Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA8C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E62BD427A8;
	Sun, 20 Sep 2026 20:14:38 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 366B440E03
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:29 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so2021341a91.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928068;
 x=1790532868; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UT4jhrhVomgCM+ojkCmZDyLeufRy2SpE0xa74TkS+g4=;
 b=pl4eEblWlkC698zxDqxO+Ysa3+GV6kNkh+xTKm0jcCBOsSsczQ5W49opJnaPsUki61
 eg5ZNfLZq3N3l2qEJ0PAHDj0TkUYOUkqdOsWQ7rkRVqhID11f2fluW9/jV39aPASQxym
 1AFA+HjzU3s8VOikZgqBMOe3+1KhFJBC/HbAXAcOZmKvlRR/O9a4bebuoUjZV1uDLUsM
 spche8aFonWoVT0D+H4e8r+0xoxpA4FkSWlr/lPjrgvdPBLoReeXvqplsaWMgWRruQRX
 zLEC1Bo3HeRwGfHR9nMXxhoOkrI3uJMAcRKI4ru9sN9vRk+7XhO+6TiWAdCUFbdGm+FF
 dFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928068; x=1790532868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UT4jhrhVomgCM+ojkCmZDyLeufRy2SpE0xa74TkS+g4=;
 b=nRvRLaQqEUGj7+CkvgnOgW3nO66HavGoGooBj2c/hc0lF9bqdbKlFvrVpNPRHpYMLF
 DshnIJiM4/Ukha0pJulM9mb7hk/PppM9OosFljHflkwhiYSFV/UP2twqJTzUF757DfpI
 KT8vLEat7OQA19pY1It6/ePcMXCD0HTyhAOzDoNaO0K/utwX7pLIOx2lkLgLlZWPbuWC
 f4t0ooPjklPjCz4JUhFnxTEKOJ9WMVAsLuP3uT7+0RxkC+1v/3riewkefh2iVnGt6mgO
 kdfOieuBmeXhfh8+rF2Zq+6nAH6Tc99M5v3X5aXOnHyneorfpDaL2uzXmkimfJ9Rp2e3
 ATfQ==
X-Gm-Message-State: AFuF++moN2iDkJJjGsPcXLErDEFoKtKZ88N6oUv1ryWqkmcK0KRh4qXl
 qi0f1uKT3b830iolgCr/I1zAsIEiA469/kbAvSNgU8FIZYJ6Nqy+u/7+TOwA3ZDe2jGf0TGIq6G
 PkrE/
X-Gm-Gg: AYBFou2/VQsh7d/ifCTXOOrQsK3VyXvO0Ji2cQhVqHyleIsDC/w959L6RAYqKTYrhkx
 lHhRkUq5F7RJhDXRTEWj97N+U2NELi1ZMp/KVzF2azk9MLI/KInED/hAjtAqRJr0nQXNkPM4Bli
 PnjC/slObXUVmUojHrcJg/a4RrNHOadsvd3rbQHxJ2tXo3Qn8E7zj/vs7uGdm5182cwhypBm9Vc
 2eDP0jGNtu6D+J0oFRDvzWYh3m5yQZVgB/0j3oQydYknO+IEtP5BppdLUBN9jhb1H+ZZCecBsL1
 hzXTw3uh/lijj9T65nvrQp9V6rSsuzjNxSbDKcDtSR41xJ74cYZeWlBtsSe5MlyCyoVlzxvRvS7
 PZDDEFXcq4rx0Hl7BAKkFzSgc9AS2qiektN+Sgb/WcRI3pbLeOOg3K+U4XhsL3j//ww/9I2NVcJ
 vTohgdtAATJrRDVtNNjNm3mwkmi0TkhW5DtviBFD0bt1QmPfvnCDrMhHX1t0pd0T3MJ47x8wGZQ
 lulWNh5BScnoggtZrexZ8XBH+CgSkc1LOwoHA==
X-Received: by 2002:a17:90b:2dc3:b0:39d:e9b6:cec9 with SMTP id
 98e67ed59e1d1-39e54d36756mr19228285a91.7.1789928068342; 
 Sun, 20 Sep 2026 11:14:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 33/33] doc: update release notes about rte_smp_XX removal
Date: Sun, 20 Sep 2026 11:10:25 -0700
Message-ID: <20260920181347.747210-34-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The functions rte_smp_XX were previously marked for removal.
The removal is now complete across the tree.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst   |  8 --------
 doc/guides/rel_notes/release_26_11.rst | 11 +++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 6ad7698c6b..ff0bab60ab 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -46,14 +46,6 @@ Deprecation Notices
   operations must be used for patches that need to be merged in 20.08 onwards.
   This change will not introduce any performance degradation.
 
-* rte_smp_*mb: These APIs provide full barrier functionality. However, many
-  use cases do not require full barriers. To support such use cases, DPDK has
-  adopted atomic operations from
-  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html. These
-  operations and a new wrapper ``rte_atomic_thread_fence`` instead of
-  ``__atomic_thread_fence`` must be used for patches that need to be merged in
-  20.08 onwards. This change will not introduce any performance degradation.
-
 * mempool: The ``flushthresh`` field in ``struct rte_mempool_cache`` is obsolete,
   and will be removed in DPDK 26.11.
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..c545374b6d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -79,6 +79,17 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* Removed SMP memory barriers:
+
+  * ``rte_smp_mb()`` replaced with ``rte_atomic_thread_fence(rte_memory_order_seq_cst)``
+  * ``rte_smp_rmb()`` replaced with ``rte_atomic_thread_fence(rte_memory_order_acquire)``
+  * ``rte_smp_wmb()`` replaced with ``rte_atomic_thread_fence(rte_memory_order_release)``
+
+  Some call sites became release stores or acquire loads instead of a
+  standalone fence. Barriers that order CPU accesses against a device,
+  rather than against another CPU, should use ``rte_io_wmb()`` and
+  ``rte_io_rmb()`` instead.
+
 
 API Changes
 -----------
-- 
2.53.0

