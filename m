Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ED1C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:18:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC71C40E2B;
	Mon, 13 Jul 2026 12:18:06 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 258D140DDD;
 Mon, 13 Jul 2026 12:18:04 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 06DE7200026;
 Mon, 13 Jul 2026 12:18:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C5853200034;
 Mon, 13 Jul 2026 12:18:03 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 66C8318000B0;
 Mon, 13 Jul 2026 18:18:02 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v5 10/18] net/dpaa: fix port_handle leak in fm_prev_cleanup
Date: Mon, 13 Jul 2026 15:47:39 +0530
Message-Id: <20260713101747.2947405-11-hemant.agrawal@nxp.com>
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

In fm_prev_cleanup(), the port_handle was not closed before being
overwritten on each iteration, causing a resource leak. Add a null
check and close the existing handle before opening a new one.

Fixes: e498f3b51f38 ("net/dpaa: improve port cleanup")
Cc: stable@dpdk.org

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa/dpaa_flow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 417b9b6fbb..f21950f64d 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -81,6 +81,10 @@ static void fm_prev_cleanup(void)
 		devid = fm_model.device_order[i];
 		/* FM Port Open */
 		fm_model.fm_port_params[devid].h_fm = fm_info.fman_handle;
+		if (dpaa_intf.port_handle) {
+			fm_port_close(dpaa_intf.port_handle);
+			dpaa_intf.port_handle = NULL;
+		}
 		dpaa_intf.port_handle =
 				fm_port_open(&fm_model.fm_port_params[devid]);
 		dpaa_intf.scheme_handle[0] = create_device(fm_info.pcd_handle,
-- 
2.25.1

