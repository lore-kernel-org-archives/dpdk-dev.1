Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D26C36010
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 05:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B6BF40270;
	Fri,  4 Apr 2025 07:47:49 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
 by mails.dpdk.org (Postfix) with ESMTP id 4C8AE4026D
 for <dev@dpdk.org>; Fri,  4 Apr 2025 07:47:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMlqaNJvWb52HRc1n7Bp2StLStQrHFcDsU+36Qmom9MEV24BRAyN+NSI4K6DdfYTBNkC1XNL78luWjNCPDEhqa21sUtHduFaA721vd78jMtpDZ592wLu+4HIeHxONUQtugJk3SDdobEDvVR1SZsw4aUdNOOQAese2q45J43ttHMY7jqngShR1JY4Xsu4OCA1QpTO8iuRW214ifHXujd8S9Pi2HStMZX9VBwcVp3rFPwaJCUPAvC4gh9E4dMQTMuws/iZfmfK/j93tUJUBUw3Ko+N4b9tb4KG59GAUKEqMGaiov0S+AdniR1x33/FmYRMaK+arGC4f8wA1Ds+x/aQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jKzJuRh2V++p4Pzyb8EKGlBYnlnq5kyEJm7roFPVr0=;
 b=tU3iUGSmwtTpG8qBCqSeFPYGwWGtRkO/v/CQp8gcS2vM+LM62vXxcClqSfRp5O4BO8w/wmY/T2tOfi2IJiIcrPl8ocBeDie25dey8ivC428V69th+LR/giSz7hX70YKLbT0LdmAMMwkAGQlk4EL9qHj83WpcH4pYHD0nsdSc/csGGVC0/kpkI7mk0bfR8Gp0If88hQNzYmdNIuHHxWjGPqHgCemv8jNXhSLlhywrKwE0XKWvInR47jocZxALZu/JlXUDV+qjjqgjie33as0vRvSddUIc6hic59eMSvMsj8+XVX/tl4ski00/p3X94w7ndViTtQu5RpeUR3Z+/ca+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jKzJuRh2V++p4Pzyb8EKGlBYnlnq5kyEJm7roFPVr0=;
 b=FFPkzBzUcudfEp8PIHVM3cbrCPCqS1gwroFDiSgnKS0+T4zz3aEp35iG2p+Q8OYo1Qa/niMkRrrbGEH6y++vi316mnSXtHodefiGwZHXsymqhBLKjW21tFKFOPe2ZQTpI4moR0su41O5J1+CrgXrzI/5nPRKvdAJOA8juEJle6CBynCQl+b8z27Ern5X3c+L/2tB17QE1vwdEk53Mqx8/kB08C/2CY7Wk9HTVzwfKki/EZ4hcaRhj1X54UQ09eOOcejkKPumRC+D+PaHc/WfIus1h1sCAl+7V65LtSPMZRfmWYDqpvDWg/NI28GRiJ9fb+W+yNSvsV4mFC4UA9vPkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 05:47:45 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%6]) with mapi id 15.20.8534.045; Fri, 4 Apr 2025
 05:47:45 +0000
