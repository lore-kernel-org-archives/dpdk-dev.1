Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71229CF45DB
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:52:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F14134065F;
	Tue, 13 Jan 2026 01:52:10 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 1AD5440667
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:52:10 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so3748026f8f.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768265530;
 x=1768870330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3gHPjzRtPQjowX+ptBo6r9zy3jOZb2KWj0doClqHQQ=;
 b=Ui3CosIsN7Xb9fsiwAV1ajNSVMiSGTwMVZu3zdnyiLi0qxWlcOV1Fxh6TF0Yngo6KN
 msgbDo+9Z7UvdFSnl7UnJP7YffSzec6KO/EHFdanpSWLIVv8nfE2njbKGVR18R2heIJl
 IzJ5BSoPpaKWHGCt0fft1intXfEZ1pZjw5NqzZ3A4l8InMSru7ZeTPiN1wTeIu3ymQMC
 6+eJeWSZzRH1g4Kh6QF0odwj7qeq+AL7x6yZZ18Rd1yd2vxHLouUXV8awhOV3vi+U4qU
 t0mt/1pzFr/pnRiM4mc6JXSf3SHVWbJMqlrHcV86RnLxNXVTZNqZYVBNLgRb8A5DwgFd
 eCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265530; x=1768870330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d3gHPjzRtPQjowX+ptBo6r9zy3jOZb2KWj0doClqHQQ=;
 b=CV6hgUM07LepHG8L3eFd1WtmGo77BXnw1RGrU6geH1PRw2jmF2YGk/nCKp52BnlKcU
 EIVWtDmygxvKeRa1/p9IC8FkGlmKViknWqVFRdXq0JYH/AoREg24MfFTg6OmVNmsPCCk
 hPHzh+xTzf7GFVsWm/Mgmlc4XwUZ9vFNd8zVhQMhBwiCvSqGFUPI/TAA1m0V7CuwZ/AM
 ss47oNDRluRI3VkaThcftRYOlJHFdM7n1RBthkNIoIU1LSFzQyRqIohlkR0/V4KcxyMF
 fbpTGZTz7F7s8uuiGtau+z6JUhHovqVylq18xyM/4hWw7LUQYIOcxstJu8zpY6WbwI51
 53HQ==
X-Gm-Message-State: AOJu0YysGmxgBcsH14U7QwwEoIu6mI8D83+BA4P6r/K7GxKSEV6RTeuK
 EXLRP/nTmYfUySThVPexOv/lvLaZ4f0zS6R+YwreAraryB+4MC/tPGCmq3f183tOxAzydR4zvPw
 Fx5/o
X-Gm-Gg: AY/fxX6Sz0hSD9rWMoYpoCsG+2tI3Uc3iR5qSLr5pCIEWlPvao4otcT2yrFLbTE04We
 yJx7WTvKZdmjl9OQVrdnVzcNppULrMWq0j04KNM21j3xgtdcwpi2hCabVcczXjBvfmnWqMqM3XU
 ZIpSXzq6f0iUYYdC7PIOkC4b8JD/rhSgAdROi+nAZGTw1qISHxyTOuO50KT0uoktGV/a15EThC7
 /yVulqreXj7eQbFnXauWcI59llMIBtRrMFafdbMSG229TWlfdiRUX0SHEkjh4WdipTQAeI2uPxH
 vR986hiynH+dyA8biWypuy0eNVAKJ5+Zgg4CHvDfuzcDd6hgWYQoZwwXNl58zcI8+QZVU1Yme3N
 N5RSA0gfibfuKlBvQCV4pDNWHfx9L7SHcBI1aeueCPkAeXNg75cRr+Uavkp2Oko3f0sMvRT04sv
 rReseu4FW7SfmMuBKd827vJpLmlvCnsQCjcoYJGAabtclffAE5Cg==
