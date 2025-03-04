Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7669AC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:06:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1834402E2;
	Tue,  4 Mar 2025 17:06:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9296640287
 for <dev@dpdk.org>; Tue,  4 Mar 2025 17:06:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741104416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMTMlum3z9mpVnlIN8Zz/FAY6E1HawJEGGBd80yotpc=;
 b=gsl3Ft6Ub3BeiWQ80QbmHGLq4wm3x3uEpmN2dOIrENdoUPtfHnkhT+l//Jh7tuQ4gEDONq
 +Ku3SY3A4h4zS2whzLPZ6Plhmzulm0/LT3ARKMLVcf2301MtJEPexgogCAW0Q+bKeJnTkV
 MwX6KH3oOMTiKtmZBnG0I4FOTKcAtwE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-ZhIGXUVnOGKzj6U6kr4xmw-1; Tue,
 04 Mar 2025 11:06:44 -0500
X-MC-Unique: ZhIGXUVnOGKzj6U6kr4xmw-1
X-Mimecast-MFC-AGG-ID: ZhIGXUVnOGKzj6U6kr4xmw_1741104404
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC50A190ECC7; Tue,  4 Mar 2025 16:06:43 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 753E519560AB; Tue,  4 Mar 2025 16:06:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: [PATCH v4 1/5] ci: check traces validity
Date: Tue,  4 Mar 2025 17:06:29 +0100
Message-ID: <20250304160633.385185-2-david.marchand@redhat.com>
In-Reply-To: <20250304160633.385185-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250304160633.385185-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZmOhoH7GS_zXgyePyuMl62ou09I5bq-PkgO3dW30zqI_1741104404
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

We currently do not validate if generated traces can be parsed by a
tracing tool.
Add some check.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- added this check, as v2 was breaking CTF metadata content,

---
 .ci/linux-build.sh          | 10 ++++++++++
 .github/workflows/build.yml |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index fdb5787621..e9272d3931 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -44,6 +44,14 @@ catch_coredump() {
     return 1
 }
 
+check_traces() {
+    which babeltrace >/dev/null || return 0
+    for file in $(sudo find $HOME -name metadata); do
+        ! sudo babeltrace $(dirname $file) >/dev/null 2>&1 || continue
+        sudo babeltrace $(dirname $file)
+    done
+}
+
 cross_file=
 
 if [ "$AARCH64" = "true" ]; then
@@ -133,6 +141,7 @@ if [ -z "$cross_file" ]; then
     configure_coredump
     devtools/test-null.sh || failed="true"
     catch_coredump
+    check_traces
     [ "$failed" != "true" ]
 fi
 
@@ -173,6 +182,7 @@ if [ "$RUN_TESTS" = "true" ]; then
     configure_coredump
     sudo meson test -C build --suite fast-tests -t 3 || failed="true"
     catch_coredump
+    check_traces
     [ "$failed" != "true" ]
 fi
 
diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index aef692ca1f..183b0b1999 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -151,7 +151,7 @@ jobs:
       run: sudo apt install -y crossbuild-essential-riscv64
     - name: Install test tools packages
       if: env.AARCH64 != 'true' || env.PPC64LE != 'true' || env.RISCV64 != 'true' || env.RUN_TESTS == 'true'
-      run: sudo apt install -y gdb jq
+      run: sudo apt install -y babeltrace gdb jq
     - name: Install doc generation packages
       if: env.BUILD_DOCS == 'true'
       run: sudo apt install -y doxygen graphviz man-db python3-sphinx
-- 
2.48.1

