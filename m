Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A70CC98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:42:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEC1D42EAC;
	Tue, 22 Sep 2026 21:41:52 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id CB33142EB9
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:48 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b31b4281eso192120a91.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790106108;
 x=1790710908; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N7Mt+JtKrvTHA7QJdvyUav78aGodTuJSvSASY3sszps=;
 b=UCzlpgYWdfNwtH2bWNwCqDmN4253WwnMfQ4/LsL5uSQ3JaUGByJArgbScp87U7TCwo
 3Xz8qlCvxSz/3svuZypevKbQ12f+Vo0gET/4en+HS9yrHVVB68cUi2rY8cbq0/JomPs2
 DtWowXjzgoDq/bOzSkFpqNl6r9YKwmLiogkSILBXeJKqJf40yd7sCI/qld05DOd5X/D1
 ZZKR0vv8iYcuXRZ/NtnVwezv3kSNoakK+kPAz0UhmUNpt6ak/AF4UrlcX8Oum3hjuwvK
 oCtpY9yW4U2E1UJx4iC4Tl3YnVhJSfrfRqAt6sLdVDpN1HxYXBANBv3piXyj5CbdrStJ
 jHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790106108; x=1790710908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N7Mt+JtKrvTHA7QJdvyUav78aGodTuJSvSASY3sszps=;
 b=WBdSYISLenHMlYUUZxdN8RVAgzGXrqoZXsncdk26jfbIBHdTNqweuF2F+FON+3VNR9
 RNm8aV1yshv0w5LgBIisT6ntybHh+3xnDY4SyC4I6BWbUBoZx40QCVYl/sBOzFV7ogMP
 ViFjU1oQsLa0Dfe3EMGttIt3xAQlmJ04o1LcdpyBe6id9P9+iTVL/TJnx23jgRIcgEgz
 5vEgISReN3lZDSp8zeI54ixVbwksoIsS5vC3FT81cddS361Q/RLbpmQuIEFB0SmlqzBX
 WRG/QKZFzIDgZWfs/Wc6vewlrkxpZRsuUBRSq/kxIDwa/F9IF4z48vyPq7CADt+S7+Op
 2uMg==
X-Gm-Message-State: AFuF++k9+iDTu5IPS3VcmavRDTxN43A4v+6hd+NtF1QTL8kPOYGlx+1K
 y2+AvJ/LhDU/qxP+WOwHBsyx4nk8fJLccRidpDnOOcder+7FTz47YjCyZx4z73mo8YwItFxUP2x
 m6nn+Zow=
X-Gm-Gg: AYBFou3v9lhVlHpXT9su7RTyLaZ+R6Ex8p0M41mUTj3gedjcuWnLoGSv/EQb9XIWMB3
 n/p7G8731QiLZZjtFTUzJ8qVEs/YmDetTJ8PUYJ+WbiScWX9uOciPZDrmBt2bULNP9F6kFaMS6x
 +zov0C9b903h5Bf//RG7rANplukf9a8IAFuCpQm+GZp3hHPKbzgd8BUy1IJSy5rL5W2YTFJhROx
 ZATovhAiSCzU9HRuzX9gZZz7dkoEWd7SXQINKfXKNxizphmXj0f9r3NrTXHCNVETyutf1V7MRO6
 ttn5CgVFEL23J/PjjuuQB3NVH2w6MUomJbtjnk2bk0WcD78SSZFjoYii1R6i4OgQ/7/0xvJOc0V
 7bPQ9lm1yYOTWbQwAi2NyVW1rnw4np83Za4Okt2+23FCehi13A54CgEY6O6Y2qBWZuRpuff3Ohz
 V+DI6B7j4J8JPY8qXb3FxM4Y9grnuDQarG7WVoZ7UNnIfcZ3y6Ugkd1hsV6KmydiIkrXfkCYfJ4
 sjhf81ISMookfRGWaYFv7jejGWIRjstWODz2Gz4Yo7pm5aU
X-Received: by 2002:a17:90b:2d05:b0:3a0:2900:f56c with SMTP id
 98e67ed59e1d1-3a07e705245mr379499a91.57.1790106107791; 
 Tue, 22 Sep 2026 12:41:47 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf1cf3sm814881a91.9.2026.09.22.12.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:41:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>, Thomas Monjalon <thomas@monjalon.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH 6/7] net/memif: add server/client connectivity test
