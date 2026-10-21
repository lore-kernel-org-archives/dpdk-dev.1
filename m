Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B3606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DQw/LMrQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B3A5402BF;
	Wed, 21 Oct 2026 10:28:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id F0F2440041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 10:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792571286; x=1824107286;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nR7LXE6Ch58G9+1W2ow+ST0qU6V5P1crslU/9zELQpY=;
 b=DQw/LMrQaLVftxLOrwDqEdJf4EPkSZiaXsW7nYLWZUvaamQi0WDV+43K
 zJ5OWd9vDoayrXRgVOMzGZUIvVDja5y9uj2gp6DS6AkCudh4N/1Fwam5B
 TU6RnbPFujHHykywZF6l8W9A7jwXBBrRsQMQ29IzIvx/7b7AnodU9Rzrq
 PkZTHXDVpAx6sljwAkULwDVPZqknlzT5wSjlov+YDIfgXMlhwpc+sDtxO
 SdLs+7Hz3n7yYhIJraVHO4ufrlvEOS3IwHe2hpau01VHyNsOL1rtWoOAG
 YfRvLhDSpfWtuytjOvhNhmbolH7CfeG4Oqx1Sr4RwaAD5vegvB0SJ9Jl6 A==;
X-CSE-ConnectionGUID: HgUxUP2gTOOtG/WHS/mATw==
X-CSE-MsgGUID: GAD4BOU/TPODWHLDCuPNTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1187850"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1187850"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:28:05 -0700
X-CSE-ConnectionGUID: psUMtPnhQtqciqPgG4ydtg==
X-CSE-MsgGUID: 9LZSeFn1TEiySnjeg5HGIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3493210"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:28:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:27:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 01:27:48 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivNA+SZ/V8IjQ3nuI+Vu/wINp7eDoQ+2lHOpWIhA8aiHzGwAC7tkkiqRgykeYx1e0d1lNNpAHr4ewXohgaZmrod2kJgPbo+TODTenS3a7QVsoehcrDgBOcqtEnplaOgsJdGaFYQf7nRFO7SjEllMWOENoufIPUri5GJIJ7Dr9IwXRvPAvrr0S6suu8F63Kpm0EgKCP6VNR+ic09jK+CWqYE1PDITweTYothEYat1fClSOQbWKa1zQGLb+xy2CfHAMCyP7GRr1VO1syGFdfYSdBcqd/MO5SF54yjmc/PsqspND7yW0GnBwKhGYfLcS63+ZxHrwkXTMEDI0ANxdWOqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKzy6PbGGd4ohpVYQasvPA7O8KPqVRHj/FLJB0KS7ZY=;
 b=j209AlkOCe+jwOZeYOYSMlOklYw8VXDUg1f59BuiikZqdo6UdElutEKHCdYHBFImX5JkWHXGsQSLZvWWkg0W+tw5HBSFptqioSRYyMdTYYIDSk5KNa5PhDzp1SoQa9DR3r270eIAseXaQCZr3Fe3zhEHEmZK1AbzojqInHH0c8t/hR3O5jbY9L4wOyjuW8tlLewzLjDoRRrSZEBTmP9GtH/jGAMwEm+keAGXIYESbnwJGEAHhgkN1EQj0VZTiInj9ux9I72hadrdEEVnEKmEn5uj9sBSAr1ZRqWFXelTl7UuNA6tKqZ/S96Y4ahd2kxmSDbe5tHEuWo9L4CWqFNhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 IA3PR11MB738705.namprd11.prod.outlook.com (2603:10b6:208:61e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:27:41 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%2]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 08:27:40 +0000
