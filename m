Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A10CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:38:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE6574065F;
	Fri, 19 Sep 2025 10:38:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BF8B7402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758271106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRofGwOY5uN6FSwOPTlfz6l9kXEft+fL9HHBHNUyX5A=;
 b=GWDlakaq0U0LFXznfOxC02oj/Ndkcl410iQJIjn4b84Ygm6XajYwdKuGT3xaUlj0BSPNFM
 5OYMPPR+ubSEVxy1+BQf8zokLfITDSSVVo+xbFbKr/zowlP8NDxUq2JTRvuid5dqlHIDD3
 5H+rqAbBw+IaPU1RTzinVa0itK74TXA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-COx_lD4pOsOAJDEUzLl6Ig-1; Fri,
 19 Sep 2025 04:38:23 -0400
X-MC-Unique: COx_lD4pOsOAJDEUzLl6Ig-1
X-Mimecast-MFC-AGG-ID: COx_lD4pOsOAJDEUzLl6Ig_1758271102
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B07319560AB; Fri, 19 Sep 2025 08:38:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E01301800447; Fri, 19 Sep 2025 08:38:17 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 stephen@networkplumber.org, Chenbo Xia <chenbox@nvidia.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 01/10] uapi: fix include guards in VDUSE imported header
Date: Fri, 19 Sep 2025 10:37:58 +0200
Message-ID: <20250919083808.1667491-2-david.marchand@redhat.com>
In-Reply-To: <20250919083808.1667491-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250919083808.1667491-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XCGj2WtSuqoAzRo97YATnfpGrxi7vWeM99hx7aSsikw_1758271102
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

One issue with the currently imported header is that if a header
(external to DPDK) starts including the equivalent system installed uapi
header, then when DPDK code later includes its own uapi/ header,
the header guard won't match, which may result in DPDK build failure.

To address this issue, adjust the include guards in our imported uapi
header and make sure those headers are included first before any
external header.
Update the documentation accordingly.

Fixes: cf97dfd12eaf ("uapi: import Linux kernel uAPI headers")
Fixes: 67b79f6314ae ("vhost: use imported VDUSE uAPI header")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/linux-uapi.sh                 | 3 +++
 doc/guides/contributing/linux_uapi.rst | 6 ++++++
 kernel/linux/uapi/linux/vduse.h        | 6 +++---
 lib/vhost/vduse.c                      | 4 ++--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index c09c43ab6b..dbf3163bc8 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -81,6 +81,9 @@ fixup_includes()
 
 	sed -i "s|^#include <linux/compiler.h>||g" $path
 	sed -i "s|\<__user[[:space:]]||" $path
+	sed -i 's|#\(ifndef\)[[:space:]]*_UAPI|#\1 |' $path
+	sed -i 's|#\(define\)[[:space:]]*_UAPI|#\1 |' $path
+	sed -i 's|#\(endif[[:space:]]*/[*]\)[[:space:]]*_UAPI|#\1 |' $path
 
 	# Prepend include path with "uapi/" if the header is imported
 	for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
diff --git a/doc/guides/contributing/linux_uapi.rst b/doc/guides/contributing/linux_uapi.rst
index 79bedb478e..a1bc0ba604 100644
--- a/doc/guides/contributing/linux_uapi.rst
+++ b/doc/guides/contributing/linux_uapi.rst
@@ -62,9 +62,15 @@ Header inclusion into library or driver
 
 The library or driver willing to make use of imported uAPI headers needs to
 explicitly include the header file with ``uapi/`` prefix in C files.
+
+This inclusion must be done before any header external to DPDK is included,
+to prevent inclusion of this system uAPI header in any of those external headers.
+
 For example to include VDUSE uAPI:
 
 .. code-block:: c
 
    #include <uapi/linux/vduse.h>
 
+   #include <stdint.h>
+   ...
diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index 68a627d04a..f46269af34 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-#ifndef _UAPI_VDUSE_H_
-#define _UAPI_VDUSE_H_
+#ifndef _VDUSE_H_
+#define _VDUSE_H_
 
 #include <linux/types.h>
 
@@ -350,4 +350,4 @@ struct vduse_dev_response {
 	};
 };
 
-#endif /* _UAPI_VDUSE_H_ */
+#endif /* _VDUSE_H_ */
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 9de7f04a4f..2015ae9f21 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -2,13 +2,13 @@
  * Copyright (c) 2023 Red Hat, Inc.
  */
 
+#include <uapi/linux/vduse.h>
+
 #include <stdint.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <fcntl.h>
 
-
-#include <uapi/linux/vduse.h>
 #include <linux/virtio_net.h>
 
 #include <sys/ioctl.h>
-- 
2.51.0

