Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B9DCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:13:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEF8940E35;
	Thu, 18 Jun 2026 16:12:22 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7D96940268;
 Thu, 18 Jun 2026 16:12:11 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 649491A002F;
 Thu, 18 Jun 2026 16:12:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D12E1A0010;
 Thu, 18 Jun 2026 16:12:11 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 92031180007B;
 Thu, 18 Jun 2026 22:12:09 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 13/17] net/dpaa: fix xstat string typos in BMI stats table
Date: Thu, 18 Jun 2026 19:41:47 +0530
Message-Id: <20260618141151.3990283-14-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
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

Fix two issues in the xstats name table:
- 'rx_frame_discrad_count' is a misspelling, correct to
  'rx_frame_discard_count'
- 'rx_out_of_buffer_discard ' has a trailing space, remove it

Fixes: d2536b006d ("bus/dpaa: add port buffer manager stats")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 3d3f2773a1..921566123d 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -135,11 +135,11 @@ static const struct rte_dpaa_xstats_name_off dpaa_xstats_strings[] = {
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
 	{"rx_buf_diallocate",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rbdc)},
-- 
2.43.0

