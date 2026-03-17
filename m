Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF56F3381F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 09:19:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 364DE402D1;
	Tue, 17 Mar 2026 10:19:23 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40]) by mails.dpdk.org (Postfix) with ESMTP id 4C73B40270;
 Tue, 17 Mar 2026 10:19:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZs2BBKJE9a8RnUWuVjRuNDlkxvP7ImrpnjI8tgyue/TQgakaSn2eaZz9EdhF+gj8BYyMsubKrDWFan1fobJO6Unto+37Isb0vKvWZsmToIdLrW5n81ingXsR0ZP3gZhiJBki3yyUHwJPZMia0II4OA8zjg6OjQMdSPSb/ZXtbOlHd7bPlTmMUSFjV+8ITc+OnGYe9Z7XlKYUMclpH0Mjor9mVgHQjBZ2qI3wPEotzVO49fRtfdJtWHJQiF0uhWZyF47eYgf0HrDOG/MPgnezC0192ddbEzliYKnSrB0s9K5t12hbaH0hvLmVJ8atJe6W0Qcv4yLFM2KXPUgWH4JUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRge4qN1Ct1MIqVJB7XmVUFYZfUFuJNzaTGjRPW1sAQ=;
 b=xX2Exm5YKDhNxo+dn56W+xj6hw3QaJfH6wOsOBZEDgS91imjvobc0xEmr2sBy8VloSdD1boEuia94vTuIpMnEBgu9+dxppnI1oLqYT1svlVWgW+rEpeqxejq8B2edRrz/GbjWv0bvsRJ5ULcAbFAdvZIcBwma3WgfkeaOA77cjKrBQrxZABQiIdRmmnVf1tCl27sb4lLgUAN83fT57mJUQZOcGskTSJfWBhre+AgmHZCXAt7OGb4OXgGhq49cGRexRRicmI1iaKg2ubO4coHrTeDI2cIm2LdvdvTDUB+9PO3211NIObz2m5JWSSUQL20rndd00dtodKAP8FA8Ipt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRge4qN1Ct1MIqVJB7XmVUFYZfUFuJNzaTGjRPW1sAQ=;
 b=eqmIiRkZist6JcjsaIkfJkGpo1DkE9xxMQFLUnjv6o/z8h+9xDJMY9Ko1sqrDzeEIjDbRlmeR331KQasjcYqYDq5VyymVPdTfQPF5hD7Gc5mrIMStJZkYl45dlZUA32Wa4oq/7D70mu2sMGKlDMpLt7VJ2gEbwIgWa79gediOv5YmmomuA0Sf2OPF6CQJuT5io8knD4qPPWWccmvQF4TR2qE1z9aawmaHAFLd9fuY5BBbwGDuB6rrS5y8kMgxPHPClNwYoTQR4WqGVxQIQ/r20GLvu/kAg2ntv9j4apdGjGJfdrgexVt+3zNVzUz0S4EevGf9AJQyH6CQad1OIfwyw==
