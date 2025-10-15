Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA67CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70E8E410FC;
	Wed, 15 Oct 2025 11:05:30 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id 62C2940E35
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:28 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-7e3148a8928so80392996d6.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519128; x=1761123928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=IkalQ68mnpA2MfYpMQ4U2keTVos3qh0YvI9Z8o39dU45ys4KNr0gZtaFFhtTFEjnPp
 Cqn90x8sE8jA4i+cXxKNBDBice3UE4MfOopXDWP2w/o6vOu68B/UVHvGj5D9SI77O3XN
 JnIGU6zAraem4np8A/wv8sdzrITNEDD4IJ1ktw5oL4A93zwakk8xUzsC2iRkETn+GPax
 lxykaN4iohmw6f3VaPLuxbbzjlhu5clpl+mY5+iQ2vGSSNrgYOyAGfW7cHMVTe+V8nWu
 IQUMGxJzzCtinbucBisIsp3RuuK+ejCDfvF26iY9Vve70LbBQNI0fMNBhNtWsamnfF0R
 ToEA==
X-Gm-Message-State: AOJu0YwTqGp0WEW6Yn15xfqVQqoYAseEkrv47RXEKq6tibkZEoCbbGF5
 wsMKN5Kvyy9TpTRa3oWJJO4PhdQVsknByFz0bolBugzeTYqvd5nv6V9k+rDBm1/1l5ZjeJ4URWd
 HRQycOO31fUmxaMUZbGpH2OYuh74Jy/ya1Vne7zIqs/8SR5Tj/94ZHnLXtBOKMymALc9fqdXlQZ
 XgnKDkejFxpvpZyFmBefHva2HGCUJC/2gLe4dx2pF27R0wkCQy7meMC1FVhvTQestLfkBU/w==
X-Gm-Gg: ASbGncu0Ms4FNHG6l9jkzAFcLULB3nOCmjX/4wzCTPDAExZ5foxCsUVumrGjJ6yDT4l
 jkoMMfmRl8R5xy+BsbxT1IMsOguCEdLDF4HDQSKKA+QkvG34EfxRoZ4fcDjmE3NkZnXRU0nNc8q
 x9MFO1O9dBGAU81H8eIgjoOjlC2EKG9c25IZnZOYjII8djlbLDPNJt26elwdgKr1c4GZynTJB6Q
 PWLrLqif4usQmvZKFRpZovmcIBWLu36EIQKmF0ypTCkr/XToO0IWIZQPEbk1SAKm2rmkmebXB76
 JgpO5472Cw0DdQn9TyovNIY1Hwl3PAQRCrnVU5cjcFnIXlha40z/RN5EpsQMf31EKkA5rGLZcVO
 BEz/RobF4Vaf+yjLkLW/KfdP5MXTOuRZcz1t0290mDpn+Ia6A5yAx+WfsYnkg9X8rpnieLnD9wi
 siwg==
X-Google-Smtp-Source: AGHT+IGFoWZ+WSABI2irE+Si1HkgclX4DCJbQXMAzl1epccdK/dlTO/QXC93cyTCy7m7JLNVP+LGFX/AaUfT
X-Received: by 2002:a05:6214:2245:b0:799:d980:a41c with SMTP id
 6a1803df08f44-87b21065cd8mr412992356d6.20.1760519127662; 
 Wed, 15 Oct 2025 02:05:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87c0129fa4dsm1994746d6.31.2025.10.15.02.05.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7a144677fd9so1740154b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519126; x=1761123926; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=gyed2HjZg42Uhbq7ZsQhpKqwx8vBvGnkSNiehcabzfyGghog/u3RWf8Bg0tyvyvOW0
 fOviJMNhSXCBqvEHCeER05j14VWUR20rronBfpiHYsemwyCzMFR+TEtf3xmZ8QJIMGn+
 rXVvKIMkTi4dbgU9wfJI+Srd0aGkTwEv9J1yw=
