Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C53FD73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4E8940B97;
	Fri, 30 Jan 2026 02:14:35 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 5BF3E40687
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:18 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso16252425e9.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735658;
 x=1770340458; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbBk96tqE/zPvaA27s6XrfOAfUs7pLICJ9EkYivSEf4=;
 b=hNS62Kh++3M86gzaR9tKSteUxNwLb95SJV/F7fc1tay9QvuTMS3cddUshmgxObLD7n
 ObpOYpZot+ZDh/LLjZcQDFtV3NeZzLjwzP2dXr6pONFS6IzLiaH5gZf74LZAjvRrlOGt
 qcKPjyF4sGZu1gffCMPX264404v42dj+LdP4/faCRay90jJnG9Y84xjieVbXYwlT0GpA
 vRCMLm1TRhd+NQhpA4IGGbpLu+zmVy0lWaWU7V8Y4kQV2fmx01Gc36X4Bohff3wBCgCq
 Vr/LV6M6zTzeDImrFi6U5q0y3VpRGSUORQzJ4T3TFrBOK5PO8XryDOowXPQt79O/q5IS
 eZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735658; x=1770340458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pbBk96tqE/zPvaA27s6XrfOAfUs7pLICJ9EkYivSEf4=;
 b=FwK99RnGhdDgjOjVP5YuJsbUpcGF+szNGEiHfeWlri9d0UWvmZphCUV/7P6+BjTftz
 k7IKzgHrHz2xsPSVZZaRNZcAp0qC0Efja4tfg7iR514Yy7/kQTJwKwfMwquwdMaydOZu
 CANthz0v5cW0BoZ2igdnunCTOUw9wpGYRFB7AxgYR9a5fkTIPsclc2boOh8FP5tAcvYG
 Lj6OQrgSNkWOAWgRTzKlzH08CxMxN+SGBIijwWJzIOZALAzLgBFcRdzcxMKPm015Xbeq
 Dy330LTHbXwTdrsDeRr/UWBvqlpbPbXwV2IEYUN4xlC0c/ASfsxvSOMuZJTwKFAXmuv7
 SdGQ==
X-Gm-Message-State: AOJu0Yyb/4xRnKVueGCibQ5oy889AS0aGgaQwaTn4FVqS8VtdZfnMh8Y
 rm8iM7bHt6St1Swtb9bxIUtpIKvEfLqIPICVqTtT0Qp+mmXEAy0jTwuKazkZss8hWgNxqvp8obA
 YAKDI
X-Gm-Gg: AZuq6aKV17O5SGZgqJ/vxv4eKNijeAf63deWxlMJMdNBlmlvnSeBuE2T5ttUtpa7oe0
 1fn+BebUGQFzjBjEWapOvSlPVwEweWgtTPyiGa66f8axdm7OKRdtMKFjkWpPJxjp8Sj6ETVjsXW
 NVBJKS10WOTyUx4Ed/9fs77X893PfZu7EgitTRTr2Aai01gc+38meUAFDWLKI+GqOt6ry5j4DXq
 NTGa7DbvXiVAOdYj8XAmg/uxKTWOg/VawZQViVds2zEtTUUKDLuHufbL3h7O6VzWDouAWKd17G+
 rr1sRiPKz4Qi5KhkqRrfZ0hEbxMsGxmBkYAA0A3ZoqtD/AxVmkjNzb9e6fhzVnH4D9jmRA3V8jB
 Yb7x7yJsvawVTmSrDgZxoUXHsNoq8hHYOpO/I+Pv1pqt8yDxGQNtXx+ajgOA6kWpJxO2HOywEFA
 GhtdIQy30T1OS/5otUtprmW4G9r+dPwJXbVOpcNjME6ku5LXfwuw==
X-Received: by 2002:a05:600c:1e8a:b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-482db4a7a82mr9257095e9.34.1769735658002; 
 Thu, 29 Jan 2026 17:14:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 16/19] net/pcap: avoid use of volatile
Date: Thu, 29 Jan 2026 17:12:32 -0800
Message-ID: <20260130011344.204233-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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
index e7c4f3be5f..5e72a985e4 100644
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
@@ -837,11 +837,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

