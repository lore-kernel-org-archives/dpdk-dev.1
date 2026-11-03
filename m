Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81A606B25D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D26A42F21;
	Tue,  3 Nov 2026 16:17:53 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 7982142F13
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:17:52 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 5D7474D521; Tue,  3 Nov 2026 16:17:52 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2091] net/ice: get_module_eeprom() silently drops
 trailing bytes when read length is not a multiple of 8
Date: Tue, 03 Nov 2026 15:17:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.11
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
Message-ID: <bug-2091-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2091

            Bug ID: 2091
           Summary: net/ice: get_module_eeprom() silently drops trailing
                    bytes when read length is not a multiple of 8
           Product: DPDK
           Version: 25.11
          Hardware: x86
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: marcel@telka.sk
  Target Milestone: ---

ice_get_module_eeprom() reads the transceiver EEPROM in fixed 8-byte blocks=
 via
ice_aq_sff_eeprom(). The hardware read happens unconditionally for every bl=
ock,
including a trailing partial one, but the copy into the caller's buffer is
gated by an all-or-nothing check:

https://github.com/DPDK/dpdk/blob/a13c1053360ee26bbacca9f883d3f3cb83a0f366/=
drivers/net/intel/ice/ice_ethdev.c#L6765-L6767

    /* Make sure we have enough room for the new block */
    if ((i + SFF_READ_BLOCK_SIZE) <=3D info->length)
        memcpy(data + i, value, SFF_READ_BLOCK_SIZE);

When info->length is not an exact multiple of SFF_READ_BLOCK_SIZE (8), the
final loop iteration reads the correct 8 bytes from the module into value[],
but the guard evaluates false (e.g. i=3D88, length=3D90: 88+8=3D96 > 90), s=
o the
memcpy is skipped entirely. Since the destination buffer is memset to 0 at
function entry, the trailing length % 8 bytes are silently returned as zero
instead of the real EEPROM content, with no error indication to the caller.

This is a different (and still-open) case of the same bug class fixed in
31f15787 ("net/ice: fix module EEPROM read", Oct 2022), which only addressed
the complementary edge case where length is an exact multiple of 8 (changing
the guard from < to <=3D). That fix did not address non-multiple lengths at=
 all.

The equivalent Linux kernel driver (ice_get_module_eeprom() in ice_ethtool.=
c)
had the same underlying bug and fixed it completely as CVE-2023-53142, by
replacing the all-or-nothing guard with a clamped partial copy:

https://github.com/torvalds/linux/commit/84cba1840e68430325ac133a11be06bfb2=
f7acd8

    /* Make sure we have enough room for the new block */
    copy_len =3D min_t(u32, SFF_READ_BLOCK_SIZE, ee->len - i);
    memcpy(data + i, value, copy_len);

The DPDK ice PMD never picked up this more complete fix.

Steps to Reproduce:
1. On a port using the ice PMD with an SFF-8472 transceiver attached, call
rte_eth_dev_get_module_eeprom() with offset=3D3, length=3D90 (deliberately =
not a
multiple of 8, e.g. the common "read compliance codes + vendor fields + DDM
type byte in one request, skip the padding gap before A2h" pattern).
2. Compare the returned buffer's last 2 bytes against an independent read of
the same EEPROM region (e.g. via the kernel ice driver + ethtool -m on the =
same
port, after temporarily unbinding from vfio-pci).

Expected: all 90 requested bytes match the module's actual EEPROM content.

Actual: the last 2 bytes (length % 8) come back as 0x00, regardless of their
real value. Confirmed concretely: byte 92 (SFF-8472 "Diagnostic Monitoring
Type," containing the DDM-implemented bit) returned 0x00 via this 90-byte r=
ead,
but 0x68 (DDM bit correctly set) via an independent ethtool -m read of the =
same
module. Re-running the same rte_eth_dev_get_module_eeprom() call with lengt=
h=3D96
(a clean multiple of 8 that fully covers byte 92 within a complete block)
correctly returns 0x68, directly confirming the root cause.

Suggested fix: replace the all-or-nothing guard with a clamped partial copy,
matching the Linux kernel's fix:

    uint32_t copy_len =3D RTE_MIN((uint32_t)SFF_READ_BLOCK_SIZE, info->leng=
th -
i);
    memcpy(data + i, value, copy_len);

--=20
You are receiving this mail because:
You are the assignee for the bug.=
