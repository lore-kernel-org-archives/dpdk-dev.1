Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01539CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 14:17:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DA8C40615;
	Mon,  8 Sep 2025 16:17:54 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id CB34B402E5
 for <dev@dpdk.org>; Mon,  8 Sep 2025 16:17:51 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022143.outbound.protection.outlook.com
 [52.101.66.143]) by mx-outbound45-224.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 14:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rz0vjdRxoNtD9HI9itz0ZRJLgxEFLr7UDKiOmzDgNWr9AtMSOT82um0JbMyOBLSfUP26TojZAsbY+JgeeE0wvpWVyxPB6sy/3IvVs/w0YFhw6m559atGlM1ZITodqf3WtMtKmXSFcm/n5jo7/NkXH5Gn8aDYMk14msGjKS+eXwrtZQS0X5JVj9QuvK6yzpWowfpbwsTkAZ9oyNsJbmu8LvXgu8dM2lm/etY7TtfeRHGzsV7f9w0VbrUYDdefTamrnyCgeJAY94YHkcDr1Nq5of/SLkQXGuKiCEeCO4aq9YpAm4jUDAQmqqFbUMZPa/sma6b0AykUHeFHCxtpR4OFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNMSbxqzEc8X6EKZMtJb5YaAOcrmNyjteFHMG6yU3sk=;
 b=ZtSKwBF3IInAq84ecIe3Vyb1fSHQ0hohO5+2n6PuCSfYRLE8zchHInuGv7WLv/v7u8gl/Gg1v04v8m2HmvfXauwnYpCGTNc/W2vWp2HsP3FoWGj4nu7ZMteROZDe6kpQaxsTexjX+0em8EX3iIlJqPRg4pQ3NYbX5cofREt/BQGO+Mrdv7kXc7siw2bSn7vIQqmwHznYMAXD06/n/Udl7vq4DNn4J5+mCpmKhAKWY/xvvd8iJYgDyLOSlVxrjj74hiva3HKrLHTUu1+Lsl8uSuokAixTNSt639dAwIgOcGW6msaCB/gP7AjiudLtwACt8dtkicCueYfJ4KUJThTq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNMSbxqzEc8X6EKZMtJb5YaAOcrmNyjteFHMG6yU3sk=;
 b=k70DbKNybc6OrYdcIODvtH/Hxog5wmSzB1Td8Gpw6jm3sxvqE0KgimKdRWnOQUq+WQWWNalB+KjBUkaaurKNnG5fycYZYm3XjYeV0pvz626NEuJDoSoC2ls8LqSt782X83sgJo7geYbNZ28gVJn6wxD1x0xXzWdvctWDJOGd8mQ=
