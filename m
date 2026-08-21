Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554FBC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFBAE4067D;
	Fri, 21 Aug 2026 21:28:35 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 180D040A7D
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:34 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so897690a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340513;
 x=1787945313; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ip2PmL00dYSq90gi1ZElmDKMePxK8tzN0IGHAOJpCx4=;
 b=QmOU+GSCOxt8zHQDcSlb0W863re7+9LLSfRVuFU4KifYJVBosYJVu2EZcwBNj1x+y2
 t8skGjVuY/a4+r5o5QNP59/OwKa79lHb/dFmbcYy8JI+w8x4NC4clNeq9dj/KKDOmt8R
 e0UKcLi6n/7NgE7xtxk+OCyrjEFFKUgsRTSv2k1Jxthfy6bzJ8tfX4GFZU4foaD4vPCG
 b0PLx3VfgyZvNe+mCZZDU23wg301EaKTf6Siv4C9p261ySZbIjYUea5UV9A2FeFO9/Yu
 ZnZFCOFs+8RbpQ2QC217QCDs++9HNlyIxBOJiSUPJAx/WlWFuOsVGtTFDfyLcF/Z94i3
 kSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340513; x=1787945313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ip2PmL00dYSq90gi1ZElmDKMePxK8tzN0IGHAOJpCx4=;
 b=DCrgl3aVRIvXssrxM2/iH4DHhbBDOw1pGycyxa2SWShSE8y86aXQaZRj31nOBeuK4C
 DCEAbosYw5x7+UFm+ZUOX33mvg8JrNPzs4IJaJd3BsOaUzbYDgDzqA63XK25UgO7Ige9
 /fKzKmnrIWU1xH4blgELFmM/ow8VYf1JXqB+xY1LzZBfsfcpHsELPGIv+whYgY80glOF
 wNOae9uKcGP2a4ZxXzPiLa/ogZapMQoT/T39lpbRZRQ8ax3bbySSmvkOxLzLgTvE/X/F
 V96wsSTJCjmQ4PK56XgDOshj6/r4lGXjRdv8GR7F0mlWNTLXO0JO6bCmXTgMO0G3eJvP
 o0mQ==
X-Gm-Message-State: AFuF++l5VJr6I76iWI0fpogHNaz9cuYi5gXwVJpvZQIl7FPsiG0HS3ux
 jVsaeSKD4c2ca4VmC/fZXNMjYxqrvK65eBGgpW8R+0sWcS5V4aL/dCWp4KgbkCL3o7uqtPGP+AX
 z1XqSt88=
X-Gm-Gg: AR+sD13qVbX3TLsW0dM6hsMFMOTNQ2u31pZ2z3It468dfTH7VfryIkZOsZ1xlLGVoRM
 sdwGDLm4ni+MFbU4Ijwx2mVm144ahruU+PJDrhk7N3Ia1rdKh+c3MyS6mXCGmSBhHy8vfXxJ305
 VECGJ7xRIgkWb3hKbiWzOcg7wsoipQg52AUXyGsn6n+1Ns7U8yE8YwVkh2yaJcwB4z3icrZTTeL
 opdLF+fANlYvru5p4SwvYeEU0G/nowW7957hWuPLeJtHRc0JDclc3GWmQ9Eswy+n+BZe9axDOul
 xbflllTcRsSTE/xJNpesd2kGuRomtK0Sh55QRRgzklLJmccaWlED2FAx0ra4iBGIrte+ZfRUHkZ
 ORMYmxNBizW5gHIl7FrlJKSkGqWEjqaeiQoJBGKTvOE22B5a10RqmTybUdXli2cC7Nqnq15iPAv
 9qXyUnz7wfJ8Kf7ZwhizgwnY22fwwuRlnlppAIGeiTX+m4MQDvhkB6lQZpX/yoCGjWzCi3n9TC1
 El+/mlwx/2Q1nyKTiAHG0eLFVYtrEjOumlyww==
X-Received: by 2002:a05:6a21:a96:b0:3c3:954d:278d with SMTP id
 adf61e73a8af0-3cd3009cf0emr18075808637.9.1787340513089; 
 Fri, 21 Aug 2026 12:28:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Anoob Joseph <anoobj@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 10/68] test: use memcpy instead of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:05 -0700
