Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0538CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BB9D4065A;
	Fri, 22 May 2026 16:59:02 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 92AB44065A
 for <dev@dpdk.org>; Fri, 22 May 2026 16:59:01 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso16022965e9.2
 for <dev@dpdk.org>; Fri, 22 May 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779461941; x=1780066741; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4B/Xv04ZI1zxZK7rp9TvmiaX0m+8d+6pyn25plqOJ1w=;
 b=FSm5ow225q5ziXZHiwUbwPWhh2lcD28AJSDoA/p+WyDLEUErTBRY2mPzWOT9JHzS6C
 Zwg1aYs7rkS84540682nuJaif62DPnVW3CTgwz8j17aLaz7O/yvrDhQRB0QCoApMOqgS
 BjnoCIABXQE9CuwXNQNGwe3O1LJjcTKl3GCybhB2srsgYFimVactE0CmHbI0adVsnynf
 jpUFu1qCpPJQ3CWE8XOhziZxrjhfgvhuBv+bC9w42gXFF87Wc+nB80p7eOjphJsvM1qL
 ei8Spi2bzbrOTiaWCtdZdstl1eLZZMmB+fk3Cnwb/vCPDvy6l/Gz8uW+A3ljwj6ZtZc/
 ku2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779461941; x=1780066741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4B/Xv04ZI1zxZK7rp9TvmiaX0m+8d+6pyn25plqOJ1w=;
 b=anKBt/dwr8lz38s+FWsjeJqSZvi/6g0FWviBxun1mexBMNkXIapZUxeQwRaveL8WUV
 vDIUKMX9OKcsZTYzNUXhVypO03NVd5GGt2jdiWxk8xMoqnr0W14kcNFNMFDCTywyXJkS
 sgXgX5m1tOIo9oe3RJwdYaOPIuHZqX1KHexI3mu4Ep9mjSrTUKnRCt5LMrsiEFCenwPQ
 cxCmSMWL6Unb0T49itT8J1d/h5RUpDlu9r74TGuud6qKOFZ8D2um50gopdTTXPoeIM2I
 h1DdC0wY+74YNCVJrGO3SLAlD9PYm3QS9QNQpo/GXvdw+gfIV1Y2tkFirp2KKd6rsAnP
 e/+A==
X-Gm-Message-State: AOJu0Yzm/f0iQMKuY+3ImblmdvRyCQnGSxWv4PAlRgGysN+Sgr7FDxRg
 eFgR+kpe7Py9OmqA2tXHcTW+iWyea7s6RhPViwujjZXQl9U4eZVnW9fI
X-Gm-Gg: Acq92OHZi0KiVN44RESdGAv/TWPzwhCDyqp/hTR/24hSb57oyjtwT7FGvklpJZ8D8qG
 xLsp7o7qQmFGX81BVm4zNv7TjGt8qjn+OVpUt06U4qw5cdFGFvh2d9BFktFmThmgypHcqHYSPfg
 oIx83Tv2mlG6dc+nJgtH3TvrTMsKB+bIpQlu2CSmWbYcq4p6Rp5nRqpDdxdo/2jMC77oNtelEMG
 meFlK/rqgVSKysNviPE71ySeJk26bJmXGwZsITgOYCRh7uboLRACRjVLnwI/vWElXBVmFl3mKka
 sLRYQ6IPSgMALc2TXe8p6b/FDxbyCqOATRXS3nOfrulNRBfs4HgdENQHlZ1sbqKFF+6AIoe1P7r
 SAwxTiQFFanvkByu2R/+pUoXE9t8uU6WKKttlIYhG7loniHQzuHNs4wKplWrL/0NZIGBKa9wJOp
 dAQjA9xUGp20vxCTIvilw5l1WdNdJNh/3JqF54C3NRlciCOx1snAflfc8=
X-Received: by 2002:a05:600c:c3c1:10b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-490424ad405mr44792005e9.10.1779461940854; 
 Fri, 22 May 2026 07:59:00 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c600esm49143405e9.3.2026.05.22.07.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 07:59:00 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 0/5] fib6: fix tbl8 reservation drift
Date: Fri, 22 May 2026 16:58:49 +0200
Message-ID: <20260522145855.1748406-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778146229.git.maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
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

This v1 supersedes the earlier RFC. The RFC dropped rsvd_tbl8s and
used tbl8_pool_pos in the pre-check, which loses the worst-case
envelope: a compressed /48 under a /28 allocates zero tbl8s but must
reserve the boundaries the /48 would need if the /28 is later
removed (DEL forces mid-flight decompression in modify_dp() with no
rollback).

This v1 keeps rsvd_tbl8s and computes it the way dir24_8 already
does for IPv4. dir24_8 counts /24 supernets that contain at least
one /25..32 prefix: that count is invariant under unrelated RIB
changes, so the counter cannot drift. trie6 has the same need at
13 levels instead of 1 (byte boundaries 24, 32, ..., 120), so v1
counts, for each L in that set, the /L supernets containing at
least one prefix with depth > L. ADD/DEL pairs are symmetric by
construction.

Patch 1 is the minimal self-contained fix (Fixes: + Cc: stable).
Patches 2-3 add the reproducer and extended regression tests.
Patches 4-5 are an optimization (not for stable): valid_descendants
in rte_rib6 + single-descent helper, so trie_modify() walks once
instead of up to 13 times per ADD/DEL.

Validated on a live BGP router (grout + FRR, 127 IPv6 prefixes):
RSVD_TBL8 returned to its pre-cycle value after a zebra-kill /
reconverge cycle.

Maxime Leroy (5):
  fib6: fix tbl8 reservation drift in trie
  test/fib6: add reproducer for tbl8 reservation drift
  test/fib6: extended drift test cases
  rib: track valid descendant count per node
  fib6: speed up tbl8 reservation accounting

 app/test/test_fib6.c    | 335 ++++++++++++++++++++++++++++++++++++++++
 app/test/test_rib6.c    |  92 +++++++++++
 lib/fib/trie.c          |  47 +-----
 lib/rib/rib6_internal.h |  37 +++++
 lib/rib/rte_rib6.c      |  80 ++++++++++
 5 files changed, 552 insertions(+), 39 deletions(-)
 create mode 100644 lib/rib/rib6_internal.h

---
v1:
* Keep rsvd_tbl8s; recompute it via topology-stable empty-supernet
  count (dir24_8 pattern at 13 levels) instead of RIB-derived
  depth_diff.
* Drop RFC patch 3/3 (no longer needed).
* Add extended regression tests.
* Add patches 4-5: RIB valid_descendants + single-descent helper
  (optional perf optimization; not for stable).
* Production-validated on a live BGP router.

--
2.43.0
