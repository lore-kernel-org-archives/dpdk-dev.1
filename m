Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF35ECD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93FAC42EF2;
	Thu, 11 Jun 2026 10:35:32 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 290DF4026A
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:35:30 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B8ZRP301787004,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1781166928;
 bh=f1W64ms7YVlwOLQKZRr41ylGsNUDwnSRbFg828bBogg=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=vkaWHW9sL3zzBEZIR5SdvsWiQlh/ECnTBwsgbRKqpdwYVhwh6g1fpzNuOYkL2hNXW
 EssQunQB6DpKBFwFhqzubrMgdhBhRngOLEGClQRFF4AkfjjbeufzBDnfSyGJR7JBUk
 eHSQelS6bjWV0+dtsVormii6PV3xVTbk48LEYGjeM3otcUEM1n66zhOX1QkWZknYdO
 HsU/UbUbJLJ5LKpDHQFCyWCouP1E7sY9X97unQAJuqzx4wZqkBjbmdC/rgbbkcntnZ
 m1bGSDtkaiEGQ2DHVthuSWAk3cDjg+pfwYfZUEs3MUCgLq+OBLZ+wR3fWJJF14ce4S
 IdyogTGFpBcig==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B8ZRP301787004
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:35:28 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 16:35:27 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 16:35:27 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 0/6] net/r8169: hardware updates, optimizations,
 and a bug fix
Date: Thu, 11 Jun 2026 16:28:27 +0800
Message-ID: <20260611083521.20669-1-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.43.0
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

This patch series primarily focuses on updating hardware configurations, 
optimizing the datapath, and refining device behaviors for the net/r8169 PMD. 
Additionally, it includes one bug fix for a segmentation fault encountered 
during initialization.

Summary of the series:

  - Patch 1: Updates RX CRC drop behavior for RTL8125BP and later MAC versions
    to align with device shutdown sequences and prevent cross-driver states.
  - Patch 2: Optimizes the Tx datapath performance by removing redundant branch
    checks for malformed packets, replacing them with RTE_ASSERT.
  - Patch 3: Enhances RTL8125+ flow control by utilizing a new formula for 
    nearfull and nearempty thresholds.
  - Patch 4: Removes RTL9151 CSI (DBI) channel support, as firmware handling 
    latency makes it no longer suitable for the driver.
  - Patch 5: Updates PHY and MAC MCU configurations for RTL9151A and RTL8125BP.
  - Patch 6: Fixes a segmentation fault during RTL8168 initialization by 
    restricting RTL8125-specific RSS/VMQ configurations to the correct hardware.

Howard Wang (6):
  net/r8169: disable RX CRC drop for RTL8125BP and later
  net/r8169: optimize Tx datapath by removing redundant packet checks
  net/r8169: improve RTL8125+ flow control
  net/r8169: remove RTL9151 CSI (DBI) channel support
  net/r8169: update hardware configurations for 8125
  net/r8169: fix segmentation fault during RTL8168 initialization

 drivers/net/r8169/base/rtl8125bp_mcu.c | 15 ++--
 drivers/net/r8169/base/rtl9151a.c      |  8 +++
 drivers/net/r8169/base/rtl9151a_mcu.c  | 14 +++-
 drivers/net/r8169/r8169_compat.h       |  1 +
 drivers/net/r8169/r8169_hw.c           | 98 ++++++++++++++++++++++++--
 drivers/net/r8169/r8169_hw.h           |  2 +-
 drivers/net/r8169/r8169_rxtx.c         | 32 ++++-----
 7 files changed, 137 insertions(+), 33 deletions(-)

-- 
2.43.0

