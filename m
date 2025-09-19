Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7197ACAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:22:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 699AC40E12;
	Fri, 19 Sep 2025 11:20:40 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0807240DF8
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:37 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022093.outbound.protection.outlook.com [52.101.66.93])
 by mx-outbound46-45.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWLlAYhAgPftRwWwisY68J1PavVdXPiZ1VTWoEGHYx3+MNn2HOq7lUTvnYnDARkzujSeHiCyiAFtcRLlimfLC/EYQ/u7HVUex4yL7HV4lX+sa96uxCS2sJBPCEwk/UREdAZjzxyns0AhUKoHD3SZ/eY3G5cz9lXX8ojVOOy9xgR2HbUU6d0QnO5WpSEh5eKFs7d7byXHrFk2Ve2T7L2TPrk7QEg+R12hS09zFHiFh2yJJ4WNGEVj4lIdnu/WFT9E3iWQ4IcsYlFcs2XjuGZLlUXgZ5bmhyPaqFRhEt+PEtMvIbiYk7ZZOFXn0wcxBwQlMnGqLgfq4L2uEHBM6V1qqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvnyTMJE1N1viL/cjTNlh45DPM5b8QtXLhkWBernw30=;
 b=uUyoJT0r3mtjxy+Aot9NQGwGbwIO2AuJ7gEdaiZVCcXBTM/bCy6eEgqRsiwV7hzfzlfyEDRx0U0/yrpiWrg84e0w66kEumU219WyT+oP1D6O7ylaDtjsCMiPtB7HJiJVZs2HrN3jJbSEcJqyCjGWRveVlE3eMyVGECQKM/WPQbACXyd72S79W1Sv+368RUTXtKtTZCKpJnAbUvAU6XNUWZKmKFruRgWU5yIAFTLOGIQL8SbNGWjOQZHxdC1Et8wn+CcpUPF+w1mCcvP2sy/pYB+wX0967UUBXQR99LeOg/pPRGzoEhUG8o1IcyiJeTyhKTi1fw5kp/z1gW5U+gxlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvnyTMJE1N1viL/cjTNlh45DPM5b8QtXLhkWBernw30=;
 b=nlMh+k+OnUbZNluyitFJMxtQiLsthVfYnsxP9UjjrufJDthdYHCEjkzd9LavwE6hWocIFBBtJJEY+BGCS3EhCYVYgXlCSVQx6LfaJjN/PmXhO44WR3xiEzUNAt4uWHPB8kp8CzGINNe8X1zdxW7+Y33Ulggql0VXBFuzoHbIidU=
Received: from DU2PR04CA0342.eurprd04.prod.outlook.com (2603:10a6:10:2b4::21)
 by FRWP190MB2675.EURP190.PROD.OUTLOOK.COM (2603:10a6:d10:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 19 Sep
 2025 09:20:18 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::4c) by DU2PR04CA0342.outlook.office365.com
 (2603:10a6:10:2b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 09:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:17 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 08/16] net/ntnic: change prefix ntlog_ to prefix nthw_log
