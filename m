Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DEBCCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 15:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A1BF40E28;
	Wed, 15 Oct 2025 17:36:06 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
 by mails.dpdk.org (Postfix) with ESMTP id 0EEEE40273;
 Wed, 15 Oct 2025 17:36:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUyWj8TtHnMiIe09zQPTjAgZX4Zvu+wpzuRW4xFamQb8RQ1VZOsFH7HOYB9vygTZri0/isC4xEXSLQMeTRgpbBM+peV7Yu5YlwRJ9PSLhATkR10GX9ntYO9y96MWj+B5ufEh8I+8hqOXmvCHgsfibDZGFZ7h2/jzQiV72wtpW/CQH6jiJr5KSFpQ+tqF2nnU9rolPfrTSca89ayN55YLrfJnPiF4Glw4yWWNUc47UTH6RokENmRAsPgSLi96uvzDBFgsjz8DC+HifECV2Q74u0ji0MldSIOfqgGZ1WWvZfmt56pedSxrsU5PjOsuQdKCR/K0YxxafARDP+k8Rr4EZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJOLk8c1zYJAQbgnkTwu/6VQRmrDYR6skIC4hARp1Uw=;
 b=mCkouZLKGTmzXem1Er/opvbjPNasWqf+dm3HGNe6/r9cO8lpNvUWtwHJt566C7MVULg5hU3Mr/LTmIIbvu+3bwCEHGkZK9Y0b43MPWn1wwhu15QL76g4llOTGiLe2roO+fARWQbu+JS/u2hEmEA+Hjd7DGv5f/yfAzhNjwrGuC4PKCwIvWbeLisVW/DY7TKnc4NTEh/ORabifUseUvT2bK35h2m5sr7ZtnU1djVapMkdOMd1q9ggnbqw4t+IShsDOd+/d1MnE7Py2mY88RYfXFHt1myA9OlcDhy1U78aUa+WM9mNpJAUaVXXULYQb/AHgoe4+8X92rH5TSmJ7Yv7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJOLk8c1zYJAQbgnkTwu/6VQRmrDYR6skIC4hARp1Uw=;
 b=RS3IjDoevPW05Pti4DHh8smDzLPkZRmrtnn/91M/8aB2hghqsYMcX/ZsLKsWWuqmBa+RCH8DrisZjikljRw/8SN746m8pj/AC8Ff3yuxocN8cxHyYvRPzLesX/eu4Nu2wGgA+gQ5+auUr/yT6a++sEICTOJ3Aiqlk78SCJkY6Js4ztEI3mE2vSO7D3SzXkXREuLpiecmFyL5y7dVf6QmHA9hs5ZdMCr1ku5fhD+kcepwkNWgj36vt/fFMa/664if31igzL2lJF+VGyCssXgqvREiXK0JnaahGBiu9BcAAUF+ar+cLIgr8KPbIQnBb8haQgkCmL51KC36ZajkF5svQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 15:36:04 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:36:04 +0000
Message-ID: <07f30dcc-aef3-48f4-9ff7-6232882e2d47@oss.nxp.com>
Date: Wed, 15 Oct 2025 21:05:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] net/dpaa2: fix to recv packets with additional
 parse errors
To: Prashant Gupta <prashant.gupta_3@nxp.com>, dev@dpdk.org,
 stephen@networkplumber.org, david.marchand@redhat.com