Message-ID: <20260821192646.146382-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

If size is constant, better to use C library memcpy
which has more coverage from ASAN and static analysis tools.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/commands.c                     |  1 -
 app/test/packet_burst_generator.c       | 10 +++---
 app/test/test_bpf.c                     |  1 +
 app/test/test_crc.c                     |  7 ++---
 app/test/test_cryptodev.c               | 14 ++++-----
 app/test/test_cryptodev.h               |  1 +
 app/test/test_cryptodev_asym.c          |  1 -
 app/test/test_cryptodev_security_pdcp.c |  1 -
 app/test/test_efd.c                     |  1 -
 app/test/test_efd_perf.c                |  1 -
 app/test/test_event_crypto_adapter.c    | 12 +++----
 app/test/test_eventdev.c                |  1 -
 app/test/test_link_bonding_mode4.c      |  8 ++---
 app/test/test_mbuf.c                    |  1 -
 app/test/test_member.c                  |  1 -
 app/test/test_member_perf.c             |  1 -
 app/test/test_rawdev.c                  |  1 -
 app/test/test_ring.h                    | 17 +++++-----
 app/test/test_security_inline_macsec.c  |  2 +-
 app/test/test_security_inline_proto.c   | 42 ++++++++++++-------------
 app/test/test_security_proto.c          |  2 +-
 app/test/test_service_cores.c           |  1 -
 app/test/test_thash.c                   |  4 +--
 app/test/virtual_pmd.c                  |  5 +--
 24 files changed, 62 insertions(+), 74 deletions(-)

diff --git a/app/test/commands.c b/app/test/commands.c
index 497d8e9952..74494a0ef4 100644
--- a/app/test/commands.c
+++ b/app/test/commands.c
@@ -16,7 +16,6 @@
 #include <rte_log.h>
 #include <rte_debug.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_memzone.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/app/test/packet_burst_generator.c b/app/test/packet_burst_generator.c
