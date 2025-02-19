Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF10C021B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 13:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ABB540E39;
	Wed, 19 Feb 2025 14:43:32 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
 by mails.dpdk.org (Postfix) with ESMTP id 1D4704003C
 for <dev@dpdk.org>; Wed, 19 Feb 2025 14:43:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1KNgMWqH7Xe/hpR+ADmOfPiynaWCPUhST3BODGCnSPGABrC3FarfXEllNjNDtaKHO8/ftBCRZZ242q4pYm7I3M0quiHd7IeZ7nERV4DhcYRwxMSFMNZ4QWV6IS3PGOtpL8OYR5Ts4Y/NYUirTWo+V82ovIgFGbfUeFas9HQKgHReZ6zI2/x6qm7tgJMa3uhzYGQyZEblyeez28BGTYl0o275SShkLscbopKZ7BfP/1+DNRd/QHKBYeAoPW0AFa8ypNcassWrnLyZh2RMlti4jarI/ZujtOzCw9RYCdJbThGkbCvWnXLxsOylGw+267ETRUiYXF71S5GmoX7QN0WvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcqvQJpHglliYs2x0U6GFQudkZAH7dyqlQS1sOcI2YM=;
 b=tMTAx0swMvAkkeGYlbfSfBBKrjau3nSWf8K73Q01QJjZeCwc4NKlVXWV66iFOAILEgOl+i/RUcRDLsU2lMz2gh+h17Xo/B/hRHOt2fupyZcxnn+TMWdtO93isp5K70AA+18DJAK7jQwU2j4ECbMeu78QXK603rdq6oCsir5bcZsmb3VvXP8SIG+R7UA+HlAD9gFof7irpQy6Xn1JMhfU9234Shy0WoWT0m75i+V07fhrF/1RPFEd99uB4pbckmtqwNGOyymAul6tOXVlA0V5wYo0zjKsIMjbzbt4u2rWCTExVnDoAcUAYMjjnxYNESRE+dH9LGktXOCHcR95FjkQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcqvQJpHglliYs2x0U6GFQudkZAH7dyqlQS1sOcI2YM=;
 b=Z1kMJPee+dqy2UkbKZ1QrEAYLnCaiDvdWy3DVFS72FvvXZPOA0Gypke2TZxrsZ1cT4gJ0rCjJq36qQp+F72ToJVT8Yhg4hBmdMoC8xtQ1ACUvL7kO6iULg5FYEGPNkDwZvabGxUhnPSiVx/GAfWyBAE2QK4HNHHoqO516aEhA1h3fJXTj0fbI7iGPg3hHYHq5vH8sa/cjC5PGHgOm1VYyyd6YUYREVNwj50o8VVOBzUYsQhmh8U8Iaxk7wmizUBofk+vJKrwvYQQlALWCvJJiqVNKbEtcFUkvbPg/UEqpy0NM214Qo+eYFw/VCUqmlzlqPGv92jwsXb5qh/TCT3XJA==
