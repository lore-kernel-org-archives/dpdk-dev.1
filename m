Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CCDCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:21:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81849402E4;
	Thu, 15 Oct 2026 13:21:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1A5ED400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792063287; x=1823599287;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WnBVwpDUYyAyK3s2cjDbvJTPHlRzlGP4PS5cNsqep2k=;
 b=BCZxuQaijY45giwmfjnDhWjwiteQ4Hkl6wE7KfgTLnt8PC8SX0gqlRSo
 r2SJ3vkk+TuIbj6Y1KpR/PzWO1OqjoELsjIm+B9B1dSxM/VBnSIPhpJZy
 roZOoErOrS0KVn52IofAgMC7eCM5fsBylKInxQCLzuyoKEFpQAlgzFU3P
 rGLuGKW7lRfgA2mpWmTq69odTBZ3A/AydhDxf/37Jlf20Qk6Z/0cpTPzW
 CA7t8vi4PVlByjqwARV9GGI8+pfgO+Co/2xImTQuAk8W8nno8MO/uMPD4
 JzoB5/y12WJVCndUj45u8Jvcksdm/E5pEpZUtuVFgbXV0cqgIgbjrWX53 w==;
X-CSE-ConnectionGUID: 4vcfmYJoTeaFTZiwcSdTKg==
X-CSE-MsgGUID: i4ovLX4nSlud85X5fMrmZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="726083"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="726083"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:21:26 -0700
X-CSE-ConnectionGUID: Yi0ApNYqSeG/lhocy5kiDA==
X-CSE-MsgGUID: rAfvDXOPT0Clxk4wfmlhlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1577092"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:21:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 04:21:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 04:21:24 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 04:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQWdGw9QJ3zj3dy/IeURMp0Qd2M+LwtliID2daaA/0VCQvs4ecpaju2bCakeFtlwj+FJj3C5T1DnZSwxJQbiP72CsZI/bEeaZJkrzFPbBS+oyRp95B3LJ+LBI0nQ2HbPko2IUR/eA4D5wImAjLwrIn7Ppol4FORvx4BD5s9sTz5I6wbDHep9WiOQd637n1OVOPAOjvJQtayYRz8QpdFo3YQxcHg3ObJRJstn/DHVR+8gaq2rqN3d7jdWl88pSIUyADJ25k9gMku1G4cXSp0QVKWi3W3BfZ4VWzbchwbCBa5WjPqq2o9gseX4q5LYjgmDP8Lj7AzYRTQYgfSefZDefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXEwfV7tmK73qXUk4CVhr8HTh8hlOWycxAu4Mk8pHpc=;
 b=V/pIu31KMGVlxEAU5RApGHSdC3uG3n/19rrxxvcENW0N5zkgILJTOqxAkmzADff3ljvtJwPf3vMxczHv2LMIVmWrbix75l8Jf8K8MJN3Bvh9AvwnZzKwMqspQDhJNItGpAL/PxQ7bBWEmo8DoKC/v2u845ywJawDIOxJ3rSGRplGyJWfTRtWia4Rs9AX54Oe5uw+rMK/zqY0B8N4dcoMTbHzYxBZPykw8AJTexlLzCe8V0mIb5JuQ/EzjEzb/1RwJoYp7VKNFEZd7aNYIhf3qcFXMUfCn+Qd1kYhVEL4m5tidK/KncreEIvZSt9qaCx7bsxy+vJZ7h5yfmn51gW4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by SJ2PR11MB8423.namprd11.prod.outlook.com (2603:10b6:a03:53b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 11:21:22 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::492d:f133:b4c3:f94e]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::492d:f133:b4c3:f94e%5]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 11:21:22 +0000
