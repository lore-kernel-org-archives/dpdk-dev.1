Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C5606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Zx3Q5qgV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3949441153;
	Wed, 11 Nov 2026 08:11:19 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 704114026D;
 Wed, 11 Nov 2026 08:11:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aABctNsNYr5gIL8JK1zGSrYP/kvxUlokePfwuZ6UbtyIbnrm6p82t9CN2PtzGURXiwmNIu/56w9iS+6F3YPG7GN2ecoVLO5m/9X3I+I0BD0twcFz/7x5OjhkEWwjV89BUuXvAnH7cEixuvZNRrOAmsCzrSvzQrr1Z9g1Gv8q9lVY394SZZgYhfAdgAZiAwrOxqP0ptbQ+ZRQfVzOjm5tpRo/yG7pnNI2euZ8I4V481yTUdOQAkNWN/XEvEnkKJtLpiIg5E2T66s3VUEQmYRd6htcaT3bBo9S0AvxaqNLak+9U6cgPSmkayHZyPM+saW0fSVJwTkfajoNkHaMBgdnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YysTIHWvkpIVHf7Cz1DkYRpM7si3D90qfas9h6AqxJk=;
 b=GcGqOup1RLDLmNlr0MqQXvCJhyB66LqO0OVguxa3ZdwPhfWKOCmEbN3ZyXxm1eS71cSwWcEdYrchuUegVMX4Y6O3hXV7z5eSivk7w4AQ8Xf6VtoXACKb2W5ZLsfmgyCKl4q/5qqs3BPIYsfBNccrFbWkcQrv8Pl1R2mzvtNlzppoomic2U+JJjQcTbP2Q5MXoA8B44gBi+5HWOwZjKDHsc6e6Qno6IXoDMFR3KF5NHactah+a19eWjEqRWCpyRb+TPCmkEG/nZsjQfw7v8aFE27oUVkbcF+1jl3VgVyUr98tmgeJMIN+MDpBjpCh5N7L3K+3xtWKARIHJPXZWFzRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YysTIHWvkpIVHf7Cz1DkYRpM7si3D90qfas9h6AqxJk=;
 b=Zx3Q5qgVoSIAmzyXNtZv+NSQWr+tRIK2BAYYN0DP86WsPYS/BLF5Q9GaJw9ISPhZrPsG/us4Zbo719zhWx+Tv5PK2jfMUZDLgDUeMxwkP1VDPRdN54EUFPUsPpBqn0nRXzp3JkHFNiNw1H63RdBKn9Nfx+58unnhku+ZMTKUZYY=
