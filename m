Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3140CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 873D240E15;
	Mon, 20 Oct 2025 18:43:52 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id D2B99402B0
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:45 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020125.outbound.protection.outlook.com [52.101.69.125])
 by mx-outbound16-221.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUv3MQ7EEF7y0eJ/gFfCZcAnDEORJWqJkmYSyAPIrWYaJVVkr3cZB431ADkOeVDR2WEk9mJzZKbVWJ6tF40CSOO6QPID8JAhlAXwOe4H2lrA+X1fKNTR3OoG3Zxh+Bsw4QVfPfY62zd4fWCP9YtIvVYJVeAdotmIRgVhYomwS+Gczr3LGuI62vFOl/F8wPdeyPEPPm/y6W3lusLH9mpmYWzSLs8fWcQCcu2Y22lxNJI4Shtl0ibw/P6n6qFvHE/ZtJScnBvd+kLV7H51cSexpsVL0FMwCw+iSVLndH+6ylALBsmSl8+mUNnko52xLY5nSRQfX/wI4z5AAHNB3IhtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUvTVat/N23Z8wp6XmhjYanfZqEWchG7yAwX5ZqfhJU=;
 b=DNqEHJe3ZD1F4YqeIpSo3MYN8STU3+jX0P0s8nG037YPct9TcMuGl0fOtArPWvAgGTwV8LvJ5hio7BSG3DOUxsyXQ42unj/DBYURCLUF8JISZR9jOzfGdmXN0GWMoiaaK9q0XkMioWicLqEj1/mLXD2+bWUW6WuEgIxUQyyeEdy8yASgjiRS83Kcjg3HRXtc0F1flwiKSXp+186aUJd2R2G8I9I6DRWKJsJ76/QSEyKQiopc1d56iIYUT0ijr3+Q0/NOSoIMvss6buC82kzd6qFpoPd+n+Km7Py/wVSzbb6iUbWEv2uozmsppzfDIlLaBuslirJRRJwmcvLFF9ovIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUvTVat/N23Z8wp6XmhjYanfZqEWchG7yAwX5ZqfhJU=;
 b=COatmk+o8JBZEG8dQv5BIRPH8d+16Kmz8pwIsyQz1hmFNYr937CH0iYNXizX4QB+FVyiqdWTfvJhTr+o0B51exN5GIWpKTETuSKP4EUWqWUvuU9kO/dW87QE96Aj8OZqXXxaS3B8QcV+w4pGeUzoQ6c+NWtZo7rEHYoEx2K+4t8=
