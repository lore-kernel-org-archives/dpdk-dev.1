Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB2606A326
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J605+Nh9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A54A840685;
	Tue, 24 Nov 2026 19:03:33 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 87DAC40684
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:32 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so2750155f8f.1
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543412; x=1796148212; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1Rir++a3+2PRsRXZavcVJ5aufOFcFn0aM0wBFGWNN4=;
 b=J605+Nh9mbJjt3lHMFY79XiSoNHiVYj5xbUa1LeBkEAMPED62MVjybJqO4ApwR3Zah
 7nD+qcRN/yM+h20wVoZZ65NxqAZT8uJVMhBJbhvX74K4SD057DbzwK6X9PcVemEZw6jc
 bAvSlGNfW8bpnltcrcUVoe9wjgo4y9Iko/zHX4odzb0vvZQB5AtGchrNBrEIAOW1nGZX
 NyTl96xIN70Q2y/VSsH02csUCIfeF6TbKnJ/yxbanmAB/NYlWBfYAFEOooMX16odaf1l
 Tuyn9yER1MCXFpYXv7WPZlAhYDq+497nvvwLz2GQSy6uRXZl+N2RgGhZ69WlLQyQw2nK
 fDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543412; x=1796148212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+1Rir++a3+2PRsRXZavcVJ5aufOFcFn0aM0wBFGWNN4=;
 b=JNb/oL6+2assqFnDMmwy/DUFwcK9Qa5XK4ZAnSBHE6x614U9gZsX6K4A4l+NZK/cuI
 zzKsGwyVgKZ4sbTmVdDDOfPlDsV071UKSfQKVw0ww//0nxJ77N0rJYVaNrQ7kwZANjHd
 /4ifOxRNUuTuJpqbG0iesnxtMgIMnONWxfEjwSlEK+2yzwX9HaRrcN6FKp8lkZBRw1OZ
 g9zJYi49y2hgfV0zcElNXSNCjR0WNUpGxqzSD9qGsLd3TxMGKShRvLJ65S9qN9e+95E+
 63CbAms+qr0MlUS+rHS+9rpBtU9V2qA+o4117C+Arsrcqaoi+c/PN0qbPrkd40qxCTRb
 nBXw==
X-Gm-Message-State: APuU4Z93HcPDAnibjF5BdECOQ+b1BcbFOS9w4tN2ka8y9HKoH5JV9yJl
 Rbm1qflB0Di1JGTz1g7oVaUc67mKOpr1O9R1DSt0gyRq3qweUKgGCSLF
X-Gm-Gg: AZFdTZetr7IXHDdP8M2s+NVDz/LLBqEMSpwSVu0vk5NnHheG6Tq4Yknhc7zhrkc+evZ
 PC0HTSe0tCKYtEb/EcYc9tp2ZcnC9RYdVg7NhxsesGWdRMKeFYpi+BJResVVlHT/ugjIYGfRRfy
 rVtJKzz3urnfLxLGwAvcugk2YRHPvepnQh+zFFKneGsfKWu/m3MqvmPtspTnUW5E4MX6qEejLa6
 t/Y1UStu+keBh6ymwIFs4B0sakmyNKIKRb1jcctPESrDO4xAk2Xs9kEPbHnd3gnms7w74T0eYwC
 O++FS4djbeu5b3Yz9wcXbFjolqsM3TqllYhZODua6UGek0SUT/DrilqlBK5i+ReWmbJxoxsahHZ
 MFTijz4BXwRgWjqawuElWfAB0ZzAmjmhWC/dAoTSER6/hcSF//9X+aFuD/Vypy3Pvw1EzJ/8U+W
 Y+eI03FbJBbPMUWGVXfJnTCE0ao/IlCMITLXkSF2MooxA+yDKI+uExRLyUHj6vrMf/98xBi7hXP
 wKVP9GKrdF5Cpkh2r+F3HiWL1ntndvXt/LbllSOOll5v22EKwEwjVH+TwoT0meElSkB+awaC8Bn
 MULVygnFXd6/cTyTdAV0+VHEWgtTDX/uI6+V1X9BpWUF2GLlA25vc2zZmrFV
