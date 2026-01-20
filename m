Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68601D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 06:12:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3FF040652;
	Tue, 20 Jan 2026 07:12:47 +0100 (CET)
Received: from lf-2-35.ptr.blmpb.com (lf-2-35.ptr.blmpb.com [101.36.218.35])
 by mails.dpdk.org (Postfix) with ESMTP id A52C440273
 for <dev@dpdk.org>; Tue, 20 Jan 2026 07:12:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403071020; d=picocom.com; t=1768889559; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bNatZjXFana+Zr/wuuQDLqFDwx69aJyUEvC7lwy1ri0=;
 b=ahROtD5YDns7uy4O6/e9owpNcpbWjj/ZQHcaITe0nePcsxv2qEKlRrxzML3EndFtCV0QYP
 K66vFhllSLM1GBKaP6qEbwbM9evmhnQ9Nm4CwRx6+kT47AsJCIQT9Gr+YMKAtatrbhAVtj
 A+su8TB5OAN+DFdKValPdNOfoi4WM6/+bwjQLA51QXDtrORW4r3cj3Q7/0kgtnYNoSwpoq
 j4Xj6RdRJzL/j8dTZ5SeKczV0M6DRAhaaBkzd90b9mqY2iNqCF+eLwD9pJ983L5U9Yx4XF
 KMn0qbPSyGoXZJMBGSKu3u4LupFo2YYx9qM0cUFXY7+QioPconNzOX9DvTinpw==
To: <kai.ji@intel.com>, <pablo.de.lara.guarch@intel.com>
Date: Tue, 20 Jan 2026 14:12:33 +0800
Message-Id: <20260120061234.137-1-wei.dai@picocom.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.windows.1
From: "weid wei.dai@picocom.com" <wei.dai@picocom.com>
Received: from LAPTOP-U6C877ST ([117.134.6.202]) by smtp.feishu.cn with ESMTPS;
 Tue, 20 Jan 2026 14:12:36 +0800
X-Lms-Return-Path: <lba+2696f1cd5+bc49e0+dpdk.org+wei.dai@picocom.com>
Content-Type: text/plain; charset=UTF-8
Cc: <dev@dpdk.org>, "weid" <wei.dai@picocom.com>
Subject: [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
X-Original-From: weid wei.dai@picocom.com
Content-Transfer-Encoding: 7bit
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

Fixes: 5208d68d30cb ("crypto/ipsec_mb: support snow3g digest appended ops")

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