Date: Fri, 19 Sep 2025 11:14:53 +0200
Message-ID: <20250919091504.1548351-9-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|FRWP190MB2675:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ed9f8f4-0898-437b-354b-08ddf75dbff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4kU7Bl4wozH6UjD9t9u/kDH2UQA4NauCkV7pSWn+f4f594py/Jfpq5ZyvWQd?=
 =?us-ascii?Q?IwsXSpqg2NPITzBepJbHmv9EpLlOnc+qRmq9iDUAWJoznpuVNZZ+aqYrwcVo?=
 =?us-ascii?Q?RrNSxkaEmBe45sRbHbnLkg5dR17TIVi31J6PV1cQ4wEFx3RzglkwvwovEJ6S?=
 =?us-ascii?Q?uRji6x9Uuy/u9M1d1I4+ZmU3YwuYf+1CKlhDbwd+95ZSROyqhixrzDYZ4za3?=
 =?us-ascii?Q?nm/X6HgIuWav7+qRD/WTz5/tKjfFkI3Qm9CGxYQVUSzyh4aqX7fFmVFZnE7X?=
 =?us-ascii?Q?R2gpe0cB39xh0BJbhVXX8CpTjzeZFwboM2ee3WEUioY1MIyPCBu7Seitzutr?=
 =?us-ascii?Q?C9nsiZlI53OdnUXzcAYZANG8OQSGez+EYYPGkhF3p20SHkgubO8iK8qNeQdF?=
 =?us-ascii?Q?sWS3MkNILQSloCHtxPChIWo6D1u/srGeviSboRsmiyMgY4RROFfEl0RO2G/n?=
 =?us-ascii?Q?apVTvb3514MExd+7GLBgKmAlystf6RTCb5c9VNa7MkcHVHfSmBbAgPneGlir?=
 =?us-ascii?Q?E1/axPRo/7XMOagqzOTJOBNV/OYO3qStHMsFAj+jHmBz284S7k6mNNgR1oFE?=
 =?us-ascii?Q?eLTLWNnMzqUfsx67Kj1umOMsllIh5ck/aisky1F9CbeYBWm3zthGO71LhDc/?=
 =?us-ascii?Q?QhIhWI+1Xd5TsWT8hitPdyR7py1o/QI2Zg65zhqq0491FOMT5nm6JRWsSyFd?=
 =?us-ascii?Q?jjK7fbz4Qw5UKSQIxkcsOgQOUtDkA+il+8AGpgfVNBov1fDgIiZy3G9obN+U?=
 =?us-ascii?Q?aO1Kc9FLj/x0u0Pp4F2T3IufZjqqzTRKoscYSPulicxnx8Pz5W7iXfyzdiJM?=
 =?us-ascii?Q?s6qxGMk6skvQ+P7HYmkmVcY7/0gsrh7UO/9X+PEwg/MYc1TZeK+wGNJPKDPJ?=
 =?us-ascii?Q?f9cb4sY2xZGo1eXpLGnUc5LB4y8P9o+tE5n6KmuCjs2wJU3MEk3FkYbW85i7?=
 =?us-ascii?Q?oM6vvOIY6DeoYG/8v9ZrxVXtZ4V6aZlieVQSSrVMKGaTpGFv9LeqhgU1ttJO?=
 =?us-ascii?Q?cz9F9hlSCk9TIA5rpAPGsLtKSQZQMFqRJdbZ+Ft9wkt6tHcbEClT7Aq5gB0b?=
 =?us-ascii?Q?mTod3EXs/04a6jGmKJqcB+8nmW61fh4wMiJLc4Lhuz29aaJWQS7b8aHMbjUP?=
 =?us-ascii?Q?hlNRlafJvC4IuIxEr1OIDXQbADo8ya+1fgCErFZ3iCgmKFdIDmaK/x0L01v/?=
 =?us-ascii?Q?mIU/lTo/ckLrbVkXs+aFyHhwcSp6EVglB6DBxMuhMeAxraV2Isg7aI3NlBEi?=
 =?us-ascii?Q?RNtMXyr68AvgRkIGcq+DfQ9IwjP+0TTw0SMv69kP98778t47kEN/5WerK7NI?=
 =?us-ascii?Q?Gf9Pj/70rxkdAy7bqV82ceF6pq5oCnKD4F69iuwdDbkzOXIXhEPjSOHoSYhu?=
 =?us-ascii?Q?cM9mIXFagr1jEN3CV69f2pqMc7O4fJBkVhCCFqAQfUGxq+NvNX9IcVZ2tJKj?=
 =?us-ascii?Q?kVLCPAGByJse3zWp8aG06eLxhLq/NndpIXqGuCBBTiSn+9C2NCfm4u+nULk8?=
 =?us-ascii?Q?VRnMpfup8d3zR1uFgpRpLArYEwYIZCobvOCZ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LFM2HknkX3Ciqc6PTspUKOs9p9r1FceoEfP2Y5oqYTLqdlY2er/pwCujcJsEZDhQOFhLomXH2jVAK2yNfpSpPZbRKg00td7+grdWmFJrFNAivhVy4Wjpuvo6WQc0W5Kq5hmcBanGzKmiLdL1LBCmjeR8cwp/NyP0rZItBLqQ1sHg8p6A5MqkRTIRevO33nMJ4R1tAB3wlucCujMrkomJ0FRqxHO+lgcYWa+DtXDCwjYMR3QYdPIZ88E6VTC58Wo/ZdH1hhiBJBYc0EcLHnGE6+2PIm39eBP21xkyhz5MKBuUkWFure80voedYY2ynUmP4pRwuL3+zcYopayIz00QMzjkZEec4CpP3PrzZP9JqRIjlM3VQB7eU3Eb45KO0O77rT1L0/BSDF32H1F6J0EIxvH5rFTTGsHYvyd28Dy6pj6uWWAKWXsZYH9tBRTHAuWBioTizKOwMQ5p9KpEk0IsxVaFgrgsbP/paGiIZsk0K0ZfOI39Dcj0YUdoxcrbbl2fp6qF6coDg4bQT1Jdo3E8uwLRa8BzE8qX9jiGADSeHePEE0saDDVPZwLHLZbakD+8jT5n6NcTv5pc666PuZn3IWBZQ9hQQypSO/XWrzUEva+9c3Qg6vSnlTZZV+pfhpGJLekD+xnNfpsa4/u0Ofdpeg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:17.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed9f8f4-0898-437b-354b-08ddf75dbff7
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP190MB2675
X-BESS-ID: 1758273620-311821-7627-1088-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaW5kZAVgZQ0MDAOC05xdLYwt
 DUKDU1Ndkiycgg1cjUOM3Y0NzYIDFFqTYWAG9GKjNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan19-0.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

