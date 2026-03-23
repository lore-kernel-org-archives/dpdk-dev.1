Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C19FF46112
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 13:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BAC140268;
	Mon, 23 Mar 2026 14:47:17 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by mails.dpdk.org (Postfix) with ESMTP id C2D884025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 14:47:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rT7Ydp/Pgsr7frMI6374Xo7cVN8J2utOPung+jXapgErH3QJgArajPdyrU9fA7uwc8Le9X0fSn6DAqVBRtwUSy0t80zr9g02GMWpTVAydcbNw3a8Pwq3WC7xIZ1fi5aLAnfYy/CmvbI2TrLlS0BiAtt6g7qYam6EA8No+R7wSkb94XqZRMg1qd168wpNhkTxxbU/qy73LVyIAXNObtXdI7XnViocVuM4OyHHD2Yei9dzFK6I8rX0obVixqyJXbLOhX6XbskhGkL7n5shdaQ9BJm0wBWm/isgH9u9YDK5gcjAP2g3cM8A75+tsy1QF3xWlSSIGLsFz+nXeR4UaIbFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS2TNwxs79QoWUxWj5jTURdGpnC7lBI3ln3wAsYQggU=;
 b=a0AjOOTUBVOMWaPoYJRPjXOGMXoj+Y68dzVbYVg07belVNIB+h1/HJh0hdxGGoJLJgO0FAObOpWA5v8+lnJ5pkFZqOYSxTjeleu1a+UokcAaRtFcPUHii8yAZ3/1u/N/9MChooEtnDbtQUa3nOoA4f/rrwotAhRYvBrsUxua/1onH+//BKeKY0NbnWgSJv6I06I7nlSPPuspmNHVe/rFWMDMAzMm8xyabUDbUlEsPZWLvUe2wGReMZlrHvLPhSeVNhLshLCnxu4Jd2r3IKX9J0ZHAF+AOfGZ4lNJ6Z7f6Y508rmc/OMybRXxYWIwPKa/vf9qrAPIc8HtdiEUt/fkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=syseleven.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS2TNwxs79QoWUxWj5jTURdGpnC7lBI3ln3wAsYQggU=;
 b=VkqaKU0GJlXGw/ClpTTf5vXDQZP1YAin+S45FPlkpm5XgtdbO3qiUye37+jvLM/ZlBDL+oC36wVF6wzJEcZxzp8NPt/6DGbSoqeN/13RAHOGuHZYO+vd6BlfjZW7KKS9yNQfKEYOATve/GdCm2nA2SgmzfAnj4ISemO4XNgSDmgiMqEkS826Q29HlG85ShM8E0PzQ6k41gZ6kQAAqHAtkpVf7q8B/FaWjevIjOluWq58PmYYCCHICyYvfe164TOH1+GKNJde2bNzehto4T3xub4dGaBDLbNTzCV5p8xaG//UDWo8A6esrKpUuNGD+cD0puynFfq0VKYDFkmekeFzog==
