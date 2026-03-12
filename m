Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF030FED2FE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 10:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CC6C40676;
	Thu, 12 Mar 2026 11:36:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 61D504066E
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:36:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773311798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BG2YLr8u36QdCGLcS66IfvfJOPClHMGr95g3Bz94+7o=;
 b=M+LepUdYix2ZyuDyOMASsSMq8RdEbC+LISRUwNdLhEmg8bCk9rbmO8SDVHqmDPipiY5jpO
 1jIP2aYVJIWIdDmJlpRVPLpcaul1Swj/6cnw1k2JZn6RUccDTesApffNqRapNJzq9M1y6v
 VErG4OQAyeF3LXdkHgf2ZKfv685zWAw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-3BtjxWlwNe6C1FowVVH5MQ-1; Thu,
 12 Mar 2026 06:36:35 -0400
X-MC-Unique: 3BtjxWlwNe6C1FowVVH5MQ-1
X-Mimecast-MFC-AGG-ID: 3BtjxWlwNe6C1FowVVH5MQ_1773311794
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 640F518005BE; Thu, 12 Mar 2026 10:36:34 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6046530002D6; Thu, 12 Mar 2026 10:36:31 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 2/4] net/bnxt: fix uninitialized read
Date: Thu, 12 Mar 2026 10:36:04 +0000
Message-ID: <20260312103606.702617-3-ktraynor@redhat.com>
In-Reply-To: <20260312103606.702617-1-ktraynor@redhat.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U6MyI2IKWYUZy3j4aOBJHojeVN0fcpreKZp69kAl6Vw_1773311794
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

batch_info->enabled is read in tfc_mpc_batch_start() before it is
initialized.

Initialize batch_info to avoid this.

Fixes: 67ad40007cd6 ("net/bnxt/tf_ulp: fix VFR cleanup and stats lockup")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index b55366e003..23e1b59ca4 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -193,5 +193,5 @@ static uint32_t ulp_stats_cache_main_loop(void *arg)
 	struct ulp_sc_tfc_stats_cache_entry *sce;
 	struct ulp_sc_tfc_stats_cache_entry *sce_end;
-	struct tfc_mpc_batch_info_t batch_info;
+	struct tfc_mpc_batch_info_t batch_info = {0};
 	struct bnxt_ulp_sc_info *ulp_sc_info;
 	struct bnxt_ulp_context *ctxt = NULL;
-- 
2.53.0

