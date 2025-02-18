!    Copyright (C) 2006 Imperial College London and others.
!
!    Please see the AUTHORS file in the main source directory for a full list
!    of copyright holders.
!
!    Prof. C Pain
!    Applied Modelling and Computation Group
!    Department of Earth Science and Engineering
!    Imperial College London
!
!    amcgsoftware@imperial.ac.uk
!
!    This library is free software; you can redistribute it and/or
!    modify it under the terms of the GNU Lesser General Public
!    License as published by the Free Software Foundation,
!    version 2.1 of the License.
!
!    This library is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
!    Lesser General Public License for more details.
!
!    You should have received a copy of the GNU Lesser General Public
!    License along with this library; if not, write to the Free Software
!    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
!    USA

#include "fdebug.h"

subroutine calculate_diagnostic_variables_multiple(states, states_size, exclude_nonrecalculated)

  use fldebug
  use fields
  use state_module
  use diagnostic_fields_new, only : calculate_diagnostic_variables_internal => calculate_diagnostic_variables

  implicit none

  integer, intent(in) :: states_size

  type(state_type), dimension(states_size), intent(inout) :: states
  logical, intent(in) :: exclude_nonrecalculated

  call calculate_diagnostic_variables_internal(states, exclude_nonrecalculated = exclude_nonrecalculated)

end subroutine calculate_diagnostic_variables_multiple

subroutine calculate_diagnostic_variable_scalar(states, states_size, state_index, s_field, algorithm, algorithm_len, stat)

  use fldebug
  use fields
  use state_module
  use diagnostic_fields_new, only: calculate_diagnostic_variable

  implicit none

  integer, intent(in) :: states_size
  integer, intent(in) :: algorithm_len

  type(state_type), dimension(states_size), intent(inout) :: states
  integer, intent(in) :: state_index
  type(scalar_field), intent(inout) :: s_field
  character(len = algorithm_len), intent(in) :: algorithm
  integer, pointer :: stat

  integer :: lstat

  if(associated(stat)) then
    if(len_trim(algorithm) == 0) then
      call calculate_diagnostic_variable(states, state_index, s_field, stat = lstat)
    else
      call calculate_diagnostic_variable(states, state_index, s_field, algorithm = algorithm, stat = lstat)
    end if
    stat = lstat
  else
    if(len_trim(algorithm) == 0) then
      call calculate_diagnostic_variable(states, state_index, s_field)
    else
      call calculate_diagnostic_variable(states, state_index, s_field, algorithm = algorithm)
    end if
  end if

end subroutine calculate_diagnostic_variable_scalar

subroutine calculate_diagnostic_variable_vector(states, states_size, state_index, v_field, algorithm, algorithm_len, stat)

  use fldebug
  use fields
  use state_module
  use diagnostic_fields_new, only: calculate_diagnostic_variable

  implicit none

  integer, intent(in) :: states_size
  integer, intent(in) :: algorithm_len

  type(state_type), dimension(states_size), intent(inout) :: states
  integer, intent(in) :: state_index
  type(vector_field), intent(inout) :: v_field
  character(len = algorithm_len), intent(in) :: algorithm
  integer, pointer :: stat

  integer :: lstat

  if(associated(stat)) then
    if(len_trim(algorithm) == 0) then
      call calculate_diagnostic_variable(states, state_index, v_field, stat = lstat)
    else
      call calculate_diagnostic_variable(states, state_index, v_field, algorithm = algorithm, stat = lstat)
    end if
    stat = lstat
  else
    if(len_trim(algorithm) == 0) then
      call calculate_diagnostic_variable(states, state_index, v_field)
    else
      call calculate_diagnostic_variable(states, state_index, v_field, algorithm = algorithm)
    end if
  end if

end subroutine calculate_diagnostic_variable_vector

subroutine calculate_diagnostic_variable_tensor(states, states_size, state_index, t_field, algorithm, algorithm_len, stat)

  use fldebug
  use fields
  use state_module
  use diagnostic_fields_new, only: calculate_diagnostic_variable

  implicit none

  integer, intent(in) :: states_size
  integer, intent(in) :: algorithm_len

  type(state_type), dimension(states_size), intent(inout) :: states
  integer, intent(in) :: state_index
  type(tensor_field), intent(inout) :: t_field
  character(len = algorithm_len), intent(in) :: algorithm
  integer, pointer :: stat

  integer :: lstat

  if(associated(stat)) then
    if(len_trim(algorithm) == 0) then
      call calculate_diagnostic_variable(states, state_index, t_field, stat = lstat)
    else
      call calculate_diagnostic_variable(states, state_index, t_field, algorithm = algorithm, stat = lstat)
    end if
    stat = lstat
  else
    if(len_trim(algorithm) == 0) then
      call calculate_diagnostic_variable(states, state_index, t_field)
    else
      call calculate_diagnostic_variable(states, state_index, t_field, algorithm = algorithm)
    end if
  end if

end subroutine calculate_diagnostic_variable_tensor


