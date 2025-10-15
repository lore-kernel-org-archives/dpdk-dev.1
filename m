Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B27CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 15:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3647040698;
	Wed, 15 Oct 2025 17:35:06 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011047.outbound.protection.outlook.com
 [40.107.130.47])
 by mails.dpdk.org (Postfix) with ESMTP id 7725A40273;
 Wed, 15 Oct 2025 17:35:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EchsMPw3ghLQcOGxzLV2h3C3CIxomw0OwQdPmau+dXptCllhVZhHFk8JicONqA0YvyjvrV8ZMp4iF1y6QKjSOC3k7Oo5E2WH27qOujPqWeaT/wbAl69ZZ1e26owumKhlWYaFIkZzXXHSdZGiM8LPM4n39MVbH54wxjOoX0N4ocWb0gBgp0EuChFoGOrB/kB/WLunC52CP9mNGg9KVoPUdNmsT5ya7CtYfilTNLflZ3GYnA1st13g/UphPL/rsD/RB0BYTBfCPaZ9mjNDUM5yBzhqcLGZff2ytsMszP1br0tR1OM8Xr/1rGiLQkyUr9BSE7ZqJur3l1/pM3WOjk+S/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOCIa0mPPRsu4GTf2dp2JPWfy/jlfNeI1W9c2my60kQ=;
 b=uwZZlwBz+2QoNlIlRA/TWaT8LW6xijqy0eMRpzZzktwADcXvBg/ZBQwLZzW7LaOQ8sQI5oiHs6B55z/bNDtnUHOA7QsJPKV/Dlkkcw+SO88eMIxPB+JKFMOjVntWQOu37p2OgaeT6Jhi8rVtWXq5Lw+nG1nj4/+OWLIeU1o7YFWlJKr4r1nBTvRdiAv+eLK0LT2LeKqFznOuL3CnpEK19mqmNDEqrKLeN+g4DyOtlihza7MUd7oReGwtu4lwlnFrGL3vCdOxXDiEaeG60NyvRv6IJpW4qX0SHgknrrxj5zFSh96/I5qdJFRZFs+yK785ynn3J2TYgnpGxDOW+c/uWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOCIa0mPPRsu4GTf2dp2JPWfy/jlfNeI1W9c2my60kQ=;
 b=dyz6Zltwe3YQGCdz8JoBNhVWfjWSHj1WhMFdH3md7jnaoDGbYZ1fABTwst2ldQ1knQMzhvqFPW6KVrApWwIGehsHNmVJBJLgbNL63GpvneoCTqAxURzKWV2kq2Zi5w8bK6yM4adKvNGcJsMHEbazjov3beHXNzIYDS7mJW2PRtam9CvasAmrTDRbgVsj7oj82ioqsdbIZbImwfy1/d1mCVZ8hKyw7zRujaUv1fSW5SPK7mtxKfj1N0PasVFtYpsRexYjbG3EjU1o/2mZOxq4uecLe446Di4K3DbMg6ckPUKRPpSI6GD0wChl8bFIp3ABqVEQ/biZPZqoG9jp/NwHhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 15:35:03 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:35:02 +0000
Message-ID: <625a97b4-1ee6-4099-905b-c545dc831106@oss.nxp.com>
Date: Wed, 15 Oct 2025 21:04:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] net/dpaa2: fix L3/L4 csum results in packet parse
To: Prashant Gupta <prashant.gupta_3@nxp.com>, dev@dpdk.org,
 stephen@networkplumber.org, david.marchand@redhat.com
