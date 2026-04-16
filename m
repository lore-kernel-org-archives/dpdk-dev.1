Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EBAF8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB53B40E22;
	Thu, 16 Apr 2026 20:52:09 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id C9C4440B99
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:05 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso10119949eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365525;
 x=1776970325; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYqF4QjROE90sWvsYA4QbbeM6zEXxY5t92zIWOvCmsg=;
 b=ff1NHMTsa525KSdZVhCu5XA1L4GnALQ6gnzqIuMqJTEPwivD/hXTB0uGZ2CcSqCvWj
 D8rw9DwYjKorP6dReAnMwUmkogLt1pTe81QD2wqbXylR/y2Qc1YwF4kji5UUhTdqn/Cv
 aSUz1XVkutPlsYc6Cl1yZRm1AZJRvZcxznSF1jqEB+9vdaZ6y16QG7e/3C589vvT7Wny
 Lz7iVYgFy35TI5PBY27M7WnhdW+m6p8pXi3cUhOL2EjIFJfE6rLdj+5ou8l2l4Gk6pco
 BRUkYnRikU1BVvC/H0l2h5bhpF2vFzEyDIQZ5lhg9CO8enfv6ir9qjbjtmjKlqCrC909
 0UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365525; x=1776970325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZYqF4QjROE90sWvsYA4QbbeM6zEXxY5t92zIWOvCmsg=;
 b=JKlx+EkLJYpbVsWxgx2u1CNGjlpZE43NZYigbCBq7L0DL0DgfZbQI1+5DDMRUPybbL
 XRdvZ1Uv3D9b4/ZfNMpmtktwg9o7jx4pYMfD8E3oBHG0MQp554xzo7TF0m52VQ+XZTz/
 V2PgJGfm77XvdjlN8zQw0n+uIyyTfWnCvTzeyqeb1SfvwYSKxrABcYqIuPK+Q+kUX/Du
 MPbEp4AyKcBZC/6k1vF3y9/ZLk5SQ29lLoGWeatvLdRjEdwokIx0R8HF7hugIW+lEQ4L
 RJMyfbziKj1n31YCTwfN4UDTaQ1g0fqXLKZoTXbOzgkYmKvy12aqjvDVTmowNMlbAPci
 Mzfg==
X-Gm-Message-State: AOJu0YwCMPn3x01xSHiS7IZ4QGRnW2uxKJIpTQDRRQUGOIBg7Ai5aZDQ
 mBG7zt6+XGH2NHdpvzF78nmWuyo37+SRHFf/hr97DRFCDONgeEluIS51gS0zA5EGZFmQv3csp8+
 bX3Rq
X-Gm-Gg: AeBDiesTq7NGI0p9DZUE7u50yRhOFdYsDSr6vvsxXwDqJrsSh/TNA8gcXuOjIeWYXqm
 /hLM4H/8+K7mIDhcdd//1qhnferpsdevrmYF2KuarMP5/J5eEJVRftIiW/2M1E75Cl1bNUod2rS
 2N6w2I5TSzRwdxj2PNQ9BC9ZG3WjmjsHMQa2WfUvUzo45eCThPSReN3u5LEFljKFrHOJZuKevfM
 Qk4YHGW7BgjBx6WTBhZ0Z/v6/LSh+r0KAcQKPMgaNj3PQTffZes44wWItKRqHfR61FDwc2M9Ci0
 26HsA55IYwhK3i4Ilht8Z0E73Sk9351f7uEKrMfzx3lP0x2z1ePGGd/5+I2GmFHuf8eptaKlous
 MecAOc0De4xgMVqvyc7P8BrZOptv29s6NlWVSW32URm7fpmzh5FtlGrF6vWHY1yHGEVYwhNjBib
 QVuWf3INcGvaGqcq7Myu2mQUEQJ0rkOUERp332MwVdRoQ=
X-Received: by 2002:a05:7301:607:b0:2c4:4363:3742 with SMTP id
 5a478bee46e88-2e2e3584378mr276098eec.9.1776365524888; 
 Thu, 16 Apr 2026 11:52:04 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:52:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v24 17/24] net/pcap: reduce scope of file-level variables
Date: Thu, 16 Apr 2026 11:48:34 -0700
Message-ID: <20260416185144.1359260-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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
index 01b26184e6..99ffc29817 100644
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

