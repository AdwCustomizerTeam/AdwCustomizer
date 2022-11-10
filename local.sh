#!/usr/bin/bash

# local.sh
#
# Change the look of Adwaita, with ease
# Copyright (C) 2022  Gradience Team
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.


read -p "Do you want to install Python requirements? (yes, no): " answer

#is_venv = "python -c 'import sys; print(sys.prefix == sys.base_prefix)'"

#if [[ "$is_venv" == "True" ]]; then
if [[ "$answer" == "yes" ]]; then
    pip3 install -r requirements.txt
elif [[ "$answer" == "no" ]]; then
    echo "Skipping requirements installation"
fi

echo "Cleaning builddir directory"
rm -r builddir

echo "Rebuilding"
meson builddir
meson configure builddir -Dprefix="$(pwd)/builddir" -Dbuildtype=debug
ninja -C builddir install

echo "Running"
ninja -C builddir run
