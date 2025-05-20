Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF6C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 06:19:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C59EB402CA;
	Tue, 20 May 2025 08:19:06 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
 by mails.dpdk.org (Postfix) with ESMTP id 07512402AE
 for <dev@dpdk.org>; Tue, 20 May 2025 08:19:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9lzpI8Hkh+EooP9DxnXIHZ4DetcTXrv6qpLT4WQBuYVNGlOrnKHsxX4hbw42jJqFRXDm4gag+IiMZrI7tP80dC4tl0ttQsEXEFWzDNKAlsjdGA5N1Zcq8oVOTCoO0bqI0W8Kg+RS+FdvlW24ItTSXSt2eXShH6VImlELSUqwyoYMvrLIcMsEgKELq78R8cHGMwRVn21r1nXfej8Pg6+D+dGUUYzd8BmEdn/radOuRG6B9JzU6mJPKjEbEgnSyoI1B2A/hk7nUTdsFEYucngX1Vru4Wn030r5pXUOWcZRW495q4rIkZV6BhOiqwn1wM+IBrrYLSvrVBFC2y/2toKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQJKt9uHrLqxPKcLfBH71woCe/kHW0Qy6unOophbdNY=;
 b=Nv4MLolbAkd7iZEw6V3VpZZGVDd4IVXhY0ZvrOBhQrRqrHq5BvVd7GzCctRpebrSQkVTGiIlbRjyQ/RVqb2SH/eLGmaquTyLlVDWsWqk6g9TZeUiduXY9YfJVVmz3AqJvpwEMJWYVf373V5kvrE5LEMSqjKhEBwFzrogGntHCcFMeKqBE9A1hBn1t/weAl/x4w3v06AaLmjtkgn2wZ3GHe+0X+KAtuv4tnI1fG6D+744Be3h+pd8WXT/2Y/X+5NTi18spcuQrbVTn1tuATMruWtOM4m2uRxy3jDspwj5gIjLVrxQtP0g6XmKxok7HKusPWY3bJbtpjYvKD6ejcXnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQJKt9uHrLqxPKcLfBH71woCe/kHW0Qy6unOophbdNY=;
 b=Vb/qimYnz67W15zaqYq58WW0U5ISgr4k1uM6DecVSMdDEBf56DOXWBoODCDUU0vWMrWdbi3gaCWp7a7BXjLCaHZ9W4ZQcbkdtGbuhDk3/7AApruXSpWpaeAwNBKa5fjVwDsxr5lVfeKD9kQofFPzF9uOV0qJamy50maCi6Lb2E1yBvVLXkjAwrSAz5+EdpcvtE7eqdG8NEj/LIXXStdTS2Lk5LQu3V32i3XB7dJuavBG3SS9GaPhS4pwTZXmI0p6QSm1Hq99HXpB79RRcptkJnR7x/PJVcgRki/YtyJxMfcjohOWSGCHjHa3jyH+OovZve8yUlYNH5IOjBCzJVpL3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PA1PR04MB10889.eurprd04.prod.outlook.com (2603:10a6:102:491::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 06:19:03 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 06:19:03 +0000
Message-ID: <9e4ce500-e3e6-86a5-008c-013c8ff313af@oss.nxp.com>
Date: Tue, 20 May 2025 11:48:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/9] common/dpaax: support 12bit SN in pdcp uplane
Content-Language: en-US
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250520055133.506071-3-g.singh@nxp.com>
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250520055133.506071-3-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PA1PR04MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da98921-4859-48a9-d633-08dd97663767
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1cvZnVGWkxKM0xKZDVtQXM5d2JLcjk2QmVjRDJQQTlTclFqbGVQQ004Ujdt?=
 =?utf-8?B?YlF5YzE1eXo5MFBLUTI3czlPOVM2RzhYeFo2WHZoZmFMNVpoTWI3eXRES2ZP?=
 =?utf-8?B?a3ZEVGp0dG1rbE1qQ1FFYTMyTDdXSURBeHp6YUpJNDdXNlo1RlFxaUNmYTBM?=
 =?utf-8?B?c1RVWGdNaFF0dUhtRmFFUWJENXdheHRmUU9iQ2hwRDM3ZzY5UjBmWTJFR1M1?=
 =?utf-8?B?akNVeUt3YTNScVgvUkZ5RGU3TitEWFE1cXNLNkhSc3BpNmgwekxxMW5uc1Y1?=
 =?utf-8?B?bmxuOXBHTnFITWpIUHI1cVVlM1ZzcnRMcnFmYTl6dU1BeTJzSmEvWXhOb0J3?=
 =?utf-8?B?ZDMrc0dxNzlHQjg5SzJPak1hZVZEang2Mkxhd25CdDlvTDdNcWhyWTE4Z2Z6?=
 =?utf-8?B?bGwwSzJLQkpvVW5xMFNjYzdKOTRiL1FvNFRqb0EvUkJzUHA5RXlGeXREa1dS?=
 =?utf-8?B?cmJoT1FxRGQrUDFJaUlHdGZUcGZjTHo1V01YL05RSjBGZmhMVkoxaFBxcnZU?=
 =?utf-8?B?cmtPajNjMHdqcFV3ZXkycUZpMDhMSVYzeFdUMHZDVHVWdjFKV2t3MlppL2V1?=
 =?utf-8?B?Nml0S293T3V1aiszMkNUNmp1R1JiRTVQZW5sY0dTN1gyWGYrQTZscVU2aU1n?=
 =?utf-8?B?bGl5VzNYUHVVMlNhVFByakdER05HZFNRUEtGVWVHTVBQR2Fkdjl6TGpoMU1U?=
 =?utf-8?B?YmRoUzF1QnVNb0owaUszSkxJbXIydzNNYTNJUjVQNjFDZkl2QnpGV28yUzhF?=
 =?utf-8?B?RmlOQWdJTVJtRnFNMUtzTTFoZFhUUVpSTDVNbTVMWi9COWNiSHBuTkNHOExJ?=
 =?utf-8?B?SlY5RHp0a3ZQZ0JJLzlDZHdvUzJKdWoxVmU5eVIyTWNaN1IySVJqaEc1WnJF?=
 =?utf-8?B?ZUIwajh2eU5CT01MaVlOOEROUXJudTh2dzRsbi9Ba1hWTUlHemVIeG4zR3hF?=
 =?utf-8?B?NERzaEtEWGFhd0wvQTFqMEhJbk52OCtMQnFMY2UxMENHT3pQNFBEVmxwbkFR?=
 =?utf-8?B?a0pXT3lMUzVnV2RiVlg0QjlEejF4QjNJS0I4Y0VZZzZRT3Y0VlN0WXNKMXQz?=
 =?utf-8?B?MVVXZG5FTWgyem40Y2FrOHZxMmFkdisxb01JVVh2QXV1aFhoOXdtcWlmMDFH?=
 =?utf-8?B?cGoweEVmNW5IR0RuME90SDl1UnNuajI4NUZmQ3FaaHg4bklSQWkrRUMwai91?=
 =?utf-8?B?ckZQU3Y2eVU0VHZpbWIrMStDZzlybi9KdHpGbkVpWm5wdXFxYzZQb0pNaFdj?=
 =?utf-8?B?LzNVc044ek5LbVBuN0tLVkc4YWd1ejBjckFOWGNId1V4SVVuWVg1cUdvK05p?=
 =?utf-8?B?MGpjWnVFN2tNWSthdzNMU2FnOWlIcDJaYS95U3d0SURCWVBaZWFnSWMzZEpS?=
 =?utf-8?B?OWk0a0tTQUJjYUk4RGJwdFJFMzgyK0hNYVJFOS9VdU13aVhldWUyVE5zRzhN?=
 =?utf-8?B?SFdOK2xSTHR4NnEvelBYYlh4Y0hzNHQ5SjkwOVVLOVVnS0FycmlhSjFSWVhL?=
 =?utf-8?B?R1VZdzJWU2s3ZGgwRVI1TnlPSmJLREZ5c2dVbzFHZnBWMnIwMVBQZGV2VExG?=
 =?utf-8?B?SkYzQzV0MVR1THpQUWZOclVLTVFOL0VlTG5DR3JReDdtdXpaR0ZYNjNQd1Zl?=
 =?utf-8?B?LzVYbjNmU0FQOG1GWnFVeTFSb3pJck54aHVaeU9Lc1M2b0tjRUh4MlZLN25x?=
 =?utf-8?B?VDYzRloyR2ZURlgrUVBMbXJRa2UyNVFhOTN3cTVsOGF4WTUzMUFkNURFb1Bp?=
 =?utf-8?B?MVdiSnQ1MXNJTStuTk5GWHVDUFdWcHduK2pkLzhic3NaRUVtVk9RZ2NTbHdQ?=
 =?utf-8?B?VVZ4VjFGMWY2ZUFtM1NnN0xzZEZCeU1qVmFzYXdEYk9HN29PUE1yTmh6Y09a?=
 =?utf-8?B?eWczMGxoaTdpVVFqc09peDhxSm16VWpzcHJlQllpSlZ1TXhvT2l1ZGIrQ2c1?=
 =?utf-8?Q?cy3Xr+TL1oo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZKUUJDa1ZnZHRYdmdtdjJoM1ljR1ZNblRtSmpRNGdHV0thREsxaENEZjRn?=
 =?utf-8?B?YXl6ejVWRjBEVjl0UTczVlpia2pXSE4xaFRXL0R2SklIQ0dUWmNrU0F5WVla?=
 =?utf-8?B?ZEFJU3dtSFBsQ1RJeEMrM2JsOE05clZGbWwwSnF4bHZ2d0JYcFdkRi9oSEZM?=
 =?utf-8?B?czBxSzZaT1JHeC9VZThLbHRSc0tIZEJRNUtlZDQyamJvQzRBYXVqVEdQdDBl?=
 =?utf-8?B?d2V4Mzg2bVNyOFE0QnNOQW56UW1Ocm5VSmtvK1M4ZTM4TFNnVmtWTFlacDc2?=
 =?utf-8?B?ZWlPZm5MaTY0ci9EUk9rY1JPL210bWF2bUV6bnNNWEtzM3J2TDhxczlNeHBR?=
 =?utf-8?B?YXdkNjFvbGlTNjVVOWJKWm1iY0hwUFU4YXRoYTZCbHRpaVZPTzNMT0I0Q1Nq?=
 =?utf-8?B?Z2Z0SmVmWGg3UHNHVUlJMEZwQmxhRWFHVjFKcVBkWDRiNjAxMEdvQVVMK1ZE?=
 =?utf-8?B?ZFA3VklycU5kK3FZRmtCNzZpZk1seU9TTVQ0N0pSNGpiVzBkd0U0S3RhYWZp?=
 =?utf-8?B?Z05JdFFxbk5jc0t2eVBWV29YNDRKb1Noa3dsMTZaQ0ttUlNIMEFWaTd4K01a?=
 =?utf-8?B?UHlCZzRHS2NBVnVBVW1NeFZRNW0rTUlvcC9vMURUUVJhOXdTUWpnQU93Y0cy?=
 =?utf-8?B?NlRTc1NkNUhVWC96bGlZRjRKQUd2MU1ORU1XaWR3RWlKZlBBS0RFaGEwck00?=
 =?utf-8?B?OTBRanZzZFRUNExlUEg1MXhDS1RpcGNYem5ibXM0bmlIOVAyS1FOcFlLSlJN?=
 =?utf-8?B?UlBuZGZLT0Mvc3BrWXpReHo0ZnFRRC9YeFlMWjV0QVhobXV5Y3pScUVqbThh?=
 =?utf-8?B?SXd0VDlmT0FEMmZqVGxBb1B3dmUwOFJtTGlFREI3WlhvRlhYWHF0aXRLczR3?=
 =?utf-8?B?TW1TdjZmOHAzc1pqYzFEcDVGcytNb1FVdCtOZ2Q5WnplZGZxYUdUalg1b0RR?=
 =?utf-8?B?TXJhTjRudkQxcEdJdmpMUXBYa0dDaTJrOVdLUEFjR1Q0N2tlTERjMWdNVEpN?=
 =?utf-8?B?c1dvQTYxZGIzUjIvdmZHZjFjdVRBR1F4QWZRYjY3T2FORFJDZDdqTXFLb0h6?=
 =?utf-8?B?SlBBaHFTUXhVeGIvUnEzYTZsUUxmYXNWNm1IL2F0RC9SWVY3TmRsTGJsekFj?=
 =?utf-8?B?WHVaN3VITjNHM0hxbzZuaXo1Rm5OcEE1TmVxcjRSc3pQQkZjUUdXcDFTZlRk?=
 =?utf-8?B?V2xGL3o5N1VGbjZjc2VUVDJ0bExSbEZJR241elg3OWp3ZnBtWWRMRU5sZ2V2?=
 =?utf-8?B?bytiNm5jT21GMWtORTFYeHNnOHpXd2hyZFk0Z3ozS01Bdmdoa2xmOVBZNHh1?=
 =?utf-8?B?QXkzU0VMb3dHeU5DZFJuOFZJSXFKTTZESXh1WDdNUUNDdklOb3F1emQzQi90?=
 =?utf-8?B?bktHRXhzMG93M0xkMGJOcmhlbVdiQ01pcXNDQ3dTTG01czRXc1dmL3FtMldU?=
 =?utf-8?B?MzNyVm1jc1kycUYwbUN0NHFnVkRaOStsaU9GOHNaUHdoNjBXOGxPVVNBV0ZW?=
 =?utf-8?B?Ulg3aXU3WW43UmZ1cWM0eU41V0VkWWI4WmY1MDBQb3M2QVc4ZTIxRzFhQjZh?=
 =?utf-8?B?dEk3U256TWVVYnBsNW1WemRBZFEwYkdqVG5ZM1VNR2RMMVJ3Y1NNZU5lQUp5?=
 =?utf-8?B?Q1F1YTlFR0oraXZBZUx5R2J2MWJFekYyL09wZFNrTGxVajV6dXFJbTdubFBC?=
 =?utf-8?B?dnJGVTFTYXNsVThKZ1RWZDVPdE1tY2ZvTzM3TlA4Y0pDS2t4R09VdHJ0dTU5?=
 =?utf-8?B?bUc3NWlUN2srVlE3MXQ0ZG9WekcxblVQTjdPNTE1emdaSUlOczYzdFJwR0w2?=
 =?utf-8?B?NVQxd2xnVTlPUXI0SWNLMjIvUGphbjNVeTc3eVFOWnM3MkhqNlpMVlFncXJ5?=
 =?utf-8?B?aDdldnZuYjRHeXYvcmJPUWhiUksvcEpIMEREck1FaURhY1VKeFpUQTlvVHYx?=
 =?utf-8?B?NzdYTU9Md1pBVTVETSs3SkFibVg5L0FBMk5vZERUeUpPWDVValVHOGxhMXZ1?=
 =?utf-8?B?aDEwdmJ6ZXdSUUNWbWVsL0MyL2xwemJEcmMzckU1ckVpOWlwckEyMXA3WHNt?=
 =?utf-8?B?V0xJSEtHa0tNN2sxZi9TSHhkOTkxSHoyZzlzK0tOMGpnV2xpOUxuMkt5S3F5?=
 =?utf-8?B?QkVtQ25wNzdqbFIwOG82dDRxM2EvUG55WEtYbk94N0F5RE5rUzQ4Vk01a3E2?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da98921-4859-48a9-d633-08dd97663767
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 06:19:03.1435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYvnch4NWIUD05Mtdb+9/stQrVr2Z4TArHHdHfnJLfAjHwOZG3JZTm6RFSjnpsMvZAjmUkEuT/ZN6Bnh+5JEYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10889
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


