Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA2CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 14:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97C1342DC1;
	Fri, 17 Oct 2025 16:19:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0E11440269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 16:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760710773; x=1792246773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bcDNiJZpIR74kbRAa+k3peTe5BzgkQ+VdepccfVIz0g=;
 b=j5AZzq/uInPg4Ez1Gy/CrLchHsK5JXfDhQVcHzo5ub5cXE1Xq4oG9JLc
 HNxk1+yJCoWt1Cjl13o8crkLnB8fzp1fBspvNg0/rw1b/+tK8335vHbn1
 ftkt4J5m18HFxhePQP1HNk9LA5Q54Fpj9SJ4HFoG0P4TOjw0ghLRxXR0q
 HsUPtsOhAS69BUZqY+Sx/RjM2RceduYmT44ymvaXEFz2hTsYVonS6zbVC
 csfqWg3gFmadKOomBz6yNKt+QwnhqI7cAotnZYrBvShOlUV0Qb6i6Ohx9
 pO3kIaVUU6R1B8185/FyvS+KDA3UzqfLbUH/Z6Zh6eYK3/dfv53ApwTdA Q==;
X-CSE-ConnectionGUID: KHWoTVKZSt+dxQ7YoXfEnw==
X-CSE-MsgGUID: i3JtnJ/OTVyQbwkXkfIfug==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63011637"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="63011637"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 07:19:32 -0700
X-CSE-ConnectionGUID: VRQXXCGeQ5edW973ZmWcdA==
X-CSE-MsgGUID: 0OMZ29FVQNCguPevGLemOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="187840835"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 17 Oct 2025 07:19:31 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/2] usertools/dpdk-telemetry.py: correct script formatting
Date: Fri, 17 Oct 2025 15:19:26 +0100
Message-ID: <20251017141927.1156370-2-bruce.richardson@intel.com>
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

Auto-format the dpdk-telemetry script using "black" tool, to ensure it
meets default DPDK python formatting style. Allow line lengths up to 100
chars rather than default 88.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-telemetry.py | 86 ++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
index 568f222a03..09258a1f7e 100755
--- a/usertools/dpdk-telemetry.py
+++ b/usertools/dpdk-telemetry.py
@@ -18,13 +18,13 @@
 
 # global vars
 TELEMETRY_VERSION = "v2"
-SOCKET_NAME = 'dpdk_telemetry.{}'.format(TELEMETRY_VERSION)
-DEFAULT_PREFIX = 'rte'
+SOCKET_NAME = "dpdk_telemetry.{}".format(TELEMETRY_VERSION)
+DEFAULT_PREFIX = "rte"
 CMDS = []
 
 
 def read_socket(sock, buf_len, echo=True, pretty=False):
-    """ Read data from socket and return it in JSON format """
+    """Read data from socket and return it in JSON format"""
     reply = sock.recv(buf_len).decode()
     try:
         ret = json.loads(reply)
@@ -39,11 +39,11 @@ def read_socket(sock, buf_len, echo=True, pretty=False):
 
 
 def get_app_name(pid):
-    """ return the app name for a given PID, for printing """
-    proc_cmdline = os.path.join('/proc', str(pid), 'cmdline')
+    """return the app name for a given PID, for printing"""
+    proc_cmdline = os.path.join("/proc", str(pid), "cmdline")
     try:
         with open(proc_cmdline) as f:
-            argv0 = f.read(1024).split('\0')[0]
+            argv0 = f.read(1024).split("\0")[0]
             return os.path.basename(argv0)
     except IOError as e:
         # ignore file not found errors
@@ -53,41 +53,40 @@ def get_app_name(pid):
 
 
 def find_sockets(path):
-    """ Find any possible sockets to connect to and return them """
-    return glob.glob(os.path.join(path, SOCKET_NAME + '*'))
+    """Find any possible sockets to connect to and return them"""
+    return glob.glob(os.path.join(path, SOCKET_NAME + "*"))
 
 
 def print_socket_options(prefix, paths):
