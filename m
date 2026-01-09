Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1254D232C6
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B5E240A77;
	Fri,  9 Jan 2026 02:18:11 +0100 (CET)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id 0C9F540A6E
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:18:10 +0100 (CET)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64b9230f564so5446275a12.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921489;
 x=1768526289; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2d5rAaycG/wx5yioxRo3uy83OPWQqT5D4AbwE0xjMmg=;
 b=CBcld/4a5RZ7EVbQOhawsoxSCVqBd4YB6I18aycBVyiLpFKylXotL8ohIGTg4CupVB
 fOd1zrV7ft5JR3bM9PLgDSmgCfvIP92NQzMjLSJJ3aRygrG0ixLumy6VRKIYcsx5g9Fd
 GTtH11rBI8V5C0A2sHiXnpqeR+wIeTMBstninIrZ0i8KWBGyV4J1HORuBC6JWIsfs2Fb
 tdceOtlhBmFiqWzQNaHNFowFIDGJEfCwfUC0lWXTq5I7Ow7nLj9HHc9tIHAJn+ZiEhUt
 CcrdrddDY1vq0UdjSlSUoKxXqjtkCeXRbWOqxQgzuZjhXvRZWOh5fm9hhC7Caq9VJGAT
 JcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921489; x=1768526289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2d5rAaycG/wx5yioxRo3uy83OPWQqT5D4AbwE0xjMmg=;
 b=XVCunZIK0FSKhyFtcD4st6jO7yP1BYYPKUwmu9ANslbCyzHZwnuSh2eUeqzEsfQ8en
 oIhNvWiAaKCxrEQry8EZMs02yLY2qPb1gIyZs60bK3j2bKyteoZPFZiFudEUTiZO4gLk
 fJf13L/OEzFeshgm9C8FhA8ZQw8zEG+eKpZHum6A1WhzTck3kaEoDlDjnu15wgsbMoOq
 MakgB2e7yTmfrS2MNr8CeVN1mxq5A3L6bcEzPIr2DzvfPDnjblCvAjyBq8G/1Acfzmq3
 2kcc46iv3hmhS5Ui/rZ8MA+TMI0QVAHMnfFfhNEs6uEI2WyPLJ0DkQ6hbNYuPK8SUsH+
 pApg==
X-Gm-Message-State: AOJu0Yw/vff6puoLZDHdMU4R9k7izh2wU4JRI7yaEpwPo8YqpLunTfGj
 k+tA+I3P532zzeyAen7TbBAVsjyux/L0CUlxxExFLvjwZr8W7FNRinOOCJH6easBm2uFRIebbRV
 IuR4r
X-Gm-Gg: AY/fxX6OshYbmAJqKBEIkjGO/+gw2grbc1EIBjLETXgWnNCPgt0qsSwkr+knirVrw4q
 RLMIVkhrg2yLReRmVEgjtA74xwQba4kF+KCyteEocDxIGxveSQsu6tVo5nk9dk0N8BGkCundWvb
 p6IPq5Iu9SeSmlLtT9SrMXPxjuAT9r9qjNdYe8Jh/yMat5jiM45YNe4F1+F/P22p5IK7kdpxedc
 wGa7Wgovox5H1FWqBGAlJZB4TL2/U0H/9tRIrvlQJDiI5ofMhjkv5Nzn6/K7YyQM2bdyVaVeQZ/
 pKjPQxucSRGwLOa6ArXYxuGtxIcnxPPguB8IiRuZMNS8Qbnt+cv0aJjwdTmzgtpNmRqK7mC+6B+
 nzt0+DbkniAY0MUNcVloBTw3Q1mX1vNMRA5Cjzjg8MTkhs+yuDN5XVeXEM9t76N4KNiOfrmGMp7
 99deYH8snLzOS6F25a/l+zEHzs14Vbc+qopi/0gCZD0kMANY0nmA==
X-Google-Smtp-Source: AGHT+IGAsFS7zqyFu/O4ZQvCqYK8Yd5hj2Ya1rgawuxV9R2HVvalq0aMBnhwzx0c1a/PJXxuIA8iTg==
X-Received: by 2002:a17:906:d011:b0:b80:149b:badd with SMTP id
 a640c23a62f3a-b8444f6f7b7mr548320566b.37.1767921489630; 
 Thu, 08 Jan 2026 17:18:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cac3sm954886566b.20.2026.01.08.17.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:18:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 6/9] net/pcap: remove global variables
Date: Thu,  8 Jan 2026 17:16:23 -0800
Message-ID: <20260109011755.362857-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109011755.362857-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260109011755.362857-1-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 25e78f1e3a..30734cc09d 100644
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
@@ -531,6 +529,8 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	pcap_t *pc = pcap_create(iface, errbuf);
 	if (pc == NULL) {
 		PMD_LOG(ERR, "Couldn't create %s: %s", iface, errbuf);
@@ -626,6 +626,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1327,6 +1329,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

