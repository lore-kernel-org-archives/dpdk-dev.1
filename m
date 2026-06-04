Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB47CD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CBFE40B8C;
	Thu,  4 Jun 2026 05:17:23 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 53FA640A7F
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:22 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2c0c2a68d01so1504495ad.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543041; x=1781147841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMPaLfyNzkYTzaBwwN9HhPVAIv/zChn4oF3QCxlXw3k=;
 b=pqVj7usIGMM7abH4N1nwLerR3TyK4sW2Q5bpbrinn//INUpJHYfPRUBkUZMds3PufC
 YZkpGrC04BkNaqwBtzt+PX1mk25Sn2UY0j+qLUJ9KkhPFQRykbxmpht2pGWdDDIip0uN
 KYSlsTxYdGynp3LbWWXriSseAKLYnmAnfPHjKMp3aP2T6QC41ggzvEQwlmul78ttoXHO
 zRErT/O2Jj85JIHa2K6F+LvpHFLNlT/XyPIo+p6w0X1IUXKCfwoM+WD9lBdw/jMSn3B8
 e4O7sccmKnT5UZfxKMGD5UAhTN5UZNQ3DK9CFSfX/f2jFpk81xtLS5m2mKEUSzGbQ3hB
 RRYA==
X-Gm-Message-State: AOJu0YzkiORl7JZKDWgveDr113acKxII6bokt4s4ncrIM2XPK1ZgwkZ7
 deRbj1Xe0Ijvo4xfRrgAGKVUj4Sen1dHY2MBHHGHKT82S7zHJPWd2sYcig+IZ1b6bXyi/Yyxtj4
 8lkTQUa37VexklOy/N6KXtJwUEXTPj2QQxFD8KuQGoeMF/uyT7X/ivdfpOFhuG8NidpM3MSvkGg
 VQdGSd38l7yrrRa6TkFWRKdjLc9hCYAaFtlHQhqtGwcOvsAOXm+Ywa6Xf6DPe6qwY7q3YXvdns+
 zqP2RXTiLP4
X-Gm-Gg: Acq92OF/CZWQxkxsUNdk5Hnc8VJf/d6GISLAD3Q2i9/VAyTKhF5JbaAAI9461bSuBz9
 hHiIenh60fdfaXHjWoyDgNIlHuNT+DA9q8XhzKAUiuqdotxT/qL19JrmV00rdfPMYUbETIgVmdt
 WziqmlHYKdeYJ/O07F0nlDRl1Ti+IsB66QOLF2rm5zIi+FZRFhpe8hdN9hg6NIMtwJzK57SvjLu
 hh0vQEEGI7mitzVg8G73G2rSboaASU8ukLAT1HD/V8s/Cp7vRKQUNK5YxKTEiKTnFyVnJgfmPE/
 pJD1qMDBYUcM7BDbGUPz84OoMN5Y2cUQtp4RM4gbFA0VJaxkkez26DCGiDIl5VsBP/NFO8Zbl/D
 g4Bw5fSI14JgIhSOfiL75B+Y0D2tR2O21u7dXsUACskkI3G2JXC2NETNhC0e+/Bf2VcOnaF3M+t
 J+pQuK9/WlKTktJzYZhMh/f4NO755Nlp0/RnI252fs3ps3PlBI+w71WeKClqsWe9Lo9L6ZiAjMJ
 65sm/TvsS9C
X-Received: by 2002:a17:903:2410:b0:2c0:b6c7:2273 with SMTP id
 d9443c01a7336-2c163a257e8mr65457105ad.3.1780543041397; 
 Wed, 03 Jun 2026 20:17:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c164f71aedsm4264355ad.3.2026.06.03.20.17.21
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-914f037b7dfso54108985a.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543040; x=1781147840; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMPaLfyNzkYTzaBwwN9HhPVAIv/zChn4oF3QCxlXw3k=;
 b=NYqsL7iTULVwZcjrOtQ2fgHT5gVkqU0s4A7BoUI/xDnvCTqUcK2tCW9eow0Q4HiOzY
 QAg9syweTitJ09ncs+F732TOwTiAmJTdYBSa+wwjHaJAdCG9NmEwg6IGXszX7s4n0R0o
 sWnCaBY1gic0AQ0UcrYWeNnJ8XJIStzGyN1qY=
X-Received: by 2002:a05:620a:7081:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-9158a6a84bdmr1043522485a.16.1780543040308; 
 Wed, 03 Jun 2026 20:17:20 -0700 (PDT)
X-Received: by 2002:a05:620a:7081:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-9158a6a84bdmr1043520185a.16.1780543039832; 
 Wed, 03 Jun 2026 20:17:19 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:18 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 10/10] net/bnxt: fix v3 vector mode not selecting cksum
 unknown unknown
Date: Wed,  3 Jun 2026 21:18:51 -0600
Message-ID: <20260604031851.2267548-11-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

The v3 vector mode would default to all cksums being good rather
than cksum unknown in the case that flags2 cscalc section was 0.
Added an entry in the lookup table for this case and corrected
the logic.

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 14 ++++++++------
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 38aca98cb1..b5fb9d35c4 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -1111,14 +1111,16 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		 * RX_PKT_CMPL_ERRORS_T_IP_CS_ERROR | RX_PKT_CMPL_ERRORS_L4_CS_ERROR |
 		 * RX_PKT_CMPL_ERRORS_IP_CS_ERROR
 		 */
-		errors_csum_idx = _mm256_srli_epi32(_mm256_and_si256(errors_v2,
-						    _mm256_slli_epi32(mask_fs, 4)), 4);
+		errors_csum_idx = _mm256_and_si256(_mm256_srli_epi32(errors_v2, 4),
+						   mask_fs);
 		meta_format = _mm256_cmpeq_epi32(_mm256_and_si256(cs_calc,
-							_mm256_slli_epi32(mask_fs, 4)),
-							_mm256_setzero_si256());
+						 _mm256_slli_epi32(mask_fs, 4)),
+						 _mm256_setzero_si256());
 		cs_valid = _mm256_cmpeq_epi32(_mm256_and_si256(cs_calc, mask_fs),
-							_mm256_setzero_si256());
-		errors_csum_idx = _mm256_andnot_si256(cs_valid, errors_csum_idx);
+					      _mm256_setzero_si256());
+		errors_csum_idx = _mm256_add_epi32(_mm256_andnot_si256(cs_valid, mask_1s),
+						   _mm256_andnot_si256(cs_valid,
+								       errors_csum_idx));
 
 		/*
 		 * Load ol_flags for eight packets using gather. Gather
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index d8659d1001..c75a8bd09f 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -178,7 +178,8 @@ bnxt_tx_cmp_vec(struct bnxt_tx_queue *txq, uint32_t nr_pkts)
 	txr->tx_raw_cons = raw_cons;
 }
 
-static const uint32_t errors_to_olflags_v3[16] = {
+static const uint32_t errors_to_olflags_v3[17] = {
+	RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN,
 	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
 	RTE_MBUF_F_RX_IP_CKSUM_GOOD,
 	RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
-- 
2.47.3

