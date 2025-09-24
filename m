Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC1CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 313C440E21;
	Wed, 24 Sep 2025 16:42:31 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id D0F3540A89
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:13 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021094.outbound.protection.outlook.com [52.101.65.94])
 by mx-outbound13-221.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWPFdFJz+k5jJz+RgwAlfOKVsJSzmTCjv/niaEovBUxtUoQErlnBoPQ4yog8A0p/gwzjpsw/67DZAtlWu+6dJaqPI8ycdf0VB9zcUQmSEspNx7HDiYBTYwBBUUI+sqE4+lrVIa6+E1q9/oFFCF/3Zn3Fymr39wmv6bEGK3e2BPgF5vT43NP4j+M5hJKtgbuOPV2FVAqw8h1bCXkxmvvFI2WF84jI0iXkTgX91tHUht8IPEKvkE2PMdhlIp3dCryI4Gq7YY4hNemvtCRYKnyLB2F/LWkirnqwx6ZBXuChI4TjJqTK0UBrIo9fCHdEaE93T29nLOB4G18tEOD7Cja7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvnyTMJE1N1viL/cjTNlh45DPM5b8QtXLhkWBernw30=;
 b=Kgm9kJh/cpRg1limG2uv52LgcBAm75Tvr6j+gWF9RBgXiBL08LO9HwvW3SG2VJAjqHHw9YfZJuTA4LMGYYMxTb0gn9SlRxnnmC8tYzZ4VjOqs9NPSpZmKveXrKhBk3NGoQ4dPHMAENrjEQeudKFCLvE52vx8O2gFohcSs6OxtE+vdHtSsF0BndNhvRpw3QpBS+4fH2VTMphJ+dUqkE0NgpPSgv7dPdtfhbeOQRqQfWyD0hfv8w2j02ChSwbNg/rgy2Zg9SGCGLxsWEnSZAu+ch7qgNFMkCLVLQ6VC2t/yn4JVY9OsuG3J+Yt/1cfW7JorJuGL5tu28iJO6gQ7+AJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvnyTMJE1N1viL/cjTNlh45DPM5b8QtXLhkWBernw30=;
 b=R3FH92W2GkjujD0R9TgW2wEUmNi+DQ3c/H8CKn6uQi4BxdPoCIVN0qmCumvhJVLrQc7LeR7hzmcpYDPnHSJ/Ou5Ri4Qzbq6hLEKWzPV4QePL782zQxMsSimWs2vd2H3KPwnLdyKaQy2FvnoEjz+fZiXjsMt6bxg/EQG23gWFvsA=
