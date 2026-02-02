Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87436E7FDE0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:14:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B34D40BA4;
	Tue,  3 Feb 2026 00:13:23 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 91DA94042E
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:21 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso3959101f8f.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770074001;
 x=1770678801; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZpgXUCbGwGC9i8EP4r/YSKWuhx5Z09DqpoPcORN1EA=;
 b=W6XnQGyxuXPnpXZFeSeCPM2dSaOGHUWgHZRQ8yuItB1Ug2WfjgKM7ZLUphOxWQifUu
 Jz91sA7qIpQFypr8A6uxRSb2uGXjMvbBx5zhKlq6Em2kF17XbBULYmgoeGs1nyHMo7RV
 VugF+VX0o1AdkNvSm/4G4yyPTvuHWGkeAYikPjQAnckvXiDR4I8VD/HRdT9nGJLa7Ql9
 XeX6dQBWT/jfgcn++7twL8IEEajBuw+U/2erR16lhhBjLgP6iXBM/AwhGV6EKRalZhL3
 LUUXE8IgS+ORz8ACy3DJQkS90Bpye/JN8oWMCJUKnYW3K9QgQimreYjHxwmdWZaFsfJv
 AvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770074001; x=1770678801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZpgXUCbGwGC9i8EP4r/YSKWuhx5Z09DqpoPcORN1EA=;
 b=g+g7iviQ062b/QnJEckt2Eg987mhryHsmv//vIzl9nnrWIMpAdZEgxHIPv6Al/dVg3
 IiSqATdY2lksiex0lo3+wcKRZDUSlfSrj66s4YLI5QKnFqmev5Veehfz1SGHSlOQ0Zn+
 mEnwaS3MX96fxfLJspu5tpOZNRliEjplIMKNsDY/i2nleGPFGoRdQivEAlknN+ngfFnC
 59ikbGtMl8sLTl9tDLPR+eZ3Lp3YYfmt//nR4MZy5Qjw865b9SJrDTEm2A81wZozCMHF
 bsqt3P+G3ZQ2bV7XTUqcrPz3h0cqCdFdt2kgZkrFWCK8llvTbjFkFwKMKx8YF+S/HeL6
 tijQ==
X-Gm-Message-State: AOJu0YwRHJ1HhOHc10kXbkCGTT3Z5zPoOzYILInA07ijJ2KSLE4FW87p
 IHKbUQuvX7qeIJ5NuV2OAVcEaZz5Gyf6Z7K9UwSOIyO9HxM/QOZ1XlCuUI2P0wQhN0VfMHSTq1a
 6qdrV
X-Gm-Gg: AZuq6aKIMLady7Qs6WlAhuTpP58XwFA+bOvTiWCJ83L9R42/Ci0N7Zq/mXGMLxrz9p2
 jRXF9PhreMg4ZIxW+uO3hNB4/yTYyzT4LA4jYvtfwPhZQrV7dIMr0shn1RZj2eZpzf0d4KMsRit
 zVVOtNZ55zWOIgAeoRjwQqoL1qF0iXJY0ZsBtQbHPDL2BLS2MRq38wZiJhlEx3MgEy884WEuDRz
 BjynNddL/llPmnTuH0FvV5XXvYXCYpMaubM2ko9LWrXhT59IJOCi39JJFFo54juoqIvT1Q2LdjU
 SfIbL3DUVOREBfPXd1Rmat7vl4/YaPFueONtfo0oP2gZQVZxrfnzrWona5g7p2C51FyDIrKxR5k
 sik+WxxMzyXcNIJ1eBSmGzBtkIXhP0ovZSzuyBYBkxWXsRd2kUEsLgda3LfsnLmAVvHstEds4ND
 38QZVnAuRAthcvSqH5nnJL0I+GNOloCN+3VvwXH1S3BgRn34tQOQ==
X-Received: by 2002:a5d:6042:0:b0:436:141:82ea with SMTP id
 ffacd0b85a97d-43601418435mr9969473f8f.12.1770074001218; 
 Mon, 02 Feb 2026 15:13:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 16/19] net/pcap: avoid use of volatile
Date: Mon,  2 Feb 2026 15:09:19 -0800
Message-ID: <20260202231245.216433-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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
index b1dbf91acc..f3220cea92 100644
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
@@ -862,11 +862,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

