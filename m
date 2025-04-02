Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E086C36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 010B440651;
	Thu,  3 Apr 2025 01:24:52 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id E23EE40280
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:24:49 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-476805acddaso3229131cf.1
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636289;
 x=1744241089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SGv9Ld0AihCwrrd30NzWlzd1y9ceO6ZLnXIr7w0HuI=;
 b=NP+Q9rKpu+Mk1s8xGWkZguvYbhJriTniWWM/Kb2ItX6gYRHFcq9xHSMhjE6g+zh+g6
 VZe397wi/LEq/Iinj2S5HNxPMpip1WqUF2K6oLUsRAStqApJMw3jUfxrA0EE3zxcyOgI
 ilo1WbE4V04C/Qkk5/w2z2XgL8dNcZM6Senpd44lIkVVd+uK+/iKK/0ILrBXMQ6jCNvR
 MvJAm81vthdRLlKdKv0jsmm0cMcUeczElnMnPvlB+/xQanhbbRIzWdA3iqQ5pM5D5N1X
 s6zdBSpEXsOo41cNQ7p4gEN2ToyjTK7a8CfIyCh207U5bT857q1or5hiiTVjK51uNRqk
 oJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636289; x=1744241089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SGv9Ld0AihCwrrd30NzWlzd1y9ceO6ZLnXIr7w0HuI=;
 b=p4n0DdEGOampDa1zUzLquK5tLvF/ruMF/Fzzo8iAsiCnuOiYOgjYLYsOeUA5iI+OwD
 W0Y3uYuHeoLpxPxVZu2e6rSu7/Y+bQsHm2kWgZS/N6gPMvw3b42uovilW67K3BUraGD+
 ImKQ5iYi+WZssvBzQ5D08pBHuk1RlZ726jZVKY8xVZj3vtDMY0+XYDYN9uafWMD9Md6y
 GAM4jSRq0EjvrfRxApDx1Cst3uXV+SUm/hxT31rWB7X6T6BxKSpBRdSlVYvIFgL8xeoj
 ORHcpk91PV2+K0QrN4lFF71sfqSYtwuv9Nz+KHiC32jCQa47DtTVlJkdUc4kMv3MlhQL
 w/BA==
X-Gm-Message-State: AOJu0Yy9L524oA2+G4L7rHdNIH79Mi32i+LluXnifiQBn9L6wuwtK5Ul
 oCfzoOd1oXUV3iAWjcc7xCVv9MUBK8DHtuEz92AgUSOdogG6LHWbnjp09ai3LiX5XAnakw4LmdI
 7
X-Gm-Gg: ASbGncv4m0DNq41PaIhQgL62Mo+XWajRhhERX47Dl2p/1aG22OVwaq9OISWPvYskqfx
 aTBrKGypzPZQQUkSMFZKweqeX/Po/krUtCjOWmm/2A14IWwcvpvCWtYuOgTIBgQsZps51UESbk2
 0acV40KnSrtnpcvZG75hDXeEUHwRQ6oQQgCpiAHLRHIwCe8TN1Rcqa9V9snNGk1X7Hx/Lm2lAry
 gcIekAQ2zWW4sXlTvcpOPrxU3OStgkpiWz7qBtDYhEYsBXKJeqX8SnNHZJMwGwVYnBP3cwiSofz
 6uZlvghT2cyGa3/1g7B9sVP97nb4MtJCp78vzPJc0E/97xjDMl4ixE313kMdsPNpUkjwAi3oIAO
 qMWwLkjYi5C9sds6/Hw==
X-Google-Smtp-Source: AGHT+IH0pRerJQFNByumbn3SGSeR2pbkwIjtlsZ3aKInNo/6AY1V1i6JXVPwmDpB4TSvbb80msCnog==
X-Received: by 2002:a05:6214:414:b0:6ee:b77c:7dbe with SMTP id
 6a1803df08f44-6eed61d72famr268521506d6.12.1743636288851; 
 Wed, 02 Apr 2025 16:24:48 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v12 01/10] mbuf: replace term sanity check
Date: Wed,  2 Apr 2025 16:23:11 -0700
Message-ID: <20250402232441.440346-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Replace rte_mbuf_sanity_check() with rte_mbuf_verify()
to match the similar macro RTE_VERIFY() in rte_debug.h

The term sanity check is on the Tier 2 list of words
that should be replaced.

