Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC90FD2F35C
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:26:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA7CC4067C;
	Tue, 13 Jan 2026 20:25:56 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id B8C994067C
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:54 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b87281dbdbcso330024566b.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332354;
 x=1768937154; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7hNDTpnslaNplFhl8QxTcVNqp+9a742+F69AYxIwgI=;
 b=l3rE7OYcrUU+kaWUONZfgZ5NINS6SoEtmgRiIUzZculMuJCMuykZ7YEZX/7eIkUidA
 kGGijNkaWuthJYui+x2Wyw+iFMMX6TrYGdvKG/o6taie6Repxofz4FHjT+AvEOO4cyL8
 +jVMAQBISTrA6OgeBd4n7mlIIbraxnXBUxd7K8c8miPMsBCQfapdlQoS58+ph+XbZ3Qg
 5nch2wQxU/HsbVp7lKI60mmQ6g3fNYXLzOMMzE3qJj+AC7TNQVrU1DHlGE4ChWjygRyP
 3y6NcAIm69vK1d+XNQZ/rO4kts0pbq/egiNTYZcsFf3urpO2LBdgXYi2It7bperCz/2G
 iLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332354; x=1768937154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l7hNDTpnslaNplFhl8QxTcVNqp+9a742+F69AYxIwgI=;
 b=nNE8ZsHcOmtZvMXs9TXI1ua7rDQ8DbW4v1K9v38kZ+1+JPFo5d5UzS0VdRKC/Qpy8Q
 UftHoq4NqXg3wIB9YqFji0UZq5V6o8urT0BS025qeU7eDkT+D1tUcxPwKvgimsd4iY5w
 LLh9FLKhX1ptHEKGMp4OHAZFZOsgSXK0Wxu/Mjo77kHBdflIq14PCvoGKMjblOwnM6B1
 Z3bESXS087fO3f89SiiOtdyRiEk+uc6BfuqhrOzKTduJxEN5MeFhYXucXQMrB4+NN+FL
 ks0ES96F3UhvRwR1AFHEQn3y4F9NaqYlyppn159n2zrS7LysnKamJwIHcPpAuVOyqvJn
 m1Vw==
X-Gm-Message-State: AOJu0YzmmMGL4RbFDNChZR8tzhIC7SwH90YD4lfLBFgBAB5AC/kFVoip
 fzNm2yxJ0ybN+U9xW59SyXNPD4IT18cJYf9xbXpGkTctcedbGn6qsS9mWRyaZm53YDgpBTBB76r
 JwKVB
X-Gm-Gg: AY/fxX5PskJLvFCFpaZt65cZ15TC/4ioA3erUxEv6RFyMt2m6DwHndDM31eKIiZ83oR
 c9DzBbslhueSAmgeIJK2izmxlP7hZghRqT9zR5fb7pTSHwlXCzb4bTL3LKYUk0YsqloXf3x/blJ
 mGNqAcMccaDY70X55bBoQ4Rw4F+jIST0XVG2PaFyUZRpIrN8nJgOwDDVXMMqH3gUrZ/cBXZNBK7
 PDD/fzqpF3UdJ/5MI4fsaeFfBbuyeIS1h1Cx10bMzKWsTxMVqcNVdOAYsKQbiroMTTDCu1RHwSo
 +c5P27h9bmFzvxmAscIHOVNraB6kkyy1OQAb4QJnNNr82LSl1gL+lpbqDmn3q39zMcfQwlQLzdY
 is9xsXj8+CuJjpbepCIgMiureNL5XTuWkzj9u35Sk9f+us0dOrpjWSr8MNvOAGIcz5ymM/UVOUI
 ohwflz6z9xKvPo/Etxl2Djv4B8HUrVeVETZGhsf3mXbRVNaNUJKg==
X-Received: by 2002:a17:907:962a:b0:b7a:72bd:ac5d with SMTP id
 a640c23a62f3a-b8760fe29c2mr18643666b.13.1768332351710; 
 Tue, 13 Jan 2026 11:25:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v3 7/9] net/pcap: remove global variables
Date: Tue, 13 Jan 2026 11:23:39 -0800
Message-ID: <20260113192530.116470-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113192530.116470-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260113192530.116470-1-stephen@networkplumber.org>
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

Localize variables where possible.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/net/pcap/pcap_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index fbd0f475d7..6dbcd58465 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -40,12 +40,10 @@
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
 
-static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
 static struct rte_reciprocal_u64 hz_inv;
-static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -531,6 +529,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -629,6 +628,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1330,6 +1331,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

