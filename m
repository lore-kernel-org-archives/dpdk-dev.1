Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C429C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D547340B94;
	Mon,  5 May 2025 09:14:35 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 331EB406A2
 for <dev@dpdk.org>; Mon,  5 May 2025 09:14:35 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 mx-outbound14-199.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+B0V6wkoY45XRPxz+Xg/3Z2yiaeCZY1wAUlk+Wx1sKrL0HBf1F95iFCPC0bXEn51KT4COqdb0SP+o1ck9/nbOvusRxqtEREE920v3G5fZZ2hPfZ2PUUReU3b36DiwBlEkS5F5tRjLnnkgRIXfJL6ikn0nr9TtC2KwkPIM1pNiW+aOS9FR04ISSjSBDJCZR5RQYyTYpf09M24BkhJwWcRsikMeSG53v0w2nu53NtCzHbRzAARsaVl5+5aifirWPrnntGKLxRbd/SeRdv8465NBB0OO+pgMm/g5H8+fKQoQNXHrOYv1zrF5DZkva4eGyCcJBkdp9lIzjqqtmA9SFicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejWmrTWxQFcHAOdOCONJpfcT8a5kl8NfdqJ0rmKBC7M=;
 b=KL9G8JuL/ok2aYWbSTpN3jNcc7gy7PjPT3KQFdoCE5gGvphtEXyEdjzPYoMMoSZwF924ZZvY9vp4+t/3q8GOmUFYkBcloNG2x0GlAsutyKlEHPDD8HkbdycSRYksC9YUDVjtGNvq5ol/UqkeY+MTrK4DWFrG1G/vgtlNXOL4Qc6mH408E4+NEdv87zVIbne3g005JTZL1/GkxMwxO7/XQBZA1gXChyNup7gKx0ZNsLHl+QLIg9+JM9cP+eRcGONeKWQkl2sYKg/lrn71RCx2T2hGfUKO1eH9oE2sFxvB+2BybVgsoBr7VOJLH9XjSWqTn9lxB+zd3umT3rSbt25tXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejWmrTWxQFcHAOdOCONJpfcT8a5kl8NfdqJ0rmKBC7M=;
 b=Usc4iU9GI5QempmXvukqmCN1H8+5RQAQubi/aqIIUK8WAnRLbY/CzanRQt5w3GyTfZaDr22z+Fu1L+BVbOztTCpxDvm2TQ5C3hMzOqCzIjkcu7C85G/oHAI4nk77h03F9uq0nxTVk+CkKevkLU6hZMHJ2SbRSL6l3DYb5CX54FM=
