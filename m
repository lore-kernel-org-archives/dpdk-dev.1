Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086FCCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 13:40:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F16C40653;
	Tue, 19 May 2026 15:40:13 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by mails.dpdk.org (Postfix) with ESMTP id D30F44025E;
 Tue, 19 May 2026 15:40:09 +0200 (CEST)
X-UUID: 3df2b104538811f1aa26b74ffac11d73-20260519
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
 DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
 SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
 CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
 ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:a0008c35-9e44-4951-bb58-d324df477d52, IP:10,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:5
X-CID-INFO: VERSION:1.3.12, REQID:a0008c35-9e44-4951-bb58-d324df477d52, IP:10,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:5
X-CID-META: VersionHash:e7bac3a, CLOUDID:02363a9681f5636846fa4171025760d8,
 BulkI
 D:260519214004Q1WCNKVP,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
 1|102|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:ni
 l,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
 BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3df2b104538811f1aa26b74ffac11d73-20260519
X-User: jinzhiguang@kylinos.cn
Received: from jinzig.localdomain [(123.149.0.81)] by mailgw.kylinos.cn
 (envelope-from <jinzhiguang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1782627922; Tue, 19 May 2026 21:40:04 +0800
From: jinzhiguang <jinzhiguang@kylinos.cn>
To: Thomas Monjalon <thomas@monjalon.net>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Cc: dev@dpdk.org,
	jinzhiguang <jinzhiguang@kylinos.cn>,
	stable@dpdk.org
Subject: [PATCH v3] ring: fix zero-copy burst API documentation
Date: Tue, 19 May 2026 21:38:53 +0800
Message-ID: <20260519133853.889-1-jinzhiguang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519114629.862-1-jinzhiguang@kylinos.cn>
References: <20260519114629.862-1-jinzhiguang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These are burst APIs relying on RTE_RING_QUEUE_VARIABLE behavior, they
operate on a best-effort basis and return the actual number of
objects processed (between 0 and n).

Update description to match implementation.

Fixes: 47bec9a5ca9f ("ring: add zero copy API")

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Signed-off-by: jinzhiguang <jinzhiguang@kylinos.cn>
---
Cc: honnappa.nagarahalli@arm.com
Cc: stable@dpdk.org
---
V3:
  - Resend properly threaded to the v1 patch. (No code/text changes)
v2:
  - Update description to match actual behavior per Maintainer's suggestion.

 .mailmap                    | 1 +
 lib/ring/rte_ring_peek_zc.h | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4d26d9c286..a4f91f2131 100644
--- a/.mailmap
+++ b/.mailmap
@@ -756,6 +756,7 @@ Jing Chen <jing.d.chen@intel.com>
 Jingguo Fu <jingguox.fu@intel.com>
 Jingjing Wu <jingjing.wu@intel.com>
 Jingzhao Ni <jingzhao.ni@arm.com>
+jinzhiguang <jinzhiguang@kylinos.cn>
 Jiri Slaby <jslaby@suse.cz>
 Job Abraham <job.abraham@intel.com>
 Jochen Behrens <jochen.behrens@broadcom.com> <jbehrens@vmware.com>
diff --git a/lib/ring/rte_ring_peek_zc.h b/lib/ring/rte_ring_peek_zc.h
index 3254fe0481..43d6a53075 100644
--- a/lib/ring/rte_ring_peek_zc.h
+++ b/lib/ring/rte_ring_peek_zc.h
@@ -235,7 +235,7 @@ rte_ring_enqueue_zc_bulk_start(struct rte_ring *r, unsigned int n,
  *   If non-NULL, returns the amount of space in the ring after the
  *   reservation operation has finished.
  * @return
- *   The number of objects that can be enqueued, either 0 or n
+ *   The actual number of objects that can be enqueued.
  */
 static __rte_always_inline unsigned int
 rte_ring_enqueue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
@@ -265,7 +265,7 @@ rte_ring_enqueue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
  *   If non-NULL, returns the amount of space in the ring after the
  *   reservation operation has finished.
  * @return
- *   The number of objects that can be enqueued, either 0 or n.
+ *   The actual number of objects that can be enqueued.
  */
 static __rte_always_inline unsigned int
 rte_ring_enqueue_zc_burst_start(struct rte_ring *r, unsigned int n,
@@ -442,7 +442,7 @@ rte_ring_dequeue_zc_bulk_start(struct rte_ring *r, unsigned int n,
  *   If non-NULL, returns the number of remaining ring entries after the
  *   dequeue has finished.
  * @return
- *   The number of objects that can be dequeued, either 0 or n.
+ *   The actual number of objects that can be dequeued.
  */
 static __rte_always_inline unsigned int
 rte_ring_dequeue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
@@ -471,7 +471,7 @@ rte_ring_dequeue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
  *   If non-NULL, returns the number of remaining ring entries after the
  *   dequeue has finished.
  * @return
- *   The number of objects that can be dequeued, either 0 or n.
+ *   The actual number of objects that can be dequeued.
  */
 static __rte_always_inline unsigned int
 rte_ring_dequeue_zc_burst_start(struct rte_ring *r, unsigned int n,
-- 
2.53.0

