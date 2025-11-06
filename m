Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14696CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E8DA4064C;
	Thu,  6 Nov 2025 15:17:02 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3A1AF40608;
 Thu,  6 Nov 2025 15:17:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M38aPbwGD+6Lva4xyJ7+zp08cW9YNSD6RVmf3G8iQqO/WOU2DB8ikWD59gANPUbPL+hRLeXRGsnv7AAL6PQUehbWJ0tMpSYlHwxh4/wuafs/xDW4I+iAti1MSQ7qtSWFT1rVk8JDJnsLxFaMgJrSPuqFKPe22htWmy/Lx8Vp7TPwH5w7DUNosp39oXPQ0uEvT5b97lIRTvH+O804XUw3GxbYgUHjA8iwLn91IHaU8egmjUFYnkqQOJs+FzPN9P+hA0ttthUzwZdOnBmhK+bzPoO593XVYyPzJk4uGdm8AGsP4TA1t8+Dk/AsIANjme8EJmfLobn5xrvzCrUZCoVxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBQHUSGd1g745Put+tIs86UH80KmHNgsoPvszHiOgEI=;
 b=aLGpIQwX/h8c/OVvPhJZVFhLOX4vx9J1jcYTBxvGZQSa0xpM6HUxCKOk+4pHPFFaN3MAIyzBdWW7IKq/OHBCbsmYJoykEvL1oUl19hjGZxk0YjG5LjGO2bF0JWg/OLFg0VxyBUsRneWjIH4JQJ78PVKuNEGgjc3PbrpRT9misHx9/YILDwPmI24TPxtcz/wWDHhRUkvqNK4qjSi+OvoX/lqkgFEmS/hTx7P5Zz3UFohV1QWwYGiImcWTcWDkF4iCStoXGxZuu8/znbuhz6tXb38UpgnFoEVaQCqzNKFCQv9u90NJ233eKZu0ZY9FB0AqrI4rclx3MK+n3BVoRpz1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBQHUSGd1g745Put+tIs86UH80KmHNgsoPvszHiOgEI=;
 b=UE6xo6n679QHyfFLEbejTrW/gjutE87kFw77Umso9jsiSmWaUygFWVEHzUlAeZeo8dcZCjbcEGf0wGRh6QVpQ/M8Xas38IgHrTIo3CdUXHrORlUrrw4pVv45TR32xOTclImw+b28wmTEl2en+4XH8BNiCkcptrqFlyLAU9+5hfal7xWOe4t3Rui6QJG+HJ73AbCNpIafoRcRf8FtEuxSOgh/UL5dd+qqoUWxQalGcvY0Bub67xrtdeS0wihlSeT2auHR/uIhHX1mf/6wd0os8ZEr2qTzhwxjTJA8DTNJQMA/LYhjX/LQqlRr/965FdXhk7oQePyz/Z8aiCOZwb8SCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:16:58 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:16:58 +0000
