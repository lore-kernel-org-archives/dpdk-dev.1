Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831F5E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:03:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EB2B40B8D;
	Tue, 10 Feb 2026 01:02:33 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 834C440613
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:31 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43638a3330dso1847355f8f.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681751;
 x=1771286551; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3F7JggwHYFsSKlFSlfyPfSQTX1kozFM4AzMp5GcIYo=;
 b=1TD9tUPxDLa2SAsI+osB3/jhe2hsQia+J2QR2Ths8wqSXPVQn1W5MSxxMUvIplpssm
 AYi2E4R34Z8/XfVoOhguG+j2R5HLWZ0A91z5tR/dmcYr34c1lVPPqxpjQ1/r0roF7PTo
 jX0HwlTUkau5u6k6WrvjuN23VYgXGwBxAFoBK2fSkYiXR2AIX8uyDuyOAf5nNf/vpaGZ
 1gneLa/8IHbBRkTtImQkUuxGNbQVA49juLmhof4zUDIV9PH/ASpFsBDNqlmTEAkgp6kO
 xRDipWH+GqS1Ix0SXQ2lsdxDhK3UhiiPCjDiVd1g1BeTn+7ERky1/ARVywkFinKN6/3d
 S7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681751; x=1771286551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y3F7JggwHYFsSKlFSlfyPfSQTX1kozFM4AzMp5GcIYo=;
 b=ReE35hQ/qu0fOEetPPuFIudSAG4+upmzzNQrrwApoXIUN0/WfYhEE8Z0bT4mt0Afqf
 J45IreuQO14eWO2bl4nJzZk8VI9bf6+KG990yIRZYbTcu4DuTxPDI4+LvDoJkYWJ0L1Z
 4nIzwuccDTc6+6BDLU2HWItj3Y/PpfIUeoAae6nrX8IxJ2qYuxgO/J65w8xFrJhrh36i
 EuhhurW08xRGntjL4CS67n3djtxzx0ztVbqKS8Df9J6IlEfEam9u1ZrUVO8HT9U2JMAG
 ieVkXEGnz4E1fj5SN2WXCzKLDjXSMnCwYWNNtiAgRWkJMEYHUYIYgrObwQVWLd2pFA/7
 19sQ==
X-Gm-Message-State: AOJu0YzWFJQTLFGKjmJJxuSghfOJADAH29E/XWSUA1sbNs87cKn5dhqm
 48ecDeqKXLVU+lz+O4rgy6egXy+K5VJw5bfxgIdUrssfU9OnDWdlHI933ddzFuRo+fLCDIY8ycO
 QVNDx
X-Gm-Gg: AZuq6aLuVjaEulRYsghih8s0V1L6ZiTSF8h7tmu7ZYGMml1UoXpVdI7pH8FvVlG21Hs
 GsIlWvJnhv6M9sNKL27jp0xXnZyViiRUdQti1kivGtk59/M+h8dyV5VYWpn0EyDxaloO4zgOhmR
 VM3937cRDSyJq8+/4wasHhN5O72Nw+2HG7dB6MCikjnEMLLOIStcvHh4Psi9kiOFknnGa5T3V0a
 keKsqy2aLuxmiWuIM5DvLeQNAC2KuGCoaTYh4YE0XGZ5iFuhZ0Ut7MiNHnL8DhP7uGbRmTa/dQr
 8oRxLNPu8p1CbwTxEb721EJ2F4tF6p9pJD2/M37wAZn1PLube9uuRUDwuBH0AiaJMxwR+7a0sYU
 TNXJC17TcdhKsXKSfzr+zaLfErE6dl9RS3dzwHUwotLOPSPS5SzhLD1kyWhRJ80abWGDNSOFBu+
 v5Q+pjWhC8QS8kvE5F3DpmktUMtzDvHF4w3d/oyjOSnE6Rd5A10g==
X-Received: by 2002:a05:6000:2006:b0:435:96ec:679e with SMTP id
 ffacd0b85a97d-43629341e57mr21653002f8f.23.1770681751127; 
 Mon, 09 Feb 2026 16:02:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v13 12/16] net/pcap: reduce scope of file-level variables
Date: Mon,  9 Feb 2026 16:00:43 -0800
Message-ID: <20260210000201.295839-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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
index cde9744766..fde1f9fef2 100644
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
@@ -612,6 +610,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -723,6 +722,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1526,6 +1527,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

