Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE943CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 23:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8438D4027A;
	Wed, 17 Jun 2026 01:20:38 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 851504027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 01:20:36 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-7e16f05fd79so55199397b3.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 16:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781652036; x=1782256836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jak2QNEMZNmf87bhPuVKevylsE82SUfv6ciPLqiwiZ4=;
 b=D7Qqht47nkEfYYdD13nbu1QkS+47628FTWS8dNYyNl2W2XL5obkvCYZbgmvpiSc7nt
 ngFGJbEbOSpre7oKNbJsLiYYTzgWKQt2f8cjEq3YIm+8cyzwkWl5FRhwqbdJdU48vQa+
 Oojyyvlu9XNvx4kXuvHAlH1azr9BJ4+i8jZ303vAdNXZMbav0z51K06mROgBseZjrtd4
 AbLX0JaWPksDrrGXxRpBhALM/s/Lw8PPPBADbB1HL5tb0I35W1os+eylX5VzJJi0+hGr
 bXnfdK8vUYLd+RCOwDegVvDuObQ5+PLn1dIGkpfteNgA8qfoRo0OUhc2O1x1g+5pGkLY
 HPJw==
X-Gm-Message-State: AOJu0YyaaTB3X/FQ+IUyc8B0Mm5o8ZosAQT6yomycxH0E3/tOvwb6Cie
 tR4CF7IDOYRdWZm0ury7tiNKuP0DVJsC9yash4D+UEdUxnt9GER+ViiQi6NZJNAHNicx+vBVf0m
 8jSVAfmepLO5idOPkOU1RhtxsUn7iWbHHa+5OoJomrNl3/NGksLlN/ZYL5PAIhSgX2Hkt9gF1JY
 FOIE9V/dqfgPTasxZ/A3U1otRrSpkDpOI1Qh/12uK24WcpbkDa5VhR1yOGaAUUy66wK/I6Ls1ei
 p+ZShn4Hjd9
X-Gm-Gg: AfdE7clE1d41AG1rA5Rf79lwnTiYRr0w6OVhXg5MK0g0W0vGuWXP9GmnkyEG+436WuG
 FykqWhVK1vozrB3WCoyIoXVkVwVVLOMo3NEnLQZK2Aos39WTjpixYixt97ywTSd1MOn5ES6Vl6G
 W+PyF4NCF9XkbF0v6TQyqmFrdEvl51X4MSedep2iingfODgAcZVyJIK96jwqx//0B9U2EIxi3jS
 NJ0ZR444V7dY6IDD46jxmxp39IbCvooHevm3FbqJf9h3ZoOIeWfU26h7gFbqgjwaMeZ6R0D/QL7
 qcTJBnPa27RwpFBMgoWyfKDhE8HuqgxUYfxjfGvM6lKwfaOGSZEx5L4D6iFTGpjyaWXPp5FF5P5
 9b2/r6/zWOWM5rX5LxcFe9xwn7JAsymKwaADTvbRtxOHq2/pWkuSz8RJ7/KSXJ5sZ/43lIbYXzA
 wOxHj5ldFHinoLrsPyES7T1d+6fFPcwgScR+NM1wIxaR8xRmgPvV37BcA7w5u7SqEhCB5lBG0=
X-Received: by 2002:a53:ac8f:0:b0:662:b2e3:cd50 with SMTP id
 956f58d0204a3-662cd5a268dmr940358d50.28.1781652035587; 
 Tue, 16 Jun 2026 16:20:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-66274dd7ce2sm1100659d50.26.2026.06.16.16.20.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jun 2026 16:20:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-307625ee07fso18068427eec.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1781652034; x=1782256834; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jak2QNEMZNmf87bhPuVKevylsE82SUfv6ciPLqiwiZ4=;
 b=GGAqpnj4l5gm2AJn/fk+mKyCNYZ7ruUrEBpBQQivUEXIevqjDsg7crClqgk7wBF6al
 3GRl1T/MAKyZBlntuQHWqM/6mCdl995av1zZMD4ebvfuoXj1VgcdXdJWBZZP7xTPCVQr
 dSz8YKTokRdRFjFoziOu6X2q+2mCYgyAtbZ9c=
X-Received: by 2002:a05:7300:e82e:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-30bca09cf59mr793365eec.19.1781652034258; 
 Tue, 16 Jun 2026 16:20:34 -0700 (PDT)
X-Received: by 2002:a05:7300:e82e:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-30bca09cf59mr793343eec.19.1781652033445; 
 Tue, 16 Jun 2026 16:20:33 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea43b80sm19579231eec.21.2026.06.16.16.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 16:20:33 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Chenna Arnoori <chenna.arnoori@broadcom.com>
Subject: [PATCH] net/bnxt: avoid link flap on flow control set
Date: Tue, 16 Jun 2026 17:23:00 -0600
Message-ID: <20260616232300.359253-1-mohammad-shuab.siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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
 drivers/net/bnxt/bnxt.h        |   4 +
 drivers/net/bnxt/bnxt_ethdev.c |  12 ++-
 drivers/net/bnxt/bnxt_hwrm.c   | 148 +++++++++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_hwrm.h   |   1 +
 4 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 7515f0564f..066a6fd478 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -333,6 +333,10 @@ struct bnxt_link_info {
 	uint8_t                 active_lanes;
 	uint8_t			option_flags;
 	uint16_t                pmd_speed_lanes;
+	uint8_t			autoneg;
+#define BNXT_AUTONEG_SPEED		1
+#define BNXT_AUTONEG_FLOW_CTRL		2
+	bool			force_link_chng;
 };
 
 #define BNXT_COS_QUEUE_COUNT	8
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 1b8cf3a52a..23a6b193b7 100644
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
+			bp->link_info->force_link_chng = true;
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
index 0c82935de9..e333b3d182 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1876,6 +1876,21 @@ static int bnxt_hwrm_port_phy_qcfg(struct bnxt *bp,
 	link_info->auto_pause = resp->auto_pause;
 	link_info->force_pause = resp->force_pause;
 	link_info->auto_mode = resp->auto_mode;
+
+	if (link_info->auto_mode != HWRM_PORT_PHY_QCFG_OUTPUT_AUTO_MODE_NONE) {
+		link_info->autoneg = BNXT_AUTONEG_SPEED;
+		if (bp->hwrm_spec_code >= 0x10201) {
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
 
@@ -4048,6 +4063,139 @@ static int bnxt_hwrm_port_phy_cfg_v2(struct bnxt *bp, struct bnxt_link_info *con
 	return rc;
 }
 
+static void
+bnxt_hwrm_set_pause_common(struct bnxt *bp,
+			   struct hwrm_port_phy_cfg_input *req)
+{
+	struct bnxt_link_info *link_info = bp->link_info;
+
+	if (link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL) {
+		if (bp->hwrm_spec_code >= 0x10201)
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
+		if (bp->hwrm_spec_code >= 0x10201) {
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
+	    link_info->force_link_chng)
+		bnxt_hwrm_set_link_common(bp, &req);
+
+	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
+
+	HWRM_CHECK_RESULT();
+
+	if (!rc && !(link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)) {
+		link_info->pause = link_info->force_pause;
+		link_info->auto_pause = 0;
+	}
+	link_info->force_link_chng = false;
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

