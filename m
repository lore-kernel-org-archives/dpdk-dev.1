Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045ACCCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF30F40E12;
	Mon, 20 Oct 2025 18:36:47 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 0DDBF40698
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:41 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021114.outbound.protection.outlook.com
 [52.101.65.114]) by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtpQUtr+YCHAvHENoly6EhI6MP6uaTF93/pekPjI9OQ/hXjFqK5eILcox5sEokRxdKtzbrcSQFZ9qGZqvKM6azlmOk5NzmqbAks2qZJ/A6yd9e5ZlJuuTH2XySiEtAHK8IunZXnbuS+AL8sHm2qnQ4jOhSaw3IJiGRIsyVnfasufhPukSY71gOyW3EKxMJkN0bNNY47lmR+VCFz+tlHIQSQmI5x3ED0gkrJhNUpbWe42yIS8XWdFeQs9AtRohX9KXtYcQ21FJbxb2Bk24BfOyiKZh5H0MBaf1arK9oF84e2wtMopi3aToCHbIVPuVGjDvZCP7q9ngrX4dsNNNWL1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvnyTMJE1N1viL/cjTNlh45DPM5b8QtXLhkWBernw30=;
 b=CcVp6azhdmNRk1N/kn4wxZykt7/QUE992NEstKeJJbGfUnd38phXQYbuyG/GYx8OPW0q1ON409alC/xjMTnWdt3nXTmvGlFaSFlhjCkZDYfsmwuBmbp6QWCKl0cYk8iCVFd/m1mhFd8fSQJTfkQR58aHyf8iBvCaJ70Iv730ogjGdtqc1HT/r52PrW/rGWaMS6PdgVmtM5lAhNo3fE41aV1YzAz3nJOVeevW0qtFloay4unBZV5m37O+ojTD/VQ306eUZXp5se9Uu0s6EzJUxOB0PRfjH+KRbbRqE5DJwaZhIPKyyiHmwK8ogS5B0KOlcWL071AxrJ3n819YH8IZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvnyTMJE1N1viL/cjTNlh45DPM5b8QtXLhkWBernw30=;
 b=n76Mx7pgr2R6pT3WIuPD2fBLfSIeh/hP12L+2ainAK0nJ2qbe/ZZgYTRyxL24s9192W4eEZ2FQZfL5BwEZIV2AFxQkaWH/F+0mgIRumvq0hVNnfcn6J2Wbs3bplloPvFYKzEPNVNKLwP83AnqAI/VstYLD0tx7M8f9e/toOx1fc=
