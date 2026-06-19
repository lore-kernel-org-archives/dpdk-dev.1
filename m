Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E60CD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 10:40:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1137C40E6E;
	Fri, 19 Jun 2026 12:39:25 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1483F40E18;
 Fri, 19 Jun 2026 12:39:21 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0A3C1A0252;
 Fri, 19 Jun 2026 12:39:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B917B1A024B;
 Fri, 19 Jun 2026 12:39:20 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 02A451800088;
 Fri, 19 Jun 2026 18:39:18 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v3 11/18] net/dpaa: fix port_handle leak in fm_prev_cleanup
Date: Fri, 19 Jun 2026 16:08:54 +0530
Message-Id: <20260619103901.2274740-12-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
References: <20260619060916.485258-1-hemant.agrawal@nxp.com>
 <20260619103901.2274740-1-hemant.agrawal@nxp.com>
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
2.43.0

