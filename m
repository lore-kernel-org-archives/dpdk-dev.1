Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47637C531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B8C14067D;
	Thu, 23 Jul 2026 14:56:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 711954067C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 14:56:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784811372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7L4zKCeBXHuo2KINevSPiovmKYIMgwJuVh+0OtvAlV0=;
 b=ZsxnZz7VnIF+s4M/JRoMKTRe+jTxBi9Y8qdgmvt6hYin7yVM87pU87tPNmUHG1PhczsVPs
 slxwSG6IDiyzYvHJXWrLWbaY971etHVIohJrcKYosXM36nNR8Rl5C+ufCtzVNNN9wve+pt
 vKV6PMvv73BoNtmRaSgJ+9snpkxGB9w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-aYJMqvoFNXmkSuqYaTLYgA-1; Thu,
 23 Jul 2026 08:56:09 -0400
X-MC-Unique: aYJMqvoFNXmkSuqYaTLYgA-1
X-Mimecast-MFC-AGG-ID: aYJMqvoFNXmkSuqYaTLYgA_1784811368
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F5DC1945CB9; Thu, 23 Jul 2026 12:56:08 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FBAA3000229; Thu, 23 Jul 2026 12:56:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 0/9] Limit usage of internal API in tests
Date: Thu, 23 Jul 2026 14:55:49 +0200
Message-ID: <20260723125559.3087579-1-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NCBuDAE2sa76Gw6t8M_MrRKnKASe0WbqxlBXIrPgRzI_1784811368
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

Changes since v1:
- rebased,
- dropped patch 1 on bbdev,
- dropped dependency on net/ring in devargs test,
- removed hacks from last patch, flushed excluded tests list,
  added test-null.sh check,

David Marchand (9):
  bbdev: add per-queue statistics API
  hash: fix GFNI stubs export
  test: uninline helper for forking
  test/bonding: get MAC address with public API
  test/devargs: rely on net null driver
  test/vdev: find device with public API
  test: limit internal API usage
  ci: make ABI reference generation faster
  ci: run reference binaries against current ABI

 .ci/linux-build.sh                     |  40 ++++-
 .github/workflows/build.yml            |   1 +
 MAINTAINERS                            |   1 +
 app/test-bbdev/test_bbdev_perf.c       |  38 +---
 app/test/meson.build                   |   7 +-
 app/test/process.c                     | 231 +++++++++++++++++++++++++
 app/test/process.h                     | 228 +-----------------------
 app/test/test_devargs.c                |  21 +--
 app/test/test_external_mem.c           |   2 +
 app/test/test_link_bonding.c           |  35 ++--
 app/test/test_malloc.c                 |   2 +
 app/test/test_mempool.c                |   2 +
 app/test/test_pdump.c                  |   3 +
 app/test/test_pdump.h                  |   3 +
 app/test/test_vdev.c                   |  85 ++-------
 app/test/virtual_pmd.c                 |   2 +
 devtools/test-meson-builds.sh          |   5 +-
 doc/guides/rel_notes/release_26_11.rst |   5 +
 lib/bbdev/rte_bbdev.c                  |  20 +++
 lib/bbdev/rte_bbdev.h                  |  20 +++
 lib/hash/rte_thash_gfni.c              |   4 +-
 lib/hash/rte_thash_gfni.h              |   2 -
 22 files changed, 390 insertions(+), 367 deletions(-)
 create mode 100644 app/test/process.c

-- 
2.54.0

