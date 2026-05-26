Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE6CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 08:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 377B940654;
	Tue, 26 May 2026 10:42:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0DD2F4065D
 for <dev@dpdk.org>; Tue, 26 May 2026 10:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779784949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2c1FebfjLnPwI0DzSqIfsFCQp4FUrkpeGwf7D3WR/i0=;
 b=B3tOz56Z97LdzcB/9+KJIBG0vzL7BJ9qPnpJOFHR2TRejzv3grXWzkQIxfbjvTunvd4PEu
 JhbjpBnFkqJUz5qUX7heJefCEdxd+81Yj9ODNvsTEfSk5GZk74n/JPut5syU9P2XVvQEoA
 FIQ4TH7hcgbw7MpITqtZlDlygy+XFQ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-XeQFas4qMi2qxpqbq1wgqQ-1; Tue,
 26 May 2026 04:42:23 -0400
X-MC-Unique: XeQFas4qMi2qxpqbq1wgqQ-1
X-Mimecast-MFC-AGG-ID: XeQFas4qMi2qxpqbq1wgqQ_1779784942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DF6A19560B7; Tue, 26 May 2026 08:42:22 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D587300019F; Tue, 26 May 2026 08:42:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Rosen Xu <rosen.xu@altera.com>,
 Andy Pei <andy.pei@intel.com>
Subject: [PATCH v3 01/25] bus/ifpga: remove unused AFU lookup helper
Date: Tue, 26 May 2026 10:41:41 +0200
Message-ID: <20260526084212.3145685-2-david.marchand@redhat.com>
In-Reply-To: <20260526084212.3145685-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g4TWS9LQnmCb4ZSyAdooyKttPUu9baHZLD0CRG6gNpY_1779784942
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

