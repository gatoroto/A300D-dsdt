/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20100528
 *
 * Disassembly of dsdt.dat, Thu Jan 17 00:01:10 2013
 *
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000D1FD (53757)
 *     Revision         0x01 **** ACPI 1.0, no 64-bit math support
 *     Checksum         0xA7
 *     OEM ID           "TOSQCI"
 *     OEM Table ID     "TOSQCI00"
 *     OEM Revision     0x06040000 (100925440)
 *     Compiler ID      "MSFT"
 *     Compiler Version 0x03000000 (50331648)
 */
DefinitionBlock ("dsdt.aml", "DSDT", 1, "TOSQCI", "TOSQCI00", 0x06040000)
{
    External (Z00D)
    External (\_PR_.CPU1._PPC)
    External (\_PR_.CPU0._PPC)

    Name (Z000, 0x01)
    Name (Z001, 0x02)
    Name (Z002, 0x04)
    Name (Z003, 0x08)
    Name (Z004, 0x00)
    Name (Z005, 0x0F)
    Name (Z006, 0x0D)
    Name (Z007, 0x0B)
    Name (Z008, 0x09)
    Method (VTOB, 1, NotSerialized)
    {
        Store (0x01, Local0)
        ShiftLeft (Local0, Arg0, Local0)
        Return (Local0)
    }

    Method (BTOV, 1, NotSerialized)
    {
        ShiftRight (Arg0, 0x01, Local0)
        Store (0x00, Local1)
        While (Local0)
        {
            Increment (Local1)
            ShiftRight (Local0, 0x01, Local0)
        }

        Return (Local1)
    }

    Method (MKWD, 2, NotSerialized)
    {
        If (And (Arg1, 0x80))
        {
            Store (0xFFFF0000, Local0)
        }
        Else
        {
            Store (Zero, Local0)
        }

        Or (Local0, Arg0, Local0)
        Or (Local0, ShiftLeft (Arg1, 0x08), Local0)
        Return (Local0)
    }

    Method (POSW, 1, NotSerialized)
    {
        If (And (Arg0, 0x8000))
        {
            If (LEqual (Arg0, 0xFFFF))
            {
                Return (0xFFFFFFFF)
            }
            Else
            {
                Not (Arg0, Local0)
                Increment (Local0)
                And (Local0, 0xFFFF, Local0)
                Return (Local0)
            }
        }
        Else
        {
            Return (Arg0)
        }
    }

    Method (GBFE, 3, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, TIDX)
        Store (TIDX, Arg2)
    }

    Method (PBFE, 3, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, TIDX)
        Store (Arg2, TIDX)
    }

    Method (ITOS, 1, NotSerialized)
    {
        Store (Buffer (0x09)
            {
                /* 0000 */    0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                /* 0008 */    0x00
            }, Local0)
        Store (Buffer (0x11)
            {
                "0123456789ABCDEF"
            }, Local7)
        Store (0x08, Local1)
        Store (0x00, Local2)
        Store (0x00, Local3)
        While (Local1)
        {
            Decrement (Local1)
            And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0F, Local4)
            If (Local4)
            {
                Store (Ones, Local3)
            }

            If (Local3)
            {
                GBFE (Local7, Local4, RefOf (Local5))
                PBFE (Local0, Local2, Local5)
                Increment (Local2)
            }
        }

        Return (Local0)
    }

    OperationRegion (NV1, SystemIO, 0x72, 0x02)
    Field (NV1, ByteAcc, NoLock, Preserve)
    {
        INDX,   8, 
        DATA,   8
    }

    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
    {
                Offset (0xA0), 
        TMOD,   1, 
                Offset (0xDE), 
        INS4,   1
    }

    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
        Processor (CPU1, 0x01, 0x00000000, 0x00) {}
    }

    Name (_S0, Package (0x04)
    {
        0x00, 
        0x00, 
        0x00, 
        0x00
    })
    Name (_S3, Package (0x04)
    {
        0x03, 
        0x03, 
        0x00, 
        0x00
    })
    Name (_S4, Package (0x04)
    {
        0x04, 
        0x04, 
        0x00, 
        0x00
    })
    Name (_S5, Package (0x04)
    {
        0x05, 
        0x05, 
        0x00, 
        0x00
    })
    OperationRegion (\DEB2, SystemIO, 0x80, 0x02)
    Field (\DEB2, WordAcc, NoLock, Preserve)
    {
        P80H,   16
    }

    OperationRegion (\PMIO, SystemIO, 0x0CD6, 0x02)
    Field (\PMIO, ByteAcc, NoLock, Preserve)
    {
        PIDX,   8, 
        PDAT,   8
    }

    OperationRegion (\P01, SystemIO, 0x8001, 0x01)
    Field (\P01, ByteAcc, NoLock, Preserve)
    {
        PST1,   8
    }

    Name (HTTX, 0x00)
    Method (_PTS, 1, NotSerialized)
    {
        If (LLessEqual (\_SB.PCI0.SMB.RVID, 0x13))
        {
            Store (Zero, \_SB.PCI0.SMB.PWDE)
        }

        If (LEqual (Arg0, 0x05))
        {
            Store (One, \_SB.PCI0.SMB.SLPS)
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (One, \_SB.PCI0.SMB.SLPS)
            Store (0x01, INS4)
            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
            Store (0x01, \_SB.PCI0.LPC0.EC0.FLS4)
            If (\_SB.SSTS)
            {
                Store (Zero, \_SB.PCI0.LPC0.EC0.WLID)
            }
            Else
            {
                Store (One, \_SB.PCI0.LPC0.EC0.WLID)
            }

            Release (\_SB.PCI0.LPC0.EC0.MUT1)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (Zero, \_SB.PCI0.SMB.RSTU)
            Store (One, \_SB.PCI0.SMB.SLPS)
            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
            If (\_SB.SSTS)
            {
                Store (Zero, \_SB.PCI0.LPC0.EC0.WLID)
            }
            Else
            {
                Store (One, \_SB.PCI0.LPC0.EC0.WLID)
            }

            Release (\_SB.PCI0.LPC0.EC0.MUT1)
        }

        Store (0x8F, \_SB.PCI0.LPC0.BCMD)
        Store (Zero, \_SB.PCI0.LPC0.SMIC)
    }

    Method (_WAK, 1, NotSerialized)
    {
        If (LEqual (\_SB.TPOS, 0x40)) {}
        If (LEqual (\_SB.TPOS, 0x80))
        {
            Store (One, \_SB.PCI0.SMB.MT3A)
        }

        Store (\_SB.PCI0.SMB.PEWS, \_SB.PCI0.SMB.PEWS)
        Store (One, \_SB.PCI0.SMB.HECO)
        Store (0x81, \_SB.PCI0.LPC0.BCMD)
        Store (Zero, \_SB.PCI0.LPC0.SMIC)
        If (Arg0)
        {
            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
            And (\_SB.PCI0.LPC0.EC0.DALB, 0x03, Local0)
            Store (Local0, \_SB.PCI0.LPC0.EC0.MBEV)
            Release (\_SB.PCI0.LPC0.EC0.MUT1)
            If (\_SB.PCI0.SATA.PSS1)
            {
                Notify (\_SB.PCI0.SATA.PRT2, 0x01)
                Store (One, \_SB.PCI0.SATA.PRC2)
            }
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (0x55, \_SB.INS3)
            Store (One, \_SB.PCI0.SMB.RSTU)
            Store (One, \_SB.PCI0.SMB.IR9S)
            Store (One, \_SB.PCI0.SMB.IR9E)
            Store (0x61, PIDX)
            Store (PDAT, Local0)
            And (Local0, 0x80, Local0)
            If (LEqual (Local0, 0x00))
            {
                Notify (\_SB.PWRB, 0x02)
            }

            If (LLess (\_SB.TPOS, 0x40))
            {
                If (\_SB.PCI0.SATA.PSS1)
                {
                    If (\_SB.PCI0.SATA.PSER)
                    {
                        \_SB.PCI0.LPC0.EC0.CPOL (0x03)
                    }
                }
            }
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x55, \_SB.INS3)
            Store (0x00, INS4)
            If (GPIC)
            {
                \_SB.PCI0.LPC0.DSPI ()
            }

            If (LNotEqual (\_SB.PCI0.SMB.GPO4, 0x01))
            {
                Notify (\_SB.PWRB, 0x02)
            }

            If (\_SB.PCI0.LPC0.FGPE)
            {
                Notify (\_SB.PCI0.OHC1, 0x00)
            }

            If (LLess (\_SB.TPOS, 0x40))
            {
                If (\_SB.PCI0.SATA.PSS1)
                {
                    \_SB.PCI0.LPC0.EC0.CPOL (0x05)
                }
            }
        }

        If (LEqual (Arg0, 0x01))
        {
            Store (One, \_SB.PCI0.SMB.IR9S)
            Store (One, \_SB.PCI0.SMB.IR9E)
            And (PST1, 0x04, Local0)
            If (LEqual (Local0, 0x00))
            {
                Notify (\_SB.PWRB, 0x02)
            }
        }

        \_SB.BAT1.BSTA ()
        If (\_SB.BAT1.BTIN)
        {
            \_SB.BAT1.UBIF ()
            Notify (\_SB.BAT1, 0x81)
        }

        Notify (\_SB.PCI0.PB7, 0x00)
        Notify (\_SB.PCI0, 0x00)
        Store (\_SB.PCI0.LPC0.BTEN, \_SB.PCI0.LPC0.EC0.BLTH)
        Store (\_SB.PCI0.LPC0.WLAN, \_SB.PCI0.LPC0.EC0.WLAN)
        Store (0x01, \_SB.PCI0.LPC0.EC0.CPLE)
	Return(Package(0x02){0x00, 0x00})
    }

    Scope (\_SI)
    {
        Method (_SST, 1, NotSerialized)
        {
            If (LEqual (Arg0, 0x01))
            {
                Store ("===== SST Working =====", Debug)
            }

            If (LEqual (Arg0, 0x02))
            {
                Store ("===== SST Waking =====", Debug)
            }

            If (LEqual (Arg0, 0x03))
            {
                Store ("===== SST Sleeping =====", Debug)
            }

            If (LEqual (Arg0, 0x04))
            {
                Store ("===== SST Sleeping S4 =====", Debug)
            }
        }
    }

    Scope (\_SB)
    {
        Name (LINX, 0x00)
        Name (OSSP, 0x00)
        Name (OSTB, Ones)
        OperationRegion (OSTY, SystemMemory, 0xCDEDDBBC, 0x00000001)
        Field (OSTY, AnyAcc, NoLock, Preserve)
        {
            TPOS,   8
        }

        Method (OSTP, 0, NotSerialized)
        {
            If (LEqual (^OSTB, Ones))
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    Store (0x00, ^OSTB)
                    Store (0x00, ^TPOS)
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x08, ^OSTB)
                        Store (0x08, ^TPOS)
                    }

                    If (\_OSI ("Windows 2001.1"))
                    {
                        Store (0x20, ^OSTB)
                        Store (0x20, ^TPOS)
                    }

                    If (\_OSI ("Windows 2001 SP1"))
                    {
                        Store (0x10, ^OSTB)
                        Store (0x10, ^TPOS)
                    }

                    If (\_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x11, ^OSTB)
                        Store (0x11, ^TPOS)
                    }

                    If (\_OSI ("Windows 2001 SP3"))
                    {
                        Store (0x12, ^OSTB)
                        Store (0x12, ^TPOS)
                    }

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Windows 2006 SP1"))
                    {
                        Store (0x01, OSSP)
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
                        Store (0x80, ^OSTB)
                        Store (0x80, ^TPOS)
                    }
                }
                Else
                {
                    If (CondRefOf (\_OS, Local0))
                    {
                        If (^SEQL (\_OS, "Microsoft Windows"))
                        {
                            Store (0x01, ^OSTB)
                            Store (0x01, ^TPOS)
                        }
                        Else
                        {
                            If (^SEQL (\_OS, "Microsoft WindowsME: Millennium Edition"))
                            {
                                Store (0x02, ^OSTB)
                                Store (0x02, ^TPOS)
                            }
                            Else
                            {
                                If (^SEQL (\_OS, "Microsoft Windows NT"))
                                {
                                    Store (0x04, ^OSTB)
                                    Store (0x04, ^TPOS)
                                }
                                Else
                                {
                                    Store (0x00, ^OSTB)
                                    Store (0x00, ^TPOS)
                                }
                            }
                        }
                    }
                    Else
                    {
                        Store (0x00, ^OSTB)
                        Store (0x00, ^TPOS)
                    }
                }

                Store (0xB0, \_SB.PCI0.LPC0.BCMD)
                Store (Zero, \_SB.PCI0.LPC0.SMIC)
                If (LEqual (TPOS, 0x80))
                {
                    Store (One, \_SB.PCI0.SMB.MT3A)
                }
            }

            Return (^OSTB)
        }

        Method (OSHT, 0, NotSerialized)
        {
            \_SB.OSTP ()
            Store (0x48, \_SB.PCI0.LPC0.BCMD)
            Store (Zero, \_SB.PCI0.LPC0.SMIC)
        }

        Method (SEQL, 2, Serialized)
        {
            Store (SizeOf (Arg0), Local0)
            Store (SizeOf (Arg1), Local1)
            If (LNotEqual (Local0, Local1))
            {
                Return (Zero)
            }

            Name (BUF0, Buffer (Local0) {})
            Store (Arg0, BUF0)
            Name (BUF1, Buffer (Local0) {})
            Store (Arg1, BUF1)
            Store (Zero, Local2)
            While (LLess (Local2, Local0))
            {
                Store (DerefOf (Index (BUF0, Local2)), Local3)
                Store (DerefOf (Index (BUF1, Local2)), Local4)
                If (LNotEqual (Local3, Local4))
                {
                    Return (Zero)
                }

                Increment (Local2)
            }

            Return (One)
        }
    }

    Name (\GPIC, 0x00)
    Method (\_PIC, 1, NotSerialized)
    {
        Store (Arg0, GPIC)
        If (Arg0)
        {
            \_SB.PCI0.LPC0.DSPI ()
        }
    }

    Scope (\_SB)
    {
        Scope (\_SB)
        {
            Device (QWMI)
            {
                Name (_HID, "PNP0C14")
                Name (_UID, 0x01)
                Method (PHSR, 2, NotSerialized)
                {
                    Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                    Store (0x9E, \_SB.PCI0.LPC0.BCMD)
                    Store (Arg0, \_SB.PCI0.LPC0.DID)
                    Store (Arg1, \_SB.PCI0.LPC0.INF)
                    Store (Zero, \_SB.PCI0.LPC0.SMIC)
                    Store (\_SB.PCI0.LPC0.DID, Local0)
                    Release (\_SB.PCI0.LPC0.PSMX)
                    Return (Local0)
                }

                Name (_WDG, Buffer (0x3C)
                {
                    /* 0000 */    0x69, 0xA4, 0x2B, 0xC6, 0x2C, 0x69, 0x4C, 0x4A, 
                    /* 0008 */    0x98, 0x69, 0x31, 0xB8, 0x3E, 0x0C, 0x76, 0x71, 
                    /* 0010 */    0x41, 0x41, 0x01, 0x00, 0x76, 0xF0, 0x58, 0x15, 
                    /* 0018 */    0x69, 0x3C, 0xDB, 0x4C, 0x80, 0xA5, 0xD2, 0xF3, 
                    /* 0020 */    0x9C, 0x62, 0x94, 0x9B, 0x41, 0x42, 0x01, 0x00, 
                    /* 0028 */    0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11, 
                    /* 0030 */    0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10, 
                    /* 0038 */    0x42, 0x41, 0x01, 0x00
                })
                Name (FCOD, 0x00)
                Name (RCOD, 0x00)
                Name (SFAI, 0x00)
                Name (SFLG, 0x00)
                Name (UFAI, 0x00)
                Name (UFLG, 0x00)
                Name (VERB, Buffer (0x0201)
                {
                    0x00
                })
                CreateField (VERB, 0x00, 0x08, QMJV)
                CreateField (VERB, 0x08, 0x08, QMNV)
                Name (FBUF, Buffer (0x0201)
                {
                    0x00
                })
                CreateField (FBUF, 0x00, 0x08, F000)
                CreateField (FBUF, 0x08, 0x08, F001)
                Name (RBUF, Buffer (0x0201)
                {
                    0x00
                })
                Name (QBUF, Buffer (0x0201)
                {
                    0x00
                })
                CreateField (QBUF, 0x00, 0x08, Q000)
                CreateField (QBUF, 0x08, 0x08, Q001)
                CreateField (QBUF, 0x10, 0x08, Q002)
                CreateField (QBUF, 0x18, 0x08, Q003)
                CreateField (QBUF, 0x20, 0x08, Q004)
                CreateField (QBUF, 0x28, 0x08, Q005)
                CreateField (QBUF, 0x30, 0x08, Q006)
                CreateField (QBUF, 0x38, 0x08, Q007)
                CreateField (QBUF, 0x40, 0x08, Q008)
                CreateField (QBUF, 0x48, 0x08, Q009)
                CreateField (QBUF, 0x50, 0x08, Q010)
                CreateField (QBUF, 0x58, 0x08, Q011)
                CreateField (QBUF, 0x60, 0x08, Q012)
                CreateField (QBUF, 0x68, 0x08, Q013)
                CreateField (QBUF, 0x70, 0x08, Q014)
                CreateField (QBUF, 0x78, 0x08, Q015)
                CreateField (QBUF, 0x80, 0x08, Q016)
                CreateField (QBUF, 0x88, 0x08, Q017)
                CreateField (QBUF, 0x00, 0xA0, QL20)
                CreateField (QBUF, 0x00, 0x1000, Q512)
                CreateField (QBUF, 0x1000, 0x08, QZZZ)
                Method (WQAA, 1, NotSerialized)
                {
                    Store (0x01, QMJV)
                    Store (0x01, QMNV)
                    Return (VERB)
                }

                Method (WSAA, 2, NotSerialized)
                {
                    Store (Arg1, FBUF)
                    Store (F000, FCOD)
                    Store (F001, RCOD)
                    If (LEqual (RCOD, 0x01))
                    {
                        RQ01 (Arg0)
                    }

                    If (LEqual (RCOD, 0x02))
                    {
                        RQ02 (Arg0)
                    }

                    If (LEqual (RCOD, 0x03))
                    {
                        RQ03 (Arg0)
                    }

                    If (LEqual (RCOD, 0x04))
                    {
                        RQ04 (Arg0)
                    }

                    If (LEqual (RCOD, 0x05))
                    {
                        RQ05 (Arg0)
                    }

                    If (LEqual (RCOD, 0x06))
                    {
                        RQ06 (Arg0)
                    }

                    If (LEqual (RCOD, 0x07))
                    {
                        RQ07 (Arg0)
                    }

                    If (LEqual (RCOD, 0x08))
                    {
                        RQ08 (Arg0)
                    }

                    If (LEqual (RCOD, 0x09))
                    {
                        RQ09 (Arg0)
                    }

                    If (LEqual (RCOD, 0x0A))
                    {
                        RQ0A (Arg0)
                    }

                    If (LEqual (RCOD, 0x0B))
                    {
                        RQ0B (Arg0)
                    }

                    If (LEqual (RCOD, 0x0C))
                    {
                        RQ0C (Arg0)
                    }

                    If (LEqual (RCOD, 0x0D))
                    {
                        RQ0D (Arg0)
                    }

                    If (LEqual (RCOD, 0x0E))
                    {
                        RQ0E (Arg0)
                    }

                    If (LEqual (RCOD, 0x0F))
                    {
                        RQ0F (Arg0)
                    }

                    If (LEqual (RCOD, 0x10))
                    {
                        RQ10 (Arg0)
                    }

                    If (LEqual (RCOD, 0x11))
                    {
                        RQ11 (Arg0)
                    }

                    If (LEqual (RCOD, 0x12))
                    {
                        RQ12 (Arg0)
                    }

                    If (LEqual (RCOD, 0x13))
                    {
                        RQ13 (Arg0)
                    }

                    Store (QBUF, RBUF)
                }

                Method (WQAB, 1, NotSerialized)
                {
                    Return (RBUF)
                }

                Method (WSAB, 2, NotSerialized)
                {
                    If (LEqual (RCOD, 0x01))
                    {
                        RS01 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x02))
                    {
                        RS02 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x03))
                    {
                        RS03 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x04))
                    {
                        RS04 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x05))
                    {
                        RS05 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x06))
                    {
                        RS06 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x07))
                    {
                        RS07 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x08))
                    {
                        RS08 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x09))
                    {
                        RS09 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x0A))
                    {
                        RS0A (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x0B))
                    {
                        RS0B (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x0C))
                    {
                        RS0C (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x0D))
                    {
                        RS0D (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x0E))
                    {
                        RS0E (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x0F))
                    {
                        RS0F (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x10))
                    {
                        RS10 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x11))
                    {
                        RS11 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x12))
                    {
                        RS12 (Arg0, Arg1)
                    }

                    If (LEqual (RCOD, 0x13))
                    {
                        RS13 (Arg0, Arg1)
                    }

                    Store (QBUF, RBUF)
                }

                Method (RQ01, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x02))
                    {
                        \_SB.QWMI.PHSR (0x01, 0x00)
                        Store (\_SB.PCI0.LPC0.OWNS, Q512)
                    }

                    If (LEqual (FCOD, 0x05))
                    {
                        Store (SFAI, Q000)
                    }

                    If (LEqual (FCOD, 0x04))
                    {
                        If (LEqual (SFLG, 0x00))
                        {
                            Store (0x01, Q000)
                        }
                        Else
                        {
                            Store (0x00, Q000)
                        }
                    }
                }

                Method (RS01, 2, NotSerialized)
                {
                    Store (Arg1, Q512)
                    Store (Q512, \_SB.PCI0.LPC0.OWNS)
                    If (LEqual (FCOD, 0x04))
                    {
                        Store (0x00, SFLG)
                        \_SB.QWMI.PHSR (0x01, 0x04)
                        Store (\_SB.PCI0.LPC0.OWNS, Q512)
                        Store (Q000, SFLG)
                        If (LEqual (SFLG, 0x00))
                        {
                            Store (0x01, Q000)
                        }
                        Else
                        {
                            Store (0x00, Q000)
                        }
                    }

                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x01, 0x02)
                    }

                    If (LEqual (FCOD, 0x03))
                    {
                        \_SB.QWMI.PHSR (0x01, 0x03)
                    }

                    If (LEqual (FCOD, 0x05))
                    {
                        Store (\_SB.PCI0.LPC0.OWNS, Q512)
                        Store (Q000, SFAI)
                    }
                }

                Method (RQ02, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x02))
                    {
                        \_SB.QWMI.PHSR (0x02, 0x00)
                        Store (\_SB.PCI0.LPC0.OWNS, Q512)
                    }

                    If (LEqual (FCOD, 0x05))
                    {
                        Store (UFAI, Q000)
                    }

                    If (LEqual (FCOD, 0x04))
                    {
                        If (LEqual (UFLG, 0x00))
                        {
                            Store (0x01, Q000)
                        }
                        Else
                        {
                            Store (0x00, Q000)
                        }
                    }
                }

                Method (RS02, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    If (LEqual (FCOD, 0x04))
                    {
                        Store (0x00, UFLG)
                        \_SB.QWMI.PHSR (0x02, 0x04)
                        Store (\_SB.PCI0.LPC0.OWNS, Q512)
                        Store (Q000, UFLG)
                    }

                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x02, 0x02)
                    }

                    If (LEqual (FCOD, 0x03))
                    {
                        \_SB.QWMI.PHSR (0x02, 0x03)
                    }

                    If (LEqual (FCOD, 0x05))
                    {
                        Store (\_SB.PCI0.LPC0.OWNS, Q512)
                        Store (Q000, UFAI)
                    }
                }

                Method (RQ03, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x03, 0x02)
                    }
                    Else
                    {
                        \_SB.QWMI.PHSR (0x03, 0x00)
                    }

                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS03, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x03, 0x01)
                }

                Method (RQ04, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x04, 0x02)
                    }
                    Else
                    {
                        \_SB.QWMI.PHSR (0x04, 0x00)
                    }

                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS04, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x04, 0x01)
                }

                Method (RQ05, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x05, 0x02)
                    }
                    Else
                    {
                        \_SB.QWMI.PHSR (0x05, 0x00)
                    }

                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS05, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x05, 0x01)
                }

                Method (RQ06, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x06, 0x02)
                    }
                    Else
                    {
                        \_SB.QWMI.PHSR (0x06, 0x00)
                    }

                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS06, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x06, 0x01)
                }

                Method (RQ07, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x07, 0x02)
                    }
                    Else
                    {
                        \_SB.QWMI.PHSR (0x07, 0x00)
                    }

                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS07, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x07, 0x01)
                }

                Method (RQ08, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x08, 0x02)
                    }
                    Else
                    {
                        \_SB.QWMI.PHSR (0x08, 0x00)
                    }

                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS08, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x08, 0x01)
                }

                Method (RQ09, 1, NotSerialized)
                {
                    \_SB.QWMI.PHSR (0x00, 0x00)
                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                    Store (0x00, QZZZ)
                }

                Method (RS09, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x00, 0x01)
                }

                Method (RQ0A, 1, NotSerialized)
                {
                    \_SB.QWMI.PHSR (0x09, 0x00)
                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS0A, 2, NotSerialized)
                {
                }

                Method (RQ0B, 1, NotSerialized)
                {
                    \_SB.QWMI.PHSR (0x0A, 0x00)
                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS0B, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x0A, 0x01)
                }

                Method (RQ0C, 1, NotSerialized)
                {
                    \_SB.QWMI.PHSR (0x0B, 0x00)
                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS0C, 2, NotSerialized)
                {
                }

                Method (RQ0D, 1, NotSerialized)
                {
                }

                Method (RS0D, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x0C, 0x01)
                }

                Method (RQ0E, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x06))
                    {
                        Store (0x00, Q000)
                        Store (0x00, Q001)
                        Store (0x00, Q002)
                        Store (0x00, Q003)
                        Store (0x01, Q004)
                        Store (\_SB.PCI0.LPC0.WLAN, Q005)
                        Store (0x00, Q006)
                        Store (0x01, Q007)
                        Store (0x01, Q008)
                        Store (\_SB.PCI0.LPC0.BTEN, Q009)
                        Store (0x01, Q010)
                        Store (0x01, Q011)
                        Store (0x00, Q012)
                        Store (0x00, Q014)
                        Store (0x01, Q015)
                        Store (0x00, Q016)
                        Store (0x00, Q017)
                    }

                    If (LEqual (FCOD, 0x02))
                    {
                        \_SB.QWMI.PHSR (0x0D, 0x00)
                        Store (\_SB.PCI0.LPC0.OWNS, Q512)
                    }
                }

                Method (RS0E, 2, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                        \_SB.QWMI.PHSR (0x0D, 0x01)
                    }
                }

                Method (RQ0F, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x06))
                    {
                        Store (0x01, Q000)
                        Store (0x01, Q001)
                        Store (0x01, Q002)
                        Store (0x01, Q003)
                        Store (0x00, Q004)
                        Store (0x01, Q005)
                    }
                }

                Method (RS0F, 2, NotSerialized)
                {
                }

                Method (RQ10, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x0E, 0x02)
                    }
                    Else
                    {
                        \_SB.QWMI.PHSR (0x0E, 0x00)
                    }

                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS10, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x0E, 0x01)
                }

                Method (RQ11, 1, NotSerialized)
                {
                    If (LEqual (FCOD, 0x01))
                    {
                        \_SB.QWMI.PHSR (0x0F, 0x02)
                    }
                    Else
                    {
                        \_SB.QWMI.PHSR (0x0F, 0x00)
                    }

                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                }

                Method (RS11, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x0F, 0x01)
                }

                Method (RQ12, 1, NotSerialized)
                {
                    \_SB.QWMI.PHSR (0x10, 0x00)
                    Store (\_SB.PCI0.LPC0.OWNS, Q512)
                    If (LEqual (\_SB.PCI0.LPC0.OWN1, 0x01))
                    {
                        Store (0x06, Q002)
                    }
                    Else
                    {
                        Store (0x00, Q002)
                        If (LEqual (\_SB.PCI0.SMB.LDET, 0x00))
                        {
                            Store (0x06, Q002)
                        }
                    }

                    Store (0x00, Q003)
                    If (LEqual (\_SB.PCI0.SMB.MID3, 0x01))
                    {
                        Store (0x01, Q003)
                    }

                    Store (0x00, Q005)
                    If (LEqual (\_SB.PCI0.LPC0.HDME, 0x01))
                    {
                        Store (0x01, Q005)
                    }

                    Store (0x00, Q006)
                    If (LEqual (\_SB.PCI0.SMB.FMDT, 0x00))
                    {
                        Store (0x01, Q006)
                    }

                    Store (\_SB.PCI0.LPC0.TPDV, Q004)
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (0x00, Q007)
                    If (LEqual (\_SB.PCI0.LPC0.EC0.CIRF, 0x01))
                    {
                        Store (0x01, Q007)
                    }

                    Store (\_SB.PCI0.LPC0.EC0.PLID, Q008)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                }

                Method (RS12, 2, NotSerialized)
                {
                    Store (Arg1, \_SB.PCI0.LPC0.OWNS)
                    \_SB.QWMI.PHSR (0x10, 0x01)
                }

                Method (RQ13, 1, NotSerialized)
                {
                    Store (\_SB.PCI0.LPC0.DVDI, QL20)
                }

                Method (RS13, 2, NotSerialized)
                {
                }

                Name (WQBA, Buffer (0x02C0)
                {
                    /* 0000 */    0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00, 
                    /* 0008 */    0xB0, 0x02, 0x00, 0x00, 0xC0, 0x08, 0x00, 0x00, 
                    /* 0010 */    0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54, 
                    /* 0018 */    0x28, 0x5F, 0x84, 0x00, 0x01, 0x06, 0x18, 0x42, 
                    /* 0020 */    0x10, 0x05, 0x10, 0x92, 0x28, 0x81, 0x42, 0x04, 
                    /* 0028 */    0x12, 0x4F, 0x24, 0x51, 0x30, 0x28, 0x0D, 0x20, 
                    /* 0030 */    0x92, 0x04, 0x21, 0x17, 0x4C, 0x4C, 0x80, 0x10, 
                    /* 0038 */    0x58, 0x0B, 0x30, 0x2F, 0x40, 0xB7, 0x00, 0xC3, 
                    /* 0040 */    0x02, 0x6C, 0x0B, 0x30, 0x2D, 0xC0, 0x31, 0x90, 
                    /* 0048 */    0xFA, 0xF7, 0x87, 0x28, 0x0D, 0x44, 0x9B, 0x10, 
                    /* 0050 */    0x01, 0x91, 0x02, 0x21, 0xA1, 0x02, 0x94, 0x0B, 
                    /* 0058 */    0xF0, 0x2D, 0x40, 0x3B, 0xA2, 0x24, 0x0B, 0xB0, 
                    /* 0060 */    0x0C, 0x23, 0x02, 0x7B, 0x15, 0x60, 0x53, 0x80, 
                    /* 0068 */    0x49, 0x34, 0x04, 0x41, 0x39, 0xC3, 0x40, 0xC1, 
                    /* 0070 */    0x1B, 0x90, 0x0D, 0x82, 0xC9, 0x1D, 0x04, 0x4A, 
                    /* 0078 */    0xCC, 0x68, 0xC8, 0x0C, 0x3A, 0x9F, 0x8B, 0xE0, 
                    /* 0080 */    0x4F, 0xA2, 0x70, 0x01, 0xD2, 0x31, 0x34, 0x82, 
                    /* 0088 */    0x23, 0x4A, 0xD0, 0xA3, 0x00, 0xD9, 0x28, 0x52, 
                    /* 0090 */    0x3C, 0x27, 0x81, 0x14, 0x24, 0xC0, 0x21, 0x16, 
                    /* 0098 */    0xC1, 0x3B, 0x11, 0x03, 0x79, 0x0E, 0x71, 0x3C, 
                    /* 00A0 */    0x20, 0x6B, 0x46, 0x14, 0x7E, 0x94, 0x04, 0x46, 
                    /* 00A8 */    0x3B, 0x0E, 0x8C, 0x8C, 0x11, 0x10, 0xAB, 0xA8, 
                    /* 00B0 */    0x9A, 0x48, 0x02, 0xBB, 0x1F, 0x81, 0xB4, 0x09, 
                    /* 00B8 */    0x50, 0x26, 0x40, 0xA1, 0x00, 0x83, 0xA3, 0x14, 
                    /* 00C0 */    0x4A, 0x73, 0x02, 0x6C, 0x61, 0x10, 0xA4, 0x60, 
                    /* 00C8 */    0x51, 0x22, 0x9D, 0x41, 0x88, 0x43, 0x88, 0x12, 
                    /* 00D0 */    0xA9, 0x38, 0x3C, 0xEA, 0x4C, 0x80, 0x31, 0x5C, 
                    /* 00D8 */    0xE1, 0x04, 0x69, 0x51, 0x80, 0x30, 0x4C, 0x79, 
                    /* 00E0 */    0x03, 0x13, 0x44, 0xA8, 0xF6, 0x07, 0x41, 0x86, 
                    /* 00E8 */    0x8D, 0x1B, 0xBF, 0xE7, 0xE6, 0x01, 0x9C, 0x9B, 
                    /* 00F0 */    0xC7, 0xC4, 0x26, 0xDB, 0xE9, 0x58, 0x05, 0x5E, 
                    /* 00F8 */    0x3C, 0xAA, 0x30, 0x0E, 0x22, 0x81, 0x83, 0x3D, 
                    /* 0100 */    0x0A, 0x64, 0x01, 0x44, 0x91, 0xE0, 0x51, 0xA3, 
                    /* 0108 */    0x4E, 0x70, 0xF0, 0x9E, 0xA4, 0x87, 0x7C, 0x94, 
                    /* 0110 */    0x27, 0x10, 0xE4, 0x20, 0xAD, 0xF3, 0x48, 0x40, 
                    /* 0118 */    0xC6, 0xC0, 0xB0, 0x12, 0x74, 0x70, 0x0C, 0x80, 
                    /* 0120 */    0xE2, 0x1A, 0x50, 0x97, 0x83, 0xC7, 0x00, 0x36, 
                    /* 0128 */    0xEA, 0x04, 0xFF, 0xFF, 0x70, 0x7C, 0xBC, 0xF6, 
                    /* 0130 */    0x7E, 0x09, 0x20, 0x23, 0x37, 0x20, 0x1B, 0xD1, 
                    /* 0138 */    0xC1, 0x61, 0x07, 0x79, 0x32, 0x47, 0x56, 0xAA, 
                    /* 0140 */    0x00, 0xB3, 0xC7, 0x03, 0x0D, 0x34, 0xC1, 0xF1, 
                    /* 0148 */    0x18, 0xD9, 0xF3, 0xE9, 0x19, 0x92, 0x1C, 0x0D, 
                    /* 0150 */    0x3C, 0x08, 0x3E, 0x32, 0x43, 0x7B, 0xFA, 0xA7, 
                    /* 0158 */    0xF5, 0x62, 0xE0, 0x93, 0xC2, 0x61, 0xB1, 0x71, 
                    /* 0160 */    0x3F, 0x4A, 0xB0, 0x71, 0xC0, 0xBF, 0x01, 0x1C, 
                    /* 0168 */    0xF7, 0xE3, 0x81, 0xB1, 0xCF, 0xD3, 0xC7, 0x05, 
                    /* 0170 */    0x51, 0xCB, 0xC8, 0xE2, 0x3C, 0x0E, 0xD4, 0x45, 
                    /* 0178 */    0xC1, 0x83, 0x8D, 0x10, 0xD1, 0xD7, 0x88, 0x04, 
                    /* 0180 */    0xA3, 0x43, 0x68, 0xEC, 0x16, 0x35, 0x5E, 0x7A, 
                    /* 0188 */    0xA0, 0xE0, 0x67, 0x88, 0xF7, 0x0A, 0x9F, 0x12, 
                    /* 0190 */    0x82, 0x1E, 0xBB, 0x87, 0x12, 0xD6, 0x23, 0xF2, 
                    /* 0198 */    0x31, 0x02, 0xB8, 0x9D, 0x03, 0xE0, 0x1F, 0x0B, 
                    /* 01A0 */    0x3C, 0x32, 0x3E, 0x22, 0x8F, 0xF7, 0xD4, 0x8B, 
                    /* 01A8 */    0xA5, 0xF1, 0x61, 0x41, 0xB2, 0xC6, 0x0D, 0xDD, 
                    /* 01B0 */    0xFA, 0x69, 0x80, 0x8C, 0xE1, 0x19, 0xC0, 0x22, 
                    /* 01B8 */    0x61, 0xD1, 0xE3, 0xB6, 0x5F, 0x01, 0x08, 0xA1, 
                    /* 01C0 */    0xCB, 0x9C, 0x84, 0x0E, 0x11, 0x11, 0x12, 0x44, 
                    /* 01C8 */    0x0F, 0x74, 0x84, 0xB8, 0xC9, 0xE1, 0xFE, 0xFF, 
                    /* 01D0 */    0x93, 0xE3, 0x43, 0xC0, 0x8D, 0xD9, 0x43, 0xE0, 
                    /* 01D8 */    0xA7, 0x88, 0x33, 0x38, 0x9E, 0xB3, 0x39, 0x84, 
                    /* 01E0 */    0xE3, 0x89, 0x72, 0x16, 0x07, 0xE4, 0xE9, 0x1A, 
                    /* 01E8 */    0xE1, 0x04, 0x1E, 0x00, 0x1E, 0x52, 0x3C, 0x02, 
                    /* 01F0 */    0x4F, 0xEA, 0x2C, 0x5E, 0x26, 0x3C, 0x02, 0x8C, 
                    /* 01F8 */    0xA4, 0xE3, 0x0B, 0x95, 0xFD, 0x14, 0x90, 0x08, 
                    /* 0200 */    0x18, 0xD4, 0x09, 0x06, 0x78, 0x63, 0x3E, 0x2B, 
                    /* 0208 */    0x80, 0x65, 0xA8, 0xC7, 0x18, 0xE8, 0x44, 0x3C, 
                    /* 0210 */    0x16, 0x23, 0xC6, 0x8A, 0xF2, 0x8C, 0x10, 0xFF, 
                    /* 0218 */    0xBC, 0xC2, 0x44, 0x78, 0x43, 0x08, 0xE4, 0x03, 
                    /* 0220 */    0x84, 0x8F, 0x2F, 0xB0, 0x2F, 0x2B, 0xAD, 0x21, 
                    /* 0228 */    0xE8, 0x60, 0x50, 0xE3, 0x51, 0x43, 0x27, 0x16, 
                    /* 0230 */    0x5F, 0x5B, 0x7C, 0x86, 0xF1, 0xC9, 0xC5, 0xA7, 
                    /* 0238 */    0x17, 0x4F, 0xE0, 0x95, 0x20, 0x4A, 0xC0, 0x78, 
                    /* 0240 */    0x4F, 0x01, 0x41, 0xA3, 0x04, 0x7F, 0x8A, 0x09, 
                    /* 0248 */    0x1B, 0x32, 0xE0, 0xCB, 0x0C, 0x03, 0x89, 0x19, 
                    /* 0250 */    0xE2, 0x89, 0xE3, 0xF1, 0x05, 0xCC, 0x71, 0x8E, 
                    /* 0258 */    0x2F, 0xA0, 0xF9, 0xFF, 0x1F, 0x5F, 0x00, 0xBF, 
                    /* 0260 */    0x22, 0x8E, 0x2F, 0xE8, 0xC1, 0x59, 0xEB, 0xF8, 
                    /* 0268 */    0xC9, 0x51, 0xE1, 0x34, 0x1C, 0xFA, 0xF4, 0x02, 
                    /* 0270 */    0xBA, 0x23, 0x04, 0xF0, 0x39, 0xBA, 0x00, 0xCF, 
                    /* 0278 */    0x6B, 0x85, 0x8F, 0x2E, 0x70, 0xFE, 0xFF, 0x47, 
                    /* 0280 */    0x17, 0xBC, 0xD2, 0x69, 0x09, 0xFC, 0x10, 0x8D, 
                    /* 0288 */    0x7E, 0x44, 0x67, 0xF0, 0xAA, 0xC3, 0xAE, 0x0B, 
                    /* 0290 */    0x3E, 0xB9, 0x00, 0x23, 0x85, 0x36, 0x7D, 0x6A, 
                    /* 0298 */    0x34, 0x6A, 0xD5, 0xA0, 0x4C, 0x8D, 0x32, 0x0D, 
                    /* 02A0 */    0x6A, 0xF5, 0xA9, 0xD4, 0x98, 0xB1, 0x73, 0x8B, 
                    /* 02A8 */    0xE5, 0x0C, 0x53, 0x83, 0xB5, 0x78, 0x10, 0x1A, 
                    /* 02B0 */    0x85, 0x42, 0x20, 0x96, 0x4A, 0x27, 0x10, 0x07, 
                    /* 02B8 */    0x03, 0xA1, 0xF1, 0x3C, 0x80, 0xB0, 0xFF, 0x3F
                })
            }
        }

        Name (ECOK, 0x00)
        Name (INS3, 0x00)
        Name (WLWF, 0x00)
        Name (L3WF, 0x00)
        Name (DCNT, 0x00)
        Name (LDSS, 0x00)
        Name (SSTS, 0x00)
        Device (BT)
        {
            Name (_HID, EisaId ("TOS6205"))
            Method (_STA, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPC0.BTEN)
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (DUSB, 0, NotSerialized)
            {
                If (\_SB.ECOK)
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (Zero, \_SB.PCI0.LPC0.EC0.BLTH)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                }
            }

            Method (AUSB, 0, NotSerialized)
            {
                If (\_SB.ECOK)
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (One, \_SB.PCI0.LPC0.EC0.BLTH)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                }
            }

            Method (BTPO, 0, NotSerialized)
            {
                \_SB.PCI0.LPC0.PHSR (0x0B, 0x25)
                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPC0.BTEN, \_SB.PCI0.LPC0.EC0.BLTH)
                Release (\_SB.PCI0.LPC0.EC0.MUT1)
            }

            Method (BTPF, 0, NotSerialized)
            {
                \_SB.PCI0.LPC0.PHSR (0x0B, 0x26)
                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPC0.BTEN, \_SB.PCI0.LPC0.EC0.BLTH)
                Release (\_SB.PCI0.LPC0.EC0.MUT1)
            }

            Method (BTST, 0, NotSerialized)
            {
                If (\_SB.ECOK)
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.KSWH, Local0)
                    XOr (Local0, 0x01, Local0)
                    Store (\_SB.PCI0.LPC0.EC0.BTHE, Local7)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    If (Local0)
                    {
                        ShiftLeft (Local7, 0x06, Local6)
                        ShiftLeft (Local7, 0x07, Local7)
                        Or (Local7, Local6, Local1)
                        Or (Local0, Local1, Local2)
                        Return (Local2)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
		Return (Package(0x02){0x00,0x00})
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08"))
            Name (_CID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_UID, 0x01)
            Name (_BBN, 0x00)
            Name (SUPP, 0x00)
            Name (CTRL, 0x00)
            Method (XOSC, 4, NotSerialized)
            {
                CreateDWordField (Arg3, 0x00, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                If (LEqual (Arg0, Buffer (0x10)
                        {
                            /* 0000 */    0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 
                            /* 0008 */    0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66
                        }))
                {
                    Store (CDW2, SUPP)
                    Store (CDW3, CTRL)
                    If (LNotEqual (And (SUPP, 0x16), 0x16))
                    {
                        And (CTRL, 0x1E, CTRL)
                    }

                    And (CTRL, 0x1D, CTRL)
                    If (Not (And (CDW1, 0x01)))
                    {
                        If (And (CTRL, 0x01)) {}
                        If (And (CTRL, 0x04))
                        {
                            Store (One, \_SB.PCI0.SMB.EPNM)
                            Store (One, \_SB.PCI0.SMB.DPPF)
                            Store (One, \_SB.PCI0.SMB.FNGS)
                        }
                        Else
                        {
                            Store (0x00, \_SB.PCI0.SMB.EPNM)
                            Store (0x00, \_SB.PCI0.SMB.DPPF)
                            Store (0x00, \_SB.PCI0.SMB.FNGS)
                        }
                    }

                    If (LNotEqual (Arg1, One))
                    {
                        Or (CDW1, 0x08, CDW1)
                    }

                    If (LNotEqual (CDW3, CTRL))
                    {
                        Or (CDW1, 0x10, CDW1)
                    }

                    Store (CTRL, CDW3)
                    Return (Arg3)
                }
                Else
                {
                    Or (CDW1, 0x04, CDW1)
                    Return (Arg3)
                }
            }

            Method (_INI, 0, NotSerialized)
            {
                \_SB.OSTP ()
            }

            OperationRegion (NBBR, PCI_Config, 0x1C, 0x08)
            Field (NBBR, DWordAcc, NoLock, Preserve)
            {
                BR3L,   32, 
                BR3H,   32
            }

            OperationRegion (NBBI, PCI_Config, 0x84, 0x04)
            Field (NBBI, DWordAcc, NoLock, Preserve)
            {
                PARB,   32
            }

            OperationRegion (NBRV, PCI_Config, 0x89, 0x01)
            Field (NBRV, ByteAcc, NoLock, Preserve)
            {
                RVN0,   8
            }

            OperationRegion (NBMS, PCI_Config, 0x60, 0x08)
            Field (NBMS, DWordAcc, NoLock, Preserve)
            {
                MIDX,   32, 
                MIDR,   32
            }

            Mutex (NBMM, 0x00)
            Method (NBMR, 1, NotSerialized)
            {
                Acquire (NBMM, 0xFFFF)
                And (Arg0, 0x7F, Local0)
                Store (Local0, MIDX)
                Store (MIDR, Local0)
                Store (0x7F, MIDX)
                Release (NBMM)
                Return (Local0)
            }

            Method (NBMW, 2, NotSerialized)
            {
                Acquire (NBMM, 0xFFFF)
                And (Arg0, 0x7F, Local0)
                Or (Local0, 0x80, Local0)
                Store (Local0, MIDX)
                Store (Arg1, MIDR)
                Store (And (Local0, 0x7F, Local0), MIDX)
                Release (NBMM)
            }

            OperationRegion (NBXP, PCI_Config, 0xE0, 0x08)
            Field (NBXP, DWordAcc, NoLock, Preserve)
            {
                NBXI,   32, 
                NBXD,   32
            }

            Mutex (NBXM, 0x00)
            Method (NBXR, 1, NotSerialized)
            {
                Acquire (NBXM, 0xFFFF)
                Store (Arg0, NBXI)
                Store (NBXD, Local0)
                Store (0x00, NBXI)
                Release (NBXM)
                Return (Local0)
            }

            Method (NBXW, 2, NotSerialized)
            {
                Acquire (NBXM, 0xFFFF)
                Store (Arg0, NBXI)
                Store (Arg1, NBXD)
                Store (0x00, NBXI)
                Release (NBXM)
            }

            Method (GFXM, 0, NotSerialized)
            {
                Store (NBMR (0x08), Local0)
                And (Local0, 0x0F, Local0)
                Return (Local0)
            }

            Method (GPPM, 0, NotSerialized)
            {
                Store (NBMR (0x31), Local0)
                And (Local0, 0x0F, Local0)
                Return (Local0)
            }

            Method (XPTR, 2, NotSerialized)
            {
                If (LAnd (LLess (Arg0, 0x02), LGreater (Arg0, 0x07)))
                {
                    Return (0x00)
                }
                Else
                {
                    Store (0x01, Local0)
                    If (LLess (Arg0, 0x04))
                    {
                        Add (Arg0, 0x02, Local1)
                    }
                    Else
                    {
                        Add (Arg0, 0x11, Local1)
                    }

                    ShiftLeft (Local0, Local1, Local0)
                    Store (NBMR (0x08), Local2)
                    If (Arg1)
                    {
                        And (Local2, Not (Local0), Local2)
                    }
                    Else
                    {
                        Or (Local2, Local0, Local2)
                    }

                    NBMW (0x08, Local2)
                    Return (Ones)
                }
            }

            Name (PX3L, 0x80000000)
            Name (PX3H, 0x80000000)
            Name (PX3S, 0x10000000)
            Name (PX3K, 0xF0000000)
            Mutex (BR3X, 0x00)
            Method (BR3M, 0, NotSerialized)
            {
                Store (PARB, Local0)
                ShiftRight (Local0, 0x10, Local0)
                And (Local0, 0x07, Local0)
                If (Local0)
                {
                    ShiftLeft (0x01, Local0, Local1)
                    Subtract (0x1000, Local1, Local1)
                    ShiftLeft (Local1, 0x14, Local1)
                    Store (Local1, PX3K)
                    ShiftRight (0x00100000, Local0, Local0)
                    Store (Local0, PX3S)
                }

                Acquire (BR3X, 0xFFFF)
                Store (NBMR (0x00), Local0)
                And (Local0, 0xFFFFFFF7, Local0)
                NBMW (0x00, Local0)
                Store (BR3L, Local0)
                And (Local0, PX3K, Local0)
                Store (Local0, PX3L)
                Store (BR3H, Local0)
                And (Local0, 0xFF, Local0)
                Store (Local0, PX3H)
                Store (NBMR (0x00), Local0)
                Or (Local0, 0x08, Local0)
                NBMW (0x00, Local0)
                Release (BR3X)
                Return (PX3L)
            }

            OperationRegion (K8ST, SystemMemory, 0xCDEDDF74, 0x00000048)
            Field (K8ST, AnyAcc, NoLock, Preserve)
            {
                C0_0,   16, 
                C2_0,   16, 
                C4_0,   16, 
                C6_0,   16, 
                C8_0,   16, 
                CA_0,   16, 
                CC_0,   16, 
                CE_0,   16, 
                D0_0,   16, 
                D2_0,   16, 
                D4_0,   16, 
                D6_0,   16, 
                D8_0,   16, 
                DA_0,   16, 
                DC_0,   16, 
                DE_0,   16, 
                E0_0,   16, 
                E2_0,   16, 
                E4_0,   16, 
                E6_0,   16, 
                E8_0,   16, 
                EA_0,   16, 
                EC_0,   16, 
                EE_0,   16, 
                F0_0,   16, 
                F2_0,   16, 
                F4_0,   16, 
                F6_0,   16, 
                F8_0,   16, 
                FA_0,   16, 
                FC_0,   16, 
                FE_0,   16, 
                TOML,   32, 
                TOMH,   32
            }

            Name (RSRC, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, SubDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    0x00,, )
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C1FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y00, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C2000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y01, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C5FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y02, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C6000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y03, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000C9FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y04, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CA000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y05, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CDFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y06, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CE000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y07, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D1FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y08, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D2000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y09, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D5FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y0A, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D6000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y0B, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000D9FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y0C, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DA000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y0D, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DDFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y0E, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DE000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y0F, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E1FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y10, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E2000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y11, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E5FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y12, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E6000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y13, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000E9FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y14, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EA000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y15, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EDFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y16, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EE000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00002000,         // Length
                    0x00,, _Y17, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    0x00,, _Y18, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0xFFFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    0x00,, _Y19, AddressRangeMemory, TypeStatic)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    0x00,, , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    0x00,, , TypeStatic)
            })
            Method (_CRS, 0, Serialized)
            {
                CreateBitField (RSRC, \_SB.PCI0._Y00._RW, C0RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y00._LEN, C0LN)
                Store (One, C0RW)
                Store (0x2000, C0LN)
                If (And (C0_0, 0x1818))
                {
                    Store (0x00, C0LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y01._RW, C2RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y01._LEN, C2LN)
                Store (One, C2RW)
                Store (0x2000, C2LN)
                If (And (C2_0, 0x1818))
                {
                    Store (0x00, C2LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y02._RW, C4RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y02._LEN, C4LN)
                Store (One, C4RW)
                Store (0x2000, C4LN)
                If (And (C4_0, 0x1818))
                {
                    Store (0x00, C4LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y03._RW, C6RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y03._LEN, C6LN)
                Store (One, C6RW)
                Store (0x2000, C6LN)
                If (And (C6_0, 0x1818))
                {
                    Store (0x00, C6LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y04._RW, C8RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y04._LEN, C8LN)
                Store (One, C8RW)
                Store (0x2000, C8LN)
                If (And (C8_0, 0x1818))
                {
                    Store (0x00, C8LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y05._RW, CARW)
                CreateDWordField (RSRC, \_SB.PCI0._Y05._LEN, CALN)
                Store (One, CARW)
                Store (0x2000, CALN)
                If (And (CA_0, 0x1818))
                {
                    Store (0x00, CALN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y06._RW, CCRW)
                CreateDWordField (RSRC, \_SB.PCI0._Y06._LEN, CCLN)
                Store (One, CCRW)
                Store (0x2000, CCLN)
                If (And (CC_0, 0x1818))
                {
                    Store (0x00, CCLN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y07._RW, CERW)
                CreateDWordField (RSRC, \_SB.PCI0._Y07._LEN, CELN)
                Store (One, CERW)
                Store (0x2000, CELN)
                If (And (CE_0, 0x1818))
                {
                    Store (0x00, CELN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y08._RW, D0RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y08._LEN, D0LN)
                Store (One, D0RW)
                Store (0x2000, D0LN)
                If (And (D0_0, 0x1818))
                {
                    Store (0x00, D0LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y09._RW, D2RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y09._LEN, D2LN)
                Store (One, D2RW)
                Store (0x2000, D2LN)
                If (And (D2_0, 0x1818))
                {
                    Store (0x00, D2LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y0A._RW, D4RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y0A._LEN, D4LN)
                Store (One, D4RW)
                Store (0x2000, D4LN)
                If (And (D4_0, 0x1818))
                {
                    Store (0x00, D4LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y0B._RW, D6RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y0B._LEN, D6LN)
                Store (One, D6RW)
                Store (0x2000, D6LN)
                If (And (D6_0, 0x1818))
                {
                    Store (0x00, D6LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y0C._RW, D8RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y0C._LEN, D8LN)
                Store (One, D8RW)
                Store (0x2000, D8LN)
                If (And (D8_0, 0x1818))
                {
                    Store (0x00, D8LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y0D._RW, DARW)
                CreateDWordField (RSRC, \_SB.PCI0._Y0D._LEN, DALN)
                Store (One, DARW)
                Store (0x2000, DALN)
                If (And (DA_0, 0x1818))
                {
                    Store (0x00, DALN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y0E._RW, DCRW)
                CreateDWordField (RSRC, \_SB.PCI0._Y0E._LEN, DCLN)
                Store (One, DCRW)
                Store (0x2000, DCLN)
                If (And (DC_0, 0x1818))
                {
                    Store (0x00, DCLN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y0F._RW, DERW)
                CreateDWordField (RSRC, \_SB.PCI0._Y0F._LEN, DELN)
                Store (One, DERW)
                Store (0x2000, DELN)
                If (And (DE_0, 0x1818))
                {
                    Store (0x00, DELN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y10._RW, E0RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y10._LEN, E0LN)
                Store (One, E0RW)
                Store (0x2000, E0LN)
                If (And (E0_0, 0x1818))
                {
                    Store (0x00, E0LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y11._RW, E2RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y11._LEN, E2LN)
                Store (One, E2RW)
                Store (0x2000, E2LN)
                If (And (E2_0, 0x1818))
                {
                    Store (0x00, E2LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y12._RW, E4RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y12._LEN, E4LN)
                Store (One, E4RW)
                Store (0x2000, E4LN)
                If (And (E4_0, 0x1818))
                {
                    Store (0x00, E4LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y13._RW, E6RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y13._LEN, E6LN)
                Store (One, E6RW)
                Store (0x2000, E6LN)
                If (And (E6_0, 0x1818))
                {
                    Store (0x00, E6LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y14._RW, E8RW)
                CreateDWordField (RSRC, \_SB.PCI0._Y14._LEN, E8LN)
                Store (One, E8RW)
                Store (0x2000, E8LN)
                If (And (E8_0, 0x1818))
                {
                    Store (0x00, E8LN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y15._RW, EARW)
                CreateDWordField (RSRC, \_SB.PCI0._Y15._LEN, EALN)
                Store (One, EARW)
                Store (0x2000, EALN)
                If (And (EA_0, 0x1818))
                {
                    Store (0x00, EALN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y16._RW, ECRW)
                CreateDWordField (RSRC, \_SB.PCI0._Y16._LEN, ECLN)
                Store (One, ECRW)
                Store (0x2000, ECLN)
                If (And (EC_0, 0x1818))
                {
                    Store (0x00, ECLN)
                }

                CreateBitField (RSRC, \_SB.PCI0._Y17._RW, EERW)
                CreateDWordField (RSRC, \_SB.PCI0._Y17._LEN, EELN)
                Store (One, EERW)
                Store (0x2000, EELN)
                If (And (EE_0, 0x1818))
                {
                    Store (0x00, EELN)
                }

                CreateDWordField (RSRC, \_SB.PCI0._Y18._MIN, BT1S)
                CreateDWordField (RSRC, \_SB.PCI0._Y18._MAX, BT1M)
                CreateDWordField (RSRC, \_SB.PCI0._Y18._LEN, BT1L)
                CreateDWordField (RSRC, \_SB.PCI0._Y19._MIN, BT2S)
                CreateDWordField (RSRC, \_SB.PCI0._Y19._MAX, BT2M)
                CreateDWordField (RSRC, \_SB.PCI0._Y19._LEN, BT2L)
                Store (BR3M (), Local0)
                Store (PX3H, Local2)
                Store (PX3S, Local1)
                If (Local2)
                {
                    Store (0x00, Local1)
                    Store (TOML, Local0)
                }

                Store (TOML, BT1S)
                Store (Subtract (Local0, 0x01), BT1M)
                Subtract (Local0, TOML, BT1L)
                Store (Add (Local0, Local1), BT2S)
                Store (Add (Subtract (BT2M, BT2S), 0x01), BT2L)
                Return (RSRC)
            }

            Device (MEMR)
            {
                Name (_HID, EisaId ("PNP0C02"))
                Name (MEM1, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y1A)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y1B)
                })
                Method (_CRS, 0, NotSerialized)
                {
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y1A._BAS, MB01)
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y1A._LEN, ML01)
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y1B._BAS, MB02)
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y1B._LEN, ML02)
                    If (GPIC)
                    {
                        Store (0xFEC00000, MB01)
                        Store (0xFEE00000, MB02)
                        Store (0x00011000, ML01)
                        Store (0x1000, ML02)
                    }

                    Return (MEM1)
                }
            }

            Method (_PRT, 0, NotSerialized)
            {
                If (GPIC)
                {
                    Return (Package (0x16)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            0x00, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0001FFFF, 
                            0x01, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            0x00, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0003FFFF, 
                            0x00, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x00, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0005FFFF, 
                            0x00, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x00, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0007FFFF, 
                            0x00, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0009FFFF, 
                            0x00, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x000AFFFF, 
                            0x00, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0011FFFF, 
                            0x00, 
                            0x00, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0012FFFF, 
                            0x00, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0012FFFF, 
                            0x01, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0012FFFF, 
                            0x02, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0013FFFF, 
                            0x00, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0013FFFF, 
                            0x01, 
                            0x00, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0013FFFF, 
                            0x02, 
                            0x00, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x05, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x00, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x01, 
                            0x00, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x02, 
                            0x00, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x03, 
                            0x00, 
                            0x13
                        }
                    })
                }
                Else
                {
                    Return (Package (0x15)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0001FFFF, 
                            0x01, 
                            \_SB.PCI0.LPC0.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0003FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0005FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0007FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKD, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0009FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x000AFFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0011FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKG, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0012FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0012FFFF, 
                            0x01, 
                            \_SB.PCI0.LPC0.LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0012FFFF, 
                            0x02, 
                            \_SB.PCI0.LPC0.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0013FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0013FFFF, 
                            0x01, 
                            \_SB.PCI0.LPC0.LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0013FFFF, 
                            0x02, 
                            \_SB.PCI0.LPC0.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x00, 
                            \_SB.PCI0.LPC0.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x01, 
                            \_SB.PCI0.LPC0.LNKB, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x02, 
                            \_SB.PCI0.LPC0.LNKC, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0014FFFF, 
                            0x03, 
                            \_SB.PCI0.LPC0.LNKD, 
                            0x00
                        }
                    })
                }
            }

            OperationRegion (BAR1, PCI_Config, 0x14, 0x04)
            Field (BAR1, ByteAcc, NoLock, Preserve)
            {
                Z009,   32
            }

            Device (PB2)
            {
                Name (_ADR, 0x00020000)
                OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
                Field (XPCB, ByteAcc, NoLock, Preserve)
                {
                            Offset (0x10), 
                    LKCN,   16, 
                    LKST,   16, 
                            Offset (0x1A), 
                    SLST,   16
                }

                OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
                Field (XPRI, ByteAcc, NoLock, Preserve)
                {
                    XPIR,   32, 
                    XPID,   32
                }

                OperationRegion (XPEX, SystemMemory, 0xE0010100, 0x0100)
                Field (XPEX, DWordAcc, NoLock, Preserve)
                {
                            Offset (0x18), 
                    VC02,   32
                }

                Method (XPDL, 0, NotSerialized)
                {
                    If (And (VC02, 0x00020000))
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (XPRD, 1, NotSerialized)
                {
                    Store (Arg0, XPIR)
                    Store (XPID, Local0)
                    Store (0x00, XPIR)
                    Return (Local0)
                }

                Method (XPWR, 2, NotSerialized)
                {
                    Store (Arg0, XPIR)
                    Store (Arg1, XPID)
                    Store (0x00, XPIR)
                }

                Method (XPRT, 0, NotSerialized)
                {
                    Store (XPRD (0xA2), Local0)
                    And (Local0, Not (0x07), Local0)
                    ShiftRight (Local0, 0x04, Local1)
                    And (Local1, 0x07, Local1)
                    Or (Local0, Local1, Local0)
                    Or (Local0, 0x0100, Local0)
                    XPWR (0xA2, Local0)
                }

                Method (XPLP, 1, NotSerialized)
                {
                    Store (0x0101, Local1)
                    Store (\_SB.PCI0.NBXR (0x65), Local2)
                    If (Arg0)
                    {
                        And (Local2, Not (Local1), Local2)
                    }
                    Else
                    {
                        Or (Local2, Local1, Local2)
                    }

                    \_SB.PCI0.NBXW (0x65, Local2)
                }

                Method (XPR2, 0, NotSerialized)
                {
                    Store (LKCN, Local0)
                    And (Local0, Not (0x20), Local0)
                    Store (Local0, LKCN)
                    Or (Local0, 0x20, Local0)
                    Store (Local0, LKCN)
                    Store (0x64, Local1)
                    Store (0x01, Local2)
                    While (LAnd (Local1, Local2))
                    {
                        Sleep (0x01)
                        Store (LKST, Local3)
                        If (And (Local3, 0x0800))
                        {
                            Decrement (Local1)
                        }
                        Else
                        {
                            Store (0x00, Local2)
                        }
                    }

                    And (Local0, Not (0x20), Local0)
                    Store (Local0, LKCN)
                    If (LNot (Local2))
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Device (VGA)
                {
                    Name (_ADR, 0x00)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.SMB.MID2)
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Name (ATIB, Buffer (0x50) {})
                    Method (ATIF, 2, Serialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            Return (AF00 ())
                        }

                        If (LEqual (Arg0, 0x01))
                        {
                            Return (AF01 ())
                        }

                        If (LEqual (Arg0, 0x02))
                        {
                            Return (AF02 ())
                        }

                        If (LEqual (Arg0, 0x03))
                        {
                            Return (AF03 (DerefOf (Index (Arg1, 0x02)), DerefOf (Index (Arg1, 
                                0x04))))
                        }

                        If (LEqual (Arg0, 0x05))
                        {
                            Return (AF05 ())
                        }

                        If (LEqual (Arg0, 0x06))
                        {
                            Return (AF06 (DerefOf (Index (Arg1, 0x03))))
                        }

                        If (LEqual (Arg0, 0x07))
                        {
                            Return (AF07 ())
                        }

                        If (LEqual (Arg0, 0x08))
                        {
                            Return (AF08 (DerefOf (Index (Arg1, 0x02))))
                        }
                        Else
                        {
                            CreateWordField (ATIB, 0x00, SSZE)
                            CreateWordField (ATIB, 0x02, VERN)
                            CreateDWordField (ATIB, 0x04, NMSK)
                            CreateDWordField (ATIB, 0x08, SFUN)
                            Store (0x00, SSZE)
                            Store (0x00, VERN)
                            Store (0x00, NMSK)
                            Store (0x00, SFUN)
                            Return (ATIB)
                        }
                    }

                    Method (AF00, 0, NotSerialized)
                    {
                        Store (0xF0, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateWordField (ATIB, 0x02, VERN)
                        CreateDWordField (ATIB, 0x04, NMSK)
                        CreateDWordField (ATIB, 0x08, SFUN)
                        Store (0x0C, SSZE)
                        Store (0x01, VERN)
                        If (CondRefOf (\_SB.PCI0.AGP.VGA.XTPX, Local4))
                        {
                            Store (0x11, NMSK)
                        }
                        Else
                        {
                            Store (0x51, NMSK)
                        }

                        Store (NMSK, MSKN)
                        Store (0x07, SFUN)
                        Return (ATIB)
                    }

                    Name (NCOD, 0x81)
                    Method (AF01, 0, NotSerialized)
                    {
                        Store (0xF1, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateDWordField (ATIB, 0x02, VMSK)
                        CreateDWordField (ATIB, 0x06, FLGS)
                        Store (0x03, VMSK)
                        Store (0x0A, SSZE)
                        Store (0x01, FLGS)
                        Store (0x81, NCOD)
                        Return (ATIB)
                    }

                    Name (PSBR, Buffer (0x04)
                    {
                        0x00, 0x00, 0x00, 0x00
                    })
                    Name (MSKN, 0x00)
                    Name (SEXM, 0x00)
                    Name (STHG, 0x00)
                    Name (STHI, 0x00)
                    Name (SFPG, 0x00)
                    Name (SFPI, 0x00)
                    Name (SSPS, 0x00)
                    Name (SSDM, 0x0A)
                    Name (SCDY, 0x00)
                    Name (SACT, Buffer (0x06)
                    {
                        0x01, 0x02, 0x08, 0x03, 0x09, 0x0A
                    })
                    Method (AF02, 0, NotSerialized)
                    {
                        Store (0xF2, P80H)
                        CreateBitField (PSBR, 0x00, PDSW)
                        CreateBitField (PSBR, 0x01, PEXM)
                        CreateBitField (PSBR, 0x02, PTHR)
                        CreateBitField (PSBR, 0x03, PFPS)
                        CreateBitField (PSBR, 0x04, PSPS)
                        CreateBitField (PSBR, 0x05, PDCC)
                        CreateBitField (PSBR, 0x06, PXPS)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateDWordField (ATIB, 0x02, PSBI)
                        CreateByteField (ATIB, 0x06, EXPM)
                        CreateByteField (ATIB, 0x07, THRM)
                        CreateByteField (ATIB, 0x08, THID)
                        CreateByteField (ATIB, 0x09, FPWR)
                        CreateByteField (ATIB, 0x0A, FPID)
                        CreateByteField (ATIB, 0x0B, SPWR)
                        Store (0x0C, SSZE)
                        Store (PSBR, PSBI)
                        If (PDSW)
                        {
                            Store (0x82, P80H)
                            Store (Zero, PDSW)
                        }

                        If (PEXM)
                        {
                            Store (SEXM, EXPM)
                            Store (Zero, SEXM)
                            Store (Zero, PEXM)
                        }

                        If (PTHR)
                        {
                            Store (STHG, THRM)
                            Store (STHI, THID)
                            Store (Zero, STHG)
                            Store (Zero, STHI)
                            Store (Zero, PTHR)
                        }

                        If (PFPS)
                        {
                            Store (SFPG, FPWR)
                            Store (SFPI, FPWR)
                            Store (Zero, SFPG)
                            Store (Zero, SFPI)
                            Store (Zero, PFPS)
                        }

                        If (PSPS)
                        {
                            Store (SSPS, SPWR)
                            Store (Zero, PSPS)
                        }

                        If (PXPS)
                        {
                            Store (0xA2, P80H)
                            Store (Zero, PXPS)
                        }

                        Return (ATIB)
                    }

                    Method (AF03, 2, NotSerialized)
                    {
                        Store (0xF3, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateWordField (ATIB, 0x02, SSDP)
                        CreateWordField (ATIB, 0x04, SCDP)
                        Store (Arg0, SSDP)
                        Store (Arg1, SCDP)
                        Name (NXTD, 0x06)
                        Name (CIDX, 0x06)
                        Store (SSDP, Local1)
                        And (Local1, 0x0B, Local1)
                        Store (SCDP, Local2)
                        If (CondRefOf (\_SB.LID._LID, Local4))
                        {
                            And (Local2, Not (0x01), Local2)
                            Or (Local2, \_SB.LID._LID (), Local2)
                        }
                        Else
                        {
                            Or (Local2, 0x01, Local2)
                        }

                        Store (Local2, P80H)
                        Store (Zero, Local0)
                        While (LLess (Local0, SizeOf (SACT)))
                        {
                            Store (DerefOf (Index (SACT, Local0)), Local3)
                            If (LEqual (Local3, Local1))
                            {
                                Store (Local0, CIDX)
                                Store (SizeOf (SACT), Local0)
                            }
                            Else
                            {
                                Increment (Local0)
                            }
                        }

                        Store (CIDX, Local0)
                        While (LLess (Local0, SizeOf (SACT)))
                        {
                            Increment (Local0)
                            If (LEqual (Local0, SizeOf (SACT)))
                            {
                                Store (0x00, Local0)
                            }

                            Store (DerefOf (Index (SACT, Local0)), Local3)
                            If (LEqual (And (Local3, Local2), Local3))
                            {
                                Store (Local0, NXTD)
                                Store (SizeOf (SACT), Local0)
                            }
                        }

                        If (LEqual (NXTD, SizeOf (SACT)))
                        {
                            Store (Zero, SSDP)
                        }
                        Else
                        {
                            Store (NXTD, Local0)
                            Store (DerefOf (Index (SACT, Local0)), Local3)
                            And (SSDP, Not (0x0B), SSDP)
                            Or (SSDP, Local3, SSDP)
                        }

                        Store (0x04, SSZE)
                        Store (SSDP, P80H)
                        Return (ATIB)
                    }

                    Method (AF05, 0, NotSerialized)
                    {
                        Store (0xF5, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateByteField (ATIB, 0x02, TSEF)
                        CreateByteField (ATIB, 0x03, TVIF)
                        Store (0x04, SSZE)
                        Store (0x00, TSEF)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x05, \_SB.PCI0.LPC0.DID)
                        Store (ATIB, \_SB.PCI0.LPC0.INFO)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        CreateByteField (\_SB.PCI0.LPC0.INFO, 0x03, TVII)
                        Store (TVII, TVIF)
                        Release (\_SB.PCI0.LPC0.PSMX)
                        Return (ATIB)
                    }

                    Method (AF06, 1, NotSerialized)
                    {
                        Store (0xF6, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateByteField (ATIB, 0x02, TSEF)
                        CreateByteField (ATIB, 0x03, TVIF)
                        Store (0x04, SSZE)
                        Store (0x00, TSEF)
                        Store (Arg0, TVIF)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x06, \_SB.PCI0.LPC0.DID)
                        Store (ATIB, \_SB.PCI0.LPC0.INFO)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        Release (\_SB.PCI0.LPC0.PSMX)
                    }

                    Method (AF07, 0, NotSerialized)
                    {
                        Store (0xF7, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateByteField (ATIB, 0x02, XMOD)
                        Store (0x03, SSZE)
                        Store (0x00, XMOD)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x07, \_SB.PCI0.LPC0.DID)
                        Store (ATIB, \_SB.PCI0.LPC0.INFO)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        CreateByteField (\_SB.PCI0.LPC0.INFO, 0x02, PMOD)
                        Store (PMOD, XMOD)
                        Release (\_SB.PCI0.LPC0.PSMX)
                        Return (ATIB)
                    }

                    Method (AF08, 1, NotSerialized)
                    {
                        Store (0xF8, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateByteField (ATIB, 0x02, XMOD)
                        Store (0x03, SSZE)
                        Store (Arg0, XMOD)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x08, \_SB.PCI0.LPC0.DID)
                        Store (ATIB, \_SB.PCI0.LPC0.INFO)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        Release (\_SB.PCI0.LPC0.PSMX)
                    }

                    Method (AFN0, 0, Serialized)
                    {
                        If (And (MSKN, 0x01))
                        {
                            CreateBitField (PSBR, 0x00, PDSW)
                            Store (One, PDSW)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN1, 1, Serialized)
                    {
                        If (And (MSKN, 0x02))
                        {
                            Store (Arg0, Local0)
                            And (Local0, 0x03, Local0)
                            Store (Local0, SEXM)
                            CreateBitField (PSBR, 0x01, PEXM)
                            Store (One, PEXM)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN2, 2, Serialized)
                    {
                        If (And (MSKN, 0x04))
                        {
                            Store (Arg0, Local0)
                            Store (Local0, STHI)
                            Store (Arg1, Local0)
                            Store (And (Local0, 0x03, Local0), STHG)
                            CreateBitField (PSBR, 0x02, PTHS)
                            Store (One, PTHS)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN3, 2, Serialized)
                    {
                        If (And (MSKN, 0x08))
                        {
                            Store (Arg0, Local0)
                            Store (Local0, SFPI)
                            Store (Arg1, Local0)
                            Store (And (Local0, 0x03, Local0), SFPG)
                            CreateBitField (PSBR, 0x03, PFPS)
                            Store (One, PFPS)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN4, 1, Serialized)
                    {
                        If (And (MSKN, 0x10))
                        {
                            Store (Arg0, Local0)
                            Store (SSPS, Local1)
                            Store (Local0, SSPS)
                            If (LEqual (Local0, Local1)) {}
                            Else
                            {
                                CreateBitField (PSBR, 0x04, PSPS)
                                Store (One, PSPS)
                                Notify (VGA, NCOD)
                            }
                        }
                    }

                    Method (AFN5, 0, Serialized)
                    {
                        If (And (MSKN, 0x20))
                        {
                            CreateBitField (PSBR, 0x05, PDCC)
                            Store (One, PDCC)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN6, 0, Serialized)
                    {
                        If (And (MSKN, 0x40))
                        {
                            CreateBitField (PSBR, 0x06, PXPS)
                            Store (One, PXPS)
                            Notify (VGA, NCOD)
                        }
                    }

                    Name (SWIT, 0x01)
                    Name (CRTA, 0x01)
                    Name (LCDA, 0x01)
                    Name (TVA, 0x00)
                    Name (DFPA, 0x00)
                    Name (TOGF, 0x00)
                    Name (SWIF, 0x00)
                    Method (_DOS, 1, NotSerialized)
                    {
                        Store ("VGA --_DOS Arg0", Debug)
                        Store (Arg0, Local0)
                        And (Local0, 0x01, Local1)
                        Store (Local1, SWIT)
                        If (LEqual (Local1, 0x00))
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT0, 0xFFFF)
                            Store (0x91, \_SB.PCI0.LPC0.BCMD)
                            Store (Zero, \_SB.PCI0.LPC0.SMIC)
                            Release (\_SB.PCI0.LPC0.EC0.MUT0)
                            Store (\_SB.PCI0.LPC0.PAR2, Local2)
                            And (Local2, 0x01, Local0)
                            Store (Local0, LCDA)
                            And (Local2, 0x02, Local0)
                            Store (Local0, CRTA)
                        }
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Store ("VGA --_DOD", Debug)
                        Return (Package (0x04)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x0200, 
                            0x0210
                        })
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
                            If (LCDA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("LCD --_DGS", Debug)
                            Store (LCDA, Local0)
                            Store (Local0, Debug)
                            If (LCDA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("LCD --_DSS", Debug)
                            Store (Arg0, Debug)
                        }

                        Method (_BCL, 0, NotSerialized)
                        {
                            Return (Package (0x0A)
                            {
                                0x64, 
                                0x64, 
                                0x00, 
                                0x0F, 
                                0x1E, 
                                0x2E, 
                                0x38, 
                                0x48, 
                                0x52, 
                                0x64
                            })
                        }

                        Method (_BCM, 1, NotSerialized)
                        {
                            While (One)
                            {
                                Name (T_0, 0x00)
                                Store (ToInteger (Arg0), T_0)
                                If (LEqual (T_0, 0x00))
                                {
                                    Store (0x00, Local1)
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x0F))
                                    {
                                        Store (0x01, Local1)
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, 0x1E))
                                        {
                                            Store (0x02, Local1)
                                        }
                                        Else
                                        {
                                            If (LEqual (T_0, 0x2E))
                                            {
                                                Store (0x03, Local1)
                                            }
                                            Else
                                            {
                                                If (LEqual (T_0, 0x38))
                                                {
                                                    Store (0x04, Local1)
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_0, 0x48))
                                                    {
                                                        Store (0x05, Local1)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T_0, 0x52))
                                                        {
                                                            Store (0x06, Local1)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T_0, 0x64))
                                                            {
                                                                Store (0x07, Local1)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                Break
                            }

                            Store (ToInteger (Local1), Local0)
                            If (LEqual (TPOS, 0x40))
                            {
                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                Store (Local0, \_SB.PCI0.LPC0.EC0.BLVL)
                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                            }
                        }

                        Method (_BQC, 0, NotSerialized)
                        {
                            If (LEqual (TPOS, 0x40))
                            {
                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                Store (\_SB.PCI0.LPC0.EC0.BLVL, Local0)
                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                While (One)
                                {
                                    Name (T_0, 0x00)
                                    Store (ToInteger (Local0), T_0)
                                    If (LEqual (T_0, 0x00))
                                    {
                                        Store (0x00, Local1)
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, 0x01))
                                        {
                                            Store (0x0F, Local1)
                                        }
                                        Else
                                        {
                                            If (LEqual (T_0, 0x02))
                                            {
                                                Store (0x1E, Local1)
                                            }
                                            Else
                                            {
                                                If (LEqual (T_0, 0x03))
                                                {
                                                    Store (0x2E, Local1)
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_0, 0x04))
                                                    {
                                                        Store (0x38, Local1)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T_0, 0x05))
                                                        {
                                                            Store (0x48, Local1)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T_0, 0x06))
                                                            {
                                                                Store (0x52, Local1)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T_0, 0x07))
                                                                {
                                                                    Store (0x64, Local1)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    Break
                                }
                            }

                            Return (Local1)
                        }
                    }

                    Device (CRT1)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("CRT --_DCS", Debug)
                            If (CRTA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("CRT --_DGS", Debug)
                            Store (CRTA, Local0)
                            Store (Local0, Debug)
                            If (CRTA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("CRT --_DSS", Debug)
                            Store (Arg0, Debug)
                        }
                    }

                    Device (TV)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("TV --_DCS", Debug)
                            Store (0x8F, \_SB.PCI0.LPC0.BCMD)
                            Store (Zero, \_SB.PCI0.LPC0.SMIC)
                            If (TVA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("TV --_DGS", Debug)
                            Store (TVA, Local0)
                            If (TVA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("TV --_DSS", Debug)
                            Store (Arg0, Debug)
                        }
                    }

                    Device (DFP1)
                    {
                        Name (_ADR, 0x0210)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("DFP --_DCS", Debug)
                            If (DFPA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("DFP --_DGS", Debug)
                            Store (DFPA, Local0)
                            Store (Local0, Debug)
                            If (DFPA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("DFP --_DSS", Debug)
                            Store (Arg0, Debug)
                        }
                    }

                    OperationRegion (PCFG, PCI_Config, 0x00, 0x50)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                                Offset (0x2C), 
                        SVID,   32, 
                                Offset (0x4C), 
                        SMID,   32
                    }
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x11
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                \_SB.PCI0.LPC0.LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                \_SB.PCI0.LPC0.LNKD, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                \_SB.PCI0.LPC0.LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                \_SB.PCI0.LPC0.LNKB, 
                                0x00
                            }
                        })
                    }
                }
            }

            Device (PB7)
            {
                Name (_ADR, 0x00070000)
                Name (_PRW, Package (0x02)
                {
                    0x18, 
                    0x04
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x12
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                \_SB.PCI0.LPC0.LNKD, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                \_SB.PCI0.LPC0.LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                \_SB.PCI0.LPC0.LNKB, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                \_SB.PCI0.LPC0.LNKC, 
                                0x00
                            }
                        })
                    }
                }

                OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
                Field (XPCB, ByteAcc, NoLock, Preserve)
                {
                            Offset (0x10), 
                    LKCN,   16, 
                    LKST,   16, 
                            Offset (0x1A), 
                    SLST,   16
                }

                OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
                Field (XPRI, ByteAcc, NoLock, Preserve)
                {
                    XPIR,   32, 
                    XPID,   32
                }

                OperationRegion (XPEX, SystemMemory, 0xE0038100, 0x0100)
                Field (XPEX, DWordAcc, NoLock, Preserve)
                {
                            Offset (0x28), 
                    VC0S,   32
                }

                Method (XPDL, 0, NotSerialized)
                {
                    Store (Zero, Local0)
                    If (And (VC0S, 0x00020000))
                    {
                        Store (Ones, Local0)
                    }

                    Return (Local0)
                }

                Method (XPRD, 1, NotSerialized)
                {
                    Store (Arg0, XPIR)
                    Store (XPID, Local0)
                    Store (0x00, XPIR)
                    Return (Local0)
                }

                Method (XPWR, 2, NotSerialized)
                {
                    Store (Arg0, XPIR)
                    Store (Arg1, XPID)
                    Store (0x00, XPIR)
                }

                Method (XPRT, 0, NotSerialized)
                {
                    Store (XPRD (0xA2), Local0)
                    And (Local0, Not (0x07), Local0)
                    ShiftRight (Local0, 0x04, Local1)
                    And (Local1, 0x07, Local1)
                    Or (Local0, Local1, Local0)
                    Or (Local0, 0x0100, Local0)
                    XPWR (0xA2, Local0)
                }

                Method (XPLP, 1, NotSerialized)
                {
                    Store (0x8080, Local1)
                    Store (\_SB.PCI0.NBXR (0x00010065), Local2)
                    If (Arg0)
                    {
                        And (Local2, Not (Local1), Local2)
                    }
                    Else
                    {
                        Or (Local2, Local1, Local2)
                    }

                    \_SB.PCI0.NBXW (0x00010065, Local2)
                }

                Method (XPR2, 0, NotSerialized)
                {
                    Store (LKCN, Local0)
                    And (Local0, Not (0x20), Local0)
                    Store (Local0, LKCN)
                    Or (Local0, 0x20, Local0)
                    Store (Local0, LKCN)
                    Store (0x64, Local1)
                    Store (0x01, Local2)
                    While (LAnd (Local1, Local2))
                    {
                        Sleep (0x01)
                        Store (LKST, Local3)
                        If (And (Local3, 0x0800))
                        {
                            Decrement (Local1)
                        }
                        Else
                        {
                            Store (0x00, Local2)
                        }
                    }

                    And (Local0, Not (0x20), Local0)
                    Store (Local0, LKCN)
                    If (LNot (Local2))
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Device (NCRD)
                {
                    Name (_ADR, 0x00)
                    OperationRegion (PCFG, PCI_Config, 0x00, 0x08)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        PCMS,   32
                    }

                    Method (_RMV, 0, NotSerialized)
                    {
                        Return (0x01)
                    }
                }
            }

            Device (PB5)
            {
                Name (_ADR, 0x00050000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                \_SB.PCI0.LPC0.LNKB, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                \_SB.PCI0.LPC0.LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                \_SB.PCI0.LPC0.LNKD, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                \_SB.PCI0.LPC0.LNKA, 
                                0x00
                            }
                        })
                    }
                }
            }

            Device (PB6)
            {
                Name (_ADR, 0x00060000)
                Name (MPRW, Package (0x02)
                {
                    0x18, 
                    0x05
                })
                Method (_PRW, 0, NotSerialized)
                {
                    \_SB.QWMI.PHSR (0x11, 0x02)
                    Store (\_SB.PCI0.LPC0.OWNS, \_SB.QWMI.Q512)
                    If (LEqual (\_SB.PCI0.LPC0.WOLI, 0x00))
                    {
                        Store (0x00, Index (MPRW, 0x01))
                    }
                    Else
                    {
                        Store (0x05, Index (MPRW, 0x01))
                    }

                    Return (MPRW)
                }

                Method (_PSW, 1, NotSerialized)
                {
                    Store (Arg0, \_SB.PCI0.SMB.WOLE)
                    Store (Arg0, \_SB.PCI0.LPC0.PCIL)
                    If (LEqual (TPOS, 0x40))
                    {
                        Store (Arg0, \_SB.PCI0.SMB.WOLF)
                    }
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x11
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                \_SB.PCI0.LPC0.LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                \_SB.PCI0.LPC0.LNKD, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                \_SB.PCI0.LPC0.LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                \_SB.PCI0.LPC0.LNKB, 
                                0x00
                            }
                        })
                    }
                }
            }

            Device (PB4)
            {
                Name (_ADR, 0x00040000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                0x00, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                0x00, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                0x00, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                0x00, 
                                \_SB.PCI0.LPC0.LNKA, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x01, 
                                \_SB.PCI0.LPC0.LNKB, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                \_SB.PCI0.LPC0.LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                \_SB.PCI0.LPC0.LNKD, 
                                0x00
                            }
                        })
                    }
                }
            }

            Scope (\_GPE)
            {
                Method (_L18, 0, NotSerialized)
                {
                    Notify (\_SB.PCI0.PB4, 0x02)
                    Notify (\_SB.PCI0.PB6, 0x02)
                    Notify (\_SB.PCI0.PB7, 0x02)
                }
            }

            Device (OHC0)
            {
                Name (_ADR, 0x00120000)
                Name (_PRW, Package (0x02)
                {
                    0x0B, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (One, \_SB.PCI0.SMB.USRE)
                    }
                    Else
                    {
                        Store (Zero, \_SB.PCI0.SMB.USRE)
                    }
                }
            }

            Device (OHC1)
            {
                Name (_ADR, 0x00120001)
            }

            Device (OHC2)
            {
                Name (_ADR, 0x00130000)
                Name (_PRW, Package (0x02)
                {
                    0x0B, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (One, \_SB.PCI0.SMB.USRE)
                    }
                    Else
                    {
                        Store (Zero, \_SB.PCI0.SMB.USRE)
                    }
                }
            }

            Device (OHC3)
            {
                Name (_ADR, 0x00130001)
                Name (_PRW, Package (0x02)
                {
                    0x0B, 
                    0x04
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (One, \_SB.PCI0.SMB.USRE)
                    }
                    Else
                    {
                        Store (Zero, \_SB.PCI0.SMB.USRE)
                    }
                }
            }

            Device (EHC0)
            {
                Name (_ADR, 0x00120002)
            }

            Device (EHC1)
            {
                Name (_ADR, 0x00130002)
            }

            Device (SATA)
            {
                Name (_ADR, 0x00110000)
                Name (B5EN, 0x00)
                Name (BA_5, 0x00)
                Name (SBAR, 0xF0508000)
                OperationRegion (SATX, PCI_Config, 0x00, 0xC4)
                Field (SATX, AnyAcc, NoLock, Preserve)
                {
                    VIDI,   32, 
                            Offset (0x24), 
                    BA05,   32, 
                            Offset (0xC0), 
                    BL2E,   1, 
                            Offset (0xC1), 
                        ,   2, 
                    BS2E,   1
                }

                Method (GBAA, 0, Serialized)
                {
                    Store (BA05, BA_5)
                    If (LEqual (BA_5, 0xFFFFFFFF))
                    {
                        Store (0x00, B5EN)
                        Return (SBAR)
                    }
                    Else
                    {
                        Store (0x01, B5EN)
                        Return (BA_5)
                    }
                }

                OperationRegion (BAR5, SystemMemory, GBAA (), 0x1000)
                Field (BAR5, AnyAcc, NoLock, Preserve)
                {
                            Offset (0x120), 
                        ,   7, 
                    PMBY,   1, 
                            Offset (0x128), 
                    PMS0,   4, 
                            Offset (0x129), 
                    PMS1,   4, 
                            Offset (0x12C), 
                    DET0,   4, 
                            Offset (0x130), 
                            Offset (0x132), 
                    PRC0,   1, 
                            Offset (0x1A0), 
                        ,   7, 
                    SMBY,   1, 
                            Offset (0x1A8), 
                    SMS0,   4, 
                            Offset (0x1A9), 
                    SMS1,   4, 
                            Offset (0x1AC), 
                    DET1,   4, 
                            Offset (0x1B0), 
                            Offset (0x1B2), 
                    PRC1,   1, 
                            Offset (0x212), 
                        ,   7, 
                    PSPR,   1, 
                            Offset (0x219), 
                    PSCS,   5, 
                            Offset (0x21A), 
                        ,   2, 
                    PSHP,   1, 
                            Offset (0x220), 
                        ,   7, 
                    PSBY,   1, 
                    PSER,   1, 
                            Offset (0x228), 
                    PSS0,   4, 
                            Offset (0x229), 
                    PSS1,   4, 
                            Offset (0x22C), 
                    DET2,   4, 
                            Offset (0x230), 
                            Offset (0x232), 
                    PRC2,   1, 
                            Offset (0x2A0), 
                        ,   7, 
                    SSBY,   1, 
                            Offset (0x2A8), 
                    SSS0,   4, 
                            Offset (0x2A9), 
                    SSS1,   4, 
                            Offset (0x2AC), 
                    DET3,   4, 
                            Offset (0x2B0), 
                            Offset (0x2B2), 
                    PRC3,   1
                }

                Method (_INI, 0, NotSerialized)
                {
                    GBAA ()
                    \_GPE._L1F ()
                }

                Device (PRT0)
                {
                    Name (_ADR, 0xFFFF)
                    Method (_SDD, 1, NotSerialized)
                    {
                        GBAA ()
                    }

                    Name (CH0P, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        If (LAnd (LAnd (LNotEqual (TPOS, 0x40), LNotEqual (TPOS, 
                            0x04)), \_SB.PCI0.SATA.B5EN))
                        {
                            Store (0x32, Local0)
                            While (LAnd (LEqual (\_SB.PCI0.SATA.PMBY, 0x01), Local0))
                            {
                                Sleep (0xFA)
                                Decrement (Local0)
                            }
                        }

                        Store (0x00, CH0P)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Sleep (0x64)
                        Store (0x03, CH0P)
                    }

                    Method (_PSC, 0, NotSerialized)
                    {
                        Return (CH0P)
                    }
                }

                Device (PRT1)
                {
                    Name (_ADR, 0x0001FFFF)
                    Method (_SDD, 1, NotSerialized)
                    {
                        GBAA ()
                    }

                    Name (CH1P, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        If (LAnd (LAnd (LNotEqual (TPOS, 0x40), LNotEqual (TPOS, 
                            0x04)), \_SB.PCI0.SATA.B5EN))
                        {
                            Store (0x32, Local0)
                            While (LAnd (LEqual (\_SB.PCI0.SATA.SMBY, 0x01), Local0))
                            {
                                Sleep (0xFA)
                                Decrement (Local0)
                            }
                        }

                        Store (0x00, CH1P)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Sleep (0x64)
                        Store (0x03, CH1P)
                    }

                    Method (_PSC, 0, NotSerialized)
                    {
                        Return (CH1P)
                    }
                }

                Device (PRT2)
                {
                    Name (_ADR, 0x02)
                    Method (_RMV, 0, NotSerialized)
                    {
                        Sleep (0xC8)
                        If (PSS1)
                        {
                            Return (0x01)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Device (ESAT)
                    {
                        Name (_ADR, 0x00)
                        Method (_RMV, 0, NotSerialized)
                        {
                            Return (0x01)
                        }

                        Method (_SDD, 1, NotSerialized)
                        {
                            GBAA ()
                        }

                        Name (CH2P, 0x00)
                        Method (_PS0, 0, NotSerialized)
                        {
                            If (LAnd (LAnd (LNotEqual (TPOS, 0x40), LNotEqual (TPOS, 
                                0x04)), \_SB.PCI0.SATA.B5EN))
                            {
                                Store (0x32, Local0)
                                While (LAnd (LEqual (\_SB.PCI0.SATA.PSBY, 0x01), Local0))
                                {
                                    Sleep (0xFA)
                                    Decrement (Local0)
                                }
                            }

                            Store (0x00, CH2P)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            Sleep (0x64)
                            Store (0x03, CH2P)
                        }

                        Method (_PSC, 0, NotSerialized)
                        {
                            Return (CH2P)
                        }
                    }
                }

                Device (PRT3)
                {
                    Name (_ADR, 0x0003FFFF)
                    Method (_SDD, 1, NotSerialized)
                    {
                        GBAA ()
                    }

                    Name (CH3P, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        If (LAnd (LAnd (LNotEqual (TPOS, 0x40), LNotEqual (TPOS, 
                            0x04)), \_SB.PCI0.SATA.B5EN))
                        {
                            Store (0x32, Local0)
                            While (LAnd (LEqual (\_SB.PCI0.SATA.SSBY, 0x01), Local0))
                            {
                                Sleep (0xFA)
                                Decrement (Local0)
                            }
                        }

                        Store (0x00, CH3P)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Sleep (0x64)
                        Store (0x03, CH3P)
                    }

                    Method (_PSC, 0, NotSerialized)
                    {
                        Return (CH3P)
                    }
                }
            }

            Scope (\_GPE)
            {
                Method (_L1F, 0, NotSerialized)
                {
                    \_SB.PCI0.SATA.GBAA ()
                    If (\_SB.PCI0.SATA.B5EN)
                    {
                        If (Not (LEqual (\_SB.PCI0.SATA.PSS1, 0x00)))
                        {
                            Sleep (0x1E)
                        }

                        Notify (\_SB.PCI0.SATA.PRT2, 0x01)
                        Store (One, \_SB.PCI0.SATA.PRC2)
                    }
                }
            }

            Device (SMB)
            {
                Name (_ADR, 0x00140000)
                OperationRegion (Z00A, PCI_Config, 0x08, 0x0100)
                Field (Z00A, AnyAcc, NoLock, Preserve)
                {
                    RVID,   8, 
                            Offset (0x0C), 
                    HPBS,   32, 
                            Offset (0x5A), 
                    I1F,    1, 
                    I12F,   1, 
                        ,   2, 
                    MT3A,   1, 
                            Offset (0x5C), 
                        ,   10, 
                    HPET,   1, 
                            Offset (0xF0), 
                    EIDX,   8, 
                            Offset (0xF4), 
                    EDAT,   32
                }

                OperationRegion (WIDE, PCI_Config, 0xAD, 0x01)
                Field (WIDE, AnyAcc, NoLock, Preserve)
                {
                    DUM1,   4, 
                    SOPT,   1
                }

                OperationRegion (PMIO, SystemIO, 0x0CD6, 0x02)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    INPM,   8, 
                    DAPM,   8
                }

                IndexField (INPM, DAPM, ByteAcc, NoLock, Preserve)
                {
                        ,   1, 
                    TM1E,   1, 
                    TM2E,   1, 
                            Offset (0x01), 
                        ,   1, 
                    TM1S,   1, 
                    TM2S,   1, 
                            Offset (0x02), 
                        ,   1, 
                    IR9E,   1, 
                            Offset (0x04), 
                        ,   7, 
                    SLPS,   1, 
                        ,   1, 
                    IR9S,   1, 
                            Offset (0x07), 
                        ,   7, 
                    CLPS,   1, 
                            Offset (0x0D), 
                    EV0S,   1, 
                    EV1S,   1, 
                            Offset (0x10), 
                        ,   6, 
                    PWDE,   1, 
                            Offset (0x1C), 
                        ,   3, 
                    MKME,   1, 
                    PI3E,   1, 
                    PI2E,   1, 
                    PI1E,   1, 
                    PI0E,   1, 
                        ,   3, 
                    MKMS,   1, 
                    PI3S,   1, 
                    PI2S,   1, 
                    PI1S,   1, 
                    PI0S,   1, 
                            Offset (0x20), 
                    P1EB,   16, 
                            Offset (0x36), 
                        ,   5, 
                    GE5C,   1, 
                    GE6C,   1, 
                            Offset (0x37), 
                    EV0C,   1, 
                    EV1C,   1, 
                        ,   2, 
                    GM1C,   1, 
                    GM2C,   1, 
                    GM3C,   1, 
                            Offset (0x38), 
                        ,   1, 
                    GM4C,   1, 
                    GM5C,   1, 
                        ,   1, 
                    GM6C,   1, 
                            Offset (0x3A), 
                        ,   4, 
                    GM1S,   1, 
                    GM2S,   1, 
                    GM3S,   1, 
                            Offset (0x3B), 
                        ,   1, 
                    GM4S,   1, 
                    GM5S,   1, 
                        ,   1, 
                    GM6S,   1, 
                            Offset (0x55), 
                    SPRE,   1, 
                        ,   1, 
                        ,   1, 
                    EPNM,   1, 
                    DPPF,   1, 
                    FNGS,   1, 
                        ,   1, 
                    HIHP,   1, 
                            Offset (0x61), 
                        ,   7, 
                    R617,   1, 
                            Offset (0x65), 
                        ,   2, 
                    USRE,   1, 
                        ,   1, 
                    RSTU,   1, 
                            Offset (0x68), 
                        ,   3, 
                    TPDE,   1, 
                        ,   1, 
                            Offset (0x7C), 
                        ,   2, 
                    BLNK,   2, 
                            Offset (0x84), 
                    WOLE,   1, 
                        ,   2, 
                    WOLF,   1, 
                            Offset (0x86), 
                        ,   1, 
                    TDTY,   3, 
                    THTE,   1, 
                            Offset (0x92), 
                        ,   5, 
                    GE5S,   1, 
                    GE6S,   1, 
                            Offset (0x94), 
                    GP8O,   1, 
                    GP9O,   1, 
                    GP8E,   1, 
                    GP9E,   1, 
                    GP8I,   1, 
                    GP9I,   1, 
                    GP8L,   1, 
                    GP9L,   1, 
                            Offset (0x9A), 
                        ,   7, 
                    HECO,   1, 
                            Offset (0xA8), 
                    PI4E,   1, 
                    PI5E,   1, 
                    PI6E,   1, 
                    PI7E,   1, 
                            Offset (0xA9), 
                    PI4S,   1, 
                    PI5S,   1, 
                    PI6S,   1, 
                    PI7S,   1
                }

                OperationRegion (P1E0, SystemIO, P1EB, 0x04)
                Field (P1E0, ByteAcc, NoLock, Preserve)
                {
                        ,   14, 
                    PEWS,   1, 
                    WSTA,   1, 
                        ,   14, 
                    PEWD,   1
                }

                OperationRegion (GPIO, PCI_Config, 0x00, 0x0100)
                Field (GPIO, AnyAcc, NoLock, Preserve)
                {
                            Offset (0x50), 
                    G49O,   1, 
                    G50O,   1, 
                    G51O,   1, 
                    G52O,   1, 
                    G49E,   1, 
                    G50E,   1, 
                    G51E,   1, 
                    G52E,   1, 
                    MID2,   1, 
                            Offset (0x52), 
                    G53O,   1, 
                    G54O,   1, 
                    G55O,   1, 
                    G56O,   1, 
                    G53E,   1, 
                    G54E,   1, 
                    G55E,   1, 
                    G56E,   1, 
                            Offset (0x56), 
                        ,   3, 
                    G64O,   1, 
                        ,   3, 
                    G64E,   1, 
                            Offset (0x5A), 
                    G70O,   1, 
                    G71O,   1, 
                    G72O,   1, 
                    G73O,   1, 
                    G70E,   1, 
                    G71E,   1, 
                    G72E,   1, 
                    G73E,   1, 
                    G70S,   1, 
                    G71S,   1, 
                    G72S,   1, 
                    G73S,   1, 
                    G70F,   1, 
                    G71F,   1, 
                    G72F,   1, 
                    G73F,   1, 
                            Offset (0x7E), 
                        ,   1, 
                    G66O,   1, 
                        ,   3, 
                    G66E,   1, 
                            Offset (0x7F), 
                        ,   1, 
                            Offset (0x80), 
                        ,   3, 
                    G03O,   1, 
                        ,   3, 
                    G03E,   1, 
                        ,   3, 
                    MID4,   1, 
                            Offset (0x82), 
                    G13O,   1, 
                        ,   3, 
                    G13E,   1, 
                            Offset (0xA6), 
                        ,   3, 
                    G48O,   1, 
                        ,   3, 
                    G48E,   1, 
                        ,   3, 
                    MID3,   1, 
                            Offset (0xA8), 
                    GPO4,   1, 
                    G05O,   1, 
                        ,   1, 
                    G07O,   1, 
                    G08O,   1, 
                    G09O,   1, 
                            Offset (0xA9), 
                        ,   1, 
                    G05E,   1, 
                        ,   1, 
                    G07E,   1, 
                    G08E,   1, 
                    G09E,   1, 
                            Offset (0xAA), 
                        ,   1, 
                    LDET,   1, 
                    MID1,   1, 
                        ,   2, 
                    FMDT,   1, 
                            Offset (0xBC), 
                    G33O,   1, 
                    G34O,   1, 
                    G35O,   1, 
                    G36O,   1, 
                    G33E,   1, 
                    G34E,   1, 
                    G35E,   1, 
                    G36E,   1, 
                    G33S,   1, 
                    G34S,   1, 
                    G35S,   1, 
                    G36S,   1, 
                    G33F,   1, 
                    G34F,   1, 
                    G35F,   1, 
                    G36F,   1
                }

                Method (TRMD, 0, NotSerialized)
                {
                    Store (Zero, SPRE)
                    Store (Zero, TPDE)
                }

                Method (HTCD, 0, NotSerialized)
                {
                    Store (Zero, PI2E)
                    Store (Zero, TM2E)
                    Store (PI2S, PI2S)
                    Store (TM2S, TM2S)
                }
            }

            Device (IDE)
            {
                Name (_ADR, 0x00140001)
                Name (UDMT, Package (0x08)
                {
                    0x78, 
                    0x5A, 
                    0x3C, 
                    0x2D, 
                    0x1E, 
                    0x14, 
                    0x0F, 
                    0x00
                })
                Name (PIOT, Package (0x06)
                {
                    0x0258, 
                    0x0186, 
                    0x010E, 
                    0xB4, 
                    0x78, 
                    0x00
                })
                Name (PITR, Package (0x06)
                {
                    0x99, 
                    0x47, 
                    0x34, 
                    0x22, 
                    0x20, 
                    0x99
                })
                Name (MDMT, Package (0x04)
                {
                    0x01E0, 
                    0x96, 
                    0x78, 
                    0x00
                })
                Name (MDTR, Package (0x04)
                {
                    0x77, 
                    0x21, 
                    0x20, 
                    0xFF
                })
                OperationRegion (IDE, PCI_Config, 0x40, 0x20)
                Field (IDE, WordAcc, NoLock, Preserve)
                {
                    PPIT,   16, 
                    SPIT,   16, 
                    PMDT,   16, 
                    SMDT,   16, 
                    PPIC,   8, 
                    SPIC,   8, 
                    PPIM,   8, 
                    SPIM,   8, 
                            Offset (0x14), 
                    PUDC,   2, 
                    SUDC,   2, 
                            Offset (0x16), 
                    PUDM,   8, 
                    SUDM,   8
                }

                Method (ATPI, 1, NotSerialized)
                {
                    Store (Arg0, Local0)
                    And (Local0, 0xFF, Local0)
                    Or (Local0, 0x41544900, Local0)
                    Store (Local0, \_SB.PCI0.LPC0.INFO)
                }

                Method (GETT, 1, NotSerialized)
                {
                    Store (And (Arg0, 0x0F), Local0)
                    Store (ShiftRight (Arg0, 0x04), Local1)
                    Return (Multiply (0x1E, Add (Add (Local0, 0x01), Add (Local1, 
                        0x01))))
                }

                Method (GTM, 1, NotSerialized)
                {
                    CreateByteField (Arg0, 0x00, PIT1)
                    CreateByteField (Arg0, 0x01, PIT0)
                    CreateByteField (Arg0, 0x02, MDT1)
                    CreateByteField (Arg0, 0x03, MDT0)
                    CreateByteField (Arg0, 0x04, PICX)
                    CreateByteField (Arg0, 0x05, UDCX)
                    CreateByteField (Arg0, 0x06, UDMX)
                    Name (BUF, Buffer (0x14)
                    {
                        /* 0000 */    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
                        /* 0008 */    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
                        /* 0010 */    0x00, 0x00, 0x00, 0x00
                    })
                    CreateDWordField (BUF, 0x00, PIO0)
                    CreateDWordField (BUF, 0x04, DMA0)
                    CreateDWordField (BUF, 0x08, PIO1)
                    CreateDWordField (BUF, 0x0C, DMA1)
                    CreateDWordField (BUF, 0x10, FLAG)
                    If (And (PICX, 0x01))
                    {
                        Return (BUF)
                    }

                    Store (GETT (PIT0), PIO0)
                    Store (GETT (PIT1), PIO1)
                    If (And (UDCX, 0x01))
                    {
                        Or (FLAG, 0x01, FLAG)
                        Store (DerefOf (Index (^UDMT, And (UDMX, 0x0F))), DMA0)
                    }
                    Else
                    {
                        Store (GETT (MDT0), DMA0)
                    }

                    If (And (UDCX, 0x02))
                    {
                        Or (FLAG, 0x04, FLAG)
                        Store (DerefOf (Index (^UDMT, ShiftRight (UDMX, 0x04))), DMA1)
                    }
                    Else
                    {
                        Store (GETT (MDT1), DMA1)
                    }

                    Or (FLAG, 0x1A, FLAG)
                    Return (BUF)
                }

                Method (STM, 3, NotSerialized)
                {
                    CreateDWordField (Arg0, 0x00, PIO0)
                    CreateDWordField (Arg0, 0x04, DMA0)
                    CreateDWordField (Arg0, 0x08, PIO1)
                    CreateDWordField (Arg0, 0x0C, DMA1)
                    CreateDWordField (Arg0, 0x10, FLAG)
                    Name (BUF, Buffer (0x07)
                    {
                        0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00
                    })
                    CreateByteField (BUF, 0x00, PIT1)
                    CreateByteField (BUF, 0x01, PIT0)
                    CreateByteField (BUF, 0x02, MDT1)
                    CreateByteField (BUF, 0x03, MDT0)
                    CreateByteField (BUF, 0x04, PIMX)
                    CreateByteField (BUF, 0x05, UDCX)
                    CreateByteField (BUF, 0x06, UDMX)
                    Store (Match (^PIOT, MLE, PIO0, MTR, 0x00, 0x00), Local0)
                    Divide (Local0, 0x05, Local0)
                    Store (Match (^PIOT, MLE, PIO1, MTR, 0x00, 0x00), Local1)
                    Divide (Local1, 0x05, Local1)
                    Store (Or (ShiftLeft (Local1, 0x04), Local0), PIMX)
                    Store (DerefOf (Index (^PITR, Local0)), PIT0)
                    Store (DerefOf (Index (^PITR, Local1)), PIT1)
                    If (And (FLAG, 0x01))
                    {
                        Store (Match (^UDMT, MLE, DMA0, MTR, 0x00, 0x00), Local0)
                        Divide (Local0, 0x07, Local0)
                        Or (UDMX, Local0, UDMX)
                        Or (UDCX, 0x01, UDCX)
                    }
                    Else
                    {
                        If (LNotEqual (DMA0, 0xFFFFFFFF))
                        {
                            Store (Match (^MDMT, MLE, DMA0, MTR, 0x00, 0x00), Local0)
                            Store (DerefOf (Index (^MDTR, Local0)), MDT0)
                        }
                    }

                    If (And (FLAG, 0x04))
                    {
                        Store (Match (^UDMT, MLE, DMA1, MTR, 0x00, 0x00), Local0)
                        Divide (Local0, 0x07, Local0)
                        Or (UDMX, ShiftLeft (Local0, 0x04), UDMX)
                        Or (UDCX, 0x02, UDCX)
                    }
                    Else
                    {
                        If (LNotEqual (DMA1, 0xFFFFFFFF))
                        {
                            Store (Match (^MDMT, MLE, DMA1, MTR, 0x00, 0x00), Local0)
                            Store (DerefOf (Index (^MDTR, Local0)), MDT1)
                        }
                    }

                    Return (BUF)
                }

                Method (GTF, 2, NotSerialized)
                {
                    CreateByteField (Arg1, 0x00, MDT1)
                    CreateByteField (Arg1, 0x01, MDT0)
                    CreateByteField (Arg1, 0x02, PIMX)
                    CreateByteField (Arg1, 0x03, UDCX)
                    CreateByteField (Arg1, 0x04, UDMX)
                    If (LEqual (Arg0, 0xA0))
                    {
                        Store (And (PIMX, 0x0F), Local0)
                        Store (MDT0, Local1)
                        And (UDCX, 0x01, Local2)
                        Store (And (UDMX, 0x0F), Local3)
                    }
                    Else
                    {
                        Store (ShiftRight (PIMX, 0x04), Local0)
                        Store (MDT1, Local1)
                        And (UDCX, 0x02, Local2)
                        Store (ShiftRight (UDMX, 0x04), Local3)
                    }

                    Name (BUF, Buffer (0x15)
                    {
                        /* 0000 */    0x03, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xEF, 0x03, 
                        /* 0008 */    0x00, 0x00, 0x00, 0x00, 0xFF, 0xEF, 0x00, 0x00, 
                        /* 0010 */    0x00, 0x00, 0x00, 0x00, 0xF5
                    })
                    CreateByteField (BUF, 0x01, PMOD)
                    CreateByteField (BUF, 0x08, DMOD)
                    CreateByteField (BUF, 0x05, CMDA)
                    CreateByteField (BUF, 0x0C, CMDB)
                    CreateByteField (BUF, 0x13, CMDC)
                    Store (Arg0, CMDA)
                    Store (Arg0, CMDB)
                    Store (Arg0, CMDC)
                    Or (Local0, 0x08, PMOD)
                    If (Local2)
                    {
                        Or (Local3, 0x40, DMOD)
                    }
                    Else
                    {
                        Store (Match (^MDMT, MLE, GETT (Local1), MTR, 0x00, 0x00), Local4)
                        If (LLess (Local4, 0x03))
                        {
                            Or (0x20, Local4, DMOD)
                        }
                    }

                    Return (BUF)
                }

                Device (PRID)
                {
                    Name (_ADR, 0x00)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Name (BUF, Buffer (0x07)
                        {
                            0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00
                        })
                        CreateWordField (BUF, 0x00, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIC)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        If (\_SB.PCI0.SMB.SOPT)
                        {
                            Store (^^PPIT, VPIT)
                            Store (^^PMDT, VMDT)
                            Store (^^PPIC, VPIC)
                            Store (^^PUDC, VUDC)
                            Store (^^PUDM, VUDM)
                        }
                        Else
                        {
                            Store (^^SPIT, VPIT)
                            Store (^^SMDT, VMDT)
                            Store (^^SPIC, VPIC)
                            Store (^^SUDC, VUDC)
                            Store (^^SUDM, VUDM)
                        }

                        Return (GTM (BUF))
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Name (BUF, Buffer (0x07)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                        CreateWordField (BUF, 0x00, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIM)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        Store (STM (Arg0, Arg1, Arg2), BUF)
                        If (\_SB.PCI0.SMB.SOPT)
                        {
                            Store (VPIT, ^^PPIT)
                            Store (VMDT, ^^PMDT)
                            Store (VPIM, ^^PPIM)
                            Store (VUDC, ^^PUDC)
                            Store (VUDM, ^^PUDM)
                        }
                        Else
                        {
                            Store (VPIT, ^^SPIT)
                            Store (VMDT, ^^SMDT)
                            Store (VPIM, ^^SPIM)
                            Store (VUDC, ^^SUDC)
                            Store (VUDM, ^^SUDM)
                        }
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                0x00, 0x00, 0x00, 0x00, 0x00
                            })
                            CreateWordField (BUF, 0x00, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            If (\_SB.PCI0.SMB.SOPT)
                            {
                                Store (^^^PMDT, VMDT)
                                Store (^^^PPIM, VPIM)
                                Store (^^^PUDC, VUDC)
                                Store (^^^PUDM, VUDM)
                            }
                            Else
                            {
                                Store (^^^SMDT, VMDT)
                                Store (^^^SPIM, VPIM)
                                Store (^^^SUDC, VUDC)
                                Store (^^^SUDM, VUDM)
                            }

                            Return (GTF (0xA0, BUF))
                        }
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                0x00, 0x00, 0x00, 0x00, 0x00
                            })
                            CreateWordField (BUF, 0x00, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            If (\_SB.PCI0.SMB.SOPT)
                            {
                                Store (^^^PMDT, VMDT)
                                Store (^^^PPIM, VPIM)
                                Store (^^^PUDC, VUDC)
                                Store (^^^PUDM, VUDM)
                            }
                            Else
                            {
                                Store (^^^SMDT, VMDT)
                                Store (^^^SPIM, VPIM)
                                Store (^^^SUDC, VUDC)
                                Store (^^^SUDM, VUDM)
                            }

                            Return (GTF (0xB0, BUF))
                        }
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        And (PPIC, 0x01, Local0)
                        If (LAnd (Local0, 0x01))
                        {
                            Return (Z008)
                        }
                        Else
                        {
                            Return (Z005)
                        }
                    }
                }

                Device (SECD)
                {
                    Name (_ADR, 0x01)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Name (BUF, Buffer (0x07)
                        {
                            0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00
                        })
                        CreateWordField (BUF, 0x00, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIC)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        If (LGreaterEqual (\_SB.PCI0.SMB.RVID, 0x3A))
                        {
                            If (\_SB.PCI0.SMB.SOPT)
                            {
                                Store (^^PPIT, VPIT)
                                Store (^^PMDT, VMDT)
                                Store (^^PPIC, VPIC)
                                Store (^^PUDC, VUDC)
                                Store (^^PUDM, VUDM)
                            }
                            Else
                            {
                                Store (^^SPIT, VPIT)
                                Store (^^SMDT, VMDT)
                                Store (^^SPIC, VPIC)
                                Store (^^SUDC, VUDC)
                                Store (^^SUDM, VUDM)
                            }
                        }
                        Else
                        {
                            If (\_SB.PCI0.SMB.SOPT)
                            {
                                Store (^^SPIT, VPIT)
                                Store (^^SMDT, VMDT)
                                Store (^^SPIC, VPIC)
                                Store (^^SUDC, VUDC)
                                Store (^^SUDM, VUDM)
                            }
                            Else
                            {
                                Store (^^PPIT, VPIT)
                                Store (^^PMDT, VMDT)
                                Store (^^PPIC, VPIC)
                                Store (^^PUDC, VUDC)
                                Store (^^PUDM, VUDM)
                            }
                        }

                        Return (GTM (BUF))
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Name (BUF, Buffer (0x07)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                        })
                        CreateWordField (BUF, 0x00, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIM)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        Store (STM (Arg0, Arg1, Arg2), BUF)
                        If (LGreaterEqual (\_SB.PCI0.SMB.RVID, 0x3A))
                        {
                            If (\_SB.PCI0.SMB.SOPT)
                            {
                                Store (VPIT, ^^PPIT)
                                Store (VMDT, ^^PMDT)
                                Store (VPIM, ^^PPIM)
                                Store (VUDC, ^^PUDC)
                                Store (VUDM, ^^PUDM)
                            }
                            Else
                            {
                                Store (VPIT, ^^SPIT)
                                Store (VMDT, ^^SMDT)
                                Store (VPIM, ^^SPIM)
                                Store (VUDC, ^^SUDC)
                                Store (VUDM, ^^SUDM)
                            }
                        }
                        Else
                        {
                            If (\_SB.PCI0.SMB.SOPT)
                            {
                                Store (VPIT, ^^SPIT)
                                Store (VMDT, ^^SMDT)
                                Store (VPIM, ^^SPIM)
                                Store (VUDC, ^^SUDC)
                                Store (VUDM, ^^SUDM)
                            }
                            Else
                            {
                                Store (VPIT, ^^PPIT)
                                Store (VMDT, ^^PMDT)
                                Store (VPIM, ^^PPIM)
                                Store (VUDC, ^^PUDC)
                                Store (VUDM, ^^PUDM)
                            }
                        }
                    }

                    Device (S_D0)
                    {
                        Name (_ADR, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                0x00, 0x00, 0x00, 0x00, 0x00
                            })
                            CreateWordField (BUF, 0x00, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            If (LGreaterEqual (\_SB.PCI0.SMB.RVID, 0x3A))
                            {
                                If (\_SB.PCI0.SMB.SOPT)
                                {
                                    Store (^^^PMDT, VMDT)
                                    Store (^^^PPIM, VPIM)
                                    Store (^^^PUDC, VUDC)
                                    Store (^^^PUDM, VUDM)
                                }
                                Else
                                {
                                    Store (^^^SMDT, VMDT)
                                    Store (^^^SPIM, VPIM)
                                    Store (^^^SUDC, VUDC)
                                    Store (^^^SUDM, VUDM)
                                }
                            }
                            Else
                            {
                                If (\_SB.PCI0.SMB.SOPT)
                                {
                                    Store (^^^SMDT, VMDT)
                                    Store (^^^SPIM, VPIM)
                                    Store (^^^SUDC, VUDC)
                                    Store (^^^SUDM, VUDM)
                                }
                                Else
                                {
                                    Store (^^^PMDT, VMDT)
                                    Store (^^^PPIM, VPIM)
                                    Store (^^^PUDC, VUDC)
                                    Store (^^^PUDM, VUDM)
                                }
                            }

                            Return (GTF (0xA0, BUF))
                        }
                    }

                    Device (S_D1)
                    {
                        Name (_ADR, 0x01)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                0x00, 0x00, 0x00, 0x00, 0x00
                            })
                            CreateWordField (BUF, 0x00, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            If (LGreaterEqual (\_SB.PCI0.SMB.RVID, 0x3A))
                            {
                                If (\_SB.PCI0.SMB.SOPT)
                                {
                                    Store (^^^PMDT, VMDT)
                                    Store (^^^PPIM, VPIM)
                                    Store (^^^PUDC, VUDC)
                                    Store (^^^PUDM, VUDM)
                                }
                                Else
                                {
                                    Store (^^^SMDT, VMDT)
                                    Store (^^^SPIM, VPIM)
                                    Store (^^^SUDC, VUDC)
                                    Store (^^^SUDM, VUDM)
                                }
                            }
                            Else
                            {
                                If (\_SB.PCI0.SMB.SOPT)
                                {
                                    Store (^^^SMDT, VMDT)
                                    Store (^^^SPIM, VPIM)
                                    Store (^^^SUDC, VUDC)
                                    Store (^^^SUDM, VUDM)
                                }
                                Else
                                {
                                    Store (^^^PMDT, VMDT)
                                    Store (^^^PPIM, VPIM)
                                    Store (^^^PUDC, VUDC)
                                    Store (^^^PUDM, VUDM)
                                }
                            }

                            Return (GTF (0xB0, BUF))
                        }
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        And (SPIC, 0x01, Local0)
                        If (LAnd (Local0, 0x01))
                        {
                            Return (Z008)
                        }
                        Else
                        {
                            Return (Z005)
                        }
                    }
                }
            }

            Device (HDAU)
            {
                Name (_ADR, 0x00140002)
                Name (_PRW, Package (0x02)
                {
                    0x1B, 
                    0x03
                })
            }

            Device (LPC0)
            {
                Name (_ADR, 0x00140003)
                Mutex (PSMX, 0x00)
                OperationRegion (PIRQ, SystemIO, 0x0C00, 0x02)
                Field (PIRQ, ByteAcc, NoLock, Preserve)
                {
                    PIID,   8, 
                    PIDA,   8
                }

                IndexField (PIID, PIDA, ByteAcc, NoLock, Preserve)
                {
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    PIRS,   8, 
                            Offset (0x09), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8
                }

                Name (IPRS, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {10,11}
                })
                Name (UPRS, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Exclusive, )
                        {3,4,5,7}
                })
                Method (DSPI, 0, NotSerialized)
                {
                    Store (0x00, PIRA)
                    Store (0x00, PIRB)
                    Store (0x00, PIRC)
                    Store (0x00, PIRD)
                    Store (0x00, PIRE)
                    Store (0x00, PIRF)
                    Store (0x00, PIRG)
                    Store (0x00, PIRH)
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRA)
                        {
                            Return (Z007)
                        }
                        Else
                        {
                            Return (Z008)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRA)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRQ0)
                        ShiftLeft (0x01, PIRA, IRQ0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRA)
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRB)
                        {
                            Return (Z007)
                        }
                        Else
                        {
                            Return (Z008)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRB)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRQ0)
                        ShiftLeft (0x01, PIRB, IRQ0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRB)
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRC)
                        {
                            Return (Z007)
                        }
                        Else
                        {
                            Return (Z008)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRC)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRQ0)
                        ShiftLeft (0x01, PIRC, IRQ0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRC)
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRD)
                        {
                            Return (Z007)
                        }
                        Else
                        {
                            Return (Z008)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRD)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRQ0)
                        ShiftLeft (0x01, PIRD, IRQ0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRD)
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRE)
                        {
                            Return (Z007)
                        }
                        Else
                        {
                            Return (Z008)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRE)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRQ0)
                        ShiftLeft (0x01, PIRE, IRQ0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRE)
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRF)
                        {
                            Return (Z007)
                        }
                        Else
                        {
                            Return (Z008)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRF)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRQ0)
                        ShiftLeft (0x01, PIRF, IRQ0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRF)
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRG)
                        {
                            Return (Z007)
                        }
                        Else
                        {
                            Return (Z008)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRG)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRQ0)
                        ShiftLeft (0x01, PIRG, IRQ0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRG)
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (PIRH)
                        {
                            Return (Z007)
                        }
                        Else
                        {
                            Return (Z008)
                        }
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (IPRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (0x00, PIRH)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (IPRS, Local0)
                        CreateWordField (Local0, 0x01, IRQ0)
                        ShiftLeft (0x01, PIRH, IRQ0)
                        Return (Local0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PIRH)
                    }
                }

                OperationRegion (LCLM, SystemIO, 0x0C50, 0x03)
                Field (LCLM, ByteAcc, NoLock, Preserve)
                {
                    CLMI,   8, 
                    CLMD,   8, 
                    CLGP,   8
                }

                IndexField (CLMI, CLMD, ByteAcc, NoLock, Preserve)
                {
                    IDRG,   8, 
                            Offset (0x02), 
                    TSTS,   8, 
                    TINT,   8, 
                            Offset (0x12), 
                    I2CC,   8, 
                    GPIO,   8
                }

                Method (RGPM, 0, NotSerialized)
                {
                    Store (\_SB.PCI0.LPC0.GPIO, Local0)
                    And (Local0, Not (0xC0), Local0)
                    Store (Local0, \_SB.PCI0.LPC0.GPIO)
                    Store (\_SB.PCI0.LPC0.CLGP, Local1)
                    Return (Local1)
                }

                OperationRegion (LPCR, PCI_Config, 0x44, 0x08)
                Field (LPCR, ByteAcc, NoLock, Preserve)
                {
                    CMA0,   1, 
                    CMA1,   1, 
                    CMA2,   1, 
                    CMA3,   1, 
                    CMA4,   1, 
                    CMA5,   1, 
                    CMA6,   1, 
                    CMA7,   1, 
                    CMB0,   1, 
                    CMB1,   1, 
                    CMB2,   1, 
                    CMB3,   1, 
                    CMB4,   1, 
                    CMB5,   1, 
                    CMB6,   1, 
                    CMB7,   1, 
                            Offset (0x07), 
                    Z00B,   1
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x0F,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {13}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {2}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {8}
                    })
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                }

                Device (TIME)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {0}
                    })
                }

                Device (KBC0)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {1}
                    })
                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.SMB.MID2)
                        {
                            Sleep (0x01F4)
                        }
                        Else
                        {
                            Sleep (0x012C)
                        }

                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }
                }

                Device (MSE0)
                {
                    Name (_HID, EisaId ("SYN1020"))
                    Name (_CID, Package (0x03)
                    {
                        EisaId ("SYN1000"), 
                        EisaId ("SYN0002"), 
                        EisaId ("PNP0F13")
                    })
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {12}
                    })
                    Method (_PSW, 1, NotSerialized)
                    {
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.LPC0.TPDV, 0x00))
                        {
                            Return (0x0F)
                        }

                        Return (0x00)
                    }
                }

                Device (MSE1)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {12}
                    })
                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IRQNoFlags ()
                                {12}
                        }
                        EndDependentFn ()
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.LPC0.TPDV, 0x01))
                        {
                            Return (0x0F)
                        }

                        Return (0x00)
                    }
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0022,             // Range Minimum
                            0x0022,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0068,             // Range Minimum
                            0x0068,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x006C,             // Range Minimum
                            0x006C,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0220,             // Range Minimum
                            0x0220,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x040B,             // Range Minimum
                            0x040B,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D6,             // Range Minimum
                            0x04D6,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0530,             // Range Minimum
                            0x0530,             // Range Maximum
                            0x08,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0C00,             // Range Minimum
                            0x0C00,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0C14,             // Range Minimum
                            0x0C14,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C50,             // Range Minimum
                            0x0C50,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0C6C,             // Range Minimum
                            0x0C6C,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C6F,             // Range Minimum
                            0x0C6F,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0CD0,             // Range Minimum
                            0x0CD0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0CD2,             // Range Minimum
                            0x0CD2,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0CD4,             // Range Minimum
                            0x0CD4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0CD6,             // Range Minimum
                            0x0CD6,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0CD8,             // Range Minimum
                            0x0CD8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x8000,             // Range Minimum
                            0x8000,             // Range Maximum
                            0x01,               // Alignment
                            0x60,               // Length
                            )
                        IO (Decode16,
                            0x00B2,             // Range Minimum
                            0x00B2,             // Range Maximum
                            0x01,               // Alignment
                            0x0E,               // Length
                            )
                        WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                            0x0000,             // Granularity
                            0x8100,             // Range Minimum
                            0x81FF,             // Range Maximum
                            0x0000,             // Translation Offset
                            0x0100,             // Length
                            ,, , TypeStatic)
                        WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                            0x0000,             // Granularity
                            0x8200,             // Range Minimum
                            0x82FF,             // Range Maximum
                            0x0000,             // Translation Offset
                            0x0100,             // Length
                            ,, , TypeStatic)
                        IO (Decode16,
                            0x0F40,             // Range Minimum
                            0x0F40,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x087F,             // Range Minimum
                            0x087F,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (MSRC, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x000E0000,         // Address Base
                            0x00020000,         // Address Length
                            )
                        Memory32Fixed (ReadOnly,
                            0xFFF00000,         // Address Base
                            0x00100000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y1C)
                        Memory32Fixed (ReadOnly,
                            0xFF800000,         // Address Base
                            0x00010000,         // Address Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (MSRC, \_SB.PCI0.LPC0.MEM._Y1C._BAS, BARX)
                        CreateDWordField (MSRC, \_SB.PCI0.LPC0.MEM._Y1C._LEN, GALN)
                        Store (\_SB.PCI0.Z009, Local0)
                        If (Local0)
                        {
                            Store (0x1000, GALN)
                            And (Local0, 0xFFFFFFF0, BARX)
                        }

                        Return (MSRC)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                OperationRegion (SMI0, SystemIO, 0x00000F40, 0x00000002)
                Field (SMI0, AnyAcc, NoLock, Preserve)
                {
                    SMIC,   8
                }

                OperationRegion (SMI1, SystemMemory, 0xCDEDDBBD, 0x00000340)
                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    BCMD,   8, 
                    DID,    32, 
                    INFO,   1024
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                            AccessAs (ByteAcc, 0x00), 
                            Offset (0x05), 
                    INF,    8
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                            Offset (0x05), 
                    PAR0,   16, 
                    PAR1,   16, 
                    PAR2,   16, 
                    PAR3,   16
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                            Offset (0x50), 
                    BLK0,   32, 
                    BLK1,   32, 
                    BLK2,   32, 
                    BLK3,   32, 
                    BLK4,   32, 
                    BLK5,   32, 
                            Offset (0x110), 
                    BTEN,   1, 
                    WLAN,   1, 
                    WN3G,   1, 
                    ENSR,   2, 
                    CCDE,   1, 
                    DACB,   1, 
                    TPDV,   1, 
                    WOLI,   1, 
                    CIRE,   1, 
                    FGPE,   1, 
                    HDME,   1, 
                    CPUD,   1, 
                    PCIL,   1, 
                            Offset (0x113), 
                    PSTM,   8, 
                    PSTC,   8, 
                            Offset (0x120), 
                    OWNS,   4096, 
                    DVDI,   160
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                            AccessAs (ByteAcc, 0x00), 
                            Offset (0x120), 
                    OWN0,   8, 
                    OWN1,   8
                }

                Method (PHSR, 2, NotSerialized)
                {
                    Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                    Store (0x9F, BCMD)
                    Store (Arg0, DID)
                    Store (Arg1, INF)
                    Store (Zero, SMIC)
                    Store (INF, Local0)
                    Release (\_SB.PCI0.LPC0.PSMX)
                    Return (Local0)
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Name (_GPE, 0x03)
                    Name (SEL0, 0xF0)
                    Name (BFLG, 0x00)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, Local0)
                            If (Local0)
                            {
                                Store (0x01, ECOK)
                            }
                            Else
                            {
                                Store (0x00, ECOK)
                            }
                        }

                        If (\_SB.ECOK)
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Store (\TMOD, \_SB.PCI0.LPC0.EC0.TMOD)
                            If (LEqual (TPOS, 0x40))
                            {
                                Store (One, \_SB.PCI0.LPC0.EC0.OSTP)
                            }
                            Else
                            {
                                Store (Zero, \_SB.PCI0.LPC0.EC0.OSTP)
                            }

                            Store (0x03, \_SB.PCI0.LPC0.EC0.RG59)
                            Store (\_SB.PCI0.LPC0.BTEN, \_SB.PCI0.LPC0.EC0.BLTH)
                            Store (\_SB.PCI0.LPC0.WLAN, \_SB.PCI0.LPC0.EC0.WLAN)
                            Store (0x01, \_SB.PCI0.LPC0.EC0.CPLE)
                            Store (\_SB.PCI0.LPC0.PHSR (0x03, 0x00), DOFF)
                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                        }
                    }

                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x04), 
                        CMCM,   8, 
                        CMD1,   8, 
                        CMD2,   8, 
                        CMD3,   8, 
                                Offset (0x18), 
                        SMPR,   8, 
                        SMST,   8, 
                        SMAD,   8, 
                        SMCM,   8, 
                        SMD0,   256, 
                        BCNT,   8, 
                        SMAA,   8, 
                        BATD,   16, 
                        ACDF,   1, 
                            ,   1, 
                        PFLG,   1, 
                                Offset (0x41), 
                            ,   4, 
                        FPR1,   1, 
                        FLS4,   1, 
                        S5LW,   1, 
                                Offset (0x42), 
                                Offset (0x43), 
                        TMSS,   2, 
                            ,   2, 
                        BANK,   3, 
                        WLID,   1, 
                                Offset (0x45), 
                        VFAN,   1, 
                                Offset (0x46), 
                        RL01,   1, 
                        RD01,   1, 
                        RF01,   1, 
                        RP01,   1, 
                        RB01,   1, 
                        RC01,   1, 
                            ,   1, 
                        R701,   1, 
                        R801,   1, 
                        RM01,   1, 
                        RI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        RA01,   1, 
                        RR01,   1, 
                        RL10,   1, 
                        RD10,   1, 
                        RF10,   1, 
                        RP10,   1, 
                        RB10,   1, 
                        RC10,   1, 
                            ,   1, 
                        R710,   1, 
                        R810,   1, 
                        RM10,   1, 
                        RI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        RA10,   1, 
                        RR10,   1, 
                            ,   1, 
                        BAYE,   1, 
                        PRDE,   1, 
                        WP01,   1, 
                        WB01,   1, 
                        WC01,   1, 
                            ,   1, 
                        W701,   1, 
                        W801,   1, 
                        WM01,   1, 
                        WI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA01,   1, 
                        WR01,   1, 
                        LIDS,   1, 
                        BAYI,   1, 
                        PRCT,   1, 
                        WP10,   1, 
                        WB10,   1, 
                        WC10,   1, 
                            ,   1, 
                        W710,   1, 
                        W810,   1, 
                        WM10,   1, 
                        WI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA10,   1, 
                        WR10,   1, 
                                Offset (0x51), 
                        BLVL,   8, 
                                Offset (0x53), 
                        DOFF,   8, 
                                Offset (0x57), 
                        RG57,   8, 
                        CTMP,   8, 
                        RG59,   8, 
                        RG5A,   8, 
                        RG5B,   8, 
                        FSPD,   16, 
                                Offset (0x60), 
                        WLAN,   1, 
                        BLTH,   1, 
                        CPLE,   1, 
                        KSWH,   1, 
                            ,   2, 
                        RFST,   1, 
                        BTHE,   1, 
                        TPAD,   1, 
                            ,   1, 
                        WN3G,   1, 
                        USBP,   1, 
                            ,   1, 
                        W3GE,   1, 
                                Offset (0x63), 
                            ,   7, 
                        VGAF,   1, 
                                Offset (0x65), 
                            ,   1, 
                        TMOD,   1, 
                                Offset (0x70), 
                        BTMD,   8, 
                        MBTS,   1, 
                        MBTF,   1, 
                                Offset (0x72), 
                        MBTC,   1, 
                            ,   2, 
                        LION,   1, 
                                Offset (0x74), 
                            ,   3, 
                        BA3C,   1, 
                                Offset (0x77), 
                        BA1C,   8, 
                                Offset (0x7E), 
                        MCUR,   16, 
                        MBRM,   16, 
                        MBVG,   16, 
                                Offset (0x87), 
                        BA2C,   8, 
                        LFCC,   16, 
                        BTSN,   16, 
                        BTDC,   16, 
                                Offset (0x90), 
                        BTMN,   8, 
                                Offset (0x93), 
                        BTST,   8, 
                                Offset (0xA0), 
                        ABMD,   8, 
                        ABTS,   1, 
                        ABFC,   1, 
                            ,   3, 
                        ABBL,   1, 
                        Z00C,   1, 
                        ABCT,   1, 
                        ABCG,   1, 
                            ,   2, 
                        ABTP,   1, 
                                Offset (0xAE), 
                        ABCR,   16, 
                        ABRM,   16, 
                        ABVG,   16, 
                                Offset (0xB8), 
                        AFCC,   16, 
                        ABSN,   16, 
                        ABDC,   16, 
                                Offset (0xC0), 
                        ABMN,   8, 
                                Offset (0xD0), 
                        EBPL,   1, 
                                Offset (0xD1), 
                        PWRE,   1, 
                                Offset (0xD2), 
                            ,   6, 
                        VAUX,   1, 
                                Offset (0xD4), 
                        S3WT,   1, 
                            ,   3, 
                        WS3W,   1, 
                                Offset (0xD6), 
                        DBPL,   8, 
                                Offset (0xDE), 
                        PLID,   8, 
                                Offset (0xE0), 
                        DESP,   8, 
                                Offset (0xE2), 
                        DE0L,   8, 
                        DE0H,   8, 
                        DE1L,   8, 
                        DE1H,   8, 
                        DE2L,   8, 
                        DE2H,   8, 
                        DE3L,   8, 
                        DE3H,   8, 
                        DE4L,   8, 
                        DE4H,   8, 
                        DE5L,   8, 
                        DE5H,   8, 
                                Offset (0xEF), 
                        DALB,   8, 
                        OSTP,   1, 
                        CIRF,   1, 
                            ,   4, 
                        HEUE,   1, 
                        BEUE,   1, 
                        MBEV,   8, 
                        VEVT,   16, 
                        FEVT,   16, 
                        NEVT,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x1C), 
                        SMW0,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x1C), 
                        SMB0,   8
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x1C), 
                        FLD0,   64
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x1C), 
                        FLD1,   128
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x1C), 
                        FLD2,   192
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x1C), 
                        FLD3,   256
                    }

                    Mutex (MUT1, 0x00)
                    Mutex (MUT0, 0x00)
                    Method (SMRD, 4, NotSerialized)
                    {
                        If (LEqual (\_SB.ECOK, 0x00))
                        {
                            Return (0xFF)
                        }

                        If (LNotEqual (Arg0, 0x07))
                        {
                            If (LNotEqual (Arg0, 0x09))
                            {
                                If (LNotEqual (Arg0, 0x0B))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (0x00, Local3)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                                Increment (Local3)
                                If (LEqual (Local3, 0x32))
                                {
                                    And (SMST, 0x40, SMST)
                                    Store (Arg2, SMCM)
                                    Store (Arg1, SMAD)
                                    Store (Arg0, SMPR)
                                    Store (0x00, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x07))
                            {
                                Store (SMB0, Arg3)
                            }

                            If (LEqual (Arg0, 0x09))
                            {
                                Store (SMW0, Arg3)
                            }

                            If (LEqual (Arg0, 0x0B))
                            {
                                Store (BCNT, Local3)
                                ShiftRight (0x0100, 0x03, Local2)
                                If (LGreater (Local3, Local2))
                                {
                                    Store (Local2, Local3)
                                }

                                If (LLess (Local3, 0x09))
                                {
                                    Store (FLD0, Local2)
                                }
                                Else
                                {
                                    If (LLess (Local3, 0x11))
                                    {
                                        Store (FLD1, Local2)
                                    }
                                    Else
                                    {
                                        If (LLess (Local3, 0x19))
                                        {
                                            Store (FLD2, Local2)
                                        }
                                        Else
                                        {
                                            Store (FLD3, Local2)
                                        }
                                    }
                                }

                                Increment (Local3)
                                Store (Buffer (Local3) {}, Local4)
                                Decrement (Local3)
                                Store (Zero, Local5)
                                While (LGreater (Local3, Local5))
                                {
                                    GBFE (Local2, Local5, RefOf (Local6))
                                    PBFE (Local4, Local5, Local6)
                                    Increment (Local5)
                                }

                                PBFE (Local4, Local5, 0x00)
                                Store (Local4, Arg3)
                            }
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
                        If (LEqual (\_SB.ECOK, 0x00))
                        {
                            Return (0xFF)
                        }

                        If (LNotEqual (Arg0, 0x06))
                        {
                            If (LNotEqual (Arg0, 0x08))
                            {
                                If (LNotEqual (Arg0, 0x0A))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            If (LEqual (Arg0, 0x06))
                            {
                                Store (Arg3, SMB0)
                            }

                            If (LEqual (Arg0, 0x08))
                            {
                                Store (Arg3, SMW0)
                            }

                            If (LEqual (Arg0, 0x0A))
                            {
                                Store (Arg3, SMD0)
                            }

                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (0x00, Local3)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                                Increment (Local3)
                                If (LEqual (Local3, 0x32))
                                {
                                    And (SMST, 0x40, SMST)
                                    Store (Arg2, SMCM)
                                    Store (Arg1, SMAD)
                                    Store (Arg0, SMPR)
                                    Store (0x00, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (APOL, 1, NotSerialized)
                    {
                        Store (Arg0, DBPL)
                        Store (0x01, EBPL)
                    }

                    Name (PSTA, 0x00)
                    Method (CPOL, 1, NotSerialized)
                    {
                        If (LEqual (PSTA, 0x00))
                        {
                            If (LNotEqual (\_SB.ECOK, 0x00))
                            {
                                APOL (Arg0)
                                Store (0x01, PSTA)
                            }
                        }
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        Store (0x20, P80H)
                        If (\_SB.ECOK)
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            If (And (SMST, 0x40))
                            {
                                Store (SMAA, Local0)
                                If (LEqual (Local0, 0x14))
                                {
                                    And (SMST, 0xBF, SMST)
                                    Store (PWRE, Local1)
                                    If (Local1)
                                    {
                                        Store (0x00, PWRE)
                                        Store (0x12, BFLG)
                                        CPOL (0x01)
                                    }
                                }

                                If (LEqual (Local0, 0x16))
                                {
                                    And (SMST, 0xBF, SMST)
                                    Store (0x04, \_SB.BAT1.BCRI)
                                    Notify (\_SB.BAT1, 0x80)
                                }
                                Else
                                {
                                    Store (0x00, \_SB.BAT1.BCRI)
                                }
                            }

                            If (\_SB.PCI0.LPC0.EC0.BA3C)
                            {
                                If (\_SB.PCI0.LPC0.EC0.ACDF)
                                {
                                    Store (\_SB.PCI0.LPC0.PSTC, Local0)
                                }
                                Else
                                {
                                    Store (\_SB.PCI0.LPC0.PSTM, Local0)
                                }

                                Store (Local0, \_PR.CPU0._PPC)
                                Notify (\_PR.CPU0, 0x80)
                                Sleep (0x64)
                                Store (Local0, \_PR.CPU1._PPC)
                                Notify (\_PR.CPU1, 0x80)
                                Sleep (0x64)
                            }

                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                        }
                    }

                    Name (CPUC, 0x01)
                    Name (CONT, 0x00)
                    Method (_Q09, 0, NotSerialized)
                    {
                        Store (0x09, P80H)
                        If (\_SB.ECOK)
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Store (0x00, \_SB.PCI0.LPC0.EC0.PSTA)
                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                            \_SB.BAT1.BSTA ()
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                            Notify (\_SB.ACAD, 0x80)
                            Sleep (0x01F4)
                            Notify (\_SB.BAT1, 0x80)
                            If (\_SB.BAT1.BTCH)
                            {
                                \_SB.BAT1.UBIF ()
                                Notify (\_SB.BAT1, 0x81)
                                Store (0x00, \_SB.BAT1.BTCH)
                            }

                            If (\_SB.PCI0.LPC0.FGPE)
                            {
                                If (LLess (CONT, 0x03))
                                {
                                    CPOL (0x05)
                                    Add (CONT, 0x01, CONT)
                                }
                            }
                        }

                        Store (0xB0, P80H)
                        Store (\_SB.PCI0.RVN0, Local0)
                        And (Local0, 0x03, Local0)
                        If (\_SB.PCI0.LPC0.FGPE)
                        {
                            Notify (\_SB.PCI0.OHC1, 0x00)
                        }

                        If (\_SB.PCI0.LPC0.BTEN)
                        {
                            If (LGreater (Local0, 0x02))
                            {
                                Notify (\_SB.PCI0.OHC1, 0x00)
                            }
                            Else
                            {
                                Notify (\_SB.PCI0.OHC3, 0x00)
                            }
                        }

                        Notify (\_SB.PCI0.EHC0, 0x00)
                        If (CPUC)
                        {
                            If (\_SB.PCI0.LPC0.EC0.ACDF)
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Store (\_SB.PCI0.LPC0.EC0.BA3C, Local0)
                            }

                            If (LOr (\_SB.PCI0.LPC0.CPUD, Local0))
                            {
                                Store (\_SB.PCI0.LPC0.PSTM, Local0)
                                Store (Local0, \_PR.CPU0._PPC)
                                Notify (\_PR.CPU0, 0x80)
                                Sleep (0x64)
                                Store (Local0, \_PR.CPU1._PPC)
                                Notify (\_PR.CPU1, 0x80)
                                Sleep (0x64)
                            }

                            Store (Local0, \_SB.PCI0.LPC0.PSTC)
                            Store (0x00, CPUC)
                        }

                        If (LLess (\_SB.TPOS, 0x40))
                        {
                            If (\_SB.PCI0.SATA.PSS1)
                            {
                                If (LOr (\_SB.PCI0.SATA.PSER, LEqual (\_SB.PCI0.SATA.PSCS, 0x07)))
                                {
                                    Store (One, \_SB.PCI0.SATA.BS2E)
                                    Store (One, \_SB.PCI0.SATA.BL2E)
                                    Sleep (0x64)
                                    Store (Zero, \_SB.PCI0.SATA.BS2E)
                                    Store (Zero, \_SB.PCI0.SATA.BL2E)
                                    Notify (\_SB.PCI0.SATA.PRT2, 0x01)
                                }
                            }
                        }
                    }

                    Method (_Q9B, 0, NotSerialized)
                    {
                        Store (0x9B, P80H)
                        Store (One, LDSS)
                        Notify (\_SB.LID, 0x80)
                    }

                    Method (_Q9C, 0, NotSerialized)
                    {
                        Store (0x9C, P80H)
                        Store (Zero, LDSS)
                        Notify (\_SB.LID, 0x80)
                    }

                    Method (_Q0E, 0, NotSerialized)
                    {
                        Store (0x0C, P80H)
                        Store (\_SB.PCI0.SMB.MID2, Local3)
                        If (LEqual (Local3, 0x01))
                        {
                            Store (\_SB.PCI0.PB2.VGA.SWIT, Local1)
                            If (LEqual (Local1, 0x00))
                            {
                                Acquire (\_SB.PCI0.LPC0.EC0.MUT0, 0xFFFF)
                                Store (0x91, \_SB.PCI0.LPC0.BCMD)
                                Store (Zero, \_SB.PCI0.LPC0.SMIC)
                                Release (\_SB.PCI0.LPC0.EC0.MUT0)
                                Store (\_SB.PCI0.LPC0.PAR1, Local3)
                                And (Local3, 0x01, Local0)
                                And (Local3, 0x02, Local1)
                                And (Local3, 0x04, Local2)
                                And (Local3, 0x08, Local3)
                                Store (Local0, \_SB.PCI0.PB2.VGA.LCDA)
                                Store (Local1, \_SB.PCI0.PB2.VGA.CRTA)
                                Store (Local2, \_SB.PCI0.PB2.VGA.TVA)
                                Store (Local3, \_SB.PCI0.PB2.VGA.DFPA)
                                Notify (\_SB.PCI0.PB2.VGA, 0x80)
                            }
                        }
                        Else
                        {
                            Store (\_SB.PCI0.AGP.VGA.SWIT, Local1)
                            If (LEqual (Local1, 0x00))
                            {
                                Acquire (\_SB.PCI0.LPC0.EC0.MUT0, 0xFFFF)
                                Store (0x91, \_SB.PCI0.LPC0.BCMD)
                                Store (Zero, \_SB.PCI0.LPC0.SMIC)
                                Release (\_SB.PCI0.LPC0.EC0.MUT0)
                                Store (\_SB.PCI0.LPC0.PAR1, Local3)
                                And (Local3, 0x01, Local0)
                                And (Local3, 0x02, Local1)
                                And (Local3, 0x04, Local2)
                                And (Local3, 0x08, Local3)
                                Store (Local0, \_SB.PCI0.AGP.VGA.LCDA)
                                Store (Local1, \_SB.PCI0.AGP.VGA.CRTA)
                                Store (Local2, \_SB.PCI0.AGP.VGA.TVA)
                                Store (Local3, \_SB.PCI0.AGP.VGA.DFPA)
                                Notify (\_SB.PCI0.AGP.VGA, 0x80)
                            }
                        }
                    }

                    Method (_Q0F, 0, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.LPC0.EC0.BLVL, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }
                        Else
                        {
                            Store (Zero, Local0)
                        }

                        Store (Local0, \_SB.PCI0.LPC0.EC0.BLVL)
                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    }

                    Method (_Q10, 0, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.LPC0.EC0.BLVL, Local0)
                        If (LLess (Local0, 0x07))
                        {
                            Increment (Local0)
                        }
                        Else
                        {
                            Store (0x07, Local0)
                        }

                        Store (Local0, \_SB.PCI0.LPC0.EC0.BLVL)
                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    }

                    Method (_Q11, 0, NotSerialized)
                    {
                        Store (0x11, P80H)
                        BRTU (0x01)
                    }

                    Method (_Q12, 0, NotSerialized)
                    {
                        Store (0x12, P80H)
                        BRTD (0x01)
                    }

                    Method (_Q8C, 0, NotSerialized)
                    {
                    }

                    Method (_Q8D, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC0.EC0.ACDF)
                        {
                            Store (\_SB.PCI0.LPC0.PSTC, Local0)
                        }
                        Else
                        {
                            If (\_SB.PCI0.LPC0.EC0.BA3C)
                            {
                                Store (\_SB.PCI0.LPC0.PSTM, Local0)
                            }
                            Else
                            {
                                Store (\_SB.PCI0.LPC0.PSTC, Local0)
                            }
                        }

                        If (LLess (Local0, \_SB.PCI0.LPC0.PSTM))
                        {
                            Add (Local0, 0x01, Local0)
                            Store (Local0, \_PR.CPU0._PPC)
                            Notify (\_PR.CPU0, 0x80)
                            Sleep (0x64)
                            Store (Local0, \_PR.CPU1._PPC)
                            Notify (\_PR.CPU1, 0x80)
                            Sleep (0x64)
                        }
                    }

                    Method (_Q8E, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC0.EC0.ACDF)
                        {
                            Store (\_SB.PCI0.LPC0.PSTC, Local0)
                        }
                        Else
                        {
                            If (\_SB.PCI0.LPC0.EC0.BA3C)
                            {
                                Store (\_SB.PCI0.LPC0.PSTM, Local0)
                            }
                            Else
                            {
                                Store (\_SB.PCI0.LPC0.PSTC, Local0)
                            }
                        }

                        Store (Local0, \_PR.CPU0._PPC)
                        Notify (\_PR.CPU0, 0x80)
                        Sleep (0x64)
                        Store (Local0, \_PR.CPU1._PPC)
                        Notify (\_PR.CPU1, 0x80)
                        Sleep (0x64)
                    }

                    Method (_QA0, 0, NotSerialized)
                    {
                        Store (0xA0, P80H)
                        \_SB.PCI0.LPC0.PHSR (0x07, 0x5A)
                    }

                    Method (_QA1, 0, NotSerialized)
                    {
                        Store (0xA1, P80H)
                        \_SB.PCI0.LPC0.PHSR (0x07, 0x5B)
                    }

                    Method (BRTU, 1, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.LPC0.EC0.BLVL, Local0)
                        Add (Local0, Arg0, Local0)
                        If (LGreater (Local0, 0x07))
                        {
                            Store (0x07, Local0)
                        }

                        Store (Local0, \_SB.PCI0.LPC0.EC0.BLVL)
                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    }

                    Method (BRTD, 1, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.LPC0.EC0.BLVL, Local0)
                        If (LGreater (Local0, Arg0))
                        {
                            Subtract (Local0, Arg0, Local0)
                        }
                        Else
                        {
                            Store (Zero, Local0)
                        }

                        Store (Local0, \_SB.PCI0.LPC0.EC0.BLVL)
                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    }

                    Method (_Q01, 0, NotSerialized)
                    {
                        Notify (\_SB.BT, 0x90)
                    }

                    Method (_Q02, 0, NotSerialized)
                    {
                        Store (0x01, \_SB.TVAP.VRFS)
                        Notify (\_SB.BT, 0x90)
                    }

                    Method (_Q03, 0, NotSerialized)
                    {
                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                        And (\_SB.PCI0.LPC0.EC0.DALB, 0x03, Local0)
                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                        While (One)
                        {
                            Name (T_0, 0x00)
                            Store (ToInteger (Local0), T_0)
                            If (LEqual (T_0, 0x01))
                            {
                                Notify (\_SB.PCI0.LPC0.EC0.DAL1, 0x80)
                            }
                            Else
                            {
                                If (LEqual (T_0, 0x02))
                                {
                                    Notify (\_SB.PCI0.LPC0.EC0.DAL2, 0x80)
                                }
                            }

                            Break
                        }
                    }

                    Method (_Q90, 0, NotSerialized)
                    {
                        \_SB.TVAP.EVNT (0x02)
                    }

                    Method (_Q91, 0, NotSerialized)
                    {
                        \_SB.TVAP.EVNT (0x03)
                        Sleep (0x05)
                        \_SB.TVAP.EVNT (0x04)
                    }

                    Method (_Q92, 0, NotSerialized)
                    {
                        \_SB.TVAP.EVNT (0x02)
                        Sleep (0x05)
                        \_SB.TVAP.EVNT (0x03)
                        Sleep (0x05)
                        \_SB.TVAP.EVNT (0x04)
                    }

                    Method (_QA2, 0, NotSerialized)
                    {
                        Store (0x40, P80H)
                        If (LGreaterEqual (\_SB.TVAP.VZOK, 0x01))
                        {
                            While (One)
                            {
                                If (LEqual (\_SB.TVAP.VZOK, 0x01))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            \_SB.TVAP.EVNT (0xA2)
                        }

                        Store (0x41, P80H)
                    }

                    Method (_QA3, 0, NotSerialized)
                    {
                        If (LGreaterEqual (\_SB.TVAP.VZOK, 0x01))
                        {
                            While (One)
                            {
                                If (LEqual (\_SB.TVAP.VZOK, 0x01))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            \_SB.TVAP.EVNT (0xA3)
                        }
                    }

                    Method (_QA4, 0, NotSerialized)
                    {
                        If (LGreaterEqual (\_SB.TVAP.VZOK, 0x01))
                        {
                            While (One)
                            {
                                If (LEqual (\_SB.TVAP.VZOK, 0x01))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            \_SB.TVAP.EVNT (0xA4)
                        }
                    }

                    Method (_QA5, 0, NotSerialized)
                    {
                        If (LGreaterEqual (\_SB.TVAP.VZOK, 0x01))
                        {
                            While (One)
                            {
                                If (LEqual (\_SB.TVAP.VZOK, 0x01))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            \_SB.TVAP.EVNT (0xA5)
                        }
                    }

                    Method (_QA6, 0, NotSerialized)
                    {
                        If (LGreaterEqual (\_SB.TVAP.VZOK, 0x01))
                        {
                            While (One)
                            {
                                If (LEqual (\_SB.TVAP.VZOK, 0x01))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            \_SB.TVAP.EVNT (0xA6)
                        }
                    }

                    Method (_QA7, 0, NotSerialized)
                    {
                        If (LGreaterEqual (\_SB.TVAP.VZOK, 0x01))
                        {
                            While (One)
                            {
                                If (LEqual (\_SB.TVAP.VZOK, 0x01))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            \_SB.TVAP.EVNT (0xA7)
                        }
                    }

                    Method (_QA8, 0, NotSerialized)
                    {
                        If (LGreaterEqual (\_SB.TVAP.VZOK, 0x01))
                        {
                            While (One)
                            {
                                If (LEqual (\_SB.TVAP.VZOK, 0x01))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            \_SB.TVAP.EVNT (0xA8)
                        }
                    }

                    Method (_Q9A, 0, NotSerialized)
                    {
                        \_SB.PCI0.LPC0.PHSR (0x15, 0x00)
                        Store (\_SB.PCI0.LPC0.INF, Local0)
                        Store (Local0, \_SB.PCI0.LPC0.PSTC)
                        Store (Local0, \_PR.CPU0._PPC)
                        Notify (\_PR.CPU0, 0x80)
                        Sleep (0x64)
                        Store (Local0, \_PR.CPU1._PPC)
                        Notify (\_PR.CPU1, 0x80)
                        Sleep (0x64)
                    }

                    Device (DAL1)
                    {
                        Name (_HID, EisaId ("PNP0C32"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (TPOS, 0x40))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (GHID, 0, NotSerialized)
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            And (\_SB.PCI0.LPC0.EC0.DALB, 0x01, Local0)
                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                            If (Local0)
                            {
                                Notify (\_SB.PCI0.LPC0.EC0.DAL1, 0x02)
                            }

                            Return (Buffer (0x01)
                            {
                                0x01
                            })
                        }
                    }

                    Device (DAL2)
                    {
                        Name (_HID, EisaId ("PNP0C32"))
                        Name (_UID, 0x02)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (TPOS, 0x40))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (GHID, 0, NotSerialized)
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            And (\_SB.PCI0.LPC0.EC0.DALB, 0x02, Local0)
                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                            If (Local0)
                            {
                                Notify (\_SB.PCI0.LPC0.EC0.DAL2, 0x02)
                            }

                            Return (Buffer (0x01)
                            {
                                0x02
                            })
                        }
                    }
                }

                Device (CIR)
                {
                    Method (_HID, 0, NotSerialized)
                    {
                        If (LLess (TPOS, 0x40))
                        {
                            Return (0x2310A35C)
                        }
                        Else
                        {
                            Return (0x2010A35C)
                        }
                    }

                    OperationRegion (WBIO, SystemIO, 0x2E, 0x02)
                    Field (WBIO, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    Mutex (WBMX, 0x00)
                    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x07), 
                        LDN,    8, 
                                Offset (0x30), 
                        ACTR,   1, 
                                Offset (0x60), 
                        IOAH,   8, 
                        IOAL,   8, 
                                Offset (0x70), 
                        INTR,   8
                    }

                    Method (ENFG, 1, NotSerialized)
                    {
                        Acquire (WBMX, 0xFFFF)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        Release (WBMX)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LAnd (LEqual (\_SB.PCI0.LPC0.CIRE, 0x01), LGreaterEqual (TPOS, 0x40)))
                        {
                            ENFG (0x03)
                            Store (ACTR, Local0)
                            EXFG ()
                            If (Local0)
                            {
                                Store (0x0F, Local0)
                            }
                            Else
                            {
                                Store (0x0D, Local0)
                                \_SB.PCI0.LPC0.CIR._DIS ()
                            }

                            If (LLess (TPOS, 0x40))
                            {
                                ENFG (0x03)
                                Store (0x00, IOAH)
                                Store (0x00, IOAL)
                                EXFG ()
                            }

                            Return (Local0)
                        }
                        Else
                        {
                            ENFG (0x03)
                            Store (0x00, IOAH)
                            Store (0x00, IOAL)
                            EXFG ()
                            ENFG (0x04)
                            Store (0x00, IOAH)
                            Store (0x00, IOAL)
                            EXFG ()
                            Return (0x00)
                        }
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENFG (0x03)
                        Store (0x00, ACTR)
                        Store (0x00, IOAH)
                        Store (0x00, IOAL)
                        Store (0x00, INTR)
                        EXFG ()
                        ENFG (0x04)
                        Store (0x00, ACTR)
                        Store (0x00, IOAH)
                        Store (0x00, IOAL)
                        EXFG ()
                        Store (0x00, \_SB.PCI0.LPC0.Z00B)
                    }

                    Method (_PRS, 0, NotSerialized)
                    {
                        Name (PRS1, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0600,             // Range Minimum
                                    0x0600,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0620,             // Range Minimum
                                    0x0620,             // Range Maximum
                                    0x01,               // Alignment
                                    0x20,               // Length
                                    )
                                IRQNoFlags ()
                                    {4}
                            }
                            EndDependentFn ()
                            /*** Disassembler: inserted missing EndDependentFn () ***/
                        })
                        Name (PRS2, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0620,             // Range Minimum
                                    0x0620,             // Range Maximum
                                    0x01,               // Alignment
                                    0x20,               // Length
                                    )
                                IRQNoFlags ()
                                    {4}
                            }
                            EndDependentFn ()
                            /*** Disassembler: inserted missing EndDependentFn () ***/
                        })
                        If (LLess (TPOS, 0x40))
                        {
                            Return (PRS2)
                        }
                        Else
                        {
                            Return (PRS1)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (DCRS, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x0000,             // Range Minimum
                                0x0000,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0000,             // Range Minimum
                                0x0000,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IRQNoFlags ()
                                {7}
                        })
                        Name (CRS1, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x0600,             // Range Minimum
                                0x0600,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0620,             // Range Minimum
                                0x0620,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IRQNoFlags ()
                                {4}
                        })
                        Name (CRS2, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x0620,             // Range Minimum
                                0x0620,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IRQNoFlags ()
                                {4}
                        })
                        ENFG (0x03)
                        Store (ACTR, Local0)
                        EXFG ()
                        If (Local0)
                        {
                            If (LLess (TPOS, 0x40))
                            {
                                Return (CRS2)
                            }
                            Else
                            {
                                Return (CRS1)
                            }
                        }
                        Else
                        {
                            Return (DCRS)
                        }
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        If (LLess (TPOS, 0x40))
                        {
                            CreateByteField (Arg0, 0x02, IO1L)
                            CreateByteField (Arg0, 0x03, IO1H)
                            CreateWordField (Arg0, 0x09, IRQX)
                            FindSetRightBit (IRQX, Local0)
                            Decrement (Local0)
                            ENFG (0x03)
                            Store (0x00, INTR)
                            Store (0x00, IOAH)
                            Store (0x00, IOAL)
                            Store (0x01, ACTR)
                            EXFG ()
                            ENFG (0x04)
                            Store (Local0, INTR)
                            Store (IO1H, IOAH)
                            Store (IO1L, IOAL)
                            Store (0x01, ACTR)
                            EXFG ()
                        }
                        Else
                        {
                            CreateByteField (Arg0, 0x02, AD1L)
                            CreateByteField (Arg0, 0x03, AD1H)
                            CreateByteField (Arg0, 0x0A, AD2L)
                            CreateByteField (Arg0, 0x0B, AD2H)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            ENFG (0x03)
                            Store (Local0, INTR)
                            Store (AD1H, IOAH)
                            Store (AD1L, IOAL)
                            Store (0x01, ACTR)
                            EXFG ()
                            ENFG (0x04)
                            Store (0x00, INTR)
                            Store (AD2H, IOAH)
                            Store (AD2L, IOAL)
                            Store (0x01, ACTR)
                            EXFG ()
                        }

                        Store (0x01, \_SB.PCI0.LPC0.Z00B)
                    }
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y1D)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.SMB.HPET, One))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Mutex (HPSM, 0x00)
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, \_SB.PCI0.LPC0.HPET._Y1D._BAS, HPT)
                        Acquire (HPSM, 0xFFFF)
                        Store (\_SB.PCI0.SMB.HIHP, Local0)
                        Store (Zero, \_SB.PCI0.SMB.HIHP)
                        If (LNotEqual (\_SB.PCI0.SMB.HPBS, 0x00))
                        {
                            Store (\_SB.PCI0.SMB.HPBS, HPT)
                        }

                        Store (Local0, \_SB.PCI0.SMB.HIHP)
                        Release (HPSM)
                        And (HPT, 0xFFFFFFC0, HPT)
                        Return (CRS)
                    }
                }
            }

            Device (P2P)
            {
                Name (_ADR, 0x00140004)
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x01)
                        {
                            Package (0x04)
                            {
                                0x0001FFFF, 
                                0x00, 
                                0x00, 
                                0x14
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x01)
                        {
                            Package (0x04)
                            {
                                0x0001FFFF, 
                                0x00, 
                                \_SB.PCI0.LPC0.LNKE, 
                                0x00
                            }
                        })
                    }
                }
            }

            Device (AGP)
            {
                Name (_ADR, 0x00010000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x02)
                        {
                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x00, 
                                0x00, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x01, 
                                0x00, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x02)
                        {
                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x00, 
                                \_SB.PCI0.LPC0.LNKC, 
                                0x00
                            }, 

                            Package (0x04)
                            {
                                0x0005FFFF, 
                                0x01, 
                                \_SB.PCI0.LPC0.LNKD, 
                                0x00
                            }
                        })
                    }
                }

                Device (VGA)
                {
                    Name (_ADR, 0x00050000)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (\_SB.PCI0.SMB.MID2)
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Name (ATIB, Buffer (0x50) {})
                    Method (ATIF, 2, Serialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            Return (AF00 ())
                        }

                        If (LEqual (Arg0, 0x01))
                        {
                            Return (AF01 ())
                        }

                        If (LEqual (Arg0, 0x02))
                        {
                            Return (AF02 ())
                        }

                        If (LEqual (Arg0, 0x03))
                        {
                            Return (AF03 (DerefOf (Index (Arg1, 0x02)), DerefOf (Index (Arg1, 
                                0x04))))
                        }

                        If (LEqual (Arg0, 0x05))
                        {
                            Return (AF05 ())
                        }

                        If (LEqual (Arg0, 0x06))
                        {
                            Return (AF06 (DerefOf (Index (Arg1, 0x03))))
                        }

                        If (LEqual (Arg0, 0x07))
                        {
                            Return (AF07 ())
                        }

                        If (LEqual (Arg0, 0x08))
                        {
                            Return (AF08 (DerefOf (Index (Arg1, 0x02))))
                        }
                        Else
                        {
                            CreateWordField (ATIB, 0x00, SSZE)
                            CreateWordField (ATIB, 0x02, VERN)
                            CreateDWordField (ATIB, 0x04, NMSK)
                            CreateDWordField (ATIB, 0x08, SFUN)
                            Store (0x00, SSZE)
                            Store (0x00, VERN)
                            Store (0x00, NMSK)
                            Store (0x00, SFUN)
                            Return (ATIB)
                        }
                    }

                    Method (AF00, 0, NotSerialized)
                    {
                        Store (0xF0, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateWordField (ATIB, 0x02, VERN)
                        CreateDWordField (ATIB, 0x04, NMSK)
                        CreateDWordField (ATIB, 0x08, SFUN)
                        Store (0x0C, SSZE)
                        Store (0x01, VERN)
                        If (CondRefOf (\_SB.PCI0.AGP.VGA.XTPX, Local4))
                        {
                            Store (0x11, NMSK)
                        }
                        Else
                        {
                            Store (0x51, NMSK)
                        }

                        Store (NMSK, MSKN)
                        Store (0x07, SFUN)
                        Return (ATIB)
                    }

                    Name (NCOD, 0x81)
                    Method (AF01, 0, NotSerialized)
                    {
                        Store (0xF1, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateDWordField (ATIB, 0x02, VMSK)
                        CreateDWordField (ATIB, 0x06, FLGS)
                        Store (0x03, VMSK)
                        Store (0x0A, SSZE)
                        Store (0x01, FLGS)
                        Store (0x81, NCOD)
                        Return (ATIB)
                    }

                    Name (PSBR, Buffer (0x04)
                    {
                        0x00, 0x00, 0x00, 0x00
                    })
                    Name (MSKN, 0x00)
                    Name (SEXM, 0x00)
                    Name (STHG, 0x00)
                    Name (STHI, 0x00)
                    Name (SFPG, 0x00)
                    Name (SFPI, 0x00)
                    Name (SSPS, 0x00)
                    Name (SSDM, 0x0A)
                    Name (SCDY, 0x00)
                    Name (SACT, Buffer (0x06)
                    {
                        0x01, 0x02, 0x08, 0x03, 0x09, 0x0A
                    })
                    Method (AF02, 0, NotSerialized)
                    {
                        Store (0xF2, P80H)
                        CreateBitField (PSBR, 0x00, PDSW)
                        CreateBitField (PSBR, 0x01, PEXM)
                        CreateBitField (PSBR, 0x02, PTHR)
                        CreateBitField (PSBR, 0x03, PFPS)
                        CreateBitField (PSBR, 0x04, PSPS)
                        CreateBitField (PSBR, 0x05, PDCC)
                        CreateBitField (PSBR, 0x06, PXPS)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateDWordField (ATIB, 0x02, PSBI)
                        CreateByteField (ATIB, 0x06, EXPM)
                        CreateByteField (ATIB, 0x07, THRM)
                        CreateByteField (ATIB, 0x08, THID)
                        CreateByteField (ATIB, 0x09, FPWR)
                        CreateByteField (ATIB, 0x0A, FPID)
                        CreateByteField (ATIB, 0x0B, SPWR)
                        Store (0x0C, SSZE)
                        Store (PSBR, PSBI)
                        If (PDSW)
                        {
                            Store (0x82, P80H)
                            Store (Zero, PDSW)
                        }

                        If (PEXM)
                        {
                            Store (SEXM, EXPM)
                            Store (Zero, SEXM)
                            Store (Zero, PEXM)
                        }

                        If (PTHR)
                        {
                            Store (STHG, THRM)
                            Store (STHI, THID)
                            Store (Zero, STHG)
                            Store (Zero, STHI)
                            Store (Zero, PTHR)
                        }

                        If (PFPS)
                        {
                            Store (SFPG, FPWR)
                            Store (SFPI, FPWR)
                            Store (Zero, SFPG)
                            Store (Zero, SFPI)
                            Store (Zero, PFPS)
                        }

                        If (PSPS)
                        {
                            Store (SSPS, SPWR)
                            Store (Zero, PSPS)
                        }

                        If (PXPS)
                        {
                            Store (0xA2, P80H)
                            Store (Zero, PXPS)
                        }

                        Return (ATIB)
                    }

                    Method (AF03, 2, NotSerialized)
                    {
                        Store (0xF3, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateWordField (ATIB, 0x02, SSDP)
                        CreateWordField (ATIB, 0x04, SCDP)
                        Store (Arg0, SSDP)
                        Store (Arg1, SCDP)
                        Name (NXTD, 0x06)
                        Name (CIDX, 0x06)
                        Store (SSDP, Local1)
                        And (Local1, 0x0B, Local1)
                        Store (SCDP, Local2)
                        If (CondRefOf (\_SB.LID._LID, Local4))
                        {
                            And (Local2, Not (0x01), Local2)
                            Or (Local2, \_SB.LID._LID (), Local2)
                        }
                        Else
                        {
                            Or (Local2, 0x01, Local2)
                        }

                        Store (Local2, P80H)
                        Store (Zero, Local0)
                        While (LLess (Local0, SizeOf (SACT)))
                        {
                            Store (DerefOf (Index (SACT, Local0)), Local3)
                            If (LEqual (Local3, Local1))
                            {
                                Store (Local0, CIDX)
                                Store (SizeOf (SACT), Local0)
                            }
                            Else
                            {
                                Increment (Local0)
                            }
                        }

                        Store (CIDX, Local0)
                        While (LLess (Local0, SizeOf (SACT)))
                        {
                            Increment (Local0)
                            If (LEqual (Local0, SizeOf (SACT)))
                            {
                                Store (0x00, Local0)
                            }

                            Store (DerefOf (Index (SACT, Local0)), Local3)
                            If (LEqual (And (Local3, Local2), Local3))
                            {
                                Store (Local0, NXTD)
                                Store (SizeOf (SACT), Local0)
                            }
                        }

                        If (LEqual (NXTD, SizeOf (SACT)))
                        {
                            Store (Zero, SSDP)
                        }
                        Else
                        {
                            Store (NXTD, Local0)
                            Store (DerefOf (Index (SACT, Local0)), Local3)
                            And (SSDP, Not (0x0B), SSDP)
                            Or (SSDP, Local3, SSDP)
                        }

                        Store (0x04, SSZE)
                        Store (SSDP, P80H)
                        Return (ATIB)
                    }

                    Method (AF05, 0, NotSerialized)
                    {
                        Store (0xF5, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateByteField (ATIB, 0x02, TSEF)
                        CreateByteField (ATIB, 0x03, TVIF)
                        Store (0x04, SSZE)
                        Store (0x00, TSEF)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x05, \_SB.PCI0.LPC0.DID)
                        Store (ATIB, \_SB.PCI0.LPC0.INFO)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        CreateByteField (\_SB.PCI0.LPC0.INFO, 0x03, TVII)
                        Store (TVII, TVIF)
                        Release (\_SB.PCI0.LPC0.PSMX)
                        Return (ATIB)
                    }

                    Method (AF06, 1, NotSerialized)
                    {
                        Store (0xF6, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateByteField (ATIB, 0x02, TSEF)
                        CreateByteField (ATIB, 0x03, TVIF)
                        Store (0x04, SSZE)
                        Store (0x00, TSEF)
                        Store (Arg0, TVIF)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x06, \_SB.PCI0.LPC0.DID)
                        Store (ATIB, \_SB.PCI0.LPC0.INFO)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        Release (\_SB.PCI0.LPC0.PSMX)
                    }

                    Method (AF07, 0, NotSerialized)
                    {
                        Store (0xF7, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateByteField (ATIB, 0x02, XMOD)
                        Store (0x03, SSZE)
                        Store (0x00, XMOD)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x07, \_SB.PCI0.LPC0.DID)
                        Store (ATIB, \_SB.PCI0.LPC0.INFO)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        CreateByteField (\_SB.PCI0.LPC0.INFO, 0x02, PMOD)
                        Store (PMOD, XMOD)
                        Release (\_SB.PCI0.LPC0.PSMX)
                        Return (ATIB)
                    }

                    Method (AF08, 1, NotSerialized)
                    {
                        Store (0xF8, P80H)
                        CreateWordField (ATIB, 0x00, SSZE)
                        CreateByteField (ATIB, 0x02, XMOD)
                        Store (0x03, SSZE)
                        Store (Arg0, XMOD)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x08, \_SB.PCI0.LPC0.DID)
                        Store (ATIB, \_SB.PCI0.LPC0.INFO)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        Release (\_SB.PCI0.LPC0.PSMX)
                    }

                    Method (AFN0, 0, Serialized)
                    {
                        If (And (MSKN, 0x01))
                        {
                            CreateBitField (PSBR, 0x00, PDSW)
                            Store (One, PDSW)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN1, 1, Serialized)
                    {
                        If (And (MSKN, 0x02))
                        {
                            Store (Arg0, Local0)
                            And (Local0, 0x03, Local0)
                            Store (Local0, SEXM)
                            CreateBitField (PSBR, 0x01, PEXM)
                            Store (One, PEXM)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN2, 2, Serialized)
                    {
                        If (And (MSKN, 0x04))
                        {
                            Store (Arg0, Local0)
                            Store (Local0, STHI)
                            Store (Arg1, Local0)
                            Store (And (Local0, 0x03, Local0), STHG)
                            CreateBitField (PSBR, 0x02, PTHS)
                            Store (One, PTHS)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN3, 2, Serialized)
                    {
                        If (And (MSKN, 0x08))
                        {
                            Store (Arg0, Local0)
                            Store (Local0, SFPI)
                            Store (Arg1, Local0)
                            Store (And (Local0, 0x03, Local0), SFPG)
                            CreateBitField (PSBR, 0x03, PFPS)
                            Store (One, PFPS)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN4, 1, Serialized)
                    {
                        If (And (MSKN, 0x10))
                        {
                            Store (Arg0, Local0)
                            Store (SSPS, Local1)
                            Store (Local0, SSPS)
                            If (LEqual (Local0, Local1)) {}
                            Else
                            {
                                CreateBitField (PSBR, 0x04, PSPS)
                                Store (One, PSPS)
                                Notify (VGA, NCOD)
                            }
                        }
                    }

                    Method (AFN5, 0, Serialized)
                    {
                        If (And (MSKN, 0x20))
                        {
                            CreateBitField (PSBR, 0x05, PDCC)
                            Store (One, PDCC)
                            Notify (VGA, NCOD)
                        }
                    }

                    Method (AFN6, 0, Serialized)
                    {
                        If (And (MSKN, 0x40))
                        {
                            CreateBitField (PSBR, 0x06, PXPS)
                            Store (One, PXPS)
                            Notify (VGA, NCOD)
                        }
                    }

                    Name (SWIT, 0x01)
                    Name (CRTA, 0x01)
                    Name (LCDA, 0x01)
                    Name (TVA, 0x00)
                    Name (DFPA, 0x00)
                    Name (TOGF, 0x00)
                    Name (SWIF, 0x00)
                    Method (_DOS, 1, NotSerialized)
                    {
                        Store ("VGA --_DOS Arg0", Debug)
                        Store (Arg0, Local0)
                        And (Local0, 0x01, Local1)
                        Store (Local1, SWIT)
                        If (LEqual (Local1, 0x00))
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT0, 0xFFFF)
                            Store (0x91, \_SB.PCI0.LPC0.BCMD)
                            Store (Zero, \_SB.PCI0.LPC0.SMIC)
                            Release (\_SB.PCI0.LPC0.EC0.MUT0)
                            Store (\_SB.PCI0.LPC0.PAR2, Local2)
                            And (Local2, 0x01, Local0)
                            Store (Local0, LCDA)
                            And (Local2, 0x02, Local0)
                            Store (Local0, CRTA)
                        }
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Store ("VGA --_DOD", Debug)
                        Return (Package (0x04)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x0200, 
                            0x0210
                        })
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
                            If (LCDA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("LCD --_DGS", Debug)
                            Store (LCDA, Local0)
                            Store (Local0, Debug)
                            If (LCDA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("LCD --_DSS", Debug)
                            Store (Arg0, Debug)
                        }

                        Method (_BCL, 0, NotSerialized)
                        {
                            Return (Package (0x0A)
                            {
                                0x64, 
                                0x64, 
                                0x00, 
                                0x0F, 
                                0x1E, 
                                0x2E, 
                                0x38, 
                                0x48, 
                                0x52, 
                                0x64
                            })
                        }

                        Method (_BCM, 1, NotSerialized)
                        {
                            While (One)
                            {
                                Name (T_0, 0x00)
                                Store (ToInteger (Arg0), T_0)
                                If (LEqual (T_0, 0x00))
                                {
                                    Store (0x00, Local1)
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x0F))
                                    {
                                        Store (0x01, Local1)
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, 0x1E))
                                        {
                                            Store (0x02, Local1)
                                        }
                                        Else
                                        {
                                            If (LEqual (T_0, 0x2E))
                                            {
                                                Store (0x03, Local1)
                                            }
                                            Else
                                            {
                                                If (LEqual (T_0, 0x38))
                                                {
                                                    Store (0x04, Local1)
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_0, 0x48))
                                                    {
                                                        Store (0x05, Local1)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T_0, 0x52))
                                                        {
                                                            Store (0x06, Local1)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T_0, 0x64))
                                                            {
                                                                Store (0x07, Local1)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                Break
                            }

                            Store (ToInteger (Local1), Local0)
                            If (LEqual (TPOS, 0x40))
                            {
                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                Store (Local0, \_SB.PCI0.LPC0.EC0.BLVL)
                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                            }
                        }

                        Method (_BQC, 0, NotSerialized)
                        {
                            If (LEqual (TPOS, 0x40))
                            {
                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                Store (\_SB.PCI0.LPC0.EC0.BLVL, Local0)
                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                While (One)
                                {
                                    Name (T_0, 0x00)
                                    Store (ToInteger (Local0), T_0)
                                    If (LEqual (T_0, 0x00))
                                    {
                                        Store (0x00, Local1)
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, 0x01))
                                        {
                                            Store (0x0F, Local1)
                                        }
                                        Else
                                        {
                                            If (LEqual (T_0, 0x02))
                                            {
                                                Store (0x1E, Local1)
                                            }
                                            Else
                                            {
                                                If (LEqual (T_0, 0x03))
                                                {
                                                    Store (0x2E, Local1)
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_0, 0x04))
                                                    {
                                                        Store (0x38, Local1)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T_0, 0x05))
                                                        {
                                                            Store (0x48, Local1)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T_0, 0x06))
                                                            {
                                                                Store (0x52, Local1)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T_0, 0x07))
                                                                {
                                                                    Store (0x64, Local1)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    Break
                                }
                            }

                            Return (Local1)
                        }
                    }

                    Device (CRT1)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("CRT --_DCS", Debug)
                            If (CRTA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("CRT --_DGS", Debug)
                            Store (CRTA, Local0)
                            Store (Local0, Debug)
                            If (CRTA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("CRT --_DSS", Debug)
                            Store (Arg0, Debug)
                        }
                    }

                    Device (TV)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("TV --_DCS", Debug)
                            Store (0x8F, \_SB.PCI0.LPC0.BCMD)
                            Store (Zero, \_SB.PCI0.LPC0.SMIC)
                            If (TVA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("TV --_DGS", Debug)
                            Store (TVA, Local0)
                            If (TVA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("TV --_DSS", Debug)
                            Store (Arg0, Debug)
                        }
                    }

                    Device (DFP1)
                    {
                        Name (_ADR, 0x0210)
                        Method (_DCS, 0, NotSerialized)
                        {
                            Store ("DFP --_DCS", Debug)
                            If (DFPA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store ("DFP --_DGS", Debug)
                            Store (DFPA, Local0)
                            Store (Local0, Debug)
                            If (DFPA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("DFP --_DSS", Debug)
                            Store (Arg0, Debug)
                        }
                    }
                }
            }

            Scope (\_SB.PCI0.AGP.VGA)
            {
                Name (ATPB, Buffer (0x0100) {})
                Name (DSID, 0xFFFFFFFF)
                Method (XTPX, 2, Serialized)
                {
                    If (LEqual (Arg0, 0x00))
                    {
                        Return (PX00 ())
                    }

                    If (LEqual (Arg0, 0x01))
                    {
                        Return (PX01 ())
                    }

                    If (LEqual (Arg0, 0x02))
                    {
                        Return (PX02 (DerefOf (Index (Arg1, 0x02))))
                    }

                    If (LEqual (Arg0, 0x03))
                    {
                        Return (PX03 (DerefOf (Index (Arg1, 0x02))))
                    }

                    CreateWordField (ATPB, 0x00, SSZE)
                    CreateWordField (ATPB, 0x02, VERN)
                    CreateDWordField (ATPB, 0x04, SFUN)
                    Store (0x00, SSZE)
                    Store (0x00, VERN)
                    Store (0x00, SFUN)
                    Return (ATPB)
                }

                Method (PX00, 0, NotSerialized)
                {
                    Store (0xE0, P80H)
                    CreateWordField (ATPB, 0x00, SSZE)
                    CreateWordField (ATPB, 0x02, VERN)
                    CreateDWordField (ATPB, 0x04, SFUN)
                    Store (0x08, SSZE)
                    Store (0x01, VERN)
                    Store (0x07, SFUN)
                    Store (\_SB.PCI0.PB2.VGA.SVID, Local0)
                    If (LNotEqual (Local0, 0xFFFFFFFF))
                    {
                        Store (Local0, \_SB.PCI0.AGP.VGA.DSID)
                    }

                    Return (ATPB)
                }

                Method (PX01, 0, NotSerialized)
                {
                    Store (0xE1, P80H)
                    CreateWordField (ATPB, 0x00, SSZE)
                    CreateDWordField (ATPB, 0x02, VMSK)
                    CreateDWordField (ATPB, 0x06, FLGS)
                    Store (0x0A, SSZE)
                    Store (0x0F, VMSK)
                    Store (0x0F, FLGS)
                    Return (ATPB)
                }

                Method (PX02, 1, NotSerialized)
                {
                    CreateWordField (ATPB, 0x00, SSZE)
                    CreateByteField (ATPB, 0x02, PWST)
                    Store (0x03, SSZE)
                    And (Arg0, 0x01, PWST)
                    Name (HPOK, 0x00)
                    Store (0x01, \_SB.PCI0.SMB.G72F)
                    Store (0x01, \_SB.PCI0.SMB.G36F)
                    If (PWST)
                    {
                        Store (0x11E2, P80H)
                        Store (One, \_SB.PCI0.SMB.G72O)
                        Store (Zero, \_SB.PCI0.SMB.G72E)
                        Sleep (0x32)
                        Store (One, \_SB.PCI0.SMB.G36O)
                        Store (Zero, \_SB.PCI0.SMB.G36E)
                        Store (0x12E2, P80H)
                        Store (0x00, HPOK)
                        Sleep (0x64)
                        Sleep (0x64)
                        \_SB.PCI0.XPTR (0x02, 0x01)
                        Sleep (0x14)
                        Store (0x00, Local2)
                        While (LLess (Local2, 0x0F))
                        {
                            Store (0x08, \_SB.PCI0.PB2.SLST)
                            Store (0x01, Local4)
                            Store (0xC8, Local5)
                            While (LAnd (Local4, Local5))
                            {
                                Store (\_SB.PCI0.PB2.XPRD (0xA5), Local6)
                                And (Local6, 0x7F, Local6)
                                If (LAnd (LGreaterEqual (Local6, 0x10), LNotEqual (Local6, 0x7F)))
                                {
                                    Store (0x00, Local4)
                                }
                                Else
                                {
                                    Sleep (0x05)
                                    Decrement (Local5)
                                }
                            }

                            If (LNot (Local4))
                            {
                                Store (\_SB.PCI0.PB2.XPDL (), Local5)
                                If (Local5)
                                {
                                    \_SB.PCI0.PB2.XPRT ()
                                    Sleep (0x05)
                                    Increment (Local2)
                                }
                                Else
                                {
                                    Store (0x10, \_SB.PCI0.LPC0.INFO)
                                    Store (0x87, \_SB.PCI0.LPC0.BCMD)
                                    Store (Zero, \_SB.PCI0.LPC0.SMIC)
                                    If (LEqual (\_SB.PCI0.PB2.XPR2 (), Ones))
                                    {
                                        Store (0x01, HPOK)
                                        Store (0x10, Local2)
                                    }
                                    Else
                                    {
                                        Store (0x00, HPOK)
                                        Store (0x10, Local2)
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x10, Local2)
                            }
                        }

                        If (LNot (HPOK))
                        {
                            Store (0x13E2, P80H)
                            Store (\_SB.PCI0.PB2.VGA.DVID, Local7)
                            Sleep (0x0A)
                            Store (0x01, Local4)
                            Store (0x05, Local5)
                            While (LAnd (Local4, Local5))
                            {
                                Store (\_SB.PCI0.PB2.XPRD (0xA5), Local6)
                                And (Local6, 0x7F, Local6)
                                If (LLessEqual (Local6, 0x04))
                                {
                                    Store (0x00, Local4)
                                }
                                Else
                                {
                                    Store (\_SB.PCI0.PB2.VGA.DVID, Local7)
                                    Sleep (0x05)
                                    Decrement (Local5)
                                }
                            }

                            \_SB.PCI0.XPTR (0x02, 0x00)
                        }

                        Store (0x14E2, P80H)
                    }
                    Else
                    {
                        Store (0x02E2, P80H)
                        Store (Zero, \_SB.PCI0.SMB.G36O)
                        Store (Zero, \_SB.PCI0.SMB.G36E)
                        Store (Zero, \_SB.PCI0.SMB.G72O)
                        Store (Zero, \_SB.PCI0.SMB.G72E)
                        Store (0x03E2, P80H)
                        Store (0x08, \_SB.PCI0.PB2.SLST)
                        Store (\_SB.PCI0.PB2.VGA.DVID, Local7)
                        Sleep (0x0A)
                        Store (0x01, Local4)
                        Store (0x05, Local5)
                        While (LAnd (Local4, Local5))
                        {
                            Store (\_SB.PCI0.PB2.XPRD (0xA5), Local6)
                            And (Local6, 0x7F, Local6)
                            If (LLessEqual (Local6, 0x04))
                            {
                                Store (0x00, Local4)
                            }
                            Else
                            {
                                Store (\_SB.PCI0.PB2.VGA.DVID, Local7)
                                Sleep (0x05)
                                Decrement (Local5)
                            }
                        }

                        \_SB.PCI0.XPTR (0x02, 0x00)
                        Store (0x02, HPOK)
                        Store (0x04E2, P80H)
                    }

                    If (HPOK)
                    {
                        If (LAnd (LEqual (HPOK, 0x01), LNotEqual (\_SB.PCI0.AGP.VGA.DSID, 0xFFFFFFFF)))
                        {
                            Store (\_SB.PCI0.AGP.VGA.DSID, Local7)
                            Store (Local7, \_SB.PCI0.PB2.VGA.SMID)
                            Sleep (0x0A)
                        }

                        Notify (\_SB.PCI0.PB2, 0x00)
                    }
                }

                Method (PX03, 1, NotSerialized)
                {
                    CreateWordField (ATPB, 0x00, SSZE)
                    CreateWordField (ATPB, 0x02, DPSW)
                    Store (0x04, SSZE)
                    And (Arg0, 0x01, DPSW)
                    If (DPSW)
                    {
                        Store (0x02E3, P80H)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x02, \_SB.PCI0.LPC0.INFO)
                        Store (0x85, \_SB.PCI0.LPC0.BCMD)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        Release (\_SB.PCI0.LPC0.PSMX)
                    }
                    Else
                    {
                        Store (0x01E3, P80H)
                        Acquire (\_SB.PCI0.LPC0.PSMX, 0xFFFF)
                        Store (0x01, \_SB.PCI0.LPC0.INFO)
                        Store (0x85, \_SB.PCI0.LPC0.BCMD)
                        Store (Zero, \_SB.PCI0.LPC0.SMIC)
                        Release (\_SB.PCI0.LPC0.PSMX)
                    }
                }
            }

            Scope (\_SB.PCI0.AGP.VGA)
            {
                OperationRegion (REVD, SystemMemory, 0xCDEDDF6C, 0x00000008)
                Field (REVD, AnyAcc, NoLock, Preserve)
                {
                    SROM,   32, 
                    VROM,   32
                }

                Name (TVGA, Buffer (0x0004)
                {
                    0x00
                })
                Method (XTRM, 2, Serialized)
                {
                    Add (Arg0, Arg1, Local0)
                    If (LLessEqual (Local0, SROM))
                    {
                        Multiply (Arg1, 0x08, Local1)
                        Multiply (Arg0, 0x08, Local2)
                        Store (VROM, TVGA)
                        CreateField (TVGA, Local2, Local1, TEMP)
                        Name (RETB, Buffer (Arg1) {})
                        Store (TEMP, RETB)
                        Return (RETB)
                    }
                    Else
                    {
                        If (LLess (Arg0, SROM))
                        {
                            Subtract (SROM, Arg0, Local3)
                            Multiply (Local3, 0x08, Local1)
                            Multiply (Arg0, 0x08, Local2)
                            Store (VROM, TVGA)
                            CreateField (TVGA, Local2, Local1, TEM)
                            Name (RETC, Buffer (Local3) {})
                            Store (TEM, RETC)
                            Return (RETC)
                        }
                        Else
                        {
                            Name (RETD, Buffer (0x01) {})
                            Return (RETD)
                        }
                    }
                }
            }
        }

        Device (TVAP)
        {
            Name (_HID, EisaId ("TOS1900"))
            Method (_STA, 0, NotSerialized)
            {
                If (LEqual (TPOS, 0x40))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_DDN, "VALZeneral")
            Name (VZOK, 0x00)
            Name (VBFG, 0x0A)
            Name (VALF, 0x00)
            Name (VRFS, 0x00)
            Method (ENAB, 0, NotSerialized)
            {
                Store (0x01, VZOK)
                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                Store (\_SB.PCI0.LPC0.EC0.RFST, Local0)
                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                Store (Local0, VRFS)
            }

            Method (EVNT, 1, NotSerialized)
            {
                While (VZOK)
                {
                    If (LEqual (VZOK, 0x01))
                    {
                        Store (Arg0, VZOK)
                        Notify (\_SB.TVAP, 0x80)
                        Return (Zero)
                    }
                    Else
                    {
                        If (LEqual (VALF, 0x1E))
                        {
                            Store (0x01, VZOK)
                            Store (0x00, VALF)
                            Return (Zero)
                        }

                        Sleep (0x64)
                        Add (VALF, 0x01, VALF)
                    }
                }
		Return (Package(0x02){0x00,0x00})
            }

            Method (INFO, 0, Serialized)
            {
                If (LEqual (VZOK, 0x02))
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.VEVT, Local0)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Store (0x01, VZOK)
                    Return (Local0)
                }
                Else
                {
                    If (LEqual (VZOK, 0x03))
                    {
                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.LPC0.EC0.FEVT, Local0)
                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                        Store (0x01, VZOK)
                        Return (Local0)
                    }
                    Else
                    {
                        If (LEqual (VZOK, 0x04))
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Store (\_SB.PCI0.LPC0.EC0.NEVT, Local0)
                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                            Store (0x01, VZOK)
                            Return (Local0)
                        }
                        Else
                        {
                            If (LEqual (VZOK, 0xA2))
                            {
                                Store (0xA2, P80H)
                                Store (0xA2, \_SB.PCI0.LPC0.BLK0)
                                \_SB.PCI0.LPC0.PHSR (0x12, 0x09)
                                Store (\_SB.PCI0.LPC0.BLK0, Local0)
                                And (ToInteger (Local0), 0xFF, Local0)
                                Or (Local0, 0x1400, Local0)
                                Store (0x01, VZOK)
                                Return (Local0)
                            }
                            Else
                            {
                                If (LEqual (VZOK, 0xA3))
                                {
                                    Store (0xA3, P80H)
                                    Store (0x1500, Local0)
                                    Store (0x01, VZOK)
                                    Return (Local0)
                                }
                                Else
                                {
                                    If (LEqual (VZOK, 0xA4))
                                    {
                                        Store (0x1501, Local0)
                                        Store (0x01, VZOK)
                                        Return (Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (VZOK, 0xA5))
                                        {
                                            Store (0xA5, \_SB.PCI0.LPC0.BLK0)
                                            \_SB.PCI0.LPC0.PHSR (0x12, 0x06)
                                            Store (\_SB.PCI0.LPC0.BLK1, Local0)
                                            And (ToInteger (Local0), 0xFF, Local0)
                                            Or (Local0, 0x1600, Local0)
                                            Store (0x01, VZOK)
                                            Return (Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (VZOK, 0xA6))
                                            {
                                                Store (0x1502, Local0)
                                                Store (0x01, VZOK)
                                                Return (Local0)
                                            }
                                            Else
                                            {
                                                If (LEqual (VZOK, 0xA7))
                                                {
                                                    Store (0x1581, Local0)
                                                    Store (0x01, VZOK)
                                                    Return (Local0)
                                                }
                                                Else
                                                {
                                                    If (LEqual (VZOK, 0xA8))
                                                    {
                                                        Store (0x1580, Local0)
                                                        Store (0x01, VZOK)
                                                        Return (Local0)
                                                    }
                                                    Else
                                                    {
                                                        Return (Zero)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Name (VALI, Package (0x06)
            {
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Name (VALO, Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (GWFS, Package (0x06)
            {
                0xFE00, 
                0x56, 
                0x00, 
                0x01, 
                0x00, 
                0x00
            })
            Name (SWRN, Package (0x06)
            {
                0xFF00, 
                0x56, 
                0x01, 
                0x0200, 
                0x00, 
                0x00
            })
            Name (SWRF, Package (0x06)
            {
                0xFF00, 
                0x56, 
                0x00, 
                0x0200, 
                0x00, 
                0x00
            })
            Name (GTPS, Package (0x06)
            {
                0xF300, 
                0x050E, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (STPD, Package (0x06)
            {
                0xF400, 
                0x050E, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (STPE, Package (0x06)
            {
                0xF400, 
                0x050E, 
                0x01, 
                0x00, 
                0x00, 
                0x00
            })
            Name (FNDS, Package (0x06)
            {
                0xFF00, 
                0x5A, 
                0x00, 
                0x01, 
                0x00, 
                0x00
            })
            Name (FNTP, Package (0x06)
            {
                0xFF00, 
                0x5A, 
                0x01, 
                0x01, 
                0x00, 
                0x00
            })
            Name (FNTC, Package (0x06)
            {
                0xFF00, 
                0x5A, 
                0x02, 
                0x01, 
                0x00, 
                0x00
            })
            Name (GCCM, Package (0x06)
            {
                0xFE00, 
                0x7F, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (SCMP, Package (0x06)
            {
                0xFF00, 
                0x7F, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (SCMS, Package (0x06)
            {
                0xFF00, 
                0x7F, 
                0x01, 
                0x00, 
                0x00, 
                0x00
            })
            Name (CESS, Package (0x06)
            {
                0xFE00, 
                0x62, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (GPNL, Package (0x06)
            {
                0xFE00, 
                0x11, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (SHK0, Package (0x06)
            {
                0xFF00, 
                0xC000, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (SHK1, Package (0x06)
            {
                0xFF00, 
                0xC000, 
                0x00, 
                0x01, 
                0x00, 
                0x00
            })
            Name (GHKM, Package (0x06)
            {
                0xFE00, 
                0xC000, 
                0x03, 
                0x00, 
                0x00, 
                0x00
            })
            Name (SBED, Package (0x06)
            {
                0xFF00, 
                0x1E, 
                0x01, 
                0x00, 
                0x00, 
                0x00
            })
            Name (SBEE, Package (0x06)
            {
                0xFF00, 
                0x1E, 
                0x03, 
                0x00, 
                0x00, 
                0x00
            })
            Name (SHEE, Package (0x06)
            {
                0xFF00, 
                0x1E, 
                0x09, 
                0x00, 
                0x00, 
                0x00
            })
            Name (SBHE, Package (0x06)
            {
                0xFF00, 
                0x1E, 
                0x0B, 
                0x00, 
                0x00, 
                0x00
            })
            Name (GBEM, Package (0x06)
            {
                0xFE00, 
                0x1E, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (CECF, 0x00)
            Name (CECQ, 0x00)
            Name (CECG, Package (0x06)
            {
                0xF300, 
                0x0154, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (CELG, Package (0x06)
            {
                0xF300, 
                0x0155, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (CECD, Package (0x06)
            {
                0xF400, 
                0x0154, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (CECE, Package (0x06)
            {
                0xF400, 
                0x0154, 
                0x01, 
                0x00, 
                0x00, 
                0x00
            })
            Name (CELD, Package (0x06)
            {
                0xF400, 
                0x0155, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (CELE, Package (0x06)
            {
                0xF400, 
                0x0155, 
                0x01, 
                0x00, 
                0x00, 
                0x00
            })
            Name (HRCM, Package (0x06)
            {
                0xFE00, 
                0x8F, 
                0xC1, 
                0x00, 
                0x00, 
                0x00
            })
            Name (HRMG, Package (0x06)
            {
                0xFE00, 
                0x8F, 
                0xC3, 
                0x00, 
                0x00, 
                0x00
            })
            Name (HGSS, Package (0x06)
            {
                0xFE00, 
                0x8F, 
                0xC4, 
                0x00, 
                0x00, 
                0x00
            })
            Name (HGRS, Package (0x06)
            {
                0xFE00, 
                0x8F, 
                0xC5, 
                0x00, 
                0x00, 
                0x00
            })
            Name (REVT, Package (0x06)
            {
                0xFE00, 
                0x8F, 
                0xC7, 
                0x00, 
                0x00, 
                0x00
            })
            Name (GIFO, Package (0x06)
            {
                0xFE00, 
                0x8F, 
                0xC8, 
                0x00, 
                0x00, 
                0x00
            })
            Name (HCON, Package (0x06)
            {
                0xFE00, 
                0xC000, 
                0x03, 
                0x00, 
                0x00, 
                0x00
            })
            Name (REMS, Package (0x06)
            {
                0xFF00, 
                0x61, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (LEDG, Package (0x06)
            {
                0xF300, 
                0x014E, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (LED0, Package (0x06)
            {
                0xF400, 
                0x014E, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (LED1, Package (0x06)
            {
                0xF400, 
                0x014E, 
                0x01, 
                0x00, 
                0x00, 
                0x00
            })
            Name (RMGW, Package (0x06)
            {
                0xFE00, 
                0x47, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (RMCW, Package (0x06)
            {
                0xFF00, 
                0x47, 
                0x5A00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (RMGS, Package (0x06)
            {
                0xFE00, 
                0x61, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (RMSD, Package (0x06)
            {
                0xFF00, 
                0x61, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (RMSE, Package (0x06)
            {
                0xFF00, 
                0x61, 
                0x01, 
                0x00, 
                0x00, 
                0x00
            })
            Name (PANS, Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            })
            Name (PT01, Package (0x06)
            {
                0x02, 
                0x80, 
                0x01, 
                0xE0, 
                0x00, 
                0x00
            })
            Name (PT02, Package (0x06)
            {
                0x03, 
                0x20, 
                0x02, 
                0x58, 
                0x00, 
                0x00
            })
            Name (PT03, Package (0x06)
            {
                0x04, 
                0x00, 
                0x03, 
                0x00, 
                0x00, 
                0x00
            })
            Name (PT04, Package (0x06)
            {
                0x04, 
                0x00, 
                0x02, 
                0x58, 
                0x00, 
                0x00
            })
            Name (PT05, Package (0x06)
            {
                0x03, 
                0x20, 
                0x01, 
                0xE0, 
                0x00, 
                0x00
            })
            Name (PT06, Package (0x06)
            {
                0x05, 
                0x00, 
                0x04, 
                0x00, 
                0x00, 
                0x00
            })
            Name (PT07, Package (0x06)
            {
                0x05, 
                0x78, 
                0x04, 
                0x1A, 
                0x00, 
                0x00
            })
            Name (PT08, Package (0x06)
            {
                0x06, 
                0x40, 
                0x04, 
                0xB0, 
                0x00, 
                0x00
            })
            Name (PT09, Package (0x06)
            {
                0x05, 
                0x00, 
                0x02, 
                0x58, 
                0x00, 
                0x00
            })
            Name (PT0A, Package (0x06)
            {
                0x05, 
                0x00, 
                0x03, 
                0x20, 
                0x00, 
                0x00
            })
            Name (PT0B, Package (0x06)
            {
                0x05, 
                0xA0, 
                0x03, 
                0x84, 
                0x00, 
                0x00
            })
            Name (PT0C, Package (0x06)
            {
                0x06, 
                0x90, 
                0x04, 
                0x1A, 
                0x00, 
                0x00
            })
            Name (PT0D, Package (0x06)
            {
                0x07, 
                0x80, 
                0x04, 
                0xB0, 
                0x00, 
                0x00
            })
            Name (PT0E, Package (0x06)
            {
                0x05, 
                0x00, 
                0x03, 
                0x00, 
                0x00, 
                0x00
            })
            Method (MTCH, 2, NotSerialized)
            {
                If (LNotEqual (DerefOf (Index (Arg0, 0x00)), DerefOf (Index (
                    Arg1, 0x00))))
                {
                    Return (Zero)
                }

                If (LNotEqual (DerefOf (Index (Arg0, 0x01)), DerefOf (Index (
                    Arg1, 0x01))))
                {
                    Return (Zero)
                }

                If (LNotEqual (DerefOf (Index (Arg0, 0x02)), DerefOf (Index (
                    Arg1, 0x02))))
                {
                    Return (Zero)
                }

                If (LNotEqual (DerefOf (Index (Arg0, 0x03)), DerefOf (Index (
                    Arg1, 0x03))))
                {
                    Return (Zero)
                }

                If (LNotEqual (DerefOf (Index (Arg0, 0x04)), DerefOf (Index (
                    Arg1, 0x04))))
                {
                    Return (Zero)
                }

                If (LNotEqual (DerefOf (Index (Arg0, 0x05)), DerefOf (Index (
                    Arg1, 0x05))))
                {
                    Return (Zero)
                }

                Return (One)
            }

            Method (SPFC, 6, Serialized)
            {
                Store (ToInteger (Arg0), Index (VALI, 0x00))
                Store (ToInteger (Arg1), Index (VALI, 0x01))
                Store (ToInteger (Arg2), Index (VALI, 0x02))
                Store (ToInteger (Arg3), Index (VALI, 0x03))
                Store (ToInteger (Arg4), Index (VALI, 0x04))
                Store (ToInteger (Arg5), Index (VALI, 0x05))
                Store (Zero, Index (VALO, 0x01))
                Store (Zero, Index (VALO, 0x02))
                Store (Zero, Index (VALO, 0x03))
                Store (Zero, Index (VALO, 0x04))
                Store (Zero, Index (VALO, 0x05))
                Store (ToInteger (Arg0), \_SB.PCI0.LPC0.BLK0)
                Store (ToInteger (Arg1), \_SB.PCI0.LPC0.BLK1)
                Store (ToInteger (Arg2), \_SB.PCI0.LPC0.BLK2)
                Store (ToInteger (Arg3), \_SB.PCI0.LPC0.BLK3)
                Store (ToInteger (Arg4), \_SB.PCI0.LPC0.BLK4)
                Store (ToInteger (Arg5), \_SB.PCI0.LPC0.BLK5)
                Store (0x00, CECF)
                Store (ToInteger (Arg1), Local0)
                And (Local0, 0x00FFFFFF, Local0)
                While (One)
                {
                    Name (T_0, 0x00)
                    Store (ToInteger (Local0), T_0)
                    If (LEqual (T_0, 0x56))
                    {
                        If (MTCH (VALI, GWFS))
                        {
                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Store (\_SB.PCI0.LPC0.EC0.KSWH, Local0)
                            XOr (Local0, 0x01, Local0)
                            Store (VRFS, Local1)
                            ShiftLeft (Local1, 0x09, Local1)
                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                            If (Local0)
                            {
                                Or (Local0, Local1, Local0)
                            }

                            Store (Local0, Index (VALO, 0x02))
                            Store (Zero, Index (VALO, 0x00))
                        }
                        Else
                        {
                            If (MTCH (VALI, SWRN))
                            {
                                \_SB.PCI0.LPC0.PHSR (0x0B, 0x23)
                                Store (Zero, Index (VALO, 0x00))
                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                Store (\_SB.PCI0.LPC0.WLAN, \_SB.PCI0.LPC0.EC0.WLAN)
                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                Store (0x01, VRFS)
                            }
                            Else
                            {
                                If (MTCH (VALI, SWRF))
                                {
                                    \_SB.PCI0.LPC0.PHSR (0x0B, 0x24)
                                    Store (Zero, Index (VALO, 0x00))
                                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                    Store (\_SB.PCI0.LPC0.WLAN, \_SB.PCI0.LPC0.EC0.WLAN)
                                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                    Store (0x00, VRFS)
                                }
                                Else
                                {
                                    Store (0x8000, Index (VALO, 0x00))
                                }
                            }
                        }
                    }
                    Else
                    {
                        If (LEqual (T_0, 0x050E))
                        {
                            If (MTCH (VALI, GTPS))
                            {
                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                Store (\_SB.PCI0.LPC0.EC0.TPAD, Local0)
                                XOr (Local0, 0x01, Local0)
                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                Store (Local0, Index (VALO, 0x02))
                                Store (Zero, Index (VALO, 0x00))
                            }
                            Else
                            {
                                If (MTCH (VALI, STPE))
                                {
                                    \_SB.PCI0.LPC0.PHSR (0x07, 0x5A)
                                    Store (Zero, Index (VALO, 0x00))
                                }
                                Else
                                {
                                    If (MTCH (VALI, STPD))
                                    {
                                        \_SB.PCI0.LPC0.PHSR (0x07, 0x5B)
                                        Store (Zero, Index (VALO, 0x00))
                                    }
                                    Else
                                    {
                                        Store (0x8000, Index (VALO, 0x00))
                                    }
                                }
                            }
                        }
                        Else
                        {
                            If (LEqual (T_0, 0x5A))
                            {
                                If (MTCH (VALI, FNDS))
                                {
                                    \_SB.PCI0.LPC0.PHSR (0x0C, 0x00)
                                    Store (Zero, Index (VALO, 0x00))
                                }
                                Else
                                {
                                    If (MTCH (VALI, FNTP))
                                    {
                                        \_SB.PCI0.LPC0.PHSR (0x0C, 0x01)
                                        Store (Zero, Index (VALO, 0x00))
                                    }
                                    Else
                                    {
                                        If (MTCH (VALI, FNTC))
                                        {
                                            \_SB.PCI0.LPC0.PHSR (0x0C, 0x02)
                                            Store (Zero, Index (VALO, 0x00))
                                        }
                                        Else
                                        {
                                            Store (0x8000, Index (VALO, 0x00))
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                If (LEqual (T_0, 0x7F))
                                {
                                    If (MTCH (VALI, GCCM))
                                    {
                                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                        Store (\_SB.PCI0.LPC0.EC0.TMOD, Local0)
                                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                        Store (Local0, Index (VALO, 0x02))
                                        Store (0x01, Index (VALO, 0x03))
                                        Store (Zero, Index (VALO, 0x00))
                                    }
                                    Else
                                    {
                                        If (MTCH (VALI, SCMP))
                                        {
                                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                            Store (0x00, \_SB.PCI0.LPC0.EC0.TMOD)
                                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                            \_SB.PCI0.LPC0.PHSR (0x0A, 0x00)
                                            Store (Zero, Index (VALO, 0x00))
                                        }
                                        Else
                                        {
                                            If (MTCH (VALI, SCMS))
                                            {
                                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                                Store (0x01, \_SB.PCI0.LPC0.EC0.TMOD)
                                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                                \_SB.PCI0.LPC0.PHSR (0x0A, 0x01)
                                                Store (Zero, Index (VALO, 0x00))
                                            }
                                            Else
                                            {
                                                Store (0x8000, Index (VALO, 0x00))
                                            }
                                        }
                                    }
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x62))
                                    {
                                        If (MTCH (VALI, CESS))
                                        {
                                            If (LEqual (\_SB.PCI0.LPC0.ENSR, 0x02))
                                            {
                                                Store (0x21, Index (VALO, 0x03))
                                            }
                                            Else
                                            {
                                                Store (Zero, Index (VALO, 0x03))
                                            }

                                            Store (Zero, Index (VALO, 0x00))
                                        }
                                        Else
                                        {
                                            Store (0x8000, Index (VALO, 0x00))
                                        }
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, 0x11))
                                        {
                                            Name (PBUF, Buffer (0x0200)
                                            {
                                                0x00
                                            })
                                            CreateField (PBUF, 0x00, 0x08, P000)
                                            CreateField (PBUF, 0x08, 0x08, P001)
                                            CreateField (PBUF, 0x10, 0x08, P002)
                                            CreateField (PBUF, 0x18, 0x08, P003)
                                            If (MTCH (VALI, GPNL))
                                            {
                                                \_SB.QWMI.PHSR (0x0B, 0x00)
                                                Store (\_SB.PCI0.LPC0.OWNS, PBUF)
                                                Store (ToInteger (P000), Index (PANS, 0x00))
                                                Store (ToInteger (P001), Index (PANS, 0x01))
                                                Store (ToInteger (P002), Index (PANS, 0x02))
                                                Store (ToInteger (P003), Index (PANS, 0x03))
                                                If (MTCH (PANS, PT01))
                                                {
                                                    Store (0x00, Local0)
                                                }
                                                Else
                                                {
                                                    If (MTCH (PANS, PT02))
                                                    {
                                                        Store (0x0100, Local0)
                                                    }
                                                    Else
                                                    {
                                                        If (MTCH (PANS, PT03))
                                                        {
                                                            Store (0x0200, Local0)
                                                        }
                                                        Else
                                                        {
                                                            If (MTCH (PANS, PT04))
                                                            {
                                                                Store (0x0300, Local0)
                                                            }
                                                            Else
                                                            {
                                                                If (MTCH (PANS, PT05))
                                                                {
                                                                    Store (0x0400, Local0)
                                                                }
                                                                Else
                                                                {
                                                                    If (MTCH (PANS, PT06))
                                                                    {
                                                                        Store (0x0500, Local0)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (MTCH (PANS, PT07))
                                                                        {
                                                                            Store (0x0600, Local0)
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (MTCH (PANS, PT08))
                                                                            {
                                                                                Store (0x0700, Local0)
                                                                            }
                                                                            Else
                                                                            {
                                                                                If (MTCH (PANS, PT09))
                                                                                {
                                                                                    Store (0x0800, Local0)
                                                                                }
                                                                                Else
                                                                                {
                                                                                    If (MTCH (PANS, PT0A))
                                                                                    {
                                                                                        Store (0x0900, Local0)
                                                                                    }
                                                                                    Else
                                                                                    {
                                                                                        If (MTCH (PANS, PT0B))
                                                                                        {
                                                                                            Store (0x0A00, Local0)
                                                                                        }
                                                                                        Else
                                                                                        {
                                                                                            If (MTCH (PANS, PT0C))
                                                                                            {
                                                                                                Store (0x0B00, Local0)
                                                                                            }
                                                                                            Else
                                                                                            {
                                                                                                If (MTCH (PANS, PT0D))
                                                                                                {
                                                                                                    Store (0x0C00, Local0)
                                                                                                }
                                                                                                Else
                                                                                                {
                                                                                                    If (MTCH (PANS, PT0E))
                                                                                                    {
                                                                                                        Store (0x0D00, Local0)
                                                                                                    }
                                                                                                    Else
                                                                                                    {
                                                                                                        Store (0xFFFF, Local0)
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }

                                                Store (Zero, Index (VALO, 0x00))
                                                Store (Local0, Index (VALO, 0x02))
                                            }
                                            Else
                                            {
                                                Store (0x8000, Index (VALO, 0x00))
                                            }
                                        }
                                        Else
                                        {
                                            If (LEqual (T_0, 0xC000))
                                            {
                                                If (MTCH (VALI, SHK0))
                                                {
                                                    Store (Zero, Index (VALO, 0x00))
                                                }
                                                Else
                                                {
                                                    If (MTCH (VALI, SHK1))
                                                    {
                                                        Store (Zero, Index (VALO, 0x00))
                                                    }
                                                    Else
                                                    {
                                                        If (MTCH (VALI, GHKM))
                                                        {
                                                            Store (Zero, Index (VALO, 0x03))
                                                            Store (Zero, Index (VALO, 0x00))
                                                            Store (Zero, Local0)
                                                            If (LEqual (\_SB.PCI0.LPC0.HDME, 0x01))
                                                            {
                                                                If (LEqual (\_SB.PCI0.LPC0.EC0.LIDS, 0x00))
                                                                {
                                                                    Or (Local0, 0x00, Local0)
                                                                }
                                                                Else
                                                                {
                                                                    Or (Local0, 0x10, Local0)
                                                                }

                                                                Store (Local0, Index (VALO, 0x03))
                                                            }
                                                        }
                                                        Else
                                                        {
                                                            Store (0x8000, Index (VALO, 0x00))
                                                        }
                                                    }
                                                }
                                            }
                                            Else
                                            {
                                                If (LEqual (T_0, 0x1E))
                                                {
                                                    If (MTCH (VALI, SBED))
                                                    {
                                                        Store (0x00, VBFG)
                                                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                                        Store (One, \_SB.PCI0.LPC0.EC0.HEUE)
                                                        Store (One, \_SB.PCI0.LPC0.EC0.BEUE)
                                                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                                        Store (Zero, Index (VALO, 0x00))
                                                    }
                                                    Else
                                                    {
                                                        If (MTCH (VALI, SBEE))
                                                        {
                                                            Store (0x02, VBFG)
                                                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                                            Store (One, \_SB.PCI0.LPC0.EC0.HEUE)
                                                            Store (Zero, \_SB.PCI0.LPC0.EC0.BEUE)
                                                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                                            Store (Zero, Index (VALO, 0x00))
                                                        }
                                                        Else
                                                        {
                                                            If (MTCH (VALI, SHEE))
                                                            {
                                                                Store (0x08, VBFG)
                                                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                                                Store (Zero, \_SB.PCI0.LPC0.EC0.HEUE)
                                                                Store (One, \_SB.PCI0.LPC0.EC0.BEUE)
                                                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                                                Store (Zero, Index (VALO, 0x00))
                                                            }
                                                            Else
                                                            {
                                                                If (MTCH (VALI, SBHE))
                                                                {
                                                                    Store (0x0A, VBFG)
                                                                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                                                    Store (Zero, \_SB.PCI0.LPC0.EC0.HEUE)
                                                                    Store (Zero, \_SB.PCI0.LPC0.EC0.BEUE)
                                                                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                                                    Store (Zero, Index (VALO, 0x00))
                                                                }
                                                                Else
                                                                {
                                                                    If (MTCH (VALI, GBEM))
                                                                    {
                                                                        Store (VBFG, Local0)
                                                                        Store (Increment (Local0), Index (VALO, 0x02))
                                                                        Store (Zero, Index (VALO, 0x00))
                                                                    }
                                                                    Else
                                                                    {
                                                                        Store (0x8000, Index (VALO, 0x00))
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_0, 0x0154))
                                                    {
                                                        \_SB.PCI0.LPC0.PHSR (0x12, 0x00)
                                                        Store (0x55, CECF)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T_0, 0x0155))
                                                        {
                                                            \_SB.PCI0.LPC0.PHSR (0x12, 0x01)
                                                            Store (0x55, CECF)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T_0, 0x8F))
                                                            {
                                                                \_SB.PCI0.LPC0.PHSR (0x12, 0x02)
                                                                Store (0x55, CECF)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T_0, 0x00C0008F))
                                                                {
                                                                    \_SB.PCI0.LPC0.PHSR (0x12, 0x03)
                                                                    Store (0x55, CECF)
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (T_0, 0x00C2008F))
                                                                    {
                                                                        \_SB.PCI0.LPC0.PHSR (0x12, 0x04)
                                                                        Store (0x55, CECF)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (T_0, 0x00C9008F))
                                                                        {
                                                                            \_SB.PCI0.LPC0.PHSR (0x12, 0x05)
                                                                            Store (0x55, CECF)
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (T_0, 0xC000))
                                                                            {
                                                                                \_SB.PCI0.LPC0.PHSR (0x12, 0x08)
                                                                                Store (0x55, CECF)
                                                                            }
                                                                            Else
                                                                            {
                                                                                If (LEqual (T_0, 0x014E))
                                                                                {
                                                                                    If (MTCH (VALI, LEDG))
                                                                                    {
                                                                                        \_SB.PCI0.LPC0.PHSR (0x11, 0x02)
                                                                                        Store (\_SB.PCI0.LPC0.INF, Index (VALO, 0x02))
                                                                                        Store (One, Index (VALO, 0x01))
                                                                                        Store (Zero, Index (VALO, 0x00))
                                                                                    }
                                                                                    Else
                                                                                    {
                                                                                        If (MTCH (VALI, LED0))
                                                                                        {
                                                                                            \_SB.PCI0.LPC0.PHSR (0x11, 0x00)
                                                                                            Store (One, Index (VALO, 0x01))
                                                                                            Store (Zero, Index (VALO, 0x00))
                                                                                        }
                                                                                        Else
                                                                                        {
                                                                                            If (MTCH (VALI, LED1))
                                                                                            {
                                                                                                \_SB.PCI0.LPC0.PHSR (0x11, 0x01)
                                                                                                Store (One, Index (VALO, 0x01))
                                                                                                Store (Zero, Index (VALO, 0x00))
                                                                                            }
                                                                                            Else
                                                                                            {
                                                                                                Store (0x8300, Index (VALO, 0x00))
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                                Else
                                                                                {
                                                                                    If (LEqual (T_0, 0x47))
                                                                                    {
                                                                                        If (MTCH (VALI, RMGW))
                                                                                        {
                                                                                            Store (Zero, Index (VALO, 0x00))
                                                                                            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                                                                            Store (\_SB.PCI0.LPC0.EC0.DALB, Local0)
                                                                                            Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                                                                            Store (0x00, Index (VALO, 0x02))
                                                                                            Store (Local0, Index (VALO, 0x03))
                                                                                            If (LEqual (Local0, 0x66))
                                                                                            {
                                                                                                Store (0x20, Index (VALO, 0x02))
                                                                                            }
                                                                                            Else
                                                                                            {
                                                                                                If (LEqual (Local0, 0x67))
                                                                                                {
                                                                                                    Store (0x20, Index (VALO, 0x02))
                                                                                                }
                                                                                                Else
                                                                                                {
                                                                                                    If (LEqual (Local0, 0x8C))
                                                                                                    {
                                                                                                        Store (0x20, Index (VALO, 0x02))
                                                                                                    }
                                                                                                    Else
                                                                                                    {
                                                                                                        If (LEqual (Local0, 0x90))
                                                                                                        {
                                                                                                            Store (0x20, Index (VALO, 0x02))
                                                                                                        }
                                                                                                        Else
                                                                                                        {
                                                                                                            If (LEqual (Local0, 0xC0))
                                                                                                            {
                                                                                                                \_SB.PCI0.LPC0.PHSR (0x12, 0x07)
                                                                                                                Store (0x55, CECF)
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        Else
                                                                                        {
                                                                                            If (MTCH (VALI, RMCW))
                                                                                            {
                                                                                                Store (Zero, Index (VALO, 0x00))
                                                                                                Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                                                                                                Store (0x00, \_SB.PCI0.LPC0.EC0.DALB)
                                                                                                Release (\_SB.PCI0.LPC0.EC0.MUT1)
                                                                                            }
                                                                                            Else
                                                                                            {
                                                                                                Store (0x8300, Index (VALO, 0x00))
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    Else
                                                                                    {
                                                                                        If (LEqual (T_0, 0x61))
                                                                                        {
                                                                                            If (MTCH (VALI, RMGS))
                                                                                            {
                                                                                                Store (Zero, Index (VALO, 0x00))
                                                                                                \_SB.QWMI.PHSR (0x14, 0x02)
                                                                                                Store (\_SB.PCI0.LPC0.INF, Index (VALO, 0x02))
                                                                                            }
                                                                                            Else
                                                                                            {
                                                                                                If (MTCH (VALI, RMSD))
                                                                                                {
                                                                                                    Store (Zero, Index (VALO, 0x00))
                                                                                                    Store (0x00, \_SB.PCI0.LPC0.INF)
                                                                                                }
                                                                                                Else
                                                                                                {
                                                                                                    If (MTCH (VALI, RMSE))
                                                                                                    {
                                                                                                        Store (Zero, Index (VALO, 0x00))
                                                                                                        Store (0x01, \_SB.PCI0.LPC0.INF)
                                                                                                    }
                                                                                                    Else
                                                                                                    {
                                                                                                        Store (0x8300, Index (VALO, 0x00))
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        Else
                                                                                        {
                                                                                            Store (0x8000, Index (VALO, 0x00))
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Break
                }

                If (LEqual (CECF, 0x55))
                {
                    Store (\_SB.PCI0.LPC0.BLK0, Index (VALO, 0x00))
                    Store (\_SB.PCI0.LPC0.BLK1, Index (VALO, 0x01))
                    Store (\_SB.PCI0.LPC0.BLK2, Index (VALO, 0x02))
                    Store (\_SB.PCI0.LPC0.BLK3, Index (VALO, 0x03))
                    Store (\_SB.PCI0.LPC0.BLK4, Index (VALO, 0x04))
                    Store (\_SB.PCI0.LPC0.BLK5, Index (VALO, 0x05))
                    Store (0x00, CECF)
                }

                Return (VALO)
            }
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (ACST, 0x00)
            Method (_PSR, 0, NotSerialized)
            {
                If (\_SB.ECOK)
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.ACDF, ACST)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                }
                Else
                {
                    Store (0x01, ACST)
                }

                If (ACST)
                {
                    Store (0x01, Local0)
                    Store (0x00, \_SB.BAT1.BCRI)
                }
                Else
                {
                    Store (0x00, Local0)
                }

                Return (Local0)
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (CBTI, 0x00)
            Name (PBTI, 0x00)
            Name (BTIN, 0x00)
            Name (BTCH, 0x00)
            Name (BIFI, 0x00)
            Name (SEL0, 0x00)
            Name (BCRI, 0x00)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0x0FA0, 
                0x0FA0, 
                0x01, 
                0x2B5C, 
                0x012C, 
                0x1E, 
                0x20, 
                0x20, 
                "PA3593U-1BRS", 
                "", 
                "LION      ", 
                "         "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                Z00D, 
                Z00D, 
                0x2710
            })
            Name (ERRC, 0x00)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Method (_STA, 0, NotSerialized)
            {
                If (BTIN)
                {
                    Return (0x1F)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (LEqual (BIFI, 0x00))
                {
                    \_SB.BAT1.UBIF ()
                    Store (0x01, BIFI)
                }

                Return (PBIF)
            }

            Name (LFCC, 0x1130)
            Method (UBIF, 0, NotSerialized)
            {
                If (\_SB.ECOK)
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.BTDC, Local0)
                    Store (\_SB.PCI0.LPC0.EC0.LFCC, Local1)
                    Store (\_SB.PCI0.LPC0.EC0.MBVG, Local2)
                    Store (\_SB.PCI0.LPC0.EC0.BTMD, Local3)
                    Store (\_SB.PCI0.LPC0.EC0.BTMN, Local4)
                    Store (\_SB.PCI0.LPC0.EC0.BTSN, Local5)
                    Store (\_SB.PCI0.LPC0.EC0.LION, Local6)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Store (Local0, Index (PBIF, 0x01))
                    Store (Local1, Index (PBIF, 0x02))
                    Store (Local2, Index (PBIF, 0x04))
                    Store (Local1, LFCC)
                    If (Local6)
                    {
                        Store ("NiMH", Index (PBIF, 0x0B))
                    }
                    Else
                    {
                        Store ("LION", Index (PBIF, 0x0B))
                    }

                    And (Local3, 0x0F, Local3)
                    If (LLessEqual (Local3, 0x08))
                    {
                        If (LEqual (Local3, 0x01))
                        {
                            Store ("NS1P3SZNJSWR", Index (PBIF, 0x09))
                        }
                        Else
                        {
                            If (LEqual (Local3, 0x02))
                            {
                                Store ("NS1P3SZNJSWO", Index (PBIF, 0x09))
                            }
                            Else
                            {
                                If (LEqual (Local3, 0x03))
                                {
                                    Store ("NS2P3SZNJ4WR", Index (PBIF, 0x09))
                                }
                                Else
                                {
                                    If (LEqual (Local3, 0x04))
                                    {
                                        Store ("NS2P3SZNJ4WO", Index (PBIF, 0x09))
                                    }
                                    Else
                                    {
                                        If (LEqual (Local3, 0x05))
                                        {
                                            Store ("NS2P3SZNJ5WR", Index (PBIF, 0x09))
                                        }
                                        Else
                                        {
                                            If (LEqual (Local3, 0x06))
                                            {
                                                Store ("NS2P3SZNJ5WO", Index (PBIF, 0x09))
                                            }
                                            Else
                                            {
                                                If (LEqual (Local3, 0x07))
                                                {
                                                    Store ("NS3P3SZNJSWR", Index (PBIF, 0x09))
                                                }
                                                Else
                                                {
                                                    If (LEqual (Local3, 0x08))
                                                    {
                                                        Store ("NS3P3SZNJSWO", Index (PBIF, 0x09))
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Else
                    {
                        If (LLessEqual (Local3, 0x10))
                        {
                            If (LEqual (Local3, 0x09))
                            {
                                Store ("PA3592U-1BRS", Index (PBIF, 0x09))
                            }
                            Else
                            {
                                If (LEqual (Local3, 0x0A))
                                {
                                    Store ("PA3592U-1BAS", Index (PBIF, 0x09))
                                }
                                Else
                                {
                                    If (LEqual (Local3, 0x0B))
                                    {
                                        Store ("PA3593U-1BRS", Index (PBIF, 0x09))
                                    }
                                    Else
                                    {
                                        If (LEqual (Local3, 0x0C))
                                        {
                                            Store ("PA3593U-1BAS", Index (PBIF, 0x09))
                                        }
                                        Else
                                        {
                                            If (LEqual (Local3, 0x0D))
                                            {
                                                Store ("PA3594U-1BRS", Index (PBIF, 0x09))
                                            }
                                            Else
                                            {
                                                If (LEqual (Local3, 0x0E))
                                                {
                                                    Store ("PA3594U-1BAS", Index (PBIF, 0x09))
                                                }
                                                Else
                                                {
                                                    If (LEqual (Local3, 0x0F))
                                                    {
                                                        Store ("PA3595U-1BRS", Index (PBIF, 0x09))
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (Local3, 0x10))
                                                        {
                                                            Store ("PA3595U-1BAS", Index (PBIF, 0x09))
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Else
                        {
                            If (LLessEqual (Local3, 0x14))
                            {
                                If (LEqual (Local3, 0x11))
                                {
                                    Store ("PABAS109", Index (PBIF, 0x09))
                                }
                                Else
                                {
                                    If (LEqual (Local3, 0x12))
                                    {
                                        Store ("PABAS110", Index (PBIF, 0x09))
                                    }
                                    Else
                                    {
                                        If (LEqual (Local3, 0x13))
                                        {
                                            Store ("PABAS111", Index (PBIF, 0x09))
                                        }
                                        Else
                                        {
                                            If (LEqual (Local3, 0x14))
                                            {
                                                Store ("PABAS112", Index (PBIF, 0x09))
                                            }
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                Store ("UNKNOWN", Index (PBIF, 0x09))
                            }
                        }
                    }

                    If (LEqual (Local4, 0x05))
                    {
                        Store ("Panasonic", Index (PBIF, 0x0C))
                    }
                    Else
                    {
                        If (LEqual (Local4, 0x03))
                        {
                            Store ("SANYO", Index (PBIF, 0x0C))
                        }
                        Else
                        {
                            Store ("UNKNOWN", Index (PBIF, 0x0C))
                        }
                    }

                    Store (ITOS (ToBCD (Local5)), Index (PBIF, 0x0A))
                }
            }

            Name (RCAP, 0x00)
            Method (_BST, 0, NotSerialized)
            {
                If (LEqual (BTIN, 0x00))
                {
                    Store (0x00, Index (PBST, 0x00))
                    Store (0xFFFFFFFF, Index (PBST, 0x01))
                    Store (0xFFFFFFFF, Index (PBST, 0x02))
                    Store (0xFFFFFFFF, Index (PBST, 0x03))
                    Return (PBST)
                }

                If (\_SB.ECOK)
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.MBTC, Local0)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.MBRM, Local1)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.MBVG, Local2)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.MCUR, Local3)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.BTST, Local4)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.MBTF, Local5)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.ACDF, Local6)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    If (Local6)
                    {
                        If (LEqual (Local5, 0x01))
                        {
                            Store (0x00, Local7)
                            Store (LFCC, Local1)
                        }
                        Else
                        {
                            If (LEqual (Local0, 0x01))
                            {
                                Store (0x02, Local7)
                            }
                            Else
                            {
                                Store (0x00, Local7)
                            }
                        }
                    }
                    Else
                    {
                        If (LAnd (Local4, 0x01))
                        {
                            Store (0x01, Local7)
                        }
                        Else
                        {
                            Store (0x00, Local7)
                        }
                    }

                    And (Local4, 0x04, Local4)
                    If (LEqual (Local4, 0x04))
                    {
                        Or (Local7, Local4, Local7)
                    }

                    Store (Local7, Index (PBST, 0x00))
                    If (LNot (And (Local1, 0x8000)))
                    {
                        Store (Local1, Index (PBST, 0x02))
                    }

                    If (LNot (And (Local2, 0x8000)))
                    {
                        Store (Local2, Index (PBST, 0x03))
                    }

                    If (LAnd (Local3, 0x8000))
                    {
                        If (LNotEqual (Local3, 0xFFFF))
                        {
                            Not (Local3, Local3)
                            Increment (Local3)
                            And (Local3, 0xFFFF, Local3)
                        }
                    }

                    Store (Local3, Index (PBST, 0x01))
                }

                Return (PBST)
            }

            Method (BSTA, 0, NotSerialized)
            {
                If (\_SB.ECOK)
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Store (\_SB.PCI0.LPC0.EC0.MBTS, Local0)
                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                    If (LEqual (Local0, 0x01))
                    {
                        If (LEqual (\_SB.BAT1.BTIN, 0x00))
                        {
                            Store (0x01, \_SB.BAT1.BTCH)
                            Store (0x00, \_SB.BAT1.BIFI)
                        }

                        Store (0x01, \_SB.BAT1.BTIN)
                    }
                    Else
                    {
                        If (LEqual (\_SB.BAT1.BTIN, 0x01))
                        {
                            Store (0x01, \_SB.BAT1.BTCH)
                            Store (0x00, \_SB.BAT1.BIFI)
                        }

                        Store (0x00, \_SB.BAT1.BTIN)
                    }
                }
            }
        }

        Scope (\_TZ)
        {
            ThermalZone (THRM)
            {
                Method (_TMP, 0, NotSerialized)
                {
                    If (\_SB.ECOK)
                    {
                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                        Store (\_SB.PCI0.LPC0.EC0.CTMP, Local0)
                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                        Return (Add (Multiply (Local0, 0x0A), 0x0AAC))
                    }

                    Return (0x0C3C)
                }

                Method (_PSL, 0, Serialized)
                {
                    Return (Package (0x01)
                    {
                        \_PR.CPU0
                    })
                }

                Method (_CRT, 0, Serialized)
                {
                    Return (Add (0x0AAC, Multiply (0x69, 0x0A)))
                }

                Method (_PSV, 0, Serialized)
                {
                    Return (Add (0x0AAC, Multiply (0x61, 0x0A)))
                }

                Name (_TC1, 0x02)
                Name (_TC2, 0x03)
                Name (_TSP, 0x28)
            }
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (LSTS, 0x00)
            Method (_LID, 0, NotSerialized)
            {
                If (LEqual (\_SB.INS3, 0x55))
                {
                    Store (0x00, \_SB.INS3)
                    Return (0x01)
                }

                If (\_SB.ECOK)
                {
                    Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    If (LDSS)
                    {
                        Store (Zero, LSTS)
                    }
                    Else
                    {
                        Store (One, LSTS)
                    }

                    Release (\_SB.PCI0.LPC0.EC0.MUT1)
                }
                Else
                {
                    Store (One, LSTS)
                }

                Return (LSTS)
            }

            Name (_PRW, Package (0x02)
            {
                0x17, 
                0x04
            })
            Method (_PSW, 1, NotSerialized)
            {
                If (Arg0)
                {
                    Store (One, SSTS)
                }
                Else
                {
                    Store (Zero, SSTS)
                }
            }

            Scope (\_GPE)
            {
                Method (_L17, 0, NotSerialized)
                {
                    Notify (\_SB.LID, 0x80)
                }
            }
        }
    }

    Scope (\_GPE)
    {
        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.P2P, 0x02)
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.OHC1, 0x02)
            Notify (\_SB.PCI0.OHC2, 0x02)
            Notify (\_SB.PCI0.OHC3, 0x02)
        }

        Method (_L10, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.HDAU, 0x02)
        }

        Method (_L14, 0, NotSerialized)
        {
            Name (HPOK, 0x00)
            If (\_SB.PCI0.SMB.GM1C)
            {
                Sleep (0x14)
                Store (\_SB.PCI0.LPC0.RGPM (), Local0)
                If (And (Local0, 0x02))
                {
                    Store (0x00, \_SB.PCI0.SMB.GM1C)
                    Store ("HotPlug:04: Removal Event", Debug)
                    Store (0x08, \_SB.PCI0.PB7.SLST)
                    Store (\_SB.PCI0.PB7.NCRD.DVID, Local7)
                    Sleep (0x0A)
                    Store (0x01, Local4)
                    Store (0x05, Local5)
                    While (LAnd (Local4, Local5))
                    {
                        Store (\_SB.PCI0.PB7.XPRD (0xA5), Local6)
                        And (Local6, 0x7F, Local6)
                        If (LLessEqual (Local6, 0x04))
                        {
                            Store (0x00, Local4)
                        }
                        Else
                        {
                            Store (\_SB.PCI0.PB7.NCRD.DVID, Local7)
                            Sleep (0x05)
                            Decrement (Local5)
                        }
                    }

                    \_SB.PCI0.XPTR (0x07, 0x00)
                    \_SB.PCI0.PB7.XPLP (0x00)
                    Store (0x01, HPOK)
                }
            }
            Else
            {
                Sleep (0x14)
                Store (\_SB.PCI0.LPC0.RGPM (), Local0)
                If (LNot (And (Local0, 0x02)))
                {
                    Store (0x01, \_SB.PCI0.SMB.GM1C)
                    Store ("HotPlug:04: Insertion Event", Debug)
                    Store (0x00, HPOK)
                    \_SB.PCI0.PB7.XPLP (0x01)
                    Sleep (0xC8)
                    \_SB.PCI0.XPTR (0x07, 0x01)
                    Sleep (0x14)
                    Store (0x00, Local2)
                    While (LLess (Local2, 0x0F))
                    {
                        Store (0x08, \_SB.PCI0.PB7.SLST)
                        Store (0x01, Local4)
                        Store (0xC8, Local5)
                        While (LAnd (Local4, Local5))
                        {
                            Store (\_SB.PCI0.PB7.XPRD (0xA5), Local6)
                            And (Local6, 0x7F, Local6)
                            If (LAnd (LGreaterEqual (Local6, 0x10), LNotEqual (Local6, 0x7F)))
                            {
                                Store ("HotPlug:04: TrainingState=0x10", Debug)
                                Store (0x00, Local4)
                            }
                            Else
                            {
                                Sleep (0x05)
                                Decrement (Local5)
                            }
                        }

                        If (LNot (Local4))
                        {
                            Store ("HotPlug:04: Check VC Negotiation Pending", Debug)
                            Store (\_SB.PCI0.PB7.XPDL (), Local5)
                            If (Local5)
                            {
                                Store ("HotPlug:04: Retraining Link", Debug)
                                \_SB.PCI0.PB7.XPRT ()
                                Sleep (0x05)
                                Increment (Local2)
                            }
                            Else
                            {
                                Store ("HotPlug:04: Device OK", Debug)
                                Store (0x20, \_SB.PCI0.LPC0.INFO)
                                Store (0x87, \_SB.PCI0.LPC0.BCMD)
                                Store (Zero, \_SB.PCI0.LPC0.SMIC)
                                If (LEqual (\_SB.PCI0.PB7.XPR2 (), Ones))
                                {
                                    Store (0x01, HPOK)
                                    Store (0x10, Local2)
                                }
                                Else
                                {
                                    Store ("HotPlug:04: Common Clock Retraining Failed", Debug)
                                    Store (0x00, HPOK)
                                    Store (0x10, Local2)
                                }
                            }
                        }
                        Else
                        {
                            Store ("HotPlug:04: TrainingState Timeout", Debug)
                            Store (0x10, Local2)
                        }
                    }

                    If (LNot (HPOK))
                    {
                        Store ("HotPlug:04: Insertion Failed: Disable Training & PowerDown", Debug)
                        Store (\_SB.PCI0.PB7.NCRD.DVID, Local7)
                        Sleep (0x0A)
                        Store (0x01, Local4)
                        Store (0x05, Local5)
                        While (LAnd (Local4, Local5))
                        {
                            Store (\_SB.PCI0.PB7.XPRD (0xA5), Local6)
                            And (Local6, 0x7F, Local6)
                            If (LLessEqual (Local6, 0x04))
                            {
                                Store (0x00, Local4)
                            }
                            Else
                            {
                                Store (\_SB.PCI0.PB7.NCRD.DVID, Local7)
                                Sleep (0x05)
                                Decrement (Local5)
                            }
                        }

                        \_SB.PCI0.XPTR (0x07, 0x00)
                        \_SB.PCI0.PB7.XPLP (0x00)
                    }
                }
            }

            If (HPOK)
            {
                Notify (\_SB.PCI0.PB7, 0x00)
            }
        }
    }
}

