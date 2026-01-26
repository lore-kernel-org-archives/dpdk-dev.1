Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A692D1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 156E240A84;
	Tue, 27 Jan 2026 00:24:49 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 6B9A840B90
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:47 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so37178405e9.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469887;
 x=1770074687; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=AL/KQhcoF2B7YkWTGqry2oq52xW2DyXz706eFEY7aEGZ69QElh3C0MMFxYOdBn4IY/
 eq7cKcByQY8M9N7HEp4tx2YWsf6RT1taLJH9N2L9eE4Rc3sBof7d6jvKY68jRIxuJtNK
 RdQZiUHZ4HX5ThVX15kANkafnk0mWhwQFl/Upgk2GyKwm+26BJuoabTtnUiE2cRk224P
 h1UU+AqTcSndRFv0w/rJ5+4NmerZgLOEI2PDUV3miI37guMLoTF083Oe6W8y2B16QAdn
 leHK/MRFtIfAW/ccSiD/59RDVGSxhtD5MfBtlYLCIoIKnYkxh0xv3PS6ceyloOmkr6tt
 ailg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469887; x=1770074687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=EqXpYWoiVuPwvqhluBfQYdw64m6oyu8p52D7pqvyk1Hp9u2wubCxTS4d1qU61A0fqE
 KYbCEgdtiSeNErT++mfDpja1G/Qxu8T5dYRtwPcl7I3ypKTSStymYMwNWIyVumXdXluq
 KN7gvoOLzN/AvdZkfAEWm2sRBcDZKjv6WzHihxqAf8eSa/cDnCEddW1PDMWhkipX5VMe
 tR2N1/mCpcQam+AqVBLsIAvz4F73kX7HDPf6SZMrS0RC1Ozh33wbzthWZImRUwpAtigC
 kl/QnT+ig1sY7l2Fn0HYde/QV0pLPW5gYHp/OD5PXnhb08x3swWHUpaSNdwA2I3kMTZQ
 cKFw==
X-Gm-Message-State: AOJu0YzUCoyX+7iJYV2rre9t56LtNKH6IY2c1cgiTVupFbiQoORsGc7k
 ezRFzcgtrrtaXyw/e437Gj96/P2GHwNe4zt51iDM6a6i7uQQ5QBzXmTuRuowQUrpEC0iU7FAvWs
 UIBq0
X-Gm-Gg: AZuq6aLmAZ1dmicbKGjjGpwCn08QCDmr7f+ABRy1yAUGi4YGD1tXqhS+6RiRQnpCVqs
 raoa8P8v12q4WHNRj5UylB/k5EPpT96LKj5Skyg3T9DfUpPSUlrbKyKLsCs83o09KXffbtWu7XP
 elF5m0h9Fxar2DUycE7j9fIYoNOTOHfW4ZExCinBp8w4AvAjwyp02Ra/wVHAhmi4lfFuAcf4vkf
 ZRgGfkWafYv4vJ2OMvs3B41V0e//w4BoPAbrZuiYlYsJOf7WfyXzMZyaJY1jrEogXGg06Lb0brE
 HCmSUrgfy2/CbfBF4ryah1J4uACGPLL0tPri7f68YodauWm5oJ7vqYE1ny1YdiNil2M5yAAJpII
 fvOk9HPwXa5CIFBvsVU0yq1d3bYEQQU5oMFyrT40g/FsYfQgvczGhkdq1Q8LFGBKQKXTNgIbLBT
 yaFXhGpjy0gi2WQYeisLzzuEFkjIuJvGcHb0HuiyeRSDZLDoIq1A==
X-Received: by 2002:a05:600c:4e0d:b0:47e:e71a:e13a with SMTP id
 5b1f17b1804b1-4805d066730mr83542905e9.32.1769469887029; 
 Mon, 26 Jan 2026 15:24:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v12 06/17] efd: handle possible name truncation
Date: Mon, 26 Jan 2026 15:22:14 -0800
Message-ID: <20260126232428.276534-7-stephen@networkplumber.org>
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

