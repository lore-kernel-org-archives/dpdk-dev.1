Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99FCA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:51:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D235340A6B;
	Tue,  6 Oct 2026 01:51:01 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 5CAE840E16
 for <dev@dpdk.org>; Tue,  6 Oct 2026 01:51:00 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so1506115ad.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791244259; x=1791849059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3Uea1B1LVtX7MHsXaCAdJNrESd+uohHqiapp+a+ZAdY=;
 b=OKk/WDLsH18t5VzHmCvO4zRFRvOtSpw9u4wCw2IuP+5xoLR+b1Z2dqvSqYNm6BE8F9
 TrmhqICe9rL3mKU4jOXBPsWC+vVTeORixe/6AXRFJUVXJk00buTFIj8kfMNOXm8kbyHQ
 Gig/z1ZV21ev6T+uEsyHXmxUXpEvYYhqFAVKYIwMjFFCOiQ8aeXh+xl/2/ov6A5+a/Q3
 kEBAfbTuPUDZ33Dqd1p5k7srmvDmtAD/uL27Nrfn+EZQiJnRRM+Bs3RAKXGHh3pT49zS
 +RRkYXAZ+/XeQPAasrr8kfvBf75xvS4kGZJxf71AMM7Ya8mxm34IH7kv+lvqH4dgJvt+
 vt9Q==
X-Gm-Message-State: AFq9FYIDd906DPMqY85eWO+6HFrctDgON5cv/kCNI5O4syALmb0WKFhi
 ziUvCDrsr64xfZnPKtyYzJAtftoL4ApxarQmk0ptyxbWzVo4MCWp6EQU+GRyEAvsZz96qPg1+Qj
 sTixlQYeAfNSXj5lft+HmrWuAn70hrktCHT70cun3rMA7znRs+NOuAZvjWYj+MyFupqzz7ksYZz
 NhOk4DCbvolLWSpdX8k5vK8/nGbgL2FMwt4yTDqNQEWvLcO9oCOG51Pj0IqwD/mmsr68GuCA==
X-Gm-Gg: AYBFou1Pk2quOXfdick7sBfWA3ph093ziOiz5BaNbRYMS6sz/c3pjAhPtG/nvSjp9/J
 Fv83X+nWmHtUY8LSATLZFsU3ydUYXAgqkD0C0XgMebydsJ6oWa9Y441HnXZnFgLwO1euvgZWmm/
 /tFFM8N1do0jIf64Ql4VBrb0pusa3Wst6uFNS+sNNBL+Zclgl36Zyt3/7hihFonXr5iW1bHWrg/
 FlpDyEI0IUy5fjJ7sPIq2Njo6SDDFeS/i6trP1DCQScs1KKrrF/MMj0WcI631i2gN5HfGX9Rw3T
 yONgSNqDMg2DK80gZl7RQrIGNwbKedhJKW17U94c2hyUbqij+K/y7lzsBL9vjBslaAwuKYmD/TE
 bzU1tPYgvp4c2zzTbrPE8Z84GY5m8KiXgPuO1NxJ8IatrhXDKXqGg9SL2E+9tMo7Qqws1h4YwB0
 awT5b5DyEmAOLjCjsLtlwPObJM6j68VmvAl7eJDw==
X-Received: by 2002:a17:902:e84c:b0:2df:375f:b7ee with SMTP id
 d9443c01a7336-2e5c51967c9mr5957165ad.18.1791244259357; 
 Mon, 05 Oct 2026 16:50:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2e535d3b51fsm1367305ad.28.2026.10.05.16.50.57
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:50:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-532dc3793easo41019201cf.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791244257; x=1791849057; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Uea1B1LVtX7MHsXaCAdJNrESd+uohHqiapp+a+ZAdY=;
 b=aYd8fNJhKj3F7U55TOvRWFI3E3uT2a6OYOKDZm0F1vp7v1lU8N0jteqOg9FIXEXxif
 FvRkilCFDoASL7pPOQDIHVxne4NBEMGNsJGyBCBVtyk8fWLlwOYQZKewyqXOQ1wmwP3n
 GL6701+1VaOzyPGrf2YmdUwQFdeQwOCjP0aW0=
X-Received: by 2002:a05:622a:958:20b0:535:22c2:f161 with SMTP id
 d75a77b69052e-5353f30d400mr15985091cf.21.1791244256502; 
 Mon, 05 Oct 2026 16:50:56 -0700 (PDT)
X-Received: by 2002:a05:622a:958:20b0:535:22c2:f161 with SMTP id
 d75a77b69052e-5353f30d400mr15984741cf.21.1791244255610; 
 Mon, 05 Oct 2026 16:50:55 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398d41c3csm107784691cf.28.2026.10.05.16.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 16:50:55 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org
Subject: [PATCH] net/bnxt: fix potential OOB string writes in debug helpers
Date: Mon,  5 Oct 2026 18:50:53 -0500
Message-Id: <20261005235053.27074-1-manish.kurup@broadcom.com>
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

