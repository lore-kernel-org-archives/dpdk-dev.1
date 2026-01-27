Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D75D2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90F0140FB5;
	Tue, 27 Jan 2026 18:22:10 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id ED57941140
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:57 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so49881815e9.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534517;
 x=1770139317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1e7yQ1CVDaoar8XhDJ6IGdY7IDYnJZsR97nHOuXg9M=;
 b=CRQA6gFj5Lcj3DO5G4SK32QREOGLW6PKDEQI1+DnvnEspDTNw4Ve70IXPkviNb3gTB
 m7CSxz3gVi8jEEohhF9CNovcfmb4BIrEEUi+UtQQ/lIIiyX0Bmwu+k//9HocSf6dwxAb
 WKvdawth23KZzB+x/sksuwIMC4h/i0BWbHooCZfcK6CLHoY2i6JqVzAz1rK86kDXAnmQ
 5g1xpyX7XUzCtBiOeNUA6w3Zp2SP8pxI7i/7CbL1ndZKrJmqAbGX7Hk+jB+MJD82jqnn
 85rCZgGeKXnakXeowDy91ACZ940xzdBcWP/n/Z/HT8kTu8Misp/dkuX6G9DvI1m4M54E
 UAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534517; x=1770139317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q1e7yQ1CVDaoar8XhDJ6IGdY7IDYnJZsR97nHOuXg9M=;
 b=oYORedtxCne6iR4PEGK8PtpnLBMsMU87/RmomU7mUrPF+0M4KUfHaLSPIOp62l+OtW
 r7OlAqHmNVMFZphyvScLr/TeNK0BBrHJIS71YlE6F4NH2L2+PGYGQ+Ri8aZU5AZDVn4F
 eQeEi6BUeSLjpN1SZheovEncn3dPto4i+V02m6q0g+8qnPTMUcioCQkP8OTuzQ/FC+R9
 h9vEynpn+X9bgmRYjrva20PsgXaNtttfBaBJbVvyEFKFNSWnwdq5Idi9PJfhUz5KrpJj
 OmnYyfiIfxNNstZG0OuUVs3FOnh+ykvCVmGUi56mGifOCrWlZvOo+qZsjUiYFcTAiinS
 yCNQ==
X-Gm-Message-State: AOJu0YzPBWQue2AOJWROuQD0impgI+TYRMhYs6L5k+6Rk0Zo0sIV1J7f
 Me+s6rnuFwqHlOceZ9164gdvnKM3wPXlnsrDoEOwginae/vE8i8Cwb++YQ+1wlVyrWS/ouK+txN
 V1vaT
X-Gm-Gg: AZuq6aL7vrxtCwKZbAE+6XXuhmEGd+XbCaIjbKmveJai7YzWCbmO2mpmPDViqh+xQD4
 yPApc0FKnnQTLq2Bb0ViR+GaC4yErnzmUsNuX3GTYIWedJUi2Rqz1yzuhQvIRGSIZfKCiE8JvPI
 aYW+RxOiFTYnhWKTzBzBH6037yntR87qWneS+CAguldYCSoIC473aU+t9+N7nMi1l2++zzJw4TI
 lmaUsLkM0quCz4axDd3VBbsf1TFOjcKa5mBIGDQfcD60XdT6NlbrwEUO/KuMV17kmS8zoknqSEa
 S5jh+L8FEHl8UG7QERyKzhPWZ+dIo72znK0L/P0q8N/2PEioqvpcNBYvvVex8rcLVXw6CHYmNIb
 X6vBwfbmBE18mcQI4XoFlXYfPdM6+62Nrm0OV446japj62nXqThzvHw6n9rlLoNviN2/EhFHXzl
 i3Wb7Q8xhiPpM+VFqA8QEYaRIk8mvtvOlqNtEj1S2wTFLcGxDIcQ==
X-Received: by 2002:a05:600c:3b96:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-48069c37e2dmr36463965e9.9.1769534517512; 
 Tue, 27 Jan 2026 09:21:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 12/14] net/pcap: avoid use of volatile
Date: Tue, 27 Jan 2026 09:18:53 -0800
Message-ID: <20260127172128.124473-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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
index 8eb6356794..6380d76110 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -54,10 +54,10 @@ static uint64_t timestamp_rx_dynflag;
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
@@ -838,11 +838,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