Date: Tue, 22 Sep 2026 12:40:57 -0700
Message-ID: <20260922194138.508919-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194138.508919-1-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
MIME-Version: 1.0
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

Add a black box test that launches a memif server and client as two
separate testpmd processes connected over a shared socket, and checks
that traffic flows in both directions with no descriptor validation
errors. This exercises the peer request validation over a real
connection without depending on any internal driver API, and provides
the two-instance harness that an adversarial (fuzzing) peer can be
driven from later.

Both instances forward what they receive, so the client to server and
server to client rings both carry traffic and the descriptors the
client writes are validated on both paths. The client seeds the first
burst with "start tx_first", which has to be issued as a command since
--tx-first can not be combined with interactive mode.

The test is run from the CI alongside test-null.sh. It skips (exit 77)
when the memif driver was not built, as in the CI jobs restricted with
-Denable_drivers=net/null, and when fewer than four cores are online
since the two primary processes need two cores each.

Bugzilla ID: 2016
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .ci/linux-build.sh     |   1 +
 MAINTAINERS            |   1 +
 devtools/test-memif.sh | 169 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100755 devtools/test-memif.sh

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index e0b914a142..605265d7b6 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -178,6 +178,7 @@ if [ -z "$cross_file" ]; then
     failed=
     configure_coredump
     devtools/test-null.sh || failed="true"
+    devtools/test-memif.sh || [ $? = 77 ] || failed="true"
     catch_coredump
     catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
     check_traces
diff --git a/MAINTAINERS b/MAINTAINERS
index 56e20d993d..f8b117c57f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1165,6 +1165,7 @@ M: Jakub Grajciar <jgrajcia@cisco.com>
 F: drivers/net/memif/
 F: doc/guides/nics/memif.rst
 F: doc/guides/nics/features/memif.ini
+F: devtools/test-memif.sh
 
 
 Crypto Drivers
