Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59C2C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D3C9402A0;
	Tue,  8 Jul 2025 14:28:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CF35B4028C
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:28:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh+pVVkQUDJmK4UM4i5OtFfQw0c+HhasLundNOSzXQU=;
 b=HZUWiRv4IFnsr2tenpWcVapz2u8LCvtrKOeB4AtBGliEwZ4qr+6gKI9AbTGQUllwSZuJB1
 b8AHVZaALxkc95EOL5T4S8vcZi3Et5mG3HMn1ABzrkvpYGvVepC8xslMi2p52ef90xWC4X
 9Z6YaNbPoBQEbcoYXn/kiQlcyKY3rao=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-I_uQJidvNQK-08_CYlHyJQ-1; Tue,
 08 Jul 2025 08:28:47 -0400
X-MC-Unique: I_uQJidvNQK-08_CYlHyJQ-1
X-Mimecast-MFC-AGG-ID: I_uQJidvNQK-08_CYlHyJQ_1751977726
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33A9B1954198
 for <dev@dpdk.org>; Tue,  8 Jul 2025 12:28:46 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4ED4D30001B1
 for <dev@dpdk.org>; Tue,  8 Jul 2025 12:28:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v3 00/18] Run with UBSan in GHA
Date: Tue,  8 Jul 2025 14:28:04 +0200
Message-ID: <20250708122823.3406288-1-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wPLJZ9mX1EjRHfyhVbNudpkMsA8dVW0BRXYKasBVF3w_1751977726
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

This series fixes a number of issues reported by UBSan and adds a simple
job in GHA to avoid introducing undefined behavior in the core
components.
There is way more work/fixes to do if we want to run with a full set of
components, but baby steps first.


-- 
David Marchand

Changes since v2:
- simplified plugin fix,
- enabled more coverage,

Changes since v1:
- small updates on patches 5 and 6,

David Marchand (17):
  ci: save ccache on failure
  test/telemetry: fix test calling all commands
  test/mempool: fix test without stack driver
  eal: fix plugin dir walk
  cmdline: fix port list parsing
  cmdline: fix highest bit port list parsing
  tailq: fix cast macro for null pointer
  hash: fix unaligned access in predictable RSS
  stack: fix unaligned accesses on 128-bit
  build: support Undefined Behavior Sanitizer
  test/telemetry: catch errors in subshell
  malloc: fix mp message alignment
  graph: fix unaligned access in stats
  eventdev: fix listing timer adapters with telemetry
  test/power: fix tests without power drivers
  test/raw: fix test without skeleton driver
  ci: extend coverage with UBSan

Marat Khalili (1):
  graph: fix stats query with no node xstats

 .ci/linux-build.sh                     |  38 ++++++++-
 .github/workflows/build.yml            |  11 +++
 .mailmap                               |   1 +
 app/test/meson.build                   |  12 +--
 app/test/suites/meson.build            |   3 +-
 app/test/suites/test_telemetry.sh      |   6 +-
 app/test/test_mempool.c                |  32 +++++---
 config/meson.build                     |  18 ++++-
 devtools/words-case.txt                |   1 +
 lib/cmdline/cmdline_parse_portlist.c   |  15 ++--
 lib/eal/common/eal_common_options.c    |  17 ++--
 lib/eal/common/eal_common_proc.c       |   2 +-
 lib/eal/common/malloc_mp.c             |  18 ++---
 lib/eal/include/rte_tailq.h            |   2 +-
 lib/eventdev/rte_event_timer_adapter.c |   4 +-
 lib/graph/graph_stats.c                | 105 ++++++++++++++-----------
 lib/hash/rte_thash.c                   |   6 +-
 lib/stack/rte_stack_lf_c11.h           |   8 +-
 lib/stack/rte_stack_lf_generic.h       |   8 +-
 19 files changed, 201 insertions(+), 106 deletions(-)

-- 
2.50.0