index 4c17737739..2f1d75c5bc 100644
--- a/app/test/packet_burst_generator.c
+++ b/app/test/packet_burst_generator.c
@@ -31,20 +31,20 @@ copy_buf_to_pkt_segs(void *buf, unsigned len, struct rte_mbuf *pkt,
 	copy_len = seg->data_len - offset;
 	seg_buf = rte_pktmbuf_mtod_offset(seg, char *, offset);
 	while (len > copy_len) {
-		rte_memcpy(seg_buf, buf, (size_t) copy_len);
+		memcpy(seg_buf, buf, (size_t) copy_len);
 		len -= copy_len;
 		buf = ((char *) buf + copy_len);
 		seg = seg->next;
 		seg_buf = rte_pktmbuf_mtod(seg, void *);
 	}
-	rte_memcpy(seg_buf, buf, (size_t) len);
+	memcpy(seg_buf, buf, (size_t) len);
 }
 
 static inline void
 copy_buf_to_pkt(void *buf, unsigned len, struct rte_mbuf *pkt, unsigned offset)
 {
 	if (offset + len <= pkt->data_len) {
-		rte_memcpy(rte_pktmbuf_mtod_offset(pkt, char *, offset), buf,
+		memcpy(rte_pktmbuf_mtod_offset(pkt, char *, offset), buf,
 			   (size_t) len);
 		return;
 	}
@@ -148,8 +148,8 @@ initialize_ipv6_header(struct rte_ipv6_hdr *ip_hdr, uint8_t *src_addr,
 	ip_hdr->proto = IPPROTO_UDP;
 	ip_hdr->hop_limits = IP_DEFTTL;
 
-	rte_memcpy(&ip_hdr->src_addr, src_addr, sizeof(ip_hdr->src_addr));
-	rte_memcpy(&ip_hdr->dst_addr, dst_addr, sizeof(ip_hdr->dst_addr));
+	memcpy(&ip_hdr->src_addr, src_addr, sizeof(ip_hdr->src_addr));
+	memcpy(&ip_hdr->dst_addr, dst_addr, sizeof(ip_hdr->dst_addr));
 
 	return (uint16_t) (pkt_data_len + sizeof(struct rte_ipv6_hdr));
 }
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3205afaa63..bb5dc3015a 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -12,6 +12,7 @@
 #include <rte_debug.h>
 #include <rte_hexdump.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_random.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
diff --git a/app/test/test_crc.c b/app/test/test_crc.c
index 11645d323d..3494b88120 100644
--- a/app/test/test_crc.c
+++ b/app/test/test_crc.c
@@ -6,7 +6,6 @@
 
 #include <rte_hexdump.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_net_crc.h>
 
 #define CRC_VEC_LEN        32
@@ -116,14 +115,14 @@ crc_autotest(void)
 	if (test_data == NULL)
 		return -7;
 	for (i = 0; i < CRC32_VEC_LEN1; i += 12)
-		rte_memcpy(&test_data[i], crc32_vec1, 12);
+		memcpy(&test_data[i], crc32_vec1, 12);
 	ret |= crc_all_algs("32-bit ethernet CRC: Test 2", RTE_NET_CRC32_ETH, test_data,
 		CRC32_VEC_LEN1, crc32_vec1_res);
 
 	/* 32-bit ethernet CRC: Test 3 */
 	memset(test_data, 0, CRC32_VEC_LEN1);
 	for (i = 0; i < CRC32_VEC_LEN2; i += 12)
-		rte_memcpy(&test_data[i], crc32_vec1, 12);
+		memcpy(&test_data[i], crc32_vec1, 12);
 	ret |= crc_all_algs("32-bit ethernet CRC: Test 3", RTE_NET_CRC32_ETH, test_data,
 		CRC32_VEC_LEN2, crc32_vec2_res);
 
@@ -142,7 +141,7 @@ crc_autotest(void)
 	/* 16-bit CCITT CRC:  Test 7 */
 	memset(test_data, 0, CRC32_VEC_LEN1);
 	for (i = 0; i < CRC16_VEC_LEN3; i += 12)
-		rte_memcpy(&test_data[i], crc16_vec1, 12);
+		memcpy(&test_data[i], crc16_vec1, 12);
 	ret |= crc_all_algs("16-bit CCITT CRC: Test 7", RTE_NET_CRC16_CCITT, test_data,
 		CRC16_VEC_LEN3, crc16_vec3_res);
 	return ret;
diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index fd02107baf..ec1616aacc 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -2711,8 +2711,8 @@ test_AES_CBC_HMAC_SHA1_encrypt_digest(void)
 	sym_op->auth.data.length = QUOTE_512_BYTES;
 
 	/* Copy IV at the end of the crypto operation */
-	rte_memcpy(rte_crypto_op_ctod_offset(ut_params->op, uint8_t *, IV_OFFSET),
-			aes_cbc_iv, CIPHER_IV_LENGTH_AES_CBC);
+	memcpy(rte_crypto_op_ctod_offset(ut_params->op, uint8_t *, IV_OFFSET),
+	       aes_cbc_iv, CIPHER_IV_LENGTH_AES_CBC);
 
 	/* Set crypto operation cipher parameters */
 	sym_op->cipher.data.offset = 0;
@@ -2846,9 +2846,7 @@ test_AES_CBC_HMAC_SHA512_decrypt_perform(void *sess,
 			DIGEST_BYTE_LENGTH_SHA512);
 	TEST_ASSERT_NOT_NULL(ut_params->digest, "no room to append digest");
 
-	rte_memcpy(ut_params->digest,
-			digest,
-			DIGEST_BYTE_LENGTH_SHA512);
+	memcpy(ut_params->digest, digest, DIGEST_BYTE_LENGTH_SHA512);
 
 	/* Generate Crypto op data structure */
 	ut_params->op = rte_crypto_op_alloc(ts_params->op_mpool,
@@ -2871,8 +2869,8 @@ test_AES_CBC_HMAC_SHA512_decrypt_perform(void *sess,
 	sym_op->auth.data.length = QUOTE_512_BYTES;
 
 	/* Copy IV at the end of the crypto operation */
-	rte_memcpy(rte_crypto_op_ctod_offset(ut_params->op, uint8_t *, IV_OFFSET),
-			iv, CIPHER_IV_LENGTH_AES_CBC);
+	memcpy(rte_crypto_op_ctod_offset(ut_params->op, uint8_t *, IV_OFFSET),
+	       iv, CIPHER_IV_LENGTH_AES_CBC);
 
 	sym_op->cipher.data.offset = 0;
 	sym_op->cipher.data.length = QUOTE_512_BYTES;
@@ -9238,7 +9236,7 @@ create_aead_operation(enum rte_crypto_aead_operation op,
 				uint8_t *, IV_OFFSET);
 
 		if (tdata->iv.len == 0) {
-			rte_memcpy(iv_ptr, tdata->iv.data, AES_GCM_J0_LENGTH);
+			memcpy(iv_ptr, tdata->iv.data, AES_GCM_J0_LENGTH);
 			debug_hexdump(stdout, "iv:", iv_ptr,
 				AES_GCM_J0_LENGTH);
 		} else {
diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index d125dea958..bdf2ed35ef 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -5,6 +5,7 @@
 #define TEST_CRYPTODEV_H_
 
 #include <rte_cryptodev.h>
+#include <rte_memcpy.h>
 #include <rte_security.h>
 
 #define MAX_NUM_OPS_INFLIGHT            (4096)
diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 7b8afe5f92..657cdc424c 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -8,7 +8,6 @@
 #include <rte_hexdump.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_pause.h>
 
 #include <rte_cryptodev.h>
diff --git a/app/test/test_cryptodev_security_pdcp.c b/app/test/test_cryptodev_security_pdcp.c
index a7641bab7a..39926cbee3 100644
--- a/app/test/test_cryptodev_security_pdcp.c
+++ b/app/test/test_cryptodev_security_pdcp.c
@@ -10,7 +10,6 @@
 #include <rte_hexdump.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_pause.h>
 #include <rte_bus_vdev.h>
 #include <rte_byteorder.h>
diff --git a/app/test/test_efd.c b/app/test/test_efd.c
index 4a4379c563..5f64f6c650 100644
--- a/app/test/test_efd.c
+++ b/app/test/test_efd.c
@@ -13,7 +13,6 @@ test_efd(void)
 
 #else
 
-#include <rte_memcpy.h>
 #include <rte_malloc.h>
 #include <rte_efd.h>
 #include <rte_byteorder.h>
diff --git a/app/test/test_efd_perf.c b/app/test/test_efd_perf.c
index b212e96767..7f5a8b9a56 100644
--- a/app/test/test_efd_perf.c
+++ b/app/test/test_efd_perf.c
@@ -22,7 +22,6 @@ test_efd_perf(void)
 #include <rte_malloc.h>
 #include <rte_random.h>
 #include <rte_efd.h>
-#include <rte_memcpy.h>
 #include <rte_thash.h>
 
 #define NUM_KEYSIZES 10
diff --git a/app/test/test_event_crypto_adapter.c b/app/test/test_event_crypto_adapter.c
index d1674a5ba1..faddde0828 100644
--- a/app/test/test_event_crypto_adapter.c
+++ b/app/test/test_event_crypto_adapter.c
@@ -455,7 +455,7 @@ test_op_forward_mode(uint8_t session_less)
 		m_data.request_info.cdev_id = request_info.cdev_id;
 		m_data.request_info.queue_pair_id = request_info.queue_pair_id;
 		m_data.response_info.event = response_info.event;
-		rte_memcpy((uint8_t *)op + len, &m_data, sizeof(m_data));
+		memcpy((uint8_t *)op + len, &m_data, sizeof(m_data));
 	}
 
 	sym_op->m_src = m;
@@ -654,8 +654,8 @@ test_asym_op_forward_mode(uint8_t session_less)
 		m_data.request_info.cdev_id = request_info.cdev_id;
 		m_data.request_info.queue_pair_id = request_info.queue_pair_id;
 		m_data.response_info.event = response_info.event;
-		rte_memcpy((uint8_t *)op + op->private_data_offset,
-				&m_data, sizeof(m_data));
+		memcpy((uint8_t *)op + op->private_data_offset, &m_data,
+		       sizeof(m_data));
 	}
 	/* Fill in event info and update event_ptr with rte_crypto_op */
 	memset(&ev, 0, sizeof(ev));
@@ -821,7 +821,7 @@ test_op_new_mode(uint8_t session_less)
 		op->private_data_offset = len;
 		/* Fill in private data information */
 		m_data.response_info.event = response_info.event;
-		rte_memcpy((uint8_t *)op + len, &m_data, sizeof(m_data));
+		memcpy((uint8_t *)op + len, &m_data, sizeof(m_data));
 	}
 
 	sym_op->m_src = m;
@@ -978,8 +978,8 @@ test_asym_op_new_mode(uint8_t session_less)
 				sizeof(struct rte_crypto_asym_xform));
 		/* Fill in private data information */
 		m_data.response_info.event = response_info.event;
-		rte_memcpy((uint8_t *)op + op->private_data_offset,
-				&m_data, sizeof(m_data));
+		memcpy((uint8_t *)op + op->private_data_offset, &m_data,
+		       sizeof(m_data));
 	}
 
 	ret = send_op_recv_ev(op);
