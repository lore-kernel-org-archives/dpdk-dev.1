Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6369CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:39:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98E054064F;
	Thu, 21 May 2026 17:39:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 207EF400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 17:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779377976; x=1810913976;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fXCKDMr11AQtR0xz6cm9juMR5pgDf0CBVTN65KWfn04=;
 b=SP0GbyMZiskayg1LTA2F1hXWlVpzrm3aY0wLU8Umex+gT8+p1K6iphqA
 nok8AVAcaWtQe8KkLj9HcesNbgoqJ4I/S+zD64MPJ7sljUDrf3aMIanmb
 fiQyzD/YCL4b08FhE9bNteYuRkz5Zuv4QE0swnpgzwvZd8/qF+T/EKX9R
 hOjBItBGw6PF9Tpaxk7Uv0iXMleRr+Q3MwEmx9//6zhbRR+RUAbVT4X/h
 NOw5hwuMPN3kuCNiiGnHRah3kFnMPnykbDJ9tbK1GD+zAu8mjIPVZyfdQ
 cjk1uHLhBjx4SXE3wbdwpnNOgv+HyYEth4pNahBh+gpszmCV8oiR0Mzu4 g==;
X-CSE-ConnectionGUID: Bhsifc0VQ0enDr54HMJKww==
X-CSE-MsgGUID: q1NTWEkOQxOLYH//P1dufg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80353606"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="80353606"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 08:39:35 -0700
X-CSE-ConnectionGUID: uAY71LaESb6fmyWWRVX/OQ==
X-CSE-MsgGUID: DaIN5MgGSJGV80ZEzUkwfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="278672027"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 May 2026 08:39:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] usertools/telemetry: add a FOREACH command
Date: Thu, 21 May 2026 16:39:12 +0100
Message-ID: <20260521153913.82634-2-bruce.richardson@intel.com>
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

To simplify querying data from multiple devices, e.g. across ethdevs, or
dmadevs, add a FOREACH command to the python script, allowing you to
run, e.g. /ethdev/list, and then run a second command for each item in
the list, gathering the relevant output values, optionally including an
index counter.

Simple examples are given in the documentation:

  --> FOREACH /ethdev/list /ethdev/stats .opackets
  [0, 0]

  --> FOREACH /ethdev/list /ethdev/stats .ipackets .opackets
  [{"ipackets": 0, "opackets": 0}, {"ipackets": 0, "opackets": 0}]

  --> FOREACH i /ethdev/list /ethdev/info,$i .name
  [{"i": 0, "name": "0000:16:00.0"}, {"i": 1, "name": "0000:16:00.1"}]

  --> FOREACH i /ethdev/list /ethdev/stats,$i .ipackets .opackets
  [{"i": 0, "ipackets": 0, "opackets": 0}, {"i": 1, "ipackets": 0, "opackets": 0}]

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/howto/telemetry.rst |  42 +++++++++++
 usertools/dpdk-telemetry.py    | 128 ++++++++++++++++++++++++++++++++-
 2 files changed, 167 insertions(+), 3 deletions(-)

diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
index 0464c431fe..4bf48c635e 100644
--- a/doc/guides/howto/telemetry.rst
+++ b/doc/guides/howto/telemetry.rst
@@ -88,6 +88,48 @@ and query information using the telemetry client python script.
        {"/help": {"/ethdev/xstats": "Returns the extended stats for a port.
        Parameters: int port_id"}}
 
+   * Run a compound query using ``FOREACH``.
+
+     The ``FOREACH`` command runs a list command, iterates each returned item,
+     runs a second command for each item, and emits combined JSON output.
+
+     Start with the simplest form (no loop variable)::
+
+        FOREACH /<list_cmd> /<iter_cmd> .<field> [.<field> ...]
+
+     To include numbered output, use a loop variable::
+
+        FOREACH <var> /<list_cmd> /<iter_cmd_with_$var> .<field> [.<field> ...]
+
+     Notes:
+
+     - Field selectors are whitespace-separated tokens, each starting with ``.``.
+     - In no-variable mode, the iter command is called as ``/<iter_cmd>,<item>``.
+     - In loop-variable mode, use ``$<var>`` in the iter command where the
+       item value should be substituted.
+
+     Examples::
+
+        --> FOREACH /ethdev/list /ethdev/stats .opackets
+        [0, 0]
+
+        --> FOREACH /ethdev/list /ethdev/stats .ipackets .opackets
+        [{"ipackets": 0, "opackets": 0}, {"ipackets": 0, "opackets": 0}]
+
+        --> FOREACH i /ethdev/list /ethdev/info,$i .name
+        [{"i": 0, "name": "0000:16:00.0"}, {"i": 1, "name": "0000:16:00.1"}]
+
+        --> FOREACH i /ethdev/list /ethdev/stats,$i .ipackets .opackets
+        [{"i": 0, "ipackets": 0, "opackets": 0}, {"i": 1, "ipackets": 0, "opackets": 0}]
+
+     Output behavior:
+
+     - Without loop variable and one field: returns an array of values.
+     - Without loop variable and multiple fields: returns an array of objects
+       containing named value fields.
+     - With loop variable: returns an array of objects containing the loop
+       variable field and requested value fields.
+
 
 Connecting to Different DPDK Processes
 --------------------------------------
diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
index 09258a1f7e..2de10cff69 100755
--- a/usertools/dpdk-telemetry.py
+++ b/usertools/dpdk-telemetry.py
@@ -23,6 +23,130 @@
 CMDS = []
 
 
+def send_command(sock, cmd, output_buf_len, echo=False, pretty=False):
+    """Send a telemetry command and return the parsed JSON reply"""
+    sock.send(cmd.encode())
+    return read_socket(sock, output_buf_len, echo, pretty)
+
+
+def get_cmd_payload(reply, cmd):
+    """Return the payload for a command response if present"""
+    if isinstance(reply, dict) and len(reply) == 1:
+        return next(iter(reply.values()))
+    return None
+
+
+def get_path_value(payload, path):
+    """Resolve a dotted path (e.g. '.name' or '.a.b') from a JSON payload"""
+    if not path:
+        return payload
+
+    keys = [k for k in path.lstrip(".").split(".") if k]
+    val = payload
+    for key in keys:
+        if not isinstance(val, dict) or key not in val:
+            return None
+        val = val[key]
+    return val
+
+
+def parse_selectors(selector_text):
+    """Parse whitespace-separated dotted selectors"""
+    selectors = selector_text.split()
+    if not selectors:
+        print("Invalid FOREACH syntax: missing selector")
+        return None
+    if any(not selector.startswith(".") for selector in selectors):
+        print("Invalid FOREACH syntax: selector must start with '.'")
+        return None
+    return selectors
+
+
+def parse_foreach(text):
+    """Parse FOREACH [<var>] /<cmd> /<parameterized cmd> .<value> [.<value> ...]"""
+    try:
+        tokens = text.split(None, 3)
+    except ValueError:
+        print("Invalid FOREACH syntax")
+        return None
+
+    if len(tokens) != 4:
+        print("Invalid FOREACH syntax")
+        return None
+
+    _, arg1, arg2, arg3 = tokens
+    if arg1.startswith("/"):
+        var_name = None
+        list_cmd = arg1
+        iter_cmd = arg2
+        selector_text = arg3
+    else:
+        var_name = arg1
+        list_cmd = arg2
+        try:
+            iter_cmd, selector_text = arg3.split(None, 1)
+        except ValueError:
+            print("Invalid FOREACH syntax")
+            return None
+
+    if not list_cmd.startswith("/") or not iter_cmd.startswith("/"):
+        print("Invalid FOREACH syntax: commands must start with '/'")
+        return None
+
+    selectors = parse_selectors(selector_text)
+    if selectors is None:
+        return None
+
+    return var_name, list_cmd, iter_cmd, selectors
+
+
+def build_foreach_result(item, var_name, payload, selectors):
+    """Build one FOREACH result entry based on selector count and index mode"""
+    values = {selector.lstrip("."): get_path_value(payload, selector) for selector in selectors}
+
+    if var_name is None and len(selectors) == 1:
+        return next(iter(values.values()))
+    if var_name is None:
+        return values
+
+    return {var_name: item, **values}
+
+
+def handle_foreach(sock, output_buf_len, text, pretty=False):
+    """Handle FOREACH queries and print telemetry-like JSON array output"""
+    parsed = parse_foreach(text)
+    if parsed is None:
+        return
+    var_name, list_cmd, iter_cmd, selectors = parsed
+
+    list_reply = send_command(sock, list_cmd, output_buf_len)
+    values = get_cmd_payload(list_reply, list_cmd)
+    if not isinstance(values, list):
+        print("FOREACH source command did not return a JSON array")
+        return
+
+    output = []
+    for item in values:
+        if var_name is None:
+            cmd = "{},{}".format(iter_cmd, item)
+        else:
+            cmd = iter_cmd.replace("$" + var_name, str(item))
+        item_reply = send_command(sock, cmd, output_buf_len)
+        item_payload = get_cmd_payload(item_reply, cmd)
+        output.append(build_foreach_result(item, var_name, item_payload, selectors))
+
+    indent = 2 if pretty else None
+    print(json.dumps(output, indent=indent))
+
+
+def handle_command(sock, output_buf_len, text, pretty=False):
+    """Execute a user command if recognized"""
+    if text.startswith("/"):
+        send_command(sock, text, output_buf_len, echo=True, pretty=pretty)
+    elif text.startswith("FOREACH "):
+        handle_foreach(sock, output_buf_len, text, pretty)
+
+
 def read_socket(sock, buf_len, echo=True, pretty=False):
     """Read data from socket and return it in JSON format"""
     reply = sock.recv(buf_len).decode()
@@ -140,9 +264,7 @@ def handle_socket(args, path):
     try:
         text = input(prompt).strip()
         while text != "quit":
-            if text.startswith("/"):
-                sock.send(text.encode())
-                read_socket(sock, output_buf_len, pretty=prompt)
+            handle_command(sock, output_buf_len, text, pretty=prompt)
             text = input(prompt).strip()
     except EOFError:
         pass
-- 
2.53.0

