Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6440C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 09:22:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E53C42F97;
	Fri, 25 Sep 2026 11:22:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 54DBF40B9F
 for <dev@dpdk.org>; Fri, 25 Sep 2026 11:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790328137; x=1821864137;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Bbl7lLIXasRqyD0G1NczH4rXyFk8b8i25QUgykg8I8s=;
 b=kCEg+YmBed0ezXXGS8tGrHtZjX+zKP/9d/X9IJyD0tA87P2KqST76t26
 LhqgOqwrk8MNQEuTzwHv0Ter0YMyGbUlhbPC9g3upcMF43888Ls4PKuYe
 CEaqU1ab3jCYWOU4ANKzhdbXevRdvyVpVh7kjJXQrAZaLrYsUD71TJNWb
 pami6pI0rrBkovPexa1lKA00EzsU4IvNgSIm1khCpXW6+MYSkie/IJVYe
 trpLDkbw75jtXtlqxa+ufa/0P4H5CgVjbY0tPbvwWBtXAcFJCvxk39UoU
 t1p+K8baQZKfuXSZMweAxr0ouXbVEr6fAJDSB1IBBe+Kfxxzuz90cmO4Y w==;
X-CSE-ConnectionGUID: +T1Tgt1ZSxqhwpJeRhp1bA==
X-CSE-MsgGUID: vandngpETze7CviZrjBovw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108601105"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="108601105"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:22:16 -0700
X-CSE-ConnectionGUID: zMJpoStVSS2grF7u1Zdy0w==
X-CSE-MsgGUID: P+1aU+5pQL6sjafBdUzGNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273511700"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:22:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:22:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 02:22:16 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENYODqNKgw7VPWF1GVcWVHQ653SfH3+ChT9jYyYSprdmbdYp5cnAG5A34961IgAPLz4ZDKxQrH8oYLt+FMfb9S2tV+dvfMoa9rAJvDjOqEJC32VrMaWKWUxBIDtWdW60QeQNlJbm87HcGa47O+FuTtKL40GkZDLKyMK5kIu4M/6ghttkKaY32pqj2sh1hsE1yahIynQeMrimEgAQB37uR0FKNBuh99vTSrHPhUIOnMUeKHDdtvfCCRJZcDHpP8QHScHOXLIErRMoG78Ay2kRHfTqL38GzNi+VtvdDVWjGygnw/X9ALucYrwBJePMqFPxAbuQAhLv65JGK9F69EQhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMzWmyQr/bEFhNDno0nPXh5MqJ8xfhg5Of1W1MMVAiY=;
 b=emaCWjkGW93xOfBcV00jvZNL7fhvgpcmK6j+WiXu8jePlhYGtSMqKLpxm39U2OmRASORxmo6cD9HeVY4WctqDrsca5XwSCv/Usgu3ph6Vhu/wzH7mtkWGFGJKPkufI4si53Wp9RUkYK5eaM6XRo9xI/n9Wfd/IXeHNtbQwx5AR+kVV7I59umjvYR1u8Bz0E48X3rov3gs4nK73COUb2fqMKgoAJl5Kygx1lMk7Yl8ePjHm1wzpIdZ1IUi8XOXvLog8lW1LxDYu69/tUqc2a5M5LYgp7i0/yVIr335CoQPrO5TH4I9/trchwYqIEElAH+QTSy78H2hMfRjdTRQ4Kg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Fri, 25 Sep 2026 09:22:13 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 09:22:13 +0000
