Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933D8CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:15:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F28BA40615;
	Wed, 15 Oct 2025 09:15:05 +0200 (CEST)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92]) by mails.dpdk.org (Postfix) with ESMTP id 411CE4069D
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:15:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512504; x=1792048504;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=EBFaWH7BbEaqRlj5iuuRXAUw91Fjc7AqSYjoFQQ5WxU=;
 b=Apc5yktY1q4A9O1+LXD1XWxzoYuA/R7rgA7qaLURTSIOG2odnV8MmsRu
 dgkPR/f7XvZrIkhY1XuvIL5IVKyHHlDdS4pKPiwMIx5CAPoLRl2XdxFH/
 8I2WLFJ8oItpzBfBlU9FduszW3vInjirYieEjHcBAVMPCrkFZWhG9TI3F
 bUkU5mz3MapraG8Bv7TVyZblsTmQ1ixPQIhKugNKdQpgJ006FM6sTMyMa
 NqS1T1oAWvZHSldHbPqtG7GTh7SAujYfo0Gt6Cx7DcznJfaQqXXaAflDH
 Zt84Vk6IE7Q7HZhW7bXa7dt9FqAka+bqr7iZeb8BJg7pofc73gtZqntLJ Q==;
X-CSE-ConnectionGUID: Q4ho8mMiSlOwOOch3WXidw==
X-CSE-MsgGUID: 7leXR6j8Tb2/yWqfC65WLQ==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4918671"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:15:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:1243]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.225:2525]
 with esmtp (Farcaster)
 id 5aa970bc-2325-4d11-a792-73fd13625528; Wed, 15 Oct 2025 07:15:03 +0000 (UTC)
X-Farcaster-Flow-ID: 5aa970bc-2325-4d11-a792-73fd13625528
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:15:02 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:15:01 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 14/21] net/ena/base: remove redundant zeroing of Tx desc
Date: Wed, 15 Oct 2025 10:14:50 +0300
Message-ID: <20251015071450.943-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

For LLQ, tx descriptors are stored in the bounce buffer,
which is already being zeroed out upon every call to
ena_com_get_next_bounce_buffer.

This patch utilizes the existing zero-out operation of the
bounce buffer, eliminating redundant zeroing of tx
descriptors in LLQ case.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index 7d982854c0..c1e3c55f82 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -234,12 +234,21 @@ static int ena_com_close_bounce_buffer(struct ena_com_io_sq *io_sq)
 	return ENA_COM_OK;
 }
 
-static void *get_sq_desc(struct ena_com_io_sq *io_sq)
+/* There is an assumption in function get_tx_sq_desc() that both descriptors have the same size */
+_Static_assert(sizeof(struct ena_eth_io_tx_meta_desc) == (sizeof(struct ena_eth_io_tx_desc)),
+	       "ena_eth_io_tx_meta_desc should be the same size as ena_eth_io_tx_desc");
+static void *get_tx_sq_desc(struct ena_com_io_sq *io_sq)
 {
+	void *tx_desc;
+
 	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV)
 		return get_sq_desc_llq(io_sq);
 
-	return get_sq_desc_regular_queue(io_sq);
+	tx_desc = get_sq_desc_regular_queue(io_sq);
+
+	memset(tx_desc, 0x0, sizeof(struct ena_eth_io_tx_desc));
+
+	return tx_desc;
 }
 
 static int ena_com_sq_update_llq_tail(struct ena_com_io_sq *io_sq)
@@ -372,12 +381,10 @@ static int ena_com_create_meta(struct ena_com_io_sq *io_sq,
 {
 	struct ena_eth_io_tx_meta_desc *meta_desc = NULL;
 
-	meta_desc = get_sq_desc(io_sq);
+	meta_desc = get_tx_sq_desc(io_sq);
 	if (unlikely(!meta_desc))
 		return ENA_COM_FAULT;
 
-	memset(meta_desc, 0x0, sizeof(struct ena_eth_io_tx_meta_desc));
-
 	meta_desc->len_ctrl |= ENA_ETH_IO_TX_META_DESC_META_DESC_MASK;
 
 	meta_desc->len_ctrl |= ENA_ETH_IO_TX_META_DESC_EXT_VALID_MASK;
@@ -535,7 +542,7 @@ int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
 		return rc;
 	}
 
-	desc = get_sq_desc(io_sq);
+	desc = get_tx_sq_desc(io_sq);
 	if (unlikely(!desc))
 		return ENA_COM_FAULT;
 
@@ -597,12 +604,10 @@ int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
 				return rc;
 			}
 
-			desc = get_sq_desc(io_sq);
+			desc = get_tx_sq_desc(io_sq);
 			if (unlikely(!desc))
 				return ENA_COM_FAULT;
 
-			memset(desc, 0x0, sizeof(struct ena_eth_io_tx_desc));
-
 			desc->len_ctrl |= ENA_FIELD_PREP((u32)io_sq->phase,
 							 ENA_ETH_IO_TX_DESC_PHASE_MASK,
 							 ENA_ETH_IO_TX_DESC_PHASE_SHIFT);
-- 
2.17.1

