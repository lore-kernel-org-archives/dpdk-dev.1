Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9B1E78D44
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 08:55:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EBBE4042E;
	Mon,  9 Feb 2026 09:55:29 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 146974027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 09:55:26 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6198tOaU51144227,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770627325;
 bh=A6LlToj/nhjFfVXUIFBPwcQrObALmMeqwT8hTRAzARk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=CrJibN6fY9x1mEdYiGY0qO8YXjTpkN8DvCauJTHCyRI7efqiAIXQo6S+z/W5HsEvw
 5HwPDGLszO0LrU280bbymkh0nfQmtwzyZDFSLL83JHwF4O8kfJwd8mH9exsf190oFn
 kjnOLeH6tTfaaB5Oz27kUybXkAhBkaat+1F38qLADQF2jtaHp+Dcd5vX6/D3kvVlND
 wwfs7+34uZe24ki9RzWqceTQ2vKzE+ZuwVPaNALBWutuzBNZZ+mUZIJxZipJW50jx5
 sI3q7qIUHqoX+h7eKuaYyLUdGxl5LtKfw83xkkZZG2rIfL1YISc0IUv6j4O5Ytbowj
 +SNp9ALoenQ4g==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6198tOaU51144227
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Mon, 9 Feb 2026 16:55:24 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 9 Feb 2026 16:55:24 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 9 Feb 2026 16:55:24 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 01/12] net/r8169: fix NULL pointer dereference in
 rtl8168fp_ops
Date: Mon, 9 Feb 2026 16:54:51 +0800
Message-ID: <20260209085502.26722-2-howard_wang@realsil.com.cn>
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

