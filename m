Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ED8C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 16:26:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1B0840279;
	Mon, 10 Mar 2025 17:26:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B30BB40270
 for <dev@dpdk.org>; Mon, 10 Mar 2025 17:26:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741623976; x=1773159976;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CmUbovsdudYdk+bghZ1euyLpbcOooyNFFbd71OfhZc0=;
 b=O9SBce3RBaEXtNpGITdSomAKnf8dbYNzlQE13Eh0HmSAQUgJkvYMGqSJ
 7F9NjIqHR9YXJFHU/UUYYb9pz8pcetRkR63H2EAxNnSyo2ThTD0wkAmEO
 S2NAqNTbm23A9/I/hajqYqAlhXCeqRlXlz+goFRKBfM3G5NYNbTVY/EKJ
 BRNCuUtfkqFyja+gqlptZ4OV4rrAdM/mA19pwVonHKvm4UbfU9akHTohy
 S4EO8tu1efU4Me2VUMkFK+IEKRI86C54ssUt67XLViH7ODHKhOQEaCc/j
 Wyqq1BWfwD+lmNenFkXgVr2pUrSpAVPpVYDbB6gBcyvoRudwP5+w+Vgcy g==;
X-CSE-ConnectionGUID: fFl9LVqGTImbNjffOAp6uA==
X-CSE-MsgGUID: mgfp241pR2KdGwQUs+9fYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46276980"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="46276980"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 09:26:05 -0700
X-CSE-ConnectionGUID: LIu4ce2eTvSIBLjuYg8mZA==
X-CSE-MsgGUID: e/qR4yz1Q+SGAT8ITqKf7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="120559999"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 09:26:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 09:26:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 09:26:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 09:26:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehNXU5ANc+8TRv6oBP5kfISnmfuyuV7nfKmVhlHzkfqwLSE279NxjQFTh3UlVQ6B09t893Nd4yrR7DEWUdYqLSC4SV71Pz9AuVmQyWBGixgKUDwdU+MCUonVNrRVVmz7Ed6ZtL5WFLoZ5SZP0YRLf+N3fEuoDtPT97mdSV6matZ8TaLRlhmuwOmdqCmvMNMbr3augkt9ofuH59JJEvIHKhLQAEhmnPvy8M3GHLPAxjiwqGosOU5cnXjpORPV8eDn3oBdgtbA84SYT6rd2Pw6Oz9givo6rTOp4YWzUgBfmYh+etxXdLk9kyErr3kK9Qe1tlWpEukHuBI6y2hvIPNOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGKhxS3REOM+js50UJNIE8nG3nYDuU2umBC02KUCs6M=;
 b=IuvVf2aHfgRhaKZNgsTD7/xBeXlVtDBPchRfzEL9w2CCOyYpTpu82OcoTQsOYWVC2W82ekJ9VJcwFm8UuaQz1Dh5jPwx6rxeR8g7cgWc0Yxz/nVQnqKuMrdi5H/bG+TPTwrRsOUHDUhu94+ucaMzUqTHhsTLPyjXF5eaTiza0D1d8B/NDsy7YSUPRq9/WIJNVytKj/oyWEYUUhb7L2ckrODouL8sYXOoCQFOeKwZtrW58Wh87pClZnrv/uarxXiYcyPVifBbzcKb5fWEcUaiIBP8aEo5TQt9xYB7GKxS6eDCdyROvvm/P+MVb0UcQ3eVuxPY3dk83Rcg9JSWxBSCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:25:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:25:15 +0000
