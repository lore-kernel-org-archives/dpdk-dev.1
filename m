Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97418C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:04:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC6D040EE1;
	Mon, 21 Sep 2026 05:04:17 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 680E340E1D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 05:04:16 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-39de8addbe4so1275179a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959855; x=1790564655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L0BDsneijDOEWHlGl5C4MYb/5j+nAQ0h/Bo4HgQsmH0=;
 b=WhEMrF9z/qEtrrmte7+++WHBa6LX788SQLGm3oohcOjC/CoNM6nwIZ5eIEdgbPrEH6
 eZTm+ysPi1lJmdeFrwav/N6uDptkCnGlqbp7RllGew8yM0T4bxz4hSME8euSxpfJ+U2t
 oB2ykd/sjdIZTO6RODUiDMVXkwkxnyS4QBTw2gNunGpw1bXKbry50Ayujx8/yZljTQq8
 4AQNPhpvC9edNT3pE1VBT5+l+5OMi9ZWnnNcYMBCQ/CW1QcwzCLxaUdaZW32SMceWtYA
 GNJptPKcmrv03M6JZ8lHPRoMEAFlDHIBWwwl2w7L5VVI8naMluIn4M0fmOEnO5D5OCnB
 KD+w==
X-Gm-Message-State: AFuF++kTNqE/7nLdrD7oWD22gxUeDsb974HpIR4kzeaef9Ml07192Np7
 Be6L9faFERoSrfRfAGGQSa69uRqiPnmLl5PO4NpwfLKOlrKa15Pu0fATHbNewdxeltlv5KkpByM
 TrD3OFPAAWiQh4vKMA203CVf0O8UKgocHX3Wo/qKBRgQk/+IkYrD4p157afwuM8C970TXW+FrWS
 +T05JDKl3LEY+CU523FllxT/wg3WawaIGhVs7TFMZK+JsnjdPf+VaFdhN/zzZf6lCtEmfyso0rm
 hDIxULBeAUj
X-Gm-Gg: AYBFou04C74khLJX2WIsQJRtzXxj5YKEDIWi3pth3H0NScKyT8oMyaPVgtEl6+S8BPx
 J+8qIRxp6HBc8qYlsk9Zhv9jBnbdqp58Rk+eJy9pVTj2gwYW+0R5iCwDXlg+612KuMNgq5K2yAD
 G9Iy5RAEmMyisxyWVYyTj++RbGj9dtOsmCI23Y0YxzB4SeWLIb29V83bohQQwalfeBIaJd7AjW1
 4RVOeXlROUxmdZEcf0g1xB4amoEE51Q4OWG0N9DhkCHaD7C+Ly8KijHrSZVLW8jPms0H7SGQp3F
 /s5JRzFIpONJodjDInHjs3UTWwCxA6SIcoRUJKQ5jJdf3oRMMEJEHuhZ3uCVjq6My7NUUGoYewn
 /VHpePglm0sZGXjnuV1BZ8wW8lePCo4m8d8wMW/ptqmwOaOr7E1Ra+zBTOkRagZpY79hK8t/mJ7
 sCmMtXwtLBEDZzuS6sQ+jM4RbRBp2HjW/I4pL2tg00qqfm/gl6mQ==
X-Received: by 2002:a17:90b:5287:b0:39e:3285:b776 with SMTP id
 98e67ed59e1d1-39e54cb9c71mr14689805a91.7.1789959855302; 
 Sun, 20 Sep 2026 20:04:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39e6ca114b9sm4555581a91.3.2026.09.20.20.04.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 20:04:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39e087a17dfso4702801a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959854; x=1790564654; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L0BDsneijDOEWHlGl5C4MYb/5j+nAQ0h/Bo4HgQsmH0=;
 b=DI8hmxCs4IjHXLRgkFUKjjuX1rVOTYIRvG1/xCq0f7zstabsiuECPSKu9AHx/owQ6w
 4o9ECzfjdA2coc47fbgF/B3VkFNr7JIe43iF1OzRrnmeIdhhmQvMnaC/hsLJ9WKGgpu4
 hsE3SicD8RsHcF6cSrcNaalr0NR/yjiPlKOFQ=
