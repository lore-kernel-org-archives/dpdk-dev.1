Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA90CDE00C
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 23:05:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FEE140278;
	Fri, 26 Jun 2026 01:05:41 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 4FACE40272
 for <dev@dpdk.org>; Fri, 26 Jun 2026 01:05:40 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-30b6dad2382so881578eec.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782428739;
 x=1783033539; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8gFQBzY/AiKWXclxYLBGH1EBFO32/oP8MbCoquLluB4=;
 b=mRN2oTMtqpMWdwslY4J9EG9n6nfu8crQQZAn39nAUcKWFYD6EW5IOJvqbxH68qezly
 vLeiTFdv96Zli5u8oBC91Fbaj2L0wtHKhkfhIlbFLHYe0YfQmifrd27e9NtnZcwr7jwV
 KJB19gXKczppEP6/IPC+i9GzRnWLY6qVlEEdF5CGMdD/IhiPRIdhBin8Hy85n1sACL7F
 SzNFwzmhgEfgN4lKePSjHP53xNjVqtiaVCItOx3Zrov2kIh1y6/MFf7P75zGNDl1uR8u
 wdBE7HeVQAt5kIZ2Meo8sHYSaYfY+KgNLFc/IOgsOEDhybea3bZCvnVrxJ6T9kwowO+/
 bdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782428739; x=1783033539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gFQBzY/AiKWXclxYLBGH1EBFO32/oP8MbCoquLluB4=;
 b=HiF8dFjvWAHqPAckIBhX6eXBonRnNfe8EFpnsmQvZ1GIDwETXTGODMjrFxuZQfcm1J
 GKL74DHw0EXfI91TDH11lbURrqAYLUYwwbXplIbiHC1E1HlAjMqiKqAnU8Mbz0xefgkh
 8hu7FW6O47HUv7q9VcGMgYUKMpj6/I/8pT/bhoUkneGRh6pvw0qq73N2qCJVEDEgSN0c
 YDIM7KeViC3vbo2g19n2ZfDxgPJXkZYSSlbfYsBWLkPe6GcZDwJBXgCkDPF/9pE5CpNy
 2yVd/+FKAdX2FRePF8R0wmnM+IrN0y6/DpFMteUScccvwKZdByVA3C/BPCEwqHzSRHif
 fxlg==
X-Gm-Message-State: AOJu0YwZU+QBlueffclq4VNNi6l3BVzZDQBAUjOdrxmdSoKi0mweo0Z4
 9t5Sbnfwh45GNQeKb1sE4ik8jpYR9f62gxmCUIg67VXXjQcamX+QmhkBdiBTPZRXPlLy6RaJe3k
 7546o
X-Gm-Gg: AfdE7cmf18awSMiOXjW8xz2Vb6m1B8KXNWijtNMyB73TrF3xUyGLO7SEHfKJ5wQlLpe
 A+pNZiTM1RNCP2qS6c08VVqOLUaTicF9qHL1vMDn6sQpNaYugCuNOCOAWs9WEtehe6oPsuWOIFt
 xVA11UT5PbB5XEf7Cpp50WluOiHzwkHxEj635iKLF3k+iUMYcUmuyy9lUBsLnLkOVHxspM45yiB
 Y3J9l4VW5D6hYied6fCFEkokS7EWP21bMLaMFW3p4VfK9so5W6KpgBurtiGZ47JhYe8VltBy0wa
 R5f9RZINDI/zBrwcWUXCuio3bQjJkjIGx1OZLAup2byra60VqzqPLUt777xV3F7uJRdoVUd8Zr2
 4v8ku2cKw3Xw22yE5sKJRVGGdQK5gyRsywSQqi/Q0/Cp/WKA9e6BrbpXwyLtLd5+dtJRw0uCcfe
 eekLjEIpzf5177ezoWzWs7DAhQn3TqI+vrPdUnNGQqnhJncssGrPk=
X-Received: by 2002:a05:7300:3203:b0:30b:8893:8788 with SMTP id
 5a478bee46e88-30c84b895c6mr4133142eec.13.1782428739057; 
 Thu, 25 Jun 2026 16:05:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c9e9214sm12850688eec.20.2026.06.25.16.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 16:05:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, vladimir.medvedkin@intel.com,
 Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH] AGENTS.md: add additional checks for crypto related code
