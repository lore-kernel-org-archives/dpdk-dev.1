Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E4C282EC
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Mar 2025 18:51:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42FE5402A0;
	Sat,  8 Mar 2025 19:51:18 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by mails.dpdk.org (Postfix) with ESMTP id 1F6FA40280
 for <dev@dpdk.org>; Sat,  8 Mar 2025 19:51:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz1Zq385GGsS1paEmnWIz01BbmVwUFpzcRhf8NhhtZMBj2iCHRQmMjQGipO/G/PJCcmINv37uYgpSUSjxR9DIpB8oEjSl67z9+z5CyK1r5yDJrwoQ/SjPm1K/7tlp9jFdjwVoHu1uX3CBwY4O4oEhAnSYpbiqT55aC5y9Q4yhEUzA04I+QoYfWDmI+9MgNvIlVqywGa/VKf8eilhE9G/NFvZGeKIj4ExWbwX9hosjVPoS4gCjPl40uPcSc8lmnGK8ccE+uAC73i5W7QcSv3XhnU+OGRWAtQhYw4QpOmmgZtv2xxuizrf+uq5t7vtHz5i9NC0kCrXiUEJdirD5XBb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A43B6r4ro1MFv7l+/oJSkO7wRmqd1FzmzvRX3UcmKKY=;
 b=J5d3mFqLAd4Qqy2evw8uEA+zNM9vwu27PfXrVAesgsjdCzDOEXPCATakU+k2uHucgWL+EB2SbtNs+aqBHAFX+/Wkm2Nvf8bNlk0WnuwypMLce3dluJZdvXt/bIDpZJqAVqmzvWTbCSvBqdqS3bW5+rlYMOMBrOrYK2OKsAsG7kZGXIfTnXNY3fFVWPe//gtszw2aR6shKFlU79OABT58MT7+/GVYYoS/ZWdrJg65zSfhuJey6hy/JUDYEIAB3ti7FfCm9Rmo7BtAhc2l0r7Q8R/9NCKVzymYOoUeeDskborCTi+s7+0j9p9AkYJL7JDG8DG7GiU0VDTd619wi/7zHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A43B6r4ro1MFv7l+/oJSkO7wRmqd1FzmzvRX3UcmKKY=;
 b=cGY3ZTWpPEqnI1dN0afM4swG2s0IMKPO33GZJfmyB69H+lWfHLjcrsto70HFiFkvobBX/7Bu5nk7C8SKlrCtdvBopauWDkdq9AYpQjVENVP3Hnw8+Py2IRLj2rtpe9jLqqmO5aCt6QQvWxwllzGHjJAlsTxIzmUnE5FEefaG0/s8/PJw5HoQm7s7CkTntDHPXzs3k4gXt7TXHy1BhgrhCZE2tVHYpQa1CvsiqHkGdIHVcUcqObsg3WKD8hEGvUDt/cEGXJLwF0XdE9vj9jIbmRguBtaKqmmK07Y4QedQFCDZdEZEp5Znfy46S+J1yn043YbFxs3VJshzoskaNMGbdw==
