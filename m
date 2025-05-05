Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A6C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:14:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B331640B8F;
	Mon,  5 May 2025 09:13:45 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id AF6BE40A4B
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:41 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 mx-outbound40-227.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2pF0mJSoR0HA8Tc16OdNXpmfG8lRwnY4Dc2LEhEVakEyGoPeWuzedBbXRrKgK3l9/7gpmbJ+vkpVT2XDthQVWPwGvUYIlTGV/nNOalGXStkyGeiTmcicUmpgKyMGk99pC0aW7FrbqSYoHyITodEGr9mdAuMDu7jkwtkFZnPZKC45lISfFY3loqFPQYk5E/aWo8qorDuZ7SmXJ61vn8iW12E1Y1O1T3nb/SlYW7uQtpXalu2mMMv5999U4I4gZhCSWu3fBqhg4wYL06quoLS9E2Kcul80GDyRv4Rgr4spynsCQeXbEzcja71sqCDB6gRphlp8+da/P1Vbca4JlIJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M7irrNyPk8sM29G30JkGltyVYS3zUIVvxZ9n7vuzos=;
 b=ZcC+/+7Vgy12RlGXU3p8wzKsyfNA9n2mD4KBT8ZlNzRgtuH82592V2M4kv5Emb/oDORHeXbI9id+xHED5scEBgbLHgFJBtfT+5bqgOHUtrT8bBp1WkeuI4mmoVAi/EphO3vtFA0aQoTg9sui3DezhAkRyPxwmEhjlPxH3hXxCFEChG1OrHLJO8NzZzLUmQ1MRF9yeqjUytjttZUdyngom3hKwyp/1tpZLetQtadJK2nC6vyAw60Vw2W+8zwGNcE7Tij4MBwbC8pPOJ3vK3uvKs6GDvPKUChOjoR+G4TeYTqAEpriKcfPkSx1GPaBKe1U7LDSIP3mnAqsmLKDrV9lQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M7irrNyPk8sM29G30JkGltyVYS3zUIVvxZ9n7vuzos=;
 b=GQKJVHig9YTzFGZjLAyi2jJveeL0L5sAYNIFb5j2RuMIizxWmaUpynAGahnmJcSgPPWvNPaoQcP2l2/d95CJ9ogdVK2z/bi0AbaAAmmRoSsaQUArXQcdCRYfNZfKhqDDQJeXBQoSOS3TLSOkpKUbRbnbS1WMBjSHa5J3QqusBbw=
Received: from DU7P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::29)
 by AS4P190MB1853.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:504::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:21 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::2e) by DU7P191CA0027.outlook.office365.com
 (2603:10a6:10:54e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:21
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 12/26] net/ntnic: remove usless part of conditional
 expression
