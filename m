Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB74DEA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7782940B9F;
	Sun, 19 Apr 2026 18:11:31 +0200 (CEST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by mails.dpdk.org (Postfix) with ESMTP id 10DFE40A6C
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:28 +0200 (CEST)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-46808125c65so693297b6e.2
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615087;
 x=1777219887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekg0h4pJX6F8VOCxT29RuLVn9ScjzxJ7TCmoOmX431w=;
 b=SFKtUDLwo7falI9ubBAS61iG7jvJkTDx81ZbnE5zoyi3IevlsanrG2WsK1g+D4hSxP
 T+zI6YkeBfWREDHqtky+cawV4WodwNqxON6p3cKDReN++snCLbmr+Ka6F77nIFFziK3j
 lU7cLVELzaDaz18JY8oQOpBSYyy8oYQAP9hgUaAW+6/2WuuGAOfWqgrP2kCbgc0Sn2c9
 KFVonejWsOIPIs6RQxLTcuxrKs+WE2ilt4D+nqDiEqboLxJDt9h/aDDIPjhtdO28vyBP
 REQOCghakmxezUwqO7302Ey1d/MQvVQc7gVvkgzawo7zqGwnqIHFF6yx/Gp4n2+HsEBe
 pn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615087; x=1777219887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekg0h4pJX6F8VOCxT29RuLVn9ScjzxJ7TCmoOmX431w=;
 b=jK3ZOFSamKf7soi9Gv72TDJuRdk9jJqK0BdYAi7ipPzrG/N8PGa3oGuFIGQnECf0Z8
 B0xBug8uZpNb64/9Dja/B5yduLiW6EnW+WJwFKso8BEL0R2M2ueMAmXbfo9IljQkYftV
 z1fg0qg5+HdEfoS1OHy2yusNBQBZbjfbYlDvg4L7b6/hXKcjqQLt1JN2xjq4VfuI2UxN
 YL7Xy+hXM62OSpJRnSaF9WhJd+G6qKuh1O7+FAjE2jvQqR4fgC8cw0ymyjPpR/XMA/Hd
 lSN73mexvxbKizqcj0JVXLgby9tSUO1LoJzWBXv1Qx6ZP43z0Kbl1Z37j+joJ6WztOMZ
 UEtw==
X-Gm-Message-State: AOJu0Yyatl6pb8hLvjxWvFW2BQfjo74Y43uSZPVd2dggcfH7SUVlGTuF
 lRUh8jfXd4Q8v/k9sJjJ12QtlNrZTxH2beN8LjYBnEud3Wuyy/CzxRp+YH2Yd3IshGjqF90A+bF
 3jZvi
X-Gm-Gg: AeBDiesTmvexSmjLA8lR+Q6XJ17N/U+L0N80oYvgw8AE56BMh+8Ga+GjPPR7N9rfpLE
 cp6jaziyeGTq5tw3D2utRK1VtqFhpOj3wsrW37j0/Aw/0sQ4krFVlNDZzq7TJoWyD8qL/98BL31
 tBdF9WDXKlnzDDP06B5dUFPnUZd6ZZ7nyr0D5dFI8oaT7KnG9K/f7JbOYuY7uu6xwLauGIK90Nj
 tAlLnzwaJXHwmDN8lnxkxtM7RQAsukGJb/FeWy6Qc6mZMqIna/0IyJBtNt+aVdrvyGnVR5RPXXg
 QiBl2dSY5Rg7LSiizuW529KSXPJMBSAmC7qD4U/sb1axgW9qVa9WzdmXD/bTHjKP64iU0TfawlH
 wh3H/LtHnmUxYa053Np4L+bjh4aycV05vcVkKgDWfzc7cX+ReE38tFSFHWH5Bcje0448vwKJPMi
 +tHZ41Yrz4SCSiGreRLhoPEXPYeR0BrzsQdikDB30F9VE=
X-Received: by 2002:a05:6808:13c7:b0:467:268d:31d4 with SMTP id
 5614622812f47-4799c997620mr5236090b6e.20.1776615087348; 
 Sun, 19 Apr 2026 09:11:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v25 17/24] net/pcap: reduce scope of file-level variables
Date: Sun, 19 Apr 2026 09:09:50 -0700
Message-ID: <20260419161059.205954-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 91d442504a..d71ee4ec1b 100644
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
@@ -622,6 +620,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -733,6 +732,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1490,6 +1491,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.53.0

