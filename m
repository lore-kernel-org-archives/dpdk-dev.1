Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9953ECD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:39:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 958924065D;
	Thu, 21 May 2026 17:39:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id DDBDD400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 17:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779377977; x=1810913977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KlAhP+MIMg2W1hO5Xnipz+yJg3PHUvDo9r6YbXMLNlQ=;
 b=UTaVr7g8vA+rstjRsCOKtm1W55hgTyAwR5gb4A/gb+Osl5Z9Y3rmKpbI
 9vA4lLKs10dEDWKDpdWauHFemobvkh44IyrMcMkKlIBwvIgVKlWNxVxeg
 eHy9ts/EG2YAavGtOsc35AsEWfnOX9WgG3QDNiEeofhNagFnWACClK/84
 D/uUUumiTQSrNg/7HwDxd1yk9mZaXiFpKXjagjjaTtp3yr7AkHjwUSl7p
 4XTo9UfpH+SuPOfUQFnWdFYphaIZeK/j2xSKdoxO0tKAgR4W2V6hBTF3J
 lPOFxJryXNF7Y9OEvEpHTgX+57G+GM5MVR/0L7LMgAg6fO0v/+/Oa8w1r Q==;
X-CSE-ConnectionGUID: 9OXKZNd7Qs2dwGxMZkccoQ==
X-CSE-MsgGUID: hdVWqb5yRNytIc2isu85og==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80353610"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="80353610"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 08:39:36 -0700
X-CSE-ConnectionGUID: jm9M35puSMCYyD9LHNqrww==
X-CSE-MsgGUID: tAEtcfgeR0CWZhhhgToesg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="278672034"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 May 2026 08:39:36 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/2] usertools/telemetry: support using aliases for long
 commands
Date: Thu, 21 May 2026 16:39:13 +0100
Message-ID: <20260521153913.82634-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521153913.82634-1-bruce.richardson@intel.com>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
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
 doc/guides/howto/telemetry.rst | 34 +++++++++++++++
 usertools/dpdk-telemetry.py    | 75 ++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
index 4bf48c635e..072289aec8 100644
--- a/doc/guides/howto/telemetry.rst
+++ b/doc/guides/howto/telemetry.rst
@@ -130,6 +130,40 @@ and query information using the telemetry client python script.
      - With loop variable: returns an array of objects containing the loop
        variable field and requested value fields.
 
+   * Use command aliases.
+
+     The telemetry script can load aliases at startup from::
+
+        $HOME/.dpdk_telemetry_aliases
+
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
index 2de10cff69..8b976160e0 100755
--- a/usertools/dpdk-telemetry.py
+++ b/usertools/dpdk-telemetry.py
@@ -21,6 +21,70 @@
 SOCKET_NAME = "dpdk_telemetry.{}".format(TELEMETRY_VERSION)
 DEFAULT_PREFIX = "rte"
 CMDS = []
+ALIASES = {}
+ALIAS_FILE = ".dpdk_telemetry_aliases"
+MAX_ALIAS_EXPANSIONS = 32
+
+
+def load_aliases():
+    """Load aliases from $HOME/.dpdk_telemetry_aliases"""
+    aliases = {}
+    home = os.environ.get("HOME")
+    if not home:
+        return aliases
+
+    alias_path = os.path.join(home, ALIAS_FILE)
+    if not os.path.isfile(alias_path):
+        return aliases
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
@@ -262,10 +326,12 @@ def handle_socket(args, path):
 
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
@@ -274,7 +340,7 @@ def handle_socket(args, path):
 
 def readline_complete(text, state):
     """Find any matching commands from the list based on user input"""
-    all_cmds = ["quit"] + CMDS
+    all_cmds = ["quit"] + list(ALIASES.keys()) + CMDS
     if text:
         matches = [c for c in all_cmds if c.startswith(text)]
     else:
@@ -304,6 +370,7 @@ def readline_complete(text, state):
     help="List all possible file-prefixes and exit",
 )
 args = parser.parse_args()
+ALIASES = load_aliases()
 if args.list:
     list_fp()
     sys.exit(0)
-- 
2.53.0

