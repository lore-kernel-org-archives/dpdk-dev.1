Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C103EDF042
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 06:00:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26B8140695;
	Thu, 12 Feb 2026 06:59:47 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 64A4040B94
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:59:45 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61C5xhMC33356777,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770875983;
 bh=5Xvv0OZFHzNCEIKSZwFdTx129UW20HvHQwfHRakoZYg=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=LrLJfI6lg59f4BiKXvGsjeoeCRHKilYA+sMvve9/WAkWdXbNAViyoPY6TNx8Kxd/t
 uc6y7ZppzFnptPrW1vgYrbAV2QM6gZaQ6awryGmuzXnZ0uP+ZpANFb1HFxREyge3gQ
 wKKyCSb5eA8BpwagqhB/HealCm4N/LnIkvinfNMh48U5QI+GEYk7zPhxaOIS7hhidt
 hcmiVq72X+nNS9JDbG2Wbfro0ehbOI6Er4g8pFrVpqHA8ez5lLpXoIquUIjeKd8tkA
 Wg35CfNgSviGV6v3f4G11VXXutUEuGR86oudiYG+MGH5ZXZ1Hx04jkEbaX1RyZaK4B
 uwcvgjGFVl4sw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61C5xhMC33356777
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:59:43 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 12 Feb 2026 13:59:43 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Feb 2026 13:59:43 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v3 12/12] net/r8169: ensure the old mapping is used
Date: Thu, 12 Feb 2026 13:59:02 +0800
Message-ID: <20260212055902.139958-13-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212055902.139958-1-howard_wang@realsil.com.cn>
References: <20260212055902.139958-1-howard_wang@realsil.com.cn>
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

Fix the incorrect link status reported when binding the PMD after
the NIC has been initialized by the vendor driver.

Fixes: 619f6ebce115 ("net/r8169: support hardware configuration")

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_hw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index acc16f3e48..27d52c81c9 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -1083,6 +1083,9 @@ rtl8125_hw_config(struct rtl_hw *hw)
 
 	rtl_mac_ocp_write(hw, 0xE098, 0xC302);
 
+	/* Ensure the old mapping is used. */
+	RTL_W8(hw, INT_CFG0_8125, RTL_R8(hw, INT_CFG0_8125) & ~BIT_0);
+
 	rtl_disable_cfg9346_write(hw);
 
 	rte_delay_us(10);
-- 
2.34.1

