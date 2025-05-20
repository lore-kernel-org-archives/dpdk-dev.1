Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BAEC3ABDA
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 06:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16E22402CA;
	Tue, 20 May 2025 08:16:41 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
 by mails.dpdk.org (Postfix) with ESMTP id 7C9FE402AE;
 Tue, 20 May 2025 08:16:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSUMOtzHBFssKZfK8J4T4T/mw0JM4+ObKwWXUXiDd5lh9bhnzc/XG/Jw/2xuk4lY+ylI3ilh8eoztQmFcFkZzKsiWEQDaid3P1nHP+EKUEFsLtTBgcy5pEt+kRivXk5I2RVZ9CtXqAEQE+EteGZVCzCRnJeK2jaijzVK2nSaieJjzLeXHeBHN4arenyH8qiHL8PnLih0ZKWM/VAqqi9LI8/JsV1u3et/r1851D0uaL8M5sM3TAaTOwNXblavbW2PSw5ZywdFoJgvK17uv2qTffdCIk13c4hGMZ7LdF0nCh1I6j4k9ul1O+4uyj1C+cEtZTGX/41NqWVdxc1VtaQXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLPESx6gVrjlstJkZIu5FRZ5IHPIa6NlyyCYH/RBboI=;
 b=DdOoCu1AwCNOhMKhB/WxyUYYwk1iVqLe0fpQaVRuORsBXhFYN842jlDUEUWzZ522lR8CQZwj/w3gpW/3wYByZ1giAtoa+aDq/0EFATSq6IJRb0PljwErSvbEMN3LFUthH3xElumYC2/pjLaeTCxXBqnM9jfANMQQBYBMRO5M/v7ykRIYZCJvTgaSaKxAKT8Opjpp5XEuvmmBHlW72vRaZBevm9VUAlWqO9pQsem5WINmBXL4y77u3J9buOMngfJh06hKfr2LnDH68VDspAHlHMdXeZc6tvrIP1knSQYI2H1rCbKBA5pmh6+pqn68aqtLAuTyGPIOc2aS/J2D6kXFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLPESx6gVrjlstJkZIu5FRZ5IHPIa6NlyyCYH/RBboI=;
 b=dX3PHi1bUXObXGUbyg9618pAq2uYSj34he7cJrWQbngVj8PQPTqrXiZavGAxcwxYzZ27rO7siD+MIq7vJQSK7/+2HUi+vLJ1thpPa36A8zMrhOWqb5JmGRgNkCNsI80qpC0IxOtdjRgT0BgD9qJAn3yU84Vyku6jNUJsKWjaDc+QWEfegNTWD1/A1T5Um7dQ0oXjq8AngNjH91nS2LV/9IKNAd/dNqHpL0s4Jn/OYvA0eHseTx+1TraxjNH5IddgqaFUKysPPBJVamCKVZbjg89XrIb12Kpm08uqnu7Jjxmjs9iu7gXU9iZyvMkEkQSS6j1HKln5QvaMN5dwAU1U0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PA1PR04MB10889.eurprd04.prod.outlook.com (2603:10a6:102:491::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 06:16:38 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 06:16:38 +0000
Message-ID: <ae4e769e-80fd-a4fc-7f80-ae71815a9d9a@oss.nxp.com>
Date: Tue, 20 May 2025 11:46:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/9] common/dpaax: fix invalid key command error
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Franck Lenormand <franck.lenormand@nxp.com>, Akhil Goyal <gakhil@marvell.com>
Cc: stable@dpdk.org
References: <20250520055133.506071-1-g.singh@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250520055133.506071-1-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PA1PR04MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edfd44a-e5bc-4776-1e5c-08dd9765e0b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTBnU3JTdDMyWjNYZXh6Y0tRaUFpb05GdFNia0tHa0xSWHh1c3hmNkg3YVAw?=
 =?utf-8?B?TWpGY2dwUnQwZVpsZ0o0L1RTcldNNUZQNUlaTDJwNDZ1cjJWV0FGWENFdzFI?=
 =?utf-8?B?bDUzQ3Y1SUE1RU5YOEM5ZHpxY0Rza3hlVlFOT2JVY3RnTkg4ZUdUTzNURjhs?=
 =?utf-8?B?Znh5aitPOE5JL2ZmZlNSOEhETlVzT3F5dDNRYm9GRVQ5YlpVSVBhQWpDb2pE?=
 =?utf-8?B?Vlh2Y3RNcStpMlFaN2tmdFVJaHVuTWltS0YzY3VFcFR1T3VHSGUzQy90QUZ0?=
 =?utf-8?B?Mi9VTHRNbFNOVHVpSnBtU1l6c09HSUNQKzI0K0hPWWErdEFWM3MzOXpEME0z?=
 =?utf-8?B?QmlGdi9XdnIwMjVHbTVmTFZvZjY1M3JhSUtYQTQzSEFaY1VwVVdKTXpnVjdt?=
 =?utf-8?B?MVo3Z1AxK1E5Zk1mTTEzTzI4OVVRUjcyUlZybGQxWVB0MktMeUREbUU2OTZo?=
 =?utf-8?B?aEdUaEh1WFlmdHFxK1BHSnYyVFRWZ2JXMGVKcURqTjRLOTY5aVVUQ0RIa2FN?=
 =?utf-8?B?U3B1REFjclFXRFdDT1k0MkVkRlJxUzFXdE5XaTB4M0lmdDUwckQwa1JiK0Rq?=
 =?utf-8?B?Y0s2RnNPREhNVWtaNFpMcnlnbmxNem1QUEFCaVJyTGhNTWdiNWtXemFaRnRM?=
 =?utf-8?B?RU5PN1Q1Mnl0eElCdFBZeWxFckJsdTRRUndXTjljWTVibjFQdlplZllCTUJo?=
 =?utf-8?B?TDVWbm1rRHFSQ3AzOHZHU2ppU01NY3hhVmlGUGt4Ty9uYUVTbzhaNnlxN3N6?=
 =?utf-8?B?K1p4TmZkZVBkL2MxeDdKZ3d4M1dhSy8vZG5wYTlheERCeThraFJjVUlqRWZV?=
 =?utf-8?B?SWFEbEVOVDJRcmtiSnErU0RLUUlYSGkwT2F2WlEzSjVUbFZqajNRTk9DN2JB?=
 =?utf-8?B?bU1GelV4RTNBQnR5WTlNR1FkYmFVQ3djcUlyajV6TXhrU0dkOGh1Z3UrSGRw?=
 =?utf-8?B?Q1pjL0JrQlpaSFV1V245Uk8xS01lMFpTM0VCQy9OS0V6SllIL2VWdCtCS1BC?=
 =?utf-8?B?SlZSbWZtejZMTXlWMVB4dVJxekwxS3Jpc1ErdjhaTUNmSFRkMFdOYVNoV0tx?=
 =?utf-8?B?S2RTeEhVbXkzMlBUeHlUWFdHNnFMbmNWa0hqVkZ6Q2h5eWhnR2pUQWJpK2J1?=
 =?utf-8?B?ejgyYkN1S2NvZ3RGdnVKV1F1OHV3ekltUTMwUGJWdnJFY1A3ZXltVGpjZEY5?=
 =?utf-8?B?NkpFVEdnUWtRRlFSZ21yTGtqOUJjeWdBazQyRzZ4QUNPMk4zN0lrUVQzeU1R?=
 =?utf-8?B?WmJHazIwMkM4dzlTVFlXZmhxYUlLTXZVeXJTeVJYaFdkaDkvVlNyc0h6S3kx?=
 =?utf-8?B?MlV5MXgrci81RlVWQlFMSmtod3UyYzJZSlZvcisvQzlyd0kvUFd4YW9FWkhv?=
 =?utf-8?B?WEQ5TjU1RDMwTXR0azVHVVZ6TktiREJFK3lQZHF0Q1lxM2x4MExuL1RGNWU3?=
 =?utf-8?B?R3J0YXVQUVc0UmJqR3d6Y2taTFpBMVZta0NPSTF0LzkwbjYvb2NNYnl0cmRo?=
 =?utf-8?B?eWNvMkZzaW9vcFJuYnJibjRiR3hNNHUxOEJsdW1YeFA1ODNjUTNKUW5lWUJx?=
 =?utf-8?B?eGRKdEtKMEM0Rzh5RDNqK3JTalNrby80Vi9NKy9PVURTQ1UzSnRCMktsM0dR?=
 =?utf-8?B?MVlvVHdaZUNHV3N2dEFJRzV1dW1PWjRaLzlWczdLUGk3RFVsT2FBb0JGbHVr?=
 =?utf-8?B?MjBqRG9SczcrZjNhcHZDRnJCS1QycGFJN0FrSW1Rb1ZJVmlYdTZFWUI3TEw5?=
 =?utf-8?B?cVVuVTB1K1VBWWxYb3lrVVlFb0toNENYa2x3RGxaMndtd2dhNmcvM0pXN25m?=
 =?utf-8?B?Y3BhaWhmQXNNdjcraW9RRFZTVnZTNDZndjRKZm5aTGlEeG5XNDkwWWR1blNm?=
 =?utf-8?B?OGhzbFNLM1haWDVObXo5UnB4WXJBa2J5ZE4ySUEvdFZCWnpTbnJsWlh2dEN1?=
 =?utf-8?Q?oQHr8de6AiU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29MNVo0bHNFT1c5cy9JcGhuRCtPNDllQmp1UVo2YmlHM2VXRDZsY1FtRmdT?=
 =?utf-8?B?N0lvbE1DcXNQN3IxUVlCbEZtWFRnYUMyaG5OUU9MRHdTcmxxWk00U0Q4cjN0?=
 =?utf-8?B?c2c4ODRJQzRhTHBtR2NFQnlqUzY5NjlXSU1XU3Bhd1g2NjlUNkczd0g5bHh0?=
 =?utf-8?B?MVZHakhyeGxkY3NFWXNtaWlTazJVYXZxSmswZVRtdXZXUWI3em8rbTZHVHhp?=
 =?utf-8?B?VXNlWkJ0YTJ1NWR4OENicjRVUWpjcHc3emF1WHVESXg4NER5YU9vY0tuVkc2?=
 =?utf-8?B?NG1rRDRnZEMyQ1NTOG9JU2ptTkh3ZE52SHZCcXR3RzA1bDFtaVo2Wi9RSkVP?=
 =?utf-8?B?MVp5cnhpck96UnE0eTB6UWRLL1IwNkV0cmhrNHRjTXRDaXRldnd3bFJSTk52?=
 =?utf-8?B?MVZrVVpHOFN5eGFhS1NoU01qdk0wY0lySnYyTmVpajkzK3BISk11YkoreGc3?=
 =?utf-8?B?dzVPWGtsd1JmM2pjTmRyQVJzUWZmdVZRdCt0bWFUUWh5TTN3N2VXRGVvMHg2?=
 =?utf-8?B?K01YWnBocTlzdHBreGpZblFyRm90OWFGYkYwbFJleHVhTzR3K1FFVEhkZGNR?=
 =?utf-8?B?VUxac1BQV24yU2V0VEUvOThJd2lmRU5VeHBnelZNRTh6MnR3RjRESDJQQ2Nm?=
 =?utf-8?B?Y0VVRmd4SHFIcWFESmU4TmtJTW1rUTFEK0xUMnljNEZJNFBPUGdIVjd1ZTFE?=
 =?utf-8?B?QlU1R2hnNFBBTWF6WUgrL1VNK1dTOGtsNC9oeTJ6TjdiTmNqQ0ExM3Vnd3dX?=
 =?utf-8?B?MXZwRHlJcDFSTm93VnRwT203WHFBRWY0dEl0MVNpUXRhR2xQdVI4TExRR1R0?=
 =?utf-8?B?bVZlT0NodEFFcVM4UTZZYVhzNG9RQS90ekRDcXhUV0JSc3B4cTVYY3ltSXFr?=
 =?utf-8?B?N21lZlZhUzNVakVzM3pZbjBDb0ZXdFhjNmxWWDBIdDhXVmk4RHl1N2JZZ3d5?=
 =?utf-8?B?M1hpbUxBd2dwbWFtWGUzS0dBblJlNFZiQWZKSlVzdkZQakNQTDB0TDRWWXNo?=
 =?utf-8?B?VVNnSnpUY0dmSHJHSHpQMDJQMVVyc3piRjdPbFlPYWQycDdUYkNBcWFJL1Zz?=
 =?utf-8?B?ak4wMmpMNkJCak9wc085cEJYKzN4WlBOZS9QUnFlMC8zUyt4bG51UnZFMVNG?=
 =?utf-8?B?dDNGUXRjTEFES0duQUxvUlcxWFUxYkdzTWtOVnd4U0x6b0orRDlXQWhFa0Rz?=
 =?utf-8?B?cWVNeWJ4WFpidTZkVGlURzhvNDVmSkNGMThIYkxIY2gwNTJ6ajFjSG1tRlVI?=
 =?utf-8?B?bVVlZnluMGlIVzBRRUVsTk44eUJnSTh1OCtXSlVtRjdiL2QzRkx1ZmFWMDQ4?=
 =?utf-8?B?eVBmWnJodDV0Z2dUZjRIMU0zcFl4dDR4RndOdjduaE1OMDRoLzJkWUZSN3Bl?=
 =?utf-8?B?ME9TbGh3aU1Sd0l2TWZtalNlRVY3VXRnbUt1QURPbTBDWUNLcnlLM0JTU0Fa?=
 =?utf-8?B?SEVXOUtrZW1iTUNKVFZtUFRoTTkxaGFLZE9WSlBOTDNqYk1pdmJrVjZjdE1w?=
 =?utf-8?B?RGJoLzRHZVdVVmxXTjJWTU9OVFRWb0VPVzVSNGJUdnNpeW9WS2R2bWFtWkw2?=
 =?utf-8?B?a0ZzN25pM3lQSW4wSkFmd3RPYlROb04zWmt6NFhUVDhSUityb29jYVhDSlZL?=
 =?utf-8?B?bWpOM0l0SmJlZjFyZUorNVQ3UkdYRm9iemkvMzNqSUptQXk1UWZ1ZVJpTDUw?=
 =?utf-8?B?NEdoQ1ZadDd4aDU2VFZMd0VHbWZmbUtRbkcxT0hjeDN3WHdvbDU2bjFKY1k3?=
 =?utf-8?B?amo0cTdkNU15MVFKMHVkZ1E3WitQUUdHZEwwbnJZZkwvRzFrd3RNUVlEMyt0?=
 =?utf-8?B?dFM4VGFWcjE2UUk3V3ZLdGZ3cTN5dnE4c0VtRmtmK3lJcWtucmZzQTA1Z0NB?=
 =?utf-8?B?OE1BUG5CeVJIQ1RGWmR3Q1VOOU43cGRXeG9tN0M1NjFVTTNwUCtlRlU5MTZs?=
 =?utf-8?B?NGtXS1RQakszMXU4b1QzL1hGNUdyZ2tJVXNwenkvazFCTVJzeGFEalBsMEIx?=
 =?utf-8?B?WDFONFFWTXdXWWd0Z0NjeEU5OGJFTWp4Wk4ya2N4TzEyd3NTd1p2TlNDWjcz?=
 =?utf-8?B?OWl4cDRIZDlLU0tIS0xlWG1XOVN1TnVjRVhybklsV3I5NGlzQUppaTVYMDBp?=
 =?utf-8?B?cGpoVEI5Snc1bWUxV01zZEpBd001OVR1U0NKVHhjODlreXA2TUd5R01OYWRx?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edfd44a-e5bc-4776-1e5c-08dd9765e0b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 06:16:38.0286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94L/F0tYk1rSQCqBveGWc2ewqcshjHpRjvOqj8FZ0+DfO7swmpFUhwONnB36BHw1GoS55Og/9uGiHTvIGeKNbQ==
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
> Due to race between KEY loading to CAAM’s internal memory
> and initiating crypto operations can SEC errors in PDCP
> AES algo combinations.
Please fix grammar.
> To mitigate this, adding CALM instruction in SN 12bit case
> and using older version of descriptor for SN 18bit case.
>
> Fixes: 6127fff842a7 ("common/dpaax: remove outdated caamflib code")
> Cc: franck.lenormand@nxp.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---

