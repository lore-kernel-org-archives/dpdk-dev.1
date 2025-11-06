Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A74CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:16:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8257C402B0;
	Thu,  6 Nov 2025 15:16:07 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5]) by mails.dpdk.org (Postfix) with ESMTP id BA4A84013F;
 Thu,  6 Nov 2025 15:16:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAOk9cyJGGGVj8MlXvCd0yM11II8F95Vrcq4QX+TPcP7O3Hmxj9Hb9K2z2rK/sEu3DDqr0wko4cOnpkPxrHddds4CfqWWPdIbnYwt4kgCkoGI2rFIaGUCDBRz/dzcPSUnv5/UWEd2ebc0toE174x/xxnqs9Yi1XFe/EaDd/ReSTL92JfZ/xGGEMqTEPo8dsJNEFoBadBcN65AueTPj3+1zJmzqcLZLQJ8IHByHjYveqk5NcYiYrvoIfRUtlD9YOCNixxbZwirjoMUT/H/TvAf1/KI8ffbd9wEd2tDiDUASsjfHJwtdKeH5P9J8+jSIIih9B/JpEtKhxtmx79AMebZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S+D3oOftUs3QRM9AfptiZ1/ppAYJVn/YSkwCeez3TQ=;
 b=ZrfYcKiydgcShOETjciDqO8jsVqYzZDtFmCyrqPTUwZF2+fjtOU6pNrDknMSD6pBlW+Ic6kTRqZ7I0bs1uMtqJGdGml2Lhoj/lPlqLjkWf6Rt+R5sm2MAbd03Wpi9d9EamJFbNKS281H5qYg75poXVD8OQ3/p79B8bCMBvujgdfwmjRZ0t94h4M8q4exmvnm6uIpT1cRz9iPoovVsmVPaFdIoa2bYg2wCR41wQnm641vT0f9JqsOQr9QhNmXPrazzE9lJKdq2tBAN/564y2mjN0mGiesL/E2lMadgft7BBsRsDdPxOuorAWdpCcVOgnW1Ge2FmkCzWC+poblSzGPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S+D3oOftUs3QRM9AfptiZ1/ppAYJVn/YSkwCeez3TQ=;
 b=dbm1D8Po/YTHelpTrSX6p5dXXUqj38g8opsPHr6ORATCE546S2akVgF5gqL71L/e0iu6HlDIArCO8stuXRVhGQySc03HgY4Dev/x57nkb9nFIaecFIH+D2PoPjiniHoejRZ2Xkh85ZEL9e5B+Htd0DTVWeRc1geMSKFTMSnBQHT6k3j+/G7fNQEt6hMvktGyxv7RDsSN9ZDBvAKR9uMS4o+t1WEAjq6BLG+n05rF4AIXIbD9GYvpOEnwmzXErA7l5Z7v9vOJyWO5AmhXETMH8Cqc4yEsOGa9oGjyzlCYKMCZ1TjdV3GN0uQ9s4xq4ciY/FxqsTFQcusLEHCfkfvmEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:16:00 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:16:00 +0000
