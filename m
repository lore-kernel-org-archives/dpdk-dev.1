Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4F1D30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:24:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7594640691;
	Tue, 13 Jan 2026 21:23:47 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 3F12940691
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:46 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so11704218a12.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335826;
 x=1768940626; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=V6sbCsSbq6ik9qcwTwpLZzztiFf7xXWK4uGkWJBh4COhii2byuATbH9nqbFQJJFSv8
 KRI6bSeEtNVk+kV5BVWJFJUBicbdm+ZYuGnox5sS/9NILEFqbpFDMUkw21soVrBsnA91
 /WYSXCp2cFl6WQK1dLi1gKSou/jBKnyyiLqn7KgTQY2I++gE2B60942VKcrTLD2EzWg0
 h/gzq2/4w01qsJfDakVf7f//RVl6sYCTM/K+nOW/tExM+RCqN1qjiSnI7+rgKpy4o5oa
 bWqiZFr1ZICuu8ex28FJ5OH3zETUHnCal14dCLt3UgLeza4255UZBfOX2cmB7y0Yt73q
 42Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335826; x=1768940626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=SsjB+Lsk8Jjx1byhGvr5Gu3D3OlprZhYPEcQZAtj7my51eVWqrzFkdUh7p7Cu6G5qC
 GOA0Og6ZEbORTDw0EFimqVzMuwt1TzbNN/1ysmWGvoQaOzQZnQpM7MZ72PQwy6Cq9qSJ
 S4FzkB97ZYF9V5EtmDMlKtUJCRXptV/DWGKgnERTPqUf7HMrOQ7HEGTNtZXW7+SJ1dqb
 n/RVdA4uY6jeMZ22C1/ReAAlYtb1VHKcDCWA0AraLlJF4TbspRvmdGLV3pdq+rxuK7jT
 9v54MPY7ABfdlCcUnDoPb5fMt06vlTTJqqx1azc5xagusQXHYMM70yxKmm56Y3bE7qHz
 sIow==
X-Gm-Message-State: AOJu0YxJ613TIbZW2bR87uRjETOPZoFKWGz3YotVY99rd/8mH/uaeYlz
 g7ZGk+NdERp0d6sy54hPTYQG+Hh1rz8oX1X8AO3Cd9Y4Y2sNJMvPJpkUD5D6JJbQ8u9WWNjWMS6
 C50sn
X-Gm-Gg: AY/fxX6jLZdOJoDBHmK5diHJu9mIJdxht2hGWZqdkYIVyCh984jK/Z27pemZL4EKp1l
 5HF/ZOV/owZkVCKSPtCJCXNNoyRgehvFGkup73yF7tjT6qVs3TIIUcVl45NhN6LF+zFHz6cUFQS
 SbjAjU9eY+DtEXgOqihtego/hBp5SFDxfHBQgh/E+4pCbyoYziZooKQ/Lj/WmQQK4EWKFKf7RVq
 8J85W4kh0MoOxzSe+UCNZD27GEXb1emtCZb3kb+8ibSpk0Ry37jdSTPjqbWfwuemluiNoHfejj2
 u231Et/OhBZ9k2rUkyOmZoQHAxw6da18nGqRAp24WuVUjZgM2tBitf2/2cPlg4aK2lwBOn6uZuv
 btLdQ31aEGpQKArdNyg67P40dDtTaj/mYz4XB4LwENPTIlTRYxCFr+cPDaqRiRmm0/RWAm9BKcT
 GDP1EJYzknH3FQtIueLxTRHlkDD40CnRpkwKCMQ1vuLPj/s/nxNw==
X-Received: by 2002:a17:906:eecb:b0:b87:1669:de1a with SMTP id
 a640c23a62f3a-b876129fdbamr27553266b.64.1768335825775; 
 Tue, 13 Jan 2026 12:23:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v10 06/18] efd: handle possible name truncation
Date: Tue, 13 Jan 2026 12:21:45 -0800
Message-ID: <20260113202329.35190-7-stephen@networkplumber.org>
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

If the conversion of efd name to ring name gets truncated, then
log it. And if the ring name than causes collision, make sure
that log message includes error reason.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  2 +-
 lib/efd/rte_efd.c                      | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b966ce7b49..91b1808455 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -92,7 +92,7 @@ API Changes
 
   * lpm: name must be less than RTE_LPM_NAMESIZE.
   * hash: name parameter must be less than RTE_HASH_NAMESIZE.
-
+  * efd: name must be less than RTE_EFD_NAMESIZE.
 
 
 ABI Changes
diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index ebf1e0655f..bbd565f404 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -517,13 +517,20 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	efd_list = RTE_TAILQ_CAST(rte_efd_tailq.head, rte_efd_list);
 
 	if (online_cpu_socket_bitmask == 0) {
-		EFD_LOG(ERR, "At least one CPU socket must be enabled "
-				"in the bitmask");
+		EFD_LOG(ERR, "At least one CPU socket must be enabled in the bitmask");
+		rte_errno = EINVAL;
 		return NULL;
 	}
 
 	if (max_num_rules == 0) {
 		EFD_LOG(ERR, "Max num rules must be higher than 0");
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	if (strlen(name) >= RTE_EFD_NAMESIZE) {
+		EFD_LOG(ERR, "Name is too long");
+		rte_errno = ENAMETOOLONG;
 		return NULL;
 	}
 
@@ -698,12 +705,15 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	TAILQ_INSERT_TAIL(efd_list, te, next);
 	rte_mcfg_tailq_write_unlock();
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name);
+	if (snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name)
+	    >= (int)sizeof(ring_name))
+		EFD_LOG(NOTICE, "EFD ring name truncated to '%s'", ring_name);
+
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
 			offline_cpu_socket, 0);
 	if (r == NULL) {
-		EFD_LOG(ERR, "memory allocation failed");
+		EFD_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		rte_efd_free(table);
 		return NULL;
 	}
-- 
2.51.0