The debug-dump helpers in tfc_mpc_debug.c (em_show, mod_decode,
enc_decode, stat_decode) and tfc_tcam_debug.c (prof_tcam_show,
wc_tcam_show) build up formatted strings by appending into a fixed
256-byte buffer without checking remaining space, allowing an
out-of-bounds write once the accumulated output exceeds the
destination buffer.

Add tfc_str_append(), a bounds-checked snprintf() wrapper that
clamps its return value to the space actually available so a chain
of appended writes can never run past the end of the buffer, and use
it in place of the unchecked buffer writes in both files. The two
prof_tcam_show()/wc_tcam_show() dump routines had been converted from
strcat() to snprintf() with raw return-value accumulation, which
reintroduces the same out-of-bounds write on any segment that gets
truncated; both now use tfc_str_append() as well, matching the
already-correct pattern in the equivalent em_show() dump routine.

Fixes: 2a04a71841d9 ("net/bnxt/tf_core: add backing store debug")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_debug.h      |   1 +
 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c  | 167 ++++++++----
 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c | 258 ++++++++++---------
 3 files changed, 245 insertions(+), 181 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_debug.h b/drivers/net/bnxt/tf_core/v3/tfc_debug.h
index 86492f3a69..a1c3e0ceac 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_debug.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_debug.h
@@ -18,6 +18,7 @@ int tfc_mpc_table_write_zero(struct tfc *tfcp,
 			     uint8_t words,
 			     uint8_t *data);
 const char *get_lrec_opcode_str(uint8_t opcode);
+size_t tfc_str_append(char *buf, size_t size, const char *fmt, ...);
 void act_show(FILE *fd, struct act_info_t *act_info, uint32_t offset);
 int tfc_em_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir);
 int tfc_wc_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir);
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c b/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
index 9731127da0..efe91b9554 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
@@ -3,6 +3,7 @@
  * All rights reserved.
  */
 #include <stdio.h>
+#include <stdarg.h>
 #include <inttypes.h>
 #include <math.h>
 #include <string.h>
@@ -24,6 +25,33 @@
 #include "cfa_bld.h"
 #include "tfc_util.h"
 
+/* Helper function to append a formatted string to a buffer of a given size.
+ * Returns the number of chars appended (excluding the NUL terminator).
+ * If size is exceeded, a "<truncated>" marker is appended at the tail
+ * of the buffer.
+ */
+size_t tfc_str_append(char *buf, size_t size, const char *fmt, ...)
+{
+	const char *mark = "<truncated>";
+	size_t marklen = strlen(mark);
+	va_list ap;
+	int n;
+
+	if (size == 0)
+		return 0;
+	va_start(ap, fmt);
+	n = vsnprintf(buf, size, fmt, ap);
+	va_end(ap);
+	if (n < 0)
+		return 0;
+	if ((size_t)n >= size) {
+		if (size > marklen)
+			snprintf(buf + (size - 1 - marklen), marklen + 1, "%s", mark);
+		return size - 1;
+	}
+	return (size_t)n;
+}
+
 int tfc_mpc_table_read(struct tfc *tfcp,
 		       uint8_t tsid,
 		       enum cfa_dir dir,
@@ -577,6 +605,7 @@ static void em_show(FILE *fd, struct em_info_t *em_info)
 	char *line2 = NULL;
 	char *line3 = NULL;
 	char *line4 = NULL;
+	size_t off1, off2, off3, off4;
 	char tmp1[TFC_STRING_LENGTH_64];
 	char tmp2[TFC_STRING_LENGTH_64];
 	char tmp3[TFC_STRING_LENGTH_64];
@@ -598,17 +627,17 @@ static void em_show(FILE *fd, struct em_info_t *em_info)
 
 	fprintf(fd, ":LREC: opcode:%s\n", get_lrec_opcode_str(em_info->opcode));
 
-	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+-Epoch-+--+--+--+");
-	snprintf(line2, TFC_STRING_LENGTH_256, " V|rs|  0  1 |Op|St|ah|");
-	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+----+--+--+--+--+");
-	snprintf(line4, TFC_STRING_LENGTH_256, " %1d %2d %4d %2d %2d %2d %2d ",
-		 em_info->valid,
-		 em_info->rec_size,
-		 em_info->epoch0,
-		 em_info->epoch1,
-		 em_info->opcode,
-		 em_info->strength,
-		 em_info->act_hint);
+	off1 = tfc_str_append(line1, TFC_STRING_LENGTH_256, "+-+--+-Epoch-+--+--+--+");
+	off2 = tfc_str_append(line2, TFC_STRING_LENGTH_256, " V|rs|  0  1 |Op|St|ah|");
+	off3 = tfc_str_append(line3, TFC_STRING_LENGTH_256, "+-+--+----+--+--+--+--+");
+	off4 = tfc_str_append(line4, TFC_STRING_LENGTH_256, " %1d %2d %4d %2d %2d %2d %2d ",
+			em_info->valid,
+			em_info->rec_size,
+			em_info->epoch0,
+			em_info->epoch1,
+			em_info->opcode,
+			em_info->strength,
+			em_info->act_hint);
 
 	if (em_info->opcode != 2 && em_info->opcode != 3) {
 		/* All but FAST */
@@ -626,10 +655,10 @@ static void em_show(FILE *fd, struct em_info_t *em_info)
 			 em_info->destination);
 	}
 
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
 
 	if (em_info->opcode == 4 || em_info->opcode == 6) {
 		/* CT only */
@@ -668,10 +697,10 @@ static void em_show(FILE *fd, struct em_info_t *em_info)
 			 em_info->metadata);
 	}
 
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
 
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-----Range-+\n");
 	snprintf(tmp2, TFC_STRING_LENGTH_64, "Prof|  Idx |\n");
