Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C03CCA470
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 09:44:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E064540613;
	Thu,  9 Oct 2025 11:44:18 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
 by mails.dpdk.org (Postfix) with ESMTP id 24A6240277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 11:44:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMgjQxi7eiANCVmo0gB6glZ9ImFLkLv7ItpdXAq8bVG+LLBP114nKKjzf/PRYXkruxjCxIC1oN6B/+sZadt9aFZdw8NWY3xmRQZ+4nM19UYfzeRbjgO+J5d+X0XVIXSPwB7VU+HxnTP8wK4lnSUHipYP13wB1vFdcofqh1d/OTh36tKnblX9Qy2M/YNDJSvJWqWCvwDyWYs2rxbUUf4EakhVW7j0SJ7qZYF+nKKTWDBDuCerKvYHLIB1ibYsOHi2D1Yaf1GQKeaaakmFhIJ8jlHdU8O2jKqTTVgmyblZ2+L6UKO4YcDTGKNj+O6BdfKMbMwKHZgD7KtlmkvmKUSbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9RnWSuu2D2HpWQMCWh3MXIhrYOdf78stfjacyi9eVg=;
 b=uW4sfHifta6bTDwnhFWy5QWSI0wE6Qvo6Gv0A/CIpW30GyddkyqAM++0ySGxEDtdBzdM/td5tAK8outreTCzT/NCxCdbKabdnzR8xKRbjDqGiPwllg5oAV66tm6nEL+faT76JvoUxiIUH9eriAWcw+GPEAVZOGl+M7OQWmZ85UePd/5KtktWl+8WoDGwE/tm5LlAzCXmFcOzfjS2kIJtTLmbsTk1WEb5rgefMmW8TRzAJMLIsJcUWuy3s/v+vAWkQ9ouWihkV68Tlka7nN0sBqNwfU2QjqElYZhSUZt3gCLDR4zNlns4QMMfSAnXtUclOzCmAA7/ou3q/zExdueEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9RnWSuu2D2HpWQMCWh3MXIhrYOdf78stfjacyi9eVg=;
 b=Oz57jtE4amzKuB+08N9Prpf/SMY/eqEw0ZvLZNerZCtXfDpuhfpUR5+FMd3DgvukqFbI7lLJzPKN1wcezKy5EGWBVCitY9YCa1cweU6Da2x0g1bySup+wJsNMYoCQbdH5rYAZsRkcT+Q7mrQk4RqdmZ7PdZnDbme+dCXNGBN89iojR/Go9WL+6iAU2tYmzAROiEc9rNqDNc7h6BpxhvDeqbEA2cUDtdSdodk7Zj0jCY7b1lrCu/EWmRQpl8aYjiYOTgjttwx9KnWjvDoOYPbbGQ7qdmxPXR6FEedE6gTt2U4u/ohuS0dP/apNQ68dnA0oCCYYhTxc71vwod5uNN8yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DBAPR04MB7350.eurprd04.prod.outlook.com (2603:10a6:10:1a9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 09:44:16 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 09:44:16 +0000
Message-ID: <86117238-cb82-403f-9c40-5852e90d034d@oss.nxp.com>
Date: Thu, 9 Oct 2025 15:14:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] bus/dpaa: add FQ shutdown and improve logging
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
 <20251008043519.2461707-1-g.singh@nxp.com>
 <20251008043519.2461707-2-g.singh@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251008043519.2461707-2-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DBAPR04MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: f2333138-345b-492d-3b58-08de0718692b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXNkLzVkb0hja1FxN0FjM3FMOE90Uk1TSUVINm85emtPMjdrNllQMnRDWXl1?=
 =?utf-8?B?V2xDSkZHQjA1bnhkSnpSOW1JKy81NW9LQVpsTUpKbDJ3WFJmYnpaU3RHWS9s?=
 =?utf-8?B?NUYwR0lrN3VEQVZsUkw4RzBBRWhPaWY0L1NVbHF6UDBJbmpLZ1dQbnpDZjRZ?=
 =?utf-8?B?SWtXUWZJQ0N3cXlQRGJKNFgxWlBUQS90V2lQa0docmpvY202RlNDWEQ1Q21Z?=
 =?utf-8?B?S21YSTI5ZEFJVFJHdjBNQ0dieVdGYWtzc3puOWRDdDV1TU5GRVJ1WVcwVm1E?=
 =?utf-8?B?R012Mk9uSFZ1Z0t0SVpHVTVVeFBzcmFPVVpNT1J2bjhvUm9nemRHdWxWV1M4?=
 =?utf-8?B?NXlLTjlEOGwyTmVmc1l1OGhqUHYxMlJMZkloSy8rWFEwYTdBejhCcFgzREMx?=
 =?utf-8?B?UXZvZEtEZUtkMDZBSmZ1aUxSaENjT3dQYjVRTXpub1lpUjl2VE1pODFiVGZX?=
 =?utf-8?B?b3FrbEVDekNVZmUxOFJJY0NqeWtneW5jMTZCVnB3MjRxOUtjOW93SC9OZ1Jh?=
 =?utf-8?B?TmszTWFtUlI3NHc1cXVGZThmYXVLY2V3UHZuSjFSNUhma3JMdlhYYm4zT0ZV?=
 =?utf-8?B?YVdPcDJhLysxa3poYXRjMTk2ZFJCdWdwRjFmOFlDL1F4cTNCemJoQVAyeURj?=
 =?utf-8?B?Uk5mYUt0cVRwaXo3aHJXN0xiQ1pkNzFDNU5JcUM1NURrWFlweVBNN3FqOGwv?=
 =?utf-8?B?bnF6cUZTMjBNRk9HM0QvY3JFc2Ivc0hIZHBkckdoQlh5ZlF3VUVFYWJDV0pZ?=
 =?utf-8?B?TzRuY2lLVDJFTDhlYlhnd0VXWWFlQ1NBNE9HUHhDMjRjVFZXZGREci9tSlU1?=
 =?utf-8?B?TW9ZaFNBYkVyL2hSRVptMVh6VG1zM0xrMWMycEVlWDg2MU9lUUNTY1k3R0hw?=
 =?utf-8?B?NUVRZS9YRUhkdk9xZGlwelhxU3BnL3RkclZLeU11bEN6bHBBaURQR2lPV0dM?=
 =?utf-8?B?aFJTSWZoamRyOHBQSHNUUm10M3V6SS9FeHJNSFI3MTFObHBrL2JzWmFhckg3?=
 =?utf-8?B?Y2Vxc3RDcDRzYmloUnhOWWlkMjhtNmhHbTFpVFhYOVpWbXhWbWtHQnVDWWwy?=
 =?utf-8?B?anZob1NZSUE3NDd1empKTVdZamlwdVBEU1Q1TW1vRyswbFFkQ0tldkpnY2JD?=
 =?utf-8?B?UDFiYXZkZldFeWgyUnVMTDBqOUxuOXhudjhSQzUxeGZndkk1Z2JjcHJXb2Zn?=
 =?utf-8?B?Y3BJYlN0RUI5Nm1UQlpNbVU2emNsNHowaVdJd0gyZnRmbXp4ZnFxeExwM1pl?=
 =?utf-8?B?QXdORHdXTThGVnJGODZROEF4YXFHZ3pOOFJ2eXZHSXhaUGtrRGJUQlJjZXFS?=
 =?utf-8?B?SXRSSHRUTmVCOVBYU2RrM1c0NFZDc29yYjZzRjI5MStlM0NZYlM0RU5jRzVn?=
 =?utf-8?B?cmxBZWVhUEJ0NFlaMXVoS094Y2tmcEtEeUU4TStyM2l0TXJDTUlCbk4weDlr?=
 =?utf-8?B?MEFIeEpMbkw5eTNzYTdCMmFIRFBXVjRDVCtBaDc1Wkp1VE13REZhU29MOCts?=
 =?utf-8?B?bmZqWnJDNHlGcGJZRmlkakZRMlFSaVpFZ2ZLanZscmNJY3VubC83Q0RFTktW?=
 =?utf-8?B?OEc3ZEFGaGdVSWhIc1lMV1NvRGtlanhQc2o3bkZxdDB0Wjl3Y3ZoRmdZQjBI?=
 =?utf-8?B?c25xbldHMm5rcXdURmpERjBEOVgwY3J4OWd3SDhXQUdxODNvQjZTRjVtKzQ5?=
 =?utf-8?B?QUZ3QVNMaEhzRE9DZzd6U0IybXRPVGlRWUNJY2RvRDZmamJMZnRjV3A1S3Rm?=
 =?utf-8?B?TnppUUNBUzRGMzBhU0hoOUlORHNLOGpzd1A4bS9lZEwyd3NoOEZpckpWQjdZ?=
 =?utf-8?B?Q3B2ckFXK05LcTNRL3hzR3p1bDhJOVdlRGhFVTRuNzNKMVZGeFZWYWF2WU9W?=
 =?utf-8?B?cEFIUXVtTTQ5ZjA2OEhsQzBKc2RVYWVKYTFHRlRBdFJXS0o1d0FoY25qeVYy?=
 =?utf-8?Q?u+glWpX1DOSVICAo9mQ/zGxgE268JHOW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEc1Sko0RG0vY2U0NU94d1hZMW9NdExDeXExbkZraDZuWDBnbG1zMFVWaEFp?=
 =?utf-8?B?UjBHUlU2RmUvcmhLQzJId0xqczkzNFdnZlk4VVJ0Qlk0VmhqQmlPaER5eTJ3?=
 =?utf-8?B?T3FPZ2lPMzZzQjM3QlBGMWlGYnl0U2lkTFJLdzUyUERjVC9ET2djSUNhaE5W?=
 =?utf-8?B?MXlyL0RpVExLU3N6ZTFzS3pIU0pxMnB0eXFoZkVWVytKWTJuMTluVGpHVHdU?=
 =?utf-8?B?TmJSbkc3NE1VcldPU3ArUXRlT2oreVZQRyt1dkhaa0E0Tk91bTNnMVdWc01Y?=
 =?utf-8?B?WFdGb2hOMDZPa0wxZVJvam5Lck55dEV0SjJOTHpjQmM1WFlOSTBXcHR0SWts?=
 =?utf-8?B?ZVNjMnlQWVAzMGRmZDhoSGIvVENibmhTdnlDMDBPcFVQNXc0K2w5dW9xSzBQ?=
 =?utf-8?B?U3NxUWVxc29Nd0JXS2lzbE1BUzNQOE9XM3JiVjg0aitrTm1IekZuTWFEeEcz?=
 =?utf-8?B?OEpXd2xXbDdQUFBtV2dmTFp1UndJSUgzeDVQdUlDZjB3ZTdZVk4yYlBYaGQw?=
 =?utf-8?B?czhFNi93UDFZMitYMkhMMFlVSFdBYU9LUEpwSzZQS2x4Z2lDNy9Xc1p0V0dR?=
 =?utf-8?B?aXI0b0hDcklQNGxQeS9jNzEweXJBY20zNmh2QWhJeUJITE44a1lGc3VyOHVT?=
 =?utf-8?B?S3NmWjN5Z2xXL1ZrM3NLSElTNUNCbXBtbXI0TTNLbFEwbzRJVlVPQzlsTXdB?=
 =?utf-8?B?cXBZR1FIb3NsYkcvOTdsUmREWjlaUEZwRURkVWdlbTEwVDQ4N2YrOEMyMzN2?=
 =?utf-8?B?WFROamhSZVhMWnhTQnRrL2hvc3FwelhQRkxaVEJDaDJ4bVQ3Zjg5R1kyZSt6?=
 =?utf-8?B?NTY3TnpNVnpMRGZ6U0xWZzZnaTkzWTQ5dHVVSUZ3UEN0WjVlS3h1NVZMYTIw?=
 =?utf-8?B?Y2pJNnVsYXI3MGxJR0F3NnlQRFExSDhxTmJIU2NKdzIvQlBTV01CNlhTN3Mr?=
 =?utf-8?B?NEc1b3lTZHhjWG9Bbk8zbWJhWHR5SFhXdDUrOHNHU09BUVpkbEVQVkoyaEIr?=
 =?utf-8?B?YlZkMDBKcE03amd5bEVpcm5YaDV5MmM4NjNNeUJOUDQxVXNlVkZTQlg0MHUv?=
 =?utf-8?B?ODhIQldNUTRYbTc2Ykp1WjZGQ281cWQ2Rndpbnd2QUplM0dGNTFtVmRROURi?=
 =?utf-8?B?RzROVktHWnpBZjlFU0VVdi9wVjczenM3encrcDNvT29uaTJJRWJLMVZObTJj?=
 =?utf-8?B?Ry9wcVlncVAwdGRZOVl2Wmd4ZlJyNHVpWmdLeHd5MkFOTG0rd2pMVXZvckVj?=
 =?utf-8?B?RTZUZFRFSGNNdUwxd1lQOXRFSmZEL2dkYVVvb0JLSHlrM0RLZExaTFpnREdT?=
 =?utf-8?B?UENyOUN3SC9UQ1dVeCtXWGNIclJsdzVUaUViRlhUYVlueHh5U09qQVNEeTUw?=
 =?utf-8?B?eFRVbkRoZ1NXZkpFYUp3V1M1YTVTV1U4SnBEV2p1RUpkcmVUa2I5ZzlnQzhH?=
 =?utf-8?B?ZjAydzRVTWRlZUdrNVZiWitlOGVRbTRBa0x1bFJ6RHU4MkdPOFNBaktmWFha?=
 =?utf-8?B?WVp3eFJyVXpKdHlJQm5OdUlWYWx6UGtIMVptRmRSSzBnWGJ2Sk5MUjFDQTVX?=
 =?utf-8?B?UDRxQmY2dllqMVFGcTZPanpRL2hPYlMxYlZFZUJFRzFhdnIvclJXbTQ4WnI1?=
 =?utf-8?B?OENqV2EzZUcrYUx2aklIMHFsdDY3cnI4NThkTHVydmxaMTFzOHQ1U0p0NDNZ?=
 =?utf-8?B?eUw3U3cwNmpxUzMwRzFWL1F2UkFLVXlPZktzZkVJV0tWL1hvaW5kSXAwK1B0?=
 =?utf-8?B?N0FxMGRUVUpPY2duZ1JWODFPS2tLaktWbnczZDI3MWt3NFVUZnhNR2pMeDVk?=
 =?utf-8?B?Y0dxa0NqeGhKZVFOeHV4UytMVU9UL1JQUGdyUTZlYnRwMExIS3lId2VYRi9R?=
 =?utf-8?B?bDJMRTNFYTRwN0NLSklrMG1ZblJMZ0t5dEVVak9OakhnZ1QybTFGZVNhTFo3?=
 =?utf-8?B?N04wc3lEY1F3a3NaRVZUcGh1SllpYzlGTnB3NEl4N0k5dElGUFU2WVFHeFY0?=
 =?utf-8?B?cFV5cU5XT0dhajdLZ0FtYmo5c1RNa1lQVjRCcFNTbHQzRFR3Ti9FWHlyd1gz?=
 =?utf-8?B?dENDaFZDaUdBWEFETVd1N0grK3lQTnkzUUcwZ003RU9kRVRRRDh5RFpKSGY4?=
 =?utf-8?B?M0VDTWFUSFhjdDdUckREdnZKOEVpSWUyVktzRHQyQ0ZDdVk2L2lCcGRKQS9x?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2333138-345b-492d-3b58-08de0718692b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:44:16.2508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPSG+F8PcVvtAT1TKM1i5xlZG7RL15afKU6mLzRP47r8pIju+7KK4QcVzxqnCOouOxU+to4ZJ/2Z7RMSOUaZlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7350
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


