Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1818C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:03:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1EC140698;
	Wed, 16 Jul 2025 15:03:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B329E40672
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752670997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGyunl0bfXnV7lIvuqLVogC0QuFX5vlusPfVUzevqAc=;
 b=C0oWxtv9DolJ+2SHT8EdNx6gy7F3flHKYFeAQSbl5MrX96pwB+/fLSmxAUrQon41Cx+EyX
 /Wk02JpHUDKtlH9PmECytavewqzbkmf2hQlcMM7OVSV+MYsNJX8ImvoewK1T6cBpPc0rxa
 lklyfPNr8ktj0JTNgzpvlagFzArJLQw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-16nOwF1LMbKlbi2bHh0ZFA-1; Wed,
 16 Jul 2025 09:03:14 -0400
X-MC-Unique: 16nOwF1LMbKlbi2bHh0ZFA-1
X-Mimecast-MFC-AGG-ID: 16nOwF1LMbKlbi2bHh0ZFA_1752670993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 607CE19560AD; Wed, 16 Jul 2025 13:03:13 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28165300019F; Wed, 16 Jul 2025 13:03:10 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Michael Santana <maicolgabriel@hotmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v4 10/22] build: support Undefined Behavior Sanitizer
Date: Wed, 16 Jul 2025 15:01:57 +0200
Message-ID: <20250716130212.1736407-11-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: elGe8a3yl-o44jEthiFCKmz1EnX6fvY0p9z-SpW3sNw_1752670993
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

Enable UBSan in GHA.
There are still a lot of issues so only run unit tests for a "mini"
target.

Building with debugoptimized forces -O2 and consumes too much memory
with UBSan, prefer plain build (iow -O0) even though this hides a number
of build issues.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- left the mini configuration alone and instead filtered
  enabled component when running unit tests with UBSan,

---
 .ci/linux-build.sh          | 38 +++++++++++++++++++++++++++++++++++--
 .github/workflows/build.yml |  5 +++++
 app/test/suites/meson.build |  3 +--
 config/meson.build          | 18 +++++++++++++++++-
 devtools/words-case.txt     |  1 +
 5 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index 5c4bfa75c3..c7f3179598 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -44,6 +44,13 @@ catch_coredump() {
     return 1
 }
 
