Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE8C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 10:31:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 378B7402E7;
	Thu,  8 May 2025 12:31:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 62BF04026B
 for <dev@dpdk.org>; Thu,  8 May 2025 12:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746700289; x=1778236289;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OzUDm+S+gQLlmeEMnmBlVYveB6LAopUA6vWEAuWAbCk=;
 b=eqJW0Lw3RuHV1PVS8Usqi8u/sXm+cPHKpmUpzOMGWBhPldHFf3XQ1DXn
 PNCeN+H3lmxQSXp9Snbzhisv4gXAzpN4ZFii9HCVnv8wMHIzjAZa3s8R9
 xz0dYU6ZvzZtY4LTAytPpEpuEPaOWPWbMKyiYC2zw22FbVK8pcD/k+Km8
 2ou6nwLJKjv2I+GRIeUSYfj8vVOSdhy8wQUsq/X41tls84tZpVj/W+ZyL
 xDWto9ZaN0ezTvKa1/av7krjUbhwv6FtXubXJY1cGGjNGqHV36YRv7rxN
 dMxB42xK9bJ9CUyoQZK8SFvXx+v6RxyoHgbxwFtwsFWuIoEUpW2EAN3Vj g==;
X-CSE-ConnectionGUID: u08N1iKqQL20jk1cv9quFg==
X-CSE-MsgGUID: V3WpZWDHRvu18JWeDvjpOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59825458"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="59825458"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 03:31:28 -0700
X-CSE-ConnectionGUID: NmEtraAMRBWUr2PW4CXq5Q==
X-CSE-MsgGUID: lJGrhwW1QJupNp56AxU9PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="140293959"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 03:31:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 03:31:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 03:31:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 03:31:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whtQzolRl/hOk5h7KTEawki8mzYbMfipYe8JCpnF5zBbzZbOaCF7yUuLv7wOULRFi+GNgKHnQQA6vxs+QBlkKDWUksQOc9CH4+4gcSb833yTJfoUicTcRWpTpvzo7GnTowVPdH7WblNt4zbpBDkVemgGELotnu7MGnvo2Rgbuloa50uu7+kKQ7eQJGksZNjhBz023i3cwl4QiO5L9K17FDmfAJOag9FhjcL2R1sBxAbZcgU1aP+f4SrahdX/Oa/8XeCV6os7/yC7xmSWKs9MKC0i2wj6+CoYTfSAl/QsOjGo76W0H8T4MuDtCyWMXoAhDVwscRolWiob7tfDZiRJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1phcsOs9J5r6vSCdMxQkvvhUXJWiO4renhnbCmFIYOc=;
 b=kys3xE7UQSsCGurNsckXM8uZ3yUo2CC07HbLHzEY8LSPTe69z9iI532n7d0XY829z5fsn8RIcumqLlgCBT9tnPlrofKBG9cu4KxUQF43JWPu3s3Mi4kLZOQGek66Vn2StfHB++5fxqiQ0ikY2J3iqOVst5T5uRdWFV2X0SslkUaT9XcCk+g4KIcLjK0UhdvPBN/+wr4ZMnmkjTgZE7OSJ1OwjIMYdcndMVRFb4VVO/1jJnYmPPChVzDscgllTG6p0LsPh3iQyHqhmCLVVN545YWSfERC8S7cFy1ZLc+MUxxEd6bpmVmFl9Am1a2998V0vlqPm7eM/rcmJGnt23QpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 10:31:23 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 10:31:23 +0000
