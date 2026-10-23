Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15E606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E11E240299;
	Fri, 23 Oct 2026 13:07:44 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 4830340268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 13:07:41 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753656t403a35a6
X-QQ-Originating-IP: BrnKFBPqIONB9egajxCypfSB/PTIYUgGLXpeqEmoIJo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:07:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 525925438712369434
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v10 00/17] Wangxun fixes and new features
Date: Fri, 23 Oct 2026 19:03:38 +0800
Message-ID: <3C29C180B4E33816+20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nx5J06Esz7r70u54/mROhDlKfA0CoHGJxsJCe5HehjgVhMTusTOem5P2
 kru/HMp8TsN+EbX2tZpPagABsnx9zcbFfCELByZvHKmRlPON1TSbou942YKr3+Q6GA2a9hV
 Ng+J3ztjF4uUfEOVaHQarimdS10Wb0WcVoNRfdEsgHPTR6tKOIRmph1AekWZQ6h0hIG6Yy4
 +Bjp70sHFOr9u4R9HMEVXoWSOYwWzB7YiQGECxRzZypAHw3xrm8M7GhmXEJ+iUjuvkGiFuY
 jp72XEXiiYMfHVy01h6KXggbTS/RiIJK/HurFRAJbUR1vn6I/Tsw/m2qUEIXn9WrLHDE2el
 +QfmZ0Md4cGGI/8sAem+4BzFbT4CRoFk2PGJ5culI3cOFd53uGRw6MoPSXTTzBhfLLIct0L
 Rg+NTkx57JuwFriEmzIygByFfglngCPzyICH5/RTRM5t0Ptffo2lwBosNzdWPihbKn70FmI
 qAfP17jRdyzsn8F0ubBFCF8Gqcv1TAXJjPBpnPLbnVXSFo23Ruo7DeVEEEQ0TVve+K6Ec12
 rpjK55ylCcvQ8TCuUwBXc2TUu28pUlrHoSQHpQLd/+y8Aq4zg0W7lt6kdSULYhs8ND9656R
 z0SwXZHkUfqw6vqmXR9mtMAltVX0c7BUXd7Svh/MYm9eUdZXGexNKErZQ2+BeolFaUSSByX
 dZ4U2riFubQYVjj6nmMhSIo3UZuHBMs7KeNgEM6U8OIWi60fO3dI/X71j6DvlrBwOCGGc82
 YYxSNCpsrxBozH6QsEalRDjlq8eAqIOdTrew5cUNiaL8jl5JrqLOYnMio4EChw/cdRQRdnI
 MqyaJ5aGpRLUkKyUD5MbId+gCB/Y4Wszy7IlfO5U7+fJEZCz+eqmYZ2MI+bs1mKhz/tN/Ob
 AY/xFMJ4zr2Zjg2Rsj6/9FEXyA5uNy101mFxjcqVEBoqU7jL3tzqbq3f5uLvsz0XGfRwdVS
 37lMcONIAHGXYA1GsGXQYuQ2mf6QoAc67u7akZEISxprAGdVa3NRqGiHFN5FJBol2sQuSdv
 blNXTpp0bE4cTzWo3AvB0PghVFZtZcnExzmRi6Q7jzju/OuW0xGnv/Ck/fe+0Q0AIgqhCTb
 9cFqOMrAvGn
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).

---
v10:
 - P12: check the FFE taps against the register field width of the MAC in
        use, instead of only for the 40G one. On the Sapphire the main and
        pre taps are six-bit fields and the post tap is seven-bit, so a
        larger value spills into the neighbouring field rather than being
        truncated.
 - P12/P13: say "Amber-Lite 40G NIC" for bp_capa and laser_off, the only
        MAC that implements either.
 - P17: add a new patch to rename fiber_suppport_speed to fiber_support_speed.
        The field was added with the misspelling in 234ce0d1fa, copied from the
        out-of-tree base driver.
