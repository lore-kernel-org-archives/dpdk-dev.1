Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E8CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 16:28:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D182040287;
	Fri, 19 Jun 2026 18:28:38 +0200 (CEST)
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com
 [209.85.219.98]) by mails.dpdk.org (Postfix) with ESMTP id 443484027C
 for <dev@dpdk.org>; Fri, 19 Jun 2026 18:28:37 +0200 (CEST)
Received: by mail-qv1-f98.google.com with SMTP id
 6a1803df08f44-8dcd895a4c0so24132966d6.3
 for <dev@dpdk.org>; Fri, 19 Jun 2026 09:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781886516; x=1782491316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMa2nZBwlOn0IXaHJJ17kx4hYqNDGCrILmFk8Y4EDOs=;
 b=U+SJw5aoNkJ+YEmvSXPjQFUn2Hp/qLoM5N8WQL3ANqSlWCCwz/smANkqc1OFO41SkT
 1fgsQ8/ESkhGNlQEhToQds5UwHWjuszr1+q/hOSHdcxHtQ7osWN84Gzx069tzxha+Pgb
 IH/9IpDYdh76APuwGFH/D5+R1O1tfS7CYYNErZDvhebleCRlcYPPiNkMdWZ5z3nvPKoH
 Aj1Phvu4GiQQaGJZFt0hDGvn6sp2hiDRCm7OX954Yp95sdyUIlY+MNAIMS9iiultnwFU
 48IAzEhDwG6lpA0HnMrHiak55u8zBo7+uh/o8fqI0LX1Ww6FBK0vDEUwduBXMNtEsw2E
 iYDg==
X-Gm-Message-State: AOJu0YyPcUGI86eT7b9NufxT6wSL8uiv8e9eC9ZfyQ29ZY4SSiyOdZAY
 hJaIjo1ItksvlSUpRIjVJyThFfvr0LJxd7MUmo4eYL2VHcqy5GySnhrI0ma/+XXMEWU/h0NYX9F
 fHK9P/Z6u/UncuQqzy4JdQ4JDuBKzHsap+sMvrf0K3BD+4XmKIqvUhERmWK0H3qLD3jtTPpLGzQ
 3HtWlPr/Cpouh7+ZMt0PjI8vHYIiWA6TgNZGpw7+oVVuFCuti/ucQ0ZjSgK/2XfwUIzbzlk64LH
 NnOp0jlIP1f
X-Gm-Gg: AfdE7ck4+IsSXX7U+2zjTDozoNUhkpna18/nXhaPRtmu8Kj74mOlK4iP9b7NWJgImKu
 z9orrtBDIExZalSIBaB0GDRhx1QfNXgeHOW//I0VwizysRoZ9K5f/9WvIYAZ3eLcYVdtXxXzO2D
 m4vfLzI6mU+A3I4dNFiPurgmdARmDAaWijUCnmQyK+NKhXsUX1fdalmDCpM0VNKxD385dzmOD3x
 0LCMnrlcLaVvm5OZKiwGXCY63ukG8dz6iemjUqymIKJ1p6cOjkoxpzgS0uCqvXw02G4motU0Yv8
 1UNbr+5a75D18ErpNSAi74lbxFtySxiFZjpG6fczCogoiz2z6QCvBjP5Yn/OjY3hrvkDeL3tkI8
 Dv6tmSwKRNsTr7tPz5O1se2Q+MYte1xKIbA+oilfBuwZtPvAmwXjeiloQIGWe/GmSv0DPq7MCt7
 5vffgKHy/2fhp9L7NEDbBltd77NIeYKZymWFdi2xTgX086nlk7euOqs6fyMj+A
