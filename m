Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872CACCF2DF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 11:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B1BC4025D;
	Mon, 19 Jan 2026 12:02:38 +0100 (CET)
Received: from lf-2-17.ptr.blmpb.com (lf-2-17.ptr.blmpb.com [101.36.218.17])
 by mails.dpdk.org (Postfix) with ESMTP id 04DD14279E
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403071020; d=picocom.com; t=1768564658; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=1/lEsLdMY/naIgvxDcPTkKiQiehwYSZOkyttrGS9dbU=;
 b=GF0imHFNaOyjdI4AB2tfy8VhhIEJSJ2ljmtPNE2FoJCBTGVEwcuOTanYlBcGSAXQtRKVtD
 aQWvxvr4vFvFxroHgKbVJPXyPpQ4iTkWINcfKZ2WkMYaNwC3eS3RF28dSft+D3vn3SaES/
 b/H3F+NsWgx2S/mV8nL2fSmLohV4cO78cQ/7jlFt6K1k1ZVKh+nWgxQGQTPeSBGSNIqWpP
 fKGTWuYAqwp03SfN98WCWvpcQeD0AJCyUxFwplFctkeGqUzC5rNXeMR0tJptKxiphaTr/q
 I5dZSX+teibnpxx+SII1Di73745CLlfYtKX6QmJbS/UJu5Ep+GSzyPntpc9YHQ==
To: <kai.ji@intel.com>, <pablo.de.lara.guarch@intel.com>
Subject: [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2696a27b0+f863fc+dpdk.org+wei.dai@picocom.com>
Content-Transfer-Encoding: 7bit
X-Original-From: weid wei.dai@picocom.com
Cc: <dev@dpdk.org>, "weid" <wei.dai@picocom.com>
Received: from LAPTOP-U6C877ST ([117.134.6.202]) by smtp.feishu.cn with ESMTPS;
 Fri, 16 Jan 2026 19:57:35 +0800
X-Mailer: git-send-email 2.51.0.windows.1
Content-Type: text/plain; charset=UTF-8
From: "weid wei.dai@picocom.com" <wei.dai@picocom.com>
Date: Fri, 16 Jan 2026 19:57:17 +0800
Message-Id: <20260116115718.1500-1-wei.dai@picocom.com>
X-Mailman-Approved-At: Mon, 19 Jan 2026 12:02:36 +0100
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

From: weid <wei.dai@picocom.com>

Before this patch, the software crypto_snow3g
clear the encrypted auth snow3g digest when
the dst mbuf is same as the src mbuf in crypto
op.

This bug can be checked by following way,
start app/dpdk-test --vdev=crypto_snow3g,
run pdcp_autotest
the case failed when i=42 in
run_test_for_one_known_vec() in test_pdcp.c.
The case is PDCP control plane auth snow3g gen
+ cipher snow3g enc.
The case failed because the last 4 bytes are
cleared in last for() loop in line 167 in
process_snow3g_cipher_op() in pmd_snow3g.c .

Fixes: 5208d68d30cb ("crypto/ipsec_mb: support snow3g digest appended
ops")

Signed-off-by: weid <wei.dai@picocom.com>
---
 drivers/crypto/ipsec_mb/pmd_snow3g.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index b3c3b05a8a..35fe23c157 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -157,7 +157,8 @@ process_snow3g_cipher_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 	for (i = 0; i < num_ops; i++) {
 		if ((session->op == IPSEC_MB_OP_HASH_VERIFY_THEN_DECRYPT ||
 			session->op == IPSEC_MB_OP_HASH_GEN_THEN_ENCRYPT) &&
-				ops[i]->sym->m_dst != NULL) {
+				ops[i]->sym->m_dst != NULL &&
+				ops[i]->sym->m_dst != ops[i]->sym->m_src) {
 			digest_appended[i] =
 				snow3g_digest_appended_in_src(ops[i]);
 			/* Clear unencrypted digest from
-- 
2.51.0.windows.1
