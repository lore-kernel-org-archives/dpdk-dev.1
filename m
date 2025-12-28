Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED79E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4859A4067C;
	Sun, 28 Dec 2025 21:19:46 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 7A4CD40667
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:42 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so8590295e9.1
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953182;
 x=1767557982; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4d3PcO9OnlqbXLB5y9kGlylN2T3DcgXZlqglHkAEmw=;
 b=xAf2UpFPLHIBsLbEcGGrq0sx9Asnp/WhAj0EULy1/ALFVW3k28CwPfve58PxTGj9GV
 yVbwzfxMz1vry5FU6nCd0tDQsJ/P55JdM0cA8jWGCimQqy/JjFE7vR3RCji4Db74Qryg
 7sQUqEbXoSkwsShNm7obVSX42BocOi2Tq/xqZZoZ75orquMC+vM6nsNgThsHbCoeBLH+
 /xA+sZ7iRb+Ej7MWfODY0s9tGBkqVtQEg1/13ZCXaGQYVPzuJTa2L0+qoAtgXQkDcaw+
 lrOfCwgeYaN0hBjsWo+x6r4Zsi2j17+EiHrmZAW48PV2cjnaBTsOGH+a2KKoVojQB+g/
 vrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953182; x=1767557982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T4d3PcO9OnlqbXLB5y9kGlylN2T3DcgXZlqglHkAEmw=;
 b=rvdMsdJ2rgwRf/6pUAt1ZiLSnNduN3Lh2ow4qUhXQKldceu9I62ss3fXOL/92wgTF8
 xNGfbl3o+Q4Iz2B6iRoCc6+0k7ihPNBjsqeEh4zasuTSew5dbK2PuPhkrIDp1EE9fsEr
 pyRLrxEYcADuq7zAl9nnXSfjy+FXjlizYmkCDsl4sELYjffhvxCIQfk/MXHEPIFdUZmO
 AbWZvO3eWmcxkD3BmcdLeGuYUNIbwX/RgPGt+2Us+gUEqmoBH+OD4Mn0CidUl3QoFen9
 JLGoorjJIfqeMU3MA5ZNImt8mWNBcsSniwbEimqNngnQxnjC0KTPf0q2azKMc4G6yXRI
 R7cQ==
X-Gm-Message-State: AOJu0Yzq3mOo6JtBBW0lZUpyvktFQZn2sCvhjbVBFLSjnkac8I+KGZS5
 cI6H2b9uUMgZq11GhREDPglM2HLeNy5mdbVq2iq8GY1bjtoAqA6Y8K3Qo1/Bfvsz9ExAPuC8PyH
 ysjo/GII=
X-Gm-Gg: AY/fxX5CedlMgjVSwRJlUMUGfEpKlhDWpM54uTr0TF+oSj80QxMAprCG558aOis7BE/
 nD6qpGrm+CxD2BbzxlJoRSDZtrx00YYlc5TMIzMlI9Is+vPix4ZXJEEqPFX7IyzzpTqZk0l03WC
 5vSeYtvrsfuGu6rSf+dT8PFUdOOL2E75p9gyCY7HdhDgOQaJtFQ3/6MhtI9+1aGlIHwaRogyoIM
 GTQKDiUeM1nCyvGlOLhXiennTUwq/hfbtx+Gkgzg5FEZy6N4RS7GDScAQ/+TCrluC09++OFB0aB
 iK38pD4lhx89aQx3YaPqpTpUhjDYpOMx7dDP0JuzK+Usr/2kquCej89Ko9rDp3JOMiiiSC3eaYR
 0egJPq2xTC0OOIA76gK0KbDMfrff9D1yuQViU/q1FhI4dsMFtFXH6c0g6o58YtwyRxNmbANHdBP
 ElayMwIafKSpT6n2UlEwkg2ZbHDDk94F/FPtmgpQsIvYFZ0P9I6V+teC1j8GI/
X-Google-Smtp-Source: AGHT+IE1cT0tPBh3CC5jJ63R/xfiI8UvRuLE28u4NPh2NLQj6NGMGXrt5iaJus3dFNUrF1ajRZR7PA==
X-Received: by 2002:a05:600c:45d3:b0:47d:4044:4ada with SMTP id
 5b1f17b1804b1-47d40444b44mr162060335e9.13.1766953182040; 
 Sun, 28 Dec 2025 12:19:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v8 06/18] efd: handle possible name truncation
Date: Sun, 28 Dec 2025 10:56:09 -0800
Message-ID: <20251228201236.547268-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

If the conversion of efd name to ring name gets truncated, then
log it. And if the ring name than causes collision, make sure
that log message includes error reason.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/efd/rte_efd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index ebf1e0655f..bbd565f404 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -517,13 +517,20 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	efd_list = RTE_TAILQ_CAST(rte_efd_tailq.head, rte_efd_list);
 
 	if (online_cpu_socket_bitmask == 0) {
-		EFD_LOG(ERR, "At least one CPU socket must be enabled "
-				"in the bitmask");
+		EFD_LOG(ERR, "At least one CPU socket must be enabled in the bitmask");
+		rte_errno = EINVAL;
 		return NULL;
 	}
 
 	if (max_num_rules == 0) {
 		EFD_LOG(ERR, "Max num rules must be higher than 0");
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	if (strlen(name) >= RTE_EFD_NAMESIZE) {
+		EFD_LOG(ERR, "Name is too long");
+		rte_errno = ENAMETOOLONG;
 		return NULL;
 	}
 
@@ -698,12 +705,15 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	TAILQ_INSERT_TAIL(efd_list, te, next);
 	rte_mcfg_tailq_write_unlock();
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name);
+	if (snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name)
+	    >= (int)sizeof(ring_name))
+		EFD_LOG(NOTICE, "EFD ring name truncated to '%s'", ring_name);
+
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
 			offline_cpu_socket, 0);
 	if (r == NULL) {
-		EFD_LOG(ERR, "memory allocation failed");
+		EFD_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		rte_efd_free(table);
 		return NULL;
 	}
-- 
2.51.0

