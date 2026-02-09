Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE3E78D44
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 08:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05D1540672;
	Mon,  9 Feb 2026 09:56:21 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id DE8E84067B
 for <dev@dpdk.org>; Mon,  9 Feb 2026 09:56:18 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6198uG0V11144691,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770627377;
 bh=GUkyWZQT1k0TJC7TXyBeb/kfOKcDM8nBRmyHJgK6tTE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=dQCf1OaEWCcYtvNAJGUHx/NdEFkcrAn/9y9sw6pQe3hF9b8aCen1Y3CoMLVpHrDuT
 18YUAS254a3axXVwGo2otE24a2s/FERiIzndacvkrFysL5F13mpjWtsMj/tOmYdfZR
 Pbty21VjVnOr9qCw9Loee7WjGLhu5scDHi9KGZTJuTcpdlmI4lbKCgtD8NQikgI3tE
 AaVUJtFnIWUbhf0stYE1sSAANsYQd2afE00yosVE41cErQXrWYcGTfLOnQLxS31kA9
 V1ifl+MpEPA3Bs+n6rKve1RZPXQS0sPnhKSowbAWPAZCikqFoR2BaE4MWh8qQbwNF+
 j2dDwL1bnvIQQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6198uG0V11144691
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Mon, 9 Feb 2026 16:56:16 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 9 Feb 2026 16:56:16 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 9 Feb 2026 16:56:16 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 11/12] net/r8169: fix one bug about RTL8168KB
Date: Mon, 9 Feb 2026 16:55:01 +0800
Message-ID: <20260209085502.26722-12-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209085502.26722-1-howard_wang@realsil.com.cn>
References: <20260209085502.26722-1-howard_wang@realsil.com.cn>
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

The RTL8168KB was incorrectly treated as a 2.5G device.
This chip actually supports a maximum speed of 1Gbps.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_ethdev.c | 1 -
 drivers/net/r8169/r8169_hw.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index 72e014e22b..b2b1882aa5 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -167,7 +167,6 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 		switch (hw->chipset_name) {
 		case RTL8125A:
 		case RTL8125B:
-		case RTL8168KB:
 		case RTL8125BP:
 		case RTL8125D:
 		case RTL8125CP:
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index aa5e160feb..acc16f3e48 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -1550,7 +1550,6 @@ rtl_init_software_variable(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 	switch (hw->chipset_name) {
 	case RTL8125A:
 	case RTL8125B:
-	case RTL8168KB:
 	case RTL8125BP:
 	case RTL8125D:
 	case RTL8125CP:
-- 
2.34.1

