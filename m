Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2659E92FF3
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 23:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 138524064C;
	Tue, 30 Dec 2025 00:02:35 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 9A62240647
 for <dev@dpdk.org>; Tue, 30 Dec 2025 00:02:33 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b7697e8b01aso1744189466b.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767049353;
 x=1767654153; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmTGzv+JCWrykuXqU1JExJniJvskIzYAUQOcdQtwsmg=;
 b=mYNetpiu5Y+8/tV1x/tcraqihn1/1elzzq9X/IkG4EyU+PTooXwmGodj05EZ/hg66s
 HQX69fpEbCjFHYvNmbV0RI4fc6iWGRnyjqM6Wlyz3JQvbXuKgwCXdfBafZcf4sNfUoHf
 p9M2mvgG10G6dlMioNf5hoPoLAD/Lkrgg22oMRDvhK6EdLRAQCLyq1dnri/us//TWgP8
 YRkmnNOtoR3APNCHFosLRhCROOpPTM0TOC/UE5BVt6HI5SSD1v4zdOWnm7CHMO+shLa9
 Q3Pwg/v/7vHAkeXFJOWPx6gEugoMjadhDJv8e/5OCbuW139P7phmvHK6FICoXx2jpNVf
 /A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767049353; x=1767654153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zmTGzv+JCWrykuXqU1JExJniJvskIzYAUQOcdQtwsmg=;
 b=HzqCmxyIf7YDkJKFly3CScAcpv16Ox3njLerbfPlpNqz8/uLpzDfP03N4UCxSwvJP7
 AL03H5Tob9/xqc7AM7rzzS/FbEvu7io/S/Fs8MoljSYRVr2Ib3zE3OeEP3ho24E5IApP
 mhWd6wAudZdqil6LtyYnbOHI6W6hc9sGMzttZQC5edahy+aud3nJdbo5+NbAeAsvPbpy
 7EOZF9VKiTGUXbKZ9S67GBKYX1tpwQ43P1mY9cheAoiaUxuZPErIcukWTZiFpZXemctz
 xxTIY+7cg+QEjxM2EPj/OdizgU6P7j8MVadPI0ghMVxLrwhypdnK3mfwsvM5qSvhnSwT
 GzgQ==
X-Gm-Message-State: AOJu0YzBdzw+/4QdpO5ysD4rmL2dSz+uhXjhdrOXQv9st8ac/K1I/TMM
 udb8V1io8GCY2Jj6lV2OzbKIQ+6xRSItLrsq9RMTuWWA/7sZh2j6m/X6wN0rkqhH486V6S6eTfQ
 5jj+JL5U=
X-Gm-Gg: AY/fxX6mAxXSwiaqyr1oFyp2yaIvvX1iTyLqBNn8I1xwT5yXP8DucGfCiIjhfso3QxQ
 Q1Mgg5+UhdlcKmKA05OeeOjdMkHupM6CgHBFYzeSzYtGsE0AaOa4pLq2rdjE6SlvhY08YKLiodS
 tvmXUw6ohHbVDJaUQVYrHo5odaKD3/TUAa8BF9vfeYb5yJHu0vtEt2vcYYkiWN4Sqg6VCt0B+o+
 V9VdQMs2i9Eq0Nzfxm0HZXpaoRGVtq49OGHO47BQ0DksOXcX+Y4AdujQjTizmDjbBNbvaWl1G2y
 W/oxFFzcupvkFHuR32hQ9eYB3p4j4BA8kfBjZ1Np3pMv7DkfYhcvX6jW65OCyKzE6gnWV7I4AL5
 LwR+esi+ncXESik8RjId71bt2jTU2Sp1++xKy8Wl7lnjnb/F/U/p4M0IU534exoQxuYkt1cVpAE
 AWKxO2YYjb7jZbgHZhm1U9x2VQMdX++ss2uy9Mon8krUiwozR2ZQ==
X-Google-Smtp-Source: AGHT+IHBQFg0WCnBdxBMDqlbrg/8w2yOrzDDu/ziWoxzWbBkNlcI0kYZRjySy2bTjqFhdWal4qOzfQ==
X-Received: by 2002:a17:906:7312:b0:b7a:1bde:a01a with SMTP id
 a640c23a62f3a-b803721826bmr3515527666b.62.1767049353116; 
 Mon, 29 Dec 2025 15:02:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b830b5fe8cfsm1933148166b.59.2025.12.29.15.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 15:02:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 3/6] test: add more tests for comments in pcapng
Date: Mon, 29 Dec 2025 15:01:06 -0800
Message-ID: <20251229230223.151874-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229230223.151874-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20251229230223.151874-1-stephen@networkplumber.org>
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
 app/test/test_pcapng.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index bcf99724fa..f2b49c31c7 100644
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
@@ -149,6 +148,13 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 	unsigned int burst_size;
 	unsigned int count;
 	ssize_t len;
+	const char *examples[] = {
+		"EAL init complete. May the cores be ever in your favor.",
+		"No packets were harmed in the making of this burst.",
+		"rte_eth_dev_start(): crossing fingers and enabling queues...",
+		"Congratulations, you’ve reached the end of the RX path. Please collect your free cache miss.",
+		"Lockless and fearless — that’s how we roll in userspace."
+	};
 
 	/* make a dummy packet */
 	mbuf1_prepare(&mbfs, pkt_len);
@@ -162,9 +168,14 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		burst_size = rte_rand_max(MAX_BURST) + 1;
 		for (i = 0; i < burst_size; i++) {
 			struct rte_mbuf *mc;
+			const char *comment = NULL;
+
+			/* Put comment on occasional packets */
+			if ((count + i) % 42 == 0)
+				comment = examples[rte_rand_max(RTE_DIM(examples))];
 
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
-					     RTE_PCAPNG_DIRECTION_IN, NULL);
+					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
 				fprintf(stderr, "Cannot copy packet\n");
 				return -1;
@@ -386,7 +397,7 @@ static int
 test_write_packets(void)
 {
 	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
-	static rte_pcapng_t *pcapng;
+	rte_pcapng_t *pcapng = NULL;
 	int ret, tmp_fd, count;
 	uint64_t now = current_timestamp();
 
@@ -413,6 +424,13 @@ test_write_packets(void)
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

