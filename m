Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69396C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B3F540A7F;
	Wed,  1 Jul 2026 18:21:40 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9151F406FF
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:37 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso658771b3a.2
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922897;
 x=1783527697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yo0QqI6IThR8H/FDs+3+zxmOPmgnNJmgm6hujCE5Ho=;
 b=Otl7RUWB4hzcJYoyuB9d4bgcAwhaEAhUkxGexXOrF2kXVO0u7xBdcPNFMkWK4his/g
 x6OBxy1W9MMjG3Zmof0rVOhyqLtDDRiJCcGlLxen/fTv510O9hnzJE3Ynt7+uyDij1Cr
 JOMhrc5WpCwvv7AImR/0p3X8ojDKGO20W4Qp8eVcc9kZR4TWo8MeBgQtOPlZcDIBeDb+
 Zqv/RYDKrZLSrWhGo2RUxMBJjr5yUIcdJpObwGE7qFJJuY0Ffz/q6zIo/Ylz06P5Meg7
 pt8fBBdcWZU7IUhcwwx6bQgxTo99xaTiSwpxEFAT+nPNiTdDbgWd2kbLSuRaMewJqcRj
 5KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922897; x=1783527697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7yo0QqI6IThR8H/FDs+3+zxmOPmgnNJmgm6hujCE5Ho=;
 b=DUHexAOhwuvurHwKFEt7aaKAVFSFGLwBuQ2ok2uj/rrXOCRr4UeMaWMOEBivxc8L7y
 OWNsD8bN6SZifbLMC0TbBAw5Je/kO4kLn4rjvU7RUW83oiF0DOnOvLLKhHoYcWksyRY3
 3z7w/C2YxqcnCxLYErwi25Y7WdndUOa8GQ3/AU9+1CqriFtrgFl7PVGNZt1NkcPnjM+h
 FE7EBZunzwqwDtX7cUclEK8vZbnZD/Iv8vOiOJxstlMqfARRzUt9SOvtV1MF1CUd/9YB
 FnSO/INN7995+L2n89TjWxi6jU2T+VdNdFUx3xURQwUYJVtCtHYhpqb52ws+OYSoT2tY
 tNeA==
X-Gm-Message-State: AOJu0Yxug83yradpJhKCVANJYWNpiIdpKUfewYsbsXO1jtNdF2Aek5On
 v2GYMrIGC4acOJRmrvQ+pQpiaKWsOOEyCu7MaLXfLlycyKuXvkT7Y6C/GsyxW17GpwIapNihSnR
 /uQy5
X-Gm-Gg: AfdE7cnhA6eo5ZqFDUh/YhteZqExLMcql4+NcCVfyXQAUJUGcY+2dXzxOwZVuzE47xr
 cPwXnCbtXpYfYWEj3ToABYtmXsXa6lByiYKtMAEGQnf8ZsKu40YFrErteAw/wtE6/93BigQ0iHJ
 /G+0pbCpJzjdp6UWeE4ND2P+IRpT8TNoSP8BfeBbimflvZ+3gxFwZmMAwfIdXPOipi3V0Viz44L
 vclP030kwI08jxJZrWs5sjJ8V9WLempf8ELKZKmDzNqd5pdLZ7Effqc1VGg9DbN5RjSdHzqM7Jp
 GlUuzkZNg09UyBMAsypYRtLdI5kvLsUSPZoWw/628qEhrTMbri36q5X9sd5gCsrzTfXpChmVZkA
 P6KZQ7pIJzwas309O24F9OEzIKZm/9ZStxdD1Yv3CkpbOvDr+IdJTATqVNWfFm8vG8X7UiZKzBw
 8crdEvGgFHTIQfNWOeimbFo8PU3tfnlJAGWLzR1dJBGgKW1RU2slY=
X-Received: by 2002:a05:6a20:d81a:b0:3b4:6f7e:d0f9 with SMTP id
 adf61e73a8af0-3bfed122dfbmr2519584637.3.1782922896315; 
 Wed, 01 Jul 2026 09:21:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 6/8] app/test: add test for IP reassembly
Date: Wed,  1 Jul 2026 09:20:31 -0700
Message-ID: <20260701162127.207318-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701162127.207318-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
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

