Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A35C35FFC
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Mar 2025 17:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23707402D6;
	Sat, 22 Mar 2025 18:39:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id CD30E402A7
 for <dev@dpdk.org>; Sat, 22 Mar 2025 18:39:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742665189; x=1774201189;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0q7DUfpJYsh6wcwuIGkydoQwUqvn1HAtLorMa3cykIE=;
 b=A/OC1hJUcb1EvkK+GSJWNqYOtYRsuOO1hTefVQkaxP4oZb9b6SgXSdyP
 DTRiEESN2dxf1g/jPelI93yOICyC2w00ctPTvsl5FipqZiPyQPKKMADtD
 dKOsfI10XjYNgWr1enTvAJtMTI+5VQE5LV4XIF3WMmBC6orCHEyLENRkm
 vSdGLt/LT4nYQ+5PgR8kVt00V2+AGcMGyDkqnKFRKK0b4mMbVvpkNFbpk
 UybWeT8lhmJYBnUdplmy2+pfi6mO7ALwrYKUKPE/JBynDndoxdMJVkxqQ
 tFp5/369DHbGdlQ9fupKVIV3QEVgLW9Xtu6sitXp9Djc0reDFQkPDPqqR Q==;
X-CSE-ConnectionGUID: 7grexaDIQsqhyMevRXSU5Q==
X-CSE-MsgGUID: DYH4AKvQRtu3b7z6NP/oSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="43638623"
X-IronPort-AV: E=Sophos;i="6.14,267,1736841600"; d="scan'208";a="43638623"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2025 10:39:47 -0700
X-CSE-ConnectionGUID: BEhGKrbwTI2TprzJvXdOkg==
X-CSE-MsgGUID: QhX/S7GXT4SVC8SR84h8GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,267,1736841600"; d="scan'208";a="154683373"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Mar 2025 10:39:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 22 Mar 2025 10:39:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 22 Mar 2025 10:39:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 22 Mar 2025 10:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRg4Tzah2r1zWtz3e5iav1rfDkhcpprfZSG5F4ckC5mjltTPkwE8YEIKO+fUcp7XmfSTNeSjH3pGZkTL2skRXVNV3iqCpFrO8sp9rEY/inoFOzHANhakiJqiegX90L8mnUkhnavvmfmPYxMCgQXjzLAim3/ErlN27lkdutOtSQrr5h5bFZ8jqrengli/nou6rXQRu/QBMPcL4Eoq7Qclt9tKmG2YT29OR5IkLcQChtSPo0g4TFB4MRLlnqLNvwVSG83QdK+ULGf2fcmvHygFml6/brBHRuFm+lFtVlD+stv0aKyVvZTnnUStVkwb01kGk7qW9Ozea0Vlt0xH2sVKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYlF5VI3Hl2SDmNWxRoaXkoJKQRDJH8RnVIedtxTUBk=;
 b=RPVTdxK3iPwqCSroRHhrWwCyfu5WdmnW0CXhW4hpcEaSY4nGOju4lbOdN1M8WtSEywtYGu7DnNEFqGZgNnlxlBtKG98Oenm3aIcd8Orkz6P//odK8BIpfrW7t4SyzTGvRsVOGPAiKkppnq2CAzFaKwLp3aPTesxc3U/jSSqPFTYwKVlVkyrheW9EvS5+bmFHjW3HGmCQYs7v17ilKMOC8OYTDr+WArHUTADhomeBciCkK6x+gqqRdJiJnSvPN0SRW+i4pWk4iuYkb5NOBfK8+L/wOqnzCLo08JrosX3D+CVFv6JIvNYwjca4E0O0bkHkLSbbXZOKVM7s7BIfcVXyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 17:39:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 17:39:39 +0000
Date: Sat, 22 Mar 2025 17:39:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: <dev@dpdk.org>, <dsosnowski@nvidia.com>, <harry.van.haaren@intel.com>,
 <igootorov@gmail.com>, <mkashani@nvidia.com>, <stephen@networkplumber.org>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v4] rust: support raw DPDK API
