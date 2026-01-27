Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB70D2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:22:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9369642788;
	Tue, 27 Jan 2026 18:22:09 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 87C9940EE3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:56 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so49881625e9.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534516;
 x=1770139316; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjTTK4E2JUL5eyb+HP/UZryMRgu4dSSf2tggKWo7pt0=;
 b=whDovNwKy2b+l1sGTShmi591zUHVDYdQsrlzuimugdSWc3+RNrUChnKnP1Qc3mSU6/
 oOMXZXhgQrFa8Rain8Ymmy77QilVPUFsvnYjarPtadx7VgxV8WfigTfWdL4BXspbyAvu
 v6lsNXdo11zH+tKFCuQbksZFqYB5WwbwRIVTEToMZ7xEr4XUoXbROJPohU4QwU8UlfBp
 /cQQb+7Z4XwIEpILL0Biy3+pXHoXJf2Dla+9JgZhDT8mRMUInq9EOo882BvAifPy3KYc
 zQglQycdisbsqi7kE2U0ts8FJncnpcH8e8cnxn5Ri+5th9u58/DrFdJTiC15J1fjYR94
 Q/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534516; x=1770139316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RjTTK4E2JUL5eyb+HP/UZryMRgu4dSSf2tggKWo7pt0=;
 b=Oaa7xviYlrO4kknIt/qjYl9uiLaHagRxS/9wIoQmTt8eEcsIjEiE/grRFL/B0SEr50
 iN/q75KOxe9UxVs7iGS73uwed2AswPxSahbSwiFpJpRRTIC7SxoMe9HqPf/tAoxUwiI9
 yIgD2CMNHNEQQdv/ySdGl7BHfT182ph+LZPlk+rbpwVkAGqcO2MUGMx3T8oA1DTjjypO
 YD1dQlFrdDMXzVTxHtDhFpR9CJUTFh1EHvTGcNK8t6COJ2ldP4kJdhLiRhOXJwmMUfCA
 Iln/12pochv5Tpl8yP4t8bK5ocUAcfSAYZ8l5veHQhieEfYH6LEK3RIlY89US9hgQd5Q
 jCTA==
X-Gm-Message-State: AOJu0YxLTK29zD/KjN8KY/Cj6UpXdlaVhXZwdcvgq0rDOIEHXdpRtQNy
 ZcPMR9rcqebLkBCya9PYs+1ImQ38d7dOQqS0ABUjV1WWIZrvZ0KRxMFHJ3GyJ6coUTqaCedYOMP
 jD6k3
X-Gm-Gg: AZuq6aJ+HV89HDqC8fqgllF+UxcRhR9Gy+8ZAynmxy6UzxTq7arWhgXr8czWn4MNGEd
 iIFP7Dhppg7NuYcmfB+d1T+mdBI4sPMbe0WAvKm4HNJhvslOqkqqtIrTB2iLQBnHwp15Py6GfFf
 QaZztNWJB+DwqpmmC8LNRNEVS3BSMInY3N6GU75Qm1+6lYQJ5nz110FUCZr3BHEnQyIwt2/eFkT
 un3lUk6Lat1/eEJXjehJZGu6s1W/K3cJAUdyv6FcAD4CgMhbK2ZDvSl/AOPWh3+PtlvY/YUEN+j
 FG1z4uR8uH+kLZWkfXp4JFYD5j6+56I/qZobwDUGQAdEtODOyY1BotvMdEAT7giP5HFGYkH38wg
 Whohc66m7HZSXxMukQCYQxPwkXstytuPGFyXX1ADCecldc9vOpXDJ6q0NBTxE+PgQUCdYkJr2Mc
 i3pTArcyxqwZBIDrHxKt3ndnjWH6rOhY62hT65V4ouwMwBqNuJsA==
X-Received: by 2002:a05:600c:37cc:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-48069c86407mr34193895e9.24.1769534516022; 
 Tue, 27 Jan 2026 09:21:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v8 11/14] net/pcap: reduce scope of file-level variables
Date: Tue, 27 Jan 2026 09:18:52 -0800
Message-ID: <20260127172128.124473-12-stephen@networkplumber.org>
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
index 2aec737088..8eb6356794 100644
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
@@ -541,6 +539,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -639,6 +638,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1413,6 +1414,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

