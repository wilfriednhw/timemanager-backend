defmodule Moodle.ApicontextTest do
  use Moodle.DataCase

  alias Moodle.Apicontext

  describe "users" do
    alias Moodle.Apicontext.User

    import Moodle.ApicontextFixtures

    @invalid_attrs %{email: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Apicontext.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Apicontext.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", username: "some username"}

      assert {:ok, %User{} = user} = Apicontext.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apicontext.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", username: "some updated username"}

      assert {:ok, %User{} = user} = Apicontext.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Apicontext.update_user(user, @invalid_attrs)
      assert user == Apicontext.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Apicontext.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Apicontext.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Apicontext.change_user(user)
    end
  end

  describe "clock" do
    alias Moodle.Apicontext.Clock

    import Moodle.ApicontextFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clock/0 returns all clock" do
      clock = clock_fixture()
      assert Apicontext.list_clock() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Apicontext.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2021-10-25 12:17:00]}

      assert {:ok, %Clock{} = clock} = Apicontext.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2021-10-25 12:17:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apicontext.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2021-10-26 12:17:00]}

      assert {:ok, %Clock{} = clock} = Apicontext.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2021-10-26 12:17:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Apicontext.update_clock(clock, @invalid_attrs)
      assert clock == Apicontext.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Apicontext.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Apicontext.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Apicontext.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias Moodle.Apicontext.Workingtime

    import Moodle.ApicontextFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Apicontext.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Apicontext.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      valid_attrs = %{end: ~N[2021-10-25 12:29:00], start: ~N[2021-10-25 12:29:00]}

      assert {:ok, %Workingtime{} = workingtime} = Apicontext.create_workingtime(valid_attrs)
      assert workingtime.end == ~N[2021-10-25 12:29:00]
      assert workingtime.start == ~N[2021-10-25 12:29:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apicontext.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      update_attrs = %{end: ~N[2021-10-26 12:29:00], start: ~N[2021-10-26 12:29:00]}

      assert {:ok, %Workingtime{} = workingtime} = Apicontext.update_workingtime(workingtime, update_attrs)
      assert workingtime.end == ~N[2021-10-26 12:29:00]
      assert workingtime.start == ~N[2021-10-26 12:29:00]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Apicontext.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Apicontext.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Apicontext.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Apicontext.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Apicontext.change_workingtime(workingtime)
    end
  end

  describe "groups" do
    alias Moodle.Apicontext.Group

    import Moodle.ApicontextFixtures

    @invalid_attrs %{name: nil}

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Apicontext.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Apicontext.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Group{} = group} = Apicontext.create_group(valid_attrs)
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apicontext.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Group{} = group} = Apicontext.update_group(group, update_attrs)
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Apicontext.update_group(group, @invalid_attrs)
      assert group == Apicontext.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Apicontext.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Apicontext.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Apicontext.change_group(group)
    end
  end
end