Message-ID: <395f7d87-087c-4da6-908c-e9f569a7ea04@intel.com>
Date: Thu, 15 Oct 2026 13:21:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: avoid private driver include in testpmd
To: David Marchand <david.marchand@redhat.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <20261014203435.583064-1-thomas@monjalon.net>
 <0b380d9d-f7e1-4521-a548-9a9163f10995@intel.com>
 <Q5JnIR46RbOi5z8Dxhadxw@monjalon.net>
 <fe35faf8-fad1-4977-8272-bdf6f1896825@intel.com>
 <CAJFAV8zqXgiwAghLZgR4Ha0dnvwtf9puECJpmv57N2zTE2dMxQ@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8zqXgiwAghLZgR4Ha0dnvwtf9puECJpmv57N2zTE2dMxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::17) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|SJ2PR11MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: f922de96-69a5-4702-5138-08df2aae7144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: sXu1gKLMRsebiE9VMrfxI1W1jP+W1VPQ1E156P+aSKEn4OKr8afBUBCOVL3fP3sB0k1fxzVU/ePhnM6g7hEKk2n+dTwBjHv+keZA6z0Fi+1Sq11ppC6AIhG7IBCLWoqMlxhHOW5tQ8O3JFw9UTZJ4JeekwGD6c7GNC9gIQ57jHgDSCSL1tR2reFkmExqXsSz+H2mG6NAwFpZjZN+IipLOuJNPclYazxQjZFlm5Qh9iIDuG1aKw5JZtx6YIc2mA/eddGPE32o2+TMnlwIPMP7398DuwmUR+Ki/2CecGi5uLKbZvTX/RkvFNq9pNLoqR9YOXyRcJ16jSHGh3RY30M4IHaIb7Yg7igaWoNzYGnyTQlJMMw/uCcwvTEzT694Cy68EtbahnCQ7UJ332wzF2l3ie7qlzqJpbSba8BjyHbNCB/1z9QHGmGe9wrJpCI0Z6k9tcA4JiNHnTrJ14qswNaD5CtZOzO+C0IQvlz/R0x+rShOlI4R/dn85YN1JhJ1TgDJWYpgcZoienY0OJMns6REeMIVYac46lferl5P0NuqyMqizQLKYTip7SFxLvJp9ci8a1piHvKJgXmVRBSLZI3ZPLFikf/wy1kH0wNXqC5l0fFzBs6QpgRna9Cq6IWW7/gZRcYL6At1PBWadq0PNoEMliXdCulo8eYygqxexeW4FWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b29jN3U2Wm5JcElIUXIzd0ZzdUVnK29FeENIMGtXSnUzWlhzZUxkbjlYTkZy?=
 =?utf-8?B?OEVTWVJsZ1VMcDdyd3VldmpGN05zWW1XWU1ibWl4dEdLTEtzYjArWkVrR2J3?=
 =?utf-8?B?VHFETTJaTk14NWFTbFI4SGdvWFJGV3kvTWw1U2wxNEIvdjhwbHJ4WTYySndj?=
 =?utf-8?B?by9JM1RXWmVVckYxejZzcWFTckwxSnJ3b2RDdXpvVTJqbWQwWmJwTVMxZUQ2?=
 =?utf-8?B?L0JabjZCWk10U0tZQWVsSktVYTUyZ3g3Rk5JS0lHeUhYL1FNZW5TdUtySXRk?=
 =?utf-8?B?TlcwWExMRWxZUzg3SFZ6MGFNaG1NUDVjVWJHUFNkaUlpeXN2ZE9xdHZVTEUw?=
 =?utf-8?B?ZnJlTFdkNUJoVy9UMVhyK2xvQXUvY1JMVnM4K04vR25qNm11N1lWQVIybER3?=
 =?utf-8?B?QWQyVkFjQWtvZ1gvWFdoTXE4QkwvUVVCKzJtZGkzKzYzK3FETzRsT1o4ZDNt?=
 =?utf-8?B?cnJIVC9Ja0RYRUw2ZG85bVF2a0FpTEswN3Y3VDc0bGZpWk44YnZmd0thdklw?=
 =?utf-8?B?dFlDSkVKc2JSSUVaVTMrZllpTnRTT3A3SGgzS1lvRHpFUFBFemJyRDVoalFI?=
 =?utf-8?B?cjBtRUpSRjdMamQwZ0lxNlZmUk9UQ0hmNHNZeXBBUUNGSlhaRjgwZFZMT3lr?=
 =?utf-8?B?dGszZGFBL01mU29ycno1UWdua1ZORjhrUVFIckhIdkNrVW5KTk9vYXNpN1JJ?=
 =?utf-8?B?ZWsvTzQzaGJkK2tWZUxTc3dKVndOd0tBdVFhTzVMRGk4VzMyK29VeG5HZXMy?=
 =?utf-8?B?SUlKTTEyaXJ1YXc4dUh2RFJBcHFSZWI3UCtQc0hRa1piSDhWRGpwSXdubVdu?=
 =?utf-8?B?Zk5NV0R3cUJNbHlHVDg3eTRpT293RS9mOFh0bE04aDYxeEFweDI4a2YvN1dP?=
 =?utf-8?B?YkllUER3cFc1eWdmaDVsTlJWT3JPZkFhVVMrWHBTbUtreVdqaVdBMjVUd1V5?=
 =?utf-8?B?VkhydGRTUGMzVTRUOGgzSHUvYjhQaGxiTnpWMnh1OGFvZEt3Y09mZXpQcUF0?=
 =?utf-8?B?MnBmdTFyRFl0MXZCOThuVlpIV0ZBWEttQnIwUlBjaFRXbkpmcmFRV3hMTEJv?=
 =?utf-8?B?NU9XWXBBcGk1YzB2REZ6WEtGVXJUNkhSZlVJYk5QTzRhempiSFVWVTh0VHk5?=
 =?utf-8?B?dlNtdTRucmIxeXZBQ0pUeG9YVjVja2NQZUF6cVFNN0YyQ3MvV2RBVE1TRTR6?=
 =?utf-8?B?TW9MTnNhVTFlYmpyR2hqM0RXQS9Wamo0ZkNzTzM4OEt5dG0rRUQvNUF2S0NX?=
 =?utf-8?B?Smk2bDlWZGJ1cEpIWjRJcXovcDFqVENPLzg5djhGakF0T0hvTTZRN0Z6MlVo?=
 =?utf-8?B?UW0yanRKNURnSzRFSXhiTmNVeHpsQklLeTMzQTFKMUZJekF5QlJobGMweTBv?=
 =?utf-8?B?R050M2c3WlJRVk10VHJURkhCci82b2NYb0dnRTMzSC82a1ZheDVTMGpJWEtF?=
 =?utf-8?B?VE9mTjJFTUJuWmdpZWFlWGhNTW41SDN1RHlQZzBrS1RYWmZ1Y1BXTDJoK2hS?=
 =?utf-8?B?Yy9kQnMvTEdvbmFyNkFyRkloN2o0b2tGdzVNZkJzQnRrcEE3cXJMdnpkMzJk?=
 =?utf-8?B?OGVpWXo1V1g1REZEdU44QzNKNHVRa1h3bUFXbzZqQ05PMDMyM3V0OGE5Y29z?=
 =?utf-8?B?NWIrdVhTcDl6OTdYdHA3YTdzKzdNK3dVcVczWFhvT0VLWHRpbWoyUWZHNGN4?=
 =?utf-8?B?ZHRIdG1EMkkrbm9zR0I2OGNabmhqejhiOHJFa2dPUVZEaEtseVMyaWUwKzE2?=
 =?utf-8?B?amFUdU5qV3UzS2JLQzk1TE9BNEJOM3dOeDNQQlNQM3Q5SVlFWjR5SXhXR2pH?=
 =?utf-8?B?amhFTGJuZ05RVisydmN1TUVNNjc5Ly8yUjRZQkszc2hva3NjOXdIOVZiVWdt?=
 =?utf-8?B?MzRVWlBUcSt1ZXN6VUduU25oUVdjOVJwWU9kOWtwaHg1UEc4blZlSS9rNlp0?=
 =?utf-8?B?K2R1TmhEOURPVVJ6M1NIRGlmdzBDaGVaSlFQQzB1WC8xemx0NERXOFhWc2Z0?=
 =?utf-8?B?SUhEYStlV3MvMzdhWTNsRjB0WFdsNWtTNkNua3ZOQ1YrZE9RZ3JsZzMySUpG?=
 =?utf-8?B?UTZRYnlvS1BFZm9hcmtUUjRhRzJkL1RQU1hZQTRxNlZSZnlKRW51QnNiNzBq?=
 =?utf-8?B?QjdPSUZSbGFkZ2Y1d0lnazVOQnA2TmY1ck40UW44L2FSQUNWVjZMbFhrVzZp?=
 =?utf-8?B?d2ttQXRaeWk4UndHZFJaRmRCV2pJOHlOZ2diRU5XVzFJY0V1VFR3TjE4clNx?=
 =?utf-8?B?cG50MEJiWHZ1cVliY1BuNlliWWt5d2x2eVkwb0RON29IS3NoUWY0YytCK01x?=
 =?utf-8?B?TzM5VTJVV3pYVXA2djFvZWY1a21tekNiOXRnQWJ2TFVmNk04YXo5NUZ2dkYw?=
 =?utf-8?Q?PQnAQl8uqpU71IMw=3D?=