Date: Mon, 10 Mar 2025 16:25:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
CC: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "mkashani@nvidia.com" <mkashani@nvidia.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "igootorov@gmail.com" <igootorov@gmail.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
Subject: Re: [PATCH v2] rust: support raw DPDK API
Message-ID: <Z88SZddtUfSpTBhE@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250308185031.979893-1-getelson@nvidia.com>
 <PH8PR11MB680333949B01E4316CF44E29D7D62@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH8PR11MB680333949B01E4316CF44E29D7D62@PH8PR11MB6803.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 667a71c4-938c-461c-596d-08dd5ff023af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?StEWqfDlQtxMzcr4owWQEqodFwPBeW6qlSmCCigcQ7ri9XKYUDl14+xjUNQP?=
 =?us-ascii?Q?XYN11eeZF1mbde7kyveFf5XdpyHr8WLTP5LWcj98CefSVW8KeCROZYqR7EvC?=
 =?us-ascii?Q?wkBXHvRXsqVr54UARHLWdoVQZ1RLR+238NjY1tmX6OV3JOihjXwZpDSuQaAA?=
 =?us-ascii?Q?1WjS+tkX37O6XYqdUHEQeeOiFKhckyiB915Dst+Muh/nsVF2bH6h2SVJ7IHc?=
 =?us-ascii?Q?0IDPncvqiAOS2131Ft1MgRDSJAtibWO8GTjNuM73u4gfSeeoYv/wNc94WM61?=
 =?us-ascii?Q?s/U13cVCSw+UquUuu0toZHlDqCjXhlCjVLsBC9JJ9Y1d2HkfeocPlUgazXs8?=
 =?us-ascii?Q?Icyw4tzYtjC80UN0qNfnzBZNHO6a96552t4rD4Bugt7Lg1GjSw9COnLqbi0D?=
 =?us-ascii?Q?92aH+RA6iNBfxVvaBwEYdYpQX7osvh0/x9fBRgfEiWkJKI4krsWYqdIA1ouJ?=
 =?us-ascii?Q?83KRp2tXBd+rz7UBN09s4sHIgPwNEavjN3sY1OxlCQQMcbYb1SmzjsR1n0Rm?=
 =?us-ascii?Q?L2A17y8e87gQDiSwPtgXg+2AyuzWexevda7FkcoVf5nK/tNt0hi/LJNj3deW?=
 =?us-ascii?Q?oTVmioFliHcD063S7+aBbfxk+kQHMILJod/LF4cgRMJ9b0+zFDlxWBBxsWrn?=
 =?us-ascii?Q?FFsAZOGi3l8otTvo34p0w9F50F0nc1gXIH4gZuexhLmzHtpthM+X+oML859E?=
 =?us-ascii?Q?f88dNWrsekIEpPSciwAgS1eCV1eHriZo4+xSBeXZwH3HsU1DJP5sEAsGhPQl?=
 =?us-ascii?Q?o61XNPfPNyVAr0qm2mbjpyggwSbJXP2+cwb4cigDVx0EqfsPHfuDEkz6tsOf?=
 =?us-ascii?Q?F0tNT2HQa5hQHfdggntSsuTBD4iNFPDDA29+2VvRDUxrxw82CSYPfgofjdk7?=
 =?us-ascii?Q?Atd+gb1w8fncJzbUwGv7uA+mX68fJ0hd4qeyH4rQvLoPECWHyh1UaOdQwU9l?=
 =?us-ascii?Q?3K0/a4PHEqOGQ33T4WFxvzCmiLy9N1P6GX0L+m7dKIZ9fjnLFvNchudmQdkx?=
 =?us-ascii?Q?fupujjGjVW3jhqDyVzHnhIE3tK6Im/Qz9FuK5k+B6vJq7Lg48lzXahiVK9Ge?=
 =?us-ascii?Q?GEIPFt1XaBjz7EazbZZB2Tzd4b5ue86NXPK+i8AsabCl8WXAFSX+WwcYFSf0?=
 =?us-ascii?Q?OfqhKxiDiPGHZQ6mh2uD/BETqwu2tGkOqYrCO0bjZlTFrrzqDkR/sbSaecvz?=
 =?us-ascii?Q?0yyPi56d4x3nLxk4ccb3zgc/tFeI/nYVOZouzRfEaUXnBXhx8EqeSS+MFlE2?=
 =?us-ascii?Q?jHPRHK8kN5O0bqCzqBtfyWdA7FWAa6uuWnMWklI1oDbzxza0oMjbuSv11dwW?=
 =?us-ascii?Q?vAlfDyPIs0MpN1NuHg8Ty++eFhuuo4MZ1/PdKkaDRmfP+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zMLsTd8SQdTPIIiWNBf4G58gF8/VBSVATMYn1oS1s2EqXtn/vBQZ1VXtoFag?=
 =?us-ascii?Q?YFSoAhWH8RHFbSp4mSUeAlcb0zIPK5OLQkSh6OmAuOQRA/87bZO060up0cOk?=
 =?us-ascii?Q?GAtBzqO8p5U09Jzg55m3bJfehEb/UmoeozRPHvqFXD9Jlb2yfSoxy9CYnw3y?=
 =?us-ascii?Q?WVUEzpvFAvNNcCXQcBnZ2gxhG4s+5DhgJcCBFB7AHAZq4blj8ftlwLpZUCOb?=
 =?us-ascii?Q?GFUtkiq2cgBQOOe8cjObYMgt3VcJdbpbnGnto2vGWMvYda6YElCuY7zUd4Mu?=
 =?us-ascii?Q?Zp/H7hhnrFvGkL+R0rPnLMHCZIoFxsRf65F9FQ4y/7l+mCdiKZj6UW1r083t?=
 =?us-ascii?Q?nM2zbqABSj/w0v3qFkc6eNjw0ZVcMnLpFLsLiPik/ytC87c2fL0GS3SagzJp?=
 =?us-ascii?Q?bfZjsgMg5YJY7XGMKEWxmNh2yh49licvfkpBFWIxO+ahuU+/1rilqYL66Z+u?=
 =?us-ascii?Q?++lVtBi3CPd52youMBnGnmlW2UUeKLR9DUdYnQ6IcrLRs8HxaMXzx98udYCQ?=
 =?us-ascii?Q?I3bLQoZp1V7SCk0kIEGS2TXqegjE69n7RaUPahXL4qwKZpnCGZKhMBnuPCPo?=
 =?us-ascii?Q?djpwX2TDLbFRyt4fFrR6l1psKKcQBzU7Y3pz/r2HXCSGZ3VjI99GnGyguTIf?=
 =?us-ascii?Q?BqF/tQM8i9UbfLLAVjystRRA98YladEygoP0iv4slJg0ltNB5yu63n8R6xaW?=
 =?us-ascii?Q?fCL4A+/neovfgji7AY0B/A30gcn70gSd7qgnlat2f8x6CujgjOqxI9+Q/ED3?=
 =?us-ascii?Q?VaZQQWaKrApflBZX2M0VhqwGNF+c+SJYCKcKTVQZwh71ofu7jx4bwlG0vAZI?=
 =?us-ascii?Q?CyR4AK90o22L26QfoFaDEIwELZXYJ7mzB2iy3y5KidzLLr2ZKpjCmxPv0CX9?=
 =?us-ascii?Q?8US0ENTnZT8pxoT+Y3FQ3JN8QSOjuG92iWb/zN4z82Qg3bEVoj1YpIQ8W2ua?=
 =?us-ascii?Q?SVXfUxQSqgXY08aAEvDhs4SOMHJkeh9WMT+hwAIhmr/SWUs0l3q10Tpo32+M?=
 =?us-ascii?Q?iH7wq5fkr9aVHw1SKmmsA+nyd4NwuTjQGridfaC5lT5K6WmFrxOd7k6FDxVq?=
 =?us-ascii?Q?XK0sReIS1XaWURF3O8KiWyCefxyQtR990/NnsivuyZjiKNgdKJwiVkAB9UpU?=
 =?us-ascii?Q?hyXC5msy8QqNw+7oX5QMTfpMMBYTSd7F4ax72XdsA+7HA8qLEKtO9JIhaTSR?=
 =?us-ascii?Q?hm+YXPNAcstbm8sm1M+NWSSwoh9/epQtqqaz5Ed45XO6crG5mpSa1zG+OkP7?=
 =?us-ascii?Q?WXvXLNAtVqj0q9vyNSwclO6kQ0MfXc1djKJh/Xj9oDHSaSZf3AFC3/RVqL0Q?=
 =?us-ascii?Q?NdK33nzTRhgzpadc6cB9NtwxGrjFpJhsA09cTX6+5o5OzlRMYVd4ukQ5XHgV?=
 =?us-ascii?Q?Tf3LaGYmo1yvd8IGsyzl5sqC56thyjZewSCLbkNJtYILpvBNF91GgANajCDT?=
 =?us-ascii?Q?lrzFvMqqC0FSIEL2ooYnaiBaEqMY95q7hQswWSkHlYuxFZxwxJLwD2QKc9ad?=
 =?us-ascii?Q?EAU9MEa903TJ8L9BAlAXCduyVj18LwVIcVpak6ewvY9NPODfKgNx3cIkMrr5?=
 =?us-ascii?Q?X0nuQ7B6eaE447QqXMNW0ElS0RVxDYm849xV8Jp5ZHDbxT7MpMyXlzibtRVO?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 667a71c4-938c-461c-596d-08dd5ff023af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:25:15.4853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg7b0JqK3JpX8vQJAoPAnzlVhemAJVyVsykB45hnhZ9eGyCEqnymkILlOKXc51xs/fDJ0EVe6BNubKqBcdZBRBTHpQb5iUIUfHFR8NBmkcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
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

