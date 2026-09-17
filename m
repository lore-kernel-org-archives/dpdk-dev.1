Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AC0C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F019842E94;
	Thu, 17 Sep 2026 16:36:36 +0200 (CEST)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76]) by mails.dpdk.org (Postfix) with ESMTP id 3EFEE42E86
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:36:35 +0200 (CEST)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9a59so1350760a12.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655795; x=1790260595; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g2uoufm3NkD0GXZGoRQZUIp6BZK5c7s4Ieq4HtX/ntM=;
 b=r4fUwDfJlkS7tGk3ZN6CBdN3/PJ8R9jPFGKLSibZ3m70CBAww92drvjvg71oZS5yqQ
 3a1aaZPP5OkyVBUXuSZJaE+DuhECI6SyFrl99eCrQeQ+ULDH0DIxVuk3j78kqdlJuUQq
 zwIEOUtirEKfvwLMdnwN9EDym4w2pBxqKbc99O1+IJZRSKNgNgfmMrF9XLmE7B4juUik
 wVWwwT0Pstcokyfh+p9ADdOnuXyhk0/tiZvmflOn2R79l6GI7UCnSAb4kAmPQf/EUWgF
 /LAKYbA+BpVz7UtSOZL0E0qcK32IrwqWkhplr+tf18/PSQjgjs/cxsRdeVnP8zaGZqbh
 KAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655795; x=1790260595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g2uoufm3NkD0GXZGoRQZUIp6BZK5c7s4Ieq4HtX/ntM=;
 b=z52Q0M5EfncaB2NVgZkwkWW4u7IR20J/S1gC2z8HVaSd25ig5VdwDW6Ova2fMLihA9
 Q+mnvsdJ1OT1oSjqMYZi8Yvr8i2R8uTy3echkJnxcrZzQqxdKYtNk1TjVL/uy788fd/n
 ZyPg4nLMo9jX9j5I4Uc5Omz41vxo9lyvlPvsD4nfSr1uMy4RFTpMYwTnG8dGO750M36p
 0MZFlwi+mdkXbLLG654njfOWNu9AjfDZHu7l7wHBdjJ1cgZNOAKGp68aJpSj+rW4kSTV
 pDqxGN6CPwgZM5abKngdwLCzLCDmmdvNi4qRs4TSbqakz0yMjRLLXJ+9rvUQfT+7lHNT
 T0cw==
X-Gm-Message-State: AFuF++lXd8iqS7BJrimoWbRF9PJ9kmlw/82RBPjw36z01gwSv1a17DVF
 4Z2QK1cfps2U0SS6UxQQLssSFrN1e3JJ+GogIPmQ4wU9Nu6si/1ulgkC
X-Gm-Gg: AYBFou1Q659eA0LhEZ6ihhRZUNqvZ+NqyNb+dgkEO3pjA7G5puGJY4Av6JUQFR6w3eS
 t6yX/JFU3RzIbobwEYIi1wS4PFvNh3lJsGeZFOxJe1jwCtLV9gky5jyvKiAzQeG8Il6n4Nrtaqz
 ul5TJtWiJUwjDqE/W9nHWOUEq7cQNfaxCaj2pJNPx6Jc5TLp6JfL0fDhvRxe9oZ4cl4CiKl1Qc6
 +t3SzN3X5pVWioUAONs3QZxQ+2P1VmcSu0iFeECVjfg5YyRRtfov2g7dRH1QTIQ1+J/RAofdeic
 Sz/p0HCZC68be2VD1v/5vA+cDRuV+IeQ2ByMxA3GZ8fQztcHBSHMV/fSKJ4dg2OOZpThZ3ENoJ3
 r4ifcti2Ew0Ct8cp0cXbLv7bCtnLZug28xXtJM8uyoHpLFA2/mu5j2rQbbXJ3ULeQsPV3w7Sot9
 QAf1zMmPS4o+pjTFxUCoBcP5sc9laphaRrm5buywMxzXoNuqKhA99cjugES38=
X-Received: by 2002:a05:6402:f25:b0:6aa:4529:4cb7 with SMTP id
 4fb4d7f45d1cf-6aa452955d1mr877272a12.16.1789655794536; 
 Thu, 17 Sep 2026 07:36:34 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2727bfsm3440986a12.20.2026.09.17.07.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:36:34 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 2/7] bpf/validate: refactor internal step function
Date: Thu, 17 Sep 2026 14:35:32 +0000
Message-ID: <20260917143539.46951-3-qm2k21@gmail.com>
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

Rename `__rte_bpf_validate_debug_evaluate_step` to
`__rte_bpf_validate_debug_evaluate_update` to better reflect planned
usage, and make it accept a bitmask of events instead of a single event.

Step event is still implicitly triggered for now.

No functional changes.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c       | 17 ++++++++---------
 lib/bpf/bpf_validate_debug.c | 20 +++++++++++---------
 lib/bpf/bpf_validate_debug.h | 11 ++++++-----
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f9960088a2..b317abb811 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2989,10 +2989,9 @@ evaluate(struct bpf_verifier *bvf)
 				break;
 			}
 
