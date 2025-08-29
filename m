Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EECC8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 05:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF7A40276;
	Fri, 29 Aug 2025 07:08:17 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
 by mails.dpdk.org (Postfix) with ESMTP id F069140263
 for <dev@dpdk.org>; Fri, 29 Aug 2025 07:08:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVpqf70YUcMaXKP42qKySs4Iv5ccxn5WyXqLYBOEJzswhG2Lna4G3ghzl4UYySdBq3QOcfpKTBGwQuxcK8eZysoazL4cbQ/36s8ZPfroq0+OSBsD4CkQ3vT8LdsGCV2MKaf/jwiSrL9oT1ybfPJTszGsGxKazOblWiShoWzRiBXRJMuumrh8ZLtowB7lu5LulAnxQ4Z6cgPQ/hdmDOoMt7rIdWag9DQ30ZugeRq65gwNY+hafLUbPSu86dN69A1ty5I+zVi1O8pH+s+EffIVU2OIUiQJvj313UlArcLPLyUu7apw6NF1H3A53JO3+qZkaBXYzyJxpI/MMAIJUaf7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw0aDn8X+8Nl1rITUODJg/3lC7xB8rbNV4Lvd3CBJe0=;
 b=uO//hf9xrnLjEcoQGcjlrF91rNg0g0lRSYy8mDNnAfxKEOMzcEuBdlzgh0rSuBfz+jK9tIKZ7XxIY9F6MGBpt/cEuhoz8H3t/q1d4GAmHMi3VSdNkHUkZj+k/s9hJeIakWQ2iKhER9J8wH6+evaSPMW9xJVYzbcjVjCX2qfiOF4cQytKLP0WK4Wgu1CaLHxIae0U07CoXx7oAhTZCA7Zi5O+o03/3IFA+jHbEA8kalHjFXuwHbMfta1SE4X5elCro53TBOkGGLhD3xgCaJy2A1D70OqLZ4qokY0i9SbdHsPL1bl1wNHMIdSOICgK3OvIw3L8THFLrRwxjAf6LXk7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw0aDn8X+8Nl1rITUODJg/3lC7xB8rbNV4Lvd3CBJe0=;
 b=qVxZUZ21tX6nywa5qx1TWbUztNR3+HXOh11sBJVclKzBpFnoiHlpU/DqNJaJ+IwUYo4tcfbHYtvZTUkz3EQP4UFSl26OCMAyJAsEw/J/wA1oGWl8FHN/F1Oq92ddFKaRZrWfbhjN+Pym7uK/GaBsJFMQ04wGKZYh4xsarvkxgqXMYqrcA8OVyIPqAv9QZQuMGi9L6P2K3JVV9zzDoEArda2LVTJFLev1+D4hDpXE32tlJUYi7Dk5Dh1mnbizFGkGcbxO07/KYohTx6JB7Mx+eNRK9SPdONm8Zk6UpQBsjMAzR1UT7n6zG/0s6jDO5Yr53VOfJqXHIlZBm9YSgaYl9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7394.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.9; Fri, 29 Aug
 2025 05:08:12 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:08:12 +0000
Message-ID: <edc47274-feee-4177-b973-704ce84d11e2@oss.nxp.com>
Date: Fri, 29 Aug 2025 10:38:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] doc: bbdev clarifications
To: Nicolas Chautru <nicolas.chautru@intel.com>, dev@dpdk.org,
 maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com
