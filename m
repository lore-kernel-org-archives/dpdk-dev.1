Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB378606A33E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f8nHMlmo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A233840278;
	Mon,  9 Nov 2026 16:48:17 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 25F0740270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 16:48:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL1mZNLypp7qR3ZpHhKtuRpPg8KPf+q+YbRLJuh7qe9VA75m6LRoTtikbtJB3UVBauWoAQwGo0lRM9gBmmSuSTVq0LVfxV7IOuJ9/jUQgh+GLdUwS9YX/hi/knQSMHBeng4MU7SKUinGFBXLxTqGy57VozzggbDKzjC9oREHHRcYD4Q1P9qTvlWH0ml7qblCy3WgvJkfsTHlWEyvkJj6n4Su/VBx58GOGRDl/5YGTatlarORbPps1YomV9UpGnE2VqPT3CZSCfgkp1n1gxrZ8yRVk5AeaRy+dYPjooPEOKFWy2VQUWnYzo/zh4bQoiA2wXmqYFFHLaZ7q8BBwWpPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJV90YPPqiGnvXLd/DWIsvzf1Nt4T7EmCpDZnQVEdRE=;
 b=Yp22ABbV8Jm4oM07/paoMZpWE4r3D3etHDkXaRNnO+H8GJQLzAIckABCFkpMlw9ZsOOvjk/ZSXCrccOdUyGpWAWoIYC0+sHaJG6N7yMs7eh7Wk5dCwEpNB5o7IH3xIZAxkSshdQ2l0Kgy2zQncMVfqjvHMUGLpsdRuL6pfd9xuX2yv2mcdFwl+OvA8rh5ziJ9jRP1Tj4FgZgt3KF1kLvUb8/X54YjlKDyGyI4uhRc9S0epeZjuLErc7HwhI5GUfBknmd2VzEB879MaJzs4y9kGakxB+wUyYfxbcjzpayrduuMNi3BQh6/ktLFDPt7FkaSWb6vSSLNAlyEzJC3Y7DgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJV90YPPqiGnvXLd/DWIsvzf1Nt4T7EmCpDZnQVEdRE=;
 b=f8nHMlmohB0qiqgVexgGR9M6ZPHjJe49Hr5bAtBqy5wL32illgPI7pvFwfc150Ik3OffB13jNYWy5KBzGwUbPIMNv1ap/6pSZRVKrBmIZ1uoqNntQ7O6JoW+sp+yfFX+4JjzGHCFWr48+MEl7kNHkLZcSkMgz/OFXL02mKMeKfj+KSZBRF8B2HFC3Tc8uUWQzWYcoXY4N3Mn7bzRVSyW0+jby+5D1X/6+m5UGtYvtcdrDLuC5RBWsy0KarqLaFV0O9hC0AhA8o0m66zPsz19P+DTlZuJU/QcS5sXaKClDkFCBIrz8L0IhvndVV4BVHMEx/SZ0hW+QcohwW1evZBHWA==
