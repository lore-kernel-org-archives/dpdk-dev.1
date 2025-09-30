Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EABCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D5D2410E6;
	Tue, 30 Sep 2025 09:06:25 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 9A30F402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:43 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-27ee41e0798so65595415ad.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192663; x=1759797463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=EZoi9grEXkpbX8c2JFWe7Vx2uEjjssXyRks9YsxlukBEFHAOOkII2w+ZES0wGNDlDV
 4Mj9zEjm+kJQ8xNkUlF1yp8pF5/6qpjz3gcxoYcmNPHbelIF+WLWmIq8GMA92FwtQtgT
 qTBTsrL1YTMlit7zh8DiJS6HO/JQiQYg8MB6kXjXODKjhMsgPrN+DAZSGU3Na/Ou+JO2
 evfT2XVp1mv6NrGlUZzkBrpCgjGHd0lacVnJ0pENk2pvev9vW3OoBLiyHyGQPMgSvbYF
 KsYlGTvbZezvF/d4SmHKfa8IbSh4RlOECBeclN8yTxCedv2uenKk+dA21GnVkDLaB99Z
 vPhA==
X-Gm-Message-State: AOJu0Yw2GpCtXglA8EK1IFVQjHKTw0y8bPCPpsI2DCAUW0p6L812NmY0
 nIv62z5zGL56mOG6kzCcfyoPxZBRmvJytwG703OoTDY9gl4rwdF5YolA/49m5sjUIEe83OTpufo
 rwSXSo/E+rd812sU0OCONZ7At1iFJwXwmylSIx8n5cxO0hoXXIfA48fjVKj9BoMMDLEWeamnbpq
 8V32kfNIg6G7P4ohS3Wh+aesltiBSDSKL2MNZrScYdNAHkeRBes9HUF2dXiO8uB2U55zOKwQ==
X-Gm-Gg: ASbGncu7voewIVPuVwBr2uy6PHtDm1pQF/+TWRxLFdk7IFvA7TZGsxXUxE5KcPv2cGT
 4rDBIRRKEOTSQZI86Zm20cYbSKrw+fs73sQeAKiMhVGL/TQp3wsexPYidwPOi7iVhOBGM/1WN1x
 ErqYOZGrxir17aDNVN5EhNAQ0kDuofDHycBx+KuDWwE/pwroPsbHLIy4cFcl4wkIpNtNlsOi43d
 rFcuNd9yTHsx2vioXvL1m8/pGokmkN/ie8yuwl9y7jwg3C1mI/ZGK6TxQb0pfltqI0n4pOMgfUM
 yFCGZq169Hhm2bl37/XdJ7kmE+IqXVs82z8ogrvZ/E5sh8XotuuoVXorQZ7cplFv3XdXckDWSjg
 5Sm9r6+ppiDmz/6dO/n/G4b3uWLJWxeBHc0s4lINnCKYrPdF9rJpu8fN8jOOgnpsdoIdtjlW5hx
 tDsZbKXOU=
X-Google-Smtp-Source: AGHT+IGQHrmCSYtBJWv3slIs1l1p/4CsYMKVvDESwiBWCwMQSfsXUeBmeETS06BO3pEAwkr/9KePB9cDijQA
X-Received: by 2002:a17:903:2407:b0:24c:ca55:6d90 with SMTP id
 d9443c01a7336-27ed4a7448emr212352455ad.61.1759192662751; 
 Mon, 29 Sep 2025 17:37:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed66dd04bsm11555795ad.21.2025.09.29.17.37.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7821487d16bso4778929b3a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192660; x=1759797460; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=J2iE3uVQ3pfyE3wTGbkEgpAUjuNzW7Ft/747j57Uj6huOp7nJ7l12WxuHOwOJHktnD
 +c87z5fPkcjFJ5JltPUnvFmR0/DZG6uqWRewqJ6uCzOkMdnsXyB37XOVNAxVcfWR6tOi
 Vv7zKujgC9z/whyGw1ajsLVoE0lft2jpfmqqU=
X-Received: by 2002:a05:6a21:6d9d:b0:2b6:3182:be1f with SMTP id
 adf61e73a8af0-2e7d3db5fb7mr23626480637.42.1759192660543; 
 Mon, 29 Sep 2025 17:37:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d9d:b0:2b6:3182:be1f with SMTP id
 adf61e73a8af0-2e7d3db5fb7mr23626453637.42.1759192660053; 
 Mon, 29 Sep 2025 17:37:40 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:39 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 47/54] net/bnxt/tf_ulp: truflow add pf action handler
Date: Mon, 29 Sep 2025 20:35:57 -0400
Message-Id: <20250930003604.87108-48-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

