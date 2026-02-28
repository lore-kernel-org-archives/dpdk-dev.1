Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2BAFEE4F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E4C740B9A;
	Sat, 28 Feb 2026 18:56:14 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 5D27340B9F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:56:07 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso1784184eec.0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772301366;
 x=1772906166; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diWJWVXFY++Sk/rn2O7TGIlvSZn3KcQLBTem9aLHIxY=;
 b=Cq3qNzNmUN9F+ZUTuY7hUpg1FtgeaIuyACSvA2E9IUyJV7iPMfKIZ+DtP88c0d+Va9
 CtjFzdFuyTW/rpL2sMOu0cfS2BMNvUtgG/S3YXvSpqmokUKPpYVxbXf/e/Kly6eSQQX8
 sjdZZQ311i9tWFdV8TsK1u+fLF52rZG1JZN2yVDLzodMZIKwXdO8wadMiV/ML5uYFTcP
 bn8NeAf2SUt8EblnZ5BVcFEiqLeGB7xbaUeS9whlxPFTMPOKKWBBv4a+t6KaCgMmWs4E
 0jSHW2ozvzZnR2F64RtzB7yiE/D4mgQoaVSLPpffz3/RONJtz7lioZL+Mji0NLAoKRob
 2KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772301366; x=1772906166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=diWJWVXFY++Sk/rn2O7TGIlvSZn3KcQLBTem9aLHIxY=;
 b=DYaOfAwW3lY77JzZ/DHpXyJXl3zeWZitt1/4O/dV3GGXkATSSAkdcxzNqO3lHE21Q9
 KpjfxJNjktBAyF8nDl/RxmLOBW9E5wWYQ4JNNHkwlarf3dn4FLEuR4tg2tVOslOk+k1/
 DQQIYTgbo8/rPR/DLKppztfIpBNulcBSBabgM/1OibacwqCawehIFkTbv20BmOw31Wyp
 hsCrrRQD8amv/Dg5Hh7awWtEFY0uP+bMcljRE2vGXhSfh4WhA5RHGwtqnVCZvs2YRdsO
 jQSAZN1dpUdffPmYy4WLXoV0NHB3sTo7Ed69r2j4JfPTlw52QLFGnjCLoxvxVDaMtBlX
 QQdg==
X-Gm-Message-State: AOJu0YwIk/qFmPZj+XxG/+s0Q2EC5CkX8y9rsaGUdXM82DRQDAXHh++N
 XL7zNm+Jce2/zYPED4w44ioN5+mo+2AVsQToMNgl+If0W9vSxUEduO/mTwGu1EnMu1mYQAzxztI
 mXo6S
X-Gm-Gg: ATEYQzw8SLvbDv3v2vup6on2opKAJW21E8zsT4OelClfUDeAfUUvMgskEoAJWYlBWzF
 ttzwjuK/E+Sb8uRhBFl93xyuC1a81VMatUEwb19g+E05ZkDmKepOSqQ3bCao0yzsD7ukULGRKY7
 +j+JIsZpcAvp2NqGrD7es0uFdcL+9a1aIZR4LwwZlVZddpUlnnNGofI8BBg7aZUVEjzzU5OTABO
 7sgAVW83KwofnwNVx4AtTMuhzTp+42+b3Nmi4i9n5qKH7Y3Cb3guui7pqpzzaX01GrVHL9WFwVW
 +4FLf/sErvO1QcpXAO/Mqdrq0vF1EbjS5O1ITTmawbFmJc2N26+Hy/lETVVfS/pnwtYmXQ8ea2S
 bS3kUJS7mEF1aksUmLeGcW/gbuEpjZ7sff9gOtIaowD4SiCFksiWz8DV8N90HoaXq3QFILrylmM
 9G5OkO+LH7omtbBunmIVgpjN/Pobc7yESzeostQhO6McxSNzF1r4b3aYoO2/sk+A==
X-Received: by 2002:a05:7300:a191:b0:2ba:9e39:23ad with SMTP id
 5a478bee46e88-2bde20dc79cmr2329211eec.13.1772301366322; 
 Sat, 28 Feb 2026 09:56:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfb3f898asm824584eec.29.2026.02.28.09.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:56:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 3/5] test: better logging for pcapng test
Date: Sat, 28 Feb 2026 09:35:02 -0800
Message-ID: <20260228175601.585102-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228175601.585102-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260228175601.585102-1-stephen@networkplumber.org>
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
index af31e7d996..53b806833b 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -222,7 +222,7 @@ test_setup(void)
 
 	/* Make a dummy null device to snoop on */
 	if (rte_vdev_init(null_dev, NULL) != 0) {
-		fprintf(stderr, "Failed to create vdev '%s'\n", null_dev);
+		printf("Failed to create vdev '%s'\n", null_dev);
 		goto fail;
 	}
 
@@ -232,7 +232,7 @@ test_setup(void)
 					    rte_pcapng_mbuf_size(MAX_DATA_SIZE),
 					    SOCKET_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
-		fprintf(stderr, "Cannot create mempool\n");
+		printf("Cannot create mempool\n");
 		goto fail;
 	}
 
