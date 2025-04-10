Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FAC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 14:41:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F18C340666;
	Thu, 10 Apr 2025 16:41:10 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by mails.dpdk.org (Postfix) with ESMTP id 52206402ED;
 Thu, 10 Apr 2025 16:41:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NorxiTkBQY18hf/cJkyH8xHXk2I2TpYcHZis2qaqcIDv+F7qFvoYTlo2xAnJAeZKF4GoTGw8SUlGZkiDvGknHjp/z/IuPCTgRcBFwb9kGocYShVkKslP/lKtVu7BQURgCTZ7RRprgWkdJepRbQtzjc2KvoSudZB8OdR2VpEkGBI1kG6LFUt3EVIKNt9dOkxKxmPd70B6BUme1V6O6JcCV+dMeJJlbVybo9lEU9wzN7RlyTIc6TfIV/pwaohhMK6ZOniKOrKaT79AvezhDThVmRwsMd+SSMQZlXJcge2Tqd+xJLjLtbmRu9B2U1DdtOSlO+Us9GAkXdIgxke/b7k3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh36Tmlkc8FyssYGTHxfa9LlkUHrUJuZtezWVZ1oTks=;
 b=imPR7KMS6tvP3G4/OcuuOGsLf7x++wMX8ivdJgesSV4QNaKQQ8Fd8MiJNMK7K0Ho9DAdSOYViSjX7VmEiIJZw6rgMPNY8iK2+dpTm/3YlgkoB6A/0QUk6ePDMuFNPwVt80b06unBCM7lzkZBWi8pdd+P+rEAp2a6R2eJdJ0k1QzXwHPFCCyfee+cmBMePKwjpnM1JPbBZGYQyAeeO6MdU4kGfVeq8iYMcdYi+1DLWL7MfSLMgbZze7ztRoKDYhIR9t6KCziZ3UtJVNSnhukzmP71LeHf9XeUBGNH8QjiWeKpMUchl/UT55Q3NM4t7wsE0ny28512LZSVg2n4sfq6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh36Tmlkc8FyssYGTHxfa9LlkUHrUJuZtezWVZ1oTks=;
 b=BJjYg0ybypzhviP7kkeX5H64vAhLxhskUGyfQKdxbgPKBnEknC+TWoHm8Sed6qY4NWhI0us/XvabyveKcjyeWAnuiRcbWtKzGjEFPs8S6q2rho/zI7V4VGuocktKGhCkV/zVrvSBge2if1KUYXp5whKIMud4FT0UP88RfIp3prJAGWsYcChhV0jTXPxP/O7hvDe3szx86izIkLW8Z6iaIT16+xy/Q9Cc8AnooZDR1LPDnHbtMX0glYGKFFWFgI2YdqHjBc1ofVhCQj1a4W6hW9+3A4mTV8LMjJpuE4CAPv0QkY80j7HERyD6LI2g0KRy1ql0UdimE/b6tZ0fMsz3oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 14:41:05 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 14:41:05 +0000