Change prefix ntlog_ to prefix nthw_log for logging functions.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../net/ntnic/nthw/model/nthw_fpga_model.c    | 20 +++++++++----------
 drivers/net/ntnic/nthw/nthw_rac.c             | 20 +++++++++----------
 drivers/net/ntnic/ntlog/ntlog.c               |  6 +++---
 drivers/net/ntnic/ntlog/ntlog.h               |  6 +++---
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index b9d03b4982..1dc604fe65 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -727,17 +727,17 @@ void nthw_register_update(const nthw_register_t *p)
 			uint32_t i = len;
 			uint32_t *ptr = p_data;
 			(void)ptr;
-			char *tmp_string = ntlog_helper_str_alloc("Register::read");
-			ntlog_helper_str_add(tmp_string,
+			char *tmp_string = nthw_log_helper_str_alloc("Register::read");
+			nthw_log_helper_str_add(tmp_string,
 				"(Dev: %s, Bus: %s, Addr: 0x%08X, Cnt: %d, Data:",
 				p_dev_name, p_bus_name, addr, len);
 
 			while (i--)
-				ntlog_helper_str_add(tmp_string, " 0x%08X", *ptr++);
+				nthw_log_helper_str_add(tmp_string, " 0x%08X", *ptr++);
 
-			ntlog_helper_str_add(tmp_string, ")");
+			nthw_log_helper_str_add(tmp_string, ")");
 			NT_LOG(DBG, NTHW, "%s", tmp_string);
-			ntlog_helper_str_free(tmp_string);
+			nthw_log_helper_str_free(tmp_string);
 		}
 	}
 }
