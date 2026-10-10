Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA0CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26AEC40663;
	Sat, 10 Oct 2026 20:31:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D7C964065A
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657075; x=1823193075;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=+Br+jFnagTm0XS3P7LEV7GnW1XJVWJgOlZLKPrlhjfc=;
 b=mrRQtQDrhMfWeJJqfz8U5qdjenE1BW/jbbPDOmAOJ/5Sah9YZhMoO8tr
 DVyHgX+xk+6OHZyAHE3TSWe5Hy1eSxvy1mG6sqC2dXjYGdb3VZxXyNGF1
 zsqTA5Wz6izdxWnsrxO0vWrW/u0UDiHt2aFkGhnmLojkzw93fXJsOg24u
 KlrsIeMDCYgYMzJKgRTdA+hj8t/iv5zVpJMk6hQHq9Albd2eE2unxeV3T
 lOCR8V+i4cOztHwaJp9yncHBUacyL65K/muMXD2CN66fgdy1d4DPi1lkt
 DpxaIO7GmCeQPk90D2qIz1kDHE3Y1wwubIT6s5eXHpC06XSZG831CtToJ Q==;
X-CSE-ConnectionGUID: Drd4UtuZSu+GiQtd80WWjQ==
X-CSE-MsgGUID: m3WFC7fUSXy+LccZk12kmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="326577"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="326577"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:31:14 -0700
X-CSE-ConnectionGUID: ufgzaX/yR0iFyHKo2a93AQ==
X-CSE-MsgGUID: NlhgHkLtRseQtrqhaeCIJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="897761"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:31:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:31:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:31:13 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.45)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooY46zzLAyBVE9vmtI0mdlWW2PHvzQIZeHG92eJKBg70z9bRnxWYmYD1fguWIZcB5UI4tvK0ZwrzWU6tRcqa2qmGAJhIXmaFaIqEpX16B851aT615gYjZGnnivNbA8C4iyLu+07P5v3Ge9nLHEYo6zP/NE11EVHAvwmUx62N4HvWtUkR12hxaTbu88+uBUEXYuzXJetiw3cE5s+s+fYQkn/HFE79kLP0MV8PnTxZ3u0zlCiWahukVp180ikvODNQFwbgbQXl9d88ItjthdrvAadiIDtySSg6IkmejUYgEIJDapUNo0ia19fevsqigtjKd47r9TZKbxRM/tA+IjUpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqyyXAgIM1GiTiMUHn7WA9h1ZzJNHLVdZTCrnW6tow8=;
 b=EIbuN3Leog4pRQ4vwvPVnz1Hvz9vj4J2BZYF4787V1F1Drp/3RCEAe+kkEXhai4SDiul84seOMhsyNP5wL6YIVfUqLLeBkj3Tqqq8p1DbXGADcrgSd53lNyPOYP/J/1vOdT6AOw95SBT8rnbGIyW6RZfVvAG+pWqr1GDBDJeYc3Tpy4OL2vIB48WC5j5utfDOKYZBP3UTXwI4zvq4TDPpXRuxP2QMJT1/vc8OMAYzFJD+ftOErUze8QqLO56ffJLeJAiX4knupN7UCto4+edZxL93Zl/dEpRZHVHVDQONe0Ps/TqqDi/9SY9iLDz7xTBcx5kpOIUEv3TYa/Z1nN33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:31:11 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:31:11 +0000
Message-ID: <761500e5-aa05-4dd2-b4d7-1aadfcd6213a@intel.com>
Date: Sat, 10 Oct 2026 19:31:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/25] net/ixgbe: fix syn filter priority
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Wenzhuo Lu
 <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>, Beilei Xing
 <beilei.xing@intel.com>, Wei Dai <wei.dai@picocom.com>
