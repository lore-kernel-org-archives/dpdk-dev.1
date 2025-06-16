Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5FEC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:30:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C6AB40E20;
	Mon, 16 Jun 2025 09:30:17 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by mails.dpdk.org (Postfix) with ESMTP id 7BFC740E0A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:30:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4xzO+3MjFM/FnuLJTWesSMnn09uYUvFmnr3e4h+BK6+dg9BRGWauEcz5zQWL9EkNYBS2x85NAyL5mWD6jz0lE4U5PNFaJ1Td5ZDA0JH8kfb4UXkc7CjqDR3EnvyAySt2Q15rH/l3KI8tgZd0vKJLzT3EL1ulMSRdvoZUvLpgugDUvRDV5P0WHGuKTzcwyeYLdWj8sy1EuF7Hn73LnE5qCmFSfnor1Oa3Ke+sFQnmg5fQ60Jy0NUwHAl1+VxLSoZi4wWxix7B2x3r/KKDjB2ylKs16YuoufBqqDwKCjOeQal6uREJPLGWzE1YBeIhp5EK9d2yNgss7UdConb5agR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YTTSftjNk6ogx6hErXlbUR4CmPBELg340jdFz1vAbw=;
 b=MscCGJkMrURZGcLU5wOgH/alkqnhMQpmnygB7hDSGH6rXns8mCna6eJ7d23nvVHLyxQaW253He/avRB4EXvsa5BmNN1v8M5GV06sOs1YlzJsa7jgxI4AJyoLxMrR6rQobu5LHAAftfrkczMAFPrtGpl6JeEMiNHY3LlZlfzxFrqUghcuQwGC9AGs0webMDSnSAN7S6RK7Rs4rvKN19AywMK8dYeLE7wnfw6B/eNohCxO58TaRZZDHSxzbdZv0EU3LhSzh2k5bCJO668yl9KDMxjkUhS2DIgOWmdt4OBao3wqyhho4Hwl2tbxS2Ad+z/KLaX7qsjwVF/7Ypyb+N+X9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YTTSftjNk6ogx6hErXlbUR4CmPBELg340jdFz1vAbw=;
 b=NofhK/13jiq3YAEYcbdAh1jBrt686dqgrxkF2k18H32Q8XYBSi/r1Ef33n7SrCI4N8Yilr2w3n/JCR/vDhmSR/zsxxxvznCcPB9jpviA6Uhl7FVBnsIEt7q/GLgj4Js/K7AN8EFXUV4nMzwGISjpi2mh+mAnSqSmKS88B7SjiSrlLhCCzD7yIXuHjI8nI/wddnYFWN//S069hALIFB6e7v8U3zm/LHAY2DHtdzNZ8fjfLWCvHfuA9+htPwX7xOA7PN5T9CYj0fcO1md2zkwhYsklkGu1sbgTaP2J60RB7AMQfJTaTiFP40uIid0OZQfcU9HT9Yh4oR37bAQmAue6fg==
