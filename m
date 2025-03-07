Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A98C282DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 16:21:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBA2C40E39;
	Fri,  7 Mar 2025 17:21:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D807E40E36
 for <dev@dpdk.org>; Fri,  7 Mar 2025 17:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741364466; x=1772900466;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MTV3ftXdB6hxdlXBdiuB2a5ITTZYrF65d8hHEYwtnlw=;
 b=Pv73BfelUfGoSt47udGN7aICzSnXpPS+J0E193h9m+P0GVzt04x8Owp3
 ZAJpt6YqkW3l11KX9nst4pthH9APihNaxnVAhtYY0hREYjHQjfCu8qj52
 fWiLIkH9DmSE2wDRFDsTSk4yDUm0w41UDctBg3GfO62gHDOT+TBiplQFs
 Uxd3ctz+1ELTbso0D5J3uUAO1OvXwMh1AWZ7pN8GNrcj3NXcsaQaoW7R6
 nXb4DaEimzyqtuMM/l7ibHMIAYxDMtaakCNLsBHQVPYBXhviw1JKO6x6O
 Ou7TNQMt2WgTqEMVjZ4IkiRkxLeWCxAuWnKi0EQnugDxH2KrnZDh8b84U w==;
X-CSE-ConnectionGUID: XgdAl85BTS2PdCdD/dAR9A==
X-CSE-MsgGUID: cY3eKToPTKGgd6axjD1vsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42617999"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; d="scan'208";a="42617999"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 08:21:05 -0800
X-CSE-ConnectionGUID: QsQnp9krSl2/ZxLZ7G/xjg==
X-CSE-MsgGUID: Mw85TnEcSWSutAenFMPr7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; d="scan'208";a="119352476"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 08:21:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 08:21:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 08:21:04 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 08:21:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOD0OMSms1uPALS8q+GG9kKHpcVAs+vK0MS9nQhsqz1wuDXbWptpZ5lCuQsTvRwxX6+DrxMgZi2Onpccx2boHtA+hqvV4tSvgtRPT2xBSWnNXP3WdarA+0JSHvEXO2UdleMH/dc1VQTXmnQpuqlnacvib0+wWG8AsF6KGUeV7LH4139l7tOEv+/sqpwpiJT9L3lhmtpQ8SmVi0NogM5NzvNceggnoesT4FZ9+XpQYm/3d49+lujgxGXm0jwttA26UFvSWu2K39w970Y7QeR7l5UqQsCveqFG9v7AGffkzIsOc4kchhOON9cvCoF96v7mCEibUh/f7eXF06lzy5gjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjDyS15jMly/yK11Y+T62Dz0g0QJYhTcZz8z56Xonp8=;
 b=fnkZqKv3tvmjyIowwqlou9SiHdvFV5sTC6Ex8OY0zJLbHo9M95BXW4c+tqTjQ8B3vLDlmPvKgyGobh7seE4tnTrehC8pewCOzoyk5lj8gq2NSXgCkFfsRpANcyFqOmzhyt1plNi9Du1D1TkQsR8r89JDwu95C+bgsnT1oufbUV50by/p8wvkrJVViCRQcAyS9TK0b3RNZ6TpdM6sKnCPqW6RK7ixIHCaECsXhD4udvOGFPz/GRuSOTi+nh6NhELM10MSRK+SjPQIUsBSfk+Io2fD+9yWUa3sBnxwRfIAvOmLemZLgfFkdza7Jx0N0jkuFeoXOkG0b304BRFnZ1P+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 16:20:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.023; Fri, 7 Mar 2025
 16:20:33 +0000
Date: Fri, 7 Mar 2025 16:20:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
CC: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "mkashani@nvidia.com"
 <mkashani@nvidia.com>
