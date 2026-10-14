Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A3C3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 19:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C18640395;
	Wed, 14 Oct 2026 21:22:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CD6834025A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 21:22:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792005729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doeNNbIJTU7lkMf7P+m8hQ9E1mRD3LvTfPAFkhG6AWU=;
 b=V4sObht6cOZVHIeKl4V0Mb5qODM8ZNeMXPIo9FHRufCeMf5WM90DcVFtRPOXb+v0nMF5fm
 lBt4WHFPOKYQNzrOdtTr7eg1VcSLEU2ey2sLYpyPoTvhIoa86tZLqQ/bv/HTkmaPolmnM/
 Uqb4YrRsI+/9rrxD01bUSf78k1yM7FY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-spCuq4r_NVKJmw7kqb9KPA-1; Wed,
 14 Oct 2026 19:22:08 +0000
X-MC-Unique: spCuq4r_NVKJmw7kqb9KPA-1
X-Mimecast-MFC-AGG-ID: spCuq4r_NVKJmw7kqb9KPA_1792005727
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CB3518000A2
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:22:07 +0000 (UTC)
Received: from ringo.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62C91180057F; Wed, 14 Oct 2026 19:22:06 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk 1/2] lib: remove cmdline from always enabled libraries
Date: Wed, 14 Oct 2026 21:21:54 +0200
Message-ID: <20261014192153.2693883-5-rjarry@redhat.com>
In-Reply-To: <20261014192153.2693883-4-rjarry@redhat.com>
References: <20261014192153.2693883-4-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T1AlrLMGqscDzb8GUpRb0rNodKVlbG7co24nNDnx6Mg_1792005727
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

This library is not used by any driver nor other library:

	$ git grep -l '#include <cmdline.*\.h>' -- \
		':!:app/' ':!:examples/' ':!:*testpmd*'
	buildtools/dpdk-cmdline-gen.py
	lib/cmdline/cmdline.h
	lib/cmdline/cmdline_parse_bool.h
	lib/cmdline/cmdline_parse_etheraddr.h
	lib/cmdline/cmdline_parse_ipaddr.h
	lib/cmdline/cmdline_parse_num.h
	lib/cmdline/cmdline_parse_portlist.h
	lib/cmdline/cmdline_parse_string.h
	lib/cmdline/cmdline_rdline.h
	lib/cmdline/cmdline_socket.h

The only apps and examples where it is actually used already have an
explicit dependency. There is no point in always enabling it.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/meson.build b/lib/meson.build
index af5c160cb800..72ac21b5fa86 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -72,7 +72,6 @@ libraries = [
 
 always_enable = [
         'argparse',
-        'cmdline',
         'eal',
         'ethdev',
         'hash',
-- 
2.56.0

