Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7672C4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2775740B90;
	Wed, 22 Jul 2026 20:34:08 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 95F1340A75
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:34:04 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca957432c7fso8842352a12.1
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745244;
 x=1785350044; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l47sohPS41wmMa6/tOSxhcAYzM54Qe0KMKvx+BCVYpw=;
 b=mfP5/3PNqWQDfwGAxQKVDh2J+fIXuaMVsXO5jMLs/4tt1q9r2duIF5KK9foq0PjNuY
 EngkfCbYWiIuOFMZjqO9QTnmrkitb6LmGgcdgCen+hYcgvmIUbwYHKVMPQICj8FQpdHO
 DRcHvVzVKEmzVT+2Q5CowU5zwOOFnzlrKJSXiItpMel8kkNpOC6Ev+cW7iPmcgSvngon
 EJj6BT/DbybmfspPSB2xJ/a+MxgBb720PTs7dNAOy+J/68t/ruK+3bBhqomX2v+jKMz/
 yLHh/Dd2m47fS5wd73eQhy3sGDBMCvKXZyFVc/+6chyIu8BqEaC1NhMBjXxkvI8dguIO
 Zf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745244; x=1785350044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l47sohPS41wmMa6/tOSxhcAYzM54Qe0KMKvx+BCVYpw=;
 b=QfgG/dn8/bwyyTNxz8CvcK0t+Uw9MApiVAJKI3mz+wEGeK2Nq4BJwM9l4g4OQAE3ar
 DI2FDxYJaVP+YebFyyNjveej8Br2Eoq+xt/UHRTdciVpsOeiZJaNnX/RQ6CrTw7JJaG4
 elr9Da2x/O4WDHwheodmQCWefCU+V1Rh8E2a+W74kTNUF3GNEVxKO9W77VUyyooDg3if
 WbwrjfI3zuv/+ix1TDKA1W3iZOm3w8gWDTk8B5eMqVDUl9wUJxbsu4ywzXsze4p/q2Da
 ZV+6T94lu86NNl4tFtDhjraAUXyWxwcKUqLrLFx3jNBtPin3ynq6hanwf9jGZlGOmphE
 gDqA==
X-Gm-Message-State: AOJu0YxY3m/unpoTsOrBIteKK5DJ0nWvWFF0/izBqT4XSIfHh3yGhZZJ
 e326X8ZJkyi0IesE7H5e1+LGj4RkCutzsES6p584ALXcaIV9QOQufkHtE2JBoMsieHsX3JnbFPi
 RJGzN
X-Gm-Gg: AR+sD13Tm9teav7rIMLZrkbq5ah50TL7s2R5Hqs79vBUgUeX4HgciFfU7gcHJdDtZjL
 VzDgm7aW7AWJAzi6Ooe2ZuyRUQmPgD30wy29zOQx3IkepWL8XyBjZLsBSACQJgyTsHODlUCpHxl
 YZwxk6YpyWjD7zo80Rf1Vs6c9QIIAOZ1+UVsneDGTpjd3qjglU+rwnA8gWfgYkCbvttCjJsUhfi
 4JEJPHy8EceUgwg1h0q1cLa2ixD2d4Vn/TCYKKYwjiDyW9otFS83imjeKIIa4oRdF7qUabcOVVt
 Z7Qxte3jYKKBxkE8STsiGGVbmGavuyyorTQKJouh2Nf0xJAAUN3IdiZ1VIV36tXqk3eV1waD5YS
 ATQVZi8INIWOMehKPv6660UhHUuysHwSVkcebWcpSNjeI5gHDk8jYsDfJJUXkaah0W8w3CisjKn
 v801AOTMpfIRSiK1a6Umnph4lTQs/G2i2pCisEEi/v
X-Received: by 2002:a17:902:ce89:b0:2ca:481:de45 with SMTP id
 d9443c01a7336-2cfa6b7cfc3mr632245ad.6.1784745243717; 
 Wed, 22 Jul 2026 11:34:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:34:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v7 09/10] test/bpf: check that bpf_convert can be JIT'd
