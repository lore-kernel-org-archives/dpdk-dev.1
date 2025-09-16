Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C871DCAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:13:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 625DA406B4;
	Tue, 16 Sep 2025 17:13:07 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53]) by mails.dpdk.org (Postfix) with ESMTP id 108804064E
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:13:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETTcALmCAfFr6HsqGgL5kSW9hXqtIFixLBmXerWfA53DlncypcRlx5qJp7zEnbcI+y/mikyoa3RSeFjHkerE91htDSelbCXzeJHpt3cdIczSIQdJpQ8pQHpMWxUSxwWe2nGcGZHcLenbpyWEg4JaodgXXnYdvcT3tWjC2gsQD44wOxWGr6/qQqwXxOC2BaMwaxbq1ua5m6Jv5/HArINRBJOwISN6zPYj2/5OEgq9FE5G0Uv9j+SZr3Ue42buK4zy2iXu8iP4D61srGvI85XMEY9YX7zwSxC7iZWUAL1v+Q6/wi/vocDHppz+GXzhfITp0X/BvpG/L3BAqqV04SKImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk4z6r5zop57NUdnVQAdspkTYHztKx1JnRu/0J73HJ8=;
 b=ajKZhOhxVUYTQc4207AJQR/LxrE5hEOJBPUMJvP3aenzxu6gELJ4U4ZnrI9OgaHnJuHlgLIwpky9S4K5XpRm1v8/S22k/dUm4tZpfHzOhnY6A1o9wezaXUIi+oyCNLVSXIPic07kYeyIscDyxS4UkZInZeAaW4Vrx/KjXadObzdtytaHPEnKo87XbSrhEtaQaOtwnZ0Tsrc9ZXdPgxMcaIJXFA+xLZDP8xKepef0JpLF6Zklxv7rHm+n4ZudoJQ3D57XCrC9+yYHYzT46DD6D/7ebdFvQbJ/XGu+87SJb+zezf99njpKMVg1efHl4HjMrDJPDag0nfyt5EUlZhlLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk4z6r5zop57NUdnVQAdspkTYHztKx1JnRu/0J73HJ8=;
 b=gnzbxezUZQu45ulg7JDPNSMBZ+c2PghZRMO5Dy/MWbBY6rHYzGLQ5c4p7iq4YCEA0roO0JVwg/Nax4mvSgoDGvkOP6XjKVVVTimVoh7UKdQhAhscaT+ODHXFcDtUIeFSc4tUQ7zf3gzgJ8utBjaK3JzeGD/geAH7xIBQNqTsU3LegTf0c/cIeAgY8wKLxwN81ZVZ4erlZsKGp7IWnzXNxhu+7hJ8AQ/DaPCQLg7JL1PWOQqr7KhuOummg9OeTGxbEAHs+A5aqtW/Kz5wcGWreUK0GpKDnOV4CR9/95uyGjyOy7bVWFfV7Q7YwGHbnOJXHdcyFIQYTeAZyzzwUgCjtw==
