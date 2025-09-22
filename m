Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8779CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 09:24:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DC8440670;
	Mon, 22 Sep 2025 11:24:23 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by mails.dpdk.org (Postfix) with ESMTP id BBDA64060B;
 Mon, 22 Sep 2025 11:24:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPhQGqq6QAbu0CkSRyMVPmFuOc/jR48mSbo/x6IlOUnhJHGIty316+ZVrACXFCE3kgZAPgmHb7iXCR8EvMymDcz2AIWFZiIAd2pplrEPVAjLCemLlzfHsD4aZQPjZZD8IunC4miwEy5bEpY9S0RtwQT0SjlfOBU8gVg7AwuUSHLS+mKT9oJS2oevN36Cub6b37j+GwEN/GGG4BTC9+wzLt/iX1qOq/5fJQK8CBkqhDmooNA0wivs0B7NcYrl8Y8+b6/JxpUQYMzbW0HowdWOR1L3bqs335Od96FayApiTtXNB7MYW30OIH5g/JJ/M4Vh1ggm7WujTB7MSQ2nc+q62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxRssuB1FuDm5nhMDgIQJlXg5bg6GcLtyZ727756KLI=;
 b=twwY58GZCjtXUjVcpQKMLGrenVcducSyxtVKz8lcGAk76kX1GvtUQKetLOZt9cqDkBdN70ZrhDhohPwfI1tiSIK3kyrq0Q5NgUEZ4+kiOmpWBoTcn0DW0SzJMalz4N0qHLuv3L10LYqoMF2giR9s4h+kmNAwRW8jc4quADnxe6rcr6lnGzcSO2aKWQkbjjmavfD1REtuOWk8DeGH6zPY1Z7kbW42/YZrd8GdMyeJJH07mKtAiJmUiXcG11gCUcLOB0y+CjnyQH14BM4szMGTSso1N+l+sV0DxxbY6AJbgtGY50WaS1BnL2aEpeLgyVVUnMEyd+VDncA04mYpMZGQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxRssuB1FuDm5nhMDgIQJlXg5bg6GcLtyZ727756KLI=;
 b=L+2KnKKhCKzP3YOw23FJccyziyQ4IdM+TMmy+9QF4FmNFKDm3XZOWuwOKdzwlTym2LijTt1YRDOWt+5tGEiI7y5vcoIPoNh//CS7fycHhn9uO4oFPn7L6HmplLM+7l6MxgmIdpHIJDqoWAgPaI4a9Y2kNWDU/mjRpvp46xeeljVasrhXLXGKBP2XlnA0Q/pblVZ6Qe1dDVC64aAZt++pbp/FLaNIjm7P2LUFpBN1aVqmPx0zwL0Y4GfWaa1bQxMWJfA/tKXYMYDOzYsdqy5nQdX+fmgBqfrXkS+DaGVI/KvDWGwBl8/JZo0T6TKZFAFcMyzB8sM28hB8JGa8wiktQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:24:19 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 09:24:19 +0000
