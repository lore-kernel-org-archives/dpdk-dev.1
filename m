Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4052AC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 06:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FECA4026C;
	Tue, 13 May 2025 08:28:59 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by mails.dpdk.org (Postfix) with ESMTP id 5767D4026C
 for <dev@dpdk.org>; Tue, 13 May 2025 08:28:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO7RaUu3YYzZzVBOPfm+vz6SEgASVgKXS1vA8fdpe57fAKrz4Zpqi+cfRw7U8AnyLKr4HOnaiw8lHM2RSacIxX4F3R5h/ItRta7PftCoLBzLubF8IL4e9kLeQk1eqVH5LcCnIzJKejHjE52Usfl6LR1J+NtqdRZp/7u4HzQxKMTCV3Ur0Cx2Uhyz6UVkinDRcV3EitI3C+ytKv3gNUECA2ZMah3//d6W7V3reQtCSEjXsY1jpOB4w8PGROHWpfP0tHrujoNjuO62R3mtkm7WQt4zBM/i3U3O11Ue2nUYw5Vp1IIRCid5haMJN4sau4U6m8vcHjNXsYY9Ffa/1CNIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMQxSrQiu+agdLVd76HFrGuPHkf4TZrYGZb8mPACIM4=;
 b=orbTkkJJfGRxWObB+mTkL7IUfQS2zzFt9ycHtqUOdX7BTNglYiSIxLK73LCcz9tpIXWP5tx4NlYRnK1CerwgVs/lPxb82KqS3AzGMQofqS1SkZ/vv1Uky2ESh48kpIL5QTQhsjW4bKMbp1iTDWjDbD2u1v5h37u/glOdnUBHL5cSJgCFGP1MijhOnfXctL8sAjXNYbSYh0yAvZS8oHV/yR9wfluRS+F9hC2j+Z2xnkUq2qphqVc3JmJfoECmfJnYGOrxq95j9HZM+0RF05H7O5G6VUVxXAHPJs5YtdhAcuPQQgbUecf7kZsG7PqjbcqPSaFaOV+vcIOwdz7rLFm0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMQxSrQiu+agdLVd76HFrGuPHkf4TZrYGZb8mPACIM4=;
 b=eU7ZeNPLeAL+UOZ5Rhtg8nCghVf4uKeHct8+jAVBMbl8hpHove6jMXvB4RcckXeeJxW14x/KvMEyNyEXiQI83mwdJ78ndTSOqhzwZppxVhCxFquO7loaDiU97/ruiYZE1UJzL+cm6JtJ+mfpKYUmiLiq16XcM8tCYJwaiyei5smuogdJ89u4yKODEn+i4bZGWffleGjtQWe9LqT7M+iWWNc5CIQDvVa/l549wbkYhgL8/+7pkrvxVqqxjg1kiwLWqoFvMBmCuP6w8JcPXRHXmljGmObPJg6h11aOWX4FCgTN53MIHYZgYFftnIz8JSvqdpg+Wf97E5g4bzOkDIlf6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA0PPFB67404FBA.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 13 May
 2025 06:28:55 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:28:54 +0000
