Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98074EF48C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 03:20:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59555402F1;
	Fri, 13 Feb 2026 04:20:29 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id F338F402F0;
 Fri, 13 Feb 2026 04:20:27 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D3KPpS41172432,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770952826;
 bh=zt1xX+AgnsGswd+uOX1vq1kE4/toaJ0RHibTv5kFDyY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=jGyGAWvEyLTgX7FdsdoX1LOPZlBxpIAkg8M0n1gfa0nNipHARj1XJCzdGcnP1dy+j
 vHjDARVohNofmyJYX6DABqRNeyOqXWSC1dyDbzlJglPvedRdEt2lC8/LjWfICOwl4e
 uSxdfggzc8GWRSIJNzOwJZL2GGj7NNCazuO8gxT1CMO35S8Khy84DNFntPntmUdheP
 Rov1M4YGtrsKPIOsSuMhH2JTWx8M/pRD8K43INAMgwdEC2L0NMTUx4gUjfMQg7IKhJ
 a1ucefrD9uOgfUgK9kpuyD7CgL4c4CsU8ujISc3k/tTtSTi190s6xsxDFW66ruGHxW
 ctpk2Ka98Rd0g==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D3KPpS41172432
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Feb 2026 11:20:26 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 13 Feb 2026 11:20:25 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 13 Feb 2026 11:20:25 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>,
 <stable@dpdk.org>
Subject: [PATCH v4 01/13] net/r8169: fix crash in RTL8168FP init
Date: Fri, 13 Feb 2026 11:20:06 +0800
Message-ID: <20260213032018.175753-2-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213032018.175753-1-howard_wang@realsil.com.cn>
References: <20260213032018.175753-1-howard_wang@realsil.com.cn>
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
Cc: stable@dpdk.org

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

