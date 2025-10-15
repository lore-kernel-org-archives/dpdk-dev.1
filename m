Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A624CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98D77406B8;
	Wed, 15 Oct 2025 09:16:00 +0200 (CEST)
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
 by mails.dpdk.org (Postfix) with ESMTP id 41A87402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512559; x=1792048559;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=O/4h1Od7rzWJvZsJ09VxdQphruvja9j84MzyTlPlz2w=;
 b=oUgRuELs7iqk53q9RdIhgYh4tdnmPXmoz39Qo+dyRSfSdBU6qTSNe3Fx
 eAGT6013VpeZfQ2vqw4/NXWqmhcKfS3qLLW43nmI818qySHAPug2vbUzB
 BJprJMZ4KduCDJ9ks2yLre3WMQWfdeijwf4mqiWYVqfS2K+TyWQfCTvDz
 K1FITpj/onAKA8Dtr/wBZaRvahDbqpJL5aC47VpjX1Nv5vcfMsmTLPus5
 mAMAoRYQ66pdj/t0ExlWncE2Ey1woUoGmSSXC3IqBPJsQMB4X08o3B1vv
 ckz5z9Z/jjqMftfuCeK6SglZMiB67rhAaoRVOCv86h3AGxzNgGV11TBAM g==;
X-CSE-ConnectionGUID: o+UdI1OeTEeLLDOSqqvBYQ==
X-CSE-MsgGUID: Zfhb6FowSZ2JoSFsO3pDZg==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4707328"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:15:56 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:6382]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.171:2525]
 with esmtp (Farcaster)
 id a192d8b7-01e7-463c-92a3-942b752cea30; Wed, 15 Oct 2025 07:15:56 +0000 (UTC)
X-Farcaster-Flow-ID: a192d8b7-01e7-463c-92a3-942b752cea30
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:15:56 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:15:54 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH 16/21] net/ena/base: improve admin logging
Date: Wed, 15 Oct 2025 10:15:44 +0300
Message-ID: <20251015071544.1041-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
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
 drivers/net/ena/base/ena_com.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index aba52cabae..7ce80bde37 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -544,14 +544,15 @@ static void ena_com_handle_admin_completion(struct ena_com_admin_queue *admin_qu
 	ATOMIC32_SET_RELEASE(&admin_queue->polling_for_completions, 0);
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
@@ -622,7 +623,7 @@ static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *comp_c
 		goto err;
 	}
 
-	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
+	ret = ena_com_admin_status_to_errno(admin_queue, comp_ctx);
 err:
 	comp_ctxt_release(admin_queue, comp_ctx);
 	return ret;
@@ -849,7 +850,7 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 		goto err;
 	}
 
-	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
+	ret = ena_com_admin_status_to_errno(admin_queue, comp_ctx);
 	comp_ctxt_release(admin_queue, comp_ctx);
 
 	return ret;
-- 
2.17.1

