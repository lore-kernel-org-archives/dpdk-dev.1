Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EBFC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 18:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C62F40E4C;
	Wed, 29 Jul 2026 19:58:02 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5386640A76
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:53 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cbb973e6749so1462923a12.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347872;
 x=1785952672; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rTX254QN7oQyQsaaW5jzd+lVpMQnZx1oh3XhBFHTTYY=;
 b=iJrJdKfqNt5cyyXIMp84wYbfL2aXBmSrtFiJC9304SeNhmYUlobGnVr41VRW9PVpKP
 yW3L14SuBnGqx4lts3eDtDvSGkPHK+JDca0XIG2LAmt1itMZlPnzFpCNE5sVIGl1NWXy
 Xpy0+LllhkKhK5Kdk19xtCmVlmO1ErPjgHM/UIw6ZVM9XnAgGjG83WxlNPWIlq8h8hqJ
 Fzg32OQDg+aTATwRj1ol4WU4OeHYZ4hQf0DHRdlXpQaMyu8Vd8g/MKOvN8ajijO/lLri
 XkbDALABSJzyR3WjPZg3pK8WCsT2k9FnD3T15GZIXPAkcEmh1L620nI/XZdcRUv1RlDJ
 +5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347872; x=1785952672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rTX254QN7oQyQsaaW5jzd+lVpMQnZx1oh3XhBFHTTYY=;
 b=GD2KjrcLH2YVClyiKmno2RdLydfsw+55V4ob5J1dFwo6uoCUvOYJxT20PlLwrtBTz/
 9bqaJAQHJt2IwdibIXwSggTxlD2G2JancE2VBrbqkzheFOpk+jTRfjnzRsWGUdfK8IUP
 1fVsRL8MSJW+2Q/x0LAHXnfv+b21M4AFkRd2+2phgBKgD5K5sFXMwugfr6yHk7ttPP91
 McIMrKn3bPewI0paJDcidJPPfvm1veMJzTPLrBjHhfhTDCzrjdBomj22Can/rYGkzfY/
 BjuKvVIA2W2VqGWIkNGncE9Na6lbQQtu9YbvNtBPyBViG/vWEsU5bFZln+T09PpgxIxs
 fBSw==
X-Gm-Message-State: AOJu0Yzy2zVrQPeuTEZMBzA1sAsRc1c4NL+Xc5iLZwRAzKDnGFsw7pKs
 TU8A9M6Osmzx5VK5b2ykEVQWnaXDNwp8svVg9ED7yF3hyQCB1HTV9G9MtK7tbepF5xwyius2vOa
 rdTuy
X-Gm-Gg: AR+sD100ueb0Ah1J5V8eamTv6KilM/vo1cvM+EtIBNbESJs6WLCpmgp5Rqx34QdmmyQ
 n+ABT9dmvKvPVJs8vw/Kip3fSxKlbiDKCIuOm4wxeov1nD4poxbXLNLAMhsCJMcAqSYJ5GLf4AJ
 IfTFmf86m2QvzdTgXmm2CgLqhKp0dL5SiezKwCRrMAbW1dyE196RA865silDRn3KjDnOtfDRORM
 AYLJUpq+IC0A2kvTXrBizqWJz+KSAiMZOyaWkD85/GlbFC+nG4ES6FhI3Koqco9nPlMvcQJwTjJ
 aTp2LCD5xhEufwjRXzvUrQu67QYAF+eEnvZm5BulkZa9sKsgrvhrmarffjKWKb1nm5p/DC4ibQy
 kYUvlOurHlS5eIAqgt2rpUrXV/rPBMjumqs9l7WtbluorDGDg+heddjwyiELLfnDoNhb6j+U5V9
 Us7BIboQr9ww1jhkFeR6TTJnAQ8QMu++QXd/OIBZvAKRH1u3yIAbw7D5DxX2OGuhc3STKYXcsvo
 Cx5+jy3xjCdoplrPQn5uI3qt7s=
X-Received: by 2002:a05:6a21:1145:b0:3bf:a698:ce40 with SMTP id
 adf61e73a8af0-3c8ba617e36mr9397004637.58.1785347872553; 
 Wed, 29 Jul 2026 10:57:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 32/32] doc: update release notes about rte_smp_XX removal
Date: Wed, 29 Jul 2026 10:54:25 -0700
Message-ID: <20260729175715.165120-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/deprecation.rst   | 7 -------
 doc/guides/rel_notes/release_26_11.rst | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 6ad7698c6b..b310801b84 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -46,13 +46,6 @@ Deprecation Notices
   operations must be used for patches that need to be merged in 20.08 onwards.
   This change will not introduce any performance degradation.
 
-* rte_smp_*mb: These APIs provide full barrier functionality. However, many
-  use cases do not require full barriers. To support such use cases, DPDK has
-  adopted atomic operations from
-  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html. These
-  operations and a new wrapper ``rte_atomic_thread_fence`` instead of
-  ``__atomic_thread_fence`` must be used for patches that need to be merged in
-  20.08 onwards. This change will not introduce any performance degradation.
 
 * mempool: The ``flushthresh`` field in ``struct rte_mempool_cache`` is obsolete,
   and will be removed in DPDK 26.11.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..d9ebbac77b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -77,6 +77,12 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* Removed SMP memory barriers:
+
+  * ``rte_smp_mb()`` replaced with ``rte_atomic_thread_fence(rte_memory_order_seq_cst)``
+  * ``rte_smp_rmb()`` replaced with ``rte_atomic_thread_fence(rte_memory_order_acquire)``
+  * ``rte_smp_wmb()`` revised code to use ``rte_atomic_load/store``
+
 
 API Changes
 -----------
-- 
2.53.0

