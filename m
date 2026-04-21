Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D4BF8FA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 640A9402EA;
	Tue, 21 Apr 2026 14:25:01 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by mails.dpdk.org (Postfix) with ESMTP id 19B444027C;
 Tue, 21 Apr 2026 14:24:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5xAHsgrrW6WzXFhHkgJvV4+tO83EVIw2tOAWnaw7mw/d/TiEr76Xv0Yiz0R5W4uPDjyaEyAAepbD4ttR6YstrSw2LBXOisuANIAQZF8mMxYuIO/wkAy7N93CjRjt76dCt0QXqYVzW/WUml6UWVK9t42mp/ySWFq41u+npteYbAaxhqK7Bh9kqheDlSHSuS/4uxMWBPb5CZnQd5aVSGN8p2Janwro0ScGWUYei7ZOHwuDwfd7s8VvDXFvp7FDMmwL6i7+soeJRXhd82PUKaTllMNfzc9q7Wsd2KopBFzXAZz1ipWAJw30oiCiL1+KEuKMAi+SKqlRNDzGVqTshsrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuOApRJe3MnYj6Nc5lhmleFHXARJlpLIVgtsg97I+Ls=;
 b=dOmHxXa2YaPvZhmy5RYayDzQCxpFZSemHCI3DSmzAlyOCcEF1BWIAeeR4UeGbO35AJNfUjHn9XjNxa5MsPdBZmH3FHBgxG6r4yU0PotGHfpNaZ++ZJsEx/M6Deia5X52pBdLg0jnFLFIe6zKjNQA7YGvd8KkoWynL9vhdRIpg9tGgtw6ZXuCnbaYDuFBOM7eqRhUf+OhvMkxjxIrhSCoUl6H4bsDc/ZMCc+G4B0A1USUhmYx1vliVIFg3IT/hs4ba/uPQlAQy3eX9qXy3UNudYQXEYHgIjbcfZvcRk6YbTqKmOrnQvXKqWHBP3NdhNVb6CZnmut8JWmPMfbgpYXLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuOApRJe3MnYj6Nc5lhmleFHXARJlpLIVgtsg97I+Ls=;
 b=J9yXO+0iXIR+8f3fBOoK7huMKH91D6Bi2q5379HBjhSPX3w8wkmsENEUfR4R8GDU3iXctwynRxpr2p1xljW6CM67mOBAYDIC1Xwpqm9jRczhPrcCJzHgFnYpktHBchwBMHHkF1NtTqQr+WarXFnijcRSWBkaZ6bf3B5ANRpoRuhDxg7gbQSQ/laTQLgdjLFfn20la5m2ssEna/m8NK22Vf8/xvillyQISKdj6r3PQW9CUKBQDMZ8I0okKxRofuA/gTg9zBP+NR9NvJdNF7fwmR2dFrzbhq9CU+7uYajYiJ4JgFK38+RMuu3J313QPTeeljENP6wDNQFCt01OPYat7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 12:24:55 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 12:24:55 +0000
Message-ID: <74d53697-f697-4dbd-813d-0d9a14bc42f7@nvidia.com>
Date: Tue, 21 Apr 2026 15:24:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.1 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 benjamin.walker@intel.com, David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, qian.q.xu@intel.com,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 yuan.peng@intel.com, zhaoyan.chen@intel.com,
 Shani Peretz <shperetz@nvidia.com>
