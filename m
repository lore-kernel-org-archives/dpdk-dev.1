Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102D606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 15:43:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 711B5406B6;
	Mon,  9 Nov 2026 16:43:12 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id B2ABD4028F
 for <dev@dpdk.org>; Mon,  9 Nov 2026 16:43:10 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9CB254D392; Mon,  9 Nov 2026 16:43:10 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2100] net/ice: ice_get_module_eeprom() silently
 returns zeroed data when all I2C read retries fail
Date: Mon, 09 Nov 2026 15:43:09 +0000
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
Message-ID: <bug-2100-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2100

            Bug ID: 2100
           Summary: net/ice: ice_get_module_eeprom() silently returns
                    zeroed data when all I2C read retries fail
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
drivers/net/intel/ice/ice_ethdev.c#L6742-L6767

for (j =3D 0; j < I2C_BUSY_TRY_TIMES; j++) {
        status =3D ice_aq_sff_eeprom(hw, 0, addr, offset,
                                   page, !is_sfp, value,
                                   SFF_READ_BLOCK_SIZE,
                                   0, NULL);
        PMD_DRV_LOG(DEBUG, "SFF %02X %02X %02X %X =3D "
                "%02X%02X%02X%02X."
                "%02X%02X%02X%02X (%X)",
                addr, offset, page, is_sfp,
                value[0], value[1],
                value[2], value[3],
                value[4], value[5],
                value[6], value[7],
                status);
        if (status) {
                usleep_range(I2C_USLEEP_MIN_TIME,
                             I2C_USLEEP_MAX_TIME);
                memset(value, 0, SFF_READ_BLOCK_SIZE);
                continue;
        }
        break;
}

/* Make sure we have enough room for the new block */
if ((i + SFF_READ_BLOCK_SIZE) <=3D info->length)
        memcpy(data + i, value, SFF_READ_BLOCK_SIZE);

Two separate problems in this retry loop's failure handling:

1. Zeroed data accepted as a successful read. status is never checked
after the loop exits. If all I2C_BUSY_TRY_TIMES (4) attempts fail, value
has been memset to zero by the last failed attempt, and that zeroed
block is still unconditionally copied into the output buffer as if
valid. The function falls through to return 0 (success) regardless.
A persistent I2C/admin-queue failure for any single 8-byte block -- the
comment directly above this code acknowledges I2C bus contention with
NIC link management is "normal" -- is therefore silently reported as a
successful read, with that block's bytes coming back all-zero,
indistinguishable from genuine zero-valued EEPROM content.

2. Debug log prints unread data as if it were the read result.
PMD_DRV_LOG fires unconditionally right after the ice_aq_sff_eeprom()
call, before the if (status) check and before the failure-path
memset(value, 0, ...). So on a failed attempt, the log line prints
value alongside the (correctly) failed status -- but value at that
point holds stale data: leftover from the previous block's last
successful read on a block's first failed attempt, or zeros from the
prior attempt's own memset on any subsequent retry of that same block.
Either way, it's never the result of the failed call being logged,
which can mislead debugging by making a failed read look like a
plausible real value.

Suggested fix:

bool block_ok =3D false;
for (j =3D 0; j < I2C_BUSY_TRY_TIMES; j++) {
    status =3D ice_aq_sff_eeprom(...);
    if (status) {
        PMD_DRV_LOG(DEBUG, "SFF %02X %02X %02X %X read failed (%X)",
                    addr, offset, page, is_sfp, status);
        usleep_range(...);
        memset(value, 0, SFF_READ_BLOCK_SIZE);
        continue;
    }=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
    PMD_DRV_LOG(DEBUG, "SFF %02X %02X %02X %X =3D "
        "%02X%02X%02X%02X.%02X%02X%02X%02X",
        addr, offset, page, is_sfp,
        value[0], value[1], value[2], value[3],
        value[4], value[5], value[6], value[7]);
    block_ok =3D true;
    break;
}=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
if (!block_ok)
    return -EIO;

--=20
You are receiving this mail because:
You are the assignee for the bug.=
