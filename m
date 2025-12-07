Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1727D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:13:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0327D402ED;
	Sun,  7 Dec 2025 20:12:54 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 13643402D3
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:12:51 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-477632d9326so25923465e9.1
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134771;
 x=1765739571; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ar0TVTeIIJ1vt0p5BtykpERdH/+0wBESU7HhKIt4mU=;
 b=UtfNoAFWESUL1KZJyBavDPr4MN33JrsMSMBG4JkEQTzqU8uGKZlb7Y95W8+OFgwEqM
 LTLBT/254ibWe5KvpQv55548JcFkKMTqI/VszwbgJej4Siyjf/nLcud5koJjPqUhf0Ey
 9eJafc+aRT6rl0eLJXBaw8uJP920WA3eZDIPhBktMT6BbzTY6cs1FccygU0DaNUJRrYn
 RObDmY3EK5CHzwPsNJlfoDLrBxZ9K3ShqitM6lONQvHi87Lvkrin7/6dUkX/KbhkLPQ7
 IkzGvrgDOH7eHu0ev2nyW3qlVjDzD+w15RogDfs4RBSobF46fJgERgF25U2rX0E0GgLX
 W0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134771; x=1765739571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ar0TVTeIIJ1vt0p5BtykpERdH/+0wBESU7HhKIt4mU=;
 b=GYrCfGCVAPRBsoN6snYI5R42Xlp7+WGE9vQabT8v+zAbXt0OF4ryAYjWlKM2xWhZLW
 P3GOvAmpbVkZt27eO8VI86XXQBxJLvq1dYZiMRxMIqskcee7vTbkV8XjUxa0y2iJYrgT
 +ZXcCJCS6qK92TJZm+FRzHY0I+miAMlx9wfSVCZpzGGJtBEf2BXkh3AroCdCqtGsctRP
 vEMJIWkWbyHgjZzOjXsoj+7ocIEL19NfNIGArAtvpzequ/2GwUgjqyCfK4aHqnYayszG
 /LTnBl0/gSAxwt2IV0qDphuEGhYXNpTAf33k4EKIVIrVU2VX7nI4cJu4Wm7QPkMzOAYf
 bjFA==
X-Gm-Message-State: AOJu0Yw5a9xsDq259LP4WsmVgbFOGHKc9V8+cxAYI4AHHBxZMNfqY1jG
 phZ4606kHe4KvdbFMh49KcHLBd8uPBJMyrl4pyRueRXyYBYGY4zq6DRS2L7Hqqjp6fDhsHemQuN
 PE/KI
X-Gm-Gg: ASbGncuRrqMf/hcYpNFXZll/PzWrJLsPnZcyjxvS/AimKfUFbf9V3KfthP/ZWTtgzw5
 Rz5UWkVejTG5cw71XoCLleEq8kF2IXhTxvShBwTwD72J/ZF0grMF21GqJ2GBAKD1Ri7uGBqvhh4
 nnlUa/Fv7EV+j2rmyB9KXKHJv24XwhLiuy9FBOrkbMq+ogFkG2p6tieAtxJBwdBz3U4lZ6i2kPL
 RBc2A62bkPWAGwFranRocUjBRqq3zc0a6BSAfOVl4bcz6hvcUbJnaPk2zPVeuLNZKxzm0J+vYwb
 jt4MbAXh/HcBYrTPQBDUICaCCjyV7o6J/QZgDT2BNZvwv9KUHt9iK8uMTXeYPshOmtcwV1Kfv9e
 2fdrhgrDF4UntrroDG0DmkEANyI7BUfrGYqtZp4ZvNamwdL2bP/S+T67i7vgcbzPuk54eFwtWGd
 X76fL4HSd8KpUdPpcGN3RiCcozkAnilPrRWEFWDQx/56GQVDzIBA==
X-Google-Smtp-Source: AGHT+IGiP64MFiDqb4XFylpVMVCcDJq+6TiL7LutLYYDj0K4XYOCfU++QJsd8VbprQsHbKvxnC7Z2g==
X-Received: by 2002:a05:600c:3f12:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-47939e23802mr61610275e9.22.1765134771470; 
 Sun, 07 Dec 2025 11:12:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:12:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 02/17] lpm: restrict name size
Date: Sun,  7 Dec 2025 11:11:53 -0800
Message-ID: <20251207191242.165619-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

