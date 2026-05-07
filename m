Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC60ECD3427
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 09:50:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBCD44026D;
	Thu,  7 May 2026 11:50:49 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 461774025A
 for <dev@dpdk.org>; Thu,  7 May 2026 11:50:48 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso6319915e9.0
 for <dev@dpdk.org>; Thu, 07 May 2026 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778147448; x=1778752248; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=4fHGXcXALAKQAB93lJb9QMso+m61DY28KYpvKwW498E=;
 b=OMlbB7rgPtMkeK9XE9yNLunMgSJATqhJ7sQazuCxt1LLivxxDDgFHlQkcm8k5cCWNk
 CYMW0eY5pIlC93GvmD6JCfZMU9TBNj7y7v7J4lEAiSbecq/WGC3nZL/RRJ8EC03M7sL0
 ES4mDhldr/L2Onwx5n+bjFNKIEoueyHFm9836MR1FNo2GfRqYLkt5LdAYkYwwsbFM4B7
 VanUedE7D9HsfYkjWQUZZlURwVHUmwBgN12NT614CyEYEUgObr38FBdVCm0uXZO87dGO
 vTm9spx8bu7ECE1VkvYRWMxpScsj3eM6JoB/VocPBAFALMkGc4ka/jgVjkjrO3YBBB9+
 +ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778147448; x=1778752248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fHGXcXALAKQAB93lJb9QMso+m61DY28KYpvKwW498E=;
 b=IF9s0pDcP3PtnKjxgly0eYv1FbtJT4xcFGh5/AlIS+QnyuN4gLa+N5brB82URRzQ/H
 MoAqf1NwIdPf/69a6+m+5jNqqwDBVhllVn4yqoFuw5TKkgWAdKmlb0HaXEmd01JyH9mk
 QZ62BaJvENa4flZRdgzjSRuL3MzW+M0/WqTD+Fs3oa2b39tIehHkuqQ4RJeVTDvhOz3x
 gU1juoHDAX04nosqA3NWmnSWL0CoLs37lDmU5jP5Rx+zCOYpyoYEg8HlHpUYmu9Hu5bc
 BjWfMoKs5AbTro+VVaLqzuZH+u+fEIcbmAWFYwM6GosYP0o7G5mtVCK13GMsaYcuyIPN
 A+oQ==
X-Gm-Message-State: AOJu0YwLyeSQb4bvMyDBtkGCBj2NKwipAUItMDomJAmJlFiIsqc/MnNl
 JbLHN3UeY7o7nX8J1rlkl2j9cJ79SIiwTtm4xXtJhHUAFzw1CXh+X9m6pXFrPw==
X-Gm-Gg: AeBDieu6yyJYDQjB52M3ADY5hCvH4C9CBhY/sGlh3E/HbquoM9cenIdmAXjD/vbSTJ0
 4ybhDkPoi+XuQvwuH+YVcjtT5duZlK1dOXw+1mhcTPWFHeqNzczHEwQzuGcraSNIOVxQOdubzzS
 5hKW5Llr/6+rnfrMGzIeVLfERmooopLBnKm1wo20xwcYrDjNeYODHCqfvD35d3FiMos5FQj4pu/
 NLeQ0NsKM60xxCUG9ZeM41ha+W0ksQJlQYV9nfsmRXSjMEQXLk2/8ks1mqIZpD9rjT7WMTJb5/t
 I+Wnt/lD790zbZOP+FIlUMJaYv0cAxbgv0NQ2WWmmNChT2lIe5W44+UyuHYHQPHMV2pC9DP8M7M
 eaZKRn7l7bU4vd0lMsnzJxflCEIMvoUTjdaVdkPT7iRGWVFnEFQLzrWJDkeHjPnqRLFUgjOy0IS
 QBCl4kAcgKrrWU3mhTkOtd+JsqzBO5Edcz3WKhW64fmBQj6Ra43XmJvvIyCKy981Y=
X-Received: by 2002:a05:600c:2e0c:b0:489:1c2d:211e with SMTP id
 5b1f17b1804b1-48e51e0c833mr70365975e9.5.1778147447308; 
 Thu, 07 May 2026 02:50:47 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5310930esm51981825e9.7.2026.05.07.02.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:50:46 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 0/3] fib: tbl8 reservation drift reproducer and proposed fix
Date: Thu,  7 May 2026 11:50:40 +0200
Message-ID: <cover.1778146229.git.maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
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

Asymmetric ADD/DEL sequences in FIB6 trie (a covering parent
removed between the ADD and DEL of a longer prefix) eventually
make ADD fail with -ENOSPC even when the tbl8 pool is empty.

Patch 2/3 is a small reproducer.

Root cause: rsvd_tbl8s is updated by depth_diff recomputed from
the current RIB, so increments at ADD and decrements at DEL do
not cancel when the RIB state changes in between. The counter
drifts and wraps to UINT32_MAX.

The simplest fix I could find (1/3, 3/3) is to drop rsvd_tbl8s
and use the pool counters already maintained by alloc/free:
tbl8_pool_pos in trie, cur_tbl8s in dir24_8. The DQ reclaim
inside tbl8_alloc() is moved into the pre-check.

I am not sure I understood the original intent of keeping
rsvd_tbl8s separate from the pool counters. In dir24_8 the two
mirror each other 1:1 and rsvd_tbl8s looks redundant; in trie,
depth_diff gives it a worst-case-reservation flavor but the
recomputation from the RIB is exactly what makes it drift. If
there was a deliberate reason, please point it out.

Patch 3/3 is a no-op cleanup that aligns dir24_8 with the trie
pattern.

Maxime Leroy (3):
  fib6: fix tbl8 reservation drift in trie
  test/fib6: add reproducer for tbl8 reservation drift
  fib: drop redundant tbl8 reservation counter

 app/test/test_fib6.c | 83 ++++++++++++++++++++++++++++++++++++++++++++
 lib/fib/dir24_8.c    | 31 ++++++-----------
 lib/fib/dir24_8.h    |  1 -
 lib/fib/trie.c       | 23 ++++++------
 lib/fib/trie.h       |  3 +-
 5 files changed, 104 insertions(+), 37 deletions(-)

-- 
2.43.0