Date: Mon,  5 May 2025 09:12:52 +0200
Message-ID: <20250505071309.586015-13-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AS4P190MB1853:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 261a404b-0237-41b3-e4d1-08dd8ba45167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dt8bfnQh/VKnJ85vGYHdmGdRhZMsD3D4fZhln+rv+hnHH2lNpu+QQhvdA/Nd?=
 =?us-ascii?Q?Poa6LEjLUz1KkL7hiMMzLlhq4p9eHrtb3HF7o+nuowpKdlBULHWQ5k8zAqDe?=
 =?us-ascii?Q?DhYCdlyE3fYuRUEaM5EMVCMlACzJKSnlqv/qLbHXyySlkUwTF1H/GCE3Vq9a?=
 =?us-ascii?Q?BfyIDInJ4W6OS57j0+DYgZMrkw701LTwIW5IhO4JAwtLU4VQegUDDJ1AqtC2?=
 =?us-ascii?Q?pPgqIQWxjKvKx+nDoj1YfK3GV9VGwxwKLH0AEnZIi0ZNi/fMJ0Iy/sXbvTkz?=
 =?us-ascii?Q?hrr7g5f3R+sBxTG6YAm8CJoIqDFiHMUzFMtt33dw5DWaCpJ94bHmgLNIT7pw?=
 =?us-ascii?Q?+mmYyTQV+YIELNHLeJ9n4YLKtTpgZHwZFE6pIHQhywCSOUTmMZKxm2oST1cu?=
 =?us-ascii?Q?qrK+bqqtRGtu+J04dmpRQXk1nU0jz6HiyyyLE+jDiBXXsIKP5W4VK9HeS6Uq?=
 =?us-ascii?Q?hRB4G3XGLXFs3GejbB7JBb9YMl0eKJH5qVT+//lB/MryH2HjW9GYFX8C3We1?=
 =?us-ascii?Q?MuwK1oVutMOIw9RgmVfvIz+O1nSsNsy/ZAWIe54BTB5hNO1dxVeWFwsQF3pJ?=
 =?us-ascii?Q?qMokRX6aQ0ZO8NbvhqJNDX3wib0znXFqT7++U1rYt+jAVi/AkPoPnxAXqgnq?=
 =?us-ascii?Q?gdL22J+KWBjUVzj06i8XhIAvFgzEvvOQXHNpdq1Kn0bq0QiQZKn4ORmfsERc?=
 =?us-ascii?Q?95CT79+Zbrr4zCopVfl7riFQWShJoUyq44n9vFd5WK057t9xIW46yDQTJLez?=
 =?us-ascii?Q?8zyyyuixFwcts0+cMECctQ8FITlbzZqOpmzrGYzro9T/ewf9GNiIK+Bo9C+y?=
 =?us-ascii?Q?5MQoq5E0YhPHrddb424GhkFQqphNcz+nKsEazBdLKEwsqMxv2pmL57BDtdbA?=
 =?us-ascii?Q?dnHcY8j0boTWEZaCV2kfOKMp2escrwjUPwhrVQ+x+hjyEBgSkYqntqvof204?=
 =?us-ascii?Q?kvVTCztCiL0UTbSYWZeypJkrAm8TNMKI+8Houkr+jVLmfI+EvqKayp51CmSz?=
 =?us-ascii?Q?CZhRAI2x0LVAGw9Dm1xFvKfiHIykv21jz0s2XBwzczNrBESjD8aWGTX5jX28?=
 =?us-ascii?Q?Hd9IzKyocjgZYvqxJIlmIOAy35qeI+F7Vlut2rQ/pQrG2n2sUM2/gZiTgNHk?=
 =?us-ascii?Q?3hfqLEWkR6UHWQiFtnbpdjy/kT1tr4I+TOJ1vUTQ7Iwq3aLYqqiRKQj65quL?=
 =?us-ascii?Q?uvT2KgZmj5NcDeITa4sVdQloM5e6d3hogSAjHPxLQrQLXIJ5+mrxArEK/JYz?=
 =?us-ascii?Q?AdyuyG2HsM/za8Bmir+p8n9OsbUBub/yixO/F3K6bwplloWYZE4n7Oq4zn+p?=
 =?us-ascii?Q?Qdl61MRLFTJEPo3HvSJGRx3RbOpqP1PWuGCdIiGZGY8xuGmYO7DeYaxv9Hw8?=
 =?us-ascii?Q?HNuDZo7nkt/nRe60hukARY0RkJAa8wgozmEH2m0UxW/Hz3zgqEpZTFoRPaku?=
 =?us-ascii?Q?D9ol/IPyIC3Z6KUyHyIP2ZaJWCU7cWi5GLGVbrFcwvI21Bf715iloTb0maUz?=
 =?us-ascii?Q?8QkmEYyZ18YmpKG8mL4PO8LVzcbzykcpbUBE?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uWmL2KROwlloCUifRBQ0+YVsPdY4Gk6rh1cFAOCnzUq/3kkzAO/mK4fGzS+cCkDTJ1hXxRU9Vgy5LloMX6o+SV/QYEk26T2n8pBtXjiMPl3CXo8xHFg7UcFWwjmsY1lxfp3vr7LbO2zE1lryad0WfyANSCWnkNSL5mD+aVFmxEHQxl+CrDUcpLMOcHy5lQR9F9Z8SFNnvJdNQTPyxvlFFIuHSbSohp9ijE3u2ml3CvAahlkhQ/8nL+Wgywu2B5h3z9cApmNYryr3ROcO3frNpFhBnY5dhjJQzkBk9RQMQyxfimC0BpN/zSJbGBt6Ozjn37OoxiYqjtiQsmU/KyFvBqX455tXgg7YpRyc7KeyFBNx1hsvCiFdIjJv1m3OG6kO0cuJhZbTEAs/Hax9HwWGTRf/McFdGpd/8Iq9TfLUaFN7VxSQaufhAjff3VcM5VvnUH7X9MCI7rqLWLA1kySXQkFpOaho86u+1wxIJOSciSpGyZ9luVxiZuN4LJl50IZ6gtXWzAKHl0uaU/cpc4CFBPJir2awdNPNXwuQtWpGUVqDO0lHrSbzQmYobZ2KGezadb9HUHvYPNSRoMSe4o6zw8MihNCBxVULOTBm1DSDKdMIub6ocIWGTWe4vyAUzBq+DsFqhFCQX/6IZytYY68yeg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:21.1228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 261a404b-0237-41b3-e4d1-08dd8ba45167
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1853
X-BESS-ID: 1746429203-310467-11485-4617-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.18.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmluZAVgZQ0CQtxdzSIMkk0d
 Ak1dTY2DIp2czQLCXZNNEy0dzCMM1YqTYWALAjywhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan16-232.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

The conditional expressions that always has unchanging state was removed

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c | 2 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c                 | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index dde185c62f..43b3c5a41f 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -672,7 +672,7 @@ static int nt4ga_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nth
 	 */
 	RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
 
-	if (res == 0 && !p_adapter_info->nt4ga_link.variables_initialized) {
+	if (!p_adapter_info->nt4ga_link.variables_initialized) {
 		nthw_mac_pcs_t *mac_pcs = p_adapter_info->nt4ga_link.u.var100g.mac_pcs100g;
 		nim_i2c_ctx_t *nim_ctx = p_adapter_info->nt4ga_link.u.var100g.nim_ctx;
 		nthw_gpio_phy_t *gpio_phy = p_adapter_info->nt4ga_link.u.var100g.gpio_phy;
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 485e912912..47f4b4e7b1 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -550,10 +550,8 @@ int nthw_fpga_shutdown(struct fpga_info_s *p_fpga_info)
 {
 	int res = -1;
 
-	if (p_fpga_info) {
-		if (p_fpga_info && p_fpga_info->mp_nthw_rac)
+		if (p_fpga_info->mp_nthw_rac)
 			res = nthw_rac_rab_reset(p_fpga_info->mp_nthw_rac);
-	}
 
 	return res;
 }
-- 
2.47.1

