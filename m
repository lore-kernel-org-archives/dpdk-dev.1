Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E358CC982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 08:04:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 166E8427C3;
	Thu, 17 Sep 2026 10:04:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 28E30402B8
 for <dev@dpdk.org>; Thu, 17 Sep 2026 10:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789632268; x=1821168268;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zOHppVcV8+XaWEf5JuTw77LKIRetQ6+CmjNnHk6Lzi8=;
 b=JPAc5zb6CDhxua6/6azbYN+O7xAhpPLrDG7FSvatZiMzXTQIS4woPxx8
 OIJBY0Qg/3go05EUCplNQa+tg6HPHxuJCHdvIwsMp8yo1K36UIrpnKz0z
 MFbu+tA4WH/PF2f3MK69hKpnJvaBcSBjRZZigRMXhWdU3Cu9HyoLR4SNJ
 7YYqUeC0QOwOrahzs6m5/Qr89V/4HfY/u+ithRfNT6H2egn8C4JpDixDl
 5NN4VzWg6Yd5et8PQPOerMDxO9QQtq2H1BfizbRhjSEEkbWxKJ7e6DOXP
 F5UzPIpCwCM9oRyZwqAVT4fzbUoSOVOZNPiLCJnEB38zg9Pa3TVjLlrG7 Q==;
X-CSE-ConnectionGUID: cIDtnL2aTq28I36+wbsUJA==
X-CSE-MsgGUID: CCyIsYa0RvOhFACfYWfwIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100626311"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100626311"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 01:04:27 -0700
X-CSE-ConnectionGUID: mYNNlohIQuC6Imvctv7DxQ==
X-CSE-MsgGUID: a6ylwVzxRT6wPqorUeSMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269359927"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 01:04:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 01:04:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 01:04:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 01:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngILQTiYc+W8qZ0mN3iJ5RYs3uEvO1D6in4UkB1bq/UD9F+CS0Gsg0/NT5GOUOi97XyK6hI/rJLVUEzIyNVa2jek5M9QPFo9t+tPtDzmgbcIandtxgQ1/WRDh9jWHRaWUZXHrVwF4WNcTmD5t7dMzE6khbK+dZ8NYJtzl9T9zxilo8+3LRywSf135wmSV5vcw2Ds1i2jhq62+dW30ksGK3v8qJmip+LHqDd4tHE3Fq2I0Ja2Uz9TFBDiZRfkKwt0KpWNpsUztb0P7nVE8eXeVeFD+3t9GPm+h0xvek/eEaqp+Gd+K4Fav+jEg2zb8qsOzcUksFQV95pQR2f5jMjJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5VONx9D65SPsIPzhrkHUobZaKngddYosiAPHeka5yU=;
 b=BGH5K2/6WxU98EMlVS2mmHERu0KAvYrgTM+tK9DIaMPRsn9jqnmADg1aHQqstBecpQX1YcVmbWgyDU5R8vXEAmmss2H7A27q74y5EEhnycH57fsGTo0EL8akmZ8rdNrsO8RPPlCuP4m4nsmryTF5XQ9ZQvKIxmPwPqZaredJOuApET3hidNKXc8ebNdp+EE2iEaSV+OYLgW7LjNCIcJUEaQLrHp9o2r02xtDjQaPhfK0uDw6g8UQedM5G8Qfj5a8tdm3h/hNx2uVhXRa0QM2sbUFhhGI7CIX6YrXm2I1g4erO7wnj3+NIRUrNmseAhAGusabhRL7f8f9inulCLspCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Thu, 17 Sep 2026 08:04:19 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 08:04:19 +0000
