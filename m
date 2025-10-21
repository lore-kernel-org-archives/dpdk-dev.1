Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA8DCCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:59:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C23E4275C;
	Tue, 21 Oct 2025 20:58:36 +0200 (CEST)
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97]) by mails.dpdk.org (Postfix) with ESMTP id BFB0F4161A
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:33 +0200 (CEST)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-3c97813e788so3548109fac.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073113; x=1761677913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=SoqpJwR9SSqnLNuNWRPbtkLbj0FoJNbXEXRRH0BJB7ClTW34q+vjw2P6C+6O+HV2B+
 +DmvWNlF6zc7W3QTADVvoaqqH+V11NhEEgKr/PnLCBQ8gj89WKxTDAjLwKXulDOc8Tt6
 mItRZvza5TpP+VDx4SfboE5V9tN0ow4z/HIkEbVuGoMC78/Y/xd0snlWhvNcdLCPzkGS
 7GLxeVRuL4ORxyfM1Nswyz9nxXXKc9yQAT6eoL2jWejLDscbyEk1YSCLekRx6ERx+mOY
 56twL+9QLD8anIbfKv0HuZAdgZ3LWU/ndi1ludDCsrkjRE1wYBSDiPTcHgd9EPIuGv5o
 5xSA==
X-Gm-Message-State: AOJu0YwlPbY+IFCgynpFG0zNEU2KVQGqD/pfnoT2qn/Ue9Je6sB5heHV
 vlNGp2I76y+u2SEBkGt3Ut92IAbCFQvTsyHE/Ckc7lSUgZ25adLxaNM+zS1gVJjrm+jVxr/prGk
 iD86Zu5nQO2ymZFwCG3dWeS7o2P9q7dVkYA2nJ6hG36UZ/Nw82FAsZHshOl+QTDqL8HASsSdX0L
 HJafwiaQ2M5G5iTy2wx4IG4x086Y8Act9S0gos8vU+OfvVPz4zdfbB70dzkxchvq9Ap73uoQ==
X-Gm-Gg: ASbGncuEhYnhNIzkeunHAXIHDFSBbzkKz1b2JgfQzoHfIX1WhxMD+1vo1J1WfzGhECP
 gEgDJejgxToTZZv3ZhdsCeOQuzUfwJot7DHCO40TJBNaW9EYSuNnTHHgaI+ym4WoGKXJnZ/IJ2c
 RQlFSXdhivH//R6BtcEe5Avqnz/MJogm9UrlO931YGqkjeFGLktfgoIi9QhvLpmM/4ibyt4VJjH
 sW9vDsQjCYTU3UtnldqJeQ4Pbha+oW/NPyMHm4DIc7qpaxCbjz8LfQNSaR4YmlZpFF9/pFomGk1
 4lgi/r50bIXWwSeCk05hqm4ia9b7/V4266W9IKQo06Fq+1Nm39SnS71AAMJbSwICDxrlrJmU7ec
 fLnnTFuNnez6OuhseNrf1cxQHPaJUG14tC87obtTYBzHWdmFozhcOrwJ5jKPOktvCgKLqPFDZRf
 lZhf489j9n9iVJZLvmpre0Q4ICfew4UR87pEpg
X-Google-Smtp-Source: AGHT+IF+YansOf7GkSwj548zoSHr7eBGoxD9s3R5l0o1/0JovcBpDZlS+4TRAyHLJaMOSOgo4Jy28F1rNBEw
X-Received: by 2002:a05:6871:6e17:b0:3c9:c364:a47c with SMTP id
 586e51a60fabf-3c9c364b50emr3903088fac.32.1761073112972; 
 Tue, 21 Oct 2025 11:58:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c9af1f0540sm1411629fac.13.2025.10.21.11.58.32
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-26985173d8eso151513435ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073111; x=1761677911; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=GlKTJfaS7J2MhwnT40kBokNEXpQoJPo4PaktgpzbSz/W7whFjbbR5PA/68Z6Qak/HU
 ynvaz8Tja8N0NU8PEbmoOgHM/r8up94T0cUU0mTiZXo6yR/NWWngVRQGOudoawQNydWt
 mLIjQihR+OMgalMdVszTSmCKO47fF1QTW5IQ4=
X-Received: by 2002:a17:903:440c:b0:264:8a8d:92dd with SMTP id
 d9443c01a7336-290c9cb8b95mr224387235ad.20.1761073111289; 
 Tue, 21 Oct 2025 11:58:31 -0700 (PDT)
X-Received: by 2002:a17:903:440c:b0:264:8a8d:92dd with SMTP id
 d9443c01a7336-290c9cb8b95mr224386895ad.20.1761073110800; 
 Tue, 21 Oct 2025 11:58:30 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:30 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 50/57] net/bnxt/tf_ulp: truflow add pf action handler
Date: Tue, 21 Oct 2025 14:56:54 -0400
Message-Id: <20251021185701.71881-19-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

