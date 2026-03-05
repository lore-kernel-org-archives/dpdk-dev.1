Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F36F3D331
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D6084029D;
	Thu,  5 Mar 2026 17:46:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F1E38410D2
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:46:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772729189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YapNx+BU7IKuZM2IWtEEH89SmNbwe2LkPmn9t8VhRy0=;
 b=UZFdegQEcERlJK2ZfN0IWGtgTXbxQrNzy+8eLiGEmNSUpxQ/gHULnCmfpVAU0f0Ay1BhN4
 ERaOItV/7+ZL+EEQXPcYmoJfx+BKhilHUSsQKgl1Gxhbo3R3i+K4qsYYQ8cBkgyqLFAduL
 2uBUKQtFkAKFgg/KY5+3yKxl3NF/8G8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-icv7a9fNMbSyWptZs5MSjg-1; Thu,
 05 Mar 2026 11:46:26 -0500
X-MC-Unique: icv7a9fNMbSyWptZs5MSjg-1
X-Mimecast-MFC-AGG-ID: icv7a9fNMbSyWptZs5MSjg_1772729185
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B0EB184A40A; Thu,  5 Mar 2026 16:46:15 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4B7C1800756; Thu,  5 Mar 2026 16:46:13 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v3 3/7] drivers/bus: require probe function for NXP drivers
Date: Thu,  5 Mar 2026 17:45:45 +0100
Message-ID: <20260305164550.2067453-4-david.marchand@redhat.com>
In-Reply-To: <20260305164550.2067453-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: as9JImoqUJSfwnSZc5TY2pRelCj058JpzyrxPMNFDbw_1772729185
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

