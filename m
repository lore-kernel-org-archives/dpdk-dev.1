Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C6C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:03:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D64542E24;
	Wed,  4 Jun 2025 17:03:07 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by mails.dpdk.org (Postfix) with ESMTP id 001D7402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:03:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+XJ0zBnNa46DRBfxKCZqZLrgVnW/ETrjEIyZF6Mn+rqzw8q2zerwYKQ5zTOu1cYcKOmDHt7ddlDX6MnaVL/j8+MZvxVYwSZWgGPNcWztcWTbFjIPFH7HOaD1uY7tK7snciAGnoLHu6bEK/8Rt4hNdFixJoBWxiGNM0zO9bz6dGb8Zzy3ixrOer7k83VnFUPk3WlaC/ACYILM1+0BbA6UNVa23R+t9nsvdubtFscGcW1RHUeHDGFa6aQKD9LwUXMhJbcgiE3Kh3vnEiVSo4blNMKquEbe5gLAlUJsVLpHBHDo0YRBDdeS6ixjoxCj4Hxmct+o+KZM+4nM8FrNRSCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOxXdZMeAVYw83vtcMOivbtqijtNWZvtPYq3ejvJ7lU=;
 b=fYtZf7MM2d0IoyB4JQDJw1yJV/QtjJFRPEiuf/osmJpwXZmrmF2dFpGQZO5RgNqHIQgSFgYtWNTFRjbKBr2f01aM4I35r5SKZk6Ewhp5AXLt0FczrAqX79ad7ItZKyJTZ9qXWTqwklsb7eeqt+PB5UhYeZ4Y2Bf00Y/xhQyRs9gpachM//hJRbhJkUgoE3qJllOSq7NoOGKmvaPRWlRymgRXpAyVW4D1aeAJA4AiQyXD4cGyqhLW68UbxGdsOm+1lFNtIKw4ZElks9bYfxf0Qx5kUFEOena5trBwTuJwu8XZn+ir5CUR9wge/IrMAS7H8fVB57hhj6qyUTGk/PTdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOxXdZMeAVYw83vtcMOivbtqijtNWZvtPYq3ejvJ7lU=;
 b=K7hmzGcHqkNSbM+vyN8nzeHgZFfgyL/BFcAc106Yjog/b0+kBkfvOpZF8IX89kPh4KlwJMcKx4wX9uC2Pa+0H3u3EqiK+DAer//dfuN6NShBmTxql3n0laNSo/9nlKn1RUrhak03OqqvvtbcKsIFx3PZRE4NwOk3YotB0Z5JIrEuPB+5/J9d6OLo34BS0CeKhAcHFShUkmryZozCx7qUIqpKwp6w/ZnAJo81g4QDxCahH4oXxH6MbCbBrubBqfeqC0mACOjT8u5rJ2fdut+Z+TSVQp1wG0gpYvxNsKeOgi1l0kJRYCvk5TE0lNOdOnnKVeZ0XkzY/O4m+SQLpBK3ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 15:03:00 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 15:03:00 +0000
