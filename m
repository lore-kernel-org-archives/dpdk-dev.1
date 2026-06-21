Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB6ECD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 16:26:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A19C440649;
	Sun, 21 Jun 2026 18:25:45 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 49107402EB
 for <dev@dpdk.org>; Sun, 21 Jun 2026 18:25:36 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137335bc3caso5476832c88.0
 for <dev@dpdk.org>; Sun, 21 Jun 2026 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782059135;
 x=1782663935; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VB05lMcqK+/LPMv8mlQm3J8QzOVyTDGw9AcQMktYIQw=;
 b=uVBx1esQdNHW/WbW9LhppcvyN2R4ZXeFDxB5Hy4QXRic6+PXQcpO8Idtntv+0OI+6S
 0zD7r8vtmVFOh/csbSsqyuumTC+bk+StBjFFIYadFMFmmdEpKaqaEH5QKIa4j+IcfsBh
 TZdP6fg8ZZ/hV7svg4t0W2RQk0kpXmFIcSmznexIoIN4+rFvtW+4XdkqMsLG4YNX9QUt
 l9bhZ4YLb20BcEfHdSPTekcM+MsgM41HoaXbNdSxApJt+Nhq4g0Kkuq28cDQz2oC2bDL
 ziqTzkqMjpCBBEHTKqeE3wB7CbPbUMw4f/TOuvpzew6T7mDdyCCfhn3Om7XENxVR/Ssn
 1wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782059135; x=1782663935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VB05lMcqK+/LPMv8mlQm3J8QzOVyTDGw9AcQMktYIQw=;
 b=mOIMf8BBYOamRy9RThRLgQL2+waJIi0FKigJ2snT/YXdfA1B4T+XMuT6JMTDpqLF3V
 QMQR6a7gFu8WzrgECloC8W/SbSWwauLuvAUfolRmVVqxKsbCTdgAIDx02LqJ1MHGsz62
 0mCXDl1+yiN8R7VqPb6SKqaTUGBAQ2dD2Sc1BrkFkHyo1Q6dePtQIjfv93biFroIO4nS
 +9Zz+aOAKiWrQVNyPa3i41JhK12T8UhdtwW/m1FZRLmFeWJOgH+9K4ndvipsD/0Rg27h
 ZUU2I7pXVcEnh+A9UwAbJbgmQ7I7iBkmSZhKZYANn5cnyoJIs8bWSC0TAi6lC7VFOGNh
 g9oA==
X-Gm-Message-State: AOJu0YzDLzBHNZAfIvQC6lpkIBSAE/f+pd9g8gNhf/S/zkbBJ2W0+vsK
 a4iGDyqX2JqdhSUdmOiuIADXKA1CFkGBFoc+JaKR9Y55oiGLhwqIfMvLLhbWXJJpt+aA9emX5fE
 t4ZvqoJY=
X-Gm-Gg: AfdE7clWd2MTUfCPmtCuiFsP4tcf8jXdwK7zPkR/DWy+tkfUlJdKh1bN/V0+LQkjaQy
 U21Es1zlPe/k3VBmbsBKBQ+vjNL8Pme4ESJ+xPBCZTzXCyDqEJIhyD0fAJGWjjmw2id8+CqqfT+
 25c8/l5Ug3nt0VeS1WPKqXuvkQfet5mAvpUAp7EBLyvdj5E5BVxLhaPUXSnQdRUaGLaOg/IM//M
 IE6YW28CtKA5v1yIGRYx0+Za/+Oozu4sonU5OZ3c638MjCinECR/o3HVLxf9LQ1Ipj1TN2MyB1S
 OQEFRlzwPd6xwV7ciFO1PlTlJyxvce2AN8+CCHDh7XB9QR6R7iP9FbvZFOwVx3Xy0YMtJYNvFcT
 lt9/8sFxVS4U2NNZi97J9IKooCPuQJy0hnlSEl7c5SmXp87wUG0E5slT6hHucF+IbKWPzTW2C/I
 U9YR7SyNjwfhr0P9dEJNvS0MH/Ss8uWd53EL/fkQ5tltIPYseBWYc=
X-Received: by 2002:a05:7022:e15:b0:139:85c2:d7b7 with SMTP id
 a92af1059eb24-139a367e28dmr7584094c88.32.1782059135287; 
 Sun, 21 Jun 2026 09:25:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm5141593c88.13.2026.06.21.09.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:25:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v3 6/6] test/bpf: check that bpf_convert can be JIT'd
Date: Sun, 21 Jun 2026 09:23:59 -0700
Message-ID: <20260621162524.82690-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621162524.82690-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
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

