Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451C9C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 09:22:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFF6740BA6;
	Fri, 25 Sep 2026 11:22:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C869040B9F;
 Fri, 25 Sep 2026 11:22:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790328128; x=1821864128;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SbfXRTS1P71MpTMShjcVrKU6XQ5gFCRaSjHZnlKbKDY=;
 b=Ltu/t+J5TMSEW4OI2yEJ4lSIoA+UguWjq5V0w5GRPd8Zbp6njczzSxIv
 Wnxu1cNcAlARTryNB+XwTPn8XgRY5Rr5lBUhpCOoncEzJjlpAdfAjCIqK
 V7YZqlmOcVPiqVIksNxg9H5G0Hl2GXrKyEZuUS4RqcbEICK1etX5xW3j2
 7vC36o0c2hoiNLBj4QuFNMRj2CmcifNzKOLDe0h6MOWOzpH7tgLBrcYtE
 Wgkgw4JCCgavmFKdfR6JMQwVVjsv38ILrj5UjdkWG36iTG+PjdFyxxj8s
 sZnWyP9SisC2KMKFhFzDp34h5OAlVehrS6Mbbvy3cTpPkjJrnCiv1hqQ9 A==;
X-CSE-ConnectionGUID: z/qvNr67QO22UqcxWcYmlw==
X-CSE-MsgGUID: c49Y505XTD+kQ6A5D/jYdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="94929696"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="94929696"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:22:07 -0700
X-CSE-ConnectionGUID: y5eIMpo/Sf2G6PY2HWoBsQ==
X-CSE-MsgGUID: OZCNQ0aSRe+QMLj37gZYEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282368469"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:22:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:22:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 02:22:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmxRBv31QOlmPSsDj3skXQgxi7B/Wpni7cYPfu58wVn6O3viqbGTqAKdcHGzIA/Ni5w26wUNnZWlBsT57Op3Z2p9SWF9245VRDm1CnlXXfcV+iayL0RvlUPizO4X7HUqRIBTy5wjBJeao3OxTHJozRJcyT6rP7STBHpD5Is9DNNIOFV65/4h0i/1Eu73aoGejFTrlH/GEByfdcZnj/FvSK2BnReLvBl120cOAtlmNdF4wJuIWHXzZRi0eDcKGY+IMe813L8AZh+UPK81AEgy93x4BhYiwLLOu9ZllQrqEWlUL81R4uHm/uphj2znPsovWY/JRn1LjjCVTH+xKTu04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HibgRL8pKLk5nbEPvQGhagqxz1FZtfxxqeLj56R4S8A=;
 b=XWlILPp/R6htixmzIcK9Vneb/UU/PMTaC8Oq8Phe0gVQNMZCZ256isbf3+2BqtiMCaJqEx9dvRmhVc/XrphwX5Pbqqb3G90AF9SiNgukrTouV/1X6vOtryBIxO+PNQfxT6mGAOiJTOfeMuJCqaI+ivg1p3wFFO3uoGD+SYgngevd5SsCc3If7AAAgVioK1hb1B2zKdIXpgKVIGsOu5y8UncVs2j5GqIV19Kk6TYQxyr+oSq0TgZz25iokzNKSElcaE5/4966d90MDwBvwj+zE8ttN/o94XvrfNjWS/RRXdJX94gkLQ44vxutozIZ5xglyUPGWrP1EhrblSTNZekl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Fri, 25 Sep 2026 09:21:59 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 09:21:59 +0000