Received: from AS8PR05CA0008.eurprd05.prod.outlook.com (2603:10a6:20b:311::13)
 by PRAP190MB1833.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:293::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 14:17:47 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::c9) by AS8PR05CA0008.outlook.office365.com
 (2603:10a6:20b:311::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 14:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 14:17:45
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 0/7] migrate threads to DPDK service framework
Date: Mon,  8 Sep 2025 16:17:32 +0200
Message-ID: <20250908141740.1312268-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908110446.1071964-8-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|PRAP190MB1833:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c218145d-e863-4f28-6f5b-08ddeee27b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uNVicnQIqN5Aa0gsMg0aYDFn98wO2H1vTAAz3WTGkSP0cRH23hQuCHj5uwdD?=
 =?us-ascii?Q?XsmboFhVg5x8ab7njukJ5C8Fcb40HVGLp5SacJi7VIMH6xFOIiQVvfaMiaAX?=
 =?us-ascii?Q?s8yabrTopHYszW3EDC6257mCZX8jTQz7xHYLmRvdC4ThOS1n6rbtgBH9KG5E?=
 =?us-ascii?Q?ZA0V3i2qnyGZ2/MvwH2yBvtm6ztiOzKqMClRUjuBensATeLHv3yHzTFLadyQ?=
 =?us-ascii?Q?OJmo1Kl2b5aaSBFh9BraE76sKoCEHwVh6kPU9gG9dCcunzOGdNUYDkJ4W3vS?=
 =?us-ascii?Q?4keANSj59K1dVSv4ccvwHMl54t5Hav/Gk8O6uGgacPdZsx12P9dWdVt3G/0q?=
 =?us-ascii?Q?w8EnIPHBemXqPKKTGADBxxW1rrwI8/L62nXrxkNAcUJgKbeA7xXkrxvINHBc?=
 =?us-ascii?Q?ooJEqWdHH8dneB0PXVqSm/9GPpHK+Wq/uqCVrKn+L8VhTQcRBDSnwplYDylr?=
 =?us-ascii?Q?2DjYUWubltrw3IiC/XgqsOq0pssBahg7wp9S/SLAZ6k5TVMwiOJgOs9eXYbS?=
 =?us-ascii?Q?SURpcLj+Op7SeKGORIp/hbpthYGbUgQWsL7FKLQ0lXKdHxine4VTWR10+OYh?=
 =?us-ascii?Q?+OG9OQgZp6Az2aIlQ4CWImE4lLZnWUnMHDUB0LBf6z/9Bm2bNVQP+Mxw0chd?=
 =?us-ascii?Q?AGnF54gJdh2bqDraotS++yo5XbGwM8LfBvRRehrAiu4j6gOum7WvUrK1S5hC?=
 =?us-ascii?Q?oV4jPLgwoWIBR28Hg1d4j1ZOApylVxQUNSUxnhAsmBuF1hyw9O0i0dUDozLF?=
 =?us-ascii?Q?4OlVoNuw2303aXh310Xd+DaSVwwYpi5maKNvKZfNmeY73IDq3qRDFUKU0X5z?=
 =?us-ascii?Q?BqUdU167TRNowgFF5mVWFGKlcACIUgJU/618DnNorxIXnXvajxOJoQj18TCj?=
 =?us-ascii?Q?gybMTZxzifu0ME4Lgg8Pr5sKpEIsOjbtxU6ECVX+Qh9oDETabSItH/3R9q70?=
 =?us-ascii?Q?V8kfR7vRK0fuakLnLE4Mj5rJmr2R8fbbPPW/p9jgD8mKOElFRWsmrRfFBR+f?=
 =?us-ascii?Q?Nfr/LCl+jzLFLZmQJtoQQO4AuVYerV8p1lt8KfMbONMlt+JwnuvBG4UF4Hno?=
 =?us-ascii?Q?6OY37nNxG5VqFje6+7OHbaeXOL6Owa14wzDkWvLkzRNA32VXgHcK5N7SdrA7?=
 =?us-ascii?Q?oY3ea/IrNbwYQeIRbyyCZOUqMvGhV/HJMwKvA5YIZkU2dpFltjmmGgtzF7Yf?=
 =?us-ascii?Q?8HV2FIG+XasSDYnT9EzZjcwMyUWayzBeTVfr6/qHRB84uCl22jL0PdfDGnX9?=
 =?us-ascii?Q?mKhn2NFOJhoJSIbmWHkNg6P0SZoVxtn1FK7lFDDJkGbuGRMQHh/8yMUmSq7g?=
 =?us-ascii?Q?gLppcBzhpTcDoSm0GbdTe09swqpHsxaI2CUcDVGN0zDpQ8/iqEfMEq2Aqwiy?=
 =?us-ascii?Q?32++ggdZrkrhwI1+0ptUAOoOnDjzizAW5TOP4CcKXVrpaX+IoDwpP6zcbAOb?=
 =?us-ascii?Q?9P6Cn4X/vXYYRlsyJvVBruETP14PLHCIULOJaGfcGjRY0Ql1Z6/O76mk4cMI?=
 =?us-ascii?Q?6Y6gkr1NDSAH1zshNnNxH47TCiK31FwMbjbh?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aBf8EvlP++IaFw9h3qHF3oxS/2vgrxrv20H84Mw6dQskm/urOiVUNnVgEYv89yhAKlLC9ZeVauUYY95Tf5rLPOcNAiXgHClGsumacMlYA9ZvaaSe7Wk0pJqUEE7lNA/mMIMzL0+f9rYyUgbHXct0nQgiyIVm4Xyb5pIUDM1MgDmfXApbAEzjgyFSnpHVySBnm3fF13q1WB1vk6mATxo4bjc11HqPBvQpKtyAGNyJEUFNukyDARSuiw6A5V+By0MW1kuYA/v7MAWxW/dSGdLE9DkXTY5XaJwOhu6XaTTHqyyv1i5iuKEaDGdxHBqmm/0+9KpP8uLo+zs978pj2CDh4+rhMUIbrSZ81YPZKG5Rh14v7LHIH16K0DbXyJ9+2w0zCoSRs2YvbGn2MRGJ//I0CDb5J4sEYIMYdDpPG7WPnAs9zvlHqmvuGDHQbLZmsVj9rQw7qtZL+4WP24Km3R/CRf0UDFOeQhjLzfs0pzD10D0BWpc722FjLnG1d3Ry+vVttEN7KRf+yv2n3Rff8tSf0TR63qiuhCPvShM6V7tjG/oOjSrQPrDPGXB25FcdceVL+AYWVKAxfqZrLrqFX05fJC+FTalb5Bc8Pakw1E2lVOXSh9kqJ/a6Im32av+DE774T07RPicisB6udzS53aMDXg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:17:45.8195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c218145d-e863-4f28-6f5b-08ddeee27b8c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP190MB1833
