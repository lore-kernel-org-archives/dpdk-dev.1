Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA1DC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 06:22:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5BF44026C;
	Mon, 12 May 2025 08:22:32 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by mails.dpdk.org (Postfix) with ESMTP id 7EADB4026A
 for <dev@dpdk.org>; Mon, 12 May 2025 08:22:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8jl1wMU+PMa1LaKPf4mojQnXaP0i0K6zIKKvjINxwmPblngwSxFLC9ZM2GjQqGo3mJ74c3V8fs1aL8XFJEt7N+99qPL2D+oct4gshlssqI6HMOYY69nTTWWg4FMrKAw8oqeQTJj41j9kN8+CmPC5OgmeY/MZGONqKms4sNb7wZkr8RS0S9DtIBOxpFmA1jlenUQCTlQM5AWGIEESmstV/YDaq9/cPWN4BL+h6ibisZEYkVvxPg56OIIzUYnnW+ee6zaWCss9GYaONSNnwvruH+W08stO83LfA9zBNMIuuF9mzwREnf4iTHhwiluIWjOh5614G9oV4ZF+5VlpXvYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHoZLzt3yPWz33xPoVnSgsacAS2vRxrD9/EaO8Yx41Y=;
 b=wTsZZOFKu1P4lMZv6+ha0TA9/uQRpJ3GhfIUZBMl94t3q/Ng2jPIhbRwU6b9bnOfmvqUAxn9T3//VcYBT3QQ5vNq08CepwVZWTlTRVmm830LXkKjzmCNg/OQ+iSXHtqxNS6GSva1FCXdttJSRoddaG0Pi1pPrTt86M5by0LaIlQgKDVrW9ojM3upUXAGmx2u05QrKFVf5BX7vc+huP5JdXCGdn/FhMXYJhkmoXuOzKCXTQwwhEakQETdUd3GWfIEvTKLgZt8/SlHb2lIGX3RkqbWxVVlr6RiXSjvGvcxIqzz5CWcXX7CY3NADwNLWgc91EkdzOAvhnt7yr2TDVQ0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHoZLzt3yPWz33xPoVnSgsacAS2vRxrD9/EaO8Yx41Y=;
 b=CsdWdwzd2Zi4zqdrhyiedAiD0sZh4D6IHhqnHfAOuKqBoXWOCwiEGbHtMjJ48bOCBrAl1ICz27B25qGxR5nHd4oME4nYrM1VR2+tZYW0bQLs0XP9aH87cSht8La6szybshWBPMW+fHZM9DlwL+fId4WBaJOeww6D6huFbfD3EM/cQyhfvCgJlExL4Yh28SjpP/I63KmGvDxArues7XHuQG7BYL8PWQdR8Y6wd3tgLGKKvn8CQleB3KK22bZcYft3qZ19geOK3aoEwBv0KbqG5bAhe7U1LmW/Y4X+Y/5e143OJvOclJIaAMrWjKbQduePMWLkz/Z5ad/ppzOsSnKepw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 06:22:29 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:22:23 +0000
