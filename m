Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD07CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08A7440B91;
	Wed, 24 Sep 2025 16:42:10 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id AE3B840661
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:02 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023104.outbound.protection.outlook.com
 [52.101.83.104]) by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT26Y1vulbiLqTxiji1/nM6UuAkt7lFiyluu+rleSDQwgFL9zXG4t3QLf8cZFFubkqPOYvmzweq3iUA15k5hRMkyLddIEV0eWv/lvKH/vOEX7kK7jEocPyi72h+RsJtIZA+kutOplvNXXJUy6Xe5beTVIxF85aXQsbFzdt5xNOq7SlBN7atpcKzCW8U4NJLFm4GJbaGCZFMp4uuYZrz9ZQKYORqBXHuFfQJ9rfCA+MDbl9fw/ffIZexoqRgphsiX1ucDJB6mdwPhfm40I5oRG86EqCAc98MsofWSSiTsckycyxts3PpHEjoEMRH+NN40otmrVQuWWUamJNhsakmEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14cRZkGnqm8L2t1LOQAv3OHREwgft7+LW6B9HoMUPyU=;
 b=ROgxPOTsyMXh+dzPTkpaMQU+mgJHgqroT8IU2ihzgrQdyvBSKFqibVzncRFM+WbcKUOJQ6WiX4IKJi55twaK5l008BobnaNn1u7pqISIHJp90SompYb0d1h6y9SPNiNqf2GcaZi8nm4LM8oE9+gMj4E0iq1uuvmX4FeIaOeN54CxY1km++Ke3u7OfP9SU4m/bKsthUPe5EFt6vzlYH5qbQOMbe4qhFVE4L+5zYaHRopLgzd/FPOQTaYw9cDlo5OEyObNtlEnWr1vQhXVz3Zs0MPPcTsfgTGUxoPFSOhnumKPqyvTT8dWBSUrNic4B/HaA6IFZg2V8URq81sDq5cuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14cRZkGnqm8L2t1LOQAv3OHREwgft7+LW6B9HoMUPyU=;
 b=YwBGN7sf6t9VyQaRWMC+ZrNFhqPyEAoMeiIDgoEo9MaxwZpqc3YUn05tPIAPQq/d0jPM+PII80/O13+5tLym5BY6mh2rdvHueI7xWTG1nFJnrDTDj1ysfceeUmWDH+SkpDCKSeLrrI4xGyVTYZVU0DGM2Q4Z3RQ0lqwAAwbjgr0=
