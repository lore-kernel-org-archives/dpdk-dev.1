Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E60C54F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:00:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6780C40693;
	Fri, 31 Jul 2026 06:59:55 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9CB6140262
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:59:53 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so306920a12.1
 for <dev@dpdk.org>; Thu, 30 Jul 2026 21:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785473993;
 x=1786078793; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TMoH7tCbDEP7NudaYmK0dbQ/hE3o4DkVJrzZnjsCBcA=;
 b=dOd9EeRVXh/wU191eLMddNDHKrrusXcV53GvlbpEVP/EjeggvPdruKsEHQ6PMeuOy7
 q8atTQgczFJwZyxaODMYCDgldJdGA94UXAUAootMLrD4424rnKaekCE1H8hW6xqNR8jo
 DkeyTbts2k32IKvvSCafYhYUi1YmRkgtuHyZ9IgExxyj38aw8R6Wfx9NEOSZcFTC85pN
 SIxKtyRxSB5Zzpb7rrnRxkUFTLwSsDeZ9U4vZQgDxbBG28rV10+QDbaPX5/oChdIbRZs
 nedU//CXmhnLaBTuZLthm/DHm+Y1vbR6YFr8RUs5WKPdMriKgIlw658ZvUyrSA9Kmwz0
 5aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785473993; x=1786078793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TMoH7tCbDEP7NudaYmK0dbQ/hE3o4DkVJrzZnjsCBcA=;
 b=hi/533uduRemfoOclAgUP4+JCVRLfIRjhM8nYxGZ62MpfJaL3nhp7Vkxx4CATMmnJQ
 gWiocdK9vClWfAa9IDgJTJ47vbRu14m3IpiOsYwInfgws6xCZsngfC/oud4hQ+MOiuBU
 tCcOr8DJ1i8DWe/T1DWM/KcK016s/0AvAySvk/Fz+60gc2oosWWF8FcDiwQndDb6KPYa
 Iu8tK/xtFAmyGq5r+4O/0ws/BoFm/3ZfiDJxYOMVZjqeybDkyyvHopQMhJKWvtTIli/Q
 40J+VNw1a+8A2hkdwxkoCbVTLlehTPK2KxyX2bye5KKkaOv0aopXsgRSs86pGaHIJbor
 idSw==
X-Gm-Message-State: AOJu0YzkVgY8aK3N7IB3GxG5qJbh5ks9T5Hu+ekQJ5RUWYxjqPTR+mI3
 f0NCttVYW2dDfUPA4WuRF4c8njZJw1r3VmU5VYVeRmwMd7RPRL5bDF31ToRXOJtvi/gwRSQc0YD
 3gnxZ
X-Gm-Gg: AR+sD10rOfd1e8uzVvVggEwcEqjusigUoYw7xSTM7ZPlTJQ9zsiEJ7GbEd9f02EM8Yq
 ZCZEmADE8P+nTrmZ5iFE+MG/b6XNPiHFhdZc4iTCWGXnmatZPPb39pC+IMZv1DZqHImugRALxD1
 OWxD0clnsjOWGMG2S3flTAKRhgY3zgd4ujQg+ywbsNx0aiOoCN9isua7PLjaIUD/mHGIKQs9uRL
 YXBZEZvh4hK712Avc7dx1bCzDCU9eKWVa8CmcnKMDsW30/+S2sSfntvkYoCcSnrNDek+TERmS/U
 75I3kK/Woi7pGc+/m7b389zu935JLBSHsCZxNZsU5FgHeh4UWfseZWaONfspbTFL+zAM4Ro/lWn
 GIP46i/o10sPjw9fCAjNNylmsyoB2gtQeoDeCxZ/EdQY1q27S8bhKvuROTpbfreB/pRl9LeA8i4
 Mn1IPa5jVnSbqNazztJtGwr+PWa4x6EoF19o2Z2fGdoX67PwC/anBI4LE3Uhzjh4nUbK9s0jdfI
 h7dgfhOU5vFcgfTZWfj8TDenWEmeUBAhL1Ptw==
X-Received: by 2002:a05:6a21:920d:b0:3bf:b931:b3f4 with SMTP id
 adf61e73a8af0-3c91b40f937mr461374637.51.1785473992723; 
 Thu, 30 Jul 2026 21:59:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.21.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 21:59:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v6 01/24] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
Date: Thu, 30 Jul 2026 21:57:39 -0700
Message-ID: <20260731045948.769926-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

The BPF_ST_ATOMIC_REG macro generated code with deprecated
rte_atomicNN_add and rte_atomicNN_exchange.

Replace this with the equivalent rte_stdatomic definitions.
Use memory order seq_cst to preserve the previous behavior of
rte_atomicNN_add() / rte_atomicNN_exchange() and matches
the Linux kernel BPF interpreter for these opcodes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_exec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index d423ef28f5..99b37ffa4e 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -11,6 +11,7 @@
 #include <rte_debug.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
+#include <rte_stdatomic.h>
 
 #include "bpf_impl.h"
 
@@ -66,16 +67,16 @@
 		(type)(reg)[(ins)->src_reg])
 
 #define BPF_ST_ATOMIC_REG(reg, ins, tp)	do { \
+	RTE_ATOMIC(uint##tp##_t) *dst = (RTE_ATOMIC(uint##tp##_t) *) \
+		(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off); \
 	switch (ins->imm) { \
 	case BPF_ATOMIC_ADD: \
-		rte_atomic##tp##_add((rte_atomic##tp##_t *) \
-			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-			(reg)[(ins)->src_reg]); \
+		rte_atomic_fetch_add_explicit(dst, \
+			(reg)[(ins)->src_reg], rte_memory_order_seq_cst); \
 		break; \
 	case BPF_ATOMIC_XCHG: \
-		(reg)[(ins)->src_reg] = rte_atomic##tp##_exchange((uint##tp##_t *) \
-			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-			(reg)[(ins)->src_reg]); \
+		(reg)[(ins)->src_reg] = rte_atomic_exchange_explicit(dst, \
+			(reg)[(ins)->src_reg], rte_memory_order_seq_cst); \
 		break; \
 	default: \
 		/* this should be caught by validator and never reach here */ \
-- 
2.53.0

