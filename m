Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF68AC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:26:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F07DA40A8A;
	Wed, 28 May 2025 12:26:06 +0200 (CEST)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com
 [207.171.188.204])
 by mails.dpdk.org (Postfix) with ESMTP id 3360A40A80
 for <dev@dpdk.org>; Wed, 28 May 2025 12:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1748427965; x=1779963965;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=M64SQy/H4oZpPt2teWvXxpXYMAcU8mC2sR8o2jDYIDs=;
 b=ARgMFLW+9rg5qIbzD4leLUE5B69xleHPXMxbyaOEwESYaEtj+vJqCsOj
 h7jAQT5AB+pQ+JRr9XZ3GAMFOLk4KCLT1m9ywJrYwhVwA/t0OxKAYmQDk
 9yTIpqG/OVdw/RmDsb2jzOwa3SzNCIJl5uNlAlMOOEHd80QGT05lf3lYy
 /zUWMfZVxMRUaK9BASCKYxfSc41yaQXBkpy3LOd/xXaJ8UnbypUjqcmwy
 T8epUL8YFVV8S0vY2OYb5/Kgm/kXdlTc2eL14wWdihOWzOc/qgDU/INun
 wGvkc2vee2B/ad5McAsp7berSkymn/h7c/NP351Ee26OfF6qJCB4qDjN2 g==;
X-IronPort-AV: E=Sophos;i="6.15,320,1739836800"; d="scan'208";a="24456127"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:26:04 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:42527]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.11:2525]
 with esmtp (Farcaster)
 id 9eba56d6-1bf3-4952-9ed8-95871512b875; Wed, 28 May 2025 10:26:02 +0000 (UTC)
X-Farcaster-Flow-ID: 9eba56d6-1bf3-4952-9ed8-95871512b875
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:26:02 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:25:59 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v4 2/7] net/ena/base: coding style changes
Date: Wed, 28 May 2025 13:25:26 +0300
Message-ID: <20250528102531.9876-3-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528102531.9876-1-shaibran@amazon.com>
References: <20250528102531.9876-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
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