Message-ID: <7eddd264-a546-43c9-bee2-bb3177911639@nvidia.com>
Date: Wed, 4 Jun 2025 18:02:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: use portable version of __builtin_ffsl
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <1746457492-10012-1-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <1746457492-10012-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c13264-8006-4215-90bc-08dda378e566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0lBTUtjM2RPeG1nYTlrcUNJWHo5dEdoaS91MEF4VVQwRFNmYjdXaWQ1OFZ6?=
 =?utf-8?B?a0lhUjFBbzlHS05TZ0QvL1hRdkc5ZXBER1Z3Ty93NWxJbldIaWIzZ1p4YlhC?=
 =?utf-8?B?MHRRRFZFOGF6Um0xTVdPQ1VTY2ZQYW16d0REVXlSTkczNmlycmwwZjR3VWVl?=
 =?utf-8?B?aFc4TUtYQm1waVJoZk95RnU4ZllLQVJlVnhRQVRmbXA3VzhZN1d6RkpjNzEr?=
 =?utf-8?B?ZkMxMVhzV0k4akgrT2ZpK2o4RmJtNDJ5YVlRZ1RyS3lYbWlYQlNqRmw0ZDdY?=
 =?utf-8?B?UE9pS1JhNHdab3VBYVpjN3dXUWxUa2NLLytoWUpaMVYrK0dTZEx1M2xVcitC?=
 =?utf-8?B?c1NjY3EydEVaTFhLQ284ZkJ0VEJTTTZRMncvK215RUNaM0tSQkhkSDNYeHF1?=
 =?utf-8?B?SWdvZUNoUXhiMkdBL2pObTMzcm44T1hPZ3B4L09CbkYyRkpVeXUwVWM1Ykxn?=
 =?utf-8?B?elE5ZFdBcGlsdm9SOEhpMG5iN2RFVEltek1ibmh4amppUDJwdU1EaGRTM04x?=
 =?utf-8?B?Z2VpMFBpUWFKSWFHYjNJdDBwTWdqeElSaHZBS3l3MGpLRXR4bmUrOGJEVmVY?=
 =?utf-8?B?SFluV1pUUHNnQ3g4THZTSXRteTV3Q3hSakY2K0h6VUlhWFROTEhlUi90TVFy?=
 =?utf-8?B?cWRudzRkeEJ6VXhLdTJjWWFsNnNSVG5CNzRHZVhtTWRaa1ovRHlHRlppMWd4?=
 =?utf-8?B?WW5CWDlJZzQ5OVFLbzFVV2ltMm50OVQ1MmNVaWpsaGlWZmU5Nnh6Ykl1Ni9B?=
 =?utf-8?B?Z3MwbUJCYTZpTTRKWnN4SEFvQndmSnBOdUlWaWlsN2M2TW5IdE5tYWVrZ3NR?=
 =?utf-8?B?SXRKL2ttTW1OZ3JEYWZZYTgxM0JSN2dQYTNDUGF2RE0wNEYvMTkrRDlybEky?=
 =?utf-8?B?M1V0RlFmTzlXblRpS1dBSXRWVytEclJkbnE2SDU2Q2FYeXdlMWs3N3ZVUnZk?=
 =?utf-8?B?RUFLQjhFdU42SmtuTnZML0c2ejY2a082endoUzROS2JnV3lkdlhkUmRIcEVC?=
 =?utf-8?B?UGVqNTBRamllK0UvMFl6SHJDYllDNkZNdS9IbVhVamgwR1NmTDdnelVLMEJB?=
 =?utf-8?B?d0tnaHF0YXF1YVB2UzVXUTlMSjQzbkJKZ0U5aHFDb3hUVmRxM0UreUlNZmg4?=
 =?utf-8?B?T0U1REZPZmFraU5oOXBUR1ROVm9CZ20rQXFqd3FvWmw1c2lMRUYrbmtrMU5w?=
 =?utf-8?B?N1dBNmdZc1gxUzFFSkN0ZVJMTlc4ZVJTcmYrOHJnVmtUcXJoZDhlaUFKbVpE?=
 =?utf-8?B?ckhzRytRV2JPeThXcHdsVys5V0dmQnFoRXl5emhrUDJUcUVlWitMZ2FQV0h1?=
 =?utf-8?B?NnNmeVFra3B1SHJzUXNjays5YU9ueWg0RGRyaEsyR3pBeUZwM3NhRXN2Nnph?=
 =?utf-8?B?K1hTSnRtYWp2SWNJYm80TlhMSXdTY3FtRkR4a3J1cHVtUHc4ZlEzN28rZXBi?=
 =?utf-8?B?UjZzbEo4am15Ynd0a3g0RC9lWC9HWGd4bkltb0gzZHUwc3FoSlc5OUJHazVj?=
 =?utf-8?B?QlpvQUxUK0R5UzNrSXZBdFI1MGI3QkZ5TCtqcEhwOXNuQXpCLzlKNHdGelc0?=
 =?utf-8?B?S2tHUElNbFkzdWFMNGl4RU5CSnJPVHptUVhXVnMzSi9uSkdteWl2MHdoYXlD?=
 =?utf-8?B?amtZcTQ4WXpBSWluTUR6VEE3QkJ3dmNYZUUrOHFqUy9kL2I5V3U4azZjUW9w?=
 =?utf-8?B?TXJkMkJzdkQrU3dkT0pIN0pxMmE1MFRzcFJnZjkreFdpK1FTVGR3T3lkZ0p6?=
 =?utf-8?B?MTZEc1IwbGZPNkJyakt0OHl3MXVzMWtJeUxEUGVJQlcwd1Zjc1BXdHJmTkhD?=
 =?utf-8?B?S1ZHOERrNncvS0F3R0hoR3BBN1VRN3daOU1ZKzVmRWRhR0NSNGFoVXB1aDU4?=
 =?utf-8?B?Rm4rMjVIcWNMWkE3NVlCT2oya3VHbVdrcktPMDNzQ0FNaWlPeDdKbzJWWEVw?=
 =?utf-8?Q?L0y+oSh0ClA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhUbzR6MXlIWnRQTFZ2WE9aVGpvWmpmeGFZQ0NWUkt6d2xMTzJ0K2Z0QUha?=
 =?utf-8?B?NWhQV29MbHVXbmdJOVlYWVRGV0NHOENOek1VdFAwSnNvZlNDTktiYVpmbjE2?=
 =?utf-8?B?cW5EVVJIT2l1OG1wM09oRWltdUluc292Zm9vbVRPOERDRGlwcUZ1VmNFZjdz?=
 =?utf-8?B?eWxaekdJR3F5Q3B1TVZEcVZFMzFCN0pkOVNvUUxHM0JxZ1UzVzJUbWVoaWJk?=
 =?utf-8?B?TUlIVmhSZzVLOEc0MFlXZEpueWw3OVFlaEZCTGZPYXF5Nll3dGhPSm8yM3Az?=
 =?utf-8?B?NHFSMFMvWEEvbDR2QXIyaVdZcU1LVGFDYTh4K3YvZkRXSU42SDlzT0VGcmV4?=
 =?utf-8?B?c29qQkYxbnU2cTNJUlFMY1pVaWk2OVBiTnI3NlhyYXd3ZXZRNHhoVnJDZjcy?=
 =?utf-8?B?REtIaFRaWndmcStKTmhvN3lzVVRvODZRNWZKZDVNQlRRWEFsSUEyMHVsUG40?=
 =?utf-8?B?Mi9rL3hIandnU1huR0ltd1dTamxNR3lzQld3MnlvRTU5T3hlTTZ5QUJQTEF1?=
 =?utf-8?B?Yno3SUg1VitIdHloQ1lqSml2c3d5S1BXLzdpTE9xRk5CVkR3cjdybkxVRHNn?=
 =?utf-8?B?TC9qSSt1SXFUZFNzNkV4aFNsVzI0YVRlSjBtNlRoVE53dm13ZTNzZjlFUFZK?=
 =?utf-8?B?ZTdwZkpBaGZ6TGpsTDJVYlF1Z2h3ME9lS28wbmJMVEhwL2hoMmVZSWVjNGtQ?=
 =?utf-8?B?bFk4TFFnSGNXdE8zVDFRYzRyenlIMlMwNUZVdWdjcC96OUtCdTlYajI3ZGFr?=
 =?utf-8?B?QVRQTXhxWUJNcGREeVRFT2NIVGJsQkxDekpTalQwVmJreHJkSTNmQlN2eVZO?=
 =?utf-8?B?VWFrWXhTR2krck8xLzZtVVVxQkxERDhFZm9iUlhaWEtWWDlYYnQramh5bVZT?=
 =?utf-8?B?UXN5Qkl6NnpoUjYvaXFZQ0lBcy9FTjd6WmI4L1E2ZzBQYmFkbE5JM1Jsem81?=
 =?utf-8?B?TmZ5TTdSMWVZWjZaSEpLTGJINm85bnJ4RUppUVM0NE5qQzY5MnZRNkphbmVN?=
 =?utf-8?B?eTcyYWozbnZQRTBvK2NzRFB6SlB4TUlPN0tGeUFncTRJYUNWcDFEMWxoTi82?=
 =?utf-8?B?KzByK2QrcnF1UklUby9ITVZoM0pBL3VuTzNVbGlrVjQ2V3JueXpFUTlGSU50?=
 =?utf-8?B?V3F5T3ZNb3MrUlRaT0ZIS0M2SmhCT1g4RkhvdkVyczAzeEo1Q1hwemVTbXdT?=
 =?utf-8?B?TjdNQVJJdUo4VUZ4WnBscUVGOS9LYjBPWDM3cXpDelVCQ0R1bm9nQ0F2ZzhF?=
 =?utf-8?B?dVlMOHZZa20vWlBJOXdkVDk5d2xoems1cTdKVjlNTkNudnhWZE04Qk95S1BF?=
 =?utf-8?B?aDhLcm82Y203LzBFc1IzbUMwS21Hek9Sd2NoS3d4aVM1WDR4NVFjN0tuSTR6?=
 =?utf-8?B?OEZpNTgyb1p1QTRJMTdJOFJPMGxhdjVnTVNYMEhZaWVoeXFqWlYybUowY1dN?=
 =?utf-8?B?S1F6UGxJbVdacTVxVnZ4NEZqZWt0ZDdEZFpPandJNUh0NWE3NTRIaWNOeS9K?=
 =?utf-8?B?clE3d00rSG85MTVaU3ZFTXM2UUVvNzNTYXZBa2JVSzlHM2V3WkphazZHYVB4?=
 =?utf-8?B?YmdyV1NxVTA1TlY0VFRWQ3Bvb2tOdThBZUJzQkt4U1lHUFgyTEVucGtjT0tI?=
 =?utf-8?B?K0VyNC9ZQlAyZ1VtdUNiT3BCa1NsTWVnZ25OK2x1RnJFbHZhK21OL21rVGVt?=
 =?utf-8?B?M3R4L0FyeFVzb25rejQ1a3ZocVU0aXQxaTNYSHpCOUNBMTZ1clNxWW12eGF4?=
 =?utf-8?B?RUlpZXc5eUxQRTJzQzI5NW9wR2krWDltNzl5eGNjTUY0TEp3aHBvVm1TTHdt?=
 =?utf-8?B?b2IyMnlIMGlGQ1pWK3FWYTIzVys1dVJCZ1o5Q3hWdEEvblErd25MNzg5akFi?=
 =?utf-8?B?REtZK2RxZlgyQ1JmcGhHdEl3NVMxbVQ4T1pkaEkrSGVueitYN2N1L1cyc1or?=
 =?utf-8?B?dDEyZnU5bmREYjhSMWhWUnJ2SmtnS01VT3dBUjJJK1d2dTNqUnoyZkppNWxY?=
 =?utf-8?B?V3ZyYUFUdXJJaWNpZmhzL2w5c1I2Qm1HUDIvbmhqRm5kc0RjaXhlMUpEYTAx?=
 =?utf-8?B?S09oVXVBeTZvOC9qKzR4NzdWNFd2d1U2R2kvZko5SjR2MGJsaW4rWW5zaENi?=
 =?utf-8?Q?VJGKEqdC0GE7RUtuA2OUy8g1i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c13264-8006-4215-90bc-08dda378e566
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:02:59.9966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgfpPj1hG5ZNBa/h6XnZaI2/4XMRZYfn2WKxZJ/fZejH5PdC8yL+Sr9BJodr/kZI2wUwdLVkL1hVjWJktucHSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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


On 05/05/2025 6:04 PM, Andre Muezerie wrote:
> Builtin __builtin_ffsl is not available with MSVC therefore a
> portable replacement should be used.
> 
> Function rte_ffs32 is already available in eal and should be used
> instead.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

