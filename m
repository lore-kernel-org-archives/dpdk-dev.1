Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5922CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3CF040A7D;
	Wed, 14 Oct 2026 17:01:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2DE87406FF
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qxxlDR6dlDb4/q4Ax6R6afpBGaQUDA5QlecdXYbbxo=;
 b=LNKkONLjZH0/im87ZK8D/4W7u+HwlFE31n/4lnGPOvpQURweWtqqQZOYUW113Yz0R4D6/y
 tA2dCg2QoxEWcHHrf13JwM/StdtiAaUd8TRrYTcDSJ7YafUv/t+V27MVNqXjBnKDOXrVQe
 c1FzI4BQ7LrKIYsgeE17JCf0maNwbVM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-gRdgE9leNbGI3FmZD_CVyw-1; Wed,
 14 Oct 2026 15:01:04 +0000
X-MC-Unique: gRdgE9leNbGI3FmZD_CVyw-1
X-Mimecast-MFC-AGG-ID: gRdgE9leNbGI3FmZD_CVyw_1791990063
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C3331956048; Wed, 14 Oct 2026 15:01:03 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12E931800495; Wed, 14 Oct 2026 15:01:01 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 07/14] vhost/crypto: catch incorrect request length
Date: Wed, 14 Oct 2026 17:00:42 +0200
Message-ID: <20261014150049.2540538-7-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fYT2Nj6yz-zYnXScApaIOCVTlOiPsJOfCvODEc9ejCg_1791990063
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

From: David Marchand <david.marchand@redhat.com>

Incorrect lengths expressed as 32 bit unsigned integers in the crypto
operation request could go unnoticed as those were summed in a too
narrow 32 bit unsigned integer.

This issue was not fixed by the previous fixes (under CVE-2020-14376
and CVE-2020-14378).

CVE-2026-86849
Bugzilla ID: 2022

Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")
Cc: stable@dpdk.org

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/vhost_crypto.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 351fa241c8..bba2e1c0a6 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1182,11 +1182,11 @@ vhost_crypto_check_chain_request(struct virtio_crypto_alg_chain_data_req *req)
 		(req->para.hash_start_src_offset <
 			VHOST_CRYPTO_MAX_DATA_SIZE) &&
 		(req->para.len_to_hash <= VHOST_CRYPTO_MAX_DATA_SIZE) &&
-		(req->para.cipher_start_src_offset + req->para.len_to_cipher <=
+		((uint64_t)req->para.cipher_start_src_offset + req->para.len_to_cipher <=
 			req->para.src_data_len) &&
-		(req->para.hash_start_src_offset + req->para.len_to_hash <=
+		((uint64_t)req->para.hash_start_src_offset + req->para.len_to_hash <=
 			req->para.src_data_len) &&
-		(req->para.dst_data_len + req->para.hash_result_len <=
+		((uint64_t)req->para.dst_data_len + req->para.hash_result_len <=
 			VHOST_CRYPTO_MAX_DATA_SIZE)))
 		return VIRTIO_CRYPTO_OK;
 	return VIRTIO_CRYPTO_BADMSG;
-- 
2.56.0

