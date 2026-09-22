Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A2C982F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:41:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8F2B41133;
	Tue, 22 Sep 2026 11:41:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 83DF44275A
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790070067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8In0Me12bbXw8tQt5fVD7dKSHW5tFgjgfpe5edo7YU=;
 b=RGwIvOzkD2J4O5vZoD+l2Y/tFJwi+SveVGq4IpeqdAeDKuBK5H5eZn61vQvXyHGCbBcKEf
 rGorENGnSBmWmOrPkqD3eNW96gZmT2v28TBwVj3cmzVTWqr1gGFCUAF6IzwXfrtTIag9SQ
 GGs4yTGXdaKvmTyFaTpDHplf4OuBS0I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-DRVnLtjAOVOj_DRwZsmpbQ-1; Tue,
 22 Sep 2026 05:41:04 -0400
X-MC-Unique: DRVnLtjAOVOj_DRwZsmpbQ-1
X-Mimecast-MFC-AGG-ID: DRVnLtjAOVOj_DRwZsmpbQ_1790070064
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBAB01802165; Tue, 22 Sep 2026 09:41:03 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E21AA3000223; Tue, 22 Sep 2026 09:41:02 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH v4 9/9] ci: run reference binaries against current ABI
Date: Tue, 22 Sep 2026 11:40:25 +0200
Message-ID: <20260922094026.2636265-10-david.marchand@redhat.com>
In-Reply-To: <20260922094026.2636265-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260922094026.2636265-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jc7NV4mm25MqtfKSu4pfAM4kkteNg9noBf4QR-Ja3-c_1790070064
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

Let's check if a testpmd and unit tests from a reference build can run
with the current release libraries/drivers.

This gives another level of ABI checking, like catching regressions on
experimental or internal ABI symbols that get promoted to stable without
providing an alias for existing users.

Automatically skip unit tests that did not exist in the reference build.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v3:
- fixed support of newer meson version,
- updated commitlog,

Changes since v2:
- automated generation of the tests list,

Changes since v1:
- dropped hack, testing this patch can't be done in the CI now,
- emptied the excluded tests list,
- added test-null.sh,

---

 .ci/linux-build.sh | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index c789111a79..0dea7b6b26 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -206,7 +206,7 @@ if [ "$ABI_CHECKS" = "true" ]; then
         # don't try to link apps.
         REF_OPTS="$REF_OPTS -Dcheck_includes=false"
         REF_OPTS="$REF_OPTS -Ddeveloper_mode=disabled"
-        REF_OPTS="$REF_OPTS -Ddisable_apps=*"
+        REF_OPTS="$REF_OPTS -Denable_apps=test,test-pmd"
         REF_OPTS="$REF_OPTS -Denable_docs=false"
         REF_OPTS="$REF_OPTS -Dexamples="
         refsrcdir=$(readlink -f $(pwd)/../dpdk-$REF_GIT_TAG)
@@ -215,13 +215,27 @@ if [ "$ABI_CHECKS" = "true" ]; then
         ninja -C $refsrcdir/build
         DESTDIR=$(pwd)/reference meson install -C $refsrcdir/build
         find reference/usr/local -name '*.a' -delete
-        rm -rf reference/usr/local/bin
+        rm -rf reference/usr/local/bin/*
+        cp $refsrcdir/build/app/dpdk-test reference/usr/local/bin/dpdk-test
+        meson introspect $refsrcdir/build --tests |
+            jq -r '.[] | select(.suite[] | contains("fast-tests")) | .name' |
+            sort > reference/tests.txt
+        cp $refsrcdir/build/app/dpdk-testpmd reference/usr/local/bin/dpdk-testpmd
         rm -rf reference/usr/local/share
         echo $REF_GIT_TAG > reference/VERSION
     fi
 
     DESTDIR=$(pwd)/install meson install -C build
     devtools/check-abi.sh reference install ${ABI_CHECKS_WARN_ONLY:-}
+
+    failed=
+    configure_coredump
+    mv -f build/app/dpdk-testpmd build/app/dpdk-testpmd.ori
+    cp reference/usr/local/bin/dpdk-testpmd build/app/dpdk-testpmd
+    devtools/test-null.sh || failed="true"
+    mv -f build/app/dpdk-testpmd.ori build/app/dpdk-testpmd
+    catch_coredump
+    [ "$failed" != "true" ]
 fi
 
 if [ "$RUN_TESTS" = "true" ]; then
@@ -232,6 +246,24 @@ if [ "$RUN_TESTS" = "true" ]; then
     catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
     check_traces
     [ "$failed" != "true" ]
+
+    if [ "$ABI_CHECKS" = "true" ]; then
+        failed=
+        configure_coredump
+        mv -f build/app/dpdk-test build/app/dpdk-test.ori
+        cp reference/usr/local/bin/dpdk-test build/app/dpdk-test
+        meson introspect build --tests |
+            jq -r '.[] | select(.suite[] | contains("fast-tests")) | .name' |
+            sort > build/tests.txt
+        DPDK_TEST_SKIP=$(grep -vxFf reference/tests.txt build/tests.txt | tr '\n' ',')
+        sudo env DPDK_TEST_SKIP="$DPDK_TEST_SKIP" \
+            meson test -C build --suite fast-tests -t 3 --no-stdsplit --print-errorlogs || failed="true"
+        catch_coredump
+        catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
+        check_traces
+        mv -f build/app/dpdk-test.ori build/app/dpdk-test
+        [ "$failed" != "true" ]
+    fi
 fi
 
 # Test examples compilation with an installed dpdk
-- 
2.54.0

