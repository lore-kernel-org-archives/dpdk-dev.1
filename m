Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37293D340A2
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B2AF40E4B;
	Tue, 27 Jan 2026 17:33:07 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 5305640E4A
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:06 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so3547721f8f.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531586;
 x=1770136386; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Kiq20yK+3+wPNOar68UfvSv12nFZx1wqgsdQ6Qbn0U=;
 b=ZedYb6sH5HdfXOYgAEMq4fP/PE5XW0H6Sn/vT/NSON8iWbK7dAKzXD/ZzIQM9swH2s
 +3RFlJmd/29i7bsyYyobJQF7Cp/Ur+Ukgv0QmI94BYH6tNToV/puK7Te8Fmqnv4B9sRS
 b7XKnDf7pAqx/kSVxQA0GM0eayHttredyyycdIr4wZUaYh5ZvGGz8H9cPiYcpaipUOHj
 uLJdy2rRhSKEOtrWYbyXY8ZiCGXcRHy5gQSF3C7v/DuRMfPPXqtXueEFC/WFy2+0SKCe
 cJZ5tlF5MQnGZXt4YqXqmVktJXAsCxWiCCnBKC9fbK8w9K/giejMFYc1+xzOWS9RLSqG
 khMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531586; x=1770136386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Kiq20yK+3+wPNOar68UfvSv12nFZx1wqgsdQ6Qbn0U=;
 b=ttlNQTeiMhgqhMqo+s6DqHcNVRVrmz0EtgSXqC3L200KFMuLACHDKsqel0csV3CMVk
 JJWjUkicyy8/YQTFXKAKJDyIlE+P4brw1UaKG9C8OK2Nc60XqWTZK7ODSw3nSW67wkqj
 6Hvkw8BZebe+50bRRcczqn41iB0+w+RUluH7YKdIeYY4LS7+OzwJeRwbdl9tgJLJ4DbT
 tQdmM9w0pAWnuDMD9UAFFwTZ/YCBb7So4MIhEuuiyDa5TgyGe6hDFIcHTRw3wO5ThVMi
 F0lfBvtQ38M2SXIJUX47SPTHXM977Y7FYdZqxRL12Nnrh9Tcue9l5f3sh5gVYS7hRqV8
 tPbg==
X-Gm-Message-State: AOJu0Yypso/iD6pXG0ZVASG+EBTVJ0j3TvskhIqjU8dw1tNYEt6avhHN
 9eC+/FBzaqp+nL3OPtSGBsdPKLOZCvpVw11zPxXuY2hnRMel6lXW0buCV6b9I7/Q5e7iC99hFu8
 d6rUJ
X-Gm-Gg: AZuq6aIGX6uNcoaAQ5aaIN7Vf9YVHuJ/m7RHnLZD/2JoyI7jnsfT14v2Cm4t3ycq8fj
 TAV0TngZxIUA9URLH9m/kqgKUlas68KDHK12moXMJtA9l7MGdoKEHVERFm2XBCRUiiSkve0eAhd
 AOp1k+HYbejTzsT3fHK0ZrE8AwkCUq0SwnjLb3Ze+KA03ee4uDFQRNb1FbWEK+9KW2GSOmPQYq8
 WWBPIh82fNi84zTcw6W14/4+bv4jWrQTqbvOUP/XXK3bJiOS5dSrO+oAG/DPP+YwCzp1ZD4fO9W
 l4xWkr4AhneZ3jbQ3gpFhjJgwl9i4R82bpULs66rA7LEtXQDrdInTWaalO2YvXrlrxo5FhRIs7z
 GlFM8Id/v+Emlg6+4cy5yx0MkN0kyYTxnpEbCvn4FkLWr1noTS3LBW2hyBzLDJV2XUV6PSCSd9g
 ZYfNg0ma4pl+3xK9vDrrK3wtb9UAir68oBG7KRDStVqCFrltEeBA==
X-Received: by 2002:a05:6000:2084:b0:435:8d02:b9cd with SMTP id
 ffacd0b85a97d-435dd05f1c5mr3790012f8f.26.1769531585733; 
 Tue, 27 Jan 2026 08:33:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v13 01/17] lpm: reject names that exceed maximum length
Date: Tue, 27 Jan 2026 08:30:15 -0800
Message-ID: <20260127163258.75566-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

