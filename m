Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD269CA5FC1
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 02:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCD7D40E50;
	Thu,  1 Oct 2026 04:58:59 +0200 (CEST)
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by mails.dpdk.org (Postfix) with ESMTP id 021CB402C3
 for <dev@dpdk.org>; Thu,  1 Oct 2026 04:58:57 +0200 (CEST)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0f64df6a6so2514241a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 19:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790823537;
 x=1791428337; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CUpC7eYAB/aUt6kTrpY2zOj6Lp78fAx2OuSv9d+yq2k=;
 b=JAjCFzyDaf1WnoSyh0jdsw9heF/n3g14s7WJUhsOLwb7d5HcPsyDPVWLWtRvjivrAs
 4oVPb53pg65N2Vcdr0KuwAbzKXX3FeU5N+C0/QasRRWGjac1CHggTlaWjZNT+8p2orqR
 c5EtnJyHFDEkEydvrcAr1l6DRKM1j/PZdkFoDIV3uAQEEiaxfdVcqNF6x+/PuzsJVItF
 HyHdzmi58kXrcbjDmOgJ+6D9L2BRLQZw1iDvLUI0UQWwrmMvW4p90rZRxAII4d4TJcCL
 CECW3P+2WeQMmGm9uZvmCbvwkdGJuwbu/0+QHcN5ul23/XFOn0MtHP/zP6tfNBJ/aLzW
 O/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790823537; x=1791428337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CUpC7eYAB/aUt6kTrpY2zOj6Lp78fAx2OuSv9d+yq2k=;
 b=I7SzW8LNIFZs47YO63E6Ne4qVqb+x6+9gGUP48TJznLrx91LngtcwW2t4VGXUFr1/H
 1Q13aDyvFFRACVD6Go+rXmkqIffmuwejkfDg7U8vbQrUwA2hNb24dJVlGLJyJX/FRlef
 46wcU9+sduCEVdEzdukhkwaFKnC++ydskLLOA3t2dQPklW77dl/9Jy8ZIN4iMDF5o520
 UybmHoj7AlAHgLtwZCNScCNypw378jlkKX3Y0sgASCa9uHSTYhTuJRaOBKNhVEoxK9pQ
 TdZ5pQYG8fp0evMtMWUq0NJmgW1czfPpTpbsGMZZWs9lSRgxBX7VmKrJASb9vSD9dKeA
 JdRQ==
X-Gm-Message-State: AFq9FYKLuaZu50pCkvCMVcv34vZDSl7sonv6ln7Xi52xZ3/MeK3GNRPj
 0mBE2YTEXWonL61zrtDEJZNrfdtM09yeNcrOAMaqslouSKAWgGeMnRxXHta57byf6z/+T9qkOiN
 sN+W4BgU=
X-Gm-Gg: AYBFou1hgF8sqPisEx52A8KN+Kg2dPmK6QNPkSzbPEIEeVe1CT2iyjpKe9c4FVYthCg
 0iG/WkfHDSEDTOAcDeaQTHo9faW4cdQac8at/k96h3IrUzOQWf04Jq9P7wbZ1hSanlTE8rFR/0L
 tN1HvVZLfNB1OmE4Zg8Balqys7wewk43zbv89PRQTEQBp83QveX4n7BUwkgVMP/HWhFs4tATgYB
 EgaccG/s9e1DdDtpqkdMTyEY1AXZI2njog0T7YTnc2CRNZuEmkHkgnFZYPb7TZaoNdNfZObwdYU
 KweG5DNB/vRQDjZM0f14uIe/IG92RD2gUqRvOYbESV1g9lTrf7RwN7fN7ku+Ca8LF1sk8hATd8X
 Hy98mbvwwSf/nXByWZUy19HkblJkP4QpIU/qdytdUnkLbsy43mzfIMSIvIiTaezaOBhdS/dm/2/
 VJXGsrPJCAqLJqhsGDyAGbzIoVtsszEjcqRPhiUyp8V3napTJFI82ule1UxwZG1LY8p00EVpHmx
 2C22axDPsQW1PFG4vV9145qBERv622GmtbzHGRukYN4RXtN
