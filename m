Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBA4C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A528D40E48;
	Fri, 17 Jul 2026 11:30:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2469C40E0A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784280656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcCA9+gH2/ssiYg//3Hk/XdEWartjXP1T0VSy5Ob2jc=;
 b=iIb0A6bfVqt0vQE2du8OEIwD5gPTGI6UK/QxSEKOEX4k6Ly66t6DQsV2t1x1pMWT/Ydz7l
 TWHFlw9a4Cast8dTlt88Lz2GfdRadWh4wi6J6l0lwznKZKURRbR9jTDayCooJ0sFX8SVVC
 c/pDyCwRwFqP02ruNEC53MGipePmnIg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-tDikm5GbMzu7gzVrgW5AJg-1; Fri,
 17 Jul 2026 05:30:55 -0400
X-MC-Unique: tDikm5GbMzu7gzVrgW5AJg-1
X-Mimecast-MFC-AGG-ID: tDikm5GbMzu7gzVrgW5AJg_1784280654
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C566180066B
 for <dev@dpdk.org>; Fri, 17 Jul 2026 09:30:54 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EFC1180036E; Fri, 17 Jul 2026 09:30:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>
Subject: [PATCH 10/10] ci: run reference unit tests against ABI
Date: Fri, 17 Jul 2026 11:30:05 +0200
Message-ID: <20260717093006.229370-11-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Akj3cWwUDvQ38ySDabiEeXURnmBjBnOqmCEJLisFEQw_1784280654
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

Let's check if unit tests from the reference build can run with the
current release libraries/drivers.

This gives another level of ABI checking, like catching regressions on
experimental or internal ABI symbols that get promoted to stable.

Skip unit tests that were added since the reference (iow v26.03).
$ git diff v26.03..origin/main |
  sed -ne 's/^[+]REGISTER_FAST_TEST(\([^,]*\).*$/\1/p' |
  sort
af_packet_pmd_autotest
bpf_exec_wrong_flags_autotest
bpf_exec_wrong_nb_prog_arg_autotest
bpf_load_null_autotest
bpf_validate_autotest
eal_flags_pagesz_mem_autotest
feature_autotest
pcap_pmd_autotest
reassembly_autotest

As reported in https://bugs.dpdk.org/show_bug.cgi?id=1967, devargs
and vdev autotests are broken due to drivers ABI changes since
those unit tests are directly accessing internal objects.
FIXME: for now, use a branch of mine with backports on 26.03.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .ci/linux-build.sh          | 28 +++++++++++++++++++++++++---
 .github/workflows/build.yml | 15 +++++++++++++--
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index a5e602ed83..f4fb398cd9 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -200,23 +200,28 @@ if [ "$ABI_CHECKS" = "true" ]; then
         rm -rf reference
     fi
 
+    # FIXME: force regeneration in CI for this patch
+    if [ ! -e reference/usr/local/bin/dpdk-test ]; then
+        rm -rf reference
+    fi
+
     if [ ! -d reference ]; then
         REF_OPTS="$OPTS"
         # We only care about the drivers and libs, disable developer checks and
         # don't try to link apps.
         REF_OPTS="$REF_OPTS -Dcheck_includes=false"
         REF_OPTS="$REF_OPTS -Ddeveloper_mode=disabled"
-        REF_OPTS="$REF_OPTS -Ddisable_apps=*"
+        REF_OPTS="$REF_OPTS -Denable_apps=test"
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
         rm -rf reference/usr/local/share
         echo $REF_GIT_TAG > reference/VERSION
     fi
@@ -233,6 +238,23 @@ if [ "$RUN_TESTS" = "true" ]; then
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
index f0ef39d34f..b311ee26f9 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -11,8 +11,9 @@ defaults:
 
 env:
   REF_GIT_BRANCH: main
-  REF_GIT_REPO: https://github.com/DPDK/dpdk
-  REF_GIT_TAG: v26.03
+  # FIXME
+  REF_GIT_REPO: https://github.com/david-marchand/dpdk
+  REF_GIT_TAG: 26.03
 
 jobs:
   checkpatch:
@@ -39,6 +40,16 @@ jobs:
     env:
       AARCH64: ${{ matrix.config.cross == 'aarch64' }}
       ABI_CHECKS: ${{ contains(matrix.config.checks, 'abi') }}
+      ABI_SKIP_TESTS: |
+        af_packet_pmd_autotest
+        bpf_exec_wrong_flags_autotest
+        bpf_exec_wrong_nb_prog_arg_autotest
+        bpf_load_null_autotest
+        bpf_validate_autotest
+        eal_flags_pagesz_mem_autotest
+        feature_autotest
+        pcap_pmd_autotest
+        reassembly_autotest
       ASAN: ${{ contains(matrix.config.checks, 'asan') }}
       BUILD_32BIT: ${{ matrix.config.cross == 'i386' }}
       BUILD_DEBUG: ${{ contains(matrix.config.checks, 'debug') }}
-- 
2.54.0

