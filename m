Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1E3FD45FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18F014065A;
	Wed, 25 Feb 2026 23:59:27 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 0E32F4042F
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:59:23 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bdc8bb60f5so124565eec.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772060362;
 x=1772665162; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utBId3X/cPQEpqShEYZx97lpDuST7rgnGQNZuC8XRSk=;
 b=rG1jtem9g/IUT8rGAx9IX9Bm4A4wfZdqVOl61vuwaFqbeJ5xI2k6QEqr6bCj2//FHh
 HXz5Y3f3rZCqmOJGu3uIokhc5LhQUobkMlGpTL0yY2EeKfsCHgIudFncgBKHjXxkgjeL
 /RIs70B211l9aKPf5KHsdUpO6LOz3mO/m86Qm/Hex5EcmaYroNrVV2yTEzaXDTgiOsqv
 jfMxKCwBFyDnvqSd9PfnsgHVk6Xbn7RyrRzII7H9dqgdyjlNZ60AnULwsYn+zBmvgfPG
 QOaxICSa4W+Il4mq2Y7dkaHUY2NDcRbR52vC/K+XV+MPvwaTonI3F2V9FfqKWXCpyTPp
 Dxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060362; x=1772665162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=utBId3X/cPQEpqShEYZx97lpDuST7rgnGQNZuC8XRSk=;
 b=jwWaoq2kYnv0XRk1ygppI8mBfFrxZugbzU189dLjoI+Iobi/s+boB+XRo8w/0r3Oap
 uAZdH9XVzQbTqOBzjZQiGxwYGGBnLNpHpoFEShMupwdC3B3fLGP/gM7Jx05WGmiYuW76
 gt+aWIXczxCktxpL1u7XUJ3OmnSW8JwEMg2EhBFQspgQVw8XxTGkfAIad+2DNjGOwjEb
 8JytFW95MnV8Y/smC+RyfXDJ1xjkH9zBHOFfupLsK8XmDa0vJPmJCEkMbw+DufzGt+m1
 /7ygGnDEGBDLC0xJRcc7s8RUKcY0r4cegIOFfl4sesWeH8Y5W1LSet9c41F4d7jpfpDX
 hPzg==
X-Gm-Message-State: AOJu0Yzev0helwmRMmq44htJM0Oy0EZA/Ilu5jDg/CACOjcVEILLt2zQ
 dg79DoGiFmkDf9rtl763oMV9hXQaq87eYtribEW6pkzVD428kLEend0Q4n2Og+mUPS2WXI3v9D9
 BJ9OAZJ0=
X-Gm-Gg: ATEYQzyGh5CgntFsGbprcpNRfmUQX0jHjJMfDkOhQD0IeJ6rccfzOmDG4XX4FwmizrR
 tR6T7v2oic8B79LZGHQPDytTJyvzu6oIEhktRpPjtIZERnOvvBf9itjbzvj4AwVk3hAj+bP1H9e
 hcGvAlsQIaBiiXjv0okSJPnPwC+ptSREBpA3/X/GrGTBozroLdTQFg00AX/4c4fmc1Uewox0H8A
 CIlPByzvx2IgyYiLtmhq6VuLrEJbNRrLElBC3O6opHWJl8HrAZ2bKZgC9mm2Yln/UkbWvATisDD
 qdE9/xU9vO6JSG3nN1FVzuogBnqiK4L2fA3qcx7rcIuVat3NzqQcL3VtJS+n/xx96SAq1u0/bZe
 g8ZG3Kba6SMEl/0X0S6RKU5dYmwofvnNokcVavGQc6GmipiN/ASRxsWfVhHwuzNXmu9n+OMO6qb
 8H+jX9e6CzGEV1bwJzo8uwX5pAAygmrUqDDLGLL6qF5c3gk+77ujjWw5Q7v3F/XQ==
