Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D36EF8FE4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49DDF4029D;
	Thu,  5 Mar 2026 18:30:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C61E540287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772731820; x=1804267820;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+zNjQO6Ved4MmR4RYXIccOxDw18KDwdRnrtrkMaVYGI=;
 b=FR90Nonvtdt+gtDY9nJ5mUjp7lwc6JPw2P45VBAnba63lr0GLRNO7bcS
 My2Darvq6t7k3vUTN8dIH9HwBP5uMntgP44Kl8OKrljqxq40bSu6fESaN
 pQ/NxDHUWULMMs6Bk1d9s71DUb+o6uQEbT5tRA2EF9OvJIZoLXx7gihXw
 Y8ISanzkZFObpKDzyos9uX45u86TeZ0mH4j0550NoENtkhvCMU2Rpi+oe
 kbgiZIPARlPJZ7cq7D6L1yW9LW90OZPolRgy5EEciPFuOxWgx73VpOEEU
 /sOpQck9xmnCk9CMFD+6MauXn6fHjcrdMYsoeGGEy/bDfhHZpShITlm9W Q==;
X-CSE-ConnectionGUID: JP4zdFnlT2+5NEzsx0BlnQ==
X-CSE-MsgGUID: ANabyT8xSNe9brNvU3Mn3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73876737"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="73876737"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 09:30:18 -0800
X-CSE-ConnectionGUID: juDo9QgaSGGitxbUQKTOTA==
X-CSE-MsgGUID: tEHc0kx1QtiZRi1T8BTQ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="223234335"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 09:30:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 09:30:18 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 09:30:18 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 09:30:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3ptOCt8stb/WdOyXRCdUP15PnVVc/hQE61QlRtpx1OjLkJR4sxnWYnJe9oFvkqS4VV8Z0qkTpj1LQH5CAukgVZzYYiFj8CIMC3cKr7W+/cQAKix+C+UMUi4Vx19jEszQYn90SLkCRAbQOFWyo5afrdweFgwiWvUoIVrMbjtP/dk1mtRzIinM4y7QrSfrCkrPDxIRE9ZvTvArWDm9n858YNADzCzoLGrMdaQYU3GsC2NSimbZPRCw+h24DH62OaMXmnMUwSIn8OtvidzAulos35KDmL9y3Qrtqq8u+yucFV3t66PXiu4CU5pZaX43acqjVpD0ll6UMX9WVaOUeBAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj21T1Y8KdgSjOKTxOulKA1/bZjCow6zuZYIhWVJUCw=;
 b=wavcB7W1s0LvkIH8juHIP+nRKHRpr1fUKDpm/3NQw1LWHB0OvZ/bYmOoT53WsBY0ElPgfZ6mo6rbikxQA5iOWaN1QJwWBJIG6Ou0WojiBMeFIQr6RPSg7rmnxlLOVZ6HmmoR9Uuuoa9jRNu4g6V/N2wxNAcN/9ijjf00bpVrR8szQ9j6iIlGSm8fLAYrgiwvgbe7twxeBbeKSEVJ/F17rPEarbpkUpkwMOmr0T3Aw1zpXsh7ep+g4S+dTbwmU3Nxf4YgJ+QYjM9B2XvpI2Bu/4GvAnrr2QOA/8Ig+xrZr1aqbe0+mplQ98PhzEccIu5gmJcoH8/TT6huEPN5YXTkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9374.namprd11.prod.outlook.com (2603:10b6:208:581::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 17:30:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 17:30:15 +0000
Date: Thu, 5 Mar 2026 17:30:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>
Subject: Re: [RFC v3 6/7] bus: factorize device selection
Message-ID: <aam9oV1lwwhiQj7H@bricha3-mobl1.ger.corp.intel.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260305164550.2067453-1-david.marchand@redhat.com>
 <20260305164550.2067453-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260305164550.2067453-7-david.marchand@redhat.com>
X-ClientProxiedBy: DB9PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9374:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e0db62-3399-4403-cc25-08de7adcdd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: QbKb176RcTZ0yh0MJWPgOygoslfe3O/ZAz+XQl8B8fPW+AhR7kXfEL48yQ2mkKLm4jr1CkuXl+I6RY6PxVkmZ/z7JeAOO1qZiHAOA575F4bTxbzJ3fvXPVrofK1VHl2RfWH60k+xIdxbpsMPbXZiys0TTn9bRCJ8xILTGEgr7nrhxzqb/BJn75CdItR1Qi1ABjJwfJCDkqWOyAlh+WxYoDcw7xdD+O1UkptLAAN4N181hYySj7VD5LUBC9jN0XwY4EzkUVoD4JJsWDA6+sAnA9Rag+NCF2y3nqnsa9ShkUN6Ty585g7Na13wOmqVCM+SN45huX/jh/pEgIZl7ByLFiklrHF6zXAFbibKTHErbkzyFvM0n0ZOECHEmnlcBriRZKzJjP7mbAnusuDHCxdX7gQUFH3n93ebQ5dgVaLdIte6UEj3vZwRDWW4H7bvZFvFysghcG0ePWwrnaF7nH0QkFmRZASVBorx3m9NO06D1idhpL9L0T8P8XSPhBR4zrXC+jGdQP7xqKhAwT7P5wWpwYc5vn+o3t9DFIgV52O22e9n0hxnPK6kgf4XVFzeb4DKg9EKXWGCElgTTGNjKsO8YWN4FQF+fh+BbSVDLj0Pqu4rcmRf3va48zCluYzCZbcHjhOoQ1XE/7a98fTkVqZWohEjxMK0zJC8efqQthPG826RZjAkINURVU2J7gkW2E8erL19llPyS7sarSls4m0VpnqQnoABSR9odTpUWIjFmdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ju/af7X4jpEU1B3VhyYizPurx/u176LWJ6tHEtHsOzUoLRaxkGkgzE0rWG3?=
 =?us-ascii?Q?CtRuNJEtSwl0Y9bax7Ng0XgrTkbpjMVpyTuFFhK78e0g8Bx9M4VatmgL8djb?=
 =?us-ascii?Q?b0yfPWCRuyNrhDTtvjgg4c38TI8Uo8Q4dLkwIZqZ/WBlhsoUkdCdkrzYgIP7?=
 =?us-ascii?Q?iT7gzacat1N8PEYTNePakGBjLU8OTzCv3Voy4s6FCbbXLtgeLdHPWyYyPYIl?=
 =?us-ascii?Q?5wEervRd57ti2F3xN1nBkZGXnpysqr5fWwu2wlwQc4U135BZM17oyIUWuInW?=
 =?us-ascii?Q?ejOdT5GZi3UCTEZkliIONHgXHMP1nZsBA4EBSezbcY+zJEb8ZBfGeeymvsSU?=
 =?us-ascii?Q?j91SlVBIiXL7o2s1QfDOEbUBUodxLavgSrRrosOvQ3Mu6YwW/JvcDMMSwVGz?=
 =?us-ascii?Q?UD4tktvaTuX+yjrndknGFu2r8tQkv77FlFLxRNsmRWuRVKj/zuXRcGXInQd3?=
 =?us-ascii?Q?nth9iPagOEf+0+C2RGWQJcunALAuEl3QbI8NJFrDByjzQJetQ/CpFQt/TBBF?=
 =?us-ascii?Q?DkvrQ6uvFSgje34Bb9LyNPYoW//5s8e9RyNNY2co2LV3l8xJ34n3zVsOH8GA?=
 =?us-ascii?Q?ylRjYGBw+UYE4nS4GH5JpSiK7Pw0hQk5AeY9GbHTL3wSaGY69lXHEAmUrpTG?=
 =?us-ascii?Q?IsMByIK5ojlJWEwyF6aoYBdCKseNKUHCyjDWFEauxkKsoyjNMb8cRmrrpPSL?=
 =?us-ascii?Q?EwAXe/mYRp/xGDcJ04dsFxLYeWH1tDmjar9YNQMr/52ZFVAI7S3D9m3NPryT?=
 =?us-ascii?Q?BRSpXTUf/9dSygpeCq7CMslNTlCKSM+zW5z2PL6Lv99N68IfD2pB3VRKxmCB?=
 =?us-ascii?Q?2S0WPq6zOduXSVo07vg7Yz25UOeL5xAlkJpOo+I8e7KqwppBh37ti8nFsKz5?=
 =?us-ascii?Q?ecXZwQ4+wfy+PW37De/Lsfwuq6WiX+DLT4+e/bO0DAUYjZcvv6/Ffi22MEVa?=
 =?us-ascii?Q?NfJO2o7/kZA0SmFza0aqCLBZ7u1vLf+hPH4BMNoD310wvGFN0GLS/yqBxUJD?=
 =?us-ascii?Q?qu/6Cdle+jJ9wiyNgbPrvCgCep6mfT5lMxmXlSVfikC1xkUbJ9R607AD/DKB?=
 =?us-ascii?Q?FXzV0sJ57DXbSRnpATlLEtO0F+HBfoVzhN867C9WT8AlBRQZTML5P9cuscL/?=
 =?us-ascii?Q?mJ9bEwFfEhLrLnwt0U7lJToY/atN3HPIXq4mOXiUkq5CKlqsAoWv7HyDqeou?=
 =?us-ascii?Q?EXi7SRox0JHojj72W+zkOkXeXCi9vY6WwXf18Y2in3zudCNs7vbuwVR/eUM5?=
 =?us-ascii?Q?XfdxE3VVT1hghfbFeKeIskwHqMfvz/zmXu8aRi362DwGJ5wNx1d7ZY9IeoZv?=
 =?us-ascii?Q?dykpScM3K/4Knj9q2t0dmfMcfjJrhZ2nv1/U3heKfsjgew1OHQAYbHPKA3iA?=
 =?us-ascii?Q?65kYCQJuQiRgCR+ahDIrL6jXhgvFsjStEOWllUtfQYxj9ySc2KwSiVf7PzCF?=
 =?us-ascii?Q?tQ9AP0h1DapxHRe0RG0CanpmhnQGH7kQR9VScbuwpjNdUPN6OlaxuLbqU6q2?=
 =?us-ascii?Q?6xG79iGK+Y0bV2dGMDUlplbvtNeqsaeKCoZnC2PPrQ3C8B424DuKJAkJczIv?=
 =?us-ascii?Q?DNh8Omxs6cUlWSuLRwhuseinMVQmXY5913Aeibuf2yzhx+EfSPqMlMOZDSgT?=
 =?us-ascii?Q?cwzBxnyNVeFJsyvqsRZhJILPXKJGWgxI0QzapYpVQ2OwS805SqdHCdb8WHe6?=
 =?us-ascii?Q?yOfs7b5i4orfa6h+IllA3xUdhKOyI6fh4qP6C8WpfOuUc96kk93meIHTKzu9?=
 =?us-ascii?Q?iC2nOeD5KdhKE4gZajTQOH1n0Rnj0ek=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e0db62-3399-4403-cc25-08de7adcdd02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:30:15.4411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUOJSMfZ/1W1bI/68n97wPjwgxD+uFbdbjjZFD1A63tFODy+4mAM9EC7FTcqDRLdhGXuuRqiLh5YoWE0QQLcszK8g1BMEgCJq65/0bmdngA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9374
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

On Thu, Mar 05, 2026 at 05:45:48PM +0100, David Marchand wrote:
> All buses (thankfully) implement the same logic when it comes to
> selecting the devices to probe based on -a/-b options.
> As we want to adjust how devices are selected, provide a common helper
> in EAL and use it in the buses.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I was going to suggest that we avoid having a per-bus scan mode, but then I
realised after looking that the final patch in this series that that won't
work for vdev bus which can't use auto-probing.

> Changes since RFC v2:
> - changed API to query about a device name and hide the devargs meaning
>   in the common code,
>
<snip> 
