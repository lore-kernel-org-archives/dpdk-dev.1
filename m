Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2BAC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 15:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F18442796;
	Thu, 12 Jun 2025 17:03:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id E67E542789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 17:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749740611; x=1781276611;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RqNe5Me4evI9MVx/6URQRfssDcziuswSoh2FLeBpJLs=;
 b=Wk/gkwtgJwhzvlXxx7QS9HnpmV9d63e5Uqkv9Wk2ORTx0Y54WfQaM8ep
 YoXeahig6vW1QhV0rKbbYZJCgAGMbeGwVtl6JlEvIlQXMv9WNlUzVLC6v
 v2icxq1/RzJUEz82BjBhKtLhO4hel8keQvFkb4ciX1ezmhB618tHm4LXG
 C0ju3quXhU69on0voS9cgKmexrAR2f3yKJslgcAKzjocqXjAJXsRwRknd
 +nJBvVa8MTV7V1gP3eHjFcaQKAd72CtpyKUE5RNydtyhrhM+DLNLITROD
 EHNtrDucWVXUeJDf57lPub/FydlO0OGpIO7VffRpCUjeyqoHvBdqMIXFQ g==;
X-CSE-ConnectionGUID: jabRo0MVQ+ijb2vCRkEtKA==
X-CSE-MsgGUID: 6fa17WJCQSustFkRogKNBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51798420"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="51798420"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 08:03:29 -0700
X-CSE-ConnectionGUID: 5yTBM+DoRDKE2ZeyXTRJpA==
X-CSE-MsgGUID: TI/z18DuRom2MeAH105wng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="148098927"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 08:03:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 08:03:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 08:03:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 08:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnsxQ5rn9ZPjUt8X4tnE6Zw+qLt0F+uKxfn7NqI92BVQn99s+0EJjxqsbX375aYGbK5FP+5tBszB6qxtU+H7j8CwhEstnlItKELpaPZoB7jmXwnXCWhsNLkdAunHot+BWtHk57G8Q3mCrr/42YtiXZUHhby19O/LdxrBKQ9SHGpIWE4kZG7s8LC+apqEdjg659xTsfqAPZj3fLrjWrj8cG/iK7oz1PEqr/oxCTQoM391hNDtb5chVcwlSxZCVpk5xe+Ku/Cx5nsBR6QVsnONp6NJQ0AK4CdL3pKf2akdeJvuH4Q0UBOc3DyKvBKMneS8538BWCr2iigbmQ6Stqw4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPa5dcLQiULy/hQ3dLQj95sRszW3x3000Ze8AyWJmfI=;
 b=D56QD0/A48d+eQ4N5EoUqK+nDhX/Nkn0iFff40kIHG/uYVZ5GMd3+KgGAKZ2EuoiOpin3+5vwr/DusDAD3uzvvxSdpHOz4ObgZF1dBSCHqazLSmoJO3auPvn7yQP4TOn1b3IkDX9uewZ3Eb5I44qkJ1OqfycsSYHMqGfL0ya2U07Z/dNKG1yxz9atn8ceG60JTIWZ5LnHxx7H5gC308uRxjpwoDFYBTNUvcgWpYXEHHLQoylgI7ozqoSfk7DMS9LFgvQ5LgbtZkSZidG84/ePz5uLAjdns6IU8UkcMXM2A+rxZ9ROo4+4XAec1WHY9LEMF/vF6No7jBZiEdIsyIlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF9D9CDC305.namprd11.prod.outlook.com (2603:10b6:518:1::d3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Thu, 12 Jun
 2025 15:03:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 15:03:23 +0000
Date: Thu, 12 Jun 2025 16:03:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 1/3] app/test: remove use of non-standard array range
 initialization
