Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E060CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 14:19:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E56942DDF;
	Fri, 17 Oct 2025 16:19:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C75A340269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 16:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760710774; x=1792246774;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MMQ6I0LN48EUIaUZb+rAvOh5HtjUdmf/U+dh3ugp6S4=;
 b=dWDzT7ybu93t2wm6DoextMk/qhwECc/LwbtxKRNy15EcujXOkfXRyQ1q
 GQm06ncnj6+8LrE4FVTgSBj3q5gawLgTZz61hKhZSE+MIAkMFKnwHePMs
 nM6S8Sy0uq8ziDA6NV4N4+U+PG3THCZp98UsJxfhFiUjl1d7g7Wgxu+U0
 TTtCdXgOjnVXuk7S5Q4Qp3gHiX0IB+1bV8J41DAOPF1+B7lVmmwxVdkdb
 SW7JWNUvuzvGQ9ioiDIeWTwgWHed9kFokLPljmkTE5m70ScnrabRpo7kk
 pg7xQzZv91FIKx7SnzIQajqC9QEYIMU/2xT4cybapnak7nmcFU818+isQ A==;
X-CSE-ConnectionGUID: gV24h7MhTyCbshperV5mjg==
X-CSE-MsgGUID: n9mo+LjLS+CE3wV1nJoVng==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63011639"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="63011639"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 07:19:33 -0700
X-CSE-ConnectionGUID: kN4YUJA3QMuxIwMicPrR5w==
X-CSE-MsgGUID: SdQyggbwS7+bOhpoi8ZxNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="187840838"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 17 Oct 2025 07:19:32 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/2] usertools/dpdk-telemetry-client: correct script
 formatting
Date: Fri, 17 Oct 2025 15:19:27 +0100
Message-ID: <20251017141927.1156370-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251017141927.1156370-1-bruce.richardson@intel.com>
References: <20251017135622.1152341-1-bruce.richardson@intel.com>
 <20251017141927.1156370-1-bruce.richardson@intel.com>
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

Auto-format the dpdk-telemetry-client script using "black" tool, to
ensure it meets default DPDK python formatting style.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-telemetry-client.py | 49 +++++++++++++++++-------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/usertools/dpdk-telemetry-client.py b/usertools/dpdk-telemetry-client.py
index e3bb1c9ee0..f65d2e0be4 100755
--- a/usertools/dpdk-telemetry-client.py
+++ b/usertools/dpdk-telemetry-client.py
@@ -9,13 +9,13 @@
 
 BUFFER_SIZE = 200000
 
-METRICS_REQ = "{\"action\":0,\"command\":\"ports_all_stat_values\",\"data\":null}"
-API_REG = "{\"action\":1,\"command\":\"clients\",\"data\":{\"client_path\":\""
-API_UNREG = "{\"action\":2,\"command\":\"clients\",\"data\":{\"client_path\":\""
-GLOBAL_METRICS_REQ = "{\"action\":0,\"command\":\"global_stat_values\",\"data\":null}"
+METRICS_REQ = '{"action":0,"command":"ports_all_stat_values","data":null}'
+API_REG = '{"action":1,"command":"clients","data":{"client_path":"'
+API_UNREG = '{"action":2,"command":"clients","data":{"client_path":"'
+GLOBAL_METRICS_REQ = '{"action":0,"command":"global_stat_values","data":null}'
 DEFAULT_FP = "/var/run/dpdk/default_client"
-DEFAULT_PREFIX = 'rte'
-RUNTIME_SOCKET_NAME = 'telemetry'
+DEFAULT_PREFIX = "rte"
+RUNTIME_SOCKET_NAME = "telemetry"
 
 
 class Socket:
@@ -56,8 +56,7 @@ def getFilepath(self, file_path):
         self.file_path = file_path
 
     def setRunpath(self, file_prefix):
-        self.run_path = os.path.join(get_dpdk_runtime_dir(file_prefix),
-                                     RUNTIME_SOCKET_NAME)
+        self.run_path = os.path.join(get_dpdk_runtime_dir(file_prefix), RUNTIME_SOCKET_NAME)
 
     def register(self):
         # Connects a client to DPDK-instance
@@ -69,7 +68,7 @@ def register(self):
             print("Error - Socket binding error: " + str(msg) + "\n")
         self.socket.recv_fd.settimeout(2)
         self.socket.send_fd.connect(self.run_path)
-        JSON = (API_REG + self.file_path + "\"}}")
+        JSON = API_REG + self.file_path + '"}}'
         self.socket.send_fd.sendall(JSON.encode())
 
         self.socket.recv_fd.listen(1)
@@ -77,7 +76,7 @@ def register(self):
 
     def unregister(self):
         # Unregister a given client
-        self.socket.client_fd.send((API_UNREG + self.file_path + "\"}}").encode())
+        self.socket.client_fd.send((API_UNREG + self.file_path + '"}}').encode())
         self.socket.client_fd.close()
 
     def requestMetrics(self):
@@ -133,25 +132,33 @@ def interactiveMenu(self, sleep_time):
 
 
 def get_dpdk_runtime_dir(fp):
-    """ Using the same logic as in DPDK's EAL, get the DPDK runtime directory
-    based on the file-prefix and user """
-    run_dir = os.environ.get('RUNTIME_DIRECTORY')
+    """Using the same logic as in DPDK's EAL, get the DPDK runtime directory
+    based on the file-prefix and user"""
+    run_dir = os.environ.get("RUNTIME_DIRECTORY")
     if not run_dir:
-        if (os.getuid() == 0):
-            run_dir = '/var/run'
+        if os.getuid() == 0:
+            run_dir = "/var/run"
         else:
-            run_dir = os.environ.get('XDG_RUNTIME_DIR', '/tmp')
-    return os.path.join(run_dir, 'dpdk', fp)
+            run_dir = os.environ.get("XDG_RUNTIME_DIR", "/tmp")
+    return os.path.join(run_dir, "dpdk", fp)
 
 
 if __name__ == "__main__":
 
     sleep_time = 1
     parser = argparse.ArgumentParser()
-    parser.add_argument('-f', '--file-prefix', default=DEFAULT_PREFIX,
-                        help='Provide file-prefix for DPDK runtime directory')
-    parser.add_argument('sock_path', nargs='?', default=DEFAULT_FP,
-                        help='Provide socket file path connected by legacy client')
+    parser.add_argument(
+        "-f",
+        "--file-prefix",
+        default=DEFAULT_PREFIX,
+        help="Provide file-prefix for DPDK runtime directory",
+    )
+    parser.add_argument(
+        "sock_path",
+        nargs="?",
+        default=DEFAULT_FP,
+        help="Provide socket file path connected by legacy client",
+    )
     args = parser.parse_args()
 
     client = Client()
-- 
2.48.1

