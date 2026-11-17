Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5717606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tGBDG7+A
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 764CF402BD;
	Wed, 18 Nov 2026 10:20:03 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013036.outbound.protection.outlook.com
 [40.107.201.36])
 by mails.dpdk.org (Postfix) with ESMTPS id C70BC40041
 for <dev@dpdk.org>; Tue, 17 Nov 2026 10:48:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0EbFrTTo1TT+RN+Gv7Dd4G60mpPyaTYpkmicOImNhDdHghVsmGyYeswzvofecoaocCS8efsKRej5ii2L/mJGdqCKi98STcwuJwVis3zpd3Ntunvem6iziQqV7C56VWvG2SX86Djz8lWpqsYayAkjoDYGVu7G6xPDEYVmK9h9Mu2Glt8V73leo0iJnpXEMOyay5VLkFdGX8hwzp6D1G1pyDrQewl58So6Qb0tN8blemgowp/JAEoWqQaCSlvtM0l9VBo0mloQ8FukjmEkX0wxKQ6b9RWQwYpWl4BxnC40leP5XFnyeSuPKgHuL7Y1v9LPNP2BqPs/bAAAgaNehUi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyNMPTm+6rbjzntynxuODAjFCmIapxPYo4Zx+8tiAlc=;
 b=M1z1+eU7XB5Qrj/H1Y7xpuJFLxVTjfzlMltw5KjbG3F4jO+Zj2SiHuHenkOetZmj+/EZm6bcA+rM+/8f2zlbjkFODjHIN6Rz03sceBezq2zamycE1CAmIhzZ/s/bCZhoMEdeOTj7JtRS0OcB4o2ighu+e+TcBUshjyGBw8DA6AcfUEiyCTUvFWhc5MXnq/kL+z9Sujto2Nnj5otxQ2WgjBtFBZm+LdynuW2+Tjb3AY/eUu886EcUembtX75hwn2ElgQvjmsxfwRnkYm/bJYb3W/MldSqHFlwjdRNkCng9wU9kgZTAIxm9Uqg2q4mKt/QDCGhm4MBkwkUng85qP/TAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyNMPTm+6rbjzntynxuODAjFCmIapxPYo4Zx+8tiAlc=;
 b=tGBDG7+AYX4IluDxYs/2IcGYIfHi2+hsPXiCg5gf/Y0rSaYu/2u5aomL3jln8Q07Y6oZd94ErHyqvIm9R67PIcoKTjvSj6M+YWf16EwwYySfYcu11YmqQUroIA0bVWRTE7/cGeEBciMT+PgsB0h8rPFsOqauVcTNsxpN6wN1tR4=
