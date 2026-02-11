Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05719E81BD2
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 09:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3B22402B5;
	Wed, 11 Feb 2026 10:26:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id E54D74026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 10:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770801988; x=1802337988;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kxr4thxrhBLwhBbulVGkZDpyKOV2qu00yeUudeGeq8s=;
 b=ep5JH/dpSY9E6Ak4ZOt6lnHI8mh/QNwSRgP4JMzXa/wFKvO9WjdUqAGX
 Mz7wq6jURw2e5kwIvYa0J156BdM8UJMl8oK8rcV4mcbPEqUwxw73uAzEf
 tvCq0yUrkUvbR7BLt4bZsaJ5sieJZYs4n16U83E7OSjL4A/vnN45M7OFR
 Ngu6z0MXkXw2waIq+9bf/67OJDTie06jJvY2GgVok9S7QOzAEGw5P5w7P
 EGmZ+XwAkRJQtDbJVxHEBxGxJEtkMSxI9JtgYvNF5RQKCZkrUItUsCba4
 rWSZ1WakjuY6HbvWcMsM5uSWeKR8Qk5w0DRIUSR4XYNC1r+BZtVqG0wHu g==;
X-CSE-ConnectionGUID: xilZSAxGT26TNzsuRJX42w==
X-CSE-MsgGUID: YqGAKmhMQSGIWB2Un2LU2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="94584435"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="94584435"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:26:27 -0800
X-CSE-ConnectionGUID: wE/T58xNTEm1ON/WR45Jaw==
X-CSE-MsgGUID: w1k9rTZ3RJe//Oq3+JAjvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211240945"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 01:26:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:26:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 01:26:26 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 01:26:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdICvC0Hm8+v6UL2Zq2H05QvB4t6gKhJhIuCm/VR80ORTeUV26mUar8oTVnbf2Nwd/991FVpDnfQF7RMouZhDYaGiZLP08s+3hs4LaatBmfFRHsTD+7F/hXPsSzzEOnQn8W1PyQ/shF5IPjdfnsFrXGyFO5ZRhafAQwGdyPJYfhnZPpkyyLMNd6Ja/RFQqp6etuPWR6wd9iReqhxtWlqIVaUg6G7oRCDCC1VXGk77cHD0tEnzrBQRT9THv6VJcECSuCH9rf7IgM1BO2E5Dh8cwYcUuUGUdoOPYL0uxFaVbtiMnA3bICu1TXaAQGT3gv2TrJ+gn7ty9OQqDxq6uD/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0T4rtQYWnDoW5zH5bKQXL1aTtvXGfd9gmD0w3JoLhY=;
 b=ki/tUo0studVkQYGjRLGbNK3Try5hKo/NCOgFOMzpCgIsL/NX54MYVp8fb4cAPcnFfBIZXAaR6b4Hgd59dvL/PhMLiY3l1Q6uQstq2yDJkh6ZibuC0yQigUAV/tLEAibKrz82EQdV9SXkLkAoTVlutgGpDDlU7xmjqEOfyo/lucYbRcg+QaghWvdIdl76X4ZFbA9BlazIIovcuMV6RgMSPzA7g8KDGud7TyYm7hL1yhLmDJCuFG6Xs5TV4v6wGuSuFJyzm9V8QXnRkeANq04HEO3ZiUzc8CvPADim9UwaRMNB79yWK/YxoeVG3FGXXx6y7NvohLNBt6ZEu0nTe2gKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 09:26:19 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 09:26:19 +0000
