Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1E3C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E235B42EAE;
	Thu, 17 Sep 2026 16:36:40 +0200 (CEST)
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99]) by mails.dpdk.org (Postfix) with ESMTP id B6EA342E98
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:36:37 +0200 (CEST)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a985fba28bso1194636a12.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655797; x=1790260597; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EHralhZMC8QFra6aTcLg9P2CSEEqIAKx4jfrnjEykOc=;
 b=S/M+/cSuQbrIP00l/8CaCC1sEgcQHu/scfh2vibXXNvUNPKRFO1TgGnNhpE25pHMKC
 SD/56Me5N2/isg51VBOMpq+M6pamBJikbleLFsmURSGlnlxZ6Jhp1DhWsESFXArk4118
 OyO5d1MfWTrwAROFqDw77r/Y1z5obo4XvwKyqf4yvXOiEJf1Sk6DrWg3BFFK1/xO8EJc
 AGBUjMGQV6VwL1RKOQ7lFCkMxq72Zqu8nuNN8OP/B8YmFOmmtLjM2NfCI6UXAZynulgK
 Xn9yu/Z8gpm0MyFT+uA1s3I9+q2Tb6T8sOwCQS0H9dUMy+nIdGbGEIzwC1v5PVEX5I7W
 UIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655797; x=1790260597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EHralhZMC8QFra6aTcLg9P2CSEEqIAKx4jfrnjEykOc=;
 b=UfLWfz67Pzs0QDB68Pi1z0S2ILdOxaYIgCBdC5BA64ODvVDBwhTQ62vD1DzKyqrnZM
 X24TSCUCZf7iIgBhaJVa4VV8TpyRbCkYiRJIEySmLwc9GTsX+kpT/mcZ+nV5jVubmBPp
 /d2VSX29lq3GKxsRk4Kn5VkiaVY4TI20DmdZEGVj+5ucJhUXtJ3j2ih6DrhqkHdp7k8a
 iSTjBIyjpXt/S3qCbafDwTE91uenV0aw8gLz7u0BYh3QWBe+1RkAT8537lxGZ3+jg771
 KDnQ5bUDhWOLhjtuPd8Of2i2aOI4iTALZVbktEWY1aEr9VwdM+LGq0yhWahMtjR/y409
 JwDQ==
X-Gm-Message-State: AFuF++k8DOGcdJTA1HwaIeKga88p3TFcbQgG2LxTum5dTBojRdqzXlgu
 MuJ7BDsJ/thdl8wxk3zgp7gxMQFKLFWZS6tt6jmrMnC/Dxg3chZYMGK8ckSGuog/7JY=
X-Gm-Gg: AYBFou2IdC5ddoHlVWcLTyCzEeZRHCwYBpuD/1R82XVmWhBXypybZdiA9+NDz9tuuJZ
 LpLRDa/rRbPXZgYt71H7l8/AH6wHfZNdz1wwK08mmO6OKWCe3za0A67HcE7FI3qICZnqrrUrjQL
 Lp7rta1h90GyxsKYNTCsQmvIdU7XG9pzXAwJc9A2+ifFgMij5I4okBujPl8U3imfk8zZJKlQV5D
 /11aaz4cRUe/qvFje6iwXZDIrysP5jE7aCUZE9CWebACMq3OUmULWO2FzLflKlvssHuUdsd4RpP
 XgS+velXsIpGuH4IRrAznyv9ub8E9iY09zV8BXlzppjBxsZt5vposSo9TqGc3MZhlCuiidNj4W4
 ja5/rQlJdDhlwByUs5SsM6y+f4dyhLhILKuluRaMMamgooxYkjKzuhXEgn+LvCm4mDbHwIKobZf
 XUCS7wfAC2v7B+Px0V1CqobIao10zSh4OFKgGcQPveBzbMYK1XdEmkkspTKbE=
X-Received: by 2002:a05:6402:23d8:b0:6a9:9aca:1fe9 with SMTP id
 4fb4d7f45d1cf-6aa22190385mr4789828a12.0.1789655797168; 
 Thu, 17 Sep 2026 07:36:37 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2727bfsm3440986a12.20.2026.09.17.07.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:36:36 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 4/7] bpf/validate: add jump notification events
Date: Thu, 17 Sep 2026 14:35:34 +0000
Message-ID: <20260917143539.46951-5-qm2k21@gmail.com>
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

Add events notifying validate debug client of instructions that may
change program counter. This is particularly useful to an interactive
debugger to track conditional and unconditional jumps without trying to
parse the program and interpret instructions independently.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c           | 10 ++++++++--
 lib/bpf/bpf_validate_debug.c     |  2 ++
 lib/bpf/rte_bpf_validate_debug.h |  5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f4258c2fb5..d503db8361 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2899,13 +2899,19 @@ is_branch_start(const struct inst_node *node)
 }
 
 static uint64_t
-step_events(const struct inst_node *node)
+step_events(const struct inst_node *node, uint8_t op)
 {
 	uint64_t events = RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
 
 	if (is_branch_start(node))
 		events |= RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER);
 
+	if (op == (BPF_JMP | BPF_JA))
+		events |= RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS);
+
+	if (node->nb_edge > 1)
+		events |= RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL);
+
 	return events;
 }
 
@@ -3005,7 +3011,7 @@ evaluate(struct bpf_verifier *bvf)
 			}
 
 			rc = __rte_bpf_validate_debug_evaluate_update(debug, idx,
-				step_events(node));
+				step_events(node, op));
 			if (rc < 0)
 				break;
 
diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index db6d13f9cb..098a88026d 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -600,6 +600,8 @@ __rte_bpf_validate_debug_evaluate_update(struct rte_bpf_validate_debug *debug,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_STEP,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE,
diff --git a/lib/bpf/rte_bpf_validate_debug.h b/lib/bpf/rte_bpf_validate_debug.h
index b3fedd5428..f1ee8769d0 100644
--- a/lib/bpf/rte_bpf_validate_debug.h
+++ b/lib/bpf/rte_bpf_validate_debug.h
@@ -35,6 +35,7 @@ extern "C" {
  * At any given evaluation step, callbacks are fired in the following order:
  * - Validation start event;
  * - Branching and invalid-state events (can be interleaved);
+ * - Jump-instruction events (before evaluating jump instruction);
  * - Instruction breakpoints (before evaluating instruction);
  * - Step (before evaluating instruction) or validation result (if done) event;
  */
@@ -57,6 +58,10 @@ enum rte_bpf_validate_debug_event {
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN,
 	/* Pruning branch as dynamically unreachable (pc points to branch start). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE,
+	/* Program counter points to a jump-always instruction. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS,
+	/* Program counter points to a conditional jump instruction. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL,
 	/* Number of valid event values. */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_END,
 };
-- 
2.43.0

