Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B084C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 19:30:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43A5A402F2;
	Thu, 24 Apr 2025 21:30:40 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by mails.dpdk.org (Postfix) with ESMTP id 47376400D5;
 Thu, 24 Apr 2025 21:30:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1ch3CxlVZAdgXu/uuVKeyC0i3gXiLvqOm7DtqLxHb3e6PJNp1fzm3k029Erl016yD9YZCnoZtG+0CYrTJ+CZ5TW0xgGkPriYL39H+z6rRE0zUajywezIGZTgsPjA4/GEPVfMzRLOInvySfLMbRtrqqWABPNmlOSaXQi0rIlvXGmRJyf7XGgR00/e3K2pemjEBIfws6aXAtWPDQe/y/r5SmVYeIa+fv93P0LLzm8pLCyHqaiBdomX6SFyuLtHmHSKzcWYlikYaFWG9ElmuSYQbDqOrlQdCQU/UeD2iFGRO2TdI8PE8S0GdnUhIH5xj4zVzndNXlAs4e48pDzmzMIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFHa4ToT92r+nVIVNsZTaaQ+EpIdayc9l7xQLKmlUJE=;
 b=lA/Ul8i2VjoRl153b0kGCHas+6DlgaMlyB5v5sLMRpNsDVRc1vwLjcsX4s/ffeAGMGS2vPhbx8LQmDl40HdBi+MVlEuAD/6yIYafrTqStcbRkvUUUdlKwiFgdBrlTeyJLC/w/xwzV3ppKgNNKd25sUoT85o2mdcktzeZvVEDngDSNHfhrTrwOlTwnVVCvrVMJDlDJ7yvBHBBYZQv+yvSQ3MALEIxdUSDFUVcpkLsdUWGkHbp61RpMFHIGRDh8/6xtT569CR4Y8yOiNrm8kfPajXCoPAQWtYOW8mNzuPJUKp3iES4xwTH1LY5d6nt9kgyhMrt/tyrx5djE/iLY8t1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFHa4ToT92r+nVIVNsZTaaQ+EpIdayc9l7xQLKmlUJE=;
 b=DSLYTb5UVZEAazzvwOjRfBJC4q18l0IrzUbltf3lKHRBG0oZ1BAM6s8mVD66ay7DW36ditpOApMJ/fElPntHFAm4mpAeewPeLWcm2AnJXfLEIgohSd3zjqGeMlMWlVtB6m5ju0UMlfFrx8mUO+vfwyjhBW09xrKZT/4A1EdcDVVNnUGkWy0E2JVtKzIByryYbj8mefUmz4pHDEeh9apBxAQaAwMHXjjUmo+rmINYGpZq3kw2PUctCZlyFLs36GFFyB836wAOhsWA/OPebnJrZEEx+z6su8N+r0y7dtooSQNEmCd9jybbtdeyC/tw/Q+FyaRV14LJ1K0n4AKsFwjWBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 19:30:36 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 19:30:36 +0000
Message-ID: <cf8f3b95-d55d-4e1d-836c-910c06638a33@nvidia.com>
Date: Thu, 24 Apr 2025 22:30:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 23.11.4 patches review and test
To: Xueming Li <xuemingl@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 benjamin.walker@intel.com, qian.q.xu@intel.com, yuan.peng@intel.com,
 zhaoyan.chen@intel.com
