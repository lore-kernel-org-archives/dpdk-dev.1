Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62A4CD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 10:40:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ADBF40ED4;
	Fri, 19 Jun 2026 12:39:28 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0388F40E64;
 Fri, 19 Jun 2026 12:39:25 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D810C1A0245;
 Fri, 19 Jun 2026 12:39:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AADD01A024B;
 Fri, 19 Jun 2026 12:39:24 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 28297180007B;
 Fri, 19 Jun 2026 18:39:23 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v3 14/18] net/dpaa: fix xstat string typos in BMI stats table
Date: Fri, 19 Jun 2026 16:08:57 +0530
Message-Id: <20260619103901.2274740-15-hemant.agrawal@nxp.com>
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
index 3d3f2773a1..3d6405d5fa 100644
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
2.43.0

