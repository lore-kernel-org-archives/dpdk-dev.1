Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B280BCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 16:14:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30B8440665;
	Tue,  9 Jun 2026 18:14:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B8050400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 18:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781021653; x=1812557653;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hFC29jXxi6oOmG3TmztZvmIqZI/0g1ylWh4rrcROZto=;
 b=AlLGCT6HGzvoRv/ihMVHY/TW8iNmuclcS7gA68RSo2aPEg4F2aCnq4yu
 gyf19oLgdWnf1EcJFU0CD+mF3v1lI3HrLB8WsvNqyDAAq++hvLwl5BRDv
 VmrjdHYnLn9CGmHGMe/SAp/8p1pN0gzb91+aMSxlf/LqI3EnFptPWbFSe
 UNeLX4Go2nhYKi6drT+tPCodHrNwZbMUq/66flGdu123xkUztxEZYpz1e
 a/F72Gq8EcsauPeGZebiiDR1Cp6jUfVL4P63y9M94UNCm3f4Slj2RabRl
 pssSGWWe0BiEzoevMGqJl3heF9x0Zwoj0YN3fDp7Tbq4lv/r7BfAGRNz3 w==;
X-CSE-ConnectionGUID: wY8DLTbaQNyINHxmLecJ0w==
X-CSE-MsgGUID: GfkkxHjQQzeE+dRzXyQ+Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="80809692"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="80809692"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:14:12 -0700
X-CSE-ConnectionGUID: mCa/OAKGRvWvqDDWuxN4xA==
X-CSE-MsgGUID: po0onHqrRnejj9+6jysQiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="249830087"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 09 Jun 2026 09:14:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: fengchengwen@huawei.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 3/3] usertools/telemetry: add help support
Date: Tue,  9 Jun 2026 17:14:00 +0100
Message-ID: <20260609161400.3661268-4-bruce.richardson@intel.com>
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

While the telemetry infrastructure supported using "/help,/<cmd>" to get
help on specific commands, with the addition of script-specific
commands, we needed better help support to explain the use of FOREACH,
and to allow e.g. "help /<cmd>" using space separation, which is more
intuitive. This patch adds that help support.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2: added "help aliases" to list defined aliases
    updated docs for expanded help command
---
 doc/guides/howto/telemetry.rst | 31 ++++++++++++---
 usertools/dpdk-telemetry.py    | 69 +++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
index bdefbdc6a6..00cfc1a1e1 100644
--- a/doc/guides/howto/telemetry.rst
+++ b/doc/guides/howto/telemetry.rst
@@ -81,12 +81,31 @@ and query information using the telemetry client python script.
        ...
        "tx_priority7_xon_to_xoff_packets": 0}}
 
