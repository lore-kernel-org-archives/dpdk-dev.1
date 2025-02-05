Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B590C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7B0540E20;
	Wed,  5 Feb 2025 11:46:42 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id EC61340B98
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:30 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5EVOjCuz6pDAZJoaOVoXtKi3L0mSI3YuKnPDif4WyR5CYrub/qowIqV2KpGvQXxQMCn60Aox5ma3BuC8K4v7aXE2JrJTqeR2UAqZyoK0vjTud5JZBX9TQLhzxHJFSn0ZplFqg7jIuOq+YV5raKsVQiHj3N14cKPnOY8GG9QF6Koc2BcuEkM+XA+bCOnRAiyAKbMgDZZ17BGVXEVP8iuKxAEg2MWDtwnaljhWxVGvTatJPXVJTlWQmorxypskY7Eb9MFTx6KnhduNjSGQnN+skXWP1Zg9LnyPq0IsaaSbnTQFkrt/fdWSL2f52cXOHlrDEpfqbcNjyTN0+Fj4wM4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT53is01AYU4VGnooqJ4F/H+yZMN6l/uK/aYriTbCBk=;
 b=j3fMiZZgKU2frvE3vkQS3m4HQdWoXyP7K5q/Ihpq5+ajbJewge+q++1nH1xTaeW/afYrzIQA2UtxDzjhUJ4ZzOl79pdT8EO1UDBqm8OLsWviUdxoTFFtbMSSK/MbJNoMjl0fxpBjFg5BeowKWqvRB1UXNVs+Xek9X3Y85ZUQQPxs67m43KL59IvSuHwevC4HTOWO6uvfBOrX+HvFAv+Vf+2jFO39qiNV1ptvLgjp6iPpszt3hoB3XnGXLOuMUlejCp2CI0x7dhZhI6qNPKE8YkfaJqrbqCdsqhhxLuUsfkqNO3zDhBFv/jR1OuEIJFj9PQAfTmojoAbRIQfsapQ/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT53is01AYU4VGnooqJ4F/H+yZMN6l/uK/aYriTbCBk=;
 b=Fy9TG3ffDbYOLF8xeYSoA8joCMToCwzqUpbVmdhhM7iEgytNE5xeixGbr+YalyK07+/52BsjSVj55VZg1+vzOfsCLOzwhAil7/8J8eKgfkmVZ0f+Li98lo2TUVaWBcwaiuNfbGt+VzlkvGNJfRNZgNLxRPllsq/MqaPNFjEY2i0=