Received: from DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) by PR3P190MB0891.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Mon, 20 Oct
 2025 16:43:43 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::8c) by DUZPR01CA0016.outlook.office365.com
 (2603:10a6:10:46b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:43
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 05/21] net/ntnic: add reset init stage 2 for NT400D11
Date: Mon, 20 Oct 2025 18:43:14 +0200
Message-ID: <20251020164336.283664-6-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|PR3P190MB0891:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 68749d91-d098-46bc-4ab1-08de0ff7d4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iWSv9ELfKPDrTJ59qLDJVwZ4RqteUDaBzNB0pJTuJPZmp7wIsxVUE7+SrB/m?=
 =?us-ascii?Q?L9PsiGEzWoxKtu9PDTmnIqswETjB0fxGTUEcIb3tOzAJ8w6IHNQ2VDTQbNZa?=
 =?us-ascii?Q?0GfrUJwZ3HwOHZWSsgVAyxa4YrPCWTwaU+Qc5p3tqXbUB1rhB9O2hwF29G7F?=
 =?us-ascii?Q?MCQeVSTSTSSDOKL+EUxCNSbcWYKtZtX2H8q/xmLs2v4aVBBwRQO0HHInr7+C?=
 =?us-ascii?Q?kSVerQbxvyPJhQgmYS9xM9mCq2o3riY84bl2G7abDACpyp8QzjJcxFn9emK5?=
 =?us-ascii?Q?HzCRpJfMK8SSCH2YCFE9ELnqkmoPkZQ5lnVBnkPYYZb16pU5jYJttJsUYtbD?=
 =?us-ascii?Q?6Bz6w/vW2l4ev1bAZCxHr0b+GoEOXvRDI1DjcpD4INElV9cvS+7aT3D0tRAP?=
 =?us-ascii?Q?ETyCa+G7puEY68rVVvOhTQRjfsuffoCncORmrkDXLSfh3RrR5tszrIm3Kqbj?=
 =?us-ascii?Q?0E4ccfwoN7yFiWgUHhiMiBCHA/YUDObPK3sMQu9sDE42IBZ388NjaONL5rYK?=
 =?us-ascii?Q?uMC9EQ3I5eiKdrM9DOfxVJISVruvYcyZv4xth8+PBBFmliVYvKosSIVFr9OU?=
 =?us-ascii?Q?hLnO5V5CIPwJ6GUj5lO9T8jOI6xz1/aAuegEaGq7yEhj5z6CXLxUIAzsvotl?=
 =?us-ascii?Q?JrBDHXxnK6oEvXpNj/wEyFKldI2xOmkqngpoIFB3EM0pdNRQbw+ZOnx8nRCY?=
 =?us-ascii?Q?wxF9tBfYV9vJSu9+aP1wPqGeMtwco4oTHLNugDHGIM9kFz+ZNU4vc9Wl+k9C?=
 =?us-ascii?Q?Q9vxvN2+tXshynP9LGz/7SyMzaBu+kjC43ukJPQzQm/sEC13ULB3qPWJDgTC?=
 =?us-ascii?Q?RVhjaE7XmoQKlt2yqAv9KGtJl73nRjxXlOKzto0dRDhMpPBs6DJJAVk0uPEq?=
 =?us-ascii?Q?kQPcBu3Vzx64NWZf+uVnBxiFYav3A3lk8nAOCtiIRPavZdyJRVn6rZRLdXjW?=
 =?us-ascii?Q?PMxD3Doa/qgeys8ljiF/IQLoPUHtLgmjFcg9Kk+ok4430aZPgHQvpWhUVyyQ?=
 =?us-ascii?Q?d7l6iFc8eKvsLf77Lx/6mGOU4RKws3kh2lySELN306eksqljxkZQ0Rz3pXXG?=
 =?us-ascii?Q?38TZKeytyRKgjZqIdC/ca8H6Yk7kNq+FrHpa+9JuIpdXvsLl0Tc5RGR4T7rQ?=
 =?us-ascii?Q?qBUsrO2tCMc+4GnUcffEHtSYxapxdwfLD4xXjdrC9R7YX57Oakr9NdeYJa8V?=
 =?us-ascii?Q?W+XGBcHV8+og1XfMBXowJHBmyHgiBpvzcYNT2FZBCSpjw/KdSw5G8C+aLkwp?=
 =?us-ascii?Q?3Lj2Kus0Zg7RwRunxQDC2lYUBAyWN/RZhkkuK1rNULo9B9EcUCi2z2A4tVEC?=
 =?us-ascii?Q?qxF7fJ+25FldVYXx0BOympL72Y6dzZpi97RlRVPLY6elKmULmzFqD5042Mba?=
 =?us-ascii?Q?gwIIk8K1b9ZMniVI1/y7iCG7tzFGRMjLE6zPHdqcqDO2pRAi00U7LKQCxuwN?=
 =?us-ascii?Q?5d1ngOWDIVS72pC+auCvWkxbFM+h1ZixPCDxuhMwK1I9rUR1k5YaCcwUCJV2?=
 =?us-ascii?Q?qN5rG6sFlvCIUQ1lIF1V73zL9J32SVE6shA1CjoyO0CiJCk/SQLw5J5TCuq4?=
 =?us-ascii?Q?0nChxzULnJBGK25n5CY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JgIsx29Y4oIu7A9nLfkH9aSuIZ1WGFjgn1zDgQ8d+mO1yQ0rjFGfUGsw4F7xVU8O/3ip9lOdD4ZbD4C3PkKbtA+6rZCFML0JT0CDDU812Uk+d2HFoRzIef2Ujn2lprF2pAEDVuqfj+HiLPnTM+YxM19g3FO5AEz0xmK/zMME3euEnya+WyzhlHMY/CSOdbfdEC+qu792vjHodoUCsJo0LhGhomlqbF0vDLO1EJXYA3M3DlKkL+awyReFhVWp+/Hs7Nm2GPtsHtqa4Lb324cz3yU/i6fWhA+KcxB0RfsikuWUAR5YOjxGBJkQYmxCnYV/0HCZGDbK8VOl+fNZLdf81VNyntlrb/0uZwELGbsQ1A5ceMbNywGrbDKOXH9SaVOxLDqTmibFuaKRfr4jpwx2JQOuIAQ8BawqM2+EcB1T9QNp9k60Lpt7188eHYocaYGSrCUMrvp2xHFcxw1w4D7yhKT6r6/xTpyK19WSCoqe+qvziAmhWHGZKitCsSNqDAXnc5wXbmE6e7FUz0OTkgUI4JUwl/Abpx9/sqN9AkVZP2I41e0Rt/065xoexgzLFDxhbCDihPUMJE9N9o1UJlqg44EFUTg3+Ox3YB6JYohWIoIdoGcXB9dBCEODiE88GwJ/arWVW1iftEkNpGi88v7XMfjmKf3nH83/hgTctV2o6ng=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:43.4359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68749d91-d098-46bc-4ab1-08de0ff7d4de
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0891
X-BESS-ID: 1760978625-304317-25453-11877-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.69.125
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWBiZAVgZQ0CjRzMjULNXcIN
 Uo1TAxJcki0dgiOc3MJDk1ydw8Kc1YqTYWAKbR22FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan9-254.eu-central-1a.ess.aws.cudaops.com]
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

