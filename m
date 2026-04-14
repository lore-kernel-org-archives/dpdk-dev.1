Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC5F9D0CC
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 12:39:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4A5340649;
	Tue, 14 Apr 2026 14:39:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9FF7F40651
 for <dev@dpdk.org>; Tue, 14 Apr 2026 14:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776170364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qyjGKiKVw10S5YJ1nKfCWEU8Y2jIVNx+aH6rcTXqUUI=;
 b=fNx0T/JRWYl/P8nkKHrqKXO2EhVGdP8jVHtXv0sELX7RBopIGu4W8W2O3pbR2umWNIzX/p
 rlDEv0uA1ZEOtS/2ugYBHSFP2r4UBq2aPVoHz88Bz/wUlv9aaoKtwPEjDqZqSjBH9ad7YN
 flAVQQQ8Rfis4ScUXSg2XzZw//28CeI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-mKXZouiCMiaLdq81MkttXg-1; Tue,
 14 Apr 2026 08:39:24 -0400
X-MC-Unique: mKXZouiCMiaLdq81MkttXg-1
X-Mimecast-MFC-AGG-ID: mKXZouiCMiaLdq81MkttXg_1776170362
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3C4C19560A6; Tue, 14 Apr 2026 12:39:22 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.184])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EF5E180049F; Tue, 14 Apr 2026 12:39:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Traynor <ktraynor@redhat.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 3/7] drivers/bus: require probe function for NXP drivers
Date: Tue, 14 Apr 2026 14:38:55 +0200
Message-ID: <20260414123900.3355883-4-david.marchand@redhat.com>
In-Reply-To: <20260414123900.3355883-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260414123900.3355883-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oRRibNkPmzSdwmWXetIs7j8hWRL7xzT0_AiLb12dSas_1776170362
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
Acked-by: Kevin Traynor <ktraynor@redhat.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
index d058441a3f..20b08639b7 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -469,9 +469,6 @@ rte_fslmc_probe(void)
 			if (ret)
 				continue;
 
-			if (!drv->probe)
-				continue;
-
 			if (rte_dev_is_probed(&dev->device))
 				continue;
 
@@ -538,6 +535,7 @@ void
 rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
 {
 	RTE_VERIFY(driver);
+	RTE_VERIFY(driver->probe != NULL);
 
 	TAILQ_INSERT_TAIL(&rte_fslmc_bus.driver_list, driver, next);
 }
@@ -605,9 +603,6 @@ fslmc_bus_plug(struct rte_device *rte_dev)
 		if (ret)
 			continue;
 
-		if (!drv->probe)
-			continue;
-
 		if (rte_dev_is_probed(&dev->device))
 			continue;
 
-- 
2.53.0

