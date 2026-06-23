Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B1CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 23:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE63E4069F;
	Wed, 24 Jun 2026 01:25:44 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 876694066C
 for <dev@dpdk.org>; Wed, 24 Jun 2026 01:25:34 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1397e093f90so1124805c88.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782257134;
 x=1782861934; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCYFeR5dduzCfqN8wx6MZQwRpX1Z3UGkDtgHe8cKpO8=;
 b=ZEHGnl9OFVbkYRB7ZysJXA/AIXek+6aMpmvi2kJxemJf/hil80sL2pogLTJnrYXKgE
 +bmp3wCyuwQuW7MSAWfxYfmMj5sPHWhA2v4cUEtt/W1VKuk6yBMShA2FkgceTFOdF8yh
 VF+gziAQ4CZIi99PyKCB5d0A8HlNdkb1+UK9WbKrLDbdvMxPb4zEpXc5uJu9Gppi8Q5P
 pvNQXTaPsApzRtA+UjV0IX0z/T032QbcoHul9FLOwRw+XaogIG4scb4F+6rzAlbHySYy
 LSfz0PCAFrcjwrkBgMWZCmevh+dkGsR+OiwvEplVXVmb+pl2UX8VwPDTYrnW/4Rvik5n
 gVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782257134; x=1782861934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cCYFeR5dduzCfqN8wx6MZQwRpX1Z3UGkDtgHe8cKpO8=;
 b=mIQpDSGBI0sRRdSQgEETLegz8xKRSwe42BQp/u6V4GkrRrqlba5q/TvfuUULg45K0w
 XWTrjjvtv2yXP1ooByen4j7oMlQhf7ogojC91TG9QpvbnaRK8oXG3yRfUEZD4lZIo8XU
 JgEztuHWTeOV7I/KxlMcmebKtkd6rCBxw7yJdQ4TzlIAQWcaYJUrH2QIwIdAQ9XAx2yA
 5xtd2zoIOvpK+NVx1In7wc1KokV9aI0d9S6DDVyGV9a9jcjQ2TlTv5H2TbJP85Igtwp9
 WhD1T9iTDnm6unSlTxhy8SBvXlyZodl66wrjyhcK7cHGxOkxoqOweitKxJZlir7GmaV7
 WoIw==
X-Gm-Message-State: AOJu0YzlIrWfunwovEn/2/beQyeHzAxdk0x7t06YCHRQDHvZcEOul8UU
 o2Z39l79Qa2gn8edNTIvvokLNBRbrSw/jFV9wpPmZ8+m2AuH9FQUS5PRHfRGefyMkvio2HqMw2t
 SO35k
X-Gm-Gg: AfdE7ck4ga5xR8jZdbdElCFAoEnrIAdojNRWiCEHzwvr/cacRQFLZDWawQt+RwnAEv8
 j+iO3WRN6eTRr5S+Q7fH5jWmq7z00elGs/RacvWOp1TQ6mPOpD7vYqS2kdaN4EPS4jpm/rZbIwr
 jbLfenTw1kMgV1X66um9k3Sx/+tp3Mv2d4c9xWiVKjW4qXVrqIIBC7YXVKgKP897WYVwfM0Kei/
 vAnPKZyAI6bRA1pMd8l9Kfr3MRFYFZp4FTfW0mD1C860qBZkOSRIV5nyZqbjg6uDW7cJ860Ml3b
 KvOdEi0q6PRfJ19lvzSe5YMl9S09OFMR/G/EaIJBlwmF16ujeBi9Y1F1pBlCdCEMsk7L83nOWjH
 O8HRvfs+pZbPUqlhx+zNBnLxB5sycCyRAPYtCmJ5Qzn0iAhWO0aRTAySLtdHa1m0q6h1onRBtSs
 foJ+lDFC+qtiixJqpQYN2Tamm8gkFxiGOc28iKLx/4/kT6aV0afmo=
X-Received: by 2002:a05:7301:5f01:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-30c691cbb1fmr1383731eec.11.1782257133611; 
 Tue, 23 Jun 2026 16:25:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm21263443eec.10.2026.06.23.16.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 16:25:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 7/7] test/bpf: check that bpf_convert can be JIT'd
Date: Tue, 23 Jun 2026 16:23:18 -0700
Message-ID: <20260623232522.257208-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623232522.257208-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260623232522.257208-1-stephen@networkplumber.org>
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
---
 app/test/test_bpf.c | 171 ++++++++++++++++++++++++++------------------
 1 file changed, 100 insertions(+), 71 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 9adffcce64..8934c98c3c 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -32,6 +32,7 @@ test_bpf(void)
 #include <rte_bpf.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
+#include <rte_udp.h>
 
 
 /* Tests of most simple BPF programs (no instructions, one instruction etc.) */
@@ -4763,11 +4764,13 @@ load_cbpf_program_convert(struct bpf_program *cbpf_program, const char *str)
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
@@ -4792,18 +4795,65 @@ load_cbpf_program_direct(struct bpf_program *cbpf_program, const char *str __rte
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
 
@@ -4811,15 +4861,41 @@ test_bpf_match(pcap_t *pcap, const char *str, struct rte_mbuf *mb,
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
@@ -4828,44 +4904,13 @@ test_bpf_match(pcap_t *pcap, const char *str, struct rte_mbuf *mb,
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
@@ -4889,7 +4934,6 @@ static const char * const sample_filters[] = {
 	"port 53",
 	"host 192.0.2.1 and not (port 80 or port 25)",
 	"host 2001:4b98:db0::8 and not port 80 and not port 25",
-	"port not 53 and not arp",
 	"(tcp[0:2] > 1500 and tcp[0:2] < 1550) or (tcp[2:2] > 1500 and tcp[2:2] < 1550)",
 	"ether proto 0x888e",
 	"ether[0] & 1 = 0 and ip[16] >= 224",
@@ -4916,35 +4960,10 @@ static const char * const sample_filters[] = {
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
 
@@ -4956,8 +4975,18 @@ test_bpf_convert(void)
 
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

