Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A166E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 13:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B047402C6;
	Thu, 19 Feb 2026 14:44:49 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013027.outbound.protection.outlook.com
 [52.101.83.27]) by mails.dpdk.org (Postfix) with ESMTP id 8E470402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 14:44:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kti5cOJqAPvwZiIEonHVIgcKb9L2ZALhiCsN2IhXSL1cM7GtiB6EV1bV4zJQxtA6ueGUlw1yIQLKQcpuX7ux21wi0IVVTDD/woY4PJYpfEBkWRkCM1b2v0TTRAK3CJcGRwWCzc2Jlp2QbukzAYMOr8puqeiBhCTVQRZDVI5Wan0tX7ERIbF/9zkVBdfPFs+3hTT9wxDpm36YJq8YAE6olvFJHLlufmqfkUGu1FU5UFhbEwJXhtYUaijqd2VkQ1mptV097QqQ9uJYOwYDA5bzkyOHvpMvbayQV30r1XJnyzirI8dcCSHRRuLiI8v0p+vuzOTwb6sZN2j7ClVAxXv16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/70J0BsSEtE6DIWxgXJhfD03ctUNzpaLrtneIP3YDs=;
 b=KJQTBoXXAp6HdppCeTSB2fZfsJJQXWJxgzlwMYBQG/8aXfA1+vqjOvdT7Xc4A6hZC+eclzLvIrDY+QPcyk0pfSEmoDS0pKPuAlh3I1lFBvYOSjOswCKUUtLoGZXJiUL8gY7Ud0opuG6EVmT72i8k/j6lu5CAVkNNc7Tkbi3R2xrFusjpj6FPKgUX0jIOwA8rHjby/cknBv+B/Mdw2GV5rR6SD2BiTG2zZFa/70vuQNrZs3Te4u5beeHaaP7wblHW1umqLzqyJdKMKMSfdi+K5uuKxkIJuy59yBK8Ii1HNjPz03VnHbeM+1XZdcnlDf4Auhs1JMz2DFyG5G5daPWUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/70J0BsSEtE6DIWxgXJhfD03ctUNzpaLrtneIP3YDs=;
 b=eyt5E5kPxcOSlUtXQBcMyEaXl3KjM2fc3vpiuekDJCakHGB4gKets2IuyU0OgeHACtmHxjLRd1j6Ymqw9OXJn5tgBCXon3k3qEXJtKGFvjvnasVZuwkrVZbbjitzNbwvYUZ9hrKJHxxxOr0L6bZAR0/+A9driZgWzUNdI5FNvOEcuz+OtuBgNAwPQfMicj+hzYGqBf2ZjqJyGtVAYAsJurWkIZTD42VAQ5AtvxH4Ios/1IobUFswrw0qakV4Bk2mscGm9ygX2Us09dAm6L+hMFuoeF0J8JpEeWVpz1StwsRXxLeVclGKGS21etIIYtzk95CwCEwiMmOQ5tDgVdaE+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DU4PR04MB10815.eurprd04.prod.outlook.com
 (2603:10a6:10:585::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 13:44:45 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 13:44:45 +0000
Message-ID: <79643297-9778-4269-8199-552baf399dbd@oss.nxp.com>
Date: Thu, 19 Feb 2026 19:14:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] net/dpaa2: replace data stashing getenv with devargs
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-8-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260218160453.142311-8-maxime@leroys.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|DU4PR04MB10815:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d5aea4-84fd-44ce-a70a-08de6fbd0ad8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTJOZDl4ZjhwWFVUT2dlY1F5czl1K3lFRGhISVZEcTYvY2svK0tKWUkyVmFG?=
 =?utf-8?B?N2VFdHh3bkxOaWkrc25pdkJydmJiV2xObTQ1amZ2bzhZeVlHTlNaRXBGYTZu?=
 =?utf-8?B?WlVlUzNJQlBDSEU1T2gxSTkvOWNyTk5yRHY5QTRkbnpZWXIrSzRDcGtWL3hr?=
 =?utf-8?B?eGMyKzZYSDJjcWJibzFXYWRhMlFuTFRJOXBPbjNGL1pzUk9YK1hneEJ4Ullu?=
 =?utf-8?B?ZmFHOUx4blUxcFNiUk9MRVg5N0V5ZHMrZTdiSXJSSDZaMU9nSU04Qmh0NGRv?=
 =?utf-8?B?NjU0TXBzZWF5WVBES3gxajlUU1VCRlBSQlNFdUhBUlJ5RWszK1hWQzAyRGxO?=
 =?utf-8?B?aE1DcE03b0FRQytnNWlvSXd1U3JVTlhXaTRGb213aUJDNTd2NTNDZ2YycHFC?=
 =?utf-8?B?T3lPWmlTMHBkdU9TMllwOVhKbUt2R2xNSngvZ1p4RGE1S0xZdnc5dE94WUxV?=
 =?utf-8?B?UGhuclR3K2VuTy9qdEFWK0ZCVFpSVXE1NlNyOUs4b1BOalp1MDc3d3ViZFRH?=
 =?utf-8?B?M1dTUi9NaXNsNnR1b2NHUm52VlRVUkJLOTVONXNXWmJRVk1WTzNkQjBqbG5s?=
 =?utf-8?B?alhBT1Nnbk1XQUhRZldFSkZhU2FnMGZIR21vbCtTZ1Y2eHd3Y1VZeXdmR3Z0?=
 =?utf-8?B?Sld3MVBUZGNnb2RGR3lnMHJoUm44Y2gzMlJWMzNQTWgzczZKWnB0MTJST0hq?=
 =?utf-8?B?Zk1SamMyYmJyclNFNVJTcDRyTEh4ekNtTFkyQXRHamFrVUFVdDcxTXJpZCs1?=
 =?utf-8?B?Y0dGUE5vcnVmOEw3dkhhYTRtOWxISDZNUEJ2eXlhclRsUlord2g5d25qNVVU?=
 =?utf-8?B?OXhCMkxRVStnSzBUdzB4S2d5RzhaYkh1d2dUc2dHYlhzb3JsOFY2bmE1bjlC?=
 =?utf-8?B?Z3Jld2NFeS9uZVlOZG1aRi95TTRLdUZQbXF2YW4rRnhrR1RhVDh5MVArUTVn?=
 =?utf-8?B?cTVNN0srR2FZc1Jhcld6TGRrUlE1bU9TeTFtMVJmVm5nVzVESnhCMllSRklR?=
 =?utf-8?B?NzVDeDc2SEFqUmdFYjdSY2ZtMDVOUVB2aGE2Zkh0akx2ekhRQWtIM1BLWUlo?=
 =?utf-8?B?MGt5dXRNM0dma2FxdEc2OW1ldlFaQmM4TTR4aHFYYVF4cmpPMmdKRjNjQWZx?=
 =?utf-8?B?NS9uVTZ5NDB5TjcvZUhQOTNRUHF3Z1M4VldXL21JK3BCZXFOd2VoV2E2QVcz?=
 =?utf-8?B?MFY2SzVSdWQ1SGpHT2ZuV1RIS1U0ejF0b0FrS1RaUm95WjBHVHZ1cU9zTFRJ?=
 =?utf-8?B?MkxETWFJelF4cmJBYkl1RXFiQ0JwaHpKdEs3eTJ5RExTajZRdVJPcytTem5Z?=
 =?utf-8?B?c1ZTNyt4MGxZYTM1bGNYU1dON1J4VEZDQlNuMkZtNDlyRzJVd1ZtUnk4clJL?=
 =?utf-8?B?dVJqTStLdCtGSkZEZzYxbjJVaWFQaXloTzUvOUVhQTVDaHlDSWt3RitkNVBp?=
 =?utf-8?B?aWVySFIrR3hxcElCaUpjWlBiQ1NMT2liUmNIZjZCaHprWlQyWVRJb0xPaHpC?=
 =?utf-8?B?Z3FQa0p0WXgyUWZVd1RIMFhpWWtzWUdyY2dWY3NqdHl5K1pNODRXZmdkYTZ3?=
 =?utf-8?B?ZURXOUhIem9Db0VMZCtUUkh6VXNQTnVWaHdHYXNZTkF4UGJLTGJxdllsRzlE?=
 =?utf-8?B?N2VlemN0OG82SFZZTFVGblNWNVh0Z2w2eG1paDJxOU12UDh5TW9XVCttaTU4?=
 =?utf-8?B?bmRqY0VGZExpdHkvdHhnaVpvTW1qZ3NWYVJmR2REVkV6b0lVeXRCK0Q1TGx4?=
 =?utf-8?B?cC9VSDNLNHRRZXVJTzF1UGRqUGRueFh5NHd6aUk4WTZYa1AzMGlVQnZSSkRw?=
 =?utf-8?B?cko2SG5vV2JnSXdYcjh1Vjd5OGhuOHpFOGwvNWxGVXRrQk5zcFBnNjRaa3FV?=
 =?utf-8?B?VERDdHQyd3liV2g5QlQ3S0VBR0dNd2pCUUpydlVjdzdRZ2tNeVA0M2hTamM2?=
 =?utf-8?B?NHZsdXJzQWx4REpxcENyNU1nWmkzK2pid2xoODc4ZDJZbDUxSXVNdmlSc1pi?=
 =?utf-8?B?SElHM1ZpMG1wTDRmbkxteVFqNk5XSjJNdlk4R25nOEtVdFlVT3BBRkN1QlBY?=
 =?utf-8?B?VHF4RElreVducFo3MUhQQWFXV0RFTkltSlhKODRhWmg1ZmtrYTVtVkdRY04w?=
 =?utf-8?Q?uRHQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVV4eEdrOTIzTjltbUVSNDhQRlM2ejVFRXp3bHR4bXEvVllnbjFGQTFHb0ky?=
 =?utf-8?B?TDZuSmI3V0ZIY2RIclZ5d2VGdFJlT1p1akYzUWZPUlBGeUZoMGRJTTMrSmZ0?=
 =?utf-8?B?SU1nNWhxNVIwMTNacGxRZlQrZ2oxcmlrMDBuLzhsUDB4MEZpWnA1ZE9kM0tk?=
 =?utf-8?B?MFBTZlU3eEJWbUV1VEdwalZSM2gxWS9VSTNxS2tvNktsaFRDdWprc3JsaXN6?=
 =?utf-8?B?Z0dzbXYxVWNwN25PK2paalRRczlscXhvbmJzQVhIVFNvUlRWcC9OSnFUQU52?=
 =?utf-8?B?L3ZBeGRleHRyRSthUHp0ckp3bEJrcUtqdENVVndETXYrdUtEQTduN0RSTUpH?=
 =?utf-8?B?ak1PN3dZdk42VnVuM1hSYkdPUnNrWGRhdStRd0pqNHZZdTFjUE1WbnlHdDA4?=
 =?utf-8?B?ZFk5dTNpOVBUNy9BbVc4bkROS2ZMVFBGbUU5SU85M09zWHc0K1RlRkJSMDl1?=
 =?utf-8?B?MCtDQjlOeHpNbllXOG1jM1VKd0U1eHYzTms4ZUpoMkdzVGFFMUxaUkxpMjdt?=
 =?utf-8?B?UEFrY0JFR05zaVFaY2hVcDlCeStLTjI5K0Q3YzVlRGlPaHRsK2ZNbGFCQVp4?=
 =?utf-8?B?OXE4bGtYcENENlNsQVhMdXNkSFA3WjJ4bzYvZ2ZIWk52K1QxK3kzeFBFaXVN?=
 =?utf-8?B?ai9DRXBFaUF4dVRyYnkwZnF6NFNGandjQm5pb3pLYXlTVXhmQ2FVQ2J6elQr?=
 =?utf-8?B?SDZoUGVGaEszNCtZNzZiL2xrU0w1N1k0Syt0L1hiOWw3dEVNZkdBT1JmUGNm?=
 =?utf-8?B?RzlhMXVtL1lsbVZ2UEpQMEZLQUFRR2lvNGszckhMVUxzd0Y1QzRNdVVHencw?=
 =?utf-8?B?dkZXK2xkUlBYcmZ6K1FyMEFLbDhmU0tkS1UxYzE1RXpBYVVsa3pqTkVuK3RX?=
 =?utf-8?B?aHg1NGlNejljcExVRnF4ZFc5WlZicDdhZm1DcThERmxsWGJvdW9pUmhkMFl4?=
 =?utf-8?B?V3lUUmo4YTRsL3JJQU1ua1BTek8xZTFuQ295QU5YQUI5S1Z6SnlLVjR1clNJ?=
 =?utf-8?B?TWNOWGZFMjZwcjlVMGJTQnZVa0FXRHpKMENEN1lBVHNNRjYxV2tjYWpQbVJC?=
 =?utf-8?B?WVdiTjhGeVhSL1RLbTNRQlBkZ3ZzUVQ0cFhmR2YvUDk5UitBT2dRN0FteVB1?=
 =?utf-8?B?cFBZbi85bFoyTXB6NXA4dGdzTWp4cWE1NWFHeHUvNFJ2TGJ5TmZaRzZ1REUy?=
 =?utf-8?B?d0RXMXY0SEd1cWRGK3FzSWJwa2JzVCtnaXJHNUhSdTNKT1cvNmd2TWpzVS9W?=
 =?utf-8?B?bTYwVXhWUk9kb0c3R0JicWlDU1NFUE9PUVc2Vll2UGpBeGU1UTArMTBndnFR?=
 =?utf-8?B?NE9qbmxtaEtwRXloWUNrQWVKeDJYeXpHTVNrWnBzVG90eEVmaWZnWjlsdTFI?=
 =?utf-8?B?RVBTQ3VtYXVJcXg1dExhOWswNGthdkFVZnUrTnRZYk84dEJqR0RMNERTM3FT?=
 =?utf-8?B?c2VpeUFFNmhPYUZqNDRXV3Q0ejR1ci9xV3h4dmV2eUxRWlVCVXBzRnFwd3FW?=
 =?utf-8?B?ZTlnVkJCVXFuTUxtMmNBVHNzRkUrb094ODcwSGp2Slpla3RtV0xFWDlIZGdp?=
 =?utf-8?B?UUx1VjhheVBsaVNTMEdiejdQa2VNZTczVjNFanJWVDVyZVhsRnh4dzFpcXRT?=
 =?utf-8?B?dzd4ektodXd4ZFAyTlVKLzAyRVo5NlJlUjcwTldBNlpwWi9DYU85ZG1JdUhP?=
 =?utf-8?B?QmxrdmxWczBHclVTdVNJbDcrRG1SVE9MbHlFK3R4UVo0VEgwZkFTcE1HZUw5?=
 =?utf-8?B?ZmJBejRoRVM2SklOSW9wUGFHK3J6QUM3cStvai85QW8xMFlmcVBVaUFJVVcx?=
 =?utf-8?B?MW5yYnBGajZBYkZhcE1SRGxRNmNIVEFUelhNMGFXczY4WGt1TVI3aEtmbzRT?=
 =?utf-8?B?aUV0MVJGVE9PNENJWFN1Z0ZaeStXckwwUFQ4R09HY0tiSDd4Z0RqNEF4R3lX?=
 =?utf-8?B?aVRuZ3lsaFJjL1lEK3JLMWF6eEpYK1ZFdXF3VHQ0bUhmK0VkZk45MFFjeWl3?=
 =?utf-8?B?aiszVUlrOFozakZrWlVkNXRBdUF1UXFGckVLdFFBcHFMVDF2cU5VbGZybUpS?=
 =?utf-8?B?bTE2UXRsKzZiSitUTXREVWNsQXUzc0NTWm1aZnl1OXUzVHQyVnJXbSswVHp5?=
 =?utf-8?B?c093ZU83Y2hvQmZ0QnM5M2tSSm9XYW9aVXl1Nkd3YSttbXF5ek5yRHhkK3ZF?=
 =?utf-8?B?eEY3MFNSYmVhck5Ibk80SXF5QjZFSSt2WUlMUUR3QVJHcWdrTHFZZ3d0ZVNL?=
 =?utf-8?B?ZUYyMWNCdVgwMVJwblYrSng5dFFzOTNXcjZBNmU4bTlQaHRRWmYxMHJQUWlL?=
 =?utf-8?B?eEp3TVF1dlJRdFpyU1hTejZFNi9HNmdQZCtkYThJOUYrU3BsRmdUanByUXRU?=
 =?utf-8?Q?GzJSuyUOqaSMNgLk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d5aea4-84fd-44ce-a70a-08de6fbd0ad8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:44:45.7775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXpDbbIvkS1noUHnrCdhghDBH2/yWCz1ecyTKfsYgsoKSJZoOZoqfILskD4pulChq2NNlFlNdUdW6+sD5rkV8w==
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


