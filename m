Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390ECC02198
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 03:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E11A42799;
	Fri,  7 Feb 2025 04:19:20 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 2E15E402A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 04:19:17 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5173JFMw8211759,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realsil.com.cn;
 s=dkim; t=1738898356;
 bh=rw1efjjzAWig6xp6sVib9kCcjHTnnn3c3/oFVATwS18=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=rg82gFAl4WzeqmlAr1DM0lC87HXgwUyH/mILthGYFbkjHmWincYQvRfEhj8pDjWqR
 6eRa8fjsZDM7P0sp9VRR24Wr65Qb/Rbm/RL53q8jc+Iw8ohZOFX93jBq7VQ/fxhRcg
 Nm2fnqdQ6nkaEoXKD/mNlX0PfcBYal95WwNupWdybbgBTD7o8worBiBWJEuJK6qqj9
 iFkZPP82C8KRSRV+DnhBlpzowTL4aH442AVIcTlnp0DCm0ehibsQ/ZK7YN24WXpiY7
 yGHP9ar6coZEzBMWqs9/oJ98YJYxohmddLlhM4v3TkPwG96ujGYCb2DwGu51Z4RC95
 qupP+8wtox3PQ==
Received: from RSEXH36502.realsil.com.cn (ms1.realsil.com.cn[172.29.17.3])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5173JFMw8211759
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL)
 for <dev@dpdk.org>; Fri, 7 Feb 2025 11:19:16 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RSEXH36502.realsil.com.cn (172.29.17.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Feb 2025 11:19:15 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Feb 2025 11:19:15 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Feb 2025 11:19:15 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 1/2] net/r8169: replace rte_smp_rmb with atomic read
Date: Fri, 7 Feb 2025 11:18:44 +0800
Message-ID: <20250207031845.22168-2-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207031845.22168-1-howard_wang@realsil.com.cn>
References: <20250207031845.22168-1-howard_wang@realsil.com.cn>
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

rte_smp_rmb is deprecated and it is too heavy.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_rxtx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index a3b86300f0..57b97338d4 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -38,7 +38,7 @@
 
 /* Struct TxDesc in kernel r8169 */
 struct rtl_tx_desc {
-	u32 opts1;
+	RTE_ATOMIC(u32) opts1;
 	u32 opts2;
 	u64 addr;
 	u32 reserved0;
@@ -1264,9 +1264,9 @@ rtl_get_hw_clo_ptr(struct rtl_hw *hw)
 static u32
 rtl_get_opts1(struct rtl_tx_desc *txd)
 {
-	rte_smp_rmb();
+	u32 opts1 = rte_atomic_load_explicit(&txd->opts1, rte_memory_order_acquire);
 
-	return rte_le_to_cpu_32(txd->opts1);
+	return rte_le_to_cpu_32(opts1);
 }
 
 static void
-- 
2.34.1

