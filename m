Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB30CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 21:21:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 951AB40670;
	Mon, 13 Oct 2025 23:20:50 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id E003E40612
 for <dev@dpdk.org>; Mon, 13 Oct 2025 23:20:48 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3D1577A0330;
 Mon, 13 Oct 2025 17:20:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 17:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760390448; x=
 1760476848; bh=t4a6HOCQSDOQevLePkJaIEKYekuVrizSoceSZ3mXMcg=; b=T
 qH1q843k4Epqs/ykGjhSqoY7Yg2I1bna03NV7k5gic1/m/RgHmyCVQrGnaBUTjeJ
 0e0kMAWmcpgYFRrN3ZQ4yKWjKVimThrTSXhY/Xq/KBrv8BQ6sZth+OSNs2KyOp1K
 rj6hzoCsUbJwvLuiiPR9iAtRi9iChXesqfzdnO2xIU2o4SSPnDZqpXA4XaZaOqoW
 Yk6FUHh7huERr/qHfH2FBKfmyI/KfhgaJTP9KlgptvXzuRcZrhfzOMBpULJ9bLOA
 6kJIGiYPyXsdEZOW6DCl4m5cfJYnSq1nWFVHQF21JrQj0LJ+TtMCxWgzmuqNtgXs
 s8WfcRreBlV+8wv/XaDcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760390448; x=1760476848; bh=t
 4a6HOCQSDOQevLePkJaIEKYekuVrizSoceSZ3mXMcg=; b=hY3GF+DecqSR1FbYi
 lX6vJsLtS2U9S4JSS1D9PmOBfxi8ru0iFL7tn841Sc+pGDOQzEUhavZ0h1deub2g
 5czJOuxOvfXa2ePxv1InfpmEP6kMQmuBE2CuwrSD1/5hgra7FSPrDtkYuWwN2o1J
 EMgD7qy9XbpgaKvIxk9Z1rv+Nwyphwg5tFc/M/MB49QttlC9t5fTd2l75hLH9kBH
 zRtJSftQue+91HoLhqZ8XbW4/gQk99JcepRkrtriyQw1I3CxLqHvNm9BooEYD+mX
 swA+TETRuFD27lrBe5CCisTCZWs6giuuiKTgqGYz5vXf2fOcxDn7bpOVq8MRC8iL
 lL03A==
X-ME-Sender: <xms:L23taIPFm8Lf-_DJjSq-Qw-gUxmGyCUe0-UmsPkGp9xk_fDILVj6-w>
 <xme:L23taJ7pug2AN_4nQhhe5C6pyl2k04lkwKv2hFqba6ufRdjX_5Kopz63nTmhFX0qP
 NRL4Ez8fWE8eH0RiV7_SxQmuWmEaP6qe3LTQoiY3P1L_uaH1CJyDg>
X-ME-Received: <xmr:L23taOTiKTYej5WIkw6mrf1aq7gZyfudS4oYffRLUNsYyIRnW0IDYjC6S8S-8wopbOGcwGtFzK5y3UBEdgJGED74GFyAwnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekjeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpefhledujefhieetkefhgeetveduleekkeevhfelheeugfefleeghefg
 geduieethfenucffohhmrghinhepughothgrlhhlrdhgrhhouhhpnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgr
 lhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhhphgvrhgvthiisehn
 vhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirg
 drtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdr
 tghomhdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomh
 dprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdp
 rhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:L23taGB3rJJfiC9lkokgHUC9Dp1S_iMpUxZhGTNxZwPYh_B3eA3c3w>
 <xmx:L23taOHvcp4MqZ05sxQjPyYQUrAfCJZWcoNowpXZ7tIh1hCcqtz5Eg>
 <xmx:L23taAC3j4r6DF5dP6pb9r8ZDkvkTvP33qwB2BarlThuY4MG7u4x-Q>
 <xmx:L23taGW_TxkJvSVq44Be852RuD_gNpNjLEvYRNiYFsG747tnaAk_9g>
 <xmx:MG3taDqyaPBvvObvqrGO4mpKE6TOhdrTP5fNzvCLs1xp8vGTH89F_x1y>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 17:20:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Robin Jarry <rjarry@redhat.com>
Subject: [PATCH v4 7/7] usertools/mbuf: parse mbuf history dump
Date: Mon, 13 Oct 2025 23:16:07 +0200
Message-ID: <20251013212019.892032-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013212019.892032-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251013212019.892032-1-thomas@monjalon.net>
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

From: Shani Peretz <shperetz@nvidia.com>

