Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8FDD232C6
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F82940A81;
	Fri,  9 Jan 2026 02:18:13 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id A49FF40A7A
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:18:11 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b7ffa5d1b80so572472266b.0
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921491;
 x=1768526291; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5t/8/ccRGXKCVyKEpoFO86vqFS9ka9YrTyd7ZZY2QA0=;
 b=sV/dXsgFZ4dJK0XlNoEai/cqzt7jZ/gZ+XXiQQJ/Ey1bpJ38uHIzqVnfRN4YvMRMwt
 83R5brrxkwvv9HFL175GmnKeWO3Dy9qLeD7QC+UWPFh7i1pkUMZgMrTvOzoYGb/gs7UR
 2vGCexWCE8NnHzjZimhHiUPAEwhpibsR+DH0Wuki9djzFXIY5mj2zj73uJVshiz7p0Ob
 VGppXccLKOipHvhLhi02SyVUW5NyKRESkpwhKv3Y8J84nBX1VzJ0QpRUiEc84g3pGmuZ
 2UOs7B7SxIK97geJtfpDasMXlqr39+MCZpAblS9MTKerJab7ciSxJ6B8TrpzjW9L/ddb
 vNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921491; x=1768526291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5t/8/ccRGXKCVyKEpoFO86vqFS9ka9YrTyd7ZZY2QA0=;
 b=mJMaVTbLPPcA7tQh4SNvQYW5ZRq2JY40B/6Mc6om+3hASeAn5xw55Hw5YIKffwhsFu
 HwDRvOC9Ec/QQsXLeQysWx4zELjIkKPPnG+MAgI7pE1oUsLRlkMyrwR5IfwE5XOU1j7S
 gfrO0CAYAJNLry2pfVeWhqXVX0Vl8DQCK/tfIbkfM/d+wLB4Di0MVUvvDHpMoUY0rpcr
 2kvu24zTSSDxNI8KlqA2lj0ruQh5JxlwQcOAJimy0xKfrFxEEQbzh1CXyQxl5zwb61F+
 Dcn+43Tw53s636ydGaC8ZfWnMc94gWexzH3NzzG+cx9EzmDgwyIShLpBiFCPo5tied2k
 +YqQ==
X-Gm-Message-State: AOJu0YxyPbZG81pGnh1B7uO2jM7g/BceltP+/1YXmeJ+c0x1WiViicB6
 GOYkeIfMk7O+twFWgCcNMIOrLWKpEqzOIdkKHJwaXQ5hRXDfX5BV9LIKIr/wh4kjNIifK1gIh2Y
 Uad43
X-Gm-Gg: AY/fxX7mdJ5btqqfWjgQewNZyuSODW4Eclp2KYJtYac5CjtAzs+G51uAiKWCJ6g8OYf
 n5fP2P4v7KjkXGt2jNhXdBtoBkMF41rRpum8VurLTYInELn3xOpAmFdMgIiqULcNinuM6Cke/9B
 X0Ptzqh7NMDWRPqKOS/Pfuu1bybCU5vWQRGttAacrL5wKnYqVMJVf5719N5hiGJ8QTIK4S33nHU
 CpMwqrEvjX4WQ59EGxGEnnX0XvajwBuTfL6QAFTn5zBW2XSf48282uRzMgNN8LRJwVlWaeQbBDb
 jXfhs0ONoZujaIt1tDdwdUXEll6TYHYr+BDzSsqlCTBfeNHP/JfQxI9L6y+UyI5iekKb/Q6tc4u
 eScHl/EpDddHgD4dV9XKDj5jRj+Le9osLNukYMl51QLa+sZTpIjexdWordkwY3OE7VWmYMw4sgO
 Dt3QoB4G1Ds8aytOVDDbE40y9+H7p2N0QHBzJWfVvz+Vwzf4ciaw==
X-Google-Smtp-Source: AGHT+IHEGmbGoULCJNcojW0ZOi2BIvE19GmsO2TF4Crvq+wVgs5YURBNzE9GQAg5KRW1uejIOdxZMQ==
X-Received: by 2002:a17:907:98a:b0:b76:8163:f1f8 with SMTP id
 a640c23a62f3a-b8444ff1d71mr781184766b.53.1767921491157; 
 Thu, 08 Jan 2026 17:18:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cac3sm954886566b.20.2026.01.08.17.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:18:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 7/9] net/pcap: avoid use of volatile
Date: Thu,  8 Jan 2026 17:16:24 -0800
Message-ID: <20260109011755.362857-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109011755.362857-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260109011755.362857-1-stephen@networkplumber.org>
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
index 30734cc09d..bf03f431dd 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -49,10 +49,10 @@ static uint64_t timestamp_rx_dynflag;
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
@@ -826,11 +826,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

