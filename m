Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04273E7BD83
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 10:48:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CA8E40289;
	Mon, 16 Feb 2026 11:48:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id CAB0D40269;
 Mon, 16 Feb 2026 11:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771238905; x=1802774905;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JHXpovnyIdHXwyI/YFvoJeVKfo1/wEkIWqykW8hNGe0=;
 b=kSUMHV/8B9BkskdsCGVuOZRpIN4ryALKNt5u9/yCc+L4QW9ve/twBjfk
 txS8Fv+Tk0/ebFVJU5OaZmsYZCSx++P6t7JKGtJJnvCx0D/siELCTvRif
 etePUwU1OWkRFs2no2Ae3miRWJ5y3lZf5HyGln17nZazwfuLELoKJMZkK
 4PgRo918V1Lc91rC+M9zAzG8uLzwFH2CKAYiYOuw7E/4+qo8PSMOhfTvs
 3Vkr2HehqbwcSfyW0OmYIa8HHEc7tl1h6TRJQXF0rXu0SBteud2k0gtPS
 GmS8nqJVWb2WOtctU1f9MGSWJxzbjD8B7kwqob/2VFXUXQ20fkgN1fROQ g==;
X-CSE-ConnectionGUID: oQwZfiJ9QGm52ZP4HnHWMw==
X-CSE-MsgGUID: qKKiwhcDSB+cXItWuPKvNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72306390"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="72306390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 02:48:23 -0800
X-CSE-ConnectionGUID: gLC6fiGwSqiKTOMUSyKNpw==
X-CSE-MsgGUID: ITsNTA/mTzaDMCfyySSV0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="218096785"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 02:48:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 02:48:23 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 02:48:23 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 02:48:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7bJjoLGtOU9bo2ui599bLLfAOJz0rdjp7m6XXSCbFLCquC8uOz10a7qvTWIzSMRP6EhMtKgqNOVNXpkBurDQaH8sw6fLXnC+9RPKhL66ZeoUIDxbQotrUVXPpmiK3t6dB7tmz7kU7Vpze7sFAE+Eu5VD27kMx/J4yEfvBgBwvX0TrnLnQ0rCBr/TbeGfnR5pyrPvU5cZl8cwHtsaqcswlokKphdIixyg0bhpxihsufSlBjH+AIhXM7eXGjhZlUsWU5Gd2EYB2ZkF7bwxUWC4uqAAmXXddAanAY8yUlHlEXI+ixSSUqeUic9RIKen/Oh2P86tqc6xGTHnPNwDs6Zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vpoWFbTJ+/CvvvCZp2sjRgkp3Nu3x2wQEAp00bQaUU=;
 b=jfi4cJ0ZaPe8EyQ00zcICHPXVK3jTFP631Oe1PqLrSfZ4Q/eSCY4QQxm0aTUkDLNMGNiQ1VeDz0v6qnEYIHxI5dD1n4kn5BgEsLmN9KQARuOGlE+Fc2gazdwHZ2CxouerUZU+nE9Ro8xotuOEGj8xBi44o5HrqYnkCLlKJiT4uCHmSA1Kv5bAZexNeQLgM8PrrKKLKq188YKiFtTFygA129gG4Bq8G7ZRhLVewClnZ4pFExK9LnqNsLOhXq+OSmmnsun3ttcMQQIdUglyOofxCSGaQ6rmCMuQ6CpX7lu2W/H21YvNTZMH0CdBquDMwh9pZVcYuL6uWVbqXEWMCkdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7332.namprd11.prod.outlook.com (2603:10b6:208:434::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:48:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 10:48:21 +0000
Date: Mon, 16 Feb 2026 10:48:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <stable@dpdk.org>, Olivier Matz
 <olivier.matz@6wind.com>
Subject: Re: [V2] drivers/net: reorder Intel drivers list in meson script
Message-ID: <aZL177s7Wu3vLsPl@bricha3-mobl1.ger.corp.intel.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260123162707.1854505-1-thierry.herbelot@6wind.com>
 <aXOm1Xep0eINPO3y@bricha3-mobl1.ger.corp.intel.com>
 <82710dcc-d2f9-4e69-9f5f-ac70135e2333@6wind.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82710dcc-d2f9-4e69-9f5f-ac70135e2333@6wind.com>
X-ClientProxiedBy: DUZP191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 325f7948-10be-4387-e9af-08de6d48e69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FlUbI01eUmUAOZOeQ51AbukOlJeD63TL4ZVpGatWjBnoa/juNsSLIBpub22V?=
 =?us-ascii?Q?SAluJ8QwvxT5lA+VMGq6I7aNm++UBRHhKwiMpgNHVKKslhz2jExEqUqFhwa8?=
 =?us-ascii?Q?x+temE9OBZ6aZnY3Ua47Q1rNlTicjE6SmdqIuvXWMVk05lpTjACENvKOJgZn?=
 =?us-ascii?Q?5P+XgInsk+BpTvqGd4RAUwBZBq3mtRqV7ZbZSRN3nZkmIKk7M5ElVytgAt+M?=
 =?us-ascii?Q?34Q4E5pA0maoTlthlTgJ3D51NJmXfhpUpLjUZ9Qt5g8/PbVH34bUFNydiryc?=
 =?us-ascii?Q?UP6UHvrjaWYxmBQN9VuC9ct2IwOJv381Jli3DthxyOHyYoNYA0g19EXVr5PT?=
 =?us-ascii?Q?UoZdumNl3Bl56sTj4fVQStEacODq3EXy3lhsC5kex5yekoSHlf2+NrAT6MLH?=
 =?us-ascii?Q?XidFyxKoUjAitzJRy91O7q4dXp9rsdZnTMfpfosen86GzuEsJnxE2v6DvYxN?=
 =?us-ascii?Q?ZW4ImNmVFVuMoc7dZJS1vXD2wjvySFhnRLaQxIDnpYk4ALU8IHcM0iS56qtr?=
 =?us-ascii?Q?KVu8l/jS/5JcBa6hGvD2nqG9/ujrSbUaoLd3fz8nXDNebGHENxYn1EWzNK7G?=
 =?us-ascii?Q?BjtJ/RGQH5IQVRko7a07O1uBa7VeBwMI+5LHfbLLYU8AhwZyZKa0BCYEagFa?=
 =?us-ascii?Q?+iEo+Dm8gHBJMWN0sEh5DC+37jpteY581PiLlNd4I1R+JJd4T1NROVzj9Q7n?=
 =?us-ascii?Q?bkkVJ6jv47Pzokor9BEVRBBOpk+kCrIcoSQ2w/7VHiIj9gXauSqkA6Vfg9s/?=
 =?us-ascii?Q?olDqExcqrxgHuFIgHcz5yz8zMUpXfX0/M8xBA9jY8hc+RmBOrrSe08UAjzp0?=
 =?us-ascii?Q?ZMINzldZPVg67Pew+8DO4j1mjNx880Bx+VnUYa247QcxqkxRPjMiKlGIW2S2?=
 =?us-ascii?Q?9/fYiOlQodLzR52BZkX2rcQ9bX8UCASki/atQL3Hgr37r2yDRo3HYW8+e4Oj?=
 =?us-ascii?Q?8xi1OMIDewuhCkKIK1LLTFoLCS6hm70bgDwLoACRjAOeGeyq10cpvgaxTkfs?=
 =?us-ascii?Q?cX3vqHCkA10KiOp2a4aYMim7pDaUiNUJ5gkZPmDNLf1TNLC6IZvslRdwNslL?=
 =?us-ascii?Q?B6ZQdQvn+lwNpvyHPxfHxwMY0vA7lgQtKy/coHYv9zm1vSoJxsaK/2SQdNt7?=
 =?us-ascii?Q?ev/elkdy+jGcwmj1XBEBiPm04xK5wuivMUsK92bvJwTgvektVOwvYYacNH5+?=
 =?us-ascii?Q?qnT05cXMpvAxJuA4zCzaPcJ03xLLgzsttkzQd2XaR42qe6oiZO9ip9ieEKG/?=
 =?us-ascii?Q?v+732JdNtGqRN+qiH5xSwm/z9Td93WUXpJvw35LcmL+D9lq0FOCXLdztHtEy?=
 =?us-ascii?Q?LZcwlxLCRWTrBN375mwZ0L6mdym95sV5BoiOJSCilFRPSOOn2GAFMLG25mZt?=
 =?us-ascii?Q?CGMG27w51YTH8Z0662EPc1Xoq34CdHZUX3Uu6Ev7J/5Y0FplVl/yqcNafKKp?=
 =?us-ascii?Q?cYgbRwVfqflwJ0PinjKkS7aHefk+NWQJKFGxAgtDf+7Uz7hTh0flm4Qvz/t5?=
 =?us-ascii?Q?aei8RUwMNiwTd68P86tWGjxSsta0Mu8qKDTctmZXYzqdgN8eGeJBiwkafHNC?=
 =?us-ascii?Q?CehcATWGxCGvaaH24Dk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rO71rkdncG0TkINxEdEhexonToow4FcPAxiJS61AHbwdjuX3JwOvkhl08D2T?=
 =?us-ascii?Q?w5FRSPYykiIabjtk0LZajle8ZOh7tYjrjMLgSOvMWTRVUo9vrjVLnKYSy97T?=
 =?us-ascii?Q?74FBg45F+ZQUnM2pmpDO3ZDPP4V5+KQuAb6zI62ghbJzUeqtok6kB/FvaEM+?=
 =?us-ascii?Q?tPnKF97Fu0t3FZsGEEj7zlkB8kVKjkQy5cKNi9ejLnjNmEyZcF5T/Fu91p2R?=
 =?us-ascii?Q?Bv6e7xijo4YD5s6OnBzuHSpWItyS5kxTpSHRSVNQ+Kpmj+y/Gp7YYc45vY0J?=
 =?us-ascii?Q?s56IW34MUzVIq7e+CjbXYqzIlndUg4wLrp/wsoeezQSDAWW88cxlOW0kyXuu?=
 =?us-ascii?Q?jbHcNPZzh0cEA9fqVnXP+UNEMzigM4joPRhq8nZjgjmkr0spcP3dTxa8snpP?=
 =?us-ascii?Q?RmQGoxx/3YZiTos+BL8Ljpg/s8Lmh1auajedHm6xXV8tN6euFz9SPB50npWa?=
 =?us-ascii?Q?DLd3CDddw9UTGDtAsUoLVOc+KjeSGHk2wQyNVLCAIW48UO5mqOXBz3VnjZ1T?=
 =?us-ascii?Q?yUESzlIIqJC376C5qbE07sv3/5QMxOlEGkZ+SfJRZ8tlNtdDFX0sWDBjWqoK?=
 =?us-ascii?Q?N8mP19ZgvHs+2p5aKQScd49hGjCkf0I7geJ1tz9WYtNZaWZf7PH8amF846Br?=
 =?us-ascii?Q?KzB1NC9xAaCZRx2qqPJps8hXZKbB1hmFjIqo6Upj5YPpY4VumROJyHnOmkWt?=
 =?us-ascii?Q?bOuPn6d+fjGkwwbZbII4blb8+ETB6iA4XlrN4pWt0u9v1cExb19dB9zETZBG?=
 =?us-ascii?Q?2zHR+j7pDBbGzcFcH+sL0TPcHh0CITAnjwD8DtNEskK0hj9ZRp9A/0nr269y?=
 =?us-ascii?Q?43gnXZjvTNCOLkuBtGV5y4KW+R+FqxP69J5ZSJldO25D/6Lyke4/wkb2H9Gf?=
 =?us-ascii?Q?1xET5ur0t9ZqkbaawMfPxrwbaYdaAxp/KLZRy83uhKmg4vh4SILu7ex0xYgA?=
 =?us-ascii?Q?ZS/WlsiaP5L/nCQ9VEF0cFl/ASsN2idoIbIGofmvk0J/WitahE8qb5mkwUYG?=
 =?us-ascii?Q?4+5Bv497eNpv096RHaMGbaVzFy6gJUXG5SOS2PM1nkPXMo9uQZxbchM/+2FT?=
 =?us-ascii?Q?zHm3mZxF7DzRzLSZowQKvHZ5YFVR5XQdxqIwavr0ElZ/V8gW7L5r1zOTxv66?=
 =?us-ascii?Q?0Wxti6at2dUCL2uyxSWYv9LpA7LGn94HTkKP6L+IWFIQypnrX4K/vEEHKaxq?=
 =?us-ascii?Q?kIU6JTfuosjummClmyf9GJvY93kNsfWwfiiUi45houiTAtem/+GdTqfi9Hre?=
 =?us-ascii?Q?YG4mPHMSQ0JU/mAIwoV3hTZicLPDGVSOmHCT07GSq1GjbDDIqbJ7VlovgCEf?=
 =?us-ascii?Q?7dD0LCS8+mhVEkM0Bp/ynic2V4TpU9H6D2bsuFr96VCukLgs0XCp478B/SKv?=
 =?us-ascii?Q?DSgtAq0DFQlUthh5U0wvJH8CQUpuqs2QLkyNSu+c3fpeC489d/mlSZUmdHvG?=
 =?us-ascii?Q?JiG6ZNZP5jzXXLUB5ZmhhL1Ubvhns/8s4p6awzxImHxMojK87NRAVr5yNarj?=
 =?us-ascii?Q?sgQg4SloiFsQNZIUhFOE+BFpqWrkH+DDT8zyHJUCoOUQCGjC7Aosgc4bhQl+?=
 =?us-ascii?Q?6bRybf5pucLdXI3sodIjajacVVQNlTOt2TbpzYywDVZxAVhDmV2hvYdQ0SPc?=
 =?us-ascii?Q?/BTbQOCmTqeUwODrnxt957vcdCCrN9WUwRBlydTWVKnu5iRpUVSlddILBIK7?=
 =?us-ascii?Q?bhjGDpsX5DnuOQsR/WBsucUgxsTC0FkM6TX/a4oQtx8rmHgUps3qN0J1IocP?=
 =?us-ascii?Q?o2ly92mZyPQaSYsL7EdOXHwTIaeNAKs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 325f7948-10be-4387-e9af-08de6d48e69a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:48:20.9818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3te0ymAezXpj4S36heoSQbETTUVDlWMfN3Xkdc65F//ccs5LJLFFfVezHT2apLNXYzdrG00IWynIE5lzU93Dz1PUntuj0SwT/1s0YDOEWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
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

On Fri, Jan 23, 2026 at 05:57:41PM +0100, Thierry Herbelot wrote:
> On 1/23/26 17:50, Bruce Richardson wrote:
> > On Fri, Jan 23, 2026 at 05:27:07PM +0100, Thierry Herbelot wrote:
> > > After an upstream patch (see Fixes), net_ixgbe_vf is no longer
> > > declared in testpmd PMD info, when compiling under Redhat-9:
> > > 
> > > > $ meson setup build && ninja -C build
> > > > $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
> > > >      "name": "net_ixgbe",
> > > 
> > > Name 'net_ixgbe_vf' should also be reported.
> > > 
> > > One workaround is to move 'intel/ixgbe' as last in the list of Intel
> > > drivers. This restores net_ixgbe_vf under Redhat-9:
> > > 
> > > > $ meson setup build && ninja -C build
> > > > $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
> > > >      "name": "net_ixgbe_vf",
> > > >      "name": "net_ixgbe",
> > > 
> > > Fixes: 04f1b16c54f3 ("drivers: merge common and net idpf drivers")
> > > Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> > > ---
> > > V2: use shorter lines in commit log.
> > > ---
> > >   drivers/net/meson.build | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/meson.build b/drivers/net/meson.build
> > > index c7dae4ad273c..8d96244cdbb0 100644
> > > --- a/drivers/net/meson.build
> > > +++ b/drivers/net/meson.build
> > > @@ -32,8 +32,8 @@ drivers = [
> > >           'intel/ice',
> > >           'intel/idpf',
> > >           'intel/ipn3ke',
> > > -        'intel/ixgbe',
> > >           'intel/cpfl',  # depends on idpf, so must come after it
> > > +        'intel/ixgbe',
> > >           'ionic',
> > >           'mana',
> > >           'memif',
> > 
> > This is a strange one - did you do any investgation into why or how this
> > fixes things? You describe it as a workaround so any hints towards a proper
> > root cause and fix are welcome :-)
> 
> Hello Bruce,
> 
> This is indeed a bit puzzling: it seems that the expected ELF section is
> present, a 'strings' dump shows no difference between a 'full' testpmd and
> one missing ixgbe_vf. Still pmdinfo is missing one PMD.
> 
> The issue was not seen when using Ubuntu-24.04.
> 
[Not unexpectedly,] it appears that there is more to it than just missing
this driver. Installing a centos 9 VM and doing a clang build and comparing
the pmdinfo output to the GCC build output, I find there are in fact 3
missing drivers in the output: net_dpaa2, net_ixgbe_vf, and net_sfc_efx.

Changing the order of things to move down ixgbe makes ixgbe_vf and sfc_efx
reappear, but sadly net_vcpf now disappears. :-(
Therefore, more investigation and root causing is needed to find a proper
fix.

/Bruce
