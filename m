Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16236CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:21:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AC3240E68;
	Tue, 29 Sep 2026 13:21:35 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id E73734013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 13:21:32 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680886tf3508e3b
X-QQ-Originating-IP: MuUTLiV5Q75qZLcDpe5YCflFOlKG6+qz9tT9VmvdGVA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16074123532844746939
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v5 00/15] Wangxun fixes and new features
Date: Tue, 29 Sep 2026 19:18:00 +0800
Message-ID: <C050BF433795AFDA+20260929112119.4516-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NHu6THI/J1zczXY83YvtA1+ww3jzv5t2x8UAuVPdIuEz7YHQ7DbJsZF8
 DIPyQ4Ordtu6NotKi9CbK0R+i/LFxpfal3iXo2zdP8MmIb6+1NC9cnRCcQ2x2WOXMzfVoPt
 AthK5W989HYH70YyF0hwriIBNM2VyoK+AM6kMdJ06UcBOQyNk8Oy4XB3262APDLkVQ3N66A
 QhmKtY7NVvy3OkEDc/xjrJ8DiRdRaxbutOfnaq/cP4i2LRQ1l1n8xANUQKdFfnO7l9vX9ft
 JYyR5QL/fQeXloBnRD8lqkLBRLNvxs4NXHzCa0aszZEZ6+ucl0Ito1tTpdFO26qFD4smm/m
 Vy8QGeFf4KLoynyN168cwX0xSDZz/E2bNtqQ4x8lf4KfLSclps1Mx/J2YYNzztx/AerttgX
 H/sO7gBfv5amQCH9EA0fH7BFw/MTLgH4/DEbAMGtAANz9eRWhktlq1mOF8NFaoXkO6QUJgW
 mjTXVTRR/OpNJ0RW5ex5gsSuYJmU7aPoeWqgOzMQSLsKjKN1xvnTb8wG64OoNyV7bguFcay
 uLeZXvc5sivhKN13q/og5c3Y/6Z5hFLKIa6ALXVylkIhD+BfqzdE4MkFdoqMoRK+bYsbaLv
 +gQ27gFM6s5znBOprkg7WW7dVBHDLTN15Ahuqx5yX2Y7A++ki9YPVwD06KokzUAKUj5kzrl
 zSx5vB3hi0JPuAMWJw7BgDppyezaUi/IDpYkMuINsmL1HjGiObZv/I567ne71MHuVIVxACC
 JYM5E3Gu5dbctVBg/jITnVmbMWfT+N9Sg60wxNbC3CJN5pSp+73oFAx9NNAt2NCk0Zq4DVF
 ZliiHVXUFeqIwjv6J/8FUwB9qdsOlS+Nc3nafl2tbXI/Vz0gqMOb8Gpr9H9XzSdy1xdNpPi
 TnVVqXNSf83j82mup2BpE+i4Wz3TLa7Ub738FUqyreIIZqnUbZpru0CPxm2Cx1eoxU/nIsG
 h2+IgXoVB6Tb5+DV6kb5X5eZW/T/7jjVMkJ4MUG5FIGhQUUWbEyreusSvJEJe6UwgQXkl0h
 Nigc2XWiJJ9r0gGTJ0Fc9SXKaQ/BU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
(CR/KR training, hot-plug, 10G link state).

---
v5:
 - drop the UDP tunnel patch: the generic UDP tunnel flag covers any UDP
   tunnel, so the tunnel type cannot be resolved from the destination port.
 - P02: advertise 10G, 25G, and 40G from the requested speed mask instead
        of the device ID, so the 25G and 40G parts advertise 10G by
        default as well.
 - P07: keep the patch limited to decoding the 10G link speed from PORTSTAT;
        the AML40 default 10G|40G advertisement change is now in P02.
 - P09: gate the SFP detection alarm and the AN73 watchdog on a new per-port
        flag that dev_stop clears before the first cancel.
        cancel SFP detection before the watchdog.
 - P10: re-arm the 40G module poll only while the SFP/AN73 alarm flag is set.
 - P12: treat the ffe_pre2 and bp_capa devargs as a feature rather than a fix;
        drop the Fixes tags and stable Cc, and document the 25G/40G Amber-Lite
        FFE defaults.
 - P14: bound the AN page exchange, propagate its timeout to the watchdog h
        andler, and avoid register reads used only by disabled BP debug logs.
 - P15: stop clearing the auto_neg devarg when a 10G-only DAC disables AN;
        derive the effective AN73 state from the current module capabilities
        instead. Classify 40G active cables through the optical path, unify
        DAC checks on txgbe_is_dac_cable().

Not handled in this revision:

 - P12: bp_capa is not range-checked. Devarg validation will be added in a
        separate change so all txgbe devargs can be handled consistently.
 - P14: the AN page exchange still busy-waits on the alarm thread and can
        delay handling for other ports. A later change will decouple negotiation
        from the alarm callback and run per-port negotiations in parallel.
---


Zaiyu Wang (15):
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

 doc/guides/nics/txgbe.rst              |  25 +++-
 doc/guides/rel_notes/release_26_11.rst |  11 ++
 drivers/net/txgbe/base/txgbe_aml.c     |   4 +-
 drivers/net/txgbe/base/txgbe_aml40.c   |  92 ++++++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  14 +-
 drivers/net/txgbe/base/txgbe_e56.h     |   6 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 196 +++++++++++++++----------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c      |  33 +++++
 drivers/net/txgbe/base/txgbe_osdep.h   |  12 +-
 drivers/net/txgbe/base/txgbe_phy.c     |  25 +++-
 drivers/net/txgbe/base/txgbe_phy.h     |   7 +
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  17 ++-
 drivers/net/txgbe/txgbe_ethdev.c       | 178 ++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h       |   2 +
 drivers/net/txgbe/txgbe_rxtx.c         |   1 -
 17 files changed, 502 insertions(+), 128 deletions(-)

-- 
2.55.0.windows.2

