Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE0DE8306E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 09:41:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A1F240650;
	Tue,  3 Feb 2026 10:41:30 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0DB44402A2;
 Tue,  3 Feb 2026 10:41:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZNp5PiNfKzU3/93zJD79a9qAQXfxo90P27yJbB6bYOTEXNrXyQRUGySWLvN6T/A1sCaWxW67S6cASgOJfInr4RmddoBS0iHxc3gHK68eczBHgdt5sAowKXjR/WBxIJB/qqvAIYKfEJKPqC8DlJX59Pq3PNEYsN4ggFypKRkJR9mBS9VQm38x316+Enyi9+SriQGvBW/aZbZU7zi0XYyxLdffdSFyOwwN27ESeT3AcCZG2KRR5dNLV5p+8EidTw+4qFBf5xcsrpJSUp/7Rb45uJqXoa7+GIYaDzE/D2SUeXNb1Z1BOTABsVi4W/L2IlgwS7ALDg0Z2mjBOTOg1SLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnxEqsOQZbFsheGMcoFUsGk+J+raZhgPpXMpajTP9xk=;
 b=q+1rH7lbLmyiOGVC9isT1aj9XXWM8fzlJQYSFAu/PwmgvSt/0I9HPT2tum9FiMZcYk4DttIYgRnW3kEEb+6niT6Goy0H+134oUFgD7mUfxA79B9UEw58f4g6yk2Bbho7nS09nB4oeZAfVu/07Y6d+ISjWekmpokN6poQPhkrZteAiy4tZy1gur4pQzDIVBH7pFP+ErjKKInFBtm/v4JUkEWwiTRZa89ckW4m28ip9yZO1FwDrplrVCmn8yLCjrr6jivYL9KexOiF+gpIpvS2+CcPkt/PiSWzVV+HdrQgLKLnrQN2KY5Gf2a2l1/GmlgHH430qAGWatB+vD2HrBxXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnxEqsOQZbFsheGMcoFUsGk+J+raZhgPpXMpajTP9xk=;
 b=du9H1DWXppYBvm8trEeJhUVEZ2wxTJV/T4yKZ6F8kop44pSFjHtUMm/I562VDITo0u6AvFHVjb/Y1uX7XJmMVCthn8jxkIg42m0m9lW7hkZZ4FQyydQlqNlmmMK3rfP0jydiA9ntKx7AbzSsZtRZ4oh1GvybWDDQO1PcGS/53Y+91BKz70PPYLb6iKUbhfZ6rDweH3JaAfVAUGQ4+yLBLrdpvyqsNLhMP1HXpuWgz+4nSgrPIv4RK2w2DR53Ba8zJSdUNcSYOAkmw8mNsNbJJs3xPtvFXM/1PKUglByz1xFAZbjIRPJxAwL3ALubLeA95h2gYgbc1aSczkPZiQp7xA==
