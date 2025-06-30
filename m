Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC31DC8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E025840664;
	Mon, 30 Jun 2025 13:14:44 +0200 (CEST)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com
 [207.171.188.206])
 by mails.dpdk.org (Postfix) with ESMTP id 0F31D40661
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:14:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751282084; x=1782818084;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=M64SQy/H4oZpPt2teWvXxpXYMAcU8mC2sR8o2jDYIDs=;
 b=bMnCD04reDc/peF1E8DPPWGe1ltNRgmsM5ZYAEbFKgIsnlVPt9LKf5E2
 cLbLUP+o3ug8gwNvTe51P77xSPjoaQ+7aLYhELDuUc/5TC7nfANLPxYAQ
 hWFYfVOktgU4vnHVBKcD/tBpl+8dJjwzbtu6FYsmVn6JwwCrtoQYyrYwO
 3/ZO2JuoZ7bavEbBMNOvzD/WrtsKrqUd/hu4kIPvdG731LlIPCWzVMk0K
 OGDaxk/Seicr3a/io275pWVeHftZ9Q/b+qiHZPu8ViYKEe7qJgBuhRuSS
 0pphWLR6Y1UWE95BpdrPxJkMekf8s7qHfKGXjz5eJaz5tvL0p8a2ZZRSe g==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="839174792"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:14:36 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:32113]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.208:2525]
 with esmtp (Farcaster)
 id 785a8dde-c945-4793-a707-ce691a9b5f25; Mon, 30 Jun 2025 11:14:34 +0000 (UTC)
X-Farcaster-Flow-ID: 785a8dde-c945-4793-a707-ce691a9b5f25
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:33 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:31 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 2/7] net/ena/base: coding style changes
Date: Mon, 30 Jun 2025 14:13:53 +0300
Message-ID: <20250630111358.3476-3-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250630111358.3476-1-shaibran@amazon.com>
References: <20250630111358.3476-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
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