Message-ID: <bcf9bb55-af24-4191-afb6-6ac01a2c89b3@nvidia.com>
Date: Thu, 10 Apr 2025 17:40:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.2 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, yanghliu@redhat.com
References: <20250328101435.250876-1-ktraynor@redhat.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20250328101435.250876-1-ktraynor@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 938ba5d3-c0c3-487c-5053-08dd783db8fb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnBlN3U4ODloZFVZSTB1dmx6SnU2K0ZWTnhGTElSTk5XWE1GUlh0ZUZZQkxr?=
 =?utf-8?B?UENjclRoRDZJT2V6d3g4NVEzeURRNzVzVmRmazZTMzhLZmcrbURlTk00TThQ?=
 =?utf-8?B?V0VDWExmaDBKelllTDhsUEdyUVE4RVhOSGRETDFHMnBNS2dibU5xaW1SVk1L?=
 =?utf-8?B?V1pVSkxrRitReDh1dFZLMW8yYmRWc1pJd1NHeEk3eWZQUDQvazhHVHVqSjlC?=
 =?utf-8?B?ZEgzcTVBLzQ3S0JCd0s3VDV2djVnY1J2d1d4bnNNOXoxbmozWHh5WUFFdysz?=
 =?utf-8?B?K3hPWU9WR0kvZEp6eTVhVGZCSFNOeDBmQlgySHlDdkNSSkJJWjU4cmJWQ1RQ?=
 =?utf-8?B?aUhxT0hvU3g5REx5YTkrQTJ3eUFYbGJocWtxNnA0Z3dUVlU2cjFhSERHR0ZT?=
 =?utf-8?B?WjA1UTZNSm9qb2xxMDRuRTcvQlhScHJZVFAzZklHdlYrMjNUQ3Zzd2xkdklB?=
 =?utf-8?B?WkF3dGREWHorZ3hIK1RqNEpwT1FhUEc3aDVPUG1aYysvb0diaGU4Z2ExVkxR?=
 =?utf-8?B?b1AzRHBwTWV4MFNrTTgzWC9BWjl4dDFZdVZVNzI2OUYyTFRjYWNoN2hqK3dQ?=
 =?utf-8?B?QTRnOGsrbkJ6NTFGRC82OVBuYnZsd1NMTDFLREhobm1wM2Z5RTdTeE5sSE91?=
 =?utf-8?B?dHduUVRoOHBFQVM3bkNHcHg0bk4vU1BJbDRnWWp6V3R6VEd5OWxrbG5VOXk4?=
 =?utf-8?B?emU2b1hwbzhBYmpEY2NrcWJ1b3FrMTJIUUhxaTBvM3loOGN5Ky8xcVBNQU82?=
 =?utf-8?B?aityNXFHeUsyUXp5Q0FVc1JDWitEenB4Ui9UMk1tdEtkZnlUNTV5Ky9SVGN3?=
 =?utf-8?B?M09yWHZCUGpsczNXWmUxVmRjajJYaEltSzhmRWhxQ3E5QTlsd2Vxc29Cd1Js?=
 =?utf-8?B?c3VoVFpReS8vbFJYb2RaQ3NzaUtBaHNVSDVyZUxkbDFhYS85eGpNRDBXYVVs?=
 =?utf-8?B?S0M2bmtNMVpaQXZCbHl2TmZndExTUDlFRmZYdjVwbEFLbjFsbm1RUHNJNWhk?=
 =?utf-8?B?SkVQUDh3U3ZpQXBRRERGNTRFdVk1bTY2RUVQV1VWdnlUd3V3TmkvR3pvUk43?=
 =?utf-8?B?UDBGWnBGbkg2Q0V6aUJnQmdWa25WdDB6aDlPZHp2aGxTLzdERzl3WVN3QTBj?=
 =?utf-8?B?cDR5SEJqMUp6OTZRZ0lmK20xMnNucHltQThOeVMrTUhncnEvZjlJTVNQTllV?=
 =?utf-8?B?a1V5ellYazdVUzNDQXFQQ0l0MlNZTHJad2NTbEZ6WlM3RXFSU2w4aVAwbFFi?=
 =?utf-8?B?cHUvcFJQTXNDYnVhZlZQVXNNWnI2RDN6anpaTFhjYWpLSm83QmQ4Z2NvNkdJ?=
 =?utf-8?B?Y1d5TDdCUkJZSkFRaE4xUnYwSS8vVHlJN0RBOWdCb1N4Nit2ek5ORUdFdjRi?=
 =?utf-8?B?eWF5K0JLZmNNbHh1QlVPcFFOWFNVZGUrUGdjOWNWRTBnRTdrOFdLcUVqMTlm?=
 =?utf-8?B?UHNZRkJUWC9MYnovZmRDelkrTC9BNWNmVzBVS2d4aFdvVHdZMVhYa0tHRWtP?=
 =?utf-8?B?cnpqQ0lHSWViNzJSUTdyKzdkSFNiU3RXeEVJREw2dU83SDVBOXNkZTU0NXdT?=
 =?utf-8?B?Ly9RdE5ZWkNvNUJtdXorUXZ0TWdyeHh6cW0rZUtqV0xNa25Eakk4TGxkNXRn?=
 =?utf-8?B?M3pqT0lqbXhSUVg3R2FySjVBSzc3VGZXelYvMEZqS0Z4YW5qcm15ODM3WWRN?=
 =?utf-8?B?SXovMy84SUF1aGVrOURVVHRUb1doN2NmdTBSZUlrMUxSZUpZMUFTNDF0TTlR?=
 =?utf-8?B?TjdKSkI5aWY0Q0VQU2EvNStpVmh5ZDJJaWl6ems0ODJoKzhzempzTGFYbzk2?=
 =?utf-8?B?MDFVaVpTc0lxZ1M3dTFpTVh2ZFhtVmw3ZDdGQlJwc0ZjY3daK0tLd05oYXFS?=
 =?utf-8?Q?MdXD0oa7X7Fi7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDc5RjFBaVBUcSswTUR1ZDB2cFhXSWxYeEJiMlpYTGI5NGhxV3JtdE9tbU1w?=
 =?utf-8?B?RGNMalgyREJnblhHdXlOdUhtejRKbUVPc0UxRlFwRFU3RU5PaXQ4aHBRUzlX?=
 =?utf-8?B?b1R3Mjl5Yy9jSXpYZ1BTVUlVdklkdnVQRjFram4yWm9RbllmQS9ma0NIMWY2?=
 =?utf-8?B?eVBGQUYwK0tGYk5VVFZrN1loc29oTmVITG5PdmRTY3RrQ25PVm9iS1YwZGpv?=
 =?utf-8?B?d3R4V3JYVHFmNy9YWFlYNXpXUTVtZzYwcTJ6M1JITlZ4bFROdlY1RThMSjcr?=
 =?utf-8?B?MG92Q0t1dUg1M3B4NXU3TTBhTnVscm9sUmE3NlMvUXp3eEF3ZThnL2UyTEoy?=
 =?utf-8?B?MWlFdnJiS0dOL1EwRVdwR3Z6ZDh3VHpNQXJQb1F4WDBTRXcxRVlldUpiMm5h?=
 =?utf-8?B?R1BTUlg4RkgrWTVqdWNxYTVqOGVFa0ozdHI3akdBWlM0ZjJOZkpYWTFGdytq?=
 =?utf-8?B?YWZGWXpXTWtNZmh0ai9uWW0zRkpzTTQ4bFhkb3piWVBNL01JbDNNQnF0amJD?=
 =?utf-8?B?SmhpNUJpZk1kajhTYkJzSmwwdjhiSHVldEx0NFRGMkxPdUxGMXJLRElGSkhq?=
 =?utf-8?B?Q2puVkpCeldaa2trMFAwWGEwckhZRGhkUVFSdFhwZTlVNHpCUHVCdjZnQVh5?=
 =?utf-8?B?QTc4dm5UeUg1cDZHMlVTaFFGUWsvRHBrU1FaRU1YclEyMWtMclJSMzBxWHFR?=
 =?utf-8?B?cWdvc2MrbG5ubnFqMFNzM1I4c1F5czI3NGdUdzFaWmVic1BkQ1cwbkZ4aElM?=
 =?utf-8?B?Rk50ZVlGWkRBejRBc21qdDJNbWgxTmE2SXUzbG55dkVmQ2JkSmY4MjMyNkF0?=
 =?utf-8?B?WW05a3FsQmFQWTh5UmdqTjZCOFhKS2RyRkMxV05IN0o2VDYzVnV2M0ZMdDVz?=
 =?utf-8?B?RnkyV2JpRVZib1EwTnNLWnpDNU82cS9KQ2p2UmdXTS9yQ0VOWW1IL3hVRmdK?=
 =?utf-8?B?UUd0Vi95VjZYTDAzbzA0NzBVRHNvcnlMVFhmTElrVjRnalZWTFZ4ak1JTzVN?=
 =?utf-8?B?bThpeGlxdytmYjRMUGdtZHl1aDh2MmREWUNNcVRleXV3cXY3c0VyNVlDcTl1?=
 =?utf-8?B?U2RVYnVDM1BwYjRoQXNGWkk0Q1ZId2N6RFJucjVKVGs2ci9hSXBuZHpPY0Vl?=
 =?utf-8?B?bVlCR1psTU5Nb0gvL2NhemR2c25aZFgzc2Q0cE9QVmQwanRkRjE0ZVVSSnZv?=
 =?utf-8?B?U0NGMGhLM25IVVExUGFBMTlyRmUzMHc0eVMrb0FDMnVzT3B1emhQL0Y3OEF1?=
 =?utf-8?B?QlFVeGhtT3dEZkdMMFZEZUFuOXh3Q3RjeXExOEczMUJDVFljQ3d6bTJiNGpP?=
 =?utf-8?B?RGlIV2hTMk8xR3FxaExmMWJ0Z3hkOU1MK0I5OHIrNkx1NzRMR2lEVzZ1K1JD?=
 =?utf-8?B?OGw1aVI3S0FZSVBSTjYzSWpYZ1N4WFc2L1NjM0JZQ1pZMnFBQXREWFlSd0k5?=
 =?utf-8?B?R1h4MjVsWldZWHN6SHhieTVHNG1lV0ZJUW56Vi9oeTVOZy85YWEzd0N2V0ZN?=
 =?utf-8?B?R0sxUm00YzNDZ0loOWRKU1o0ZWhLenIrNHdKbVlrWXM1WVphNWNOd2JQWVFZ?=
 =?utf-8?B?R0xxTGszbjI4aGY1MVRLMmdvWU82N2kvMENlRDVsT2JSUFlYMzYxYkkyQUFI?=
 =?utf-8?B?YWx1TUZGTFcrQTAwTHZ2NzhiTTdVb210TU9ZZU5jT3V2M2kxMTVLNlIrVDlj?=
 =?utf-8?B?T0FaVzliT1F6dXFzTmpxSlNGM3FDd1RmU3VaMi9TdDdLaW0vMnhUcStUb1Er?=
 =?utf-8?B?TWlubVVVaGhEWDFDbHVHNzMwSFo5UDB1OTh6NllpMHIxUGJKclFnNmd1ZlRU?=
 =?utf-8?B?anY3ZHBGTkg2QlZqV3VXR24yK3ZjVFRhUVF6WW1iblQ5emNMSi83UVBHbUdN?=
 =?utf-8?B?ZzRHWGFKNHAvRlVyNVdKZWJFNi9QMVJ4UWpQR1dDRGVialYzV29FcUJaK3g2?=
 =?utf-8?B?YTJlZnd1NElZWDZNM1JPQUR2cDludTY0eFRjMlF1WmZUZEtIc3RsWTVxMEFz?=
 =?utf-8?B?aFRudUcyK01BSkdKZy8zN1ByajdTY0kxMmwweENIanhpemhJWmxDN2Y5N0x1?=
 =?utf-8?B?T0MxelJ4MjBHMVNiZjFTNXd6Y3hqTlhpRVpncmovWnM0RnB2NVMzVjZKVW9J?=
 =?utf-8?Q?9GOE68jPiEA0nnEyOQSmDuoiL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938ba5d3-c0c3-487c-5053-08dd783db8fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:41:05.1427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQ3Cl2p9ylKjW2Ka+z692VFRG9QBztZl6EtSUlfIjw+W8i8hDQIUsM/CT9x7LBrHpiMGwYBKwVT7c3/vjexi3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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

Hello,

On 3/28/25 1:14 PM, Kevin Traynor wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.2.
>
> The planned date for the final release is 14 April.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.2-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Kevin
>
> ---

We ran the following functional tests with Nvidia hardware on v24.11.2-rc1:

- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests 
(https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Functional tests ran on:
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 22.43.2566
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 28.43.2566
- DPU: BlueField-2 / DOCA SW version: 2.10.0 / Firmware: 24.44.1036

Additionally, we ran build tests with multiple configurations on the 
following OS/driver combinations (all passed):
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
- Ubuntu 22.04 with rdma-core master (9e9a957).
- Ubuntu 24.04 with rdma-core v50.0.
- Fedora 41 with rdma-core v51.0.
- Fedora 43 (Rawhide) with rdma-core v56.0.
- OpenSUSE Leap 15.6 with rdma-core v49.1.
- Windows Server 2022 with Clang 16.0.6.

We don't see new issues caused by the changes in this release.

Thanks,
Ali