Date: Wed, 22 Jul 2026 09:05:21 -0700
Message-ID: <20260722183351.633025-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722183351.633025-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260722183351.633025-1-stephen@networkplumber.org>
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

Run each converted filter through both the interpreter and the JIT and
check they agree, catching JIT miscompiles.

test_bpf_filter and test_bpf_match did nearly the same thing: compile,
load and run a filter against the dummy packet. Combine them into
test_bpf_match, which now builds the packet itself and returns whether
the filter matched. Callers run it for both load methods.

The dummy packet is a UDP packet to a fixed destination MAC, source
and destination ports, so the filter results are deterministic. None
of the sample filters should match it, so assert that; a convert or
JIT bug that flips a result is then caught. The destination MAC and
source port are chosen so the negative ethernet and port filters do
not match, and "port not 53 and not arp" is dropped as it matches
any non-ARP packet that lacks port 53.

Reduce log output to make it easier to match which expression might be
causing issues.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_bpf.c | 171 ++++++++++++++++++++++++++------------------
 1 file changed, 100 insertions(+), 71 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 184438a549..d85e64e7fb 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -32,6 +32,7 @@ test_bpf(void)
 #include <rte_bpf.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
+#include <rte_udp.h>
 
 
 /* Tests of most simple BPF programs (no instructions, one instruction etc.) */
@@ -4855,11 +4856,13 @@ load_cbpf_program_convert(struct bpf_program *cbpf_program, const char *str)
 		return NULL;
 	}
 
+#ifdef DEBUG
 	printf("bpf convert(\"%s\") produced:\n", str);
 	rte_bpf_dump(stdout, prm->ins, prm->nb_ins);
 
 	printf("%s \"%s\"\n", __func__, str);
 	test_bpf_dump(cbpf_program, prm);
+#endif
 
 	bpf = rte_bpf_load(prm);
 	rte_free(prm);
@@ -4884,18 +4887,65 @@ load_cbpf_program_direct(struct bpf_program *cbpf_program, const char *str __rte
 	});
 }
 
+static const load_cbpf_program_t cbpf_program_loaders[] = {
+	load_cbpf_program_convert,
+	load_cbpf_program_direct,
+};
+
+/* Setup Ethernet/IP/UDP headers in a dummy packet buffer for filter tests */
+static void
+dummy_ip_prep(void *data, uint16_t plen)
+{
+	struct {
+		struct rte_ether_hdr eth_hdr;
+		struct rte_ipv4_hdr ip_hdr;
+		struct rte_udp_hdr udp_hdr;
+	} *hdr = data;
+
+	hdr->eth_hdr = (struct rte_ether_hdr) {
+		.dst_addr.addr_bytes = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e },
+		.ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
+	};
+	hdr->ip_hdr = (struct rte_ipv4_hdr) {
+		.version_ihl = RTE_IPV4_VHL_DEF,
+		.total_length = rte_cpu_to_be_16(plen),
+		.time_to_live = IPDEFTTL,
+		.next_proto_id = IPPROTO_UDP,
+		.src_addr = rte_cpu_to_be_32(RTE_IPV4_LOOPBACK),
+		.dst_addr = rte_cpu_to_be_32(RTE_IPV4_BROADCAST),
+	};
+	hdr->udp_hdr = (struct rte_udp_hdr) {
+		.src_port = rte_cpu_to_be_16(49152),	/* fixed, avoids filter ports */
+		.dst_port = rte_cpu_to_be_16(9),	/* discard port */
+		.dgram_len = rte_cpu_to_be_16(plen - sizeof(struct rte_ipv4_hdr)),
+		.dgram_cksum = 0,
+	};
+}
+
+/*
+ * Compile a pcap filter, load it with the given loader, then run it against
+ * a standard dummy packet with both the interpreter and (when available) the
+ * JIT, checking the two agree.
+ *
+ * Returns 1 if the filter matched, 0 if it did not, and -1 on any error
+ * (compile, load, or interpreter/JIT mismatch).
+ */
 static int
