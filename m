Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3312FC83F17
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Jul 2025 14:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 175A14026B;
	Sun, 13 Jul 2025 16:52:59 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by mails.dpdk.org (Postfix) with ESMTP id 718864013F
 for <dev@dpdk.org>; Sun, 13 Jul 2025 16:52:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4xEpqmw5n6rzeqyEp/E1LW0nk5JjbqVrwp+6/shhbxuyPjmtGBbZQIGRXEYim5RNdB5aZVV4y5+wvH1bMvtStR0trb9nGpO5+tQWvDpmbKrOWKoW5Yk+nzbxsJ16XYnKKrIgYPnEcKwK/98ueVtFzbDxKMZYqsg/hKqBzhWVmv013S6bLG1tRZSTaClQH8tP20I7CCgh0hfIZYG5LKpgEPNkvxzYXsQ9n2hCKqlLtEn6/8hyn1htghNnaQt2NBja4QBlN76qCJ7Z79MvrL++WRlFx4DvqKN7SvKBqY4mC/9lsJ8x6Oj0atE1hg9YHgimGYKX/s7t9KVUm8hufNBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR+NRN/9SB35rTNEaqVtQ38lY7T0mbEoyEG5AVNts1c=;
 b=hynINJ7Bpb7RYPdGFaKCYycvgKz1DXgIfdJvNpqbeSgT+L4sA0w5BDW27TihQl+9KQV3gMAM1MWiY+Z3xoy0raHoStsth4ZK5etyfSyjfqb8A8jXB+wY8EEN1fGuEorlr72sOxEf7krMwN3/R5YiUZL/pmWCGkBxIeRSn6XbnBF7LITU7u9b2qaW6+uQqoAWi4ecvVm/p9Uv4dFPpbwvk02fts+Bg3RUwp6KEzOjgP55jZERQeZOd/K/iQJexmfNrBqFHF0IjatzCfR+CVfIwuc5zB+fodlaqcG4HblVTmlJbhROT2azCvOsZhNkwcecsoykiQxGAjZp7uOmub4KEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR+NRN/9SB35rTNEaqVtQ38lY7T0mbEoyEG5AVNts1c=;
 b=e/MFW4usUtBc9+uPw/yUUWoGB0VjwyqkAEgpUwQkhoQqjloqOHLPMc76wcxCbF7w0NquKm227nwx9WFPKaTgnFJ/x78nq0CTmbXUXuK1qmsvLtt/T/6UY0QyD1XnBzpbQ+3f6888hNYrdLSA/NRQWvoNg8Yfel1qO3TcMRXrs2ZsDT51+8NwAWvVcAPhO6AhooJbR44t8RKMru3xX7qv4z8T4HZDhWsKdkm7y9CTEI5CHHsqkLzOZTkUlM3TtYwCMgpY9bAIxO1xaAjiZvyRE6z1fFsG9Be0/c5OedW/e/N0UQTIhDv5Xfa9kXy8NfQ+sPNoma0rJ4aL6tTuqyFCgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Sun, 13 Jul
 2025 14:52:55 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%7]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 14:52:54 +0000
