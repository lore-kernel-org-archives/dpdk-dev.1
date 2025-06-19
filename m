Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF89C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:11:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DE1842DC3;
	Thu, 19 Jun 2025 09:11:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7492A4025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750317075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fkqvx/69ath8isq/Q1Pcydp8V5CwroqYh3JUhYUkPqY=;
 b=HqpC29MsfM6UDJ3HRv9cY4wCv9/6pVst4iWChrNBdI8kKGc0SmkpntPRs/PsIRT8HMHY/x
 d0EZYszdxBaOb3fApy0Yh3dKv9cfeXyJc28OScmip2+rFMs9p3CJoVqPCxhZHYbsyRbDio
 wrlcO1fVRCVGTVbkYvKfNsD+HTPoNEM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-kfHqSPP7ONGDbT9Er_OjZQ-1; Thu,
 19 Jun 2025 03:11:13 -0400
X-MC-Unique: kfHqSPP7ONGDbT9Er_OjZQ-1
X-Mimecast-MFC-AGG-ID: kfHqSPP7ONGDbT9Er_OjZQ_1750317072
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58D461956048
 for <dev@dpdk.org>; Thu, 19 Jun 2025 07:11:12 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EFCE19560B2
 for <dev@dpdk.org>; Thu, 19 Jun 2025 07:11:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH 00/10] Run with UBSan in GHA
Date: Thu, 19 Jun 2025 09:10:26 +0200
Message-ID: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PBqLnPJNKurl5XasrcmWSVA5wFiRCtxwUKaiTMu_diQ_1750317072
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

David Marchand (10):
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

 .ci/linux-build.sh                   | 27 +++++++++++++++++++++--
 .github/workflows/build.yml          | 11 ++++++++++
 app/test/suites/meson.build          |  3 +--
 app/test/suites/test_telemetry.sh    |  2 +-
 app/test/test_mempool.c              | 32 +++++++++++++++++-----------
 config/meson.build                   | 18 +++++++++++++++-
 devtools/words-case.txt              |  1 +
 lib/cmdline/cmdline_parse_portlist.c | 17 ++++++++++-----
 lib/eal/common/eal_common_options.c  | 15 +++++++++----
 lib/eal/include/rte_tailq.h          |  2 +-
 lib/hash/rte_thash.c                 |  6 +++---
 lib/stack/rte_stack_lf_c11.h         |  8 +++----
 lib/stack/rte_stack_lf_generic.h     |  8 +++----
 13 files changed, 111 insertions(+), 39 deletions(-)

-- 
2.49.0

