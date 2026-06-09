Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAD4CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 15:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0EA040684;
	Tue,  9 Jun 2026 17:54:26 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 226DE40658
 for <dev@dpdk.org>; Tue,  9 Jun 2026 17:54:25 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-307263ad0cbso7635108eec.0
 for <dev@dpdk.org>; Tue, 09 Jun 2026 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781020464;
 x=1781625264; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFd3SR0Dr112CCXrBdh0GJ/BWCrHRXx2uMDX2QYAEOc=;
 b=XOfNPBi4Hb/WeaiLw9YthOSMxVFarsypE+Xb+sP/6n3FKndgB+655DrzGP6Qq+vwNT
 7Ue/+QVk+s7LnX+xrDfNjBMS5I3+z2gfmYdQ5KZlvkfxofe6aEs90JGXVcxgIgOmWQ9z
 tK8OVTxfaJozQKawPq4V418/iQdV7FITmXhzthwbRED0nUBjfISAnVUpxaCQu0KQHMNW
 2aKhDA9Ty1TgHaPCyJVO9rCq//ncUiBzoDMRXpwMV9ksFX1BHOOvlIklB40zAs820a/9
 sOFgkxgaWyh07XBrtXlRgF/+4cdB5AsuXVvZEyoCqnnNU/bDZt4/1E8pdxQcQG4P0fOE
 i9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020464; x=1781625264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFd3SR0Dr112CCXrBdh0GJ/BWCrHRXx2uMDX2QYAEOc=;
 b=BT8UqXj7HC1aP+5HLdlNyyFlt228s28cNiPrFTknUnGS2Fep7a2LHkua+SWrcjPA4t
 tps4yQC448blFezEURCD7QG+y3G9R/BT7qRZgjUkifnwI1SqNuhZKV5MOy4uJEWsswqS
 x4TDMUvRyA8zGoDJ9IWxnhdAmBGibu30LdsH/BqzZjzio7TCVGQ4V0W+LV24bI/W+LLh
 DstyWc8UklphrBRc88DNrmx+QvZEJBwCjqlq1vr+asuuuYDd3KRcbBbq1ya/7+H79sFk
 OQ1TSK2+R5wLRcqAvUhfOKaNt3foB9FTg40/SzvScK+SHIEsmr1mrgMDDZz7vUcRHq9a
 E9Xg==
X-Gm-Message-State: AOJu0YxnLBG2hDT5mU3O8ZELERaeM38irzHMqere/j9jUoSaW6F3PUiW
 t8rCVf3qwk2GHtGZjCj1uwe5a+5IknY0tghqrHV0w1uYGmMi1ZMQscKsCf39Ri3i6J6a+1ONbea
 JbcLw
X-Gm-Gg: Acq92OGhM8Gn2dLrzeBdqNv2ccGzs13469Rb/tFoXxZ/IqbYpRaCXheOVvLTrgmKAFT
 SJnTcR1h0LpoHSyJUBzgWDCZJXPWUXedWwwGSyCfkz3HYp0dHpHahlKdwkqyU9RF99XJThF6Zps
 FTHdvnod8Tu5Vv0x3Y2ym19vTuDm7MB3GeMxE8+7rcabX9xO1L5rs9YRN3JFQ0kv4nx9bJEgXCq
 PTeRbyAD/cy60M9KJ/UrACBVpYil1DyDeQQm9+ILWGxv55RvH74uZ8gKsK99BO4np0wSnP+t+fr
 e4AmGZjakd0dd1AcNeWgrevcF9Sx95jYajvwlseTfo4Nxlzy8H9RNcdl4uMXaPjTX6oJytMlVp2
 ePMSJ5PdjpqINhOS1PFlxNB0R36BOMfeCQWdwv2ZXaaFRm1pdB4e0/p2rHYf+SKXLFb9SZq4C8t
 tCcoDI/PJor13oTDmF7XGPM9aRdiCFBBX9YlnTEhQL0mOUF5OXEPLYQWu9Tm41gcyxu0+aKkPz
X-Received: by 2002:a05:7301:168e:b0:304:630d:e4ec with SMTP id
 5a478bee46e88-3077b272073mr13014148eec.28.1781020464163; 
 Tue, 09 Jun 2026 08:54:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm31015551eec.11.2026.06.09.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:54:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v3 2/2] eal: add destructor to unregister tailq on unload
Date: Tue,  9 Jun 2026 08:53:31 -0700
Message-ID: <20260609155419.263787-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609155419.263787-1-stephen@networkplumber.org>
References: <20260607150418.30885-1-stephen@networkplumber.org>
 <20260609155419.263787-1-stephen@networkplumber.org>
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

EAL_REGISTER_TAILQ registers a static rte_tailq_elem from a
constructor but provides no destructor. If a library using the
macro is loaded with dlopen() and later unloaded with dlclose(),
the process-local list keeps a dangling pointer to the unmapped
elem, and the next dlopen() crashes in rte_eal_tailq_local_register()
while walking the list.

Add a new RTE_FINI destructor that is paired with the constructor
in the macro. rte_eal_tailq_unregister() drops the local entry on
unload. The shared mcfg->tailq_head[] slot is left reserved since
it is keyed by name and shared between processes;
rte_eal_tailq_update() now reattaches to that slot on re-register
instead of failing.

Bugzilla ID: 1081
Fixes: 873a61c7526b ("tailq: introduce dynamic register system")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_tailqs.c | 13 +++++++++++++
 lib/eal/include/rte_tailq.h        | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index fe3ced21c7..34e6883f65 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -113,6 +113,11 @@ rte_eal_tailq_update(struct rte_tailq_elem *t)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		/* primary process is the only one that creates */
 		t->head = rte_eal_tailq_create(t->name);
+
+		if (t->head == NULL) {
+			/* slot reserved by an earlier load -- reuse it */
+			t->head = rte_eal_tailq_lookup(t->name);
+		}
 	} else {
 		t->head = rte_eal_tailq_lookup(t->name);
 	}
@@ -148,6 +153,14 @@ rte_eal_tailq_register(struct rte_tailq_elem *t)
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
index e7caed6812..d4d8bfd6d4 100644
--- a/lib/eal/include/rte_tailq.h
+++ b/lib/eal/include/rte_tailq.h
@@ -117,11 +117,27 @@ struct rte_tailq_head *rte_eal_tailq_lookup(const char *name);
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
+ *   The tailq element to remove from the EAL tailq list.
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

