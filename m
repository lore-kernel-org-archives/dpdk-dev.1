Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38819C88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:24:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A03942EB4;
	Tue, 15 Sep 2026 21:23:21 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 60F1042EAE
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:23:17 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc1so107529a12.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500196;
 x=1790104996; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ytiXM3KqtcRrC3++Sm78Ya/zlciQyZbi/38eUFcTOW4=;
 b=OtqqSnRyAEqxFfXA/03m0aL5z461U7QqgMtFAZszBefsRH32yQXESAjU38qCKRPyx1
 Tkk8SnbjbTYufmy9QPsw3UxDw1ZiKhd9AIah9pT42Sm+X3xcaVPvElQ6xvW0YAoMEAm6
 4zKu6Dul2AigkuZyZatpwGt/gWTnf17TSHdF8WqAoOfg6PXRt/hrhu+QlIELeSq8iuc5
 vlYYbQEy7Uymg5dkTwZnfQMuG0b0VumhtRaOY5UbkQJONhcnZuQEA3v4Irbi+i0j4rwF
 bScysIi4GSjkskCCvkZdvF1AuX0iKYlDxDfWEF4V+agH4NeIzo6yHqzzh02j4vYP4tKO
 KYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500196; x=1790104996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ytiXM3KqtcRrC3++Sm78Ya/zlciQyZbi/38eUFcTOW4=;
 b=km3gmPxXkQBHCl45bwG0gWprBI16icEStwe2yyCZ5MmqeX0Pb+CENjrq60rWzwqs6o
 lKTTF3m1qnvJYsaC3Og8IRKkprgApkDQUqtCy8Re++SB2HxgkConQyMnvoC2ZFp65D0t
 N0Rf7gYF6S0Ix4YASnSnI0JvbT0XNj1IqP7ufBt6heUurr9EaW7jdQZ8UiCOentQvJG4
 h9PQ+g0+lxoHtt5/YiOKmYqSCmEt5vpSN25tVzNDdnLeftcJiMDazGntQMAUHgQCkOuQ
 xAJI6/B0KPGzlIDHeEB60Myejp9/9OrY970zdi1O3OCZXxkv12n9HyMlufKESplWcqOB
 ovoA==
X-Gm-Message-State: AFuF++knXjVa7mLdpqzezXWFCuzkwl+r7SUTO2LVFybhF6nCnQrH6WTj
 Helbn8F+VQH5I7sqMU59MwhVjw9E5hhvYnWrBxFHSqHerCxfeGSBo7WbNhhpua0EFwnD1UzBIVB
 PEwcy
X-Gm-Gg: AYBFou2M7A7QjLtw61SoRMjh21KDV5go0pdAqdyb1xFLiJM/9YlV2We9tNGeIwzxNeb
 pEnYza47FhTeGNdGmTBAjso0mAX8GwmilZk6/Ru6M/CHoeGGrhscsajjSZpti6mRHroITrR5GL5
 dbAAo2Mbc9MosgPCNWnegyUD/FIUIh3UhjZvXhhsdas6jdalGjr1aDUVnfot538a/hbnD2m83KE
 ewkz9mcRdCpEQkhXeDDueRivTYqvMMX+t6y3JM1iDer7YlKs+3KAf3hjudsQUf6Eyj/okuHCClq
 mECTWbgRL/bVUoNeOozvGQEXnKfJVLS1fVLdQcDPX159uMUhnQ21MzliDU+RCDWwa4eUSR8TcVS
 EYJ4LoFiiEjaJXECFqZ6xiEgVSvxNmqwbv0udEQmq1yiud53M/0DNXDWes4q/x/e2STOnp5DdaU
 YYR0oHHPuslo+blCGbUzEGo+oPK3jgCRKFD7lTA08vX1cioyL5EsIFCrLmVdg7Eyo8hSebQC/BL
 DtHkYm7vxGUskD36A535y4On4unCpkTZ2JnJ8g=
X-Received: by 2002:a17:90a:1056:b0:39d:ec9a:8f8e with SMTP id
 98e67ed59e1d1-39dec9a90b5mr11421406a91.8.1789500196470; 
 Tue, 15 Sep 2026 12:23:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:23:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH 18/18] doc: recommend secure random for unpredictable values
Date: Tue, 15 Sep 2026 12:21:16 -0700
Message-ID: <20260915192207.3926217-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

The AI review checks say not to generate keys, IVs and nonces with
rte_rand(), but do not say what to use instead. Name
rte_random_bytes() as the replacement, and extend the rule to the
other values which must not be predictable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 AGENTS.md | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/AGENTS.md b/AGENTS.md
index 813584352b..df4c37f62e 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -544,6 +544,9 @@ or authentication digests. Stays silent on all other patches.
 - **Insecure RNG for keys/IVs** (Error):
   rte_rand()/rand()/random() are not cryptographically secure;
   do not use them to generate keys, IVs, or nonces in crypto/security code.
+  Use rte_random_bytes(), which draws from the random source of the
+  operating system. The same applies to other values that must not be
+  predictable, such as RSS and hash keys, salts and random MAC addresses.
 
 Do NOT flag:
 - IV/nonce reuse -- a runtime property, not determinable from a patch.
@@ -1680,7 +1683,7 @@ Checked by `devtools/checkpatches.sh` -- not duplicated here.
 - [ ] Memory ordering is the weakest correct choice (`relaxed` for counters, `acquire`/`release` for publish/consume)
 - [ ] Auth tag/digest comparisons use rte_memeq_timingsafe(), not memcmp
 - [ ] Key material zeroed before free (rte_free_sensitive / rte_memzero_explicit)
-- [ ] Keys/IVs/nonces not generated with rte_rand()/rand()/random()
+- [ ] Keys/IVs/nonces not generated with rte_rand()/rand()/random(), use rte_random_bytes()
 
 ### API Tags
 
@@ -1795,6 +1798,7 @@ devtools/get-maintainer.sh <patch-file>
 - Non-constant-time comparison of auth tag/digest/MAC/ICV (timing side channel)
 - Key material or session secrets freed without zeroing (rte_free_sensitive/rte_memzero_explicit)
 - Non-cryptographic RNG (rte_rand/rand/random) used to generate keys, IVs, or nonces
+  instead of rte_random_bytes()
 
 *Process and format errors:*
 - Forbidden tokens in code
-- 
2.53.0

