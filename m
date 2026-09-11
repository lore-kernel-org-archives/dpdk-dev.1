Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8EEC88E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 14:32:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7555842D7D;
	Fri, 11 Sep 2026 16:32:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BCCC642D35;
 Fri, 11 Sep 2026 16:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789137135; x=1820673135;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qx8PjnRGYxp2nKZchidIT0X1JeCSHb6Vp3c4YLKKBTU=;
 b=ZIClaNAQBxHOZEuH/RXrRpD45WNBV7elsX1beChEUdP5NmJ7KVbbxGRF
 b5Xla1MFUD5WsOzy0NiwafEvjYCbCR8/53XRldxydzG9lDUfEnbmdgw+H
 yVYxIm50g97IazccUThPbuS0+hxfSTgdxGYdDMumuZbrwxr2VAk3Oo9wt
 bLzjOHHJkA7m7t44/fNSeO1l9eq5pTe60SBwH6bKlsctFkVoJ4XsW1syo
 9+94h80zfAAh5OlB7NbqM6gWse7+1J8Ozxhd0kyB9Ti7EKpeoEH1l8uPc
 RLqBS8BjKaEJeXVBsjSJgbOa4PxyBrDJ30FUKbX2Zf/vilB8iI4T9LsS9 A==;
X-CSE-ConnectionGUID: qRw0SIJiTHauekjI4wiaUA==
X-CSE-MsgGUID: obTu1LjfQ+uEHKOUP8+pPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="106969012"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="106969012"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 07:32:13 -0700
X-CSE-ConnectionGUID: +Sd9hBBCSOiRWgxNdfHLyg==
X-CSE-MsgGUID: PeWhZxogQ0GsKkRD0MMytA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="269336579"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 07:32:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 07:32:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 07:32:12 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 07:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdRuaxLGlPUcnlnQIXokxR9OrL6r1J2SVFqph8kYLEOTHet4TUPvo84lRyAclaF5uKqvoHySchuFNWy7X4nTJp3sRZO1bB5XNunQkFJDFm1Pa/Bn5xjriddz4HEtHtnzJS9ps0qlY4BEgbL+89X3VUUfJxxDhTvKDvL3E9n7+FFhfjZHF7lovrFkNlWqdhX1PQuz+3rFC0vQYvd8HO+5BW4qMbfSEDieOY3m7i4vthKxoWKZQKvq9xwfqoPMV08ROync3AjROB+bipRlqaICVDLc1d10LewfR/rOJt58z/EZmJia+zIOrD8HXHogCRYGlZO8JiKMrkqNB04XgOXKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqBPQLQi/P5Eiz7w6qV+tDt7zyM3WECXx3BG1NHy2gg=;
 b=RsDGCCVD/DfWTsQgPjuz7+HImhoKFWdlsfDcj1g98+ICRouXkA7kRPHljAWkiYj5xUZ1EQoXFaPwjeHHAceoU95i295vmDnB+k4yLzZ6W7ZfyXfd52OA3FNE6JJYoDtMRMblWly/9JZrOnJSnltbaCbWxW+r1WnzGF2rxpz4jTeoIzqBRACLNInyo4WjFAdhSG6IbGiR4FuPmqrm7frwOoHo8QgwEUEuvgUOZU2beb28xnDbj5ELt7TIfmftaFHJWSqP9+C+0Mv0q8a2TEoHPb8GA2mMATfDv/1Tii+JMgtb4YErsQ470xNnXrhPmVMo2a1kShY67j6rWOR3Xti84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV4PPFDC496280F.namprd11.prod.outlook.com
 (2603:10b6:40f:fc02::22e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:32:09 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:32:08 +0000
Date: Fri, 11 Sep 2026 15:32:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix missing error handling for QinQ filter
Message-ID: <aqQQ4_WVq5_7do3Z@bricha3-mobl1.ger.corp.intel.com>
References: <20260911094043.1683329-1-bruce.richardson@intel.com>
 <d2b9b9da-f238-4207-8f4f-4476afe98014@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d2b9b9da-f238-4207-8f4f-4476afe98014@intel.com>
X-ClientProxiedBy: DU7PR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV4PPFDC496280F:EE_
X-MS-Office365-Filtering-Correlation-Id: 09692972-ccc0-4ebd-eb86-08df10117530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: z4UbL4jsidseiZhCFIjw0K1HnWto1P55wdJWolKQ0K16hlEZ6lmZVux8EAR8hUGRiJmR9Kc4Ljp0QVDwZRc8qgWfxzNLc8OpZ8a1bRPbs1TQdT6yoMVHZmj5mvxChARepFBbdVJAFib4V0eE3ZFP8yW4OwUBBTjmTzcMRGELug9LIag2V5SRm+mhRedjrH7+WWPSzwNRhegR503oqigRxR3MBGwObAVvm3g3c5ggdt/Ni86DQ5IqRueG57TM/DjTiCY6XW5RBZMqiZpMa1t7hCaN3SCe2nJBVpeHIeWvmwRFaDigkUNakkYx6hpwqceLRqfAZ188jdGVeA4oeKRugJZDV1L/Rr7yUu9GjAr95YiYHCWKRoSvE8kqSKSkw8IVYGZB87QDCXYciB9m1VISTU5OwUkWBVa44f8OZpwXKoZqNrmJeg+/qQLA4ra7qBx/GHEK7BkxPoc/ApjQBibw9dr5v30ceH7mcQM5s2Utjo6DsXFXv/TDOQxdpm+/ZuOYMHJOeQGmktL8yklz+UX4m07GDCIImOW1okZjRdzE47vDpf7CCqCxjg99kUdxBIhWrdB0/HiNupBV+8AstuJ3U/vE4MIVw1ISPN64VBfjyS7ysTwIf21EzqwARyVGQiIToU9BI8sPrvnROfgpiU0kvwTF88+5yzmn1JSiyHe3M/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGFydMgAKBjB0dHU/QCuiF0bCkmGfTXb+8e0OGqulr8igCEOUducgWetf/rh?=
 =?us-ascii?Q?wlkTdpDwFy5cRqlbuluOQeMaPxe0MngHU43/QDkvv7IwfRjbuTo9IHykz2qt?=
 =?us-ascii?Q?39/AyOEcdnKQfxD6U2xP2qIdQ3XTf6WPTP4aq+OVFtSc6TwfT3/ueOLc5Pbo?=
 =?us-ascii?Q?pXK57Wh5oUK8FM2dYuBj5zJvrrOLIv/5b0Onbqw7cK0J7raKq0h5SlJ9XUqu?=
 =?us-ascii?Q?3J3BVWx5uxm09krkG92P2/azL89Um1zfb4UXDUE+brH4eYLivT+K1ClFicIK?=
 =?us-ascii?Q?KOF0LTZkwwpCfoZR/S25hndHg0UIGrOQbU5DJIpQP6MKpaGWAQ8d1AhWmHap?=
 =?us-ascii?Q?U0K4cO36zqjW6FC/IstCIMAJB46Mv2OkWMzJkHRc5USPqSFyKSkIaxR/1WED?=
 =?us-ascii?Q?4irFWRR6iyrZ1wuZsP80mreGjQVmbVTMeYDhpALPZIUky4QI9NgoBEX4XnFM?=
 =?us-ascii?Q?PUvy1U3rKh5nKbmMOqyT4A/e0m97wGpEPWFaSLkdT7M2+L7W9l/K2n0mru6c?=
 =?us-ascii?Q?9MQaO7Y5+5ZbjkI/WBP1OIXtp5sseyqY9YxAsQgRCA4b3BTDzTrDlL0cDJxK?=
 =?us-ascii?Q?n98RvWixnm1RxhoZI8oU8QZHRZk1Ro1akmL0bRA0fKwX64PiaEczbgegY2vu?=
 =?us-ascii?Q?1sYpEuex22gqfXJ1qIudQ13xyowEfnlpW4xC3kollL09l4wZAzZ3By1Wgpdm?=
 =?us-ascii?Q?WfBlFO0ZmYLiyvftV+oc6Ipjcb6yj2fGyz2sxkLP6AfT9egcLMvLUTFfYdHt?=
 =?us-ascii?Q?CLasPjZiXtpVk/r0zUO5WrLbBI4guHp5Od9TpmzWmxHeSZ8M4ajQpLhDjgQB?=
 =?us-ascii?Q?t5Id5w+fp7YRyycYsNVpAPQOxmP689Ohn4HiublYeUyAAtU/CLK6uWpHopQq?=
 =?us-ascii?Q?Yo4bv/FatWrsqI/mSGDQ8f0WY6eBZYuXE5r0awJYkyXZ+rvjQ4eXtesESFJA?=
 =?us-ascii?Q?yIKp4+xaw9wyuumMaY+kUlPlOBOt5ahaRwTLrjWlYEXs0X6NeGieidOzwajm?=
 =?us-ascii?Q?jQTCPmVA1YKdYR9unhVfqBqcY6nkMTGbktTJvQKNIVKTsuxiUHEOjyk5SzA0?=
 =?us-ascii?Q?BUspCup+uxWi/MZ6CTtypHD0aaqIWikW/mY3EwtQbjfM/36W7wIriSvsPjV+?=
 =?us-ascii?Q?U4WltOw7+lPFFYTJhPMpNIfIxXEIZhPJ4+PlftC4N5UdIqXW3beC4iMMbB1x?=
 =?us-ascii?Q?J6K+SoBsP68hThmBRLjj3S5vtDyyhxArWl4dRnXAl1+cdgBtcpwBI39tBZlM?=
 =?us-ascii?Q?LqTv9KvzqAa+379w2s0+pTrMRcx2TJwlVK8uJW6OBYtA/z8BCEYhZTMI9ucB?=
 =?us-ascii?Q?WV6xPGf3bhvFKonD3ns8+SD97NqupjtfN4ujqewgv8VqE9bQNvxD0tLaH2pB?=
 =?us-ascii?Q?JFSCDAUTzgx0nLXUA9FVpa5ayvlo5UYIMSing6eRXaSqzdG43zAXQqknnNj1?=
 =?us-ascii?Q?T3KgU6xkAKlg9S5RNBUYw6Mbfm/lFp5VBiZ87YYGQNPRqznsxZExjkaIvDDC?=
 =?us-ascii?Q?122B6O3zUOiWHiudNOBEXDJxS8k3qyArAjy2ZvAo4yQoqTPgp9X9SG8y+cl2?=
 =?us-ascii?Q?yjxUqHLZ+Vee1eTKPWmF93YLgA8KA+Vw1FVeBeQL0cGIM0mr4WqdzPMWkodh?=
 =?us-ascii?Q?29m38KYHPycI1/Sfw1MrR2gDQnsz3LeW4KFZw7t3PVdeWJ6L9VAJqVfG0H70?=
 =?us-ascii?Q?NY9JOnOtkghI2hP3GPTP44H7kTalgx8p8QMMbfVt7i9YKSjAu8RBkhbjuaHF?=
 =?us-ascii?Q?anWoMzT3W+XzRnts8p+wDA81fInaF6U=3D?=
X-Exchange-RoutingPolicyChecked: R7LKdISCicOymAQwpbRczkhvoyXOXBjyxWwELvwnTT15qUipEU9Zjto3BB62joXeW/uWdoaWGkp7u/bR3AuQ1HCDGgVx1fUt0hUT7j0ycis+LBsX+ni53X20gdhrt+fDyl2NRwjcDx1tUxJs/V+rRwClkbYrE9VguIBVOp0f8Vf63B9Gf1IT2TUNgWv03Zs8GoZja4Gu7PzebzpU6eORNGoAfzgj7tvSGBd8MHpVXtyckG+86bo0TmWE6V5H7vnHmJ5O/pnkggo4Hq5KcprGrS0Zbwy3WlxXSrYStI82wR94M1Fzz7QLYovl1uuduTBog6ZUoe5H4Z9zMfrW8hRlWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09692972-ccc0-4ebd-eb86-08df10117530
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 14:32:08.1188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k60zYcqBNssQ6riuoLxExMj0lOmb1wQxfdgfw+wnJNRShKl3u5TwQErz+qC9NZ41monYePuB+8o/R6ak1Jw2GQz6N7S1KpEQfwyfNKO0a2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPFDC496280F
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

On Fri, Sep 11, 2026 at 01:16:57PM +0200, Burakov, Anatoly wrote:
> On 9/11/2026 11:40 AM, Bruce Richardson wrote:
> > When installing a QinQ tunnel filter, errors were not properly caught
> > leading to the situation where the app got a successful return code even
> > though the filter was not properly installed. Add an appropriate log
> > message and error return code on error to fix.
> > 
> > Fixes: 116b7910d641 ("net/i40e: add QinQ filter create function")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >   drivers/net/intel/i40e/i40e_ethdev.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> > index b6b2d291ee..c91abe7626 100644
> > --- a/drivers/net/intel/i40e/i40e_ethdev.c
> > +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> > @@ -8597,9 +8597,11 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
> >   	case I40E_TUNNEL_TYPE_QINQ:
> >   		if (!pf->qinq_replace_flag) {
> >   			ret = i40e_cloud_filter_qinq_create(pf);
> > -			if (ret < 0)
> > -				PMD_DRV_LOG(DEBUG,
> > -					    "QinQ tunnel filter already created.");
> > +			if (ret < 0) {
> > +				PMD_DRV_LOG(ERR, "Failed to create QinQ tunnel filter.");
> > +				/* ret is a raw i40e_status_code, not an errno */
> > +				return -ENOTSUP;
> > +			}
> >   			pf->qinq_replace_flag = 1;
> >   		}
> >   		/*	Add in the General fields the values of
> 
> Returning ENOTSUP unconditionally seemed unwarranted to me, so I dug into
> the code to see what sort of errors we might see. The function in question
> actually mixes return values (default value is `-ENOTSUP` which is -95, but
> most errors from that codepath return `I40E_NOT_SUPPORTED` which is -64),
> but most of them indeed boil down to ENOTSUP (except for status returned
> from call into AQ command).
> 
> So, although not ideal, this is probably consistent with current
> implementation
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel.

/Bruce