Received: from MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:30:11 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::31) by MN2PR20CA0064.outlook.office365.com
 (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Mon,
 16 Jun 2025 07:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 07:30:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 00:29:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 00:29:53 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 00:29:52 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Robin Jarry <rjarry@redhat.com>
Subject: [RFC PATCH 5/5] usertool: add a script to parse mempool history dump
Date: Mon, 16 Jun 2025 10:29:10 +0300
Message-ID: <20250616072910.113042-6-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: efd8a687-47c0-4ed6-a126-08ddaca7a095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P4Un10TFmPbVzdsPD0Q3TR4xGty6sj3iBfID6qNYhvVi9p/J008YyIjNU61V?=
 =?us-ascii?Q?o3msuxviYG5FCQDU0qzYBBtE784Y0tIWyU35AM/6B9qIMUu7eNoVSeYPB34D?=
 =?us-ascii?Q?G2bbk9943cGMjkb95fb7Ikly6ER7hOIR4BhOxeL/D7TBSWVVnr7wrs6qb+9e?=
 =?us-ascii?Q?RJkl87/RXDvW9bA6PXCqA40CAq+UfSbYdHRdJUq0HZ8l5WcRo+NLw2QFzHfE?=
 =?us-ascii?Q?iXINFeDEp7zqjbUsWr9NUBDny4E56QKEHSr9wszgjj37XooFHgbxnVXp78Wk?=
 =?us-ascii?Q?ItOlc+S8E+fc/L5ot7V1JfG6QRbWQks1xnraOLe1lnq5CdOR6OC10ovA8O7A?=
 =?us-ascii?Q?cyxvbFkkBK1sXG4yKUtsabN+L4+CaBBENRL+8okxj+FaaznvkEU0EfxcHn8S?=
 =?us-ascii?Q?SRomoWdugMzRKcaLoZfSoymAd0ISFsgz9YQRaxCTzyVZXu9jiNUmj/O/4sMO?=
 =?us-ascii?Q?o7tG1G4FqbWE+KRSkPXae51WOwwfQaOIhnTiZwqviVptiB/CaKak6Mt61mxX?=
 =?us-ascii?Q?TsArT8/niPmpws+GB7ty2uY/Pw/tHLJSgivlc1UzfC1cH+tVxOJBcXmr9sxH?=
 =?us-ascii?Q?rpwW4EiUapDdVEaM45ASKPzNComispOZAgxnuXxBChvUEL83or0O7C6mGmAN?=
 =?us-ascii?Q?cOEbbSBaYdslm89OLdQ53sOHu4DucEN75a7NZY1St8v0P11oo3CHLRKhytZA?=
 =?us-ascii?Q?xoekCyqPlafMxYCNtoFPMVq/9ymPvdpBWh8aIPJ7nfxHo6bBeehfB7ClIDxv?=
 =?us-ascii?Q?HtzO1qrK6KL8sHULdf4qVMmEK7/mnP3/jcyZH9zRfWdpbscrspRhjdwwP68q?=
 =?us-ascii?Q?+SUC9E/WTqY7qrot/esySDAg8wNVchlZjE3PTKm6ntYUUu8s6OdXzm8aJ640?=
 =?us-ascii?Q?ChxRxJw/VIkOuGNvsjR7kiXBTbdZ+VMOLaq5Az+aLkFMV0FHcZIvfyRsr6mC?=
 =?us-ascii?Q?acZcajjUE/YF3c+duXddKHP4NHrm8ISCH8rdaoQZ7rN9Ai3OKmDyetcEiQnW?=
 =?us-ascii?Q?B+IpN1Aq2wFljBpB+K6/UJWwq0+MGNOxFS862d/+DLBaaK2PhyN1K/fhP7hc?=
 =?us-ascii?Q?MM+jc/YrrJjJvrL3WakfY2MB707R7a2WV/563Wu7vGYvJndJrxnP/HQzONgl?=
 =?us-ascii?Q?0yVO6bf88ean+3ZMskx6x33Zq90kS2R3AEX0P1B1aJ52vs9d5RwAA+xc1d5g?=
 =?us-ascii?Q?ZLD13FEhQB7zC5RZfNwWp9/cxoe75eOW8GqjuaTw1KqmpbiGI87SOUG5pIkW?=
 =?us-ascii?Q?aSxsgj73Br57o4yhD/BhTNQMct0B747jUGe7Bd6ylmHRtqJh9SZNnhf5W1eC?=
 =?us-ascii?Q?l+P5qDwXzMB1OnXD1a/YfYFBvsMMgLbkhCyg+7qmzX0mmK9LKNWO1AAPcDGR?=
 =?us-ascii?Q?zgtQCITQjrfHkiNGovxM7VcSN/CKQ/bv9AawZNS1hJxC+Y/vUn7NFA7ol/SG?=
 =?us-ascii?Q?UOu62Len8892J82k8E+PEWcKcUZrL0NfRKh1tDtftu/fW7Z6KuW4kYmwRX1W?=
 =?us-ascii?Q?Qi8yAggQDQJvRZZTjfTt4X8YR5j6pCBfd5tX?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:30:10.8225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd8a687-47c0-4ed6-a126-08ddaca7a095
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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

Added a Python script that parses the history dump of a mempool object
generated by rte_mempool_objects_dump and presents it in a human-readable
format.

If an operation ID is repeated, such as in the case of a double free,
it will be highlighted in red and listed at the end of the file.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 .../dpdk-mempool_object_history_parser.py     | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100755 usertools/dpdk-mempool_object_history_parser.py

diff --git a/usertools/dpdk-mempool_object_history_parser.py b/usertools/dpdk-mempool_object_history_parser.py
new file mode 100755
index 0000000000..0224a97e22
--- /dev/null
+++ b/usertools/dpdk-mempool_object_history_parser.py
@@ -0,0 +1,129 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2023 NVIDIA Corporation & Affiliates
+
+import sys
+import re
+import os
+
+RED = "\033[91m"
+RESET = "\033[0m"
+ENUM_PATTERN = r'enum\s+rte_mempool_history_op\s*{([^}]+)}'
+VALUE_PATTERN = r'([A-Z_]+)\s*=\s*(\d+),\s*(?:/\*\s*(.*?)\s*\*/)?'
+
+def match_field(match: re.Match) -> tuple[int, str]:
+    name, value, _ = match.groups()
+    return (int(value), name.replace('RTE_MEMPOOL_', ''))
+
+def parse_history_enum(header_file: str) -> dict[int, str]:
+    with open(header_file, 'r') as f:
+        content = f.read()
+
+    # Extract each enum value and its comment
+    enum_content = re.search(ENUM_PATTERN, content, re.DOTALL).group(1)
+    return dict(map(match_field, re.finditer(VALUE_PATTERN, enum_content)))
+
+
+# Generate HISTORY_OPS from the header file
+HEADER_FILE = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib/mempool/rte_mempool.h')
+try:
+    HISTORY_OPS = parse_history_enum(HEADER_FILE)
+except Exception as e:
+    print(f"Warning: Could not generate HISTORY_OPS from header file: {e}")
+
+
+def op_to_string(op: int) -> str:
+    return HISTORY_OPS.get(op, f"UNKNOWN({op})")
+
+def parse_mempool_object_history(line: str) -> list[str]:
+    line = line.strip().replace('0x', '')
+    return [op_to_string(int(digit)) for digit in line]
+
+def parse_metrics(lines: list[str]) -> dict[str, int]:
+    metrics = {}
+    for line in lines:
+        if ':' not in line:
+            continue
+        key, value = line.split(':', 1)
+        metrics[key.strip()] = int(value.strip())
+    return metrics
+
+def print_history_sequence(ops: list[str]) -> bool:
+    sequence = []
+    had_repeat = False
+    for idx, op in enumerate(ops):
+        if idx > 0 and op == ops[idx-1] and op != 'NEVER':
+            sequence.append(RED + op + RESET)
+            had_repeat = True
+        else:
+            sequence.append(op)
+
+    if not sequence:
+        return had_repeat
+
+    max_op_width = max(len(re.sub(r'\x1b\[[0-9;]*m', '', op)) for op in sequence)
+    OP_WIDTH = max_op_width
+    for i in range(0, len(sequence), 4):
+        chunk = sequence[i:i+4]
+        formatted_ops = [f"{op:<{OP_WIDTH}}" for op in chunk]
+        line = ""
+        for j, op in enumerate(formatted_ops):
+            line += op
+            if j < len(formatted_ops) - 1:
+                line += " -> "
+        if i + 4 < len(sequence):
+            line += " ->"
+        print("\t" + line)
+    return had_repeat
+
+def main():
+    if len(sys.argv) != 2:
+        print("Usage: {} <history_file>".format(sys.argv[0]))
+        sys.exit(1)
+
+    try:
+        with open(sys.argv[1], 'r') as f:
+            lines = f.readlines()
+
+        # Find where metrics start
+        metrics_start = -1
+        for i, line in enumerate(lines):
+            if "Populated:" in line:
+                metrics_start = i
+                break
+
+        # Process mempool object history traces
+        marked_mempool_objects = []
+        mempool_object_id = 1
+        for line in lines[:metrics_start] if metrics_start != -1 else lines:
+            if not line.strip():
+                continue
+            ops = parse_mempool_object_history(line)
+            print(f"MEMPOOL OBJECT {mempool_object_id}:")
+            had_repeat = print_history_sequence(ops)
+            print()  # Empty line between mempool objects
+            if had_repeat:
+                marked_mempool_objects.append(mempool_object_id)
+            mempool_object_id += 1
+
+        if marked_mempool_objects:
+            print("MEMPOOL OBJECTS with repeated ops:", marked_mempool_objects)
+
+        if metrics_start != -1:
+            print("=== Metrics Summary ===")
+            metrics = parse_metrics(lines[metrics_start:])
+            # Find max width of metric names for alignment
+            max_name_width = max(len(name) for name in metrics.keys())
+            # Print metrics in aligned format
+            for name, value in metrics.items():
+                print(f"{name + ':':<{max_name_width + 2}} {value}")
+
+    except FileNotFoundError:
+        print(f"Error: File {sys.argv[1]} not found")
+        sys.exit(1)
+    except Exception as e:
+        print(f"Error processing file: {e}")
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.34.1

