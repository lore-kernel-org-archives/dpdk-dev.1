Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6162CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 04:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B1504026D;
	Thu,  7 May 2026 06:45:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B316B40265
 for <dev@dpdk.org>; Thu,  7 May 2026 06:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778129134; x=1809665134;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p9ufeLn9BodWk3ohIMWcyw4llFsxTxT9RohOIWCc7hk=;
 b=di3urNJhl8nVzKhuS8RzgIcg7sOcG5TXUPNcaLlDlSkj3JP7xnB7u56s
 CvZ45HQTmZGwyGvvecbeCSZ8EQ+u5Trn86x184LpF8VnrZfbE6lXriMgn
 ubOPL7y99EKjYSqYj47hyzct4Fa9sk5vvlQvdkDKQR7BvJGwUY1p6E0YE
 aYA1RnJoW/YsxOoEbzCejbytVUEIL1v1jB5Lc2GvhjRvYvD9+Y6d7UJkw
 9weDIKNvqWJi+I4Qk/fZ0Zj9UmO5gAJohBD+hqmy9Z+yBOfkJnsqLFb7j
 f74VYxh0moaygu6JzX9psivzSK0fusX2NdbexV91x5kN0J7iqnQgEzXQ8 w==;
X-CSE-ConnectionGUID: 4FHV5P2tQTOstFNL25FmJQ==
X-CSE-MsgGUID: JdMhVLiVTf2oRa+dTTFymg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79180106"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="79180106"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 21:45:33 -0700
X-CSE-ConnectionGUID: xmebVlMrTWuyppPTQth4Pg==
X-CSE-MsgGUID: RwCZvrxqQFW3t5a/exAZeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="240339052"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 21:45:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 21:45:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 21:45:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 21:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeNRlLTL5rGV375kfgfpMJK8MxHuahJRHU/DrZlnDH5HzCG6iaQQyDDqHNX2EuM+jzI+V7d1O/kWUtaW1P4d5wFjYA+qmwHdJg88ozfI0UbKKURfxieOgkEzsd09VTiFd44iI+Y/vEeckaGM9GrMHPFj+f7UTbsLs49XF/t/lJd9AaDhZyQ+ZakozDTxEvwLDIEK+b/VSPCQThdVaheErL4FPOg5oq/NN0Rsi4euGAJNsQaNiK0lkjXlSe6ze+Q/cmhuiL5nxSpkKpZ58pMssrIEjJVtsYBmq7TrG1/thijsfWzJL0DxgffOVHoFL4FB67yafJqywGqhzNdQBlcfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzYnKj00HvQQfjdO+Nx1uCmSSc1NJcnod1+pq/mZOEk=;
 b=HGLUpqMS2fcyizNjUhwf0biBjCMX1YcGD0MBeKZvqn9JMlQDhgv151Uy4a/tkDyWxOUiVNXUR0k663PkpaZiIw9MIwtzJRlYTUrr94tLbTMfJKtCsBkNt2Oqs7ElCBFBxN2U5X4/fL6ECHr6dhBV6e0pja3/Vl1tvwUQP584xr48PYX3ppk0DL09NZ/9UBCgjQX3K1mohY7IC8+IuPkoy8qXyEtX2rsrdE2sniieqM3gw5XFv8uWEBOYtAff5RidWP6BI6hNmMnRm6/JSRMLiTWcJdLg31M4POKW2mLD0RbMBojzguTUYAS/w0U0sxMFB/0eSCn2sxAns+qmiHWyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 04:45:30 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%6]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 04:45:29 +0000
