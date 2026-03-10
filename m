Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ADDFCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:51:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DABE40DF6;
	Tue, 10 Mar 2026 03:49:51 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id D2B4540B90
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:46 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7d744d9acbeso683899a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110986;
 x=1773715786; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+04IHz3XWll5F1/78hPHPzhpWNzA2iLPL7BJ8uLA6A=;
 b=k2T8ywsTI3nsA9+HGKbqnejk154xOHhaHsX+nB2ffVkXZpZmAnyX2HGWzTdqLeD/Wp
 5mDJ1YZFU3cr2/AKMhFZAnwyivSbig+fknWftcSj6JT5tvyUmTnBex6rpCLAnv5OCMVr
 trZgnoTRyrbrkehGtYasMmBrEO3Wd9nO51A78B5dMSt6zEKniZhv9j7OtffFUB/6wcmL
 401S/3Wl7DKPtS0ErFUMhiezVEf4bnwpQkFs77xf5xXuUMdIME9E1Te9BlxqfNZmREm1
 rcdwPIySCWj/9iJymHXJxzxZ2W7xsqSKMWqt67dWTQw24hgqNuBGMyzwE91YFXUBhYdx
 oWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110986; x=1773715786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+04IHz3XWll5F1/78hPHPzhpWNzA2iLPL7BJ8uLA6A=;
 b=Crcd3/vrl7ma2vrOU0y8ytsWYLcWRb67zWY3NL/rWuXsgHfg0omuS7BeVZGS3KHtfZ
 eRuaLHXk4vuq/IdSd+emDUw/hGeDmsgWCZ4pgTaZcJDzKPd+o9fx7g6OWzV9lhzwvQyh
 rd7usohdUGt8Ax0W+ylsCheTrCpIIOK7++tcngRfeMa5acCmKLQaZTTBjS/kXZgD+OQG
 OdxDkbyZxAXAJi0OfnekdIu8ueF9ZbYgtC3UbeEd+TbExoNpswK1Q7zrKg0HFmWKCLMV
 aGSRSPptWO/TwhfEk3xB7YIn0mAMBOJXeA1ecygJcBEbdsRQ8AhzQH3W5ZSXMMor6+bP
 vUBQ==
X-Gm-Message-State: AOJu0YxJcpJFMKjG8lDQWtohbd3lDG/D89GtZ74b3O1S72l3lRqfOO7N
 zXtkQbcGt/1ejYVe3CHipgVmtzoMo2Yi1cuRDvjPVG40NszhKXEtMrGk4tV+8OUKp08Fmc091op
 OOdayv6Y=
X-Gm-Gg: ATEYQzwjYtCBQfSGEbCo7i12i7RqICnhCX63PJAH7HTWkXDBPRMReZzthY5LTAbk6jb
 qNPIuArJuhrXfUqRlA7WEGewftOmG4ZJ7OoTuBsIovF/idTQM1Z5DaevvmwPiYOkFpB4YxiKGEV
 s4zWCEDahCj+FyFoiCZZ1D8cvYsH1P/A0BOsynrjo26t5Tn8VeqkteFYrKc+tqxsn2GU2CFjmBp
 0hmFaAqmWCvXfe5N0+F15bF35joCpvDmb2efHnufdClzoNTgHp04tSt3VcLaZJk34WVTFETPbjj
 x5OoyA/AhJVPiSIuf5M2fpUDMwZaLGqt1YNwfrZ11uuZL9+xBNiXD/gWXmu0f511VIYiDgaoclZ
 ocUyFPMis78RwyZQfd9xIrXZibulgcqrb3Yr39L8xj6r238AdWa672vH/lZOWs/HfCJ9aSulBpA
 6Ew7nGCIs4H5E5Z/m7GtMWxlPJ7QQ3380H
X-Received: by 2002:a05:6830:3c8b:b0:7d7:4f8d:163f with SMTP id
 46e09a7af769-7d74f8d19e3mr2783138a34.16.1773110986152; 
 Mon, 09 Mar 2026 19:49:46 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v19 16/25] net/pcap: reduce scope of file-level variables
Date: Mon,  9 Mar 2026 19:47:51 -0700
Message-ID: <20260310024925.476543-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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
index b9e828f5a4..8be3a59690 100644
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
@@ -600,6 +598,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -711,6 +710,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1459,6 +1460,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

