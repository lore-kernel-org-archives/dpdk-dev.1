Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC43C531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 20:15:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A7E940276;
	Fri, 24 Jul 2026 22:15:47 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3BCDA40274
 for <dev@dpdk.org>; Fri, 24 Jul 2026 22:15:46 +0200 (CEST)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-80814edb536so8415987b3.2
 for <dev@dpdk.org>; Fri, 24 Jul 2026 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784924145;
 x=1785528945; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tyMKYLs0Ghn0gohbc2geOwM/XoRVGxTtQ1emDyVWtCc=;
 b=uRTo35TgVpvwr8skyH8ckgeOk5G5rSt7D6uYhU7UmkZ3kh4Wnts5BqYBa8djaesfYs
 41EMhUk59D2vEV6L7+5MjM18Xoxg/0Mf9EKCszJVC/z0AH/kyYq6QhUtjwZjyoSZUkey
 Es0plFaHmgmOMiySq629WKxddhVKrZwWJjv7EGUAFlo3pRnrQGGh9Zg8kH6BY7ErWx9m
 bTv5x0WIK4O96aB+XAGSEiJQUE0GoP8WgDirLJovUKQ5Nzme0XvDCu4v1BxLIJk9t68P
 TLf6odcp1m4UddwaBbWfCiCosPPHmQ5+WhTIHrB51kylBt3yGdIiVSdjgsvvQB17yduy
 D1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784924145; x=1785528945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tyMKYLs0Ghn0gohbc2geOwM/XoRVGxTtQ1emDyVWtCc=;
 b=BH/OXjnVoeEor2n+hm3Yl+SivgjluMbtXNPw7Gbm5mNpRNg8e7lhmPozzHtH+96KiA
 A616Ej/Bfl8B4NxOzj2MxjJDT52n5oWByuHa51LunzfyjCKtKWLj/qptTefvZmZntza8
 F2omPWUFonHhaHppXWM41ZU+c3XDPQtdwjz2C/wzBwFRZ8wYLR6fVC3tX/AW//wNMnDi
 wSDv+aK0ooVtfE+AeK1AkQMjKkN2z9lnF5jQ0SZ/tM+5h9XBeHxLF5/QwJob2maW41l0
 NiETud93H/B/yr0i3BWz+ORgCK1RwGAM/XxBI2/049fftHWPvsdPcMdCdcQb0t56q3Gj
 AiVg==
X-Gm-Message-State: AOJu0Yzj5G3MFARj70h6Z4gs0quTzr4fgWePrKjjsyOY3EajvnrNH3sJ
 4vT6buuX9bITpj2LI94o6Gsy+GaCuogZu4av+I+2APq7v+42qS8Upj0Xig1kfpTrJmAF4c74g8J
 wDZns
X-Gm-Gg: AR+sD134KAOvKhWN54qjxvOzzGd/mt7furWt8uglBamNoMZ9chgm7Wg7Q1+VVchE/et
 RunFbNIBYJiPPxwgpDmhDe6RvD1tII3+Yyf3fU3wFY35nGrgB+sMbxqcA+A5J2hzsuXeMsgSe+s
 AQxM6V64Jz9Aofy6iiFvb3W0pnuHCHEkf4+6VHHFf5S3+IJi1Gvm1XlK3/rFit9GAE//KGUXaI2
 DWx1o8Z3nbONik8ojSa1VciwFMKSRCb4ysS3B115suoltetgLUjcFvyoQg7z8sgDgBgjtt7oIJd
 qDcJjxc2SB4oMMxsU4tItAQ9q5qKSqGvKG6asOkYoTNwIuQsnLvpWDn1Mu7oSTbsD3ZkokWji8x
 0J4RHTsRIxW6sEdoExc2UDTUPvn1NCvVKqhIOAL0QmEnzjYqtFrS4tY85TWgmram3zuC6zyFuea
 xKE5dCiat6nTqe08onRc3Hd0iznZl54+aDB1TSgTeD
X-Received: by 2002:a05:690c:6a11:b0:81e:a425:fe88 with SMTP id
 00721157ae682-81f4c3a6360mr29891777b3.33.1784924145196; 
 Fri, 24 Jul 2026 13:15:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f657a9705sm5279647b3.16.2026.07.24.13.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 13:15:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] app/test: rewrite telemetry test in python
Date: Fri, 24 Jul 2026 13:15:41 -0700
Message-ID: <20260724201541.801099-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The test_telemetry.sh was failing with test timeout.
This was caused by the overhead of spawning a fresh dpdk-telemetry.py
for every command it walked. With every endpoint queried three times,
that is several hundred Python interpreter startups per run.

Replace the shell script with a python test that opens the telemetry
socket once and issues every command over that single connection.

Each reply is parsed as JSON and checked directly in Python.
This also drops the jq dependency.

Bugzilla ID: 1972
Fixes: 9da71dc4f96e ("test: add test case for scripted telemetry commands")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/suites/meson.build       |   2 +-
 app/test/suites/test_telemetry.py | 129 ++++++++++++++++++++++++++++++
 app/test/suites/test_telemetry.sh |  30 -------
 3 files changed, 130 insertions(+), 31 deletions(-)
 create mode 100755 app/test/suites/test_telemetry.py
 delete mode 100755 app/test/suites/test_telemetry.sh

diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 786c459c24..ec1de99154 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -145,7 +145,7 @@ if not is_windows and dpdk_conf.has('RTE_LIB_TELEMETRY')
         test_args += ['--vdev=rawdev_skeleton0']
     endif
     test_args += ['-a', '0000:00:00.0']
