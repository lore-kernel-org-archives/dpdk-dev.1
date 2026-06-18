Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB89BCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCF2940A73;
	Thu, 18 Jun 2026 17:28:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8E0D240609
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FQuiEpDN92xOd9yCSlcQbapKAk7P/cNiyQPbdu5Wrg=;
 b=Jb4g2DdeQGAfT9H9ccp0OxK1Beyt98zSTZ7ebbbUtZ7MjLkbrJLgkbYuHuN/prHuqiWWBX
 +Z3UksGTvPQPOjnCrADRpVZ/Hr/FlAuY7xQTW22yNIIFsziwqS3FH+woj+7k4qT9/WRbar
 SVOOHZsgi77+PGZk1NPPGEnxeoSma/A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-j0ugZERCNa-rgBGUxASL5A-1; Thu,
 18 Jun 2026 11:28:46 -0400
X-MC-Unique: j0ugZERCNa-rgBGUxASL5A-1
X-Mimecast-MFC-AGG-ID: j0ugZERCNa-rgBGUxASL5A_1781796523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CB1E1805A33; Thu, 18 Jun 2026 15:28:43 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.50.197])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A16E9180058D; Thu, 18 Jun 2026 15:28:40 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v2 02/10] dma/idxd: remove next pointer in bus specific device
Date: Thu, 18 Jun 2026 17:28:17 +0200
Message-ID: <20260618152826.490569-3-david.marchand@redhat.com>
In-Reply-To: <20260618152826.490569-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bvc8Kd9fAr_hImaPf2IZnQuRR7o2fYgv0NtXuzeeoAI_1781796523
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

The dma/idxd devices are now stored in a list of generic rte_device
objects.

Fixes: b4f0974a995b ("bus: factorize device list")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/dma/idxd/idxd_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 4810d52f2a..2ec526ec09 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -34,7 +34,6 @@ struct dsa_wq_addr {
 /** a DSA device instance */
 struct rte_dsa_device {
 	struct rte_device device;           /**< Inherit core device */
-	TAILQ_ENTRY(rte_dsa_device) next;   /**< next dev in list */
 
 	char wq_name[32];                   /**< the workqueue name/number e.g. wq0.1 */
 	struct dsa_wq_addr addr;            /**< Identifies the specific WQ */
-- 
2.53.0

