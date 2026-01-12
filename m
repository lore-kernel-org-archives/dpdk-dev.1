Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB449CF45B7
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 17:42:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3535F40281;
	Mon, 12 Jan 2026 18:42:20 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11]) by mails.dpdk.org (Postfix) with ESMTP id 4D33A40041;
 Mon, 12 Jan 2026 18:42:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSaOa9Rygs6Zdul1yxOZ9IkSMn0APcv7v0U+tzRoC7axReafKI4bwMhlQ4VdDz07wpHK5vAUP1aufpQLABhyTkIfcooQjjKwY5nUAikwNTaZUlkUSIwSBT3jsItF+WC6u4HF5Re38QiU7LTf0yu9dJ7tx73hn+G+gd5P1MoRVlALASpUSwP+tIRs2RB5uNB2TSRLwbToaDl5hUfBZx1UH63EzlJnnDs1zDndc9Zjvef+YtJzYxJPMSMb40w4ZhMF2pUr7ljj7GM8XtnnnZ0g8kVhn1ju1SchuNbhd+ZuGCg71tSioYovLrmut2s9vSdREVQ45OzZqZV8JYS5Aj1RdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfHkpOEoGLcGX7IDX0cNLYoje13b8aNSZb6yVekJ2hQ=;
 b=Is0CoDvCXJWb3SjX8oZhdPZlbMgOMm4+sEfHoPn+wghK1KJZXapGeNUxAjmfUPdvHTTsOxqoIj0xEoaPIcED83xHB6XCsiwnFJs1UzXawZ+GS9etFyN+xDUeiNASqn4jdMq5Nbmk9sSi3zMicmabZo6MiWWS5OPFqaKnPaM+fMtq/nfo27xMWAlEom0vTKXb2MGqYK2fGjOVv50kNCFokCf5lAm1Ncagqigion4o/dQXb0S6xAqP4UVbjclCDv+wkkREO4ML6wu7lwTN+s78wRulFJUHJgt4yh+/B8EBm/aFJD4PtX09l5pAibvoS2b68RzPk+5mtD0CBP/psocapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfHkpOEoGLcGX7IDX0cNLYoje13b8aNSZb6yVekJ2hQ=;
 b=lBzrfydja37HfWIJhp8n60NWp7Utv7cBJSYzuRP9T82WTv0tRQ+7yHt0lOykwoDqH7WBKDIweRRC87+Gr7ZhCPDmre1hzPmqzcEdNxaOoUMZcLMWgtQIvU1UoeWrsonHzw9XlBrrPbNwck1qruT4wV2V/4MJAF/rmvldiKPSaOIedrBZ9f+pMlOYueiF919fUEHAt9i0Byv5Hn5gvQHryUMlugBPJtMxgHI7eEFgcsJMJE8eOthricva4HznMlsPijPHOW/ho2kZzTKOTP9MqZF2MULoemlwzBtTjvu7HuQRsHqZOva1OkhPmmLNtEkmwM6CWaZFBF/hVlqpe3PJAQ==
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:42:14 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::e8) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 17:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 17:42:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:41:56 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:41:56 -0800
Date: Mon, 12 Jan 2026 18:41:52 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>,
 <dev@dpdk.org>, Bing Zhao <bingz@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] app/testpmd: fix flow queue job leaks
