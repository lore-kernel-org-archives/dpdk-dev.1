Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F92606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5AC24064F;
	Mon, 26 Oct 2026 13:26:57 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTPS id 92E74402A3
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:26:53 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017604t606903a7
X-QQ-Originating-IP: DCAK4+Ibi4dyMvTz8WyCOqtzyfJHrZ6JE56yGFCLp30=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:26:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9103120766231060196
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v11 00/17] Wangxun fixes and new features
Date: Mon, 26 Oct 2026 20:21:46 +0800
Message-ID: <D4A752590839CFE3+20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NuJTdbh4wSLqybix0UDwiZojaNZFm+fF+AKmlk9RehD0+MJBdynrSvXY
 fr443SSA5XFvYwH7leryZgi2Mmi9p9Aj4nwLFRXxKa65uFAS4VmVQZSgzFhApmITIWtIURT
 pVKZ0xUGTsVxzK996ydSHi8h+3uZpsuOv7qeJ8h2EzGGpOAd4H+oJfpx6CxPFG8jVRyaAR1
 iSbgGP60feEaxei4E3J0+LO+BbggWEQtQ8ZBBKtUzVcp59VgVs016Ok4cy2dJEa1AfYJO3H
 pbazSEU5dllngg8oc81JasbF3CSyLSTGf0R0mY76Y+Qbe7HudWsPMR7UkRBNAmCqJBAqG4n
 azRP4jCx7owIH9nOYfhjP8R8pwHSQPL5jNmWHoeDilXfIPSQ/HAPYgE73IoZNrlfEDXoaBa
 e6z3f/aPBF/eX8M8ebtzxKABwIUUMqEKTYsyEcuWRPZsiR8aAflrdoNJDs9xWv0CO1mK8es
 ZTPCOpoIjn54+DvqC3DeVd62HT5s+8dkyYIa/n6hm+0lS4b0kNVnmJxrpKYws/CMNKOnkeQ
 47PgffdD8lLsvcuPWXwXSxE1Kz5AodFtgCeg/L2Lrysnf+CsJhl2e4vwKyFgt1cboCnxOZr
 Za82TjaNthcJZiV9MwAopbJJOKU/FDaLfOhrJ6rlgHyS3/PYQeDNUjxem7Dxp86z9KeVX99
 6ZUspsVZVYhqDIEqva6ZVuIA686jRIGSvdsAdYGzTUPh5Z221Rf7jNTaKFKjGO41aOXtVOc
 HNALZH+tii7N1R6mUuZvcNkuTKyyuioARqdbGTdwScDG2VpFRfKgNFc3+sDb0mjJYJsOIIc
 vv/Ga7OXw3mAj4zZ/ttLXn5F2KgDoMkdMo1plj+1BByplzP/TfYlaHKQTOlDJdZDwfx63rF
 Q2lS4sL0IfKkaAyuiZB19HdHu6Uth7Z7/ctXnx1mbPfABbdCI/HtFyfH/4GPl4VFXhWToIH
 bWLL17+RtEmakhNCsmIUyDrLDr3yKt1oAmlFZEQKlOjmRf3lIjATwKTusg54CB2bf36aju1
 OfhPHIncwkakQAubl+1c+4Z9Wf9wU1aP9lDvKsTRfPmBpyVGEzcHY+LQVZo4zZMIrEQ4de4
 roz7Mlm4CRp/6TojT+UYZBFMBpmhopa2jEqF023Q/gU
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
v11:
 - P12: fall back to the default value when an FFE tap does not fit the
        register field, instead of only logging it.
 - P13: change the patch from a new feature to a fix:
        take the transmitter down on AML40 link down. Clearing GPIO bit 1,
        which holds the module in reset, does not stop the transmitter for
        every DAC cable and QSFP module. The laser_off devarg and its
        documentation are dropped; link setup runs again on link-up to
        restore what link-down disabled.
 - P17: fix warnings in check-git-log, and add the Cc: stable tag that
        belongs with the Fixes line.
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
  net/txgbe: fix Tx laser left on at AML40 link down
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification
  net/txgbe: respect manual link-down on Amber-Lite
  net/txgbe: fix typo in the fiber support speed field

 doc/guides/nics/txgbe.rst              |  25 ++-
 doc/guides/rel_notes/release_26_11.rst |   8 +
 drivers/net/txgbe/base/txgbe_aml.c     |  13 +-
 drivers/net/txgbe/base/txgbe_aml40.c   |  78 ++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  16 +-
 drivers/net/txgbe/base/txgbe_e56.h     |   4 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 196 +++++++++++--------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c      |  31 +++
 drivers/net/txgbe/base/txgbe_osdep.h   |  12 +-
 drivers/net/txgbe/base/txgbe_phy.c     |  42 ++++-
 drivers/net/txgbe/base/txgbe_phy.h     |   7 +
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  16 +-
 drivers/net/txgbe/txgbe_ethdev.c       | 251 +++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h       |   2 +
 drivers/net/txgbe/txgbe_rxtx.c         |   1 -
 17 files changed, 569 insertions(+), 140 deletions(-)

-- 
2.55.0.windows.2