On 20-05-2025 11:21, Gagandeep Singh wrote:
> update pdcp_insert_uplane_no_int_op() to support 12bit SN size
>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---
>   drivers/common/dpaax/caamflib/desc/pdcp.h | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
> index c90eff26a8..55159d53f0 100644
> --- a/drivers/common/dpaax/caamflib/desc/pdcp.h
> +++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
> @@ -1988,10 +1988,10 @@ pdcp_insert_uplane_no_int_op(struct program *p,
>   		return 0;
>   	}
>   
> -	if (sn_size == PDCP_SN_SIZE_15) {
> +	if (sn_size == PDCP_SN_SIZE_12) {
>   		SEQLOAD(p, MATH0, 6, 2, 0);
> -		sn_mask = (swap == false) ? PDCP_U_PLANE_15BIT_SN_MASK :
> -					PDCP_U_PLANE_15BIT_SN_MASK_BE;
> +		sn_mask = (swap == false) ? PDCP_12BIT_SN_MASK :
> +			PDCP_12BIT_SN_MASK_BE;
how the 15 bit will be handled now?
>   	} else { /* SN Size == PDCP_SN_SIZE_18 */
>   		SEQLOAD(p, MATH0, 5, 3, 0);
>   		sn_mask = (swap == false) ? PDCP_U_PLANE_18BIT_SN_MASK :
> @@ -2000,7 +2000,7 @@ pdcp_insert_uplane_no_int_op(struct program *p,
>   	JUMP(p, 1, LOCAL_JUMP, ALL_TRUE, CALM);
>   	MATHB(p, MATH0, AND, sn_mask, MATH1, 8, IFB | IMMED2);
>   
> -	if (sn_size == PDCP_SN_SIZE_15)
> +	if (sn_size == PDCP_SN_SIZE_12)
>   		SEQSTORE(p, MATH0, 6, 2, 0);
>   	else /* SN Size == PDCP_SN_SIZE_18 */
>   		SEQSTORE(p, MATH0, 5, 3, 0);
> @@ -2047,7 +2047,7 @@ pdcp_insert_uplane_no_int_op(struct program *p,
>   
>   	default:
>   		pr_err("%s: Invalid encrypt algorithm selected: %d\n",
> -		       "pdcp_insert_uplane_15bit_op", cipherdata->algtype);
> +		       "pdcp_insert_uplane_no_int_op", cipherdata->algtype);

Why not use DPDK LOG APIs?

also, why not use __func__ ?

>   		return -EINVAL;
>   	}
>   
> @@ -2734,8 +2734,7 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
>   					cipherdata->algtype == PDCP_CIPHER_TYPE_AES
>   					&& !authdata
>   					&& sn_size == PDCP_SN_SIZE_12) {
> -				err = pdcp_insert_cplane_enc_only_op(p, swap, cipherdata,
> -						authdata,
> +				err = pdcp_insert_uplane_no_int_op(p, swap, cipherdata,
>   						OP_TYPE_ENCAP_PROTOCOL, sn_size);
>   				if (err)
>   					return err;