Add a Python script that parses the history dump of mbufs
generated by rte_mbuf_history_dump() and related functions,
and presents it in a human-readable format.

If an operation ID is repeated, such as in the case of a double free,
it will be highlighted in red and listed at the end of the file.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 doc/guides/howto/debug_troubleshoot.rst |   3 +-
 doc/guides/prog_guide/mbuf_lib.rst      |   2 +
 doc/guides/rel_notes/release_25_11.rst  |   1 +
 lib/mbuf/rte_mbuf_history.h             |   3 +
 usertools/dpdk-mbuf-history-parser.py   | 166 ++++++++++++++++++++++++
 5 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100755 usertools/dpdk-mbuf-history-parser.py

diff --git a/doc/guides/howto/debug_troubleshoot.rst b/doc/guides/howto/debug_troubleshoot.rst
index 16feeb1e54..c19aada6f8 100644
--- a/doc/guides/howto/debug_troubleshoot.rst
+++ b/doc/guides/howto/debug_troubleshoot.rst
@@ -221,7 +221,8 @@ Memory objects close to NUMA :numref:`dtg_mempool`.
    by defining the compilation flag ``RTE_MBUF_HISTORY_DEBUG``.
    Then the libraries will mark the mbufs,
    and more marks can be added in the application.
-   Some dump functions must be used to collect the history.
+   Some dump functions must be used to collect the history,
+   and a script can parse it.
 
 #. Lower performance between the pipeline processing stages can be
 
diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index ae72eecc61..382bfbdca4 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -279,6 +279,8 @@ More marks can be added by the application
 by calling functions like ``rte_mbuf_history_mark_bulk()``.
 Then the history can be stored in a file
 by calling functions like ``rte_mbuf_history_dump_all()``.
+The dump file will be easier to read after being processed
+by the script ``dpdk-mbuf-history-parser.py``.
 
 
 Use Cases
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 6854090096..6c26d3be10 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -65,6 +65,7 @@ New Features
   Added history dynamic field in mbuf (disabled by default)
   to store successive states of the mbuf lifecycle.
   Some functions were added to dump statistics.
+  A script was added to parse mbuf tracking stored in a file.
 
 * **Updated NXP DPAA2 ethernet driver.**
 
diff --git a/lib/mbuf/rte_mbuf_history.h b/lib/mbuf/rte_mbuf_history.h
index 915fb13dac..042570762b 100644
--- a/lib/mbuf/rte_mbuf_history.h
+++ b/lib/mbuf/rte_mbuf_history.h
@@ -19,6 +19,9 @@
  * The history is stored as an atomic value (64-bit) in a dynamic field of the mbuf,
  * with each event encoded in 4 bits, allowing up to 16 events to be tracked.
  * Atomic operations ensure thread safety for cloned mbufs accessed by multiple lcores.
+ *
+ * After dumping the history in a file,
+ * the script dpdk-mbuf-history-parser.py can be used for parsing.
  */
 
 #include <rte_common.h>