Message-ID: <21d2ffa1-8ba2-df4a-f240-bd5d2c847814@oss.nxp.com>
Date: Fri, 4 Apr 2025 11:17:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 2/8] drivers: remove incorrect exported symbols
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
 <20250403165845.1315380-3-david.marchand@redhat.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250403165845.1315380-3-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbeabc4-114e-40d5-a117-08dd733c38f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZENkenhSdmNqRjJnUUlTdWxLNEhWUG5mR1hzQjFpR2ltbkdvdEJPZExaVThp?=
 =?utf-8?B?NVV6a0p0Y2xBRzBXb014OEtaL3JhcVRZT1ZPTy92a2NweVNzTVp5M0c2d2x0?=
 =?utf-8?B?OE5kQnIvaUdQNFQ3VTVqT1JqaDdlNy9Ec0QrVDN3M2xWU0NnQTZjZzVpeEc0?=
 =?utf-8?B?YkUrZys5V1RQZ1pqenRSUFNKZ0c1dEtLcTZXUFJFYU1qNnM3MFY5MFYrdkVx?=
 =?utf-8?B?QjI1eTVOdENGN3luL00rQjhBUUg0WXY1Q3RjZ1llOFBNQUF6S2NkcndIMVpn?=
 =?utf-8?B?Wm43SmdBQ2kxd0hLeG03Q2hySkdBQWVFelZvZThDRUh1MUpPTVErOEhxVys0?=
 =?utf-8?B?N1FLUWgrUXhPNWRUbDdFcnJKRk9jMml0cjZ4blV4UDZjcjJ0ek9CYlV1T3Jr?=
 =?utf-8?B?VWE5ZC9tRGhXbmN5Nk1MZFJlYW1ka1NTTTR0bXNoU09OdHp2NzNOQnB0MytW?=
 =?utf-8?B?OEN3RGVCdDZ2cHlhQkpYWXN0R1l2a1JjNjA3RTgxSTE4b3RPaW1NdC9xa1ZS?=
 =?utf-8?B?eVU0TnFWNW81dk5LN0lPM1hrVTNsQzBKRFdyMlEvbWtJRHVlbEE0RTZaeUdX?=
 =?utf-8?B?aGRSTTdTR2MvQ3BuL2J1dFZOdVNZcFQzeXlBdng0dGQzN28rMlAzRWM4VDAy?=
 =?utf-8?B?eU9pNTdVSFhhcjFVMkErYWR6NlR4K3ZaTTZkb0xvKytQMnF2M05SWGU5MU5H?=
 =?utf-8?B?Tzh2SGZzMlZOdnREbDROZWFCSVREUU5NUWpIWS9SZzA2VzFqaFhkZStNUU1C?=
 =?utf-8?B?TzV0MjY5d3VndGN3OE1La0J5M24vVFUxZ2NQOEYwSWxrME9PSzZVZm9KUVdu?=
 =?utf-8?B?SXZuT2YycDdkSnVuNExkVHNkdHlBZHFSb1pPMVNNdTR6WGtIZ2VjNXhKZ2VP?=
 =?utf-8?B?UmM3U2g2VkxtRHdVRGNjeWFuWFJoenZucGJoZllpclpIekIxK2k1ZllsTjNV?=
 =?utf-8?B?RjVWTndFYVg3dWtvdjlkM3pxK0NQV3JZc2loY1NxdlVna2hRVlFhbGVuMHg1?=
 =?utf-8?B?ejA5Z29QRUZVdW1RVGNVK0ptYUhYUU1SRlZWam5qclNZS1cvVFV3SjBiV1A3?=
 =?utf-8?B?dmpiMjk2NER3UGtKTittQmdsQU1MMEF4WkQ5aWhFV0Rxek12RXM2NGlhdWQ3?=
 =?utf-8?B?c1ZuVjdUR05nWGx0d1RjT3hVSkM4MnA1K3d5ajVDT1V1Z3hkMzdIZ1Bad2hO?=
 =?utf-8?B?ckZQeldxSEFoRkwvWUs4dEdXZ3hZQ2RKMGg4S04wTkZST0RKMUVGTkZmaWNr?=
 =?utf-8?B?OGwyZTU5MVQ3ajZNTlBNKzlMTXgvSmFNZ3hXOGlYTkM2akRVMkFxYzlld0lv?=
 =?utf-8?B?aWcrbTFYSDBpWVo3WU51RlVEWjM0MkhwWmI1Wkd6V1VwbXdRSUtiNSs2elE1?=
 =?utf-8?B?ZExYSnFlMTdsSGVTRlVQMHhXNDZidnUwUUJoaVJVRVBBNDVVaDZyeGdEZGov?=
 =?utf-8?B?QmRDRk15Qlp6UitBNEdUZHJwWUZhcy9QanRZNUlVVTVWai90SlhnYUREdzF4?=
 =?utf-8?B?amxndUFpM0dGcGpXNDczbkVEa01BWVdadXk1ZTdsS3lUKzN6QVF3UmlqUE1s?=
 =?utf-8?B?ZnlrbmdVU0xOd3RCZ3FPMUdkRlk2WVRyRHhEZklwSnIrNGl1Z1RsQ0VsR00z?=
 =?utf-8?B?MGZPa29kazdQWFZhUXpPYTRYS0V6Ti91aitKUnEvNGRoQ3dhT0ZVc1oxa3RZ?=
 =?utf-8?B?TUtObHllNzVXSHZ5UVd6Y1lHaGZ5a1MwV1dRcVd2UEpQSSthSEFIUE4wZ0hx?=
 =?utf-8?B?a0QxdnFRSzVPeFI5Q0lLT1VKaDMwQVRNQmd2SHE3WktZbURrWkFZbFlJdjVo?=
 =?utf-8?B?Q3ZJSEd5UzAwZ0dCbENvRndwVTJpaFcrVlhZUUxJY1RFbFRqMEVMYjZ4aVVv?=
 =?utf-8?Q?CP5rUh5DG05nc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEFDR21ZWEFnVzNzUC9jdzhvZEg1TmRHeGg1b0dSaWJWR1RkcHREd0FJaXNN?=
 =?utf-8?B?Z2NLMzFuMVEzSFdCNmJoSXdXelBaZTIwQVJyeGRCSWNCL09FZ0F3MGc0Nk9X?=
 =?utf-8?B?bEZtZmdiYWhPNzlIYUJ6cVpBZ3lzWmxUQzMrNlg2UFY3RkFzSm1YUFM4dFVx?=
 =?utf-8?B?REE5ZkxqbUxtUG5Uc1RWSFdJZkZxZVBWNjdpejh4U3U3Q1J6dUtMMFZ0djFP?=
 =?utf-8?B?elNtbzNLK0JqQ1E3MHpIV2Eyd1pUckV4THlzRW9iWWN1N3ZjdkFXaGp6UWh5?=
 =?utf-8?B?Q29qaWZBRHZLWUhIb29kQkhaaHVaSFA0UmVmYlZpWDQ1MWNybmZadFhUVkR4?=
 =?utf-8?B?WStISTlRY2t3YVgyUUZKbG1nMFpXVTBMM2VyMnZSbmpJQkptZ2YyNURUVmN0?=
 =?utf-8?B?SXlIN1dUUkFTVUVzN2FIZXpLaXJ0ekxKblhEbnFqYzFqTzQ4L2RVT3AwdzhJ?=
 =?utf-8?B?OUQyWEt6QlQ3c0o0SVBWb09JUG5HSzBmcGU4R2ExVE8yNWFpYzJmcjNVc1V5?=
 =?utf-8?B?eUZrd0kyQVFRVE83NmFkV25VSnRoSDB5cElwc1ZFVGo0MDJvSnlIc3lEayt3?=
 =?utf-8?B?ckZFSzg1Ry9ia3c2ak16UkhZQ3NvNlRoKzlzOFBYQnc5blZJdFFnNlRnbG4r?=
 =?utf-8?B?OXFtbi80bUFwclFxeGp6Ni9aSE9pOWJBZ3VueVM1d0pBSnFTYlNCc2tNb2k2?=
 =?utf-8?B?bmRQUGJzSFMrN3kwRWxIamhhVmduSmptS2ttTXBVUGd2NFc4T0liV2JVcjZl?=
 =?utf-8?B?clR5THkrQklPQllsTEN6QVV0S0V4b2V5d3FEdUZ4TWN2QUR5dml2UHEwQ2tT?=
 =?utf-8?B?eldTMDRnQXR3bEVJdzhvRXJDaVFDVWMzN202QmJWd1BYYkhhZ0dlbWRmRmwy?=
 =?utf-8?B?SWltQUkxdVAybTNNY0JIUjRGNDc5TElGYUJRblR0ZUFidzZidmQ2aURTRW1u?=
 =?utf-8?B?S2lNeW4yL0QzZDkySVl6WXVncEJ3UG52bUd5bVZEYzdpRWc2b1huSHJoeE9G?=
 =?utf-8?B?d2ZZQW1EUGtlR0xRVFUvY2R3ck5HNzB0ZWluOEFpNFV3VUlJOHBKZTBWcW5t?=
 =?utf-8?B?VC9Ba2QvNWJDYW5lNXNKdjVBTjdkcU9FWE5HUnBpM0RCSzQ4Nk9nb2VZc3c2?=
 =?utf-8?B?bGxyOGhCR2RQOUVwTlY1WHRvWDlPOGM5MFJwVFpuYm1janhMY1R5WVkvaSsv?=
 =?utf-8?B?dUNRcXQvSmhVTWpwK0dWY3ozNDBFb3ByY0wzS0p5cmdmN042K2hTSkQ0NmR2?=
 =?utf-8?B?bjFGNlArazZDeWZhZGUxNGdjdmtTaXQwV252YjNQckswNXZZVDVxYUdJNHBL?=
 =?utf-8?B?L1N5cmpnZ1lNeTJtd2hjZHY3MDNWRjVVMjh0MVlQMkdjSzNxTTlaT3BTMUNh?=
 =?utf-8?B?VE1yNVdXZXpZWWxUS0k5MDRNaHJ0WFlZYTdJdHZzY1dCVkFTeXRwOEtWYWxi?=
 =?utf-8?B?K2YwL1JKZ2ZZcU1yL1VDYXFZWGp3OStXSFk4Vms5aURrdmFzOXh5SjEzRDNT?=
 =?utf-8?B?aDdDeEtUQWR4RWd3eW9mUllrdXdHNE5lSnE1U2hQTk9DUURYUTFMZTNHdUZ4?=
 =?utf-8?B?K1V5d3lPaFdLV1BnekJ6WkhpQmpReEtnMTFZNjBWNUpvSDFGS2NsMGNsMTlY?=
 =?utf-8?B?cWdKQnNnZmNZNGtncXd6TTFOQVdHT0JIOHhOaDE2aTJXZThmbVdYS0pFaXk0?=
 =?utf-8?B?S1ZTTjAyTW1rb2E0bzJCUGFLV3lkMlMxY3FhTXdQaWhFdEtJUytFeHBFTytq?=
 =?utf-8?B?ZnVpUVpJdXVvMTRxcktidDM5SkFNTlJlZ1kwcW1kdDNmWVdnc0tOMmdPVGJT?=
 =?utf-8?B?TDVncGlDcldBeFRVVlF0T21mU3VPdVRTTFZpYlhDWlFHV3BHazBLQUhOT2dJ?=
 =?utf-8?B?TmwyYU51dEt3ZWFKeGJLMVRjb2Y4VnIzQU8vNXpNcFJsZzhXRzcrYTljeWs4?=
 =?utf-8?B?VUo4aXJMdUZyU0Fuci9hNmpGV2xDbDY1R2lJeEROSWN5M1JRNFpBU2xQeDlE?=
 =?utf-8?B?VnZ5VWNLSTczWXlNWFk5eHZlemFtRnZ0UTdZTHdBT1hET0NReC8zT1FqT2tt?=
 =?utf-8?B?Y0NQY0lMN0VhUnhneUpRNURMdEg2Y0hKbjlLbG1UZDBVcTZNSFZHbXFzVnlE?=
 =?utf-8?B?V3JyTjR3ditwYU84Y29oZFlNaWVVWHFRRjBlL2R5Y3oxUVNhV1A3Ym9OTEVP?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbeabc4-114e-40d5-a117-08dd733c38f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 05:47:45.0666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ke++LoqzhySR5ahEKNAu2ULjm63uZFaRiD+QGSn6AkSpLOWYJlKec9SgSW6vcuBnigcJky4n1E39xt/Ttw6JFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499
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


