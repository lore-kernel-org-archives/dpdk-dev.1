Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D08606A329
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZW5aRaU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 700B140297;
	Tue, 24 Nov 2026 19:03:21 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mails.dpdk.org (Postfix) with ESMTPS id CC8F84027A
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:19 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so43128195e9.1
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543399; x=1796148199; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qchqujfmb11VH3SxB9wlfXJ/qSsvU/6EEbvKZKYTIis=;
 b=LZW5aRaUoG6KXsc578PxsSiXklwbwREM0YWP/q9oOWlTYrLQj3XsOWiCWfmbgizHTz
 X77/9I85nhXvxRnQsuEXN33K31h9/OpMbzx+qO+/LWRZIPLgaa+Xn7GH5hCuywR5D9jY
 uQULD3eZMJDAqW4uOM1gtcT2BxTXIXk8AGtHV3uyPiiLI5CdtS17Yj56ieMQxM0kEMDs
 gaGQCa0pzUhO8Mx/LYCvUrZMWBr25JSkABkUaITPHdi30uZYImN+OHKYwmScDCHIj3Wt
 oGv1BIKNLwfuD8esBoQIoE1T8S2pN6/u4JGePci6H6cnOZ5iN4KVS7vCaQZ7mq/QyXBx
 luIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543399; x=1796148199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qchqujfmb11VH3SxB9wlfXJ/qSsvU/6EEbvKZKYTIis=;
 b=c6A2fz932UDUW5scLeooWq3EmI/gnri9W4mhHStKcO5wu2q3hFIbb7c2BWIIN7vgw3
 GXZbQJ3S9qCpLDb6XwBBnOeLIIkKnVqC4Qmy7cDUvYaK2fr9Ynx65TTmwVXNPHz6o69J
 kqVcnaRMdhTryftkt67bFte8Dlka5BlsJFNVEVMfYLgg3ryKMoVoTUZwgX2sqJGIcIDr
 oGNrvn806SWM5J2mXPpYycmh+qBDPo60TwpxSRK37Dv4xzz1+dLCdp7IWCO7HcGSEgXQ
 YwMSvxVdmwS1vhhSd4WrVkGpVgj3/KC9MoCFH10LUEO5JrN7xZodQRyj2Zn2oyC0VT5Z
 Waqg==
X-Gm-Message-State: APuU4Z8IaZ1BPzl2Iy56QSUW9qtQH7K2nvbrmYQB9m8LHo8VFi5PiVkV
 HyYBcTdhyeoeqyn+KdTyozK0kxNkReZ21ijfGI3NtRib6vS1VOETEzmy
X-Gm-Gg: AZFdTZdW1jnaZsdWVg2HfvEBfv6TkixQZaGBHf3Z5n9exO49RCST6jzfOXfhw6vL44X
 HL1Jj+aodBGrqCBr8Nde77LxCoMVdI0dawwHB4ULsS3w0cDf8tXfGaMQJJu31SBidlbIUjIcQ9Q
 LiYoyV1Kv+06vFIEF64E8Rq00yfqR0qWB2nzni59Nn0gEs257UpIHktSjN3vSKIG12Xh1Vmh+Ao
 ZXBRVVuNYfGYz/Q/BET2CMNk5TexchgJBm1GprQ1rwLn0N+ds8eYSVB8UhEkFacisxCyynExAWl
 20J4+WD3OrmkE4xNwm2w4zYS6nb35CCWV4rV4n+cfkROcPR6y7wtJU+CuCQ7vZdcl91dGE2RXw4
 84n7t1+4h15qUu6QThQl21P7h8LxwfEt7Mor/U0439At8APy74D0vqgeI3jt7IXh+ZkxIV65hIP
 3FsKJd85S811xoPAP5IooU7+n8gadDrZyznbML9mJ+EzEbt7ZVk4BNJ9rNIaySsI8/WK/NfVQS/
 +W5Jy7XARascYCIpX0hEZ/HQnH5U0Abn9jk+oM61DXZC+ffvyYr78JzKSlxFktEVIqbgwTeVZ02
 EyiWElXDQUidyrOnKERhGyx0ulR62sFZI4X7x82pPvFqdZGoh3kJUql7Bbm3exUea+LNqBMrU/R
 J/EW7nA==
X-Received: by 2002:a05:600c:a05:b0:4bb:5e6b:49e with SMTP id
 5b1f17b1804b1-4bb88807c0fmr313926765e9.6.1795543399061; 
 Tue, 24 Nov 2026 10:03:19 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895f7bc1sm170923975e9.3.2026.11.24.10.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:18 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 00/13] fib: shared and resizable tbl8 pool
Date: Tue, 24 Nov 2026 19:02:36 +0100
Message-ID: <20261124180249.1099506-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331214117.142495-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This RFC proposes an optional tbl8 pool shared by several FIBs, for
applications that keep one FIB per VRF.

