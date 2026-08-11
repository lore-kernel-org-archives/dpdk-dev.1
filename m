Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A42C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 14:02:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2198406B8;
	Tue, 11 Aug 2026 16:02:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 037994027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 16:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786456954; x=1817992954;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lJx38Agt4KrdXxo2/3WhhZ/opWmHAj+ZWmMbbyzh+x0=;
 b=RQLyhOEIlXXKytRj4O+qV4ah203WU1XWn/K7MWNjREp283uEnB9773Ed
 s+5DCVUMUJ9K7TBqk7eEQYDNzc13bnuZsA6Ss8tTUfhiqi7lfgjL7M2ta
 dSdC6SmdvMt4dF9+FgU8stkBvEylW8VHnC9sSHaq02MdyUz7CN18CNbqy
 68QCWLcucv1AvJ138P4joFMfdqyvjIfMrAIPJueIqlOn+TvGxLLEAQiLN
 uRNnn55lx3oBrcfzCpDE9A3O5mIOWdThA4dM+XNHoZAVe90QFfXmTkxc/
 TaYnUQgQRU1KvvLM/RHGaxvfSF8/flz2ia4JcllrQDmIb/QxWc99oA4ua w==;
X-CSE-ConnectionGUID: /qjEk04+SF2VLAU9ZKS28w==
X-CSE-MsgGUID: 9EayzczNS+mExJq/FZg87A==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90801087"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="90801087"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 07:02:32 -0700
X-CSE-ConnectionGUID: g9OZEjXZTOqpooZ8n1MF4w==
X-CSE-MsgGUID: Lf9KZK8KSAOSvkahONlL8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="257135175"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 07:02:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 07:02:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 07:02:32 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 07:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svM6ksI06ZaE8x75K0vXtnfSk/JJCls+n8FJOcT89l6vtGbo/Mt+m8SnyxOu08NnkrTCAiYCoKZIPHWFy6WXXwTwasLzCqk4DHA5wzkgVAVUfN2JGW4daJaXHafCi0F+zFQ6b/xmWojdA8jp9ED5GBZGIsQod9yZqg5kXjXETREz8R5Z5hIhCKtpkTpXBhac2SwpMuezErXq1O1IUccJUBjsP3HEnMxOlwtdNEebJe43cF79cVHq0nvC3BMovBexb6zek1n95f66AJkvzl1scs0mhamqGt4posjsmNtg8Khe1k3Aj+XBYzSgyARjuH7KFeVCJLKHXlSdVe9Evpffrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b57mwb99rAfJ4hg7u8u4ZJc8LSEIXbsH2VAF/A0Ps5c=;
 b=PEysjhcKFNL/9ptmmp8XmhINNT0eMRABOKgH9cmtMH3r+avCsBixQ+GiESllbqdPDJJaJC6fhMIWDRCR5THYEShPDMNwKIRdaRL2iHQh1BOL1jKZZxzR/vaOSHZqZWAXuxvz8CKlxsc/c5mT3LgJP0K0ghlOyiHLdmRD/CMTdT2sARhXo2B8HM9REMXPAg7r70obV6UYm8PN9t9mP8FCxhypZFQCaRkPDdpqNU9dLPdu00+Lqjlc4JxFHqqlylLWTU4yWz0MgNkpiGPiD7qP3DkoAnbw7vXub+iN2B6RwuwDRl0BFQQBM2VmLncBKodc6UUtlaChr832KR2njQ5MKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Tue, 11 Aug 2026 14:02:23 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 14:02:22 +0000
Message-ID: <7a291c7c-5c45-4bf7-95d9-3894711d181a@intel.com>
Date: Tue, 11 Aug 2026 15:02:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] crypto: add RSA-specific capability parameters
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, <dev@dpdk.org>
CC: <anoobj@marvell.com>, <gakhil@marvell.com>, <gmuthukrishn@marvell.com>,
 <fanzhang.oss@gmail.com>
