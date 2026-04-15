Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0DBF428CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 19:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9203C402EA;
	Wed, 15 Apr 2026 21:59:01 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by mails.dpdk.org (Postfix) with ESMTP id 29913402D7;
 Wed, 15 Apr 2026 21:59:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHmm64/9RaxJ5LWahAHtohyGqTmt2JvsmHS+TP8VKm8U9RCBps+iVUFOZukusVhSr43zSGFrxoGNUD1x8dyQLckWkshPRyiOcLBUkTMPjJ+yfQoIcsX9PiDl/1l+bu4NU80tCEMX7V+9B8pKcZfaXqyKN5/WvxUT2xuaamu+5hq+lKq2HOsFSEJxS1tggFlhf3W90saU9Jj0in0BBNCAOVxrYNGsFMd7Sv3s9JExqaWgwfxxmYRqMVEFa3w1sghg10TlZx8KoxneyEYYMy/t4rz35maxEmNpNONI9BJ7Dx8rotN9IhXxjzh3DguZ7I34G4vnY2boiqf0DyAgXDs79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+Y9yb9owtZm2V2pv3dGOvMJyM0BfrEIlgosWi2VquE=;
 b=WZPK11RUCdUQeUkecjTOT95MUrjfxMfmiu8xN02yhUMAODtCK23xsL18nLypcTlpv+rCfUAC8drcMtoohgD4RfGhNXPC3sXj4VteUenyoyOSGkBTgtmtQiPIYg6jMaSTjyP9GrC9G5d1aPJ00ANwhr9TJMwEjcT9jhvy+7oYd6TbU8xISFnqDYcd4KlZ+upnVSQt/pULEINhIM+eUS9sEK2FxHwxsG4jFTlxW6jMtfmnrUBKBr/N0X08ijrPMDYtvE7VBRdcbniiZVvEHVfe9gBl/kLe9oXG3/2ItJdi2MScfsnDMrNuV2g0fx6ApQMPS4BLBC+q95YFYyjTFaIECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Y9yb9owtZm2V2pv3dGOvMJyM0BfrEIlgosWi2VquE=;
 b=qGzXgk9MG3bLjJI8F0Ct6VGmONSyPgCBjAZzTKA+AyBQxlG4G/BnfIjNHVlf5Hrfh18gzAs3hf8hKVSAdGE/YVZX/cKo6xsdCs6iKfgr+BKktwb7bMpGUSJE9Mcgbo9tmMs52o2UqV8xVe9gciz96QnprqTFoJLUt2+1f0dbbqP8viVD/fOGEK5RK8QhawNesg94EKHloFsEtAT7waLIavhSXRwW0X/bxSvq0e02xL/zW2OhKaMItdhWPBNk87G0bLCUjlxZrqXZEuHDd+KfZWm7mUVx3yOP4BwHJ2S+0HEaRF6cQg7G9biCiIK8AIDx9g620w72CWr8h4Kd/wtoTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 19:58:54 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 19:58:54 +0000