Message-ID: <9900d28a-d295-4f7f-a325-a939bdbc8d5c@intel.com>
Date: Fri, 25 Sep 2026 11:22:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/ice: disable link negotiation for fixed speed
 selection
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260910150817.1521317-1-bruce.richardson@intel.com>
 <20260910150817.1521317-3-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260910150817.1521317-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 103af3b6-4320-44b6-690b-08df1ae67ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: n/lkeUpezcH+5HY5ksbwj6UavG4uUYH+WCIDvc9Q1CUOty1hFO+evWiNxwVFC3cMX74SywvxswvvYhC/bBJ5yngJjdU1528J/oAclcXZsM9XzW7RD0wvCGX26Ybomo79sphyL86L+kl6OL03VHRq9VYfmZBPW2P52RIYdh4O9ezdbQGweaA6+7vZc11Hwq++zMKK9R9Sd+qIDJ3b7JsginuW1UEohXPUDQxQJNPZqpXsj+/C0mIVnv7mmk4UwFAKkbUqrTgiyW9Wt16d33VJIbTyQhQ4SzbFE2SwASuhmn/E5FC65aOiS1XMBFwIIubxUzGUpwtLKG5FHG3KxteWUIwoYgxrhFL04j7HUJO5S1aTF7j//dK0X1kykfc9VP3XlEPKzO8m3I+bZliuO/yYAjZCzWIqmbAdrlFZV0DptCwVAanAeeA7FiaLt8h5G8SMLj5nZhfK0i6wEHJwrbZZtVe1Vo28ix6fUWkbOjyUyKpcaq1Mt8PAf+SrA7PljDdReJ5SavwYIL3bw5/fDiysiJ4dWzW2ZlWJnifrM/GsgqNjCiisemzYIKz4+7iLn1C3OVLp6JA2MRNnrDI9YN7hG3nqstw0TdfiW7LkP31ZGHncv/9vRVXbDyQM3dRXaWsppf3GO3xLvXYDPkGQkaoigTog1Mb2vxRRWgHN+2MR6Fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNLWVFSQUtiZWJJQmRuS2lPdDBEamRNNFJtbW85TWNxZk9VSU9qVGdCLy9r?=
 =?utf-8?B?Z0lLaFpVYjIxZHluWGZON29oT2RYNzlQbFV5SisrcVhBMkNjSituRzJveVA2?=
 =?utf-8?B?K2ZtREdJWVowMXZCL2hRWVBndExJVEF3TklqUTJ3OXF6UWFLTlkzZUpYVkFW?=
 =?utf-8?B?RXZsQktwbzlRRWFXaGs4UnlBUzFqZkZPeGVjUktXTzByejJHcUFoT3NNWGFo?=
 =?utf-8?B?Wk5FRXhwR093RlUrOFNyOVcrU0gvL0Z0L0h3a0NJL1JXSk80eTZaOGp0emRw?=
 =?utf-8?B?UGZoRFkyVTRNS2hXVUVsVGoxNTN2Y0Nxanp5dktNSk4vM0wzZW9VeXBrY041?=
 =?utf-8?B?OVQraVQ1a01WemR1TmRJd2srZTY4cEo5cjRsRk9ucVNzUitrdjRqSlVSN2RE?=
 =?utf-8?B?YUljcmxsaVRFNTNOcWhvbkJQMTRWN0owNUJrbHhXN0xTRnZCbm5rd25lSlpq?=
 =?utf-8?B?RGZpa09KRUI0NTEybWhSMS9tT3IzYjBhaXpjSUV2aWdHU2RyK1NXVmNVOWs3?=
 =?utf-8?B?S2RiYzFDMHNHbUtYNWcwWUJ3NXhoS3ZvSEFmdzZvb0g3TFB0Q1hCTFdqRkx6?=
 =?utf-8?B?cHFhcWNtOEpQUXZrNFM5eGJFbDFMRW1iTXdiUm1Ya0p6bVA2SnZyNmpTNEJl?=
 =?utf-8?B?bzU1RDRJMTd3MEpFaTUyNlE3am5ZNGo1WkV1OWl2cUxjNnNQNlYraXR0YXVj?=
 =?utf-8?B?TmFIRmZXbVdMNVlPTkUxcTZ0dUdBVG0zY2xNRk05bkRWUjBtVmJ5a3lhLzRB?=
 =?utf-8?B?SjVBdkdua3FxSzF3bFFRcU5WbnVNdmZWK2huTnJZTzB3VTNYU1B4cmhiMStX?=
 =?utf-8?B?WU41N3FNQWhXNjRHWUhjcWxxbkl6ZVRSb1piOUs3WWVLdXczWURPSExRaXBa?=
 =?utf-8?B?bkx4RmpqY3hpQjJsSjNuMG96WE5ic0JiMHgzelZ6M2c5b1lBWTFCVGlLcHpL?=
 =?utf-8?B?dlFwelgxcjIxU3FKN0hiOGJYVk9zeEFvalBpNFh3bWFrRWlZZzBuNGQxeFE5?=
 =?utf-8?B?dnFDNnFkMmgrY3VqcGlEbjl6Zms2ditJeDJqQjZ5WnBMbnp0TklzY0JPeW51?=
 =?utf-8?B?aTd6clU2dzVJak9KTkZQRVRxSVYrLzJCc1J4Y2VDZDJYVXJ1aXpVNVdZYlNl?=
 =?utf-8?B?UmtTQXhGODhUaGIyTG5FTFpobHR2T29VVnhuakJJdTZpUXBKM2hoMWRiZXpV?=
 =?utf-8?B?ZnhoVkpCT2dsOGlzVE96NXRoUktQbWxtRng0TFdQMENxdVFkZkNCNjRySmp4?=
 =?utf-8?B?WVhtMUhoa2txQWoyMVZKbHFXNDdMUUlKd3JFa0F6a3JlTmFJVFZaTEpDczZs?=
 =?utf-8?B?c3Bzc2xFN1dNRklzb2dIdUdHTkt5a2ViUTJNUVdoM0I2RVVkNEJGSlRuYVR5?=
 =?utf-8?B?WUtRcFRyZlFPTkZFQUc0dnAxZVVhQlJZZEJGTWI4QkdlL1F4ZGg4clJFcnk0?=
 =?utf-8?B?b1prcCsreEJQZWtIWVROMm5KR3pCYlVIazFsakszN0pNb25wL2JjQ2gvTkNr?=
 =?utf-8?B?ZnkxT1FHWW1PQjhuSlNsNHJtNFV5VEExVzU5SVg5T1lNRjI4amhmaGRpMkQx?=
 =?utf-8?B?dTVIaU5yZzZ4dUY4SjlCWVVnSklxSVJKdlBzTEVXLytDVVRrY2FyWXRkYWlu?=
 =?utf-8?B?aTlyaFFlK3JIUFFZcDRiQWh6cW9Lb0ZtWnVLOXdVVFpxTThtUkk2ckozWHZi?=
 =?utf-8?B?WG1HN3hsQ0FMMVcvZUpYaUtzSmp5bzNvR3RheGIrOU5UQlkvVzM5RW1YbldW?=
 =?utf-8?B?bjc2bHVzUlVRTzhKeGV6bkt1RmpabnJ4TVkyRC9EanQzaFo4eFJESmVBZjFU?=
 =?utf-8?B?UUlkNUVtZVh4cXVDVWh3ajZwODFoay95S2lLNUxIeGhHZDVrQ3hGWWYzQTI4?=
 =?utf-8?B?KzNiN0RPN1JIbVRZWG9kQ2ZRWkxJbGNWdTZCU1JTU2lJbVQwN0tEM2kyQlRL?=
 =?utf-8?B?SnUvL3lFekJMVSs2emRrQmNhTTd4MHpDWVhhUE5VY29vNk1tcUlSSC9qM3Nk?=
 =?utf-8?B?SlFvUW5MYjc1K1FESklZcnU4UGZhMEJ1VmhKTHVqZEk5bEdqT2ROWThBUDNJ?=
 =?utf-8?B?cFFwaU8vNm1pb3RZMmRCaTNzU2JiNEFmc2JnalFpR3JzOU9nTE1sQXE3dHp5?=
 =?utf-8?B?MWZYdzN0Q1BBQUxjZmZEblNpN2R6MnJkY0NxWW5CdU8rU3A0YzZQRjF0eWN3?=
 =?utf-8?B?ZEs3KzdpVlFKZjRTUHJCSFIvRW04cVV2ZzJLL056REw4Z2Y4UDlQdFNtZ1Nx?=
 =?utf-8?B?eFVybUhJeHdoQlBobzd5MklKU3VPdWVMWktYWUNST2VnbDdsZXo0M1dOb3ZV?=
 =?utf-8?B?QVNCRzRqNGFtVk00U2oydkZpSnN5bVBZK0wxVFdLWVpBSGhxKytDcXpLT2JJ?=
 =?utf-8?Q?OuuadZ5n71zLwGig=3D?=
