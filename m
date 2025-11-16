Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F5CCD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 15:34:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A398410E7;
	Sun, 16 Nov 2025 16:34:21 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by mails.dpdk.org (Postfix) with ESMTP id 9795E402E3;
 Sun, 16 Nov 2025 16:34:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIrNnyYOlExaJutf6nkgrMWL4j7hHWTOos4yETFuPz02MC1KYdvVb2pwx3VeQpbrJqbZ7hpDYfbcZ29CoUycx/fb4P7DHAwTvYTX8Dijd4FRo5fF5yH2stKLRuAlwwpRXFDPwm7j9uOS6GtBAIMEfzqOcD3pRqQ+BarU7XL79YlaPX//hGmhiCXWgLi1Q4CGPHcXJPldgYp8g4N345BvVqNbYLlykix0Lj9n9Lx7zdE/XDCy1O3ES8gA8thj8Wy+hnz+ldm1OHc7MnEfGTzZeFDkO9w4wYuIXruyfZGr+MAvKn4UCU8+PZP38FaukYJN4bG09Jt391qHfEPH4APPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCDom+/+ijot3I2XVpKs71fzGvSxaFIUnr0uiukw8nk=;
 b=ZY+9fIqh7SoIkksPyXMeSAuUFYLoxunMI/XiMkhyHrksVhtIcBt+yijxVmA1ZVznWTvW6hvkIZ+uosvII24I/jea2/OAN3ZXXTFCj5Z/Ot08NdmqQXNl9p5C6/6zd2zSBhYbohtqTzTLEa5NA+M/9g2Kx1bXqhOZE+HYVPuClNjenhhVRQczuNS/l4xy+heCIO/QHXu9EdxUZ4SNJDiPeSOulIYHa5UaATZBut9DfbzV6hBSrUEQF7y00F8TLxYBrbczjNvgCieBqjG+2rGtuqwcp07AOS2tklCY0eKf0FTV60r3zJsuR01jSKKHK2ejqmyLu/RXWWvhS+xx/+atvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCDom+/+ijot3I2XVpKs71fzGvSxaFIUnr0uiukw8nk=;
 b=mEIVtrtNgexPcKZ/Vh/vVG2i6aMt/QGScavfuN7+MRtENzcN4LFm5BskNkope3buLTJiMWRwfIS8U0pAihlGKPAUivH1C5ytz+9y6RAyJg9/F/inWkwgrTeQJzcKDXDrDCgnCGNhszFh6d/t2zmR9SE8Hk+tUCJ0gmSE3DkQANk+t7KQ2Uld3eNfX1dQq8ry2XuVNEpnFSUsPROBOhLUgzHMCRU5567SK2puhsddZHI8YCVn/DdhyxjQU1lp69PPN/PJ9Mr/rY2K/ZXBfbYmMmT0DEil7HPK1uJpkrG4qYk9ZetD4Ylg8T7qhqHyXVHUe3jSlkjRo+QA9AYXBNh52g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 16 Nov
 2025 15:34:16 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.013; Sun, 16 Nov 2025
 15:34:16 +0000
