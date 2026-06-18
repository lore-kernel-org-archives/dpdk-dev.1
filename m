Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC5DCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 21:01:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0264940DCD;
	Thu, 18 Jun 2026 23:00:46 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id B19CD40A84
 for <dev@dpdk.org>; Thu, 18 Jun 2026 23:00:40 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304f590dd91so1701487eec.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781816440;
 x=1782421240; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VB05lMcqK+/LPMv8mlQm3J8QzOVyTDGw9AcQMktYIQw=;
 b=af2c58EsTaPNZCBtkC0xSAcNQheN1UqftWjyB8lTmJAF00YRZYk+UvSiVVF6Ozl0wF
 JFpJ4/OV7VuYZbNIm/qdhhbf1E1tZYE7v/huw9YHPm7Zbf33+0eJwgaf37HEheRj98ED
 ISEYfnL4Gs9rO9h5pQbkpxn6XnznnCk/nWQsiXOcy2omsYH8HlGnl8gEr4bBHCgD2Lor
 3DhcC1qmlNNpYWbkAM7ZFz2DzfwsXPmkvTgHktnFPLPnu6d9BsXo8nXFiI5gz2NLpCSS
 vQzx+Kbe8zggHQ/oA/3Xxje/92082vOuPsWZv6Gr8h3qOvIEn8kXLSxyCXaLqXsB063v
 ehtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816440; x=1782421240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VB05lMcqK+/LPMv8mlQm3J8QzOVyTDGw9AcQMktYIQw=;
 b=ltC8p/n0IcGlmoFwFxl92TVfxxJSDkFnsRyz+t4HgeJuSoNotUEV8G7LvTGfUKjvKt
 GrjhyTvZD6dlxQZvV6ahX1OkIpczyvWg2VU9PjfuqLR6Yizsqv8cb6eXNmhLNF8KS79x
 vDXcv6iUjiJyESy2Q4c3moHsecRkwVGX6mFPy8N5EoAzA+m9zoQMXdoF0MEagjpGxUn7
 fH0FPEULWYU/9+U2i5fHmjD4QPYfgzodIJDjeX2A5edAHMnOuIZiRJPAM1SS3Xanpv33
 OQPQ5mGpgTaEQVqgIsPtlrC501n0co6Zucm/Le5VU/RBU45vxocT4IH2JPMjBpomd3Ts
 Qnuw==
X-Gm-Message-State: AOJu0Yxl4fIvwgtrDufRqIEMB9zEEm4lmLRLKipYKuGeZCF/2A6ugcwo
 VXr6o7cN1UH8MVmQFjH8DXzVteVUUWvRSpfM9Yh14LOJELHLgZMt1u6kS6aGUoxUyPeWJgrrCld
 e7PKC
X-Gm-Gg: AfdE7clwtjyu86QiNTGcpyHUediczgPJtJfWhnaZajQGtXFrj8C7LuRkBV5KWVJ1n2n
 qi629KRXwgSYnVqRbHYyUOSWE4bNoLfcRVzpV8kh3RuMpWCU3EU0MoyWYxkBn23C/RBazDkf9RI
 0btmZmJ8ySaUUOKnS50rXs+oClRIMS2U5tBHz5+C6/KBR9wkgLZpLkva/5pdyMl9UP1HlrpPAGr
 WJt4cjQHW3J6WOYLUJsIIRgfRRxvNa7INLiEVKma55JKO7yr2BFneoO7lGxaMm8StI4SPMLFMF+
 16T+U6itkVU75gefAVNsVWQpsDFysne9h975B3vXoq8XpmRIkxvxCs5cg55Eqn+cPg28RsASjP9
 Kzm0xhyBp/5lhD0WYpAVm0RcPhXzvhJ/JOtfkW2pnfIdb5ndDNmwU7o5PwFI9kNNAV1zmMAJNMT
 7cwmFIz2dvFL7ghlT+eyqkL8Xoc+4e/9hBMC4fZFiZzBKylMAwdqE=
