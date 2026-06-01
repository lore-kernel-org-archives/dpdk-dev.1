Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B2BCD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AB2D4025F;
	Mon,  1 Jun 2026 11:14:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 370C74025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780305294; x=1811841294;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mKA9XytzNdHhUfCUpg+zJv5xEjlFhNiLieEFmzyzr6o=;
 b=oBdaYA77yf+jAY57Kc3JnRHw6CaRCOQvn/CE3t4ZAAZHeEDoLZ6DY1jb
 kRbsRXPOf1DsFkhL8NyCxlj6yoBPKOERU/eYJHNhx07O7wYC85BztQSzG
 u5cgrxbATrLcUlvfaVcXj2hiyZ1gMye1S0kwKrQyuYx+WdgK58eV+UD8Y
 NFHnLNLApk5aMRnIgMMGWkGqxAbmhqCtK3kagPbri0KLXjHc/LSgab6oj
 bHXXrGXKZoETzpvUgs76j+1S7Uvln3bzDGeRRVRJ6QEUbnMizFV5qrr45
 7Ry4UA6EiaZiIjtwMTBn3CG7gH8tvYQNJas4mL4C2nE1Mm6atKjKrDiPn Q==;
X-CSE-ConnectionGUID: ZRu0LQdNSeqVGXXWlOpjZQ==
X-CSE-MsgGUID: OsAt4WgNSKCG+raqKDcwRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84947683"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="84947683"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 02:14:53 -0700
X-CSE-ConnectionGUID: 53SgrwRTRHGm66WCP6R2UQ==
X-CSE-MsgGUID: LHzMUhO8TTmaihPu9WTWbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="243618091"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 02:14:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:14:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:14:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbs3swZ35yPEbKEIcbAcedGu/TbHoJlDRn2XxGGQZTKS/SiS1aFXS64jtCACVWyJqBULPaDVUVP6/RUOGrtuykHYPdcOO/Pu1s9nakwOSkWbTTzu4hF5+NSmDPMJ42p7HFXpiKakQ3MhbsznrKeOoLaiIyUEN/kkQTbOpf0Ub1H1fVcjYkp4phQ1DwZahZT0fQL71KOy6yYcnBt+0mlTIC5FW3qMg5qZzBwC+7/Luol/rtm876idcXIwxiKHHjLseydhNFXdw9dI0saNIiWjMi3uHDJJKvTZAQr1CCCGRqf9n6Y1won6sKEzdoPzfDMUU/jAeGMy3wl/aGfqHJ7cnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqDSralDiOkr+IqljprMoQ1rX0a3xrBl/It2ri1H/5Q=;
 b=n29wBmGadUv8PFtZcUoKnf5W204cbSADtQl+mseNty5MyoBDFMFq+yYfMYd427Hd1Xjs/D1VcBXLP43hDaPZW66BeOJq5V3II/IY7D0RpDHiuqabQ2s5xfSKHWLN/UNfeG8ofbm58zkRQfdlG0mHjHY/ACmTzTn9NLBm7u+pzjz4ZdKDHNJryfxunGUqMZ1JJXZSZXa7S2XAY5Xj0yyPcpxMZg1Fc1iL9yNM5xf32eLTCfbh6nBYds/udTQc20640YfpyoovjnSqz297RU51ifnxSm9FKhYCqFaj0gKouLfRN3Hg79/6FpdIO09jizscjzNp81B0eF2vCVqSm77nhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB7667.namprd11.prod.outlook.com (2603:10b6:806:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 1 Jun 2026
 09:14:50 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:14:50 +0000
Message-ID: <8b46f61d-062b-427c-8701-11c0d5b58d26@intel.com>
Date: Mon, 1 Jun 2026 11:14:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] eal/memory: add page size VA limits EAL parameter
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
 <968ab78a3f7bd130287e269dfe82a3481baab161.1773417833.git.anatoly.burakov@intel.com>
 <ahXHZx25kPDmjkMD@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <ahXHZx25kPDmjkMD@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 83396326-de1e-48d5-2a90-08debfbe3c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|6133799003|3023799007|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LxS+7q87AzBCTf4Jt72TJO1hTVlcQ3Tl+iw5CegBJm30SplI8NJ+kCE8dG0nnJsGOvLG+EKw/LrZkLC4hL1x+2MuPVXutiFXUlhBorVP1DRG5NBo7dMeAj5be719dfRycPhl4lsL5TUyzceMT8ccjzpQrCgEYMVAjpz8sw0SKHkUwZOmUm1cbjR4Ujh8HBmrVYCuRGF9zJVDlkgIadZ4F/cHgvAmf4mkgN/AUUr3FqqKFVplb03SPwJO4kUQkAECwShBWJDLkFkdvwwOGkCJLR6EeNi7M7Owsyx64G+8jBWqCTKaXHrzDHDyh8nfBAYKV38TJkMNae+CojgIhz31lV8fXUCKHtjy8WbhxNeRJB21OOIDxXtB9K9QTZWFZR31xfrVZU1wZERwVF/tFuWyVS2UPlaaOBHC8MbnJeZN20RTcvfv/V4i/5rzLk1G/QpSEQ+zMKpyIn6toOEoq17fCkRxKyP24qaXhS9rRo2LY/1UJmmQwgJD0VRZAemRFegWgxdvjV/vEUe5sU74882TgvCgEakUhtXU3GJInow85gQXo09gtpb5EFFfvDXU5csJSOkLHKyi4wuIBvnDcEy9WBADAxF6i1XS8yx764wEaGLqf/sVWzJ5nXGE/eHq6yAEHklGj58iCa/gAXg1dZEqtVfgwjTM/zPqPPPYNDXes/oVNilEJaywtmMvK9SkwI7I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(6133799003)(3023799007)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDZRVDVkNFlhQjZaYm1INCtCUEdydjJSRTY4Y3B3YUpveGxlSXgycjdBcTZh?=
 =?utf-8?B?ZjNQcFJ0V2dWRE5sdjlMUEhFSDNNOEsrOXBjcXMremFuSW9RY1NqY0lydERO?=
 =?utf-8?B?SkVNbWE1Vm94aHNacDdyRCt5ZHpNL1R1ajd0S2lHYzRLUk5GSW0xTUZkL0cv?=
 =?utf-8?B?bzhyWEVLYXg0NytETFpab3RQZGlmMm9sRFo5Ykcwd1lFWGR2MUM4ajNyblV1?=
 =?utf-8?B?Mm4rTkhpU3VhdkhxeXBBYkNiWFh4OS8rM2NoQmR5aC9oSmFMaFdrNjBvV3Ey?=
 =?utf-8?B?cGprUk5xNnd2Z2J5dGNOR2lWM3R6Y1R5M3lValJMNmZXSWI5OEVFbWdXaVE5?=
 =?utf-8?B?a3NTcUtBa082S2JtSnpVS1dsV0pCYUJPQVBkM1hwU3Rjbm9ZNFJYdExNMGhK?=
 =?utf-8?B?L0FJSEtVaWowcmg0a0xBbEM5VmhoeEkxQktZQkp2MzZWWUxiTXJ3aWpMQmNR?=
 =?utf-8?B?ZXU2bEZIWVltSW50MGgwdThsYmJJWDhKOUZ0TzBoQzkwYWJ0VGRDWVpLbEFi?=
 =?utf-8?B?aVM1anRDbjhZZXc2dzQxby9nSUh0NzIwbnZsUFQrdmJIcXB5cjlKb0tmbUpT?=
 =?utf-8?B?TVYvT0h0cWZsMytvNTFySkJkaWIramY1UHFrZGNXK1lUaDFXeTJSeHh3WHhZ?=
 =?utf-8?B?MWVyRkVqdk1yUGlvc0svREJRaDYvVGN6eEEzaTFnR1ExakJHZ1J4WURmREs0?=
 =?utf-8?B?a2pkMkh0bU90TndzSTRneGxBay9UbGQ5bVNQYXd1ejBPUGNMMCtZSUM2M21D?=
 =?utf-8?B?dHNXYVViMUQ2YWVBZ3ZCbEduVUJyQmEzenVqZXJBYkc5Mys3N3ZxeWRmQmNq?=
 =?utf-8?B?eHJEWmZ3ZkhJbEF5dFJnRHZSc0ZaZ2IxekZmYUYvNTExUURoOXQ4VHFlTzJo?=
 =?utf-8?B?SklXQ01rYXpFMThlRitxL3BBV2hZL3gvLzNsUElLQndiOFk4cjFUMkFJVWFF?=
 =?utf-8?B?VWg3QS9mK3BqK0dDa2hBL1ZkOG00czE5MXVacTJSYzNOQlhzNnpwV1p0blcy?=
 =?utf-8?B?VENFSFlpc095NEdMdmVLMFF1TDlhVUVFY0kxZjVWUTVnZ1VuKzBLS1NaRTFt?=
 =?utf-8?B?VlBzRVh1YlBrdzJXamdUWENjNUhUdzlscEdoVVUySHRTTjE1UURYN2Nqb3Bn?=
 =?utf-8?B?ZnJYL2VpRHIwRE9LZndVMENiNEo2ZGZvQXZTZlBsdU50ZCs2aENXTFFZeGla?=
 =?utf-8?B?UE1wYllYNmo4UTU0VmpHaWhQUGlWRURYemZaYm5uSVJjZVVvc2swOTNiUVRM?=
 =?utf-8?B?NWozRllLcnRYR1hUNWt5Y2pDK2NMSlF4a1BkZWZRMTJzdGdlNnBXTnY5VTF4?=
 =?utf-8?B?V0ZyL0FKeGNYYlJBcTZra2M0NGxyVXhabWZaQkdldnhwY01yZVVLTjhzbUQ2?=
 =?utf-8?B?Ty9SM2pPNUwwZTVMWnpsenV6ZjNRYWVPOFNMZllTWkg2R2J0RXl5MnpRVWhD?=
 =?utf-8?B?V2o4anFERVY1aVZ4SkRXOEJwOEJGclpuNy9UVHd0bE13SGhUUEQvZEsrZTYx?=
 =?utf-8?B?SWJ6N2Y2MXdZWGdhVVBZU3FJWUw3WUFnRnlSSHV4M0pOYm4wMUJKY2tkcXJm?=
 =?utf-8?B?cGZHSDV5dG8rSzN1T1pySC9OU3F2c2s0eFZ2dmtnN1pxaVZ3RnRrSlluZ21y?=
 =?utf-8?B?Y3AwbUJhRjlzcFJjVlhGUUhRUUdNVFJ2ZEdIWHNkcXordUlIeFZCSEp6MXU5?=
 =?utf-8?B?bEQrNzY3ZVRkejkrcXVGa1BzSm9QODIzVHo5Z0JMSmNUaGtXWklUd2ZFeHpN?=
 =?utf-8?B?bEo4VTJ4UmhoMm5BK0x0ZUx2ekViaktRRlY0QWo5eWRNWmEzVWI1dEpZN1Na?=
 =?utf-8?B?b1NuK0w3K0EyYmVnYUc1bVZYSFpDd2h4cDM3cGhSZ29EQ3V0K0VrT24wZDcr?=
 =?utf-8?B?anAxRDdLWW1RZ1dJbG1rMXNjclV2QnFUaEVlTEZWVSsrcTR0d1FXWlNIOEpD?=
 =?utf-8?B?aHErRWp3NDl6WDg3bkwzOXRxSVUzUTBjNGRuSEhhSGphUjUvNmxCQnBCSmU1?=
 =?utf-8?B?emk1Qm90aUp6UFFEekZPdDcrUFlGUkxMK3NBRVkya0JrbUcrRVBuOGF6SE9X?=
 =?utf-8?B?QUd5aUZMRlNUdk1Pdlhkc0ZmbHhsdEdNSDZaMjBaZ0xnajE1anFCcnI3MFd1?=
 =?utf-8?B?MmtNV3Y3RVZhVWJnZ1RzcnZZZ2xROFJpaWd6cmNmeXBkZFlJY3pSNDNPSUlk?=
 =?utf-8?B?cmQrWEc2RmVZc0VqT3VZNU9HT0VmVWhqeGJRV082Z0wvME16bkY1ZXg0elg2?=
 =?utf-8?B?WlNpOU55WGlMSjBTc09QUFpJdEJzSHZ5a0N3emJ2Z0VySlV2TE8vQXN3T3FL?=
 =?utf-8?B?RDZLdlN3VnY3bVlPM1l4eGJvT2RicWFRejFQckpRSGUvc29INXZ0TW9mTjVI?=
 =?utf-8?Q?qHWuZLQ2hxKFtLOQ=3D?=
