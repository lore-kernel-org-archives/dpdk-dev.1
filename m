Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E4BC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 10:42:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA0FB40156;
	Mon,  7 Apr 2025 12:42:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D193840041
 for <dev@dpdk.org>; Mon,  7 Apr 2025 12:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744022556; x=1775558556;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=E9ggf3ybFVHq6T2gxdR5rhSdaQlqVRJJuIUPczIc7gg=;
 b=PywWo7OOVtaE4jz2snm7jrjt4MEGSq8Am8ezG9Xv9zIFHcBIPIGhqs1V
 SkK4FZeJhtcL9m5cLp/6IX9N0hf8K/AoWy2cC+XIVUIZyS0PYD6TnbBxI
 hvBkV4hg7iR5tdwEeE7YE2tUhAy/oLv5+iTT0/ucrEGexQ7uxEnTrOXTI
 6Y0t9Gu4x1KtgE8qIAiJO5Fd8YSDLWsNalaYosq8TbIZ+QnmF4oZtmEG9
 cRJ7jE2rFyZ3u1Q2UclC58HXAZO04mZqefp954HnXuJsqoNa24xvOF9Wk
 0zOsPcyOJHY5CF2uld5NOh8z/jWwJKGk5F1oVN17urtTJ8RsB6kolFUAz A==;
