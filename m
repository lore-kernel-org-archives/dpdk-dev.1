Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE0FEEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:05:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F50A40A6C;
	Fri, 13 Feb 2026 18:04:03 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 90F3C40A4B
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:04:01 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4837907f535so1694745e9.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002241;
 x=1771607041; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNsyON3Oz/VDdthns3KRHWNS6tGjweBr6DVV3SxQqI8=;
 b=V6jvK72RHT3Zb7vG0T2RjEBv11evMqW9ciRioDVT3/W/k4Zs8CAWHa1yvQLeE21AcE
 VztUMkOoSAVs0N3PtBCj3j5gui0AUtkegBOdtFOXT0PNScT5AlAn58uGPD+BHpBh2BUa
 mCptoCXxZh59qZpS4Qeo2nApOJhs6P2XRF3PO4jtilpgIVfeul0xbwBcgVysdYhbHPnn
 Wqe4BvNMJG2dvfdGVBVBue5KcxFlKy9DpqAUuqgbDVLixwq0lvlInSFvS8KJfQa8DeoO
 evpJVQxMaH9tqv1MQamQtxx4rrrEqufnsMGoG6NLSxt7RiRqdanodJWFLg+PBpFsLSpw
 /B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002241; x=1771607041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tNsyON3Oz/VDdthns3KRHWNS6tGjweBr6DVV3SxQqI8=;
 b=ONicTZ/xtaVFdWsb+v4hCI4jVuoG6jSwKH2XwJgRbjaksCSj5QmLEneYOrTjqlLrga
 0kFeTFxNFL306yAg4KhHw45lHiGQY/fTsNyXf3dBZva4qBHq/ngLdKkIkvViPMsg55Hk
 qRiaX/95sEHLPz9BBDLFCaJnqO18j3tbHtoy33mSYHh/f/iQ24lVLPbQlAP+9rHYdNJX
 TZ/jBU2CB+J8sozhqZHI5EYXEV5lwDx5zled1FlMlIAMub/lrkDDsxvq3JTMPl9V3NIL
 qo+j0FwWbIRatD6zu8paVxMrfT0vHp7orqjO4D1lHziVN+3CTeqbMgdNoTwp1ziQuZe9
 NEvQ==
X-Gm-Message-State: AOJu0YxKFU6BYyO1uN7vuihWPACuqEfZd/aeojnMna0keCOg4q99Ls6o
 9dTdxRurm25l+gPQpSzQJRXc1/MxTRI6EDS+ti3gPon6unBk2ZAqMyRVe5ciH5K/cNyB4zjIiNa
 vdCKq
X-Gm-Gg: AZuq6aKf5wwFYKt1PqCFMDcde6+zCIZDKXImPtab1RmvAYa6F23FnvK4djHGNhs3xkt
 Pxu5QtmeYEHIg8RviLDH5WCPHtW9exUGd+ZX1oc1QSYFEtRL6U6J6GEAS4qig71v8LdVHbFoc30
 PeWuHcLJa5WsEWG7Dk+l7tqWy8li5BgnNi5vM1e97LSb3gB4N9AmQZQEd4zMkO2NrkqwPGJnFuJ
 fcw38P3th78o4JifL4y44zWcUDDkv5ZjJm3VLb+2K17VO5x+viKEGmr9e64Ei/6kwJDeSVdwmcN
 YwekhZxKIEVyA+e/60y7sc1Y4/0SibNdhakMKBAyUv5wFd2jZDZMADMRsoB2o9cPvbSHshW/YlH
 Agjtu8b7xiFjy2fm3ytICYkfJvHkoT9WsmyZ89TvJI9djb+DRguwUxHNVfxZ2BXWWXjZYsHU9Id
 GuI9kOdljA+H6GctkHIk0214JCrqUEpSnJReYLfFOyGGStOZ0iJeHptsCH6WQDEg==
X-Received: by 2002:a05:600c:1384:b0:483:702f:4633 with SMTP id
 5b1f17b1804b1-48373a00b03mr42105175e9.4.1771002241126; 
 Fri, 13 Feb 2026 09:04:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:04:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v15 12/18] net/pcap: reduce scope of file-level variables
Date: Fri, 13 Feb 2026 09:01:35 -0800
Message-ID: <20260213170333.40089-13-stephen@networkplumber.org>
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
index 8f44baf2e1..16472ca068 100644
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

