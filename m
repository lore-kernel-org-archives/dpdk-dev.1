Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324FDD3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:44:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94D6F402E1;
	Sat,  6 Dec 2025 19:44:20 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 60948402D4
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:19 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42e2b78d45bso1486964f8f.0
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046659;
 x=1765651459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ar0TVTeIIJ1vt0p5BtykpERdH/+0wBESU7HhKIt4mU=;
 b=XBC0rwLWEp9rkRY77vTzM5E5AykftaIz1M8l7A8cyZYo4wQ8AsfPbxI+jXutg2ZE0r
 eQzPIzr9ZKL/ADaJh/uZhV0/wWXjkQsKxq2lwEuijKO69Qi5SpRsXvaTzUf4WsU5S5BQ
 EjbMRiQ7j55LHZaHO7qY2AYop/Uj1Z/3h/HV4Oy1pxQGPQOuXtjMQK9+QW/XjaHMi9De
 FUieaI7bwQpFNuTtg2F/nVa2UlTJRFPUHsYhLSdRu7rBmFgrGzlAREbzlg+qWUvjC6+E
 XJkofsQpS44D41mycjQ59RIbKbMTRQzGpbf7hIAc5ahZs7iqCEBrFUV2aF5Uw7saQtCI
 lRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046659; x=1765651459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ar0TVTeIIJ1vt0p5BtykpERdH/+0wBESU7HhKIt4mU=;
 b=oCB1tBDYTvm+P/9ICO05wWzPpJQd/JO4q5cvlt2gaz9Y4SsTUzdh0QM0rQ5AX4VYfH
 3Wd29u4degJKy8PVI4LNPj9vA3T43QNAL/DWimWz+II6iYU9zgCuB4N2I6/Ocdjz/hJE
 AxhfTU2vu+9IN/qIegUR5Myr0kmESsbqkNYVWMir1XsOdm1PhITLqSiRs9QGL8KRfuob
 XNXm7bkIf7XUV6s0OjFB1vowleo5F+LT4t13Hp8ySZJrUNFXZG+2mcVxO984r2/Ju1Oe
 kUkQjchJHkb2ojAtxCLIYVDudrlvjJVrtiNDzrIUFNo3O2hQk/vES7EUnQPqlISghdnL
 iX6w==
X-Gm-Message-State: AOJu0YyRM2ZHHgJYIypFQ3Nk3TUol/kkFwF4GmwHSnDYew/DAgZRd9V9
 dvQFduHfdYBKie7Mj0Su/tBlrOuwV8yB1YeFtWTMaUCDhfa7NG82voUN7dnPo77qk3Y3ovqdtc9
 EhnfF
X-Gm-Gg: ASbGnctTFZMvYs6wB44C1iTyDLuBbFQosIxgORdXqMArSiRiyyp888RaXrfYmA/RE+w
 xyuJYgijVwctNj7ctXmb2sN9Qwr+AamfpacQlBXWkQXnUZb0IDLQAmRGCEQB0aisd/bBwKLHlCZ
 XH/nOgkojcqsmSve9sunA2yr/5enK2uWLpvkaGEkOd3UbwgUSqPwfkz2l6qq1+4xDDoAfUswGc4
 +ANiscVfnTJIICeBOkROIMPjGQD561iOnhYkE4kXpKKf73pmvDqjTMFsClkdG4hy1Rp+tH13Bv1
 fnGzH4s+VqaUQ06q51lDh8b4pv6V9CZYg5pwZ5m0AcWX5qPXa7Z89HPtw9fYg67GIzHkY9X3lFB
 loK+Ea0dnaoOgO7BJfGI4VCj2oBpkBoi0ee7q81CqxbfWaJhuIwxaD3wlvw56LrULf7clYcewrn
 0Kwlu7o5B1zkOQlJyVsu1Hkbfs41sB5hesv4/zbSrYuZASKt/SZgtioseBAUyW
X-Google-Smtp-Source: AGHT+IHf5PozjDWZjP/OhQxzjbOcS/7oX6T0+meEN5JoY0aax+hYo3uTyk8q42I2yNPb7lG+Y/xPiA==
X-Received: by 2002:a05:6000:60f:b0:42f:8816:c018 with SMTP id
 ffacd0b85a97d-42f89f6708amr3433429f8f.60.1765046658949; 
 Sat, 06 Dec 2025 10:44:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 02/16] lpm: restrict name size
Date: Sat,  6 Dec 2025 10:43:03 -0800
Message-ID: <20251206184410.542725-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

