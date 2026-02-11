Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0166FECD6EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F72F40A4B;
	Wed, 11 Feb 2026 23:22:06 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 44B4140A6C
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:22:03 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso980686f8f.0
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848523;
 x=1771453323; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KzYgYr5Mk9F3jC/Xm0pPDRn+s9oxH4xd89PYleej/U=;
 b=2njJ7Qst5mbAbmdQDhMA0q+X190hoYh4ISr3wP8dq+fkIoZfFrcKGwOLoRMT7l/LQf
 q/2bVKzpIW2gkxNB2O4WQkia9YL5ede5hrS4BobHFNgmSdpqn9CBVf4xEB8568bbVLDw
 Xpj/w7DFtQttsqqAm7jOMsOxhRRA40gwIUwlGOlEXbC8GlR7zqTXzrvteS19LVjEKMSN
 XfepE5WHkA+OeBvDRfcwDgEvv5cTXJl/u0CTKYfteSCDU+Y+nkxMg5IHhtIfY91HXZgV
 FVtdiCrdpwv53yUfN/MYOGw0x3npYXn3Rxes4jhH7SY6iqrPb8VxWjhA8nSwPYMw2UEw
 spKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848523; x=1771453323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3KzYgYr5Mk9F3jC/Xm0pPDRn+s9oxH4xd89PYleej/U=;
 b=cROdyMLXZ+8Cy+u/DQIXJvc99uoAK0oTJEro0qjOl5YTsYGNVOLxfSpVzk8hE0WIVQ
 M48YhvztibJ/8gpNV9XDAHOKruuVAMjuJxJKa4aYVe8TA31LmxfNhnl+Fcinc2+fzHvc
 lzq3DWD/Xrcg4BJ9B+qzIbzTHe+RDu1V6yTdb50afrh8R4xo+8eQaFD0kmelrlQP0gaD
 B86OWVZggspVdxL/Y06AYlJSttg/aD0MYu9s1IjMCp0t45icWEtLMQ4PDFLwNhT7smah
 31ujc2+coUgoOQnekOL1TYjotWUpo8GgJA/TkiLMh/yV8Ia41WjAl3q7VoxhDypR7w9b
 +L1g==
X-Gm-Message-State: AOJu0YzNvNbHkc592qaGyQxKAhY15bIFpF4XNoQaPBkoLGO7o2Jp4Ev7
 jc5voTCI4j20gfE1cAWVuZ47D1245yLA8f26wyFyLageyysu29axC8JRP+bdyQfk3+YYK4FHORL
 CERrX
X-Gm-Gg: AZuq6aI8l9xRHqGnObfPMgUIH/LR2MNO7yaL5UUUcoVM7vzsJF/CZFVQkL88iDMtl43
 D80YGYXrcIlxnmntM8MWHKQbsBOfmcKO9Y3iSgS3p4TXL53bbP1OkMs3d7nVbso6oY8UEgPjKmD
 tEylg7Vc18ZyluA5T8oyukR+4l+/fHUvTLfGI4N21P0v+KokHvyr5Rea3hwt2OJLoaMJfAvgJRU
 vy0o6SiLQCOYVh7zmv3Z8DdBg6px+iwxns9ITF8BgKPcM2GENosbEHZGDoKsdkZBmD2JkcJtVIe
 azYHlbGosU5Mtl2rR/e/poTQeMp2+y1TGj3FVdkXUZDn9R7V7wXK49zik1jo59WSlU8/Skgz+Ih
 NhSRAFsaWjJnR2zX4y4dHq5KbvKZA+TDCzyHZXyAZOh3JlOhpYdUF7d4EJeJcLopVgrnB3wMtdc
 1+U5A2iXOdYlBAcN8LET/rexLfWRe0epcxH92tLH7AuO2GjL+3RBaHarCMiwoqNA==
X-Received: by 2002:a05:6000:2207:b0:437:6963:a10e with SMTP id
 ffacd0b85a97d-4378e7240e5mr663164f8f.23.1770848522842; 
 Wed, 11 Feb 2026 14:22:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:22:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v14 12/18] net/pcap: reduce scope of file-level variables
Date: Wed, 11 Feb 2026 13:09:45 -0800
Message-ID: <20260211222130.338797-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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
index 3522401b5e..89c1eac8d2 100644
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
@@ -627,6 +625,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -738,6 +737,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1541,6 +1542,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

