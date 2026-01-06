Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A2ACEFCE6
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C3BC40E21;
	Tue,  6 Jan 2026 19:33:28 +0100 (CET)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 2905240E1E
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:26 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-64b4b35c812so2071593a12.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724406;
 x=1768329206; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1umuobQ8BVosMoy+RIsmlrSgHZk7t6iNnU5oAf60ikM=;
 b=EnYx1pkRa18r4MUqRfJ6eoe/AUYXyc1IwMr33mKvQCNM9DnZ3Lk2tB2E/uAqXDR900
 YAd/l7N1tPkyVbToLu0GkHKk6h8Bhq0bi9MVBXJl3O0F2/fMha7CpPcny1RGjde8nHYh
 dO/++r86phKo7ebPDcsqclvVYmaGTpSDiwn3e8OtkTnpeWy4eVQnRN3jsS1kENs5LreM
 PGXxMOBcC2yWhunanBCf1MNzDxeP/WxCv+tfHEyuQ0fiy9bR16gPdiZJhj/3qd0KBHv0
 3LMhX0ipIXaC/6Mhu2NuXqJdrGJQiiV85r16J/ZCOJcfMt0s4k3X32W1BD9098wE2X0p
 Lm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724406; x=1768329206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1umuobQ8BVosMoy+RIsmlrSgHZk7t6iNnU5oAf60ikM=;
 b=WwpMMFitojEXk+12an5jJ+TVGYnZGx4HB8lHcsHzpRwYnm+zaTdDumslaXkofD5H2j
 IiMeMP8xnV+5vqDSB40/YhU4dTwQDPGAZKu54YnV86R2MkyAM1Zc/ppKdd4W5SBlPEFD
 SSPmqBns89NeMfiPMEQdq1N69Z0V7HPsfjm+Q8V/+ShWPDilieU7FuItxcoTUHWtNJ2A
 GHt9IKkkPF3fIt9KwSgyNwnVEUF85aeih64IhXpnI7SWQCk8mPMKE3VtGsodTPutVdeP
 fpI8Tvtx/fXUUpOZmIZVEH88fpQi1CkowGrEhL0I7vaKGu03q80qVXRL3hr61CDiTwEd
 mG9Q==
X-Gm-Message-State: AOJu0Yy2e3j1wBbrn3w5AmKZznBp02wusu9ipixMa2YKolTKKBOwvrib
 HOP+cB2ojYvnUzecmt61WvWX+mtyo14EoDFFf6/kLzwK1IV5R9AjQzbcGklCJ/1x/vDntF5Q8/h
 AUYV/WXA=
X-Gm-Gg: AY/fxX7NCe1l1IijBnela9hb5GfsOmijVyNHhcO4h5ka6rlgtsdlqVRiPxpJxhQo/8j
 tKhiXuGqLFz7WY7UmyUsXhphA7UITqW07wKrQl4CHz3uKl4DnIi84rBbNx+y/asTf+ZTA1glCuj
 dIbYk2Z3mrvlHMEP2C0fjhFIfE9M0ONL7lni/PLny08wt4uceeuveUW/kw+M9EbXRUtbjGVOySO
 ithDHGQtx5ywmgrd3RQptDAkrohf41l34/cQYbTo3tvDq+Dkg2Lh46NPs2J+H5eN5qEPwtPme0n
 PssvekFTwbG9oT/OAZGN9HJ5s7tbl84ibWZQxAHnpYO8Z11wyMkRv1CBCF7bbMWvOcXJXgz9sPM
 nOozKaDVbcMo2X9jY94hKm2S3VIs0zb73+9rHQ2aGO1CSM5v7fGCjUjBVAYAeuNWW4cxb2apZNy
 yZW44ohJsx9zQsONyDlfY4kQs1GUset4IuaaiU9UIABD7jzCa7iA==
X-Google-Smtp-Source: AGHT+IEnpD0fliDpncwR9LFeMARI6eNHqjTs7YUrCuWyLFq2lwFj2KWhJZnNdi9dJlw1eATpW6tDxQ==
X-Received: by 2002:a05:6402:5186:b0:64b:7231:da3d with SMTP id
 4fb4d7f45d1cf-65097de81f7mr5257a12.9.1767724405745; 
 Tue, 06 Jan 2026 10:33:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 06/12] net/pcap: remove global variables
Date: Tue,  6 Jan 2026 10:26:45 -0800
Message-ID: <20260106182823.192350-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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
---
 drivers/net/pcap/pcap_ethdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 905ca62bd4..1658685a28 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -39,11 +39,9 @@
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
 
-static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
-static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -526,6 +524,8 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	pcap_t *pc = pcap_create(iface, errbuf);
 	if (pc == NULL) {
 		PMD_LOG(ERR, "Couldn't create %s: %s", iface, errbuf);
@@ -621,6 +621,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1314,11 +1316,13 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * - and point eth_dev structure to new eth_dev_data structure
 	 */
 	*internals = (*eth_dev)->data->dev_private;
+
 	/*
 	 * Interface MAC = 02:70:63:61:70:<iface_idx>
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

