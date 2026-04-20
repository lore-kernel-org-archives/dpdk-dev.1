Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2FAF5A8AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 19:37:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1317F402A2;
	Mon, 20 Apr 2026 21:37:31 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by mails.dpdk.org (Postfix) with ESMTP id B61264028D;
 Mon, 20 Apr 2026 21:37:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPVNHV6cNMTTleFMn50KV4GHqvSIW/ZC3JAhdNVEQHs26oN/NZ/Wcsyx9BWI93hVOHMkTIBRoQlKIaEZ+Zl+rx94aXv1JoC/Ub2eqtVywMatuFUoFApgP478RZL1+xNfMJkRYnFs1l9HjZSwhe6N5yq1vphRgb0+sX/ZCHPEkKCf/GmquAR+e1eXTeR3yScYWTwyn2hZoJoHFD34evnr59ddRaJAvRYRBMLSd8OOWAn5jhNVZEQzCLyzLDnZRk84gi8AHf7Y+Tr9BeH/C1V/Jqo9qeeuEtpwxsyJWFQPYC3Pk73jQnRK2kE2+hXjjyVViumm/mZ/YU+jrjush3C0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc0k2SwTGuW7cqGpb3J3u0t7sFhsUTnPwwaQYliWG0Y=;
 b=FemyZZ19eQywn0aGn++WIJikWCwDwsL4Tps/ieOSMXzbnx6uVDC7JfCRowBzoZkt+uVOBhUhUooNfTUC9ZfQPGMB9F0eRyLZ0MZrnHcBVkh1ZYCxm8dBesgK8DYsWZA0GF0DgAa3DXvYzLQIsWrtYrV290Ibi37tSjqBRw7ZbCon+9dJRIyrqK97ND1eHMVLCuQooYe3W6iYJFpKlXusbFqa2W9cRPlJbIQWg0KE+nyyp3r+5nwP5oYAUs8ZNWXaMX/AErQ09e3o0heN0foifcyrNepE/j76HsGOc810BVkaEvMcLTYlgVra2rQdWxM9VtHuyYEtfWZGjN2Obk/7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc0k2SwTGuW7cqGpb3J3u0t7sFhsUTnPwwaQYliWG0Y=;
 b=mO2iIDvH7RKx4mZi9PsjQJVgcLK12xJ1D9JKFkrGfPt/rxjMwcKL34BxzVpbxgXTNA/md/aRcOMhkBpjUQS8FpnnD13VeIWknlpz+XpUcAK/FtfZuT1MRjyKk6XiXeCUCSkXxNJe7CsIbOJBt8HeaSXGvL4HhCv+/jemFOlFf/9Vl9B9DUf6GcxDK/JWQdNJfgGfI+N6WOh4mFU0vMqpkmxe7ESiO5wqXzVTMI69BKWyk7+ovZ5LIj9XnD/TjSq7tA5N8NCt3YmbpRQYRRb3ezal8Oz5pW10FrzopdMZBJmQTOi/Am7l/6nICafIzEt9V7eJUzta4RphqIEBLrDxtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 19:37:24 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%3]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 19:37:24 +0000
Message-ID: <9beb13d5-8072-4b34-8db9-2c472d6d6803@nvidia.com>
Date: Mon, 20 Apr 2026 22:37:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.1 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 benjamin.walker@intel.com, David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, qian.q.xu@intel.com,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 yuan.peng@intel.com, zhaoyan.chen@intel.com,
 Shani Peretz <shperetz@nvidia.com>
