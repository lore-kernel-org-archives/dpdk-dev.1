Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DD9CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 06:58:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E261409FA;
	Tue, 30 Sep 2025 08:58:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F0545406BA
 for <dev@dpdk.org>; Tue, 30 Sep 2025 08:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759215489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3WSTLrR7KmC2xjh32XFBDeGgTLVr0xRPqVFDKzX66E=;
 b=dxxsX6JOZWMq9FFMNorjTWbrP1uIrQCaUv04UJBksYz5n/QJsRGqeS994KZoKabeqNeunV
 gwMg+Z04eV4HIfeJt7pfHK548y8dqMjDKzWS+o7/9Qo0TJ8Ugu/W6afe6zzY0cEQkVOKJ3
 mULMxyzidENb8CXec8sX4atMzpiO8Yk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-3VdROzNsOcWNvWnO_tPsVg-1; Tue,
 30 Sep 2025 02:58:07 -0400
X-MC-Unique: 3VdROzNsOcWNvWnO_tPsVg-1
X-Mimecast-MFC-AGG-ID: 3VdROzNsOcWNvWnO_tPsVg_1759215486
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8919819560B2; Tue, 30 Sep 2025 06:58:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7B891800576; Tue, 30 Sep 2025 06:58:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Elena Agostini <eagostini@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v6 4/9] gpudev: fix driver header for Windows
Date: Tue, 30 Sep 2025 08:57:34 +0200
Message-ID: <20250930065740.1838899-5-david.marchand@redhat.com>
In-Reply-To: <20250930065740.1838899-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250930065740.1838899-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6sjMiHyz59L5eioxgyldVVoq7-7YUyzRgG7By8yhrRo_1759215486
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

Use rte_os.h and its RTE_TAILQ_HEAD definition compatible with BSD
sys/queue.h

Fixes: 18cb07563165 ("gpudev: add event notification")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/gpudev/gpudev.c        | 1 +
 lib/gpudev/gpudev_driver.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
index 0473d9ffb3..4a2335834c 100644
--- a/lib/gpudev/gpudev.c
+++ b/lib/gpudev/gpudev.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdlib.h>
+#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_eal.h>
diff --git a/lib/gpudev/gpudev_driver.h b/lib/gpudev/gpudev_driver.h
index 37b6ae3149..b7621f6e5a 100644
--- a/lib/gpudev/gpudev_driver.h
+++ b/lib/gpudev/gpudev_driver.h
@@ -12,11 +12,11 @@
 #define RTE_GPUDEV_DRIVER_H
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <dev_driver.h>
 
 #include <rte_compat.h>
+#include <rte_os.h>
 #include "rte_gpudev.h"
 
 #ifdef __cplusplus
@@ -80,7 +80,7 @@ struct __rte_cache_aligned rte_gpu {
 	/* Driver functions. */
 	struct rte_gpu_ops ops;
 	/* Event callback list. */
-	TAILQ_HEAD(rte_gpu_callback_list, rte_gpu_callback) callbacks;
+	RTE_TAILQ_HEAD(rte_gpu_callback_list, rte_gpu_callback) callbacks;
 	/* Current state (used or not) in the running process. */
 	enum rte_gpu_state process_state; /* Updated by this library. */
 	/* Driver-specific private data for the running process. */
-- 
2.51.0

