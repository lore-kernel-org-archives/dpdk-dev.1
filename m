Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35944C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F05140E21;
	Thu, 20 Feb 2025 23:04:42 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 188B640A81
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:32 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2040.outbound.protection.outlook.com [104.47.11.40]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZAJnxaRD8wDuyD8m7hLh59tBb+C34LKQD8zbb3iWEUGmHehnpZDo9KHCzoJBSbvDy52crvBQ47geCEVJ4rlSYJ6QySXnpgLX4XCQuehhLUtgd+XT95fb7GWXWl+S3TiomaSTUMrnJZMCjMLpifLrLlXUzREyvrWKMziMwI0Rro7xqUxDBU3AirZXk7oTv6D7pv2GLlWTDYeRtGFuqgadl5Lo4KFKYZZFUph+lFAqOw8Y25t7eypqJHm5fUTH/ik5rgNSBhJjDrOs2WB4LKE4rgYFR1vgqvR+sJlXQHdQN2wd4mE2xr9Z1WVzBrBz4AY6LdGixieHiDxn4UduVDiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzGnMOSfVoVbGZ1+RHcwoIp/WMjAN28hsHohqB50tFg=;
 b=VLFBWGVq1gvo3lthVoxq9YNtB1CCY3rR2PKJZzqRN6WXEKHkfQggYab0Odo+sGb3VxN3apOkKJgX7wFCsRIabJhnRAmM7VYI0HC5ROIeW5dBNS+5/tpj+3HdIfqGqsyoiU9eSTxAj3OgrU7SfvDVh7VfDwfY2wq60R54HO6fAInEYg875ztNXWPob/FiKbE9C3o8IQIqa3ToTCeGbnMNUaTKb78tcuz6aTruLRXGtQn4EZJarm4E0q4REYuT+7jU8qoIoYP/SVTkPP6UGk6aJA47mD7aVSEhz4/1+6sRCdMFbjaYkKD3XFVcpmLorrW6KdsfDPzBWF80MuIKYgx3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzGnMOSfVoVbGZ1+RHcwoIp/WMjAN28hsHohqB50tFg=;
 b=GLIY7IujiDOcFWnZyqYUYrQuSyv2xuV1x0V+n0Kc3sdVa5GS95SvbMpxE+9xVILVhp1LUdoBnovwv69SQ+aWo1ioYPxNj0LzIWvDctlyNQQ+0eQqE4U14S36ZTJ5uVpdxCW+XJbDu79i0EOWgxreGD4Ilsm24PfNGgkoceOxm8s=
Received: from CWLP265CA0510.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::10)
 by AS4P190MB1879.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:506::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:29 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::6c) by CWLP265CA0510.outlook.office365.com
 (2603:10a6:400:18b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:29 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 22/32] net/ntnic: add HIF clock test
