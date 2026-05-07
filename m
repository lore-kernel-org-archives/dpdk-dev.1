Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E138CD343B
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 08:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 246AE40265;
	Thu,  7 May 2026 10:08:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D1CAA4025A
 for <dev@dpdk.org>; Thu,  7 May 2026 10:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778141325; x=1809677325;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fu61aYaIJKOINTjeAY3AgDqa4mGjlK5IBnny1vZQWNs=;
 b=QCEBQp0mf+u8ia0yC58CeTNsbiuABiwzvMoBHXT+/Ui5+qVrEA6Wvywo
 VHzFS5IOcW4VoZl9N1B3Pxd7pu/7x55KK/ONYT+JSXocN1+25LF5+P35J
 TLMo9tPSudGoPwFVXJV2TOR2HwNdBBVu7IDqMvhuUlTd++gY0HXjpl2v4
 V2Gt9lpUkfcMbY7G1efCqGeoA3eJJzLYVRo4E9obV8GmAE9Kv1Ez+bcCo
 VZoPcLc3INY7z6iX1PeqvzSFsi7hdc0WCjQWbhjwxaU7hc28bAxVXlyJR
 UhxJshJKjaic3J974gOwNmTNj0D5TWEDvKAZVWwy3U8+SWotuRFeZ0DWE Q==;
X-CSE-ConnectionGUID: cGlrxQ2RQ4qaRWmD0k7QbA==
X-CSE-MsgGUID: Dwyq76O4QAupEpjSTaSe8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79074611"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79074611"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 01:08:43 -0700
X-CSE-ConnectionGUID: Ykww6VfcRXiYKz8T5PpehQ==
X-CSE-MsgGUID: TNnM7yH/ShyYsQTOQ5+o9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="241394389"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 01:08:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:08:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 01:08:43 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEintyGcQYu3rHRDshA70A5Fs7tWgLki3AHvZivwTfjBUAu7HeAmx2sfMvWAEHFH2GHSI1b6S7DKkZSYv5e14xkTEFo7bsYfkhJKZc5r6WE5vtQmQrLS4k88l/9MSZFRtxuFQRQyBZzT1PPmZ/ZiYWUsmAsbqGzk7UCgfU5J2UWuLQrVDFD++uUeMHkJVpbiObVwK5u4Ne/XXgGJf9o6v3in2st6UyTC/7jv80krFZbxOZxTWRQPSFQ8sGlXof2M0KsBf8at0UqciYQh63zZOuGE9+Ctl/NYqRwoZJ5tfzVQNZ7Mxh3OvAhDNVRODTuQiYxAbDbuwsGQUKmYRu1yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rNpEe5LrYuEyGdnU4HmOpPGG4X1wSkCmGGI4IZhuL0=;
 b=DPLVGx7FeVc1cTl3KnpFlUQLLTrxV3GALr5anP3wEC/gGmgwHsM2/6+H+MzRIus8esj/I2j5F5p1pAR1MYG36Ta2Dyce8uZHq6EsWXf2hwYQuix0W+c5sBUatlAcDkBdeUQHNVvD/O/aloUiyZeU8uwQb7QNDlO2M7b+6X9ItuJECMaIkzfIDlRLDEyPnyt12kRzW9nQknuX+M6aTegu1uKnMONUqvX53w5koL+rgUMUnr+J7XH+UQ//Pq0GhkI0WnpKy1RjHYg8kKXBBe0n1FQ4L1BVNtFU+AJGr1uBNp0K6+zmVxtEtAPuczQOH1gUNUhBVwZsqLd5fdM1iK5ynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.17; Thu, 7 May 2026 08:08:41 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 08:08:40 +0000
