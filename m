Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F68C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:27:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7B0B40E1E;
	Mon, 13 Jul 2026 11:26:40 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 454B2409FA;
 Mon, 13 Jul 2026 11:26:38 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C0E520000C;
 Mon, 13 Jul 2026 11:26:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EA1DE200012;
 Mon, 13 Jul 2026 11:26:37 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6CA951800226;
 Mon, 13 Jul 2026 17:26:36 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v4 13/18] net/dpaa: fix xstat string typos in BMI stats table
Date: Mon, 13 Jul 2026 14:56:11 +0530
Message-Id: <20260713092616.2902828-14-hemant.agrawal@nxp.com>
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

Fix three issues in the xstats name table:
- 'rx_frame_discrad_count' is a misspelling, correct to
  'rx_frame_discard_count'
- 'rx_out_of_buffer_discard ' has a trailing space, remove it
- 'rx_buf_diallocate' is a misspelling, correct to
  'rx_buf_deallocate'

Fixes: d2536b006d78 ("bus/dpaa: add port buffer manager stats")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index da83b45831..50d30d23b2 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -135,13 +135,13 @@ static const struct rte_dpaa_xstats_name_off dpaa_xstats_strings[] = {
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rlfc)},
 	{"rx_filter_frames_count",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rffc)},
-	{"rx_frame_discrad_count",
+	{"rx_frame_discard_count",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rfdc)},
 	{"rx_frame_list_dma_err_count",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rfldec)},
-	{"rx_out_of_buffer_discard ",
+	{"rx_out_of_buffer_discard",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rodc)},
-	{"rx_buf_diallocate",
+	{"rx_buf_deallocate",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rbdc)},
 };
 
-- 
2.25.1

