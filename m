Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470EEC021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B2A84067C;
	Thu, 20 Feb 2025 23:04:17 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2276F40653
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:15 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2235.outbound.protection.outlook.com [104.47.11.235]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBy2dnisL3zvYsBP5IB93/z/gLZtz/8BS7Sv1HHTVnDko4QLCj+E4Z8u6F9+3ZjnSKR4DOhtfP401hDCYWjIWZAsDvNpkHbauKMWHglfz3Z9RNJ0X9/7GmeY4hEnqJ7x8c3K/rYCG4r2dYSzbaSx8SIXv0TE1ZCaJaDcP4NgUe2eDCD/yRjIb3cOdINEP7HTrQfPhX2uRvl6XaBq6PjIbykO8EEyEKRGZHWDAUwctmUsyLn7jw5TxTbWe1iZTC9lOAqbuawU9QV/H8UTo5eMuFXYE4mhB8OYD2d9pwRc4MB0QoTpVPeNxwcGgDMCGh2YUqLah+OrZN2XtFqMvdyOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VitO+ckScTA9eLn5aXQp9np+uaSsunI25KKycKW5Avs=;
 b=KG++8Y8T+NNl6pjYk0U0HlUnxNGR9k3eeArwg2I0iw/LxbYbEyFEdnUnNILRdq3R7JcWUxOQrjhs3p/yP8kf+HKds67yeRfRA7/vhNfhWy7Fuv1l0TJzjWOMHeRjhJzY1s9o9onn/no38RbltVFA3z8b1FHF0VZ+PdFnJUUkGAzvq5BWAww3duV5wbRnm914VBu9w71ZlhC+SZAQtuWj+Z4tVGxBS6/yhpFAV7HqtkvVdS4dd4W6sCtkosS+XViblRvJQWRJCQrYyMFXIDLAwoauzlSGMZTOCkHkI18yQEOlW0bkWXDf8Lwyxh26a9OftDkWz0aC1lmdQgIjrz2mBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VitO+ckScTA9eLn5aXQp9np+uaSsunI25KKycKW5Avs=;
 b=NdbLVbJmT5TmAbQrP8Rf/8lJuN152072YnzLwegUdpo6NyHin4XyB2YFA2PTuzwvVRT90FuXzLOkDjUHDyBeOfGQMDRpKC3P6trVigrAgBSOqauLVq2n76cDoKmbia5C+KD6xFHsbY2MIEwSOWtPsWcHoAqRpTwysgJNboe538k=
Received: from CWLP265CA0498.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::12)
 by PA2P190MB2131.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:424::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:12 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::c0) by CWLP265CA0498.outlook.office365.com
 (2603:10a6:400:18b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:12 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 01/32] net/ntnic: add link agx 100g
