Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3007C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:58:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2100640647;
	Mon, 30 Jun 2025 11:58:31 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
 by mails.dpdk.org (Postfix) with ESMTP id 2629840609
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:58:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqQ6YH0LcjdnZUxtRwbjz6uJ06UxkDf27RBMol+x40Yii+gfTlCRvZE0GrldL6sVtCWt5KIfNpkhsDvhD5FZmjdaY6HVS0EIyKUsZqSqbrK9n4LT4m7qE3xCud//Gie+lh4qO5dZwmogdRWyN2ZEwa9cNXaHYJ/5nIkIf8fzuwNMZHlBhF/SzHhsTKD6BDiKJErsCX+N4d7sKwrTJrj12PdbFDwcvyjO8UIGR33/sXO/uuQ2TC/iBlaIo4ZnV5VlSIMVUlicmbcQcfTTpR9ZbGHbTI9V8WSbzsJVK0vyxA21v2SqHhrbHOou4yWRKkz4sAswpvcxTydulOfOnZyodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+WrzGkCl6tmw5vjM0kfDyFlyp9Xt/YRLmCmSvDRt6Q=;
 b=oiCW8dnw0/+RX3l9kxHIzZ++GNIjA1S8C2mPLwJpJjTaRiMtSkc0RJhu0hQSYuyETv09bmx/RFJYRG+VVaSCJD+Phbu62jAHOFDGxlCwr1vVWtGLhv9AZ9C2rrfEImMo4PcmfRsrJPPocqR5RTDSttURJBy8FKzYP3KxrWVhCphFnGg4Q5ai6FkUHCM/aReU2E9OjHDvBzNNYx8qYVnnoXybZX4IqRq+UtEoRwxM0xPMHI+cSGvJ6xz9aGQLYBE1e1T47qqDtLqBYMeVs/OuEQaeqz/UGF5EWyhTvrloWPthiyRJxqsik2Q2t6qdFfDKlADNtJLjY+Ynvo4O+hKI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+WrzGkCl6tmw5vjM0kfDyFlyp9Xt/YRLmCmSvDRt6Q=;
 b=hX17VOwr5OuQ5XTIUItat9dT81omj5ftl8ZTShLHuRdKmqux0RtLmHSdPme9Ziskk8IjF0c9hfUgtf3HU0ees/5CcqtPIO4Qu8EIDNgj/TiLmLfHXsuHSBP1PeOXNP+rWPzev9i7VO9N5s/BLdh/ZKjFjVjxg/LaWGj3y3zyykOAyK2YIVayBDUsFMcegNbk7/iotJWhJvZCU9oqAXSjqNgoMzRkFX1ncTtxQqx0ACbIGni/1Cm8VU8zIF1IffiS5UXB+BdxZz1kf0ZQhhb08mm9u7QlQTr5Wc8e10JhzkrW5U6JezA5h5o3WRAl+EZZi2h/zxBsnTM+TX5u9iGkgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 09:58:21 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 09:58:21 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v6 3/6] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Date: Mon, 30 Jun 2025 15:27:57 +0530
