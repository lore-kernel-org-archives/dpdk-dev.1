Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E6C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:06:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8747D4066E;
	Thu, 22 May 2025 15:06:54 +0200 (CEST)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mails.dpdk.org (Postfix) with ESMTP id 15B384066C
 for <dev@dpdk.org>; Thu, 22 May 2025 15:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747919212; x=1779455212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=M64SQy/H4oZpPt2teWvXxpXYMAcU8mC2sR8o2jDYIDs=;
 b=hdMJWH1t9floL8BpeUcMSjTdf9wi69FHYdgvBkpw4kJErDE8XUScnc6H
 JEMRWkLSztMAgzd7TXmX0Yr32BSIsYEd1Si3W9QCA6sVnySUWVyEDpW0M
 xbZtq/Dohi6/WqmEPOtmnV5QZfgeIVln0Qk/I1fXbhbByy2CJjQM/UnwH
 C5J/5gOOXgLyTfclX3adlh5Cs54rkk6P6gWLy6FW1LoxOQOE35bJT8zL/
 PoawrTJPUfKuM6+87HIAr53t7Pc4LaPV0Vt9TenKAsuryi2KhbKIFHota
 IQxi7IPDKEgbnbUC6Suodh69NC0ey+gVUwO662oEMbFSDESlzM3I9T831 w==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="523294359"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:06:45 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:23337]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.44:2525]
 with esmtp (Farcaster)
 id 898eef03-a42a-4e36-b768-5fe13ab300a8; Thu, 22 May 2025 13:06:44 +0000 (UTC)
X-Farcaster-Flow-ID: 898eef03-a42a-4e36-b768-5fe13ab300a8
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:06:44 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:06:42 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 2/7] net/ena/base: coding style changes
Date: Thu, 22 May 2025 16:06:17 +0300
Message-ID: <20250522130622.3192-3-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250522130622.3192-1-shaibran@amazon.com>
References: <20250522130622.3192-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
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

