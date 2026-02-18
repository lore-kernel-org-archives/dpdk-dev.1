Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F19E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:14:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62756402E1;
	Wed, 18 Feb 2026 17:14:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 341774014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771431255; x=1802967255;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2h0rdW6Jup8Wundg+OIu+TH4E8UkJzEm7klAQEDoU+4=;
 b=MgytAG4X4woG3Yv8CzxuEdCPLwCf12o7ivs7SSubvTZTM+CXaupaelgD
 gsU5iq0PVo31hRVRzgWI9QoEGrtJyyEdGzo1Hu45MeptWJPf0NQzGD00N
 yxW7JEfy3KoXh/JA1NxpVUyqRnFMoNpbDyLGIyUH9J5pnbocdJGkTqahT
 i1PQt6HQn0ux9a0cWOfi7VJ2UY0jR9AwbyCu7yINa6LvJSKAzfENB3PEX
 eDIX7QqiQqgGFsk9HYxm+gXZjMoMf6GtcHH6n4k3+4ivHHhjQP2SkQUC8
 6M+qCCVXDXhhuDNkXDIjRdQ2x3MkJ3hRtZQ1WhDfrtWTl22CCBILArnxg Q==;
X-CSE-ConnectionGUID: Owi8dRm1T/CnuZnTOaXvoA==
X-CSE-MsgGUID: 321SqUoRQ+Krn4BnzmmF9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83227591"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83227591"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:14:14 -0800
X-CSE-ConnectionGUID: OQDb4XpiT5uolNUk8migIg==
X-CSE-MsgGUID: EeamsvvaRVKi4KAgzg4/Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="212893249"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:14:15 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 08:14:14 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 08:14:14 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 08:14:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bES6KZ37r45t32vH21D0965GU9eVlp7Kqa7NnZ+WbKFq2Ueti5pj8+qf26KI+gyFw/CqXbxMEIz3Oy0VSzTxwEB44cNUcFycQS3h3UgNGYa7yPEN6J00VJJejG48y/DlC042VlLTa03GQxz9N0gW1MSHGe4UBXk/x1OBchyHYLbkq/QNxZjg/jzOTpCbTFp+xlmdAFGQtmTjtVoDL7wHZGLYrWwxO0X7qaM/TRNBI6C5We5UxddLVIJSQTZZ+DASPAcbK2HslkI9x1MIcAKYzDoFlnAJoUo2UotVwsc4UxHuJaiCNvyQstr1YT/b1Xnag+oicO1I2adqaRlG9jyOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m54wsIdNz6gMoWeQxSjNHv0Rtd0GKRbbzz03pQWDi2s=;
 b=gbtz8fUDAgpAft6e+k2dJk8RMVk9idJhrT8FQHT7x82O0EK6UTYu27rdOvSNY79dtuaYjQqoga4kICunHfpnziNMnx96Hwnkih7c2GN8Yk9/DX2UuQage2VKOPyIOqQqleNnZu/ygKt6euUPqGeBsXubBQiClB7ghAx2pjVZ830XUSDCBxq2JGryEi0dwgtoN0rs85aom5ORoFgZV6c3A+gcP5ieD24DwENOP6dg/pBAlrWyhWrO1CDstzJIWdGqSeuoft5Oq6nPzflRPInmRKqZF9UKbDZtKwjCjLpeS/w6ps39ztjgf0wahJMmyTfOaoSSaqLoL5GngJ0VdwWBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Wed, 18 Feb 2026 16:14:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:14:10 +0000