Received: from SJ0PR05CA0206.namprd05.prod.outlook.com (2603:10b6:a03:330::31)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:48:10 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::74) by SJ0PR05CA0206.outlook.office365.com
 (2603:10b6:a03:330::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.7 via Frontend Transport; Mon, 9
 Nov 2026 15:48:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 15:48:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 07:47:47 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 07:47:44 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Frank Dressler
 <frank@dressler.pro>, Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Kevin Traynor <ktraynor@redhat.com>
Subject: [PATCH v2] net/af_packet: fix build with old kernel headers
Date: Mon, 9 Nov 2026 17:47:30 +0200
Message-ID: <20261109154730.146345-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106142756.241131-1-bingz@nvidia.com>
References: <20261106142756.241131-1-bingz@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d85389-ee5e-4665-d671-08df3e78da22
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|261021121427099003|56012099006|261021135927099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: /cVbmfyjHlzwqJCT0zrriKc8hctX9DaG88BA6Do4GhOtGC5DlB6XdGXmvjg9rCMgn1tJurIAQzPn7R+SQBgwnjKAz1CvECES5oV4FLs4D3JU2h52SMZkhrKDVwdSDLIalbDOZAGGcf16hQT5rizS8UzYMewGDbrQ3xgzzUUr74HjsxBVDLrjCTW3vSKb1Zn7CyRLDGQhwRz/Nl/g5XVyUhFtaKM6peZCWqmlzokIpyjzLIbwx7V/BGcdXOInLDz8WExSiulZXyA84SZ2dnWSqi3569RDGp4tEHhXH+xCCpQ59OoHyOMi6W0YgpUYDCSBRMizUyH9xITBmvjoBqsp6EJFnj56bFN7sKXZtZYmReLN9EVYU1e6k2wEzzCNoGtBjA6rCb+BUMXix3iCTRTcTXUcgvXwebFAKROfzU+dHlCOAPvfN9D9NJog+3dXhoT89+tff5fQ+xnAyBCJ0sWA0qQM9UNGOsbMPSUa0qHXL4b+R3Vj0x08rblfrE1Tj409j4jtAxIDWspYxTUfwHf+fx+YMJkniP99NBFXNdtHVgISyqIWpoZiTJY2A2+tyqh0TDtcchd8rev8WWMp7/QXMsIyQa8q7cd+6+pX4o1iJbs7O2JAp7RhcT7N00MckwnR0XaijJj0yI5KSOdwI3JhMl8BztjYqnpHcNXzADsk/ZArcDHgUMzSKwkmnYUuOKwRGJZllmd4bFLmyyVqohDM/g==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(261021121427099003)(56012099006)(261021135927099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J33mGStf10+4UqelhM0DIedFvjVAZY/pqRJvpmgpIZ4Su78mT4TZmEQc+JQpWz+dI19R921YMhjCRN16Cb96MqGXuhA9BU4iixsH/SUMz+TK7ZvbuCgZMjIpWetaIqhHv3/ynNbszJA1D76s1T6IzfCYZHUqnYDCQXjiZ1fQXZSPrdi1imGtXQCu2XzPwf8ky8XoHQ0b0a9+wpBwPEIZOs5mTGI+NmzofZrePjceyLSnOaM3mnLEBTJSCl2pCYsUaMBwvuYyKtLSIl7m+JVmhu2reii2MhSd3RsR2ADVXAogDUrTCEDlKvp6iYSHxR28rsjxL8iZ4f0XblackYFf2jmoDprcG+MM3B1Zg76smotjWWkUX0SBM6xUlQqTsf81d0mXYXSwVdUlfrBRwHC2BNeINLeYgGK29RvnwqkdyP2F0Lo8T8I4yR4qy5mPkBrg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:48:08.6228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d85389-ee5e-4665-d671-08df3e78da22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
but it was only added to the uapi headers in Linux 4.20. The build
fails on distributions shipping older kernel headers, like RHEL 8
(kernel-headers 4.18.0):

  rte_eth_af_packet.c:1057:41: error: 'PACKET_IGNORE_OUTGOING'
    undeclared (first use in this function)

DPDK requires Linux 5.4, so the driver does not need to support older
kernels. Check for the symbol at configure time and skip the driver
when the headers lack it, instead of failing the whole build.

Fixes: 3db7aa7868b2 ("net/af_packet: use kernel to filter single-queue Rx")

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
v2:
- Drop the fallback define and the runtime fallback to PMD filtering.
- Skip the driver in meson when linux/if_packet.h lacks the symbol,
  so the problem is reported at build time (Stephen).

 doc/guides/nics/af_packet.rst     | 2 ++
 drivers/net/af_packet/meson.build | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 6282f1e18b..44da26854d 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -72,6 +72,8 @@ Prerequisites
 This is a Linux-specific PMD, thus the following prerequisites apply:
 
 *  A Linux Kernel;
+*  Kernel headers defining ``PACKET_IGNORE_OUTGOING`` (Linux 4.20 or later),
+   otherwise the PMD is not built;
 *  A Kernel bound interface to attach to (e.g. a tap interface).
 
 Set up an af_packet interface
diff --git a/drivers/net/af_packet/meson.build b/drivers/net/af_packet/meson.build
index f45e4491d4..ce4737010a 100644
--- a/drivers/net/af_packet/meson.build
+++ b/drivers/net/af_packet/meson.build
@@ -4,6 +4,14 @@
 if not is_linux
     build = false
     reason = 'only supported on Linux'
+    subdir_done()
 endif
+
+if not cc.has_header_symbol('linux/if_packet.h', 'PACKET_IGNORE_OUTGOING')
+    build = false
+    reason = 'missing symbol "PACKET_IGNORE_OUTGOING" in "linux/if_packet.h"'
+    subdir_done()
+endif
+
 sources = files('rte_eth_af_packet.c')
 require_iova_in_mbuf = false
-- 
2.34.1