Please send cover-letter for multi patch series.

>   drivers/common/dpaax/caamflib/desc/pdcp.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
> index 9ada3905c5..f4379ede2c 100644
> --- a/drivers/common/dpaax/caamflib/desc/pdcp.h
> +++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: BSD-3-Clause or GPL-2.0+
>    * Copyright 2008-2013 Freescale Semiconductor, Inc.
> - * Copyright 2019-2023 NXP
> + * Copyright 2019-2025 NXP
>    */
>   
>   #ifndef __DESC_PDCP_H__
> @@ -1981,8 +1981,7 @@ pdcp_insert_uplane_no_int_op(struct program *p,
>   	KEY(p, KEY1, cipherdata->key_enc_flags, cipherdata->key,
>   	    cipherdata->keylen, INLINE_KEY(cipherdata));
>   
> -	if ((sn_size == PDCP_SN_SIZE_15) ||
> -			(rta_sec_era >= RTA_SEC_ERA_10)) {
> +	if (sn_size == PDCP_SN_SIZE_15) {

In description, you mentioned 18 bit SN case, however here you are 
modifying  15 bit code?

am I missing the changes for 18 bit ?

>   		PROTOCOL(p, dir, OP_PCLID_LTE_PDCP_USER,
>   			 (uint16_t)cipherdata->algtype);
>   		return 0;
> @@ -2747,6 +2746,7 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
>   			    (uint64_t)cipherdata->key, cipherdata->keylen,
>   			    INLINE_KEY(cipherdata));
>   
> +			JUMP(p, 1, LOCAL_JUMP, ALL_TRUE, CALM);
>   			if (authdata)
>   				PROTOCOL(p, OP_TYPE_ENCAP_PROTOCOL,
>   					 OP_PCLID_LTE_PDCP_USER_RN,