Message-ID: <aa968de8-efff-4094-ad70-8785a38a51fc@nvidia.com>
Date: Mon, 12 May 2025 09:22:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/mlx5: support multi-host lag probe
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
References: <20250311083154.1623908-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250311083154.1623908-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::6) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: f80eb5b7-5796-4e91-6621-08dd911d5b77
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0pPR0Y0a2xkMWxVZy9sa21vU1dBYlNURHBWc2VXOHk4YjhvZWhpdmRMemhz?=
 =?utf-8?B?UVNVTVNianM0dGV4cGZoMlUweG5rZWo5MkFIVVByOU9aZXpSNEx3ZEZUTEtZ?=
 =?utf-8?B?czZaZy80c2ZjNnE1UGdMUG8yaHpSdC9EWFowRnFwb3NOMlFGVDJXMVRoQ2Z0?=
 =?utf-8?B?dDhCR1BWODJsNG5BdW1Cc1VQVnZUN0dBWmJwbWZZZFAyeHNXZmNUUVFTL3dF?=
 =?utf-8?B?c3N1Y2JocXhaME9TTkJEZHEzWk1tMHJuUlBMdkFVK1BPcS91L3lMZVA5MFJi?=
 =?utf-8?B?VnJkKzNpUGxVd1MxT1pQbUsvSnk4dHJlcHcxTUxtKzhZR1FFWDFkSVJzd2x6?=
 =?utf-8?B?WVR6WmY0ZzV5SDF1VnF4RnFuNU1XaEFVbTM5RWNkaHVYMDUzWStqV2c3ZVE5?=
 =?utf-8?B?aVVNcHdSWDJqRHFmVnpqM0phQU55SGFKVzJrK2h3KzhMOVJvRStvMGlVdndz?=
 =?utf-8?B?YnhaeXhiU3VMOEt0dm0rQU5OU2M1cWROdVZ4a0d2Zk5IcVg3bVZLVTVFVWw2?=
 =?utf-8?B?Qm9FVzdhckVuT1dLUVM3TS8xNHRvVW03VlMvRHJwQXFYUlFjcitvSi9VdjBr?=
 =?utf-8?B?OGFsWng5VXlaYkdMc3ZGVUwwZytRLzBRbzRwckpHdytqbzZkcDU3Uk5sTDJu?=
 =?utf-8?B?ZDNxRGZLNkkramNrM0JQSUJqTlVxRnFGRlhHU3hxbm5zWlh2MFI5TnlsMStL?=
 =?utf-8?B?dndhQm84U0JMMGFtMnYwUE9WWDNzQlFZSU53VDY3blc1UTdKaTI1dlZCWkh6?=
 =?utf-8?B?bjdDN2MrYm05Yy8wRloxbjc1UFJQbzFvQkRVTmRUQnk5OVRGQmdlTzAxK0FU?=
 =?utf-8?B?bmVBbFJRbE1FcUhPeFEzZ1EyRmFuV0NCbVFJVDd4UmdkNkhkVXRjQTRickdv?=
 =?utf-8?B?VEV1Wm9GVFhndU11L3hXcXFpWVpHVDJFemdtZm01eU93ZjNibkhWb1pQY251?=
 =?utf-8?B?Sy9UVVQyZmMxaklzS1FJakF2NTBWRGtPYnlYV0NocjJCVm9xRk1wbGVBdkh2?=
 =?utf-8?B?TmhrWjNKNmFaM0Z0Vkp1WVQyRnY2V0FObkR4TFp3cFptbk9kbHJyeFBlQ3py?=
 =?utf-8?B?N0hyOFZkVzBFZXY0ZUI4UGVHajNtVjB6YkxOZ3lBbGxzVEhUUlViY1hmMnlM?=
 =?utf-8?B?MFNRLzZnOW80WWNGNUFyQ2UzWHlnZE9NWm9BMlBUcnZBVjA2T0E5NWd4VWZJ?=
 =?utf-8?B?eGtqRFBPc2ZDMVBzdkxRK2tvRk1HcHlVcm82T2JGeHRpcFRxZUtPQVl6ZEg1?=
 =?utf-8?B?MXRQMkxuUnJ2S1VUSWd0dlN4dEJDdzFIYlM0VDF1RXk0NTJUUjdXMXloa2NJ?=
 =?utf-8?B?U3haWDdLODJhanBZdnNzR1NVZSsvT01IakhhVUx4QUhGSTZpZnliL29SZUlU?=
 =?utf-8?B?MzhXSWZQcDhFZTI2bHczSjh0RzFYT1hrMlJNa2FZYmltUlBsSlBVR0lCU2cz?=
 =?utf-8?B?alliMGNrQkxpd283ZGpEOFMwUzlNQ2k2V3h1VkRkQ0p1eHAzSGdpNmtRYnls?=
 =?utf-8?B?OTdhTHlvYlpHbjdoeUE3N3Jta1B4OVdTTm9kK0dBR0k1MUw3d3Jzd01QM3dv?=
 =?utf-8?B?eHIzMkU0bTJiYklRbEExRkxJblFUL3VkQ3poQkVaN1FCSWs2UnBmUjNwS2FN?=
 =?utf-8?B?aXo2cTVRemF6dGlZR0ViL1JuZnFOVXRtQm9pTlVncjZ4UzNVelpGMTRLc3FO?=
 =?utf-8?B?SkoyODk1Zjg4M0xva2lnaDU3OTFuY3pXd0FER3RpWDhsR3dTYVp3ZWUwRVBa?=
 =?utf-8?B?TDdmTHIrQ09GZlQ3K0ZWdTRFR0g5YUIvVzRrZFkyNlg3bkttZ08xcXFjekg2?=
 =?utf-8?B?UG1GSDJ6ajQxbzJJTjdGVHA3c3pUbERXRVNSN1pCUkFCVjgwUkl3bE50M0t2?=
 =?utf-8?B?YjFtQ2ZVWklOa3F0QVltakJxOTlhZFhLdUdRYnVvaWNDbWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JieFpVd3Z6a1ZHSkkxZkVmYnpMb0R6dU5USVlEaWVkY0NIV0pqYjZ3RnVq?=
 =?utf-8?B?NzBGRjROd0d1eTdHaFBZY1FOMExYdmhrZXdRd3l4WDVvWEw3M2J3UnZvMmdq?=
 =?utf-8?B?SXJNbXowVHlDL05ENWxoQnFZQ0s1QVF0ZnhsbHVUcmVIUEp2dVJwc3l2bEh5?=
 =?utf-8?B?VVVuREVaeTUxV1d2bkdSdkV6RG14RTJKb1QwWjdwTVErMm1KR2t1bW1jUFhE?=
 =?utf-8?B?bzhreGZhakJFWTNnSmZRY1lQNzFPZnNpUEZLNkNreld4NDZrbWpTL0RpNTdi?=
 =?utf-8?B?clpsclZCTVNYV3lnOHZQdmIvTGV3MG1McCtOM1hCL2I2MExsR1NxN1d1U1p5?=
 =?utf-8?B?RkVUTHM1VU02RU43a0ZGQnBmZ04xbzVEUnF4Nmlac3FTMDZ4aGo3SjhNV2My?=
 =?utf-8?B?MnFOemJFWTh4bzR0cmF6bDl6S0pwWlJycjBDNllDNzAxNFJ5ekYyMXdwWDJN?=
 =?utf-8?B?S2Z0dXcyejZqT2VRUjlKNEJ4NlIySnFHUWdta1hkK1c0NXpuZlZBZWE5c2to?=
 =?utf-8?B?Tkt5b1NYVU8xQmtIVmVMQzM0cERiZHhZakR5eUZsQ2lqMWVUV3VMT0NvOFVn?=
 =?utf-8?B?bHlaSzU2K3dTNmNDWGRYdkl6VzJieHFoSi9qbjMvS2hUZGF1SDBiQktWVW1o?=
 =?utf-8?B?TXhINVdSdnJlb2FzYlQyNlRrS2NKSkNEUi9TcFlSQjJjVkFWYUYxcTVGcTVp?=
 =?utf-8?B?QytFTnNaVEdFdjdsUDRrK1NZejRKbnRxS3VSTnJHMGN2YkdtTWpWZlFYL0dh?=
 =?utf-8?B?YmhQTG9UTngxdmxuYUpNT0o5MFp4ckZrR25BRzc2OGlkaE4xTmhkUmlYSW1a?=
 =?utf-8?B?SzRVVDJxQmFWYndMOWx4d2RkQjI1aDcwaHNzZ3dRL0VDd0wwTDJKczRMbDhw?=
 =?utf-8?B?TWE3VVZxQ0NMZGUrSVdVd1RzQUNTTlZwVVh0c05TOVlpQ3hxUkg2bzMzRUdI?=
 =?utf-8?B?Rjh0OHYvd0tFakYzKzE5TEhTMVFnKytrQzNxQWpHOXJ2b24zZzZxWi8wM0xn?=
 =?utf-8?B?bmR4U0V2ZXhDdGZqaW05WFp4cklkaFlGRytnRmhIeXB5YXYzVEZ2eCt2TzJo?=
 =?utf-8?B?a2pUeU1RZmYwSGkzRkVNemVRNndveEVHSzFnZDU1VTdUOWUyZkdJQ3k4d1Fo?=
 =?utf-8?B?Q1NXcFBWbVJWb0svQ21HMkZ3RFZmSWVqZ09CdlB3LzFTVDdCREJPTWlnZFJD?=
 =?utf-8?B?bVpmRkRFMHpzWUd4YS9kQzdDdFQrWktLYmhWSkF3WWFKN2ZKR3BGSVFWRHhh?=
 =?utf-8?B?NG5PMFM5a1VSMTIzMkRpTGVOcCtuWTdLaUhyaWR1V0djSjZ3L1dZdGNIUHRs?=
 =?utf-8?B?Q0F4dGdjR2JxaXoya1pVWnJ5aWh0Q0FOaDF0c1FCVzdPNXVFVUFZMkw1Z2Zh?=
 =?utf-8?B?OVZyWk9scGl4V2hUVlhuVEttbWJkSGMvRG1zS3EvRFhzNmljb21tZms5R2xZ?=
 =?utf-8?B?RzA2akVISC9wakppcU9zRUZNNlNlT3VXRkVmRUVvNzZ5VnRQbkg3eWxoWDBL?=
 =?utf-8?B?blMvdzFPSGR3Vm40TVg5azNZdXZxTUtmUHlCdGlEbmhHS0Q5b0ovbGljQXNN?=
 =?utf-8?B?SGd4dGlNSW03L05uQjJodDBqN3pqMjVkNWRBMEdDSHdTeWNTN3I5YjNJYUcw?=
 =?utf-8?B?clVUODZURjRieVU4QmI5cGZVTWNoZkhxeFVKNTc0ZWdKa25uYUo5QVF0L3F3?=
 =?utf-8?B?QlRiMVVKSTg2OUlINCtpSkdvL3FjYm5SbER4cEdLNWpnT2dVMElTOUowNzdv?=
 =?utf-8?B?ZTVpNWJoamU3Q0VwYUwrbmlKYU1MT1VTb01hYVM3VlVFdHlVWWV3RTJmUWQ0?=
 =?utf-8?B?UkpyaS8xR3dBdmIxT0JQelNRb3VNRzB0WHY1eWZiVjlwd25ITThFK1NINVEx?=
 =?utf-8?B?UzZZbzloOUlDSmJOOGlodHY0WWR6WEVKSTV0Y0xjRTlRWlAxaXhTWUlGRDVE?=
 =?utf-8?B?eDFYckFLWnczdFJuam5uNXZoMGVpYU44aWVGcW1iSnB4L0cvNEtnNWxNY0pO?=
 =?utf-8?B?c0RkOXVXTGxuY3JTcnpEemgvTmJoalRWWmhJK1V2VDN5V3k2OFhEUEtzMUxk?=
 =?utf-8?B?UnA5Uld1Mkpvb0N1SmdWMklkelk4bURlVmhVTnJEaXN2SE9IRGV6OGVhOUs4?=
 =?utf-8?Q?aN3rZ42FHHtDLjkIJZk1BpXXf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80eb5b7-5796-4e91-6621-08dd911d5b77
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:22:23.4164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1cxRUv6vAGLA8kXS7ruL+NwqTAwoucDp2apuQsvH01OZgml3bX84ykyK9CqRBMKcvQ3RxFvhhvLk0ar++apfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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

Hi,


On 11/03/2025 10:31 AM, Rongwei Liu wrote:
> Under multi-host environments, the NIC exports total 4 ports,
> and each host get 2 ports. The 2 ports' identifier is uncontinous
> now. It causes the lag port array access violation.
> 
> Increase the lag port array and allow the hole in middle.
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,


-- 
Kindest regards
Raslan Darawsheh

