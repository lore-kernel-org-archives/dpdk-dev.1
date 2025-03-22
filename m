Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B807C35FFC
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Mar 2025 10:59:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 553D4402D6;
	Sat, 22 Mar 2025 11:59:39 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by mails.dpdk.org (Postfix) with ESMTP id 17505402A7
 for <dev@dpdk.org>; Sat, 22 Mar 2025 11:59:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvx+eWRyiLNel3/GLyeXMUo8164Ml0cIAFYd+Ce2ttHKdp7mWYT2HxpVMUF7zi7un7DKKvTN424B+JADEX/icClNBEJMJkULxyFtViRc4uSxlmqkrLEfydT855+Yb1Y8efN8F2wCCR3Z8qxzLk5GYGFJpOxeJ5Dz9mTLCJ/nTEMt75aV51eoVpxYHXpclb6Nco8d12disQ/T1Dmr6MDY0hDBQ87fwUA8DbkFPrE1+/fsEIECh9p8gvSonVOBcOhBbpUSi8/76zauCk9bv8ZNOicaFrD2FkvQsKqA66epWg2moIocCMUsfmU3r3xUxUi1+FfKCTTPPtsSvaBXczlaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIt+lyWQZKcoT3/1tGcAgsGLAuXQT1tmmTRv6lw5y3k=;
 b=y3XQ3ZjjjLnuarR68pq7gZB27tBLulr9bKNCBx8v7dBui97RT+XNhFz5FuJa4WZBMtN/4u68BGOLUH+he0T1ukMW/ONCBxGtIK34wSMKT2NTGSbmGdlvNikd/viJqSkSZ32R1MRWYt145BzB6rHI6R2p6LeoJpRpL8ZhiRIooNLBMAWn+ytRl07fA0gcKK6GgYBEqcKPiXRgtrB/fG4EMOdSPaywtFQgZQ2tXSNbDc6TC+iA/X49WfYVzhg3TpJYYRhwlFN7wA3iGL1SQEPf7O+xkDc37qnRVdQkWiCzKKfW6IfHugj+tO8b3KQ1g69azW1u9wQRdjtCJOEm0QWUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIt+lyWQZKcoT3/1tGcAgsGLAuXQT1tmmTRv6lw5y3k=;
 b=N36KUEiJUBeCdcaXTxK10ByPLjdDa7Qn1xqw9uuKxIbKKLH38qEg7DHwvdwFHyDyi4wROKFdrOH+6mHyOnpeIH8tY4hvFXASg1pbmemE6RirJ/g3hBhJ2dHakqVoQAdbq/eBigUuL18ZEdzkr4uNdH88zhyw9LA07HRjszXC9e2aHVuB1lzMovPpjeI+pdeEaU7UgfK/+c9bluZiptAqBrBLkZn9IkcRmq/Usbt/9jiUyPEMYP0T2G5ajoWmqgqHmqcf61yoHYWjgbdXaXPQkcLcMMSLzCK9OihkRiOM/LNFZw2d5FV3BFJ8jLV787a8NnuQBUKu8RR/GKTn/UexBQ==
