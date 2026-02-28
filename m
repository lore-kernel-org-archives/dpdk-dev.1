Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862EBFEE4ED
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:26:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75D4C402CA;
	Sat, 28 Feb 2026 18:26:14 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 24BC94013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:26:13 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1275750cfc7so5442994c88.0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772299572;
 x=1772904372; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7g317oelm7j0/jrXdnLkquekFYCD3yFr+NK0BgQPSmc=;
 b=n6U/bMHhZIRu/9BcRbI1+O+1ezupMc5H1IQVWf6Ffx/yVWfz0rPPyIneHjHajLFq4k
 wvUidfTUuBjw3wI4eubMBrHr6ksnO6rObFhVjH1eHxHyyuzA/C6fc2ZpjH6xkY1SNyNq
 AWqShBSgeN4pHulDO/lO1RdNyVaZtlovmYUQT9wYtVwCjonXWOWrBsS/hRy2r1GrtKGC
 8KvdF5i35o32+EqfAjqPuM1WijqerlG9tyB9UpKY5P1Fa/+9mCPNYMsVahVuUrrpx+W5
 ABnlTA3eim21JOnz38POfbe42qttLyYGc16d5XJMlBkaU6R/ZUht1jKoQLujZ+tI5cre
 I6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772299572; x=1772904372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7g317oelm7j0/jrXdnLkquekFYCD3yFr+NK0BgQPSmc=;
 b=R+u5j+RAxHZ26sGx3vYGct5usuHlHI7tq3GTM35pgtA+r7irJOQm+rzJguVyz9eOwa
 HySal7/v3bUuHRm+6oHcsvPZRTLo9v6ond6xgrh2lo8ThWWBsSAm5dIRftjstb9HpDW4
 JW6sC47941gXEb4RQtrif86tT9PJ/irGxmqBYBzLxDnSuwzAfJu3KepsbwsCFTyRnao5
 I9GhTpRIfY6eMpSZbg+ze+09v5IVxGmmP1ZvuuOVKw8XLzEApUIep1SmAeEEqDAtpoJA
 6Qwx9XVDjWrUgB1BjDKBFTVP4uvFvZfcLsiIhJARFXS1DJAvfNlZvwJHKbCw8m3zMbZa
 AhQQ==
X-Gm-Message-State: AOJu0YxGJpyEwDVVlPikOHsBNoexHED5O2ui1bPGvo5RGIYTeOLitjsi
 GssGMrjq7EPtDNpjYRYPiu4sfYaILbL6Mjok+fDc7nPRnzwhGig2R1i0jfhEA1NzbsCQKVPODJ8
 LW6wR
X-Gm-Gg: ATEYQzzHyjsLVRQRQaSJR5Kth6YI4HC0CKWc406NSzP6Mck3ybymFNFvZeI0CgT5k7F
 kF2wU5pLKclVRini49fvfEi0FinqCrVo/aNYx9eO+UZoKL55rB1PUD5Ie4ZCRk8N+eEQJHi4tCT
 wrTsLb1cn80j0gkuWB0lZ1wbCFJh73uz+iSIii5A+eOvu4CGuUQNnIWl0iYT9mUUjkpOTWhC8gM
 nbZxDbGjyUAdYGEoS8MzjRZIHmc5KMnDdbkriGPcKyKPHZyD/eeeIOvxkOoHRYZVCqJB2cXSjUl
 /UjhH8Ts22Q+6AwLtWd97OZxsyRa//2VszAbrkcSNM5VbhwX1iMmfTAKAnmzUiCEYVYDc0cxgK9
 Knvdfkrc3wkE2HC0MIe2OYAF+Nqeiy7DFnNwGjXGAjMvVwjGax2pKKVA2TLL4KBv9cZ2G41L0SI
 JN/+HL810kHN12I6tqd8iIcvejlevQ/OP1cpjQkL+1hozlDQcSZCulQ2XaYPhmig==
X-Received: by 2002:a05:7022:e02:b0:119:e56b:c745 with SMTP id
 a92af1059eb24-1278fc468f1mr3779349c88.10.1772299571952; 
 Sat, 28 Feb 2026 09:26:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a52ab0sm10052782c88.15.2026.02.28.09.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:26:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] test: better logging for pcapng test
