Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBACCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67E9840BA4;
	Wed, 29 Oct 2025 17:23:39 +0100 (CET)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id DDEA240657
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:23:36 +0100 (CET)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-87a092251eeso15838016d6.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755016; x=1762359816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=RRxTQ4RCEqRsUklyba1sR14KV0I4aUxlQg3IPu0lHPwFTlqbKRklQHTwsYIEajEhck
 JslpBA6172z4a6KcI0f12ePjKaKLcxak99TCO8EfmDXAIBCZEvSWMX04uATfXPJzzKR+
 vjyLmiXutCkeVQ78QB0Yl0K2rZACyvaRqAGJ4UQ/SPxLSqRiQOGAYRJiSKWiZq3N+25Z
 rzJwFBWfyJXPHJYA+B1yHHmEztpXSFiiUymdabxvHZVF4tkmXEbnCkppbb9ZDc/vC/fL
 1Xayh8H5G0/DCaBvBo6/g2OmEvOcdMYLXwV509GJR2GJIZbv1DDOFQ7/Zd2FoIVob+6L
 GWsw==
X-Gm-Message-State: AOJu0YwnGgSwlDq82PS+5cVieQtTmpyi2dekuZltTRnPIguROJpWo+GA
 Eou7Tr4eifd0lCmQiKgI/ofbtsWtkGXPuTpxQxl6iKtuSb/w+00M9iDoQyVN3x1k/LO6Ibv++f7
 FxWoYC6fiz5oHI1yAfcPZtdGI0MElHpMo41UaUDQNUI6qq9FJ4ln6q86yztPtlb0C+X9Oibr3g/
 r8hCLSItgzXtlR0gVpuUpG8y3F0zg4vfpmMTIQxGL8Ntnw4YYffsGTt/rpA890RiVmC8IQOQ==
X-Gm-Gg: ASbGncsGGWo/mYk4uRp8tvrNz2abfVicUZy/fMVgm/ZBpsdp9lQsGKWNKcys2iVrOvK
 covcTHtgUoaF2VZpf3i/6Cu4oqoINljQiyPq/53xkR2aTVrj9CmE8ID/m7OvTQD8oX0y8AomMxB
 wOP60g9TnACyz0BLwk5NlPtl5GojFCiGQCM4z4Qcs6gWDLjABuoVEMdvFgWLVAriLWd4V5oi+LB
 zBHjMNxuqnV40YB3foUG55ibpqtMtnwRF3qi/XymCOgBCJyPI8zNx0qAWmiFxo8WBSgtb+AsqrN
 rmjI1WQd4FsuN4MKS0k6ydkCAPZMKWxkziYMqK+usbpd49UcG8UJ5UjGHplXZ00YVpwQ0RapAK6
 e8kfN1MiwHLI2BrJkFyQSS4cZEshAzY3JlD5J3dq/t6vLyK6PG9Qpzks+Y8Opmt9zd3U+/vXXbo
 TXiu9mPEg12aiE10nOUxDQIcVUwd+SN6Y=
X-Google-Smtp-Source: AGHT+IHqtB2Abt613l3XygwsZ00WeyelOYEcN0e//23eOw0NqYZ/ZzaaMzuyiPKXn6j5qznX3x1G/15ifmsu
X-Received: by 2002:ad4:5ca4:0:b0:87f:fbe5:904f with SMTP id
 6a1803df08f44-8801ac997a3mr2874656d6.29.1761755016157; 
 Wed, 29 Oct 2025 09:23:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87fc49817bfsm13374006d6.23.2025.10.29.09.23.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:23:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a1ba620dc9so341436885a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761755015; x=1762359815; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=iMSimltO7nvL9Hs4z08bVmCQTeeO36Jp/t/hl5CvWov+SpNpBLZQfZLw0QYbq7uIal
 JzG2iZRI6NnfavQA5/vB2m59yUryXpNet2XxYIXV5cqXkdoIpjwDlVlbOcu0Xtmmq6FR
 y+a6KOWh57IO4NgNCvX+UgOI64uZO8zkF/9m0=
X-Received: by 2002:a05:620a:28d0:b0:8a0:4d8:81fb with SMTP id
 af79cd13be357-8aa2c46c49cmr22982785a.45.1761755015074; 
 Wed, 29 Oct 2025 09:23:35 -0700 (PDT)
X-Received: by 2002:a05:620a:28d0:b0:8a0:4d8:81fb with SMTP id
 af79cd13be357-8aa2c46c49cmr22978785a.45.1761755014550; 
 Wed, 29 Oct 2025 09:23:34 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.23.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:23:34 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 50/57] net/bnxt/tf_ulp: truflow add pf action handler
Date: Wed, 29 Oct 2025 12:07:05 -0400
Message-Id: <20251029160712.58519-51-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

