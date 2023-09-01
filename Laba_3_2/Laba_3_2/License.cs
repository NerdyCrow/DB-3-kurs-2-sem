﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;


[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]
public struct License : INullable, IBinarySerialize
{
    Int32 Id;
    String Title;
    public override string ToString()
    {
        
        return "License: " + Id + " " + Title.ToString();
    }

    public bool IsNull
    {
        get
        {
           
            return _null;
        }
    }
    public string TITLE
    {
        get { return Title; }
        set { Title = value; }
    }
    public static License Null
    {
        get
        {
            License h = new License();
            h._null = true;
            return h;
        }
    }

    public static License Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;
        License u = new License();
        string[] xy = s.Value.Split(",".ToCharArray());
        if (xy.Length > 0)
        {
            u.Id = Int32.Parse(xy[0]);
            u.Title = xy[1].ToString();
        }
        return u;
    }

    public void Read(System.IO.BinaryReader r)
    {
        int maxStringSize = 10;
        char[] chars;
        string stringValue;

        this.Id = r.ReadInt32();
        chars = r.ReadChars(maxStringSize);


        stringValue = new String(chars, 0, chars.Length);

        this.Title = stringValue;
    }

    public void Write(System.IO.BinaryWriter w)
    {
        w.Write(this.Id);

        for (int i = 0; i < this.Title.Length; i++)
        {
            w.Write(this.Title[i]);
        }
    }

    // Закрытый член
    private bool _null;
}


