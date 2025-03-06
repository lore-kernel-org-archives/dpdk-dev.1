Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68985C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:38:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACFC74065F;
	Thu,  6 Mar 2025 14:38:00 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by mails.dpdk.org (Postfix) with ESMTP id 9CEDF40430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:37:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySVkPY1m1gl1s70mvkdA91YjK3/UYy970x+XTGNvgle+m2WMHmIEFP2Lo6ncJxjm8cZjP2zG9l5xugNrfSX90chb+Qm0hbtdHYGHmr5jRZRNuq5TYxniafLcKoEPhnbxWCU7ad26VU/EZhxeWg7fNZREUDyAHZiuLjKZEsQR6DyzSlXAv8MHsPpDRw6BG7/w774K+XipAuf723n7uuHcI7WB02vxDsD33I+II8mo/JM4s+DhdQqLK0L6KdUj5YWKBCkp8uXR1y/2tklTBYH4xsf0giRklSSLIm4bxvdVLX/AzWI9hL1C2ehGfXvzXgyLPtq9L+P3MZCY0jdr52w49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4aIOcqj7shxI24pblwEWILSjTVyWeY/ly3+YDDlNEo=;
 b=bLt88LAByQxadjYzdA7jz4OuA01XfPhahE5hosJ5F/rmi/oZBoQCiuLst++czpt5aFfDlFrUlFaUfYz+ohpBWOH87uNPDrO4fXZYPMqoWPTA6Kr29L7J2ezLQsGtdE4ZXLZL5eEjZHDGKxWKHMPKRrell9lYpdwUtalqlUtoCd240VyMoYITgubcdXdNYLRqoqxd9nrhqkQaccgdAmW4jGKEpmY91+8+bANJ0TrTkPL9VkrlapQAQb5NL6dU08l7jDvLiviJe0W1dYxKCoyhup35bMcvq8C99inGRdqm4NKcWiG90J9PHswHH9bIHdv8K4ymJKfxfWJbbEhxzGdnaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4aIOcqj7shxI24pblwEWILSjTVyWeY/ly3+YDDlNEo=;
 b=fxZPtTuaA1eyzQGk+JBdxxMuOCkoQTjn9JccQjY/KkUtquooDn4cRhxdhh56NC0jpRcZyrILCcZ6J9kPrntc51GEolZQDPPt+lHB+uy0NlO+cW82cAZ0g15/ZSvg5rarIYufneUd7vm8Oj3wMLjcHF2yjIEvjoSTcPolalgBkqueCTWnIVmNZW34IbqZCbirFDZHiDoHH+YLDT8MPypuZy8TNTg3eRmOkEzntX7MIrGy3JqqJWDBHAumYCm46EyNqMK6FytCpd9XfrKwDFf4OL5otwsz+QxCniIxz48Yq4HBR/1HqavH8vRSG7Ecl3YtESPqxM5nDYM3hvywj+NY6g==
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 13:37:53 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:33e:cafe::40) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 13:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8549.1 via Frontend Transport; Thu, 6 Mar 2025 13:37:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 05:37:32 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 05:37:29 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <thomas@monjalon.net>, <mkashani@nvidia.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Subject: [PATCH] rust: support DPDK API
Date: Thu, 6 Mar 2025 15:37:13 +0200
Message-ID: <20250306133713.393057-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da234d0-f6c9-495f-85e3-08dd5cb41848
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tu649JjWHQjv+xEeh4uu90ywLE8RfzIv9oDWECZBrOgh3nLmDb0vGAzesu9i?=
 =?us-ascii?Q?9TdhK2tRywxR3kEIpd0jN9uejgEdTMIAIGKqBsh2uV/x7/LiOvGyYfn6kZm1?=
 =?us-ascii?Q?bdiaEDrdSoLJHJul3aUZ2kb5XWkHfBqNBJlFEV9/vpur6UNlfZ/SG6q0hIzA?=
 =?us-ascii?Q?KoE6RHAxOl1ldyEpKPxK1A1Jp6HCHkqIFXHpLPVWwhrpOppgBrIwIxMcvkx+?=
 =?us-ascii?Q?JJm0k/gFizEVQEKelxR5XxzsoOGhMXottmSkxcD/W7VxFZzZWzLqqreSRQBm?=
 =?us-ascii?Q?LHm94yMl6h12F72LP9u/G0Huf6p9BxDgUbV4uWeuRGW6F4Lc3TS6QU6KA2o3?=
 =?us-ascii?Q?14rv6yWR7WGCKW/OfVYESluN6LYdxyi2wl1ZX7ARvPLtUH8VWeXEn0Jdf3LW?=
 =?us-ascii?Q?cEi4VMa0ep846AfSwDbfPmSTQOWPxi1Jwwc/vVan5W+317x4kQj4K8iIg29r?=
 =?us-ascii?Q?XCMrsyio9LrG1zFp/AtgGNs1kb5kdLQt0cmbDwhjEX6W9EC7E3ZDrPMXXIeX?=
 =?us-ascii?Q?nP7AXQMCTo3xwv6bbl82y7Vn4tycD5yLGHp7LqSUIkKggmxK1bxNGZ6c2hAh?=
 =?us-ascii?Q?5UADbpf0Cfmct4qMJvJ8j3f9oU8DyOwJMYG7sSNATEjSIWhAGC2uZ/jvbRvn?=
 =?us-ascii?Q?mdjFEzxgf5H272tX7s0zgWu5Ysqe0Wpv218Q1DoHOn3mzYnDa79QNydrz8cg?=
 =?us-ascii?Q?oyADOdnOHrRAa1wW7taOeh4WOiZYpwj7VCvKJOU8FZkXRDy5XYcJn8oOjsJa?=
 =?us-ascii?Q?H0e7h63idoY1OLjizeopppApK8updFifQnHzafNbSK9xNCbUightV2cULHpq?=
 =?us-ascii?Q?Wc9W1qowuvwux78JJMIpKEDo8v+EsGvJ8Iq9VJEKWcH/4BGjmifphtsPKx2B?=
 =?us-ascii?Q?Ee/OpufxN+lMlVd7MG7ioIADuBVrjZKmc4L+Ses4aw/VDSC4jd8EO7gePSdr?=
 =?us-ascii?Q?CjXvdhdQFkKYSP8jkBXQ3Tk18EsvPSd3VPQDiXlx6yoAJ9hh1L1IzalGMU0b?=
 =?us-ascii?Q?uH8UQDbRH9fj2+SVjR9FwDsSWD0iIFBgqwPwmyimj723nHZ6EanXlSCMyjfQ?=
 =?us-ascii?Q?l9ewBkSWTVoK0L30scFHwaOzlJLbQcagZVTbuEmE9rfDoqLK/oSr/UEuCHJB?=
 =?us-ascii?Q?AWiwI9owb9Yb31pY91Zzg0IwHL895ynRW5jDl5tladshY6i99R2b2Q4Kcb0J?=
 =?us-ascii?Q?tkfCO1s+iPwPFtzIpR+IowGVF2XJKHRMhZSGSo/HTRPL5RBtD6IeZsHzdG1k?=
 =?us-ascii?Q?O0ur62QR/I14KcW4M7De25lVnzKkea7nmwsqUOT+2vau7rFV20m6GOXBgsQh?=
 =?us-ascii?Q?Cy4+mJhtw/q2X5IPcAega8lEOyg22k62gdUL0QomrfBP4KNe+fdCRddo+P+d?=
 =?us-ascii?Q?rwcf+Oo/hk8m7hwIwmAyHKEv/gl++CvEcUWKY0LUG50tQSsVWY7sL1bvjNZm?=
 =?us-ascii?Q?PZl1hUq5CXU7agCe2shoylQ2sL7DRy/AwXPImUp0rkl5FP104JkTRpPiwI44?=
 =?us-ascii?Q?Y0zOdltoHqaYKsk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 13:37:52.6815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da234d0-f6c9-495f-85e3-08dd5cb41848
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
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
RUST API files info dpdklib package.

