Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49381CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:40:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F4144064A;
	Tue, 28 Oct 2025 15:40:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EEF874028D
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:40:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761662408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t74N4rVC+1VdjYbAow9g7hi+KRcw/t/tK4kZkvq0ypM=;
 b=Xg81QX4XAsnIlNT/zJkBSyKv78xegeQd8qS88eWCGYJNyoXqrBAANLUhW9W5UcATO96UzP
 J0O1vfrzdjE5JAPlK8XXq7GxtKyq4LjKSKgakDZlBzl2sBqaCS5phrqD1qTNfxIMJktfR9
 6AydppJyiIAsf8DmVBb4AoqVUKiGcYQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-J5mdT-_tMDG_S56Hc_EoMw-1; Tue,
 28 Oct 2025 10:40:02 -0400
X-MC-Unique: J5mdT-_tMDG_S56Hc_EoMw-1
X-Mimecast-MFC-AGG-ID: J5mdT-_tMDG_S56Hc_EoMw_1761662400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90CC7195422F; Tue, 28 Oct 2025 14:40:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70935180057C; Tue, 28 Oct 2025 14:39:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, stable@dpdk.org, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH] trace: fix build with clang 21
Date: Tue, 28 Oct 2025 15:39:52 +0100
Message-ID: <20251028143952.4160487-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ahe7cWocKMZ4R10ojFjMOVf0CjFgjv8_VptcyhIudQo_1761662400
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

This was caught with recent clang.
The RTE_TRACE_POINT_ARGS() macro expects at least one parameter.
As a (void) function does not require any special tweaking with
__rte_unused, we can simply replace with a direct (void) token.

Build dir: /export/dpdk-next-net-mrvl/build-clang-static
Project version: 25.11.0-rc1
C compiler for the host machine: ccache clang (clang 21.1.4
	"clang version 21.1.4")

In file included from ../lib/eal/common/eal_common_trace_points.c:7:
../lib/eal/include/rte_eal_trace.h:23:2: error: attribute 'unused'
	cannot be applied to a 'void' parameter
	[-Werror,-Wignored-attributes]
   23 |         RTE_TRACE_POINT_ARGS(void),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/eal/include/rte_trace_point_register.h:46:3: note: expanded
	from macro 'RTE_TRACE_POINT_ARGS'
   46 |         (RTE_TRACE_POINT_ARGS_(RTE_TRACE_POINT_ARGS_COUNT(0,
	__VA_ARGS__), __VA_ARGS__))
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/eal/include/rte_trace_point_register.h:44:30: note: expanded
	from macro 'RTE_TRACE_POINT_ARGS_'
   44 |         RTE_TRACE_POINT_ARGS_EXPAND(RTE_TRACE_POINT_ARGS_FUNC
	(N))(__VA_ARGS__)
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
	~~~~~~~~~~~~~~~~~
../lib/eal/include/rte_trace_point_register.h:41:38: note: expanded
	from macro 'RTE_TRACE_POINT_ARGS_FUNC'
   41 | #define RTE_TRACE_POINT_ARGS_FUNC(a) RTE_TRACE_POINT_ARGS_ ## a
      |                                      ^
note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0
	to see all)
../lib/eal/include/rte_trace_point_register.h:42:42: note: expanded
	from macro 'RTE_TRACE_POINT_ARGS_EXPAND'
   42 | #define RTE_TRACE_POINT_ARGS_EXPAND(...) __VA_ARGS__
      |                                          ^
../lib/eal/include/rte_trace_point_register.h:26:35: note: expanded
	from macro 'RTE_TRACE_POINT_ARGS_1'
   26 | #define RTE_TRACE_POINT_ARGS_1(a) __rte_unused a
      |                                   ^~~~~~~~~~~~
../lib/eal/include/rte_common.h:248:37: note: expanded
	from macro '__rte_unused'
  248 | #define __rte_unused __attribute__((__unused__))
      |                                     ^~~~~~~~~~
1 error generated.

Cc: stable@dpdk.org

Reported-by: Jerin Jacob <jerinj@marvell.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_trace.h           | 2 +-
 lib/eal/include/rte_eal_trace.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_trace.h b/app/test/test_trace.h
index 4ad44e2bea..123ec8290a 100644
--- a/app/test/test_trace.h
+++ b/app/test/test_trace.h
@@ -13,5 +13,5 @@ RTE_TRACE_POINT(
 
 RTE_TRACE_POINT_FP(
 	app_dpdk_test_fp,
-	RTE_TRACE_POINT_ARGS(void),
+	(void),
 )
diff --git a/lib/eal/include/rte_eal_trace.h b/lib/eal/include/rte_eal_trace.h
index 9ad2112801..152474bf84 100644
--- a/lib/eal/include/rte_eal_trace.h
+++ b/lib/eal/include/rte_eal_trace.h
@@ -20,7 +20,7 @@ extern "C" {
 /* Generic */
 RTE_TRACE_POINT(
 	rte_eal_trace_generic_void,
-	RTE_TRACE_POINT_ARGS(void),
+	(void),
 )
 
 RTE_TRACE_POINT(
-- 
2.51.0

