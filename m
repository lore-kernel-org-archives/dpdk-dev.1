Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DC5C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:03:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93C544067D;
	Wed, 16 Jul 2025 15:03:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8B70B40662
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752670993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ab42GudJ70aV+nzoAgbMSmvvcYO9Dko2mxNAKI3B3Fs=;
 b=jO7691d5u2j/XTOoO0Js12pAuaJ18a1paoHWUhatla/raMntz0gd3V0H3UHidLeTukuC1i
 kqjMSSjqSxuSCnJv43ie55nWiPxpNneNmcmotztB0vkA1yasjA0GaYjnLZqxMtR0/2+pry
 Epv8d1v5OFLf5EOowkFViJPrbEkqBr4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-WIg3VWduP6mHghwlXE68Cg-1; Wed,
 16 Jul 2025 09:03:09 -0400
X-MC-Unique: WIg3VWduP6mHghwlXE68Cg-1
X-Mimecast-MFC-AGG-ID: WIg3VWduP6mHghwlXE68Cg_1752670988
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D163195608B; Wed, 16 Jul 2025 13:03:08 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE33F180049D; Wed, 16 Jul 2025 13:03:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>, Gage Eads <gage.eads@intel.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH v4 09/22] stack: fix unaligned accesses on 128-bit
Date: Wed, 16 Jul 2025 15:01:56 +0200
Message-ID: <20250716130212.1736407-10-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xhVm9HywYeDopcElryHBKjWihXq5EFACM7szUziiWqE_1752670988
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

Caught by UBSan:

../lib/eal/x86/include/rte_atomic_64.h:206:21: runtime error:
	member access within misaligned address 0x7ffd9c67f228 for
	type 'const rte_int128_t', which requires 16 byte alignment
	0x7ffd9c67f228: note: pointer points here
 00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
              ^
 00 00 00 00 00 00 00 00  00 00 00 00
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
	../lib/eal/x86/include/rte_atomic_64.h:206:21: runtime error:
	member access within misaligned address 0x7ffd9c67f228 for type
	'const union rte_int128_t::(anonymous at
	../lib/eal/include/generic/rte_atomic.h:1102:2)', which requires
	16 byte alignment
0x7ffd9c67f228: note: pointer points here
 00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
              ^
 00 00 00 00 00 00 00 00  00 00 00 00
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/eal/x86/include/rte_atomic_64.h:206:21 in
	../lib/eal/x86/include/rte_atomic_64.h:206:16: runtime error:
	load of misaligned address 0x7ffd9c67f228 for type
	'const uint64_t' (aka 'const unsigned long'), which requires
	16 byte alignment
0x7ffd9c67f228: note: pointer points here
 00 00 00 00  c0 5d 3e 00 01 00 00 00  01 00 00 00 00 00 00 00
              ^
 00 00 00 00 00 00 00 00  00 00 00 00
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
	../lib/eal/x86/include/rte_atomic_64.h:206:21 in

Rather than explicitly set alignment in callers, mark the structure
itself with an alignment constraint.

Fixes: 3340202f5954 ("stack: add lock-free implementation")

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Changes since v3:
- changed rte_stack_lf_head struct alignment,

---
 devtools/libabigail.abignore | 8 ++++++++
 lib/stack/rte_stack.h        | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index 96ae32455f..c65bea2b51 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -47,3 +47,11 @@
         name = rte_node
         has_size_change = no
         has_data_member_inserted_between = {offset_after(original_process), offset_of(xstat_off)}
+
+;;;;;;;;;;;;;;;;;;;
+; DONT MERGE THIS ;
+;;;;;;;;;;;;;;;;;;;
+
+[suppress_type]
+	name = rte_stack_lf_list
+	has_size_change = yes
diff --git a/lib/stack/rte_stack.h b/lib/stack/rte_stack.h
index 4439adfc42..fd17ac791d 100644
--- a/lib/stack/rte_stack.h
+++ b/lib/stack/rte_stack.h
@@ -33,14 +33,14 @@ struct rte_stack_lf_elem {
 	struct rte_stack_lf_elem *next;	/**< Next pointer */
 };
 
-struct rte_stack_lf_head {
+struct __rte_aligned(16) rte_stack_lf_head {
 	struct rte_stack_lf_elem *top; /**< Stack top */
 	uint64_t cnt; /**< Modification counter for avoiding ABA problem */
 };
 
 struct rte_stack_lf_list {
 	/** List head */
-	alignas(16) struct rte_stack_lf_head head;
+	struct rte_stack_lf_head head;
 	/** List len */
 	RTE_ATOMIC(uint64_t) len;
 };
-- 
2.50.0

