Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B5C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8749140BA4;
	Wed, 30 Apr 2025 15:49:40 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id E3DD54065F
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 mx-outbound42-181.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmwBPq+curJ6y5J/qFp7KttWmtDI/lFoNK70wUMbhDpBI6tOP/3PzkjpDQHeHnkYDd0bHNVALAO5rr5RWoA4sRT2TIAJ5pRte9PfcE7+ICY6jWnkhzbKC7x2BZo9d+IV7/5D7spx/RySFmQZ/zedTX3ZPqPkwIvR5zO4UecZr1RZ1DePmI72wAkL0rxV8makFSruvc7gwlI1TZFxF3hNY7X+0836IrrXeYUWIChpirlXj+jzrhH0F1GyEmeikMlzGKqSMNN86D3WLlCx+837RkDe+OAKLBh8GqWxc3Ot6vSvV0fkmh7Nd0/hIc1KgMvu5UYpjm9aydWUmKfmxbOdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuCjpSvwqJR4EAFLjQOjGHHtohwQTN7z9zP2c3+6uJY=;
 b=jBzcVth5eVW2PtRNWaXayu4GCOeWnYu3e3byVVet02aYYOmJ7oUBQj+Mskza88H8t+6tjnPE26cPtLIlolX8UC4UmqYO7HT3z0AwjGaqEZVde88orPRQM/oUTuTn1Kdf0u11oobk/KWBudTEZdBIkIhWdKnFq9zianmjhH70men2IFKCcZpJIMTJgccbEFctEX8avdqa5bS91FVfrwsKcpbrkxsi7rOiWTJ4tmPZ8qCNLKxPSlC/35aWoQFiQNyC7zVFaEpgbXUC2SCJtG3R2sZUWEbXUEjPwiPw8CP2PQFPQpITGVGqhFqcu0Sg/KQ+BfJrMZ45JgguVMnfJ0V+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuCjpSvwqJR4EAFLjQOjGHHtohwQTN7z9zP2c3+6uJY=;
 b=nHE44laEOBgthAXX/XNTfoXZoOkm4TWeMUdZ/LbxlPzvSobgKpSd8r9wEafVRihpINSStcrf/pJSOUl0FEEyISCvQv7BGlBRrTMY7qpqO25FaDCECaAaLF/cL+xvx6IkzLs9Ibz5G5UfQh9rnI4VrU3ObXQV6ygIi5hYe+1+mWw=
Received: from AM9P193CA0002.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::7)
 by AS4P190MB1999.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:51a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.39; Wed, 30 Apr
 2025 13:49:21 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::8) by AM9P193CA0002.outlook.office365.com
 (2603:10a6:20b:21e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:20 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 20/25] net/ntnic: avoid divide by zero