X-Received: by 2002:a17:90b:54cd:b0:39e:3ce1:d22f with SMTP id
 98e67ed59e1d1-3a4d154270bmr3098144a91.16.1790823536916; 
 Wed, 30 Sep 2026 19:58:56 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f471b16asm2024487a91.9.2026.09.30.19.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:58:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 1/4] pcapng: add API to read back capture mbuf header
Date: Wed, 30 Sep 2026 19:35:26 -0700
Message-ID: <20261001025853.319860-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001025853.319860-1-stephen@networkplumber.org>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20261001025853.319860-1-stephen@networkplumber.org>
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

An mbuf from rte_pcapng_copy() starts with an enhanced packet block
holding the capture time, the length before truncation and the port.
The only way to get at that was to write the mbuf to a file, which
is no use to something forwarding captured packets elsewhere.

Add rte_pcapng_pkt_info() to decode that header in place, and check
it is well formed before trusting the lengths in it.

The capture time is reported as the raw TSC value: there is no
capture file here to take a reference point from, so converting it
to a time of day is left to the caller.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c                 | 133 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   5 +
 lib/pcapng/rte_pcapng.c                |  40 ++++++++
 lib/pcapng/rte_pcapng.h                |  46 +++++++++
 4 files changed, 224 insertions(+)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index d14ea84f0d..cb36ea1d54 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -672,6 +672,138 @@ test_write_before_open(void)
 	return -1;
 }
 