Date: Wed, 18 Feb 2026 16:14:05 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/iavf: fix txq flags setting after Tx path selection
Message-ID: <aZXlTVOWSitCgQN0@bricha3-mobl1.ger.corp.intel.com>
References: <20260210095045.1901921-1-ciara.loftus@intel.com>
 <20260216102253.2801021-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260216102253.2801021-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0304.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f294e7-bf6b-427d-f15e-08de6f08bfa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8IfAsHwp0GE6ORKgnJzPjWAAtol/f2OIY4z5dQL6DAuempEtbxuHd15mqRhx?=
 =?us-ascii?Q?jpeRkheRxBX/w4nL/ClBQNaJBRNz82CQuFJXlxnpsuHwb3m+rIeLbUt7aqAE?=
 =?us-ascii?Q?H/9aMylcOI7ghJcFgqktp1FXYH1SwOSSr029CQs/QVqK0XFezpbgzNhu0rpn?=
 =?us-ascii?Q?5Oe2DqpG9Pxw19QsMIjBmyrGyKwMWhst8/NWMIX78x+qI5DjqzKI63U0uVW2?=
 =?us-ascii?Q?/cdnrfJB6PaQDZimBJFmEdEc1y2Y9luHNBv9rb9mcw0L5h/79NJ6ZLsXDpye?=
 =?us-ascii?Q?RU6WVVFeip6BTc03yHBuQ/TyX3v8Px0OTYqaWLluViOor4G5nhZuCHcdGbK9?=
 =?us-ascii?Q?UvcPit7+oNyCKQaP/VYnH6OU5tFTHTK+SrGboA2pOgK06jl3k5sshcSR3fIB?=
 =?us-ascii?Q?qGw8hz2NdnSEGk6daDRK6s/+xQxdVtKw+hzlSFS1PYV7Kc8IOJ4S9EwLKH9Z?=
 =?us-ascii?Q?/+nnAIgFtjGf4eqoJwv6FmvBGuv5qnXQ554Vw8iZOXRzQYgRGzuTTB2pBI8x?=
 =?us-ascii?Q?OTyMx1zdbZ7J3eIek+caeEXagxY1wjz3Da1pHFZCX1xEXpmYhRB9t9Eh4ffF?=
 =?us-ascii?Q?ifkhKKwJlInHWxrvVP648nv7AvoR8zgzHhXklK+bO/rMS5gdEQr2pCSslVUB?=
 =?us-ascii?Q?FWcTbsfPVZj7Bs0mJ+KCSRA7FkCiU30jeCXJdHjBZt5GzjN/37vyyjpc5R5r?=
 =?us-ascii?Q?3uPLSslW+T8EUrKm3bG2QesDWhKeKRjzopdJM66AP5WIor08vs2AySzhzsbx?=
 =?us-ascii?Q?mf0xLm2xUN9c4SeVVJHYpnOLrNXvGv0kqr0ISeffUGFSsbm0poHDQMLfg6Pl?=
 =?us-ascii?Q?uNQhgKy0epXdvsjGWX5oTa9dN9+mMxWkvgvUZjogJH3vmaeiVpwX9Ps+InVb?=
 =?us-ascii?Q?NTFe/EPOT7eh2RSsn/gwunRKMOKfD2CqgpLBbd1T6T2tgYomDnQ9q5XeJZnp?=
 =?us-ascii?Q?ga5nrQ8RFWnlQmht4CV639dHRhHHTIGC+UBHIWavfESgwY3WW8yqzSINTWhz?=
 =?us-ascii?Q?fLzxVIo1gkytG5Jw/10H5yHFK0v57GncPhIfx/k1GxaYOq9DDjxCz+ZXLEbn?=
 =?us-ascii?Q?3RLK6fjWXePx4r/d8nearSOxxG9Y/uWw/3q2FxEeSS8RJ+f2Fr/oNa2swyiR?=
 =?us-ascii?Q?HFy/5UDVGeRLLnUaitsLT8lDXJV6xR5dljminEqBd3NP/UPvV3AkQNd+cYOp?=
 =?us-ascii?Q?gJA40nEqlAwh5y+qjZu+A8hF+wLANjxHANrLJBEkg/CM0Y6HzcMwQ0VpfGDE?=
 =?us-ascii?Q?eeBCwPORWoSL1jKZioleGYbeEdqacqH+GrzX3ODsdZHk9ne6Tu73rqmJDgT2?=
 =?us-ascii?Q?r925eAXDQ+n/Fpu6v50nAnNcaGD3M9jlwmwtJnfOObU69RXRdBtYFs5M1il2?=
 =?us-ascii?Q?zhZYF6MLzFCvjy2Y0M3G7LtoJ84duKJjHPqMzxosEWUlHCRQQxLDdWryKP4s?=
 =?us-ascii?Q?SgNBMmmsNADkP/kz5ZJeBbcPMByzSaSY/vzEpPx/G0aZ+Oi6snln+VCn+PsS?=
 =?us-ascii?Q?o6Bd2HrqQ6fcWAOX1mMB8cktFI9jjk3JNRJurG2MVBGYZG7oknDdLLiUYcH3?=
 =?us-ascii?Q?jZwYfpFSIrJR8W0liaw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FS82JB8AVNfqcHkBVG0+AhvqamS7fK4ju3/kxSxNeHBOP2P4qBoK86e5kErZ?=
 =?us-ascii?Q?qlDmErmv66C1jTti/9kgpF+1pmHSmWWSO8iAneqkj4lKx7WWedTNDN3U2vDo?=
 =?us-ascii?Q?klatPj3o3hkY/kiiDzbt5FdE/Cl8WQ5PAFAvh5GLEoERIhVsDDCFnwP8krS/?=
 =?us-ascii?Q?tj1//xEhNfoOzikz/933/qtjc2lIB4ld/DomdQ8tPM2vkZOGEHF/qKkRailG?=
 =?us-ascii?Q?5A2HFPanGkcHkYPSnssSVxbIzGruOIq5SS7s2RsVHlvbNCSHowVrm926Phb3?=
 =?us-ascii?Q?6VyBbMddzHGmitHPcwn7L1Ije+o3se7QdD3vUj4VwBRm/5oJM3Kog7vHIidx?=
 =?us-ascii?Q?FGhO90HCmKbIz8BxcWbuuNQOzqJ3qpHNvohcvqR3l4OqCvUt7crLNA/569l8?=
 =?us-ascii?Q?BLrst5e9Vda25mVUSVpRv6b147QZq3SIQYD7KgqnbFsZ4PQ7aCvA91gqkTGx?=
 =?us-ascii?Q?t3ndJGGRlTgSPKBKlCKxSxlg6AZYl/Mc0/9AfIpBuR9EcG/6O0hMv4W2idZg?=
 =?us-ascii?Q?C5ZEYLN14XOvDE6565SUy//kq0LRCFhIV3JOA/zwZ04/NZIOD7Zfl5Kf1UKS?=
 =?us-ascii?Q?pZjGSr74W+MnsdklpO97btGJqp3I899iNJT9FoPLDk5gaImVdTQxoefh0yjQ?=
 =?us-ascii?Q?k07issNwP5i9qEU4xSx3WPUNgEvsYYR9a5HMNNVjrgqKPM+9oMZqjkwzJSs9?=
 =?us-ascii?Q?0mbF2e8upQ2wmBd5qYxkOUsW814rpq09hs8S+5vhDO28pQNs1yLiHz+wKr2S?=
 =?us-ascii?Q?6DFXde4ndSukEkbGMd15fhFuV2jSwntaMiX6n4chOQeIPKDMugGxLak4lcRe?=
 =?us-ascii?Q?FdAcHsh6OO9bmCfH+mAOySFt1TeSrHAZ9yCPw5s0maIsVCfd5LCn7aF8RScF?=
 =?us-ascii?Q?E9Rdy3IsYa+yod62bmYOIaRGUHzDG6AY8yaJNyk2KPYciiwxxB90pc2ExwMf?=
 =?us-ascii?Q?vKVSlt0tZddzlnfShizPdsqoM6fLTS1J8Nqrq+3wm6wo/DnYwAUdRN/s/6dF?=
 =?us-ascii?Q?rvK8zzsLjFW1YGW5LEggRWjR66inKt0e/JfwVJTM4SSJV5Ba+CMsKzNgiFsI?=
 =?us-ascii?Q?rDhEqk7DtqGq/1KAUci2T729yT75MebJ66+ivgKWnoL0Q4KGg7KpBwmYHWRb?=
 =?us-ascii?Q?6cuw3Br/hKWPWZItezM91n8hmjBhZLpbnZida8nlRWY1PCiIl22qmUJUbibh?=
 =?us-ascii?Q?jSnbv5pqKj7Kri5wHgbh4uhqBFwIKbpcKBl5xNxQ74ZD05Mhq4SC7kGcTrf/?=
 =?us-ascii?Q?U8FwDZRYK0GqcPlqWwOx1AxypNriGr24xjv7m8dCqZYcxzSAq//zlJ/qJUNx?=
 =?us-ascii?Q?efvwwYuN7yCsmHGYVPWxJ5huEqrJGCKQ05tviZOJC0QSTsh87TarJoQIaLty?=
 =?us-ascii?Q?khUTqUwfA41cMzIxCmeSu9FjaQYoTACO1WfBSUQPa4KIEsZX3VlkYmEh7xs2?=
 =?us-ascii?Q?5UyRHgwE8hDz1ZpYl/b9j7vQzS4tDOYfTjz6vIGpIRusDjeYTcJgB5ScX8rI?=
 =?us-ascii?Q?UP/4/NMlAgWqtKzns2yEd2aFocnSMhvt/eR0/I+x6NBiGE2n1+bq6S8Q7cWQ?=
 =?us-ascii?Q?a5GhCBQxWASndD5jchmAu+AiH2wx6q7uxYOWTsnyxKKO3YTWAqAIZr2fxlDp?=
 =?us-ascii?Q?O9GFB3/ydQ1xxf3+vdj0C8EsKvMvw7Ylkb0ZyROYnwVjjHebahPzF7hCt3Wc?=
 =?us-ascii?Q?nCyhvd3djyUxb615GElqQPiJpvDoG+Ch25O2JxwUfYge+wUUwtEcGz2vMQo3?=
 =?us-ascii?Q?WFqkSN8nTcpVso4c2qKZk0WMxV3R2Pg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f294e7-bf6b-427d-f15e-08de6f08bfa8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:14:10.0273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOjw1rFBmmMU1wvkgvzP10oiw5/jbpZ0BLYRVI2dzYadjq5V2kri5fvdrow+zv7dln+zqfLedDaSzBOfhM45JweR+TuoSVINb9oJvhg3eDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
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

On Mon, Feb 16, 2026 at 10:22:53AM +0000, Ciara Loftus wrote:
> Ensure the txq flags "use_ctx" and "use_vec_entry" are set/unset
> properly after tx path selection. Prior to this commit these flags were
> only configured if a vector path was chosen. Fix this by making their
> configuration unconditional. Also simplify how the "use_vec_entry" flag
> is set by removing the dedicated function that sets the flag in favour
> of just setting it inline.
> 
> Fixes: ebcfb039afa8 ("net/iavf: use common Tx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2:
> * Get a pointer to the selected tx path features and use it instead of
>  directly referencing it twice in a row.
> * Use >= SIMD_128 instead of != 0 to determine if a selected path is
>  vector (future proofing).
> ---
Applied to dpdk-next-net-intel,

Thanks,
/Bruce
