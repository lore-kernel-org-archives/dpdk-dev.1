Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB0C282E3
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 12:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17CAF402DD;
	Wed,  5 Mar 2025 13:52:28 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
 by mails.dpdk.org (Postfix) with ESMTP id CBFE34025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 13:52:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUudUhs2UUHeXQFQYN8yxd46f+Qqc2SJggRYvQ3vVc659g5iq8JOvl88eQBWYYilyWbNjfL3ar5raT07wDov6jxFgkXQQdxA8WXTPOfQ6BY+1AJDt/2mhB7DWE730sXAG3tuWEqdZMYmnkK+arSfgqYysy5gdSHgvCkiTnAF00woFar6wQgrhM6k8Amv5e2UoNl0OwzDW16GjB0hj1yRaTjJ4aPinZ9PSppcCuxhcgVn4hs4CQE79BL/o5ZClWP3sr2aE2TWRoni11KgC9qn0iGO89i3hG8t2jPENraswreYY/Ozwu3LAe/qRjHNot2963fM4oIBgWYH4DD5zgpJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4JH4OkElRDsg++qSjcNgtRi/G2zS67n0+2zDudzJ6E=;
 b=Wlxx9BR3GIkkQrbjyhHdiW5bG7nBpNGkCfwazGTHiwW/hBqoOPHeh7hjjw1uKojb/OBjpDYsAG89Ad6SewsQU1MtfI7Q9pvr4Y47UDPrhznfFCqbSB1DoVzeAnnARi51n4Ae3KGHhYmX/D/gtbTwZu2TSOxgfEqeh3v4a0AJEo3JBAls3foXF9M9hDO56ONAWVwNJl2eHw9L9n6svZ+Ku9vSL7YEysTGhhnIwFzSUAMDIK+zqs9vp3xwQ0l+ETxqPXd6cmT+9MgZS+Yqjn9iXiL4gZH5Q675VYqqlquSLp/MkNRPQFgDkHUIVL7V9Ff17I8KlXVonztcBv+zITSECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4JH4OkElRDsg++qSjcNgtRi/G2zS67n0+2zDudzJ6E=;
 b=SfSDgwhqX35V4+9wCltZOxNwy1VzdndDgIpsQqnPSzdcjV4cO0b//sg2UyfgMCDhigQt0nF5acdHlEW05YrWEge2a7iK1+EOZ7WqHQ99/X7QNqLNXE8LfBMIqDeBekeU/t1Elyc0XmhlD9BDYlIhq2BjcljEVrhnXjf6VnqeGYTGEwnpZRWCALxYeNQz4WYCorqvVIs5RcGrNZAjVuJ6PzYs5GAnWMPUf9RzOxcoA7txJ51UvHgFbKOrk3+FmOBVA60/++8oXT+crFP12Nk0nAwfngI7b6vIJQxjw/Fe6jcr/zKnU7h7zms/Hs4qDrzJW/shGWL1AQsWQdEG1UOkZg==