@@ -780,18 +780,18 @@ void nthw_register_flush(const nthw_register_t *p, uint32_t cnt)
 		if (p->mn_debug_mode & NTHW_REG_DEBUG_ON_WRITE) {
 			uint32_t i = len * cnt;
 			uint32_t *ptr = p_data;
-			char *tmp_string = ntlog_helper_str_alloc("Register::write");
+			char *tmp_string = nthw_log_helper_str_alloc("Register::write");
 
-			ntlog_helper_str_add(tmp_string,
+			nthw_log_helper_str_add(tmp_string,
 				"(Dev: %s, Bus: %s, Addr: 0x%08X, Cnt: %d, Data:",
 				p_dev_name, p_bus_name, addr, i);
 
 			while (i--)
-				ntlog_helper_str_add(tmp_string, " 0x%08X", *ptr++);
+				nthw_log_helper_str_add(tmp_string, " 0x%08X", *ptr++);
 
-			ntlog_helper_str_add(tmp_string, ")");
+			nthw_log_helper_str_add(tmp_string, ")");
 			NT_LOG(DBG, NTHW, "%s", tmp_string);
-			ntlog_helper_str_free(tmp_string);
+			nthw_log_helper_str_free(tmp_string);
 		}
 
 		rc = nthw_register_write_data(p, cnt);
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index 4845c2b0c9..a2a96794da 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -654,8 +654,8 @@ int nthw_rac_rab_write32(nthw_rac_t *p, bool trc, nthw_rab_bus_id_t bus_id, uint
 			char *tmp_string;
 
 			if (trc) {
-				tmp_string = ntlog_helper_str_alloc("Register::write");
-				ntlog_helper_str_add(tmp_string,
+				tmp_string = nthw_log_helper_str_alloc("Register::write");
+				nthw_log_helper_str_add(tmp_string,
 					"(Dev: NA, Bus: RAB%u, Addr: 0x%08X, Cnt: %d, Data:",
 					bus_id, address, word_cnt);
 			}
@@ -669,13 +669,13 @@ int nthw_rac_rab_write32(nthw_rac_t *p, bool trc, nthw_rab_bus_id_t bus_id, uint
 				}
 
 				if (trc)
-					ntlog_helper_str_add(tmp_string, " 0x%08X", data);
+					nthw_log_helper_str_add(tmp_string, " 0x%08X", data);
 			}
 
 			if (trc) {
-				ntlog_helper_str_add(tmp_string, ")");
+				nthw_log_helper_str_add(tmp_string, ")");
 				NT_LOG(DBG, NTHW, "%s", tmp_string);
-				ntlog_helper_str_free(tmp_string);
+				nthw_log_helper_str_free(tmp_string);
 			}
 		}
 
@@ -840,17 +840,17 @@ int nthw_rac_rab_read32(nthw_rac_t *p, bool trc, nthw_rab_bus_id_t bus_id, uint3
 			}
 
 			if (trc) {
-				char *tmp_string = ntlog_helper_str_alloc("Register::read");
-				ntlog_helper_str_add(tmp_string,
+				char *tmp_string = nthw_log_helper_str_alloc("Register::read");
+				nthw_log_helper_str_add(tmp_string,
 					"(Dev: NA, Bus: RAB%u, Addr: 0x%08X, Cnt: %d, Data:",
 					bus_id, address, word_cnt);
 
 				for (i = 0; i < word_cnt; i++)
-					ntlog_helper_str_add(tmp_string, " 0x%08X", p_data[i]);
+					nthw_log_helper_str_add(tmp_string, " 0x%08X", p_data[i]);
 
-				ntlog_helper_str_add(tmp_string, ")");
+				nthw_log_helper_str_add(tmp_string, ")");
 				NT_LOG(DBG, NTHW, "%s", tmp_string);
-				ntlog_helper_str_free(tmp_string);
+				nthw_log_helper_str_free(tmp_string);
 			}
 		}
 
diff --git a/drivers/net/ntnic/ntlog/ntlog.c b/drivers/net/ntnic/ntlog/ntlog.c
index 7b7f583364..1ee0f40286 100644
--- a/drivers/net/ntnic/ntlog/ntlog.c
+++ b/drivers/net/ntnic/ntlog/ntlog.c
@@ -16,7 +16,7 @@
 
 #define NTLOG_HELPER_STR_SIZE_MAX (1024)
 
-char *ntlog_helper_str_alloc(const char *sinit)
+char *nthw_log_helper_str_alloc(const char *sinit)
 {
 	char *s = malloc(NTLOG_HELPER_STR_SIZE_MAX);
 
@@ -33,7 +33,7 @@ char *ntlog_helper_str_alloc(const char *sinit)
 }
 
 __rte_format_printf(2, 0)
-void ntlog_helper_str_add(char *s, const char *format, ...)
+void nthw_log_helper_str_add(char *s, const char *format, ...)
 {
 	if (!s)
 		return;
@@ -45,7 +45,7 @@ void ntlog_helper_str_add(char *s, const char *format, ...)
 	va_end(args);
 }
 
-void ntlog_helper_str_free(char *s)
+void nthw_log_helper_str_free(char *s)
 {
 	free(s);
 }
diff --git a/drivers/net/ntnic/ntlog/ntlog.h b/drivers/net/ntnic/ntlog/ntlog.h
index fd839e5cff..810b07efd0 100644
--- a/drivers/net/ntnic/ntlog/ntlog.h
+++ b/drivers/net/ntnic/ntlog/ntlog.h
@@ -65,8 +65,8 @@ extern int nt_log_ntnic;
  * to use when one single function call to NT_LOG is not optimal - that is
  * you do not know the number of parameters at programming time or it is variable
  */
-char *ntlog_helper_str_alloc(const char *sinit);
-void ntlog_helper_str_add(char *s, const char *format, ...);
-void ntlog_helper_str_free(char *s);
+char *nthw_log_helper_str_alloc(const char *sinit);
+void nthw_log_helper_str_add(char *s, const char *format, ...);
+void nthw_log_helper_str_free(char *s);
 
 #endif	/* NTOSS_SYSTEM_NTLOG_H */
-- 
2.45.0

