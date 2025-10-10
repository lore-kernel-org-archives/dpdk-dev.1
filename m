Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1EDCCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 05:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D11AC402A0;
	Fri, 10 Oct 2025 07:32:08 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
 by mails.dpdk.org (Postfix) with ESMTP id E096C4028C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 07:32:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3yRsWB6CHZHnDj4l8YjkzTyv7J5Up1yNMTTfLDuYf5nm1Fk2H0AZW1r57nDudu6T6igDouJQfnabVaFNbUf24/Ro+RTFdCRGZJMK54V3++fEtyFg4m+3H0G5oibjFX77/qcBJQo2KR9i03tN3eAmTBxVwY65VcY1QlYEw4v2NwZvyyT6fUC+EEq+M1DzFx8nBxPz/BKHKarOpDb+NwnGiTIjRlAiRlbUmQm8J3nNk4tIPvTrWZLGHEHkUmJhRxZcaqz2F947FHP91D6CXgu7kw/OL3dEmcbas1EpZWJBvSYn2AcmrT9BTlZgTMT69xgKko/4BmTTHQkly/7fYwD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMXR3fM35C4pBnF75L5eixg1eSE2sOY4GakRLPbI030=;
 b=D1zk7/tQChS8sVXgAj0mp0U4DJdvIEOJ+TpaNcRBv8AbeUOQEfSzt/6THZrObb8mEYfJ5hN/imemRx1H/UmMPb42nJJcYF8Q3cNx0DSCoBfYi7Eav0535iMF8dFdjmi8fJIXK9r4iBJjwsNM6Swxp+6fC3znYMGk+/sPEIousQr+NRrYNocFfu45ADdoazkUE71VRKrgxGh9lrV//ZpNkIn6X4kf4t/Z2Tjy4zt0RBc+DOUFtAyVAAQoGW4n+ErschoahIpGwVn6xkF4enfcZ4qDdJh75+5RWjagkTnJKFtW94e1LNHM/Icwlk4kMhcg7ds36/BaQ5PqaAk9/LKa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMXR3fM35C4pBnF75L5eixg1eSE2sOY4GakRLPbI030=;
 b=dfhl+Czqehl6ODdxxRK8IotKfwEfSmbvsECoF1YTDk3mPzo8NNy63wCraesanvCccdAStQbOwMRo+RO/RB7K9j0gITvqhJxZlFhZxXpDMYGKifQqfsBzP7ckQ+ywHEMskoMoGL2X+R4eftgwE0BQUuxqASXCfSfYl0QU8OlUh/wU47kKrFLGaZzSlQcBycdYJAUx8SSb9aC1gpIhOk+5AxDab9TnmUTLoAIC2KDguVi7T3tbfwlXwplNbCpwCU5kOJF+MRCwKQFUMUe8Kw045VtOjN77iOvomEQdoqECIDzjTZrok5m1ExvZv7rIWkCFO3yTh2QaoFLKJrmkFD8zNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AS5PR04MB9729.eurprd04.prod.outlook.com (2603:10a6:20b:650::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 05:32:06 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 05:32:06 +0000
Message-ID: <68be12c7-e1da-4cd0-ad18-3efb7326065c@oss.nxp.com>
Date: Fri, 10 Oct 2025 11:01:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] drivers/net: update to remove queue stats from eth
 stats