X-Received: by 2002:a05:6a00:2e99:b0:781:27a7:dd00 with SMTP id
 d2e1a72fcca58-79385325660mr34085108b3a.2.1760519126158; 
 Wed, 15 Oct 2025 02:05:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e99:b0:781:27a7:dd00 with SMTP id
 d2e1a72fcca58-79385325660mr34085050b3a.2.1760519125455; 
 Wed, 15 Oct 2025 02:05:25 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:25 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 47/54] net/bnxt/tf_ulp: truflow add pf action handler
Date: Wed, 15 Oct 2025 05:00:17 -0400
Message-Id: <20251015090024.32250-48-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

From: Shahaji Bhosle <shahaji.bhosle@broadcom.com>

Update pf action handler callback to use parent PF vnic

Signed-off-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 42 ++++++++++++++++--------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
index ceda1ff5ef..82baf722cd 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
@@ -2946,30 +2946,44 @@ int32_t
 ulp_rte_pf_act_handler(const struct rte_flow_action *action_item __rte_unused,
 		       struct ulp_rte_parser_params *params)
 {
+	struct bnxt *bp;
 	uint32_t port_id;
-	uint32_t ifindex;
-	enum bnxt_ulp_intf_type intf_type;
+	enum bnxt_ulp_direction_type dir;
+	struct ulp_rte_act_prop *act = &params->act_prop;
 
 	/* Get the port id of the current device */
 	port_id = ULP_COMP_FLD_IDX_RD(params, BNXT_ULP_CF_IDX_INCOMING_IF);
 
-	/* Get the port db ifindex */
-	if (ulp_port_db_dev_port_to_ulp_index(params->ulp_ctx, port_id,
-					      &ifindex)) {
-		BNXT_DRV_DBG(ERR, "Invalid port id\n");
+	params->port_id = port_id;
+	bp = bnxt_pmd_get_bp(params->port_id);
+	if (bp == NULL) {
+		BNXT_DRV_DBG(ERR, "Invalid bp");
 		return BNXT_TF_RC_ERROR;
 	}
 
-	/* Check the port is PF port */
-	intf_type = ulp_port_db_port_type_get(params->ulp_ctx, ifindex);
-	if (intf_type != BNXT_ULP_INTF_TYPE_PF) {
-		BNXT_DRV_DBG(ERR, "Port is not a PF port\n");
+	ULP_COMP_FLD_IDX_WR(params, BNXT_ULP_CF_IDX_ACT_PORT_TYPE, BNXT_ULP_INTF_TYPE_PF);
+
+	/* Get the direction */
+	dir = ULP_COMP_FLD_IDX_RD(params, BNXT_ULP_CF_IDX_DIRECTION);
+	if (dir == BNXT_ULP_DIR_EGRESS) {
+		BNXT_DRV_DBG(ERR, "Invalid direction");
 		return BNXT_TF_RC_ERROR;
+	} else {
+		uint16_t pid_s = bp->parent->vnic;
+		uint32_t pid = pid_s;
+		pid = rte_cpu_to_be_32(pid);
+		memcpy(&act->act_details[BNXT_ULP_ACT_PROP_IDX_VNIC],
+		       &pid, BNXT_ULP_ACT_PROP_SZ_VNIC);
+		/*
+		 * Update appropriate port (A/B) VNIC based on multi-port
+		 * indication.
+		 */
+		ULP_COMP_FLD_IDX_WR(params, BNXT_ULP_CF_IDX_MP_VNIC_A, pid_s);
 	}
-	/* Update the action properties */
-	ULP_COMP_FLD_IDX_WR(params, BNXT_ULP_CF_IDX_ACT_PORT_TYPE, intf_type);
-	return ulp_rte_parser_act_port_set(params, ifindex, false,
-					   BNXT_ULP_DIR_INVALID);
+
+	/* Update the action port set bit */
+	ULP_COMP_FLD_IDX_WR(params, BNXT_ULP_CF_IDX_ACT_PORT_IS_SET, 1);
+	return BNXT_TF_RC_SUCCESS;
 }
 
 /* Function to handle the parsing of RTE Flow action VF. */
-- 
2.39.5 (Apple Git-154)

