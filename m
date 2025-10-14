Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5EBCCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4274A402AE;
	Tue, 14 Oct 2025 11:06:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8A01B402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 11:06:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760432809; x=1791968809;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZHVU1zFppywttDId5ons5+awL/3NUwPza0TYg6dUAJQ=;
 b=nOkhBKxMbX8DVyQ8gDHynrfRn00lTOBxXnmUOJSXdVeES6LgZ5lqsSYI
 AaqXfJhrl1VMv0jKKZCTm4Mq5Ub7k97VJ5Z/i3quPaXsBmJlCuuSlkt+5
 jsGd8a38Uf0i7GQCLHczE7SGqoXHR+Ai5f7XDIjSd/2eWZKRZg+FiZjnc
 5+npUUDSNnqOn9ikXjGdnW18g78+w4YzwoxQnKv3KMWABKwkTSL5LrLmq
 bX8B1xkzI+sZuxuaaLifHi9vlzIcaGByzHYw3mCVNn4n2/8VuS4vFB7BD
 NBmhbW486/zPlzk/TM5Nj2WHLN8oUETlrNPyMoelNQuf24BA4qQ1RzmvF Q==;
X-CSE-ConnectionGUID: L67iRpsRRb2SiDPn9w8HUA==
X-CSE-MsgGUID: wdDCd1WqSsqe1zfsOCAgiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62518113"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62518113"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 02:06:47 -0700
X-CSE-ConnectionGUID: CFFakUgLQn+BEEgfFSLmNQ==
X-CSE-MsgGUID: 9jL2lSGUR4OxfBjSnWmivQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181513041"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 02:06:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 02:06:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 02:06:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 02:06:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQ3vnTR7+P02FWeNCjT9lQk5R5oibiM0lVw2zOjuhRz3dsk18XEEMZQyTFmXu2UMe/KxUdTzMHxPQnzgyfgCsS06kYfPGh/hu32ZbO65dkLRsCqKElArHB2mv6fGDEYEjH82I5K0Usyi7JV91J7ObYFHul4fiW73rLaUBGUpohg+TLRvIY5QWpr5Nk0cv5ZgzawlD64CtthET9W0ouWYYBhvVyy+0PqybdC50pnQwX4W1QHfwoVe6lX6mxS2CW96+e1QGqkCzi3WQWeyzQ5IGpzxPJRZIvdLJPqJnmvmCS+Nlcc5VMQv6RW92GZ1f0htbBo7+R7LQYaWaum+NR6E0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO5b9gZa6lnRN/Uw7Wm8QqoRCmpwbKw15sNMPbkT1Vg=;
 b=DbXy/aT/8sVYAk8CcNwfiAp8lQydXIJpTOw1RJ4KSs/xu1WeIZdKn4/CqwzSRQRgG7OPXwSrTt6GaxwIDmi8wPCvuZ0TUoCA79+4DPNeVfH0wj9Ql9LWjowkcR/wkdgLobMLIgJ2glESnhICeIQoZkL0k5JGDV1cMSKR6+G95I7mBY3GzgK2+4gPfS3QtDPAEKmqOF2/Ki/73ajkhh09ijCK8zMs3AFyBGJvvyR6KqmI8fW7Ql+s3YXz9ukRRTJDPnyhhFVCSvbDwxJpZZqPN9YSw6qMOfiuY4HsfM/Wikr6WoEqETBJmdFlAVlRn/XLcnAlAi5y1ysaKud0jfthkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 BL4PR11MB8822.namprd11.prod.outlook.com (2603:10b6:208:5aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 09:06:38 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 09:06:38 +0000
Message-ID: <17724fb4-337d-4300-b476-d4188f3814a9@intel.com>
Date: Tue, 14 Oct 2025 11:06:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] eal/freebsd: Do not use prev_ms_idx for hole
 detection
