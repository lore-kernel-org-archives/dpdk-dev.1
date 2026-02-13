Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F592EF48C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 03:20:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51A71402C5;
	Fri, 13 Feb 2026 04:20:24 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 1BBAC402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 04:20:22 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D3KK0v81172422,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770952821;
 bh=nItsQY+TYSbKvZglUVz05UsfeO5RSqRXK22JhvvEq7U=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=Uxu4solNyTk/ZcPvUJ95wXcuHeQ61EnOHj4CKtqDqhul5RUYmr2iyydvepzjhHO7t
 +aTfZPmD2v2fgGOWyzixXtx27lrZ82N51z3Syx6BcTAnvs4Eov7Kxj2jBKapxYI2/H
 PG343/OVoWirI3YJOAuNdmSOg97+aXiVJj6w9EPtxFXVHvNrquKonmqcE+PpIDmYin
 MxEpOkSJ3IsOb9jPU/AvVEtNvLdqxqCVOv0+gZQwWaEKRb26kAFHBZZ1OSEy+7kZWc
 QFyeNOhZ0PJEoUIHMkvGQNSp53s3XzTNZhkRJB1utz17rWtm/arDfrpUzrd6qKPI+8
 e/o9r26PNzoOQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D3KK0v81172422
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:20:20 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 13 Feb 2026 11:20:20 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 13 Feb 2026 11:20:20 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v4 00/13] net/r8169: driver updates and new hardware support
Date: Fri, 13 Feb 2026 11:20:05 +0800
Message-ID: <20260213032018.175753-1-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patch series introduces several updates to the net/r8169 driver.

The changes are categorized as follows:

1. Bug Fixes:
   - Fix a crash during RTL8168FP initialization due to a missing function pointer.
   - Fix incorrect bitwise logic for RTL8127 capabilities.
   - Fix incorrect speed identification for RTL8168KB (it is a 1G device).
   - Fix link status reporting issues regarding old mapping.

2. New Hardware Support:
   - Add support for RTL8125K (2.5G).
   - Add support for RTL9151 (2.5G).
   - Add support for RTL8168KD (1G).

3. Hardware Configuration Updates:
   - Update MCU and PHY configurations for RTL8125, RTL8126, and RTL8127 series
     to match the latest hardware specifications.
   - Optimize Rx descriptor fetch numbers for RTL8126 and RTL8127 to improve performance.
   - Adjust jumbo frame size limits for non-1G cards.

4. Cleanup:
   - Remove support for the unreleased test chip (CFG_METHOD_69) to simplify the code.

Howard Wang (13):
  net/r8169: fix crash in RTL8168FP init
  net/r8169: optimize Rx descriptor fetch number
  net/r8169: add support for RTL8168KD
  net/r8169: update hardware configurations for 8127
  net/r8169: adjust jumbo frame size limit for non-1G cards
  net/r8169: remove support for CFG_METHOD_69
  net/r8169: update hardware configurations for 8126
  net/r8169: update hardware configurations for 8125
  net/r8169: add support for RTL9151
  net/r8169: add support for RTL8125K
  net/r8169: fix one bug about RTL8168KB
  net/r8169: ensure the old mapping is used
  net/r8169: fix bitmask logic for RTL8127

 drivers/net/r8169/base/rtl8125a_mcu.c  |  128 +--
 drivers/net/r8169/base/rtl8125b_mcu.c  |   56 +-
 drivers/net/r8169/base/rtl8125bp_mcu.c |   17 +-
 drivers/net/r8169/base/rtl8125cp.c     |   36 +
 drivers/net/r8169/base/rtl8125cp_mcu.c |   87 +-
 drivers/net/r8169/base/rtl8125cp_mcu.h |    1 +
 drivers/net/r8169/base/rtl8125d.c      |   31 +-
 drivers/net/r8169/base/rtl8125d_mcu.c  |  605 +++++++----
 drivers/net/r8169/base/rtl8125d_mcu.h  |    1 +
 drivers/net/r8169/base/rtl8126a.c      |   32 +-
 drivers/net/r8169/base/rtl8126a_mcu.c  |  689 +-----------
 drivers/net/r8169/base/rtl8126a_mcu.h  |    2 -
 drivers/net/r8169/base/rtl8127.c       |   15 +-
 drivers/net/r8169/base/rtl8127_mcu.c   | 1332 +++++++++++++++++-------
 drivers/net/r8169/base/rtl8168fp.c     |    1 +
 drivers/net/r8169/base/rtl8168fp.h     |    1 +
 drivers/net/r8169/base/rtl8168fp_mcu.c |    6 +
 drivers/net/r8169/base/rtl9151a.c      |   87 ++
 drivers/net/r8169/base/rtl9151a.h      |   10 +
 drivers/net/r8169/base/rtl9151a_mcu.c  |   53 +
 drivers/net/r8169/meson.build          |    2 +
 drivers/net/r8169/r8169_compat.h       |   10 +-
 drivers/net/r8169/r8169_ethdev.c       |   36 +-
 drivers/net/r8169/r8169_ethdev.h       |    3 +
 drivers/net/r8169/r8169_fiber.c        |   15 +-
 drivers/net/r8169/r8169_hw.c           |  239 +++--
 drivers/net/r8169/r8169_hw.h           |   11 +-
 drivers/net/r8169/r8169_phy.c          |   54 +-
 drivers/net/r8169/r8169_rxtx.c         |    1 -
 29 files changed, 2058 insertions(+), 1503 deletions(-)
 create mode 100644 drivers/net/r8169/base/rtl9151a.c
 create mode 100644 drivers/net/r8169/base/rtl9151a.h
 create mode 100644 drivers/net/r8169/base/rtl9151a_mcu.c

-- 
2.34.1

