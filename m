Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC4E63CA4
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:24:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2245B40671;
	Sun, 25 Jan 2026 20:23:38 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id D71CD402EE
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:29 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so29147415e9.1
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769369009;
 x=1769973809; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OERXU3DYbJ/ctEReRb6BIjj7bwZ6BMpOj9R7HcJmV3A=;
 b=AmRosHHVBJzE3ppKL4BsySTpndlSm0a1tH6eZ/5dAcJ2P7YQ9LRnON1j2NyzXFuz+o
 djJs3f6ZZUrU+iOgxOPv4O/5hM6b8dSsy3Mpdwag+mJUbjI8+yENLjOUgPB9ZwbHXzVw
 uE81JRZ+SNZvuBDY6LcF2d/MYEvshatJLdj5Qz7R3Gbyf2ipmJX3zi9BmQ97ujFQaSwB
 Sxs/hM0cN/bow1nF+JsedXtJhCwtFKNMIBB9BxW18KZip7LTQFptUvIKn2LxgJRdMJxH
 dGu1Ht2hVIiyM3256EepcG2jgvVABG+feiSaJio5cW5G8ZbvvbGHJPd6Vwi4BSno7UEr
 If7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769369009; x=1769973809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OERXU3DYbJ/ctEReRb6BIjj7bwZ6BMpOj9R7HcJmV3A=;
 b=jXRwtKhhpoS+KIZOLaQAvX9MiTUylONaSoAMcpUGJOlNIwK9BDcKaxdl6E3Nh9hntO
 0bYWPCAC8B4mXyiGvTi4qakVu2/tWdxp5Ly8IVsQQi/9jnHRYkSsltDz3LpxXuDZNSdH
 RDEcNrDpcqu/uRxqmS8UvQfQk0162PBscq8tcOWsF5/G3dq9GbAwaukr6+dK7Fd+7Oab
 sU9stTI2mmnnksTbuWP0N0kSHSewvWCleHaOl6tcnccLbhbx73FtlQdOATfhdFgh9Ar2
 p97+aVcYZ/Rd573KkIP3642axEj4nv7dZKMVAI5VRx8R1u+YqbyiM6d6obFWcMgvduBg
 hyAQ==
X-Gm-Message-State: AOJu0YwP7eqGdlNOByc4qu27ydt+YlIRuMPivgHh24DtPy4Eo9lgzrSc
 z3IgKCaI/bOtcvQ4py6bOvzCS50El61B+6N9v02MqloI3nEUCEOzyMWY/iDpETG+wMGE52++MpN
 pn8Af
X-Gm-Gg: AZuq6aJzbgyBFbBaGLzB5fjhZnCvcD7oEneM2Ddost8cBxmo6ySq01IH/6AgQEfI1cm
 jH5G5JBlJnM13t8F34JufhH178sOLBrzEuo1uFOrWXSfksKJeD/aHzKktbZ/pFYTPQ5PmFgAYXK
 CKyeGNqzuYq8V4805qCA1FUu0eRqn8lNKshHHhO+y97gcoR731uQSokOrEstniI2dOu36REtmWK
 VBFPd/1reeBROKJcz6OZluBPAWmxF/rR4VhMsZsMVJOkVwC6Mnst89w3qR7Qn9L9izoiix6FaiJ
 yAG9CjFEgZDCJqa2fD0Inre+lJ6xC5BmqyBiYmsDMQY1/1/oqeXbsC3DT61cMgLjVvx1udCbJ9H
 vfpX8svcymTxB2VoiPuvlzL4dR5Xg40bkC1nZ1UrG2CDxWO9BIf7AbXB9JjVZUTKgeZ9OnhkuMT
 Q5Yf+sOaEBFIVIWbIkqEAjMvWFN+/sZ2iuk279t+qltAW1iiuHtg==
X-Received: by 2002:a05:600c:8b81:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-4805d064515mr41911615e9.25.1769369009461; 
 Sun, 25 Jan 2026 11:23:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v6 11/13] net/pcap: reduce scope of file-level variables
Date: Sun, 25 Jan 2026 11:20:09 -0800
Message-ID: <20260125192248.497563-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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
index 1c53a47bc6..c79b00332e 100644
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
@@ -550,6 +548,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -648,6 +647,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1351,6 +1352,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

