Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D15C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:33:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A9E340E1B;
	Wed, 23 Jul 2025 15:33:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 01E8840B98
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOh3kJU3vlMbm6Or1KT6CQDO96gQ7CP4zNl0g60gHRc=;
 b=U15/V6AL9LkSQrnZDnvQ+CArJmnen7yaJg+SA90F3vsTr1tey5WTKhw4cN2Bc6EbsN0Nd0
 CjT5JO4MkkEiCJ0uNNWHn7+KjfxGzboIw2U87zoL3cCmIcUpqeFIqNHHmnpj87DH1QZpdg
 IzwEtx/KpcTjCWFw6DWUcS+QON2USPg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-g1gUD8hoNsCXBgrSS_ATOw-1; Wed,
 23 Jul 2025 09:33:03 -0400
X-MC-Unique: g1gUD8hoNsCXBgrSS_ATOw-1
X-Mimecast-MFC-AGG-ID: g1gUD8hoNsCXBgrSS_ATOw_1753277577
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D012D1800941; Wed, 23 Jul 2025 13:32:56 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3138519560A0; Wed, 23 Jul 2025 13:32:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Olivier Matz <olivier.matz@6wind.com>, Gage Eads <gage.eads@intel.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: [PATCH v5 09/22] stack: fix unaligned accesses on 128-bit
Date: Wed, 23 Jul 2025 15:31:42 +0200
Message-ID: <20250723133157.159825-10-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ro5-RaeF8-RXear-DEXSNpbp1NkIyt8DUq5x8ARB1MY_1753277577
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
Changes since v4:
- dropped ABI exception and updated RN,

Changes since v3:
- changed rte_stack_lf_head struct alignment,

---

 doc/guides/rel_notes/release_25_11.rst | 3 +++
 lib/stack/rte_stack.h                  | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index ccad6d89ff..aa9211dd60 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -100,6 +100,9 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* stack: The structure ``rte_stack_lf_head`` alignment has been updated to 16 bytes
+  to avoid unaligned accesses.
+
 
 Known Issues
 ------------
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

