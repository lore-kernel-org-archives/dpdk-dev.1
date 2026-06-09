Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87056CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 16:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41FEF40695;
	Tue,  9 Jun 2026 18:14:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 894BB400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 18:14:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781021652; x=1812557652;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hw5UsMw45Jemm5cZcokT5dhxOZIcMS1bav5nK9x+gS8=;
 b=E+PcYZ53bM8pW2VmKndy6ge9N9f2+2xFjl/xuAlKv7AluXm5Gh/ath9K
 ZaY7KPS09jrETKVjtlWHTyv/04apRO/q+1Qctia7FtDB0Se/7HOfdX2FE
 ZLH/Nl2uSV1JX+EbCjhhunkmGoxToEiWg2PWPPvp1BIlIMFRFhm4qUJcC
 dL+1JUdUNRB5o4lU6VQ61l45GrDcF21f1idocVmrNrdjPmYEfkAI12p1N
 HkMYEeqQDzAF0yLMLL5cXEGqbTyX0XJFuaHDRwMtRfklEYyELJ9pBmZbx
 GxXSJ5ePG3sfWiXs6DQdpNLxR5Fx/PMRwoMMjH1UMqNFte8/EGJm4CL9c w==;
X-CSE-ConnectionGUID: V7okmYKrQrmaToWi0yftYQ==
X-CSE-MsgGUID: Ii+cG1SlStC6J8j/PM12Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="80809688"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="80809688"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:14:11 -0700
X-CSE-ConnectionGUID: Rx9koRZFQ3+HoaHUv9hpLA==
X-CSE-MsgGUID: G9dP9Gw/SyOAc5YVVIr3dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="249830077"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 09 Jun 2026 09:14:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: fengchengwen@huawei.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/3] usertools/telemetry: support using aliases for long
 commands
Date: Tue,  9 Jun 2026 17:13:59 +0100
Message-ID: <20260609161400.3661268-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609161400.3661268-1-bruce.richardson@intel.com>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260609161400.3661268-1-bruce.richardson@intel.com>
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

Similarly to how shell aliases work, allow specifying of short alias
commands for dpdk-telemetry.py script. The aliases are read from
"$HOME/.dpdk_telemetry_aliases" at startup.

Some examples of use from the docs. Alias file contents:

  # Basic shortcuts
  ls=/ethdev/list
  names=FOREACH i /ethdev/list /ethdev/info,$i .name
  q=quit

