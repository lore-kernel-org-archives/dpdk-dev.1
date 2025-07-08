Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C1C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:30:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6578740A4B;
	Tue,  8 Jul 2025 14:30:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 550644028C
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:30:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xS9b/aHVC4oMd8pWs0BvxI6xXbdEM6KnJr9bRA692FM=;
 b=gVJIWNwqnBzKVfsnBR8WsKu9HrUaMYnHlU7Gm8aYFIkZfGH71YCicI856tML9d+niMCeud
 /4TgqtaJJ89BzjPPN8HXV4eGrrsQCrTAU8SnU2oy9dC5nJuwCjo1/brMIO4eJ0oTepFDsB
 G0JTre5IpZFI4Lu3Hk+lywTDYLbuNgs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-g81AL9-uM9ypf4OY_Bt1lA-1; Tue,
 08 Jul 2025 08:30:35 -0400
X-MC-Unique: g81AL9-uM9ypf4OY_Bt1lA-1
X-Mimecast-MFC-AGG-ID: g81AL9-uM9ypf4OY_Bt1lA_1751977834
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57E89180047F; Tue,  8 Jul 2025 12:30:34 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58AFD195609D; Tue,  8 Jul 2025 12:30:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Gage Eads <gage.eads@intel.com>, Olivier Matz <olivier.matz@6wind.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: [PATCH v3 09/18] stack: fix unaligned accesses on 128-bit
Date: Tue,  8 Jul 2025 14:28:13 +0200
Message-ID: <20250708122823.3406288-10-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8HCj2m6yZpUov5Qw2x9jY3Tf4E1ZYTd1yDTl1dOVvgg_1751977834
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

Fixes: 3340202f5954 ("stack: add lock-free implementation")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/stack/rte_stack_lf_c11.h     | 8 ++++----
 lib/stack/rte_stack_lf_generic.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/stack/rte_stack_lf_c11.h b/lib/stack/rte_stack_lf_c11.h
index b97e02d6a1..f674731235 100644
--- a/lib/stack/rte_stack_lf_c11.h
+++ b/lib/stack/rte_stack_lf_c11.h
@@ -63,13 +63,13 @@ __rte_stack_lf_push_elems(struct rte_stack_lf_list *list,
 			  struct rte_stack_lf_elem *last,
 			  unsigned int num)
 {
-	struct rte_stack_lf_head old_head;
+	alignas(16) struct rte_stack_lf_head old_head;
 	int success;
 
 	old_head = list->head;
 
 	do {
-		struct rte_stack_lf_head new_head;
+		alignas(16) struct rte_stack_lf_head new_head;
 
 		/* Swing the top pointer to the first element in the list and
 		 * make the last element point to the old top.
@@ -102,7 +102,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
 			 void **obj_table,
 			 struct rte_stack_lf_elem **last)
 {
-	struct rte_stack_lf_head old_head;
+	alignas(16) struct rte_stack_lf_head old_head;
 	uint64_t len;
 	int success = 0;
 
@@ -129,7 +129,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
 
 	/* Pop num elements */
 	do {
-		struct rte_stack_lf_head new_head;
+		alignas(16) struct rte_stack_lf_head new_head;
 		struct rte_stack_lf_elem *tmp;
 		unsigned int i;
 
diff --git a/lib/stack/rte_stack_lf_generic.h b/lib/stack/rte_stack_lf_generic.h
index cc69e4d168..32f56dffdd 100644
--- a/lib/stack/rte_stack_lf_generic.h
+++ b/lib/stack/rte_stack_lf_generic.h
@@ -36,13 +36,13 @@ __rte_stack_lf_push_elems(struct rte_stack_lf_list *list,
 			  struct rte_stack_lf_elem *last,
 			  unsigned int num)
 {
-	struct rte_stack_lf_head old_head;
+	alignas(16) struct rte_stack_lf_head old_head;
 	int success;
 
 	old_head = list->head;
 
 	do {
-		struct rte_stack_lf_head new_head;
+		alignas(16) struct rte_stack_lf_head new_head;
 
 		/* An acquire fence (or stronger) is needed for weak memory
 		 * models to establish a synchronized-with relationship between
@@ -77,7 +77,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
 			 void **obj_table,
 			 struct rte_stack_lf_elem **last)
 {
-	struct rte_stack_lf_head old_head;
+	alignas(16) struct rte_stack_lf_head old_head;
 	int success = 0;
 
 	/* Reserve num elements, if available */
@@ -99,7 +99,7 @@ __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
 
 	/* Pop num elements */
 	do {
-		struct rte_stack_lf_head new_head;
+		alignas(16) struct rte_stack_lf_head new_head;
 		struct rte_stack_lf_elem *tmp;
 		unsigned int i;
 
-- 
2.50.0

