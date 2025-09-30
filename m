Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8498CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 23:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A830940A6C;
	Wed,  1 Oct 2025 01:39:05 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id B2C0140A67
 for <dev@dpdk.org>; Wed,  1 Oct 2025 01:39:04 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 122817A0078;
 Tue, 30 Sep 2025 19:39:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 30 Sep 2025 19:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1759275543; x=
 1759361943; bh=Zp5sIjYM0WyW1GHhPsU5SZlnTs32ONHP5Pa3dCw6VhE=; b=h
 n+XBq+KjvTlT3zvwiBznSqAyLUYXBRHZSRSJnY4i4iVsIXzo4XEPXbt47g53sOIB
 hOZGg06RU3IapuSKeuWG9Co43sLAeKH28Ymyu2GmtDmeDadOrH0taPPiDAcfJ/Wk
 /q0JvtFjEnAwM40HBK7AKhC04kBBCl9KpXx8MWheYUaug1PgYhU4Gz3msp39QEf9
 PsI8zXbZiwRnnAJ8pyDMoQ/HzPb228bT2Nw8rKVlt0CU7sDYO1MMsl5qdfKfQqTC
 jYw2oLlF4dESxm07mHYUjsqPsKdcoJqqDJnO5cgofXpzpQY0mUykAHralSRfVdab
 279sm0plkgqva9pVQp+FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1759275543; x=1759361943; bh=Z
 p5sIjYM0WyW1GHhPsU5SZlnTs32ONHP5Pa3dCw6VhE=; b=iHYrQeM3piY9Z3kWO
 jfEBVxGrOwB7B4Ld0Z5GlLTX1wCJnw1aEUOxqs4CIX5QxCbqHL7aGH78LiFZKz66
 Rfom5T8WTbO1Hl1EuS1CDg9Li6Wih4Zhuh1byORb8VgEZRLiicH42MXcFq4WWA2l
 2+TsMxtIFqzqK1vVGKUiYP0tHNfwNaGy6/407F/3a4EFCMVQvzG5zXJMJ4nT4YE/
 +40P4e7Lu8GKzN9lSfu//ptCW6TXsaauZYqI7cOZPuVw142z5YQsJK0OdSQbAIH6
 MWbnrEq8Pwe1XOSCeC7/H3b3+FJtcAj8tUv/SYUC2R+be7v1hBTHGLyg6cKBL8iu
 Pug8g==
X-ME-Sender: <xms:F2rcaLvv5a4TWDLAYvUuUfnZcGKW5-cALonj5hDJACjWHvxcHCr8bw>
 <xme:F2rcaHYz3cbzqTg1T4Cp7Np-WniPey1eqLWG_7aeTs5SY6aJRZK-dI7jmNdnqmB1C
 DdvF9u-EpNPBZl7LeNoqeSNpaIQK8226q5RGGgrTuOhaGMcTanGXr8>
X-ME-Received: <xmr:F2rcaNxjOzsf8BhuQlsTbbHPi3VTPFVPpD3-9k7Wmbli12MnsdyTTzfPQqs_q37ccBBkg1S8LjtXbf56B4voQCvVG_7GXpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhephfeludejhfeiteekhfegteevudelkeekvefhleehuefgfeelgeehgfeg
 udeitefhnecuffhomhgrihhnpeguohhtrghllhdrghhrohhuphenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghl
 ohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnhhv
 ihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgt
 ohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpd
 hrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhr
 tghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:F2rcaPgwn2kQ-gQdFEfkXYbWVzc10ZuxeNEX3hF6lrHOwXaXDKILzw>
 <xmx:F2rcaJmFqh48odqxS3HrExoRMGDKlzJ6UgDGhCbXrubzvehofR5cpg>
 <xmx:F2rcaFjGXaj-b667gCg6qxrlJ0i-N_U4DjccIuSpgbo7vtX5F5Q0IQ>
 <xmx:F2rcaN1X9WC3IdLEUY30Bj3CMZst_RmoYtfTv46SHMGjcl2M5CuJDw>
 <xmx:F2rcaNJva6Kt98i2ZcOnbET1I8af4bnAfR1dzxGJXKI8ZfI1qiha1NjW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 19:39:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org,
 Robin Jarry <rjarry@redhat.com>