diff --git a/app/test/test_eventdev.c b/app/test/test_eventdev.c
index 1241da38cb..ab16b6fda9 100644
--- a/app/test/test_eventdev.c
+++ b/app/test/test_eventdev.c
@@ -8,7 +8,6 @@
 #include <rte_hexdump.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 
 #ifdef RTE_EXEC_ENV_WINDOWS
 static int
diff --git a/app/test/test_link_bonding_mode4.c b/app/test/test_link_bonding_mode4.c
index ff13dbed93..e4827c1e80 100644
--- a/app/test/test_link_bonding_mode4.c
+++ b/app/test/test_link_bonding_mode4.c
@@ -1399,8 +1399,8 @@ test_mode4_ext_ctrl(void)
 
 	for (i = 0; i < MEMBER_COUNT; i++) {
 		lacp_tx_buf[i] = rte_pktmbuf_alloc(test_params.mbuf_pool);
-		rte_memcpy(rte_pktmbuf_mtod(lacp_tx_buf[i], char *),
-			   &lacpdu, sizeof(lacpdu));
+		memcpy(rte_pktmbuf_mtod(lacp_tx_buf[i], char *), &lacpdu,
+		       sizeof(lacpdu));
 		rte_pktmbuf_pkt_len(lacp_tx_buf[i]) = sizeof(lacpdu);
 	}
 
