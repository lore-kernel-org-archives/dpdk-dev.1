Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D01AD1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:09:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 142004067A;
	Mon, 26 Jan 2026 19:08:38 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id EBC134060C
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:29 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so4233528f8f.3
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450909;
 x=1770055709; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5WFOPdYc8zl0U1YQHHyPtN5gznN4IG1mHVUs4O1EG88=;
 b=mThF8wGqF6HoABz8SB3z7sGdpTYw4X9HltS5uRAKfjvv5PLVBy4nRUhs9gkOfOxXN9
 G+4A5PWhetbeE/dvvwpPbABaAAGSoTWxUjzxMMdI+f64ppp3kzWf31vopXfswhC+H3WB
 MvjB6T5spgFbXmWGUpQvb50YJSYiRUhHTM7X+mmOZFfDoHovUcHgzK8x9bz+8eLbLqeQ
 pD145tcmgYOf6JwcyKI3cx6wrlSRyRcJXuxk+dplXM7UL1IduqUjl3pC78TKo8eMdOOK
 RK/gQHAv2BTyFMLGSHHAdY4KYw0izLXaYHLTMBeSV9xJr/YBeuXM1bv+9p8NoyAthtFL
 CBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450909; x=1770055709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5WFOPdYc8zl0U1YQHHyPtN5gznN4IG1mHVUs4O1EG88=;
 b=l3eyJuU4c0RNdqxg6OudC80QicMf1uc9E7yEERh2bLjLfpkxupfcAl7g26FOyXKy+V
 kgPSJISPY4Uf6eXz/Ca22an4lBRny1wTh9bOTs0XdoSc03e4q1gxa2RX5BOKJCNbAy9g
 mh5h4sMCEH5r9mnlb3/IniVAn2HYIHTaG7Q5YygzqZzSjOxyAQyONF6oK1K0ZfzrDUwm
 di27UXBGbgUzy4CiUAjn7VN3JlnNJzus6aSZk4VONAw4LPKil6WnKB9w9Nj6uz3ilLlI
 s/T0pngVLbfMPWhnc+7EdKOzKdEqHqjqV7ncQXNJNqgZ1Z3u0gBTKgZXd41ZGYmYYDsw
 Bdhg==
X-Gm-Message-State: AOJu0YzbYEkQcrXK8roWSjQhdesBcCRK1eYE8Sh1J1YSV+reSr06UtzO
 FyX7zBSZxkQDkhx0n8OKSrbkzMqUFMuEcBwygl7xWtPdpvslij6+4fbXn4lSdK/zo/4kwzEgIBW
 JFzeC
X-Gm-Gg: AZuq6aJCsSoptsdM/ny2hd00/hpwsbGXPi+KGbwSnMxOFnzB/kmGz9az715NOMuqmsa
 NuqVnbl63dOQEYz8bT3+PFU0PPFcS2rEPg73whUy7T8yJgmMpCEftZ0Iu8hwRyx0qk5Fcct4yuR
 G/lvq/8/b5EHvNRZXAyOGKmjaOVbCndpIXbtzvvavxtOsOV4UxVOruPLh3pSVWn1PvdpMdB9rTv
 5794FLhhUTJTxVO29+7p0c4g5NF8WxfFefDFilfQI0IaIHpFJHBPouBF6b6wOXXAa/FJEKxwFpL
 KX1vbkyl2tJ9RU4CzLuiEMRLwLA+bQv8zP2miPMn4aqKhtRqCSShbxF/U0mLxua8gJBsqPFZJzJ
 kp0S663TlMwYJeyhDNr9Ng58waSTdbd52bhbf+5Tf5Zh9fsZh+z+8ETrlu8SesmX4nRM3zVT8Eb
 TlVTIS/lUnADTmmOnX038nQew90B2GG+JqM6a1RwYLKj/bPqQk3g==
X-Received: by 2002:a05:6000:2082:b0:435:97fc:6f1c with SMTP id
 ffacd0b85a97d-435ca075f38mr5830483f8f.25.1769450909517; 
 Mon, 26 Jan 2026 10:08:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v7 11/13] net/pcap: reduce scope of file-level variables
Date: Mon, 26 Jan 2026 10:06:48 -0800
Message-ID: <20260126180807.100891-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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
index 35ab4e58d3..1670cd56cf 100644
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
@@ -543,6 +541,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -641,6 +640,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1415,6 +1416,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