Cc: stable@dpdk.org, Brick Yang <brick.yang@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251014064035.1312896-5-prashant.gupta_3@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251014064035.1312896-5-prashant.gupta_3@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 023f48e2-f1cd-407f-315a-08de0c008d24
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlRELzVlQkFSZHJ0SkRyYnBRTUhvUXlMemZPVDRITDE3eFBYT1psVVZUN1lU?=
 =?utf-8?B?aHRCZWxPcStmUzQ5K0xwRi9ELzl3UTRFbWdWc0VRYmd4VjBCMGpMa1d4bzAw?=
 =?utf-8?B?RTdGNUVUcm1Ia1RDdS9jU2JDb3ppOUs5SnVVOGMzYTJFZjNxS1NOQXoyU3Ew?=
 =?utf-8?B?b0pSNm12SmhlNEdBaE9VWjJWNjNoKzRlRnlVQWtMUjlqaGpMU0VKcnlPM3Iy?=
 =?utf-8?B?dU1qWGs3VnBmSGk3K0J6aHpJUHE2NngwL3UvRnhLbFpOdkNRL1RnbDlZbjBl?=
 =?utf-8?B?TERpcnpURHRwbXFwa01aRERWYnJ3RVFtU1JJbUlKQ0JkVHQwRTJyMm5TQ2Zy?=
 =?utf-8?B?eCs1TldLYkJoUEpEZC9aSVJER0lJV1ZEMUdJaCtNSDNVcXQ4cVc5Y09ZZGFh?=
 =?utf-8?B?NXVxdEF2QmZWTDZNT2pmMVRTWk4yaE9STUpXdSsweHhnZTNDaFRsNWo0bGZU?=
 =?utf-8?B?NjFicXFGaUM1anNpUmxBdFFnQUJsa2xlTXhTWldQMUxUcFA5K01RaTNMSGY0?=
 =?utf-8?B?S3p0MXdwaW9qQk5jN3ZIOE5FQnc0bEVrekFFeUkwMnJJWEtySEllSXFqOE54?=
 =?utf-8?B?bWJxNGQzb2E2QkFLRnlMUHNacDIzWkJjbjBQREVaTGRHWlNXT1l5NmdsRnZJ?=
 =?utf-8?B?S1plb0M3L2tlN2RWaWdsSmc3V0VzVS9udnl0MXRabHBYTTh1Q1ZIWDhrWkcr?=
 =?utf-8?B?VGJOQzZqY1hzUFlLMW9maGtHckVlblNzcEw4dE1TbUt3WFFZWS8zUmFoRjNP?=
 =?utf-8?B?b1VtazB0OWVNYndyZ0kvbjVBS1pWZ25wd0ZJcmYvYUxkOFVuTHUwL3NmOWhJ?=
 =?utf-8?B?SURDZ3BMZzV4bytGaVFaUWViSDYweEZqQS9XZVFhcEV3REVuZTIrVzhxOHVj?=
 =?utf-8?B?ZnRtSVRpM2hMNTU1bUtnYXhwL01jUStEbStJU2N1SEJhQndBZmxOZlF6WXNx?=
 =?utf-8?B?TjJ5UFJvTXIrS3M4NjZGRlVKRU02UitMZ0g5dHlrTmk0c1ppck41VFRjMGhQ?=
 =?utf-8?B?eXpPQ25qU295TTZCKzFiRWZvNXhnL0lweHEzSlYrUVg1S2JZTy9rdU9hSmV3?=
 =?utf-8?B?anh0ZndqbW82RXhJaE9QNk8ya1l4WVRkRnlVdURBdWFLSklCdXZkZnFsSm50?=
 =?utf-8?B?Q1VXcGlUZ29BNWV1ajZqZTRCZk5JeVN6REdRVG9PaW80NENVanJHN0grSU1D?=
 =?utf-8?B?U2ZZelJYTkRidEF0NTVPT3NpRFBGdXJxODNUVkJCNW9iaGVLbDFuVU16bGV2?=
 =?utf-8?B?SlYzdVFlbVlhYVRjMXpCcUp4VmtBaHpCUm5TZzNLM1VyYlBDZk9MUmhRQ29z?=
 =?utf-8?B?N0FDWXg5bDYwMjFaTVQwY0VVTjNlbjdrcDlFTTZwaWlreXRPUVV0eXE1OHND?=
 =?utf-8?B?VzI1RFJmWmN6TElQQ2NtUzh1SlRKaGdEb2FCbzJ5b1luTGdyeTZOWUVReWJP?=
 =?utf-8?B?eHpMcVJOK3JhaDAvaTc1MTNhczBKaEx4SVo3YUJxMHpKaDNHUUZwK1RacUFF?=
 =?utf-8?B?TXdIWE5ETlZnVVo1a04vUjVlNVJJaC9WVmtaYXBQQStVVU1PWWlHZW9QWHdh?=
 =?utf-8?B?NUJiWmkwME41YnRkUjVGeGE1N3l3ZXBBUXBkTWlnNm4xWmJMYkt4ZE9NSlBX?=
 =?utf-8?B?L2dzWCtrYVZCbkZORTFMQ0YzU25BNDRFZ3hYdVZXcE0wMXgzeTFTK3hMcGZZ?=
 =?utf-8?B?N0xwOC9yU2tkYXBBN1dseUxYL0lJS1AzTDdSUkF5ZXFDdmt5RlJlQTRTVWxo?=
 =?utf-8?B?TWxLTWtBQjZXY0N4bzZzWEhsbG11ZXZMMlRQZlNMaHdZa2M3b3JiOURQb2Yz?=
 =?utf-8?B?OWErcEUrcmxKS0VBWCtHMmFMSVRsUzZhNmViUzRDTE9SaFphRGdqT2tBY2ts?=
 =?utf-8?B?aEt4TGhJK05ZUDdiRk0xdnlJTTJPMkh4TzFEeS94RkRDUmFjbGJGS2dEMXNT?=
 =?utf-8?Q?GIEfobmzQDNVrDUr5uG0EX/kVJnWlswe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNQVnJMQmVsK2pCSGY3MmNYNllTakRETWYrYk9nTVQ5UmtST1AvdS9rTmhm?=
 =?utf-8?B?eXlJa29GeElJSkQ0RmZZU3NZc3VQSGNQNjFvWTdxWERjV3pKeXE0RXcvZURj?=
 =?utf-8?B?SkNRTUNpSnpMYVdUbzhMK0VDYnlnKzhmUTd0S0FZdXZlN3lGRE14VGNibUFU?=
 =?utf-8?B?bVlpVXE1N00ySjZRcXp3QTF1dWxiMnhwYjZFdVlOK2VzQ1ZnKzl1ekdsdnU0?=
 =?utf-8?B?TXArSk4vT0sraFdYM291M1BhQWtQZWFJOUR2R09Ga1Ewb2lxdlZBMHk5Yndv?=
 =?utf-8?B?MG5TaGRQdWhhREZSajdnRFlNRnhidU1ZUXVBNHJaMnFEN0NGV0ZYQWZrUk1h?=
 =?utf-8?B?R0lKelZKK1JkbzRZQWNhL0YvS0FlOTlBQTBndTVIdEVMMXZFaytqZmVMdkgy?=
 =?utf-8?B?b3JQZFVsYVVCbUVJeU5RVG05QjFFM2hER0NYRzJkSGovUFU4L0JWOWw1bkVr?=
 =?utf-8?B?cUlhS0dWUDRPRllwZVJUaW5xMlJpUllEQURqTFZjTnoxWFU0SnNXV3RiZU5I?=
 =?utf-8?B?TXEzeDV4cUpuS293cTJnY3g4eEtpSVZTRVhhcitiV0dFTG8xNWE2cXc0bGtl?=
 =?utf-8?B?ZEFESjJ1dnRUSlppUytFYVk2NGVlYzRhVnljckVnRXViUDRHellEVEltTnFl?=
 =?utf-8?B?NUVHUndrUmE2OTEyOGZqSzlzcWVxZjRJVG5VQzd0YXd1N3owS1BYY2Fxamli?=
 =?utf-8?B?R0xDZEEvM2tkWm5vVUtvQVhQTW8rYVI2QlZja1dlWjlFZTFUVHlRODBhL3Rz?=
 =?utf-8?B?aFc4REp6MEM0cS9HdHdndWZnTDBLM0g0cFhmVzUzQkRUVmxEQ2ZYekVWZ3hw?=
 =?utf-8?B?dHFjQUpoNWcyMmN0bHpJbUV4NmNHeks0QXRaZ0VoRDRTVHcvNWdaSVRSUVkv?=
 =?utf-8?B?WHNvY0tkZnpCQXBsazF0STZRMERuSUFZMXJQakF4SWNrS01EMHJ2bEdIMnZ5?=
 =?utf-8?B?LytVdUt5UUs4TVcxUVdDMzdhMVFIbVBaVmxubVk4eGpRTUQrWjQxTEk5UWhr?=
 =?utf-8?B?eHhCaVFybUZvNWVscmloY3hCY3dOSm9XdXNDaElsUldHL1E2ZmlST2dHWlI3?=
 =?utf-8?B?dFhXZWVaMkVsZ292TVF0VlRXU05RYkpBQkNsbGkxaGU5aFFKVGQyWlV3bVVF?=
 =?utf-8?B?eHJvUkhaL1Z5WjFNYXk4SFh4Z1BRd2Q2OUdSc3dJclZjWDYwdkNqeXp1MDU4?=
 =?utf-8?B?bnZUVVJQMEV3cDJFM1o3WWRJVzN5N2Jydi9RSEFxS0dGVXQzVEJ5dnJPVEU2?=
 =?utf-8?B?bW5qbWhYY1Q1dUh3Z3ZKT3VCOWgxdFJhNUZJNkI3SFVBZFozcDg0WVhFN2I5?=
 =?utf-8?B?S1p3NldBWm83dGpySmNYakVZU2pMNzJvWmJYc09wS2JjY1dYUCtLMDJiTk9m?=
 =?utf-8?B?WndUQ0Qzd0FDUEd0cUs1Zkg4VWorSGIyVzZKNkt6WmpJOU9zcnhXb2lJYVFr?=
 =?utf-8?B?cUZVU0pLMVYyaDlXQ1Fmckc2Ky84RU9JWmFQRzdTUTY3NjNCSmFzdW92UHF2?=
 =?utf-8?B?S2RaZ2ZYWlB3eWd2eUpjZzRyb3hZcmhFL1BFRlAvQkFGa1RHK2E5L1R6di9l?=
 =?utf-8?B?aUFMVzFsa1RHYnl5WHZaaTBybXQxNEpHc1BOQVhnMUU2MGhFRzNtMVVrN05w?=
 =?utf-8?B?Ty84ZjRsOW1VSzFweU9sU3dYbU92SzRNYk8zc3FTcHVVZGdneHk0R2RxY0tC?=
 =?utf-8?B?ZlBrVmEvdHYxK1Y1NHo4Yk1mcHNKM045bWx1dEhxeDVzZkpVNC9lMnUzcFYx?=
 =?utf-8?B?c3ZHdGRxNUJNVmszczR0bzVIeitLM2pVVEtuZUFyVzJEeXlPL29MTzkzUzN4?=
 =?utf-8?B?TUI3U21icDFZUXgwT2RPaGlHeDZWY2FpVjBvTHFpbzJWTk9wZFlEUnJrSW9z?=
 =?utf-8?B?ak1QQnJ0MER4SmNOMG1TQzJzNmYzYTdQOWI1Qy96bEhvZkhQbGo2SVlad0tt?=
 =?utf-8?B?UWg2NHF3R0ZaY1I3SHI4SVczbllYbWI1dTlpS2YwaUIvK0t2cmpSdVo4ZjNM?=
 =?utf-8?B?bDd4S3o0eVVOVk5NbllMc2hXcXFxaSt1WmUxUDFFSHZDUlRURXlUM2NnNlpv?=
 =?utf-8?B?MUpGYkdvUCsvVDRVNlY2NUc5Z290QVUwSzNLUWo5MWFHN2IrdzFscFo3TEFU?=
 =?utf-8?B?bUdOdHN0NUFSVWg4VyttbC85eW9iTmJFLzJ1dy90WkJDVVBNL3hRaFI2cEZM?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023f48e2-f1cd-407f-315a-08de0c008d24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:36:04.4683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnJiyoHuJe//oUd57k7+/Qz8mqoEQln2kXqfwhmzBo0KGoAUsfQ5/1XgnQWwqokjeAzQLreovAVUI9eYZQUdeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
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


On 14-10-2025 12:10, Prashant Gupta wrote:
> [Some people who received this message don't often get email from prashant.gupta_3@nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Brick Yang <brick.yang@nxp.com>
>
> Also receive packets with HW parser length errors.
> Thus this option allow to let HW drop packets for any kind of parser
> errors.
You meant *not drop*  ?
> Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
> Cc: stable@dpdk.org
>
> Signed-off-by: Brick Yang <brick.yang@nxp.com>
> ---
>   drivers/net/dpaa2/dpaa2_ethdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index 41678ce09b..0fd577c448 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -1240,7 +1240,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
>                  err_cfg.errors = DPNI_ERROR_L3CE | DPNI_ERROR_L4CE;
>
>                  /* if packet with parse error are not to be dropped */
> -               err_cfg.errors |= DPNI_ERROR_PHE;
> +               err_cfg.errors |= DPNI_ERROR_PHE | DPNI_ERROR_BLE;
>
>                  err_cfg.error_action = DPNI_ERROR_ACTION_CONTINUE;
>          }
> --
> 2.43.0
>
