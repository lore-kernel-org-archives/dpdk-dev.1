Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8CFC021B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 13:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 360E54161A;
	Wed, 19 Feb 2025 14:43:42 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
 by mails.dpdk.org (Postfix) with ESMTP id 2AAB342707
 for <dev@dpdk.org>; Wed, 19 Feb 2025 14:43:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAjCugeAXt3eD25i0fBJLnoLz/30+KJjQLaKUCLn6Up6fwCLbIXVioYMREWgv3Xv40J4yI6F6kZYeewZ/gJuGs+a4SeDuxb2Iy+9kIso9NIG9OOfc1Bbz2u/er5GBQ6jwVplLvVbWx0pjXZcqvCKWOP5yFTuTtZ+q5Gcr3RehurqLm33pfCubz0nv5AWa4eh1hPkjWjljeb9B6B60K+j/mZHDjYNLNpWAb4mtTh6mUVbA/G/UrDtuDJ4CtoFAolX4Yfojt4tWXtLQIfiVrSA2b4BvnKs6Ib0U2CW7Y9MJHlaiVoSVJOA81NFmB3qrdw/QcMqJdbwMSYote5pStYKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am2+ZqEz5kec1nun4onsXAoaqktGK9YMK/IbZcZPum8=;
 b=gGtAt6R9Ii5X/eub7lcocA0JacUXO4ipGQ844cNSOZtqZN5sW357Tvsc7YIfk9ZnfcZCwcHh1YFspExjdMDvPDztz715WOiGDpo2FzUUNQ+I0p/Ji7cKYDso0nxBaNHFn+Vphpq/iuWzkuNLz8O2nqWh2HTOgBy5s9kXgareZ/OYZrMaMU5ZHOhArTEpCagvf1SEL/i/8wG0P60Ah4BGp6VyW5Y37NLh1R8AhbBsm+2zIyd3h6+r2Fp42BMoFHuh/AesZEL6fRu3yDRoIUJb+dEY3hYro5K2zOq+RArAZ2t+uNHUdLb2kdZP/263wv1V2DDTboY1MRsW62wvgtKetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am2+ZqEz5kec1nun4onsXAoaqktGK9YMK/IbZcZPum8=;
 b=q5mJbfPGg/CCm1dyrpyFeHktQttdbemZuJb3qfjwaNjbfxjObp7bIoBfJst3SbWzj+WWJ8kyhW51ad46/t4HD54oYHfFvHbMebnDFVO32WirAUwObwZFMhUy9m3P19AAY3A9cR9uwT55cU+40uMJqIw1GrZZFp3aferpJ4G7YeMwdXbkXO0lFqChw5KbkcgKx3bA59Bb6NSVg2ihBaqEeo4L2hsNFxpHmz3KC5ynySnJQj3+GRZdQQ9ckCF/Cn/nN7vWiiHC7bIMrsxhveTNW/Hs2GB/V6DKiDXipousW79QH5o0fXemQyQzcWqp1Cloqgs3POIKRZeoEznTcezIsg==
