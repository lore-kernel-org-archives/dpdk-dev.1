Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC6AEA3F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 09:29:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14E74402B5;
	Wed, 11 Feb 2026 10:29:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 39F7A4026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 10:29:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770802180; x=1802338180;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nco/XqooZpIsZMc0Es+cMPHjkz3NhgcZebGxlGnoYiY=;
 b=Cztnqtd3yTQDyzeIXlifhVLceXB0MNIgPFP4/qQ1z7eHnD62ldi+KRp0
 jIG65Sfv+n4UqyomM7Qf5WVIrVbrxDZdtnhdWlyLfe1yJkkPOR5RZw8wE
 rDU0ZmS4KTgvn1KlsQRhZvy7Rw+2Njb81Wb19BOIkHNBACsNY0bCeb78T
 hKzMH49vLgRvlcj8Se1z9ffolttLiCASo+Ap8ghkRaw/VzLW5DLa2feRQ
 3O0q6stCjAP5zQEuUKH0F5VXl7mCw+BY3Dc/nNhV+rxAFk8RPdtRw5DMQ
 PsAbmfFi3jm38oGlRLLt0b8Xt4JhGpWPWobC0kWVTpsBiAbv/zcwnLfqi Q==;
X-CSE-ConnectionGUID: zf6JT0QMRNG6Sl6S7LTvsA==
X-CSE-MsgGUID: HYhzNK4zQp6P5J+HKY67lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83388277"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83388277"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:29:31 -0800
X-CSE-ConnectionGUID: rTEULWtuQLmN+kMnGJ8/FA==
X-CSE-MsgGUID: Hc4rKvgIQJakliwxUxv5XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216715531"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:29:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:29:31 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 01:29:31 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:29:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sa4gAk/7jN+HkJXg10GnRLdSCwcQpC2/PYy6wVFdfwCG8D5E6mvOqtzIZsQuINDOjsBz9ISjLkW1W2YxgPuO6YZIamB9yK/i4S5XyPrwvTVuON/9omYUnavctcjweh44vTuc47XL6xLilVjrPG+6ceWSl1d/4BqcIzVUllmj79pG8LHqn7neCfzv4dM0eiqIm3HJygEQ9w7MfzpCs1/eD631nbIy00rpyKrb+UiIoRW1Tk60t/TNuPHPEOjC90/Cvuix7sq6XAnqKJAPcNj4M9ekp9ee0CylgfdTLN28uQnP7WWvCVN6kvEnw5nHYYRiLJijaEGeB/WqxnbF4Z+DqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0RWzLuSgfoGnSrxRNGjiy6GBoy5xGz49AX92V2aqM4=;
 b=xET58wC5kDbBNHD2Qsfu26Pntv/7hlj+5Nn0kPkPhAuckKX0Ep90CPFtU7KE59OYg8e0Jega+SuesLc+WKnITyP+qa0mdJfBq2bS3nT+X0hypdBSrrewjnqHjJwWb8fq5ADkohLt61KKUjd3pRgwLPUZcp7rv0vcHUzHb15bVkUap3kv4XBJxk5ufpEELp6nDsEZDG503AkR6BcDpq64q2IfAt0Fr5hclXf1CGcacjwW81CNpsseCDA9JpdipGZFfpB9r8Chwkq9WwTv4aqC1haD7yCK/pMiVfHOmrSjR4vcmNf1THNs4PGg5atJWBpcfUAJUWRNFzTgU9jPoR6lSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 09:29:23 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 09:29:23 +0000