For this release keep old API functions but mark them
as deprecated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test/test_cryptodev.c            |  2 +-
 app/test/test_mbuf.c                 | 28 +++++-----
 doc/guides/prog_guide/mbuf_lib.rst   |  4 +-
 doc/guides/rel_notes/deprecation.rst |  3 ++
 lib/mbuf/rte_mbuf.c                  | 23 +++++---
 lib/mbuf/rte_mbuf.h                  | 79 +++++++++++++++-------------
 lib/mbuf/version.map                 |  1 +
 7 files changed, 79 insertions(+), 61 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 31a4905a97..d5f3843daf 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -264,7 +264,7 @@ create_mbuf_from_heap(int pkt_len, uint8_t pattern)
 	m->port = RTE_MBUF_PORT_INVALID;
 	m->buf_len = MBUF_SIZE - sizeof(struct rte_mbuf) - RTE_PKTMBUF_HEADROOM;
 	rte_pktmbuf_reset_headroom(m);
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	m->buf_addr = (char *)m + sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM;
 
diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index 17be977f31..3fbb5dea8b 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -262,8 +262,8 @@ test_one_pktmbuf(struct rte_mempool *pktmbuf_pool)
 		GOTO_FAIL("Buffer should be continuous");
 	memset(hdr, 0x55, MBUF_TEST_HDR2_LEN);
 
-	rte_mbuf_sanity_check(m, 1);
-	rte_mbuf_sanity_check(m, 0);
+	rte_mbuf_verify(m, 1);
+	rte_mbuf_verify(m, 0);
 	rte_pktmbuf_dump(stdout, m, 0);
 
 	/* this prepend should fail */
@@ -1162,7 +1162,7 @@ test_refcnt_mbuf(void)
 
 #ifdef RTE_EXEC_ENV_WINDOWS
 static int
-test_failing_mbuf_sanity_check(struct rte_mempool *pktmbuf_pool)
+test_failing_mbuf_verify(struct rte_mempool *pktmbuf_pool)
 {
 	RTE_SET_USED(pktmbuf_pool);
 	return TEST_SKIPPED;
@@ -1181,12 +1181,12 @@ mbuf_check_pass(struct rte_mbuf *buf)
 }
 
 static int