Alias use:

   --> ls
  {"/ethdev/list": [0, 1]}

  --> names
  [{"i": 0, "name": "0000:

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2: added support for providing an alias path on cmdline.
    added summary printout of how many aliases were loaded.
---
 doc/guides/howto/telemetry.rst | 35 ++++++++++++++
 usertools/dpdk-telemetry.py    | 85 ++++++++++++++++++++++++++++++++--
 2 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
index 4bf48c635e..bdefbdc6a6 100644
--- a/doc/guides/howto/telemetry.rst
+++ b/doc/guides/howto/telemetry.rst
@@ -130,6 +130,41 @@ and query information using the telemetry client python script.
      - With loop variable: returns an array of objects containing the loop
        variable field and requested value fields.
 
+   * Use command aliases.
+
+     The telemetry script can load aliases at startup from::
+
+        $HOME/.dpdk_telemetry_aliases
+
+     or from a custom path provided via the ``--alias-file`` script flag.
+     Each alias entry must be in ``alias=command`` format.
+     Empty lines and lines starting with ``#`` are ignored.
+
+     Example alias file::
+
+        # Basic shortcuts
+        ls=/ethdev/list
+        names=FOREACH i /ethdev/list /ethdev/info,$i .name
+        q=quit
+
+     Alias behavior is intentionally similar to shell aliases:
+
+     - The first token of the entered input is checked for an alias match.
+     - If matched, that first token is replaced with its expansion.
+     - Alias expansion is recursive (aliases can expand to other aliases).
+     - Expansion has a safety limit to prevent infinite loops.
+
+     Examples::
+
+        --> ls
+        {"/ethdev/list": [0, 1]}
+
+        --> names
+        [{"i": 0, "name": "0000:16:00.0"}, {"i": 1, "name": "0000:16:00.1"}]
+
+        --> q
+        # exits the client
+
 
 Connecting to Different DPDK Processes
 --------------------------------------
diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
index 2de10cff69..7a25b78730 100755
--- a/usertools/dpdk-telemetry.py
+++ b/usertools/dpdk-telemetry.py
@@ -21,6 +21,76 @@
 SOCKET_NAME = "dpdk_telemetry.{}".format(TELEMETRY_VERSION)
 DEFAULT_PREFIX = "rte"
 CMDS = []
+ALIASES = {}
+ALIAS_FILE = ".dpdk_telemetry_aliases"
+MAX_ALIAS_EXPANSIONS = 32
+
+
+def load_aliases(alias_path=None):
+    """Load aliases from $HOME/.dpdk_telemetry_aliases or a custom path if provided"""
+    aliases = {}
+    if alias_path and not os.path.isfile(alias_path):
+        print("Warning: alias file {} not found, skipping".format(alias_path), file=sys.stderr)
+        return aliases
+
+    if not alias_path:
+        home = os.environ.get("HOME")
+        if not home:
+            return aliases
+
+        alias_path = os.path.join(home, ALIAS_FILE)
+        if not os.path.isfile(alias_path):
+            return aliases
+
+    try:
+        with open(alias_path) as alias_file:
+            for line_num, line in enumerate(alias_file, start=1):
+                entry = line.strip()
+                if not entry or entry.startswith("#"):
+                    continue
+                if "=" not in entry:
+                    print(
+                        "Warning: ignoring malformed alias at {}:{}".format(alias_path, line_num),
+                        file=sys.stderr,
+                    )
+                    continue
+                name, command = entry.split("=", 1)
+                name = name.strip()
+                command = command.strip()
+                if not name or not command:
+                    print(
+                        "Warning: ignoring malformed alias at {}:{}".format(alias_path, line_num),
+                        file=sys.stderr,
+                    )
+                    continue
+                aliases[name] = command
+    except OSError as e:
+        print("Warning: failed to read {}: {}".format(alias_path, e), file=sys.stderr)
+
+    print("Loaded {} aliases from {}".format(len(aliases), alias_path))
+    return aliases
+
+
+def expand_aliases(text, aliases):
+    """Expand aliases similarly to shell aliases on the first token"""
+    expanded = text
+    for _ in range(MAX_ALIAS_EXPANSIONS):
+        stripped = expanded.lstrip()
+        if not stripped:
+            return expanded
+
+        parts = stripped.split(None, 1)
+        first = parts[0]
+        rest = parts[1] if len(parts) > 1 else ""
+
+        if first not in aliases:
+            return expanded
+
+        alias_value = aliases[first]
+        expanded = "{} {}".format(alias_value, rest).strip() if rest else alias_value
+
+    print("Warning: alias expansion limit reached", file=sys.stderr)
+    return expanded
 
 
 def send_command(sock, cmd, output_buf_len, echo=False, pretty=False):
@@ -262,10 +332,12 @@ def handle_socket(args, path):
 
     # interactive prompt
     try:
-        text = input(prompt).strip()
-        while text != "quit":
-            handle_command(sock, output_buf_len, text, pretty=prompt)
+        while True:
             text = input(prompt).strip()
+            expanded = expand_aliases(text, ALIASES)
+            if expanded == "quit":
+                break
+            handle_command(sock, output_buf_len, expanded, pretty=prompt)
     except EOFError:
         pass
     finally:
@@ -274,7 +346,7 @@ def handle_socket(args, path):
 
 def readline_complete(text, state):
     """Find any matching commands from the list based on user input"""
-    all_cmds = ["quit"] + CMDS
+    all_cmds = ["quit"] + list(ALIASES.keys()) + CMDS
     if text:
         matches = [c for c in all_cmds if c.startswith(text)]
     else:
@@ -293,6 +365,10 @@ def readline_complete(text, state):
     default=DEFAULT_PREFIX,
     help="Provide file-prefix for DPDK runtime directory",
 )
+parser.add_argument(
+    "--alias-file",
+    help=f"Provide a custom alias file instead of $HOME/{ALIAS_FILE}",
+)
 parser.add_argument(
     "-i", "--instance", default="0", type=int, help="Provide instance number for DPDK application"
 )
@@ -304,6 +380,7 @@ def readline_complete(text, state):
     help="List all possible file-prefixes and exit",
 )
 args = parser.parse_args()
+ALIASES = load_aliases(args.alias_file if args.alias_file else None)
 if args.list:
     list_fp()
     sys.exit(0)
-- 
2.53.0

