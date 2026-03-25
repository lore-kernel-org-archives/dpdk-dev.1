Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C86103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51A6140ED6;
	Wed, 25 Mar 2026 03:40:46 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 3136040E3B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:43 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c160308a54so871660eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406442;
 x=1775011242; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqQaf/Ur98SwYskFlkraKldRaXaZ8ejKc1tTW/l8WA0=;
 b=UUtIMVWN9OWztCc55fPR4zLyBV1JEYOE+MjC0ETDslpsdeO7YX5yi/JsseqDgBEI5C
 4xKaCvOVc4FyeK6yY8KqFtNYFiFswScSPC6RkEZdsKTjEO6i+wpM6j3eEN90OTt1076i
 M1cL2jHx7dUSEscIq7C6OWucOvldRd52HkC4BpHUGEYwaYzE32mJCnYVfQsmOoJ//CWE
 7x/FvHMT4Y4+RPgv+2N2hPsPASOEgz9BH3GYoeT92hjkfnyRlUUID2O+V/eTS6E406kV
 8I5Gc/dxaRRWk5bpuMpQ9zFEp6XYN1AcwuRMjiSKDi7Xw8SDxAAhFqiOAfWRHeb9vGtI
 ywNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406442; x=1775011242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NqQaf/Ur98SwYskFlkraKldRaXaZ8ejKc1tTW/l8WA0=;
 b=oSrbdKTiXnZ05jjZZlqJc2ljueQDHw2zZw98uYUU4mJWWvKwbkQ/nFIBdEFZPEt4eL
 ufYCv/BOlSmswJ8MZaoEp9XWBX9C1G5/tecza6+NA+Xvgwm5++OsEuY/10DvKe7BmByU
 On4lfynSqZwFjaEtDHQgy0xKDbAsWSpi741E0CIGHbiEc/dnuezR8H9z3ePM7Ih/Vnm9
 /7oNXpFuzFn+k4vqiyAvJu4mEW3xHJIbrgrRypkX5u978NCSbMIdUQun3sgg+QTLiZYR
 M436lyAI/s95TKfZCLdzIl8Z7jpPs2v0VSdTYZB9FbgMZqGOJOUGb8JyKuuanrS8WoXT
 kUjQ==
X-Gm-Message-State: AOJu0Yxm7rBSt1aTgktVbLJjZIyjh2h9dWed+NeUGoS65VqvkGznZGyj
 Xol5PvgH+yytmiz9Ss5UI6MnuwA0F7UIZIuMGNgGVTEWkDuTv3ITw1SNWRuNystcoV/MRH9lukv
 CsT5E
X-Gm-Gg: ATEYQzx3U5JFC6mgBE0QV0dp5Hotwaf2pms3ONFbLweW51bDLvQOy7oCNKa8mIvtcYu
 eODSTHm59NY2A7pdmqZMWJz5DZS1FInZ46eiOLp4jHM9ILa+yPgtg2G81qS/mas6RQaDY99XfjM
 Ry4gGNtiVvMu7Pkcjhs21UKxMdOEW75AOpMshwHyEdR3PbmCjT04egMukRv21aup1fzs4ECwBE6
 wOkSwBdshwStM+vn5M/Vcj1KSd+jgXPPMtSOZpretKeSskeNSMch9lh1HOivmHYzQBFWY0HzaMn
 oV6dkGAK9JT4MHLOH73EXVgeg7/c+Y1Sj5gunxMWK3Gx5l5EBdAFB7w7H/XJ8BWidEUsxQHCCUg
 MeFmxS7/JdSyVwtv3tEnjpfK3dR3tp3oiAAfRsI1nV5yz6rYvQC9Ct8pECsuNqH3mD/v4/07/I5
 ee1jd89e+k4NEJLjMUbg7YPgbqnCpNwKgO
X-Received: by 2002:a05:7301:4446:b0:2c1:27c:75cf with SMTP id
 5a478bee46e88-2c15d26fb1fmr911876eec.2.1774406442081; 
 Tue, 24 Mar 2026 19:40:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v21 18/25] net/pcap: reduce scope of file-level variables
Date: Tue, 24 Mar 2026 19:37:49 -0700
Message-ID: <20260325024018.1275209-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
index dd640a82c4..0ac8b90ce3 100644
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
@@ -596,6 +594,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -707,6 +706,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1464,6 +1465,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.53.0

