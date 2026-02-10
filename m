Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B761EA3F0C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 05:56:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2250E40678;
	Tue, 10 Feb 2026 06:55:29 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 81D404060B
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:55:20 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61A5tIWm93127200,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770702918;
 bh=MzgxIum8QdC+6Nq+B+hcv6vu7gGO2mX8vxYAWXJobpM=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=Oo7TREf5kv3e3/Cj6X+Cv6ESyaptNeeWQ0bEJbc3Fs0LL2a3yOuspkihc0Bj9VFBS
 82g0Z0+De5dnOiCNCIC2KLPLuNbqIl7k//fpFbkElTDfzXaLgFR+blajfw15oYtBnr
 RHs1oaGdFQdD9HYN0+AnwO5/4YZvZzk4R03rCMgXloaInhupJ2KwYP1KAHR0GK0+/l
 slsfIvEAn5eOyTtVHzrcrZAV1L+J7NZ7KrN0WZ63pTWkWUWk4CiyEcNvehYsFe2xv4
 YPAeloWlNbF+zo1RPxuPY62Q6jMftDJ8p+bCQTLiGoxVdE0jvgMGPKldafBLB0oqb1
 q7X+OCVHLbu7w==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61A5tIWm93127200
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:55:18 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 10 Feb 2026 13:55:18 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 10 Feb 2026 13:55:18 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v2 11/12] net/r8169: fix one bug about RTL8168KB
Date: Tue, 10 Feb 2026 13:55:10 +0800
Message-ID: <20260210055511.62382-12-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210055511.62382-1-howard_wang@realsil.com.cn>
References: <20260210055511.62382-1-howard_wang@realsil.com.cn>
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

Fixes: 4e6ed7284f50 ("net/r8169: simplify config method check")

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

