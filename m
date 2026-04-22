Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B2DFA1FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 20:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F07940648;
	Wed, 22 Apr 2026 22:54:57 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id C126240648
 for <dev@dpdk.org>; Wed, 22 Apr 2026 22:54:55 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso8085073eec.0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776891294;
 x=1777496094; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uSm6GaBVqDJtD/ezRlB+FEQOf44Q5Mh8au89J/BCtQE=;
 b=Z7G2BY+0eLgbfEW5BAQhy4IRRuDdB3RQuL8+FVylfiJPN8e2dfiCejjJs+nashnSev
 hhtYIKzfMTbXXESYL/u3X3udwA/rCUMQV71uPJgtNLjy8DIShj15a6SSToASezHNBnWG
 HojFU3kCH3zKJ/4WyTZL5O04ZDTSMjBBSooutAYct3L0iWq0n5tsFK5ezhooBIwdno4c
 WGjduGfppgiBoN9m0tVnkdMSgnNlohJb6EUDXLtylXD3Igkdat2avWtdnwkMBEZvY/+a
 XeU1XsLRGsn1B6jJaZnd8JCjV7eeOG4y+UNbbxWu4X6UL9RK1TgHyx8cFbwC7IVm/LqH
 SB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776891294; x=1777496094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSm6GaBVqDJtD/ezRlB+FEQOf44Q5Mh8au89J/BCtQE=;
 b=O2+Qgvtvu2KkY/jwuLaNvoemcaeBJmN0dbS4UMRRJb/mOrCF/ztZUkEjpwNHik0bZy
 5Z7x6dtcAsKOCJ9xj/ZeyTpeEjAR/JDOqJHOidFJbOyoOw7pZXHaWj2eLiPkzFqGX5Cd
 cVmujUjDZj5VOk46dEKcLRFxdAnWaz49cwKmX1IdrvJB6akz3NIZBzYgviaQ9XQJNjpc
 36eBP1gbrR5I3iJAG5l/9wuuSvF35zQR0PoTkGeZv6UVN613TnfC5qC1Y92D/aVG8vuE
 WfP9dvKEjeq+9GdAfcXC0zljsiDqkVGtkhMsqJk0vOlMt7RMAul40tJo023gDRiBIn14
 g1CA==
X-Gm-Message-State: AOJu0YyIpddo3Oc+x7czgKHMDcG/boYSlZPp0b5X8h0+cbfwVbrG8dQk
 Mefqy2Bq3TTUMIQfj9yQqdgRmrskIubKv2wq9O2+6IbVz1JgZJJU4Kh5Xys+l/lZthzLXi7iaz9
 V3Mm1
X-Gm-Gg: AeBDievg4v42WHR1YCz09q/1kLQ3NsY+ncoViYNwLjulZ7K5bpJF5+W76dx1cz7S/a9
 NzsW7gFeYho7sT9xFBlJwuk1UPS6O7ESCBy9QyxAnR/Q1cag3q5G8ocXkOU0QRTrkoQY214OEeK
 C6lOo2sQ35RVD2mJsDZVoZkYbHy9rgacyt7sL7goByLTdmbh/I0T6k7g/EB4xV0dZvAPmEQzJz4
 OfqRrIOBaOh3kGJRKFfe4+xVfa0pWjpdEB2JO1HPc4H6UBshwcf5nvxxo0gdsqL5idZTuf/TiF8
 MtJODf/FKNCSkabxd0gdHmXa4vwViT4jwPO0y/wbUzXTo8Ze820jEdNAsMTwhipdyKtQA+KPJ0A
 HRb78KkZ7/iMVNQjuE+WxYgKJRHlqp6amfm04vC+8RSquQXvmdWOBXtv9LM5dThNFr0fWWJQN+j
 z/CtfnWz2gz2r8fJwALucupzxtm6v+u/5sc1OsC8jx0/c=
X-Received: by 2002:a05:7300:3252:b0:2c4:ec89:bc7 with SMTP id
 5a478bee46e88-2e464dacc71mr13914380eec.10.1776891294444; 
 Wed, 22 Apr 2026 13:54:54 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a8018sm31482244eec.8.2026.04.22.13.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 13:54:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Neil Horman <nhorman@tuxdriver.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [RFC] eal: add destructor to unregister tailq on unload
Date: Wed, 22 Apr 2026 13:54:49 -0700
Message-ID: <20260422205449.289861-1-stephen@networkplumber.org>
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

Libraries that use EAL_REGISTER_TAILQ insert a pointer to a static
struct rte_tailq_elem into the process-local tailq list via a
constructor, but have no matching destructor. When such a library
is loaded as a dependency of a plugin via dlopen() and later
unloaded via dlclose(), the list retains a dangling pointer to the
now-unmapped static. Reloading the plugin crashes in
rte_eal_tailq_local_register() when it traverses the stale entry.

Add rte_eal_tailq_unregister() and extend the EAL_REGISTER_TAILQ
macro to emit an RTE_FINI destructor alongside the existing
RTE_INIT constructor. Every library that uses the macro
automatically gets both sides; no per-library changes are needed.

Bugzilla ID: 1081
Fixes: 873a61c7526b ("tailq: introduce dynamic register system")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_tailqs.c |  8 ++++++++
 lib/eal/include/rte_tailq.h        | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index c581f43b6f..714f91d0ec 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -148,6 +148,14 @@ rte_eal_tailq_register(struct rte_tailq_elem *t)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_tailq_unregister)
+void
+rte_eal_tailq_unregister(struct rte_tailq_elem *t)
+{
+	TAILQ_REMOVE(&rte_tailq_elem_head, t, next);
+	t->head = NULL;
+}
+
 int
 rte_eal_tailqs_init(void)
 {
diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
index e7caed6812..c5d5cb782f 100644
--- a/lib/eal/include/rte_tailq.h
+++ b/lib/eal/include/rte_tailq.h
@@ -117,11 +117,28 @@ struct rte_tailq_head *rte_eal_tailq_lookup(const char *name);
  */
 int rte_eal_tailq_register(struct rte_tailq_elem *t);
 
+/**
+ * Remove a tail queue element from the local list.
+ * This function is mainly used for EAL_REGISTER_TAILQ macro which pairs
+ * an RTE_FINI destructor with the existing RTE_INIT constructor.
+ * The destructor calls this function during dlclose() to prevent
+ * dangling pointers to unmapped library data.
+ *
+ * @param t
+ *   The tailq element which contains the name of the tailq you want to
+ *   delete
+ */
+void rte_eal_tailq_unregister(struct rte_tailq_elem *t);
+
 #define EAL_REGISTER_TAILQ(t) \
 RTE_INIT(tailqinitfn_ ##t) \
 { \
 	if (rte_eal_tailq_register(&t) < 0) \
 		rte_panic("Cannot initialize tailq: %s\n", t.name); \
+} \
+RTE_FINI(tailqfinifn_ ##t) \
+{ \
+	rte_eal_tailq_unregister(&t); \
 }
 
 /* This macro permits both remove and free var within the loop safely.*/
-- 
2.53.0

