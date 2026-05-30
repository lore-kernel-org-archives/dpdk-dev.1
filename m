Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83392CD4F54
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 07:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEE8B402EA;
	Sat, 30 May 2026 09:52:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E5AC1400D6
 for <dev@dpdk.org>; Sat, 30 May 2026 09:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780127547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2c1FebfjLnPwI0DzSqIfsFCQp4FUrkpeGwf7D3WR/i0=;
 b=Z+PczmTFCoybP/0O+LEnsUJynpcWKx62ewPr/cMM3oao2eE+MDWyKzksNxD8l70jUSJg8G
 dk9sP6U1pE9LCfi9CyDMjzG5ZyguhnwF5lG8SQyMwzOB0cJkAGW7Y6Z5CvN5VckbrsXl9+
 wGVK5Hzcvd8Nsl/pWweJoNBQT5u5xRs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-8F8VEzZBP0S5GuYFnz6Ffg-1; Sat,
 30 May 2026 03:52:21 -0400
X-MC-Unique: 8F8VEzZBP0S5GuYFnz6Ffg-1
X-Mimecast-MFC-AGG-ID: 8F8VEzZBP0S5GuYFnz6Ffg_1780127540
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D4FD18005B9; Sat, 30 May 2026 07:52:19 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 496A430001BB; Sat, 30 May 2026 07:52:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Rosen Xu <rosen.xu@altera.com>,
 Andy Pei <andy.pei@intel.com>
Subject: [PATCH v5 01/25] bus/ifpga: remove unused AFU lookup helper
Date: Sat, 30 May 2026 09:51:31 +0200
Message-ID: <20260530075201.869606-2-david.marchand@redhat.com>
In-Reply-To: <20260530075201.869606-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260530075201.869606-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a44SjiO_SiCCJkU7Eql893iMY8O464kmZViC_cbvKZ0_1780127540
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

This helper got left behind after another cleanup.

Fixes: 8418c92811b4 ("net/ipn3ke: remove configuration for i40e port bonding")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/bus/ifpga/bus_ifpga_driver.h | 10 ----------
 drivers/bus/ifpga/ifpga_bus.c        | 13 -------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index d34ab8cec1..c0f5fb5b85 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -116,16 +116,6 @@ rte_ifpga_device_name(const struct rte_afu_device *afu)
 	return NULL;
 }
 
-/**
- * Find AFU by AFU name.
- *
- * @param name
- *   A pointer to AFU name string.
- */
-__rte_internal
-struct rte_afu_device *
-rte_ifpga_find_afu_by_name(const char *name);
-
 /**
  * Register a ifpga afu device driver.
  *
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index ca2812a960..5cc1207c46 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -74,19 +74,6 @@ ifpga_find_afu_dev(const struct rte_rawdev *rdev,
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_find_afu_by_name)
-struct rte_afu_device *
-rte_ifpga_find_afu_by_name(const char *name)
-{
-	struct rte_afu_device *afu_dev = NULL;
-
-	TAILQ_FOREACH(afu_dev, &ifpga_afu_dev_list, next) {
-		if (!strcmp(afu_dev->device.name, name))
-			return afu_dev;
-	}
-	return NULL;
-}
-
 static const char * const valid_args[] = {
 #define IFPGA_ARG_NAME         "ifpga"
 	IFPGA_ARG_NAME,
-- 
2.53.0

