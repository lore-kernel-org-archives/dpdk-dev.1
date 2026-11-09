Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57B606A323
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAjH09k9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B80F4026E;
	Mon,  9 Nov 2026 15:41:20 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 609E24025A
 for <dev@dpdk.org>; Mon,  9 Nov 2026 15:41:18 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-91eb53957cbso13255826d6.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 06:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794235277; x=1794840077; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4vYKPE7e/nozYBfCKcKVFmKxTOQiQtozhdwKVk8dEaE=;
 b=lAjH09k9zLsdap85O6SYgUMGac8gjyGjx4ZCOhVP1s2kzmPpPmavIn5DGRllhYvw4i
 ziKt/0HKElY0I94p8nf/GyYvLlh5GS1AXxlDV/73sC9k9BcaIMKSWIcm1yqWyzC3yPN5
 SkD7X/fmEiwAfryINKwIFgNM4t/zIt+vPcD+HHusbCHnOj7SkNyyB3MthJ6BPyOk51LX
 oS2n5L51JJJLMl1ecMwOsekI3Y9bfaUok9lmvng4GBZahh33sh6w7pTIS7m/xR31Wqac
 t7qaSDPJrbtHZNPzPQGu4S5aeEDXWHy4EVhIr9ymeft42b5HmT7beiox1sVMWadLUA7p
 +DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794235277; x=1794840077;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4vYKPE7e/nozYBfCKcKVFmKxTOQiQtozhdwKVk8dEaE=;
 b=kSqPrj4W3j94JNQdfXMjhcisY0Nc4/slJNmc86ziLuzCMG+de/YJddOcIZHo9a6FK1
 kdEU9XNJz6F7r9KJ964SEyLyVeDLb3FgZEg3Z6v2bPVYRhMK94vV8BDOt3Ss0GeW5r2t
 7u7yF0nr5FKy5wy/PxoUdFXH4rlEEwEAfbwURc+Vhdx409IL23+e0uf72QSq5zdo5HDf
 ODGIXFsBTCSxGS51EsrZ6NVNdy71l7XZ+VhvxQwchUrEC2H7054UkacVCDdj6yZWKCjk
 In9idCEdXjPXDLlCgoBXM+esZylb9TPsHhi5tBdGlGsTFnbVbAo5PDAYV2F2o1PM9X4G
 lpQw==
X-Gm-Message-State: APuU4Z9RALDhN6Rj66xjQf25EhRgpXU/oQkXXBPmb2L1NDcLgk7CzCyT
 UItNzjZ/7SfQFJdRHNElend0CX5Hb5rV/xxmmR0LmV6LiwGkqiFkhiRQnAkzjja9
X-Gm-Gg: AYBFou1u5CbmPk5cXoi+07j8nhWsiP508YlJtM4d0n0iA3pk7L2WCMw4G3QVaJNnoa3
 1T1D1eMvXOjixM1pCBl2NIqP5ro5BxQOh7gKXyWqScJhfCmFXn/mmokMmV2rRZNl/ndILT4Op2B
 IkdTQYdmDNIdLmAm8K2gCJem+CBBiD9xlnC5ucVKfgAOKB1oYbFqc83+WAalzNf5tfVJ+ksdOOP
 mxDdjvXJDMxz0mABQ6GdDtA8627FMMtAQRQRUG/kPZ81lxk6d3tK30KwZKOBQxjnzXlSP2w3wM+
 Bym7Ar7am93XlJsQAb+MJiLOLg7QBNKjcGBAYI69zBbCrOtyIedFQU+vLUpbnU62WryySwnsCaV
 KseQ4j2CG7szh/5BHMfaDEuRaEYgPLTKa2eTYpsQSRBcUwubvuCLGldgiIiNP5fYyQg4KiLlJu5
 9d7kiDiDF1M/qIO815AhWVisgMPCQb0hTW0I+ftCIDLe81QTI8oNnn4vTqbeTw/u7kmuccCqvAy
 KznQbNGZ3dk6qDu6ufu5br3f9bG5l4x/2JIzm8i51D9Npf7rsZmPy5BqrGxkpDQKpAJsniC0AxM
 rzVg4L8YqcEslRHyYMGkdF+bLRFH2w+Pdfoi/xYtb/B9NtsGIMXCxktiYwgOeKL/bvmjzPu6SIu
 ixZ7nlD+efzUJ8h3eGMxzhs9CCVlVU4XlWScDn6+2yi5RFt2HlvjH3+xqYhpeUoR6ah/sT9nf+C
 s=
X-Received: by 2002:a05:6214:f27:b0:91e:887f:8bf1 with SMTP id
 6a1803df08f44-91ed248b8d4mr60639706d6.33.1794235277060; 
 Mon, 09 Nov 2026 06:41:17 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91eceed448dsm43579846d6.45.2026.11.09.06.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:41:15 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v3 0/3] mempool: fix races between list walk and create/free
Date: Mon,  9 Nov 2026 09:40:51 -0500
Message-Id: <20261109144054.3784583-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103173543.130142-1-rsanford2@gmail.com>
References: <20261103173543.130142-1-rsanford2@gmail.com>
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

 app/test/test_mempool.c                | 144 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   7 ++
 lib/mempool/rte_mempool.c              |  45 +++++++-
 lib/mempool/rte_mempool.h              |  29 +++++
 4 files changed, 221 insertions(+), 4 deletions(-)

-- 
2.34.1