X-Received: by 2002:a05:6214:3c97:b0:8ce:aace:eaf7 with SMTP id
 6a1803df08f44-8de4283c2bfmr70423006d6.39.1781886515975; 
 Fri, 19 Jun 2026 09:28:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8df830426e6sm158336d6.26.2026.06.19.09.28.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jun 2026 09:28:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c13bb8ca9so771705eec.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1781886515; x=1782491315; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMa2nZBwlOn0IXaHJJ17kx4hYqNDGCrILmFk8Y4EDOs=;
 b=X8pZfJkHnhHBhgk4eThhBnI5iUNxH3gGFMrU/k96uZP8y/k8vdkpXuyMcsD01DmXdU
 u8L9x7IbTPq6iHSX3+nf3pZEh43P6wEZWUgprpiw2AfmMzra/RbNbPH50EYz0zDSTYaf
 +tSqjIF0aWIsjEGJNw2RTsBmgYxsdYqEX5004=
X-Received: by 2002:a05:693c:2d8f:b0:30a:e52d:fa90 with SMTP id
 5a478bee46e88-30c06ff7617mr2851181eec.11.1781886514626; 
 Fri, 19 Jun 2026 09:28:34 -0700 (PDT)
X-Received: by 2002:a05:693c:2d8f:b0:30a:e52d:fa90 with SMTP id
 5a478bee46e88-30c06ff7617mr2851133eec.11.1781886513715; 
 Fri, 19 Jun 2026 09:28:33 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1be95ebfsm228662eec.31.2026.06.19.09.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 09:28:33 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Chenna Arnoori <chenna.arnoori@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: avoid link flap on flow control set
Date: Fri, 19 Jun 2026 10:31:02 -0600
Message-ID: <20260619163102.624652-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616232300.359253-1-mohammad-shuab.siddique@broadcom.com>
References: <20260616232300.359253-1-mohammad-shuab.siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Chenna Arnoori <chenna.arnoori@broadcom.com>

When OVS-DPDK reconciles port state, it calls flow_ctrl_get followed
by flow_ctrl_set if the returned configuration differs from its
database. The driver was reporting autoneg=1 whenever the firmware
had auto_pause set (including the AUTONEG_PAUSE bit 0x4), even
though no pause autoneg was actually requested. This mismatch
caused OVS to repeatedly call flow_ctrl_set, which triggered a
full link reconfig with PHY reset, flapping the link every time
any interface change occurred on the system.

Two problems were fixed. First, flow_ctrl_set was clearing all
autoneg bits instead of only the flow-control autoneg bit,
which also wiped the speed autoneg state. Second, the pause
set path was abandoning its own HWRM request and calling the
full link config function, which built a separate request
without the pause fields that set_pause_common would have
computed.

Port the kernel bnxt_en driver's approach: add a
set_link_common helper that merges link and speed fields into
an existing HWRM request, and rework set_pause to build a
single combined request with both pause and link fields when
a full reconfig is needed. When only pause changes without an
auto-to-force transition, a pause-only PHY config is sent
without a full link reprogram.

Fixes: 8aaf473bbed6 ("net/bnxt: add flow control operations")
Cc: stable@dpdk.org
Signed-off-by: Chenna Arnoori <chenna.arnoori@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 doc/guides/rel_notes/release_26_07.rst |  25 ++++
 drivers/net/bnxt/bnxt.h                |  10 ++
 drivers/net/bnxt/bnxt_ethdev.c         |  12 +-
 drivers/net/bnxt/bnxt_hwrm.c           | 151 +++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_hwrm.h           |   1 +
 5 files changed, 197 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b5285af5fe..ee80a37055 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -209,6 +209,31 @@ ABI Changes
 * No ABI change that would break compatibility with 25.11.
 
 
+Bug Fixes and Other Changes
+---------------------------
+
+.. This section should contain bug fixes added to the relevant
+   stable branch. Sample format:
+
+   * **code/area: Fixed issue in <component>.**
+
+     Fixed a specific issue with the following impact, caused by the following
+     action, and the resolution.
+
+   This section is a comment. Do not overwrite or remove it.
+   Also, make sure to start the actual text at the margin.
+   =======================================================
+
+* **net/bnxt: Fixed link flapping on flow control configuration.**
+
+  Fixed an issue where setting flow control parameters via
+  ``rte_eth_dev_flow_ctrl_set()`` triggered an unconditional PHY reset,
+  causing repeated link flaps in environments such as OVS-DPDK that
+  periodically reconcile port state. The fix ports the kernel bnxt_en
+  approach of building a combined pause+link HWRM request rather than
+  delegating to the full link reconfiguration path.
+
+
 Known Issues
 ------------
 
diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 7515f0564f..0ea18fb134 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -88,6 +88,8 @@
 #define HWRM_VERSION_1_9_1		0x10901
 #define HWRM_VERSION_1_9_2		0x10903
 #define HWRM_VERSION_1_10_2_13		0x10a020d
+/* Minimum spec version that supports AUTONEG_PAUSE bit in auto_pause field */
+#define HWRM_SPEC_CODE_AUTONEG_PAUSE	0x10201
 
 #define BNXT_MAX_MTU		9574
 #define BNXT_NUM_VLANS		2
@@ -333,6 +335,14 @@ struct bnxt_link_info {
 	uint8_t                 active_lanes;
 	uint8_t			option_flags;
 	uint16_t                pmd_speed_lanes;
+	/* Bitmask tracking which autoneg modes are active */
+	uint8_t			autoneg;
+#define BNXT_AUTONEG_SPEED		1 /* speed autoneg enabled */
+#define BNXT_AUTONEG_FLOW_CTRL		2 /* pause/flow-ctrl autoneg enabled */
+	/* True after autoneg->forced FC transition; cleared once set_pause
+	 * sends the combined pause+link HWRM request successfully.
+	 */
+	bool			link_reconfig_needed;
 };
 
 #define BNXT_COS_QUEUE_COUNT	8
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 1b8cf3a52a..467b551bd9 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2565,7 +2565,7 @@ static int bnxt_flow_ctrl_get_op(struct rte_eth_dev *dev,
 		return rc;
 
 	memset(fc_conf, 0, sizeof(*fc_conf));
-	if (bp->link_info->auto_pause)
+	if (bp->link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)
 		fc_conf->autoneg = 1;
 	switch (bp->link_info->pause) {
 	case 0:
@@ -2601,6 +2601,14 @@ static int bnxt_flow_ctrl_set_op(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 	}
 
+	if (fc_conf->autoneg) {
+		bp->link_info->autoneg |= BNXT_AUTONEG_FLOW_CTRL;
+	} else {
+		if (bp->link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)
+			bp->link_info->link_reconfig_needed = true;
+		bp->link_info->autoneg &= ~BNXT_AUTONEG_FLOW_CTRL;
+	}
+
 	switch (fc_conf->mode) {
 	case RTE_ETH_FC_NONE:
 		bp->link_info->auto_pause = 0;
@@ -2642,7 +2650,7 @@ static int bnxt_flow_ctrl_set_op(struct rte_eth_dev *dev,
 		}
 		break;
 	}
-	return bnxt_set_hwrm_link_config(bp, true);
+	return bnxt_hwrm_set_pause(bp);
 }
 
 /* Add UDP tunneling port */
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 0c82935de9..a0983183c0 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1876,6 +1876,22 @@ static int bnxt_hwrm_port_phy_qcfg(struct bnxt *bp,
 	link_info->auto_pause = resp->auto_pause;
 	link_info->force_pause = resp->force_pause;
 	link_info->auto_mode = resp->auto_mode;
+	link_info->autoneg = 0;
+
+	if (link_info->auto_mode != HWRM_PORT_PHY_QCFG_OUTPUT_AUTO_MODE_NONE) {
+		link_info->autoneg = BNXT_AUTONEG_SPEED;
+		if (bp->hwrm_spec_code >= HWRM_SPEC_CODE_AUTONEG_PAUSE) {
+			if (link_info->auto_pause &
+			    HWRM_PORT_PHY_CFG_INPUT_AUTO_PAUSE_AUTONEG_PAUSE)
+				link_info->autoneg |=
+					BNXT_AUTONEG_FLOW_CTRL;
+		} else {
+			link_info->autoneg |= BNXT_AUTONEG_FLOW_CTRL;
+		}
+	} else {
+		link_info->autoneg = 0;
+	}
+
 	link_info->phy_type = resp->phy_type;
 	link_info->media_type = resp->media_type;
 
@@ -4048,6 +4064,141 @@ static int bnxt_hwrm_port_phy_cfg_v2(struct bnxt *bp, struct bnxt_link_info *con
 	return rc;
 }
 
+static void
+bnxt_hwrm_set_pause_common(struct bnxt *bp,
+			   struct hwrm_port_phy_cfg_input *req)
+{
+	struct bnxt_link_info *link_info = bp->link_info;
+
+	if (link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL) {
+		if (bp->hwrm_spec_code >= HWRM_SPEC_CODE_AUTONEG_PAUSE)
+			req->auto_pause =
+			    HWRM_PORT_PHY_CFG_INPUT_AUTO_PAUSE_AUTONEG_PAUSE;
+		if (link_info->auto_pause &
+		    HWRM_PORT_PHY_CFG_INPUT_AUTO_PAUSE_RX)
+			req->auto_pause |=
+			    HWRM_PORT_PHY_CFG_INPUT_AUTO_PAUSE_RX;
+		if (link_info->auto_pause &
+		    HWRM_PORT_PHY_CFG_INPUT_AUTO_PAUSE_TX)
+			req->auto_pause |=
+			    HWRM_PORT_PHY_CFG_INPUT_AUTO_PAUSE_TX;
+		req->enables |=
+			rte_cpu_to_le_32(HWRM_PORT_PHY_CFG_INPUT_ENABLES_AUTO_PAUSE);
+	} else {
+		if (link_info->force_pause &
+		    HWRM_PORT_PHY_CFG_INPUT_FORCE_PAUSE_RX)
+			req->force_pause |=
+			    HWRM_PORT_PHY_CFG_INPUT_FORCE_PAUSE_RX;
+		if (link_info->force_pause &
+		    HWRM_PORT_PHY_CFG_INPUT_FORCE_PAUSE_TX)
+			req->force_pause |=
+			    HWRM_PORT_PHY_CFG_INPUT_FORCE_PAUSE_TX;
+		req->enables |=
+			rte_cpu_to_le_32(HWRM_PORT_PHY_CFG_INPUT_ENABLES_FORCE_PAUSE);
+		if (bp->hwrm_spec_code >= HWRM_SPEC_CODE_AUTONEG_PAUSE) {
+			req->auto_pause = req->force_pause;
+			req->enables |=
+				rte_cpu_to_le_32(HWRM_PORT_PHY_CFG_INPUT_ENABLES_AUTO_PAUSE);
+		}
+	}
+}
+
+static void
+bnxt_hwrm_set_link_common(struct bnxt *bp, struct hwrm_port_phy_cfg_input *req)
+{
+	struct rte_eth_conf *dev_conf = &bp->eth_dev->data->dev_conf;
+	uint16_t autoneg, speed;
+
+	autoneg = bnxt_check_eth_link_autoneg(dev_conf->link_speeds);
+
+	if (BNXT_CHIP_P5(bp) &&
+	    dev_conf->link_speeds & RTE_ETH_LINK_SPEED_40G)
+		autoneg = 0;
+
+	if (autoneg == 1 && BNXT_CHIP_P5(bp) &&
+	    bp->link_info->auto_mode == 0 &&
+	    bp->link_info->force_pam4_link_speed ==
+	    HWRM_PORT_PHY_CFG_INPUT_FORCE_PAM4_LINK_SPEED_200GB)
+		autoneg = 0;
+
+	speed = bnxt_parse_eth_link_speed(bp, dev_conf->link_speeds,
+					  bp->link_info);
+	req->flags |=
+		rte_cpu_to_le_32(HWRM_PORT_PHY_CFG_INPUT_FLAGS_RESET_PHY);
+
+	if (autoneg == 1 &&
+	    (bp->link_info->support_auto_speeds ||
+	     bp->link_info->support_pam4_auto_speeds)) {
+		uint16_t spd_mask;
+		uint32_t en;
+
+		req->flags |=
+			rte_cpu_to_le_32(HWRM_PORT_PHY_CFG_INPUT_FLAGS_RESTART_AUTONEG);
+		spd_mask = bnxt_parse_eth_link_speed_mask(bp,
+							  dev_conf->link_speeds);
+		req->auto_link_speed_mask = rte_cpu_to_le_16(spd_mask);
+		req->auto_link_pam4_speed_mask =
+			rte_cpu_to_le_16(bp->link_info->auto_pam4_link_speed_mask);
+		en = HWRM_PORT_PHY_CFG_IN_EN_AUTO_LINK_SPEED_MASK |
+		     HWRM_PORT_PHY_CFG_IN_EN_AUTO_PAM4_LINK_SPD_MASK |
+		     HWRM_PORT_PHY_CFG_INPUT_ENABLES_AUTO_MODE;
+		req->enables |= rte_cpu_to_le_32(en);
+		req->auto_mode =
+			HWRM_PORT_PHY_CFG_INPUT_AUTO_MODE_SPEED_MASK;
+	} else {
+		uint32_t en;
+
+		req->flags |=
+			rte_cpu_to_le_32(HWRM_PORT_PHY_CFG_INPUT_FLAGS_FORCE);
+		if (speed) {
+			if (bp->link_info->link_signal_mode) {
+				req->force_pam4_link_speed =
+					rte_cpu_to_le_16(speed);
+				en = HWRM_PORT_PHY_CFG_IN_EN_FORCE_PAM4_LINK_SPEED;
+				req->enables |= rte_cpu_to_le_32(en);
+			} else {
+				req->force_link_speed =
+					rte_cpu_to_le_16(speed);
+			}
+		}
+	}
+	req->auto_duplex =
+		bnxt_parse_eth_link_duplex(dev_conf->link_speeds);
+	req->enables |=
+		rte_cpu_to_le_32(HWRM_PORT_PHY_CFG_INPUT_ENABLES_AUTO_DUPLEX);
+}
+
+int bnxt_hwrm_set_pause(struct bnxt *bp)
+{
+	struct hwrm_port_phy_cfg_input req = {0};
+	struct hwrm_port_phy_cfg_output *resp = bp->hwrm_cmd_resp_addr;
+	struct bnxt_link_info *link_info = bp->link_info;
+	int rc;
+
+	HWRM_PREP(&req, HWRM_PORT_PHY_CFG, BNXT_USE_CHIMP_MB);
+
+	bnxt_hwrm_set_pause_common(bp, &req);
+
+	if ((link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL) ||
+	    link_info->link_reconfig_needed)
+		bnxt_hwrm_set_link_common(bp, &req);
+
+	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
+
+	HWRM_CHECK_RESULT();
+
+	if (!rc) {
+		if (!(link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)) {
+			link_info->pause = link_info->force_pause;
+			link_info->auto_pause = 0;
+		}
+		link_info->link_reconfig_needed = false;
+	}
+
+	HWRM_UNLOCK();
+	return rc;
+}
+
 static int bnxt_set_hwrm_link_config_v2(struct bnxt *bp, bool link_up)
 {
 	struct rte_eth_conf *dev_conf = &bp->eth_dev->data->dev_conf;
diff --git a/drivers/net/bnxt/bnxt_hwrm.h b/drivers/net/bnxt/bnxt_hwrm.h
index fc56223ab4..3034803023 100644
--- a/drivers/net/bnxt/bnxt_hwrm.h
+++ b/drivers/net/bnxt/bnxt_hwrm.h
@@ -261,6 +261,7 @@ void bnxt_free_hwrm_rx_ring(struct bnxt *bp, int queue_index);
 int bnxt_alloc_hwrm_resources(struct bnxt *bp);
 int bnxt_get_hwrm_link_config(struct bnxt *bp, struct rte_eth_link *link);
 int bnxt_set_hwrm_link_config(struct bnxt *bp, bool link_up);
+int bnxt_hwrm_set_pause(struct bnxt *bp);
 int bnxt_hwrm_func_qcfg(struct bnxt *bp, uint16_t *mtu);
 int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp);
 int bnxt_hwrm_func_reserve_vf_resc(struct bnxt *bp, bool test);
-- 
2.47.3