Message-ID: <aErsNWFWWEoANVyV@bricha3-mobl1.ger.corp.intel.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1749737842-30538-2-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB9PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF9D9CDC305:EE_
X-MS-Office365-Filtering-Correlation-Id: 6489d317-af1b-48c3-f20d-08dda9c2469d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tPNbaM45sSAk+4QuJsyCd0B6xXptVigjiGDPCaJJIuy9wj4mtHrd9kZFR4Mi?=
 =?us-ascii?Q?iVtjYzpEcka+mRdhBUhGhoDf30vkI5/8o3749qhRMe4hb14L04XDLLBIZBkA?=
 =?us-ascii?Q?dXt5iaG0SDq/oZgK5jDvpbP4Nomwv6qB2vlW4Rr+vedcEkI9SfhD162SrpF/?=
 =?us-ascii?Q?Amd5tQQ5F2+tSoH9sIeeXozMlWvZfHj0R3OSeD16BmS5+hlDKuQKNF9898jD?=
 =?us-ascii?Q?tnHeAht7XVYTOFRn+R/GbHsDlFcYfzcvlFjNkJ9NzCfgsoGKPkUZ4gIm6KzL?=
 =?us-ascii?Q?ubBwUSV11NUf3LwcOwCp+HvKLe78mHU+2Agwek+npzEuxT/QrK7+3c1Rp4cK?=
 =?us-ascii?Q?7T7snVMVymAVt9CJktNT8zNbszyrQ5WndfPyoU67EVsziX5LHKhPHaK/Wdq+?=
 =?us-ascii?Q?pl540fhBXdUBas3Qwx/cjgmOCtNq/k0Ydf/KnrCxyXMIxUwua6p1NkdjG5aF?=
 =?us-ascii?Q?2MlUANTjJREywpGYhypeSJB2MQuj6FAOdtXdzy7Y/34DxJTKRr7L25xxbA+J?=
 =?us-ascii?Q?A2z3suUDacozWNhS/MYox1+MFaIaHOJGK9wEOxfr/wm9KUVjZ7Q7sgH0YEcY?=
 =?us-ascii?Q?9hkF1RqqrSN877KhCb0ziOw+VghqrGIfKdPUCMcHMbbhm96Hu9I7d0UlBMTq?=
 =?us-ascii?Q?/ouLL6kactVEZ1J1ulfHUbtEbI4+vIkt9O9I+ex+Az61QaTW79G41DwhQ9K4?=
 =?us-ascii?Q?SZlKCKg05BROrYx1Wo28wrq0dO4MoELIqbrO0+cp8dnaJuaT+4w9wCxvtgbo?=
 =?us-ascii?Q?zB2wDMh7SSDYx/QsYaVwO3rh1zjysmz1F7ocP8ptFOBi6J+1Cm7I0fAO+gOx?=
 =?us-ascii?Q?q6hbVhVPFTw47HNEUCPsBhgCJg5EzeTjQrNk5f+WuqLysx3ikTXtHROfOKD/?=
 =?us-ascii?Q?hwRZx02LadfFeG60vLRKOJH2od/xW/AxaP/SAVFiPXh/ftozNzjoFKH2ScaT?=
 =?us-ascii?Q?3ErSqRWgG9hawsBnWvM1n/rzkzgjDSkrYL0uoiYtfVQQsbml0SCGPeKJxzoI?=
 =?us-ascii?Q?vdQnoCVjdgKNwtWNYsK1MqKy23RVSiyBxmKmxikaTKabgrehZXn2fnUDiG7c?=
 =?us-ascii?Q?FI2OWzGfw2h4uqctHKO1K2wSesETnAOXDMF77dSza1gM9K1uW+UNNDK2qDHL?=
 =?us-ascii?Q?/vJyj9t+hLir4exv+SPJQ4R9hOd88aD40B/j09S8WceSK8VF2oO4cjtsZFzm?=
 =?us-ascii?Q?FGLL/LD90HOYZBbfPIiMqNv6kZ1XC2vIvu2i9GvzR8kk+kD/BmB52MWiN5Dw?=
 =?us-ascii?Q?D5SNS634hqZBpY5Fx1Vj35SWyYHvzQGtujTRXkgvw1fXu/kncUPqYm29eKuM?=
 =?us-ascii?Q?d2p43zBdVLNZK0Fb2c+TXALTLFMXH1aAYm8XYYz3SzhIeVoKGe0kxUiLkfbt?=
 =?us-ascii?Q?DX8Lf/NTMn18Q8NaYa/Z78rMelymYhDJ/Z2CqJmhLhQ2bfarkvmE0/V3KZyz?=
 =?us-ascii?Q?E+BfOsxpIrs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZK0osoSOvSMfWfDRlreOzWtOy7D1bSLLKnYCUizZI69qLGoruuCPTJQguG4h?=
 =?us-ascii?Q?P0FQCN2pZwEBd9Ift3p3C6TwKpkzeJjSsYjRayzSzChtWnWVP7TUM+YzqZWN?=
 =?us-ascii?Q?AgrMDrXhmAMCu+fkwNBQ1FrpJ7sOph4608AEr4bRtP2m2xe5Nhl+2YkcosoY?=
 =?us-ascii?Q?EI0vWWnPTmpgDkF6UuBgKURxeLwOgkQ3O1Cv4ptJjZStYw/iHZHV/T9Hf03F?=
 =?us-ascii?Q?EUq4IDQorQE1lEc1sLqfSvrS2ZwrZmISZGqUQquLq3N6LJ6pK6mrmjKTz0Of?=
 =?us-ascii?Q?PIpw1SgZvcf4aVT1f0h44K7YT5scK4c7y9r3y47yZd7U1F2k8hhxdf+YmFE1?=
 =?us-ascii?Q?Eri1/JnGF04S6+4Se6R6CyT5zy6V5dBGR7J7s+jZ5uLUQpz1ZFTvOJv5JJWF?=
 =?us-ascii?Q?MM8/IlNgOOHzCMYnrTWHZwL8kSdKS4GKy9Yg+tEbO+KCW556jKXnenzi8ckj?=
 =?us-ascii?Q?mFt8ViOmQOR0EOYpqB9X45T44XXoVg12a+noJwEtEfzC56NAOOZglRr9uH54?=
 =?us-ascii?Q?xvUq31MQ3jn0rLugorcTLeWBnaTq687JXSmLyRxWH3vI608PIE4C3vT6kaXG?=
 =?us-ascii?Q?Nqr6DdID6tkkklttC/ja/xwh589Jv4eviz8SnTtyHngml4PsTfOb0h4aiudy?=
 =?us-ascii?Q?FCF2Ip2eQNa1pzDvmpBYtOi0WkcJhgVwaLn4bRSaRs3MR5cSKuLT5DFUU5hW?=
 =?us-ascii?Q?DrYAhsgCcu6e7bten82wXNIQUQhbVxPzf+H5dVqXRFFulYCZdiH7OwEqf378?=
 =?us-ascii?Q?XG9e0zEb1M2dOz2tfbJoQ7hkdSNLVpsWMy6FQgvO4Wu0+LlKAnkBNtcPgKvN?=
 =?us-ascii?Q?+f0uP1aPj+vWeiBLwjL9Yu7F6mMMEwkC8hC1gxelFCN+/NzUIfxSMHbZYfsR?=
 =?us-ascii?Q?ZpuS0Cviu0YvSWSwkdV19WXOxqyA520wo6b+L3ggTm/Fio0mcuupFAsrLThc?=
 =?us-ascii?Q?rhkYX9BmLN+MQVmkqR42DLJcLcD+BSZxupz+0Jl1IPl0+TQuARkHMkwKj7f1?=
 =?us-ascii?Q?xjhkcl8PjNbYSOhbJy85W3Z5abaBwqWc8oDNY0dptWuI9Thai4UWTpsrW0hh?=
 =?us-ascii?Q?y5p1rZr3rWm9efmeP7VjMpRhX9xOruo3M+its3AjosN8UD3r5BvKyfzP73XN?=
 =?us-ascii?Q?lNMBRqQRTjdjt1Lpko+yTHTx2nH26bTcBls9wQd8KHsF5Hq3lLsuSASfuiBr?=
 =?us-ascii?Q?m7lRljTKR1vhh16MTHNSwXiZEFJeawhj9HbtDskkgAWwjqf2guymRxtuYHVw?=
 =?us-ascii?Q?pKuIvp+jc327DgX2wpthR66UfUtI0WYODc8zMguwNBwVHFRTGD9MDInd7R/P?=
 =?us-ascii?Q?egwy7LGOmNih+ee3oynzKzhmsH6yMWAXe53ZKQbajdw1fTqfY5BX6S7sHxfF?=
 =?us-ascii?Q?Ngw7XFXBAexUDkvLaA2FNW4bwwKO4jL7JXvfPTak0fD0otx3TuMLV7w/Ypm/?=
 =?us-ascii?Q?cSz0RR/h/LRcIe3MKpPavkSZemE+y+lic1I9OUEG912pPk7UjZ4XaStZHato?=
 =?us-ascii?Q?azjkkpKDp4Q63pTZo/ebDs0YEHlFOSBydjIR4h6z1xDXhgt7eO/4RrM6o2dl?=
 =?us-ascii?Q?GsDaprtXX4ygNZ0G2PXQmpTKBzNdbPlWK/f3dWMUFofvIK/YWBUOW10S+6nY?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6489d317-af1b-48c3-f20d-08dda9c2469d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:03:23.1828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA/nL4ojF8w/jCnqX4COT4FBRgqiTtgS9UahUeOVdbgcdI0fvJH5FPHVUQQMAxqDRBBGiDRKSFL504XXlX2cAsdYTKwD9EhHpLOZOXmCryw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9D9CDC305
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

