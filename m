Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D2C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4243D42D90;
	Wed, 21 May 2025 16:03:04 +0200 (CEST)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
 by mails.dpdk.org (Postfix) with ESMTP id EC68442D90
 for <dev@dpdk.org>; Wed, 21 May 2025 16:03:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747836184; x=1779372184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=M64SQy/H4oZpPt2teWvXxpXYMAcU8mC2sR8o2jDYIDs=;
 b=dTVxYk+sRfh3mNN+sdckSbaMMWBhLXcVdAfAbg2LJ5jJsrvHXFc+nBDc
 dm3eTIz05kNT3k/sgnIHjVBBujTQRXDxjLu3sbVtPRB+MsCq2CUKr08Qa
 dleDBIdRsM1yjIjfzgo6YC4yZxKO5hq5Jxcaa0hnCpkJQyvsVzffWC6W1
 wByz+uO+MSnlqXQnVczew7RKL15agWspIGNDP5w6Em3C+SqDj3bsR4vk0
 b5l/6ZFa4xx7uF0fMig9glYo6b//LLYuNs1RRqQnI+m1/f25M1Q37RE1k
 ffSDcGJJDbGdaW+uH4JbToEiPDui21ZqN2IIdZ7IaVOr/pqKWxcLZgo2r g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; d="scan'208";a="494696462"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-2101.iad2.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:02:56 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:1207]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.132:2525]
 with esmtp (Farcaster)
 id 7d481e97-c1aa-434f-bce9-9eb4b9709ee1; Wed, 21 May 2025 14:02:40 +0000 (UTC)
X-Farcaster-Flow-ID: 7d481e97-c1aa-434f-bce9-9eb4b9709ee1
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:02:39 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.30) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:02:37 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 2/8] net/ena/base: coding style changes
Date: Wed, 21 May 2025 17:02:07 +0300
Message-ID: <20250521140213.2576-3-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250521140213.2576-1-shaibran@amazon.com>
References: <20250521140213.2576-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.30]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

Reordered variable declarations to follow the
reverse Christmas tree style.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 238716de29..588dc61387 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -308,8 +308,8 @@ static struct ena_comp_ctx *ena_com_submit_admin_cmd(struct ena_com_admin_queue
 						     struct ena_admin_acq_entry *comp,
 						     size_t comp_size_in_bytes)
 {
-	unsigned long flags = 0;
 	struct ena_comp_ctx *comp_ctx;
+	unsigned long flags = 0;
 
 	ENA_SPINLOCK_LOCK(admin_queue->q_lock, flags);
 	if (unlikely(!admin_queue->running_state)) {
@@ -616,10 +616,10 @@ static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *comp_c
  */
 static int ena_com_set_llq(struct ena_com_dev *ena_dev)
 {
+	struct ena_com_llq_info *llq_info = &ena_dev->llq_info;
 	struct ena_com_admin_queue *admin_queue;
-	struct ena_admin_set_feat_cmd cmd;
 	struct ena_admin_set_feat_resp resp;
-	struct ena_com_llq_info *llq_info = &ena_dev->llq_info;
+	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
 	memset(&cmd, 0x0, sizeof(cmd));
-- 
2.17.1

