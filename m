Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32521CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:16:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE0D640672;
	Thu, 28 Aug 2025 01:15:45 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 30EBE4066A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:44 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45b618b7d33so2840155e9.1
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336544;
 x=1756941344; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mz+aILgSL3WMcN4fUenQPC9RLpjD762BMn0rJHkBSDo=;
 b=SlqYpyCPpCZFYlMGK6hZdXBxcV/S7Gqexnmk287K4C/ZlfPNk0BNwt2ocKgyIiIEe3
 I+fZs3IzG4dW2Nk1qTeLpN1xOuzCwpO/4xmRpcZdr5q/aE4u8pV74z2d9Y51iMUGVO86
 IUPk2yuJ7j8uPRGoRmgi2UDLu208+/acuI8fpqvpqcuyXtE+29fGeXz1g7QA48M4Hdxa
 DmvROQo+ffAvY5vvuH8rmHP2CODvQSqvYUENRjwqDAsaWqKnjXRIawMh0CDSf74DjiQS
 PXFe/itZceLuzkYXs5dxEVuThZI+I0j2D28Eq7klMfkzqASEpda1VbQQh8KLCKAsSkeD
 mFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336544; x=1756941344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mz+aILgSL3WMcN4fUenQPC9RLpjD762BMn0rJHkBSDo=;
 b=JdrLZnokAyCIwWwFyBrko4663TVrLOWy3GeVEgYHRJVgZkHvuBdZKKlbpSfDwYeIwX
 hmou00atYLjL1ufkhAZuZHvs7llk8rjipYmfyyCHdaNO19dqFSHgzSw28hv4qY8q9Awe
 T+DVNf0PtAeNfyEgBu2VqQswnYEfcdRuXFDvtBNvu8Uujt+ZVWcWZzVagJ6RXfhXmmXE
 tiLIHaoxO9pFoAC1gW+CETIME4xur6/jJcIVMWhX2hV85/LPcfEDBkGfNpJqNbnV7aG1
 SGXuFsx7nDKUO4m8DFw+7G5MKjZsi+5C6qnXJqZktCTEAMgW15NmJNecg7K27kpxdO9z
 d1bg==
X-Gm-Message-State: AOJu0YwHvGAdjb9FEQ+CQaziksRi/yqTjPCnGlPe70IMuR0kmgiwk3Dg
 g89Q+BgFICjJGcE6eE7YrXx1w53bUOYYYD1PC7t9XVBkPycYbGB6adQceocib2nQ3TiOGHovlLZ
 904ES
X-Gm-Gg: ASbGnctXvaLIWArFD0Faq2HYh0iINKPlmOAa2c5nSck50CCHH9up6lTqc68cskaDkp1
 J8eNR7xS004/g8W86OlrN2yrwno++gpXHs2bCkl/r4++nMXPd7UhDJE+eTirPQWLze99M086yja
 jL+kPlz1LIhtX7UTofoYnj4VzcwkC03TG4iHBmDnRq2flwfEl66WMROwP/H6I899YZ7w3+aiJhV
 tG1p/Nz9nAIbuqtIQXuCpGDwsr+UAxF8bwcQab23j1+Q+zx1q9FWIi69x40Fj3BDpzGRk4o7ywz
 jZZWCsUmkVy1VfanTXY3ENtynVgVcCKBjxhNCF1GdQDVKefsCvfgIA+jWlJJreQW58kXDpcar6g
 yLOgsFYDd0cDgxmCvXNIdTS/sSY0D7f4rlHvb5lvnl84yHO+6WxbhEcA9yVV+rVChvqqNQnqM
X-Google-Smtp-Source: AGHT+IHq5IP+UnQh4ENKaEB/0/uFFpntxRm3ZXdIA46PmjXBi3cneulUkA1ENgGk1IW3C3LnkgGcOg==
X-Received: by 2002:a05:6000:1788:b0:3b7:901c:92ee with SMTP id
 ffacd0b85a97d-3c5dd7b43cfmr19081450f8f.58.1756336543752; 
 Wed, 27 Aug 2025 16:15:43 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC 4/8] eal: avoid shadowed variable aligned_end
Date: Wed, 27 Aug 2025 16:14:07 -0700
Message-ID: <20250827231528.236172-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827231528.236172-1-stephen@networkplumber.org>
References: <20250827231528.236172-1-stephen@networkplumber.org>
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

Fix instance where variable was being shadowed by
using a new name.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/malloc_heap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 13a56e490e..602266fba0 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -1044,7 +1044,7 @@ malloc_heap_free(struct malloc_elem *elem)
 	/* if we unmapped some memory, we need to do additional work for ASan */
 	if (unmapped) {
 		void *asan_end = RTE_PTR_ADD(asan_ptr, asan_data_len);
-		void *aligned_end = RTE_PTR_ADD(aligned_start, aligned_len);
+		void *asan_aligned = RTE_PTR_ADD(aligned_start, aligned_len);
 		void *aligned_trailer = RTE_PTR_SUB(aligned_start,
 				MALLOC_ELEM_TRAILER_LEN);
 
@@ -1064,8 +1064,8 @@ malloc_heap_free(struct malloc_elem *elem)
 		 * unmapped space that was marked as freezone for ASan, we need
 		 * to mark the malloc header as available.
 		 */
-		if (asan_end > aligned_end)
-			asan_set_zone(aligned_end, MALLOC_ELEM_HEADER_LEN, 0x00);
+		if (asan_end > asan_aligned)
+			asan_set_zone(asan_aligned, MALLOC_ELEM_HEADER_LEN, 0x00);
 
 		/* if there's space before unmapped memory, mark as available */
 		if (asan_ptr < aligned_start)
-- 
2.47.2

