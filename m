Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDCC02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 11:59:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33CDB42798;
	Fri,  7 Feb 2025 12:59:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 410D340DFD
 for <dev@dpdk.org>; Fri,  7 Feb 2025 12:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738929547; x=1770465547;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tZkybl0rXp5wT9Mc/p4O7FVyjFRzs2bXqRmMpkxr7Ss=;
 b=bUERB0jrCssRck2ShtnK4uS0NiXYXJFLwUie1Np6AdtbRwyxSrJVwDEM
 +bQaIc61IiTLjjX5wP2BWBCb640UJddf7/dISOf2PhxAGJhYlsE3ToVHR
 Gl8ezQOc27MhI/oY0yZRp0iJBaX7IHVFVXPjSTo6YyqOgtMrDPre6cyDm
 mtry3aY9XWp8S70nICXzvVPKs6EbJXx14Vvc8xprx81oZsoDKV68aemAu
 7IeJAsSCQYBgeBTan5E9PJB/tZj4+IxxhLPUIDYmm0rAKAljmcU5KgLBo
 D4UuR4UXza+hOwR5BXaLCrRwN+xTWstjn2YIQfgkebks3FDKk+6HKXGB2 A==;
X-CSE-ConnectionGUID: OQs6BHleSfePQRx0O2ajQQ==
X-CSE-MsgGUID: kraiw6YmSomFcjEnXq2IGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51001019"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="51001019"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 03:59:06 -0800
X-CSE-ConnectionGUID: SHBTAlKYSHC9wEw2+bMi5g==
X-CSE-MsgGUID: Mzuj45HIQ/mN2TEeSe3uEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116120667"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 03:59:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 03:59:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 03:59:04 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 03:59:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjad7hj6FQScZI/c7l/8NQ1aMqxwd6EIQ3dNVJbWORcrCRBN8gMNIdFTyFsy5j9I7ruw1VoD5CHMVVI1mVyZ2JE5m7Hjd7jiqUw0VJ/VcMINNGHwC3N/KdP/7hRIGGkfUiGjp0dT1f0Lpm2z9MMcJh62f7kL9dZePJif//ImFJHg97h2m3yoqMOCW+M7SuV6G9dm9UnylMFjD8DYwvsyni3EMkmhB22JQXaaBKSwUSDKiTA40Kt+iibJKKJN0eOJWPDvrxfgg7UVDimM4kgFaS79wbJWYo0j26MLsZ/3I6SQ3QeI4Q+z3HYMfk6CxRplt20qGyaQ2QzHlLYDtmL8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX1iQYmh86OATg5/KPyTu/Nn12wYo9YHXYNxkZ1/ku8=;
 b=CNVqUQrOApFVWlq00wDzbimW/v+GEcwt7PlotkJTUQptDpLp7hdEBUnDEjSnd9uvgj3Ygj/sTzCB+Mno4DRttj5E76M/n/Rk7rPJhOVfeUtMCWSKYUS+QtNKC5VRjUdOjwJ08Vp8PHdbn7RKS2iKYiJJeMBGWRjY4ahL+ipbkISknWPdyeKinhHmWPeRhOgEw8zjWBALuxiBETJ3hJU+uMx2YpgPII+My7qSK8DwtzKf4exQwacr785mmQXyGFR2Bjltw+MUqV2dFk3vOYXg4pUVmL43hnF/64OAbQTPAgfUgE4/XZooDse6Kgm58FsAzEouPBaBtyu2HT+Xj5i+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH7PR11MB6332.namprd11.prod.outlook.com (2603:10b6:510:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 11:59:02 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 11:59:02 +0000
Date: Fri, 7 Feb 2025 11:58:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 1/2] common/idpf: enable AVX2 for single queue Rx
Message-ID: <Z6X1gbYqGp-tc2fl@bricha3-mobl1.ger.corp.intel.com>
References: <20250203052430.1243485-2-shaiq.wani@intel.com>
 <20250203075508.1304702-1-shaiq.wani@intel.com>
 <20250203075508.1304702-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250203075508.1304702-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZP191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::8) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH7PR11MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b03831-e09a-4368-d4e7-08dd476ed066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O7Dl4fOrEnaoJhcmZAB0QbCu+4KpKZEEbijjidg5W6nAjJuyB8KBSEwWj8X5?=
 =?us-ascii?Q?m4f8NyYz3fqfD9ZwhIPLgSGkLh5IM6xySstX7GUmLbq1ZZkSqhHRe1QU9Ahx?=
 =?us-ascii?Q?w7WoHALLWbbaUD6TzrXzVLzj/M39VLrzbjZ2bXT+B1q2YsGZ+IbYPY+0wWvi?=
 =?us-ascii?Q?UNvZv4JHvwZceRMJYy2qlA64ecUZd00ms9tYM4B+KXiAb8fJ1ouBOZnPvaw/?=
 =?us-ascii?Q?yQz22SNo6HOQNU2CMuZb6OmLlXRS3vP0YOfETnozNmkVI4/jkuoLacWc4z9c?=
 =?us-ascii?Q?3fNHtZZe0m3Xhc9Xd4pC62LTlMJJDl9LqNVWS8jkaNzNcBbR9lTSv1Ljzxu/?=
 =?us-ascii?Q?ZMhv4mTgpzIsI3tx7ph/ULOA/cX3b1uicZVaLWhsQ16QThgWlddAl68eUcPw?=
 =?us-ascii?Q?MyUTF61TF9Pnho5Sf2v+txPfRfVF79glOOm3njIFe3FNozIJFFarYBuIyUom?=
 =?us-ascii?Q?+2S7ZBXjk8x31qmixgbEGu5atIYMTiUbz+ZXuXJv2gme7njUacrHdBPtELV7?=
 =?us-ascii?Q?HJ8p4EicU9vmS/AtXM0nBDryePWsg+Iqzd8h44PV40wx7uukXUpslt0Sagyp?=
 =?us-ascii?Q?HXLCeoM/vCBsS6eBjzcft/00/WrNKEgs2m5RfBZx7oIiyX7WW8vPqUYhF7fc?=
 =?us-ascii?Q?VH/vB1QcKxko300FoAVkNnQxhaacHFpYqOnzhDuOf23BFA5U9rq3Yk1nZKjS?=
 =?us-ascii?Q?BzWtL+bB9X2/9M0JpqFMwBshbSqqO6Gv4fZQexZj14OZWBXKpATOJesiUtRm?=
 =?us-ascii?Q?Kr/anXF2CsbxU+yKFO/dGF9O1f+hR/Pw9ptSowfga734IrDBwvDnQYs6JCX7?=
 =?us-ascii?Q?vITgWUrt4OIS7SQgCC2FUH3u4AIEkehOx/JPe3h0qiza72AcB36eb2u5fgO3?=
 =?us-ascii?Q?cse4yiB4bgwyAj51LHSX5YBiHsBI88BrOlVRpgjed40rm/b/VdTSHi3DdwWG?=
 =?us-ascii?Q?Y0dT0tk8XP8+fDQOkKIkC1XGAVcx9hqTOsMHfoBRLsvcgArUEvJmsv8oSmr0?=
 =?us-ascii?Q?TvjNeA/iOdtOjamjO/s7mMWwIH2BEPRjqQyjTzz7DMdvzwkZ4/fdT8qRJezf?=
 =?us-ascii?Q?/3h8rnlQSHDfPMbyBKMCmEJ0pSRYtBibVgbUP8jQX2crhDfjv/4VJ/L90SFF?=
 =?us-ascii?Q?f3RGVJ78sENUOEQmTmrkPOzjgZokZUYWikaaynP4yx8oP6puYawnzz2gqoAQ?=
 =?us-ascii?Q?6+xBz7PrqnNBTVLsmV0KLzosCvBaUZV2+hkuwzlwI67MJNuq8je6uhBf+Qti?=
 =?us-ascii?Q?6cBaePNdMZH8M/n7QbrjO+lhXPgpCnCyZVRer7V7YcViRbWFa4bRNXgF7XI+?=
 =?us-ascii?Q?YoTjk6TNVA0aAWtZzInZCOHlTD3/NZan8sRf/2tMZ0lLFG8y9esdpSJeBvr1?=
 =?us-ascii?Q?CWmsMa1bfxKtNuvEYDHc/C8v24LH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?581MmYNULUDNmxC3RurfSdt7fpDfUv4GEcoWmdidu5Vn9FhI8S78knNtElb4?=
 =?us-ascii?Q?3/FELv27/JpCFRsREKmWJFgmIB2vUEBcXoLQKvDmnJW/zJDAnljGy3cVU4JM?=
 =?us-ascii?Q?JrP37eUjbTltrmJ3KLQoiDw4mg3XirA93zEHO0xHMirx63Ka1twF4E908IYG?=
 =?us-ascii?Q?VvgeYJ2MxqyCaC9os4Le6QbqjraLhf9gKJe1FbT2PKBnepqTd1CdJeS640g6?=
 =?us-ascii?Q?D3kOco+XWk+wVMZ15I6gJ5YBiX1GE4cUur+xNLIoHwuCe0yuQ1CXldEK3bbb?=
 =?us-ascii?Q?GpVVvS3oIDrOahLiDwvV+Lysq1K4XZ87xvV1xnys+J4Rf2MCy/hpQcLPloJq?=
 =?us-ascii?Q?C5MqOX8f8bgOGjJk3HetbQpv4Ypa/bFXdhh8VHSzO/iiLl2r+izlG5VSD4ay?=
 =?us-ascii?Q?B/2TlKdrPoht86xG6YM2HU36HIKJdBXQ5VxKD4uFpwwVObw+Hoqd1oiwsBg0?=
 =?us-ascii?Q?J/F3ZgOLWrYWgni4EkrEpH3yP4WWlfEnmrLdXU2+DhpTK1YRt+dZfXsNM7kz?=
 =?us-ascii?Q?MyXQGKd/5ecO+75w4+OtpWcPONTp9TTVffs/Nl60CFiuie+obJ5zivhC86kZ?=
 =?us-ascii?Q?o7ifLpJaV8dIMy4liSGtnVQ/T8bSC2BcRfYmrzVv2RABFPJ7Sf1FBLzQqyAN?=
 =?us-ascii?Q?cW6YcNeDQwxq2UE+F48EDzhu5JweHniaDSLSUlyb4hJANjGfopChRevVcRME?=
 =?us-ascii?Q?44fjFhQmh8Xs/OEuQpnVcf0fZQvcMQUIbUNKDWFWnFEcMABskACaBf4JqLdc?=
 =?us-ascii?Q?DqG+zPEGI2JXbBzi5P3UZU2zzeoTEXIS/D0Pimxu56vMdQgz6/z0UkWjrJNa?=
 =?us-ascii?Q?mpDa77Lv2hqxCVBZQblXMyMOXFLjsIDPGwLyy4uxAv5pofgeMs7FkA3U87Ye?=
 =?us-ascii?Q?oQIxb6Rpz1w3NdKIzJOrD+H8mIuNb+zv/CVnmi963VjeRB4JiapTO0bSsoUz?=
 =?us-ascii?Q?CCTzqflunN80BcLZpVtR3xyMLKaY0sMFn5qV1nrs6x7Bzk5dQvXO8/Z/XNEb?=
 =?us-ascii?Q?10AjE4o/Koyl/GrXKTWn4Kit4izRMgDCQ5wIqKbPWz2+azHvhCmqo58Gtrj/?=
 =?us-ascii?Q?eY5FDMam5HqBvUh25XQJ9DaSeBLJyEzJQvMat1nTOAA+U4ru0BR2MpcMUMjj?=
 =?us-ascii?Q?1aOjNJlSsIunhCTFGJgytTCEiNtoiwGrAs6cARJRWQSUJqNeEPDEQjXEnjMw?=
 =?us-ascii?Q?lw58ZngKwPrnYKNj7O7xdJyA4yZFPGiwDJJm7xfianUVUs6flHzN1+Yqxvy0?=
 =?us-ascii?Q?VnEBCLbfrvME8Uvnb0rZmaCWlMXVohOK3IiJmW5alPlLYlzXQABZaDC8guDP?=
 =?us-ascii?Q?jaXKkFJzJkYp8uoPxaJ0ffWHxmxGer9rKvrB/kDFv3nSpGtRGIqzQX9TK+Ua?=
 =?us-ascii?Q?4GB/tnZE9jeLYxUCUjq/Ow/aO9WcB+OetltzSV3LjQdaWv15vQy9NSP/hUmw?=
 =?us-ascii?Q?voBXI+3a8fVaFc752EwQwAFskLe352y6od6wO17+0R7xc3kLawzMhE7RgWCV?=
 =?us-ascii?Q?qwFvkZjRGtais80wrTcvf+jJsCd1dY1bwqNK99YeYMmP8L0FUgH9+kpF9pMV?=
 =?us-ascii?Q?+3o4LlIMezC61WIScGVC7D0nIuLgBkYcvNIieU/YaYDg0ozJu9c9FutJHWyH?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b03831-e09a-4368-d4e7-08dd476ed066
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:59:02.6237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZFOniEXMwfXtBg5wubqtmSqM0FL9oXS6fPke+QES4Iu5t7t+g9fdmV8eV06NUUWWHh2FcULSfLD8I4S9Ktky/MPOmKg/Ed0aS0xgz78f5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
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

On Mon, Feb 03, 2025 at 01:25:07PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> The single queue model processes all packets in order while
> the split queue model separates packet data and metadata into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/common/idpf/idpf_common_device.h    |   1 +
>  drivers/common/idpf/idpf_common_rxtx.h      |   4 +
>  drivers/common/idpf/idpf_common_rxtx_avx2.c | 480 ++++++++++++++++++++
>  drivers/common/idpf/meson.build             |   7 +
>  drivers/common/idpf/version.map             |   1 +
>  drivers/net/intel/idpf/idpf_rxtx.c          |  11 +
>  6 files changed, 504 insertions(+)
>  create mode 100644 drivers/common/idpf/idpf_common_rxtx_avx2.c
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