Received: from AM0PR01CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::16) by PR3PR07MB6969.eurprd07.prod.outlook.com
 (2603:10a6:102:74::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 13:43:28 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:208:10e:cafe::1f) by AM0PR01CA0075.outlook.office365.com
 (2603:10a6:208:10e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 13:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 13:43:27 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 19 Feb 2025 14:43:27 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [RFC v7 0/4] eventdev: atomic tests to test-eventdev app
Date: Wed, 19 Feb 2025 14:43:21 +0100
Message-ID: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
References: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|PR3PR07MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c08781f-5ee6-4be7-2286-08dd50eb63d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?71mFN38LcWwMBR3JmaX4xS5Er6kYurXvhngNG1GMOPzagL90wh53zyt9vR9U?=
 =?us-ascii?Q?QyjQ+3FiE6KRbVRmFWfMp85E9gJJXKxYA1EXTsOC4fkEjt272aNRg5ijjerZ?=
 =?us-ascii?Q?RgU/I+AYG2DeRs4LPgo7JUhWSa5elP68mslJjhs/9fjoJPjgGbHwpU9O1TOU?=
 =?us-ascii?Q?uUw7KdCqA5Oq/fqCx8KrqMdC5ocps0hXIV6yWqCF8+2zHab74jUloonl+Iaz?=
 =?us-ascii?Q?ojv/pB97fKqgJiTb0knw2T+nUIbGQya/KiMNHVW33szFEF3tLq30Si7qWtgR?=
 =?us-ascii?Q?ZEzCtS9gFIJ+JkGgQ731zrDGyl772uEp9BwbbxmehJ7b7StGGNTyWGgYyg+U?=
 =?us-ascii?Q?2JX3U+OsssecqaqsE/8yWSaWhqj7XPYXG5rN+nXqCU9VG0c0Ui7JlUpKAFSt?=
 =?us-ascii?Q?pSyk6fAZBFH9Bwn5P4e6f2ez8snZa9GuIdjXTKCVCCgNx0TBPXKcei/13Z1h?=
 =?us-ascii?Q?ZPvqw3kmkOMetzpZyZCpNGCWk0osY3O4TPjfX9rS61Nzf10UExu64obf1Txs?=
 =?us-ascii?Q?d4LgqYguYWbVdqpxX3G3fhyEpjVInkoqdh2WxvJHaVPhougxR7mBJfhrQHLC?=
 =?us-ascii?Q?ItxT8gd49enSvmILjinn5hEiwCMGdgfXxpWXviMHVdu+/XFCIz/qLF+7tPZL?=
 =?us-ascii?Q?WDH2H3gs+TN5QoEVzBKYuSfDxz4kcGjnIy4fGZk0ci17sW9uApAxjln6LuaW?=
 =?us-ascii?Q?tJC+u0XcfJPlGqER011m2tY/6k57fmBPXO+b7pP0JsnY1PnWI/xPdLEOJXc0?=
 =?us-ascii?Q?wKjSrmqG8zEO8X6tysgAy9DK/zWoLaspO8MzFBwatVjFkYgXAKd0nxZ/87aj?=
 =?us-ascii?Q?45vHlLEh3iQsyefwJb7MG5Bg+ZToMRbxhFGHzYPcBSfKDu8lsr8RouoinVie?=
 =?us-ascii?Q?tU4wxgwNLmjN8x/OrwPL272v7MdVQNYYvpzM+P0ZujJ+KXz5jKW00CwhFusS?=
 =?us-ascii?Q?8q4ycdAFH+f7TM1nLg6dlRuUizKRnQFP3dDd+w39yO1zBUrBcZXPnVmsNGID?=
 =?us-ascii?Q?9QJLrZTDLORi0HvAO39QMgWrC7nkupZ2D/AMjMR9dL5DC2OwqqiGNHHrU+Zc?=
 =?us-ascii?Q?CkoftJYsKixw0dAjngcoiIoNi3r2VG38l4clhDuQKFO5AExuG2IPfjXFBpuE?=
 =?us-ascii?Q?MVZy0i8MxdL6zLcBH8JMZeGDCovf7I04s69+UiekWwKG1FcspMp9IzO773QI?=
 =?us-ascii?Q?gL2oBnWO1WvWIbaCHda/3lIc9qjxzcSG/+6rV2a8M4uFxIkjv3jAwTqcvUy4?=
 =?us-ascii?Q?1PmPHW5KMGMnmHUwDW2tUMOLVjKSA/t7WG6GiY/4sB/G5SCllMZI7HMbk3KH?=
 =?us-ascii?Q?mFpcIRlYdr9J4z74xxreAekG4O1rBvLrTbeTeBh8mIBkLo2U/erN1jn9cKUU?=
 =?us-ascii?Q?JeFaraoKoXDmDhrQvsNZXL4mkkGGPaWPY3ehi3QrF6hpiLtrtCKbXDE0CIXM?=
 =?us-ascii?Q?G79g4MgSWe+z0xf+lctZmVFctv+zNTSvTmmCIwG+0X1TOTqEkNcS38/hCADO?=
 =?us-ascii?Q?JODBmQA7yreqoPE=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:43:27.8564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c08781f-5ee6-4be7-2286-08dd50eb63d9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6969
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

Luka Jankovic (4):
  eventdev: atomic common for test-eventdev app
  eventdev: add atomic queue test to test-evnetdev app
  eventdev: add atomic atq to test-eventdev app
  eventdev: documentation for atomic queue and atomic atq tests

 app/test-eventdev/evt_common.h                |    9 +
 app/test-eventdev/meson.build                 |    3 +
 app/test-eventdev/test_atomic_atq.c           |  216 +++
 app/test-eventdev/test_atomic_common.c        |  134 ++
 app/test-eventdev/test_atomic_common.h        |   85 +
 app/test-eventdev/test_atomic_queue.c         |  230 +++
 .../tools/img/eventdev_atomic_atq_test.svg    | 1588 +++++++++++++++
 .../tools/img/eventdev_atomic_queue_test.svg  | 1701 +++++++++++++++++
 doc/guides/tools/testeventdev.rst             |  155 ++
 9 files changed, 4121 insertions(+)
 create mode 100644 app/test-eventdev/test_atomic_atq.c
 create mode 100644 app/test-eventdev/test_atomic_common.c
 create mode 100644 app/test-eventdev/test_atomic_common.h
 create mode 100644 app/test-eventdev/test_atomic_queue.c
 create mode 100644 doc/guides/tools/img/eventdev_atomic_atq_test.svg
 create mode 100644 doc/guides/tools/img/eventdev_atomic_queue_test.svg

---
v7:
 * Refactor common atomic test functionality into separate common file.
 * Implement atomic atq

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