@@ -304,7 +304,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
 					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
-				fprintf(stderr, "Cannot copy packet\n");
+				printf("Cannot copy packet\n");
 				return -1;
 			}
 			clones[i] = mc;
@@ -315,7 +315,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 		rte_pktmbuf_free_bulk(clones, burst_size);
 
 		if (len <= 0) {
-			fprintf(stderr, "Write of packets failed: %s\n",
+			printf("Write of packets failed: %s\n",
 				rte_strerror(rte_errno));
 			return -1;
 		}
@@ -326,6 +326,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 	return count;
 }
 
+/* Convert time in nanoseconds since 1/1/1970 to UTC time string */
 static char *
 fmt_time(char *buf, size_t size, uint64_t ts_ns)
 {
@@ -333,7 +334,8 @@ fmt_time(char *buf, size_t size, uint64_t ts_ns)
 	size_t len;
 
 	sec = ts_ns / NS_PER_S;
-	len = strftime(buf, size, "%X", localtime(&sec));
+
+	len = strftime(buf, size, "%T", gmtime(&sec));
 	snprintf(buf + len, size - len, ".%09lu",
 		 (unsigned long)(ts_ns % NS_PER_S));
 
@@ -358,6 +360,7 @@ print_packet(uint64_t ts_ns, const struct rte_ether_hdr *eh, size_t len)
 	rte_ether_format_addr(src, sizeof(src), &eh->src_addr);
 	printf("%s: %s -> %s type %x length %zu\n",
 	       tbuf, src, dst, rte_be_to_cpu_16(eh->ether_type), len);
+	fflush(stdout);
 }
 
 /* Callback from pcap_loop used to validate packets in the file */
@@ -368,6 +371,7 @@ parse_pcap_packet(u_char *user, const struct pcap_pkthdr *h,
 	struct pkt_print_ctx *ctx = (struct pkt_print_ctx *)user;
 	const struct rte_ether_hdr *eh;
 	const struct rte_ipv4_hdr *ip;
+	static unsigned int total_errors;
 	uint64_t ns;
 
 	eh = (const struct rte_ether_hdr *)bytes;
@@ -386,18 +390,19 @@ parse_pcap_packet(u_char *user, const struct pcap_pkthdr *h,
 
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
 
@@ -406,8 +411,9 @@ parse_pcap_packet(u_char *user, const struct pcap_pkthdr *h,
 error:
 	print_packet(ns, eh, h->len);
 
-	/* Stop parsing at first error */
-	pcap_breakloop(ctx->pcap);
+	/* Stop parsing at tenth error */
+	if (++total_errors >= 10)
+		pcap_breakloop(ctx->pcap);
 }
 
 #ifndef RTE_EXEC_ENV_WINDOWS
@@ -440,14 +446,14 @@ valid_pcapng_file(const char *file_name, uint64_t started, unsigned int expected
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
@@ -478,7 +484,7 @@ test_add_interface(void)
 	/* open a test capture file */
 	pcapng = rte_pcapng_fdopen(tmp_fd, NULL, NULL, "pcapng_addif", NULL);
 	if (pcapng == NULL) {
-		fprintf(stderr, "rte_pcapng_fdopen failed\n");
+		printf("rte_pcapng_fdopen failed\n");
 		close(tmp_fd);
 		goto fail;
 	}
@@ -487,7 +493,7 @@ test_add_interface(void)
 	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       NULL, NULL, NULL);
 	if (ret < 0) {
-		fprintf(stderr, "can not add port %u\n", port_id);
+		printf("can not add port %u\n", port_id);
 		goto fail;
 	}
 
@@ -495,7 +501,7 @@ test_add_interface(void)
 	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       "myeth", "Some long description", NULL);
 	if (ret < 0) {
-		fprintf(stderr, "can not add port %u with ifname\n", port_id);
+		printf("can not add port %u with ifname\n", port_id);
 		goto fail;
 	}
 
@@ -503,7 +509,7 @@ test_add_interface(void)
 	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
 				       NULL, NULL, "tcp port 8080");
 	if (ret < 0) {
-		fprintf(stderr, "can not add port %u with filter\n", port_id);
+		printf("can not add port %u with filter\n", port_id);
 		goto fail;
 	}
 
@@ -539,7 +545,7 @@ test_write_packets(void)
 	/* open a test capture file */
 	pcapng = rte_pcapng_fdopen(tmp_fd, NULL, NULL, "pcapng_test", NULL);
 	if (pcapng == NULL) {
-		fprintf(stderr, "rte_pcapng_fdopen failed\n");
+		printf("rte_pcapng_fdopen failed\n");
 		close(tmp_fd);
 		goto fail;
 	}
@@ -548,14 +554,14 @@ test_write_packets(void)
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
 
@@ -567,7 +573,7 @@ test_write_packets(void)
 	ret = rte_pcapng_write_stats(pcapng, port_id,
 				     count, 0, "end of test");
 	if (ret <= 0) {
-		fprintf(stderr, "Write of statistics failed\n");
+		printf("Write of statistics failed\n");
 		goto fail;
 	}
 
-- 
2.51.0