Received: from CWLP123CA0224.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::12)
 by GVXP190MB2595.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:2a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:41:57 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::93) by CWLP123CA0224.outlook.office365.com
 (2603:10a6:400:19f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 14:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:41:56
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 01/24] net/ntnic: introduce service API for NTNIC PMD
Date: Wed, 24 Sep 2025 16:41:24 +0200
Message-ID: <20250924144152.53203-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|GVXP190MB2595:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ed3dde0-e574-4109-dfa7-08ddfb788317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I7qZCBbNxwBQfEUS7+7lXaKG9OGnkz7DGIDbNVucIvtY2FUtzlmdbes52Xoo?=
 =?us-ascii?Q?hhuSTNHGVByKtcQy4JCfJjhUVzGMsmsz8KSDjMU17UWyO4SKi/jWSjOhFSEi?=
 =?us-ascii?Q?ZmpV4PGssz4Pe929AC69am6Vfp4vdx2apkI4LuZUC1pZf2YvRcWrVmZVWStf?=
 =?us-ascii?Q?5Db3Xe29bLgBhkr/OUNKrHwQwKVPZaLjDA3MeFDgOwPWXcdHgA8r8lJlUd4E?=
 =?us-ascii?Q?1hSSlXL4JDROKu6D+LNzdeKkQrpbDASJbhb+oEqQapYU0Tw1e9Va67mIWCOd?=
 =?us-ascii?Q?Dpqb5XLCNN0UMIPwrr/KgJaLiemMAslcW0bhFJ+NBB68YI1/llr+seDD1mbA?=
 =?us-ascii?Q?gBKK+ph5ujzw3v4onixDAArHTRpP20W6KMG+HEWg2KrAuM7uJjs/9qiriOOC?=
 =?us-ascii?Q?MuucM4MZu3hScPNq8crQomxGhZfmcBsMG/smESGaufPVgXeU5VtoECQBODGu?=
 =?us-ascii?Q?n5q2gbZ0g+GosKfO0IRwXNw7+c9vcsAjTcj/zKmd071RGcUKcDsikf6RtTM2?=
 =?us-ascii?Q?XX1mojj4pWaDFe1zrJNaDdP/I5PgZICnwxmI3onFXa8oKvBXcrfBEaZ0DeJC?=
 =?us-ascii?Q?vjIspXSmJiYlSPSLKx6Mk2GgR0syHxecC7zHlvKI2IJaWAd4szaUNc0GiKm0?=
 =?us-ascii?Q?mfJ5bKuSukOkD54ZC/s/Nzyh4WhHnaOJNoiVYKvQ2SH7OCY6pThw0sbwnVuc?=
 =?us-ascii?Q?N/VFMFeFQC1QQnBIbaQOgzg/GMh/GbwdxuxDkf71a/uY2y0FaKp20yaXSEH0?=
 =?us-ascii?Q?vZYF/2QnJhi3ZtLMLbQNBTA/Reve2e5E6fmLdu7vkkxliW3xdjd4OskjvbfW?=
 =?us-ascii?Q?0U17hlsZ6oHQSbuKjTDUc9BZQFgfLjO1tSA7+6TEvP5PxV3PzIY9x/2RWqhV?=
 =?us-ascii?Q?uHtU2+4/stYZp03cu8jNrgO4hJZ+5yDteK9XX+cXBMDOIAygtq2irYEMCLoN?=
 =?us-ascii?Q?419LpLx48qT/vlfDT2ZS3hTOwLOrsb34jweN1sgewj4upr2RaW/hqeEcZCbh?=
 =?us-ascii?Q?BOpSMTF/ZMGYDr01lbzQHhQ42OYUnLIlsxFHbIe0vfdeiqmVWPT+Ogr+BDPz?=
 =?us-ascii?Q?yLnzUkHrZ7LumMNXxZaPkPwRUMsG+dDAtTqldtv1a8GfK7FI8PYEeYWqYpxW?=
 =?us-ascii?Q?0j+uxrIzAapQB8W8ncawQf4J8I22X7tKfeHMIKwCiGJAU4JiuTfTyf1LVmSV?=
 =?us-ascii?Q?Yoj3abEWF3FsSfHrEhZZWtzJn8dJz0qqZ03Q09ER1l79hSwx9MlbQ7UDsABc?=
 =?us-ascii?Q?+qNoUKYFPHWhg8jhJk8g20xoRoJhKptq4ZyC4ivRcE9Oh1WXbOMe1z4LyRLr?=
 =?us-ascii?Q?j15O5opdx9tsWRsqKFz/Hx9riHqdM2npnHqZLIv0PI+VrpQPkm0ca9uJc2Zv?=
 =?us-ascii?Q?OjXOj6h8xiFCOmBpQye7N4DpFmN5gjGlt160yUM/3jKhDipv80gq6sNnSTWS?=
 =?us-ascii?Q?njn4Auyi5fjCuHb7IvA1ZXSjI4uEOEGYIoIMK73TZx0tsRAuYR8jGcUpHSrO?=
 =?us-ascii?Q?qyYSANXWxoguiiIUk+ucVrju/6mR04VUgHvJ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kGTGK906p14drSj9AxcPl7Vdk9YZrfGAH91/UDYwvcNle7XOVwZ9pm0xIB+BLIx0HWcRfZkfVEWbX8eI/TvYUsaelwWC4IDGvtpNarPQG9VA90P6kI/2cx6PveUE9u/vWhEJdUYm7anh8LhOKc84lP699WwKNcA3HmyAXWvZJSadwRqE8jGpxtb4TPYFt7eQSFSZdHbbkkXeskmzC1XcMbh3VdPLMuEsZTgIWp0bn41dTAjxnqB8nT81WoeH9YSUYHtHm305EV+4++cV5FKvoQVXqTgxXj/tGVBF1sMxYewSC0M/jZpD958AP0XtPmXoBu4RYrk0uzozheChKxOIWrHp/OieOKEOYfByNRhip+2BKLwkrWf9F5msqwiF0sDMkDc375hLHVQmQoklUSVqpn679CjbI582/3IR6JvPtoN1Adb58/L1117P4HxsSQUdwcLSqfeH83zqicPx7dyQMkuVZCIREoLr9oAFd9Ypcs9l9FkEJZrl/sqFcRYtQD1kLaCn9A7OKMxRpPDI4tK0vL7eom2Mxms6HqIcwzL4Mto75hq/IPVmZIl/4bOGXJWwjQw7bgJKMiH5EYqIAMlXf7OWcU/8WgFJ6GlM6CI3wH033/XMiofKC1xlnhBWDhEnqaEO4Evi864gN/zPhGEnfQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:41:56.9490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed3dde0-e574-4109-dfa7-08ddfb788317
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2595
X-BESS-ID: 1758724920-305664-7612-8007-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.83.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmRuaGQGYGUDTR2NzIODHVzM
 AoKdHIyCgx2SIlOSnJwNzM0sQy1dLAVKk2FgANBtdqQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan21-85.eu-central-1b.ess.aws.cudaops.com]
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