Subject: [PATCH v3 5/5] usertools/mbuf: parse mbuf history dump
Date: Wed,  1 Oct 2025 01:25:06 +0200
Message-ID: <20250930233828.3999565-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930233828.3999565-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
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
 usertools/dpdk-mbuf_history_parser.py | 173 ++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100755 usertools/dpdk-mbuf_history_parser.py

diff --git a/usertools/dpdk-mbuf_history_parser.py b/usertools/dpdk-mbuf_history_parser.py
new file mode 100755
index 0000000000..dfb02d99be
--- /dev/null
+++ b/usertools/dpdk-mbuf_history_parser.py
@@ -0,0 +1,173 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2023 NVIDIA Corporation & Affiliates
+
+import sys
+import re
+import os
+import enum
+
+RED = "\033[91m"
+RESET = "\033[0m"
+ENUM_PATTERN = r'enum\s+rte_mbuf_history_op\s*{([^}]+)}'
+VALUE_PATTERN = r'([A-Z_]+)\s*=\s*(\d+),\s*(?:/\*\s*(.*?)\s*\*/)?'
+HEADER_FILE = os.path.join(
+    os.path.dirname(os.path.dirname(__file__)),
+    'lib/mbuf/rte_mbuf_history.h'
+)
+
+
+def print_history_sequence(address: str, sequence: list[str]):
+    max_op_width = max(
+        len(re.sub(r'\x1b\[[0-9;]*m', '', op)) for op in sequence
+    )
+    op_width = max_op_width
+    for i in range(0, len(sequence), 4):
+        chunk = sequence[i:i + 4]
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
+    return (int(value), name.replace('RTE_MBUF_', ''))
+
+
+class HistoryEnum:
+    def __init__(self, ops: enum.Enum):
+        self.ops = ops
+
+    @staticmethod
+    def from_header(header_file: str) -> 'HistoryEnum':
+        with open(header_file, 'r') as f:
+            content = f.read()
+
+        # Extract each enum value and its comment
+        enum_content = re.search(ENUM_PATTERN, content, re.DOTALL).group(1)
+        fields = map(match_field, re.finditer(VALUE_PATTERN, enum_content))
+        fields = dict({v: k for k, v in fields})
+        return HistoryEnum(enum.Enum('HistoryOps', fields))
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
+            if idx > 0 and op == self.ops[idx - 1] and op.name != 'NEVER':
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
+    def parse(
+        self, dump_file: str
+    ) -> tuple[list[HistoryLine], 'HistoryMetrics']:
+        with open(dump_file, 'r') as f:
+            lines = [line for line in f.readlines() if line.strip()]
+            populated = next(line for line in lines if "  populated=" in line)
+            metrics_start = lines.index(populated)
+
+        history_lines = lines[3:metrics_start]
+        metrics_lines = lines[metrics_start:-1]
+        return (
+            self._parse_history(history_lines),
+            self._parse_metrics(metrics_lines)
+        )
+
+    def _parse_metrics(self, lines: list[str]) -> HistoryMetrics:
+        metrics = {}
+        for line in lines:
+            key, value = line.split('=', 1)
+            metrics[key] = int(value)
+        return HistoryMetrics(metrics)
+
+    def _parse_history(self, lines: list[str]) -> list[HistoryLine]:
+        # Parse the format "mbuf 0x1054b9980: 0000000000000065"
+        history_lines = []
+        for line in lines:
+            address = line.split(':')[0].split('mbuf ')[1]
+            history = line.split(':')[1]
+            history_lines.append(
+                HistoryLine(
+                    address=address,
+                    ops=self._parse(int(history, 16))
+                )
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
+    lines = [
+        (line.address, line.repeats()) for line in history_lines
+    ]
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
+        print(f"{name + ':':<{metrics.max_name_width() + 2}} {value}")
+
+
+def main():
+    if len(sys.argv) != 2:
+        print("Usage: {} <history_file>".format(sys.argv[0]))
+        sys.exit(1)
+
+    history_parser = HistoryParser()
+    history_lines, metrics = history_parser.parse(sys.argv[1])
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