References: <20260731091146.602320-1-ssarananaga@marvell.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260731091146.602320-1-ssarananaga@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::9) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|PH0PR11MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abc1d37-5f4e-43c5-bdfc-08def7b12a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|3023799007|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Pky/pHkK2fcNTxjucJrwQGHA6RSV0WwJ7NLrid+oYmmbierg12vsEc39Tyryx1qrvjOeuW3GheBF75jxcSRrU2DwXgC+SciFxvpOkMqTxpT5A0CKEXJhGFF/zIh4VWFUxCOIoiTW4DLR2Bie4UyOpjC5C8iNEOBV6d0Ld/UElkZ13DxOglu2LEBGS+g/aVx0b8HL537BQqUwrCnOrtjWbldxiQlYqNeExft/lSBXulmyqCfkk7RcuaUWc0zYOxVu/rtgEmEVo5y+RQL5ea+NYOj812vfTwFBCNS/4rGcUE6scRATS+kVnjG8u82xRFq0fl4x3WU2eBJDFZFDzneVAACqMR32i5OLe1xIW/sWBnum4LxkAXQJgLbjNXtWqtDRmeLWPTEF1acIobRQKiI5KemceWJb5Z56Idionqtg1XrLBorM/TFPPJn+WGWiwON+Tk2nNzqi5/H46hsWgS2l0E8xitTRlvxMu4bvuB2C8CJ2u76nr77OW+hgOmX3BSxdw4hsBfN31Jq5K30f+WGnYAIKEzA+sg7//rIGPnX3/GYSLr91KpW0gq1R4sv3Cq5mvfhFXZu61RaifPUgpqcrgE2Fg8QHqsP0Z9FUcxvp0px7NywBtVHR4b1I8O4X+UZASwAOEELr1tGL4kdVMk8XwP0OMuRTp7mZLCHdo31BFeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpQbnovYjdrMTUrU0FmSHY0UkxwQXNoaVBKZTlhTStHNFV0UVJxTlpWVHRL?=
 =?utf-8?B?WmxlSGxrNWpHQ2FBbWVVMFdwNm1DdzJBSlRESzVDVlFJd2dObnNGQW5hb3dC?=
 =?utf-8?B?a0cxNHZJeFU1MzBocmN4dzV5blYwQ2pJWFE5YW1PZWNNS0FRUExHV053TmRK?=
 =?utf-8?B?N2N2S2J1MkpJdTg4ZDgrYUw2U3EreFIxY1VRaUUrRmZ1WG9XNHpCM081STFy?=
 =?utf-8?B?SmRraFdGTVRXRGFBT1ZPR1c3RXJUMkpML0Y4OEQ5bnFYS0RuRk1Ib1FaK0FZ?=
 =?utf-8?B?K3Q3bFE5VXpoMmJwbllNbTFlanVob0pLdHBrbEI5cGdXTnVwcDR5NzhVTGg2?=
 =?utf-8?B?VktxRWxJTjRVZ1IwQ3NKWWdCbkxVd3JjWGhTVy9pNG9YeURTRlVSNVc4OFpM?=
 =?utf-8?B?WVpXTlBmZ3I3SCsrZVFlZGhTeU0zSkRFWjFUWW9LZ3dEbjdBM0lGeHdxQ0JF?=
 =?utf-8?B?T1RSL0FpYUVBZDZ5K1Jya0ExWTViQjJLTXpnbFgrNms2a0h2UytSYW5ZN3pt?=
 =?utf-8?B?OTE2MFh4cWo5K280UXcxazhsYlBkRXVwVHI3eTg3RElLc2crQW5QbFlNRVVt?=
 =?utf-8?B?eCtPRlYyblgzNmpIeTBXUFFwbnlRU0pBWkZHREdGVFgybFZUNzdMaTdZVTQ1?=
 =?utf-8?B?TFRhUExqZE1TVXBNeDc1QmtqZi9CWmJxUzloTVl0S1hOWjkrSldPMyt3aGhR?=
 =?utf-8?B?MEh1MXVDWU45cHpoVXIyRzYyQVFIUklGVmFWSjduL01SdmZ3QkFud0VVeXhl?=
 =?utf-8?B?Z1FrNWthMmdyYStRS0t4LzZzcytwbnRqeTJrZ0VHT3NrM2VBdFM3R2ptZGpu?=
 =?utf-8?B?c0J0T0p3Ylg0b0RyejJQTDBkaGVpYmIvK0Q0QkVLMzBtZUFWQ3FlNzkxU1hy?=
 =?utf-8?B?ZWtQQ2k4RmhKM3cvOUlOcTMxdHFZcVBGU29HbXpCU1pZZjZPcmJLSFRQbElR?=
 =?utf-8?B?SkczY0dVOEluSTRqcmFKS1YxVzVPdEI2Y1dBcldwcFcrbGxlQWV5b09GbXhG?=
 =?utf-8?B?M1FMZ2lEb0hFSjhIREVEeEJ6Y2RjVFZDdVd6YnFjYjZvOEZmelZpc1JlcUQ5?=
 =?utf-8?B?MWxxMHFVa0taT296M1FQVFB5WnI2UFFVSVRlcHVUSExxV0NzQUZCa0FsMU9X?=
 =?utf-8?B?eVJFeEZlR0E0aS91amRJRDJtbjhzclc2UXNrVXQrdmpLTjA0dWRmZ01ONHBE?=
 =?utf-8?B?NjE2WWJRQTF5M1lmcW1aTmFvNTFudjE3THZUK3M3dytzanJ4NDZuMjdFTkJO?=
 =?utf-8?B?d3VBTlZvM0dpWDA1cGc5NmVWbHZmeC82am1NUlhkTGlUaW5hVklQVmVnVzdi?=
 =?utf-8?B?Tm5vcjJVbzVDODB0Z0ZJVC9CT1dGUTJXVTM5aG9lM2duNUR3UDcvOVJyeVlq?=
 =?utf-8?B?Q2xicEtuSVBsbFJ1UjlYcTZScmxuNGthU0NHMks0ZkQ3azk2UFV2S3Zjc3Zr?=
 =?utf-8?B?TFZmQzlKelc1Rnc5M0ZHTEU5VXVhL3FpYWdiMTJwc1ZZS2p6ZUVZUC92OFRQ?=
 =?utf-8?B?V3VINGhkaThVcGRrR0JNL3h6VE1yZE1RUXFFbWowQzhsOG1Za0lzUmRkRkY2?=
 =?utf-8?B?ZVkybytJL1h4MnZkaENzMUVvNGFLejZzWDN2em13aHVkVXF4SWdDa0U2dGFn?=
 =?utf-8?B?V3ZHTmpzQTJSQkRmSVVFSFdKRTdsang5U0pEcWdxVVhOUElUN0IyQ0M4cWhv?=
 =?utf-8?B?eHZqQkp5a25XRHdQZnlnRlNQTWtiUGdaOE5MdWpVZi9EQS9pdWduaW1TREly?=
 =?utf-8?B?VG9FbVZyazc0T3hqakYrSzhxY1ZULzZETjI1UkpqMnQ5TWpQcHpXcys1V21x?=
 =?utf-8?B?azhGdkxnZXhMZFU1RTdoUkM0MGJDZHh0bUUxOTMrT05ZdGxOZlduVkVrazFi?=
 =?utf-8?B?K0F3Z2FoV0JZY1NJNnZSS2RuNjltaElCQWpBc3NRQVRDY3FLUWNHYzFCNnYy?=
 =?utf-8?B?MTdXbzJ5dUlDUi9pb2RQQVA5SUZhWHJMOVdEWTRuL2RGaE9mbE0vUlVMc2dO?=
 =?utf-8?B?eHpvQ1hIY2t4NmdqaFBYYUxZQWR3T0JQOWlsWUhmQjhDRDNabnhCTVNwREw5?=
 =?utf-8?B?RkNObVl4aGcyTkRoNWdyTGFtOHRpRG9aS2k5dFFmMXZBUWNGU0lKR0RYLzJH?=
 =?utf-8?B?TmZxaTk3Z2U2Q2ZLendBbGF3TFlMWThoMDQ2Wmw0YlhDQzVoZU1qTGU3WlR4?=
 =?utf-8?B?RG5valdndFpjU0RSaC9URFp6S0IwZFdQVFR5c3pubXduNFFwcFlxaXJMcm5v?=
 =?utf-8?B?UU1LTGlKRmVMV0llTU1jVlQrVjA5YjZlT3FFbXRaTEpWM3NzT1pEdFdoZk84?=
 =?utf-8?B?bWZYTXpQYm02WlV1TzF6bXFzWm5JVjJaNjVmTnMxV3p5aTFxYXVvZz09?=
