Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA48C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 11:47:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF5D4029B;
	Mon, 21 Sep 2026 13:47:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5F7F14021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 13:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789991268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1XGuboP7RmGLtGFCMXLb/SZTWt6hOu1hr7fyZ5o2bY=;
 b=GnDyxquKRvbQ4ssgoWotKKNZdXWk2Ga0+gzRjbxHY70s74TdzuMMMQka6zPwWbgrTEbEur
 fN7xJU/u+w+Arc7TRGHR6joXzbdO8xhlR1qernkN+tx3sM1JRsCK9rWnb76x3uiwtpyn+p
 m95prTNNPRIlIHWUtB0u9+z8X96ipPs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-lVY4WgDqPMqPBCVQMt-JdQ-1; Mon,
 21 Sep 2026 07:47:45 -0400
X-MC-Unique: lVY4WgDqPMqPBCVQMt-JdQ-1
X-Mimecast-MFC-AGG-ID: lVY4WgDqPMqPBCVQMt-JdQ_1789991264
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ACC5180074E; Mon, 21 Sep 2026 11:47:44 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FAFD300106E; Mon, 21 Sep 2026 11:47:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v3 0/9] Limit usage of internal API in tests
Date: Mon, 21 Sep 2026 13:47:27 +0200
Message-ID: <20260921114737.2334589-1-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bUXR75x_sicJEpIAS2aOJNv6q701Zs1KVUfVdcUH2zk_1789991264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

Changes since v2:
- automated tests list generation in last patch,

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

 .ci/linux-build.sh                     |  41 ++++-
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
 21 files changed, 390 insertions(+), 367 deletions(-)
 create mode 100644 app/test/process.c

-- 
2.54.0