-    """ Given a set of socket paths, give the commands needed to connect """
+    """Given a set of socket paths, give the commands needed to connect"""
     cmd = sys.argv[0]
     if prefix != DEFAULT_PREFIX:
         cmd += " -f " + prefix
     for s in sorted(paths):
         sock_name = os.path.basename(s)
         if sock_name.endswith(TELEMETRY_VERSION):
-            print("- {}  # Connect with '{}'".format(os.path.basename(s),
-                                                     cmd))
+            print("- {}  # Connect with '{}'".format(os.path.basename(s), cmd))
         else:
-            print("- {}  # Connect with '{} -i {}'".format(os.path.basename(s),
-                                                           cmd,
-                                                           s.split(':')[-1]))
+            print(
+                "- {}  # Connect with '{} -i {}'".format(os.path.basename(s), cmd, s.split(":")[-1])
+            )
 
 
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
 
 
 def list_fp():
-    """ List all available file-prefixes to user """
-    path = get_dpdk_runtime_dir('')
+    """List all available file-prefixes to user"""
+    path = get_dpdk_runtime_dir("")
     sockets = glob.glob(os.path.join(path, "*", SOCKET_NAME + "*"))
     prefixes = []
     if not sockets:
@@ -98,18 +97,17 @@ def list_fp():
         prefixes.append(os.path.relpath(os.path.dirname(s), start=path))
     for p in sorted(set(prefixes)):
         print(p)
-        print_socket_options(p, glob.glob(os.path.join(path, p,
-                                                       SOCKET_NAME + "*")))
+        print_socket_options(p, glob.glob(os.path.join(path, p, SOCKET_NAME + "*")))
 
 
 def handle_socket(args, path):
-    """ Connect to socket and handle user input """
-    prompt = ''  # this evaluates to false in conditions
+    """Connect to socket and handle user input"""
+    prompt = ""  # this evaluates to false in conditions
     sock = socket.socket(socket.AF_UNIX, socket.SOCK_SEQPACKET)
     global CMDS
 
     if os.isatty(sys.stdin.fileno()):
-        prompt = '--> '
+        prompt = "--> "
         print("Connecting to " + path)
     try:
         sock.connect(path)
@@ -142,7 +140,7 @@ def handle_socket(args, path):
     try:
         text = input(prompt).strip()
         while text != "quit":
-            if text.startswith('/'):
+            if text.startswith("/"):
                 sock.send(text.encode())
                 read_socket(sock, output_buf_len, pretty=prompt)
             text = input(prompt).strip()
@@ -153,8 +151,8 @@ def handle_socket(args, path):
 
 
 def readline_complete(text, state):
-    """ Find any matching commands from the list based on user input """
-    all_cmds = ['quit'] + CMDS
+    """Find any matching commands from the list based on user input"""
+    all_cmds = ["quit"] + CMDS
     if text:
         matches = [c for c in all_cmds if c.startswith(text)]
     else:
@@ -162,17 +160,27 @@ def readline_complete(text, state):
     return matches[state]
 
 
-readline.parse_and_bind('tab: complete')
+readline.parse_and_bind("tab: complete")
 readline.set_completer(readline_complete)
-readline.set_completer_delims(readline.get_completer_delims().replace('/', ''))
+readline.set_completer_delims(readline.get_completer_delims().replace("/", ""))
 
 parser = argparse.ArgumentParser()
-parser.add_argument('-f', '--file-prefix', default=DEFAULT_PREFIX,
-                    help='Provide file-prefix for DPDK runtime directory')
-parser.add_argument('-i', '--instance', default='0', type=int,
-                    help='Provide instance number for DPDK application')
-parser.add_argument('-l', '--list', action="store_true", default=False,
-                    help='List all possible file-prefixes and exit')
+parser.add_argument(
+    "-f",
+    "--file-prefix",
+    default=DEFAULT_PREFIX,
+    help="Provide file-prefix for DPDK runtime directory",
+)
+parser.add_argument(
+    "-i", "--instance", default="0", type=int, help="Provide instance number for DPDK application"
+)
+parser.add_argument(
+    "-l",
+    "--list",
+    action="store_true",
+    default=False,
+    help="List all possible file-prefixes and exit",
+)
 args = parser.parse_args()
 if args.list:
     list_fp()
-- 
2.48.1