diff --git a/devtools/test-memif.sh b/devtools/test-memif.sh
new file mode 100755
index 0000000000..065ba08347
--- /dev/null
+++ b/devtools/test-memif.sh
@@ -0,0 +1,169 @@
+#! /bin/sh -e
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright 2026 Stephen Hemminger
+
+# Run a memif server and client testpmd pair over a shared socket and
+# check that traffic flows in both directions without descriptor errors.
+# This is the black box connectivity and regression baseline for the
+# memif peer request validation; adversarial (fuzz) peers can be added
+# as a separate driver against the same two-instance setup.
+
+build=${1:-build} # first argument can be the build directory
+testpmd=$1 # or first argument can be the testpmd path
+srvcores=${2:-0-1} # cores for the server instance
+clicores=${3:-2-3} # cores for the client instance
+eal_options=$4
+testpmd_options=$5
+
+[ -f "$testpmd" ] && build=$(dirname $(dirname $testpmd))
+[ -f "$testpmd" ] || testpmd=$build/app/dpdk-testpmd
+[ -f "$testpmd" ] || testpmd=$build/app/testpmd
+if [ ! -f "$testpmd" ] ; then
+	echo 'ERROR: testpmd cannot be found' >&2
+	exit 1
+fi
+
+if ldd $testpmd | grep -q librte_ ; then
+	export LD_LIBRARY_PATH=$build/lib:$LD_LIBRARY_PATH
+	libs="-d $build/drivers"
+else
+	libs=
+fi
+
+# Skip (do not fail) where the driver was not built, for example a
+# build restricted with -Denable_drivers.
+config=$build/rte_build_config.h
+if [ -f "$config" ] && ! grep -q '^#define RTE_NET_MEMIF ' $config ; then
+	echo 'SKIP: memif driver is not built' >&2
+	exit 77 # automake convention for a skipped test
+fi
+
+# The server and client run as two separate primary processes, needing
+# two cores each. Skip (do not fail) where there are not enough cores.
+# Use nproc rather than getconf, it respects the affinity mask.
+ncpus=$(nproc 2>/dev/null || echo 1)
+if [ "$ncpus" -lt 4 ] ; then
+	echo "SKIP: memif test needs 4 cores, only $ncpus online" >&2
+	exit 77
+fi
+
+# Per run temporary socket and logs, cleaned up on exit.
+rundir=$(mktemp -d)
+sock=$rundir/memif.sock
+srvlog=$rundir/server.log
+clilog=$rundir/client.log
+srvpid=
+
+cleanup()
+{
+	[ -n "$srvpid" ] && kill $srvpid 2>/dev/null || true
+	rm -rf $rundir
+}
+trap cleanup EXIT
+
+common="--no-huge -m 64 --in-memory --file-prefix"
+
+# Use a pathname (non abstract) socket so its creation can be waited on
+# and so it is removed with the run directory on exit.
+vdev_srv="net_memif0,role=server,socket-abstract=no,socket=$sock"
+vdev_cli="net_memif0,role=client,socket-abstract=no,socket=$sock"
+
+# Both sides forward what they receive back to the peer, so that the
+# client to server (C2S) and server to client (S2C) rings both carry
+# traffic; descriptors supplied by the client are validated on both.
+# The server starts first, it listens on the socket.
+$testpmd $common memif_srv -l $srvcores $libs \
+	--vdev=$vdev_srv $eal_options -- \
+	--no-mlockall --total-num-mbufs=8192 \
+	--forward-mode=macswap --auto-start --stats-period 1 \
+	$testpmd_options > $srvlog 2>&1 &
+srvpid=$!
+
+# Wait for the server to create the listening socket (up to ~5s).
+tries=0
+while [ ! -S "$sock" ] ; do
+	tries=$((tries + 1))
+	if [ $tries -gt 50 ] ; then
+		echo 'ERROR: server socket not created' >&2
+		cat $srvlog >&2
+		exit 1
+	fi
+	sleep 0.1 2>/dev/null || sleep 1
+done
+
+# The client seeds the first burst with "start tx_first" and then
+# forwards what comes back, so the packets keep going round. It is
+# interactive (-i, not -ia) so that the burst is sent by that command
+# rather than by an auto-start with nothing to forward yet. Keep going
+# on a non-zero exit so that the logs below are still reported.
+clistatus=0
+(echo 'start tx_first' && sleep 3 && echo stop) | \
+$testpmd $common memif_cli -l $clicores $libs \
+	--vdev=$vdev_cli $eal_options -- \
+	--no-mlockall --total-num-mbufs=8192 \
+	--forward-mode=io --stats-period 1 \
+	$testpmd_options -i > $clilog 2>&1 || clistatus=$?
+
+# Let the server drain and print a final stats block, then stop it.
+sleep 1
+kill $srvpid 2>/dev/null || true
+wait $srvpid 2>/dev/null || true
+srvpid=
+
+fail=0
+
+if [ $clistatus -ne 0 ] ; then
+	echo "ERROR: client exited with status $clistatus" >&2
+	fail=1
+fi
+
+# testpmd prints a periodic statistics block per port and a final forward
+# statistics block. Match any line showing a non-zero count rather than
+# the last one, so that the result does not depend on when each instance
+# happened to be stopped.
+nonzero()
+{
+	grep "$2" "$1" | grep -q "$2"'[[:space:]]*[^0[:space:]]'
+}
+
+# Both rings must carry traffic: the client drives the client to server
+# ring and the server sends the same packets back over server to client.
+check_nonzero() # log pattern description
+{
+	if ! nonzero "$1" "$2" ; then
+		echo "ERROR: $3" >&2
+		fail=1
+	fi
+}
+
+check_nonzero $clilog 'TX-packets: ' 'client did not transmit any packet'
+check_nonzero $srvlog 'RX-packets: ' 'server did not receive any packet'
+check_nonzero $srvlog 'TX-packets: ' 'server did not transmit any packet'
+check_nonzero $clilog 'RX-packets: ' 'client did not receive any packet'
+
+# A conforming peer must not trip descriptor validation: no rx/tx errors
+# and no "bad descriptor" log line on either side.
+for log in $srvlog $clilog ; do
+	if nonzero $log 'RX-errors: ' ; then
+		echo "ERROR: RX-errors reported in $log" >&2
+		fail=1
+	fi
+	if nonzero $log 'TX-errors: ' ; then
+		echo "ERROR: TX-errors reported in $log" >&2
+		fail=1
+	fi
+	if grep -q 'bad descriptor' $log ; then
+		echo "ERROR: descriptor validation rejected a valid request in $log" >&2
+		fail=1
+	fi
+done
+
+if [ $fail -ne 0 ] ; then
+	echo '--- server log ---' >&2
+	cat $srvlog >&2
+	echo '--- client log ---' >&2
+	cat $clilog >&2
+	exit 1
+fi
+
+echo 'memif server/client forwarding: OK'
-- 
2.53.0