References: <20260402164454.669125-1-ktraynor@redhat.com>
 <9beb13d5-8072-4b34-8db9-2c472d6d6803@nvidia.com>
 <e3b57004-9f21-480f-97f2-13c305e25547@redhat.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <e3b57004-9f21-480f-97f2-13c305e25547@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1101fd-a19f-4789-22e2-08de9fa0fea6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MDRDA5h/V2KiuTFSlRtncC2UNIdr3FQOiIKnOKF201q/d2fkXsjm4oFXuj7vRH3NT9bLxV8/szpH1IBOEsqwKWSgczwfyXotnPDn3xTF3OXKUoLB8yF7n0sNYbW5Btwjiso+8TTNR+eNkKUHGBUspnGryi7NgRyy+9XS2OCi+sN5dpEMOMwh1OezS3we0KVqGv65aXXYUZH5DEf5AUvtIV+/MJbHq0y/9XBKN9ARxAMaUulNu56pvkqeMn2ksQuC/OL+adSJuPvmf4w/EXwcOkoRm4trSE2/6cVJOa7h7N2cIYC4bVewC8ybtehIjalmZwFq9Fg28qrfL43l4qELS/8co4/P6/fnePtziL2mjNAG62WTxQmE+uXJYfxg96iEOEPc7kfrlWuohNMcXJMfuWOrPAUB7rdyybO3N8xMaBtjkz88PDlSpkLdsy89xHk8oo4yz6MyJ7A02VRgGhE3EhcpNbY3lppjq37torG2yaQyJtaNC1t06RXwrB1XT6Cy0gsqw+kmiYi16Oxm2WhjUQtrRp0oJzeYE4dwM6HheuejCeLUFdaK5H91RB1FqJe8NIOu2X1VJT/4Aa5SEjuu6pIWNNqWyLFYEIUqwyARsjUYgGZETfKB9KxW7k7sF7YwEJkqsV7WeZi5mZkrlPI3aVAZNyQsYJquumexbMKWQRRAxxCpVJnFad8ZbX3jIjROttDujJlF4MSwTdRZIrd4jBaIDbq813px8+eiA9m97HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVljeWRtdmhTNkZGMmhnME8yU3ROREI4RWlsZ3BrQ3BpTmJiSS9TVnR3RkFV?=
 =?utf-8?B?NVRYKzAyTTNodXFIQzllMUlCdkxJWk1qdS9BMHNmdHJNbjgyUExiZTZMem1w?=
 =?utf-8?B?b1BlZmgwUGI3R1VpZzRWWjlLWldzUEkrVzMzSUFCS25MTjNlb0RINDNybFVE?=
 =?utf-8?B?c09oekd3WEU1TCtjU2hXQ1dqT2Jxb2lFZVlqVkQ1cUliZGt6OVNhV3Z4WVlF?=
 =?utf-8?B?bGFOKzRLR01uaFFjTkRQMTJhbys1ZGs1NzBGT1dNb2xGRXZrNmJZTmxKcDRY?=
 =?utf-8?B?RXdNbVdKRTMvQ2xJc1NGR0t0bTFUVWFiTnBDWmVRZUw5Z0RkbkJqQS9ic2pZ?=
 =?utf-8?B?eGszeDJNeUIrcDN5R2tOY2VhZHV0c0Q0K3ZCUlNIRUN6dm92Tyt3dWI1bFlE?=
 =?utf-8?B?VTdQOXFHNjZzVk9rWU1LbXVZeFprZ2pEVk1wRkxlek1qcnhMNCtVMUQxcXNU?=
 =?utf-8?B?VlZIMXZjMjEycHJ3MWZYdS9UQmZjdlJpdURFUTAvSGhhVkQ0UzIrK29JZ2sz?=
 =?utf-8?B?a0NTUkhWcDEwZmpzcDhWZG5Rc3ZpdXhyTzVCTE9ScldqVTU2UmNxaDhNeE02?=
 =?utf-8?B?NGRGVEFqUmFEM0FjbTlxaDFIZ2QxTGJzclpUVU9FeW93eVBGWTExZk9IOG9Y?=
 =?utf-8?B?THlsam9OME5qYVZTKzNYVGJOSzB5WFMxck5OOW5SR1hKY0wzcU0xSzNjaHhy?=
 =?utf-8?B?bHdsdjM4cEJkRHZzWlVaMWpOTGlJbDVqWWNSNlBoajJ5bXZrcll2UUtNTytq?=
 =?utf-8?B?UmRGdnJXVHMyeFVxcVM0anlzRGI3eFdRd2U1eDMwc1EweFJ5bnNMVzllaTdn?=
 =?utf-8?B?TmZzNURlOStKdUlkK3RuSHZtZUVsQVNuRHNBTGg2d2s1YnhIbTFHNU52RGRy?=
 =?utf-8?B?Uy9iZFA3YVh0RDhDVlVyc2lOVkNVdWd5TlRiOHR1OUF3U3lJQkoxai9jU3py?=
 =?utf-8?B?K2FDVGpueDlKMzBoNE1TbzF5bG5QS1lrT2FyZ0Y0NVRQdkRJZUN2NEZLb0lF?=
 =?utf-8?B?djVaNno0OHpGdTNCNTNPU3JORGxmN0hSNEs5YUt6TXdGR3Q0K2h5SGdocmVj?=
 =?utf-8?B?UVdPeFFCTERBODE1RE1EU2xGZFZQS203em1YWE5DK3R2MG5VWnlkUTdwTUd0?=
 =?utf-8?B?ZTFSb1hndUd3TDFJeFloVW4xL2x2Q3d5Z1EwL1pmTkJ3ZEp0bDk5eStRN0Zv?=
 =?utf-8?B?V2FtMTZmQVdtaE9Wbi94aURmWk02a1ZoblRieFQ4RFlGekdKRVdqbWlpZ3R4?=
 =?utf-8?B?QjBNbHRNOXMzVnRJUnZQN3pJNG9yMlFHOWF2cXZXb3pTbjMzY3VJSTBqSElU?=
 =?utf-8?B?YVZKUzdZamFkTWVhYzN6Wm5tNGNLd2UyeFF4bm9DN0VhQVNzMTVncW04MEl2?=
 =?utf-8?B?MUdjaWordFR1alM4SDNuZ2o5YnpmVlBJK3p5ZzQ3ME5ES2JKYUY3VXhoazRU?=
 =?utf-8?B?ZWVCcDdDV3dDYlM0NE1zZUhPR2F6Sm9IemxiYWwxTFdoaFRjQTRPMnB4RGtv?=
 =?utf-8?B?K2h2MTUrdHpMME5HVjBOeVNoL2xpSHN5aGJyOHpGd0oyOGhlQUgwMG04d1o4?=
 =?utf-8?B?TU96eXBMZ0ZJd293TU5tbFBWTVUvMzFCUTJlNy9US1c3M2YwaW8vSWJWemtt?=
 =?utf-8?B?Ukx4TjVxZ04xQjl2Wmc5RzZyVkIwbEJnVk5idFRSVmNQR0VrY084NUpBbkJ3?=
 =?utf-8?B?K3cyamtTNExQL3BZZEFvYWFGK1hXL0RjeDFEa244bkxabHNhSlU2NnFDVHdk?=
 =?utf-8?B?QnBlRFA2cFNpUXNtYXhXREpDUWJIYmxjaFZSVlZWQ0V5dU9JbDFxcG9uWkUx?=
 =?utf-8?B?MUY5ZjNWV2tWK0xHUHVjaENmUnZxSlhOeEZNS09pOWpZQ2xpb0dKc0k1YTBN?=
 =?utf-8?B?VExUWHZ5VDZRdmYvaUxaWm8rbnpIL1Zja0ZtTXNSY3ArMTZQZkM3QzhCWkNr?=
 =?utf-8?B?ekRpaktScUp6Rit5bDk0dkc0dktMTzNVbVlaazdodmVpNWlOQkdSTFJOQzVn?=
 =?utf-8?B?bldRN0JadnQ1bHdXWkpXOTduRXFCMHBGRW9wNDd3cUc0bXBZLy8waEVNaGl1?=
 =?utf-8?B?MXNPQnlyWjB1c3JlYk5OSnRCbEdHZmVFWGV4ejlPdkI3QlBFeWVrWnVuRzBW?=
 =?utf-8?B?K3JxVjh4S1RmYnVlQlNrbHZNWUlyWElPMHVDaHFaZ2pzNTRLZ3Y1WkFEcWU2?=
 =?utf-8?B?cldFbThZNms0R1I1bU5uNjFnZmNoUUVNZDdKRHRDY3ZRNFF4YkxrRWNwOE1E?=
 =?utf-8?B?SjlxSU9yOWZyUjc3YlpvSE9NcVNwVlBpeldTVWEzT3VYenl2eUhJZzFJSFBO?=
 =?utf-8?B?c0Q3bkkxY3lMRDhtN25MNy9ldERoVzZLSURYeFJjeGNkcnpOY2dXZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1101fd-a19f-4789-22e2-08de9fa0fea6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:24:55.2335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS7B+tkx0B8pwRIgzdaDVUQVxUkuoz1xtWs4o3Px9QJWOOfLBdJsnidI8PVMlZ/wM9lxh728E119W/Sx95rMrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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