Message-ID: <6ac617d4-7e22-463b-b4a6-3d93961edc95@intel.com>
Date: Wed, 11 Feb 2026 10:29:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/35] net/intel: support configurable VLAN tag
 insertion on Tx
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-15-bruce.richardson@intel.com>
 <6d8f5c9d-c014-4763-bff0-215b43656b9d@intel.com>
 <aYt20BirTtIdIutY@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aYt20BirTtIdIutY@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0255.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::27) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e5f536-9453-42c5-ecaf-08de69500a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anJRR055NEc0bHdGV0sxVlRIcUVwQ1pKUTJRaitlS0NYSWVMSkVJOHZNY0NW?=
 =?utf-8?B?QnllSytNNkE0WmU3RndpOHZVQWtrNXkxRGxvNUFYUGtVMGNJby9zbkN4cUha?=
 =?utf-8?B?K0p3eVZzL2xPRlV3R3E5RFBlRHBwTkVBNXFsdkxzcUtodEpwOURKYmxLVmdt?=
 =?utf-8?B?QXZ4NnVUcVdiZndBTm5TeThpM09Kd3U2anczOWdFTm9wYm1TaFVSYWFPUWhI?=
 =?utf-8?B?czNQNzR4NVlvS0t6TmZnUW5tQnJtQXVzaENNbHdzbDQ5dklnMEVWdkIwZVM5?=
 =?utf-8?B?b3NBSnVmVUdhbml0eUJORDR3Mkw2eFVqMzFlMVYvQjMrR0hqQTlBWjRRaHdQ?=
 =?utf-8?B?c2o3MzVlYVkxWXFGQXlRK1VEeWdBaUV0MHFMbmNmMnBRYWtpWDlhWnhObHN2?=
 =?utf-8?B?YWRTWWxjeWh1NHNPWVBjYWhFS0k2dzg5S1o1V25ONExQVnlVSkwwbFpPcWVs?=
 =?utf-8?B?WldwLzZ1MC9QcFdMYmFmc1JNejd6YWJ5d1RqMEhCQWtoQWRVZ0thNkpDK3FG?=
 =?utf-8?B?TkFkTmF0SkpLcWxzQ3FhYXJxeW1KanpiUHIwWndjMlV6M01SN1RrcHlOY2Ev?=
 =?utf-8?B?cndGYkgyM0t5VDdpYmhFbmpKNjlBQ2FVcUpmTU55TVdnRU1sNzhBQUNNVWIv?=
 =?utf-8?B?SDNmb0NXbjJ6WGwvS25lMWl0MnpjK1B5and1bjI5Vk9LU1BGcjR3ZitlZmk4?=
 =?utf-8?B?VjFaaG5VekdkOGt5bHJ6MjBjUktabHF2eHdZYUtTeTNtMXJaanpBTHg5ZktC?=
 =?utf-8?B?WHFGN1Irdy9hLzl5NlYwZndhOW1QNDVmSCsvQURwQWpBb3RxSUw0SjZlS1NN?=
 =?utf-8?B?S0p4V2ZwN3N4YUVzYWR5Qy9yTXNlNmt4azhaQTZhUnJxdHJOa2pCR0VuL1dx?=
 =?utf-8?B?R0gzTkZHSlhNY1kyZHlTU2lnNzduUUJ4VjJkL3IvdmY2L0xzd2hrRVpxRHJZ?=
 =?utf-8?B?S3g4V2lZWjVXSXJwRmgvZmNCQVJ3T1hVUGVpVXFPVkF1T3JKVU1zOGVqdC8z?=
 =?utf-8?B?T1hLUW5nS0FxNzBjR0lTOE03WGd0cXJ0alcvd0cyRUFCVzl0RzlIc3pXWXFh?=
 =?utf-8?B?OW0yN0YyNm1ROGtUOERiTXlvaURNNmJKMTJxcXFTaUpPRUkzdjVkWU5QdlY3?=
 =?utf-8?B?TGVENEtCT0ptZk1mN3R2VGl1OHZVSTI2R2JXOXBuVEVUVlBEczdCY3hIRDN5?=
 =?utf-8?B?a3d2bGI4Q1c3aHVtV2U3Z0svYlcycUVYMWt6djN0QzFQTnRONzVhYWc4Vith?=
 =?utf-8?B?K3Y1bHB3UUR6S1c1NEdLMm8vZnZpWklRSnVySE5NYWx4VDdnWVFhVFNUeUtB?=
 =?utf-8?B?SWxHRW82bk5uUVd3dGhGWGpxOUVEZ21ZeXNKYkZBSWZGb1FHTG5lTVFQRisx?=
 =?utf-8?B?djIrbW40cVdDYm9LQ1hWVnNEcWc4U2NrdGo1dHBieUpDQmtRc0RyQ00rSU5r?=
 =?utf-8?B?SkZNajE1L2FTN3VtRVhVeGs3M3VnTDkwelNmNndhRkhqUURzREhaYzl2anpq?=
 =?utf-8?B?QVlnaXgvOXFxbXdlUGNwL3FMeE1MNU1mK3dnZzYvUk9EaHBiTGwwTks1bDRH?=
 =?utf-8?B?K2kwckFOMzZ2eERmdDdKREN4b2x0cmlid0dLQWhsOEwxNEgvYTh2TFQxeHYr?=
 =?utf-8?B?R0lyZHp6T2dUU1RkV1RCaWgzc1c1anRwaVltQ1FxMXJYR25zMkV6QXg2ZzBh?=
 =?utf-8?B?VXFuZThPSkF3YnFDQlMzcUs0Ujl6OEV5bHk2Q1pQT3hiYzlJMnc0K0ZVQWF1?=
 =?utf-8?B?UjhPZndyUkpud0FERGJsUVVNVEtra0dwYXhKV0N5eWxNTU9XLzdSRW40NHdM?=
 =?utf-8?B?QlRxU0Y5VkF4ME83K0NYZ0hsaW5saEZ2TWlxeHpyR3RmWUJ0ZmQ3Tzh0czNO?=
 =?utf-8?B?SzZ2VU1MQ29YUXRiVkcyQ2V0WUFqcWt6VUdEaFNmWHZEQUZFeGRJU1JHL2kx?=
 =?utf-8?B?TnVJL1djZGszY2p3b0pSRG5yVElXYnhncFVSTzZxdy9oZURablUrRUtGbi8z?=
 =?utf-8?B?eWRZV2tzcWxtV1hnOFJPSHhPa21XdU9JK0tlTk0weVdSdUxJZHdocmNNZ216?=
 =?utf-8?B?bHloeC85ZGhDNDE2VzBLMkw3SHVHWWx1bTBQTGZXbHZIbi9zSzRvNDhvRzhz?=
 =?utf-8?Q?2baM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZJZUd6MmJZUGVvU2JJeHNFMnYrU1hGdTJRYTkwRzdGVUxiNUlXd0hYaXJz?=
 =?utf-8?B?bGkrbWZkK05MVlNVbVp2YS90UHZxYnUzSGJORk1ZWk16N0ZYRW0zQXBMR0xi?=
 =?utf-8?B?S2Zha1pZN0FTUDU0clBSUDYwb3UyTGNOclZJY1l6cDhhVkJibmZOVmhKV0ww?=
 =?utf-8?B?U3R2U2VEL29SQVZuT0xCV1cwTVBCTjlJWXdoREh0V1d6L1ZxdDZvNWpoUWRQ?=
 =?utf-8?B?Y2M0aitrN1FIT29NNzIyMVNoblU0OS9ra054ZWJSRUhENjMyUmw1YmgyUG9s?=
 =?utf-8?B?ckVSTUY1Q2VZWUl5TDNaWU96RVNKSEt3TEdmVERiSnVsQ2RVTElCYVdoOGgr?=
 =?utf-8?B?Si9lVHNrVWRwWjMvd2JJWkpwd2ZMMzJqYWZYaDIwY1RWQTRYUFIzLzFJWmdU?=
 =?utf-8?B?ZURMbUdaWTFnZUc1TEYxTUd5Q3AvR3MzaE9vMGcrMmJQUE92UkJLVENFMFhF?=
 =?utf-8?B?L0Q0dXRiampCSkRjSkdzUkFRRWF3T3Y3THRQekxxdlJvRGI2V0dTZkd1N2ZJ?=
 =?utf-8?B?OXY5RWRxWHhiZW96QkxLZ2VEVVJnZlBOVVgxdmM0cjFzdWR0RGVYbVZXWVlq?=
 =?utf-8?B?YkhGQlRSdkdFZ2FFZTRJeWt4S0JnMTRib1hKQTNUMHNINUYyRk0wbXRJNkhR?=
 =?utf-8?B?Y3dvUXc4YkN3dXlLUEp5aVR4Qy9GK3JLcXhkZzFNamNFSHhYQldYTTk1ZGZs?=
 =?utf-8?B?RGxhdVdvdEdiOHZvbThrakNiNHIvRk9VM044QmdVeHhOUmROanBqM2Zrd0Ns?=
 =?utf-8?B?ZjFhOURQL3pGR0lVaU50YlVXbjNSKzNabGV3SU1SOXFnYWwrNVdMajVRZzFn?=
 =?utf-8?B?T1RKandzTlZZMEF4L2xDalVNNmp1bkc1K0VWM0sxU2JZYi9ib1dybWVZZXFB?=
 =?utf-8?B?SlJuVUZWNXNnbmJ4Y3RqRCtoUGl5TEQ4TFJUZy9qTGJsdFF1S1lIaERqMXRP?=
 =?utf-8?B?aWpJOXMrUTdudVNjbEY5Sk9kYnREZ1BRbmZaTEk3U25GSFo1N1RQZ3JPOFJq?=
 =?utf-8?B?UzhJNjlQVEZOL1hoMWdNcWlRak90dkJZLzRHbUJ6VHFwenN6MzliYmhyVk1K?=
 =?utf-8?B?Ny9zVTloRjR1QTNnQ1ZvVXVpUlhUd28yQklBWUFxbVJXQUo3Y1orU0lGSWFO?=
 =?utf-8?B?a2hVMHpORG1tQTY4cFJUR2pMeis5cUpWZU5XcUR3eWIweXN0cFMxTnFFanBu?=
 =?utf-8?B?OXVPZE12SEUyKzJmUGpZTDhmbUFDOXJkdEw1aG9EV3VFSmxwdGlRNEZWK21Q?=
 =?utf-8?B?R2lpV1lPQjR5Q3FaQWVrT1BsTXQzRzZFZGRkRUhrdVdPUCtYRk1jRHFMUThK?=
 =?utf-8?B?aWx2L0J6NGFYRlY3L0JmNXZjQ3ZBZDBsNHNGS3pHQWNIWkhTci9TZitoMXVJ?=
 =?utf-8?B?TnpOOUJUeFozbWF1YnRzaWovRkdBMXhvbEVhYjRNS1ZWekMzSVI1cXJaMXFY?=
 =?utf-8?B?ZEwwVXJQallyYnBZZ1Nrd3ZHKzRTMGpWZ0N5Umo2VjBtTU5lSThNR3BDcDVF?=
 =?utf-8?B?WHhrazVhdkVLYkV2NWNxOTRDNW9CQ0xCbXl1ZThLVndnWWpiUXJTckJ1Rysy?=
 =?utf-8?B?cVFWcWhsTk1iaFZZUjBHOWt0MUF1b3g3aHFmekpMRWFNSG05YkNiVXNxUDU1?=
 =?utf-8?B?UTkwRExUTHFkenZIRk5ENVIyQ29zOG95OUtCUmVPMHpMb0JsbmIxWkcwR2xv?=
 =?utf-8?B?b1RaQVNBcEhQOXEvdnBuUzRzcStia0QrSXp2ZEJqY1loUGVzS1BkNlBnRjdC?=
 =?utf-8?B?c0U3VnJuWWNVNTBjeXU4dmVVOTltelpMWG5xdWM3OUZCNk5Nc1YxZ2tvYnA0?=
 =?utf-8?B?OS9uOXhCYnlsTEMzalVBaThsdVFOVXdnSEpIai9ZT2hmWnU3WEdpM0lUaUMw?=
 =?utf-8?B?ck11MnhpQTdiU3VSR2JlUlJnUHNtZ05YRXRVcXQ3dmZtcW45YmZFaFZNNEQr?=
 =?utf-8?B?bUl1bTYyMDVqamh5WmQ1ckprd0tZVTB3ZzZOUjl5NkEzbThvMk9UL3F2bnYr?=
 =?utf-8?B?b083UHRjaFQyMlFLaDR5WFpQYXdqYyt0bzRudzV4bThjOWlST2UxKzMxaFdF?=
 =?utf-8?B?dkZHRnE3Rkd1MXhFN1VMcTYwKyt6SjE1dG1wTVZlWmRFL3drWUtlWWpzNW55?=
 =?utf-8?B?eHFqblNtSlZqa0o2Y3NobU5MWUVVNU9FbmUrTWRYQXlSY2NNQzV3L1lzZWJ0?=
 =?utf-8?B?ajJrQ1d3S05ZRFVrL3ZJUEppWEFaYnV0ODRSUndqclQvQS9PVlp5R1FHTjkv?=
 =?utf-8?B?LzdkMzdJVC9LbG1JV1NRNFUrZkFrVEpGc3JVbkN0Rk5DS3J4RWZxR3ZnS1hS?=
 =?utf-8?B?UVo4bDVHTXhmRmgyZnM4ME1odDNkWHY5YUpDd2g0YjI0Q1RmNUxOekJsTW1o?=
 =?utf-8?Q?GiTGc1DdDX++/Xok=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e5f536-9453-42c5-ecaf-08de69500a83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:29:22.9870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iau9sVgXJzNWQ/vSIyqbr7zouVxh+QWs/xpSuXbR1/h7qzm7SxTRsse/wYRsfqLuSwOhyPvHehY1ZViD1nQoVJaM+SQnYYMPnRW+UxX2szY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
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

