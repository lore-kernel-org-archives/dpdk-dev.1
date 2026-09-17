Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679ABC982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC41442EC1;
	Thu, 17 Sep 2026 16:36:41 +0200 (CEST)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76]) by mails.dpdk.org (Postfix) with ESMTP id E326542E98
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:36:38 +0200 (CEST)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a985fba28bso1194679a12.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655798; x=1790260598; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6yGnZ5vfsX0IKALcvzad3Try1LL3cml2b9x33Gwbp6o=;
 b=g5m8aSz/CDK2LvPNFq1Qh8mPQBP/vueCm7EggBUORyqMQrwomHkR9aEV64EqTx7/OT
 oH4PohAEDQUY5HOFcjgUBTb6du6oNWR5wmIC2o/b99FJUUHaR5RhWQgX1eoEBCkdc2Cz
 FDmVwTGvGzpunn7IzkMH6J0fKjdSAxFgsU/+p/XOu4dRnF6kP0MGj3J6gO0VH/RvQ8z6
 vOMUQ0/FR+BEFBCwDZ80axmX9wg3oe0Kxr8uLC4qG7EYHtHSaZeTBoHD/udVxx3S7pgV
 hqrUvnjFm7gEq3esUczvl5IiCpnjLpZuXNLBg7wj6pF1a6eV0AbcIZxCTRRLcxhcnbq0
 md0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655798; x=1790260598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6yGnZ5vfsX0IKALcvzad3Try1LL3cml2b9x33Gwbp6o=;
 b=cmj+DKJx984Aus115aBylfvT5KfeQ4kAoIcfyPBOKvhTtnAQYSg+5jWLd22ifBPbhp
 MLLI6sTPmmH5D7gK3BO19JcuAGpu4NQenthqKYly5vF6Bpw6wTgyDPKLhU0MMsKL+CGr
 dfpfPhTfbXEDa2VsnKd5bn+HnrYrr0QW9NDfz3gIYBqlL5ThpikMS8WKMV/bEznVQldW
 ZqL8qRMjegkx2hY76+gvWRruargRHJfsiahD+dEcD9x/s8rKWf2NtIjhbfeL0K4qmVc4
 ZLwGyJM+AOLF2/9l/C20ElcrzJ2Ibd1AdBD0QXFsnRlH9SlGaOrMYxsueAfZMuneP1NB
 aJAw==
X-Gm-Message-State: AFuF++lhmf+RGtNjkMHGC+IiDVwlTfvZHlSAzhnvIkQmSOWhHXlm+4BG
 2tUI+vZq2laR1dkn6D6skAQpsnwEMRveeO5ha0KKARETeco2elgT1LLwXlDXQtOVRh4=
X-Gm-Gg: AYBFou0/SumBIrcXKr0vWE1i9GHaCdX+ty3ZWYbDwnVbdybZA45iA3rVcPnfnhgo+rl
 FjpB1PyX1uuZMVgHDIf4W+gtR5b7A1EzXaULfphNRa1t47bt1eJT8AUcfWlJd4eN5IBpHPSietL
 EJIxZ8pelKfr4oIbe+WUHlJlIXk/inL0dSrDIRF1I3sJ4rNz4EjMvc6mDFHdE6BZksaRbRuRnBp
 7kGuyEsL6X+PHmsogzOigpuAyo53k+KTJNCjUKfAdTPfx3G9HwyStZIfKvVjrPsAuz/Cb6sMW7w
 RtYyXy9luKwG8faA7FcAHl542HB/6sKH7e+Wz/mNHbfBf4XNR0Fxgo1ZHl/oIR+Ifih7En9Waet
 euT4wNMWzlgMG+HYgxisWKvSUneZo5vKjSk+tAp3Ynvp/uvE0znzM8x7Kot6ICosYjNGWXtip+7
 W84PCmORlc6vb4ADIayfMHEgvkaOI7dDxqCmsrBEHsmFNXYRji7+aViDOFVIw=
X-Received: by 2002:a05:6402:5005:b0:6a8:e223:fee5 with SMTP id
 4fb4d7f45d1cf-6aa2248b5d4mr5422893a12.44.1789655798389; 
 Thu, 17 Sep 2026 07:36:38 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2727bfsm3440986a12.20.2026.09.17.07.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:36:37 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 5/7] bpf/validate: add get current event API
Date: Thu, 17 Sep 2026 14:35:35 +0000
Message-ID: <20260917143539.46951-6-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143539.46951-1-qm2k21@gmail.com>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
 <20260917143539.46951-1-qm2k21@gmail.com>
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

From: Marat Khalili <marat.khalili@huawei.com>

Add API for retrieving the event currently processed by a callback.
Useful when single callback is registered for multiple events to put
less pressure on the context argument.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate_debug.c     | 13 +++++++++++++
 lib/bpf/rte_bpf_validate_debug.h | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index 098a88026d..c8e9e5dd92 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -43,6 +43,7 @@ struct rte_bpf_validate_debug {
 	const struct bpf_verifier *verifier;
 	const struct rte_bpf_prm_ex *bpf_prm;
 	struct point_list *breakpoint_lists;
+	enum rte_bpf_validate_debug_event current_event;
 	struct rte_bpf_validate_debug_point *last_point;
 	uint32_t pc;
 	/* Evaluate stage (only tracking `evaluate` part at the moment). */
@@ -236,6 +237,7 @@ debug_trigger_breakpoints(struct rte_bpf_validate_debug *debug, uint32_t pc)
 static int
 debug_send_event(struct rte_bpf_validate_debug *debug, debug_event_t event)
 {
+	debug->current_event = event;
 	return debug_points_call_back(debug, &debug->catchpoint_lists[event]);
 }
 
@@ -342,6 +344,17 @@ rte_bpf_validate_debug_get_ins(const struct rte_bpf_validate_debug *debug,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_event, 26.11)
+enum rte_bpf_validate_debug_event
+rte_bpf_validate_debug_get_event(const struct rte_bpf_validate_debug *debug)
+{
+	if (debug == NULL)
+		/* Just to be fool-proof, not really required by API. */
+		return -EINVAL;
+
+	return debug->current_event;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_last_point, 26.07)
 struct rte_bpf_validate_debug_point *
 rte_bpf_validate_debug_get_last_point(const struct rte_bpf_validate_debug *debug)
diff --git a/lib/bpf/rte_bpf_validate_debug.h b/lib/bpf/rte_bpf_validate_debug.h
index f1ee8769d0..6d4bf53589 100644
--- a/lib/bpf/rte_bpf_validate_debug.h
+++ b/lib/bpf/rte_bpf_validate_debug.h
@@ -194,6 +194,19 @@ int
 rte_bpf_validate_debug_get_ins(const struct rte_bpf_validate_debug *debug,
 	const struct ebpf_insn **ins, uint32_t *nb_ins);
 
+/**
+ * Get event currently processed by a catchpoint callback.
+ *
+ * @param debug
+ *   Debug instance.
+ * @return
+ *   Event currently processed by a catchpoint callback.
+ *   Undefined if no event is currently being processed.
+ */
+__rte_experimental
+enum rte_bpf_validate_debug_event
+rte_bpf_validate_debug_get_event(const struct rte_bpf_validate_debug *debug);
+
 /**
  * Get last triggered breakpoint or catchpoint.
  *
-- 
2.43.0

