Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68929CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 515DE40E1D;
	Wed,  1 Oct 2025 17:10:34 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 7DF4040DF8
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:31 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023102.outbound.protection.outlook.com
 [40.107.162.102]) by mx-outbound13-239.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJlagKzhrOFt8SxwdCs9c9ukwK5g6OXsDoXi4O7NQ6rWjweiYYM9gn6mko7JDuov10wh/R/RbOk1+9IR5uAZj+gunKovWeceFWyFx0JWrZOdSFDT5sCFhynwkzpWyfcCbAuqbXkWmuV3DirqhABXNX/JkrGuGuiGWXD8PMLBwzUZjnBJA4T8i0BEo/XI4+BRyAACcvfZAKlz+YBqj7xEwEV88TVX8s9Z+uaWsLgithzDHJ6mDpEHTY9hPhE/XO4ny4WgXd/N2lFRzfkHCOLq4jp1kW4jZ21+OAqMocTBuZlZvhmtGL2edEB7T+u84LbW6OuF4cXJQmn5SUEedTj+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUvTVat/N23Z8wp6XmhjYanfZqEWchG7yAwX5ZqfhJU=;
 b=bQEkCz2i/QBjt5xfCKu3AW05itn62ZFSNus/6NHtcr2iiqxuFyylrLpMHBu4dLmbjN/kI9w7lRyrI9aWXqsFv3J543mnDZGYBAGhi304522vYN8NLRXXvOsFs1LEkkDXTwA1vKtdyh/mEBanJNKINHpIdRfqyvZ8wRyXCS7yxaiueAaeasieJS81RUvZiWGYucP7/w17df7cN8pOqA9a78i04m2Jn7KvKgrb7HZo/qNGmmRm0PyFUQzwb7bRJYeQsYjhacbnBxDTnIgdavg1fUpXMKCjkftoLRvAVjheJaSrcQXX+y0gptJVJf3jopp/mAx7U683yY6rDO/CDLH0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUvTVat/N23Z8wp6XmhjYanfZqEWchG7yAwX5ZqfhJU=;
 b=BFkL9r1Ao+q2m8JJ3tUTmLw91LIOYeqr7JTRP5ym4x/aalucmTX9f5FbMv4ccpZ3QFAFx8oFwlsc0v7OZgRvOmeeY9u/Z9Wrg+FhEVHtTIf6Wn9vs7GZR8fsnfkKA8octtWts7sNkb+oXpaiHUg4PzQfPLHG0p2syShLfgHc+AU=