Date: Thu, 20 Feb 2025 23:03:25 +0100
Message-ID: <20250220220406.3925597-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PA2P190MB2131:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed553f50-a886-425f-239a-08dd51fa8242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SZ4Tp+PZYgJa6hNN2EvTnRcDwifbHW+Ec9aeKtoRctAqFvT40aK3tVTgituA?=
 =?us-ascii?Q?+nBwFl4tii0nEb9x/ALwVsahIogm7v62g0TPgKfaEuEJz7X2muMsR0yNTUWM?=
 =?us-ascii?Q?Da+HBKv/c/iIBcRpdx1UxEI6nfjGbsc36MMNPIhjHnN3Ac+LL+udJYhT2j18?=
 =?us-ascii?Q?1a+bGiS57NbQxOfotuYUV3ce5JR7WngxyV4EnDTgnpvcKxgvqifWZ295s1YU?=
 =?us-ascii?Q?bjYIjwbT4ww13Xgcrbd1G5TkrYrblILhPHocPCU7Ym9pdtrRVS7SbuWBBKqy?=
 =?us-ascii?Q?8kcQzgKzLpsYrdCLgYhlG8F/PR9rsaZ+FxrOuDhUTnHP2YZVVJT83MeOVRWq?=
 =?us-ascii?Q?93CuD7mYtTTsdmmzwXN10QPgvvHIOD/6fmoG/J2Uy/2EFzDkadCyypaYB9PF?=
 =?us-ascii?Q?Ygbq+YW6+sWAEf75hRum89/42xVsP098BqhZ4H1OBwR94paERXRA7biyctrD?=
 =?us-ascii?Q?3V2Os8RBFTBBB4+wmB01FgGB5b0uPHTmd+1oQ22gh5LqUdgNfh7zPnqn0Oas?=
 =?us-ascii?Q?Qj0J350Ox6oLG6nGbl9HAjkofyvKCt8ivtnzTrtcn8yidsOjfunXxoRrQulZ?=
 =?us-ascii?Q?J+InR4Aqk+2eju37zP/RNVK7fA4WY0QmB77s99Myckap6LCnBKPDPkhgEQSC?=
 =?us-ascii?Q?LWkSM9Kmi6zQ1FRFMASfJ1eJyFpi0IXpU+B9jegd1nhtzHwZHuxaKPRT/KCi?=
 =?us-ascii?Q?dRLjrmjs/OFQ7bfzG8vBpIqLKf5oOv4vHXzcgyUSet2/cLZ49Nn5hNyyt1Pk?=
 =?us-ascii?Q?VnaMVh+Hijn/gEYxzJqkYEl8/p+2lAb0c9RdSEFxM9K0tSsSnN8Xqs6Skt0q?=
 =?us-ascii?Q?7tDYnpOZKscyBmMAJWEUqWleNf5T0SEy6sNLg/6XoAhsaMNzAz5plpEWpq5S?=
 =?us-ascii?Q?IdXQMLsra9l4uIo8dOi812tkStzeZ92wtQdNK2nRIVCH2lU+nG/7Mon7N1li?=
 =?us-ascii?Q?PWlUTDH5WWOX1A/F9CZhb5NSMY06nCYbPZipfYi7fIF/NW4dwIt/z1Tm1XSy?=
 =?us-ascii?Q?r715SG3F41eAF4sEaKHHHZPGR0m0HuAuGP1BsNC2+UsCCqdu0WsDiQD2uHAK?=
 =?us-ascii?Q?v7ixFZogt3wxieRWbiMeT913LB9VAo4apr+eKOk8iQCvfpvl+87rSrTFiEJg?=
 =?us-ascii?Q?4RJTnfkCMi6qjtg3bOGoSoYEceDxxOqLBuMNKJOjb9HzyDUCQCowV4STgSU8?=
 =?us-ascii?Q?YrcOdJiBoSxk1ewD7fUOtz5OaZa1wKsrl8ze932YSi0uHXwXRqQfS34z65b2?=
 =?us-ascii?Q?6zyocrMpw6B4STfHVymPNiybhPT0lHw7b3/8RlZnw60yTJf5rf1GEK2rOYnw?=
 =?us-ascii?Q?Wzxh0h1CVoC2HDWQZtkq6r+n12L1PzAqPsksgnGWma9nss7SWhXJMgoGy7ON?=
 =?us-ascii?Q?ErOEiWorL/sjb1IpxMoPeDR5yvygkLEK2+TBGOupjBLpZOR6HW/V5Avz4q5L?=
 =?us-ascii?Q?leKZF3Q8ldUc4tvdec9JUoHex3VftJler8xw5gjBvzJ8cEDKKV6qLmIW5YTu?=
 =?us-ascii?Q?lhYq1XmFg8+WIik=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fL++f6lu7xuc/gWszjeVYX3LoQQ9rH11LOri133IyOI8iQbP+kSq609qYCdV3/yFlIsu7ushwjt6pbnNTrKADoSrD9UqcmbRcdb1ocnlG2UnlqxDP+a4Up6OHIpv1eQ31eufx7GH8+DKllT58bXGosgdFkrnPWSeta5JRDfsTItoVYLzxf2pDmdVbRGvOldTdOZD2D7YVMSOcaXC3uJ3lK1zxj7elPaSVMkNLDx8QpKj51XAVvWFagUank2SJGiHR4ZmDpLIu++bnObfCNo3zk905in/Xsx+7jRBqLwafD89vqqaFpYZORCUdvyZlWk/N29ofIk0TzDBd7RoLqDpQqPybzqHV6IVPlxZpFL7YFzOlTAGyeHr8Y3EThH2wyWNb1INKCcksAGJXHvRms/DfhKNIrWwH+xphrmg3jVFi689aVZ+DkiVqnA9C6GEVyyv0dN0+SmR1suW6NBmOvH3kdoQbkAQWUG6jMkreRZro1N/2oDBuAOV65VSFb02EbwkhD2p8a+2zl9Hp0WHYQcimsBDKxmRdDSn8FBH8v8MlJUxdU1V3Rsm0ue53BnhV+mCBYra2+u0vfvIEGo89NbzHrwblxBp7sotiBQJFZnC0vBPRkbicNVC0w2WJmuIVs/2dYVZiQvmBQw5u3ONcbNReNxQflL51MegMNG5V976in8=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:12.3181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed553f50-a886-425f-239a-08dd51fa8242
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2131
X-BESS-ID: 1740089054-312005-29067-14084-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.235
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYmhpZAVgZQMMXAIjE1OcnC3N
 woKc3cKNHEwCTNwjLV3CAlMdXE0thMqTYWAJfa7jFBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-102.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 1.00 BSF_SC7_GK0121_1       META: Custom rule BSF_SC7_GK0121_1 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC7_GK0121_1
