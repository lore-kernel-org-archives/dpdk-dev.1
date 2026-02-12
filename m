Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB11EDF044
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A623D4064F;
	Thu, 12 Feb 2026 06:59:13 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id D816240647
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:59:11 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61C5x9bA53355089,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770875950;
 bh=W/yk11U4x2qqSi9f+lbpv1OqJ+OcKP3uWooCjb+Nfl0=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=OcsiiIsPZVn5p3vQDodF+zEIO7sPRyDs89+q3NmUARbwmulLxouAj3ruWP4uFjdkw
 qJITk5Ghd9HEFA5vr6SHArWv9BXi85YUkvgCX2uPs09gEcWAzmgKuJW7ceMWDnhfQb
 Bzm32+QeUZS23nQf47pVCpm49VHeZibAe7+DtOzZMhObGAHUtCBrm3Ne5XZLuyKFSz
 yD1mZ22puSkuiLljdKjww0LyftUxzlC38RIVXQuz9VaJWVWV8V6hbPH0LdEoSZr87z
 quQzJVMczNPE7RHvTnFgtdqkeKPq5kyCpirpx48BkNPNN6fa323vs6h8YxC2V6flI5
 JV5mdHI+x0lgg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61C5x9bA53355089
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:59:10 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 12 Feb 2026 13:59:09 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Feb 2026 13:59:09 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v3 01/12] net/r8169: fix crash in RTL8168FP init
Date: Thu, 12 Feb 2026 13:58:51 +0800
Message-ID: <20260212055902.139958-2-howard_wang@realsil.com.cn>
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

The rtl8168fp_ops structure was missing the hw_phy_mcu_config function
pointer, causing a NULL pointer dereference during device initialization
when the driver attempts to configure the PHY microcontroller.

Add hw_phy_mcu_config_8168fp() as a no-op function since the RTL8168FP
does not require PHY MCU configuration. This matches the pattern used
by other chip variants that don't need PHY MCU updates.

Fixes: d9ee71b5f1bc ("net/r8169: support RTL8168 series")

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/base/rtl8168fp.c     | 1 +
 drivers/net/r8169/base/rtl8168fp.h     | 1 +
 drivers/net/r8169/base/rtl8168fp_mcu.c | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/r8169/base/rtl8168fp.c b/drivers/net/r8169/base/rtl8168fp.c
index b8a058bbd9..9aa3cabeb8 100644
--- a/drivers/net/r8169/base/rtl8168fp.c
+++ b/drivers/net/r8169/base/rtl8168fp.c
@@ -192,4 +192,5 @@ const struct rtl_hw_ops rtl8168fp_ops = {
 	.hw_ephy_config    = hw_ephy_config_8168fp,
 	.hw_phy_config     = hw_phy_config_8168fp,
 	.hw_mac_mcu_config = hw_mac_mcu_config_8168fp,
+	.hw_phy_mcu_config = hw_phy_mcu_config_8168fp,
 };
diff --git a/drivers/net/r8169/base/rtl8168fp.h b/drivers/net/r8169/base/rtl8168fp.h
index 4613fe9a98..194f14af4e 100644
--- a/drivers/net/r8169/base/rtl8168fp.h
+++ b/drivers/net/r8169/base/rtl8168fp.h
@@ -10,5 +10,6 @@
 extern const struct rtl_hw_ops rtl8168fp_ops;
 
 void hw_mac_mcu_config_8168fp(struct rtl_hw *hw);
+void hw_phy_mcu_config_8168fp(struct rtl_hw *hw __rte_unused);
 
 #endif
diff --git a/drivers/net/r8169/base/rtl8168fp_mcu.c b/drivers/net/r8169/base/rtl8168fp_mcu.c
index 839dcfde61..7757e5f448 100644
--- a/drivers/net/r8169/base/rtl8168fp_mcu.c
+++ b/drivers/net/r8169/base/rtl8168fp_mcu.c
@@ -268,3 +268,9 @@ hw_mac_mcu_config_8168fp(struct rtl_hw *hw)
 		break;
 	}
 }
+
+void
+hw_phy_mcu_config_8168fp(struct rtl_hw *hw __rte_unused)
+{
+	/* Do nothing */
+}
-- 
2.34.1

