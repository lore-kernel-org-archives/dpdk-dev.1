Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC84EF48C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 03:22:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8142402B2;
	Fri, 13 Feb 2026 04:20:56 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 5612C40698;
 Fri, 13 Feb 2026 04:20:55 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D3KqJnA1173212,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770952853;
 bh=e2Qkm/ZXXBzX3DZGMIQDbJ+eAsLj4yhtmRoy2af3dvs=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=UZQ+XVn9KWCe45uYm209UZ+QbrxBNN0/0alVUF1la5gxOebS8bMsx9/spwZBx/6wh
 /Jc2vpePB4j5W7rZGl2HtV1yw0b9JBAdBPtkdfB226JioUPglyDlsne5GsEqNUEXQ0
 3V1w/dko/5VoxWxlrQbUBHzzZOy5Yhb6Lg58wiMlq9VkwnHv43zF/ei37lvvE+bZ4O
 uqO8ugNdKj6+nW6X1BxyrabIixTxp573S2C805j2JEXaQbkwfknDF+vfS/UYonToUX
 6BngHtgoChKXy0MTCix4/2Pev8vUIbrEwbaWaNQvD34Cuq9t4GRiMyA17LtXBZROTI
 VvzgC7EnQnKtQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D3KqJnA1173212
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Feb 2026 11:20:53 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 13 Feb 2026 11:20:53 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 13 Feb 2026 11:20:53 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>,
 <stable@dpdk.org>
Subject: [PATCH v4 13/13] net/r8169: fix bitmask logic for RTL8127
Date: Fri, 13 Feb 2026 11:20:18 +0800
Message-ID: <20260213032018.175753-14-howard_wang@realsil.com.cn>
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

Fix incorrect bitwise operation (used & instead of &~) when setting
RTL8127 1G and 10G capabilities.

Fixes: 8d9c29c2de93 ("net/r8169: support RTL8127ATF serdes interface")
Cc: stable@dpdk.org

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_fiber.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/r8169/r8169_fiber.c b/drivers/net/r8169/r8169_fiber.c
index 8533ade15e..caad868cf5 100644
--- a/drivers/net/r8169/r8169_fiber.c
+++ b/drivers/net/r8169/r8169_fiber.c
@@ -119,7 +119,7 @@ rtl8127_set_sds_phy_caps_1g_8127(struct rtl_hw *hw)
 	RTL_W16(hw, 0x233A, 0x8004);
 
 	val = RTL_R16(hw, 0x233E);
-	val &= (BIT_13 | BIT_12 | BIT_1 | BIT_0);
+	val &= ~(BIT_13 | BIT_12 | BIT_1 | BIT_0);
 	val |= BIT_1;
 	RTL_W16(hw, 0x233E, val);
 
@@ -153,7 +153,7 @@ rtl8127_set_sds_phy_caps_10g_8127(struct rtl_hw *hw)
 	RTL_W16(hw, 0x233A, 0x801A);
 
 	val = RTL_R16(hw, 0x233E);
-	val &= (BIT_13 | BIT_12 | BIT_1 | BIT_0);
+	val &= ~(BIT_13 | BIT_12 | BIT_1 | BIT_0);
 	val |= BIT_12;
 	RTL_W16(hw, 0x233E, val);
 
-- 
2.34.1