Received: from BL1PR13CA0145.namprd13.prod.outlook.com (2603:10b6:208:2bb::30)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::991) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Tue, 17 Mar
 2026 09:18:05 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::9) by BL1PR13CA0145.outlook.office365.com
 (2603:10b6:208:2bb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 09:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 09:18:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 02:17:49 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 02:17:47 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <dev@dpdk.org>
CC: <wathsala.vithanage@arm.com>, <bruce.richardson@intel.com>,
 <honnappa.nagarahalli@arm.com>, <ruifeng.wang@arm.com>,
 <thomas@monjalon.net>, <stable@dpdk.org>
Subject: [PATCH] config/arm: fix the cacheline size for Grace CPU
Date: Tue, 17 Mar 2026 11:17:32 +0200
Message-ID: <20260317091732.289777-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: e82f15d3-968a-4ddf-1225-08de84061867
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: c8Y3jSbQ3NvnImjbc/eKo8hI8v37ybRTKAAj5vqSEjipiDkmRpPFKG4gZBaWSzYh+0xSJMPnN6BMpqLjTEp6wYXBYdnyUfu4DwuQL8B5yngOyqJ6iBVzuaie2RafWCXILW2IxzRwLY8r4vbFHFp5yU08wOGNmcTgmdzv3lPc0PZaq7BA59pzXyprd8x44BNtuQvWD4Wst8qeIHwDBTHBaf1BOwwOaCalptw3eCmolYWh1YaQidG77r5l3pEh61JcVzfkuPq4IKj87rq1xp+3gtTo9d2i8Atcymy6o4lcH0TwzsMFwfT3DhawFC9Qz9GD8fATbvyHNQLJ3QMGo5OBXCYgpCogZH7EyqTx/QKNqkNeQRg95KIy48fMieyey/M09yPEjfCMdjJz379Oc4ze+csn95jk6JGm7BVO02yIKpxsxhoOg4ogxRTdO2JPAG2Bt6Nfc2D1sKdvzeWUDigEOnKKKffw1ysoW47AupbKk8YDlC5GObXNVru8G2+pGBBD6JYwLPovUEURvN7k1l4FqFvYKbkvRNntHuL6shygiYh+risdTbc6j6G4Krg6AHxweAcSNWyPGxwIoQc0ioOC/CaSdzf0zl7NaztpRETsHmlGL7wR5Utm5PfwhJP+4uhTUUSRDN/0tZ44reWzytpYlLqfjw4gRFzwYvzZeRnpRvLL+Nkt5E0HfsGZzWjXb1MoMI07mFhj/K5VH6LxN32r4BUoHeVnfS1Oxn72hNQgR82yDNJOpt4KcEjPSRrG7aESySgeyG6YAhy5v5x/0GxGgg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hlCpUwxHAgxG6LtOdq5eVSS1+rk65rwkjLjnuoxDhqxH5INTPYrlhkstDYDzTGZ7b9r5SYsPDVHpGC3cVIWN1W/BSFJDHNqDeFCrQ73nndqI2S43K4eyqFt8zleHqxV3TOVdlS7rLPRMFEPzV8EZgHf6ZUOX5bftEg9q+N0hlLw/1UEwWJz7BpbAH0UUuAn2ci55SmWZPjk/+/v+KYjEg80IHAMsAXIGX5FFezcUGydN06AkSGON2DsTLv8Htxggxw4oQb7GVGosA3qtic68vNRnkQV6Lx3CnP9KHkpqq4tNm/F4/aTMWv4lUGzemNzGO5Sk5vYawV5ES7HAClaCsgMgd8per5fQ+tu5Bg6mKUi4bnvTIKwWK/LQYTIBcqU/N6cXNTWvmf4wKaHplumDujKttg1E17St5QtvFA4DvJSriOQr6hoXoQyt2KoP9tNg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:18:04.5322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82f15d3-968a-4ddf-1225-08de84061867
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70
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

The Nvidia Grace platform has a cacheline size with 64B, unlike the
128B size on other arm64 generic platforms. In the meson file, the
cacheline size is missing to be defined explicitly. So it will choose
128 for building and it will impact the performance.

In the ACM whitepaper, "The NVIDIA Grace CPU implements 72 Neoverse V2
Cores [16] with a 64-B cache line size".

Reference link:
https://dl.acm.org/doi/10.1145/3723851.3723853

Fixes: d007038c0121 ("config/arm: add NVIDIA Grace CPU")
Cc: honnappa.nagarahalli@arm.com
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 config/arm/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 523b0fc0ed..f7eac7da0a 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -535,6 +535,9 @@ soc_grace = {
     'implementer': '0x41',
     'part_number': '0xd4f',
     'extra_march_features': ['crypto'],
+    'flags': [
+        ['RTE_CACHE_LINE_SIZE', '"64"'],
+    ],
     'numa': true
 }
 
-- 
2.34.1

