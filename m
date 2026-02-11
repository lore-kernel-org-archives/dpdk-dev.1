Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA07EB271F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 10:38:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82168402B5;
	Wed, 11 Feb 2026 11:38:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4C8184026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 11:38:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770806307; x=1802342307;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=u5VGNwWg6/iHQNIvIPRGYDEntnVzIgAFO0YKNSIcc18=;
 b=an5faRiuJuTHQrYq2D8sIsRyXURJcrADaDvbkUCAeWjjQyyoy8h3S/JH
 mmJ6VaSx29cdf8M5fBWNuqmDZoluHc/2ghPttJT6dIqhQJkqb6UFFf9ip
 hIddUZrxYCgBo4VjE+0Pe+/DurKCDpTXUGyRoN3W1KppEmuT2blhfxLG5
 /Lsey/uo488SIIQ7+0rn9Eku6T185qdhUMZAzw/VDw9aSj6n1pUf97Rop
 ApT7CgM9/wCKgKUYipe7O0D9OZ/Hi3l1S7KCV0gnBXrQo9MobLwMJMm0D
 bG/Dbp4NCX3a9aKd6Jh57qpMeTefDXkPi2vHVzKEy+b9s/22YcUWp2yEK Q==;
X-CSE-ConnectionGUID: o+ULCQfLTe6d9SgYSdoWxg==
X-CSE-MsgGUID: yDb+ovGaTuCw8+w+R3P1cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71849669"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71849669"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 02:38:26 -0800
X-CSE-ConnectionGUID: SX6/dqoGShGoNExNvcJKTQ==
X-CSE-MsgGUID: Jk4HjkcjQcep96NpEFHBBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216500801"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 02:38:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 02:38:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 02:38:25 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 02:38:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sD3ZcFuBTD4A/C4qietpjcfBbq/NtqtmQ1Z+ArdwnYsWp7wNNkE6L5dC0ZDHC92dMmqGVSwCJgBCf6pN3QKkdM2rA0SNj185ehqF8I4fGSUiV6siIf2MLc34lMGQF/4fCxFMCblrSiTNA3ycoA/1ejG3rjbecdhgUBzvFauhVwgNc2IB4Mk+D3nu3ptBOfKSK8klZSBPyqybbmJslBW7TVWL1NCq2d+QsyrpxzPllhXYsNRaeQkgaHmXKY2Vv9176sWLHhHLIVdnn2RXd3xfyBG6aZPufb9VSNeR5QAGaJhKmUMWf46BOJ7WgV9rZetJe76vhecV+8zBlDB6UfepEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7ZoTb9LY3+oPRbE6f74RZ5OOPFBlZixqIaohH07hEM=;
 b=g/RpImRTnieaoGRniTtsIGYiteNhAlP0oyNi5rNQVhqXKEvQP/Swt+tyCRcZqXveGDCUNsX6UDGTFedCnGy/1RSeZrQfeboQ8j59jnthNk41Px/2YQjQGNH7R3+XVMWdFUZRJU3ZsX+Lfh5hrsGKtNK9safIY2QAokG/FgXXGn3XCvM/gPXTFU9pb7xjO+eSxQJXgvU+dGZMsuItRXg6WUOkG9yObKtDcGKGFio73k4lZosAH5jFGGvfBzaygW/0XqKGwpkJBBAy19aP1wMjjPKv0NKIdEKdXPoln0arvBPf9gn4Ozcd2nDj7mguphSmLljbF7LIml6SjKzNpYBzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 10:38:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 10:38:23 +0000
Date: Wed, 11 Feb 2026 10:38:18 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 06/35] net/ice: refactor context descriptor handling
Message-ID: <aYxcGq5M8pLKfi-M@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-7-bruce.richardson@intel.com>
 <f3a53f53-e636-4660-81a8-5ae3b3fabf0f@intel.com>
 <aYtthv1wbK7xHdm5@bricha3-mobl1.ger.corp.intel.com>
 <5740f4a3-5bbe-46ef-acc7-6ddaa6092f14@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5740f4a3-5bbe-46ef-acc7-6ddaa6092f14@intel.com>