X-Exchange-RoutingPolicyChecked: yXNyMjAGe5J3S7TtJG4Jf0TcrCPVcirFYZNxcfwx406bHopH3w1D+CJ+XHIUlfM0HtnXY2Vm0yKhiZwkraaiw0wI6MLAwre9tH/qRJl9OjVaLQlyZJbWkxJjVbTWlkUnj4aOUHzN2GcDsXIeHyX3Nj3Pjokq70jR7wpitGJVH8BjQIRuuAkxgf4UusWOGmwpLKqBFyGo83pt/T0oLfj8QWTJJhlh+lbFoFei+QckqenVrl52xM89FF3SzIlEI0aTHfhGfyHFatolM8XSPp7r4J1ScHC8AOBo4d+zZKsIlBRJHJgX1FTyfAiSWgbMOrq8HpMrpikFl0a6Q7HlwFYnIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 103af3b6-4320-44b6-690b-08df1ae67ba9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:22:13.0896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yesmjpRkbfOTEsFpuq9rTkWMvqXhFL3av1rngw4ooiZI5p/9RSsQhaZcqXquIb0s4LlvDbRMeoKhnN+3lKdzsgRz5CCIptTLB6lriuPSj2g=
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
> When the user has requested fixed link parameters, e.g. speed, duplex,
> etc., disable the HW link negotiation, i.e. AN Clause 28, Clause 37 etc.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---


Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