Message-Id: <20250630095800.2943863-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630095800.2943863-1-g.singh@nxp.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
 <20250630095800.2943863-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7613d3-cd91-4f2e-b06e-08ddb7bca560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fQOn9eiKPIiHJI3URc0HqsslEsUL8Ho8zujyGNV6ssHG5UcM5HsdFgEgWsjo?=
 =?us-ascii?Q?75zjR112YZIP2y8i842egrbvrd82pGgwrM4eIzh5woLwYQyOdktTD62ZdYTw?=
 =?us-ascii?Q?iizjTaI2iw4iXrh9sezSjod2QTAxpP8J357gVpSQ3EK/QxMsCf5T68eO0r7T?=
 =?us-ascii?Q?84WfEjbFLRSE+8qQi8uynuWetBlTVH1+/qM1PZV14Q5I3Inb/DxDMHikFOm0?=
 =?us-ascii?Q?Ed4/OkChytAQ8qWe007IeApkooBcVyYphK8lA/wniAu81vHDHMFmoWG1/3w4?=
 =?us-ascii?Q?iTZFOhuNNpsb8UgayGIXe8NEgkl8Ti0+tp3vLdWomtqmMI/QkoNl3HWctdNX?=
 =?us-ascii?Q?Bu4KDYMUf/SIvs6yRF7veyNTHcjBTuL2NR7FNYhq8gxj1trz05FNdAL5eDAY?=
 =?us-ascii?Q?Y8gv/+Z9G3VoJF8g6TXHxdtvbgUehTCm/CzjUPunUzwHfLO87pFwjeT8yEDf?=
 =?us-ascii?Q?1yCpgV5Db1b3kVwyRo6LviuQqCELpcECfhPKQaJu7PZHyOiKL2+xYEH1Fnn6?=
 =?us-ascii?Q?1u3+sELTJOPwRgvwTXI4YE2S1Ui+nDqXJYcPjl0k+1ZUIKkVhwNV8ArjXuS9?=
 =?us-ascii?Q?iDqjcYxFfalWEaQsu0iAvWN0TnS3d/iQspon70VPF10Pxcdq7l3e3U6xVZTJ?=
 =?us-ascii?Q?8aF0uPHC7r+sR0Si2LdvMM1JHkelRNYNg8HMmN0UgYTEfMd41b7I9z+B+MHX?=
 =?us-ascii?Q?L/0kJwLP/jlukcfuF2kkayZK5EJdCib8BBt3281LqdHWVrlfKH4g6TcGf3xV?=
 =?us-ascii?Q?JJ62yyhxFQzJ4Osm76h4GVpV1t87gG8gjRoHIOJ+NW3LKaOaAOyatEt+UcON?=
 =?us-ascii?Q?yu6gtpsJXBEJ+VZDlezfL64dnhQhHQocoWusLkYbeQhW6feYlb+8nFB/JbX0?=
 =?us-ascii?Q?hsHmdbsAfpuwngnAK0XUcazSW4UnYk4LYqfGtJqnEh64PCmdRCmExbAkVIth?=
 =?us-ascii?Q?RpP1zthJJ/V/E5i1f1eFqeWsWZakrzRTQjjusieyg/lnpsvn8PgvZDXdTUVN?=
 =?us-ascii?Q?gTa1CGN+Q+lulhnPrPIi/YNSycvsNr70wK5UcXsSIFKv9uHDv2WWuv7Mjsn5?=
 =?us-ascii?Q?Mi9Ffas1X3O5M7EBHdZgOmE5ohb6jh7i8UVa6ctbthCkCTFPJHUzP/hfpb8q?=
 =?us-ascii?Q?w9RCtRIIC0PUNJS+421obamkMIz77EsIxUwcQI3Cwnza4Dlggu6LSa8HBTkT?=
 =?us-ascii?Q?F7gY8QIEVs8OMjBw5dhunnVk4IowT2Wk8wL7pKdB4yHofsMDUHRWs5x536Np?=
 =?us-ascii?Q?P8jYopU37pka0MzAvhyMrKMj2qG0ygs3lnEX2ntRXsJe0lgE1lx7K76f5jGM?=
 =?us-ascii?Q?jDQNZL4NQPF1osZiJX9uNlmY4VrVnmcPGnMWK78pwTdLzXXbynUI/ycgtG/Y?=
 =?us-ascii?Q?xOKcBwDlqNalbYAjkkveU4B4ZXm4KdKqcofwsVOFHSKfcltbOvCuvfUN4rZ8?=
 =?us-ascii?Q?42b3eWCH8T8N740a2ni9z+Z/7zhPksqKgYvYArRL498Fs5H7NAlUMawI75cL?=
 =?us-ascii?Q?xZebFKRjMhFnGi0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3mnmmHE9gvrNrGHm/bshTqlieIMqklxwC1i/QTkW65abEdfWevfIc4qBHmB?=
 =?us-ascii?Q?3OGohVWGsuMm+vXs3BK1fOT5luIKdc1rT3C+iGIOMMoGt2GUUT0+vV7UjIwC?=
 =?us-ascii?Q?kF5K6+ZWLWlqZgPxBjJAi4PIWVXhX2mOYYfXwE8pxnmeUZkM4Xava3+q14hw?=
 =?us-ascii?Q?sOBWUbyTsCBKAQUzie4YOnCazgCYak/rOHFaU4b8ZjMfgdk67S+yxrFcan9+?=
 =?us-ascii?Q?5JvBoenyAxYNXEqP+Ho0BL8dpoT3wtEEGJCeC5xbwh6nLGWrYy1akVwzJ2Dd?=
 =?us-ascii?Q?AeKOdL5mpIjsidRkN9Uf8Lgr3o9VTJ3c2dwwtxBp0CyqG3d5a3d7wPMY5J0n?=
 =?us-ascii?Q?nSdu6FvH+cS5JczggCmRR+jY3/2fNIbKIsjy6uR13f6ReNa4M1A1b2RE/ONN?=
 =?us-ascii?Q?08KtaSTVgZvT+PZLFDTZx6259ZyJ5jGboaSG6bse2v1dnQ61fPA+taAlbtVM?=
 =?us-ascii?Q?p7jKC/4KUppntX49NYr+RCh1PyJkqL8bOPvS+if7+RI8nSupk04maPQ34rv3?=
 =?us-ascii?Q?qu0nzhCt5aUIBz7pKjiQWOEaVyVDOb2Orvq8AO1tZwS+UQq8aggwTy31V9sm?=
 =?us-ascii?Q?xp0MOXu2AzuwketllyfM/0ZgHIbbiDNCFE4Omh5nliur914wjUHT4YmfE5ep?=
 =?us-ascii?Q?J3QexEUKFTSeiY4/4C12nUHOhOxY/wCWOVGE3oYtMc4YhckcHFU2xoAwYNPL?=
 =?us-ascii?Q?ZszjUvBS01oos3WDZWE3k4orQD8N0gzNey06VEiOuulBsrbKV4PSyY8M78RJ?=
 =?us-ascii?Q?XJdrqddzEjTyBrSabTR3SMMDTNW3nC9mG+kBdvk3+2F+aBS9n8t3yJRLyqWs?=
 =?us-ascii?Q?EGvyNimOpvhaI/yqgqH6NIPU8MpYPtn255L9kQRcgfifWga/YbscN+V+eucf?=
 =?us-ascii?Q?U4OtsebZ38Pgaxi75tqzJhlJqa2S2wXdsZ4UiAIKKR8YX9kcFwQgfS3uvGRj?=
 =?us-ascii?Q?TtFneLM+kthukfsX6DlWcisK2HpQn5XKebhRllZDEyXFTeJEPdJQKg+L6zXe?=
 =?us-ascii?Q?bcbeU6UpcBOv4+YqxU4uhFfKVfiM4in5X/vwqRz4vyPSeTjhmXQOFa4IJp37?=
 =?us-ascii?Q?VVMQl9AhHBdKYuKTfyhh4nZ2+ktA7ImEiMW1h34pqlEFBIJgrEfTqXjI+mUx?=
 =?us-ascii?Q?4EYxe638V0MzGvpgV/Z40wbmkJ5oidrsClNr7qp/lJXwJRV28tKUffjt7HJZ?=
 =?us-ascii?Q?S61XJ7Y31j5p7+ZhrM00L6Do0vv69r13jwZ/Uk75NdKaZ4GY21Aea3nABkNa?=
 =?us-ascii?Q?gCGktUBudkyE24gPq6P36zO3Exb0avGKs8N2U8NcpF/kf+Zso2m43/LPgBpd?=
 =?us-ascii?Q?pDXPX1hrQ7ecw+Exi9SarWbhtcrGMNHSssXsVmNLfKOc2Ime9yh2eX/cxFqA?=
 =?us-ascii?Q?okZUolmrXz4EGJNfDnH4cVliQvijexOhebhZ2YyDs82TUriAxPNS/K1erC2A?=
 =?us-ascii?Q?iNhFGFJiM9dbcVOtnUcB77qCTQ6Tvb7AC2LYduCwSkg7uMWpjKKhUUgCA04h?=
 =?us-ascii?Q?cJEf8iskeWEgLq2ExsdBPIzWKF1ZqPYvYFo5scmzMwMY2My3KVzxdkXMILh5?=
 =?us-ascii?Q?zUN97vN7IQbF+zKMEZw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7613d3-cd91-4f2e-b06e-08ddb7bca560
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:58:21.6323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+sDtfOy9paB7BG1m9v3ljIBmvl+7U0cqwhkfyZhTmLhd/0uMU3/pDNNMrmCiXj0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

