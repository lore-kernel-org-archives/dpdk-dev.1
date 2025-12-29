Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4028E92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 353F1402C6;
	Mon, 29 Dec 2025 21:48:28 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id D5736402B6
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:26 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so5734943f8f.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041306;
 x=1767646106; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbB09mZXp/wSLL6nZ5LfIyzIrgTjgZ/yGSSveIVp2gE=;
 b=sDjOpyHAT+jdkJ5EwcXznk4+1AhxVsn8bSTWiTK8WY6QnNoylNfFxZMI6qv7Vg0eSg
 tfrJydNRfeEI+Z1c5EQs0hjA4T4gs6/zVxXuULse3SuZQWehe3DN9xIBrbaQy6px70uC
 hRsAB1VdgMw4c6PTvPmfngw55yRUuCZY7PvXcjUmFAMTOypVNFlJqrLsP/zGi5M1+vCU
 hKfT1APqvq03QxI8s/LhM1xonEHX8jSQgENz4nnzvf/oCO36Q9f6PTtnaAzdFSB5AS4R
 i9Z9hL90eBG+3UzVWrvCQczow+devedHXInt3ihJQ6NBnkCU1VNWPlA/WJiipLTPX+UY
 vWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041306; x=1767646106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pbB09mZXp/wSLL6nZ5LfIyzIrgTjgZ/yGSSveIVp2gE=;
 b=cBkNmPdhL5SmnhE5RzQdjS6F2K1yMe2jGcDFsa0/0xMMHTC6MDa3IL14FxSNjCCMFQ
 fTp2oYns2UAq8tfvxtFtqeHHQYDuRo3PkIN34r8SzccQjTCieUWXjubSvliUecgK9xY2
 f5/ahBAstF4BW5M7a6swP25w+6El54wSigIwn6U3nmElrpe1HNUY0jbMNHP8VH2U9R8p
 xXzXgZ5netc8BBI0S/FHZOuaYk1ZxlA2PQVJ9z2wQPwcO2Fpkbb4zcX5f5iYcYdpS3+Q
 uVuL3hPCv/ZripK7+3rJ27atzpaqnCRbee3oVttjrCr22FBjJ0Drjhyh8zHra7VdqxOg
 FPkg==
X-Gm-Message-State: AOJu0Ywvgp3rEsdKuz7ETirrhZztgVncNiZJFK4tQapkejQqM86Uz2tx
 qez+4oEX9B2WuOlizesKBu+V+X9NGSXeLF9V6ih4lzs567R1i3dAKyxF0acq1VamOCb108XHAiV
 D+bBI0Ew=
X-Gm-Gg: AY/fxX6xYoyYKv3o5ozwNe5m/LCS+zPKm2/eIg7XsNJbt8SBhODBwwuFCrm4WzVRqKG
 72jxw7zH6DXwcz2ID+jnhoGGxJItvpDOQj9NSFgfIA+ijxspD5eR/ERw2m3rM2nXR/lbSCKELlH
 s6PggtCRX/Qx8ST9bDRYJea6WUzSnGsZ4Hp2RM10giYiVry4vaFr1gWa3PN0rDws4Kq7xS3Hjxf
 sNCFadBaSTCrO6q0WNhEgJedEMKTT2SVclBeK+ymlzXFGIkIIW7dYe+Wowg3SvDnRiaP7B5PtDN
 uqP3YTqH58ce69i0/FsEIefPyhSMV02T+Y6FtKH39L7Nl9IOehBH/EYpcder5riYxsinGYsf2qn
 rZ1ajIAejkBXhSRxRLoSX2HjKji17OZg+P7t5tPCihn5J0NIC7X/hovf9IbIu7luIKjTAk1zeif
 gw0YldDUdDdKaImEpHvXbIag9Nxut9ZKC5xBcfdenJpF26FxroVQ==
X-Google-Smtp-Source: AGHT+IGeOs7dgdiOPofF0YUpBD4eYLzGmDxJPH77PpQN7yevPor+rJtA0dJraJUt8ipG5B4nIjniyQ==
X-Received: by 2002:a05:6000:25c6:b0:430:fced:902 with SMTP id
 ffacd0b85a97d-4324e4cd03amr40467507f8f.26.1767041306337; 
 Mon, 29 Dec 2025 12:48:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v9 01/18] lpm: restrict name size
Date: Mon, 29 Dec 2025 11:37:59 -0800
Message-ID: <20251229204818.61231-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