@@ -1453,8 +1453,8 @@ test_mode4_ext_lacp(void)
 
 	for (i = 0; i < MEMBER_COUNT; i++) {
 		lacp_tx_buf[i] = rte_pktmbuf_alloc(test_params.mbuf_pool);
-		rte_memcpy(rte_pktmbuf_mtod(lacp_tx_buf[i], char *),
-			   &lacpdu, sizeof(lacpdu));
+		memcpy(rte_pktmbuf_mtod(lacp_tx_buf[i], char *), &lacpdu,
+		       sizeof(lacpdu));
 		rte_pktmbuf_pkt_len(lacp_tx_buf[i]) = sizeof(lacpdu);
 	}
 
diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index db23259745..e0ad4eed13 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -19,7 +19,6 @@
 #include <rte_debug.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
diff --git a/app/test/test_member.c b/app/test/test_member.c
index 23447196c3..3b7e81314b 100644
--- a/app/test/test_member.c
+++ b/app/test/test_member.c
@@ -7,7 +7,6 @@
 #include <math.h>
 #include "test.h"
 
-#include <rte_memcpy.h>
 #include <rte_malloc.h>
 
 #ifdef RTE_EXEC_ENV_WINDOWS
diff --git a/app/test/test_member_perf.c b/app/test/test_member_perf.c
index db6b8a18ef..f40fdba91e 100644
--- a/app/test/test_member_perf.c
+++ b/app/test/test_member_perf.c
@@ -11,7 +11,6 @@
 #include <rte_cycles.h>
 #include <rte_malloc.h>
 #include <rte_random.h>
-#include <rte_memcpy.h>
 #include <rte_thash.h>
 #include <math.h>
 