Message-ID: <407bc750-9ea3-4675-bcf2-ddfe27c0eddc@intel.com>
Date: Fri, 25 Sep 2026 11:21:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/ice: check for missing fixed speed setting
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Kaiwen Deng <kaiwenx.deng@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>
References: <20260910150817.1521317-1-bruce.richardson@intel.com>
 <20260910150817.1521317-2-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260910150817.1521317-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0199.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::28) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 208ecf9b-22fe-45c1-7249-08df1ae6736f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rDk0Wi2mQ8VXEJn026SyeIiZnZ2YUfzLtLG0NxXwq3y+X+tov2BDw5kQ3B4dRD9DPBCdpRHPKbzTfZbmAJsH2vPqYopgtLCYjaaJ5LQ/+Cbz8MVTjGmYnPZze5F/iNtVTIn0h+9JExF0+I9bFtqmjKKrAFZc/LPR7QHNGtkv7UfIQyuVkP08HmsGNBB8mgDlXj5GwfPr2UYZfHzue4+7hdw1cKFt/yODpRbbflyRHh1j4OelxQlnbjpo75sdQ/pmUhKye8m0qO+UE8ORSNpR41fKt0F41zqMSfs+1n3XMN4z9x+kWr8t0MmC587S+Anet8UxlLolJhMiJE47Hd94zW57+Y3YKOytYOCj/OXMvPBnHEfzS0UFs/v4I6p0M2F71VuyZ+kzKvgEGooBBH9YQLdrDYEr7I1+0NEwX6hV3Qh8TyCgMsgj4Wh5qqyvFSOFzpyC0yKHh7+U0OfOh540kf4wLVlir2ugYk3zH+2B5vQZ0qX6ioovH3q2cGX0XRTLVSD3IR/imxgj0XJ1iEl+polGVTc9tVI4iVGrcm3px5w4YfImEJb1bwFYkE+tEXKwqnUOTOE0ikmWHoGJtIHP38H+j+bdHrnQRZrcCzHMEVf4hgyzuBesFwImQU/5hPllx/RusXxREpTc+GqphjufGmM62ySbDWxqJI/p4oBG70U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0VGNkNmcmh0QVJMampJSUY0MGowL3dhUEpxZVZsRmU5YkpHeXNRMU4yVEVT?=
 =?utf-8?B?YUdJVmVNVHlqMlJzTHBZcWlTaGV3YlNZTVdpWTAxWnJBUlVDWHBtUVhmR3Ji?=
 =?utf-8?B?NkJnOFFwYkNSL1BhTmtPNXVOOExaQWRFbGhkakg3R1E2ZG05dUtmNEZBVzBM?=
 =?utf-8?B?T2R0c1hValJHbUZKRDdUY1dtb1Bzdmh2bHdYQUdGdjVHaEc5MWxFcG1TRmgx?=
 =?utf-8?B?S3pYbUFERmxaQThzTHZsdElHVlBOUE5SMVNZK2FQZXQ3SHA2MWlJak1IM01x?=
 =?utf-8?B?ck1SQUF6QmI5Qi9ySDcrTmJmWVp3Y3YxdjJLL3lxNGxGa29UK1NFQkVOcWhp?=
 =?utf-8?B?MzBMcVhUUFlzc3U2ZitSMjlCanBUR2ozYkx5ZUVxTE1mMzEyWGFaVURiRnVp?=
 =?utf-8?B?b2toa3hnVm5ZcGV1VXpzTWJ0M0J1VEd3Qjh2UjJ3R3lpanBWRWROWXZrSzNZ?=
 =?utf-8?B?RTU2WVZ4Sjg1UlJVblJrbHNybG53NElwclZHTmF4ZDdNQVFCUDFjd29GYkh6?=
 =?utf-8?B?Q2FKZE1zdjVyOW9jSk45aUdBdi8wOHMxYzJPZTM5Y0MzcjFZVTJmN3dGWlA4?=
 =?utf-8?B?emJYQzdpRmFYOFpFVFQvam1Cd3dZUEhCUEVXYlo3MVB1K1hxOHFLNTFpWHpM?=
 =?utf-8?B?aDZTeGRmb3dQZ2Zic1oydTRKSWk0S3AxeFhReVg3V2wyL3o3SVRPZXVRdkhi?=
 =?utf-8?B?N05TSFdtanFkMGd6ZEx4MzdtN1pXQlJpWmVDVDVDdFNDa01tU1VFYXJmd1p3?=
 =?utf-8?B?UUhsZlpZMkVzUmdObk5IVGhDSUM3enY0VVpzQjN0NDM4Y3BFZFdrUjVTck42?=
 =?utf-8?B?OHhKMytmdXcyKzZVaXc5K0s4M1d3MHkwdFdhOG5DMVJXSlhJM2RDSlI5aGRD?=
 =?utf-8?B?TXhaVXlCbnA3MmRiSHdxTlJad01jMyszR1Z2RDUxcGxqV2Vac1NxdzVjNFpt?=
 =?utf-8?B?SHlGUkdxOWk1YjN5dERuMFZQU3R1dU1UU0pxZGNqdUlBL2lKUVdHcWp2SzNX?=
 =?utf-8?B?OW43bGd3dUExRHducngzazcrdjA0MS9CWHBIQng0d1hGYjBNb3ZMcHhvQzZv?=
 =?utf-8?B?ZkZZVHBtb1psZE9SMk51YXlCeU9aWnNFQTljTDFtQTlBdm94aDkvdHBaSW5s?=
 =?utf-8?B?Nng5Nksvd21KRU5sanp2TlptUnFkUlFUQm1YU2ZJNzVQcEphSnk1b3RsWFhy?=
 =?utf-8?B?TTZWN2x0eVlZUTAvR09HOXNkTGRmaHR4MVVOWnZtVnZKbG5qWEYwL0RmU3A1?=
 =?utf-8?B?SkpLd1piTXR0ZTErRTF5UC80dE9tMHhHWFpDOE9ETUJqa2ZVemc4OS82aC9M?=
 =?utf-8?B?Y0VFdVdzTG94M3J2R1M1cWtRR1B3eVNtbHRqWS92eE5neEpOV0F6OWk5MGo4?=
 =?utf-8?B?bmxGUjJTMzZsNlk3aWFUaFhwWXZ2bWFGNjFQeWNCWFlhVXFEYVJycGRlRWFX?=
 =?utf-8?B?eS9WTHU5aHpQMXlnWnFaRVdSSDh3OHliVUxLU0FOT0xHcHdOcWpNQlRJSTdL?=
 =?utf-8?B?WVFnS0FiRStFMnFmMEo2dzR3REFuTmcxVFNndEZJbER0MFRwTng0SWs1NHRu?=
 =?utf-8?B?M0xpNmpNQityMFZPKzVLbDhmU3RPK1ZWSm95emFwT2ZxYy8vMEx0S3BDS3l3?=
 =?utf-8?B?QlpZdm1KRXVjckhKL2VNaEd3VGVhSllCMWFXN0QyUzZPak9VUmIxUWJWV3lU?=
 =?utf-8?B?WnpxdmNmNjdqU0MxRWpFMThKTW12WmJpdlhwMDBWdGt4dElwdTlMUXVqZnUx?=
 =?utf-8?B?Rk8yUUtVM1h4TUQyd2pFRmhROEJSYmtTREM2OVhRUkxEZGRuUzZvUlFidUlp?=
 =?utf-8?B?dVpyb2JjMmhJeWpGSjlGUDZ5clMycWxLQ3lMRk9obnVkMjNXUnNPNFN0Yzdq?=
 =?utf-8?B?T1lBSHAyYkJXNmJyb05Lc3lidkd0QmJHUDB0akJyQ3Rxb0pJUTl4VUVCUDBF?=
 =?utf-8?B?S01tM0cybVVpT1FoRUkxa1VwMWNhSEFPWjNCV1hMRFQzSlpQRDRKNG1BZmNT?=
 =?utf-8?B?eUZzazFDWkhjK3o3UUZJS3k2ZlBhSVBHSHgzRXpIQXFBTnA2cERRUWxXM1pn?=
 =?utf-8?B?TmJHQlNHb3BNSzQyQVh0N2ZmYnlTYW1qR1hKZDhuaVdIS3R4SVMrT1dCQklr?=
 =?utf-8?B?b3hkVXo5cU9HRW00Z2t2cksweS9EZ0tqY1dpSXpod0htcUpkeHhIY2lLZW5x?=
 =?utf-8?B?aWkxL0tIOWtEQ2FNc3VvdWpnVnNkSUJYVFQyVVdBNFVhVUgyM1YxOGVlbVRl?=
 =?utf-8?B?UmtpV1d0dndYMzIzN2duZWFhLzAxcHZnNHNJb0NabDZ3Si94cGZoakUzeDlx?=
 =?utf-8?B?WmJLazVPdzEzc2YvTmlBcktwWS9zQittNEI5ZTFseEtKTTk5NlV1cVFMNXFi?=
 =?utf-8?Q?u16lh666aZ1aSJHs=3D?=