-test_bpf_match(pcap_t *pcap, const char *str, struct rte_mbuf *mb,
+test_bpf_match(pcap_t *pcap, const char *str,
 	load_cbpf_program_t load_cbpf_program)
 {
+	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
+	const uint32_t plen = 100;
 	struct bpf_program fcode;
-	struct rte_bpf *bpf;
+	struct rte_mbuf mb = { 0 };
+	struct rte_bpf *bpf = NULL;
 	int ret = -1;
 	uint64_t rc;
 
+	printf("%s '%s'\n", __func__, str);
 	if (pcap_compile(pcap, &fcode, str, 1, PCAP_NETMASK_UNKNOWN)) {
 		printf("%s@%d: pcap_compile(\"%s\") failed: %s;\n",
-		       __func__, __LINE__,  str, pcap_geterr(pcap));
+		       __func__, __LINE__, str, pcap_geterr(pcap));
 		return -1;
 	}
 
@@ -4903,15 +4953,41 @@ test_bpf_match(pcap_t *pcap, const char *str, struct rte_mbuf *mb,
 	if (bpf == NULL) {
 		printf("%s@%d: failed to load cbpf program for \"%s\", error=%d(%s);\n",
 			__func__, __LINE__, str, rte_errno, strerror(rte_errno));
+		test_bpf_dump(&fcode, NULL);
 		goto error;
 	}
 
-	rc = rte_bpf_exec(bpf, mb);
-	/* The return code from bpf capture filter is non-zero if matched */
-	ret = (rc == 0);
+	dummy_mbuf_prep(&mb, tbuf, sizeof(tbuf), plen);
+	dummy_ip_prep(rte_pktmbuf_mtod(&mb, void *), plen);
+
+	rc = rte_bpf_exec(bpf, &mb);
+
+	/* Verify the JIT, when available, produces the same result. */
+	{
+		struct rte_bpf_jit jit;
+
+		rte_bpf_get_jit(bpf, &jit);
+		if (jit.func != NULL) {
+			fflush(stdout);
+			if (jit.func(&mb) != rc) {
+				printf("%s@%d: JIT return code does not match\n",
+				       __func__, __LINE__);
+				goto error;
+			}
+		}
+#ifdef RTE_BPF_JIT_SUPPORTED
+		else {
+			printf("%s@%d: no JIT code generated\n",
+			       __func__, __LINE__);
+			goto error;
+		}
+#endif
+	}
+
+	/* The return code from a bpf capture filter is non-zero if matched. */
+	ret = (rc != 0);
 error:
-	if (bpf)
-		rte_bpf_destroy(bpf);
+	rte_bpf_destroy(bpf);
 	pcap_freecode(&fcode);
 	return ret;
 }
@@ -4920,44 +4996,13 @@ test_bpf_match(pcap_t *pcap, const char *str, struct rte_mbuf *mb,
 static int
 test_bpf_filter_sanity(pcap_t *pcap)
 {
-	static const load_cbpf_program_t cbpf_program_loaders[] = {
-		load_cbpf_program_convert,
-		load_cbpf_program_direct,
-	};
-
-	const uint32_t plen = 100;
-	struct rte_mbuf mb, *m;
-	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
-	struct {
-		struct rte_ether_hdr eth_hdr;
-		struct rte_ipv4_hdr ip_hdr;
-	} *hdr;
-
-	memset(&mb, 0, sizeof(mb));
-	dummy_mbuf_prep(&mb, tbuf, sizeof(tbuf), plen);
-	m = &mb;
-
-	hdr = rte_pktmbuf_mtod(m, typeof(hdr));
-	hdr->eth_hdr = (struct rte_ether_hdr) {
-		.dst_addr.addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
-		.ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
-	};
-	hdr->ip_hdr = (struct rte_ipv4_hdr) {
-		.version_ihl = RTE_IPV4_VHL_DEF,
-		.total_length = rte_cpu_to_be_16(plen),
-		.time_to_live = IPDEFTTL,
-		.next_proto_id = IPPROTO_RAW,
-		.src_addr = rte_cpu_to_be_32(RTE_IPV4_LOOPBACK),
-		.dst_addr = rte_cpu_to_be_32(RTE_IPV4_BROADCAST),
-	};
-
-	for (int li = 0; li != RTE_DIM(cbpf_program_loaders); ++li) {
-		if (test_bpf_match(pcap, "ip", m, cbpf_program_loaders[li]) != 0) {
+	for (unsigned int li = 0; li != RTE_DIM(cbpf_program_loaders); ++li) {
+		if (test_bpf_match(pcap, "ip", cbpf_program_loaders[li]) != 1) {
 			printf("%s@%d: filter \"ip\" doesn't match test data\n",
 			       __func__, __LINE__);
 			return -1;
 		}
-		if (test_bpf_match(pcap, "not ip", m, cbpf_program_loaders[li]) == 0) {
+		if (test_bpf_match(pcap, "not ip", cbpf_program_loaders[li]) != 0) {
 			printf("%s@%d: filter \"not ip\" does match test data\n",
 			       __func__, __LINE__);
 			return -1;
@@ -4981,7 +5026,6 @@ static const char * const sample_filters[] = {
 	"port 53",
 	"host 192.0.2.1 and not (port 80 or port 25)",
 	"host 2001:4b98:db0::8 and not port 80 and not port 25",
-	"port not 53 and not arp",
 	"(tcp[0:2] > 1500 and tcp[0:2] < 1550) or (tcp[2:2] > 1500 and tcp[2:2] < 1550)",
 	"ether proto 0x888e",
 	"ether[0] & 1 = 0 and ip[16] >= 224",
@@ -5008,35 +5052,10 @@ static const char * const sample_filters[] = {
 	"or host 192.0.2.1 or host 192.0.2.100 or host 192.0.2.200"),
 };
 
-static int
-test_bpf_filter(pcap_t *pcap, const char *s, load_cbpf_program_t load_cbpf_program)
-{
-	struct bpf_program fcode;
-	struct rte_bpf *bpf;
-
-	if (pcap_compile(pcap, &fcode, s, 1, PCAP_NETMASK_UNKNOWN)) {
-		printf("%s@%d: pcap_compile(\"%s\") failed: %s;\n",
-		       __func__, __LINE__, s, pcap_geterr(pcap));
-		return -1;
-	}
-
-	bpf = load_cbpf_program(&fcode, s);
-	if (bpf == NULL) {
-		printf("%s@%d: failed to load cbpf program for \"%s\", error=%d(%s);\n",
-			__func__, __LINE__, s, rte_errno, strerror(rte_errno));
-		test_bpf_dump(&fcode, NULL);
-	}
-
-	rte_bpf_destroy(bpf);
-
-	pcap_freecode(&fcode);
-	return (bpf == NULL) ? -1 : 0;
-}
-
 static int
 test_bpf_convert(void)
 {
-	unsigned int i;
+	unsigned int i, li;
 	pcap_t *pcap;
 	int rc;
 
@@ -5048,8 +5067,18 @@ test_bpf_convert(void)
 
 	rc = test_bpf_filter_sanity(pcap);
 	for (i = 0; i < RTE_DIM(sample_filters); i++) {
-		rc |= test_bpf_filter(pcap, sample_filters[i], load_cbpf_program_convert);
-		rc |= test_bpf_filter(pcap, sample_filters[i], load_cbpf_program_direct);
+		for (li = 0; li < RTE_DIM(cbpf_program_loaders); li++) {
+			int m = test_bpf_match(pcap, sample_filters[i],
+					       cbpf_program_loaders[li]);
+
+			/* None of the sample filters match the dummy packet. */
+			if (m != 0) {
+				if (m > 0)
+					printf("%s@%d: filter \"%s\" unexpectedly matched\n",
+					       __func__, __LINE__, sample_filters[i]);
+				rc = -1;
+			}
+		}
 	}
 
 	pcap_close(pcap);
-- 
2.53.0

