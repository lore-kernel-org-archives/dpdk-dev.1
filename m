Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F57D46BF0
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:43:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1143C40613;
	Thu, 29 Jan 2026 02:43:23 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 41A1F402D1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:21 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so4385995e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651001;
 x=1770255801; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Kiq20yK+3+wPNOar68UfvSv12nFZx1wqgsdQ6Qbn0U=;
 b=xbefWSiSCFvsWdv/7syeacpMAXWVOMLBuIK+ELr2G8IrQrbQSERDbjVHZOrI5rTzLY
 eKu+LQyQhUPXSqeuHnFwEfSnuWpbFVUdEXI1pvNUPRsx+N5XTrDTaaDSY0qXr/uI9Ino
 PF9/g326hEk3sEwlsafo5uHGoRp1PpMfLEYqA4rvtQsgN4xMYYg7aJJFnlg6PgFTNsE4
 7uj/cPaxBGjED2PrrtmyVFeIVlIOc+bwcRZgfFA2MyVjIWCvR+Y9ILcJfwbKujC1qE75
 7tjCl+W/3qMaYRq0fpFiEhv8K9o0gyDFSUMNPPOez5gDBBGKCK4CRlrPlWCfenAFw4r7
 HV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651001; x=1770255801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Kiq20yK+3+wPNOar68UfvSv12nFZx1wqgsdQ6Qbn0U=;
 b=Xt/hu0sLepgcbm/0svwIGkHOK/yH1QVlJ+sXzVmLP/nNNT81YcUQZxt+xUQrBsnvkq
 DCwmVNhK3HTqsiMwSejFjmBYn4wZroP2HjZpvDnkbuQGGdz/xxx8GldzsNCTK2ezu/PD
 oRghueMGgj0zIQe2SY6bh6T3WhyDsV/bWsE1J6+6wS4Aw9S17TN2f3JlwaVof9sUMbro
 4+i4PD5wh3MuS+cxqPXJ4FnV+m88hMmH+MjfVKZS15urlc1fNFU47VIVtNzm7UF5KByn
 mua5HF14ei31CWDoi84DZdD28Uj0Xfv0XnZxGBIUPgziWJPDVoMP6LbcSvKVkMfvIe6u
 Cq3g==
X-Gm-Message-State: AOJu0YyMnLjoPvP8KGlv91+U70Eb0t1ksaOTr8YpniTq1Gl3tw1B/+17
 wO3HLa989/34Hb0DMTeQNHCUd/d3p6Cvh3i9qUIhd4k+ZxGcD4LGNnIWkkTMQfD8fmIa1/Bzpua
 rsRmy
X-Gm-Gg: AZuq6aJfRhHGuQPwkLeGdrYIw1egL5/AHFH+ebvaXN487V6ubkSGTgLNAd2FJnOW+bg
 M6Z21+1ITHUZ/xZovS9Gz7/+9bWPMQCjAT4fRk7A4/yboXw2ULllzaXzRiBwiUYiVr7YW9wCeE8
 l+R2HJYnOnjQzUiZ4H9cjWK6nW3LJ6z4yYZ0BVhsZ309LK44KFwQFZ/N12JIgNm6Butic8vRu/S
 +uQzj8v4mY2aNukXTim/yoCSWG7cRT0CcavlYakBsmvUAhe6eXPfToGx5okbZcuV8+GZcEhOM4m
 TUpU6tUWdk4FI4qQT9Mf25+PYES8gPPt1yAHGsW0xHQ0XiupPsw7AsdghXfxdIeOGkN+1zTpScv
 02EyXmSzkKqKvp0eqSJFRjZNhUqtRXbvNJT4o9MB6jGzzSjShWIubNeKuZethSOYRWs78X2i9tF
 oDeuN54Bgx9anI5RDG+SyB/P5L7p7vNIAD026a2iWzgEYhuDes+Q==
X-Received: by 2002:a05:600c:1992:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-48069c745cbmr81072385e9.34.1769651000516; 
 Wed, 28 Jan 2026 17:43:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v14 01/17] lpm: reject names that exceed maximum length
Date: Wed, 28 Jan 2026 17:41:04 -0800
Message-ID: <20260129014313.939831-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

Previously, rte_lpm_create() would silently truncate names longer than
RTE_LPM_NAMESIZE via snprintf(). This could lead to unexpected behavior
such as name collisions or failed lookups when the caller assumes the
full name was used.

Add an explicit length check that returns ENAMETOOLONG when the name
is too long, allowing the caller to handle the error appropriately.

Also fix the mem_name buffer size to account for the "LPM_" prefix,
add a truncation warning for the RCU defer queue name, and improve
the defer queue creation error message to include the actual error.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  7 +++++++
 lib/lpm/rte_lpm.c                      | 17 +++++++++++++----
 lib/lpm/rte_lpm.h                      |  1 +
 3 files changed, 21 insertions(+), 4 deletions(-)

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
index 6dab86a05e..0ae8479481 100644
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
@@ -327,8 +332,11 @@ rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_LPM_QSBR_MODE_DQ) {
 		/* Init QSBR defer queue. */
-		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
-				"LPM_RCU_%s", i_lpm->name);
+		if (snprintf(rcu_dq_name, sizeof(rcu_dq_name), "LPM_RCU_%s", i_lpm->name)
+		    >= (int)sizeof(rcu_dq_name))
+			LPM_LOG(NOTICE, "LPM rcu defer queue name truncated to '%s'",
+				rcu_dq_name);
+
 		params.name = rcu_dq_name;
 		params.size = cfg->dq_size;
 		if (params.size == 0)
@@ -343,7 +351,8 @@ rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
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