Message-ID: <42658998-715a-4589-b162-f3f840302dc1@intel.com>
Date: Thu, 7 May 2026 10:15:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 1/6] ptp: introduce PTP protocol library
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>,
 <stephen@networkplumber.org>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260506154131.2496072-1-rajesh3.kumar@intel.com>
 <20260506154131.2496072-2-rajesh3.kumar@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65849@smartserver.smartshare.dk>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65849@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0162.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::17) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|DM6PR11MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: ce67e53d-ce37-4978-3cb3-08deabf376ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: 68jk1ybrDz6bd6OEVTS3U/WhtcdRF00UoRycSPSXpw6rmuFZjKnVWJCvrT7guwSmhc09WQ7DJiKDYUNbn2ra5LBCw9Fd1rFGKGIZxkhKk9uFL2+jRsf6JVwx2wahqXe8HEJfnKRsDcoC9ChRMQ5C9wXnfJp2/mW+URCd6B78+/uJGBd3YsBB0azZ9SbPfxX6myfCT1LGB0SZu9Ssk6413/UPa4VwdXRj1368zMpzBv5klw0kE/oRI2COeC99MKUYP06ByR6Oi27g9JO9ImwTKgxbYGRDnBR7Mo4Hmnhz4tL4lGXpP8EOlSin8T+HMy9o6DHpg9YIyphaa3WWDpPfp1aDtjrVgDX9QByHTyKX6wTBo2ZHJcSBQdziYRJnqIBd82Mg1XJdZhhlIHNVgs8kdq2OTgCYuWu93pQHwDs0pB6h3mDis6WqCini+VX3B3yAcQmoPNGLdfliMT7l6hDq8nbLDBAIq+RCwh57Okx+XuktInApPLd/F4E+bFf8KlzIg45OPHaPv2VMtdKetUneAirHuSsQMoFHj36FFEThF99CnPQ2hx2RZajNx1nVICbLDZ6yr6aAeWe04oW8MWRIWbUqeqpfWRxADftvlLiD2iaA6LFoSxz2e3FO/s4pXsbc2GVYi1GaQSYQdQ9xm26bMH3uKuGSbDexVGGxUepMtg7rSzXoedV9AOEs2B9wxC85
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJtcEVQOWNWZWN5aG95aUl3cFRtWkdGVm8yNkU0MUFtSitBMFY3cXRJamc2?=
 =?utf-8?B?M1ArNDU0OGFxN01NK2Nub3E5bWxBMnp0aDQzTUs4cVJySnNKZy8wM0JLSzFS?=
 =?utf-8?B?UlRnNnhBVTA5VEhPL3RGdUlxWk9zSXpqVmhlVVFyN1c2eEJMblQ2d3FuL3d6?=
 =?utf-8?B?b2hiWEg3cjA2ckJUYldOaTlRWlg4SWpmcU1lRnp4RUVtZ2QvOERnRU1pY2N1?=
 =?utf-8?B?djIrbmFzTDhNOHltMmU1VXNKL0JWUlF5WDcxYVpvU0NLZXZ1OUJqYkVuK2FU?=
 =?utf-8?B?eC9nWVAzV3VKVk9Cd216OFhMbWwvRkFZZitRWmNnOVh2SlYwY2Nnd25NWmtm?=
 =?utf-8?B?cHlkQ3U3T0Q0aUxSRzdyWUxoM0pJbENRUnY0aUVtb0piTVdQa2RoYkU0MUlV?=
 =?utf-8?B?aHU5Smw4K1hjcDl5MHpYUzVUTk8zYitxZUhJQlhROXlUSmY4VXd4aVByUXln?=
 =?utf-8?B?YnYzZTBpUXBsRE1HcmVWUm8wMDVBNklUUzBNVDBIQUZVdWxYY01lOUVyYm0v?=
 =?utf-8?B?dmdZSlpKV1I3TGltMHh3akRpRE4reStvc1FTV0ZTczNuNGFyVHVyaXVYTW9G?=
 =?utf-8?B?eWZLWlM4V2NUYi9DZ2IvU2J4RXhZK0p5WFlZdWl2WStHaDZSdWRPQWUwbHM1?=
 =?utf-8?B?ZGtSZ1lYUC9GajBQbjVYUjRMTS9oYzN0alJJanczYWV2NzBtU1pTK1Z3clZa?=
 =?utf-8?B?TmpBbk9Md295N1NTcVhheThIbmdlWmNWTnhGVHFsOXQ4MEw4cUJIakh4WFdB?=
 =?utf-8?B?cDlwOG1CWFRzRGNUSUMvUDUyLys2MXhscGN1WDdJWUxOM013bkJ0bDZXV3Qy?=
 =?utf-8?B?Uk1RS2ZvVDJtVUpjOUdwMkVDRXkyQyttOGdPQTM5SzVPdHRUSnBORFp3QWpP?=
 =?utf-8?B?c1ZLZ2FTMDg3VGR5N2trdzhjTHJsNEQ2TXYrd1ZlODQvM3BNK3ZCdURsOHMx?=
 =?utf-8?B?N2ppTUQxanBvSkdWVzJ3Z1FtZ2phcXVuaWU5SE5PazV3TWN5NmtlNU5UTExx?=
 =?utf-8?B?amdkaUNVUm5wVFkvcGNTZk0zaThNdVk0dUpQQkZyNkJZMU1yQWk0ekNGc3N5?=
 =?utf-8?B?bnNER1VCWCtDTndQYmdnOVNsb2VOandzRm1nTTVIT1pPa3NsbFJ0dk5TL3A3?=
 =?utf-8?B?YXVFSWV2dGxsU0JONFpxUlFhRUoxRzBrTWVWNG5rVnlqTno1cHRVMXFXcCsy?=
 =?utf-8?B?MVN6bUtNWkxvaUFsTkJkaVhJUFdQTStzcmhoZHNVTEp0d1psMjQ1R1NVSkJ2?=
 =?utf-8?B?SnNoV2w0YTZIZm0rNVJpOGFIZFJ6ZnBvbUoxRFZ2TU1ac3M0NEY5ZUpuQ0Iv?=
 =?utf-8?B?RzhaOTdRcTNPdC94a0RMV3QyVEJxeGNzVU01eDh0ZjhFZzVUVmdRSDNPbCtP?=
 =?utf-8?B?WG10eFBBT2I5MzNvbUZIMDRiSHpSUDRZcFRWaE1QODdQdFRDeUpKcWZEN2c2?=
 =?utf-8?B?N0pOaE1nVGxSODlMdDJzdzFCTWx5cHhSOEFIcTNRUnJaWFQ4UmQ3cFMweHQz?=
 =?utf-8?B?RG9OOGliL0krUXV6cW5pMkVORXZSeXdqeXl3MVAvR080cWZ0a3J4cUtTeDVm?=
 =?utf-8?B?SEdyRGVxNndUUm9jeWJwc3VJM2hCL2huK1JDdkZyNFpKUnVzZE93NlkxMmU1?=
 =?utf-8?B?NEs5M1lwY1AzbjhWTDNSem9JWXBYNUdZMnpVbXRrYzVyaWkyMkxKU1FPdDBq?=
 =?utf-8?B?SVAxYlljMkYyVm9DZm9QeFhuODZhZCsvempHc2N4NHk2cmhmbjc3d3BsQWlS?=
 =?utf-8?B?NGpWUXVaMFR4Z3JYTVhvdG53Mjg1dEdGUERZbGE2VnplTkdiYjJvZngyTDl4?=
 =?utf-8?B?aHNlWlFQdE00elZ1b0JJaGlmVHNDN0dLNmdwYVV0N2dvVzJVTTNyMngzbmFu?=
 =?utf-8?B?Z1J3ekJoKytwTkN0ZHQ3Nkl6OFZGREFISE1oN0htT09zWFNXUlpwM2hFWGsw?=
 =?utf-8?B?WWlCeTZwcGZZbVBGbnI2V2FNVURicm1ibmZQY0gvSmpYU1hHd2VZcVpWclVP?=
 =?utf-8?B?WVlpWUU1dW5mV243ZEJERlZxRGFRNXFmQWtaamRPN1BQT1BZQUtBUTRHb1VT?=
 =?utf-8?B?VkZ6WUx5SW9EMzAyUjhGUzNWUzEyaUdMRHRnUE11L3RERDJrZHdJRGkvZ3ly?=
 =?utf-8?B?ZDlTVHl0VytDSEl5NHA3SVQ5Ry9WakplUG1KakhTYzFHSlBTb3lVRUZXcEpT?=
 =?utf-8?B?RGNtTmVURDhuTURjMU14eEJLTlhOUEdlMVRmVFU1eG80STJwSzlEMTVNcFU3?=
 =?utf-8?B?SnJQM0VrcjRsWlQwcS9LWmU5cFVyRFR5MDZVdDY2RC9YSzU2MG11dDArTXYw?=
 =?utf-8?B?ZkpEZUV4djlKcHNFMzYwallCVFBzajNNU0JVOExnOVRzZjg2SXNxZz09?=
