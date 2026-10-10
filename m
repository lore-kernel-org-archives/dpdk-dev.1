Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5AECA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:33:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F7FF40697;
	Sat, 10 Oct 2026 20:33:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 97BEF4067B
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657204; x=1823193204;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=RuHAA040AQpKQtIA/OVHq9bVhtT8F+d3j8OInr0rRfk=;
 b=MBG8zDWdECHRfl2c1wwSRQPu/3Yp+Sz55vpDyClYbzCCGv6U9TW+F5sP
 s0lPj204fU+pzOj1y4qDHUs1lDDRiPM4ZUMHGMz4I0GG+j+YgGZgD3mfl
 3ihKEuV0Fg75bSMfSM2tnhWvHbUARoofrcTFnTl5p4nvZDTQ+EyoKA/fW
 bpzm3jXqUa3KDO9OYb4v+0tfYukmer9eWGwVS+AwfMDC+ztzAXLaYiLp7
 j6YwYn6TU/MC1YhNgLv8zeOQ8/gFZdIquIPTqV933LjTzLqPAOZYiDg53
 VNw7qr/zvZIuaFQX9hZGMNFVnNSefPb0zxRcj7zEUcAO5aTYWjtWPPAxn A==;
X-CSE-ConnectionGUID: OPxDrb/DSJmC87zs0lc2kQ==
X-CSE-MsgGUID: TURCatdyQUScTIRNBVmLrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="305088"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="305088"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:33:23 -0700
X-CSE-ConnectionGUID: 4qCtA0kBQ1iZWDuTyJovlA==
X-CSE-MsgGUID: D1GCk6PoR969lL9xuG3z/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="557798"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:33:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:33:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:33:23 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaHFZcIWP0D/dh1nC6qrxRaV4H/Ty2b4NaTtyilun+W3jJ4uXcLJVx3/Zg/e8TtybaE1d9E3krEMTo4dxM6FcWj3c+lIu74NIdEMQWYzIHZOxfbXeOuUIt9X60TvzURXZd7l6zlEqRV0eOZ42G6reHV1IkCgJ2Hi2H87tsDgSFMVKzwebjvjb7k3ZDzqeQMMltyMVAFn63pzuZWT7Gwa1pjBU6a/K5cEQLU38DfbX8fLhW1H3gty3MDttIA3KU9DQsUPib06H3W0cXJ1WAnQS7PPoUn4Dw6kx3rTVxP+6deWQivKrmHiOXt2dkYVT8vXZAsr2Av79cO1kvVG+msI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C30OU6pgqOKP7BCdVJILCaQgOfTkWqLRlOZTMeZGSc=;
 b=YcgnpaC/mjTqhQuDe+VJIrkJoicuEaoHHuyoiXC1ACegEUXLI5Klg2B3BNW0PdgeiPSICw37J3U0DiUeP4/V9qHFZnMmiIeDjlSTynPJWEVolgB/7zSOGje8Hulj1OV5tf6fZpkYKwqNN2aehMAC2NMRvG5ZAL8aUYLWy5xai1udFO5HcU2BKWgGMviqHbAeceiDB1uwmaSh0vxbS+6GWxnR2LWN7brZclFS9hzLTMQohsNpCYxyuOozHgg/N8oYoi7OpmNqqN5g/mW5rh9kun40+0L+LpCg0sAfgQ6nqHaO/XOqm5U48RVMMXm2w16ADwNEK4SGKwOnu/MVK6bBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 10 Oct
 2026 18:33:16 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:33:15 +0000
Message-ID: <1a6d8193-7ef3-496d-a322-fb39881e35a2@intel.com>
Date: Sat, 10 Oct 2026 19:33:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/25] net/ixgbe: fix protocol-only ntuple parsing
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, Wei Zhao
 <wei.zhao1@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>