+/*
+ * Check that rte_pcapng_pkt_info() reads back what rte_pcapng_copy()
+ * recorded.  The length before truncation and the capture time are
+ * only in the block header, so this is the only way a consumer that
+ * does not write a file can get at them.
+ */
+static int
+test_pkt_info(void)
+{
+	struct dummy_mbuf mbfs;
+	struct rte_mbuf *mc;
+	struct rte_pcapng_pkt pkt;
+	uint32_t pkt_len, snaplen, saved;
+	uint64_t before, after;
+	const uint8_t *data;
+	int ret;
+
+	mbuf1_prepare(&mbfs);
+	mbuf1_resize(&mbfs, 512);
+	pkt_len = rte_pktmbuf_pkt_len(&mbfs.mb[0]);
+
+	/* An untruncated copy reports the length it came in with. */
+	before = rte_get_tsc_cycles();
+	mc = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp, pkt_len,
+			     RTE_PCAPNG_DIRECTION_IN, NULL);
+	TEST_ASSERT(mc != NULL, "rte_pcapng_copy failed");
+	after = rte_get_tsc_cycles();
+
+	ret = rte_pcapng_pkt_info(mc, &pkt);
+	TEST_ASSERT(ret == 0, "rte_pcapng_pkt_info failed: %d", ret);
+
+	TEST_ASSERT(pkt.original_len == pkt_len,
+		    "original_len is %u, expected %u", pkt.original_len, pkt_len);
+	TEST_ASSERT(pkt.captured_len == pkt_len,
+		    "captured_len is %u, expected %u", pkt.captured_len, pkt_len);
+	TEST_ASSERT(pkt.port == port_id,
+		    "port is %u, expected %u", pkt.port, port_id);
+
+	/* The copy was made between the two readings, so the recorded
+	 * cycle count has to fall between them.
+	 */
+	TEST_ASSERT(pkt.cycles >= before && pkt.cycles <= after,
+		    "cycles %"PRIu64" is outside [%"PRIu64", %"PRIu64"]",
+		    pkt.cycles, before, after);
+
+	/* data_offset points at the packet itself, not the block header. */
+	data = rte_pktmbuf_mtod_offset(mc, const uint8_t *, pkt.data_offset);
+	TEST_ASSERT(memcmp(data, rte_pktmbuf_mtod(&mbfs.mb[0], const void *),
+			   rte_pktmbuf_data_len(&mbfs.mb[0])) == 0,
+		    "packet data is not at data_offset");
+
+	/* A corrupt block is rejected rather than believed. */
+	{
+		struct pcapng_test_epb {
+			uint32_t block_type;
+			uint32_t block_length;
+		} *epb = rte_pktmbuf_mtod(mc, struct pcapng_test_epb *);
+
+		saved = epb->block_type;
+		epb->block_type = ~saved;
+		TEST_ASSERT(rte_pcapng_pkt_info(mc, &pkt) == -EINVAL,
+			    "bad block_type was accepted");
+		epb->block_type = saved;
+
+		saved = epb->block_length;
+		epb->block_length = saved + 1;
+		TEST_ASSERT(rte_pcapng_pkt_info(mc, &pkt) == -EINVAL,
+			    "bad block_length was accepted");
+		epb->block_length = saved;
+
+		/* and is fine again once put back */
+		TEST_ASSERT(rte_pcapng_pkt_info(mc, &pkt) == 0,
+			    "restored block was rejected");
+	}
+
+	TEST_ASSERT(rte_pcapng_pkt_info(NULL, &pkt) == -EINVAL,
+		    "NULL mbuf was accepted");
+	TEST_ASSERT(rte_pcapng_pkt_info(mc, NULL) == -EINVAL,
+		    "NULL result was accepted");
+
+	rte_pktmbuf_free(mc);
+
+	/*
+	 * Truncated copy.  This is the case that cannot be recovered
+	 * from the mbuf alone: captured_len shrinks to the snaplen
+	 * while original_len still describes the packet on the wire.
+	 */
+	snaplen = pkt_len / 2;
+	mc = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp, snaplen,
+			     RTE_PCAPNG_DIRECTION_IN, NULL);
+	TEST_ASSERT(mc != NULL, "truncated rte_pcapng_copy failed");
+
+	ret = rte_pcapng_pkt_info(mc, &pkt);
+	TEST_ASSERT(ret == 0, "rte_pcapng_pkt_info failed on truncated: %d", ret);
+
+	TEST_ASSERT(pkt.captured_len == snaplen,
+		    "captured_len is %u, expected %u", pkt.captured_len, snaplen);
+	TEST_ASSERT(pkt.original_len == pkt_len,
+		    "original_len is %u, expected %u, truncation lost it",
+		    pkt.original_len, pkt_len);
+
+	rte_pktmbuf_free(mc);
+
+	/*
+	 * A stripped VLAN tag is put back by the copy, but is not
+	 * counted in the length reported by the hardware.  So the
+	 * captured packet is larger than the original, and a consumer
+	 * has to cope with that rather than assume it cannot happen.
+	 */
+	mbfs.mb[0].ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
+	mbfs.mb[0].vlan_tci = 42;
+
+	mc = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp, pkt_len,
+			     RTE_PCAPNG_DIRECTION_IN, NULL);
+	TEST_ASSERT(mc != NULL, "VLAN rte_pcapng_copy failed");
+
+	ret = rte_pcapng_pkt_info(mc, &pkt);
+	TEST_ASSERT(ret == 0, "rte_pcapng_pkt_info failed on VLAN: %d", ret);
+
+	TEST_ASSERT(pkt.captured_len == pkt_len + sizeof(struct rte_vlan_hdr),
+		    "captured_len is %u, expected %zu with the tag restored",
+		    pkt.captured_len, pkt_len + sizeof(struct rte_vlan_hdr));
+	TEST_ASSERT(pkt.original_len == pkt_len,
+		    "original_len is %u, expected %u", pkt.original_len, pkt_len);
+	TEST_ASSERT(pkt.captured_len > pkt.original_len,
+		    "restored VLAN tag did not make the capture longer");
+
+	rte_pktmbuf_free(mc);
+
+	return 0;
+}
+
 static void
 test_cleanup(void)
 {
@@ -688,6 +820,7 @@ unit_test_suite test_pcapng_suite  = {
 		TEST_CASE(test_add_interface),
 		TEST_CASE(test_write_packets),
 		TEST_CASE(test_write_before_open),
+		TEST_CASE(test_pkt_info),
 		TEST_CASES_END()
 	}
 };
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e027c7a27f..5b5a9f006e 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added pcapng API to read back a captured packet header.**
+
+  Added the experimental ``rte_pcapng_pkt_info()`` function to read back what
+  ``rte_pcapng_copy()`` records in a captured packet.
+
 * **Added API to get CPU socket ID.**
 
   Added the experimental ``rte_cpu_socket_id()`` function
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b5d1026891..54a0aa1342 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -707,6 +707,46 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	return NULL;
 }
 
