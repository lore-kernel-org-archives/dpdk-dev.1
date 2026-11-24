Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C1606A32A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pB1UqpXB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABAB3402B2;
	Wed, 25 Nov 2026 11:26:14 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by mails.dpdk.org (Postfix) with ESMTPS id E3EEC4027A
 for <dev@dpdk.org>; Tue, 24 Nov 2026 13:42:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
 MIME-Version; bh=5t30F1XpLj27/puuYcOFuyKcf1NDWeKXxwJLFFqXfBQ=;
 b=pB1UqpXB8eQusD1yCS0fLHBhYCKpSoNKw/LuxHoZwDXQcu2IUrKg2PTpjIX6iO
 JWIeZBdadVwrQ9/rGeBzplCGCWSf0sspxptEAmEcQMmuw3It5XPfhaHXBmRfWY3i
 x1YM1nn2B/MTl/kwnXeMbpuSIl4NZpc2dTwAHOBfUHCWE=
From: Xiaojie Zhang <zxiaojay@163.com>
To: Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Sunila Sahu <ssahu@marvell.com>,
 Shally Verma <shallyv@marvell.com>
Cc: dev@dpdk.org, ashish.gupta@caviumnetworks.com
Subject: [PATCH] compress/zlib: clear queue pair slot on setup failure
Date: Tue, 24 Nov 2026 20:41:58 +0800
Message-ID: <179552411800.1057.7417498293368339009@1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3v1sWhgVr+Ac0Kg--.12757S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1DGw4DWFyrAr1fZFy5Jwb_yoWftFc_Jr
 W8ZrZrtr43Kr4q9F1akrWkZFyFyFn8WFnYqFsrKw13Ja47Aa1rJr4kXFn8Gry3J39xJ3Z2
 kw1jqr15urn3JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8y89tUUUUU==
X-CM-SenderInfo: 520lt0xmd1qiywtou0bp/xtbC+RfCzGsFhhdLSgAA3e
X-Mailman-Approved-At: Wed, 25 Nov 2026 11:26:12 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

zlib_pmd_qp_setup() publishes the queue pair before completing ring
setup. The cleanup path frees the queue pair but leaves its pointer in
the device slot, so a later release or close can access freed memory.

Clear the published slot when setup fails.

Fixes: 27422fc33cf3 ("compress/zlib: add basic ops")
Cc: ashish.gupta@caviumnetworks.com
Signed-off-by: Xiaojie Zhang <zxiaojay@163.com>
---
 drivers/compress/zlib/zlib_pmd_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/compress/zlib/zlib_pmd_ops.c b/drivers/compress/zlib/zli=
b_pmd_ops.c
index a530d15..596acc3 100644
--- a/drivers/compress/zlib/zlib_pmd_ops.c
+++ b/drivers/compress/zlib/zlib_pmd_ops.c
@@ -209,6 +209,7 @@ zlib_pmd_qp_setup(struct rte_compressdev *dev, uint16_t q=
p_id,
 qp_setup_cleanup:
 	if (qp) {
 		rte_free(qp);
+		dev->data->queue_pairs[qp_id] =3D NULL;
 		qp =3D NULL;
 	}
 	return -1;
--=20
2.39.5 (Apple Git-154)

