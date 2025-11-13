Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09494CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 09:55:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C6C40BA5;
	Thu, 13 Nov 2025 10:55:43 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
 by mails.dpdk.org (Postfix) with ESMTP id C504140151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 10:55:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfZd5vUvYZ1Xk4pnwrCk1A6Podu+uAw0xidwPnSvCP/uAQbss3CZA4QkcOwfwPJpcFhw3/t6UlE39HB0DaFxxSKvXg2w4YO/lHhtrV9RNCP5YLUYBA9GVeNtNLRzyaFfMprGe+HDMeEgoipyOpfJg5r2Q3hQySJ51c7jbb5ezyHLxAt1AzKDPvFG7qghGNqZBZX4go6XNde3Inyem8y/kmY3i6YMGykqu9NuDMhDgHQXJq6n+HunZmo5i9/5T0QRE75YBUFm6UzbuhnlZWBTpL3A950LWD6OeF+tfixWNSMyuLzRKbxEZ771fOnxfcze5RdG/BxwB+OHMCEjpKpYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cqENfqoE+IPSyEdCpIMtI6sZ6AMwNQuubFmm3uHQhw=;
 b=b7OE5l8h8XyNNhHp57DzIeydoy4HtdBHc7uHtWSpAM6DrW1OMH9gm5QvmStl+hd7CblKCdG8hi6DAG1M+Ryth08C3OGQQcXjINRIo6IwMCKHH95Je4an18j8kWPcP7b8/JKpQFbdiO6GD69pB4vo2WRwT0Iebu5rMC2Q5jqY0UsJWIlgmdYMCeYE3zmd8Jf+vKrXBRXYku26yAXF+vmc2ue3texuVJrk5To9oNiKLkNjrOC6nBKq7XFQ1IEQlRXnwO9Owfbvv9FdKuNAq8BMPIWKE4eqvJYar1pwDAiP2WSS6nYhKIhuvpGnNLzOnk1lG8/1Nch/NPB2AiGKKPE6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cqENfqoE+IPSyEdCpIMtI6sZ6AMwNQuubFmm3uHQhw=;
 b=Q1kl6smkVKf4vb3Fu80eAgq6nKNym9H8tFLffCPYW8yw3K8f4LIcCm5NDfBcjEFHeWAGGoUcpdb8sQj8CIQtT3zhYdO1RIWItOKggfLmtGyoee8SzrlYjknPA5TS5ZFYUs2RFL51+E7QdMZev9qBMPqmnc1yQbq43dMFr5cY4Umoq4bAZZPVKX/VpIzIPklGSmSHxmM8ZoaXUhzVCFN5w/lOOXxHqOGl+EE7pZ6RXgVCgN07xzewytZAqh6UhV4vskU9SHQM2pebxO8ciSSfblD90im7o+1xY9xAaDAILhvl8mfjnpWADPR5Xb7AyEeDc3ahkOpzZZo0au11S7ziCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:55:40 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:55:39 +0000