Received: from LV3P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::6)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 23 Mar
 2026 13:47:10 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::92) by LV3P220CA0017.outlook.office365.com
 (2603:10b6:408:234::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 13:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 13:47:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 06:46:47 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 06:46:47 -0700
Date: Mon, 23 Mar 2026 14:46:39 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: <a.schollmeyer@syseleven.de>, Stephen Hemminger
 <stephen@networkplumber.org>, Thomas Monjalon <thomas@monjalon.net>, "Aman
 Singh" <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>
Subject: Re: [PATCH v3] app/testpmd: fail on shared rxq switch mismatch
Message-ID: <yotjxacqrodttraqrr3r6ftut4cty66g6cjnr5ughswtatapgh@gqqkftskp3qq>
References: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
 <20251201102211.490071-1-a.schollmeyer@syseleven.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251201102211.490071-1-a.schollmeyer@syseleven.de>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cd51ce-c94f-4e67-a371-08de88e2ad70
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|7053199007|18002099003|56012099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 8ZhrmVmE3mgdDcG93aQBrkLmzR65qDG5sHWU4h3Mywgw6H1/ceHSVeImRdOUYlGMhg911cMcPRpFgceMreVid6Pla4Ow/HtUA3Mf6+3708Px8c6/5xzNie+ft6apjhu78AaAdwNaUiVpzIVQ+Zve97WE7U8VxOmhEZxCXkJTnEZjcGX+Oa5W2JJvEd8RbU90hYTo/HMQaQWDEjw+/x2ydvNzi0cTBuS3qHf+fMyG2iXMqIV3XQzRJrzTMzPOJf0PTcFn2d1Ty9KnsEC0S7DffBUuMJpL8hhYUUpJa8jPlA5pcvB96FXFCnnfdtfnhDTmQLcH11EHH0IhhBiYZgxrLgnwt3YyakarzGcsKSOnP4HC4bs8RXVZJAJS0m1zCYwdbNnCd5igpFnm2hiuNl3IA649f7NmJGJ7AX0t3y8MYnxEl2Itx39WUfboWtUo9w6kpQZlKACodiYUQfNgphcTqTP7Nbv5hl1b+aEmO4SqNeTBSBByzNrCfwMrJSYvC/h1yRzfYzMSQEawCw4xjCNfeiMROe7lAQIu9c5QEX7L+qDlQgymngK699WkDCrysQ/xjzKjW9/GQlvyPauTQYuVkx5g9/pP+tatrso6sjmLEwcO5pMjIOmpn9tkfssrSc23gCu88oq3pIj5ELOt0MxhBwIGj0BsYQjnrZ2RNA7r1Ix2Xtpq70OKvUZ+5g/Y36cgDBeMtBYwUenq4RsxUrbA6zWp/0FySNHaDNAYesLigX2K3ukbKrCzvZ+Vl181veDZBy/JSY9EFR68BMXkLBVDZA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: um6iN8iTJunR86qVJvQ2KQZD5dS5JUh9ynQe7LcuRMEv44NCspxmsu/x+uZ5dmQ9sgGIkzMGYAG5jk1PBGSzHohZwH92bdjnx6RWnAp4gP+K2647uEpkOjV55g3Rds1AQbPLrDmLnCyO/IZcXIdVON8KLofrk9N1aF8h66hJ7q5Lyd4xvRBk0ihdThE8wnWvPMugmDQ2JRM0V79NuzPhCMCoF8HiOdf1ASAu84/LgLqAZcbp2RUA7AIVaB2c6SuKt88xkjo5KT88ttIwKyei2x2X9c3Yhmk7tAer0E+4H0JQuVgUgyueK8xtPtCPCWkX0fAubZ+YtkuXi7fDn/JmG1ykoeRgOUZye3XKd6UCrvgf+cdtOfj1sgyd8DBPdfg27bSFm/W02zBDS9Z8HNojZUR4k7403nPEjBqqJo/1WwfkxPA4bzoSwS0KbMfkc6Vs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:47:08.5201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cd51ce-c94f-4e67-a371-08de88e2ad70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64
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

Hi all,

On Mon, Dec 01, 2025 at 11:22:11AM +0100, a.schollmeyer@syseleven.de wrote:
> From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> 
> Shared Rx queues do not work with every combination of ports. Besides
> requiring the corresponding device capability, shared Rx queues also
> require all ports of one share group and queue ID have the same switch
> domain and Rx domain. When these fields do not match, shared Rx queues
> are not properly set up and queue sharing may fail silently. This can
> happen even in some less intuitive cases like multiple VFs of one
> physical NIC and may cause packets not to be read by the application,
> depending on how the data path is implemented.
> 
> To help with debugging issues with shared Rx queue configuration when
> using testpmd, this commit introduces simple checks and error messages
> for members of a share_group and share_qid to fail whenever there is a
> mismatch in the switch and Rx domain.
> 
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>

Our internal regression tests have flagged issues with shared Rx queues.
Specifically, issues with domain mismatches:

	Invalid shared rxq config: switch domain mismatch ports 0 and 3

In my opinion, additional testpmd fixes for shared Rx queues or a revert is needed.
Please find the details below and let me know what you all think.

Best regards,
Dariusz Sosnowski

---

https://github.com/DPDK/dpdk/commit/8ebba91086f47c90e398d7775921e05659c0d62f

**ethdev and mlx5 driver behavior**

In DPDK API, to enable Rx queue sharing,
the application must provide 2 parameters in rte_eth_rxconf struct:

- share_group
- share_qid

2 Rx queues can be shared if and only if these queues are created on
ports which share both switch and Rx domain.
In mlx5 NICs case this means that queues can be shared only between
representors for a single embedded switch.

Both ethdev library and mlx5 driver do not explicitly require that
share group index is globally unique.
The same value of share_group index can be used in different domains.
For example, the following is allowed:

- port 1, switch/Rx domain 1, share_group index == 1
- port 2, switch/Rx domain 2, share_group index == 1

In this case, both share groups are considered unique and separate
because they are set up in different domains.

**testpmd**

--rxq-share parameter can be used in 2 ways:

- --rxq-share=N - Set of ports is divided into subsets, each with N
  ports. Each subset gets new share group index.
  Index is assigned incrementally based on port index.
- --rxq-share - Same as N=UINT32_MAX. In practice this means
  that all ports get the same share group index equal to 1.

In our internal testing, where combination of sharing Rx queues
and dynamic representor attachment was tested,
"--rxq-share" parameter was used.
These tests relied on assigning the same group index to each shared queue.
When new representors were probed, their queues were added to existing
share groups.

After this patch was applied it is no longer possible,
regardless of the --rxq-share option variant used:

- Without additional N parameter - probing 2 different PFs and
  configuring shared queues failes on mismatch.
- With additional N parameter - queues of dynamically added representors
  cannot be added to existing share groups.

**Possible solutions**

For now, I see 2 possible ways to resolve it:

1. testpmd assigns unique share group index per domain:
    - Behavior change for --rxq-share parameter.
    - Instead of statically assigning indexes based on port index,
      testpmd will internally allocate new share group index
      per unique switch and Rx domain.
    - Drop additional parameter N for --rxq-share.
2. Expand testpmd parameters for shared Rx queues:
    - Allow explicit assignment of share group index through additional
      parameters.
    - Right now, it's unclear how to handle dynamic port attachment in
      this solution.