Received: from DB9PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:10:1d9::24)
 by GVXP190MB2180.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 1 Oct
 2025 15:10:26 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::62) by DB9PR02CA0019.outlook.office365.com
 (2603:10a6:10:1d9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.18 via Frontend Transport; Wed,
 1 Oct 2025 15:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:25
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 05/20] net/ntnic: add reset init stage 2 for NT400D11
Date: Wed,  1 Oct 2025 17:09:47 +0200
Message-ID: <20251001151018.250671-6-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|GVXP190MB2180:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 07e96e11-013c-47ab-d039-08de00fca6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fkr7DR01knUzYaZ9FfHSPZ9ajuwSwFq/pddSqa2eSwYrOr5xJymjnFuVAdMK?=
 =?us-ascii?Q?Iuk0gg4zqI+SiOEUEB9MsHjMYL1kPwOCXlAvCm8gcYZIrMUZDZwEA6kn8np3?=
 =?us-ascii?Q?0ZDAOvr5NCqtdxXYy5uA6fYrmufKB1aEU/Z5o9TexM8gSlsNgFQxsoJWka3u?=
 =?us-ascii?Q?em55gIfbIUsJHIWHbulSnyeFviwx5G+juVeCWs15hizHDfHVC+Uk2a9zX1Hz?=
 =?us-ascii?Q?8DkQKMqtZKOu0AtLu900UjVP3c8uMN709i7ymDKNdci6fwej4s5ALJO9VrLa?=
 =?us-ascii?Q?NqcEq2hFz28g5hfXqzL5tSGU9p7xaDZWFP7CF2dvK1pHW6Y7CpMvRVxMYivx?=
 =?us-ascii?Q?3aUj4k6A7GDs+vCBVKgomyYo3N8QItb+8/cLd/SXaUtqkMf/pLz6DzaF5fYH?=
 =?us-ascii?Q?tgRQGEvVQ250Xo2ai+O1zxS48UJ2vabmkMw5dbIqNU3HIeo0hRJRR7UzVwD9?=
 =?us-ascii?Q?YA0+eNc/hqhrjBPBkdB91tJQBtVEz/Mjim+Za3IbAGUpNEryvnZXmQkvBmG6?=
 =?us-ascii?Q?H8EqSobmzuxS7L5Pseo1icb6D/jjN7+6jk9QtvUUdqLGAFQMT+9VUQzaQuPM?=
 =?us-ascii?Q?9Su6X2Elvn/pO+Jx5RsT/DjNOcKuMhPd1WBeCP/NuqBsZDikD2YAKBBizd5X?=
 =?us-ascii?Q?9H7S5ya7pKJ68J3u71UQ4MK/CLVxT5XtVxtXrUXZPrkf/wnFxHBLnf9LRRkx?=
 =?us-ascii?Q?R16267+80JDEE3qeF4KT0BwHbin6SfLUa7JU8pKdcnE97iL9SKSVbRQY3Pol?=
 =?us-ascii?Q?aMeIc6GoB6gCUPwwX1sZWXzAh4PLVWcjsakpvX3klmD5z3dDsTOiJMSmU4xL?=
 =?us-ascii?Q?ZHMN4r4QQDESmVwJHjmE2n2Wk2ZxOdnlIn/l5wxy7o/gcTz8/7R8btAye2zC?=
 =?us-ascii?Q?P7RQEPQj2b6twfKmax5T+qjqVo6gwzaLl5f1h9/EnjsZlCMsAnX9iph9+ipj?=
 =?us-ascii?Q?HcW3J60qUUiJBfFMWb6vOpgvQ4IkxYyjTKD7D1GDtDVTGtVNcFvz1Eh1Gw58?=
 =?us-ascii?Q?v7aobXV++PXtyBA2LUw50PGl5JbFSTnPl7MVyMY+bo90LRDhsHsjz504FhW1?=
 =?us-ascii?Q?gkwIaR60qp4FaTdKE/4D9i6jiPa+YSkM0rZT2QvYLJoyrYZtERYS4wK+Ozm3?=
 =?us-ascii?Q?4HphLnOetqSAfzxiyCFi9NNhjMNPnoOky5RHtjwSAgcEhtpd7rCT8IbsBKK6?=
 =?us-ascii?Q?QhcTSv/qWqu9V5urM5IVhFpD0Kxid7NaksBJbw9L6YYL87ZP9Lt29Ij5/DaB?=
 =?us-ascii?Q?XOxqrKK6WzNLxhIhLG+GOtmzQKGiPxUXY2Ol0mjrTGJLvI4t5y1ieNw/NSJM?=
 =?us-ascii?Q?4jJPbbR6ozhmi2Ho8vclhMcaxmMaMzACtCM6b4lue3lRGTCrejYeg/iLmrhN?=
 =?us-ascii?Q?78hftYjLh3gODUw4SuyS62MK38Nmrvufqi0csuIm2P5ezDkP37Zk2mR+7xXO?=
 =?us-ascii?Q?aCI/za9RmsqVC+Onrt3S+kdcTS8JBKlFLiBNSm3gVXwt/o9a+2wo3Yndg3ZW?=
 =?us-ascii?Q?SLsrNdmmo5sv8ypYrhDAth0BpmdbfZGjtEX6jRMKK9xKID3GijkuuXb9RP+z?=
 =?us-ascii?Q?uAuTyOVrs/BELjZiGFw=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VS0VSl3EvD4gaoidpXV424y5ZZ4na9yeA5hYVbr5NNFqU+sP1J68NKFBZ/laJNUblEFtkMLteMq1kaYcVRFee+GntlTiV5oFcFok0OYB5k+Jg2Ir0SaTTeu31OvFgW0DdVcPrj7alAyFgCf0w7c6DZRTbFi1GPdzlkstzX25mFFbPJRG0k9qZe0IcWxSunnhsb7Aj9ACyXM0gX22Fm+aLXXC4nx5pKXdcmStj75sWJXdUWtpiEWADenbImWP1Hhhu6N65Zt4zJGWYtGIHA9piDrn7yl8ioMYptORNy9J6Oenn9nMQF/gO3hhlXrxMIAdHn9eqD1BdL2FTHyiD0eAlVcvpI6euKBngrh239S6FKZ02r+DWrrjXAGEOJEJFbOeAxcO0Ska/Ds3YMG4XwHdpMDGYv5bIHWHXMGdEl9shRNegOJWrFcfds4SaoCC6M3LW+g6X3T+Pa7Ki6wg3IIF2neJDckRQdev/he/h2GZRh8FkffRxEmoTMBr5s2Ax3M+Ip1bgBncuiY7ywpJYX4fB8msH1GgQa4pz21L7JWZgvM3xl4eHDgLtWTz1AgNx0PptbQQyWxjQ7eYaLFmnqWTte5ABuJc9LowD/SNLAEBE4/2rRNCWZut8dw0Doh+psIRD2aK8fsdFB8qZpQqmixoeA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:25.8743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e96e11-013c-47ab-d039-08de00fca6a9
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2180
X-BESS-ID: 1759331430-303567-7600-4428-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.162.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWBiZAVgZQ0CjRzMjULNXcIN
 Uo1TAxJcki0dgiOc3MJDk1ydw8Kc1YqTYWAKbR22FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan16-167.eu-central-1b.ess.aws.cudaops.com]
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

