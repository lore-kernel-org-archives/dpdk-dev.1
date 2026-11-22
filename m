Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D880606A32C
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X+j3DpdB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7A14402CC;
	Sun, 22 Nov 2026 16:46:35 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by mails.dpdk.org (Postfix) with ESMTPS id E695A402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 16:46:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAnd+7NMj3V43WvbHXIohvkhqxUBQ73TXzmDPra3updsKOzMr6jvjazfmXNDVyUmkyL9eesDhEiGN/b6cywlaELcBi1kL3E9PpuBq/CKQPwjZ/rdl6FRzG0wMWmIcillQ3Dq2EcSpxpWZD21u5KnZZI3jwpJ0hO0bw0nY7sie1gN9+UEg2MQI9s7bufsFlrCQRyCmDEfmWVV/DI4G7XAWoJmTHxCgyKAKenbwi1nchqQDmw7Mq+TaEdcnn8PsRoFx6hTOemTO6TOawyaheSTov9WrL80UvZ2blsa59U5xiUg4pvSNdcI0h5YsmqByl5X3iO/AU5Np7nv/RpBQZV9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmSmRjevCNuuRaGr18JMLwBV5WE9WT3km5a9DyCx8Tg=;
 b=KWOquyeWYhJCgudsouwNb9Qxj/2wuTzeQZQB9kf/AWvR81YYLAhFKbYTLUikC7Oo1vrscmAnaKvDe7LKnZhBi57CLmOg0AnSjqRxmYrpBl00BPI+0Ryz5YYS3bCv5lBbK6uTGwOUgasH+NajUCKVfVIoetVk9cZcAwLkXlfasq7+yNCOCzGI5jeZ/7A0L4zupB3LFPXgScCzaEiWMs6hdUIGtyMkQr7zJ3CjFTr8xulAMt3KlLE15Q7ZWIdKbLcosEwIfLNFIZvH1UPl5jrIJvttCOpozNXoJvjd6YZSKzCqknbdsjtBAhQBnOKF8fnsMNg0tyzGf9lvcbZFvIkdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmSmRjevCNuuRaGr18JMLwBV5WE9WT3km5a9DyCx8Tg=;
 b=X+j3DpdBrSqLlp3HvXGdAltm7jRq8u7DQ69X341fZmF8h1CeuFi2MAFpQsrHwpcbsC6dGKLJXHg+OJv8z0+fS/CVYTEQtcSGzSqTjJ7Mg1G2wuQ1I9LFMFs2IcOxLPbCneDG8swVlINeJyoPt37GZPvyDhnHlgF84j70lSrGZCo9unEoY85r5KmEOYyT0ctxqCWICL4yVfJm0z55RAGuM5fvXdv+OuD+HdS/Fl+DnbjDT56jdbsRS96PScUILqkHHB6B3pcLdcrKXXuIIvMQKXjScbwjWzc5+ULTTbrJxOBJjnM4UP1SyfZ7Wgl5HncfheHswAVj3VCXbr2iA4JD4Q==
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Sun, 22 Nov
 2026 15:46:17 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::6f) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Sun,
 22 Nov 2026 15:46:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Sun, 22 Nov 2026 15:46:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 07:46:06 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 07:46:04 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Sun, 22 Nov 2026 17:45:49 +0200
