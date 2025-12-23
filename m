Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BD7E6FE24
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56D4C40431;
	Tue, 23 Dec 2025 19:14:27 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id 75C2F402BE
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:25 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b7697e8b01aso998849866b.2
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513665;
 x=1767118465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ar0TVTeIIJ1vt0p5BtykpERdH/+0wBESU7HhKIt4mU=;
 b=lWRUtqJbNOdkoZPaxP6ZDfLthCPnjnjzUTIo+DQKNqa6wsKltARELYRNYiO3gKtS80
 L65TXuw4lUe3RzAebJ9G/UOa3UjsjOabNnmtItas262iUeP0sSjKVskG2zUjgDg4EFCl
 inEoKyGpAARLlm9Rb7t9mGXPMxjve4AXwXp7WJL3eU8R07nYZfKJ99JqlDcrrO1EaYNm
 50hdK9d0J5hp3fRlv+tK5vpr3FKvmC6hXHqSrKdES9XF0PCsfX7jS0ad5RAu+KESj7Ex
 ZoTHXl4kWZOB0bIom4EfqieEhrejgQYsLFDCRujAoJODoKX9Wu9BRGt4CB5eA7JK4Al9
 xn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513665; x=1767118465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ar0TVTeIIJ1vt0p5BtykpERdH/+0wBESU7HhKIt4mU=;
 b=Mr52XFzBAi4q5AQagGPL+zvl3Z8X9+HuXgqhlMDgxa0946rilq6/50j8IaFYATB0e5
 hc5Q1v6ZphpcQTUTKYbdMk+w6WFU/iNU7e23XTR6TM7CnuPZ5UVgFjvcdm0sh95KXgLQ
 BpjcmciFTth1FCVh1GJgsqcMMzXDz0iO5354IjBKM0K7vBfmyArfgjlRTba3I5BJYoNp
 9eyUpsOXCRfCzOb6WARgKCRejsezouhCj2toIXxT3K++bTnRLiOGZm2Ik3DI7YSrcN+u
 NpdtGNxFxdMFZmU178g9pcHqRN+8TO/Edt6jVGYWanbFDzobG+LkSbFPvNlVDGG2zOPr
 jpdA==
X-Gm-Message-State: AOJu0YzBacX7OOzlMMAosAylmWOjaFyNNlpsnSKxFaeEmAoLsn9HK7h0
 7GHJjt+ngXXQ4yh8A5rPU3r3hYsTaJmDA4sPmgINnZbBg+coA0WMpwH6CLQO8VySGAGJjSbPEJN
 tScfAb6E=
X-Gm-Gg: AY/fxX7cKnTKtOm+x/zfsGBPJrG2ieInXm6RjNpf7w2ra7GkV2d1OqyCmomYvgbF2AO
 jCqERIBnUL0FNeEsMpiKIdw8/YN9OY9H4doEx7tGniW2YZpXftSyloaIvFJA3BJmJ63Fy3eRID7
 0VJZqexyhmVGzWUzlYvu9m7tM1z00THBHgXUucU0Txl1Eqe1p+OJd5eLbIuRaXL+JFVTqGnS0Xy
 UizBe/UpqDZWqjq0wPw2oYX5TlTZ6XxJ7PZqgEBsQ6wAvGBPq9/atfymykqlaUS6z5M39wtSpqF
 OG9oVjttD46gys2q4rCRpheQTTyxZEDNUotFNC+60EySvKsTdtAhgvRfngLZ66okIyCf9atIEQl
 xmKL6959yurL/EP50F1xdFoBGZZV2Mz0zk87d18VWNk40eGGSM40VrF0jx3hCjRMM9WmcYLrfnC
 Zx9kHI8FNyTnKuSMFJAgJ/sCWNiM51W6somVxb0I2yS4hlYZfB1g==
X-Google-Smtp-Source: AGHT+IGUGcu6GwNuxriGhDzifsJGtBI/o5ZDVllQeViUfZaLvBqnJszueZCyZaZWpTrgGCz0MMnrIg==
X-Received: by 2002:a17:907:3e8c:b0:b72:5d08:486c with SMTP id
 a640c23a62f3a-b8036f5a0cdmr1773486766b.27.1766513664886; 
 Tue, 23 Dec 2025 10:14:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 01/18] lpm: restrict name size
Date: Tue, 23 Dec 2025 10:12:59 -0800
Message-ID: <20251223181418.40834-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

Since LPM uses ring internally with a prefix, limit the
maximum allowed LPM name.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/lpm/rte_lpm.c | 25 +++++++++++++++++++------
 lib/lpm/rte_lpm.h |  2 +-
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 6dab86a05e..2666d4f208 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -5,6 +5,7 @@
 
 #include <string.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <stdio.h>
 #include <sys/queue.h>
@@ -152,7 +153,6 @@ struct rte_lpm *
 rte_lpm_create(const char *name, int socket_id,
 		const struct rte_lpm_config *config)
 {
-	char mem_name[RTE_LPM_NAMESIZE];
 	struct __rte_lpm *i_lpm;
 	struct rte_lpm *lpm = NULL;
 	struct rte_tailq_entry *te;
@@ -170,7 +170,15 @@ rte_lpm_create(const char *name, int socket_id,
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "LPM_%s", name);
+	if (strlen(name) >= RTE_LPM_NAMESIZE) {
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	/* This is only used for tracing, ok to be NULL */
+	char *mem_name = NULL;
+	int unused __rte_unused;
+	unused = asprintf(&mem_name, "LPM_%s", name);
 
 	rte_mcfg_tailq_write_lock();
 
@@ -247,6 +255,7 @@ rte_lpm_create(const char *name, int socket_id,
 
 exit:
 	rte_mcfg_tailq_write_unlock();
+	free(mem_name);
 
 	return lpm;
 }
@@ -309,7 +318,6 @@ int
 rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 {
 	struct rte_rcu_qsbr_dq_parameters params = {0};
-	char rcu_dq_name[RTE_RCU_QSBR_DQ_NAMESIZE];
 	struct __rte_lpm *i_lpm;
 
 	if (lpm == NULL || cfg == NULL) {
@@ -326,9 +334,13 @@ rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 	if (cfg->mode == RTE_LPM_QSBR_MODE_SYNC) {
 		/* No other things to do. */
 	} else if (cfg->mode == RTE_LPM_QSBR_MODE_DQ) {
+		char rcu_dq_name[RTE_RCU_QSBR_DQ_NAMESIZE];
+
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
@@ -343,7 +355,8 @@ rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
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
index edfe77b458..8e70603ace 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -26,7 +26,7 @@ extern "C" {
 #endif
 
 /** Max number of characters in LPM name. */
-#define RTE_LPM_NAMESIZE                32
+#define RTE_LPM_NAMESIZE  RTE_RING_NAMESIZE
 
 /** Maximum depth value possible for IPv4 LPM. */
 #define RTE_LPM_MAX_DEPTH               32
-- 
2.51.0