Date: Thu, 20 Feb 2025 23:03:46 +0100
Message-ID: <20250220220406.3925597-23-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AS4P190MB1879:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f63be8a9-baa1-4b5c-a0dd-08dd51fa8c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qqa1oTrv1rQ77MZFtchaHBkHm2QYs4XSaijuvA+1dck3wW+r8dQH+LvzJj3U?=
 =?us-ascii?Q?iB0WPdDX/XWuzFXqd63UENlOKpQxgt0bQUycNwtCQYdiKLPC+bJ0QhctlXbS?=
 =?us-ascii?Q?b9IGgfWnKjTmFGEDmhmgXkp7rYDakfoU30wMTxGB4MUqcoVe74RTzM9GbCEg?=
 =?us-ascii?Q?TPBUille2xsX2RKBKvvjEe0/+nKyhavdhVw5fezru1yGhnx6C0uwPheAmVb1?=
 =?us-ascii?Q?Jy7AHujUwD2KAo07x012hAgZRZ7r3JYMF5ddx+OkRbvHM5u4NoxqYz/9Pw5N?=
 =?us-ascii?Q?z9SYB1/a2nCkyaSeWzIEfCoiuebSfB94jk5uZn4No+G4MyoSIWDdZH5B8uin?=
 =?us-ascii?Q?jhvej28Cgiw/GhtLIB0xxOEkgCbIaSOGqBAgJls8ZGAK7/DpbhisTCw8rNT4?=
 =?us-ascii?Q?LW/IY6wtRAo+zifhVlaTMZyjvPvS0GBW9vXHPK7lZNk4RbNxI3tO213S31OW?=
 =?us-ascii?Q?Wvott41VK64U4H+Wizr2zBkDcN6HMXRJwZEaLA9LnCVSzwHhCf2vBO79QoHK?=
 =?us-ascii?Q?BHy6sx9KuIZYyu1qYLV7Zp1k5RGPYJUeD9nFj23GTSRNK63Do2idYuwl//Ax?=
 =?us-ascii?Q?wB8i0hvuACJRVSIXQ2KgjonVX5m2Si/ZFoV2Slks8o+od++z8EZWnkjoL9T0?=
 =?us-ascii?Q?Pe6Ao1HRat+oPTf0ssRUI5SgIHyZYvgmrfI4/ueNxjoMfCyb0HLBSLaTZ5wF?=
 =?us-ascii?Q?I7or1diIbP+Klw24oRBjHTzV4njf3sSoBIIGGJTGTqHlFnDbe238PY4AheWb?=
 =?us-ascii?Q?+hwrguc/v8O9codAHYdW4y78CTRpcgZr/4f6mzzo+6d/ka50a4S9cqR+c372?=
 =?us-ascii?Q?9h0yNcrvin+p+8sa4+xVmIWvAgh+C+W90ueH7880uVhT2vsPN7eQ3Or+s2hx?=
 =?us-ascii?Q?8rHeStLKM8QW3bJ+EFM4XA4iUACnVH0p8bcuYjUrPX9I26y/n0FbsqP3TkOI?=
 =?us-ascii?Q?YEaFN0LEkM+dCOi6DLtC9dmX7i13OQLGKB5GJRj82ix+rXa9utYAbH0mp5zh?=
 =?us-ascii?Q?i1Ouy7xFOa4Pq4MOWzIskKTbYRch43vtPHuMPGx0zJNW3g6U8hpr8TNalHmt?=
 =?us-ascii?Q?DrP0P3ZCXcaYj+IHtR+gPjO6h69zaGj7LG4KyObngFYCUkGfJIQ50HTpXTuG?=
 =?us-ascii?Q?T7hLto4zjJwjfZluA6621UGpsq6s6JMymkpgKbL8rEi/7xGxxv8n5CIUtUqh?=
 =?us-ascii?Q?38r3yVAi4+bSyzEQ6PdYp8cGWZZwB8/lhQMf4H3xVpWqi+2o1jRvewT+1B/7?=
 =?us-ascii?Q?LR3L+7wGwe9WGtJtwfAzXXjIeyEDpLqKuTi1dO7n/RDbK8hIBbZpMjmvrpxU?=
 =?us-ascii?Q?A1OPf+40c96PQl00xzBfFMkvSU3CZ/gWG4atcVwSv99P2vbX/h0aPJPpnafB?=
 =?us-ascii?Q?tPMhKH1YUHoJEWSGtldtyvkMajnNgg5H/qeGHC8kWKawjfVR1HWqmk9e9FXF?=
 =?us-ascii?Q?ZUquB+QnsUsipq70B8D+6mj3l6GE5Min1iis6y/zKm6mQpxi5vxNHKF2LEFl?=
 =?us-ascii?Q?MP3Cmj5TGaevzDM=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TEg2BHzpuH8XeTz+bTEEhknX+9hyP0U/fzMlQWSiSXFn+RwVBp5Yqru99D52ZQGXBfd74IAUTRoVvA7qP5OXihpFBvWJ2IKtB8yUbrZ9nBnlQl9pf+dx98fR4NXIuiN/aBzfR3CRz2ZIwIFNrzDr5xfg+W+0WIpK+1905lG/eIyMTgtJjoIkcEmrooH3ErLjXRRhIqpL3TTt+ydM7nouWCeF0StO2J9YT2e5WPZype0f4pCH1qZ6ViLHybgPmmi2qSq3pfQGCjQl1wO6ZqZF9mpnER08L2zAh9k7VTF135zdYXX0IBFtZ4e289U7OPYpV/KlbhxIA7NjMBkG09x0mZ5Uv3f404SAc3yx4Z0YluQZD+3SA3gLuF1i5obd7ALZXIFEQX00GW7KrVVJB4LVdlNvzyf+ca1LXtVy+pcYCBmWYHANTPiGEJDeE/VqkxqsodcZ1dSxjPmQpDirVTqraJDz3VwejyMj09wkyTpbhfXbpkeaEjkqhW5y6AJdG/2wZCEEsvjYZqJIXWUhYm9DWF9EQ8r59VfrjAsLZ6TI4JidhZmix15CbCtz2FQDHLrfIyjzLHB9AlUgmXf3CP78fUSTlv6tGCpW5WnZ+d1KjmGjQPPUImEEcAfRu3H3lA2BabRWEBoeldLWkQlkSkHKcwoOdj+3vR2iELHwof7haN4=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:29.3651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63be8a9-baa1-4b5c-a0dd-08dd51fa8c5a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1879