diff --git a/app/test/test_rawdev.c b/app/test/test_rawdev.c
index aece7b655c..daf599a48b 100644
--- a/app/test/test_rawdev.c
+++ b/app/test/test_rawdev.c
@@ -7,7 +7,6 @@
 #include <rte_common.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_dev.h>
 
 #ifdef RTE_EXEC_ENV_WINDOWS
diff --git a/app/test/test_ring.h b/app/test/test_ring.h
index 2e0ff9c1d6..934c09ee9e 100644
--- a/app/test/test_ring.h
+++ b/app/test/test_ring.h
@@ -2,8 +2,9 @@
  * Copyright(c) 2019 Arm Limited
  */
 
+#include <string.h>
+
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_ptr_compress.h>
 #include <rte_ring.h>
 #include <rte_ring_elem.h>
@@ -166,11 +167,10 @@ test_ring_enqueue(struct rte_ring *r, void **obj, int esize, unsigned int n,
 					r, esize, n, &zcd, NULL);
 			if (unlikely(ret == 0))
 				return 0;
-			rte_memcpy(zcd.ptr1, (char *)obj, zcd.n1 * esize);
+			memcpy(zcd.ptr1, (char *)obj, zcd.n1 * esize);
 			if (unlikely(zcd.ptr2 != NULL))
-				rte_memcpy(zcd.ptr2,
-						(char *)obj + zcd.n1 * esize,
-						(ret - zcd.n1) * esize);
+				memcpy(zcd.ptr2, (char *)obj + zcd.n1 * esize,
+				       (ret - zcd.n1) * esize);
 			rte_ring_enqueue_zc_finish(r, ret);
 			return ret;
 		case (TEST_RING_ELEM_BURST_ZC_COMPRESS_PTR_16):
@@ -271,11 +271,10 @@ test_ring_dequeue(struct rte_ring *r, void **obj, int esize, unsigned int n,
 					r, esize, n, &zcd, NULL);
 			if (unlikely(ret == 0))
 				return 0;
-			rte_memcpy((char *)obj, zcd.ptr1, zcd.n1 * esize);
+			memcpy(obj, zcd.ptr1, zcd.n1 * esize);
 			if (unlikely(zcd.ptr2 != NULL))
-				rte_memcpy((char *)obj + zcd.n1 * esize,
-						zcd.ptr2,
-						(ret - zcd.n1) * esize);
+				memcpy((char *)obj + zcd.n1 * esize,
+				       zcd.ptr2, (ret - zcd.n1) * esize);
 			rte_ring_dequeue_zc_finish(r, ret);
 			return ret;
 		case (TEST_RING_ELEM_BURST_ZC_COMPRESS_PTR_16):
diff --git a/app/test/test_security_inline_macsec.c b/app/test/test_security_inline_macsec.c
index a929ff5326..d97925a5a7 100644
--- a/app/test/test_security_inline_macsec.c
+++ b/app/test/test_security_inline_macsec.c
@@ -128,7 +128,7 @@ init_packet(struct rte_mempool *mp, const uint8_t *data, unsigned int len)
 	if (pkt == NULL)
 		return NULL;
 
