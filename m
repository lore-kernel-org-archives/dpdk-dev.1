Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDFECCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 06:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A6984028E;
	Mon, 19 Oct 2026 08:45:50 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by mails.dpdk.org (Postfix) with ESMTP id E2BB540269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 08:45:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWksbLjhVLG+sz+qSgSpBYzq2zSmonh4THYp0R6qVPFAcRTevxNMxCssVhtq9Sl3rc1uzwzGHV27BBXDO+8tY2Ohit0BwzINb/N8jKF50t5ihX8HKI93182w2Xaw6j+XKxFv+z7oIBnMd5heCtnbubABSxZ3d9r9bssBfUJvlsA1Wu79LDk8g0sC4UhFY9GgCa8U6Hm7aJx7hEymQrN2BENuvcS1i9OU0RjP/tc/l6DgrR852cdQ9kG4nuY+BeUZxjWd2ZSLCFtjxnTAaGLs8+We24WdC5VcS577Qa8BmgAH8BkjRD46ETC8aPpVPGLvbXZ2suYkI+buhKPIauRG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9WVe464gG/eL+oWhBiYQIns5GOUOwrDWQFdqXoEtvM=;
 b=YadpUSHO3mUVHSsofaNrXj9JN65PrZaSSZvjfHAGXZhMpoeaIK8uwBE0ddNT+m72k53ifJmHbf8VE/6pgFYGC35LS6wftZaqbxRAsO8kNWivbCea2tbZmnjhKMa4HuRBdjMOchor8BQUHAVvZpNN9N19Hj6jKL/vtcn59Q27jwWc2zDeCiYQ7tOdop+GtsANpleQUV5V+SXLoaJwbAFbHM1pUagZGUA7M6wjbbv5/wyK8OxPkSat8RY84GvjHf88YHxCzLJMm3j56RUs9XKUU5RLlC2XCAj/66t2izS+hKgrUL9Vi5FxWBvUscZFeD5JzkRGZATO1KSnPNa6thLYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9WVe464gG/eL+oWhBiYQIns5GOUOwrDWQFdqXoEtvM=;
 b=X0U971Su8uZC5asVjXuo6rYEIXVD7wFMTsZ8EMpme+YWvitbmwUdSOj7ix0IkOyYwekFwXAsSgQ4DsHoPtlr0fpA/CJsbxcfD1gsP62274sKHbm7KMCE7BsPvjsOMPLOR4q43mt9U0+/yMHwbDhcV9FyJtCuBf5N7nqZrCjqYn8=