X-Received: by 2002:a05:7301:6591:b0:304:d32e:65e7 with SMTP id
 5a478bee46e88-30c06c0431emr802461eec.0.1781816439579; 
 Thu, 18 Jun 2026 14:00:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d6766fsm863387eec.29.2026.06.18.14.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 14:00:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 6/6] test/bpf: check that bpf_convert can be JIT'd
Date: Thu, 18 Jun 2026 13:47:10 -0700
Message-ID: <20260618210026.430288-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618210026.430288-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260618210026.430288-1-stephen@networkplumber.org>
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

Add followup in bpf conversion tests to make sure resulting
code was also run through JIT and that JIT produces
same results as non-JIT.

Reduce log output to make it easier to match which
expression might be causing issues.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 94 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3a88434c3c..973dd7d659 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -8,6 +8,7 @@
 #include <inttypes.h>
 #include <unistd.h>
 
+#include <rte_byteorder.h>
 #include <rte_memory.h>
 #include <rte_debug.h>
 #include <rte_hexdump.h>
@@ -32,6 +33,7 @@ test_bpf(void)
 #include <rte_bpf.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
+#include <rte_udp.h>
 
 
 /* Tests of most simple BPF programs (no instructions, one instruction etc.) */
@@ -4529,6 +4531,7 @@ test_bpf_match(pcap_t *pcap, const char *str,
 	int ret = -1;
 	uint64_t rc;
 
+	printf("%s '%s'\n", __func__, str);
 	if (pcap_compile(pcap, &fcode, str, 1, PCAP_NETMASK_UNKNOWN)) {
 		printf("%s@%d: pcap_compile(\"%s\") failed: %s;\n",
 		       __func__, __LINE__,  str, pcap_geterr(pcap));
@@ -4550,6 +4553,24 @@ test_bpf_match(pcap_t *pcap, const char *str,
 	}
 
 	rc = rte_bpf_exec(bpf, mb);
+#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
+	{
+		struct rte_bpf_jit jit;
+
+		rte_bpf_get_jit(bpf, &jit);
+		if (jit.func == NULL) {
+			printf("%s@%d: no JIT generated\n", __func__, __LINE__);
+			goto error;
+		}
+
+		fflush(stdout);
+		uint64_t rc_jit = jit.func(mb);
+		if (rc_jit != rc) {
+			printf("%s@%d: JIT return code does not match\n", __func__, __LINE__);
+			goto error;
+		}
+	}
+#endif
 	/* The return code from bpf capture filter is non-zero if matched */
 	ret = (rc == 0);
 error:
@@ -4560,23 +4581,16 @@ test_bpf_match(pcap_t *pcap, const char *str,
 	return ret;
 }
 
-/* Basic sanity test can we match a IP packet */
-static int
-test_bpf_filter_sanity(pcap_t *pcap)
+/* Setup mbuf for filter test */
+static void
+dummy_ip_prep(void *data, uint16_t plen)
 {
-	const uint32_t plen = 100;
-	struct rte_mbuf mb, *m;
-	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
 	struct {
 		struct rte_ether_hdr eth_hdr;
 		struct rte_ipv4_hdr ip_hdr;
-	} *hdr;
+		struct rte_udp_hdr udp_hdr;
+	} *hdr = data;
 
-	memset(&mb, 0, sizeof(mb));
-	dummy_mbuf_prep(&mb, tbuf, sizeof(tbuf), plen);
-	m = &mb;
-
-	hdr = rte_pktmbuf_mtod(m, typeof(hdr));
 	hdr->eth_hdr = (struct rte_ether_hdr) {
 		.dst_addr.addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
 		.ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
@@ -4589,13 +4603,32 @@ test_bpf_filter_sanity(pcap_t *pcap)
 		.src_addr = rte_cpu_to_be_32(RTE_IPV4_LOOPBACK),
 		.dst_addr = rte_cpu_to_be_32(RTE_IPV4_BROADCAST),
 	};
+	hdr->udp_hdr = (struct rte_udp_hdr) {
+		.src_port = rte_rand_max(UINT16_MAX),
+		.dst_port = rte_cpu_to_be_16(9),	/* discard port */
+		.dgram_len = rte_cpu_to_be_16(plen - sizeof(struct rte_ipv4_hdr)),
+		.dgram_cksum = 0,
+	};
+}
+
+
+/* Basic sanity test can we match a IP packet */
+static int
+test_bpf_filter_sanity(pcap_t *pcap)
+{
+	struct rte_mbuf mb = { 0 };
+	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
+	const uint32_t plen = 100;
+
+	dummy_mbuf_prep(&mb, tbuf, sizeof(tbuf), plen);
+	dummy_ip_prep(rte_pktmbuf_mtod(&mb, void *), plen);
 
-	if (test_bpf_match(pcap, "ip", m) != 0) {
+	if (test_bpf_match(pcap, "ip", &mb) != 0) {
 		printf("%s@%d: filter \"ip\" doesn't match test data\n",
 		       __func__, __LINE__);
 		return -1;
 	}
-	if (test_bpf_match(pcap, "not ip", m) == 0) {
+	if (test_bpf_match(pcap, "not ip", &mb) == 0) {
 		printf("%s@%d: filter \"not ip\" does match test data\n",
 		       __func__, __LINE__);
 		return -1;
@@ -4648,10 +4681,15 @@ static const char * const sample_filters[] = {
 static int
 test_bpf_filter(pcap_t *pcap, const char *s)
 {
+	struct rte_mbuf mb = { 0 };
+	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
+	const uint32_t plen = 100;
 	struct bpf_program fcode;
 	struct rte_bpf_prm *prm = NULL;
 	struct rte_bpf *bpf = NULL;
+	int ret = -1;
 
+	printf("%s '%s'\n", __func__, s);
 	if (pcap_compile(pcap, &fcode, s, 1, PCAP_NETMASK_UNKNOWN)) {
 		printf("%s@%d: pcap_compile('%s') failed: %s;\n",
 		       __func__, __LINE__, s, pcap_geterr(pcap));
@@ -4665,8 +4703,10 @@ test_bpf_filter(pcap_t *pcap, const char *s)
 		goto error;
 	}
 
+#ifdef DEBUG
 	printf("bpf convert for \"%s\" produced:\n", s);
 	rte_bpf_dump(stdout, prm->ins, prm->nb_ins);
+#endif
 
 	bpf = rte_bpf_load(prm);
 	if (bpf == NULL) {
@@ -4675,6 +4715,30 @@ test_bpf_filter(pcap_t *pcap, const char *s)
 		goto error;
 	}
 
+	dummy_mbuf_prep(&mb, tbuf, sizeof(tbuf), plen);
+	dummy_ip_prep(rte_pktmbuf_mtod(&mb, void *), plen);
+
+	uint64_t rc = rte_bpf_exec(bpf, &mb);
+#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
+	{
+		struct rte_bpf_jit jit;
+
+		rte_bpf_get_jit(bpf, &jit);
+		if (jit.func == NULL) {
+			printf("%s@%d: no JIT generated\n", __func__, __LINE__);
+			goto error;
+		}
+
+		fflush(stdout);
+		uint64_t rc_jit = jit.func(&mb);
+		if (rc_jit != rc) {
+			printf("%s@%d: JIT return code does not match\n", __func__, __LINE__);
+			goto error;
+		}
+	}
+#endif
+	ret = 0;
+
 error:
 	if (bpf)
 		rte_bpf_destroy(bpf);
@@ -4685,7 +4749,7 @@ test_bpf_filter(pcap_t *pcap, const char *s)
 
 	rte_free(prm);
 	pcap_freecode(&fcode);
-	return (bpf == NULL) ? -1 : 0;
+	return ret;
 }
 
 static int
-- 
2.53.0