Message-ID: <2d403ff4-0ff3-4dde-b655-16f14247222a@nvidia.com>
Date: Mon, 22 Sep 2025 12:24:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix MTU initialization in device spawn
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>
References: <20250918054325.777881-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250918054325.777881-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: a16afbe8-a360-40f7-846e-08ddf9b9cf06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFN6R3lTaWJ2YllOTjNNYWdwRUpuWU90d2VPVmZFNDJ2Q290aVlzZTh5clBP?=
 =?utf-8?B?MSswVlhHbkhuRXByRWV5SFkrZWJDR1gzS2wwcXdEU0czUG1xbmE4eTh0cGVE?=
 =?utf-8?B?YVFJSExhMjcxdmpBdVFralVxY2tSdWFubk9teU9VY3hFaGtzcHFLVWZ2dDkz?=
 =?utf-8?B?dnZpZEZaY3VIMzU2V2diejNJVEtYVHVwVDVjRGhxTThQSWRUMHhMS0srYits?=
 =?utf-8?B?YkpFRDMvZ2lFeGM2VWp3bDJWMHk0RGg0NkRHc1lTMWNWY0sxT0xXaEU0bjVZ?=
 =?utf-8?B?UWlNWUoyZ1Y1VVZYRnpGb095LzVXQjRTRlZ2cThKTjBHUWs2dEhJRTBFc1Zu?=
 =?utf-8?B?ZVIrWjZES3ZocHphb2Rwd1V3ajU3M3lsbmgwRmZJWDBsdjg5VWs4ckY4c2ll?=
 =?utf-8?B?WHk4MVdGKzd6RXNIQ25IWkpJYlU0c0c0QklVUW5Ob0lqMzZPUjA3bXp5SGFh?=
 =?utf-8?B?aWc3NE9NZVZYUzhoS3Q2eWhOK080S2dlYXZpZUk2U0FqM3h1aTJFbGxkRGlm?=
 =?utf-8?B?ZXlhMzU0U1Y0eCtaZXFoK0VPMlJ1cGdiQmNacExYNDNHZ29wUzBtbC9iMzl2?=
 =?utf-8?B?b3Q3NzhqVTdGemE3M3JicGV1bzJkVGEybjdCcDV1ZDBYdjdGY21ReVU1dWNJ?=
 =?utf-8?B?d1I0K01NTVR0UHg3Qk9wNWJWeEZxZDU2T3BtaldnbENjZ3FKVUw4d0E3Vk13?=
 =?utf-8?B?blU5TEVsWnNnVlhhSmcxREVwSXpzNFNFc2ZLYW9Sc1dzbzM2S21oVmV3blc4?=
 =?utf-8?B?YktDdTFWVWtEMi9SNTJDWkRYdjR5WGlzenNhU2lvak5qeTBtV2pQTFdXaFZD?=
 =?utf-8?B?UTIzaGRLeTF3TVBYdmV3aEtWSGxET1NMSEM4dDhaY0M3MGd2bTFjWmxlZEdy?=
 =?utf-8?B?Z3l1Z2JMVUR1VHo0MEYyQnJJbVhjVzRFYzRWdTNMN1BnbGRSNVVJdlR4enIv?=
 =?utf-8?B?aFdMKzFRNkx1ODUvbkgwZTg5QUs4ODVYb0t5ZFRYNkdSSTNoYkMxUUVncDRx?=
 =?utf-8?B?L2JYNUUzWktJdlkrZWI1TjlDWFllQ25EdXZjQ1Y5UTNTR0Rxa0gvVzRNemp3?=
 =?utf-8?B?U3o1Z0pxT1NXS0JMS1ZDbzZZWXZkSGRIa1lWK3NFcHBUbmkvVXBBeUsrNGRr?=
 =?utf-8?B?bWNjcmZnWU04MEFBRkszcHZadHNxYkxXSjlPOVltL0M1amU5c2EyNEd3aGN4?=
 =?utf-8?B?SVoxcXRlZmJVdGlick1SbkE2WElPNndxd1ZFL05DNGdIdUVaZFc3bW53anpL?=
 =?utf-8?B?WDVzbi95WlY3TkxLR0RtYlpaZjE4TDNwNXJZa2VSV0sxcS8rMWx1d09VV0xy?=
 =?utf-8?B?SkRWWkNoUU5Td2dERkkreDltNlF5Qzc3WEtsNkJvZ3BjUDRMSHNDNDVVZWhY?=
 =?utf-8?B?RjBYdER4cnMrY3VGallDdHdza01EYUVwZDlMc3FCdlhzbTAyNjJDdm9pYWxX?=
 =?utf-8?B?QWIvUnVnSUErcFhFTHdkck81YitjejZYbmZWemJIaGs3M0hOQnlXWStBU3dY?=
 =?utf-8?B?Yk1lcHgvZ1JBNUNiRVlaL2dYN2NBaFlBL2dRVWg4azVaOVUrcWNWRm4rTXZt?=
 =?utf-8?B?VVd5bGF1T2lQZFpxTk1VZlhwa2krQStpbE5XWVlrNHVkSkF3alN2QzNlaG1H?=
 =?utf-8?B?c1lhMEZ0NjluZE5FYkRZdldaTTJhbTRmdXdzRkRyMi9JNU83T1AwcWM1RDFU?=
 =?utf-8?B?M2dDL1lmRlhVM1F0VEYvNnhqbVdkZlpuUjRNVFRVSDFVVGh3Q1JTZ1F4WnZx?=
 =?utf-8?B?SGUwR2w1UWsreHNUV1BTcW9mOTRLOEY5UHZGVklDZVNwVHZaTTRibzhwMkk3?=
 =?utf-8?B?RE1mYkNpYlZXYXp2YnY3VnFyYmthY3c2RW5zTDY3SkRROGZuWGpRYWRObVYz?=
 =?utf-8?B?VlN3Z2czK0JpWVVMeE8vcFdKdlZrQ0EyRGVaSGpRM2hvcHhySTNaQ3dycGN2?=
 =?utf-8?Q?5NzdWoxD2cI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXlyMDVmd3M0Zk0wWE1QMjVCSTlON3g4OElKb093aE5OdS8ydjNTUGI2TDVD?=
 =?utf-8?B?NTJTdlJpYTVpSGJkejV3WVROVnBsRktYZDhNVkNaZ0pnVzR0cktFUVd0dW5I?=
 =?utf-8?B?QzlLaW9YQmQ4T2E5aU01d2t2TE50ajRNQzZVWnFEUHk1Nkc2TjE0ZlVtdHVN?=
 =?utf-8?B?d3NnRlJCVDMrZWozb1NBOW5OSUpFL3hFTnNaVEFqdU9rM3VhRldJcys2VlRG?=
 =?utf-8?B?Tk14bStJcGt3amZKbEVReW1zR2VHalJIMHBxTnZDUVZ4UUFpMHM5azhHc0Np?=
 =?utf-8?B?Wm9UVWtoMVBGQ215VnR4U012TTVCSU9RempqalZDeWdWeGtHL0s4RU9SdlNH?=
 =?utf-8?B?R002K3czdEZ1ZjNDTVZ4ZXA3UitVdzV2SUdQRGJxQWFGNUVBdm1aLytET0Jy?=
 =?utf-8?B?eFNvTUIxNG1zOFRiK2d6Q1NqRktEcDlMb2RZUlFFand1ZWtWOWY5TU5EZm9M?=
 =?utf-8?B?QWJQMkFkSnRDdzhJZFlIU2ZQY3ptcitzdnlvMkxYZHUwSkxpclV1TjhIcFdr?=
 =?utf-8?B?NFNRUUYwUm1Md1gvN0NPUXZvK0habWNDUmxXSkRHV2R4Q1NDUzVNcUovYzFV?=
 =?utf-8?B?di84WURhZDdiT3hWSFJmNVVQSnYybTUya2kwWFVMTWRaRWRkUUpTTzByRWhL?=
 =?utf-8?B?MGx6Sk0wWVFhMHpWUnZnNzVwS21qa1Q3SWNBZjhtOWQvVUtUa3JPNzRWU1Vz?=
 =?utf-8?B?M0VNOVdXVzZlbUZ4THdsYi8wVWUyNVE0RHRDbFJ4QkdTcmJ4VktRU1RaYU1s?=
 =?utf-8?B?L1ZqZUVzeWw1VklzUGJZM3NqdkdnYVE3VkIzZDVTK3hKMFQ4YmdOSVNhTDF1?=
 =?utf-8?B?VE52aGJFcm5PalVzNFg4ODcwVlNUWC8zT2ZXUEVBL1JFZmZjWHZRZ2h0NUZn?=
 =?utf-8?B?QmhDeDVZYUNIU0huaTdTK2pubDNmZVBkUEgyMGY0dnArT1plVVRvbGQ0bmFB?=
 =?utf-8?B?NzRPaUdZcFRmdW5RVzBFYWppS1FCVEJOYjRxVEVtVTJ4bGlmeGFsUytuRUZS?=
 =?utf-8?B?NDR2WWNiQ0RES0Fwa2lEeUt4NHVoaytkMXl1V0lFbXd0Y1hYQzVoS2dPbExt?=
 =?utf-8?B?aWd3WG0vZU1nOG91TjlTR1VkMmw0Z2tMS3VpdW1lN0VPZDM1UVpGMzhVV2Jj?=
 =?utf-8?B?eU1oRElKb3VFMmNLODVBa0Z0WXBRY2VEa0xTaDFocVQxVjFDZXRsaG4rMkV2?=
 =?utf-8?B?VWhaRDc4VmR4SHJLTFZlUXFZNjlQbDh1My96Z2kzS3kyM2tZRDJCaGpDNXJR?=
 =?utf-8?B?QWJQOCtqQUhnMTNkcUUwYjFQbmVNVnJiV2Urek1BTElnQk9aK3k4L0F1N3Z1?=
 =?utf-8?B?NDhtMjZmSG1kemU5b3BlYW9POGVKRlRIdTQ1Y0xhTjM0UVAyeVYxZXViQ2k1?=
 =?utf-8?B?NGpGeS8rOGoyYW1VOEpxNVBqQ0c2bjlXOUN1MVhxWEpRclU0V00xMXYwZkh3?=
 =?utf-8?B?NFZVT08wS0g3d0YzeDF6cU01RklGaVVNQm8zODRya2ZrUTBhUEVGNUlrNFRB?=
 =?utf-8?B?TC9tZ3lmRDNla1RDamhRN0dPNEkyK29URk1jdll2d2NFNGMrRStaMkJuSEhJ?=
 =?utf-8?B?Q0VSbTVMbkcvdC8rSTJXWGozRDhtcVRJU2t5MDRuNnFub2JocGwrSXhidXBh?=
 =?utf-8?B?M0k1S0RMV0JvQ012RUNLekdrOWduUUs3dlpNZWErRlg1VTV4cVJ0cG93a1hx?=
 =?utf-8?B?aHNScnRYZSs5ZnErSDZoaUhNY3NMTWw5b2ZreFBPcDhxRkpwQk5QVGJGaDF2?=
 =?utf-8?B?OERXNm1WU0Z5L3JZVlJrdDZXcFlJZDFhVHdBVTR2enlUSHpqNG5aR1NGamRh?=
 =?utf-8?B?TEdMSjNpa1B6SEk4WnhRTFJjaVErSFhjeW5qTW9GZEU3K3UvN0JBcDRneUVs?=
 =?utf-8?B?MGpvakhqekpDKzV4OHNnRWRkRWF6WGtxZmN2WmhtZW5TQXBpNHNvSmRkUy83?=
 =?utf-8?B?bzV3YnB2Qk0wQ0diOVluUDIweEpibjRaV3BKZlhMOXEySXZLYXdRendDdmZ3?=
 =?utf-8?B?Y1VIQThuWFdOWFprSGxQMWpQN0U5OUFYSkl1QUhvdXJQMGY0NVhncWlUOGdO?=
 =?utf-8?B?S20waE1iWitBMjlLWG1aaDJHTXJlcEFvdWRKRXFpbjRSSlIrd1RHNm9jS2tI?=
 =?utf-8?Q?2FyT7nCpy9O8W071HOAsGHOQk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16afbe8-a360-40f7-846e-08ddf9b9cf06
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:24:19.7157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8AE/emtLdFMGVRqmN+BdTxoUbMc/G9bHiQ6dhCHqW9DWDuzwmptxTVSbojg2nYXjUo9DkWQYu1lJITfPPr2+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558
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



On 18/09/2025 8:43 AM, Shani Peretz wrote:
> Currently with mlx5 PMD, rte_eth_dev_get_mtu() doesn't return
> the MTU the device was set with, but the default one.
> It happens because mlx5_dev_spawn() is not setting the eth_dev->data->mtu
> field after getting the actual MTU from the driver,
> so the default value is kept.
> This patch fixes the issue by retrieving setting the value of priv->mtu
> to eth_dev->data->mtu.
> 
> Bugzilla ID: 1768
> Fixes: 2eb4d0107acc ("net/mlx5: refactor PCI probing on Linux")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

