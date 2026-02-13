Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765DDEEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41B8B40A75;
	Fri, 13 Feb 2026 18:04:05 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 723D94069D
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:04:03 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-481188b7760so10176395e9.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002243;
 x=1771607043; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3QLGJ3Kv2O+in/unqUND9ov/Yy+05VXloTmkfnYhK0=;
 b=3U24Ce1ReqqiyBg6tLT10b5azqRC4hDCe1Nb0w3hELyCUyXHyVXSLOfbZSZq1faYhj
 2Lt1KdlJZ8UyGyw/z66sFMefJLCP1E7P6zZqaVuIuXjZdNH5rLH8c//9InERiuOexFMy
 8ZRpzVYYu3EPiXTJllihxR+tMJhNasExZAwrRBajWlE4zOObenhBRgTb24BaWoIxhZ8l
 yIhOAhU2X+kReFRetQhv9do8VaRbFYP7BAwg0thrdLgqMXtMNAWhQM7ZMqp/t1+wxVbN
 x1X7Q7yj/yQArMz2FPuDBfXToBkiYbmLAivt9LC0K4sdPtqj0VAWov8txRSEGDVodwJ0
 f8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002243; x=1771607043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3QLGJ3Kv2O+in/unqUND9ov/Yy+05VXloTmkfnYhK0=;
 b=vZssy6cC9iY6Oi4qfhtgKqsEOW2QbMQqw9LAj44tD+oeZFpYQyrbXEOEwPncE2J69f
 6CdzP9WEzrccLfQlWoWQujYbuQt+l5DBN04pcZ8epq24stqxm68xdoQ1HR7+u5JyP2kj
 hkiPpNbs8gXVPZdRpkN0eANS4sZtMLNzZEbMy1Q4rFpsvOo8ao633mI+aeYAEivP1+/J
 WSaJkHTG9tdlq3VglYPkBwYk8J8shRULWXMOhiSG75pFPg0IlnmItGpFuDPi4SGjgf9M
 2rfaJB5THBqfP2X/ghl8Ie1kqGLUU+9JIQj+6gfOqgjoPsRrSCj6UhQRe9eUrCtAC9tR
 Ef8A==
X-Gm-Message-State: AOJu0YyBGh7OwcO6bYzQhmNovCHSWbowSd9WUnMjy7Qf52goi32lnY7T
 sf3WU9d+dLlN3UWWh/7fBiH1QB2aCYSWYgX0LFVP+RLTCuY6uLgyR419uOtcf7tmCgWBUoXZrJ6
 AH5Oy
X-Gm-Gg: AZuq6aImt2r3JbhWOiuVLZzerE+AHHJv8iTDJIfJjKyiQqHQmMo9F4bhvNlOJ6t7ptU
 lyE0OeSvY3fwiDGqAYLynTfdjJxZZ8AtJx/ctjyQGISC/q9WWaMVASRXo5KBHE/Oyk1uh8bm6MG
 4YdhwNNceWLFdY3cJsuqWQlAlCPSoBb9xUqD8bMTWwQdVndQq7iD3oq6HtSePdPRjA12JsXcCb3
 QjXHs08FCtfZmIJlIlYxtkMALziY4lfH66hSyA4gTJQopv0HpixddJcDq0dQ+TtBALwitrngAk/
 Q7DC2lvu8RGLhbRoKN8G4prjoHVqWH81AzElsZsJ6IfD24hubi702zyDTo3m4r+e3alQZr6O2T6
 zYK9NEG2wgxEaaW6MNSKYSP3scPLTz2F9QvcbcgTyKG8t2LIdIQcPZ2Hk3DXvwt1h+UceFn5Tri
 4NU+RPEG5AIHVt8RBpsG+Dp5d0fUWBdCZyCisDX83dAaKdLHWKcDYoCzriESoqhA==
X-Received: by 2002:a05:600c:1381:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-48373a58140mr45018075e9.33.1771002242869; 
 Fri, 13 Feb 2026 09:04:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:04:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 13/18] net/pcap: avoid use of volatile
Date: Fri, 13 Feb 2026 09:01:36 -0800
Message-ID: <20260213170333.40089-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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

Using volatile for statistics is not necessary since only one
thread is allowed to operate on a queue at a time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 16472ca068..eeac0cffc8 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -55,10 +55,10 @@ static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
 
 struct queue_stat {
-	volatile unsigned long pkts;
-	volatile unsigned long bytes;
-	volatile unsigned long err_pkts;
-	volatile unsigned long rx_nombuf;
+	uint64_t pkts;
+	uint64_t bytes;
+	uint64_t err_pkts;
+	uint64_t rx_nombuf;
 };
 
 struct queue_missed_stat {
@@ -928,11 +928,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	      struct eth_queue_stats *qstats)
 {
 	unsigned int i;
-	unsigned long rx_packets_total = 0, rx_bytes_total = 0;
-	unsigned long rx_missed_total = 0;
-	unsigned long rx_nombuf_total = 0, rx_err_total = 0;
-	unsigned long tx_packets_total = 0, tx_bytes_total = 0;
-	unsigned long tx_packets_err_total = 0;
+	uint64_t rx_packets_total = 0, rx_bytes_total = 0;
+	uint64_t rx_missed_total = 0;
+	uint64_t rx_nombuf_total = 0, rx_err_total = 0;
+	uint64_t tx_packets_total = 0, tx_bytes_total = 0;
+	uint64_t tx_packets_err_total = 0;
 	const struct pmd_internals *internal = dev->data->dev_private;
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-- 
2.51.0