References: <20260402164454.669125-1-ktraynor@redhat.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20260402164454.669125-1-ktraynor@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: fb41ff7f-f45e-4928-bb96-08de9f143f3a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: NZw9scU46og4EryBTDEtOAU9t03oYv7O/1C0uPfBMJWQKNzKse9buVNQNBFRaOmXVDVuBW3pK1VY6WER1u0i7EczvZb8SLRPNUA3mWplkPnJ2B1YQTbF3U3IU7QHXmFlmu3+o2nTGJQtf1gOW41Anba30JF88+o/IgH38OJbBwAppuDP6s3sUXeBuygS/YUEAWT19llgTG0a+60K3YSX3p+4HEtoV+Wvq8yHi8vMqY7scKBt5GXx1ehtqT9ZmyKWAoju8r32pTWGuZgPrQS96N/qNKolahNkoZ956Uvvw0VV8vmQmXmETKko0mz5+hL3fmRVcM6MwORclVhX/6vqDppRAPEU0QuAZIC6zk2bSfMFLytv+VPM01xmoxkQQcSFjWEw7+XctThxn872sd43CDi2TqrIvsTBgV7efrg7GwPhRYmvdJf87BQ8NCrZgtVueglzs+Dcjofct6+X4sbdqNYHstMK9XYS1J2AZDqlXJR7prAxPVATPzpfVmzTDuCV6s1ayxgtL71L/ZtuPM41H/ZaT9Q2YFvt6GNcE7M0NkUPs1M66PrKiI/oRYl4/UlfS6JT2TMQyKRqobOTQ+DFf/spij7ogJ2ITNPabRX4HSmKw+a2f7ykoXfhT/baaXx9b37FJxFLh7yiD70CzxlJ7pyfVxoFn3qu+9UCSOf8/+7Rs6JrvSJKixQlHNzJG5lFJXjoSOfMPVU/KazyJzwIZnKC/oiKs2GZa6e931PSfGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3h3VUVmK1Q4ZWd4czZhVWxueEJsRnVNMzgvTmRjZWhlK01EYWpQUmowNWZY?=
 =?utf-8?B?ODF3ODh1UUpGRlRUU2dpV3M4OFdha04rQUpxMUlpak14RXcwYTQ4UjRsTDho?=
 =?utf-8?B?UGY5bm9Jb0FLWlE5Y0hNMHN0Y3dKMXhHN3N3STFXdlJxdDNUK2hNVUZEM09M?=
 =?utf-8?B?YyszMnJvZ3NhUzFWMVorL1BGTUNSdHU2L0hBVWw4ak1GdkdENlJQOUtvRFlh?=
 =?utf-8?B?Ym5KZmNRNzZFRUV3SHcvc3ZQL2VNT21QVUJsZXdyZHpBTUpOT0pIT1dlY2Zl?=
 =?utf-8?B?d2gzd0lBaXNvenpLQ05oRE5DQlI4dkdaZ2Rzc0RUZkk2dlhOb3lPRDVhZ0Zr?=
 =?utf-8?B?Q0dnMzFVYVJrT2x2bWI3bjM1WmxGamtBcmpKMlRJQU82NGFpdnJ2K3dTUXFG?=
 =?utf-8?B?RkJWbFVhejBwSERVY3BhZSt2NkppMWpROXpWWTJPejJaSjZYeElpOTJQSGNV?=
 =?utf-8?B?dVVYS0JleUc4S1E5S3N0ejBKV2hWTCsxdEYrQ2g0eTMrVzcycGlZSWdaR2F2?=
 =?utf-8?B?ZnRtbW4wM21OSTBXazRoeXU3VitCdmhMWVRpS09vRmpmWitvcXdvNnZYSEJI?=
 =?utf-8?B?eXd0NEtIUXdlUVd3TEhITndrVzdxVm1Mb3d4ZFBUSnFSeHFyOG1BN2RqOW1Z?=
 =?utf-8?B?T3UzMlI0anFxallmU3c3bDdRWXBZUHUraWROMCtaRC9FdE5VOHFjK3l2dndS?=
 =?utf-8?B?VzdGQlBSRGlnd2dFL29PUnFNSFRkTmkwdndLNzJXN3lWNGlCUE1OeEtlUll3?=
 =?utf-8?B?bGdVbVlta0NveVVpNmFiaDdURGwzTVU2d2RDMVc4YzBVb2FnQnl5b2ZjWVN0?=
 =?utf-8?B?K0VCc1JiYUh1Nmgwemhjc2p4NGJlUGxpNVIvVjFidUc0YStPR2ZXLzBTQjNz?=
 =?utf-8?B?MnNkMEhKdjlYdXpqSDdCaUZBOEdJbFdYZGFQcnlFSG1Fd214UXYxMUcxS1JU?=
 =?utf-8?B?b2N0T0lUU05VdkxGRHlXcVhjQW1kTG5kV2oyTU9ISHFJM2RzMHJBSk1mTWg0?=
 =?utf-8?B?T3ZWQzc0UWNwQ1VLcjN3SmdwVTBjbm8wNDdFVjFLTVIyTmZZOElKSFI3N0VW?=
 =?utf-8?B?RW5Va2dsbTk0UHZrdTZkUkxsM1dwM0xZZSsrazA1M3dkSFVJNTAzNy95VTN2?=
 =?utf-8?B?a3hsWFRkR0k0dU5ieHY1WElSaUUrVVhUNTFtYzRoc1QzR3UwWVBzRGt1c1F5?=
 =?utf-8?B?ZkwrK3Bjc0RZMzg3SlF5QUV5NGVMYzd6NlVPUUQ3Q3Q2Z2s0T1pvbjBpWmUz?=
 =?utf-8?B?MDQwRXI3aVZKYmswSnJKK212OXVtVkJIMzFZOU1xNFcyMTBEaHlHSXNFSXFW?=
 =?utf-8?B?VmFFSmxlWStJNXkzUE5FSnhPL2VoSGpLUi9aWVo0YlJOaVdwMTFWY2tPN1RD?=
 =?utf-8?B?ZDNYNHd2OXNzZWRjU3J0SnNneEU2Snlhc1VVWTFFT294cGJxV0tTQWVXK1BG?=
 =?utf-8?B?NmhaSzNIbDRNOWN2bU8xeFZNK3A1TVJrVGMzd2RUckg0ZVdSM2ZkeXdGc056?=
 =?utf-8?B?d3dYUTRsSWk5aEdyMklrK2Y1T0U0SW0rdDFJTjZtd212TDYxOXVpblIwMnNw?=
 =?utf-8?B?V005aSt1di82ckFOcTVOekJKQitjanJaVHBNS3VhOHplZkQ2QmNwOTVua3Qy?=
 =?utf-8?B?bHR1Q09wVXpUQmtTVVZtdklPZW9ISVF1MXhTNUpKcXd0bVYzNEZVTW9VOXJy?=
 =?utf-8?B?QWR4V2dSaGphZnZZK3NkM3pPWEhKbGpoZjB0aUp5U1o4K0R5ODdZUUVCbFZp?=
 =?utf-8?B?c2wrRzhjWFl1QjNZa1dsSUVxeXk0dzhHV3hBakU3UjZ3UkRXZlpwbnhRZFdE?=
 =?utf-8?B?NlhtdG90ZTcza2ZuMkU3Y2czd1Q0aEk5UHNCNVlaanRiMjZIR3lGTnRNc08v?=
 =?utf-8?B?UDY2a0tzTWFPd1NRa244KzhvQ01yNEFjd0hZK0tVUVhBVDhwWUFIQnhuZUFh?=
 =?utf-8?B?NmhVZ3p0U3daZEhYeFFySlVoYlJYZmxRek9yNlVyUzRYTllSQnU0UDhBZHRN?=
 =?utf-8?B?TDQ0bE05QzlvZUd2WXlqUklCb0lYL1dQUVhXSG5GeUpaUy9UK0Y3UWZsZWRv?=
 =?utf-8?B?NmdERmEyVDBTS0JwVE1tb2JrenFIWENUd2J0MWRaejlGL2R1UktwcTc2MzBw?=
 =?utf-8?B?a0NaR09ndHJoR1IrTklDQlQvZnhmT2hDaGJwYzk0T3VEeG5ic0tRMGYrNGRn?=
 =?utf-8?B?bHZVcEViSzNZWWR3em04SFBIQmd2OE1lQ0I0eEVDZHcxd2JNWXQwM0dNNDRj?=
 =?utf-8?B?dmI4ZjZTYWVMdncxa3NMcUh0c0g3eGJqRVI4SEJBWnM5QnVjbmtrWkcwT1o1?=
 =?utf-8?B?ZGU3UGRwUktETzIzWEpvVmE4TCtKbkRFTWR4aFBLMFNnWDQvakdMZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb41ff7f-f45e-4928-bb96-08de9f143f3a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:37:24.5772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQsyv1DIrQOqHUOgX/Lpvbou4MmoecdSMwjiFwOYnfJzIrXfrtOi22GPsqySFbcGhUPBwuMw2Oy6SQTiFYDTPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
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


On 4/2/26 7:44 PM, Kevin Traynor wrote:
> Hi all,
>
> Here is a list of patches targeted for stable release 25.11.1.
>
> The planned date for the final release is 21st April 2026.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.1-rc1
>
> These patches are located at branch 25.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Kevin
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware:

- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests (See https://doc.dpdk.org/guides/nics/mlx5.html for 
supported features)
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

We ran our testing with Shani's backport for 9ec0c6bda04a ("net/mlx5: 
add RSS TIR registration API") on top of  v25.11.1-rc1. Environments:
- NIC: ConnectX-7 / OS: Ubuntu 24.04 / Driver: DOCA-Host 3.3.0-088000 / 
Firmware: 28.48.1000
- DPU: BlueField-3 / OS: Ubuntu 24.04 | DOCA SW version: 3.3.0 / 
Firmware: 24.48.1000

We have not identified any new issues caused by changes in this release; 
however, we are still investigating test failures that are suspected to 
be related to environment changes.

Thanks,
Ali