Date: Sat, 28 Feb 2026 09:26:06 -0800
Message-ID: <20260228172606.555527-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The pcapng functional test was mixing output on both stdout
and stderr, which made analysis confusing. Use stdout like
the rest of the test framework.

Also, output timestamps in UTC which makes more sense in
CI environment.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 48 ++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index ad9ad51f4c..95f2eb9c33 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -158,7 +158,7 @@ test_setup(void)
 
 	/* Make a dummy null device to snoop on */
 	if (rte_vdev_init(null_dev, NULL) != 0) {
-		fprintf(stderr, "Failed to create vdev '%s'\n", null_dev);
+		printf("Failed to create vdev '%s'\n", null_dev);
 		goto fail;
 	}
 
@@ -168,7 +168,7 @@ test_setup(void)
 					    rte_pcapng_mbuf_size(MAX_DATA_SIZE),
 					    SOCKET_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
-		fprintf(stderr, "Cannot create mempool\n");
+		printf("Cannot create mempool\n");
 		goto fail;
 	}
 
@@ -238,7 +238,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
 					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
-				fprintf(stderr, "Cannot copy packet\n");
+				printf("Cannot copy packet\n");
 				return -1;
 			}
 			clones[i] = mc;
@@ -249,7 +249,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 		rte_pktmbuf_free_bulk(clones, burst_size);
 
 		if (len <= 0) {
-			fprintf(stderr, "Write of packets failed: %s\n",
+			printf("Write of packets failed: %s\n",
 				rte_strerror(rte_errno));
 			return -1;
 		}
@@ -260,6 +260,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 	return count;
 }
 
+/* Convert time in nanoseconds sinc 1/1/1970 to UTC time string */
 static char *
 fmt_time(char *buf, size_t size, uint64_t ts_ns)
 {
@@ -267,7 +268,8 @@ fmt_time(char *buf, size_t size, uint64_t ts_ns)
 	size_t len;
 
 	sec = ts_ns / NS_PER_S;
-	len = strftime(buf, size, "%X", localtime(&sec));
+
+	len = strftime(buf, size, "%T", gmtime(&sec));
 	snprintf(buf + len, size - len, ".%09lu",
 		 (unsigned long)(ts_ns % NS_PER_S));
 
@@ -292,6 +294,7 @@ print_packet(uint64_t ts_ns, const struct rte_ether_hdr *eh, size_t len)
 	rte_ether_format_addr(src, sizeof(src), &eh->src_addr);
 	printf("%s: %s -> %s type %x length %zu\n",
 	       tbuf, src, dst, rte_be_to_cpu_16(eh->ether_type), len);
+	fflush(stdout);
 }
 
 /* Callback from pcap_loop used to validate packets in the file */
