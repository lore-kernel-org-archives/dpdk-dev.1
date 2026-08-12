Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42208C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 19:02:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB389402DF;
	Wed, 12 Aug 2026 21:02:36 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 828674026E
 for <dev@dpdk.org>; Wed, 12 Aug 2026 21:02:35 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso701097a12.0
 for <dev@dpdk.org>; Wed, 12 Aug 2026 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786561354;
 x=1787166154; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h5qQmovgZ4vbCuYEQQ2CJMJBUJEh2efF/O+mRhUXz1U=;
 b=CfGCl4xjFr7C6Ecmy4UEhz2MYIhZ6k1PB/v6DyYkAjom3f6VrKCvJWe/VbDLBnupGK
 0LXqDaHvlc0x6OCHXvN2oMoMfaoR+ZDyWnHL39I5VEGPvNcMHW4osDlDuwvJkDvJvJLQ
 ZmLuefW3QXQbeiHejxNN205Agf/bcz/dGbFqw90pPD8x/ZlAK3IuEF71ouVmwCPhDoj7
 uTLTR1Mvgye41vPpcGR6M0akz6h7Fw10xiKALg0Ka+LKNHqv6tjzwScm5twtQwTlRR/2
 I6AeG/EP1AgAZO21EiH5L9i2wI1ckkU9tL0f9PXSZtuX5pWRVdcmEIYtJxi3lsqc0eh7
 r2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786561354; x=1787166154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h5qQmovgZ4vbCuYEQQ2CJMJBUJEh2efF/O+mRhUXz1U=;
 b=fDwz8TF5FCBOHnCxd8SFH8ycx9rGxI1vcGt5ZmMgqvnlv34hsL0SxfdRUymxG7sQaZ
 f4aH6/RiqIHTad6UEl7LzLJy1vma5y6yuijzK9ddFtvTw14fbndcGwhgvDs9tdyI/KKr
 DnJE3oKs9lif3htOhuC7CRnHHUdcdlDBZLDaC2clJx4ufL8/Lcug85QrGPy8mbq28EZe
 gMpWu++YG6mHspaySuLAZ9QeZx75TDWay5beWuzXhWNhlqkNPYTM0EGFf7OiyXogpMsl
 MEFW+rTBtJahWumVn8yTXAJ5UglzERfN+aO+CJVLnjujujOZ7RKFlcIL7iGDZD2Us53L
 0Zug==
X-Gm-Message-State: AOJu0YyQSGritbG2NLSWiUSn4k/+GJbvyHBK2QHDmMYMaB3XEHRpmI6m
 MeenGDR0JS06KdBLpMPDUePQsuplw7AHHdNUdo81isQptBOhUzektIeACNDo/H7J6dsczK4zzXA
 bZpV1
X-Gm-Gg: AR+sD135g07f0TCwjGHm+1hgAb5GG1OD2KBsGDpRQRXpLzk3cUwj4Z6Yiq7e9uD8pu0
 YFuphXxhUaSxlsh51WQsB4zgqKYiMjKUfS+1/gyaZcFHMHtRUxhLo705UsJfsHYUwZXt/qRddVt
 lQr8JO3iMBFqUvxRfk3CGSYqcPSre+HjBfmvodcTMnVrnsQIcHw9+C7e1grDrTKvykAY74GD39J
 pOlqBohlHmo6bqYRQV0aBOQLkawwIpRELzBpI5Gb2aUYydsrdldyf1CSLtDvHVwA10RwhxXBX89
 BelhQDD3zL4h0ZDogzrsPMEDLqdr0+MkcfIjwMOryRLAI/ZXnVzNx4NNZ4YxEK4MuBCSH3eJMoa
 u2u0cTr/bkf+uP4CeJj0LBm9zOGBARHXuzW2Fk+FvAAAyBnOhw/xKnNmksdMiw6QGUqk7YoKTu1
 hmZRb0IMMsquIND/uriZtxDjy57GLqwbSTlr5m7XREI8oTIuUypD1fyri1rlScGGT3CJ4FrLuq7
 64yX+azCdDFwSVDE5YyAbbNlEM=
