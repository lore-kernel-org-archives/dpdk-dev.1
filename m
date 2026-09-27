Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE07C98338
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Sep 2026 19:50:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95758402CE;
	Sun, 27 Sep 2026 21:50:22 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id A4FFC400D6
 for <dev@dpdk.org>; Sun, 27 Sep 2026 21:50:20 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso1987481a91.3
 for <dev@dpdk.org>; Sun, 27 Sep 2026 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790538620;
 x=1791143420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YXRGThjFwQvN44Y81z2CErX+xUAIxl2lvrbHMN2s9Ek=;
 b=FnXz5uLJaw7BWM7+eH0uNWFSs/rvHF38Lg9w0roMz4KscUQogSAn2hO+dqrfLc0d88
 +od2qCwCzXYp5WSfwbl1vYWUKK1/2bq+a830D1qi5MQExiJ1ayVa+T4Jpy3rpZxQHp89
 sADiFD8LKti6aDd/t5zWhUgiodlIy9jHXeg627cgO3Eir/uGsCTp2Re4oThY033HTuPg
 9MXlXN62zfKXS4Sq57G/fkfPjCBLYmkoJ4lRkobozaLCiXO3y4ah2zb82AkLidTlPstq
 i4FX5ejjtEgIbhNuqsaqFqR2hgT0vaP93+JHODlnJdfl/AlWQDQg6Jg+2uLiaKjzQev/
 ef8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790538620; x=1791143420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YXRGThjFwQvN44Y81z2CErX+xUAIxl2lvrbHMN2s9Ek=;
 b=jYGIKb7rNpCyWVzG07SqT60RffizFrWPf0hx+bApreRnHA/z0qKh66LybSxK43wi0y
 sUHxgIiX1NvQFPdSEIfZsF4tcSf7HdKX9PXoxTDgxMkJX4v8WQDF2Qmdw63t6irDAYMX
 0LgRd6/4ajBxt27k5EivuEdcmWG6apKBZypiAm5UJsYShfWAdWE8n3H4YjABbNFT33kv
 IzqbNbjHGQbdLhwUvOZiohwUc8riLWEbwQ63Dx+msLauja7Wu8UbYlw0G8SE+YKzRw8J
 YLVboQdEqLH3SQqHq8lL/vHDMXP0MRvCB98ON1YItEdnFiLvQmBH5kgXFCPqmevsUv0x
 1eIA==
X-Gm-Message-State: AFq9FYKAqqqVsgjsBHeBUx0HMgTOrZfMZxU9SgSZJWigF0mmYZD0nN4K
 ZxdbH/t87Q2tLWMm+SGiWnhHBwsv8BH6eBfBHEgDtfgpokRPiER6Ae2tWf23zm05nLWQFO++thC
 UoYOXRig=
X-Gm-Gg: AYBFou1lbg5XTLL74r2D4oF4ItFQdYVGPtqssPGVp1lZN6cLydf8/PhufA0joiyuar8
 KfZywDNq4M9lIretv4OJ9G2nH/nOieYIBYYkuFUkxdQPwib9p54VuagYVWkX49hCb39MNoBIjAe
 T65AcZmDDt61ZuWImSIV6Ed8kY5Rse0C0SxCXFnsuYfa+CpJooigCZbJQwb+6y5jlj+EyYEAZDt
 kzGOvoB+OzzipjcoThj41BafD9ErsA4lU9qRpWAisWskkcNv4AtT3lz4FIsk3k3qA+pjL2ZAaRn
 GtRcr5AhmTL/Mym3R0DU1uBMSb1FV99j9Oongg3s0H6yhV/HkNTBckE63vYjOawoDPSmsn51+UR
 J+tNWdbaJwjyuepETMMwGLMk52QwUym/cHiew/21L1lseGO4FT9b1lEEqy3IXiWzEyAmwknWJDT
 JFoRK62+Nth48ERRarQ1j+rV8FQ6XSc4ioPdxA1ZBi735O/cR50LR9uNuIunlpuFAvXo15BZFTs
 biknta4Ayl4llg/01v7QqtzOlY9bPfz/8p2og==