@@ -680,10 +709,10 @@ static void em_show(FILE *fd, struct em_info_t *em_info)
 		 em_info->range_profile,
 		 em_info->range_index);
 
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
 
 	fprintf(fd, "%s%s%s%s",
 		   line1,
@@ -756,6 +785,7 @@ static void mod_decode(uint32_t *data, char *mod_str)
 	int32_t read_offset;
 	int32_t row = 0;
 	uint32_t val[8];
+	size_t mod_off;
 	char str[256];
 	int16_t vect;
 	uint16_t bit = 0x8000;
@@ -763,14 +793,16 @@ static void mod_decode(uint32_t *data, char *mod_str)
 	row_offset -= 16;
 	read_offset = row_offset;
 	mod_vector = tfc_getbits(data, read_offset, 16);
-	snprintf(mod_str,
-		 TFC_MOD_STRING_LENGTH,
-		 "\nModify Record: Vector:0x%08x\n", mod_vector);
+	mod_off = tfc_str_append(mod_str,
+				  TFC_MOD_STRING_LENGTH,
+				  "\nModify Record: Vector:0x%08x\n", mod_vector);
 
 	for (vect = 15; vect >= 0; vect--) {
 		if (mod_vector & bit) {
 			snprintf(str, TFC_STRING_LENGTH_256, "%s: ", mod_data[vect].name);
-			strcat(mod_str, str);
+			mod_off += tfc_str_append(mod_str + mod_off,
+						   TFC_MOD_STRING_LENGTH - mod_off,
+						   "%s", str);
 
 			for (i = 0; i < mod_data[vect].num_fields; i++) {
 				row_offset -= mod_data[vect].field[i].num_bits;
@@ -796,7 +828,9 @@ static void mod_decode(uint32_t *data, char *mod_str)
 					 TFC_STRING_LENGTH_256,
 					 "%s:0x",
 					 mod_data[vect].field[i].name);
-				strcat(mod_str, str);
+				mod_off += tfc_str_append(mod_str + mod_off,
+							   TFC_MOD_STRING_LENGTH - mod_off,
+							   "%s", str);
 
 				switch (mod_data[vect].field[i].num_bits) {
 				case 128:
@@ -805,44 +839,61 @@ static void mod_decode(uint32_t *data, char *mod_str)
 							 TFC_STRING_LENGTH_256,
 							 "%08x",
 							 val[k]);
-						strcat(mod_str, str);
+						mod_off += tfc_str_append(mod_str + mod_off,
+									   TFC_MOD_STRING_LENGTH -
+									   mod_off,
+									   "%s", str);
 					}
 					break;
 				case 48:
 					snprintf(str, TFC_STRING_LENGTH_256, "%08x", val[0]);
-					strcat(mod_str, str);
+					mod_off += tfc_str_append(mod_str + mod_off,
+								   TFC_MOD_STRING_LENGTH - mod_off,
+								   "%s", str);
 					snprintf(str,
 						 TFC_STRING_LENGTH_256,
 						 "%04x",
 						 (val[1] & 0xffff));
-					strcat(mod_str, str);
+					mod_off += tfc_str_append(mod_str + mod_off,
+								   TFC_MOD_STRING_LENGTH - mod_off,
+								   "%s", str);
 					break;
 				case 32:
 					snprintf(str, TFC_STRING_LENGTH_256, "%08x ", val[0]);
-					strcat(mod_str, str);
+					mod_off += tfc_str_append(mod_str + mod_off,
+								   TFC_MOD_STRING_LENGTH - mod_off,
+								   "%s", str);
 					break;
 				case 16:
 					snprintf(str, TFC_STRING_LENGTH_256, "%04x ", val[0]);
-					strcat(mod_str, str);
+					mod_off += tfc_str_append(mod_str + mod_off,
+								   TFC_MOD_STRING_LENGTH - mod_off,
+								   "%s", str);
 					break;
 				default:
 					snprintf(str, TFC_STRING_LENGTH_256, "%04x ",
 						 (val[0] &
 						  ((1 << mod_data[vect].field[i].num_bits) - 1)));
-					strcat(mod_str, str);
+					mod_off += tfc_str_append(mod_str + mod_off,
+								   TFC_MOD_STRING_LENGTH - mod_off,
+								   "%s", str);
 					break;
 				}
 			}
 
 			snprintf(str, TFC_STRING_LENGTH_256, "\n");