Message-ID: <1ccefc96-f08e-4bf6-a547-f7514e552286@nvidia.com>
Date: Tue, 13 May 2025 09:28:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix support for meter flow action in HWS
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
References: <20250504052350.91160-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250504052350.91160-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA0PPFB67404FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: bb87ecb3-f752-4dff-7ad0-08dd91e76efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3ppRjVpb0tyTkR3bjluelkxUy9MMWtuTmVpcmtwY0xlcVFmSEsvMmJrY1Iv?=
 =?utf-8?B?T2RpU1FPcVgvOG5iWFM3SHp0NlVmWCtSN1pDZUgyWGVoWUhoMXRnUlMrQm1y?=
 =?utf-8?B?VEp6Y055QzVrR3ExYkJOZXNkY3FGZzJtR2t4S3AwTWkyYm4zUDFWaDZzQnhl?=
 =?utf-8?B?c0lxelIxYnJrQnZQSU9yUmNuWW5GN0ZpOFJ3a1RBc2tSNXNJQUZyc0lRSE9T?=
 =?utf-8?B?bHd1bitzc0tqRFM3MXQ3WXVhVXpkNllIdXVhby9FT01BanUrSENTZWZmVksr?=
 =?utf-8?B?WHdxTGtEK09XM1VNUzBkUGJlT2ErRElMak93SVI5dlRkd3VZcW1aK2IyeHlK?=
 =?utf-8?B?bloyLzJLWndHemIyNmlLZ01BRDlLcEdiU2JKZjlsdUtCTlgvQnF6bnhlZ2or?=
 =?utf-8?B?T2hxVnFseUtCS0RCUkgvZG1qdkNiR2EyNy9nWWJnblhvWHdmRnAyRHRVbVR1?=
 =?utf-8?B?R0lNczJxYjlvS3E0cWwyU09YVkdYNjkrUGlKRWVvcXRGOGtOTVlCTGRQSE5w?=
 =?utf-8?B?dkU1bDZieDFDa3dXcGlrQzArSUN1UDZQdDBPTVVRNExhM2dtMC91TWVTWHV3?=
 =?utf-8?B?TDVUWlh3OFpyQzVVOWk2WDFjZmR3dkpha2JDTzA5b09GQ0FwRDVWcWFUaUpB?=
 =?utf-8?B?dnVTMXQ5U2w3aHNVME5PbmVHMUR4T0pEdTVTYWdwbUN3RFp6L24xR3ErMFIx?=
 =?utf-8?B?SXJMQnBRS2xPSFdjYTE5MDQya1BWdnlSdTJzaFR1MjFiL2lqR1lBa2ZoSmNv?=
 =?utf-8?B?bU92Q2hZeENEOFBVQUhwVHdIWTNDV1N3SmZMSEFvUHFnMXhwWXF3cXhSWExD?=
 =?utf-8?B?N25vNVFTYUI3TWRmZDkyZm1FTCt4RUQ3aTRlRVNENE9DaFY5QUo3Mks2S0pz?=
 =?utf-8?B?c0o4cytMbHFLNFhZZzd6OEYvQzdFU3h5Z1NMVGdyYjNwa2FIemgvR045QjhV?=
 =?utf-8?B?Q0JKU3JOcnZ0b2Nrb0g0cWVFYU5PUUk1Q1BrMTFDb1Q0S2k1K0llaHM3Smdt?=
 =?utf-8?B?MVdPNGZ0ckRYWHhVSGZrZHA0Tm9Rc215MXBIWnBDaHdqaHNrbzZOckduRk9y?=
 =?utf-8?B?RUkvWFlJQnh4R0d6VlRTZldoL3U3bG1zdzRTZTVGTkRTVGErS0lUQkVQcm5o?=
 =?utf-8?B?RmFGUmU0K2VRbURYUnY4b09TYnlJWkExSElXSVRqajd2cnBzei8xVnBqUk1l?=
 =?utf-8?B?aTB5UGJDZHNQcXE3WjBHb1E5c1VCRU5VdGFCdkxubE5BWTZnRTlROVYwbTlO?=
 =?utf-8?B?MlNxS2VFRTN0K0tpNmVEUmFEbXU0bFdiUnVEd2FKUlZRVVpJSlFRa1RlaWQy?=
 =?utf-8?B?VS9FdHJrRE4yRWU2SVNMMnZYak9hZWZ2cGVFREVwU1IweTY4b1FZWHp1RzhI?=
 =?utf-8?B?dUI3cVJHcFNiVjl6OFhPS1QvQmpvTFp2WnJmSHhFTy9YdGxUZmx3ZHR5YU5l?=
 =?utf-8?B?L3NOMVQrR1ZTTTRURW9wdjFFbW90ZE9RRjJhNm9rMWpNYk1JRHVCMjlXQWl2?=
 =?utf-8?B?dDMrM2FTK1lWMzNEZ0JjcDNtdW1pc21HZTcwczRQTXIvckhJbVlVQkladjR4?=
 =?utf-8?B?Sm9IZU9hZGcvV21BZ2sxbnV1Wng5MTAyUjNsSit0cWlOenF6Q3N1cmFJbDhO?=
 =?utf-8?B?K3hZZWQxYk9XVkxySDhRTDlSM0U0QWoxazBTNmJ2OFNKa1U2Ky9hekRBN1Mv?=
 =?utf-8?B?RVptbmlSUW1Ua2JjU2NpcUlWYmkwNnM2Z3JpOU1Rd0I3bUp1cmFBTURBcUpo?=
 =?utf-8?B?T1B5YkNwOGphKzZGUE1ZZThvenZyWHNPd3kxMldnbFVoSDdMaGhEYUxNWVp5?=
 =?utf-8?B?MUxMenl0aDB3M1hCQzdvL3krRTlkUDRVeFViVmdaMFdyVEJlT3BmQTRjd0xn?=
 =?utf-8?B?VEJ4R2NYVTZaUDNZdG83RGFKT3dnN0xHYlNRSDcvWGllZml5QVU5c3F5M2cr?=
 =?utf-8?Q?5i8hB8hIL0c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFRR0lvN2FITjdEanN1MnovNnR2U0dpeVVVbXllM2lRcGM0ekl1N1dBZFJP?=
 =?utf-8?B?V21KancrMUxvNXoyQVhCbHFkeUY2bkZvNFUwdU5iSXZhYTc2aldSYmFETG15?=
 =?utf-8?B?QW9iZWc2V0xpZlVUWTRmeFdpY2tpZGNINHB1VUowNXBjWlE5Tnlyc2lDbzRW?=
 =?utf-8?B?Y242K0Z4SDM4THV6UFhFbnV6clRkcktUSFJ6MnJ1TW95T1BNZnRLVDFuZjdk?=
 =?utf-8?B?a1hBUWZtWk0wNUw3bzNLZlVPSnVEdGxCdUtITE1sS3BXZklwdEV5YkhDVklS?=
 =?utf-8?B?dUZkTjRzOVF0d01tYm5CNjRFeXZNMzcxZTR1dEZOVmlXRkFjWUlaTXk5MHYw?=
 =?utf-8?B?UWV2dlNOaVJBemRMQVlCdWRnRUpGa2pZZ3F0RHVXT1dYWkJtenU5ZzFZYnFz?=
 =?utf-8?B?c0hpMDZ6Ui9CbjJqdXVlQVhLS1BWNkdrNlkrSnpXOUJGaVhLTWVpYktLd0JW?=
 =?utf-8?B?Mk5HTkxHMW5Bd2ZMc0NKdytWOFFMcmg2dEU2bm9LV3lvRzVOOWhCQTNMTDNZ?=
 =?utf-8?B?dGlLUXlXcGcxMTdtMmRzYnpvZVA4RDdxVVRmdWJPdFFESTZCOUE0U055b3Bv?=
 =?utf-8?B?eHRMZUtjS0FVeXhDY0ZwbDVCT2JqOExadERjRkhEOWVpbXVyeWVSWHVzdUlK?=
 =?utf-8?B?NFpXMEp1WkdydTQ4T3hHUWF1TkxHTjBvUm5uMmtGQTEwOFM0cDdNaGo0Mkdu?=
 =?utf-8?B?Z0liZ2syZ09ETjdES0ErSDdtZ1ZncDFBQmFYZHdMdnZ3Q1gxTnpzeHNTanBt?=
 =?utf-8?B?bWRnYkhodGgvcElDckZmQzlvNmZ2UnZvRWtteWkrRHY0ZVAwSU1GNDdsUVhl?=
 =?utf-8?B?VFY3SFBqbFVBUmVQSEVmYVg5KzkvRjZyM1NHZFJOSHU1R0pjc2t5OCtQZkpy?=
 =?utf-8?B?MzdJMko4eGdGQmpiWjkxUnE3NEc1UnJ1SjlnWmU0SXA4cm5Zbm13VmdUU2lY?=
 =?utf-8?B?djhVUXZoRUdsY0dhc0ZGejZoVHY1NFZMT0tuOVRPQTFVTTZvSCs2Q090L3hY?=
 =?utf-8?B?UENiQ1dmQllZVGdoZzJMZkVJR3hRK0p3czRRTEtvTXhjN0piaFliZzQxQ2Ju?=
 =?utf-8?B?bG9KNTdXOFV1dUpGbnRUV0pIbDVqWk50Wm4wYVRuTmRRaEd3NlJlQXcyNWM5?=
 =?utf-8?B?UXFUaWo1b1g0QmlWY2psbDM4dGxPSW82a1NkYjdzU0o4SnRCNHZiNUp3OUYr?=
 =?utf-8?B?dUNERFpsSFlpY0FHTlhVUWM3bWRKeVJHdHNOUmk2LzFCbVEzZEJrZjF2NDNp?=
 =?utf-8?B?dHNuaUhYTTdIYnJvemwvOXhvaTNIS2FtSFE3SGZWQXNSU1F6bXFPS3VoNFI2?=
 =?utf-8?B?aDFhRWpjenNlUDYzM2hQTXg5aVZlaUZacGZUcERiMXcyNHNJREljY0cwbkVt?=
 =?utf-8?B?VVZiSVNzeEhteFEzYllhUWNzcTVBZjNvcFhBUHdrTmhOb3ord3dBTURvWUhC?=
 =?utf-8?B?a25nRWtOeG9oRnhmTkJWei9GTlFwTDFXSFFvSnZhOHpjaUZhVW83L0puSko5?=
 =?utf-8?B?dytmMHpKSEFEQWJBSDNNZEZHbWMxSGt0Z3daUzhYM1lRNis5SWV4REhXQzJJ?=
 =?utf-8?B?ejVRRGNlMC9OUW9Va1MyOUpoYjc0Zzg1TmJUR0VVbTZJUHh0aUdQT09KRVRJ?=
 =?utf-8?B?RzcvVzk4MVNZSklJbndDaElDdmlHRTVuZXlRREZVY3FXWllzOTlnMlJGMGtD?=
 =?utf-8?B?Mm5HU21aZjRtckR0NFpCN0d0c25HZmo2ZUovaVNFTllZd2Nnek1LMHdGbmxH?=
 =?utf-8?B?MkVqS0JVOGx2TzBBaVRCMzlGNnUwQVBFRGtDOHNTOEo1aUgwWURxMHVEVUg4?=
 =?utf-8?B?NjF1N3U3QVZrNzlhOHoxWnc1WU52SjBSQ2VqR1lxWkw1aXdDb2xBdjFWSGx4?=
 =?utf-8?B?SGxGMmYvSUJhRXhXbEM5OEZoTnFqYU1kZnhFZjVjLzNQOHllRC9UQm8rVDdD?=
 =?utf-8?B?VmZkbkwvV2RaRVQ5ZzJnOHNtQkJoTmtrRk5NZnprV2dFRjhFeS9sbWVXdmtN?=
 =?utf-8?B?QUVxNW1iek9VODl3ZE5LQ3JGUkNnaGFrUWE2emVWN29WMXdZNTR4QjA1L1Ew?=
 =?utf-8?B?c3ZLNjZjeDhYdGNtaGc2VldXamtQbzlQR1dPZmE1a1QzdXVITEhWTkdXQTh0?=
 =?utf-8?Q?qScP64papMZhtvLpkdlE2Py/S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb87ecb3-f752-4dff-7ad0-08dd91e76efd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:28:54.5193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uJ/RDKslXXBsY1rLfUBK0WjjW3f7uEIs9XWTzvSbG1iG5ZHr300Vk8RCk0M2SiaKBT03IO+DU1Vnwxet/120Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB67404FBA
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


On 04/05/2025 8:23 AM, Gregory Etelson wrote:
> METER flow action is not supported in MLX5 HWS mode.
> Application must use METER_MARK flow action.
> 
> The patch removes METER action from HWS code.
> 
> Fixes: 48fbb0e93d06 ("net/mlx5: support flow meter mark indirect action with HWS")
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