Message-ID: <Z9711_x0IBYetdZR@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250322105911.12378-1-getelson@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250322105911.12378-1-getelson@nvidia.com>
X-ClientProxiedBy: DB9PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: aa77ec95-94be-4552-474b-08dd696885b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oPbRGku2eQUVEUu0dhOErBAF56GIrKzNbs0wr9gApvkKTL2NnuMQLwl1/0UN?=
 =?us-ascii?Q?U55vNMCmpX06mdA9N34v1dI4kBiotrpLMndPn9kGHh6L0fJ8KXz0MUdNMIK2?=
 =?us-ascii?Q?w2qdFjU6QYfBEPTIEgsusaZOx4KTHU12tXX8KEkF5aIG82PRN6H7VYpxKgio?=
 =?us-ascii?Q?I8iWJJAL3FK6bBqy9tzXoNR3ljvW8UNo5Tl503m7l5Gfparzj7QCpFQtwLt7?=
 =?us-ascii?Q?OpLQznkjB3y1pUgN0fdXXe3bEkLuBFDNhXHj3jHC/UHKZjkR3FnruAqjPW8t?=
 =?us-ascii?Q?R4tmjFkdEecymyCkrF0/C780x1jAVKZICM203T6soryGbhY/tzj0k5fsbPQ9?=
 =?us-ascii?Q?MeMJSLnu50niEn/1X0s4Y87Fr8Cg7mT219/IqTNIwstO3YLppXQiEYgwwT/p?=
 =?us-ascii?Q?gwZPAE2gxGo5/85kf25JSjkCH5ZPqouBwnlGO5yzR60LyNqKUaZNuAVI5B94?=
 =?us-ascii?Q?HJa7o00oJ3XpWYDQsiMPgkb3Nd/Tq6QhH5073K9OmLwv3dlcK5oo7mXBQAQg?=
 =?us-ascii?Q?jk+mhle9ChBgSPnPXoHWd8bm4UORxxl0Cv4+QungJKxIkHtXmvkXuU+H8P3R?=
 =?us-ascii?Q?UppukhGvz4DcnPZxXFqHRhE3dLeSDSAmnXdJvdXtWRc0dx4pVYh/l1Yprq06?=
 =?us-ascii?Q?91fPA0uid1DWhfHpy1Ar8od5kt5ovuBK1JV5uFyFkvXLX411wf2Hiun4wPgC?=
 =?us-ascii?Q?bDPAUWSLF7XJB0mbO75zGPt3D2wLUKWLfotxEIEidNrAWhQcq+afn6VvkE2B?=
 =?us-ascii?Q?rost8G8FGEp64D1526PiOwdNO8n4I2b987emLyZRXfdN1yYInTwydeQGzDgM?=
 =?us-ascii?Q?rQ9tZyqgrUy6PZGJ3acMIERvdsqDO3USBlTs6kDXlvxCltfsHcpbE6OLUzoz?=
 =?us-ascii?Q?zfFtlWg1c39+kTCzeTjRlZE/+ynQ+xjT+v15blNDZ5n3xBPFOCUKtbrkzyg0?=
 =?us-ascii?Q?TFjaSy1BTFspbgv8hcK2uobagTVnPd5qvRqvG5lOw+yiqyw9iHP/P1sJh541?=
 =?us-ascii?Q?rUmH6BS3bsDHUJnXY2Xg2YpvYj8uLgTieWFQWMqfnf777hTY6Pw2qS0YgV/Q?=
 =?us-ascii?Q?U9Vi1VHOxQpPSyKwmxrN0bcNJ5ymlErmBUatDfcbdhPuyRGQFnW5G5Jirhl/?=
 =?us-ascii?Q?uVkZnTkwPgHouX22kk3ZuqwVzSFP8HG7qRik1+4UkYJzSo/X7tHfFQiRwOYr?=
 =?us-ascii?Q?cL6PKM9sDeKnUPiwQhchHQaTr/hwGhbWK4V3kUxyixERpBczxVGPDC0g7FHB?=
 =?us-ascii?Q?y4iWFViNRhqL/LjLi78IJp3seOaQF+KJAoSiOd1qe6+GNuq2j4LIfmUyuz7g?=
 =?us-ascii?Q?C9DfCr1jQWRr9iwINlWaZDIfqo97Escn6eQS7gbHVmJ46GtDr3VpBscAUQ7l?=
 =?us-ascii?Q?9IadsinHwMH8QI1zbGBd/1PPpsGB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vcCUL/lYvqgiCEEuBIS93BLnYSbUSCAeiwpCPcdCwudVxmoNJ+uuGF1hqPj0?=
 =?us-ascii?Q?3ScRgTaDUPUj+sKYQAOuYbShFfYQInlrdis/qEj4J4UWpo/o3cDSxulX1RhN?=
 =?us-ascii?Q?SGRaLD9Zr+ngaHKqcf/TD21ZsEhTWYOkx/Fq8A+Ool8IdXobG/yLuWv8di78?=
 =?us-ascii?Q?VEEPUj6W+qPLOMjt+ItEnW2ghIv5LqcPcXQWc2zpE8M/rz5OF3JU0PBY0pmJ?=
 =?us-ascii?Q?OLIY537j1+CS/nZyni/JvklfZ3a5zkfVMPmUqqyjeIkxyGZH1iRcnEfRC2bQ?=
 =?us-ascii?Q?wge31FX2qdZmwrC0VveQSe2IfyOvvi8FYLxkDX6oBQyqjF3ZAQpK/RK83/xe?=
 =?us-ascii?Q?O8xbiF1+VW4IhrBCHhyV7TYL3M1Y1hB2w91J1TbzPrz3e9gND878RyY7el1Q?=
 =?us-ascii?Q?LEoECbqI3y+nliZ/aWrlOEx32uayxljcCO+dzPfJZ24QPYJgyfGPx4aBP1al?=
 =?us-ascii?Q?6NcFmDzuV0pSZ6SOZ1huW8DnXOtFTdmB2hW/pgD6ubFwvXThOHuDfnCnogMr?=
 =?us-ascii?Q?JMX2+/auhZFTfj6C53uYAqnGGeSlDHvKce09fi8Sy8kmpmXsAkuLIfEPwJ16?=
 =?us-ascii?Q?w+oTlsAkOIfzSJdBHuqFa78q8+/vVF9OtFxFssFoPVFVRKLKIbK9DhINZiaX?=
 =?us-ascii?Q?C9ftLhAsHD6sU9U5sNiCCwVZO2hPdYlaJLpDKH7JoF4f/QR++kUc4XBdOCw0?=
 =?us-ascii?Q?OaymIzupkQRS81wEMTZQEx2ocSy2PGrcfsDBd7btTnOKUIod30gVe+GY4pDT?=
 =?us-ascii?Q?DGAxJe88kIc7tcjBlYPKUSaD/sMPRnwyOTGq8rRu0tjLf5i0Q2vi2GEbGOMo?=
 =?us-ascii?Q?qhF7curd1U/T3+EoWg9ooFubB0e9ZFdGwNte6af7tfVjLP2aBFxQA33VrB1N?=
 =?us-ascii?Q?0zehEOpInNNcy4pl6obbSkDJr8zT4LXfURPAxUKHrlUjN5vv+U7e2gaF77SI?=
 =?us-ascii?Q?C+juA41V0pLBRe+NVMPQZqC9AicrhzyL91CE4npm2eq/mgC4SY/OPrB8K3dd?=
 =?us-ascii?Q?W1kTZiSNujFXJFVQK5XTLbmkWB1mg8C2wLiBNNlUipI/XRdlIqYSf0CKkvOb?=
 =?us-ascii?Q?gzbkC4WicXnKPzSRMhlvgEeHGjaugekKCUy8LSQuF7Xg4SOGKVf4O62d0oix?=
 =?us-ascii?Q?ulCJUPDz7YJCI00uoVoU749+DTG8N826ca5uudpNorgeRU0izhdf1BTrDaSL?=
 =?us-ascii?Q?H7ycuLbIr58fzTGv3OWOWvF3CfnWukF9ARcsZ5L+oSTRCQZaTavcW6069QcR?=
 =?us-ascii?Q?2PV6QZIqKdcf78obxuvnJ/jBi9SZOhw5UOiAx4WmMw2aD55K3hQLAF7fAnbH?=
 =?us-ascii?Q?bsuXecpfNnIC4BRGJqTrOVpJp6Xrdvlz8gsh/WJRg6r4CA36DkW82sweu2hJ?=
 =?us-ascii?Q?VQg3dSsW5z28AVLpxiUSJHyv6zTIsDzKxoHW61OH9f8PclVf9FZxLO0L7VEp?=
 =?us-ascii?Q?Kwr5asDGH+UbA6jBNnBj0vE3qyekz2sSdpIYAxlWiTqGwqEPaDY1EoZ4GwVH?=
 =?us-ascii?Q?C9hktK939W2jdyGu+x4DXr/eDc3zXnWgctPK1EA0cGjoJYOmX5FZmkvz9JdS?=
 =?us-ascii?Q?Gl59+3GUU/6k9q59gW3+93jPzxB2slnQ9JOk4nFlFJg8DT2gMVqmT4VEphiO?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa77ec95-94be-4552-474b-08dd696885b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 17:39:39.8345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSn1MSzK95+dBw6eBcmKrexujuY8xrleZLA/rKgbEpq82RtYj8hu9Tzynm77qA8P/zgn4Z//hnboQVTKR6/jSfgvebvAQ/ad911GDLIyFwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
