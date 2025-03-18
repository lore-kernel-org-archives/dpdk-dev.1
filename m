Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460EC35FF8
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 08:51:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C0F402C4;
	Tue, 18 Mar 2025 09:51:44 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by mails.dpdk.org (Postfix) with ESMTP id 4633640291
 for <dev@dpdk.org>; Tue, 18 Mar 2025 09:51:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osIZZt1Q+3xByzrVn9y9Gd6/PGomPRRpgMiwjxuL0PH2X89c4X8bydEZQ2OPeGaB/7QjR539Xx4dtgBKXaufTPPNka9PfTI8Ed9ZCQEvqTRkINOlSd8wEDQl1XRnVfzoUT288G6BNzlHfNdBUrVYLxzHjt4HgmFMTbWLGwYi54Bq4owHtAJuzIKjbgBmR2MyCBMkVSlEwpnCDAQqmRUT2Ybze/5kbzKOcSh+VN1jrUcbIoktXcuqBjZaeOKZwf/XHCHecwpO2b4IX1561JQjRac9xlROfkl0zWvC/izJQky5EU6Vfktbpr+hD9spsdLirWxVRZAYSKdgpHsFF+qaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxy3OY30lv21wjI/2MYNoDX9ZLOSDHZQDMc6SKue4gg=;
 b=CeMUzmJxPUxPaVcmfFC+CJPTR3mH46bgswi52TLAvlyTNF1G8G1iV67UwIOoOEThBbGGFpANAi4OtbIn4S55zG8ssWR5yNJcWxMyQNNec/phQZFoLQNAWZWZPNnCY8UV6UIajZ3J7ufeqxLWjiqRl9hqhjDZhLGLetFUTe82vi7V6cklHz5o4meownZRcCm9wlswH4xfcLe9dKdOGvt5k3gUeaLViNbaAgaJIllykzdSUTDNMc2n8Jy5vYKgSejjZzaAFiSxMAsJdU9Io8U4+IEn60GywKFHMSj/7Vrx6S3FXpIiDD3kpBPcQW4vH33dz5hSdMRcridNmtSjUSHQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxy3OY30lv21wjI/2MYNoDX9ZLOSDHZQDMc6SKue4gg=;
 b=LCibaitAtgx152l5BcKEd3s4eHjxh1GCIpkR9Hke0tf3ys/O3KKmB8J0a+kcYlCBshz+0n3UTa3u9aWlLe0dDOMi1KBKQ3LPg5jc+GBP4PqiPdQtdlL8w5WlwYfZzUpmD9alXNwau1sr3fgccUuXttPj49s4E1vsVFmt7avpFzmYxTUPQdbfHVbg8pS8IuYnb8rMgVICWWhtUmZoR1cfO2RFXRnYfpDAYi1KiT/nH8KoSKNxSB2Zcl4IKecBtekwHtHr4JQOT8cyPLH9gcF4eR/7NJ0/YTWPiNqPYwTKXmqS9GbIN5YSj8eWpzUL+3oPtvKP0fDeqWfjrGY9ckuYXA==
