Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02988CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1E9740DDC;
	Wed, 15 Oct 2025 14:05:29 +0200 (CEST)
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.155.198.111])
 by mails.dpdk.org (Postfix) with ESMTP id 8794140273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760529925; x=1792065925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=yrkzBo0jmK21LHvOffNIk0oPKRowXHHthvQZQ7kxVo8=;
 b=CJWcT/1n7WHHdGgTL8H9F3SNxzcAK2ny/k/3+xxQo+uiPLUv43jc8TbT
 fTWTjeD9q8MJ29Xv4NMwazC+RNACIUlnnlgmz5bIePXrTlsfOhxAwHTLs
 lHq3drJ5e3Jnweslg7PEzBnI+WrgXqBTRu8zykOwY/IXCZ2B42t1QuGTH
 oWe5p/PcJTUY0gC727zX2IXgMYqRX/YxZghzdFgJEOxLwRd2Qvf3tMma+
 3vGnh/l0AsK5uzlc2Q7trm/sOb6LW5Sanw4uXqsUITPx0icqRn44BX7h3
 omTSDslzSnhApaUL7FQykxv38zcoWVJaJM9+GcKoD6f9h7QwPnLOuW3Qn A==;
X-CSE-ConnectionGUID: Y3WR6ySeQHWwyEoRrYq59g==
X-CSE-MsgGUID: nFBOzk9YSjidc3vDoTzUsg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4813251"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:05:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:25120]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.168:2525]
 with esmtp (Farcaster)
 id 49939837-5c7d-4b1d-ab4c-e75cd33390d1; Wed, 15 Oct 2025 12:05:24 +0000 (UTC)
X-Farcaster-Flow-ID: 49939837-5c7d-4b1d-ab4c-e75cd33390d1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:05:24 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:05:23 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 03/20] net/ena/base: add IO ring helper functions
Date: Wed, 15 Oct 2025 15:03:58 +0300
Message-ID: <20251015120415.2204-4-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251015120415.2204-1-shaibran@amazon.com>
References: <20251015120415.2204-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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

Add separate utilities to check if Rx/Tx CQ are empty.
Introduce new function to retrieve tx cq descriptor.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.c | 43 +++++++++++++++++++++++++-----
 drivers/net/ena/base/ena_eth_com.h |  3 ++-
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index b68be49ef9..fd98e5ae67 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -733,13 +733,42 @@ int ena_com_add_single_rx_desc(struct ena_com_io_sq *io_sq,
 	return ena_com_sq_update_reqular_queue_tail(io_sq);
 }
 
-bool ena_com_cq_empty(struct ena_com_io_cq *io_cq)
+bool ena_com_rx_cq_empty(struct ena_com_io_cq *io_cq)
 {
-	struct ena_eth_io_rx_cdesc_ext *cdesc;
+	return (ena_com_get_next_rx_cdesc(io_cq) == NULL);
+}
+
+static struct ena_eth_io_tx_cdesc_ext *ena_com_get_next_tx_cdesc(struct ena_com_io_cq *io_cq)
+{
+	struct ena_eth_io_tx_cdesc_ext *cdesc;
+	u8 expected_phase, cdesc_phase;
+	u16 masked_head;
+
+	masked_head = io_cq->head & (io_cq->q_depth - 1);
+	expected_phase = io_cq->phase;
+
+	cdesc = (struct ena_eth_io_tx_cdesc_ext *)
+		((uintptr_t)io_cq->cdesc_addr.virt_addr +
+		(masked_head * io_cq->cdesc_entry_size_in_bytes));
+
+	/* When the current completion descriptor phase isn't the same as the
+	 * expected, it means that the device didn't update this completion yet.
+	 */
+	cdesc_phase = ENA_FIELD_GET(READ_ONCE8(cdesc->base.flags),
+				    ENA_ETH_IO_TX_CDESC_PHASE_MASK,
+				    ENA_ZERO_SHIFT);
+	if (cdesc_phase != expected_phase)
+		return NULL;
+
+	/* Make sure we read the rest of the descriptor after the phase bit
+	 * has been read
+	 */
+	dma_rmb();
 
-	cdesc = ena_com_get_next_rx_cdesc(io_cq);
-	if (cdesc)
-		return false;
-	else
-		return true;
+	return cdesc;
+}
+
+bool ena_com_tx_cq_empty(struct ena_com_io_cq *io_cq)
+{
+	return (ena_com_get_next_tx_cdesc(io_cq) == NULL);
 }
diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index e8f6f09359..e56eb2c173 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -74,7 +74,8 @@ int ena_com_add_single_rx_desc(struct ena_com_io_sq *io_sq,
 			       struct ena_com_buf *ena_buf,
 			       u16 req_id);
 
-bool ena_com_cq_empty(struct ena_com_io_cq *io_cq);
+bool ena_com_rx_cq_empty(struct ena_com_io_cq *io_cq);
+bool ena_com_tx_cq_empty(struct ena_com_io_cq *io_cq);
 
 static inline bool ena_com_is_extended_tx_cdesc(struct ena_com_io_cq *io_cq)
 {
-- 
2.17.1

