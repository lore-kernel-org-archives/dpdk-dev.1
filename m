Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CC8C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 13:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95419402D4;
	Tue, 10 Jun 2025 15:17:28 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by mails.dpdk.org (Postfix) with ESMTP id D77634026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 15:17:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVpvKMIjiOBKIt7MZ70w/54/TsmcykZK2kxVRWRMqJKo7d5P0BgihyTOdJ8kjTP9jivexjCcFzokG6m9ywS/CjVk+J48DuiD5eeGymSciSkSBpXe7RdkZN4IJAEW9n4+2jUBK1lS1dy0FlOB9q56XUY88PXPpcEZRVz3ozofNdtJ4U15ZWUf6JeOs6PXHyrYVOyxmpRolyRop+vtAMJ4TuTtZHMJr1he3WotTqFaC6hYk/2Hrv7St7mKJvcwGp2QM/8DBPGCxboluq+cwOZNUuYJSToFq1Jh30Mf1D0v15ZgWdE6dyrmorqZ4A2x9NMz/CC0LcKa/McjJXqTU5b/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK85nBRWdERw36Orc0CwA9e8gZrYP3oM+GwAyf/vQKY=;
 b=NUsHXaOMzAgUGP3lgB9wbdDBtNp2NUZTkkFykUM8Hw+OOIm9qXPJIyZjpnd2WVpSuid69IdxQfRyJGMh5tdQzbIXnqeDN10KRgQnRszzxYJQSq9oEs9YFiIDdvV+uF+FD0du4t+nB2qMdVVXfUI5ynFdWBMCRgfRutJWVgYFRPqTeRfrJmJB+PfjL3TYjbX1z9vzID2DSl7iLf1Q4B5jgy2Ti9lIlxqwzn2H2QMDVMJzEAu8RkTBQwOfpEOuW+7QNivvNSN2bW64qs7f6i5cF++0h/u80bKtnbE9cgWonL33P/S+G3YjP5uR1K61MfnYNCxMZXeh7uiSAtLBiB35hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK85nBRWdERw36Orc0CwA9e8gZrYP3oM+GwAyf/vQKY=;
 b=cZWxZge/KLHJhtqhl3uz2+t5WD12vTKojHXHjOudVmqUoWXLPuPCaLti7ESIYSOjznozUKWSLxa8K2oqrKkwNZHTAKHkesRfvpjibgpPQzsrtdvByBFkGUO7I0/NB6+xf5S57Emk+DSCLz+B5cRoji/3ITN3g7FdaK56JVJYFk2m1thzSvuH1F7jJ+gaDmOYZNREY+kMRAuHG9NE4V/qvYsaFuP6VoFRMDTbnnSITlfo79YzKghxOnCmTHQEiHEtbxss4KP/ENSlOq/gB8S4yJ+tRYNbamEBBm4GOwoiRJ6EzeuVCz/hnWx22Bxq47LH8FEwrpPRuqmS3LjXtYjBdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 10 Jun
 2025 13:17:24 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 13:17:24 +0000
