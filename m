Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5259FCA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC48940E43;
	Mon,  5 Oct 2026 22:25:34 +0200 (CEST)
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com
 [209.85.128.228])
 by mails.dpdk.org (Postfix) with ESMTP id 9CD8840E22
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:33 +0200 (CEST)
Received: by mail-yw1-f228.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso1201797b3.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231933; x=1791836733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z3pnjy9ZcuRbM9v7qBtyox30r3vH1/B1qpDmBib9Okw=;
 b=muTQXvJbfPa8/Eu4mWIdDeZFHB2gf1OjGtYjSnYigwN9bWf4umbWn+c0rJ92LZLAhk
 P/Hz+YXWDEgmNRF1z5GexN5Ms1joVKTIJ02Y/kB7ZQjiYTkhFFD7qGbGfqidAuvIbRpB
 CHTozj7sdNEB8Fih7t/NvdnRSMjQSqhqc0LL+BVj2SElCoz732qCGNZLv3shnLv/+Ikm
 zMAl90QQVquou4IBDbGLMYrfvB++5EjO8EV849/ZgsaakR/qL+s3386ma1OcKRcR+ERy
 t6VGM8qtTperZgffDl2+zqWuAGXmq/9X1trTwGhSVNLaP+draaKzW5uosnVq7IaYv3db
 qheA==
X-Gm-Message-State: AFq9FYIjhCG0oUlPYxMgSJPOmoebZseFej+Nt0xrgGzGdH8gL+TwWRy9
 q5ErSq7VLRcxGkgTF63N45bw7LuabsNscJ7Lz7KmHwdqgZumQW3PMcN5XWNCM09JAFE5XkU0Urg
 AOmITG19hHtnX/8Rd39uj2f37S1UI3FL+GYh8nJx91/DHtZroaJrBpNebfhoWKYmfPSse39Dbd/
 8sVBBSCimA7lbAwLlavOcWo//FVs1ReuWTq6b3wlDYkwE3Bnvs9ZBmXvrDkzLvu9hSN2iy+Q==
X-Gm-Gg: AYBFou2VOlfa/85NRNPHG8lw6YZ2WqzT/2pu2Ss07ErvgUl6riUHe4nyE8u3pvv8Cvy
 vaeONtdaahOjdgGn7qRlGK/3FMEHRp1Oc4Ocv5wDo1f9YMuR33PJk8csl8VEY7wpYJV6qvffdgM
 E+WlxBWjO4qiR6iyFv0l+MginB24LAexgNRIfMYKuVhc1TxV7MBz9J7Py6Ul0sv4Lx8CLhhyjGg
 ZKUEOB0iXNIGuCoCkCqovpHTluDVIvBpIFLMwYHaqAR8CflZOUXVDQhpDGYHhvNKcKKoQrJRYHK
 tewihen/wMHnbb3pDjs4eiAqQQZzw04ycd7lYVl00eJMGkEzEIynQOdHGQLED6YTnjBaSeBzrei
 P6NpERbJ+RVcFeptwFfAohNQn6M+AiBr5bp6fFb9nBnQu/0seKHCy8C/UmNk2iVaHl2rw0cIibq
 2yAK5cu3tohGcRlkEWBYCPmuCz0m1X3dIl6X4=
X-Received: by 2002:a05:690e:d01:b0:66f:7e05:c3f8 with SMTP id
 956f58d0204a3-677ac00785emr3978308d50.42.1791231932181; 
 Mon, 05 Oct 2026 13:25:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-677c1b6e1b6sm1460709d50.23.2026.10.05.13.25.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf7856ffso342616285a.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231931; x=1791836731; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z3pnjy9ZcuRbM9v7qBtyox30r3vH1/B1qpDmBib9Okw=;
 b=OTDSm8S5NdkdU7NyxeYZWIoxRBeWkR0oO5Th4RlnP3N4ujCvlPMoyzloE1MbwErvaP
 1mwqTArMPzQSamhiJWTv6z62B0MR1MWHKJkDxxEEj6iGEDi7p8zLJqXD2IuptU37nEzG
 slRK+gQA6KZGLADYpKh34jNdKHaaB1DtViVSs=