Message-ID: <d31e7f60-ddde-4d5b-9327-187eeb1c86e4@nvidia.com>
Date: Thu, 6 Nov 2025 16:16:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/mlx5: fix invalid queue index handling
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: getelson@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
References: <20251105125200.468312-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251105125200.468312-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: b2519b4f-f280-405d-92f2-08de1d3f2526
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3RhTXk2OVFFLzdTTTFFUnlGOG1NWHVsZk13VzVBV2lkQ1NHMEV3SCtoSU5i?=
 =?utf-8?B?WWpNM3pTa21uT3JkamhjNjZGa3dFV05YNDJXNkpqd1F5cnN3b2RNamhwT0ky?=
 =?utf-8?B?TWg3M3cxbW1YTVhhOFY5Y3c3WFBqTitJMWtMd2JjQUxyOUFadGRyZG9McDJI?=
 =?utf-8?B?b3VJTzZTQWc2SXQ0NlM0YlJLR3ErSkNEQVBEUWI3YjdBTTFrdHhKcTVrNmZZ?=
 =?utf-8?B?dlhBeFVaSWIvVUduOVFWMXRoVXU1SC9aNmJyMUxDZGdLK3dSTWRhOFJsNDk5?=
 =?utf-8?B?OXZzTm1na1Q3OTJOV3lIWDVrdFc4YXUyMTRORGRuYmVlWXJnN3JSN1I5b1Vo?=
 =?utf-8?B?aXdtaWxVNU93eTk3SkQvb1RkZXB0Y0lzV2hUeGFYT0tOZTd3YzlYeVpuRFFo?=
 =?utf-8?B?UWUvMUErdGllcDFjYk9aOXZTQWNOOXU5NmRuT1dWV0xkUnVuMzRxcTVIbE9M?=
 =?utf-8?B?ZktsbS9IOFBmTGtoS3I2M3g1SjRhb1creTlLOGdBNm8rNWszdjkrYnVJTDNS?=
 =?utf-8?B?cGgrUXpraGplQ1NUZThQQVhGZ05RSFhaWm1iSGpjZEtUTlF4ajZuQmdHNkRq?=
 =?utf-8?B?NG0zR1R2WHpGaEMzRlFuRkk1eWpCZUdobVlhNlNjRDFCd2tWckFhZCt0TWhO?=
 =?utf-8?B?WE8zVm4wL2RmOUFPRG5BUlg5Z0lGRkZ5eXgwbEtaMUgrSTlkVHFLMk01b1VC?=
 =?utf-8?B?azRRQmlFVURvY2cvc2JjeDAvVk5Jd3puTnRHWWc3aUpMTVNsVHVKdEpLd2xL?=
 =?utf-8?B?TW9nb1IwZU15UkdCL1k3T2hGTHY2ajR2Q1Q3STNCN014ZzEyZzVMMks5dGNa?=
 =?utf-8?B?cE4yU3Y0aW10RUErWmtTZGg3WXRnSEhPdEF6dzRCUXBkV3ZPYnphQWhIbDBn?=
 =?utf-8?B?aHJNM29QcUE4MkRnMFNuVTVtdm5XRVRKR1JiQzRSemlWcy9jUGovZnZKVTcw?=
 =?utf-8?B?RHlDUCtkRG9GVVZOdkdLYktNd2Jyc2hzend1MmR0S2JveWg0YVp6dWMwaVc5?=
 =?utf-8?B?SnYzRW5uYUx5WExNYUlDN09SL21xNVA4emdrc3lsQ1ZKSGJXc2I5N09tNVA0?=
 =?utf-8?B?WmllVkIxSThpYllBb2lqQXIwenRVbmloVHJQZVhxWHhaRlZuSnliTk5EblNW?=
 =?utf-8?B?eExkSzFrNldOWjRhT1dCZXE5WWgyWFFGU3JXdktMaW9sU2NSY1phTyt2ZXkw?=
 =?utf-8?B?TUxwNGhwTGZLYTFUT0szcWtrR01RZVJUeDIwdDdiWFlDcVpKRWtKMGpORzZ6?=
 =?utf-8?B?TzcyU1NjMFFpVVRrNzg3R0ZrQTRicEIvZTZRSlF1c2tBdUMrdUVtV0x0SXBV?=
 =?utf-8?B?QW5lN0RZR0hwQkFSUU5Dd0pOQnZzLzk5cUU1RlV2VkQwZ1MrcHJxSWw2dDZU?=
 =?utf-8?B?d1lJZXorUEd2MXlIZldKeEJWZTZvSjB2dXgwRnQ2R1U3WmhvZ2cwODBBbWpv?=
 =?utf-8?B?Z3BtUzN4UDF6NWw5eVhuU0ZQRDZOYmR4SWd1WnlrUVpJNEtRbmh0WTVENUxo?=
 =?utf-8?B?MFZQV3czTVRWQVVPVjlTcTVIQ0NCZ3k2WngyRUZ2Y29hS2JSVGloK2JMR1Bq?=
 =?utf-8?B?ZXE5Q1RYOEFMWGVNSWM4dGlFZWpnb2ZZVkVUUVNMVGk4YytTMVhnME9IZFRI?=
 =?utf-8?B?WjBQWVdudlF6U0dZZE9maWVEcmxNeTB2K3B4SWdqUm1ZNFY3enFPM1JRQjNM?=
 =?utf-8?B?TGN5WENSeTRVSWx4QkRBbWJlTzAraTIwSkpESVVpdmQzdU55YlhnNGZiVDRJ?=
 =?utf-8?B?M0Z6czMyK0wzVmo2SUQ0b1ZtcHdyS3dXTzFMN2xXTVpjZjAzK0hBa1RmbU1x?=
 =?utf-8?B?MG9DVm16SWxBS3lhWEY0ODFLa3p0R2plNlpMYnlEdjZjdHlrQkN2YkhCWlpS?=
 =?utf-8?B?N3VrR2U1UDRzeVhQb0VaaFlIbzR5RFhPR1JMbmpldU5kRHVnblBPOWppTjBS?=
 =?utf-8?Q?aZr44gcEKTb2M2+MvdtJJpe2ZZ3I8UV/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZwbGV2Y3dBRFV5ZVN6NmJWTzdwbGFWc2dpcUxQUkNUMEF0VXExT0c1UVdX?=
 =?utf-8?B?cFo2TDNlYWdFRG04Skx6SlZmZU8zOWhMd08zcWs3ZmkzOVhDUys0NkxxZ25V?=
 =?utf-8?B?UldXWU16T3dYTEF4WS80bHRVQVQ1SEZVdHY2MGVtTzlaNFBVQ3hyVnY0WWNB?=
 =?utf-8?B?QTNzaEIwSVRKZjcyc01KUFc4T2g4MFZsWjBrT3NaZ0dnRXZFY1NNT3BjNkxy?=
 =?utf-8?B?ZW44NUNhUkVMT2d1Tm10eVFZZFhwY2pMVTlQc1VWaUZMUE1iU1Jrd2FoQStM?=
 =?utf-8?B?OGpDUXY4R3V5dDI0NmRRQi9MQkJ1MHJzQkRxVGMreXAzSWtQZmtDaEFMSXox?=
 =?utf-8?B?dzVSMG5uYUozcDdPdHhiMVRVSTdhT3M1UDV3L1diVHNrTkNJM205L3FZNndY?=
 =?utf-8?B?eXZscEpvTURma012TkphTnE0ald6THZwbUhLL1dvSWRNaGVSdVZmUWtWNGEv?=
 =?utf-8?B?ZE1obmp5cVE0Q2ZoMC91c0tPZVd4bStWeStUQkROcTd2dTRYRVdHRFpVMnZT?=
 =?utf-8?B?YjZpU3ZzK1BBaDkvYWVsVm5wTWtkSitrQ2F4aW5kcm1MQnhka3NDS3JEeTRu?=
 =?utf-8?B?VlBkQjFtbFJaMmlpM0hwUDVsbWNMVkh3cCtQdlMyWVBYbEowY1k2bEpwQjdv?=
 =?utf-8?B?a3lkVlByeFZpS25yMHBFTkt1RlpwNzdXbEhSRVVKL1JFTzlnL0JtK2ZQL0dL?=
 =?utf-8?B?b21JS3hKZGJ2T2o2ZkNobUluaXNVSWxrSkpwZGhXZis5cGpsa3dHRVZTRXBq?=
 =?utf-8?B?K1d0b0JLTzUraDRaSkZ3Q3Q1VGtxbFlaNU9DZnhDVU5SUHg0dmdwMUg2Ukla?=
 =?utf-8?B?MHp2N2Z0eWxUZ0JtKzI5N2h0RE5rV09tZVo3UllGR0ZwS2pNU2xlLzd6RDVz?=
 =?utf-8?B?YVpIUDFIYXZvaVd1WmZFdUN2aElnak5kcVRiTFBlSWxwakgyZlFIb2pMbVVl?=
 =?utf-8?B?ODJZV3l3TzdJY3VtdGNnSUsreWVWRktQQ3R2Y0hiTjVMa1A3WndwaURYZFUr?=
 =?utf-8?B?cWdVVzhhTWRsNDVBV0hvODBqaHhHL0haMFc0YkpabkFnU29zVnJWK1Q0K1Er?=
 =?utf-8?B?bEEzSjRyaFp3clk2N3VqaXVNRlhMZGUxZ1FZVE1GRWcyUzY3dDdNM2VMaEZx?=
 =?utf-8?B?djhmWkxMNHlkNUdRcGJTOUtCRktiaGpVaVVDQjRFRXNJUFJuWFJlelJuV042?=
 =?utf-8?B?ZTRDcE80ZDAyVzJvNHBFdisyTVcvSERqaEttS0VxYkhYVGRvaHNqTHkwNy9S?=
 =?utf-8?B?SWZxaFhzbEFpbmVvdnE1eU9nRkZIcVphc3RMQzExc3ZmbW12ZWgrd3Fydytw?=
 =?utf-8?B?NmZMY1VML2hQd28xcXVwbTA4K2hLNmQyanlPZjFqeVBiTU1HMUt5SW0xcm5N?=
 =?utf-8?B?N2JqbUtNL1k4TlEyNHpFMjRheCtYS1UyeDYxOFk4THp0cHd3d0d6dml3UVZa?=
 =?utf-8?B?WnJMblpsckYzVXB0UFF4bVZUSlp1TlBNc0pDUGZQQkdtRFJaYTZ6UWtJTnF1?=
 =?utf-8?B?UFBXRXc1NktnZ3BmUFBLWk5uYWZucFZDanAzQXFmTVFPdVVocGZ1aTRUL0lT?=
 =?utf-8?B?ZW41UHlld3pleVE3QXZqQXdBcG13ck1VS0FsOGMzVlpWdmtKc1R2anh4aHly?=
 =?utf-8?B?dWxIRFBKd1hNTEtnOHljclFjWFNGSWNpUE0vaDhJVTNnVUhKcjFNQkRJVWhr?=
 =?utf-8?B?UWNzVzBNZFprekVkU2NtKytuUUowaTYxSmd2czhzNDYvMkd2N0Z1OTlGUWtt?=
 =?utf-8?B?b2hoR1IrNVVadVkzZG5DYmxhTXNiQ3M4bG1mbTRkbHRLYzlrMjdmeWRTV2Uw?=
 =?utf-8?B?Y2lZU3orTFN5elI3SE4yeXc4Vnp5YkJ4UXVSTkxYVENZVDdJb1ZIRFFBK2dt?=
 =?utf-8?B?ZitZUW5ma3FuQ0xSaEh5VWhCNWVjQyswYmNWMkV2VzhXd3JGZHRrU1IvOWNv?=
 =?utf-8?B?YnZRU3VxbGFmYWNnWlhMOUlMRDc4MGhGS1I3OU9YNC95Y0kzUDh1T1dMRTd2?=
 =?utf-8?B?RjYvQXZ1N1AvajJsL1NhVzVUYTlnZnpJbTJJUHZNSzk3WEJ2WU9wa005ZFFx?=
 =?utf-8?B?RVZRamhQc0FnRWRHeVVxNmo2K1ZmQnk5cndPSXoxOThXanZxbjRoK1pRWnA0?=
 =?utf-8?Q?7nk3DJcrXLO+I5B6OpMEuGU/I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2519b4f-f280-405d-92f2-08de1d3f2526
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:16:57.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZHBqCrqSRNE+Pqi2LbO8RiQL6KwmWHbltESeOBWnCviVooCW6VPKwmCW8Da2xNHVX9Qii26LTaSdNR4OgP1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578
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


On 05/11/2025 2:52 PM, Rongwei Liu wrote:
> When failing to allocate a meter HW resource,
> PMD may use an invalid index to release the job.
> 
> Fixes: 4359d9d1f76b ("net/mlx5: fix sync meter processing in HWS")
> Cc: getelson@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
>
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

