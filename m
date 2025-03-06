Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD0C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 08:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4AB54029E;
	Thu,  6 Mar 2025 09:49:51 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
 by mails.dpdk.org (Postfix) with ESMTP id 774C340156
 for <dev@dpdk.org>; Thu,  6 Mar 2025 09:49:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoO03Oo4/kyuZsGkVkVLYkPfdGDj1Np87/0Z6vgpQAdzA59EfYDEjTp+Rjos3BLECSgEHyY94DlxpO2Iecr6K4LEaWlPPw9ZImUVJBwg+yu2F0/vor2pQkAsvOhjSN1+03VXJ7nLwO0FXrk/uisrG/hzXkgRusiQCwAt126z8FZ3V47Nv3fp+epcZNhzRzruwlQ2cWk99EpNLz1Jn3iJ+05xZb3Q1YZEoBRDOkJ+XzKG9fGI/uqpckver9MIg9pTCFosax+yFHn0G1Ysp2ZRVTZjJ0/5E39A0RKyKtnB5B/vFji/4ub+qRYlJP7L6L8wO5iKdb3p4f3F061OEJIGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQJx2prfRZ4m73gic6gd/HZKzgrlLpRdJ/mINS9wGZA=;
 b=qVCSp5ZZVCGIew+ZwtBn4BNTazCI42Mtll8mTnKuz9AqGMffdxFP1wL3m1y57B9wGoopJB4AglnLZfkxGgnNt0Ck5wZYXIuWlKTU99unptoXla4/E6bk/HOkr+5PPwJxAXtQs0zYTz0fWpFLFZ6lQtn4op68/UXgX5hL5WJlx3nQ17xW6UYE4sv0l8OhxgbGsmGDqGX+2zAjIgtwH7RSn2o5uWKFlnMXTMaR5fzm1OOPQWAi3k9qbzGfiL2FnXRlecmhfmHdHrrMxDAmrVR7sEuTB6s+WhpqGTvYEp+k1IXYaxlNKKmhPRjvmeF6d+nfUCynkFbb7TFbSpsWOw0B/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQJx2prfRZ4m73gic6gd/HZKzgrlLpRdJ/mINS9wGZA=;
 b=FwFForQ9O/C7jr2J5CHKG143L3FJYs9OxenchbczQEes56eEMkZpfziYEZq2yztAr2TYW3M7Nsg+Qxsi6RbnsDBQoW0z6bN66z0EyZaAeBr7HlHOrWgj9zoEjpCAUIqaC9AEdo4ks2ckeSJwVKCLiVDNw7fQxdnpqxOj3PA6mDNF9LAwLmUg8FxyZFjAMVelxP7QXj5Jz8jRt0eGBBEr/5MW2gQYAurd6WqyVG5YM1JYr62iWmtrnrtaG5ATWJVA0igK3LbQYl0oGFNjWbmtGaKac0xBkFzGP3tHb6ujQ0kdj/xWczjYcBAP9tj7oHikhRsU0uJryVPRbpOZ415y0w==
