Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84524C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C325240E2C;
	Wed,  9 Jul 2025 19:36:27 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7416340E09
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:23 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso2353555ad.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082582;
 x=1752687382; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=2WW+vTIOeQR8MZbXGiGTiYG46xmZEh8nCAVEdGZw62OzFtlrmOzZFAFWTeitF+in/2
 FvctbyYxPeMEU/Ah/T1jLPvHIyW4L855QtXTtMqqiOuOL2yomD5MP06TtWaXPTk5fMkW
 Z1BUVlcwaoWX+7Khd784fF3HWEX28U5zfPpS1n1Va1OGsu3mfz6UQyjWeFicvQOIP9Et
 /Hf4Le41XEghROi4PxkIXGIiRZu5JsQU7MZDXAjbMeXVGUvcLegXrtEQOAx0AeiO/amp
 EWIns3sYAnq4fb9ll6jxeBKXbJchE3g7ZFVJlCFkh7UstL4uP9JbUmoB+Njgj3ViCBW1
 Rvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082582; x=1752687382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=LidSAqNtYbE5WnXyCd3y9IbZRRz3KUKwbxPwXuhLEAM82RkZNzblc5lLp/Z5jaDFq0
 vxdybCDsHOAWE2tn6KGXMeUdgPSi+Et1y1g7e4XREP0LA6mtfgQb9gbnFbwsc2LRapgY
 APOlCIF0JozmYlZ5LTi3DhtpYqZdHVKf7cFuFB23pcD7MFYzDQTFxg+vWegDkoWZhKt/
 NwEZqwwXz6/eLa7lJIPmu9vRgNXYZWu6chTbQHhddePGYre/NGsianAm7Qd6aq2d/Ekg
 wKQsLX33veGaII/TqcFPatRzLe+hDCTIou6qou8rBFG5RJAmtVNY6QbG3uMGP6i1nmT6
 1Y4Q==
X-Gm-Message-State: AOJu0Ywq7nP/sN57iROzwcCSorIcVE5kcQXh0eBWEsLeep4L9jnXjve9
 zTQ3gz8W8gqOMkP9mZSjD46bux018sDVAOHmCnIi4GE3RHS0WrmITTFyLHbidLswtGf2OWfoeLu
 0Gtah
X-Gm-Gg: ASbGnctU5dYnYAgRaMYqbvdh5YWfy0P+pQIzbP4VEFi7hUk4dBlvGEAul2ooOjx5vKh
 aFCaeVNfa6GXCB79QA/yvmNW1pg5LmuANSZgJHbBXKhF3kS0bavCcwYtyZroSjwc5to71NV+DP5
 WrWJWcVQxt+3uG6U7bfFYV27Z/BZyKdMI6VGLVBqB9hxt4P9bzpMrh5xO00uHyBTthDBcOORfyk
 CfzNml0PM3lIunZV0yp9hSvjY0z1pxpU//6bpkHO5w6qqMkxXnf3tPtxj9oM5YKwSUnkSZYIAPL
 kU500v4b0gYyxgGu7oMnUvnmGTFVpiPYfC+CWAZeW1wGxJnE6ChvmTVqr7P1s3/1KiZXiPhK/qE
 XFh4rQ+MsYKZtAVhJfuW5tnmNVv4coxJm+hCR
X-Google-Smtp-Source: AGHT+IHpJz8P7/IKueI5iL9i5pXZfBmsbOend2IlutpayL1EnOR7e2YXigWcolvdIEBntrajlpvkzA==
X-Received: by 2002:a17:902:ef0b:b0:235:cb94:1399 with SMTP id
 d9443c01a7336-23ddb1dc490mr63113405ad.6.1752082582594; 
 Wed, 09 Jul 2025 10:36:22 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [RFC v2 08/12] pcapng: make queue optional
Date: Wed,  9 Jul 2025 10:33:34 -0700
Message-ID: <20250709173611.6390-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709173611.6390-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
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