Received: from BN0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:e4::13)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 06:45:44 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::86) by BN0PR02CA0008.outlook.office365.com
 (2603:10b6:408:e4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 06:45:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:45:43 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:45:33 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, "Sachin
 Saxena" <sachin.saxena@oss.nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Selwin Sebastian
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>,
 "Thomas Monjalon" <thomas@monjalon.net>
Subject: Re: [PATCH v2 0/2] raw/ntb: add AMD NTB support
Date: Mon, 19 Oct 2026 12:15:22 +0530
Message-ID: <20261019064522.2834095-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJFAV8xvyNqfqfJk=SjKpJ-JsgRDybpzM5rtZVDORQMUcxhgtg@mail.gmail.com>
References: <CAJFAV8xvyNqfqfJk=SjKpJ-JsgRDybpzM5rtZVDORQMUcxhgtg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a959be-c6a7-40f9-6100-08df2dac9915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|6133799003|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i8Mrjb9K3Ornsclh6wAFbcVSzKMRB4MdtJm+b4APXkZPJoHPd3q6WTC+pdRKE+bizVpqMYJbWGKmGByAnmvqxb8tO7NkDbVf1EyshhPQJf8f21kihENUcHoIkXt1a1fSi1HjGsCxRn5yQ7KiZzAmV63pYqnyw3LEc77r1oOmjmI2a/DSCXmcIoPv2GA0sn2CPchYs/NzvKB5LXA+MQE/+GdySU6Vh6rZ2Xqi7DN7zm+KIeyJDepfU4RAzT/mZkcHfXGqWP0u///Hj3B3Bx55OyPK7E9iArrn1rdSvmG+J54NGZYjwpMu4NK2uQKvNlLHPc1I3B3TLn3+t0lWUflm1dfQDICDXTKw0miJiNMJKBUp8V7T7fio/J47SgYH0jIiz6bUmvFaPJFcZgZc1Kd5XA6ieGs2N4f9O4mdw6Lq8kCtAfig8otujQBT94A7nFf5o9RuVEEQ0690fmHa64WP2xiQYq2zEQtK0McPVz3SRaQmAShUII38SBf9xGiS4vI9zFNKiMmVNi9kf36W9YgMYDMAhrJpcvvXencuwGh/mgcVnf/nBiCy7gA4Szy7DKvrmK+3Xl+JUpFTw2jdAGwRy+b7IB2cA9g+hh/tmxIfrAfMS20WpFlOSY13CPGOuyvCh8mVi+PFjeptP6/UiY0vdOOOkzWXQ0NnE9QVUhodcjfPz7DeaPVNRMaNmyiczGlTYD7nCa1995NJqFf5XKRs7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3n4R4KsvK3EgF0nIqNveJqBbVCWPaWzx3NlDWbJajWiVvs0lpkoCEpc98hRTJw/1qcgfQ2IDxSFVug4N1x2E9WaGAaYMJ2Q2WeOoIxOpZlKze/msLTzjdOg9EriP7IILLit53OD3TtO4+7hFujdkRm1OWtLcfd1w2wsrtfa+vqtODDl7LUicIb/v72j84jAFJAZ/dR8p/IdaaRc56LbmbYGeN1X1c22qVCaEX5qm6nr8rkCO41UwQyJlCEnAVTfgsKogjy31sUqTH2lgLL4A1JM04PkHbqbeZyB5CMTOFjmVyF7dm7wIx8NNuDqPUfQND3sfR0xwAdaHYmxiHnyJvrzDcYNM4oJyml9ETTJXMoSFEi9zZ29Nf/JbUXtBXUwFApljiM1Odt8OecNBBzGa4dUaqA041ns56nyeSLbQiGKTHdCwzKgHdlZw+5mA0mPf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:45:43.5413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a959be-c6a7-40f9-6100-08df2dac9915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

Hi David,

Thanks a lot for taking the time to look at the driver, the feedback was
very helpful. I have reworked the series accordingly and will send a v3.
Below is how each point was addressed.

> the driver is riddled with runtime checks on the ntb_ops presence.
> none of those checks are required [...] all ops should be enforced at
> probing time when selecting the vendor ops. This could be a first
> preparation commit.

Done. v3 patch 1 ("raw/ntb: validate vendor ops at probe") is a pure
preparation commit: it validates the mandatory ops once, right after the
vendor ops table is selected at probe time, and removes all the per-call
NULL checks scattered across the common code.

> The handshake op should be mandatory and provided by both Intel and AMD
> implementations. This probably makes the mw_set_trans op a vendor
> specific concern which does not have to be exposed as a op.

Done. dev_handshake is now mandatory and implemented by both drivers; the
built-in scratchpad handshake that used to live in the common code moved
into the Intel driver. mw_set_trans is no longer an op - it is now a
vendor-internal detail of each driver's handshake/cleanup.

> I see no reason to have a separate interrupt handler. This should stay
> in common code. It just needs some abstractions of some operations:
> read_peer_config, peer_mw_validate, link_cleanup.

Done. There is now a single common interrupt handler. The AMD-specific
handler is gone and its logic is expressed through the ops you suggested:
read_peer_config (already present), and the newly abstracted
peer_mw_validate and link_cleanup, both mandatory and provided by Intel
and AMD.

> Only handle_hw_event seems optional, and it is better to keep optional
> ops to a minimum, this reduces the runtime checks.

Agreed. handle_hw_event is the only optional op; it is used by AMD for its
SMU/power-management events and is the single remaining NULL check in the
common interrupt handler.

> There is some rebase needed on the RN, and the dpdk-devbind.py (trivial).
> Please make sure to send a series freshly rebased so that CI can pass on
> next revision (did not happen on v2).

v3 is freshly rebased on current main (26.11-rc0); the release note and
dpdk-devbind.py conflicts are resolved and checkpatches/check-git-log are
clean locally.

Thanks again,
Raghavendra