On 18-02-2026 21:34, Maxime Leroy wrote:
> Replace the getenv("DPAA2_DATA_STASHING_OFF") call with a proper
> devargs option "drv_no_data_stashing", aligned with the existing
> DPDK devargs pattern used by drv_loopback, drv_no_prefetch, etc.
>
>    fslmc:dpni.1,drv_no_data_stashing=1
>
> Fixes: c794f2cab6cc ("net/dpaa2: support FLC stashing")
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>   drivers/net/dpaa2/dpaa2_ethdev.c | 11 +++++++++--
>   drivers/net/dpaa2/dpaa2_ethdev.h |  3 +++
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index 578ad98b8e..0a68365de2 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -35,6 +35,7 @@
>   #define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
>   #define DRIVER_ERROR_QUEUE  "drv_err_queue"
>   #define DRIVER_NO_TAILDROP  "drv_no_taildrop"
> +#define DRIVER_NO_DATA_STASHING "drv_no_data_stashing"
>   #define CHECK_INTERVAL         100  /* 100ms */
>   #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
>   
> @@ -961,7 +962,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>   		options |= DPNI_QUEUE_OPT_FLC;
>   		cfg.flc.stash_control = true;
>   		dpaa2_flc_stashing_clear_all(&cfg.flc.value);
> -		if (getenv("DPAA2_DATA_STASHING_OFF")) {
> +		if (priv->flags & DPAA2_DATA_STASHING_OFF) {

I will not like to remove it completely.  Can we OR it priv->flags ?

devargs are good. In most cases DPDK based application has specific set 
of devargs hard coded. They need to re-build if they want different boot 
args.

This is one of the env, which is used by customer to dynamically tune 
the system for performance without the need to re-build their app every 
time.


>   			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
>   				&cfg.flc.value);
>   			dpaa2_q->data_stashing_off = 1;
> @@ -2938,6 +2939,11 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
>   		DPAA2_PMD_INFO("Rx taildrop disabled");
>   	}
>   
> +	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_DATA_STASHING)) {
> +		priv->flags |= DPAA2_DATA_STASHING_OFF;
> +		DPAA2_PMD_INFO("Data stashing disabled");
> +	}
> +
>   	/* For secondary processes, the primary has done all the work */
>   	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
>   		/* In case of secondary, only burst and ops API need to be
> @@ -3425,5 +3431,6 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
>   		DRIVER_TX_CONF "=<int>"
>   		DRIVER_RX_PARSE_ERR_DROP "=<int>"
>   		DRIVER_ERROR_QUEUE "=<int>"
> -		DRIVER_NO_TAILDROP "=<int>");
> +		DRIVER_NO_TAILDROP "=<int>"
> +		DRIVER_NO_DATA_STASHING "=<int>");
>   RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_pmd, NOTICE);
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
> index 86b3022ddb..4da47a543a 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.h
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.h
> @@ -97,6 +97,9 @@
>    */
>   #define DPAA2_TX_DYNAMIC_CONF_ENABLE	RTE_BIT32(9)
>   
> +/* Disable data stashing (prefetch of packet data into CPU cache) */
> +#define DPAA2_DATA_STASHING_OFF		RTE_BIT32(10)
> +
>   #define DPAAX_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
>   
>   /* DPDMUX index for DPMAC */
