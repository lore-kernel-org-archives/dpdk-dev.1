Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2CEFD7F92
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 11:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08D91402C5;
	Fri, 27 Feb 2026 12:01:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 538B04027F
 for <dev@dpdk.org>; Fri, 27 Feb 2026 12:01:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772190062; x=1803726062;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=in+v8c7KZVMsAp9PRZ0xct/9rOZYsi2bjXOuMzxF1TI=;
 b=Je6lYc+EtuIIAXIWn6J4rdy7Zjvkio54mrVWUCY4brZrZEqDdgiYTU+a
 5/dMAV7MCo7gb9h4mZvQfDBMbqYxI6opZeKyaQw0T+DiezD76GZgr+Wod
 Cdtcm/4T33IJ6nQ0u+Xo2GmEnCW7YIu1ToCirDecgum73ZlasgDY+Pk1l
 Hg+V3mOxxnGswMfN+UtTadclK/udKFj2t9ePHEyIGt8M8hB7IqFe+p7NR
 3SU4ixOZm5gbCyutFuz4JDjuoZ8Xtvj/+4UatpghZhqouCIovU0if1maT
 +bdSbUfcVB6Ot2Yks/X1JMACQ+yhRC5QoFUvk/RrV5p+38WUDuKTpt3Zn g==;
