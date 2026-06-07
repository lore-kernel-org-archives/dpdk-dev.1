Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B92CD8C88
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Jun 2026 15:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8701402D6;
	Sun,  7 Jun 2026 17:04:24 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 915E3402AD
 for <dev@dpdk.org>; Sun,  7 Jun 2026 17:04:23 +0200 (CEST)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-7ddd3d67084so38414607b3.3
 for <dev@dpdk.org>; Sun, 07 Jun 2026 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780844662;
 x=1781449462; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uSm6GaBVqDJtD/ezRlB+FEQOf44Q5Mh8au89J/BCtQE=;
 b=XKDV+E26BxuuYBXgMfICC3ICnfwIC3vsAA7g5qlJI1FqiUjdx+hk5zShUfrwUSeoYo
 wYoceQYGUyO5aSlpFTz+zCj9qEIet2mIe4LFAGlgypaYLWgT8B8T1TRSNGvIRTp01glU
 YGUusJXihvk6mr1/9/rWPGdVESGcuRCA96PbjjjuvUvt4N7VohpD15Rck0xPlf5U1Zbj
 G+Qzp5hiIPTxp/+rwYaD4hDbgeh9C6FTzN1k9Nor2udWifLDKGMNl98Q/8thmYaPh42q
 qs7I6sxAMNPCSU9wpUZLW+L0txbRvoS2st3agEtMGGStugZdN0bUvHMXHNDPRclzlm6l
 GUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780844662; x=1781449462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSm6GaBVqDJtD/ezRlB+FEQOf44Q5Mh8au89J/BCtQE=;
 b=A++jrsxJeyHk3GOw+XphKuHO62Y6zLSV/jNLiuT0yE0yUZzphkeJQ3oD7b5Ltgd5St
 ORxqgS7GpNEgC9w5WvTm7XyLwQWu0M6haPqXoz7rqASLl5TVmDoSl51/cQT+q7aexc7e
 L4Pwqy555/dly6NioA/BXVbGJFNazIleJlSAeVcNTJ/57wW5/aq+Num0upbhr4RzPNBt
 AJUrKPZU42BbckncNJyP/m8IP/UAtorvmh0pb9Hf5Zs6Eo7SZrOSnwbMDgP98tE8UNGr
 Mx/XNYzhwMkW5+0mW/2sq4Mqpx6eMeuAcTSxj2nVvgLcf9bweIYr1/bb2ZVFc6gsvN5n
 1tZA==
X-Gm-Message-State: AOJu0Yxf0O03MEtSoC4t1J+s4UzndacE1/JlAcfjR6jbYs562iGsOnFS
 5hBe9VeZnZACtm9r9elwoDEwibNvvE5Nvg/759AzYH/w7g4guDNt2L4SwZD1pBkrGcOsxw29648
 edr+n
X-Gm-Gg: Acq92OEeQJUdm/t+D7x7/btLPb+LZRHAdqBsCzCrmmDUkAGq3nPQbJWzQuma/Q33I8H
 0G4iBH2esvpUDhI//tLB/OKhk4wWoCItUCXIHV8Lo5va76mUt6J6DWWh57XT6VW8LnbdiYdnQOZ
 JH2hLAmkHLMkPw/5EfkNtdPZvZR9CgrNF4P323dErHeoD1lWjdmjqSQozZG/c5heb/GSOstnleX
 fQ+k6TSb063DjUG4ZeSd52gYiDg1WajhdaOvq7yI0FSFMeUGT1s3dkMhel8B/yo4atHVVXOcRmP
 IN3hhqjRe3XC3oyNnUz/RZM0qmT9bpmW5BPtrjlJ6G1OPp8ZcGaNG6paOHFq7lPtA0FzaAP06Di
 wsWTkAd99X7CbEF74Ia4MGL1cfHIhXNhQv/taWJTXiKBo3u25YySAbRbc1XafOa/sDP+YJWkjOi
 lt5XWNZT59wnENmulBcSI3JtnMyda+lRtHRzo9UNnlRnEv4c5cS8RhP39xGvXnai91+U4zm2jYZ
 6ibDWzDTCE=
X-Received: by 2002:a05:690e:bc4:b0:661:ab4:b048 with SMTP id
 956f58d0204a3-6610ab4bab5mr9114728d50.43.1780844662541; 
 Sun, 07 Jun 2026 08:04:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d644a68fsm8243035d50.14.2026.06.07.08.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 08:04:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] eal: add destructor to unregister tailq on unload
Date: Sun,  7 Jun 2026 08:04:17 -0700
Message-ID: <20260607150418.30885-1-stephen@networkplumber.org>
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

