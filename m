Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2F0CA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:14:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A51B540E2B;
	Wed,  3 Sep 2025 17:14:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A305940E1D
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756912439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzOuMGWUokeY2lMVT+QfPg0ix9muuj5cala4/bKuc9Q=;
 b=Jxm38RtngCkQs/KP1RdATh2Pekl1+hBpYDbM2c74zCnLjaG+HibEpk9epnb+sDDExwQM5b
 rTqbmYLafUUMQGr3gsXrObDm70DEcNOZ2JSgLHjSw4nVgzCpHerjdaiZ5VVU8mqMfCW72+
 F6HxCKogegAv7VQbHumlH3pS/w6xfxE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-C4rX7935MPGV4EERwLvEDQ-1; Wed,
 03 Sep 2025 11:13:55 -0400
X-MC-Unique: C4rX7935MPGV4EERwLvEDQ-1
X-Mimecast-MFC-AGG-ID: C4rX7935MPGV4EERwLvEDQ_1756912434
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 634261800343; Wed,  3 Sep 2025 15:13:54 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8BB319560AB; Wed,  3 Sep 2025 15:13:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC v2 3/9] vfio: assume VFIO is always and only present on Linux
Date: Wed,  3 Sep 2025 17:13:20 +0200
Message-ID: <20250903151327.1964490-4-david.marchand@redhat.com>
In-Reply-To: <20250903151327.1964490-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151327.1964490-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B7dy67kK2dvWxyMN_wh6oTgMODeqUvETZKcPnevdJ40_1756912434
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

RTE_EAL_VFIO is directly mapped to is_linux in meson.
Replace this intermediate build knob with RTE_EXEC_ENV_LINUX.
This is an intermediate state before importing the VFIO uapi header.

Note: crypto/bcmfs was functional only for OSes supporting VFIO iow
Linux. Stop compiling it on other OSes.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 config/meson.build                |  3 ---
 drivers/crypto/bcmfs/bcmfs_vfio.c | 18 ++----------------
 drivers/crypto/bcmfs/meson.build  |  4 ++--
 lib/eal/include/rte_vfio.h        |  6 +++---
 4 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/config/meson.build b/config/meson.build
index 55497f0bf5..b5e894de3c 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -459,9 +459,6 @@ dpdk_conf.set_quoted('RTE_EAL_PMD_PATH', eal_pmd_path)
 install_headers(['rte_config.h'],
         subdir: get_option('include_subdir_arch'))
 
-# enable VFIO only if it is linux OS
-dpdk_conf.set('RTE_EAL_VFIO', is_linux)
-
 # specify -D_GNU_SOURCE unconditionally
 add_project_arguments('-D_GNU_SOURCE', language: 'c')
 
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index 8d6ea16544..9138f96eb0 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -7,14 +7,12 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
+#include <rte_vfio.h>
+
 #include "bcmfs_device.h"
 #include "bcmfs_logs.h"
 #include "bcmfs_vfio.h"
 
-#ifdef RTE_EAL_VFIO
-
-#include <rte_vfio.h>
-
 static int
 vfio_map_dev_obj(const char *path, const char *dev_obj,
 		 uint32_t *size, void **addr, int *dev_fd)
@@ -94,15 +92,3 @@ bcmfs_release_vfio(struct bcmfs_device *dev)
 		return;
 	}
 }
-#else /* ! RTE_EAL_VFIO */
-int
-bcmfs_attach_vfio(struct bcmfs_device *dev __rte_unused)
-{
-	return -1;
-}
-
-void
-bcmfs_release_vfio(struct bcmfs_device *dev __rte_unused)
-{
-}
-#endif /* RTE_EAL_VFIO */
diff --git a/drivers/crypto/bcmfs/meson.build b/drivers/crypto/bcmfs/meson.build
index 5842f83a3b..925dde2ee2 100644
--- a/drivers/crypto/bcmfs/meson.build
+++ b/drivers/crypto/bcmfs/meson.build
@@ -3,9 +3,9 @@
 # All rights reserved.
 #
 
-if is_windows
+if not is_linux
     build = false
-    reason = 'not supported on Windows'
+    reason = 'only supported on Linux'
     subdir_done()
 endif
 
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 594d504c56..035b727dd0 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -19,7 +19,7 @@
 extern "C" {
 #endif
 
-#ifdef RTE_EAL_VFIO
+#ifdef RTE_EXEC_ENV_LINUX
 
 #include <linux/version.h>
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 0, 0)
@@ -94,12 +94,12 @@ struct vfio_device_feature_bus_master {
 };
 #endif
 
-#else /* ! RTE_EAL_VFIO */
+#else /* ! RTE_EXEC_ENV_LINUX */
 
 /* we don't need an actual definition, only pointer is used */
 struct vfio_device_info;
 
-#endif /* RTE_EAL_VFIO */
+#endif /* RTE_EXEC_ENV_LINUX */
 
 #define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
 
-- 
2.51.0

