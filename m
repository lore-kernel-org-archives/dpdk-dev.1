Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F20D3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96AA740647;
	Sun, 28 Dec 2025 21:19:32 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 9B1D3402ED
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:30 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso82070225e9.3
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953170;
 x=1767557970; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxPM7sAoBjlw5kd3Em+aUyCnez83/vbeYYX/L99dWXI=;
 b=XhhzRJM+CtHTJD08HbQYVOJyC8WcNLqrj1gVoqg9bjB1h8g20bC6s+sZ8GmDvV/TRY
 VJ3XUmHUo+bpBXL8Q/G6rV/YnyD7h0GxkAQ9Pv/MstMua19hP1hpvjSlWre6zN+D4hW7
 CynQ2JaU8WwUBBjB8iNC9SlELZnhcNdz6EU+j7hAJjkkOEd5GbKVyniQJyWhmLxZIxNh
 MfyxYARvqyUOgKoS8kCMR+Qv6yQ5iqPQO99KDSQ40/X+ejr8xdgmqa9TPJXt6WKMNLa2
 aHHvuaeYww2FcWgWt2B5D4s0AZtJBXHZBZL3BayCPBGUfj3Ug4GAMAoYdovEq8KO+zrW
 5Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953170; x=1767557970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uxPM7sAoBjlw5kd3Em+aUyCnez83/vbeYYX/L99dWXI=;
 b=hL5zKtOyPkrM1Jn75xdG+CLh88ce1U0TwYVZvBJ06AQ27nq7H9Q1C7GzHSaonSxZqi
 c468DGG6AOM73+lkt5wZBMTFM6u6L/KClp0xRIXGhrtgeCDzsEzMrX72wjo3BUAbK5Xy
 xvsMfYmlmCMAhOegDr6diIminfxyH/fj51/xPgaM5HWJe3PIeMJcTyCvUfIwdnTrLnRC
 gdiMkNZ7BIPLbqcHVXCdU57v23U+dOePQry4SSJFfXq2HnLXfsDXAt4m+ICzic+8h4CI
 kMNa240IJiNycczc0T/Nd5C4J+W6fghgCt9hrPXo72F9165ggL1NVN9IqYw0uN126Oif
 vQNQ==
X-Gm-Message-State: AOJu0YxFTfn6fiRKG4U5bBgRVK13sbiNLzYIBZ0AJhyg3fXzfwgjCO+V
 g1Xc8ewI0Mhkbw84EIN4zQZUHlmPdh61Y41HYc/VbMEQuORUejxtBRKghWwujFinZdYr+qk2vb4
 EdDPG4fg=
X-Gm-Gg: AY/fxX4Jj6eqgeySNPI/FNgnBTR8irXdONZpO5G5Na2HGgDjSTxXAFwTWRSZW3OuI8f
 54q4FwzFZ+GYtOS9sqD9nMLLkVVy3Vbx2mvuQRYSH19tC6lr1+oMG4GM2IpjpUuGLpfNYOIizjH
 kQqncwmc1CfUbOEf1TD9oott6RZZnd/VLq56A8xgCqQM/CaNQBqD1rUpvRNEIwoFXUakB9407hF
 ATWSXyZToiBzNTNXB+3bRuACUqNwJvy1Yi+sUdshmQEeQwjHjP/rt9Co8N0QHPRk1kXChmCZiKf
 brZ99GMP0kymdqM1gsa2aMWPNqTtbiljl8anOptux/ZIZwWetNSrxGxnLTFSPtTGQnMkJezC2go
 HdFZjw65PZXoVHxKfGCHGSH4CuhWe3M6aU0wj4kXQjJTN5Viqsr3kA3aEAZw/G7sR5HD2htdfKP
 4BTFP3R5PeLrR3n6lQ3bNQstgh+gKgQYwZccIcoheI0Oagfinm+A==
X-Google-Smtp-Source: AGHT+IHJFG+tHotXPdlpv3artOxZGbqewm+xJAi3/fQH0RvEHOmikNuS1RhV2Xgu/p36OCc4c8+TUQ==
X-Received: by 2002:a05:600c:4e42:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-47d1956eb65mr256369035e9.2.1766953170176; 
 Sun, 28 Dec 2025 12:19:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v8 01/18] lpm: restrict name size
Date: Sun, 28 Dec 2025 10:56:04 -0800
Message-ID: <20251228201236.547268-2-stephen@networkplumber.org>
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

Check that lpm name size is within limits and add checks
for truncation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/lpm/rte_lpm.c | 16 ++++++++++++----
 lib/lpm/rte_lpm.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 6dab86a05e..9c20eb731c 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -152,7 +152,7 @@ struct rte_lpm *
 rte_lpm_create(const char *name, int socket_id,
 		const struct rte_lpm_config *config)
 {
-	char mem_name[RTE_LPM_NAMESIZE];
+	char mem_name[RTE_LPM_NAMESIZE + sizeof("LPM_")];
 	struct __rte_lpm *i_lpm;
 	struct rte_lpm *lpm = NULL;
 	struct rte_tailq_entry *te;
@@ -170,6 +170,11 @@ rte_lpm_create(const char *name, int socket_id,
 		return NULL;
 	}
 
+	if (strlen(name) >= RTE_LPM_NAMESIZE) {
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	snprintf(mem_name, sizeof(mem_name), "LPM_%s", name);
 
 	rte_mcfg_tailq_write_lock();
@@ -327,8 +332,10 @@ rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_LPM_QSBR_MODE_DQ) {
 		/* Init QSBR defer queue. */
-		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
-				"LPM_RCU_%s", i_lpm->name);
+		if (snprintf(rcu_dq_name, sizeof(rcu_dq_name),
+			     "LPM_RCU_%s", i_lpm->name) >= (int)sizeof(rcu_dq_name))
+			LPM_LOG(NOTICE, "LPM rcu defer queue name truncated");
+
 		params.name = rcu_dq_name;
 		params.size = cfg->dq_size;
 		if (params.size == 0)
@@ -343,7 +350,8 @@ rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 		params.v = cfg->v;
 		i_lpm->dq = rte_rcu_qsbr_dq_create(&params);
 		if (i_lpm->dq == NULL) {
-			LPM_LOG(ERR, "LPM defer queue creation failed");
+			LPM_LOG(ERR, "LPM defer queue creation failed: %s",
+				rte_strerror(rte_errno));
 			return 1;
 		}
 	} else {
diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
index edfe77b458..38a061513f 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -180,6 +180,7 @@ rte_lpm_free(struct rte_lpm *lpm);
  *    - ENOSPC - the maximum number of memzones has already been allocated
  *    - EEXIST - a memzone with the same name already exists
  *    - ENOMEM - no appropriate memory area found in which to create memzone
+ *    - ENAMETOOLONG - LPM object name greater than RTE_LPM_NAMESIZE
  */
 struct rte_lpm *
 rte_lpm_create(const char *name, int socket_id,
-- 
2.51.0