Message-ID: <8719bca4-d4be-4b5b-8083-6fb34b7de6d1@nvidia.com>
Date: Sun, 16 Nov 2025 17:34:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] net/mlx5: fix IPv6 DSCP offset in HWS sync API
To: Gavin Li <gavinl@nvidia.com>, dev@dpdk.org, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com
Cc: jiaweiw@nvidia.com, stable@dpdk.org, Bing Zhao <bingz@nvidia.com>
References: <20251112130139.194450-1-gavinl@nvidia.com>
 <20251112134236.195614-1-gavinl@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251112134236.195614-1-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: d992082d-674b-4099-e67f-08de252599d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mzl2Zk5IRGNSZ2xNRUVGTGZHNG5LYXZGcTdCWml4SEtHR0pERm5hVHpyeEl5?=
 =?utf-8?B?RUl1amFkS3BySi81bzhRaS92TDhtaElCdERoWktRcU84NWV0QlFxSUdGTm1J?=
 =?utf-8?B?aDN3TmUrS0krNC9URTMrVVMzMmR4VExrSitIRzJqUGRNbE1iRnFLVS9wRkxK?=
 =?utf-8?B?aG1YN0Y3UjRDSU1rMjI1djExM0tKZUlXdEx1azRBSUhYRGNmYmFlNWFnQkEz?=
 =?utf-8?B?UUdkK0VZTHJidDZ5b3BPbXVFYVRhK3B0NTNvY200TFdYbG9ERGErN0JBcDNo?=
 =?utf-8?B?UDB1U2xMdU9qZlBKVnpTTCtWRHhKL2VuZ1JqU3phK093TnYrNGt6c3BjSVps?=
 =?utf-8?B?WDd2T2tGRHJJSkY4RVVjNkdjRzFISUlpRGVwQWR6M2FmVVQ3TFVueVBmVkZI?=
 =?utf-8?B?aDVOOFE0d1hsTThKNDEyb2szQmw2TTRqbHpReXpKSHRYZVpBcUtzQUUyYVlW?=
 =?utf-8?B?eGw1eCtnZFdrWjFJR2hMM256SHBlSFZvQWkyamJjWHVMYy9yMG9GV3lzRS9E?=
 =?utf-8?B?ZUxhNTVtUzUvemJ4Rjc0Ky9tallIQWM1MXZnVTdEWncrRUFqOVFmYWVmTHFV?=
 =?utf-8?B?dHdUTHNQMDB3WW90RytPRmdmVmVGREVFVW5xYVhxSGtNSnM3bnVHM05GQ2hY?=
 =?utf-8?B?Z3ZpN1h6bXB1UVhMeUpnR0o1NmVnczYwWTN2TFhQVGY3eEtJMlA0Q3UzZ2I0?=
 =?utf-8?B?OUpJb091eDJWTGtCS2tVOHJKVHJwSVBMZXNMZ3JkbGpsUjVXSjhnSW9VdXhs?=
 =?utf-8?B?VzEzQW9WUFFvUEFtTXEvU0gvVVpFOHcvZkVjYVBRMzE1WVRaTURmU01OdjBa?=
 =?utf-8?B?amRxV01TOGF4MlpTQXVwSC9UVTh3eWFJeEtTUzB4dXI1dDVWdjJxMGVvWlpM?=
 =?utf-8?B?TGtXb2o2b3poOE5XSGdVajYzUTZ4UEgxc0pLY3NoYXZLYzBNd3NNWW9WM3pK?=
 =?utf-8?B?TGVnYmNuZk9lWFB0RXdxWE5qVVcvVGtnT0VFRm11dllTVCtsc0plUHNNblZC?=
 =?utf-8?B?Rll5cW1VWDhCeHorR1J3M3U2bFRJNmJZd0J2TloxTWpiajFpUlpxQW9tSjVH?=
 =?utf-8?B?alpDays5b2FUQnV5dWpQazN0bGtWdTZLY0xFMGtkbW5ZcGpXNTR5N0Zyc3F0?=
 =?utf-8?B?eThxanVKeTl5MUxpcHd3bDkvNnIzYmEvdk9aM3gvbEQyb2ZWTTRzVW9CZ3U3?=
 =?utf-8?B?UXRTa1BlV0VSYkJBdEp3N2NWc1VGZUF0bnRPYjdVTGx6eEFOMVpNZHBMaS9N?=
 =?utf-8?B?b3p4OUJUaVBBQkd0S25Kc2ZVa2NSLzFiUlh2NktLYjkweVhwVWlCMHZLZEo4?=
 =?utf-8?B?N2RzeTRMemFiNEViTzY4UzFzYnBMNTliVUx4Kzh0MjZHYWJ2ak1oZGYvMzRl?=
 =?utf-8?B?blUveXRyVHJJbU1SaXRzZlhRU2hwT05PamJlaEFSdXQvSUloYXJXME9JNS9Z?=
 =?utf-8?B?M0ZBQ2J0bTJ3MFdGUUtJUXVJRlFhYS9MRlVVUDdhclRFMjVJMEcvQ0lSV0N4?=
 =?utf-8?B?SDZoK0Z0K3dGREptZU5ZbWVzTjBLZEdHU254dzM4dHdTT3JZLzM1VWJoMUp3?=
 =?utf-8?B?a0pnbGJDTFJocnlJV0k1OW50SHVyUERoL0JmOFVhSXU4ZzNKTkNvNFdhOUlX?=
 =?utf-8?B?TXJCVTZKa2FBL2E5TUd5UTQrMzRQcGFjUlcvQnVxRURJMzlVMjN0ZjdxRWVF?=
 =?utf-8?B?MGY3a2tzOWlSckh5QkprQkFqOUlJRWs1alR6dTZIM3RIV214UFowbWs4NVE5?=
 =?utf-8?B?MnRjbDQxV09OMU5vSTE3bFEvejVoWGNONkRMOHpFR29JT0JwK2JTSVZMaHpT?=
 =?utf-8?B?V3RYeXhzS3l1b1FNSXZCNnZTZjhMZGg5aVhoSnQ2dVpPZjU5VEFqdW9xd2lH?=
 =?utf-8?B?ZGR3Y3djTHIzdGM4dFJxNkdySjc0OHF1TlRVdTMzYVJGUVRWSmxITS96QWNV?=
 =?utf-8?Q?JozfhfshLn9Xm4Mke7FBofbM5E2eSXPd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdMODZaK1k0MXp1UjRyY1ZKMUs2NGZsNEJWNXl5UlFDYVo1RGx5SDJ4QUIw?=
 =?utf-8?B?aHhEOXd2ZkluNjdZMVFlNHh4dkU3THNId05GT1k3WTlicklZQlFDdm01T29K?=
 =?utf-8?B?VlVGdlBEaVgzaUc2aGwyVlI3ZndxSjRPY3VMQ2FacUg0TmtBRjB5aHRDbnc1?=
 =?utf-8?B?clZ5ek5adXpSai9JTk5CdmFCV2tpZTk2b0hxWlBFVmdrdmtqNFRPLzVLWWpL?=
 =?utf-8?B?Z3RlZjBpZ0w4VjJFT2dZRkoxVTJocE9iV3BJQmptbVpUZDdkajZqR3YwMHJD?=
 =?utf-8?B?ZUpLWi9HWDhLQXI5anBMRktLVVBuUzNPVG5LVnB6bGtsYWkzQjNnZWJxMmFZ?=
 =?utf-8?B?Q0hRUmlQUzVaZlRPbm1oaUdKRVRUQjlwdGNjdEZMZHlZS1pPNHkxOThWMnN2?=
 =?utf-8?B?VktoMkh5dE43QVFsaE9LTldBdi9oRzZZZ1VzNU1jbmdlS1ZEWEVpNndhTFdM?=
 =?utf-8?B?S0FjdUNDci9FeHVjR2dpNWd6VGs5dytOTC84VHhVTFpnMW43MEJtZnd0bWJX?=
 =?utf-8?B?dm9sZFZzWEFjdUQ1TnBvRGl5bTVDUE1WZS9MS0NjdHQ2ZDhTN2ZIdGVJQjFH?=
 =?utf-8?B?SDVnM2hRRGd5NXV5UTZqc2ZzNkFWV2J3OXE3MFBUdldFcmNzenpLaXpiSzNE?=
 =?utf-8?B?UTIvVThiNGhEbUVFck9hR0dJek5YOEdSSnFLaDFMbHpUeVJIVGNtbzVJQ0wx?=
 =?utf-8?B?enlPQmplbVFwTk9BNTZxeTg0UGJzREdyNW9XNUR2Y3JLWFkrRGVMd0U5Sitk?=
 =?utf-8?B?Y0gvbkkvQnptU2VjOWRnckRFVnRBVUNFWnVIUVZQRkVOZkNJdU9payt0Rm1H?=
 =?utf-8?B?cFNIc0pycldjTHJWWlh0QUMyY1hvWnowMjBNSy9NVXZRR1dObGRvWVFBbFov?=
 =?utf-8?B?bjJ6eWNPQmVHYTZoMHdsYVZpYnJlMEFYZVJ2b3JLa3Nuak5HTTd6TjQ4RWRB?=
 =?utf-8?B?MzRXSno0bmkvTkQ1VUZVdTBZTk5JWkQ1QnJvS3NwTitaZzNLWlMxeDZPZzVX?=
 =?utf-8?B?TG01eTZDRXRjSDZEdFl2SjBuQkNBeXN6TG91OGFZQUtPVjdxV3VPeVJJQzMz?=
 =?utf-8?B?d3hERkhIbHhCQjc3RVFGTFR4OGYrS25UTElRQVdQVVdoeERxUVlYU3BHMDUy?=
 =?utf-8?B?aU5mdS9wRlJjZjZDREpFdEw5T0VyWjdPa1RFbUVqQmlPUlhhczB3N3g1Mmlx?=
 =?utf-8?B?Q2JyVVFQVnQxK3NBb0c4OG1GOGkvWVVQZXdUekJCM3hCaXRDRWdKbWczR2FR?=
 =?utf-8?B?bndZSnFPMTJXT1J1UUVWWXpnZlJ5SUp0RW03eUVNNjJkcDQ0dENnK00zbWFI?=
 =?utf-8?B?aHZma3pKWFdlblUxNnMrc3Rybm5OYXpnSEtQMTBCU2Zyb1JWSmNvc2dyajFt?=
 =?utf-8?B?bUliRFJIYXJTQldqYk52UDA0alVTQnh4K0JRWUw5SjAweTNpQ0oyNkVYYS9L?=
 =?utf-8?B?Z2NTK0J0cHhKbHZOdGtuWUtBVERuQ0huOHEvdVpyS1NoUVNqd2l2aTEvRGRw?=
 =?utf-8?B?SEx6VFJ2L0hqclBWZmk1U2Z5ZGh0bW5ueFlaSFFqcS9IaXNHNGd0OVlqRzdk?=
 =?utf-8?B?MzNpVVBybjNQbnNObWdlOUR3WlUvQnJqVjNhYmtsM0NVT1dGc0RtM3kxY1pa?=
 =?utf-8?B?NVBQd0hjUHliQmFSbEhHL3NpQ3N4NUF1dzRJQmFjUWliTm1pY1gzdkJzNkFC?=
 =?utf-8?B?QTlCdk5Fd1NhdzdvY2hCUVNtWUYrTVBZYUVybHRLQnpmbUpySmRLWmt0eXZL?=
 =?utf-8?B?TkNjbzF0bE1iK3F6MkFjLzdWNW02S3N1aTFvMHg0a08wSHlJMjJwYlZHaG5p?=
 =?utf-8?B?anQ5TC9DZ0ROUHVlSmxmSnpHYlJqTVRCWVNneFNzMklheW1Ha0FncWIwWEZl?=
 =?utf-8?B?YkM3MksxRERHQ2ZDZlVWL243U0NBOXFkMjdlY0t3aWpRQ2I1RTR1d2o3VVBT?=
 =?utf-8?B?MndZc3AwSzVXRDN2SHJyYlhWSnJmWmE5Y2xJVkNORDdZT05VUjdlMWNESDZn?=
 =?utf-8?B?bzdsTFJnR2FETmo3R3RMMnlvaTB6NDg2blJNNUt6bjVrUGdNOGdldVByazNx?=
 =?utf-8?B?RDNiNlUxQXdLL0dhZE0wcGFOcHFFWStxajkrRGlxTjJJQTVOSnczNU5ISFEz?=
 =?utf-8?Q?Wbbx9jMa+SEnRZxk6ISeApa6C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d992082d-674b-4099-e67f-08de252599d0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 15:34:16.0612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJUAmU34eBJLzA+I47Fx1+K1Ga9MF6L6XdrYIBLJcgOYRxt0yo41o1dzoVrh0lsRXVZxBVQVPL8OizYjO8outg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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

On 12/11/2025 3:42 PM, Gavin Li wrote:
> The processing of field IPv6 DSCP via the synchronous flow API is
> different between software and hardware steering engines(HWS). The bit
> shift handling for IPv6 DSCP was not handled in HWS, resulting in
> incorrect data in the field.
> 
> To resolve this, bit shift handling should be added to HWS.
> 
> Fixes: ec1e7a5ceb69 ("net/mlx5: update IPv6 traffic class modification")
> Cc: stable@dpdk.org
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

