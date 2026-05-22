Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC66CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 13:37:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA1BE40649;
	Fri, 22 May 2026 15:37:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E1E1C40649
 for <dev@dpdk.org>; Fri, 22 May 2026 15:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779457042; x=1810993042;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kVy4HjjlPfqbj4r5ghVkA/fIOP07aOIbXt6kwpwK3BY=;
 b=XVldl5rgIfLNtJkqDabThJS7fx4Dqd57zarNboSJkLVfUGY9N1jby1oL
 doJtvmDRsYJzuSjBdPoYoE0pvLijMH7goPndJyAVNd5QfVTzNCTiMdqZb
 M8VRlH1CFMKbepb5/0OCMYY5O7lJmhy0z9T04qayRZRnlbzA99fWtEMC3
 VQMIddAGT66rrEOnX0rDlZb9yjYN7L3jd8zHeN8SXv1iRAYRyyi8kEwVP
 O3vkNCT96ZVKvyvLqAtDq9W6+RtcJHDQFEVzjygLhd0UMBobCiVyspNN5
 v1e8ljhPg6PAk74jdfbMGQRygQ2za+fCCAJORONy5Li/MS3rCdJb/HAQ3 Q==;
X-CSE-ConnectionGUID: BygJn5d7Sx2olKg+3MHtGw==
X-CSE-MsgGUID: OBMkvvXmQPKpFy5mQGUgaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80237493"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80237493"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 06:37:21 -0700
X-CSE-ConnectionGUID: JS3lENk2Tra94CdkyqR1cQ==
X-CSE-MsgGUID: NA4l2dfeR3C1ykEXaa9WdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="241145344"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 22 May 2026 06:37:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: fengchengwen@huawei.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] usertools/telemetry: add help support
Date: Fri, 22 May 2026 14:37:13 +0100
Message-ID: <20260522133714.133268-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522133714.133268-1-bruce.richardson@intel.com>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260522133714.133268-1-bruce.richardson@intel.com>
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
 usertools/dpdk-telemetry.py | 61 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
index 8b976160e0..2c88b91517 100755
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
 
 def load_aliases():
     """Load aliases from $HOME/.dpdk_telemetry_aliases"""
@@ -203,10 +223,49 @@ def handle_foreach(sock, output_buf_len, text, pretty=False):
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
 
@@ -340,7 +399,7 @@ def handle_socket(args, path):
 
 def readline_complete(text, state):
     """Find any matching commands from the list based on user input"""
-    all_cmds = ["quit"] + list(ALIASES.keys()) + CMDS
+    all_cmds = ["quit", "help"] + list(ALIASES.keys()) + CMDS
     if text:
         matches = [c for c in all_cmds if c.startswith(text)]
     else:
-- 
2.53.0

