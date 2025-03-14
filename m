Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A2EC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 18:38:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B06240263;
	Fri, 14 Mar 2025 19:38:55 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by mails.dpdk.org (Postfix) with ESMTP id 2C152400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 19:38:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMcxao1e56m3WrGyIYCk8fLlUCQOlO8U9h/VA2O1hML6Sy7H7nMaEEcBEWiQifXYU9BjFhCv31vP2PmVlIiAUwUL2W2Cp43+fMqG2WSpiYC/TQJ8wFLO15QIcs6YjwpteEBsJMRus+D6xwDcyI/JNRC0E4HL+pOPdBKvSPb9PIKK4dDSj1bnN49j7ye/FezIb0HrkKZyzEJyi7a+aHCRMHuemUsMEi6oE3aKjC1Gi4/6Q5Kg5usUQWqqc6Fi8aUF2+mGbJVeVwZOwB4qoodRKi8YET2cu3321VN3oBArpcMXxIXazACw/AMklC3sZDgXpz3wc13riZLJVqS0Mp/X7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJPC2u270L2s1CTQ6cHsP0ZqO6zAvxLDQrM7AB/UrHc=;
 b=WXD2p2BvkTxzgL77DfrQpe0nQNzQRPZ88Z445PaltHOHEAhEuSK6JzrRUxp96q/Ch0o9CE++a9cJvwWbnD/RikbH/5MoOLj49pQd9T9Ao5RRzv+k1rOrTdKUC3PJoq9l68cpLCMnXirE5DXqxNAtcocomIk5SUKnQGwMsYDd67iTwliIB8UqS0vbJy32TMQ6Z1YNa0EiWibzqq06x+HrVpT+t3DuQsswFJDe6z+iTny1tG8o6dejXlBh3PMVy211cuQvg/koVz0io/z2JXBUa7piN3oaEpXF2rsq+L/V32p4mFga4t2mXgYznJTGvBrDQJBP0+hHchQl0+77jGr4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJPC2u270L2s1CTQ6cHsP0ZqO6zAvxLDQrM7AB/UrHc=;
 b=M2EpAUSwq19GJx5c4e/mu5wlYZtGEoYzJ101bIyjo83hS9usbylkGhTCbn4UZUJiFQSH9xGDN0+Ec6ctFI870dOUnDhOzkElIZNy7jFTvfRB7YfemkO2TMmBbSJsfezuYAalVtciBijSxqcNlJBEDX6/t4cmu68WuyrotPHEsz5EDQ1NiHnNDdr0SMQeTsgEXl9eHCi2ZD0HelakuWRRZc/FqX4rzxAUW/k6g7UPiLw0Ixs7/VeJafkG6R7YxdlN3htjsguP+7Oz9vyYcZnNVzm8cVbpUar2FRQpi8XmgQ71kfHLE5XnzuoKa7lFlXN2PuMnAif9J1qdTKbsnpkmEw==
