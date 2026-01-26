Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9C1D1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BD04406FF;
	Tue, 27 Jan 2026 00:24:38 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 0151740668
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:36 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso52629805e9.2
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469876;
 x=1770074676; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbB09mZXp/wSLL6nZ5LfIyzIrgTjgZ/yGSSveIVp2gE=;
 b=lucV2ojF03ZyiMPj03axA0jNLbcVnWixYBN0G4uTQTf8WyTiA1qkbxk1vjJTXj0qzD
 19+/UAgNzlDmfI6zeEYca+jF06s4g25SmxqhURfApzu5LZG6PFtY0qH2JYGEFRyZZ9CR
 NhLifDwF1gS0JU5iZhsbKP8SuLj0eTUTAwHVCnHisd7vqNY6/WvetwT7mDyJ0O0+Oo+n
 knpgX8t1ZgrksfEkZahm7Q8O9zm3ptwbhmUV8UkliT34enVracgTegxWJ3r4Uj6s9syN
 0XOI0khm6JYSzYU3V4cnqDceVKQl4eVxlLvAbaH8XdQequf7CNRbqA++oKgzAYfjZPV1
 p6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469876; x=1770074676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pbB09mZXp/wSLL6nZ5LfIyzIrgTjgZ/yGSSveIVp2gE=;
 b=pMuAIC5OJTIbtmPIIGTzKaTJHRPqYHWjZ/hbkt/EKpr8WIFwgZUsEOXa9G6zrjNHn+
 +ENei+z/yHxkg3Y8eWC0htwpckLYYgrv0YPLz0tu8q298x5rpAV5JViTNK9n7q/GHY4t
 0ZciG8QXFyt1b38EaatBEVhFkhFySG4DwXHJzKGZ4ogip83s2SD+I001Y0OW6xGM5AVF
 47gXxc+n+pBE2qfx5UW4RqwF8bCPixB1xFzV4wsF93QbWbL/CoWjJZCbk9siTrFVALie
 6XZz8vEZND6IYfGvClH1K4dQHVcdZaNsmlaEau+3TqguPEoMdS+hTHNKwkVfHT6mX5ra
 08Kg==
X-Gm-Message-State: AOJu0YwrfGQDh1ObuR+vaFz0b52SPq4GpBnSDWtL6Vz4Fyl2AqyikQXm
 edu++CYdH0A+Iotx1YQC/tbeURSj+C3xMbw0P3g434j4huigkaJw/xMF+IkkeuEV9T5A55Q/Ur2
 //JGe
X-Gm-Gg: AZuq6aKkMwCSJHjPLzchDz/RCM6dW90/4bJ5KU8fTuJEyIur7pnQoV6yaFGNCyZ6UTJ
 6agJ/0QN6EZH/KnEloMqEoSjP+4EZjLuoiPWJMaZDYaDIUkGB5if7kdjgrlsOSdY6LOjCjkFH5X
 WVzCI0rMuJBJssCWcF3DE7jHfZrtArgQP2sEzihXLZaFmeG5AzowbmGIA4q65VdEuwhuN7Axkai
 OsQ7jXO83E8yoSwvi/DFukn5Q7QouSsQiSbBN1tQg933alCmG6ER0WYaiIpyWIx9Yv7gi95vaZU
 CvjYSm0P/7fKcxLCH9dIpfdVL0mrvE+ZvZL8s6YCOIZC81p5eU8tNXPQzhes0a4k0jnLy/Kn3pg
 kKQrLd7mXSbTlZ5bJhJKyaRkbOtoaEHjwWL7LSpYYZDv/BEz7RVmOv5KDmenOVlu4lep/lHiMEN
 19jYeA3zv9lPdD3HB6J6xuMeP1LtR82hMWarUtjwHr6XU2kYtNWw==
X-Received: by 2002:a05:600c:3e1a:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-4805ce4e55dmr101827295e9.10.1769469876234; 
 Mon, 26 Jan 2026 15:24:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v12 01/17] lpm: restrict name size
Date: Mon, 26 Jan 2026 15:22:09 -0800
Message-ID: <20260126232428.276534-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

