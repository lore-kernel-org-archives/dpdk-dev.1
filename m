Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A9606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rPMjQlL3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BC664025A;
	Tue, 27 Oct 2026 15:54:28 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 2D5D0400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 15:54:27 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-91c7a0c1617so2872966d6.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793112866; x=1793717666; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pdmt7jx/AHtYO04J/M724buq4qU/T5L1Rn9O2PTeaX4=;
 b=rPMjQlL3F1jkyXMV9J9GedIy38+NVkTtl80yKDwsfsrDBK1E9t5qhpPfPS/5cjcM8w
 uBrMdMvVQ2PG0J40dr9m3ZvxJOoZEeBoQRyaLXJakEWWb61HysOro99sEf1cyZagx2sI
 9ht8XgDMB5oNGZ2VPeHxNfB55n7KZViyQeRdyvX30C0bhetlQ7dnEqBCMwLmsXgBF9R/
 5lKprDu7parpHEvhxowWqCsLYawMzr+zfkk/kzcZJrc9laVuMr75fv4DzFB1D3lviPqG
 5KeE0XHOCeLikYt7QGaQOZNsVNkkPD+tftEYkNf5K7sn36LULsAghS/Y3mNmmW4JX9BT
 qIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112866; x=1793717666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pdmt7jx/AHtYO04J/M724buq4qU/T5L1Rn9O2PTeaX4=;
 b=mU/1NmNiKK/AyI+TwG9V/OqpXdxTJjonAplnn9NlQ737Wvet3P+JJSoSrxaWpjR2Eb
 AMW82Xa4k/4mgZgDLlJbyTM6l0C4x/aqAkvNKV38Tu8DiUHkUC9CohhmmNOCe3VvmDyt
 pNsRMg1bus0vID+sfLiOnpmfn8+zgK2TOf9fouIWsU1WQ/N4EaCQImLNyIW/42bwdlFn
 sCWwac0h0pKN5DknJoN2p4LpKK11NMkgaVG9SMW84ujO8royK1yxM2P51oJqI+xWNEZI
 i+STrwASDdHabNyewkLffDXojCCsBHMBJ03bSK5v2qHiyTEGUhMUgknje6ykB/+R3HnD
 pa1A==
X-Gm-Message-State: AFq9FYKECEveMNPNccDEgnxnRPZXzXsx2fPuJb2TyUbP/fxuk1h1bvXB
 tFbDvRRCvKgHqDL7vS/CHe3NWbzerscWBPSuuOi8lf8A9PBzVTUcVR1O+DXEnw==
X-Gm-Gg: AYBFou0G3KLHwCFfMBSFIfJWvqrFEczmEo7xNWxUND0TuGI4kOq2C++S/iL/+KzkLDI
 YlLoeCPo8YyejQZn3VUzed0VkcpQ4wLlGQOyFhZDs1sbTHnp/j2qH1qYweObBJbgpFSlP2Betn7
 e+cRjNr5WX93dVIpTXsr9JFYxzkVCrCk02ZGoluYjGhX6LdVYwdfKS+tvMNehWMJcf47nQcM0/E
 46cfzQdgDRRx3BngCyXZ/gfLsURnCLOjVt/LQw7XM3ISDLoiTClVHNOnhQOYH9Oop95yf2fh/kt
 NcTE8Lo96wobmZA3AzEP85xpyVkmkI7Mz59/OnfFyc2k+sMQSuOJkEmJDtwZAN80lmZf8LZFl50
 u5ASwbBKeySphm6uqSfDoA7gTzeiW/GfBjFML1/n4hK0AqTSyZQOh3Z9I1Qe6bLijLAtIJOAmmF
 mcXQjtfgx1azwDzHYr/pLH6xSD6yV4mb0hMMd2rRi79nLhwex0RC/kJAzScWFTz+xrlsj2gQFLT
 kwx8gOSJsFSED1qTFLFL3vlr3bafxYQFdzMIirz65nCZjAEp28z8xcMd3nFi+7O3LSPSKlOiSaI
 KmPkywslWpaJnjSgHyrsUKWxhnBpuQUmMzlBvyPk0sXm3hLAKe/qARG16Rooi531D/oYPbwFHbD
 hlXvTm4Fj0RtgACEa50nI7NCoqrRP
X-Received: by 2002:a05:620a:3726:b0:93e:fa30:f1da with SMTP id
 af79cd13be357-940ef8f3bfemr1469354985a.45.1793112866022; 
 Tue, 27 Oct 2026 07:54:26 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0789b18sm996910385a.29.2026.10.27.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:54:25 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v2 0/5] fib: fix full table overwrite on address wraparound
Date: Tue, 27 Oct 2026 10:54:00 -0400
Message-Id: <20261027145405.3454251-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027001423.3028072-1-rsanford2@gmail.com>
References: <20261027001423.3028072-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

Both FIB dataplanes can overwrite their entire lookup table when a
prefix whose range ends at the top of the address space is added,
deleted, or has its next hop changed, while more-specific routes cover
its range up to that point. The call returns 0, so the corruption is
silent.

One real-world trigger is a default route coexisting with explicit /1
routes: with 0.0.0.0/0, 0.0.0.0/1 and 128.0.0.0/1 installed, deleting
0.0.0.0/0 makes every lookup miss. IPv6 behaves the same with ::/0,
::/1 and 8000::/1.

In modify_fib() (dir24_8.c) and modify_dp() (trie.c), the branch that
skips a route starting exactly at the current left edge has no
wraparound check, while the branch that installs a gap does. Patches 2
and 3 add the missing check. Patches 4 and 5 add unit tests that fail
without the fixes and pass with them.

Patch 1 fixes undefined behavior in rte_rib.c that the new IPv4 test
reaches: its bit test computes 1 << 31 on a signed int for nodes at
depth 0. No existing test adds a depth-0 route.

v2:
- Add patch 1. The CI UBSan build reported the undefined behavior in
  rte_rib.c when running the v1 test/fib wraparound test.
- Patches 2-5 are unchanged from v1.

Robert Sanford (5):
  rib: fix undefined behavior in bit test
  fib: fix full table overwrite on address wraparound
  fib6: fix full table overwrite on address wraparound
  test/fib: reproduce table overwrite on address wraparound
  test/fib6: reproduce table overwrite on address wraparound

 app/test/test_fib.c  |  94 +++++++++++++++++++++++++++++++++++++++
 app/test/test_fib6.c | 103 +++++++++++++++++++++++++++++++++++++++++++
 lib/fib/dir24_8.c    |   6 +++
 lib/fib/trie.c       |   6 +++
 lib/rib/rte_rib.c    |   8 ++--
 5 files changed, 213 insertions(+), 4 deletions(-)

-- 
2.34.1

