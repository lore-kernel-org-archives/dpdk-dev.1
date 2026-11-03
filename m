Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DFC606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbID9TZM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD554064E;
	Tue,  3 Nov 2026 18:36:13 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B473400D6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:36:11 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-93f20c3aaa5so466366385a.2
 for <dev@dpdk.org>; Tue, 03 Nov 2026 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793727370; x=1794332170; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2CVoGK8uNFYwo9SIG7SP8fKFx7r7p1tZlVYqLV0tSjY=;
 b=IbID9TZMCLiwktSz7qze0yKxtm11OrKqf4+Bav9OgxW7JKjTwJbXaUbSTJAq2eCSMj
 SqsJMRJgD1UtAl7iNelFaWEriSFTFo1h06NyNFCTdyjA5YRWGCBBH3JIuekJsIFHg4u6
 3N495ve07djQxup7N7LiM17ah3DK/OufkurdUs7rWWp9A1febPm94zvKPDRF5qRE9iXS
 yevPH4Eumw13dsn51PpFQweonBGwVuvALJwn0RVR9hEFXRzCq7jGvDGxAmbL7a2qLZ/S
 vqXsFBwyD/IhIeLZ+zGSIk+1RmM4hWRFhtvz5BZxUeSDYdeeMJF2WsihOu1ksOVrpkI0
 dEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793727370; x=1794332170;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2CVoGK8uNFYwo9SIG7SP8fKFx7r7p1tZlVYqLV0tSjY=;
 b=pmohCaYG9x7cfIIl3DmKyEtpowKZW3XvUq7ymBKSkSTLOiKOLpdVt8wimU9l7XQ3N/
 pth6G+nl8GUC2fPrit9no9cqS6KDCLyFLYQmtlyieBUMVhSagbO+bDNQh4zWf+uKE5M5
 +U2GgEuG3aIwnJdZMgGL/5SED+KcqfnkRyE15WMnT4BJs1kwKg3wP8HIlXIiMlswuyFy
 IIRcQwiy+3uu+GuDp+f8szi+LbhYdiJsKh6AqnAHXx7mNv0uU5uZLcUdjMdZTqBNwleh
 GAK4SjdWuaV3jLHuxIubrXk3ynVYvhGb6DGl7099fJT+VEfoT4PbyjRBxk+78HftAyUJ
 7ZUg==
X-Gm-Message-State: APuU4Z/tctS6CBoU9ht5JgmEO89X7eLhvePGilt659u7zPm48oYY72fH
 N5/1fm4bbomlvUJYRu+E0Gqtx91vBWBhECg8DqIp44YxVnHk4BBLnrSPCDUhGi6H
X-Gm-Gg: AYBFou11zfcOx+1al9AFrs1TnFP5pNiWEIuD4CaN/xbjoMWM/68as6ZQWZTpDIJjcZs
 LhmBLqmOU8pZ1YzqplStm9pTtaj1E2uLhM7NJyirSjTuEKGvd3pzNlIpNPd+8Eo9jO/xL+vG03W
 EOjW4LyAClxm1BYcz7xoEDhyCX4QTfWMGmTgaZWX+ymCISr7rowPGdHImyvxY+0/e1hS/nOx4GA
 Xl+tAYvTzH7uDmJ1/mv/xQn1prOqfDUDMWuyY8vVEHAV5efqkHTZ64iPgbteIVC8RtSt7Pabtm2
 /BsiiqOj4fN4kGyvgVUV3/TXa6yemPfOlh0Rs9aoqrafl7IiU9qLza8JkAtliZOkN6dq8Hd4QOH
 8vwm8JMC7MHUn00CLFRCBcHLzoN7mmSMaKyuJrbA3j+1EBjEDClss8RfExwKd171LNsgS0wArEw
 n6tQjpy6D4nA2Hy/w2eoSsoHGJGWT5ANs8CNLxoooiIl2ta93lfS2omN6Tv4kCU7jdF+K1KDwep
 EZ1brkdDOpJPgi7MRcmlfxak1+wWM0pObFfH9Zh/X2ggH4spyiEMOt5rEwbdX3WYw35+lPidYSN
 l6uTa+DWAGvJ++97S8XAcuXBqEu3Jl4dPB9HMs9xH49PhgzvdY5y9zu5hMzQ1rsxWFKHO/+b+Ur
 ZvidXbwz1a2GnoSmiFTYczWRKTR2RYfaIBwgLjGYcFelpXE0AnLz6Z2DTpyf6d7azYdYYGx6Z2i
 Cl
X-Received: by 2002:a05:620a:628e:b0:93e:c12c:f148 with SMTP id
 af79cd13be357-944218308e3mr2092200685a.82.1793727370115; 
 Tue, 03 Nov 2026 09:36:10 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d33c0052sm15113385a.8.2026.11.03.09.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:36:09 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v2 0/3] mempool: fix races between list walk and create/free
Date: Tue,  3 Nov 2026 12:35:40 -0500
Message-Id: <20261103173543.130142-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103011107.3658840-1-rsanford2@gmail.com>
References: <20261103011107.3658840-1-rsanford2@gmail.com>
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
  crash on such a mempool. Patch 2 makes them report the mempool
  without querying the driver until RTE_MEMPOOL_F_POOL_CREATED is set,
  and documents that rte_mempool_walk() callbacks must check that flag
  before querying the driver.

Patch 3 adds a test to mempool_autotest. On x86 with 4 or 8 lcores,
it crashed in all 20 runs without patch 1, without patch 2, or
without both, and passed in all 20 runs with both patches.

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

 app/test/test_mempool.c   | 146 ++++++++++++++++++++++++++++++++++++++
 lib/mempool/rte_mempool.c |  44 ++++++++++--
 lib/mempool/rte_mempool.h |  12 ++++
 3 files changed, 198 insertions(+), 4 deletions(-)

-- 
2.34.1