X-Received: by 2002:a05:620a:6cc8:b0:93e:5fbf:a41c with SMTP id
 af79cd13be357-93e5fbfac39mr1242516785a.16.1791231931321; 
 Mon, 05 Oct 2026 13:25:31 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc8:b0:93e:5fbf:a41c with SMTP id
 af79cd13be357-93e5fbfac39mr1242510085a.16.1791231930550; 
 Mon, 05 Oct 2026 13:25:30 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca2643acsm949920585a.32.2026.10.05.13.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:30 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joey Zhong <xiaozhen.zhong@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix -Warray-bounds in blob bit-stream pull helpers
Date: Mon,  5 Oct 2026 15:25:26 -0500
Message-Id: <20261005202526.17981-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Joey Zhong <xiaozhen.zhong@broadcom.com>

GCC inlines ulp_bs_pull_lsb() and flags the remainder branch:
  if (len)
      ulp_bs_get_lsb(src, offset, len, &dst[size - 1 - idx]);
After the full-byte loop exits, idx == cnt. When cnt == size with a
non-zero bit remainder (e.g., len = 33 with size = 4), the subscript
size - 1 - idx underflows to UINT32_MAX, producing a -Warray-bounds
false positive (and a genuine out-of-bounds write if len/size are
ever miscalculated upstream of the check that normally prevents
this). ulp_blob_pull() rejects this state via its
ULP_BYTE_2_BITS(data_size) < len check, but GCC cannot carry that
constraint through the inlined call chain.

Changes:
- ulp_bs_pull_lsb / ulp_bs_pull_msb: add unlikely(cnt > size) entry
  guard and an explicit likely(idx < size) check on the remainder
  branch so GCC can prove all subscripts are in range.
- ulp_bs_pull_msb: add the missing uint32_t size parameter (matching
  ulp_bs_pull_lsb) and update its three call sites to pass the
  destination buffer size.
- ulp_bs_get_lsb / ulp_bs_get_msb: add unlikely(!bitlen) early exit
  to make the zero-length contract explicit.

Fixes: f634204b7ad8 ("net/bnxt: support generic table processing")
Cc: stable@dpdk.org

Signed-off-by: Joey Zhong <xiaozhen.zhong@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c |  2 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper.c  |  1 +
 drivers/net/bnxt/tf_ulp/ulp_utils.h   | 44 +++++++++++++++++++++++----
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c b/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c
index ac0a7e6db1..535849b1f9 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c
@@ -309,7 +309,7 @@ ulp_mapper_gen_tbl_entry_data_get(struct ulp_mapper_gen_tbl_entry *entry,
 	if (entry->byte_order == BNXT_ULP_BYTE_ORDER_LE)
 		ulp_bs_pull_lsb(entry->byte_data, data, data_size, offset, len);
 	else
-		ulp_bs_pull_msb(entry->byte_data, data, offset, len);
+		ulp_bs_pull_msb(entry->byte_data, data, data_size, offset, len);
 
 	return 0;
 }
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index 960cdda311..168f05a5a4 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -701,6 +701,7 @@ ulp_mapper_tbl_ident_scan_ext(struct bnxt_ulp_mapper_parms *parms,
 					idents[i].ident_bit_size);
 		else
 			ulp_bs_pull_msb(byte_data, (uint8_t *)&val64,
+					sizeof(val64),
 					idents[i].ident_bit_pos,
 					idents[i].ident_bit_size);
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_utils.h b/drivers/net/bnxt/tf_ulp/ulp_utils.h
index ce20f1916f..5cb6e48b37 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_utils.h
@@ -663,6 +663,11 @@ ulp_bs_get_lsb(uint8_t *src, uint16_t bitpos, uint8_t bitlen, uint8_t *dst)
 	uint16_t index  = ULP_BITS_2_BYTE_NR(bitpos);
 	uint8_t mask, partial, shift;
 
