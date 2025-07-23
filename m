Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A4DC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8371940E24;
	Wed, 23 Jul 2025 15:33:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6009C40E18
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKhLxs1VN6vrkMVuMIz9M5+QgJilLYA0lEByxj0ISOY=;
 b=E5Ux5oR2r305+EQetb8a9rrWGy2SwOTFN+yxmXrMW1gwl8UfMBEzINyPMuzxnQTNChs4Ee
 /8fwJssrDNuv/UUgvo5d3Py5oTyv6w/WlrE30iYBHU3jWMx5laDeF6Qa7FbTy/IaMd19hV
 AhFi+IKorIYm8/kDQsDcFYI/n8pU7Fk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-5xNQ4uZfPuGEYe8W5339zA-1; Wed,
 23 Jul 2025 09:33:12 -0400
X-MC-Unique: 5xNQ4uZfPuGEYe8W5339zA-1
X-Mimecast-MFC-AGG-ID: 5xNQ4uZfPuGEYe8W5339zA_1753277590
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6867119560AD; Wed, 23 Jul 2025 13:33:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4646A19560A0; Wed, 23 Jul 2025 13:33:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v5 12/22] ipc: fix mp message alignment for malloc
Date: Wed, 23 Jul 2025 15:31:45 +0200
Message-ID: <20250723133157.159825-13-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QClqk9oy9gPaaE2fxgR-sj_VStcthtn0G78dZqlFaxc_1753277590
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

Content (param[]) of received multiprocess messages are aligned with
a 4 bytes constraint.

Before patch:
struct mp_msg_internal {
 int type;                                                     /*   0     4 */
 struct rte_mp_msg {
  char name[64];                                               /*   4    64 */
  /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
  int len_param;                                               /*  68     4 */
  int num_fds;                                                 /*  72     4 */
  /* typedef uint8_t -> __uint8_t */ unsigned char param[256]; /*  76   256 */
  /* --- cacheline 5 boundary (320 bytes) was 12 bytes ago --- */
  int fds[253];                                                /* 332  1012 */
 } msg;                                                        /*   4  1340 */

 /* size: 1344, cachelines: 21, members: 2 */
};

This results in many unaligned accesses for multiprocess malloc requests.

Examples:
../lib/eal/common/malloc_mp.c:308:32: runtime error:
	member access within misaligned address 0x7f7b35df4684 for type
	'const struct malloc_mp_req', which requires 8 byte alignment

../lib/eal/common/malloc_mp.c:158:9: runtime error:
	member access within misaligned address 0x7f36a535bb5c for type
	'const struct malloc_mp_req', which requires 8 byte alignment

../lib/eal/common/malloc_mp.c:171:8: runtime error:
	member access within misaligned address 0x7f4ba65f296c for type
	'struct malloc_mp_req', which requires 8 byte alignment

Align param[] to 64 bits to avoid unaligned accesses on structures
passed through this array in mp messages.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v4:
- dropped ABI exception and updated RN,

Changes since v3:
- changed rte_mp_msg struct alignment,

---
 doc/guides/rel_notes/release_25_11.rst | 4 +++-
 lib/eal/include/rte_eal.h              | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index aa9211dd60..86cc59b4be 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -100,10 +100,12 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* eal: The structure ``rte_mp_msg`` alignment has been updated to 8 bytes to limit unaligned
+  accesses in messages payload.
+
 * stack: The structure ``rte_stack_lf_head`` alignment has been updated to 16 bytes
   to avoid unaligned accesses.
 
-
 Known Issues
 ------------
 
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index c826e143f1..08977c61d3 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -11,6 +11,7 @@
  * EAL Configuration API
  */
 
+#include <stdalign.h>
 #include <stdint.h>
 #include <time.h>
 
@@ -162,7 +163,7 @@ struct rte_mp_msg {
 	char name[RTE_MP_MAX_NAME_LEN];
 	int len_param;
 	int num_fds;
-	uint8_t param[RTE_MP_MAX_PARAM_LEN];
+	alignas(8) uint8_t param[RTE_MP_MAX_PARAM_LEN];
 	int fds[RTE_MP_MAX_FD_NUM];
 };
 
-- 
2.50.0