X-BESS-BRTS-Status: 1
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Minimal implementation for link agx 100g was added.
Add support for NT400D13 (Intel Agilex FPGA) link operations.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  9 ++++
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 42 +++++++++++++++++++
 drivers/net/ntnic/meson.build                 |  1 +
 drivers/net/ntnic/ntnic_mod_reg.c             | 17 ++++++++
 drivers/net/ntnic/ntnic_mod_reg.h             |  4 ++
 5 files changed, 73 insertions(+)
 create mode 100644 drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index fa72dfda8d..fe9d397293 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -196,6 +196,15 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 
 			res = link_ops->link_init(p_adapter_info, p_fpga);
 			break;
+		case 9574: /* NT400D13 (Intel Agilex FPGA) */
+			link_ops = get_agx_100g_link_ops();
+			if (link_ops == NULL) {
+				NT_LOG(ERR, NTNIC, "NT400D11 100G link module uninitialized");
+				res = -1;
+				break;
+			}
+			res = link_ops->link_init(p_adapter_info, p_fpga);
+			break;
 
 		default:
 			NT_LOG(ERR, NTNIC, "Unsupported FPGA product: %04d",
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
new file mode 100644
index 0000000000..ad3398500f
--- /dev/null
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -0,0 +1,42 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "nt_util.h"
+#include "ntlog.h"
+#include "i2c_nim.h"
+#include "nt4ga_adapter.h"
+
+#include <string.h>
+#include "ntnic_mod_reg.h"
+#include "nim_defines.h"
+
+static int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info,
+	nthw_fpga_t *fpga);
+
+/*
+ * Init AGX 100G link ops variables
+ */
+static struct link_ops_s link_agx_100g_ops = {
+	.link_init = nt4ga_agx_link_100g_ports_init,
+};
+
+void link_agx_100g_init(void)
+{
+	register_agx_100g_link_ops(&link_agx_100g_ops);
+}
+
+/*
+ * Initialize all ports
+ * The driver calls this function during initialization (of the driver).
+ */
+int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_fpga_t *fpga)
+{
+	(void)fpga;
+	int res = 0;
+
+	NT_LOG(DBG, NTNIC, "%s: Initializing ports", p_adapter_info->mp_adapter_id_str);
+
+	return res;
+}
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 8ae6817dea..7e4f47b1e6 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -32,6 +32,7 @@ sources = files(
         'adapter/nt4ga_stat/nt4ga_stat.c',
         'dbsconfig/ntnic_dbsconfig.c',
         'link_mgmt/link_100g/nt4ga_link_100g.c',
+        'link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c',
         'link_mgmt/nt4ga_link.c',
         'nim/i2c_nim.c',
         'ntnic_filter/ntnic_filter.c',
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 658fac72c0..598df08fb7 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -69,6 +69,23 @@ const struct link_ops_s *get_100g_link_ops(void)
 	return link_100g_ops;
 }
 
+/*
+ *
+ */
+static struct link_ops_s *link_agx_100g_ops;
+
+void register_agx_100g_link_ops(struct link_ops_s *ops)
+{
+	link_agx_100g_ops = ops;
+}
+
+const struct link_ops_s *get_agx_100g_link_ops(void)
+{
+	if (link_agx_100g_ops == NULL)
+		link_agx_100g_init();
+	return link_agx_100g_ops;
+}
+
 static const struct port_ops *port_ops;
 
 void register_port_ops(const struct port_ops *ops)
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index bddae823c8..3e84beaa62 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -144,6 +144,10 @@ void register_100g_link_ops(struct link_ops_s *ops);
 const struct link_ops_s *get_100g_link_ops(void);
 void link_100g_init(void);
 
+void register_agx_100g_link_ops(struct link_ops_s *ops);
+const struct link_ops_s *get_agx_100g_link_ops(void);
+void link_agx_100g_init(void);
+
 struct port_ops {
 	bool (*get_nim_present)(struct adapter_info_s *p, int port);
 
-- 
2.45.0

