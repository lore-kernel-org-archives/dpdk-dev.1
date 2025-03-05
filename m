Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1F5C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 14:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0FFC402A4;
	Wed,  5 Mar 2025 15:13:02 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
 by mails.dpdk.org (Postfix) with ESMTP id 4A67040275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 15:13:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzB6zf3KSDR1QtWcI3B/dxscxjaw67VPQG4cdEBdu3py1VDRnVu2Ds2cXR4QEEEPYKCzKH8j6yX2qXNE5D6aMzsZJ9Qocmz2dVVOci86vk2JnsZP8sLhFQ5uq6kcPvsLCOx6anDka/2TJtQ7ff8hfzf6erhQmH4F5y38yY7E/HyGPYit8AN63oJxV+jFw9L5TzPZg65VjHwGOcvuU48Du3PPMTJYw/GPXsSO1Un+tQfz16xY88yXVHYHT2z1V2MQuM1MBoCaMooFhFYE6moFrZ6+hPBFfdbvV/wS8bwr8QokQk344HMFfBdPQ5R6FB0U9d5Ob7m10QuyuIgD/+0PZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2jk40DT8qNCNnmh84yoz5zmt9fiw4ASPw+fCxBR5nY=;
 b=CQjL5vzvxUsDekTmVjEOq8SyhsaLGJHQEEp24WQM8cTGYivsrbADTATYgp4AkKyFcI+HBY3UfCB4jbsml7vUXhZZglb+DmD8qw+GwEwWqw8vxr2E7n01MB1fgEPwsOw0ctDa9jEqfrUiITytY0vjayUutbYPQgt0O/WBkpGtLqrZom0lT+uXDiX/NwmkzegtYWpfBGXeNBwzRQ/6C0bDa0zDDQPb86w6nnOu2dKB6x2STrTP8RyZhNItgX1Z/pPbQfLfX9l7w82ZKQpUilADarpZ2uD9Z/IQuM5zZ+p/g7O93W64D8FsknvBi0u7mHGmGxJafO9wfkXQ0HPvY3VoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2jk40DT8qNCNnmh84yoz5zmt9fiw4ASPw+fCxBR5nY=;
 b=PPe1YVOssTgzkMZJi53XnnLg2Uv1JG3/prDj7I3ssMtw9ESfSEt1jCXS75TqhNnhzCRSvgwbQ8yZGTMDD/RUUN2CgkMmi4M3tafXQgyzTvBMqedKVSmu1BDKrLOaPIHIvxMG3l20LqtpyS2g+fmiTVrweBw1ysY+dqlgIkU45HrSO+jEc9Y4LbPLuoYWMQB2xZ+L7DvETA/f4GeIZr+7y8I1tKXxJjGIVxE2C7zlHqBGmI2CbefbElplwt9GK0yUoHWlGE+uwIi6SliJ2t9H3gK11ePuiaVrnR8WSXWx8IjZt0EhbLRnNkSxn1bCDtpxfzu8MfIHrhFVAAnIn5xlbQ==
