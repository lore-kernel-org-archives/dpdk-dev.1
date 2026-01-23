Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B69FD6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAE534042F;
	Fri, 23 Jan 2026 05:30:06 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 1B84C4042E
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:05 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so1167457f8f.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142605;
 x=1769747405; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=kCQATuKSD4HRbyJl66cHWHd7EXkxqSgNG82NL3OzsKxNjibIaldTeU4LCIn3wGzMle
 186gpKzjON1I3WGIXEZvGeGqJfQAiB/bE2y2H7W6MZuX2rcR2q5NKNJBRMasjIgfA1Mm
 o+76zY3dr76kYc3Pwck3SOyMBAVXOErbuR4yaftogw9Ok0BFxrxZ/nAm820f2d4gc3BX
 J79/3B1FclP7fQWbkpAeFSjmA8BoeTWWBnV4fyZqjHk5TI6pWthkpzW7RpSD5LXHH33I
 fNlXdXwhuyfK/hbMTXU66oDv+tO1A8yfMnZ4+KnOBrdYim924T2nPxhfmRO6TcdFcd/a
 Wc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142605; x=1769747405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=wvbB1oIEqmemqC+tx48t4LfcFwSDFuKN4EosrIcoWrtm3DbJtocmQ4l/dhKIktNS4P
 Chjxemh99IHYKfCMr9sBUJf2Gkd7jMPDPxSuvAgHdJZsFNULYR0ZM50046zFygqUZOur
 xnR0Qw1SNQKk/ALSvbcxn0NLPnwMqn/GzbXaQJUaJfQq9NQ50gz2pCrBS4dBa8N4EVAT
 hhmT4FKOGGBfZB/SWDHtlMjM/QlFc3mZ7RkX+TZZIoxjqRdzmfh4ql11pPESygb4yfF9
 dSgKpJ0lCFsH6/jX2RevcAp3Ka9figutC9adGReatY6WDM0IxUkTtd+oyep29Vn8Zkx/
 qKvg==
X-Gm-Message-State: AOJu0YyHGDuD4Aa8kUkyrjHA4eS0mZ4j9KoY/F53Xena2PaB/jaEc5Q+
 oveVGeQU1qm64q/w8KW4DKvAqytKoa6Yii7LhjGs7e8vw+9kdJCuxHoKP4N9q5WWzGQObzufW1N
 gNz+x
X-Gm-Gg: AZuq6aKTGZT5GWH7ynkwktNZvbSB2Q9YtsC5a2DWK0AVdG5fpfvCCUJRs2tdfpA1L89
 Gh6XUYHkN8IjXuQ7GZnZf7vzohtUaDh5Tq4IqBrI2daB/rp3kQKo7XeAXotPjxUj57UfW8dE5y9
 Haa94YS+/5Vn6x/7Ebonr29D4QV4vUc+6f2NSrSNrCBql2pN9OFBdetRb7kLE5JKpHE9A55ynPx
 GsBI2C3KCII6NdT078sZCxmWYzK/f1KCtZ1nnBzOTtFD05IU1GxQFJCk/4nnNH9FG4mSo6VElkk
 kQx4N1N5zlcDUN5szCdf8R5OIpDRYbweYPbRBKQPz3n4OH795nICc2S5Ij3QxpTtrhrnJqdfDN7
 8h6jk4reOW5hHioN6IvZwunfHp/0h1Ho1DmbUldoanWw/YoGj7ez4rrxiIWRKwASx7cZzGRvB47
 aqdulHV2Uzd1lzrBJLEFTA1EGzHEyMz4lK//KrZ8Wliw7KLlM7MQ==
X-Received: by 2002:a05:6000:2010:b0:435:960c:5284 with SMTP id
 ffacd0b85a97d-435b160357amr2790866f8f.29.1769142604719; 
 Thu, 22 Jan 2026 20:30:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v11 06/18] efd: handle possible name truncation
Date: Thu, 22 Jan 2026 20:28:04 -0800
Message-ID: <20260123042945.159075-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_03.rst |  2 +-
 lib/efd/rte_efd.c                      | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b966ce7b49..91b1808455 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -92,7 +92,7 @@ API Changes
 
   * lpm: name must be less than RTE_LPM_NAMESIZE.
   * hash: name parameter must be less than RTE_HASH_NAMESIZE.
-
+  * efd: name must be less than RTE_EFD_NAMESIZE.
 
 
 ABI Changes
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