add DDR4 calibration complete.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 4205e539b9..5e127ecc86 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -79,6 +79,54 @@ static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, u
 	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
 }
 
+static bool nthw_fpga_rst9569_get_ddr4_calib_complete_stat(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_stat_ddr4_calib_complete) != 0;
+}
+
+static int nthw_fpga_rst9569_wait_ddr4_calibration_complete(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
+{
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	uint32_t complete;
+	uint32_t retrycount;
+	uint32_t timeout;
+
+	/* 3: wait until DDR4 CALIB COMPLETE */
+	NT_LOG_DBGX(DBG, NTHW, "%s: DDR4 CALIB COMPLETE wait complete", p_adapter_id_str);
+	/*
+	 * The following retry count gives a total timeout of 1 * 5 + 5 * 8 = 45sec
+	 * It has been observed that at least 21sec can be necessary
+	 */
+	retrycount = 1;
+	timeout = 50000;/* initial timeout must be set to 5 sec. */
+
+	do {
+		complete = nthw_fpga_rst9569_get_ddr4_calib_complete_stat(p_rst);
+
+		if (!complete)
+			nthw_os_wait_usec(100);
+
+		timeout--;
+
+		if (timeout == 0) {
+			if (retrycount == 0) {
+				NT_LOG(ERR, NTHW,
+					"%s: %s: Timeout waiting for DDR4 CALIB COMPLETE to be complete",
+					p_adapter_id_str, __func__);
+				return -1;
+			}
+
+			nthw_fpga_rst9569_ddr4_rst(p_rst, 1);	/* Reset DDR4 */
+			nthw_fpga_rst9569_ddr4_rst(p_rst, 0);
+			retrycount--;
+			timeout = 90000;/* Increase timeout for second attempt to 8 sec. */
+		}
+	} while (!complete);
+
+	return 0;
+}
+
 static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -100,6 +148,22 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 	NT_LOG_DBGX(DBG, NTHW, "%s: De-asserting DDR4 reset", p_adapter_id_str);
 	nthw_fpga_rst9569_ddr4_rst(p_rst, 0);
 
+	/*
+	 * Wait a while before waiting for calibration complete, since calibration complete
+	 * is true while ddr4 is in reset
+	 */
+	nthw_os_wait_usec(2000);
+
+	/* (2) Wait until DDR4 calibration complete */
+	NT_LOG_DBGX(DBG, NTHW, "%s: DDR4 calibration", p_adapter_id_str);
+	int res = nthw_fpga_rst9569_wait_ddr4_calibration_complete(p_fpga_info, p_rst);
+
+	if (res) {
+		NT_LOG(ERR, NTHW, "%s: DDR4 calibration failed", p_adapter_id_str);
+		return res;
+	}
+
+
 	return 0;
 }
 
-- 
2.45.0

