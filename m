Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466ACEF06E3
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 13:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97F3B402DB;
	Sun,  8 Feb 2026 14:39:50 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22]) by mails.dpdk.org (Postfix) with ESMTP id 4598F4028C;
 Sun,  8 Feb 2026 14:39:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe3hf6zMMLaksoYWTYQPLzYzTor6NVgdHTP70ksfQhlxHgbWX3Wl5cognwbgdgXnk1gQzZkAXfvP6qn1PhSIltiHpD7tn6Sy/MmzelToximvhwbtdVtmvkDM1fzrY5mnAup25EyyGXwFOQG0V38g1CVxWQIWwBknvt2y8W2o43js6nsH90zrFzUQzVCaYKLtqF0PW3fob9UmGM2tVW4cLYyxRsmHicRlLtgJm08TQWWMoRuRIh3OpEvBkKked/JezD4kg3doAqaHSmQEtXPJjWFL1/JN83fGZDKZbffT2cpM7GLMFYZ8qOGkIpZFbQfEV5PClJrsRktDMM9+gMFyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR0SFTsGJykkeceWJkjzOippByE1pwXw3LPqcn8Z+6o=;
 b=wK8/5+i6BVvj4u4bQBWJaf9J96xuigrqQDl++Qyu0Z3u9hvnx1CkoHu3+D3llxZ6eT8yEyJyhRhEZmFoUel+KCFMYwqhycMAqKEvVOvUaw7VLDgmuZ7ZmnZyWMy2Z8IqOZaQjfWhcdROdxGWA2OdlynOo+NcHAYvZVTATZkDsYWrQCPdTRavVOLXXhiVcg/e/U7r18v/ERfYWWlLCqNUgmf9w70zpt7KdW9+gSh1hQxf6pMo3muFm5zmTNtRxT71Y1+X3wFhMVLVjdE4l9n3bfAcRSeDhI2oTtklewomxOZRv0Li9gdFqbOq8q/SCG5wGepZ+twzTBAKW46sTVCzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR0SFTsGJykkeceWJkjzOippByE1pwXw3LPqcn8Z+6o=;
 b=nlwT0tZRct54sVeOxktNJ6usQjumHnj1hVi8mCgKgJ52jDbwRDL6FJ6kz2LPTo2nyGcRC6jO7uW/jPv/awbVyGhwX5f10rkMty0MVPqhC8VBT4MyMBP2xbMcZsz/w3z02RGZYpPd/bVVUc8yCdSIu2FHp9pbV6nmuGu9GNiW07HBkxz+HyNyFqj94O59nMEMYgJSS77i1dC78fHWneeilnYmBiUo9XaykrKpc3scfSkxawZ2LLwkleEUOdjpRzH4RoYpy4UjKZXlm/OUuef/YgRTp8u6cJyML6EqYKtfdqaex95k5OFDag9pax1WWGvtF6+hRMo6GY3d47GB9g21Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:39:45 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 13:39:45 +0000
Message-ID: <214f6653-361a-40bd-9d9c-5dd6a9eb9fb6@nvidia.com>
Date: Sun, 8 Feb 2026 15:39:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix flex parser creation length attribute
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com,
 stable@dpdk.org