References: <20250826194324.95284-1-nicolas.chautru@intel.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250826194324.95284-1-nicolas.chautru@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: f92b7bdb-3ffd-4aba-9baf-08dde6ba0d86
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmtzK0RnZUFLNnZ5TEhDM3pkTG9QUFlVNStCaVNUMlc1UlJZRmwySXhQemtv?=
 =?utf-8?B?dUhlenNDVVFEMHZoU1doY0lhRlUvMXFKWUtNRUJOV3lKTW5GN2hHbGszK3RQ?=
 =?utf-8?B?enNWMEhoZ3NOUXA1OGIxaFc3aFdYNld5M2xlaGJXeE03VlNOVUNmb3N4M1kr?=
 =?utf-8?B?djRlYWkwNkhnUXlWek5Cb1dNV2hVWWZmSkU5TFQxUk9ZeUZ6K1VCTEtlTjJC?=
 =?utf-8?B?cFp6aFFIeEpHMDVXdlp4V045aWptLzBtSkhPSTdCcUxxdXVWbHF3UkJLa29F?=
 =?utf-8?B?Z2Z0OVE3NEZxclJFWGN6MjVOU1pzMG1JYzFsNnJFWkg0bzQ1TFJUQTk3eFlQ?=
 =?utf-8?B?WU5VaWRML0ZIVFdtWHc5b3dRdHJva01DaE1OSkNpRFAwdlJvam81WVFScld4?=
 =?utf-8?B?bmwyeEZSV2NLZ0pvV2hlRjhDbTRweEJ5ZVY1MFNrcEd1UzVOdVpmWUhsQmpU?=
 =?utf-8?B?RnFBWE1ITXdxTEpaUEw5ZmJHdHNKWDNJeFloVnVXcDdzb0EyL1ptMnBQTzlY?=
 =?utf-8?B?RHpkZjRrbnFWMEZGMmE4Z1dqVlRSZm9zQ3pMdkJBNVNoRlJXOTBRVWxBb1FU?=
 =?utf-8?B?Vm9GcTg2T200cjhZdkdjTGx1MXkrRm04V1hvTDNiRm5rUTgwMmZ4U0tMZnFr?=
 =?utf-8?B?T0p2M05jbVdDZU83OE1iREtoZnpVZ2J0WkxpVmp1ZWdFMWs5bnpRUCtTRmRO?=
 =?utf-8?B?V0RjT0JvY05EMXI2UHFvOW11UUs1NmFRMmx6MEpVT3R2U3pZOWJGRXE5VTVD?=
 =?utf-8?B?UnRsMWV2N3VMN2w4L1dUTElmZkFhdHRUcVpOZlJZSUZNRm5UcStJMnRpbjg2?=
 =?utf-8?B?OThkY0IzRzl3SmRCVG16TG5yTUhwcEJoZ3hUVHlxRk1yaFhSeFpVNnFsTFpa?=
 =?utf-8?B?NUFXZVVTcldack9QTVZPV0lNbnFKaG0yMlo0Qy9uR3ptZDQ5R1prUkVIL0xL?=
 =?utf-8?B?SjBnOENLeDN1UjlkMnk1RnlPSGpKMGRuZlhMR2hmZ20vMG8vSDBVaGJEcFBn?=
 =?utf-8?B?ekttTWplbDdXSG0rSG0xNVVrd1oyS2xmdTZYQ25ScGI4bzcwdTNpUFBIbS9H?=
 =?utf-8?B?RUR1aGhmV1FXdE9XcDZCVmI2V2NoaEJXblFoKzNWUzAyTGh0RHE1bW13bHZJ?=
 =?utf-8?B?TlNVUjVCbUpxWTZYZzI1OFovTm1Xakp2Uy9vWnBrd25CcjRzVWlpalNPNXB6?=
 =?utf-8?B?bjhheFNOKzEzenh5YkxvOU1qR2NVQ1crT2V1YWlkK2pWQmZpOG5ZOVpONHox?=
 =?utf-8?B?eVZKYy9ZSlMyYnp4OTdKMTJTa3Z2Q3NHQXV6NDZ2NUoxMXJjQ0xsbk9xMmhz?=
 =?utf-8?B?TVBKbzUwa2FPRklOZmhaVlAwSXlWWXdndWJoMzZsRmxJaU1hOXZJSTBKZEpm?=
 =?utf-8?B?d3lLSWJYTWZaOHFjY3BFZk16SjhNMlM3WUlkaFpVdUJQVGdEdzk0cDIyRnBp?=
 =?utf-8?B?bzNHcVFEakIwSHRpWmE3dXhVSkVkeGhDbzg5NGl6MFRKOTN2R21RbG5INC93?=
 =?utf-8?B?cTlOUUNkNE5JR0hPYytNTmRnSXdDWHlYQUZMK1V1MmNxM2ZsTWdudUQyNEth?=
 =?utf-8?B?Y3B5Y0lXc0NHcHEzOVN0aUtCV1EyeEx2SXFpQ1J6ZDVCdStoTW1FVnpoUnpJ?=
 =?utf-8?B?eDNqd1ViK2p3QkNYTW0yTVdab3AwMWZUb0JveVpkNGJIL2xuRlRrQ0xlSENQ?=
 =?utf-8?B?ZHdJVlhoYlJUK213Q3kzTzlCQ1Y3eTBPenhuTVNvN1NvQzN5YzNZOWdrV0kx?=
 =?utf-8?B?eFlpY1pHdUlwa0lyVjFSY1hkRk0raWR1TkxYTFBoZDBJMHBBQlhOVVhhejZW?=
 =?utf-8?B?RFMxY3RtOW9WbzAvNDRyMTEzSy9qa2RNc2RMM3pYYjB5anVlOWNCbzZ0cmE1?=
 =?utf-8?B?eVJ2MVVFcDJqa0R5K2NHV3NVVS81cFowTEIwRmdDdXgxeEtNSXFrS3dsTnVh?=
 =?utf-8?Q?9bEaEdhtnTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUM0UFdvRTVqVXZTSUdqQjA0clVSVDF5SVU2WjhqVlVRaVgxdk5hUnZOcDBs?=
 =?utf-8?B?VlJ1R2Rjdll2YzBIbEg3a2lOeDZGOGFuSGR2eUgxSG92UVlqYzV2NmFvUmtX?=
 =?utf-8?B?SUxWNytzcnVnSVZvOGt0ckZ4UENvOHR4Vmd0UVBnR25DdWhpWGxwVjFsL2hP?=
 =?utf-8?B?M2s4a0RTMlpBNDVHTkc3eGYwVnA2QVEzazVvWEtyTHZIS05ndlg4bHVqZTJR?=
 =?utf-8?B?Q2Y4NVVlNU1DS1dIZjZEUnVjbmVBNVZBaHRyRlRhYWdqdHEzeGFJVi9DL0tV?=
 =?utf-8?B?eEw3NVRNSmJBazZOdXlNVWY1eDA0VnNXRmRjbXZmbm5qV3J1OWZBZzM4bVZD?=
 =?utf-8?B?RVk5VXZCT2p2aVVDd3J0TXNlVXlkaUhBbDl4UmZLdzN1MUd1VzZyUlpDbTlX?=
 =?utf-8?B?c00ybkZrRlA3NXo4Z3FoQjhVRzgxNzNPVTdCUmo5TXBmNk1qOXE4M2cwWWIz?=
 =?utf-8?B?YlVSYk96blFMM1ZiTWViMmRyUGJZSHhhOHBXWUNZTlpFWldEZ0lMM1paWDdZ?=
 =?utf-8?B?amZmOHptcHE1WllKbFBaTkcvRlpyVnp3a0RWbEZJZkpHbjZXNUY0bjAzYklU?=
 =?utf-8?B?K2lLenBMYkNsdFQ3NXA3YzdBbjdMZHlRVjYvWW1nZFJmQXA4SWpnYzEyQVJC?=
 =?utf-8?B?K2FyL2daaVI5RlRaY3RBNEkwUnhjUGJFZ05aMzJWc1pGaWo4VWJhZ0VJd2pz?=
 =?utf-8?B?aGdKR3RjR0JvRlJmSWpCTFNyczlwMXdyRmxwVmFJUVNpMmVzSEU4YkorMW1H?=
 =?utf-8?B?dGxUaldIUXY1ZkpJMHZPbFZhNGNmSmhQWS9CTHhnUUswc3U4OUFSSnpGZEpo?=
 =?utf-8?B?YnVUVTB4dk5idWhJaXB2amxvQ2lqckx0UUtmakEzUnptY2I5MDJZakplcXY1?=
 =?utf-8?B?YzY4Z0xJekU3REUzbkMxNDl0NzNrdlRyaGZHc1dtV1Z1bm9OdGV0Q3YzMjZj?=
 =?utf-8?B?QkFQWEE4SzNsYjVRc00wU3orYmRCRXVZcEhjMFc2bG5oVlZyc2JscTNnV2lC?=
 =?utf-8?B?d01zbytILzczN09XRUZyWDkrU0JIck51bjArc2xNS3lpWTEyRE1MUndZMXlk?=
 =?utf-8?B?UDBEU0MvVnhUMEhRWVB2N1JNaXlReUZDdVJGU1JMdHVSbWV4SzZ3dmo0cFhv?=
 =?utf-8?B?cmhqdjdNRlZndWF5bVczd3FPam9IOFJLSGpwbTlwNURpVW1VUEhud0k5Z3hL?=
 =?utf-8?B?V2JkbXRLbWxBZHNxRGI5Umx5WGpXRFg1dTAybkR2TTNNdHpBQTk1NW1aWVlD?=
 =?utf-8?B?NmZ2cTU4RVhvR0tGVExPRGk3MktlZ2YvWU03c2Nra0U2REU1RExzTVNSblhT?=
 =?utf-8?B?RC9UVkVpVjc0Smw5eEFKbDV4Q1FDNDlzWFVGRlI0bkJtdTFhK2swRitCekdx?=
 =?utf-8?B?QlpFMkp2VEdDQTU3RHBZVlZqVkwxMlkwcUlTMCtWVmlUYU5mNVFCejRGTzk5?=
 =?utf-8?B?RnFxYnlCZzFXWmlzcmJIV1BYcHBONDdoMm9ON0gzNTA3OENTRW91Mm51d3RR?=
 =?utf-8?B?a2lJQUR4RWwwVUVPT0JLeHJIVGMzWStVYlVMeW5zclJGbVNBOEtHMnU3ek16?=
 =?utf-8?B?N0FLbndvNXl0bzArZXpiNUxobzRnT240SUs5dzVpVTU1SVA4S2FSNW8vTGQv?=
 =?utf-8?B?Vmc0cFlBL1czbW8yZnUzNEtndWxRTEZiSXl4TlNhUGJvMTNEVHB3cDNlVFJT?=
 =?utf-8?B?ZlpnL3N3N1YxVnZFSTNzdzZwWFd4R29Hczh2Y2h6cjVQdjVIRlk5VUJncnVz?=
 =?utf-8?B?cEFydVMrUjRNcG40NUlkM3dVOWZLQ0tpM2N5eTVKeVpQOGNCNkNBc0ZPQU9r?=
 =?utf-8?B?cWV0bWNMSHRWcThIelhNZkVWaGZ2bDFxVU5DclZ6cURROEc5SXhHYmdIRk9P?=
 =?utf-8?B?R3N0OHFkU0hYam52NlVXMENwenhmSnRibzIwd25laEp0bDNob2dacDVZQkdz?=
 =?utf-8?B?UnE2Nk9Nd1JWS2ZlMEZjdWlONU84dUNaeGFJUWtKSnZBYnVZL2Ztck9CMlZh?=
 =?utf-8?B?Z1J5eE96QSt2Mml5b3ZyNFhZWVJ3MUNSaGpncGphM3NWV3hWbFdsbUt6QUQ5?=
 =?utf-8?B?TW5jS1lmd3JMTkZadGRyZ0RkVXk0cHpQNWNscUNFS29vVmN6dkdnZGc1aGE0?=
 =?utf-8?B?VklCOUh5MlI0a05UU1JPQmJmV01wOXZRSUdVQ0VCZGpNeVZwcmxoSXN1cWNI?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92b7bdb-3ffd-4aba-9baf-08dde6ba0d86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:08:12.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWQ2cnh1xJfViYCSLjP2QABhdi0L2g8F43aE/8Nk9ud8ajWIyWlKDPYovS5ojwOLpptVBbeudYB7FtZ7sv3Hzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7394
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

Series-

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

On 27-08-2025 01:13, Nicolas Chautru wrote:
> Hi,
> Some minor clarifications to document based on
> feedback from users.
> Thanks
> Nic
>
> Nicolas Chautru (2):
>    doc: clarify CB vs TB level device support
>    doc: clarify the window index usage in bbdev
>
>   doc/guides/bbdevs/acc100.rst        | 1 +
>   doc/guides/bbdevs/fpga_5gnr_fec.rst | 1 +
>   doc/guides/bbdevs/fpga_lte_fec.rst  | 1 +
>   doc/guides/bbdevs/vrb1.rst          | 1 +
>   doc/guides/bbdevs/vrb2.rst          | 2 ++
>   doc/guides/prog_guide/bbdev.rst     | 7 +++++--
>   6 files changed, 11 insertions(+), 2 deletions(-)
>
