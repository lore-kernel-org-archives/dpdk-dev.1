Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC18BCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84D7D40E4C;
	Fri, 10 Oct 2025 00:16:41 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 3A37240E68
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:40 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3322e63602eso2080835a91.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048199; x=1760652999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=qzEbQDhUIO1RjGLVbJ6RFkpv2vaYvikx8Xa5lLBu3pwDsbCbZLLnHe6fkRUQEvNfe2
 QuLOF4hBjuBSwZ6TJJX7S38ra2hND5rqkyl9HgFFH08H+k+KsmFuwgFL19HEzlad08SU
 IkPBMFeOkN/rZO1VTyr/OGPKqCNx4dc5rAMQZkLlrHUz/fv7B4OXGmGAykxfq4ZJLE1S
 dF0KVRTiJ/VMPnsej5wh/Cm8mUc98QNVO6UIEn5W2XZOfJajbB+ylpRoB8TAVEbXeOcO
 PWL7Gl2GdaeqcbipiCDHAKepj8NT30gN5k78dK4jBAYmTd1baHi5vuV2QVmpAC0Kk7d8
 jv4Q==
X-Gm-Message-State: AOJu0YwtsnZbGyVMi0cjt3Ik+W89dzity65NGqSfIuvDDr3HxPYXlMFG
 OJD6WZw5sQpTW1UZOoL0Of+iijAlO1gZkey3kg/Oqfao1lqmyfpQ79X7E3NMsX0YrkyyVCqj8Lh
 kwwueFuleTX8DkYC5fs8PClsnaiKsCEk8bDH4//aXEv49xrCFCtdZAeaZK2zha+w1bzrjQCezMc
 rsVzkslx5i4WiPyxKmuRJgsiFuUIziGgN/LJ8srYxQMEzKs1+Zkrq5gxYvAUg2rhDz5ubV5g==
X-Gm-Gg: ASbGncvyoOZRwLAiwHpWu3bRUCgeoxSzB6sSNWzRv/RGHlqzfBo//4xqTIwuQvRvMem
 2Aue/vV/GRKjfORrv3xwOpzcwpbKf+0RuAKDGZjNcfHRRW5qKic/2Va2LXqRItWXy9NfHjwWmLB
 uTvcpC9qyyj0psCsOLktsIW5kCWdIkH0Gn9RTc8d7/o0++eoM1mcL2eUKJ6232BOigSPL1Z4qLU
 VgUICVXHtr4w2nXo/TfrjGF12q41hD1Y7ka07JifgudusWTvJs+Guyw+lL9TljEDVPueTf6uYx0
 W3LHZwVKFyHbJOwDYlggaIOXP+PvQVGqt2waTmeF83HiwOLjt4hkIgTRCgZ1xQlJ8CTjM0LJBKY
 Nj0o70f71T7SBgcYPETDQciUsuT3lK86P/iaVxBYM5aOEnD11/+pmndrFSv1HMDPk68gbk0glwo
 4QXwZDmGM=
X-Google-Smtp-Source: AGHT+IFjQYvgOg5W5Q7S1l8yhC6UaPzQqepWmIVm4G05eUtN7S2znaj934BIOz/EuhpyXGQd2cxx9bUer6L6
X-Received: by 2002:a17:903:2d1:b0:277:3488:787e with SMTP id
 d9443c01a7336-29027356933mr118234465ad.12.1760048199229; 
 Thu, 09 Oct 2025 15:16:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034f2dd65sm3211905ad.58.2025.10.09.15.16.38
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8645d39787bso694138085a.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048198; x=1760652998; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG2iYYV+RJvIBDHq3EIy50ByhQrPorNWKVqHo+mf7yw=;
 b=HDN6VyjTC0eyUbulmUeuyPCBmb5H/+Wo+wYN4/iZTug/OofIwkM0b+oYfMFwIDB6+2
 YwADc0FcnmQ2ohv6m8Xy082aemJ28bPmkCqBnHOf5m7/1hJFbqiIZoL9JGJFuWBSEU6c
 aaDkHxBhgPBivzsa6WjsE9JJ11IKrkadUc3lc=
X-Received: by 2002:a05:6214:246f:b0:787:5934:697 with SMTP id
 6a1803df08f44-87b2103c5dbmr124989256d6.8.1760048197203; 
 Thu, 09 Oct 2025 15:16:37 -0700 (PDT)
X-Received: by 2002:a05:6214:246f:b0:787:5934:697 with SMTP id
 6a1803df08f44-87b2103c5dbmr124988726d6.8.1760048196602; 
 Thu, 09 Oct 2025 15:16:36 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:36 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 47/54] net/bnxt/tf_ulp: truflow add pf action handler
Date: Thu,  9 Oct 2025 18:11:22 -0400
Message-Id: <20251009221129.28256-48-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

