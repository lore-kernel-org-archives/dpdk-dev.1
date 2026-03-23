Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92AEC01C9
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76E5140669;
	Mon, 23 Mar 2026 11:53:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2023D40664
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774263209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YapNx+BU7IKuZM2IWtEEH89SmNbwe2LkPmn9t8VhRy0=;
 b=idSuyqHJTnYIspcohVqZMt5oiQIwkwJkl8p81lty+VP2rrd8mWb81FN/dtFgt3eeKBsqcJ
 /2rjGJx/fCS9MfJkTC4XDZUXU0RududUAkXYDLHoLpzG/aTxdWbdgR8R5+YOgxu/tLPpDt
 a2H3ape4lQ994FI0nVxNNS+0gYGMWW0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-8Fs0ifmFPDOwXt9vwWMWGA-1; Mon,
 23 Mar 2026 06:53:28 -0400
X-MC-Unique: 8Fs0ifmFPDOwXt9vwWMWGA-1
X-Mimecast-MFC-AGG-ID: 8Fs0ifmFPDOwXt9vwWMWGA_1774263207
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5265F180044D; Mon, 23 Mar 2026 10:53:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0D1A1955F21; Mon, 23 Mar 2026 10:53:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 3/8] drivers/bus: require probe function for NXP drivers
Date: Mon, 23 Mar 2026 11:52:57 +0100
Message-ID: <20260323105306.1531689-4-david.marchand@redhat.com>
In-Reply-To: <20260323105306.1531689-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: coXjJ5IANZaZmGN_pffO6xOu0pSdAsBrskt3ykLLwj0_1774263207
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