References: <2507bf5e4a1451674e66bd487f8e9ae0b9d743f9.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <2507bf5e4a1451674e66bd487f8e9ae0b9d743f9.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0042.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::18) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: ab07a1f1-3aea-427d-a51c-08df26fca881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6qCXG3Eu8wOLeY2rdMee3gT/16UdJGz+fYNFy85KnsfqtvbHyMBEtvYXliWYFPABgxGEDwHaODmisVHiIoe0ESUzWV8+okoN1g+g4DTNpBAr5BzxwVWVPzE4iJ01jikdZWCHfjT3ehxTn7VJ3OfHa3/qmnF9SZS5z8CH53jXUPYwiHkpw4DdHlP1DF7M9u4pOg0j0srfzUAKMCtOto1wX2hWb8pAVcimdzZl2V8oxr6neL4giKdSh2YXf8JJC9x/+evrOiIjxW2EA5H7rPLXj56IIgIylZ9txyLHEfZuySOl3xY/8R1rafqiQNk38cwbX2fWsejf0jFtJpd3JHonwlCxDTj0sDeFfqZM+ZJiScebJ8chZS7bpZA7XjJmKnyZ2cpOkj+sdVp0Vf3lWBvL9ppgP60U1UGYonL1gCbDF3J+U5YTbsbx+9LjJZKLTbdexnuztLgAw0IFgKJlMVDidznwfHEjA79+jBQolmQX5nNUnd/Mtl+N1WOCvjFnI/p2b6a/VJh1VSlfHAgF4uyPbZ85EjASrc5ZRtRUzIHdThVaBFMoX7Jq0gkcXMWrcM2kEMWv0ouvFCCiOV8MfixGnGVWvdAsQbPhieohlZPqGhrRlJQRuQweTvB2Jndu6WCmnLBzZifLKEArX5lt4dWjJtMY2Y8TVxWgsvK51dYAIo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0EvUzQ1ckhBYVJmL0JqZTltd2E2RjU5SEh1OEZlajhPZ3ZvWXNTY2Mvc2dS?=
 =?utf-8?B?ekNkcGwzQ0JlazZZMlcrbEt3VEZab0VFUnJmamp5RHVWUUdYY2NPNXMrNG93?=
 =?utf-8?B?M2xHSHVRa3lQd256RDhOcEJXaUJLcUU5Mm9SQlB3ZjdJdDR1d1M2VVZwc05R?=
 =?utf-8?B?THcxNUZYWVN5dUpiNysrdVBhTUs5UXBJcm4vcUg0SkRkQWlQazVCckJqTlB2?=
 =?utf-8?B?U1R2UjljZGFQWHlUQlZoNnZWOG9nK2RaOVF5NGs1RE9aOTU0VTVsbHNyODNJ?=
 =?utf-8?B?RTRqOFdvYWw4R3JFL25JUFpjZXdib0tZdXJ2MnJ3eDZEbnNjM0ZlRk56c05I?=
 =?utf-8?B?YnNUQlZRcHo2ZDVZSWRMN1JZK290YUliTkEvaTE2NXJac25iclV4RkxHbCtm?=
 =?utf-8?B?T0R2YkkweHZYanlQbDBJWllrMkc2T3liMmtkVllobmU2R2JWV1dRejVIa05h?=
 =?utf-8?B?OW9XeTFmb2VESTVVMWNGY0pIL1cvUUI2enY2WlFlV3ovcG1xNUVaUXV1WUo3?=
 =?utf-8?B?eVMxT25keHBmNDFpVGUzYjIwYTEyaktlNlFSc3JlL2UxMXZNOVVIb3ZsRS9q?=
 =?utf-8?B?dVliR2RUS1VIY3NYejVuRWhYVm11SHU1VEU4TXkrb3VCNVBhRTRFbktmQzBH?=
 =?utf-8?B?b0dNZkdJNEdJam5KYXZiWjlxaWlWZ2dpSnRCelhnU2hTMkxGTmQ2QlZ2WEhI?=
 =?utf-8?B?TWw0SGcwS3hsbkVPYXRvTXI4V1dJVXhteTArNmNmaUEwcHZYT0QzendVQ2V0?=
 =?utf-8?B?N05OTXBYNFBSdklaL1NoVE8wUGlxL1RuSDlGNU5SdHA3WUJOTW53WWRQTUNZ?=
 =?utf-8?B?WWZPa1ZtaURmcUJFbWVjZVpqV2dlWFBjOEhDWHRVZlFEOTNJVGZsK3BSS3ZK?=
 =?utf-8?B?MWt2dU11K3RPeldiWmo4Rm10VnlwNHpnM0tLcDIvek52UlhQNDJBMEw2ck9F?=
 =?utf-8?B?ZEJKVUFlYXB6ZG9iaUNPM3dJa0hvcE14Z2ZiNnNkaElqdll1NG4yclU4bGlr?=
 =?utf-8?B?OWtpZkVIME85aFJVZERES2M1L25FdkhtUHRqNW1GYXRuRjZyOEFuZDFVRStR?=
 =?utf-8?B?NGduUSsvT1FnUnQ1TXdkcVdwcGtTbjdqczdYZ25sM0FyQTYrVERIbVRZQWtT?=
 =?utf-8?B?K2lYb0F4VlVTQTdpamZaNnJyZzhPVlFLWEpTczVnS2dMdllsL01RQUR2WkYy?=
 =?utf-8?B?Nnd4QnhjUTBxRDBrRlF4Zm00TUVjc25xZ1Nqc1lTRnkrcUExUTR5aVRKaWUr?=
 =?utf-8?B?cm50NjNIWmwzNHhaSWlWNTFiU0kwZnJYWUtGeDdpRVN2YTZVeHUrT2I3ay9W?=
 =?utf-8?B?VUNZcmtNeXVid0Y0SnlsZi9hbWR1WWZEQlBVOENvd1dQKzNIL29BUE9kMXp4?=
 =?utf-8?B?R1VTaElBVTlTY0lRcU1QN0kyam1jaU40QUdyL1kvOWxUODVZcHlRTCt4M1Vi?=
 =?utf-8?B?VmhDR2Njd3ljNTVLSFZTM0RyakFPZFFUK3BkYXc1dHdZWGpLeEMrMHdNYUdQ?=
 =?utf-8?B?WDZFUnk4Qm1HWnc1OGVSYzlUVkVieTUyUVhaamNsWnowY0JpOUdvV0hCMERx?=
 =?utf-8?B?a1BnVlNnajk1Q0JUdlFWOVlxN2w4VWVQc0R0Qk5uTlduVnZXQ1BpekRLTjB4?=
 =?utf-8?B?SkRBUHNBbnJKQlZaWU53blZpSE5CNlJTbld2MXBIZ2NoYy8xN212SlpZNlpq?=
 =?utf-8?B?b3ZYT0VkTUoydkFwbTRMWHM2REQ4WGkvM3pTcGlaQUpiaHhyK094Rkg0a0Za?=
 =?utf-8?B?Snc0dHdCb09lVVBOdU83S21zSTBvaXExVHh4UGFRcEQ5T0QzZ1JvckhxZUFW?=
 =?utf-8?B?bDJMTkRPUitlOU9DYzN4UFpYWHFUZS9YNnZMU25XRWpNTnk0Zy9EQ0l5TUFw?=
 =?utf-8?B?UjVyQnB3MS93aGtzUzl4cnNlK3RVK29xR3o3SEd5djZydGRLcEwreDFBenhr?=
 =?utf-8?B?Y05MOWVZT3VCUXhaVnlqZTdFU2plbHVsVnNXSUFwbXdneGFqdDRKT3pES0R2?=
 =?utf-8?B?UnVuc0FWZlJMV0NtMmJGUFE5SGJTYmlwQ0tac1RKRGlxbFcyWDJEVXdGUVZr?=
 =?utf-8?B?MHdMbEZxdStacEhPUmhMa1dKMVd6ZGJ0TktzR3VQajlNeDhNcEV6d2JvWGZp?=
 =?utf-8?B?RytNTlFyWGdrUE1GVnBPb1dTdTBZRWkvUitISEN1WXdpKzNjS0ZXVElSQkho?=
 =?utf-8?B?cmdia1ozdHp0U0NLNys4VmE3aHllN1ROVUZxQnVqeGdtbFZVTnVtd1BnNjdD?=
 =?utf-8?B?OEJjRWVQQzM2QTB5RVBxV1dFOVVFV2JEeUIxT2FOcU1sOG1EU2krSC9uUEVq?=
 =?utf-8?B?UDJBRC9lV3NVcHVnRFQ2MlNyeWJjYkczV21Vbi8zYTRpenl3dXQ3b0pFQjBk?=
 =?utf-8?Q?LTdTv2RAShlCHS+8=3D?=
