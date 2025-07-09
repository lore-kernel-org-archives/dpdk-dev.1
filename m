Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA8C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 12:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7235640662;
	Wed,  9 Jul 2025 14:40:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 188AB402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 14:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752064842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tL13yQ+mU23zbJ0Y+HDo7BeilYLbq24TATJdA1d8ngg=;
 b=N2mchVvbmDF/OvB5M7uJ3l+i94aSmBzqJARwwUHkbR0/pvNmkoim+NjVEzDhkZms1bR249
 z27yL0BCoiFPq4q9FJKTfBx+tpW1ArpBnBCKa+J0xWlK750BYEkLsLs52Dx1wda2aLjTau
 pyMjnec1dVepAYZnSZhBU5gUJgd9fAw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-iXX0v_wiO3mrKUbtNuERbg-1; Wed,
 09 Jul 2025 08:40:39 -0400
X-MC-Unique: iXX0v_wiO3mrKUbtNuERbg-1
X-Mimecast-MFC-AGG-ID: iXX0v_wiO3mrKUbtNuERbg_1752064838
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31C921955EC7; Wed,  9 Jul 2025 12:40:38 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43D8118003FC; Wed,  9 Jul 2025 12:40:35 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	techboard@dpdk.org
Subject: [PATCH] doc: announce changes in structure alignments for UBSan
Date: Wed,  9 Jul 2025 14:40:22 +0200
Message-ID: <20250709124022.4105481-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IccUNyUdrTlhwSJPIj13yBEK5SJfh6Z-ZDFyjpvzXD8_1752064838
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

As part of the effort to limit undefined behaviors in DPDK code, some
structure alignments revealed not to be accurate enough.
At the moment two structures have been identified but others may be
found while running more parts of DPDK with UBSan.

Though the calling code can explicitly request alignment,
we would prefer to put the alignment constraints as part of the
structure definition itself.

Such changes are ABI breakages.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index e2d4125308..4ae561d670 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -57,6 +57,10 @@ Deprecation Notices
   ``__atomic_thread_fence`` must be used for patches that need to be merged in
   20.08 onwards. This change will not introduce any performance degradation.
 
+* lib: multiple issues relating to unaligned accesses have been detected using the UBSan checker.
+  As part of resolving those issues, alignment in some structures will be updated in 25.11,
+  namely (but not exhaustively): ``struct rte_stack_lf_head`` and ``struct rte_mp_msg``.
+
 * lib: will fix extending some enum/define breaking the ABI. There are multiple
   samples in DPDK that enum/define terminated with a ``.*MAX.*`` value which is
   used by iterators, and arrays holding these values are sized with this
-- 
2.50.0

