Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93328C54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:27:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 008DD4066D;
	Thu, 22 May 2025 15:27:01 +0200 (CEST)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com
 [99.78.197.217]) by mails.dpdk.org (Postfix) with ESMTP id AC17640663
 for <dev@dpdk.org>; Thu, 22 May 2025 15:26:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747920420; x=1779456420;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=M64SQy/H4oZpPt2teWvXxpXYMAcU8mC2sR8o2jDYIDs=;
 b=jICvOMyErHUuw+VIO4k1k1OmO39+mYqf1640HeJLZnuNejJOKNyObkU1
 ono8t7NeuQE0dgbTYEfRJDeHbDQygNbt/IyBPz5bG6yqsRbRMP45TIGiJ
 wQFyb3ja5P9RWXzwv5ky6nyexzVAHe+5UvNIOqqy11FyFbFDianzzztH+
 u0vJLBXEi3Da+DCrBLErFvrOJYH7JfMspq2VhhC2dDTini4cR7816mdvd
 1ZNo/7eAB8wtPYGwv3vOC98kFhC6NccJGMSTBjjRaKvwquzHkowMmtcc3
 vAb6J5j1yrh2AuS/Y8ra/AwHzm1ER1VWRbGoQl7tfcO1ZjmgcOk/13q3T g==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="52896918"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:26:57 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:23375]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.235:2525]
 with esmtp (Farcaster)
 id 3b308194-b81a-4c50-a942-09e89ceb0a1b; Thu, 22 May 2025 13:26:56 +0000 (UTC)
X-Farcaster-Flow-ID: 3b308194-b81a-4c50-a942-09e89ceb0a1b
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:26:56 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:26:54 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 2/7] net/ena/base: coding style changes
Date: Thu, 22 May 2025 16:26:09 +0300
Message-ID: <20250522132614.3379-3-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250522132614.3379-1-shaibran@amazon.com>
References: <20250522132614.3379-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
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

