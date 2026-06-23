Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA1BCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:39:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F70A40678;
	Tue, 23 Jun 2026 13:38:48 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by mails.dpdk.org (Postfix) with ESMTP id 4B5EF40677
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYYGmdPNRHYZ4BnMTw3hvFF3xndFJuxpFVEfcgPq96ItjbMMINgOuY7PmuAsOhGL7j7RDny7PLlndASYEpiM7nKhZCpBRDH83+I1nfAxhx/MtInkvSRCIF8GIMx6En6qz0HjtyFWvoFTy7jllastBXc150B3SKISiFL9F3dKiGFqak4eCbEWNWNd5ISLtdEZcbJNRXsPo1kAezeJb5vhbBVAbjMLUIImQxZaGrZ2jZYq+B53wHfqVNpGMyWKZc0jlXwDO+y2pBkE4NyrZWxcAdXg1eJGRR4ttTR3KuHSJ8pofl3uwXyjtmxinKn5ox5aXEhaFR3P2wZrcPaIXwZpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Miw8XAYZ1c/f+ms1DRv8tIpvKQnL5FIWDjHJYVavcf4=;
 b=MrNV0qUIDnmJXYHEezGDgAQShPUI9ZRGN/DciqoNTG8tviJsuBCOvLGZ0scNG9VCrAbdeJMeAZitQPpPqdC/AY6gOma9A9hmuUBSXEXBzU38u4qN1aZ7LlAcfvfkLCLQB+boBG2dXXRtjI1yhJXI9z50AJTEUcG0RSU/1SLUOAwHvrPRA4ExQRGcUg3p3Fg8lzz1lHSOJRmxX4mqau6uq04SBQizjA/Elvr+3ofVsjPWuDo/6/nEmhhGrutWuRHdVHtIHo6u520EzXT8vL0qqqU04FMgL+Um+1vSDDbGtAkNv2/Clzj4BFxQp4LNWRYKG4YINmEkTLiioCdbRTqTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Miw8XAYZ1c/f+ms1DRv8tIpvKQnL5FIWDjHJYVavcf4=;
 b=iuht0G0c7viJVPOdFpiAwUQO5LdveWtU59hRFV2dNwIiBsWxXro4BWTQ7JjSIsLorRYotTtWP04pxF+GyPHr68y0JjD/5/1ID7GmnhZ2xBGgpXNUoawfjB6UEPAF/y3TS+PxMl87PPCZJMQoMXj9X8ekUUUhjxVWnM8ASq3S4fDmLgXem6iwpoxSHyjI/gtEurXR6bRrXXAO+KQH9fAmE6fq7e5XfdxClofQ3CLZeT2ODMWsD7w6Il/4ScO/mLjz2PcLmsq0Cty/G1Mh1X+S1VrwrWIdgbIRBMcJLWoYOxaZMraKWf0qXSogGSmh/70XLGel4YOT3Awv6NUhi0n4eg==
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 23 Jun 2026 11:38:40 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::36) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 11:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:38:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:24 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:23 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH 2/5] drivers: support function versioning
Date: Tue, 23 Jun 2026 13:37:48 +0200
Message-ID: <20260623113752.1100072-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623113752.1100072-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: d7964c28-5c49-40a5-36d3-08ded11bf8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|10062099007|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: zQuGbzpm6/akp6iRD5gtdP6yqPP0WXlVYwF+oieZUYArf0HciDxTGvaGYiJBW3AgE+xVTyVt5oFZhPSTkRedYsZ4NQ881AZSBcy/VElTzC386YueM2U1Q7HgQnpFMR2Vro4kSqtNsn+9on0ILMLz0mEfdwb94orQly+nng52CJpHvGqbJOl+K8tIIAdMMY2hHbOpwmKNXA05UjHpnSb++T+36XgzMGM76/ROsAk+NZ9xncukkVnajFMiTodw8LB/i3GvV6a8LsgZiD2Igw3l3/ckKQLrIVgwKt7v3X9IoD/aDxKQ4QYhkUNwZeDqTRXHvnctDGkvYaHSp9RZavJiQyLVjE0xVKdpTF1d3+wKcmvCNThuSCytd8DyRmDYRh8OjfXs7SoA6aSepKpW6jk/sX+H86owqKUO/XSkmBYIyhayvr8CuJqkRLy/zkC9lb+uozGsq6xOKktIBfP5uNMC9ssYHUHY2i30uAQ7Rf2QORjZFDKnaopl3Qo5CfqdgACIkZQYY0GwpTWrRZ05WQ+zoQO73q1hOBT9+pmf05eGi9b9nRtghMLRI0O+hwOjDeJCcH0cLM9HBTAq5U+mHFjkXBhe+5PJlN0ExoeY165vZXUdrxFS1meq2ZHxW8i5dF8MW41j4HFsos1s3BJa0s2v1oPcROie4ho1+wO2+2VDwRnbpht4HilkffIlqMT6qtiqLyq6QU1Yo2meE0KGGtrNHA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(10062099007)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8bUOa1Tbp/8wIb2iRKXEjSlNmpEb3NRlPC2kU6n1bsiI1yLrZ9FqQyDaT5/etFd8j9OSJ274PgyDIK5NE63FFxn4R4+KrF/8+OpVrhMQ5HON4gkCBM5XJWE07Ksdld6VYGfBuQMbRfJ5Z1rfOPwDpP9f8lv+IdR5QwmxUWaQIE+7qvbTfU9DrfN/mjliNjAljNjTcTVjGLctVfXRXnRUAvF56ZxwWwKUMn2ww7BKdX03uzoOnKfJBfJP6ameGHjkWgW/7VU0CVo0vTTN/u5jE2yhOe5B8uBWayWCJfv82gqZHdi0Ibn+iwiyKJaD6G5c2Zuf7azF9x3Q6AGTHkJLRAtNl5rbxhU1Hsf/Y70MHpjxWY0gRdWWkHtb0vFQLH8ZOltnGKT0c71zlBpyRU242zIzA1hHUgb4NrYbCSSjznsX5+gRWYNBPQ6FhKodLqBw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:38:39.9628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7964c28-5c49-40a5-36d3-08ded11bf8c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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

Add support for enabling function versioning
(through use_function_versioning meson variable) for drivers,
similar to libraries.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 4d95604ecd..a63d93372a 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -171,6 +171,7 @@ foreach subpath:subdirs
         pkgconfig_extra_libs = []
         testpmd_sources = []
         require_iova_in_mbuf = true
+        use_function_versioning = false
         # for handling base code files which may need extra cflags
         base_sources = []
         base_cflags = []
@@ -273,6 +274,13 @@ foreach subpath:subdirs
         endif
         dpdk_conf.set(lib_name.to_upper(), 1)

+        if developer_mode and is_windows and use_function_versioning
+            message('@0@: Function versioning is not supported by Windows.'.format(name))
+        endif
+        if use_function_versioning
+            cflags += '-DRTE_USE_FUNCTION_VERSIONING'
+        endif
+
         dpdk_extra_ldflags += pkgconfig_extra_libs

         dpdk_headers += headers
--
2.47.3