+	if (unlikely(!bitlen)) {
+		*dst = 0;
+		return;
+	}
+
 	shift = bitoffs;
 	partial = ULP_BLOB_BYTE - bitoffs;
 	if (bitoffs + bitlen <= ULP_BLOB_BYTE) {
@@ -700,6 +705,16 @@ ulp_bs_pull_lsb(uint8_t *src, uint8_t *dst, uint32_t size,
 	uint32_t idx;
 	uint32_t cnt = ULP_BITS_2_BYTE_NR(len);
 
+	/*
+	 * cnt > size means len >= (size + 1) * 8; caller should have
+	 * rejected this. It does not catch size*8 < len < (size + 1)*8,
+	 * which also can't fit in dst: there cnt == size, so idx == size
+	 * after the loop below, which makes "idx < size" false and
+	 * silently drops the remainder instead of writing past dst.
+	 */
+	if (unlikely(cnt > size))
+		return;
+
 	/* iterate bytewise to get data */
 	for (idx = 0; idx < cnt; idx++) {
 		ulp_bs_get_lsb(src, offset, ULP_BLOB_BYTE,
@@ -708,8 +723,8 @@ ulp_bs_pull_lsb(uint8_t *src, uint8_t *dst, uint32_t size,
 		len -= ULP_BLOB_BYTE;
 	}
 
-	/* Extract the last reminder data that is not 8 byte boundary */
-	if (len)
+	/* Extract the last remainder data that is not 8 byte boundary */
+	if (len && likely(idx < size))
 		ulp_bs_get_lsb(src, offset, len, &dst[size - 1 - idx]);
 }
 
@@ -735,6 +750,11 @@ ulp_bs_get_msb(uint8_t *src, uint16_t bitpos, uint8_t bitlen, uint8_t *dst)
 	uint8_t mask;
 	int32_t shift;
 
+	if (unlikely(!bitlen)) {
+		*dst = 0;
+		return;
+	}
+
 	shift = ULP_BLOB_BYTE - bitoffs - bitlen;
 	if (shift >= 0) {
 		mask = 0xFF >> -bitlen;
@@ -752,6 +772,8 @@ ulp_bs_get_msb(uint8_t *src, uint16_t bitpos, uint8_t bitlen, uint8_t *dst)
  *
  * dst [out] The byte array where data is pulled into
  *
+ * size [in] The size of dst array in bytes
+ *
  * offset [in] The offset where data is pulled
  *
  * len [in] The number of bits to be extracted from the data array
@@ -759,12 +781,22 @@ ulp_bs_get_msb(uint8_t *src, uint16_t bitpos, uint8_t bitlen, uint8_t *dst)
  * returns None.
  */
 static inline void
-ulp_bs_pull_msb(uint8_t *src, uint8_t *dst,
+ulp_bs_pull_msb(uint8_t *src, uint8_t *dst, uint32_t size,
 		uint32_t offset, uint32_t len)
 {
 	uint32_t idx;
 	uint32_t cnt = ULP_BITS_2_BYTE_NR(len);
 
+	/*
+	 * cnt > size means len >= (size + 1) * 8; caller should have
+	 * rejected this. It does not catch size*8 < len < (size + 1)*8,
+	 * which also can't fit in dst: there cnt == size, so idx == size
+	 * after the loop below, which makes "idx < size" false and
+	 * silently drops the remainder instead of writing past dst.
+	 */
+	if (unlikely(cnt > size))
+		return;
+
 	/* iterate bytewise to get data */
 	for (idx = 0; idx < cnt; idx++) {
 		ulp_bs_get_msb(src, offset, ULP_BLOB_BYTE, &dst[idx]);
@@ -772,8 +804,8 @@ ulp_bs_pull_msb(uint8_t *src, uint8_t *dst,
 		len -= ULP_BLOB_BYTE;
 	}
 
-	/* Extract the last reminder data that is not 8 byte boundary */
-	if (len)
+	/* Extract the last remainder data that is not 8 byte boundary */
+	if (len && likely(idx < size))
 		ulp_bs_get_msb(src, offset, len, &dst[idx]);
 }
 
@@ -802,7 +834,7 @@ ulp_blob_pull(struct ulp_blob *blob, uint8_t *data, uint32_t data_size,
 	}
 
 	if (blob->byte_order == BNXT_ULP_BYTE_ORDER_BE)
-		ulp_bs_pull_msb(blob->data, data, offset, len);
+		ulp_bs_pull_msb(blob->data, data, data_size, offset, len);
 	else
 		ulp_bs_pull_lsb(blob->data, data, data_size, offset, len);
 	return 0;
-- 
2.31.1