Received: from DB8PR09CA0016.eurprd09.prod.outlook.com (2603:10a6:10:a0::29)
 by DBBPR07MB7563.eurprd07.prod.outlook.com (2603:10a6:10:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 14:12:59 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::d1) by DB8PR09CA0016.outlook.office365.com
 (2603:10a6:10:a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 14:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 14:12:59 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 5 Mar 2025 15:12:58 +0100
From: ejnulak <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [PATCH v9 0/3] eventdev: atomic tests to test-eventdev app
Date: Wed, 5 Mar 2025 15:12:52 +0100
Message-ID: <20250305141255.3031686-1-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250305125215.2870237-1-luka.jankovic@ericsson.com>
References: <20250305125215.2870237-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|DBBPR07MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: e17b1780-d6f7-45c2-5a61-08dd5befd570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fuNKxExhzlpoaFa/y0F2UHYYQbEcXMjQpcpZHl/bTxvKT4U3a6t8bQiNG5Ga?=
 =?us-ascii?Q?7POrxdhbPjiNltdscefJU+Nf0nD3R9fP4/BXHZSnNxAZCrQyQeLxDBdF47bu?=
 =?us-ascii?Q?rjVYfpz9ruTGuHB9jXVuhBrq63xgsvOak29SZi5S9acgQdNeplXyKK6nxK37?=
 =?us-ascii?Q?cwJc9xUoZwi+Q1aWREqi79MnLGAkRfmjnSYwqYTkUtvPf/WDzND8JuioIjYh?=
 =?us-ascii?Q?ykzUIQyOtPLnW1IVTOWM0VE7AdYehLLWnuGPMP4vDjjfWS8rJA/Uwc1ZSGT7?=
 =?us-ascii?Q?iOLeDd7vohEesbnBmHXCbHG7u/qz+fIeyJhM0CZCqrKb9uLDH7y1h70YgblL?=
 =?us-ascii?Q?Wk7GOD0YUxo94lpnw+tVP8ZcX4eKUHneuff1NIOZfLTBR0siym/O3VOdr92K?=
 =?us-ascii?Q?QBmASMsWvhSwMVrsmPWSGWMMtc1TcuZSV/XasYFVOw3Ds4xbjW1Q4T0JMIfN?=
 =?us-ascii?Q?4seRKEGwL0XDnbvy5KbcrRst5/ND1uMkG5cnl/jBmDYxIK1/DSnlXJQ48Xh4?=
 =?us-ascii?Q?FmYiPx+IqEL01/ItH/olJxBnEGn8BoJ7neIjxiHZca/8Bt6QhUyEux9iAfq/?=
 =?us-ascii?Q?td/N1U7XLN4oC7vWIPKgEB83wjy1n4B8Z9MbkdDSK8/k4n3WlVuh5CL5tYvu?=
 =?us-ascii?Q?0wuo4SWGG5HRDST/W8kJlgJHYh5QYwCaOf67e2Kr/u2+MxYlLh3BR2i+KxIT?=
 =?us-ascii?Q?mgkUQyNn1+1QQi9slXWgZOy1ahnyMKd4bO9nCgwDczY/9kNCkYR0xfQcbuGH?=
 =?us-ascii?Q?i2HbPMLlm3117fmE+KMMEajFQ/HAlZL85/yZxwJxqcjATHe8wYghYlfaax6x?=
 =?us-ascii?Q?p5eb5PZtiLqafENMOGkC2CwyLqfhUXu3eGQ7LbNhqQZfxluRiiq+24tRYCFK?=
 =?us-ascii?Q?YyAMvyAz+UtlTOe4Zd2BFk8QD5idh+7JD2SK2Ud6xPpIS+Fr2CJZiab0529O?=
 =?us-ascii?Q?gJHEywjzTmJGiE8XgoHZmCmc4xCUZktAYWxft+200GarWI/4tfS189Zbof+b?=
 =?us-ascii?Q?0E3fyN6qJYH9HcvAIxlZsjUi3mkvVIDv5HinFYdVlIJCp2xFdCLXlR+Mrd5l?=
 =?us-ascii?Q?rG8Lp5vAc0cpEwSXpee6tvvYlIY6FVy5+menPPiGGxyjdPOc9pNGjOYGKxJt?=
 =?us-ascii?Q?3BfIv13vslgqoAwcGtHAsA4+5tQYPOIvuVn5nQHxSY7x+9R7La0TgmRu/Pu0?=
 =?us-ascii?Q?jsj4brBa85Zn8EtWOf6WAlM3U2NuioyHOtZZqbBFsFixE786d+mi3qbAeOLF?=
 =?us-ascii?Q?eb4WxeTZmjHR4iOuzqAkoFfOkP8/3lP8EKcqAFh4kC7eEaZyztbfot2s4GdE?=
 =?us-ascii?Q?stxxX1jydOrvaEelFHjA3c04Dm+5Tn0XmL61MPoFxhAkiGAZLlCHb23NZAWm?=
 =?us-ascii?Q?J1AfvLmDDpO7pC0PI5hFp4eGxdkq8DfF/soqveOlY+9+RTgkLPOki6wIpz1m?=
 =?us-ascii?Q?6WzesFmeX+5vnl/E7pl5WnXqjSMToYwhPxyiLv7NuAXaoqBEjUNjzmlwvWJs?=
 =?us-ascii?Q?6lAJNf0uGWtffEpQgKGg5YuT4x0ibakxJg4F?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:12:59.1918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17b1780-d6f7-45c2-5a61-08dd5befd570
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7563
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

From: Luka Jankovic <luka.jankovic@ericsson.com>

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

