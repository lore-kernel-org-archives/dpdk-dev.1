Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE006E7FDE0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AB7940A84;
	Tue,  3 Feb 2026 00:13:22 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id F3C0240B8F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:19 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-435a517be33so2984302f8f.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073999;
 x=1770678799; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+WhhJqnSOTCCLPlT9pr46fcINEV2K9BJ3Mxj2IKCf4=;
 b=Vd0PdrCAEGUbS2zrYAWb80PlOow0cEnCEErSIt0b9iASABeU3DAQkXx5oIHpYOWT2X
 XQUV0zhW41TG/L3BsPJeM3CbZLDd/r9Fz7mAkgeiaH4PUycAUGDHT6ZTSgz/B6DXQBZm
 E+vBjZYI6VGUVXkJ8jdB+7GS3RqM3G8dCau9I36n8Eky+JS23kxLrlXCaq+4u2zlVHR2
 KdbMnZnD4uQ3fLH4adyY6rkKhGS1zxfx3jD56SEOoK2NzgaKNQx7LnDXP0XjozteN52a
 vrcsRbPxDnBpunmBgM52awYg9PuIjEzeW8j9NN/E5SJR7NRVfqyfWBPf/xWymlL5tJRG
 YmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073999; x=1770678799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+WhhJqnSOTCCLPlT9pr46fcINEV2K9BJ3Mxj2IKCf4=;
 b=uTj7p+2sJqXjLhK4sJbxmF8iyjLwQXKfgnAI6pRAS5DMowNVuaQidcv6T/mgGwJt6w
 d1O74riGPyszWT8w96nE7InUv0331gDWTcD9Vhf1BJRqHiLXytljvaJnb3ZhNyQxyFRl
 kByj+u/2nhlMF6Y2fh3sgo6Dt8bUOPcA8Jyod8zkzq8BJQxLXqzw5SnitqZxgQa0Rf7I
 6R36xOKEfl5UXrS1hDex7cJdxcpvn80jA6Bf/ha57xCxtteODZ5zoJqOZ2fJMh0FR6JG
 sriK4juhaY2jo/coFlh5S8l+8/R50AF0qrfCh6wwQZP45euDMmdcJUFBaQKZf/ikXpGe
 Ihkg==
X-Gm-Message-State: AOJu0Yx9+z0sgTvVAdYg+y4hSG8Q3UPpfJd4xeL5oBqDnem+EkbaC1ZI
 vs6yKTgTVtuRC2jEtlJiC8aAVVgiqzPg5DsUmmfn4ZRSJ86xcz8BLW+z7JsTriW1C6Oeg120kAf
 wWUkD
X-Gm-Gg: AZuq6aKfy1WBDy3Cn10cSkNojEGQP/2JFpwbNh14E6mVaj1hiyObxjYhUB7hMCFrnVp
 jE5arISPl+xNdmNL3/AW7pUkfCOY/XXJRz3OUq15TSPr7br1aeoH9+KRhjA/jvTYhlCi8r8w4jY
 K7K1Kyshkk8N9XlxGMc9+9BeWSonWvDEjoL4nDFTS8KkgTAiQrydrS8p45qax9sjaBmwAdDCzdw
 oHRC4rvp4213cb8kR9g3daBKBCK94ShL5/7yqqjKrMbl+DmjkOSQyG1Snz7GNCvbkJSYVyKP8o5
 lFmQVOlHoTNd8Ir84NZGGts3NOMrlUxsAMig4BNHwf8ghm7B8yOXFrahyNXhDLYCoEJUWNhelQC
 9q1LRCCPqIIfmTxXYjl5Mc41R4f77FcWVmTgH4VOwNs2SFl6nATl22RP3N8QkFsKohWZFsY6bAX
 joIOfzqbOMDle62AsCT1C28FyOx1g/7yGwiwURetDdFGE9D/djwg==
X-Received: by 2002:a5d:5885:0:b0:431:67d:53b3 with SMTP id
 ffacd0b85a97d-435f3aad916mr18274747f8f.43.1770073999649; 
 Mon, 02 Feb 2026 15:13:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v12 15/19] net/pcap: reduce scope of file-level variables
Date: Mon,  2 Feb 2026 15:09:18 -0800
Message-ID: <20260202231245.216433-16-stephen@networkplumber.org>
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

Move errbuf from file scope to local variables in the two functions that
use it (open_iface_live and open_single_rx_pcap). This avoids potential
issues if these functions were called concurrently, since each call now
has its own error buffer.  Move iface_idx to a static local variable
within pmd_init_internals(), the only function that uses it. The
variable remains static to preserve the MAC address uniqueness counter
across calls.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/net/pcap/pcap_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index fdec637988..b1dbf91acc 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -47,11 +47,9 @@
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
 
-static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
-static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -561,6 +559,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -672,6 +671,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1475,6 +1476,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