This commit adds a common service API for the NTNIC PMD,
which includes functions for service management: add or delete a service
and retrieve information about a service.
The API is designed to facilitate the interaction with services within
the NTNIC driver, allowing for better control
and monitoring of service states.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/ntnic.rst             | 112 ++++++++++++++++++++++++++
 drivers/net/ntnic/meson.build         |   2 +
 drivers/net/ntnic/ntutil/nt_service.c | 103 +++++++++++++++++++++++
 drivers/net/ntnic/ntutil/nt_service.h |  62 ++++++++++++++
 drivers/net/ntnic/rte_pmd_ntnic.c     | 104 ++++++++++++++++++++++++
 drivers/net/ntnic/rte_pmd_ntnic.h     |  21 +++++
 6 files changed, 404 insertions(+)
 create mode 100644 drivers/net/ntnic/ntutil/nt_service.c
 create mode 100644 drivers/net/ntnic/ntutil/nt_service.h
 create mode 100644 drivers/net/ntnic/rte_pmd_ntnic.c

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index b3d6ad70c1..a173eaa2ac 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -185,3 +185,115 @@ There are list of characteristics that age timeout action has:
 - after flow is aged-out it's not automatically deleted;
 - aged-out flow can be updated with ``flow update`` command,
   and its aged-out status will be reverted;
+
+Service API
+-----------
+
+**nthw_service_add**
+**nthw_service_del**
+**nthw_service_get_info**
+
+The NTNIC PMD provides a service API that allows applications to configure services
+
+The services are responsible for handling the vital functionality of the NTNIC PMD:
+
+- **FLM Update**: is responsible for creating and destroying flows;
+- **Statistics**: is responsible for collecting statistics;
+- **Port event**: is responsible for handling port events: aging, port load, and flow load;
+- **Adapter monitor** is responsible for link control;
+
+**NOTE**: Use next EAL options to configure set service cores
+   * -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores;
+   * -S SERVICE CORELIST List of cores to run services on;
+
+**NOTE**: **At least 5 lcores must be reserved** for the ntnic services by EAL options. above.
+
+For example
+
+.. code-block:: console
+
+   dpdk-testpmd -S 8,9,10,11,12
+
+The PMD registers each service during initialization by function:
+
+.. code-block:: c
+
+   int nthw_service_add(struct rte_service_spec *srv_spec, const enum rte_ntnic_service_tag tag)
+
+and unregistered by the PMD during deinitialization by the function:
+
+.. code-block:: c
+
+   int nthw_service_del(const enum rte_ntnic_service_tag tag)
+
+The service info may be retrieved by function:
+
+.. code-block:: c
+
+   struct nt_service *nthw_service_get_info(const enum rte_ntnic_service_tag tag)
+
+The service info includes the service ID, assigned lcore, and initialization state.
+
+Service API for user applications
+---------------------------------
+**rte_pmd_ntnic_service_set_lcore**
+**rte_pmd_ntnic_service_get_id**
+
+The exported service API is available for applications to configure the services.
+
+By API function:
+
+.. code-block:: c
+
+   int rte_pmd_ntnic_service_set_lcore(enum rte_ntnic_service_tag tag, uint32_t lcore_id)
+
+For example to assign lcores 8,9,10,11,12 to the services, the application can use:
+
+.. code-block:: c
+
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_STAT, 8);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_ADAPTER_MON, 9);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_0_EVENT, 10);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_1_EVENT,11);
+   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_FLM_UPDATE, 12);
+
+The API will automatically lcore to service core list and map the service to the lcore.
+
+.. note:: Use `rte_service_lcore_start` to start the lcore after mapping it to the service.
+
+Each service has its own tag to identify it.
+
+.. code-block:: c
+
+   enum rte_ntnic_service_tag {
+      RTE_NTNIC_SERVICE_FLM_UPDATE = 0,
+      RTE_NTNIC_SERVICE_STAT = 1,
+      RTE_NTNIC_SERVICE_PORT_0_EVENT = 2,
+      RTE_NTNIC_SERVICE_PORT_1_EVENT = 3,
+      RTE_NTNIC_SERVICE_ADAPTER_MON = 4,
+      RTE_NTNIC_SERVICE_MAX
+   };
+
+The application may use next API function to retrieve the service id:
+
+.. code-block:: c
+
+  int rte_pmd_ntnic_service_get_id(enum rte_ntnic_service_tag tag);
+
+
+For example, to enable statistics for flm_update service, the application can use:
+
+.. code-block:: c
+
+   int flm_update_id = rte_pmd_ntnic_service_get_id(RTE_NTNIC_SERVICE_FLM_UPDATE);
+   rte_service_set_stats_enable(flm_update_id, 1);
+
+All other manipulations with the service can be done with the service ID and rte_service* API.
+
+To use the service API, an application must have included the header file:
+
+.. code-block:: c
+
+   #include <rte_pmd_ntnic.h>
+
+And linked with the library: `librte_net_ntnic.so` or `librte_net_ntnic.a` for static linking.
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index b4c6cfe7de..785ac4836d 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -120,7 +120,9 @@ sources = files(
         'ntlog/ntlog.c',
         'ntnic_filter/ntnic_filter.c',
         'ntutil/nt_util.c',
+        'ntutil/nt_service.c',
         'ntnic_mod_reg.c',
         'ntnic_vfio.c',
         'ntnic_ethdev.c',
+        'rte_pmd_ntnic.c',
 )