This patch adds DPBP APIs for setting and getting the depletion/surplus
thresholds for controlling pause frame generation.

By default, depletion_entry is set as 128 by MC. This API would help user
configure the buffer in depletion state as per requirement.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 doc/guides/platform/dpaa2.rst             |  2 +-
 doc/guides/rel_notes/release_25_07.rst    |  3 +
 drivers/bus/fslmc/mc/dpbp.c               | 78 ++++++++++++++++++++++-
 drivers/bus/fslmc/mc/fsl_dpbp.h           | 41 +++++++++++-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 26 ++++++++
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |  1 +
 drivers/mempool/dpaa2/rte_dpaa2_mempool.h | 12 ++++
 drivers/net/dpaa2/dpaa2_ethdev.c          | 39 +++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h          |  1 +
 9 files changed, 197 insertions(+), 6 deletions(-)

diff --git a/doc/guides/platform/dpaa2.rst b/doc/guides/platform/dpaa2.rst
index c9ec21334f..e32ba5d300 100644
--- a/doc/guides/platform/dpaa2.rst
+++ b/doc/guides/platform/dpaa2.rst
@@ -106,7 +106,7 @@ separately:
 Currently supported by DPDK:
 
 - NXP SDK **LSDK 21.08++**.
-- MC Firmware version **10.37.0** and higher.
+- MC Firmware version **10.39.0** and higher.
 - Supported architectures:  **arm64 LE**.
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index b75405edf6..53a1c8756d 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -160,6 +160,9 @@ New Features
   (including out-of-tree nodes).
   This minimizes footprint of node specific mbuf dynamic field.
 