Message-ID: <947ecef7-5986-4501-842b-d3df132befbf@oss.nxp.com>
Date: Thu, 13 Nov 2025 15:25:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] net/dpaa2: bifurcate close into close and deinit
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251113052931.1784953-1-hemant.agrawal@nxp.com>
 <20251113052931.1784953-4-hemant.agrawal@nxp.com>
 <CAHHRULWaiPD9qbVG0ujbMHZ+DoOH+Yp8vCLNRSbHvvSKcBOvVA@mail.gmail.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <CAHHRULWaiPD9qbVG0ujbMHZ+DoOH+Yp8vCLNRSbHvvSKcBOvVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: be9ac319-a783-46cd-3997-08de229acd0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU9yRkhkZzBTVkZ5YXE5bzE1Y1R1MTgwdlREU3JwcHRGeFVyNWxubXhZN05y?=
 =?utf-8?B?bldVdU9JMDV2YTI5MVZpTjNvaTY0NEtEZWJHMGtQMGJTZXNJekp3bUtrbFJS?=
 =?utf-8?B?RG5aT2RnRUwvUmxWd3JZRjdLZnpLMEkrazZRZlJ5VjJOdTVxODAvL0JrK3do?=
 =?utf-8?B?TWp5dU9UU1FHSWRMaXgrSWdDdTEyRGpUZ3hwaFQ1WnJGcERsNXZEL1dUTE9U?=
 =?utf-8?B?bXFQcmtzMTgyYmNNR2RNRVFEM3dPQW5vOFpwMWJ2NnZ5V1hucnhSQVNpaWE5?=
 =?utf-8?B?Zk5iajZkVTVhVzRTcEhqNkZvSHFiL2REWXZUVDJZZXYxVjNVdGdFRTBDNVhL?=
 =?utf-8?B?ZGd3WmM1dzhuZlhNdng4WGVzTCs4MDRlMFdEbFlKNWxTemNJbGlhR3lBa0c1?=
 =?utf-8?B?WGZVY21KQkE2VlBkQ3dYakgwTEVScHVyZjZjdWw0VXk1K2QyeDhQdVI0N1NP?=
 =?utf-8?B?dkU3TUlsRUVWQUNnNXJjcEcySDhheDNTdlBuZTlQazg0WVJVNUh5bjVuWE80?=
 =?utf-8?B?SW5WckE2KzdwSlBtQ0FUbTYvU1VaSWFNL3FlNUZyQnFQSGt1dlFZd3ViTndY?=
 =?utf-8?B?NnJjRXJqcmxQR05FaHBrTGNLTWNLOEsyNXVQMktrZUFlYWxNd1ZlVkdHWk9X?=
 =?utf-8?B?RjVxcVJuNDlJTmVFbGpOVVVOcnFYaXJ1Nk5zazRXMGxTdVlyZElBWHFidklI?=
 =?utf-8?B?SDJURXEzWEhUdTRmQ1hyci9kcER6YnNxbk0yenJBMW1wV2M4MzlnSktZc2lO?=
 =?utf-8?B?T0NENGh0cVBJUk9rd0llMEs1QjZmOWZzZTgvWlA3b0hzNjlGZUZFL1ZzU3Rx?=
 =?utf-8?B?bStqTWp6WlZsc3FrUFdkN0hXcGdnUm1kUnFyc1lTS0V0b3JDaWNQb1pWTkFY?=
 =?utf-8?B?ZDI5S0RnUCtpOVozaTNidThWQ1F4VG00d2t6NHhCSHhWM2JZWDlkU0FDUm9p?=
 =?utf-8?B?OWlwdVEvR1N6eWJxV0ZFTFdFb1hqK3RnK3Fnb2dqK2FrOGRmeWY1cGlpME53?=
 =?utf-8?B?SDNjdlJvSXZYaGRFVmJJcklRWmcvY3ZJRy9hamJ0Z1JZT2pWMzkxVVJJOGwy?=
 =?utf-8?B?Q1drdEVwcWdLRkxhOTIxdFdENnR0ZDJCc0R3NGxtN3RZR3RuMU1VNEtVeUhi?=
 =?utf-8?B?TnpHUGx4WEZWMk5PWTZGSlYxUzI5ZXN0c1hQQVJkVENqNFlya1ZtWm84K3c2?=
 =?utf-8?B?K3RlUWNmTzRDMDBIRVVZZXZhMDlSS1JPelRFeDBCTUdvM09sRHRnS0N3SnUz?=
 =?utf-8?B?c3ZpQUVJVDJGNHdDV1BuQmZaWitUVE0rQ3hZcEVHZmNUK2pSREx2SFlZSmts?=
 =?utf-8?B?VHpJMEJKM3JlUW5XL1U4RUdacm96ekZFYUluWlRJYlB2NGlReUxuLzEwWWdO?=
 =?utf-8?B?N2ZaNkRIYXRXT2lqUThGZnpVTisvRm5DVWJLNDdOakZkQ3dDS3JWUWFTNDVh?=
 =?utf-8?B?amRTK2ZtQUhvaERoRmZSZU0vTXJLVmZwWkd3R1BhUnI3OXU3eEJGdDVOYmNB?=
 =?utf-8?B?QVVrYUdvSU5DaG5HWmVXT3BuRWJac1lkNHpUbnphZ29UUjFWVXErS1N6MVVD?=
 =?utf-8?B?TWVJREtQZE00VVNTNnNTQTBVZnZYL2p1YzFpVVhrRVlVNEYrTGg2SXJzUUdh?=
 =?utf-8?B?L0hBM2xLZXlBaC9jZG54OHoyMFZMUFplcUExakNtT0Q4TE5YMCtxVm5nOE1X?=
 =?utf-8?B?TC90RDFlWFlMYS9KUDVxc1B4UXhtUzBtbWNnOGxjSS9uZ1l0Z1RDMEhNZVFR?=
 =?utf-8?B?ZW9pR2gwNUlESWs2SkhuajU1ZDA5SFovWEEzN0FFSVpNUW1tVk93WUxtY0tY?=
 =?utf-8?B?QnB0SzNOSm9qNkFjMzBkbHRUSEZzbW03SmYzZWx5ZTAxTVZrbExBN1l1dDNH?=
 =?utf-8?B?UXBnS2hYRFZQNjE1TlBoZUVHU1luZ2Vuc2Y2OVdlWC9xeXpkZjAwamRBVnli?=
 =?utf-8?Q?pzylBxM6EPkKnwlpb4srhRkRBYfIhwSc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXF3REo3Z1BIMStvZDc5N1hld1dJcGEzS2NsMjM2UnRlbGtmSEJuZUljLzVm?=
 =?utf-8?B?VmFBQnZnK2llTzcxOThkaFdaQWhMbEZHWi9GVkh3NDcrcDlYRzBUWllIekN6?=
 =?utf-8?B?bjNhNU0zZDVObFI1NU1UdWl5TjQ1WkpyRTZEQnJRTWg2TUVIdStvM1hnTU9E?=
 =?utf-8?B?aGRIbzNKZDNPTCs2QUdxSlNOUHAwbTRBNSt3azB0bElyLzNCT3dmQUpIenp3?=
 =?utf-8?B?S2tNMCtIcUo2S1Nzc2hGQ1Z5dHR0WlVEQUk3eVFNR0NvZEZjNUptTGFwYU9O?=
 =?utf-8?B?YjlJdkMvL1k2WDd0bWNiVVUrNmlMMVFZYjRaYlp2Vjdra3Nwd2ZSMVAwK0w4?=
 =?utf-8?B?M1pKVHhjcUpMdFdaMjV2ZkRlMjBTRUY3aFBOcm1iM1FBR0tiZEZwQ2MrUVly?=
 =?utf-8?B?Y3lIWENNRDYvdS9KVkFQQ0srcmpjbkNtdnhWaFBpWTVmcTU5WG5wcFRHeVhT?=
 =?utf-8?B?L2Nhd3AxT2VZRkRYQ0lkNWxUYzJqUkt3aEI0RE1DVXFGc29kWTdoYjVmbEN5?=
 =?utf-8?B?K3FtZUdHTDF0bU9oaG1iOHdFSWNBcCtteG9FcDQ2eFBod0dlNERJVDBIbGZQ?=
 =?utf-8?B?d1Q1ZzRxVG9Tc1I1cy9UNEwrc202S3IwWFAwTWFJRGFjQkRFdDFrZDR3cjFh?=
 =?utf-8?B?Mm1xU296TVhYYi9RVENqbnBCNHhWYmFXZCtzK05qc0ppeEE3TTZPL2UzQk5M?=
 =?utf-8?B?d3F6RlRPOXI4RWk3eWIvZldiMWJ6dEk5amdRL3BCa2haNHdUZ2tKeWk2QlJn?=
 =?utf-8?B?WVhrQ1VydndpdGZJR3IvczI4SVRGQ2pYRTZWVXNvZHYvUUF1SFBWcjdIM1FQ?=
 =?utf-8?B?VDlON29RUVlqZDBrN3lXMTRnT3ZZbUxDTWFXK3p6czVaM2lmQUtZbHhNa2ox?=
 =?utf-8?B?bEdQaEZqTzdJS0lHQ2tNOUt2ZVN5cG9sSVo1T3RxS05pd2pTS1BVNmI0M0Fa?=
 =?utf-8?B?dmVTQitIRVdrVzhQZEhrM0dJdXg0ejI2M05Id2RlNi9MQzRqdCtBbnpCQmYw?=
 =?utf-8?B?azdXcm1RbVJDbnRibitQdlJjWnNqaHN4RnNVbnBEWEl1VG0rVTJRY0IrR1hj?=
 =?utf-8?B?eDQvTytNQmxuTTdSTkdxWXhTaXZVOXlDekhCeTlSV0dTRzkwMEVGdmNvSUhh?=
 =?utf-8?B?aDEvOWtZdGJjUEdJa01WMXJ1dmZQSmNHU3BJT0tNUCtGc05jT01BaHJ1Vjkw?=
 =?utf-8?B?Tjd2dThRa0hFVVFiOHhCZjA3dEhaYUNhUXlXVzFYT1E4QmlOUVRMMjZ0ZGxv?=
 =?utf-8?B?YmJWaitRZmhjR2xRQzZ6Qkl6ZEhoNk5mbnJrN3J0dnhDejZjOGlXZmI5eTR5?=
 =?utf-8?B?dmFqanpQbGFYNFJPM3Q2dlViY3ZFbXptMnB6bGpBL1FZOThrbkVySXRFTGls?=
 =?utf-8?B?SlBUbERLeEttck5vWU1WTm5qRnNHTmpra2RhYzZNTGJRb2pkWUd3UGtoS0Jr?=
 =?utf-8?B?Vk1pUVdlSGdFdkYzbE5NempEY2pWOGtIRzI1aFh1c1BrRmgvczRjd2JwZldS?=
 =?utf-8?B?RkJwU2FtVS9LQ2g1REYzNFBVVWt6ZnRORTFCby9FbHg3OFlEU21TbXpBVG96?=
 =?utf-8?B?QjhMc2RoMzFCK3dGQW5JeW1RZDM3c0plQ2xyejJtdVR1RFJPanVBNXkxMzV6?=
 =?utf-8?B?ZXpyWVBGSjcvVW04RkZSczlXTENNcDA3L0xtaGVRTlU0R05lWFJUc1U0RGVC?=
 =?utf-8?B?ajVXRitGNkpzb043TnZ0OUVMa3V1NVV4cnNxOG1yMDdCY0tJVng2Z3F2dFIx?=
 =?utf-8?B?OFBKNDVLc3lmOGNxOXR5QjNHQXdScjhLSFlOSUFoYURweXlJL1NKNVh2RytH?=
 =?utf-8?B?R0ZtTCs5VkpSYW9IVnpoRzRjaHFPUkRMRnRtWDJGVGFzRkZmZk5MLzRjOVdY?=
 =?utf-8?B?MlhFVW9xb0d2VGk0a01XUUh4Mk9rY05Zd3NLUVdoc3VDcmVJT2ZzUjRTSEVs?=
 =?utf-8?B?RjFJMlR4cXNOSWNxZDRXV2J2QUkrLzZVZkFZUUpIeUlpNzNLbUJRNXFKblRU?=
 =?utf-8?B?dElOczlad1o3MVlLYVduTWx3alpKbHlicGYwSFg2bzQ0ZWt1cTJONCs4bnlH?=
 =?utf-8?B?REpLTTBmNUJmZ1FRZC9QSlZCZ0N5R0hKdVh5TTBjMDdoZGpaeVl1d3NXeFRW?=
 =?utf-8?B?bGhXOElmUExQaFE5YmUvRTRLNGEyUVUxMytsbWdRbkptTTR1UytDTWpWWjRz?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9ac319-a783-46cd-3997-08de229acd0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:55:39.7551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itKKaWWdg9ZCsOhJeY9cCg5qV7adUfRKjjPOlkfpE8Hcn6hQnI/LbF1EQfPIc89EBGIkdJM+u0aYDOm3WgSbLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951
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


