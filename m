Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282EAE6BF30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9F314069D;
	Fri, 30 Jan 2026 18:35:43 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 119894067B
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:22 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so18091045e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794522;
 x=1770399322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgvpiE67QHFLP62Uq0mPzvnz+IKKlDNAz8PpvDnl5JE=;
 b=DgamRaKFTWiulJosKtTC41Y1JndYEdd2kQOClhO6rBsZCBWM+LWJQfXWcjpQmcAw+K
 N/0RtMSpPGkZCBilZP9wko64yKsbUX0RdaOzYluTc68OcCy3syvoROSqz6k5fvMpeb7D
 m7tRvYDgg2MlhRA4iG9mtpaN2lyXdxGai4ZTaypuU/CshOSGl4LnjkQNJLUThSOMRm44
 il4iBLOqKNPO0+HKtSHsPcRVM9KFRFX/8Bjlqb++UtA6VGbfkFfalbwZ3NGHVdw19LRH
 2Os617FhHREnyJKnlZIAPnaecT3p2ucKX4MNALzaF1IhU/LnodLXAsL7k+zXmE93JtmC
 jcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794522; x=1770399322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgvpiE67QHFLP62Uq0mPzvnz+IKKlDNAz8PpvDnl5JE=;
 b=dGh06gj7enQBPpdIkaRNIjH80N6ID6Wv7D+pdPNIUIG05z6eqkXjGRajU0sV9XfMqz
 Fe9+okQQeQihuOqWZEiBhk4BwMbkBdnK/ItV9iVwJGl9m9iixwFIo+K8aBQWlZtx0+VB
 6pFXvw6zqQGhzVgGu+D8i8br1GR55k6js+N3hADOTNcNh8YBeT+KawQdykJThoMRh+ED
 PJzl+33ZzRTXQYi6dVqORWSPnpOSpdjBU57ZhH/YB5DT92KhiS7jrCLWaXRD6Bc0NNWV
 /QXOV8aEnjHMBLcCw7D2HYwuzPNc/OjjmTMMQK22BCdoe2biMIhaK6kcBqn0nePX0TZL
 I7GA==
X-Gm-Message-State: AOJu0Yy5a6LdNjxJksBTs47lvcP3XrnKEtjXT7EguoBwvH+6nSc0BII+
 LB807zNdwQr4PpzF0hZCzjbKUEdvsllepXHv8Cb3zWwN3nWqc0eCLU4cMUcrHbqlCQQhoMCFZag
 O5kf4
X-Gm-Gg: AZuq6aLiE346ndOrsqz9VaLoHPPUKrPKV/QfjKZozCg/6ZSLYOcLPNoxPr4DNysImSB
 jorZcbvczcinoP6wwUO6OaTfI/sQNkA20LI9jy03+YGCGUflvkokQIc4P4I7mFbs6va5BCi2JX8
 bK88ym9EW8PtDzsW/2U6V0gPbcDPaEZVEsKNAZh+dAI9VR3Nrrl7Hcx9um8I7S+0sCvWJ7FgSdZ
 2pYo8uNeVgbqHWLo4WqS7dVnirYrvCVbHa4C+3EHS1yjdO466t+Wn5YAuzEeQvd/0yDxYfO5Cqa
 JruPCjoDrwzSdqpS1MEwbj9nOnTjEHkPIJdbNZupEg1z0uQQQJkpe/QYIr+yQTxXTcYpNQMVMTn
 WhvkMJPzXQ4vY0mJ6VK55BOZg27OOkwOsWPP6qEIL2hv29jP3ICDa9eJDdFyg9ngO5p6MZ26aXg
 UrFTZzoslsIdDMWROqacL3I3zp3L4oxSXlDtkGdcbX6fPPKxZYOQ==
X-Received: by 2002:a05:600d:6402:20b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-482e5d4b849mr16806635e9.8.1769794521664; 
 Fri, 30 Jan 2026 09:35:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v11 15/19] net/pcap: reduce scope of file-level variables
Date: Fri, 30 Jan 2026 09:33:28 -0800
Message-ID: <20260130173447.14546-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

