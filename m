Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81933C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:02:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F7884021E;
	Wed, 16 Jul 2025 15:02:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 85B764013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752670940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3jXrCeupmH4kifdvtEfwe0WD6E6tAKr/F3VaqK7lm8=;
 b=Cl1IOdIPeddRK29GHcgyTrBxRFXXTufhXjO1f9mlzCPUBRMAxiBcJkC45s0ak91Ug0OZZd
 8M7dR31yoJWWgxbMblF/fo8iQqrv2wQV2lmEYmOOrvswyjD78xnEacTInLqTdcCAMvL44R
 RbAlfISCbNgzltGuAmqOu0h6YfxyzCA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-UFyY3j3xOA2zBfHZNbvG2Q-1; Wed,
 16 Jul 2025 09:02:19 -0400
X-MC-Unique: UFyY3j3xOA2zBfHZNbvG2Q-1
X-Mimecast-MFC-AGG-ID: UFyY3j3xOA2zBfHZNbvG2Q_1752670939
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E74951800294
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:02:18 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F47E180049D
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:02:17 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v4 00/22] Run with UBSan in GHA
Date: Wed, 16 Jul 2025 15:01:47 +0200
Message-ID: <20250716130212.1736407-1-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sLOYSgSZBF5KlMEUaZAiFMeAZNURbRWY6MOjhVTy2bM_1752670939
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

This series fixes a number of issues reported by UBSan and adds a simple
job in GHA to avoid introducing undefined behavior in the core
components.
There is way more work/fixes to do if we want to run with a full set of
components, but baby steps first.

This series is aimed at v25.11, as it contains ABI breaking changes.
A new revision will be needed before merging is possible.


-- 
David Marchand

Changes since v3:
- modified fix on tailq,
- updated hash fix using unaligned_uint32_t type,
- updated rte_mp_msg and rte_stack_lf_head structs alignement,
- fixed more libraries/unit tests,

Changes since v2:
- simplified plugin fix,
- enabled more coverage,

Changes since v1:
- small updates on patches 5 and 6,

David Marchand (21):
  ci: save ccache on failure
  test/telemetry: fix test calling all commands
  test/mempool: fix test without stack driver
  eal: fix plugin dir walk
  cmdline: fix port list parsing
  cmdline: fix highest bit port list parsing
  tailq: fix lookup macro
  hash: fix unaligned access in predictable RSS
  stack: fix unaligned accesses on 128-bit
  build: support Undefined Behavior Sanitizer
  test/telemetry: catch errors in subshell
  ipc: fix mp message alignment for malloc
  graph: fix unaligned access in stats
  eventdev: fix listing timer adapters with telemetry
  test/power: fix tests without power drivers
  test/raw: fix test without skeleton driver
  net: fix IPv4 macro with highest bit
  rib6: fix some highest bits handling
  cfgfile: fix section count with no name
  test/func_reentrancy: fix EAL init call
  ci: extend coverage with UBSan

Marat Khalili (1):
  graph: fix stats query with no node xstats

 .ci/linux-build.sh                     |  38 ++++++++-
 .github/workflows/build.yml            |  11 +++
 .mailmap                               |   1 +
 app/test/meson.build                   |  12 +--
 app/test/suites/meson.build            |   3 +-
 app/test/suites/test_telemetry.sh      |   6 +-
 app/test/test_func_reentrancy.c        |   5 +-
 app/test/test_mempool.c                |  32 +++++---
 config/meson.build                     |  18 ++++-
 devtools/libabigail.abignore           |  12 +++
 devtools/words-case.txt                |   1 +
 lib/cfgfile/rte_cfgfile.c              |   8 +-
 lib/cmdline/cmdline_parse_portlist.c   |  15 ++--
 lib/eal/common/eal_common_options.c    |  17 ++--
 lib/eal/include/rte_eal.h              |   3 +-
 lib/eal/include/rte_tailq.h            |   9 ++-
 lib/eventdev/rte_event_timer_adapter.c |   4 +-
 lib/graph/graph_stats.c                | 105 ++++++++++++++-----------
 lib/hash/rte_thash.c                   |   6 +-
 lib/net/rte_ip4.h                      |   6 +-
 lib/rib/rte_rib6.c                     |   2 +-
 lib/stack/rte_stack.h                  |   4 +-
 22 files changed, 215 insertions(+), 103 deletions(-)

-- 
2.50.0

