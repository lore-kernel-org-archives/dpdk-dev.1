Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613C6C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08459410DD;
	Mon, 24 Feb 2025 10:55:09 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C46C640E39
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:54:53 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51DKc001315
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 rZCajK+3REZJXSQfu4qG1ke3K28b/3BnwrVbWYlXX8=; b=R4XInBtlvZUzeJnGt
 U9r5DUGWxZmC5lBVGuoxIgHe3cNnC+nB8zuyaKxnbEpLhg39W2qmIXpp9/YXPPuK
 ycYJoXziHcdEFB32jc0xQ8SU4zOGCla4+1OJ3mC1zGSY/OU96cu6CZaBf4kNxtj9
 R9IJKC0hFCb7W4YM2jriBMjqRLssDs0HJxkP0v7vQJfHvRzhQjZirYvP3P1CiDB1
 ODXoBLkH2f+am24+Pf3q29aTs6mZbSKGI7q+aDMv0QU6fQKXEtx7sShcy5P/7RUr
 RzyyLrr5YSFiVp8f4UC0tPhi1W42o+YXk1bEAStHbM5wNZ2Q1lTs4DuISaugXwB9
 6A+ig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jh3c-11
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:53:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:53:44 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 04CF83F7062;
 Mon, 24 Feb 2025 01:53:41 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 13/33] common/cnxk: add cn20k meta pkt structs
Date: Mon, 24 Feb 2025 15:22:21 +0530
Message-ID: <20250224095241.1263700-13-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1MOcaUHKzgsXLG7omWsv0PE3LEDjIMP4
X-Proofpoint-ORIG-GUID: 1MOcaUHKzgsXLG7omWsv0PE3LEDjIMP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

Adds below structures for cn20k,
- cpt_parse_hdr_s
- cpt_rxc_sg_s
- cpt_rxc_ptr_info_s

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/hw/cpt.h        | 211 +++++++++++++++++++++-------
 drivers/common/cnxk/roc_cpt.h       |   2 +-
 drivers/common/cnxk/roc_cpt_debug.c | 143 +++++++++++++++++--
 drivers/net/cnxk/cn10k_ethdev.c     |   5 +-
 drivers/net/cnxk/cn10k_rx.h         |  21 +--
 drivers/net/cnxk/cn20k_ethdev.c     |   4 +-
 6 files changed, 304 insertions(+), 82 deletions(-)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index b308a18f0d..f2c222a920 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -322,60 +322,124 @@ union cpt_res_s {
 };
 
 /* [CN10K, .) */
