Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD4606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tC7mnwsv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F81D4028B;
	Tue,  3 Nov 2026 02:11:15 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D40540278
 for <dev@dpdk.org>; Tue,  3 Nov 2026 02:11:14 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-91c6ce60697so53099696d6.3
 for <dev@dpdk.org>; Mon, 02 Nov 2026 17:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793668273; x=1794273073; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V+D2L+W2jX2iTYBllEg+GxjxSpmn9b7F3MTQ28ISjDE=;
 b=tC7mnwsvJds6QAdzkrZ57uQNx6qN+HAsWccMZLvFZm1YX4a7Kjlp0XAbVLjv+ZnWsM
 pMu/P4IMw2X2U6e9nD3ZpFeMwogv3kwZuzw63ssH29kG6b5o7ASssEvu+C/OnmMHP+5W
 j8DKVxtVDp3hsfH9nt5M5dgiazfck/gg1cJ0oXNW8fKo1ThuY6x++Bqi5SNEpyWjtLVi
 HYcZB60fzVOXlcLe32oivL9wmOGG0qYkojOixHxQtvjEnz/l+fhINLfr2jqHTQofuJGU
 9RXJjLNbJXVS17unffsuxAKbEd0+ZrahD/2QjmZwXFG9yDI5EoGN56Ym/l+4ZDzfrVZ1
 gz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793668273; x=1794273073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V+D2L+W2jX2iTYBllEg+GxjxSpmn9b7F3MTQ28ISjDE=;
 b=oWGNtEE5KzbHFo/TK4S+lMsGMRxIWFJJ174G5psKvhE0cBE7FHDAzaI+SWM8k7LySz
 TyGmVJ0/TRka8pCYPTPIPEZAm+QLIISd2GOe1HvAUNJtxZqivY9TFcuo8jLaPIcUVvIp
 PNJCSq5XAZZO/y+St48GKQ5e+EbWsMC7eeveF7EwAIm0XyD9iYNOrljQUa1lKt9OFepe
 kZODXoM2syj+UfY+Mdhn9Jn2PDHX5F0aQX0jGIX4Ch4bLfBlFhHpcXSViWVOE31jPvkA
 YRNJ6z5j9VzavJW2DMk8srzzOcB8hlB3HTg1gLAc0XvwHM2UcZYS2k3WFHx5zuvci886
 c0Yg==
X-Gm-Message-State: APuU4Z/ipxFpttDNoP+JIZVdMKhRwBfNKvM6ZYm0ZSLhcAldwhu0vj16
 tzDk6KzEBt0b00xiwlgOAsolvDpWxA6aD/EGaZUeeu0hRfulbHN52zbEu6uWBt66
X-Gm-Gg: AYBFou3ol7KBjZYo0Cdb7AIpCsmuWG58zU49n0ckhong9W6Mjuu4VST4h73iCTnlzMg
 Pxk1r3xvA9nDyTbqiAr5VAmLFLYlGAYV6mXSao3pR4eZerhliAjmTWZjDy1lQXZ97qpiIGbbT6m
 spK+3yRHeACaFgMhP79I377k9oBE0cgHjZNuAEsuu2pUlIkrSCR5t/xXpKC9TUaADUlUTexpPdD
 EEt7CxIUk6nFbC3e7gN8JnGs419LvkC7LbZAYu28u9VWwjjyK4QtfNLLL1C7gdcAh1h2FHehNiF
 ziGqA/RyEvNqSyKJqDh9EwGNmPBUGK/02lKtgxwTHNnD6sMeMevsyfJpL02s4sNzm21NlVF6/65
 5LseLbzRmFXkChq32krfhXH8Q4HuKk4RHTXTFf4oubzQqMaeLZJtBfd8co4w9o7vWllFkYdTPxo
 Mj117td5bVAPN6hzCZ7I3Cc99wamjDvDwSpIpS5KmKvz4PfsmDqwjJ4BiKfQ1jkU7Rja6r2/pKe
 vZFKx66RASf9v/rRyCDDxKFYpJ7G8mAJ8yvpOCD2KIKcoYehgGtljvKLV8OH2oEUQosVvE9CJlr
 cuEFWFFvbTccDmqIwF2IrHNkXZ0IANCyQDyTEJnhD8+xWPNKh5jiP3nfEQdTLdHTBXSccKBtipc
 JSmmppVV3FoEEJkW6O+ECzxzQGwv2OgFFy554aPe1xcy1YYEC6m+iHnBc4gzDB2T0tVsBbhswv8
 1dSA==
X-Received: by 2002:a0c:f20a:0:b0:91c:7701:4d5d with SMTP id
 6a1803df08f44-91ca4b4c7cemr191422546d6.37.1793668273170; 
 Mon, 02 Nov 2026 17:11:13 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7e2749asm103788266d6.1.2026.11.02.17.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 17:11:12 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v1 0/3] mempool: fix races between list walk and create/free
Date: Mon,  2 Nov 2026 20:11:04 -0500
Message-Id: <20261103011107.3658840-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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

- A mempool is on the list before its store exists, and walking or
  dumping it reads the store. Patch 2 skips mempools without
  RTE_MEMPOOL_F_POOL_CREATED in rte_mempool_walk() and
  rte_mempool_list_dump(). The release/acquire fences it adds generate
  no instructions on x86.

Patch 3 adds a test to mempool_autotest. On x86 with 4 or 8 lcores,
it crashed in all 20 runs without patch 1, without patch 2, or
without both, and passed in all 20 runs with both patches.

Robert Sanford (3):
  mempool: fix race between list walk and free
  mempool: skip unpopulated pools in walk and dump
  test/mempool: add list walk race test

 app/test/test_mempool.c   | 137 ++++++++++++++++++++++++++++++++++++++
 lib/mempool/rte_mempool.c |  28 +++++++-
 lib/mempool/rte_mempool.h |   6 ++
 3 files changed, 170 insertions(+), 1 deletion(-)

-- 
2.34.1

