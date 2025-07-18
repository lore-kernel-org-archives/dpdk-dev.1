Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B6C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72EE940E38;
	Fri, 18 Jul 2025 18:33:04 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 7C7FB40E38
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:33:03 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7dfdcded923so248947085a.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856383;
 x=1753461183; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=Uahq+OR3SWdGrWHKA6CvRcHZwnHkTBtjhc4AvoBJqggG1ZP+gamSn7l0b+jyJ/d36L
 57WxSXDJzBI+9htfL0FAKHF/vkuW4sSEGMhKzmw6l9Yd8XCLgDpVs+zIad/BZbDGf7wj
 bjZ4DtOTCBgSfoBU0qAU/RjFcE4bRXaPAQe4JUWdWPCjO7pb94wl5lJOLchR2uz+0hjJ
 9awl7MEUiTsIdPWCLXZZN1SOg6EZRsxLKgsfzdj3aPVVC4QIwFoIciDx709SRSe13yOp
 MMTwFrPGDRvZk5xvCmup/Dsoe8DCnO00cmpJ5RswE6rdvPdW8zcVkM1nLWmWvn926XY4
 dCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856383; x=1753461183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=BMy2jV26V0fN6bgiWLicE3DzJOYXrbBa1TqFQycriq2FwLsg4dG2Z61mrWj0kdT5xH
 VO54Unq2HTK4P+8wn2Yr425xdxFqCTch18d3wb2Cwrq7KTJs2umDRxxOM4xHmRLDwRzU
 x/eovk/nNJRARdEHMm2gKSf6oDqi0Cf4rEhVBqR3PwszpDc1PCQNB/hEjLrLD+lB4UnD
 u6aB25HSf6T6pWgQcSB1siyGii+WmneUjldou2flJidcRvCqkTTkfyfpUS2tHZpVjnA1
 wFXTr07L/vEwuCpLz3YOBhJNjH8wDa2q5cvauvaP4moeS8ifaisJB/o54eEGbcOtbB36
 uWlA==
X-Gm-Message-State: AOJu0YwzSOsG2NZDCmTw9hyZwC/q8U1K6vLIrpYgk5gAsAQS26++xNdv
 7hxoDHllyxyPgON4cadWRvsvqRw2/fHfrcKM/z7mk5lUDx3KWPoWqGhQaS3DqSOZY2QYX3r75v6
 QBY2m
X-Gm-Gg: ASbGncs6UdN95SMvGGpqBJV6crp5uaxOm0QNXIX2euWWOC0+XlrdkEkSb6R0bHwoiph
 Ly2AMNy9Qs3r298gjNN+70z/8AgV/Etrh2gC7UkPWdqMASJlKOys7yWp9HGVRJNlIVgRf7aHLWX
 eWBtLj0I4rOab6e30sUkmszMJrlxnfZWX1ymJ6jWkV1Zqyf81UYC20qkW53oobjK7WUjnCgqn+v
 +raJSZt4pb3AuyB4v+1kKxzq1PcpAvPARNgfGaYBm4ngANKpy31YxQ3cdAnT978Ml24XIt66mnb
 hKxkFDx9EkEJGyIAgbXc3oV9nW4RA3XeV0Nk08VxgTRI1fsqR+qUCEmAPasZbCPd4i+hTsoA29G
 S174K8orCHykKYVoQpdXPQTS/M7icgK9R5yVerox7qv4/ZJ+NJuR12texlclvRaw0yCRgQ4mQ
X-Google-Smtp-Source: AGHT+IFHoZBzNLcHDwQYpjwH52yAezsp7FJZV7YHzCze3k3UiwrYl4LxoRURSQYcmcD+4Y9mN0lpYQ==
X-Received: by 2002:a05:620a:4444:b0:7e2:a47:e50f with SMTP id
 af79cd13be357-7e3558d918amr613831085a.17.1752856382396; 
 Fri, 18 Jul 2025 09:33:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:33:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 09/13] pcapng: make queue optional
Date: Fri, 18 Jul 2025 09:28:26 -0700
Message-ID: <20250718163236.9870-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718163236.9870-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250718163236.9870-1-stephen@networkplumber.org>
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

