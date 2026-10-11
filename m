Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5BACA9ECF
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:23:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB9234064A;
	Sun, 11 Oct 2026 20:23:08 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 0228740656
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:23:07 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so883632a12.3
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742986; x=1792347786; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ZZjX9Jjki/3yH7gOWlKzvIegbWEppKNuJdciDm4RNo=;
 b=m50FVKlv1NuhqE6Iu00kYCkcN/O+hWT2l7HIj/ZHPGrbRIYv4jSgiPvIOK5jWHsfVQ
 fp+3AWIE4ozPSJPshEaQpvcgUgP0qHZHajAHtX4CUsZt1NxVLb9Eb29rttQchtduJt0M
 M4OL0do0PVOdcEQNJYrKItRGJAp3rVhTPRmFfcWUvFM/cw29Spv/pLPZArwKaylkooSF
 nLtXcD9Idpj3Au4ifn9twrtqudz40bfn2/nvA8z3EMVCJofAjuuIfWRjCMHIaVq3TaS/
 c1tPjgQqgTPsfCfezeb/ov92KfNJ7kyMYRvwcYUjacEW7Dh6IOsK4hj71/FBjwkg/Fe3
 ROwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742986; x=1792347786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ZZjX9Jjki/3yH7gOWlKzvIegbWEppKNuJdciDm4RNo=;
 b=lyfmZLzAw1sd8XoVRHBcdfOToccM+uLEwhj/1if2l+vF+TgSSI8FQwtKlXH20b8bFK
 Ooz8PeOzoGmYTA65ECGehKvVg6+3CGtmBWASBzDNjwworftf/0bBFsIxRyywaGcR9wdg
 taktemwesh+ATWKTjHV+qTAfuGmqNd3BnQPa3WB+MToN05mksKfdnmi675HmTxW0TPtg
 peJfSUdaTWwDrcIZ3MC6oG8Ex/p3pVvn+TK3CWcCaaF7gWZej+Vll8RCIzu1czrDqXXH
 xlojG91kaGCO9W3IzKX7FQnG6CpK0bB/lba7n2jVn+5kT+YyUFFIEzB3R9dkJ7mKH03+
 WUaw==
X-Gm-Message-State: AFq9FYJeTTjDNWmot2zUY7PRmWo3qCCf3cxulWu36VtK6kraqdNsuhmD
 +tZdUtlTiKwrzWSqW24mMk3dhCKzOS3YYQjBCQUVPW7CfeGmmjBDElXkENIPgkH9uaY=
X-Gm-Gg: AYBFou0NtifZv3cC1rsHH4OuUuCWb9jBBTNP7dLLgbzY02vVyhl7xjmlbfuME+XmrI/
 v9g1j2w0LMQ7+LmqBrOWiyfMPGPXCG6932VZ9tE3HLq9agIq/jY2FqxL1vHgx8H37ch64XrjxL/
 i7cQMxwWVdsfZoziABjQadw9hd5OZWih0S2+iIWS4yczw1jSTvwegC2BRVUNFOGh1CkcUxjxbx2
 gULPMkXzcqFEbOibQDwKMPmx8hhQD7W4Q5vaYW6nzNexWbHwlsdbs8CfiYf153Mu+6kHAm77uQe
 atc5dWYItFKPJzNM2upsO5ppmZKvUGGkKK+FyhDH9z79cO6OnTlEr24t1UH63ckFtVPjtPWmaJH
 7KoSe+0r1UljDJkV26O2n9KUQ5slvU8AcRpOH1fgO8ndTEJOdUb6pC/I4bvmdJNMIPCQCnyPBtT
 iJ9mngfkIjyWu4UDoFs1qiIbQNSYfdj4rV5xlskqPtiAF+cbC1v8EvofAacDg=
X-Received: by 2002:a05:6402:3244:b0:6b1:c43c:c2f2 with SMTP id
 4fb4d7f45d1cf-6b1c43cca4emr458983a12.1.1791742986499; 
 Sun, 11 Oct 2026 11:23:06 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:23:05 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH 8/9] bpf: use relaxed stores for callback inuse tracking
Date: Sun, 11 Oct 2026 18:21:56 +0000
Message-ID: <20261011182158.124246-9-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182158.124246-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
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

Direct assignment to an atomic variable defaults to sequentially
consistent memory order in C11. Since cross-thread memory ordering
for packet callback execution and unload is already explicitly
enforced by memory barriers, sequentially consistent stores are
unnecessary and may emit redundant barrier instructions on weakly
ordered architectures.

Update bpf_eth_cbi_inuse() and bpf_eth_cbi_unuse() to use
rte_atomic_store_explicit() with rte_memory_order_relaxed, matching
the relaxed loads already used in bpf_eth_cbi_wait().

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index ea7e240494..9dee001f0f 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -137,7 +137,7 @@ static struct bpf_eth_cbh tx_cbh = {
 static __rte_always_inline void
 bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 {
-	cbi->use = BPF_ETH_CBI_INUSE;
+	rte_atomic_store_explicit(&cbi->use, BPF_ETH_CBI_INUSE, rte_memory_order_relaxed);
 	/* make sure no store/load reordering could happen */
 	rte_smp_mb();
 }
@@ -150,7 +150,7 @@ bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
 	/* make sure all previous loads are completed */
 	rte_smp_rmb();
-	cbi->use = 0;
+	rte_atomic_store_explicit(&cbi->use, 0, rte_memory_order_relaxed);
 }
 
 /*
-- 
2.43.0