Message-ID: <f69e08a1-2252-4d5e-bf1f-70b58754eb03@intel.com>
Date: Thu, 8 May 2025 12:31:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] eal/freebsd: Do not use prev_ms_idx for hole detection
To: Jake Freeland <jfree@FreeBSD.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250506175010.1141585-1-jfree@FreeBSD.org>
 <20250506175010.1141585-2-jfree@FreeBSD.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250506175010.1141585-2-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::32) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: f5db4a34-fa37-44d4-b405-08dd8e1b7aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTdwZUU4N1VvY3VKKzA4ZWJ3UDFuZm1walBqNEZnbzlTZ3BORngzNXhXY29i?=
 =?utf-8?B?SE5QSEE0eG5UbzIvZU1vSVdJdllJN21zM3E1UFhoZEVacWx0dGZzclBwa0dK?=
 =?utf-8?B?eGNuS2wvWGx4UVNLcWdmeDdHQVNNbmtORGtWV254RGxNU0IyNG02T0pnMklS?=
 =?utf-8?B?dHk1c0xYVncvZ3BXUGJSS0k5WmhUK2ZJWlp5WUQ4cVd1L0ZrQzdDc2c3R1NH?=
 =?utf-8?B?MmYzRlBNMGNQN3d5djcvZEZkMzQwN3Q0ODVlVGdOc3J1VlFSZS9lVWxEZTJn?=
 =?utf-8?B?d1hPZExDZXE0ZzRMVWdURjVBZWtEUDJlcWk4RTJYZTQ2VFM0MlBXdWc5RU96?=
 =?utf-8?B?NWVpenVqWHU3RFMxeERpaUtrQk1kRncyTU1Dc1BDU1dOZjVBZGprdythbXZO?=
 =?utf-8?B?SisyYzg3YW5sallHcVhuU01UVE9QRm1vWXpXZmN2bnU2alkzeGJiYUN3YzRr?=
 =?utf-8?B?RWgxRjY3NGJYa1dqb0FKTENORDloQjJBNVB2aUN0clN0eW5tL0dpVHRDYjJ4?=
 =?utf-8?B?VGlqM1hPQk9TODF3WTVhN29DNHR4V280dFlCbHVYKzdsRnVIWkNuOE96K0pK?=
 =?utf-8?B?eXI1N0o0b3FDSmFTSkkvQmlzMlhaeVBoWmhiQW5lTDJiVVpnbFNOdFJ6eUVG?=
 =?utf-8?B?dkJNQ1F1U0RFMUVTNm9iZlpzRklTdGpaZUswT3k1cE1ZQlpQTzZ5aTBnM2VB?=
 =?utf-8?B?bkxNeEc5dHV6RmdBWWN3NzdnRXR1UWJDNE5ydnZhaTh0QndsSUVHZDdzUGto?=
 =?utf-8?B?Y3QxdmZ4NmxadXh6TWxDZ01iRy8wYWRONHNOcjdGcFZyRVhweW01Mi9nQWtT?=
 =?utf-8?B?ZExyYXJHL0xxbTNSY2NJYitxWUovRTduV0tPZXdwU1FJTW1SZDNsdGNTQXlL?=
 =?utf-8?B?V2ZPanFtWG5BNjNqYlJKSnl5SXEvRWQ2amFvMkc1aEhMcGlUeUxFTlNONUl0?=
 =?utf-8?B?TE5ocllYOXM5RTNXM1l5SGQxZkF1NnArTUJxQkNhTElOcTZMQk5kODFMYi9K?=
 =?utf-8?B?R2RnVTR4bWFweVB1RVF2NFJham9sZHBGUkV4K1MyYk0zd1VOc1R4YWY0RG9s?=
 =?utf-8?B?S1hlVDRneFpoOHY1YnMzNTR2TUQxeHhnaUFNK3BmSWdNc3hIKzJYcVdUMjVt?=
 =?utf-8?B?S0NTQW1SOStCMEFKZXk5L1IyYjdjeTRqdU5aaGhaWHJrY3lQOCtIQTNkOVR3?=
 =?utf-8?B?TFIrdTVIK0dsdU5JalZzRkF5T09TT2Z5UndFM1kzd29sRzZyN080OU54KzJ6?=
 =?utf-8?B?dEE1ampLMlMyekZ1eitHM2pDbU9ma0xDbGZiRDE1TzNBWWxDdThWdkNFRTZ6?=
 =?utf-8?B?YXlXNnp4S2l1K3hGdW5nd21CakV4M0k1RXB1SW5zQVc0eXBESEpvNExlMTQ4?=
 =?utf-8?B?QmdZQmpGb2xERFRSYk9ib1U2c3prY3RFcG9tck04Y2JWbXFOV0x5dEhZVFli?=
 =?utf-8?B?SnExTjBSUW5lTS9RQSt5eHBobnlaNmNXc2xmT3hPQ2lNVTdpZTNjNW5VdEVz?=
 =?utf-8?B?d3pVNmlnVHNJSlBvbWhNSWlpSnh0K2wyQzZ6WXdBTUdEMVpGMlEvdHl0eXhU?=
 =?utf-8?B?eUtORWhIYUx2eTdEbmk0emM5UFNnVWRRSjMvZGVKc3pWTzBrazQ0VnRlaWEy?=
 =?utf-8?B?VVpOOUE4Y3NCZjVyZUJ6dXF6ZmtxUGRxUDg5elBtM3AxV2dkVmFUVUNjOC85?=
 =?utf-8?B?WWswZmU3TFZoeWZ6MnVTNWYwOHIrSlFpTjVLaUgvOVdOTnRlUjlpVTBkU3Jv?=
 =?utf-8?B?aXZOdmUyeEVTbHlLTkhJR3UyNUtCOUVlRERCZ2tkUzk2TmYzMTdMaW1iOVBw?=
 =?utf-8?B?SzVVTTVXYzh0QWJOOGhkK1A2N1dkVW1OdmZ2TDJ4Um9TamxaREtzTWpETFJq?=
 =?utf-8?B?eEJOTEdaZ0hpbDQwNk1XaG5kWndpdXV0a2RRSy8reXpETURhbHdJNzRYQU05?=
 =?utf-8?Q?0IPjKqDq+1k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N292TjAzRjNUQmViYjViblpIMlJEL2lXd1AzYlFqa0ZpSmxRMTNNNzVyK2sv?=
 =?utf-8?B?WTBYbzRzdGVwYm11S0JSQm5jYWVQUHdXWUN1QlVtMU5rT2xLeHFNdDgrMFlW?=
 =?utf-8?B?clhQRG1CMjczaDZ1MUt5dnRRajFjVnhTa2NxRFFFTm9jSWQ5OVVBU3NUaTll?=
 =?utf-8?B?cmRqY1hJN0EwQXhVQ2xxWlQvblh1Y1lZWENpQjhkTFFVOU50UTZUNStvdjVo?=
 =?utf-8?B?MEowUU1jU3NXOW5rTzJEZnFTMDNIbzlDYVFSeEE0M0VCVFNWMkczenVRRTlZ?=
 =?utf-8?B?ZmlvTG9jU1ZRbG4yc0REUkZCTk83d1FSTzJ3NExsWEJXcEZ5RmcxUEdETG5E?=
 =?utf-8?B?Q0g4S1JvVUtTSEFqbG5xWW5ScVBySHBrRTl5VjlTWVY4RnlDck5QNVk0blBh?=
 =?utf-8?B?N0RNdGN3RjIrVWlGUHZaYVpjejBnNmhLNzdhVERMcWhJZDgzWWFKQmdkUGRW?=
 =?utf-8?B?OHMrQ2hGdHZtU1A3ZktBa0pLSG1abXpjTCtvbzBJdTlBTCsrQSthTk5yUVp0?=
 =?utf-8?B?QWJneWd5VlpSTG9BT3djUElJVjJkdHc2dk5LV3NLMFRIeUlDWHNNMVJmUHBi?=
 =?utf-8?B?bFd5eGw5ejhscU5kdmExMTNZVDl2MFdyOGl2aW1uQW5PeDNwdUNzMlpTYzNY?=
 =?utf-8?B?TzF1OEhxR1gyV2syK1pUeW1uZEY3eUttTWlGUG1vUFI2NjI0anZFb1FiMEFG?=
 =?utf-8?B?Z050eWZPRnNEK0VPN0F4RHowOUNPZnplR1VLMUpwYklZaU56RUZ2Y21mQUFh?=
 =?utf-8?B?eitLWDhNaUVXSzR6bWhzejZNN09oNUtJODd6Z291V3FjdDRBRlJRSllJTjE3?=
 =?utf-8?B?dzVObWl1Um9CVS9GRWNNZ3R3eFlKYnNqQWppeTJPTzZzdDdtSkI4VHMrM1R5?=
 =?utf-8?B?OEo0cVlCNkdvMzQxemlPQTNORHhuUkZ3NjdvTzJ1YjV6ZTZTY0JXSjhQTEov?=
 =?utf-8?B?OHpkMWQ1Vkt3clVHaXVva21hQ1BUSnZYWDB2dkVmcnVKZ2l1aXF6S2RCc3dy?=
 =?utf-8?B?TVd6Wm5jYmFNRDVvYm9XN016ZXhFb1BWRDN2a2N1QjlMTFhXWWdRZXlRQ1lP?=
 =?utf-8?B?TDcrN0wxcEZPcHp5L2hncDREd3E4MEkyVDJlc3BUTXJMdWQ3d2ZIZ1JOUjdT?=
 =?utf-8?B?eDM3ZEV6VHZ0emU2Vkp3VHoyRldLS0Vrd0ZoVDQ1KzVtRC9KQjZDMzNyNXR3?=
 =?utf-8?B?cTBFK2loU20yS09mRUhKemMyN3ZXaDlENXVha2pxQzZ4V1BiN1ZrUFlUKzFV?=
 =?utf-8?B?WVVwUitTVWd0by9qNmVaTkdnMEFyV3c1cW5iTE5qVElqM041QkovY0lGOHFv?=
 =?utf-8?B?ZG43S0FYZWJwZ01VblNHSlhFRlFPYVhYOEp6N2VidTVrMFRWdENxa2xJWW1n?=
 =?utf-8?B?ZkNacWZaNG9CYktqb2xrbzFxckhVUThEYVBES2RoeTZLRGFPSTlFanFycVhh?=
 =?utf-8?B?eURNWUxpVzNoOEF2cVUybWNpeDI1ZTRicDFRZzEyYXpvNHVPVGhIWmJ0ci9w?=
 =?utf-8?B?dW9Cem5rc21VOTZJc0dWc2poNzgvZGVHbFJ2N004Q1RlRFdCNHNNYnp2V0Rr?=
 =?utf-8?B?RVJUUHMwQ1hlUmVaN25QOXNRSTdGc0NzOWgyMTN1LzVHSDg1UEFhb2F1S0Jv?=
 =?utf-8?B?Q1Jqd00vZTZFcHg3OXczeHRyY05zUUhiOFNxeTdCT0Z4VHQwUjg1bHpwd2Fk?=
 =?utf-8?B?T1NWVmJ2dnQ5TzlqVnB2enVKdGNjMTdVNkE1WlNtTEZHOENjLysyeCtLTXJj?=
 =?utf-8?B?d0M5ZkF1L3NYdjRzbTFxNG9GVWx4UEg1NTdzUHRqZC8rQ1ZTa3ptVE1zV0Z6?=
 =?utf-8?B?TGVoS3lYY3dKOW5NZU5FTDhOZFNhTCtuZHg3ZFhzL1FIOHlRdmh4K05VQVpj?=
 =?utf-8?B?SnQ5N1VUK3I5ZTFsMGx6RGYzUzhqMHdrY0NoemhmeE8zY2dCL0hKU2VaVitI?=
 =?utf-8?B?QWxyTWVDcXkrZDVRZFNUS1dtTVBGTG1iZjQ4SG42OWYrYVJJRjNWVEZWRjFJ?=
 =?utf-8?B?MkRWM2hFbGRLN1BaNlhiazlEY0pnL2JzRE13MFNZdENUd3FCU2hicEYxZzBD?=
 =?utf-8?B?REFHcmZ2bVRRZ0R6KzhjLzR1UnFXTWNLM1hxeXZ1Nm9CSDFhNy9jbGN5QUNQ?=
 =?utf-8?B?TlppV2lIWGRaWVlqKzFhRkJzMFU0akVNNm1XcWFOTVpyS0ZDcnBSSFYrWlR6?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5db4a34-fa37-44d4-b405-08dd8e1b7aa4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:31:23.1040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfG0gK9EvNIOoefBsfG9elqJAGNgxfO40L/hLwl/73yEdJsYJXKurksIz6xrVK6B/xGJOLbKGHDU1ZPL6XMSU+9RFElOeL3w1kHRLUB0ZN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
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

On 5/6/2025 7:50 PM, Jake Freeland wrote:
> Use rte_fbarray_is_used() to check if the previous fbarray entry is
> already empty.
> 
> Using prev_ms_idx to do this is flawed in cases where we loop through
> multiple memseg lists. Each memseg list has its own count and length,
> so using a prev_ms_idx from one memseg list to check for used entries
> in another non-empty memseg list can lead to incorrect hole placement.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