References: <20250421141920.622156-1-xuemingl@nvidia.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20250421141920.622156-1-xuemingl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a2f59b-5f6c-4566-2b1b-08dd83667ca9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWVDNUVXeXN0WlRTb2UrUllWWUpTWURjM0xpWVpsTnFBaXArVE9CNzhtZ2Fk?=
 =?utf-8?B?VlYzMXI2b2tDa3BlV3gvbXFrQXhadU8xK01OZmJLUW5mOHJHejVSLzVkSEw2?=
 =?utf-8?B?aXhvVTU4QWhDdHJRNUhyd0R6cU5XMnhXWlU1MEdmYXhuSTFVQlVUWHVvaFdo?=
 =?utf-8?B?akRzSTN6NTJlK0hkeHNWN3FNQmNFQmtJZjdWb0laZkJPdml1V0MwSCs1cXd2?=
 =?utf-8?B?M3V0TkZ5Z05NWjBCb2N4SkNmN0VQMU1qU2VoZ3pzK0V3allmSFIxR0lZSSt0?=
 =?utf-8?B?Ylh5ODV1bXJaN1FiazlmaDRTSk5ucE5nL2RZRDArSkZmV1lqSnZrcnE0Sjhk?=
 =?utf-8?B?Rk1YVFoyT3pVLytoM293NGdpTXRVeDVFMEQxNEdSb1crZERpakpoWHFXbUpy?=
 =?utf-8?B?QnJHV1BYRTNrL0hlRGNPamx3UVRtdHR6M2EzM0I0b1NLc0NuYjNxN3hOTTdV?=
 =?utf-8?B?eUZNZVVGaWc4NHhkcnhTS3FDbFFIcGhndHRoMzhkSXBVL3JEQTRnRlIrVHlK?=
 =?utf-8?B?N3B1S1hGd0p1bE9nT3p4MTR4a1o1K2xySmhBTWFaUE9xSFJnT3Q0aGFSMWgw?=
 =?utf-8?B?UTZlMFkzRDBrZ1puUE1sbUVFMStPdGJIWVBLOGJRU1hYZURHbk1HVGtZWEdu?=
 =?utf-8?B?Z2d5TjhtS2I4TWNJb1ExaDlicXR5MVFqRHZUVWNlU0UzY3lPaTdPdFd5OGJR?=
 =?utf-8?B?SHNtNXBVVXhuREF4amQxMmtlQzJBMnIrWEhlTkQrSlUvYWZEVW1qK0VWWlhV?=
 =?utf-8?B?Z2JDd3ZwZ1ZYbGVEWVNvbWdBS2gydzF3VnNER3FsaElMbktaMlFCcUxwV0dt?=
 =?utf-8?B?K0REQmNCVWJGVzJJNThWS2FqRHNmNFlzWDU0cFZCa2I4TjcybUJkNnNRRWJK?=
 =?utf-8?B?RUtnbW1iMDN2cW15Rm5keVVWR2x5aWtxOUZIZzU5YkFBcTRuYWxWbEIxazVu?=
 =?utf-8?B?T2RwZkFUNUlvQXJPRVBZSGd2ZTdIU1pCVmNyS0dZN0Q0bzRrWlQ4bTF3M0Vj?=
 =?utf-8?B?ZHlrZGVOWVBFMzUvYUVUcnBjYUdGb2F3LzdveXNmS2llemJLQlovZkRJVDJL?=
 =?utf-8?B?ZFpMWDd4anVuMFFiUVkvTFQxQVprY3ZUYktkakN4Q0dENE5UVjlTY0J1Tk4y?=
 =?utf-8?B?THFLZUQrRGc4VlUwUFpGZFlGKzZ4VnhwWDZiS1RuM0JmL0VCU0QwSE5VSE9L?=
 =?utf-8?B?ZWhaRFZQUzdla1FsSk5uNU9IRHFaL1BLQ1d6SkVTcG11eUpnU3c4clcxOFNt?=
 =?utf-8?B?bHlPUUszc3FpRHhQYnZQRDJuWFYxR1NxamRnMzdFcjNGTFFoTStMb3FXK2Zm?=
 =?utf-8?B?dFdFcG40WGoxRE5UVGZvSXhvdHdQNm1tVDdzN3l1U3FLRW1lU1hxZzh3UERn?=
 =?utf-8?B?ekMrZ3JaZlVZdW5xQlVqaElHajZZRXFsb1FtQ3RKQUZjUjRTd0Q5Ty9BWUxp?=
 =?utf-8?B?VVU5UndOWWVkN3plbC9YbERZb1VjRHo2T0MzendDdU5mRGMxdy9xMkMvcGdF?=
 =?utf-8?B?QmwxZkRXWW1ldXhSa0UyUmFrcE5wZGRRRXY0SXFPTWM0UG5MU1h6TjdVRGt6?=
 =?utf-8?B?SkF5REFWdnluVUNGNFZwMU0wVzJKOTNyRk1TYTlSOVRWNlBmTnBNTFd5YmdI?=
 =?utf-8?B?dmVvWk5jUDdmSG80OThnWDRhVGxXcTFRVHd2bWdQU2lGTy9nNVZBNlR4N1p3?=
 =?utf-8?B?Z0RBODJBN0R6YkZLVzMzcHAzZWsxL0FKSGFvOGE0S3huNW5PTng0OExxMWdV?=
 =?utf-8?B?VE41R2hsdFNTemsrMGdUVU5Ed1d3YzRyblZyR0tUT1hhd1V3UkdDZU9zVkQw?=
 =?utf-8?B?R09jN29mMlJkc0hHTDA0enpESmFNUHR3aE42WXVneVZYb0c2czVkK1pWSmZP?=
 =?utf-8?B?ZHBJVHlydEhDZHd4Z0lyQ2N2UDVoQWRZNW8ySHZJRHdWclBwT0hSOVBaNHhR?=
 =?utf-8?Q?Bofr+9NHQjc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS9jUzhFWklLUkZSNkJlTWtyVktOREpERVQ3YmVqRWowL0R2THlSbU83dHF1?=
 =?utf-8?B?QTllQ1MvNXd1QzVYaDYyK1JDUkpZaUE5VTE5ZGJDTUpjbUJQSkYzcXRBeU44?=
 =?utf-8?B?STJwbG5NcGlsUVJlbHRZcWdXcVZQN1RDZDlCQ2VCU2gra3hzdDFvZ2Z1UjIx?=
 =?utf-8?B?L1BUdFVRN2hDRmN6cW9kbzl1a2xOZjBhSEJLcFRWait1MkYybFNwY1owYkdN?=
 =?utf-8?B?c2tJN0cxckVMbWQ4TGIyWU9OU0ZlQTBaTVJCY1lETnUrVkcrV1hWLzBKc2tW?=
 =?utf-8?B?Z09wNmp4MWk1Z1R0cTFoUTA2WlhRWGIwd212UE5KWVNRak9TWFRuYnRoMlpv?=
 =?utf-8?B?SExaRVdRQ0l1UDc2TTYwUkk2MGVFOW5Wb2cycFRySEJMa3IyMzYvUWJIZU5C?=
 =?utf-8?B?djJibjVUWjJDa1BLOC9LUDBUemk3T1RjK1RaVUlPQVdLS1hxVmVjVGRFMUl0?=
 =?utf-8?B?RnYxbm9DZlFNWG9JMWloYkJaLzNabkVGYlgvRUNmcy9iTGp5RG1MS0FRK0du?=
 =?utf-8?B?a2RoT2xseW4rZ3JwT25ScFZSaFhmR09LalRKcVF4bFZrQ0MvY1ZZWkg5WHNH?=
 =?utf-8?B?NUJ0N0J5SDk0VDF6eXBFNXZGK3VnY3RFWFhoNDVSVHZtOUlGcTJ3S1VKbUxm?=
 =?utf-8?B?cXYxUDZiaXQ4dkRXWTc3VmpPelZPamdYQy9vbXVMb3E2T1A5SlZTSXV6MjU2?=
 =?utf-8?B?eTcwOU9PUzhMUW5ibHBLdnBGZ1lnSWxnaDNmU3d1bkxBT2Q1MmwvOHFXdUFs?=
 =?utf-8?B?WFNzSklFMHQwcmdVa0dadzk4NlFBcFcxaDY1T09PcUlLRStXZmxVMDZaODh6?=
 =?utf-8?B?ems4di9OdEJPSkJieHVKNHVIN2QvRXN4d00zZURYV21zVGFQSUQvenVQbkZa?=
 =?utf-8?B?Y1VkMk9GWndSQ0ZaR05tdU03aTFrMklYVTUvamM5eXY0TVIwUXVValZuZTdT?=
 =?utf-8?B?NUd0eFJicWp6UHBDdGRDdGQvakw0eklwS25KclNkNXdmQzh3c0FTNTdVSjQz?=
 =?utf-8?B?QythYXBtN254b0ZYQ1lkd3dwdGtSYVVvb2dlYVNNQktWTkUrdVhheEdKcUNY?=
 =?utf-8?B?OGtocndUcVFKRlZyTVVsc0ZXbTJRdFRnc0lDR0FHRHlKOTJGdEV6Qi8rRzBj?=
 =?utf-8?B?eDR2QXVIRUpCM1hzTmd5RFhndDJjc2xKd3hxSENpallHR0hGY0FiWkhtRUo4?=
 =?utf-8?B?b2ljM3J6bHF1WnFDTlB6bHhEQ0xoTTR3WE9aUmk2TEpnRUhOUFRKc1JwZzI3?=
 =?utf-8?B?dFZ5SjFYdVlvN2dNN0tTMFlrWCtpWFVINTNNeWwwRFlyOFNVQmJsQ2ZGY2V3?=
 =?utf-8?B?NHRzN0FoSFh3cE1wQ3pKc1hHaEJmZDRaTEVyMWczWlZMS3dhc2JrOUJYM0kv?=
 =?utf-8?B?Z2p4cXh5cGE2Zm54UXRES0FySk9TTFNzdVBQWUhhRTJoVnBFRGUwbFd1VEJL?=
 =?utf-8?B?Vlg0RVNwaWg2U3JkY3IxOU1POStsQ2h6ZjF6VWRrdUNmNk9PZ0dINndoOHlP?=
 =?utf-8?B?K0M0UXQrd1Fqa1FvZk5wUlp1TGhFUmxUOWpFdUVlaU5GNWdVcFMrSlF1WERN?=
 =?utf-8?B?ZHhmaDJrQUlEdVhNS3J5VDdyb3NTNm1xMllOWTNXa0Zzc1EwVDh4dWlhQ2pv?=
 =?utf-8?B?Qkh5V1V0cXZTb2Vpd2VJRUdqSWtydXBCR3FsQjB4Y3BtMGtXa0xKdSs1T2lm?=
 =?utf-8?B?R01tSFVEUDdlTTNWLy95elNrN2p6Q3dCdzdOekJwSTJWUEJkTXhPSTdLRmVZ?=
 =?utf-8?B?eTJlOXBkeVRUcTBOSFFDNEVqcFJQcklrcWpHRmhDSkwrKzN4bDNVSHBFYU9w?=
 =?utf-8?B?VHUzWEZGamlEWC9YYk14NHljYXc2TUJmR0hMcTFhSVVwMTErTW1XUXhCT1R0?=
 =?utf-8?B?T0pUV015U1ltbjRjeWZ3TDgyeU04bzIzbWxaRHNhSFd0blFseUZKVmY3UnR2?=
 =?utf-8?B?MFBWMzBCNmJidDgzU3JvSldnbWVhc2YxT2RRdFdnbGo3QlZPMWJUTzh0K0d0?=
 =?utf-8?B?eDV0V29RTExZRXdXVGIycDRjcS80Z2k0NndDdUZYY1krenVqOWJsNk9NVHda?=
 =?utf-8?B?czR1ZlJJYnRXQlplOEN5TFJ5am0rMWNGTnZwN2xsZW5uS1ROR1BBb2xXSkc5?=
 =?utf-8?Q?AQk/Uq0qdmK/rb/ypAzdQ8yIH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a2f59b-5f6c-4566-2b1b-08dd83667ca9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 19:30:35.9481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSE5SqAVr+K5ZU8joCEh1CQ2LZj3aWzF1vN2yozq45APQyGfcTsz7tFRfLwpitw/hKf2ZfaLfy9150o1GhP9+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
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

On 4/21/25 5:19 PM, Xueming Li wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.4.
>
> The planned date for the final release is 25th April.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.4-rc4
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com>
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware on v23.11.4-rc4:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests 
(https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Functional tests ran on:
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 22.43.2566
- DPU: BlueField-2 / DOCA SW version: 2.10.0 / Firmware: 24.44.1036

We saw functional test failures caused by environment changes, but 
didn't find issues caused by changes in this release candidate.

Additionally, we ran build tests with multiple configurations on the 
following OS/driver combinations:
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
- Ubuntu 22.04 with rdma-core master (324c42e).
- Ubuntu 24.04 with rdma-core v50.0.
- Fedora 41 with rdma-core v51.0.
- Fedora 43 (Rawhide) with rdma-core v56.0.
- OpenSUSE Leap 15.6 with rdma-core v49.1.
- Windows Server 2022 with Clang 16.0.6.

All build tests passed except for gcc 15.0.1 on Fedora 43, which failed 
with:

lib/ethdev/rte_flow.h:886:36: error: initializer-string for array of 
'unsigned char' is too long [-Werror=unterminated-string-initialization]

Thanks,
Ali

