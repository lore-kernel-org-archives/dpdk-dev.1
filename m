Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B01D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:29:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBD584027C;
	Fri, 23 Jan 2026 05:29:53 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id AAEDD400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:29:52 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so1672591f8f.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142592;
 x=1769747392; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbB09mZXp/wSLL6nZ5LfIyzIrgTjgZ/yGSSveIVp2gE=;
 b=yy0hHHRGQWnkXLBjZP7HxX3winvC1mEH4wLIWfcyBjHCOgLecj0McrjYdz5DX3NxTX
 ajN+PxuW0T7Im2sg+DNsw0j/H8vA/F+U+VC2ktXyvuwM9pQ2d6gNRwFcecj3b5oYrX1/
 6ZqpQdf0nTBhlG85MSuWOMTRz5OUgkh0xoXAlLL8w5fuQas6YIW29k4Sld27LMQM43Yw
 rRyBRTPtIgHYntzgrpMCLNb8X8E0hrfflSB33AOGdQsMdgX3M862e29n4y+5la9DUKa+
 Gq6UlkLGYjiQ/aiC0mbekwJQaXKHfYIUNH92nk+45d2nkIfp2J/qm8WN2YlEidMbSXVG
 lJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142592; x=1769747392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pbB09mZXp/wSLL6nZ5LfIyzIrgTjgZ/yGSSveIVp2gE=;
 b=rIyU+50Haa+S7q01vLrA62gr8ZXjc7XbWBWR3gdYjGdqtmN2kIKsn+ote0RLR3e3M0
 UjVYvhvkVbDz4jHAHxBZqzD2fWcNmYK4QCPN3pjtIgPISzV1LMwbGNF1XLx+lNOfEezF
 KrEpfvcGgEWOOa2C5MUsMHyA572ddPuSJVTrOMbLiuqjYH7rExApVFAsOKnIaQ0UA+E6
 4kn6k0dUHMM3/8rcRh84tna28RVbhcugkKLF1FFCgi6Ikn1wy76R3gZZyXXDLQLah0Ri
 SnOmF4+ZCyk/E9iDPwdFvM7WvdLN0F8Rr1syvxe/NRv/TrTYcylmXKSWuYwv9kXHKfnN
 pO7g==
X-Gm-Message-State: AOJu0Yz+t5IAMCe/3p2Tbbq4XQTfLihmLA62drCIdVFDAxAsqlm1/JM6
 NGHLWMLwneRBJpgGgtGDhymAeAdMCmQiT2Pq06RqYGZyeb5oRvO8n8lk52wCoqjvPmB7PI5iepc
 TdFjU
X-Gm-Gg: AZuq6aK868cKbk1yKy+6lz2CAhy3HCfGncwrD9DH9IGbAZg+HD8fgQDQsifJb/CBgEf
 ZnVXXGkh8bvipqYGYBmeXsaeycer2APizwTETA4xfY4nNTek76SXGOWxJSUlUlx85YNJW3BINr6
 eZtCw9mOIhGr8Ft8tW5ebkveD6eY7XNtx9b7GqtB/grxoq/ZUF9tSY2PPQj/aahWBPexnJ/+rK4
 74kIKQn13o5cF5cQeky35fdWFcXFD3NTYJCWfVtw55ijhbse4b8kSKGMpteehVrQR8vfFBwzKiE
 JPc/cZQdCxHCkrFqy9i+uaWXlDu81vABDbAHN9+xk6hs1jWGBaqM80YEAAhd95gTppP+dnY1XGd
 /T71/VZkXxbo1ljyw7SCaFLZNiASNaymrPme9oXkrhiIUBSm95dL8tJledYV1ro2vhkWvumCmiN
 pcjOWEs5qTfIDr8qOGC/lBrxhlOk+Ks8F0B0HV0KM5ePffhIjIAg==
X-Received: by 2002:a05:6000:2313:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-435b15f8986mr3248184f8f.29.1769142592129; 
 Thu, 22 Jan 2026 20:29:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:29:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v11 01/18] lpm: restrict name size
Date: Thu, 22 Jan 2026 20:27:59 -0800
Message-ID: <20260123042945.159075-2-stephen@networkplumber.org>
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

Check that lpm name size is within limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  7 +++++++
 lib/lpm/rte_lpm.c                      | 16 ++++++++++++----
 lib/lpm/rte_lpm.h                      |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..13f753abe8 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -84,6 +84,13 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Added additional length checks for name parameter lengths.**
+
+  Several library functions now have additional name length checks
+  instead of silently truncating.
+
+  * lpm: name must be less than RTE_LPM_NAMESIZE.
+
 
 ABI Changes
 -----------
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

