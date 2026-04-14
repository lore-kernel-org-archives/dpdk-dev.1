Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDADF9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:12:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8792140BA3;
	Tue, 14 Apr 2026 18:10:37 +0200 (CEST)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42]) by mails.dpdk.org (Postfix) with ESMTP id A8DAA402F0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:34 +0200 (CEST)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so3969696fac.2
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183034;
 x=1776787834; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYqF4QjROE90sWvsYA4QbbeM6zEXxY5t92zIWOvCmsg=;
 b=fEA/FsHRnNTO1Db5FVwa2wl5lYQCzOkkpTTa8EK6psZPa9FLgV1KGBcoDr/K7G49f0
 Ns660vBt+pd5CvnVm/WIEZmzfXNdpzad+PyEm/lfDf97I5HK7UORn1hJY2CFjoAbYEVd
 c4QY+kAR+rYRu3gMoBvZulmLQbkWPm8xrHphxxjtiNA2AxjyLvyXZSo2M+RS5pCwnwVh
 7Ow1HyWJnxRLN7U9nq+OFm1HuUws1E8X5Gaqg5GT463ypqr+YAOtUmfBdV8W8x9HEiwZ
 M7W2vQWPJBrv5/5NnuoNBfBhHepvDbRNhjZDiivRSCtDd50C9zlCo7/RqTnxvHO2rFQ/
 LN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183034; x=1776787834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZYqF4QjROE90sWvsYA4QbbeM6zEXxY5t92zIWOvCmsg=;
 b=LoDBYbsrY9r9idXCADL5yplRNNjHrkyPRKdq5qygL3c7AmghzSRFCCngHKgd300PK3
 pC3Ti826VsHAtTFzWuyXgAfnMNM8I/ZBQixGK4lsZu9cemWLXiDyNexCIaRxwvekR6WV
 2QVBhLqcolp1jf0cqP7q9NjKRrKzeRQsii3IVZgtKiDCKO57aEcN0Fkqd4Q+rigFXuqr
 RZSOMQ8K8ny+va+C/zyTCjUt1Nceg6O1XiExZBB7MCzLBQWk2OlZ/DXPSQ+cvVf2wV40
 Gc1BERDDFrPgcoOizaMVD/kclMVqfbNQd7AubDJTxyt6T56A41nHdPnlSMxExpHK/dFM
 Z5fQ==
X-Gm-Message-State: AOJu0YxFlDTRji87JdV3Wk0IkEmvXmVUYWxBuTSBczP7PU4/mocQf++p
 PBFdRdbb3wOK7PN5Gq6gVIzGRRP34EsMVwsao2IdHALbEWUqU5diK6/8DjESwD5L02A6A+DP7c9
 ja0js
X-Gm-Gg: AeBDies920hoUu+7oEUWguq3HxOllV43IdH2dshJwrAqHj+4YHwkFHQKpcD5NCoJKzw
 NGQNASI2cih5aCwFH8qyRb1FWBcMgU5HEQjVeDoEeQC73e8Y/BQxGHHw9VEqUL+B0yTZY8b3gGY
 qnNMUfFFyVKXQXWU2tJG2Bgb8q9tZQ1v/HE4JVXIeoFkM528tFT4IgUFVQkutBux2OW1aHRkX7s
 18C4JqA45GlRwlLAWK7kxHmz89biKt0ECTd3n665HK0TySY1k35AJtS+xbQpEuv5+IQQTWiC+Zj
 lkm1hmREDkF+4ub4CjxumcY21PlTOQidiCpCP8Em+Ep9mOD4m6uMOVtKNGc7yVOYx2MdomEYcEk
 AXFxDPqcqBMVvJYXBJBOMhM0frKtJCeCSu1pJFFatSpMUWncqGgX/JjpijlMebR1I+3nZ5rtoK2
 9bekTphFlqlaiM92t4HgZRxR94LKuFJm025tf2363t1g0=
X-Received: by 2002:a05:6871:709:b0:423:f59:31f4 with SMTP id
 586e51a60fabf-423e0e19684mr10322965fac.11.1776183033803; 
 Tue, 14 Apr 2026 09:10:33 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v22 17/24] net/pcap: reduce scope of file-level variables
Date: Tue, 14 Apr 2026 09:08:08 -0700
Message-ID: <20260414161011.756101-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

