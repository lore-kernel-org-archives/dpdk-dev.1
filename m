Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691DDFEFB47
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 13:01:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9EE94068A;
	Fri, 27 Feb 2026 14:01:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 075F44027F;
 Fri, 27 Feb 2026 14:01:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772197264; x=1803733264;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TfWZttd2qi0fvy9okJ5NY35TOkYf77QowIGaKOBANKE=;
 b=jYp4QSc6ta0gLrjgs/2KpmqvjDT050WyhcG6QWvtouBV4LpH64OXqJ/e
 U4VzlHuY3IL0HIayx7dVVrgoyK8KHFP7HsmvupffuEa+qyH+I8WmbLpe4
 kzCyuO2vf7EwiIQaBTz6TQay98DvDGLLKYd+K1raBlwF1eTgc7hSMF04R
 19dhVQIL/YqBTSz+SWxd0in+G3+NfFol6gnJuMs2dms2R4Pq+bq85MVm6
 NGg2LfkkWsGzaP5QWiU/DJNtMQ3oj7IKAgUCiD7PS/9NcVxxFZiqPp1Wv
 ZKZsY5j5G/WGkQX3lrVTZ/vtJYp3sdcyr/tlDDsNBHC6SkO7HFYghUxH3 g==;
X-CSE-ConnectionGUID: ezZM35pSTbuB3NTNdlQ7iA==
X-CSE-MsgGUID: 2srKbgJuTB+iF39kvPXEjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83912548"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="83912548"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 05:01:02 -0800
X-CSE-ConnectionGUID: rWUQJpr4SseOihqIXRS1VQ==
X-CSE-MsgGUID: yFRvTjyRT32MR+Nk9wv7lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="247413111"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 05:01:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 05:01:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 05:01:01 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 05:01:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arAPpSBI4PXuN0APwyGbqgLSRbUUMBV3UZmLZJVJ/XYK52j2K/OM9xcVpwnVnmsryBJwnKjF1Q4u6BDIEdpvgX9/WvCaEI23LS7weTwWzjKiL4tahlfyIzm1FtzmzvigAfYXFoEAj3WoRBuatepTH+uqcB2qyIdas8AaBjT+7kKuTAf8AZ+EW2VG8Mc9hYImmKKIb6in/QeMAZJoocQGo1/gPMOI0YdMKe8Jvob6PyXLLyzqkSiGwe3ZNYCTBkwqig/HVK1FA7hnX4sz0Zx48jPa81vzV1beTR+C2zkHPVgrx+eKR1skgXxs/P2G9Obg2xPiqVwmSg7KPTR06bg7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOyoVdgmzET5s3dpDDUKAWpcm9jc7cq7o8VBuTltclI=;
 b=wykz7S6jhfRN1MkeDarRqIDboXbnBWMqeojUdgMXequGYyUD3p+Y9VbfPO1N40+Mx8PAczKb7sy9b9DIHZpzCrT1qb/Mx0rGIAtH8mLVoovKqkL2UCfeaEM10XpVyaey5KgzphkR41mUKKVl9MPYgJ9dlGQ5UvV6juJcVrYuHxgqRF1Bna9aTmzoCpPeDyA+4bskAmH1yXwgBhDzPeis8ILlbYXDY7+FkO+jjCImCNUMkW78dowhroQyKp21Llg+aa/doVAW44YnTfuQo/iDp1SA6NMFpqlLOF9PJJQNFFw6xsYPKztehpeWlTHrPaX54nSvPDNlMTMXlSY6H6z23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SA1PR11MB9613.namprd11.prod.outlook.com (2603:10b6:806:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 13:00:55 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 13:00:55 +0000
Message-ID: <6cba006d-5bef-4962-bde6-f038fd1bb085@intel.com>
Date: Fri, 27 Feb 2026 13:00:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hash: fix pointer alignment
To: Marat Khalili <marat.khalili@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, Yipeng Wang <yipeng1.wang@intel.com>, "Sameh
 Gobriel" <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Yerden Zhumabekov <e_zhumabekov@sts.kz>
References: <20260226142206.860737-1-radu.nicolau@intel.com>
 <20260227094852.960180-1-radu.nicolau@intel.com>
 <3d39b27078014135969fe54ec6b79e97@huawei.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <3d39b27078014135969fe54ec6b79e97@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU6P191CA0044.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::24) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SA1PR11MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 671d45b4-bf20-470f-8a3d-08de76003e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: dRQIOAgkxRXDZLz2hOho7ZTKD39ebc2wEBabuHBThxpuwcVM7xWkm4M+eZ2d1LdpfKlLS4q3ItSvLuAmjx1kRmvxf8ixnT6B0GJ/bL5tsCTMrDTH41sFg17Sk8ErVmy2KBDKvlt+6SBL4RS3RRx1lrt5Ig6SeTtVomabsSv1fZ8cTNAlK8AmUL7KEU5ueyOhapXNrclq3t4IijtLop/sWrv/21EpeA+TyBP6SXaYJDDs7QR/kYa3n2VsKW6+vG1FEBkcVLpkG26QRdpK9pCYpyUFn2w4b7hnH68tMhmdbht0JOo3U2j/XvUHtZX1CN+VIr9iKHo409TMSj8N+aL9eTp2LJinx9dCsPrzsStnFD3UHKO4PsP8srqA7ROSPHtIuDkClTEsVl5PIrKcXagCvZ3IRFz5vS64slZYISaR5TpbTq8iTN2f2QudAiah8sWi1MNfD2KXX59DiL5CIIuh3qfA1K7Tj+mrjx60fcud+xinVB+XWkYMhajNK5zJ6jClCrGK7k7qmUiXPeBq4lGpyr9rJGAhXy0TDYHovc10At9oaLLv54qZsPJAHxF9gAm2GFXQ1sUEWLrAltCwIG0GuYvn+wOW4E9jXHaKfUXjdXEo6rsOZJqBU45mgNx/EDzzGSNiQPbdauuPN0qm3SdM79IAaa14p5zFv2Er56iESC1CnUXEzoqY1S0giMVqRsRLEZIUPaC4d01cmzK1XMdhbvJ8d8/lh+BYc6lkTcIFeNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JtNWRQR1ArdlZUUzc0ODJPckZYM2lZMERDNVl4QmhLMzVzT1Y1Y1Jsb1A0?=
 =?utf-8?B?aFBydHFRbThWWWp3b2VkR2hENzdRcU9pWkZ3RHQrTVFBVkNVLzUwd1h3N0Ri?=
 =?utf-8?B?QVFBelRIQVgzL1NvZm9XdlRGdTh5M3BBWHVvelhVWUFKZjQyVU54Y2ovQkRm?=
 =?utf-8?B?Mjh1QTR1YlhGcTAvU3JYSmhVWWJDZlY3WWQ2VHI5Y0ZPc2tJS1lPK1E3eEti?=
 =?utf-8?B?R282VmRFVE9tRHBTTTBMWDZPN3ZhVXU4TXJ6dmFZWm9Bek5nUHpXMXl3Wmoz?=
 =?utf-8?B?TlFtUHhNRm1HKzhmaVAzRjlndGNVVVBTRC80MXJSVk5mSWtkTXk0UWxQVFRy?=
 =?utf-8?B?b1l4VGtvdFZXUHpMOFlZZnNsYjJ6aTNXQXRva1QwZUFaTjJWZEtoNlBTM281?=
 =?utf-8?B?T2dHcnNmVDlvOWxpVXl0WWhDUDBtY1RuSmJ0UTFHMTVSZGRrMWVSNzlFa25V?=
 =?utf-8?B?dXNNUFBKZW1NWnJnblVoTGoyWHJuNnQ5RDV4bXNWb1RhRm5MeGxtdW82Yzlh?=
 =?utf-8?B?dERDUlM1dFJQazYxV1ViZVcwS2xiRUpkZTY3Zm9wQ1JnMUkxemJCc3lzUFNH?=
 =?utf-8?B?MVdxd2FFMTFMV04reTNmZXhmOURucVhiNlczSTZ1UHZHZFpMakVNeGlUS2tk?=
 =?utf-8?B?STlSaG41V3VrWkhHdjRJSU0wZDZQcjBsaENhSG9NRkFaSmhicWVWWUZlZUs2?=
 =?utf-8?B?cVJKKzZua3pybEVPaStyTC9yWnFJcmY0TjAzdVVOM2R6eC9IMzdweTQ4cmk5?=
 =?utf-8?B?ZkROUnhodCtHdDU0YnROSU9pMkFSSC9Cb2N6amJwekRodS9hUWdSNVZFN1ZY?=
 =?utf-8?B?WVU5RW5ZS1FQMzc5d21TcjRPU1JxVERZMEVPYVFPbWRKaktJVG1JK2NHeGpE?=
 =?utf-8?B?Q0Y0NzV0NVdQMnJ2OUNFTEc5MU1tRVE4SGR1amNXeWtHVW1LNlFaUVRCKy94?=
 =?utf-8?B?QUpodGYxTGt5TVdseVhybW1kdGFzWThHNDJ1TXlHdFFNSnpKZG51V0I4WHd6?=
 =?utf-8?B?OU14bXozNFdjZmhCWkY3OFQrY04yeGZNTnVGekthM3djUGlPN01aRHFTeWhM?=
 =?utf-8?B?b2l2T2lhc1VkMUtyYzMybVJ5NFNqZkF5QmkxaUJsdksweFBMUkdjN1lJTzNC?=
 =?utf-8?B?TlBlTThyd0xDa253Qk1iU3F1UjlDbGZvbkJ1Rms0dnQzdnl1YWU2a3dOSXUy?=
 =?utf-8?B?cDFRcExMMGpYWmhrTFVJU091Z0F4K2h0TU5USmdMQVQwaUpjL21ucDc3QkdK?=
 =?utf-8?B?eEIvVkxOYTgyODdEU0JYOE91ZWc5d25rbEtET3lXNFZtNEJOSGllZzlMRytj?=
 =?utf-8?B?aHpNYjhENDY0Zis1TXRhdGVNOGJlbmYxQkZPQkhCbStqdHpjTDFPUU03Z2U5?=
 =?utf-8?B?TnpkSmxWRFA4c1FkcldIa0srRi9mdlpTMHRvcytRS0xIRWJKaW9jOFY0blYz?=
 =?utf-8?B?RE03em1BMVByMGhodUlGRnI5RzdadHlEVUYzakpaNm9xMllpOWZCWEdYMFNj?=
 =?utf-8?B?MnBQQngwTWZIS2Zjc2N6UmtXZ1NGc3o0U0xTN0tkRVJrRGdpKzlKemtIcHVv?=
 =?utf-8?B?aEtHRjQxYlV0MW8rQmpYbHNKMzdRN0I1dENQUmFnYVFzMWFxaS8xUEx5TXpk?=
 =?utf-8?B?ZjhLdHJod001eCtvdTJ0WDcxWnRvRVBLcG9rU3h1bXFFbTRSK2F0ZU12SHRN?=
 =?utf-8?B?Uks1dnhaa096ajZNVlBTaVlPY2NBeVcxOWdYYkNEUmIzRHBsRDU0ODVFa3F2?=
 =?utf-8?B?cU1NZ1Q2ckg0YTBzSmp0ZHBNQnpwRDJRUVRxbUZQZlExdmNOcTFPSUdtb1pJ?=
 =?utf-8?B?MHRoRHkwL0ZLOTRCa0FVZjFiaGtTZEFocTF4R044SnJTNUw2ZlZiYStMTS9Z?=
 =?utf-8?B?Zzh0b0ZMbW84dHZaNjljRHBZbUhaNDVMSWcyRDZKeUlweE1ZT2hUN0t5cHRt?=
 =?utf-8?B?WmJWcGdwY09sRVJ5R3p6Tk9nK2Vjekx0Vnk1UWZxc2ttcmhrUVBHUFkydGhx?=
 =?utf-8?B?S0Z5elkydUg1Z1d3aHNXdVJORS9kTUNvcm5wcS9BNGJHSjJQZjZvaDdlOW5l?=
 =?utf-8?B?VU5xamQxV1ZZblJHOFgyQ1hzbUlvbXhsYWl2eXhtMWRwdGtoRURnUEtpM0Na?=
 =?utf-8?B?TFVIYllQTmt6MUFjUzhTWnhJcU92Mi9ubWZkYXdiODBGVzRQUFZicGJLaGRs?=
 =?utf-8?B?a3VuQkFmb3JpYTRQU003OUNPTndBTUt6anFtdDQxS3JLL1l4dVhUeGhPM29Y?=
 =?utf-8?B?OVZkVHE0RkNLcVFsTmp3WjdUU29nWTN1aXoxdDNhYUpIUmdOVGNaRHVmTFJa?=
 =?utf-8?B?VkZNZ1Myd25qSENjTWZKTGFNT2F4R2JrWGtrZnRZSStPQ0FKRDlpQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d45b4-bf20-470f-8a3d-08de76003e19
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:00:54.9601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQmN6N5VyaHwmFbVSAMvlvrfECc0iMFEUDmgkB0eRMNyeHgZYZ+Khp8WOQ592U0X2HopRae6sjpeY2LFrb6sDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9613
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