Received: from AS4P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::9)
 by DB9P190MB1195.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 20 Oct
 2025 16:36:38 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::3d) by AS4P191CA0019.outlook.office365.com
 (2603:10a6:20b:5d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:38
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 16/24] net/ntnic: change prefix ntlog to prefix nthw
Date: Mon, 20 Oct 2025 18:36:07 +0200
Message-ID: <20251020163620.282312-17-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DB9P190MB1195:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e1c7c7d3-0624-4303-40bf-08de0ff6d760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T4xKJc4f9J20N5UBTIZeIVtiFPo0dnnk2+HFNZpK6aWmmmNQaK/kUdGUmEfQ?=
 =?us-ascii?Q?HzbAP+gggvz/j9Lhh0nwEIVmsq3bbkH51Ok+zCfgyY4E9+2RwuIFngBXwNCW?=
 =?us-ascii?Q?Qg688kCyuLVJksFzDN5e8TaZC0tmtNNeqrmNHXaEw+6+ZomHh1hFtne9I1JH?=
 =?us-ascii?Q?Eu1W+sJAl4CSGVANI8b/rO9K5nJqy0tbCC6ksAtZM52T+AhQDC/hr50CBv8x?=
 =?us-ascii?Q?bNbOaR5lG4SCDucpR+EdQt7BriEzmWDPd3YIp9krSjfhngt0Byt5AkNTrCcL?=
 =?us-ascii?Q?I9hE1v2U+gY3h6tKC2gjfoBW1o1bz+lqGhB0rR8AfiucbcHK3evkll15Xbbp?=
 =?us-ascii?Q?EVv/z78EBd6mrLc3f7KmdWdBPy0bKQyCZqVihAKIa0Ivr5M2txnXGajYlt1z?=
 =?us-ascii?Q?Tvx4flX5TEVgxTdwvIyB0e2ezz8vTPt1ejV8wc0w6lGPYiOILVtHrgE5aoUo?=
 =?us-ascii?Q?iGahbHKrtM/+b2N94vCHsAcY0GSRQDXPc/0R+IWw/jCMOtKElpQmicf4WC/K?=
 =?us-ascii?Q?J8P0n8q2/rHyGlRb2YAhQgef82sgyk+/lO2ja8ZRLDW+OTf9wj+6l90XIKX6?=
 =?us-ascii?Q?iZXskjcBAePpOge4BoFFtBwpfubewiqjfTaH42fNwhXVINrJvIDs4VG3V0fe?=
 =?us-ascii?Q?kpznIjt97ULZNAVjCEFq8Ulg4sXaWsRhk2/nqJSF5baSOygEGl+RHVwd/9b1?=
 =?us-ascii?Q?FyTwny6+A6bgz0aJgucdp57D7gPBPPCIh7l+W2HKz/L74+TlT5KXxbB92gQS?=
 =?us-ascii?Q?MaGsPynQ6K39UcMPqB+Wpsv1D8YEp2zs0vtsvQzHpxGpZ0Ak+5f59IsDeTSb?=
 =?us-ascii?Q?83R7AwggClYd7WZyFuUo4QLrXzER6mjVMDFqFAAfsmv6votUebaZc62Nx/Ho?=
 =?us-ascii?Q?FYz2pOXhZBgt0ZemWMaJw+66ldMsHcWXbFQt1NdYeZ0Vu/kzhfpJ+hj1lNdL?=
 =?us-ascii?Q?PLXOjgx7Eu4GCGjepyhrAU9EsfhK8UWBQQQUSmvnG2qhm+bKpKLqxPPTx740?=
 =?us-ascii?Q?3TTarKBSp+kJou8xP3dyYdKLgG9y4nxieFqlBgNmC7Tc44F+fRnJqj6I8ADy?=
 =?us-ascii?Q?f1MffMsuOiCMDU2t8iBez3LhdCKt5y86YAHQHnCyq9nluHT7ZcLoIXyge1iO?=
 =?us-ascii?Q?altNBvjp1oaOjCbrFJ1FLlARu6faT4JzsWoMsjUG43pGzximS9pMbol/Ga4p?=
 =?us-ascii?Q?iRF6RsJCAc6lDAyI/H4VrA18FzrujQKGuedkO24GLEXklnrcG2dvrOFUdMMf?=
 =?us-ascii?Q?ll56akc+U/IT+d5ON/iR4iFlG6NTBzgpGikjiIhu4TnyLJCfFm8mVkertsbC?=
 =?us-ascii?Q?JPfK7pqqvp99rIwYWHIJaqqVfEioHHHz6ueP5MldGLcmuQZNHg7hTXMdEvBZ?=
 =?us-ascii?Q?9AXREcnMqCR/aN1tl+LNOSm/5LgohRwQXfApmY85UbOHIR6wD+5Ft2OU2dtP?=
 =?us-ascii?Q?zPJ2YB1PrmmNgosw6Ckj/7L3nhACyqi++H8ub8mZCdkjUV4WvzyAZ/dYzvJ6?=
 =?us-ascii?Q?fuzLf1mR/MobY3Ui7ExP313iDIakxM4jURQYYotStuyJExeUBd4E9g0Nd/9b?=
 =?us-ascii?Q?gKWi5+Jd1IcTBCIMuhs=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5vrNtkrIi740ZoZUX6V0M+me0u+/NAYSjmLikJgF0/g2hYGukcsV/+ClQIc/Vf/p8/31S2FAFP21k4y7qpqxBKFw7fBcucCmPEWUcurzlaIGfWrZ1owD3bRvKT28aIhfF1kvzsFqRvn9tpDsw4XlSheQYVvnQrbQJb37EhQn9NOjeAJIbilPqUuVIxR9sKJSzpf1dzbIGl5WMcs/+lVqpj8PlP4sIZaVWCk6rha6zWkG3YV6u643JQkFxnD6mAsjKT01svzuyN3XqolpOEbpJfoPV+GSID/l/inWYOdQchH6yhNEWiedcSOs2325cxHpgzonQK7fWup1ZUQvd6Cb9osMFUI1845t7LdUCYjss66TFzU5LGoQhy7zsPSaIa5u+IMuOmCF9r8hcUC0nVaknstgQiLiFOrTpbpsTAhPJYIncFj1f/tE8b3UmtKvp1arv4hQvcvf4axsF2h2NXSUU7sT74AzxiwExriUDAPzmtaY6jRhVNjtgrJTzHSenc6YxvL+Te8fxAI96dwoymVeOZ4oclO9K3PSX0Cpo2JgZyJlgJsArZHIWVfVNhSpDSeMnpm5qYwL70S/i6hOgIbYNZPnBhpTPBh0jO0NNbn9vvKDXsLaIz1w9sVYQ58IV3AysNuElSoiAIsetXmLSyIU+1eyzDXX0NeaMBLJGNAHkus=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:38.1846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c7c7d3-0624-4303-40bf-08de0ff6d760
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1195
X-BESS-ID: 1760978200-303027-28478-63526-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.65.114
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaW5kZAVgZQ0MDAOC05xdLYwt
 DUKDU1Ndkiycgg1cjUOM3Y0NzYIDFFqTYWAG9GKjNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan18-209.eu-central-1b.ess.aws.cudaops.com]
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