Received: from MN2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:208:134::35)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:51:35 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::15) by MN2PR16CA0022.outlook.office365.com
 (2603:10b6:208:134::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Tue,
 18 Mar 2025 08:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 08:51:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 01:51:19 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 01:51:18 -0700
Date: Tue, 18 Mar 2025 09:51:05 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <mkashani@nvidia.com>,
 <thomas@monjalon.net>, <harry.van.haaren@intel.com>, <igootorov@gmail.com>,
 <stephen@networkplumber.org>
Subject: Re: [PATCH v3] rust: support raw DPDK API
Message-ID: <20250318084723.qb53zqp4yelscdgy@ds-vm-debian.local>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250314183815.246612-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250314183815.246612-1-getelson@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: dce70c53-7564-4534-ad03-08dd65fa16a2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9SxokTsNMc/pmwvELOBTCj6J5ahIznce4Vn0XPAJlQL24Ljof45RH6sbI+r9?=
 =?us-ascii?Q?FoI/4rQnu8BQvVv/V2cvOltu88FXo9boGWfi5sSPmJ4xljbkXC4qy9PJuq18?=
 =?us-ascii?Q?jpkHzmiOV363AgWnJBtioZW7bN4BbjTLuIsZmvlFpQIZf26PzZyeOMbdIopM?=
 =?us-ascii?Q?eQeQAtW0aOGRCSVAgkT1TWv+RdIkptwhLIK2r7bruLrXL9KpM0RPy8AeCmGN?=
 =?us-ascii?Q?a0Puhox51aWPjlb5lvt+j/aw0i10DbWsRm8T+PI1KOMEJOCChATqUG81vee9?=
 =?us-ascii?Q?pu73F0+R6WqfpMymiFBs6SIxyamq6kWs3FyyKeP7FWZiA+3iHDrnSzpHvtIy?=
 =?us-ascii?Q?vKB8LoOpLm6JbwZbof2Hm+/gnYRJ+dL5GEGUxPESM1ky/Tv4nOsYo1BqSA2I?=
 =?us-ascii?Q?EcbN5TW7wMZ+gbA2sZjytBGkd5uXJnPaziw3Fb6Wu6kERe6LtdJHaxRxhCAO?=
 =?us-ascii?Q?CyFisYs4Fv7IBNBwxPO5tSmwPUQTsAKKHgKhgmYUuQTVCGDQQlUPLC/z3esl?=
 =?us-ascii?Q?Wsr8UD19Y8YiFnsSEMpITTAFsPOz1iHAKHLZ0XP802DxY1/3vZEHwsnv8iX0?=
 =?us-ascii?Q?QNBC30sBNB5UIHG5+MbV2HnaWg3IVzfnKlqcm/6dTzfZRiolDMYsFhJUPIyl?=
 =?us-ascii?Q?GnhHAZypMd5ku5CL9Zxx+JTTz42DXl/DpdFmyg+YbWGQvJs91hsaAq0/5Oks?=
 =?us-ascii?Q?Z6dtOt96tdOp3/3wT9nNZS6aLmFN7KfISlyLeIutYKzsMGGr1uzm9YZDQCK0?=
 =?us-ascii?Q?jpGie/p/DCYYrRTfWhrwFZ3O2QZs8jxNAxI/Pa1lzUVX1NrZ0kTz1iN3+yJQ?=
 =?us-ascii?Q?4upbjXbPUPBSPz6fYGN+18iZt4HM/rbd6XXI/ifzEyIMZfe5T38B1006lxqg?=
 =?us-ascii?Q?NKOmDDHL21qsu5gMBHFpQTvKf6y3W49rHC6Bn79aFGeGnOxpti8km8v3FTP2?=
 =?us-ascii?Q?tznKk6LGnGoLh3m9P4IZvC/qDaOnBB2qW6656q/Y5XDf/nHurX+kY7iOy6Gs?=
 =?us-ascii?Q?DSEKVn0RiTmImuW+tDUJzqaVRd0aVEifGelpfgTPeWmgr/EOR4JO2RcHIXvu?=
 =?us-ascii?Q?ubfHozfiP4iI8t8YT6cJfQ1MqeAjQdSPVi+MVPXSWgyrhrHRAV1FI2PX51EY?=
 =?us-ascii?Q?BIY9GtWMKnB4o/i1uwPU6KPFQtVHHuTIwByOyfWf9XsmTgrMTC0oipNskRF8?=
 =?us-ascii?Q?2VIyLQzIL2LeUdBJOX9tAlAZzasaOLLrd1rHQtk3emx3bkad+bdKypuHi/eF?=
 =?us-ascii?Q?HNgt7+FDUZkDlnyiC9HxaTLBMOga5cVCUcQSZIAIdpD7h7ZTPbf1AewZ0BpI?=
 =?us-ascii?Q?iGDlOoPMahuVQAMQA9nIPmdrfTHPVTEcbR8NCZo+rW+frrkFx4qeb3rAO2tk?=
 =?us-ascii?Q?3Pzk68gUqSFKZdyQfr8HG9cjUfn8Wlj5v4UxFWx0LLlzT1nrY29/ybkpp6II?=
 =?us-ascii?Q?RkpvqetZ4y38xMRN2TYmazvU+wPz1ykRif0FhREL4DUdR7ViZgbSoTZNZ5Cs?=
 =?us-ascii?Q?aIW9I8mWl/1uFa7w+mm5z58BvYA1dSezX570?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:51:35.0436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce70c53-7564-4534-ad03-08dd65fa16a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
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

Hi Gregory,

I have been playing around with the patch and I have a few suggestions
which I hope would improve the experience with using the generated bindings.
Please let me know what you think.

First of all, during compilation, there is a lot of warnings regarding naming style.
Basically there is a difference between naming style in C and Rust.
For example:

	warning: type `rte_mempool_mem_cb_t` should have an upper camel case name
	    --> /home/ds/obj/dpdk/lib/rust/src/raw/rte_mempool.rs:6292:10
	     |
	6292 | pub type rte_mempool_mem_cb_t = ::std::option::Option<
	     |          ^^^^^^^^^^^^^^^^^^^^ help: convert the identifier to upper camel case: `RteMempoolMemCbT`

In the end, I don't think these are important for bindings and they can be safely ignored.
I think the following should be added to "src/raw/lib.rs":

	#[allow(non_camel_case_types)]
	#[allow(non_upper_case_globals)]
	#[allow(non_snake_case)]

There are also some warnings regarding the use of u128:

	warning: `extern` block uses type `u128`, which is not FFI-safe
	    --> /home/ds/obj/dpdk/lib/rust/src/raw/rte_mempool.rs:4170:18
	     |
	4170 |         __value: u128,
	     |                  ^^^^ not FFI-safe
	     |
	     = note: 128-bit integers don't currently have a known stable ABI

There's an open issue for that with more information and discussion:
https://github.com/rust-lang/rust/issues/78473

These warnings are caused by declaration of the following functions in stdlib.h
(which is transitively included by DPDK headers):

	qecvt_r
	qfcvt_r
	qecvt
	qfcvt
	qgcvt
	strtold

These are not part of DPDK public API and removing their bindings
should not be an issue in my opinion.
I think we can just remove them from bindings with '--blocklist-function' argument.
What do you think?

On Fri, Mar 14, 2025 at 08:38:15PM +0200, Gregory Etelson wrote:
> The patch converts include files with DPDK API to RUST and binds new
> RUST API files into raw module under dpdk crate.
> 
> The RUST files and DPDK libraries build from C sources
> allow creation of DPDK application in RUST.
> 
> RUST DPDK application must specify the `dpdk` crate as
> dependency in Cargo.toml file.
> 
> RUST `dpdk` crate is installed into
> $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust directory.
> 
> Software requirements:
> - clang
> - RUST installation
> - bindgen-cli crate
> 
> RUST dpdk installation instructions:
> 1. Configure DPDK with `-Deanble_rust=true`
> 2. Build and install DPDK. The installation procedure will create
>    $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust crate.
> 3. Update PKG_CONFIG_PATH to point to DPDK installation.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---
> v2:
> Change rust crate name from dpdklib to dpdk.
> Add raw module for to link with C API.
> Add "cargo:rerun-if-changed=build.rs".
> v3:
> Move init_port_config() to Port.
> Move start_port() to Port.
> Remove Cargo.lock from git repository
> Reformat code.
> ---
>  buildtools/meson.build               |   4 +
>  buildtools/rust-env.sh               |  81 ++++++++++
>  examples/rust/helloworld/Cargo.toml  |   7 +
>  examples/rust/helloworld/build.rs    |  24 +++
>  examples/rust/helloworld/src/main.rs | 219 +++++++++++++++++++++++++++
>  meson_options.txt                    |   2 +
>  6 files changed, 337 insertions(+)
>  create mode 100755 buildtools/rust-env.sh
>  create mode 100644 examples/rust/helloworld/Cargo.toml
>  create mode 100644 examples/rust/helloworld/build.rs
>  create mode 100644 examples/rust/helloworld/src/main.rs
> 
> diff --git a/buildtools/meson.build b/buildtools/meson.build
> index 4e2c1217a2..b9d0092f07 100644
> --- a/buildtools/meson.build
> +++ b/buildtools/meson.build
> @@ -50,3 +50,7 @@ else
>      pmdinfo += 'ar'
>      pmdinfogen += 'elf'
>  endif
> +
> +if get_option('enable_rust')
> +    meson.add_install_script(['rust-env.sh', get_option('libdir')])
> +endif
> diff --git a/buildtools/rust-env.sh b/buildtools/rust-env.sh
> new file mode 100755
> index 0000000000..fe0877643b
> --- /dev/null
> +++ b/buildtools/rust-env.sh
> @@ -0,0 +1,81 @@
> +#! /bin/sh
> +
> +# Convert DPDK API files into RUST.
> +# DPDK files selection is on demand.
> +#
> +# The coversion is done in 4 stages:
> +# 1. Preparation [Optional]
> +#    Due to the bindgen conversion utility limitations source file may need
> +#    manual adjustment.
> +# 2. Preprocessing [Mandatory]
> +#    Run preprocessor on a source file before conversion.
> +# 3. Conversion [Mandatory]
> +#    Convert preprocessed C file into RUST file
> +# 4. Post translation [Optional]
> +#    Manually fix translation.
> +
> +# DPDK files list
> +files='
> +rte_build_config.h
> +rte_eal.h
> +rte_ethdev.h
> +rte_mbuf.h
> +rte_mbuf_core.h
> +rte_mempool.h
> +'

There is a lot of warnings generated for types redeclaration, for example:

	warning: `rte_mempool_ops_get_info` redeclared with a different signature
	    --> /home/ds/obj/dpdk/lib/rust/src/raw/rte_mbuf.rs:6352:5
	     |
	6352 | /     pub fn rte_mempool_ops_get_info(
	6353 | |         mp: *const rte_mempool,
	6354 | |         info: *mut rte_mempool_info,
	6355 | |     ) -> ::std::os::raw::c_int;
	     | |_______________________________^ this signature doesn't match the previous declaration
	     |
	    ::: /home/ds/obj/dpdk/lib/rust/src/raw/rte_ethdev.rs:8957:5
	     |
	8957 | /     pub fn rte_mempool_ops_get_info(
	8958 | |         mp: *const rte_mempool,
	8959 | |         info: *mut rte_mempool_info,
	8960 | |     ) -> ::std::os::raw::c_int;
	     | |_______________________________- `rte_mempool_ops_get_info` previously declared here
	     |
	     = note: expected `unsafe extern "C" fn(*const rte_ethdev::rte_mempool, *mut rte_ethdev::rte_mempool_info) -> i32`
			found `unsafe extern "C" fn(*const raw::rte_mbuf::rte_mempool, *mut raw::rte_mbuf::rte_mempool_info) -> i32`

These come from the fact that bindings for each header file are generated separately,
but certain types and functions are defined "transitively" in more than one.
rte_mempool for example is defined in rte_mempool.h which is included by both
rte_ethdev.h and rte_mbuf.h
It's ok in C, but in Rust, resulting bindings these types are different
(dpdk::raw::rte_ethdev::rte_mempool != dpdk::raw::rte_mbuf::rte_mempool).
They could be transmuted between one another, but it is an additional obstacle in using the bindings.

What do you think about using a wrapper header?
This is a solution used in Rust for Linux
(https://github.com/torvalds/linux/blob/master/rust/bindings/bindings_helper.h).
Basically, a new header file is added which includes all headers we want to translate.
bindgen is only run on this wrapper header.
This removes the duplication of all definitions.

This comes at a price of having a flat namespace in dpdk::raw::*,
but I'm not sure it's that much important for raw bindings.
Proper namespacing can be introduced by higher level wrappers.

> +libdir="$1"
> +rust_dir="${MESON_INSTALL_DESTDIR_PREFIX}/$libdir/rust"
> +include_dir="${MESON_INSTALL_DESTDIR_PREFIX}/include"
> +
> +if test -d "$rust_dir"; then
> +  rm -rf "$rust_dir"
> +fi
> +
> +mkdir -p "$rust_dir/src/raw"
> +if ! test -d "$rust_dir"; then
> +  echo "failed to create Rust library $rust_dir"
> +  exit 255
> +fi
> +
> +bindgen_opt='--no-layout-tests --no-derive-debug'
> +bindgen_clang_opt='-Wno-unused-command-line-argument'
> +
> +create_rust_lib ()
> +{
> +  base=$1
> +
> +  cp $include_dir/${base}.h /tmp/${base}.h
> +
> +# bindgen cannot process complex macro definitions
> +# manually simplify macros before conversion
> +  sed -i -e 's/RTE_BIT64(\([0-9]*\))/(1UL << \1)/g' /tmp/${base}.h
> +  sed -i -e 's/RTE_BIT32(\([0-9]*\))/(1U << \1)/g' /tmp/${base}.h
> +  sed -i -e 's/UINT64_C(\([0-9]*\))/\1/g' /tmp/${base}.h
> +
> +  # clang output has better integration with bindgen than GCC
> +  clang -E -dD -I$include_dir /tmp/${base}.h > /tmp/$base.i
> +  bindgen $bindgen_opt --output $rust_dir/src/raw/$base.rs /tmp/$base.i -- $bindgen_clang_opt
> +  rm -f /tmp/$base.i /tmp/$base.h
> +}
> +
> +echo 'pub mod raw;' > "$rust_dir/src/lib.rs"
> +
> +touch "$rust_dir/src/raw/mod.rs"
> +for file in $files; do
> +  base=$(basename $file | cut -d. -f 1)
> +  create_rust_lib $base
> +  echo "pub mod $base;" >> "$rust_dir/src/raw/mod.rs"
> +done
> +
> +cat > "$rust_dir/Cargo.toml" <<EOF
> +[package]
> +name = "dpdk"
> +version = "$(cat ${MESON_SOURCE_ROOT}/VERSION | sed 's/\.0\([1-9]\)/\.\1/')"
> +EOF
> +
> +# post conversion updates
> +# RUST does not accept aligned structures into packed structure.
> +# TODO: fix DPDK definitions.
> +sed -i 's/repr(align(2))/repr(packed(2))/g'  "$rust_dir/src/raw/rte_ethdev.rs"

I have taken a look at specific types with that issue and there is only a few of them.
The following are affected:

	rte_l2tpv2_combined_msg_hdr
	rte_flow_item_l2tpv2
	rte_arp_ipv4
	rte_arp_hdr
	rte_flow_item_arp_eth_ipv4

Before changing DPDK definitions (if possible), we could make bindings for them opaque.
This would basically generate, for each type, a struct with byte array inside,
which would be "naturally" packed (no need for 'repr(packed)').
Reading/modifying specific fields could be written as a higher level getter/setter.

What do you think about making these types opaque through '--opaque-type' bindgen parameter?
This would:

- remove the need for manually replacing align/packed
  (which removes required alignment on rte_ether_addr),
- remove the need to disable layout tests
  (which are very good to have),
- "document" the list of problematic types.

> +
> +echo "Install RUST DPDK crate in $rust_dir"
> diff --git a/examples/rust/helloworld/Cargo.toml b/examples/rust/helloworld/Cargo.toml
> new file mode 100644
> index 0000000000..ceeecf958d
> --- /dev/null
> +++ b/examples/rust/helloworld/Cargo.toml
> @@ -0,0 +1,7 @@
> +[package]
> +name = "helloworld"
> +version = "0.1.0"
> +edition = "2024"
> +
> +[dependencies]
> +dpdk = {path = $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust }
> diff --git a/examples/rust/helloworld/build.rs b/examples/rust/helloworld/build.rs
> new file mode 100644
> index 0000000000..bd5737d209
> --- /dev/null
> +++ b/examples/rust/helloworld/build.rs
> @@ -0,0 +1,24 @@
> +use std::process::Command;
> +
> +pub fn main() {
> +    let mut pkgconfig = Command::new("pkg-config");
> +
> +    match pkgconfig.args(["--libs", "libdpdk"]).output() {
> +        Ok(output) => {
> +            let stdout = String::from_utf8_lossy(&output.stdout)
> +                .trim_end()
> +                .to_string();
> +            for token in stdout.split_ascii_whitespace().filter(|s| !s.is_empty()) {
> +                if token.starts_with("-L") {
> +                    println!("cargo::rustc-link-search=native={}", &token[2..]);
> +                } else if token.starts_with("-l") {
> +                    println!("cargo::rustc-link-lib={}", &token[2..]);
> +                }
> +            }
> +            println!("cargo:rerun-if-changed=build.rs");
> +        }
> +        Err(error) => {
> +            panic!("failed to read libdpdk package: {:?}", error);
> +        }
> +    }
> +}


What do you think about using pkg_config crate in build scripts?
(https://crates.io/crates/pkg-config)

This would allow to remove manual command execution and output parsing with the following:

	fn main() {
	  pkg_config::probe_library("libdpdk").expect("Unable to find libdpdk");
	}

Also, what do you think about moving this logic to dpdk crate?
This way dependency resolution would be shared by all examples/applications
which use the dpdk crate.

> diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/helloworld/src/main.rs
> new file mode 100644
> index 0000000000..0c057cb39f
> --- /dev/null
> +++ b/examples/rust/helloworld/src/main.rs
> @@ -0,0 +1,219 @@
> +/// Usage: helloworld -a <port 1 params> -a <port 2 params> ...
> +use std::env;
> +use std::ffi::CStr;
> +use std::ffi::CString;
> +use std::os::raw::{c_char, c_int};
> +
> +use dpdk::raw::rte_eal::{
> +    rte_eal_cleanup,
> +    // Functions
> +    rte_eal_init,
> +};
> +
> +use dpdk::raw::rte_ethdev::{
> +    RTE_ETH_DEV_NO_OWNER,
> +    RTE_ETH_NAME_MAX_LEN,
> +    RTE_ETH_RSS_IP,
> +    rte_eth_conf,
> +    rte_eth_dev_configure,
> +    // Functions
> +    rte_eth_dev_get_name_by_port,
> +    // Structures
> +    rte_eth_dev_info,
> +    rte_eth_dev_info_get,
> +    rte_eth_dev_start,
> +    rte_eth_find_next_owned_by,
> +    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS,
> +    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS,
> +
> +    rte_eth_rx_queue_setup,
> +    rte_eth_rxconf,
> +
> +    rte_eth_tx_queue_setup,
> +    rte_eth_txconf,
> +};
> +
> +use dpdk::raw::rte_build_config::RTE_MAX_ETHPORTS;
> +
> +use dpdk::raw::rte_mbuf::rte_pktmbuf_pool_create;
> +
> +use dpdk::raw::rte_mbuf_core::RTE_MBUF_DEFAULT_BUF_SIZE;
> +
> +pub type DpdkPort = u16;
> +pub struct Port {
> +    pub port_id: DpdkPort,
> +    pub dev_info: rte_eth_dev_info,
> +    pub dev_conf: rte_eth_conf,
> +    pub rxq_num: u16,
> +    pub txq_num: u16,
> +}
> +
> +impl Port {
> +    unsafe fn new(id: DpdkPort) -> Self {
> +        Port {
> +            port_id: id,
> +            dev_info: unsafe {
> +                let uninit: ::std::mem::MaybeUninit<rte_eth_dev_info> =
> +                    ::std::mem::MaybeUninit::zeroed().assume_init();
> +                *uninit.as_ptr()
> +            },
> +            dev_conf: unsafe {
> +                let uninit: ::std::mem::MaybeUninit<rte_eth_conf> =
> +                    ::std::mem::MaybeUninit::zeroed().assume_init();
> +                *uninit.as_ptr()
> +            },
> +            rxq_num: 1,
> +            txq_num: 1,
> +        }
> +    }
> +
> +    pub unsafe fn init_port_config(&mut self) {
> +        let ret = unsafe {
> +            rte_eth_dev_info_get(self.port_id, &mut self.dev_info as *mut rte_eth_dev_info)
> +        };
> +        if ret != 0 {
> +            panic!("self-{}: failed to get dev info {ret}", self.port_id);
> +        }
> +
> +        self.dev_conf.rx_adv_conf.rss_conf.rss_key = std::ptr::null_mut();
> +        self.dev_conf.rx_adv_conf.rss_conf.rss_hf = if self.rxq_num > 1 {
> +            RTE_ETH_RSS_IP as u64 & self.dev_info.flow_type_rss_offloads
> +        } else {
> +            0
> +        };
> +
> +        if self.dev_conf.rx_adv_conf.rss_conf.rss_hf != 0 {
> +            self.dev_conf.rxmode.mq_mode = rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS
> +                & rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS;
> +        }
> +    }
> +
> +    unsafe fn start_port(&mut self) {
> +        let mut rc = unsafe {
> +            rte_eth_dev_configure(
> +                self.port_id,
> +                self.rxq_num,
> +                self.txq_num,
> +                &self.dev_conf as *const rte_eth_conf,
> +            )
> +        };
> +        if rc != 0 {
> +            panic!("failed to configure self-{}: {rc}", self.port_id)
> +        }
> +        println!("self-{} configured", self.port_id);
> +
> +        rc = unsafe { rte_eth_tx_queue_setup(self.port_id, 0, 64, 0, 0 as *const rte_eth_txconf) };
> +        if rc != 0 {
> +            panic!("self-{}: failed to configure TX queue 0 {rc}", self.port_id)
> +        }
> +        println!("self-{} configured TX queue 0", self.port_id);
> +
> +        let mbuf_pool_name = CString::new(format!("mbuf pool self-{}", self.port_id)).unwrap();
> +        let mbuf_pool: *mut dpdk::raw::rte_mbuf::rte_mempool = unsafe {
> +            rte_pktmbuf_pool_create(
> +                mbuf_pool_name.as_ptr(),
> +                1024,
> +                0,
> +                0,
> +                RTE_MBUF_DEFAULT_BUF_SIZE as u16,
> +                0,
> +            )
> +        };
> +        if mbuf_pool == 0 as *mut dpdk::raw::rte_mbuf::rte_mempool {
> +            panic!("self-{}: failed to allocate mempool {rc}", self.port_id)
> +        }
> +        println!("self-{} mempool ready", self.port_id);
> +
> +        let mut rxq_conf: rte_eth_rxconf = self.dev_info.default_rxconf.clone();
> +        rxq_conf.offloads = 0;
> +        rc = unsafe {
> +            rte_eth_rx_queue_setup(
> +                self.port_id,
> +                0,
> +                64,
> +                0,
> +                &mut rxq_conf as *mut rte_eth_rxconf,
> +                mbuf_pool as *mut dpdk::raw::rte_ethdev::rte_mempool,
> +            )
> +        };
> +        if rc != 0 {
> +            panic!("self-{}: failed to configure RX queue 0 {rc}", self.port_id)
> +        }
> +        println!("self-{} configured RX queue 0", self.port_id);
> +        rc = unsafe { rte_eth_dev_start(self.port_id) };
> +        if rc != 0 {
> +            panic!("failed to start self-{}: {rc}", self.port_id)
> +        }
> +        println!("self-{} started", self.port_id);
> +    }
> +}
> +
> +pub unsafe fn iter_rte_eth_dev_owned_by(owner_id: u64) -> impl Iterator<Item = DpdkPort> {
> +    let mut port_id: DpdkPort = 0 as DpdkPort;
> +    std::iter::from_fn(move || {
> +        let cur = port_id;
> +        port_id = unsafe { rte_eth_find_next_owned_by(cur, owner_id) as DpdkPort };
> +        if port_id == RTE_MAX_ETHPORTS as DpdkPort {
> +            return None;
> +        }
> +        if cur == port_id {
> +            port_id += 1
> +        }
> +        Some(cur)
> +    })
> +}
> +
> +pub unsafe fn iter_rte_eth_dev() -> impl Iterator<Item = DpdkPort> {
> +    unsafe { iter_rte_eth_dev_owned_by(RTE_ETH_DEV_NO_OWNER as u64) }
> +}
> +
> +pub unsafe fn show_ports_summary(ports: &Vec<Port>) {
> +    let mut name_buf: [c_char; RTE_ETH_NAME_MAX_LEN as usize] =
> +        [0 as c_char; RTE_ETH_NAME_MAX_LEN as usize];
> +    let title = format!("{:<4}    {:<32} {:<14}", "Port", "Name", "Driver");
> +    println!("{title}");
> +    ports.iter().for_each(|p| unsafe {
> +        let _rc = rte_eth_dev_get_name_by_port(p.port_id, name_buf.as_mut_ptr());
> +        let name = CStr::from_ptr(name_buf.as_ptr());
> +        let drv = CStr::from_ptr(p.dev_info.driver_name);
> +        let summary = format!(
> +            "{:<4}    {:<32} {:<14}",
> +            p.port_id,
> +            name.to_str().unwrap(),
> +            drv.to_str().unwrap()
> +        );
> +        println!("{summary}");
> +    });
> +}
> +
> +fn main() {
> +    let mut argv: Vec<*mut c_char> = env::args()
> +        .map(|arg| CString::new(arg).unwrap().into_raw())
> +        .collect();
> +
> +    let rc = unsafe { rte_eal_init(env::args().len() as c_int, argv.as_mut_ptr()) };
> +    if rc == -1 {
> +        unsafe {
> +            rte_eal_cleanup();
> +        }
> +    }
> +
> +    let mut ports: Vec<Port> = vec![];
> +    unsafe {
> +        for port_id in
> +            iter_rte_eth_dev().take(dpdk::raw::rte_build_config::RTE_MAX_ETHPORTS as usize)
> +        {
> +            let mut port = Port::new(port_id);
> +            port.init_port_config();
> +            println!("init port {port_id}");
> +            port.start_port();
> +            ports.push(port);
> +        }
> +    }
> +
> +    unsafe {
> +        show_ports_summary(&ports);
> +    }
> +
> +    println!("Hello, world!");
> +}
> diff --git a/meson_options.txt b/meson_options.txt
> index e49b2fc089..d37b9ba1dc 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -60,3 +60,5 @@ option('tests', type: 'boolean', value: true, description:
>         'build unit tests')
>  option('use_hpet', type: 'boolean', value: false, description:
>         'use HPET timer in EAL')
> +option('enable_rust', type: 'boolean', value: false, description:
> +       'enable RUST')
> -- 
> 2.45.2
> 

Best regards,
Dariusz Sosnowski