Received: from SJ0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:a03:2c0::22)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 09:48:22 +0000
Received: from BY1PEPF00026969.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3b) by SJ0PR13CA0017.outlook.office365.com
 (2603:10b6:a03:2c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Tue, 17
 Nov 2026 09:48:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026969.mail.protection.outlook.com (10.167.244.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 09:48:21 +0000
Received: from cae.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 03:48:20 -0600
From: Ajit Kumar <Ajit.Kumar@amd.com>
To: <dev@dpdk.org>
Subject: [PATCH v2] net/axgbe: serialize PHY and link status access
Date: Tue, 17 Nov 2026 15:18:05 +0530
Message-ID: <20261117094805.4134371-1-Ajit.Kumar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112135611.2757325-1-Ajit.Kumar@amd.com>
References: <20261112135611.2757325-1-Ajit.Kumar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026969:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: b60bc42a-4cb3-4b78-9980-08df448fead4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|261022105027099003|261026130827099003|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261021130227099003|261021135927099003|261102123227099003|261026140227099003|261009223027099003|261026121527099003|261022075727099003|261022113327099003|261022115727099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: cTOSFAj0xEUiqKDfaPyibxaYKDm73yBeme5Qeaqi96csSw9I0aOhxxzV1llgtoN6AIhOLfp3pnsT+TxZShG2wejZrJfseEoBzR/wpYXzQzUgqtsesMxv8AXHQze3Uf3TGTZSRubzT+4hOQAjlVzxhmhtF2UrhST7Z81y2QiUkG8dK24RnlhvEFlsLBtml/6M3g9TeaB1VHH5DFaoqoZ/d/20a5pPKxKgux3RkQKuCKtTgHE3z6/lRMFc374ib4nHXWFsIU3Q3q9LXyxc6kDt2aUH8/P0ttvPpFPyJnNTh13Akw8bVZwBBKPJp4dDyY7iPv37dzE+TK4OFFpsLb4MI46Qxz1mHoVnEnVQpvFo+8HrFjBx26u6r9zdBbSxUcAvU+pzuoLvEBuCyNG5X1DxjNP0A3odJgtuk6tkv8rBzt2NBFImjIgBQyoerLaHAgJS/13M7vk/nlLMkRpOFHSoZAKvqsZ3ARXi17T9y3HlIfQLhIXL8UnzcDT9koOyjqKZIT1J3HSr+3M3TVmujKHwi08DQhbarVnxJzHuERPYpUD+s8S95tKV3cdraO+audkJmgex4cIp5Gy3iuQsE6vQwcbjps3HbD1liUBNaj8piaI/dLb2JzeFcJQondTfv//M3KnfkYHyv5TYq+Xtuf+9xlpbzBzYPTNbvPmr2uGs6wRnEMGrWTDfgQYBg1tP7b+lYRxhASpCkwc08bx3g8hmGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(261022105027099003)(261026130827099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261021130227099003)(261021135927099003)(261102123227099003)(261026140227099003)(261009223027099003)(261026121527099003)(261022075727099003)(261022113327099003)(261022115727099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pq5WV1y0jDj7AyYjXqj/TK0dh55qGid8GW2w/CRwyu9bKwQLoi61wY+wU7XjUIg/1dYLfNWQnlMdN2DRs30TyYjDdu9cFMbo8LvFk6t2nSQb0KAYzw+Vrpz9keV7QvnRJkQ6DoYFYPz3lTGgr4U4743pht7NQBdxHV8d2DouCZLdNKXATb+iik66xo5T8BOt05PmyvnXB0hB78pUC9mGIkwbQOm4yG900Ns1MZyVEJLIkHwHFow8jxBYHFN8Nqh5F1wYRKHLh0ahjiaSMTHfHeXN7vUVAHnC/LnRfa6ok1cMMoTDFtN5HFjQED2xbY8jzaG4JXKZtaTVnZEHIsRsDrnf6jBGaMoTrjIk8YIQRKNo9xEb0veL0tZ4MTaaCxt9kCm11AUiHp6mPMI6KuPYgIp8g1rNJuPWhWg7kf6n6S7Q76lK3/b98v35xOx3Apz5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:48:21.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60bc42a-4cb3-4b78-9980-08df448fead4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026969.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Mailman-Approved-At: Wed, 18 Nov 2026 10:20:02 +0100
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

From: Ajit Kumar <ajit.kumar@amd.com>

The I2C and MDIO buses are shared by all ports on the device.
axgbe_phy_get_comm_ownership() takes the per-port phy_mutex, which
does not stop two ports in the same process from using the bus at
once, causing I2C failures (-EAGAIN, -ENOTCONN, -ETIMEDOUT) and
incorrect link status reporting.

Add a driver-wide mutex taken before the per-port one, as the Linux
xgbe driver does (xgbe_phy_comm_lock), which this DPDK PMD lost when
its equivalent global lock became the per-port pdata->phy_mutex.

This fix applies to ports owned by a single process. If ports of the
same device are ever split across separate processes, or one port
stays with the kernel xgbe driver, the hardware mutex registers
remain the only arbitration between them; this is a pre-existing
limitation, not something this patch changes.

v2: dropped the per-port link_status_mutex and the retry-on-
-ENOTCONN/-ETIMEDOUT change from v1, per review (Stephen Hemminger):
 - link_status_mutex only covered axgbe_dev_link_update() and not
   axgbe_dev_interrupt_handler()'s AN ISR, which touches the same PHY/
   link state without it, so it was incomplete protection for a race
   that was never actually observed or validated, while the real,
   validated cross-port race is already fully handled by the bus
   mutex below. Removed, along with the struct member and its init.
 - -ENOTCONN is an address NAK (IC_TX_ABRT_7B_ADDR_NOACK), not a bus-
   contention symptom, and axgbe_i2c_xfer() already waits up to 1s
   before returning -ETIMEDOUT, so retrying either while holding this
   new driver-wide mutex can block every other port's link_update
   behind it. Reverted axgbe_phy_i2c_read() to the existing -EAGAIN-
   only retry; a separate fix for a different, non-contention I2C
   failure mode will follow as its own patch with its own
   justification and hardware validation.

Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
Cc: stable@dpdk.org

Signed-off-by: Ajit Kumar <ajit.kumar@amd.com>
---
 drivers/net/axgbe/axgbe_phy_impl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 4abf5fdea9..55d45bfb7b 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -605,9 +605,30 @@ static int axgbe_phy_sfp_get_mux(struct axgbe_port *pdata)
 	return axgbe_phy_i2c_xfer(pdata, &i2c_op);
 }
 
+/*
+ * The I2C and MDIO buses are shared by all ports on the device.
+ * axgbe_phy_get_comm_ownership() takes the per-port phy_mutex, which
+ * does not stop two ports in the same process from using the bus at
+ * once, causing I2C failures and wrong link status reporting.
+ *
+ * Add a single, driver-wide mutex, taken before the per-port one and
+ * before the hardware XP_I2C_MUTEX/XP_MDIO_MUTEX acquire sequence, so
+ * that only one port in this process is ever inside that sequence at
+ * a time. This matches xgbe_phy_comm_lock in the Linux xgbe driver,
+ * which this DPDK PMD lost when its equivalent global lock became the
+ * per-port pdata->phy_mutex.
+ *
+ * This only arbitrates ports owned by this process. If ports of the
+ * same device are split across separate processes, or one port stays
+ * with the kernel xgbe driver, the hardware mutex registers remain
+ * the only arbitration between them.
+ */
+static pthread_mutex_t axgbe_i2c_mdio_bus_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 static void axgbe_phy_put_comm_ownership(struct axgbe_port *pdata)
 {
 	pthread_mutex_unlock(&pdata->phy_mutex);
+	pthread_mutex_unlock(&axgbe_i2c_mdio_bus_mutex);
 }
 
 static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata)
@@ -616,6 +637,8 @@ static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata)
 	uint64_t timeout;
 	unsigned int mutex_id;
 
+	pthread_mutex_lock(&axgbe_i2c_mdio_bus_mutex);
+
 	/* The I2C and MDIO/GPIO bus is multiplexed between multiple devices,
 	 * the driver needs to take the software mutex and then the hardware
 	 * mutexes before being able to use the busses.
@@ -648,6 +671,7 @@ static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata)
 	}
 
 	pthread_mutex_unlock(&pdata->phy_mutex);
+	pthread_mutex_unlock(&axgbe_i2c_mdio_bus_mutex);
 
 	PMD_DRV_LOG_LINE(ERR, "unable to obtain hardware mutexes");
 
-- 
2.43.0

