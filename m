Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B3CD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 686E84066E;
	Thu,  4 Jun 2026 05:17:10 +0200 (CEST)
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com
 [209.85.160.98]) by mails.dpdk.org (Postfix) with ESMTP id 7C52440652
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:09 +0200 (CEST)
Received: by mail-oa1-f98.google.com with SMTP id
 586e51a60fabf-43bf9548df4so220992fac.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543029; x=1781147829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kygTjEMlMlkF8uWLEHO0o7/sBugNQK2RJbXmaS9BEp8=;
 b=gO3QJbTmhcFrtMu2AU6rMdwwy/Ra19+siBAG0fNbOkE86jJRIvxiM5bvYsv/awScka
 ivog3dGGLAW5kyIBSnRlYl+/jEETkXv7LWLbDQdBuEb0x8/iNpFyFtHJPjLqPQOfgJen
 feXS0SU6sN54cIajvD+7siw21esPK3Df9H7Xf32l7JTcKlRYuSNNGdle5AYtu+ofeH7K
 QA447lPYGSidnqGzvJ3TJEZW+6LnmeJKl6eoliEFz9MomZ+gJXv4pQyadvlMPOCZCQ1+
 vANruYCL/neLZ2fN0Tg7bRAPAgZ07fZkZNxzGkDGG/XrB7M8rPeFxMRH6omwxv0ieh8B
 +a2g==
X-Gm-Message-State: AOJu0Yzeb0qzkYUotmYWJiSntCLe4xk1VVQPa3kRT8pkgH75ZvPOKOJj
 CTXU/eVNL6EGhRb+2XAXbsXZ73yEssZm1QPnYin+GDrAL3Uz7gXmM5mlC14oNk3NUTn9LyApoFu
 OmPmGQ4EDCB4KBcQxa8LEXCno0BMJVidpmBXyYztf1lNbwEHX4hoMTvsx05Q8+6OEoLTf+5R8ei
 zrq5T4EA9kyVFcTMNGdr/Z//Qo0A+qKnwaEWr7I9jqaTGZk68alpsKg2Klg0NjatvwaJPRI8ajm
 7g3IsXJ6Sg6
X-Gm-Gg: Acq92OHwShog37xn2PL4zKxSOVirXUIN5CTnPr93dtO34v32FbFdCZ3lYBFTIn4X3rf
 lW4FTRTY+t2zoTR0mh98ZYpPaSpOXcvgkAHZOshMFv1NHJzM5A/fMYKv0ZFOy+w3Qgy06vsl8Sl
 SDw4NNDx9ztK8C+xMksTEyj8tXAVhatJVrQTkrty8U1/mRn+TwgxFlEVj6OxtOzb/72cuQsYRBc
 yl/bz0rcKLrgQDr/5IvjYrGsF7OKnWLG5/YTClphtjDT7vGB6+CPKCqFZCoC6sE9Dnv3eKVSbPU
 9Tjn/47ERe4HEmPqP//k9diBgIeqtJbDBzrykc7mCoQANX/ZFULGaNf/ePA6ltWk0FbMcSRCdW0
 Y3u8eBUxH2meK2D759gl6QHZW+E4OZRV0bB8U0iIMhR5cP/7CGHQWwa8nULfPtCUzJExA6+FyGB
 jkQTt1ZnpeW4gFy/sL7egqJgRxsxbG1k5try4woCR8wzmuFOybiYEV3zVpstrbtFUivO3nzX0Rq
 xcRFUS6X/sq
X-Received: by 2002:a05:6871:5e95:b0:43d:591:81e7 with SMTP id
 586e51a60fabf-440dbb24953mr3884629fac.34.1780543028541; 
 Wed, 03 Jun 2026 20:17:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-440d7da8e82sm436781fac.4.2026.06.03.20.17.08
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91598ab3a1aso37000285a.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543027; x=1781147827; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kygTjEMlMlkF8uWLEHO0o7/sBugNQK2RJbXmaS9BEp8=;
 b=XvmoSC+UWN/VObB6ZwZz6BxsVo054iHfaUpiqOiKjA/CiiBdW65O4Xa1j0kdUt9N2M
 dpiuFZSvurYSa9XkGao93O1oPGFSbjJKSfAIO5fonFeb/Otr5oLgDcD1IF6wNwuvH7EA
 JzKQnTIl8sgy6uPCJZxfdF40syM5hR6VfIpgY=
