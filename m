Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47566606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fz6Sssqp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC92040E15;
	Thu, 12 Nov 2026 16:44:08 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 3079040682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:44:07 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-53397554beaso41504251cf.3
 for <dev@dpdk.org>; Thu, 12 Nov 2026 07:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794498246; x=1795103046; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JDRMmQOUH2uo2GV/hVLwdabquy5Y2rZQovb5BQ6og74=;
 b=Fz6SssqpfuWqcbhdVaaI/dFJFS4waRENDiZd8k6E7Wie8rbb0kafG28SS64PDz+HOr
 r2aDGZclPYMx+baWvKLm4qgObQAAxqyOmOP1wPQh53t4eJVIJTzGjbcV/EDoLv3NUHQd
 lYtvVdKhRkSM2QMoujrcLT47b1At47FAOR+CTXjFn03i8CRUFFuDBYtzqAgzwUb4PVUU
 7nQLPkDJ0DxioTdkOzTWV7HQnCGlYfjY5NEOp8AjiW480tcEHzu+e2ihTGhMamyOdeQ3
 S2EWrvcwCNjZxyuhkQtWJRU0ly+aLCrEU4BIX9ovEJk32HKwuLbzcd4wnLj7Sk8tGs7l
 c01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794498246; x=1795103046;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JDRMmQOUH2uo2GV/hVLwdabquy5Y2rZQovb5BQ6og74=;
 b=xE3gUfZgAGVw9TkCfso0E2aX5xs62vFwMZBNptl+mgOl9D4UpOfmevMCWsWPaGY8fA
 51yYf4Pm033uYCz5Xmmo56/sUS0EOMoAo4pznpOrrGtdCUYEnMm6cWQN8ohFUfYDW2S3
 D29DDIMeyWb/P/V3g6BWUdEdvgWXqFRv8A9ncat1oNfME3+ZwaXTlBwP9T2utOiCojpl
 iyRJKcBHb+guXWcaqv0UCI8i4nMivS/sKFVkVvPvA0UgkNFHN0xn0w/UjQa1Bt7MaRG4
 A4XGlRPDjw/4r9nbtvHYBSdirT5V7MfTQiBX8hgchx1TQZKtlFcsKTTh0JmUxy0/IZpk
 pWeQ==
X-Gm-Message-State: APuU4Z8uTkrSdb6tRGvJrRRwjzSR+gBEorIX0dmU+hLhky0/dperrW5t
 gB/lqaC+JccTC48x8vli9OsyeySQL2WHSApJq3w2/pR/EqWFtY5z34PHTv7waalv
X-Gm-Gg: AYBFou3MeJqm01QwtO+DLDnbhEQXybuVkA8+I52Yx680Ojven94xjQeDUBg5LiKsU0A
 V14GdvukVDfOcD2Q/PKSO9QsFuiIJTutRaoahXAs8u8LvBfYZ4xyCjElnpFEa87bBN0LpFb7yFP
 KrM3Xjl+K+GZFMDU4/r+KuPFkjQrzqUAs09HGVoUVf5NaT9bI5bnm3iHni7XLOTwKYPECrcCr3s
 S0zOEqrQPZaQ4bt1QQ4S1oVHcApBiicK/qxwe1fs8YrhiEEWTydv4bpNbnoftYrqqmldCMtgI90
 +Rezkr+rZ+Y4+LLXchnCLV1Pza61etbO9c7kvXOs+B4GJls3o198zidjZslGFfsNOBSoPI9ioPz
 mRCgmHBAYQn5aFla0/6GboNTuyju18VGH8B2sTnlYEXsjBVUYk57KudIsVvxAb+Wp9boP5kJ7qZ
 G3wrdYqN8Y5r7ltXrZSWCap776iQWkBiaHoCAXxmAvcMlf+UH7N+Difeucx6R6YvuzexaPS9ETz
 IDNrdX1iyJ8/nwTqPFezx2qDSE+lmYUCNOyNbH+JfQlmXNal2y76Wq+flkFcWqZ/gh8fpWfMfS7
 AIx4e9lRVfHg0apRPfKYanFC7GQnCGI7qlgF3+wDk1qMICnt7vM0h3ZvqTkkqXgZUrzyJ7ycNVZ
 byQr4+z5UxiV0gZwGNeHFelBQ4UR7HNSGNftFhIlOKFxgBVk2BGfUmZ53dSS5bALu+YERtB9ndy
 U=