There was no functional test for IPv4/IPv6 reassembly,
only a performance test. Add a new test  modeled on the Linux kernel
selftest tools/testing/selftests/net/ip_defrag.c. This is new
code so no license conflict.

Test covers:
size and fragment-size sweep across in-order, reverse,
odd/even and block delivery orders with byte-exact payload validation;
minimum 8-byte fragments; the fragment-count limit;
timeout of incomplete datagrams;
and the duplicate, overlap, extension-header and
oversized-fragment cases fixed earlier in this series.

The reassembled packet is checked with rte_mbuf_check() to catch
malformed segment chains in addition to wrong content.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build       |   1 +
 app/test/test_reassembly.c | 675 +++++++++++++++++++++++++++++++++++++
 2 files changed, 676 insertions(+)
 create mode 100644 app/test/test_reassembly.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 61024125a7..b8c2208d0b 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -160,6 +160,7 @@ source_file_deps = {
     'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
     'test_rcu_qsbr.c': ['rcu', 'hash'],
     'test_rcu_qsbr_perf.c': ['rcu', 'hash'],
+    'test_reassembly.c': ['net', 'ip_frag'],
     'test_reassembly_perf.c': ['net', 'ip_frag'],
     'test_reciprocal_division.c': [],
     'test_reciprocal_division_perf.c': [],
diff --git a/app/test/test_reassembly.c b/app/test/test_reassembly.c
new file mode 100644
index 0000000000..480de8d1dd
--- /dev/null
+++ b/app/test/test_reassembly.c
@@ -0,0 +1,675 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026
+ *
+ * Functional unit tests for the IP reassembly path of librte_ip_frag.
+ *
+ * Coverage mirrors the Linux selftest tools/testing/selftests/net/ip_defrag.c
+ * adapted to the library API and to DPDK-specific constraints:
+ *
+ *   - size / fragment-size sweep, bounded by RTE_LIBRTE_IP_FRAG_MAX_FRAG
+ *   - in-order, reverse, odd-then-even, and block-reordered delivery
+ *   - byte-exact validation of the reassembled payload (not just length)
+ *   - minimum (8-byte) fragments
+ *   - fragment-count boundary: exactly MAX reassembles, MAX + 1 fails
+ *   - incomplete datagram reaped on timeout
+ *   - zero-length fragment rejected
+ *   - duplicate fragment tolerated in a reordered set
+ *   - overlapping fragments (leading/trailing/contained) discarded
+ *   - IPv6 fragment with extension headers in the unfragmentable part dropped
+ *   - fragment whose end exceeds the maximum datagram size dropped
+ *
+ * The last four groups depend on the corresponding reassembly fixes
+ * (duplicate tolerance, overlap discard, extension-header drop, oversize
+ * drop); they pass once those are applied and fail on unpatched code. The
+ * remaining cases pass regardless.
+ *
+ * Fragments use l2_len == 0; the library reads the L3 header at offset 0.
+ */
+
+#include "test.h"
+
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_ip.h>
+#include <rte_ip_frag.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+
+#define NB_MBUF		1024
+#define MBUF_CACHE	0		/* exact accounting for leak checks */
+#define MBUF_DATA	2048
+#define V4_L3_LEN	((uint16_t)sizeof(struct rte_ipv4_hdr))
+#define V6_L3_LEN	((uint16_t)(sizeof(struct rte_ipv6_hdr) + \
+				    RTE_IPV6_FRAG_HDR_SIZE))
+#define TEST_ID		0x4242
+
+#ifndef RTE_LIBRTE_IP_FRAG_MAX_FRAG
+#define RTE_LIBRTE_IP_FRAG_MAX_FRAG 8
+#endif
+#define MAX_FRAG	RTE_LIBRTE_IP_FRAG_MAX_FRAG
+
+#define MAX_PAYLOAD	(MAX_FRAG * 256)	/* keeps a fragment in one mbuf */
+
+enum family { V4, V6 };
+enum order  { IN_ORDER, REVERSE, ODD_EVEN, BLOCK };
+
+struct frag_desc {
+	uint16_t ofs;	/* byte offset into the payload */
+	uint16_t plen;	/* payload bytes after L3 */
+	uint8_t  mf;
+};
+
+static struct rte_mempool *pkt_pool;
+
+/* position-dependent payload pattern, non-periodic at 256 so a misordered
+ * reassembly is detected even when lengths line up.
+ */
+static inline uint8_t
+pat(uint32_t k)
+{
+	return (uint8_t)(k * 31u + 7u);
+}
+
+/* ------------------------------- harness -------------------------------- */
+
+static int
+testsuite_setup(void)
+{
+	/* the table create/destroy per case is chatty at INFO level */
+	rte_log_set_level_pattern("lib.ip_frag", RTE_LOG_NOTICE);
+
+	pkt_pool = rte_pktmbuf_pool_create("REASM_POOL", NB_MBUF, MBUF_CACHE,
+					   0, MBUF_DATA, SOCKET_ID_ANY);
+	return pkt_pool == NULL ? TEST_FAILED : TEST_SUCCESS;
+}
+
+static void
+testsuite_teardown(void)
+{
+	rte_mempool_free(pkt_pool);
+	pkt_pool = NULL;
+}
+
+/* Every case must start and end with a full pool, so a leak in one case is
+ * pinpointed here rather than silently masking the next one.
+ */
+static int
+ut_setup(void)
+{
+	if (rte_mempool_avail_count(pkt_pool) != NB_MBUF) {
+		printf("pool not full at case start: %u/%u\n",
+		       rte_mempool_avail_count(pkt_pool), NB_MBUF);
+		return TEST_FAILED;
+	}
+	return TEST_SUCCESS;
+}
+
+static struct rte_ip_frag_tbl *
+tbl_new(uint64_t max_cycles)
+{
+	return rte_ip_frag_table_create(16, MAX_FRAG, 16, max_cycles,
+					rte_socket_id());
+}
+
+/* Build one fragment with a position-dependent payload. */
+static struct rte_mbuf *
+build_frag(enum family fam, uint16_t ofs, uint16_t plen, uint8_t mf)
+{
+	struct rte_mbuf *m = rte_pktmbuf_alloc(pkt_pool);
+	uint16_t l3 = (fam == V4) ? V4_L3_LEN : V6_L3_LEN;
+	char *p;
+	uint16_t i;
+
+	if (m == NULL)
+		return NULL;
+	m->data_off = 0;
+
+	if (fam == V4) {
+		struct rte_ipv4_hdr *ip = rte_pktmbuf_mtod(m,
+						struct rte_ipv4_hdr *);
+		uint16_t fo = ofs / RTE_IPV4_HDR_OFFSET_UNITS;
+
+		memset(ip, 0, V4_L3_LEN);
+		if (mf)
+			fo |= RTE_IPV4_HDR_MF_FLAG;
+		ip->version_ihl = 0x45;
+		ip->total_length = rte_cpu_to_be_16(V4_L3_LEN + plen);
+		ip->packet_id = rte_cpu_to_be_16(TEST_ID);
+		ip->fragment_offset = rte_cpu_to_be_16(fo);
+		ip->time_to_live = 64;
+		ip->next_proto_id = IPPROTO_UDP;
+		ip->src_addr = rte_cpu_to_be_32(0x0a000001);
+		ip->dst_addr = rte_cpu_to_be_32(0x0a000002);
+	} else {
+		struct rte_ipv6_hdr *ip = rte_pktmbuf_mtod(m,
+						struct rte_ipv6_hdr *);
+		struct rte_ipv6_fragment_ext *fh =
+			rte_pktmbuf_mtod_offset(m,
+				struct rte_ipv6_fragment_ext *,
+				sizeof(struct rte_ipv6_hdr));
+
+		memset(ip, 0, V6_L3_LEN);
+		ip->vtc_flow = rte_cpu_to_be_32(6u << 28);
+		ip->payload_len = rte_cpu_to_be_16(RTE_IPV6_FRAG_HDR_SIZE + plen);
+		ip->proto = IPPROTO_FRAGMENT;
+		ip->hop_limits = 64;
+		ip->src_addr.a[15] = 1;
+		ip->dst_addr.a[15] = 2;
+		fh->next_header = IPPROTO_UDP;
+		fh->reserved = 0;
+		fh->frag_data = rte_cpu_to_be_16(
+				RTE_IPV6_SET_FRAG_DATA(ofs, mf ? 1 : 0));
+		fh->id = rte_cpu_to_be_32(TEST_ID);
+	}
+
+	p = rte_pktmbuf_mtod_offset(m, char *, l3);
+	for (i = 0; i < plen; i++)
+		p[i] = (char)pat(ofs + i);
+
+	m->data_len = m->pkt_len = l3 + plen;
+	m->l2_len = 0;
+	m->l3_len = l3;
+	return m;
+}
+
+static struct rte_mbuf *
+feed(enum family fam, struct rte_ip_frag_tbl *tbl,
+	struct rte_ip_frag_death_row *dr, const struct frag_desc *d, uint64_t tms)
+{
+	struct rte_mbuf *m = build_frag(fam, d->ofs, d->plen, d->mf);
+
+	if (m == NULL)
+		return NULL;
+	if (fam == V4) {
+		struct rte_ipv4_hdr *ip = rte_pktmbuf_mtod(m, struct rte_ipv4_hdr *);
+		return rte_ipv4_frag_reassemble_packet(tbl, dr, m, tms, ip);
+	} else {
+		struct rte_ipv6_hdr *ip = rte_pktmbuf_mtod(m, struct rte_ipv6_hdr *);
+		struct rte_ipv6_fragment_ext *fh =
+			rte_pktmbuf_mtod_offset(m, struct rte_ipv6_fragment_ext *,
+						sizeof(struct rte_ipv6_hdr));
+		return rte_ipv6_frag_reassemble_packet(tbl, dr, m, tms, ip, fh);
+	}
+}
+
+/* Split a datagram of total_plen into fragments of frag_size (multiple of 8).
+ * Returns the fragment count, or -1 if it would exceed MAX_FRAG.
+ */
+static int
+make_datagram(uint16_t total_plen, uint16_t frag_size, struct frag_desc *out)
+{
+	int n = 0;
+	uint16_t ofs = 0;
+
+	while (ofs < total_plen) {
+		uint16_t rem = total_plen - ofs;
+		uint16_t len = rem <= frag_size ? rem : frag_size;
+
+		if (n >= MAX_FRAG)
+			return -1;
+		out[n].ofs = ofs;
+		out[n].plen = len;
+		out[n].mf = (ofs + len < total_plen);
+		ofs += len;
+		n++;
+	}
+	return n;
+}
+
+/* Produce a delivery order (array of indices into descs). */
+static void
+make_order(enum order ord, int n, int *idx)
+{
+	int i, k = 0;
+
+	switch (ord) {
+	case IN_ORDER:
+		for (i = 0; i < n; i++)
+			idx[i] = i;
+		break;
+	case REVERSE:
+		for (i = 0; i < n; i++)
+			idx[i] = n - 1 - i;
+		break;
+	case ODD_EVEN:
+		for (i = 1; i < n; i += 2)
+			idx[k++] = i;
+		for (i = 0; i < n; i += 2)
+			idx[k++] = i;
+		break;
+	case BLOCK: {
+		int t = n / 3 ? n / 3 : 1;
+
+		for (i = 2 * t; i < n; i++)
+			idx[k++] = i;
+		for (i = t; i < 2 * t && i < n; i++)
+			idx[k++] = i;
+		for (i = 0; i < t && i < n; i++)
+			idx[k++] = i;
+		break;
+	}
+	}
+}
+
+/* Feed descs in the given order; return reassembled mbuf or NULL. */
+static struct rte_mbuf *
+run_ordered(enum family fam, const struct frag_desc *descs, int n,
+	    const int *idx)
+{
+	struct rte_ip_frag_death_row dr;
+	struct rte_ip_frag_tbl *tbl;
+	struct rte_mbuf *out = NULL;
+	uint64_t tms = rte_rdtsc();
+	int i;
+
+	memset(&dr, 0, sizeof(dr));
+	tbl = tbl_new(rte_get_tsc_hz());
+	if (tbl == NULL)
+		return NULL;
+	for (i = 0; i < n; i++) {
+		struct rte_mbuf *r = feed(fam, tbl, &dr, &descs[idx[i]], tms);
+
+		if (r != NULL)
+			out = r;
+	}
+	rte_ip_frag_free_death_row(&dr, 0);
+	rte_ip_frag_table_destroy(tbl);
+	return out;
+}
+
+/* Validate length and byte-exact payload, then free. Returns 0 on success.
+ * Note: reassembly strips the IPv6 fragment header, so the reassembled v6
+ * header is sizeof(rte_ipv6_hdr), not the V6_L3_LEN the fragments were built
+ * with. v4 has no fragment header to remove.
+ */
+static int
+validate(struct rte_mbuf *m, enum family fam, uint16_t total_plen)
+{
+	uint16_t l3 = (fam == V4) ? V4_L3_LEN :
+				    (uint16_t)sizeof(struct rte_ipv6_hdr);
+	uint8_t buf[MAX_PAYLOAD];
+	const uint8_t *p;
+	const char *reason;
+	uint16_t k;
+	int rc = 0;
+
+	if (m == NULL)
+		return -1;
+	if (rte_mbuf_check(m, 1, &reason) != 0) {
+		printf("  bad mbuf fam=%d total=%u: %s\n", fam, total_plen,
+		       reason);
+		rte_pktmbuf_free(m);
+		return -1;
+	}
+	if (m->pkt_len != (uint32_t)(l3 + total_plen)) {
+		rte_pktmbuf_free(m);
+		return -1;
+	}
+	p = rte_pktmbuf_read(m, l3, total_plen, buf);
+	if (p == NULL) {
+		rte_pktmbuf_free(m);
+		return -1;
+	}
+	for (k = 0; k < total_plen; k++) {
+		if (p[k] != pat(k)) {
+			rc = -1;
+			break;
+		}
+	}
+	rte_pktmbuf_free(m);
+	return rc;
+}
+
+/* --------------------------- baseline / sweep --------------------------- */
+
+static int
+sweep_one(enum family fam, uint16_t total_plen, uint16_t frag_size)
+{
+	struct frag_desc descs[MAX_FRAG];
+	int idx[MAX_FRAG];
+	const enum order orders[] = { IN_ORDER, REVERSE, ODD_EVEN, BLOCK };
+	int n = make_datagram(total_plen, frag_size, descs);
+	unsigned int o;
+
+	if (n < 2)		/* skip single-fragment / oversized for sweep */
+		return 0;
+
+	for (o = 0; o < RTE_DIM(orders); o++) {
+		make_order(orders[o], n, idx);
+		if (validate(run_ordered(fam, descs, n, idx), fam,
+			     total_plen) != 0) {
+			printf("  sweep fail: fam=%d total=%u fs=%u order=%u n=%d\n",
+			       fam, total_plen, frag_size, orders[o], n);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int
+sweep(enum family fam)
+{
+	const uint16_t fsizes[] = { 8, 16, 64, 256 };
+	unsigned int f;
+
+	for (f = 0; f < RTE_DIM(fsizes); f++) {
+		uint16_t fs = fsizes[f];
+		uint16_t total;
+
+		/* cover 2..MAX_FRAG fragments, last fragment partial */
+		for (total = fs + 8; total <= fs * MAX_FRAG; total += fs) {
+			if (sweep_one(fam, total, fs) != 0)
+				return TEST_FAILED;
+			if (total > fs + 4 &&
+			    sweep_one(fam, total - 4, fs) != 0)
+				return TEST_FAILED;
+		}
+	}
+	return TEST_SUCCESS;
+}
+
+static int test_sweep_v4(void) { return sweep(V4); }
+static int test_sweep_v6(void) { return sweep(V6); }
+
+/* Minimum 8-byte fragments. */
+static int
+test_min_fragment(void)
+{
+	struct frag_desc d[3] = {
+		{ 0, 8, 1 }, { 8, 8, 1 }, { 16, 8, 0 },
+	};
+	int idx[3];
+
+	make_order(REVERSE, 3, idx);
+	TEST_ASSERT_SUCCESS(validate(run_ordered(V4, d, 3, idx), V4, 24),
+				"min 8-byte fragments not reassembled");
+	make_order(ODD_EVEN, 3, idx);
+	TEST_ASSERT_SUCCESS(validate(run_ordered(V6, d, 3, idx), V6, 24),
+				"min 8-byte fragments not reassembled (v6)");
+	return TEST_SUCCESS;
+}
+
+/* Exactly MAX_FRAG fragments reassembles; MAX_FRAG + 1 fails. */
+static int
+test_cap_boundary(void)
+{
+	struct frag_desc d[MAX_FRAG + 1];
+	int idx[MAX_FRAG + 1];
+	uint16_t fs = 8, total = fs * MAX_FRAG;
+	int n, i;
+
+	n = make_datagram(total, fs, d);
+	TEST_ASSERT_EQUAL(n, MAX_FRAG, "expected MAX_FRAG fragments");
+	make_order(IN_ORDER, n, idx);
+	TEST_ASSERT_SUCCESS(validate(run_ordered(V4, d, n, idx), V4, total),
+				"MAX_FRAG fragments should reassemble");
+
+	/* one more fragment than the table can hold */
+	for (i = 0; i <= MAX_FRAG; i++) {
+		d[i].ofs = i * fs;
+		d[i].plen = fs;
+		d[i].mf = (i < MAX_FRAG);
+		idx[i] = i;
+	}
+	TEST_ASSERT_NULL(run_ordered(V4, d, MAX_FRAG + 1, idx),
+			     "MAX_FRAG + 1 fragments should not reassemble");
+	TEST_ASSERT_EQUAL(rte_mempool_avail_count(pkt_pool), NB_MBUF,
+			      "overflowing set leaked mbufs");
+	return TEST_SUCCESS;
+}
+
+/* Incomplete datagram: no output, reaped on timeout. */
+static int
+test_incomplete_timeout(void)
+{
+	struct rte_ip_frag_death_row dr;
+	struct rte_ip_frag_tbl *tbl;
+	uint64_t mc = rte_get_tsc_hz(), tms = rte_rdtsc();
+	struct frag_desc d[2] = { { 0, 64, 1 }, { 128, 64, 0 } }; /* gap */
+	struct rte_mbuf *out = NULL;
+	int i;
+
+	memset(&dr, 0, sizeof(dr));
+	tbl = tbl_new(mc);
+	TEST_ASSERT_NOT_NULL(tbl, "table create failed");
+	for (i = 0; i < 2; i++) {
+		struct rte_mbuf *r = feed(V4, tbl, &dr, &d[i], tms);
+
+		if (r != NULL)
+			out = r;
+	}
+	TEST_ASSERT_NULL(out, "incomplete datagram reassembled");
+	rte_ip_frag_table_del_expired_entries(tbl, &dr, tms + mc + 1);
+	rte_ip_frag_free_death_row(&dr, 0);
+	rte_ip_frag_table_destroy(tbl);
+	TEST_ASSERT_EQUAL(rte_mempool_avail_count(pkt_pool), NB_MBUF,
+			      "expired fragments not freed");
+	return TEST_SUCCESS;
+}
+
+static int
+test_zero_len(void)
+{
+	struct frag_desc d = { 0, 0, 1 };
+	int idx = 0;
+
+	TEST_ASSERT_NULL(run_ordered(V4, &d, 1, &idx),
+			     "zero-length fragment accepted");
+	TEST_ASSERT_EQUAL(rte_mempool_avail_count(pkt_pool), NB_MBUF,
+			      "zero-length fragment leaked");
+	return TEST_SUCCESS;
+}
+
+/* --------------------- duplicate / overlap / reject --------------------- */
+
+/* A duplicate anywhere in a reordered set must not break reassembly. */
+static int
+test_dup_tolerated(void)
+{
+	/* offsets 0,64,128,192 with 64B frags; inject a dup of frag 1 */
+	struct frag_desc d[5] = {
+		{   0, 64, 1 }, {  64, 64, 1 }, {  64, 64, 1 }, /* dup */
+		{ 128, 64, 1 }, { 192, 64, 0 },
+	};
+	int idx[5] = { 1, 4, 2, 0, 3 };	/* reordered, dup interleaved */
+
+	TEST_ASSERT_SUCCESS(validate(run_ordered(V4, d, 5, idx), V4, 256),
+				"duplicate fragment broke reassembly");
+	return TEST_SUCCESS;
+}
+
+/* Overlap geometries; the datagram must be discarded and every collected
+ * fragment freed. The last fragment is withheld so that on unfixed code the
+ * entry is *retained* (total_size stays UINT32_MAX) rather than torn down by
+ * the frag_size > total_size path: that retention is what we detect. We
+ * capture the mbufs still held in the table after draining the death row,
+ * before destroying the table (destroy frees held mbufs, hiding the leak).
+ */
+static int
+overlap_case(enum family fam, const struct frag_desc *d, int n, const char *what)
+{
+	struct rte_ip_frag_death_row dr;
+	struct rte_ip_frag_tbl *tbl;
+	struct rte_mbuf *out = NULL;
+	uint64_t tms = rte_rdtsc();
+	unsigned int held;
+	int i;
+
+	memset(&dr, 0, sizeof(dr));
+	tbl = tbl_new(rte_get_tsc_hz());
+	if (tbl == NULL)
+		return -1;
+	for (i = 0; i < n; i++) {
+		struct rte_mbuf *r = feed(fam, tbl, &dr, &d[i], tms);
+
+		if (r != NULL)
+			out = r;
+	}
+	rte_ip_frag_free_death_row(&dr, 0);
+	held = NB_MBUF - rte_mempool_avail_count(pkt_pool);
+	rte_ip_frag_table_destroy(tbl);
+
+	if (out != NULL) {
+		rte_pktmbuf_free(out);
+		printf("  overlap reassembled instead of discarded: %s\n", what);
+		return -1;
+	}
+	if (held != 0) {
+		printf("  overlap kept %u fragment(s) instead of discarding: %s\n",
+		       held, what);
+		return -1;
+	}
+	return 0;
+}
+
+static int
+test_overlap(void)
+{
+	/* last fragment withheld in every case (all MF=1) */
+
+	/* overlapping fragment arrives second */
+	const struct frag_desc tail[2] = { { 0, 600, 1 }, { 300, 600, 1 } };
+	/* overlapping fragment arrives first */
+	const struct frag_desc head[2] = { { 300, 600, 1 }, { 0, 600, 1 } };
+	/* a fragment fully contained in an existing one */
+	const struct frag_desc cont[2] = { { 0, 600, 1 }, { 200, 200, 1 } };
+
+	TEST_ASSERT_SUCCESS(overlap_case(V6, tail, 2, "v6 overlap second"), "");
+	TEST_ASSERT_SUCCESS(overlap_case(V6, head, 2, "v6 overlap first"), "");
+	TEST_ASSERT_SUCCESS(overlap_case(V6, cont, 2, "v6 contained"), "");
+	TEST_ASSERT_SUCCESS(overlap_case(V4, tail, 2, "v4 overlap second"), "");
+	return TEST_SUCCESS;
+}
+
+/*
+ * An IPv6 fragment whose fragment header does not directly follow the base
+ * header (a per-fragment extension header precedes it) is dropped, not stored.
+ * Build base hdr + an 8-byte routing header + fragment header, and pass the
+ * fragment header at its real offset (48), so the library sees frag_hdr !=
+ * ip_hdr + 1. Captures whether the fragment is still held in the table after
+ * the death row is drained but before the table is destroyed.
+ */
+static int
+test_v6_ext_header_drop(void)
+{
+	struct rte_ip_frag_death_row dr;
+	struct rte_ip_frag_tbl *tbl;
+	struct rte_mbuf *m, *r;
+	struct rte_ipv6_hdr *ip;
+	struct rte_ipv6_fragment_ext *fh;
+	uint8_t *rthdr;
+	unsigned int held;
+	const uint16_t plen = 64;
+	const uint16_t ext = 8;	/* one 8-byte routing header */
+
+	memset(&dr, 0, sizeof(dr));
+	tbl = tbl_new(rte_get_tsc_hz());
+	TEST_ASSERT_NOT_NULL(tbl, "table create failed");
+
+	m = rte_pktmbuf_alloc(pkt_pool);
+	TEST_ASSERT_NOT_NULL(m, "alloc failed");
+	m->data_off = 0;
+	ip = rte_pktmbuf_mtod(m, struct rte_ipv6_hdr *);
+	memset(ip, 0, sizeof(*ip));
+	ip->vtc_flow = rte_cpu_to_be_32(6u << 28);
+	ip->payload_len = rte_cpu_to_be_16(ext + RTE_IPV6_FRAG_HDR_SIZE + plen);
+	ip->proto = IPPROTO_ROUTING;	/* per-fragment header before frag hdr */
+	ip->hop_limits = 64;
+	ip->src_addr.a[15] = 1;
+	ip->dst_addr.a[15] = 2;
+
+	/* 8-byte routing header, next = fragment */
+	rthdr = rte_pktmbuf_mtod_offset(m, uint8_t *, sizeof(*ip));
+	memset(rthdr, 0, ext);
+	rthdr[0] = IPPROTO_FRAGMENT;	/* next header */
+	rthdr[1] = 0;			/* hdr ext len: (0 + 1) * 8 = 8 bytes */
+
+	/* fragment header at offset 48, not 40 */
+	fh = rte_pktmbuf_mtod_offset(m, struct rte_ipv6_fragment_ext *,
+				     sizeof(*ip) + ext);
+	fh->next_header = IPPROTO_UDP;
+	fh->reserved = 0;
+	fh->frag_data = rte_cpu_to_be_16(RTE_IPV6_SET_FRAG_DATA(0, 1));
+	fh->id = rte_cpu_to_be_32(TEST_ID);
+
+	m->data_len = m->pkt_len = sizeof(*ip) + ext + RTE_IPV6_FRAG_HDR_SIZE +
+				   plen;
+	m->l2_len = 0;
+	m->l3_len = sizeof(*ip) + ext + RTE_IPV6_FRAG_HDR_SIZE;
+
+	r = rte_ipv6_frag_reassemble_packet(tbl, &dr, m, rte_rdtsc(), ip, fh);
+	rte_ip_frag_free_death_row(&dr, 0);
+	held = NB_MBUF - rte_mempool_avail_count(pkt_pool);
+	rte_ip_frag_table_destroy(tbl);
+
+	TEST_ASSERT_NULL(r, "fragment with per-fragment header accepted");
+	TEST_ASSERT_EQUAL(held, 0,
+			  "per-fragment-header fragment stored instead of dropped");
+	return TEST_SUCCESS;
+}
+
+/* A fragment whose end exceeds the max datagram size is dropped, not stored. */
+static int
+oversize_drop_one(enum family fam)
+{
+	struct rte_ip_frag_death_row dr;
+	struct rte_ip_frag_tbl *tbl;
+	struct frag_desc d = { 0xFFF8, 64, 0 };	/* offset 65528 + 64 > 65535 */
+	struct rte_mbuf *r;
+	unsigned int held;
+
+	memset(&dr, 0, sizeof(dr));
+	tbl = tbl_new(rte_get_tsc_hz());
+	if (tbl == NULL)
+		return -1;
+	r = feed(fam, tbl, &dr, &d, rte_rdtsc());
+	rte_ip_frag_free_death_row(&dr, 0);
+	held = NB_MBUF - rte_mempool_avail_count(pkt_pool);
+	rte_ip_frag_table_destroy(tbl);
+
+	if (r != NULL) {
+		rte_pktmbuf_free(r);
+		return -1;
+	}
+	return held == 0 ? 0 : -1;
+}
+
+static int
+test_oversize_drop(void)
+{
+	TEST_ASSERT_SUCCESS(oversize_drop_one(V4),
+			    "oversized v4 fragment stored instead of dropped");
+	TEST_ASSERT_SUCCESS(oversize_drop_one(V6),
+			    "oversized v6 fragment stored instead of dropped");
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite reassembly_testsuite = {
+	.suite_name = "IP Reassembly Unit Test Suite",
+	.setup = testsuite_setup,
+	.teardown = testsuite_teardown,
+	.unit_test_cases = {
+		TEST_CASE_ST(ut_setup, NULL, test_sweep_v4),
+		TEST_CASE_ST(ut_setup, NULL, test_sweep_v6),
+		TEST_CASE_ST(ut_setup, NULL, test_min_fragment),
+		TEST_CASE_ST(ut_setup, NULL, test_cap_boundary),
+		TEST_CASE_ST(ut_setup, NULL, test_incomplete_timeout),
+		TEST_CASE_ST(ut_setup, NULL, test_zero_len),
+		TEST_CASE_ST(ut_setup, NULL, test_dup_tolerated),
+		TEST_CASE_ST(ut_setup, NULL, test_overlap),
+		TEST_CASE_ST(ut_setup, NULL, test_v6_ext_header_drop),
+		TEST_CASE_ST(ut_setup, NULL, test_oversize_drop),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_reassembly(void)
+{
+	return unit_test_suite_runner(&reassembly_testsuite);
+}
+
+REGISTER_FAST_TEST(reassembly_autotest, NOHUGE_OK, ASAN_OK, test_reassembly);
-- 
2.53.0