Received: from SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 18:38:47 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::5e) by SJ0PR05CA0208.outlook.office365.com
 (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 18:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 18:38:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Mar
 2025 11:38:31 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Mar
 2025 11:38:29 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <getelson@nvidia.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <mkashani@nvidia.com>,
 <thomas@monjalon.net>, <harry.van.haaren@intel.com>, <igootorov@gmail.com>
Subject: [PATCH v3] rust: support raw DPDK API
Date: Fri, 14 Mar 2025 20:38:15 +0200
Message-ID: <20250314183815.246612-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 03190870-2a6d-41e3-f7b7-08dd632774c7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p4mCrvfw5yII710MM5+seoEtrwRzF+JkrhnTHYUPp8+lBmn4FLyUbRS6lcMR?=
 =?us-ascii?Q?1O9UIol1gdSJgLLedlHaWFyDCTjt91pqzVYIucAW4iimypjLW+z9yrNauUYc?=
 =?us-ascii?Q?ClYRVhTNWPJ/rsyJq3/tSNtD1nGDnkpFt4Ow3QUZEfRw8T5S2mQgqZwEpyfD?=
 =?us-ascii?Q?miO+iaHLen5eAfat3zab96j7prL6SzQ9wIuphqHZiB+UJI83N46QS5MYS7nN?=
 =?us-ascii?Q?0WxMrgVvQiCHyveGEQx2h9RnmRVnOA4KzlJzGD0v2qoTVPSGOP75QRsF2CtD?=
 =?us-ascii?Q?wSQ+tsHStwEKoSqLnnMYX/Zt9flLQ90do1rMS2LEbE5BbI1+Jxe2P4AcSsPG?=
 =?us-ascii?Q?z43iI+mQsWuCbc9OkF4LTuYKLDUQeH1AP9gm7H2SDcc0YXjZOci74BhHa62S?=
 =?us-ascii?Q?/CiYN7raY7d0+RioiHSypEx6ZWLAPCCF3EkW8o63vGyZLkyZv+YWl4613hno?=
 =?us-ascii?Q?4vah47pYeu53LfBVZPM3hDsKTO+qT71YdjOEd7F7UMZIRTvDSd6/ywQElOYr?=
 =?us-ascii?Q?t+B2LXJUSFn44DkMnQri/Gp/a8TgZS7Ww1COT0xpY2COTFirsyFNlbdUAfXj?=
 =?us-ascii?Q?ZiBxg4fLs9YKK9Gd8ZOSw1CsFnYQZnn60pB2/GQcgbBaEAkSpuqLmzTw0v3U?=
 =?us-ascii?Q?8jPhZS397dgHbT3GpaP6NMRObwzymsDlWFiTLROpCxWMch9MtOFXl7EBjxiI?=
 =?us-ascii?Q?gUjd9ECs+HTuU2RtJXngmckPbHj017YNO96zPzskqTR+BhCZKaj1Q8lK9Taz?=
 =?us-ascii?Q?uyf1eW6LEleQOFYCBu5KzvsmNLzSy+qexH8fp6IsCollOnvK1pCrIS+AiQ5J?=
 =?us-ascii?Q?YE/C2SXMF7+OrfhBf0Y3EjhNO1hb+l4mfF81PRBQZe70hm2ro8MLwQrJnUEQ?=
 =?us-ascii?Q?HnsmyqFJ5VeFEA/AEPYxkqkFdF/0LFKWeXF/LsjRxjgLDZ5on811+sHCoSgi?=
 =?us-ascii?Q?ItBieOXh5ajPMnQ4e3PGMuupRmsGnJkfLIVEqm6dYDwBeRz/kM4b/lIq3IbT?=
 =?us-ascii?Q?5OSN2+/HIeJRjgeKScAxsIN5FVhEbJQ6jIXWu6Au2VONTO7ANm8iYTioxjnm?=
 =?us-ascii?Q?E5lRUBoA89iGqO3vHtUKAft/7SoL5XslgOkM29+jW1DywAmpqJWZbPqRhkxv?=
 =?us-ascii?Q?4zvckv0lRubY+OxUP+x4fzv5fjFIm8ag+stdnpdI4LivAMkgAjlnsux/IXul?=
 =?us-ascii?Q?dYES6HnkOGnktXI2ChTvsxNee1qXkG6zUxUsqWb4CtduHYFC3+pUYxOJBBns?=
 =?us-ascii?Q?54F0Nf8Z1EkoKWmXHRt3Q0NeOSTIToLOuh5HWmh9GR5fpiOFmigr0brdiIAw?=
 =?us-ascii?Q?RewEYnjzmCR2w1NOF0gNHW2fejrOv75u1OlaWd4/nYohPGB8U8lJjkvKm/l5?=
 =?us-ascii?Q?/4SUwbVCE6SYyKsXcddOD+NrV81XL7ehQXczCgCnpZFUQLwPtZHU9dvrhBfi?=
 =?us-ascii?Q?2G3b9rk4b1oO1T2r4Hq7a2HsyeF0RUqIaTmWKdDlhwJuWM3uzXrxS0h/Fiog?=
 =?us-ascii?Q?fkBldJ/BQkyOknc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 18:38:46.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03190870-2a6d-41e3-f7b7-08dd632774c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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
---
 buildtools/meson.build               |   4 +
 buildtools/rust-env.sh               |  81 ++++++++++
 examples/rust/helloworld/Cargo.toml  |   7 +
 examples/rust/helloworld/build.rs    |  24 +++
 examples/rust/helloworld/src/main.rs | 219 +++++++++++++++++++++++++++
 meson_options.txt                    |   2 +
 6 files changed, 337 insertions(+)
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

