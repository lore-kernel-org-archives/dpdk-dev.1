Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C7CC5AD4E
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Aug 2026 19:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65DF340A87;
	Sun,  9 Aug 2026 21:48:59 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by mails.dpdk.org (Postfix) with ESMTP id 18B0A40298;
 Sun,  9 Aug 2026 21:48:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OazVSrms2lZHkOgPnyR8tquMZVVOpYiEvweidNIlZ+N42d5Wh/xaBA9dcG+FW8bjWNOb0xNnJrSA4u6pgb8J4nRWPaNwd5V38r+TjD03BKA8eyuFT2lHCxDUJO8MY7IFh3BRyczpqYF7SvzyK1Y48u1qCjw3FxwTa3W25E/CNBLuMdAqtb40F86rZ7Hrwxh9nxv6PKbZyfFM4rzX2QwsAM1bevJykoVqQmAdyfEqSgMUBQC1e2c2/zhNo77JuptRh+Amr/pXKVKc1VK220xNV7ZLwNvpl7vECizCyCHz324qfapgPLdgRYozhIRjOGVOAI/FjWX6pdMywaCb1Uut7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/kmTqdbghj1hh4MKjufebrt48jBNqXY3ZsANEVTrhw=;
 b=gaGnJxXa255s8YDD5aj6sK3GyM4RrpdDukcN+UbUp2MMXp1dMxX6QueQlENUGO2fCPIMUj2wW99RGjikxypJGJa0R4r1CWNEzIV66YBdOFyu2IqoL/EAlIZrumjko+g79rf3ThobL0DZXS0xIieljPaL/1MDRBPIFH2LS9IW1BI+bDR/88QreBf8we2IGZebmV9A1W/sVvn1MA7bjyxPAxwc7T9cNIs1TnMg8Kb1Fr7Sutgc/dM03Qncq1bxX9/JMsU9yhp39Oh6QBHpQDMhpnpVIO6qNJczT5++chDzM63P91YsFMPkMVZy98SJ3NJHA2Y3xs1TdHQ+opx5/8TU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/kmTqdbghj1hh4MKjufebrt48jBNqXY3ZsANEVTrhw=;
 b=duBQpg9V2dNWq66aYrAko4wpTQ9QXXf2hZ/xi4EEkfChaqMsbC+PzRb7Sm04N4aIxKoJLrFKnWrClDHNxo9Nt+yQj7Khu1+ET/wKhEaDlez4OU/MjmDinlP9XaN8z9UzxPOWy9f/O3sBwfoqa9cl3qpYlPgInWLRruCQKDWgT8290s0dIRLFfH1S1jzlqUULhOP05bQbCSQOj5T9amdM9D5LtI9CGGNeHhjHX4CiQ6rWpWiYjP51EK2VsVpM+sMzXrAUtqKeqZXwCoJKSKffQWT+b6MQIufEsY//Srrdo64QbNnaPdx0rp0Fd/QkfVfxjO1AEyDseGI0guY+feBDxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 19:48:53 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%3]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 19:48:53 +0000
Message-ID: <b085cf21-1188-4cc5-9d72-e9e1c80cbeb7@nvidia.com>
Date: Sun, 9 Aug 2026 22:48:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.7 patches review and test
To: luca.boccassi@gmail.com, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 sbadawi@nvidia.com, waela@nvidia.com, dsosnowski@nvidia.com,
 mkashani@nvidia.com
