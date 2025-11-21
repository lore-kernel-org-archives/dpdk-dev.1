Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F44CCFA477
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 06:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A8AF4025E;
	Fri, 21 Nov 2025 07:20:10 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 38539400EF
 for <dev@dpdk.org>; Fri, 21 Nov 2025 07:20:07 +0100 (CET)
X-QQ-mid: esmtpsz17t1763705998tf3b6fe21
X-QQ-Originating-IP: 9QdcsAjo+7GlYoCzDSou7gwlZsXKwSgEcC1IRGfBrSc=
Received: from w-MS-7E16.trustnetic.com ( [122.231.28.133])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 21 Nov 2025 14:19:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14528158874862036507
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] net/txgbe: remove the build dependency on security
Date: Fri, 21 Nov 2025 14:19:51 +0800
Message-ID: <19590B42346A2673+20251121061951.466049-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NULd4DJcKZL/FLJrTq4BAq+bajs1kQ3vTaibBi+VgfGJMh8zFlSrPWUR
 +HME/VRjLoCrzC1UFdJRqeq1wwvt6151zA0pJvswqSoFm9Iewt3h2OiTwqZsZgyRg2gl/Uq
 rDNmR0I4/wXN/AKVOOzT5hRVqMpXZ/6IlgtajbBVoBgjgB+Y55uyXbP3SdWjvNB7kwEigTp
 MZsgSdidu56DB0cjJzhAqlnuc1wWB/0Tt7bRwPIRUuKLDwpkS3c8vbrUbfL0TqsxvC9TohY
 JU5/ALsLWabIjFYk7MObkC3PEBSgQ9qpiuyOLP8n2W7hnb0dcIzKJCnd+8OIhl7Y3/q3VQQ
 c1MAFmutcFkUWZW6GrW7y8vL46mjx1ssH099johWjh1gZL+oSS8QHNcILokwNOgyq+Tw0Sa
 nWWwo6+CZTGlSHUKSz72kyFnKQPMQHlxCGlSUVY40KUJZRD69tUiCmfEBkWj2SdgR7RY3kL
 TW/bFiBnhUgWR0FYfTz70YzYIStQkazEsyTrYWieQhiZe7Wgf2aOy+FzjlK4hz+RxBnUJeM
 ThB4gqhTnL8zyQJx6lRsUQ0oq+6p5C8+ppFwzBTHYtxmJ+L6NiGIa7VWXrsElaeAIaY4HMJ
 VShyWebCdrDQ6QnalJt0Z5i5ZspkFDlpbQSMuHtRL4MEwojy2HJv+TnSQ42gJWsdcnZL2/8
 b5A5JdBz0IlSKLEJBb1b1a074teL+RyjhBYItodEZ1u4uVdz21SYT+Zh4OHVg4GARN59Jxk
 Oj2ME952d/tKawvjIXoR/5/VMqjGxjyGMQbqH/7ezB9qM6HDedprxtjZtJD6CyotF2uhWVO
 SwhLTo6aJpSBKoLzRq0qtNOk/Xx1UnRJNwnKBepxuc18uI9ADum5oNksDFz0SY9Jah2rEJ/
 udIi6A6UalL62f0wmmJ4hJjpRUGCTMh5BGvcE7VovaOeh/62CCsBbPXWxTtb2qSRcsV/d8V
 oh0YVMDziSy7yVYqEJcI2bG/wcita1UVnWZEWxpPveBXkUSo7dnvuYX+jEffDkwc5O4nuYY
 6HVDJDSiPzzQr9jT1A2FHxbPI3F1yfnbhYjSjkRerVCvXwfWvn
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
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

Now lib security is enabled by default, and cannot be disabled if the
driver is intended to be used. But there are some functional scenarios
where lib security should be disabled, just like to enale Tx descriptor
hardware check. See commit 0eabdfcd4af4 ("net/txgbe: enable Tx
descriptor error interrupt").

So remove the build dependency on lib security for the driver.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/meson.build  |  8 ++++++--
 drivers/net/txgbe/txgbe_rxtx.c | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/meson.build b/drivers/net/txgbe/meson.build
index 5cdec017ed..57b2f6dbf1 100644
--- a/drivers/net/txgbe/meson.build
+++ b/drivers/net/txgbe/meson.build
@@ -14,17 +14,21 @@ sources = files(
         'txgbe_ethdev_vf.c',
         'txgbe_fdir.c',
         'txgbe_flow.c',
-        'txgbe_ipsec.c',
         'txgbe_ptypes.c',
         'txgbe_pf.c',
         'txgbe_rxtx.c',
         'txgbe_tm.c',
 )
 
-deps += ['hash', 'security']
+deps += ['hash']
 
 cflags += no_wvla_cflag
 
+if dpdk_conf.has('RTE_LIB_SECURITY')
+    sources += files('txgbe_ipsec.c')
+    deps += 'security'
+endif
+
 if arch_subdir == 'x86'
     sources += files('txgbe_rxtx_vec_sse.c')
 elif arch_subdir == 'arm'
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 78199ea00b..e9b9f17c84 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -21,7 +21,9 @@
 #include <rte_debug.h>
 #include <rte_ethdev.h>
 #include <ethdev_driver.h>
+#ifdef RTE_LIB_SECURITY
 #include <rte_security_driver.h>
+#endif
 #include <rte_memzone.h>
 #include <rte_atomic.h>
 #include <rte_mempool.h>
@@ -342,6 +344,17 @@ txgbe_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
+static uint64_t *
+txgbe_security_dynfield(struct rte_mbuf *tx_pkt)
+{
+#ifdef RTE_LIB_SECURITY
+	return rte_security_dynfield(tx_pkt);
+#else
+	UNREFERENCED_PARAMETER(tx_pkt);
+	return NULL;
+#endif
+}
+
 static inline void
 txgbe_set_xmit_ctx(struct txgbe_tx_queue *txq,
 		volatile struct txgbe_tx_ctx_desc *ctx_txd,
@@ -1102,7 +1115,7 @@ txgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 				txgbe_set_xmit_ctx(txq, ctx_txd, tx_ol_req,
 					tx_offload,
-					rte_security_dynfield(tx_pkt));
+					txgbe_security_dynfield(tx_pkt));
 
 				txe->last_id = tx_last;
 				tx_id = txe->next_id;
-- 
2.48.1

