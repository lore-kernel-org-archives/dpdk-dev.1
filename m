Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F35C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DECA240A79;
	Mon, 13 Jul 2026 12:17:54 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id C894840685;
 Mon, 13 Jul 2026 12:17:52 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF678200037;
 Mon, 13 Jul 2026 12:17:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A0CA20003D;
 Mon, 13 Jul 2026 12:17:52 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4499C1800229;
 Mon, 13 Jul 2026 18:17:50 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v5 01/18] bus/dpaa: fix error handling of qman_create_fq
Date: Mon, 13 Jul 2026 15:47:30 +0530
Message-Id: <20260713101747.2947405-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713101747.2947405-1-hemant.agrawal@nxp.com>
References: <20260713092616.2902828-1-hemant.agrawal@nxp.com>
 <20260713101747.2947405-1-hemant.agrawal@nxp.com>
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

Fix the error handling path in qman_create_fq() to properly
return error codes instead of silently ignoring failures.

Fixes: c47ff048b99a ("bus/dpaa: add QMAN driver core routines")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 5534e1846c..9a99eb9785 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1579,6 +1579,9 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 err:
 	if (flags & QMAN_FQ_FLAG_DYNAMIC_FQID)
 		qman_release_fqid(fqid);
+#ifdef CONFIG_FSL_QMAN_FQ_LOOKUP
+	clear_fq_table_entry(fq->key);
+#endif
 	return -EIO;
 }
 
-- 
2.25.1