Cc: stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Brick Yang <brick.yang@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251014064035.1312896-4-prashant.gupta_3@nxp.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20251014064035.1312896-4-prashant.gupta_3@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c92c84-cdf2-4548-7f37-08de0c00685b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MldOVWNVcFlVODVVSnB1aThGaHVvcjlkbUtkVmhWeTlrdnRZVDYyRjZaZnov?=
 =?utf-8?B?SXplSHBZTXZGUkZ0YTloUE1WZW5xQ2M0VUpTZitkNDN3bWRtOU5USDZya21o?=
 =?utf-8?B?M2ZFcmx2L0ZlWi95blpVaFYwT3FsSWtLazdGSkZITHp5Zk1rc2twTEQwcytR?=
 =?utf-8?B?bnBVbUJWZDFnRUlIM3JpU2I4bDluaG9DOXpBSWZQOWJoRDRSNExpNThONXF3?=
 =?utf-8?B?aHQ2blZSZ3cvRVdOYlBTVlZKTjFuaHpyN1RQUTc1SnV1M21iaVliSDEzZ1gy?=
 =?utf-8?B?YWtYcEsydGV5aGUvNDdIa1NTdGdkTTdRZ1diSXovb3QwYnNQallhV2FYWVcr?=
 =?utf-8?B?RTZKTWNNN01iU3M3LzB4TVd3UzJuV0VNQ1RUWGJrTjNYTTBERGZRQkh5ajly?=
 =?utf-8?B?ZVlwRmRpS1owQlNCaVFQOEJiYTFET2pqTGdZYmxmZEZwaUVEU21Wa2F6eWs5?=
 =?utf-8?B?KzJpNmVBeUxtSG9wbytwUWx4YjdER2RaMDQrRGxTMm01TTBGcTY2a0pKU0Uy?=
 =?utf-8?B?Y0lLaVllZHRWdnYyTjVuTC8wb2hleWhmZDcrL3FVNXN4dlI5V3c3Ujh2U1ZO?=
 =?utf-8?B?S0RLNlF4UGlZNk1qTHBiaWJoNllzbyt4bWdCeG5sWTVteHhQcFJnd1RXVFAz?=
 =?utf-8?B?ZEtKRzRXYWN1RUJkY2E2a2JsdWM2S0tlVk1CRm4reUZValArWC9NRTFXem9Y?=
 =?utf-8?B?cEJVVzdQTWh5amV3dVp4Ly95TUx5QVJXdy9PVTQyaWxJN25jb3BmcGxOVDds?=
 =?utf-8?B?b2NuaVZ5dHdMRmJuZUg2dkNDeUxHeDEyYnpvdTI4Z3NQSWVrK3VYamxzdTl5?=
 =?utf-8?B?aFA1dS9wWnRuVkVYdnZLZGNyNjliL3RQRWd0RCtrT3kyak5uM0pUcDdWa28x?=
 =?utf-8?B?K3Q2UHZaTVpTV1JkMGlrb3pxU1p0bzV1aUJkWGprWWZDbnNqdlBBZVd2ekJm?=
 =?utf-8?B?cCtsZzM2dTVLS1Qra2dlU280WnkxMkpsbmtKNW52ZHRYTVlvOFpXMU1RNWJp?=
 =?utf-8?B?d0ppMlB5L3kzeUsxZkFhUkRnWTBDWEhxVGRHamd0L0JwWkk2QitCL3I0UTVP?=
 =?utf-8?B?NFNlU0hyTzRzNjFzaU5Rcy9YSGFmNGhUa2ZFN01MRExrcUFWbFM2TGlkQ0hF?=
 =?utf-8?B?ekwwcXhKcytFdmcrUmsxMjBUaURLVnh6QnlWZmIrM0dYOThpT3hGTXJtSTRN?=
 =?utf-8?B?dEdtUWtZRXdkVnA0dGxkVXZjd0tLSktzeFJiUDR0YWQwak1Ea3NJYkU5OHdI?=
 =?utf-8?B?cGZybHVzNitlMVM0SUprVVBzc01vMUZjZmRhc2U5NlhxU0k1MDUzSTVJU3J3?=
 =?utf-8?B?QkhjRmUzbm1EQ29lVTNqdk9LUnNSQThvMmFDMG4yRnVEWkd3SVhaY0dIMkF5?=
 =?utf-8?B?SW80RDU1Nm00bzVDL0Yrbm81cSt5RXdUVkNsL2pVdGNxbVBiNW9mNklFek5z?=
 =?utf-8?B?OHZPYktSTXhXaklsYkpIa09ZSEFsUiswZXNwVU9kQnhqVFZaMTEyTEtLRW5X?=
 =?utf-8?B?NVVkSGgxZUNLZzgreEJHVnNwSXowY3huSFh3VjZvaXZqODdzeXE4Sm51R0Z5?=
 =?utf-8?B?NnZZU25tVmk3VmFkN3B5UVVzbDVaaXA3bWpmRjVXdWVzUU4yWHE5RVZ3R2xQ?=
 =?utf-8?B?WEZ2SzhzMElQS3pXNlpqeU5yUUtmZllKdlltVWk4VlUyMUNtL29LOWFIbHlF?=
 =?utf-8?B?REhhSFV1cEZMb0c0MnFwdTdRVnNRZUFXVjhPNS96dEllNCtua1VzRzY2QkJY?=
 =?utf-8?B?Wk01amRQOVVndHlxdGZqZjRadTh1YURWRHZrMm9jVXZKWG9OWVdqY3VkTVJ1?=
 =?utf-8?B?U0pjclhjRFNsVWR2azF3MUJyWXZhOUV2SHpKSkFvUVdRVGplaWt5RmZqUTV2?=
 =?utf-8?B?dU9UYjhYeDlVSnZ1YWtQOW9PWE5qRkxJcGVROTNDZDlLR1BpcW53M2RNNnJH?=
 =?utf-8?Q?S+BTz5dB4NpV09KMaMQ7/GB2HZ46bwi/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEtZRnBkU3lCZ0VvYnQ2Y0E4R2Z3OFRvcnhxSUhPQk0xMDNoWkZiem1YdHJ5?=
 =?utf-8?B?c25zUnFhdTNMT0RvZGQ1elNraWlweThhb0UzTnhlWFFvVnFoTkJ3YXVJLzhG?=
 =?utf-8?B?VFFHUkdZOTFiSEszdE1jTWZUb2tldVFraGpFQ0JVd2NVQThDQW1DV2p6NGtW?=
 =?utf-8?B?NGR5Uk00YXM3RW5DVUZUTWRVVk9CWk1wNFBWU2NtMjl4bGRTK3Zla3RsUzRk?=
 =?utf-8?B?TDkzL2pod2g1WXd5ZTdkd3JuYlNsSzFQZi9NMUUvYjdMcjZJcUtiTXpFdW5R?=
 =?utf-8?B?SUk2T2MwbEMyajgvNGJGS3pQN3cxejZaeUwwMzBUNlIrd1k5M283S01EcEJH?=
 =?utf-8?B?QmFUVmJSb3pZZjNiZEIyNFNCZnZYUEtndCsvMHN3L1lmdjVnRUdhOFlDalJU?=
 =?utf-8?B?VUtXd2J2d2pYMnNqWS9hWkJpUXQvTGpYZmpEL1R0empQK2t3OWw5c2o5QXlL?=
 =?utf-8?B?a01Fa3hZQnlQemRBSTU3VG0yeDdYTTVjYkhlanloNmkwVTg0a1VLTTNRMzlV?=
 =?utf-8?B?NXNVbU1BVWpkV2NrNW5VSWEzL2ZaQ1dETVZZT1lXbWhiT0svcmpSZzhRK3hh?=
 =?utf-8?B?T0sxci9wbU1YaEl5M2l3NU5wTEprZTE1S21SN2EyOVNtdndoOHZROVlLMWtQ?=
 =?utf-8?B?SFB5WWJGOFhxUzBIamVrYXVJWjJhMlJvN3JUc01BL05tLzRURXY0Z0JpUGF1?=
 =?utf-8?B?VjlCcWNEODc5WXc3QmM0WkF5d0dzSDJUaTd1ektzNjJtUVNDRDJvWG5nN2d6?=
 =?utf-8?B?emluNDJGWjRuSFVoVFovLzVYekZvLzdZZHgwMUlXUUZhV1p2WGkxY09iYUVw?=
 =?utf-8?B?NFF6MC95a2VSc0xnWmZ2VzRaRkhJbnlCNUllWVRGSkU3Nm8rUTk1R2Y2U0Rp?=
 =?utf-8?B?My9sOXpXeEhkOHY1TThVWVF1NlZSYnROZGszZ3B4dzNkWmVBbVVzZ2YwbUYx?=
 =?utf-8?B?Y0t1WG9wVE5PQjJtaUZ2YmVJS09WQysrdmgzTm0rc0RtOWZsNERqamhwdHE1?=
 =?utf-8?B?S0xHVi9oT2NHS3Vvb0ZRRlNWQnB6QVZ5VWVGMmdmN2YwckdZTkxyOVlxdFhO?=
 =?utf-8?B?bm4zbDJIUVYwRE9xYkp4SDVSTW5DTVYyK2lxdzVONzZBQkxYcWk0dWZPSnBs?=
 =?utf-8?B?RUhQUlJFTDVZbHJNNE9GcUVqcUdyb3gweE8wRnA4TTlUd2FNUEJycld1NTRh?=
 =?utf-8?B?cnpuUTZ2b1NpNE5ieVNtblN6VEovVlBqNGZpZm5ndm4xWkZYZlk0NU1qWktv?=
 =?utf-8?B?N2oxUkdZTmxzT1BwZGZOU2c3emRKOVdicWF2QXVybGpTTmsyTEhEQkdQM0wz?=
 =?utf-8?B?d1h6Z0FqQlNOQzF0ZkkyYXVHUVZUNEYzcTJianlhUnhVMWp3VEhJK21PekZW?=
 =?utf-8?B?ZWFBUlpPNUttdVNVY0oxM3hIdCtKRXQxQXRZa2tORW43K2RCbXVnQnZodjVM?=
 =?utf-8?B?Mmx0b2tIS292ajFQK1FLS0s4Q0xpd2RWaVZBU2VmNG54N0VsL05MeENsTGNt?=
 =?utf-8?B?bktySG1Nc3VDYyszNWRvdzBtSTJqa0dRT0h5ekQwV3E4QkIybG9PT0FNSzRp?=
 =?utf-8?B?MkJ1WUtvcG5nNEk2Z21aY1RWWm52cEwxU0czakswVkNkbGdwcXpyOUwvdU9n?=
 =?utf-8?B?VGNuRHdnYml4NUNQbGx1QytBVDN0WUN5ZHlQSE9WSXVkSkdEVlJraTRLN1pW?=
 =?utf-8?B?UzBwVmRqZnNTRHhIZUQzTFV6ZDhHNitlTmkvWHJOTFpKNzNMRktyMHg1ZEx5?=
 =?utf-8?B?aWNiL2FRRXhIQkxHWWpDMHpjWjdpbFo1UURTbDg1T2RUQzVNWndrOWNIeDYr?=
 =?utf-8?B?WWNnMi8vcHBkaWp1a2JqUGxucWVlcC9TQjJYL3YzSHZHMmxCbVIrVm5yc2tT?=
 =?utf-8?B?UFlYMzRTTUxqMzNodXVBdEFFcUZRc2E4Z21SWFZDVmVlK1JNWXlkUlAvQlRN?=
 =?utf-8?B?QnlyL2RTbE5sNTRSQkNCYXZ1eXpLNDdPQ0NZMUx1cWwvNGU3VUI4UkwyLy9s?=
 =?utf-8?B?UFY4TWp3ZFlQb2NHWEFTa2FSbFNmYUFMU1dpTU01aWJ2WTAvbVBHR3dEdjJK?=
 =?utf-8?B?R0VrRTczQ3Z3YWtJbFhrVzFFM2xQeUYzYmdVN2ZCRUc1Vk95dllTMmx6b0R2?=
 =?utf-8?B?eW9TYnpScVhyTFRIbk1HV3hueEoyai9KQTVjR3BWVTVqd2JsWHZTRHEwejJl?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c92c84-cdf2-4548-7f37-08de0c00685b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:35:02.7213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+TCU07iMZ9N9zgy1Wy8MogqlfuyUVs2xLIQ6TGSUk38voxKv8TQ7KF6KNJ4OWw916TUJXG8779S+PaYO2iapg==
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
> Layer3 and layer4 checksum validation and error
> status is part of word1 of annotation area, but
> driver is looking into wrong word.
> This patch fixes the checksum error status in packet
> parsing.
>
> Fixes: 94d31549c380 ("net/dpaa2: support Rx checksum offload in slow parsing")
> Cc: stable@dpdk.org
>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> Signed-off-by: Brick Yang <brick.yang@nxp.com>
> ---
>   drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h | 10 +++++-----
>   drivers/net/dpaa2/dpaa2_rxtx.c               | 17 ++---------------
>   2 files changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
> index d156b07087..a670098958 100644
> --- a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
> +++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: BSD-3-Clause
>    *
>    *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
> - *   Copyright 2016,2019 NXP
> + *   Copyright 2016,2019,2022,2024 NXP
>    *
>    */
>
> @@ -304,13 +304,13 @@ struct dpaa2_faead {
>   #define DPAA2_ETH_FAS_PHE             0x00000020
>   #define DPAA2_ETH_FAS_BLE             0x00000010
>   /* L3 csum validation performed */
> -#define DPAA2_ETH_FAS_L3CV           0x00000008
> +#define DPAA2_ETH_FAS_L3CV           0x0000000800000000
>   /* L3 csum error */
> -#define DPAA2_ETH_FAS_L3CE           0x00000004
> +#define DPAA2_ETH_FAS_L3CE           0x0000000400000000
>   /* L4 csum validation performed */
> -#define DPAA2_ETH_FAS_L4CV           0x00000002
> +#define DPAA2_ETH_FAS_L4CV           0x0000000200000000
>   /* L4 csum error */
> -#define DPAA2_ETH_FAS_L4CE           0x00000001
> +#define DPAA2_ETH_FAS_L4CE           0x0000000100000000
>
>   #ifdef __cplusplus
>   }
> diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
> index 656a3a423f..6cb91e67d4 100644
> --- a/drivers/net/dpaa2/dpaa2_rxtx.c
> +++ b/drivers/net/dpaa2/dpaa2_rxtx.c
> @@ -201,14 +201,10 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
>                  goto parse_done;
>          }
>
> -       if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L3CE))
> +       if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CE))
>                  mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
> -       else
> -               mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
> -       if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L4CE))
> +       else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CE))
>                  mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
> -       else
> -               mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
>
>          if (BIT_ISSET_AT_POS(annotation->word4, L3_IP_1_FIRST_FRAGMENT |
>              L3_IP_1_MORE_FRAGMENT |
> @@ -248,15 +244,6 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
>          DPAA2_PMD_DP_DEBUG("(fast parse) Annotation = 0x%" PRIx64 "\t",
>                             annotation->word4);
>
> -       if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L3CE))
> -               mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
> -       else
> -               mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
> -       if (BIT_ISSET_AT_POS(annotation->word8, DPAA2_ETH_FAS_L4CE))
> -               mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
> -       else
> -               mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
> -
why the checksum parsing code is removed from dpaa2_dev_rx_parse?
>          if (unlikely(dpaa2_print_parser_result))
>                  dpaa2_print_parse_result(annotation);
>
> --
> 2.43.0
>