On 03-04-2025 22:28, David Marchand wrote:
> Declaring inline helpers in version.map is unnecessary.
> There is no exported symbol and this will probably be treated as an
> error by MSVC linker.
>
> rte_dpaa2_dev_type is an enum token.
> roc_se_ctx_swap has no implementation (leftover from a previous rework)
> and can be removed.

The commit message comments are not matching with the changes in the patch?


> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>   drivers/bus/dpaa/version.map    | 1 -
>   drivers/bus/fslmc/version.map   | 2 --
>   drivers/common/cnxk/roc_se.h    | 1 -
>   drivers/common/cnxk/version.map | 2 --
>   4 files changed, 6 deletions(-)
>
> diff --git a/drivers/bus/dpaa/version.map b/drivers/bus/dpaa/version.map
> index a17d57632e..8f09b72757 100644
> --- a/drivers/bus/dpaa/version.map
> +++ b/drivers/bus/dpaa/version.map
> @@ -18,7 +18,6 @@ INTERNAL {
>   	dpaa_update_link_speed;
>   	dpaa_intr_disable;
>   	dpaa_intr_enable;
> -	dpaa_seqn;
>   	dpaa_svr_family;
>   	dpaa_update_link_status;
>   	fman_dealloc_bufs_mask_hi;
> diff --git a/drivers/bus/fslmc/version.map b/drivers/bus/fslmc/version.map
> index 2c36895285..ba3c7f36e3 100644
> --- a/drivers/bus/fslmc/version.map
> +++ b/drivers/bus/fslmc/version.map
> @@ -22,7 +22,6 @@ INTERNAL {
>   	dpaa2_get_mcp_ptr;
>   	dpaa2_io_portal;
>   	dpaa2_seqn_dynfield_offset;
> -	dpaa2_seqn;
>   	dpaa2_svr_family;
>   	dpbp_disable;
>   	dpbp_enable;
> @@ -108,7 +107,6 @@ INTERNAL {
>   	qbman_swp_push_set;
>   	qbman_swp_release;
>   	rte_dpaa2_alloc_dpci_dev;
> -	rte_dpaa2_dev_type;
>   	rte_dpaa2_free_dpci_dev;
>   	rte_dpaa2_intr_disable;
>   	rte_dpaa2_intr_enable;
> diff --git a/drivers/common/cnxk/roc_se.h b/drivers/common/cnxk/roc_se.h
> index ede8d69c0e..f2c4056169 100644
> --- a/drivers/common/cnxk/roc_se.h
> +++ b/drivers/common/cnxk/roc_se.h
> @@ -405,7 +405,6 @@ int __roc_api roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type ty
>   int __roc_api roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type,
>   				  const uint8_t *key, uint16_t key_len);
>   
> -void __roc_api roc_se_ctx_swap(struct roc_se_ctx *se_ctx);
>   void __roc_api roc_se_ctx_init(struct roc_se_ctx *se_ctx);
>   
>   void __roc_api roc_se_hmac_opad_ipad_gen(roc_se_auth_type auth_type, const uint8_t *key,
> diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
> index cdbfc1d39a..7f40dcced2 100644
> --- a/drivers/common/cnxk/version.map
> +++ b/drivers/common/cnxk/version.map
> @@ -164,7 +164,6 @@ INTERNAL {
>   	roc_mcs_custom_tag_cfg_get;
>   	roc_mcs_dev_init;
>   	roc_mcs_dev_fini;
> -	roc_mcs_dev_get;
>   	roc_mcs_event_cb_register;
>   	roc_mcs_event_cb_unregister;
>   	roc_mcs_flowid_entry_enable;
> @@ -546,7 +545,6 @@ INTERNAL {
>   	roc_tim_lf_enable;
>   	roc_tim_lf_free;
>   	roc_tim_lf_interval;
> -	roc_se_ctx_swap;
>   	roc_ree_af_reg_read;
>   	roc_ree_af_reg_write;
>   	roc_ree_config_lf;
