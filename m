Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21785CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 05:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6251440E0C;
	Thu, 16 Oct 2025 07:18:44 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011019.outbound.protection.outlook.com
 [40.107.130.19]) by mails.dpdk.org (Postfix) with ESMTP id D353840269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 07:18:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsOvnL8mhPtmdQUFpzMCLXhOhNmdw4UMVqSxlfBfgQwLGL/KDaBW2ZaJkkmX7NkZBEzVX55M6kdJHkzBNeQ1n8cOBYwwph49T19Ja1OWYOgkZvlIpYHBi8PHRtGPu1lYMyrY8fng5uQTquVPMuuNoHEfB/zEOmxZ4HXhYQXO5ICZNyBqWp6lVLkkdvTTJSW0sX/mELvgaSpNrmyevCQnhxqCl7TRvSCoXolWPQEgH7wAxMX8qAZBuFZ0OqIZcgFeYpgnPvk5h7LbpjXqNaAuFXPyJEnwlSQBcsFzxLbRT8K408V6ixDNkK9Oy0aa2whywE+89Q5rHpA75amPpG3uxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS1/OtlERHJLDQP4FUCFQHftJw3i4BANRRtzq6HZoQU=;
 b=J87qosqZUXMp9PnBbNRY+J7wV7ZpLzFVvcOf0g8XHFsrjnQlYKryXffPBjbgeBFvGy9mNc6Q7yPvVu2GpbGApJxpiN1sMVrKzIjd+h6JF7nGenULBcV3szjvN8cxouUo/MyLAOQZJrlsTU8mRGoAqFV2EsaFe+i9uv7yZYv5HK8FkQzAvaZ9BfkFKm5N1YlRa5UKA7Dmms0omkgFa6k1IBAiQVLokiVX1C0bYKbxsyT4lqozViJznNMbANsY2MLS7OtWimuEezEWQgHLttoAFTlibP8viuERUOSDw4rpkG5ZnqUz0xFCvS474f1hcc0q0AKuUEqwFMiInksMO0rqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS1/OtlERHJLDQP4FUCFQHftJw3i4BANRRtzq6HZoQU=;
 b=NsizWPDsLnQ1X5JNLA0nZk3FFm4UoqHAjcoK4TQFAjds2sm+LLGhx0vuWW4FXvCgkgFIgNhXrEncfIAlvzKxBA6vZ4nK7pznn883wOKDja8FZYyx7zgXtPiwmBwkVhyg8IxefuT/lgJaxauTyNDsYM4C+0WFOGdpIwX0b08Nx1ZdPz8nGSV4qnBVfY+aqNjbEMFcfyW5F270qBo1CbzlMPkcTpHLz+YeCNs3Efg4+Zo9W9AhEH6lhorHixzC4rna+WZYtbXrKcAf213NyKHaZvfRq5+d1NO6LV+46xVtTO09AUgC/r9pavACft4yh91YUfjBK+JIs13OTTxj/BzBlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PAXPR04MB8639.eurprd04.prod.outlook.com (2603:10a6:102:21e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 05:18:40 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 05:18:40 +0000
Content-Type: multipart/alternative;
 boundary="------------bsyMcskh1y73lxFvq0S34T6J"
Message-ID: <7f81d9f8-812d-4af7-a9bf-973f3d1ac148@oss.nxp.com>
Date: Thu, 16 Oct 2025 10:48:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT 3/3] net/dpaa2: make total rx descriptors per device
To: dev@dpdk.org
References: <20251015230933.875860-1-stephen@networkplumber.org>
 <20251015230933.875860-4-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251015230933.875860-4-stephen@networkplumber.org>
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PAXPR04MB8639:EE_
X-MS-Office365-Filtering-Correlation-Id: b06fef87-1381-46a9-9436-08de0c7377d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlhETEtTN2hWdDR0eTl4NDB5Q1JBWHMzVTlWQW5zRFZNeld6Nk1FV0RaUURG?=
 =?utf-8?B?N3VTbEtYdVQ1ZnpZL0lKZUxsYlNldWNYNTc4cW1FZGkyQVNNTUFCMWxYaVcz?=
 =?utf-8?B?aTV0ekRCSGQ5NlZib0l6aEY3RWFNY1YxQTA5Z0VOZnNkV2ZKdVM4RFZ0SnhD?=
 =?utf-8?B?RVF5SnE1VDBNRGhzQlNEeTNLNWkvT2ZZdlJ2b1BHcS9WMUZmTFB0R1BaWFpM?=
 =?utf-8?B?UDVMSWlIdlpvV29adUplU0pEY0xvajRPVHFGMm5SSnFnZXpndnlZMnZ3Njhj?=
 =?utf-8?B?L1VBSDVLQi82RHNIcFdCS2cvN09tdWpLV1JPYS9xVUpnZ0hqd25PcnNOZEx0?=
 =?utf-8?B?bHFab2U1UGFiZTczY0ZvUkUyNG1IMlk4UWlJOXpER0F0cHphcnpMa0RYVmJI?=
 =?utf-8?B?R0xHb0JtUytxTDFWbTA0SzJJZGk5Um00N3hCQ1R6UjhLNFY0RU5JYjBrTkVV?=
 =?utf-8?B?RzU5V3BHZWpRcjhFZ1pZdXBGR0tkbHR6MmdBakJsMmJvUnQrUjRVRzl3Y2hO?=
 =?utf-8?B?cnhwUHFrYXgrckQ1Q2lRVlpVdnhRZ0JOdUdsaHlZaGtEcERTemRJYmxta0Zk?=
 =?utf-8?B?aGRnbVMzNWI1TGNkRUtpY1h3T0xiZ1dHdEt5dXE1TWRSVjZxNU5IRXllS3FU?=
 =?utf-8?B?S0FWN1JVWXFDRE1iSFl3YTkyWDE5R3FKRmk4V1pBYTlpaGw4c3lJRmtKZWll?=
 =?utf-8?B?ZGkzaUV5cVBsRlJuSmFWc3lheEZqOXhqbzllNmc0a2VEcEtXMG43L1M0VnJ5?=
 =?utf-8?B?NzN5V3NUMndUc2NQN2l3L1pEMGdWV252NThJODBZVGJqK3dIMUFVemgvK3k1?=
 =?utf-8?B?cW14QzJWY0VXWU5XY3VEZWowUFdzMTd3cEpVZ0F4cEVwQmlaVHBGZ3hxbHVh?=
 =?utf-8?B?ZHhIS09wQWdyTERzWUtUWldkTXRMU09seHhQWEU4eG50eGMzM3NxdEhiR1lJ?=
 =?utf-8?B?clNwZ3dpQXltZWNhWUU0dG1MMENHczBLWEg2Y3lwd1Y4eUtZaWkvaHA4QjBZ?=
 =?utf-8?B?YU5nWHVVaDZTMzFpNG1BbXVSTnBLYS96eS9rR1ZBeTFHd0NFT2JLeFBBSXhq?=
 =?utf-8?B?T3B3N1A1MEV5WkZtU250WTF6WGUvc1Zpc3YwTWE1MnhzSW1rU0FQMGNuQjNQ?=
 =?utf-8?B?SXlXUFBJblNLOFVMWWRDTkx1WjBuNDlFcXk3M293VFpVa1lJV1oxSFFHMWh5?=
 =?utf-8?B?TlVRWVdwdWJ4RkdaU2pXTzAwNnhjVklyamlJNUVXUmw1b3RUSmpyU09pS01r?=
 =?utf-8?B?dlE5K0Z4WjZDTnJXVEx0WXM5cTFGbG1EZ0ZJQ2F5eTZaVUZRWGZ5d2NsaXhM?=
 =?utf-8?B?RUh3Q2hJenViOWovR1k5OVpFb2w3cGZoNzZZNGx6U1dZWTdiZUM5TWIrVW9n?=
 =?utf-8?B?M3NteE5Icm9hbW9wWGNsV05pMjdFbzdvNkNhWlFDMWZITkYwR1NwTkVUSm9o?=
 =?utf-8?B?Q2ZyK0R1TUtnd0ZlRVBEOWxBdVdSMTZmWXR4ckJqcDg0UDZhTnJ6d0FMOWE2?=
 =?utf-8?B?Und3Y0tXMStHanU1dlFLRUFtUG5aNElwWUs2c2NEU2o2ZGI0enQveEg0LzBn?=
 =?utf-8?B?MisxaFdVRWhpYVFCeVhXV0t5Q3d4bWtEMlA2OVhQTTNwTGhhV0JBTWMrcFJM?=
 =?utf-8?B?a1V0SHBtQ1JWM2dPbGR1NUNjSDQwM1JsMDNUa0RUSzF1N09tUTVNMDJtUWtt?=
 =?utf-8?B?cWNVVXhVbHhpOVdtdzkrN09rR1pYRzA4ZTByWTBsQ0JOenI2ZDJ3MTNiTkVr?=
 =?utf-8?B?OXpEZ1FSWnNndlpGcWxDM1RuZFphek84bTU5MFQzbS96OFJVT2xXNlZHcEhp?=
 =?utf-8?B?WEJoMk84Y0lRZ3U4YjJvbHZYM0NVRUtDZEFJRkJCeTNwNWNJT3g4QWovdGF6?=
 =?utf-8?B?RGhqSDlsL1dvMm8vWHVvdFoySHRzcytWMVE2Y1YzK1BCL0lQRzNxa3NTUk5H?=
 =?utf-8?Q?pZJ0wvotKogM8tT43fCI5UHc4iq/n3Zm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVyUDhyYTZKeTVzOEp2V2lEcmN6SzVGT1B2VWlndTA2emVzTERCMVhLeGpY?=
 =?utf-8?B?Y002dUFYSjMybXdVU1grR1N6RlkzRmdsSHpwdlI4Z2dhWnduTjVKWVpadVJq?=
 =?utf-8?B?cVhpV3hKc3lwb25pWmFYRHQwa2ZtNVJlYVcvZ0ZtVWxQUWdhZmZ6NThqdCs3?=
 =?utf-8?B?eHZsU0hFUzNwVDFUdG1hZjFpT3Y1akdzSFlBeXZwdUljS0VIMWZLKzRsMGIy?=
 =?utf-8?B?UXN0U3BKWkpORndCbGhHWVliTkh6NGM0UkNJRFk0TC9KTW5leFJOSVREZ0RR?=
 =?utf-8?B?L2JlWUgyZlNlMnRRRTlWSUVLVlBVNnZteGppdlRCTkMwT0pyWWJ2bG9QdS92?=
 =?utf-8?B?dDd0dTdmN3luZVM2QmNicGpUZCtDQkFzRDJHZnBkVHBDVVFPWm1aTjNaMGtW?=
 =?utf-8?B?eGRvM29GNzR0YzI3Q2FzS0dHY20vbjRtVE0zc2VtaUEzRGFOSkxyMThjZmov?=
 =?utf-8?B?Z2RFVGdlVVVrQXVQeFJ3STVxQjU2TDJ0SktkRkMyakJseEVlelg2RWhqV2E1?=
 =?utf-8?B?Nlc1bWhrMVNnalR4VURBYVZ6YVBOM1MxNElYeDl6UFhEMERiYlhocVUwYmJD?=
 =?utf-8?B?RlRVS3JUU2lkSUZOTHlJYUxWVDVpbUxwbWtJTmpwaXJycytsY2xGN0NJcDZm?=
 =?utf-8?B?dDVoVzIxVENrK3ZJTkhJMHVuYlJHMlo2ZVp3NTJLWXZCVWpuK0twTkJ3dEhU?=
 =?utf-8?B?QVY1Z0lGV2FMS05RTmhMZmg4MVpVMythTWVHM3JqY3dNc2RpZzdYZFFrNVYx?=
 =?utf-8?B?SVpSa0F4b2tiOVM4M2IxTWVvVzhoS3FLOC9rem44OG4wS1IzR3l6TWJmMURW?=
 =?utf-8?B?WEs0T3pYYUFMeUpPL0tzdzNtVUkyTEdqaW5UNUs3bWg0U3h2OEV5b0N1bk5q?=
 =?utf-8?B?azg5Um53T3NaVzJPbTkvdisyZnV2K3Vldm5HdC85TzMyVGpleHZjWFNsWUVa?=
 =?utf-8?B?ZFpKNHlXcXkwZS9LQytzRy9IOFJqaUlYdnQ0MWY5cFRzUUR3ZFUrM3M3cXFu?=
 =?utf-8?B?dFpaZ2JKYTJTb3lTaUwwc2xjS29PUGFMbXhyS3RvSDZCWUtqOTE5S0ZMMkJz?=
 =?utf-8?B?dzVvL1NqU0svT2ZYbXZKR0lGTllTaFZtL1lacGZMc1diNTZHbUwwVnhJZEcw?=
 =?utf-8?B?dk9oaEpMWjByNlVmVW9iR2xVVnoyamJZK1BWK0RHdWxWQkJ1c2xkdThZMUNm?=
 =?utf-8?B?UC9xSUZQYjlRWXZha0twNWg5dnBJVmdaZkVRc2t3U0lseG1oSVN5UHM5cEFn?=
 =?utf-8?B?WVBLaUFJSUdFWWt3VVorUHFNRkhIWGFQck9nbXhNNFJNcEJ0WDNwQ1FvTkkr?=
 =?utf-8?B?cDNrMXp6SGdVVXB2RHg4MG4wc1lIazZPcEIrakI0cFV3U0FGVDc4REc0SEJ1?=
 =?utf-8?B?alJVOXZuNXJSWHpNVWM0Z2wyaTlGZyszZDdKUFNUNkZRNjF2THJ2T1Y0UGVl?=
 =?utf-8?B?S2JXdTBYQW5KaGYrRzhkVDBjTFB4RHNSeWlFN1VNM3lSaFJpM3pRa0IydFdm?=
 =?utf-8?B?WExDYUM0T0tJbFFyNTF3c0d6SmhkdERsSEtNa2ZxM0EzRUpZVVFEbnhMVElk?=
 =?utf-8?B?eFhoNFdhb0xlb09rL1FnTGF2VzdZRHRvdTFxeEpCR3E0NkJVamdtY25qaERP?=
 =?utf-8?B?SjRjeWRDZlAyWU04ZVJmWTAvNlMyN2MwdEM0M2c1cm5ycHFodHpIc0VKTkxo?=
 =?utf-8?B?S0xObkxneE5jWHRTU1dqV01IbEtMSGc3QmxSOXVqSitpb3FXZ2xBbWNWRVcz?=
 =?utf-8?B?YnB2aGJKMTQ5bEo3ejhzRjl5aTBWMkJWSnFhTGpHU3V6Yzl2M0pHZThDSDlD?=
 =?utf-8?B?MnREb1FqbTg2cU8vY1RYV1pBM0JHSHQ4T3dZVE8xODRtVXFXNDNpTmNOSkIr?=
 =?utf-8?B?YzQxMWhUKzBpK1NqUXdlSkl5UmZpNGxFSXVUY09Yb1EvQzFsVkg5NnNKSjVz?=
 =?utf-8?B?NXkxREtYYlpUd3ZFOUthdWFVTyszbTJlR3dpUHVUSk5IV2l5NkVSSFExTUlp?=
 =?utf-8?B?T1VpYzcyQmdxZGFRdU1WcG9MaDdXZzBHNXpUMnJzVm5hb1hsSmkzTkZrRThx?=
 =?utf-8?B?KzV5cEN0Q1hBdytWTU5ISHdwTko2K21SRWgvamtjRE9TUzJZM3VscXlJQ1Ez?=
 =?utf-8?B?MjdOM1VPWmFjbjlOTFNWNHRRSzU0c21EekthWElGRzk4QmMwUHBvY29PdEdk?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06fef87-1381-46a9-9436-08de0c7377d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:18:40.7197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgzPdUVOoJljmkN5Txgz8AEt/TZ3g7YkXn71cb/MTV9XOOo9ReK7UbFJyRIt21HFrNc0Jdfz1EUUhI5ozudetQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8639
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