References: <20260120080638.1976999-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260120080638.1976999-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb0d0ff-1e7b-4da3-905e-08de67178526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDZ2NUNwUmoxM2dvOW05M2QyQ3VrQ2dGMVlNYXp4QTZTVkk2OVlVTDA1cCtp?=
 =?utf-8?B?MkxCa1N4UmkvcFZsZDBSc3cvN1M4dG1aNVdmRHZWV1BnaWFVczl0N3hkblBz?=
 =?utf-8?B?c0UvL3NlODUyVG9LM3c2Vm1qdkRjU0kzTHU2MHZCMmh1Y1poY2ZaNURWTWNI?=
 =?utf-8?B?ZkN4c0dYQTVpbzllQUswWEh6R3ZROVBtZ0E2WkRCQlh2Wmk5MTllUzAxY3Fa?=
 =?utf-8?B?c0Z6WWJMdUJoTWs2c05QVHh0R1VGenI0Ry9xR2tSZFVib3NSQitFeUpUbWgr?=
 =?utf-8?B?d2NvYll6UnhhbUhzOGxYN2tqZU5xSzVyUCt3dU1hTDBHTXVNNFF3WWtTQjBp?=
 =?utf-8?B?TzlwcFpUMnFQWHhNb2Z5RTRmRlNSWDNpNERWMEpCSkovOGpKSnJzQXdmSTA2?=
 =?utf-8?B?blBQbnFiNVlyRXBidlhjdE1hU3RWTFVOUTR0c3hkQUV5UjY1VWJKaHdGVkE0?=
 =?utf-8?B?WjRHUjNBYVJSUW5XU2poV0ovdUJrakxkSEdTUitmWGZSNlF5Z2Y3THNnZHNa?=
 =?utf-8?B?a001Si9BUXBuVzRnTFJqeitOSFVkK2wzRW55UlBoZjlqT0FPZzZWdjJtc2gx?=
 =?utf-8?B?WndUL2dEcEVIdG02ZzhJdkpSbEFQL0NDUkVhYjNhcWhvUkJETUNGQ1FGRkNs?=
 =?utf-8?B?am1oU0ptVDFBd2J1RFVzcFZHZzVzSVJYeVQxVURCc2FZU3FvVnprRjJoOWFi?=
 =?utf-8?B?ZVBSZmNuSVRJczBrcTJad1lza0xPbTdWTFJyM2JCU3FCRWgwS05VK2QzL3JG?=
 =?utf-8?B?L3BTN1gvRnhMNVVkdENUdjUvS1Q1bm0welhYZ3dNNFU1ZkE0NTdwTzgvU3Rq?=
 =?utf-8?B?VEpYd0Z6VHE2VVJLdCtUblhnMjVuZHZFRHVPWVJpUWFLeEFPNXZEZ3AvWXpi?=
 =?utf-8?B?blpDMGhuVUZtbzYxT2JiZVVralZRRWUvVS9kNmJ0Qy9yT1c4SThSRGkwS2ZD?=
 =?utf-8?B?QzYzSXNYZFY1YmJyTEpodGlFK3Q4YnZWZEVyckxBd3RtZHpGVHhieGVBSUwy?=
 =?utf-8?B?Wk1CNXlRSWZPOERaN3pUK05wSWZ5akR3dHo3a3kyeHlPcHRnaEdmNGswUEdw?=
 =?utf-8?B?VVRlcEgwTFk2a0dEMGM0MXFxQU5NWjkzQmNiRE1LVXFpV3dBMm4yb2Q4N0hJ?=
 =?utf-8?B?RjUwMDI3aWdsRmcvanVIRWhsS2Fyd3hKOU85QXJrYjQ0UDJKMC96YnhuZTRn?=
 =?utf-8?B?V1YzUDltbXp6ZkpuVlJ5cUZlMDFsVmtGR3dOeHQydFVOQ2JkSjhML3RtZ0NJ?=
 =?utf-8?B?VG1OaisraVNzMjl4U0xHNEFYTWVCWEYzZDhyRGdORCtYL3JKRkY5ZVJEZC96?=
 =?utf-8?B?VVQyK0Jqc0xBUWlhRnRjRCszSzMvRWx1K1VlZnYwUElneG54dTdOeWRqM2p6?=
 =?utf-8?B?c3hoZk1qZ0JZT0VuV0dSNHdld25VTE9JK2E1WU5JV0didE9BVjQ1ZGFjWldD?=
 =?utf-8?B?STR2OTRuTnIwMnlCTDRWdEZkVGliZzZpdXNDaCtHS2VneGlSTUZuZlZsaVdE?=
 =?utf-8?B?VHd5c2UwTXJYWm5ReFIzUERFV3RaTjJPZ3lvN1A3QVNTNlFPOExWcDM4ckVN?=
 =?utf-8?B?N1JBczRxTW9MVTJ4NnYrSGlZY3JGV2UrQTVEYnhscGZsY29BT2N1VjZSZkdG?=
 =?utf-8?B?alpBUFg3LzVSdXNyMVNXbU5EbEJ3NFI2QzJLVEpQcTR3dTJ5eU8yWFFTdWJu?=
 =?utf-8?B?L2QxYUxqY3J6ZzUxZDE4c0xFcCtYMzcvbVRScHU1QnRVMTdCUUc2R2p5TkdZ?=
 =?utf-8?B?MFMvREwxQy9PMG5aeFRVL3owbWlKUHhUc25XSDRDTys0V0R6Q3ptRjZESG9L?=
 =?utf-8?B?aGRPejJXWkJaSVhwakhtc1B0VXNKRFc4UGMvWkVRTDd2dHBrWTVleE1nb0ZL?=
 =?utf-8?B?LzVLNmt5elhzLy90cnVGTjNjcEJJeUwycUZFcDYxMUl5ZElqN3I3WTlzZ0lY?=
 =?utf-8?B?K2s0eDk5YUhlOFFjRkJrcTJwa2N0alp4WkgyZTdNTHNhYVN5WVZ4TEtadlpO?=
 =?utf-8?B?WDI5ZnU2RTJHd0Y0ZlgvSkRWci9yMDJKYzhvajJuMmlKTjNLQlZ5YVN0OTQ0?=
 =?utf-8?B?U0p3TlhjWVlENWpjYmNneVdmTEJwV0U0U29xL1ROdWcyaFhtRWFjZU9PK2cx?=
 =?utf-8?Q?GC/c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3c1ZEZZbVBqREI1M3N3NHUwbU1ObTNEMzQ3anRRcXN0N2JNcGhEa0xxdC9k?=
 =?utf-8?B?QkZxL3hJbGhTN1FzdjRVWk1JWHZIREozN0x2TE1DQlY3MnN0L3kwVlZwbHRP?=
 =?utf-8?B?WExyaHlVYWRLc0lYdkJFWEliRkprQWJZT2ZnMjZhOGpwUStRL2ttMmJIN2Z5?=
 =?utf-8?B?NktpODc2aVMwNkxpSkp3V3lxK1hCNE5xUjlKUmhLbmNhQTR5OWZrbDVYR1Ry?=
 =?utf-8?B?a0x2Ri93SElqZUl1ZUtGNEwzVmpDLzBUVHJwSEZ3WkxCTXRZY1h6MXozNkNw?=
 =?utf-8?B?b2FlRW41alQ5RjVaenZFWldLRHRZcGN2TDR4V0l1dXhRTmQ0aDZHZThnQkxL?=
 =?utf-8?B?QUdKUjdoM25UKzA2ZXM4K3IyRmhUVzZVODJ5V3FRRGcxUHlKQWpRRTI5dDBB?=
 =?utf-8?B?NEozazEzT0R0NVdLcTZ3WGJkSFlzR0RTekpNMlJtOVpVeitpcUMzQ1NFZGpP?=
 =?utf-8?B?MnpEbmk5NEVaUnJBc256aHl6VVZ4eWY0WitMRU1CS2x3VysyaVliVDhtN09O?=
 =?utf-8?B?TGVHMmJlazdiVm9KcFd0NWgvNzVwN29zSzNBbWdBMStWOHMzZGh4UWNsYm1z?=
 =?utf-8?B?WjhwendKbm4relZ4OFZheEFOa3lqUXJ0ZXZPOWpVUTR1OHBQdDQ1NkhHR3py?=
 =?utf-8?B?VEFWSTdwN2RQNDZ0dVJkcjQraktBUU5oZFNjMENVRUhWVW84UHB3RXVnSUV6?=
 =?utf-8?B?Y2pTMW1EaU1EUFNwOXBNQzFiYWkwTWVTZlcvcTRLZkEzOUVubGprTFV5T3Qr?=
 =?utf-8?B?U1c3NEkzb3NMcXlpZUs3ZjkzU1hISzF5WE5ZS3VUTzBaZVY3c1dXOS9HbmtM?=
 =?utf-8?B?T2NVTWlxV0dEb3pERkxLN3Z4YXh5clJqTUIvb2Erbjd4d3BmNTJJMkdpemx2?=
 =?utf-8?B?OE5Ta3FtNENyS0VJaGNXQmU4aCszemRvdi9tWDFIQ0hwZVZ1VlhQYjFLMlpP?=
 =?utf-8?B?TTVKdlZxcDcyclczWStyaWVjYlpCLzVHbXRKWUxaYmtRZytCdFNPWE5PYzRl?=
 =?utf-8?B?YmpMUm5KWm1hQ0ZBM2ExNnI3a0VjYW53UExyYmNZL0tleUdkUWZvZHpGd1NY?=
 =?utf-8?B?aE83UTFBd1YrQ3dXWGgxSkFHdWFTd1U3YXhzQ2xuNlAzejVER3N6cHR2RGlI?=
 =?utf-8?B?WHdDVzB4dVlJQ0RmYWJ5R0xyTWNtUjhQbUcycVh2TlhnTnR4WDlvRDRUWUxh?=
 =?utf-8?B?WERsWlVWRVlvRnQ3VzlkaTZpd3M3VnA4YWFpTzd0VG1wN0Z6cmtpMnVPZGR0?=
 =?utf-8?B?d0R5bXU5ekdSWnUzOG5UY3RUSG1mV3lqZnB3VW5vcTNCVmQrZzFCYUd3RitY?=
 =?utf-8?B?NmVGOXdXUlU1SjZ3ZnJncUh4c3pwNTlnbVRpMXNDMHVBVmlaK29NUWRBdnRl?=
 =?utf-8?B?RWxkcjMza3BzclIrT2pmMXFRSzQwMjBqNnJOQ2YxVER3M2habnBaM2p3RUFK?=
 =?utf-8?B?bTlXaVM4U281bUJKN0tFY2lob2hXaU5DN3dEWUV0UXliVm1jM3JKZ2NBN3RL?=
 =?utf-8?B?bStYTW9RaDlZNW5ad3VrMEtNRktLV29SWjN5M3haeFdLbzBiN1AvTkhBNDRF?=
 =?utf-8?B?Q2FPbjJXcTYvY3J1UVZGUG82djhoMDI0b3BSMkloNlBuKzlwdTBUUlFrSjh4?=
 =?utf-8?B?SzQvbjlIYm5jNzFKRURvUm1xaDgvazFQQ2xWQTJ1d2M1RlNnOS9uL2NENTRT?=
 =?utf-8?B?OWpVdDF3Qk1jZk42dEpGV245TGN3Z2J3dU1USE9XQkY5dmxDT2pQZHJtMWhW?=
 =?utf-8?B?Y0t5QW5JU3B1TDlKR2RsQ2gwMXkrS3g0RWNWL3BnaVJBbGJRMjdHMEVzQ1pW?=
 =?utf-8?B?c1hJODRrRmpYMXNKZ3ZYc1BtYzhIQUJsUVgyTUljTm9XRm9iL1BFbU03a3Jz?=
 =?utf-8?B?VURyOVBNZWdwd3dDQXpUYlBOMStGaktBWk1vVFI2WnQ2MUJtNXkzRExjekZw?=
 =?utf-8?B?ZlNoZzRWeDBOa2F6d1pyT2dLSlJIM0VFZmR2eTRPeGNHODZXMXo2YW9ITXpB?=
 =?utf-8?B?VmREV0F4UG51am9DSGQwczNBSW5pVzNDVFhRVk0rdmI1NWwwMUc0YythWHl3?=
 =?utf-8?B?K09hdzQ0TFQvVElYbElZUmxzaGllalJBU0FDeXM0YUpTdFpicnJXZDBsQ3B3?=
 =?utf-8?B?ZDhQY0g3SHZFNFU2eitaVDBGc0hOYjd5TG1YcmJFcW1ZS1VLQ2k3NGUwMXhm?=
 =?utf-8?B?MmhYYjRsdzVJV0lBRTEvUzVUNDRmTmJsN1prT0Q5N1V5M2lMTFlnZ0VFRDdF?=
 =?utf-8?B?VGJPeUN2VVp3Q25Ya2pMN1FWNmpmRzVKcWJueGgxQ2tDbHpRaEFWTGliNXZZ?=
 =?utf-8?Q?OuMB7QeOlRoK5pW9it?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb0d0ff-1e7b-4da3-905e-08de67178526
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:39:45.1699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH1G1eFSheQQfUbVvbqNfl/P3XGwU8p1gxy10TVBNjisU8/EQk0EGSmAwoZ4SG4GgiMzzZJFOs6sLymIospZ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666
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


On 20/01/2026 10:06 AM, Viacheslav Ovsiienko wrote:
> The newer firmware on ConnectX-8 and above always check the
> presence of length mode workaround bit, regardless of the
> flex parser header length mode. The patch sets the workaround
> bit for the all length modes for the parsers created by application.
> The internal parsers for eCPRI and IPv6 SRH are updated as well.
> 
> Fixes: a2234609bf7e ("net/mlx5: fix flex flow item header length")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