Message-ID: <qd2tajzg2v4xrdjzq2r2fdgkvmu47exjizabfav43wihrqedkk@uyewhppawni5>
References: <20251118104518.1714166-1-dsosnowski@nvidia.com>
 <20260109152607.206389-1-dsosnowski@nvidia.com>
 <20260111171016.56ea4285@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260111171016.56ea4285@phoenix.local>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ddf005-a22e-4d39-755c-08de5201ec70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjRleFdMQXlIaEczSWluT2dPMlIvaHRNa2xLaUFCU0pzZll4MHdYRi8wZFpp?=
 =?utf-8?B?dmFEVWF2RUdkWnBUSE02bnZLazZlWGppTVgreFN6V0w0d0lPOTN5MnJQY2Jj?=
 =?utf-8?B?OWFwUXRYQ0Y2eGNSZE5yMFFUNVUzU1BYNHg0aEtadFlRaDd6K2xpTStkZzRY?=
 =?utf-8?B?ZU5lVFVLcW1GMnYwWC9hNmNzY2h3Wmc0dzhqbHJUSkFOT29pcVhPdUhSbkla?=
 =?utf-8?B?dkVzdzRKbXV0eU9Gdk40SnJLckdYakt4OVB0Wko1eGVSL1NqMktpRmVJRytD?=
 =?utf-8?B?NzIyTkxtTzJ4NURYSW5CZkJPRTdrNE45QUVMYURVOHhoWmJBYmRJdWhZN3NK?=
 =?utf-8?B?ajNqNStFem04SFBwLytqajRQNlVuNjBWUnB0V1VPM3UrTGtiT29sWnFzaEY0?=
 =?utf-8?B?TmUwN1hEUlE0QXExWWFwUC9tOEQrSlB2R3pHR3FGSmF0a1YzRG9FeUhmSy9B?=
 =?utf-8?B?eS9qTGxkVFh3VlpUR3BnYyt6MWd0dHY0ejdCOGk1R0VLckt2WS9KZ1MyNFBi?=
 =?utf-8?B?azk1cFBVYTNwMTZUdDBTZUVjZHpJS3hFZUJrSVA1QkxtTk5kSGZ6NkJQY0FK?=
 =?utf-8?B?eWdaNkpFUVRNUUwzK2RwZ1FVemttaDc1bGpBSG5HaFJCZ1duUnFyY2xOamFp?=
 =?utf-8?B?NzBuYklHNUh2TzFXOHZDL2tWTkVRNXRQV0xqMlFuNENmZWFRZmE0blRGdnlk?=
 =?utf-8?B?VHBJeXEvVkJERW1XU0J0NEVFMDBvaDhyeXZWNzE3N3IzTzUrNjZWK3lwVG0w?=
 =?utf-8?B?TEFEdVg0c3RPdjNvblJvT3dkUkpUZFZETDFkSXBOMEtiRXNpekZlSzQ0M0lY?=
 =?utf-8?B?TmU5VmlWSXZRSGtGOTVaQmpIREdwU1d6RlJUMWJNdFA3QjI2UXVwSjRwd0xT?=
 =?utf-8?B?NjhWN2RGclEzdU9mdW1NYUh6RkJqTlFoVFNuUUhqQ0cxZFUweUZwaTJCSVhN?=
 =?utf-8?B?UTNoUHNXa1ZNaDlhdHBrZEVVYWRWTmpENFhSdnlpd2ZYM29WYytKZUZsUVVU?=
 =?utf-8?B?ZnhOWE1pZEdNUFlTS3kxSGJpOGxGd2xqb3V6VU1ReUttd0FlS3hhUTllaGl3?=
 =?utf-8?B?NlZHQWZIbTNSL3licVIwNnIybWRRQkU1cHJyZm1zSmRPT2dkWWloZTVWZ0tX?=
 =?utf-8?B?STR5Y0c2YzJwWGZGOExDVFZtSnhEb1ZodE5QVHBzcExnL1htNlJOZzd5c2F2?=
 =?utf-8?B?djhXemlLSEtoNmQvY0VYYVhMSFdsVFQ1bHEvLzEwZnBKR3dkcU5icmtZYm96?=
 =?utf-8?B?eFdmcitvU2FQenQ2UGZ6MjlSc1ZyUDhnZGVEdEVnNnZqNlM1aUxaSUpEZ1R4?=
 =?utf-8?B?U3o5REJ1OVBKSTZTV1dtRUlHczhWY3VlR0IvZEwwRHVCRXUyeTRySkY2Zkx2?=
 =?utf-8?B?SEFiL0prWnAzaGo5Qno5RzJCSkl5S0pUc2FwWUxJb1lzVHFBV0dyQjFnTWM5?=
 =?utf-8?B?TlphK2VYcU8rMW8xWElGRE16RElVSHVqR1JqYW1BSm9oVWpCWCtPZFMvVHF0?=
 =?utf-8?B?b05DWXZhT2FOYkhUcEl5MVE2ZWtnOTRxU2VqVG1RdFQybDRCdXR5UXlDRU56?=
 =?utf-8?B?Nm9IOW5YYlNhc1VLZlJRR1FxM0FGaEQ4cE8rODgxcE1LOFBwZ3JydlAyR1By?=
 =?utf-8?B?T1Ywc3dwYkNMbHlYZTZsdmtXN2ZvbTlwVDd0VEhIaS9NS0d5UnJ3bXFGN0Q2?=
 =?utf-8?B?M3lrWkpTNVBHTlZQeFlRTE4yaUEyM0d0NTBNNXNMajlDSEQrcG5USFhSY2Ix?=
 =?utf-8?B?VVorM24rMkpHY0dvQ2R6Q0grOGdaczYwaEJoRWxLeEtaNjI2ejlkOVBNUUFD?=
 =?utf-8?B?RW9nN1dVNm9qNDBMWjlwR2ZyTEZaNkhLNEQvUm1qTHlucThHRmRqU2VTS2lP?=
 =?utf-8?B?b3BSak5MdVJNYytQS055WDBqdFNZKzdobDcxbG1hamN4U2ZTcHdMT3QwODht?=
 =?utf-8?B?WStZQkJiK0pxSWQwWGl1MHR1U2hkd3YrSzB4RUVrQTk1Uks2eEFvdWNZdGdB?=
 =?utf-8?B?SWtuZWMrTW5KVnhpTHpCZE8xZTVyQml2cVNlaWRYZDI1SWVYdGFDa3pCUDhL?=
 =?utf-8?B?UkpuSitIakpMV2dnbkpHVlFXZzZnUlN1cjNqN3oxRWZzSTVjeVZLcDZlZG90?=
 =?utf-8?Q?+4I0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:42:14.7967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ddf005-a22e-4d39-755c-08de5201ec70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