X-Received: by 2002:a17:90a:4cc7:b0:3a0:22bd:6ef0 with SMTP id
 98e67ed59e1d1-3a022bd85efmr4976415a91.30.1789959853767; 
 Sun, 20 Sep 2026 20:04:13 -0700 (PDT)
X-Received: by 2002:a17:90a:4cc7:b0:3a0:22bd:6ef0 with SMTP id
 98e67ed59e1d1-3a022bd85efmr4976388a91.30.1789959853138; 
 Sun, 20 Sep 2026 20:04:13 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a111sm13305831eec.6.2026.09.20.20.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 20:04:12 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: validate ptype table indexing at build time
Date: Sun, 20 Sep 2026 21:07:17 -0600
Message-ID: <20260921030717.1034849-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

The Thor2/P7 (V3 completion) receive path left a TODO instead of
calling a build-time validation of the ptype lookup table indexing,
unlike the equivalent V2 completion path which already validates its
own index layout via bnxt_check_ptype_constants(). Without it, any
future drift between the V3 completion field shift/mask definitions
and the ptype table's index layout would silently produce an
out-of-bounds ptype table index at runtime instead of being caught
at compile time.

Add bnxt_check_ptype_constants_v3(), mirroring the existing V2
helper, and call it from bnxt_parse_pkt_type_v3() via
RTE_BUILD_BUG_ON.

Fixes: 65d2b0557ba3 ("net/bnxt: support Rx completion v3")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c |  3 +--
 drivers/net/bnxt/bnxt_rxr.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 0fab4ddf78..18790d6821 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -575,9 +575,8 @@ bnxt_parse_pkt_type_v3(struct rte_mbuf *mbuf,
 	flags2 = rte_le_to_cpu_32(rxcmp1->flags2);
 	meta = rte_le_to_cpu_32(rxcmp->metadata1_payload_offset);
 
-	/* TODO */
 	/* Validate ptype table indexing at build time. */
-	/* bnxt_check_ptype_constants_v3(); */
+	bnxt_check_ptype_constants_v3();
 
 	/*
 	 * Index format:
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index c971233dc3..0e8840e2cd 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -475,6 +475,17 @@ bnxt_parse_pkt_type_v2(struct rte_mbuf *mbuf,
 	(((f2) & RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE) >> \
 	 (RX_PKT_V3_CMPL_FLAGS2_IP_TYPE_SFT - BNXT_PTYPE_TBL_IP_VER_SFT))
 
+static inline void
+bnxt_check_ptype_constants_v3(void)
+{
+	RTE_BUILD_BUG_ON(BNXT_CMPL_V3_ITYPE_TO_IDX(RX_PKT_V3_CMPL_FLAGS_ITYPE_MASK) !=
+			 BNXT_PTYPE_TBL_TYPE_MSK);
+	RTE_BUILD_BUG_ON(BNXT_CMPL_V3_VLAN_TO_IDX(RX_PKT_V3_CMPL_METADATA1_VALID) !=
+			 BNXT_PTYPE_TBL_VLAN_MSK);
+	RTE_BUILD_BUG_ON(BNXT_CMPL_V3_IP_VER_TO_IDX(RX_PKT_V3_CMPL_HI_FLAGS2_IP_TYPE) !=
+			 BNXT_PTYPE_TBL_IP_VER_MSK);
+}
+
 #define RX_CMP_V3_VLAN_VALID(rxcmp)        \
 	(((struct rx_pkt_v3_cmpl *)rxcmp)->metadata1_payload_offset &	\
 	 RX_PKT_V3_CMPL_METADATA1_VALID)
-- 
2.47.3