X-Exchange-RoutingPolicyChecked: aP5kWZBgKG32doUabuwd67omElB8UXtJgQ3cJ2kHg6p93LFFZdyOkr1TYTdF7eCP5xo9R9LCUoh8oPxaBIsrJS6/9qeFce0bMhxWY59bpzKHt/d9/wQilHWWSmYz8RsXCd8pHc2quu9QgoehnNQOlkFkmPX+n9MwksUpDdf2DbGWBs4nJ2DdeXRqn0K3dR9MvkDm+EkyPvTw7Ad90KjkqSr7uWyyUsIQK1FrihJGAxfjLQ2cKB+yu5kxs1iBAqOa2ynyPMQ0G42nVxL+CbIgXuiyQITNai6VfNt9lZXTTCaapsz8t4poPf/L7rsQoFx46y3+PHORAV8IS0BrINlOUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83396326-de1e-48d5-2a90-08debfbe3c0e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:14:50.6986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzniuEmcJjygOW0P/wzan4aAHYgg/Ul3CKMancM9ikG45n6KOS/EwbYecx2bS5soRqxs3NcQkZGG7NZVAutJOQzyJ4iLXmFhS9MKfEl2bUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7667
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

On 5/26/2026 6:16 PM, Bruce Richardson wrote:
> On Fri, Mar 13, 2026 at 04:06:37PM +0000, Anatoly Burakov wrote:
>> Currently, the VA space limits placed on DPDK memory are only informed by
>> the default configuration coming from `rte_config.h` file. Add an EAL flag
>> to specify per-page size memory limits explicitly, thereby overriding the
>> default VA space reservations.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 