X-CSE-ConnectionGUID: Jk71XZ04RraHciQyxNynrQ==
X-CSE-MsgGUID: oa6nxr5kQI2JzAqJ0fJ4og==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="44647627"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="44647627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 03:41:03 -0700
X-CSE-ConnectionGUID: XRVrv2cGRfebC3mK1B3h5Q==
X-CSE-MsgGUID: slriV92dTdiRbIBFzbr1HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="127797901"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 03:41:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 03:41:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 03:41:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 03:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY3qCK9GlDLvGxKwUB0P36EYeYVPdb2dor1xrd2cakuxdixOT3+qztJSbQu+7AqUKQiCmiNavtsLgX620fdideTJbPu34lfj+OVBKk63L5KYeR2FOARMiMuyAAyhk9idS20BYRETdHU2HREWtDa3NEqfRzPvUA9W5q03KI6GrL1e8NUNmmZRB1+ZgnRBALsN3fX8SSRe2aZiCb2sJTe9V8Cif36WtoRVc+pN0uz5UTs0StrBdiJmGCtbC6LwLnHfHj3i69cAxs/i5DYEz7Ae3DErWhqj8gOkyV5bHMInQsKvVMEVNnqW2fwIPQRocmMBuGWX4vQSLduyCHQCsGQNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3pYL2/UlKjPkFxFpYwSomJM8SfZVr5K8tT5a13YJ0s=;
 b=bsQhfNVGYfIK9GYWD6c8BI9YPG9FZEreL/G98ZEkR80qRBw/3LUHqpwMLB3Izn+XmVWc/+aPSO0ZsjNP5sPKdm8Djln3XfBNo5zv0ZhiiDmprv2+6iVoJVdBIfpufY2Vbciu68KY14o8G4LplJox2xzsOVxLiYkgpqCqOdklc3ZneSF91H8q16n9/AxYr7a9TAPGk5U+J9yiQMrKeuDO1YwfndNQZ05aYdaZK0i7Haj0dKL6WimPuJHVecwi0CFOhwGtFTPgEaI+qpoq3gunIMOnCBQnMio62M9zxBcShlYjCyaxTlW3HWjxJkvEasN7u29ZTlkRroavzEce8PcmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB8293.namprd11.prod.outlook.com (2603:10b6:a03:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 10:40:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 10:40:54 +0000
Date: Mon, 7 Apr 2025 11:40:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
Message-ID: <Z_OrsVaV64pLREqv@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
 <Z_Ofcb4ktAmn2RqJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB99@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB99@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6c3fa0-758b-4413-05a4-08dd75c0ac4e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm9melpsa3d1VGhmWEVFbHpXT2E3TVB3R2JNWThQUnUxY1BVSU5nMDFhMC9H?=
 =?utf-8?B?ZmtQTmg5cmRCdXg1akhDMEtBNnJSSFd1UDJ4SkNOR2d4YnZxTnpORzB4T0hq?=
 =?utf-8?B?N2VaUjF1UWM1VU92RXRTd25ZM0EyM0xXL3cvTTQwWEYxa3cxcnFPYWQrRE5N?=
 =?utf-8?B?Qi9tUkhZeUcvQ2dlNWIraTVwUkoxSDRwc1RNUU9QM2lXa3hsMGpGQmpzK2NO?=
 =?utf-8?B?Vms0a1RoOU83Ti8wVGZnSTdIZFJBZk1qLzRUT1RSd0N4RUJ0WG9qcW4vMEhS?=
 =?utf-8?B?RVRQQW9va3ZyVTdSZW4vWktkbkJRTmR3TmJCb21OSTN6cDFsN3VxcThvZytN?=
 =?utf-8?B?dVZtbWNvbkh3SHExYlQ3bk9MWFpUV0tzWFJDZGhrWEtERkJHZWZ5Zi9WSVlZ?=
 =?utf-8?B?TkR1Mm83SjBqTms0V3lYdG5jUFVGTkZSeWVmYVdyK3ZOUjBVZXg1Zm9YZTYw?=
 =?utf-8?B?WEJmajhyODhMTExBTENKaGxkbXFtMUlGMkxuZ0JrZzNrYmRjWTk5amhkSGt0?=
 =?utf-8?B?TUFodk5BNmN5dmVPNEpMOUM3aFRQYUpkNXYrL3ZiSVBJN3hpMW9IQzY3UlE1?=
 =?utf-8?B?T25IOEJ2VjlycXVUZ0JuR1BGRmdMUndJbitTdk1oZ0swaWtKN3IxNjlmK2hV?=
 =?utf-8?B?UzZkclZ3bUo3anp1V2FKRzZFR3JXdjVrSS84Sys5dlp6Vk1VUTRTOGVCbVJF?=
 =?utf-8?B?dDRnUGM3b1JCZitlaFdNQmhMc0svRXk2VFRPL2U3RW8yZVR5aUVRNlJqYUUv?=
 =?utf-8?B?WjFMV2V0Qkd6YUxhRi9IZm11bEJBVEJDZm9yTGR3cUhTLzNrdy9tY1gzRHVP?=
 =?utf-8?B?NlZQbXpzUEVnT3lVNFFMejBURkFPRGxVcUxpb2hJTWtMbjl6U1FmL2RwcEZi?=
 =?utf-8?B?RVlCSGNTUlNKN21zNEFwR09wbHNHV2VkMzBDQVlEWnlwTDBzejQ2UU1zNU4z?=
 =?utf-8?B?VUMwdjVPQWt0bVNvVUY1NVl3UTByK2hENUYzT0lrYWRibGVYTzA5anZvRWll?=
 =?utf-8?B?ZW11UzlLSFBjYkdmRy9YVHlxY3NpcWM1cnJ2b1hjTlJ5QzRRdmk5Mk1PR2Rk?=
 =?utf-8?B?QWkzR2gvOWw0SVBKYWlpVk1BNkJxemcyd1NMd1Y0R21OdHBWbExSbkVJTGxl?=
 =?utf-8?B?MzFDNjJROXBHWG16YTAxTTNMWUVHNGgveHJadisrSjRleXpjVDZ2SUVZNXBO?=
 =?utf-8?B?WGhsR0RGSWpZTExmNjdFN3hHQnAvNUxkOVVyMEthdHZnL0dqcHZ3Q0lncWUr?=
 =?utf-8?B?NmpEMUxwOXcxZ0k3ZjZVeVBKd1FnQ2txdDZ5bDY2TzVTbWVhL2RiNjZESEJI?=
 =?utf-8?B?czVrd3hkeGxlT1JlTE5MTG5nNlZmMG1pOExJM0FmanROVUZORFJzOEEvbVRQ?=
 =?utf-8?B?aXIwQ1dpaXdrdkx1ZE03TFBDYlpJTmpGb3FscDM4WHRYdzYzdmY4MXcxS21N?=
 =?utf-8?B?M1FTVWtDSzNHTzhLZkYvK1JmSGVpU0ZJdmxDN0RtUFdkWDdpQ051Y3JSTjBH?=
 =?utf-8?B?NnY1THR2M2p2S1hDMHNaUXZKU2lWaFFYQ0F4MUthcCtFdzhZMXcvb241c1NL?=
 =?utf-8?B?Z1RQNFZ5YndnZ1U1Z1RhOXh3VmxCYnJvZUszcmVUMExidGpFVE5hcVFJR2Z2?=
 =?utf-8?B?SC9LaHlxMFYvZlpOcUQwY3dDdjdpMUVIOUJDTjRPNnJld1M4YTJEYVJhN3Vh?=
 =?utf-8?B?VWlocW0ybE5sQVI3QmtCMHV4YkdiTFh3MmEyRUFLTlV4UVlnSHI2cXAvMTA1?=
 =?utf-8?B?eDdPamV6QnJERm9NVlIvcHRRQm9RdTkrUUYvcXhHWWg5bVJPT3MxWTUxZnAr?=
 =?utf-8?B?SVlZYUwwQUtiYk9XZ29WN2YrNmw4Zis3MmhJb3VBbmVGMEw3Ukp3dlFmMllo?=
 =?utf-8?Q?otksxrvXEraiN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWU3OTcrWUh3Q2c0bUZodXhyMzVzVDBZY3grTjRzM2QzNTFVaWpHS3R0Zzkv?=
 =?utf-8?B?bUE0L01HMnpZQVZ3VWY4TWVGMWs2QlR5WmlURHZMZUJJUDcvRlR5ajdIWGI5?=
 =?utf-8?B?VDh4ZlJhMkR0VmJzSVVUSzRNemJFV1RpaXVDbDg5REdMYW1iKytQOUs5bXZq?=
 =?utf-8?B?Q1hONi9qQUtWWTA3ZEhNdTV6dWV4QkFwTU5Eb0ZTNk0rOHN6bDlMRi9IZG5h?=
 =?utf-8?B?alc0K1VEWWZORStTelFxUEpQUk0rY2dZRVJraUpCTGhyejZxVlJSVlptTURj?=
 =?utf-8?B?NEZHQ1gzZnM1M2hlR2tPSWNSUi9XNXkvanhyOEp5SjBuQjVDeGdaTW9hWnNm?=
 =?utf-8?B?MXNyeUxxdkpvOE1vZzFieVBVczdaOGx0cDBxdmtHeXRnNWkyMC93Z2VSV1Jy?=
 =?utf-8?B?eFFyclkyUTBDY3NFTURrZ2JtUGlNbW4vTEt2aDFLUnVvNEFpbkxMRW03UWtE?=
 =?utf-8?B?RWEreis2dnozZkc4NDZpU2c4N3pXZDU3cEZQdFpidStWeEtPWXdqSHQzV3BL?=
 =?utf-8?B?OEtBOHBpbnBnL1lRS0h6KzlkdTV0NGx6ZGk5cTVmdTNZVE1OZkJtbEFnT3d6?=
 =?utf-8?B?VHpWdlZOMUpiVHF5V1Z6b1Qzd1hiQlBHSC9sT2p3MEVFcnZ3M2Q5d3B5Szc2?=
 =?utf-8?B?Z3VuMXhnQ2JFamY1Tm92R20rNjhkQlVWakdGM2Q1K0swNnFQayt6clVCLzRX?=
 =?utf-8?B?U29vT0ZzVEZpVWszbnpmMTBVRDQ2N3ZlZVAzbmF2eHNPNG5kcFpib0JXbEJy?=
 =?utf-8?B?SzluMlpzZW50T1d6OWNQdFNmaHczcUVsSytjU0EzN1RnTmVXV1doYWNzUnd0?=
 =?utf-8?B?RkhmeXdwdTlFUGZ1UlI4N1B2d094cGU4OHB1bkF1MGV3RWl5bkhKL2hSWVQ2?=
 =?utf-8?B?VFF3KzZkd05ORlZ6YVNVVUszZVBJZWhvOXJqUFVRc1Y1T09hRzNXN2trWXg1?=
 =?utf-8?B?clN2Mm1TYUk5RTQxZHJ4R2VyTUdFNXVmR0NtRDVhTmlZNnZaWDBxZEs4SnRz?=
 =?utf-8?B?RkVqVXNQY01kNlpOaWhoTGUzZG1pTFRab3J4K1Y0cFFHTmE0dUhsWUdkR3JJ?=
 =?utf-8?B?TCtId0lrelJjL0pOVXBjMnF3R3Vuc2sxNEVhYWV0azQ5S3k2cjJBdkFsVmFi?=
 =?utf-8?B?eEdYSlhaMFdPUW1ubXh0Z3VhcFNjV20yVUY0RFF0Vm9WYVVINzRkWjNXNjZm?=
 =?utf-8?B?anYxZ3JUNVpIWE9RamxwRzZQa09UMVZFdkhSOHJoenRlWGxSbHZ2K0g4ZzhC?=
 =?utf-8?B?b0VmWEFWRUxrWU9aOE94aEFPbkFkWnRGc1JJNGcxZ2drMjlpN3JHUjJlbk9s?=
 =?utf-8?B?RjRVV01WQW11dG05cUYzUHhpdkxVYTkwbXlaejdnVzNBWDVoR0RnK2dWOVJt?=
 =?utf-8?B?cm5yUzMrSmlwdGR1Y21aR1BkSUlnMjlmS1pTd0VUb0Rtb25Fci9zeGZuWVFy?=
 =?utf-8?B?T2JtZlNxMWNuK3JSbU9TczR2UzRFeXQ3L0hvZDc0NEJ4THBXTnJjUDBxRFM3?=
 =?utf-8?B?TUgxWGswcmNUZCtjUkppS2p5TU9iL0FpZlc5K2JzditzTDJFVGNtUGh6RkMy?=
 =?utf-8?B?R256UytYSG9oWUpnZ3MxTXNTMFkwVHh3RU5PVDllYlJLMVFOQXo5S2gwWkFp?=
 =?utf-8?B?TFJoNzN3NVUyYUxMMG55NHRsSzdHY1BYQmhtSDBzV2FXaTk1cTdNdDliUkd0?=
 =?utf-8?B?VGtySUljaE9uak9STzVnUFFobzB0YTdFTGdxNjNvYUROUWFOcEZlaWRURWxq?=
 =?utf-8?B?QzFMemJmYXE2S0xYZVFLRisvVWU5TXYrRGFIY1cwUzF3Uml4TnRyaEwzM2tL?=
 =?utf-8?B?UGJzN1ZRQmVaUUlINUlYTHhxVHBCOUxZODhLdERmMGQvQWxnMEdrMnp6MXBp?=
 =?utf-8?B?V1drSmNaVXloK2tFWjBIOVdWKzBPQXNHYmZkMnh2YXFWUXNLVFdaeEc5c1Ny?=
 =?utf-8?B?bERQK3g3Y0g2MDM0QjYyTnFQNS9nY0xjaUsvU1h1LzBvNDNFWGphNzBGblJS?=
 =?utf-8?B?bUp3TEFYeE9FUWZiZTl6ejVMSTgxQUl6d0ZKUlNmU3VlaVNrREtZMk1aM0FV?=
 =?utf-8?B?VlpJS0lPeHhQaGRwS0dGM0ttQnpNS3VrbGxRZFJoaGJDQVVVU0RqSDl4YkdB?=
 =?utf-8?B?TzFBajFyV2ZNWTR2MmxoSWxYN1BQeStBWUU2eGU3M2VhVUJMNjA5MjZBVmdJ?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6c3fa0-758b-4413-05a4-08dd75c0ac4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 10:40:54.2905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc18rYVKKmr+5y5Iym8tD+rzGNr4a+X9mQqVetVBgOuyqV0S2uL4PMv3N3tssor4FSqs499x9Una30PuyetbX0JtfxgXBLYoBC5DsadvNn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8293
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

On Mon, Apr 07, 2025 at 12:15:13PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com] Sent:
> > Monday, 7 April 2025 11.49
> > 
> > On Mon, Apr 07, 2025 at 09:04:05AM +0200, David Marchand wrote:
> > > Hello Bruce,
> > >
> > > On Tue, Apr 1, 2025 at 4:08 PM Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce Richardson wrote:
> > > > > Traditionally, DPDK has had a direct mapping of internal lcore-
> > ids, to
> > > > > the actual core numbers in use. With higher core count servers
> > becoming
> > > > > more prevalent the issue becomes one of increasing memory
> > footprint when
> > > > > using such a scheme, due to the need to have all arrays
> > dimensioned for
> > > > > all cores on the system, whether or not those cores are in use by
> > the
> > > > > app.
> > > > >
> > > > > Therefore, the decision was made in the past to not expand the
> > > > > build-time RTE_MAX_LCORE value beyond 128. Instead, it was
> > recommended
> > > > > that users use the "--lcores" EAL parameter to take the high-
> > numbered
> > > > > cores they wish to use and map them to lcore-ids within the 0 -
> > 128
> > > > > range. While this works, this is a little clunky as it means that
> > > > > instead of just passing, for example, "-l 130-139", the user must
> > > > > instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> > > > >
> > > > > This patchset attempts to simplify the situation by adding a new
> > flag to
> > > > > do this mapping automatically. To use cores 130-139 and map them
> > to ids
> > > > > 0-9 internally, the EAL args now become: "-l 130-139 --map-lcore-
> > ids",
> > > > > or using the shorter "-M" version of the flag: "-Ml 130-139".
> > > > >
> > > > > Adding this new parameter required some rework of the existing
> > arg
> > > > > parsing code, because in current DPDK the args are parsed and
> > checked in
> > > > > the order they appear on the commandline. This means that using
> > the
> > > > > example above, the core parameter 130-139 will be rejected
> > immediately
> > > > > before the "map-lcore-ids" parameter is seen. To work around
> > this, the
> > > > > core (and service core) parameters are not parsed when seen,
> > instead
> > > > > they are only saved off and parsed after all arguments are
> > parsed. The
> > > > > "-l" and "-c" parameters are converted into "--lcores" arguments,
> > so all
> > > > > assigning of lcore ids is done there in all cases.
> > > > >
> > > > > RFC->v2: * converted printf to DEBUG log * added "-M" as shorter
> > > > > version of flag * added documentation * renamed internal API that
> > > > > was changed to avoid any potential
> > hidden
> > > > >   runtime issues.
> > > > >
> > > > > Bruce Richardson (3): eal: centralize core parameter parsing eal:
> > > > > convert core masks and lists to core sets eal: allow automatic
> > > > > mapping of high lcore ids
> > > > >
> > > > Ping for review.
> > > >
> > > > At a high level, does this feature seem useful to users?
> > >
> > > This seems useful, though I am not I would touch the existing
> > options.
> > > I would have gone with a simple -L option (taking the same kind of
> > > input than -l but with new behavior), and not combine a flag with
> > > existing options.
> > >
> > 
> > That would be an easier patchset to do up. However, it would then mean
> > that we have no less than 4 different ways to specify the cores to use:
> > "- c", "-l", "-L", "--lcores" - and therefore need 4 different sets of
> > parsing options for them, and more checks to ensure we have only one of
> > the 4 specified in any run. That's why I chose the modifier option, and
> > to try and consolidate the core setup a bit.
> > 
> > However, if having a completely new option is preferred, I am happy
> > enough to do up a different patchset for that.
> > 
> > > I scanned through the series, not much to say.  Maybe add a unit test
> > > for new cmdline option.
> > >
> > Sure. Once it's decided what approach (if any) to take, I'll do up a
> > new patchset, taking into account any relevant feedback on this set.
> > 
> > /Bruce
> 
> Changing the EAL parameter parser to a "two pass parser" makes sense.  I
> think checking for existence of more than one lcore specification options
> should suffice; we don't need to accept multiple lcore specification
> options and check for conflicts.
> 
> When remapping, do we need to support gaps in the "lcore" (logical cores)
> array, e.g. for secondary processes, or can it be continuous from 0 to
> the number of specified lcores?
> 
> And are new EAL parameters for this really beneficial?  Doesn't e.g. "-l
> 0-9@130-139,100@140" suffice?
> 
Actually, I believe "0-9@130-139"[1]  is not the same as
"0@130,1@131,2@132,...". The latter affinities one thread to one core ten
times over, while the former affinitizes 10 threads to 10 cores - leaving
those threads free to move about within the 10 cores specified.

Just to confirm, I tweaked our helloworld example to print the cpu affinity
of each core when printing.

./build/examples/dpdk-helloworld --no-pci --lcores '(0-3)@(30-33)'
EAL: Detected CPU lcores: 96
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /run/user/11304126/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
hello from core 1, with thread affinity for cores: 30 31 32 33 
hello from core 3, with thread affinity for cores: 30 31 32 33 
hello from core 2, with thread affinity for cores: 30 31 32 33 
hello from core 0, with thread affinity for cores: 30 31 32 33 

./build/examples/dpdk-helloworld --no-pci --lcores '0@30,1@31,2@32,3@33'
EAL: Detected CPU lcores: 96
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /run/user/11304126/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
hello from core 1, with thread affinity for cores: 31 hello from core 3, with thread affinity for cores: 
hello from core 2, with thread affinity for cores: 32 
hello from core 0, with thread affinity for cores: 30 
33 

Regards,
/Bruce

[1] This actually needs to be "(0-9)@(130-139)", and with "--lcores", not
just "-l", there are actually different flags with different behaviours
