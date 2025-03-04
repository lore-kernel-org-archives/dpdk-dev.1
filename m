Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE120C282D2
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 842C74029A;
	Tue,  4 Mar 2025 17:06:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2F58740287
 for <dev@dpdk.org>; Tue,  4 Mar 2025 17:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741104401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5IcjJR4FnLPeXSc85NPbhMrZFaPS65yZPulL3Wr160=;
 b=T5Wnvgnr+UDLBdJDXTOGsWcXutxzx7qAZGSIGaMRQhT/tkdHlB2G+EeEggr9A5/85zzvBQ
 EXeLyjGQgJYGLEQa1tUaRgTqR8la5w3CIsOha+dZXG/o7FwJpb9eh+wM2JAoJ5fUimgg1A
 frkXCO0KKAgTHNyZ9kwd9ytkiUAW8HU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-VRKm1EAxOOeMGNS6RyJkug-1; Tue,
 04 Mar 2025 11:06:40 -0500
X-MC-Unique: VRKm1EAxOOeMGNS6RyJkug-1
X-Mimecast-MFC-AGG-ID: VRKm1EAxOOeMGNS6RyJkug_1741104399
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DF5919540FE
 for <dev@dpdk.org>; Tue,  4 Mar 2025 16:06:39 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 945F91954B00
 for <dev@dpdk.org>; Tue,  4 Mar 2025 16:06:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v4 0/5] Trace point framework enhancement for dmadev
Date: Tue,  4 Mar 2025 17:06:28 +0100
Message-ID: <20250304160633.385185-1-david.marchand@redhat.com>
In-Reply-To: <20250124161408.310581-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YO_54cu2SSzU6PU7Pox4ti3Zi-6dyDWCIA8SEWO7lbs_1741104399
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

dmadev trace points have been working around trace point framework
limitations.
One of this workaround blocks enabling dmadev on MSVC.

Traces files were not checked in CI, so this series also adds a new
check.

-- 
David Marchand

Changes since v3:
- dropped changes to CTF metadata,
- added new helpers for dumping content of pointed at memory,
- changed dmadev to avoid more changes in trace framework,

Changes since v2:
- added check of traces validity in GHA,
- split patch 2 and fixed CTF metadata,


David Marchand (5):
  ci: check traces validity
  dmadev: avoid copies in tracepoints
  trace: support dereferencing pointers
  trace: support expression for blob length
  trace: fix undefined behavior in register

 .ci/linux-build.sh                         | 10 ++++
 .github/workflows/build.yml                |  2 +-
 devtools/libabigail.abignore               |  5 ++
 lib/dmadev/rte_dmadev.h                    | 29 +++++-----
 lib/dmadev/rte_dmadev_trace.h              | 32 ++---------
 lib/dmadev/rte_dmadev_trace_fp.h           | 26 ++-------
 lib/eal/include/rte_trace_point.h          | 66 ++++++++++++++--------
 lib/eal/include/rte_trace_point_register.h | 51 ++++++++++++++---
 lib/ethdev/ethdev_trace.h                  | 27 +++------
 9 files changed, 135 insertions(+), 113 deletions(-)

-- 
2.48.1