Received: from SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::12)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:41:21 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::78) by SA1P222CA0176.outlook.office365.com
 (2603:10b6:806:3c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 09:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 09:41:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 01:41:06 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 01:41:05 -0800
Date: Tue, 3 Feb 2026 10:41:03 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3] app/testpmd: fix flow queue job leaks
Message-ID: <ad26w43vtryoiqoo3kng4dfwjviadkgngxv55rxov4g4vms5jn@k3gm52cta3qg>
References: <20260109152607.206389-1-dsosnowski@nvidia.com>
 <20260112173648.1528180-1-dsosnowski@nvidia.com>
 <20260112170918.4802853a@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112170918.4802853a@phoenix.local>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6d4f38-93ff-4c08-80f6-08de6308634b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEZyaFFjOVY3QmpTbVJkajA4bm0rbXYrTml1S2QyRm9GWFNTRVpOUDI3Q3pJ?=
 =?utf-8?B?VmFieDdmWkJiVHk1U0NuR2djekwwQVFDL291Vi9GSGVLVHZDK2tuanNsUmIz?=
 =?utf-8?B?b3VwbmdYNkRNdTllVUdMeExkaTJSL0QzMlRNdXdBM2UwVzhaWHYyWDFyd2ZG?=
 =?utf-8?B?ZEJNQklza1dXS1ZGcklzbXg0dHRIek5kVjVzMG5qNkxNcmxMa2NtMlkrUmxD?=
 =?utf-8?B?dElDRzZPS2pheGhQa3VIL215UCtXdng5empYU2hwWXpudnNTdm1iRFpWMlN0?=
 =?utf-8?B?ZyswMjFZZ2t4cFpPcEIrWUZKTTA4MFAxaFF6MzU3NmlRK1F5SVF3Qi82ZS9F?=
 =?utf-8?B?SkFkTGQ3QnJ4UmxPc0pTVDVlTUZMK3kxdldZTTllZDVZaTFwTUtCakdMVkt3?=
 =?utf-8?B?bitJbnoyRFRPSDRpeHo2NzlrZlNGSHFrcndnZXRjNjJsSlFXTHNFYkVpbUQ5?=
 =?utf-8?B?dW9ia2JLMHZnWjlQdDVWRGdWdHpFVlBLajFIM09JZUN1ei9Ub0xYdmtJTkdH?=
 =?utf-8?B?eU9uRVljanJLVGs3bEEvMGdxRHBsSnVjSjdOOHNRL0VHNWIvdlh4RFQ1c2Mx?=
 =?utf-8?B?R3A2SWZTWjNvKy9xemJNbjRmK0YvRjg3SDg2Z3pTUjhyWGh2WnZUY3RlSlIr?=
 =?utf-8?B?S2FJNHZyaGdJQ3ZKSldFZ2lTdW5meElDQVlRbWdVejl3Ym9MMTdQR3cxdVV3?=
 =?utf-8?B?TFVnRkRBbVVDVXBtN2pNR3dhRWhyQ3ZPYWdMTnNiUVJMY2VOeXZraWYwYmJO?=
 =?utf-8?B?SmFObSsrd1Yrb0RMTms5ZGNZN3BYSGNFS1hDeHZpcit5eElRMXcySmtOeGVk?=
 =?utf-8?B?ODIra1I5cDBXamxYelBoY2FPdlNwWXdZWWdFdTVEdExDbjVDRkFLWFNwWjd3?=
 =?utf-8?B?NGZ1ODFpdlJKM0c5NnUvWnRBb1czQzB1b1NQMU4vbVh3TlAzNTRwMlBuRCtK?=
 =?utf-8?B?M2dqc1dBOUxxSGFwZnU1WkRYb292cFUrYnM1MGR5bkU0ZmVTd0UzakJqYUJh?=
 =?utf-8?B?Q1ZQYnRFcDlNQ3lSWmY2NU5CVXYwd3VQTnF0NlRLZGNIanhtK1JQUlJLTHhi?=
 =?utf-8?B?RGxINmRtdy9aR1lmZy9yeXMvaStkaFRQSHc5WVpDZVJDcHpCZkFvaTZ6aFBn?=
 =?utf-8?B?eUVJWHFlUnJoOFdKYnZIcUltdFJsYVM1SjhJZ3lEcWRpQjNERDkyUXBqc3hk?=
 =?utf-8?B?WDRDL2xQS1NmK3NqZ0FndFFSNzJMUmc5MUtFa1dQd3BQZnMrL0FvQmhIcTJt?=
 =?utf-8?B?TmdHaUxESmRkY3BRTTdESE5TU0NQUnJRaDVyMWFPalZVbDhVUyt0aW5NTEFF?=
 =?utf-8?B?OEZJN3NqVy9UOXFNcGZwempKeTJ1RkxzODFOMUVhU0tuRlN0bFMvMW5xQXdp?=
 =?utf-8?B?SmM3VlN0UTBkSUhqWjZvNkVjQ0tVNTdsblBCU0RmRFl4aG92SVJ4RXUzQnRT?=
 =?utf-8?B?djcrVmpXUHgyMVF4dUYzdEd5OVdZTHc2MHg4R2gwOHBJVDhuUHJwOTU5dWpa?=
 =?utf-8?B?cFR2ZG13UzF1Zzd6WWJUZTQzT2lFZG9XZFVBNFRYek1OdUk1emVNYjErbW92?=
 =?utf-8?B?ZkVzc2xUQ2NVTm8vUlJyQWMxRCtYWFZ3ak1aQ3lZRThxNjNPYTdwcDlxZmR6?=
 =?utf-8?B?bHh0bEM4T1R4aEZjYmdSREFMc2gvKzI3ekJGakppUVd6emZCeWRoZitpZHhl?=
 =?utf-8?B?QndDbnhHTm16YlZHNVBoNHdzL2l0TWZ6ZVg3MGVxZmZuRlBFdzFSdzd4MnJK?=
 =?utf-8?B?WDA0Ky84cGZBTVlnUTJlQjhQazNuM05xNVd0TXVxQzI4MTBkbEdoVDBjN1Jx?=
 =?utf-8?B?cEU4emZyRnBrT3R0Y01CUmdvUERaUnNPVGt4QTIxby83K0ZRb0lCWnN1eFFk?=
 =?utf-8?B?bDVuMlV6eWQ0d2dUL3R2enc1UjRkRE1XUVhveEE4NzJBTjF5c0VpemYyVVl3?=
 =?utf-8?B?ZHFaZndOTU9ycDRuM05GK21vd1lOVmt5SWhQRDFXbWsrUmNaNGRkUUxxTEdW?=
 =?utf-8?B?d3c3WTducFlEWFBDNGdTYldvSEdvTkY5d3dIVWlhQmxDWlhYYjhSWUFkdEQz?=
 =?utf-8?B?R1FoczVDU1lEV1lXMFRocGM2T2NEU2hxZldueWtjWHZZc3ZFdVFzRWtrVFJ1?=
 =?utf-8?B?eE9GaVltYUpBc2s1NTRBanZYRnNZVTlKWnBiekV2Q1JjMGdWSWVoUmJ4bEVU?=
 =?utf-8?B?aFZGbW4wRFJPbFFLb1N6RmZoQm1XQnBtT0Nma2EvMWlFV3lXY0EyeE9nUXE2?=
 =?utf-8?B?ZVNjb0lSOEZSN2puZnJCTWdDYWJBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vl/GzQDybgwwRW1esmxeKGFQGYnGTm1QD/tTiqf1gpDNxTaW+y3IlMyLeik+8KP0OB9+ve/VOGJ53LuMkOWQLuTpJiBJoHFOA/TihM8aLVDb/gS2R2Q+O9NUw5/cruSSqV4rWTFsY8L9eTrS4VqSQmCtyWD2SF4+OPuZmcGqKa7NG/Uh/SaFeKbtrGv2lDUb1G2ohZlTVR1hPR3HeXsgtcvqQ5t6/FDCpuJiZov7KdILBt9lA5RsY2IVv84SW553q6JLRtonHqayRf0QvK3zru+qeWLWoMd9dmbUWR6nI0LxTeftiZeI1LTH5+P/fX9Ba1e/waFRxQpzw7rwrrdILF+KQO4vsLgmLUeuC0IO/X2Zxk1LZ99K58AUiNcFF7J13EnbDRgeInVUDAzXGMJydmtv7EGUDQU1CM5w5Ht2C404pCTMLXAbWwzdFLgBEZYd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 09:41:20.8849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6d4f38-93ff-4c08-80f6-08de6308634b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
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