-   * Get the help text for a command. This will indicate what parameters are
-     required. Pass the command as a parameter::
-
-       --> /help,/ethdev/xstats
-       {"/help": {"/ethdev/xstats": "Returns the extended stats for a port.
-       Parameters: int port_id"}}
+   * Get the help text for a command.
+     This will indicate what parameters are required.
+     Use the ``help`` keyword followed by the command or keyword of interest,
+     for example::
+
+       --> help FOREACH
+       FOREACH usage:
+          FOREACH /<list_cmd> /<iter_cmd> .<field> [.<field> ...]
+          FOREACH <var> /<list_cmd> /<iter_cmd_with_$var> .<field> [.<field> ...]
+
+       Examples:
+          FOREACH /ethdev/list /ethdev/stats .opackets
+          ...
+
+       --> help /ethdev/xstats
+       {"/help": {"/ethdev/xstats": "Returns the extended stats for a port. Parameters: int port_id"}}
+
+   ..  Note::
+         For commands starting with ``/`` that are telemetry enpoints,
+         the help text can also be obtained by sending the ``/help`` command to the telemetry socket.
+         In this case, the parameter must be separated by a comma, not a space.
+         For example::
+
+           --> /help,/ethdev/xstats
+           {"/help": {"/ethdev/xstats": "Returns the extended stats for a port. Parameters: int port_id"}}
 
    * Run a compound query using ``FOREACH``.
 
diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
index 7a25b78730..20627b596b 100755
--- a/usertools/dpdk-telemetry.py
+++ b/usertools/dpdk-telemetry.py
@@ -25,6 +25,26 @@
 ALIAS_FILE = ".dpdk_telemetry_aliases"
 MAX_ALIAS_EXPANSIONS = 32
 
+BASIC_HELP_TEXT = """Basic usage:
+    /<command>[,<params>]      Send a telemetry command to the app
+    FOREACH ...                Run a compound query over list items
+    help                       Show this help
+    help /<command>            Show app-provided help for a command
+    help FOREACH               Show FOREACH usage and examples
+    quit                       Exit the client
+"""
+
+FOREACH_HELP_TEXT = """FOREACH usage:
+    FOREACH /<list_cmd> /<iter_cmd> .<field> [.<field> ...]
+    FOREACH <var> /<list_cmd> /<iter_cmd_with_$var> .<field> [.<field> ...]
+
+Examples:
+    FOREACH /ethdev/list /ethdev/stats .opackets
+    FOREACH /ethdev/list /ethdev/stats .ipackets .opackets
+    FOREACH i /ethdev/list /ethdev/info,$i .name
+    FOREACH i /ethdev/list /ethdev/stats,$i .ipackets .opackets
+"""
+
 
 def load_aliases(alias_path=None):
     """Load aliases from $HOME/.dpdk_telemetry_aliases or a custom path if provided"""
@@ -209,10 +229,57 @@ def handle_foreach(sock, output_buf_len, text, pretty=False):
     print(json.dumps(output, indent=indent))
 
 
+def command_exists(cmd):
+    """Check if a telemetry command exists in the command list"""
+    return cmd in CMDS
+
+
+def app_help_command_for(target_cmd):
+    """Build a '/help,<command>' query for app-side command help"""
+    if not target_cmd:
+        return None
+    normalized = target_cmd.strip()
+    if not normalized.startswith("/"):
+        return None
+    if not command_exists(normalized):
+        print("Unknown command for help: {}".format(normalized))
+        return None
+    return "/help,{}".format(normalized)
+
+
+def handle_user_help(sock, output_buf_len, text, pretty=False):
+    """Handle local 'help' command and command-specific help lookup"""
+    parts = text.split(None, 1)
+    if len(parts) == 1:
+        print(BASIC_HELP_TEXT, end="")
+        return
+
+    help_arg = parts[1].strip()
+    if help_arg.upper() == "FOREACH":
+        print(FOREACH_HELP_TEXT, end="")
+        return
+    elif help_arg.lower() == "alias" or help_arg.lower() == "aliases":
+        if not ALIASES:
+            print("No aliases defined")
+            return
+        print("Defined aliases:")
+        for name, command in ALIASES.items():
+            print(f"  {name}='{command}'")
+        return
+
+    cmd = app_help_command_for(help_arg)
+    if cmd is None:
+        print("Usage: help [FOREACH|/<command>]")
+        return
+    send_command(sock, cmd, output_buf_len, echo=True, pretty=pretty)
+
+
 def handle_command(sock, output_buf_len, text, pretty=False):
     """Execute a user command if recognized"""
     if text.startswith("/"):
         send_command(sock, text, output_buf_len, echo=True, pretty=pretty)
+    elif text == "help" or text.startswith("help "):
+        handle_user_help(sock, output_buf_len, text, pretty)
     elif text.startswith("FOREACH "):
         handle_foreach(sock, output_buf_len, text, pretty)
 
@@ -346,7 +413,7 @@ def handle_socket(args, path):
 
 def readline_complete(text, state):
     """Find any matching commands from the list based on user input"""
-    all_cmds = ["quit"] + list(ALIASES.keys()) + CMDS
+    all_cmds = ["quit", "help"] + list(ALIASES.keys()) + CMDS
     if text:
         matches = [c for c in all_cmds if c.startswith(text)]
     else:
-- 
2.53.0

