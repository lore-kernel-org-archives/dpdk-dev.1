Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44DBCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:07:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C0BA40685;
	Wed, 15 Oct 2025 14:07:28 +0200 (CEST)
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.162.73.231]) by mails.dpdk.org (Postfix) with ESMTP id 6E4BB40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:07:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530046; x=1792066046;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=I7dr1fP8oTQm2QuYPYryA6cnYlJTJDzbinDWYq4aQ+o=;
 b=rK67WEfVqo1SJqAAx38MRLzLqRd+WBoa/TpSI+i0haH41RPc9Xap1bJm
 dJr+UO7f4d6Uq13kITQY/ZX6oRkwIuWK7sGwP77C8IgukCmt2hoqutzd7
 cQ+JONm//z1mA1iIF+fNiGBwbgJQYP4rz6DTR2MQqpAxJ3bDrp9SHjClU
 2rr7ARv2lHzdLJf2WEqgf028ntQQH6YF4P/1Es31I+WK+YQhGOJxyxg63
 zTAnTkYCQiuTOEFOdYCk96JzbczpoIQIc6S390OXUltAtFZ2zLGethEJs
 OQC2k0hf0zW4uzaXn6MQOq/LHuNdrxzM/bpflbQqrh5+erxXSXlgVd/Vg w==;
X-CSE-ConnectionGUID: FOq9HVTPSpqtGO1syBVFUw==
X-CSE-MsgGUID: oG9Lv8rrR0STHcILlheQyA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4732765"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:07:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:19273]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.131:2525]
 with esmtp (Farcaster)
 id 05c4d378-344a-4b6e-9e2a-e4cd5f81248a; Wed, 15 Oct 2025 12:07:23 +0000 (UTC)
X-Farcaster-Flow-ID: 05c4d378-344a-4b6e-9e2a-e4cd5f81248a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:07:23 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:07:22 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 05/20] net/ena/base: add Rx cdesc dump on bad request ID
Date: Wed, 15 Oct 2025 15:06:43 +0300
Message-ID: <20251015120643.2345-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
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

This patch moves the check of bad req_id from ena_com_rx_pkt() to
ena_com_cdesc_rx_pkt_get(), such that on bad req_id the head will point
to it and later the descriptor will be dumped.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index fd98e5ae67..212adc7d1f 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -322,6 +322,13 @@ static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 			return ENA_COM_FAULT;
 		}
 
+		if (unlikely(cdesc->base.req_id >= io_cq->q_depth)) {
+			ena_trc_err(dev,
+				    "Bad req_id in descriptor #%u on q_id: %u, req_id: %u\n",
+				    count, io_cq->qid, cdesc->base.req_id);
+			return ENA_COM_EIO;
+		}
+
 		ena_com_cq_inc_head(io_cq);
 		count++;
 		last = ENA_FIELD_GET(status,
@@ -624,7 +631,6 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 {
 	struct ena_com_rx_buf_info *ena_buf = &ena_rx_ctx->ena_bufs[0];
 	struct ena_eth_io_rx_cdesc_ext *cdesc = NULL;
-	u16 q_depth = io_cq->q_depth;
 	u16 cdesc_idx = 0;
 	u16 nb_hw_desc;
 	u16 i = 0;
@@ -635,7 +641,7 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 
 	rc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx, &nb_hw_desc);
 	if (unlikely(rc != ENA_COM_OK))
-		return ENA_COM_FAULT;
+		return rc;
 
 	if (nb_hw_desc == 0) {
 		ena_rx_ctx->descs = nb_hw_desc;
@@ -659,8 +665,6 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	do {
 		ena_buf[i].len = cdesc->base.length;
 		ena_buf[i].req_id = cdesc->base.req_id;
-		if (unlikely(ena_buf[i].req_id >= q_depth))
-			return ENA_COM_EIO;
 
 		if (++i >= nb_hw_desc)
 			break;
-- 
2.17.1