---
v9:
 - P02: build autoneg_advertised from one mask instead of three ifs, and
        drop the out-of-tree reference from the message.
 - P03: fix the same wrong RXS field in txgbe_e56_cfg_10g(), and add the
        Fixes tag for the 25G commit that introduced that copy.
 - P10: report module removal and cancel the AN73 watchdog only on the
        transition to not-present, so an empty cage no longer repeats both
        on every poll.
 - P12: reset invalid bp_capa values to 0, log AML40 ffe_* values above
	0xFF before their low bytes are replicated across the four lanes,
        and document the applicable FFE value range.
 - P13: clarify that laser_off disables the E56 PHY PMD through PMD_CFG0
        for DAC cables, while QSFP modules use the SFF-8636 Tx-disable byte.
 - P15: rewrite the unknown-module comment, drop the debug print that ran
        on every watchdog tick, and drop a commit-message bullet for a branch
        that is not in the parent tree.
 - P16: clear TXGBE_FLAG_NEED_LINK_CONFIG before the administrative-down
        early return, so a 25G SFP port can recover after set_link_down() and
        set_link_up().
---
v8:
 - P05: keep a retry from reconfiguring an established AN73 link, while
        still restarting PHY configuration when the link is down or AN is
        incomplete.
 - P10: on AML40, mark unsupported and unclassifiable QSFP modules as
        unknown so the module poll does not repeatedly identify them or
        rerun module and link setup.
 - P12: place the txgbe release-note entries between the Solarflare and
        ZTE driver entries.
 - P13: rerun complete AML40 link setup on set_link_up() with laser_off
        enabled, restoring the DAC configuration without adding a separate
        state flag.
 - P14: correct the AN FSM condition described in the commit message
        and remove the stray line after the Signed-off-by trailer.
 - P15: assign the detected 10G speed for passive and active-limiting
        DACs, and remove the unreachable AML40 10G SFP capability branch.
 - P16: add a new patch to keep Amber-Lite ports administratively down
        by preventing the AN73 watchdog and setup-link retry paths from
        configuring PHY while hw->dev_start is cleared.
---

Zaiyu Wang (17):
  net/txgbe: fix failure to configure 10G on dual-speed DAC
  net/txgbe: use the requested speed in E56 AN setup
  net/txgbe: fix E56 PHY configuration error
  net/txgbe: fix incorrect link state in 10G forced mode
  net/txgbe: do not force reconfig on link retry
  net/txgbe: set i2c sda hold time
  net/txgbe: fix link speed display info for 10G mode
  net/txgbe: remove stale outer UDP checksum offload flag
  net/txgbe: fix SFP hot-plug when auto-negotiation is on
  net/txgbe: fix DAC hot-plug on AML40 with auto-negotiation
  net/txgbe: fix 40G FFE tuning applied to first lane only
  net/txgbe: add pre2 FFE tap and backplane capability devargs
  net/txgbe: add devarg to turn off Tx laser for AML40
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification
  net/txgbe: respect manual link-down on Amber-Lite
  net/txgbe: fix typo in the fiber_support_speed field

 doc/guides/nics/txgbe.rst              |  32 +++-
 doc/guides/rel_notes/release_26_11.rst |  12 ++
 drivers/net/txgbe/base/txgbe_aml.c     |  13 +-
 drivers/net/txgbe/base/txgbe_aml40.c   |  78 +++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  16 +-
 drivers/net/txgbe/base/txgbe_e56.h     |   4 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 196 +++++++++++++--------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c      |  33 ++++
 drivers/net/txgbe/base/txgbe_osdep.h   |  12 +-
 drivers/net/txgbe/base/txgbe_phy.c     |  42 ++++-
 drivers/net/txgbe/base/txgbe_phy.h     |   7 +
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  19 +-
 drivers/net/txgbe/txgbe_ethdev.c       | 232 +++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h       |   2 +
 drivers/net/txgbe/txgbe_rxtx.c         |   1 -
 17 files changed, 566 insertions(+), 140 deletions(-)

-- 
2.55.0.windows.2