X-BESS-ID: 1740089071-312005-29070-14098-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYWFgZAVgZQMMXYNMnYzMI0yS
 gtzcIoJSnVwtjcPMUkOdUo1cLU3MRcqTYWAF0QXElBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-233.eu-central-1b.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add HIF clock test with write/read verification.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../net/ntnic/nthw/core/include/nthw_hif.h    |  3 +
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   | 20 +++++
 drivers/net/ntnic/nthw/core/nthw_hif.c        | 82 +++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/nthw_hif.h b/drivers/net/ntnic/nthw/core/include/nthw_hif.h
index c8f4669f83..deb9ed04e8 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_hif.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_hif.h
@@ -148,4 +148,7 @@ int nthw_hif_get_stat_rate(nthw_hif_t *p, uint64_t *p_pci_rx_rate, uint64_t *p_p
 
 int nthw_hif_end_point_counters_sample(nthw_hif_t *p, struct nthw_hif_end_point_counters *epc);
 
+int nthw_hif_read_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t *p_value);
+int nthw_hif_write_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t value);
+
 #endif	/* __NTHW_HIF_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 1d93474cff..60e7714283 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -24,6 +24,26 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	if (res == 0)
 		NT_LOG(DBG, NTHW, "%s: Hif module found", p_fpga_info->mp_adapter_id_str);
 
+	/* (A) Test HIF clock is running by performing simple write/read test of HIF registers */
+	const uint32_t test_pattern[2] = { 0x11223344, 0x55667788 };
+
+	for (uint8_t i = 0; i < 2; ++i) {
+		uint32_t test_data = 0;
+		nthw_hif_write_test_reg(p_nthw_hif, i, test_pattern[i]);
+		nthw_hif_read_test_reg(p_nthw_hif, i, &test_data);
+
+		if (test_data != test_pattern[i]) {
+			NT_LOG(ERR,
+				NTHW,
+				"%s: %s: Test sys 250 clock failed",
+				p_fpga_info->mp_adapter_id_str,
+				__func__);
+			return -1;
+		}
+	}
+
+	nthw_hif_delete(p_nthw_hif);
+
 	/* Create PCM */
 	p_fpga_info->mp_nthw_agx.p_pcm = nthw_pcm_nt400dxx_new();
 	res = nthw_pcm_nt400dxx_init(p_fpga_info->mp_nthw_agx.p_pcm, p_fpga, 0);
diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index 9f699e4f94..92a2348bbb 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -298,3 +298,85 @@ int nthw_hif_end_point_counters_sample(nthw_hif_t *p, struct nthw_hif_end_point_
 
 	return 0;
 }
+
+int nthw_hif_read_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t *p_value)
+{
+	uint32_t data;
+
+	switch (test_reg) {
+	case 0:
+		data = nthw_field_get_updated(p->mp_fld_pci_test0);
+		break;
+
+	case 1:
+		data = nthw_field_get_updated(p->mp_fld_pci_test1);
+		break;
+
+	case 2:
+		if (p->mp_fld_pci_test2)
+			data = nthw_field_get_updated(p->mp_fld_pci_test2);
+
+		else
+			return -1;
+
+		break;
+
+	case 3:
+		if (p->mp_fld_pci_test3)
+			data = nthw_field_get_updated(p->mp_fld_pci_test3);
+
+		else
+			return -1;
+
+		break;
+
+	default:
+		assert(false);
+		return -1;
+	}
+
+	if (p_value)
+		*p_value = data;
+
+	else
+		return -1;
+
+	return 0;
+}
+
+int nthw_hif_write_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t value)
+{
+	switch (test_reg) {
+	case 0:
+		nthw_field_set_val_flush32(p->mp_fld_pci_test0, value);
+		break;
+
+	case 1:
+		nthw_field_set_val_flush32(p->mp_fld_pci_test1, value);
+		break;
+
+	case 2:
+		if (p->mp_fld_pci_test2)
+			nthw_field_set_val_flush32(p->mp_fld_pci_test2, value);
+
+		else
+			return -1;
+
+		break;
+
+	case 3:
+		if (p->mp_fld_pci_test3)
+			nthw_field_set_val_flush32(p->mp_fld_pci_test3, value);
+
+		else
+			return -1;
+
+		break;
+
+	default:
+		assert(false);
+		return -1;
+	}
+
+	return 0;
+}
-- 
2.45.0