The RUST dpdklib files and DPDK libraries build from C sources
allow creation of DPDK application in RUST.

RUST DPDK application must specify the `dpdklib` package as
dependency in Cargo.toml file.

RUST `dpdklib` package is installed into
MESON_INSTALL_DESTDIR_PREFIX/rust directory.

Software requirements:
- clang
- RUST installation
- bindgen-cli crate

RUST dpdklib installation instructions:
1. Configure DPDK with `-Deanble_rust=true`
2. Build and install DPDK. The installation procedure will create
   MESON_INSTALL_DESTDIR_PREFIX/rust directory.
3. Update PKG_CONFIG_PATH to point to DPDK installation.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 buildtools/meson.build               |   4 +
 buildtools/rust-env.sh               |  78 +++++++++++
 examples/rust/helloworld/Cargo.lock  |  14 ++
 examples/rust/helloworld/Cargo.toml  |   7 +
 examples/rust/helloworld/build.rs    |  21 +++
 examples/rust/helloworld/src/main.rs | 197 +++++++++++++++++++++++++++
 meson_options.txt                    |   2 +
 7 files changed, 323 insertions(+)
 create mode 100755 buildtools/rust-env.sh
 create mode 100644 examples/rust/helloworld/Cargo.lock
 create mode 100644 examples/rust/helloworld/Cargo.toml
 create mode 100644 examples/rust/helloworld/build.rs
 create mode 100644 examples/rust/helloworld/src/main.rs

