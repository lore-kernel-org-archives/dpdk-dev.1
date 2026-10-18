Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CB8CCA490
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:48:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B649D4065A;
	Sun, 18 Oct 2026 11:48:09 +0200 (CEST)
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.13.214.179]) by mails.dpdk.org (Postfix) with ESMTP id 4BFD04065A
 for <dev@dpdk.org>; Sun, 18 Oct 2026 11:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792316888; x=1823852888;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=IS7lvXiu4m9OmcqOtlpw+8f1Uwgb6z2N8MK9g2K5lRI=;
 b=f8M0p2VjMXnB8ozMLxa4hm59B8PsDB4hKrJCE179WVWN5pb/9EKIQjow
 noHfCKnUU+KK6p6UbvqzuFRpCXPA/Tjbf02BmfdURXA0QePfbsDSSqhvP
 scIq7KKDA8n20VfwLrSasbYoJ81ZPyZy2lPdsr3pVBPYrXGxc2++oBBZ0
 oA8cKeQ/E2dHGCb7y9WrfIoN6F7QqUc7/D4qII1SgkdwYZjPjx1oXoK23
 qHNWT9wfhZ8eWpvzGUqMSgr9um0CACTgpYIG9Nw+GqJxyQ101GaHW04E4
 sAvXB5kYNmNXjZ55O14ZLKUXCDBoaO8GbOPlNNo6ueVu2TMKiSoJs1AgN w==;
X-CSE-ConnectionGUID: X1KcZBYfS/24OsDglpI0/A==
X-CSE-MsgGUID: tAQ9Z05QSwqWeSkPeSs5Wg==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31546624"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 09:48:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:26138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.90:2525]
 with esmtp (Farcaster)
 id d6ca86e8-7fe9-4c6c-85aa-3ae076345edb; Sun, 18 Oct 2026 09:48:03 +0000 (UTC)
X-Farcaster-Flow-ID: d6ca86e8-7fe9-4c6c-85aa-3ae076345edb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 09:48:03 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 09:48:02 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 04/13] net/ena/base: rename bounce buffer references
Date: Sun, 18 Oct 2026 12:47:52 +0300
Message-ID: <65315166cb7f0a86425fa10c03b25b9a95cbd1af.1792312030.git.shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1792312029.git.shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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