diff --git a/usertools/dpdk-mbuf-history-parser.py b/usertools/dpdk-mbuf-history-parser.py
new file mode 100755
index 0000000000..6d01d0ff67
--- /dev/null
+++ b/usertools/dpdk-mbuf-history-parser.py
@@ -0,0 +1,166 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2023 NVIDIA Corporation & Affiliates
+
+"""
+Parse the mbuf history dump generated by rte_mbuf_history_dump()
+and related functions, and present it in a human-readable format.
+"""
+
+import argparse
+import enum
+import os
+import re
+import sys
+
+RED = "\033[91m"
+RESET = "\033[0m"
+ENUM_PATTERN = r"enum\s+rte_mbuf_history_op\s*{([^}]+)}"
+VALUE_PATTERN = r"([A-Z_]+)\s*=\s*(\d+),\s*(?:/\*\s*(.*?)\s*\*/)?"
+HEADER_FILE = os.path.join(
+    os.path.dirname(os.path.dirname(__file__)), "lib/mbuf/rte_mbuf_history.h"
+)
+
+
+def print_history_sequence(address: str, sequence: list[str]):
+    max_op_width = max(len(re.sub(r"\x1b\[[0-9;]*m", "", op)) for op in sequence)
+    op_width = max_op_width
+    for i in range(0, len(sequence), 4):
+        chunk = sequence[i : i + 4]
+        formatted_ops = [f"{op:<{op_width}}" for op in chunk]
+        line = ""
+        for j, op in enumerate(formatted_ops):
+            line += op
+            if j < len(formatted_ops) - 1:
+                line += " -> "
+        if i + 4 < len(sequence):
+            line += " ->"
+        print(f"mbuf {address}: " + line)
+    print()
+
+
+def match_field(match: re.Match) -> tuple[int, str]:
+    name, value, _ = match.groups()
+    return (int(value), name.replace("RTE_MBUF_", ""))
+
+
+class HistoryEnum:
+    def __init__(self, ops: enum.Enum):
+        self.ops = ops
+
+    @staticmethod
+    def from_header(header_file: str) -> "HistoryEnum":
+        with open(header_file, "r") as f:
+            content = f.read()
+
+        # Extract each enum value and its comment
+        enum_content = re.search(ENUM_PATTERN, content, re.DOTALL).group(1)
+        fields = map(match_field, re.finditer(VALUE_PATTERN, enum_content))
+        fields = dict({v: k for k, v in fields})
+        return HistoryEnum(enum.Enum("HistoryOps", fields))
+
+
+class HistoryLine:
+    def __init__(self, address: str, ops: list):
+        self.address = address
+        self.ops = ops
+
+    def repeats(self) -> [list[str], str | None]:
+        repeated = None
+        sequence = []
+        for idx, op in enumerate(self.ops):
+            if idx > 0 and op == self.ops[idx - 1] and op.name != "NEVER":
+                sequence[-1] = f"{RED}{op.name}{RESET}"
+                sequence.append(f"{RED}{op.name}{RESET}")
+                repeated = op.name
+            else:
+                sequence.append(op.name)
+        return sequence, repeated
+
+
+class HistoryMetrics:
+    def __init__(self, metrics: dict[str, int]):
+        self.metrics = metrics
+
+    def max_name_width(self) -> int:
+        return max(len(name) for name in self.metrics.keys())
+
+
+class HistoryParser:
+    def __init__(self):
+        self.history_enum = HistoryEnum.from_header(HEADER_FILE)
+
+    def parse(self, dump_file: str) -> tuple[list[HistoryLine], "HistoryMetrics"]:
+        with open(dump_file, "r") as f:
+            lines = [line for line in f.readlines() if line.strip()]
+            populated = next(line for line in lines if "  populated =" in line)
+            metrics_start = lines.index(populated)
+
+        history_lines = lines[3:metrics_start]
+        metrics_lines = lines[metrics_start:]
+        return (self._parse_history(history_lines), self._parse_metrics(metrics_lines))
+
+    def _parse_metrics(self, lines: list[str]) -> HistoryMetrics:
+        metrics = {}
+        for line in lines:
+            key, value = line.split("=", 1)
+            metrics[key] = int(value)
+        return HistoryMetrics(metrics)
+
+    def _parse_history(self, lines: list[str]) -> list[HistoryLine]:
+        # Parse the format "mbuf 0x1054b9980: 0000000000000065"
+        history_lines = []
+        for line in lines:
+            address = line.split(":")[0].split("mbuf ")[1]
+            history = line.split(":")[1]
+            history_lines.append(
+                HistoryLine(address=address, ops=self._parse(int(history, 16)))
+            )
+        return history_lines
+
+    def _parse(self, history: int) -> list[str]:
+        ops = []
+        for _ in range(16):  # 64 bits / 4 bits = 16 possible operations
+            op = history & 0xF  # Extract lowest 4 bits
+            if op == 0:
+                break
+            ops.append(self.history_enum.ops(op))
+            history >>= 4
+
+        ops.reverse()
+        return ops
+
+
+def print_history_lines(history_lines: list[HistoryLine]):
+    lines = [(line.address, line.repeats()) for line in history_lines]
+
+    for address, (sequence, _) in lines:
+        print_history_sequence(address, sequence)
+
+    print("=== Violations ===")
+    for address, (sequence, repeated) in lines:
+        if repeated:
+            print(f"mbuf {address} has repeated ops: {RED}{repeated}{RESET}")
+
+
+def print_metrics(metrics: HistoryMetrics):
+    print("=== Metrics Summary ===")
+    for name, value in metrics.metrics.items():
+        print(f"{name + '':<{metrics.max_name_width() + 2}} {value}")
+
+
+def main():
+    parser = argparse.ArgumentParser(description=__doc__)
+    parser.add_argument('history_file')
+    args = parser.parse_args()
+
+    history_parser = HistoryParser()
+    history_lines, metrics = history_parser.parse(args.history_file)
+
+    print_history_lines(history_lines)
+    print()
+    print_metrics(metrics)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.51.0

