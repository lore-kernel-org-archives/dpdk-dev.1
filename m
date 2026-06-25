Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C08CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAD6F4068A;
	Thu, 25 Jun 2026 18:02:08 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 59DB540616
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:02:06 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-139b5e604b9so55812c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782403325;
 x=1783008125; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yn3reYfUVeIplC+Ku4Q2vEujzSfj8clcfJnjEF7v6o=;
 b=Ivl7I0E4L+hCSBmj5Tp8hFQ6FsrjpmoBt/ceAdvmfibqrY2q2CW6PolUKJV7/WVIH4
 20wnrhX2XlKKXHBnupSQ/mSURTG3hQXObk/1hUGkYDUx93TTZGSGza8P7HcTXnrf+Vew
 m4lCMX7PZkoDk7nAGet2hMgFJuVuDDWokki/3F9IY3iOJWncc6jFSUh9kgOfNTSX/r7w
 eR1lsXFD5TEqXN/iTIxUuEBtw9bRQB5TsHR5STTQMv4/p/WNqKkc0P1G78d8zWmJ4UBj
 9lm5n53NqiMeY7y8Z7E6bDuOSgmtlc+Y0hXS61hf62WQOhvAM/dkiCUYKkaIUFIQfppT
 JQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403325; x=1783008125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4yn3reYfUVeIplC+Ku4Q2vEujzSfj8clcfJnjEF7v6o=;
 b=XM3MQ2qTCiyORCH/eRS1P2OZTQLa6LRF5lT8+3+PdV5OAGZqQITAdhI4VElZuBq7lC
 i06M/EWgBcp+poxaqMEMM8yTLK3Ipx98qXfsgOhSPDL4A0GnljBbC2BunoLQw69wMyYl
 lygudvXCqWzgg8y/eK4X7Ug3qAYeh6MkngvGsTLBr25YeMjXrbsrP8qVW0SbbGQxc6Lk
 /fHUQ+kuS2yUZ0BYkfONzseA5XscnL6NSvipH054dsdA7cITmYf5KdTvgN57KBZutgTb
 Rgf6cQ3R0C9GYPbA54LA2g8w+qzd6NqxjN6zhkPplHEVLLT4DDdADxojSL4+Pq7VUYxz
 ie3g==
X-Gm-Message-State: AOJu0YwCdTj7SUQxG1iseZRsblXCsTNI8A9UxhzMc0Vr/iY2JyYYxdYn
 AUMXVAukeVBRmhqiHitit4N6HDY96o4jWEP7/AUz8yIEB8SQ2VLPd0m7vE6lhFGtA7n/pEMmUGz
 fdN/p
X-Gm-Gg: AfdE7ckriO0x8YOblrJ4SIGVbl4diUSz8kyI2BIhRfWqth9bDu6C4BpW6u7P6hEG6s8
 gDaV4nFaKF5/24eHZy4CdqHDaU4xcAVhXTE5k7UqQktkzWMhp1nl31m1Qa0FokaoG0F0EEIlGpm
 uDD9dnmFtAnie+BdEQEV9PMerpsG2bM537QtEgmXgabD5xDNNrVYU27+VCDM49BO8XNB+5PamPM
 E9s00AHvUPMBEtTerSeEkyXLhXoZtHh+QqKDR8CZamaRYu16fxVHeyPvIZA9BYbjpYJnAJiZ22c
 nVjA9PeJORWarFnoBvxfuXcz237yywyalMK6gq4wq7Q5A7smWcesFIaab2nP0y1FjGnpHXWpEYH
 o2kM19PQTYISrNASYVzf/JqWQn9aJXUJ1f80ijFYGMecW0DHW9nVKUkuOjKKrWG+5Jot8kxv1tw
 rQ1qQihP/XC6kbG1Y3JS0USjDJQ+n6WEH8Aj8htaGK+MNwuuOvvFY=
X-Received: by 2002:a05:7022:69a0:b0:139:7375:c435 with SMTP id
 a92af1059eb24-139dbac30afmr2654635c88.20.1782403324950; 
 Thu, 25 Jun 2026 09:02:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e940asm9121569c88.9.2026.06.25.09.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:02:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/5] eal: take experimental flag off of rte_memeq_timingsafe
Date: Thu, 25 Jun 2026 08:56:34 -0700
Message-ID: <20260625160200.24170-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625160200.24170-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
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

This function is needed in other places, and don't want to
have to propagate allow_experimental_api into those drivers.
It is stable enough and inline so no ABI exposure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_07.rst | 4 ++++
 lib/eal/include/rte_memory.h           | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 0b1cac3e0d..a9ca81905c 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -218,6 +218,10 @@ API Changes
   - ``rte_pmd_mlx5_enable_steering``
   - ``rte_pmd_mlx5_disable_steering``
 
+* **eal: promoted timing-safe memory comparison from experimental to stable.**
+
+  The inline function ``rte_memeq_timingsafe()`` is no longer marked experimental.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
index b6e97ad695..940770f1eb 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -747,9 +747,6 @@ void
 rte_memzero_explicit(void *dst, size_t sz);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Timing-safe memory equality comparison.
  *
  * This function compares two memory regions in constant time,
@@ -770,7 +767,6 @@ rte_memzero_explicit(void *dst, size_t sz);
  * @return
  *   true if the memory regions are identical, false if they differ.
  */
-__rte_experimental
 static inline bool
 rte_memeq_timingsafe(const void *a, const void *b, size_t n)
 {
-- 
2.53.0

