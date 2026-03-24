Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DAAF532D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 05:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9895402CE;
	Tue, 24 Mar 2026 06:16:03 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
 by mails.dpdk.org (Postfix) with ESMTP id 47B8F4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 06:16:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os92YiqFL6z4nIGeQKTRD02XjQJoU3uNCEQ3/UCIskXs0pfgqPxk5+7V0Ajidj8RNADuR5oTEPd5zPZYdPApm08l6sjDOKEXDgOProRnG5nUBibXPF+VrQyndaz2iRVNB0dKokCZ+ng3grqKeeAbvNa+OYK00OnWUqQGGK59ZddBc9pJqKHigtcb2nOG4g74ElYeg9U5lIpOZg2GDF1AzQMjCAOM+xYq6zI72KvM5a/001YfjlLe01PD479YsRtz0Xv5cfUS4waHZkH0T7Li2Jaxu3NZJaEBYlcU3Nlzvec/A1tg7mFVWBp1vQTHSs95+6N2VfiAmnwuqj7BPMdUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kypXRxSrekQRy7jKVbRByNyuR5axfgLaSg3ntpHRpT0=;
 b=qK8s1kyVyJrhzN6H8RkQO6VlAthNKrVdOF+fPx7l6FsJsy5die1Fe0M/ICiIkybd+nSBmbMrplOWWKLiabrjN6XeYGbuhNymAcol9q0elyGN6WpjN0SL0bjhvrwpXDKEVuONkv6Zd33iOg9he1hJm5GUvqnhsdFdYeNHbDFBkSoe949z9Lm6SZ09BopTm/0UVbNjGlyHbWsuqvA0Yxapu81vgV4IcbNJ0PqHk/9yveySduAaVpN5YsIr/AuXI0IZaIYpT4gPIz+d6jAtPt8TwmG/NJ1u56ZJZPz69oWSCuQ9AeTMxD2JnjshgOVHgioSIIgt23KSXO5yk/Y9xugEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kypXRxSrekQRy7jKVbRByNyuR5axfgLaSg3ntpHRpT0=;
 b=diJpHPx4/28oaUhTUb588dy5Kzd6LfPtLC+MPVHdSmKkiF4Ju8RkoQrTsX4tNqv0bpE3Sb+5+mGKgB1V2rMax/Pdnb91CtXYaTqA/9O80xDdSF6Dclb1/ObjEBOJNgPC9qeWKcl5Ve4ssBCnJyHaz7czrqLsq13H+Zp+5PgzHRYzn/+2VWnrIBmVCuGCQkW9Rah5GnSkNkIVWTjeJukEsF7nRWg9NpalsexhiuadCL3lHwbxIa5j1CWCO3Fhnziqtt8HYiup29E7DnAdqNp9SClEBCdwzvLUwZ1RL/dDm39UYippj6unGgBvbs6fFSacc/u12H66YhJynPQjFrCvOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 05:15:56 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 05:15:59 +0000
