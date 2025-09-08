Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7857CA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28B4B4042E;
	Mon,  8 Sep 2025 13:05:16 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id CE220400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022124.outbound.protection.outlook.com
 [52.101.66.124]) by mx-outbound46-194.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 11:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI4c61IYYoSdq0A3zGdCFIAnMJy9OlFQuWWruc1wFJL7yBZouvUocfjKjEg9zMTnlcIdXG0Q8yMSkoh+P2LZvWDHyFkACbldoSpJET/N3ETw3//raVgG2jdC0ZvbTVomnpEbsHFDjJQZPvsuhqbSLmR1Ga2DFq/Ahx10gR7JaWfWrxdvPoGzXhRm+EsAnOOx7XmZLok6ouZ5B8iPE/Vnk92vPGNlBxbr7wkcjOtXrja9vETKRRBveeR6rWSsskwHlOsbm7L/pMO8jsnphLNJt6c69BW5wGvuCJGv4XKcCih+0YPRqHDCPau/53bWX3diWMsIqeXPhrJ9hOeTvHxRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg3Q3ZG0NxdeGTRe5CHJspMS7RxmHe66ijKUbEtDPiA=;
 b=jPBYETnjwPvuJATJbyjzSyssnql3VPdHEQqqd7lw/Q7W/cgQjyDXAIQXjqKhqeFUAKE/qUdPuHc+bsArP4hcEUKKj5RA+En5Iyv1RKazNL0EVBJsuz0pQbbJl4SpbHA1T0rEZZjebY5rLiCYtUEkXBZHSOwUKP+8drwIqoXHVrnG7xLaKGO/D+Xof+0p90eXPH1T0wuu0YiFCHZHNXKyhfZKzaglp0T0h83+STH20S4hOcOL/KpU3BIvMl1NtcL7syljsCMvRYcP/4eh5tuWZQ7a9q8EeC2VtHXGeHL4njt4vbyFRnY6LOax7fs80w67UHDTruY25R5r/vvsdANpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg3Q3ZG0NxdeGTRe5CHJspMS7RxmHe66ijKUbEtDPiA=;
 b=g2tBkCRiFUMyn/NlsItjl+4oSVphCGkEiU5e9piOq4lGDRqSRT50+OYPg8jtKeosha2tV4a+bydt4H99h42pxW+pdy23EvrOidmMSXQDD6d64fWf9u2z/oKn2GZj6JJJgy2E3gKAjDtBSdMTaPHCpyMgbyL69iDBwyiY2uepLuM=