Message-ID: <648ec4c4-f4d2-4a42-9ebb-0fa015376e11@nvidia.com>
Date: Tue, 10 Jun 2025 16:17:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc/guides: Mention needed kernel option for mlx5
To: =?UTF-8?Q?Jarom=C3=ADr_Smr=C4=8Dek?= <4plague@gmail.com>, dev@dpdk.org
References: <CA++ArTjpo7QE5t4F0eevDsiuWtB_WN12FU9nxakxQ2a=nFxp5w@mail.gmail.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <CA++ArTjpo7QE5t4F0eevDsiuWtB_WN12FU9nxakxQ2a=nFxp5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: b40a7173-f9e0-4729-278e-08dda8212387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VENpdWI5UHMvRklvc00vMnFMNlh3cytyOStha2ZqL2JDNlhRcWtzS2tHM1Ft?=
 =?utf-8?B?am44SE5LWkhsWlAvWW5jRmhFRncybDNHZTF2bUpqZXJ1d0VjRjZyUWJTWmlV?=
 =?utf-8?B?c1BQSEtJbFI2U3hSbUZoa1BPd0t4QlQ5NXhmSUl2eG11dlF0eUtma0R6Nys4?=
 =?utf-8?B?T0FtdlliOWdHRzFwM0ltZGJjTGhsdXFxWTcvZ1owWG9EVHVXc3d5YzhDK1hW?=
 =?utf-8?B?UWE4RXBqbjV3dTJsR3ZxTUdKNmxOTittODcyRko4TElHUkZJck1LOUsyL2xU?=
 =?utf-8?B?VFRCc3hPdS8zc3ptZitHaVZEYW5GNWo4ZjVEMUpETFdZV3ljajQ5REw0cFBk?=
 =?utf-8?B?eElFT3JXQUZBanBwSHNMUExYZjdTN1VSdnNENkRVenFaWUNhMHRLdVg0WkNO?=
 =?utf-8?B?RWdacVo4SU82ajlSZXpUcGw0NjA2QnNCNXQvaEJMS2N0MGlrUFNSb3pPa1pF?=
 =?utf-8?B?R3FWRWRsdWR2S1NPb3hUbWdBTWN2SGFQS2hqN2ZHS21aSE03NmlidXk3Q3NB?=
 =?utf-8?B?S1h2WnJNcGUzVGV5OEkwcTNTdzJaZWROTWZ1Tkl2cE1pWFluUUF6QWdVZm1G?=
 =?utf-8?B?ekF3RW0vSHhrdkV0V0NaNmVvVjFOSlVUWWprc1c2VE8xMWlQUjI0TmRmaTNK?=
 =?utf-8?B?T3BHM0tJdTNPa2pnM093WmdyT0R1K2JVSVFWUENVRlFaQjJTOEJib21MdVNm?=
 =?utf-8?B?NFlKNFVwM2xjRzNlTFMrVnM0dWpBN0YrL2o0TnF6QmJ0NDVoa3RxanpyTzVv?=
 =?utf-8?B?WitBU2RxeHJKMW5mcC8rNEhaRGZ3Smlyek9iWmZLUGpvZmhENkYxY01HRzNG?=
 =?utf-8?B?YVB4bDhGN0x1SmpDZWw1V1VqcTBjWmgraFZvMGhreXlIaU13VHh3aGRSZjNO?=
 =?utf-8?B?UHNuMFV0SEtWY1JhZEk3YVYxb1ZwR3JIUXo2clFNWGV4emk1RjlLZ2JEbTdX?=
 =?utf-8?B?U3ZHNE44Y0xpZkVBS3lUd3pYSENFR2Y3V3piSmhxVWd0b1NuWm9PV0tCcEZ4?=
 =?utf-8?B?b3RaclFXVjZYRXJYNWRiRWV6bGFnVkRrQS9WK3NKbVJxVlI1OWdjOGt6RUFX?=
 =?utf-8?B?WEZmY1lOTmdCQ28rRWZDcWlUbTk2YmU1eVFxajNWMXlKV2JIaUpvSXpzOWx6?=
 =?utf-8?B?WnVYS0NDYkNNdnJSTmZ4dWFQSlQrdExYbUdwR1NEQWw3bUZ4WldCSXlnMmNx?=
 =?utf-8?B?OFdETjFvbFdWdUQ3MWo3OG5nVW82QUUxM2dVSytLam5pWk9rbUNEeVMrZ25a?=
 =?utf-8?B?dFNJVlU1Yy84dmRKakVxeFU4WXdlMlNSZG96SVlSUnNrZ2Z1K2w2Rm9uZjlp?=
 =?utf-8?B?NldWRjRsQ1pIYkVRWEVNc1h6dWhDVmZQQkYybldiL0RYVTJPSnZ2YmNCZm1m?=
 =?utf-8?B?dFJ5eE5zSzBiSnU2TEE1OElxWjhNQ1dkL3I2SXplSi9MRE80aDBBa2NnVkth?=
 =?utf-8?B?OGc1OVI0emZPWForckI5NGhUMUUxRTZSdHhLVWpyMUJnOG55ZW5rQkU2MnMy?=
 =?utf-8?B?ZVZiTnFPNEVqWW12c3ZSZ0ZwR0FJVnNvT2p3WSt4UnpZMFNSdFY3UitqaHJu?=
 =?utf-8?B?SHlpNU1nZ0dXRDBNUENodVpzdWoyeFpWYm80SDNnSE1pczl6UWJYdmRPanZV?=
 =?utf-8?B?SHhMOUpOdmEzM2FPY1NXQnVkeFJ3SndlV1hpb2dxRjlMeEZhUG9scHlJZmJM?=
 =?utf-8?B?V0hzR1p0Y3BPckY2ZzVxOG4yYjU5dEdmVTRtMlpuM3dUWHlhbEQ4RGJJaUVS?=
 =?utf-8?B?b1h5M3oxYS9UaW05Qzd2bzk5eWQ1RnlUbDBVSXZzZlY3UGVGaHEvNDBIOE9h?=
 =?utf-8?B?VEpjeG9vL0NSQ3Q4eC85Uzh4T1gwakNXTVZyL2hsa1VvSG1BT3ZMWVBzUlB0?=
 =?utf-8?B?eTZMWlBGMzJ1NUdyS3FmaFhPSzgvQ0N3Q3AvUmpIZXNhRHJlV2IzMUhGTHZv?=
 =?utf-8?Q?n08oLUmBmoI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFA5eDFIYWhrRGdSWnBTd1BpdnJhODF6WEJPMUduUEI0WUxqck42d3N5Y1hn?=
 =?utf-8?B?dytWdy9LOGVwVXBjVDZHSTdOYTFyNzJUMXNhSDQxSm41cVdxYy9zT0FFTTYr?=
 =?utf-8?B?b1hGM0pvdXJzWU0zSjRwU25wU1NvSys3d3VTTVM2OUptaUV2MUp2OExpRWlH?=
 =?utf-8?B?ckJsL0c5cm9DN1JFRXZrRnE0ZlU3RlEzNlFYcmdZNEtEK0R5SUUrOFFYaTJh?=
 =?utf-8?B?M2tuYkQzVWVVREJ1RHNsYlA0U1BiVzJiM3FqYlkzK3hVcVNmTFB3WEw3T0RR?=
 =?utf-8?B?NVc5c3Q0VzNJeU5YY2t1SFZLZ3RKNWxaenJoVG1rZzhjNXdOQVJXWXgxTVda?=
 =?utf-8?B?ZTFLOFdjWnZYQWtnSXpuTFliYzRKVzlkQzRjNnU5RlFUdG80YStuM3RiRzhh?=
 =?utf-8?B?Y1JaK1hNanpkUWpSTEo3RUpGYWMrczhJTGh6RDBFdnNNNVpKNENlQS9ZTzll?=
 =?utf-8?B?YU42ZmtmVEQwZGJtYURPL1RGbTR2UDNxSHJ4ZGJwdWlNSCtISVVQdmZidnFv?=
 =?utf-8?B?VmphcmFxRGsrbW9CeWNxUkp0clA4OVIvQ0RoUnkzT0tnZWttQk5EdEZwTUtl?=
 =?utf-8?B?dUI5aGZZbDhuY1dIYUI1QUJQejJubnlMeGg1b3NnWVZ6OVdmTGZ0UXJzeUJF?=
 =?utf-8?B?WTljRkV3YlVJTjM0R2dObkQxODc3RENCWG9OM3pFZDlReS94V2hIYkV4b2pv?=
 =?utf-8?B?cmZZNWNlZGx2MVphMk0rcG1nSTFaQ2t1MkkrM3U1Y2FjUFFzckhISjhSbldt?=
 =?utf-8?B?N0s0TGZidzA4THFWclI4c2JMQk9ONlFJNngvRW9lQTIxMjBOQVFxWkFMWTJF?=
 =?utf-8?B?RC91cjQrYkVWYkRNWHhtaEZReUs0VndsWU5UTisvR2Y5VlVQSmdRR1cvSnRX?=
 =?utf-8?B?dU1sUUtnRmNuK1U4bEM0ZGE0TGlvTWlid3RUTVJ6WmlQUG13ZmE1cXNLd3Bj?=
 =?utf-8?B?eVFnMS9SS0x1cG5VUk9jUHpHT0lIZy9BZ2NjSzBuMWdES3pUTnIrYnJ1NWtP?=
 =?utf-8?B?Y3pCYzJRVElTdnZobU5zWVVuY0ZKUmp0VmxIYVJHbXNkbmJESHl3b21iNGVD?=
 =?utf-8?B?cEdTTHJIQitaVFhQd29GKzJwMm12dE05WTZnQ1dIeEFxNC9iUXlMN3ZOU3hv?=
 =?utf-8?B?a3MySjVyaGhrYXR0MmwyRkFySkJhMGRnam5IYU5ScUQvMG8rTElKeVR6TlBv?=
 =?utf-8?B?NnJ1MWFuVCtPcmJFQVBsMXdSR2d6MFU1eGtIS2xwV284YVBTQkZHeFpEMStW?=
 =?utf-8?B?VW82Q2JlUmZhVitzUkg0VllRekxLbjJMQW1PSlhSVFJwa1MzclczS3Jhc29G?=
 =?utf-8?B?ZHlySnVIK3JxUjVvY3ZQT3U0R3d2eExWZGErVGkwOVlxYURnRGlkVHhLcVNQ?=
 =?utf-8?B?ejRRZE5vVmRRZjBkR3lIc2Mrek1wQ0plVmFOUS81cVE3S2RZazZlRlFocGFH?=
 =?utf-8?B?K2NDd2pDNjhLWU1UZm1ta3A1T1Z1dHlYbmhLZXdwc3lmS2VVdHJ0Zi81ZnlK?=
 =?utf-8?B?R2UzdGRjNjJ5T20wMjc0dXRHdGJmdjRhc3l2bGc4TEU4ZzA1V1NvN1FpUkZ4?=
 =?utf-8?B?eWIzWHA1YTdvZ2taZ2JETjVRejB6Rm9IMEFPTGtRU3VkRXM4ZkZURmIvVGVo?=
 =?utf-8?B?VUNYbVFSR1ZNY3BZSEs1bXYvN0RUcVd3Q2QyODNGZlNKYVIwQ0c3N1M5NjRu?=
 =?utf-8?B?VlV2Vm1rLzRxc1VLZnZhMlhXSk5aZE5UVUh4S09Gbnpya1U3Qm1jaXJveHpr?=
 =?utf-8?B?L2hGSGRhdXE4TVRlNCtoS3loZjY4R0dyVlVJcWdCWVExYldxVWhvb0JhT1FD?=
 =?utf-8?B?RDhtREEzYjJVWEl2WmNEbnlXRVlGQm9XRE1oVFBtZVBuU3dFZ05LaUxSRTlU?=
 =?utf-8?B?RlUrV0FQWTVUNzNTWHYvMTdLZjA0cytYSm43azE3Y3NpWUJPRmRzRjkvQ0FV?=
 =?utf-8?B?UUkrV2xCeHlnRUZqS2l6TmJGb0xmcytDZCt1Q0tMcC9tdElVVWhQTHBrN1d6?=
 =?utf-8?B?bWtVVzBxZmg1QW9UQXdxeUY4WURuSUw1c0l2WnJrTUlSQ2lVdmt3THpKV1I4?=
 =?utf-8?B?MWJtSGNZbE4rdFhqM2lreG5nbDdVazZYWS9BaWhha3g1S3JPYm1SdmR2S2tB?=
 =?utf-8?Q?Wxsvvxg1RtLOpS9LltXUMsMS+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40a7173-f9e0-4729-278e-08dda8212387
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:17:24.2451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9N6Ym7lJMgrAuTAIJ6gK9ENClBSVP7/Tkj6QKr7AjwwURwqfATbHGJXhOdz+yP3bANaOLxDOIKBv7eOmSUZAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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