On Mon, Mar 10, 2025 at 04:13:21PM +0000, Van Haaren, Harry wrote:
> > From: Gregory Etelson <getelson@nvidia.com>
> > Sent: Saturday, March 8, 2025 6:50 PM
> > To: Van Haaren, Harry <harry.van.haaren@intel.com>; Richardson, Bruce <bruce.richardson@intel.com>; dev@dpdk.org <dev@dpdk.org>
> > Cc: getelson@nvidia.com <getelson@nvidia.com>; mkashani@nvidia.com <mkashani@nvidia.com>; thomas@monjalon.net <thomas@monjalon.net>
> > Subject: [PATCH v2] rust: support raw DPDK API
> >  
> > The patch converts include files with DPDK API to RUST and binds new
> > RUST API files into raw module under dpdk crate.
> > 
> > The RUST files and DPDK libraries build from C sources
> > allow creation of DPDK application in RUST.
> > 
> > RUST DPDK application must specify the `dpdk` crate as
> > dependency in Cargo.toml file.
> > 
> > RUST `dpdk` crate is installed into
> > $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust directory.
> > 
> > Software requirements:
> > - clang
> > - RUST installation
> > - bindgen-cli crate
> > 
> > RUST dpdk installation instructions:
> > 1. Configure DPDK with `-Deanble_rust=true`
> > 2. Build and install DPDK. The installation procedure will create
> >    $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust crate.
> > 3. Update PKG_CONFIG_PATH to point to DPDK installation.
> > 
> > Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> 
> Please include a "revision change" summary, this helps reviewers understand
> what changes you have addressed, and what changes are not present. This usually
> is formatted below a --- line, so Git doesn't include it in commit notes.
> 
> Also add to CC any participants of the wider email discussion.
> (+CC Igor and Stephen here now)
> 
> --- 
> v2:
> - update rust crate name to "dpdk" from "dpdklib" (Bruce)
> - update binding generation to use dpdk::raw::* namespace (Bruce)
> - <were other comments/notes fixed?>
> --- e.g. "rte_ethdev" -> "ethdev" namespace change?
> --- e.g. "cargo fmt"?
> --- e.g. "build.rs" simplification & fix?
> 
> Pulling comments from "detailed review" email thread (see v1 on patchwork)
> - Gregory: "The idea was to provide generic DPDK API and let application to resolve unsafe interfaces."
> 
> For this patch, OK. But we (DPDK project) should take the next steps, and provide a "Safe Rust" API. The main reasons are that:
> 1) DPDK APIs have many rules around multithreading; (lcore concepts, rx_burst() threading requirements, etc).
> 2) Cross-language bindings are hard, FFI is hard (even though C/Rust is one of the "easier" ones)
> 
> Overall, I'd like to set the "goal" of Rust in DPDK to be "if it compiles, it is correct".
> For example, if compiler allows "rxq.rx_burst()" to be called, it must ensure that a &mut reference is valid at that point.
> That gives a Rust bindings *actual value*, as opposed to "allowing DPDK usage from Rust (with all threading/unsafety just like in C)".
> 
> The bindings are the required base for that: making it available. But it is important state
> that these raw bindings are NOT ready for Rust folks to go build applications in "safe Rust".
> 
> 
> - Igor "Indentation/styling is a bit off or inconsistent. I'd suggest to run `cargo fmt` to format the code."
> 
> Big +1. Rust has a default formatting engine, and using it means everybody wins (no checkpatch, no manual style rework).
> By reworking (and auto-saving..) my updates of the first patch, it reformatted a bunch of code, losing my own changes.
> Small things like this really hinder productivity. (Off topic: I'd like to see a DPDK auto-formatted for C code too!)
> 
> - Igor "I'd make `init_port_config` and `start_port` a method on `Port`, rather than a free function, but that's just my preference."
> 
> +1 here too. There is a logical "ownership" of functions to structs. For value added Rust APIs, we must
> not copy the existing DPDK namespacing (it does not capture "ownership" in the way that Rust API should).
> Instead, logically understanding the thread-requirements and boundaries of concepts like an "Rxq" struct instance,
> and ensuring appropriate Rust "Send" and "Sync" bounds are applied is key to a good Rust API (as per https://youtu.be/lb6xn2xQ-NQ?t=702).
> 
> <snip>
> 
> 
> > diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/helloworld/src/main.rs
> > new file mode 100644
> 
> <snip>
> 
> > +pub type DpdkPort = u16;
> > +pub struct Port {
> > +    pub port_id:DpdkPort,
> > +    pub dev_info:rte_eth_dev_info,
> > +    pub dev_conf:rte_eth_conf,
> > +    pub rxq_num:u16,
> > +    pub txq_num:u16,
> > +}
> > +
> > +impl Port {
> > +    unsafe fn new(id:DpdkPort) -> Self {
> > +        Port {
> > +            port_id:id,
> > +            dev_info: unsafe {
> > +                let uninit: ::std::mem::MaybeUninit<rte_eth_dev_info> = ::std::mem::MaybeUninit::zeroed().assume_init();
> > +                *uninit.as_ptr()
> > +            },
> > +            dev_conf: unsafe {
> > +                let uninit: ::std::mem::MaybeUninit<rte_eth_conf> = ::std::mem::MaybeUninit::zeroed().assume_init();
> > +                *uninit.as_ptr()
> > +            },
> > +            rxq_num:1,
> > +            txq_num:1,
> > +        }
> > +    }
> > +}
> > +
> > +pub unsafe fn iter_rte_eth_dev_owned_by(owner_id:u64) -> impl Iterator<Item=DpdkPort> {
> 
> Looking at the above parts of "Port abstraction in Rust", I'm not sure it really adds anything.
> It feels a bit "middle of the road" (aka, adding some "abstraction", but not going far enough).
> 
> What if we took an even smaller step: remove the Rust struct concepts, and just call the "dpdk::raw::*" unsafe
> functions directly, as if they were C code. No "struct Port, impl Port", and no "Iterator<DpdkPort" concepts at all.
> That would show "correct" usage of the raw generated bindings, and provide raw API unit-tests.
> 

Yes, definite +1 for this. Let's not try and have a half-C, half-Rust set
of APIs, but instead let's have a clean low-level mapping directly to C
functions, and then build a proper, safe API on top of that.

/Bruce

