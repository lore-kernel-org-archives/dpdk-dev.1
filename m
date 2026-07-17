Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C92C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B577D40A7F;
	Fri, 17 Jul 2026 11:30:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8EEAB40684
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784280614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qBmPT6wwOFH49eFyxmA3wxpV/vD4ro0a8PGrZfMs9yA=;
 b=cy53TEQ8W3cBEh7ANNSDRCYcrJ3OWt5YhP0Lw9L7iN/f8R30WdOTYmMwF3tVvUNyxLejK4
 iGFav4oIUOEBlENrpkM8eOzVMoem4enjIdW1JgXBeKkIxF3N43+XGRvCbCn7P1i92PwJJy
 r2UcC1MQXkU3Z4bv6K4+nyqzYMYPwmU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-zRNa3q8COfiEn74RZveG7g-1; Fri,
 17 Jul 2026 05:30:12 -0400
X-MC-Unique: zRNa3q8COfiEn74RZveG7g-1
X-Mimecast-MFC-AGG-ID: zRNa3q8COfiEn74RZveG7g_1784280612
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6FAF1955DCC
 for <dev@dpdk.org>; Fri, 17 Jul 2026 09:30:11 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FCDBD72 for <dev@dpdk.org>; Fri, 17 Jul 2026 09:30:10 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH 00/10] Limit usage of internal API in tests
Date: Fri, 17 Jul 2026 11:29:55 +0200
Message-ID: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oNfNePAR5Wr4GD0bDS7dWhl5js_8sof-pZo6HNyQ0xg_1784280612
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This series is aimed at 26.11.

We had a few bug reports related to internal (and experimental) symbols
issues during 26.07 development.
See for example https://bugs.dpdk.org/show_bug.cgi?id=1957 or more
recently https://bugs.dpdk.org/show_bug.cgi?id=1967.

To catch such issues earlier in the CI, this series proposes to run
the unit tests through meson with the ABI reference unit test binary
against the current ABI libraries and drivers.

For this to work, some unit tests must be skipped (since meson may
invoke the ABI reference code with tests that were unknown at the time).

A few unit tests were directly dereferencing internal structures and are
reworked so they use public APIs.

Additionally, unit tests were allowed to use any internal API which has
hidden a few issues (like a public API backed by internal symbols in the
hash library).
So disable the global ALLLOW_INTERNAL_API and move it to code explicitly
requiring internal API, with the hope it will push us to have better API.

The last patch contains a hack for now, where the cached ABI reference
is force regenerated with a branch of mine where I backported the
fixes of this series.


-- 
David Marchand

David Marchand (10):
  bbdev: fix stats aggregation from queues
  bbdev: add per-queue statistics API
  hash: fix GFNI stubs export
  test: uninline helper for forking
  test/bonding: get MAC address with public API
  test/devargs: check driver presence with public API
  test/vdev: find device with public API
  test: limit internal API usage
  ci: make ABI reference generation faster
  ci: run reference unit tests against ABI

 .ci/linux-build.sh                     |  35 +++-
 .github/workflows/build.yml            |  15 +-
 MAINTAINERS                            |   1 +
 app/test-bbdev/test_bbdev_perf.c       |  38 +---
 app/test/meson.build                   |   7 +-
 app/test/process.c                     | 231 +++++++++++++++++++++++++
 app/test/process.h                     | 228 +-----------------------
 app/test/test_devargs.c                |  12 +-
 app/test/test_external_mem.c           |   2 +
 app/test/test_link_bonding.c           |  35 ++--
 app/test/test_malloc.c                 |   2 +
 app/test/test_mempool.c                |   2 +
 app/test/test_pdump.c                  |   3 +
 app/test/test_pdump.h                  |   3 +
 app/test/test_vdev.c                   |  85 ++-------
 app/test/virtual_pmd.c                 |   2 +
 devtools/test-meson-builds.sh          |   5 +-
 doc/guides/rel_notes/release_26_07.rst |   5 +
 lib/bbdev/rte_bbdev.c                  |  26 ++-
 lib/bbdev/rte_bbdev.h                  |  20 +++
 lib/hash/rte_thash_gfni.c              |   4 +-
 lib/hash/rte_thash_gfni.h              |   2 -
 22 files changed, 405 insertions(+), 358 deletions(-)
 create mode 100644 app/test/process.c

-- 
2.54.0

