Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBDBCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4C4840150;
	Tue, 30 Sep 2025 12:00:07 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 56CE940685
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:06 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226401tdaac1957
X-QQ-Originating-IP: b7KnqHCPiTguJK2AcB3oPMTyCJec+LHGtSzL4cjgd2Q=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 17:59:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15674576346580966815
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v4 00/20] Wangxun new NIC support
Date: Tue, 30 Sep 2025 17:59:32 +0800
Message-Id: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MNbA5mkmBXEJXzF9wFmc2dEh1a/v7+iEVLGG0oxztusDUM7qvd6mj/Lj
 yRACVEt9otlO8wLh6LskwGaeHT5uiDpyfEAlBi4buMmaOqlPskyTOf93NB9UlX5EbHEoVRO
 VWFqXRK0OJpRcPHVKnI2MehRZ8rYh7TF/W5TpRPGf3+VVicNFJh446P1ZWneAC0Z0e21IhB
 rEtjywStClSX7WJNP/TA/SyJ4mBTLPjkR7E/yZ0YsSstY67DWSWX5Ubfon0QxWBXJPnqv+t
 ZMnKKCunyHq4pHfP9S4lLsxoqz6ha/NLcu5XjcxZAV+k8RsRXLeSP1FocpYJqmyd/xhvGBb
 skdWJIsSXu3HVbrAHO+46NzAg5uJRwnk8G1ILdyAY4tYOgf0IGmczfXrqyDVTHUXQWoLI3R
 orLUqRbQ4jFeSF+PBibNlAapGRL/ReVkEEnwLAQOsr+Vif/0qSB7sdyaGzO7frcEiOWbamJ
 u5pPPBNyPtaOty66n4QayWqWNJq5BxsMfYGXSbc4XRxMD4BEh5UFMKxM9ma9jzcg6LAF6ar
 15fPPgZZ5xg4m6pFOAOoa2iaRvBKAG4qeiQ11FgkW1P+8o/ns6vRSvRHQU2HZ6TLAeild89
 c+qu1TErZHwGdW9Wdxm6OQ37kOOiZZzOwyDShJz63ql1AV9QK7NfY33OxdOp+YHFZ/zhVz0
 rLhGDGqMxOH+OBxP7a/UoNyDegbcOVeElqqaBsnkGqVwgqlkDviMeEJj/j3wWBLFLWg6YgI
 FP+b5L2sJOzcYl1+eQh7XLc/qDGiGacViYoiACWQiFcxSdLJFOIs975m+NNtd8rtk8in5eR
 54pjRMzkMJ1o2U4PV1ZRtYG2zydfyyHbsdGdheUE76MWID8Iwx3/Zsc8xRvcMUaH1RlNksr
 5rnm/iBhi3W51ewh1NbLndCPyaNeMHfKsUfeGbFtIF5RJJPwiForSuBe2pPArMR7sE0Rtak
 sbxfRABUtW7mn/C2SqJL2lTnmE3//rOoQAyUSfhsuVaG5LGkwPq42pbBNhMGg96dxYMaCIB
 cS4TChq6zQ4CL34mBj
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

We have released a new NIC series: Amber-Lite, with two models
supporting 10G/25G and 40G rates. Due to minimal hardware 
differences from existing 10G NICs, it remains supported within
the txgbe driver.

Zaiyu Wang (20):
  net/txgbe: add basic information for Amber-Lite 25G/40G NICs
  net/txgbe: add new SW-FW mailbox interface
  net/txgbe: add identification support for new SFP/QSFP modules
  net/txgbe: rename raptor to sp for Sapphire-specific code
  net/txgbe: add basic link configuration for Amber-Lite NICs
  net/txgbe: add support for PHY configuration via SW-FW mailbox
  net/txgbe: add RX&TX support for Amber-Lite NICs
  net/txgbe: add hardware reset change for Amber-Lite NICs
  net/txgbe: add MAC reconfiguration to avoid packet loss
  net/txgbe: add TX head Write-Back mode for Amber-Lite NICs
  net/txgbe: add RX desc merge mode for Amber-Lite NICs
  net/txgbe: add FEC support for Amber-Lite 25G NICs
  net/txgbe: add GPIO configuration
  net/txgbe: disable unstable features
  net/txgbe: add support for TX laser enable/disable
  net/txgbe: add support for TX queue rate limiting
  net/txgbe: add support for getting PHY ID
  net/txgbe: add thermal sensor configuration for Amber-Lite NICs
  net/txgbe: add RSS for Amber-Lite NICs
  doc: update for txgbe

 doc/guides/nics/txgbe.rst                 |   8 +-
 drivers/net/txgbe/base/meson.build        |   2 +
 drivers/net/txgbe/base/txgbe_aml.c        | 354 ++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_aml.h        |  22 ++
 drivers/net/txgbe/base/txgbe_aml40.c      | 160 +++++++++
 drivers/net/txgbe/base/txgbe_aml40.h      |  20 ++
 drivers/net/txgbe/base/txgbe_devids.h     |   9 +
 drivers/net/txgbe/base/txgbe_eeprom.c     |   7 +-
 drivers/net/txgbe/base/txgbe_eeprom.h     |   2 +
 drivers/net/txgbe/base/txgbe_hw.c         | 365 ++++++++++++++++----
 drivers/net/txgbe/base/txgbe_hw.h         |  15 +-
 drivers/net/txgbe/base/txgbe_mng.c        | 184 +++++++++-
 drivers/net/txgbe/base/txgbe_mng.h        |  34 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |   2 +
 drivers/net/txgbe/base/txgbe_phy.c        | 127 ++++++-
 drivers/net/txgbe/base/txgbe_phy.h        |  24 ++
 drivers/net/txgbe/base/txgbe_regs.h       | 103 +++++-
 drivers/net/txgbe/base/txgbe_type.h       |  70 +++-
 drivers/net/txgbe/base/txgbe_vf.c         |   2 +-
 drivers/net/txgbe/txgbe_ethdev.c          | 390 ++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h          |   2 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c       |   2 +-
 drivers/net/txgbe/txgbe_flow.c            |   2 +-
 drivers/net/txgbe/txgbe_rxtx.c            | 203 ++++++++---
 drivers/net/txgbe/txgbe_rxtx.h            |   3 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |  27 +-
 26 files changed, 1937 insertions(+), 202 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h

-- 
2.21.0.windows.1