-test_failing_mbuf_sanity_check(struct rte_mempool *pktmbuf_pool)
+test_failing_mbuf_verify(struct rte_mempool *pktmbuf_pool)
 {
 	struct rte_mbuf *buf;
 	struct rte_mbuf badbuf;
 
-	printf("Checking rte_mbuf_sanity_check for failure conditions\n");
+	printf("Checking rte_mbuf_verify for failure conditions\n");
 
 	/* get a good mbuf to use to make copies */
 	buf = rte_pktmbuf_alloc(pktmbuf_pool);
@@ -1708,7 +1708,7 @@ test_mbuf_validate_tx_offload(const char *test_name,
 		GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
 	if (rte_pktmbuf_pkt_len(m) != 0)
 		GOTO_FAIL("%s: Bad packet length\n", __func__);
-	rte_mbuf_sanity_check(m, 0);
+	rte_mbuf_verify(m, 0);
 	m->ol_flags = ol_flags;
 	m->tso_segsz = segsize;
 	ret = rte_validate_tx_offload(m);
@@ -1915,7 +1915,7 @@ test_pktmbuf_read(struct rte_mempool *pktmbuf_pool)
 		GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
 	if (rte_pktmbuf_pkt_len(m) != 0)
 		GOTO_FAIL("%s: Bad packet length\n", __func__);
-	rte_mbuf_sanity_check(m, 0);
+	rte_mbuf_verify(m, 0);
 
 	data = rte_pktmbuf_append(m, MBUF_TEST_DATA_LEN2);
 	if (data == NULL)
@@ -1964,7 +1964,7 @@ test_pktmbuf_read_from_offset(struct rte_mempool *pktmbuf_pool)
 
 	if (rte_pktmbuf_pkt_len(m) != 0)
 		GOTO_FAIL("%s: Bad packet length\n", __func__);
-	rte_mbuf_sanity_check(m, 0);
+	rte_mbuf_verify(m, 0);
 
 	/* prepend an ethernet header */
 	hdr = (struct ether_hdr *)rte_pktmbuf_prepend(m, hdr_len);
@@ -2109,7 +2109,7 @@ create_packet(struct rte_mempool *pktmbuf_pool,
 			GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
 		if (rte_pktmbuf_pkt_len(pkt_seg) != 0)
 			GOTO_FAIL("%s: Bad packet length\n", __func__);
-		rte_mbuf_sanity_check(pkt_seg, 0);
+		rte_mbuf_verify(pkt_seg, 0);
 		/* Add header only for the first segment */
 		if (test_data->flags == MBUF_HEADER && seg == 0) {
 			hdr_len = sizeof(struct rte_ether_hdr);
@@ -2321,7 +2321,7 @@ test_pktmbuf_ext_shinfo_init_helper(struct rte_mempool *pktmbuf_pool)
 		GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
 	if (rte_pktmbuf_pkt_len(m) != 0)
 		GOTO_FAIL("%s: Bad packet length\n", __func__);
-	rte_mbuf_sanity_check(m, 0);
+	rte_mbuf_verify(m, 0);
 
 	ext_buf_addr = rte_malloc("External buffer", buf_len,
 			RTE_CACHE_LINE_SIZE);
@@ -2482,8 +2482,8 @@ test_pktmbuf_ext_pinned_buffer(struct rte_mempool *std_pool)
 		GOTO_FAIL("%s: test_pktmbuf_copy(pinned) failed\n",
 			  __func__);
 
-	if (test_failing_mbuf_sanity_check(pinned_pool) < 0)
-		GOTO_FAIL("%s: test_failing_mbuf_sanity_check(pinned)"
+	if (test_failing_mbuf_verify(pinned_pool) < 0)
+		GOTO_FAIL("%s: test_failing_mbuf_verify(pinned)"
 			  " failed\n", __func__);
 
 	if (test_mbuf_linearize_check(pinned_pool) < 0)
@@ -2857,8 +2857,8 @@ test_mbuf(void)
 		goto err;
 	}
 
-	if (test_failing_mbuf_sanity_check(pktmbuf_pool) < 0) {
-		printf("test_failing_mbuf_sanity_check() failed\n");
+	if (test_failing_mbuf_verify(pktmbuf_pool) < 0) {
+		printf("test_failing_mbuf_verify() failed\n");
 		goto err;
 	}
 
diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index 4ad2a21f3f..6c96931f8c 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -266,8 +266,8 @@ can be found in several of the sample applications, for example, the IPv4 Multic
 Debug
 -----
 
-In debug mode, the functions of the mbuf library perform sanity checks before any operation (such as, buffer corruption,
-bad type, and so on).
+In debug mode, the functions of the mbuf library perform consistency checks
+before any operation (such as, buffer corruption, bad type, and so on).
 
 Use Cases
 ---------
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 36489f6e68..10bb08a634 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -142,3 +142,6 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* mbuf: The function ``rte_mbuf_sanity_check`` is deprecated.
+  Use the new function ``rte_mbuf_verify`` instead.
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 559d5ad8a7..fc5d4ba29d 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -367,9 +367,9 @@ rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 	return mp;
 }
 
-/* do some sanity checks on a mbuf: panic if it fails */
+/* do some checks on a mbuf: panic if it fails */
 void
-rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
+rte_mbuf_verify(const struct rte_mbuf *m, int is_header)
 {
 	const char *reason;
 
@@ -377,6 +377,13 @@ rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
 		rte_panic("%s\n", reason);
 }
 
+/* For ABI compatibility, to be removed in next release */
+void
+rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
+{
+	rte_mbuf_verify(m, is_header);
+}
+
 int rte_mbuf_check(const struct rte_mbuf *m, int is_header,
 		   const char **reason)
 {
@@ -496,7 +503,7 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 		if (unlikely(m == NULL))
 			continue;
 
-		__rte_mbuf_sanity_check(m, 1);
+		__rte_mbuf_verify(m, 1);
 
 		do {
 			m_next = m->next;
@@ -546,7 +553,7 @@ rte_pktmbuf_clone(struct rte_mbuf *md, struct rte_mempool *mp)
 		return NULL;
 	}
 
-	__rte_mbuf_sanity_check(mc, 1);
+	__rte_mbuf_verify(mc, 1);
 	return mc;
 }
 
@@ -596,7 +603,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 	struct rte_mbuf *mc, *m_last, **prev;
 
 	/* garbage in check */
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	/* check for request to copy at offset past end of mbuf */
 	if (unlikely(off >= m->pkt_len))
@@ -660,7 +667,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 	}
 
 	/* garbage out check */
-	__rte_mbuf_sanity_check(mc, 1);
+	__rte_mbuf_verify(mc, 1);
 	return mc;
 }
 
@@ -671,7 +678,7 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m, unsigned dump_len)
 	unsigned int len;
 	unsigned int nb_segs;
 
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	fprintf(f, "dump mbuf at %p, iova=%#" PRIx64 ", buf_len=%u\n", m, rte_mbuf_iova_get(m),
 		m->buf_len);
@@ -689,7 +696,7 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m, unsigned dump_len)
 	nb_segs = m->nb_segs;
 
 	while (m && nb_segs != 0) {
-		__rte_mbuf_sanity_check(m, 0);
+		__rte_mbuf_verify(m, 0);
 
 		fprintf(f, "  segment at %p, data=%p, len=%u, off=%u, refcnt=%u\n",
 			m, rte_pktmbuf_mtod(m, void *),
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 06ab7502a5..53a837e4d5 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -339,16 +339,20 @@ rte_pktmbuf_priv_flags(struct rte_mempool *mp)
 
 #ifdef RTE_LIBRTE_MBUF_DEBUG
 
-/**  check mbuf type in debug mode */
-#define __rte_mbuf_sanity_check(m, is_h) rte_mbuf_sanity_check(m, is_h)
+/**  do mbuf type in debug mode */
+#define __rte_mbuf_verify(m, is_h) rte_mbuf_verify(m, is_h)
 
 #else /*  RTE_LIBRTE_MBUF_DEBUG */
 
-/**  check mbuf type in debug mode */
-#define __rte_mbuf_sanity_check(m, is_h) do { } while (0)
+/**  ignore mbuf checks if not in debug mode */
+#define __rte_mbuf_verify(m, is_h) do { } while (0)
 
 #endif /*  RTE_LIBRTE_MBUF_DEBUG */
 
+/* deprecated version of the macro */
+#define __rte_mbuf_sanity_check(m, is_h) RTE_DEPRECATED(__rte_mbuf_sanity_check) \
+		__rte_mbuf_verify(m, is_h)
+
 #ifdef RTE_MBUF_REFCNT_ATOMIC
 
 /**
@@ -514,10 +518,9 @@ rte_mbuf_ext_refcnt_update(struct rte_mbuf_ext_shared_info *shinfo,
 
 
 /**
- * Sanity checks on an mbuf.
+ * Check that the mbuf is valid and panic if corrupted.
  *
- * Check the consistency of the given mbuf. The function will cause a
- * panic if corruption is detected.
+ * Acts assertion that mbuf is consistent. If not it calls rte_panic().
  *
  * @param m
  *   The mbuf to be checked.
@@ -526,13 +529,17 @@ rte_mbuf_ext_refcnt_update(struct rte_mbuf_ext_shared_info *shinfo,
  *   of a packet (in this case, some fields like nb_segs are not checked)
  */
 void
+rte_mbuf_verify(const struct rte_mbuf *m, int is_header);
+
+__rte_deprecated
+void
 rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header);
 
 /**
- * Sanity checks on a mbuf.
+ * Do consistency checks on a mbuf.
  *
- * Almost like rte_mbuf_sanity_check(), but this function gives the reason
- * if corruption is detected rather than panic.
+ * Check the consistency of the given mbuf and if not valid
+ * return the reason.
  *
  * @param m
  *   The mbuf to be checked.
@@ -551,7 +558,7 @@ int rte_mbuf_check(const struct rte_mbuf *m, int is_header,
 		   const char **reason);
 
 /**
- * Sanity checks on a reinitialized mbuf in debug mode.
+ * Do checks on a reinitialized mbuf in debug mode.
  *
  * Check the consistency of the given reinitialized mbuf.
  * The function will cause a panic if corruption is detected.
@@ -563,7 +570,7 @@ int rte_mbuf_check(const struct rte_mbuf *m, int is_header,
  *   The mbuf to be checked.
  */
 static __rte_always_inline void
-__rte_mbuf_raw_sanity_check(__rte_unused const struct rte_mbuf *m)
+__rte_mbuf_raw_verify(__rte_unused const struct rte_mbuf *m)
 {
 	RTE_ASSERT(rte_mbuf_refcnt_read(m) == 1);
 	RTE_ASSERT(m->next == NULL);
@@ -572,11 +579,11 @@ __rte_mbuf_raw_sanity_check(__rte_unused const struct rte_mbuf *m)
 	RTE_ASSERT(!RTE_MBUF_HAS_EXTBUF(m) ||
 			(RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
 			rte_mbuf_ext_refcnt_read(m->shinfo) == 1));
-	__rte_mbuf_sanity_check(m, 0);
+	__rte_mbuf_verify(m, 0);
 }
 
 /** For backwards compatibility. */
-#define MBUF_RAW_ALLOC_CHECK(m) __rte_mbuf_raw_sanity_check(m)
+#define MBUF_RAW_ALLOC_CHECK(m) __rte_mbuf_raw_verify(m)
 
 /**
  * Allocate an uninitialized mbuf from mempool *mp*.
@@ -606,7 +613,7 @@ static inline struct rte_mbuf *rte_mbuf_raw_alloc(struct rte_mempool *mp)
 
 	if (rte_mempool_get(mp, &ret.ptr) < 0)
 		return NULL;
-	__rte_mbuf_raw_sanity_check(ret.m);
+	__rte_mbuf_raw_verify(ret.m);
 	return ret.m;
 }
 
@@ -644,7 +651,7 @@ rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigne
 	int rc = rte_mempool_get_bulk(mp, (void **)mbufs, count);
 	if (likely(rc == 0))
 		for (unsigned int idx = 0; idx < count; idx++)
-			__rte_mbuf_raw_sanity_check(mbufs[idx]);
+			__rte_mbuf_raw_verify(mbufs[idx]);
 	return rc;
 }
 
@@ -665,7 +672,7 @@ rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigne
 static __rte_always_inline void
 rte_mbuf_raw_free(struct rte_mbuf *m)
 {
-	__rte_mbuf_raw_sanity_check(m);
+	__rte_mbuf_raw_verify(m);
 	rte_mempool_put(m->pool, m);
 }
 
@@ -700,7 +707,7 @@ rte_mbuf_raw_free_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned
 		const struct rte_mbuf *m = mbufs[idx];
 		RTE_ASSERT(m != NULL);
 		RTE_ASSERT(m->pool == mp);
-		__rte_mbuf_raw_sanity_check(m);
+		__rte_mbuf_raw_verify(m);
 	}
 
 	rte_mempool_put_bulk(mp, (void **)mbufs, count);
@@ -965,7 +972,7 @@ static inline void rte_pktmbuf_reset(struct rte_mbuf *m)
 	rte_pktmbuf_reset_headroom(m);
 
 	m->data_len = 0;
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 }
 
 /**
@@ -1021,22 +1028,22 @@ static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	switch (count % 4) {
 	case 0:
 		while (idx != count) {
-			__rte_mbuf_raw_sanity_check(mbufs[idx]);
+			__rte_mbuf_raw_verify(mbufs[idx]);
 			rte_pktmbuf_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 3:
-			__rte_mbuf_raw_sanity_check(mbufs[idx]);
+			__rte_mbuf_raw_verify(mbufs[idx]);
 			rte_pktmbuf_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 2:
-			__rte_mbuf_raw_sanity_check(mbufs[idx]);
+			__rte_mbuf_raw_verify(mbufs[idx]);
 			rte_pktmbuf_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 1:
-			__rte_mbuf_raw_sanity_check(mbufs[idx]);
+			__rte_mbuf_raw_verify(mbufs[idx]);
 			rte_pktmbuf_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
@@ -1267,8 +1274,8 @@ static inline void rte_pktmbuf_attach(struct rte_mbuf *mi, struct rte_mbuf *m)
 	mi->pkt_len = mi->data_len;
 	mi->nb_segs = 1;
 
-	__rte_mbuf_sanity_check(mi, 1);
-	__rte_mbuf_sanity_check(m, 0);
+	__rte_mbuf_verify(mi, 1);
+	__rte_mbuf_verify(m, 0);
 }
 
 /**
@@ -1423,7 +1430,7 @@ static inline int __rte_pktmbuf_pinned_extbuf_decref(struct rte_mbuf *m)
 static __rte_always_inline struct rte_mbuf *
 rte_pktmbuf_prefree_seg(struct rte_mbuf *m)
 {
-	__rte_mbuf_sanity_check(m, 0);
+	__rte_mbuf_verify(m, 0);
 
 	if (likely(rte_mbuf_refcnt_read(m) == 1)) {
 
@@ -1494,7 +1501,7 @@ static inline void rte_pktmbuf_free(struct rte_mbuf *m)
 	struct rte_mbuf *m_next;
 
 	if (m != NULL)
-		__rte_mbuf_sanity_check(m, 1);
+		__rte_mbuf_verify(m, 1);
 
 	while (m != NULL) {
 		m_next = m->next;
@@ -1575,7 +1582,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
  */
 static inline void rte_pktmbuf_refcnt_update(struct rte_mbuf *m, int16_t v)
 {
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	do {
 		rte_mbuf_refcnt_update(m, v);
@@ -1592,7 +1599,7 @@ static inline void rte_pktmbuf_refcnt_update(struct rte_mbuf *m, int16_t v)
  */
 static inline uint16_t rte_pktmbuf_headroom(const struct rte_mbuf *m)
 {
-	__rte_mbuf_sanity_check(m, 0);
+	__rte_mbuf_verify(m, 0);
 	return m->data_off;
 }
 
@@ -1606,7 +1613,7 @@ static inline uint16_t rte_pktmbuf_headroom(const struct rte_mbuf *m)
  */
 static inline uint16_t rte_pktmbuf_tailroom(const struct rte_mbuf *m)
 {
-	__rte_mbuf_sanity_check(m, 0);
+	__rte_mbuf_verify(m, 0);
 	return (uint16_t)(m->buf_len - rte_pktmbuf_headroom(m) -
 			  m->data_len);
 }
@@ -1621,7 +1628,7 @@ static inline uint16_t rte_pktmbuf_tailroom(const struct rte_mbuf *m)
  */
 static inline struct rte_mbuf *rte_pktmbuf_lastseg(struct rte_mbuf *m)
 {
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 	while (m->next != NULL)
 		m = m->next;
 	return m;
@@ -1665,7 +1672,7 @@ static inline struct rte_mbuf *rte_pktmbuf_lastseg(struct rte_mbuf *m)
 static inline char *rte_pktmbuf_prepend(struct rte_mbuf *m,
 					uint16_t len)
 {
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	if (unlikely(len > rte_pktmbuf_headroom(m)))
 		return NULL;
@@ -1700,7 +1707,7 @@ static inline char *rte_pktmbuf_append(struct rte_mbuf *m, uint16_t len)
 	void *tail;
 	struct rte_mbuf *m_last;
 
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	m_last = rte_pktmbuf_lastseg(m);
 	if (unlikely(len > rte_pktmbuf_tailroom(m_last)))
@@ -1728,7 +1735,7 @@ static inline char *rte_pktmbuf_append(struct rte_mbuf *m, uint16_t len)
  */
 static inline char *rte_pktmbuf_adj(struct rte_mbuf *m, uint16_t len)
 {
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	if (unlikely(len > m->data_len))
 		return NULL;
@@ -1760,7 +1767,7 @@ static inline int rte_pktmbuf_trim(struct rte_mbuf *m, uint16_t len)
 {
 	struct rte_mbuf *m_last;
 
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	m_last = rte_pktmbuf_lastseg(m);
 	if (unlikely(len > m_last->data_len))
@@ -1782,7 +1789,7 @@ static inline int rte_pktmbuf_trim(struct rte_mbuf *m, uint16_t len)
  */
 static inline int rte_pktmbuf_is_contiguous(const struct rte_mbuf *m)
 {
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 	return m->nb_segs == 1;
 }
 
diff --git a/lib/mbuf/version.map b/lib/mbuf/version.map
index 76f1832924..2950f24caa 100644
--- a/lib/mbuf/version.map
+++ b/lib/mbuf/version.map
@@ -31,6 +31,7 @@ DPDK_25 {
 	rte_mbuf_set_platform_mempool_ops;
 	rte_mbuf_set_user_mempool_ops;
 	rte_mbuf_user_mempool_ops;
+	rte_mbuf_verify;
 	rte_pktmbuf_clone;
 	rte_pktmbuf_copy;
 	rte_pktmbuf_dump;
-- 
2.47.2

