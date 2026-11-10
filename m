Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83D606A334
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:33:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BB4F40285;
	Tue, 10 Nov 2026 13:33:05 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 61A2D40281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:33:04 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4F5E74D5D2; Tue, 10 Nov 2026 13:33:04 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2102] net/ice: ice_get_module_eeprom() can read the
 wrong page when a block straddles a 256-byte boundary
Date: Tue, 10 Nov 2026 12:33:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marcel@telka.sk
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2102-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2102

            Bug ID: 2102
           Summary: net/ice: ice_get_module_eeprom() can read the wrong
                    page when a block straddles a 256-byte boundary
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: marcel@telka.sk
  Target Milestone: ---

https://github.com/DPDK/dpdk/blob/a13c1053360ee26bbacca9f883d3f3cb83a0f366/=
drivers/net/intel/ice/ice_ethdev.c#L6683-L6772

for (i =3D 0; i < info->length; i +=3D SFF_READ_BLOCK_SIZE) {
    offset =3D i + info->offset;
    page =3D 0;

    /* Check if we need to access the other memory page */
    if (is_sfp) {
        if (offset >=3D ICE_MODULE_SFF_8079_LEN) {
            offset -=3D ICE_MODULE_SFF_8079_LEN;
            addr =3D ICE_I2C_EEPROM_DEV_ADDR2;
        }=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    } else {=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        while (offset >=3D ICE_MODULE_SFF_8436_LEN) {
            offset -=3D ICE_MODULE_SFF_8436_LEN / 2;
            page++;
        }=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    }=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
    ...
    status =3D ice_aq_sff_eeprom(hw, 0, addr, offset, page, !is_sfp, value,
                               SFF_READ_BLOCK_SIZE, 0, NULL);
    ...
    if ((i + SFF_READ_BLOCK_SIZE) <=3D info->length)
        memcpy(data + i, value, SFF_READ_BLOCK_SIZE);
}=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20

The page/address switch is computed once per 8-byte block, from that
block's starting offset only. Nothing checks whether offset +
SFF_READ_BLOCK_SIZE actually stays within the same page/address before
issuing the read, so a block that starts just below a boundary is
still issued as a single read against that one address/page -- the
bytes before the boundary come back correct, but the trailing bytes
past it are read from whatever happens to sit at that same local
offset on the wrong side, and that wrong data is copied into the
caller's buffer along with the rest.

1. SFP (is_sfp branch): A0h/A2h straddle, and past A2h's own end.
A call with info->offset=3D253, info->length=3D8 has its one block at
offset=3D253, which is < 256 so it's read entirely from A0h, bytes
253-260 -- but bytes 256-260 actually belong to A2h. That wrong data
is copied to the caller.
The same kind of gap exists at A2h's own end: info->offset=3D505,
info->length=3D8 computes offset=3D505-256=3D249 on A2h, reading local
A2h bytes 249-256 -- byte 256 is past A2h's own 256-byte range.

2. QSFP (else branch): wrong page for the straddling tail bytes.
A call with info->offset=3D250, info->length=3D8 has its one block at
offset=3D250, page=3D0 (since 250 < 256), reading bytes 250-257 -- but
bytes 256-257 belong to the next page. That wrong data is copied to
the caller. The same gap recurs at every subsequent page boundary.

Likely consequence in all cases (not empirically tested): wrong byte=20=20=
=20=20=20=20=20=20=20=20=20=20
values returned to the caller under a fully successful status, for
any read whose block happens to straddle one of these boundaries.=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20

What happens for an offset far past any valid range differs between=20=20=
=20=20=20=20=20=20=20=20=20=20=20
the two branches:
- SFP: info->offset=3D600 computes offset=3D600-256=3D344 (only one
  subtraction, no loop) and addr=3DA2h. 344 (0x158) fails the=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  mem_addr & 0xff00 check in ice_aq_sff_eeprom() below, so this case
  at least returns an error (ICE_ERR_PARAM) instead of silently
  reading garbage.
- QSFP: the while loop keeps subtracting 128 and incrementing page
  for as long as offset >=3D 256, with no upper bound on page. There is
  no equivalent range check on page anywhere -- the result of asking
  for a page number the module doesn't implement is undefined from
  the driver's side and would depend on the module's own hardware
  behavior.=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

https://github.com/DPDK/dpdk/blob/a13c1053360ee26bbacca9f883d3f3cb83a0f366/=
drivers/net/intel/ice/base/ice_common.c#L4350-L4379

int=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
ice_aq_sff_eeprom(struct ice_hw *hw, u16 lport, u8 bus_addr,=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                  u16 mem_addr, u8 page, u8 set_page, u8 *data, u8 length,
                  bool write, struct ice_sq_cd *cd)
{=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
    ...=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
    if (!data || (mem_addr & 0xff00))=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
        return ICE_ERR_PARAM;
    ...
}=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20

ice_aq_sff_eeprom() validates the starting mem_addr but never checks
mem_addr + length against the page boundary, and never validates page
at all.

Suggested fix:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

Hardening ice_aq_sff_eeprom() to also reject mem_addr + length >=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
0xff would catch some out-of-range cases earlier, but that alone is
not a fix and must not be the only change: ice_get_module_eeprom()
always requests a fixed SFF_READ_BLOCK_SIZE (8) bytes regardless of
how much of that block the caller actually needs, so a legitimate
small request (e.g. offset=3D250, length=3D4) would start failing outright
once such a check is added, even though it never needed the
straddling bytes in the first place.

The required fix belongs in ice_get_module_eeprom() itself. A single
I2C/admin-queue transaction cannot cross either boundary correctly in
the first place -- SFP's A0h and A2h are distinct I2C device=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
addresses, and QSFP's pages reuse the same address range with
different contents depending on which page was last selected, so a
straddling block was never going to be satisfiable as one read
regardless of any driver change. The fix is to check whether offset +
SFF_READ_BLOCK_SIZE crosses the relevant boundary and, if so, split
that iteration into two correctly-addressed sub-reads (switching
device address for SFP, or writing the new page-select value for
QSFP) instead of issuing one read spanning both. Each individual read
should also be sized to min(SFF_READ_BLOCK_SIZE, info->length - i)
rather than always requesting a full fixed 8 bytes, so a small
trailing request doesn't over-read into the next page for data nobody
asked for.

With that in place, adding the mem_addr + length check to
ice_aq_sff_eeprom() becomes reasonable defense-in-depth against any
other/future caller of that function, but it is not a substitute for
the ice_get_module_eeprom() fix above.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
