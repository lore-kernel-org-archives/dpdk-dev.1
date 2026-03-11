Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2B71125856
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:59:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B285E40A76;
	Wed, 11 Mar 2026 17:59:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 762D84060A
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773248339; x=1804784339;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/ZdY32alJiWlJUfVTc1tsPYkysfcA25YzzNMAMnAC4I=;
 b=fM5ZiPwYRD1QgGchaF1D0qNZ8y99zqAGRJWWlsWQMhM3CJ4BdhR9jwce
 U8w/sRxp6ZcsAXAGBBD8+k5vKkpqSYX7v00Owf6+Agm9jw/4jO1+RgCYD
 mnzzgVGFdz9cTIfvnG+9O58lE0L+0VuOS+X/n6oxAq4y1VI0MbZvgo1CN
 wf5NyvmJ4ZsaKocsa+WneMx3dURxu1YY2L7ptOQZ5jzcES1JTVPCYpA3z
 y2T8TF+Ww6CnL8KCEoiizbuaWxNDDRwdcXXVBFiReKxSgUaT3/Mzd9pF/
 1fqH/q9gFLpuaf4/YY7w4yEUn6g0sZ6nieQZbHAcT1Wry4E7sZgeD6p+u A==;
X-CSE-ConnectionGUID: HALAGYxwQ7ecVbzMZ+12/A==
X-CSE-MsgGUID: qTjjRVLiS2aNVOrwUdBJ7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85677453"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="85677453"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 09:58:58 -0700
X-CSE-ConnectionGUID: mWq9pxpdTs6MJOb4iE+C3Q==
X-CSE-MsgGUID: arRvO+HgRZeXIEdVz6Qn0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="219781003"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 09:58:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 09:58:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 09:58:56 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 09:58:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arSFXy/ZFxz4/DaVGQKg1P3VepUODFnHjrebLK2zmccecbCrGLf3CfkDaHG6zL2Obp9Fc3cmphbK0UL3S0XTPv8F8LxFzzyHMb/m28YD1hCQ5f8MI8ms7BqVQkeon8IZMjlo5dsY/DT3G1GHDGLwvs5zNubMOJfLiK5MtGWRJhtx1cQ4lbL99TWrCS/zrRcLTjBSPGmhxZXZcjwCOBBKOjq82sP67sfSfAD7ox5LzQRKCgNlZ3R23JeMLuesMzKFHieClSxhLX2hih39nWNTcuQFB5LmzbSaGvgBVfMd5TqT87sPt5HgSjbzz+ScvAvS1tLayZKKPSlx3RAlor72bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmqHaSRsCWFWz6sKRzO1Zd3kTsftFTxk6fVZTUewAdY=;
 b=ldFhzZl1C9aOjDK0EfFL+HIAxpy2U/10RDtxpciSz7w89c5kRJRmXl3Qg/cJ2j88OgGP7GUlAuvwK0f3HENp/Oxd5LHV7qhSBtcu+jeezeW8iajfTMyU8pLmALZGghOONxvdzw0DDU4ImztAgGfgVd9nOHHhs5as0yr+bmxDB7A7uWp9ODCgaTSEjFGFFj0e8Ybapk3aIhMxvd0mMgAGyL8Ws+FlViemuFJtbP6h3LO9ElCAEa5S2Qinp9AHItj3rbB3luQzH6oDLsW3qs74yNRySZ1Psf2qKWuWzt1ln3xORr8OLNhso3exCLH5WyxnSkZ3yUz0NV1/JWPdF4W/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF7708D4D9D.namprd11.prod.outlook.com (2603:10b6:518:1::d31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 16:58:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:58:54 +0000
Date: Wed, 11 Mar 2026 16:58:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Liangxing Wang <wangliangxing@hygon.cn>,
 Thiyagarajan P <Thiyagarajan.P@amd.com>, Bala Murali Krishna
 <Bala.MuraliKrishna@amd.com>
Subject: Re: [PATCH v7] eal/x86: optimize memcpy of small sizes
Message-ID: <abGfSARwKc4TV_dU@bricha3-mobl1.ger.corp.intel.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260220110824.235784-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220110824.235784-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF7708D4D9D:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dddf4a8-d09e-4a53-4718-08de7f8f7a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gpazQnNc2IZBJ1whc/kylbQERxMGWxawy0IGOSSQTfUzSYcggFYHAWELbvKrlKUT5LOo8b9rYgFAcH+ehqlegrgEB04GQ+liFpeLbJ+QlwuFHdMm67Umq6hwlfdORi70+bb8P0u/fZ+SY2Ndq2ou/khRGkhOOTXmnVMEBvY5WBKG6LEoqBahD60QvKb34tMaJSmT1/JdldxJZmOSEBUvj1mGaIucXWz3Yd14JYBSu5AYTWO/Wf7HkQ8ty1+i6x/znWdbNA335JDc2xntj15K5OUo0vL9/1NcpxPbV5JYfngzpogt0pk+e+gk7GbDTnqPVh89frNDg0hYCXgxIexZo8I8MxULkzAqpch9rs/rHHUo5YN4pEIL7wudABXHq411Cnc1iPjlh+jZEggMaRY5mXSmxiLWT9nnJs5JjQqYFchASL0mKKaJ4dW/GBqKqVzGgnIqpoyvbhonxhrXQ+GI6+pY9T0p4Yo91Dy2gtprAR1yzp1VxuJz8qsp52Ccc2wUPph8yCYoUDthdieUfI5EkEgs9pUCcg0eI6wBTL2STXmTgvo9hnf1Z1jz0La+t0mg7nYPMd/vo2J5s6I+K9aJ5CqomAKngvvTkut+AR9G7gIJ4Wlaag7+Yb8SKOg2E6TleGtc53r3j3Mzoaw55/zL6yawDMUgiP1Q9gykNsflqfGw1JhP3c0D279URA3Yu689Gu6rzqRWUXLRUQcZTQkL41s8ejXZVJvOH0gicUFblfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LbkZENkRSFfXpmFFmc3BWwfJ3qQz+XAQoqgO5Qx5VAtcrU6mkEIe6T1piq?=
 =?iso-8859-1?Q?AruL4T2aR6Kg8l0eBZVHiVj4e5tIDLV0RIHDiS73mSuUwW30rSrdGiwMRQ?=
 =?iso-8859-1?Q?ILlhvbVkpSeAaGzTbA5s4ezTIALIZ0a3O+iO5CgEagllZKP2tPpAUpm1Vo?=
 =?iso-8859-1?Q?WjmYTNYf/BG1jjYNMGrotHcH9YDBYmCjFFMvf6x8n8IlulA/8BvszSgCEL?=
 =?iso-8859-1?Q?Ac+rHdvKDVEKllHtstaA49Uo4+PwgfkQ4FVrb5d7yaoYcdGGmdShX6qklW?=
 =?iso-8859-1?Q?k8Lvx2maxlh4o6IZvlAXvrkNsJh2cwDzsWxlxMU4E7Yu/9tLFJvibH1cLg?=
 =?iso-8859-1?Q?uJQJIG0uOTaDUJ6xh1o8H0F3jpW6IYUuewPF4pydMqP+7Hb2WYbbJ9vj0y?=
 =?iso-8859-1?Q?lSKIpF5nkmEkcnJrxyvRd0gLADg2uxFvSRuURNF8uGmYxtxL/ULELvWMvm?=
 =?iso-8859-1?Q?El4hubeDdslBDvVfvUzro0tcJw7pm2E3jc+a1vFT8lmDkZ6M0l+i+/UptL?=
 =?iso-8859-1?Q?Tf3LjGV8rSVlFwDONoFGedyPN9z7vhitX191qyYusSV7WkBSXL7aDRhPWj?=
 =?iso-8859-1?Q?h6OUPG18OniFxDIT7LCXxv1h4N9UgoygNbCT2/GKIyNFWAl95HYWELfR/i?=
 =?iso-8859-1?Q?ia3gz+I+OQsEPfwjCRtJNDDKYD0tDu5150DwHHakDuuKOrlc6midvecoTg?=
 =?iso-8859-1?Q?YCOZRxaXwZdEfVHZnwpkTOyuhvxqBX1kOZ11rHsQIaedkOXOD09zSOPTkX?=
 =?iso-8859-1?Q?NsoS3pJ2VR6P8USljO3BmOfl24XE8bPSSAtgPG7YN79UTCZ54+mr6CxysG?=
 =?iso-8859-1?Q?iq6xsRUJ84Xn4rzvGJLK4e5HCBXOcDdmyp263x2NaFkrn7FxBPYqgYkcoV?=
 =?iso-8859-1?Q?r8vm1/eW2lpl9rDooDTEnQgdMcz22omvKg4NQ9redrBJF6R/ZlUN9t8XQ3?=
 =?iso-8859-1?Q?CY+k3Sg+rhvHct4LLIzLDWS/5QpJ+KXKlmuhyZVe38ciJuqX7NLHhjkjXH?=
 =?iso-8859-1?Q?AhBhbstxCE/uWoXG6zufvAIHIiWqPZb6jPi7Ty9znx+skv4EbcjSeJRrzx?=
 =?iso-8859-1?Q?F0oCtorLPL4AAUsVJalq7Qw1WCcMJguLjbzt3jthH5l38+aPJW3tZ+Gr01?=
 =?iso-8859-1?Q?46zNXjDeXjHHbJIB1KIzXhYoAhz9Wgj1Wy/REA02UivwDl9uCWU9dWQ65n?=
 =?iso-8859-1?Q?eWHbjAs8fcj5tftXYA7miwoPyEDgs62uNFg2t7Mdc02xfy+eTnlEB/ffwB?=
 =?iso-8859-1?Q?GcVOaH0NIhxuDgAMO8GtdZJTYW+n/6ReqK814HJ0RplsCzl3FexyUDHd/l?=
 =?iso-8859-1?Q?frTQXGxZJrOC/XJEDCGfUkg/NYOg2DIud1Qpa1nP0/kLWZAosyktViRUvA?=
 =?iso-8859-1?Q?ysQs3s1xb52gMmF1UwMsPv/N/0Wo7gfzMb1MvfD3/H3FGk81+W427DPbL0?=
 =?iso-8859-1?Q?pFxRT+ybhXOmRDQoC0C3g7m1+7dVCaJQYpHTD4nTMpILljA7YAJaImZGVy?=
 =?iso-8859-1?Q?OWjNS8HnYxMuy/wduk8z4ft07u7A4taNOeHzDDIXJuZ+FPtJ8TRAKHwFLg?=
 =?iso-8859-1?Q?1qdJ/Bh58EIYUh0m7Cc16A5RGHhRObdkwFLz+xsvCo37ECS4ku8eDp22Ik?=
 =?iso-8859-1?Q?ENLcxeRwaI+O8szLEPSkq6wuFZZyspNvFHfpXExUAcVdUisw8CoCDvUGMu?=
 =?iso-8859-1?Q?ad4Ekhto8mMrhrSsPs6yzm9WF94ISPZM7godwj4xKhhpYkMNMuVc4MY7/O?=
 =?iso-8859-1?Q?JHOd1Rcyc7rL1tMyIE8LJFiZeyLY9Qs2VjwMxHeLPNUcJs3CRcuqYFk5mc?=
 =?iso-8859-1?Q?1KV8XUAWjrabtojWlyt+aHCNW7FhauE=3D?=
X-Exchange-RoutingPolicyChecked: wEy0+LDRN53yU1HDZ4xvHe9dQ8bevvDaQPGiabLCcSlgxHIRlRz6nq/l4clpA+D+tGEN4diR1yVJ1Pmfq6QuQHjt303ILczkNKt3yXOZPE1Fj3DxIz9lV3Z9tFenQI/rR6ryjylLWaokBQ3uKMawuQOzEm0gDjDCCYLyS6prXp8J0lMhohHVGXV4nihtoRyRb2wSmb8bTuq2j3jB/pBLnB7/kjI8epM/VGuS/9LBLA81yPRXNJ7kw/Aml1Uf143Wxx2KS/W0NZMmKBdJphf3Htb+oDOsQ3O4GEdx5Z5j4pUYOls1BO8/2eowcEmorZokiQKvnq8B2itW8q12KciZEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dddf4a8-d09e-4a53-4718-08de7f8f7a08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:58:53.9612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s90Rz7oB8NaE6y1zAIgLVOnKPLbWnM5vr5WXm/x2IVNYBKjkxB4r1S/2gR04dNj6U6NROjDt6MHllMMl7UEir04fbiWyCqDtjqpQ7e8VuHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7708D4D9D
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

On Fri, Feb 20, 2026 at 11:08:24AM +0000, Morten Brørup wrote:
> The implementation for copying up to 64 bytes does not depend on address
> alignment with the size of the CPU's vector registers. Nonetheless, the
> exact same code for copying up to 64 bytes was present in both the aligned
> copy function and all the CPU vector register size specific variants of
> the unaligned copy functions.
> With this patch, the implementation for copying up to 64 bytes was
> consolidated into one instance, located in the common copy function,
> before checking alignment requirements.
> This provides three benefits:
> 1. No copy-paste in the source code.
> 2. A performance gain for copying up to 64 bytes, because the
> address alignment check is avoided in this case.
> 3. Reduced instruction memory footprint, because the compiler only
> generates one instance of the function for copying up to 64 bytes, instead
> of two instances (one in the unaligned copy function, and one in the
> aligned copy function).
> 
> Furthermore, the function for copying less than 16 bytes was replaced with
> a smarter implementation using fewer branches and potentially fewer
> load/store operations.
> This function was also extended to handle copying of up to 16 bytes,
> instead of up to 15 bytes.
> This small extension reduces the code path, and thus improves the
> performance, for copying two pointers on 64-bit architectures and four
> pointers on 32-bit architectures.
> 
> Also, __rte_restrict was added to source and destination addresses.
> 
> And finally, the missing implementation of rte_mov48() was added.
> 
> Regarding performance, the memcpy performance test showed cache-to-cache
> copying of up to 32 bytes now takes 2 cycles, versus ca. 6.5 cycles before
> this patch.
> Copying 64 bytes now takes 4 cycles, versus 7 cycles before.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> v7:
> * Updated patch description. Mainly to clarify that the changes related to
>   copying up to 64 bytes simply replaces multiple instances of copy-pasted
>   code with one common instance.
> * Fixed copy of build time known 16 bytes in rte_mov17_to_32(). (Vipin)
> * Rebased.
> v6:
> * Went back to using rte_uintN_alias structures for copying instead of
>   using memcpy(). They were there for a reason.
>   (Inspired by the discussion about optimizing the checksum function.)
> * Removed note about copying uninitialized data.
> * Added __rte_restrict to source and destination addresses.
>   Updated function descriptions from "should" to "must" not overlap.
> * Changed rte_mov48() AVX implementation to copy 32+16 bytes instead of
>   copying 32 + 32 overlapping bytes. (Konstantin)
> * Ignoring "-Wstringop-overflow" is not needed, so it was removed.
> v5:
> * Reverted v4: Replace SSE2 _mm_loadu_si128() with SSE3 _mm_lddqu_si128().
>   It was slower.
> * Improved some comments. (Konstantin Ananyev)
> * Moved the size range 17..32 inside the size <= 64 branch, so when
>   building for SSE, the generated code can start copying the first
>   16 bytes before comparing if the size is greater than 32 or not.
> * Just require RTE_MEMCPY_AVX for using rte_mov32() in rte_mov33_to_64().
> v4:
> * Replace SSE2 _mm_loadu_si128() with SSE3 _mm_lddqu_si128().
> v3:
> * Fixed typo in comment.
> v2:
> * Updated patch title to reflect that the performance is improved.
> * Use the design pattern of two overlapping stores for small copies too.
> * Expanded first branch from size < 16 to size <= 16.
> * Handle more build time constant copy sizes.
> ---
>  lib/eal/x86/include/rte_memcpy.h | 526 ++++++++++++++++++++-----------
>  1 file changed, 348 insertions(+), 178 deletions(-)
> 

I'm a little unhappy to see the amount of memcpy code growing rather than
shrinking, but since it improves performance I'm ok with it. We should keep
it under constant review though.

> diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
> index 46d34b8081..ed8e5f8dc4 100644
> --- a/lib/eal/x86/include/rte_memcpy.h
> +++ b/lib/eal/x86/include/rte_memcpy.h
> @@ -22,11 +22,6 @@
>  extern "C" {
>  #endif
>  
> -#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wstringop-overflow"
> -#endif
> -
>  /*
>   * GCC older than version 11 doesn't compile AVX properly, so use SSE instead.
>   * There are no problems with AVX2.
> @@ -40,9 +35,6 @@ extern "C" {
>  /**
>   * Copy bytes from one location to another. The locations must not overlap.
>   *
> - * @note This is implemented as a macro, so it's address should not be taken
> - * and care is needed as parameter expressions may be evaluated multiple times.
> - *

I'd be wary about completely removing this comment, as we may well want to
go back to a macro in the future, e.g. if we decide to remove the custom
rte_memcpy altogether. Therefore, rather than removing the comment, can we
tweak it to say "This may be implemented as a macro..."


Acked-by: Bruce Richardson <bruce.richardson@intel.com>

PS: If we want a little further cleanup, I'd consider removing the
RTE_MEMCPY_AVX macro and replacing it with a straight check for __AVX2__.
CPUs with AVX2 was introduced in 2013, and checking Claude and Wikipedia
says that AMD parts started having it in 2015, meaning that there were only
a few generations of CPUs >10 years ago which had AVX but not AVX2. [There
were later CPUs e.g. lower-end parts, which didn't have AVX2, but they
didn't have AVX1 either, so SSE is the only choice there]
Not a big cleanup if we did remove it, but sometimes every little helps!