X-Received: by 2002:a05:6a20:d12e:b0:3c4:3112:3b with SMTP id
 adf61e73a8af0-3cc551f9869mr847699637.18.1786561354147; 
 Wed, 12 Aug 2026 12:02:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412d8d0c3esm357721c88.6.2026.08.12.12.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 12:02:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2] app/test: rewrite telemetry test in python
Date: Wed, 12 Aug 2026 12:01:09 -0700
Message-ID: <20260812190224.678892-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724201541.801099-1-stephen@networkplumber.org>
References: <20260724201541.801099-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

---
v2 - incorporate Bruce's suggestion
   - add MAINTAINERS change

 MAINTAINERS                       |   2 +-
 app/test/suites/meson.build       |   2 +-
 app/test/suites/test_telemetry.py | 168 ++++++++++++++++++++++++++++++
 app/test/suites/test_telemetry.sh |  30 ------
 4 files changed, 170 insertions(+), 32 deletions(-)
 create mode 100644 app/test/suites/test_telemetry.py
 delete mode 100755 app/test/suites/test_telemetry.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..e978b068ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1912,7 +1912,7 @@ M: Bruce Richardson <bruce.richardson@intel.com>
 F: lib/telemetry/
 F: doc/guides/prog_guide/telemetry_lib.rst
 F: app/test/test_telemetry*
-F: app/test/suites/test_telemetry.sh
+F: app/test/suites/test_telemetry.*
 F: usertools/dpdk-telemetry*
 F: doc/guides/howto/telemetry.rst
 
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
new file mode 100644
index 0000000000..68490d8fe4
--- /dev/null
+++ b/app/test/suites/test_telemetry.py
@@ -0,0 +1,168 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2022 Red Hat, Inc.
+
+"""Exercise every telemetry command exported by an application.
+
+Spawns the DPDK test binary (passed as arguments), waits for its telemetry
+socket to appear, then walks every command reported by "/". Every reply is
+parsed as JSON and checked, so a malformed, empty or missing response fails
+the test immediately and names the offending command.
+
+Commands are called with dummy parameters ("", "0" and "z"). In addition,
+any node of the form /*dev/list is queried first and the identifiers it
+returns are passed to the other nodes in the same namespace (/*dev/info,
+/*dev/stats, /*dev/xstats, ...), so those are exercised with real arguments
+rather than only rejecting garbage. The dummy parameters remain the fallback
+for anything not matching that pattern.
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
+DUMMY_ARGS = ("", ",0", ",z")
+LIST_SUFFIX = "/list"
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
+def device_ids(client, listing):
+    """Map namespace to identifiers, from the /*dev/list nodes.
+
+    /ethdev/list, /cryptodev/list and friends take no parameter and return
+    the identifiers accepted by the other nodes under the same namespace.
+    """
+    devices = {}
+    for cmd in listing:
+        if not cmd.endswith(LIST_SUFFIX):
+            continue
+        namespace = cmd[: -len(LIST_SUFFIX)]
+        if not namespace.endswith("dev"):
+            continue
+        reply = client.command(cmd)
+        check_reply(cmd, reply)
+        ids = reply[cmd]
+        if isinstance(ids, list):
+            devices[namespace] = ids
+    return devices
+
+
+def args_for(cmd, devices):
+    """Parameters to try for a command: real identifiers where known."""
+    if cmd.endswith(LIST_SUFFIX):
+        return DUMMY_ARGS
+    for namespace, ids in devices.items():
+        if cmd.startswith(namespace + "/"):
+            return DUMMY_ARGS + tuple("," + str(i) for i in ids)
+    return DUMMY_ARGS
+
+
+def walk(client):
+    listing = client.command("/")
+    check_reply("/", listing)
+    devices = device_ids(client, listing["/"])
+    count = 0
+    for cmd in listing["/"]:
+        for arg in args_for(cmd, devices):
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