X-Received: by 2002:a05:7300:d518:b0:2ba:70d6:e371 with SMTP id
 5a478bee46e88-2bdd2fe6c7bmr105870eec.19.1772060362045; 
 Wed, 25 Feb 2026 14:59:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c47sm411104eec.19.2026.02.25.14.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:59:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 4/4] test: add pcapng test for copy before open
Date: Wed, 25 Feb 2026 14:57:19 -0800
Message-ID: <20260225225916.518790-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225225916.518790-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260225225916.518790-1-stephen@networkplumber.org>
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

If packets are copied before open is called, the timestamps
will be before the start of epoch. Add a test for this which
makes sure pcapng file is still valid.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 82 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index af31e7d996..69a8f44f1a 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -585,6 +585,87 @@ test_write_packets(void)
 	return -1;
 }
 
+static int
+test_write_before_open(void)
+{
+	char file_name[PATH_MAX] = "/tmp/pcapng_test_XXXXXX.pcapng";
+	struct dummy_mbuf mbfs;
+	struct rte_mbuf *clones[MAX_BURST];
+	rte_pcapng_t *pcapng = NULL;
+	int ret, tmp_fd, i;
+	unsigned int count = 8;
+	uint64_t now;
+	ssize_t len;
+
+	mbuf1_prepare(&mbfs);
+	mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
+
+	/* Copy packets BEFORE opening the pcapng file.
+	 * This exercises the negative TSC delta path in tsc_to_ns_epoch().
+	 */
+	for (i = 0; i < (int)count; i++) {
+		clones[i] = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
+					    rte_pktmbuf_pkt_len(&mbfs.mb[0]),
+					    RTE_PCAPNG_DIRECTION_IN, NULL);
+		if (clones[i] == NULL) {
+			fprintf(stderr, "Cannot copy packet before open\n");
+			rte_pktmbuf_free_bulk(clones, i);
+			return -1;
+		}
+	}
+
+	/* Small delay so fdopen's tsc_base is measurably after the copies */
+	rte_delay_us_block(100);
+
+	now = current_timestamp();
+
+	tmp_fd = mkstemps(file_name, strlen(".pcapng"));
+	if (tmp_fd == -1) {
+		perror("mkstemps() failure");
+		rte_pktmbuf_free_bulk(clones, count);
+		return -1;
+	}
+
+	pcapng = rte_pcapng_fdopen(tmp_fd, NULL, NULL, "pcapng_preopen", NULL);
+	if (pcapng == NULL) {
+		fprintf(stderr, "rte_pcapng_fdopen failed\n");
+		close(tmp_fd);
+		rte_pktmbuf_free_bulk(clones, count);
+		return -1;
+	}
+
+	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
+				       NULL, NULL, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "can not add port %u\n", port_id);
+		goto fail;
+	}
+
+	/* Write the pre-captured packets — timestamps precede tsc_base */
+	len = rte_pcapng_write_packets(pcapng, clones, count);
+	rte_pktmbuf_free_bulk(clones, count);
+	if (len <= 0) {
+		fprintf(stderr, "Write of pre-open packets failed: %s\n",
+			rte_strerror(rte_errno));
+		goto fail;
+	}
+
+	rte_pcapng_close(pcapng);
+
+	/* Validate the file is parseable — timestamps should be
+	 * slightly before 'now' but still reasonable.
+	 */
+	ret = valid_pcapng_file(file_name, now - NS_PER_S, count);
+	if (ret == 0)
+		remove(file_name);
+
+	return ret;
+
+fail:
+	rte_pcapng_close(pcapng);
+	return -1;
+}
+
 static void
 test_cleanup(void)
 {
@@ -600,6 +681,7 @@ unit_test_suite test_pcapng_suite  = {
 	.unit_test_cases = {
 		TEST_CASE(test_add_interface),
 		TEST_CASE(test_write_packets),
+		TEST_CASE(test_write_before_open),
 		TEST_CASES_END()
 	}
 };
-- 
2.51.0

