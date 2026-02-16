Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A41E83822
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:16:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E505840B92;
	Mon, 16 Feb 2026 19:14:37 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 3BF1040B97
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:36 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so2607109f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265676;
 x=1771870476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7ebP2ewuFRXXFMtTnwalqmzuHCkwZ9AyB8EuV99MUc=;
 b=aPR3J0n8r4ZkYO5UlN7E8ym+ECDcgOSeSiBkpF1u4B/Barmg3ri55GYAY4RjIYvB8T
 TSc/cgGAttNGc448XseEn2tofsZRbIMPT0SV9QBkxMZ42bxRiwcsqVrfbacjDmRr+Mhw
 T/d4YIyJUUM21Q2EZFg2SwRtf8XVQu3lT5QedokkKH2ti1NETPzn7PAXBtMEr7SwR8OH
 lMl1BycKCMpSMPk+rMOIecXgED8ecb9Trg9zi1YwqkzYucqMSvu+sANnTJD5ZAo+9TYb
 xnEoYz2tt4NfIyeUS1+E5V+TS1Q6Gq6TB+66bjx0KwMXOdwo1i50jPnwLSJOEUEa0Ogp
 +O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265676; x=1771870476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T7ebP2ewuFRXXFMtTnwalqmzuHCkwZ9AyB8EuV99MUc=;
 b=lb0Gx0PA+I7SQxp0dMo5cp2FoXr4qv8ggZFfnfry3baRd3KNWib/H6AFWvh8PR2uN3
 Dn8b/edMr7FOoIz/uzXyQy/ec2DXTbgwgZH5dtaEHeb9Nwtqv4bOky6123Nv8iQskEtY
 xFxlLidMTlrNnajPU2+mkwUql86Nt8ZsyovBMNrmap4Fk6d6YcfVsCaBwTOPO9LUA1nL
 JeWlm9IJfdjY3ExX1Ewztp8ZwIEZhp0uO5IJ1ncjrYNWXykwAjbsk4t93Ps3aFPCkzMd
 1OUOKOR3zcBbN6huKwbudl/qVskuXOjfCQ+4ExBrIKrUC0/xptxyks4EsUcAqWVdqZ3s
 fEfA==
X-Gm-Message-State: AOJu0Yz/Lp40MS3Fjv1PFb/eQtDTzRpQJ9yF6MfmfGTUVxtutx37YTPz
 HPgI7Ih4bbNgJTWZh9mO4ZUKZMos8tCYkuhuaxQU6DLEYzgd22MwuFv/J3N40jDTjR9duQ9Vpd0
 l50iyp0o=
X-Gm-Gg: AZuq6aL+eKo9Wvels8/C9D7NJG6A7gyQ6SeUKFb3SQ0tnbc3HCpr/ZIB6KFl60WzTMH
 h2YpFdod8Mj2bf8quVYulyAT0Hf2YnfzcNPykIdIcEg5AGeOS4JwgXE8yfvpbXw6Hq4euWmnwSH
 FBOLiGQm66JFikS0K4sOBVk8IpzC4Ql4OtoJ0f68IeGsyAuyBRAsZWkGbyJL0SggBhX77cFyDYC
 aXutU9/Lj6qp1Jnvq5BcEHzekvzyJXUIqzKoySHHewAwDqboX2Vdj79iWFv+j/uC2HV13qAiznX
 mUCZkSnYu/k6q0mQanGwk4NKwE8AK+3PpGiPfzj6o6UruklcLAr2gqJgbCs6rx+BlSik5ZFY5IH
 4S1i9lHBcE6EqpGoP+EvebsdrjpBNIlWmZ0HqDv05V2+tDEfpKYqnsrxZE2oGcNg2QujHiXS0l7
 nak7+n4kJIXKO3t9mnNU7zx0Xb4Jj6cBT6b2NirAGXef8LBHVoowjvcupbZzsJcQ==
X-Received: by 2002:a05:6000:25ca:b0:430:f985:a7b2 with SMTP id
 ffacd0b85a97d-4379dba73f2mr16222277f8f.51.1771265675767; 
 Mon, 16 Feb 2026 10:14:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 16/21] net/pcap: avoid use of volatile
Date: Mon, 16 Feb 2026 10:12:11 -0800
Message-ID: <20260216181407.428877-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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

Using volatile for statistics is not necessary since only one
thread is allowed to operate on a queue at a time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index be14d7690d..fc425109d5 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -54,10 +54,10 @@ static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
 
 struct queue_stat {
-	volatile unsigned long pkts;
-	volatile unsigned long bytes;
-	volatile unsigned long err_pkts;
-	volatile unsigned long rx_nombuf;
+	uint64_t pkts;
+	uint64_t bytes;
+	uint64_t err_pkts;
+	uint64_t rx_nombuf;
 };
 
 struct queue_missed_stat {
@@ -927,11 +927,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	      struct eth_queue_stats *qstats)
 {
 	unsigned int i;
-	unsigned long rx_packets_total = 0, rx_bytes_total = 0;
-	unsigned long rx_missed_total = 0;
-	unsigned long rx_nombuf_total = 0, rx_err_total = 0;
-	unsigned long tx_packets_total = 0, tx_bytes_total = 0;
-	unsigned long tx_packets_err_total = 0;
+	uint64_t rx_packets_total = 0, rx_bytes_total = 0;
+	uint64_t rx_missed_total = 0;
+	uint64_t rx_nombuf_total = 0, rx_err_total = 0;
+	uint64_t tx_packets_total = 0, tx_bytes_total = 0;
+	uint64_t tx_packets_err_total = 0;
 	const struct pmd_internals *internal = dev->data->dev_private;
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-- 
2.51.0

