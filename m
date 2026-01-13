Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2047D30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:23:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD0D640649;
	Tue, 13 Jan 2026 21:23:37 +0100 (CET)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65]) by mails.dpdk.org (Postfix) with ESMTP id 8947C40613
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:36 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id
 4fb4d7f45d1cf-6505d3adc3aso12371840a12.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335816;
 x=1768940616; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbB09mZXp/wSLL6nZ5LfIyzIrgTjgZ/yGSSveIVp2gE=;
 b=tu3qXQUNdW9zm56aHk+Don0IzVE2eeBVZe8nkYK16xGmDTZuo89QO1g4lAdST04Q95
 UAQBHmgcQfnFpkNkDhCr3jpnxcxd8M93WCKFbZ1TmAffx9fWCGehRKYcubrdKTcrSe5z
 /OnhhVuQRzFT7kwbhAJBmga0ysJcW10LW2Rkc8eR94wwsHa2I7cM+wSqdc6JWnQun3PR
 QDGaL5SmShD5LstR/ID8srndXsbXJH5JOusQ0T4oS36GP6Rw0gUr3OH1cQnhQvivjdH1
 rTc54Zb9Sbjs5lbSJUpJjuJnGQLLc97VQr4YhdhZP/EF1GU7V4snFxbAmPcj7wd+EkuM
 9gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335816; x=1768940616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pbB09mZXp/wSLL6nZ5LfIyzIrgTjgZ/yGSSveIVp2gE=;
 b=Eq5wqPThxQGIUDEK6pvsBj5/jz7hdMZr/7nSZ4Yh59mPFsPYXoHLs+DRS+iUOmSJo/
 JsjeDU+IZLulY6qk7+y/D2PY/shxoX/WdgLjFhwyL41S57Kq2b1WLcu2LRxF/TDmJ6I9
 dO44zYk3I4Cf/rzE14I/YG9LxKqnAVVrNxHniLSuzZ0c8cdkl/TszoqpLxubIpW3RBNw
 R+uG1GHoOadhZL55iFp4o+K7grP0aD1M01SQ9fwGJppJy2nlkUVsxy6OuZb3EHzwH/VT
 BMbwqhymWj2dnlIwb9hvg104y4u26bU0/hrs8vQPvA/Ob5tUJoETFKtdgieUJ1a09HIi
 Kj8g==
X-Gm-Message-State: AOJu0Yz6kcnYs8XyojjH35f4wfwNKSl37vi99sIfiurPYvmfJZi791HW
 el3mdjXFXcVC8u5et2dpXCcwrHtw2kHqYjP5kq+S4ogQ9fN3g1Nn1J6StL5AlfJIKwXWlYMQVo5
 ic5Is
X-Gm-Gg: AY/fxX6z23C5O8sgfz/2/jWEryPtg6HHz80gtf1MB6D3fbIzhf35Q1heCq2aSf/J5qg
 vKrzxQn0GHuQap1tTiwky9LAxSIllAxdN7XVGbTclLeMSDwU/4Kzxv3bhaa4ilhMcObRKGBrTp+
 0umEeqE0aJI2cOnLtsJjIALO0Y3Zb0NRrdL54wZWKUd5BBKEH1oDb7cTdgBF949o0EEs5mDi52h
 Le5K5sojRbQ15u8BUR+MsmoTJ7zId+k4d90xUc76HMGUNlLyQhjwMJKnHg0nenfYMzgV8P8SbwH
 2MoELJxmvWDJNARMX6m3AIZ8vyLDfULTqrWvP/kJ1rtQef0ULXDmlILb6Ce/RK4QO1x+2Rvtlby
 D9DfVvn7WVlaEOAmAIGonNjBok+kkuiIMWACRUh5YD2G38aRxPWUJcFj7nEZGqPF+91ba7OvCi+
 c0Ax0fc6m6FSOJjFNd5KjoPW87wgXVCaQ3Eldm9dhv67XylIBowQ==
X-Received: by 2002:a17:907:3f1a:b0:b87:281b:1445 with SMTP id
 a640c23a62f3a-b8760fcbe80mr27199166b.11.1768335815910; 
 Tue, 13 Jan 2026 12:23:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v10 01/18] lpm: restrict name size
Date: Tue, 13 Jan 2026 12:21:40 -0800
Message-ID: <20260113202329.35190-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