X-Exchange-RoutingPolicyChecked: eFFNwS9L8f7O+/j4q768O7F2PuSSC1H/z3fUbnSab8oxKiPDo2qQ8niO1fFYxjOX+G9KIQ7UX3lIHX4Ce2n0dvzKzJGN2cwLktdo5Xe9TyAc6CgC0J3fmPmiNI6DX8Q36peqHq/8ZYCeVaSz/BSsZDai4QQ/ZYm2+NyNM5gua3KeRbRexvA/xyv8lKtAWLoZXZHIf4ew9A3sSyc8gB1/gLUzbbUTaAZxafV5SygzRH/cJBd6cTIgcUjQ7nUcw6kzS6LcVQSt3U0zTHCR3mzi+7XZYfNaZPPgGEpj2zQS7fA5NzFbycP/gJcHaf9dJvd43zMlP44a2Q3d/X40V0doVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 208ecf9b-22fe-45c1-7249-08df1ae6736f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:21:59.3238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYKkzCw4dP+NEjiABI8fYQso5WvxdG8csnpcMWiEzpkXeh35vDjguk/FM2BFC/WtiUGkXGrmARuZlqIW5muPAEUROeIPC2C9n6t/XJPU4/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
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

On 9/10/2026 5:08 PM, Bruce Richardson wrote:
> When the user requests a fixed speed for a NIC link, the speeds bitmask
> passed must have a speed value actually set in it, as well as the
> "FIXED" flag. Catch this case and log an error message.
> 
> Fixes: 36afbc269081 ("net/ice: support link speed change")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/ice/ice_ethdev.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 76b8ff0a72..dc955d130b 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4936,6 +4936,10 @@ ice_apply_link_speed(struct rte_eth_dev *dev)
>   					RTE_ETH_LINK_SPEED_100M;
>   	}
>   	speed = ice_parse_link_speeds(conf->link_speeds);
> +	if (speed == ICE_AQ_LINK_SPEED_UNKNOWN) {
> +		PMD_DRV_LOG(ERR, "No valid link speed setting specified");
> +		return -EINVAL;
> +	}
>   
>   	return ice_phy_conf_link(hw, speed, true);
>   }

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
