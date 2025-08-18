Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDAFCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DA734026A;
	Mon, 18 Aug 2025 08:36:03 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by mails.dpdk.org (Postfix) with ESMTP id B1A8140267;
 Mon, 18 Aug 2025 08:36:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js169QUuCKv40TH6DJjTJ7EgdtPILXIEsz1rfJbRzcEyNXW9MdmOWHNTGe1r0CAj93jAJ7kUQPiKx0v2aX0IiLo01qkbDOph7SzKKpIPtqi4bcXYeteVqW/FoA+uqZaMlnB2fRQXJC9VQdkxnavSpkrBhaHuqNLrkT48/hMIFXmvEfKB4nlInmtu73sj50uiXA/bNv9L0ZzBXxoi+UswMueVvP9SqIeXfItV86x/obi/+O6Bij4j5HixAPQQgRTfIClSSeWPuvaUAvlL8SZqUbBvsVzUBwV+zeDgm3PX+aXFToy7gbYQbIf7Uum+ticRNPY4NUHAQ3uXj2nCtmkaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3wROLMIbOPJ/e8ClnYIqEdo8MURUE77ePYHs32gQiQ=;
 b=bqpF9FWpryvfdz29j9MG1n2X7VW7rxye+hXRpJpzUYrzSn9Emje06QfLB8aEgjJs46HuWo/80fVkpxMDS/JpW+P35HN7MVVZ2Kqxfz+DPS9ff/N5is0BekYW1kOkM5raEZQ2zLd/JWgb9/Ffl/cuDB4i3W5cZCY7VxGZt4/r9B2cZYpqplMUCPsNpSemU1l0YTCF1MJHgmQdpg99xhJaJptSBpmoR/yF9F+CpxQ6C4pgdKH02icAXesZ3nQVsDpzV5Ea2pJX5zARuaVf2BIxtQu/TdeK7qwp+dxvD5EP7CWXAEiOLKeZSD9Dl4DUvxM5VOlapEDBapJWZ9t01sA8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3wROLMIbOPJ/e8ClnYIqEdo8MURUE77ePYHs32gQiQ=;
 b=OXPzc4C2prKbNFLnhrHcy5gDhlmi9h1NgZVFfp/CuxzBvpeueRrWTmxZ4XBhx5iYin7NfRbG/h6KdlETI7vCZEV6B4N8N9Jr4rC1MaNFbXQ/y/68s4QOwY4WUWIAEhxyB6xK/iy/KZ8FDX2n0DK+8dlk5slzjp2sUvx/aY4izU22glhWEG49ufUTZpIXExO+gTwoGF+cm9/53kynllr32LVgDLTszbWZHquZLxv/BPKT6KEZxm136X1/cUs0zyxRVYcdd+w/+V7tzkIuC+EToSUm9fDqZGiTQ9uBkaXeDZOzP2Yss+H8kOtAyj2bQIIh4Aojl0SkEXqoC5ANF6Li+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:35:59 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:35:59 +0000