+* **Updated DPAA2 ethernet driver.**
+
+  * Added DPBP APIs for setting mempool depletion thresholds.
 
 Removed Items
 -------------
diff --git a/drivers/bus/fslmc/mc/dpbp.c b/drivers/bus/fslmc/mc/dpbp.c
index 08f24d33e8..5529a1fe9c 100644
--- a/drivers/bus/fslmc/mc/dpbp.c
+++ b/drivers/bus/fslmc/mc/dpbp.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2017 NXP
+ * Copyright 2016-2017, 2025 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -362,3 +362,79 @@ int dpbp_get_num_free_bufs(struct fsl_mc_io *mc_io,
 
 	return 0;
 }
+
+/**
+ * dpbp_set_notifications() - Set notifications towards software
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPBP object
+ * @cfg:	notifications configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_set_notifications)
+int dpbp_set_notifications(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags,
+	uint16_t token,
+	struct dpbp_notification_cfg *cfg)
+{
+	struct dpbp_cmd_set_notifications *cmd_params;
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPBP_CMDID_SET_NOTIFICATIONS,
+			cmd_flags, token);
+	cmd_params = (struct dpbp_cmd_set_notifications *)cmd.params;
+	cmd_params->depletion_entry = cpu_to_le32(cfg->depletion_entry);
+	cmd_params->depletion_exit = cpu_to_le32(cfg->depletion_exit);
+	cmd_params->surplus_entry = cpu_to_le32(cfg->surplus_entry);
+	cmd_params->surplus_exit = cpu_to_le32(cfg->surplus_exit);
+	cmd_params->options = cpu_to_le32(cfg->options);
+	cmd_params->message_ctx = cpu_to_le64(cfg->message_ctx);
+	cmd_params->message_iova = cpu_to_le64(cfg->message_iova);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpbp_get_notifications() - Get the notifications configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPBP object
+ * @cfg:	notifications configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_notifications)
+int dpbp_get_notifications(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags,
+	uint16_t token,
+	struct dpbp_notification_cfg *cfg)
+{
+	struct dpbp_rsp_get_notifications *rsp_params;
+	struct mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPBP_CMDID_GET_NOTIFICATIONS,
+			  cmd_flags,
+			  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpbp_rsp_get_notifications *)cmd.params;
+	cfg->depletion_entry = le32_to_cpu(rsp_params->depletion_entry);
+	cfg->depletion_exit = le32_to_cpu(rsp_params->depletion_exit);
+	cfg->surplus_entry = le32_to_cpu(rsp_params->surplus_entry);
+	cfg->surplus_exit = le32_to_cpu(rsp_params->surplus_exit);
+	cfg->options = le32_to_cpu(rsp_params->options);
+	cfg->message_ctx = le64_to_cpu(rsp_params->message_ctx);
+	cfg->message_iova = le64_to_cpu(rsp_params->message_iova);
+
+	return 0;
+}
diff --git a/drivers/bus/fslmc/mc/fsl_dpbp.h b/drivers/bus/fslmc/mc/fsl_dpbp.h
index 8a021f55f1..c79b511715 100644
--- a/drivers/bus/fslmc/mc/fsl_dpbp.h
+++ b/drivers/bus/fslmc/mc/fsl_dpbp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2017 NXP
+ * Copyright 2016-2017, 2025 NXP
  *
  */
 #ifndef __FSL_DPBP_H
