Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8E606A338
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A88DC40E49;
	Fri, 23 Oct 2026 15:44:27 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id DBE2640E34
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:18 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C000A1A0044;
 Fri, 23 Oct 2026 15:44:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A8651A0038;
 Fri, 23 Oct 2026 15:44:18 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 30FFB180006C;
 Fri, 23 Oct 2026 21:44:17 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 24/65] net/dpaa2: add policer v2 MC command and L2/L3
 byte units
Date: Fri, 23 Oct 2026 19:13:04 +0530
Message-ID: <20261023134346.37727-25-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Pick up the v2 version of the DPNI SET_RX_TC_POLICING MC command and
expose the new policer features it brings, while keeping support
for older MC firmwares that only speak the v1 command.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/mc/dpni.c     | 54 +++++++++++++++++++++------------
 drivers/net/dpaa2/mc/fsl_dpni.h | 23 +++++++++++---
 2 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index 54df66416a..8e4114e604 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -2210,30 +2210,16 @@ int dpni_clear_fs_entries(struct fsl_mc_io *mc_io,
 	return mc_send_command(mc_io, &cmd);
 }
 
-/**
- * dpni_set_rx_tc_policing() - Set Rx traffic class policing configuration
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPNI object
- * @tc_id:	Traffic class selection (0-7)
- * @cfg:	Traffic class policing configuration
- *
- * Return:	'0' on Success; error code otherwise.
- */
-int dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
-			    uint32_t cmd_flags,
-			    uint16_t token,
-			    uint8_t tc_id,
-			    const struct dpni_rx_tc_policing_cfg *cfg)
+static int
+_dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags, uint16_t token, uint8_t tc_id,
+	const struct dpni_rx_tc_policing_cfg *cfg, uint16_t cmd_id)
 {
 	struct dpni_cmd_set_rx_tc_policing *cmd_params;
 	struct mc_command cmd = { 0 };
 
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_RX_TC_POLICING,
-					  cmd_flags,
-					  token);
-	cmd_params = (struct dpni_cmd_set_rx_tc_policing *)cmd.params;
+	cmd.header = mc_encode_cmd_header(cmd_id, cmd_flags, token);
+	cmd_params = (void *)cmd.params;
 	dpni_set_field(cmd_params->mode_color, COLOR, cfg->default_color);
 	dpni_set_field(cmd_params->mode_color, MODE, cfg->mode);
 	dpni_set_field(cmd_params->units, UNITS, cfg->units);
@@ -2248,6 +2234,34 @@ int dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
 	return mc_send_command(mc_io, &cmd);
 }
 
+/**
+ * dpni_set_rx_tc_policing() - Set Rx traffic class policing configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPNI object
+ * @tc_id:	Traffic class selection (0-7)
+ * @cfg:	Traffic class policing configuration
+ *
+ * Return:	'0' on Success; error code otherwise.
+ */
+int
+dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags, uint16_t token, uint8_t tc_id,
+	const struct dpni_rx_tc_policing_cfg *cfg)
+{
+	return _dpni_set_rx_tc_policing(mc_io, cmd_flags, token, tc_id, cfg,
+		DPNI_CMDID_SET_RX_TC_POLICING);
+}
+
+int
+dpni_set_rx_tc_policing_v1(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags, uint16_t token, uint8_t tc_id,
+	const struct dpni_rx_tc_policing_cfg *cfg)
+{
+	return _dpni_set_rx_tc_policing(mc_io, cmd_flags, token, tc_id, cfg,
+		DPNI_CMDID_SET_RX_TC_POLICING_V1);
+}
+
 /**
  * dpni_get_rx_tc_policing() - Get Rx traffic class policing configuration
  * @mc_io:	Pointer to MC portal's I/O object
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 4bec348545..9e6dc23f66 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -1141,6 +1141,11 @@ int dpni_set_rx_tc_dist(struct fsl_mc_io *mc_io,
  */
 #define DPNI_POLICER_OPT_DISCARD_RED	0x00000002
 
+/**
+ * Do NOT reset counters generally for policer update
+ */
+#define DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS	0x00000004
+
 /**
  * enum dpni_policer_mode - selecting the policer mode
  * @DPNI_POLICER_MODE_NONE: Policer is disabled
@@ -1157,12 +1162,17 @@ enum dpni_policer_mode {
 
 /**
  * enum dpni_policer_unit - DPNI policer units
- * @DPNI_POLICER_UNIT_BYTES: bytes units
+ * @DPNI_POLICER_UNIT_BYTES_L3: bytes units (for each frame takes into account
+ * FD length - L3 offset)
  * @DPNI_POLICER_UNIT_FRAMES: frames units
+ * @DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS: bytes units (for each frame takes
+ * into account FD length - L2 offset, which means L2 size without the 4 bytes
+ * for the FCS)
  */
 enum dpni_policer_unit {
-	DPNI_POLICER_UNIT_BYTES = 0,
-	DPNI_POLICER_UNIT_FRAMES
+	DPNI_POLICER_UNIT_BYTES_L3 = 0,
+	DPNI_POLICER_UNIT_FRAMES,
+	DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS,
 };
 
 /**
@@ -1203,13 +1213,18 @@ struct dpni_rx_tc_policing_cfg {
 	uint32_t ebs;
 };
 
-
 int dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
 			    uint32_t cmd_flags,
 			    uint16_t token,
 			    uint8_t tc_id,
 			    const struct dpni_rx_tc_policing_cfg *cfg);
 
+int dpni_set_rx_tc_policing_v1(struct fsl_mc_io *mc_io,
+			    uint32_t cmd_flags,
+			    uint16_t token,
+			    uint8_t tc_id,
+			    const struct dpni_rx_tc_policing_cfg *cfg);
+
 int dpni_get_rx_tc_policing(struct fsl_mc_io *mc_io,
 			    uint32_t cmd_flags,
 			    uint16_t token,
-- 
2.43.0