X-Received: by 2002:a05:6000:2886:b0:4af:9172:3238 with SMTP id
 ffacd0b85a97d-4af917234abmr21879336f8f.43.1795543411906; 
 Tue, 24 Nov 2026 10:03:31 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf680fsm33630500f8f.14.2026.11.24.10.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:31 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 06/13] fib: share tbl8 definitions between fib and fib6
Date: Tue, 24 Nov 2026 19:02:42 +0100
Message-ID: <20261124180249.1099506-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extract common tbl8 definitions shared by dir24_8 and trie backends
into a new fib_tbl8.h header:
  - FIB_TBL8_GRP_NUM_ENT constant (was DIR24_8_TBL8_GRP_NUM_ENT
    and TRIE_TBL8_GRP_NUM_ENT)
  - enum fib_nh_sz with static_asserts against public enums
  - fib_tbl8_write() inline (was write_to_fib and write_to_dp)

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/dir24_8.c  | 84 +++++++++++++++++-----------------------------
 lib/fib/dir24_8.h  |  9 ++---
 lib/fib/fib_tbl8.h | 50 +++++++++++++++++++++++++++
 lib/fib/trie.c     | 80 +++++++++++++++++--------------------------
 lib/fib/trie.h     | 10 ++----
 5 files changed, 118 insertions(+), 115 deletions(-)
 create mode 100644 lib/fib/fib_tbl8.h

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index cf924621a2..7e5f094a3a 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -17,6 +17,11 @@
 #include "dir24_8.h"
 #include "fib_log.h"
 
+static_assert((int)FIB_NH_SZ_1B == (int)RTE_FIB_DIR24_8_1B, "nh_sz 1B mismatch");
+static_assert((int)FIB_NH_SZ_2B == (int)RTE_FIB_DIR24_8_2B, "nh_sz 2B mismatch");
+static_assert((int)FIB_NH_SZ_4B == (int)RTE_FIB_DIR24_8_4B, "nh_sz 4B mismatch");
+static_assert((int)FIB_NH_SZ_8B == (int)RTE_FIB_DIR24_8_8B, "nh_sz 8B mismatch");
+
 #ifdef CC_AVX512_SUPPORT
 
 #include "dir24_8_avx512.h"
@@ -147,35 +152,6 @@ dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr)
 	return NULL;
 }
 
-static void
-write_to_fib(void *ptr, uint64_t val, enum rte_fib_dir24_8_nh_sz size, int n)
-{
-	int i;
-	uint8_t *ptr8 = (uint8_t *)ptr;
-	uint16_t *ptr16 = (uint16_t *)ptr;
-	uint32_t *ptr32 = (uint32_t *)ptr;
-	uint64_t *ptr64 = (uint64_t *)ptr;
-
-	switch (size) {
-	case RTE_FIB_DIR24_8_1B:
-		for (i = 0; i < n; i++)
-			ptr8[i] = (uint8_t)val;
-		break;
-	case RTE_FIB_DIR24_8_2B:
-		for (i = 0; i < n; i++)
-			ptr16[i] = (uint16_t)val;
-		break;
-	case RTE_FIB_DIR24_8_4B:
-		for (i = 0; i < n; i++)
-			ptr32[i] = (uint32_t)val;
-		break;
-	case RTE_FIB_DIR24_8_8B:
-		for (i = 0; i < n; i++)
-			ptr64[i] = (uint64_t)val;
-		break;
-	}
-}
-
 /*
  * Get an index of a free tbl8 from the pool
  */
@@ -215,21 +191,21 @@ tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
 	if (tbl8_idx < 0)
 		return tbl8_idx;
 	tbl8_ptr = (uint8_t *)dp->tbl8 +