X-Exchange-RoutingPolicyChecked: erDFCMM/9LW3MOBM8sHiDebnBKEBPZoMf8c7B5mohDfHGc01NAJnOXVp5IWB1nsAEck0DM5ODJEjxBIwN/laapviJLussG0hl2WC2xa+sOUCgsAPOGV/70IwoZT+7m4S9m+icNaJtrJL5Zvu1olf9YQ9V2QDAiJvaxTMeoY7iLAZ8imckHNLbjZnoeSoUNSVUo31yd90bqF+obSzLPCYllbKLvBIZOkSJVmy/Q0GX4vKftePPEADEPt9Xnpm9pyGNuHoGEcUmVOsluLFG5iL44e1non0Gn6trHMl28x0vpKyJ4MrkQDy+xZBbaCUMPJ9/fVImbzJ4abUIMJZCTm40w==
X-MS-Exchange-CrossTenant-Network-Message-Id: f922de96-69a5-4702-5138-08df2aae7144
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:21:22.4649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOF+Wg+i4TdzzPPoN9Ihqxw+OMYo1MiJA3HYVjx1H14GuutG0b7aMtbEim1AnkrKQQlN92msldTyymd5McF4a4hMvxU1PTJtiUolZ3jkrBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8423
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

On 10/15/2026 1:18 PM, David Marchand wrote:
> On Thu, 15 Oct 2026 at 12:41, Burakov, Anatoly
> <anatoly.burakov@intel.com> wrote:
>>
>> On 10/15/2026 11:13 AM, Thomas Monjalon wrote:
>>> 15/10/2026 10:53, Burakov, Anatoly:
>>>> On 10/14/2026 10:34 PM, Thomas Monjalon wrote:
>>>>> Testpmd commands should use the driver's public API
>>>>> rather than access its private structures directly.
>>>>> Note: ixgbe_testpmd.c should be considered as part of testpmd.
>>>>>
>>>>> ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
>>>>> operations are available through the private adapter structure.
>>>>>
>>>>> Rely on the public bypass API to check availability
>>>>> and handle -ENOTSUP in the commands.
>>>>> Remove ixgbe_ethdev.h, ethdev_driver.h
>>>>> and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
>>>>>
>>>>> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
>>>>> ---
>>>>
>>>> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>>
>>> I forgot to say it is mostly written by AI.
>>> I didn't review it myself.
>>> Please double check.
>>
>> It doesn't look wrong to me, testpmd code should not be using
>> driver-internal things anyway except through pmd-specific API, which is
>> what this patch does.
> 
> On the principle, this looks good indeed.
> 
> My fault for just moving the code around, without considering the used APIs.
> And there are probably similar issues in some other drivers _testpmd.c
> files (at least net/ice seems to include ice_ethdev.h).
> 
> 

My guess is this doesn't blow up on ice because it is not using the 
graph helper yet. I'll see about fixing our other drivers.

-- 
Thanks,
Anatoly