Message-ID: <20261122154549.48329-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: bed3f171-2739-45fa-df41-08df48afbed3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261026121527099003|261021121427099003|261021135927099003|261102123227099003|11063799006|56012099006|10067099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 1UibHconHoD35rG5e++gp4pUk3NsqmFETMVfTrdT6z0fW7CitPr3oUL8jb9m1W04rFpEMXHG1l744DsqAE1MDwmMfot1RFCjCO1IbJkGNgZ8nxBsgm9gaz9eX62gFJrofzZTOWEU/oky+9cg5JG2jaLveReBP4bKUYMmbQFmfrfj/GRx3GM9eeP0t2D38IuCdKSWjjt9MqLap+fwdWwaos6mw7iDPtq1W7CVmpfDcl2G6MOf0lVegMhYkkyGQs80F15L9C9wLOv43vMSdGMZkcprD5eq7lYui1FIWQjAgXCsX/Ruqe77+kPyB2iuSgddiJ+tyeqLxPFIocrZLwxC0vrQSHywdoPb0Y51f5YQK5SwCrG8LkpF5Eo0DyElhiB/cNwcgNZJab9SwYmOOJ6bK6+aGv+xIZgzUkQJAGDsHoOS6jc3b4iJ/aMeFTLcSxqqzMPQ6tu5FWvJ/joADh0hfTLmXWV/9i7lnXkfqsWWcfyS2fOx7tdvSSASZRCAN/um6FSjuGZTJC8AcdTtxOXtsNyNmcFR0aLyn1pIGeYBwIf2gByQNtAn0iXOmOhMYOs3bCxjTS4bmDwbBewmeU/PwbaMz7BPO2c7rXE1JMxz/tlQxoP0MKlDla0Jq5F9ezFoYw+XgYtTgZQSdGy2EcCzekVcWmZBUDjJUOEQQSi44kzusDGFwZhIpU7BTUAyRfGkcTV3VH79tBcayhSC3n+nkg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261026121527099003)(261021121427099003)(261021135927099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oCj8n+5EDgd7YbECR9msGxBoaILNjUijzMA2bacMrNtpnhB3LKdX0XK+tDbJBMNsmQVNEQhlE8I+/etf0YJsOVBDGHYw4XD3MibZJH6j7jEpuissnpz13z679Ufx7QLwiNYIag5SeSb1vgiVI2r8P5Ztd64RNSGJN+HfXt91AhoycPFyiDlnrOyTouvDSU/TSz6iSo+XomgmgQaAH5XBgmvF9qhgRJOtkm+RDzFWdrF2n99PtBqzoWSA/5NX302ZigvFVNH1yWoBOzTWwJ6KpEErJrSIBmAqrUBAr/cryOvJo80B2u846cGvyjn2sN2HfPz27H+jT+wHCVFnUfESQSZqf6NJIxycTY9mIJ1Q0hRk1st3XxTkaPp+MzuADeD7d+nu5qnseKbuDbXnU9FB+SrtlTaPHxcM2ev7Y7MdXZEzB19EDGonhec9JyReSPa2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 15:46:16.7593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed3f171-2739-45fa-df41-08df48afbed3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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

Add tested platforms with NVIDIA NICs to the 26.11 release notes.

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 doc/guides/rel_notes/release_26_11.rst | 118 +++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d3ab3662dd..ca8b2e7e78 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -758,3 +758,121 @@ Tested Platforms
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+
+* Intel\ |reg| platforms with NVIDIA\ |reg| NICs combinations
+
+  * CPU:
+
+    * Intel\ |reg| Xeon\ |reg| Gold 6154 CPU @ 3.00GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2697A v4 @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2697 v3 @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2680 v2 @ 2.80GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2670 0 @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2650 v4 @ 2.20GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2650 v3 @ 2.30GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2640 @ 2.50GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2650 0 @ 2.00GHz
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2620 v4 @ 2.10GHz
+
+  * OS:
+
+    * Red Hat Enterprise Linux release 9.2 (Plow)
+    * Red Hat Enterprise Linux release 9.1 (Plow)
+    * Red Hat Enterprise Linux release 8.6 (Ootpa)
+    * Ubuntu 24.04
+    * Ubuntu 22.04
+    * SUSE Enterprise Linux 15 SP4
+
+  * DOCA:
+
+    * DOCA 3.6.0-069000 and above.
+
+  * upstream kernel:
+
+    * Linux 6.18.0 and above
+
+  * rdma-core:
+
+    * rdma-core-60.0 and above
+
+  * NICs
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 100G MCX623106AN-CDAT (2x100G)
+
+      * Host interface: PCI Express 4.0 x16
+      * Device ID: 15b3:101d
+      * Firmware version: 22.51.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
+
+      * Host interface: PCI Express 4.0 x8
+      * Device ID: 15b3:101f
+      * Firmware version: 26.51.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.51.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-8 SuperNIC 400G  MT4131 - 900-9X81Q-00CN-STA (2x400G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1023
+      * Firmware version: 40.51.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-9 SuperNIC 800G  MT4133 - 900-9X91E-00EB-STA_Ax (1x800G)
+
+      * Host interface: PCI Express 6.0 x16
+      * Device ID: 15b3:1025
+      * Firmware version: 82.51.1000 and above
+
+* NVIDIA\ |reg| BlueField\ |reg| SmartNIC
+
+  * NVIDIA\ |reg| BlueField\ |reg|-2 SmartNIC MT41686 - MBF2H332A-AEEOT_A1 (2x25G)
+
+    * Host interface: PCI Express 3.0 x16
+    * Device ID: 15b3:a2d6
+    * Firmware version: 24.51.1000 and above
+
+  * NVIDIA\ |reg| BlueField\ |reg|-3 P-Series DPU MT41692 - 900-9D3B6-00CV-AAB (2x200G)
+
+    * Host interface: PCI Express 5.0 x16
+    * Device ID: 15b3:a2dc
+    * Firmware version: 32.51.1000 and above
+
+  * Embedded software:
+
+    * Ubuntu 24.04
+    * MLNX_OFED 26.10-0.59.1
+    * DOCA 3.6.0-069000
+    * bf-bundle-3.6.0-85_26.10_ubuntu-24.04
+    * DPDK application running on ARM cores
+
+* IBM Power 9 platforms with NVIDIA\ |reg| NICs combinations
+
+  * CPU:
+
+    * POWER9 2.2 (pvr 004e 1202)
+
+  * OS:
+
+    * Ubuntu 24.04
+
+  * NICs:
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx 100G MCX623106AN-CDAT (2x100G)
+
+      * Host interface: PCI Express 4.0 x16
+      * Device ID: 15b3:101d
+      * Firmware version: 22.51.1000 and above
+
+    * NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
+
+      * Host interface: PCI Express 5.0 x16
+      * Device ID: 15b3:1021
+      * Firmware version: 28.51.1000 and above
+
+  * DOCA:
+
+    * DOCA 3.6.0-069000 and above
-- 
2.55.0