Received: from CH0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:610:75::35)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 15:12:58 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::84) by CH0PR04CA0120.outlook.office365.com
 (2603:10b6:610:75::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 15:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 15:12:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:43 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 08:12:38 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <mb@smartsharesystems.com>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, <ajit.khaparde@broadcom.com>,
 <jerinj@marvell.com>, <konstantin.v.ananyev@yandex.ru>,
 <david.marchand@redhat.com>, <maxime.coquelin@redhat.com>,
 <gakhil@marvell.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>, "Shani
 Peretz" <shperetz@nvidia.com>, Robin Jarry <rjarry@redhat.com>
Subject: [PATCH v2 4/4] usertool: add a script to parse mbuf history dump
Date: Tue, 16 Sep 2025 18:12:07 +0300
Message-ID: <20250916151207.556618-5-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916151207.556618-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: ec436165-1ace-4604-6411-08ddf533853a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gULmR+oyX+BIeaKfjjmcow2LPI69xaWfH8PSlG3HJR7ZRrrj8ebOrkOybgTI?=
 =?us-ascii?Q?Z39RPzSDkFuOuwv1Qlk7IDiO87S9vq7+4/3dt/S0hQfwpMwjA1KG1T/l1ZVf?=
 =?us-ascii?Q?Lasro80e2VBg6FTnXgp3EobS7MybBE7yBDdp4ep+l/FqFU5MDzGWd3iB3NPo?=
 =?us-ascii?Q?1YF00SlMw6YlrIvk2U/UvtjzO6OzF3xEcxoykKARXxJukp+EKYDnhzpVzxKQ?=
 =?us-ascii?Q?Uj3k/fI4IbcAMt7PFWyTMoGwVffA+k7epRKWn1fjVFSIHuEKxWyzUM54S8gS?=
 =?us-ascii?Q?8MZRIs2slbHhGZ3/QsmNrBsLkfsURWGA4E9pkXegpPPirf9Xt/sEk7t0+HQN?=
 =?us-ascii?Q?vRtZHEeAJ6oiPD/4FMDK3AHzoVs/jyE+PZSRaDqBmEwyWGDlpGLwJQhmUN4A?=
 =?us-ascii?Q?k0t+eLJKNc1hYyvlGIAaBzAdtkRp3gVx7qKxcEhq24HjsgrlEXMKg8fhFaL4?=
 =?us-ascii?Q?yP3zr8y1f0Qcx3fH+9LXAkKwCLNQUe3Yvfxm1oWc7ZVepQYcUg842iGqo70D?=
 =?us-ascii?Q?2W4BxdpwURb7sO9QJCPdoRjitAT0iqZPDqThG69CPfTT5cZaoRpXDB8MqF0S?=
 =?us-ascii?Q?4rMAbKWCwEND66uzGKe1pAt3Gyo3vFDcXCNW+aqV+aZ5HfRLglN4w38q+NRB?=
 =?us-ascii?Q?SV62lxOhI8zvuJ2WOxR2qPEvhBMR6Ix+K+AD3BwcgxksfEaiwgjSTS46PzvM?=
 =?us-ascii?Q?5m4c2PKGpiTk953NCHHnjQdEagvk43FafcDvj6gon6K1sBmV45l4YRdOULGS?=
 =?us-ascii?Q?XK2pAaBqemPydiVPFay9Fk+DlLV3Lohp5AmwFxpzJRcYKUQeK0ZumeW37dJh?=
 =?us-ascii?Q?tInhXCkGvXnWV5Om/XDNgf7NYm/9qoBdjhSKBb9xFD+GtK8qDVfurDjnOmJ5?=
 =?us-ascii?Q?NrY3XBuNWns9gaibLAesQIlZwb7w6pwoftV7Nk7narhwbVQkmoADR1n/YW3D?=
 =?us-ascii?Q?GV72GiP23hRGfjGjEeCg3r9kmqBoG4MVfmpd6eUiKCApUcOXInmeEgkG427m?=
 =?us-ascii?Q?pRrECh1Aw3D9Qt1qUYxqfrlM6csFdFKf9WL+3UNcTne2VCsiKHic2uoyZIfI?=
 =?us-ascii?Q?Te12WQcvrTiuxIxs375d8N0nBZvtrfRh+SAgTj5ktl9nUSpv0npFuYjkxo46?=
 =?us-ascii?Q?kJqDJdxnyXLpG5W+QiX8SmDZ8omEAHQ0GEoxpcCwJi1guD9++nZy6ancmmTo?=
 =?us-ascii?Q?USeVVhgHXcT14H5MGYT+MOBwxU3P76ZcezpSBOGHPlu8beXhEPRSx64VAqwh?=
 =?us-ascii?Q?RusNd5KFwMEh9wEh4QWScfWfum+9HE/I1H8/S6vEANOhM35zX0Mr7ywSwzdf?=
 =?us-ascii?Q?TPZMVaAQQyQRxlXwxkWQCp/Yxy23drn+IGzNJurttN9OfQvxcdcP6GVcu+hD?=
 =?us-ascii?Q?EunwV/N1KaJ9zHhfoKab+DJkLvNL9posmuNYvMAyNUnJNr1RLVC+xmRf1WfF?=
 =?us-ascii?Q?niAhyNzUNfgBKZNquh4ERgYNzJGKwKFToYQMyxH70cYu/1muyDyMk3hP6yjy?=
 =?us-ascii?Q?EcmG9r+SWodjxs3G5n0EHjdbILEfds+bS7Nj?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:12:58.2346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec436165-1ace-4604-6411-08ddf533853a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

Added a Python script that parses the history dump of a mbufs
generated by rte_mbuf_objects_dump and presents it in a human-readable
format.

If an operation ID is repeated, such as in the case of a double free,
it will be highlighted in red and listed at the end of the file.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 usertools/dpdk-mbuf_history_parser.py | 173 ++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100755 usertools/dpdk-mbuf_history_parser.py

diff --git a/usertools/dpdk-mbuf_history_parser.py b/usertools/dpdk-mbuf_history_parser.py
new file mode 100755
index 0000000000..c39a796d5d
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
+            populated = next(line for line in lines if "Populated:" in line)
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
+            key, value = line.split(':', 1)
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
2.34.1

