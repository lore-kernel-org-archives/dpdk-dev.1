Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A362CFC269
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 12:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 265A9402A6;
	Fri, 21 Nov 2025 13:08:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 287B14026F
 for <dev@dpdk.org>; Fri, 21 Nov 2025 13:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763726923; x=1795262923;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y/d2xaxSJi5qMHfJouVvhg3pIHBkn9bnwQvuJrmwhug=;
 b=IGbDqVKpX44qyAqlfYdAm/jQIpt2iVgsIFLfvsEEDJH6yLsStnfz6R3P
 RSqFw0DaEeC2h9uhBP6VmN/GSjG7iYijyM+rYVqOaD6hJK53aJPnxGOo7
 y3w1AgysuVDkg3xYdkwGqeS/Zd73gkU9Hje6pqXMXiYdolF/oQny+t3gE
 hd1fmQ9OEDbZmKxRLqs5y9CMiHuyXvyu0vfDXqX3aY81dKBYNIL4HiOa4
 AgHgDrlECnwadVRs9W+40Kmjo9anLxgZxcLGKFKKMGiAdQCt1+dnNoiZE
 Zy1y5VMLs1KrfLS6dAVdQnrEcJ/klMZp+iI7kOZXikGcjELzPKgmAcHXT Q==;
X-CSE-ConnectionGUID: 3GBcXRGuRViBGT+lilWVSg==
X-CSE-MsgGUID: B2RgE0p1SYyCZenJxqoFLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="53391739"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="53391739"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:08:42 -0800
X-CSE-ConnectionGUID: iDFas70RTCihlEGaJy6cGw==
X-CSE-MsgGUID: nMScl1+wSMiBKgC71QF5/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="222630015"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 04:08:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:08:41 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 04:08:41 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 04:08:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jStFxu7RfHat1sObPALQs7QppeGpKPC1MB63pnr8N1Gb4rxVdnWGNmLBQsgj9oMDLcMLpxv0KW0BDa6yjOOgg7z+tRRWjedbz9mzISP4rQ0Aa+Jdoe7bMA0AYlSbw5Hn5PR0cGO/VRveqgrdsZEJDCt5paaAf9HkaFSkt0ZVujJwM8i8eusVlyOz4AsiPz/oFwBAFMVGK5AI7mwILRKzV8X8B+SQ6QBYMDY5WSaIHYOi2BoB3prNsj2T2t7eF6rUxaBGQQBf4k82SQBPWMxA/453CE+mMqo6XvFFw4Ooke8ieopETaD9hYs92FQ49jNhNzvXgI4fLI8Fz6LW20KM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjO+R6qjtIJzqOBmbC1KK2KPGw7K9cwCc1otibY4G30=;
 b=Dk8NqPLewWxz7Jk9KmmceBOaMBxMEYNYR2Fw4wEgTxlwLDlJ2//O1T1qtpKMvLkNl/TDkayfuVRvAf5rg/ATnzowsLjWvbmZQ4754xaf4SKimfl6Ys2wAMCqXCdqd8JYT8a3ZtysK8TqdoGRjaz4gG04YDVIamg7BVkuYrHP/zIJeH15/JTJwozJZ0herALlLz3+uc7l+U15fnk28CEBsjWRjS58d7+lKZfFMNo6ei45iQ0niNAlwQ1G8wQDbkV9Vo/QwfOEcCesdH/8AJcyu/lW13fa1jnbZxp/AoTSm3EMVJp/iZzKe5epciyA49F6Y9Jas6HCtkkhBSnhRXzBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.14; Fri, 21 Nov 2025 12:08:39 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 12:08:39 +0000