+catch_ubsan() {
+    [ "$UBSAN" = "true" ] || return 0
+    grep -q UndefinedBehaviorSanitizer $2 2>/dev/null || return 0
+    grep -E "($1|UndefinedBehaviorSanitizer)" $2
+    return 1
+}
+
 check_traces() {
     which babeltrace >/dev/null || return 0
     for file in $(sudo find $HOME -name metadata); do
@@ -100,7 +107,6 @@ fi
 
 OPTS="$OPTS -Dplatform=generic"
 OPTS="$OPTS -Ddefault_library=$DEF_LIB"
-OPTS="$OPTS -Dbuildtype=$buildtype"
 if [ "$STDATOMIC" = "true" ]; then
     OPTS="$OPTS -Denable_stdatomic=true"
 else
@@ -122,13 +128,39 @@ else
 fi
 OPTS="$OPTS -Dlibdir=lib"
 
+buildtype=debugoptimized
+sanitizer=
 if [ "$ASAN" = "true" ]; then
-    OPTS="$OPTS -Db_sanitize=address"
+    sanitizer=${sanitizer:+$sanitizer,}address
+fi
+
+if [ "$UBSAN" = "true" ]; then
+    sanitizer=${sanitizer:+$sanitizer,}undefined
+    if [ "$RUN_TESTS" = "true" ]; then
+        # UBSan takes too much memory with -O2
+        buildtype=plain
+        # Only enable test binaries
+        OPTS="$OPTS -Denable_apps=test,test-pmd"
+        # Restrict drivers to a minimum set for now
+        OPTS="$OPTS -Denable_drivers=net/null"
+        # There are still known issues in various libraries, disable them for now
+        OPTS="$OPTS -Ddisable_libs=*"
+        # No examples are run
+        OPTS="$OPTS -Dexamples="
+        # The UBSan target takes a good amount of time and headers coverage is done in other
+        # targets already.
+        OPTS="$OPTS -Dcheck_includes=false"
+    fi
+fi
+
+if [ -n "$sanitizer" ]; then
+    OPTS="$OPTS -Db_sanitize=$sanitizer"
     if [ "${CC%%clang}" != "$CC" ]; then
         OPTS="$OPTS -Db_lundef=false"
     fi
 fi
 
+OPTS="$OPTS -Dbuildtype=$buildtype"
 OPTS="$OPTS -Dwerror=true"
 
 if [ -d build ]; then
@@ -146,6 +178,7 @@ if [ -z "$cross_file" ]; then
     configure_coredump
     devtools/test-null.sh || failed="true"
     catch_coredump
+    catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
     check_traces
     [ "$failed" != "true" ]
 fi
@@ -187,6 +220,7 @@ if [ "$RUN_TESTS" = "true" ]; then
     configure_coredump
     sudo meson test -C build --suite fast-tests -t 3 || failed="true"
     catch_coredump
+    catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
     check_traces
     [ "$failed" != "true" ]
 fi
diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 6c4bc664d0..0c8ca23bbb 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -54,6 +54,7 @@ jobs:
       RISCV64: ${{ matrix.config.cross == 'riscv64' }}
       RUN_TESTS: ${{ contains(matrix.config.checks, 'tests') }}
       STDATOMIC: ${{ contains(matrix.config.checks, 'stdatomic') }}
+      UBSAN: ${{ contains(matrix.config.checks, 'ubsan') }}
 
     strategy:
       fail-fast: false
@@ -62,6 +63,10 @@ jobs:
           - os: ubuntu-22.04
             compiler: gcc
             mini: mini
+          - os: ubuntu-22.04
+            compiler: clang
+            library: shared
+            checks: tests+ubsan
           - os: ubuntu-22.04
             compiler: gcc
             checks: stdatomic
diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index e482373330..0cba63ee12 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -72,8 +72,7 @@ foreach suite:test_suites
             elif not has_hugepage
                 continue  #skip this tests
             endif
-            if not asan and (get_option('b_sanitize') == 'address'
-                    or get_option('b_sanitize') == 'address,undefined')
+            if not asan and get_option('b_sanitize').contains('address')
                 continue  # skip this test
             endif
 
diff --git a/config/meson.build b/config/meson.build
index f31fef216c..b8a8511a7f 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -499,7 +499,7 @@ if get_option('b_lto')
     endif
 endif
 
-if get_option('b_sanitize') == 'address' or get_option('b_sanitize') == 'address,undefined'
+if get_option('b_sanitize').contains('address')
     if is_windows
         error('ASan is not supported on windows')
     endif
@@ -519,6 +519,22 @@ if get_option('b_sanitize') == 'address' or get_option('b_sanitize') == 'address
     endif
 endif
 
+if get_option('b_sanitize').contains('undefined')
+    if is_windows
+        error('UBSan is not supported on windows')
+    endif
+
+    if cc.get_id() == 'gcc'
+        ubsan_dep = cc.find_library('ubsan', required: true)
+        if (not cc.links('int main(int argc, char *argv[]) { return 0; }',
+                dependencies: ubsan_dep))
+            error('broken dependency, "libubsan"')
+        endif
+        add_project_link_arguments('-lubsan', language: 'c')
+        dpdk_extra_ldflags += '-lubsan'
+    endif
+endif
+
 if get_option('default_library') == 'both'
     error( '''
  Unsupported value "both" for "default_library" option.
diff --git a/devtools/words-case.txt b/devtools/words-case.txt
index bc35c160ba..d315fde8fe 100644
--- a/devtools/words-case.txt
+++ b/devtools/words-case.txt
@@ -105,6 +105,7 @@ TSO
 TTL
 Tx
 uAPI
+UBSan
 UDM
 UDP
 ULP
-- 
2.50.0