Received: from CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:06 +0000
Received: from BL2PEPF000352D5.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::1) by CH2PR03CA0026.outlook.office365.com
 (2603:10b6:610:59::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D5.mail.protection.outlook.com (10.167.254.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:03 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:11 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 03/16] raw/ntb: fix memory window bound in address remapping
Date: Wed, 11 Nov 2026 12:36:37 +0530
Message-ID: <d9e1e7fe33ae0b6bfdc79db728a67d20e9289e7e.1794377833.git.raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794377833.git.raghavendra.ningoji@amd.com>
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
 <cover.1794377833.git.raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D5:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: f91ea260-15ab-475c-5747-08df3fc2f3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006|261009223027099003|261102123227099003|261021121427099003|261021123027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2U3xa8ZCDT2AIZFgAvj/N1xyQHNl73Wl9iLZwFVd9SnfSyKcPSHFZYHNAj5FZWLXKILdeoStCiuzFx/sg1zP0tAIpoLbXykFx57Wz+kD8rGJ+nzjk+g24X8P7G2BhMGhs93H5oPS66Om+HiPSODYj60zGTBybk+bAXUAcIigtVxwD+PXOkaiq1TaYIYYj1/ZVHMXAyL27hOG6DGsrzdcVcePouyivXQZHuQmZoVuQWfs9YwdjDZOriAl0XN5rW41fKgZxAFRmZKlh3o+Zw1tdV/ONkcjEfy1g4gvAR6BcUJs4LANV4nVmUXyeggNbBtLMeahKgueIfeUYFBjImMuieApILe4w/zuZpHJtFdoj4J2XvibfuQCnwYR2tp4mxdjt9fwo261hCxxFDGieJTGsdjGEIanDpDfM5FFfjWxcDeU69YK6snda/d2oJgOV/rvh4NnRxWNZ5Jjkpa+uHCmYvi1pgjvciofiw38f9KIJdp1SdZzrzLw4K2qmVmEU+DfxAOxPO9u5x1ZHr+Ov4NruQi6CuV5WHeBfCplMxCzPmbMROHXkqjUwBi4z5oL/JhJmM/Tte0tACcmSW1IyKQPTeIv+HtF02s+qdktDhjpU08agSiraC1QIJMyqBjYD/NhUk/zJigfS8skm2OmkbKi9cVGrcJIJQSUrwlBTiCbOeHlbG2AExxhUcsuItErUaWZ69ke1gk2a3N3tQ4pWArVRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pQxdOQzzVrVuOoR7dLEg1K/7dgyI7vd8Iq9ZHCpNnhMXdEvFYAHrVzY77w7KiRQYze3UQ5QSN8XSjMdFbrZWPX7U1qlbDVW2k4gJoQaT7dOkln4QreJZ3fDA+ECK6kMcEFshxhy8tuqpQbw6GOv6YZelejWHHZyrI+r6j8pNRclTk0J5K2LVHPNdqbGe4lg7C0K3aTR479g59nVX1GY72k7+jUu4nZXTNbgw6Cfcp192AIACKICun0JAmyLaBs1tJYakyBBhcidnSYCn5k626YTkTRYTOzANPSRKjh/jUP0TwiW/Q4zRBrgMWCvIXs1pS8Pryb7G1NSGSQYNgjEP27tLwo6ZwY7q3dF8bVZkmEW9E6jxpfpTiDtfXBu4m6ds2oPw4Ai0KOqNex9M0iB8tMOkMZIIXIihYgz/M8y+w+cCl15ELcxoG2NAIHdrU2px
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:05.5785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91ea260-15ab-475c-5747-08df3fc2f3ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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

When translating a peer address into the local mapping of a memory
window, the end of the window was included in the accepted range,
so an address one byte past the window was mapped.

Exclude the end of the window.

Fixes: 11b5c7daf019 ("raw/ntb: add enqueue and dequeue functions")
Fixes: d6dc5a7f8b06 ("raw/ntb: support AMD NTB")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb_hw_amd.c   | 2 +-
 drivers/raw/ntb/ntb_hw_intel.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
index dba5b03671..64075501c2 100644
--- a/drivers/raw/ntb/ntb_hw_amd.c
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -166,7 +166,7 @@ amd_ntb_ioremap(const struct rte_rawdev *dev, uint64_t addr)
 
 	for (i = 0; i < ntb->peer_used_mws; i++) {
 		if (addr >= ntb->peer_mw_base[i] &&
-				addr <= ntb->peer_mw_base[i] + ntb->mw_size[i]) {
+				addr < ntb->peer_mw_base[i] + ntb->mw_size[i]) {
 			base = amd_ntb_get_peer_mw_addr(dev, i);
 			mapped = (void *)(size_t)(addr - ntb->peer_mw_base[i] + (size_t)base);
 			break;
diff --git a/drivers/raw/ntb/ntb_hw_intel.c b/drivers/raw/ntb/ntb_hw_intel.c
index 78fce9ffac..47d5d39339 100644
--- a/drivers/raw/ntb/ntb_hw_intel.c
+++ b/drivers/raw/ntb/ntb_hw_intel.c
@@ -312,7 +312,7 @@ intel_ntb_ioremap(const struct rte_rawdev *dev, uint64_t addr)
 
 	for (i = 0; i < hw->peer_used_mws; i++) {
 		if (addr >= hw->peer_mw_base[i] &&
-		    addr <= hw->peer_mw_base[i] + hw->mw_size[i]) {
+		    addr < hw->peer_mw_base[i] + hw->mw_size[i]) {
 			base = intel_ntb_get_peer_mw_addr(dev, i);
 			mapped = (void *)(size_t)(addr - hw->peer_mw_base[i] +
 				 (size_t)base);
-- 
2.34.1

