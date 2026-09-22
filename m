Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E73CC982F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58AE7402BA;
	Tue, 22 Sep 2026 11:40:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6F8D2400D6
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:40:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790070034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yuvmZwkI7rO/7ZmjjkldOmNBzERCuP9jB/p4zjRmkwE=;
 b=QKy5aIuTCAMjFxXgNxoWurZA4uxRVHTUxxHjlN99ka3BMzcw2S/a7fbH8LaSW39cl9UZKp
 dy+3Slw/amIepu/6Euq+So7cULUcI0aXiSTkwvhZdMi/MkNKdU8GJ8Rm8N19+DUJbar8U+
 hvz0py6cODjvesfcf9LWC+to3+unhco=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-tI0i2dEGPLmUupzoprQf2A-1; Tue,
 22 Sep 2026 05:40:32 -0400
X-MC-Unique: tI0i2dEGPLmUupzoprQf2A-1
X-Mimecast-MFC-AGG-ID: tI0i2dEGPLmUupzoprQf2A_1790070030
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF4231955D6E; Tue, 22 Sep 2026 09:40:29 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 245F3418; Tue, 22 Sep 2026 09:40:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 0/9] Limit usage of internal API in tests
Date: Tue, 22 Sep 2026 11:40:16 +0200
Message-ID: <20260922094026.2636265-1-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mX4HQVBe29A4rbOiaZnZGOExYi4GzZZ3NeFVtY5A_f4_1790070030
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


-- 
David Marchand

Changes since v3:
- fixed support of newer meson version in last patch,

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

 .ci/linux-build.sh                     |  44 ++++-
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
 21 files changed, 393 insertions(+), 367 deletions(-)
 create mode 100644 app/test/process.c

-- 
2.54.0

