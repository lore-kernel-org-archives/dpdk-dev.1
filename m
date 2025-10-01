Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82473CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 06:45:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBC5340693;
	Wed,  1 Oct 2025 08:45:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1337E40671
 for <dev@dpdk.org>; Wed,  1 Oct 2025 08:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759301152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3WSTLrR7KmC2xjh32XFBDeGgTLVr0xRPqVFDKzX66E=;
 b=Civwp7ypMsPBlFpiB6muUkI7vF83Yh0fhGXyLcJccXoMOM/wXvqIoj+m8ZCtBKz4ZdKSRq
 w24E5aXjoTnKXUKxqzoKWxIJ6w6Q4V4zXu2+M7eRATjnsGff1xc8MO8s7+9Cp5tFhAV4Ku
 oh6pyiKSmxLXPjAC/edPtIujPdM6aog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-HKLbG0VoP3iEZcGTvWe-KQ-1; Wed,
 01 Oct 2025 02:45:47 -0400
X-MC-Unique: HKLbG0VoP3iEZcGTvWe-KQ-1
X-Mimecast-MFC-AGG-ID: HKLbG0VoP3iEZcGTvWe-KQ_1759301146
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CEFF180057F; Wed,  1 Oct 2025 06:45:46 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44AA719560B8; Wed,  1 Oct 2025 06:45:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Elena Agostini <eagostini@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v7 4/9] gpudev: fix driver header for Windows
Date: Wed,  1 Oct 2025 08:45:06 +0200
Message-ID: <20251001064512.2539269-5-david.marchand@redhat.com>
In-Reply-To: <20251001064512.2539269-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20251001064512.2539269-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qTAT96WsfN7Yr5shK1Ooh_1_O4rNWri7z-mbdjVKKK8_1759301146
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

