Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1953EC531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19420406BA;
	Thu, 23 Jul 2026 14:56:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DA35F40698
 for <dev@dpdk.org>; Thu, 23 Jul 2026 14:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784811412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GBDMM/44lfy2dC2JZcUBWilBj6nn28z+0caY/Mij90=;
 b=R+b4yChwaGXMJp3kG4ZidSRclr4N3pMbuMeIZCkKAlwZd/MfqVm9xj6MEk6v+AzuJN4Dgl
 2kKxnVfX2rPl3BAEbgL1R/zbow1ukJbBR8LGXKVthJOrtnVyKt0SHkrgiuxVFbPzjLer5u
 RrE6F1JlgOqaxgADBvzA2/SAaiV7gP4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-HmCuze_gOeKy11FLdusgxQ-1; Thu,
 23 Jul 2026 08:56:49 -0400
X-MC-Unique: HmCuze_gOeKy11FLdusgxQ-1
X-Mimecast-MFC-AGG-ID: HmCuze_gOeKy11FLdusgxQ_1784811408
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 620E919775D9; Thu, 23 Jul 2026 12:56:48 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 261401956053; Thu, 23 Jul 2026 12:56:46 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH v2 9/9] ci: run reference binaries against current ABI
Date: Thu, 23 Jul 2026 14:55:58 +0200
Message-ID: <20260723125559.3087579-10-david.marchand@redhat.com>
In-Reply-To: <20260723125559.3087579-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XFoAAFyflEUb0RSByIHWeKyIoD9UKCejCP4yjgbZzy0_1784811408
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
experimental or internal ABI symbols that get promoted to stable.

We may need to skip unit tests that were added since the reference.
So add a ABI_SKIP_TESTS environment variable in preparation.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- dropped hack, testing this patch can't be done in the CI now,
- emptied the excluded tests list,
- added test-null.sh,

---
 .ci/linux-build.sh          | 33 ++++++++++++++++++++++++++++++---
 .github/workflows/build.yml |  1 +
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index a5e602ed83..032f3726e8 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -206,23 +206,33 @@ if [ "$ABI_CHECKS" = "true" ]; then
         # don't try to link apps.
         REF_OPTS="$REF_OPTS -Dcheck_includes=false"
         REF_OPTS="$REF_OPTS -Ddeveloper_mode=disabled"
-        REF_OPTS="$REF_OPTS -Ddisable_apps=*"
+        REF_OPTS="$REF_OPTS -Denable_apps=test,test-pmd"
         REF_OPTS="$REF_OPTS -Denable_docs=false"
         REF_OPTS="$REF_OPTS -Dexamples="
-        REF_OPTS="$REF_OPTS -Dtests=false"
         refsrcdir=$(readlink -f $(pwd)/../dpdk-$REF_GIT_TAG)
         git clone --single-branch -b "$REF_GIT_TAG" $REF_GIT_REPO $refsrcdir
         meson setup $REF_OPTS $refsrcdir $refsrcdir/build
         ninja -C $refsrcdir/build
         DESTDIR=$(pwd)/reference meson install -C $refsrcdir/build
         find reference/usr/local -name '*.a' -delete
-        rm -rf reference/usr/local/bin
+        rm -rf reference/usr/local/bin/*
+        cp $refsrcdir/build/app/dpdk-test reference/usr/local/bin/dpdk-test
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
@@ -233,6 +243,23 @@ if [ "$RUN_TESTS" = "true" ]; then
     catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
     check_traces
     [ "$failed" != "true" ]
+
+    if [ "$ABI_CHECKS" = "true" ]; then
+        failed=
+        configure_coredump
+        mv -f build/app/dpdk-test build/app/dpdk-test.ori
+        cp reference/usr/local/bin/dpdk-test build/app/dpdk-test
+        for t in ${ABI_SKIP_TESTS}; do
+            DPDK_TEST_SKIP=${DPDK_TEST_SKIP+$DPDK_TEST_SKIP,}$t
+        done
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
diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index c63a9a3982..5ee55f4d27 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -39,6 +39,7 @@ jobs:
     env:
       AARCH64: ${{ matrix.config.cross == 'aarch64' }}
       ABI_CHECKS: ${{ contains(matrix.config.checks, 'abi') }}
+      ABI_SKIP_TESTS: none
       ASAN: ${{ contains(matrix.config.checks, 'asan') }}
       BUILD_32BIT: ${{ matrix.config.cross == 'i386' }}
       BUILD_DEBUG: ${{ contains(matrix.config.checks, 'debug') }}
-- 
2.54.0

