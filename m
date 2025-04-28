Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DBCC369D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08D23402A9;
	Mon, 28 Apr 2025 17:08:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B5FCC4021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 17:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745852938; x=1777388938;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+TC3t8T0eCahzQIuWt+HguKeMoVOcutsg4lMKXU1LUw=;
 b=afiXNBQTRf1kcmk3BCssNqzD+Eu8lcQ8ieqRHKDPjedGkkKnLKe/0e6M
 rKRjFtblan1q6xbcvvuXeACZHmRkegeleucJImZ93Gm2+RHqwZcvDRMF4
 MGLeQKmt/lGqg41mvENa4aiRiKCN8TChUNKKhu4/Z8RgmfuUOaxQPoh8T
 ESxyVH9ZauGMFaQZnRsPXxUEbKwxYy5v0dOQG7wvKr9wY5QxBI54ycaFp
 QAEYIs2UFop5BEOIOs6GqfUmbJ96N8lOvMXBRseh38anrA63mzdTdRLga
 AY3otS3/6Eswya8yFpHdNbTu0cJn7ckDN3+Nb5R5D2fStpY1yxEAz/nD6 A==;
X-CSE-ConnectionGUID: KnSdwEpfTEuXr60GCTsH8w==
X-CSE-MsgGUID: R1/oi6hGQmytNJxh3mEQPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="51257406"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="51257406"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:08:57 -0700
X-CSE-ConnectionGUID: 0T3WP3ZkRtiWBVWG2ichcw==
X-CSE-MsgGUID: 0XzK6efjTPGN5WYLN6zIUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="164627110"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:08:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 08:08:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 08:08:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 08:08:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjDGhsFh5NXWZqYdqQeDApTHaeNsVst8kSfAvXjVaT7JwxL4Ldtu3WzYYbM7mgZ3i8qw2aNTj2Oz+f5wMjhBFstYiKPHbj6XYyOSBT61INplqJIMUTVfCN2QMYL7y03piV/hOnj2/LKJxPviWxs7uTITJTXouLMtCRqqtOsxbln9PO37Z6UOkqREecUmoAi3n9o7pBqImiFyg757oLdt5W5efTGKBruaGJ5O3xq+lJSJi9lDEprqSFAIvsci9oNR+Yf22LKiSNKeydPqSOLSHhfrMMWAE4kZI7YmL9YZaBOpUwfpnPxwgMC/kscAg6K6DH3RkqG1jvguMXdQWz6fOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7snn2YB/8aNJf2umpOM2LxJdFaoAMTP24rXQpJ/KP9Q=;
 b=ULkzKuboCHqFSd1HRDnHARW8K7CMIsrwcMaxGnLlwhYdN1RU7nmPFqqcqdzs4td5z/ZPBbJpV89QNNipTFjC/XMpoTpBCac9W7QgYH+80rHIsuO6TVOYcsFj3UXTotLULM/WP/3PPaiNJnWc9qRzpfMuMGjg1QkbrtBrzXSwec06nWcxUWE9HgWYUH7N4ZJdOdORt7xp8EHTiG7LLhzXfkuLdB368RGTg4+987dpYMynYoFCQ8R/xpVIsesZ+XfgYB+Cy6rONktAM8Z7dGkgoIZfDEVN/r8RR1lu/rGmL7hf9FwILaUsJWNomIe8gk87i1ovUB3iH4CNMhHUXBWqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8830.namprd11.prod.outlook.com (2603:10b6:208:599::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Mon, 28 Apr
 2025 15:07:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:07:50 +0000
Date: Mon, 28 Apr 2025 16:07:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: David Marchand <david.marchand@redhat.com>, Praveen Shetty
 <praveen.shetty@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v1] net/idpf: avoid truncation of constant value
