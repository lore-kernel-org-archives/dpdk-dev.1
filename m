Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E79FCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 917DE4042E;
	Mon, 18 Aug 2025 08:31:47 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by mails.dpdk.org (Postfix) with ESMTP id 64E414003C;
 Mon, 18 Aug 2025 08:31:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsxsecvl4s/z8dzd1YhU4DXU7O56FdIs7EQqvTCa7h++0nGZ2v103CMPecN52FPGY6NosFalB1/Yz95i8MTnMo58qP8jDqdBu8iGE+dSojnKhCa/gZeyctJ7r8AXe1vJxKd2lsg16dVgXSoHO8vAuNbagaDXklnRFflgX5yhVhm/0dHGCACi+BR4kUKyhQGbdY7VU1OPpuszlZu0SV8qdMrb76eIPZv7ZsfZWNplF7RdfKea+4f7+yILkfdKJ8rrZWVJZ/MpaGbn713fmuH48nlFY9mrgAbskBdHuBQGBslsuDFLw6suSZ4SB66x/KU0rUCKBBe/K86jO09LyZgMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYvaWIg0H/CElS1Zds0/G8TkOkcvxqCbciHelRS55A0=;
 b=KMWGxCPl/8qC8MM/e0UsK7TZQgW84r5dsqs24x/iU0Osg2m2yxECtRhbwOJbctUTIBexaZxIdt2w85U/Ou2uB2QTJCOLqffNcIGoAMY8i7HpvEnSUkNObksmKiFgNtmen/MP7Y/Alq/I6ly4pJqrzfCwFJQOsJ5uXO46EF4sZtH2Y68DBOM3FWhB836WOXUQxwfPa6biYDEE58BcHh5qu+oRv0wwvFm7NsZ4WA/9I271kAa9Facmtdcejz/t+70dUWnHXwGoA5HY2ZE3yo9a7p+gSyCC+e1Daa5HwqK3+OhO1ObfFEzhuFwWzoqXy/WZ9y9aP7DQUSa8mv0HVFRitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYvaWIg0H/CElS1Zds0/G8TkOkcvxqCbciHelRS55A0=;
 b=qh6GG7P73zgU/ZIXLyXDITBAOGww1r8yt/kHP585ePhYstiF7n10XhMhzzUigxj1InaFvwEW3Ni70wJlTThahb0Z33OllDK5xYMGphVKr8O/7i1lNcLC3v8bkqFAYchEoEWVhGnfbZ/ofx3pOSurzxpB6C3AC1kEu/ZpS8VWsUjCP3KUWFyhrFbAbtKCo0jGd+xKaS/aCVqLYoSD7C6mm6RJ7XHd/RYzkq+lWlr6D16f4bEIJWSIo814k9D0dAsZWOw+oOUKQyn4n42MK4zyZWn9TJ8ZNsij3MfNYxrxvCIOb+lcDjarpZeAQBPlVArEimS8ho46KhKHx8HATf5PBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:31:44 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:31:44 +0000