X-ClientProxiedBy: DUZPR01CA0162.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 01476a19-8390-4500-12c6-08de6959ae71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fgYSj2vH1iQAoGsKk4iPYNdjlfJOyMcmW0hyeeuwNEx4hrYB/WuDDAKLfFwT?=
 =?us-ascii?Q?HBHfGkpVJpHOWMxpivqqK3Y3reoaxR4CkCt1P/T5Alr8m6S2jAIZvePgpcim?=
 =?us-ascii?Q?TzsrvmeEbUsb8SHLfsSDmqc2dA2C70Mk+16zRoZDd0ZI2ZwWrC6kDV+/k8FN?=
 =?us-ascii?Q?E/lY5I3MxCnGWU9sQhIEbTF85DWEJd69APH0sfD/VtftJcf3+y3V1QnDDoG5?=
 =?us-ascii?Q?ot5oMFCYnTSWgtN3A77Ci6hxkutaTIXolBfoxXjNvlouUTk6NXlj+QdwkhVr?=
 =?us-ascii?Q?JjQVoto6lLS9XhXf0+W2ChFSK6PLerAiRxcSbgWv2LNOmb2DkNhBamwt0HbB?=
 =?us-ascii?Q?ZTeKfIssc8azx/s+bQCB8ieTNY4znnQO4ESPN5/3lCyc1oErwfJ3H1vX209s?=
 =?us-ascii?Q?L8nIrlt37kyRlWquF69GCPrFtZF0cQGAybteQksDfgbrpojcLSwFk5qwa2+z?=
 =?us-ascii?Q?OkubUec5W0ylKafmRUsAuKZf/uOYCsfqYRWN3WTbPI0l78C8fuyEKFgV+rtG?=
 =?us-ascii?Q?GEI0qwCtYbW9R72uR5NPE+GaATn0xkIQ2xkohIbDSh9bhpb97vqVLFg9Thjb?=
 =?us-ascii?Q?asPdkFe7RJ3EjuW9KrfOq8mNDbwbBpDlZ9zJX+iSzE6v5X38HRwI5c0ekA8b?=
 =?us-ascii?Q?XSFiYof8NYq4V+wAoAtLLbmkgxMvTOsSesz/hKDXkGxoOgeG+QEgUChf0rxB?=
 =?us-ascii?Q?sPZd55XVw3bYH65+YcFMJeO+bQLR0WyT2zjk8ds/CUyQdIg30tFehCtYWV1E?=
 =?us-ascii?Q?DXyoE/kXZQo+eBtaYmjYmW+BEPg0iKE8Iteipcwrkc6Pa+ytgtBWk0r0y67a?=
 =?us-ascii?Q?Kdq8AB0y7wBGXYxVKOyYYwNQZbmhXAWqXk/l+B2WSId6aZt5raBfel2xn+YQ?=
 =?us-ascii?Q?1w0CQV78S0u4Sgvt53ZZCa4RxvI8xMelfoklwLQ8sxtZ0WojxiKlTKv/raus?=
 =?us-ascii?Q?wmYQiuhZB6d6HAmQYm/Hy9Xr3XKLYfQN92hLxkYf7hfSCFT/q3f2MBvbY9dY?=
 =?us-ascii?Q?wukqJZSfRJ2VtSSawm63DrjpwKv+4O0+2oawFsC06aqhcJ7+xDbB47JpS0W8?=
 =?us-ascii?Q?mMcZrj7H++GNUEXvEnhgObyl/5E6GxynV5a0DSY6KUvzEqF0gIhuoxMLXM9a?=
 =?us-ascii?Q?+/n5cfmmC+gG1VCFueiHnjgV1lndGRgpNMt1zggLY1ne68MiXn6oTKA9Ojxl?=
 =?us-ascii?Q?XWVA6ClA18aWRQH1q3+E2a1KPmCgv837/MiKeeWvTI6cUPza3VsrwEalzFia?=
 =?us-ascii?Q?ZC19AxeACnq+xSuvuGYLSrDcduxDJW7/L/n4OQ0vJqhmNrtE8o+ygJBNoblB?=
 =?us-ascii?Q?yrRpo4LmxJnQWt+ROdaypIHHLKf7p6PsvBe4c4nw+0plG6swTtP0DWLwT4my?=
 =?us-ascii?Q?j6Dh9sh1wpyfAGzdR23hxfi7wk9DzzpAnCwayZAmFZekaMRnFtLTZbgbKlXr?=
 =?us-ascii?Q?lKC5syTphNlIQOWIB1s9mTwQj4tgubwCMIuGPInyNc3iu0WfcZErmag3wmvs?=
 =?us-ascii?Q?k/00Bfz3lPhOoVf5LDThMtWEzdm26IX4MpGsdPpGohW6BOxUgCh0wmVNVtkf?=
 =?us-ascii?Q?nXGJWHHXlknr8SU9uVk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqc50WbG/Z3cMFFRei7lvE2rTCuBZSb7liMs5B3ZMfcwzNxKdwOHtpaUl3UJ?=
 =?us-ascii?Q?AdcOMeNMJvv+9nAWlBMqsokmozIBx9iwhU0R6sGLqHAqdVahEJ4Rh/WGOlC2?=
 =?us-ascii?Q?o0MptsmU/Yas58k7KoC9vlbKGneMNBrR6vW1XP/+cQZAMVptq1KjXeaypiTj?=
 =?us-ascii?Q?vQeQmG/3adjATGbbf5UDYXyo33LBq61Y9/CDHQQcatztuNj6PLdE0GTTtCza?=
 =?us-ascii?Q?C2sANI+xnqT7vqPWt0bbhB8hQciblAGkgwTZW6QAQgwD0QOWRBcckemk5d67?=
 =?us-ascii?Q?QRR0Gl28vA6QxOZ6CfFfWgxJpWFweNVNu6TH+oMrwXUaMPujWhSGPLDsroUT?=
 =?us-ascii?Q?jvJemHdiryD9rKRY1tRSjnqKQ9aFU6izveDG5g6dW4bGNOAHA+yP2UnHSyQA?=
 =?us-ascii?Q?FVfIwpas9GXb/p5FEExERi8l7zB8nsUqdqNR+mxBtc5lu8XUfXCyVVOvUr+b?=
 =?us-ascii?Q?1bhevTVTsO8OkWA4eqc3xcLHIxBFk2c/V1LYabW75Nsvwq9M0JpMC8D3eNPT?=
 =?us-ascii?Q?3O7DBeccaa4rZ5KPyk00t5pLH6aaQyzMLs5oYVyJVndj8dp9/sHOR+/1shNl?=
 =?us-ascii?Q?jbpSNGwjsNGRfwxoLkme+SVPT3o+ArPJs21E4Dv5B1+x7kz/7U5K37I6ZoJs?=
 =?us-ascii?Q?AUM7zAeASHlkDdFy+YOp6iPxVenXdNklLkPoTKiwQ4XA6iaJChFQanqyg/aM?=
 =?us-ascii?Q?xN2JaWwkj+Yqqd4h8N/y1eoz4uqoKsRZW+W7vJGoCyXfYt67LjohAIC5003c?=
 =?us-ascii?Q?Zcr4s0WxFQtXv2JSnweeGJ7wblVmewVIzaZYbu6utCI2/BAUcb9LLCtkzw2e?=
 =?us-ascii?Q?jkCDZ4mgoJ6XEccCuWETQg9v1Pa0W8tNi/xwLJsDMj1pKLYrDGtNKxQ3vTXN?=
 =?us-ascii?Q?v1mjcZQo6N8FWREzSRUvqkUWZTEHY/4MYDIJvk4wYon3xfsYW09/OH0wIR0u?=
 =?us-ascii?Q?3lwUOgACUq1YmF1AKbDR3wfz8WJR4y2zQwqO0fVVz3AqcNm67Ga8l82kIOtd?=
 =?us-ascii?Q?SxjVlANHH845n/wmlPa7uFBL78GFbf0M39+5qvQwGnZfXdiV8Q1/8IJcLNUR?=
 =?us-ascii?Q?0SskNrvsib6rmeRz8mGwvZBbTgOU+T9aecvodeouGDSkLW+WGTjgydK9DcAp?=
 =?us-ascii?Q?Ds88wVsxL/Azrm+ByWplkQfY6Rh03Hg6nBUzjEGNsHikIKapN7VTAnh+9lDi?=
 =?us-ascii?Q?pS+JjY+kzPTF3H/uYoP8wRYtkZvf/eYk96ZuUhC+dn3OMoMxr3MxMQysAy8V?=
 =?us-ascii?Q?u3EoQw9hYSLqyW4KB/1/9VYmtqH307wjCL+Rv5Jzxmnl24dVoPxPEpL530kx?=
 =?us-ascii?Q?Bk7dPW0jA5u8Go8U7mVJWMXSAFSLRsxJ5ePB+tdGLOQUmmr1hSjE0mgSSAfg?=
 =?us-ascii?Q?NvXx9jZnoB/NoKwrA4kVxGm2Qux+Fzvsg8C5+i/ZeqFZ9G4Zm1gzx/+cp5ET?=
 =?us-ascii?Q?RfiMpPMNz8GnD/zeJLA1KjefqWqvkyqwvLb6dYLhrmufjMylmZsW0863XkTF?=
 =?us-ascii?Q?j5kU910rMSnFZwapGhdNygbSmNml6G3aJI/3wgeSLolO7SXF69lhiUR8YGuE?=
 =?us-ascii?Q?6P3CdcymV0HbqYV2WVbdt3HLgQD66IjvKdcp7B7R4Yz9FuyFj/OJthlWmPQ6?=
 =?us-ascii?Q?TnT5oJX19ofKTBz2pCP/xBgMVN9ZhAfkpQ4TBq3/FidEHJNuTp9cY9NUeurJ?=
 =?us-ascii?Q?2IwOeNJ/lBcT0SOO9gM9AlFu52QnEQnjN4fFliJNKxg/LvW322RbRt0VOnIT?=
 =?us-ascii?Q?XvO8YU7lIlWvClV8N3mlqcs4pOGmNGg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01476a19-8390-4500-12c6-08de6959ae71
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 10:38:23.4073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+fL1kiwBmjh3MploZfYe0AKLod2eThSvlp3Fb3Hb/tJpobOP+fWhcH/e1ceLDLsAJu6MUMYJ3IGACe1T0YUy+6+EiKVTPubYBMNE1vYFT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
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