Received: from CWLP265CA0345.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::21)
 by GVXP190MB2202.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:46:25 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::14) by CWLP265CA0345.outlook.office365.com
 (2603:10a6:401:5a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 10:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:24
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 31/34] net/ntnic: remove shutdown thread
Date: Wed,  5 Feb 2025 11:45:40 +0100
Message-ID: <20250205104548.1533554-32-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|GVXP190MB2202:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 05f627d5-1660-46c5-338f-08dd45d25630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t+ToO0ERXq2eaMMiYXQNY2dgfvN/bqJfHux4hJgiLUqK1Xqa9w7UFV78aI65?=
 =?us-ascii?Q?xMznRlkwklkNAoJxngflDPHNSu+a/RleyR8UoOrqCGVN3vpoElvaeOOUkFrH?=
 =?us-ascii?Q?l0Sw0/wyfzashoo0tQ0qzFgesuB98E00RUeT/O8UjZEI+4GJvEADtUMiY6cD?=
 =?us-ascii?Q?GV3l6IvyupguOjoGQ9T+BTYmoGzlhOxd7as/Np5pgP05LmEXOXRY5qtyd7qZ?=
 =?us-ascii?Q?ME8dKQYEmo07Wye6lOMxtYS4XVWfVIKDfxjzwa6kZMr67xRZsakxD2BcNdi1?=
 =?us-ascii?Q?bY1Yfu6923pXZS+CE2bCwyvRQwLxyBNKfl0GJ797DcRdGaE28xsQk5kEGCCb?=
 =?us-ascii?Q?C4zsrS8oQs2ut2RxlUrkuQX/MtVBvCj8qV29QFWhCeq2eqF4Z0Q2CliH3PHG?=
 =?us-ascii?Q?bX1X0nivSEpMImQU561klCPBy19kTR+Pl8uH0RMio2EMhgPnLQNRF69s5T4z?=
 =?us-ascii?Q?axI8zLPPRCn+5096nsrZvbJGOqOEb/bVpikDUYt4Ewcg80/vBWSgzetANQol?=
 =?us-ascii?Q?gC0qMWbccDOG4p/XPZ9EeHzgmFNwqI3wsjRqS/NNfLlF00N2y1dLMBwQofD6?=
 =?us-ascii?Q?/0BTiZOjv5m+QITphEHRcHub0/X1X5Lzu1hS73BcgRO2Bck2H4+8AUIWGHXz?=
 =?us-ascii?Q?xtI7bCcQZjFf8J6mq8CrlrK9cvl78IoyVvUcIifZ2KqH6dTgKWGyikGCMIuL?=
 =?us-ascii?Q?APsi6C+8TO4N3zPJYSipgRQ+B1q+uX9GJudRgdCP34noEioI1dsnTPRnPS5B?=
 =?us-ascii?Q?/xuhkfLWYSRn9vM4rbeXKJQci+owza6dDLAn3rBW98LiLAfWGrRT2BATJ2TQ?=
 =?us-ascii?Q?ysEoLDVUAUbP7eF69OCgCXkDD6dyFYOskx5lupBx8BJxdXGnH6N0uilKDLHD?=
 =?us-ascii?Q?WnGAsNxUgH14RZI0UT7Z4C4cn64u0jqU5fMODN8rTfdz1GN23ZWwpT3e+Dnt?=
 =?us-ascii?Q?V56T0EV2T+0QpWPZsJoyXzpkOKlXuletRqw06PLvsS4cBTwjjn9mGhhg9Adv?=
 =?us-ascii?Q?AqRt/LwOiCu7DlHQIUe7kc06QNh8CdeVpY19Oj6R0BjvtRY8MVU6TxGZnKjE?=
 =?us-ascii?Q?I4mYyC3vlTd0u2rie9q1lPIE2AbOsQjmvYLEOGt8kCbCoBKNy24gBoXy4slL?=
 =?us-ascii?Q?ZjKXS2frpOQAbbtIf8EuBO5UtaFIVyKBH8hQvsOum4i47sSu67ZK9x3zZP0z?=
 =?us-ascii?Q?S81vI0obd55XXCdLFDJJJZsks6JdLAoXOOL8WtpwepzhcrPfXAEtJpSwpGlk?=
 =?us-ascii?Q?hzNw2bf4GEdPuvY3CwgU+yOlav4TOg0PEI0kuKZ0KvfI0XAwF+NlpsJ6bSy6?=
 =?us-ascii?Q?IWC8MaMgc6zUYrD9BpTOWUf2B8/2O3UacQnfcQiCC4a7N0n06+zC2g3cl9kC?=
 =?us-ascii?Q?I0LigpxcoOMP43EUfsqKx4iKz/WywlfJoRiy5mdgAtwOimZjDsdD6cGQgcdi?=
 =?us-ascii?Q?Pm3ri7BmW3bnOjv3l9TyU28UJvJcJC0GISV017TbbM3rSH9OOUICS0oIuSFQ?=
 =?us-ascii?Q?Pjng9Ipdl9hWk+0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XZL0pLfO8RDwwa40AmqHqXYQsVukEDDpCTerjeFAf0ekn024z4kJ3nkklfrdwCFH84pRHNPz8Fpv7iuauE+qs91ZRt701owsD3GNmQHpt8o1b/sOUGSuYar5LlgMCrmC9mi4beoZd919QTQJgWYIdXjcwBGso59c1Mhuwh4RSMxl7nTFLy/T3XWNy/WD5ZBPHR6BaGeWczTVT+knxRaDsNRKdjWzdI6Fmsmr2sZFAwZt1pWVAVPMAyFQzPxdYm3SEm8PzIRlbsHqFa/VHUoUmwF9jv22mkJY/uS1N7a3zFPplcfAbOXuib3lNOlZ+ZuyBkrM2f5owzHhwS0Qz5hkS88xSXqmOoC+uYhPtLKWA2c6z9+vsGxylV4QqMsDKD8QHZ+RQy4o0y4r5f4l8iZXZyQ7tRW3Y2H7PEWuLrP+x1CHYvbL0HSvehr9OKF/t++e/UdZz7BWIke6I8yu3mrDB3FexKMdqopPUPC6Ay9SpvEDh6tOPIW+KpZLd8b74kfJ3zoZzVaVDmSl3qUjCrGu4CaGAdoPd5b79iBAiu+XiEuJ3yItdWlpgTEZJZHF9j1r/t5CSlO8asgXFJ0B1pJzqo13NfS167VOMPktsHK3lAeW/2nbEYxsiOx+l1ULjOVK3kQcUpLROF/UDEMHUP2A8g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:24.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f627d5-1660-46c5-338f-08dd45d25630
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2202
X-BESS-ID: 1738752389-302364-7584-689-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.110
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGpgZAVgZQ0MDC3MA81dws2T
 jFMNXU2MLUzDIxzTTNyCzJNC3Z0sRAqTYWAC+PkWdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan13-199.eu-central-1a.ess.aws.cudaops.com]
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