Message-ID: <bb4258b6-9696-4293-b431-82958afe4e2f@intel.com>
Date: Fri, 21 Nov 2025 13:08:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] test: fix format overflow in cryptodev test
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ciara Power <ciara.power@intel.com>, 
 Declan Doherty <declan.doherty@intel.com>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
 <20251120165713.120238-8-stephen@networkplumber.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20251120165713.120238-8-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0212.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 927b458a-60b4-448a-220c-08de28f6b4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXBJK3lrSnpyajkycGQwNnlWTEI4Z05oN3BmTUxNVXNKa1lha1gxMFpwODNr?=
 =?utf-8?B?RVdsQ2xsWG9YSjV4M3J5MTRVUjZZU2srR3VQcWlHQkVEejBCT1VPRmNBVVBm?=
 =?utf-8?B?VW5iZ3lBSFFDak9DRnRMc0FPNXo3c2RQcTB6eVV2MGRqUFVSS3d6RFlGUkpr?=
 =?utf-8?B?ZEI0SzdlS3RRZ3h2YkcraFlGcFNPRWRjMXg0SEsrTDQzMjlFbFFKMW1VZUg1?=
 =?utf-8?B?NlhzMlBWaVF6OTUwTmZZMjY4alVtZFI4R2UyWW5saGQ4QisyTHBQU0plUjVh?=
 =?utf-8?B?WFp4Z3VpclB5akM1RjhIbTJjc0w0eEZvWTdNdWlCOWFGK0dtWm1CckpyTTJP?=
 =?utf-8?B?K3pXLzhJVWo0TWEyWEFaUkEyWDhmZXlWOEFPS3NtTnYyMkZKSFVOaEM3cEVp?=
 =?utf-8?B?QzQraXVqY0Z4Y1VXMzNmcGJqK2tjTVZJZzVUUWRaL3kxMFVWMjd6emlVZHRC?=
 =?utf-8?B?dHkvZlZjQTZvWkc1aWNtaUs4VHNobm9Gckh5WC8rMjMxckNjajRSaWhPYTQy?=
 =?utf-8?B?Qi9wS1R0d3VTNGZUQ3dtcGlnT1F5MU5TZGpzUGI4d1Z6Y0htMWpGdXZyMjEw?=
 =?utf-8?B?MmZqMWE4a3RkYU9aMUE0T0JCQXI2KzdVaU84OUE3NVVPVG8xWG93aFRRbERU?=
 =?utf-8?B?UnhJaHY4Yys0SWdUeEgydmF1WSt0NkNTOE95UnVTSHNFYUswdUQzYURkeTFr?=
 =?utf-8?B?M1puL1NDS0xFdUkrZ1A0Wjh1Q2VQcVdLeFRsaXNLSjRVRm9EYUwrQmhKcmly?=
 =?utf-8?B?NTk3NHpHb2tLTWwzWTdXSEFzRzUwWnY3bUF6SERJLy9wMVRxOGhIY1hLTUFM?=
 =?utf-8?B?Vkp3RUllVTBmSDlyR3lZd1JvZmd1Nkx0U3RyZ0JDOGQ1Wkg0VmxGZml5UVpF?=
 =?utf-8?B?Z1FLNklaTHpZcHJXWTAzUFBKZ2luVitRQlpxTE93RVRFUEs2K1BkMHpHcWt3?=
 =?utf-8?B?azRyY2xuOURwY3c4Qzc1cEY0bWlDa0tuSklzUUl1ZWlqRmN2alEwd1hCSGx4?=
 =?utf-8?B?WjNFd0RYelNuZ2ZFeElqRkdtSFNYWmc4UVRMU3h2WWZ5K0JZUlZacGk0MXJH?=
 =?utf-8?B?RmllWW9VczhSMjY3TmhtRTJiSnIvOURnQ0RqUU5VRjBIaFAwa2lqb1N0WGlS?=
 =?utf-8?B?NXYzY0V5a05LQk9CZHNqQ2hMVHBubXprSWZmcURhOEkvTllyby9SemVkaWli?=
 =?utf-8?B?enh2c0pQVW1ENDJYUHFucWdmY2VxRktPeU5leTM2SWdEd0FId1kzaXl1OW9a?=
 =?utf-8?B?ZmhDbm82bHRoQW9zS0JKTERwZkpKYzlDdlpoSkI3U3BZSjcrVUFtZXd4dDlN?=
 =?utf-8?B?c3ltdFBxUnVtNUlyejE5MHJNVmNCZElSangrQzBhWHBrOXp6NHI1YThwejhQ?=
 =?utf-8?B?YTlJQURwMm9aQzFKbERwcXZyZU5kOWRqelU3VEwzMkljVFRkeS9hUzV4TXVv?=
 =?utf-8?B?Y3ZhYm1sUzdmcnVKNUhXcW9RNWxkZmFLaDZNMy9kUU9NbmwreFdjQ3VtRDc4?=
 =?utf-8?B?akNiNTV5K2FmakpqK1QzcjYxeEErcEJoWXdFV3JyOFZwV1RtVG5USjZySjRM?=
 =?utf-8?B?SGFQaDFhay9NREVpKzZ1SmVTSExQWkZjd0xDRVY1c25sUlRPT1dXaS91bjNV?=
 =?utf-8?B?cG53ZmhhVzRDYS9qVnE3bHd3OG5MRFEzUnIvWld2NkVIelJTbEpkalZnNmVy?=
 =?utf-8?B?blJqOWc1dmtiNFhQSG1QeGxDMmtDRFc1NGZUeVVFVUxTNzRzQkVjaGpKckI2?=
 =?utf-8?B?YjZGVG5hZUltUlp3ZDVHSkNSaEYzNGVlcmZFSFlpL1lrbzJrN2M0U3JyWjdQ?=
 =?utf-8?B?MEhydnBOUkJXYVhNVklmelRuamlHa0xJQTZVK3h5RTM0NXRraHE3SEFMSTVs?=
 =?utf-8?B?NS9GbEZ0OEFXYlRyMlkxZU5PbFM4eU1ySVpKcXZydWtxb25VU3Y0WU9ERGZK?=
 =?utf-8?Q?jveXnBUz1pUwHdd/95SJiwfpRLFtpJJ3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGl5bXdOYTRWVGtDQ0daZEVHUnU4ajg5Wjh1OGVIVkJ3U3JEYmc3MDFhbkJD?=
 =?utf-8?B?b1VLQi85cjNxanNqNFg2MUVxS2JoZHVPNWUvSVIxUFFHMTZLMktUWXZYbnVD?=
 =?utf-8?B?WDhUc2UzMThoTEdOdDRETmlzek1KOG4rQU5BWGhhaWFlOS9ldHdoZVhoNWUr?=
 =?utf-8?B?OHJOUjUyQTFuaTNkckNjUXVVMHV5RzI3cGhPZ0NYQ2oxdWR1c0xwYWZabVd1?=
 =?utf-8?B?bW1tNGVyQWx4eXhFUVNyc3Q1MlY0LzNtaGpqVTNsZmw0bTVQdUozbUxlVkYw?=
 =?utf-8?B?SnhKSmdYcW5JSktkZ2xaMlo2UkFZTkJaL1d1K3JkRDExNTE3aTB2KzFJYVJt?=
 =?utf-8?B?N3AwdjdwS3AvbGt5VENWckdka1dhVmRkb3pWWE9sWVorRmFPKzg0bEdJajNR?=
 =?utf-8?B?V1AweC9leTZLdDF1R1piOWRubXloN0ZxaGh5RFlieTQ5aWs0UnA0NEkxTHRV?=
 =?utf-8?B?TTV1Yi9tR0pIWTJRN0tvSE1aR2lwUXNIcGtma0NhbzRUOEYvWE5hZW8vUEhH?=
 =?utf-8?B?RE5WN0RqTmtkOWxvdnBHUXVYeHlkNmFadW9VNTd6S0xrdDRDa1hrT3Z5Ym92?=
 =?utf-8?B?ZFNFbkFneGhaWUlFdmZNc0dSZmVKZnJjekx5enNDaWdWYWdxcVBnWVpvZENK?=
 =?utf-8?B?ZEIzWlUydyttNEdJN2ZadG5oU1llVUduMHZRSkNHbHpBVlg4Q2ZWeThNYWla?=
 =?utf-8?B?aW42NDNseE8yV1BQTFhxNGFSclcwRUtldmtuZUlrRllQUFVpV3dkVzgxVTNP?=
 =?utf-8?B?NUMraUxGVzdXOGlMR3p6ZDRaQUE3ME51YmYzUW9sTHVnd0FrZTd1bXRLRnE3?=
 =?utf-8?B?VitSZ1NwZzVLRXZkYXBEZWtURnQrUHphckh4bTZwSTJVaVlYOTZ4U2dZN0ZD?=
 =?utf-8?B?RmpMT0o5OVh3TmJLcWhjbVpmZy9kNlJNaVZnNWhCekFnQnBxTVlqY1Z0L2No?=
 =?utf-8?B?Y1NMMmk0TmZnMHVyMS9qY0o1ZnJHRFVNeFhRUHRVVWh0anlqZ2twVDZZeVZt?=
 =?utf-8?B?ZkZsV2JxclpOVmtqaCtVU0YvT0tVWmk0YmI1bkg0emQwRTM4anNnUmRsNkhS?=
 =?utf-8?B?S08rK2E5c1pnN1JSenZYVG1abGM1MWtyaVZ1NExVN2JmKzh6aU9hOHE5Yy9G?=
 =?utf-8?B?TCswT2I0eTIrSXZ5aG5rR0pZQlZOTGZBaEp2RkxTY0cyZ3p5Zi9ocEcrajg2?=
 =?utf-8?B?a25HOFlEakxPbFZ5azBSbU42elk3VVgrTVNpWXhycTFQSCt5RnR1Q2ZwNHhP?=
 =?utf-8?B?c1picW9CbzFpOE5XNXZqaCtINTdyRVY0cUtoSncyUjdLWW5QWXk1QXU5bkpr?=
 =?utf-8?B?bC9laGlKWWc3TnQ3R25od0RJdlVFdDBZaGFqNHlqc0grbXIzRnYxTGZ6Rko1?=
 =?utf-8?B?S3Nyc3BrcnFSRmhndGl6U201Y05kUDFOeGxhUW1KMUpEaHVIbTA0NGJ3MWJv?=
 =?utf-8?B?RFJFSWFzZU05dHhFcTNHNFFveVUyTktwVzd1NUpLY2NpVUFId3dOdE1ZUDRa?=
 =?utf-8?B?SFJYQnJJT0pJdTU1dzB6QXYzaXNCSjJxRU1GQWdPUjg1bFBDQUw3Qi9SbEpy?=
 =?utf-8?B?RFRSa0tqWEh5WHpzYXYwbjRDcEFwNE5VN0VEQ2VNZjh1YnlHSzBId1RPUzhZ?=
 =?utf-8?B?RU5MS3RDQVJESnpYV1ByN1ltQ05iVE5nUnJpakNPSEc2bHl0M09ZTE1qOW1I?=
 =?utf-8?B?cEp5MDZwUXpYMC9yVFNwU1NBbVpTU2ZuQmxkUzZDZ1BQZTdrem91VnRRSnZa?=
 =?utf-8?B?K21FT285eVcvdG1hbzFLeUR3eUdLOWZqQWtRdjdCLzY4RVU5RzFhYjRTdEFy?=
 =?utf-8?B?QU94NFJPTTZza1Znblh2Y0VNbU5sWFJlMWxWcjdVcDd1ZTd4enkybXdQL2Q5?=
 =?utf-8?B?U1BWY3JTc0hXT3EwU2YwT2xUWWdIL1BBZmIwd1pPekY1V3FmSXVYSTh3NjNy?=
 =?utf-8?B?bGgxb1ZqWkFwNHY0d3BTQm9ucXFzRzJNTk1EQ3JyK3JldllBM3h5M0RDdVhx?=
 =?utf-8?B?eksvZ29TYUE2NjA1OVdUcHY0bm5aRmIwQlhPbjRwUTMvY1JUaDRUTExreG1X?=
 =?utf-8?B?enBid1Nkb3F1ckowOFQ1eTFmbk42M05mTWdZeVFCVWo5ZEErRjVFbWxKWVZm?=
 =?utf-8?B?SGRJSlh5aDJTSTlVemt5WUxwM1VtSzdTNEpXZUV3QTc5YlBaUm1GUW9RZUhm?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 927b458a-60b4-448a-220c-08de28f6b4be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:08:39.5146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqZTZKe37nwI9/HQeyP7GosIXJwxRHmezZWZO5v6Y/IlHybjbZ89AyhuJf/TnUK/yZ07Ihzo7YHvBj8fOk+GYnItmIrZuK6zNpnpUOrGNhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
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

On 11/20/2025 5:55 PM, Stephen Hemminger wrote:
> The vdev args buffer could in theory get truncated if there were
> lots of sockets or lcores. Handle that by checking return value
> of snprintf.
> 
> Fixes: 8bfdd8a7f0f1 ("test/crypto: refactor to use sub test suites")
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