References: <20260727094306.41797-1-luca.boccassi@gmail.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20260727094306.41797-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::15) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0bf9d3-a97c-43ee-873c-08def64f3e07
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qxszTe/qW+20Swkfhn8Vs8d0E8f5HiYScBfBzBUTJ16MwxeyV+ZcMgnCnZlKouz+i2kZgrLKjiqYy9/sIBE5CCb1iCFnofXLNDIpFhYtjqxhYTGTfDHP0WEZeC+sQZVhCx2LFMdP9m9QmjxLKa86VvZu6Fh/vOYDK9kthMqzmj0YR/hzlQNszByVNoDzy+q95UXGfYMVHqyVPtz6KQcmNUitiE6oycRhNhkDOB9KagHDXwv/17JIJti+uXNj8wwWGDrPIJK0TB/EVpON2I9mhf0ucbd3lyonWUtFj0poYHxOhMUhx26SUx4x1xfhMc0wWG2iDKgRCvGd8FxhGZCjLlI/AUp/uevAtgu/UIf3CSYFrM0HReVtqK+PuNkEYfPjkBoGbLBr9jzhFzO/htpnyEmU2NRdm4zzmtYdamnTkgFHDLi97wKbAtbqvydvg+JHfpzsaQzn+NppukaLx/95L4bqRGifhx+C/JDCO+6GYUdjbPzWOUwi8VYXFiHQ/qxYqqpqkJZ2b2r/nyFsxewSTUOYuPYcAfp0+0y3+Pz01JNP8kFG4d8ayHLBgpYawOz4dHrlraZvkczh/EP/VHjPgbU2EX8WUNr25qiV4zzHjniSBkBtqA/eTDHpPYNIWd2DVE9/viWYhfdQunrmvaMYojA20DAle+eW3uK4yostjpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mnlnbm9NWEM5STVnZmsvdlROMzJCSFJveVMvUFR4WUZWeVNQUkkxa3MwNHJG?=
 =?utf-8?B?Y1dsWUx6YTV3S1FER3A0Zi9SQjRKRXVUZy93V3QraEFvemZsTk1ITlgzZTJq?=
 =?utf-8?B?bVk0SVIzeUY3aHFVSUNyai93K1dnbHFEOHRrZHVuVEFla1JYbGl3T2hSNitl?=
 =?utf-8?B?eHo4MjdESk0reTVpdWNFUHJGV08xK0Fndi9JN3JNVUFnelk1eXhWbCtWcVFq?=
 =?utf-8?B?cVVpek5adm56L010Y1I0Q0ZXZjBVSEpiRXB3ZGYrQUxUNVFheHBib04xMHA4?=
 =?utf-8?B?YnBCNEozNlVuaFVuRUZNMDc5VkpWTWl3VDVnRlpaS3lGRlZmOGZ0U0VBb3Yw?=
 =?utf-8?B?ckRCUzhIRitkV1Bla3dSeVdnREJUM2lUVEF1NHJlblVCTTM3dFBOY1c1aFo1?=
 =?utf-8?B?UWpSa2RCV05mNTZFZFNvcldFaEptdFJiYTZXRGRYNTNiQ1dsZlk2VDdsUmJ6?=
 =?utf-8?B?NUVKYjRRR1BWQ1pRR1RDNzhqU0x5dHZuT3hwdTdVdmo0SDRjRUtXYjV6M3BO?=
 =?utf-8?B?VnZWdU5UOFhabzlTc2N4OW15dDN6NHVLdEtPdG5YWDQyd2k1VHJoWG51dVlQ?=
 =?utf-8?B?R1UvQkdGTHVESnMrbjJTNi96eW04bUEweTNRZmM0VTBHVHR5QXQ5V3ZkVHFi?=
 =?utf-8?B?YnMwZU1nVVlZeTJNaVRiOWhUNi9lbDc1OXBsNDlVM3JYeTdrOUNmV1VqTFZo?=
 =?utf-8?B?b0ttNHZzbXE2bWpJM2txU0pXMmQzRTJmdlprb0QrODMzODZEL0cvcjh2TXRa?=
 =?utf-8?B?S0NqcElXTncvOXlCblAwYnJWVmh3SXVGMklINTFsaktDeU9GSTNETmRCY3N4?=
 =?utf-8?B?NFk4cXJKT2c0dnRLYTZNeGtCa1BEMkxBdEV6bFloWFVLVkxLTmU2Z215b1lz?=
 =?utf-8?B?S0QwSi9WSEpiVllhemxYSFg3Sm51S2xoeEs5NjVoOG9OVHhiM1hwdDhqYmFk?=
 =?utf-8?B?YWN4N2cvTWQ3ZTNDQU5kWWNXMVU2eERldTBpNE1QM0dzMUpPU1BqWDhiOXhK?=
 =?utf-8?B?M0tJelkrMGFhQzNQM0V2QXZDS2pOYzJ4WGphYXo5YkF5SnJQbXVBZEdJeVFS?=
 =?utf-8?B?ZlZaUGhFVitiNVhrSXVJWGFic0lrcFZ6SXg4aXV4ajN5UjdqN0dxZXVsc2FT?=
 =?utf-8?B?b1hHZ1Myd3grZHFpZXMzVFgrNktxa1BmTTNpU2FFYnRhbDFmY21QK0R3SnA4?=
 =?utf-8?B?ZnI1cDlNSm05OUVRTXRJaEJUY3dZbG5URWs2dTl3RkNnUkRoWWJKajk0ZHVK?=
 =?utf-8?B?NWN6dm15M1lXdlJ1UXZvdVdoRWluVnhFQWNkV2pxejdmVFBGN2thK2ZCdVcy?=
 =?utf-8?B?SHF6a0o5L3RnRkErWURpNjF4WVZ4TGtJVXR3OEVscFQ5YnIwVWRGQ3B1TEJM?=
 =?utf-8?B?RXVkeGx1bXB5cWZVTnE3ZE4ra0htQVc2QWpBT2w0MmpSMVNGdjBpeldmVytC?=
 =?utf-8?B?NEhsaFdOUHZkOG44WFJscEhTMHFRY0UrZjl4VWRGUC9RZldDUEMrTU1xb25I?=
 =?utf-8?B?dm13ejRKRzdrMHAwWDZ3L0NpR2QwVjBLd0JyYllnQlpnbFpXbTdVTFBzSFFR?=
 =?utf-8?B?L3pXTzlRQW5vZ1pZL0V4Mm0rdi8yMW1zNWZwK1VVODdVb3plb0d6YnN6QnB4?=
 =?utf-8?B?VGFwMjMvN0ZMVHluNTBTTWU4TDI4UmloNzR2bFcreXNjQlN1elVuaGJYV0NF?=
 =?utf-8?B?YkJhMFRRL1pmQUd6dUhyZHUvT1phcE5TbkFIZGFHaXZNOERwMkUzMi9NWG5F?=
 =?utf-8?B?SE81K1ZaL1VETHZSUmhvOEVCL2tuMGdza0FMN21ULzI1Zks4dW16UTRhK3dh?=
 =?utf-8?B?RE9PNXNPVWN1OGlXYmxYd0VjWW9xbzBUSDlqMXJrK3V4VVJNcmlXRGQ0Z0pK?=
 =?utf-8?B?ZDlwMjRWTS9OTWZiVm0zU2xLSlNKQWJNdHhJcXV6VVdzWlhsSEN2NHFKd1BP?=
 =?utf-8?B?UXN3QTY5MTF3YTBHQjdmOXRJM0NFQW5JNlRId2pXdzNEVjZBZ0VDdDV1K3FD?=
 =?utf-8?B?UmF3RUdNS3prYjF5TGN0WVMvNVNCeTFZQ20yUjRrUUkrNGlHTHh0bkdlOXkz?=
 =?utf-8?B?YXk0UnlyalVFamEvTzJZektiWmR4bktaWnR1Y0hoSHRsdi9sWVpVUk5KZEFT?=
 =?utf-8?B?Sk5sT3NJRHRCamRHOTJ5VkYwakVib0dTRTZyamVWaGQxMVB3REJHMVY3RDV0?=
 =?utf-8?B?VFhkNElUajJYMktRQWNCV04yZ0JKMk53cDhDWGVtVzdnU3l5dzQvbEF0NnFT?=
 =?utf-8?B?KzM5bThFaXUxMlJYTzVua25qRU5lR2ZBOVRVQ0I5WCtXM1RldEpkTW8yeDRP?=
 =?utf-8?B?eDN0bEhKWDVWSEFsYzlWZ3JFYnNqSDVRTjluQ2tuVGZ2dGJoQlVlZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0bf9d3-a97c-43ee-873c-08def64f3e07
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 19:48:53.7998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/nvPuEDUEzlYJwN+tbN22qN2RUUwtiEU2RRBMM6/TE32B9n/F9dAaGe6CirDzSW2rmryL90Q1SQTEA8o1BqBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
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

On 7/27/26 12:43 PM, luca.boccassi@gmail.com wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.7.
>
> The planned date for the final release is 2026/08/10.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.7-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Luca Boccassi
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware on 
v24.11.7-rc1 (with 890094995dcaa0 ("net/mlx5: fix item prepending 
conditions") applied):
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
MLNX_OFED_LINUX-24.10-5.1.6.1 / Firmware: 22.43.8016
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-5.1.6.1 / Firmware: 28.43.8016
- DPU: BlueField-2 / DOCA SW version: 2.9.5 / Firmware: 24.43.8016

We don't see new issues blocking this release.

Thanks,
Ali