Received: from DU2PR04CA0360.eurprd04.prod.outlook.com (2603:10a6:10:2b4::28)
 by DBAP190MB0821.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:05:10 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::e8) by DU2PR04CA0360.outlook.office365.com
 (2603:10a6:10:2b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:05:10
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 1/7] net/ntnic: introduce service API for NTNIC PMD
Date: Mon,  8 Sep 2025 13:04:39 +0200
Message-ID: <20250908110446.1071964-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908110446.1071964-1-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|DBAP190MB0821:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a7adb21d-d587-4da0-56c0-08ddeec79405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0lEJOErc2tbJY5kBKzrCTBACdWwEzHRxW2MzVyF0RzjK4efc6HQ5ouTvqLjd?=
 =?us-ascii?Q?ZMJeFNco4PFIPXUNfi/4xTVXD+KuLjkTLwlY5i5XfcKyTNWNrdGSVIIGJ+yg?=
 =?us-ascii?Q?6FHgpbfboWyCoHjtSmh6i+uIltJC6+kaieF7RnJJVGfEOAjRO2fdXUYYggmO?=
 =?us-ascii?Q?81iu8lrKCF9gsO3RqhkDu3ZYLlWNoPkFT8MI4SF9yPSTZzDwQCkMuqG54aIP?=
 =?us-ascii?Q?0s39wHA/HhSpDp+aej0g07Ryt9oxhrAOYR7b6NM4yjai1ae4cSWyexEc32/J?=
 =?us-ascii?Q?hoAHZOr5BE5mUtRYKtLm9egEO+AOZbNRkXYjCoZoX9BvSxvy0sSkCeyJEiIL?=
 =?us-ascii?Q?4DPJD8RoQpB/6n6Ch1x/gFk28mV2MwI76Dt1htwCrRqDwoFwCbsCQB6YneWp?=
 =?us-ascii?Q?gd2YG5urWbSWZJxlq92160vKWrubCwMAJCdK5OR1Rajn0zKxeZHdghsaAG8s?=
 =?us-ascii?Q?sjCieBxFLneXZGcYt1v/CJF93RDHK5gWFZl9TyxQEnGChyAh9HClHAJ+7lyJ?=
 =?us-ascii?Q?VsZ4S5UuDiWz5na9X+XOC4DMS23BgflXkgPdw9Wpw6gnRvvkm/5anSrt0jcZ?=
 =?us-ascii?Q?3P/bkfDr0z+cwhvcVPfqgieFsj4q7ptvL6cDfC769rBvM5hMkuMDI/eO72Y9?=
 =?us-ascii?Q?2sGJWuG62j5i0Rj6iW0s7w4bKzLpTb4zlebrCKWonGCOes4cjpbGyyM4YkkQ?=
 =?us-ascii?Q?UXqvrGVGWZc7oWrQikFS4ZWyopVcvQEXMKnuITZjlR0ZS+D9/2zqpnNFoBLC?=
 =?us-ascii?Q?iYhPaaC/IwHegQUOkokXmxNAObfkCDFNxduSRXKl5E5TEey7NehFf3o9E69P?=
 =?us-ascii?Q?Avc6hWYQsGZKXHTsvfnyntPscA8ybPDZtJ7kgvkh8Bz4ORiFDQs8B3ag5mk0?=
 =?us-ascii?Q?iGOmh2/+DEjWdNqNoACmq3ij0Dv4oYmHzwo/g3dEGlS6UFLdgVcHylICmRfa?=
 =?us-ascii?Q?Z1DmSnn4u5rdULBDjWJmudoZcjQVWH2k2BoOsCO5jIRrZ6hb0n3+u1Ttfx1j?=
 =?us-ascii?Q?e5izeybML7dIIv3lIFCG0Z0G1sfTfUJCwVtchmK7gHsLU0XFkSVXLOw+zLeG?=
 =?us-ascii?Q?isqgfUNL8C0WEuBByDV/awafpz52IePi4/51G9aVhPjFqgePE1dRtpNsQ14Y?=
 =?us-ascii?Q?JjRmzRl51fL1Y57T1GQykm42TlVKxswbZCUSLiSzTWInwcPi2CNqC40od4J9?=
 =?us-ascii?Q?QR3eSKSV0HM09yVu0N7F7IYmqM/tu2DYA+gteID1ji0LXfr9zQLZAgiifYVC?=
 =?us-ascii?Q?Q3R/Z4vIkE+xYnpmuz5GNbyuXn7faAQKZsPj41TNF2BzTe8dzTrirmIz/dNq?=
 =?us-ascii?Q?6OyKvpnOBY6nwcaQ0vt+RG5hmJQVN8Y2gBYkE7OzZpcwpq0CZppHkJnMCjf2?=
 =?us-ascii?Q?DMktTU2CiiXh2LmdsuWYDJVzEgFHRolB6faYwh9Nj9F0QtQ4O/P8s6eJdBEk?=
 =?us-ascii?Q?QLa2CNxgtI6exT2jqKO0G0TdokrmXjGjoARn/+UIyriu+eNa1FgUmKt0Pg1n?=
 =?us-ascii?Q?IpLcFLNIHnxCadMTvti0hk/LxDZPvKU6azCf?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ljacF75MrISaDJKCTtfwuL32m8aqkzODZdkF6dBfb0aZQi45DdU7onDpbyFoRkWjtFPodqm6pxDWS9dw2mn+igOwFkl5KcA4TtbmbpV6rIyre5bX/+iTZ1RrQ7b1cPxPXRYKmCcjx4LWDT+sFNRVttEcqN17uyry0Gn23Erqun7eoN3fPOLrcDpQHyW2WcgNlATH4xr+qKEs4ndzbJ8CCZFMF/OVScSIYeaWIqMEJfCVWiJrdHDp1DYH6JJWJicqVYHbY1AJjMW0SoZkoaB07rMr46S1iyHLQIFXO8bv8x0CkzKRaBqLpf0Z6cbOItrWx6csHPrMvlyrVIklEqaoD5DOoZdbwOWmNL88JiVus5d6cqdwCDY1Qs24O48sknnbvTUiAVzyJ5apyII1Fi2P8N2uV7AnT3sSgg8DxSoJmzU8iDIDjqVJF0PcHkflpuB4lC4SQo/2dGbWmPN78VShwsh3sA+lfx2h/k3E1PLflbrJj4apSXu9sBSKB5auiQcxu7WjKAedNpw1vmUrcVQZj0c9NnIv+R58KRsj4fP6L+DTQtFWWOqka70H8OCF3Wv8ICIVLBuW62YOmmp7KegsUqUmHORPD2vbdXArmNLAljwf9bxtcHqdsDMrR55oSFmXjPkAOTc7hfK9ywmnTahP+Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:10.4337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7adb21d-d587-4da0-56c0-08ddeec79405
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0821
X-BESS-ID: 1757329511-311970-7668-3961-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.124
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmRuYGQGYGUDTFKDEl2cg8yd
 g02dQ00dzQwtQi2SQ5ySzJ0jAlLcXQTKk2FgB98oApQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267333 [from 
 cloudscan19-155.eu-central-1b.ess.aws.cudaops.com]
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
index b4c6cfe7de..9467684f04 100644
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
+        'rte_pmd_ntnic.c'
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

