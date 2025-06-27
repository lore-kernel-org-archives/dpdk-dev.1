Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634B3C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 18:57:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43D574026D;
	Fri, 27 Jun 2025 20:57:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A1C63400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 20:57:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751050626; x=1782586626;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=mIBnYlJxkx4UqAoqYubP6I41UdaRjzKvW7PoUMiOOVk=;
 b=bUw1KIvK3V6BCAMeQRbyY18JxGa204o8557d+rf2TOGZQMeE7+2LdIOF
 kRVgYZdwtdqld8Fe670GQ47sJLEsJO4SmULvmGipT42ARSyXVL14wLY+3
 c4YMIgAv1y+ojl0+dOwDraMFax6yQNKWglz6cGZT4T+kO8jtQ3ybPNGo+
 S4Ve0it2D9qcUNfzB/46Zu8kEqrgHdoM2GnzXpF+2iBmctXNiEj3J8Kjq
 OeO1MvNBpmMxtBGxPiOCQBgEOuBg73ChC8rmyZrJZrvkGAUvgv49zBXni
 WpstSlx/Ml/1trV2uprJDQca7goLUdPNGS+ENAzdPRfWKo0w7ZCmXUaWi w==;
X-CSE-ConnectionGUID: 4KEgmSRcRQGXZnWieT6+DQ==
X-CSE-MsgGUID: DZX+Lg3fTYmSq2Jkj7C12A==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="70942225"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; d="scan'208";a="70942225"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 11:57:04 -0700
X-CSE-ConnectionGUID: aW91P2zkRYKzvKBJxphBkQ==
X-CSE-MsgGUID: 6PUkYEy5SOiW+4MAPgMykA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; d="scan'208";a="158379518"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 11:57:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 11:57:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 11:57:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 11:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddmCbg3LST9p3Rih2eP5A8qSpVSAbSdVRx0+E8xDBfkxxdYuKf84o1JC5TmIOC/yaPh0mdK62Xy5ojdpGrXXsxvmj0VXDlCi0tE9MYHWyOGsTFuT370cOfR17/zax77L/Rb6tVJhLFUpKXY1vh0QUno4atqnuNntrlaDy3xWxX7h2dHqI9tKqsOxIhwL1tu38gFZ7qpQ3EdyWmbeN/Qf2XEicIDoPPPS+VtqTqC1yUK3gxYibLKhp8AroADB91KrWw+H81ZjyCu/UEfwcapePPtVxYrdHYEROHEb/3oKZVqxLqIWgM8YeYFv+x+zgdqj+tEOA/kjGoQu1lGLxH9QCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv3iZm3+lXih+PNu6FclqaiqbJZRBxenhriR3vX/vyU=;
 b=wiN3lVX+jBBcmk1W2m97y+Bhh5HCW9yNDRGSe4ZyevoR9wEb0JZaHQEizJ/ilo1k1uCVvUjJ75hcwS2ryFMCXdwPgRMPVEBzlyR+r4jZNxmevgVwghtgdxZyldcZGFK2nQeL6c/n9sVSGFYRUvOP1Z1Dml+cLN5Za3EnVur9JSWoQiOSNbNBH4DteKT/RWx9LC/jc1nn1P9zrLAz0Xmp8voPGTsB8UGKzLoh4QShmlSAJgBmBdX+OU5ngZxSltDcRBrA0b8srjiREo2M4q9UqRyKESXwyZ+1MHbsvzTIfQDwN4PPOWQW4WMjdeIBK/1j0ktU5vyM7vEUyU5QzE2qtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6996.namprd11.prod.outlook.com (2603:10b6:806:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 18:57:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 18:57:01 +0000
Date: Fri, 27 Jun 2025 19:56:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <fengchengwen@huawei.com>
Subject: Re: [PATCH] test/argparse: fix out of bound memcpy
Message-ID: <aF7pef1HMfjT88-e@bricha3-mobl1.ger.corp.intel.com>
References: <20250627162305.340042-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627162305.340042-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 01732cbd-c44d-42b9-9bc8-08ddb5ac6691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alZ0SzNyT2tQK3g2ZFdJT3RmamllbGdsbzY2SjJ3TndUWndIeXRtbG1aRTlU?=
 =?utf-8?B?WlpRNU5oY045NndobXlwLy8vRnM2SjlPNzFoVjdtU2FteVVTVHZBVEUrWGdU?=
 =?utf-8?B?S3FTSEtzNzQvajBQZk5ObXlCQ0h2T00yanlTa0dXUUVmSVV4TG9qeGxvMDVQ?=
 =?utf-8?B?ZmZHWGRLcDFTdWRySGFaQVJEdEw1aEVRSFovVllGdHA2bHA1b1QrZFNnd1ps?=
 =?utf-8?B?ckRZOFZQRHNyUXhaQkJCK3VIalNSWHZhSHB0MFFyQzRlZ29qeDJGNkUrYjFk?=
 =?utf-8?B?TFN5SFRWT002cEd4SHdhaVdzRm5kK1pvMlBMWVJ4RWZSMHlacTJxYklLRjJv?=
 =?utf-8?B?VWtJSmx0MEJRaHFkU09nSmtHUVZEYmlHZTkyTU5sclhKUmsxMVVqdDlvZnd1?=
 =?utf-8?B?R05XaitDSnZUNzZNMlpVdGpVWXhYc0VpUFdPSXd2Q1ZMY2tVVTJUS3ZBTm1n?=
 =?utf-8?B?V05QeTYwL1YrYWgvWXNZbkkyNXd5dzJVbDRmQzdaMWxGY1BpMHZpWHVSRWtI?=
 =?utf-8?B?eVhoVWhIbkVHb0lzWW5Za1VsWTNNVW9nd0hmSHJOYTc0SnNNRFNrK2U3Z1F0?=
 =?utf-8?B?NnRsZFY2QU40OHZHNHJZRkdUMnhWY2VCay9sZ0RqYnVGTzB2dGdMQ09QV1h5?=
 =?utf-8?B?TTNQZnRpaGc5TFZ6ajNoOTBPS2Q5WXpXOVBud3Z3OW1sa2dEWVlPSm8yNlhY?=
 =?utf-8?B?WUNYTm9ZZnYwNS9vYTRvd3UwT2FieTlacjRqcmVuMzh6NjN2WGF5ZGNsaGk4?=
 =?utf-8?B?ZEFwNWoyQ1hoRG9wajhxckg5Z1dacmtmV1oyZ2JWd3JTU0xkcUJHK1JIVTBr?=
 =?utf-8?B?K1RTaUs1L0huTnFoVnUrVVhPQTc5MmtidkVVeEpjVjB3MGtuMlAzbjM0azdR?=
 =?utf-8?B?TTJnU2JxbUVJRWVMSExlZlVQeEdxL3o5YkVNUkcwS1JoQjVrNVF1MStXbGtW?=
 =?utf-8?B?TUlWZnh3RlBZS0UrMTFZRXd6eHpBM3pscFJzdW1oNWl3YzBMNTVxd00wakR6?=
 =?utf-8?B?bUZWMTVNd05YVHFaWW9WdWEwaDdOT2lCazFpM0NxRG5MU1ltLy9WSzI4b212?=
 =?utf-8?B?NXhITzRYTmZZTGU4Yno2VCs5YkNZM0QxNWJEZ3hBUHpmS0loNVhiQlJXZjdi?=
 =?utf-8?B?QWl6Ym9SUmJ2ZVF3c1I2YUdlRjNBM0ZNemVKaGhJaU00c015UnQ3Q1BkajNr?=
 =?utf-8?B?ak1UUFdMc3dRTmp5eWE4NzBOR3BPaGF2Rzh3RVZIZGlRWU02WG5zaWEyRExB?=
 =?utf-8?B?ZVNBQ0dFK2NEMnFOQmkxcTNjSnA4OUhlbTVZa1c0N3ZtdGtFbHUwSU1WUUl0?=
 =?utf-8?B?OEJZS1FVaG1TSkRRaEFvMFF3bVozWnVWVHJDdTN3L0FwTVZ3Z0FvbHBUM29G?=
 =?utf-8?B?dkFsei9TUCtoNHgzZEl2WHY4ZkJRd1ZlWnQvRTJkTDVYczFoVXRmL2Y4NWdJ?=
 =?utf-8?B?cG9YTlJERi8zMm5MRjUzeUQrcWhEeWFCbXpBbDg0eGdONys4TlgrYmtYMkxh?=
 =?utf-8?B?enlsSzBOSEJqdXR3M2tZWktGS2Q2amJkMGFwdU9BVjlPZm84dTdDM2k0ZVBN?=
 =?utf-8?B?VCsyczJHK0ZKeFpWSm1xT3BuUDBPclZUY3Fob0hqVHgxSnR0T1BUTzF5anJU?=
 =?utf-8?B?aWdKa3BHOEVLK0pMM1JScmRGa0traFVZMi8ydExnSzVVbDNrZGZNWUo4REEr?=
 =?utf-8?B?ZHpSQ3dGNGJzNWNiOVZHZXNxTzBrMXpjMTB2NkxyUVdDbjViT1FKZnpvTUVM?=
 =?utf-8?B?UXJrVmJvTkgyUTIzMDRKcCswK1V2UkFYVis0c2crUnczZTk0U09IL0ZXZThZ?=
 =?utf-8?B?UW9OVGEyWXRSbTFkTWRaRlNLMUFSd3FsU0JwZThZT2VJZEZTOFpvT0hpYzBu?=
 =?utf-8?B?TFZDT1RZWGlXcUtQaE5nL3Fsc1c1cGZ5eDQ1aXg5Tjg4Vmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3UrM0QyQkNhWXBSb2FJZ2dJK1lyMGpkaEordGxvU0JPRWpuODZ0UGdrbUdh?=
 =?utf-8?B?bkNWZDdlRzd2VThUczZ0R2h6SWxmZnFGMWVNOUtGVUp4VTZ2Y3BkV1ZSS1JZ?=
 =?utf-8?B?TXhvV2hGZmVoV2NrejZqaFVuUTBqN0w2bmJuK0JBOGRyOVVPbW9OMGlYVWhH?=
 =?utf-8?B?d2k3NjYvajJkYnJNRGRNeCtZOWxvOXE3V0FyMHU1UEo3cEk2Sm1ZZUZUVWlT?=
 =?utf-8?B?cU1JRWlMdjV6MjgwVEthaitDS29rUnJWTy9QUWNVOHJGSVZzR2ZpYWkrbkRD?=
 =?utf-8?B?Z2lOaElXUExNM0RVU3k0UnhNZklUSXZRV0huSkoyMGhlTzBtOVRocW9uTFhS?=
 =?utf-8?B?eiszUGszbU1tNy9mOGhwMHdZNTdHdjBJVDFReVh0a0wxdm9uMFN3RzNmWGdP?=
 =?utf-8?B?Q2xqSm1Hc3U5SU9Fb1lPZHJlU0hvbzQyS3QyV21YaTZXNFM3ZFBVZ3F3WFN4?=
 =?utf-8?B?Q2k4bU5PQ0lmUFZPRnhlSGlxVElnVThvN0Z6Rll0K2o4LysvZjdKaElBaGZE?=
 =?utf-8?B?ak5vNVE0T0dJRVAwUGxPRERRS0tOOTBEWU5IZ0RtRUI1YlQva0pRNmVTU0VN?=
 =?utf-8?B?SWkyUE82S2tYVHpCazdkR2ZZbVFsYW16MkptbEc3RnZybTJ6QStpSTJNR0I3?=
 =?utf-8?B?ZEljNU1LL2xUY0U0eHJtL0RHTFQrZTdQM3Z3aFFpNCtGNWtTMDF2T3VhTUZP?=
 =?utf-8?B?anFkV0tBbE00djk5TEFwMStidkZMckY1SUFoV05PZGZNMkZQOXRQWFk0OVgy?=
 =?utf-8?B?bkpNNXlSdVVoUUlIMUxsb1JsOHhNa3FlWmp0UWxWcnVtZUNJZSsyazRiMmo1?=
 =?utf-8?B?NDhtUDU2YXU1L3RXRks3N0c0Q1E0aXUvZERyNUU5UTg2bENZeWJ0RFFwOHpT?=
 =?utf-8?B?MHNjZUlIa3crcEdMMmxSOFN2N3ZING11YzVtaCswOTBDTWxQdnF5NFpGVGlv?=
 =?utf-8?B?YzN6c242NmRQdkM1OENIVFdhWERKcUJrcnZ1MVpDaTUwZjAxWk1oWnFwcVM1?=
 =?utf-8?B?N0hOVjBWMXpxSVlueXlPd1NkeHk2VndJa0F2STQxU3lWbWdVYW9lUzF2ay9P?=
 =?utf-8?B?OXZKcEx4Qy9KR0xDZGVERlU4WjNnR3BiZkw3eHVYdW4vZlNFb1Avb1NFZ0d3?=
 =?utf-8?B?MWc3aUFoelhXMFVUOWxmT01ocW5KZVljQnBmTnlRTHdLV3piMlFnUjVtMnB4?=
 =?utf-8?B?bjIwZEZ6REl1Z0lFdSttRHl0cmpjSUowVUZGZGt5amFhR3dkVWVHNlZVaVN5?=
 =?utf-8?B?MFAzd1FNekx3WXpLNHU5eWpQeVdSN2NjYlFKUGo5NkkzMjEyR3I5aFJTU21Q?=
 =?utf-8?B?RzZTUnUxVURzeGcwbjA3N1FQVUNra1ZrbGRrVGEzaFNxc0ZHMmlxVjNaYnZs?=
 =?utf-8?B?and4TitmTENLWVRheU5uTmZldUlGUmRIK09DV2NQZXUwU0xwc3RzSVkxdm5y?=
 =?utf-8?B?QjFhZldUM1IvQkY5Wk1hYzJXZStueFhOZjNvTDkxTkYzdktNM2p3NFRPOXdk?=
 =?utf-8?B?Y1ZQL3RZN1Z1RlY5V3QxSTZtOWRsZm1mZjJWYnNqUkxOSENNS0NxR2JXcGhL?=
 =?utf-8?B?eFI5K3RtVG9HejdETmozY0poMlpYL2ZkRVdFV3E4YTJrOTJrREFmbnN4THAr?=
 =?utf-8?B?aWlPRitrWHkyVHFZWTM2TDNmbGZxSjhURmJIbFJFUWdlT3d4OENQaWh5dm1G?=
 =?utf-8?B?ajMrMnlqVU0zdVk3cW1KcVZsTlRoNFlNdGdFMWFaajNJNTlKMnl1ak5wVEF5?=
 =?utf-8?B?S3pBZGdNenNSNkNkQ0dLdTdjRE1lNm1HWkthMTVCaHhzcHZEdlk4cXc5b0pZ?=
 =?utf-8?B?bUZieVJuRGZSZ1paUnlLMGtCdlBxMDdZeTNpVjhlWndVTmhqVlZ6K0FPc3d6?=
 =?utf-8?B?Z1YrbkpIb0VEalFRUE0zeDJDbkRJUkowY2J1WU9JUXdseE5MbzNvOUtTK1ZG?=
 =?utf-8?B?QytQYmJvVkE1aVF6S3RKVkZCNGluQUdFUFRmb0hHb0hvMFFObnZDei9DOUFB?=
 =?utf-8?B?azNBTTZFc0piVUtiU0F0WFNNNlZTak9oeE5hdmFkTC85bWRMeGd1eGlYSkZy?=
 =?utf-8?B?LzZMZ3hSOEJwekQzMUZaNnc5aU5NTjdzQjRtbDJXVlVPMEZiR092aDV1dXQ0?=
 =?utf-8?B?RHRzalora2FMdTlobnREbUJyZnBJeVpHQStnUTJaYkNjeFRRSGlOV2llRElJ?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01732cbd-c44d-42b9-9bc8-08ddb5ac6691
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 18:57:01.7326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54+3wp2Pp23S/7rVKxuLBctbBIYD10tL5yBfBu/dhWgw8fmPJLA5isQOrL9eN0yscMha2M/0sMYxCzUpG4vG+n/tLBeoHUjU4sRQdWM9Y4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6996
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

On Fri, Jun 27, 2025 at 09:22:35AM -0700, Stephen Hemminger wrote:
> The rte_argparse API use variable length arrays for the args.
> But the test was only putting space on stack for the argparse
> part, not the args. This can lead to out of bounds writes.
> 
> The bug only gets detected if DPDK is compiled with LTO.
> In function ‘test_argparse_copy’,
>     inlined from ‘test_argparse_init_obj’ at ../app/test/test_argparse.c:108:2,
>     inlined from ‘test_argparse_opt_callback_parse_int_of_no_val’ at ../app/test/test_argparse.c:490:8:
> ../app/test/test_argparse.c:96:17: warning: ‘memcpy’ writing 56 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
>    96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
> 
> Fixes: 6c5c6571601c ("argparse: verify argument config")
> Cc: fengchengwen@huawei.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

It looks to me like this is a false positive. If it's not, then the whole
method of declaring argparse arguments is broken, and the library is not
really usable.

See below for what I see in gdb for a regular (non-LTO) debug build. Looks
to me like the compiler is doing the right thing.

/Bruce

>  app/test/test_argparse.c | 56 ++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
> 
> diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
> index 0a229752fa..f4b33e2726 100644
> --- a/app/test/test_argparse.c
> +++ b/app/test/test_argparse.c
> @@ -70,43 +70,31 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
>  	return 0;
>  }
>  
> -/* valid templater, must contain at least two args. */
> -#define argparse_templater() { \
> -	.prog_name = "test_argparse", \
> -	.usage = "-a xx -b yy", \
> -	.descriptor = NULL, \
> -	.epilog = NULL, \
> -	.exit_on_error = false, \
> -	.callback = test_argparse_callback, \
> -	.args = { \
> -		{ "--abc", "-a", "abc argument", (void *)1, (void *)1, \
> -			RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE }, \
> -		{ "--xyz", "-x", "xyz argument", (void *)1, (void *)2, \
> -			RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE }, \
> -		ARGPARSE_ARG_END(), \
> -	}, \
> -}
> -
> -static void
> -test_argparse_copy(struct rte_argparse *dst, struct rte_argparse *src)
> -{
> -	uint32_t i;
> -	memcpy(dst, src, sizeof(*src));
> -	for (i = 0; /* NULL */; i++) {
> -		memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
> -		if (src->args[i].name_long == NULL)
> -			break;
> -	}
> -}
> -
>  static struct rte_argparse *
>  test_argparse_init_obj(void)
>  {
> -	static struct rte_argparse backup = argparse_templater();
> -	static struct rte_argparse obj = argparse_templater();
> -	/* Because obj may be overwritten, do a deep copy. */

Running gdb and querying the layout of items in this function I get:

Thread 1 "dpdk-test" hit Breakpoint 1, test_argparse_init_obj () at ../app/test/test_argparse.c:108
108		test_argparse_copy(&obj, &backup);
(gdb) print &backup
$1 = (struct rte_argparse *) 0x555556d2b8a0 <backup>
(gdb) print &obj
$2 = (struct rte_argparse *) 0x555556d2b740 <obj>
(gdb) print 0xb8a0-0xb740
$8 = 352
(gdb) print sizeof(backup)
$9 = 184
(gdb) print sizeof(backup->args[0])
$10 = 56
(gdb) print sizeof(backup->args[0])*3 + sizeof(backup)
$11 = 352
(gdb) 

So we have the space available and allocated for the full structure plus
the 3 args. This means that the memcpy is not going to overflow.

Now, the separate question arises as to whether there are better methods to
initialize things in this test. That's a different issue, and I suspect
that we don't need the memcpy at all, but for me the key thing is that the
syntax used in the templater macro is good for defining argparse arguments.


> -	test_argparse_copy(&obj, &backup);
> -	return &obj;
> +	static struct {
> +		struct rte_argparse cmd;
> +		struct rte_argparse_arg args[3];
> +	} obj;
> +
> +	obj.cmd = (struct rte_argparse) {
> +		.prog_name = "test_argparse",
> +		.usage = "-a xx -b yy",
> +		.exit_on_error = false,
> +		.callback = test_argparse_callback,
> +	};
> +	obj.args[0] = (struct rte_argparse_arg)
> +		{ "--abc", "-a", "abc argument", (void *)1, (void *)1,
> +			RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE
> +		};
> +	obj.args[1] = (struct rte_argparse_arg)
> +		{ "--xyz", "-x", "xyz argument", (void *)1, (void *)2,
> +			RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE
> +		};
> +	obj.args[2] = (struct rte_argparse_arg) ARGPARSE_ARG_END();
> +
> +	return &obj.cmd;
>  }
>  
>  static int
> -- 
> 2.47.2
> 
