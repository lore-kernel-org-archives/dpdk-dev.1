Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A224D73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C9F640B90;
	Fri, 30 Jan 2026 02:14:34 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id C157F4068A
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:16 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso12928255e9.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735656;
 x=1770340456; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgvpiE67QHFLP62Uq0mPzvnz+IKKlDNAz8PpvDnl5JE=;
 b=rcrN0GSUyAYXH8Or82Yd1thPTJy5kVRn+63+Ph6pyOUI7uxAoJ95ClrdL37/toAQv/
 rWjQu/2GPIP5w+jVorID9Qngbey8QixLiuoyrlxW+z48D6kIp+UQBI5o8ENnJfaQ1YGd
 C8LucYJZyocXOTcb+/Q++11I5LS8k9MxgZCl3aiEcqcTmD1R3hWISZVjq6EExRDDjbyc
 b5sasAbPwg7CA6SfzBR/6cUwSqQtlTsUQBi0W0qIKuUuDEWXMihv4wARnqfnXqNvUPKr
 WIT9rn3wYsjaJ6CV1pkfBiMlu0jPVGrS0gB0tKSDOJMRkRjSLzY1My9gI1UUWQF1Tu1K
 3nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735656; x=1770340456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgvpiE67QHFLP62Uq0mPzvnz+IKKlDNAz8PpvDnl5JE=;
 b=oK+RIba6ysnOZ5/aoSj8zu3xm2/RxSDv3yT0knOiQbkpYyeVHRKmgQ1S8VW/bwiFC6
 QZunXviDrJq/n9xjYxiAoyv+SCaZy6Q+wnkEbDVskJgQtvsYHobRlBSKdnG9E5liWoQH
 xZPG0OQgrylAACOOGLOEOlRkk0M/5dSTJMX41wysfiBVb1SO2LodE6kBUUitH9fwOv13
 LtHtRvMdv5eXK8qWCv+piEBiuDtGim7Y5jOJXWBWr5HztLIrqQ47blxt/mPDL1UVh/rc
 X73fnunvQ4q/wPVWQSCgmmJilcixOaGWmn0axaXiiB7/6LWwAiDFRiCrUd693M3db81+
 ZPbA==
X-Gm-Message-State: AOJu0YziOqgYxrHPe8RGdnr8j0/ChFE7ZRB+gtt+TzS0msfCqRqB7bw2
 85A/62R4OPYyDhXV7gLnj+dhpGzPVCFNoLjgfPuHc5EAGm/1jb92eX6e0YpMEq64SXDQiPJ2BR4
 0Fmv1
X-Gm-Gg: AZuq6aKmc4LAI1ztfEZK0R1VLYJyKDrREVoTbwJlbPIxAxZRDtOxfhkTvlBOHfAbhbj
 taUlwW8LycXVGcBBhhbOOdT0XrOQRkeclOUho/95PE7xHiITdPOY21LF0qnmxmyTq3QeYVgXmdk
 N8BVPG27BqfBd98qWxu5EgLkASkTpeY3DWZ8OcL+jk2UWlLeMuTz9R7t8pT+H/Lj0iMgGov8DGN
 x3rx4I9i4GpPCdMcRnAL3c98NzfD13QGtDwGakmEMfGOAd5fCrS1heqfKYfItNGKA9Gn79pKyVf
 C/TSRAGwfU1WApfB2QfgLWeCDMcrEyT/X0ty3TiW1w2ee2P0XXBK9b5NKrD1E6OSnJgVZybIW+M
 9ti9EDosjR/EeQvWjgGzcd9m1uUc8BJzRE/epIiLYe7VC+xJJBveDnvuv6m18zJ7XZ2mma49ahg
 nNb3H3LMD5JViMZ6z4hLH+lPPEIQyJVMQxNqAEXCEu+vk6GnvPYKrwHx317NLC
X-Received: by 2002:a05:600c:1d8c:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-482db4970e2mr12746365e9.33.1769735656400; 
 Thu, 29 Jan 2026 17:14:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v10 15/19] net/pcap: reduce scope of file-level variables
Date: Thu, 29 Jan 2026 17:12:31 -0800
Message-ID: <20260130011344.204233-16-stephen@networkplumber.org>
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
index f1965449eb..e7c4f3be5f 100644
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
@@ -536,6 +534,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -647,6 +646,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1416,6 +1417,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

