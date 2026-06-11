Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16523CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:35:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0751542F27;
	Thu, 11 Jun 2026 10:35:49 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 5081842F25
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:35:47 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B8ZjLE21787297,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1781166945;
 bh=gtuYL+rBjr2MsYtzPTiF/5eQCMFsQuxM7odegADrTN8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=LaLT8tMl+uO7eV3dPEDfyfPt7Htn4pyL1MbRIGCqKmD6thbVPsfmAHiJVDl+dNMg2
 wXMEs3TXlylZ9wylnqvRos88pshZlnFoGpWw1MNcSxWbgG+MpY6oTPTUTr53BbVF4v
 WgRmYPm4uXaPzUm37zpmbJ1Ihlhs7hn6r1eKIJpIPVZ7Wn6eq6ujGWKb2DpAMwMYTv
 wBZIUZgtIj1+z4GDRCj244V2+QnAhBhgrQYd9MWf9AzbvdVM1TqylUTdvx+FvVoGnL
 y7qYDJK4bE0R7LV58TiaiGA9gvp+uAMDN+BDDC9B2LmC5DFFG+yakc75PC8IERcr74
 1yU4+HtHGrmcA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B8ZjLE21787297
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:35:45 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 16:35:45 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 16:35:45 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 3/6] net/r8169: improve RTL8125+ flow control
Date: Thu, 11 Jun 2026 16:28:30 +0800
Message-ID: <20260611083521.20669-4-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611083521.20669-1-howard_wang@realsil.com.cn>
References: <20260611083521.20669-1-howard_wang@realsil.com.cn>
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

Improve it by using formula to set H/W nearfull and nearempty.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_hw.c | 67 +++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index e5434165ba..53d0620422 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -1979,6 +1979,66 @@ rtl8168_switch_to_sgmii_mode(struct rtl_hw *hw)
 	rtl8168_set_mcu_ocp_bit(hw, 0xEB16, BIT_1);
 }
 
+static u16
+rtl8125_get_fifo_nf(struct rtl_hw *hw)
+{
+	u32 magic = 0;
+	u32 mtu;
+
+	mtu = hw->mtu;
+
+	if (hw->mcfg >= CFG_METHOD_48 && hw->mcfg <= CFG_METHOD_61) {
+		if (mtu < 9500)
+			magic = 14215 + mtu;
+		else
+			return 0x5CA;
+	} else if (hw->mcfg >= CFG_METHOD_70 && hw->mcfg <= CFG_METHOD_71) {
+		if (mtu < 9500)
+			magic = 14447;
+		else
+			magic = 4947;
+
+		magic += mtu * (mtu < 9500 ? 1 : 2);
+	} else if (hw->mcfg >= CFG_METHOD_91) {
+		if (mtu < 9500)
+			magic = 17171;
+		else
+			magic = 7671;
+
+		magic += mtu * (mtu < 9500 ? 1 : 2);
+	}
+
+	return (u16)(magic >> 4);
+}
+
+static u16
+rtl8125_get_fifo_ne(struct rtl_hw *hw)
+{
+	u32 magic = 0;
+	u32 mtu;
+
+	mtu = hw->mtu;
+
+	if (hw->mcfg >= CFG_METHOD_48 && hw->mcfg <= CFG_METHOD_61) {
+		return 0x6BE;
+	} else if (hw->mcfg >= CFG_METHOD_70 && hw->mcfg <= CFG_METHOD_71) {
+		if (mtu < 9500)
+			return 0x107C;
+
+		magic = 77033;
+	} else if (hw->mcfg >= CFG_METHOD_91) {
+		if (mtu < 9500)
+			return 0x2C4A;
+
+		magic = 190910;
+	}
+
+	if (magic > mtu)
+		return (u16)((magic - mtu) >> 4);
+	else
+		return 0;
+}
+
 static void
 rtl_exit_oob(struct rtl_hw *hw)
 {
@@ -2007,12 +2067,9 @@ rtl_exit_oob(struct rtl_hw *hw)
 	rtl_wait_ll_share_fifo_ready(hw);
 
 	if (rtl_is_8125(hw)) {
-		rtl_mac_ocp_write(hw, 0xC0AA, 0x07D0);
-
-		rtl_mac_ocp_write(hw, 0xC0A6, 0x01B5);
-
+		rtl_mac_ocp_write(hw, 0xC0A6, rtl8125_get_fifo_nf(hw));
+		rtl_mac_ocp_write(hw, 0xC0AA, rtl8125_get_fifo_ne(hw));
 		rtl_mac_ocp_write(hw, 0xC01E, 0x5555);
-
 	} else {
 		data16 = rtl_mac_ocp_read(hw, 0xE8DE) | BIT_15;
 		rtl_mac_ocp_write(hw, 0xE8DE, data16);
-- 
2.43.0