Message-ID: <6cdc2640-9eab-42c3-9b45-c06365fb0b92@intel.com>
Date: Wed, 21 Oct 2026 09:27:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPsec
 MB
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, David Marchand <david.marchand@redhat.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, John McNamara
 <john.mcnamara@intel.com>, Jack Bond-Preston
 <jack.bond-preston@foss.arm.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Paul Szczepanek <paul.szczepanek@arm.com>,
 <jyotsna.chitri@arm.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <1ZyWCFPKR3SU1pTJ1PHaEw@monjalon.net>
 <6ecbe3c1-0925-4392-afd8-53c777495175@intel.com>
 <fjUyopQLSkieZRyFov00PA@monjalon.net>
 <68a2da9f-81c6-451e-806f-ddfbfcd67361@arm.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <68a2da9f-81c6-451e-806f-ddfbfcd67361@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0288.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::21) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|IA3PR11MB738705:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e4d721-dad8-440b-4c3c-08df2f4d2bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pdQagl38wcU4IiuvhhWol1yZfRKz6Wide6MCx5WB0sx6qHXSxbRSxgS2SOGMu6oBf9OvdrIxTso8NvNNyaF+0ZUjvdjr2cfcGdNDa0/tNTAQvGh+RxYpYM3+gSHUHzRGONWizTBKT/IJuSghdWKGcp4dPLH7wx7dzTDkpv6DhHOVZL36dkXmadyznxdQ4L+8xxuqvbcbNiU18NJEPrkFzy1ARViLS5Nrzqafer2CwbVyBGbROTdxaq//Z2oMuL+AJ1zD15eyRgpj16o/NsQeuB+qOuffXukWjeHO/ZAl2Z2OkEFydAe0G3WR2/loHuS1nMPQvXz+JVmFOL368+FN8Jv4R1F3Fo+n7BBWbRifZKeX5WYpaU2jXmf/RHBuNPIFFkQGBwSk3Gev0GacpXfdV4pO4uetVnuwYV2RDlAx0LxQb0rdmWgjtzjTpDt+hy3d8dEhHzErBOQe59l8ZoV08aTXIMdTJUz0ouPLDFnjVvQvOCWbNbuOojavLXtCeMIIoBwRLa3Y47MPBY1FxCl/jEmTgE2DyQzjs8Vx+nnHslBfFYj0wJWdhlIdspncTcpNtG1Jch+3pIX4nXCj0D+KTkV4JhV/hnLlVBZY5eJc/Bwv6H1GMBifUMKr+UbjpJAk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjFoTHVXR3crcUhSd21sczB0V0dhU2pNY0xoR3R3TnBNTTdRVkR4Wm1ZSUh1?=
 =?utf-8?B?cEZ6YzBjT3BNeUNWSW9mVmtGZE5BVTFyQkh3cFQ2WkY5S3Q4ZmgzbUsrWC96?=
 =?utf-8?B?NmtGOHVnRlNSZVZDZGtrME5MZHlMRm9oOWFqWDhFMHVMbTBFY3hsZmJMSlZ0?=
 =?utf-8?B?czRYYVBVMllDV0RWNXJBblJNNGNXdFhGdGRySis0bE5zMDZWV2RkaStoN3ZE?=
 =?utf-8?B?Nm1XYjRUcEtDS1BxSHBmRGwxcEVRK3R6YVM4K1dESUowU2F1QWdvYy8xRngv?=
 =?utf-8?B?UWZUWldXZVZJVlN2YzY5VlpWblF3WXl3cVhiTm8rcmJkZ01KbEpmTUdxU2Fi?=
 =?utf-8?B?ZXBlaEVrci8rNndlb1AxY3A3ZHQ5bUpFYUM3TXQ1REFzeThxZytpYzJtWERR?=
 =?utf-8?B?REk5Mk8rN2pIYVdMenNiZURzRFp4ZE1pWkdtV2Jid3BrNm9nekFJMStVTHh5?=
 =?utf-8?B?TTNBR0I4SVhBbGFMdVVCekJTdGVTUzlMUWVsdUROMTN5RGVWM09xam5xZExt?=
 =?utf-8?B?WG0zR1dnaW1mT3Q2Q1FhRlE1Z3FmK29YWG1HdWFQK0RxUEVJZHRIMDcyYjEv?=
 =?utf-8?B?ampqMW9YdGhERnF6NHJpb1ZJME51dlJJcWVpbHRnaHE3VGpweWNiRXYveHQz?=
 =?utf-8?B?MDdwS3FvZmZqNVpUSUV3R210M3VndWp6cm9pdUE3QkNGV1NML3MyWnE0aHR1?=
 =?utf-8?B?SzlGOW9iQkNSWkNwWDdHUUtqQ3Ixcks0OFczYmZLVTYzRDJDOGY3b0lEbld0?=
 =?utf-8?B?L2E1NWlmWk5XZmdRaFR5TS9YZU9Pb3pFOE8ra2tXSktSUHI1Q0pxbFpjaG1J?=
 =?utf-8?B?Vk1zYkhxdFhqQWVBdEt6ems5VXNvMDJyVlJZU0xzTzBMRUVFQUM4OG1VQVJi?=
 =?utf-8?B?d3FmakRvdFJ2Z1pISWd2SWJGd2ZZNklCNG5QcUpwVzllKytVdElwWndaSU8x?=
 =?utf-8?B?bzBobUtNWFFxSlZyeUZEWkhIVHh2QmVvRkYwR3prMXVPNUVWQ1RzaUM4WXQz?=
 =?utf-8?B?aXZHc0FmQTdGWXRORGR0Qm14YVBOaXV3Q2VLSktuNWtqMVpHMXk1V0hyNnpG?=
 =?utf-8?B?TnRqZTFHZVVvNjVsdk50cjQvc210bStwVFU0NmpkTWZFM2VGOVBVdWhXeUpH?=
 =?utf-8?B?VHhIY3lWOUI3Z3Mwa3BlVUVRWTV4NmM1ckhDOW5GeS9QbEJjazN1K2FaYUR1?=
 =?utf-8?B?R0NhNjdKbWRkczBiNnNRRGV2UkhiNW9NTWl6WHVlOHJzcEg2d1VERVRNb1Vy?=
 =?utf-8?B?azQzdFU3RnRtQkFvaysrQ3ZHbkNYZmh2czI3MjVuejNlMUlrSjRuMFNpOVRj?=
 =?utf-8?B?c2huSlE1WGdjdnlNRkFaR0o0cVFraTlPK1Z0OFNhQTZZYWJSMzBldHgyVEZ5?=
 =?utf-8?B?YU5HV0JQTnRsTWtOSWVNVjI3eEhBVUtJQnIzOVV1OUxWcXVaUWZCQ2lPanJE?=
 =?utf-8?B?V0hPenJldkRYLzg5YkVCa2N6Vys0MDhDZ0RUK1h2UFFWMTR4Z0dkWDduS1V1?=
 =?utf-8?B?YmpWYlhLM3h1bUdZektPeGdXZzhSVVk1QkhXZnlSUXlpbWdDVjNXN0c5K2cv?=
 =?utf-8?B?OCtKK0xOT1owU1ZId2pNeHI5YjBlK2FvbDB0ZC9VM29kOVJNOEZkSnQyMHhJ?=
 =?utf-8?B?NFJpM2lic0UzQ2l3bWh2MVROWmFyZ3lQMWM1MEg2R254aVRqcmg1MnNXL3Ry?=
 =?utf-8?B?aEdJT3pFazE0YkVzK29PVS9SWUNtaGxBM1B2akpRbHVoUXVNek5obXZuN3B0?=
 =?utf-8?B?WDl4Y2pJUDN3aEpSeXlsMVFuQ2JWalJPcitBOWlzenFTdEg3Q2YxR3ZJUEFM?=
 =?utf-8?B?VTl3SGN4OTdpaFZGUEtqS0o3T1E0OG9pb0pvMnZUZ0tTTHhIQWdBNXRUQUtw?=
 =?utf-8?B?SHNEaU5BVDlhTWFkN0V6Nzl4SStMVDEvZmZDNWpKT3NPUjU0eUh3b2E3RlRW?=
 =?utf-8?B?Q2F6MzNFdy85Z2VpK0JYaGI2MkRQTk45Smc0LzZoV2RDeldRM0RpVjJvWW9s?=
 =?utf-8?B?V0U2NEQxaTRMbEcrTWhuSVlRcVVOQkJneThiNVdMZ05ZSHNxU0s1MHhLa0Jl?=
 =?utf-8?B?QUErOFBkMHlIbi9tMmhoKy9DSEI0QSs0MU1uNkdZRWlKTUx2SXo5WXFoQjhz?=
 =?utf-8?B?T2gzM0dvVDViTzhBYlBDOWFiM3ROUUhKT2VhWTNDU3NXYzdiOC90SDlhYjg1?=
 =?utf-8?B?cm1YUzZUc1FHQkNSQklTWDU3QWpUNUZIUXl6ek9YbElhYlJjOEdyNG1KdFhn?=
 =?utf-8?B?dWpwN2JIdmJFWXZENE84YjVRdU9mZitkZzUzNWhPTjNFOHJLZXdPWWk5Ykh1?=
 =?utf-8?B?S3h2aXcrM1NuQ2F0TTdvMkE4R0JUZkZoSklNRHNZRzAzZi8zK1ptUT09?=
