defmodule Opencov.JobControllerTest do
  use Opencov.ConnCase

  alias Opencov.Job
  @build_attrs %{coverage: 50.4, project_id: 42, build_number: 1}

  @valid_attrs %{job_number: 42}
  @invalid_attrs %{build_id: nil}

  setup do
    conn = conn()
    build = Opencov.Repo.insert! Opencov.Build.changeset(%Opencov.Build{}, @build_attrs)
    valid_attrs = Dict.put(@valid_attrs, :build_id, build.id)
    {:ok, conn: conn, build: build, valid_attrs: valid_attrs}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, job_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing jobs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, job_path(conn, :new)
    assert html_response(conn, 200) =~ "New job"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, valid_attrs: valid_attrs} do
    conn = post conn, job_path(conn, :create), job: valid_attrs
    assert redirected_to(conn) == job_path(conn, :index)
    assert Repo.get_by(Job, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, job_path(conn, :create), job: @invalid_attrs
    assert html_response(conn, 200) =~ "New job"
  end

  test "shows chosen resource", %{conn: conn, valid_attrs: valid_attrs} do
    job = Repo.insert! Job.changeset(%Job{}, valid_attrs)
    conn = get conn, job_path(conn, :show, job)
    assert html_response(conn, 200) =~ "Show job"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, job_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, valid_attrs: valid_attrs} do
    job = Repo.insert! Job.changeset(%Job{}, valid_attrs)
    conn = get conn, job_path(conn, :edit, job)
    assert html_response(conn, 200) =~ "Edit job"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, valid_attrs: valid_attrs} do
    job = Repo.insert! Job.changeset(%Job{}, valid_attrs)
    conn = put conn, job_path(conn, :update, job), job: valid_attrs
    assert redirected_to(conn) == job_path(conn, :show, job)
    assert Repo.get_by(Job, valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, valid_attrs: valid_attrs} do
    job = Repo.insert! Job.changeset(%Job{}, valid_attrs)
    conn = put conn, job_path(conn, :update, job), job: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit job"
  end

  test "deletes chosen resource", %{conn: conn, valid_attrs: valid_attrs} do
    job = Repo.insert! Job.changeset(%Job{}, valid_attrs)
    conn = delete conn, job_path(conn, :delete, job)
    assert redirected_to(conn) == job_path(conn, :index)
    refute Repo.get(Job, job.id)
  end
end