Received: from AM6P191CA0080.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::21)
 by PR3PR07MB8097.eurprd07.prod.outlook.com (2603:10a6:102:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 13:43:36 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:209:8a:cafe::c5) by AM6P191CA0080.outlook.office365.com
 (2603:10a6:209:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Wed,
 19 Feb 2025 13:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 13:43:36 +0000
Received: from seliiuvd00917.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 id 15.2.1544.14; Wed, 19 Feb 2025 14:43:35 +0100
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: <luka.jankovic@ericsson.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <mattias.ronnblom@ericsson.com>,
 <pbhagavatula@marvell.com>
Subject: [RFC v7 4/4] eventdev: documentation for atomic queue and atomic atq
 tests
Date: Wed, 19 Feb 2025 14:43:25 +0100
Message-ID: <20250219134325.1195531-5-luka.jankovic@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250219134325.1195531-1-luka.jankovic@ericsson.com>
References: <20250124095937.1436673-1-luka.jankovic@ericsson.com>
 <20250219134325.1195531-1-luka.jankovic@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|PR3PR07MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 405fa057-68b0-4a0b-1f61-08dd50eb68c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3F3cnpBY3kvcC9iYi94dDVtTHdxa095SWU0UHVXVm9oV085SThhU0l2c0ZI?=
 =?utf-8?B?V2l4WVphVEhTbmZ3K3hlUnJVYjMrK2IvN2RxNFVuR0xhd1RwbndvU1VuWG5q?=
 =?utf-8?B?MmRQSWtqWUpFRTFWSVZqSWNMcTRpc1pFZFV3d24wRlI1NjBFSTBTd09GaEZD?=
 =?utf-8?B?MUtLeTBwOEpoYW5TK2JWeEJkNkREMVdlV0lMbVIyUTVBNC9ZUjBYL0lXYmRM?=
 =?utf-8?B?UGV4MjI1eFFLcVEzWnpHNi9EZGF3SGNrR0psSmN0aWR2dHFGcHZMVzZORjNZ?=
 =?utf-8?B?UXhXMElGdFZrWnBlbzdBQjZWOFdWV0hwN3VUTkxnd2tOYTA5bk51WFdnMzdT?=
 =?utf-8?B?SzU4K0FIbFhINkVNTm05VXh4TzJxVDd0Q3UvRFp3M3ZaeTg1QTRwNUtPOGxR?=
 =?utf-8?B?dE5OSXFBcEFOdld3RFlRZGdiOTFqRHhTcUZMTEgxT3BJWFNmOEJMQjdSUkRY?=
 =?utf-8?B?TjBiWGEralNrMkJ3SGw4RmtlOVBxeHVhZGw3Uk1JbnRsY0RhNjhEalkySkRa?=
 =?utf-8?B?OFc3OHprazBWYWhuWWc1blQ4d3BWdFZkaWFJYVdjSmhMVVliSVdaOHJrandW?=
 =?utf-8?B?K21kT3YwYVRBUW0yNFZDNUd4UXNwM3hpaStCTkExSksvY2tORlpJYWNsT0p6?=
 =?utf-8?B?aVY5YmQzQVZORDJnRmpOUE82VTU3a3FFeVM0dmF5NHRReVEzQTRVUzZXT3NJ?=
 =?utf-8?B?dTdZKy9xS2E2M2xYWmdSSXVBeHkvZkMyWUpsdWpTeXFTcWdWVFgyVTRzeXlk?=
 =?utf-8?B?N21yZG1qcjB4eTZTc1ZVak9OVXBSRDR5azBvSmM1RENNdkMzd2htdEhTZm5B?=
 =?utf-8?B?eWY0WnRLQTUzUUorYmNqOGMvdkJsR3lJRFFzMEM0RDRZa0I3dU8yckhiRFgw?=
 =?utf-8?B?dmNNWE5abjF3V3d4RGpEMEFHQUtlVzhUZWNsazNtaGVyMHpCSXg5QUoyWHZa?=
 =?utf-8?B?UWRxTCthM2FOaHNLRisrQzdFZGx4SmYvbjFpOEhpYm9mMjJtTlRVd3VoazA3?=
 =?utf-8?B?S3V3TUd1UGdVZ29tM2VuVXRnQnRuS2dQTWJhazkrRWFCTGhmdGR6TFhsNEhu?=
 =?utf-8?B?VnpCVlhPMDlqSTBLYnYrSys3SGRaV2l5YWdtUkVrRXFFemdVbEczaE9nMHNV?=
 =?utf-8?B?cTBHbnEzc2dlWEY3aHZVckhUTkx2ZllnZWloS0EyNE5Hd1FtbFJrVXJpbVVr?=
 =?utf-8?B?aElNZFhWS1RSTnFhU1ZNdjBnYm5LVWlIMFRVOGI2TFlXRkpDTndHWkxQK1I1?=
 =?utf-8?B?OUxGSlZNY1YzSUVhb2NXcWxwbHNZM01mQTBJUWIzTjQ3b2ZIYmtRUUtiQU8y?=
 =?utf-8?B?c3lsQlNtSVJJTTZHMC8wcmlGS2xtSEhDWExnUEZ4ZkFrT3NHTFFPcUNUWHhI?=
 =?utf-8?B?a01WNVgyNm1oWmpzZGJOWnF5UnhOeU1FcjNTcC9OcXNUanlkTlluMjNuYm1z?=
 =?utf-8?B?cFEzY2h3NE9MSGhNUlBZK0RZclVJZ0VRVDAydERKL1Mxd0g0WFkxQjlaQ1Zu?=
 =?utf-8?B?RTNBZEVjQ29RU055aWR6bXlFcTRMRkp4MEF4cEM5TmF4UXpBYVlqVjR6MkMr?=
 =?utf-8?B?eXl3SjVPTTNOZDlhS0VoWGg5ZlAvV0pJTy9mUEFkbGQ5eFUrK0Q5dng3YmdR?=
 =?utf-8?B?ZFpzSzFkOUs3Zy9HWWZXY0F2Z0h2bTdxcS9uTVRTZjQrak15a3lIZDRJMDlR?=
 =?utf-8?B?Y05SMVZvWjRhWXhwbFBlY3A1ZFpVRnlLMVZoUHBHOHp3aUs1UUkzZlVYQkY5?=
 =?utf-8?B?YnFja0tyWHhwUnBhbTBPdlBnZzNLbjFackJYWFF6RjlPN054R01pTnliOEpW?=
 =?utf-8?B?akNMVXR3ZjF5M1UzYlBRRGxSKzJWR0FaNHpoN0gyZUdsbk1LeVNrOU1FZ0oy?=
 =?utf-8?B?dXJRMXJPSHlTa3RXbEV1N2RNZ1Y4ZEdyQ0pub1IwUktHa1hLQ1YrWFJldVlQ?=
 =?utf-8?Q?HBCrOZidr6QoJ6avqGZLNdib1CsdP1oD?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:43:36.1424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405fa057-68b0-4a0b-1f61-08dd50eb68c7
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8097
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

Add relevant documentation and figures to the tools/testeventdev page.

Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>
---
 .../tools/img/eventdev_atomic_atq_test.svg    | 1588 +++++++++++++++
 .../tools/img/eventdev_atomic_queue_test.svg  | 1701 +++++++++++++++++
 doc/guides/tools/testeventdev.rst             |  155 ++
 3 files changed, 3444 insertions(+)
 create mode 100644 doc/guides/tools/img/eventdev_atomic_atq_test.svg
 create mode 100644 doc/guides/tools/img/eventdev_atomic_queue_test.svg

diff --git a/doc/guides/tools/img/eventdev_atomic_atq_test.svg b/doc/guides/tools/img/eventdev_atomic_atq_test.svg
new file mode 100644
index 0000000000..0459d9f649
--- /dev/null
+++ b/doc/guides/tools/img/eventdev_atomic_atq_test.svg
@@ -0,0 +1,1588 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<!--
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2017 Cavium, Inc
+#
+-->
+
+<svg
+   width="631.91431"
+   height="288.34286"
+   id="svg3868"
+   version="1.1"
+   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
+   sodipodi:docname="eventdev_atomic_atq_test.svg"
+   sodipodi:version="0.32"
+   inkscape:output_extension="org.inkscape.output.svg.inkscape"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
+   xmlns:cc="http://creativecommons.org/ns#"
+   xmlns:dc="http://purl.org/dc/elements/1.1/">
+  <defs
+     id="defs3870">
+    <linearGradient
+       id="linearGradient6545"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#ffa600;stop-opacity:1;"
+         offset="0"
+         id="stop6543" />
+    </linearGradient>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3302"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3294"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3290"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3286"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3228"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3188"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3184"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3180"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3176"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3172"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3168"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3164"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3160"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3120"
+       is_visible="true" />
+    <linearGradient
+       id="linearGradient3114"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#00f900;stop-opacity:1;"
+         offset="0"
+         id="stop3112" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3088"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#00f900;stop-opacity:1;"
+         offset="0"
+         id="stop3086" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3058"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#00f900;stop-opacity:1;"
+         offset="0"
+         id="stop3056" />
+    </linearGradient>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3054"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3050"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3046"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3042"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3038"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3034"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3030"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3008"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3004"
+       is_visible="true" />
+    <linearGradient
+       id="linearGradient2975"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#ff2200;stop-opacity:1;"
+         offset="0"
+         id="stop2973" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient2969"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#69ff72;stop-opacity:1;"
+         offset="0"
+         id="stop2967" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient2963"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#000000;stop-opacity:1;"
+         offset="0"
+         id="stop2961" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient2929"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#ff2d00;stop-opacity:1;"
+         offset="0"
+         id="stop2927" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient4610"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#00ffff;stop-opacity:1;"
+         offset="0"
+         id="stop4608" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3993"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#6ba6fd;stop-opacity:1;"
+         offset="0"
+         id="stop3991" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3808"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#6ba6fd;stop-opacity:1;"
+         offset="0"
+         id="stop3806" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3776"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#fc0000;stop-opacity:1;"
+         offset="0"
+         id="stop3774" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3438"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#b8e132;stop-opacity:1;"
+         offset="0"
+         id="stop3436" />
+    </linearGradient>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3408"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3404"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3400"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3392"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3376"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3044"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3040"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3036"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3032"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3028"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3024"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3020"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect2858"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect2854"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect2844"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <linearGradient
+       id="linearGradient2828"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#ff0000;stop-opacity:1;"
+         offset="0"
+         id="stop2826" />
+    </linearGradient>
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect329"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <marker
+       inkscape:stockid="Arrow1Mstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mstart"
+       style="overflow:visible">
+      <path
+         id="path4530"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.4,0,0,0.4,4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend"
+       style="overflow:visible">
+      <path
+         id="path4533"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <linearGradient
+       id="linearGradient4513">
+      <stop
+         style="stop-color:#fdffdb;stop-opacity:1;"
+         offset="0"
+         id="stop4515" />
+      <stop
+         style="stop-color:#dfe2d8;stop-opacity:0;"
+         offset="1"
+         id="stop4517" />
+    </linearGradient>
+    <inkscape:perspective
+       sodipodi:type="inkscape:persp3d"
+       inkscape:vp_x="0 : 526.18109 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_z="744.09448 : 526.18109 : 1"
+       inkscape:persp3d-origin="372.04724 : 350.78739 : 1"
+       id="perspective3876" />
+    <inkscape:perspective
+       id="perspective3886"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Lend"
+       style="overflow:visible">
+      <path
+         id="path3211"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3892"
+       style="overflow:visible">
+      <path
+         id="path3894"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3896"
+       style="overflow:visible">
+      <path
+         id="path3898"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Lstart"
+       style="overflow:visible">
+      <path
+         id="path3208"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.8,0,0,0.8,10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3902"
+       style="overflow:visible">
+      <path
+         id="path3904"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3906"
+       style="overflow:visible">
+      <path
+         id="path3908"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.8,0,0,0.8,10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3910"
+       style="overflow:visible">
+      <path
+         id="path3912"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:perspective
+       id="perspective4086"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <inkscape:perspective
+       id="perspective4113"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient4513"
+       id="linearGradient4519"
+       x1="47.142857"
+       y1="244.50504"
+       x2="677.85718"
+       y2="244.50504"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="matrix(0.99477436,0,0,0.98597786,2.8382132,3.7730937)" />
+    <inkscape:perspective
+       id="perspective5195"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-4"
+       style="overflow:visible">
+      <path
+         id="path4533-7"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:perspective
+       id="perspective5272"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <marker
+       inkscape:stockid="Arrow1Mstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mstart-4"
+       style="overflow:visible">
+      <path
+         id="path4530-5"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.4,0,0,0.4,4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-0"
+       style="overflow:visible">
+      <path
+         id="path4533-3"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:perspective
+       id="perspective5317"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <marker
+       inkscape:stockid="Arrow1Mstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mstart-3"
+       style="overflow:visible">
+      <path
+         id="path4530-2"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.4,0,0,0.4,4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-06"
+       style="overflow:visible">
+      <path
+         id="path4533-1"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mstart-8"
+       style="overflow:visible">
+      <path
+         id="path4530-7"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(0.4,0,0,0.4,4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-9"
+       style="overflow:visible">
+      <path
+         id="path4533-2"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect2858-0"
+       is_visible="true" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-3"
+       style="overflow:visible">
+      <path
+         id="path4533-75"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3044-9"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-3-2"
+       style="overflow:visible">
+      <path
+         id="path4533-75-8"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3044-9-9"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3808"
+       id="linearGradient3810"
+       x1="61.233804"
+       y1="153.47966"
+       x2="308.87187"
+       y2="153.47966"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="matrix(0.97704237,0,0,1.0002563,1.4114958,-0.03933915)" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient3995"
+       x1="155.21328"
+       y1="231.61366"
+       x2="207.95523"
+       y2="231.61366"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient4612"
+       x1="594.77722"
+       y1="232.19244"
+       x2="647.51917"
+       y2="232.19244"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient4614"
+       x1="530.03839"
+       y1="232.3177"
+       x2="582.78033"
+       y2="232.3177"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient4616"
+       x1="468.32343"
+       y1="232.3177"
+       x2="521.06543"
+       y2="232.3177"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient4618"
+       x1="405.4682"
+       y1="232.36095"
+       x2="458.21014"
+       y2="232.36095"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient2963"
+       id="linearGradient2965"
+       x1="49.239535"
+       y1="244.84964"
+       x2="677.6483"
+       y2="244.84964"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient2971"
+       x1="372.12488"
+       y1="333.32864"
+       x2="476.58179"
+       y2="333.32864"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="translate(95.459415,-18.384776)" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3008-3"
+       is_visible="true" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3114"
+       id="linearGradient3104"
+       x1="570.76388"
+       y1="265.59842"
+       x2="613.45706"
+       y2="265.59842"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="translate(-4)" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3114"
+       id="linearGradient3106"
+       x1="540.94574"
+       y1="265.3059"
+       x2="548.29097"
+       y2="265.3059"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="translate(-2)" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3114"
+       id="linearGradient3108"
+       x1="429.95148"
+       y1="274.65289"
+       x2="467.35629"
+       y2="274.65289"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3114"
+       id="linearGradient3116"
+       gradientUnits="userSpaceOnUse"
+       x1="481.13927"
+       y1="264.7722"
+       x2="491.08518"
+       y2="264.7722"
+       gradientTransform="translate(0,2)" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3120-7"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3120-7-3"
+       is_visible="true" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient6547"
+       x1="568.54004"
+       y1="280.793"
+       x2="630.64801"
+       y2="280.793"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient6549"
+       x1="499.98608"
+       y1="268.21176"
+       x2="522.65869"
+       y2="268.21176"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient6551"
+       x1="449.72733"
+       y1="267.29733"
+       x2="480.36688"
+       y2="267.29733"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient6553"
+       x1="554.2403"
+       y1="266.57718"
+       x2="565.97662"
+       y2="266.57718"
+       gradientUnits="userSpaceOnUse" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-4-3"
+       style="overflow:visible">
+      <path
+         id="path4533-7-6"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect12084"
+       is_visible="true"
+       lpeversion="1"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+  </defs>
+  <sodipodi:namedview
+     id="base"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageopacity="0.0"
+     inkscape:pageshadow="2"
+     inkscape:zoom="1.4142136"
+     inkscape:cx="217.08178"
+     inkscape:cy="136.11805"
+     inkscape:document-units="px"
+     inkscape:current-layer="layer1"
+     showgrid="false"
+     inkscape:window-width="1883"
+     inkscape:window-height="1000"
+     inkscape:window-x="2614"
+     inkscape:window-y="195"
+     inkscape:window-maximized="0"
+     fit-margin-top="0.1"
+     fit-margin-left="0.1"
+     fit-margin-right="0.1"
+     fit-margin-bottom="0.1"
+     inkscape:measure-start="-29.078,219.858"
+     inkscape:measure-end="346.809,219.858"
+     showguides="false"
+     inkscape:pagecheckerboard="0" />
+  <metadata
+     id="metadata3873">
+    <rdf:RDF>
+      <cc:Work
+         rdf:about="">
+        <dc:format>image/svg+xml</dc:format>
+        <dc:type
+           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
+        <dc:title />
+      </cc:Work>
+    </rdf:RDF>
+  </metadata>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(-46.542857,-100.33361)">
+    <rect
+       style="fill:url(#linearGradient4519);fill-opacity:1;stroke:url(#linearGradient2965);stroke-width:0.99036628;stroke-opacity:1"
+       id="rect3697"
+       width="627.4184"
+       height="283.11649"
+       x="49.734718"
+       y="103.2914"
+       rx="0"
+       ry="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="424.47687"
+       y="382.4664"
+       id="text2912"
+       inkscape:export-filename="/home/matz/barracuda/rapports/mbuf-api-v2-images/octeon_multi.png"
+       inkscape:export-xdpi="112"
+       inkscape:export-ydpi="112"><tspan
+         sodipodi:role="line"
+         x="424.47687"
+         y="382.4664"
+         id="tspan2916"
+         style="font-weight:bold;font-size:13.3333px;line-height:1.25">test: atomic_atq(all types queue)</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="99.327995"
+       y="317.25745"
+       id="text2978"
+       inkscape:export-filename="/home/matz/barracuda/rapports/mbuf-api-v2-images/octeon_multi.png"
+       inkscape:export-xdpi="112"
+       inkscape:export-ydpi="112"><tspan
+         sodipodi:role="line"
+         x="99.327995"
+         y="317.25745"
+         id="tspan3006"
+         style="font-size:15.2252px;line-height:1.25"> </tspan></text>
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient4614);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87"
+       width="51.714954"
+       height="32.587509"
+       x="530.55188"
+       y="216.02396"
+       rx="11.6051"
+       ry="16.293755" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient4612);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87-3"
+       width="51.714954"
+       height="32.587509"
+       x="595.29071"
+       y="215.89868"
+       rx="11.6051"
+       ry="16.293755" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient4616);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87-6"
+       width="51.714954"
+       height="32.587509"
+       x="468.83694"
+       y="216.02396"
+       rx="11.6051"
+       ry="16.293755" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient2971);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect128-7"
+       width="103.42992"
+       height="57.382355"
+       x="468.09781"
+       y="286.25269"
+       rx="8.5874901"
+       ry="10.712767" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient4618);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87-6-5"
+       width="51.714954"
+       height="32.587509"
+       x="405.98169"
+       y="216.06718"
+       rx="11.6051"
+       ry="16.293755" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient3995);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87-6-5-3"
+       width="51.714954"
+       height="32.587509"
+       x="155.72678"
+       y="215.3199"
+       rx="11.6051"
+       ry="16.293755" />
+    <path
+       style="fill:none;stroke:#009587;stroke-width:0.93883556;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 183.25449,249.08205 c 3.74662,22.85489 17.60919,43.86172 37.14916,56.29446 18.31316,11.65216 40.37703,15.62026 61.91526,18.31267 12.34123,1.54273 24.72858,2.74691 37.14916,3.39123 13.45494,0.69797 26.93497,0.73841 40.40786,0.67825 36.04931,-0.16098 72.09541,-1.04105 108.10962,-2.63952"
+       id="path2852"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect2854"
+       inkscape:original-d="m 183.25449,249.08205 c 12.38397,18.76387 24.76701,37.52867 37.14916,56.29446 12.38211,18.76578 41.27777,12.20748 61.91526,18.31267 20.6375,6.10516 24.76702,2.25985 37.14916,3.39123 12.38215,1.13134 26.9395,0.4512 40.40786,0.67825 13.46837,0.22702 106.15533,-2.64046 108.10962,-2.63952"
+       sodipodi:nodetypes="csscsc" />
+    <g
+       id="g4374">
+      <text
+         id="text5219-3"
+         y="187.92023"
+         x="132.8121"
+         style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+         xml:space="preserve"><tspan
+           style="font-size:10px;line-height:1.25"
+           id="tspan5223-6"
+           y="187.92023"
+           x="132.8121"
+           sodipodi:role="line">producer_flow_seq</tspan></text>
+      <g
+         id="g4286">
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="67.609619"
+           y="125.91534"
+           id="text5219"><tspan
+             sodipodi:role="line"
+             x="67.609619"
+             y="125.91534"
+             id="tspan5223"
+             style="font-size:10px;line-height:1.25">producer maintains per flow sequence number</tspan></text>
+        <rect
+           style="fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:url(#linearGradient3810);stroke-width:0.97884095;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect2896"
+           width="240.98547"
+           height="44.122215"
+           x="61.723225"
+           y="131.41856"
+           ry="8.8282356"
+           rx="9.0800323"
+           inkscape:export-filename="/home/matz/barracuda/rapports/mbuf-api-v2-images/octeon_multi.png"
+           inkscape:export-xdpi="112"
+           inkscape:export-ydpi="112" />
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#6ba6fd;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect3736"
+           width="39.065548"
+           height="24.347494"
+           x="70.045547"
+           y="143.98941" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="76.606445"
+           y="141.62436"
+           id="text5219-1-9"><tspan
+             sodipodi:role="line"
+             x="76.606445"
+             y="141.62436"
+             id="tspan5223-2-3"
+             style="font-size:10px;line-height:1.25">flow 0</tspan></text>
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#6ba6fd;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect3736-8"
+           width="39.065548"
+           height="24.347494"
+           x="129.42143"
+           y="144.7206" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="131.98233"
+           y="142.35555"
+           id="text5219-1-9-4"><tspan
+             sodipodi:role="line"
+             x="131.98233"
+             y="142.35555"
+             id="tspan5223-2-3-5"
+             style="font-size:10px;line-height:1.25">flow 1</tspan></text>
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="195.98233"
+           y="142.35555"
+           id="text5219-1-9-4-3"><tspan
+             sodipodi:role="line"
+             x="195.98233"
+             y="142.35555"
+             id="tspan5223-2-3-5-6"
+             style="font-size:10px;line-height:1.25">flow 2</tspan></text>
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#6ba6fd;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect3736-8-0-1"
+           width="39.065548"
+           height="24.347494"
+           x="251.42145"
+           y="144.7206" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="257.98233"
+           y="142.35555"
+           id="text5219-1-9-4-3-0"><tspan
+             sodipodi:role="line"
+             x="257.98233"
+             y="142.35555"
+             id="tspan5223-2-3-5-6-6"
+             style="font-size:10px;line-height:1.25">flow n</tspan></text>
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#6ba6fd;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect3736-8-3"
+           width="39.065548"
+           height="24.347494"
+           x="192.15901"
+           y="144.7155" />
+      </g>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="157.0374"
+       y="258.07278"
+       id="text5219-2"><tspan
+         sodipodi:role="line"
+         x="157.0374"
+         y="258.07278"
+         id="tspan5223-0"
+         style="font-size:10px;line-height:1.25">producer0</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="477.25565"
+       y="316.59613"
+       id="text5219-6"><tspan
+         sodipodi:role="line"
+         x="477.25565"
+         y="316.59613"
+         id="tspan5223-1"
+         style="font-size:10px;line-height:1.25">all_types_queue0</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="410.87885"
+       y="213.34842"
+       id="text5219-2-4"><tspan
+         sodipodi:role="line"
+         x="410.87885"
+         y="213.34842"
+         id="tspan5223-0-7"
+         style="font-size:10px;line-height:1.25">worker 0</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="157.44383"
+       y="236.49918"
+       id="text5219-2-6"><tspan
+         sodipodi:role="line"
+         x="157.44383"
+         y="236.49918"
+         id="tspan5223-0-9"
+         style="font-size:10px;line-height:1.25">port n+1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="472.61508"
+       y="213.66943"
+       id="text5219-2-4-3"><tspan
+         sodipodi:role="line"
+         x="472.61508"
+         y="213.66943"
+         id="tspan5223-0-7-7"
+         style="font-size:10px;line-height:1.25">worker 1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="534.61511"
+       y="213.66943"
+       id="text5219-2-4-3-4"><tspan
+         sodipodi:role="line"
+         x="534.61511"
+         y="213.66943"
+         id="tspan5223-0-7-7-5"
+         style="font-size:10px;line-height:1.25">worker 2</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="600.61511"
+       y="213.66943"
+       id="text5219-2-4-3-4-2"><tspan
+         sodipodi:role="line"
+         x="600.61511"
+         y="213.66943"
+         id="tspan5223-0-7-7-5-5"
+         style="font-size:10px;line-height:1.25">worker n</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="420.13348"
+       y="234.8974"
+       id="text5219-2-6-4"><tspan
+         sodipodi:role="line"
+         x="420.13348"
+         y="234.8974"
+         id="tspan5223-0-9-7"
+         style="font-size:10px;line-height:1.25">port 0</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="477.25241"
+       y="234.85495"
+       id="text5219-2-6-4-4"><tspan
+         sodipodi:role="line"
+         x="477.25241"
+         y="234.85495"
+         id="tspan5223-0-9-7-4"
+         style="font-size:10px;line-height:1.25">port 1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="539.25244"
+       y="234.85495"
+       id="text5219-2-6-4-4-3"><tspan
+         sodipodi:role="line"
+         x="539.25244"
+         y="234.85495"
+         id="tspan5223-0-9-7-4-0"
+         style="font-size:10px;line-height:1.25">port 2</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="607.25244"
+       y="234.85495"
+       id="text5219-2-6-4-4-3-7"><tspan
+         sodipodi:role="line"
+         x="607.25244"
+         y="234.85495"
+         id="tspan5223-0-9-7-4-0-8"
+         style="font-size:10px;line-height:1.25">port n</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="478.92789"
+       y="188.00357"
+       id="text5219-3-2"><tspan
+         sodipodi:role="line"
+         x="478.92789"
+         y="188.00357"
+         id="tspan5223-6-7"
+         style="font-size:10px;line-height:1.25">expected_flow_seq</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="433.7254"
+       y="125.99867"
+       id="text5219-26"><tspan
+         sodipodi:role="line"
+         x="433.7254"
+         y="125.99867"
+         id="tspan5223-10"
+         style="font-size:10px;line-height:1.25">per flow expected sequence number</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#ff2d00;stroke-width:0.97884095;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect2896-6"
+       width="240.98547"
+       height="44.122215"
+       x="407.83902"
+       y="131.50191"
+       ry="8.8282356"
+       rx="9.0800323"
+       inkscape:export-filename="/home/matz/barracuda/rapports/mbuf-api-v2-images/octeon_multi.png"
+       inkscape:export-xdpi="112"
+       inkscape:export-ydpi="112" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#ff2d00;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect3736-1"
+       width="39.065548"
+       height="24.347494"
+       x="416.16132"
+       y="144.07275" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="422.72223"
+       y="141.7077"
+       id="text5219-1-9-5"><tspan
+         sodipodi:role="line"
+         x="422.72223"
+         y="141.7077"
+         id="tspan5223-2-3-9"
+         style="font-size:10px;line-height:1.25">flow 0</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#ff2d00;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect3736-8-4"
+       width="39.065548"
+       height="24.347494"
+       x="475.5372"
+       y="144.80394" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="478.09811"
+       y="142.43889"
+       id="text5219-1-9-4-9"><tspan
+         sodipodi:role="line"
+         x="478.09811"
+         y="142.43889"
+         id="tspan5223-2-3-5-0"
+         style="font-size:10px;line-height:1.25">flow 1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="542.09808"
+       y="142.43889"
+       id="text5219-1-9-4-3-9"><tspan
+         sodipodi:role="line"
+         x="542.09808"
+         y="142.43889"
+         id="tspan5223-2-3-5-6-1"
+         style="font-size:10px;line-height:1.25">flow 2</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#ff2d00;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect3736-8-0-1-7"
+       width="39.065548"
+       height="24.347494"
+       x="597.53723"
+       y="144.80394" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="604.09808"
+       y="142.43889"
+       id="text5219-1-9-4-3-0-7"><tspan
+         sodipodi:role="line"
+         x="604.09808"
+         y="142.43889"
+         id="tspan5223-2-3-5-6-6-1"
+         style="font-size:10px;line-height:1.25">flow n</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#ff2d00;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect3736-8-3-1"
+       width="39.065548"
+       height="24.347494"
+       x="538.27478"
+       y="144.79884" />
+    <path
+       style="fill:none;stroke:#5cdcff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart);marker-end:url(#Arrow1Mend)"
+       d="m 86.923031,168.93973 c 2.833543,14.16771 5.667239,28.33619 16.884859,38.84515 11.21761,10.50897 30.81628,17.35669 50.41543,24.20459"
+       id="path3022"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3024"
+       inkscape:original-d="m 86.923031,168.93973 c 2.834697,14.16748 5.668393,28.33596 8.50109,42.50544 19.601799,6.84748 39.200469,13.6952 58.799199,20.5443" />
+    <path
+       style="fill:none;stroke:#5cdcff;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend);marker-start:url(#Arrow1Mstart)"
+       d="m 146.43066,168.35658 c 2.36123,9.20881 4.72265,18.41832 9.20969,26.09352 4.48705,7.67519 11.09851,13.8144 17.71043,19.95404"
+       id="path3026"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3028"
+       inkscape:original-d="m 146.43066,168.35658 c 2.36241,9.20851 4.72383,18.41802 7.08424,27.62854 6.61346,6.13914 13.22492,12.27835 19.83588,18.41902" />
+    <path
+       style="fill:none;stroke:#5cdcff;stroke-width:0.81213671px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart);marker-end:url(#Arrow1Mend)"
+       d="m 217.48983,176.52088 c -8.64146,12.7325 -17.28354,25.46592 -25.92626,38.20028"
+       id="path3034"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3036"
+       inkscape:original-d="m 217.48983,176.52088 c -8.64125,12.73264 -17.28334,25.46606 -25.92626,38.20028" />
+    <path
+       style="fill:none;stroke:#5cdcff;stroke-width:0.86425042px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart);marker-end:url(#Arrow1Mend)"
+       d="m 272.10856,176.69086 c -0.83331,11.39414 -1.66669,22.78917 -12.50095,31.58588 -10.83426,8.79671 -31.66708,14.99352 -52.5026,21.19113"
+       id="path3038"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3040"
+       inkscape:original-d="m 272.10856,176.69086 c -0.83249,11.3942 -1.66587,22.78923 -2.50014,34.18511 -20.83523,6.19695 -41.66805,12.39376 -62.50341,18.5919" />
+    <path
+       style="fill:none;stroke:url(#linearGradient3108);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 467.27138,304.53077 c -4.47171,0.79203 -9.17911,0.19735 -13.31337,-1.68186 -4.13426,-1.8792 -7.67758,-5.03486 -10.02115,-8.92474 -2.70468,-4.48926 -3.7629,-9.74432 -4.94975,-14.84924 -2.2305,-9.59386 -5.06642,-19.04692 -8.48528,-28.28427"
+       id="path3040"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3042"
+       inkscape:original-d="m 467.27138,304.53077 c -7.54147,-3.30083 -15.55535,-7.07207 -23.33452,-10.6066 -7.77917,-3.53453 -3.29883,-9.9005 -4.94975,-14.84924 -1.65091,-4.94875 -5.65585,-17.20727 -8.48528,-28.28427"
+       sodipodi:nodetypes="cscc" />
+    <path
+       style="fill:none;stroke:url(#linearGradient3116);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 490.60591,286.02467 c -1.19028,-4.00346 -2.3688,-8.01042 -3.53554,-12.02081 -1.28128,-4.40407 -2.55618,-8.85645 -2.82842,-13.43503 -0.22685,-3.81532 0.25518,-7.67163 1.41421,-11.31371"
+       id="path3044"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3046"
+       inkscape:original-d="m 490.60591,286.02467 c -1.17751,-3.53653 -2.35603,-8.01487 -3.53554,-12.02081 -1.17951,-4.00594 -1.88462,-8.95769 -2.82842,-13.43503 -0.94381,-4.47734 0.9438,-7.54347 1.41421,-11.31371" />
+    <path
+       style="fill:none;stroke:url(#linearGradient3106);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 543.76023,283.31757 c -3.17461,-5.53504 -4.67076,-12.01835 -4.24264,-18.38478 0.38974,-5.79571 2.3658,-11.4769 5.65686,-16.26345"
+       id="path3048"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3050"
+       inkscape:original-d="m 543.76023,283.31757 c -1.17751,-5.89356 -2.82742,-12.25752 -4.24264,-18.38478 -1.41521,-6.12726 3.77224,-10.8433 5.65686,-16.26345" />
+    <path
+       style="fill:none;stroke:url(#linearGradient3104);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 567.52771,286.25269 c -0.89405,-7.05499 0.50327,-14.382 3.93101,-20.61279 3.42237,-6.22103 8.85117,-11.31764 15.27563,-14.34091 6.42445,-3.02328 13.81187,-3.95783 20.78681,-2.62965"
+       id="path3052"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3054"
+       inkscape:original-d="m 567.52771,286.25269 c 1.31134,-6.87193 2.62167,-13.74286 3.93101,-20.61279 1.30933,-6.86993 24.04263,-11.31471 36.06244,-16.97056" />
+    <path
+       style="fill:none;stroke:url(#linearGradient6551);stroke-width:1.23147655px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-3)"
+       d="m 449.95502,247.97701 c 7.55606,3.00738 14.27612,8.08523 19.23272,14.53274 4.94601,6.43374 8.12285,14.21372 9.09385,22.27059"
+       id="path3118"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3120"
+       inkscape:original-d="m 449.95502,247.97701 c 6.41168,4.84269 12.82258,9.68693 19.23272,14.53274 6.41012,4.84582 6.06333,14.84549 9.09385,22.27059" />
+    <path
+       style="fill:none;stroke:url(#linearGradient6549);stroke-width:1.02635109px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-3)"
+       d="m 500.27242,249.30514 c 5.49861,3.69701 10.16955,8.61776 13.57532,14.30137 3.95545,6.60092 6.18818,14.22417 6.41885,21.91602"
+       id="path3118-5"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3120-7"
+       inkscape:original-d="m 500.27242,249.30514 c 4.52565,4.76559 9.05076,9.5327 13.57532,14.30137 4.52456,4.76867 4.27978,14.60913 6.41885,21.91602" />
+    <path
+       style="fill:none;stroke:url(#linearGradient6553);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-3)"
+       d="m 563.4379,247.96223 c -0.93075,1.47255 -1.40195,3.23109 -1.33217,4.97173 0.0873,2.17847 0.98613,4.22982 1.82529,6.24207 0.83917,2.01226 1.64627,4.12194 1.53517,6.29933 -0.10557,2.06901 -1.03996,4.01595 -2.21955,5.71904 -1.17958,1.70309 -2.61086,3.2153 -3.88281,4.85056 -1.79899,2.31284 -3.27787,4.87432 -4.38135,7.58871"
+       id="path3158"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3160"
+       inkscape:original-d="m 563.4379,247.96223 c -0.44305,1.65624 -0.88711,3.31349 -1.33217,4.97173 -0.44505,1.65824 2.24131,8.35993 3.36046,12.5414 1.11915,4.18146 -4.06724,7.0454 -6.10236,10.5696 -2.03512,3.5242 -2.9199,5.05814 -4.38135,7.58871" />
+    <path
+       style="fill:none;stroke:url(#linearGradient6547);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-9)"
+       d="m 627.07751,247.25512 c 2.57858,5.21574 3.57603,11.20045 2.82843,16.97056 -0.64544,4.9816 -2.54874,9.72988 -4.94975,14.14214 -5.34434,9.82114 -13.26591,18.22509 -22.75437,24.13997 -9.48846,5.91488 -20.52182,9.327 -31.69285,9.80115"
+       id="path3170"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3172"
+       inkscape:original-d="m 627.07751,247.25512 c 0.94381,5.65586 1.88662,11.31271 2.82843,16.97056 0.94181,5.65786 -3.29883,9.42709 -4.94975,14.14214 -1.65091,4.71505 -36.29715,22.62642 -54.44722,33.94112" />
+    <path
+       style="fill:none;stroke:#ff0009;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-3)"
+       d="m 472.28159,286.78034 c -4.73891,1.38236 -9.8908,1.31285 -14.59068,-0.19687 -4.69989,-1.50972 -8.9285,-4.45346 -11.97588,-8.33697 -4.6972,-5.98601 -6.39497,-13.73104 -7.77817,-21.2132 -4.74217,-25.65195 -7.34684,-51.69871 -7.77817,-77.78175"
+       id="path3174"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3176"
+       inkscape:original-d="m 472.28159,286.78034 c -8.85452,-2.84561 -17.71004,-5.69023 -26.56656,-8.53384 -8.85651,-2.84361 -5.18444,-18.15007 -7.77817,-21.2132 -2.59372,-3.06313 -5.18445,-47.84856 -7.77817,-77.78175"
+       sodipodi:nodetypes="cscc" />
+    <path
+       style="fill:none;stroke:#ff0009;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-3)"
+       d="m 520.26659,285.52253 c -5.12949,-4.21044 -10.95341,-7.57288 -17.1645,-9.90993 -1.06939,-0.40238 -2.15342,-0.77603 -3.17262,-1.29248 -1.0192,-0.51645 -1.98094,-1.18681 -2.68299,-2.08826 -0.72153,-0.92647 -1.14059,-2.06537 -1.31508,-3.22662 -0.1745,-1.16126 -0.1134,-2.34757 0.0547,-3.50977 0.33614,-2.32441 1.09651,-4.58378 1.26041,-6.92664 0.17202,-2.45897 -0.32204,-4.92427 -1.08174,-7.26926 -0.75971,-2.34499 -1.78291,-4.59423 -2.70916,-6.87857 -3.13866,-7.7406 -5.16733,-15.90124 -6.47139,-24.15154 -2.35876,-14.92295 -2.35876,-30.21628 0,-45.13923"
+       id="path3178"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3180"
+       inkscape:original-d="m 520.26659,285.52253 c -6.30121,-1.68967 -11.442,-6.60762 -17.1645,-9.90993 -5.7225,-3.30231 -3.90274,-2.25483 -5.85561,-3.38074 -1.95287,-1.12591 10e-4,-9.10969 0,-13.66303 -0.001,-4.55334 -2.52627,-9.43288 -3.7909,-14.14783 -1.26463,-4.71494 -4.31326,-16.10203 -6.47139,-24.15154 -2.15813,-8.04952 10e-4,-30.09382 0,-45.13923" />
+    <path
+       style="fill:none;stroke:#ff0009;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-3)"
+       d="m 550.98248,285.63367 c -2.92905,-0.67285 -5.54573,-2.60689 -7.0484,-5.20959 -1.50267,-2.60269 -1.86925,-5.83582 -0.98743,-8.70888 0.60067,-1.95707 1.7332,-3.7028 2.90087,-5.38431 1.16766,-1.68151 2.39383,-3.34436 3.22004,-5.21741 1.05624,-2.39454 1.4169,-5.05627 1.32027,-7.67164 -0.0966,-2.61537 -0.63688,-5.1959 -1.32027,-7.72225 -2.02251,-7.47675 -5.29434,-14.54655 -7.92814,-21.83047 -2.63379,-7.28391 -4.65127,-14.98425 -4.00448,-22.70266 0.8282,-9.88322 6.25638,-19.28511 14.4014,-24.94396"
+       id="path3182"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3184"
+       inkscape:original-d="m 550.98248,285.63367 c -2.67761,-4.64049 -5.35622,-9.27998 -8.03583,-13.91847 -2.67961,-4.63849 4.0816,-7.06881 6.12091,-10.60172 2.0393,-3.53291 0.001,-10.26359 0,-15.39389 -10e-4,-5.1303 -7.95408,-29.68975 -11.93262,-44.53313 -3.97854,-14.84337 9.60194,-16.63031 14.4014,-24.94396" />
+    <path
+       style="fill:none;stroke:#ff0009;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-3)"
+       d="m 570.50897,312.30894 15.9099,-15.9099 c 1.60179,-1.60179 3.18026,-3.22794 4.83149,-4.77871 1.65122,-1.55077 3.4059,-3.02641 5.42156,-4.06012 3.98852,-2.04548 8.73787,-2.20014 12.72792,-4.24264 2.36474,-1.21051 4.3875,-3.06569 5.84524,-5.28657 1.45774,-2.22089 2.35254,-4.80039 2.64004,-7.44135 0.22981,-2.11099 0.0784,-4.24195 0,-6.36397 -0.10438,-2.827 -0.0784,-5.65744 0,-8.48528 0.10462,-3.77187 0.30241,-7.55251 0,-11.3137 -0.66504,-8.27138 -3.7123,-16.13228 -6.42402,-23.97477 -4.92134,-14.23288 -8.82892,-28.81618 -11.68335,-43.60288"
+       id="path3186"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3188"
+       inkscape:original-d="m 570.50897,312.30894 c 5.3043,-5.3043 10.6076,-10.6076 15.9099,-15.9099 5.3023,-5.3023 6.83637,-5.89355 10.25305,-8.83883 3.41668,-2.94528 8.48628,-2.82943 12.72792,-4.24264 4.24164,-1.41322 5.65786,-8.48628 8.48528,-12.72792 2.82743,-4.24164 10e-4,-4.24364 0,-6.36397 -10e-4,-2.12032 10e-4,-5.65785 0,-8.48528 -10e-4,-2.82742 10e-4,-7.54347 0,-11.3137 -10e-4,-3.77024 -4.28168,-15.98418 -6.42402,-23.97477 -2.14234,-7.99059 -7.7879,-29.06959 -11.68335,-43.60288" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="274.48175"
+       y="311.57025"
+       id="text5219-2-62"><tspan
+         sodipodi:role="line"
+         x="274.48175"
+         y="311.57025"
+         id="tspan5223-0-91"
+         style="font-size:10px;line-height:1.25">dequeue_atomic_flow, lock(step 2)</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="230.38838"
+       y="349.16824"
+       id="text5219-2-62-2"><tspan
+         sodipodi:role="line"
+         x="230.38838"
+         y="349.16824"
+         id="tspan5223-0-91-7"
+         style="font-size:10px;line-height:1.25">enqueue atomic flow(step 1)</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:1, 2;stroke-dashoffset:0;marker-end:url(#Arrow1Mend)"
+       d="m 284.13073,339.88611 c 0.17405,-3.87643 1.69528,-7.6795 4.24264,-10.6066 1.21368,-1.3946 2.65204,-2.59324 4.24264,-3.53554"
+       id="path3226"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3228"
+       inkscape:original-d="m 284.13073,339.88611 c 1.65092,-3.53654 2.82943,-7.07207 4.24264,-10.6066 1.41322,-3.53454 2.82943,-2.35803 4.24264,-3.53554" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="54.031021"
+       y="305.13019"
+       id="text5219-2-62-2-0"><tspan
+         sodipodi:role="line"
+         x="54.031021"
+         y="305.13019"
+         id="tspan5223-0-91-7-9"
+         style="font-size:10px;line-height:1.25">produce atomic flows(step 0)</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="221.4942"
+       y="271.6572"
+       id="text5219-2-62-3"><tspan
+         sodipodi:role="line"
+         x="221.4942"
+         y="271.6572"
+         id="tspan5223-0-91-6"
+         style="font-size:10px;line-height:1.25"> unlock and enqueue(step 3)</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="228.94464"
+       y="232.44748"
+       id="text5219-2-62-3-0"><tspan
+         sodipodi:role="line"
+         x="228.94464"
+         y="232.44748"
+         id="tspan5223-0-91-6-6"
+         style="font-size:10px;line-height:1.25">dequeue_atomic_flow, lock (step 4)</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1, 2;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 125.03171,296.7526 c 3.74786,-3.82704 6.25815,-8.84762 7.07106,-14.14214 0.89616,-5.83674 -0.22472,-11.84652 0.70712,-17.67767 0.88602,-5.54438 3.67535,-10.76654 7.79086,-14.58594 4.11551,-3.81939 9.53103,-6.21176 15.12603,-6.68208"
+       id="path3284"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3286"
+       inkscape:original-d="m 125.03171,296.7526 c 2.35802,-4.71505 4.71504,-9.42909 7.07106,-14.14214 2.35603,-4.71304 -4.47734,-16.97156 0.70712,-17.67767 5.18445,-0.70611 8.30435,-19.6191 22.91689,-21.26802"
+       sodipodi:nodetypes="ccsc" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:1, 2;stroke-dashoffset:0;marker-end:url(#Arrow1Mend)"
+       d="m 400.09624,301.70234 c 2.99719,-1.5536 6.06561,-2.9698 9.19239,-4.24264 10.36506,-4.21939 21.37433,-6.85204 32.52691,-7.77817"
+       id="path3288"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3290"
+       inkscape:original-d="m 400.09624,301.70234 c 3.06513,-1.41521 6.12926,-2.82942 9.19239,-4.24264 3.06313,-1.41321 21.68561,-5.18645 32.52691,-7.77817" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:1, 2;stroke-dashoffset:0;marker-end:url(#Arrow1Mend)"
+       d="m 366.15512,272.71097 c 3.81527,2.26146 7.84644,4.15848 12.02081,5.65685 11.69951,4.19948 24.37655,5.20587 36.76955,4.24264 17.71147,-1.3766 35.17977,-6.78471 50.20458,-16.26345 1.43767,-0.90698 2.85248,-1.85019 4.24264,-2.82843"
+       id="path3292"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3294"
+       inkscape:original-d="m 366.15512,272.71097 c 4.00793,1.88461 8.01487,3.77023 12.02081,5.65685 4.00594,1.88662 24.51404,2.82743 36.76955,4.24264 12.25552,1.41521 33.47072,-10.8433 50.20458,-16.26345 16.73386,-5.42016 2.82943,-1.88662 4.24264,-2.82843" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:1, 2;stroke-dashoffset:0;marker-end:url(#Arrow1Mend)"
+       d="m 336.45663,221.09217 c 2.28482,-4.91581 5.69736,-9.30336 9.8995,-12.72792 8.26499,-6.7356 19.09721,-9.47021 29.69848,-10.6066 11.02462,-1.18177 22.14702,-0.83857 33.23402,-0.70711 6.83505,0.081 13.67105,0.081 20.5061,0"
+       id="path3300"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3302"
+       inkscape:original-d="m 336.45663,221.09217 c 3.30083,-4.24364 6.60067,-8.48628 9.8995,-12.72792 3.29883,-4.24164 19.79999,-7.07207 29.69848,-10.6066 9.8985,-3.53454 22.15701,-0.47241 33.23402,-0.70711 11.07701,-0.2347 13.67173,-0.001 20.5061,0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="316.1026"
+       y="170.71103"
+       id="text5219-2-62-3-0-3"><tspan
+         sodipodi:role="line"
+         x="316.1026"
+         y="170.71103"
+         id="tspan5223-0-91-6-6-6"
+         style="font-size:10px;line-height:1.25">unlock(step 5)</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.65;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:0.65, 1.3;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#Arrow1Mend-4-3)"
+       d="m 351.54328,162.29923 c 4.37234,-3.84771 8.74462,-7.69536 17.46372,-9.28631 8.71911,-1.59095 21.78354,-0.92534 34.84719,-0.25978"
+       id="path12082"
+       inkscape:path-effect="#path-effect12084"
+       inkscape:original-d="m 351.54328,162.29923 c 4.37327,-3.84665 8.74555,-7.6943 13.11682,-11.54294 13.06596,0.66663 26.13039,1.33224 39.19409,1.99685" />
+  </g>
+</svg>
diff --git a/doc/guides/tools/img/eventdev_atomic_queue_test.svg b/doc/guides/tools/img/eventdev_atomic_queue_test.svg
new file mode 100644
index 0000000000..38d9a555df
--- /dev/null
+++ b/doc/guides/tools/img/eventdev_atomic_queue_test.svg
@@ -0,0 +1,1701 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<!--
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2017 Cavium, Inc
+#
+-->
+
+<svg
+   width="631.91431"
+   height="288.34286"
+   id="svg3868"
+   version="1.1"
+   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
+   sodipodi:docname="eventdev_atomic_queue_test.svg"
+   sodipodi:version="0.32"
+   inkscape:output_extension="org.inkscape.output.svg.inkscape"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
+   xmlns:cc="http://creativecommons.org/ns#"
+   xmlns:dc="http://purl.org/dc/elements/1.1/">
+  <defs
+     id="defs3870">
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect12084"
+       is_visible="true"
+       lpeversion="1"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect10830"
+       is_visible="true"
+       lpeversion="1"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <linearGradient
+       id="linearGradient6425"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#e6860b;stop-opacity:1;"
+         offset="0"
+         id="stop6423" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient6391"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#000000;stop-opacity:1;"
+         offset="0"
+         id="stop6389" />
+    </linearGradient>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect6387"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect6037"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect6033"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect6029"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect6025"
+       is_visible="true" />
+    <linearGradient
+       id="linearGradient5213"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#ff0009;stop-opacity:1;"
+         offset="0"
+         id="stop5211" />
+    </linearGradient>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect4276"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect4272"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect4268"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect4264"
+       is_visible="true" />
+    <linearGradient
+       id="linearGradient2975"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#ff2200;stop-opacity:1;"
+         offset="0"
+         id="stop2973" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient2969"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#009a08;stop-opacity:1;"
+         offset="0"
+         id="stop2967" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient2963"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#000000;stop-opacity:1;"
+         offset="0"
+         id="stop2961" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient2929"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#ff2d00;stop-opacity:1;"
+         offset="0"
+         id="stop2927" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient4610"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#00ffff;stop-opacity:1;"
+         offset="0"
+         id="stop4608" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3993"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#6ba6fd;stop-opacity:1;"
+         offset="0"
+         id="stop3991" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3808"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#6ba6fd;stop-opacity:1;"
+         offset="0"
+         id="stop3806" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3776"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#fc0000;stop-opacity:1;"
+         offset="0"
+         id="stop3774" />
+    </linearGradient>
+    <linearGradient
+       id="linearGradient3438"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#d18f21;stop-opacity:1;"
+         offset="0"
+         id="stop3436" />
+    </linearGradient>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3408"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3404"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3400"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3392"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3376"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3044"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3040"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3036"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3032"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3028"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3024"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3020"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect2858"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect2854"
+       is_visible="true" />
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect2844"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <linearGradient
+       id="linearGradient2828"
+       inkscape:swatch="solid">
+      <stop
+         style="stop-color:#ff0000;stop-opacity:1;"
+         offset="0"
+         id="stop2826" />
+    </linearGradient>
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect329"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <marker
+       inkscape:stockid="Arrow1Mstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mstart"
+       style="overflow:visible">
+      <path
+         id="path4530"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.4,0,0,0.4,4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend"
+       style="overflow:visible">
+      <path
+         id="path4533"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <linearGradient
+       id="linearGradient4513">
+      <stop
+         style="stop-color:#fdffdb;stop-opacity:1;"
+         offset="0"
+         id="stop4515" />
+      <stop
+         style="stop-color:#dfe2d8;stop-opacity:0;"
+         offset="1"
+         id="stop4517" />
+    </linearGradient>
+    <inkscape:perspective
+       sodipodi:type="inkscape:persp3d"
+       inkscape:vp_x="0 : 526.18109 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_z="744.09448 : 526.18109 : 1"
+       inkscape:persp3d-origin="372.04724 : 350.78739 : 1"
+       id="perspective3876" />
+    <inkscape:perspective
+       id="perspective3886"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Lend"
+       style="overflow:visible">
+      <path
+         id="path3211"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3892"
+       style="overflow:visible">
+      <path
+         id="path3894"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3896"
+       style="overflow:visible">
+      <path
+         id="path3898"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Lstart"
+       style="overflow:visible">
+      <path
+         id="path3208"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.8,0,0,0.8,10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3902"
+       style="overflow:visible">
+      <path
+         id="path3904"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3906"
+       style="overflow:visible">
+      <path
+         id="path3908"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.8,0,0,0.8,10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3910"
+       style="overflow:visible">
+      <path
+         id="path3912"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:perspective
+       id="perspective4086"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <inkscape:perspective
+       id="perspective4113"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient4513"
+       id="linearGradient4519"
+       x1="47.142857"
+       y1="244.50504"
+       x2="677.85718"
+       y2="244.50504"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="matrix(0.99477436,0,0,0.98597786,2.8382132,3.7730937)" />
+    <inkscape:perspective
+       id="perspective5195"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-4"
+       style="overflow:visible">
+      <path
+         id="path4533-7"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:perspective
+       id="perspective5272"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <marker
+       inkscape:stockid="Arrow1Mstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mstart-4"
+       style="overflow:visible">
+      <path
+         id="path4530-5"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.4,0,0,0.4,4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-0"
+       style="overflow:visible">
+      <path
+         id="path4533-3"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:perspective
+       id="perspective5317"
+       inkscape:persp3d-origin="0.5 : 0.33333333 : 1"
+       inkscape:vp_z="1 : 0.5 : 1"
+       inkscape:vp_y="0 : 1000 : 0"
+       inkscape:vp_x="0 : 0.5 : 1"
+       sodipodi:type="inkscape:persp3d" />
+    <marker
+       inkscape:stockid="Arrow1Mstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mstart-3"
+       style="overflow:visible">
+      <path
+         id="path4530-2"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(0.4,0,0,0.4,4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-06"
+       style="overflow:visible">
+      <path
+         id="path4533-1"
+         d="M 0,0 5,-5 -12.5,0 5,5 0,0 z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mstart"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mstart-8"
+       style="overflow:visible">
+      <path
+         id="path4530-7"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(0.4,0,0,0.4,4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-9"
+       style="overflow:visible">
+      <path
+         id="path4533-2"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect2858-0"
+       is_visible="true" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-3"
+       style="overflow:visible">
+      <path
+         id="path4533-75"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3044-9"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-3-2"
+       style="overflow:visible">
+      <path
+         id="path4533-75-8"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="bspline"
+       id="path-effect3044-9-9"
+       is_visible="true"
+       weight="33.333333"
+       steps="2"
+       helper_size="0"
+       apply_no_weight="true"
+       apply_with_weight="true"
+       only_selected="false" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3808"
+       id="linearGradient3810"
+       x1="61.233804"
+       y1="153.47966"
+       x2="308.87187"
+       y2="153.47966"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="matrix(0.97704237,0,0,1.0002563,1.4114958,-0.03933915)" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient3995"
+       x1="155.21328"
+       y1="231.61366"
+       x2="207.95523"
+       y2="231.61366"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient4612"
+       x1="594.77722"
+       y1="232.19244"
+       x2="647.51917"
+       y2="232.19244"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient4614"
+       x1="530.03839"
+       y1="232.3177"
+       x2="582.78033"
+       y2="232.3177"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient4616"
+       x1="468.32343"
+       y1="232.3177"
+       x2="521.06543"
+       y2="232.3177"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3438"
+       id="linearGradient4618"
+       x1="405.4682"
+       y1="232.36095"
+       x2="458.21014"
+       y2="232.36095"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient2963"
+       id="linearGradient2965"
+       x1="49.239535"
+       y1="244.84964"
+       x2="677.6483"
+       y2="244.84964"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient2969"
+       id="linearGradient2971"
+       x1="372.12487"
+       y1="333.32863"
+       x2="476.58178"
+       y2="333.32863"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient2975"
+       id="linearGradient2977"
+       x1="558.08159"
+       y1="336.1407"
+       x2="662.53851"
+       y2="336.1407"
+       gradientUnits="userSpaceOnUse" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-2"
+       style="overflow:visible">
+      <path
+         id="path4533-6"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3228"
+       is_visible="true" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="marker3706"
+       style="overflow:visible">
+      <path
+         id="path3704"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3286"
+       is_visible="true" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-1"
+       style="overflow:visible">
+      <path
+         id="path4533-8"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3290"
+       is_visible="true" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient2969"
+       id="linearGradient5215"
+       x1="474.25354"
+       y1="288.07208"
+       x2="607.70117"
+       y2="288.07208"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="translate(2.9619308,1.9381716)" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient2969"
+       id="linearGradient5217"
+       x1="475.90207"
+       y1="275.55313"
+       x2="550.59595"
+       y2="275.55313"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="matrix(1.0378669,0,0,1.0378669,-20.849369,-9.3151532)" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient2969"
+       id="linearGradient5219"
+       x1="430.01959"
+       y1="275.94962"
+       x2="483.12329"
+       y2="275.94962"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="matrix(1.0526015,0,0,1.1085927,-22.60217,-28.51638)" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient2969"
+       id="linearGradient5221"
+       x1="409.40347"
+       y1="274.47592"
+       x2="424.67188"
+       y2="274.47592"
+       gradientUnits="userSpaceOnUse"
+       gradientTransform="matrix(0.99688019,0,0,1.0540252,2.0081849,-13.414405)" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-3-7"
+       style="overflow:visible">
+      <path
+         id="path4533-75-9"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3120-7"
+       is_visible="true" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-4-2"
+       style="overflow:visible">
+      <path
+         id="path4533-7-0"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect6025-2"
+       is_visible="true" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient6427"
+       x1="629.66772"
+       y1="279.10413"
+       x2="652.93823"
+       y2="279.10413"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient6429"
+       x1="548.02209"
+       y1="278.62817"
+       x2="594.85144"
+       y2="278.62817"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient6431"
+       x1="439.92499"
+       y1="294.88806"
+       x2="559.63593"
+       y2="294.88806"
+       gradientUnits="userSpaceOnUse" />
+    <linearGradient
+       inkscape:collect="always"
+       xlink:href="#linearGradient3993"
+       id="linearGradient6433"
+       x1="483.44641"
+       y1="280.99118"
+       x2="564.04688"
+       y2="280.99118"
+       gradientUnits="userSpaceOnUse" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-7"
+       style="overflow:visible">
+      <path
+         id="path4533-5"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3294"
+       is_visible="true" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-92"
+       style="overflow:visible">
+      <path
+         id="path4533-28"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3302"
+       is_visible="true" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-97"
+       style="overflow:visible">
+      <path
+         id="path4533-36"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3228-1"
+       is_visible="true" />
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Mend-92-7"
+       style="overflow:visible">
+      <path
+         id="path4533-28-5"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <inkscape:path-effect
+       effect="spiro"
+       id="path-effect3302-3"
+       is_visible="true"
+       lpeversion="0" />
+  </defs>
+  <sodipodi:namedview
+     id="base"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageopacity="0.0"
+     inkscape:pageshadow="2"
+     inkscape:zoom="4.0000002"
+     inkscape:cx="321.12498"
+     inkscape:cy="71.999996"
+     inkscape:document-units="px"
+     inkscape:current-layer="layer1"
+     showgrid="false"
+     inkscape:window-width="1536"
+     inkscape:window-height="1059"
+     inkscape:window-x="2606"
+     inkscape:window-y="223"
+     inkscape:window-maximized="0"
+     fit-margin-top="0.1"
+     fit-margin-left="0.1"
+     fit-margin-right="0.1"
+     fit-margin-bottom="0.1"
+     inkscape:measure-start="-29.078,219.858"
+     inkscape:measure-end="346.809,219.858"
+     showguides="false"
+     inkscape:pagecheckerboard="0" />
+  <metadata
+     id="metadata3873">
+    <rdf:RDF>
+      <cc:Work
+         rdf:about="">
+        <dc:format>image/svg+xml</dc:format>
+        <dc:type
+           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
+        <dc:title />
+      </cc:Work>
+    </rdf:RDF>
+  </metadata>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(-46.542857,-100.33361)">
+    <rect
+       style="fill:url(#linearGradient4519);fill-opacity:1;stroke:url(#linearGradient2965);stroke-width:0.99036628;stroke-opacity:1"
+       id="rect3697"
+       width="627.4184"
+       height="283.11649"
+       x="49.734718"
+       y="103.2914"
+       rx="0"
+       ry="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="528.47687"
+       y="380.4664"
+       id="text2912"
+       inkscape:export-filename="/home/matz/barracuda/rapports/mbuf-api-v2-images/octeon_multi.png"
+       inkscape:export-xdpi="112"
+       inkscape:export-ydpi="112"><tspan
+         sodipodi:role="line"
+         x="528.47687"
+         y="380.4664"
+         id="tspan2916"
+         style="font-weight:bold;font-size:13.3333px;line-height:1.25">test: atomic_queue</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="99.327995"
+       y="317.25745"
+       id="text2978"
+       inkscape:export-filename="/home/matz/barracuda/rapports/mbuf-api-v2-images/octeon_multi.png"
+       inkscape:export-xdpi="112"
+       inkscape:export-ydpi="112"><tspan
+         sodipodi:role="line"
+         x="99.327995"
+         y="317.25745"
+         id="tspan3006"
+         style="font-size:15.2252px;line-height:1.25"> </tspan></text>
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient4614);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87"
+       width="51.714954"
+       height="32.587509"
+       x="530.55188"
+       y="216.02396"
+       rx="11.6051"
+       ry="16.293755" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient4612);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87-3"
+       width="51.714954"
+       height="32.587509"
+       x="595.29071"
+       y="215.89868"
+       rx="11.6051"
+       ry="16.293755" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient4616);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87-6"
+       width="51.714954"
+       height="32.587509"
+       x="468.83694"
+       y="216.02396"
+       rx="11.6051"
+       ry="16.293755" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient2977);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect128"
+       width="103.42992"
+       height="57.382355"
+       x="558.59509"
+       y="307.44952"
+       rx="8.5874901"
+       ry="10.712767" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient2971);stroke-width:1.027;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect128-7"
+       width="103.43"
+       height="57.382355"
+       x="372.63837"
+       y="304.63745"
+       rx="8.5874901"
+       ry="10.712767" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient4618);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87-6-5"
+       width="51.714954"
+       height="32.587509"
+       x="405.98169"
+       y="216.06718"
+       rx="11.6051"
+       ry="16.293755" />
+    <rect
+       style="fill:#ffffff;fill-opacity:1;stroke:url(#linearGradient3995);stroke-width:1.02699995;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect87-6-5-3"
+       width="51.714954"
+       height="32.587509"
+       x="155.72678"
+       y="215.3199"
+       rx="11.6051"
+       ry="16.293755" />
+    <path
+       style="fill:none;stroke:#009587;stroke-width:0.9931457;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 181.86811,247.66582 c 3.58556,24.38192 18.0972,46.94673 38.79478,60.32374 19.0792,12.33104 42.1302,16.69577 64.65795,19.6234 12.88313,1.67425 25.82062,2.9633 38.79477,3.63396 14.05094,0.72632 28.12813,0.72676 42.19783,0.72679 2.04183,0 4.08366,0 6.12549,0"
+       id="path2852"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect2854"
+       inkscape:original-d="m 181.86811,247.66582 c 12.93255,20.10689 25.86414,40.2148 38.79478,60.32374 12.93062,20.10895 43.10626,13.08124 64.65795,19.6234 21.55169,6.54215 25.86414,2.42161 38.79477,3.63396 12.93064,1.21233 28.13285,0.4835 42.19783,0.72679 14.06498,0.24328 4.08462,-10e-4 6.12549,0" />
+    <path
+       style="fill:none;stroke:#f70000;stroke-width:0.981;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend);marker-start:"
+       d="m 640.02293,307.22481 c -12.09421,-24.58854 -24.27852,-49.36025 -30.348,-70.97018 -6.06948,-21.60992 -6.06948,-40.14987 -6.06948,-58.68854"
+       id="path3042"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3044"
+       inkscape:original-d="m 640.02293,307.22481 c -11.90643,-24.6809 -24.27734,-49.36083 -36.41748,-74.03977 9.8e-4,-18.54033 9.8e-4,-37.08028 0,-55.61895" />
+    <path
+       style="stroke:#f90000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;fill-opacity:1;fill:none;marker-start:url(#Arrow1Mstart)"
+       d="m 541.5074,178.03818 c -5.9138,7.73622 -8.0643,18.21989 -5.67376,27.65957 1.48599,5.86783 4.57531,11.19036 7.80142,16.31206 21.74916,34.52845 51.56536,63.93984 86.38787,85.215"
+       id="path3398"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3400"
+       inkscape:original-d="m 541.5074,178.03818 c -2.36307,8.74604 -3.78151,18.43871 -5.67376,27.65957 -1.89225,9.22086 5.20195,10.87371 7.80142,16.31206 2.59947,5.43835 57.59291,56.809 86.38787,85.215" />
+    <path
+       style="fill:none;stroke:#fc0000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart)"
+       d="m 486.31591,175.32896 c -4.56701,3.4939 -7.88094,8.59224 -9.21986,14.18439 -1.17323,4.90013 -0.85198,10.07279 0.32038,14.97313 1.17237,4.90034 3.17163,9.56311 5.35338,14.10489 18.70771,38.94408 52.03948,70.64767 91.8709,87.38319"
+       id="path3402"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3404"
+       inkscape:original-d="m 486.31591,175.32896 c -4.01791,5.67276 -5.19994,8.50963 -9.21986,14.18439 -4.01991,5.67476 2.12866,20.32997 5.67376,29.07802 3.5451,8.74804 61.24827,58.25446 91.8709,87.38319"
+       sodipodi:nodetypes="ccsc" />
+    <path
+       style="fill:none;stroke:#fc0000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart)"
+       d="m 438.74144,177.32896 c -2.99229,7.65136 -4.44794,15.90007 -4.25532,24.11347 0.26469,11.28631 3.68787,22.50755 9.92908,31.9149 7.88401,11.88353 19.75202,20.40996 30.49645,29.78723 16.28636,14.21403 30.48909,30.90719 48.22696,43.26242 11.01957,7.67563 23.28348,13.56063 36.16571,17.3546"
+       id="path3406"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3408"
+       inkscape:original-d="m 438.74144,177.32896 c -3.5451,5.90916 -0.2354,18.20231 -4.25532,24.11347 -4.01991,5.91117 4.01991,19.14794 9.92908,31.9149 5.90917,12.76695 20.33197,19.85715 30.49645,29.78723 10.16449,9.93008 36.88044,34.98718 48.22696,43.26242 11.34652,8.27523 19.61974,10.85951 36.16571,17.3546"
+       sodipodi:nodetypes="ccsssc" />
+    <g
+       id="g4374">
+      <text
+         id="text5219-3"
+         y="187.92023"
+         x="132.8121"
+         style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+         xml:space="preserve"><tspan
+           style="font-size:10px;line-height:1.25"
+           id="tspan5223-6"
+           y="187.92023"
+           x="132.8121"
+           sodipodi:role="line">producer_flow_seq</tspan></text>
+      <g
+         id="g4286">
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="67.609619"
+           y="125.91534"
+           id="text5219"><tspan
+             sodipodi:role="line"
+             x="67.609619"
+             y="125.91534"
+             id="tspan5223"
+             style="font-size:10px;line-height:1.25">producer maintains per flow sequence number</tspan></text>
+        <rect
+           style="fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:url(#linearGradient3810);stroke-width:0.97884095;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect2896"
+           width="240.98547"
+           height="44.122215"
+           x="61.723225"
+           y="131.41856"
+           ry="8.8282356"
+           rx="9.0800323"
+           inkscape:export-filename="/home/matz/barracuda/rapports/mbuf-api-v2-images/octeon_multi.png"
+           inkscape:export-xdpi="112"
+           inkscape:export-ydpi="112" />
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#6ba6fd;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect3736"
+           width="39.065548"
+           height="24.347494"
+           x="70.045547"
+           y="143.98941" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="76.606445"
+           y="141.62436"
+           id="text5219-1-9"><tspan
+             sodipodi:role="line"
+             x="76.606445"
+             y="141.62436"
+             id="tspan5223-2-3"
+             style="font-size:10px;line-height:1.25">flow 0</tspan></text>
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#6ba6fd;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect3736-8"
+           width="39.065548"
+           height="24.347494"
+           x="129.42143"
+           y="144.7206" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="131.98233"
+           y="142.35555"
+           id="text5219-1-9-4"><tspan
+             sodipodi:role="line"
+             x="131.98233"
+             y="142.35555"
+             id="tspan5223-2-3-5"
+             style="font-size:10px;line-height:1.25">flow 1</tspan></text>
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="195.98233"
+           y="142.35555"
+           id="text5219-1-9-4-3"><tspan
+             sodipodi:role="line"
+             x="195.98233"
+             y="142.35555"
+             id="tspan5223-2-3-5-6"
+             style="font-size:10px;line-height:1.25">flow 2</tspan></text>
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#6ba6fd;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect3736-8-0-1"
+           width="39.065548"
+           height="24.347494"
+           x="251.42145"
+           y="144.7206" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+           x="257.98233"
+           y="142.35555"
+           id="text5219-1-9-4-3-0"><tspan
+             sodipodi:role="line"
+             x="257.98233"
+             y="142.35555"
+             id="tspan5223-2-3-5-6-6"
+             style="font-size:10px;line-height:1.25">flow n</tspan></text>
+        <rect
+           style="fill:none;fill-opacity:1;stroke:#6ba6fd;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+           id="rect3736-8-3"
+           width="39.065548"
+           height="24.347494"
+           x="192.15901"
+           y="144.7155" />
+      </g>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="157.0374"
+       y="258.07278"
+       id="text5219-2"><tspan
+         sodipodi:role="line"
+         x="157.0374"
+         y="258.07278"
+         id="tspan5223-0"
+         style="font-size:10px;line-height:1.25">producer0</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="384.74597"
+       y="334.61694"
+       id="text5219-6"><tspan
+         sodipodi:role="line"
+         x="384.74597"
+         y="334.61694"
+         id="tspan5223-1"
+         style="font-size:10px;line-height:1.25">atomic queue 0</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="569.64355"
+       y="336.42307"
+       id="text5219-6-5"><tspan
+         sodipodi:role="line"
+         x="569.64355"
+         y="336.42307"
+         id="tspan5223-1-5"
+         style="font-size:10px;line-height:1.25">atomic queue 1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="410.87885"
+       y="213.34842"
+       id="text5219-2-4"><tspan
+         sodipodi:role="line"
+         x="410.87885"
+         y="213.34842"
+         id="tspan5223-0-7"
+         style="font-size:10px;line-height:1.25">worker 0</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="157.44383"
+       y="236.49918"
+       id="text5219-2-6"><tspan
+         sodipodi:role="line"
+         x="157.44383"
+         y="236.49918"
+         id="tspan5223-0-9"
+         style="font-size:10px;line-height:1.25">port n+1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="472.61508"
+       y="213.66943"
+       id="text5219-2-4-3"><tspan
+         sodipodi:role="line"
+         x="472.61508"
+         y="213.66943"
+         id="tspan5223-0-7-7"
+         style="font-size:10px;line-height:1.25">worker 1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="534.61511"
+       y="213.66943"
+       id="text5219-2-4-3-4"><tspan
+         sodipodi:role="line"
+         x="534.61511"
+         y="213.66943"
+         id="tspan5223-0-7-7-5"
+         style="font-size:10px;line-height:1.25">worker 2</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="600.61511"
+       y="213.66943"
+       id="text5219-2-4-3-4-2"><tspan
+         sodipodi:role="line"
+         x="600.61511"
+         y="213.66943"
+         id="tspan5223-0-7-7-5-5"
+         style="font-size:10px;line-height:1.25">worker n</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="420.13348"
+       y="234.8974"
+       id="text5219-2-6-4"><tspan
+         sodipodi:role="line"
+         x="420.13348"
+         y="234.8974"
+         id="tspan5223-0-9-7"
+         style="font-size:10px;line-height:1.25">port 0</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="477.25241"
+       y="234.85495"
+       id="text5219-2-6-4-4"><tspan
+         sodipodi:role="line"
+         x="477.25241"
+         y="234.85495"
+         id="tspan5223-0-9-7-4"
+         style="font-size:10px;line-height:1.25">port 1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="539.25244"
+       y="234.85495"
+       id="text5219-2-6-4-4-3"><tspan
+         sodipodi:role="line"
+         x="539.25244"
+         y="234.85495"
+         id="tspan5223-0-9-7-4-0"
+         style="font-size:10px;line-height:1.25">port 2</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="607.25244"
+       y="234.85495"
+       id="text5219-2-6-4-4-3-7"><tspan
+         sodipodi:role="line"
+         x="607.25244"
+         y="234.85495"
+         id="tspan5223-0-9-7-4-0-8"
+         style="font-size:10px;line-height:1.25">port n</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="478.92789"
+       y="188.00357"
+       id="text5219-3-2"><tspan
+         sodipodi:role="line"
+         x="478.92789"
+         y="188.00357"
+         id="tspan5223-6-7"
+         style="font-size:10px;line-height:1.25">expected_flow_seq</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="433.7254"
+       y="125.99867"
+       id="text5219-26"><tspan
+         sodipodi:role="line"
+         x="433.7254"
+         y="125.99867"
+         id="tspan5223-10"
+         style="font-size:10px;line-height:1.25">per flow expected sequence number</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#ff2d00;stroke-width:0.97884095;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect2896-6"
+       width="240.98547"
+       height="44.122215"
+       x="407.83902"
+       y="131.50191"
+       ry="8.8282356"
+       rx="9.0800323"
+       inkscape:export-filename="/home/matz/barracuda/rapports/mbuf-api-v2-images/octeon_multi.png"
+       inkscape:export-xdpi="112"
+       inkscape:export-ydpi="112" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#ff2d00;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect3736-1"
+       width="39.065548"
+       height="24.347494"
+       x="416.16132"
+       y="144.07275" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="422.72223"
+       y="141.7077"
+       id="text5219-1-9-5"><tspan
+         sodipodi:role="line"
+         x="422.72223"
+         y="141.7077"
+         id="tspan5223-2-3-9"
+         style="font-size:10px;line-height:1.25">flow 0</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#ff2d00;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect3736-8-4"
+       width="39.065548"
+       height="24.347494"
+       x="475.5372"
+       y="144.80394" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="478.09811"
+       y="142.43889"
+       id="text5219-1-9-4-9"><tspan
+         sodipodi:role="line"
+         x="478.09811"
+         y="142.43889"
+         id="tspan5223-2-3-5-0"
+         style="font-size:10px;line-height:1.25">flow 1</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="542.09808"
+       y="142.43889"
+       id="text5219-1-9-4-3-9"><tspan
+         sodipodi:role="line"
+         x="542.09808"
+         y="142.43889"
+         id="tspan5223-2-3-5-6-1"
+         style="font-size:10px;line-height:1.25">flow 2</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#ff2d00;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect3736-8-0-1-7"
+       width="39.065548"
+       height="24.347494"
+       x="597.53723"
+       y="144.80394" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="604.09808"
+       y="142.43889"
+       id="text5219-1-9-4-3-0-7"><tspan
+         sodipodi:role="line"
+         x="604.09808"
+         y="142.43889"
+         id="tspan5223-2-3-5-6-6-1"
+         style="font-size:10px;line-height:1.25">flow n</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#ff2d00;stroke-width:1.06814909;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1"
+       id="rect3736-8-3-1"
+       width="39.065548"
+       height="24.347494"
+       x="538.27478"
+       y="144.79884" />
+    <path
+       style="fill:none;stroke:#2ce3ea;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart);marker-end:url(#Arrow1Mend)"
+       d="m 86.923031,168.93973 c 2.833543,14.16771 5.667239,28.33619 16.884859,38.84515 11.21761,10.50897 30.81628,17.35669 50.41543,24.20459"
+       id="path3022"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3024"
+       inkscape:original-d="m 86.923031,168.93973 c 2.834697,14.16748 5.668393,28.33596 8.50109,42.50544 19.601799,6.84748 39.200469,13.6952 58.799199,20.5443" />
+    <path
+       style="fill:none;stroke:#2ce3ea;stroke-width:0.94190133px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart);marker-end:url(#Arrow1Mend)"
+       d="m 146.34977,174.57512 c 2.37508,8.12236 4.75033,16.24527 9.26371,23.01491 4.51339,6.76964 11.16356,12.18449 17.81407,17.59962"
+       id="path3026"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3028"
+       inkscape:original-d="m 146.34977,174.57512 c 2.37625,8.12202 4.7515,16.24493 7.12573,24.36872 6.6522,5.4148 13.30237,10.82966 19.95205,16.24581" />
+    <path
+       style="fill:none;stroke:#2ce3ea;stroke-width:0.80414414px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart);marker-end:url(#Arrow1Mend)"
+       d="m 216.07443,175.10554 c -8.16931,13.20464 -16.33919,26.41022 -24.50966,39.61674"
+       id="path3034"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3036"
+       inkscape:original-d="m 216.07443,175.10554 c -8.1691,13.20477 -16.33899,26.41034 -24.50966,39.61674" />
+    <path
+       style="fill:none;stroke:#2ce3ea;stroke-width:0.77416188px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-start:url(#Arrow1Mstart);marker-end:url(#Arrow1Mend)"
+       d="m 275.03639,177.69945 c -3.2253,11.1515 -6.45088,22.30399 -17.30887,30.95868 -10.85798,8.65469 -29.34621,14.80993 -47.83697,20.96602"
+       id="path3038"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3040"
+       inkscape:original-d="m 275.03639,177.69945 c -3.22467,11.15168 -6.45026,22.30417 -9.67676,33.4575 -18.49025,6.1554 -36.97848,12.31064 -55.46908,18.4672" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="215.93097"
+       y="349.08289"
+       id="text5219-2-62-2"><tspan
+         sodipodi:role="line"
+         x="215.93097"
+         y="349.08289"
+         id="tspan5223-0-91-7"
+         style="font-size:10px;line-height:1.25">enqueue(step 1)</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="53.573601"
+       y="307.04483"
+       id="text5219-2-62-2-0"><tspan
+         sodipodi:role="line"
+         x="53.573601"
+         y="307.04483"
+         id="tspan5223-0-91-7-9"
+         style="font-size:10px;line-height:1.25">produce atomic flows(step 0)</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1, 2;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#Arrow1Mend-2)"
+       d="m 124.57429,298.66726 c 3.67724,-3.88246 6.17144,-8.87087 7.07106,-14.14214 0.99323,-5.81974 0.0756,-11.80766 0.70712,-17.67767 0.68671,-6.38281 3.2487,-12.55246 7.28535,-17.54419 4.03665,-4.99173 9.53369,-8.7879 15.63155,-10.7949"
+       id="path3284"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3286"
+       inkscape:original-d="m 124.57429,298.66726 c 2.35802,-4.71505 4.71504,-9.42909 7.07106,-14.14214 2.35603,-4.71304 -4.47734,-16.97156 0.70712,-17.67767 5.18445,-0.70611 8.30435,-26.69017 22.9169,-28.33909"
+       sodipodi:nodetypes="ccsc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="243.45221"
+       y="299.112"
+       id="text5219-2-62"><tspan
+         sodipodi:role="line"
+         x="243.45221"
+         y="299.112"
+         id="tspan5223-0-91"
+         style="font-size:10px;line-height:1.25">dequeue, lock(step 2)</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1, 2;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#Arrow1Mend-1)"
+       d="m 369.06669,289.2441 c 2.99719,-1.5536 6.06561,-2.9698 9.19239,-4.24264 10.36506,-4.21939 21.37433,-6.85204 32.52691,-7.77817"
+       id="path3288"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3290"
+       inkscape:original-d="m 369.06669,289.2441 c 3.06513,-1.41521 6.12926,-2.82942 9.19239,-4.24264 3.06313,-1.41321 21.68561,-5.18645 32.52691,-7.77817" />
+    <path
+       style="fill:none;stroke:url(#linearGradient5221);stroke-width:1.02505457px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 412.13462,303.84217 c -1.78221,-8.21339 -1.99449,-16.76454 -0.62202,-25.05624 1.75585,-10.60783 6.12178,-20.77383 12.60532,-29.35128"
+       id="path4262"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect4264"
+       inkscape:original-d="m 412.13462,303.84217 c -0.20635,-8.35314 -0.41368,-16.70522 -0.62202,-25.05624 -0.20832,-8.35102 8.40455,-19.56856 12.60532,-29.35128" />
+    <path
+       style="fill:none;stroke:url(#linearGradient5219);stroke-width:1.08023429px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 430.54474,305.94863 c 1.69515,-6.54525 4.20133,-12.88001 7.44301,-18.81342 3.60164,-6.59226 8.11378,-12.68982 13.39743,-18.02956 9.02277,-9.11854 20.30848,-15.98095 32.55605,-19.79607"
+       id="path4266"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect4268"
+       inkscape:original-d="m 430.54474,305.94863 c 2.23395,-6.01096 4.96307,-12.54338 7.44301,-18.81342 2.47997,-6.27005 8.93268,-12.02081 13.39743,-18.02956 4.46476,-6.00874 21.70509,-13.19849 32.55605,-19.79607" />
+    <path
+       style="fill:none;stroke:url(#linearGradient5217);stroke-width:1.03786695px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 473.24617,306.85798 c 13.16685,-4.64153 26.0551,-10.07323 38.57234,-16.25615 11.0872,-5.47655 22.26981,-11.88166 29.35531,-22.01647 4.21744,-6.03245 6.78064,-13.2094 7.33883,-20.54872"
+       id="path4270"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect4272"
+       inkscape:original-d="m 473.24617,306.85798 c 12.85848,-5.41976 25.71593,-10.83847 38.57234,-16.25615 12.85641,-5.41767 19.57124,-14.67868 29.35531,-22.01647 9.78406,-7.3378 4.89359,-13.70019 7.33883,-20.54872" />
+    <path
+       style="fill:none;stroke:url(#linearGradient5215);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 477.30438,331.21768 c 12.46907,4.50534 26.59382,4.24853 38.89087,-0.70711 15.87809,-6.39877 27.91048,-19.8678 43.24046,-27.48684 5.17938,-2.57417 10.67531,-4.44881 15.95548,-6.80936 5.28016,-2.36055 10.43559,-5.28025 14.34317,-9.54442 5.02516,-5.48374 7.59372,-12.72742 9.8995,-19.79898 1.98775,-6.09621 3.87372,-12.22561 5.65685,-18.38478"
+       id="path4274"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect4276"
+       inkscape:original-d="m 477.30438,331.21768 c 12.96463,-0.23671 25.92825,-0.47241 38.89087,-0.70711 12.96263,-0.2347 28.12086,-20.44688 43.24046,-27.48684 15.11959,-7.03995 20.9072,-8.7822 30.29865,-16.35378 9.39144,-7.57158 4.71505,-14.37883 9.8995,-19.79898 5.18444,-5.42016 5.65785,-11.07901 5.65685,-18.38478"
+       sodipodi:nodetypes="cssscc" />
+    <path
+       style="fill:none;stroke:url(#linearGradient6431);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-4)"
+       d="m 440.40133,248.66934 c 3.19162,10.00334 8.25468,19.40617 14.84924,27.57716 3.66774,4.54451 7.79314,8.69906 12.02081,12.72792 10.2267,9.74579 21.15045,18.84495 33.23402,26.16295 8.57229,5.19151 17.67288,9.45409 26.87006,13.43503 10.00349,4.32995 20.14561,8.33962 30.40559,12.02082"
+       id="path6023"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect6025"
+       inkscape:original-d="m 440.40133,248.66934 c 4.95074,9.19138 9.90049,18.38377 14.84924,27.57716 4.94875,9.19339 8.01488,8.48428 12.02081,12.72792 4.00594,4.24364 22.15702,17.44097 33.23402,26.16295 11.07701,8.72199 17.91437,8.95569 26.87006,13.43503 8.95568,4.47934 20.27139,8.01288 30.40559,12.02082" />
+    <path
+       style="fill:none;stroke:url(#linearGradient6429);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-4)"
+       d="m 548.51265,248.03664 c 1.13857,5.77255 4.23753,11.14011 8.66742,15.01241 4.18454,3.65784 9.3801,5.91956 14.03601,8.95481 11.99609,7.82041 20.2499,21.13301 21.92031,35.35534"
+       id="path6031"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect6033"
+       inkscape:original-d="m 548.51265,248.03664 c 2.72916,4.7243 5.77928,10.00728 8.66742,15.01241 2.88814,5.00514 9.35834,5.96887 14.03601,8.95481 4.67767,2.98593 14.61454,23.56922 21.92031,35.35534" />
+    <path
+       style="fill:none;stroke:url(#linearGradient6427);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend-4)"
+       d="m 629.90594,247.96223 c 4.16076,2.2543 7.64519,5.73873 9.89949,9.89949 3.81368,7.0389 3.96402,15.38981 4.94975,23.33453 1.17967,9.50784 3.68303,18.85051 7.41533,27.67438"
+       id="path6035"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect6037"
+       inkscape:original-d="m 629.90594,247.96223 c 3.18298,3.18098 6.60066,6.59866 9.89949,9.89949 3.29884,3.30084 3.30084,15.55535 4.94975,23.33453 1.64892,7.77917 4.94455,18.44859 7.41533,27.67438" />
+    <path
+       style="fill:none;stroke:url(#linearGradient6433);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow1Mend)"
+       d="m 483.94123,249.30958 c 1.1199,7.72101 5.29709,14.95611 11.42373,19.78648 5.29578,4.1753 11.79761,6.49938 17.49811,10.10253 5.44652,3.44261 10.08603,8.00309 15.2195,11.89715 3.38678,2.56908 6.98502,4.84517 10.6066,7.07107 7.74785,4.76198 15.62669,9.31084 23.62461,13.63968"
+       id="path6385"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect6387"
+       inkscape:original-d="m 483.94123,249.30958 c 5.24772,5.24571 7.61682,13.18999 11.42373,19.78648 3.80691,6.59649 11.6664,6.73402 17.49811,10.10253 5.8317,3.36852 10.14733,7.93044 15.2195,11.89715 5.07216,3.96672 7.07206,4.71305 10.6066,7.07107 3.53453,2.35802 15.75074,9.09212 23.62461,13.63968" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="191.27325"
+       y="270.74423"
+       id="text5219-2-62-3"><tspan
+         sodipodi:role="line"
+         x="191.27325"
+         y="270.74423"
+         id="tspan5223-0-91-6"
+         style="font-size:10px;line-height:1.25">update queue id, enqueue, unlock(step 3)</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.76920223;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:0.76920221, 1.53840441;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#Arrow1Mend-7)"
+       d="m 357.93205,263.09044 c 3.35603,-1.55628 6.83267,-2.85241 10.38844,-3.87293 10.27369,-2.94859 21.10841,-3.56584 31.77639,-2.90469 15.00358,0.92985 29.94516,4.405 43.38701,11.13467 1.23601,0.61881 2.45857,1.2645 3.66651,1.93647"
+       id="path3292"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3294"
+       inkscape:original-d="m 357.93205,263.09044 c 3.46367,-1.29029 6.92649,-2.58127 10.38844,-3.87293 3.46195,-1.29167 21.18514,-1.93578 31.77639,-2.90469 10.59128,-0.96893 28.92555,7.4238 43.38701,11.13467 14.46147,3.71087 2.44521,1.29166 3.66651,1.93647" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="280.1011"
+       y="200.31314"
+       id="text5219-2-62-3-0"><tspan
+         sodipodi:role="line"
+         x="280.1011"
+         y="200.31314"
+         id="tspan5223-0-91-6-6"
+         style="font-size:10px;line-height:1.25">dequeue, lock(step 4)</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.64963406;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:0.64963409, 1.29926818;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#Arrow1Mend-92)"
+       d="m 347.02887,196.67228 c 2.73089,-2.27942 5.78054,-4.1764 9.03233,-5.6184 8.65182,-3.83663 18.36723,-4.34297 27.82919,-4.5551 10.47734,-0.23489 20.95878,-0.18017 31.43857,-0.11877 6.46997,0.0379 12.93992,0.0784 19.40986,0.12133"
+       id="path3300"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3302"
+       inkscape:original-d="m 347.02887,196.67228 c 3.0117,-1.87323 6.02249,-3.74603 9.03233,-5.6184 3.00986,-1.87236 18.55372,-3.03718 27.82919,-4.5551 9.27549,-1.51794 20.95997,-0.0796 31.43857,-0.11877 10.47862,-0.0391 12.94082,0.0804 19.40986,0.12133" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:1, 2;stroke-dashoffset:0;stroke-opacity:1;marker-end:url(#Arrow1Mend-97)"
+       d="m 281.77537,342.34916 c 0.17405,-3.87643 1.69528,-7.6795 4.24264,-10.6066 1.21368,-1.3946 2.65204,-2.59324 4.24264,-3.53554"
+       id="path3226"
+       inkscape:connector-curvature="0"
+       inkscape:path-effect="#path-effect3228-1"
+       inkscape:original-d="m 281.77537,342.34916 c 1.65092,-3.53654 2.82943,-7.07207 4.24264,-10.6066 1.41322,-3.53454 2.82943,-2.35803 4.24264,-3.53554" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;line-height:0%;font-family:'Bitstream Vera Sans';fill:#000000;fill-opacity:1;stroke:none"
+       x="319.30115"
+       y="168.93935"
+       id="text5219-2-62-3-0-3"><tspan
+         sodipodi:role="line"
+         x="319.30115"
+         y="168.93935"
+         id="tspan5223-0-91-6-6-6"
+         style="font-size:10px;line-height:1.25">unlock(step 5)</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.64999998;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:0.64999998,1.29999995;stroke-dashoffset:0;marker-end:url(#Arrow1Mend-4)"
+       d="m 354.74182,160.52755 c 4.37234,-3.84771 8.74462,-7.69536 17.46372,-9.28631 8.71911,-1.59095 21.78354,-0.92534 34.84719,-0.25978"
+       id="path12082"
+       inkscape:path-effect="#path-effect12084"
+       inkscape:original-d="m 354.74182,160.52755 c 4.37327,-3.84665 8.74555,-7.6943 13.11682,-11.54294 13.06596,0.66663 26.13039,1.33224 39.19409,1.99685" />
+  </g>
+</svg>
diff --git a/doc/guides/tools/testeventdev.rst b/doc/guides/tools/testeventdev.rst
index aaa0e5f24c..424e51ab28 100644
--- a/doc/guides/tools/testeventdev.rst
+++ b/doc/guides/tools/testeventdev.rst
@@ -55,6 +55,8 @@ The following are the application command-line options:
 
          order_queue
          order_atq
+         atomic_queue
+         atomic_atq
          perf_queue
          perf_atq
          pipeline_atq
@@ -326,6 +328,97 @@ Example command to run order queue test:
    sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x10 --vdev=event_sw0 -- \
                 --test=order_queue --plcores 1 --wlcores 2,3
 
+ORDER_ATOMIC Test
+~~~~~~~~~~~~~~~~~
+
+This is a functional test is similar to the ORDER_QUEUE test, but differs in two
+critical ways:
+
+#. Both queues (q0 and q1) are atomic. This makes it compatible with the
+   distributed software event device (dsw).
+#. Atomicity is verified using spinlocks for each combination of flow id and
+   queue id.
+
+.. _table_eventdev_atomic_queue_test:
+
+.. table:: Atomic queue test eventdev configuration.
+
+   +---+--------------+----------------+---------------------------+
+   | # | Items        | Value          | Comments                  |
+   |   |              |                |                           |
+   +===+==============+================+===========================+
+   | 1 | nb_queues    | 2              | q0(atomic), q1(atomic)    |
+   |   |              |                |                           |
+   +---+--------------+----------------+---------------------------+
+   | 2 | nb_producers | 1              |                           |
+   |   |              |                |                           |
+   +---+--------------+----------------+---------------------------+
+   | 3 | nb_workers   | >= 1           |                           |
+   |   |              |                |                           |
+   +---+--------------+----------------+---------------------------+
+   | 4 | nb_ports     | nb_workers +   | Workers use port 0 to     |
+   |   |              | 1              | port n-1.Producer uses    |
+   |   |              |                | port n.                   |
+   +---+--------------+----------------+---------------------------+
+
+.. _figure_eventdev_atomic_queue_test:
+
+.. figure:: img/eventdev_atomic_queue_test.*
+
+   atomic queue test operation.
+
+When an event is dequeued for processing, a spinlock is acquired for the
+the flow from which the event was dequeued. Once processing is complete,
+the lock is released. The test will fail if an attempt is made to take a lock
+that is already held. This indicates that multiple workers attempted to
+process the same flow at the same time, thereby violating atomicity.
+
+.. table:: Atomic queue test queue processing tasks.
+
+   +-----------+---------------------------------------------------+
+   | Queue ID  | Processing Task                                   |
+   |           |                                                   |
+   +===========+===================================================+
+   | 0         | Update queue ID for event and re-enqueue.         |
+   |           |                                                   |
+   +-----------+---------------------------------------------------+
+   | 1         | Verify sequence number.                           |
+   |           |                                                   |
+   +-----------+---------------------------------------------------+
+
+Application options
+^^^^^^^^^^^^^^^^^^^
+
+Supported application command line options are following::
+
+   --verbose
+   --dev
+   --test
+   --socket_id
+   --pool_sz
+   --plcores
+   --wlcores
+   --nb_flows
+   --nb_pkts
+   --worker_deq_depth
+   --deq_tmo_nsec
+
+Example
+^^^^^^^
+
+Example command to run with the software event device:
+
+.. code-block:: console
+
+   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x10 --vdev=event_sw0 -- \
+                --test=atomic_queue --plcores 1 --wlcores 2,3
+
+Example command to run with the distributed software event device:
+
+.. code-block:: console
+
+   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f --vdev=event_dsw0 -- \
+                --test=atomic_queue --plcores 1 --wlcores 2,3,4
 
 ORDER_ATQ Test
 ~~~~~~~~~~~~~~
@@ -389,6 +482,68 @@ Example command to run order ``all types queue`` test:
    sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -- \
                         --test=order_atq --plcores 1 --wlcores 2,3
 
+ATOMIC_ATQ Test
+~~~~~~~~~~~~~~~
+
+This test verifies the same aspects of ``atomic_queue`` test, the difference is
+the number of queues used, this test operates on a single ``all types queue(atq)``
+instead of two different atomic queues.
+
+.. _table_eventdev_atomic_atq_test:
+
+.. table:: Order all types queue test eventdev configuration.
+
+   +---+--------------+----------------+------------------------+
+   | # | Items        | Value          | Comments               |
+   |   |              |                |                        |
+   +===+==============+================+========================+
+   | 1 | nb_queues    | 1              | q0(all types queue)    |
+   |   |              |                |                        |
+   +---+--------------+----------------+------------------------+
+   | 2 | nb_producers | 1              |                        |
+   |   |              |                |                        |
+   +---+--------------+----------------+------------------------+
+   | 3 | nb_workers   | >= 1           |                        |
+   |   |              |                |                        |
+   +---+--------------+----------------+------------------------+
+   | 4 | nb_ports     | nb_workers +   | Workers use port 0 to  |
+   |   |              | 1              | port n-1.Producer uses |
+   |   |              |                | port n.                |
+   +---+--------------+----------------+------------------------+
+
+.. _figure_eventdev_atomic_atq_test:
+
+.. figure:: img/eventdev_atomic_atq_test.*
+
+   atomic all types queue test operation.
+
+Application options
+^^^^^^^^^^^^^^^^^^^
+
+Supported application command line options are following::
+
+   --verbose
+   --dev
+   --test
+   --socket_id
+   --pool_sz
+   --plcores
+   --wlcores
+   --nb_flows
+   --nb_pkts
+   --worker_deq_depth
+   --deq_tmo_nsec
+
+Example
+^^^^^^^
+
+Example command to run order ``all types queue`` test:
+
+.. code-block:: console
+
+   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -- \
+                        --test=atomic_atq --plcores 1 --wlcores 2,3
+
 
 PERF_QUEUE Test
 ~~~~~~~~~~~~~~~
-- 
2.34.1