Message-ID: <16d5acf5-038d-46ab-9abb-bd1ff52aaf16@intel.com>
Date: Wed, 11 Feb 2026 10:26:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/35] net/intel: create a common scalar Tx function
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-12-bruce.richardson@intel.com>
 <7dc889e3-f8b4-415f-a911-d3e14acd4cbb@intel.com>
 <aYtzDKUZC8fmKMTP@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aYtzDKUZC8fmKMTP@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0043.eurprd06.prod.outlook.com
 (2603:10a6:10:120::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: a7140363-eb92-46c4-34a0-08de694f9cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFhBY1QxSmJtRzA4emRIUDlDRE1FUlFVWlptNTZEMmtuSlZnMFpZSkN1ZDhz?=
 =?utf-8?B?bHBEdXJGOEF0M3hDRUxkZS9vY0JBWW15VzVERUVGd2NPRGlHV3Jva1B6RTU0?=
 =?utf-8?B?V3d4Q2NDWElMRWFuM0E1NVByZG0wc1VyR2luNGxNRXNTUWRKVStoL2hSZDVx?=
 =?utf-8?B?ZzJTZEw4V0NjYmNqV1Y4bDVUTktyMVdabGRsK1hxSDhocXN4am5GZHBBUjVs?=
 =?utf-8?B?dDExVGpPNWExTXdUWHNGREpva1VXcVd2dnMxZTZDdEgvSjhCbDJoWFRkMzBu?=
 =?utf-8?B?NkxDZVVLNEZoR1RiTEE3TWRqczR0YXZuZmpydUl0ZTJJUDZxTHBUTWRiNUtK?=
 =?utf-8?B?V1ljOSt0K0FTTkVKcEEzdXNxNG5SRGlrMDVDYitEaXhCZU0rUDdRQXdKaFVk?=
 =?utf-8?B?K25qMmVPNzZFeUQzWjlmSmR6VU1uWXZQYTMrRzZ0c0pQN2lTSElyM3dwcmFq?=
 =?utf-8?B?b3RFUjVLRE4wd01OUXRSeHV3RTJKR2RVRWNJSnhtWS8vaUcvejU2L1NDQjIv?=
 =?utf-8?B?cSsySlowT3JySVZ3NmxXenhiQ3FaV3duZncvRVlsVVNXVnE2UVk1ZXppaUk5?=
 =?utf-8?B?S0VNUDFqejIxTHFrdDY4bVlyQXQ0V2N2MWNvZHZ1YzhXM25YZW1pT1BRTFYz?=
 =?utf-8?B?Y05QZVhCQnlHclVjMGREZWVqUG9GT20yN0h6OFBPT01pNUtCQzRSN0hOK1p0?=
 =?utf-8?B?NVF2MkVlbGZ3RlFqcU1DVFRmOGlVNVFtdm84MVNjdU9SeGVWaU9xdGM5aU56?=
 =?utf-8?B?cjI4dDhCa3JYT2NhdE4yRWFDR2NiVWZXaW41bHJRRWY0czNpaVZZbk11Ykpt?=
 =?utf-8?B?Ukt6a0NGT2VJSWs2a3JlL01mQkR2UUYxaGtZYWgyQzlMTXczazFkR1h5SEk5?=
 =?utf-8?B?ZTBIcmhmQW5uUk5OQlJWcmJxeDZHd3dTMVdkMk5PSkFKZ2lHNldKL0hYQTkz?=
 =?utf-8?B?MmQ2YmJFQzBtWE4vWFpjUUdiRUFXeHdWSVlFNlhjVFdESk5WQUlGNzNSTzhu?=
 =?utf-8?B?M0o4Z3ZleHQ4V3p2VDVUVVVFSVRJYTRGMzJpYlNtT3MxMmszK3lTR1dQcG91?=
 =?utf-8?B?Z2F2QmVRdjcyMzFSY2dvTEVPVUJDT3VNb3BpYkZhaTMwSjIvUXo5clVPdTlL?=
 =?utf-8?B?d3JUckdtYWkrQUY3SmhXdHpIMGZMYUoyOWJBbGdXcFI5KzhSc015d2FOTTM0?=
 =?utf-8?B?REhZa1lpNGsyZzZhUWl4QVZSQ1ZGTVE2YWxIRmVpQXM5SnFMcGF3bm1LanRM?=
 =?utf-8?B?NUhsc0cvTERwNVJEVmFNMmN1MHBTTjd5UjFxOUM0NUVDOVNWaEYrUmI3U1No?=
 =?utf-8?B?ZXVkeEwrOHlCM1ZSSzFBUTFpNkEzWnlEejk0L215aW4vMDBpbTFZK3p1ZFJn?=
 =?utf-8?B?ZkRxYXNJSm9PMW84RG4zMithY1RTbmFWeGhDN2tTRm40cC9OSDhZY0RScHdO?=
 =?utf-8?B?MU14L2Zac2ZhTDh0cFdCSHc3WkV0SlBiRTU2S3JmVExGNkY0UVBNQlJoZkFO?=
 =?utf-8?B?RUloalpPcWo3ZTdaMzVTRFE0aHdadnJQZEVUWHBSR0xEUCtNT2lVZU5qSmNo?=
 =?utf-8?B?MjAyOXhzc3U1RDFYQTdEdmtTclpPVDFmbEQ2L2krNlNUVEtvNFFWVXNZMUEw?=
 =?utf-8?B?N2lLOURZMk94WU16RU1tbmlVSUhQbVhXTVhrRG1CVHQyUldHVEQyaFBPc2JE?=
 =?utf-8?B?Sm4yMi81dElnVVRyRW9WVkVBNk03aFZRRGVHa0hEdjd4WXFUWE5pQ0ozSDlP?=
 =?utf-8?B?RVJLN0JaK0s5aHh5QUdRbXlCdGhVSjFzU1VFL3Y3OE5TSXRmbHhFQ0crN1Vt?=
 =?utf-8?B?ejdXcS9mb1R2S0FjcElnZzQzVHlGZFAyRUVRUm8wdkJXZm5FWGQ1dS90amNJ?=
 =?utf-8?B?N2RLU3BER0wzOFNaaytBV2VTOHdvRWZVSnVuK0pkUVEwcURtV2NZT3RMYmVo?=
 =?utf-8?B?S3FBcHYwdDFOWDh2Zncwb284Sm5ZT3EwcFhON3NzN0ZNWjJpb29nTTYvbzNT?=
 =?utf-8?B?dDYvOTlUWVdmUGNWVlJKZ3pnTFp1MUp3Wmx1L0hnMkYreS92OWdITUFKYjRN?=
 =?utf-8?B?aFIxZTA1OXpWRUZQMlhXUk5xYUJEclorNWtNcXFtVjdLR0pwR1VmWTJIeWND?=
 =?utf-8?Q?fOC0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djkxYzl3S0gvWTUyTUxydnBQWGFxVjF0dUkwMTg3bEVpSnpOQkJ1S3JTUmJE?=
 =?utf-8?B?NERnVWVOMUlMVVpkUmRGbmJhOGRZU3U0VmhFckRYb0RHenpBRDB3TUVNUGY5?=
 =?utf-8?B?UC94WUxWOXhwQ0xJT1QzcTVBY3hZOGtRdXRrazVEZVRrNXBPdzRrN09BTEc3?=
 =?utf-8?B?M3ZROEsyN1BuaEZGZzZkVmVpNUJrVTZFU2k3VVBmT0xmZEZmRFlEbTNZWHJZ?=
 =?utf-8?B?aHZRc29CZ0V4UGtPVE1oOGlUVytqUmZxK2JuNzZxdmRHTGJ4SzRYb1Z3MWJo?=
 =?utf-8?B?QWRydTF1YU5xQ25iVFYzQzBpdVFzdHdZMnZPc2xkWmp3U0psckVmWlZpSkVQ?=
 =?utf-8?B?VDhtSWMyM0d0OWdMbE9BU0VhVG9nQUxtSndVUHppWDNrN2hHL2FCaTBsa3Zk?=
 =?utf-8?B?NVQzQVFCenB2aE1HcnhJc25nV0sxcWpERHF5cHRBKzZRVlQ4ZFhhQlVwaVRx?=
 =?utf-8?B?alJzZHFLNGRpR3pKUHlKalZCSThGeWI0OHJDQ2VUQS80SlFEemd0ZGFWRDVR?=
 =?utf-8?B?R1Nlcm5NVUFKUlRBWldRRVJSekF1ZG44QTJSbEVaTE5RWm5iWUNyZnJUTi9D?=
 =?utf-8?B?MjUxSHAyVkNOU084bWNsdEF0SkZ5ZmlxMkplbFFYc3BqUFFpRjVpeGFUL2Mz?=
 =?utf-8?B?VTF4ai9tZno1Lzd2aHVCSmJOc3A2dldXRTNsa2pDM2ZYbnAvdHNsWWZJQXAv?=
 =?utf-8?B?NGxXUGIxczVGOGJDVE1pYVhOYXJpUjdMdVBiN2VSbjdOQkIvSkxaMDZJZmJv?=
 =?utf-8?B?ZnpvSy8welB5TjhKNFIvY0hVOHZBZ2tlMFo3b2xnK09Ka1psUVZzU0NVY1dk?=
 =?utf-8?B?bWtiVHE3a0pwNktwK3JRZjNsMm51UmRLdlErZXRzcDcrVmdSRmFRRzhFYW5m?=
 =?utf-8?B?bnBlOEtHSXBRaHZrUkYrcUZzc05KNVBzZFd2NVJBdzMxVktCeEdNS3VGRUQ4?=
 =?utf-8?B?c3h6OHhibi94RDM3ZEJ0SEpQc0VsNi9OME1nKzNPWnhjbHA5bE5STzBlVlI5?=
 =?utf-8?B?Zko4Y1hnMVo0dnI0MlVWbXNBYWNMc1p2QVplRWlSUmU3SmFrWmI2K2dwR29t?=
 =?utf-8?B?Y1dycFRSaU81WFF2UzZ0ZjA2TkZGNmo1WjlFMGtSdGpQZC9aRUpROWlMbWZM?=
 =?utf-8?B?RmZoOGQyRkFBNWJ2cTVVR3JnSFVyZ3NuTGJkVnZDTFVPdXRGY253MlRYeWlh?=
 =?utf-8?B?RXg4aVQ3QjBScTJSSjBtaUpMdEZLTjI1UGlRRFFvVnV5Tm9MQmpER3QzSXQr?=
 =?utf-8?B?YjdLVnEwMXB6ZW1aZDlTNEVwbmZlT0s4U081NWlVVWdpNUU0UDVVOHZ0dWcv?=
 =?utf-8?B?d1QxQnZselZOd290cWxGSHhuUnVIdFhyamxLQnp1K205cEVDb2tTNGVJY3Vj?=
 =?utf-8?B?TVBKWFE1ZVZWaVdNLzh5QVhoQ3hBV01WVmJpU3ZEekxuRFFpc052RDV4Tm1s?=
 =?utf-8?B?OVZKUFBSTmdwVGlERkF1R3Vack5kTVgrMldtdGFySFQrdHRmY0M0Mldoalln?=
 =?utf-8?B?NUkxY3BTZWNueXIyTUsyVUh3L3lOYU4vZzNhYklkb093YzlSSU15NGxHZVV6?=
 =?utf-8?B?UHhneFFwZDRxY0tSYU0wTThxSmJnb3oyUm1WcFB0U28wa1RRakJzQVFPKzcx?=
 =?utf-8?B?QWtKbjNkVXZiYWx1dlBNejAxRmNWWFJidG1Eek1ualV4Q1BkUVp1UTJsazZs?=
 =?utf-8?B?cFZCbStEWmxRQU1LbWlvc3Z5bTRVUWxpVFRSS3EwS0kvQzk0SVlab090VHYy?=
 =?utf-8?B?elN0NjNhdFNHOWJLRHpSandqbVVhU3F2ak1VMkcvMzAyZ3U2TzhSbmpNYXZs?=
 =?utf-8?B?WkRKVi9KKzJtNEVKZkhVOGRlZW1pTHRwSTRCSGlwZk1aV0pJT0JDK0RYU1pD?=
 =?utf-8?B?bHRLWGVGNFl0bjRmZHd2OFVac3phaUEreks4cGN1Y0FQNnR0OFhtRTlCb2l0?=
 =?utf-8?B?ekxKbjREbXJIVFRJM0ZvdndEcmpDM1A4eThsMFlSWmZ0bmRPQjNieHZIYk1x?=
 =?utf-8?B?c2t3M3ZWS210aERTaUdmNGtyTFBjdkJOSkJKYVU4eDRpNFFuei92UG9aRDhM?=
 =?utf-8?B?UEVYUzFCZWpNR2thL1QremgrMkk2ajlLRDdOTU1IVC8yNFlvTU9IVlNFV05N?=
 =?utf-8?B?bzUzMUh4a09CaUZKMUd3ZEE4UDg2dEIvOVpILzJQclArbFhvalBBRi9ESm9r?=
 =?utf-8?B?QzdzcVJUellpdkpHMDd6Y3FTYlBubHBqUUNzN0pLb1pWT01EUDErK2VrMlJU?=
 =?utf-8?B?ZTlYYXBzZ1ZwRmVOOHlpQ2JtZjJYTWRpRm1jcUg4KzhnY1lBenRVNWgrNG10?=
 =?utf-8?B?ajlLdGJyQXVSSmJqTmJPOGdsT0xNODk4WEsvNGorTktHNUgvNjRqZjI3SE81?=
 =?utf-8?Q?rcX10SaD1WyfGmjk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7140363-eb92-46c4-34a0-08de694f9cfb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:26:19.1401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKRbScM7DCGRgrR09LifkWZWnU6Wb7is57BWGxGleWFttZzuQhNTMCqJSZ81rpHxQU2BFVMo0JZhc7mTdtXqtevrJ5wcU6O4+SKn2DMh4lI=
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

On 2/10/2026 7:03 PM, Bruce Richardson wrote:
> On Tue, Feb 10, 2026 at 02:14:04PM +0100, Burakov, Anatoly wrote:
>> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
>>> Given the similarities between the transmit functions across various
>>> Intel drivers, make a start on consolidating them by moving the ice Tx
>>> function into common, for reuse by other drivers.
>>>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>> ---
>>
>>> +	if (ts_fns != NULL)
>>> +		ts_id = ts_fns->get_ts_tail(txq);
>>> +
>>> +	/* Check if the descriptor ring needs to be cleaned. */
>>> +	if (txq->nb_tx_free < txq->tx_free_thresh)
>>> +		(void)ci_tx_xmit_cleanup(txq);
>>
>> Why (void) ?
>>
> 
> Not sure, it seems superfluous, but I think it may help with some static
> analysis perhaps? I've seen some tools warn you if you generally check a
> return value from a function but fail to do so in one place. The other
> places where the xmit_cleanup function is called here the return value is
> checked each time, making this the outlier and so an explicit "void"
> doesn't hurt.
> 
> If you feel it should be removed, I can do so though....

If you need to ignore the value perhaps do RTE_SET_USED()? I mean it's 
usually used for variables, so perhaps (void) is fine, in which case you 
can disregard this.

-- 
Thanks,
Anatoly