X-Received: by 2002:a05:620a:2786:b0:913:7bc8:79b4 with SMTP id
 af79cd13be357-9158a81148bmr1048266585a.51.1780543027537; 
 Wed, 03 Jun 2026 20:17:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2786:b0:913:7bc8:79b4 with SMTP id
 af79cd13be357-9158a81148bmr1048262885a.51.1780543026971; 
 Wed, 03 Jun 2026 20:17:06 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:06 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 03/10] net/bnxt: fix advertising RX LRO offload capability
Date: Wed,  3 Jun 2026 21:18:44 -0600
Message-ID: <20260604031851.2267548-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>

Do not set the RX LRO offload capability bit mask if the
hardware did not advertise the function, and let
the driver take non-tpa path in configuring the vnic
in such cases.

Fixes: b150a7e7ee66 ("net/bnxt: support LRO on Thor adapters")
Cc: stable@dpdk.org
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h      |  1 +
 drivers/net/bnxt/bnxt_hwrm.c | 29 +++++++++++++++++++++++++++--
 drivers/net/bnxt/bnxt_rxq.c  |  3 ++-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index f21753e40c..5ae4e620a4 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -1273,6 +1273,7 @@ extern int bnxt_logtype_driver;
 #define BNXT_LINK_SPEEDS_V2(bp) (((bp)->link_info) && (((bp)->link_info->support_speeds_v2) || \
 						       BNXT_LINK_SPEEDS_V2_VF((bp))))
 #define BNXT_MAX_SPEED_LANES 8
+#define BNXT_SUPPORTS_TPA(bp)  (!BNXT_CHIP_P5_P7(bp) || (bp)->max_tpa_v2)
 extern const struct rte_flow_ops bnxt_ulp_rte_flow_ops;
 int32_t bnxt_ulp_port_init(struct bnxt *bp);
 void bnxt_ulp_port_deinit(struct bnxt *bp);
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 02a5d00738..590543ad6a 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -3120,10 +3120,10 @@ int bnxt_hwrm_vnic_tpa_cfg(struct bnxt *bp,
 		return -ENOTSUP;
 	}
 
-	if ((BNXT_CHIP_P5(bp) || BNXT_CHIP_P7(bp)) && !bp->max_tpa_v2) {
+	if (!BNXT_SUPPORTS_TPA(bp)) {
 		if (enable)
 			PMD_DRV_LOG_LINE(ERR, "No HW support for LRO");
-		return -ENOTSUP;
+		return 0;
 	}
 
 	if (vnic->fw_vnic_id == INVALID_HW_RING_ID) {
@@ -4946,6 +4946,31 @@ int bnxt_hwrm_pf_evb_mode(struct bnxt *bp)
 	return rc;
 }
 
+static int bnxt_hwrm_set_tpa(struct bnxt *bp)
+{
+	struct rte_eth_conf *dev_conf = &bp->eth_dev->data->dev_conf;
+	uint64_t rx_offloads = dev_conf->rxmode.offloads;
+	bool tpa_flags = 0;
+	int rc, i;
+
+	if (!BNXT_SUPPORTS_TPA(bp))
+		return 0;
+
+	tpa_flags = (rx_offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) ?  true : false;
+	for (i = 0; i < bp->max_vnics; i++) {
+		struct bnxt_vnic_info *vnic = &bp->vnic_info[i];
+
+		if (vnic->fw_vnic_id == INVALID_HW_RING_ID)
+			continue;
+
+		rc = bnxt_hwrm_vnic_tpa_cfg(bp, vnic, tpa_flags);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+
 int bnxt_hwrm_tunnel_dst_port_alloc(struct bnxt *bp, uint16_t port,
 				uint8_t tunnel_type)
 {
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index b93f5043de..023cb0e174 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -38,7 +38,8 @@ uint64_t bnxt_get_rx_port_offloads(struct bnxt *bp)
 				    RTE_ETH_RX_OFFLOAD_VLAN_EXTEND);
 
 
-	if (!bnxt_compressed_rx_cqe_mode_enabled(bp))
+	if (!bnxt_compressed_rx_cqe_mode_enabled(bp) &&
+	    BNXT_SUPPORTS_TPA(bp))
 		rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TCP_LRO;
 	if (bp->flags & BNXT_FLAG_PTP_SUPPORTED)
 		rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
-- 
2.47.3

