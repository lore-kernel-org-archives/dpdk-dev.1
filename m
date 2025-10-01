Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD4CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 11:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14BE740DC9;
	Wed,  1 Oct 2025 13:16:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4317640B95
 for <dev@dpdk.org>; Wed,  1 Oct 2025 13:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759317395; x=1790853395;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=bHzMdBjdqU+GhoC9oDu0Uz2JqROrtk5R5doXhjCdsP0=;
 b=a2mp18YHt17q62RY2EgZYbmxthhHG/uCAwETMGVg098RK15pqQ+wow8D
 LY4F2QZGv37FLmtPiitSj+E2EEFLzdNrEhWr21BQmAY3JeL9NKed3U0Jr
 ELu8dp1hcGhvQ7088M7l5Qri+RYo7sC5/SBBbFhPKzJxjGCp9VTXKnvM6
 SMiJ4vF/WLhmk4uYSt5Y7lIUMqmTuPmymGHjrSxrRtpUYMtXYxuXF/7ky
 LX4FPpW3hzEAQeykL5vGo2I5PDQGAJvglRsIgWaUu/NWRiVspcJoXItM1
 Y/yfwo4OB5HUtDznSt0mDZP4YOcz3Qa2uSGMiwANx55fNFvdRHfGQ7rAr g==;