Message-ID: <6bf7f9d9-1fb7-44cb-a490-12e43f7da848@nvidia.com>
Date: Sun, 13 Jul 2025 17:52:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: DPDK release candidate 25.07-rc3
To: dev@dpdk.org
References: <9991491.lyo4hBLbkK@thomas>
Content-Language: en-US
Cc: thomas@monjalon.net
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <9991491.lyo4hBLbkK@thomas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|IA4PR12MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a1d85b-4718-4c51-1bf4-08ddc21cf2df
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWZrZVJ4TFBtYVg2dkZkdDdQSG4zU09DV1paK003NlA0dmNGd2xXMCtNQzFi?=
 =?utf-8?B?cnQwaWVRSitxTDZyQXVpZ09pbXhnK1kxY2tRQ3VWNWNIdk16czB2Wml5TnZs?=
 =?utf-8?B?cTRmelF2d0Z0dkVnVGRFTGJnS2piRmpmNW41c3FBb04wbFh5SGVKaEVldHJn?=
 =?utf-8?B?Q1Z5M2tmbnVqd2RySFBxUnUyNjVsZjlvaVZwTFR0YVNQSHRQSFNQb2ZnSzFt?=
 =?utf-8?B?T1ptQU5pSXEwUGpKWmhIUW9HOFQyQlM5aWhDRHZhQnVrSE5GU1JJQXVBNFY1?=
 =?utf-8?B?aGVDSTVjSU0veDZyNE5ycFJCR0I4ZjE4V2RvRm5yN3dWK3NVL3IyMEp1SXZ2?=
 =?utf-8?B?SzFHYU9BVG9lc2hHTGhFRVJPWDhWQmxrQy9BbCsyc0diUXNmcTRoL05BRFdL?=
 =?utf-8?B?UHcwTCtGbVhOcTRyUWZOdEpRRnA2QklRZTJBaktoTU1JZjkzdW1CTnlHNi9Z?=
 =?utf-8?B?Z21vdnpCQW5xNlB0RHFTQm5LK0FYOUdLOEdBV2k4RktTdEk4NldFdituank2?=
 =?utf-8?B?K2tDVUd6K2NoVXV4RjQ3a2hNamx1QWFZbkNYSkxmdThhQWpTWVJQak80RmFS?=
 =?utf-8?B?alVQQkNzaEhTN1Zmbmovcmp3ODlJWHVacGZmTEJhZXdVZURueDNsZGErMWpv?=
 =?utf-8?B?RjVFdUFuNjNCQXVvT2NNVE1Dc3NQeFZ3eUJFNFd5NFFvTy9KbTNuZXd0eHhC?=
 =?utf-8?B?dFZOSjNWZXZvY0ZadG55ZFF1eFNmY0F4K3ZzWjh1MUwvUGlpZUREWWFPcW4x?=
 =?utf-8?B?ZkxBY0hRa0VYbks4Vk90RyswMUhMcGhPeEYwVE5WRlRLY0tmYkFiUHFQYjFW?=
 =?utf-8?B?RG5La2V2b0thQ0xIbmNiYmgvYjZmYnRTQVdwdHV0NDBzb0tBdTFRUmFYRDc1?=
 =?utf-8?B?MThZSTZVZDJ6cEQrTVJ5VzhQZTBZK3hRQklTK2RneXh4VUY5Wm1Qekw3SlNS?=
 =?utf-8?B?ZUtENlRZMk1lV1VHVCtjVDRqa3pxRGZEZlFOZHpIOTZrbEpUeFBlUGRVaVNu?=
 =?utf-8?B?WEVQZUVXaExZZi9HVnF0czhSYThXby9Pb2V3aWhDZk9QbXBzTFBTdXhqaFN0?=
 =?utf-8?B?aU9GNjJUTkJpbTJqNTRwcmZGb2R3UnFGcGcwSWxzeW1SUU9VNzAwTWNCNElP?=
 =?utf-8?B?MEozeEtTWVR1SFNHbWN2VW44YmxtdzRWQmRidzVlTmd2V3RTTS8rcVNsVGhp?=
 =?utf-8?B?emRPUjdXcVB1UHZ0cEhHV3FzU240ZS8zc3kzMWRYdThkVXpJRnlWMTY2Wnhy?=
 =?utf-8?B?ZFFOK1hjSkxLekd4M1BodC9ENWZSSy9Xak1mUkhtbWZKK3plSXQ5LzEyWDEz?=
 =?utf-8?B?MENma1F1L051YXZ0RXVaK0FrdDhPVVNXY2RDYWFhWmxnM1pOMVVtc0lSOERT?=
 =?utf-8?B?dkFseW5CT1V6d0VPR2dua0hOd0pkVkduSkx4MG5JVVBLZW0zU0dCWXlqc3RW?=
 =?utf-8?B?bS9wQm1xcHljS2hURHdwQWprK0plRXo2RFVaTzYzMGZUakNkM2RVcmwzUmQr?=
 =?utf-8?B?SlAwQjd6bkVRLzlSVldPTURobVVBbFRSbC9VZGd3R3Z5akJ1RHV5cmJ2aFN2?=
 =?utf-8?B?UDFKREpBVkJiQmxnbGhacXQ0WENhUzY5TzFZYkQ5OUJMMkZuK0xzeXI3MHVz?=
 =?utf-8?B?Y3FiM0pmdVlpOTdiVkFvZlBBYTZSZ3NLSWlCNzhKeEwxS0ErNmd2a0lNMGRL?=
 =?utf-8?B?NG9SUVVFNHZtb2Rzc0svOGprRk1TZHNkU2hzTnNGVkwvcDlmUmVKeHZZUUNt?=
 =?utf-8?B?ZUYxVGFDREE2WExBMi9idDVHUnE2cTRwZm9ZTWVERE5HUjZpZUgrcTMrOW9J?=
 =?utf-8?B?amUzRkJpQmlMa0UvVm5KNU5CaFZUaDZKeG5pR1U1MkZVNFN4clVsRGtzVmcr?=
 =?utf-8?B?UjZjSW1qKy9mSXNpQ2Vsa1lRSUdIQktDejhaV0lFcVVXT0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0dLTUpsczBqSGxrRFZ2ZmpkVkxHcmZPZnl5UU1BUUlDSXdTeUNWUnFRZkIr?=
 =?utf-8?B?eG51WkFtU2txckViUndVdW9VVXNMREptVDhmcDQyN1RrNGQ2K0o0QTJBWWRw?=
 =?utf-8?B?VUhienVldjk1MzhKOTJNN01Qa2luS0tPSHBjRHJaM0xza0Ezc25kaHRaUE5S?=
 =?utf-8?B?akVNQzRHRVZtZ1paa2N2ME8zTlh1U01pbVQrTVlRVUV2SURIbEU5eStBWTlS?=
 =?utf-8?B?ajU5WXRnZE5XRThHaUdXWEF5RE9oeGRxTHVnYlIxSEttdlZCdkJYOGlxaElu?=
 =?utf-8?B?QTd3b0VMUTdOeWl0ekIyU2ZZK2tGdHVXSmFkQnRDd1A3UlU4TkRXZVlRQmV4?=
 =?utf-8?B?angyRC9LVmc0SVBYRmJCUUpIZ2I2Tm9yWm1rUnhLbU5EWVZKSVNKWDZhcThO?=
 =?utf-8?B?N1RDS3N1VDJRSzFBSEptdEtYbXU2cUhXTDZUaERWdU05ZmY2LzVQTlRFcGY2?=
 =?utf-8?B?cXNjMmlIUW9xMmtVRTBSOU1XSnZ0Mi9MWTZXZXVZQmZlUjhWZWpMZjNiTzk1?=
 =?utf-8?B?RzhaTnBCTk05QnJJZWVNZEp1STI3STFzc2xtbzJuMnB1UDB3VEI3aWhHUlQv?=
 =?utf-8?B?MzVQRGoyTkVEbEFYNFFreDROQ2kreURYdHpUamlQS1B1b0R2cDJTUjB0U3F5?=
 =?utf-8?B?ZSszY01QNXE1WVBUWkhlNFVzQllUVG5sd2lnVkhSamVSZFRWS2V0dzRCTnFV?=
 =?utf-8?B?VEVLK2tyUFFlNUd2TU9VTjNZb3Jnekx1bnRZTmtaSXdLWm9zRDNjU0RDU1RF?=
 =?utf-8?B?TllpSjk2clVjajV3TTFyZ3FJQWk0QVVLUDMvejBLa0lnZ3B5N3FXSW5HU1Bu?=
 =?utf-8?B?TlNkNE5HaUtDanQ5OFluSnVHd1Zndmk2M0FFdlFKRzdXcDR1bmFCVHY5K3c0?=
 =?utf-8?B?azJmSTBNTEY3bEpvQm9NbnAzMUZUa0J6VnZWdVFCckRPWkVOQjV2TE4yQmd4?=
 =?utf-8?B?QW1EenM1dVQ5aWJtNzY5Z1dXYWhha3lrVk1zYko3L29xbUpwRHBZMlE4bTNO?=
 =?utf-8?B?WnFoR1dqbzdkNVZ1SlNDTEREWFFtMndPcU5nRFJkTXB5OE5DQm1HYU9ycUls?=
 =?utf-8?B?bldFT09NTHA3WnN1SjRDK2pTSUQzaTh3S3lVOHVUaUlnR1MrQWwzT2lXam1n?=
 =?utf-8?B?dHhzVHZLcWNDeXVLLzVvU3FuOFFJa0lSUjV5ajR4cE9BcEdLRkQyaTVtdzRt?=
 =?utf-8?B?MERSY215aVVLV1VDbVk4ZWRiSHd1UWlpSk93bnd3U05nNzlKd0pBYk9QK1gr?=
 =?utf-8?B?THk0cHB6NlZyZ3h1RllCRlV3aEJpUmdZNDcwTGRxc3RlU1dLNC9PMXNIVkIx?=
 =?utf-8?B?czV4VGEvNzVkcFRrQVlTSHNPVlJNdWszU1Z3RmNUZnBMa2RaemF1ODFHbGI2?=
 =?utf-8?B?b0UxZVNCbCtmd2VjcnJRdnhmY2NMRUgxNUY1Ulpaa3RoRG9zWlpRQU1JVGRN?=
 =?utf-8?B?Rm5XcDVjbEtYQWtBRUtzMnBmU3N5eGNvdUxodXpZeWVrUm5TUCtCbDZFcHB3?=
 =?utf-8?B?UUpYeG1BZmp1b2M1TWEvaVBDQjJuYzEyTGo3MkxyazZ6QnUxSGJucEYvVGJO?=
 =?utf-8?B?aE1rQjNLNUdpOGNnUnJNVmUyRWk4S2xqSnhlSGdGZVk3N24vM1k2VGoyY01N?=
 =?utf-8?B?V2dlYlVRazY4Mk95SU1VdW1GcXhCUzdCVHN3ZmViWnA1clNZNWdvMGhYTVhC?=
 =?utf-8?B?NjhiMHRoNEJrMkdZM3ZMOFlxR3RZc1lwMEhzQ3VRd0s1MW56Q2JXWjNVNGJH?=
 =?utf-8?B?Q2tDSHVOZFd1WnlkTnl5UE93OVVQaVh1NWVjRzBGYzRvaHhRUExTaytLVWFq?=
 =?utf-8?B?eGh3WE9Cbk9ydWd5SEZXNHNyTnZYNHVlaDhYU01pcDZUcXM2ak44OWdvd1cr?=
 =?utf-8?B?WjZQalMwWDFMQmZhaHBwS1Vtb1VoQ25UQzNtVFRUdmZLclVjOGFzNDl5YXc5?=
 =?utf-8?B?Ny81VG5yMGFINlRDMCs2OEFzd0lZc25uSThleVFaUXJZSE9tV2Y0ajkxRXJL?=
 =?utf-8?B?SFhJdFU2K2xIazEyTmMvNTdWdnNpbHZPSnVFbUM5STJDWFd4QkkxNUd3NVZz?=
 =?utf-8?B?d2x5YUwxSnhhaGF1OG14cFVIYmNkUTlTbTFLcmhjdzhUM2xxR3huR3JtV3dx?=
 =?utf-8?Q?tEmPAhBj9lhHGeTR4Gd8nAWRc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a1d85b-4718-4c51-1bf4-08ddc21cf2df
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 14:52:54.8905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8YQbpRFFdATXPIZzy+M+tAF/XRCSQyDdiYLxNQMeRIffOyeQDjTCOfAw4Uq+XIcFlruJQhsLNoCRY1xdtsIyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9763
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


On 7/10/25 12:26 AM, Thomas Monjalon wrote:
> A new DPDK release candidate is ready for testing:
> 	https://git.dpdk.org/dpdk/tag/?id=v25.07-rc3
>
> There are 86 new patches in this snapshot.
>
> Release notes:
> 	https://doc.dpdk.org/guides/rel_notes/release_25_07.html
>
> Please test and report new issues on https://bugs.dpdk.org
>
> Only documentation changes are expected at this stage.
>
> If no major blocker is discovered,
> this release cycle may be closed during the next week.
>
> Thank you everyone

Hello,

We ran the following list of test suites on NVIDIA hardware with v25.07-rc3:

- Basic functionality:
    Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- RTE flow tests:
https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads
- RSS testing.
- VLAN filtering, stripping and insertion tests.
- Checksum and TSO tests.
- ptype reporting.
- link status interrupt using the example application 
link_status_interrupt tests.
- Interrupt mode using l3fwd-power example application tests.
- Multi process testing using multi process example applications.
- Hardware LRO tests.
- Buffer Split.
- Tx scheduling.

We don't see new issues caused by changes in this release.

Thanks,
Ali

