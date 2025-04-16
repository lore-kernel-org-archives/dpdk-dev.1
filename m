Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DE6C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 12:34:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B159E40E18;
	Wed, 16 Apr 2025 14:34:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3866540DFD
 for <dev@dpdk.org>; Wed, 16 Apr 2025 14:34:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744806879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHyVInfaViuYid9pQrScCOTcSbFqBwfeN0kiObHvB7M=;
 b=aVuLFofejde/DX/yTzv15Z4QXfZO7Q5/30yRN6KM8vYgVrZDmCCC1myesbw4yexmKqn0F4
 eDW1nGUZHhKkwmnJx6WmGab2/8wcaRhdGuxcKO8WeDHoqcxmHXc7ohLcmRSjnhtHu9wFlJ
 cI/JCCt68O6h8IxYJqVH8+n1N4I9aYk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-X0WH011OPj69ZOGyiif8Qw-1; Wed,
 16 Apr 2025 08:34:36 -0400
X-MC-Unique: X0WH011OPj69ZOGyiif8Qw-1
X-Mimecast-MFC-AGG-ID: X0WH011OPj69ZOGyiif8Qw_1744806875
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E21CE1956086; Wed, 16 Apr 2025 12:34:34 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.44.22.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 829CF180045C; Wed, 16 Apr 2025 12:34:32 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	thomas@monjalon.net
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH 1/4] license: add exception for Linux Kernel uAPI headers
Date: Wed, 16 Apr 2025 14:34:23 +0200
Message-ID: <20250416123426.2638250-2-maxime.coquelin@redhat.com>
In-Reply-To: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
References: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nL3da6usmeYoprUatcguI5YX1i9o2nosMKiu88yuOQc_1744806875
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

As approved by both Technical and Governing boards, Linux
Kernel uAPI header files can now be imported into the
kernel/linux/uapi directory.

This patch also fix the SPDX tags checker script to take
into account dual-licensed files.

The process to import such headers is documented in
doc/guides/contributing/linux_uapi.rst

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 devtools/check-spdx-tag.sh |  2 +-
 license/Linux-syscall-note | 25 +++++++++++++++++++++++++
 license/exceptions.txt     | 17 +++++++++--------
 3 files changed, 35 insertions(+), 9 deletions(-)
 create mode 100644 license/Linux-syscall-note

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 1fd0d579d3..984825026e 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -48,7 +48,7 @@ check_licenses() {
     fi
     exceptions=$(build_exceptions_list)
     git grep -l SPDX-License-Identifier: -- $no_license_list $exceptions |
-    xargs grep -L -E 'SPDX-License-Identifier:[[:space:]]*\(?BSD-3-Clause' > $tmpfile
+    xargs grep -L -E 'SPDX-License-Identifier:[[:space:]]*(\(?|.* OR )BSD-3-Clause' > $tmpfile
 
     wrong_license=$(wc -l < $tmpfile)
     $quiet || cat $tmpfile
diff --git a/license/Linux-syscall-note b/license/Linux-syscall-note
new file mode 100644
index 0000000000..9abdad71fa
--- /dev/null
+++ b/license/Linux-syscall-note
@@ -0,0 +1,25 @@
+SPDX-Exception-Identifier: Linux-syscall-note
+SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
+SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
+Usage-Guide:
+  This exception is used together with one of the above SPDX-Licenses
+  to mark user space API (uapi) header files so they can be included
+  into non GPL compliant user space application code.
+  To use this exception add it with the keyword WITH to one of the
+  identifiers in the SPDX-Licenses tag:
+    SPDX-License-Identifier: <SPDX-License> WITH Linux-syscall-note
+License-Text:
+
+   NOTE! This copyright does *not* cover user programs that use kernel
+ services by normal system calls - this is merely considered normal use
+ of the kernel, and does *not* fall under the heading of "derived work".
+ Also note that the GPL below is copyrighted by the Free Software
+ Foundation, but the instance of code that it refers to (the Linux
+ kernel) is copyrighted by me and others who actually wrote it.
+
+ Also note that the only valid version of the GPL as far as the kernel
+ is concerned is _this_ particular version of the license (ie v2, not
+ v2.2 or v3.x or whatever), unless explicitly otherwise stated.
+
+			Linus Torvalds
+
diff --git a/license/exceptions.txt b/license/exceptions.txt
index d12fac2034..cf2034747d 100644
--- a/license/exceptions.txt
+++ b/license/exceptions.txt
@@ -9,11 +9,12 @@ Note that following licenses are not exceptions:-
 	- BSD-3-Clause OR LGPL-2.1
 	- GPL-2.0  (*Only for kernel code*)
 
----------------------------------------------------------------------------------------------------
-SPDX Identifier      | TB Approval Date | GB Approval Date | File name
----------------------------------------------------------------------------------------------------
-MIT                  | 10/23/2019       | 02/10/2020       | lib/eal/windows/include/dirent.h
-BSD-2-Clause         | 10/23/2019       | 12/18/2019       | lib/eal/windows/include/getopt.h
-ISC AND BSD-2-Clause | 10/23/2019       | 12/18/2019       | lib/eal/windows/getopt.c
-MIT                  | 10/19/2022       | 10/18/2022       | drivers/net/gve/base/*
----------------------------------------------------------------------------------------------------
+---------------------------------------------------------------------------------------------------------
+SPDX Identifier                 | TB Approval Date | GB Approval Date | File name
+---------------------------------------------------------------------------------------------------------
+MIT                             | 10/23/2019       | 02/10/2020       | lib/eal/windows/include/dirent.h
+BSD-2-Clause                    | 10/23/2019       | 12/18/2019       | lib/eal/windows/include/getopt.h
+ISC AND BSD-2-Clause            | 10/23/2019       | 12/18/2019       | lib/eal/windows/getopt.c
+MIT                             | 10/19/2022       | 10/18/2022       | drivers/net/gve/base/*
+GPL-2.0 WITH Linux-syscall-note | 12/11/2024       | 04/14/2025       | kernel/linux/uapi/linux/*
+---------------------------------------------------------------------------------------------------------
-- 
2.49.0