Message-ID: <740d146d-3a67-46bd-b901-438e6b635511@intel.com>
Date: Thu, 17 Sep 2026 13:34:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net/iavf: add reading PHC time support
To: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <vladimir.medvedkin@intel.com>
References: <20260727102444.789833-1-anurag.mandal@intel.com>
 <20260915164231.247037-1-anurag.mandal@intel.com>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <20260915164231.247037-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0300.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::13) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|DS0PR11MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ee04d1-c4b7-4ecc-27be-08df14924659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z/zbLtEPwDPXjs/GEtzZCTKIaB08fE6Y7Ryp9vmzVKGhUmnXywT/2uuZ3pURdl8+4hkvVRmyuxJuCKm7PZ5dQJD4eAfaFjPIW3EriWCh/2ne1ywWPlcQNP05cNmmYdyixupvjdiTzcOiHvEBkFbLt/FO4nGRlOqjh7JOqmeJl6caNDnVQMIU0VjwoSKRNIXEVvfGNM0g+OooYdaLRD1NWZdPHHn0yZZKOnzTvCyt3RSedbsFeZ0c5Lh3eZgW42W53esRKki/LCs5nulLDa6eP0lmWYTWHezixLZy1xxV/VqcZ+03+is9vd+ZVQkO94FvFm9U2sKVjpVyOCPVTChZ7kYm3oZsNJX7l+HdMdGHmJNaGSyV7z+Iv3enxR7jJct3UHS00yoO5uLXkDpd0fHSkhluQqmnOvgavTkgRgy+wUHJhXhBOLewAZtPeH+MdovxgfUbnDB/m6IQ7LBs8dQShIwarlKj7LzdCkmXp432AqFVHDmZ3ohKHEEF+rBD9WF9ymJ9WzK/RhmMK9zWtMCGPnWgZ6tzOfX3JS+EyaobcR8/YYcAIUGVhsug2o5z++JxqkplfyWjLGXwNYPFi3iR/ynS87zfmDGYLKUYbAUrKEeo1cMhs/gZIebYyMwpjL0mGhkta/5ZQOH/s8cvYebKpI4wq+qrDWtZTSMRjeF0G58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a20yZmR0blBhQ3ViWnpLeFZBN3JNZG1sR3ZxeDVxa054K2NHSWZ2cWNzTlpT?=
 =?utf-8?B?eHpDV25yMW9QR2E2NW1MTFYzZ29LV1BDbGp3eXovVHFreXdaemNxWXlvREd4?=
 =?utf-8?B?YkF2aGh4NFdjV0RTZEw4NVROTVJZZGlIYTVHMkVURnhWV1JEUDg0NTRqRnho?=
 =?utf-8?B?L3huejZYaFpPYjJwSUE2S1REVTBMd3lNY3Vsdk5RaDFrcFk3UlBDSE8xY2lj?=
 =?utf-8?B?ZTNKQVBTTlp3QkIveDE2TFNsejNiUS90QzN3UEVyUGNPdjVSL25kZkpBaTg4?=
 =?utf-8?B?Q2VPVExXM1VKN1RLbGk3NzBDMFBsNUFobERPTjJyNTJIZ1VERzlrUk4vU3d2?=
 =?utf-8?B?NThYaVZaRitvMTIwRkJDTnpqTFRGbGQ0SGh2M2dDVDhLekNrck50bnF1d0Vx?=
 =?utf-8?B?Rm9RVWtILzNPOElNRTZhajBkNThzbTIyQ3ZkbXhsVlNVdHhYSEc0cjVUbkVx?=
 =?utf-8?B?VEV3bXJsdTMzT2ovNXdTTlRxVURObWkvdVY1T1pNWUZ2TGIzd1UvVnhxWlVH?=
 =?utf-8?B?VElsbWFROVpXbTJEaVh4OTFxK2J6MEZvb1JBZHJ5b2NjR2sxcURRR1g5OWU2?=
 =?utf-8?B?VERvQmI5anV4dDB4WkxMbFg4amNFVFJ5ZTZ0S2JvM0FaUk9TSzRZMHYxOXBT?=
 =?utf-8?B?eDNYQzFTUWNCS2FtZzRiUk5xa2lNNjBIZFBWTkJwcGZBWm1XU2t0TE5GRnVC?=
 =?utf-8?B?MzVCSHgwekN6T0dHSWZZM0VKVnAwUjRkTGxtY2dhQ1VERGRBQk1nZ0l0UGU3?=
 =?utf-8?B?N0JneVJ3ZGtUQ0FvMTJUV3VOQjMvYVNQandVNzBibU5yaHJjZGhUSkxtbk02?=
 =?utf-8?B?YWJ3UnRjOGdjemlPbEpsVUl3ZysydFZxSllPQzRIbmFOL1oyNGN0Mk9qdGdH?=
 =?utf-8?B?QTdSMTBFVEVkeFVrY0h3bDd4ckdOMUlnTUQyaUpVSFVwTjJ3LzkxYnZnVVRr?=
 =?utf-8?B?cURNTzhYWDl3ODErc21PNUZmV25uSnFIRkNqMFpJajBwek1nSlFBL3JzRDBx?=
 =?utf-8?B?ZExFSUZBWCtZVlNOSkdFMzEyQUdIbzFlNDlFN3ZMT3pqT3h0MjNtanZxcWRw?=
 =?utf-8?B?N0ZHWi9TVzkxb1FwTkdGcDI2aHJqbGxOVm94b2Fod3VhOVBHUTk0SWU0empG?=
 =?utf-8?B?K0pGK2d5ejNpZVo5bzdFN0dsck15OThEdjRkZ0xVTkFCaWFTRVdZREowc3ho?=
 =?utf-8?B?ckpRdjIxUy9DQTU3dTFnbnRMUzMza1J4dVl5dEJXdndYa3c0ZFVIS3dEWVhy?=
 =?utf-8?B?cnp5V3o2K0xIVklSenBCMDBnUWNSOFBsNDE1d3ZyeGdkai9PamluT1B6dlA1?=
 =?utf-8?B?M2J4dWw2TGQwZmtyTlpTVTZGOU9GTFRadHVJRXJ1QlIzb1hkQVRMWVQ2dVRO?=
 =?utf-8?B?ckl5NFQ3SllUdGRhRU8vWXR1RWRtbFFIaXg4ekJOUlRPY3ZJVlFpK2E1eFpJ?=
 =?utf-8?B?MkNEYzduUGZJK3RvaE40S3hiUEQvbS9iYnBJNW8ycXRLdXR6ZmZ6SXlNSDVV?=
 =?utf-8?B?ampUeUxuMjJnejNpaVYvYzRiaVZ2a1Z1U2w2akRkcTdoZUM1cmVESkpEK2xY?=
 =?utf-8?B?cGliN3BjcnNsc3UxUCtUeit2alNzZzVhODZjTklXdUIwdnl4TkFDRDgxdW5r?=
 =?utf-8?B?cHM4ZUdGNDl2YTVZdHd0clpCWEJ3U3ZCT0RBK2RPZ0JoZ1lmSjl0U0xURmJR?=
 =?utf-8?B?UUt6Vi8ySktCS0F1T0F3RkEzN0p5M1dWTXFOZWlwVWJGdnpYSmpxL2loTFdV?=
 =?utf-8?B?elFPZ1B3OTUzWEtDZ0lYNUJvODJjQUVibVdORFdJNC9aclQvVkR4QUh5cWh4?=
 =?utf-8?B?dlMzbXl4MllIYWRONStzOFBzV1FnUmJqOW5NVnpzR1JKeExxU3g3SjlJdDF2?=
 =?utf-8?B?dWp0ZDdFSkZaWUI3RmdudU1aeGlMamZMdkRwaThrNFZZdEZJVDk2UVdJcWZK?=
 =?utf-8?B?SVNFVURhL1BmNnVPb1FoNlU5VTk5RStLeEU4cEVwRldzVmh5NmtGendUV05m?=
 =?utf-8?B?TWQvaHFjQVQ2SlZTVWFiRTdCNHhhTDg4NTBFZ3k4aW43TGs3TDZ4YXJnRXZH?=
 =?utf-8?B?Z3NpVWhvNEZsOENRck1QSkM1U1FTaEpjWkpzdmJNRituY1hTaklOL2o5czlQ?=
 =?utf-8?B?eU13V1VzSkJBN3ZiRHdyQ0cybVVwMDNZWHU4bHAvdkZiOFBNTWZjWThMbFJx?=
 =?utf-8?B?V0hta3pnUlV1TlpmWFZLeGpVd3BvMUJ2cERxUnFVdk9ZRERCL3NqOUhkYzVm?=
 =?utf-8?B?K1ltRFU2UDFYdUFaZmNEQUpJaS96ZzFPVGhBeEQ3K2dTSEVQOSsyTzA2cGtY?=
 =?utf-8?B?Mk0rbU05eHl0cjUyWTcxWi9leVF5SUFUbExPM0Z3bUZRMjNLMlJCdUNnL2x6?=
 =?utf-8?Q?TOWANzdyPaL3DhKc=3D?=
