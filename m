Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAE6E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 13:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54F27402C6;
	Thu, 19 Feb 2026 14:45:57 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
 by mails.dpdk.org (Postfix) with ESMTP id ABF22402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 14:45:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzkkJh1NTZetzykP36QKHHQYXzHYGKKsWvMI2A9Sx7XkmrWqW43j96aUSPRbuClp6Q8MvVMIgIwsPglpZ5m93h0wK9rncU5BYALxJGggecwmXvizS7OUj6nmRd9y+hIzt2B84KpQqNP/iFNlnBlwQDMJAzy4e2J+lTDUhCGQnrMw0OB+PXD2mENsbvvDHxifYB/IwqmDqJad/AOEsgFWh/PvN0fBr10zuumQ5P1cADQfOa2X28UIJ6987Bm99PlrvdpfIWGFNH+GE3WQMmsJd6LDdXPKjXvky44dtFyFs4u8rKRzohxIoUL7kOfsr6pKzfnO5AVIcEaoY5UNkNs81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=Xp4bXtX5iDiTjGKtHlN8moW5/KCDKlb/NudaBDUgGwqW4NAxl8cGaebidduoxUfxJR8gr4lNq1ADR3qsiuBtCFLvvhjPMT3rNyFaRebKf2b71wojv2i926m3Shq4lWJM2Nqkn/On7oWKUv6V6gYmlfAQRBwBU8aL6k9qrsJ/sWNKagHmIGzjScyRSk44KkXGw//qDzxGv+q3VpwLOpkOKxv3Oh80TW4joJlmH/5Fy+kijr0x9G+lgHRLp/OIUH4NwBfEI+FVx8gkDwakOmoKeROqIMqHIN0T3nnclZPXm3ziKkgcENZYbWCygR17yj6KvBGEIBRLhxDY/DIAYK5cng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=sUZupalKwWlOml5M6fcz/QGBFo2EWdWZxFkA5Ocv0tteoT4f3qDWtz6kgi/DSf4yTcOqN9pgpRLa5aLVE9HVB1cTiOM0JLsYV79HywGGQHN12VTQ+dC/UycWPqrNThcCdXYzxlPan52Kg6tSl8LMU8lZ5rTRgwzkm40mW+U6H8ymu96DmKRYgFZjt+9jrhNUeI42INElny05tqaLoc1q5djJn4Tif6P5hrxXG1jZjF82uBwYbZYaGt+jfU2fLiLM0cYpIskwv9P0hc4WBE9XKUcc6DexFPLv5MlZaq1h2UVBc/JCXcPv68yz7NZX3i2Aaw5NPmvYiOOrrXshM31OYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DU4PR04MB10815.eurprd04.prod.outlook.com
 (2603:10a6:10:585::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 13:45:54 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 13:45:54 +0000
Message-ID: <9d4f518a-b47c-40a0-b1f5-0ffd4975255d@oss.nxp.com>
Date: Thu, 19 Feb 2026 19:15:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] net/dpaa2: fix link not up after port stop/start
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-9-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260218160453.142311-9-maxime@leroys.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|DU4PR04MB10815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0105d91d-18de-468b-16d7-08de6fbd33ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VC9rWDJlOGp1RGs2RGpMVUU1RlU0V2tBUlAvUjJsRjM4Z0NITmo3YzRkRG5U?=
 =?utf-8?B?NkRwcVFjeU9EN1F6VHZXMXAzTjFGUUlsa0NFU3VnZFFkNENmbTI3YlNlVnY2?=
 =?utf-8?B?TW55NUhydmRJTE11WGNrUE5ucGZmSis3VlgwL1RFZlQweWpQZ09obE9OeUwy?=
 =?utf-8?B?RkZUSUlnUDI4bjJ5VFZqU1NFMHFvY0wvb3VsSWhyQmdzWm00WnBqWGpBYWhi?=
 =?utf-8?B?czBlckVSNEROdGF5djB4dWw1TXpPZnBraWRlNHN6eFNUVi9yMUFxcUp2dUpa?=
 =?utf-8?B?czMzMEovSnJHUGw0WTBOZVJFYjY3VlA5NCtzeFR2UHg2b05MSnZaemZjdktq?=
 =?utf-8?B?ejdobDkxdWVvajlFOWpyc1N1YnFqSm9SUmlyNmFtajhrT051VkxqTUpsM3Ju?=
 =?utf-8?B?TVgyaUdpRW1mU1pITURVeDE3NkhVTU9WL0I4dlVTRFZLWG1tT3NLZnBVODdC?=
 =?utf-8?B?SEdEeU11bmpRWWI0UkhJUTVsUGJ0ZUltZEVXZG9rdDZrMzE2SzdLb1F2bGhl?=
 =?utf-8?B?MzFXZERaK3pXazFEM09Nc0NhREpYa1FrVkNmVXdLSnJwdkY4MGJCWVc0Nkkr?=
 =?utf-8?B?ZUVqOVl3UWd2Tm9BVkNuTlRLVkU3eEV3WWNmZXRmbWVYb2pYQ2t4aURTR2E3?=
 =?utf-8?B?L3VXdE4wRlZOMllFei9yajI5ZFdRUmkrSXZicmJVODZmUWNaNUdCemFKeGor?=
 =?utf-8?B?R1dPN0pWNFpxOXlLQmhSZk5kVnZGZEVFZmp5ZDg3am92d2xvZjBWSzZYSlZ2?=
 =?utf-8?B?RFJWOVJYMWVoNVhVcmU0VnhKV0ZjVXdhQXVQVFhBZU9xRi9HbmVEb2tUR0ww?=
 =?utf-8?B?cUlPaVFaTzhCNjU1VEZ2SGhpN25lak85dWIvWmZ2cmtNdzNCQnNSeGhoWEhL?=
 =?utf-8?B?VFZtSkFjOEM0Z2tyM3licWRFQ01ab1N0YWtoSnI5QVFsbjh0SlF2QzFOQkhl?=
 =?utf-8?B?bGZIaUFFdXp2ZU9jRDd4eDg1Q3RxMmtybjQyaXlQN0xaT1ZHVXhQMndYV1ZP?=
 =?utf-8?B?ODhMNW54WVYybEFrZHIyNmxaWi9Md3c2L2cxU1psR0pkUWYyZEFwN3oyb3V5?=
 =?utf-8?B?TGRNMnRQNERlSlJzRGdsQ1VIazR2d3NqRkJOcVRyUkJaaVNHZ3k1NkZ0SlhV?=
 =?utf-8?B?Zm04QU00VnM0eWJZOGNiV2M2TkFxZ1B3VWVyVWk0cVh1M05iOXJVekRYWTl2?=
 =?utf-8?B?UkRyZUhncUpEdFJHQ2NUejZvN25rdGhJaFJJSkIwS085Z2xoSUY1ZEVmeFg1?=
 =?utf-8?B?Zk12VlNwV3owZVg4TytQUHhEL3JXV1pqVFE3NjVmU2lZUFdTaVNKYW9QL25H?=
 =?utf-8?B?eFBUanFLNldGNXBISi96Uis2Q1FWWEVBT3Z4WEpnTW5LQjh2bjFSNHhlclRU?=
 =?utf-8?B?bVBaSFd3TWZzMytNSXBzT0ZOeE5CdFY4RVBMS3VxTHEzRnQ3UmY1OFZUVFNN?=
 =?utf-8?B?NzlyT1JtaTZsRWNrRzFFMklqOFJBdHRXNUl4YzZHZmUzWFcvMnFJMnBNS3Fn?=
 =?utf-8?B?R2hLd250MUZBSmtjTUIvZHYzRzY1ZUZmQ1pqc25LaFo5ektOY2psNm83WWM3?=
 =?utf-8?B?aFpZKzg5ZU5QQjZOajFmT0ZYQW9Fd0ozYzRTZUhWRjBLYWVOY2t3Y1Noc280?=
 =?utf-8?B?bTY3ZmdCcGpCWU5uVThEUFVFUE5vZ3RqV3dnRHNmL0E3Ui81ZkR3UGxDSWht?=
 =?utf-8?B?VW1YalhKYVJTUGRPMWs1ZGNLTmJEdnBXWGJqaTcwdzVKSCtVR0gxK3l3d0hK?=
 =?utf-8?B?V3l2UjNiNVZWbjRPelErQkJYellrVmhucStwTUpYUGU3Z29OZm94VXVRV3hn?=
 =?utf-8?B?b1JkTVp4ZmcrZTNvMHB6NCtYK1VkYURxeHdoQldzajJweFJoRzIvRWRLMkxr?=
 =?utf-8?B?ckgxL2plYk00NWJMQkROQXl4VFUvdWdBLzlxc1F5YU5CQjJTaXNUN0pnOWVW?=
 =?utf-8?B?QWliWEhtQS90SEduSWNJNGtGVEJPQm0yMnhTOTJFZ040dysxOTFhYzBhYkx2?=
 =?utf-8?B?MDgxWStDL2V5VGVUMDIrTTNTeHJaWjRIT0YwdjNoTXRQYkRzYWlUQWQ4MVk1?=
 =?utf-8?B?VDFBUjNldlFmaHlmcE5UN24xa3g4ZkRQM1ZzYVQ1ZnQ1SXI3VW90L3ErWlVw?=
 =?utf-8?Q?zfgU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9qL2E1ajNLa043U2NxamJsYmFyOXVoc3laaFpKam5RRSs3c1NKSWYrRERU?=
 =?utf-8?B?S1ZFQS9QTU9uU1VUTlhFY1RLZHVrZGZ1Y1h3OTUremh5WnJZaTlWSzJibjU3?=
 =?utf-8?B?OG5pdGd1RUVNbGhHcFVwcXd6anVTOWJBZm9QZjNKYkU1OGl5SUw5ZlAycjJm?=
 =?utf-8?B?WXorMUxyK3JiWU1SOWFxRUk3dXdRa2ltVHRGU3doTWRyT2VuNjlLVGxHVmJV?=
 =?utf-8?B?ZlcvK0VDWnpldkp5dlNLYXJuSG1JMzZhdnl2RWJ3K1RJbjFiL1lqMUZwdWx6?=
 =?utf-8?B?U1NKSkVIMU56SE11Z2VaS3pQZ3lGcE4rWmxmcUtlK0lscDdKRU8wUmliTktZ?=
 =?utf-8?B?M253WFpqbk1XS0poV3I4TFFaL2lTR0pzcjNmRjFQekUwL0U4VzRNd0pQdXBt?=
 =?utf-8?B?TFM2WDVzUmZoY0ZTT3M0MDRvTXJwMkhaaWxINThzUjFwdzFnS05SYXV1ajVB?=
 =?utf-8?B?VFlOR1FQd29Ha3N3OTBGb01ueGkwcjhldG11TDRTVS9vL0k0UnN6NU44Q0lV?=
 =?utf-8?B?cEs5TmpGaWtRR0J5bWNTbjY5YnR0QXl4RDh2Z0JTTSs4NFNqam9qTEZMZlVN?=
 =?utf-8?B?Slk5RDdmVUhXNjZtSldmSk43M1JsTGRueEpuaTVwMW04L2p6RU5aRlp6ZFBM?=
 =?utf-8?B?WDJwRGFrYTBtZXFoR0xBc1lGWTNJYm1TdmF6WSttQlZRTW9way9ZZXYzcjMw?=
 =?utf-8?B?bThyNlZjMnV3VFVmeHBMbjlOVHdXeE01SmlGLzNMWnZ0TmJpTTRKY0NNTVM1?=
 =?utf-8?B?U2hsOHF2b2p3WmNBWEdTQUZnTzMzY01kc2FnbkZDVFFzcWpkVkJCZmFnZndH?=
 =?utf-8?B?MHhhKzR5YlREc0JjZFJ2OXRIeE4wL1psTkxoK3RUcnl4OHBmMnN1UkpLZC9x?=
 =?utf-8?B?a2ZzVGZHcmZSRkZyWHVuT3VyVUdJdmVwaml0d0VpRk9tS0RPWFpzY00rTGV2?=
 =?utf-8?B?bkwvMzBJU2d4ZU1LRXJkb3VnenJLcVFYbFlCZEROZzgrSFlFRHVRMSt5Q0p1?=
 =?utf-8?B?NHMvUVkyK1RuVFJOUzJERFJldFdBdXIwOC8wK1JCQ2tJbE80L1ltZEp1VVpL?=
 =?utf-8?B?eS9QRVp4dEM0Vlp4SXUydzMzSkY3UGFuQmlNTUVkMHFZY3FaZTFVLy9mdTdV?=
 =?utf-8?B?blRnUVE1di8xZzMxcVVTUXdGVDJOaG0vOWlacjBaZHlEdTdRSTJGb1Rrdlll?=
 =?utf-8?B?eUQ3MWhmVm5tQ1REOVBDNG9HK3JuRXNGeGxKTDRaU0dQa1pyTU15bzJFa2Jq?=
 =?utf-8?B?VUdsZnR4eDRNVDhDSHFsSWpQWEw0aGxPcjg2S1RKY0VkRzM0b2pVVmExa3Zm?=
 =?utf-8?B?ZkIwMmY0WlRGd3BSN2pLZzQ5NlJVUkptTUdCSjR5RStxRWxWSTNjVG9Ccmp2?=
 =?utf-8?B?Ry8zcldwUWU4NG5nWElqS2NkalhYaGowZlhReUVVWE9VOTFzR2IvYUdCQ1cz?=
 =?utf-8?B?Qm1wTndyeU5QYWlLQStUaHRTWUl5U2ZXQTcxaWx2QlU5REw5MTNvL3UxZDds?=
 =?utf-8?B?bEsyN3o5S251ZHV6dWt2dXREbWZTNXVKbGI1Y3VSeTBlQnI5KzFMTEx5TkRl?=
 =?utf-8?B?bWVhMyt4YTgwMmJXL0hPODJ4WUZkUEwzYU54NkNpN3Zmb2l6UHhiTXhxbTIv?=
 =?utf-8?B?L1RCWHJtVWZNZ1paakdwZm1ldCtWWTRwNXMyS1RSR2V3c016cEJaMVZ6RUU2?=
 =?utf-8?B?OUpwWHdHcFA1UVZJOWRJZTRtQXR0RGZGS09qMlAyakl6UnBtM2xPdHl6VzAy?=
 =?utf-8?B?dGJzMnZZZTd4VzBtS0Q1RjJWdHVRb2tKTjJySjN4dGdmUXltT3ZOSVRJS2d6?=
 =?utf-8?B?ZlE0UFpLdkZxek9yQklQMXd3S0U4MDJDQ3JVdm5QelFzUXZJRjUxUUVVd25w?=
 =?utf-8?B?dnVxd3RWUk43RmlWUnV6M3dwOUx5TFYvakpFOTBKUkt0SVBrVFJqNjNiYndU?=
 =?utf-8?B?MXhMdGFaS2l2dS85bVRvNGpNcHFLd1p3SHlTSEk3aTdLbkdQZmhqOGZpaTFM?=
 =?utf-8?B?czRNYTZKbnZicWNpN2s2d0tNZVlNSkF6QnJDeERRYk1KelA5NnliRFRxdDlZ?=
 =?utf-8?B?Rjl6VDdGOG4vVzNjSW0xd3JRTjY0MTJza2tYNHBRZitxRkZrTzFsYXhoeFQ5?=
 =?utf-8?B?VHNiak4rdnp5WFhhZUY3eGRHUXJvWkJxcm55S001SDNOYnZDSTcyelZuZk9W?=
 =?utf-8?B?a3RvbjA5Z3ZvWUpVeWhka2xST0tCazZ3YUxtSmhuWkRoVUlFb2RPaFVFSnZP?=
 =?utf-8?B?bC9wbE1HaEJxM2xYVEZ2eEJsOHVyM0RJSTZDUFVGSVk3MjZaa2VERTFrZm4v?=
 =?utf-8?B?dGk4eS91OGJ6aWNmb0ppMmF5TUNBb0xNbHRoRGM5aXcxOUZWY3F3WHJQUlVT?=
 =?utf-8?Q?S3IbD2EmSIlD8x8g=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0105d91d-18de-468b-16d7-08de6fbd33ef
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:45:54.7100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ix4e+qSXHNeGmtuK7/GU36yo+4HUNlKtlG26LNxed8nGI4NfpjxQqiNDVMZZQvgH+Kbq6MMITMTePYzUbPTO0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10815
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

