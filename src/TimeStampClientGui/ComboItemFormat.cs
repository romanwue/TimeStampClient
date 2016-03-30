﻿/*
*  Copyright 2016 Disig a.s.
*
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
*/

/*
*  Written by:
*  Marek KLEIN <kleinmrk@gmail.com>
*/

using Eto.Forms;

namespace Disig.TimeStampClient.Gui
{
    internal class ComboItemFormat : IListItem
    {        
        public ComboItemFormat(string text, SharedUtils.ResultFormat format)
        {
            this.Text = text;
            this.Key = format.ToString();
            this.Format = format;
        }

        public SharedUtils.ResultFormat Format
        {
            get;
            set;
        }

        public string Key
        {
            get;
            private set;
        }

        public string Text
        {
            get;
            set;
        }

        public override string ToString()
        {
            return this.Text;
        }
    }
}