On 08-10-2025 10:05, Gagandeep Singh wrote:
> adding a FQ shutdown functionality to ensure proper cleanup of
> frame queues during queue setup. This helps reset the
> queues reliably and prevents potential resource leaks or
> stale state issues.
>
> Additionally, update logging to use DPAA_BUS_ERR instead
> of pr_err for better consistency and clarity in error
> reporting within the DPAA bus subsystem.
Can you break the changes into two patches? logging  and cleanup patch?
> These changes enhance maintainability and improve
> debugging experience.
>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---
>   drivers/bus/dpaa/base/qbman/qman.c  | 394 +++++++++++++++++++++++++---
>   drivers/bus/dpaa/include/fsl_qman.h |   3 +
>   drivers/net/dpaa/dpaa_ethdev.c      |   3 +
>   3 files changed, 369 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
> index 60087c55a1..6ce3690366 100644
> --- a/drivers/bus/dpaa/base/qbman/qman.c
> +++ b/drivers/bus/dpaa/base/qbman/qman.c
> @@ -10,7 +10,8 @@
>   #include <bus_dpaa_driver.h>
>   #include <rte_eventdev.h>
>   #include <rte_byteorder.h>
> -
> +#include <rte_dpaa_logs.h>
> +#include <eal_export.h>
>   #include <dpaa_bits.h>
>   
>   /* Compilation constants */
> @@ -137,7 +138,7 @@ static inline int table_push_fq(struct qman_portal *p, struct qman_fq *fq)
>   	int ret = fqtree_push(&p->retire_table, fq);
>   
>   	if (ret)
> -		pr_err("ERROR: double FQ-retirement %d\n", fq->fqid);
> +		DPAA_BUS_ERR("ERROR: double FQ-retirement %d", fq->fqid);
DPAA_BUS_ERR already adds ERR, why add ERROR again?
>   	return ret;
>   }
>   
> @@ -161,7 +162,7 @@ int qman_setup_fq_lookup_table(size_t num_entries)
>   	/* Allocate 1 more entry since the first entry is not used */
>   	qman_fq_lookup_table = vmalloc((num_entries * sizeof(void *)));
>   	if (!qman_fq_lookup_table) {
> -		pr_err("QMan: Could not allocate fq lookup table\n");
> +		DPAA_BUS_ERR("QMan: Could not allocate fq lookup table");
>   		return -ENOMEM;
>   	}
>   	memset(qman_fq_lookup_table, 0, num_entries * sizeof(void *));
> @@ -349,7 +350,8 @@ static int drain_mr_fqrni(struct qm_portal *p)
>   	}
>   	if ((msg->ern.verb & QM_MR_VERB_TYPE_MASK) != QM_MR_VERB_FQRNI) {
>   		/* We aren't draining anything but FQRNIs */
> -		pr_err("Found verb 0x%x in MR\n", msg->ern.verb);
> +		DPAA_BUS_ERR("Found verb 0x%x and after mask = 0x%x in MR",
> +			msg->ern.verb, msg->ern.verb & QM_MR_VERB_TYPE_MASK);
>   		return -1;
>   	}
>   	qm_mr_next(p);
> @@ -423,11 +425,11 @@ static inline void qm_eqcr_finish(struct qm_portal *portal)
>   	DPAA_ASSERT(!eqcr->busy);
>   #endif
>   	if (pi != EQCR_PTR2IDX(eqcr->cursor))
> -		pr_crit("losing uncommitted EQCR entries\n");
> +		DPAA_BUS_ERR("losing uncommitted EQCR entries");
>   	if (ci != eqcr->ci)
> -		pr_crit("missing existing EQCR completions\n");
> +		DPAA_BUS_ERR("missing existing EQCR completions");
>   	if (eqcr->ci != EQCR_PTR2IDX(eqcr->cursor))
> -		pr_crit("EQCR destroyed unquiesced\n");
> +		DPAA_BUS_ERR("EQCR destroyed unquiesced");
>   }
>   
>   static inline int qm_dqrr_init(struct qm_portal *portal,
> @@ -515,6 +517,7 @@ qman_init_portal(struct qman_portal *portal,
>   	int ret;
>   	u32 isdr;
>   
> +
>   	p = &portal->p;
>   
>   	if (!c)
> @@ -540,30 +543,68 @@ qman_init_portal(struct qman_portal *portal,
>   	 */
>   	if (qm_eqcr_init(p, qm_eqcr_pvb,
>   			 portal->use_eqcr_ci_stashing, 1)) {
> -		pr_err("Qman EQCR initialisation failed\n");
> +		DPAA_BUS_ERR("Qman EQCR initialisation failed");
> +		goto fail_eqcr;
> +	}
> +	if (qm_dqrr_init(p, c, qm_dqrr_dpush, qm_dqrr_pvb,
> +			 qm_dqrr_cdc, DQRR_MAXFILL)) {
> +		DPAA_BUS_ERR("Qman DQRR initialisation failed");
> +		goto fail_dqrr;
> +	}
> +	if (qm_mr_init(p, qm_mr_pvb, qm_mr_cci)) {
> +		DPAA_BUS_ERR("Qman MR initialisation failed");
> +		goto fail_mr;
> +	}
> +	if (qm_mc_init(p)) {
> +		DPAA_BUS_ERR("Qman MC initialisation failed");
> +		goto fail_mc;
> +	}
> +
So you are doing init two times?  Init, reset and init ?