Message-ID: <aA-ZwTjYej5okjp3@bricha3-mobl1.ger.corp.intel.com>
References: <20250409125440.7103-1-praveen.shetty@intel.com>
 <Z_aDznlc6Cd7nti4@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wMtW5y+-k=jCUg5RFizbbn1SLbRj8nNicVqrQQK6g_=g@mail.gmail.com>
 <20250411135155.GA16808@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411135155.GA16808@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DU7P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c943e2-b6e6-4d25-bfa4-08dd86667148
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmEzNktXaC9sNW5QYjh4U01oc2YrNC9KZzI4Qm1iTHdrK2lta1VrQjVOd3dl?=
 =?utf-8?B?UzVLd0Nsc3BoaUVIeU9YU0lZMWZOZWo3NTFuTDc5SmE4dnpWb2VVQm5RVjdN?=
 =?utf-8?B?M21EUFo3OVNxYnFFVEtibkhOQStqQ281L1QwOGZlRUtDRk8zOGoySE5xWmlB?=
 =?utf-8?B?M1laeVBqWGlOb2dJZSttcEJQTnhhM05NVEhzYU4rb3hMMEZJSU0vNTUrZ2Zx?=
 =?utf-8?B?VzZNN093T3MxUHRDYlJsZHFFWm8xQnd5OWgrMUxJankyckZBb2hlTEpaVFFH?=
 =?utf-8?B?QnBUQmowWm9nV0pUdDl0b1NWVERzUHRrK0pUbFhZL1dvOFZXYWo0aWl2NnJo?=
 =?utf-8?B?SnlaT0xNWndqSkdGTDRyYzBWVWZJQ0ErMk9FUStmMmVmSUJoTnlWWTZGWDBC?=
 =?utf-8?B?NXdiREo4eFBDblRKc1dXTnFkSTJpS2IySHRrZys1YkROVVRMUDFqc2doZVhh?=
 =?utf-8?B?MUorQmVrVi91Q1FpRnZSUzJtNERHRzBrSkx3djBJSGxSZFVRaW5naVVLTldH?=
 =?utf-8?B?VEJsNXVxREQxbGZhSXlsaC9hRm4vZTZmVjdoNENIOVJDbzJxSW9VbFJVcExy?=
 =?utf-8?B?bmxXc2owbEliWTc2NXZ5aThrb1BmNzhtcGh6MnRrVGNzbno1SG9WRkhkMEds?=
 =?utf-8?B?N2R0NXJVcTl0MjBvclVBSHh2RkFrdlBuSUVyYU1xYi9vc2hyS0hPMVlIR0Rt?=
 =?utf-8?B?QmxlOFhNb1BWQW5vMUZCZUJWMzhrYStyYkpkdjdxcEJIeWF1ZndsRTNwUFYw?=
 =?utf-8?B?QVlVS3BKb1N6U3RKVUpXeEN6aVlzbTd4ckRoVG1YMGQ2M1RwM05xclhDaFEz?=
 =?utf-8?B?YU5UeDRJUTNpK3dFdjBDeDBtYTA2Sm9BaW0rUEN3T29KT0pQU0FKN3ROMkxM?=
 =?utf-8?B?dld5c2c2cnNSMUtzV1V2bnQxNXNDMUxQSk9XbFZiUE00eHI1Z0hYWFd0ZFRV?=
 =?utf-8?B?Skp1QUsweWNrN2FOa1dUR2hwcnBsVFNmR3JoaWJzV2ROUXFBT0FVaHB0YXVT?=
 =?utf-8?B?bE9OQVo1Mk1LVEZrdm50b1ljMGFhcmlJNmtwSFZHYk1URUlhZjhpOHcvS2hk?=
 =?utf-8?B?VENkOWpNemx3Q1NpbCtBLzlOVTJEWW1XOWFDSkcwYnVIY2Z2VjlFc3VpMnhI?=
 =?utf-8?B?MG1rOTE4cDM1aVNuL0J0NGhyU2RMR1ZmNW9mbGVYZW9mM3k0djVMZ2svVEJx?=
 =?utf-8?B?bzF4YitZZ0dzdEJPYitqUkZablRpOGY1S3JaRjN6Zjl2cGdhYXp5aDd4aWdP?=
 =?utf-8?B?S2t3b3d0U3VlNEV2NmlzakZvVFI0UW5rT09KNHhxcXJTekJxRGZUcGNwb2ls?=
 =?utf-8?B?T05NN2ZhcHgwcHlOZVZsUEtKRlZUSXBUQTJxVlFqSExtL3UxL2NaaWFtK1NQ?=
 =?utf-8?B?eHZ1c1JkVUZJek5PRGJvYmdqaVo0Nk1PYmVNTnBjblNOQzJtdlcyVnlHUXUw?=
 =?utf-8?B?UCt2eTJOczNWeGs1Y1hXTmpoTTN3UG9xdFRTTlVzLy9LeHpJVk9tV1htNmRC?=
 =?utf-8?B?ZkMra21wY0Y5Mk81NmJPN2lEZ0lKU1JVclZUcVpVdis2dTF1bFNmTGQyTTkz?=
 =?utf-8?B?TTJzUWxNWFpqMnlSNHJmUHNSZUl6NS94L2cyR3VqMUNnd1NVVWppYkFmQkZZ?=
 =?utf-8?B?cjhjSllJRUJWaWdZc0tYZW9scXROb1g5aklTVGxkRnhjV2V4SFc4S0dYNnRx?=
 =?utf-8?B?OFcvYmRiWVlZdkxUT1VsUS8vdkQrLzJwQm11M254dmxPUlV1VWNNZ215bCtv?=
 =?utf-8?B?ZW1uWjI1YmNaM3ZWbHBCRzdIbDdZZmcxU0lmbnhuN1hQeGIxYUp2VXlmOTU5?=
 =?utf-8?B?VjFkWmZOY05TaHVNYUxTTmZEV3g4L1VhSUV2WGcyTFpvOEtPNlZjZmN6MnlV?=
 =?utf-8?B?dHdWWWQ3MU40U3g4ZU5sbFpCQnIySjhsNnhSUmFNL2VqZWNaTEZRWFBjR3BS?=
 =?utf-8?Q?KIa52Fpqdfs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRzd0lLbmt0RStXV2R0MGlZUGFQUFVienF5MzJ0ZVZBTVdoTXAyQTFpZFN1?=
 =?utf-8?B?TjV0ZzllN1NsSDJxS0RUMXRiN3B4enpiSlprMXd5WTE4TVEvcWx1SmFwTkcr?=
 =?utf-8?B?QjZpcENmUzBvcW1xVkN0dFZTZ3hodVRmQlNVUXIrT0dMSXBpdlQwOW4xUFo3?=
 =?utf-8?B?Z2R2clJJaTdhWE9sUkxPdTRPWmRyd1lLc3c1RDNudzd4TUFNVU5uSGdlYnhn?=
 =?utf-8?B?a3c5ak5CalQ5dHp1U1Z5UTdOcm1YTGlrYzVZYkIzeWlYSlFBKzkzY0FhYmNB?=
 =?utf-8?B?TUx4b0dtdHp3TGY1dGR5b3JKTUlGL2xyZDhxL1I1aXpxMTdZd3puODNlT1Bi?=
 =?utf-8?B?TkpOdFpVT2xNZkV1aWlDOHhrRVNVOXJWY1Y3RkgvSjBoQWpaaHVQU3pzT0Iz?=
 =?utf-8?B?MG1pc1Z1eWZHckNHbXZEbHVRekFsRytEdXA1Z1pVNlNyV09aMHMrN1EzMDkx?=
 =?utf-8?B?R3hJMS9jVlVwS1R6WjFWTE05TnhnVDQwTnFZMkM1S1NFSEhZV1VJbWJLUGNs?=
 =?utf-8?B?MVAzZWtpMEdHb1JRMVJpbVhTZHBkL2E3T0ppZlJBM3RLS2VFZVlUVlpsK0Vx?=
 =?utf-8?B?TzhEc3paQXJ0RDdJVjlYSjQ3aTVzVkdsVlpjQ2FWT0lIM2wzZlMzbmhoK1Iy?=
 =?utf-8?B?YklBRkQ0MHAwYmxLYkl2Q1JnVHBKSlZzdmVGOVhBWnhScUJSMTFFVU9kcU5k?=
 =?utf-8?B?WTdUQU9lbm13WkRxWG53NVhZWE5nekIxMkgwaEdYTHVxSG9iN3VvNzVIb2VS?=
 =?utf-8?B?OFFVY3BoR2ZnRmhOZi9Gb1EvSjlYc2FNOFd6Z2ZoRS9tcHp6ZmwyL1o0UGtI?=
 =?utf-8?B?bXZFYWZtU3hnTjRkcjhiWGc1Ym5HSmpLL0crTDR0SGR2OVl5bU9KQnNIUm9u?=
 =?utf-8?B?TW0zTFJaMWRJUXFkc0VrazRvSWxvK2lHMU5QRmkxQnJHcitoRE5YN3BRWTFr?=
 =?utf-8?B?YnU0c2VHWExIb1lidXZqdWVvUEQxc2FJYUNHWEU5U0YzWWVZSDFPZEh3b1BD?=
 =?utf-8?B?ZzNxU09TUzRzMURTQXVYY0VRczJ0YlM3ZU1JYjg0MEZJM1FVSlkvTDJLZTBR?=
 =?utf-8?B?UjBCYU0xNnBMZ2tyOG03TVM4MDJCK29ieUdXYm9DYjg4ZUV3NDBoK0NVSnJL?=
 =?utf-8?B?VTM2K0hiRVF4a2xUZTFnTW5SUk5jOCtoSnZINkM5MzFKSkhHc3pub2hiQkJi?=
 =?utf-8?B?YnlMV0JBL0lwRzgrVTNXa0wyWlRSVmIzNDJ4cDhwNUJsZ1U5ZjNwTWp5aG43?=
 =?utf-8?B?bTV0ZXFUYUl6K0tiQmR6dHpNVmVZRmJHclFFNFhBcFhwb2NEclBHdW9YRTd5?=
 =?utf-8?B?OWpwckNUbVcyQU80clNCSTlDV2RCdllveEhWa09zajQyNTI4ZnI5anhPUmxI?=
 =?utf-8?B?SEYweUgwL1BvSGhPL1pvQ254N0dCYjBQNUtvK0xWaXBBTWJaZ3hNN1Jjd0J5?=
 =?utf-8?B?Z3pCKzlRSTlNTmppTlFRTW9Ta0VYV2o2THdpSTRUQllGUWdHdUYxSlNRS1R1?=
 =?utf-8?B?QkJHVnpVc1cwYW9vbHpTam1yZWcrN0d5NVY1M1pNajg2bzlRaXpKUTd4M1Ar?=
 =?utf-8?B?ZHZWTkJvVU5jT1hxOU45M0RRblp0V1M3V29PWHN0VVhDZnFNQjUzZHdUODBT?=
 =?utf-8?B?Nmh0NHlWaEd4K0JsWmp5bldpbytSd2didUR4TTBtRTJpSWVmZHgrRXRCc1lH?=
 =?utf-8?B?Zjh1RHlCZkdackNoK2pTUkJ3UU1YODV6VUJHdzVBQVhnMGU3bEo2K25XU1NJ?=
 =?utf-8?B?VjVsTjdvZXZ5eHNSazQ2ODI5N0RPMDM1MEQwRlBsclVod0JXV3lPTmZrQmRU?=
 =?utf-8?B?UUZEN3NpNDh5SFF3R0dKM0pBTml6N0xNY0NWSzQ4VDZ1NHhuQ00rU0xaTzF3?=
 =?utf-8?B?MGFjcE82aTJnb3pPWlIrb3NWS0JHQjJJaVlRa0g4VFRKRzlkYVl6QlhOSnpV?=
 =?utf-8?B?dGUveC9wM0ZoWDYwYkxJRDlobWpsR0gvc05tdkR0LzFRR1duRm9pVjlJS2o3?=
 =?utf-8?B?Tk5CZFpvSHlJZ3RvZktBWmFZK3RPblBKN2VXUVR2d3N5Znk2bVMxQUc3NjF4?=
 =?utf-8?B?NWdzWkZFNXBTenJZZ1hRL1V0dDUyZk1UbXQrWUpLT2RDakdTeFEvVjZkSTJp?=
 =?utf-8?B?VVY5Rzl5TjV6WExoZ0RpMnRJTG9vUFR5ZHllS0hqaWdjWEN1Tk9zRDYyZ2Fu?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c943e2-b6e6-4d25-bfa4-08dd86667148
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:07:50.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYScOou6pTnnKnoVSHkGiHTjaHkxE3HAAVbTN7v9Wobspe3RcngQyvZ0xMiyu8rRPWAeLUuCg8wBvUMNlNwcjGvsSmAApWFQGVJhVVNrhLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8830
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

