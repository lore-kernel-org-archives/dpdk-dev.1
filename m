Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1ED606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33FBB402D3;
	Thu, 22 Oct 2026 13:10:37 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id E43784003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 13:10:34 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667428t64c5ca09
X-QQ-Originating-IP: au1aFaOKGY2mgcDG+TgCvNxbh6e0mamtMvdnd769Qwg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1877923981596231022
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v9 00/16] Wangxun fixes and new features
Date: Thu, 22 Oct 2026 19:03:06 +0800
Message-ID: <7FB1146D440010CF+20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NkL5+hAx9LE0vqnyvKueydhYMZAHg/4e1YP+/7UvjuornfrkPZT2VCAa
 8JjlyRwzXfPRjeYSYV8iUoe/97EyUCmH0rnn6ANjGQOwykaAX04Zb71rqh7AJ7JYLgndgPE
 +yMG58PKU1+WgYHGbJVy6GcD1zol80Zbb+P6Mp3Yhr7kLoC8JgZwoszc1fHgrHZOVO4Wk8U
 v6U3EWMsYCl6N5CwTwODCCXekViZmzTJJAJaEJ0kiZIuyPKxLZtPyPJEu8uvWw+Vj8RSF/0
 m2GqvDJcbc1AOoeaXR+Uuf+94JFYZjWZx6CQ669Ihx5WtyOrPPsbYSgqCW3m0VNVHGWbKB7
 B4UwjgDBvOpa7kB65M3GEtqME8beKKtee0M5NfDxvEAJo5Ltc7gRrGLpTqIO8xbOyQ2Dx9F
 fO7e+Ws1hAwS+sIuDnR4k6OiCErASG3w4k+b/EPwaA4X+sDX4Am9C5ff07Ra7F7P0va3VRT
 14vKp2WdUxjSn6UiNy4TyoRkvkkFeDU+WWqgpn7XDNqrzMyX87nuYGvYCpt+2KBRw5e8UEm
 o5FK6Klt/9ILiYiTxMXt6S6t0NOD27gy0X2TwM5s0LebsLuHAu5hd9V7CdzB59hpCbRNtKe
 LdFK28JpKmhj89dpmEygvSP5zt7/GeFOpjMrlg1kDw4WixcGqTdTUQpESzTGDV+T9zbLBT2
 jPFJLXMxTwAIUcyA6hBHjbaMK2Kmn+kGeBygkTkDZ9OQVkunIy+nXfbPb9LOOUlOk5ZBHai
 +a3vxCuP7+4sg+XsqoH7uc9F1I54U9Ia1szoNudYKZN09K9e7HlZLzOGOnUkCXkAFpWfUxD
 pS2Zgi9cT877juBmS2s39e65H/p7JaaDc44pCZ/E4q6rIUNToTVBy2dWL8Zz5P9KYeZ7Ns4
 gh2MTV1+h1JgGEYc4SebQTarnBUz1aYiGPkntDVvZ9RcI3gxkisaf4vwtxyeLds8Cz8WZg2
 tKc/CxZXZu3KGDMjMuI8IUvxiKFd0irAr6+4mM77JMvLc7shB34M34vFhM/399jkoiCyJpl
 r9lUXeG/KYMEuIGCS1r3jdSbaSdoOX4k3lJ4QaHMq4c42kODgQ
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

Not handled in this revision:
 - P12: Range validation currently covers only bp_capa and the AML40 FFE
        values. Consistent validation for all txgbe devargs will be added in
        a follow-up after the ongoing community work on the common devarg
        parsing and validation functions is finalized.
 - P13: keep the laser_off devarg. On AML40, forcing physical loss of signal
        is a stronger operation than an administrative link-down. Bringing the
        link back up then requires complete PHY configuration and restarts AN73
        negotiation (if auto neg on). This has a visible link recovery cost on
        high-speed ports. 
	The default laser_off=0 preserves the existing behavior and link
        stability for users that only need local link-down. Deployments which
        need the peer to observe loss of signal, for example for peer-side
        link-state tracking, can explicitly enable laser_off=1.
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
v7:
 - P14: fix a TRAINING log-string typo.
        move the variable declarations in txgbe_e56_get_txffe().
        clarify the comment of page-exchange timeout budget.
---


Zaiyu Wang (16):
  net/txgbe: fix failure to configure 10G on dual-speed DAC
  net/txgbe: use the requested speed in E56 AN setup
  net/txgbe: fix e56 PHY configuration error
  net/txgbe: fix incorrect link state in 10G forced mode
  net/txgbe: do not force reconfig on link retry
  net/txgbe: set i2c sda hold time
  net/txgbe: fix link speed display info for 10G mode
  net/txgbe: remove stale outer UDP checksum offload flag
  net/txgbe: fix SFP hot-plug when auto-negotiation is on
  net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation
  net/txgbe: fix 40G FFE tuning applied to first lane only
  net/txgbe: add pre2 FFE tap and backplane capability devargs
  net/txgbe: add devarg to turn off Tx laser for 40G NIC
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification
  net/txgbe: respect manual link-down on Amber-Lite

 doc/guides/nics/txgbe.rst              |  32 +++-
 doc/guides/rel_notes/release_26_11.rst |  12 ++
 drivers/net/txgbe/base/txgbe_aml.c     |   9 +-
 drivers/net/txgbe/base/txgbe_aml40.c   |  78 +++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  16 +-
 drivers/net/txgbe/base/txgbe_e56.h     |   4 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 196 +++++++++++++---------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c      |  33 ++++
 drivers/net/txgbe/base/txgbe_osdep.h   |  12 +-
 drivers/net/txgbe/base/txgbe_phy.c     |  38 ++++-
 drivers/net/txgbe/base/txgbe_phy.h     |   7 +
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  17 +-
 drivers/net/txgbe/txgbe_ethdev.c       | 220 +++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h       |   2 +
 drivers/net/txgbe/txgbe_rxtx.c         |   1 -
 17 files changed, 549 insertions(+), 135 deletions(-)

-- 
2.55.0.windows.2