-struct cpt_parse_hdr_s {
-	/* WORD 0 */
-	union {
-		uint64_t u64;
-		struct {
-			uint8_t pad_len : 3;
-			uint8_t num_frags : 3;
-			uint8_t pkt_out : 2;
-
-			uint8_t err_sum : 1;
-			uint8_t reas_sts : 4;
-			uint8_t reserved_53 : 1;
-			uint8_t et_owr : 1;
-			uint8_t pkt_fmt : 1;
-
-			uint16_t match_id : 16;
-
-			uint32_t cookie : 32;
-		};
-	} w0;
-
-	/* WORD 1 */
-	uint64_t wqe_ptr;
-
-	/* WORD 2 */
-	union {
-		uint64_t u64;
-		struct {
-			uint8_t fi_pad : 3;
-			uint8_t fi_offset : 5;
-			uint8_t il3_off;
-			uint16_t orig_pf_func;
-			uint16_t reserved_145_160;
-			uint16_t frag_age;
-		};
-	} w2;
-
-	/* WORD 3 */
-	union {
-		uint64_t u64;
-		struct {
-			uint32_t spi;
-			uint16_t reserved_209_224;
-			uint8_t uc_ccode;
-			uint8_t hw_ccode;
+union cpt_parse_hdr_u {
+	struct cpt_parse_hdr_s {
+		/* WORD 0 */
+		union {
+			uint64_t u64;
+			struct {
+				uint64_t cookie : 32;
+				uint64_t match_id : 16;
+				uint64_t err_sum : 1;
+				uint64_t reas_sts : 4;
+				uint64_t pad_len : 3;
+				uint64_t et_owr : 1;
+				uint64_t pkt_fmt : 1;
+				uint64_t num_frags : 4;
+				uint64_t pkt_out : 2;
+			};
+		} w0;
+
+		/* WORD 1 */
+		uint64_t wqe_ptr;
+
+		/* WORD 2 */
+		union {
+			uint64_t u64;
+			struct {
+				uint64_t rsvd_134_128 : 7;
+				uint64_t pkt_inline : 1;
+				uint64_t new_pkt_aura : 20;
+				uint64_t orig_pkt_aura : 20;
+				uint64_t il3_off : 8;
+				uint64_t ptr_pad : 3;
+				uint64_t ptr_offset : 5;
+			};
+		} w2;
+
+		/* WORD 3 */
+		union {
+			uint64_t u64;
+			struct {
+				uint8_t hw_ccode;
+				uint8_t uc_ccode;
+				uint16_t frag_age;
+				uint16_t pf_func;
+				uint16_t rlen;
+			};
+		} w3;
+
+		/* WORD 4 */
+		union {
+			uint64_t u64;
+			struct {
+				uint32_t l4_chksum;
+				uint32_t l4_chksum_type : 1;
+				uint32_t rsvd_298_289 : 10;
+				uint32_t channel : 12;
+				uint32_t sctr_size : 4;
+				uint32_t gthr_size : 5;
+			};
+		} w4;
+	} s;
+
+	struct cpt_cn10k_parse_hdr_s {
+		/* WORD 0 */
+		union {
+			uint64_t u64;
+			struct {
+				uint8_t pad_len : 3;
+				uint8_t num_frags : 3;
+				uint8_t pkt_out : 2;
+
+				uint8_t err_sum : 1;
+				uint8_t reas_sts : 4;
+				uint8_t reserved_53 : 1;
+				uint8_t et_owr : 1;
+				uint8_t pkt_fmt : 1;
+
+				uint16_t match_id : 16;
+
+				uint32_t cookie : 32;
+			};
+		} w0;
+
+		/* WORD 1 */
+		uint64_t wqe_ptr;
+
+		/* WORD 2 */
+		union {
+			uint64_t u64;
+			struct {
+				uint8_t fi_pad : 3;
+				uint8_t fi_offset : 5;
+				uint8_t il3_off;
+				uint16_t orig_pf_func;
+				uint16_t reserved_145_160;
+				uint16_t frag_age;
+			};
+		} w2;
+
+		/* WORD 3 */
+		union {
+			uint64_t u64;
+			struct {
+				uint32_t spi;
+				uint16_t reserved_209_224;
+				uint8_t uc_ccode;
+				uint8_t hw_ccode;
+			};
+		} w3;
+
+		/* WORD 4 */
+		union {
+			uint64_t u64;
+			uint64_t esn;
+			uint64_t frag1_wqe_ptr;
 		};
-	} w3;
-
-	/* WORD 4 */
-	union {
-		uint64_t u64;
-		uint64_t esn;
-		uint64_t frag1_wqe_ptr;
-	};
+	} cn10k;
+
+	uint64_t u64[5];
 };
 
 union cpt_frag_info {
@@ -413,6 +477,47 @@ struct cpt_frag_info_s {
 	} w1;
 };
 
+/* CPT rxc pointer info structure */
+struct cpt_rxc_ptr_info_s {
+	/* WORD 0 */
+	union {
+		uint64_t u64;
+		struct {
+			uint64_t rsvd_47_0 : 48;
+			uint64_t size : 16;
+		};
+	} w0;
+
+	/* WORD 1 */
+	uint64_t ptr;
+};
+
+/* CPT rxc scatter/gather subdescriptor structure */
+struct cpt_rxc_sg_s {
+	/* WORD 0 */
+	union {
+		uint64_t u64;
+		struct {
+			uint16_t seg1_size;
+			uint16_t seg2_size;
+			uint16_t seg3_size;
+			uint16_t segs : 2;
+			uint16_t nxt_fst_frag : 3;
+			uint16_t blk_sz : 4;
+			uint16_t rsvd_63_57 : 7;
+		};
+	} w0;
+
+	/* WORD 1 */
+	uint64_t seg1_ptr;
+
+	/* WORD 2 */
+	uint64_t seg2_ptr;
+
+	/* WORD 3 */
+	uint64_t seg3_ptr;
+};
+
 union cpt_fc_write_s {
 	struct {
 		uint32_t qsize;
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 30bd2a094d..238f55eff4 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -227,7 +227,7 @@ void __roc_api roc_cpt_iq_enable(struct roc_cpt_lf *lf);
 int __roc_api roc_cpt_lmtline_init(struct roc_cpt *roc_cpt, struct roc_cpt_lmtline *lmtline,
 				   int lf_id, bool is_dual);
 
-void __roc_api roc_cpt_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth);
+void __roc_api roc_cpt_parse_hdr_dump(FILE *file, const union cpt_parse_hdr_u *cpth);
 int __roc_api roc_cpt_ctx_write(struct roc_cpt_lf *lf, void *sa_dptr, void *sa_cptr,
 				uint16_t sa_len);
 
diff --git a/drivers/common/cnxk/roc_cpt_debug.c b/drivers/common/cnxk/roc_cpt_debug.c
index 8e69b0a0e5..35a2cf6b3a 100644
--- a/drivers/common/cnxk/roc_cpt_debug.c
+++ b/drivers/common/cnxk/roc_cpt_debug.c
@@ -5,15 +5,125 @@
 #include "roc_api.h"
 #include "roc_priv.h"
 
-#define cpt_dump(file, fmt, ...) do {                                           \
-	if ((file) == NULL)							\
-		plt_dump(fmt, ##__VA_ARGS__);					\
-	else									\
-		fprintf(file, fmt "\n", ##__VA_ARGS__);				\
-} while (0)
-
-void
-roc_cpt_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
+#define cpt_dump(file, fmt, ...)                                                                   \
+	do {                                                                                       \
+		if ((file) == NULL)                                                                \
+			plt_dump(fmt, ##__VA_ARGS__);                                              \
+		else                                                                               \
+			fprintf(file, fmt "\n", ##__VA_ARGS__);                                    \
+	} while (0)
+
+static inline void
+cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
+{
+	struct cpt_frag_info_s *frag_info;
+	struct cpt_rxc_sg_s *rxc_sg;
+	uint32_t offset;
+	int i;
+
+	cpt_dump(file, "CPT_PARSE \t0x%p:", cpth);
+
+	/* W0 */
+	cpt_dump(file, "W0: cookie \t0x%x\t\tmatch_id \t0x%04x \t", cpth->w0.cookie,
+		 cpth->w0.match_id);
+	cpt_dump(file, "W0: err_sum \t%u \t", cpth->w0.err_sum);
+	cpt_dump(file, "W0: reas_sts \t0x%x\t\tet_owr \t%u\t\tpkt_fmt \t%u \t", cpth->w0.reas_sts,
+		 cpth->w0.et_owr, cpth->w0.pkt_fmt);
+	cpt_dump(file, "W0: pad_len \t%u\t\tnum_frags \t%u\t\tpkt_out \t%u \t", cpth->w0.pad_len,
+		 cpth->w0.num_frags, cpth->w0.pkt_out);
+
+	/* W1 */
+	cpt_dump(file, "W1: wqe_ptr \t0x%016lx\t", cpth->wqe_ptr);
+
+	/* W2 */
+	cpt_dump(file, "W2: pkt_inline \t0x%x\t\tnew_pkt_aura \t0x%x\t\torig_pkt_aura \t0x%x",
+		 cpth->w2.pkt_inline, cpth->w2.new_pkt_aura, cpth->w2.orig_pkt_aura);
+	cpt_dump(file, "W2: il3_off \t0x%x\t\tptr_pad \t0x%x \t", cpth->w2.il3_off,
+		 cpth->w2.ptr_pad);
+	cpt_dump(file, "W2: ptr_offset \t0x%x \t", cpth->w2.ptr_offset);
+
+	/* W3 */
+	cpt_dump(file, "W3: hw_ccode \t0x%x\t\tuc_ccode \t0x%x\t\tfrag_age \t0x%04x",
+		 cpth->w3.hw_ccode, cpth->w3.uc_ccode, cpth->w3.frag_age);
+	cpt_dump(file, "W3: pf_func \t0x%x\t\trlen \t0x%x \t", cpth->w3.pf_func, cpth->w3.rlen);
+
+	/* W4 */
+	cpt_dump(file, "W4: l4_chksum \t0x%x\t\tl4_chksum_type \t0x%x", cpth->w4.l4_chksum,
+		 cpth->w4.l4_chksum_type);
+	cpt_dump(file, "W4: channel \t0x%x\t\tsctr_size \t0x%08x\t\tgthr_size \t0x%08x",
+		 cpth->w4.channel, cpth->w4.sctr_size, cpth->w4.gthr_size);
+
+	/* offset of 0 implies 256B, otherwise it implies offset*8B */
+	offset = cpth->w2.ptr_offset;
+	offset = (((offset - 1) & 0x1f) + 1) * 8;
+	frag_info = PLT_PTR_ADD(cpth, offset);
+
+	if (cpth->w0.num_frags > 0) {
+		cpt_dump(file, "CPT Fraginfo_0 \t%p:", frag_info);
+
+		/* W0 */
+		cpt_dump(file, "W0: f0.info \t0x%x", frag_info->w0.f0.info);
+		cpt_dump(file, "W0: f1.info \t0x%x", frag_info->w0.f1.info);
+		cpt_dump(file, "W0: f2.info \t0x%x", frag_info->w0.f2.info);
+		cpt_dump(file, "W0: f3.info \t0x%x", frag_info->w0.f3.info);
+
+		/* W1 */
+		cpt_dump(file, "W1: frag_size0 \t0x%x", frag_info->w1.frag_size0);
+		cpt_dump(file, "W1: frag_size1 \t0x%x", frag_info->w1.frag_size1);
+		cpt_dump(file, "W1: frag_size2 \t0x%x", frag_info->w1.frag_size2);
+		cpt_dump(file, "W1: frag_size3 \t0x%x", frag_info->w1.frag_size3);
+
+		frag_info++;
+	}
+
+	if (cpth->w0.num_frags > 4) {
+		cpt_dump(file, "CPT Fraginfo_1 \t%p:", frag_info);
+
+		/* W0 */
+		cpt_dump(file, "W0: f4.info \t0x%x", frag_info->w0.f0.info);
+		cpt_dump(file, "W0: f5.info \t0x%x", frag_info->w0.f1.info);
+		cpt_dump(file, "W0: f6.info \t0x%x", frag_info->w0.f2.info);
+		cpt_dump(file, "W0: f7.info \t0x%x", frag_info->w0.f3.info);
+
+		/* W1 */
+		cpt_dump(file, "W1: frag_size4 \t0x%x", frag_info->w1.frag_size0);
+		cpt_dump(file, "W1: frag_size5 \t0x%x", frag_info->w1.frag_size1);
+		cpt_dump(file, "W1: frag_size6 \t0x%x", frag_info->w1.frag_size2);
+		cpt_dump(file, "W1: frag_size7 \t0x%x", frag_info->w1.frag_size3);
+
+		frag_info++;
+	}
+
+	rxc_sg = (struct cpt_rxc_sg_s *)frag_info;
+	for (i = 0; i < cpth->w4.sctr_size; i++) {
+		cpt_dump(file, "CPT RXC SC SGS \t%p:", rxc_sg);
+		cpt_dump(file, "W0: seg1_size \t0x%x\t\tseg2_size \t0x%x\t\tseg3_size \t0x%04x",
+			 rxc_sg->w0.seg1_size, rxc_sg->w0.seg2_size, rxc_sg->w0.seg3_size);
+		cpt_dump(file, "W0: segs \t0x%x\t\tnxt_fst_frag \t0x%x\t\tblk_sz \t0x%x",
+			 rxc_sg->w0.segs, rxc_sg->w0.nxt_fst_frag, rxc_sg->w0.blk_sz);
+		cpt_dump(file, "W1: seg1_ptr \t0x%" PRIx64, rxc_sg->seg1_ptr);
+		cpt_dump(file, "W2: seg2_ptr \t0x%" PRIx64, rxc_sg->seg2_ptr);
+		cpt_dump(file, "W3: seg3_ptr \t0x%" PRIx64, rxc_sg->seg3_ptr);
+
+		rxc_sg++;
+	}
+
+	for (i = 0; i < cpth->w4.gthr_size; i++) {
+		cpt_dump(file, "CPT RXC GT SGS \t0x%p:", rxc_sg);
+		cpt_dump(file, "W0: seg1_size \t0x%x\t\tseg2_size \t0x%x\t\tseg3_size \t0x%04x",
+			 rxc_sg->w0.seg1_size, rxc_sg->w0.seg2_size, rxc_sg->w0.seg3_size);
+		cpt_dump(file, "W0: segs \t0x%x\t\tnxt_fst_frag \t0x%x\t\tblk_sz \t0x%x",
+			 rxc_sg->w0.segs, rxc_sg->w0.nxt_fst_frag, rxc_sg->w0.blk_sz);
+		cpt_dump(file, "W1: seg1_ptr \t0x%" PRIx64, rxc_sg->seg1_ptr);
+		cpt_dump(file, "W2: seg2_ptr \t0x%" PRIx64, rxc_sg->seg2_ptr);
+		cpt_dump(file, "W3: seg3_ptr \t0x%" PRIx64, rxc_sg->seg3_ptr);
+
+		rxc_sg++;
+	}
+}
+
+static inline void
+cpt_cn10k_parse_hdr_dump(FILE *file, const struct cpt_cn10k_parse_hdr_s *cpth)
 {
 	struct cpt_frag_info_s *frag_info;
 	uint32_t offset;
@@ -69,10 +179,17 @@ roc_cpt_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 	cpt_dump(file, "W1: frag_size3 \t0x%x", frag_info->w1.frag_size3);
 
 	slot = (uint64_t *)(frag_info + 1);
-	cpt_dump(file, "Frag Slot2:  WQE ptr \t%p",
-		  (void *)plt_be_to_cpu_64(slot[0]));
-	cpt_dump(file, "Frag Slot3:  WQE ptr \t%p",
-		  (void *)plt_be_to_cpu_64(slot[1]));
+	cpt_dump(file, "Frag Slot2:  WQE ptr \t%p", (void *)plt_be_to_cpu_64(slot[0]));
+	cpt_dump(file, "Frag Slot3:  WQE ptr \t%p", (void *)plt_be_to_cpu_64(slot[1]));
+}
+
+void
+roc_cpt_parse_hdr_dump(FILE *file, const union cpt_parse_hdr_u *cpth)
+{
+	if (roc_model_is_cn10k())
+		cpt_cn10k_parse_hdr_dump(file, &cpth->cn10k);
+	else
+		cpt_cnxk_parse_hdr_dump(file, &cpth->s);
 }
 
 static int
diff --git a/drivers/net/cnxk/cn10k_ethdev.c b/drivers/net/cnxk/cn10k_ethdev.c
index fbb9b09062..3f8c66615d 100644
--- a/drivers/net/cnxk/cn10k_ethdev.c
+++ b/drivers/net/cnxk/cn10k_ethdev.c
@@ -711,7 +711,7 @@ cn10k_rx_descriptor_dump(const struct rte_eth_dev *eth_dev, uint16_t qid,
 	const uint64_t data_off = rxq->data_off;
 	const uint32_t qmask = rxq->qmask;
 	const uintptr_t desc = rxq->desc;
-	struct cpt_parse_hdr_s *cpth;
+	union cpt_parse_hdr_u *cpth;
 	uint32_t head = rxq->head;
 	struct nix_cqe_hdr_s *cq;
 	uint16_t count = 0;
@@ -733,8 +733,7 @@ cn10k_rx_descriptor_dump(const struct rte_eth_dev *eth_dev, uint16_t qid,
 			rte_iova_t buff = *((rte_iova_t *)((uint64_t *)cq + 9));
 			struct rte_mbuf *mbuf =
 				(struct rte_mbuf *)(buff - data_off);
-			cpth = (struct cpt_parse_hdr_s *)
-				((uintptr_t)mbuf + (uint16_t)data_off);
+			cpth = (union cpt_parse_hdr_u *)((uintptr_t)mbuf + (uint16_t)data_off);
 			roc_cpt_parse_hdr_dump(file, cpth);
 		} else {
 			roc_nix_cqe_dump(file, cq);
diff --git a/drivers/net/cnxk/cn10k_rx.h b/drivers/net/cnxk/cn10k_rx.h
index 3430318193..e79306e646 100644
--- a/drivers/net/cnxk/cn10k_rx.h
+++ b/drivers/net/cnxk/cn10k_rx.h
@@ -147,7 +147,7 @@ nix_sec_flush_meta(uintptr_t laddr, uint16_t lmt_id, uint8_t loff,
 
 #if defined(RTE_ARCH_ARM64)
 static __rte_always_inline uint64_t
-nix_sec_reass_frags_get(const struct cpt_parse_hdr_s *hdr, struct rte_mbuf **next_mbufs)
+nix_sec_reass_frags_get(const struct cpt_cn10k_parse_hdr_s *hdr, struct rte_mbuf **next_mbufs)
 {
 	const struct cpt_frag_info_s *finfo;
 	uint32_t offset = hdr->w2.fi_offset;
@@ -241,7 +241,7 @@ nix_sec_reass_first_frag_update(struct rte_mbuf *head, const uint8_t *m_ipptr,
 
 #else
 static __rte_always_inline uint64_t
-nix_sec_reass_frags_get(const struct cpt_parse_hdr_s *hdr, struct rte_mbuf **next_mbufs)
+nix_sec_reass_frags_get(const struct cpt_cn10k_parse_hdr_s *hdr, struct rte_mbuf **next_mbufs)
 {
 	RTE_SET_USED(hdr);
 	next_mbufs[0] = NULL;
@@ -263,7 +263,7 @@ nix_sec_reass_first_frag_update(struct rte_mbuf *head, const uint8_t *m_ipptr,
 #endif
 
 static struct rte_mbuf *
-nix_sec_attach_frags(const struct cpt_parse_hdr_s *hdr,
+nix_sec_attach_frags(const struct cpt_cn10k_parse_hdr_s *hdr,
 		     struct rte_mbuf *head,
 		     struct cn10k_inb_priv_data *inb_priv,
 		     const uint64_t mbuf_init)
@@ -331,7 +331,7 @@ nix_sec_attach_frags(const struct cpt_parse_hdr_s *hdr,
 }
 
 static __rte_always_inline struct rte_mbuf *
-nix_sec_reassemble_frags(const struct cpt_parse_hdr_s *hdr, struct rte_mbuf *head,
+nix_sec_reassemble_frags(const struct cpt_cn10k_parse_hdr_s *hdr, struct rte_mbuf *head,
 			 uint64_t cq_w1, uint64_t cq_w5, uint64_t mbuf_init)
 {
 	uint8_t num_frags = hdr->w0.num_frags;
@@ -414,7 +414,8 @@ nix_sec_reassemble_frags(const struct cpt_parse_hdr_s *hdr, struct rte_mbuf *hea
 }
 
 static inline struct rte_mbuf *
-nix_sec_oop_process(const struct cpt_parse_hdr_s *hdr, struct rte_mbuf *mbuf, uint64_t *mbuf_init)
+nix_sec_oop_process(const struct cpt_cn10k_parse_hdr_s *hdr, struct rte_mbuf *mbuf,
+		    uint64_t *mbuf_init)
 {
 	uintptr_t wqe = rte_be_to_cpu_64(hdr->wqe_ptr);
 	union nix_rx_parse_u *inner_rx;
@@ -438,7 +439,7 @@ nix_sec_oop_process(const struct cpt_parse_hdr_s *hdr, struct rte_mbuf *mbuf, ui
 	 * calculate actual data off and update in meta mbuf.
 	 */
 	data_off = (uintptr_t)hdr - (uintptr_t)mbuf->buf_addr;
-	data_off += sizeof(struct cpt_parse_hdr_s);
+	data_off += sizeof(struct cpt_cn10k_parse_hdr_s);
 	data_off += hdr->w0.pad_len;
 	*mbuf_init &= ~0xFFFFUL;
 	*mbuf_init |= (uint64_t)data_off;
@@ -455,7 +456,7 @@ nix_sec_meta_to_mbuf_sc(uint64_t cq_w1, uint64_t cq_w5, const uint64_t sa_base,
 			uint64_t mbuf_init)
 {
 	const void *__p = (void *)((uintptr_t)mbuf + (uint16_t)data_off);
-	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)__p;
+	const struct cpt_cn10k_parse_hdr_s *hdr = (const struct cpt_cn10k_parse_hdr_s *)__p;
 	struct cn10k_inb_priv_data *inb_priv;
 	struct rte_mbuf *inner = NULL;
 	uint32_t sa_idx;
@@ -568,8 +569,8 @@ nix_sec_meta_to_mbuf(uint64_t cq_w1, uint64_t cq_w5, uintptr_t inb_sa,
 		     uint8x16_t *rx_desc_field1, uint64_t *ol_flags,
 		     const uint16_t flags, uint64x2_t *rearm)
 {
-	const struct cpt_parse_hdr_s *hdr =
-		(const struct cpt_parse_hdr_s *)cpth;
+	const struct cpt_cn10k_parse_hdr_s *hdr =
+		(const struct cpt_cn10k_parse_hdr_s *)cpth;
 	uint64_t mbuf_init = vgetq_lane_u64(*rearm, 0);
 	struct cn10k_inb_priv_data *inb_priv;
 	uintptr_t p;
@@ -700,7 +701,7 @@ static __rte_always_inline void
 nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf,
 		    uint64_t rearm, uintptr_t cpth, uintptr_t sa_base, const uint16_t flags)
 {
-	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)cpth;
+	const struct cpt_cn10k_parse_hdr_s *hdr = (const struct cpt_cn10k_parse_hdr_s *)cpth;
 	struct cn10k_inb_priv_data *inb_priv = NULL;
 	uint8_t num_frags = 0, frag_i = 0;
 	struct rte_mbuf *next_mbufs[3];
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 4e4337a6e5..1b608442cf 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -677,7 +677,7 @@ cn20k_rx_descriptor_dump(const struct rte_eth_dev *eth_dev, uint16_t qid, uint16
 	const uint64_t data_off = rxq->data_off;
 	const uint32_t qmask = rxq->qmask;
 	const uintptr_t desc = rxq->desc;
-	struct cpt_parse_hdr_s *cpth;
+	union cpt_parse_hdr_u *cpth;
 	uint32_t head = rxq->head;
 	struct nix_cqe_hdr_s *cq;
 	uint16_t count = 0;
@@ -697,7 +697,7 @@ cn20k_rx_descriptor_dump(const struct rte_eth_dev *eth_dev, uint16_t qid, uint16
 		if (cq_w1 & BIT(11)) {
 			rte_iova_t buff = *((rte_iova_t *)((uint64_t *)cq + 9));
 			struct rte_mbuf *mbuf = (struct rte_mbuf *)(buff - data_off);
-			cpth = (struct cpt_parse_hdr_s *)((uintptr_t)mbuf + (uint16_t)data_off);
+			cpth = (union cpt_parse_hdr_u *)((uintptr_t)mbuf + (uint16_t)data_off);
 			roc_cpt_parse_hdr_dump(file, cpth);
 		} else {
 			roc_nix_cqe_dump(file, cq);
-- 
2.34.1

