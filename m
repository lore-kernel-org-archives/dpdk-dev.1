Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D330C282D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 09:43:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56BF240156;
	Wed,  5 Mar 2025 10:43:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43AAB400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 10:43:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741167816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n+Ys6//U8nKuDfWEP0oy2o+3bvhSAbOcT/sO4CG2G1I=;
 b=aC8UzJAb1NZEzu43t9zGmGaFpsCw5GtYMvm0nCUymnkrg++t6Ogw95NBjR1Q3IvNDtUUj9
 WE6f/Axv3JcMvqOaT50U8I3XhXd9xH1Bgh9K58v2gHU42HYwR9Nz/kwcj9B1nfNJ0nHDGa
 ao+QB8+19uncReu32Ddy/riIx9loS9s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-xDQWXRmvOYK_OrPoq8m9TA-1; Wed,
 05 Mar 2025 04:43:31 -0500
X-MC-Unique: xDQWXRmvOYK_OrPoq8m9TA-1
X-Mimecast-MFC-AGG-ID: xDQWXRmvOYK_OrPoq8m9TA_1741167810
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A15D180087D; Wed,  5 Mar 2025 09:43:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BA48300070B; Wed,  5 Mar 2025 09:43:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Akhil Goyal <gakhil@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH] vhost/crypto: fix build with asserts
Date: Wed,  5 Mar 2025 10:43:23 +0100
Message-ID: <20250305094323.598983-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SFzYQ_CYRQx1kdI9b6SUj4aS8DpVj5RKYSnqF1c-w0U_1741167810
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

../lib/vhost/vhost_crypto.c: In function ‘virtio_crypto_asym_rsa_der_to_xform’:
../lib/vhost/vhost_crypto.c:538:42: warning: comparison of integer expressions
	of different signedness: ‘long int’ and ‘size_t’ {aka ‘long unsigned int’}
	[-Wsign-compare]
  538 |         RTE_ASSERT((tlv + len - &der[0]) == der_len);
      |                                          ^~
../lib/eal/include/rte_branch_prediction.h:43:45: note: in definition of macro
	‘unlikely’
   43 | #define unlikely(x)     __builtin_expect(!!(x), 0)
      |                                             ^
../lib/eal/include/rte_debug.h:47:25: note: in expansion of macro ‘RTE_VERIFY’
   47 | #define RTE_ASSERT(exp) RTE_VERIFY(exp)
      |                         ^~~~~~~~~~
../lib/vhost/vhost_crypto.c:538:9: note: in expansion of macro ‘RTE_ASSERT’
  538 |         RTE_ASSERT((tlv + len - &der[0]) == der_len);
      |         ^~~~~~~~~~

Fixes: d1b484bf1876 ("vhost/crypto: support asymmetric RSA")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/vhost_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 8dd1806a39..3c6c5dc114 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -535,7 +535,7 @@ virtio_crypto_asym_rsa_der_to_xform(uint8_t *der, size_t der_len,
 	xform->rsa.qt.qInv.data = qinv;
 	xform->rsa.qt.qInv.length = qinvlen;
 
-	RTE_ASSERT((tlv + len - &der[0]) == der_len);
+	RTE_ASSERT(tlv + len == der + der_len);
 	return 0;
 }
 
-- 
2.48.1

