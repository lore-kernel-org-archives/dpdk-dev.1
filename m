Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA2ACC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F596402EA;
	Tue, 13 Oct 2026 17:09:50 +0200 (CEST)
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.13.214.179]) by mails.dpdk.org (Postfix) with ESMTP id B822F402EA
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904189; x=1823440189;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=8tDBdeScc912+3cDQ3GtHsSz0MKsqtSdI7CmsJ5870U=;
 b=ObCPGCKBIyIPtFxUyOz9Fpb3nnmYNZNdZh9Ci9PQJt47C3j4HmrmLQSj
 ZGmL0tCEbQkoXuVqjP6NzhQpsu/m3Jh9m6ELDmhLccLICp+EkfSLqhGMc
 SDPp6SWQftgBZbCMzzVwqnaVUPKszO5C/h8+u8SwFxu0ZGgpQQc079xLb
 SW4LwRJLRdBM20sZm4/Vx8LMq+ELqLgfYzQ5GzihetwYCjgwwA7imrXQY
 6PpZpUX/RtjNIefKB1YTUNycJA+ebT82bCPWCTiXO1ZZPloz8NCbQGgdb
 WeJFfNhBu5XI6MIk1HsmaMooYzpv0I8rpZr2kbUm+dJlaWhBm11QpNxgd w==;
X-CSE-ConnectionGUID: Ze8CO144TEabo43fmuRK8w==
X-CSE-MsgGUID: 8dFO4HJRTZaIjlEpZyaDMA==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="31117108"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:09:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:29643]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.91:2525] with
 esmtp (Farcaster)
 id 1dc7b33b-1964-420d-a2b3-8f78d49a8e55; Tue, 13 Oct 2026 15:09:44 +0000 (UTC)
X-Farcaster-Flow-ID: 1dc7b33b-1964-420d-a2b3-8f78d49a8e55
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:09:44 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:09:42 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 07/13] net/ena/base: deduplicate LLQ entry write and advance
Date: Tue, 13 Oct 2026 18:09:30 +0300
Message-ID: <20261013150930.9580-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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

ena_com_close_llq_entry() and ena_com_sq_update_llq_tail() duplicate
the same sequence for flushing the current LLQ entry to the device and
moving on to the next one: write the bounce buffer, fetch the next
bounce buffer and reset it.

Extract the common sequence into a new helper,
ena_com_write_and_advance_llq_entry(), and call it from both sites.

No functional change.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.c | 49 ++++++++++++++++--------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index e3b2a753c4..ca15306859 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -204,6 +204,29 @@ static void *get_sq_desc_llq(struct ena_com_io_sq *io_sq)
 	return sq_desc;
 }
 
+static int ena_com_write_and_advance_llq_entry(struct ena_com_io_sq *io_sq)
+{
+	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
+	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
+	int rc;
+
+	rc = ena_com_write_bounce_buffer_to_dev(io_sq,
+						pkt_ctrl->curr_llq_entry);
+	if (unlikely(rc)) {
+		ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
+			    "Failed to write bounce buffer to device\n");
+		return rc;
+	}
+
+	pkt_ctrl->curr_llq_entry =
+		ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
+
+	memset(io_sq->llq_buf_ctrl.curr_llq_entry,
+	       0x0, llq_info->desc_list_entry_size);
+
+	return ENA_COM_OK;
+}
+
 static int ena_com_close_llq_entry(struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
@@ -215,18 +238,9 @@ static int ena_com_close_llq_entry(struct ena_com_io_sq *io_sq)
 
 	/* bounce buffer was used, so write it and get a new one */
 	if (likely(pkt_ctrl->idx)) {
-		rc = ena_com_write_bounce_buffer_to_dev(io_sq,
-							pkt_ctrl->curr_llq_entry);
-		if (unlikely(rc)) {
-			ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
-				    "Failed to write bounce buffer to device\n");
+		rc = ena_com_write_and_advance_llq_entry(io_sq);
+		if (unlikely(rc))
 			return rc;
-		}
-
-		pkt_ctrl->curr_llq_entry =
-			ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
-		memset(io_sq->llq_buf_ctrl.curr_llq_entry,
-		       0x0, llq_info->desc_list_entry_size);
 	}
 
 	pkt_ctrl->idx = 0;
@@ -258,18 +272,9 @@ static int ena_com_sq_update_llq_tail(struct ena_com_io_sq *io_sq)
 	int rc;
 
 	if (!pkt_ctrl->descs_left_in_line) {
-		rc = ena_com_write_bounce_buffer_to_dev(io_sq,
-							pkt_ctrl->curr_llq_entry);
-		if (unlikely(rc)) {
-			ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
-				    "Failed to write bounce buffer to device\n");
+		rc = ena_com_write_and_advance_llq_entry(io_sq);
+		if (unlikely(rc))
 			return rc;
-		}
-
-		pkt_ctrl->curr_llq_entry =
-			ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
-		memset(io_sq->llq_buf_ctrl.curr_llq_entry,
-		       0x0, llq_info->desc_list_entry_size);
 
 		pkt_ctrl->idx = 0;
 		pkt_ctrl->descs_left_in_line = llq_info->descs_per_entry;
-- 
2.17.1