diff --git a/drivers/net/ntnic/ntutil/nt_service.c b/drivers/net/ntnic/ntutil/nt_service.c
new file mode 100644
index 0000000000..4ef1233f12
--- /dev/null
+++ b/drivers/net/ntnic/ntutil/nt_service.c
@@ -0,0 +1,103 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Napatech A/S
+ */
+
+#include <rte_service.h>
+#include <rte_cycles.h>
+
+#include "nt_service.h"
+#include "ntlog.h"
+
+#define NT_SERVICE_UNKNOWN_ID (-1)
+
+static struct nt_service g_nt_services[RTE_NTNIC_SERVICE_MAX] = {
+	[0] = {
+		.tag = RTE_NTNIC_SERVICE_MAX,
+		.id = NT_SERVICE_UNKNOWN_ID,
+		.lcore = RTE_MAX_LCORE,
+		.initialized = false,
+	},
+};
+
+inline struct nt_service *nthw_service_get_info(const enum rte_ntnic_service_tag tag)
+{
+	if (tag < 0 || tag >= RTE_NTNIC_SERVICE_MAX)
+		return NULL;
+
+	return &g_nt_services[tag];
+}
+
+int nthw_service_add(struct rte_service_spec *srv_spec, const enum rte_ntnic_service_tag tag)
+{
+	if (srv_spec == NULL || tag < 0 || tag >= RTE_NTNIC_SERVICE_MAX) {
+		NT_LOG(ERR, NTNIC, "Invalid service specification or service tag");
+		return -1;
+	}
+
+	int ret = rte_service_component_register(srv_spec, &g_nt_services[tag].id);
+	if (ret < 0) {
+		NT_LOG(ERR, NTNIC, "Failed to register service %s: error: %d",
+			   srv_spec->name, ret);
+		return ret;
+	}
+
+	const uint32_t service_id = g_nt_services[tag].id;
+
+	NT_LOG(DBG, NTNIC, "Service %s registered with ID %u",
+		   srv_spec->name, service_id);
+
+	rte_service_component_runstate_set(service_id, 1);
+
+	ret = rte_service_runstate_set(service_id, 1);
+	if (ret < 0) {
+		NT_LOG(ERR, NTNIC, "Failed to start service %s: error: %d",
+			   srv_spec->name, ret);
+		rte_service_component_unregister(service_id);
+		return ret;
+	}
+
+	return 0;
+}
+
+int nthw_service_del(const enum rte_ntnic_service_tag tag)
+{
+	if (tag < 0 || tag >= RTE_NTNIC_SERVICE_MAX) {
+		NT_LOG(ERR, NTNIC, "Invalid service tag");
+		return -1;
+	}
+
+	struct nt_service *info = &g_nt_services[tag];
+
+	const char *service_name = rte_service_get_name(info->id);
+
+	rte_service_component_runstate_set(info->id, 0);
+
+	const uint32_t timeout_count = 10000;
+
+	for (uint32_t i = 0; i < timeout_count; i++) {
+		if (rte_service_may_be_active(info->id) == 0)
+			break;
+		rte_delay_ms(1);
+	}
+
+	int ret = rte_service_runstate_set(info->id, 0);
+	if (ret < 0) {
+		NT_LOG(ERR, NTNIC, "Failed to stop service %s: error: %d",
+			   service_name, ret);
+		return ret;
+	}
+
+	ret = rte_service_component_unregister(info->id);
+	if (ret < 0) {
+		NT_LOG(ERR, NTNIC, "Failed to unregister service %s: error: %d",
+			   service_name, ret);
+		return ret;
+	}
+
+	NT_LOG(DBG, NTNIC, "Service ID %d unregistered", info->id);
+
+	g_nt_services[tag].id = NT_SERVICE_UNKNOWN_ID;
+
+	return 0;
+}
diff --git a/drivers/net/ntnic/ntutil/nt_service.h b/drivers/net/ntnic/ntutil/nt_service.h
new file mode 100644
index 0000000000..73c9076c2e
--- /dev/null
+++ b/drivers/net/ntnic/ntutil/nt_service.h
@@ -0,0 +1,62 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Napatech A/S
+ */
+
+#ifndef __NT_SERVICE_H__
+#define __NT_SERVICE_H__
+
+#include <stdint.h>
+#include <rte_service_component.h>
+#include <rte_stdatomic.h>
+#include <rte_pmd_ntnic.h>
+
+#define NT_SERVICE_GET_STATE(srv) \
+	rte_atomic_load_explicit(&(srv)->initialized, rte_memory_order_seq_cst)
+
+#define NT_SERVICE_SET_STATE(srv, state) \
+	rte_atomic_store_explicit(&(srv)->initialized, state, rte_memory_order_seq_cst)
+
+
+struct nt_service {
+	const enum rte_ntnic_service_tag tag;
+	uint32_t id;
+	uint32_t lcore;
+	RTE_ATOMIC(bool) initialized;
+};
+
+/**
+ * Get service information by tag.
+ *
+ * This function retrieves the service information based on the provided tag.
+ * It returns a pointer to the nt_service structure containing the service ID
+ * and other relevant information.
+ *
+ * @param tag The tag of the service to retrieve.
+ * @return Pointer to the nt_service structure or NULL if not found.
+ */
+struct nt_service *nthw_service_get_info(const enum rte_ntnic_service_tag tag);
+
+/**
+ * Register and start a service with the specified tag.
+ *
+ * @srv_spec: Pointer to the service specification structure.
+ * @tag: Tag of the service to be registered.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int nthw_service_add(struct rte_service_spec *srv_spec, const enum rte_ntnic_service_tag tag);
+
+/**
+ * Unregisters a service by its tag.
+ *
+ * This function stops the service, waits for it to become inactive, and then
+ * unregisters it from the service component.
+ *
+ * @param tag The tag of the service to be unregistered.
+ * @return 0 on success, negative value on failure.
+ */
+
+int nthw_service_del(const enum rte_ntnic_service_tag tag);
+
+#endif /* __NT_SERVICE_H__ */
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.c b/drivers/net/ntnic/rte_pmd_ntnic.c
new file mode 100644
index 0000000000..fcc06a1ea0
--- /dev/null
+++ b/drivers/net/ntnic/rte_pmd_ntnic.c
@@ -0,0 +1,104 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Napatech A/S
+ */
+
+#include <eal_export.h>
+#include <rte_service.h>
+#include <rte_pmd_ntnic.h>
+
+#include <stdint.h>
+
+#include "nt_service.h"
+#include "ntlog.h"
+
+static int nthw_service_is_mapped_to_lcore(enum rte_ntnic_service_tag tag)
+{
+	struct nt_service *service = nthw_service_get_info(tag);
+
+	uint32_t cores[RTE_MAX_LCORE] = {0};
+	int32_t lcore_count = rte_service_lcore_list(cores, RTE_MAX_LCORE);
+
+	for (int32_t i = 0; i < lcore_count; i++) {
+		if (rte_service_map_lcore_get(service->id, cores[i]))
+			return cores[i];
+	}
+	return RTE_MAX_LCORE;
+}
+
+
+RTE_EXPORT_SYMBOL(rte_pmd_ntnic_service_set_lcore)
+int rte_pmd_ntnic_service_set_lcore(enum rte_ntnic_service_tag tag, uint32_t lcore_id)
+{
+	if (tag < 0 || tag >= RTE_NTNIC_SERVICE_MAX || lcore_id >= RTE_MAX_LCORE) {
+		NT_LOG(ERR, NTNIC, "Invalid service tag or lcore ID");
+		return -1;
+	}
+
+	struct nt_service *srv = nthw_service_get_info(tag);
+	const char *service_name = rte_service_get_name(srv->id);
+
+	uint32_t service_core = nthw_service_is_mapped_to_lcore(tag);
+
+	if (service_core != RTE_MAX_LCORE) {
+		NT_LOG(WRN, NTNIC, "Service %s[id=%u] is already mapped to lcore: %u", service_name,
+			srv->id, service_core);
+		/* Mapping by application has higher priority then 1:1 default mapping.
+		 * Disable previous mapping and do remapping to new lcore.
+		 */
+
+		rte_service_runstate_set(srv->id, 0);
+
+		NT_SERVICE_SET_STATE(srv, false);
+
+		int timeout_count = 10000;
+
+		while (rte_service_may_be_active(srv->id) != 0) {
+			if (--timeout_count <= 0) {
+				NT_LOG(ERR, NTNIC, "Failed to stop service %s[id=%d] on lcore %u",
+					service_name, srv->id, service_core);
+				return -1;
+			}
+			rte_delay_ms(1);
+		}
+
+		rte_service_map_lcore_set(srv->id, service_core, 0);
+		rte_service_runstate_set(srv->id, 1);
+	}
+
+	int ret = rte_service_lcore_add(lcore_id);
+	if (ret < 0 && ret != -EALREADY) {
+		NT_LOG(ERR, NTNIC, "Failed to add service lcore %u for service %s: error: %d",
+			   lcore_id, service_name, ret);
+		return ret;
+	}
+
+	ret = rte_service_map_lcore_set(srv->id, lcore_id, 1);
+	if (ret < 0) {
+		NT_LOG(ERR, NTNIC, "Failed to map service %s to lcore %u: error: %d",
+			   service_name, lcore_id, ret);
+		return ret;
+	}
+
+	NT_LOG(DBG, NTNIC, "Service %s[id=%d] is mapped to lcore %u", service_name, srv->id,
+		lcore_id);
+
+	return 0;
+}
+
+RTE_EXPORT_SYMBOL(rte_pmd_ntnic_service_get_id)
+int rte_pmd_ntnic_service_get_id(enum rte_ntnic_service_tag tag)
+{
+	if (tag < 0 || tag >= RTE_NTNIC_SERVICE_MAX) {
+		NT_LOG(ERR, NTNIC, "Invalid service tag");
+		return -1;
+	}
+
+	struct nt_service *service = nthw_service_get_info(tag);
+	if (service == NULL) {
+		NT_LOG(ERR, NTNIC, "Service with tag %d not found", tag);
+		return -1;
+	}
+
+	return service->id;
+}
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.h b/drivers/net/ntnic/rte_pmd_ntnic.h
index 4a1ba18a5e..7a491319fa 100644
--- a/drivers/net/ntnic/rte_pmd_ntnic.h
+++ b/drivers/net/ntnic/rte_pmd_ntnic.h
@@ -40,4 +40,25 @@ enum rte_ntnic_event_type {
 	RTE_NTNIC_FLM_STATS_EVENT,
 };
 
+enum rte_ntnic_service_tag {
+	RTE_NTNIC_SERVICE_MAX = 1
+};
+
+/**
+ * Set the lcore for a specific service.
+ *
+ * @param tag The service tag to set the lcore for.
+ * @param lcore_id The lcore ID to set for the service.
+ * @return 0 on success, negative value on failure.
+ */
+int rte_pmd_ntnic_service_set_lcore(enum rte_ntnic_service_tag tag, uint32_t lcore_id);
+
+/**
+ * Get the ID of a specific service.
+ *
+ * @param tag The service tag to get the ID for.
+ * @return The service ID on success, negative value on failure.
+ */
+int rte_pmd_ntnic_service_get_id(enum rte_ntnic_service_tag tag);
+
 #endif	/* NTNIC_EVENT_H_ */
-- 
2.45.0