@@ -302,6 +305,7 @@ parse_pcap_packet(u_char *user, const struct pcap_pkthdr *h,
 	struct pkt_print_ctx *ctx = (struct pkt_print_ctx *)user;
 	const struct rte_ether_hdr *eh;
 	const struct rte_ipv4_hdr *ip;
+	static unsigned int total_errors;
 	uint64_t ns;
 
 	eh = (const struct rte_ether_hdr *)bytes;
@@ -320,18 +324,19 @@ parse_pcap_packet(u_char *user, const struct pcap_pkthdr *h,
 
 		fmt_time(tstart, sizeof(tstart), ctx->start_ns);
 		fmt_time(tend, sizeof(tend), ctx->end_ns);
-		fprintf(stderr, "Timestamp out of range [%s .. %s]\n",
-			tstart, tend);
+
+		printf("Timestamp out of range [%s .. %s]\n",
+		       tstart, tend);
 		goto error;
 	}
 
 	if (!rte_is_broadcast_ether_addr(&eh->dst_addr)) {
-		fprintf(stderr, "Destination is not broadcast\n");
+		printf("Destination is not broadcast\n");
 		goto error;
 	}
 
 	if (rte_ipv4_cksum(ip) != 0) {
-		fprintf(stderr, "Bad IPv4 checksum\n");
+		printf("Bad IPv4 checksum\n");
 		goto error;
 	}
 
@@ -340,8 +345,9 @@ parse_pcap_packet(u_char *user, const struct pcap_pkthdr *h,
 error:
 	print_packet(ns, eh, h->len);
 
-	/* Stop parsing at first error */
-	pcap_breakloop(ctx->pcap);
+	/* Stop parsing at tenth error */
+	if (++total_errors >= 10)
+	    pcap_breakloop(ctx->pcap);
 }
 
 static uint64_t
@@ -372,14 +378,14 @@ valid_pcapng_file(const char *file_name, uint64_t started, unsigned int expected
 							   PCAP_TSTAMP_PRECISION_NANO,
 							   errbuf);
 	if (ctx.pcap == NULL) {
-		fprintf(stderr, "pcap_open_offline('%s') failed: %s\n",
+		printf("pcap_open_offline('%s') failed: %s\n",
 			file_name, errbuf);
 		return -1;
 	}
 
 	ret = pcap_loop(ctx.pcap, 0, parse_pcap_packet, (u_char *)&ctx);
 	if (ret != 0) {
-		fprintf(stderr, "pcap_dispatch: failed: %s\n",
+		printf("pcap_dispatch: failed: %s\n",
 			pcap_geterr(ctx.pcap));
 	} else if (ctx.count != expected) {
 		printf("Only %u packets, expected %u\n",
@@ -410,7 +416,7 @@ test_add_interface(void)
 	/* open a test capture file */
 	pcapng = rte_pcapng_fdopen(tmp_fd, NULL, NULL, "pcapng_addif", NULL);
 	if (pcapng == NULL) {
-		fprintf(stderr, "rte_pcapng_fdopen failed\n");
+		printf("rte_pcapng_fdopen failed\n");
 		close(tmp_fd);
 		goto fail;
 	}
@@ -419,7 +425,7 @@ test_add_interface(void)
 	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       NULL, NULL, NULL);
 	if (ret < 0) {
-		fprintf(stderr, "can not add port %u\n", port_id);
+		printf("can not add port %u\n", port_id);
 		goto fail;
 	}
 
@@ -427,7 +433,7 @@ test_add_interface(void)
 	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       "myeth", "Some long description", NULL);
 	if (ret < 0) {
-		fprintf(stderr, "can not add port %u with ifname\n", port_id);
+		printf("can not add port %u with ifname\n", port_id);
 		goto fail;
 	}
 
@@ -435,7 +441,7 @@ test_add_interface(void)
 	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       NULL, NULL, "tcp port 8080");
 	if (ret < 0) {
-		fprintf(stderr, "can not add port %u with filter\n", port_id);
+		printf("can not add port %u with filter\n", port_id);
 		goto fail;
 	}
 
@@ -471,7 +477,7 @@ test_write_packets(void)
 	/* open a test capture file */
 	pcapng = rte_pcapng_fdopen(tmp_fd, NULL, NULL, "pcapng_test", NULL);
 	if (pcapng == NULL) {
-		fprintf(stderr, "rte_pcapng_fdopen failed\n");
+		printf("rte_pcapng_fdopen failed\n");
 		close(tmp_fd);
 		goto fail;
 	}
@@ -480,14 +486,14 @@ test_write_packets(void)
 	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       NULL, NULL, NULL);
 	if (ret < 0) {
-		fprintf(stderr, "can not add port %u\n", port_id);
+		printf("can not add port %u\n", port_id);
 		goto fail;
 	}
 
 	/* write a statistics block */
 	ret = rte_pcapng_write_stats(pcapng, port_id, 0, 0, NULL);
 	if (ret <= 0) {
-		fprintf(stderr, "Write of statistics failed\n");
+		printf("Write of statistics failed\n");
 		goto fail;
 	}
 
@@ -499,7 +505,7 @@ test_write_packets(void)
 	ret = rte_pcapng_write_stats(pcapng, port_id,
 				     count, 0, "end of test");
 	if (ret <= 0) {
-		fprintf(stderr, "Write of statistics failed\n");
+		printf("Write of statistics failed\n");
 		goto fail;
 	}
 
-- 
2.51.0