-		((tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT) <<
+		((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) <<
 		dp->nh_sz);
 	/*Init tbl8 entries with nexthop from tbl24*/
-	write_to_fib((void *)tbl8_ptr, nh|
+	fib_tbl8_write((void *)tbl8_ptr, nh|
 		DIR24_8_EXT_ENT, dp->nh_sz,
-		DIR24_8_TBL8_GRP_NUM_ENT);
+		FIB_TBL8_GRP_NUM_ENT);
 	return tbl8_idx;
 }
 
 static void
 tbl8_cleanup_and_free(struct dir24_8_tbl *dp, uint64_t tbl8_idx)
 {
-	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
 
-	memset(ptr, 0, DIR24_8_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	memset(ptr, 0, FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
 	tbl8_put(dp, tbl8_idx);
 }
 
@@ -255,9 +231,9 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 	switch (dp->nh_sz) {
 	case RTE_FIB_DIR24_8_1B:
 		ptr8 = &((uint8_t *)dp->tbl8)[tbl8_idx *
-				DIR24_8_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr8;
-		for (i = 1; i < DIR24_8_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr8[i])
 				return;
 		}
@@ -266,9 +242,9 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 		break;
 	case RTE_FIB_DIR24_8_2B:
 		ptr16 = &((uint16_t *)dp->tbl8)[tbl8_idx *
-				DIR24_8_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr16;
-		for (i = 1; i < DIR24_8_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr16[i])
 				return;
 		}
@@ -277,9 +253,9 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 		break;
 	case RTE_FIB_DIR24_8_4B:
 		ptr32 = &((uint32_t *)dp->tbl8)[tbl8_idx *
-				DIR24_8_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr32;
-		for (i = 1; i < DIR24_8_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr32[i])
 				return;
 		}
@@ -288,9 +264,9 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 		break;
 	case RTE_FIB_DIR24_8_8B:
 		ptr64 = &((uint64_t *)dp->tbl8)[tbl8_idx *
-				DIR24_8_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr64;
-		for (i = 1; i < DIR24_8_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr64[i])
 				return;
 		}
@@ -343,23 +319,23 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 				}
 				tbl8_put(dp, tmp_tbl8_idx);
 				/*update dir24 entry with tbl8 index*/
-				write_to_fib(get_tbl24_p(dp, ledge,
+				fib_tbl8_write(get_tbl24_p(dp, ledge,
 					dp->nh_sz), (tbl8_idx << 1)|
 					DIR24_8_EXT_ENT,
 					dp->nh_sz, 1);
 			} else
 				tbl8_idx = tbl24_tmp >> 1;
 			tbl8_ptr = (uint8_t *)dp->tbl8 +
-				(((tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT) +
+				(((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) +
 				(ledge & ~DIR24_8_TBL24_MASK)) <<
 				dp->nh_sz);
 			/*update tbl8 with new next hop*/
-			write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
+			fib_tbl8_write((void *)tbl8_ptr, (next_hop << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, ROUNDUP(ledge, 24) - ledge);
 			tbl8_recycle(dp, ledge, tbl8_idx);
 		}
-		write_to_fib(get_tbl24_p(dp, ROUNDUP(ledge, 24), dp->nh_sz),
+		fib_tbl8_write(get_tbl24_p(dp, ROUNDUP(ledge, 24), dp->nh_sz),
 			next_hop << 1, dp->nh_sz, len);
 		if (redge & ~DIR24_8_TBL24_MASK) {
 			tbl24_tmp = get_tbl24(dp, redge, dp->nh_sz);
@@ -369,17 +345,17 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 				if (tbl8_idx < 0)
 					return -ENOSPC;
 				/*update dir24 entry with tbl8 index*/
-				write_to_fib(get_tbl24_p(dp, redge,
+				fib_tbl8_write(get_tbl24_p(dp, redge,
 					dp->nh_sz), (tbl8_idx << 1)|
 					DIR24_8_EXT_ENT,
 					dp->nh_sz, 1);
 			} else
 				tbl8_idx = tbl24_tmp >> 1;
 			tbl8_ptr = (uint8_t *)dp->tbl8 +
-				((tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT) <<
+				((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) <<
 				dp->nh_sz);
 			/*update tbl8 with new next hop*/
-			write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
+			fib_tbl8_write((void *)tbl8_ptr, (next_hop << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, redge & ~DIR24_8_TBL24_MASK);
 			tbl8_recycle(dp, redge, tbl8_idx);
@@ -392,18 +368,18 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 			if (tbl8_idx < 0)
 				return -ENOSPC;
 			/*update dir24 entry with tbl8 index*/
-			write_to_fib(get_tbl24_p(dp, ledge, dp->nh_sz),
+			fib_tbl8_write(get_tbl24_p(dp, ledge, dp->nh_sz),
 				(tbl8_idx << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, 1);
 		} else
 			tbl8_idx = tbl24_tmp >> 1;
 		tbl8_ptr = (uint8_t *)dp->tbl8 +
-			(((tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT) +
+			(((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) +
 			(ledge & ~DIR24_8_TBL24_MASK)) <<
 			dp->nh_sz);
 		/*update tbl8 with new next hop*/
-		write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
+		fib_tbl8_write((void *)tbl8_ptr, (next_hop << 1)|
 			DIR24_8_EXT_ENT,
 			dp->nh_sz, redge - ledge);
 		tbl8_recycle(dp, ledge, tbl8_idx);
@@ -595,7 +571,7 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	}
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
-	tbl8_sz = DIR24_8_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
+	tbl8_sz = FIB_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
 			(num_tbl8 + 1);
 	dp->tbl8 = rte_zmalloc_socket(mem_name, tbl8_sz,
 			RTE_CACHE_LINE_SIZE, socket_id);
@@ -625,7 +601,7 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	dp->tbl8_pool_pos = 0;
 
 	/* Init table with default value */
-	write_to_fib(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
+	fib_tbl8_write(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
 
 	return dp;
 }
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index 8e74fd4a62..e75bd120ad 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -14,13 +14,14 @@
 #include <rte_branch_prediction.h>
 #include <rte_rcu_qsbr.h>
 
+#include "fib_tbl8.h"
+
 /**
  * @file
  * DIR24_8 algorithm
  */
 
 #define DIR24_8_TBL24_NUM_ENT		(1 << 24)
-#define DIR24_8_TBL8_GRP_NUM_ENT	256U
 #define DIR24_8_EXT_ENT			1
 #define DIR24_8_TBL24_MASK		0xffffff00
 
@@ -68,7 +69,7 @@ get_tbl24_idx(uint32_t ip)
 static  inline uint32_t
 get_tbl8_idx(uint32_t res, uint32_t ip)
 {
-	return (res >> 1) * DIR24_8_TBL8_GRP_NUM_ENT + (uint8_t)ip;
+	return (res >> 1) * FIB_TBL8_GRP_NUM_ENT + (uint8_t)ip;
 }
 
 static inline uint64_t
@@ -129,14 +130,14 @@ static inline void dir24_8_lookup_bulk_##suffix(void *p, const uint32_t *ips, \
 		tmp = ((type *)dp->tbl24)[ips[i] >> 8];			\
 		if (unlikely(is_entry_extended(tmp)))			\
 			tmp = ((type *)dp->tbl8)[(uint8_t)ips[i] +	\
-				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)]; \
+				((tmp >> 1) * FIB_TBL8_GRP_NUM_ENT)]; \
 		next_hops[i] = tmp >> 1;				\
 	}								\
 	for (; i < n; i++) {						\
 		tmp = ((type *)dp->tbl24)[ips[i] >> 8];			\
 		if (unlikely(is_entry_extended(tmp)))			\
 			tmp = ((type *)dp->tbl8)[(uint8_t)ips[i] +	\
-				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)]; \
+				((tmp >> 1) * FIB_TBL8_GRP_NUM_ENT)]; \
 		next_hops[i] = tmp >> 1;				\
 	}								\
 }									\
diff --git a/lib/fib/fib_tbl8.h b/lib/fib/fib_tbl8.h
new file mode 100644
index 0000000000..1552f2cab0
--- /dev/null
+++ b/lib/fib/fib_tbl8.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Maxime Leroy, Free Mobile
+ */
+
+#ifndef _FIB_TBL8_H_
+#define _FIB_TBL8_H_
+
+/**
+ * @file
+ * Common tbl8 definitions shared by dir24_8 and trie backends.
+ */
+
+#include <stdint.h>
+
+#define FIB_TBL8_GRP_NUM_ENT	256ULL
+
+/** Nexthop size (log2 of byte width) */
+enum fib_nh_sz {
+	FIB_NH_SZ_1B = 0,
+	FIB_NH_SZ_2B = 1,
+	FIB_NH_SZ_4B = 2,
+	FIB_NH_SZ_8B = 3,
+};
+
+static inline void
+fib_tbl8_write(void *ptr, uint64_t val, uint8_t nh_sz, int n)
+{
+	int i;
+
+	switch (nh_sz) {
+	case FIB_NH_SZ_1B:
+		for (i = 0; i < n; i++)
+			((uint8_t *)ptr)[i] = (uint8_t)val;
+		break;
+	case FIB_NH_SZ_2B:
+		for (i = 0; i < n; i++)
+			((uint16_t *)ptr)[i] = (uint16_t)val;
+		break;
+	case FIB_NH_SZ_4B:
+		for (i = 0; i < n; i++)
+			((uint32_t *)ptr)[i] = (uint32_t)val;
+		break;
+	case FIB_NH_SZ_8B:
+		for (i = 0; i < n; i++)
+			((uint64_t *)ptr)[i] = (uint64_t)val;
+		break;
+	}
+}
+
+#endif /* _FIB_TBL8_H_ */
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 871bb923ab..22a6e2e863 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -17,6 +17,10 @@
 #include "fib_log.h"
 #include "trie.h"
 
+static_assert((int)FIB_NH_SZ_2B == (int)RTE_FIB6_TRIE_2B, "nh_sz 2B mismatch");
+static_assert((int)FIB_NH_SZ_4B == (int)RTE_FIB6_TRIE_4B, "nh_sz 4B mismatch");
+static_assert((int)FIB_NH_SZ_8B == (int)RTE_FIB6_TRIE_8B, "nh_sz 8B mismatch");
+
 #ifdef CC_AVX512_SUPPORT
 
 #include "trie_avx512.h"
@@ -96,30 +100,6 @@ trie_get_lookup_fn(void *p, enum rte_fib6_lookup_type type)
 	return NULL;
 }
 
-static void
-write_to_dp(void *ptr, uint64_t val, enum rte_fib_trie_nh_sz size, int n)
-{
-	int i;
-	uint16_t *ptr16 = (uint16_t *)ptr;
-	uint32_t *ptr32 = (uint32_t *)ptr;
-	uint64_t *ptr64 = (uint64_t *)ptr;
-
-	switch (size) {
-	case RTE_FIB6_TRIE_2B:
-		for (i = 0; i < n; i++)
-			ptr16[i] = (uint16_t)val;
-		break;
-	case RTE_FIB6_TRIE_4B:
-		for (i = 0; i < n; i++)
-			ptr32[i] = (uint32_t)val;
-		break;
-	case RTE_FIB6_TRIE_8B:
-		for (i = 0; i < n; i++)
-			ptr64[i] = (uint64_t)val;
-		break;
-	}
-}
-
 static void
 tbl8_pool_init(struct rte_trie_tbl *dp)
 {
@@ -171,10 +151,10 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 	if (tbl8_idx < 0)
 		return tbl8_idx;
 	tbl8_ptr = get_tbl_p_by_idx(dp->tbl8,
-		tbl8_idx * TRIE_TBL8_GRP_NUM_ENT, dp->nh_sz);
+		tbl8_idx * FIB_TBL8_GRP_NUM_ENT, dp->nh_sz);
 	/*Init tbl8 entries with nexthop from tbl24*/
-	write_to_dp((void *)tbl8_ptr, nh, dp->nh_sz,
-		TRIE_TBL8_GRP_NUM_ENT);
+	fib_tbl8_write((void *)tbl8_ptr, nh, dp->nh_sz,
+		FIB_TBL8_GRP_NUM_ENT);
 	dp->cur_tbl8s++;
 	return tbl8_idx;
 }
@@ -182,9 +162,9 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 static void
 tbl8_cleanup_and_free(struct rte_trie_tbl *dp, uint64_t tbl8_idx)
 {
-	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * TRIE_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
 
-	memset(ptr, 0, TRIE_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	memset(ptr, 0, FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
 	tbl8_put(dp, tbl8_idx);
 }
 
@@ -208,39 +188,39 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 	switch (dp->nh_sz) {
 	case RTE_FIB6_TRIE_2B:
 		ptr16 = &((uint16_t *)dp->tbl8)[tbl8_idx *
-				TRIE_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr16;
 		if (nh & TRIE_EXT_ENT)
 			return;
-		for (i = 1; i < TRIE_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr16[i])
 				return;
 		}
-		write_to_dp(par, nh, dp->nh_sz, 1);
+		fib_tbl8_write(par, nh, dp->nh_sz, 1);
 		break;
 	case RTE_FIB6_TRIE_4B:
 		ptr32 = &((uint32_t *)dp->tbl8)[tbl8_idx *
-				TRIE_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr32;
 		if (nh & TRIE_EXT_ENT)
 			return;
-		for (i = 1; i < TRIE_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr32[i])
 				return;
 		}
-		write_to_dp(par, nh, dp->nh_sz, 1);
+		fib_tbl8_write(par, nh, dp->nh_sz, 1);
 		break;
 	case RTE_FIB6_TRIE_8B:
 		ptr64 = &((uint64_t *)dp->tbl8)[tbl8_idx *
-				TRIE_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr64;
 		if (nh & TRIE_EXT_ENT)
 			return;
-		for (i = 1; i < TRIE_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr64[i])
 				return;
 		}
-		write_to_dp(par, nh, dp->nh_sz, 1);
+		fib_tbl8_write(par, nh, dp->nh_sz, 1);
 		break;
 	}
 
@@ -268,7 +248,7 @@ get_idx(const struct rte_ipv6_addr *ip, uint64_t prev_idx, int bytes, int first_
 		bitshift = (int8_t)(((first_byte + bytes - 1) - i)*BYTE_SIZE);
 		idx |= ip->a[i] <<  bitshift;
 	}
-	return (prev_idx * TRIE_TBL8_GRP_NUM_ENT) + idx;
+	return (prev_idx * FIB_TBL8_GRP_NUM_ENT) + idx;
 }
 
 static inline uint64_t
@@ -306,7 +286,7 @@ recycle_root_path(struct rte_trie_tbl *dp, const uint8_t *ip_part,
 
 	if (common_tbl8 != 0) {
 		p = get_tbl_p_by_idx(dp->tbl8, (val >> 1) *
-			TRIE_TBL8_GRP_NUM_ENT + *ip_part, dp->nh_sz);
+			FIB_TBL8_GRP_NUM_ENT + *ip_part, dp->nh_sz);
 		recycle_root_path(dp, ip_part + 1, common_tbl8 - 1, p);
 	}
 	tbl8_recycle(dp, prev, val >> 1);
@@ -331,7 +311,7 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
 			tbl8_idx = tbl8_alloc(dp, val);
 			if (unlikely(tbl8_idx < 0))
 				return tbl8_idx;
-			write_to_dp(tbl_ptr, ((uint64_t)tbl8_idx << 1) |
+			fib_tbl8_write(tbl_ptr, ((uint64_t)tbl8_idx << 1) |
 				TRIE_EXT_ENT, dp->nh_sz, 1);
 			prev_idx = (uint64_t)tbl8_idx;
 		} else
@@ -340,7 +320,7 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
 		j = i;
 		cur_tbl = dp->tbl8;
 	}
-	*tbl = get_tbl_p_by_idx(cur_tbl, prev_idx * TRIE_TBL8_GRP_NUM_ENT,
+	*tbl = get_tbl_p_by_idx(cur_tbl, prev_idx * FIB_TBL8_GRP_NUM_ENT,
 		dp->nh_sz);
 	return 0;
 }
@@ -365,22 +345,22 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
 			val = ((uint64_t)tbl8_idx << 1) | TRIE_EXT_ENT;
 		}
 		p = get_tbl_p_by_idx(dp->tbl8, (tbl8_idx *
-			TRIE_TBL8_GRP_NUM_ENT) + *ip_part, dp->nh_sz);
+			FIB_TBL8_GRP_NUM_ENT) + *ip_part, dp->nh_sz);
 		ret = write_edge(dp, ip_part + 1, next_hop, len - 1, edge, p);
 		if (ret < 0)
 			return ret;
 		if (edge == LEDGE) {
-			write_to_dp(RTE_PTR_ADD(p, (uintptr_t)(1) << dp->nh_sz),
+			fib_tbl8_write(RTE_PTR_ADD(p, (uintptr_t)(1) << dp->nh_sz),
 				next_hop << 1, dp->nh_sz, UINT8_MAX - *ip_part);
 		} else {
-			write_to_dp(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
-				TRIE_TBL8_GRP_NUM_ENT, dp->nh_sz),
+			fib_tbl8_write(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
+				FIB_TBL8_GRP_NUM_ENT, dp->nh_sz),
 				next_hop << 1, dp->nh_sz, *ip_part);
 		}
 		tbl8_recycle(dp, &val, tbl8_idx);
 	}
 
-	write_to_dp(ent, val, dp->nh_sz, 1);
+	fib_tbl8_write(ent, val, dp->nh_sz, 1);
 	return ret;
 }
 
