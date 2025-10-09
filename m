Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E94CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 16:06:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B4D1402A0;
	Thu,  9 Oct 2025 18:06:55 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013007.outbound.protection.outlook.com
 [52.101.83.7]) by mails.dpdk.org (Postfix) with ESMTP id 746E140267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 18:06:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUlbe6lbqx26p3pmIS+40e2y/nclaGCvX2Xy7vBbO2LNp7pcWPzHQj+YlmKfVSrB8TwkowFopQ73n8JnFDT/BUeOyBweylDzKx7zGQ5caX3Jv/iQei9MCy9MGR9X4nDsR3JjsVFiQNUdVehlpoJvCZRBCj3klDXeOF6Ptedlv7ylGVPCKkvGHby3PATclI91PqvCPYoQ4n+zysm9vOL/7coy4DAtKbVjWPnNJEVvN+jOJXP54tuvwBNpMUOJDOkptSMmYdVz82UwS/w2vOX18MRlubhtzSNN6/9RPqAvZvDTk/5X8tOJiLl6/O617uSlzPB93x6rRviLb4EMi8KwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye7OyPK8ceobDVxmeQal5DcLXvz7dgQ1ln8jO557clc=;
 b=rr7cM4pkeU1QbQCU9lH4Ks2eh8nay3iQq2wt63+DLo4Mc79y05ZGoz+7/No4dDNEgH/pZYKRouqXw8rA/tV9XAMydaVEwssCJwM3oRsZKjfpNd5vfzNlpe5WOPX1bILZvfXqmU21IGLBSBGG+hS7uCO+dgDLIVtwdtiHpqamthL7xuQ/w4fWAFuxTeq+xf2SDJIoBJoJNvl84akNLoTKkcZFPN38SkoHYIws5ncIhIAMcseNyZh9jgaULJETk9KfP5dNrMbuy7JVUKHNBIEdQQTqTJAZyJ6eZEgiTWL6TnnqYe5VKouGy1196OLhOH13c4fFVEeDuGPEqSk8EbjL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye7OyPK8ceobDVxmeQal5DcLXvz7dgQ1ln8jO557clc=;
 b=OTZBPVAG0HdlRnDRw75y1KHiO2m0EOpt32brz9TMxtwZYy6NOkrJo7OZzueMiA5cfx5cjQXlgOeen7LaQeIwnke2Kp4JP//DofihTaFKE2Dcm02l15ea7psWAGgScV7iI8m5Jz/JajI/6qzIg3nAjWzy6R/Wq1kMaCMZcHN3TvRjzA6f1b+y9iMaDRT19uVzUchFECuCeZ/ffchl+in2S/fF/ZGNLEGPa5sVaQifn/MGI3JtvSLU9ZKpvtb/ojy3B5qxUgL0IogJc0Si3wwXxLhe0pw0y+68Yf8XhQtXGSgOsJWbdrLidY0+hO9OGwjlpVXq3migTG1qmNuzDntF0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 16:06:52 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 16:06:52 +0000
Content-Type: multipart/alternative;
 boundary="------------eu3I2jkdR0YVyICeiROscw5o"
Message-ID: <e3c1917b-d9fe-4222-9989-00cf80164233@oss.nxp.com>
Date: Thu, 9 Oct 2025 21:36:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 01/12] net/enetc: Add initial ENETC4 PMD driver support
To: vanshika.shukla@nxp.com, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251009111633.3585957-2-vanshika.shukla@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251009111633.3585957-2-vanshika.shukla@nxp.com>
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PA4PR04MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9da3a2-4311-4851-d070-08de074ddbe1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW1sVnhRYm5pV2FMVmxWeE82SHhMZUltNHdhM3VTalg3Tk84UnMvUllLNit6?=
 =?utf-8?B?Rmp2ZXVTRHNubHVSbCtkM3dxZ2xaR0tWdTRrM0NwUjdvNGl5R2dVNzFDOTdT?=
 =?utf-8?B?Q0I5a2Z2ZlhvUTBJSWxuMk9tZ2xkVXllN3RzbDNIZzlNbXNQcjA5Sit0QTNG?=
 =?utf-8?B?NGZvcW1iQUZWdmJDV2VPK3JSYkVtRFFMUVZ3bExoT0x4M0dwS3ZLMlhhcmRJ?=
 =?utf-8?B?dXRGY3JaVHRoUktFRzBMRnVMR3d1amo0ZUlPQkw4SnVWeWdWRlFKbkJaZVBJ?=
 =?utf-8?B?RlA3azZXVVZleVFVK3pnUnBlbkM5d0JkYUJvSUtEUS84WmlwOWtZMm1ScVFG?=
 =?utf-8?B?ZDBjWFIxREtsZStxOU1UTERsM2lTNC93cS9HL0YxU29hcFdsbElrM2l6Vmt1?=
 =?utf-8?B?VDhzOW9ZOVdaanFVNXJtVFFKMGVHeGJxNDdZV0pUZTczMDRKTEwzUGRoMk5F?=
 =?utf-8?B?Mm1vZVF1QjVtMGx0cmt3Z3J4NXYyQVlPQmd2dmZ4N0FUcG9lY05oNFRsUGc5?=
 =?utf-8?B?T0Y5bkNKS0F1Z2JIalphSEdZTUR3VkdoOUtrVXdONHlvVDF6a2E5QmY2eGpM?=
 =?utf-8?B?d1Rtb1NSSmFOTWpucE9paUdUNzJFVjNTY2RNUkpXWDF0d2JQYThxZFRUR3Nw?=
 =?utf-8?B?MFVDcWtYWG5HellCdG4zMHowemVwTW03cXZIWEFHSDdZS00xeUxWS0RXNzBm?=
 =?utf-8?B?NU9iVGJOSS84VjVZMmlYZlVUSXhjcTRwbGdwcjZDcU9lMWFuWnlQQTRwOWdH?=
 =?utf-8?B?TTdYV25WcG9PalRpODRMUktHWjdpblgxa2c5ZTFUeEVnUk5pdkhXaXlGNDZU?=
 =?utf-8?B?Q3llUjZZYkhvRllwWEFvZG9MZ1VJUzFIbWZUVTd0MGpTOEJYajQ5NyswVFdo?=
 =?utf-8?B?OVBTd29zVTl0NGFLV3RvYWFXcE5MRTRySVFrRU1MN2ltNnRvK1FYQVIyTUtl?=
 =?utf-8?B?VGZMam5Gb0lINTA4QWYvdjVJblE0MkFpUmd1b1RhZk9MYXdKMU1UQjhuRng3?=
 =?utf-8?B?K0psbGR3YXBRMzBPTlIyQU9ZS1ZXQkU3VEMxeHE5RUhUTTBjbkxxYnkzM0NB?=
 =?utf-8?B?V3B1Tk1xanVXRHhlS3FKVzZCeE5pcHh5L0hPWEtqZ3FWbjFQekM5b1MrTHZr?=
 =?utf-8?B?UituSTB2dlFXcGNOZE45cUUwN0pVc3ZzVms2YXFnaFlwWkxqOVlYWHI4QXJh?=
 =?utf-8?B?dWlrb1Z1THNiMUdtYVVWM05rdjdRckExRmE0SUR1V0JJUDc1YTZKTVBXaTAy?=
 =?utf-8?B?VjZxSUYvMndnNmJnd2ZtODZkRkhTL2VrRTdDeU1pd014Z01Pa09hN1ljMVp3?=
 =?utf-8?B?N1Y2RmdyQXVZMk81ZkIrckFTT0NDcDVRK1ZRUHk4Zi9TRi9xVXVhOVhiaHh0?=
 =?utf-8?B?ZXRJUmIzSmhwS3gxekxzckVtdkFSRXA5UVlVUHNvS2R2TFI1bkdMQzN0KzNq?=
 =?utf-8?B?UDdtVnE4YWNhTjIzWVRXK0VXYlNra0tzNGlEZ1kvK05LbXRuQ05HM1Qyckpp?=
 =?utf-8?B?RCtpVyt5SmRoeEgzZzB5ZmhsTytsSVRtblNqRVhMQW84MlQ1S3R4THdubjYv?=
 =?utf-8?B?YzY0UHJib0JDV2xQQWhjcVBKdmNOYUZHNlJxeFBIWVZLU2dhWEFJREQ1bUEw?=
 =?utf-8?B?WkFiL0JaYkdBNEduUFZ3TmxrRHUrUEV2LzAwejJaa2xGYU5HL1c4Wlk1dnZW?=
 =?utf-8?B?bVVrU3RUQm9STldpQkJIMG45bk1xcWZLRGZEWVlDWUsxcDY2UitURytIYzlt?=
 =?utf-8?B?cmxSajU1L1BYZm5GS09yUGMva1BhaXFaY1lKMW4rR2ZpWmV4ajhScUhTOXFp?=
 =?utf-8?B?Ykc5b0tEQlRmeldkemZwUWlEWEtlaFVkVFlTRHNTa3hHWVRXM3lGc1FuMmY1?=
 =?utf-8?B?SkxNYVJJUzZWMUd2QjZiVTBVODhldUZGWC8va3dCc0FwNjZsUDhFVFAwS3F1?=
 =?utf-8?Q?ee0TgygRSOU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxUL1pWWTJWQVBKWEtqT284dElGTW00TVlGNjBzU2x3eEZydjFhTUZGdEdp?=
 =?utf-8?B?K0VNUVJmWDRsRWdyRERGSlExZVA0ZlFQY3YwQ29aeldpeExHazBIdEJjTEVt?=
 =?utf-8?B?VW8wamlGUk0zREx0aXM5MUdWNzVPdGZiTGt1Y0RQaFE5aEJSTUpjS01KR3J3?=
 =?utf-8?B?V01sQkRLRDBNTkhxSVJEaitnTEw1L2NwTEsvbU9iNFU2emtyS3Z0ZEp6WktY?=
 =?utf-8?B?WnM5K2Q2bGRicHcvVUxZdWdJbEdBY0twNmt2Z09HdzJvK3ZxeitCNlp0cHF3?=
 =?utf-8?B?S3YzNE15YlhUdkdKcU84ZVRYcXV3RURNcUFqdjhxZEJjNHMwQWU0SU9zcGFo?=
 =?utf-8?B?VTdXZGNOWjN6K1diVW5jaEZ0TlFXajFub0VENXhnUUNCYml1MzFNa3JBM1pX?=
 =?utf-8?B?L1RIMDFzMjFBSWRYY3dVMkdiSHZHRkxQOTVLL29QelZpREdKTmg1SU1aOVdx?=
 =?utf-8?B?QWJGdGIwT3QzcHI3REtkNk5EVVRUTmVDS2FZUjFhODdMb0FsbS8yajVaaDZM?=
 =?utf-8?B?Zlg1dWh6SVFXRTBGY2JTSDdwTmN2cW9tWVMvbFowUExzdGtkdWpDeDVsRGZz?=
 =?utf-8?B?S0VnMmVYWDMwbHdLOEdrY3J5dGFnZFVjSFVJT0hUZ0ZQNnFueGJ2aEIxTkpE?=
 =?utf-8?B?RE9GOTVNL2pvaVBOYzdBUjllZGdiZ3N0NkN0aDQ2MlU5K0JZRFJrSml4QlRs?=
 =?utf-8?B?SlRsS3QzSG8xMlVMOFJlZHRFTmhZYnB4UHNSWDJkQndHSWxhN2I2dkZ2MUxm?=
 =?utf-8?B?d2hqM29YQUFLeDkyT3kyRWY0NUt0QzRienduT0dTcHlPNzV0Q29DN0dmc0xY?=
 =?utf-8?B?MUpjNEFDWFQvUTB0ZHlEY1o5a2Y0WlhVcXpJTlYzQzdVc3RVbFUzeHhhdm92?=
 =?utf-8?B?cXVFaEM4djJJY25IU2VtR3NIWjNGRy9FZjdxak50emg3Y2tTOFp4RStYRUxG?=
 =?utf-8?B?bEFNOGV5QWJwTTFXODVoNkd2TUJYY011N3ZhK3V1SVNSS0Z1YXhWaGxFS0pL?=
 =?utf-8?B?QkFIQlZYY2tsL3J3LzgvQjNRMWxtcU9MeHFEQXpxdDVMdyt1T0NUNUo5MHBh?=
 =?utf-8?B?eWRRMTZYRnRoZWdRUm1ZMU5ud1VOQzhpbEdNTytRbUdDZ2l1L24xSjhYTDRT?=
 =?utf-8?B?M0gxdnJiTHhYMVVUcitaakVnV1RGTHB3QTJacHVWZ2doVkJoelIvWGJUelY3?=
 =?utf-8?B?ZGpRTlRQMUVvUjRzN3NrekFYTW1ROFljdHZJTFdpc2tzQXVET3lMSW1DZm9p?=
 =?utf-8?B?a1ZaYzZRTjlCRTJ6UFdsVFVqTUQ1U1krdTlpWFdiU2JaL1FqTU5nVVAwd3ZN?=
 =?utf-8?B?NDkxclNjZytZVlRmTjdTUzN5YitzWUNnS3BjdkdBRFpWNUpPd2doSjQ4VCto?=
 =?utf-8?B?Tm55UHJBdDgvR0o1Ry90NUQ1VW1lSldWZUJMRkN4Z2lrNmM5WUxaVjQzZ1Zw?=
 =?utf-8?B?VCt5ZGVoKzErdm96Y0twOXpHb2NEWlZhNUlnNmNBeW1OMHllTDRpeXFnYUhw?=
 =?utf-8?B?Q09UU1lnOVl3UGJVbU9yOEFnMTNUdlUxcU1YMm1VTVlCa01hTmhQd2JpM0pJ?=
 =?utf-8?B?WTU5ZjZYR09pZFV1b1FITlhaU2Npc3BFbzFXMjg5akM2UVltMjFnZnRtYVVG?=
 =?utf-8?B?RWFFaXJ6eHFaTy9oMXJEWmN3OS90OTZxSnlkazRWSWduV3VycytEM3UyZE8r?=
 =?utf-8?B?ZW9tMXIwZ1dnUTdQYmNjSzVPMDFIVUtBdnBRYk1ncGkwTytQeUp3YmlTWXhR?=
 =?utf-8?B?eVFVZG0yYm02VENpdXFyNENGbENWZFZWRWtVL1Nua0hZalpxalptR3Jodm5k?=
 =?utf-8?B?OTdWVXRqN29jQWNvbW1QODJzcEVpcEowSXFVVjRJV1U3OE1ka0c2ZVVqLzBB?=
 =?utf-8?B?Z0tjbjFoaVUzV3FNekFYd1BOUEVtVVdXNEcvSDFPSk42VnJGTWhjSFA3OExY?=
 =?utf-8?B?b3lNYnpPS0xmVW53azMzTW1ieW9DcG8xSXk1WFZlZWw3QTNDdkFVa3E2VWtG?=
 =?utf-8?B?MUhFZzVFbWx2WXJKSUFiZkUwZUxDbmFpY0FVQlUxcVY5a1I1bTFWZm5uR3dq?=
 =?utf-8?B?N0p6d3RXQ1hHRlNHSWd6ODYwNFBweVkwaGl2dmJaZkx3SHlJbWpTS2pZQnd5?=
 =?utf-8?B?bnhJbjBwcVFDNWw2QTdVNTlna0RhQzd5OSt6RkdpYUtENDZXZmpSK0Y0MjBm?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9da3a2-4311-4851-d070-08de074ddbe1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:06:52.1704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2yBHol2KC6tjcNR5+QOaSfyiyMI0GKRew7FsyRS6cr37ZJlkJb/0KAsBZIxLiIPP/ZvowIcok+1etGmzpOB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885
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