Received: from DU7P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::16)
 by AS8P190MB1287.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:25 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::37) by DU7P191CA0024.outlook.office365.com
 (2603:10a6:10:54e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:25
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 18/26] net/ntnic: add return value check
Date: Mon,  5 May 2025 09:12:58 +0200
Message-ID: <20250505071309.586015-19-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AS8P190MB1287:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d820737b-907b-498b-5ff5-08dd8ba453f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/8hFT7sB8DrfPeOeFzK0cwZjyDvfABAXlop1QNRa48CS1oUnXqz0cMrqalEk?=
 =?us-ascii?Q?sYd4+5a/yARQmEZCucR9Y+Az/gXH65LLufWiqRxyPxKae2FZ90Sah2ecSczj?=
 =?us-ascii?Q?XWuKvEX5xqe7fJ8K19C/im42ayyi8nj9oEPCJEf9Ah+/apYglWwcHc+e7EGs?=
 =?us-ascii?Q?Bi7RB+fpIHW+pl1YS0uv7bp3tW/VvfkNfVUljVk2NXF6vpwf/Ecu6hl/N9Za?=
 =?us-ascii?Q?mtAypu9JWfZb5ds0RF7scWL4qLsFW8rxq4coM+o+N431aYwdIWT82eXk0jJi?=
 =?us-ascii?Q?sd+AK1D4MCeNOmJNizHhiqAspB24MU6lJ5BeSVwPB5/E/jbV4piMITCp3cx3?=
 =?us-ascii?Q?+R+COS35gPZG7hdpYqljpgL/LkBriw9dECsSdWRSdN5lBZ7EDEnQu9ajqdAH?=
 =?us-ascii?Q?JLPQXLhVCGHaRstBo95hDGlofU4c/TXEUDn29SO98NbjhIrjhP/SRBm2m8a6?=
 =?us-ascii?Q?ZeZlTA1IMuP7E9s/yoIVLc1MhdSGE1NK72yUYMmhxxfyGxDl4L/tTfx+FEq9?=
 =?us-ascii?Q?T84Ui0/pzN1GA3QNXPF9Ebi3CpWs3tU+MD+ueF7coa0wwcskFc8EkjNn5HxD?=
 =?us-ascii?Q?yiekhQAMKLpc4JkCFNBH97LJ9SgR3GWo/2FPPH5Jlzbp3H9IWv/e4ZClxmw0?=
 =?us-ascii?Q?1Er5cNkEWo+/E1MaZqwkFfmiBwI+2CKADb7dJoyHIgyFfsRNf6KcwpienTMB?=
 =?us-ascii?Q?y9odAUF0H/ZfDGh64aZCHKhYncnpH68NbIsEQuDDRMWeGQjg/L2YtzuEd6Uo?=
 =?us-ascii?Q?FJao+uLyZIdP3nJ7EiaDJk1xMEMzaEWd5tMCSZxZQLwCwQo0AeiyMgUdWja0?=
 =?us-ascii?Q?5umQ+S55eqPdbY/KXVij2Wtur3IpLULookD5xiNnrYnTi8xM71Q8NFGITmWX?=
 =?us-ascii?Q?c1zS+eqCqFEIuTs5hEigraNicsYw1SepU74M3Nqu0q0mHsNUbdtGD/+TmT7q?=
 =?us-ascii?Q?QPbbi4ypnOZnVL3lKH4bS1zPXwArUSwmAO1BwqbkSFUqaY0t8zLseddtVPT9?=
 =?us-ascii?Q?uvdeye2UhnnYpC+vz0x/2zqMqlAM0PuoUL0CZhs6BY1TdiWGW64yRrr25cZC?=
 =?us-ascii?Q?cjaipCA6AHq6mv/2ODuN5sZy8PhXFyc887yq97RHxiFrJizi5dLx3zi8xC31?=
 =?us-ascii?Q?PBhxCcoA/ocUhM9/46Z1WKfuA85a8yJgR27ZfOwUjEWb24zshtFiiS1uEYba?=
 =?us-ascii?Q?vsiNGASGzvxHbLUDp6uHE4873jlu9kq7mlf5khLIESSSTAUgrbWfbXK6e6TJ?=
 =?us-ascii?Q?8DQ4Az5YHYuTa9oIyDEVceM4Kt5Hah6ancbdQ/9ubmD2E7pbt6jXLKhPx86M?=
 =?us-ascii?Q?/5aIS4FvuYrDGRsmIjrzUtnNujonIyM6NZX1i873GXP3vzjn+SW7AmuDCRXg?=
 =?us-ascii?Q?9eVKLzBio4s+riH6WzZZ7J9TM7b95pRJmehn2O4bs/+HGIIC5oWVUxrqUekv?=
 =?us-ascii?Q?YHsiuV7FpqRiLySxbsyAMfrwLnuKoKnQcgN1V5p4oHcSf8UyIyNoF9qTf43a?=
 =?us-ascii?Q?Q0o4TQ6n0YR/+kPMFpvcp1JTWMdIJ82R18vC?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ue/XQdf/5GhIUOgWFMSQHM5xQeBxJIX+0CUNPRGyaZwe9Degi/nEsXMWeGM/dAjUBK5NRofh/O2LVhf5aZMgm0zVYWkrZCvcIs9kp2S2UbmqNizE64WJ36uHUQUFornpBFfye19i2F22NRa5p4CaAkvZLt3WiClmKR1pREJzsREH7e7DFJhTxqh4X79CPCXMx0SgcLNhCp4HuT7X16o4zn3WRCYsREKuxZtqyjoWHfKqRN8de/EZXsC//2WvQ5SHAIvy3MmZqBFNEZHtqrt/nAMTsPIy32o2nVQLP47rTO6wbksrgN1ulikyu+nAcsDLTqSYtLqM1D74XivUdcolQmHyINA+t57ZLbUntBP/GNx1vP/jOULgEeD5eWnYaQR/MQHgZCPyYqGoJUDsz3fgjAbeZyXEgErTJinoFAFVY/zEnetKc1MPFUKhDvUW5RJYzTkM5KQ8sgX6CITcdsDCqP916Rm0hOMABueQkRBDfCJlqA6oYx8Q3IZ/CFOBmgwB2ev0qXiKbtZ5R4y3xRkA7OrOW6jRzWezOd+NayC37EExGmgBSr0dUmoP4yZVePTxfB29ZrWeQ36TUJS7y2u/7eFJ8D07C7pH98g4vF1IE6NlK4tveYzbSk7ltEpH1c8nlL1Fi7YBC8dclzW4YECZDg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:25.4064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d820737b-907b-498b-5ff5-08dd8ba453f5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1287
X-BESS-ID: 1746429206-303783-7662-386-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.111
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGxhZAVgZQ0MzEODXRINU82T
 IlycQ8xTDNwMLQ3DIxxdjMIMksJTlFqTYWAMv2roRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan20-254.eu-central-1b.ess.aws.cudaops.com]
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

Add separate return value verification and logs for function.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
index 3528792845..cc6f7d13b5 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
@@ -528,7 +528,16 @@ static int nthw_fpga_rst_nt200a0x_init(struct fpga_info_s *p_fpga_info,
 	nthw_rac_rab_setup(p_fpga_info->mp_nthw_rac);
 
 	res = nthw_fpga_iic_scan(p_fpga, 0, 0);
+	if (res == -1) {
+		NT_LOG(ERR, NTHW, "Failed to init iic instance %d - %d for NT200 (%d)", 0, 0, res);
+		return -1;
+	}
+
 	res = nthw_fpga_iic_scan(p_fpga, 2, 3);
+	if (res == -1) {
+		NT_LOG(ERR, NTHW, "Failed to init iic instance %d - %d for NT200 (%d)", 2, 3, res);
+		return -1;
+	}
 
 	/*
 	 * Detect clock synth model
-- 
2.47.1

