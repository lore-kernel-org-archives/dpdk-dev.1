Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A36E83822
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:15:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E078640B9A;
	Mon, 16 Feb 2026 19:14:36 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id B287640A7F
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:34 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-436234ef0f0so2385925f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265674;
 x=1771870474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGNMBhvJhIMVkLmVmc5+HYSOC1Efeixu4MqBDfuJCwk=;
 b=2cC/XjHHhhw/LPuAGOP0k9W982copL3o5mPiBffAGgEXO4gHBWooRh1KcpJoQMcUsG
 2zsGLVHlkXIByY44/dWYc1m3SdO+5Itpa9oGgyi8n7WvlV2flRtNuSKAilLg3OYe7j0x
 pDhahBNuhh53dP3Cj7/BS/mWJLToa0h00Mc1CoXvggPdrjEOJ5imnvBCyAZoaaSFFr9w
 FWLdDG5RTOOJP5QmEJ7yPupAJcmFng/Uo2uvVALr8A9Ho5EJalcCbfmXOYTgDd/BtbfD
 OX9SUPXbn68p5oThNYunIuyKzyXDMg9bKU6uVSzSf5l3sQVZPG4DPMe/cNWSue3H+8pi
 l0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265674; x=1771870474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dGNMBhvJhIMVkLmVmc5+HYSOC1Efeixu4MqBDfuJCwk=;
 b=rY2K7CAxEuRVVO+6dDWN5iMlnCXBz5t+WTPojHz6qaeRImZ0tUVfQDyfGYvSMBG/XS
 2p4UOutnZnh6Ahon/RqdcfsWLNSyi416yw9ZKuvdYKo46gmf/OQrhl8KXXyUf7wOmYqk
 3dDNeQ/avA99odKZOK7n3adXLRR7zBmd8IrbLNyA+LdtAmTi9N66gd3RrgJCXaXibiqH
 baW8TmBrL96/FE/gPqOTnA3SbqsgmyBU8fyQdjMgru8Ztc7bFK5b/X2cfzl2HO7kTgM+
 1vL//EXd+Dv+yhXux31FB2dW2ZbpP3mheigY1sbs0h/KnN2nOm/naiEJdUBQlP9I7grR
 sZ0A==
X-Gm-Message-State: AOJu0Yymm9ieLQj9uw1o8YE++9M9o0ncw22naGBwV2URGpUBk1XFtQCo
 kCuNyQf7ku0yFarSfsOAZNAXYucVPpwGgKu3pBZjz6bysp+HcrekjaF95lrrvVflH7bxq+I77/a
 XYf0RfJM=
X-Gm-Gg: AZuq6aKK078hxaWM6NzQjVMH3Q5MIdl5OQqIRGUCC/fY2E1hiL7o61dEqhpcVx6xpaE
 vVDP+NjYdcf4NiM9kGIpG6ELIpgUH/qiT4IQmRWLvPrmG8NI95/oLJ+VeqhOQuO0ZO4qDwkLWtr
 8uf8+JuOr33zmASnJydvX+wEEtNkjipEB1XxzFTHvLGZQ6EXciAJjiIbXe5kVW0bTT4+530RouC
 dcGYd1Djgnsc2AeKAFtit+UaPvecwidfCqwaRJUe9kdH15+BuzjDT3NKNRTsqnboIa8/D13NUhk
 opaWDSA9XgtiWiIo/gm22VIhP3OnXo2rRgwMOFK9VvrzFTQbi6X/HLJjnzE/LYt8haGOX1Odijk
 cxRK/n9bihb7UXYTtDuJid/H09HU1vhIPh2Dl0fuufyTOQNIVUjWRui5VvdEYcB1biyijkkna/R
 uvglsmLw7zfve7RkiqtnceUVH36hezFIiCqbd3XtJVyPhxE1vLPn0UEFvAxLqebhLGuGcZyYEN
X-Received: by 2002:a05:6000:186b:b0:437:895d:2026 with SMTP id
 ffacd0b85a97d-4379790e995mr25069721f8f.38.1771265674257; 
 Mon, 16 Feb 2026 10:14:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v16 15/21] net/pcap: reduce scope of file-level variables
Date: Mon, 16 Feb 2026 10:12:10 -0800
Message-ID: <20260216181407.428877-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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
index 676b928484..be14d7690d 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -46,11 +46,9 @@
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
 
-static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
-static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -626,6 +624,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -737,6 +736,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1540,6 +1541,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

