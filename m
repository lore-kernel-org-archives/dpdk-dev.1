Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC4606A323
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GUn+OO4I
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BBC14064E;
	Wed, 25 Nov 2026 11:26:17 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by mails.dpdk.org (Postfix) with ESMTPS id 658194027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 10:52:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fD
 LwbnC/c0olj6Cdfz4fFFC7O1cvr99Sodd2cSqN3RI=; b=GUn+OO4ImbZfNdkMNO
 Zzwk+UQgGDLfFD6rCyE2w+BVgtQMyjhzr/S7EULIhlf8Hv98ljjPuyixhaZEi7Ik
 JrQt6tzJRxlS/DhGTBHb3C3A8Q2fJFMoDXdgnwKFFCdGsC+zplMcs7TL71T154y0
 MeiQAbPWFhJcUgffRd0gSsORo=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wDXTqLArwZrYENfJw--.57701S2; 
 Wed, 25 Nov 2026 17:52:01 +0800 (CST)
From: Xiaojie Zhang <zxiaojay@163.com>
To: dev@dpdk.org
Cc: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>, Shally Verma <shallyv@marvell.com>,
 Xiaojie Zhang <zxiaojay@163.com>
Subject: [PATCH] compress/zlib: reset queue pair pointer on setup error
Date: Wed, 25 Nov 2026 17:51:58 +0800
Message-Id: <20261125095158.42191-1-zxiaojay@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXTqLArwZrYENfJw--.57701S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur48Jr18Zw4xuF45JryDGFg_yoWfZrg_Xw
 48ZrW7tr45Kw4q9F1akrZ3ZF9Yyas8XFn3XanrK342v343Aw4rAF4kWr1rWry3KwsIq3Zr
 Kr1jqw15Zrn7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCsjU3UUUUU==
X-CM-SenderInfo: 520lt0xmd1qiywtou0bp/xtbC3gF4gmsGr8EkdAAA32
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In zlib_pmd_qp_setup(), dev->data->queue_pairs[qp_id] is set before
name and ring initialization complete. If either step fails, the error
path frees qp without resetting the array entry to NULL.

Reset dev->data->queue_pairs[qp_id] to NULL before freeing qp.

Fixes: 27422fc33cf3 ("compress/zlib: add basic ops")
Signed-off-by: Xiaojie Zhang <zxiaojay@163.com>
---
 drivers/compress/zlib/zlib_pmd_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/compress/zlib/zlib_pmd_ops.c b/drivers/compress/zlib/zlib_pmd_ops.c
index a530d15119..61f8fa2e6a 100644
--- a/drivers/compress/zlib/zlib_pmd_ops.c
+++ b/drivers/compress/zlib/zlib_pmd_ops.c
@@ -208,6 +208,7 @@ zlib_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 
 qp_setup_cleanup:
 	if (qp) {
+		dev->data->queue_pairs[qp_id] = NULL;
 		rte_free(qp);
 		qp = NULL;
 	}
-- 
2.39.5 (Apple Git-154)