@@ -461,7 +441,7 @@ install_to_dp(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ledge,
 	if (right_idx > left_idx + 1) {
 		ent = get_tbl_p_by_idx(common_root_tbl, left_idx + 1,
 			dp->nh_sz);
-		write_to_dp(ent, next_hop << 1, dp->nh_sz,
+		fib_tbl8_write(ent, next_hop << 1, dp->nh_sz,
 			right_idx - (left_idx + 1));
 	}
 	ent = get_tbl_p_by_idx(common_root_tbl, right_idx, dp->nh_sz);
@@ -725,10 +705,10 @@ trie_create(const char *name, int socket_id,
 		return dp;
 	}
 
-	write_to_dp(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
+	fib_tbl8_write(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
-	dp->tbl8 = rte_zmalloc_socket(mem_name, TRIE_TBL8_GRP_NUM_ENT *
+	dp->tbl8 = rte_zmalloc_socket(mem_name, FIB_TBL8_GRP_NUM_ENT *
 			(1ll << nh_sz) * (num_tbl8 + 1),
 			RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp->tbl8 == NULL) {
diff --git a/lib/fib/trie.h b/lib/fib/trie.h
index e0f53e0c47..bea74f1bb6 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -11,6 +11,8 @@
 #include <rte_common.h>
 #include <rte_fib6.h>
 
+#include "fib_tbl8.h"
+
 /**
  * @file
  * RTE IPv6 Longest Prefix Match (LPM)
@@ -18,17 +20,11 @@
 
 /* @internal Total number of tbl24 entries. */
 #define TRIE_TBL24_NUM_ENT	(1 << 24)
-/* @internal Number of entries in a tbl8 group. */
-#define TRIE_TBL8_GRP_NUM_ENT	256ULL
 /* @internal Total number of tbl8 groups in the tbl8. */
 #define TRIE_TBL8_NUM_GROUPS	65536
 /* @internal bitmask with valid and valid_group fields set */
 #define TRIE_EXT_ENT		1
 
-#define BITMAP_SLAB_BIT_SIZE_LOG2	6
-#define BITMAP_SLAB_BIT_SIZE		(1ULL << BITMAP_SLAB_BIT_SIZE_LOG2)
-#define BITMAP_SLAB_BITMASK		(BITMAP_SLAB_BIT_SIZE - 1)
-
 struct rte_trie_tbl {
 	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
@@ -124,7 +120,7 @@ static inline void rte_trie_lookup_bulk_##suffix(void *p,		\
 		j = 3;							\
 		while (is_entry_extended(tmp)) {			\
 			tmp = ((type *)dp->tbl8)[ips[i].a[j++] +	\
-				((tmp >> 1) * TRIE_TBL8_GRP_NUM_ENT)];	\
+				((tmp >> 1) * FIB_TBL8_GRP_NUM_ENT)];	\
 		}							\
 		next_hops[i] = tmp >> 1;				\
 	}								\
-- 
2.43.0

