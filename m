Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B9ECCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 817E540661;
	Mon, 20 Oct 2025 18:36:36 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0AC95402D3
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:31 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023106.outbound.protection.outlook.com
 [40.107.159.106]) by mx-outbound47-33.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFE/1BZpJOnymkWJhkqqT7kGl7ER/VwAZ35VP3dDtLJC8UtJyUJzYvYe4MgsBAYzbMChfAHy7iClc18xsi7FyicHcrZ88E6l3v6aO3XP0drLdBZxpRilGp1LEgtSV/gr+A/heFxf8ceDzuq8eM8pBafedelzvnXviAkZ+QKVhDXggF+4Y7qpO91JMtwNm/01o8HlgRXnfzWCdsdWnoUbNzmcgLzECP1F9ey1jEXmj5uFSARhjV+H33XEKgOjQKmb3LNQzhoHbu9XybWncgWbCaxapiV8MExo/wyA+0QpCS2X44Uy4QqNpjSN0eLJ0AF/d6DBoReMrEgwaIdgK3Q3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14cRZkGnqm8L2t1LOQAv3OHREwgft7+LW6B9HoMUPyU=;
 b=wiT1YBqx2HjSXZxGkvnNsKHqpRlxhVAOtnsp9oRSSZNpwOk3zPr8iHOuHmD09PAZIjoS5Xi1OLilhTR4DhguOU/fhD7P1vhcYv9+ZiHiBmC5HuBxcM0likArWU9DaHLNtNPoW+G1m2VO9Uh6BBjlrPCfxDUr1ForQHzQkWN6VfG4DMb3rQLP6geZ0O3R+TgdGutmBs8oHo8kuXLIBkMmhXHUhWWncfFXUBsM0dpaQocXAqfvlA+UwzpDm9RRZQ8qf3qTJUKJASZWuv3OJ3nzFkykckVUFjX1wX9Xyxvx90BQ0S8+WOQA6XClumWQXY6uMsg8rMqqIgxplqxrbrqWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14cRZkGnqm8L2t1LOQAv3OHREwgft7+LW6B9HoMUPyU=;
 b=UreJG2thIZwQvxNK1MeUXIxDMMWSZVMWs6C8bZEuC+y9YSZnkpdFRAzLOFo5ofROE6x9LEa08M6906V3VhQdVIgTuA46YtOanBuD2ObnUB8JMJuJOW2ngZnhNmR2w/mkuNR7jm6eMZ711bwdF51y8flNZo/7FHNfSSAIfeBVwHk=
