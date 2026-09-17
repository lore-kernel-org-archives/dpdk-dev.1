Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67BFC982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:41:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D348F42F87;
	Thu, 17 Sep 2026 22:41:04 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 6755C42759
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:41:03 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469e25187so46774b3a.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789677662;
 x=1790282462; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8F2lpM9fkO9+pLZ6acACfNXtcGZXooD08O6mSPW+UxM=;
 b=A/vAjLeLUA/NDl5drdZGNvGky0oVaMm3+UyQNR6cMZpiCRlvcwwFKnOFtedpxwdV35
 TKcxSMt5VqTGrJx32VpsULVjA57dSqdWSfCVzMnWryIVflsLsyqPx/6GrlYI8j5rw3u6
 2YK34pcSBOc41/Y3hRSBavEGSUk0lE97fgDnAIqn/wojOOLKVH0NEMqpV/lBfv9xsAUA
 GDqrRgqCJkJ/Gm8+aKr4N8qE4XhcTKOXZOq9DbIpykn/1fod63xwIxec7QZv5U20vuTk
 z6J2WWvhujNNNiKfVyX7vIzK9/qrNi3lZHvh4hgGX9GUBg6QFREcW/VcH4igtfxU2HjS
 NlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789677662; x=1790282462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8F2lpM9fkO9+pLZ6acACfNXtcGZXooD08O6mSPW+UxM=;
 b=O4TmjAle+Lg9QXc8yKAGu8/71hSFJISkOPaRltrGI/uMuyY4Kdv5dzM1QYH4hdn6w8
 xpR+Npbva+XEQIAcfXbM0WPZbaGs4AFsNMj1kBAOyWQRJA3HCLBoeWRXotCDYMv473sq
 YNWfH66W68cGVXFkRwNVd1meh59NUqNm576/XA8wNfbxGZetrYZokWxf7T9yxVrNvWaS
 c+rsHzUoIz07skuSrhz2Ib50ClPxTdOS0NQ1fje5xUT3vs4qyl2yTnZoT/aGdAlVlIXL
 I/lIN7QEzzzydmdwoE0k65jMjGrSxrdXGtmdC3bjasGbJQSU2jCW1BI54RYWDEjOCLlC
 2T3w==
X-Gm-Message-State: AFuF++kwIw7bharKRiYzLF340ROsCRJ1Oi9YAdfbRXVpcPoeneZzBJb1
 hm9zioossRu6Qx0tPJBl1c5UXaB1BJT81Lwp3xRN0eqp2/C4mOKi5LTg+XvzNWL7J/frnto025k
 rlPKx
X-Gm-Gg: AYBFou3oxip6k8sMHMg6B8y1FfSo1V1GI+YzQR13Mcm3gB9cipdy2MtzvENlokaoRFb
 N5Y+n/8Bfen9dV8BQEWXmeoA2/mhg6hWdflUhPSHhf5nfjUNTixXSbTfEmasYBE5MSRYG9NmDHH
 wA2wQyhIn7WetPs7ryS5ZwbUfN504YMBw91zTF67WHHmCerI4CNwFf5eLMOyZr49twctl2m1BHq
 hS4UG7+wzsAFtL4ea/yw6FpDA8hqWn+EN7tI/H6bXqM36VeJdHaVdQthYFZQddagW+inHo/ull8
 NUqQ97IAnX/UYsvpue0PuBCizD0hXkpZQORHLR0vksy86hmO7O21mZrXBB3lwZ3yeXIoV0vMmWj
 SCCRWffVu1yBEDeJXmnz+TNJRki+0McXjF28yFdR59pDmULiek0h7y8jQ4cGLYfO8x16vbT1rb8
 gAgwDEPTGHCgkGB5oZxy34FG8TN4DVkKYmXhUAYpJ2YHtiWqr5U6dRqlNP4SCtaxy2GR46mvtd1
 JCTrWK8iUJ1QnoiNrHbjW7gOrJJX4LY5JduGfL2hQT+XKoE
X-Received: by 2002:a05:6a00:94fc:b0:845:bda6:574b with SMTP id
 d2e1a72fcca58-874db6f712dmr288450b3a.5.1789677662377; 
 Thu, 17 Sep 2026 13:41:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-871fc14239bsm3384264b3a.0.2026.09.17.13.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:41:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] eal: remove atomic flag operations
Date: Thu, 17 Sep 2026 13:41:00 -0700
Message-ID: <20260917204100.2289205-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The rte_atomic_flag_test_and_set_explicit and
rte_atomic_flag_clear_explicit macros were added in 23.11 with the rest
of the stdatomic API and never had an in-tree user.

They cannot be used portably:

* Only test-and-set and clear were wrapped.
  C11 makes atomic_flag opaque with no load operation.

* The operand type differs between the two implementations, and no type
  works in all builds: across stdatomic and gcc vs clang.

No portable application can be using these, so removal cannot break
correct code. Use rte_atomic_exchange_explicit, rte_atomic_load_explicit
and rte_atomic_store_explicit on an RTE_ATOMIC(bool) instead.

Removed without a deprecation notice as the API cannot be used as
specified. 26.11 is an ABI break release.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 10 ++++++++++
 lib/eal/include/rte_stdatomic.h        | 12 ------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..72f9dd92bd 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -79,6 +79,16 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* eal: Removed the atomic flag macros ``rte_atomic_flag_test_and_set_explicit``
+  and ``rte_atomic_flag_clear_explicit``.
+  They had no in-tree users and could not be used portably:
+  only test-and-set and clear were wrapped,
+  so there was no portable way to read or initialize the flag.
+  The operand type also differed between the C11 and compiler builtin
+  implementations, with no single type accepted by both.
+  Use ``rte_atomic_exchange_explicit``, ``rte_atomic_load_explicit``
+  and ``rte_atomic_store_explicit`` on an ``RTE_ATOMIC(bool)`` instead.
+
 
 API Changes
 -----------
diff --git a/lib/eal/include/rte_stdatomic.h b/lib/eal/include/rte_stdatomic.h
index 7258b393f1..2fd69ec780 100644
--- a/lib/eal/include/rte_stdatomic.h
+++ b/lib/eal/include/rte_stdatomic.h
@@ -102,12 +102,6 @@ static_assert(rte_memory_order_seq_cst == __ATOMIC_SEQ_CST,
 #define rte_atomic_fetch_nand_explicit(ptr, val, memorder) \
 	atomic_fetch_nand_explicit(ptr, val, memorder)
 
-#define rte_atomic_flag_test_and_set_explicit(ptr, memorder) \
-	atomic_flag_test_and_set_explicit(ptr, memorder)
-
-#define rte_atomic_flag_clear_explicit(ptr, memorder) \
-	atomic_flag_clear_explicit(ptr, memorder)
-
 /* We provide internal macro here to allow conditional expansion
  * in the body of the per-arch rte_atomic_thread_fence inline functions.
  */
@@ -169,12 +163,6 @@ typedef int rte_memory_order;
 #define rte_atomic_fetch_nand_explicit(ptr, val, memorder) \
 	__atomic_fetch_nand(ptr, val, memorder)
 
-#define rte_atomic_flag_test_and_set_explicit(ptr, memorder) \
-	__atomic_test_and_set(ptr, memorder)
-
-#define rte_atomic_flag_clear_explicit(ptr, memorder) \
-	__atomic_clear(ptr, memorder)
-
 /* We provide internal macro here to allow conditional expansion
  * in the body of the per-arch rte_atomic_thread_fence inline functions.
  */
-- 
2.53.0

