Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4363D340A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D699640ED8;
	Tue, 27 Jan 2026 17:33:18 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 5D1AC40EE6
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:17 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so4371133f8f.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531597;
 x=1770136397; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=blarGyoYEU6BHxiEtUZs7CFFz5uRSuPiX/y2FmgKWtbRwXqXSabcnn5NRpICY60NwY
 EZoIR8wm2aPoefqKQgIwjgPr9NGQCHkD1jV0jLQYwdfBOWj2qf3xKtY9aNaOzp0js6if
 sD5r8kkpnezGS716/cs4QVWFqI9F2rYn1ono9r722axUTPk2hQo4f7qS8H4xNwPJj001
 r4djuW+i0TBSMd/Vf/HDGw60IilySXyWC4vwD71NTR2qGSJPUqk3XZ95TXmMjb/j+ddH
 MWEUf8FzNcitRAzhJ7YbYB3dh8kqmIH1nIDY3TXZ6Me8QzA5sh+dBu3XXFifQN5LzG8P
 Tw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531597; x=1770136397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lt5Fp6oZtCkd3/VDFaFeJGUYOfSjKqfPvtMGuKoEJXs=;
 b=mMIJoZe7gk+G2HjdaQXO5v+M51AW8pxOsXlVJ0yxRXUJRm2ghNjwRmLSeBhedRh8QR
 ZWDhpEk61fa8lPwvhnWa/gPhQhdkDcSfBZXHxPTZRBH1L+cAlBrs1X90bzJ46zYkuKAr
 T53cgmXP4a1Y/Rx4BNn+YoH7kxhEVJd1QSc9NUdDZmQaPxsNcAyjB/nxy62UbDKfcZnM
 Kf7WCi/K8NTYwEawDWADb9aiXNilu7SWeD+3BGapN2gFln3KU/Rx9ggJ1O+HTQ+mGzQn
 qH3fVMzGn0oEqxmWrvbV88wVFhzjV2oWjCJIeB610NMmnc54Mz2KFnkWx/rxsEiaXePR
 /PMA==
X-Gm-Message-State: AOJu0Ywnaq79cqN8J2DMDEur/T9+9Xa4RcAurfeOhtYYgiLmEwLasdqS
 hgpUruRpJBHs9wYm2xIs8byj1MfJMwE+I7APuLFo+LjB8APQwPQgRGbNFaVz9qzrMgnqo4aLTvq
 tdBDM
X-Gm-Gg: AZuq6aL3CUhHj9G8VQW+FyXpUgZKFyZqI+v+4CLlHQoxTIIMvooGHagMXfRRZ9NcTFk
 KsY//nJc91hPgvwKF17PkwL/KY/x9XiND9jJOIevmSMl26XeAO5Y6ykQ9xeJSpyXtccADrH0Pgt
 41qa7/sH348DZodPKDEiCagUWHsc9DSpxAE6YJ3IXI8xyox2kjCszUYuBQWuDQMS/Ac0rgDVzeA
 0GyCq/HLLSQ3oZwbSycclgs9QrfqtCuEL6K32rAmb/q+cubhXhlqozzqo6GsYkVFxd6uL+FgxHz
 D0O/OJ5118pnqQRiEhmPv6170923WKVM69qtJwVtiVHDWsxcwUUaeDfRNfikyJQc5IqhLHqj23D
 XIPtRG4IqAYGFwQKjLnJ3eFPjUEoEfdUYDHzKG5RxdvpCr0cZsssPKb8quIafD69MTy3tQXJPF3
 u4Etys2PCkYJPxPRfXhEM9Rh5JpAd2vbOl4dMdpjRuLJs9YEEm7KEy43VOw1dc
X-Received: by 2002:a05:6000:2582:b0:435:dbb8:c5a6 with SMTP id
 ffacd0b85a97d-435dd05be14mr3834194f8f.12.1769531596890; 
 Tue, 27 Jan 2026 08:33:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v13 06/17] efd: handle possible name truncation
Date: Tue, 27 Jan 2026 08:30:20 -0800
Message-ID: <20260127163258.75566-7-stephen@networkplumber.org>
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

