Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08894C44501
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 261BE40E01;
	Mon, 13 Jul 2026 11:26:36 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id F278D40E22;
 Mon, 13 Jul 2026 11:26:32 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D94491A0003;
 Mon, 13 Jul 2026 11:26:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E1E11A0002;
 Mon, 13 Jul 2026 11:26:32 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E64C61800226;
 Mon, 13 Jul 2026 17:26:30 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 09/18] net/dpaa: fix invalid check on interrupt unregister
Date: Mon, 13 Jul 2026 14:56:07 +0530
Message-Id: <20260713092616.2902828-10-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713092616.2902828-1-hemant.agrawal@nxp.com>
References: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
 <20260713092616.2902828-1-hemant.agrawal@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

rte_intr_callback_unregister() returns the number of callbacks
removed (>= 1) on success and a negative value on failure. The
previous check 'if (ret)' logged a spurious warning on every
successful unregister. Fix it to 'if (ret < 0)'.

Fixes: 2aa10990a8dd ("bus/dpaa: enable link state interrupt")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index da7f65d8af..f679a6e781 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -559,7 +559,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 		}
 		ret = rte_intr_callback_unregister(intr_handle,
 			dpaa_interrupt_handler, (void *)dev);
-		if (ret) {
+		if (ret < 0) {
 			DPAA_PMD_WARN("%s: unregister interrupt failed(%d)",
 				dev->data->name, ret);
 		}
-- 
2.25.1