On Thu, Jun 12, 2025 at 07:17:20AM -0700, Andre Muezerie wrote:
> Array range initialization is non-standard and is not provided by
> all compilers. MSVC does not implement it and ends up emitting
> errors like the one below:
> 
> drivers/net/r8169/r8169_phy.c(380):
>     error C2143: syntax error: missing ':' before '...'
> case CFG_METHOD_48 ... CFG_METHOD_57:
> 
> The fix is to explicitly initialize each element in the range.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  app/test/test_cryptodev_zuc_test_vectors.h | 156 ++++++++++++++++++++-
>  1 file changed, 153 insertions(+), 3 deletions(-)
> 
> diff --git a/app/test/test_cryptodev_zuc_test_vectors.h b/app/test/test_cryptodev_zuc_test_vectors.h
> index 714d681fba..e694cc3922 100644
> --- a/app/test/test_cryptodev_zuc_test_vectors.h
> +++ b/app/test/test_cryptodev_zuc_test_vectors.h
> @@ -1067,7 +1067,57 @@ static struct wireless_test_data zuc_test_case_auth_4000b_mac_128b = {
>  	},
>  	.plaintext = {
>  		.data = {
> -			[0 ... 499] = 0x11,
> +			/* [0 ... 499] = 0x11, */
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*00*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*01*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*02*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*03*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*04*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*05*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*06*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*07*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*08*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*09*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*00*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*11*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*12*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*13*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*14*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*15*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*16*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*17*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*18*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*19*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*20*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*21*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*22*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*23*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*24*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*25*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*26*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*27*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*28*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*29*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*30*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*31*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*32*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*33*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*34*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*35*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*36*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*37*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*38*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*39*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*40*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*41*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*42*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*43*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*44*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*45*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*46*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*47*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*48*/
> +			0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, /*49*/
>  		},
>  		.len = 4000
>  	},

This is very ugly to have the source code. Can we find a better way to do
this, e.g. init this at runtime using memset, or else just disable the
build of this test case on windows?

/Bruce