To: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
 <20251003110201.1541183-5-bruce.richardson@intel.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251003110201.1541183-5-bruce.richardson@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AS5PR04MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: b6afcf20-9c12-433b-c003-08de07be5975
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zm1URzNDMDhvcHhSMWw5ak5obHJWYmExM21taGhYT2VEdVJIY20xakdTNSs1?=
 =?utf-8?B?dUR3MVE4bTBMd0ZUeFZOc1VzUDB3ZlVRL29VSThsek1BakpFVUlVS3N4alM2?=
 =?utf-8?B?Vy9MU25Dc1BmempXSDhnaVp6Sk5Ua1pXMkVsallXU0Z3RFBZZUErNHNrU01B?=
 =?utf-8?B?blZQMVh0bnV3ejNDbi9TQUlpVGY1dzJHd0J4WVBPM3VZV1B4VjlHZkNBbFgr?=
 =?utf-8?B?RDBaUzhYd2ZLcWszWFFJd3dkWFAxVnJ6aXZUZDlVRWdSOExtOTJISXlsRHBU?=
 =?utf-8?B?SlR4dVlmTWQ5NElpVnpaVzZYT1gveDdaVmNSMmRUaTZxWkx1NlVDeHFHMWdU?=
 =?utf-8?B?V2hLcnVieDlvSVJ6b1VsQ0hrL3FJMVY5K1lBNW1ueTNRWFhRcVJmM0hiMk1B?=
 =?utf-8?B?VUVWSm81b2ZFQlVPc1MyT0lzODB0RTU2ZGQ4SkwvS2JOYTZZZzFlN1hnME1H?=
 =?utf-8?B?Z2R6TG1OUnUzV0N3N29zWENTb1NYYVVwTm9DWWxuWHNqOWZsTDZRMjd5RVpx?=
 =?utf-8?B?dkdyRGRpaGIyMlQrcDM5Wm8veHd2eVY3M3R4SEdQRGNnMUZ4SUNGaVR5WHFm?=
 =?utf-8?B?V2VQditSRkthRCttWVpSV1h4NE9VdWRsbmxrc3lVTGZBQzZDRE9NR1JGQXVi?=
 =?utf-8?B?Q05KUDNuaXNJaXJoRzl3RExBOWdRc3F0YmNJaHcydDhPSFFSZmdNeUViSURx?=
 =?utf-8?B?alcvVWc4Z2VEWFpvR0Z6YjhtRlBEbkoxcktlN2xYdkFoZ1JlblBBRTVVbVNr?=
 =?utf-8?B?QjVDamVvZzhJdDFzcUhkUld2MmRROVJFR1BVNlFxeUhWVjJIUm16TTdMMTB5?=
 =?utf-8?B?aUt5NC9qaWV2N2dUT1lKOTN2Zk9JMlZtVzFmSnQrL1hONGJkSnc4aVRZZkJa?=
 =?utf-8?B?SVQzbmZtUEZxQU00cEhBbEpHV1JiT01zMmw3S1dFQzFoSDhXc2FnVlo5ckxL?=
 =?utf-8?B?eDFmQ2o4dkd6eDhXUkp1bzc1S1hLQUZ0Zlg5TlNOVHpqUDk5NEJJbm9jMi95?=
 =?utf-8?B?ZUhxOVJCYVM5TEVIZXVvWDVtdkgyRkxydjJTM1hVejdZT2M5ZCtObkJzMVIz?=
 =?utf-8?B?aGF1RmZITWhDYndyS2JkSk4rMURCWEhEUlFCRGJIUDgrUmJvOTR5MzRVNXNO?=
 =?utf-8?B?aTY4WWpUZms4TUR6cFRYVFRIa2RXeFhCRWlBcWxYdWxLNHZMSnhhWExHZHVL?=
 =?utf-8?B?NTBZNUtMRm9lajUxcGh2ZDQvejJXS1JEMHFTaVlGbEpOZk5LUmY2ZG1xT1hx?=
 =?utf-8?B?UTRJRUNGT21kVk9ENWdaN3pHQ1RzQXVWejJJa0RoUEFuTS82L2FqUHZFTmpi?=
 =?utf-8?B?YU5OM2EraGMvRzFDUGY1dW5RRXZnbXZhL0xhQmdZZGlYRHBpRXR3WGpyRGlv?=
 =?utf-8?B?YTl4UUFaUzNza3V0TEMzU0lEMy8xVC96UnNDbzdWWTkyZUY3Q0lPRXZqNzdw?=
 =?utf-8?B?MHNwckdxalA4WVhsWWV2Wnd4OTVOeWFQNm4zOVVmVG5SVkpVeTBSMVNFQjJ4?=
 =?utf-8?B?TGQ3RjRjeFE1azdNL1dMOEovaGsrTlJoYU15QnplYUtqQWROVjBheWZqUjM4?=
 =?utf-8?B?c3dLRFh0aWUzTmh2U28yWDBoblNBR2E5OVVyZFpmeDNVNGxEVXpKU2EwZjRJ?=
 =?utf-8?B?L202R1BkK3RycVBRSGlGWm53M1RqZ3l0NEJ5Mk1zcFV3U2d0aDVROThxK1hM?=
 =?utf-8?B?SitvWHFYby8yRGxWakVPMk1EV05WWlhJOUtub0VLTW1ITG1nTGZUcEpQeVFK?=
 =?utf-8?B?cVc5MG5FWEFTMEIyZit4aHc3WTBwd1pORlVxRndoT3B3V1k0TkJBcmxUZnd2?=
 =?utf-8?B?cjRCSlNXSUFaa09wdkhqSlJadDVXcm5pcnJrakJrV1AvRzEwNHJkMGxuclB2?=
 =?utf-8?B?UFcwUGdVZUhDcTduT1lNVkdWS1NQTUlZc2dwSmZNbjkwNVBoS1RLVitlSGd3?=
 =?utf-8?Q?MIkjBpfxAlpJOMdEPsZMBbB5xMGorN/1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RUZTFmbTVnL1pOcTFlNU1IaG8ydWQ2VzVrTVNKRnRBak1WS2tTbWl5Y00z?=
 =?utf-8?B?Z1NvTTYrSy9xMGZZTkJyaEttZEs5R2VIUHZLZm5kTjRtbUVDVmZnRmJOTlZN?=
 =?utf-8?B?ZmhGa1ZLczk4bmZ4SlJWaDVQZFlyMFhwbGcyNkhDWWFNNTFwQ2xjeG5LMTIx?=
 =?utf-8?B?Rmw4U3U2SjZNMEo5RUI2R2xrdkdONDFDSzhBYURjajBlTzgwV0IyV0luWHQy?=
 =?utf-8?B?VERFV1VRQnNMNXhyTTUyTVJyblpIdjlYTXR6ZlZKdGFITGo5RW16MXFQRml4?=
 =?utf-8?B?dytuV3o4ZklmUWNDR3RBSEFoeXZlQW9NaHdJdnFLWURSeWpjdmpEQmlNNnRz?=
 =?utf-8?B?elMranM1bDVhR1BaOHhsZVVvZElDZUwxY2NSS3phWVgrTGNVVll1Q3V1K0ta?=
 =?utf-8?B?WG5NTnBNdktvQVZ5cXRVWmJiS0hiQVhydTNEL3hZdm81VnU5eGxLRWFhc1hK?=
 =?utf-8?B?c1dEUEw1UFRsMXMrb2dYZlBZdkQzR2ZVOWlET054aHNQb3RuRDRMVG1PVXZh?=
 =?utf-8?B?bEZWYmhYbXVvc3V1aXd2Rk1DYVdZNGx4bFRUd3FWL1V6d25YZUpjb3RDRUFr?=
 =?utf-8?B?amw3S0g1Vko1UWhPWXV6MWZjOHkrQ1QxckRCeXAzWkJCMGVMT0paczdqYWFO?=
 =?utf-8?B?djJuN2lYRWs5bFgvaEtvZ0hGaW12UTAwdG9mYkI4SzVHMEpFbXM0MkhFUXFZ?=
 =?utf-8?B?UDkzTmtTeHRoTEJFUnM5eVY5azFlOFVJekxtbjQzZDlhNUo0d1JjbDF3WUhI?=
 =?utf-8?B?WWtLMUk3UkpSbTQ2bkJvVjJoRmwzNVpWTEZKM2txZjJ1SW9Wdmh2dGNKN0FG?=
 =?utf-8?B?bUhLbUZtNG1HZlNBN0tJZFZjZWlmWW1BelJFRTJlaUJGTjZ0TFFqU3B5Y2Iv?=
 =?utf-8?B?b1pGcHVBL3VwT3hLbHVzQkRML2hYd1Y5VUhjTUp6Q2lELzZrVktPOFJ6a0p5?=
 =?utf-8?B?WmFIOVFpcGp3dFdxbVpmc01GSG9FcTREQ1BSWEY5ZlZScDhsMTJ3Y3B3OUQw?=
 =?utf-8?B?MGxCaTUvUk95aDY3VUhRYi85NTN1STdvcVFlelQxa1MyRExmZlJ5TDI1WkJE?=
 =?utf-8?B?bUJ3dDJ5V0JPRXl0MlpwVWRWS1ViSVJUUjhaY0UvMGxZYXNuVzFLSVR1dGk5?=
 =?utf-8?B?N1Y1KzloZzlLQVZyeGt0RG1FaFVLcVR0MmRXMmtHY2kvcXNnK2FMV2YwN1RW?=
 =?utf-8?B?akVXWmVPd3o5SUQvcFIyczJubE1ZWE1JVEp0bUFwZmI4QjQzUTcwSEJtREN1?=
 =?utf-8?B?TElaTE50VHVCVXlNS1FIam1oMzB3a2FZT2FJcWdVL1NNN2paZFZQTXlVMVVz?=
 =?utf-8?B?YU4rSjJ3ZElqZnhuWjVTeWNRWXJhZ01wZk9Od3ZheHdKSXgrbm5yS2d1TTg4?=
 =?utf-8?B?UzM4c2RCMEF5YVBWMDFQd2JFRmNBMEd5QnVSRGtlQnhEVEVmTkdjU3VqNll4?=
 =?utf-8?B?bGMzZmh0eUtBQ1AvOFdwbjFST1RjTmdiMjhxbCtXMDY5UDJ4ZDh2bk1qMmNS?=
 =?utf-8?B?SVVKcTJBeHVCYlFSUVpuZ2xsd3lrSk9DR2JWNENyVHpQdkxZU0xVUUN3bU9O?=
 =?utf-8?B?ZFE3UE5QN2UwR0k5UGpjSkhKeG12bDFjSm5EWXlwSFo2UDlHT1RiejBBU0hI?=
 =?utf-8?B?Ky9HcE5xNEUzc1VHVnRkNklIb3c2eERyQ05NeW0reTNMTHlYK2JoWUUwT2U3?=
 =?utf-8?B?dmMyUWF4MUc3UkhJRkJPQnRKK0RseUlaNnJXQjRMR0dEMmpkVyt0YjdibDZv?=
 =?utf-8?B?M2RCUytBaXZBOHF1dktrc0N3bkxCdmdZNjFjdWc2TXMvK1VXVmcybzlHbmF5?=
 =?utf-8?B?c1JKUWdUUUJSNStEUUZhK25VNU5aWHQyTUJDQmorOVBNbThPQ293S1JlZFJ1?=
 =?utf-8?B?RWorQm4zRW5INmdOQm03MW1xL0IwamZYS2paTGpCTzdrOVNDdVh6eFlFbVlx?=
 =?utf-8?B?VDFiRlppUDhoL1ZEQk1ndk5USHVJZDNKNS82eEt6eGtha2Fka2JrUlppcWJ6?=
 =?utf-8?B?dW0rR3BiQmYvNElTTkQvMHRMMFlRTDBHcGdhSFdsSjRRN3ZCakYvZUlyajhh?=
 =?utf-8?B?c2o5WXprdDkvVy9BazFPaHdlMkFzOE9qQlExQ1AzWlJjV0FwcnpCNmF3MVBw?=
 =?utf-8?B?UDNzTCtkTllHTTUvVk15R2puVmlZYmZZeEdYbk05aFpSbTRNVElwc0E0Z3VM?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6afcf20-9c12-433b-c003-08de07be5975
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 05:32:06.3834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG5mOXADto6cNR3/jvvF82wI6SCuu2OrVvciqLwCp66nGyrKIE9tai1mFpxBa49OyLVmkwdAftY5qPcdh5NtcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9729
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

