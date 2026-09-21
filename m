Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E266EC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 11:48:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CE9642D76;
	Mon, 21 Sep 2026 13:48:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A70E8427E7
 for <dev@dpdk.org>; Mon, 21 Sep 2026 13:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789991296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1a1UnOF7hwytM8orrv516NcOaTJ/cGisIdLpPl1Y94=;
 b=RSQLVj7DK8zbq+sdRjxh6mwNYFzUsRZJ6+QKa6ekTPkXTMXE9OqCln/GOqKb7uYEjZ2nzw
 3gyu5fnmy1makSb0HtwZd+UzM3YxxZopTP9M+VCRcxXHuaW3DKFuE+KuFYe6oVMPEedQ5B
 uQZYZy870IMccLD9zEL4Dpguqf3QfRA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-8DtqZjdyNAuGe9jtm-gW1w-1; Mon,
 21 Sep 2026 07:48:13 -0400
X-MC-Unique: 8DtqZjdyNAuGe9jtm-gW1w-1
X-Mimecast-MFC-AGG-ID: 8DtqZjdyNAuGe9jtm-gW1w_1789991291
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FA411954234; Mon, 21 Sep 2026 11:48:11 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB2AB1800577; Mon, 21 Sep 2026 11:48:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 7/9] test: limit internal API usage
Date: Mon, 21 Sep 2026 13:47:34 +0200
Message-ID: <20260921114737.2334589-8-david.marchand@redhat.com>
In-Reply-To: <20260921114737.2334589-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260921114737.2334589-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qbodk1wy5CwRwggoh5Vc-q5WKcr9Nc69MVPvNXosLi8_1789991291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Internal APIs may be used for validating the internals of some
component, but in general, it should be discouraged.

Let's not allow globally internal API in the unit tests.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test/meson.build         | 3 ---
 app/test/process.c           | 2 ++
 app/test/test_devargs.c      | 2 ++
 app/test/test_external_mem.c | 2 ++
 app/test/test_malloc.c       | 2 ++
 app/test/test_mempool.c      | 2 ++
 app/test/test_pdump.c        | 3 +++
 app/test/virtual_pmd.c       | 2 ++
 8 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index d8efa93050..e3dfa1d24c 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -286,9 +286,6 @@ foreach arg: extra_flags
     endif
 endforeach
 
-# Enable using internal APIs in unit tests
-cflags += '-DALLOW_INTERNAL_API'
-
 # create a symlink in the app/test directory for the binary, for backward compatibility
 if not is_windows
     custom_target('test_symlink',
diff --git a/app/test/process.c b/app/test/process.c
index 2b6d7ae84b..92c8af702b 100644
--- a/app/test/process.c
+++ b/app/test/process.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#define ALLOW_INTERNAL_API
+
 #include <errno.h>  /* errno */
 #include <limits.h> /* PATH_MAX */
 #ifndef RTE_EXEC_ENV_WINDOWS
diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 0300a2c753..571f57500c 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -2,6 +2,8 @@
  * Copyright (c) 2021 NVIDIA Corporation & Affiliates
  */
 
+#define ALLOW_INTERNAL_API
+
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
index 53300983ed..2c8d0d8e00 100644
--- a/app/test/test_external_mem.c
+++ b/app/test/test_external_mem.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#define ALLOW_INTERNAL_API
+
 #include "test.h"
 
 #include <errno.h>
diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index da868c8091..151d1a3f2c 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2010-2019 Intel Corporation
  */
 
+#define ALLOW_INTERNAL_API
+
 #include "test.h"
 
 #include <stdio.h>
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index e54249ce61..f1e8adeef9 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#define ALLOW_INTERNAL_API
+
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index 64f1bbf21c..f1c9bd9d7e 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2018 Intel Corporation
  */
+
+#define ALLOW_INTERNAL_API
+
 #include <stdio.h>
 #include <unistd.h>
 #include <stdint.h>
diff --git a/app/test/virtual_pmd.c b/app/test/virtual_pmd.c
index aa37e4073c..74bb3516ab 100644
--- a/app/test/virtual_pmd.c
+++ b/app/test/virtual_pmd.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#define ALLOW_INTERNAL_API
+
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <ethdev_driver.h>
-- 
2.54.0

