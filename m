Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A9FC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 17:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA86340B97;
	Sun, 18 Jan 2026 18:00:09 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id C815D40676
 for <dev@dpdk.org>; Sun, 18 Jan 2026 18:00:05 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so32041895e9.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 09:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755605;
 x=1769360405; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6sj/KCXk7T6l0AlIh7TozkEsmfAOnowZ2ydeTnz7Io=;
 b=x04bsS12yngj1EHqTogSczcFMIjCVdA0yp/L3X0rNtD/ZcONiZ7w2P7zZjvhuRFBLQ
 twobnoOSvY/j40mIYGFRZ93jRpsphu8J9KBoJv9FlCyVEfSJU3yQqdm1XdVbu7SJ/QpX
 YBLryAFD/trC0N91w1bjYID6N5DdiCjNHWi0i1maE+h/CI7UOdtcAjBvNq6uN/e1eBm9
 2rQnUKSGlysL1f59XCrTEj3zcXVSoS00ILfRupakWR+Nl/jt8II8wbD1rhSo5T3/eKRC
 7FtiAHUEszlzsiaXApf6FV6UDZEZox8Sj8IBpPGlFAaSZOY/C4LqMBGu/NRMjxR2mKp8
 KFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755605; x=1769360405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E6sj/KCXk7T6l0AlIh7TozkEsmfAOnowZ2ydeTnz7Io=;
 b=gXjw5FeQC2LBo9iXeEDysAKi/jHAV43zq4XmIRQXc4Ue3l7bxAKPBjKZTtghUcChYu
 +Ek0qCv5VAfU8QJPJjrWcKHIH3K11OiDXMbdARQTnrunbdBoG0C23iTZPYplJDXYsGnv
 ZUp5yduBA5N63BD/spnFeXqrShIoUzs9DISL21haRCgOm9Z3d20fvvWOI8J8muuDrYaf
 gs0PfIdtwLZAeUgYSWbVQ3kVBkaIr3+04AMCmh76P4IfY6GqpahJTegw+HL7Lccwwk7I
 0S5BANhhVlum2inru8oYb5zEKH28rgxoQsx5mnQlpWgTWdG/I7ZWbKIq3flUlVVS04Ey
 aN2A==
X-Gm-Message-State: AOJu0YyJnJ5XeU7p1jGihGW42s3fQdU1Nhj9Vc9stCH04WU2SzX+Osw5
 kC1Xl9zXd23d82tAXe8VBAbWZrBC5FdAy/ix95hVqMyJ6Oh/MET8vRUpV1pR4XW89TtJZHc6YBy
 +qrDm
X-Gm-Gg: AY/fxX5g0MfbZx0bm0KAGwNXSBaEyhHoIAOXXE07XLjM/3DU3KP6qtSKKjcfsKHvssk
 eeUgtasfbK7NctUgBg0K1QJjW4TY6ZHKOILTRl/93VTgNuXZSOABTqaO3RnQA0CwdInRW0O2DqW
 Y3RMzih34OpT75BSXcM5O6xJ1voYjE9ShA1saDJD6NYi9khPrp4Q+uyJk2obO+htgpRX73pIshe
 Hpk9H+9be0WbvFSZdPpXHDv/K3gwBQdh0ILkkK8Yx2i5X07P5clffal+/h62KXbOBoMJS0qVkV0
 Wic6OJatcHkmmB+An1RGeenNa4fF4cVijL1G8cdRLhKM/D7S8EATFD2U3kyok0StOy7FLmzPRbg
 QqTna21iLt0G9EYOrIPnhqFQuP7h4YX/5tHvgnSkmywuLupmvVK0QoLoQhVYFGkxHUUar90S8w2
 mp/WoIaPiK8PsjKizw1Nq2KZZRGNbpwqgn7lu6fAWBp9EbdDtOMA==
X-Received: by 2002:a05:600c:45d4:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-4801e347c1fmr122547525e9.27.1768755605331; 
 Sun, 18 Jan 2026 09:00:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.09.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:00:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v5 08/11] net/pcap: remove global variables
Date: Sun, 18 Jan 2026 08:58:43 -0800
Message-ID: <20260118165944.41374-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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
index 76bb546673..bc31b526a4 100644
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
@@ -555,6 +553,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -653,6 +652,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1357,6 +1358,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