On 03-10-2025 16:31, Bruce Richardson wrote:
> Now that we have removed the queue stats from the ethdev stats, we need
> to update the various PMDs to take account of the changes.
>
> Update each stats_get function to take the extra parameters for qstats,
> just marking it as unused if the driver does not fill in queue stats.
> For those that do complete queue stats, update the structure reference
> as appropriate.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/af_packet/rte_eth_af_packet.c     |  13 +-
>   drivers/net/af_xdp/rte_eth_af_xdp.c           |  35 +++--
>   drivers/net/ark/ark_ethdev.c                  |  36 +++--
>   drivers/net/ark/ark_ethdev_rx.c               |  14 +-
>   drivers/net/ark/ark_ethdev_rx.h               |   3 +-
>   drivers/net/ark/ark_ethdev_tx.c               |  12 +-
>   drivers/net/ark/ark_ethdev_tx.h               |   3 +-
>   drivers/net/atlantic/atl_ethdev.c             |  19 +--
>   drivers/net/atlantic/atl_types.h              |   1 +
>   drivers/net/avp/avp_ethdev.c                  |  20 ++-
>   drivers/net/axgbe/axgbe_ethdev.c              |  22 +--
>   drivers/net/axgbe/axgbe_ethdev.h              |   1 +
>   drivers/net/bnx2x/bnx2x_ethdev.c              |   3 +-
>   drivers/net/bnxt/bnxt_reps.c                  |  14 +-
>   drivers/net/bnxt/bnxt_reps.h                  |   2 +-
>   drivers/net/bnxt/bnxt_stats.c                 | 133 ++++++++++--------
>   drivers/net/bnxt/bnxt_stats.h                 |   2 +-
>   drivers/net/bonding/rte_eth_bond_pmd.c        |  14 +-
>   drivers/net/cnxk/cnxk_ethdev.h                |   3 +-
>   drivers/net/cnxk/cnxk_rep.h                   |   3 +-
>   drivers/net/cnxk/cnxk_rep_ops.c               |  15 +-
>   drivers/net/cnxk/cnxk_stats.c                 |  49 ++++---
>   drivers/net/cxgbe/cxgbe_ethdev.c              |   3 +-
>   drivers/net/cxgbe/cxgbevf_ethdev.c            |   3 +-
>   drivers/net/dpaa/dpaa_ethdev.c                |   3 +-
>   drivers/net/dpaa2/dpaa2_ethdev.c              |  28 ++--

For dpaa, dpaa2, enetc, enetfec

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>