On Mon, Jan 12, 2026 at 05:09:18PM -0800, Stephen Hemminger wrote:
> On Mon, 12 Jan 2026 18:36:47 +0100
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> 
> > Each enqueued async flow operation in testpmd has an associated
> > queue_job struct. It is passed in user data and used to determine
> > the type of operation when operation results are pulled on a given
> > queue. This information informs the necessary additional handling
> > (e.g., freeing flow struct or dumping the queried action state).
> > 
> > If async flow operations were enqueued and results were not pulled
> > before quitting testpmd, these queue_job structs were leaked as reported
> > by ASAN:
> > 
> > Direct leak of 88 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f7539084a37 in __interceptor_calloc
> >         ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
> >     #1 0x55a872c8e512 in port_queue_flow_create
> >         (/download/dpdk/install/bin/dpdk-testpmd+0x4cd512)
> >     #2 0x55a872c28414 in cmd_flow_cb
> >         (/download/dpdk/install/bin/dpdk-testpmd+0x467414)
> >     #3 0x55a8734fa6a3 in __cmdline_parse
> >         (/download/dpdk/install/bin/dpdk-testpmd+0xd396a3)
> >     #4 0x55a8734f6130 in cmdline_valid_buffer
> >         (/download/dpdk/install/bin/dpdk-testpmd+0xd35130)
> >     #5 0x55a873503b4f in rdline_char_in
> >         (/download/dpdk/install/bin/dpdk-testpmd+0xd42b4f)
> >     #6 0x55a8734f62ba in cmdline_in
> >         (/download/dpdk/install/bin/dpdk-testpmd+0xd352ba)
> >     #7 0x55a8734f65eb in cmdline_interact
> >         (/download/dpdk/install/bin/dpdk-testpmd+0xd355eb)
> >     #8 0x55a872c19b8e in prompt
> >         (/download/dpdk/install/bin/dpdk-testpmd+0x458b8e)
> >     #9 0x55a872be425a in main
> >         (/download/dpdk/install/bin/dpdk-testpmd+0x42325a)
> >     #10 0x7f7538756d8f in __libc_start_call_main
> >         ../sysdeps/nptl/libc_start_call_main.h:58
> > 
> > This patch addresses that by registering all queue_job structs, for a
> > given queue, on a linked list. Whenever operation results are pulled
> > and result is handled, queue_job struct will be removed from that list
> > and freed.
> > Before port is closed, during flow flush, testpmd will pull
> > all of the expected results
> > (based on the number of queue_job on the list).
> > 
> > Fixes: c9dc03840873 ("ethdev: add indirect action async query")
> > Fixes: 99231e480b69 ("ethdev: add template table resize")
> > Fixes: 77e7939acf1f ("app/testpmd: add flow rule update command")
> > Fixes: 3e3edab530a1 ("ethdev: add flow quota")
> > Fixes: 966eb55e9a00 ("ethdev: add queue-based API to report aged flow rules")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > ---
> 
> Much better, but there some suggestions.
> Yes this AI "bikeshedding" which is a first...
> 
> ## Patch Review: app/testpmd: fix flow queue job leaks
> 
> ### Summary
> This patch fixes memory leaks in testpmd's async flow API by tracking `queue_job` structs in a linked list and ensuring proper cleanup when flushing flow queues or closing ports.
> 
> ---
> 
> ### ✅ Commit Message Analysis
> 
> | Check | Status | Notes |
> |-------|--------|-------|
> | Subject ≤60 chars | ✅ Pass | `app/testpmd: fix flow queue job leaks` = 37 chars |
> | Correct prefix | ✅ Pass | `app/testpmd:` is correct |
> | Lowercase after colon | ✅ Pass | |
> | Imperative mood | ✅ Pass | "fix" is imperative |
> | No trailing period | ✅ Pass | |
> | No forbidden punctuation | ✅ Pass | |
> | Body doesn't start with "It" | ✅ Pass | Starts with "Each enqueued..." |
> | `Signed-off-by:` present | ✅ Pass | Real name with valid email |
> | `Fixes:` tags present | ✅ Pass | 5 Fixes tags with 12-char SHAs |
> | `Cc: stable@dpdk.org` present | ✅ Pass | Correctly included for bug fix |
> | Blank line before Signed-off-by | ✅ Pass | |
> | Tag order | ✅ Pass | Fixes → Cc → blank → Signed-off-by |
> 
> ---
> 
> ### ⚠️ Warnings
> 
> **1. Unnecessary cast of `void *` (line ~420)**
> ```c
> job = (struct queue_job *)res[i].user_data;
> ```
> If `user_data` is `void *`, this cast is unnecessary in C and should be removed:
> ```c
> job = res[i].user_data;
> ```