-			strcat(mod_str, str);
+			mod_off += tfc_str_append(mod_str + mod_off,
+						   TFC_MOD_STRING_LENGTH - mod_off,
+						   "%s", str);
 		}
 
 		bit = bit >> 1;
 	}
 
 	snprintf(str, TFC_STRING_LENGTH_256, "\n");
-	strcat(mod_str, str);
+	mod_off += tfc_str_append(mod_str + mod_off,
+				   TFC_MOD_STRING_LENGTH - mod_off,
+				   "%s", str);
 }
 
 static void enc_decode(uint32_t *data, char *enc_str)
@@ -856,6 +907,7 @@ static void enc_decode(uint32_t *data, char *enc_str)
 	uint8_t l3;
 	uint8_t l4;
 	uint8_t tunnel;
+	size_t off_s;
 
 	vector = tfc_getbits(data, offset, 16);
 	offset += 16;
@@ -866,9 +918,9 @@ static void enc_decode(uint32_t *data, char *enc_str)
 	l4 = ((vector >> 10) & 0x7);
 	tunnel = ((vector >> 13) & 0x7);
 
-	snprintf(enc_str,
-		 TFC_ENC_STRING_LENGTH,
-		 "Encap Record: vector:0x%04x\n", vector);
+	off_s = tfc_str_append(enc_str,
+				TFC_ENC_STRING_LENGTH,
+				"Encap Record: vector:0x%04x\n", vector);
 
 	snprintf(str, TFC_STRING_LENGTH_64,
 		 "Valid:%d EC:%d VTAG:0x%01x L2:%d L3:0x%01x L4:0x%01x Tunnel:0x%01x\n",
@@ -880,11 +932,11 @@ static void enc_decode(uint32_t *data, char *enc_str)
 		 l4,
 		 tunnel);
 
-	strcat(enc_str, str);
+	off_s += tfc_str_append(enc_str + off_s, TFC_ENC_STRING_LENGTH - off_s, "%s", str);
 
 	if (l2) { /* L2 */
 		snprintf(str, TFC_STRING_LENGTH_64, "L2:\n");
-		strcat(enc_str, str);
+		off_s += tfc_str_append(enc_str + off_s, TFC_ENC_STRING_LENGTH - off_s, "%s", str);
 
 		val[0] = tfc_getbits(data, offset, 32);
 		offset += 32;
@@ -892,22 +944,22 @@ static void enc_decode(uint32_t *data, char *enc_str)
 		offset += 16;
 
 		snprintf(str, TFC_STRING_LENGTH_64, "DMAC:0x%08x%04x\n", val[0], val[1]);
-		strcat(enc_str, str);
+		off_s += tfc_str_append(enc_str + off_s, TFC_ENC_STRING_LENGTH - off_s, "%s", str);
 	}
 
 	if (l3) { /* L3 */
 		snprintf(str, TFC_STRING_LENGTH_64, "L3:\n");
-		strcat(enc_str, str);
+		off_s += tfc_str_append(enc_str + off_s, TFC_ENC_STRING_LENGTH - off_s, "%s", str);
 	}
 
 	if (l4) { /* L4 */
 		snprintf(str, TFC_STRING_LENGTH_64, "L4:\n");
-		strcat(enc_str, str);
+		off_s += tfc_str_append(enc_str + off_s, TFC_ENC_STRING_LENGTH - off_s, "%s", str);
 	}
 
 	if (tunnel) { /* Tunnel */
 		snprintf(str, TFC_STRING_LENGTH_64, "Tunnel:\n");
-		strcat(enc_str, str);
+		off_s += tfc_str_append(enc_str + off_s, TFC_ENC_STRING_LENGTH - off_s, "%s", str);
 	}
 }
 
