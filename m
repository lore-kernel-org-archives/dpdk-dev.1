Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98137CEFCEB
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:34:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D643C40E3A;
	Tue,  6 Jan 2026 19:33:32 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id E108840E2B
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:30 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so2026730a12.1
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724410;
 x=1768329210; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydcH/gyGzjccOhzYIYuQcvr7DKwWGONDU3QaNMbuZOs=;
 b=qRl7MAH2bv9p+GjJiFVEyzscnaT/q23GqTnBUYadhoDlnmDxzS2Bzwvqskbcg2bZSk
 Dgz9O81vodL69Fs8R2x2PU7fhAX1/YkXjrQhA9oXeJpm0zPKWMyeBR5vQ9KMGwqxsaET
 DPslP/ah04VHecW0EEEoNSxRL2o+L30MMyfR1HWDY2E4E2HWAGegzGiZ7nsO1ax16dGE
 NGizD+DNVVQGTPCphoAdI9qWQc5gyLwRrqzABR1gTx0OPRCl8VOhbMGbMXNs5CGMf7Sh
 kx45bNbPd0RmMCI67TmHYqzA4S5NS+oteV0ZLGePylnQQekiwYSoreCUcPRBT3lqju1x
 cEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724410; x=1768329210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydcH/gyGzjccOhzYIYuQcvr7DKwWGONDU3QaNMbuZOs=;
 b=Rp2ccRth4mvA3+G/DQSsJCu3ukFSePIIEEfldILyXJxBWW71uaIiEG5y3x3DvCMOPM
 5+OYkPPRwUiHpYQo3GbgJ1w2VkGCsKuPvw44GIgpHE0ba7ixAZ0DQAd73ZJpaU5+Ncgp
 YyJX3Y4/JM/G8eaT8f/Ip7gbiLP1Z30loEfez56gMQdN8ijN8nPP0eUp8lmKuhBWJ1fp
 3zWHxWm9QDq1kxecs3o+NMSKWsHmKJdMBSo6PQ8Z7ZEdlLsoh64qEQixh2VwqvE5FHYV
 ORW2weCWTWOMopN1nwbjoVlCagV4uNN7LdoN453QrsKycl4W+kzB3RBZCfTnJgBVg33k
 dcrg==
X-Gm-Message-State: AOJu0YysAExTgXlvxVgnhXZ2CuqW5carmkh1pYzFLYZZLhVO45ZHSjbp
 VkCXHrjoNml51Uxa8BeY4EzoKvEaYa8E0uSNZmrQ40e7T4ckUKHpYVqBRpk2IgPGT1xmWw70kMr
 QmTbnNLU=
X-Gm-Gg: AY/fxX5aSfthIMzmGUBEBl08kLWkt6yhMoo+kLazrq6Y3uwejAGl7s28OGdCWfn7b21
 kevkje3Wp8LMIkZZIF0hDbMY5yPIkLQIx7puGJ+WyGz6/tAdgUli/4k7pJRms8aA7/f6lb+JsWL
 DKucABKs7Ql7phMsQwPYMaSqI/X6THWCOCJaB86HKnkZFg7qNfSH+WvlScOyt78UfN6M1BCg5cR
 TwxagIegGZdez21lYfdvcFR2WrqQxyJgP+XqXXrK/bEuMunO3Jqpe2Smnd7WFQKzyMSvisj73tO
 4Iy/9oSw8gWsJh7O8KW1O0MRNWUZbQB8LBzFqRF7Z1JJ2PfUcYrEFsEbVKaizbC2WJcNuQlGbSo
 dYhJ6Xpon0q2D0Xtmm9q/FFlealgMi/VelAoDs2xF/6vzOd+tJFwVdCQsXRwBilFqetfwacVmk9
 NzYFpc7Ll6a/inxILFGeWk3agC0eq3cRMHpi1ShwKdgsgcG83+DA==
X-Google-Smtp-Source: AGHT+IEQMlHRCjyovPYd12O3RvfBp/g+kUv9Iu9Nk5EW8CaxdoYMlnEyTbtx5Pdji/cbF5fdVzfwoA==
X-Received: by 2002:a17:907:60cb:b0:b84:206f:a650 with SMTP id
 a640c23a62f3a-b844501eb89mr11063066b.56.1767724410479; 
 Tue, 06 Jan 2026 10:33:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 09/12] net/pcap: report receive clock
Date: Tue,  6 Jan 2026 10:26:48 -0800
Message-ID: <20260106182823.192350-10-stephen@networkplumber.org>
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

Since this drive supports receive timestamping, provide a callback
so that the application can determine the clock rate for timestamp.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index e283fb3787..3eb313ebb8 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1103,6 +1103,16 @@ eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return 0;
 }
 
+/* Timestamp values in receive packets from libpcap are in UTC */
+static int
+eth_rx_clock(struct rte_eth_dev *dev __rte_unused, uint64_t *timestamp)
+{
+	struct timespec cur_time;
+
+	timespec_get(&cur_time, TIME_UTC);
+	*timestamp = rte_timespec_to_ns(&cur_time);
+	return 0;
+}
 
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
@@ -1120,6 +1130,7 @@ static const struct eth_dev_ops ops = {
 	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
+	.read_clock = eth_rx_clock,
 };
 
 static int
-- 
2.51.0

