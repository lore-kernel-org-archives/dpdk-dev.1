Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403BCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:10:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6365640ED1;
	Wed, 15 Oct 2025 14:10:58 +0200 (CEST)
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
 by mails.dpdk.org (Postfix) with ESMTP id D662840A6C
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530256; x=1792066256;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=EBFaWH7BbEaqRlj5iuuRXAUw91Fjc7AqSYjoFQQ5WxU=;
 b=lqZOnzyeS6tZ3x0Ghm73c/Iy81rf9HZ0c1+UqF+nEN6z23Lyarufwabb
 TYFYx6O8WSx05IuP5hXnhJHrmFf6128bi2LTWjOsQFjUZzx+5hGoB/sFR
 /QX/UKm4872ppfDf93QUNcEevNJKecvjr7pmaROQLNZiJh4bJjWJU7FZ7
 VBeS6mDZEvPBuFr1fFQYbQQiaDNXPqWWwmim6wtBXP7KDKNzn+wrT++j0
 2fxKAfP5E0Fgwgh9DBc6za6gLniY+4iwexHcsmNi/qlBKjgK62U4mk2qM
 6MxAfLGcArlpCCoXnAXIXbzWdBIrRSFDruU6vnyhJdGDGnOQABr3mXuB3 A==;
X-CSE-ConnectionGUID: K1HUcljuT+KJkvpzsol28w==
X-CSE-MsgGUID: S/uAGVkvRJW5d69CVtF+MA==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4931657"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:10:55 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:9791]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.137:2525]
 with esmtp (Farcaster)
 id 94d4d83d-e64d-4112-be71-08ba133e8d58; Wed, 15 Oct 2025 12:10:54 +0000 (UTC)
X-Farcaster-Flow-ID: 94d4d83d-e64d-4112-be71-08ba133e8d58
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:10:54 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:10:53 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 13/20] net/ena/base: remove redundant zeroing of Tx desc
Date: Wed, 15 Oct 2025 15:10:42 +0300
Message-ID: <20251015121042.2828-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
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