@@ -1161,13 +1213,14 @@ static void stat_decode(char *str,
 	uint64_t meter_pkt_cnt;
 	uint64_t meter_byte_cnt;
 	uint32_t timestamp;
+	size_t str_off;
 	char tmp0[96];
 
 	/* Common fields */
-	snprintf(str,
-		 TFC_STAT_STRING_LENGTH,
-		 STATS_COMMON_FMT,
-		 stat_num, stats->pkt_cnt, stats->byte_cnt);
+	str_off = tfc_str_append(str,
+				  TFC_STAT_STRING_LENGTH,
+				  STATS_COMMON_FMT,
+				  stat_num, stats->pkt_cnt, stats->byte_cnt);
 
 	switch (stat_ctr_type) {
 	case CFA_BLD_STAT_COUNTER_SIZE_16B:
@@ -1180,7 +1233,9 @@ static void stat_decode(char *str,
 			 STATS_TCP_FLAGS_FMT,
 			 stats->t.c_24b.tcp_flags,
 			 timestamp);
-		strcat(str, tmp0);
+		str_off += tfc_str_append(str + str_off,
+					   TFC_STAT_STRING_LENGTH - str_off,
+					   "%s", tmp0);
 		break;
 	case CFA_BLD_STAT_COUNTER_SIZE_32B:
 		snprintf(tmp0,
@@ -1188,7 +1243,9 @@ static void stat_decode(char *str,
 			 STATS_METER_FMT,
 			 stats->t.c_32b.meter_pkt_cnt,
 			 stats->t.c_32b.meter_byte_cnt);
-		strcat(str, tmp0);
+		str_off += tfc_str_append(str + str_off,
+					   TFC_STAT_STRING_LENGTH - str_off,
+					   "%s", tmp0);
 		break;
 	case CFA_BLD_STAT_COUNTER_SIZE_32B_ALL:
 		meter_pkt_cnt = stats->t.c_32b_all.meter_pkt_cnt;
@@ -1201,14 +1258,18 @@ static void stat_decode(char *str,
 			 meter_byte_cnt,
 			 stats->t.c_32b_all.tcp_flags,
 			 timestamp);
-		strcat(str, tmp0);
+		str_off += tfc_str_append(str + str_off,
+					   TFC_STAT_STRING_LENGTH - str_off,
+					   "%s", tmp0);
 		break;
 	default:
 		       /* Should never happen since type is 2 bits in size */
 		snprintf(tmp0,
 			 TFC_STRING_LENGTH_96,
 			 "Unknown counter type %d\n", stat_ctr_type);
-		strcat(str, tmp0);
+		str_off += tfc_str_append(str + str_off,
+					   TFC_STAT_STRING_LENGTH - str_off,
+					   "%s", tmp0);
 		break;
 	}
 }
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c b/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
index 8da27b8e81..2a4b82da5b 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
@@ -1003,6 +1003,7 @@ static void prof_tcam_show(FILE *fd,
 			   struct prof_tcam_key_t *ptmask_info,
 			   struct prof_tcam_remap_t *ptrmp_info)
 {
+	size_t offh = 0, off1 = 0, off2 = 0, off3 = 0, off4 = 0, off5 = 0;
 	char tmph[TFC_STRING_LENGTH_64];
 	char tmp1[TFC_STRING_LENGTH_64];
 	char tmp2[TFC_STRING_LENGTH_64];
@@ -1034,13 +1035,13 @@ static void prof_tcam_show(FILE *fd,
 		return;
 	}
 
-	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+----+----+----+---------+------"
+	tfc_str_append(line1, TFC_STRING_LENGTH_256, "+-+--+----+----+----+---------+------"
 		 "+--------+-------+-----+---+---+---+\n");
-	snprintf(line2, TFC_STRING_LENGTH_256, "|V|Sp|lpbk|ptyp|rcyc|    MD   |aggerr"
+	tfc_str_append(line2, TFC_STRING_LENGTH_256, "|V|Sp|lpbk|ptyp|rcyc|    MD   |aggerr"
 		 "|l2ipfunc|profunc|hrnxt|IHT|IHG|IIT|\n");
-	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+----+----+----+---------+------"
+	tfc_str_append(line3, TFC_STRING_LENGTH_256, "+-+--+----+----+----+---------+------"
 		 "+--------+-------+-----+---+---+---+\n");
-	snprintf(line4, TFC_STRING_LENGTH_256, " %01x x%01x   %01x   x%01x  x%01x  x%08x"
+	tfc_str_append(line4, TFC_STRING_LENGTH_256, " %01x x%01x   %01x   x%01x  x%01x  x%08x"
 		 "    %01x     x%02x      x%02x     x%01x   x%01x  x%01x   %01x  key\n",
 		 ptkey_info->valid,
 		 ptkey_info->spare,
@@ -1055,7 +1056,7 @@ static void prof_tcam_show(FILE *fd,
 		 ptkey_info->int_hdr_type,
 		 ptkey_info->int_hdr_group,
 		 ptkey_info->int_ifa_tail);
-	snprintf(line5, TFC_STRING_LENGTH_256, " %01x x%01x   %01x   x%01x  x%01x  x%08x"
+	tfc_str_append(line5, TFC_STRING_LENGTH_256, " %01x x%01x   %01x   x%01x  x%01x  x%08x"
 		 "    %01x     x%02x      x%02x     x%01x   x%01x  x%01x   %01x  mask\n",
 		 ptmask_info->valid,
 		 ptmask_info->spare,
@@ -1077,22 +1078,22 @@ static void prof_tcam_show(FILE *fd,
 		line5,
 		line4);
 
-	snprintf(lineh, TFC_STRING_LENGTH_256, "|OTL2 hdr       |");
-	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
-	snprintf(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
-	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
-	snprintf(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
-		 ptkey_info->otl2_hdr_valid,
-		 ptkey_info->otl2_hdr_type,
-		 ptkey_info->otl2_uc_mc_bc,
-		 ptkey_info->otl2_vtag_present,
-		 ptkey_info->otl2_two_vtags);
-	snprintf(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
-		 ptmask_info->otl2_hdr_valid,
-		 ptmask_info->otl2_hdr_type,
-		 ptmask_info->otl2_uc_mc_bc,
-		 ptmask_info->otl2_vtag_present,
-		 ptmask_info->otl2_two_vtags);
+	offh = tfc_str_append(lineh, TFC_STRING_LENGTH_256, "|OTL2 hdr       |");
+	off1 = tfc_str_append(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	off2 = tfc_str_append(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
+	off3 = tfc_str_append(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	off4 = tfc_str_append(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+			ptkey_info->otl2_hdr_valid,
+			ptkey_info->otl2_hdr_type,
+			ptkey_info->otl2_uc_mc_bc,
+			ptkey_info->otl2_vtag_present,
+			ptkey_info->otl2_two_vtags);
+	off5 = tfc_str_append(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+			ptmask_info->otl2_hdr_valid,
+			ptmask_info->otl2_hdr_type,
+			ptmask_info->otl2_uc_mc_bc,
+			ptmask_info->otl2_vtag_present,
+			ptmask_info->otl2_two_vtags);
 
 	snprintf(tmph, TFC_STRING_LENGTH_64, "OTL3 hdr  |");
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+");
@@ -1109,12 +1110,12 @@ static void prof_tcam_show(FILE *fd,
 		 ptmask_info->otl3_hdr_type,
 		 ptmask_info->otl3_hdr_isip);
 
-	strcat(lineh, tmph);
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
-	strcat(line5, tmp5);
+	offh += tfc_str_append(lineh + offh, TFC_STRING_LENGTH_256 - offh, "%s", tmph);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
+	off5 += tfc_str_append(line5 + off5, TFC_STRING_LENGTH_256 - off5, "%s", tmp5);
 
 	snprintf(tmph, TFC_STRING_LENGTH_64, "OTL4 hdr  |");
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+");
@@ -1131,12 +1132,12 @@ static void prof_tcam_show(FILE *fd,
 		 ptmask_info->otl4_hdr_type,
 		 ptmask_info->otl4_hdr_is_udp_tcp);
 
-	strcat(lineh, tmph);
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
-	strcat(line5, tmp5);
+	offh += tfc_str_append(lineh + offh, TFC_STRING_LENGTH_256 - offh, "%s", tmph);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
+	off5 += tfc_str_append(line5 + off5, TFC_STRING_LENGTH_256 - off5, "%s", tmp5);
 
 	snprintf(tmph, TFC_STRING_LENGTH_64, "OT hdr      |\n");
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+---+---+\n");
@@ -1153,12 +1154,12 @@ static void prof_tcam_show(FILE *fd,
 		 ptmask_info->ot_hdr_type,
 		 ptmask_info->ot_hdr_flags);
 
-	strcat(lineh, tmph);
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
-	strcat(line5, tmp5);
+	offh += tfc_str_append(lineh + offh, TFC_STRING_LENGTH_256 - offh, "%s", tmph);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
+	off5 += tfc_str_append(line5 + off5, TFC_STRING_LENGTH_256 - off5, "%s", tmp5);
 
 	fprintf(fd, "%s%s%s%s%s%s",
 		lineh,
@@ -1168,22 +1169,22 @@ static void prof_tcam_show(FILE *fd,
 		line5,
 		line4);
 
-	snprintf(lineh, TFC_STRING_LENGTH_256, "|TL2 hdr        |");
-	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
-	snprintf(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
-	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
-	snprintf(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
-		 ptkey_info->tl2_hdr_valid,
-		 ptkey_info->tl2_hdr_type,
-		 ptkey_info->tl2_uc_mc_bc,
-		 ptkey_info->tl2_vtag_present,
-		 ptkey_info->tl2_two_vtags);
-	snprintf(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
-		 ptmask_info->tl2_hdr_valid,
-		 ptmask_info->tl2_hdr_type,
-		 ptmask_info->tl2_uc_mc_bc,
-		 ptmask_info->tl2_vtag_present,
-		 ptmask_info->tl2_two_vtags);
+	offh = tfc_str_append(lineh, TFC_STRING_LENGTH_256, "|TL2 hdr        |");
+	off1 = tfc_str_append(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	off2 = tfc_str_append(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
+	off3 = tfc_str_append(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	off4 = tfc_str_append(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+			ptkey_info->tl2_hdr_valid,
+			ptkey_info->tl2_hdr_type,
+			ptkey_info->tl2_uc_mc_bc,
+			ptkey_info->tl2_vtag_present,
+			ptkey_info->tl2_two_vtags);
+	off5 = tfc_str_append(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+			ptmask_info->tl2_hdr_valid,
+			ptmask_info->tl2_hdr_type,
+			ptmask_info->tl2_uc_mc_bc,
+			ptmask_info->tl2_vtag_present,
+			ptmask_info->tl2_two_vtags);
 
 	snprintf(tmph, TFC_STRING_LENGTH_64, "TL3 hdr   |");
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+");
@@ -1200,12 +1201,12 @@ static void prof_tcam_show(FILE *fd,
 		 ptmask_info->tl3_hdr_type,
 		 ptmask_info->tl3_hdr_isip);
 
-	strcat(lineh, tmph);
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
-	strcat(line5, tmp5);
+	offh += tfc_str_append(lineh + offh, TFC_STRING_LENGTH_256 - offh, "%s", tmph);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
+	off5 += tfc_str_append(line5 + off5, TFC_STRING_LENGTH_256 - off5, "%s", tmp5);
 
 	snprintf(tmph, TFC_STRING_LENGTH_64, "TL4 hdr   |");
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+");
@@ -1222,12 +1223,12 @@ static void prof_tcam_show(FILE *fd,
 		 ptmask_info->tl4_hdr_type,
 		 ptmask_info->tl4_hdr_is_udp_tcp);
 
-	strcat(lineh, tmph);
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
-	strcat(line5, tmp5);
+	offh += tfc_str_append(lineh + offh, TFC_STRING_LENGTH_256 - offh, "%s", tmph);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
+	off5 += tfc_str_append(line5 + off5, TFC_STRING_LENGTH_256 - off5, "%s", tmp5);
 
 	snprintf(tmph, TFC_STRING_LENGTH_64, "T hdr       |\n");
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+---+---+\n");
@@ -1244,12 +1245,12 @@ static void prof_tcam_show(FILE *fd,
 		 ptmask_info->t_hdr_type,
 		 ptmask_info->t_hdr_flags);
 
-	strcat(lineh, tmph);
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
-	strcat(line5, tmp5);
+	offh += tfc_str_append(lineh + offh, TFC_STRING_LENGTH_256 - offh, "%s", tmph);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
+	off5 += tfc_str_append(line5 + off5, TFC_STRING_LENGTH_256 - off5, "%s", tmp5);
 
 	fprintf(fd, "%s%s%s%s%s%s",
 		lineh,
@@ -1259,22 +1260,22 @@ static void prof_tcam_show(FILE *fd,
 		line5,
 		line4);
 
-	snprintf(lineh, TFC_STRING_LENGTH_256, "|L2 hdr         |");
-	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
-	snprintf(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
-	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
-	snprintf(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
-		 ptkey_info->l2_hdr_valid,
-		 ptkey_info->l2_hdr_type,
-		 ptkey_info->l2_uc_mc_bc,
-		 ptkey_info->l2_vtag_present,
-		 ptkey_info->l2_two_vtags);
-	snprintf(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
-		 ptmask_info->l2_hdr_valid,
-		 ptmask_info->l2_hdr_type,
-		 ptmask_info->l2_uc_mc_bc,
-		 ptmask_info->l2_vtag_present,
-		 ptmask_info->l2_two_vtags);
+	offh = tfc_str_append(lineh, TFC_STRING_LENGTH_256, "|L2 hdr         |");
+	off1 = tfc_str_append(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	off2 = tfc_str_append(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
+	off3 = tfc_str_append(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	off4 = tfc_str_append(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+			ptkey_info->l2_hdr_valid,
+			ptkey_info->l2_hdr_type,
+			ptkey_info->l2_uc_mc_bc,
+			ptkey_info->l2_vtag_present,
+			ptkey_info->l2_two_vtags);
+	off5 = tfc_str_append(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+			ptmask_info->l2_hdr_valid,
+			ptmask_info->l2_hdr_type,
+			ptmask_info->l2_uc_mc_bc,
+			ptmask_info->l2_vtag_present,
+			ptmask_info->l2_two_vtags);
 
 	snprintf(tmph, TFC_STRING_LENGTH_64, "L3 hdr         |");
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+----+");
@@ -1293,12 +1294,12 @@ static void prof_tcam_show(FILE *fd,
 		 ptmask_info->l3_hdr_isip,
 		 ptmask_info->l3_protocol);
 
-	strcat(lineh, tmph);
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
-	strcat(line5, tmp5);
+	offh += tfc_str_append(lineh + offh, TFC_STRING_LENGTH_256 - offh, "%s", tmph);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
+	off5 += tfc_str_append(line5 + off5, TFC_STRING_LENGTH_256 - off5, "%s", tmp5);
 
 	snprintf(tmph, TFC_STRING_LENGTH_64, "L4 hdr                 |\n");
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+---+----+---+\n");
@@ -1321,12 +1322,12 @@ static void prof_tcam_show(FILE *fd,
 		 ptmask_info->l4_flags,
 		 ptmask_info->l4_dcn_present);
 
-	strcat(lineh, tmph);
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
-	strcat(line5, tmp5);
+	offh += tfc_str_append(lineh + offh, TFC_STRING_LENGTH_256 - offh, "%s", tmph);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
+	off5 += tfc_str_append(line5 + off5, TFC_STRING_LENGTH_256 - off5, "%s", tmp5);
 
 	fprintf(fd, "%s%s%s%s%s%s",
 		lineh,
@@ -1337,10 +1338,10 @@ static void prof_tcam_show(FILE *fd,
 		line4);
 
 	fputs("\n:Profile TCAM: remap\n", fd);
-	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+---+---+--+---+---+---+\n");
-	snprintf(line2, TFC_STRING_LENGTH_256, "|B|EM|PID|KId|Scp|WC|PID|KId|Scp|\n");
-	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+---+---+--+---+---+---+\n");
-	snprintf(line4, TFC_STRING_LENGTH_256, " %c  %c x%02x x%02x x%02x  %c x%02x x%02x x%02x\n",
+	tfc_str_append(line1, TFC_STRING_LENGTH_256, "+-+--+---+---+---+--+---+---+---+\n");
+	tfc_str_append(line2, TFC_STRING_LENGTH_256, "|B|EM|PID|KId|Scp|WC|PID|KId|Scp|\n");
+	tfc_str_append(line3, TFC_STRING_LENGTH_256, "+-+--+---+---+---+--+---+---+---+\n");
+	tfc_str_append(line4, TFC_STRING_LENGTH_256, " %c  %c x%02x x%02x x%02x  %c x%02x x%02x x%02x\n",
 		 ptrmp_info->pl_byp_lkup_en ? 'Y' : 'N',
 		 ptrmp_info->em_search_en ? 'Y' : 'N',
 		 ptrmp_info->em_profile_id,
@@ -1451,6 +1452,7 @@ static void wc_tcam_show(FILE *fd, struct wc_lrec_t *wc_info)
 	char *line2 = NULL;
 	char *line3 = NULL;
 	char *line4 = NULL;
+	size_t off1, off2, off3, off4;
 	char tmp1[TFC_STRING_LENGTH_64];
 	char tmp2[TFC_STRING_LENGTH_64];
 	char tmp3[TFC_STRING_LENGTH_64];
@@ -1472,17 +1474,17 @@ static void wc_tcam_show(FILE *fd, struct wc_lrec_t *wc_info)
 
 	fprintf(fd, ":LREC: opcode:%s\n", get_lrec_opcode_str(wc_info->opcode));
 
-	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+-Epoch-+--+--+--+");
-	snprintf(line2, TFC_STRING_LENGTH_256, " V|rs|  0  1 |Op|St|ah|");
-	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+----+--+--+--+--+");
-	snprintf(line4, TFC_STRING_LENGTH_256, " %1d %2d %4d %2d %2d %2d %2d ",
-		 wc_info->valid,
-		 wc_info->rec_size,
-		 wc_info->epoch0,
-		 wc_info->epoch1,
-		 wc_info->opcode,
-		 wc_info->strength,
-		 wc_info->act_hint);
+	off1 = tfc_str_append(line1, TFC_STRING_LENGTH_256, "+-+--+-Epoch-+--+--+--+");
+	off2 = tfc_str_append(line2, TFC_STRING_LENGTH_256, " V|rs|  0  1 |Op|St|ah|");
+	off3 = tfc_str_append(line3, TFC_STRING_LENGTH_256, "+-+--+----+--+--+--+--+");
+	off4 = tfc_str_append(line4, TFC_STRING_LENGTH_256, " %1d %2d %4d %2d %2d %2d %2d ",
+			wc_info->valid,
+			wc_info->rec_size,
+			wc_info->epoch0,
+			wc_info->epoch1,
+			wc_info->opcode,
+			wc_info->strength,
+			wc_info->act_hint);
 
 	if (wc_info->opcode != 2 && wc_info->opcode != 3) {
 		/* All but FAST */
@@ -1500,10 +1502,10 @@ static void wc_tcam_show(FILE *fd, struct wc_lrec_t *wc_info)
 			 wc_info->destination);
 	}
 
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
 
 	if (wc_info->opcode == 4 || wc_info->opcode == 6) {
 		/* CT only */
@@ -1542,10 +1544,10 @@ static void wc_tcam_show(FILE *fd, struct wc_lrec_t *wc_info)
 			 wc_info->metadata);
 	}
 
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
 
 	snprintf(tmp1, TFC_STRING_LENGTH_64, "-----Range-+\n");
 	snprintf(tmp2, TFC_STRING_LENGTH_64, "Prof|  Idx |\n");
@@ -1554,10 +1556,10 @@ static void wc_tcam_show(FILE *fd, struct wc_lrec_t *wc_info)
 		 wc_info->range_profile,
 		 wc_info->range_index);
 
-	strcat(line1, tmp1);
-	strcat(line2, tmp2);
-	strcat(line3, tmp3);
-	strcat(line4, tmp4);
+	off1 += tfc_str_append(line1 + off1, TFC_STRING_LENGTH_256 - off1, "%s", tmp1);
+	off2 += tfc_str_append(line2 + off2, TFC_STRING_LENGTH_256 - off2, "%s", tmp2);
+	off3 += tfc_str_append(line3 + off3, TFC_STRING_LENGTH_256 - off3, "%s", tmp3);
+	off4 += tfc_str_append(line4 + off4, TFC_STRING_LENGTH_256 - off4, "%s", tmp4);
 
 	fprintf(fd, "%s%s%s%s",
 		line1,
-- 
2.31.1