Received: from DB8P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::37)
 by PAXPR07MB8604.eurprd07.prod.outlook.com (2603:10a6:102:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 08:49:49 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::50) by DB8P191CA0027.outlook.office365.com
 (2603:10a6:10:130::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 08:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 08:49:48 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 id 15.2.1544.14; Thu, 6 Mar 2025 09:49:48 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [PATCH v10 0/3] eventdev: atomic tests to test-eventdev app
Date: Thu, 6 Mar 2025 09:49:43 +0100
Message-ID: <20250306084946.3699972-1-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250305141255.3031686-1-luka.jankovic@ericsson.com>
References: <20250305141255.3031686-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|PAXPR07MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2391fa-0eae-4369-1a99-08dd5c8bda2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VhkkkjDsLAAhuQCoO0meE5jSYgBt3Hvw/1uQYEG6ZymC8WAQyCspWFihmGZx?=
 =?us-ascii?Q?3K8xvp0CQDCCC7XmfbYDQQAoBQqF80yninobp6AE+TjKgnSIF5WqM9HDQItT?=
 =?us-ascii?Q?q32lNGFODX7QxfeYecawa/eJLTyGBazTTRqI9eM+F2j7gq2nqK3gOuNLgbBP?=
 =?us-ascii?Q?rKpfOK0PH3iY8GpJyVqUH2oAPhMkNTFvXN7n1czxjkMY4fiiMlo2CvbjP2Ww?=
 =?us-ascii?Q?p8r1SXdHigBBNjnexKVRB9jaB5F7XvAfIqg5trf1/dxBzdPLbA7kneQFMID9?=
 =?us-ascii?Q?0nTOmkIeuYLFeT/LbJTzv1IdWLHYlZKWJcsiTbptd2V7wqBtKGFqPAD0QQ1H?=
 =?us-ascii?Q?/DKumwKTdNhC+5hLYHO+Hf/PvL7u60/OUh0kx3IvqNvuvru6ghDPTYppXBHo?=
 =?us-ascii?Q?AL2OEG3Ruwahv1iGOD6IrsadoqFPaBog+Vr44j1xBNUGpmclDhiE9A0FFCS4?=
 =?us-ascii?Q?lmVSIwaHjOIX/QZ9VUTSdMh4l3UHs11oClYOCvSez2q77lyMkIoUr4K8KOS/?=
 =?us-ascii?Q?FRTW7HpIbc/Z8D1h/ISlZStBh3EXcI3y1W1qmRySNyR19qolh62429LfnzSz?=
 =?us-ascii?Q?PN3KLK9gZ7uD9YciwT8YPXGxgVQxfV9hKaHzH0a7RGpVQvY92EBjV1iNDtCz?=
 =?us-ascii?Q?a9svEMZ8CCKbXxVj+GkjujAP4MvbUxPfEbBuRAbQ4p3CPoVSBrdXxL3TNwLM?=
 =?us-ascii?Q?J7cXHhjlVqPfIRxNvCjW6wwnbqhEEQWN2LgKJLo2zO6veoQHj5pgIapZ0GIZ?=
 =?us-ascii?Q?DhkENiqVSM4Kj19zENk2qrEz7rREqBlIaGh/iysuXO/nEBfoYZFElM1raI+n?=
 =?us-ascii?Q?/1US+rNHb1RgvxW99Mt7Bfgbk7t4RegfyKi7dqErFPPXEtHPVPbkjkremQKn?=
 =?us-ascii?Q?lpmKfFPZPn5BaUGz3Z28WQhireVfKp/K1VQ3oUrWL8iD46xcfgKppvtH1BL9?=
 =?us-ascii?Q?46+bRw27XkrdD92HcZkL4axxJk2qcdAhcqtyYWO8nGjoAQp57kzttLRhgqxb?=
 =?us-ascii?Q?I1rWfmifdVY9mznIBIAlkenolN48qubZWfM0T2iC0sWGUFbkEqMpKFnFfjNv?=
 =?us-ascii?Q?SdK5gbh1wylRJte9RJj/kij2KpJKjxRg6LZov6z+NVAoY7XyNYm/x78QZXQj?=
 =?us-ascii?Q?6e/xEEfC+LlBwnggo9kYLTUucZuwDolaX6A8N8DUsyEz5ZGCyGJlwMy1Ei30?=
 =?us-ascii?Q?xk+B8fW4BYVesYzpSQYkbN5tGkkMC8bJw8iNOdQPix7nKDZN4MGyaV6cwEP3?=
 =?us-ascii?Q?ZVB8LR+hdl8SbygKAcKunUFH+y2KZ6OFrtQrogFKJSMmiJzJfHvtlaGGmxq3?=
 =?us-ascii?Q?jnQy1ysGkKKW9m4R/Vgmqz8TfTuY7xcmsEa1RlSAq6oIGj8OpStWAAFseWFW?=
 =?us-ascii?Q?CUXGscxQHUpmH2TJ6VwgNY/EZS/IDGrQtJU268rG9+x7Q7QV27KFmzMX71aQ?=
 =?us-ascii?Q?Ipju2MhH0kRJVTDilroUbqU5UeBBgdpZpgyUn86w/DuHND87ZIDGVg/LxyNE?=
 =?us-ascii?Q?JreSER2tsyfiZoU=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:49:48.6099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2391fa-0eae-4369-1a99-08dd5c8bda2a
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8604
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
 app/test-eventdev/test_atomic_common.c        |  136 ++
 app/test-eventdev/test_atomic_common.h        |   87 +
 app/test-eventdev/test_atomic_queue.c         |  234 +++
 doc/guides/rel_notes/release_25_03.rst        |    5 +
 .../tools/img/eventdev_atomic_atq_test.svg    | 1588 +++++++++++++++
 .../tools/img/eventdev_atomic_queue_test.svg  | 1701 +++++++++++++++++
 doc/guides/tools/testeventdev.rst             |  155 ++
 10 files changed, 4138 insertions(+)
 create mode 100644 app/test-eventdev/test_atomic_atq.c
 create mode 100644 app/test-eventdev/test_atomic_common.c
 create mode 100644 app/test-eventdev/test_atomic_common.h
 create mode 100644 app/test-eventdev/test_atomic_queue.c
 create mode 100644 doc/guides/tools/img/eventdev_atomic_atq_test.svg
 create mode 100644 doc/guides/tools/img/eventdev_atomic_queue_test.svg

---
v10:
 * No changes.

v9:
 * Fixed incorrect patch.

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