Message-ID: <91e2cc72-3552-4f7f-92d5-dd6dcd77e8de@nvidia.com>
Date: Thu, 6 Nov 2025 16:15:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/mlx5: fix indirect meter index leak
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: akozyrev@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
References: <20251105125433.468878-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251105125433.468878-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: fab420a1-63fb-4ee1-4fb8-08de1d3f02a5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0NxTUNUVGtISVdXUUwwKzBQQ1VTQWdKRGFqbzR3OFNrRWhmcE9ZUytLYWpv?=
 =?utf-8?B?ck1WZm5LZlptNW50VUdhK2VDeFRXTHUwQ3pHS2pvdzI3NzcvUmR5TGsyVUNK?=
 =?utf-8?B?Vm1Zdkthb1VKUmdMUnZxcVVmRCsyaUxMdEtLRk9pOGNtcDFNOVNtMVloM0Z4?=
 =?utf-8?B?b1NvZ3Q2K05BTjhUOE1YeTFmcHkraDZFN3h3dkgwNGk2alBRaU1XRGEwdjVx?=
 =?utf-8?B?Y2VCR04vSEYvU1Nhc2Vvd1BBS0o1MmFnVlVmL0Z5Q1d6eUFrZjF4RTFoUDdN?=
 =?utf-8?B?NVNRTlNzUzl3Zlk5RTZ5MFQ4azBmdFFZZ1pMRjFoU0Z3TDlTaGN5V3JVdDZJ?=
 =?utf-8?B?a0o2em96SEhkeFFycTlnZ05LRWQrTDZBamdvUExZNmRUcnIrTnRUMEFJaks3?=
 =?utf-8?B?MG4vd0JVNktHanV0N0FSQk92NzJ3ZytacVF2NmJXT1BYMWZqRStSRzZjcjhz?=
 =?utf-8?B?WURrQUtmSllteUpnOTNBUUhjaWhjSGhCcWc5amlBSmx3cCtDQ3E0VEROK0h3?=
 =?utf-8?B?b2RsRm9DVEJFbUw4UTh3K2gzMXRKTUJ1ZndISis0ZTQvQUU2OXQyUUd5WUJk?=
 =?utf-8?B?Q2RQOS80UENzK3pBRWY4RXVFVjNCQjZ3bG91YU1vS1JOTGJIU0drMjVzcXVt?=
 =?utf-8?B?QnJUK25ZaGJPNHFWY2E2a3dUVmJHMzJkbGovRmNkNnFqWEFRaVdLbmRiaVdL?=
 =?utf-8?B?RFFKRjJKbStWZWZVV3RaVWwzeHJhVXVGQ1gzVjBMd1AxTXNSVXpmWHFVR0lG?=
 =?utf-8?B?VThuWkE3bjdDSmIvV2VVUmlYeHV5MGhxcENKbTdkZHh6bTFvQXh3L2VSSHBH?=
 =?utf-8?B?SFpMNGxiZGhENW5naDltb2ZlMnR5cHVKam91K3ZFMEpmaUg3UzgvZG13UFow?=
 =?utf-8?B?NzVCZ1c0Z3dlSjdDM3NIRklGN1M3Y2NGWVU5eVpzdlRLQ3RUbXFIQmQ0d2JP?=
 =?utf-8?B?QUx6QmNWQi91UW1VUFQ3RzR4NDB0VTh6d2xXUGlUUlB6MUgvTFRKc29RL0hN?=
 =?utf-8?B?aVhoTUZuaVZieFZDYmVnOUxDSHF4UWhzZUkzMm5ybWZQU3VJbTVVZlc1SWF6?=
 =?utf-8?B?M3VHaElvOXdZVVk2MHBDNmhadFBKaEVKLzJWNVpRdS9TN1psaXZiRCtZU2to?=
 =?utf-8?B?cmt1SVZWWEF5QWxTM0hMbnhYb1VpekYyR0pxcnQxaEYwUVZmQkpvY05oYkt4?=
 =?utf-8?B?U01jNzVhS3Zib3NMZ2hjR0FQVDZHS0dyQjBvWStMbGVLRHVaOXZqeVpqM3I1?=
 =?utf-8?B?cGpkaVRPVjJvbmJnamJXWCtuOHg2eGZqRExXYktDYXJpeTBHUU1lZ0l4ZnZZ?=
 =?utf-8?B?N2Y0K2dlbnVqeW5XdXB4dTNUdTh3K1gyVDVtRllTbFNyVk5ySGFLMXNRcVd6?=
 =?utf-8?B?Zys5ajhUejhZV0x2ODNCM0tXak1VbGVHTlAzSW1lRXZkek90UmdpWUo5RytE?=
 =?utf-8?B?Z2RWbUpRMTJJQkw1NlFEb1czVGkrVjJjd2lZTU9qK0ZCSjFXU2xSMWduVm1M?=
 =?utf-8?B?L3lmeXlVMFp1enlZaVZkVmVaZk04YzdZZDN4M0hKWWlTa21DMTgzMUJTTk84?=
 =?utf-8?B?U0p3dkpZNm5qZGRDdElhaHdLZXJzTUpmT3E3SzBXQ3dNQ1hSekYyWFNnWm1F?=
 =?utf-8?B?dFZDRTVXVTFQc0V3bnpla3hvdkNtZHpGNUpUNkxxNFN1ZjBuOWFheTRJZy9q?=
 =?utf-8?B?QU1SSmJPbGIxbmxPSHlRSUk2STNVYjRjYmk5dUUyQVgxMjZDODY4MWlkWnRO?=
 =?utf-8?B?a25lbE12bE1qNkVaN2NoRXJOMzl1eVhUclNXak4xczNEV0hRUmZ0U29LdnZR?=
 =?utf-8?B?a2h3QXUrM0lrM3QvNDhPbjdJb1ZlTGdxM0xVTDJvMXY5aThKTkx3NkNnd1FC?=
 =?utf-8?B?WnFHRlJlRXAzays5T1Blci9reForZ2pmWDMyOHhNYzVkZWExZTdWOUdjeUl2?=
 =?utf-8?Q?sscxV8cGrLLLLRTyQm/2UPVDTwwyuewW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkRMM2V3NWZHd2tDaFVYSFJFTVNrV1dJYzFRU2M1aGhOZzIxV1FHaWdldDFm?=
 =?utf-8?B?bFVYT3NsdXJFUUV2T3BXSWR3OUppVW5XVG9SZVZoUmlqcExNT0Y4ZHM4S0la?=
 =?utf-8?B?THB5ZElxODFZVkw1TEJUY0U5SDMvMGpmWXZ2bjAvTGltKzlxUTQ4N1FFeG41?=
 =?utf-8?B?cEUrdlVpemt1MVRQN0xrSUdVZUNRUVk2U3l6UWxNU3R0ZjVtb01pMzZlMlA0?=
 =?utf-8?B?bjZBekxNcXlrc2Q2NjE4cS9ldjUwblh5TkQ3Z0FoTk90TVk1RFJXdytZcGMr?=
 =?utf-8?B?QlJjZHhzMVFSSGxUSkJFcVNQTlVzbDRnZG9oWHBNbE4wU0poMzZZVlpWcmtl?=
 =?utf-8?B?aW43RUxwWVZUWllBaEtXK2R4c0p1YXJDcDdzT2pCbWUxM1B5ZElXS2VZT1dD?=
 =?utf-8?B?bStoTUxjcENYVTAxcXBsbjZyb2NzellDSHZVNE5leFlpSTN5ZVFpZUVoNmZ1?=
 =?utf-8?B?cmJxZlhENkVhUjRhSlgwSDdlSmdUMldKbHc2V2c1UzcwSFhwYUt5NXdKRW9y?=
 =?utf-8?B?T0JvNmZ4Tmc4cXVLdkIzcUF2eW1LaHA3MmxKZnFYMVpqck0xc1g4T21vUlFJ?=
 =?utf-8?B?dUZOV1ltTlhXbjdPd2gvMnloc09Eb1dWa3hFaTQ0UE1WTGF2UE9GSEpCcHU4?=
 =?utf-8?B?MUNRUllOc2pScEpVYXM3UmF5WFJPUnpFK3dHNW83NE9pa1dmZnpFOWtLbmhm?=
 =?utf-8?B?NVppa2xoM21OM095RDFNTitPbUJZcmNQaG5rLzF5QlRBbG5RdEppM1lDbmRj?=
 =?utf-8?B?YzUrdzRURm5FNEQxQnNXWStPbU9tT0NsZVBnUGFkVlJvbVk1NmczTE4wVHJa?=
 =?utf-8?B?VUs5NGtEWDVlRFFLZXJlOW8vVG43RTNnVUF2ZzNvZUM3R0VYSzBndnhwaVFi?=
 =?utf-8?B?c1owNitZajVwcFJXN3VxWENLN2tUQXVFVlNlblMweHhJWnJHM1RwTlV4clgv?=
 =?utf-8?B?RVNrRnVQclQ4VkVGb21KcHhnNVVaSURid09NMkd0T2ZEKzZ4U0dud0ZFQnZ3?=
 =?utf-8?B?clk0TmNCOEdkMGZzZEo1UWpFREdieGlOdU4vM1NBYkFIdHNTbVdiZXVoc3dv?=
 =?utf-8?B?ckdQSm8xdVVpOE9CYnNkaG16NEhIdThIUDJkLzF0MFg3SldDeXpWUVR5Y3Zx?=
 =?utf-8?B?OUFTRXlGcTRLbnRkb3NMMVAyYW5XOVVLaHZhcVZXdHN0R0dMUHNtcHBCdDNS?=
 =?utf-8?B?Rk5ydjI1WC9XWFVOdy9JRzBneDU5WW8zbmhLQzRIOS92eVVPQlBTbTlrbkRE?=
 =?utf-8?B?V2g3cGRoc0VxaWlMSzlna1B5a0JzdndackRBczhNTGM3VHl2d2lFcEk1UVBu?=
 =?utf-8?B?R0Q1K1lrMjB3NFQzN1hjY1IwS2hBVFlUdFlMWHB5Ty9hcTJ6cmNQMndNdXl1?=
 =?utf-8?B?d3lPOUFzWmtWR3ZPU1lhdUFOM3EzNUdaMEJqMHFha25kUDd2Q2JpSjFEbllU?=
 =?utf-8?B?TGl0dHJVckFUUWdLY085c2VMb2pIblFudTF0ZzhwMGNtTTFhTytBenUvekly?=
 =?utf-8?B?amhDc3daQjRZcTBsV3laTlkyc1ZGMDIyNFFzR2FucDdXM3JMKzFSckJ3YWl6?=
 =?utf-8?B?RVZyemM2YWlaN3JyTUJ5ODFpM2xUVkI1ZTlIMmkxNm9aOFR1dFVOaG50NVAw?=
 =?utf-8?B?aFF0ZHZ4VFJXVWxnWFl2NmorV2wvZ0FoeTU5VnF3dVlEM2dOclppeDRVTEl3?=
 =?utf-8?B?RTlFbVNnVDFGRUFLTk4vUW5pZ1diSFZ6VS9vTXppcGlrc0g0VnIwMVZFaUQ3?=
 =?utf-8?B?T0E2dWhhMXU1bTdCSk5TNldBOTZ3Tis2cG9rdEZVK2d6a25QUWsvREd1K3FD?=
 =?utf-8?B?RFd5Wm9GQ0FmSUhFVkQ3dmxzTXJEZ3poODFjUEtoOFUyYkgxWHc0UnZvc2Vk?=
 =?utf-8?B?VlhJM1VGQWp4aGF3THkySjE2RVZHNE5FbmQwc0dyMGZBcjJoNGF5amxHcDc0?=
 =?utf-8?B?UFZYdmJSNllWSzJTZXJJTkZpMXltTmFLa3NBMTJTMDlmMlpDK0dHNlhkcVNs?=
 =?utf-8?B?ZVBJWjd4T0pqbTRvbWVkNHpicHJCQjBNQmJLWWNMRmozcXJ6RzJZcTlYeUtC?=
 =?utf-8?B?WHVSZ004Q0RrcW45T2hMeWlHYVlUUnFJSUhPaWtsYW1JN09RRlFXNjVON0Ft?=
 =?utf-8?Q?ofE6TbRizVpspxCsLGMREubNN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab420a1-63fb-4ee1-4fb8-08de1d3f02a5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:16:00.0825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5lDBsVPE1CUajwx1XPDgvjPuyWm4iFUjhqFb6VGCDmH01hfSUOTIxOP3Yi1+GnUeKOUd/9dB6KjD/mOuaXC5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477
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


On 05/11/2025 2:54 PM, Rongwei Liu wrote:
> When destroying the meter_mark indirect action, PMD
> didn't recycle the ipool resources.
> 
> Fixes: 48fbb0e93d06 ("net/mlx5: support flow meter mark indirect action with HWS")
> Cc: akozyrev@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