Subject: Re: [PATCH] rust: support DPDK API
Message-ID: <Z8sczC2L6zRKvGk4@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <PH8PR11MB6803599C6A152CD6B70465A7D7D52@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH8PR11MB6803599C6A152CD6B70465A7D7D52@PH8PR11MB6803.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB8PR06CA0065.eurprd06.prod.outlook.com
 (2603:10a6:10:120::39) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 361c2d8c-a0ee-4342-4b78-08dd5d93fc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ooGgTqn9htJsBtCd89xJuShgmbuKgn25qTsQ+TajIDm1O27YaqyBOXRuIJ+?=
 =?us-ascii?Q?h6uTNfWHxXQGOEqiSXaMpQNn0jhYs5OivXiey16RO3tkX4xEXz/qIsR5eEIB?=
 =?us-ascii?Q?dhR5oKFv52Qqoz81HRKArs9TVtgxF975gS0uCLH9OLRTxANOoawFkrN5rehW?=
 =?us-ascii?Q?cug10E1a5PXG0tFqDqDVTgh2WnlIXc2MfVrsomN8Ttg7T23WcX9CEanBuKr5?=
 =?us-ascii?Q?LS3loApZC7MxLhOn4xmZOsEwraBxrbdIRCARH89mI745Q9HQJ3uluNmyz4Ei?=
 =?us-ascii?Q?nvVWq4bZDBsXwxAc+62TZfGOxa7Ot8bPQ7HlmfU/RDa74yfryy7aAtC3GchR?=
 =?us-ascii?Q?qHDRh4TuZp3vq7vlhINznEP3xj+SlhDHvduDKh49Leb2q/owFpLs/4gQMq5t?=
 =?us-ascii?Q?B78k1Korv8Hls9LtjKddYKt4ctYWy9fZT2iDJ1obEau6nyqvoeZtxacDO9Hw?=
 =?us-ascii?Q?8TYqAp87dsjEZDkZDMpnobqhVuj+EGozZIXyuq2vtDjKq6RQmWdGfExXML87?=
 =?us-ascii?Q?fYaCEv6fo+4GMSwr5tUFGXunc6wfkeCU1dOBDAlb5epZi8JwVS1GdKR9N2Ft?=
 =?us-ascii?Q?/qe1caD9Wtqz1asRwPohedrq2dY0j9qgrhgvLQtAfucYwc9c1s57drvN1Q3I?=
 =?us-ascii?Q?GBikVNQ+UmbXovfUavV+ljSWm/ESZEUEcHDtZQc5/MrZOda0Bk8vy/zV5xEx?=
 =?us-ascii?Q?f1Y12i6VdF0yZFqfKpsKLtzo1ATwsdfi0eBVSf6ADMT5/ZdHXfm/0fkYPHou?=
 =?us-ascii?Q?BMvq5I8HRt+8K38zr5nvvbK9aV1ZyjXWXy9HAf4DoLq2UfJTy9GZksxSpTqE?=
 =?us-ascii?Q?S2h7SADZxUELfgdVVfRe04EyQoFnfadqRwTC03ayEghXCcZh0wuqwLrFa+8S?=
 =?us-ascii?Q?kokSENbk/xszC7PuQ8BF9aux6OsfxPkx3LtFtVUyC7p9IlpIcOsqmAxflO7Q?=
 =?us-ascii?Q?dq8KQNH4T9koE9tg52eu+VZnHv31wheJm8NITfnzfT8UU3Y4hMnTB02D7o/u?=
 =?us-ascii?Q?zT7rsfZZWkJzJroyrA28Go+Q29clkvdQD6wsYbLajO6ohLw+x8IUTr/g5WF0?=
 =?us-ascii?Q?9cvp2Hxr601x7nZilMKGmK+zsSuovMywPwdB4aBGfx+ta1ZghB5Xufpi94g+?=
 =?us-ascii?Q?oORbce4PQjXPStB8m11PZmeIWCjfqfsN4wFckWlTRkqrRATuzhnqmQY4p5sY?=
 =?us-ascii?Q?kEya3eCbWBGM1otHIR8LB+rYixEKDQpYfqyL8HYA16Byn8cosUOkZpCVwO5I?=
 =?us-ascii?Q?A6x/srYvaa8/XX6QnsUx3FLGiZRtHtutI6FiHJyLeXqbc6fk5Mvv2v029P7q?=
 =?us-ascii?Q?TWOXsSD63xe2bjoJwmjxnl2q8lmwyNShiTXBMA2Hy45TgB34aRQluW/pySud?=
 =?us-ascii?Q?y244APmRsjhSXFUKvGoqfxC66wjV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DchWOtOxsU64BT8W0cKqxBPLkeu8737//pT47OTPP5uz7WQWKo8z4Ojr9rcd?=
 =?us-ascii?Q?4bgiKDwZtq672h7HpDr1z71L5Pv96WuR+vpiEWo8wHlbV6IMH/y/mu9Q3Od4?=
 =?us-ascii?Q?cU2xbN+LrKHubASWVIP0fxRsUaFUOkPmo5NXjFnB1ake3YVD9UpyZhfVUlvo?=
 =?us-ascii?Q?DgewvLuj9Hwsejo3bm0W4p0oUIHFRXxgS1l1l0aA/sa47ij4Dasrwh2DfYch?=
 =?us-ascii?Q?YGRBtjBy/Ol2ZTeW0EFX2MY5zFZUcmhsp7R9Gg51UpOq6rsrkvj8UdXFLvge?=
 =?us-ascii?Q?/ayUs9d/9hPzDh6Myroa8OPYvnwf7dmTxQXmstReSRNEWzmPY+Sax+roG9ks?=
 =?us-ascii?Q?yI6K+FYsmTM4s+BFb3UYSIAPEHjVG0y6WZtlbw9wmhpkw9UjRqk7khkQgAGW?=
 =?us-ascii?Q?ZwtuyQfoJvVqauNmB4bTQoOixTg2K/RuyHkT6C/0/dHX/q8eeOCxqDQQ0YVs?=
 =?us-ascii?Q?5cz3MqqrfY8/pLQm+CaWRN3zLHB22D+7R+A8g8qVHls0AmnBOv+xJ9AdwrQn?=
 =?us-ascii?Q?oETGslMY74o7Ar3VhqLZULedJ//3MJXF6G8pRFXpiCB+g/Lakd/G9y22HSUQ?=
 =?us-ascii?Q?yHyxzCY7CJ3ElAePeegIdH5lNG+6nT7Bv8IEMXSq0ALe8sxEXYSqDCar/rV4?=
 =?us-ascii?Q?61pN21LfAhBVG1wS4PRmpI/AAjlCE454SdfnrAfMT8Y2fU6hkIl0GLuti3tx?=
 =?us-ascii?Q?x2N7sGoiryYX7eGDNI+7XmWdG9DMShcXoJ553CFUyTiulsH55ajePmbMjn8J?=
 =?us-ascii?Q?V8+Zu1Gv8WQoRciF7IlFzk1oePFaTC9SKKAuBrvRtChU5uqjAWVyUOPOGATt?=
 =?us-ascii?Q?8jlLOznJTl4qJc6ZeW3SvtTZSWDQQ82HU2YK5splGOx0s3fEzfCNGIMo22Kz?=
 =?us-ascii?Q?YpcsnmG0okJndJ1r3V7RAq0jjK0nOWYKX20oS8e70DJirF/M2Ooo7Bbjj9sa?=
 =?us-ascii?Q?0n52nYeTT065axn8rMwmlJGp+EQeJPWGGv4qJrEHr2GRZ8ZZfsaShkKndD9A?=
 =?us-ascii?Q?q37mdfKsClMdbduASh5OC79ZociXFvSSrWufPg+uUXgn7ug//CBsezodXX/W?=
 =?us-ascii?Q?CJ6XwcYCHnNCTDG5F5h+v3GHwc92BXrDe+aLFbZxojg1qLR4/Sb32FYcQAih?=
 =?us-ascii?Q?Zr7fBcFeHi6lghQqmVhi8oQhIlqV+yPtnC3ZVZNFwOMYUer7NYzn2NDaFPEU?=
 =?us-ascii?Q?LSfCo1HxpC7VuWn4xWRkYZ49mTUPGP5lUrqnhlga8/GwYA2WZ+jRy8NKhDba?=
 =?us-ascii?Q?uapAEY2QHUxT4qbGUbT6inflropW23vGr3ZxJNtuy2mQxuGWeGct8Epipg6N?=
 =?us-ascii?Q?KMZByRf1caHWmcLoQTfYvHLrTPzMQzNl46I8CbT1c6RM9+3BqFAQbS7aZ0sq?=
 =?us-ascii?Q?UQxden8bhnlLPzshAmDB7zucyMhqyXuETP1bFmt5y/fEj+0DcOG3gQoNylgQ?=
 =?us-ascii?Q?rZcsJvn3j6zAr95G9N+O9JRgCZac5d6iDTmXP4lm6p4PG+15/Ikd0eIWPt9W?=
 =?us-ascii?Q?+WdGyCykorpPvHIqbjHE14owxjseZ+OBOugUUNbtuBIT3/TYof1d97/ShlVF?=
 =?us-ascii?Q?07AbFAU0eO6382AW9Haxjr/cRS7i1YV6+To13Oz45n1gcDQLrmA2dKHwWDnd?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 361c2d8c-a0ee-4342-4b78-08dd5d93fc7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:20:33.7191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEMR1CzzUYz85tN+9Un4lCGSWj1tOuyNofHkb66Lhf2uz+4GePEq71abkybHhlQ0/Y3a6pSYT4lcSXNAEj4lueNEj6sYcSxmcO3RzJ2Tjpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
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