-    test('telemetry_all', find_program('test_telemetry.sh'),
+    test('telemetry_all', find_program('test_telemetry.py'),
             args: test_args,
             timeout : timeout_seconds_fast,
             is_parallel : false,
diff --git a/app/test/suites/test_telemetry.py b/app/test/suites/test_telemetry.py
new file mode 100755
index 0000000000..f37eccabcc
--- /dev/null
+++ b/app/test/suites/test_telemetry.py
@@ -0,0 +1,129 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2022 Red Hat, Inc.
+
+"""Exercise every telemetry command exported by an application.
+
+Spawns the DPDK test binary (passed as arguments), waits for its telemetry
+socket to appear, then walks every command reported by "/", calling each one
+with no parameter and with dummy parameters "0" and "z". Every reply is parsed
+as JSON and checked, so a malformed, empty or missing response fails the test
+immediately and names the offending command, rather than relying on a shell
+pipeline not erroring.
+
+A single connection is reused for the whole walk: the previous shell version
+spawned a fresh dpdk-telemetry.py (Python interpreter + new connection) per
+command, which scaled with process-startup cost and timed out under load.
+"""
+
+import json
+import os
+import socket
+import subprocess
+import sys
+import time
+
+SOCKET_NAME = "dpdk_telemetry.v2"
+
+
+def runtime_dir():
+    """DPDK runtime dir for the default 'rte' file-prefix, matching EAL."""
+    run = os.environ.get("RUNTIME_DIRECTORY")
+    if not run:
+        run = (
+            "/var/run"
+            if os.getuid() == 0
+            else os.environ.get("XDG_RUNTIME_DIR", "/tmp")
+        )
+    return os.path.join(run, "dpdk", "rte")
+
+
+def wait_for_socket(path, proc, timeout=10):
+    """Wait for the telemetry socket, failing fast if the app dies first."""
+    deadline = time.time() + timeout
+    while time.time() < deadline:
+        if os.path.exists(path):
+            return
+        if proc.poll() is not None:
+            raise RuntimeError(
+                "application exited (code %d) before telemetry socket appeared"
+                % proc.returncode
+            )
+        time.sleep(0.05)
+    raise RuntimeError("timed out waiting for telemetry socket %s" % path)
+
+
+class TelemetryClient:
+    def __init__(self, path):
+        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_SEQPACKET)
+        self.sock.connect(path)
+        info = json.loads(self.sock.recv(1024))
+        self.buf_len = info["max_output_len"]
+
+    def command(self, cmd):
+        self.sock.send(cmd.encode())
+        reply = self.sock.recv(self.buf_len).decode()
+        try:
+            return json.loads(reply)
+        except json.JSONDecodeError as e:
+            raise AssertionError(
+                "invalid JSON reply for %r: %s (raw: %r)" % (cmd, e, reply)
+            )
+
+    def close(self):
+        self.sock.close()
+
+
+def check_reply(cmd, reply):
+    """A telemetry reply must be a dict keyed by the command name."""
+    if not isinstance(reply, dict) or list(reply.keys()) != [cmd.split(",")[0]]:
+        raise AssertionError("unexpected reply for %r: %r" % (cmd, reply))
+
+
+def walk(client):
+    listing = client.command("/")
+    check_reply("/", listing)
+    count = 0
+    for cmd in listing["/"]:
+        for arg in ("", ",0", ",z"):
+            full = cmd + arg
+            reply = client.command(full)
+            check_reply(full, reply)
+            count += 1
+    return count
+
+
+def main():
+    if len(sys.argv) < 2:
+        print("usage: %s <dpdk-app> [eal args...]" % sys.argv[0], file=sys.stderr)
+        return 1
+
+    sock_path = os.path.join(runtime_dir(), SOCKET_NAME)
+    proc = subprocess.Popen(sys.argv[1:], stdin=subprocess.PIPE)
+    try:
+        wait_for_socket(sock_path, proc)
+        client = TelemetryClient(sock_path)
+        try:
+            count = walk(client)
+        finally:
+            client.close()
+        print("telemetry: walked %d commands" % count)
+    finally:
+        # tell the interactive prompt to exit, then ensure the app is gone
+        try:
+            proc.stdin.write(b"quit\n")
+            proc.stdin.flush()
+            proc.stdin.close()
+        except (BrokenPipeError, OSError):
+            pass
+        try:
+            proc.wait(timeout=5)
+        except subprocess.TimeoutExpired:
+            proc.terminate()
+            proc.wait()
+
+    return 0 if proc.returncode == 0 else proc.returncode
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/app/test/suites/test_telemetry.sh b/app/test/suites/test_telemetry.sh
deleted file mode 100755
index 3c5b629b63..0000000000
--- a/app/test/suites/test_telemetry.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh -e
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright (c) 2022 Red Hat, Inc.
-
-which jq || {
-    echo "No jq available, skipping test."
-    exit 77
-}
-
-rootdir=$(readlink -f $(dirname $(readlink -f $0))/../../..)
-tmpoutput=$(mktemp -t dpdk.test_telemetry.XXXXXX)
-trap "cat $tmpoutput; rm -f $tmpoutput" EXIT
-
-call_all_telemetry() {
-    telemetry_script=$rootdir/usertools/dpdk-telemetry.py
-    echo >$tmpoutput
-    echo "Telemetry commands log:" >>$tmpoutput
-    echo / | $telemetry_script | jq -r '.["/"][]' | while read cmd
-    do
-        for input in $cmd $cmd,0 $cmd,z
-        do
-            echo Calling $input >> $tmpoutput
-            echo $input | $telemetry_script >> $tmpoutput 2>&1
-        done
-    done
-}
-
-! set -o | grep -q errtrace || set -o errtrace
-! set -o | grep -q pipefail || set -o pipefail
-(sleep 1 && call_all_telemetry && echo quit) | $@
-- 
2.53.0