To: Jake Freeland <jfree@FreeBSD.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20250814213246.4141803-2-jfree@FreeBSD.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250814213246.4141803-2-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::8) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|BL4PR11MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b24bcd3-6431-4f7c-a615-08de0b00fb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmE3OVRDRmRVYlNJZlU5akE4aWFXaUlIcnFQOWdodXRRT01DbGpNYk1zRGtS?=
 =?utf-8?B?MmhwNGpkaVZNb0VmZkhnUkpSSzhvUGVEN0RIQ0EvenE1dXI0TDZjRWZkTW5U?=
 =?utf-8?B?K1c3Wkludm1jNUQ5VnRDMFh3alMralBaUXNDdEVNeWpocklwWlhscVlIZkFo?=
 =?utf-8?B?QkZMS2ZVcmFzanI3NnR4b1F6c3Nwd3Nxb0drU3UrZkZUOXpkUExaTlF2UXk2?=
 =?utf-8?B?Y2hwUWpvbGdLbEVJazh3eWdMWmRtaUJqdzdVMW96YU5GMEdPd29XUElaRGMx?=
 =?utf-8?B?SHowa1kvcXBUenhRTTJhSGlNdzR5L09haEdCM29GbWZ1VjNBejZiYmtmOUZN?=
 =?utf-8?B?V3N1cHZuV045aVFoT1RJUmJoUGMwWU9QVmpwVU0vU2FlQnllN1NYRHFpUmlM?=
 =?utf-8?B?eERLS1F1MlJRVjYzVGVPOE8raUQrU256RHZpVUp1YmF6WkpFMlFlMkFLMEdm?=
 =?utf-8?B?ZmtSdTdxL3Brb053cTdkOFR5WUk0eDcxZTVMcGhCUFdQWXZhYVNSRi94TzVK?=
 =?utf-8?B?TGtudURQV1ZPTFhWUmtSSWdUQk1Qb092V3dEV3RkbGlZY3JtS3N3SEdJbXQw?=
 =?utf-8?B?SytDeEY0Rm1wcmk0Q1NpdkJlcFA1NkFBZ3R5b1dKVHY4Q01aU2x6WnhURHlI?=
 =?utf-8?B?UUNzN2FEUmdpTnhLeDlCeWRNKzVyNGZ0cDZmSFdJN2wzOFpjdzVlUDJhUUp4?=
 =?utf-8?B?NUxXZERHRlNieFZqRUVpTUczQldKV3h3eklaTjByMlBJRVRDMEtPUXZpVHJU?=
 =?utf-8?B?aEQzZGtpWkFUVEFNZlpHa3hWUTZFTnVZR3pjSVNFMXhnNVhYVlR5VTlFb3ZM?=
 =?utf-8?B?dzJwUVdZd1NEOHhISlNlMWVrMi9DWXJyVlVKMmdmSitoTkN1TXpsem5mUWRH?=
 =?utf-8?B?K1liTTJ4NEs4Si96bmNXakpBaGZrdjhGbExDb0VIZ3B2M0RlYTEwZ0dhUnZN?=
 =?utf-8?B?RkFIMWxoWXNCam1STVMzeWRpQVZpejlHUk96ZlhHeUMybHB2TmRxVDdkVExy?=
 =?utf-8?B?ZGxSU01iZG53Tk9zZE9TYVJ0V1dVcmdGZWUrRmY5SWU1Nk9MT0h3eUNKV0tR?=
 =?utf-8?B?UlJ3TlBlMDJhbXkyenBJaEVRUG8veXhFVUJWUmpNU3c1RVJqQXN1Zmo1NGVt?=
 =?utf-8?B?OU16MzBzek1vY1EySXlpaFppM0VFMDgvbkl4cDJpckJUSWpJcC9jTlU4bnZ4?=
 =?utf-8?B?WkJLT3BycStXMSt1UHA2b09IYjMvV2thMDkvajhPQlZJLytTM3lZNlZHUEc1?=
 =?utf-8?B?VFNyUmRjSjQwNVRGcnM2NFM3MmFRaWExTSt1VGhIb0cvcjlQK3JoOGd5WWRh?=
 =?utf-8?B?OFRNd0lOU0tPUTNjWFh2cjRUdnZGQ3pxczBGZU1HYnpsY3l6UjBZZXBPMGw3?=
 =?utf-8?B?S25DQ0tpQ0w1c1gzRzRXaTM1eXcvNnNJcUFnbENGNHdidHRMZjJzaktuRGxS?=
 =?utf-8?B?RGpicHluU0JrQnNaTXUxYWsrWEpKK0lqeHpaRHlXSW15Y1JRK05OTFJwZ0dR?=
 =?utf-8?B?WW1EMElsRlU3QnJxMnZLRnFPcS9IdDV1UTRoaENGNnlGQ1lPMFJDUkQ2UFI3?=
 =?utf-8?B?K2tiUzhaVXhCS0dld3BSWGV3eCtXWEJoa09vUGJhNDJCZjA3Q3BGR2F6QWVi?=
 =?utf-8?B?WUZlOGpXZlk2YkdsNXE5NnhDYTBYL0NTejU3RnRBaVdBTmhUSWdDMUppc2g2?=
 =?utf-8?B?THdpTC94c05FUkVvaFlJdHgzM1BwMHBQTld4bHJOc04wSlBLSWg4VmxUeUpN?=
 =?utf-8?B?K2JWUXhMdGhBV1daQzVXMFdNbllVWnVjT1dpeHpCdTVZdWZOOVVQMzlnME1m?=
 =?utf-8?B?c01RNU5CbG5jYUE5UGxyeUxRN2xoQ1B4Z2JEeGNDckxnOUVDM2NCT1RpaUNx?=
 =?utf-8?B?ZG1laDdSQmdDejhudFh0eFpIZXJrTkxJYWthSVJCam5PdC9MQ2pGbkd4MXVO?=
 =?utf-8?Q?sm83XzKX7rwcVBDCshQW1AqAzF0MgDU9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJqTmU5R2VnT2szV0ZGNHdyblphVktRc1NxKzZtbGhIdUgwQncwWGNsWjI3?=
 =?utf-8?B?WEdXa29hbk9xaFJGWHhhNTVUWmpXNmtVYUdDSWU2UnlIeWtnL1hXQnMwWk1V?=
 =?utf-8?B?L3ljTVhjVHY2OGR5eXpvWHR2dHhCSC9vbEFtQVhkUDlkVUtsanZSYlg5NzFG?=
 =?utf-8?B?dHhkbVJNWXJHaU8wS3h6dXEvSW5iQ05qY21lcHBWcUFTdXBzb1pMNHpjRDdE?=
 =?utf-8?B?cU5HRXJORkJWdGdIalRVTXNTRFlMbjBpZDRpQTQxQzk1Q2xJeFJZc1pRZlFv?=
 =?utf-8?B?ck9YRGFqZFFDU2dWcnRvZ1hZdlB4dGxhUnBnMWxWVFYrWkRFOUpCOG8rU0xl?=
 =?utf-8?B?VG92bCtXSGZKNitka21FUDBrZGUxd2ZUNHp6RFRxbjlCd3FiNjZJYWxaMi85?=
 =?utf-8?B?dzJncjNyMnlIeC9PTXJpVjF0N1NWQ1pQWDRMVUxaYUg2Y0xXTVpWVVlZSjhX?=
 =?utf-8?B?SXpGR1Z0ekwyOVlhVnRWK1poVGZwV29hTkhUUG11VnlZZlUvODdtZTBKZVhY?=
 =?utf-8?B?RjR3MldldGJHLzFxNTMrU1dtdU91djhOUVIzaGZReEFGazUxdTBPZlZhYUFz?=
 =?utf-8?B?M2pMZXJZVU5nRWFNTkxrK25Ib3lCcm9EOENYanFSWTdOWG9FQnlDWXV5cjk0?=
 =?utf-8?B?NnpqSzFlTHFnNzBISC85eUdhTks5azROeXVjRmgvQTJxNEpveTM4bndHSUh0?=
 =?utf-8?B?ZThWZTJxeWJ4OWtvVlRHODNVamRIeWk5d2hTbTNvN3JmNm1YN3FNNEpGQ2NL?=
 =?utf-8?B?RTR4V3U4K0EyMVYwSHlkT2dTR01sTHZhNGJuOTM1b0VCeEppbGdsekNCWXpT?=
 =?utf-8?B?NmFLaHkwRFNldTJRUEw3VEtEVHJHenhoVWZPZTJMMi8xaDI2KzN3Vm4yTUVp?=
 =?utf-8?B?Q1JxK1ZWdVdCTW5ab0E5K2kwWEF5M1hUMnNhbjE1UDFrU0RhVVVSbEdPVnBG?=
 =?utf-8?B?aFhXZkNRQUs1RHdZeFhqNnl4RDc2OEpZN2xJNGdKbGFaMnY3TUlOK0dQZzFF?=
 =?utf-8?B?NVV3aEwxbkdISzJQZzJtVFVkNDdpOWwrb0lRQW5aSFNnVDFZanVyd09sY0ht?=
 =?utf-8?B?eHc2b0I5ck52S1BkcWZDOUVtZHphc0lSMllOZmV5Ymo2RmMrVmZPd3VHRDJO?=
 =?utf-8?B?SnFRc2ljRHNvNk9nNWVJRHFpQ29FNFNIcWw2UTN1YVpYU2gvZmR2S1ZnSG5j?=
 =?utf-8?B?V2VFcWhTMlY5c01idGNuWENlWmoxc3QxVHVKNHI2V1l0Rjg2MCtDTlVsS1lT?=
 =?utf-8?B?WVNZbW1jOC9GTDFLWGxlMUZZcGQ2dVV2S1c0L2V6andZMy9wYThYSjlBUjVZ?=
 =?utf-8?B?ZXVHN2lqYmM5Nk12WTMwOUthbmpFeFpqaG1Ca0EvS2Q4QXpHYndwWXJBMTdR?=
 =?utf-8?B?d0FaUGVzVFF4WnRzZnBsVlVoOWVtR1BtQUJrYmFZS3VPcTFLd3RMbHZYSmZU?=
 =?utf-8?B?WWNhSUlyYlRNRGdvUU05OGhXQW9CQ2MwR0MwZW4zdkkvWWRoVWkwaXdDNUpp?=
 =?utf-8?B?Q25BdWk0QVYyaVJlbjc5bDE2Nm9yQjZQbXBQTTdJN3p3eHNVTjhERHU5QVJo?=
 =?utf-8?B?ZDY5amRLR24zdS81RWY4cjhKNGhqYzF3RDYwcFJSMFZSdGdWUnNMWDh0c1A3?=
 =?utf-8?B?MXlwRzlFTFVaNkFDV1krOTFyUjNzdUM3Z1JhNUxzZm5za3VWTXFIZGxRUWZr?=
 =?utf-8?B?VUhkVFZLbGFsZFZKeEZ2WkRCRUd6dEhJODJGZ0p4OHlyZkdtd3ZpVkF0c0tz?=
 =?utf-8?B?ZGlBTjRXL0ZzQWg1RlBRZEZlZld2OFJxT3VTS0pRVVNTNTd4RFY2Y1ZpcHhp?=
 =?utf-8?B?QTlsSG45UVNiMUVQZVJRWkF2TXlaOXlOUFdCVEFSTWMwdXhIdW1Yb1N4YndE?=
 =?utf-8?B?VHNZQndJV0duYlFHU3VucGdCdmRQODNNaEt4ZmdRdUNhQ3VKY1R1Y0hGaE8x?=
 =?utf-8?B?S3BBUUtOdjZIK2NZcFJOSG1Cb2NkU2Y5bTZhZmFiclFBRGJxTnZVZFlNT1oz?=
 =?utf-8?B?VU1DVkgwOGtJeUpRcnU2VDZYWUpUMUhEMDQ3QjAyWTExS1V5UzdNcmxFQW9a?=
 =?utf-8?B?bHpZR0Y4WmdZak5ydy9rdmdtSi80bDRTaU1hTEhLM2dzU0dqdGJsUVBnbEcz?=
 =?utf-8?B?c2hqMmxiM2V1QkdYd1pFTDQ2N1lua25tMVVPam14akM1VHgzRnZFYmQzeFNP?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b24bcd3-6431-4f7c-a615-08de0b00fb26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:06:38.3904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOvo4y2nAIPc7pRwHApjzgZFXB76u6nH8Has90Jky6L1HhrBDXXRV004a4G/fa9kMbVkMNwKwuOjFEPKOzI9uHpqKuql2+BteEO+5YucLp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8822
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