num_tbl8 is hard to size: only routes longer than /24 use tbl8 groups,
nested routes share them, and the need changes with the routes learned
at runtime. With one FIB per VRF, each FIB has to be sized for its
worst case. A shared pool lets the FIBs draw from the same groups, and
a resizable pool removes the need to guess the peak.

v1: https://mails.dpdk.org/archives/dev/2026-March/335512.html

Changes since v1:
- Rebased on 26.11-rc4, on top of the trie fixes for bug 1970
  (reservation with the RCU defer queue, no temporary tbl8).
- The pool never grows while an update holds a pointer into the tbl8
  array: this fixes the use-after-free reported on v1.
- The tbl8 reservation is counted in the pool: the groups reserved by
  the routes of one FIB can not be taken by another one, and freeing a
  FIB returns its groups and its reservation to the pool.
- When the pool runs out of groups, the RCU defer queues of all its
  FIBs are reclaimed.
- dir24_8 uses a stack of free groups in its own patch; num_tbl8 is no
  longer rounded up to a multiple of 64.
- The pool is documented in the guide and the API index, and covered
  by tests for growth and sharing.
- Callers filling rte_fib_conf or rte_fib6_conf field by field now
  zero-initialize it.

The first patches (zero initialization of the configs, dir24_8 stack
conversion, shared tbl8 definitions) do not depend on the pool and can
be applied on their own.

Patches 2-3 (zero initialization of the FIB configs in app/graph and
node) are the same in the RFC for a lookup across a group of FIBs. The
two series touch the same place of dir24_8.c, so the second one
applied needs a rebase.

Open questions:
- ABI: the tbl8_pool field extends struct rte_fib_conf (40 to 48
  bytes, flags moves) and struct rte_fib6_conf (32 to 40 bytes), so the
  ABI check of the CI will fail. Keep the field for 27.11, or attach a
  pool to a FIB with a new experimental call?
- Public API: v1 review suggested keeping the pool internal to the
  library. An application with one FIB per VRF then has no way to
  share tbl8 groups between its FIBs, which is the use case of this
  series.
- With a shared pool in defer queue mode, rte_fib_free() and
  rte_fib6_free() wait for the readers, so that the groups waiting in
  the queue of the FIB return to the pool.
- Already in main: a group freed while the RCU defer queue is full is
  lost ("Failed to push QSBR FIFO"). With a shared pool it is lost for
  all its FIBs.

A bulk lookup across a group of FIBs, for bursts mixing VRFs, is
proposed in a separate RFC.

Maxime Leroy (13):
  test/fib6: zero-initialize config struct
  app/graph: zero-initialize FIB config structs
  node: zero-initialize FIB config structs
  examples/l3fwd: zero-initialize FIB6 config struct
  fib: use a stack of free tbl8 groups for IPv4
  fib: share tbl8 definitions between fib and fib6
  fib: add shared tbl8 pool
  fib: add resizable tbl8 pool
  fib: add tbl8 pool stats API
  test/fib: cover tbl8 pool growth
  test/fib6: cover tbl8 pool growth
  test/fib: cover tbl8 pool sharing
  test/fib6: cover tbl8 pool sharing

 app/graph/l3fwd.c                 |   4 +-
 app/test/test_fib.c               | 348 ++++++++++++++++++++++++++++
 app/test/test_fib6.c              | 277 ++++++++++++++++++++++-
 app/test/test_fib6_perf.c         |   2 +-
 doc/api/doxy-api-index.md         |   3 +-
 doc/guides/prog_guide/fib_lib.rst |  40 ++++
 examples/l3fwd/l3fwd_fib.c        |   2 +-
 lib/fib/dir24_8.c                 | 272 ++++++++++------------
 lib/fib/dir24_8.h                 |  18 +-
 lib/fib/fib_tbl8.h                |  50 ++++
 lib/fib/fib_tbl8_pool.c           | 365 ++++++++++++++++++++++++++++++
 lib/fib/fib_tbl8_pool.h           | 135 +++++++++++
 lib/fib/meson.build               |   5 +-
 lib/fib/rte_fib.h                 |   3 +
 lib/fib/rte_fib6.h                |   3 +
 lib/fib/rte_fib_tbl8_pool.h       | 159 +++++++++++++
 lib/fib/trie.c                    | 291 +++++++++++-------------
 lib/fib/trie.h                    |  16 +-
 lib/node/ip4_lookup_fib.c         |   2 +-
 lib/node/ip6_lookup_fib.c         |   2 +-
 20 files changed, 1647 insertions(+), 350 deletions(-)
 create mode 100644 lib/fib/fib_tbl8.h
 create mode 100644 lib/fib/fib_tbl8_pool.c
 create mode 100644 lib/fib/fib_tbl8_pool.h
 create mode 100644 lib/fib/rte_fib_tbl8_pool.h

-- 
2.43.0

