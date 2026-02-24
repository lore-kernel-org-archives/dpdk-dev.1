Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE21F3C991
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B6340661;
	Tue, 24 Feb 2026 16:27:36 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 586CD402E9
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:27:33 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-126ea4b77adso6844612c88.1
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771946852;
 x=1772551652; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVD+SHifM2I9xnM+dVyVVnoYTkkFRNYlfMFG/JJuSrE=;
 b=SC6evwfqefHOhwhEcieqsw9TLHndZ70Jr4BowVMLTHmzUyCk5tU3ASmdnZ/GQ1yKpo
 w8/DPkqb89SOQ5tr+mqpJafrGax52Gien0VM6eaw2eNP/wnyDeORu2cvo870ETinrkEa
 bAbSDiryEk8PKMRTvrJ0GlDXdWyk2BlQWlk8BW1vfEe+qi4FVyh//L5u/gGdLg6QtHHr
 sXy2RU9sPFIrb0sEMZWfnLXTFRsEGhdG6j8qX1MmvFj0s2t3a0X/0Zth+PNUR4D3P+29
 1Wc5rREGTNhuEPeJ0BQAFyfqlP5A3HJDUjlbMQIL634Zn0+o2GwXrTSQUrLNY3+3xk0x
 IgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771946852; x=1772551652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qVD+SHifM2I9xnM+dVyVVnoYTkkFRNYlfMFG/JJuSrE=;
 b=RySWh4rQsxdByaIOA5eeQ4zguBo2+chQFrNr50zDm18//uteu+TiIvZH5pFmvOb8GY
 7HDJs5ZwUSZDUWRikLgwtJY5UWanc7Q+6o5n5jvbB9uoeTYiO3QChXk66IyF6WcFHGYG
 uh8dZH5U5pbhX4ZdZqzKp6XHM0hPrpHrFrPFMa21//wnX7mGhjRms92muoDKN3JJzrnT
 KtQdgVczmViMpchlXcJS+4mMa8/IivWdJTTmW3sckw4tLtL43bLkmxkg1i89GucGi/NY
 YXXfgC7uVTyGzFGajAhI0xMvdk8EroSj7c+izWryLeVs1X16aJjpvuvDMdzMQpWRHUtO
 aJAA==
X-Gm-Message-State: AOJu0YxuI72dnreNvKo2H1S4YJA20ZLr+2tNBk1tt6kzafmaxPYaOQY9
 nZ3ktekfIfqGaGSxMfpJOAwoujyjQFSnyOEpP1RzJo3etT67bu2PQJ4PZqLcL4DsPp81+XujnVm
 e8NNU
X-Gm-Gg: AZuq6aKlQlt9YhvSR51AyjvF4zVVdKz5rEGvGhR0dOvCEhrhw8wXlOiNQMto15R7dgq
 hdaVB0ZAdgSHRFyfkSWP7Iu9NvwSYszrCCUk1DiTa9MQNrHrfZ6Zfu6Y5Y/2aKvuRqxc3vpUr0f
 gkVNlDpV06SdNSTF0iLm/rBHUqkqqHS+8gp+Yf8VlzkmVVQ4KWxehwoUAlvNhXmHfHOZx6oFvtc
 hVODnyTfJV1mK/rqU1nmoVuC/3JnRE4xIyheJjm9ng3y4hatls/JIi1PfBUVQZkW0VSedk+WA+k
 E/DEB6AeZMS12jPpXHrNASAypeHVfwW8Ogy5R1au4iZASCfYXZESVUNsaUXuMQwdo1ML/o1FRgl
 oh0K0zJkJg1LOr1mKafZcKXwzsAm3oGwI3o23ORDY6V4RKJqsniu0OvZx1+2clXfiOlekK1aOMv
 jNe3NsoU98zA5/sTKcv3AUi63bHpkswxdlFeGfmViZfQqWeJ3f5fepG/Kawu1RXA==
X-Received: by 2002:a05:7022:68a5:b0:11f:2c69:31 with SMTP id
 a92af1059eb24-1276ad6a75fmr5071018c88.46.1771946852312; 
 Tue, 24 Feb 2026 07:27:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af7b4c7sm10728774c88.9.2026.02.24.07.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:27:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 3/4] test: add pcapng test for copy before open
Date: Tue, 24 Feb 2026 07:25:56 -0800
Message-ID: <20260224152726.567604-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224152726.567604-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260224152726.567604-1-stephen@networkplumber.org>
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
index f0faead728..deba08cc6f 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -574,6 +574,87 @@ test_write_packets(void)
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
@@ -589,6 +670,7 @@ unit_test_suite test_pcapng_suite  = {
 	.unit_test_cases = {
 		TEST_CASE(test_add_interface),
 		TEST_CASE(test_write_packets),
+		TEST_CASE(test_write_before_open),
 		TEST_CASES_END()
 	}
 };
-- 
2.51.0