X-Exchange-RoutingPolicyChecked: HigY/ezWuWkVmI6t22ysM8stiMWUu2h2Ws7dlVZK1BG9pM93euu+HvftN5XKXj5+b8WkodhTRqv/LU347cljuU/Qu9ch2gnZDU9eIwrCTqkW9McJJ/hm9jTlJILoGKH7UiKtga5//6Hl3vI8jiwRsiXjj94nqEasLhAa5baMlSvtD0FALfd1SKGxaFdwLc6oOrPJVI3CimhDK+k2og/Z0UK2JwReejIONEkEH7f9zPYDgPsUqwW+hKXqjcxPNf5tc/0Xk41v7jUaaDrj63UO0Jb//t4hw7McSXackFFtB+2Fg5wwT9romtde3Z50UZm5O20hb9lr0yBlRaHF5qj+Yg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab07a1f1-3aea-427d-a51c-08df26fca881
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:31:11.2213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIDua6JoLX1yLD6gISKIFxedVVAhgTto5xzksXS3V+VfJM2orBUqJ0bBArLbFUe3vRJyxxNsIQpgibFAcewnjcN6mNSuhjcKI1YHRpKGT+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:58 AM, Anatoly Burakov wrote:
> In rte_flow API, 0 means highest priority. Fix SYN filter priority being
> wrongly set to lower priority when API requests priority 0.
>
> Fixes: 429f6ebb42cc ("net/ixgbe: parse TCP SYN filter")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_flow.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index a2b9403d3a1..6ba36a8b44a 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -804,10 +804,10 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr, const struct rte_flow_it
>   	filter->queue = q_act->index;
>   
>   	/* Support 2 priorities, the lowest or highest. */
> -	if (!attr->priority) {
> -		filter->hig_pri = 0;
> -	} else if (attr->priority == (uint32_t)~0U) {
> +	if (attr->priority == 0) {
>   		filter->hig_pri = 1;
> +	} else if (attr->priority == (uint32_t)~0U) {
> +		filter->hig_pri = 0;
>   	} else {
>   		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
>   		rte_flow_error_set(error, EINVAL,

-- 
Regards,
Vladimir