X-CSE-ConnectionGUID: lN0MzgzgTLuDSIMYH8aTOg==
X-CSE-MsgGUID: yNNzrTRAQrigoQxzpvSLOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72300989"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="72300989"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 03:01:01 -0800
X-CSE-ConnectionGUID: rN5Rd9uxQ4GK83ijSXwWKA==
X-CSE-MsgGUID: IIJlLKpWSVu8c37np7bcUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="221868618"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 03:01:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 03:01:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 03:01:00 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 03:01:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuxTSTuCRmZxgyDJeYZ9eqzY9zy3sF/nyxejZXaUZXSRJayxbGNiDo+nR0yADxU6L+jqmUmhWIejoFZLkIvBTRGdZSWv6dR+/StEIfqCo1mMKEtLDgW/LnD0j+RMhlb2UygbbnIQgoF3Ns4EDrkAKhaHIYk7YF9XGYy0F0O4zDgQ327Oux0J/r3Ryo9RpBr43yAv9EZe9q1ea2AouYtNS1+d2bB4zs+v9YDPacJb98cvC6/SUSyyM9RW9VXsIoFm4cbgM9b3JNTGmXP76exHl35SAtRQl+YOCAHJd0y/ptH+w99+RoIuIuLCG1Sq8b5XUEltb7c7cUGmIHLUXVgjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6I2o95wJRuf5PIweLNqS4XuqWrjM/YXWAehCXArK4c=;
 b=epJaTtBvHDuLZS3YpbY7HRM4I4jEPlCOc4b/CG+/flGQFlvWT7+fyXaALky6ZDZ22tAAh2m5A3sjGuF0Ibx0MhDAd75QRy6EililemIp1YiJSfOOsN2X/18S4PEWBBnXboaAYeAFMoSdTfgc/e3E4KMTAoGyBqIZ+AybAOm71GOfO5N6Nuii0/cjHQxac46/CWoQC68KWnZWyZA/9kpmsECKzbaJjTbA6CQkvX26Prk0vIIWYr40novYwMim/IyzKsGTj37MYV/nAvKgS3C81qmz81FrDJnmOWhKQo9+U2W5ILL27y54kqIJ0nhXR6KS6x/efUl78issT8zYmVd1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV8PR11MB8464.namprd11.prod.outlook.com (2603:10b6:408:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 11:00:58 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 11:00:58 +0000
Message-ID: <5f6daf58-7fe5-4975-80c2-51d08d6eea1d@intel.com>
Date: Fri, 27 Feb 2026 12:00:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] cmdline: add floating point support
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
 <162c8c5bbecaafc97e698196e57b7835d794a83c.1772124281.git.anatoly.burakov@intel.com>
 <20260226101935.490f172c@phoenix.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260226101935.490f172c@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0267.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::32) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LV8PR11MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: b4775d6a-d13c-4144-bfa0-08de75ef7cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 0Mi0eyLyMTOXwYQOgF7MdFL1XnTKdJuXplWI2aarQMdj9xjUz0bPCyvDyjl08Baz4qJ/Xx9oNc4RyeoAF61IJlyzl7Ol947XSNJRzvOcYJk+k0bEXtZNC0LQaRFyqfn60bmLPjkWvEcsdEBSs5L49w8k5fhrnZXJF27bxerMX42qc5nK1wRL5vuXBVbWvsKQaBHbyV/Ohh+IK3n1+jWiNi5DtTqzxxFFGjgFNTBUhkn7tXoW30rRjf+uS9GDtdnw/hv7lz8uhSe3Jc+SMdzZP9b5xKRFupYlQhvekyPc7WocieijV3TRayzZMpb5XsZ54oPm97OFZuz6AAQ3gswCIGSxDqw//bHYzuwj8HSW/PSLP+TEaNbrcPU0qcFBLcupAHHkGfU1edudAFDWNUCVBKtqzlgl/wsaGe6pNYiU/haYCsb3uFeWNM9RUaD9fovkpZzja8jpm9wUxBYi6PjO/kDNk4lgn7mqYy60libkzF60DishyOyNNRB0FJN78+JUKZ4NAmdNzhL+242U+LmZQWA3eQS1KRCdrDmoEGFZhxw+v7QTSwc165R9uVnMmjPEL2/bQANfsL4NcfdbhgR9mhxSAuAsl+8UTdmbOTUxibVySmIEEhSEi0xdM6260c3nfLQDj4AsBKOBuUKSMEUGnQHT2fNOTISGu/qELcu5CxXhOuCsnsq9Nb7FulDO0RJl9jDXgmoBDW2eu9dOTLpACtfOj9ABEUORzuBT5ph47d0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFZZRGEvNmljd0VMMW5UWlViL29NZXhlV0J1R2xyVVFpaXIzcU1haUxIQlpR?=
 =?utf-8?B?MjUzeWUySXdtMDdhSUFKanRMSjQ0OERRMG12Lzc2bkFjZHRBdk5HOXRXMWIr?=
 =?utf-8?B?MS9ER3hOT0g0ckt3N1JGdmxsN2QwaDNMSXlMWFo2TlBhNUwxdWc4RURhSzB6?=
 =?utf-8?B?Y3RobFVtd2MvQWRUcFhMVU80OFk3ZmN5ZjZuMjR2Y0ROVWZpK01TL0RyekEy?=
 =?utf-8?B?TzNTT0l4bitncy9xNzMvSDJYMXdIUk1zTlRzVzBjQWc3MytOWlJDUkZ4VGZ6?=
 =?utf-8?B?dy8wVVdyVWJMOXVsd0dhT3Z4eE1ickNCdWdQVVNJOVVVOEtESDBHb204THNQ?=
 =?utf-8?B?ZGtnMnZsL3dRdXl1RnRMNXdjcWhneWVLNXNIWFdtMEY4WndDcUlmMExFRHhi?=
 =?utf-8?B?a1ViN1hFZy8vcVlobjM0SUVtLy8va2k0WjFwZDZ0b3NqVFllQWpzZFJoNGdo?=
 =?utf-8?B?Q2I5cTNzbU9uQUYyOGJ4SWptQ1YrZ2VwUmNJSXlUa3E3eURWZDkyRk11bVl4?=
 =?utf-8?B?aEFZTlhsVjB3QjFmbVhuQWlMQkRMVFVMUGI3akFxVVptV3EwK1IwaC9relBE?=
 =?utf-8?B?Ry92SUlrbE1hdjF6WGUzVmwzcmRvZzB0elVKSHZYZkFNK0ZJSGFLZEJzQmN4?=
 =?utf-8?B?eUZXMjlzYitsWUdObmk5OHIxNUVNOGFUZ3RQSURramtaTjJXUFh3aE55Nzdx?=
 =?utf-8?B?WVA0SFoweTVZVUdhbzJEOTAveXVaSXhKU215QkE2T0xYSEhqKzFzeTB3Y3Mz?=
 =?utf-8?B?azhReVJJNFhKREx1MHprU2QxK09TV3AxbmdsN2plbVNScHNPbFozL0hyZWhZ?=
 =?utf-8?B?Y29iYkxaQ0wxZCtGdDB0cmxUbGh0TzMyQ3NkQlN1Z3dvS1ptYlRwSFBRYnZK?=
 =?utf-8?B?L0E0bUJaR2wrb1BYRHdhT0Y0UjkybmZyQlk4RHFQck9qZVFVcUNLSTJGU3d0?=
 =?utf-8?B?akZjcHlPdGI2QUx0THlZbG5JOFJtVEJFRlFoTDczLzd4d3lpU3puaFR5M3lr?=
 =?utf-8?B?eGhyZnY5amF0Q056STJvekhpOXFwQjZzWkhQMlJ4N0VaRzdVR2syRTZnK0JB?=
 =?utf-8?B?bW5XMHE4RmdXb2UxKzlSWEpCclBGL08zZ3hHQVcyM3hCRjhLQSt2ekgyNm9m?=
 =?utf-8?B?OXdCdTFxQmxvVmx4RlJuYUxmZ1huRTd2WCtYZm4xVVc1SlQxSlZkWTZ0MlRI?=
 =?utf-8?B?SUk5dlZRaEdTeFgzV05jV2VtS1hsTXZMK1Z2bmIvc2dMci9RVGIzaTloM0RF?=
 =?utf-8?B?d2NtZkZ6czE3WlpYUkJ1QmpFTXZ2ajdvWnhEWHh1YktMNHFyUHZSUjEybStz?=
 =?utf-8?B?VUVkN1RmWFlwbC8zMUFNb0dBNXZndDQwNGtLaEVhWDNuZzJMM3krNm1QOVN3?=
 =?utf-8?B?aFhGWXhkWncxMG00MUlzMjcxK1lZcWNnY2xSYnVZOUU3UmQ4M09jMk9pQ254?=
 =?utf-8?B?Yzdxc281eEhhK2lkUXlxVEpGTXFOcFhYeHJTTGlXTnROL1dCMnBRd1pvWDRF?=
 =?utf-8?B?YVB2R1B3RGd1L0NWbGhqQ3hsQkExRjlleFNWaUh2OC83dGxQdHFtZzl5dFpT?=
 =?utf-8?B?V3c2R3lzdllFd0FIaVFsY1RmNUNBOWtqVFF6eXdyZ0EzQTVDQnJOY3lOQmxa?=
 =?utf-8?B?b2tpQy9oKzdGMi93bmUwd1Y2dEFEQlBTRURiVnVEZDZQTXp4T3lRaDhiRUlS?=
 =?utf-8?B?WU5XS0J3eVBpMGdMdWZjT09UVWk0K21RWGZFdDlOOW1sMGV2blZKYnlFdzdq?=
 =?utf-8?B?NklhWGVCTWE2aFBoYUFyOFhnVVJpRHVmcnBWZE1NeUtNL1VELzk0NWcxUVNj?=
 =?utf-8?B?NTd2TXR2WFkzQ0hpSnhIc256MGhWWlVudElwVHBCbTZ6bWoxMUJUaGV6Vkh2?=
 =?utf-8?B?QjFwa0h1eFFXeVlwSHBwRTFNL3pZRzVML3Fhc0xORWJDdFZ6WjZlaWxPSWhm?=
 =?utf-8?B?Zk80Z0NiOURzeGlwVjhUSXV2UGFKNEhTQnFia1VxZHlPUUxlVUwyVVF0dTlL?=
 =?utf-8?B?QUdGWmdLMXFsc2hCVjI5OUI2RTZsd2dGTlhJR3lQQ0oraWRDN0NveFBydndE?=
 =?utf-8?B?Nk1EVklhQXhPUXRWK0ZiTUE0R0JFdmtXVE1GSmtIRjBvV0c4THN3Yk5EVjFt?=
 =?utf-8?B?RjlhcUNGcWlISE5wamFrcGhQczZvMU9tbFpmaUQwQkpIa2s1ZE1RU0dLNkp4?=
 =?utf-8?B?eU9Fdkd4NUVEZUpJRkNCeng4dVFjZ1dzUWNicm1JMjAxL3pKaGNTOUVvWVRG?=
 =?utf-8?B?NUxuaTRMdlo0ZTlCd0RTb0Y2TmU1c3g1OFZnVkt0dUpkSUFobjVXNm5HZkFV?=
 =?utf-8?B?TU9ORFRxUXpEV1ZsTnNRVE5MZVk5b1QxdWdFdGQvZEFPT3hBbFM1MlRCcFFm?=
 =?utf-8?Q?5DK51B+ccbYV+Pzo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4775d6a-d13c-4144-bfa0-08de75ef7cc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:00:58.5412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3W+14AdCQq++JUXDvPOmAo1ZHZGB3uShT1n3VxaCUxquIWvLaZLv/T+32f8PRBk9usTq9fh7XOOHjKdQ1Jq3KvN5tnfR8GQQJWsTMQQggiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8464
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

On 2/26/2026 7:19 PM, Stephen Hemminger wrote:
> On Thu, 26 Feb 2026 16:44:49 +0000
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> +	if (type == RTE_FLOAT_SINGLE)
>> +		dres = (double)strtof(srcbuf, &end);
>> +	else if (type == RTE_FLOAT_DOUBLE)
>> +		dres = strtod(srcbuf, &end);
>> +	else
>> +		return -1;
>> +
> 
> You could use strtod for both.
> The conversion from double to float could happen in caller.

I did have that previously, but parsing a float as double then 
converting it to float yields slightly different result than parsing it 
as a float directly. Unit tests expose the difference.

-- 
Thanks,
Anatoly
