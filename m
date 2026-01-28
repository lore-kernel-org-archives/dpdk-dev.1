Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877AFD35693
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 11:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0C4140274;
	Wed, 28 Jan 2026 12:04:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ECE9B400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 12:04:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769598288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bdYcgZD+6EB877T37EDwh2vc3p3lL+udTtroqjdqMxA=;
 b=hsR0X4UoQ4zr2GhkklWRA+gqxtkkwQ7WBV2hTIlC6JlmzLC2eKt5mSaCbzFyyqwX+BbbPr
 BJMDMDNRjB12ySAfSFfH3m3GQyfvwQDxIb9b2lluR9onCnegarVv+C3QduiOi7nwKwKVEG
 iHW3oH9q3UuOcVO7+L8saxSTujCwq0E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-2i9SdjlyNgunJw-fiJwgRQ-1; Wed,
 28 Jan 2026 06:04:46 -0500
X-MC-Unique: 2i9SdjlyNgunJw-fiJwgRQ-1
X-Mimecast-MFC-AGG-ID: 2i9SdjlyNgunJw-fiJwgRQ_1769598286
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCCBC1955D8E; Wed, 28 Jan 2026 11:04:45 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E61319560B2; Wed, 28 Jan 2026 11:04:44 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: scott.k.mitch1@gmail.com,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH] ci: display UBSan stack trace
Date: Wed, 28 Jan 2026 12:04:38 +0100
Message-ID: <20260128110438.3003192-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tDRV8FsACu6LjoX71vHc3AZ2AQzuE15sZSAlhYRgwCg_1769598286
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

When UBSan raises an error, we get really few context.

Example, on a recently submitted patch:

RTE>>cksum_fuzz_autotest
../lib/net/rte_cksum.h:49:10: runtime error: load of misaligned address
	0x0001816c2e81 for type 'const unaligned_uint16_t' (aka 'const
	unsigned short'), which requires 2 byte alignment
0x0001816c2e81: note: pointer points here
 00 00 00  00 70 f2 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^
	00 00 00 00 00 00 00 00  00 00 00 00 00
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/net/rte_cksum.h:49:10 in

Ask for the full stack.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .ci/linux-build.sh | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index 084d9642fc..091d239fae 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -7,7 +7,11 @@ if [ -z "${DEF_LIB:-}" ]; then
 fi
 
 # Builds are run as root in containers, no need for sudo
-[ "$(id -u)" != '0' ] || alias sudo=
+if [ "$(id -u)" = '0' ]; then
+    run_as_root=""
+else
+    run_as_root="sudo -E"
+fi
 
 install_libabigail() {
     version=$1
@@ -28,15 +32,15 @@ configure_coredump() {
     # No point in configuring coredump without gdb
     which gdb >/dev/null || return 0
     ulimit -c unlimited
-    sudo sysctl -w kernel.core_pattern=/tmp/dpdk-core.%e.%p
+    $run_as_root sysctl -w kernel.core_pattern=/tmp/dpdk-core.%e.%p
 }
 
 catch_coredump() {
     ls /tmp/dpdk-core.*.* 2>/dev/null || return 0
     for core in /tmp/dpdk-core.*.*; do
-        binary=$(sudo readelf -n $core |grep $(pwd)/build/ 2>/dev/null |head -n1)
+        binary=$($run_as_root readelf -n $core |grep $(pwd)/build/ 2>/dev/null |head -n1)
         [ -x $binary ] || binary=
-        sudo gdb $binary -c $core \
+        $run_as_root gdb $binary -c $core \
             -ex 'info threads' \
             -ex 'thread apply all bt full' \
             -ex 'quit'
@@ -53,9 +57,9 @@ catch_ubsan() {
 
 check_traces() {
     which babeltrace >/dev/null || return 0
-    for file in $(sudo find $HOME -name metadata); do
-        ! sudo babeltrace $(dirname $file) >/dev/null 2>&1 || continue
-        sudo babeltrace $(dirname $file)
+    for file in $($run_as_root find $HOME -name metadata); do
+        ! $run_as_root babeltrace $(dirname $file) >/dev/null 2>&1 || continue
+        $run_as_root babeltrace $(dirname $file)
     done
 }
 
@@ -136,6 +140,7 @@ fi
 
 if [ "$UBSAN" = "true" ]; then
     sanitizer=${sanitizer:+$sanitizer,}undefined
+    export UBSAN_OPTIONS=print_stacktrace=1
     if [ "$RUN_TESTS" = "true" ]; then
         # UBSan takes too much memory with -O2
         buildtype=plain
@@ -218,7 +223,8 @@ fi
 if [ "$RUN_TESTS" = "true" ]; then
     failed=
     configure_coredump
-    sudo meson test -C build --suite fast-tests -t 3 --no-stdsplit --print-errorlogs || failed="true"
+    $run_as_root meson test -C build --suite fast-tests -t 3 --no-stdsplit --print-errorlogs ||
+        failed="true"
     catch_coredump
     catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
     check_traces
-- 
2.52.0