X-OriginatorOrg: intel.com
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

On Sat, Mar 22, 2025 at 12:59:11PM +0200, Gregory Etelson wrote:
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
> v4:
> Blocked bindgen to convert stdlib functions with u128 type.
> Allow compilation of C style symbols.
> ---
>  buildtools/meson.build               |   4 +
>  buildtools/rust-env.sh               |  96 ++++++++++++
>  examples/rust/helloworld/Cargo.toml  |   7 +
>  examples/rust/helloworld/build.rs    |  24 +++
>  examples/rust/helloworld/src/main.rs | 219 +++++++++++++++++++++++++++
>  meson_options.txt                    |   2 +
>  6 files changed, 352 insertions(+)
>  create mode 100755 buildtools/rust-env.sh
>  create mode 100644 examples/rust/helloworld/Cargo.toml
>  create mode 100644 examples/rust/helloworld/build.rs
>  create mode 100644 examples/rust/helloworld/src/main.rs
> 

Hi Gregory, some high-level feedback:

* I'd suggest for future revisions splitting this into two patches. The rust
example should be separate from a patch adding the basic rust
infrastructure.

* For the example, I'd suggest that the helloworld rust example should
correspond to the regular "C" helloworld example, i.e just init DPDK and
print helloworld. If we want a basic packet handling example, it should be
an l2fwd one - again to align with the "C" examples.

* However, in terms of the examples, if the idea is to provide higher level
"rustic" APIs for DPDK, the examples should be written to use that. Any use
of the low-level C APIs should be in a testing app only, rather than an example
app. IMHO We want to encourage proper rust usage, not C-code just rewritten to
use a different compiler.

Regards,
/Bruce