X-Exchange-RoutingPolicyChecked: BLEvEki5FzN+aZ98Bg8UGX6HGBr6piIjb5z0T8Nd6HOFLoqFb81D1Gfc9WSytgmDDJk0EZqgVXGzi9uxHrUhuLuhYwz4bam4t1WmvWK4El5OYQKPGvBgJCmyN8e6A5n78a5j/KVfpgiz2hvxGaj4K4OTKTp+of5aBHEeqrQzwHds1JzSfUwNw8cAj5u6QTyqQkpXqUtvTgx4YtRhgc7qfkNySI29ri4dLnmallBntz5yVnzgpUMvGmx4MdTa0jrq6NLkSmIM0++qpnbKeyDtbEPdLEL9bAciQjifsgQozLPkICv5qapoMSooUREmgoqzHUTqcf5ZW/rqDwUtfgyYAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce67e53d-ce37-4978-3cb3-08deabf376ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 04:45:29.7947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d16oA5U8KrBqT1r1tODl+kNfj7zmUMFy7GsClFdI5khXDrgdG4zrDocAw1Vn+MfvdcFsG1LtOv4ZgTD2sJXbWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
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


On 06-05-2026 04:32 pm, Morten Brørup wrote:
>> From: Rajesh Kumar [mailto:rajesh3.kumar@intel.com]
>> Sent: Wednesday, 6 May 2026 17.41
>>
>> Add IEEE 1588-2019 Precision Time Protocol (PTP) processing library.
>>
>> The library provides packet classification, header structures, and
>> helper functions for PTP packet processing in DPDK. This avoids
>> duplicate PTP header definitions across multiple applications and
>> drivers.
>>
>> Supported transports:
>> 1. L2 PTP (EtherType 0x88F7)
>> 2. VLAN-tagged L2 PTP (single and QinQ)
>> 3. PTP over UDP/IPv4 (ports 319/320)
>> 4. PTP over UDP/IPv6 (ports 319/320)
>>
>> Public APIs:
>> 1. rte_ptp_classify()
>> 2. rte_ptp_hdr_get()
>> 3. rte_ptp_msg_type_str()
>>
>> Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
>> ---
> Improved PTP support seems like a good addition to DPDK.
>
> Here's some high level feedback to the library:
>
> I think much of this belongs into /lib/net/, which holds similar protocol structure definitions and helper functions for many other protocols.
> Please familiarize yourself with the code conventions in that directory, and move the relevant parts of the PTP library there (following the code conventions there).
>
> Remember to define the packet structures with endianness in mind; e.g. use rte_be32_t instead of uint32_t where appropriate.
>
> Don't define simple aliases, just use RTE_ETHER_TYPE_1588 directly.
>
> Your DPI (deep packet inspection) parser function that can parse all kinds of PTP encapsulation does not belong in the library.
> Applications would rely on a layered packet parser, such as rte_net_get_ptype().
>
> If you need a DPI parser for the examples, feel free to add it there.

Thank you for the feedback, Morten! All comments addressed in v6:

- Moved to lib/net/ as a header-only library (following rte_tcp.h 
conventions)
- All multi-byte struct fields now use rte_beXX_t types
- Removed RTE_ETHER_TYPE_1588 alias; using constant directly
- DPI parser moved to example-local ptp_parse.h (not library API)