On 8/14/2025 11:32 PM, Jake Freeland wrote:
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
>   lib/eal/freebsd/eal_memory.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
> index 6d3d46a390..be3bde2cb9 100644
> --- a/lib/eal/freebsd/eal_memory.c
> +++ b/lib/eal/freebsd/eal_memory.c
> @@ -103,7 +103,6 @@ rte_eal_hugepage_init(void)
>   	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
>   		struct hugepage_info *hpi;
>   		rte_iova_t prev_end = 0;
> -		int prev_ms_idx = -1;
>   		uint64_t page_sz, mem_needed;
>   		unsigned int n_pages, max_pages;
>   
> @@ -167,9 +166,9 @@ rte_eal_hugepage_init(void)
>   				if (ms_idx < 0)
>   					continue;
>   
> -				if (need_hole && prev_ms_idx == ms_idx - 1)
> +				if (need_hole &&
> +				    rte_fbarray_is_used(arr, ms_idx - 1))
>   					ms_idx++;
> -				prev_ms_idx = ms_idx;
>   

This is not a bug as the logic won't allow for this to happen, but some 
static analysis tools might flag this:

Earlier we check for ms_idx < 0, so assuming ms_idx == 0, we will pass 
(ms_idx - 1) to rte_fbarray_is_used. This won't actually happen because 
ms_idx will never be 0 if `need_hole` is true, but *technically* it is 
not impossible, and so should probably be addressed somehow to avoid 
false positives from static analysis.

-- 
Thanks,
Anatoly