On 4/21/26 1:13 PM, Kevin Traynor wrote:

> On 4/20/26 8:37 PM, Ali Alnubani wrote:
>> On 4/2/26 7:44 PM, Kevin Traynor wrote:
>>> Hi all,
>>>
>>> Here is a list of patches targeted for stable release 25.11.1.
>>>
>>> The planned date for the final release is 21st April 2026.
>>>
>>> Please help with testing and validation of your use cases and report
>>> any issues/results with reply-all to this mail. For the final release
>>> the fixes and reported validations will be added to the release notes.
>>>
>>> A release candidate tarball can be found at:
>>>
>>>       https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.1-rc1
>>>
>>> These patches are located at branch 25.11 of dpdk-stable repo:
>>>       https://dpdk.org/browse/dpdk-stable/
>>>
>>> Thanks.
>>>
>>> Kevin
>>>
>>> ---
>> Hello,
>>
>> We ran the following functional tests with Nvidia hardware:
>>
>> - Basic functionality:
>>     Send and receive multiple types of traffic.
>> - testpmd xstats counter test.
>> - testpmd timestamp test.
>> - Changing/checking link status through testpmd.
>> - rte_flow tests (See https://doc.dpdk.org/guides/nics/mlx5.html for
>> supported features)
>> - RSS tests.
>> - VLAN filtering, stripping, and insertion tests.
>> - Checksum and TSO tests.
>> - ptype tests.
>> - link_status_interrupt example application tests.
>> - l3fwd-power example application tests.
>> - Multi-process example applications tests.
>> - Hardware LRO tests.
>> - Buffer Split tests.
>> - Tx scheduling tests.
>>
>> We ran our testing with Shani's backport for 9ec0c6bda04a ("net/mlx5:
>> add RSS TIR registration API") on top of  v25.11.1-rc1. Environments:
>> - NIC: ConnectX-7 / OS: Ubuntu 24.04 / Driver: DOCA-Host 3.3.0-088000 /
>> Firmware: 28.48.1000
>> - DPU: BlueField-3 / OS: Ubuntu 24.04 | DOCA SW version: 3.3.0 /
>> Firmware: 24.48.1000
>>
>> We have not identified any new issues caused by changes in this release;
>> however, we are still investigating test failures that are suspected to
>> be related to environment changes.
>>
> Thanks for testing Ali. I don't mind waiting a few more days for the
> release if you want some time to investigate this ? or if you are fairly
> confident it is environment changes, I can go ahead with the release.
>
> Let me know which you prefer.

Hello Kevin,

I’m fine with you going ahead with the release.

Thanks a lot,

Ali

