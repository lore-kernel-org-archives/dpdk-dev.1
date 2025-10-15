Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F5CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:07:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85A4240674;
	Wed, 15 Oct 2025 09:07:33 +0200 (CEST)
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.83.148.184]) by mails.dpdk.org (Postfix) with ESMTP id AE0D84065E
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512050; x=1792048050;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=yrkzBo0jmK21LHvOffNIk0oPKRowXHHthvQZQ7kxVo8=;
 b=QPBR2VCch59YERs05i1Ti6bkXmPHPJLP+AF71vJNcSF77i1MlSA4IJ3a
 kaUIHYpNu+KgFDDlkL1tn+bGSZFz/ok9N2n8qe8Odb8Vu/iIQz92J60eJ
 JJN27y6wbLo6grjFsILJ6+BiNgv/i3RpIi1DGNtM3PG4PZVTFJAgzLxrY
 BgnkpO8bF8bPy/SYPWMcXOybOyEgaEIQzcBdzRM5cgWQNvia7cPU8Fy2j
 qo10UlJ2GGjSrTrhdmi2n9436DoZPe1vDIOiBomJJW8PTaGx2noAdIzb9
 aAUwJJByAT7LiG+zcdLwzFulKbwFhb/QYvjCRPo8x5AZk4ae8MZ1mlPEE A==;
X-CSE-ConnectionGUID: 8aNne0CmQNGd9p8W8/+EAg==
X-CSE-MsgGUID: UUTki15vR8W4MALZg2HE4A==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4716686"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:07:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:27115]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.3:2525] with
 esmtp (Farcaster)
 id 53dd12dd-97fb-4c71-a277-a51070bfd913; Wed, 15 Oct 2025 07:07:27 +0000 (UTC)
X-Farcaster-Flow-ID: 53dd12dd-97fb-4c71-a277-a51070bfd913
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:07:27 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:07:26 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 04/21] net/ena/base: add IO ring helper functions
Date: Wed, 15 Oct 2025 10:06:50 +0300
Message-ID: <20251015070707.340-5-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251015070707.340-1-shaibran@amazon.com>
References: <20251015070707.340-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
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

