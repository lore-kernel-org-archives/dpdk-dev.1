Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED74ACD5BA6
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 09:15:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C79EA40674;
	Thu, 13 Nov 2025 10:15:36 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
 by mails.dpdk.org (Postfix) with ESMTP id 38B734003C
 for <dev@dpdk.org>; Thu, 13 Nov 2025 10:15:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x09BBHCq3/FnO0puAhqKjT2LYx0E6Go93Br3MHk7f8QKeFd83io8NedamB7R8GtkKJBsNhW+DL9UgloT+Wd6zNMLAK1cbwJ8OAyjMDDr61hiWe8z0Deefoq7oyT8ZylKJR0sgkuTnJdD3/C8D40MUeVKhlDFJCysaW6kSGAxQNbE2lS0JXRnQyecV/q9/iU3wmsXQ328bJdGaCSF9RwiNBnToLkZ91gz+NSK0dNkFGIXjOkDFRcOp2iL5bEkV8/8cZDA5gwY9BTvesTCN1A13Ic1hlFboO5DF6CoUhnPuTYp355w3/Gr7BpHdg17xGOg06KuyOy/MhFyQzG5HU1/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7zYA4AbJKRgy7JYkw0gzwBB2rkWwX25XFRJzclI4qY=;
 b=fHsz1yTSpY5ZclKJZGtYAcMw2lgqGAZpImnOUqk2r72yIots/EgNaIjpylsvB8P0Ccn7BP9UDMDikABkf9nadwVsW9wQEHAl/1H7TpZd19nwDQjAiMDlig7o0wHXJCtmOltzZb4qizEavuYHAplS0xw+0lQ/bhmIKThWeo/Ce8M9R4txOBNhQORRRrnajB/w+3dSHL0kGgLfgRtsi/XcNOuxUTsxQ3LpaKaHDaEDRZuhMjhqXByeMvZtH0jo2qkA52KftlOz3Nc8LTEnhHTjQy2hETYrurKREqqGqhfyvam6t+jGjEn5vMTBnkadPFiNncBRzQPWZuXl+z61lykvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7zYA4AbJKRgy7JYkw0gzwBB2rkWwX25XFRJzclI4qY=;
 b=GCUz6H1MEXuF5hUvi9DZE1/QoHQffEYaD3bXK1gY7BLly8vMKR9tRozbazUV6ojy/TxkScEqE/dYwvDC92id+QJX5d+uyvv3xOYbtrDEIjcHA2mfwD5gJZu3eZTZhJ+3/mcRT8f+Ztvkr0OqwDJoufTLLi0mSfVrRwo5mQQoJE8s79l9R5lGq5bxzSEGid6zPNgHe490JJt9bs+V738u25kjX7mDL6eYFyrN+1JaOPq/hJj2kSMK2ixFQh3EVznOss2J5ZHgBpkQdKyPth0cgwhxmkXY4afbYC/+D6rfq3DbQTau6JUdguFslEHv3g1m/i5DRJhgwWROfSBVUs/5fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DB9PR04MB8219.eurprd04.prod.outlook.com (2603:10a6:10:24d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 09:15:33 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:15:33 +0000
Message-ID: <1c6a056b-2215-4f72-9e90-c320de4528b5@oss.nxp.com>
Date: Thu, 13 Nov 2025 14:45:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] net/dpaa2: remove ethdev device in bus device
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: hemant.agrawal@nxp.com, maxime@leroys.fr,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
 <20251112091049.2669481-5-david.marchand@redhat.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251112091049.2669481-5-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DB9PR04MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6f71d2-ebb4-4dcd-b52d-08de22953268
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDdKcnUvbWExWkZVYnd0UzB2aUlIWVRWaXc4TzdUM1I0RTV6MmxDbnk1emdh?=
 =?utf-8?B?SGZuQS9EOEx5UVRzKzhzb05LY3RFTEYzQ0ttSWFzd05MTjJXWmtrakZjZEJL?=
 =?utf-8?B?cW1ROSsrUndCdTkvR2xMK2x4TVozVjloZGJlb3ZIMkR1STVLdGhvSnVHdHlG?=
 =?utf-8?B?TVdoUEJJcGNHYmtYRFQrb1MrQU92UzRTOSsrdUNnM2FJa1RQOVBaME1CTEoz?=
 =?utf-8?B?SEQ5RmlCZVBYYkNWY0swL2xva1p6K3VjOUZaWTh6aGxHL1lTUVZQb3VneGkr?=
 =?utf-8?B?bVBNWWlDQmE0NzlncGcydit5WTFVRFpOTTRCN3ZZK0lSTFY0MlVObXVFNDAy?=
 =?utf-8?B?SzN2WnQ3eWEySW1VdlVCZDYrYzg5QzRnU0Eyd1ltKzBTbklid3BjS3NKS21y?=
 =?utf-8?B?eXJCWmw5SWN1TVZDL2o1dDlmeVErbk5SeHZ2ZmVWSDNncnJ5K2x6UWY2Znpz?=
 =?utf-8?B?VHBiMGdEa3pRbW1vQWdQV0tuSE9iSGpXQ1A4SzdYY2trdVB6M01GWHdvR2lw?=
 =?utf-8?B?UHE2Vy9hTDIvMFBya3JROTZmWGVkcXVNSCtVaFRlNlVXRnNNRXNkYXVVUzVx?=
 =?utf-8?B?MzFrNHVHQkhoM2p3bDNTVmgySzZhWGlqaXJJbm9uVE9wclBVYUVnbmovclVB?=
 =?utf-8?B?b3hoZ2R2RnlON0c5N3RpODAvd1h1bTlLR05DZmI5WjcxUUZNYnNxSjhjYkE0?=
 =?utf-8?B?aFlEbDVxeEpzc1RxQ1V6NDdwTDNPYUZWQUlVeldmKzlRR3l5U1piQzJCS25j?=
 =?utf-8?B?NEdvVjVqLzNSRWxCYnBqM0hubjVrMHU4MVlYSlhTWVdIU2tsbldKTkNjRmVr?=
 =?utf-8?B?am54bjRUOW8rTHpWTXdiZzE0OVpwRG1lVHpDOVRzU2EveUFrbjQwQUxiMnRt?=
 =?utf-8?B?Qm1xRVRUSk1DUG9QMWMxZmpzeWMyN2dyc0lOUFd6T2h5RjVISHI3bWRkSDBv?=
 =?utf-8?B?UG1INkVkYW8wNCtGeXNyYUhNODNHYjNXcm43S002MG84VXM4WnlIV1JMRXkx?=
 =?utf-8?B?WGdLanJkd3RoN2s2Q2U4QmxnMEVmRTBjdVNDdlEvZFZOY29UZ1VQZzNZZWNw?=
 =?utf-8?B?Sit4UDNXOGVFMlhvdGREQ1d5RGpkbE8xSlRycEJqU3VMUDVvb1NnVnpVbjBG?=
 =?utf-8?B?anMyK3V4aFhuN1lDczEzOHpwdDhmRU9YYUZuZXkrUmkxRGJFNE5uSTBvMWxt?=
 =?utf-8?B?RldiVUJ1TnN1SmFVVnFrUFhJWjVSSnZFTHVEVVM2WlQ3NVR0ODNTY21JSlJm?=
 =?utf-8?B?dGFQbmx4OVhhVUNsaXVRbkFVL00wUzluMzBrWkNxTVBkZ21CUXU1akUyV3Y0?=
 =?utf-8?B?TDgyeUNuZ3VJTk0yZDJqVUF3NTRUU2c3bkhmaDRCTWZOMlUvV3hzb1lwaWZG?=
 =?utf-8?B?T0I0U3p4RUM4aU1hK09BVHVSRVZ3VTc2Zm9ZN1ZhM3RTNjgvcWZuMkxJNWUz?=
 =?utf-8?B?cTluTTlZN1RHWGxDQlArckhXOHN3aVBwemo4dk9OVGVXaldOd1JRT2hqNTFN?=
 =?utf-8?B?dWk2NDRRYWlkeW4zNWU3UndIQkVEMm1OZmVOMll1aUNXekZTVmc3T1d1WHlV?=
 =?utf-8?B?bHg1VlJ3WkZ0Kzh5SThwRzkvLzBjVitqeDA3K3ZUZFlCWG1RSWNETWYzVGlq?=
 =?utf-8?B?YnExUHBVQVFOVjY3RjZoM1pDUDRUWGdPTkgyaldYRVoxaVpwcnFUem9sNWRB?=
 =?utf-8?B?QUt6cnJHUkZFTFk3dnYwZktjK0Q5a3R1dld1ZHVPWnU2b2hHcHlZRlU1L01X?=
 =?utf-8?B?RjE1Z1lVa2dJM242SFplclhMdUc3YVN2c3pBQ3VuTDhVVmlRR0Q1c2MybVZv?=
 =?utf-8?B?VGh1VG5sUTF6QmdJSWF1NVFENURWdGtwekpjT2ZVV1hlODFzQXluMUNkWmYr?=
 =?utf-8?B?KzRkc0NGbW1rZXJKVG1rVlhvb0lWUDdmRGQzSlBuMzZ0cHhieitkTjYyd0ps?=
 =?utf-8?Q?ly9egrYErsdWHGUs5iNJ66j8v6vnI2PC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEdFdFhDNnF6dll1VnkwVDhNSXVhOTJjbTVjQllQN3NsYmE4S2YrMnpGRXRi?=
 =?utf-8?B?QzFjSzBrZUpScmhybjl5ODExZVROVGdNU1NGZHdGdGFQVTBXaFQxWDBZNTRm?=
 =?utf-8?B?SitGTjd3RlI4d3k3cU5JdlNCZndVbG5LWUZlRXAxdG81dU9IZjhrcFRLeFpX?=
 =?utf-8?B?L3o2eGtwWkVuQUZSTjhxc0JVTUJBVTJVRnFvMnE3QVVJR3pCblIrUWRlME9E?=
 =?utf-8?B?MmRBd0VRZWxmNmZ1cWM5dnBPb0NIcWxhZVlSSUM3cnZpNDBOSG56empPTmJ3?=
 =?utf-8?B?ZVh6c1h2VmpiS0dvMTRLdUJ2VkoxcjF6dnVVUVdpMlBUaW4zNCs2RmpTUExE?=
 =?utf-8?B?V1FBcGdReXY5TlB3elgwaGViREtWVEZLdUNvUGpGWll0R2lyMVI0OGV4WHkx?=
 =?utf-8?B?MWxMK1d0MHQvdVo0VndCMlNzSUxJZWM0MGdyTmZnRVN3U2pCWW1DYktvVURy?=
 =?utf-8?B?Y0JFNWN3c2V3T2N4M3lOaVpGQ1h1cjFpZ1RRL3QxZlBaUU90QlR3VjNtbjVF?=
 =?utf-8?B?UVl3SXp1WU1vSDhhOXNHajlsTHNDT2l0Rmw3WUZzQ0dvVk1CYnUxUFJ0bXR5?=
 =?utf-8?B?RG0rd1ZSL052Tm1qcVJJWnRzUktEaEU2bE81NXo5WXlWbStlYVlUNjJuZmNK?=
 =?utf-8?B?dUhTTlowY3BFb2FDSVMyZHVodGE2L0dWWjlFVTA1WlZFUHhsL1FlaVVUampo?=
 =?utf-8?B?Zy93L2pQY2xBNkRodWZGTkQybUxpS1JZdXowVTNzSjVZNmVCalJMYzF5Ry9K?=
 =?utf-8?B?U1FBazZYM09zUmxib3E2YXpXZUdjUTdyVUZDQVFLUisyZ04wNU5ubmdXUFpo?=
 =?utf-8?B?NUlaeExZK3BrNUhGNVRaWXBBTU5WbEx3REh1Ukpic3N0M3dMQXZROHAzbk1M?=
 =?utf-8?B?QUhoVUYzdEZtc1N4YndqUmsrOVFWVktJcDZIU0RQTG9rdUJlVDVVY1FSR2FY?=
 =?utf-8?B?QU1YaTJKeVJ5dXFOM3pRZkR0VDlGcUJ2QjlXUERUYVpJUEpwd3QwNWdSYVhj?=
 =?utf-8?B?ZkhTbmxsa2dvYTFsWG9xK3RmemlzaDNTZkUyeE1OVWQva1BleUt4a2lTVmtL?=
 =?utf-8?B?TWVOeUUwUmxuNGtBRE8zYzIwd3lPTFo4QytaTE1rQmdpN3Flc0xlZVpFUFkx?=
 =?utf-8?B?TFFtdHNDTGdZblBuYllrbWo5d01XWEJNZzRSK2xmd012ZExhZit1SDBNTWxF?=
 =?utf-8?B?U1ZPdjFLcWoybVAzRnhLWEVYZGlWdmtSMEsrWXZqOVYrSVNRQXlKRVJjbTlW?=
 =?utf-8?B?cG5tUmU2Wkt0TDFFRVlqTDRrWDJ3OHVJdkFWV2pLRnJHTnhLVC9UdDJyZzdL?=
 =?utf-8?B?ZkxudFN3K2tvK2VmYzN3a01EWUdwRFJDczg4UXh5bXlmN2xOZXhpTHBGczdt?=
 =?utf-8?B?UGxKTmYrZjJldnRKRGVsNDcvbnBwdHJCTUM0VEpXMllDUUNKRHJIc2dxTHJQ?=
 =?utf-8?B?cXZ5ZDl0TzE4UjhlYS80YjZuemFvU0E2UkZLUVd1a043YXF0emJiVW9kTGZ5?=
 =?utf-8?B?dXdQaTJaS0swM20rc0xmK3NJeE9qTmVjd0lSUnEwazhsWUxpdlVGcWF1bjB4?=
 =?utf-8?B?a2JMcUhrd0pBRWNHQjVCbFI2eEl2R3BZNXh0T1dMTmIxTWtqSExrbzBBTjVE?=
 =?utf-8?B?OEJFQzV2ZVFNRjJHWEcxUVU5OFp4bUhDR2svS3cwdFpuVElLOURnbERpUjk5?=
 =?utf-8?B?MVIwK1hzUk11S3VHbWZZanA1NVM4Qmt6WXl2TGVoOG9GVkxzM3N4bGF3aE94?=
 =?utf-8?B?Z1F5VU9RcGo4UEV4VlJoRUczaDRucUxTQU0rc1pEQkxrSjZtM0orTW1vYWMv?=
 =?utf-8?B?dXhEZGl6SXdkTyt6RHpXSFFDZmhEcW84UDdZdTR5cDVoZFcrMTJqaFg5ODg3?=
 =?utf-8?B?OHhiRndnUm81bDMvU2YyU0VrdG0xS0VWQ2V1dWdyalhJZGF2SlorME5iMXh3?=
 =?utf-8?B?SzJWWDZiTEtQSVE1WlhsQkN4WmQzaFdCZVBCa2J5RzViZ01TM1J3am84S2t6?=
 =?utf-8?B?ZW9jYjRsaTFqRERvU3JsZ1YvTDdkcURuekUrVzl0bHk0SGx3L0txMTZDbXgz?=
 =?utf-8?B?S3BvSHhrcXBNN2NnbW5jQWJ3RjVjQWVYTUR3Z2JZcmllRlBORXk0RDVGWXVY?=
 =?utf-8?B?ZE1tS3ZYZHd5ckd1V0JMYStQSFU4anNYMUpjakgzOTJ6bS9sN3FYWll2ZVh2?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6f71d2-ebb4-4dcd-b52d-08de22953268
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:15:32.8691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4tYNnn8Of5E/WEbsXEkzAwlMhNS6KoCI5ktXLFWNqTBVTWEIt8fRW0nYjML90ompkfTBcM1ZSU/7GVkpDCeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8219
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