X-Google-Smtp-Source: AGHT+IGN1Lb8QxJQVvE9/HRIKfJ0wdkptv4x8FGjlc9zi7jOYNgj8WyF2fvlrPQ2U10N7eMGdg9ezg==
X-Received: by 2002:a05:6000:2302:b0:430:8583:d182 with SMTP id
 ffacd0b85a97d-432c379dbb3mr22999815f8f.29.1768265529688; 
 Mon, 12 Jan 2026 16:52:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41603051f8f.8.2026.01.12.16.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:52:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 4/7] test: add more tests for comments in pcapng
Date: Mon, 12 Jan 2026 16:51:27 -0800
Message-ID: <20260113005154.44551-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113005154.44551-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260113005154.44551-1-stephen@networkplumber.org>
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

Add some more cases where comment is set in pcapng file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index bcf99724fa..09a963c676 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -125,8 +125,7 @@ test_setup(void)
 
 	/* Make a pool for cloned packets */
 	mp = rte_pktmbuf_pool_create_by_ops("pcapng_test_pool",
-					    MAX_BURST * 32, 0, 0,
-					    rte_pcapng_mbuf_size(pkt_len) + 128,
+					    MAX_BURST * 32, 0, 0, rte_pcapng_mbuf_size(pkt_len),
 					    SOCKET_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
 		fprintf(stderr, "Cannot create mempool\n");
@@ -149,6 +148,22 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 	unsigned int burst_size;
 	unsigned int count;
 	ssize_t len;
+	/* These are some silly comments to test various lengths and alignments sprinkle into the file */
+	static const char * const examples[] = {
+		"Lockless and fearless - that’s how we roll in userspace.",
+		"Memory pool deep / Mbufs swim in lockless rings / Zero copy dreams,"
+		"Poll mode driver waits / No interrupts disturb its zen / Busy loop finds peace,"
+		"Memory barriers / rte_atomic_thread_fence() / Guards our shared state",
+		"Hugepages so vast / Two megabytes of glory / TLB misses weep",
+		"Packets flow like streams / Through the graph node pipeline / Iterate in place",
+
+		/* Long one to make sure we can do > 256 characters */
+		("Dear future maintainer: I am sorry. This packet was captured at 3 AM while "
+		 "debugging a priority flow control issue that turned out to be a loose cable. "
+		 "The rte_eth_tx_burst() call you see here has been cargo-culted through four "
+		 "generations of example code. The magic number 32 is not documented because "
+		 "nobody remembers why. Trust the process."),
+	};
 
 	/* make a dummy packet */
 	mbuf1_prepare(&mbfs, pkt_len);
@@ -162,9 +177,14 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		burst_size = rte_rand_max(MAX_BURST) + 1;
 		for (i = 0; i < burst_size; i++) {
 			struct rte_mbuf *mc;
+			const char *comment = NULL;
+
+			/* Put comment on occasional packets */
+			if ((count + i) % 41 == 0)
+				comment = examples[rte_rand_max(RTE_DIM(examples))];
 
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
-					     RTE_PCAPNG_DIRECTION_IN, NULL);
+					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
 				fprintf(stderr, "Cannot copy packet\n");
 				return -1;
@@ -386,7 +406,7 @@ static int
 test_write_packets(void)
 {
 	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
-	static rte_pcapng_t *pcapng;
+	rte_pcapng_t *pcapng = NULL;
 	int ret, tmp_fd, count;
 	uint64_t now = current_timestamp();
 
@@ -413,6 +433,13 @@ test_write_packets(void)
 		goto fail;
 	}
 
+	/* write a statistics block */
+	ret = rte_pcapng_write_stats(pcapng, port_id, 0, 0, NULL);
+	if (ret <= 0) {
+		fprintf(stderr, "Write of statistics failed\n");
+		goto fail;
+	}
+
 	count = fill_pcapng_file(pcapng, TOTAL_PACKETS);
 	if (count < 0)
 		goto fail;
-- 
2.51.0