X-CSE-ConnectionGUID: q+ELSR+IQsaDZvcg7RSNGA==
X-CSE-MsgGUID: EH22UH1ATx+Lmoe2elIZVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="72945623"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208,217";a="72945623"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 04:16:34 -0700
X-CSE-ConnectionGUID: Mmlzqo5+QlaGIfT32qH7JA==
X-CSE-MsgGUID: rmVIbSqPS22VYMMLpvkXuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
 d="scan'208,217";a="179531909"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 04:16:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 04:16:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 04:16:34 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 04:16:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oENmECTW0zUkCqL+Fwzsosj46iwBMPaR8U2tsKEEW9Ra9tRKcQST0bLb0zUJJn+MxykU97YHhEKWUQz/5Tbl3AWLkBwCz3T9Kx1K/9vMP9PHXswJlo4z0rN64SVZYQkPBU5UEGjuuRejMqYmBksbZFtOPzHsdH+jR54//k8SvnpVS9lec+bmok5LR8zbD/lH20Jno1PwFHzSyE9BtZhTG02m6ug8qCKLd9qtmMF5238Iras+G6IgGnnIdIhvvxFbHqJRZdh4yrkUKFPL1zVgEoH+qNzVZfO0c5CK8/169e18aIvIadvpXxbNbGG0mVU95xNjbWJMi51NYi+JA0xD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/lcpgtcD4eDxT3Gc6umLnXmQ7oZ2eEpwvHKaqt+UUs=;
 b=gVEgj5bh6No6xJ0njPMpzzucukif8IZu4NBd5+QeiTnmRpbhElS+J87sNQH2/GWoARXd9OehCvVgyy3VuPfsrzsZL28pHCr6zf/bvc/eoa1Z4Kx6QLe9eiHaSCbD/woSCeEJwSIc1Ji/JwdllwhrmHDSLB5auqXHmLG6UseHS0gUurVD+77cvTvNoPsr13wMl42APN3fBtuH1n6dBazDBYrB1FRlTBxsonOzLBaOul5JZhVddBdCBXnZIj4JxgMlaqqZLibGSbuDgU9AxhHHoFw5uzBpfTQWVH78PH4OTOCITPyWNb8SNCqTQ8S2kNrE9/PXmoJqW6g9Ur1p0y5rZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14)
 by SJ2PR11MB8539.namprd11.prod.outlook.com (2603:10b6:a03:56e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Wed, 1 Oct
 2025 11:16:30 +0000
Received: from IA1PR11MB6074.namprd11.prod.outlook.com
 ([fe80::49e1:819:e42b:33b]) by IA1PR11MB6074.namprd11.prod.outlook.com
 ([fe80::49e1:819:e42b:33b%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 11:16:30 +0000
Content-Type: multipart/alternative;
 boundary="------------OaCr1NgjMOX8IzeYn3Iqv05F"
Message-ID: <ca9c8c7a-f9c4-4358-821a-67587eb20d94@intel.com>
Date: Wed, 1 Oct 2025 16:46:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] net/intel: add config queue support to vCPF
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: <dev@dpdk.org>
References: <20250922094819.1350709-2-praveen.shetty@intel.com>
 <20250930182718.2997819-1-praveen.shetty@intel.com>
 <20250930182718.2997819-4-praveen.shetty@intel.com>
Content-Language: en-US
From: "Singh, Aman Deep" <aman.deep.singh@intel.com>
In-Reply-To: <20250930182718.2997819-4-praveen.shetty@intel.com>
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To IA1PR11MB6074.namprd11.prod.outlook.com
 (2603:10b6:208:3d6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6074:EE_|SJ2PR11MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: b84d2720-7aea-4a10-eaf4-08de00dbf86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SktWaGZjYXhmSHVwbnhoTnRiVzVtay9uc1ovWlZLcXJGVC9KTGtLY25SR3I3?=
 =?utf-8?B?anJrTmFpRmdOY2NJbEd6azZZYS93eVQrRHBHbTRZb24wVndaZERHWGM0VjBO?=
 =?utf-8?B?bXVtUU1maVkrZlVqaWZRZi9nU2hIUWtBWUl2TTYwa0VlcGR4blVlUmx5V1JX?=
 =?utf-8?B?aS9qYW9jMTBRMVMwZUEwdkowaVJxZXFtaUlyTWNhWWluc2F0YVc0R3BQZDRT?=
 =?utf-8?B?bDhvTXVaUGg2ZVhXYjRabkhzbjRtNHB6Wis1Ukgvd1BzK3ZCeVphL0pjS2t3?=
 =?utf-8?B?QWtlWTRiMndaRTN5dFVnaWgzRzN5WTBpTFVxTmtaV25LSmhXeUEvOVJrSU9t?=
 =?utf-8?B?T2ErWHBBdEVzNTJDYURzMDlQOFI5Z1ZiNW50d1BnZml1Sk5ZRHUyTVdxTE5R?=
 =?utf-8?B?QlM2UHBUTlZoa1hZdURYdDNzc0NIMUJHWlcrSVg4dHpaVFNoSHUvaXNmVkZj?=
 =?utf-8?B?WDg4aHZQWUNGdDhXZTF6UDFVNUVkNXBUbEdxL1hXVG80bHJYM3hHU1d5NG04?=
 =?utf-8?B?QmRXMVk2b3BoN0F2SVVwRml3M0tkQTF1czJFSGxydTF1QUVwRzgreWcwcGo4?=
 =?utf-8?B?OU5pdUlkSG84NnBCUlJkMUJxRE43Y1VySFZjaXltYmpjVThtS0E2VHVoY2NB?=
 =?utf-8?B?cVZLUGN1YktZNDFva0NaejBFajlqTFVGRGpwU005Q001L1hrdi9odzJiZlNP?=
 =?utf-8?B?VTJMVlJHSGdpcmpvNmlOL2JwaW5iL3ZWM3FvSElaNlQ2U3lHWDZ1SkltRGha?=
 =?utf-8?B?ODBBK0YwZzhKQXJubnJmZjNwRnpxQktReUVsNDltdlRLYXBCRGV0UDlyVmlU?=
 =?utf-8?B?SThOTjdxU25lN2k4bWIyRzVtL0hvSk1lVjF1VDZtdWpVMXdLUlIwTUlJNU5v?=
 =?utf-8?B?MytMNG95UDlKRXVablN1YmlQL3RRaFpJL0d1MEdQWHlLKzM1SFQvRjZiclRq?=
 =?utf-8?B?ak9Fb0lTSGh2bVZiWmZiNllLTzcvUWV1S0p3bDRTdWhSanRsUmM3WnlnUEtD?=
 =?utf-8?B?Vi9FNWJnZ0dqeHdHa0t2UjNmaHVsTUV1Z0Y1NXpvaTRMcUpFK1BWZmpxQUpz?=
 =?utf-8?B?emRHdDR4aVpCaEpEaktLbTJJd3BGeUZtMXhEVitPZVhjRmMyY2FwREgyb2c3?=
 =?utf-8?B?aDlWUGRZQ0I1NE5LaGp4WXA5OHN6MEFuM2x5YUJrUmtDZGhKL3NnYkJYQWVQ?=
 =?utf-8?B?WWErQ1NFMzFKcEhjU1FDNmFZeUx6QWNoK2xLSndaUlhHbTViNmM2cmV0a3lH?=
 =?utf-8?B?OWR6Z2Y5eWVOYytMWW9qUjFodW5aaW96bFpGQkdxMGxiNFhyQ1NaSzJXQllq?=
 =?utf-8?B?QnhmeHBwWDltUmxwOXBmMmZ4NUtBUUxDOFZwbkVsZy9HVFpZT2hGa0dxOFR2?=
 =?utf-8?B?Um5SZVRNNExiVTBRN1o3U3ZhS0NIN3lxamNCT2cyOEhhUjkrR1V3TVVXVm1K?=
 =?utf-8?B?eUhrQzVOeXJhdU5Yc3pCVXA5VzZsd2tnT0tCT3RhbjFsL1dYVlp0OXJkd3o0?=
 =?utf-8?B?MkMyUkorUjdyeU02K3gwN1piSlpHcDBRT2l5d0RyYXYzbGRNRzZlN0lVTFNT?=
 =?utf-8?B?T0YvNlExQnR2Q2h5SzFyWGp6SVRLUEFGcHBqZEVGcDN1c2tuRWVQbjZqbWNh?=
 =?utf-8?B?SjlVNmdRd255SmxvMjRJVXNvODU1K2txU1RrTEsxWERJeEFJd3JqNWFRTVVq?=
 =?utf-8?B?eWZ2czJFbGxXWGJKdm5CcFgwTGVGV2lqWkZFcHNRZlNlZkl5elFQSVlzbm9v?=
 =?utf-8?B?WU4yK2VkM0FnQmVtaUxsWm9jWk5zRVpCTFBQRCtkbGFkTmg0dHNtWnN0QUdY?=
 =?utf-8?B?TVpGUG5LMFB3cU1IUVdycXRuMTlYaXpQQXF5RWlpbW1DR3psSElTb2hMYWVX?=
 =?utf-8?B?Tyt5OVpNSDJYeDA2akR6c1NzTzgvL3JMUTBwMmNMT0dPM0tvR0NqZG84ZEgy?=
 =?utf-8?Q?bTYJ1h5XaUuay0UwS1wL7OBzlYjOXF4g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6074.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pKMzVQTmx0ZE5TV3B1WkxZUjh3ZFpOQ0NhODdLMCtNS3lEMWNxcmd6R2Ev?=
 =?utf-8?B?NS9kcGd4UEQ3TzRIeVlEbVhmL1lpa0tuVFVDcXVkTm1EVHo2bU11ZjY0NWlB?=
 =?utf-8?B?SVRVdmpFL0Y3dDRJUFF2ZFlzNnZwdTIzWEJxbUJoaUxKWkVBamp5OFgxdUp3?=
 =?utf-8?B?VWYvb051UzVseGxJSnNSNVp1dDk2d0Y4aER2QlcvbHd4MnJEMVEwWjRNcmJQ?=
 =?utf-8?B?QWl5UDhJNzZiL294RHlGNEx3OUxBanBuNkx6RmYxaGtMR2JGRWxVaERZclRz?=
 =?utf-8?B?N2VsVFpZdDRPa0xyaFdOYUJIN3dvTHNKbFJPUEswZS8vaGM3cUI3ZnQ4S0Rt?=
 =?utf-8?B?cUlZMkJObktBUHFOeDN1c2k2NFBhQzE5RStZZVhyeVlaZTNlOHNwUmZvNDVD?=
 =?utf-8?B?S3dwdC96K0hLVFhxTjk5ZTM5UUcxR24xZy9MeTcybXVMWGlyYVBtSmNtVzJI?=
 =?utf-8?B?a2FXNXlpTklaa2Rkc0VTTk1KTVNoR1NBOC9qSjVSbXhyUXZnb1RMckpnWkNL?=
 =?utf-8?B?UVgwaWw4Y2h1VE1LOW9HdHp5anhJbHZWa2d2ekZrSGtPMXl5VHVlMnZkU0tY?=
 =?utf-8?B?NGw3dnVaZlh1dkNkRzI4S2k5TG5VbSs1bzl2ditKcm80aDdBeTNwSDN0bGtw?=
 =?utf-8?B?ckM3NkVYUkhRbjM3MWRrNGxjWWloclpMR0UwcS9VYmljZVdhSEFpcFErZlRF?=
 =?utf-8?B?UlVlbWVUaFIwa3NlRFhRMHJsREw5SWtuVk0yalNncnBGRUoweUdtamVuMjBW?=
 =?utf-8?B?a1c0d01MNWtHV0dkYkhiaEVsZDNCVmxNSGQ4dElnN2FiRTZsZ0MvcVh0L3pi?=
 =?utf-8?B?ajFKT1FOeHc5Z1E5ZVdvbDQvbGVadzJRdXdjbVJ3WFI0aHpQdFVCcVZlN3gr?=
 =?utf-8?B?L0c3SFJjbit6RndQRjk3OTNIa09URm90bFZqQ0x4Q0RmQWZSZXo2ZDA4Tjhp?=
 =?utf-8?B?UFZPczlsR1UzQ1J2OTlVWGNGNzc5aTN3QnE4bXRBaE1wa3JBQndwZm9pNkFj?=
 =?utf-8?B?SFFtdlgwb01MbVFQQTN0bzdRVCtPL2NwTDFOTTQ0OXBRcmNQeEZZSDJJNWIz?=
 =?utf-8?B?ZDZIOVJ4anh4N1pqakRTV3dYYXZ6S00ybjFYYVVhMHN5aXF3QkZXRTNJQnVV?=
 =?utf-8?B?dDVabGtQaW11YVVITWQrd3VYUGpTL09CaGE5c0hhNy9CVS9jN0VMVTNDNUhz?=
 =?utf-8?B?UTQ2Mmdxc3hSa2tQQzk1UWhqNkxFZU5naFhVWG1LS0xNYnZ4Qk5uRVloK0t6?=
 =?utf-8?B?a0JHNStkcEVWWC9hZDdiNHVFeUJrMlRzVVdHYW8wREdSVlI0eXQreUJhQUR5?=
 =?utf-8?B?MFZHKzhwTlI2OHJZamtJMlBrNUZmWUovczVNSzdaa0laZG9SbS8xT21GUFVR?=
 =?utf-8?B?M1l3WFNrRkZhR3hJRXZKNkM1eHVNZ3N3b3BRUlJ2bEhteDhwSEllWDFBV0hM?=
 =?utf-8?B?Z25oWnEzNGhtdC9LK2tuZ2grSzQ3cEoyaURDd0J1S2x0M0VFNkVmWlgwRjF1?=
 =?utf-8?B?bWtiN1pWWEMxaEcwMEhJMWNKN2RoZ0JkRW5lcWRQcnJzVVBHOGtQWXUyQ05Z?=
 =?utf-8?B?Snoya210bFpIZjFScXVqZzg4MnZjanYxMkdMUm12TEpUbHEzbExkVFh1VTZ2?=
 =?utf-8?B?cDFaUG43RWxqRU50Y2VZMG5ZbVZoWWpKbXFNRXBaNUpycGJ3L3lkbFNYMXNq?=
 =?utf-8?B?ZXJuaiszRWVkSFZaRXI0MDZ1aFl2NHJWL2JzY2NnTEd1bjN6MTUwWWlQQ2xa?=
 =?utf-8?B?a1FWbXJ3b1YxYXFCZEtGalpubG5EUTIxbml0K3lwTGhuVVdsMHQzT3RwREV0?=
 =?utf-8?B?MFkrbHYyMVFzYlJZbTh4TSttTlJGZVZwTko3LzFydm40d3NBUGRhcGF2NnJJ?=
 =?utf-8?B?ZzNkR1RxZ1BTSTd0SVhHV0R1NkxSeTZSMk54V3JNWjRKd0NxbGZ3ZEFJaDZT?=
 =?utf-8?B?RTJEaXNTZU8zWmZXNGxiSE42UWFnTTNPNFVoNEZ3Q0JTT0pLRVFqZm5lZ2Qr?=
 =?utf-8?B?N3RUakh2UWNnNjBHOEZGMkpwWFhjSTBUclFhRVVJTktOQVNBK1VJQXdOTjk3?=
 =?utf-8?B?ZTJMQTNWQ3lmd0kvM3NaQlpkZDQrUGl2V2NnZllpSGl5YWNqMkxCU2ZnTWl0?=
 =?utf-8?B?NmRtSVVvTG91Yll2SVJuN1k0dTdiajJoRGp0VWwzK1BhUzRlWFJ4RHV2TDhO?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b84d2720-7aea-4a10-eaf4-08de00dbf86e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 11:16:30.0150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rX97SJzB1/pcO+wCL0Xo6f+094rLItpFE0lXqSahoTFYea3RgQXiz6ZqdBQjB5QvV3ydDh02PHiZWTkD0Z/YeLyK45v0p3xwf/4laVyAvc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8539
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

--------------OaCr1NgjMOX8IzeYn3Iqv05F
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 30-09-2025 23:57, Shetty, Praveen wrote:
> From: Praveen Shetty<praveen.shetty@intel.com>
>
> A "configuration queue" is a software term to denote
> a hardware mailbox queue dedicated to FXP (Flexible packet processor)
> programming.While the hardware does not have a construct of a
> "configuration queue", software does to state clearly
> the distinction between a queue software dedicates to
> regular mailbox processing (e.g. CPChnl or Virtchnl)
> and a queue software dedicates for programming the FXP
> Pipeline.From the hardware’s viewpoint, both mailbox and
> configuration queues are treated as "control" queues,
> with the main distinction being the "opcode" in their
> descriptors.This patch will requests queues from the
> firmware using an add_queue Virtchnl message and sets
> them up as config queues.The vCPF driver then uses these
> config queues to program the FXP pipeline via rte_flow.
>
> Signed-off-by: Praveen Shetty<praveen.shetty@intel.com>
> Tested-by: Dhananjay Shukla<dhananjay.shukla@intel.com>
> Tested-by: Atul Patel<atul.patel@intel.com>

Acked-by: Aman Singh<aman.deep.singh@intel.com>

<snip>

--------------OaCr1NgjMOX8IzeYn3Iqv05F
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30-09-2025 23:57, Shetty, Praveen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250930182718.2997819-4-praveen.shetty@intel.com">
      <pre wrap="" class="moz-quote-pre">From: Praveen Shetty <a class="moz-txt-link-rfc2396E" href="mailto:praveen.shetty@intel.com">&lt;praveen.shetty@intel.com&gt;</a>

A &quot;configuration queue&quot; is a software term to denote
a hardware mailbox queue dedicated to FXP (Flexible packet processor)
programming.While the hardware does not have a construct of a
&quot;configuration queue&quot;, software does to state clearly
the distinction between a queue software dedicates to
regular mailbox processing (e.g. CPChnl or Virtchnl)
and a queue software dedicates for programming the FXP
Pipeline.From the hardware’s viewpoint, both mailbox and
configuration queues are treated as &quot;control&quot; queues,
with the main distinction being the &quot;opcode&quot; in their
descriptors.This patch will requests queues from the
firmware using an add_queue Virtchnl message and sets
them up as config queues.The vCPF driver then uses these
config queues to program the FXP pipeline via rte_flow.

Signed-off-by: Praveen Shetty <a class="moz-txt-link-rfc2396E" href="mailto:praveen.shetty@intel.com">&lt;praveen.shetty@intel.com&gt;</a>
Tested-by: Dhananjay Shukla <a class="moz-txt-link-rfc2396E" href="mailto:dhananjay.shukla@intel.com">&lt;dhananjay.shukla@intel.com&gt;</a>
Tested-by: Atul Patel  <a class="moz-txt-link-rfc2396E" href="mailto:atul.patel@intel.com">&lt;atul.patel@intel.com&gt;</a></pre>
    </blockquote>
    <br>
    <pre>Acked-by: Aman Singh <a class="moz-txt-link-rfc2396E" href="mailto:aman.deep.singh@intel.com">&lt;aman.deep.singh@intel.com&gt;</a>

&lt;snip&gt;</pre>
  </body>
</html>

--------------OaCr1NgjMOX8IzeYn3Iqv05F--