References: <27b39f9a15d6f5aeaffd1dcbf2955761dfe90f9c.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <27b39f9a15d6f5aeaffd1dcbf2955761dfe90f9c.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0285.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::23) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c8cf7f-6839-4ac1-8ca1-08df26fcf2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007|261009223027099003;
X-Microsoft-Antispam-Message-Info: 4KtRA8Y2Q8cOPaIiOA/4Pi1UbNuCOb/qxh15ZHw0X22U2wdJ0HWxHifOPNnuZdp7D6MapCYG6Z7+DfjVE3MBHM0i65ots8vIY+LyuSmzraAVdKRMAZe2duraxXO0YHenehvCfPDhKeoVG547bkOWjDndNZlDU4k+OZSRB+0KMSO97xcSUNSyv/r7Jwg8J8OEI/WkCxEb5FCFPfWHuNSTqoioDJ68sTWt6SQUZ/3ALykUG0eBxMa+vr4KX4cKdBDhlq+R5pldhj9p7YaX4kR0pFtYlwaue/ui/BHuOpPPLoKnpM2FwLeYmufcvs7cdCFbaCuDnbwOXhVDJHU0wfcEt1E7zgbHCV0KoK6BEWLc29x9YVR17mZX+4J78j2ssQPgkmlSVTkrsbxie0Y+rR40cwINNtw/ZHvO/TYc6eb7qGc6G713Ersw5cwZGVcsuOUEKe4g5+ctkH2nVp2pAIWX/n0ULfNZDAMxvGD0cyEUJKZEnGUtPyyz5FaKOV6vZ0tSznjT1G3NPzY4n4X9N9fjU58nk60bK+TfZyS79Z8WAgZAS4P7O6Os8R2ZpXcToHTVA9gnZae8k1xssJxIrR6watl091ew9KwoNDKQzAzipQMYJSSIcdTqV75cRNjZG185BYaIJdoO40bop1MHWJNL01clVT9VAK0IONm0O3XIaQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajZkVys5OW5tSkRINmMxSmJrVFUzVDRycXRwdlE5Q0hxK2xueVFvd2RqR0hT?=
 =?utf-8?B?dTgvNU95L25QaHRCS0VMRlE0dGVyVkJYQTZ4QXhRZnZybVVKZXJrdUFlZkcz?=
 =?utf-8?B?bVVXS3BpbGJBWjRQaGJDRURFQ2pEenZ4Mklza0NoS1o4VzRMRUxzUGxpTHp5?=
 =?utf-8?B?WUJIdnlUWkIvY1JvSTJtVmNMVmFXa2dqdmNJekxWa1F0UGczZzJxbTJrb04w?=
 =?utf-8?B?NGhLMnl1ams1QkdpU1ZJeE5YTURJbXFidWhWTFVEUWsvdDJhR3BmaTk1U0oz?=
 =?utf-8?B?YmJncHFXQnlYMk9RSllUU1llNGJMZElOcEFTRnhqYnBVNG5KUE9VZE1URmZa?=
 =?utf-8?B?NCtsRU54VllPTGZhRnRKNkxDTjBVQmtrT1hac0JkTWQzZS9NR3YwRlIvUGNm?=
 =?utf-8?B?dGRPR2d4Rk95aXQzY2xUaE5RbjFKV3M5U3RITHY3aEhUM0RtRkJXZnRnWms2?=
 =?utf-8?B?Sm1NYWg0TWJsZzM0MnE1T0VZdjJVY3FFMFJpdVU3ZGhPcHo4Rktsd0FoeDE5?=
 =?utf-8?B?VUQ5aitxSjB0c21FY3hBUU9qWVljS2FQSjRMWWkwR1l2eWV1N3pZWnk4ajBR?=
 =?utf-8?B?b0ZsTkFIZjR0TTg4RlRET0pUd0s3K3F3aFhVOGsvYjB1RE1PcUVDVk5XTGo2?=
 =?utf-8?B?N05URTMwM1drckZBVEV3eXg4S3MvS011WmhZYlduNmowUUpTRnI4RWVJWHJV?=
 =?utf-8?B?eE5wMFZxMm9QN2RvaVBHMFQvRHo5OGROTTV4bHAxWUQ4NDhDMU9PUlpLY3Fp?=
 =?utf-8?B?cmI4THR6QjJMMkl6NndyQVV0S1N3ZytIN3Eyd25US2lKSWF5am5HSytYY05M?=
 =?utf-8?B?S0d2bEZvMFJHR3N6bEVGSWdrZVd2bVBYc3dJZnM0MVk5MnNOanVKTFE2cFJY?=
 =?utf-8?B?SFBmbWhkczNkai9DV3BsUy9EeENickV0ZzZ3aHdaTVF5dElvSVV0MTBqTjMw?=
 =?utf-8?B?RnhNMmFGUXF6bC9TQmVzTW1Mb2cxQ0NaYXEvS3RjWU55cng5YmVzVUo3NnQr?=
 =?utf-8?B?M25IQy9MYXRqNkk4aUtJSW9RbGt4eUZ2T0UrblFiU2U5aEVOY09FVTVFUFYy?=
 =?utf-8?B?WVRTbHFiYWhXekV1bTUzZUlsRUpsSzY1V1BwSDRqT1ZDSXBaS1JOUmh6b2JV?=
 =?utf-8?B?QkpmZVdZM3lTaXBHbjg5Z1VnbGNvOVh5c3RGTTgzQWcyUW9oMFV3YzFQT0Qv?=
 =?utf-8?B?TkFzZTJOK3Y1bWVSZkV3U0dMU2hsZ3NKZlJIS2lWcmFYZVkvc1IveXNLVS9z?=
 =?utf-8?B?U2w4Z0lEWG5lTTQ3aVQ3d2syZjZnSExONFJYUGMwbENlb1BpVHp3OCtsY3Ar?=
 =?utf-8?B?MkJRS1hsRWFuWWFKemRVVXZ5Y1NGS0xRWHU5MXZndTRaV01WZXl2TVJWYk4w?=
 =?utf-8?B?NWlvTmxDQ3B2S2lEKzNpOStjMkIwcUNWSWp4NmZueVNOdUVTcGFtZTdyaVVr?=
 =?utf-8?B?T0NkZ01OTmpxRmgwNW56d3JUandFSWlsWS9PYnRoUnVqWWl3dFJYT2RBalR4?=
 =?utf-8?B?aEJBS0MyYWNYc1F5Zk1INlNmNlp0RlpXQmk1amI2QVRqc3FDTUZnOTlTcEg2?=
 =?utf-8?B?eEJJSnJTNlhHZHR2MmxjRGxyc2dHb1JUaG9wRzhRby9uMENLbGthOUNxaExK?=
 =?utf-8?B?RHZrRkxVbDBnZUUveWFRdWR1R2lRbVBock5OVXUvRXljK0tpQjhHK1pKWXVp?=
 =?utf-8?B?SDZKTHViblg0YUUxQk5XYXBsT2UwNE5ZN1k5Yk85U3BiQUhFWk1SSERoeXlC?=
 =?utf-8?B?Z1N0aUFVTG5KWW9LdG9hS2dLdDJ3RzM5ekdIOW5OZEQ5bmJsMEo2VmIwUzU2?=
 =?utf-8?B?WDlPUCtSZ21mL0xzeVB0SmtsTzB0Skc1UlNGOTdYVWlVU0lUMmNxSno1cFhm?=
 =?utf-8?B?UzBYelZWQU96ZGlSQjFWZUtLY2xoMzM0bnBrRVNXVGtIQjlERFNIWDg3anJE?=
 =?utf-8?B?YU54VmhPOGJGdWZYbzQzcFFSNnA1SThwTWE4ZmNlaDBRVWVTdUdkVUw3Q0hO?=
 =?utf-8?B?aW5xL2UrVW1SQi9KeWZZN1VOUnNkMUZxVU9tZUNYdmVCVmVndjNqQUV4bTc0?=
 =?utf-8?B?RjU5RlFGUjBpd2RCMUtPRllvQWVlYXl6V2JzektTU1loblh0UFhaRGs2SHV0?=
 =?utf-8?B?SzFzQkh0ejlSeElxSjV5OW5tZmg5NEI0L3lYU1FBVEpvdW5Od2puUkpnUHEr?=
 =?utf-8?B?aGJxc0dNcXhaS1U2Z3VsdG5xTlE2bzdVWGw3cFhLNDNkTzBFSkE0amRKbVow?=
 =?utf-8?B?dU5zSVRXRkViUnc5RGd5U0xyUGVIOHc2UFdZdUI3UjV1cjZVL29SRHlTWFRJ?=
 =?utf-8?B?Q2ZMUEI2SGFIRG1iK2RJYmtRditCL1dSdWxXYWdyaUpuUCtOaDFUTDluTkx0?=
 =?utf-8?Q?C8mgPMHYOw6K8ols=3D?=