Received: from CWLP123CA0231.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::17)
 by AS8P190MB1255.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Wed, 24 Sep
 2025 14:42:11 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::34) by CWLP123CA0231.outlook.office365.com
 (2603:10a6:400:19f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 14:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:11
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 16/24] net/ntnic: change prefix ntlog to prefix nthw
Date: Wed, 24 Sep 2025 16:41:39 +0200
Message-ID: <20250924144152.53203-17-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS8P190MB1255:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b12fc34e-c786-445a-8373-08ddfb788b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ITmDoD6bsPNKnI85P0mxv8HSYRRNqDMx/o4aOLY1nufqj2ZrN9nnSTPxdi1y?=
 =?us-ascii?Q?YlWbgfbSKPz+mvd72uS1jd0rIr0D9o+Yk2JktYqqrAkF07Qy1asz0bycGL5f?=
 =?us-ascii?Q?Fqrp3/tRlqwD0kHK4Id0XUbhBWvYHSThcNP25vCQBpC4a1V2oxyP/F1OnFKr?=
 =?us-ascii?Q?fQyz3jQ17T7wOdKvq7H/kHj0pkSwUsG72RLmryKzfb9iBJtXbuQRP+18HM4p?=
 =?us-ascii?Q?aDclJ4PptQdnPrRR4dZVULc3SchDtIP5G0YY3Q6cm3hmCThH1ZmL5tNqlVN5?=
 =?us-ascii?Q?kf6NQmjkF5mF4Td5oQ0r2slMkp0TvezORLbGU6FXxQqAWS/rrrH6XGo0IzvZ?=
 =?us-ascii?Q?2A0bru6xqKJh34XoE/2HOFZNZS1JMazrFIfKA4fZgHuTEKLWJ7/AyXJGcyOz?=
 =?us-ascii?Q?a/fNg7rqp+rvLdtZw/jORl+D3zHaRkqj3B/IhacPKmGuuEPTd7jDf+k4CDzf?=
 =?us-ascii?Q?1Dxer+zbbL2wHHIDZ0P3kVt/oaEiJPTgjo0+oXaqy+SthMMAp+xK/xZtxkhv?=
 =?us-ascii?Q?ngdlyIK+W1Dl0AGKsuEjR1pwUK8dNBmcQNZgoU9PeU/Wm9ELqb3DAvikJ7sg?=
 =?us-ascii?Q?Cj3NzdJCv1QmtK7uDr6xhpPSdRy32a1rq+Uz4srDq+mmHAJUQVbMJsF0t2hV?=
 =?us-ascii?Q?zXRMwE6cnIU0jWnjjvMDD5tcbV2t3UrQw0oe/2ZujgPqO4sHVLU93VtqHS3W?=
 =?us-ascii?Q?kuO2wfVj/zaSpqVFU4fnUmYQIObFd3lXoGySqX3UoeJ+Ofxg046JRTdiWfsc?=
 =?us-ascii?Q?+AbfxWTOIe/IVp9BWAAOyl6EBcRIKu38gcevPd7U186hWe57PZa4RXJWoccH?=
 =?us-ascii?Q?iHORIOs52KVw4BWzp9vJK5Rx2BfWI01aaZw0PLwyN8wteaKW2ekKz/NEUeVo?=
 =?us-ascii?Q?vFyQiRolVniACBdlfo93MfI2CM9dgsqvk9PVMdJW3Tnj+dZh/xaO50Ui4QdE?=
 =?us-ascii?Q?JH+AA5gaGcXAW2SESCTR9iiREh5rwnomBEE0V4Q0gTzO7HFfxX6CpN4th09Y?=
 =?us-ascii?Q?J1rUa9yk59uhSLXIn+U6KUBkh4DQXTMl0wA8/wQ+jEvPjOMQvKer2+C/tXDj?=
 =?us-ascii?Q?76X7+iQ6Rrhzi+ZI2IOSy2LyPmN1IADPb+1Ui1iwDRsNpgVlvIvff9eqYnEJ?=
 =?us-ascii?Q?r7DpJbTCJDhFr2yMT0J818xfRO+XgO+8lkrEgq6kPqKw0jl/Hw2HKahWw6Rc?=
 =?us-ascii?Q?188SNrT1Nx434nkkOqWQDQPOU8vfdyG4Ms6S4FflMcTisURe0cbL+Am8jfcL?=
 =?us-ascii?Q?bjuuM5KXcVaYYqXKfs8QOJ+6q8Rz1Ls/O60JNX2yJg5l2zblpzJD6X1C4upn?=
 =?us-ascii?Q?yZCBLp8zeXXeMwXg2LVDhljUu5kXX8Y4PxN2uruzjRT+0oujrzOt2xe0mdyA?=
 =?us-ascii?Q?rInHrfJ3Gn2WVYCwEaEzlXCZSUza+RyIkdYhUOXy9EQgBWjRKL6YxDr6Q1R4?=
 =?us-ascii?Q?Nsm4LwWCx/QoJkPDrykfdOq7gzV0Mafbf8+BanzX9Jqiag8y3mO6P6G4Wmn6?=
 =?us-ascii?Q?IP1l8q7MVxl0d7gz6EYVRzPJXvBEMx5CvRew?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yElNiNiPeggjupET3FD4Wk3HJAgKm+PLCHsWh0YRG0xpLb12HKt3ORxAndJEekZ6+MBthxXu+c51de0BvVaPt+aYOZoaul95glrfa48sQj1BMl91di7RzsDatlRAjlzCUJ+wup9CWq0QZpAwX4IO0Iz1ZHoNj0rgxBkmfcrkvpiPcovjSEjxyqrNyobf+nVfQyqUpyAihXhVSwefC31XZhrVHpga+eeoZlnIgDWF9+FXjT1hj9h2v+4CylVRXAsG4a8gMEiVZJa9J1O1OEHvF2s0ThQtJRl3uskiDl+3AKNMhoEDwAbHTBF45UjIcY30Z0xw2rXldUj5C8FM5djaUIxXeDoh25K1BWlm99C7SZ60ToJufF5H0Z37UnA8fkThttYIEU/RIt6HsgrsK+eVj0seW/dTe2Ftx82rWM/jcgVefvAHkrDTvGa9W5C2+JVNpfUkSDRjMvxDQ20Rm91u3G6YQJ75D8BFv6tEW/wZI3S+rBjpL2i9tolN7UoGx2I+o+1++zusp84zFZUYUjl5OC1po1x5N72pmXOlVUB9APDd1KDu+Ia26XO/B5+/PMBnpXXvKaxQ2pHW8Bmh185B9vru+72CDanzakdYWFgRwFzd4qimQ5gLJgUy55mfuGEuZoB+MnWWTZLpmNe2yNKPFQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:11.1943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12fc34e-c786-445a-8373-08ddfb788b95
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1255
X-BESS-ID: 1758724932-303549-7636-8101-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.65.94
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaW5kZAVgZQ0MDAOC05xdLYwt
 DUKDU1Ndkiycgg1cjUOM3Y0NzYIDFFqTYWAG9GKjNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan23-253.eu-central-1b.ess.aws.cudaops.com]
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