On Fri, Mar 07, 2025 at 03:54:33PM +0000, Van Haaren, Harry wrote:
> > From: Gregory Etelson <getelson@nvidia.com>
> > Sent: Thursday, March 6, 2025 1:37 PM
> > To: dev@dpdk.org <dev@dpdk.org>
> > Cc: getelson@nvidia.com <getelson@nvidia.com>; thomas@monjalon.net <thomas@monjalon.net>; mkashani@nvidia.com <mkashani@nvidia.com>; Richardson, Bruce <bruce.richardson@intel.com>
> > Subject: [PATCH] rust: support DPDK API
> 
<snip>

> +
> > +use dpdklib::rte_ethdev::{
> 
> As per first reply, I'd like to see the end-result safe-Rust namespacing be shortened.
> 
> This can be easily done by renaming the name= in Cargo.toml, and
> removing the "rte_" prefix at bindgen output stage for each file.
> dpdk::ethdev:: { RTE_ETH_NAME_MAX_LEN, ... };
> 
> Perhaps its a good method to put the generated (unsafe, raw-C-bindings) in this
> namespace, and build a safe crate (with the dpdk::ethdev::* namespacing) over it.
> Thoughts?
> 

I love naming discussions :-)

+1 to separate namespaces for low-level DPDK wraps, and more rustic
higher-level APIs. However, that doesn't mean that the names get to be
ugly! Let's definitely remove the "lib" in dpdklib (or libdpdk), and the
"rte_" prefix from libs.

How about having "dpdk::raw::*" e.g. "dpdk::raw::ethdev" for low-level
wraps and "dpdk::*" e.g. "dpdk::ethdev" for higher level apis?

/Bruce
