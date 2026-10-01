Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B72CA5FB3
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 11:25:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DEC142EB0;
	Thu,  1 Oct 2026 13:24:41 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id C3EB840144;
 Thu,  1 Oct 2026 13:24:35 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A397C20012A;
 Thu,  1 Oct 2026 13:24:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D610200134;
 Thu,  1 Oct 2026 13:24:35 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E476118000BE;
 Thu,  1 Oct 2026 19:24:34 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v19 05/26] bus/dpaa: accept QDMA device name in devargs
Date: Thu,  1 Oct 2026 16:54:09 +0530
Message-Id: <20261001112430.251845-6-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261001112430.251845-1-hemant.agrawal@nxp.com>
References: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
 <20261001112430.251845-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

rte_dpaa_bus_parse() recognises fmX-macY, fmX-ohY, fmX-onicY and
dpaa_sec-N, but not the QDMA devices that dpaa_create_device_list()
creates as "dpaa_qdma-%d". A QDMA name therefore falls through to the
fm%u-mac%u sscanf(), which does not match, so the function returns
-EINVAL.

That makes the documented usage

  -a dpaa_bus:dpaa_qdma-1,dpaa_dma_err_check=1

fail in rte_devargs_parse() with "failed to parse device" and abort EAL
initialization, so no dma/dpaa devarg can be passed at all.

Parse dpaa_qdma-N as well, bounding the index by the number of QDMA
devices the bus creates.

Fixes: a63c6426fdfd ("dma/dpaa: add option for error checks")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/dpaa_bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 368c8eeb98..5442f8f893 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -521,6 +521,11 @@ rte_dpaa_bus_parse(const char *name, void *out)
 				i < 1 || i > 4)
 			return -EINVAL;
 		max_name_len = sizeof("dpaa_sec-.") - 1;
+	} else if (strncmp("dpaa_qdma", &name[delta], 9) == 0) {
+		if (sscanf(&name[delta], "dpaa_qdma-%u", &i) != 1 ||
+				i < 1 || i > RTE_DPAA_QDMA_DEVICES)
+			return -EINVAL;
+		max_name_len = sizeof("dpaa_qdma-.") - 1;
 	} else if (strncmp("oh", &name[dev_delta], 2) == 0) {
 		if (sscanf(&name[delta], "fm%u-oh%u", &i, &j) != 2 ||
 				i >= 2 || j >= 16)
-- 
2.25.1