X-Exchange-RoutingPolicyChecked: XFFhw5bjr++93I84h9G2SXaamJ82QAc4CQku9vthiRV5yEFY387dHyTk9dsWtRuvTXwyM8BDSNlG7aUM4amvkIfDRhkIhK7/8vyOwoiphF10y0hScSjCQEZrOIMJnXDaJpgxAqlgporJYHwQjl2mQRXrvDbSL4ClNWigLE3f1IpOm6ej//hvCzsB/hXGOtOeiX03Xz5OFbL8/3VqEj6gaWOuBFu1IUNQSZb8HcbUNjl5DpXQtoS4HYM3XpFoP9cSqmV49dJt92EgF5tFd7sA78wjKlk4rxI47+Z1wIWyjbNMy0WBJsrCa9/BkKiyzXACc8tpBOnW//mRM5lZXAIrVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ee04d1-c4b7-4ecc-27be-08df14924659
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:04:18.9882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjUjzINO6TeTQpIDb6x5lFFCaKZibErIVfhorRgfX1SETmvUu1hJsxfK2NKsr6bLbQDRetlUEuR4HWl9ZITHAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6424
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

LGTM.

Reviewed-by: Rajesh Kumar <rajesh3.kumar@intel.com>

On 15-09-2026 10:12 pm, Anurag Mandal wrote:
> Added iavf support for the
> timesync_read_time ethdev API to read
> the device PTP Hardware Clock (PHC).
> A VF has no direct access to the PHC,
> so the time is fetched from the PF
> over virtchnl, and the API is only
> advertised when the PF grants the
> PTP read capability.
>
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V4: Addressed Rajesh Kumar's feedback
>   - return the error unchanged
> V3: Changed read_clock to timesync_read_time
> V2: Addressed minor typo
>
>   drivers/net/intel/iavf/iavf.h        |  1 +
>   drivers/net/intel/iavf/iavf_ethdev.c | 28 ++++++++++++++++++++++++++++
>   drivers/net/intel/iavf/iavf_vchnl.c  | 13 ++++++++++---
>   3 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index 293adaf6c9..416625d9fb 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -533,4 +533,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
>   void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
>   bool is_iavf_supported(struct rte_eth_dev *dev);
>   void iavf_hash_uninit(struct iavf_adapter *ad);
> +int iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time);
>   #endif /* _IAVF_ETHDEV_H_ */
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index e475b64971..cb0e8989e1 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -24,6 +24,7 @@
>   #include <rte_cycles.h>
>   #include <rte_eal.h>
>   #include <rte_ether.h>
> +#include <rte_time.h>
>   #include <ethdev_driver.h>
>   #include <ethdev_pci.h>
>   #include <rte_malloc.h>
> @@ -165,6 +166,7 @@ static int iavf_set_mc_addr_list(struct rte_eth_dev *dev,
>   			struct rte_ether_addr *mc_addrs,
>   			uint32_t mc_addrs_num);
>   static int iavf_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg);
> +static int iavf_timesync_read_time(struct rte_eth_dev *dev, struct timespec *timestamp);
>   
>   static const struct rte_pci_id pci_id_iavf_map[] = {
>   	{ RTE_PCI_DEVICE(IAVF_INTEL_VENDOR_ID, IAVF_DEV_ID_ADAPTIVE_VF) },
> @@ -264,6 +266,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
>   	.tx_done_cleanup	    = iavf_dev_tx_done_cleanup,
>   	.get_monitor_addr           = iavf_get_monitor_addr,
>   	.tm_ops_get                 = iavf_tm_ops_get,
> +	.timesync_read_time         = iavf_timesync_read_time,
>   };
>   
>   static int
> @@ -3662,6 +3665,31 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
>   	return !strcmp(dev->device->driver->name, rte_iavf_pmd.driver.name);
>   }
>   
> +static int
> +iavf_timesync_read_time(struct rte_eth_dev *dev, struct timespec *timestamp)
> +{
> +	struct iavf_adapter *adapter =
> +		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> +	uint64_t time;
> +	int ret;
> +
> +	if (adapter->closed)
> +		return -EIO;
> +
> +	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) ||
> +	    !(vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_READ_PHC))
> +		return -ENOTSUP;
> +
> +	ret = iavf_phc_get_time(adapter, &time);
> +	if (ret != 0)
> +		return ret;
> +
> +	*timestamp = rte_ns_to_timespec(time);
> +
> +	return 0;
> +}
> +
>   RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
>   RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
>   RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index f346837bf1..a63639549c 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -2521,9 +2521,8 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
>   }
>   
>   int
> -iavf_get_phc_time(struct ci_rx_queue *rxq)
> +iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time)
>   {
> -	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
>   	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
>   	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
>   	struct virtchnl_phc_time phc_time;
> @@ -2543,9 +2542,17 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
>   			    "Failed to execute command of VIRTCHNL_OP_1588_PTP_GET_TIME");
>   		goto out;
>   	}
> -	rxq->phc_time = ((struct virtchnl_phc_time *)args.out_buffer)->time;
> +	*time = ((struct virtchnl_phc_time *)args.out_buffer)->time;
>   
>   out:
>   	rte_spinlock_unlock(&vf->phc_time_aq_lock);
>   	return err;
>   }
> +
> +int
> +iavf_get_phc_time(struct ci_rx_queue *rxq)
> +{
> +	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
> +
> +	return iavf_phc_get_time(adapter, &rxq->phc_time);
> +}