--------------eu3I2jkdR0YVyICeiROscw5o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09-10-2025 16:46, vanshika.shukla@nxp.com wrote:
> From: Apeksha Gupta<apeksha.gupta@nxp.com>
>
> This patch introduces a new ENETC4 PMD driver for NXP's i.MX95
> SoC, enabling basic network operations. Key features include:
>
> - Probe and teardown functions
> - Hardware initialization for both Virtual Functions (VFs)
>    and Physical Function (PF)
>
> Signed-off-by: Apeksha Gupta<apeksha.gupta@nxp.com>
> Signed-off-by: Gagandeep Singh<g.singh@nxp.com>
> Signed-off-by: Vanshika Shukla<vanshika.shukla@nxp.com>
> ---
>   MAINTAINERS                            |   3 +
>   config/arm/arm64_imx_linux_gcc         |  17 ++
>   config/arm/meson.build                 |  14 ++
>   doc/guides/nics/enetc4.rst             |  92 ++++++++
>   doc/guides/nics/features/enetc4.ini    |   9 +
>   doc/guides/nics/index.rst              |   1 +
>   doc/guides/rel_notes/release_24_11.rst |   4 +
>   drivers/net/enetc/base/enetc4_hw.h     | 111 +++++++++
>   drivers/net/enetc/base/enetc_hw.h      |   3 +-
>   drivers/net/enetc/enetc.h              |  42 ++--
>   drivers/net/enetc/enetc4_ethdev.c      | 297 +++++++++++++++++++++++++
>   drivers/net/enetc/enetc4_vf.c          | 146 ++++++++++++
>   drivers/net/enetc/enetc_ethdev.c       |   5 +-
>   drivers/net/enetc/meson.build          |   4 +-
>   14 files changed, 726 insertions(+), 22 deletions(-)
>   create mode 100644 config/arm/arm64_imx_linux_gcc
>   create mode 100644 doc/guides/nics/enetc4.rst
>   create mode 100644 doc/guides/nics/features/enetc4.ini
>   create mode 100644 drivers/net/enetc/base/enetc4_hw.h
>   create mode 100644 drivers/net/enetc/enetc4_ethdev.c
>   create mode 100644 drivers/net/enetc/enetc4_vf.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1a2729be66..6614e5ad38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -974,9 +974,12 @@ F: doc/guides/nics/features/dpaa2.ini
>   NXP enetc
>   M: Gagandeep Singh<g.singh@nxp.com>
>   M: Sachin Saxena<sachin.saxena@oss.nxp.com>
> +M: Vanshika Shukla<vanshika.shukla@nxp.com>
>   F: drivers/net/enetc/
>   F: doc/guides/nics/enetc.rst
> +F: doc/guides/nics/enetc4.rst
>   F: doc/guides/nics/features/enetc.ini
> +F: doc/guides/nics/features/enetc4.ini
>   
>   NXP enetfec - EXPERIMENTAL
>   M: Apeksha Gupta<apeksha.gupta@nxp.com>
> diff --git a/config/arm/arm64_imx_linux_gcc b/config/arm/arm64_imx_linux_gcc
> new file mode 100644
> index 0000000000..c876ae1d2b
> --- /dev/null
> +++ b/config/arm/arm64_imx_linux_gcc
> @@ -0,0 +1,17 @@
> +[binaries]
> +c = ['ccache', 'aarch64-linux-gnu-gcc']
> +cpp = ['ccache', 'aarch64-linux-gnu-g++']
> +ar = 'aarch64-linux-gnu-ar'
> +as = 'aarch64-linux-gnu-as'
> +strip = 'aarch64-linux-gnu-strip'
> +pkgconfig = 'aarch64-linux-gnu-pkg-config'
> +pcap-config = ''
> +
> +[host_machine]
> +system = 'linux'
> +cpu_family = 'aarch64'
> +cpu = 'armv8.2-a'
> +endian = 'little'
> +
> +[properties]
> +platform = 'imx'
> diff --git a/config/arm/meson.build b/config/arm/meson.build
> index 665f3fa38f..f2567adf06 100644
> --- a/config/arm/meson.build
> +++ b/config/arm/meson.build
> @@ -562,6 +562,18 @@ soc_hip10 = {
>       'numa': true
>   }
>   
> +soc_imx = {
> +    'description': 'NXP IMX',
> +    'implementer': '0x41',
> +    'part_number': '0xd05',
> +    'flags': [
> +        ['RTE_MACHINE', '"armv8a"'],
> +        ['RTE_MAX_LCORE', 6],
> +        ['RTE_MAX_NUMA_NODES', 1],
> +    ],
> +    'numa': false,
> +}
> +
>   soc_kunpeng920 = {
>       'description': 'HiSilicon Kunpeng 920',
>       'implementer': '0x48',
> @@ -746,6 +758,7 @@ graviton2:       AWS Graviton2
>   graviton3:       AWS Graviton3
>   graviton4:       AWS Graviton4
>   hip10:           HiSilicon HIP10
> +imx:             NXP IMX
>   kunpeng920:      HiSilicon Kunpeng 920
>   kunpeng930:      HiSilicon Kunpeng 930
>   n1sdp:           Arm Neoverse N1SDP
> @@ -788,6 +801,7 @@ socs = {
>       'graviton3': soc_graviton3,
>       'graviton4': soc_graviton4,
>       'hip10': soc_hip10,
> +    'imx': soc_imx,
>       'kunpeng920': soc_kunpeng920,
>       'kunpeng930': soc_kunpeng930,
>       'n1sdp': soc_n1sdp,
> diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
> new file mode 100644
> index 0000000000..f5e1df339f
> --- /dev/null
> +++ b/doc/guides/nics/enetc4.rst
> @@ -0,0 +1,92 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +   Copyright 2024 NXP
> +
> +ENETC4 Poll Mode Driver
> +=======================
> +
> +The ENETC4 NIC PMD (**librte_net_enetc**) provides poll mode driver
> +support for the inbuilt NIC found in the **NXP i.MX95** SoC.
> +
> +More information can be found at `NXP Official Website
> +<https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-9-processors/i-mx-95-applications-processor-family-high-performance-safety-enabled-platform-with-eiq-neutron-npu:iMX95>`_.
> +
> +This section provides an overview of the NXP ENETC4
> +and how it is integrated into the DPDK.
> +
> +Contents summary
> +
> +- ENETC4 overview
> +- Supported ENETC4 SoCs
> +- PCI bus driver
> +- NIC driver
> +- Prerequisites
> +- Driver compilation and testing
> +
> +ENETC4 Overview
> +---------------
> +
> +ENETC4 is a PCI Integrated End Point(IEP). IEP implements
> +peripheral devices in an SoC such that software sees them as PCIe device.
> +ENETC4 is an evolution of BDR(Buffer Descriptor Ring) based networking
> +IPs.
> +
> +This infrastructure simplifies adding support for IEP and facilitates in following:
> +
> +- Device discovery and location
> +- Resource requirement discovery and allocation (e.g. interrupt assignment,
> +  device register address)
> +- Event reporting
> +
> +Supported ENETC4 SoCs
> +---------------------
> +
> +- i.MX95
i.MX943 ?
> +
> +NIC Driver (PMD)
> +----------------
> +
> +The ENETC4 PMD is a traditional DPDK PMD that bridges the RTE framework and
> +ENETC4 internal drivers, supporting both Virtual Functions (VFs) and
> +Physical Functions (PF). Key functionality includes:
> +
> +- Driver registration: The device vendor table is registered in the PCI subsystem.
> +- Device discovery: The RTE framework scans the PCI bus for connected devices, triggering the ENETC4 driver's probe function.
> +- Initialization: The probe function configures basic device registers and sets up Buffer Descriptor (BD) rings.
> +- Receive processing: Upon packet reception, the BD Ring status bit is set, facilitating packet processing.
> +- Transmission: Packet transmission precedes reception, ensuring efficient data transfer.
> +
> +Prerequisites
> +-------------
> +
> +There are three main pre-requisites for executing ENETC4 PMD on ENETC4
> +compatible boards:
> +
> +#. **ARM 64 Tool Chain**
> +
> +   For example, the `*aarch64* ARM Toolchain<https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz>`_.
> +
> +#. **Linux Kernel**
> +
> +   It can be obtained from `NXP's Github hosting<https://github.com/nxp-imx/linux-imx>`_.
> +
> +The following dependencies are not part of DPDK and must be installed
> +separately:
> +
> +- **NXP Linux LF**
> +
> +  NXP Linux Factory (LF) includes support for family
> +  of QorIQ® ARM-Architecture-based system on chip (SoC) processors
> +  and corresponding boards.

Why QoriIQ?

+ It includes the Linux board support packages (BSPs) for NXP SoCs,

> +  a fully operational tool chain, kernel and board specific modules.
> +
> +  i.MX LF release and related information can be obtained from:  `LF<https://www.nxp.com/design/design-center/software/embedded-software/i-mx-software/embedded-linux-for-i-mx-applications-processors:IMXLINUX>`_
> +  Refer section: Linux Current Release.
> +
> +Driver compilation and testing
> +------------------------------
> +
> +Follow instructions available in the document
> +:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
> +to launch **testpmd**
> diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
> new file mode 100644
> index 0000000000..ca3b9ae992
> --- /dev/null
> +++ b/doc/guides/nics/features/enetc4.ini
> @@ -0,0 +1,9 @@
> +;
> +; Supported features of the 'enetc4' network poll mode driver.
> +;
> +; Refer to default.ini for the full list of available PMD features.
> +;
> +[Features]
> +Linux                = Y
> +ARMv8                = Y
> +Usage doc            = Y
> diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
> index 57d161c526..c6e9a3a71d 100644
> --- a/doc/guides/nics/index.rst
> +++ b/doc/guides/nics/index.rst
> @@ -27,6 +27,7 @@ Network Interface Controller Drivers
>       e1000em
>       ena
>       enetc
> +    enetc4
>       enetfec
>       enic
>       fail_safe
> diff --git a/doc/guides/rel_notes/release_24_11.rst b/doc/guides/rel_notes/release_24_11.rst
> index 843d6500a2..84bdab4f6b 100644
> --- a/doc/guides/rel_notes/release_24_11.rst
> +++ b/doc/guides/rel_notes/release_24_11.rst
It should be 25.11
> @@ -135,6 +135,10 @@ New Features
>     * Added SR-IOV VF support.
>     * Added recent 1400/14000 and 15000 models to the supported list.
>   
> +* **Added ENETC4 PMD**
> +
> +  * Added ENETC4 PMD for NXP i.MX95 platform.
> +
>   * **Updated Marvell cnxk net driver.**
>   
>     * Added ethdev driver support for CN20K SoC.
> diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
> new file mode 100644
> index 0000000000..34a4ca3b02
> --- /dev/null
> +++ b/drivers/net/enetc/base/enetc4_hw.h
> @@ -0,0 +1,111 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright 2024 NXP
> + *
> + * This header file defines the register offsets and bit fields
> + * of ENETC4 PF and VFs.
> + */
> +
> +#ifndef _ENETC4_HW_H_
> +#define _ENETC4_HW_H_
> +#include <rte_io.h>
> +
> +/* ENETC4 device IDs */
> +#define ENETC4_DEV_ID		0xe101
> +#define ENETC4_DEV_ID_VF	0xef00
> +#define PCI_VENDOR_ID_NXP	0x1131
> +
> +/***************************ENETC port registers**************************/
> +#define ENETC4_PMR		0x10
> +#define ENETC4_PMR_EN		(BIT(16) | BIT(17) | BIT(18))
> +
> +/* Port Station interface promiscuous MAC mode register */
> +#define ENETC4_PSIPMMR		0x200
> +#define PSIPMMR_SI0_MAC_UP	BIT(0)
> +#define PSIPMMR_SI_MAC_UP	(BIT(0) | BIT(1) | BIT(2))
> +#define PSIPMMR_SI0_MAC_MP	BIT(16)
> +#define PSIPMMR_SI_MAC_MP	(BIT(16) | BIT(17) | BIT(18))
> +
> +/* Port Station interface a primary MAC address registers */
> +#define ENETC4_PSIPMAR0(a)	((a) * 0x80 + 0x2000)
> +#define ENETC4_PSIPMAR1(a)	((a) * 0x80 + 0x2004)
> +
> +/* Port MAC address register 0/1 */
> +#define ENETC4_PMAR0		0x4020
> +#define ENETC4_PMAR1		0x4024
> +
> +/* Port operational register */
> +#define ENETC4_POR		0x4100
> +
> +/* Port traffic class a transmit maximum SDU register */
> +#define ENETC4_PTCTMSDUR(a)	((a) * 0x20 + 0x4208)
> +#define SDU_TYPE_MPDU		BIT(16)
> +
> +#define ENETC4_PM_CMD_CFG(mac)		(0x5008 + (mac) * 0x400)
> +#define PM_CMD_CFG_TX_EN		BIT(0)
> +#define PM_CMD_CFG_RX_EN		BIT(1)
> +
> +/* i.MX95 supports jumbo frame, but it is recommended to set the max frame
> + * size to 2000 bytes.
> + */
> +#define ENETC4_MAC_MAXFRM_SIZE  2000
Why limit?
> +
> +/* Port MAC 0/1 Maximum Frame Length Register */
> +#define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
> +
> +/* Config register to reset counters */
> +#define ENETC4_PM0_STAT_CONFIG		0x50e0
> +/* Stats Reset Bit */
> +#define ENETC4_CLEAR_STATS		BIT(2)
> +
> +/* Port MAC 0/1 Receive Ethernet Octets Counter */
> +#define ENETC4_PM_REOCT(mac)            (0x5100 + (mac) * 0x400)
> +
> +/* Port MAC 0/1 Receive Frame Error Counter */
> +#define ENETC4_PM_RERR(mac)		(0x5138 + (mac) * 0x400)
> +
> +/* Port MAC 0/1 Receive Dropped Packets Counter */
> +#define ENETC4_PM_RDRP(mac)		(0x5158 + (mac) * 0x400)
> +
> +/* Port MAC 0/1 Receive Packets Counter */
> +#define ENETC4_PM_RPKT(mac)		(0x5160 + (mac) * 0x400)
> +
> +/* Port MAC 0/1 Transmit Frame Error Counter */
> +#define ENETC4_PM_TERR(mac)		(0x5238 + (mac) * 0x400)
> +
> +/* Port MAC 0/1 Transmit Ethernet Octets Counter */
> +#define ENETC4_PM_TEOCT(mac)            (0x5200 + (mac) * 0x400)
> +
> +/* Port MAC 0/1 Transmit Packets Counter */
> +#define ENETC4_PM_TPKT(mac)		(0x5260 + (mac) * 0x400)
> +
> +/* Port MAC 0 Interface Mode Control Register */
> +#define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
> +#define PM_IF_MODE_IFMODE		(BIT(0) | BIT(1) | BIT(2))
> +#define IFMODE_XGMII			0
> +#define IFMODE_RMII			3
> +#define IFMODE_RGMII			4
> +#define IFMODE_SGMII			5
> +#define PM_IF_MODE_ENA			BIT(15)
> +
> +/* general register accessors */
> +#define enetc4_rd_reg(reg)	rte_read32((void *)(reg))
> +#define enetc4_wr_reg(reg, val)  rte_write32((val), (void *)(reg))
> +
> +#define enetc4_rd(hw, off)	 enetc4_rd_reg((size_t)(hw)->reg + (off))
> +#define enetc4_wr(hw, off, val)  enetc4_wr_reg((size_t)(hw)->reg + (off), val)
> +/* port register accessors - PF only */
> +#define enetc4_port_rd(hw, off)  enetc4_rd_reg((size_t)(hw)->port + (off))
> +#define enetc4_port_wr(hw, off, val) \
> +				enetc4_wr_reg((size_t)(hw)->port + (off), val)
> +/* BDR register accessors, see ENETC_BDR() */
> +#define enetc4_bdr_rd(hw, t, n, off) \
> +				enetc4_rd(hw, ENETC_BDR(t, n, off))
> +#define enetc4_bdr_wr(hw, t, n, off, val) \
> +				enetc4_wr(hw, ENETC_BDR(t, n, off), val)
> +#define enetc4_txbdr_rd(hw, n, off) enetc4_bdr_rd(hw, TX, n, off)
> +#define enetc4_rxbdr_rd(hw, n, off) enetc4_bdr_rd(hw, RX, n, off)
> +#define enetc4_txbdr_wr(hw, n, off, val) \
> +				enetc4_bdr_wr(hw, TX, n, off, val)
> +#define enetc4_rxbdr_wr(hw, n, off, val) \
> +				enetc4_bdr_wr(hw, RX, n, off, val)
> +#endif
> diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
> index 66fad58e5e..2d63c54db6 100644
> --- a/drivers/net/enetc/base/enetc_hw.h
> +++ b/drivers/net/enetc/base/enetc_hw.h
> @@ -1,10 +1,11 @@
>   /* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright 2018-2020 NXP
> + * Copyright 2018-2024 NXP
>    */
>   
>   #ifndef _ENETC_HW_H_
>   #define _ENETC_HW_H_
>   #include <rte_io.h>
> +#include <ethdev_pci.h>
>   
>   #define BIT(x)		((uint64_t)1 << ((x)))
why not use RTE_BIT64   ?
>   
> diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
> index 7163633bce..19e0fa3a07 100644
> --- a/drivers/net/enetc/enetc.h
> +++ b/drivers/net/enetc/enetc.h
> @@ -1,18 +1,21 @@
>   /* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright 2018-2019 NXP
> + * Copyright 2018-2019,2024 NXP
>    */
>   
>   #ifndef _ENETC_H_
>   #define _ENETC_H_
>   
>   #include <rte_time.h>
> +#include <ethdev_pci.h>
>   
> +#include "compat.h"
>   #include "base/enetc_hw.h"
> +#include "enetc_logs.h"
>   
>   #define PCI_VENDOR_ID_FREESCALE 0x1957
>   
>   /* Max TX rings per ENETC. */
> -#define MAX_TX_RINGS	2
> +#define MAX_TX_RINGS	1
Why reducing tx_rings to 1 ? Will it not impact the older ENETC devices ?
>   
>   /* Max RX rings per ENTEC. */
>   #define MAX_RX_RINGS	1
> @@ -33,21 +36,11 @@
>   #define ENETC_ETH_MAX_LEN (RTE_ETHER_MTU + \
>   		RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
>   
> -/*
> - * upper_32_bits - return bits 32-63 of a number
> - * @n: the number we're accessing
> - *
> - * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
> - * the "right shift count >= width of type" warning when that quantity is
> - * 32-bits.
> - */
> -#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
> +/* eth name size */
> +#define ENETC_ETH_NAMESIZE	20
>   
> -/*
> - * lower_32_bits - return bits 0-31 of a number
> - * @n: the number we're accessing
> - */
> -#define lower_32_bits(n) ((uint32_t)(n))
> +/* size for marking hugepage non-cacheable */
> +#define SIZE_2MB	0x200000
>   
>   #define ENETC_TXBD(BDR, i) (&(((struct enetc_tx_bd *)((BDR).bd_base))[i]))
>   #define ENETC_RXBD(BDR, i) (&(((union enetc_rx_bd *)((BDR).bd_base))[i]))
> @@ -96,6 +89,20 @@ struct enetc_eth_adapter {
>   #define ENETC_DEV_PRIVATE_TO_INTR(adapter) \
>   	(&((struct enetc_eth_adapter *)adapter)->intr)
>   
> +/*
> + * ENETC4 function prototypes
> + */
> +int enetc4_pci_remove(struct rte_pci_device *pci_dev);
> +int enetc4_dev_configure(struct rte_eth_dev *dev);
> +int enetc4_dev_close(struct rte_eth_dev *dev);
> +int enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
> +			 struct rte_eth_dev_info *dev_info);
> +
> +/*
> + * enetc4_vf function prototype
> + */
> +int enetc4_vf_dev_stop(struct rte_eth_dev *dev);
> +
>   /*
>    * RX/TX ENETC function prototypes
>    */
> @@ -104,8 +111,9 @@ uint16_t enetc_xmit_pkts(void *txq, struct rte_mbuf **tx_pkts,
>   uint16_t enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
>   		uint16_t nb_pkts);
>   
> -
>   int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt);
> +void enetc4_dev_hw_init(struct rte_eth_dev *eth_dev);
> +void print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr);
>   
>   static inline int
>   enetc_bd_unused(struct enetc_bdr *bdr)
> diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
> new file mode 100644
> index 0000000000..e96f390626
> --- /dev/null
> +++ b/drivers/net/enetc/enetc4_ethdev.c
> @@ -0,0 +1,297 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright 2024 NXP
> + */
> +
> +#include <stdbool.h>
> +#include <rte_random.h>
> +#include <dpaax_iova_table.h>
> +
> +#include "base/enetc4_hw.h"
> +#include "enetc_logs.h"
> +#include "enetc.h"
> +
> +static int
> +enetc4_dev_start(struct rte_eth_dev *dev)
> +{
> +	struct enetc_eth_hw *hw =
> +		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	struct enetc_hw *enetc_hw = &hw->hw;
> +	uint32_t val;
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(0));
> +	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(0),
> +		       val | PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
> +
> +	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(1));
> +	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(1),
> +		       val | PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
> +
> +	/* Enable port */
> +	val = enetc4_port_rd(enetc_hw, ENETC4_PMR);
> +	enetc4_port_wr(enetc_hw, ENETC4_PMR, val | ENETC4_PMR_EN);
> +
> +	/* Enable port transmit/receive */
> +	enetc4_port_wr(enetc_hw, ENETC4_POR, 0);
> +
> +	return 0;
> +}
> +
> +static int
> +enetc4_dev_stop(struct rte_eth_dev *dev)
> +{
> +	struct enetc_eth_hw *hw =
> +		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	struct enetc_hw *enetc_hw = &hw->hw;
> +	uint32_t val;
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	/* Disable port */
> +	val = enetc4_port_rd(enetc_hw, ENETC4_PMR);
> +	enetc4_port_wr(enetc_hw, ENETC4_PMR, val & (~ENETC4_PMR_EN));
> +
> +	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(0));
> +	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(0),
> +		      val & (~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN)));
> +
> +	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(1));
> +	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(1),
> +		      val & (~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN)));
> +
> +	return 0;
> +}
> +
> +static int
> +enetc4_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
> +{
> +	struct enetc_hw *enetc_hw = &hw->hw;
> +	uint32_t high_mac = 0;
> +	uint16_t low_mac = 0;
> +	char eth_name[ENETC_ETH_NAMESIZE];
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	/* Enabling Station Interface */
> +	enetc4_wr(enetc_hw, ENETC_SIMR, ENETC_SIMR_EN);
> +
> +	high_mac = (uint32_t)enetc4_port_rd(enetc_hw, ENETC4_PSIPMAR0(0));
> +	low_mac = (uint16_t)enetc4_port_rd(enetc_hw, ENETC4_PSIPMAR1(0));
> +
> +	if ((high_mac | low_mac) == 0) {
> +		ENETC_PMD_NOTICE("MAC is not available for this SI, "
> +				"set random MAC");
> +		rte_eth_random_addr(hw->mac.addr);
> +		high_mac = *(uint32_t *)hw->mac.addr;
> +		enetc4_port_wr(enetc_hw, ENETC4_PMAR0, high_mac);
> +		low_mac = *(uint16_t *)(hw->mac.addr + 4);
> +		enetc4_port_wr(enetc_hw, ENETC4_PMAR1, low_mac);
> +		print_ethaddr("New address: ",
> +			      (const struct rte_ether_addr *)hw->mac.addr);
> +	}
> +
> +	/* Allocate memory for storing MAC addresses */
> +	snprintf(eth_name, sizeof(eth_name), "enetc4_eth_%d", eth_dev->data->port_id);
> +	eth_dev->data->mac_addrs = rte_zmalloc(eth_name,
> +					RTE_ETHER_ADDR_LEN, 0);
> +	if (!eth_dev->data->mac_addrs) {
> +		ENETC_PMD_ERR("Failed to allocate %d bytes needed to "
> +			      "store MAC addresses",
> +			      RTE_ETHER_ADDR_LEN * 1);
> +		return -ENOMEM;
> +	}
> +
> +	/* Copy the permanent MAC address */
> +	rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
> +			&eth_dev->data->mac_addrs[0]);
> +
> +	return 0;
> +}
> +
> +int
> +enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
> +		    struct rte_eth_dev_info *dev_info)
> +{
> +	PMD_INIT_FUNC_TRACE();
> +	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
> +		.nb_max = MAX_BD_COUNT,
> +		.nb_min = MIN_BD_COUNT,
> +		.nb_align = BD_ALIGN,
> +	};
> +	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
> +		.nb_max = MAX_BD_COUNT,
> +		.nb_min = MIN_BD_COUNT,
> +		.nb_align = BD_ALIGN,
> +	};
> +	dev_info->max_rx_queues = MAX_RX_RINGS;
> +	dev_info->max_tx_queues = MAX_TX_RINGS;
> +	dev_info->max_rx_pktlen = ENETC4_MAC_MAXFRM_SIZE;
> +
> +	return 0;
> +}
> +
> +int
> +enetc4_dev_close(struct rte_eth_dev *dev)
> +{
> +	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	int ret;
> +
> +	PMD_INIT_FUNC_TRACE();
> +	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
> +		return 0;
> +
> +	if (hw->device_id == ENETC4_DEV_ID_VF)
> +		ret = enetc4_vf_dev_stop(dev);
> +	else
> +		ret = enetc4_dev_stop(dev);
> +
> +	if (rte_eal_iova_mode() == RTE_IOVA_PA)
> +		dpaax_iova_table_depopulate();
> +
> +	return ret;
> +}
> +
> +int
> +enetc4_dev_configure(struct rte_eth_dev *dev)
> +{
> +	struct enetc_eth_hw *hw =
> +		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	struct enetc_hw *enetc_hw = &hw->hw;
> +	uint32_t max_len;
> +	uint32_t val;
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	max_len = dev->data->dev_conf.rxmode.mtu + RTE_ETHER_HDR_LEN +
> +		  RTE_ETHER_CRC_LEN;
> +	enetc4_port_wr(enetc_hw, ENETC4_PM_MAXFRM(0), ENETC_SET_MAXFRM(max_len));
> +
> +	val = ENETC4_MAC_MAXFRM_SIZE | SDU_TYPE_MPDU;
> +	enetc4_port_wr(enetc_hw, ENETC4_PTCTMSDUR(0), val | SDU_TYPE_MPDU);
> +
> +	return 0;
> +}
> +
> +
> +
> +/*
> + * The set of PCI devices this driver supports
> + */
> +static const struct rte_pci_id pci_id_enetc4_map[] = {
> +	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NXP, ENETC4_DEV_ID) },
> +	{ .vendor_id = 0, /* sentinel */ },
> +};
> +
> +/* Features supported by this driver */
> +static const struct eth_dev_ops enetc4_ops = {
> +	.dev_configure        = enetc4_dev_configure,
> +	.dev_start            = enetc4_dev_start,
> +	.dev_stop             = enetc4_dev_stop,
> +	.dev_close            = enetc4_dev_close,
> +	.dev_infos_get        = enetc4_dev_infos_get,
> +};
> +
> +/*
> + * Storing the HW base addresses
> + *
> + * @param eth_dev
> + *   - Pointer to the structure rte_eth_dev
> + */
> +void
> +enetc4_dev_hw_init(struct rte_eth_dev *eth_dev)
> +{
> +	struct enetc_eth_hw *hw =
> +		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
> +	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
> +
> +	eth_dev->rx_pkt_burst = &enetc_recv_pkts;
> +	eth_dev->tx_pkt_burst = &enetc_xmit_pkts;
> +
> +	/* Retrieving and storing the HW base address of device */
> +	hw->hw.reg = (void *)pci_dev->mem_resource[0].addr;
> +	hw->device_id = pci_dev->id.device_id;
> +
> +	/* Calculating and storing the base HW addresses */
> +	hw->hw.port = (void *)((size_t)hw->hw.reg + ENETC_PORT_BASE);
> +	hw->hw.global = (void *)((size_t)hw->hw.reg + ENETC_GLOBAL_BASE);
> +}
> +
> +/**
> + * Initialisation of the enetc4 device
> + *
> + * @param eth_dev
> + *   - Pointer to the structure rte_eth_dev
> + *
> + * @return
> + *   - On success, zero.
> + *   - On failure, negative value.
> + */
> +
> +static int
> +enetc4_dev_init(struct rte_eth_dev *eth_dev)
> +{
> +	struct enetc_eth_hw *hw =
> +		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
> +	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
> +	int error = 0;
> +
> +	PMD_INIT_FUNC_TRACE();
> +	eth_dev->dev_ops = &enetc4_ops;
> +	enetc4_dev_hw_init(eth_dev);
> +
> +	error = enetc4_mac_init(hw, eth_dev);
> +	if (error != 0) {
> +		ENETC_PMD_ERR("MAC initialization failed");
> +		return -1;
> +	}
> +
> +	/* Set MTU */
> +	enetc_port_wr(&hw->hw, ENETC4_PM_MAXFRM(0),
> +		      ENETC_SET_MAXFRM(RTE_ETHER_MAX_LEN));
> +	eth_dev->data->mtu = RTE_ETHER_MAX_LEN - RTE_ETHER_HDR_LEN -
> +		RTE_ETHER_CRC_LEN;
> +
> +	if (rte_eal_iova_mode() == RTE_IOVA_PA)
> +		dpaax_iova_table_populate();
> +
> +	ENETC_PMD_DEBUG("port_id %d vendorID=0x%x deviceID=0x%x",
> +			eth_dev->data->port_id, pci_dev->id.vendor_id,
> +			pci_dev->id.device_id);
> +	return 0;
> +}
> +
> +static int
> +enetc4_dev_uninit(struct rte_eth_dev *eth_dev)
> +{
> +	PMD_INIT_FUNC_TRACE();
> +
> +	return enetc4_dev_close(eth_dev);
> +}
> +
> +static int
> +enetc4_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
> +			   struct rte_pci_device *pci_dev)
> +{
> +	return rte_eth_dev_pci_generic_probe(pci_dev,
> +					     sizeof(struct enetc_eth_adapter),
> +					     enetc4_dev_init);
> +}
> +
> +int
> +enetc4_pci_remove(struct rte_pci_device *pci_dev)
> +{
> +	return rte_eth_dev_pci_generic_remove(pci_dev, enetc4_dev_uninit);
> +}
> +
> +static struct rte_pci_driver rte_enetc4_pmd = {
> +	.id_table = pci_id_enetc4_map,
> +	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
> +	.probe = enetc4_pci_probe,
> +	.remove = enetc4_pci_remove,
> +};
> +
> +RTE_PMD_REGISTER_PCI(net_enetc4, rte_enetc4_pmd);
> +RTE_PMD_REGISTER_PCI_TABLE(net_enetc4, pci_id_enetc4_map);
> +RTE_PMD_REGISTER_KMOD_DEP(net_enetc4, "* vfio-pci");
> +RTE_LOG_REGISTER_DEFAULT(enetc4_logtype_pmd, NOTICE);
> diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
> new file mode 100644
> index 0000000000..7996d6decb
> --- /dev/null
> +++ b/drivers/net/enetc/enetc4_vf.c
> @@ -0,0 +1,146 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright 2024 NXP
> + */
> +
> +#include <stdbool.h>
> +#include <rte_random.h>
> +#include <dpaax_iova_table.h>
> +#include "base/enetc4_hw.h"
> +#include "base/enetc_hw.h"
> +#include "enetc_logs.h"
> +#include "enetc.h"
> +
> +int
> +enetc4_vf_dev_stop(struct rte_eth_dev *dev __rte_unused)
> +{
> +	PMD_INIT_FUNC_TRACE();
> +
> +	return 0;
> +}
> +
> +static int
> +enetc4_vf_dev_start(struct rte_eth_dev *dev __rte_unused)
> +{
> +	PMD_INIT_FUNC_TRACE();
> +
> +	return 0;
> +}
> +
> +/*
> + * The set of PCI devices this driver supports
> + */
> +static const struct rte_pci_id pci_vf_id_enetc4_map[] = {
> +	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NXP, ENETC4_DEV_ID_VF) },
> +	{ .vendor_id = 0, /* sentinel */ },
> +};
> +
> +/* Features supported by this driver */
> +static const struct eth_dev_ops enetc4_vf_ops = {
> +	.dev_configure        = enetc4_dev_configure,
> +	.dev_start            = enetc4_vf_dev_start,
> +	.dev_stop             = enetc4_vf_dev_stop,
> +	.dev_close            = enetc4_dev_close,
> +	.dev_infos_get        = enetc4_dev_infos_get,
> +};
> +
> +static int
> +enetc4_vf_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
> +{
> +	uint32_t *mac = (uint32_t *)hw->mac.addr;
> +	struct enetc_hw *enetc_hw = &hw->hw;
> +	uint32_t high_mac = 0;
> +	uint16_t low_mac = 0;
> +	char vf_eth_name[ENETC_ETH_NAMESIZE];
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	/* Enabling Station Interface */
> +	enetc4_wr(enetc_hw, ENETC_SIMR, ENETC_SIMR_EN);
> +	*mac = (uint32_t)enetc_rd(enetc_hw, ENETC_SIPMAR0);
> +	high_mac = (uint32_t)*mac;
> +	mac++;
> +	*mac = (uint16_t)enetc_rd(enetc_hw, ENETC_SIPMAR1);
> +	low_mac = (uint16_t)*mac;
> +
> +	if ((high_mac | low_mac) == 0) {
> +		char *first_byte;
> +		ENETC_PMD_NOTICE("MAC is not available for this SI, "
> +				 "set random MAC");
> +		mac = (uint32_t *)hw->mac.addr;
> +		*mac = (uint32_t)rte_rand();
> +		first_byte = (char *)mac;
> +		*first_byte &= 0xfe;    /* clear multicast bit */
> +		*first_byte |= 0x02;    /* set local assignment bit (IEEE802) */
> +		enetc4_port_wr(enetc_hw, ENETC4_PMAR0, *mac);
> +		mac++;
> +		*mac = (uint16_t)rte_rand();
> +		enetc4_port_wr(enetc_hw, ENETC4_PMAR1, *mac);
> +		print_ethaddr("New address: ",
> +			(const struct rte_ether_addr *)hw->mac.addr);
> +	}
> +
> +	/* Allocate memory for storing MAC addresses */
> +	snprintf(vf_eth_name, sizeof(vf_eth_name), "enetc4_vf_eth_%d", eth_dev->data->port_id);
> +	eth_dev->data->mac_addrs = rte_zmalloc(vf_eth_name,
> +					RTE_ETHER_ADDR_LEN, 0);
> +	if (!eth_dev->data->mac_addrs) {
> +		ENETC_PMD_ERR("Failed to allocate %d bytes needed to "
> +			      "store MAC addresses",
can you try to fit it in single line?
> +			      RTE_ETHER_ADDR_LEN * 1);
> +		return -ENOMEM;
> +	}
> +
> +	/* Copy the permanent MAC address */
> +	rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
> +			     &eth_dev->data->mac_addrs[0]);
> +
> +	return 0;
> +}
> +
> +static int
> +enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
> +{
> +	struct enetc_eth_hw *hw =
> +			    ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
> +	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
> +	int error = 0;
> +
> +	PMD_INIT_FUNC_TRACE();
> +	eth_dev->dev_ops = &enetc4_vf_ops;
> +	enetc4_dev_hw_init(eth_dev);
> +
> +	error = enetc4_vf_mac_init(hw, eth_dev);
> +	if (error != 0) {
> +		ENETC_PMD_ERR("MAC initialization failed!!");
> +		return -1;
> +	}
> +
> +	if (rte_eal_iova_mode() == RTE_IOVA_PA)
> +		dpaax_iova_table_populate();
> +
> +	ENETC_PMD_DEBUG("port_id %d vendorID=0x%x deviceID=0x%x",
> +			eth_dev->data->port_id, pci_dev->id.vendor_id,
> +			pci_dev->id.device_id);
> +	return 0;
> +}
> +
> +static int
> +enetc4_vf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
> +		    struct rte_pci_device *pci_dev)
> +{
> +	return rte_eth_dev_pci_generic_probe(pci_dev,
> +					     sizeof(struct enetc_eth_adapter),
> +					     enetc4_vf_dev_init);
> +}
> +
> +static struct rte_pci_driver rte_enetc4_vf_pmd = {
> +	.id_table = pci_vf_id_enetc4_map,
> +	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
> +	.probe = enetc4_vf_pci_probe,
> +	.remove = enetc4_pci_remove,
> +};
> +
> +RTE_PMD_REGISTER_PCI(net_enetc4_vf, rte_enetc4_vf_pmd);
> +RTE_PMD_REGISTER_PCI_TABLE(net_enetc4_vf, pci_vf_id_enetc4_map);
> +RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, "* uio_pci_generic");
> +RTE_LOG_REGISTER_DEFAULT(enetc4_vf_logtype_pmd, NOTICE);
> diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
> index ffbecc407c..d7cba1ba83 100644
> --- a/drivers/net/enetc/enetc_ethdev.c
> +++ b/drivers/net/enetc/enetc_ethdev.c
> @@ -1,9 +1,8 @@
>   /* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright 2018-2020 NXP
> + * Copyright 2018-2024 NXP
>    */
>   
>   #include <stdbool.h>
> -#include <ethdev_pci.h>
>   #include <rte_random.h>
>   #include <dpaax_iova_table.h>
>   
> @@ -145,7 +144,7 @@ enetc_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
>   	return rte_eth_linkstatus_set(dev, &link);
>   }
>   
> -static void
> +void
>   print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr)
>   {
>   	char buf[RTE_ETHER_ADDR_FMT_SIZE];
> diff --git a/drivers/net/enetc/meson.build b/drivers/net/enetc/meson.build
> index 966dc694fc..6e00758a36 100644
> --- a/drivers/net/enetc/meson.build
> +++ b/drivers/net/enetc/meson.build
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: BSD-3-Clause
> -# Copyright 2018 NXP
> +# Copyright 2018,2024 NXP
>   
>   if not is_linux
>       build = false
> @@ -8,6 +8,8 @@ endif
>   
>   deps += ['common_dpaax']
>   sources = files(
> +	'enetc4_ethdev.c',
> +	'enetc4_vf.c',
>           'enetc_ethdev.c',
>           'enetc_rxtx.c',
>   )
--------------eu3I2jkdR0YVyICeiROscw5o
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 09-10-2025 16:46,
      <a class="moz-txt-link-abbreviated" href="mailto:vanshika.shukla@nxp.com">vanshika.shukla@nxp.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">From: Apeksha Gupta <a class="moz-txt-link-rfc2396E" href="mailto:apeksha.gupta@nxp.com">&lt;apeksha.gupta@nxp.com&gt;</a>

This patch introduces a new ENETC4 PMD driver for NXP's i.MX95
SoC, enabling basic network operations. Key features include:

- Probe and teardown functions
- Hardware initialization for both Virtual Functions (VFs)
  and Physical Function (PF)

Signed-off-by: Apeksha Gupta <a class="moz-txt-link-rfc2396E" href="mailto:apeksha.gupta@nxp.com">&lt;apeksha.gupta@nxp.com&gt;</a>
Signed-off-by: Gagandeep Singh <a class="moz-txt-link-rfc2396E" href="mailto:g.singh@nxp.com">&lt;g.singh@nxp.com&gt;</a>
Signed-off-by: Vanshika Shukla <a class="moz-txt-link-rfc2396E" href="mailto:vanshika.shukla@nxp.com">&lt;vanshika.shukla@nxp.com&gt;</a>
---
 MAINTAINERS                            |   3 +
 config/arm/arm64_imx_linux_gcc         |  17 ++
 config/arm/meson.build                 |  14 ++
 doc/guides/nics/enetc4.rst             |  92 ++++++++
 doc/guides/nics/features/enetc4.ini    |   9 +
 doc/guides/nics/index.rst              |   1 +
 doc/guides/rel_notes/release_24_11.rst |   4 +
 drivers/net/enetc/base/enetc4_hw.h     | 111 +++++++++
 drivers/net/enetc/base/enetc_hw.h      |   3 +-
 drivers/net/enetc/enetc.h              |  42 ++--
 drivers/net/enetc/enetc4_ethdev.c      | 297 +++++++++++++++++++++++++
 drivers/net/enetc/enetc4_vf.c          | 146 ++++++++++++
 drivers/net/enetc/enetc_ethdev.c       |   5 +-
 drivers/net/enetc/meson.build          |   4 +-
 14 files changed, 726 insertions(+), 22 deletions(-)
 create mode 100644 config/arm/arm64_imx_linux_gcc
 create mode 100644 doc/guides/nics/enetc4.rst
 create mode 100644 doc/guides/nics/features/enetc4.ini
 create mode 100644 drivers/net/enetc/base/enetc4_hw.h
 create mode 100644 drivers/net/enetc/enetc4_ethdev.c
 create mode 100644 drivers/net/enetc/enetc4_vf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..6614e5ad38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -974,9 +974,12 @@ F: doc/guides/nics/features/dpaa2.ini
 NXP enetc
 M: Gagandeep Singh <a class="moz-txt-link-rfc2396E" href="mailto:g.singh@nxp.com">&lt;g.singh@nxp.com&gt;</a>
 M: Sachin Saxena <a class="moz-txt-link-rfc2396E" href="mailto:sachin.saxena@oss.nxp.com">&lt;sachin.saxena@oss.nxp.com&gt;</a>
+M: Vanshika Shukla <a class="moz-txt-link-rfc2396E" href="mailto:vanshika.shukla@nxp.com">&lt;vanshika.shukla@nxp.com&gt;</a>
 F: drivers/net/enetc/
 F: doc/guides/nics/enetc.rst
+F: doc/guides/nics/enetc4.rst
 F: doc/guides/nics/features/enetc.ini
+F: doc/guides/nics/features/enetc4.ini
 
 NXP enetfec - EXPERIMENTAL
 M: Apeksha Gupta <a class="moz-txt-link-rfc2396E" href="mailto:apeksha.gupta@nxp.com">&lt;apeksha.gupta@nxp.com&gt;</a></pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">diff --git a/config/arm/arm64_imx_linux_gcc b/config/arm/arm64_imx_linux_gcc
new file mode 100644
index 0000000000..c876ae1d2b
--- /dev/null
+++ b/config/arm/arm64_imx_linux_gcc
@@ -0,0 +1,17 @@
+[binaries]
+c = ['ccache', 'aarch64-linux-gnu-gcc']
+cpp = ['ccache', 'aarch64-linux-gnu-g++']
+ar = 'aarch64-linux-gnu-ar'
+as = 'aarch64-linux-gnu-as'
+strip = 'aarch64-linux-gnu-strip'
+pkgconfig = 'aarch64-linux-gnu-pkg-config'
+pcap-config = ''
+
+[host_machine]
+system = 'linux'
+cpu_family = 'aarch64'
+cpu = 'armv8.2-a'
+endian = 'little'
+
+[properties]
+platform = 'imx'
diff --git a/config/arm/meson.build b/config/arm/meson.build
index 665f3fa38f..f2567adf06 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -562,6 +562,18 @@ soc_hip10 = {
     'numa': true
 }
 
+soc_imx = {
+    'description': 'NXP IMX',
+    'implementer': '0x41',
+    'part_number': '0xd05',
+    'flags': [
+        ['RTE_MACHINE', '&quot;armv8a&quot;'],
+        ['RTE_MAX_LCORE', 6],
+        ['RTE_MAX_NUMA_NODES', 1],
+    ],
+    'numa': false,
+}
+
 soc_kunpeng920 = {
     'description': 'HiSilicon Kunpeng 920',
     'implementer': '0x48',
@@ -746,6 +758,7 @@ graviton2:       AWS Graviton2
 graviton3:       AWS Graviton3
 graviton4:       AWS Graviton4
 hip10:           HiSilicon HIP10
+imx:             NXP IMX
 kunpeng920:      HiSilicon Kunpeng 920
 kunpeng930:      HiSilicon Kunpeng 930
 n1sdp:           Arm Neoverse N1SDP
@@ -788,6 +801,7 @@ socs = {
     'graviton3': soc_graviton3,
     'graviton4': soc_graviton4,
     'hip10': soc_hip10,
+    'imx': soc_imx,
     'kunpeng920': soc_kunpeng920,
     'kunpeng930': soc_kunpeng930,
     'n1sdp': soc_n1sdp,
diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
new file mode 100644
index 0000000000..f5e1df339f
--- /dev/null
+++ b/doc/guides/nics/enetc4.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2024 NXP
+
+ENETC4 Poll Mode Driver
+=======================
+
+The ENETC4 NIC PMD (**librte_net_enetc**) provides poll mode driver
+support for the inbuilt NIC found in the **NXP i.MX95** SoC.
+
+More information can be found at `NXP Official Website
+<a class="moz-txt-link-rfc2396E" href="https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-9-processors/i-mx-95-applications-processor-family-high-performance-safety-enabled-platform-with-eiq-neutron-npu:iMX95">&lt;https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-9-processors/i-mx-95-applications-processor-family-high-performance-safety-enabled-platform-with-eiq-neutron-npu:iMX95&gt;</a>`_.
+
+This section provides an overview of the NXP ENETC4
+and how it is integrated into the DPDK.
+
+Contents summary
+
+- ENETC4 overview
+- Supported ENETC4 SoCs
+- PCI bus driver
+- NIC driver
+- Prerequisites
+- Driver compilation and testing
+
+ENETC4 Overview
+---------------
+
+ENETC4 is a PCI Integrated End Point(IEP). IEP implements
+peripheral devices in an SoC such that software sees them as PCIe device.
+ENETC4 is an evolution of BDR(Buffer Descriptor Ring) based networking
+IPs.
+
+This infrastructure simplifies adding support for IEP and facilitates in following:
+
+- Device discovery and location
+- Resource requirement discovery and allocation (e.g. interrupt assignment,
+  device register address)
+- Event reporting
+
+Supported ENETC4 SoCs
+---------------------
+
+- i.MX95</pre>
    </blockquote>
    i.MX943 ?&nbsp;
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">
+
+NIC Driver (PMD)
+----------------
+
+The ENETC4 PMD is a traditional DPDK PMD that bridges the RTE framework and
+ENETC4 internal drivers, supporting both Virtual Functions (VFs) and
+Physical Functions (PF). Key functionality includes:
+
+- Driver registration: The device vendor table is registered in the PCI subsystem.
+- Device discovery: The RTE framework scans the PCI bus for connected devices, triggering the ENETC4 driver's probe function.
+- Initialization: The probe function configures basic device registers and sets up Buffer Descriptor (BD) rings.
+- Receive processing: Upon packet reception, the BD Ring status bit is set, facilitating packet processing.
+- Transmission: Packet transmission precedes reception, ensuring efficient data transfer.
+
+Prerequisites
+-------------
+
+There are three main pre-requisites for executing ENETC4 PMD on ENETC4
+compatible boards:
+
+#. **ARM 64 Tool Chain**
+
+   For example, the `*aarch64* ARM Toolchain <a class="moz-txt-link-rfc2396E" href="https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz">&lt;https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz&gt;</a>`_.
+
+#. **Linux Kernel**
+
+   It can be obtained from `NXP's Github hosting <a class="moz-txt-link-rfc2396E" href="https://github.com/nxp-imx/linux-imx">&lt;https://github.com/nxp-imx/linux-imx&gt;</a>`_.
+
+The following dependencies are not part of DPDK and must be installed
+separately:
+
+- **NXP Linux LF**
+
+  NXP Linux Factory (LF) includes support for family
+  of QorIQ® ARM-Architecture-based system on chip (SoC) processors
+  and corresponding boards.
</pre>
    </blockquote>
    <p>Why QoriIQ?</p>
    <p><span style="white-space: pre-wrap">+  It includes the Linux board support packages (BSPs) for NXP SoCs,</span></p>
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">+  a fully operational tool chain, kernel and board specific modules.
+
+  i.MX LF release and related information can be obtained from:  `LF  <a class="moz-txt-link-rfc2396E" href="https://www.nxp.com/design/design-center/software/embedded-software/i-mx-software/embedded-linux-for-i-mx-applications-processors:IMXLINUX">&lt;https://www.nxp.com/design/design-center/software/embedded-software/i-mx-software/embedded-linux-for-i-mx-applications-processors:IMXLINUX&gt;</a>`_
+  Refer section: Linux Current Release.
+
+Driver compilation and testing
+------------------------------
+
+Follow instructions available in the document
+:ref:`compiling and testing a PMD for a NIC &lt;pmd_build_and_test&gt;`
+to launch **testpmd**
diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
new file mode 100644
index 0000000000..ca3b9ae992
--- /dev/null
+++ b/doc/guides/nics/features/enetc4.ini
@@ -0,0 +1,9 @@
+;
+; Supported features of the 'enetc4' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Linux                = Y
+ARMv8                = Y
+Usage doc            = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index 57d161c526..c6e9a3a71d 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -27,6 +27,7 @@ Network Interface Controller Drivers
     e1000em
     ena
     enetc
+    enetc4
     enetfec
     enic
     fail_safe
diff --git a/doc/guides/rel_notes/release_24_11.rst b/doc/guides/rel_notes/release_24_11.rst
index 843d6500a2..84bdab4f6b 100644
--- a/doc/guides/rel_notes/release_24_11.rst
+++ b/doc/guides/rel_notes/release_24_11.rst</pre>
    </blockquote>
    It should be 25.11&nbsp;
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">
@@ -135,6 +135,10 @@ New Features
   * Added SR-IOV VF support.
   * Added recent 1400/14000 and 15000 models to the supported list.
 
+* **Added ENETC4 PMD**
+
+  * Added ENETC4 PMD for NXP i.MX95 platform.
+
 * **Updated Marvell cnxk net driver.**
 
   * Added ethdev driver support for CN20K SoC.
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
new file mode 100644
index 0000000000..34a4ca3b02
--- /dev/null
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2024 NXP
+ *
+ * This header file defines the register offsets and bit fields
+ * of ENETC4 PF and VFs.
+ */
+
+#ifndef _ENETC4_HW_H_
+#define _ENETC4_HW_H_
+#include &lt;rte_io.h&gt;
+
+/* ENETC4 device IDs */
+#define ENETC4_DEV_ID		0xe101
+#define ENETC4_DEV_ID_VF	0xef00
+#define PCI_VENDOR_ID_NXP	0x1131
+
+/***************************ENETC port registers**************************/
+#define ENETC4_PMR		0x10
+#define ENETC4_PMR_EN		(BIT(16) | BIT(17) | BIT(18))
+
+/* Port Station interface promiscuous MAC mode register */
+#define ENETC4_PSIPMMR		0x200
+#define PSIPMMR_SI0_MAC_UP	BIT(0)
+#define PSIPMMR_SI_MAC_UP	(BIT(0) | BIT(1) | BIT(2))
+#define PSIPMMR_SI0_MAC_MP	BIT(16)
+#define PSIPMMR_SI_MAC_MP	(BIT(16) | BIT(17) | BIT(18))
+
+/* Port Station interface a primary MAC address registers */
+#define ENETC4_PSIPMAR0(a)	((a) * 0x80 + 0x2000)
+#define ENETC4_PSIPMAR1(a)	((a) * 0x80 + 0x2004)
+
+/* Port MAC address register 0/1 */
+#define ENETC4_PMAR0		0x4020
+#define ENETC4_PMAR1		0x4024
+
+/* Port operational register */
+#define ENETC4_POR		0x4100
+
+/* Port traffic class a transmit maximum SDU register */
+#define ENETC4_PTCTMSDUR(a)	((a) * 0x20 + 0x4208)
+#define SDU_TYPE_MPDU		BIT(16)
+
+#define ENETC4_PM_CMD_CFG(mac)		(0x5008 + (mac) * 0x400)
+#define PM_CMD_CFG_TX_EN		BIT(0)
+#define PM_CMD_CFG_RX_EN		BIT(1)
+
+/* i.MX95 supports jumbo frame, but it is recommended to set the max frame
+ * size to 2000 bytes.
+ */
+#define ENETC4_MAC_MAXFRM_SIZE  2000</pre>
    </blockquote>
    Why limit?&nbsp;
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">
+
+/* Port MAC 0/1 Maximum Frame Length Register */
+#define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
+
+/* Config register to reset counters */
+#define ENETC4_PM0_STAT_CONFIG		0x50e0
+/* Stats Reset Bit */
+#define ENETC4_CLEAR_STATS		BIT(2)
+
+/* Port MAC 0/1 Receive Ethernet Octets Counter */
+#define ENETC4_PM_REOCT(mac)            (0x5100 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Error Counter */
+#define ENETC4_PM_RERR(mac)		(0x5138 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Packets Counter */
+#define ENETC4_PM_RDRP(mac)		(0x5158 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Packets Counter */
+#define ENETC4_PM_RPKT(mac)		(0x5160 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Error Counter */
+#define ENETC4_PM_TERR(mac)		(0x5238 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Ethernet Octets Counter */
+#define ENETC4_PM_TEOCT(mac)            (0x5200 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Packets Counter */
+#define ENETC4_PM_TPKT(mac)		(0x5260 + (mac) * 0x400)
+
+/* Port MAC 0 Interface Mode Control Register */
+#define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
+#define PM_IF_MODE_IFMODE		(BIT(0) | BIT(1) | BIT(2))
+#define IFMODE_XGMII			0
+#define IFMODE_RMII			3
+#define IFMODE_RGMII			4
+#define IFMODE_SGMII			5
+#define PM_IF_MODE_ENA			BIT(15)
+
+/* general register accessors */
+#define enetc4_rd_reg(reg)	rte_read32((void *)(reg))
+#define enetc4_wr_reg(reg, val)  rte_write32((val), (void *)(reg))
+
+#define enetc4_rd(hw, off)	 enetc4_rd_reg((size_t)(hw)-&gt;reg + (off))
+#define enetc4_wr(hw, off, val)  enetc4_wr_reg((size_t)(hw)-&gt;reg + (off), val)
+/* port register accessors - PF only */
+#define enetc4_port_rd(hw, off)  enetc4_rd_reg((size_t)(hw)-&gt;port + (off))
+#define enetc4_port_wr(hw, off, val) \
+				enetc4_wr_reg((size_t)(hw)-&gt;port + (off), val)
+/* BDR register accessors, see ENETC_BDR() */
+#define enetc4_bdr_rd(hw, t, n, off) \
+				enetc4_rd(hw, ENETC_BDR(t, n, off))
+#define enetc4_bdr_wr(hw, t, n, off, val) \
+				enetc4_wr(hw, ENETC_BDR(t, n, off), val)
+#define enetc4_txbdr_rd(hw, n, off) enetc4_bdr_rd(hw, TX, n, off)
+#define enetc4_rxbdr_rd(hw, n, off) enetc4_bdr_rd(hw, RX, n, off)
+#define enetc4_txbdr_wr(hw, n, off, val) \
+				enetc4_bdr_wr(hw, TX, n, off, val)
+#define enetc4_rxbdr_wr(hw, n, off, val) \
+				enetc4_bdr_wr(hw, RX, n, off, val)
+#endif
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 66fad58e5e..2d63c54db6 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2020 NXP
+ * Copyright 2018-2024 NXP
  */
 
 #ifndef _ENETC_HW_H_
 #define _ENETC_HW_H_
 #include &lt;rte_io.h&gt;
+#include &lt;ethdev_pci.h&gt;
 
 #define BIT(x)		((uint64_t)1 &lt;&lt; ((x)))</pre>
    </blockquote>
    why not use RTE_BIT64&nbsp; &nbsp;?&nbsp;
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">
 
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 7163633bce..19e0fa3a07 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -1,18 +1,21 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2019 NXP
+ * Copyright 2018-2019,2024 NXP
  */
 
 #ifndef _ENETC_H_
 #define _ENETC_H_
 
 #include &lt;rte_time.h&gt;
+#include &lt;ethdev_pci.h&gt;
 
+#include &quot;compat.h&quot;
 #include &quot;base/enetc_hw.h&quot;
+#include &quot;enetc_logs.h&quot;
 
 #define PCI_VENDOR_ID_FREESCALE 0x1957
 
 /* Max TX rings per ENETC. */
-#define MAX_TX_RINGS	2
+#define MAX_TX_RINGS	1</pre>
    </blockquote>
    Why reducing tx_rings to 1 ? Will it not impact the older ENETC
    devices ?&nbsp;
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">
 
 /* Max RX rings per ENTEC. */
 #define MAX_RX_RINGS	1
@@ -33,21 +36,11 @@
 #define ENETC_ETH_MAX_LEN (RTE_ETHER_MTU + \
 		RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
 
-/*
- * upper_32_bits - return bits 32-63 of a number
- * @n: the number we're accessing
- *
- * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
- * the &quot;right shift count &gt;= width of type&quot; warning when that quantity is
- * 32-bits.
- */
-#define upper_32_bits(n) ((uint32_t)(((n) &gt;&gt; 16) &gt;&gt; 16))
+/* eth name size */
+#define ENETC_ETH_NAMESIZE	20
 
-/*
- * lower_32_bits - return bits 0-31 of a number
- * @n: the number we're accessing
- */
-#define lower_32_bits(n) ((uint32_t)(n))
+/* size for marking hugepage non-cacheable */
+#define SIZE_2MB	0x200000
 
 #define ENETC_TXBD(BDR, i) (&amp;(((struct enetc_tx_bd *)((BDR).bd_base))[i]))
 #define ENETC_RXBD(BDR, i) (&amp;(((union enetc_rx_bd *)((BDR).bd_base))[i]))
@@ -96,6 +89,20 @@ struct enetc_eth_adapter {
 #define ENETC_DEV_PRIVATE_TO_INTR(adapter) \
 	(&amp;((struct enetc_eth_adapter *)adapter)-&gt;intr)
 
+/*
+ * ENETC4 function prototypes
+ */
+int enetc4_pci_remove(struct rte_pci_device *pci_dev);
+int enetc4_dev_configure(struct rte_eth_dev *dev);
+int enetc4_dev_close(struct rte_eth_dev *dev);
+int enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
+			 struct rte_eth_dev_info *dev_info);
+
+/*
+ * enetc4_vf function prototype
+ */
+int enetc4_vf_dev_stop(struct rte_eth_dev *dev);
+
 /*
  * RX/TX ENETC function prototypes
  */
@@ -104,8 +111,9 @@ uint16_t enetc_xmit_pkts(void *txq, struct rte_mbuf **tx_pkts,
 uint16_t enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
 
-
 int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt);
+void enetc4_dev_hw_init(struct rte_eth_dev *eth_dev);
+void print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr);
 
 static inline int
 enetc_bd_unused(struct enetc_bdr *bdr)
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
new file mode 100644
index 0000000000..e96f390626
--- /dev/null
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2024 NXP
+ */
+
+#include &lt;stdbool.h&gt;
+#include &lt;rte_random.h&gt;
+#include &lt;dpaax_iova_table.h&gt;
+
+#include &quot;base/enetc4_hw.h&quot;
+#include &quot;enetc_logs.h&quot;
+#include &quot;enetc.h&quot;
+
+static int
+enetc4_dev_start(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);
+	struct enetc_hw *enetc_hw = &amp;hw-&gt;hw;
+	uint32_t val;
+
+	PMD_INIT_FUNC_TRACE();
+
+	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(0));
+	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(0),
+		       val | PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
+
+	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(1));
+	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(1),
+		       val | PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
+
+	/* Enable port */
+	val = enetc4_port_rd(enetc_hw, ENETC4_PMR);
+	enetc4_port_wr(enetc_hw, ENETC4_PMR, val | ENETC4_PMR_EN);
+
+	/* Enable port transmit/receive */
+	enetc4_port_wr(enetc_hw, ENETC4_POR, 0);
+
+	return 0;
+}
+
+static int
+enetc4_dev_stop(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);
+	struct enetc_hw *enetc_hw = &amp;hw-&gt;hw;
+	uint32_t val;
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* Disable port */
+	val = enetc4_port_rd(enetc_hw, ENETC4_PMR);
+	enetc4_port_wr(enetc_hw, ENETC4_PMR, val &amp; (~ENETC4_PMR_EN));
+
+	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(0));
+	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(0),
+		      val &amp; (~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN)));
+
+	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(1));
+	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(1),
+		      val &amp; (~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN)));
+
+	return 0;
+}
+
+static int
+enetc4_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
+{
+	struct enetc_hw *enetc_hw = &amp;hw-&gt;hw;
+	uint32_t high_mac = 0;
+	uint16_t low_mac = 0;
+	char eth_name[ENETC_ETH_NAMESIZE];
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* Enabling Station Interface */
+	enetc4_wr(enetc_hw, ENETC_SIMR, ENETC_SIMR_EN);
+
+	high_mac = (uint32_t)enetc4_port_rd(enetc_hw, ENETC4_PSIPMAR0(0));
+	low_mac = (uint16_t)enetc4_port_rd(enetc_hw, ENETC4_PSIPMAR1(0));
+
+	if ((high_mac | low_mac) == 0) {
+		ENETC_PMD_NOTICE(&quot;MAC is not available for this SI, &quot;
+				&quot;set random MAC&quot;);
+		rte_eth_random_addr(hw-&gt;mac.addr);
+		high_mac = *(uint32_t *)hw-&gt;mac.addr;
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR0, high_mac);
+		low_mac = *(uint16_t *)(hw-&gt;mac.addr + 4);
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR1, low_mac);
+		print_ethaddr(&quot;New address: &quot;,
+			      (const struct rte_ether_addr *)hw-&gt;mac.addr);
+	}
+
+	/* Allocate memory for storing MAC addresses */
+	snprintf(eth_name, sizeof(eth_name), &quot;enetc4_eth_%d&quot;, eth_dev-&gt;data-&gt;port_id);
+	eth_dev-&gt;data-&gt;mac_addrs = rte_zmalloc(eth_name,
+					RTE_ETHER_ADDR_LEN, 0);
+	if (!eth_dev-&gt;data-&gt;mac_addrs) {
+		ENETC_PMD_ERR(&quot;Failed to allocate %d bytes needed to &quot;
+			      &quot;store MAC addresses&quot;,
+			      RTE_ETHER_ADDR_LEN * 1);
+		return -ENOMEM;
+	}
+
+	/* Copy the permanent MAC address */
+	rte_ether_addr_copy((struct rte_ether_addr *)hw-&gt;mac.addr,
+			&amp;eth_dev-&gt;data-&gt;mac_addrs[0]);
+
+	return 0;
+}
+
+int
+enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
+		    struct rte_eth_dev_info *dev_info)
+{
+	PMD_INIT_FUNC_TRACE();
+	dev_info-&gt;rx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = MAX_BD_COUNT,
+		.nb_min = MIN_BD_COUNT,
+		.nb_align = BD_ALIGN,
+	};
+	dev_info-&gt;tx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = MAX_BD_COUNT,
+		.nb_min = MIN_BD_COUNT,
+		.nb_align = BD_ALIGN,
+	};
+	dev_info-&gt;max_rx_queues = MAX_RX_RINGS;
+	dev_info-&gt;max_tx_queues = MAX_TX_RINGS;
+	dev_info-&gt;max_rx_pktlen = ENETC4_MAC_MAXFRM_SIZE;
+
+	return 0;
+}
+
+int
+enetc4_dev_close(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);
+	int ret;
+
+	PMD_INIT_FUNC_TRACE();
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	if (hw-&gt;device_id == ENETC4_DEV_ID_VF)
+		ret = enetc4_vf_dev_stop(dev);
+	else
+		ret = enetc4_dev_stop(dev);
+
+	if (rte_eal_iova_mode() == RTE_IOVA_PA)
+		dpaax_iova_table_depopulate();
+
+	return ret;
+}
+
+int
+enetc4_dev_configure(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);
+	struct enetc_hw *enetc_hw = &amp;hw-&gt;hw;
+	uint32_t max_len;
+	uint32_t val;
+
+	PMD_INIT_FUNC_TRACE();
+
+	max_len = dev-&gt;data-&gt;dev_conf.rxmode.mtu + RTE_ETHER_HDR_LEN +
+		  RTE_ETHER_CRC_LEN;
+	enetc4_port_wr(enetc_hw, ENETC4_PM_MAXFRM(0), ENETC_SET_MAXFRM(max_len));
+
+	val = ENETC4_MAC_MAXFRM_SIZE | SDU_TYPE_MPDU;
+	enetc4_port_wr(enetc_hw, ENETC4_PTCTMSDUR(0), val | SDU_TYPE_MPDU);
+
+	return 0;
+}
+
+
+
+/*
+ * The set of PCI devices this driver supports
+ */
+static const struct rte_pci_id pci_id_enetc4_map[] = {
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NXP, ENETC4_DEV_ID) },
+	{ .vendor_id = 0, /* sentinel */ },
+};
+
+/* Features supported by this driver */
+static const struct eth_dev_ops enetc4_ops = {
+	.dev_configure        = enetc4_dev_configure,
+	.dev_start            = enetc4_dev_start,
+	.dev_stop             = enetc4_dev_stop,
+	.dev_close            = enetc4_dev_close,
+	.dev_infos_get        = enetc4_dev_infos_get,
+};
+
+/*
+ * Storing the HW base addresses
+ *
+ * @param eth_dev
+ *   - Pointer to the structure rte_eth_dev
+ */
+void
+enetc4_dev_hw_init(struct rte_eth_dev *eth_dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(eth_dev-&gt;data-&gt;dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+
+	eth_dev-&gt;rx_pkt_burst = &amp;enetc_recv_pkts;
+	eth_dev-&gt;tx_pkt_burst = &amp;enetc_xmit_pkts;
+
+	/* Retrieving and storing the HW base address of device */
+	hw-&gt;hw.reg = (void *)pci_dev-&gt;mem_resource[0].addr;
+	hw-&gt;device_id = pci_dev-&gt;id.device_id;
+
+	/* Calculating and storing the base HW addresses */
+	hw-&gt;hw.port = (void *)((size_t)hw-&gt;hw.reg + ENETC_PORT_BASE);
+	hw-&gt;hw.global = (void *)((size_t)hw-&gt;hw.reg + ENETC_GLOBAL_BASE);
+}
+
+/**
+ * Initialisation of the enetc4 device
+ *
+ * @param eth_dev
+ *   - Pointer to the structure rte_eth_dev
+ *
+ * @return
+ *   - On success, zero.
+ *   - On failure, negative value.
+ */
+
+static int
+enetc4_dev_init(struct rte_eth_dev *eth_dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(eth_dev-&gt;data-&gt;dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	int error = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	eth_dev-&gt;dev_ops = &amp;enetc4_ops;
+	enetc4_dev_hw_init(eth_dev);
+
+	error = enetc4_mac_init(hw, eth_dev);
+	if (error != 0) {
+		ENETC_PMD_ERR(&quot;MAC initialization failed&quot;);
+		return -1;
+	}
+
+	/* Set MTU */
+	enetc_port_wr(&amp;hw-&gt;hw, ENETC4_PM_MAXFRM(0),
+		      ENETC_SET_MAXFRM(RTE_ETHER_MAX_LEN));
+	eth_dev-&gt;data-&gt;mtu = RTE_ETHER_MAX_LEN - RTE_ETHER_HDR_LEN -
+		RTE_ETHER_CRC_LEN;
+
+	if (rte_eal_iova_mode() == RTE_IOVA_PA)
+		dpaax_iova_table_populate();
+
+	ENETC_PMD_DEBUG(&quot;port_id %d vendorID=0x%x deviceID=0x%x&quot;,
+			eth_dev-&gt;data-&gt;port_id, pci_dev-&gt;id.vendor_id,
+			pci_dev-&gt;id.device_id);
+	return 0;
+}
+
+static int
+enetc4_dev_uninit(struct rte_eth_dev *eth_dev)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	return enetc4_dev_close(eth_dev);
+}
+
+static int
+enetc4_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+			   struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_probe(pci_dev,
+					     sizeof(struct enetc_eth_adapter),
+					     enetc4_dev_init);
+}
+
+int
+enetc4_pci_remove(struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_remove(pci_dev, enetc4_dev_uninit);
+}
+
+static struct rte_pci_driver rte_enetc4_pmd = {
+	.id_table = pci_id_enetc4_map,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
+	.probe = enetc4_pci_probe,
+	.remove = enetc4_pci_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_enetc4, rte_enetc4_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_enetc4, pci_id_enetc4_map);
+RTE_PMD_REGISTER_KMOD_DEP(net_enetc4, &quot;* vfio-pci&quot;);
+RTE_LOG_REGISTER_DEFAULT(enetc4_logtype_pmd, NOTICE);
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
new file mode 100644
index 0000000000..7996d6decb
--- /dev/null
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2024 NXP
+ */
+
+#include &lt;stdbool.h&gt;
+#include &lt;rte_random.h&gt;
+#include &lt;dpaax_iova_table.h&gt;
+#include &quot;base/enetc4_hw.h&quot;
+#include &quot;base/enetc_hw.h&quot;
+#include &quot;enetc_logs.h&quot;
+#include &quot;enetc.h&quot;
+
+int
+enetc4_vf_dev_stop(struct rte_eth_dev *dev __rte_unused)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	return 0;
+}
+
+static int
+enetc4_vf_dev_start(struct rte_eth_dev *dev __rte_unused)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	return 0;
+}
+
+/*
+ * The set of PCI devices this driver supports
+ */
+static const struct rte_pci_id pci_vf_id_enetc4_map[] = {
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NXP, ENETC4_DEV_ID_VF) },
+	{ .vendor_id = 0, /* sentinel */ },
+};
+
+/* Features supported by this driver */
+static const struct eth_dev_ops enetc4_vf_ops = {
+	.dev_configure        = enetc4_dev_configure,
+	.dev_start            = enetc4_vf_dev_start,
+	.dev_stop             = enetc4_vf_dev_stop,
+	.dev_close            = enetc4_dev_close,
+	.dev_infos_get        = enetc4_dev_infos_get,
+};
+
+static int
+enetc4_vf_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
+{
+	uint32_t *mac = (uint32_t *)hw-&gt;mac.addr;
+	struct enetc_hw *enetc_hw = &amp;hw-&gt;hw;
+	uint32_t high_mac = 0;
+	uint16_t low_mac = 0;
+	char vf_eth_name[ENETC_ETH_NAMESIZE];
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* Enabling Station Interface */
+	enetc4_wr(enetc_hw, ENETC_SIMR, ENETC_SIMR_EN);
+	*mac = (uint32_t)enetc_rd(enetc_hw, ENETC_SIPMAR0);
+	high_mac = (uint32_t)*mac;
+	mac++;
+	*mac = (uint16_t)enetc_rd(enetc_hw, ENETC_SIPMAR1);
+	low_mac = (uint16_t)*mac;
+
+	if ((high_mac | low_mac) == 0) {
+		char *first_byte;
+		ENETC_PMD_NOTICE(&quot;MAC is not available for this SI, &quot;
+				 &quot;set random MAC&quot;);
+		mac = (uint32_t *)hw-&gt;mac.addr;
+		*mac = (uint32_t)rte_rand();
+		first_byte = (char *)mac;
+		*first_byte &amp;= 0xfe;    /* clear multicast bit */
+		*first_byte |= 0x02;    /* set local assignment bit (IEEE802) */
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR0, *mac);
+		mac++;
+		*mac = (uint16_t)rte_rand();
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR1, *mac);
+		print_ethaddr(&quot;New address: &quot;,
+			(const struct rte_ether_addr *)hw-&gt;mac.addr);
+	}
+
+	/* Allocate memory for storing MAC addresses */
+	snprintf(vf_eth_name, sizeof(vf_eth_name), &quot;enetc4_vf_eth_%d&quot;, eth_dev-&gt;data-&gt;port_id);
+	eth_dev-&gt;data-&gt;mac_addrs = rte_zmalloc(vf_eth_name,
+					RTE_ETHER_ADDR_LEN, 0);
+	if (!eth_dev-&gt;data-&gt;mac_addrs) {
+		ENETC_PMD_ERR(&quot;Failed to allocate %d bytes needed to &quot;
+			      &quot;store MAC addresses&quot;,</pre>
    </blockquote>
    can you try to fit it in single line?&nbsp;
    <blockquote type="cite" cite="mid:20251009111633.3585957-2-vanshika.shukla@nxp.com">
      <pre wrap="" class="moz-quote-pre">
+			      RTE_ETHER_ADDR_LEN * 1);
+		return -ENOMEM;
+	}
+
+	/* Copy the permanent MAC address */
+	rte_ether_addr_copy((struct rte_ether_addr *)hw-&gt;mac.addr,
+			     &amp;eth_dev-&gt;data-&gt;mac_addrs[0]);
+
+	return 0;
+}
+
+static int
+enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
+{
+	struct enetc_eth_hw *hw =
+			    ENETC_DEV_PRIVATE_TO_HW(eth_dev-&gt;data-&gt;dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	int error = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	eth_dev-&gt;dev_ops = &amp;enetc4_vf_ops;
+	enetc4_dev_hw_init(eth_dev);
+
+	error = enetc4_vf_mac_init(hw, eth_dev);
+	if (error != 0) {
+		ENETC_PMD_ERR(&quot;MAC initialization failed!!&quot;);
+		return -1;
+	}
+
+	if (rte_eal_iova_mode() == RTE_IOVA_PA)
+		dpaax_iova_table_populate();
+
+	ENETC_PMD_DEBUG(&quot;port_id %d vendorID=0x%x deviceID=0x%x&quot;,
+			eth_dev-&gt;data-&gt;port_id, pci_dev-&gt;id.vendor_id,
+			pci_dev-&gt;id.device_id);
+	return 0;
+}
+
+static int
+enetc4_vf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+		    struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_probe(pci_dev,
+					     sizeof(struct enetc_eth_adapter),
+					     enetc4_vf_dev_init);
+}
+
+static struct rte_pci_driver rte_enetc4_vf_pmd = {
+	.id_table = pci_vf_id_enetc4_map,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
+	.probe = enetc4_vf_pci_probe,
+	.remove = enetc4_pci_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_enetc4_vf, rte_enetc4_vf_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_enetc4_vf, pci_vf_id_enetc4_map);
+RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, &quot;* uio_pci_generic&quot;);
+RTE_LOG_REGISTER_DEFAULT(enetc4_vf_logtype_pmd, NOTICE);
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
index ffbecc407c..d7cba1ba83 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -1,9 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2020 NXP
+ * Copyright 2018-2024 NXP
  */
 
 #include &lt;stdbool.h&gt;
-#include &lt;ethdev_pci.h&gt;
 #include &lt;rte_random.h&gt;
 #include &lt;dpaax_iova_table.h&gt;
 
@@ -145,7 +144,7 @@ enetc_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	return rte_eth_linkstatus_set(dev, &amp;link);
 }
 
-static void
+void
 print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr)
 {
 	char buf[RTE_ETHER_ADDR_FMT_SIZE];
diff --git a/drivers/net/enetc/meson.build b/drivers/net/enetc/meson.build
index 966dc694fc..6e00758a36 100644
--- a/drivers/net/enetc/meson.build
+++ b/drivers/net/enetc/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2018 NXP
+# Copyright 2018,2024 NXP
 
 if not is_linux
     build = false
@@ -8,6 +8,8 @@ endif
 
 deps += ['common_dpaax']
 sources = files(
+	'enetc4_ethdev.c',
+	'enetc4_vf.c',
         'enetc_ethdev.c',
         'enetc_rxtx.c',
 )
</pre>
    </blockquote>
  </body>
</html>

--------------eu3I2jkdR0YVyICeiROscw5o--