Received: from MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Sat, 8 Mar
 2025 18:51:07 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::af) by MN2PR22CA0024.outlook.office365.com
 (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Sat,
 8 Mar 2025 18:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Sat, 8 Mar 2025 18:51:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Mar 2025
 10:50:49 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Mar
 2025 10:50:45 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <harry.van.haaren@intel.com>, <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <thomas@monjalon.net>
Subject: [PATCH v2] rust: support raw DPDK API
Date: Sat, 8 Mar 2025 20:50:31 +0200
Message-ID: <20250308185031.979893-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 7beefe96-a1e3-47e2-1d4d-08dd5e722f69
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cCtfhQ+FkwTwTiIuUaJR5KkMvyzIKAa49mbV26OT8D+ZdEEJVBBTTQpymPoU?=
 =?us-ascii?Q?KUfHE+B+lYyPby9n2p1qrmoODR/6t/werxSxzONnPDsKDI5/QhR2K0zycuDJ?=
 =?us-ascii?Q?008fRhiTam2v4PQHIGwmUtcn0zgENDnxAEjXMzEXfJnMTQHGp+lFcKUUvgp0?=
 =?us-ascii?Q?xWAtHrh4iRQmE0fItGRVDA1Nztw7UeDiuibiefHRHLrrbjXfRzz6ifZa48Ji?=
 =?us-ascii?Q?IroGC2/etYGED7BNzWo2gtlCMHYTv6lDogKfkuHATT1+Walo8STMTf+4JK83?=
 =?us-ascii?Q?ew62G+ylKWGHGbQ0og98KsqaS6kNVfPm4UDb2lKBkGvOW7s+cFzwyG7yNFdU?=
 =?us-ascii?Q?3eKS+m5K+OpiiSZinOzMoBAdNTh71/azO1gueKrXHxdEJQrx7KTfD5XpnU+1?=
 =?us-ascii?Q?14VbyxcBzSJHnC3RctJyokW2qxlExk/KuAFe5L2DI3KlMnk5l1quo/t0e18q?=
 =?us-ascii?Q?arJ/AOGSRiDLy2pLoHurFY16jvZQmbm7m5EoouSUcxsZVZXpAnfAXyfB81dH?=
 =?us-ascii?Q?3bwBgUKEXURRXgizKWt+XiyUu5l3Z5IV7809v59OD5Ol4Q4fLBc5bZ3v6wRC?=
 =?us-ascii?Q?44sHinnSKRk/fIvb8lgAuq+2gALtAlWafy5mPAPYXAW12SzbfNQ5opkoNVNO?=
 =?us-ascii?Q?/UY5FbTaVPUCXtF2SSyo0Jo+Cqlz8IzCkSC32A+c0jPCmH06lCSlPCvQQzns?=
 =?us-ascii?Q?6MVHEGGMq/9MUgv1hHYvTO1fVpygwccYPpES7+fOGRzcslxiLgHkVaID332h?=
 =?us-ascii?Q?y3y0HjSdohsGairzCkJqaqwGNPNGJojmtlfYvRVz4V+8xwLTzqrIRh+vO3GC?=
 =?us-ascii?Q?JD15ahLZHTNT0vRR6zjyMSFSsRbTmfjn9Zd6NAqan7etaVimTA2BWF8qYDne?=
 =?us-ascii?Q?nxosfZE3vFWriT/9Fa8nMDWGmKxn5qpV6Xj8AgmlkcZk00xDeR0hIBFH0PL7?=
 =?us-ascii?Q?tiLuSb3erbqzOzGQH6BrwOvVvE6ZF4A/esdJHpgozim4poR4bPc01WH8EOiy?=
 =?us-ascii?Q?26P1MGjBh3qoXEx5w3+brUcLRWbWYM5PgmIcWFbdJXiysngvDd1Wo/3BYKWa?=
 =?us-ascii?Q?v/KxLGRoN2N4zI/yNhVqFEadxq632twV2n/MKrAXTDWJrLhlwQ0YxC8HTuBu?=
 =?us-ascii?Q?qO6Jh0hNgxMWnhtyVFI+yTmICLMVT1hhFcthYKuklQwsbwntIsVWwjgsCEA9?=
 =?us-ascii?Q?QUmZIfWTzAjtNfZIArj6W1/1sEfSc2GqrjDK/TqPZekTLvxUsQpQ2zTN6WJJ?=
 =?us-ascii?Q?DCtQmTd3A8ACW6bwR0eLJs/GLZlHLhPi40/LEcXeO7sALQAJ+mbWZ7sykQbO?=
 =?us-ascii?Q?nxb2fn4rg3G54GiB0bnjAxAXjZgNxLdMUL/qjoBr7ErbmiFb1AoI2/zaP4Xq?=
 =?us-ascii?Q?tem6Hw8PWZC8P2ecfhqIgghRq3SvoWLFpf6bzuMozSOfnX+cBqTl3uLI5vFq?=
 =?us-ascii?Q?gp/WVrM7T496npOFU+E1tPwyyNbc1oqmDUnmppaiueC62eXKFru7RQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 18:51:06.9147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beefe96-a1e3-47e2-1d4d-08dd5e722f69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
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
 buildtools/meson.build               |   4 +
 buildtools/rust-env.sh               |  81 +++++++++++
 examples/rust/helloworld/Cargo.lock  |  14 ++
 examples/rust/helloworld/Cargo.toml  |   7 +
 examples/rust/helloworld/build.rs    |  22 +++
 examples/rust/helloworld/src/main.rs | 197 +++++++++++++++++++++++++++
 meson_options.txt                    |   2 +
 7 files changed, 327 insertions(+)
 create mode 100755 buildtools/rust-env.sh
 create mode 100644 examples/rust/helloworld/Cargo.lock
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
index 0000000000..fe0877643b
--- /dev/null
+++ b/buildtools/rust-env.sh
@@ -0,0 +1,81 @@
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
+  bindgen $bindgen_opt --output $rust_dir/src/raw/$base.rs /tmp/$base.i -- $bindgen_clang_opt
+  rm -f /tmp/$base.i /tmp/$base.h
+}
+
+echo 'pub mod raw;' > "$rust_dir/src/lib.rs"
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
index 0000000000..f4cef36499
--- /dev/null
+++ b/examples/rust/helloworld/build.rs
@@ -0,0 +1,22 @@
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
+            println!("cargo:rerun-if-changed=build.rs");
+        }
+        Err(error) => {
+            panic!("failed to read libdpdk package: {:?}", error);
+        }
+    }
+}
diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/helloworld/src/main.rs
new file mode 100644
index 0000000000..7f8d5c58c7
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
+use dpdk::raw::rte_eal::{
+    // Functions
+    rte_eal_init,
+    rte_eal_cleanup,
+};
+
+use dpdk::raw::rte_ethdev::{
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
+use dpdk::raw::rte_build_config::{
+    RTE_MAX_ETHPORTS,
+};
+
+use dpdk::raw::rte_mbuf::{
+    rte_pktmbuf_pool_create,
+};
+
+use dpdk::raw::rte_mbuf_core::{
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
+    let mbuf_pool : *mut dpdk::raw::rte_mbuf::rte_mempool = unsafe {
+        rte_pktmbuf_pool_create(mbuf_pool_name.as_ptr(), 1024, 0, 0,
+                                RTE_MBUF_DEFAULT_BUF_SIZE as u16, 0)
+    };
+    if mbuf_pool  == 0 as *mut dpdk::raw::rte_mbuf::rte_mempool {
+        panic!("port-{}: failed to allocate mempool {rc}", port.port_id)
+    }
+    println!("port-{} mempool ready", port.port_id);
+
+    let mut rxq_conf:rte_eth_rxconf = port.dev_info.default_rxconf.clone();
+    rxq_conf.offloads = 0;
+    rc = unsafe {
+        rte_eth_rx_queue_setup(port.port_id, 0, 64, 0,
+                               &mut rxq_conf as *mut rte_eth_rxconf,
+                               mbuf_pool as *mut dpdk::raw::rte_ethdev::rte_mempool)
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
+            .take(dpdk::raw::rte_build_config::RTE_MAX_ETHPORTS as usize) {
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