X-Received: by 2002:a05:622a:411:b0:536:35e1:b5 with SMTP id
 d75a77b69052e-556bdbe9abcmr102990971cf.1.1794498245925; 
 Thu, 12 Nov 2026 07:44:05 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f02df714csm50400586d6.28.2026.11.12.07.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:44:04 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v4 0/3] mempool: fix races between list walk and create/free
Date: Thu, 12 Nov 2026 10:43:39 -0500
Message-Id: <20261112154342.1484709-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109144054.3784583-1-rsanford2@gmail.com>
References: <20261109144054.3784583-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

A thread walking the mempool list with rte_mempool_walk(),
rte_mempool_lookup() or rte_mempool_list_dump() can crash while other
threads create and free mempools. We hit this in production, in a
process that walks the mempools while other threads create and free
them.

There are two races:

- rte_mempool_free() unlinks and frees the list entry without the
  mempool list lock that the walkers hold, so a walker can reach a
  freed entry or mempool. Patch 1 takes the lock in rte_mempool_free(),
  as rte_mempool_create_empty() already does. A rte_mempool_walk()
  callback can therefore no longer free a mempool; this is documented.

- A mempool is on the list before its store exists, but
  rte_mempool_dump() queries the mempool driver, which reads the store.
  So rte_mempool_list_dump() and the telemetry /mempool/info handler
  crash on such a mempool. Patch 2 adds rte_mempool_is_created(),
  makes them report the mempool without querying the driver until it
  returns true, and documents that rte_mempool_walk() callbacks must
  check it before querying the driver.

Patch 3 adds a test to mempool_autotest. On x86 with 4 or 8 lcores,
it crashed in all 20 runs without patch 1, without patch 2, or
without both, and passed in all 20 runs with both patches.

v4:
- Patch 3, as suggested by Morten Brørup: the dump goes to "NUL" instead
  of "/dev/null" on Windows. Acked-by added.
- Rebased on main.
- Patches 1 and 2: unchanged.

v3:
- Patch 2, as suggested by Morten Brørup: the helper that tests
  RTE_MEMPOOL_F_POOL_CREATED is now the public function
  rte_mempool_is_created(), and the rte_mempool_walk() documentation
  refers to it instead of the flag. Release note added. Acked-by added.
- Patch 3: the walk callback uses rte_mempool_is_created().
- Patch 1: unchanged.

v2:
- Patch 2 reworked as suggested by Morten Brørup: rte_mempool_walk()
  no longer skips mempools that are not populated yet. Instead,
  rte_mempool_dump() and the telemetry callback report them without
  querying the mempool driver, and the rte_mempool_walk() documentation
  asks callbacks to check RTE_MEMPOOL_F_POOL_CREATED. The flag is now
  set and tested with release/acquire atomics instead of plain accesses
  with fences. New title.
- Patch 3: the walk callback dumps every mempool, and checks the flag
  before querying the driver. The test waits 100 us instead of 10 us
  before populating, so that it still finds unpopulated mempools
  reliably.
- Patch 1: unchanged, Reviewed-by added.

Robert Sanford (3):
  mempool: fix race between list walk and free
  mempool: fix dump of unpopulated pool
  test/mempool: add list walk race test

 app/test/test_mempool.c                | 150 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   7 ++
 lib/mempool/rte_mempool.c              |  45 +++++++-
 lib/mempool/rte_mempool.h              |  29 +++++
 4 files changed, 227 insertions(+), 4 deletions(-)

-- 
2.34.1