Remove the shutdown thread and SIGINT handling on the level of PMD

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 63 ++++----------------------------
 1 file changed, 7 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 9000264804..e65be67c44 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -76,10 +76,6 @@ const rte_thread_attr_t thread_attr = { .priority = RTE_THREAD_PRIORITY_NORMAL }
 
 uint64_t rte_tsc_freq;
 
-static void (*previous_handler)(int sig);
-static rte_thread_t shutdown_tid;
-
-int kill_pmd;
 
 #define ETH_DEV_NTNIC_HELP_ARG "help"
 #define ETH_DEV_NTHW_RXQUEUES_ARG "rxqs"
@@ -480,9 +476,6 @@ static uint16_t eth_dev_rx_scg(void *queue, struct rte_mbuf **bufs, uint16_t nb_
 
 	struct nthw_received_packets hw_recv[MAX_RX_PACKETS];
 
-	if (kill_pmd)
-		return 0;
-
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
@@ -693,9 +686,6 @@ static uint16_t eth_dev_tx_scg(void *queue, struct rte_mbuf **bufs, uint16_t nb_
 	int pkts_sent = 0;
 	uint16_t nb_segs_arr[MAX_TX_PACKETS];
 
-	if (kill_pmd)
-		return 0;
-
 	if (nb_pkts > MAX_TX_PACKETS)
 		nb_pkts = MAX_TX_PACKETS;
 
@@ -2490,51 +2480,6 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 	return 0;
 }
 
-static void signal_handler_func_int(int sig)
-{
-	if (sig != SIGINT) {
-		signal(sig, previous_handler);
-		raise(sig);
-		return;
-	}
-
-	kill_pmd = 1;
-}
-
-THREAD_FUNC shutdown_thread(void *arg __rte_unused)
-{
-	while (!kill_pmd)
-		nt_os_wait_usec(100 * 1000);
-
-	NT_LOG_DBGX(DBG, NTNIC, "Shutting down because of ctrl+C");
-
-	signal(SIGINT, previous_handler);
-	raise(SIGINT);
-
-	return THREAD_RETURN;
-}
-
-static int init_shutdown(void)
-{
-	NT_LOG(DBG, NTNIC, "Starting shutdown handler");
-	kill_pmd = 0;
-	previous_handler = signal(SIGINT, signal_handler_func_int);
-	int ret = THREAD_CREATE(&shutdown_tid, shutdown_thread, NULL);
-	if (ret != 0) {
-		NT_LOG(ERR, NTNIC, "Failed to create shutdown thread, error code: %d", ret);
-		return -1;
-	}
-	/*
-	 * 1 time calculation of 1 sec stat update rtc cycles to prevent stat poll
-	 * flooding by OVS from multiple virtual port threads - no need to be precise
-	 */
-	uint64_t now_rtc = rte_get_tsc_cycles();
-	nt_os_wait_usec(10 * 1000);
-	rte_tsc_freq = 100 * (rte_get_tsc_cycles() - now_rtc);
-
-	return 0;
-}
-
 static int
 nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	struct rte_pci_device *pci_dev)
@@ -2577,7 +2522,13 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 
 	ret = nthw_pci_dev_init(pci_dev);
 
-	init_shutdown();
+	/*
+	 * 1 time calculation of 1 sec stat update rtc cycles to prevent stat poll
+	 * flooding by OVS from multiple virtual port threads - no need to be precise
+	 */
+	uint64_t now_rtc = rte_get_tsc_cycles();
+	nt_os_wait_usec(10 * 1000);
+	rte_tsc_freq = 100 * (rte_get_tsc_cycles() - now_rtc);
 
 	NT_LOG_DBGX(DBG, NTNIC, "leave: ret=%d", ret);
 	return ret;
-- 
2.45.0