On 13-11-2025 15:19, Maxime Leroy wrote:
> [Some people who received this message don't often get email from maxime@leroys.fr. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Hemant,
>
> Le jeu. 13 nov. 2025 à 06:30, Hemant Agrawal <hemant.agrawal@nxp.com> a écrit :
>> The close function was overloaded to be also used as deinit function.
>> This can cause issues when using functions like hotplug.
>>
>> This patch cleans up the code and implement separate close and deinit
>>
>> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
>> ---
>>   drivers/net/dpaa2/dpaa2_ethdev.c | 92 ++++++++++++++++++--------------
>>   1 file changed, 51 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
>> index f82c50341d..0cd875d715 100644
>> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
>> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
>> @@ -1524,53 +1524,14 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
>>   static int
>>   dpaa2_dev_close(struct rte_eth_dev *dev)
>>   {
>> -       struct dpaa2_dev_priv *priv = dev->data->dev_private;
>> -       struct fsl_mc_io *dpni = dev->process_private;
>> -       int i, ret;
>> -       struct rte_eth_link link;
>> -
>>          PMD_INIT_FUNC_TRACE();
>>
>>          if (rte_eal_process_type() != RTE_PROC_PRIMARY)
>>                  return 0;
>>
>> -       if (!dpni) {
>> -               DPAA2_PMD_WARN("Already closed or not started");
>> -               return -EINVAL;
>> -       }
>> -
>>          dpaa2_tm_deinit(dev);
>>          dpaa2_flow_clean(dev);
>> -       /* Clean the device first */
>> -       ret = dpni_reset(dpni, CMD_PRI_LOW, priv->token);
>> -       if (ret) {
>> -               DPAA2_PMD_ERR("Failure cleaning dpni device: err=%d", ret);
>> -               return ret;
>> -       }
>> -
>> -       memset(&link, 0, sizeof(link));
>> -       rte_eth_linkstatus_set(dev, &link);
>> -
>> -       /* Free private queues memory */
>> -       dpaa2_free_rx_tx_queues(dev);
>> -       /* Close the device at underlying layer*/
>> -       ret = dpni_close(dpni, CMD_PRI_LOW, priv->token);
>> -       if (ret) {
>> -               DPAA2_PMD_ERR("Failure closing dpni device with err code %d",
>> -                       ret);
>> -       }
>> -
>> -       /* Free the allocated memory for ethernet private data and dpni*/
>> -       priv->hw = NULL;
>> -       dev->process_private = NULL;
>> -       rte_free(dpni);
>>
>> -       for (i = 0; i < MAX_TCS; i++)
>> -               rte_free(priv->extract.tc_extract_param[i]);
>> -
>> -       rte_free(priv->extract.qos_extract_param);
>> -
>> -       DPAA2_PMD_INFO("%s: netdev deleted", dev->data->name);
>>          return 0;
>>   }
>>
>> @@ -2891,6 +2852,55 @@ dpaa2_get_devargs(struct rte_devargs *devargs, const char *key)
>>          return 1;
>>   }
>>
>> +static int
>> +dpaa2_dev_deinit(struct rte_eth_dev *dev)
>> +{
>> +       struct dpaa2_dev_priv *priv = dev->data->dev_private;
>> +       struct fsl_mc_io *dpni = dev->process_private;
>> +       int i, ret;
>> +       struct rte_eth_link link;
>> +
>> +       PMD_INIT_FUNC_TRACE();
>> +
>> +       if (!dpni) {
>> +               DPAA2_PMD_WARN("Already closed or not started");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* Clean the device first */
>> +       ret = dpni_reset(dpni, CMD_PRI_LOW, priv->token);
>> +       if (ret) {
>> +               DPAA2_PMD_ERR("Failure cleaning dpni device: err=%d", ret);
>> +               return ret;
>> +       }
>> +
>> +       memset(&link, 0, sizeof(link));
>> +       rte_eth_linkstatus_set(dev, &link);
>> +
>> +       /* Free private queues memory */
>> +       dpaa2_free_rx_tx_queues(dev);
>> +       /* Close the device at underlying layer*/
>> +       ret = dpni_close(dpni, CMD_PRI_LOW, priv->token);
>> +       if (ret) {
>> +               DPAA2_PMD_ERR("Failure closing dpni device with err code %d",
>> +                       ret);
>> +       }
>> +
>> +       /* Free the allocated memory for ethernet private data and dpni*/
>> +       priv->hw = NULL;
>> +       dev->process_private = NULL;
>> +       rte_free(dpni);
>> +
>> +       for (i = 0; i < MAX_TCS; i++)
>> +               rte_free(priv->extract.tc_extract_param[i]);
>> +
>> +       rte_free(priv->extract.qos_extract_param);
>> +
>> +       DPAA2_PMD_INFO("%s: netdev deleted", dev->data->name);
>> +       return 0;
>> +}
>> +
>> +
>>   static int
>>   dpaa2_dev_init(struct rte_eth_dev *eth_dev)
>>   {
>> @@ -3177,7 +3187,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
>>
>>          return 0;
>>   init_err:
>> -       dpaa2_dev_close(eth_dev);
>> +       dpaa2_dev_deinit(eth_dev);
>>
>>          return ret;
>>   }
>> @@ -3381,7 +3391,7 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
>>
>>          eth_dev = rte_eth_dev_allocated(dpaa2_dev->device.name);
>>          if (eth_dev) {
>> -               dpaa2_dev_close(eth_dev);
>> +               dpaa2_dev_deinit(eth_dev);
>>                  ret = rte_eth_dev_release_port(eth_dev);
>>          }
> When a DPDK application stops, dpaa2_dev_close is no longer called.
> This happens because eal_cleanup() invokes rte_fslmc_close(), which
> then calls the remove function (rte_dpaa2_remove) for each DPAA2
> Ethernet driver. As a result, dpaa2_tm_deinit() and dpaa2_flow_clean()
> are no longer executed.
>
> Another issue is that dpaa2_dev_deinit is now called in secondary
> process, which was not the case before this commit.
>
> For comparison, other drivers like ixgbe call their close method from
> the bus’s remove callback. I don’t see any issue doing the same
> here—calling close during remove if the Ethernet device is still
> allocated.
>
> As far as I know, there is no counterpart to rte_eth_dev_close() in
> the DPDK API (there could have been an rte_eth_dev_open()). The open
> path is always triggered by the bus’s probe callback.
> Because of this, it is expected that dpaa2_dev_init is called from the
> plug/probe path, while the corresponding deinit logic is handled in
> the close callback.
ok, it looks like best approach is to drop this patch.
>
> One more point: why isn’t dpaa2_tx_sg_pool_init() done directly in
> dpaa2_dev_init(), with its corresponding cleanup performed in
> dpaa2_dev_close()?

dpaa2_tx_sg_pool is a global resource across devices; which is being 
tracked with dpaa2_valid_dev

we will be revamping this logic in next major release.

>
> Maxime Leroy
