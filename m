Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5588E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 10:57:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92D39402AC;
	Thu, 19 Feb 2026 11:57:09 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
 by mails.dpdk.org (Postfix) with ESMTP id ED35F402A2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 11:57:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMz1FdteGbLRWQLWtPYg5jJkKvBTdtU94PdlVJYbBO9Ju1PdHof1M1dW+S4ZhByYXyS0cEOSTuw4ApTOU19Fdr4Fx0NiN34SQPDnx39m47VLaGagmrZ8hayC9+SMREBQmOdFMbi0bHyPr5VyLnUN8UGDdfhiYghalYUakf6ZDfHs7ip+2FGfUPv7QaX/5WXYDbLrgc/Ks1hAa4jg/Ayz3PZmLbjLJH+496hVVoclV6hkdRE2zuwpMiSiY+nuGG/lqx6NdsNubBIQY88TxoEmJ4tf4cGNk/WaaS9Hwm7ke8zLxQRES5meZHpx07oS2KkKKn32tkEJrF6Iaq1RnBAu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QjH6l3JpG8rKQVCKLjsU3nUssRGkXIMeBXm9hV8noc=;
 b=OcU7o5FKlWGmN0DZdtNCEoHxL3NReEBfb7LgnvatjuCdETy3OZNHlc81klJmZ2zGEt7/t2xouPSXN6bRIme9IcyDUNsc0IrlMdp+3CAdZ8scaGQzqiFXCBNW93iQYgq10VT2RGUYutTepZSDpsBqAX+mIeYemT2mmnukLZaDkiGuSL0Ov54n3JkmZ2YLm91FxZPZC2Uyhg6GQbJEHbC/7o2CEoaidNBTdmNOw+7tOSWQMJM7i8O+/I14uG2vprWe86L2bu8RaDqVA8rjjI9iOndBmNi6oMA5AlQhnyCYROVKXDSfhLgyDAWYa9ehxMrjrvXoMTpnFS4Wa8pMhmHWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QjH6l3JpG8rKQVCKLjsU3nUssRGkXIMeBXm9hV8noc=;
 b=qEvYRbEqwKUvTYR9PqN4mAxXgPQUdi/2M5/0PH2MY+bOItRG9lM3B4VGBCj57G3OJM5mgyDQDKZPjqTX+ISs6G5i1e2B1JZsOv4XfYT/hy9fFFDuB/uK8S1VdeLFShqfASnNfvRPUxWzdqXmqXOK3y1h2p19hfEcqdBpsC48fJLnDq2aU+dLDr+ZnGKL/EvcRAUgldyJJc+V7ch3CKP4Hnyt2QHQd75jmRwDv3cRXEtrq36LRTU/qFwPXD+p4yP1ee4HN2ideAP51/MR087exaEzOxBAxF+i70JZH2qhU+e60Zl1dQ3bwHHFEuNwiG7PkOplbHyAo6InkRewwryhrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by PAXPR04MB9007.eurprd04.prod.outlook.com
 (2603:10a6:102:20f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 10:57:03 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 10:57:03 +0000
Message-ID: <fed52258-7066-40bc-9cef-b3388062628a@oss.nxp.com>
Date: Thu, 19 Feb 2026 16:26:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] net/dpaa2: fix rx error queue memory leak on port
 close
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-3-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260218160453.142311-3-maxime@leroys.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|PAXPR04MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: a00c9812-79f4-4cb8-30dc-08de6fa59d0b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGMvL0lqM3kvdVZibkZQb0lHRnQwVk5jT2ZnZUpzeWpyazVkQ1dyYlhjSENn?=
 =?utf-8?B?eENWb2djUkh1U050Vmc5enJKakNLTVNwV090S3lwUW93cHV4ZWxVNDYwM3Qx?=
 =?utf-8?B?M1RrZUM4em9adjMrc25tUUtCUzRJdk5BamJveVBOamVlRmZ2Q1l6L1RZM2RD?=
 =?utf-8?B?TWg2VzJ5VHE2SnkwL252RFJySkUyT0UrOHhQOVU2U2w2TWwvbVgxVkZHT2V0?=
 =?utf-8?B?RXJRMER2Sm4yU3lnKzRHbE9kVlFSTDBHUDQyMWRlWHphYVlwOThabnlHQWF0?=
 =?utf-8?B?ZFVRcnFjb0psTFpHb21UWFdVcnQvaUVSM0VjODd2RDRmS1pzOFJya2hLZVht?=
 =?utf-8?B?TmtOdERwc05vTlYxcmVmNS91ODBpQ2ZiSjB3eWtzQXo2K25IeEV6b0xYbWkx?=
 =?utf-8?B?MXYrMTA0VWx3RmNYK2JzMldpYXdRSjFrakQ5c1krdXpvMktkSkUvL3hNRXRS?=
 =?utf-8?B?VDNkcGRIQXVxMFZ2WStFTG43d29Hc3ptcHdiNCtzQ0x2NmJCQmhBNGNTdEtH?=
 =?utf-8?B?RjNSMmpSUm91YzJXU0dqT3o0aHlCQ3A3c0Q3V2dMczFmT1ZFM21Ybm51RzhN?=
 =?utf-8?B?SGVLSTZQUHdvUTdzeFZXTVBxYUFrb21SME81YVFuT2diZ2xBNG1FZVJIZlFo?=
 =?utf-8?B?MmRQZFZtR1Y0Q2x1YlEvNFZGZjc5YVFEZHdYODNBTnNaWXhrcS9FV1JXSTFO?=
 =?utf-8?B?Y1RUYVdKN3hNMGJNM29mVWpFUlVZaVhQdnBEZUVvL2ZKdGdRUTYxK0V4NEky?=
 =?utf-8?B?RStqeTh3cC8veE1sckFmMDlGeitEZ2FBMlUxWGEwRytSN3FnTFY3RExQNGJH?=
 =?utf-8?B?WWtVSXNRdWx2d1V4dDd3M3NjOVlNVlFORy9DQnN1Z2ZuRHIvb1NtN2RDVklN?=
 =?utf-8?B?Kzd2NWJsR2Y0VGJSK0lWY0Q0c3JuSDI2Q1BEQ05kMERaSHNHcFFtVmwxakpD?=
 =?utf-8?B?V09PQk0wYVN0S2l0WFNRUFpDM2w0UkpFVzVySG9idUpGU0YyQWRsVFFKZU9S?=
 =?utf-8?B?elBNeXd6WGk4VnFaUWYwN0NaSGM0NU90VHVCZUZEeXltQm5jdlk5UnlhVG51?=
 =?utf-8?B?QTdGV0Uxd2MyelJGY3FhUHhlb2pmalJCNU9BWmRUeFRaUTR0eVdjRlAwVzJ4?=
 =?utf-8?B?UlJlWm13bVliOVFtSkRaeTY1TWk3L0VNcEY0d3ptUGloUEw2T3pOa2NwQnFJ?=
 =?utf-8?B?N2ZQNEdpY2JGRTlyajgvYXBVRWZ5SXkxS3VkT0lzdVhjL0dYRW9ZeFpWOFRZ?=
 =?utf-8?B?Z1B6aDFjcXAzeDFqNzZnWHF1alRUb2txVFRVRHlFamc5NytJLzBJdzZjNlFn?=
 =?utf-8?B?dDNIanZKbEdDQmZYL1BPeVVKZlZNRHluLzFYUno0OTBUTVhKQmdLOXB4Mllo?=
 =?utf-8?B?NlJhVGkrcG9ZTzZjMW0rMUZZUWNTdElKa1ZGdzhWNWtTUit2TkZpYXlQSGtn?=
 =?utf-8?B?ek9VRjRGcjBlcGJUY3JIcGNBaTlLWlhCeGtvM25YQ3NWM2RhVitnaC8zTWlW?=
 =?utf-8?B?UTB6ZXNMeDlWckw2ZE40QnRYOFVGMkhTR0hHTTRzc3A2NDlDZkp6RUlhVVp6?=
 =?utf-8?B?UkRtbEUwKytWd3VlMDRQY1JtRERYaXhPK3dUUTcrVmxybGZQdTdEdTAvL1dN?=
 =?utf-8?B?MzJoZDMxRjhrckNueFZTZXNqQVpxcEc0bmVGeDdQb1g0M1RBc2NzS1lFWWlT?=
 =?utf-8?B?L3NLcUErWkFkaTVObFVPQmNOYnJIbklIbnNOMmVLUG4rWnZISGZUOWpQYUNw?=
 =?utf-8?B?T0Z2YnlBSlNHOUc4WGxTT09kYVJ1L3NHTnBvbDk1NkJrbFBJNnFrb0dOZU5G?=
 =?utf-8?B?OC9qemlJMlJrTGw5Z0ZuNkpyT0xBcDR1U2JtZncrSTlpeXdaenBPdHYreDRG?=
 =?utf-8?B?aU1nVGdrRCt1S2ZFK0hPVGcvdTlGTFczSmFOaDVpVENyWC9lRElZTStKZm53?=
 =?utf-8?B?NUJaVjhYRGZoWXFiUGw1UTRMaEhHUFB5TlRBMWZrSWg1bU0xSGZhcitmSUZx?=
 =?utf-8?B?RG1EQTRnbXAzTG5ONzZoQk1yckJaNTJ6RUlSTW1kUDlsTXhRelRjbVIxaFJD?=
 =?utf-8?B?YWdNcFEvajU5bHFoNG90eFpzUWhRZE9KcU5HdmVRZWQzNGNrSTB5d0JJUDFr?=
 =?utf-8?Q?9Iqg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0VqWEx5Ukk3WWQvZThFTjVFQjErQkpvZXNQUGNQUUhITm82dXE4ZVM0T1Zv?=
 =?utf-8?B?OGswcW9DNS9QYmtsSWZheUliK0RLRXN1NjZvb0ZtSWE5cytoRTNYZzB5T2Fp?=
 =?utf-8?B?MGYvZVlGUlZCVDlpdWU2R0VKaW9GNndRdytOK3ZlRmRrK0xvemtHangxa3Z6?=
 =?utf-8?B?TEtoQlE5ODJnOEVKdkZMNDRVaml1L3BiRFoyU01FM3VGSGlpTWxwMUpFVzE5?=
 =?utf-8?B?dlRaME1sUnpBcWR6Qjd1bm9pSnBOOWNUeGhDLzJMVkt4VENxdWxyZDE1NzlS?=
 =?utf-8?B?NFU2MGMwc1I2eVRheElmV0dtdmNjcXZOSkhHSHVOdjloZnNXZnVnSDlWZ29H?=
 =?utf-8?B?OUNtQnFUWHBPMVMzYllKYTlqTWU0eW5jZUpqUlFySUVxM2NiRGIvVEh5cjhQ?=
 =?utf-8?B?WlIyZkU1bWRhbkxQTmVDbnEwdzhDellUWUhoanFhZksvL1NJdjBLMjZzV3li?=
 =?utf-8?B?dVU5RUNGOC8rdXFtbWswaHdpOWpDSE16cEZtcEd4OUdvUVlOOEEyZmRseTJh?=
 =?utf-8?B?cFU5dFR1TW1HMWl4NDl4MjJrL2I3THBkK1B4azdqZWdGV2tKeWtGZDgwc2ZE?=
 =?utf-8?B?dkgvdzgzR3g3RTVTb2puMkVWWkxjTm1hL1A4c2hlVEx4Ukp4ejdOU1BrTU9V?=
 =?utf-8?B?SnE4RDMveWtJUW8yNjcyYXdXU0VjK29kUUptbVNxTlFPRi9YZnhWeDIzQ09E?=
 =?utf-8?B?bnV5TmREajJ2Mk53UGozeXNVM3JGWlRrczBiR3pwblVJUHJvM001bnp5OTZV?=
 =?utf-8?B?bHMxN1R5UWFVcGJIcVFuSTZHNXhPNERIbVg0aXBsK3J3YmYrOFdBZXUvcTNw?=
 =?utf-8?B?N3hNYkx2T2U4VitqSEljOEpSRzBNMkJRUHo4WkY2bmxITUxwYitTQjF1TjJx?=
 =?utf-8?B?UElKczRURTA0L3YvckRiaEpKU3o2YXpvUVQvcExKK01PcHBmOFpkcTVSUmZI?=
 =?utf-8?B?QjRQZm9XcVlQUlFWcDFzcWtuY1FXUnNJQnN4U3hYaGNnT0ZJUDUvR3RweUtT?=
 =?utf-8?B?RGF6UXFHN0dweHFmZ09vYVJ6Wk5Cdk9uRnR1WmRXRDJyT2k0ZDRBbHZHcDFE?=
 =?utf-8?B?OUFLc0NJeEc5UDNNWVFUSXpuNnNVVHBoV1NSSU9HOHpuUjJDVDdZN1Y2OWxC?=
 =?utf-8?B?ZjQzblBtaUpsMExlV25XNjBpaStzN3ZLUkd5TmFwOUU2bkNlaXB1ajJNWjJZ?=
 =?utf-8?B?elNLMHVFdVRXNC9YS0FHa0NwRHhST1huQngzVEZ4UzlzQVpvS3M3VEp6dHNQ?=
 =?utf-8?B?UXI4VWI2bXpFS2x5MlVNT1R5REZVaHd1TGxoR2pXUDkzNXlESzFNa2JVTHRy?=
 =?utf-8?B?aCtLRER6KzN2NG5sVkkrcUQ2QVJIRzhSMlhQMndTQjZBais3M3RhVVN0Rmkz?=
 =?utf-8?B?Z1VqSkdQVVZnckxRUlN5Y2FoUmFrbjZscFNZQW0rMHljYnNlM2E0c3dwUk5i?=
 =?utf-8?B?Y2g3NUZVY2ovYjdFZ2dYMVNyeG5XSk1MWUp0OGNvWjA1aE5KRTdscnpXOFJ6?=
 =?utf-8?B?bG9ES0FuL1doTFRyNytWYXJZUVljSEovaTk2NGZsZTdZU1h5a0Vwdmw3dkN3?=
 =?utf-8?B?RmQ2TTIyb2xrVnZTcWcwS3Vrby9sVG8yRDRPbVVWYUs5S2cxWUVrOVVVOElY?=
 =?utf-8?B?Z3ZNSlphTGYrWnpyVCs4ZUFlYXVlRHdIYTNSem5EM0lIRFFpRGJhM3RRbGh2?=
 =?utf-8?B?RUxDanFmampyZzg0MVhuQmQ3aVljL2NlaU1qd0l3NXdiV241ZW5kVzhLc1lt?=
 =?utf-8?B?Z1pUTVJYWEd4UjJmTjJiUGdNSmNGT1pmVVE5dllqV0grelozdHE2RWJlelJR?=
 =?utf-8?B?S3RkYXNpSWVBOHlYOWQ0VmZETkhwZjM3NHZMTVo1a2J1Si9TSzQwejRQSTJP?=
 =?utf-8?B?bHczTmR3S29DYUllbXFBZ2g2MHZXT0NDaFkvdFMxdkRqQXJsekh1dXJERlFO?=
 =?utf-8?B?S1QzM0I4MWJwczBleStGZ1FUUjNnODhaYUlkU2NkWWpGdWlhT3grRE9QVm1Y?=
 =?utf-8?B?c1JXWnowZHZFRUNzOFpvME5oRmZ0ZFFEQXYxQ1Y1cUZCcWJTa0ViTDFhb29z?=
 =?utf-8?B?SkpBRmZXMU9OZXZpcEhycW1Bb1NRTjhJV3VPeUZUUnN2MWh1eE5ReFFiSk5i?=
 =?utf-8?B?a0R5YTlCK0NKSDBKK0ZBZ2xDbGtDWlNIWlkvQmN2WjBFUGkvT1VUMHowbGJU?=
 =?utf-8?B?NXJBTGtQaGpUVkFmdW4xNUU0dnpyZ2dMSVB1dUcwd0dXd01lWmNEY1Nzd1B2?=
 =?utf-8?B?dGNBbFNnc00wNGFHeUxlaERLQUdSQWxndy91R0NrcTBKQlg3RmZvR1N4NnNU?=
 =?utf-8?B?NGJVSkJUcHNiTWhlZTJ0YVNzQ04yVkFpYTRJRnBSYWo0OE1ZZmtHVFRZM25v?=
 =?utf-8?Q?owRO+4HPeZ36aIzc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c9812-79f4-4cb8-30dc-08de6fa59d0b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:57:03.3734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/AVDd7GEEtYW85eAG/IDrQ2Wli0vHwAdsOkvIIEAQG2kMTWQBwgdd4TzoltYSK5LjyFpq/N3+x/EsMUf99ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9007
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


On 18-02-2026 21:34, Maxime Leroy wrote:
> The rx_err_vq is allocated separately with rte_zmalloc() in
> dpaa2_alloc_rx_tx_queues(), but dpaa2_free_rx_tx_queues() only frees
> its q_storage contents via dpaa2_queue_storage_free() — the struct
> dpaa2_queue itself is never freed, leaking memory on every port close.
>
> Add the missing rte_free() and NULL assignment.
>
> Fixes: 46d02eeaaeb8 ("net/dpaa2: fix queue freeing")
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>   drivers/net/dpaa2/dpaa2_ethdev.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index cef819650b..b75b934b17 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -691,6 +691,8 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
>   		if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
>   			dpaa2_q = priv->rx_err_vq;
>   			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
> +			rte_free(priv->rx_err_vq);
> +			priv->rx_err_vq = NULL;
>   		}
>   
>   		/*free memory for all queues (RX+TX) */
Similar change is also required in error handling path of 
dpaa2_alloc_rx_tx_queues