X-Received: by 2002:a17:90b:4d91:b0:3a0:c24f:3811 with SMTP id
 98e67ed59e1d1-3a0c24f3beamr5339514a91.56.1790538619675; 
 Sun, 27 Sep 2026 12:50:19 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976ca5f9sm23133053a91.14.2026.09.27.12.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 12:50:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 2/2] test/pcapng: check timestamps over a long capture
Date: Sun, 27 Sep 2026 12:50:15 -0700
Message-ID: <20260927195015.78109-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927195015.78109-1-stephen@networkplumber.org>
References: <20260927195015.78109-1-stephen@networkplumber.org>
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

The cycles to nanoseconds conversion can overflow after only a few
seconds of capture, but the test ran for less than that so it never
saw it.  Forge the cycle count in the packet header to get timestamps
up to ten days out without waiting.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 140 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index d14ea84f0d..688b58794e 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2021 Microsoft Corporation
  */
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -466,6 +467,47 @@ valid_pcapng_file(const char *file_name, uint64_t started, unsigned int expected
 	return ret;
 }
 
+/* Record the timestamp of the first packet in the file. */
+static void
+first_timestamp_cb(u_char *user, const struct pcap_pkthdr *h,
+		   const u_char *bytes __rte_unused)
+{
+	uint64_t *ts_ns = (uint64_t *)user;
+
+	/* File has nanosecond precision, so tv_usec holds ns. */
+	if (*ts_ns == 0)
+		*ts_ns = (uint64_t)h->ts.tv_sec * NS_PER_S + h->ts.tv_usec;
+}
+
+static int
+read_one_timestamp(const char *file_name, uint64_t *ts_ns)
+{
+	char errbuf[PCAP_ERRBUF_SIZE];
+	pcap_t *pcap;
+	int ret;
+
+	*ts_ns = 0;
+	pcap = pcap_open_offline_with_tstamp_precision(file_name,
+						       PCAP_TSTAMP_PRECISION_NANO,
+						       errbuf);
+	if (pcap == NULL) {
+		printf("pcap_open_offline('%s') failed: %s\n",
+			file_name, errbuf);
+		return -1;
+	}
+
+	ret = pcap_loop(pcap, 0, first_timestamp_cb, (u_char *)ts_ns);
+	if (ret != 0)
+		printf("pcap_loop: failed: %s\n", pcap_geterr(pcap));
+	pcap_close(pcap);
+
+	if (ret == 0 && *ts_ns == 0) {
+		printf("no packet found in %s\n", file_name);
+		return -1;
+	}
+	return ret;
+}
+
 static int
 test_add_interface(void)
 {
@@ -607,7 +649,7 @@ test_write_before_open(void)
 	mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
 
 	/* Copy packets BEFORE opening the pcapng file.
-	 * This exercises the negative TSC delta path in tsc_to_ns_epoch().
+	 * This exercises the negative TSC delta path.
 	 */
 	for (i = 0; i < (int)count; i++) {
 		clones[i] = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
@@ -679,6 +721,101 @@ test_cleanup(void)
 	rte_vdev_uninit(null_dev);
 }
 
+/*
+ * Converting a cycle count to nanoseconds overflows past
+ * UINT64_MAX / NS_PER_S cycles, which is only a few seconds of real
+ * capture.  Forge the timestamp in the block header to reach large
+ * deltas without waiting.
+ */
+static int
+test_long_timestamp(void)
+{
+	/* seconds into the future */
+	static const unsigned int offsets[] = { 1, 8, 3600, 10 * 86400 };
+	struct pcapng_test_hdr {
+		uint32_t block_type;
+		uint32_t block_length;
+		uint32_t interface_id;
+		uint32_t timestamp_hi;
+		uint32_t timestamp_lo;
+	} *epb;
+	struct dummy_mbuf mbfs;
+	uint64_t hz = rte_get_tsc_hz();
+	unsigned int i;
+
+	TEST_ASSERT(hz != 0, "TSC frequency is zero");
+
+	mbuf1_prepare(&mbfs);
+	mbuf1_resize(&mbfs, 512);
+
+	for (i = 0; i < RTE_DIM(offsets); i++) {
+		char file_name[PATH_MAX] = "/tmp/pcapng_test_XXXXXX.pcapng";
+		uint64_t cycles, base_ns, want_ns, got_ns, diff;
+		struct rte_mbuf *mc;
+		rte_pcapng_t *pcapng;
+		int ret, tmp_fd;
+		ssize_t len;
+
+		mc = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
+				     rte_pktmbuf_pkt_len(&mbfs.mb[0]),
+				     RTE_PCAPNG_DIRECTION_IN, NULL);
+		TEST_ASSERT(mc != NULL, "rte_pcapng_copy failed");
+
+		tmp_fd = mkstemps(file_name, strlen(".pcapng"));
+		if (tmp_fd == -1) {
+			rte_pktmbuf_free(mc);
+			TEST_ASSERT(false, "mkstemps() failed");
+		}
+
+		base_ns = current_timestamp();
+		pcapng = rte_pcapng_fdopen(tmp_fd, NULL, NULL, "longts", NULL);
+		if (pcapng == NULL) {
+			close(tmp_fd);
+			rte_pktmbuf_free(mc);
+			TEST_ASSERT(false, "rte_pcapng_fdopen failed");
+		}
+
+		ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
+					       NULL, NULL, NULL);
+		if (ret < 0) {
+			rte_pcapng_close(pcapng);
+			rte_pktmbuf_free(mc);
+			TEST_ASSERT(false, "can not add port %u", port_id);
+		}
+
+		/* Conversion happens on write, so move the capture time. */
+		epb = rte_pktmbuf_mtod(mc, struct pcapng_test_hdr *);
+		cycles = (uint64_t)epb->timestamp_hi << 32;
+		cycles += epb->timestamp_lo;
+		cycles += (uint64_t)offsets[i] * hz;
+		epb->timestamp_hi = cycles >> 32;
+		epb->timestamp_lo = (uint32_t)cycles;
+
+		len = rte_pcapng_write_packets(pcapng, &mc, 1);
+		rte_pktmbuf_free(mc);
+		rte_pcapng_close(pcapng);
+		TEST_ASSERT(len > 0, "write failed at +%u s", offsets[i]);
+
+		ret = read_one_timestamp(file_name, &got_ns);
+		TEST_ASSERT(ret == 0, "can not read back +%u s", offsets[i]);
+
+		/* An overflow wraps and misses by the whole offset. */
+		want_ns = base_ns + (uint64_t)offsets[i] * NS_PER_S;
+		diff = (got_ns > want_ns) ? got_ns - want_ns : want_ns - got_ns;
+		if (diff > 2 * NS_PER_S)
+			printf("at +%u s: got %"PRIu64" want %"PRIu64"\n",
+			       offsets[i], got_ns, want_ns);
+		else
+			remove(file_name);
+
+		TEST_ASSERT(diff <= 2 * NS_PER_S,
+			    "timestamp off by %"PRIu64" ns at +%u s",
+			    diff, offsets[i]);
+	}
+
+	return 0;
+}
+
 static struct
 unit_test_suite test_pcapng_suite  = {
 	.setup = test_setup,
@@ -688,6 +825,7 @@ unit_test_suite test_pcapng_suite  = {
 		TEST_CASE(test_add_interface),
 		TEST_CASE(test_write_packets),
 		TEST_CASE(test_write_before_open),
+		TEST_CASE(test_long_timestamp),
 		TEST_CASES_END()
 	}
 };
-- 
2.53.0