X-BESS-ID: 1757341069-311744-22019-3575-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.143
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWFkZAVgZQ0MgwNTnJwMTSMN
 HIIiXNyMLMzDw5zdjIIi0lKc0sNc1EqTYWAF3RC8FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267336 [from 
 cloudscan17-179.eu-central-1b.ess.aws.cudaops.com]
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

This modification provides better resource (CPU) management for NTNIC PMD.

The following threads are migrated:
        * FLM update thread
        * Statistic thread
        * Port event thread
        * Adapter monitoring thread
Additionally, a warning is added to inform users about the importance of
dedicating lcores to the DPDK service framework when using the NTNIC PMD.
The code is also cleaned up to use pthreads and rte_thread APIs.

After this patch series, an each application using NTNIC PMD should
dedicate at least five(5) cores for DPDK service framework to ensure
proper operation of the NTNIC PMD.

The sercvice cores can be dedicated by EAL options:
        * s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores
        * S SERVICE CORELIST List of cores to run services on
Or with special API by application itself.
        * rte_pmd_ntnic_service_set_lcore to map a service to a specific lcore
        * rte_pmd_ntnic_service_get_id to get a service ID.

Serhii Iliushyk (7):
  net/ntnic: introduce service API for NTNIC PMD
  net/ntnic: migrate flm update thread to service
  net/ntnic: migrate statistic thread to service
  net/ntnic: migrate port event thread to service
  net/ntnic: migrate adapter mon thread to service
  net/ntnic: add warning about service cores
  net/ntnic: cleanup using pthreads and rte_thread

 doc/guides/nics/ntnic.rst                     | 112 ++++
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  27 +-
 .../net/ntnic/include/common_adapter_defs.h   |  15 -
 drivers/net/ntnic/include/nt4ga_adapter.h     |   4 -
 drivers/net/ntnic/include/ntdrv_4ga.h         |   4 -
 drivers/net/ntnic/include/ntnic_stat.h        |   2 +-
 drivers/net/ntnic/include/ntos_drv.h          |   4 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     | 303 +++++-----
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 306 ++++++-----
 drivers/net/ntnic/meson.build                 |   2 +
 drivers/net/ntnic/nthw/core/nthw_pca9532.c    |   2 -
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |   1 -
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |   1 -
 .../profile_inline/flow_api_profile_inline.c  |   2 +-
 drivers/net/ntnic/ntnic_ethdev.c              | 520 ++++++++++--------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  17 +
 drivers/net/ntnic/ntutil/nt_service.c         | 127 +++++
 drivers/net/ntnic/ntutil/nt_service.h         |  62 +++
 drivers/net/ntnic/ntutil/nt_util.c            |   2 +-
 drivers/net/ntnic/rte_pmd_ntnic.c             | 104 ++++
 drivers/net/ntnic/rte_pmd_ntnic.h             |  26 +
 21 files changed, 1073 insertions(+), 570 deletions(-)
 delete mode 100644 drivers/net/ntnic/include/common_adapter_defs.h
 create mode 100644 drivers/net/ntnic/ntutil/nt_service.c
 create mode 100644 drivers/net/ntnic/ntutil/nt_service.h
 create mode 100644 drivers/net/ntnic/rte_pmd_ntnic.c

-- 
2.45.0