X-Exchange-RoutingPolicyChecked: 2ssGty+xKcXS8vthlfGEOt09Afb8lx37ccx+dV1//QCXg2hVMks3skpMd0hKKRTF2JlRcxLd4y/EeJ1lOTWx3n34kb93b9oJRKaxCdZ9C4hVRu/xxe3fksird86kYzMqzUra3nvYVV9cdPcl8QYQdWP0rfFZ/KfLbul5QqoOPSNOxJkhwIQtXCRnygjwR76jpii2oAxwgmSER+2HRygMvWFfFQwIB1L2WX1kqvBvs6Ym8QTK6fOj7Ts8gcVg2hliEguZmcAU+4Itm9wOti14rtCDLpqPn5RP8bTLKdxjLJh2/BMsFSnpyMYjmLjFhObXXv4MO/2JAGji3xEHBIzsVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e4d721-dad8-440b-4c3c-08df2f4d2bf0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:27:40.8712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJZa+W482JfkGQg9fClDTgEkOwM5XTbrIIELssOpfP7QJOBQfZVaGVzAaFdBwlG81G6cf1DiND1ZUGZvLmb9QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB738705
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 15-Oct-26 4:46 PM, Wathsala Vithanage wrote:
>
> On 10/14/26 09:42, Thomas Monjalon wrote:
>> 14/10/2026 14:44, Radu Nicolau:
>>> On 14-Oct-26 1:16 PM, Thomas Monjalon wrote:
>>>> 14/10/2026 11:37, Radu Nicolau:
>>>>> On 13-Oct-26 8:51 PM, Thomas Monjalon wrote:
>>>>>> 24/09/2026 13:18, Akhil Goyal:
>>>>>>>> From: Nicolau, Radu <radu.nicolau@intel.com>
>>>>>>>>> Increase the minimum required IPsec MB library version to 2.0 
>>>>>>>>> As a
>>>>>>>>> consequence, clean up the aesni_mb PMD code.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>>>>>>>> Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
>>>>>>> Applied to dpdk-next-crypto
>>>>>> As usual with Intel IPsec MB, it triggers a compilation failure 
>>>>>> on Arm:
>>>>>>
>>>>>> drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32:
>>>>>> error: 'IMB_CIPHER_SM4_GCM' undeclared
>>>>>>
>>>>>> I have to drop this commit while pulling next-crypto in main.
>>>>>>
>>>>>> Please find a solution.
>>>>>> I'm still advocating to merge the Arm fork.
>>>>> Hi Thomas, the root cause of the build failure on Arm is their 
>>>>> library
>>>>> fork which lags behind, being at 1.5 release which is at this point
>>>>> almost 3 years old.
>>>>>
>>>>> The only solution in this release cycle is to drop this patch and 
>>>>> rebase
>>>>> the ones adding support for 3.0.
>>>>>
>>>>> Considering Arm lack of support and contributions for these PMD 
>>>>> over the
>>>>> last couple of years, the only long term solution I see to avoid PMD
>>>>> code littered with ifdefs and supporting very old releases of the
>>>>> library is to drop the Arm version altogether.
>>>> No.
>>>> The only solution is to work with Arm.
>>> Indeed that would be the ideal solution.
>>>
>>> If anyone @Arm is still watching this space, please chip in.
>> Adding Arm folks
>
> Hi Thomas,
> We are looking into the  build issue and how best to resolve it.
> Also, would be happy to start a conversation on how we could work on a 
> combined fork.
>
> --wathsala

Hi Wathsala, can you have a look at the latest patches and ack them if 
all ok? The Arm compilation issue was resolved by removing the patch for 
minimum version, and all patches were rebased.

https://patches.dpdk.org/project/dpdk/list/?series=39660

Thanks,
Radu