X-Exchange-RoutingPolicyChecked: yXwyTc12e5OgvjR3732HqUZQLnn0mFFwF2xdXdCrRfajDZeNJzKXEBWraPXzkQfu4REZIo2mFFmiys6TWbaVHw/Ku1DPprvijov/K5zLE8Owz3AmFBQu9r9/T+7z1ZomxlWAbNttqH7RGapD/dWNxo4ACU7R0VH7uvA/zRTY5k6RVpb/1WpcVCcRZtfhLcmvPxMCKZEu+c2FUkciJEwKgqTYnWrTVbdONyQYcwkxqTmQRunz3IXwek9pMJCt0mQFx/cxJ3RJg8P51Ll1pn7P2d2aB7kjq8f4pShtBzowEAzZ6SpiA5EgMpT1A1N3iAgUuQRKgdQghsZYFGP4dPkT8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c8cf7f-6839-4ac1-8ca1-08df26fcf2b8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:33:15.7326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THNy355QKGKELQZLxolQnGo9iMlwDlzObcIvaFTQC/l6d9P3HMM8jiNQ7ytCe130Bg7SoU8tYEvjN9FtbVZzIBb5gwpRi5iiMw7DuSFJetw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
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

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Currently, when parsing ntuple flows, we may hit an empty L4 protocol item
> (i.e. one that does not have a mask or spec), in which case we just skip to
> the end. However, we do not set a protocol mask, which means we will not
> be matching L4 flows even though the flow structure implies that we should.
>
> Fix it by setting up match-by-protocol when we have an empty L4 flow.
>
> Additionally, there's a separate issue with how empty L4 protocol items are
> handled in that once we see one, we do not check whether there's anything
> else past it, and instead go straight to exit. This means that we might
> have any other flow item after L4 (e.g. ipv4 / tcp / gtp) and this will be
> silently accepted. Fix by enforcing that last item is END.
>
> Fixes: 46ea969177f3 ("net/ixgbe: add ntuple support to flow parser")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_flow.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 547c6621d3e..808d3b955d8 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -358,9 +358,28 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>   		return -rte_errno;
>   	}
>   
> +	/* an empty L4 item still implies its protocol */
>   	if ((item->type != RTE_FLOW_ITEM_TYPE_END) &&
>   		(!item->spec && !item->mask)) {
> -		goto action;
> +		uint8_t proto;
> +
> +		if (item->type == RTE_FLOW_ITEM_TYPE_TCP)
> +			proto = IPPROTO_TCP;
> +		else if (item->type == RTE_FLOW_ITEM_TYPE_UDP)
> +			proto = IPPROTO_UDP;
> +		else
> +			proto = IPPROTO_SCTP;
> +
> +		if (filter->proto_mask != 0 && filter->proto != proto) {
> +			*filter = (struct rte_eth_ntuple_filter){0};
> +			rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ITEM,
> +				item, "L4 item conflicts with IPv4 protocol");
> +			return -rte_errno;
> +		}
> +		filter->proto = proto;
> +		filter->proto_mask = UINT8_MAX;
> +		goto check_end;
>   	}
>   
>   	/* get the TCP/UDP/SCTP info */
> @@ -490,6 +509,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>   		goto action;
>   	}
>   
> +check_end:
>   	/* check if the next not void item is END */
>   	item = next_no_void_pattern(pattern, item);
>   	if (item->type != RTE_FLOW_ITEM_TYPE_END) {

-- 
Regards,
Vladimir