@@ -16,6 +16,34 @@
 
 struct fsl_mc_io;
 
+/**
+ * struct dpbp_notification_cfg - Structure representing DPBP notifications
+ *	towards software
+ * @depletion_entry: below this threshold the pool is "depleted";
+ *	set it to '0' to disable it
+ * @depletion_exit: greater than or equal to this threshold the pool exit its
+ *	"depleted" state
+ * @surplus_entry: above this threshold the pool is in "surplus" state;
+ *	set it to '0' to disable it
+ * @surplus_exit: less than or equal to this threshold the pool exit its
+ *	"surplus" state
+ * @message_iova: MUST be given if either 'depletion_entry' or 'surplus_entry'
+ *	is not '0' (enable); I/O virtual address (must be in DMA-able memory),
+ *	must be 16B aligned.
+ * @message_ctx: The context that will be part of the BPSCN message and will
+ *	be written to 'message_iova'
+ * @options: Mask of available options; use 'DPBP_NOTIF_OPT_<X>' values
+ */
+struct dpbp_notification_cfg {
+	uint32_t depletion_entry;
+	uint32_t depletion_exit;
+	uint32_t surplus_entry;
+	uint32_t surplus_exit;
+	uint64_t message_iova;
+	uint64_t message_ctx;
+	uint32_t options;
+};
+
 __rte_internal
 int dpbp_open(struct fsl_mc_io *mc_io,
 	      uint32_t cmd_flags,
@@ -25,7 +53,18 @@ int dpbp_open(struct fsl_mc_io *mc_io,
 int dpbp_close(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token);
+__rte_internal
+int dpbp_set_notifications(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token,
+		struct dpbp_notification_cfg *cfg);
+__rte_internal
+int dpbp_get_notifications(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token,
+		struct dpbp_notification_cfg *cfg);
 
+#define DPBP_NOTIF_OPT_WRIOP               0x00010000
 /**
  * struct dpbp_cfg - Structure representing DPBP configuration
  * @options:	place holder
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index 118eb76db7..0ba40e751e 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -46,6 +46,32 @@ int rte_dpaa2_mpool_get_ops_idx(void)
 	return s_dpaa2_pool_ops_idx;
 }
 
+int
+rte_dpaa2_dpbp_set_notifications(struct rte_mempool *mp,
+					struct dpaa2_dpbp_cfg *dpbp_cfg)
+{
+	struct dpaa2_dpbp_dev *avail_dpbp;
+	struct dpaa2_bp_info *bpinfo;
+	struct dpaa2_bp_list *bp;
+	int ret;
+
+	bpinfo = mempool_to_bpinfo(mp);
+	bp = bpinfo->bp_list;
+
+	avail_dpbp = bp->buf_pool.dpbp_node;
+
+	ret = dpbp_set_notifications(&avail_dpbp->dpbp, CMD_PRI_LOW,
+					avail_dpbp->token,
+					(struct dpbp_notification_cfg *) dpbp_cfg);
+	if (ret) {
+		DPAA2_MEMPOOL_ERR("DPBP set notifications failure!");
+		return ret;
+	}
+	bp->dpbp_notification_enable = true;
+
+	return 0;
+}
+
 static int
 rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 {
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.h b/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
index 8b2718bfa1..47ad7efb6c 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
@@ -48,6 +48,7 @@ struct dpaa2_bp_list {
 	struct rte_mempool *mp; /**< DPDK RTE EAL pool reference */
 	int32_t dpaa2_ops_index; /**< Index into DPDK Mempool ops table */
 	struct buf_pool buf_pool;
+	bool dpbp_notification_enable;
 };
 
 struct dpaa2_bp_info {
diff --git a/drivers/mempool/dpaa2/rte_dpaa2_mempool.h b/drivers/mempool/dpaa2/rte_dpaa2_mempool.h
index 0286090b1b..c1cf160a21 100644
--- a/drivers/mempool/dpaa2/rte_dpaa2_mempool.h
+++ b/drivers/mempool/dpaa2/rte_dpaa2_mempool.h
@@ -19,6 +19,16 @@
 extern "C" {
 #endif
 
+struct dpaa2_dpbp_cfg {
+	uint32_t depletion_entry;
+	uint32_t depletion_exit;
+	uint32_t surplus_entry;
+	uint32_t surplus_exit;
+	uint64_t message_iova;
+	uint64_t message_ctx;
+	uint32_t options;
+};
+
 /**
  * Get BPID corresponding to the packet pool
  *
@@ -62,6 +72,8 @@ rte_dpaa2_mbuf_from_buf_addr(struct rte_mempool *mp, void *buf_addr);
 __rte_internal
 int rte_dpaa2_bpid_info_init(struct rte_mempool *mp);
 
+int rte_dpaa2_dpbp_set_notifications(struct rte_mempool *mp, struct dpaa2_dpbp_cfg *dpbp_cfg);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 1d11847d76..bf6d6fc418 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -745,6 +745,9 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q->nb_desc = UINT16_MAX;
 	dpaa2_q->offloads = rx_conf->offloads;
 
+	if (priv->bp_list->dpbp_notification_enable)
+		priv->enable_bp_flow_ctrl = true;
+
 	/*Get the flow id from given VQ id*/
 	flow_id = dpaa2_q->flow_id;
 	memset(&cfg, 0, sizeof(struct dpni_queue));
@@ -1176,7 +1179,7 @@ dpaa2_eth_setup_irqs(struct rte_eth_dev *dev, int enable)
 
 	return err;
 }
-
+static int dpaa2_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf);
 static int
 dpaa2_dev_start(struct rte_eth_dev *dev)
 {
@@ -1191,11 +1194,27 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	struct dpaa2_queue *dpaa2_q;
 	int ret, i;
 	struct rte_intr_handle *intr_handle;
+	struct rte_eth_fc_conf *fc_conf;
+
+	PMD_INIT_FUNC_TRACE();
 
 	dpaa2_dev = container_of(rdev, struct rte_dpaa2_device, device);
 	intr_handle = dpaa2_dev->intr_handle;
 
-	PMD_INIT_FUNC_TRACE();
+	if (priv->enable_bp_flow_ctrl) {
+		fc_conf = rte_zmalloc(NULL, sizeof(struct rte_eth_fc_conf),
+				RTE_CACHE_LINE_SIZE);
+		fc_conf->autoneg = 0;
+		fc_conf->mode = RTE_ETH_FC_FULL;
+
+		ret = dpaa2_flow_ctrl_set(dev, fc_conf);
+		if (ret) {
+			DPAA2_PMD_ERR("Unable to set flow ctrl");
+			return ret;
+		}
+		rte_free(fc_conf);
+	}
+
 	ret = dpni_enable(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
 		DPAA2_PMD_ERR("Failure in enabling dpni %d device: err=%d",
@@ -1298,6 +1317,7 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
 	struct rte_device *rdev = dev->device;
 	struct rte_intr_handle *intr_handle;
 	struct rte_dpaa2_device *dpaa2_dev;
+	struct rte_eth_fc_conf *fc_conf;
 	uint16_t i;
 
 	dpaa2_dev = container_of(rdev, struct rte_dpaa2_device, device);
@@ -1305,6 +1325,19 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (priv->enable_bp_flow_ctrl) {
+		fc_conf = rte_zmalloc(NULL, sizeof(struct rte_eth_fc_conf),
+			RTE_CACHE_LINE_SIZE);
+		fc_conf->mode = RTE_ETH_FC_NONE;
+
+		ret = dpaa2_flow_ctrl_set(dev, fc_conf);
+		if (ret) {
+			DPAA2_PMD_ERR("Unable to set flow ctrl");
+			return ret;
+		}
+		rte_free(fc_conf);
+	}
+
 	/* reset interrupt callback  */
 	if (intr_handle && rte_intr_fd_get(intr_handle) &&
 	    dev->data->dev_conf.intr_conf.lsc != 0) {
@@ -2110,7 +2143,7 @@ dpaa2_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	return ret;
 }
 
-static int
+int
 dpaa2_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 {
 	int ret = -EINVAL;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index b501fc091a..4e3e0338aa 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -413,6 +413,7 @@ struct dpaa2_dev_priv {
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
 
+	bool enable_bp_flow_ctrl;
 	uint8_t channel_inuse;
 	/* Stores correction offset for one step timestamping */
 	uint16_t ptp_correction_offset;
-- 
2.25.1

