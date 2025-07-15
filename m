Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2377C83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 16:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05D1740696;
	Tue, 15 Jul 2025 18:17:20 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 180464067B
 for <dev@dpdk.org>; Tue, 15 Jul 2025 18:17:18 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4ab61ecc1e8so19935231cf.1
 for <dev@dpdk.org>; Tue, 15 Jul 2025 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752596237;
 x=1753201037; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=dJPoe/SosuKyMwuJJHTXKiFuk/JrpmaERlIU1OHnoeZTDGz6mVfIN6o2rXfpmxVy4x
 eQ84oy8S014BoGrIuuDf8MPWmVHPkx9EN3XC1wPW/yILVhcW4J451uu1WJUZnDeCiPPe
 NKqJhP6XNRPeSTXax9JIjVFmcG/2alGSZ9lVouoeXS335q2h5IvEDcqLUJlzNJc5d9hN
 yFh9NN623MdMQ3RSKcwfIJYXkYRWKQog5K6m9VvaWl2zYsev2Kil4fxwDlb6v6l9aZmU
 Hggzbre7hH+amfu8on0enqo24b9jSzumCnhr//4yGu0vYA7gIBL5wqKDRc1dafI8HREc
 FKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596237; x=1753201037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=J1PepxHv41XuzujoeENZw7FGDRJFq3sygYPRDkX2JtW5amBoK4uZSr7bKQULLvcSij
 6ivYcUNCYqaABkMlEWIwtwGMjupD17nBExQY7yjQTsDYnRau1UIs0Axvcv0a1J3ZhebZ
 yoja5ojVMxtDqHTyzM3pI163g1u9AkuHoJcDBHQiYheTMWZBKVo5xlph4v2M+eAZVhWv
 NGEw022gSdqLHMd6S09q+pYdDWK6PcX3ow5oqq6Z8Xr+HkHJ4+4qSxIWTaj1GW7H8iHn
 5LAlQxg9P/JjDQ2ixh+/jc3zDyNiRu26YWkB7o57M59rTsODipgRsOiSbirzRT9l97FP
 lEjw==
X-Gm-Message-State: AOJu0Yy2/19wUaVN4C2HDOCGwIWmnv01Kv+GoIfL+Li0irlOluKt4TzS
 U3F0jGIkZrongOlpmHPP4610Z9fUvHeSasd+6PGk8hJFD0zRW9QKtHU8TGuvOvaJI3UmoqlY669
 7OtrM
X-Gm-Gg: ASbGncuDwH4lZRFwtwHJ+PU5nQ9gMoF9z4rYnL8Q1BMhgLZ5emojW915/4EtQPG3TgM
 OnDPQotS+b6IypBngs9GBJ1G6ts3dPL4kwDBuFbY61YINFYMsjWXjmNxmZGTtuw/kxonE9aN4/j
 ycAPzCDPG0od57Ew5dnmQEVSIufKccZJsPjN0eFJnXChTRPjPYQ7+MSzaPArhks1THfhMidhH+L
 fnXyM5LTpVykE71quW3m9S/VLFfyjp8a5HdnJByA5dDppYQCLiUupg7/Ss+yV3jBN+gOhS/cK/V
 Kt4NzT4MU0LZeGVz/gqIBuSBjKU0GAGeF86M7gdqVhKPJlUx+MoLI/1yH/q/hEe6izznBcR9na3
 lmOegRyHbrZMP4BrP79URwAjzuueNcoFwta+8kWwtd6zKUIhHCUvIVnYJHXDPEP48FLCdmE58
X-Google-Smtp-Source: AGHT+IEMb5Kj4tSXJXaQMxAMA5f+w6Q4iGuUrGlwobKOtxgAro9jE3ObL2cT8cCPC/H0O1A7057Axw==
X-Received: by 2002:a05:6214:246e:b0:702:c8dc:c4a8 with SMTP id
 6a1803df08f44-704f4819d70mr881366d6.11.1752596236475; 
 Tue, 15 Jul 2025 09:17:16 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979a8857sm59985106d6.9.2025.07.15.09.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 09:17:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 09/13] pcapng: make queue optional
Date: Tue, 15 Jul 2025 09:15:47 -0700
Message-ID: <20250715161700.103209-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715161700.103209-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250715161700.103209-1-stephen@networkplumber.org>
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