diff --git a/buildtools/meson.build b/buildtools/meson.build
index 4e2c1217a2..dd16567f51 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -50,3 +50,7 @@ else
     pmdinfo += 'ar'
     pmdinfogen += 'elf'
 endif
+
+if get_option('enable_rust')
+    meson.add_install_script('rust-env.sh')
+endif
diff --git a/buildtools/rust-env.sh b/buildtools/rust-env.sh
new file mode 100755
index 0000000000..705bc0d95b
--- /dev/null
+++ b/buildtools/rust-env.sh
@@ -0,0 +1,78 @@
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
+
+rust_dir="${MESON_INSTALL_DESTDIR_PREFIX}/rust"
+include_dir="${MESON_INSTALL_DESTDIR_PREFIX}/include"
+
+if test -d "$rust_dir"; then
+  rm -rf "$rust_dir"
+fi
+
+mkdir -p "$rust_dir/src"
+if ! test -d "$rust_dir"; then
+  echo "failed to create Rust library $rust_dir"
+  exit 255
+fi
+touch "$rust_dir/src/lib.rs"
+
+bindgen_opt='--no-layout-tests --no-derive-debug'
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
+  bindgen $bindgen_opt --output $rust_dir/src/$base.rs /tmp/$base.i -- $bindgen_clang_opt
+  rm -f /tmp/$base.i /tmp/$base.h
+}
+
+for file in $files; do
+  base=$(basename $file | cut -d. -f 1)
+  create_rust_lib $base
+  echo "pub mod $base;" >> "$rust_dir/src/lib.rs"
+done
+
+
+cat > "$rust_dir/Cargo.toml" <<EOF
+[package]
+name = "dpdklib"
+version = "$(cat $MESON_SOURCE_ROOT/VERSION | sed 's/\.0\([1-9]\)/\.\1/')"
+EOF
+
+# post conversion updates
+# RUST does not accept aligned structures into packed structure.
+# TODO: fix DPDK definitions.
+sed -i 's/repr(align(2))/repr(packed(2))/g'  "$rust_dir/src/rte_ethdev.rs"
diff --git a/examples/rust/helloworld/Cargo.lock b/examples/rust/helloworld/Cargo.lock
new file mode 100644
index 0000000000..d18af80c66
--- /dev/null
+++ b/examples/rust/helloworld/Cargo.lock
@@ -0,0 +1,14 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 4
+
+[[package]]
+name = "dpdklib"
+version = "25.3.0-rc1"
+
+[[package]]
+name = "helloworld"
+version = "0.1.0"
+dependencies = [
+ "dpdklib",
+]
diff --git a/examples/rust/helloworld/Cargo.toml b/examples/rust/helloworld/Cargo.toml
new file mode 100644
index 0000000000..7f9a77968a
--- /dev/null
+++ b/examples/rust/helloworld/Cargo.toml
@@ -0,0 +1,7 @@
+[package]
+name = "helloworld"
+version = "0.1.0"
+edition = "2024"
+
+[dependencies]
+dpdklib = {path = "MESON_INSTALL_DESTDIR_PREFIX/rust"}
\ No newline at end of file
diff --git a/examples/rust/helloworld/build.rs b/examples/rust/helloworld/build.rs
new file mode 100644
index 0000000000..5c76188e18
--- /dev/null
+++ b/examples/rust/helloworld/build.rs
@@ -0,0 +1,21 @@
+use std::process::Command;
+
+pub fn main() {
+    let mut pkgconfig = Command::new("pkg-config");
+
+    match pkgconfig.args(["--libs", "libdpdk"]).output() {
+        Ok (output) => {
+            let stdout = String::from_utf8_lossy(&output.stdout).trim_end().to_string();
+            for token in stdout.split_ascii_whitespace().filter(|s| !s.is_empty()) {
+                if token.starts_with("-L") {
+                    println!("cargo::rustc-link-search=native={}", &token[2..]);
+                } else if token.starts_with("-l") {
+                    println!("cargo::rustc-link-lib={}", &token[2..]);
+                }
+            }
+        }
+        Err(error) => {
+            panic!("failed to read libdpdk package: {:?}", error);
+        }
+    }
+}
diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/helloworld/src/main.rs
new file mode 100644
index 0000000000..cf666aece6
--- /dev/null
+++ b/examples/rust/helloworld/src/main.rs
@@ -0,0 +1,197 @@
+/// Usage: helloworld -a <port 1 params> -a <port 2 params> ...
+
+use std::env;
+use std::ffi::{CString};
+use std::os::raw::{c_int, c_char};
+use std::ffi::CStr;
+
+use dpdklib::rte_eal::{
+    // Functions
+    rte_eal_init,
+    rte_eal_cleanup,
+};
+
+use dpdklib::rte_ethdev::{
+    RTE_ETH_NAME_MAX_LEN,
+    RTE_ETH_DEV_NO_OWNER,
+    RTE_ETH_RSS_IP,
+    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS,
+    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS,
+
+    // Structures
+    rte_eth_dev_info,
+    rte_eth_conf,
+    rte_eth_txconf,
+    rte_eth_rxconf,
+
+    // Functions
+    rte_eth_dev_get_name_by_port,
+    rte_eth_find_next_owned_by,
+    rte_eth_dev_info_get,
+    rte_eth_dev_configure,
+    rte_eth_tx_queue_setup,
+    rte_eth_rx_queue_setup,
+    rte_eth_dev_start,
+};
+
+use dpdklib::rte_build_config::{
+    RTE_MAX_ETHPORTS,
+};
+
+use dpdklib::rte_mbuf::{
+    rte_pktmbuf_pool_create,
+};
+
+use dpdklib::rte_mbuf_core::{
+    RTE_MBUF_DEFAULT_BUF_SIZE
+};
+
+pub type DpdkPort = u16;
+pub struct Port {
+    pub port_id:DpdkPort,
+    pub dev_info:rte_eth_dev_info,
+    pub dev_conf:rte_eth_conf,
+    pub rxq_num:u16,
+    pub txq_num:u16,
+}
+
+impl Port {
+    unsafe fn new(id:DpdkPort) -> Self {
+        Port {
+            port_id:id,
+            dev_info: unsafe {
+                let uninit: ::std::mem::MaybeUninit<rte_eth_dev_info> = ::std::mem::MaybeUninit::zeroed().assume_init();
+                *uninit.as_ptr()
+            },
+            dev_conf: unsafe {
+                let uninit: ::std::mem::MaybeUninit<rte_eth_conf> = ::std::mem::MaybeUninit::zeroed().assume_init();
+                *uninit.as_ptr()
+            },
+            rxq_num:1,
+            txq_num:1,
+        }
+    }
+}
+
+pub unsafe fn iter_rte_eth_dev_owned_by(owner_id:u64) -> impl Iterator<Item=DpdkPort> {
+    let mut port_id:DpdkPort = 0 as DpdkPort;
+    std::iter::from_fn(move || {
+        let cur = port_id;
+        port_id = unsafe {
+            rte_eth_find_next_owned_by(cur, owner_id) as DpdkPort
+        };
+        if port_id == RTE_MAX_ETHPORTS as DpdkPort {
+            return None
+        }
+        if cur == port_id { port_id += 1 }
+        Some(cur)
+    })
+}
+
+pub unsafe fn iter_rte_eth_dev() -> impl Iterator<Item=DpdkPort> {
+    unsafe {
+      iter_rte_eth_dev_owned_by(RTE_ETH_DEV_NO_OWNER as u64)
+    }
+}
+
+pub unsafe fn init_port_config(port: &mut Port) {
+    let ret = unsafe {
+        rte_eth_dev_info_get(port.port_id, &mut port.dev_info as *mut rte_eth_dev_info)
+    };
+    if ret != 0 {
+        panic!("port-{}: failed to get dev info {ret}", port.port_id);
+    }
+
+    port.dev_conf.rx_adv_conf.rss_conf.rss_key = std::ptr::null_mut();
+    port.dev_conf.rx_adv_conf.rss_conf.rss_hf = if port.rxq_num > 1 {
+        RTE_ETH_RSS_IP as u64 & port.dev_info.flow_type_rss_offloads
+    } else {0};
+
+    if port.dev_conf.rx_adv_conf.rss_conf.rss_hf != 0 {
+        port.dev_conf.rxmode.mq_mode =
+            rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS & rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS;
+    }
+}
+
+pub unsafe fn show_ports_summary(ports: &Vec<Port>) {
+    let mut name_buf:[c_char;RTE_ETH_NAME_MAX_LEN as usize]= [0 as c_char;RTE_ETH_NAME_MAX_LEN as usize];
+    let title = format!("{:<4}    {:<32} {:<14}", "Port", "Name", "Driver");
+    println!("{title}");
+    ports.iter().for_each(|p| unsafe {
+        let _rc = rte_eth_dev_get_name_by_port(p.port_id, name_buf.as_mut_ptr());
+        let name = CStr::from_ptr(name_buf.as_ptr());
+        let drv = CStr::from_ptr(p.dev_info.driver_name);
+        let summary = format!("{:<4}    {:<32} {:<14}",
+                              p.port_id, name.to_str().unwrap(), drv.to_str().unwrap());
+        println!("{summary}");
+    });
+
+}
+unsafe fn start_port(port:&mut Port) {
+    let mut rc = unsafe {
+      rte_eth_dev_configure(port.port_id, port.rxq_num, port.txq_num,
+                            &port.dev_conf as *const rte_eth_conf)
+    };
+    if rc != 0 { panic!("failed to configure port-{}: {rc}", port.port_id)}
+    println!("port-{} configured", port.port_id);
+
+    rc = unsafe {
+      rte_eth_tx_queue_setup(port.port_id, 0, 64, 0, 0 as *const rte_eth_txconf)
+    };
+    if rc != 0 { panic!("port-{}: failed to configure TX queue 0 {rc}", port.port_id)}
+    println!("port-{} configured TX queue 0", port.port_id);
+
+    let mbuf_pool_name = CString::new(format!("mbuf pool port-{}", port.port_id)).unwrap();
+    let mbuf_pool : *mut dpdklib::rte_mbuf::rte_mempool = unsafe {
+        rte_pktmbuf_pool_create(mbuf_pool_name.as_ptr(), 1024, 0, 0,
+                                RTE_MBUF_DEFAULT_BUF_SIZE as u16, 0)
+    };
+    if mbuf_pool  == 0 as *mut dpdklib::rte_mbuf::rte_mempool {
+        panic!("port-{}: failed to allocate mempool {rc}", port.port_id)
+    }
+    println!("port-{} mempool ready", port.port_id);
+
+    let mut rxq_conf:rte_eth_rxconf = port.dev_info.default_rxconf.clone();
+    rxq_conf.offloads = 0;
+    rc = unsafe {
+        rte_eth_rx_queue_setup(port.port_id, 0, 64, 0,
+                               &mut rxq_conf as *mut rte_eth_rxconf,
+                               mbuf_pool as *mut dpdklib::rte_ethdev::rte_mempool)
+    };
+    if rc != 0 { panic!("port-{}: failed to configure RX queue 0 {rc}", port.port_id)}
+    println!("port-{} configured RX queue 0", port.port_id);
+    rc = unsafe {
+        rte_eth_dev_start(port.port_id)
+    };
+    if rc != 0 { panic!("failed to start port-{}: {rc}", port.port_id)}
+    println!("port-{} started", port.port_id);
+}
+
+fn main() {
+
+    let mut argv: Vec<*mut c_char> = env::args()
+        .map(|arg| CString::new(arg).unwrap().into_raw()).collect();
+
+    let rc = unsafe {
+        rte_eal_init(env::args().len() as c_int, argv.as_mut_ptr())
+    };
+    if rc == -1 {
+        unsafe { rte_eal_cleanup(); }
+    }
+
+    let mut ports:Vec<Port> = vec![];
+    unsafe {
+        for port_id in iter_rte_eth_dev()
+            .take(dpdklib::rte_build_config::RTE_MAX_ETHPORTS as usize) {
+            let mut port = Port::new(port_id);
+            init_port_config(&mut port);
+            println!("init port {port_id}");
+            start_port(&mut port);
+            ports.push(port);
+        }
+    }
+
+    unsafe { show_ports_summary(&ports); }
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

