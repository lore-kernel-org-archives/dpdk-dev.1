Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE17C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 21:41:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14CE0402E3;
	Tue, 11 Mar 2025 22:41:32 +0100 (CET)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44]) by mails.dpdk.org (Postfix) with ESMTP id 59F404025A
 for <dev@dpdk.org>; Tue, 11 Mar 2025 22:41:30 +0100 (CET)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-5fe86c16f5dso2715030eaf.1
 for <dev@dpdk.org>; Tue, 11 Mar 2025 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netgate.com; s=google; t=1741729289; x=1742334089; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oP9CZkNmWmlUuiiyhECRaE+k99OyZRvQPM7xPwBPwtY=;
 b=IIM9ZrpulboQYUCMkqFVniF7gLIBEWuBcfZ8SAUx8weiHjP970EOfvz/06uE/mFrqe
 2TR4LFuNjqdftv587tCL1SF4BkVwz0t7CLOUKzS1N34NStoGtKdtI/vSgs5x4Ff4B/EI
 L6RbjgqSWXZJvtxmUsGmiK/0a355l37uvY2t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741729289; x=1742334089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oP9CZkNmWmlUuiiyhECRaE+k99OyZRvQPM7xPwBPwtY=;
 b=wlPBnLwsM/AskD/QIdksikf11i5DxJziPVfztBpRiy7bP2JOptLLXlZ1z7M/QJjEyN
 pm12tvBCOBwp7KxW8fSe8XSuZ4T4zigfRVAcfWMeni1cDadq2235rRnCL/vGMcDLLw66
 eTL09gIXp2cF3/CUHurBWmVWMmrFn3mioSegCss6KT36/aGTzGOQCXO22+/RFrDm2UNS
 7oysgeSqLS6aFSnMeRPUsteglIiybQX9LalcO2rJs2kfELjLCXHP9KNb7f5XBaa2FxRI
 oaKX2IgKtojmWgKx6IEGVzLQ4aZ9x8psEDLRuryDJFvnPMaFIEzOM7vf+UlULaRgH19m
 UtfQ==
X-Gm-Message-State: AOJu0YyEsm+jwzJzpNWCejX4z/RgyI9tEEjATvZxnm27qxWpN6QmMaRA
 x7K3KWh6eIXqPukmdOXTXyrA65sx5DaXYvoL72E3VIG0GTkKxCcZg9SVHvBvIV21urv+BEzZHVU
 =
X-Gm-Gg: ASbGncumKIsjxvNlMQes2hYsuWwhba8IiplPodOrD2Bqcb9cRB63Bul2s1pCOKQsinK
 R/NQOVhCdDwn0n38HO3QMGjCb5MYIafWXAO4kZRgub/BQa3V1onqDJD1TDgSgH0ACm9x3O2egxP
 tre8B6zf5Q/8bfQbtoag6uAnP6+xEDQRgGbeWy/sJos9ynI8/Rnhoal4GT9xm/sd9S9IkcJzCkD
 GkhJxVjdgkk0dVdF2l2oV1re5gWGCxQ5jTXkquBHrCSwnzmrTA/fWubQuVZIqCLunpGz4gQnCE/
 y/Gnm7PD1L+j3iJXSga43+wPc90T6Fme3wTD+MI5Ui3vIKDDKFCqpwY2YMdvFg==
X-Google-Smtp-Source: AGHT+IHftttfNdN+rsEPHukUdo0V5cwU/WyA8DqCAfB+j1K6IdFjQdOwe3P9/kH+yI1DJc4AZYwxkQ==
X-Received: by 2002:a05:6820:98c:b0:5fd:50d:49e4 with SMTP id
 006d021491bc7-601c24688c7mr2752928eaf.7.1741729289110; 
 Tue, 11 Mar 2025 14:41:29 -0700 (PDT)
Received: from xg1541-1-zcolo.netgate.com ([2610:160:11:3f:ec4:7aff:fec7:62f6])
 by smtp.googlemail.com with ESMTPSA id
 006d021491bc7-6017680b599sm1409469eaf.2.2025.03.11.14.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 14:41:28 -0700 (PDT)
From: Matthew Smith <mgsmith@netgate.com>
To: dev@dpdk.org
Cc: Matthew Smith <mgsmith@netgate.com>
Subject: [PATCH] net/ice: set flags while adding vsi
Date: Tue, 11 Mar 2025 21:40:31 +0000
Message-Id: <20250311214031.2217808-1-mgsmith@netgate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While adding a vsi for an ice PF, set the ICE_AQ_VSI_SW_FLAG_LOCAL_LB
flag. This will prevent packets from being dropped when using a virtual
MAC address with VRRP.

Also set the ICE_AQ_VSI_SW_FLAG_SRC_PRUNE flag to prevent transmitted
packets from being looped back in some circumstances.

Fixes: f9cf4f864150 ("net/ice: support device initialization")

Signed-off-by: Matthew Smith <mgsmith@netgate.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 3cdfa16f77..21d3795954 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1696,6 +1696,10 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		 * by ice_init_hw
 		 */
 		vsi_ctx.info.sw_id = hw->port_info->sw_id;
+		vsi_ctx.info.sw_flags = ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
+		vsi_ctx.info.sw_flags |= ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
+		cfg = ICE_AQ_VSI_PROP_SW_VALID;
+		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
 		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
 		/* Allow all untagged or tagged packets */
 		vsi_ctx.info.inner_vlan_flags = ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL;
-- 
2.34.1

