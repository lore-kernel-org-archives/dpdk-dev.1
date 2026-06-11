Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E400CCD98D4
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:35:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9A7542F35;
	Thu, 11 Jun 2026 10:35:50 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id B85D542F2D
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:35:49 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B8Zlo961787309,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1781166948;
 bh=KzZ+ZjZgFy9y2syfPjYeOqD5qIucXLPrGLdzmbcU0ig=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=D15+Zzoqt+83ICUVmUbVRFe3J8sisLtbNXjQbkbJP5+nP7s+zSZEKJvo5R8b2LK59
 0cBaP/Ho5wnnSn7XF5Fmun0aqk51HQUc6vJdop1/EvylwH5WyU2WacAytEUMalF22w
 3WTRW+R2j2wIiI0l7pVRZigkrIegIXzJmvJabVOzBYbFhLOq6rAy+p1uNzJxl8xAIN
 8o2Kkzjj+FU/VmWoiyxI/uAfUYXhTvzPeik2ZTr4oTagst2CyWkqJOsxUI+OE5PbfL
 t6MtjbcEPKUYf+/lrWDxG4XHtVwc63870slE2gWNbwRk9/9Ju2xkGqKKjsG8WsysXE
 YO4k/wlK0BE2Q==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B8Zlo961787309
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:35:48 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 16:35:47 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 16:35:47 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 4/6] net/r8169: remove RTL9151 CSI (DBI) channel support
Date: Thu, 11 Jun 2026 16:28:31 +0800
Message-ID: <20260611083521.20669-5-howard_wang@realsil.com.cn>
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

RTL9151 CSI (DBI) channel access is handled by FW. But FW may take
time to handle driver CSI channel access request and cause a HwIoErr.
For the reason mentioned above, remove RTL9151 CSI channel support.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_hw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index 53d0620422..f15bd579fd 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -467,6 +467,9 @@ rtl_csi_other_fun_read(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr)
 	int i;
 	u32 value = 0xffffffff;
 
+	if (hw->mcfg == CFG_METHOD_60)
+		goto exit;
+
 	cmd = CSIAR_Read | CSIAR_ByteEn << CSIAR_ByteEn_shift |
 	      (addr & CSIAR_Addr_Mask);
 
@@ -506,6 +509,9 @@ rtl_csi_other_fun_write(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr,
 	u32 cmd;
 	int i;
 
+	if (hw->mcfg == CFG_METHOD_60)
+		return;
+
 	RTL_W32(hw, CSIDR, value);
 	cmd = CSIAR_Write | CSIAR_ByteEn << CSIAR_ByteEn_shift |
 	      (addr & CSIAR_Addr_Mask);
-- 
2.43.0

