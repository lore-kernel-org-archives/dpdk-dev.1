Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A25CFD8FCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF9E40647;
	Thu, 26 Feb 2026 17:21:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7282D40647
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772122882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fH9atKH5V5XOVAiIQbQGhyNUIr1FyjAKVB80065R7Oc=;
 b=RYwSBu5XJ77AcDq5g0ffoInF8oO3nMMSgmyq7IjjsuDTb9ObVpyE4ZrdbJ604Zrd/6u7tZ
 P0bJZ915drINSxVy14xnLcm8LeI6bZtqJ7mkU/E2uUWkR+CSy4xlejXhg/nfTiZf406tnW
 6uFChETFFhGdBSseE1P3Efbph+eWWr0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-kzaq3Kc9M9Oz6a3h0VvE_A-1; Thu,
 26 Feb 2026 11:21:18 -0500
X-MC-Unique: kzaq3Kc9M9Oz6a3h0VvE_A-1
X-Mimecast-MFC-AGG-ID: kzaq3Kc9M9Oz6a3h0VvE_A_1772122877
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E0BF1800473; Thu, 26 Feb 2026 16:21:17 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E86201800673; Thu, 26 Feb 2026 16:21:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 3/5] drivers/bus: require probe function for NXP drivers
Date: Thu, 26 Feb 2026 17:20:54 +0100
Message-ID: <20260226162057.207202-4-david.marchand@redhat.com>
In-Reply-To: <20260226162057.207202-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJby6jhUqGsCJK1MYmx-5Kx_kuq31Vxr49BKVNazkzQ_1772122877
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

Rather than silently ignore an invalid driver, enforce every registered
driver has a probe callback.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/dpaa_bus.c   | 6 +++---
 drivers/bus/fslmc/fslmc_bus.c | 7 +------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index d9830b68ca..5e0f32bfe8 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -614,6 +614,7 @@ void
 rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
 {
 	RTE_VERIFY(driver);
+	RTE_VERIFY(driver->probe != NULL);
 
 	BUS_INIT_FUNC_TRACE();
 
@@ -808,9 +809,8 @@ rte_dpaa_bus_probe(void)
 			if (rte_dev_is_probed(&dev->device))
 				continue;
 
-			if (!drv->probe ||
-			    (dev->device.devargs &&
-			     dev->device.devargs->policy == RTE_DEV_BLOCKED))
+			if (dev->device.devargs &&
+			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
 				continue;
 
 			if (probe_all ||
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index abdb0ad50d..ac9fb7a08c 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -465,9 +465,6 @@ rte_fslmc_probe(void)
 			if (ret)
 				continue;
 
-			if (!drv->probe)
-				continue;
-
 			if (rte_dev_is_probed(&dev->device))
 				continue;
 
@@ -534,6 +531,7 @@ void
 rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
 {
 	RTE_VERIFY(driver);
+	RTE_VERIFY(driver->probe != NULL);
 
 	TAILQ_INSERT_TAIL(&rte_fslmc_bus.driver_list, driver, next);
 }
@@ -601,9 +599,6 @@ fslmc_bus_plug(struct rte_device *rte_dev)
 		if (ret)
 			continue;
 
-		if (!drv->probe)
-			continue;
-
 		if (rte_dev_is_probed(&dev->device))
 			continue;
 
-- 
2.53.0