Received: from SJ2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:a03:505::14)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.36; Sat, 22 Mar 2025 10:59:32 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::91) by SJ2PR07CA0024.outlook.office365.com
 (2603:10b6:a03:505::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Sat,
 22 Mar 2025 10:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sat, 22 Mar 2025 10:59:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Mar
 2025 03:59:31 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Mar
 2025 03:59:27 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <bruce.richardson@intel.com>,
 <getelson@nvidia.com>, <harry.van.haaren@intel.com>, <igootorov@gmail.com>,
 <mkashani@nvidia.com>, <stephen@networkplumber.org>, <thomas@monjalon.net>
Subject: [PATCH v4] rust: support raw DPDK API
Date: Sat, 22 Mar 2025 12:59:11 +0200
Message-ID: <20250322105911.12378-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: ff43512c-4105-4858-f3fe-08dd6930a03f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2yCwr46wfM174wIXB9GOLqBVKOE8hRqrmbT/emvqVWZlbMR1vjkNoFAbvoRz?=
 =?us-ascii?Q?q9jA7Lg5so3tWQVDQulVGCWTHh93TNfi01fkciE8+5SZJIg9MhMJb5z+5/UZ?=
 =?us-ascii?Q?9RxIjV6aCQzkxQ7H9BTAp9CRMaw+Mrn/yCNHIS53mYsa7wUATqDLnb3q6dZg?=
 =?us-ascii?Q?TSaPTkH0sFWFvj5PwVaF4h1Y3EGuRcyOhebAUU0LL41aXZl7s5kLDTmMXgCv?=
 =?us-ascii?Q?hl+DdwRvneTdu4Hq5GJd3+t61Nq+XBkrDtC3vCQ6HVcbgrclvahmXE9tFOQe?=
 =?us-ascii?Q?LhNYkjUEnmFV35088Q8/JSc3iGb4RpgjTSpFjgZaCuVVUBShSa1NEA7mij+c?=
 =?us-ascii?Q?ljd1FTA4G66Awg6Mq2M21iCQq6MbrjkeNTcxLFozdPu5fjbi8LeWSKX05kyF?=
 =?us-ascii?Q?dBYJS+35giHMN0iUXUYc29puaXoArXt37GEUMRUvpOgitnNHXZAsy9PcIGq6?=
 =?us-ascii?Q?z/gy+Z/e3YN/CTVYyoINZmNUKKPFy9S9+ofyoLbzfdkRRGp3xsb7memVG4Ui?=
 =?us-ascii?Q?aPSrlQRt2whzLeTSYTaqJvLygv17y0k3QRnqgUAZ1FfvPfS8BZBZOQvbm+uq?=
 =?us-ascii?Q?PVbxYp8JQtA4zom9CYylGFW/8ryDWEJUyf89paIaUJVl2ROZ6aQkfDZZLZKS?=
 =?us-ascii?Q?TZZPXplsXbFpAZpldEMuiZw9Sun+L0uT1rRNBTw65383M/is/JxWWSF/PxHC?=
 =?us-ascii?Q?pyY0JL1GeCkpYlvrOsLkeRs9bcx7Y7bCV7dKD3HoS86+YJxIxo8tB/O6a6v1?=
 =?us-ascii?Q?vIzRhbnFmcfF6IdkBDGHhvAG7MLnDfTDZMkjbVVSk0/3zjSmzn5q2xg4Gt0s?=
 =?us-ascii?Q?wQqj1DSR3X7Sqs9wCgq0LcdAYsZ1s/+1SwKPchjz19Hwz+Xmtt7EaW1fX8yO?=
 =?us-ascii?Q?MjX5aRX/ZEVEL4qXte7bcMOz7/tUyGkefUm6Mzdwrj9cjbWDzhkUIww9kU/e?=
 =?us-ascii?Q?yGvqgaEUIpnGDTtLdjN5AUPrri5Ut59slvzBpRvQLc8LorUiqOTBqUmDR0ua?=
 =?us-ascii?Q?t/7hm9gK/XKD8pOrjfhemkeSDTzObSWN0dCT/kxz1NGQLUaZtidY+A2k3pP6?=
 =?us-ascii?Q?4CA19FN25d6/LVKzl7epijkM1UEDiswS1/50cRNgEvhL2FyyfhymR5eAMruc?=
 =?us-ascii?Q?DrWn4tbeHosPJAiGxEc62hzzJzl/ucleT0EaQlo6ejZbjpPLAUqshP6sGJTR?=
 =?us-ascii?Q?hwNf2JKrfEL3bOiLfWzla2/KJzqMi95dFfT98d9cR6wSg8Xy+TbWy1LIS828?=
 =?us-ascii?Q?ZiiFuSFWDIQtvdef6HynrToY00aQXDm38Aiuum/KfiTfVjy3bAnWU5BqBmG2?=
 =?us-ascii?Q?G0+cWmAgxrTIVT4bz3N66uBf7kEBT5ZLh7qzyIiFzu0NTVmZPuuJHa0ie7HU?=
 =?us-ascii?Q?q6457vCy8ag21RGGZYZg5tjZV3yIrEqxhgevgKL+Tp+v6EJMnHZCmEzM0yTw?=
 =?us-ascii?Q?Znh6kGuZrYRyTw058pL7aTImgLmffj9IEFqyFbA0KDIfglPvdnJHt7pfB5bD?=
 =?us-ascii?Q?BhpC2BJNIUFlXLA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 10:59:32.4058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff43512c-4105-4858-f3fe-08dd6930a03f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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

The patch converts include files with DPDK API to RUST and binds new
RUST API files into raw module under dpdk crate.

The RUST files and DPDK libraries build from C sources
allow creation of DPDK application in RUST.

RUST DPDK application must specify the `dpdk` crate as
dependency in Cargo.toml file.

RUST `dpdk` crate is installed into
$MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust directory.

Software requirements:
- clang
- RUST installation
- bindgen-cli crate

RUST dpdk installation instructions:
1. Configure DPDK with `-Deanble_rust=true`
2. Build and install DPDK. The installation procedure will create
   $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust crate.
3. Update PKG_CONFIG_PATH to point to DPDK installation.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
v2:
Change rust crate name from dpdklib to dpdk.
Add raw module for to link with C API.
Add "cargo:rerun-if-changed=build.rs".
v3:
Move init_port_config() to Port.
Move start_port() to Port.
Remove Cargo.lock from git repository
Reformat code.
v4:
Blocked bindgen to convert stdlib functions with u128 type.
Allow compilation of C style symbols.
---
 buildtools/meson.build               |   4 +
 buildtools/rust-env.sh               |  96 ++++++++++++
 examples/rust/helloworld/Cargo.toml  |   7 +
 examples/rust/helloworld/build.rs    |  24 +++
 examples/rust/helloworld/src/main.rs | 219 +++++++++++++++++++++++++++
 meson_options.txt                    |   2 +
 6 files changed, 352 insertions(+)
 create mode 100755 buildtools/rust-env.sh
 create mode 100644 examples/rust/helloworld/Cargo.toml
 create mode 100644 examples/rust/helloworld/build.rs
 create mode 100644 examples/rust/helloworld/src/main.rs

diff --git a/buildtools/meson.build b/buildtools/meson.build
index 4e2c1217a2..b9d0092f07 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -50,3 +50,7 @@ else
     pmdinfo += 'ar'
     pmdinfogen += 'elf'
 endif
+
+if get_option('enable_rust')
+    meson.add_install_script(['rust-env.sh', get_option('libdir')])
+endif
diff --git a/buildtools/rust-env.sh b/buildtools/rust-env.sh
new file mode 100755
index 0000000000..a239432a28
--- /dev/null
+++ b/buildtools/rust-env.sh
@@ -0,0 +1,96 @@
+#! /bin/sh
+
+# Convert DPDK API files into RUST.
+# DPDK files selection is on demand.
+#
+# The coversion is done in 4 stages:
+# 1. Preparation [Optional]
+#    Due to the bindgen conversion utility limitations source file may need
+#    manual adjustment.
+# 2. Preprocessing [Mandatory]
+#    Run preprocessor on a source file before conversion.
+# 3. Conversion [Mandatory]
+#    Convert preprocessed C file into RUST file
+# 4. Post translation [Optional]
+#    Manually fix translation.
+
+# DPDK files list
+files='
+rte_build_config.h
+rte_eal.h
+rte_ethdev.h
+rte_mbuf.h
+rte_mbuf_core.h
+rte_mempool.h
+'
+libdir="$1"
+rust_dir="${MESON_INSTALL_DESTDIR_PREFIX}/$libdir/rust"
+include_dir="${MESON_INSTALL_DESTDIR_PREFIX}/include"
+
+if test -d "$rust_dir"; then
+  rm -rf "$rust_dir"
+fi
+
+mkdir -p "$rust_dir/src/raw"
+if ! test -d "$rust_dir"; then
+  echo "failed to create Rust library $rust_dir"
+  exit 255
+fi
+
+bindgen_opt='--no-layout-tests
+ --no-derive-debug
+ --blocklist-function qecvt_r
+ --blocklist-function qfcvt_r
+ --blocklist-function qfcvt
+ --blocklist-function qgcvt
+ --blocklist-function qecvt
+ --blocklist-function strtold
+ '
+
+bindgen_clang_opt='-Wno-unused-command-line-argument'
+
+create_rust_lib ()
+{
+  base=$1
+
+  cp $include_dir/${base}.h /tmp/${base}.h
+
+# bindgen cannot process complex macro definitions
+# manually simplify macros before conversion
+  sed -i -e 's/RTE_BIT64(\([0-9]*\))/(1UL << \1)/g' /tmp/${base}.h
+  sed -i -e 's/RTE_BIT32(\([0-9]*\))/(1U << \1)/g' /tmp/${base}.h
+  sed -i -e 's/UINT64_C(\([0-9]*\))/\1/g' /tmp/${base}.h
+
+  # clang output has better integration with bindgen than GCC
+  clang -E -dD -I$include_dir /tmp/${base}.h > /tmp/$base.i
+  bindgen $bindgen_opt --output $rust_dir/src/raw/$base.rs /tmp/$base.i -- $bindgen_clang_opt
+  rm -f /tmp/$base.i /tmp/$base.h
+}
+
+cat > "$rust_dir/src/lib.rs" <<EOF
+#[allow(non_camel_case_types)]
+#[allow(non_upper_case_globals)]
+#[allow(non_snake_case)]
+
+pub mod raw;
+EOF
+
+touch "$rust_dir/src/raw/mod.rs"
+for file in $files; do
+  base=$(basename $file | cut -d. -f 1)
+  create_rust_lib $base
+  echo "pub mod $base;" >> "$rust_dir/src/raw/mod.rs"
+done
+
+cat > "$rust_dir/Cargo.toml" <<EOF
+[package]
+name = "dpdk"
+version = "$(cat ${MESON_SOURCE_ROOT}/VERSION | sed 's/\.0\([1-9]\)/\.\1/')"
+EOF
+
+# post conversion updates
+# RUST does not accept aligned structures into packed structure.
+# TODO: fix DPDK definitions.
+sed -i 's/repr(align(2))/repr(packed(2))/g'  "$rust_dir/src/raw/rte_ethdev.rs"
+
+echo "Install RUST DPDK crate in $rust_dir"
diff --git a/examples/rust/helloworld/Cargo.toml b/examples/rust/helloworld/Cargo.toml
new file mode 100644
index 0000000000..ceeecf958d
--- /dev/null
+++ b/examples/rust/helloworld/Cargo.toml
@@ -0,0 +1,7 @@
+[package]
+name = "helloworld"
+version = "0.1.0"
+edition = "2024"
+
+[dependencies]
+dpdk = {path = $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust }
diff --git a/examples/rust/helloworld/build.rs b/examples/rust/helloworld/build.rs
new file mode 100644
index 0000000000..bd5737d209
--- /dev/null
+++ b/examples/rust/helloworld/build.rs
@@ -0,0 +1,24 @@
+use std::process::Command;
+
+pub fn main() {
+    let mut pkgconfig = Command::new("pkg-config");
+
+    match pkgconfig.args(["--libs", "libdpdk"]).output() {
+        Ok(output) => {
+            let stdout = String::from_utf8_lossy(&output.stdout)
+                .trim_end()
+                .to_string();
+            for token in stdout.split_ascii_whitespace().filter(|s| !s.is_empty()) {
+                if token.starts_with("-L") {
+                    println!("cargo::rustc-link-search=native={}", &token[2..]);
+                } else if token.starts_with("-l") {
+                    println!("cargo::rustc-link-lib={}", &token[2..]);
+                }
+            }
+            println!("cargo:rerun-if-changed=build.rs");
+        }
+        Err(error) => {
+            panic!("failed to read libdpdk package: {:?}", error);
+        }
+    }
+}
diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/helloworld/src/main.rs
new file mode 100644
index 0000000000..0c057cb39f
--- /dev/null
+++ b/examples/rust/helloworld/src/main.rs
@@ -0,0 +1,219 @@
+/// Usage: helloworld -a <port 1 params> -a <port 2 params> ...
+use std::env;
+use std::ffi::CStr;
+use std::ffi::CString;
+use std::os::raw::{c_char, c_int};
+
+use dpdk::raw::rte_eal::{
+    rte_eal_cleanup,
+    // Functions
+    rte_eal_init,
+};
+
+use dpdk::raw::rte_ethdev::{
+    RTE_ETH_DEV_NO_OWNER,
+    RTE_ETH_NAME_MAX_LEN,
+    RTE_ETH_RSS_IP,
+    rte_eth_conf,
+    rte_eth_dev_configure,
+    // Functions
+    rte_eth_dev_get_name_by_port,
+    // Structures
+    rte_eth_dev_info,
+    rte_eth_dev_info_get,
+    rte_eth_dev_start,
+    rte_eth_find_next_owned_by,
+    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS,
+    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS,
+
+    rte_eth_rx_queue_setup,
+    rte_eth_rxconf,
+
+    rte_eth_tx_queue_setup,
+    rte_eth_txconf,
+};
+
+use dpdk::raw::rte_build_config::RTE_MAX_ETHPORTS;
+
+use dpdk::raw::rte_mbuf::rte_pktmbuf_pool_create;
+
+use dpdk::raw::rte_mbuf_core::RTE_MBUF_DEFAULT_BUF_SIZE;
+
+pub type DpdkPort = u16;
+pub struct Port {
+    pub port_id: DpdkPort,
+    pub dev_info: rte_eth_dev_info,
+    pub dev_conf: rte_eth_conf,
+    pub rxq_num: u16,
+    pub txq_num: u16,
+}
+
+impl Port {
+    unsafe fn new(id: DpdkPort) -> Self {
+        Port {
+            port_id: id,
+            dev_info: unsafe {
+                let uninit: ::std::mem::MaybeUninit<rte_eth_dev_info> =
+                    ::std::mem::MaybeUninit::zeroed().assume_init();
+                *uninit.as_ptr()
+            },
+            dev_conf: unsafe {
+                let uninit: ::std::mem::MaybeUninit<rte_eth_conf> =
+                    ::std::mem::MaybeUninit::zeroed().assume_init();
+                *uninit.as_ptr()
+            },
+            rxq_num: 1,
+            txq_num: 1,
+        }
+    }
+
+    pub unsafe fn init_port_config(&mut self) {
+        let ret = unsafe {
+            rte_eth_dev_info_get(self.port_id, &mut self.dev_info as *mut rte_eth_dev_info)
+        };
+        if ret != 0 {
+            panic!("self-{}: failed to get dev info {ret}", self.port_id);
+        }
+
+        self.dev_conf.rx_adv_conf.rss_conf.rss_key = std::ptr::null_mut();
+        self.dev_conf.rx_adv_conf.rss_conf.rss_hf = if self.rxq_num > 1 {
+            RTE_ETH_RSS_IP as u64 & self.dev_info.flow_type_rss_offloads
+        } else {
+            0
+        };
+
+        if self.dev_conf.rx_adv_conf.rss_conf.rss_hf != 0 {
+            self.dev_conf.rxmode.mq_mode = rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS
+                & rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS;
+        }
+    }
+
+    unsafe fn start_port(&mut self) {
+        let mut rc = unsafe {
+            rte_eth_dev_configure(
+                self.port_id,
+                self.rxq_num,
+                self.txq_num,
+                &self.dev_conf as *const rte_eth_conf,
+            )
+        };
+        if rc != 0 {
+            panic!("failed to configure self-{}: {rc}", self.port_id)
+        }
+        println!("self-{} configured", self.port_id);
+
+        rc = unsafe { rte_eth_tx_queue_setup(self.port_id, 0, 64, 0, 0 as *const rte_eth_txconf) };
+        if rc != 0 {
+            panic!("self-{}: failed to configure TX queue 0 {rc}", self.port_id)
+        }
+        println!("self-{} configured TX queue 0", self.port_id);
+
+        let mbuf_pool_name = CString::new(format!("mbuf pool self-{}", self.port_id)).unwrap();
+        let mbuf_pool: *mut dpdk::raw::rte_mbuf::rte_mempool = unsafe {
+            rte_pktmbuf_pool_create(
+                mbuf_pool_name.as_ptr(),
+                1024,
+                0,
+                0,
+                RTE_MBUF_DEFAULT_BUF_SIZE as u16,
+                0,
+            )
+        };
+        if mbuf_pool == 0 as *mut dpdk::raw::rte_mbuf::rte_mempool {
+            panic!("self-{}: failed to allocate mempool {rc}", self.port_id)
+        }
+        println!("self-{} mempool ready", self.port_id);
+
+        let mut rxq_conf: rte_eth_rxconf = self.dev_info.default_rxconf.clone();
+        rxq_conf.offloads = 0;
+        rc = unsafe {
+            rte_eth_rx_queue_setup(
+                self.port_id,
+                0,
+                64,
+                0,
+                &mut rxq_conf as *mut rte_eth_rxconf,
+                mbuf_pool as *mut dpdk::raw::rte_ethdev::rte_mempool,
+            )
+        };
+        if rc != 0 {
+            panic!("self-{}: failed to configure RX queue 0 {rc}", self.port_id)
+        }
+        println!("self-{} configured RX queue 0", self.port_id);
+        rc = unsafe { rte_eth_dev_start(self.port_id) };
+        if rc != 0 {
+            panic!("failed to start self-{}: {rc}", self.port_id)
+        }
+        println!("self-{} started", self.port_id);
+    }
+}
+
+pub unsafe fn iter_rte_eth_dev_owned_by(owner_id: u64) -> impl Iterator<Item = DpdkPort> {
+    let mut port_id: DpdkPort = 0 as DpdkPort;
+    std::iter::from_fn(move || {
+        let cur = port_id;
+        port_id = unsafe { rte_eth_find_next_owned_by(cur, owner_id) as DpdkPort };
+        if port_id == RTE_MAX_ETHPORTS as DpdkPort {
+            return None;
+        }
+        if cur == port_id {
+            port_id += 1
+        }
+        Some(cur)
+    })
+}
+
+pub unsafe fn iter_rte_eth_dev() -> impl Iterator<Item = DpdkPort> {
+    unsafe { iter_rte_eth_dev_owned_by(RTE_ETH_DEV_NO_OWNER as u64) }
+}
+
+pub unsafe fn show_ports_summary(ports: &Vec<Port>) {
+    let mut name_buf: [c_char; RTE_ETH_NAME_MAX_LEN as usize] =
+        [0 as c_char; RTE_ETH_NAME_MAX_LEN as usize];
+    let title = format!("{:<4}    {:<32} {:<14}", "Port", "Name", "Driver");
+    println!("{title}");
+    ports.iter().for_each(|p| unsafe {
+        let _rc = rte_eth_dev_get_name_by_port(p.port_id, name_buf.as_mut_ptr());
+        let name = CStr::from_ptr(name_buf.as_ptr());
+        let drv = CStr::from_ptr(p.dev_info.driver_name);
+        let summary = format!(
+            "{:<4}    {:<32} {:<14}",
+            p.port_id,
+            name.to_str().unwrap(),
+            drv.to_str().unwrap()
+        );
+        println!("{summary}");
+    });
+}
+
+fn main() {
+    let mut argv: Vec<*mut c_char> = env::args()
+        .map(|arg| CString::new(arg).unwrap().into_raw())
+        .collect();
+
+    let rc = unsafe { rte_eal_init(env::args().len() as c_int, argv.as_mut_ptr()) };
+    if rc == -1 {
+        unsafe {
+            rte_eal_cleanup();
+        }
+    }
+
+    let mut ports: Vec<Port> = vec![];
+    unsafe {
+        for port_id in
+            iter_rte_eth_dev().take(dpdk::raw::rte_build_config::RTE_MAX_ETHPORTS as usize)
+        {
+            let mut port = Port::new(port_id);
+            port.init_port_config();
+            println!("init port {port_id}");
+            port.start_port();
+            ports.push(port);
+        }
+    }
+
+    unsafe {
+        show_ports_summary(&ports);
+    }
+
+    println!("Hello, world!");
+}
diff --git a/meson_options.txt b/meson_options.txt
index e49b2fc089..d37b9ba1dc 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -60,3 +60,5 @@ option('tests', type: 'boolean', value: true, description:
        'build unit tests')
 option('use_hpet', type: 'boolean', value: false, description:
        'use HPET timer in EAL')
+option('enable_rust', type: 'boolean', value: false, description:
+       'enable RUST')
-- 
2.45.2