On Fri, Apr 11, 2025 at 06:51:55AM -0700, Andre Muezerie wrote:
> On Fri, Apr 11, 2025 at 08:52:12AM +0200, David Marchand wrote:
> > On Wed, Apr 9, 2025 at 4:27 PM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > On Wed, Apr 09, 2025 at 12:54:40PM +0000, Praveen Shetty wrote:
> > > > Truncation of constant value compiler warning was reported in clang/msvc
> > > > compiler for the VIRTCHNL2_CAP_OEM bit setting.This is due to 64 bit number
> > > > is initialized in a 32 bit enum.VIRTCHNL2_CAP_OEM capability is not used in
> > > > the present dpdk code,so removing this bit setting from the dpdk to avoid
> > > > the truncation.
> > >
> > > Please just watch spacing after punctuation in commit message. Will fix on
> > > apply as necessary, no need for new revision to fix it.
> > >
> > > >
> > > > Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> > > > ---
> > > >  drivers/net/intel/idpf/base/virtchnl2.h | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/intel/idpf/base/virtchnl2.h b/drivers/net/intel/idpf/base/virtchnl2.h
> > > > index 3285a2b674..cf010c0504 100644
> > > > --- a/drivers/net/intel/idpf/base/virtchnl2.h
> > > > +++ b/drivers/net/intel/idpf/base/virtchnl2.h
> > > > @@ -265,8 +265,6 @@ enum virtchnl2_cap_other {
> > > >        * if a reserved bit is set in a standard completion's tag.
> > > >        */
> > > >       VIRTCHNL2_CAP_MISS_COMPL_TAG            = BIT_ULL(20),
> > > > -     /* This must be the last capability */
> > > > -     VIRTCHNL2_CAP_OEM                       = BIT_ULL(63),
> > > >  };
> > > >
> > >
> > > Although technically perhaps not as good as [1], this avoids significant
> > > divergence from the shared base code, while still fixing the core issue.
> > >
> > > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > >
> > >
> > > [1] https://patches.dpdk.org/project/dpdk/patch/1734537913-1159-1-git-send-email-andremue@linux.microsoft.com/
> > 
> > LGTM.
> > I marked Andre patch as rejected.
> > 
> 
> I'm good with that. My main goal is to get this code to compile with MSVC.
> 
Applied to dpdk-next-net-intel.

thanks,
/Bruce