Hi Bruce,

>> +static int
>> +eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
>> +{
>> +	char strval_cpy[1024];
>> +	char *fields[3];
>> +	char *pagesz_str, *mem_str;
>> +	int arg_num;
>> +	int len;
>> +	unsigned int i;
>> +	uint64_t pagesz, mem_limit;
>> +	struct pagesz_mem_override *pmo;
>> +
>> +	len = strnlen(strval, 1024);
>> +	if (len >= 1024) {
>> +		EAL_LOG(ERR, "--pagesz-mem parameter is too long");
>> +		return -1;
>> +	}
>> +
>> +	rte_strlcpy(strval_cpy, strval, sizeof(strval_cpy));
>> +
>> +	/* parse exactly one pagesz:mem pair per --pagesz-mem option */
>> +	arg_num = rte_strsplit(strval_cpy, len, fields, RTE_DIM(fields), ':');
>> +	if (arg_num != 2 || fields[0][0] == '\0' || fields[1][0] == '\0') {
>> +		EAL_LOG(ERR, "--pagesz-mem parameter format is invalid, expected <pagesz>:<limit>");
>> +		return -1;
>> +	}
>> +	pagesz_str = fields[0];
>> +	mem_str = fields[1];
>> +
>> +	/* reject accidental multiple pairs in one option */
>> +	if (strchr(mem_str, ',') != NULL) {
>> +		EAL_LOG(ERR, "--pagesz-mem accepts one <pagesz>:<limit> pair per option");
>> +		return -1;
>> +	}
> 
> If multiple options are given, then the rte_strsplit should return >2 when
> splitting on ":". I'd suggest checking for the comma first, before even
> doing the strlcpy.
> 
>> +
>> +	/* parse page size */
>> +	errno = 0;
>> +	pagesz = rte_str_to_size(pagesz_str);
>> +	if (pagesz == 0 || errno != 0) {
>> +		EAL_LOG(ERR, "invalid page size in --pagesz-mem: '%s'", pagesz_str);
>> +		return -1;
>> +	}
>> +	if (!rte_is_power_of_2(pagesz)) {
>> +		EAL_LOG(ERR, "invalid page size in --pagesz-mem: '%s' (must be a power of two)",
>> +			pagesz_str);
>> +		return -1;
>> +	}
>> +
>> +	/* parse memory limit (0 is valid: disables allocation for this page size) */
>> +	errno = 0;
>> +	mem_limit = rte_str_to_size(mem_str);
>> +	if (errno != 0) {
>> +		EAL_LOG(ERR, "invalid memory limit in --pagesz-mem: '%s'", mem_str);
>> +		return -1;
>> +	}
>> +
>> +	/* validate alignment: memory limit must be divisible by page size */
>> +	if (mem_limit % pagesz != 0) {
>> +		EAL_LOG(ERR, "--pagesz-mem memory limit must be aligned to page size");
>> +		return -1;
>> +	}
>> +
>> +	for (i = 0; i < internal_cfg->num_pagesz_mem_overrides; i++) {
>> +		pmo = &internal_cfg->pagesz_mem_overrides[i];
>> +		if (pmo->pagesz != pagesz)
>> +			continue;
>> +
>> +		EAL_LOG(WARNING,
>> +			"--pagesz-mem specified multiple times for page size '%s'; later limit '%s' will be used",
>> +			pagesz_str, mem_str);
>> +		pmo->limit = mem_limit;
>> +		return 0;
> 
> Rather than just warning, I'd make this a hard error and say you can't
> duplicate the hugepage limits on commandline. Saves confusion when
> examining a commandline, having to check if a value is overridden later.
> 
Apologies, missed these comments in v3, will resubmit a v4.

-- 
Thanks,
Anatoly
