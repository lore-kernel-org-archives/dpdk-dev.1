Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79E7D46BEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FBF740A82;
	Wed, 28 Jan 2026 19:42:05 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 8BF99406A2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:53 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so165522f8f.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625713;
 x=1770230513; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjTTK4E2JUL5eyb+HP/UZryMRgu4dSSf2tggKWo7pt0=;
 b=f0DmMgrsIunJraANKoxV35veK+B6x+8yhTSO5YsDD4R3Wq0XJjA/awtsWrhdHS7lTF
 1XvkyKl428ydzEUIzajPfT7Ddo1BXQZE8q6RN7tPoWG7/q/O9j10aYzz+2j1cZEDDHvB
 xUjVB5kMnRCKkF+RYsepOpkB7S8QGU/etddVRYFIagbfk3IAQFzOk687tifIVhLJWt4I
 9sNXR++kuXrSvAMF7sckASCsUilHs7hcAKutMemh5kUBAEIMC9BcO+vvQSUteKV7TXCo
 1rmHtT/OaLyum5MvHTsiSsg2tmu25IpeCw+uztg2mPcwE7Bo3XN4zvACRSJg6/k6uSZ4
 Rh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625713; x=1770230513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RjTTK4E2JUL5eyb+HP/UZryMRgu4dSSf2tggKWo7pt0=;
 b=i9wU/vCGAzAY4nn0JiCpFU6yOVuU+1QXOyaqF/V0H7AECiSKOKO4gwJDZHQzijpZPP
 uPN6h7TnSBONEuX6KD/YAW9Gh6XteruQfbBPObWy8e+8kEbwIX91cQJ5i8uxkjxf8Sgl
 vCA6oAgJBDQUrRU4b9i6LrCrNn+zdZlOIFaZBDyBObyIK1Au7H/KZq43P7VgCKNfjRMc
 NiGh0tUmNdIq8X679n4ysvDxOYRVgYJz5ijmR6Wem+1j4OGzlJlNSXulF7AiwGSp20C+
 TJan7hMx/EH9MdlNiQYdSa7otjMFVDVMwFKEcqfMHwOmL3jDebSHhIy8G16DavrkZK1J
 HN1w==
X-Gm-Message-State: AOJu0YzRrFpxy+bksMewOyqpxRR+E64ERyLFsZ1Sw05o7U78numZSvYb
 63S1zfTsBE5P+J0m7PAfS6poIxDsFBqQ3uJotBb+gTS1qpP2T3gmD9ILq2S2GVg3W9djur4sK1q
 lvucV
X-Gm-Gg: AZuq6aLIL1b0TTwEY48FcYTgGqbRzfcSlERQ2vYuKo2UCCPobQtQzPFR3rbNd5Scqyj
 fx64hm3oC6VbicTbAO9uJr84ja5yPfGXPXXh8J6CDn3UH9xQX2Gbh4j+3r7jGjOxNzfY8SG85u7
 eg0iuoki+LhJoZ6cjY6ZPEa4s4cx8n28jIJnCw/YkFu1VNxxeHATWibvNogueSPEvZHO0uL3hOU
 Euo8JN6l9Qwqx0Rv10U1Aq8Bj5t0r1zkr4pi+/aqyptFUdn2G9Nv6Ku+jegfYijfUGO57r3Rfk2
 tTfTbpJ6cuhJdqdJHGAamaV8ta7NIojH0eLpLhbsSfRDEH3yCIVKecZbGWJ4bxHjdodrsIpOVhR
 C3tbr7L2+3fs2gVrTyaG77ikXt43xuOF6xnU5ntyuAQt4iId1nN5iDVOX2LQZEJiToD3ZnW+GMx
 meQjk1JT6kaIz1C2M1GJivgHT9NY3bgQIg7TDvQSlNVW/tMDncGw==
X-Received: by 2002:a05:6000:2601:b0:435:95c9:6895 with SMTP id
 ffacd0b85a97d-435dd0752f7mr8876332f8f.18.1769625713073; 
 Wed, 28 Jan 2026 10:41:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v9 11/15] net/pcap: reduce scope of file-level variables
Date: Wed, 28 Jan 2026 10:40:40 -0800
Message-ID: <20260128184130.445567-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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