+/* Read back the block header put there by rte_pcapng_copy() */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pcapng_pkt_info, 26.11)
+int
+rte_pcapng_pkt_info(const struct rte_mbuf *m, struct rte_pcapng_pkt *pkt)
+{
+	const struct pcapng_enhance_packet_block *epb;
+	struct pcapng_enhance_packet_block ebuf;
+
+	if (unlikely(m == NULL || pkt == NULL))
+		return -EINVAL;
+
+	epb = rte_pktmbuf_read(m, 0, sizeof(*epb), &ebuf);
+	if (unlikely(epb == NULL))
+		return -EINVAL;
+
+	if (unlikely(epb->block_type != PCAPNG_ENHANCED_PACKET_BLOCK))
+		return -EINVAL;
+
+	/*
+	 * rte_pcapng_copy() sets block_length to the whole mbuf length, and
+	 * the packet data has to fit in what is left after the header.
+	 */
+	if (unlikely(epb->block_length != rte_pktmbuf_pkt_len(m)))
+		return -EINVAL;
+
+	if (unlikely(epb->capture_length >
+		     epb->block_length - sizeof(*epb)))
+		return -EINVAL;
+
+	pkt->cycles = (uint64_t)epb->timestamp_hi << 32;
+	pkt->cycles += epb->timestamp_lo;
+
+	pkt->captured_len = epb->capture_length;
+	pkt->original_len = epb->original_length;
+	pkt->data_offset = sizeof(*epb);
+	pkt->port = m->port;
+
+	return 0;
+}
+
 /* Write pre-formatted packets to file. */
 RTE_EXPORT_SYMBOL(rte_pcapng_write_packets)
 ssize_t
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index d8d328f710..055075e921 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -22,6 +22,8 @@
 #include <stdint.h>
 #include <sys/types.h>
 
+#include <rte_compat.h>
+#include <rte_mbuf.h>
 #include <rte_mempool.h>
 
 #ifdef __cplusplus
@@ -140,6 +142,50 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		uint32_t length,
 		enum rte_pcapng_direction direction, const char *comment);
 
+/**
+ * Decoded header of an mbuf produced by rte_pcapng_copy().
+ *
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice.
+ */
+struct rte_pcapng_pkt {
+	uint64_t cycles;	/**< TSC value when the packet was captured */
+	uint32_t captured_len;	/**< bytes of packet data present */
+	uint32_t original_len;	/**< length of the packet on the wire */
+	uint32_t data_offset;	/**< offset of packet data in the mbuf */
+	uint16_t port;		/**< port recorded by rte_pcapng_copy() */
+};
+
+/**
+ * Extract info from mbuf created by rte_pcapng_copy().
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Only valid for packets created by rte_pcapng_copy().
+ * The mbuf is not modified.
+ * To reach the packet data, read *captured_len* bytes starting at *data_offset*.
+ *
+ * The capture time is reported as the raw TSC value recorded by
+ * rte_pcapng_copy(), since this has no capture file to take a reference
+ * point from.  To turn it into a time of day, sample rte_get_tsc_cycles()
+ * and the system clock together once, then scale the difference by
+ * rte_get_tsc_hz().
+ *
+ * @param m
+ *   An mbuf returned by rte_pcapng_copy().
+ * @param pkt
+ *   Filled in on success.
+ * @return
+ *   0 on success, -EINVAL if the mbuf is not a well formed enhanced
+ *   packet block.
+ *
+ * @note
+ *   Length may vary from the original because rte_pcapng_copy() inserts VLAN.
+ */
+__rte_experimental
+int
+rte_pcapng_pkt_info(const struct rte_mbuf *m, struct rte_pcapng_pkt *pkt);
 
 /**
  * Determine optimum mbuf data size.
-- 
2.53.0

