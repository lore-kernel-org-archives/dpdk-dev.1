Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC09BC02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 07:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B303240697;
	Thu,  6 Feb 2025 08:55:32 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
 by mails.dpdk.org (Postfix) with ESMTP id 54F844066D
 for <dev@dpdk.org>; Thu,  6 Feb 2025 08:55:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1fVWngH1WGmvzRSPSIm8DdyMQmbvildeWPqHAb4MH12dhKZpphdP/Bt9cv2IQHYP/Z47G8YRH8w/nUqr8hRMNEV6pGwTZEOQVrWJgwUY6MiZ7iIWFD17ZVp9FygRp6MP364E9ZyK+2E03i/Rg7Ozw7tVgRMSUmuAT6QMJ07bMH+ZOnvHd/t56ihhpkAYJWwkAI4SryKHp9qFHU9zrN2mdUtKwLjAlYjMqe2ZYGbEc96QgT2bqC8cIMeMK4XQzCZbmyL9GzPNnC/ZgMYtb6RxdnZeZQaQpA4o3UJG8IIGZW4EJjGMQWNQ3To+5CNXNth2uPoyzod6zPoYV14FowbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAFtrOosEH3RNUoND+j2fnfDpHJltwwBccjEzArmF4U=;
 b=YcfYWAQdfJ69fBjKTxzF9RxQVcIgvm8Sxtk7vMiG/DlmUQpgHSebXD4gR7lMuExf0gQNbSyLL3WFh3pXj09jMERegsdJ3f5wEKgRlPjQwnGuIVkGHMwXEB9vL3ENFwnTSitzNJ1dPQWuV7041/9ERwBfgwaqm4emwewbvxT/Yd765PhVuLM5djm/k+IHnoHixETceqppM1T/BFfvAh99E8WO6LK3AYwVKUddW6QELDKJ2bipYtyxXTGeqk+q0cMnBFbKfs93cZmhi2FZgCducfGWhyN4UC2D6iiUS4SwoKjzq/0yRStHe56bcsHe0yIUCtELxANt2dWwuU6WA51Hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAFtrOosEH3RNUoND+j2fnfDpHJltwwBccjEzArmF4U=;
 b=XFVxDUmC5L0MqJGUTd4IoqTZWpNgjKsSNND3y41oDgHfaej8AZEY0lRIduZTto5doBFkQQJhCpmdMFDwiIgl1w2Mp9AtVFv84DsG0nQ+YqfkOltNdd9167YKapfJCDTgH7iH367xlqhRYxWRDc2a+SMpUYRBDxWBNL8oqwwOndagFg9kwxLoeKbWQGMgjZl5z5IF81O+Hhh72ARbWYsktU/dXMhBt5Ql/0ftY9N/lfBnbAfOD95I+v8X7E4G68OUHHbe/dC7F6rNrMM25QuflW57w7hkKLLCIs/+/aAp9rGT4vfc/Huv2/L/Au5fyn9D1cXO1NKf5+/rsyowRQbOPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PAWPR04MB9815.eurprd04.prod.outlook.com (2603:10a6:102:381::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 07:55:29 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 07:55:29 +0000
Message-ID: <75e4f0d3-c038-682c-f84b-db583e224e89@oss.nxp.com>
Date: Thu, 6 Feb 2025 13:25:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/4] lib: fix comparison between devices
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: stephen@networkplumber.org, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jan Blunck <jblunck@infradead.org>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-3-shperetz@nvidia.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250206000838.23428-3-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d16a9a-e8b8-499c-92e3-08dd46839f7e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVIxNWpvZUJLcGZ5TTVIRk5JaFN6VzMzNm9HZ3phdlMxNkMvWXFmZytRYTZU?=
 =?utf-8?B?K3lsZEFDZFlBb1pRUjNWL1drejMrV2F4aCt5aFlFeFVqTU8ySTQ4eWRwNEpk?=
 =?utf-8?B?SmczSFord1hURlg1RUNuUVplY3RYZkNERlQ1TkVoN1IybUdPdUNuclZiSnBn?=
 =?utf-8?B?NHVMb0xNdmEwRmc1TjN3VUtyYy9yMG9YZXVOVFVxZVpiekhwRFRlbmJzYXZN?=
 =?utf-8?B?aFR3WkdCWWZjZU9UZk8yMFRiRnhOSk04SlVmN3k4K1FSaXpQVlBOayt6UkF4?=
 =?utf-8?B?bVZtODFyMlRsYmdLTEZ2QWYvK3FPVEovVzRLcVd4UVE5cVJUWGM2RHRYZzZF?=
 =?utf-8?B?aGRub2RFcUNXWVpyanB0YlBWd0tNWEg4RXRzMUdMVitiMU5jNExBWUE4M1Nq?=
 =?utf-8?B?YW9ueUg1QlVOWk5CNGNFM0YyM1BoQm9tUnlEUmVlajRGMHJuNDZETU83NytV?=
 =?utf-8?B?RTlFOWErckpyTUNQOWkwYzJrRU42K3lBNW94MnVvNXhCZEhRRmlTeitzWVBV?=
 =?utf-8?B?cCtGTFpnVldJT0Q4ak5mck1lKzBOeEJFZGdaSDZJbXpjTEZxK05Ub1FmUEli?=
 =?utf-8?B?c0FFODI1NzZURnprQ1JFSFF6ZzhXM3lMa2ZNTWVkVWJld2tHbzlLSFZKMklj?=
 =?utf-8?B?WDdDaDBlODdzZG0xdTJIZXppdmVMN0lxVUhkQjArcHZpOFBPUm9RbGNVcWZz?=
 =?utf-8?B?Q0s4U1FBWWdvc1JqYkNtOWg4S0pJcFNmalBQOGN2TWRuUEcydElUR2xhNWk2?=
 =?utf-8?B?ekV4M1pUUHRpZFovV3RhTVNMTXNXL1JNdHg0b1lHWmhpUzJYem83dFVlSTln?=
 =?utf-8?B?TjVPYmZ5RElnSnJISVMveFZoeWJlTTRTSk5lUUE0SnNKZDdXajJxa1NwSXg3?=
 =?utf-8?B?b3ZKc083SkdYK1N0K1lROVRTaGxaU3U1TVhFN2daM3Qxd1BSdVhiRk5jdERw?=
 =?utf-8?B?RkZGdDllaUdSTDBsZVRlRnN5bDhyR1dUMjZpTDZWYURSS281TmNnRUs3bEx2?=
 =?utf-8?B?VHJSaTJ4S2svMTBrZUxFdEdaSmRtTWxnZ2c5RXJ4SnFkQzYyNk1DSDJzcy9P?=
 =?utf-8?B?MkJCR2RKSE14MFdTcGNuV0lYWGtHdFJaMkhTanMvYkdpQkd1T0pHQVRlZ251?=
 =?utf-8?B?ZW5TQzZGaFoyL1JxV1lwTm5PZlFuRVhYUFhUL0JvaCtkdU5VcUxyS3o1akdv?=
 =?utf-8?B?a3FsQ1NXbGxVNURqNFdTZGc3NTZNbjIrL1R5SEYrUlBsMVRxRTYvV0xEOU12?=
 =?utf-8?B?am50ZXpXaUo0TWVUSi9ScDBWSURhemNlUFN2ZGhoWTBZU05hYXA2UG9MSEta?=
 =?utf-8?B?SlBhbGtZMUFidUE0enkwTXp1L0lQdCt4MW5iamw3T3hWalFHK1RjcWZIaktB?=
 =?utf-8?B?TEtYeXdaQ2V3TCtnUFBsUnhWRjZUYVlPS1Z6YXlSK3VFMnpRT295YUVCZHZC?=
 =?utf-8?B?VzhxRVl5WlB0bWpPTitIOWtrQ1pxMnllREJkaDJpaDl2Y1NUall1M1d2NTND?=
 =?utf-8?B?UkF0OVZvNm5XNUlhSDFlWklVTUJNM2NCTnRDZzdzTUF1L255anRwa3pmTWUr?=
 =?utf-8?B?eFZ5SU5YN2cxMEtzcUJuYkdWczArSnkwTDRIVWRpQllBUXNEQlJrMzVQL2dr?=
 =?utf-8?B?WENnS1RORXcyWVhmYWNpbWRVcGRGYTNnYnBOcDQ2cmxtQUs4bUFSQy9hYWwy?=
 =?utf-8?B?ZENiSE9aNzNmRHhMRGJMSzM0cXFsS1pnelFQazZOWTMzbURZWjhoWGhEMWt6?=
 =?utf-8?B?bms4ZUYyWXBsUGJ4NEFnZ3ZLeW44VUhRcjNEcjFpVzJUR2tNMTZoVHNtU2g1?=
 =?utf-8?B?YUV4SXJoUUhYdDVISWJpUzV6eVM5UFdmSWcrT2FUVHNrNEc1RUFKR04xZ0cw?=
 =?utf-8?Q?8WWPFTQ2Rjstp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWlITTlXTmNGa2xmbGRPbTl0K05SdEVuNDVzMUtYUitwMDlCZ3ZYWFhFbDZL?=
 =?utf-8?B?UXBoYndtNjVtTEZzd1hDZ3hrY2IvUmpRVWIzYjM1VHVsNFJqamppWklPaUpK?=
 =?utf-8?B?MEZoYWdVSnJsK2dRQ3RUYWx2SjlsNnc0UTlKNngzcDU1NXB1ckhyZkZ1RDdo?=
 =?utf-8?B?bklSbjQ5Z3RQL2ZwUHp1NmVQSnkvVFFCZGRra3pZbEgwU2hSK28vREFRMzNI?=
 =?utf-8?B?aS9RSGJRaVNyZHp4aXdaRWRUSEh0bVlGZGsxaElCL2xpQldVbHJWMWppNitt?=
 =?utf-8?B?TjVvY3JnV3VSK2FVdzY4OUUyVi9vLzhlVEZ4UGJvRXBhS3BKbTJOWXJWY0tr?=
 =?utf-8?B?dUtSZ1RoSUZNV1Q0OUlhVmRmZnMxd3QrY1ozQzRYWk9ZU3BPM3l0dFM2MVgr?=
 =?utf-8?B?QVhvWFI0VU0ybGZtKzhwNGVVVlpORHF1bVBsQ2FaRWtNVFZtUHdhZFF0QUZS?=
 =?utf-8?B?aDlnc0doNVBYSGdBYlNxSDE3NU1FYWhPVXFXVm51UzJCL0Y4YU81YmNybGt5?=
 =?utf-8?B?eTBzRTI2eDM1THRhN29aWERkcm9ORE4vdlVXMm93dFF0ZU9GZi9VSUZ5bWdF?=
 =?utf-8?B?WmFzOExmaklZZFdPN0xEamdRWXVzLzJTbTl0cGNJK1lldmpDRUtHZ3JEZCto?=
 =?utf-8?B?NnZ4dzZ2SHVUaWxKcXJvSHlOeVN0eGFVS3RiRGVxSllzZHVsYW0weEpscEI0?=
 =?utf-8?B?TGY3TmU1YWJTUmZXVkFiMjNMV1BFVWtuTWRTTlFCOC96RzV1cGEySVVFN0tx?=
 =?utf-8?B?YTRYRWZMM2lqM0t0dE9ZdU9lZ0RZNEdYVE4wM0hiby9lK25hdHhUaFBMM2FR?=
 =?utf-8?B?TjBSS2s5dC9vSERadXR6R0xwR0hRNjZJb2tFSmhROU1IT2F2RmVRNUtaZWRP?=
 =?utf-8?B?aWlZd1N4K3NIcTgzUGpqY0w5c2czRG14UENpeHpMcS94ZnF3SWZvZExSTFNy?=
 =?utf-8?B?YTBQQjFFNHNFK05HZEl5L1o4MDFmL0lvRHU2R0hVbUFiaHg4aEN3WVBmN041?=
 =?utf-8?B?SXhQVU8vSHhwZEVTdkxPanYycndvWDFWVzdLNTkraHY2RlZ3czFWelNKWE5M?=
 =?utf-8?B?SnJDcnNDSDlheW9lSFBocXhkU0RQNW9MTHdzVGV1aEVPRk5QdnpoVkJkcW0x?=
 =?utf-8?B?c0Y4ekxPOXRKZWxmdEQvSWxhdjhZOWVnY2hVbGNWQXVCT0hRU2hyVzljSlhE?=
 =?utf-8?B?SDdiVm5RLzFMZnl2VUxLdFlHM3kvYThNVDFST3daODlGRjVCUGtBMnIyWEFG?=
 =?utf-8?B?NG9nR2hKL0wxWmlSREJFQVpyUm5LZFhtbDZFZEFCTnJVdVVVd2xXWW8ycmxE?=
 =?utf-8?B?RWxCQlhRTjZCN3A3OW91ZWs5a2FtNTIwa3VUN2pHNis3bGZlOWRPYzZmb3lx?=
 =?utf-8?B?VUloUnI1bGQ2Z1h5QWRDQ0VwMkFWbk1xanpPK2FDK2tCMzlRZTRjeG4yL3JJ?=
 =?utf-8?B?YW1mZi9oYmsyd1ZSWEEzUWxiL0hIUVR0SURDamFqdFN1d2V5V2tEcTlyM3M0?=
 =?utf-8?B?anZ4ZGtEZXdOb0czTnlDQlNxc3dFQkZHVVBQa2NiamN0RDVJdzIxWDJmdkVJ?=
 =?utf-8?B?VjJnb1B2Sy9UcU9yeGwxOVpRTzZaV29FbEtWTUM4WEZiQUV1dk9KVlptM0s3?=
 =?utf-8?B?eGM4SFFXcVRzemxpUnZxVDZPZnRIL1lldkxxNXZsdW0wcW9JRzhlYU9QbjZh?=
 =?utf-8?B?YXIwYVZGYjNyRFdZRzd3RTJUWHYwOTZyVmJuSStFZThHZHlaSVc0N1lveGsv?=
 =?utf-8?B?OW1PWEJ6WFdXOWVSYS9VMlpBU0cyVkp4cDZ3anBld1BqbzFiNVpyN3VoMEZs?=
 =?utf-8?B?RzZFR3JOUjFkTnA3RFZka2Z6U0M1MVpldFFnSXA1Rnd5TUtJYStMS3pRMngz?=
 =?utf-8?B?ZytUbmliZjJyRHFjdUpYMWdkRkE2cjF2SThrY3FEeWYvN2dCVjZOUk5welRl?=
 =?utf-8?B?U2lKbStUcEtRWHFGVld4LzJxUEpxZ2l1dGJYR04rQzhqZFc5L3FXeitRRVFU?=
 =?utf-8?B?U0tFNW5mRFBOdldkZzNWMjR2NS8zY3p0MEtocVlDTUFiZW51bWNHT3czb0wz?=
 =?utf-8?B?RTBiRWZPbjN5NHQyK24wT1IwNUl5dHVIUzhpK1FBcGdTK3RWbGdON2FlaXJ4?=
 =?utf-8?B?eGZ4dHFhbGswQm5ZSzR5dFJhNW9uajdBakZXeXZwdkpxS1lXT3dnOVRPWTMw?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d16a9a-e8b8-499c-92e3-08dd46839f7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 07:55:29.1474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpSGi1qdoIcsc9TlqY5ENJ94iCIMsceHn5gcKOFiI475sDtG/vv4wArkJzii9rSmP3NrXTrwHqgxvmGzWKVW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815
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