Received: from AS4P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::10)
 by VE1P190MB0926.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1b3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Mon, 20 Oct
 2025 16:36:28 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::a) by AS4P191CA0027.outlook.office365.com
 (2603:10a6:20b:5d9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:27
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 01/24] net/ntnic: introduce service API for NTNIC PMD
Date: Mon, 20 Oct 2025 18:35:52 +0200
Message-ID: <20251020163620.282312-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VE1P190MB0926:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96b96236-2b85-4810-ef9c-08de0ff6d12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PwOUQeQZ01zbqUShREKnZs0jUJE0QTie/u5FTjaiH9a88mPdQ8+FaQDxpReX?=
 =?us-ascii?Q?yRS4O42euIXbol9NFr7mE90SZ3Pfsq2E45osJn26syohgIBODjpKEXiFyGmR?=
 =?us-ascii?Q?gFeq7Jh8qdeggiMeBEP9i9TPq5X3+f2fM1vA+rW+WlulB4z3WJY2FYHVFStO?=
 =?us-ascii?Q?yiYoOWC/rogiasTOpNw/lBpyfW//5mqxLI8Eurs9nwldlkxJENJ+nCaXYKAm?=
 =?us-ascii?Q?8D40Uby2JFRhPJ8nyC8DjRjhbvL3zaPk9YU+AJ/zhOFnDywJ5lOOlENwLtJS?=
 =?us-ascii?Q?+KF5qZ8TsGH3F6/ip9yvjyMJr5nz5hT/xtOEOfykmORCZAun2POqShq99/K+?=
 =?us-ascii?Q?7Z5o9aj+ThxNEUaEJUs3AxZgqMSlRhi6sf/cpTz//1inJ7VIwyDulCRMCBpR?=
 =?us-ascii?Q?41tsFD7kjmbUt+B7kdrncA2r7BgmWJwARX9rW1ihRwpv0uhsGzY7MnPoohMt?=
 =?us-ascii?Q?gFzTD33tEumGfRRi01o/xUiNAIPm2cjxvCbyMaf0F15pVAh2jTVAbkItH+si?=
 =?us-ascii?Q?LKq+5tCIm1oayw/uu2tzwN8sonSWMYxn6FyOvjKgOANXbR7Mi7gvxLQ3HUjz?=
 =?us-ascii?Q?FLisFBBDpL0LKOXcj60mYixdt4N/Qc/AjM895V6foR8iDJNftOk0Sh72IQi6?=
 =?us-ascii?Q?kV0aleMpguma0TVQ674QGQi+LBtEr/+XJZ4xaJeJn0PYTIdoyOsGjBM4eSDB?=
 =?us-ascii?Q?zrqTpt6LTE1PKYw6f0pvJCX1QIx3gRKjNPRtDbqd+niLIFjAflSLn8siG2A7?=
 =?us-ascii?Q?Bs70hjF05IHR9F6KWKpitXSso7BjidL4eshjbldOUvh35cvSNI1upEKLrWyn?=
 =?us-ascii?Q?/P30GjPiV4BTpFV+9Zm9950Zrh6Z6uAIwecMmCjdYxZUa50cRzRib3Y3hOVw?=
 =?us-ascii?Q?qY4dDNCZdSBDzSF9nebBeS8V958UWQXdmxOB+TamV2tvRNmLv4I0jbSulKAG?=
 =?us-ascii?Q?kPt9+bn9iQYs5yRNYKpQi9IXpdCQpkw1IA+rf4erXUfH5kACgwPHRJGQTLNp?=
 =?us-ascii?Q?7qmYP3oPqTvTW3+DfR8SwZL8rWQsPDNISJqd29GcFH7BmnuyEi8NBrah5tlt?=
 =?us-ascii?Q?5638777Y3W5Z87mcVCE7PFlFsQnfb9oMsFzjsfIJdrqF/0/jeELOKoKJI1Sr?=
 =?us-ascii?Q?Gla/LVrvHPV2JtbR3JHsJp3z9qPorWG3uDas5kx2UfJZWMY9JhVf5H9Hl64F?=
 =?us-ascii?Q?pMin9ST7ywshaxqS0VFZOB8AXLD0jPxAjBtCR3YDRKJ58FZYGGocVT3KV6yZ?=
 =?us-ascii?Q?QtmaEcEX5OO8PDkeQspi5CI14hIDB0lc/tu/btLIRJXP7aoKZGNbcFXzIujd?=
 =?us-ascii?Q?UG9Sliv3DmL7CUV1BoRTchmcs/z0lTqbQKoX+R8Pa/cRtXIyEOtRukg+XOhe?=
 =?us-ascii?Q?r73PFf1BDQXsU/t44AxQoZu+7YaVjipH22fJCvKkfIG1arHA8YWXevY6XWjw?=
 =?us-ascii?Q?bbO3xpc9pfGSrjeh5CKy61KMGp7KxUY+w13bIm4pjfyCN/G+FNyl4qMgEDh1?=
 =?us-ascii?Q?KvrWJ4TcV3Qxsj5saN0g8Xyc7PJRS/8Go8pu2SeOJ+8zM12WNuqLw7i/zCD9?=
 =?us-ascii?Q?P/xDogAn4VQGY/VhADk=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5CU37lPYCOAhjpq5GJtI2aG0l/xhLBsPw4oLaOb6DX3eVrXCh15QBlqIvTcPkzm+Cm7WCmVqKowHf9yXTS+8TNEctlzdb+3R0dD5DWR+B0sIQM7+e8bmpHXvXbU8OmHwt9u8/+VHpCvviq5lSI1KZbasAjf2fPOVxi/ocZPr5tUctVQP7iz0R3Ie2EsQJ9E0ZjZF2Z9Ejy3oMW4cnIUPK8QaLxN828adF4w9h4XDNYtMxzIZ+eC53zIvfiI2qhG1UNDxg6iVfNgsRNZ5BBxzSMEXeoY+pC7ANh5aST+5DP60v/Gj2LvrzB1HbOeYyyomp5X0hNjEGgOEBL/pdl46kJhfKbl8roasEpeSt771OI/NDeiVrxKsB8L8o8tJoVaMSR+fttcv/UVH4MYuTV4uvcGuejgmwsC2lKjZ9nG7EXygCmXapa3cV5qdcB1+eJUhPA88lsF7G5CL8M2Bp1Iyw5hvlZh/XEO9VB7klCcoyfWYmkD6juBeS9gC9rU5T7Ug1nbZKlsgeEthLFKwFdButllqa/vvtCp0jUKMqtszRVKF2a7zNHS27r7RLkIq8YSBmW2/1/jVl1DJm+rpjDaldGZOLOgsG1mEu763VOOHOEAAd1ClkCRHHkGCTLwX6/LPuym/Sei8qUJXr2pCbXn3xNlXtJDnueIF2Yxx77e0mNc=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:27.7977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b96236-2b85-4810-ef9c-08de0ff6d12e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0926
X-BESS-ID: 1760978190-312065-25063-118007-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.159.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmRuaGQGYGUDTR2NzIODHVzM
 AoKdHIyCgx2SIlOSnJwNzM0sQy1dLAVKk2FgANBtdqQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-181.eu-central-1b.ess.aws.cudaops.com]
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

