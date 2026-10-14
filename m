Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AAECC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:02:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D262B4064A;
	Wed, 14 Oct 2026 17:01:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 14B6540B92
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49zAsbAiMT5K+Mgwp0bHgKfWnrw2fEFtmhV7ZRnQBwI=;
 b=PIw10y85ggQ+VHesVVZr6wIdox9DZGEnhN7Gk8gVZ7xnuEG+NeSTXHE0G8Z+g995Z+vS+u
 EctnLlyMd8ck5Gx3h8eDOXeP2Zg7RVRjWnQo2M5Wq6lcQAl8suAWiZhSp3W7HNkFPXGKqW
 hutpHMVU6MZbET3/L2aGnyTA8mnXnaA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-BarnoNkmOQuHQxMXdmzD3A-1; Wed,
 14 Oct 2026 15:01:05 +0000
X-MC-Unique: BarnoNkmOQuHQxMXdmzD3A-1
X-Mimecast-MFC-AGG-ID: BarnoNkmOQuHQxMXdmzD3A_1791990064
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D3F41955F7F; Wed, 14 Oct 2026 15:01:04 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D9A91800446; Wed, 14 Oct 2026 15:01:03 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 08/14] vhost/crypto: drop crypto session cache
Date: Wed, 14 Oct 2026 17:00:43 +0200
Message-ID: <20261014150049.2540538-8-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AYx_0-cyhf-HfAxxLRE11oQy_FJcJdtvNllLU7f49DI_1791990064
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

The session cache may get invalidated by a guest, which would then
request an operation on the same (cached) session.

In general, the cache itself is racy as there is no guarantee a session
gets closed on the same thread that is processing a crypto request.

For those reasons, drop the cache entirely.

CVE-2026-86845
Bugzilla ID: 2028

Fixes: 939066d96563 ("vhost/crypto: add public function implementation")
Cc: stable@dpdk.org

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/vhost_crypto.c | 48 +++++++++++++---------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index bba2e1c0a6..a072324083 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -216,10 +216,6 @@ struct __rte_cache_aligned vhost_crypto {
 
 	uint64_t last_session_id;
 
-	uint64_t cache_sym_session_id;
-	struct rte_cryptodev_sym_session *cache_sym_session;
-	uint64_t cache_asym_session_id;
-	struct rte_cryptodev_asym_session *cache_asym_session;
 	/** socket id for the device */
 	int socket_id;
 
@@ -1590,22 +1586,16 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 		memcpy(vc_req_out, vc_req, sizeof(struct vhost_crypto_data_req));
 		session_id = req.header.session_id;
 
-		/* one branch to avoid unnecessary table lookup */
-		if (vcrypto->cache_sym_session_id != session_id) {
-			err = rte_hash_lookup_data(vcrypto->session_map,
-					&session_id, (void **)&vhost_session);
-			if (unlikely(err < 0)) {
-				err = VIRTIO_CRYPTO_ERR;
-				VC_LOG_ERR("Failed to find session %"PRIu64,
+		err = rte_hash_lookup_data(vcrypto->session_map,
+				&session_id, (void **)&vhost_session);
+		if (unlikely(err < 0)) {
+			err = VIRTIO_CRYPTO_ERR;
+			VC_LOG_ERR("Failed to find session %"PRIu64,
 						session_id);
-				goto error_exit;
-			}
-
-			vcrypto->cache_sym_session = vhost_session->sym;
-			vcrypto->cache_sym_session_id = session_id;
+			goto error_exit;
 		}
 
-		sym_session = vcrypto->cache_sym_session;
+		sym_session = vhost_session->sym;
 		op->type = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
 
 		err = rte_crypto_op_attach_sym_session(op, sym_session);
@@ -1641,22 +1631,16 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 	case VIRTIO_CRYPTO_AKCIPHER_DECRYPT:
 		session_id = req.header.session_id;
 
-		/* one branch to avoid unnecessary table lookup */
-		if (vcrypto->cache_asym_session_id != session_id) {
-			err = rte_hash_lookup_data(vcrypto->session_map,
-					&session_id, (void **)&vhost_session);
-			if (unlikely(err < 0)) {
-				err = VIRTIO_CRYPTO_ERR;
-				VC_LOG_ERR("Failed to find asym session %"PRIu64,
-						   session_id);
-				goto error_exit;
-			}
-
-			vcrypto->cache_asym_session = vhost_session->asym;
-			vcrypto->cache_asym_session_id = session_id;
+		err = rte_hash_lookup_data(vcrypto->session_map,
+				&session_id, (void **)&vhost_session);
+		if (unlikely(err < 0)) {
+			err = VIRTIO_CRYPTO_ERR;
+			VC_LOG_ERR("Failed to find asym session %"PRIu64,
+					   session_id);
+			goto error_exit;
 		}
 
-		asym_session = vcrypto->cache_asym_session;
+		asym_session = vhost_session->asym;
 		op->type = RTE_CRYPTO_OP_TYPE_ASYMMETRIC;
 
 		err = rte_crypto_op_attach_asym_session(op, asym_session);
@@ -1834,8 +1818,6 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 
 	vcrypto->sess_pool = sess_pool;
 	vcrypto->cid = cryptodev_id;
-	vcrypto->cache_sym_session_id = UINT64_MAX;
-	vcrypto->cache_asym_session_id = UINT64_MAX;
 	vcrypto->last_session_id = 1;
 	vcrypto->dev = dev;
 	vcrypto->option = RTE_VHOST_CRYPTO_ZERO_COPY_DISABLE;
-- 
2.56.0

