Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE53ACCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 20:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC1E242830;
	Thu, 16 Oct 2025 22:36:22 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id AD20F42D26
 for <dev@dpdk.org>; Thu, 16 Oct 2025 22:36:20 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 64B821400186;
 Thu, 16 Oct 2025 16:36:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 16:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760646980;
 x=1760733380; bh=qkg5CtgsyIb0ixZ7k/hxTYcKyU4T/4fmK/wQ8Ol/QtA=; b=
 a3OYmofv4tuZMb9PSGQB2q/ZAEBUOdMW0Ev8mTRO98nsGV8BJoJp4Wn1RcRwSLkH
 U6N7r5nhznODlJX523H1OCrQMapMFUWKgE8u2J956QonvBqIutg6GDv5k++rjfDo
 MvolmzWQdDvP8CJy37HnmkR/HmezkfxNZ2hzWq1o9zPJd+65F0rYOe80WWvmsjZl
 Fi8EZ0TzJuwMmRxshgNo71XuIol/TmAaXyTFpQeMtzT26EvRVLGA6rBqOMH9Wm6k
 SB/LrCyV03HOleTv8h1Ebb3wbxPlhjRtb+1Ni2P01F8Cx1TZcpmLw9VblyCVXrO0
 1Fruckbs8Y2VB6oURtz8/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760646980; x=
 1760733380; bh=qkg5CtgsyIb0ixZ7k/hxTYcKyU4T/4fmK/wQ8Ol/QtA=; b=p
 /igYDInbZgKsHI3tU17RkO7SvSyfCkdkCkK/o9QDV3+Ea32+ZSnAelZy7rdCF9oN
 q/pfIDs2r+Omlf7+sW01arZx6qOYGMcJmv7DDu051RAnvRdFiN1tmJoVMbSz2C1Y
 4KMDDgMc/6HE+9ypzT2qckdD7UDOL7cAFhJXYmpjLyIeupxa8aYytbAy5wnXEhfZ
 EFITIY9xk3dJ82xkLzA64kdyjj7zKj6KSZBPUX4DBJqM8lHrKQ6w+dWUx8x2XMry
 wzS2tf0OJYVbheN0/RwWTzSgeL1RuS4JL4MxFTMgDTAKWVnhMZ7OquJM+GYwK+Q1
 ywf1CNux3qY3K3hCtlPxg==
X-ME-Sender: <xms:RFfxaH_GpWvnFAXvURDTdr_aQw6hFRvSk9g_wVwihYbPN2jzwmA_Pw>
 <xme:RFfxaOq8L3R05qbmJ9qtvybVd5TtOyumZlpMxLMqGgXmZFr-y3ejH1dSY89NZhWiX
 QiP0mxwqgaL5oNsaqDyTLF1N_1uCviV-7xlyi4WD6nbXiH2nnkPVw>
X-ME-Received: <xmr:RFfxaEAizn1zjT7QvxiP9D80Io7sVif900nIBm7FV7PmjkmzrlIrZG3nMdoWmMAylGaB0EnY2sdkceu8UotQb2IUrxERGBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvhhhomhgr
 shcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecugg
 ftrfgrthhtvghrnhepudeltefhveeufffhleeltedvhfeutefhtdegfeetledtvdefvdff
 vdekveffjedtnecuffhomhgrihhnpeguohhtrghllhdrghhrohhuphenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
 gtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiies
 nhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghl
 rdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtoh
 hmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
 pdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:RFfxaIwZWNWWSvfkeyH-mbaQCHG2yySUwgEHbJrzrngLVgh7jlVJvg>
 <xmx:RFfxaJ2Eyt2lBffVjxs4c2Sza2G_S60gxguaZMORkexF06oUjJTsgA>
 <xmx:RFfxaAzzylf68ByozE6PXyta790x9w5wBU1bajjH2Ido68s02lilbA>
 <xmx:RFfxaIEYi3bkcbFzxQ4e4Aksr1Xmkgbcvx9HvI9VCa5a94Uez05Zfw>
 <xmx:RFfxaGbmbjY-sMu1EDkd0WzwluASuf2bDkkTqGAGgzbpN7R8Dw5uOM80>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:36:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Robin Jarry <rjarry@redhat.com>
Subject: [PATCH v7 7/7] usertools/mbuf: parse mbuf history dump
Date: Thu, 16 Oct 2025 22:34:45 +0200
Message-ID: <20251016203557.2554678-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016203557.2554678-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Robin Jarry <rjarry@redhat.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/howto/debug_troubleshoot.rst |   3 +-
 doc/guides/prog_guide/mbuf_lib.rst      |   2 +
 doc/guides/rel_notes/release_25_11.rst  |   1 +
 lib/mbuf/rte_mbuf_history.h             |   3 +
 usertools/dpdk-mbuf-history-parser.py   | 165 ++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 1 deletion(-)
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
index 4d6a02179a..95e64d5d57 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -76,6 +76,7 @@ New Features
   Added history dynamic field in mbuf (disabled by default)
   to store successive states of the mbuf lifecycle.
   Some functions were added to dump statistics.
+  A script was added to parse mbuf tracking stored in a file.
 
 * **Updated NXP DPAA2 ethernet driver.**
 
diff --git a/lib/mbuf/rte_mbuf_history.h b/lib/mbuf/rte_mbuf_history.h
index 56a975a484..daf3cda34c 100644
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
index 0000000000..273adbcfae
--- /dev/null
+++ b/usertools/dpdk-mbuf-history-parser.py
@@ -0,0 +1,165 @@
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