Message-ID: <3a959bf6-a583-4f32-8b61-54dcde6f0925@nvidia.com>
Date: Mon, 18 Aug 2025 09:35:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix double free in non template flow destroy
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
References: <20250807100026.157277-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250807100026.157277-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 20659bde-b1e5-4798-806c-08ddde217e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHdDRFhFQmpucExZbWZpem51bDlUT2JlT1NLbGhUS2lwSzFsZjVndzY2Wmli?=
 =?utf-8?B?djlrRkFHZGh2YnA3bXZidXZqNytwaklHdGhsYkxBZHJLbENYckRESW5iRXZG?=
 =?utf-8?B?bC84ZzAyOFBGV3BBZXVKeWpqem96YldCaUhDV0JFY3ZDeDF1dTdieVU3M3JB?=
 =?utf-8?B?N2JJVEtiQjdwb2RQanEwWW05RTFuUjBUMmhncWxCNVBUdVJrUEN4V3U1VHZ4?=
 =?utf-8?B?djZnQ3lBK3lXSG1RL2hlMEVwNXBkQUVVMHVENG1vakdlVDQ3eUd4ZjU4TlRs?=
 =?utf-8?B?cFpRdzcya1F2NkZSbVNTamsrb2FDTUlCRGV1UElLVGVXUUVyQysxcTRCSlFH?=
 =?utf-8?B?dEFRaW55SWFENDV3L2FmWnQyMHRzRTZNV0IyWGduaElodDAvNUJoWWVRZDJN?=
 =?utf-8?B?Q1U4WUZMeUlHV2ZGc3dxRitRVnpTQytSREFCVjF0TWZEZDZJcDI0RFdPdVB0?=
 =?utf-8?B?UmdYMXc2OW9GWUlZVHcwUXlqdVRSK2dnSjB0M0lHY1o3MUpKaHB5VXhxV1JV?=
 =?utf-8?B?Ti9ldDRMUk5jRGFkaGZodlVaeXByOHBlUUV3eC9yMXpqNlMwWlZoUFJITnQ0?=
 =?utf-8?B?UHQ4aW5PL1k3NDVUdXJuZDJhVUI5Z0N1a2o0NTFqSW9Lekx3MkE5eHZrRjRK?=
 =?utf-8?B?YTNTZTAyc1orajQrVXMvTTZJL0ExMEdmRHBsRE4wbEQ3RkpxNnBrYlM2U3pD?=
 =?utf-8?B?NDBHV1IrcDJtbjErbzFMRjRzVnhvdFNRUTVHMzVZSFEybkVvK21pYXFCK3By?=
 =?utf-8?B?cWJ0ZG5KTlZWSEpFdWR4VlVsc1JONFc0Tm55SWVlRVFrbnRucVJUVlVFUTlU?=
 =?utf-8?B?Q1dZZ3Zmc2VWdEdRMHBZeEplcEo3OEZidE5PK0lDek5xN0dSNnpXYWZ3R05C?=
 =?utf-8?B?akROOFRxTVNqV1lqdUFYdlVTSzBHdGJTYnhmMDRsaStsaldJYW12dDVheStV?=
 =?utf-8?B?WUFwdG1RQmtrejA3YjhkQjVmVDhyNVNNNS9MRVY0aWVSZVVveXA0TmZ1Z2U3?=
 =?utf-8?B?Q3l0V09hOXRXblQ0dDIxdzZxV0hkeE9xeml4ekFzWHZ4ZjVhaVc1YVJFOTAr?=
 =?utf-8?B?KzdYbU1QY3U0Nm1pNnFtMkVsSGEzcXdtUE85QmxOYzVXQUpnT1I0Q2N4RVdL?=
 =?utf-8?B?MzZHRmQvQTZ1QzNQRTBBT3Vsa2JXTnVlTGJidlIwWnEyaXh2aDBjSm9EUHZj?=
 =?utf-8?B?UVJRRXdjOWpweUVxSXBtdnl1UERVMHJaSklKeFhUSk1lSTBQK3MxNnBHK2tD?=
 =?utf-8?B?TzBFb0dneHZtTlYvN0FKSzh4dTRsSDJpOE1vNGRnWWxhMTRVdjEyYW5FWFFT?=
 =?utf-8?B?R1hsTWpla2R3NmJqZGV5UVFLd0RpcklSSmU4Vkk3YllOTU9NUlFScS9ZMjk1?=
 =?utf-8?B?QnNpRFlkaUlONklNanRQeXdYYjkvSysyK0srNU9JZlVnMTl3WmxDdlg3UlNB?=
 =?utf-8?B?Mk9sdEFhQWFQMjdXM3UraTQ4a2I4eUVLZWE0L0pKR0VtM3p0OXZnM2c4cjBC?=
 =?utf-8?B?WEFJc3pKZThXa1JFeS9lUnR0a2tWVmI3VDNneFVSbkx6UUxnci9GM0pFTDJW?=
 =?utf-8?B?cURZdHZZRkpzbjFsbEgvM0xZL0dHU25xVXZuS09IZVRSbU9NcklzZGFzZC9n?=
 =?utf-8?B?VWdTNytzcUI4YUc3dEpSb2prdE5PUURPcUlaUW5qNkxTc3FBRnRwUXU5dm1G?=
 =?utf-8?B?Mnd0TEpVUWJ4RDBNNU9JZHlWaldYYmpqdzdTWTU1NHBRZ2p2QWY3NWQ1b2x2?=
 =?utf-8?B?Wk13eGVsQlY2Zk1ZbFprZndIUUE1U3VGSW1SMGdkK1N3VTdFV0pCcUM4KzhC?=
 =?utf-8?B?Y2NjaVRMTHE0M1lQSVp2Y3BJUGRYT0I2dzl0ZEhlWE9vMS9kRlMwbVIzcXJo?=
 =?utf-8?B?TzArRnpiUVdwc3hKWWtwMURiVUZaK29hRFBSbXRsS1VWOHZyeFdrM053dFEv?=
 =?utf-8?Q?ocVutSv9NeA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZkdjZqYzhxc1VXTXAwK0p2aHhkYWI5QTAycnpmaUN4RzhZcGw3SzJtMmQw?=
 =?utf-8?B?cGlPSTVqNm5ISE93Ny9qc3MvZ0wxKy9JYjZrdG5rajNlUUhvTGlwb1A5OUNl?=
 =?utf-8?B?aHlTdmpZa3E2S2h2ajlKOVJXZ1NheTVuVFlabjduUDdLOEVMK044QTVmQndi?=
 =?utf-8?B?S1hWa29TYXpLdm4xZldHWTBXd250UnJQM01LUlJhQWV5SGRBdGZqR0dDL1A4?=
 =?utf-8?B?dDQ3S0xxN2NzVWtQVm5kOXhmSnpjY2lkRk91TEEzNTBRU3VpSm1nVUlDWVh1?=
 =?utf-8?B?a1hUTjl2MUp2OFBDUVpXdVU2QXoxeVdoYWRvK3hiYjRBYmxJNkZ2WXZQayts?=
 =?utf-8?B?T2I1eEwwK2V5SDM4RE1jTmczcjJtajF4TzZwZTFnZ3Q1L2J1dG5sNWtTZjhr?=
 =?utf-8?B?R2ExNnFhcE03V0twSkFtZmRtSUxkRlROU1AvZ0JOakVQeEJYYmo0dFpBYXhK?=
 =?utf-8?B?dGEybDBRL2NDZDZxUHk1T0NzaXF2alVRa1pPQnZLc0ZlUnZESXl1SUlVREtZ?=
 =?utf-8?B?dTQ0SWdwYXM4dEZ3ZjMzOWxESXFQb2NIRTFsR3hZbm0vbkp1dGFidE9vNVJx?=
 =?utf-8?B?bjEwSzhzaW9UbzhTajVKZTJVWUx4UWRvUU94OXMvSTV0TEtOOHBtVGdqYU9l?=
 =?utf-8?B?K2h5Q0ZqYWdsM3llSCtyc2Y1Qjl1anZRS0VvNFlETS9yaDQvRnFRVVdiOU5m?=
 =?utf-8?B?S3JYSDdGRW1UbmZCN3lpUXdjNWgxTFB4bEk3dXgyOCtublNVT1dXZlRCR3cx?=
 =?utf-8?B?WXIwaVc3YnUvajVCRzRrQWNzdTg0SnBzTldjbTVnekQrTFQyR3lEOHJKaTAw?=
 =?utf-8?B?cHJON2Z5ZlduUnBNaEY1WUQ2SWl3V1JpYjVHYlg3eUw0NGV6aHNPWGoxa0pl?=
 =?utf-8?B?VW9GMDZqL1hWLy9KcDdPaGlFM2pQQXRubXNBaWRDbmVFTVFUcDFaU0Vna2M2?=
 =?utf-8?B?a09nZjQ0MUM4VERsZm9GYlZORjNuSGZyZmlvVm5MQllRSjh6VnRKNnBBSldG?=
 =?utf-8?B?b29Pc1VuZHMvUUpSVnpJTXhiY1QzdmFJNzd1UjJHUFZpeXVZckFFMGorNXdY?=
 =?utf-8?B?WjNsaXlLdHF4aUJwNXdYVmxSUGZoV3RHTm9EcndJeERtdlF0MmZWTSsxTlU3?=
 =?utf-8?B?anlpbG1DSGIrZHlkWTRwV1hMa3R3NEdmeFRrd2JvcXZHb0hYWnRzR2ViZFR6?=
 =?utf-8?B?V0dncVFlRVlaZERzTmtmakRvbjIxclBXSEU1Q04zRnRxUkR0bGFVRlBHejNC?=
 =?utf-8?B?bXhjeFRMZTRqNDZKeElnQmJTcDdOc1FOMHB3enZSZEJKN0hOMy9peGcySExH?=
 =?utf-8?B?MkNSSkd5dGpQb0kwaEVvZ09yRnpaSDNYWXFma1JqbHhJdGRWc2JEMkhEZk5u?=
 =?utf-8?B?U2I0OW1LejJHcGlReVZYREVOZjEyNFZzOHUzTGNleS9FZFRna2xXNjV6RnB0?=
 =?utf-8?B?Ump5Vks1SVkzckhjcnNHczFXK3hrL1dTK0R5elNESVFuQ2N1SHVLV0tERFZI?=
 =?utf-8?B?Rkd2SzNzV3pLZDJiY3h5MjdIT0k1Z0xqNnprNWlZRGJHMWM3YUFwTXFqdW5J?=
 =?utf-8?B?YWlJM3lBWEdlL0F0K1V6Q09kajVsSkwrV2tYMWJFUnhldVZOUTBmeTVRanN0?=
 =?utf-8?B?am42NDNoT1I5bUdqNGc3YVlwSTZBTm9lNGFFS1NoUHM3RkZWcm9VMjNSMTlW?=
 =?utf-8?B?R2Rwc210VzBON0ZheEVlemRVcUVGcldEc2l3MmZvSjdOeFNnSVg3VkMxNFdt?=
 =?utf-8?B?djFrMmM1SDFqU2lhYlMvWTZpbXRuOUdhZU5LOWlnelZPaDh0UjVCUXMxckdy?=
 =?utf-8?B?MFY0N3JjOUt1QXp3SHo5dFArY2pHaUNJUmF6ZEI2Z0lTWldRdmt6YVZHSjVZ?=
 =?utf-8?B?NjZWNjcwYzNwaWFWRTlOYWlzQ0UvQy9qVk0zeHpsSHZsVDhSU1ZSWkhzemtp?=
 =?utf-8?B?S2lSS2FCcEp5RG05V1pIQnhFeUF0TVQyQStvSlg1cXgyYzMxcklzbllmcG85?=
 =?utf-8?B?RHA3VFo3YThHMUZlQ0k2NWtuSjVNTWcyeW05dHlGTFU3U3BwbjBkcGpjanZP?=
 =?utf-8?B?REVPYVRHQkFkMk9ZcnVvUzhObURwSGVRZkNBYmFCNzZYRm5EUjhhL1VheVV1?=
 =?utf-8?Q?bsr8t2MJHcN750Q+vWKHsuLFk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20659bde-b1e5-4798-806c-08ddde217e7a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:35:59.6564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC2NaZ02VexCYYxCDsFkF4T7BZxDQqzDTCNwo5QL6LqxqHBE+ZmjjVW96Gdtk5aDooBM0+p/lB69jh8ec4bYbw==
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


On 07/08/2025 1:00 PM, Maayan Kashani wrote:
> Avoid calling flow_hw_unregister_matcher twice when rule creation
> fails due to insufficient memory, which previously caused
> a use-after-free error detected by ASan.
> 
> As a preventative measure, clear released pointers in
> flow_hw_destroy to avoid potential double-free issues.
> 
> Fixes: b2845d51c748 ("net/mlx5: support FDB in non-template flow")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