subroutine calculate_diagnostic_variable_dep_scalar(states, states_size, state_index, s_field, algorithm, algorithm_len, dep_states_mask, stat)

  use fldebug
  use fields
  use state_module
  use diagnostic_fields_new, only: calculate_diagnostic_variable_dep

  implicit none

  integer, intent(in) :: states_size
  integer, intent(in) :: algorithm_len

  type(state_type), dimension(states_size), intent(inout) :: states
  integer, intent(in) :: state_index
  type(scalar_field), intent(inout) :: s_field
  character(len = algorithm_len), intent(in) :: algorithm
  type(state_type), dimension(:), pointer :: dep_states_mask

  integer, pointer :: stat

  integer :: lstat

  if(associated(dep_states_mask)) then
    if(associated(stat)) then
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, s_field, dep_states_mask=dep_states_mask, stat = lstat)
      else
        call calculate_diagnostic_variable_dep(states, state_index, s_field, algorithm = algorithm, dep_states_mask=dep_states_mask, stat = lstat)
      end if
      stat = lstat
    else
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, s_field, dep_states_mask=dep_states_mask)
      else
        call calculate_diagnostic_variable_dep(states, state_index, s_field, algorithm = algorithm, dep_states_mask=dep_states_mask)
      end if
    end if
  else
    if(associated(stat)) then
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, s_field, stat = lstat)
      else
        call calculate_diagnostic_variable_dep(states, state_index, s_field, algorithm = algorithm, stat = lstat)
      end if
      stat = lstat
    else
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, s_field)
      else
        call calculate_diagnostic_variable_dep(states, state_index, s_field, algorithm = algorithm)
      end if
    end if
  end if


end subroutine calculate_diagnostic_variable_dep_scalar

subroutine calculate_diagnostic_variable_dep_vector(states, states_size, state_index, v_field, algorithm, algorithm_len, dep_states_mask, stat)

  use fldebug
  use fields
  use state_module
  use diagnostic_fields_new, only: calculate_diagnostic_variable_dep

  implicit none

  integer, intent(in) :: states_size
  integer, intent(in) :: algorithm_len

  type(state_type), dimension(states_size), intent(inout) :: states
  integer, intent(in) :: state_index
  type(vector_field), intent(inout) :: v_field
  character(len = algorithm_len), intent(in) :: algorithm
  type(state_type), dimension(:), pointer :: dep_states_mask
  integer, pointer :: stat

  integer :: lstat

  if(associated(dep_states_mask)) then
    if(associated(stat)) then
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, v_field, dep_states_mask=dep_states_mask, stat = lstat)
      else
        call calculate_diagnostic_variable_dep(states, state_index, v_field, algorithm = algorithm, dep_states_mask=dep_states_mask, stat = lstat)
      end if
      stat = lstat
    else
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, v_field, dep_states_mask=dep_states_mask)
      else
        call calculate_diagnostic_variable_dep(states, state_index, v_field, algorithm = algorithm, dep_states_mask=dep_states_mask)
      end if
    end if
  else
    if(associated(stat)) then
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, v_field, stat = lstat)
      else
        call calculate_diagnostic_variable_dep(states, state_index, v_field, algorithm = algorithm, stat = lstat)
      end if
      stat = lstat
    else
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, v_field)
      else
        call calculate_diagnostic_variable_dep(states, state_index, v_field, algorithm = algorithm)
      end if
    end if
  end if

end subroutine calculate_diagnostic_variable_dep_vector

subroutine calculate_diagnostic_variable_dep_tensor(states, states_size, state_index, t_field, algorithm, algorithm_len, dep_states_mask, stat)

  use fldebug
  use fields
  use state_module
  use diagnostic_fields_new, only: calculate_diagnostic_variable_dep

  implicit none

  integer, intent(in) :: states_size
  integer, intent(in) :: algorithm_len

  type(state_type), dimension(states_size), intent(inout) :: states
  integer, intent(in) :: state_index
  type(tensor_field), intent(inout) :: t_field
  character(len = algorithm_len), intent(in) :: algorithm
  type(state_type), dimension(:), pointer :: dep_states_mask
  integer, pointer :: stat

  integer :: lstat

  if(associated(dep_states_mask)) then
    if(associated(stat)) then
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, t_field, dep_states_mask=dep_states_mask, stat = lstat)
      else
        call calculate_diagnostic_variable_dep(states, state_index, t_field, algorithm = algorithm, dep_states_mask=dep_states_mask, stat = lstat)
      end if
      stat = lstat
    else
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, t_field, dep_states_mask=dep_states_mask)
      else
        call calculate_diagnostic_variable_dep(states, state_index, t_field, algorithm = algorithm, dep_states_mask=dep_states_mask)
      end if
    end if
  else
    if(associated(stat)) then
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, t_field, stat = lstat)
      else
        call calculate_diagnostic_variable_dep(states, state_index, t_field, algorithm = algorithm, stat = lstat)
      end if
      stat = lstat
    else
      if(len_trim(algorithm) == 0) then
        call calculate_diagnostic_variable_dep(states, state_index, t_field)
      else
        call calculate_diagnostic_variable_dep(states, state_index, t_field, algorithm = algorithm)
      end if
    end if
  end if

end subroutine calculate_diagnostic_variable_dep_tensor