X-Exchange-RoutingPolicyChecked: OkA/T4glASM7mIyP3lrN0fQ06Ap0pWCo80KJ2+oCc5C2Xt0w7rZbN3Vh658uS7TL/1pvV3QEtO6R+vxc/z53LlhqKj1F/nJGYUQRpoR9ee7mwYQXx5g9tZ57PJbMe9FONTDc0+vZ4B0cb4VQu7zNO/skGuwmNzG0st24CMyYmEu2iZqU1sWv8aqRLwi2hqIqooymrydqU9mpxvnteXvLDsx+cxhgGaIaBWw/kFb2h0dq4dnRizz2mYpktsiSLKyRwQ8mQgfgATYVGC8BHw19jtDgSe0Lg2ylG2EIiXyzfdJwS0GQO/kBtKB/E+/ri2VCDtZ55kJlo9IxKFQfax3flg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abc1d37-5f4e-43c5-bdfc-08def7b12a46
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:02:22.7602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVBww6bYGbzcaW8ZiHYrnmQCcmMgrqb+1DrsR43U6g1cDNDALxztkHGTt3MNf4PAJVSr+e68BoOjLFOj7NVcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
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


On 31-Jul-26 10:11 AM, Sucharitha Sarananaga wrote:
> The existing asymmetric capability structure reports generic
> modulus length and hash algorithm support, but it cannot
> describe RSA-specific parameters required by OAEP and PSS.
>
> RSA operations may support different padding schemes and MGF1
> hash algorithms independent of the primary hash algorithm.
> Applications currently have no standard way to discover these
> capabilities from a PMD.
>
> Add rsa_capa to report RSA modulus length, supported padding
> schemes, and MGF1 hash algorithms. Keep hash_algos for reporting
> primary digest support.
>
> Also clarify that the generic modlen field applies to other
> modulus-based transforms such as MODEXP, MODINV, DH, and DSA.
>
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
> ---
>   lib/cryptodev/rte_cryptodev.h | 42 +++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
> index 37a6a5e49b..e577dd8553 100644
> --- a/lib/cryptodev/rte_cryptodev.h
> +++ b/lib/cryptodev/rte_cryptodev.h
> @@ -157,6 +157,40 @@ struct rte_cryptodev_symmetric_capability {
>   	};
>   };
>   
> +/**
> + * RSA transform capability parameters.
> + *
> + * Used when rte_cryptodev_asymmetric_xform_capability::xform_type is
> + * RTE_CRYPTO_ASYM_XFORM_RSA. Advertises supported modulus lengths,
> + * MGF1 hash algorithms, and padding schemes.
> + *
> + * Primary hash algorithms for RSA operations (e.g. OAEP, PSS) are
> + * reported separately via hash_algos in
> + * rte_cryptodev_asymmetric_xform_capability.
> + */
> +struct rte_crypto_rsa_capa {
> +	struct rte_crypto_param_range modlen;
> +	/**< Supported RSA modulus length range, in bits.
> +	 * A min, max, or increment value of 0 means no limit is
> +	 * imposed for that field and the PMD default applies.
> +	 */
> +
> +	uint8_t pad_types;
> +	/**< Bitmask of supported RSA padding schemes.
> +	 * Each bit corresponds to enum rte_crypto_rsa_padding_type.
> +	 * A value of 0 means padding capability is not reported.

Here and below, would it make sense to add something like " and the PMD 
default may apply"?

Apart from that,

Acked-by: Radu Nicolau <radu.nicolau@intel.com>