Message-ID: <3b9ba191-f086-4264-8382-653c06772e17@intel.com>
Date: Thu, 7 May 2026 10:08:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
 <CAJFAV8yNKxSXjmjQ0sM21-6hZDTVrGT9cpZ6aQU_FNTepTP4nw@mail.gmail.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <CAJFAV8yNKxSXjmjQ0sM21-6hZDTVrGT9cpZ6aQU_FNTepTP4nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::27) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CO1PR11MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 707141ee-8123-4eb4-7b0a-08deac0fd958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: v83++VTHWh4yKU7wRXJWPMvRRZ64wR9uQYydcy/idM7rcRES58vMzUKIHOtgCqrr6/juJ3Kfi6lqHNFHb25B8VmkeNk300Ty+HPNSc+ZyYo+JaT0q+XsD5gkL591ngyrsDcNkRmDcn34D9LlzJ/jkZSyz2WzDvnt6HEwjlaRgyIqJD5x9Vpk7LBGmA800Q7gEjCfUpcWMCWkz13QNdNRHaliXfEj4jebsemNwXB/e3UwTtbafmcYyHu+M42a4h3tE8kl9uWSVPca26EpsnyI4lcrdGPdReljrpsNTkTPzO9JXxaHSZCR/fIMCAfzOexIk+BqvbmG8hZ5GjKFfhLckmtATZa5SrSJsUYaHsVZ8JYbrrO6/3k+LCN2+JXxMVwuXp/FVLcf+kXcpLMNZSmhM42PW2hIrxKoOEekwB4PcEN2r/xmqf6kWUn/cIVsObVmvwF4uUd9icf/C9AELhMm/GX7GRN0+h8htyMmn2NpJXgfjyxEtcQa4OotuSxO8URljZ53uvR22c/FVnS/2Dj7MHoeVb5SYA3SuxA7hmcqqCjfp02C6/s4eLyHhByWoUfagMMwMpcil1h+pASXTE+zMODBs34qkCc349yLuze8/BMheFSgaDew//fdETb0RHZ+YGsr/IfPCVEBrTtfehFWkKLCS/AJCBO+ewEFIa6KArx4ngxE3iNhw+26HI4gFFjy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEV1Wkpab2M0VW5hYmVTNUlKa2Z2VVJnTkw2am9KSW5xZzdqNCtSSHNKS2ov?=
 =?utf-8?B?b1h0TnV0b29VYUswWUdtc293b0REdzdDbUF5Q3ptL0s0RTJMS1pMVWFZRnMv?=
 =?utf-8?B?S25ZME1Fc0FlRUh3UVdHcXlaVFRIeVNWVVM3cW1WMU9TV21qTWZHcUs4alB2?=
 =?utf-8?B?dTJCOWtVOXJoZ1dtcnN1MXZidWVvbFdBQ0dmSkpnMzJGMXR6UnVEUG0vZ0RW?=
 =?utf-8?B?ejVyeHdiT1YvNGhxL1cvSXl4b0Z1TFdwWWJNMWNmelNlYUZiQ2RNWjJPaWNh?=
 =?utf-8?B?N0gyRDU4ODBSd3Y0L2Y0UUU1dEMxa2pJc3JiemtWc09oWXZ6N2Q5cUhmNnRn?=
 =?utf-8?B?SEE0RjZkYUhjWWFzMFN2U3dJSG1ub0JJaUl2SlhKNW4yOVN1TjVrWlgvSk1C?=
 =?utf-8?B?M0MzRTBNTXFsaHk1MUwreWJZTUVJNUlmVFQ4K1VweEszS3dMT2tVUWpXU2NO?=
 =?utf-8?B?NVgrSFJXekdEOGJVNWlVN2VQTXFpaTFLMkhlNlhGQ2pzVEovbDZGSWxxVDBi?=
 =?utf-8?B?RUJxd2R6TXYveStUMXAwMGY5S2JnRTVTMXRmWThMTUw0SE01dFdseHR5SjBl?=
 =?utf-8?B?Z0RBYTNEOXU3eVhqK3owRjlrbWdqMU9TUDM4TFFybDBvVGwyb1AzWVN1eGIz?=
 =?utf-8?B?eVdZY2lISVEvWXZ6c29xWHltcmJRNU8rYUM2SVZRT3IvRzFOcHl6Y0p1L3Iw?=
 =?utf-8?B?dlB3VEdhamlFa0E1RVhZRk40NC9nWksyWGxGWlNVcVZrS2lDQkNoVmVhcmVh?=
 =?utf-8?B?SWtEOXEwVUpadXdKR2V6L3N2YTRCVWlUWjRVQytpZUJFSlNIUEdOdUhqcG4z?=
 =?utf-8?B?ek5NK3dPVkp0OUdhUEZBYUFxUWtHN0tVVkZHN3lUdUowNSs0bTMweWVoVFZ1?=
 =?utf-8?B?SDFubFFRZkNVRFVxOE1QbHdyekN4b2lDa0Z6QVJKMXBYdkJHWkZJdDFRMVNz?=
 =?utf-8?B?NHNNNmxPUEg1ZVhZNzNkZlZ4YUFCazhZNEhFSk9Ib0VaMGFZU0NsMjA2b1ZM?=
 =?utf-8?B?VVd6QlptMDV1SzhwOGFnbms3ZDJvUnFjdHpXV0FRWVpmMlp6dXlSditQMGhL?=
 =?utf-8?B?Q0tSUm9YVm1NTkJseEZZcWo1MFo2czZGQThCMXgzcjZadXFZZUlrZk9nRm0w?=
 =?utf-8?B?WWdacnpzWlRkb2xpYWNxTis4eW9tZmc3TFVYZGJrQ2toK3JuT2l2S3p0Tm9W?=
 =?utf-8?B?TG9HcHZwRnpSS3VmSFhpUzE4MmRMMWJKeTZsT1c2clhacVJtZ09ybWNMb3Yy?=
 =?utf-8?B?VGFsMkFzSWY0ZEM4aE8raFVGTTEyTDJRcGtxTmprUUovVUM5YXA1c1pwSlFV?=
 =?utf-8?B?aTJSVTNZbyt4dW13QWFYT2FnRExlMDdSSERnMGoxeHFzSEZxcVVMV1VWMVlj?=
 =?utf-8?B?MmVkR3lXbmNyamFISUg2RU9peVU5K2NEOVNXQm1tYWtZZHlib2swOUk5UFpU?=
 =?utf-8?B?RFdhVDl3STJGbzQzY0xtd2wvbTNISmk2SmlHMVBGbkx6S2dhUFBwMzZRYkFa?=
 =?utf-8?B?Uzh5ZWViVkp6dXAwdkdKSU9ucWRvNzZvS3VQcTNmZXVYdUw4L0hPbFh4K1ZJ?=
 =?utf-8?B?NWxYd3RFQWQraSt5NENLSFRhZ2RCNGFqQi9MSWNtSEdoRWNZeUg1N3pJQlU3?=
 =?utf-8?B?YjRsWEtzdmpMbnhFU2MySVN0djVTNklBVUpXRWs5azZzaGVRZXhyWEd4MEFv?=
 =?utf-8?B?TzRsVUxqYURYejFXQU1jYklXSDVsN1F5WUw5a3RtazAzMkt6R0g5ZzFQMWcx?=
 =?utf-8?B?NW9JS25rbzVzNFN5ZTEwK3M5K1RRMStYU0trRTl1Y2tDVDRCYUpSS0F2Ri8v?=
 =?utf-8?B?eWwra1hYSC9FdTF4Y3FTSVM0OXpibUxEZVU3M2NwK1FmT0JQaVFUWkZybHVS?=
 =?utf-8?B?SmJtUXRhaHJkcnIraGUxYUpUL3orckJhelUzaHB2cUtGUUJRTE5VSzhvaW95?=
 =?utf-8?B?MjJFNkZUSi9jQkR0UTBrOEIyNGhlUkpBNjdXRWZFUHVDN1hrRHA4RGNBSWtj?=
 =?utf-8?B?QUpBeGplb1IyM3ZqZUtab2w3eEVoN1ZUYlVwaXk3aE40bE9DSGR3SWN4SU9l?=
 =?utf-8?B?aldZc0NuL0FscEhjUGhDNXNXRlQrKzBtM3d1cVQxU2VLeEVFR0tjOGFZV0Zq?=
 =?utf-8?B?SFlKOEZqK1M3djdBeEs0L28yMUZlaG4wT3FLQVp6SVk3Ly81RktCRFIzV2Z5?=
 =?utf-8?B?V05YK0VXeE9Qc3l5RHphNXpvT1hOWndOUGtkUURxek92YlNKSEtBK3NpTlhR?=
 =?utf-8?B?SElwNHRDaHhjcjEvVUROcVpReW5kdVAvc2pGbWE4SjNtNGJvR1hmK1lDRnJu?=
 =?utf-8?B?Q1UxWTBkempLMDY3Zlc0ZDRVaUV3VisxWmlXM3Y4dGlBQm5wM295ekFDbHZa?=
 =?utf-8?Q?m34rFNXeuGhMrvCI=3D?=
