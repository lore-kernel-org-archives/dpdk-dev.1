Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F02C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 13:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E1E4065C;
	Mon, 23 Jun 2025 15:56:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 15EBE40151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 15:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69QsebkOhiODTNgMevN53nnjbfwvIpB53zitXY2m3RE=;
 b=d/cxIXIUO/P7Rund+UM22nPSeD4FqafrOu79BGFOs7X6UjOjKcUTFm2lwjHS/ZodtmoFoU
 1JxNUy/ZjLsjoDALnpw5EHRFxhEy0+CSaF19LLpcGAroUl6RJzHPOKlgFYS11Ystjs5Vvd
 BrDDlVapMl6lwS++1sN5zoc5LhKCwZc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-zQ4YtZkYNnql5aTKZs93YQ-1; Mon,
 23 Jun 2025 09:52:50 -0400
X-MC-Unique: zQ4YtZkYNnql5aTKZs93YQ-1
X-Mimecast-MFC-AGG-ID: zQ4YtZkYNnql5aTKZs93YQ_1750686769
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54555195609E
 for <dev@dpdk.org>; Mon, 23 Jun 2025 13:52:49 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.240])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78A1F180045B
 for <dev@dpdk.org>; Mon, 23 Jun 2025 13:52:48 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v2 00/10] Run with UBSan in GHA
Date: Mon, 23 Jun 2025 15:52:30 +0200
Message-ID: <20250623135242.461965-1-david.marchand@redhat.com>
In-Reply-To: <20250619071037.37325-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tQpf9-zX7VlDebK8SxBVl4VX1K7_WxnBMjEO72nn6wc_1750686769
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

Changes since v1:
- small updates on patches 5 and 6,

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
 lib/cmdline/cmdline_parse_portlist.c | 15 +++++++------
 lib/eal/common/eal_common_options.c  | 15 +++++++++----
 lib/eal/include/rte_tailq.h          |  2 +-
 lib/hash/rte_thash.c                 |  6 +++---
 lib/stack/rte_stack_lf_c11.h         |  8 +++----
 lib/stack/rte_stack_lf_generic.h     |  8 +++----
 13 files changed, 107 insertions(+), 41 deletions(-)

-- 
2.49.0

