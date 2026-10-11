Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC95CCA9ECF
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:23:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 710834064E;
	Sun, 11 Oct 2026 20:23:01 +0200 (CEST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id 4AE004026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:22:59 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso1811852a12.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742979; x=1792347779; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+qROW/oljihVOl0xT+vNC2n82LSP6A3Plgbl+ovKzw=;
 b=IOs0xo90KRJzwlgFAJ4Q3mGNwf5xhzmbKJgNp3k8kUlRoXQy8wua6Dh5ClN2qX5PCf
 s4Z+FQScWB4whLBwx2g37pg72CT1sBygoO3T4EIcfM7zjpJ3gBmqSJ8xKfw6Pwfsl6iS
 uvGU5s3miisjbFFGX+A2WXRMeQUElndR2NY0xvUgU+j0u4QE9JQDTUccGHpEtNu2mU8X
 rtao8w5lDeet9pa9oiedoCrrpEKEUUg7itYiBp1yefsPQYRJ0Z12LqLXZ/9UU32r48fa
 az57W80YO8fgR4w3frD8iUo4gU9RYAVov63Tqwg0sTW4aOxZFp6/ILER8oMGe7CT0oVg
 HtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742979; x=1792347779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F+qROW/oljihVOl0xT+vNC2n82LSP6A3Plgbl+ovKzw=;
 b=jjug12CTtn8VjKOb5z/CeesxPXPhkPzQmO3B5RvP3ylbO9js2bQhQilgMZyfGKJ4K0
 5RNB+uSf6mVPbopRjOekVMpgGum4qvcMWuvREho40q93A3x8DWNWUXKFoSIsXBEtyZJL
 /GeHcFHXfD1Nl2dQChV4IJ+NtW1MGvKQn62D7IUullckV3RzZs2REz/XX4iGFI+pADzn
 dnqXgt4Ur1ZefSi3JCVuoW/2GodghLtakamCQRK5U1vOb3LlryuNr2ABijcmUnqT8hzj
 sYt3O4x7xCr3BLDmS5RmUBDJ42fX5JhvvqbVnyyy0Q2wNETIdmQo9dSQkFieB2KZPQWG
 mF/w==
X-Gm-Message-State: AFq9FYIzCGIG7dNVyl9RqnaPRWpUmHA5b8bWNAb45HIH1nsOhcnqyt1D
 8q6cvx7H2DS3IFuOnU9zUJad5ZPT79rqLUE029Mch6b+5U2H9dJsD+8GhQ8Dal+uAV0=
X-Gm-Gg: AYBFou0Bxys7YX3DKisdqLkfSBq2XmaE2p4drxdirraqOfvUoMxjSzXY4aTscrcrlNW
 5x1SALJ40H2N43o7SoK96W/uDQ1M3f6sXwM3drUaAxNlSKynM8UlBagvruio2718RMS33dNqzAS
 zveqq3dpX0QY44PEPqmxTziG0sZBPZdR486skO7Yrr1JYXuyWOsJon1/QLMlPhYih0mP/KJWP09
 S8mVp9+j7o1zJLKottI4k44z6tDgvd6YbDHJ16icshijIXNd+efiyMCofZcI4mOtzL1gNeyH71h
 khyum1ycLZ3Q+ieZLh8/NnTx9/ElZcoB5RMJHpP+OLmz2baeh4UCX8dkKKP1pxpEIkjx102ReFC
 fvlMTxyrJ10XukmXPgesU9mHYSlT8pyCqpAZQrvgKtz2IxWHpvLgoD68p8NaGDpif7kBHCyyAFS
 +3RY8ffIIB+/x2rVqEli0wW55lYrX/RRpOr7d+0JNlaxZgnQ8mAvFI1QINEGM=
X-Received: by 2002:a05:6402:354a:b0:6b1:ba86:5f43 with SMTP id
 4fb4d7f45d1cf-6b1ba86638bmr1417303a12.19.1791742978763; 
 Sun, 11 Oct 2026 11:22:58 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:22:57 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH 5/9] bpf: remove redundant memory barrier on unload
Date: Sun, 11 Oct 2026 18:21:53 +0000
Message-ID: <20261011182158.124246-6-qm2k21@gmail.com>
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

In bpf_eth_cbi_unload(), rte_smp_mb() was called immediately before
bpf_eth_cbi_wait(), which itself starts with rte_smp_mb().

Remove the redundant rte_smp_mb() call from bpf_eth_cbi_unload() and
update the unload sequence diagram accordingly.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 7ee16cfa69..68671848e9 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -62,8 +62,6 @@
  *     |                      |               |              |              |                |
  *   rte_smp_mb()             |               |              |              |                |
  *     |                      |               |              |              |                |
- *   rte_smp_mb()             |               |              |              |                |
- *     |                      |               |              |              |                |
  *     +-if use is odd        |               |              |              | if cb not NULL-+
  *     | |                    |               |              |              |              | |
  *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
@@ -502,7 +500,6 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
 	bc->cb = NULL;
-	rte_smp_mb();
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
-- 
2.43.0