On 2/10/2026 7:20 PM, Bruce Richardson wrote:
> On Tue, Feb 10, 2026 at 02:21:49PM +0100, Burakov, Anatoly wrote:
>> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
>>> Make the VLAN tag insertion logic configurable in the common code, as to
>>> where inner/outer tags get placed.
>>>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>> ---
>>
>> Hi Bruce,
>> I might be missing something obvious, but...
>>
>>> -		/* Descriptor based VLAN insertion */
>>> -		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
>>> +		/* Descriptor based VLAN/QinQ insertion */
>>> +		/* for single vlan offload, only insert in data desc with VLAN_IN_L2TAG1 is set
>>> +		 * for qinq offload, we always put inner tag in L2Tag1
>>> +		 */
>>> +		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag1_field == CI_VLAN_IN_L2TAG1) ||
>>> +				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
>>>    			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
>>>    			td_tag = tx_pkt->vlan_tci;
>>>    		}
>>
>> I can see that we insert VLAN tag on TX_VLAN and VLAN_IN_TAG1. But then...
>>
>>
>>> @@ -1004,8 +1004,7 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
>>>    	/* TX context descriptor based double VLAN insert */
>>>    	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
>>>    		cd_l2tag2 = tx_pkt->vlan_tci_outer;
>>> -		cd_type_cmd_tso_mss |=
>>> -				((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
>>> +		cd_type_cmd_tso_mss |= (I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
>>
>> this logic is only triggered for QinQ. Meaning, there's nowhere we insert
>> VLAN tag on TX_VLAN and VLAN_IN_TAG2?
>>
> For VLAN_IN_L2TAG2 the vlan tag goes in the context descriptor, and
> creating the context descriptor is the responsibility of each individual
> driver. The two drivers using this common path, i40e and ice both put the
> tag in the TAG1 slot, so don't have a path to add it to the TAG2 slot. We
> make it configurable in this patch so that in the next patches we can add
> in support for the iavf driver - which does support putting the VLAN tag in
> the Tag2 slot, in it's context descriptor function.
> 
> /Bruce

Perhaps we need to document that more explicitly then, and double-check 
that all driver paths actually do this in all required cases (i.e. not 
just for QinQ but also for regular VLAN insertion case).

-- 
Thanks,
Anatoly