--------------bsyMcskh1y73lxFvq0S34T6J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 16-10-2025 04:37, Stephen Hemminger wrote:
> The limit on number of receive descriptors should be per-device.
> Discovered while looking at globally exported symbols.
>
> Fixes: 35dc25d12792 ("net/dpaa2: warn on high Rx descriptor number")
> Cc:rohit.raj@nxp.com
>
> Signed-off-by: Stephen Hemminger<stephen@networkplumber.org>
> ---
>   drivers/net/dpaa2/dpaa2_ethdev.c | 9 ++++-----
>   drivers/net/dpaa2/dpaa2_ethdev.h | 1 +
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index 41678ce09b..32edff0554 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -79,7 +79,6 @@ bool dpaa2_enable_err_queue;
>   bool dpaa2_print_parser_result;
>   
>   #define MAX_NB_RX_DESC		11264
> -int total_nb_rx_desc;

NACK,  However, we can change it to static variable.

DPAA2 supports two methods for allocating the RX descriptors.

1. Fast memory - low-latency PEB memory - The size is limited, so we 
globally track the number of buffers across devices.

2. Normal memory - no limit as they are from DDR.

This variable help in tracking that overall rx descriptor across devices 
are not crossing the memory limit of MAX_NB_RX_DESC

>   
>   int dpaa2_valid_dev;
>   struct rte_mempool *dpaa2_tx_sg_pool;
> @@ -720,9 +719,9 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>   	DPAA2_PMD_DEBUG("dev =%p, queue =%d, pool = %p, conf =%p",
>   			dev, rx_queue_id, mb_pool, rx_conf);
>   
> -	total_nb_rx_desc += nb_rx_desc;
> -	if (total_nb_rx_desc > MAX_NB_RX_DESC) {
> -		DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
> +	priv->nb_rx_desc += nb_rx_desc;
> +	if (priv->nb_rx_desc > MAX_NB_RX_DESC) {
> +		DPAA2_PMD_WARN("Total nb_rx_desc exceeds %u limit. Please use Normal buffers",
>   			       MAX_NB_RX_DESC);
>   		DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
>   	}
> @@ -1029,7 +1028,7 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
>   	memset(&cfg, 0, sizeof(struct dpni_queue));
>   	PMD_INIT_FUNC_TRACE();
>   
> -	total_nb_rx_desc -= dpaa2_q->nb_desc;
> +	priv->nb_rx_desc -= dpaa2_q->nb_desc;
>   
>   	if (dpaa2_q->cgid != DPAA2_INVALID_CGID) {
>   		options = DPNI_QUEUE_OPT_CLEAR_CGID;
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
> index ffc9ebadb8..aa3fcb9af0 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.h
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.h
> @@ -385,6 +385,7 @@ struct dpaa2_dev_priv {
>   	uint8_t num_tx_tc;
>   	uint16_t qos_entries;
>   	uint16_t fs_entries;
> +	uint16_t nb_rx_desc;
>   	uint8_t dist_queues;
>   	uint8_t num_channels;
>   	uint8_t en_ordered;
--------------bsyMcskh1y73lxFvq0S34T6J
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 16-10-2025 04:37, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251015230933.875860-4-stephen@networkplumber.org">
      <pre wrap="" class="moz-quote-pre">The limit on number of receive descriptors should be per-device.
Discovered while looking at globally exported symbols.

Fixes: 35dc25d12792 (&quot;net/dpaa2: warn on high Rx descriptor number&quot;)
Cc: <a class="moz-txt-link-abbreviated" href="mailto:rohit.raj@nxp.com">rohit.raj@nxp.com</a>

Signed-off-by: Stephen Hemminger <a class="moz-txt-link-rfc2396E" href="mailto:stephen@networkplumber.org">&lt;stephen@networkplumber.org&gt;</a>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 9 ++++-----
 drivers/net/dpaa2/dpaa2_ethdev.h | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 41678ce09b..32edff0554 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -79,7 +79,6 @@ bool dpaa2_enable_err_queue;
 bool dpaa2_print_parser_result;
 
 #define MAX_NB_RX_DESC		11264
-int total_nb_rx_desc;</pre>
    </blockquote>
    <p>NACK,&nbsp; However, we can change it to static variable.</p>
    <p>DPAA2 supports two methods for allocating the RX descriptors.</p>
    <p>1. Fast memory - low-latency PEB memory - The size is limited, so
      we globally track the number of buffers across devices.</p>
    <p>2. Normal memory - no limit as they are from DDR.&nbsp;</p>
    <p>This variable help in tracking that overall rx descriptor across
      devices are not crossing the memory limit of&nbsp;&nbsp;<span style="white-space: pre-wrap">MAX_NB_RX_DESC</span></p>
    <blockquote type="cite" cite="mid:20251015230933.875860-4-stephen@networkplumber.org">
      <pre wrap="" class="moz-quote-pre">
 
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
@@ -720,9 +719,9 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	DPAA2_PMD_DEBUG(&quot;dev =%p, queue =%d, pool = %p, conf =%p&quot;,
 			dev, rx_queue_id, mb_pool, rx_conf);
 
-	total_nb_rx_desc += nb_rx_desc;
-	if (total_nb_rx_desc &gt; MAX_NB_RX_DESC) {
-		DPAA2_PMD_WARN(&quot;Total nb_rx_desc exceeds %d limit. Please use Normal buffers&quot;,
+	priv-&gt;nb_rx_desc += nb_rx_desc;
+	if (priv-&gt;nb_rx_desc &gt; MAX_NB_RX_DESC) {
+		DPAA2_PMD_WARN(&quot;Total nb_rx_desc exceeds %u limit. Please use Normal buffers&quot;,
 			       MAX_NB_RX_DESC);
 		DPAA2_PMD_WARN(&quot;To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script&quot;);
 	}
@@ -1029,7 +1028,7 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	memset(&amp;cfg, 0, sizeof(struct dpni_queue));
 	PMD_INIT_FUNC_TRACE();
 
-	total_nb_rx_desc -= dpaa2_q-&gt;nb_desc;
+	priv-&gt;nb_rx_desc -= dpaa2_q-&gt;nb_desc;
 
 	if (dpaa2_q-&gt;cgid != DPAA2_INVALID_CGID) {
 		options = DPNI_QUEUE_OPT_CLEAR_CGID;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index ffc9ebadb8..aa3fcb9af0 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -385,6 +385,7 @@ struct dpaa2_dev_priv {
 	uint8_t num_tx_tc;
 	uint16_t qos_entries;
 	uint16_t fs_entries;
+	uint16_t nb_rx_desc;
 	uint8_t dist_queues;
 	uint8_t num_channels;
 	uint8_t en_ordered;
</pre>
    </blockquote>
  </body>
</html>

--------------bsyMcskh1y73lxFvq0S34T6J--