On 06-02-2025 05:38, Shani Peretz wrote:
> DPDK supports multiple formats for specifying buses,
> (such as "0000:08:00.0" and "08:00.0" for PCI).
> This flexibility can lead to inconsistencies when using one
> format while running testpmd, then attempts to use the other
> format in a later command, resulting in a failure.
>
> The issue arises from the find_device function, which compares
> the user-provided string directly with the device->name in
> the rte_device structure.
> If we want to accurately compare these names, we'll need to bring both
> sides to the same representation by invoking the parse function
> on the user input.
>
> The proposed solution is to utilize the parse function implemented
> by each bus. When comparing names, we will call parse on the supplied
> string as well as on the device name itself and compare the results.
> As part of the change the parse function will now return the size of the
> parsed address.
>
> This will allow consistent comparisons between different representations
> of same devices.
>
> In addition, fixed vdev test to use the rte_cmp_dev_name function
> instead of the custom one.
>
> Fixes: a3ee360f4440 ("eal: add hotplug add/remove device")
>
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>   app/test/test_vdev.c                     | 10 ++----
>   drivers/bus/auxiliary/auxiliary_common.c | 17 +++++++---
>   drivers/bus/cdx/cdx.c                    | 13 +++++---
>   drivers/bus/dpaa/dpaa_bus.c              |  7 ++--
>   drivers/bus/fslmc/fslmc_bus.c            |  9 ++++--
>   drivers/bus/ifpga/ifpga_bus.c            | 14 +++++---
>   drivers/bus/pci/pci_common.c             |  7 ++--
>   drivers/bus/platform/platform.c          | 15 ++++++---
>   drivers/bus/uacce/uacce.c                | 14 +++++---
>   drivers/bus/vdev/vdev.c                  | 23 +++++++++++--
>   drivers/bus/vmbus/vmbus_common.c         |  9 ++++--
>   drivers/dma/idxd/idxd_bus.c              |  9 ++++--
>   drivers/raw/ifpga/ifpga_rawdev.c         |  8 +----
>   lib/eal/common/eal_common_bus.c          |  2 +-
>   lib/eal/common/eal_common_dev.c          | 41 +++++++++++++++++++++---
>   lib/eal/common/hotplug_mp.c              | 11 ++-----
>   lib/eal/include/bus_driver.h             | 24 +++++++++++++-
>   lib/eal/include/rte_dev.h                | 15 +++++++++
>   lib/eal/linux/eal_dev.c                  | 10 +-----
>   lib/eal/version.map                      |  1 +
>   20 files changed, 180 insertions(+), 79 deletions(-)
>
> diff --git a/app/test/test_vdev.c b/app/test/test_vdev.c
> index 3e262f30bc..860fa260af 100644
> --- a/app/test/test_vdev.c
> +++ b/app/test/test_vdev.c
> @@ -20,12 +20,6 @@ static const char * const valid_keys[] = {
>   	NULL,
>   };
>   
> -static int
> -cmp_dev_name(const struct rte_device *dev, const void *name)
> -{
> -	return strcmp(rte_dev_name(dev), name);
> -}
> -
>   static int
>   cmp_dev_match(const struct rte_device *dev, const void *_kvlist)
>   {
> @@ -82,7 +76,7 @@ test_vdev_bus(void)
>   		printf("Failed to create vdev net_null_test0\n");
>   		goto fail;
>   	}
> -	dev0 = vdev_bus->find_device(NULL, cmp_dev_name, "net_null_test0");
> +	dev0 = vdev_bus->find_device(NULL, rte_cmp_dev_name, "net_null_test0");
>   	if (dev0 == NULL) {
>   		printf("Cannot find net_null_test0 vdev\n");
>   		goto fail;
> @@ -93,7 +87,7 @@ test_vdev_bus(void)
>   		printf("Failed to create vdev net_null_test1\n");
>   		goto fail;
>   	}
> -	dev1 = vdev_bus->find_device(NULL, cmp_dev_name, "net_null_test1");
> +	dev1 = vdev_bus->find_device(NULL, rte_cmp_dev_name, "net_null_test1");
>   	if (dev1 == NULL) {
>   		printf("Cannot find net_null_test1 vdev\n");
>   		goto fail;
> diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
> index e6cbc4d356..ba2f69e851 100644
> --- a/drivers/bus/auxiliary/auxiliary_common.c
> +++ b/drivers/bus/auxiliary/auxiliary_common.c
> @@ -237,10 +237,9 @@ auxiliary_probe(void)
>   }
>   
>   static int
> -auxiliary_parse(const char *name, void *addr)
> +auxiliary_parse(const char *name, void *addr, int *size)
>   {
>   	struct rte_auxiliary_driver *drv = NULL;
> -	const char **out = addr;
>   
>   	/* Allow empty device name "auxiliary:" to bypass entire bus scan. */
>   	if (strlen(name) == 0)
> @@ -250,9 +249,17 @@ auxiliary_parse(const char *name, void *addr)
>   		if (drv->match(name))
>   			break;
>   	}
> -	if (drv != NULL && addr != NULL)
> -		*out = name;
> -	return drv != NULL ? 0 : -1;
> +
> +	if (drv == NULL)
> +		return -1;
> +
> +	if (size != NULL)
> +		*size = strlen(name) + 1;
> +
> +	if (addr != NULL)
> +		rte_strscpy(addr, name, strlen(name) + 1);
> +
> +	return 0;
>   }
>   
>   /* Register a driver */
> diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
> index 62b108e082..b97f1ce1af 100644
> --- a/drivers/bus/cdx/cdx.c
> +++ b/drivers/bus/cdx/cdx.c
> @@ -464,15 +464,20 @@ cdx_probe(void)
>   }
>   
>   static int
> -cdx_parse(const char *name, void *addr)
> +cdx_parse(const char *name, void *addr, int *size)
>   {
> -	const char **out = addr;
>   	int ret;
>   
>   	ret = strncmp(name, CDX_DEV_PREFIX, strlen(CDX_DEV_PREFIX));
>   
> -	if (ret == 0 && addr)
> -		*out = name;
> +	if (ret != 0)
> +		return ret;
> +
> +	if (size != NULL)
> +		*size = strlen(name) + 1;
> +
> +	if (addr != NULL)
> +		rte_strscpy(addr, name, strlen(name) + 1);
>   
>   	return ret;
>   }
> diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
> index 9ffbe07c93..f768fb9454 100644
> --- a/drivers/bus/dpaa/dpaa_bus.c
> +++ b/drivers/bus/dpaa/dpaa_bus.c
> @@ -153,7 +153,7 @@ dpaa_devargs_lookup(struct rte_dpaa_device *dev)
>   	char dev_name[32];
>   
>   	RTE_EAL_DEVARGS_FOREACH("dpaa_bus", devargs) {
> -		devargs->bus->parse(devargs->name, &dev_name);
> +		devargs->bus->parse(devargs->name, &dev_name, NULL);
>   		if (strcmp(dev_name, dev->device.name) == 0) {
>   			DPAA_BUS_INFO("**Devargs matched %s", dev_name);
>   			return devargs;
> @@ -447,7 +447,7 @@ dpaa_portal_finish(void *arg)
>   }
>   
>   static int
> -rte_dpaa_bus_parse(const char *name, void *out)
> +rte_dpaa_bus_parse(const char *name, void *out, int *size)
>   {
>   	unsigned int i, j;
>   	size_t delta, dev_delta;
> @@ -494,6 +494,9 @@ rte_dpaa_bus_parse(const char *name, void *out)
>   		max_name_len = sizeof("fm.-mac..") - 1;
>   	}
>   
> +	if (size != NULL)
> +		*size = max_name_len + 1;
> +
>   	if (out != NULL) {
>   		char *out_name = out;
>   
> diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
> index 68ad2b801e..a525b5e245 100644
> --- a/drivers/bus/fslmc/fslmc_bus.c
> +++ b/drivers/bus/fslmc/fslmc_bus.c
> @@ -103,7 +103,7 @@ fslmc_devargs_lookup(struct rte_dpaa2_device *dev)
>   	char dev_name[32];
>   
>   	RTE_EAL_DEVARGS_FOREACH("fslmc", devargs) {
> -		devargs->bus->parse(devargs->name, &dev_name);
> +		devargs->bus->parse(devargs->name, &dev_name, NULL);
>   		if (strcmp(dev_name, dev->device.name) == 0) {
>   			DPAA2_BUS_INFO("**Devargs matched %s", dev_name);
>   			return devargs;
> @@ -235,7 +235,7 @@ scan_one_fslmc_device(char *dev_name)
>   }
>   
>   static int
> -rte_fslmc_parse(const char *name, void *addr)
> +rte_fslmc_parse(const char *name, void *addr, int *size)
>   {
>   	uint16_t dev_id;
>   	char *t_ptr;
> @@ -298,7 +298,10 @@ rte_fslmc_parse(const char *name, void *addr)
>   		goto err_out;
>   	}
>   
> -	if (addr)
> +	if (size != NULL)
> +		*size = strlen(sep) + 1;
> +
> +	if (addr != NULL)
>   		strcpy(addr, sep);
>   };

for DPAA/FSLMC:

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>