Fixed in v4.

> 
> ---
> 
> ### ℹ️ Informational Notes
> 
> **1. Function naming could be clearer**
> 
> The function `port_alloc_queue_job()` doesn't actually allocate anything—it inserts a job into a linked list. A clearer name might be `port_register_queue_job()` or `port_track_queue_job()`.

False positive - port_alloc_queue_job() function does not exist.

> 
> **2. Commit body line lengths**
> 
> The ASAN stack trace in the commit message appears to have lines that may approach or exceed 75 characters due to indentation. While the content itself is useful, you may want to verify line lengths or consider trimming the stack trace to the most relevant frames.
> 
> ---
> 
> ### ✅ Code Style Verification
> 
> | Check | Status |
> |-------|--------|
> | Lines ≤100 characters | ✅ Pass |
> | Explicit NULL comparisons | ✅ Pass |
> | Explicit zero comparisons | ✅ Pass |
> | No forbidden APIs | ✅ Pass |
> | Function return type on own line | ✅ Pass |
> | Proper comment style | ✅ Pass |
> | No trailing whitespace (visible) | ✅ Pass |
> | Uses DPDK list macros correctly | ✅ Pass |
> 
> ---
> 
> ### Code Quality Notes
> 
> The implementation is sound:
> - Properly tracks jobs per queue using `LIST_HEAD`/`LIST_ENTRY` macros
> - Bounded iteration count (`FLOW_QUEUE_FLUSH_MAX_ITERS`) prevents infinite loops
> - Graceful error handling with cleanup on failure paths
> - Memory is freed both on normal completion and timeout conditions
> - Uses `RTE_ASSERT` with explicit NULL comparison for debugging
> 
> ---
> 
> ### Verdict
> 
> **Acceptable with minor suggestions.** The patch follows DPDK coding standards correctly. The only actionable item is the unnecessary `void *` cast, which is a warning-level issue. The naming suggestion is purely stylistic.