Message-ID: <1bb9b76b-6f5d-4eec-8dba-d54096a5ca06@nvidia.com>
Date: Mon, 18 Aug 2025 09:31:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix failure on device start for default rules
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20250730113512.197555-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250730113512.197555-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb07fcb-e499-40c8-84c1-08ddde20e64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3dveHNzdWJMOXMvc2xnb3NWdWRsUWI4RldSdFVMdzlTWWVPVHhCelpoeW4x?=
 =?utf-8?B?dzU3bkwzWlk3MER3dFVuNFVIaHh6MjJ0eUJRVXJYTThHSnptdVNBaVR2bURT?=
 =?utf-8?B?c1dUUVk3bE43NW83eE5sRHpydEdrN1VBVmVHNGpIbVRoSUY1blp6WHBleWJy?=
 =?utf-8?B?ejIzUXBNTCtmTWYyb0tEWWtVVTNpMTlUY1ZVSGZwaEwwTzhnNTRwQ2xuSzU2?=
 =?utf-8?B?NzJoalhtenRwSDZjdkdJRlhGOUNIdzNrdkYxTmNoMlROa3lyekFSR1FPLzFV?=
 =?utf-8?B?VVRjcWhQYTAwMTQxU0ZKZVNBZTJRTlpuYTVSamNTcmpkR2ROQmpkejkybmZN?=
 =?utf-8?B?UVlCdlcvcXlwNkIyWnNsLytkdGJkNEE2cUhnamNWek1PR3pVdTFhZGo5Zmhk?=
 =?utf-8?B?VlB5bGNrWVFMNDRXeENWSWxndldlN2hEUFZWd3FYR1NZK2FUdU1nWFhzZUJ4?=
 =?utf-8?B?eW9Idldjemd5cTduOTROTmFwc3NkMkxhRC91MkpvUXpDQUhIZG1TQTZyZFF1?=
 =?utf-8?B?RWROeldudTBVWERMczVxT25jSXFSMU52MkFQNG9nc2phMGY4dkJYdmxrVmtX?=
 =?utf-8?B?ZjRGRk1lTmdOanZoKzJtcnlqb1lsMkFmYmludEg0Z1lWU3hPbzBnSlZGNENK?=
 =?utf-8?B?ODlWdC9lZWxwWEtGOERLVkx0VXE5QTBCU2JlRW1mTFcyaWJ0U2QyUkRCajMr?=
 =?utf-8?B?WWZJaXd3RHdNUXlrS2R4WU5jcHUvSWRsVllwaFdxSThWTk92QXdTemlOaThS?=
 =?utf-8?B?ZHpzNmxWVGVKeWVGK2dVNkNFendBMXJDQjVoZExIekQwM29xSFNZR3lvaWJu?=
 =?utf-8?B?U3htV293WElMSnlQOVZBUUZySFJaak5WaktvQVJ4ZStGd2xuaFU1cS9qeHQw?=
 =?utf-8?B?SHN4empEbnNlYUhlNlFNVHVxNGpHd0IrZmJ4Q2ZnYjNLcFJkM2Erb0plUkxR?=
 =?utf-8?B?ZE1rQnY2QmM2b1NlcU1RMDJWN3BBU01lM21EeERWbjhJL0JidGJEM2NJa0lC?=
 =?utf-8?B?NU0vdTRwRTl2Tmo3ZHRLZ2xpdnhPZzBYWlhMcmhQNmNtZjNOSVVaRTZvNUx6?=
 =?utf-8?B?aFgrN3JWL1JFSjZkN1VWbEh0Wll4NSsrN3FZaVk2UFBNdnR6UmJ1V0E5WS9v?=
 =?utf-8?B?bFhYQU05ODhkclZPallGN1dHZkNzVTZVOHVBOGJ2TUFpK21HaCs2c0NXYWhl?=
 =?utf-8?B?bTFjOEVaekdMNzhNenJvYTVTY0FZSFVPRjg3UHlyTWRCcVQ0K1VMYlJrNVpY?=
 =?utf-8?B?MWFHNytVMTJhRmVFWUZ2cGdBcFdRamQrR1dDSURyYkUwbUxacDRGTXk0YVVy?=
 =?utf-8?B?VndOTkorSnBkQjk1Q2ZjTkdNZmlkczk3WmNIK3U3RnQxaUpTTlhUMjVlc01k?=
 =?utf-8?B?MFJUbG5aN1I1NnBsRjhqU3k0MDBtSmZOa2pvOW4venVTTFB1b0Q3Z3pUaUFX?=
 =?utf-8?B?K0dOWXJaRjRBSnVSWmFYcTZmcVRPamw5SzZLbzREclBPanRUUnF6Z04vWi8w?=
 =?utf-8?B?NGw4dXJpUmhCVzg3Y09XbkVnaWw5bmNxZ1hCMFNjZFpvQXl6V0w3d050cnAz?=
 =?utf-8?B?MGI1T0V4R2tETlp4U2RQb1RLZEIvdkZXQXU0Uy9JajlEVnRScnRzQ2c5dTBP?=
 =?utf-8?B?b2dvaDRUZzhCSFR0dWNJN2xYUXNUV2tkL0NEbVBFT0xnSHFNb1RvN1lpdTlm?=
 =?utf-8?B?S05mS2VVTlZyNlhhVXVDM3ptWmQ2Z0czTE9CcmxKY25JMVpXSVlLMDh1cGtC?=
 =?utf-8?B?ekE4NjdLMUh2ZGVLL3lDUklJeHBqVDJ0ZGpJWGVDSWpyWWlpTGxINjNhY1lC?=
 =?utf-8?B?TFRPdmdabVp1ZEVXN0tpbE1xODd6TzBKRVBnWDFLOUZQZFhrNUlVc3lSZEl0?=
 =?utf-8?B?QUN3VDhzbFF1V3JLZlR0S0xTVThacWxjbVZ6eFAvWVF2azUrdFVyNjJNeHdV?=
 =?utf-8?Q?b1MGS/EwsvU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pNVk52TEV2eWprK2pESlowaHJiV3ZXd29NdlZTVXBNYk1scFJPZ0h4TUNR?=
 =?utf-8?B?aDRNUW9jb0djZkw2Mk9xaFZpdUZOSjhkYnRVNUx5TERNU2lXU0J2UnZ3alFW?=
 =?utf-8?B?dk1Md2FHMTZjbHN0QXFRemUrRjkvUm05ODRhOEZtOU9URncwVm0ya1QyUldq?=
 =?utf-8?B?RWlNMXRscnJncUg3bmphYWlpVm5jaEpaeFhmeFRtT2Z4dnNXN1psZXJaV0Np?=
 =?utf-8?B?aURneGFtZ0NiSEtuOXlFM0MvbC8wdXluQjQwTnZtdHlKQ0k5dXdQelYvM1dv?=
 =?utf-8?B?UHB3cklLYnZyd1QxaTA4MkVzYXpsV2xtTVpKUVpENm1yRHNybmF1c2JzVzd4?=
 =?utf-8?B?MUc0Q1VmZWRHTndLdWZTR25qZkNHUCtrSEVoa08wWWNpZzdaUkp4RGltbkNq?=
 =?utf-8?B?RG4yUEhlODI3UVpObjhDcFJCdmhhU2c2RC83aXo3Nm1sb3lVaTRtaXZVdjBv?=
 =?utf-8?B?elJsMm41TnNwajZxSlZHNENGV3Q0RkZqQkFiblZsOUpKdU1XbUliVTBpYkNi?=
 =?utf-8?B?Yi96d1NNbEUxMnI2dy94MlZ6UE5wS2pLM1VKL1FMUU9sYjdGbFdrRGJpVUxs?=
 =?utf-8?B?YllvWGI4TDNoSjVnSUhLMnN5dTkzaElCK0d4eENhZE9FTUFMcmZFaTFiMnU4?=
 =?utf-8?B?WHhKTm44bDVXb2YvV0FGSHl2MzNvRXNhcUQyNFRwTytIVmlNMjRGSTVMYWdY?=
 =?utf-8?B?bWlnV3ovdkJHUkVnRjgwdlBKVU5IYUxVc2tVdmVmNXRzYUNLNXFTTFFudmlN?=
 =?utf-8?B?Wk1MK3Z5R2ZXM0prbCtzUVhZdCtIdC8wUlRGQ0lMbFNMYkJSUDJjT0RnVXVW?=
 =?utf-8?B?VzMvRkQxcGliZnQyU0dENWtmakZKTUJGamI2R05XS3M1d0k2emZ4aUhxTHE3?=
 =?utf-8?B?MDhUeVlKckRwWmUyR0lFZy9OMGJhUU9MeWtXemRFbTlNSEZ6dTRJSWJicThB?=
 =?utf-8?B?UndQQWNRQkdhb0QvaktOUGZSTDM1Vk85czQ3RmZ4czFtS29CY2VkZ2RzWkhO?=
 =?utf-8?B?WlhzalBOQStScUVzV0FybTlreGZreGNyLzBrYUdtUk5qZnhKMTc3YU5CL0Jl?=
 =?utf-8?B?MS9CQU1CTzJxRWFwbG9mYnVQWGFLSHpWeFdqYnZyZUhVQUpLa2hnQ1hvRFVj?=
 =?utf-8?B?UllaaitPWkwyUTdzUDFGUUdMbEQzOVp1bDVPbGRZZE8wRUxodTZzTnY2OXAx?=
 =?utf-8?B?QzFZTE9JSGlZWGUwS0R5WUI5bExWRSs4UFNTZTc4R3hTTUpId0dhRFFxT3R4?=
 =?utf-8?B?aml6RjN5ZEd6YXVILzJ5anpBNlRMa0NEcGdrSGlyMWh4L3RNK2hJUTdxNVhU?=
 =?utf-8?B?QWNsMFVIUnRtT3ExS2JtdERZVjFrSVkyYlVJZ2x6TWxGYVpaa24zTTIyZlNX?=
 =?utf-8?B?VkliU21zaS9SbW1WZ2pRY1hva0dXa1JIMUsyWmpMSDVXaVZaR0FDRkVtQm8y?=
 =?utf-8?B?VDZrbThOaWFkTlpVT0kwSlovem9YYTY2Z0ZXSUFZTi9lcFNSOVRnU1k0RmI3?=
 =?utf-8?B?YzRWQmRKMzZpV3ovWDBDc3QvWkdJQ0JSM0swQjFGTjQrZ3A2RFlkN2UrRzU3?=
 =?utf-8?B?REl0cGhxWVlrYXNPemU1T2JERnZERGsyak54UVlqSUlsdzJ1SHJTMmF0a0JJ?=
 =?utf-8?B?RzBTWTJXYm5FSGN2Ryt1eXB1dmJHWm81UGNoNTE4ZC9LUTRMUzROWDRpN1Jl?=
 =?utf-8?B?Rm8zeFIzQ0F1NE5kNHBIbHpPSFdtTXp2S1BPaGpwK0VEcnB6eVk4bTNxR0FJ?=
 =?utf-8?B?Qit3N05keXdnS2VYL1duTFVlNk9XNDVnRkg5Tk9LbWUwckwzaXJXM2dNUlEz?=
 =?utf-8?B?Zm5xbnlvL1ZtSlI1TlZxTkFranE3Kzc0M1EybVNjRnpPMmhyQUw2RnlVOWJM?=
 =?utf-8?B?alRjWXBUc1FOR1lZdktMc1BabUNDWjRCRkdzbGhhdjR4emlyajd5U3dHd1JK?=
 =?utf-8?B?MDBnWmN0T1JpeVBsK1hSRjdrMFBKMGFMdkc2TG9talFZRDQzbUd6dVFHY0Y2?=
 =?utf-8?B?TVNkYWo0VWRZZUgwa2NuVFVvcXB1QkYxalZuUEs3ak9iWUluRmh1YlRTMmRT?=
 =?utf-8?B?S2VLQ0pVSzU2WXUydVpxcFNnUnorTlJHd2dNSldTdnFnb1M0bFJHcHRtM2pM?=
 =?utf-8?Q?6wY1FeuGdMP/8BUdLKYrxynLi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb07fcb-e499-40c8-84c1-08ddde20e64e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:31:44.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAbFO3HMGAZBt17Lt0rsHAs09U1CvHb+u2I583JASpQ5kDhk72pQ2wlgpRxRb5a6Iaz41XaobVSlJW1XjQZ/aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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


On 30/07/2025 2:35 PM, Maayan Kashani wrote:
> As part of non-template implementation,
> new default rule was added in HWS mode (dv_flow_en=2)
> in case dv_xmeta_en=4 (32bits extended META for HWS mode).
> In case the proxy port did not start, and it was not configured,
> it failed to create this rule and failed to start port representors.
> 
> Added ignore for this failure to align to other default rules
> creation failure behaviour, and to enable testing port representors
>   w/o starting the proxy port.
> 
> Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