-			rc = __rte_bpf_validate_debug_evaluate_step(debug, idx,
+			rc = __rte_bpf_validate_debug_evaluate_update(debug, idx,
 				prev_nb_edge > 1 ?
-					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER :
-					RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
+					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER) : 0);
 			if (rc < 0)
 				break;
 
@@ -3024,9 +3023,9 @@ evaluate(struct bpf_verifier *bvf)
 			}
 
 			if (bvf->evst->unreachable) {
-				rc = __rte_bpf_validate_debug_evaluate_step(
+				rc = __rte_bpf_validate_debug_evaluate_update(
 					debug, get_node_idx(bvf, next),
-					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE);
+					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE));
 				if (rc < 0)
 					break;
 
@@ -3038,9 +3037,9 @@ evaluate(struct bpf_verifier *bvf)
 			 */
 			} else if (node->nb_edge > 1 &&
 					prune_eval_state(bvf, node, next) == 0) {
-				rc = __rte_bpf_validate_debug_evaluate_step(
+				rc = __rte_bpf_validate_debug_evaluate_update(
 					debug, get_node_idx(bvf, next),
-					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE);
+					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE));
 				if (rc < 0)
 					break;
 
@@ -3059,9 +3058,9 @@ evaluate(struct bpf_verifier *bvf)
 			 */
 
 			if (prev_nb_edge != 0) {
-				rc = __rte_bpf_validate_debug_evaluate_step(
+				rc = __rte_bpf_validate_debug_evaluate_update(
 					debug, get_node_idx(bvf, node) + 1,
-					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN);
+					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN));
 				if (rc < 0)
 					break;
 			}
diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index 9a03976632..f76303a7fd 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -582,8 +582,8 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
 }
 
 int
-__rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
-	uint32_t pc, debug_event_t event)
+__rte_bpf_validate_debug_evaluate_update(struct rte_bpf_validate_debug *debug,
+	uint32_t pc, uint64_t events)
 {
 	int rc;
 
@@ -595,8 +595,7 @@ __rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
 		return -ECHILD;
 	}
 
-	if (pc > debug->bpf_prm->raw.nb_ins || event < 0 ||
-			event >= RTE_BPF_VALIDATE_DEBUG_EVENT_END)
+	if (pc > debug->bpf_prm->raw.nb_ins)
 		return -EINVAL;
 
 	debug->pc = pc;
@@ -606,11 +605,13 @@ __rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
 		rc = debug_send_event(debug,
 			RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE);
 
-	if (event != RTE_BPF_VALIDATE_DEBUG_EVENT_STEP)
-		rc = rc < 0 ? rc : debug_send_event(debug, event);
+	for (enum rte_bpf_validate_debug_event event = 0;
+			event != RTE_BPF_VALIDATE_DEBUG_EVENT_END; ++event)
+		if (events & RTE_BIT64(event))
+			rc = rc < 0 ? rc : debug_send_event(debug, event);
 
-	if (event == RTE_BPF_VALIDATE_DEBUG_EVENT_STEP ||
-			event == RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER)
+	if (events == 0 || events == RTE_BIT64(
+			RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER))
 		/* Stepping into a real instruction to execute. */
 		rc = rc < 0 ? rc : debug_points_call_back(debug,
 			&debug->breakpoint_lists[pc]);
@@ -651,7 +652,8 @@ __rte_bpf_validate_debug_evaluate_finish(struct rte_bpf_validate_debug *debug,
 			event = RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS;
 		}
 
-		rc = __rte_bpf_validate_debug_evaluate_step(debug, pc, event);
+		rc = __rte_bpf_validate_debug_evaluate_update(debug, pc,
+			RTE_BIT64(event));
 	}
 
 	debug_evaluate_close(debug);
diff --git a/lib/bpf/bpf_validate_debug.h b/lib/bpf/bpf_validate_debug.h
index a91f3e9c48..2b0c3bb646 100644
--- a/lib/bpf/bpf_validate_debug.h
+++ b/lib/bpf/bpf_validate_debug.h
@@ -46,7 +46,7 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
 	const struct bpf_verifier *verifier, const struct rte_bpf_prm_ex *bpf_prm);
 
 /*
- * Signal each instruction, branch end, or evaluation end.
+ * Signal evaluation events.
  *
  * Immediately return 0 if debug is NULL.
  *
@@ -54,16 +54,17 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
  *   Validate debug instance configured by user, can be NULL.
  * @param pc
  *   Current value of the program counter, or next after last instruction.
- * @param event
- *   Specific evaluation event if any, or RTE_BPF_VALIDATE_DEBUG_EVENT_STEP.
+ * @param events
+ *   Bitmask of events.
+ *   Step bit is always implied and should not be set.
  * @return
  *   Non-negative value: evaluation should continue;
  *   -ECANCELED: evaluation should fail without calling this API again;
  *   Other negative value: evaluation should fail signalling failure;
  */
 int
-__rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
-	uint32_t pc, debug_event_t event);
+__rte_bpf_validate_debug_evaluate_update(struct rte_bpf_validate_debug *debug,
+	uint32_t pc, uint64_t events);
 
 /*
  * Signal end of evaluation process.
-- 
2.43.0