Date: Thu, 25 Jun 2026 16:05:36 -0700
Message-ID: <20260625230536.147975-1-stephen@networkplumber.org>
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

Security related code is a high value target and extra precautions
should be taken. These are hard to catch with checkpatch alone
so add additional rules to AGENTS file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 AGENTS.md | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/AGENTS.md b/AGENTS.md
index af9a7e0772..d6b84f777b 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -513,6 +513,41 @@ than one that catches every style issue but misses the bug.
   }
   ```
 
+### Cryptographic and Security Code
+
+Applies only when the patch touches crypto PMDs (drivers/crypto/),
+the security or ipsec libraries, or code handling key material, IVs,
+or authentication digests. Stays silent on all other patches.
+
+- **Non-constant-time digest/tag comparison** (Error):
+  When verifying an authentication tag, digest, MAC, or ICV --
+  comparing a computed value against an attacker-supplied one to decide accept/reject --
+  plain memcmp leaks timing information. Use rte_memeq_timingsafe() instead.
+  Return semantics differ from memcmp: memcmp returns 0 on equal,
+  rte_memeq_timingsafe() returns true on equal.
+  So `if (memcmp(tag, digest, len))` becomes
+  `if (!rte_memeq_timingsafe(tag, digest, len))`.
+  Do NOT flag memcmp on non-secret data: algorithm IDs, key lengths,
+  capability/feature structs, lookup keys. Only flag comparisons that
+  gate acceptance of attacker-influenced data.
+
+- **Sensitive material not zeroed before free** (Error):
+  Keys, expanded key schedules, HMAC ipad/opad, and session secrets
+  must be wiped, not merely freed -- a plain free leaves secrets in heap.
+  - rte_malloc/rte_zmalloc'd secret: use rte_free_sensitive() instead of rte_free()
+  - local/stack secret going out of scope: rte_memzero_explicit()
+    before return; plain memset() may be optimized away.
+  Do NOT flag buffers that never held secrets (descriptors, dev_info),
+  or memset the compiler cannot elide because the pointer escapes to free.
+
+- **Insecure RNG for keys/IVs** (Error):
+  rte_rand()/rand()/random() are not cryptographically secure;
+  do not use them to generate keys, IVs, or nonces in crypto/security code.
+
+Do NOT flag:
+- IV/nonce reuse -- a runtime property, not determinable from a patch.
+- memcmp on lengths, algorithm selectors, or non-secret config.
+
 ### Architecture & Patterns
 - Code that violates existing patterns in the code base
 - Missing error handling
@@ -1642,6 +1677,9 @@ Checked by `devtools/checkpatches.sh` -- not duplicated here.
 - [ ] `bool` used for pure true/false variables, parameters, and predicate return types
 - [ ] Shared variables use `rte_atomic_*_explicit()`, not `volatile` or bare access
 - [ ] Memory ordering is the weakest correct choice (`relaxed` for counters, `acquire`/`release` for publish/consume)
+- [ ] Auth tag/digest comparisons use rte_memeq_timingsafe(), not memcmp
+- [ ] Key material zeroed before free (rte_free_sensitive / rte_memzero_explicit)
+- [ ] Keys/IVs/nonces not generated with rte_rand()/rand()/random()
 
 ### API Tags
 
@@ -1753,6 +1791,9 @@ devtools/get-maintainer.sh <patch-file>
 - MTU accepted without scatter Rx when frame size exceeds single mbuf capacity (silent truncation/drop)
 - `mtu_set` rejects valid MTU when scatter Rx is already enabled
 - Rx function selection ignores `scattered_rx` flag or MTU-vs-mbuf-size comparison
+- Non-constant-time comparison of auth tag/digest/MAC/ICV (timing side channel)
+- Key material or session secrets freed without zeroing (rte_free_sensitive/rte_memzero_explicit)
+- Non-cryptographic RNG (rte_rand/rand/random) used to generate keys, IVs, or nonces
 
 *Process and format errors:*
 - Forbidden tokens in code
-- 
2.53.0

