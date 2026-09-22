Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EEBC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1635A402B6;
	Tue, 22 Sep 2026 14:54:30 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id D6FE3402B0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 14:54:26 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081661t7fa9a517
X-QQ-Originating-IP: t526+vKJ7aCrqAW5Gf1hzh64+iwvCv9BWC66RncERbA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15564897615643183218
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v4 00/16] Wangxun fixes and new features
Date: Tue, 22 Sep 2026 20:37:33 +0800
Message-ID: <D88DBAEE6DF34BF1+20260922125414.3638-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MfQnJH+7WKv6VK+f+mBPiJs+BV7bMISfX/QDzBuJ2eABqj8MHWaoSaRk
 FJOEIt3e4ApIKblU9m3T8J3wjW5ZvNMfp8TiMaBZMC7MVdE8zpm+N8KNAizEI2n6ht7uscl
 ZkmLrcKl2IL1kD3hobgTOVmDKNpPEbHxFyZpGn7XIxf2Gjrubuq0tMRCEpNlrs16j037AzY
 15YHD+YcS8H9/Lqc52RcLErn3UFjmk4FZZnmaCZcfN823LXnU4hvmqoc4gsDJ1P64l52O8Z
 r6KzwnAA7WMMGDWrUx7sECA30A9sUrYnhCpJ5fxRDxzKSs3ePG26dkgXI/zb6kz8DxFRFqb
 GZ1edVMDcN2ORdYGwEI6SBcdKQfSa0nZJsw49sURR3cZY2acT+0a/ttnUcj7Se+MFAdIcI8
 rmb5bvH3oIi+g5Ex7qWR37oP4/omMNCitZDLauW6s/fnTzHCu6mWEwo09cYtF2mZ/MW4FAs
 hIiQgJX2myTDeYiVTMGCYI6LAcWjSFiDU7Nq4i43PBLMKnozrIUzOL7F4gt+WB47H5z7Zkq
 GhoBp5JE39V0OAhhLr20xGh2Xb9UkV0c4jbre0Yj6gUpkTKcGrdXvClNCuX023npASTDIBW
 e385hLB/xeqNfYdKKkL1Mo0DLy413aO/tCt88/u3e2v6dIS3ARVnCshr/IsWEMV1MNfTAUj
 gakGnUHNf0uDW5r9r8M+09I5OdAjZ5iafhZXfdE4tymKl1yL4uN4Ch4ckW2sEqFUFcBuZ5Y
 /ecuZ5SLlkWUZ2KfMWRynbPwIaYZch3Ri3TC18pK3z6RQxtNHT7itptGE016gT/4eUYPMyR
 Oc6qH9DQcITXQxf8bVJwl8i7+TrlLdTilgrob8AWMxD5iEvuCUiQMIhKgcUCg8tOTmnA6du
 pJwbAc4ciVRRhweS9Am5xnkmV6wM/8GKshZ4uAZbOifdg7wjh/Qxwv1FUD04doNDr3NIVHe
 eDRJaLufvw+S2hI5sX/r90H4c7JMaftKj0ATfR6HTU7Rpk3ZxN49pWCVsiiVW10TMkFOHbF
 9jdRBvbwnzIhQRrP4B
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs
(CR/KR training, hot-plug, 10G link state), and additionally refines UDP
offload handling.

---
v4:
 - add a new commit to use the requested speed in PHY setup
 - P01: drop the hardcoded-speed hunk and the matching commit-message bullet.
 - P10: gate the SFP module-removal sampling.
 - P11: cancel the previous SFP-detect alarm before re-arming it.
 - P14: gate txgbe_enable_tx_laser_multispeed_fiber() on the DAC/QSFP branch.
        complete the "no module" case with txgbe_sfp_type_not_present.
 - P15: enforce count2 as an iteration budget in txgbe_e56_exchange_page().
        propagate the return status instead of silently throwing it.
 - P16: re-assign hw->devarg.auto_neg.
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
  net/txgbe: add offload support for tunnel type UDP
  net/txgbe: fix SFP hot-plug when auto-negotiation is on
  net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation
  net/txgbe: fix 40G FFE tuning applied to first lane only
  net/txgbe: fix unset pre2 FFE tap and backplane capability
  net/txgbe: add devarg to turn off Tx laser for 40G NIC
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification

 doc/guides/nics/txgbe.rst              |  18 +++
 doc/guides/rel_notes/release_26_11.rst |  11 ++
 drivers/net/txgbe/base/txgbe_aml.c     |   3 +-
 drivers/net/txgbe/base/txgbe_aml40.c   |  93 ++++++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  14 +-
 drivers/net/txgbe/base/txgbe_e56.h     |   6 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 193 +++++++++++++++----------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c      |  33 +++++
 drivers/net/txgbe/base/txgbe_phy.c     |  13 ++
 drivers/net/txgbe/base/txgbe_phy.h     |   7 +
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  17 ++-
 drivers/net/txgbe/txgbe_ethdev.c       | 147 +++++++++++++++++--
 drivers/net/txgbe/txgbe_rxtx.c         |  29 +++-
 15 files changed, 473 insertions(+), 118 deletions(-)

-- 
2.55.0.windows.2

