Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34285CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 20:37:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9621540A80;
	Fri,  8 May 2026 22:36:27 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id B58E240695
 for <dev@dpdk.org>; Fri,  8 May 2026 22:36:23 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso3798945eec.1
 for <dev@dpdk.org>; Fri, 08 May 2026 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778272583;
 x=1778877383; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EifivdIgZwPoYyRpHuAh03fq9pYdSFX8umA53ldaks8=;
 b=GaGWf/tnUqE0s6h5wSfCVXHPzNOHa/GQdiOV/W7iz4pNGAS601j5IAslxQVvt8QW/o
 QYNKZl3+Onyt5ud//62jyJKm2sOhxSnLAt02nl7JGlr1Aahan3pw+yBiECKSDMYv4N9h
 YQF8cNRulyVah4LxclAoihJq/EHZ95Q3s8R1+fXItRyOxGmRuKBPOtUjZQNFTlwd1gUm
 tZp3vH/2fPzqomMZ7ZiDpLonCoqwiGfWinBzKQCzCtGxJ47K8OL4Q7Z/rBF8n22LztXA
 +4kqU6MN6XKdmhpARgQdY1Gp1TqvDvwcD0JsMY6CvOJsGw/DMwYSXsvTEEhzUZpmq5SI
 G2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272583; x=1778877383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EifivdIgZwPoYyRpHuAh03fq9pYdSFX8umA53ldaks8=;
 b=KP7BeATxbUdTfBbZlL1kqlVLZM/K0YZWsTA/nonfYXfETjGVSIo2doa6YpF+Dryjps
 M/De22grgfWOl2uNv9IRA7Lfb+IjS6LklrIuA5Ty2S9ifXS48PdZwNrEtbPYmSX5V9SC
 s6Kz2VeTU8JSDAMa+b9mYOZc+qOf7HLmJYrLGMfCxEL7L4SvGQGg5xQImw48H0+fJBfy
 mwq3Hp+S0eiskyXcTQFthwZfxzRu9NxO4RaGIxoRPwf2S5nKwaN1u9mOQRwCTB4sp+0A
 +R7zeIc5xJ2U99L74EWBYkjsG26CSHVd7XgVRNu5nVuRyRkyocyGixYoPGBSedDHq/ax
 GkpQ==
X-Gm-Message-State: AOJu0YycDrX2D7K/iQy+3iTZqQO2on+VVH9dmC1eq0KGmCVWOwKMm4nW
 oQgNAQxKPmre2qzKv0WgKh/gyR9/daGQuc3gALvEBdPVfm+214KHBrFvq6Hh/amz1jOTx7LYyyY
 xaBbj
X-Gm-Gg: Acq92OEaX0QWPiAba1Mdrlb4/TzW+hhDYmRa/P2e2Xv+3ijV1O5ar/XWwOVBXizmsX4
 uxUAl/x5UzuSDQsjaRliGKwz67uHflPvn/HQWLMsWeXFV9UN73wF/1KBpjJbEOCuKsmNRFVVxHY
 Pi8VgbX+65pTv+aNAeUYvB+ogwsMNJOtCjGzi8ODXI4JVNcqmBX+/5HvVp7Ye/PKkI5nBVATb5u
 TpKKXME/OuERaUAkySwFDOIUgcskayVB7jOg1h6uTYy62aKfyecEl/faYOjQy5AGl7gB9oXxJzj
 y6E6a2S+cP3DlDrTJgmQEXDvCnBXK6j3hEsfex7AQvguGh3l9DYRf5SK1mFOMzqh4z3NLgeCYwc
 v5zks+60Xs48YIpa2DfTz4+LqYmhAE/8OwsGT+xj/v8NbQiLGcYeGMLZPrIrcRi/JoXC4rWg/qX
 0WxVtTVZqYEu0yvo2PzVpW66DiHcyNOI64EpnD1FICbWo=
X-Received: by 2002:a05:7300:a199:b0:2ed:a64:a457 with SMTP id
 5a478bee46e88-2f54a77f54fmr6936027eec.20.1778272582754; 
 Fri, 08 May 2026 13:36:22 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafcdsm4715146eec.6.2026.05.08.13.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 13:36:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 13/20] mbuf: allow NULL array in rte_pktmbuf_free_bulk
Date: Fri,  8 May 2026 13:33:34 -0700
Message-ID: <20260508203607.1003036-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508203607.1003036-1-stephen@networkplumber.org>
References: <20260508203607.1003036-1-stephen@networkplumber.org>
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

This allows callers to avoid NULL checks and just call
rte_pktmbuf_free_bulk, similar to rte_pktmbuf_free.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/nullfree.cocci          | 5 ++++-
 doc/guides/rel_notes/release_26_07.rst | 5 +++++
 lib/mbuf/rte_mbuf.c                    | 3 +++
 lib/mbuf/rte_mbuf.h                    | 1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/devtools/cocci/nullfree.cocci b/devtools/cocci/nullfree.cocci
index e7417b69ff..78e30f730a 100644
--- a/devtools/cocci/nullfree.cocci
+++ b/devtools/cocci/nullfree.cocci
@@ -4,7 +4,7 @@
 // free(NULL) as a no-op.
 //
 @@
-expression E;
+expression E, N;
 @@
 (
 - if (E != NULL) cmdline_free(E);
@@ -79,6 +79,9 @@ expression E;
 - if (E != NULL) rte_pktmbuf_free(E);
 + rte_pktmbuf_free(E);
 |
+- if (E != NULL) rte_pktmbuf_free_bulk(E, N);
++ rte_pktmbuf_free_bulk(E, N);
+|
 - if (E != NULL) rte_rib_free(E);
 + rte_rib_free(E);
 |
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..6f2f7f849f 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,11 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **mbuf: rte_pktmbuf_free_bulk now accepts NULL array pointer.**
+
+  Calling ``rte_pktmbuf_free_bulk`` with a NULL ``mbufs`` argument  is a no-op,
+  matching the behavior of ``rte_pktmbuf_free()`` and ``rte_free()``.
+
 
 Removed Items
 -------------
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index c2476e7704..8ec3bb53bb 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -562,6 +562,9 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 	struct rte_mbuf *m, *m_next, *pending[RTE_PKTMBUF_FREE_PENDING_SZ];
 	unsigned int idx, nb_pending = 0;
 
+	if (mbufs == NULL)
+		return;
+
 	rte_mbuf_history_mark_bulk(mbufs, count, RTE_MBUF_HISTORY_OP_LIB_FREE);
 
 	for (idx = 0; idx < count; idx++) {
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index e7c3bbadd4..e9f8932e80 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -1534,6 +1534,7 @@ static inline void rte_pktmbuf_free(struct rte_mbuf *m)
  *  @param mbufs
  *    Array of pointers to packet mbufs.
  *    The array may contain NULL pointers.
+ *    The array pointer is NULL function does nothing.
  *  @param count
  *    Array size.
  */
-- 
2.53.0

