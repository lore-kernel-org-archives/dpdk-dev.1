Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBBCCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 06:37:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913E840664;
	Sun, 18 Oct 2026 08:37:47 +0200 (CEST)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92]) by mails.dpdk.org (Postfix) with ESMTP id 8A17840276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 08:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792305466; x=1823841466;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=IS7lvXiu4m9OmcqOtlpw+8f1Uwgb6z2N8MK9g2K5lRI=;
 b=BMDVfHwLVU3x6r1fA7cxcTerx7gH/RQynA1/W1y1jp1ATSx6XbyCGqEK
 ukd+dt14znvwym4ePiHJVYTZMQB92gXkkJIKp/qqzLRgtVJSnz/9Aemju
 uGPU/qc7VszRtaC30wOswXQ1t/pby1+suzr93IgsTaFkMGCuWOdrWtJEl
 mcwdk6np1gvISaAZuPaZCHhov8dPYwbQ2qD4KlfM7HJo/npl7oZVjTUsU
 0FCesF8GkNtJWEco2YfGTKvQUPmeLkMwdsUckCAqT/8E3prxyI4HywlRF
 V2aJSkO+AjiydCNVxnvJXKi9iFzdwzWlE0ZAWEkGM8ak3LB/xkTb7po3m Q==;
X-CSE-ConnectionGUID: 3t5OVJkHTIiKteEw+tBx/g==
X-CSE-MsgGUID: PK4SjTRkS7SrOzXNvtFRwQ==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31070061"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 06:37:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:11812]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525]
 with esmtp (Farcaster)
 id 5791bc59-cb06-40ed-8d07-53eba6103254; Sun, 18 Oct 2026 06:37:43 +0000 (UTC)
X-Farcaster-Flow-ID: 5791bc59-cb06-40ed-8d07-53eba6103254
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 06:37:43 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 06:37:41 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 04/13] net/ena/base: rename bounce buffer references
Date: Sun, 18 Oct 2026 09:37:31 +0300
Message-ID: <20261018063731.1165-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
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

Rename curr_bounce_buf pointer in sq llq packet control to
curr_llq_entry for future use of llq not only with bounce buffers.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 4 ++--
 drivers/net/ena/base/ena_com.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 49818c4bd0..e9b9de21cb 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -391,9 +391,9 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		       sizeof(io_sq->llq_info));
 
 		/* Initiate the first bounce buffer */
-		io_sq->llq_buf_ctrl.curr_bounce_buf =
+		io_sq->llq_buf_ctrl.curr_llq_entry =
 			ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
-		memset(io_sq->llq_buf_ctrl.curr_bounce_buf,
+		memset(io_sq->llq_buf_ctrl.curr_llq_entry,
 		       0x0, io_sq->llq_info.desc_list_entry_size);
 		io_sq->llq_buf_ctrl.descs_left_in_line =
 			io_sq->llq_info.descs_num_before_header;
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index 1d024cfea0..bd395fd90c 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -138,7 +138,7 @@ struct ena_com_io_bounce_buffer_control {
 
 /* This struct is to keep tracking the current location of the next llq entry */
 struct ena_com_llq_pkt_ctrl {
-	u8 *curr_bounce_buf;
+	u8 *curr_llq_entry;
 	u16 idx;
 	u16 descs_left_in_line;
 };
-- 
2.17.1