Received: from CWLP265CA0525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18c::13)
 by GV1PR07MB10191.eurprd07.prod.outlook.com (2603:10a6:150:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 12:52:23 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:400:18c:cafe::5d) by CWLP265CA0525.outlook.office365.com
 (2603:10a6:400:18c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 12:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 12:52:22 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 5 Mar 2025 13:52:17 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [PATCH v8 0/3] eventdev: atomic tests to test-eventdev app
Date: Wed, 5 Mar 2025 13:52:12 +0100
Message-ID: <20250305125215.2870237-1-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
References: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|GV1PR07MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a15738-498c-4864-ecf3-08dd5be492a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rb8XDaiP5oBWlzPgnbHGpFoI7VQqIVecBstZmgb4ozFNeOfOy9IbSEa8qfTA?=
 =?us-ascii?Q?OP3YMdVERNS1yazEwL80WHeSlmpci33ksvmuQEFjscGQLQg19T3BUsyKth/q?=
 =?us-ascii?Q?lhrSW5JF+onvBFLX5mhNWbs5Uq9D9kXEAUiVdDf8hTzxfzNnYn7rKyWeFXx2?=
 =?us-ascii?Q?c6prRHUecCwcThLhxn6hLiH4UgPG7vhSd3qXU5Mwdhy76WjMXpr2DsyzG/Nv?=
 =?us-ascii?Q?bn8O9ZQngW25QQMFCAI/qzJAndVoh+bRvlfqO+5igfi7s1s6HE1JfcZ0ZGf8?=
 =?us-ascii?Q?cHW4EzosHRpoLRphuLNaksTR8m4fO4QJfDoMoSLfKoPRQJtZpitwmHbz7VNg?=
 =?us-ascii?Q?Dtw5IXaqKEYU1SJSTt9xwU8eGlR2Cpf/d9Blc86NfN/yMURXlkr4pHG4uPDS?=
 =?us-ascii?Q?50ORM50qTERvGvaRTyZc5K6GejTmYRph8WUHKAxKaQ/0ke5qyMm8nEyD/pQ2?=
 =?us-ascii?Q?iTA8PzEZcdVNDT75Hc7KF+uJyz+bN2seTLkwUtKkElQ5TcJbU8LLfznii0Qb?=
 =?us-ascii?Q?l/8JuUBpxcrWO0r8Y3iKwJkTiZ+LHOkZ9PmLWb2Yad4zrojc89sHAYbhOjDm?=
 =?us-ascii?Q?STqBxtPhuIk/5X9Xj9aSsSjHCCgKqagRFiyc5qPO90XIoT+d0g092ZnTZete?=
 =?us-ascii?Q?AYSWounM/YDgTeIx5WjpRYMXJlRMNdghAdYBHFUy3Qxx3O06BQ2sjlLeZGGt?=
 =?us-ascii?Q?9BM7W5hVLmTsXVaHwXW2ksiGiDfshg+XceJIL76zEWrS/JExAJTxA01QEgAz?=
 =?us-ascii?Q?3X2zI5pVICGzqh1i2QRyWuLGDLo0T8EgS4/r3UU99jtIQcpMZJZpSl+BfqPV?=
 =?us-ascii?Q?4zZTxJh4dtlDwR9GGCsnbnO8+Df7fhRZTdw8DUf+1BINo3eKNSbFM7KUba+f?=
 =?us-ascii?Q?S4JGrF2oZQmNYtd5DnNbrfVAPQDZeEPIMcIW853l6wYwnJXa180LvK+XL1cJ?=
 =?us-ascii?Q?iEyx8ed94lerjQ/G3+RyPbBDjUx5XRKcr11bi+icJzt/8+/CuLFlWY7mis2R?=
 =?us-ascii?Q?Q/ICQXpQKIhbYq8G0oge8ErWu5T4HHGdRR1dgy1AIkYf9qpIOAndLTycf8VR?=
 =?us-ascii?Q?5TB2LnjFl3RLvwCHntK+nEi7deyiu58M5uvM/C2P9Q4i1lC1dfKrkoLYNNeT?=
 =?us-ascii?Q?HJmCvU+0PM3iBrO/AjWElyueTGRA3z6+MQv6Q6zzxo9Vj0MG5Kb64CQC0NSN?=
 =?us-ascii?Q?pHpUmhKKcJhYv8kA2KuhFslCQWW5SwXu2KRythvnkG41DiSFBSHGohujZ/lh?=
 =?us-ascii?Q?J9v6mbpLcTk+0b0csTDJ1TmIbe0ZuCWpX0oPS2UdvpYxYyolEdUlPasVrsj4?=
 =?us-ascii?Q?QHjo5M1TSGOE40TcwwFeFsktEZUBJG2ANxJz5hT3wjPPY0de/vxmAtSPI9rZ?=
 =?us-ascii?Q?XYPY9Z6HFrkPcBe9Bbh2Co9A+ef5mBQt8k+KMj/KiEYPX3mfgG9ULtcuaPiQ?=
 =?us-ascii?Q?v935fRZUU1uQg2NlrYYzWRvi1oNXTcsc1i6RXy3fNiPXp2olk8YcCj42oiz9?=
 =?us-ascii?Q?/3ZufsgUK9+Hl50=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 12:52:22.7134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a15738-498c-4864-ecf3-08dd5be492a9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB10191
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

Add atomic tests to the test-eventdev app which correspond to the order
tests but use exclusively atomic queues.

The test detects if port maintenance is required, and so they are compatible
with event devices such as the distributed software eventdev.

To verify atomicity, a spinlock is used for each combination of stage and flow.
It is acquired whenever an event is dequeued for processing and released when
processing is finished.

The tests will fail if a port attempts to acquire a lock which is already held.

Luka Jankovic (3):
  eventdev: atomic common for test-eventdev app
  eventdev: add atomic queue test to test-evnetdev app
  eventdev: add atomic atq to test-eventdev app

 app/test-eventdev/evt_common.h                |    9 +
 app/test-eventdev/meson.build                 |    3 +
 app/test-eventdev/test_atomic_atq.c           |  220 +++
 app/test-eventdev/test_atomic_common.c        |  138 ++
 app/test-eventdev/test_atomic_common.h        |   87 +
 app/test-eventdev/test_atomic_queue.c         |  234 +++
 doc/guides/rel_notes/release_25_03.rst        |    5 +
 .../tools/img/eventdev_atomic_atq_test.svg    | 1588 +++++++++++++++
 .../tools/img/eventdev_atomic_queue_test.svg  | 1701 +++++++++++++++++
 doc/guides/tools/testeventdev.rst             |  155 ++
 10 files changed, 4140 insertions(+)
 create mode 100644 app/test-eventdev/test_atomic_atq.c
 create mode 100644 app/test-eventdev/test_atomic_common.c
 create mode 100644 app/test-eventdev/test_atomic_common.h
 create mode 100644 app/test-eventdev/test_atomic_queue.c
 create mode 100644 doc/guides/tools/img/eventdev_atomic_atq_test.svg
 create mode 100644 doc/guides/tools/img/eventdev_atomic_queue_test.svg

---
v8:
 * Add copyright notice.
 * Update changelog.
 * Prepare for merge.

v7:
 * Refactor common atomic test functionality into separate common file.
 * Implement atomic atq.

v6:
 * Revert the use of event.u64 to mbufs as the Marvell CNXK platform assumes
   event.u64 to be 8-byte aligned, which causes the test to fail.
 * Clarified deadlock error message.

v5:
 * Updated documentation for dpdk-test-eventdev

v4:
 * Fix code style issues.
 * Remove unused imports.

v3:
 * Use struct to avoid bit operations when accessing event u64.
 * Changed __rte_always_inline to inline for processing stages.
 * Introduce idle timeout constant.
 * Formatting and cleanup.

v2:
 * Changed to only check queue, flow combination, not port, queue, flow.
 * Lock is only held when a packet is processed.
 * Utilize event u64 instead of mbuf.
 * General cleanup.

---
2.34.1