On Sun, Jan 11, 2026 at 05:10:16PM -0800, Stephen Hemminger wrote:
> On Fri, 9 Jan 2026 16:26:07 +0100
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
> 
> Surprisingly AI code spotted a minor bug which I did not see.
> 
> 
> ---
> 
> ## DPDK Patch Evaluation: `app/testpmd: fix flow queue job leaks`
> 
> ### Summary
> 
> | Category | Status |
> |----------|--------|
> | Commit Message | ✅ Pass |
> | Tags | ✅ Pass |
> | Code Style | ⚠️ Minor issues |
> | Code Correctness | ❌ **Bug found** |
> 
> ---
> 
> ### Commit Message Analysis
> 
> **Subject Line:** `app/testpmd: fix flow queue job leaks`
> 
> | Criterion | Result |
> |-----------|--------|
> | Length (≤60 chars) | ✅ 37 characters |
> | Format `component: description` | ✅ Correct |
> | Component prefix | ✅ `app/testpmd:` (not `testpmd:`) |
> | Lowercase after colon | ✅ Yes |
> | Imperative mood | ✅ "fix" |
> | No trailing period | ✅ Correct |
> | No forbidden punctuation | ✅ Clean |
> 
> **Body:**
> - ✅ Does not start with "It"
> - ✅ Provides clear context (ASAN leak report, explanation of queue_job lifecycle)
> - ✅ Lines appear within 75 character limit
> - ✅ Well-structured explanation of the problem and solution
> 
> **Tags:**
> - ✅ Multiple `Fixes:` tags with 12-character SHAs and quoted subjects
> - ✅ `Cc: stable@dpdk.org` present (appropriate for bug fix)
> - ✅ `Signed-off-by:` with real name and valid email
> - ✅ Tag order correct: Fixes → Cc → blank line → Signed-off-by
> 
> ---
> 
> ### Code Style Analysis
> 
> **Positive:**
> - ✅ Function return types on separate lines
> - ✅ Explicit comparisons (`res == NULL`, `ret < 0`, `ret == 0`)
> - ✅ Proper brace style (single statements without braces)
> - ✅ Lowercase function names with underscores
> - ✅ Comment style follows guidelines
> - ✅ Lines within 100 characters
> 
> **Info (minor observations):**
> - C99-style loop variable declarations (`for (int i = 0; ...)` and `for (queueid_t queue_id = 0; ...)`). This is acceptable in DPDK but some maintainers prefer traditional style.
> 
> ---
> 
> ### ❌ Critical Bug Found: Format String Argument Mismatch
> 
> There are **two printf format string bugs** where arguments are in the wrong order:
> 
> **Bug 1 (line ~428-429):**
> ```c
> printf("Flushed flow queue %u on port %u (%u failed, %u succeeded).\n",
>        port_id, queue_id, polled - success, success);
> ```
> Format says "queue %u on port %u" but arguments are `port_id, queue_id` — **reversed**.
> 
> **Bug 2 (line ~437-438):**
> ```c
> TESTPMD_LOG(ERR, "Unable to fully flush flow queue %u on port %u (left ops %u)\n",
>             port_id, queue_id, expected_ops);
> ```
> Same issue — format expects queue then port, but arguments are port then queue.
> 
> **Correct version should be:**
> ```c
> printf("Flushed flow queue %u on port %u (%u failed, %u succeeded).\n",
>        queue_id, port_id, polled - success, success);
> 
> TESTPMD_LOG(ERR, "Unable to fully flush flow queue %u on port %u (left ops %u)\n",
>             queue_id, port_id, expected_ops);
> ```
> 
> Note: Line ~475-476 has the correct order (`queue_id, port_id`), which makes this inconsistency more apparent.
> 
> ---

Fixed in v3: https://patches.dpdk.org/project/dpdk/patch/20260112173648.1528180-1-dsosnowski@nvidia.com/

> 
> ### Verdict
> 
> | Severity | Issue |
> |----------|-------|
> | **Error** | Format string argument order bug (2 instances) — will print misleading debug output |
> | Info | C99 loop variable declarations |
> 
> **Recommendation:** Request v3 to fix the printf argument order. The fix itself is sound in design — tracking queue_job entries on a list and flushing on port close is the right approach. The ASAN leak is properly addressed. However, the swapped format arguments would cause confusing output during debugging ("Flushed flow queue 0 on port 1" when it should say "queue 1 on port 0").
> 