On 06/03/2025 11:09 PM, Jaromír Smrček wrote:
> On some kernels (Debian 6.6, 6.9 and 6.10 tested),
> there is a missing option for "TC recirculation"
> that prevents MLX5 driver to include CONFIG_MLX5_CLS_ACT
> in the compilation, thus preventing PF1
> from properly working in multiport-eswitch mode.
> 
> Fixes: 11c73de9ef63 ("net/mlx5: probe multi-port E-Switch device")
> 
> v2:
> - Added additional MLX5 kernel option
> - Fixed patch formatting
> - Added "Fixes" tag
> 
> Signed-off-by: Jaromír Smrček <4plague@gmail.com>
> ---
>   doc/guides/nics/mlx5.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
> index 30c40f767b..06c6e80f83 100644
> --- a/doc/guides/nics/mlx5.rst
> +++ b/doc/guides/nics/mlx5.rst
> @@ -1713,7 +1713,7 @@ Supported HCAs:
> 
>   Supported mlx5 kernel modules versions:
> 
> -- Upstream Linux - from version 6.3.
> +- Upstream Linux - from version 6.3. with CONFIG_NET_TC_SKB_EXT and
> CONFIG_MLX5_CLS_ACT enabled
>   - Modules packaged in MLNX_OFED - from version v23.04-0.5.3.3.
> 
>   Configuration
> --
> 2.39.2


Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

