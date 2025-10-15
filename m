Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A9CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F060D40661;
	Wed, 15 Oct 2025 09:07:30 +0200 (CEST)
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.246.68.102]) by mails.dpdk.org (Postfix) with ESMTP id 1D52940657
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512049; x=1792048049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=Rq1ZaRIKUzmp2hmEbEjywmRyDrABC6gSmh1QNn8xQH8=;
 b=F3uffKcgOb3bw8Q2ALLdAKaNc9gSn/brvZ0Nu7Vyh8gq8wy4uqO0KPFg
 YPdh1z6T7YO6AgAGeGHI0BFzrv2yW3r/FWDgVt2+dXAkp7RA6alDO3Aki
 fnl1QFZnaxhoTD7j5rFWuF4oS3HLvR8g7uLO7Xe8tE6DVfbFDBSZ0Jxpj
 U+tuA8/oXJ38tnXEQUahjMhdqzHWI1osjECmWo7uz6V8/5fnSxZm+hj8n
 s5wdg8Kn5WcdOPVSxDS5pzstp1wcAkYM4G2IRzuVBfBLZ9KacFeoiXdep
 UooJC+JUhi6DtrcwjBKEh03nmqcglHBQ3T2dlpSmoigAvjf1Dg5Hbq9vg Q==;
X-CSE-ConnectionGUID: rHE/6kkORRG7Of+ygBu6HA==
X-CSE-MsgGUID: A+hBNMb3SLugpcXIn7tbnw==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4918359"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:07:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:23532]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.233:2525]
 with esmtp (Farcaster)
 id e35421c7-36f8-49fc-97f2-b016632f9b4c; Wed, 15 Oct 2025 07:07:23 +0000 (UTC)
X-Farcaster-Flow-ID: e35421c7-36f8-49fc-97f2-b016632f9b4c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:07:22 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:07:21 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 01/21] net/ena/base: optimize Tx desc fields setting
Date: Wed, 15 Oct 2025 10:06:47 +0300
Message-ID: <20251015070707.340-2-shaibran@amazon.com>
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

Instead of erasing tx descriptor and later set all fields using or,
use set for the first value of each field of the descriptor.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index c6668238e5..c4fee7bb3c 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -516,26 +516,25 @@ int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
 	desc = get_sq_desc(io_sq);
 	if (unlikely(!desc))
 		return ENA_COM_FAULT;
-	memset(desc, 0x0, sizeof(struct ena_eth_io_tx_desc));
+
+	desc->len_ctrl = ENA_FIELD_PREP((u32)io_sq->phase,
+					ENA_ETH_IO_TX_DESC_PHASE_MASK,
+					ENA_ETH_IO_TX_DESC_PHASE_SHIFT);
 
 	/* Set first desc when we don't have meta descriptor */
 	if (!have_meta)
 		desc->len_ctrl |= ENA_ETH_IO_TX_DESC_FIRST_MASK;
 
-	desc->buff_addr_hi_hdr_sz |= ENA_FIELD_PREP((u32)header_len,
-						    ENA_ETH_IO_TX_DESC_HEADER_LENGTH_MASK,
-						    ENA_ETH_IO_TX_DESC_HEADER_LENGTH_SHIFT);
-
-	desc->len_ctrl |= ENA_FIELD_PREP((u32)io_sq->phase,
-					 ENA_ETH_IO_TX_DESC_PHASE_MASK,
-					 ENA_ETH_IO_TX_DESC_PHASE_SHIFT);
+	desc->buff_addr_hi_hdr_sz = ENA_FIELD_PREP((u32)header_len,
+						   ENA_ETH_IO_TX_DESC_HEADER_LENGTH_MASK,
+						   ENA_ETH_IO_TX_DESC_HEADER_LENGTH_SHIFT);
 
 	desc->len_ctrl |= ENA_ETH_IO_TX_DESC_COMP_REQ_MASK;
 
 	/* Bits 0-9 */
-	desc->meta_ctrl |= ENA_FIELD_PREP((u32)ena_tx_ctx->req_id,
-					  ENA_ETH_IO_TX_DESC_REQ_ID_LO_MASK,
-					  ENA_ETH_IO_TX_DESC_REQ_ID_LO_SHIFT);
+	desc->meta_ctrl = ENA_FIELD_PREP((u32)ena_tx_ctx->req_id,
+					 ENA_ETH_IO_TX_DESC_REQ_ID_LO_MASK,
+					 ENA_ETH_IO_TX_DESC_REQ_ID_LO_SHIFT);
 
 	desc->meta_ctrl |= ENA_FIELD_PREP(ena_tx_ctx->df,
 					  ENA_ETH_IO_TX_DESC_DF_MASK,
-- 
2.17.1

