Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D8FCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B217440E4D;
	Wed, 15 Oct 2025 14:12:04 +0200 (CEST)
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.13.214.179]) by mails.dpdk.org (Postfix) with ESMTP id 6987C40E40
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530323; x=1792066323;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=xTqTQVHmvmufTg3bRWNqdsBbkZfdi3BpsZX4NHnhJJM=;
 b=V33oIOXvV68sBHvuJ2sC2CqW4vR5h4BAZiGSR3t74Tl/7lqfIG9OZfMh
 bAJo8KceFqlZjfI08TWVYEYpUxIse8eIEwKdzc2PGMchlaZFg+WUhC2LD
 YYlV9zDDnGeLCyHb/3XZIMsBOwLo/Uc3aBr0TgIliRvSW8xKzuGKaQeeN
 TiXYGrVptGrU9xFGymWii0vzERn3I2NhqxtNCzbjDhlqX9h0xYzliHpA5
 IiZLhw+i9Tzq1HONWumf2wVBmyS9kNgpxcJCCRlas5cNDDqJY29YWWYzZ
 64WQ5UEdjadZlB17ZSjve1quvgl0fdXlq9R6YoRmfHUtZWbozoD1STAdM g==;
X-CSE-ConnectionGUID: ZRFbJRfcQhWCQTPR2i122w==
X-CSE-MsgGUID: bDWYSmcWQOWTkdFghtdz3Q==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4929271"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:12:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:27284]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.197:2525]
 with esmtp (Farcaster)
 id e2c8d5d7-297a-4f18-aa77-e6d00373241b; Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
X-Farcaster-Flow-ID: e2c8d5d7-297a-4f18-aa77-e6d00373241b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:12:02 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:12:00 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH v2 15/20] net/ena/base: improve admin logging
Date: Wed, 15 Oct 2025 15:11:50 +0300
Message-ID: <20251015121150.2926-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
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

Added command ID to admin command failure log.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 4ba8211c2f..c3f3ca2bbe 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -530,14 +530,15 @@ static void ena_com_handle_admin_completion(struct ena_com_admin_queue *admin_qu
 	admin_queue->stats.completed_cmd += comp_num;
 }
 
-static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
-					u8 comp_status)
+static int ena_com_admin_status_to_errno(struct ena_com_admin_queue *admin_queue,
+					 struct ena_comp_ctx *comp_ctx)
 {
-	if (unlikely(comp_status != 0))
+	if (unlikely(comp_ctx->comp_status != 0))
 		ena_trc_err(admin_queue->ena_dev,
-			    "Admin command failed[%u]\n", comp_status);
+			    "Admin command %u failed (%u)\n",
+			    comp_ctx->cmd_opcode, comp_ctx->comp_status);
 
-	switch (comp_status) {
+	switch (comp_ctx->comp_status) {
 	case ENA_ADMIN_SUCCESS:
 		return ENA_COM_OK;
 	case ENA_ADMIN_RESOURCE_ALLOCATION_FAILURE:
@@ -608,7 +609,7 @@ static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *comp_c
 		goto err;
 	}
 
-	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
+	ret = ena_com_admin_status_to_errno(admin_queue, comp_ctx);
 err:
 	comp_ctxt_release(admin_queue, comp_ctx);
 	return ret;
@@ -833,8 +834,7 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 		ret = ENA_COM_NO_DEVICE;
 		goto err;
 	}
-
-	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
+	ret = ena_com_admin_status_to_errno(admin_queue, comp_ctx);
 err:
 	comp_ctxt_release(admin_queue, comp_ctx);
 	return ret;
-- 
2.17.1