Message-ID: <1a4259e0-1452-4e00-ad3b-8a6f2ef93c55@oss.nxp.com>
Date: Tue, 24 Mar 2026 10:45:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drivers/bus: require probe function for NXP drivers
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-4-david.marchand@redhat.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260323105306.1531689-4-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PA1PR04MB10770.eurprd04.prod.outlook.com
 (2603:10a6:102:492::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB10770:EE_|DBBPR04MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 25aa6a4d-84a4-488a-b248-08de89646f29
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TtC+Btsd2L4U4E/CnfCm/McDg5QYHjjw5fTOJsP4BNwifdVaf0GoTNmyoNU71EGwMS1nOE/6Sk+RNeW2NWV4YU68JBaeNEC5nSoL9jibfsp7c8KSyImR2ELIeOov+m53pkQ9J3UMssO4YlxqtovvDMBg3hHk1BDEzUFGA+P9Z4FYyi3u32X2ubZILwFGU+IgvxTGJfVX/urdCfSPxVlykAL/UJiGNRyuV9WFUwEy91DSTRJqt7jjW86CwastLYOSJa0Z+u9F4mx8e4llihCHbYYi4hwIY9mfBiFVFgyexI2lkFhv6xm7xjmGTFrIM90BHwD2NCikNwLxLlohXRKCEwm4wAf7nAp3T4h3Er+XP6mDR0DRsRktuNJ6N1NEueI355FyDiyoeZAqRD0VzpMD3DEfMt84PuSVKhSbpComh3gtkcA7ZkbyWVpy6KUK+ag/CpyWPJn5IHoPnFhieQk1SIhjIoL6AcM1dxX3J0uYBUP+eqdE23ApxL8kIBLfW+AUSsSr66Z3zYfxzwAEFkBsCThXIidcq8BuyeY4PnXY5Xo5lwl7rqpKQZM8EOAGhHHTDVt/IL2GjNMbxO48SLdgMzogRDs5K480dzqiKumVrTp+GzlL76GQg7Kl+eVsp+29XsFr2yVFtSDnO39xkqnjibAPWRfKYbShuLH3LmVQvYTQBdIHTz4V8Ncjc5ZPQYDDwdsQoNTI810bR5sBHQYFjk+vG4S3Iu+0Op64YCj7j4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lNY21KSTNJcnFXZ0ordERoSFBScmloVFM0Unp5WWNnckIyWk8vbHE5R0tP?=
 =?utf-8?B?U25BRTZzMWNXaldwSXNhQXQrdUp1WjllV2VRcWJ0MkgxbkhqV05PNkcxVkZB?=
 =?utf-8?B?ZEVvb0FTRmVmOENGNWRNRjBraklSa2VaWVpwMWwrQ29kb1M3R2pFYzk5aTlX?=
 =?utf-8?B?Zy9RdzBzQ0xuQyt4REFFOTVmcG1FQmFpSjVzOEtTMDZDa2hmdmJzaThJa1lx?=
 =?utf-8?B?SUpDNlY1S05kK3dUbGNnTHh6S3RUazRBTnE3Qnk2QUcveXYvQ2NxL050TlIx?=
 =?utf-8?B?a0hjOWdJdHNHc3pzRms1OXFlak5PMVVnTjM0VHV1ZmxTbGUvblgxZm1TVU5V?=
 =?utf-8?B?R1RrVk0wTXM3clFNMzdpOXM1clNPV3AwbTFDU2xEdDVSZEkvK252NE1BSm9m?=
 =?utf-8?B?WlFpa3NMMkZJN1VrNjI2NWdTWGtxZ0c4d3NyUy9xV1I2TzFFSTBucll5bHR6?=
 =?utf-8?B?ZnhRZEpOcUtsT0M0K3hWWlpqdXYraGxpbVY3L2tCRHdzNjhTMDB1UlF4QzBV?=
 =?utf-8?B?NmZsZGlFQWVCTENMVTFHMWRFSDV4Y01EN241c1dpRjdWeTV2dlRHUGJxZC9h?=
 =?utf-8?B?YjI5bnRjbEEzMUphRWI2bkNnUW12SVZlc0xYeTZVeUpNWE1zZUxoMzB3eisv?=
 =?utf-8?B?VURzNXQrTllsYmhDci9sYmJObDBXa3BBbW4rMXhOUUhLV2daY1VmNHd4QjFp?=
 =?utf-8?B?VHNObkZKdnRnVzNTYzBUYVlzd1Z0OTByV1R0emhxZ2JVUWgwTVQ4TFFHNUpW?=
 =?utf-8?B?UkFrZmlyMjlpaG96dFZtY2xocXVCZ3MwajdGRzVzM2dPUnQyenYrbWM1c1hO?=
 =?utf-8?B?ek4remQ3emdPS0dPTXp3cmpvc2NsR2NYVkhTT1hja3lhSWhqMnNXQWRVQzUx?=
 =?utf-8?B?ZXVvWUZ5ZlBTd1h5N1JTWnVjQXBIYjFtY1RKeEpNek9hMXhEM2xhamU0clds?=
 =?utf-8?B?c21OMU84VWEwajFMeHVJVEtCM1dVK3IrMkVVOXBmVkJiM0k0SmRqdWdlSGNQ?=
 =?utf-8?B?VGdhbWNHWjBBQWU2L3NhOGVwKytHT0Jnck9pN29hbUpqVlRVd1NSTFYvc3BR?=
 =?utf-8?B?Mm96bGVzaUtjQnVJb3BZNEk5bnZPUE5GY0xpNHpydW5PUmxOSEJHbG1oejRY?=
 =?utf-8?B?TWdRbTlQbzVqK2hONVhYc2NUWFRybWZLWERhNjlPU3hveUsyMW5zQXRhZFZS?=
 =?utf-8?B?NHB4Z1lEM3BsOU1GMitVMEM1VEpPSFllK0MzWWVRZEROK2ZZYXJ2SFJraCtY?=
 =?utf-8?B?N0cxZDkyTHRvNlNMODc1STI2dU9iU0NTSWh1WUFHcDRUY2ZyZVFsUHppanow?=
 =?utf-8?B?K3k3bm9TeEtQcFRMdGpqNytsVHRScFVYTWF4eFdFRzZGbFlEOU56UkpSSFkw?=
 =?utf-8?B?Zm11Ui93bm9kRXBQRzRYSUNOaDdhWlJMd1dyQmw3YnVjVEs0bmQ0clVvOW4y?=
 =?utf-8?B?N3UzV0tqMVNuMUtKU1dRQmRGTkhBMjhVR2NUbXhLSmkzcVBkaGgxaXBYOFBY?=
 =?utf-8?B?VHNBbS9lQTNxLzFqcWFsQjl0ZW5lVWRRdHVpeXZ5SFVjcE9jOFg5aUh6VWto?=
 =?utf-8?B?Y3RqTHl3QmVpSzlEWDR6TlMxQkNob2wyM0Y3dG9FMTVPVlRqckFaR0M4VnZm?=
 =?utf-8?B?ZkZWOXBvMHd3bXBGK1VjRDJxT041dUcwLzdraWlYaUx5VVpTNkR4a1NLQnRX?=
 =?utf-8?B?ZSs1WXdBZkpidXFxYmZiMEw4R01TSFJQUUhSdW43TkcwbW1Wc0h3WlMxSDJj?=
 =?utf-8?B?NUJGemdtT0ZIOVhyM2J6RnE3Qm1MSWVIcDQxOXUvUE1aSzA4ZHk3aGZzaEFN?=
 =?utf-8?B?TDdyeTZJVktDZXd0UnZvZ0FaZXdvRTdoU253bjZja3ptZEhFemJpUmRHUFVO?=
 =?utf-8?B?RFlVZEdFRG9HSjhrenRCdzF5MjlCN0tMU3FvdHZCcmh4VjRlL1ArS0RVMjJW?=
 =?utf-8?B?VXRyZUpSczlPMitBbXZkelA2MzNvb1REUVA0dmlud0FzZDl4bWtMeGFnYzdV?=
 =?utf-8?B?a0VzUUNqYklubWdJWDZEUUIyRGxEd2lEeGVsUWFTZC9CNklsakY5c3ZRZmNS?=
 =?utf-8?B?NDJTRThnUlQ0MlRyMEdjYjFSZUVVU1ZjL1lsZ3Y0bnVjT1BMS1VsSy9SUmVh?=
 =?utf-8?B?KzloZ1dnV0hMTFJvcFFtaS9OQTkvc2dGVHZyMk9hU3BmT0RmZ3YraDhUQThB?=
 =?utf-8?B?UVFTSDhUVG5tWVNoWXQ3ekQ4cm0yWUc2QVc3NUNoY2tmVTErcWwyalBXdWdN?=
 =?utf-8?B?amdXRUwvbmdoZlN4aGl3aVFGU0FOL2VoUmFBWEZFaVRJZjhzR0hxTWg2OWc2?=
 =?utf-8?B?WnIvbXMzb2dvUG5tMStSeWE2VVJnYUZxQnE0cVFqbUpyaVBwM3RJZTRQN3JI?=
 =?utf-8?Q?WH+o5XVOZOUuOK1I=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aa6a4d-84a4-488a-b248-08de89646f29
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB10770.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 05:15:59.1204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1P8UXktWbLe5B8Tcujc3K1FvQ40gdm8Oxr9yz21otxkL8PEspPrHDIuZ8V+7JH64Lpy0d9ywXMcEECRLuImqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
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


On 23-03-2026 16:22, David Marchand wrote:
> Rather than silently ignore an invalid driver, enforce every registered
> driver has a probe callback.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

>   