-	rte_memcpy(rte_pktmbuf_append(pkt, len), data, len);
+	memcpy(rte_pktmbuf_append(pkt, len), data, len);
 
 	return pkt;
 }
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 0b1f7fbbab..209b04b92d 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -245,8 +245,8 @@ create_inline_ipsec_session(struct ipsec_test_data *sa, uint16_t portid,
 
 	/* Copy cipher session parameters */
 	if (sa->aead) {
-		rte_memcpy(sess_conf->crypto_xform, &sa->xform.aead,
-				sizeof(struct rte_crypto_sym_xform));
+		memcpy(sess_conf->crypto_xform, &sa->xform.aead,
+		       sizeof(struct rte_crypto_sym_xform));
 		sess_conf->crypto_xform->aead.key.data = sa->key.data;
 		/* Verify crypto capabilities */
 		if (test_sec_crypto_caps_aead_verify(sec_cap, sess_conf->crypto_xform) != 0) {
@@ -256,13 +256,13 @@ create_inline_ipsec_session(struct ipsec_test_data *sa, uint16_t portid,
 		}
 	} else {
 		if (dir == RTE_SECURITY_IPSEC_SA_DIR_EGRESS) {
-			rte_memcpy(&sess_conf->crypto_xform->cipher,
-					&sa->xform.chain.cipher.cipher,
-					sizeof(struct rte_crypto_cipher_xform));
+			memcpy(&sess_conf->crypto_xform->cipher,
+			       &sa->xform.chain.cipher.cipher,
+			       sizeof(struct rte_crypto_cipher_xform));
 
-			rte_memcpy(&sess_conf->crypto_xform->next->auth,
-					&sa->xform.chain.auth.auth,
-					sizeof(struct rte_crypto_auth_xform));
+			memcpy(&sess_conf->crypto_xform->next->auth,
+			       &sa->xform.chain.auth.auth,
+			       sizeof(struct rte_crypto_auth_xform));
 			sess_conf->crypto_xform->cipher.key.data =
 							sa->key.data;
 			sess_conf->crypto_xform->next->auth.key.data =
@@ -282,12 +282,12 @@ create_inline_ipsec_session(struct ipsec_test_data *sa, uint16_t portid,
 				return TEST_SKIPPED;
 			}
 		} else {
-			rte_memcpy(&sess_conf->crypto_xform->next->cipher,
-					&sa->xform.chain.cipher.cipher,
-					sizeof(struct rte_crypto_cipher_xform));
-			rte_memcpy(&sess_conf->crypto_xform->auth,
-					&sa->xform.chain.auth.auth,
-					sizeof(struct rte_crypto_auth_xform));
+			memcpy(&sess_conf->crypto_xform->next->cipher,
+			       &sa->xform.chain.cipher.cipher,
+			       sizeof(struct rte_crypto_cipher_xform));
+			memcpy(&sess_conf->crypto_xform->auth,
+			       &sa->xform.chain.auth.auth,
+			       sizeof(struct rte_crypto_auth_xform));
 			sess_conf->crypto_xform->auth.key.data =
 							sa->auth_key.data;
 			sess_conf->crypto_xform->next->cipher.key.data =
@@ -424,7 +424,7 @@ copy_buf_to_pkt_segs(const uint8_t *buf, unsigned int len,
 	copy_len = seg->buf_len - seg->data_off - offset;
 	seg_buf = rte_pktmbuf_mtod_offset(seg, char *, offset);
 	while (len > copy_len) {
-		rte_memcpy(seg_buf, buf + copied, (size_t) copy_len);
+		memcpy(seg_buf, buf + copied, (size_t) copy_len);
 		len -= copy_len;
 		copied += copy_len;
 		seg->data_len += copy_len;
@@ -433,7 +433,7 @@ copy_buf_to_pkt_segs(const uint8_t *buf, unsigned int len,
 		copy_len = seg->buf_len - seg->data_off;
 		seg_buf = rte_pktmbuf_mtod(seg, void *);
 	}
-	rte_memcpy(seg_buf, buf + copied, (size_t) len);
+	memcpy(seg_buf, buf + copied, (size_t) len);
 	seg->data_len = len;
 
 	pkt->pkt_len += copied + len;
@@ -463,12 +463,12 @@ init_packet(struct rte_mempool *mp, const uint8_t *data, unsigned int len, bool
 		return NULL;
 
 	if (outer_ipv4) {
-		rte_memcpy(rte_pktmbuf_append(pkt, RTE_ETHER_HDR_LEN),
-				&dummy_ipv4_eth_hdr, RTE_ETHER_HDR_LEN);
+		memcpy(rte_pktmbuf_append(pkt, RTE_ETHER_HDR_LEN),
+		       &dummy_ipv4_eth_hdr, RTE_ETHER_HDR_LEN);
 		pkt->l3_len = sizeof(struct rte_ipv4_hdr);
 	} else {
-		rte_memcpy(rte_pktmbuf_append(pkt, RTE_ETHER_HDR_LEN),
-				&dummy_ipv6_eth_hdr, RTE_ETHER_HDR_LEN);
+		memcpy(rte_pktmbuf_append(pkt, RTE_ETHER_HDR_LEN),
+		       &dummy_ipv6_eth_hdr, RTE_ETHER_HDR_LEN);
 		pkt->l3_len = sizeof(struct rte_ipv6_hdr);
 	}
 	pkt->l2_len = RTE_ETHER_HDR_LEN;
@@ -491,7 +491,7 @@ init_packet(struct rte_mempool *mp, const uint8_t *data, unsigned int len, bool
 	}
 
 	if (pkt->buf_len > len + RTE_ETHER_HDR_LEN)
-		rte_memcpy(rte_pktmbuf_append(pkt, len), data, len);
+		memcpy(rte_pktmbuf_append(pkt, len), data, len);
 	else
 		copy_buf_to_pkt_segs(data, len, pkt, RTE_ETHER_HDR_LEN);
 	return pkt;
diff --git a/app/test/test_security_proto.c b/app/test/test_security_proto.c
index cf40d5fc9a..6302f33886 100644
--- a/app/test/test_security_proto.c
+++ b/app/test/test_security_proto.c
@@ -167,5 +167,5 @@ test_sec_proto_pattern_generate(void)
 void
 test_sec_proto_pattern_set(uint8_t *buf, int len)
 {
-	rte_memcpy(buf, cleartext_pattern, len);
+	memcpy(buf, cleartext_pattern, len);
 }
diff --git a/app/test/test_service_cores.c b/app/test/test_service_cores.c
index ff04472616..0ae83a10dc 100644
--- a/app/test/test_service_cores.c
+++ b/app/test/test_service_cores.c
@@ -7,7 +7,6 @@
 #include <rte_hexdump.h>
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
-#include <rte_memcpy.h>
 #include <rte_random.h>
 
 #include <rte_service.h>
diff --git a/app/test/test_thash.c b/app/test/test_thash.c
index eeb2e87f2c..12911979c7 100644
--- a/app/test/test_thash.c
+++ b/app/test/test_thash.c
@@ -316,14 +316,14 @@ test_toeplitz_hash_gfni_bulk(void)
 		tuple[0].v4.dst_addr = rte_cpu_to_be_32(v4_tbl[i].dst_ip);
 		tuple[0].v4.sport = rte_cpu_to_be_16(v4_tbl[i].dst_port);
 		tuple[0].v4.dport = rte_cpu_to_be_16(v4_tbl[i].src_port);
-		rte_memcpy(tuples[0], &tuple[0], RTE_THASH_V4_L4_LEN * 4);
+		memcpy(tuples[0], &tuple[0], RTE_THASH_V4_L4_LEN * 4);
 
 		/*Load IPv6 headers and copy it into the corresponding tuple*/
 		tuple[1].v6.src_addr = v6_tbl[i].src_ip;
 		tuple[1].v6.dst_addr = v6_tbl[i].dst_ip;
 		tuple[1].v6.sport = rte_cpu_to_be_16(v6_tbl[i].dst_port);
 		tuple[1].v6.dport = rte_cpu_to_be_16(v6_tbl[i].src_port);
-		rte_memcpy(tuples[1], &tuple[1], RTE_THASH_V6_L4_LEN * 4);
+		memcpy(tuples[1], &tuple[1], RTE_THASH_V6_L4_LEN * 4);
 
 		rte_thash_gfni_bulk(rss_key_matrixes, RTE_THASH_V6_L4_LEN * 4,
 			tuples, rss, 2);
diff --git a/app/test/virtual_pmd.c b/app/test/virtual_pmd.c
index aa37e4073c..0bc986189b 100644
--- a/app/test/virtual_pmd.c
+++ b/app/test/virtual_pmd.c
@@ -2,13 +2,14 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <string.h>
+
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_memory.h>
 #include <rte_ring.h>
 
@@ -187,7 +188,7 @@ virtual_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	struct virtual_ethdev_private *dev_private = dev->data->dev_private;
 
 	if (stats)
-		rte_memcpy(stats, &dev_private->eth_stats, sizeof(*stats));
+		memcpy(stats, &dev_private->eth_stats, sizeof(*stats));
 
 	return 0;
 }
-- 
2.53.0

