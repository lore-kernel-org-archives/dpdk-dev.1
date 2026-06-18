Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B245CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:28:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC9C040674;
	Thu, 18 Jun 2026 17:28:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7900640268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saknGPzLFc/0kkNkhLYmS2Q6AX+ZTKEsed7HCa7KocE=;
 b=a4puSbiuCZgTcIrj0Zj3lpQOS95aJahgmkr0bKIGkfrrUqvaXCMn8Ms7UIO/uJOBt4alAj
 xsrxXZd4hGLnfl7DjVSZqM1CP3FsNS+dquYJfFmA/bR2PCd30F8KYuYoSSEYMDzO9GFcO3
 KpGNcwxQl+sC3TQ3JEDhsf1EAJJyL+U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-0l1WVXPmNw2o7D0A-8FFnA-1; Thu,
 18 Jun 2026 11:28:39 -0400
X-MC-Unique: 0l1WVXPmNw2o7D0A-8FFnA-1
X-Mimecast-MFC-AGG-ID: 0l1WVXPmNw2o7D0A-8FFnA_1781796518
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4506195394E; Thu, 18 Jun 2026 15:28:37 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.50.197])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DAF8195608D; Thu, 18 Jun 2026 15:28:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com
Subject: [PATCH v2 01/10] bus: fix reference to plug callback
Date: Thu, 18 Jun 2026 17:28:16 +0200
Message-ID: <20260618152826.490569-2-david.marchand@redhat.com>
In-Reply-To: <20260618152826.490569-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3d4QNvtfMklw0iWozadqJ23M-62yysuCR0lv_EJ_eEs_1781796518
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

Remove now unused typedef, update documentation
and some log following the callback rename.

Fixes: 76622feba9e6 ("bus: refactor device probe")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- remove missed rte_bus_plug_t typedef,


---
 doc/guides/prog_guide/device_hotplug.rst |  2 +-
 lib/eal/common/eal_common_dev.c          |  2 +-
 lib/eal/include/bus_driver.h             | 13 -------------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/doc/guides/prog_guide/device_hotplug.rst b/doc/guides/prog_guide/device_hotplug.rst
index 9896a097f3..7eb7fbcc2b 100644
--- a/doc/guides/prog_guide/device_hotplug.rst
+++ b/doc/guides/prog_guide/device_hotplug.rst
@@ -234,7 +234,7 @@ When ``rte_dev_probe()`` is called, the following sequence occurs:
    and the attach operation fails if the device is not found.
 
 #. **Device Probe**:
-   The bus's ``plug()`` method is called, which triggers the device driver's probe function.
+   The bus's ``probe_device()`` method is called, which triggers the device driver's probe function.
    The probe function typically allocates device-specific resources,
    maps device memory regions, initializes device hardware,
    and registers the device with the appropriate subsystem (e.g., ethdev for network devices).
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 48b631532a..2a2103ec57 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -193,7 +193,7 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 		goto err_devarg;
 
 	if (da->bus->probe_device == NULL) {
-		EAL_LOG(ERR, "Function plug not supported by bus (%s)",
+		EAL_LOG(ERR, "Function probe_device not supported by bus (%s)",
 			da->bus->name);
 		ret = -ENOTSUP;
 		goto err_devarg;
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 0a7e23d98d..9711e6712b 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -75,19 +75,6 @@ typedef struct rte_device *
 (*rte_bus_find_device_t)(const struct rte_bus *bus, const struct rte_device *start,
 			 rte_dev_cmp_t cmp, const void *data);
 
-/**
- * Implementation specific probe function which is responsible for linking
- * devices on that bus with applicable drivers.
- *
- * @param dev
- *	Device pointer that was returned by a previous call to find_device.
- *
- * @return
- *	0 on success.
- *	!0 on error.
- */
-typedef int (*rte_bus_plug_t)(struct rte_device *dev);
-
 /**
  * Implementation specific probe function which is responsible for linking
  * devices on that bus with applicable drivers.
-- 
2.53.0

