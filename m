Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8933BC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:04:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC83A40669;
	Wed, 16 Jul 2025 15:03:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3F7FE40696
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWa5QvjEjQB/8SJ4tlztd88lQ0om3aZtShHUmWnXB/c=;
 b=Q8iwlRU4dlD9CVqNYGE7KLSqBtRT6WFzM/MHuhduJa3w03vneKiHP6NkB71ufPFIRkltrL
 A5f1oBPZ/k/cqLlNvhjHM4lGgMCdcXGgR9+p/HPm5Cj4tztPk+/vWIpCebj0zgl1y8qeNR
 m7lfqIO+Tihbgdm5n+9M4mLm7BLZlEg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-MJNLSoPOMJKDp7Yd5Su8-g-1; Wed,
 16 Jul 2025 09:03:23 -0400
X-MC-Unique: MJNLSoPOMJKDp7Yd5Su8-g-1
X-Mimecast-MFC-AGG-ID: MJNLSoPOMJKDp7Yd5Su8-g_1752671002
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D29B1800C36; Wed, 16 Jul 2025 13:03:22 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC813195E772; Wed, 16 Jul 2025 13:03:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v4 12/22] ipc: fix mp message alignment for malloc
Date: Wed, 16 Jul 2025 15:01:59 +0200
Message-ID: <20250716130212.1736407-13-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y__gyGqEvameTYE2lpoPtDtXXoIH76E0iUWsMrVzfk8_1752671002
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

This change breaks ABI, put a suppression rule for now (this will be
removed when merging the series in v25.11).

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v3:
- changed rte_mp_msg struct alignment,

---
 devtools/libabigail.abignore | 4 ++++
 lib/eal/include/rte_eal.h    | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index c65bea2b51..ceb2d24a1f 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -55,3 +55,7 @@
 [suppress_type]
 	name = rte_stack_lf_list
 	has_size_change = yes
+
+[suppress_type]
+	name = rte_mp_msg
+	has_size_change = yes
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

