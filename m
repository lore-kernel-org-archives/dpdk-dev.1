Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C917FC83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C516140BA6;
	Tue, 29 Jul 2025 00:10:16 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 5472140B9D
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:13 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7e34493ecb4so558912185a.1
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740612;
 x=1754345412; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=Ua96GaK8z7nuqWxJAlY76EqWD2bV33S5SZRYzS0pRJ6J0ooApqU7leATKeWgoBjiaZ
 El4YdmKPMuZlVHb1LMFw2XqCXd5Tqseky402QLPm0aGQWSDUJUallf6NeiEhhceEPYlh
 VYF0qk50x9NW1mxLEWk2EB+ZN6pGTfgVfoaJBcq7uBNThXRlRV7Ere2q3BhynfRheOoj
 Ioc1V6KFpd3qqtu5rs+2Jozkzp4/grmHtzUyWD4uIQL4AmJKG/M2sewjMyxT8fob9S+3
 S7uvl/ioxlCpTAD7okhFaGVAA/j/JctktIHijAVSy4FpyM895UiwrzxHMuVo7cqZb2R6
 YWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740612; x=1754345412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=Iaw1Z7jn3tcrlsXnWuZYz5d3TqImv8/w8H5KR8Iva6ll3omr7Y9xd4qrdb0h5Ew/L0
 KGVmA+HXxN11HRs+VXcD0ZBF3MsxJFqG2ltxOH0z9e9y4+H464GCELsi6Xmsd6hBLcC2
 5xU8gLvfiuxqI5vB95JwY3Oz8aon/j2P9AdJFb4ActW2eMBbl5HvnSLtz7uElN/ck0iA
 rgFHspPyErzagMXppPZKxbWCjqLoK/TqFS11S5Syl3LiK6UsMOjOueyZYj8XXEdIm0Cs
 31HW2eYCHhP5MS8UxoOf/kE39ldSQeXThhOdQkAATsDRQ2XAVKLvdsyu4HrBYh10cIiB
 SPVg==
X-Gm-Message-State: AOJu0Ywja/3K8CxVJJeKUhixCg6/U8rXtCzK5YD/aP1GX7Nelutd8LSg
 cnpMKpuxG+yPczLwaCcz9Aa3ZvwFTm8FfEhISD344xRUwzgwQIfVKwISd28K+bdKD1xEbqfasV0
 OaUWj
X-Gm-Gg: ASbGncuhIhCaGu2qIFRPb83GQRBthR6aj8WBMhMGrFrCZuRowK4GLUIOWaHkAcbUmjf
 g5pnNDv9SPzsYVwqylpkCVqG9am9YauLvBVGvLRMzI8Zw+i1HtP7T2/d08CzPCiVKYM+nb/Jc3q
 eWR14sHOqsbSL8qahTLXfFwclMsMfgJa2uJy3C6OaqJz4RkoSJRxZghu9/bGR0wBQCBn73iYjrk
 iO20TI9R+8Er1UIJlJw1KKN6nA9dPxgCZWor1QJ8kOWtSOSvkDCu/Db0RXNaBhv320v0qiNfQBh
 W9lJfwY70nNrCdPFWYpSRNypdFaFKwiR6BAemYUR/SM+PL0XF+Vuag1zQlF/ID5X88QFV4k4Pex
 idQl9+BEqnpwSqHNA1neczbUO5saooKVcIDWzCytvCuM6ocPd/oHOUCPC1uxZioDZlNiHntkx
X-Google-Smtp-Source: AGHT+IEmyTbP/64H0Q7YtoIQhatimM+iBDkPVgc13Ww93yEFQNBOlwaS0nWU161acHx5g1ppWsO6VA==
X-Received: by 2002:a05:620a:4627:b0:7e3:4415:8dfe with SMTP id
 af79cd13be357-7e63c1b31fcmr1464741985a.59.1753740612612; 
 Mon, 28 Jul 2025 15:10:12 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 10/12] pcapng: make queue optional
Date: Mon, 28 Jul 2025 15:08:18 -0700
Message-ID: <20250728220955.332924-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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

The queue field is optional in pcapng received packet.
Use UINT16_MAX as flag value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 7 ++++---
 lib/pcapng/rte_pcapng.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 6db5d4da50..c27cb9b48e 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -500,8 +500,8 @@ rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
 
 	uint16_t optlen = pcapng_optlen(sizeof(flags));
 
-	/* make queue optional? */
-	optlen += pcapng_optlen(sizeof(queue));
+	if (queue != UINT16_MAX)
+		optlen += pcapng_optlen(sizeof(queue));
 
 	/* does packet have valid RSS hash to include */
 	bool rss_hash = (direction == RTE_PCAPNG_DIRECTION_IN &&
@@ -531,7 +531,8 @@ rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
 	}
 
 	opt = pcapng_add_option(opt, PCAPNG_EPB_FLAGS, &flags, sizeof(flags));
-	opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
+	if (queue != UINT16_MAX)
+		opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
 
 	if (rss_hash) {
 		uint8_t hash_opt[5];
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 4914ac9622..48aaab365c 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -135,8 +135,8 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
  * @param m
  *   The mbuf to modify.
  * @param queue
- *   The queue on the Ethernet port where packet was received
- *   or is going to be transmitted.
+ *   The queue on the Ethernet port where packet was received or is going to be transmitted.
+ *   Optional: use UINT16_MAX if not specified.
  * @param direction
  *   The direction of the packer: receive, transmit or unknown.
  * @param orig_len
-- 
2.47.2