Message-ID: <cf6b2387-dec2-46b7-a1e7-5e09c8b7bae7@nvidia.com>
Date: Wed, 15 Apr 2026 22:58:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.5 patches review and test
To: luca.boccassi@gmail.com, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>
References: <20260404095902.856502-1-luca.boccassi@gmail.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20260404095902.856502-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc3b0a5-7ff3-482e-d48c-08de9b296c14
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cEmm20WyfDbLf8ir3E28EJX7G/npYgUgZWHV4uJrlNhfLYlEDFnMn3stw+1dxFtfmrDgOIz4iBJdHot7MSQpmmV7GTwKdpVjhD+8p6FF94qJ+0CgkdhOKugdzIawN53ve2mqNvC9ki3sMELjLeQf++ko6XmYNYF6KDO8cfTR7qoinko5axG+IdXESEXYCIbjRcmCrrMuRcTwyRr3PxjocDUv4FDEltRXSfuE3Ll1kff1WuOBaPnpJOath1L6XjkOFCgsAO5fjrz70uGGykdcIguZ6ZXfqqZAVqlKapzSGqbyJ/zv5mRBtSI/CVOag9TWQ3mwxo8HriYuxe/PoH0PvI55CK5SZb6KJI70ZCc4kN9HEksT4aJcgFIyfVcLm7pIgcF7q1831+jnzuDltON7JEllLA3amLiwBAV3eltY7/z07A9p0LO5/iSVjZtDlNrq4MroUJzlzinpF0GBZeShhkEzp/2jUYXJiOkt93RKdYs9HM+eixa7WN4XZknC9IhA5Czm+T9JhZS3mWa6xRoJEaBwB6EJhaxlXXNDgCMP0WfJom/qal6+e5SI/8LfaOMz36Yo34wCSJbPpe3pwyKZfu8TXs8jV5sdsplSsstH4cXlld3cs/87Ub38GGxaL62M+u/SgUA+2pi/EloRgmjtfNCP0YXFSJZgvTVey9zJC8+fbb7vKF1fUDcMyv6J85QXck8e7l/FqPp7gnuEJIyVcxUJfuvPXpA4IzIa8m2dS8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0d1Y1N1N0Z6WTllMFNwQ0Vvb3BQNkhrNlh3RWRyN1lVSUQ0eGVQL0I4aHNm?=
 =?utf-8?B?VE5JRExYdnZCWWhkTzRPTTM0OE8wSWh0amZQR2pvMjVxaEpuTDNMWkVIaU43?=
 =?utf-8?B?YkpmNG9WcnQ4SitZYjIyN0E1blBQZnI0SzhGbS9zc2RzdmtRdXk0V2FxZEsx?=
 =?utf-8?B?bnhHQ2E1MEp4UjhFcEI2cUxkb3pMZm1nMi8xcDlZNkc0bG11ZUlEekQ0bXBB?=
 =?utf-8?B?cThULzNvM1U5b3NuRVArcXN6eFdSZVVtVnpUdXoxRkREWlZ2c25zc2xMQlZY?=
 =?utf-8?B?S05RaTEwdkJrU3U5WXFWQ3pvYkEyQzN2dlpRRGlleUVKbjZmMXRVSEdwemJk?=
 =?utf-8?B?Tk5LaVIzaWw3RmY5YmRySmtITnpXdmRxcTNacVRKSnFsTEZYVWlrSThoNE4z?=
 =?utf-8?B?RlVVZUZubVhERWtkOVA0R2xudDl6U1JBb0xPS1BYM0tvSktMRTNRMCtzaTNY?=
 =?utf-8?B?T2lKMDNTYzRBNlFndHlvd1NGVlFDK0pjSFZ3OHI5ZkN4MXh6SGUvdENRLzV5?=
 =?utf-8?B?anZheW9rTmQvNEYyRjdsZDY0OXJLY1VDbXBrMHJPaCtuS2tld1loMTllOTN4?=
 =?utf-8?B?K3RqdWcvV2NoZmpIbXBMWC9RZ3M2T0wyQ2ZFMmxxVW82SXhYQS9Wb3p2ZHBH?=
 =?utf-8?B?MkFTVlhjYzRzVFdEWWluem9FUjUwYU1wTFE1S3cwMHpaSjJVMlpoNGxCdjJa?=
 =?utf-8?B?RmxnU0NGRGZhOUtIZE5wYXN1SGQ3eEh1VkxMSm5VRVFSeWFuNHBhdFpMc3Fp?=
 =?utf-8?B?aGJxQituZW5ZUzQ5TTNITmQ2aXpKckpaWnpTRFNQVTlMSFdHNEtQQlVxYXF0?=
 =?utf-8?B?WnNqU2ozR2RSdGcxOVNhRklQcXdMaWU1MUFGQVQ3Sk1Xd3pMWHFOMUREMktP?=
 =?utf-8?B?bklGZTFwUFpBYURvb2lNYXZvc2hMWG9qT0loYnlsRk8rZWlqNVRCNTdVVlFY?=
 =?utf-8?B?d3QyRXI1bzR2dm5RL1AzdHpBWERieDc4cTBwbzE5a1kvZWRJRU84N1J4ZU9I?=
 =?utf-8?B?RGFvRnUrcVNOdUI2WDlyZ1lpNW5IemZpL09lZGF3T1FkdU1OOGZCT1oyaFlV?=
 =?utf-8?B?Q2R5T3JZaVdsVHFmL3o1UHpGTzVmUTMxS2ZKeFhvY3VqTG1VYk96YWRRalFW?=
 =?utf-8?B?ejE1L0x1RFRWSldVbEdnYlhsSk5NdUgzckNYcmkvakF0TmVSdlkzTFdhL2Jt?=
 =?utf-8?B?YWxkcmQ5QzBRZ0lORTRZQ0Qzb3RUN2xYYUVFYlVEYlhoWkVWV3Y3ZkNWNHhV?=
 =?utf-8?B?MVd5MHR1UVVZU1JNVDJYei8xdUpRNUgxdEllZnNYV01sMWVNckh4cUVYY3Vx?=
 =?utf-8?B?OWtwKzhGbzRMUEI4ZUg0UG1USXZFNEVvYW1rcDUxUDJoOWRmUGYzeWEzYS9S?=
 =?utf-8?B?SkJuUkFpcjhVeFh0dW8vNnZHQk9ic1RpWGcrWFhlYm5qUUl4aEZUWGpjSGJ0?=
 =?utf-8?B?UFFZRFNLTEl2d1pCMmxXc2o4TWc5a3IrZ0xNZ3NCT1FyVUZ6cUg3eTQ5ZjNt?=
 =?utf-8?B?MDVGc2FOTnJ6aEF0d0x6U0YxVk8wYXNscFFNbmRJV2drajRsbzZ6OXRQM1ln?=
 =?utf-8?B?WGJhcmNseUl6VytDOGgvOXVHMzNudTgvTHVNakMxRFkzayt1WEtlYTR1dHJr?=
 =?utf-8?B?RnV2UWp4TGhBMjhzdFpEaVY1cjRremlSeDJZN3ZKeVY2S0E5RnJmTzQ2VHdj?=
 =?utf-8?B?bW9sUzFBeHYwOG0xcnptbTFyaVJXRnp3WWVrYTlmaTBzRXRBNTZucXFpRXhB?=
 =?utf-8?B?RHdjYldpS1c4ZDhqMjBMMnJvUWgybTRMZWpybDVtVVRZOGdNUEJaT0V5WEpm?=
 =?utf-8?B?aUhzNzhXUWlBbG8zMU1CNHRZSGFENDFmQ0lBRWlmVVhvZlNEeHpvKzM3NUVo?=
 =?utf-8?B?RTRsdzhlSFJIdHk2eHRaMFhMbFE0RGRyM3NmVTd1NFBTcVliZUJHNDM0Ykxj?=
 =?utf-8?B?TWJFdlVEVW5BeVdueXNMN0ZzVXZhUkRTdHk2a3U1Q2lCZFRkb0JTazBHN3Vq?=
 =?utf-8?B?ZE1TTFhOU29ROWRNVnUveW0yWWdRS0kvaWZJenZPemhBVm9tWnVnUTZiMVY3?=
 =?utf-8?B?dFY4SG44MVRKam1jMzhlRTIwODc3SERWejNRRXNEM0RHMmpNWmtPMHAxU1lq?=
 =?utf-8?B?cFMweWtiOThxcjlDMi9PaVliRG12Z0ZVTEhhTGxTSDBuSFhzTVRtRE0vZWlq?=
 =?utf-8?B?VHFwVi9BWXIxblRrcE5JM3QxYWN6c1BmYUlRM2NCZDZqNERLVVlHaFZtTE9z?=
 =?utf-8?B?dDJwMDJzT1hYRDZhUEt1MUZhZm5keGt1eW9oRytxSGYxNkU2eEJVWmRPNGRL?=
 =?utf-8?B?Wjg1bjVjTS90ZDJoSy9mYTVZRGIxRVdjNk41Z0dKcnV4WDlVVlpHUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc3b0a5-7ff3-482e-d48c-08de9b296c14
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 19:58:54.4842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2nLHmwNLXUBds6fDTJXqqM9/SbdgY8K1f/A3+ZtgdYQGvogOU+PdYkop9tmtKG+/ZvrznHMV/0w8YdTkj7O9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
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

On 4/4/26 12:58 PM, luca.boccassi@gmail.com wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.5.
>
> The planned date for the final release is April 16th.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.5-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Luca Boccassi

Hello Luca,

Apologies for the delayed report and thank you for your patience,

We ran the following functional tests with Nvidia hardware on v24.11.5-rc1:
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

Functional tests ran on the following environments:

- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-4.1.4.0 / Firmware: 22.43.4100
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-4.1.4.0 / Firmware: 28.43.4100
- DPU: BlueField-2 / DOCA SW version: 2.9.4 / Firmware: 24.43.4100

We did not find issues caused by changes in this release.

Regards,
Ali