On 27-Feb-26 12:37 PM, Marat Khalili wrote:
>> -----Original Message-----
>> From: Radu Nicolau <radu.nicolau@intel.com>
>> Sent: Friday 27 February 2026 09:48
>> To: dev@dpdk.org
>> Cc: Marat Khalili <marat.khalili@huawei.com>; Radu Nicolau <radu.nicolau@intel.com>; stable@dpdk.org;
>> stephen@networkplumber.org; Yipeng Wang <yipeng1.wang@intel.com>; Sameh Gobriel
>> <sameh.gobriel@intel.com>; Bruce Richardson <bruce.richardson@intel.com>; Vladimir Medvedkin
>> <vladimir.medvedkin@intel.com>; Pablo de Lara <pablo.de.lara.guarch@intel.com>; Yerden Zhumabekov
>> <e_zhumabekov@sts.kz>
>> Subject: [PATCH v2] hash: fix pointer alignment
>>
>> rte_hash_crc assumes input pointer address is 8 byte aligned
>> which may not be always the case.
>> This fix aligns the input pointer before proceeding to process it
>> in 8 byte chunks.
>>
>> Fixes: 504a29af13a7 ("hash: fix strict-aliasing for CRC")
>> Cc: stable@dpdk.org
>> Cc: stephen@networkplumber.org
>>
>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>> ---
>> v2: reverse the order of alignment adjustment calls
>>
>>   lib/hash/rte_hash_crc.h | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
>> index fa07c97685..d61420868a 100644
>> --- a/lib/hash/rte_hash_crc.h
>> +++ b/lib/hash/rte_hash_crc.h
>> @@ -127,6 +127,24 @@ rte_hash_crc(const void *data, uint32_t data_len, uint32_t init_val)
>>   	unsigned i;
>>   	uintptr_t pd = (uintptr_t) data;
>>
>> +	/* align input to 8 byte boundary if needed */
>> +	if ((pd & 0x7) && data_len >= 8) {
>> +		uintptr_t unaligned_bytes = 8 - (pd & 0x7);
>> +		data_len -= unaligned_bytes;
>> +		if (unaligned_bytes & 0x1) {
>> +			init_val = rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
>> +			pd += 1;
>> +		}
>> +		if (unaligned_bytes & 0x2) {
>> +			init_val = rte_hash_crc_2byte(*(const uint16_t *)pd, init_val);
>> +			pd += 2;
>> +		}
>> +		if (unaligned_bytes & 0x4) {
>> +			init_val = rte_hash_crc_4byte(*(const uint32_t *)pd, init_val);
>> +			pd += 4;
>> +		}
>> +	}
>> +
>>   	for (i = 0; i < data_len / 8; i++) {
>>   		init_val = rte_hash_crc_8byte(*(const uint64_t *)pd, init_val);
>>   		pd += 8;
>> --
>> 2.52.0
>>
> Surprisingly, we do not seem to have any tests calling rte_hash_crc with misaligned data. I tried to tweak existing ones in test_hash.c and test_hash_functions.c, and found out that rte_hash_crc still fails (with ubsan) for sizes less than 8 in one of the last 3 if's, and also that jhash has the same problems. Still this commit is a step in the right direction IMO, so:
>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>

Thanks for the ack!

The issue still persist with less that 8 bytes unaligned input because 
the 3 ifs after the loop assume the input is aligned, which is the case 
only if the loop was taken. I will fix the patch to address this case in 
the added section - you were right with the first comment.