Date: Wed, 30 Apr 2025 15:48:32 +0200
Message-ID: <20250430134840.402553-21-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS4P190MB1999:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f0d2464f-f5cd-4e67-f7ff-08dd87edcf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bEcl0pWTXPfmhI1/EVEuMrCh9Fgj5LvdDyDiootB5RyGF2QGePQM6lfqcaG1?=
 =?us-ascii?Q?4PsZHBhHAk/hrVa/E2Ihf7/p7uMU+dhuYCPOUpWTGCFx+A5oMHM4Ljv3mWew?=
 =?us-ascii?Q?k4dG2R31/9Y2vsnmYgFZIVo2JRC27II5UQWeJ2tbI7Jt63NOii8jDblm29uh?=
 =?us-ascii?Q?9OHSRc3hE3Y5WyonGVD3250qbIdkJ+nb2imm7OjzhszJSsTa1s2kizbpHA74?=
 =?us-ascii?Q?20Vn4G3Gch0rY4SvMSUhUYBcFnkyN3Gj67Cop046lUKGfm29la9jjKALdqKW?=
 =?us-ascii?Q?FqdjF80DOVPqBwAmif+jNX8Tutn65Ci3y7GFFeAMMySC4XyedOHQL3kWnHfg?=
 =?us-ascii?Q?/YA0WtWTyVTQTd3c+vMkSkw2fq+luojvQTgLF1OwkQcy3Igd0jAVJli/P9OK?=
 =?us-ascii?Q?2sV8dh3iM3aQ7ojgZBVMsPqFRUvMi2GaNPCL8fqA93MREHahUkNcTxFkw8Vl?=
 =?us-ascii?Q?2yX5BPdmuzgLk3Dx8B//oL8TiU7FH7GdfsZUqf27UBE/DOjRMZH4GFUIRTwH?=
 =?us-ascii?Q?1jzftkWLSqh/w58m5Y4XZyrnpqSSUvCHmrS+POxXn6G2rsyVvU2ncb3rrACY?=
 =?us-ascii?Q?jA8+HEmpBzKtD5TZyXnJZLfWKQSjA3UWsupsn0sXwDVNSec644rnL/rEQStU?=
 =?us-ascii?Q?wAOkzysoIWVfSOAD7Ml0US797/7I42Hn7W0YmdMH/Inqwm/HwtjwTZqghSbT?=
 =?us-ascii?Q?F/3t/E5fwbfqaCmNn0A8lJafXt7Ud0OXTEmIWaD8yPSJI60QVE1C8+G4xXXT?=
 =?us-ascii?Q?ZywLFSsD9kWevpiMMfQ/ueXw8S30qriGm1bTDAuo4+Q8KSV0v2onhN5TcJiu?=
 =?us-ascii?Q?11YdEbreFl31K03Fn6yGUmQbXGBzGIEZFWJpNv4g5s2N0usu1VTfGVL2w6jx?=
 =?us-ascii?Q?JR9sMB5tHtZ7UuYpXGqCyVtwH/XeWBDBDswEsvQNrNddXTot4vaw7sr9/ET3?=
 =?us-ascii?Q?tygtVOtvbefJ9cie0HEWmfyD8JulXi/a7DtnC76H2KbudK0cVXbKfTWX/xZq?=
 =?us-ascii?Q?FnvZ62Qv+Jt8EAe/lDFBQfumeXeeXkDO/j8KlKq5wf2+xqV2onNHX5LJ1vCh?=
 =?us-ascii?Q?dmb/KVofoMp5hRRSNPsVZqOa8mYUCcKLvqMahK5PbKtZ5CS0VSxz7prF8jcQ?=
 =?us-ascii?Q?EthH0PhTeepmB9KnShl+fQTuAZgtHwauYi6t4px3hU/c6wGuWArf2Yhf/N5J?=
 =?us-ascii?Q?Voi3czsDvioTKo8sN93/A4nnXpII2qr51igcUb/fNzOHzaU6k1AQsQRA8pmP?=
 =?us-ascii?Q?1AkR0104qVfbRwFRQ51IAYWFUiKxbPdXPXD/UMckj/8+wud9p/a5f8jKTsmA?=
 =?us-ascii?Q?h2ZtkFJEANWmpLQCHyTtulsu809JGdB/MGshIcdz+0emIw0X34jxGnwJ3gWX?=
 =?us-ascii?Q?H+AObk8lme7catLNyTsRFxi+CX8fSDhDiTQA01Eyq3wmTxkafyhA10LMWVaS?=
 =?us-ascii?Q?zf6ETHqt7xCmIuoFdQ3GE261BChAOcVVRsceOkvK6dFGGi5/czHjSM+GsfI8?=
 =?us-ascii?Q?8Aj/C9KgTwoGhabruxfE6c51clmd2NseV7bB?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PnQlsyVKT9xG84kwFytEo7eixdxbUVr5nu6C6T32il6dhONknSKLNF3+fFWt4xALyOXRacPCmejoIDJ3ekZkZ/U3JOhZrcgnufrrnKhWNUX0a0rxvp/RlB0TfkReKniie1EVzalLZKEp7JnoUx07AL/v4fHSmd/r6y1MTjUKW3GiRwAXcUmLHbRvdW/iqIYsXo7LNt4mo/DY12ZsLob1wTE8lkvhLhvEOQfTDDlShdNH5GPRhz6MmUJFJgLu2truoA6lxeMRFyUuz6COI3FE6/2cNJ2dyZRB7x4nnCuJHyABBoTDe4JILNRuqB1LFQY8ZGJjHNEzgXpFHe6w1IBzilgjkn/I+/b6MnOU8EtkByt5pacKRjJmVMnZQ/d5eUetScmTVexEsWkmz/L1j7NyK4YG1beEICUJV6AHPkP3gNHhhbEmNGGSFB2B7mkFIBEdxUFaZ3bZcHWx67s4nFbDsGBO3+LfOryxiPoJWor29IwxSZ8hLpHYyyRROMT7OotaeWPGJ+XvCLPDqgl5Ykcm20HQUwzAaKtbH4PUjNF1fRLggCkc6NtUiYZ8NDjKg29hJkgsokEK+RXQGSzFr+Y+xjWXyQQoIUnwwVvZbmYOCOGQXczeY0OeQ7vCng8RD1/blGIfsAZkyHgX9+xBcasY+Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:20.9736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d2464f-f5cd-4e67-f7ff-08dd87edcf48
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1999
X-BESS-ID: 1746020962-310933-7995-578-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGpqZAVgZQMC3N3DTZJNEgJS
 XV0MLS1MzCIMncItk0Nc3QMDnJIC1RqTYWAJf8z0RBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan17-92.eu-central-1b.ess.aws.cudaops.com]
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

Fix CID issue 457736 divide by 0. It was avoided by
adding adittional checking on the return value
for function.

Fixes: effa04693274 ("net/ntnic: add statistics")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/stat/nthw_stat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ntnic/nthw/stat/nthw_stat.c b/drivers/net/ntnic/nthw/stat/nthw_stat.c
index 2ddef052a5..9bb97bf311 100644
--- a/drivers/net/ntnic/nthw/stat/nthw_stat.c
+++ b/drivers/net/ntnic/nthw/stat/nthw_stat.c
@@ -319,6 +319,10 @@ int nthw_stat_init(nthw_stat_t *p, nthw_fpga_t *p_fpga, int n_instance)
 	/* Set the sliding windows size for port load */
 	if (p->mp_fld_load_bin) {
 		uint32_t rpp = nthw_fpga_get_product_param(p_fpga, NT_RPP_PER_PS, 0);
+		if (rpp == 0) {
+			NT_LOG(ERR, NTHW, "RPP has wrong value"); /* Avoid divide by 0 */
+			return -1;
+		}
 		uint32_t bin =
 			(uint32_t)(((PORT_LOAD_WINDOWS_SIZE * 1000000000000ULL) / (32ULL * rpp)) -
 				1ULL);
-- 
2.47.1

