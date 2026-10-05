Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB5CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:55:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF8EA40E1C;
	Mon,  5 Oct 2026 18:55:18 +0200 (CEST)
Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com
 [74.125.227.146])
 by mails.dpdk.org (Postfix) with ESMTP id 31F3D40B8D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:55:17 +0200 (CEST)
Received: by mail-pj2-f18.google.com with SMTP id
 98e67ed59e1d1-3a4c276e1c7so859101a91.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791219316;
 x=1791824116; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MXPJ0TTVmdRo7RELXcaxHTZ2Y268QBt1WEuammHDg2I=;
 b=u2N+2Pr+E/Jyr0uLkdmqHAzFa/o4740wbDZCpcdxjXl8BpXRX3AEWO5vyPnAiGX0Sb
 OvIFCWvhRqYfZujQw/N2AJUOOmTqCGOifYrT8NdC8D4eG4cs7xMJDnWe6/9nnsWjSVvx
 zpUEhCSoBFquHLxz1GQgwflrStK3EAjVfpvwsg6aZKjMHpv6xbFUQlTG9VvAJVfjvnPd
 EyPw9vv8smf1OTMhmzRiANOslt8YAiYaCnsOIwiF8kif0T1oahZR5Dz5qTspO05DqcEm
 7Q18kV2bCGhDXxm+vuATYgia/3Q2CdylVzmCK0MHbX6qIMQBYYMg5oU6AfQGyQlIi+cB
 /ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219316; x=1791824116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MXPJ0TTVmdRo7RELXcaxHTZ2Y268QBt1WEuammHDg2I=;
 b=Z1iygYP3ohXknh7N+lLoe6jl3BdEsZARDmsHPHMh0LQda5sqp2b8FNE9KDE/22kWZ3
 Z9ELN5qYGtS1fVBe7Ka5fnnCMpGcnMZrBqrMTuXmhSHIETcSJO+ZbFU5PZOWRJAll41r
 UeObmZupYZUK84UqAEobpewvasXE1a5L/vuBaFwvGTIgUykMRfb08tXRa34nt55yhmzl
 6axzSzhOSXCQqcyYFuLKUE24xRa7IaQDtu4JstulIUGhh7m6E/4bHFTfRHy2qauk2XGu
 6y8tq1TRswPy3Z+qLUnnPMVhqVw6wSnnaBnL4N8CIPj5skkon+G9Xbt9hXmoOD78l+ZS
 jN5A==
X-Gm-Message-State: AFq9FYLU7ebEnCRGP1rkWPvWRE7jq1EW4uBlj402oJjVZVSMZQIZPF7E
 +GlicmF351BNwcPPbRIk2ewLY1TxLmr3LlVUV5Pq1EgCVCSWKqsbFL+yuVvodkA2oKu+EJOkU0D
 vLPhheQY=
X-Gm-Gg: AYBFou0oONO6NL9hMGEGd6H1fJzMY+9x94MrPXVvYKqriLbKrELPcKzeMdo+uSU8O6d
 2ZUMFy/m7kMv4Rdh0EeZyiSpn6DIRLSZQD1PKQSa2xprATxnHEnQ/8BIiUrg52EXTv60pj7TjTU
 BxZyFpNBUduFtml4tUCjF1cIbCKMX6TfEpnGwIdxH83kmGvYdPRvGU83OcqkFzZuI7Bu3XtTKhW
 NyYTxj5/oJN0q2DeBFxS/s63lxRHKLZq3HQhA91p2186PcBwenSJUeJPz106KtUdmeFh/TXpIAq
 jVK/s/7Iq80zHoLNJ3rsBZYTyBFcc9FcyWzsM6tlyBY21pgfqsnriKa+6qR2khGOeLFEEuhBLzT
 r0uk8vF3cxowME1Vz/u8XykuoBxLs33jEV2xWE6fGjqoek1u0iiW8mPZyjQDpwZXb4ciA+O22ce
 KPCZ/i4cbqnFLCMnl8euWtES8S3afHYG4KtBlX3//4h6K4mdHdtHdqFBJqaNzId9ldM8Wa5tptq
 aFZd2ly/6YtiYAX/OZvQZW2PWg6IOu4fZul2Q==
X-Received: by 2002:a17:90b:498b:b0:3a4:bbec:b4b4 with SMTP id
 98e67ed59e1d1-3a6ce78f166mr4898187a91.26.1791219316202; 
 Mon, 05 Oct 2026 09:55:16 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8533aba95sm289414a91.2.2026.10.05.09.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:55:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/4] kvargs: harden rte_kvargs_parse
Date: Mon,  5 Oct 2026 09:53:48 -0700
Message-ID: <20261005165512.334085-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005165512.334085-1-stephen@networkplumber.org>
References: <20261005165512.334085-1-stephen@networkplumber.org>
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

Make rte_kvargs_parse(NULL, ...) return an empty list rather than crash.
NULL is not excluded by the API doc, and an empty list matches
"no arguments" so safer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/kvargs/rte_kvargs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/kvargs/rte_kvargs.c b/lib/kvargs/rte_kvargs.c
index 4e3198b33f..89c1b74308 100644
--- a/lib/kvargs/rte_kvargs.c
+++ b/lib/kvargs/rte_kvargs.c
@@ -272,6 +272,10 @@ rte_kvargs_parse(const char *args, const char * const valid_keys[])
 		return NULL;
 	memset(kvlist, 0, sizeof(*kvlist));
 
+	/* Treat NULL as empty string */
+	if (args == NULL)
+		return kvlist;
+
 	if (rte_kvargs_tokenize(kvlist, args) < 0) {
 		rte_kvargs_free(kvlist);
 		return NULL;
@@ -294,7 +298,7 @@ rte_kvargs_parse_delim(const char *args, const char * const valid_keys[],
 	char *copy;
 	size_t len;
 
-	if (valid_ends == NULL)
+	if (args == NULL || valid_ends == NULL)
 		return rte_kvargs_parse(args, valid_keys);
 
 	copy = strdup(args);
-- 
2.53.0