X-Exchange-RoutingPolicyChecked: q62ZvjG0hQfdZ3C5HWXB+mrP0CDW4zMfZBa+oqYx3cNC4O9JJuFMjDWbmlJ6ydoOGgMa+JYFGGdAVSBDmlztW5ZPkaGXLlws+GEdi3uSM6ZQqXIqDC0gqQ20+dQ2c1MTNkLoro/bzQs3rXwgKEFHlAR6fOsDJqsPn1AmNj9oN0ZWph4n/SNP04B+Y9J88eGcS8Rsvf/nOfpXU+eiCO+WEFCaja+Fqip6KH4UC56MsZZ4BueEWJ5F5A9kQBFXkwHnSjboLTq/Z5ga6x4tJ2BdVSO6FYWJrxcFSbtEercN1oZuaKEbWZOHy5CASk2Mx1mYGAtgsquSDgr1bS1n1my7rA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 707141ee-8123-4eb4-7b0a-08deac0fd958
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:08:40.7805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZQkeV9UgrGDtuazW0tGnkW1Y3Xf+jcGBdH638b7+n8y0qAW+yz1lKBIAM2o1g2huZCsOdAbZvoUiYngD8izWVHp9Z9Opt1wV/W4WX24euM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
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

On 5/6/2026 5:58 PM, David Marchand wrote:
> On Wed, 6 May 2026 at 16:07, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>>
>> The PF will check buffer size for being too big, and the chunk sizing code
>> correctly calls that out. However, the size was actually still too big
>> because `struct virtchnl_queue_vector_maps` already had one queue vector
>> as part of its definition, so `chunk_sz` was too big by 1.
>>
>> Fixes: 292d3b781ac4 ("net/iavf: replace unnecessary hugepage memory allocations")
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
>> index c2f340db81..dd09b0fa61 100644
>> --- a/drivers/net/intel/iavf/iavf_vchnl.c
>> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
>> @@ -1528,7 +1528,7 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
>>
>>          /* for some reason PF side checks for buffer being too big, so adjust it down */
> 
> The comment above can be removed?

No, it's still relevant, because it refers to the fact that we're 
adjusting the total length downwards as opposed to leaving it at max size.

> 
>>          buf_len = sizeof(struct virtchnl_queue_vector_maps) +
>> -                 sizeof(struct virtchnl_queue_vector) * chunk_sz;
>> +                 sizeof(struct virtchnl_queue_vector) * (chunk_sz - 1);
> 
> - did you make sure you did not break compat with previous version of
> Intel out of tree PF driver (since this concerns configuring "Large
> VF")?

The commit in question *did* break things with previous out of tree PF 
driver. This commit fixes the breakage introduced in that commit. The 
commit being fixed was a refactor, which specified size as N-1.

> 
> - all those virtchnl list struct have the same elems[1] issue.
> Kernel side did some cleanups some time ago, maybe time for DPDK to do
> the same...?
> 

Yes, it is indeed time to do the same, but not as part of this patchset, 
and not before the base driver code is updated to do the same. There is 
some background work happening on that front already, but there are a 
lot of dependencies and moving parts, so we can't just change this willy 
nilly.

-- 
Thanks,
Anatoly