On 12-11-2025 14:40, David Marchand wrote:
> Calling rte_eth_dev_allocated() is enough to retrieve the
> ethdev device object.
>
> This leaves no user of the ethdev field in the fslmc device object.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - dropped return on !eth_dev (this should be fixed in a separate patch),
>
> ---
>   drivers/bus/fslmc/bus_fslmc_driver.h | 1 -
>   drivers/net/dpaa2/dpaa2_ethdev.c     | 3 +--
>   2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
> index efa88754a7..094f885f59 100644
> --- a/drivers/bus/fslmc/bus_fslmc_driver.h
> +++ b/drivers/bus/fslmc/bus_fslmc_driver.h
> @@ -98,7 +98,6 @@ struct rte_dpaa2_device {
>   	TAILQ_ENTRY(rte_dpaa2_device) next; /**< Next probed DPAA2 device. */
>   	struct rte_device device;           /**< Inherit core device */
>   	union {
> -		struct rte_eth_dev *eth_dev;        /**< ethernet device */
>   		struct rte_rawdev *rawdev;          /**< Raw Device */
>   	};
>   	enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index 7da32ce856..c545177999 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -3320,7 +3320,6 @@ rte_dpaa2_probe(struct rte_dpaa2_driver *dpaa2_drv,
>   
>   	eth_dev->device = &dpaa2_dev->device;
>   
> -	dpaa2_dev->eth_dev = eth_dev;
>   	eth_dev->data->rx_mbuf_alloc_failed = 0;
>   
>   	if (dpaa2_drv->drv_flags & RTE_DPAA2_DRV_INTR_LSC)
> @@ -3349,7 +3348,7 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
>   	struct rte_eth_dev *eth_dev;
>   	int ret;
>   
> -	eth_dev = dpaa2_dev->eth_dev;
> +	eth_dev = rte_eth_dev_allocated(dpaa2_dev->device.name);
I have also included this change in my patch series. otherwise it looks ok.
>   	dpaa2_dev_close(eth_dev);
>   	dpaa2_valid_dev--;
>   	if (!dpaa2_valid_dev)
