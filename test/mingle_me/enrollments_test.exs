defmodule MingleMe.EnrollmentsTest do
  use MingleMe.DataCase

  alias MingleMe.Enrollments

  describe "enrollments" do
    alias MingleMe.Enrollments.Enrollment

    import MingleMe.EnrollmentsFixtures

    @invalid_attrs %{user_id: nil, season_id: nil}

    test "list_enrollments/0 returns all enrollments" do
      enrollment = enrollment_fixture()
      assert Enrollments.list_enrollments() == [enrollment]
    end

    test "get_enrollment!/1 returns the enrollment with given id" do
      enrollment = enrollment_fixture()
      assert Enrollments.get_enrollment!(enrollment.id) == enrollment
    end

    test "create_enrollment/1 with valid data creates a enrollment" do
      valid_attrs = %{user_id: 42, season_id: 42}

      assert {:ok, %Enrollment{} = enrollment} = Enrollments.create_enrollment(valid_attrs)
      assert enrollment.user_id == 42
      assert enrollment.season_id == 42
    end

    test "create_enrollment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Enrollments.create_enrollment(@invalid_attrs)
    end

    test "update_enrollment/2 with valid data updates the enrollment" do
      enrollment = enrollment_fixture()
      update_attrs = %{user_id: 43, season_id: 43}

      assert {:ok, %Enrollment{} = enrollment} = Enrollments.update_enrollment(enrollment, update_attrs)
      assert enrollment.user_id == 43
      assert enrollment.season_id == 43
    end

    test "update_enrollment/2 with invalid data returns error changeset" do
      enrollment = enrollment_fixture()
      assert {:error, %Ecto.Changeset{}} = Enrollments.update_enrollment(enrollment, @invalid_attrs)
      assert enrollment == Enrollments.get_enrollment!(enrollment.id)
    end

    test "delete_enrollment/1 deletes the enrollment" do
      enrollment = enrollment_fixture()
      assert {:ok, %Enrollment{}} = Enrollments.delete_enrollment(enrollment)
      assert_raise Ecto.NoResultsError, fn -> Enrollments.get_enrollment!(enrollment.id) end
    end

    test "change_enrollment/1 returns a enrollment changeset" do
      enrollment = enrollment_fixture()
      assert %Ecto.Changeset{} = Enrollments.change_enrollment(enrollment)
    end
  end
end