On Wed, Feb 11, 2026 at 10:17:34AM +0100, Burakov, Anatoly wrote:
> On 2/10/2026 6:40 PM, Bruce Richardson wrote:
> > On Tue, Feb 10, 2026 at 01:42:17PM +0100, Burakov, Anatoly wrote:
> > > On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > > > Create a single function to manage all context descriptor handling,
> > > > which returns either 0 or 1 depending on whether a descriptor is needed
> > > > or not, as well as returning directly the descriptor contents if
> > > > relevant.
> > > > 
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > > 
> > > <snip>
> > > 
> > > > +static __rte_always_inline uint16_t
> > > > +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> > > > +	const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
> > > > +	uint64_t *qw0, uint64_t *qw1)
> > > > +{
> > > > +	uint16_t cd_l2tag2 = 0;
> > > > +	uint64_t cd_type_cmd_tso_mss = ICE_TX_DESC_DTYPE_CTX;
> > > > +	uint32_t cd_tunneling_params = 0;
> > > > +	uint64_t ptp_tx_index = txq->ice_vsi->adapter->ptp_tx_index;
> > > > +
> > > > +	if (ice_calc_context_desc(ol_flags) == 0)
> > > > +		return 0;
> > > > +
> > > > +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> > > > +		ice_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
> > > > +
> > > > +	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> > > > +		cd_type_cmd_tso_mss |= ice_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
> > > > +	else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
> > > > +		cd_type_cmd_tso_mss |=
> > > > +			((uint64_t)CI_TX_CTX_DESC_TSYN << CI_TXD_QW1_CMD_S) |
> > > > +			((ptp_tx_index << ICE_TXD_CTX_QW1_TSYN_S) & ICE_TXD_CTX_QW1_TSYN_M);
> > > 
> > > It's tangentially related to this commit but it caught my attention that TSO
> > > and timestamping are mutually exclusive here. They *are* mutually exclusive
> > > as far as the driver is concerned so that part is fine, but I couldn't find
> > > any signs of us enforcing this limitation anywhere in our configuration
> > > path, so a well behaved application could theoretically arrive at this
> > > combination of mbuf flags without breaking anything.
> > > 
> > > (if I understand things correctly, this applies to both ice and i40e)
> > > 
> > Yes, you are correct here. However, I'm not sure if we can or should
> > enforce this, as it is completely possible to have a queue where some
> > packets are sent with TSO and others are sent with the timesync flag on
> > them. There is no way for the actual Tx function to flag a bad packet.
> > Best we can possibly do is add a check to the pre-Tx packet prepare
> > function. WDYT?
> > 
> > /Bruce
> 
> Now that I think of it, I believe these features do not make logical sense
> together anyway (TSO means segmented packets while timestamping means you
> have one packet you timestamp) so perhaps this can be considered user error?
> I mean we could add a check if it doesn't hurt performance, but maybe this
> isn't a problem we need to solve.
> 
I wouldn't put a datapath check for this. Maybe one in tx_prepare just, but
even then I'm not sure of the cost/benefit.

/Bruce
