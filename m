Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9E606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Et9QI7JG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 406614325E;
	Tue,  3 Nov 2026 16:24:12 +0100 (CET)
Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
 by mails.dpdk.org (Postfix) with ESMTPS id C1DB643278
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:24:10 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=oa6IIDztnZDWhVTggZeSxOEK8vVwjCza2Hd1AX3i8J8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719450; v=1; x=1794324250;
 b=Et9QI7JG/noaISklgc0sye1qjf17elWKrpAtmqdmtLYp6/ZsNkIZUNP7k0OHqPL+lZOjBoSI
 StxNuqihim0aJfcNTCGMOuK595Mw6B21sb1cbmtlx8cWzlNIi0aYxiHrgfEzZfaKTl6V2Tb55EY
 PhKzfI5WgcI+f4e6cFp7u2Zc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 7e2e243c5a44e4e1;
 Tue, 03 Nov 2026 15:24:10 +0000
X-Mizu-Trace-ID: 7e2e243c5a44e4e1
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 198/227] examples/l2fwd-crypto: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:36 +0800
Message-ID: <20261103145306.487255-199-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 examples/l2fwd-crypto/main.c | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index 84399463da..1b195a816e 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -672,12 +672,12 @@ static void *
 initialize_crypto_session(struct l2fwd_crypto_options *options, uint8_t cdev_id)
 {
 	struct rte_crypto_sym_xform *first_xform;
-	int retval = rte_cryptodev_socket_id(cdev_id);
+	int retval = rte_cryptodev_numa_id(cdev_id);
 
 	if (retval < 0)
 		return NULL;
 
-	uint8_t socket_id = (uint8_t) retval;
+	uint8_t numa_id = (uint8_t) retval;
 
 	if (options->xform_chain == L2FWD_CRYPTO_AEAD) {
 		first_xform = &options->aead_xform;
@@ -694,7 +694,7 @@ initialize_crypto_session(struct l2fwd_crypto_options *options, uint8_t cdev_id)
 	}
 
 	return rte_cryptodev_sym_session_create(cdev_id, first_xform,
-			session_pool_socket[socket_id].sess_mp);
+			session_pool_socket[numa_id].sess_mp);
 }
 /* >8 End of creation of session. */
 
@@ -2350,18 +2350,18 @@ initialize_cryptodevs(struct l2fwd_crypto_options *options, unsigned nb_ports,
 		if (check_capabilities(options, cdev_id) < 0)
 			continue;
 
-		retval = rte_cryptodev_socket_id(cdev_id);
+		retval = rte_cryptodev_numa_id(cdev_id);
 
 		if (retval < 0) {
 			printf("Invalid crypto device id used\n");
 			return -1;
 		}
 
-		uint8_t socket_id = (uint8_t) retval;
+		uint8_t numa_id = (uint8_t) retval;
 
 		struct rte_cryptodev_config conf = {
 			.nb_queue_pairs = 1,
-			.socket_id = socket_id,
+			.numa_id = numa_id,
 			.ff_disable = RTE_CRYPTODEV_FF_SECURITY,
 		};
 
@@ -2379,23 +2379,23 @@ initialize_cryptodevs(struct l2fwd_crypto_options *options, unsigned nb_ports,
 		} else
 			sessions_needed = enabled_cdev_count;
 
-		if (session_pool_socket[socket_id].sess_mp == NULL) {
+		if (session_pool_socket[numa_id].sess_mp == NULL) {
 			char mp_name[RTE_MEMPOOL_NAMESIZE];
 			snprintf(mp_name, RTE_MEMPOOL_NAMESIZE,
-				"sess_mp_%u", socket_id);
+				"sess_mp_%u", numa_id);
 
-			session_pool_socket[socket_id].sess_mp =
+			session_pool_socket[numa_id].sess_mp =
 				rte_cryptodev_sym_session_pool_create(
 					mp_name, sessions_needed, max_sess_sz,
-					0, 0, socket_id);
-			if (session_pool_socket[socket_id].sess_mp == NULL) {
+					0, 0, numa_id);
+			if (session_pool_socket[numa_id].sess_mp == NULL) {
 				printf("Cannot create pool on socket %d\n",
-					socket_id);
+					numa_id);
 				return -ENOMEM;
 			}
 
 			printf("Allocated pool \"%s\" on socket %d\n",
-				mp_name, socket_id);
+				mp_name, numa_id);
 		}
 
 		/* Set AEAD parameters */
@@ -2537,10 +2537,10 @@ initialize_cryptodevs(struct l2fwd_crypto_options *options, unsigned nb_ports,
 		}
 
 		qp_conf.nb_descriptors = 2048;
-		qp_conf.mp_session = session_pool_socket[socket_id].sess_mp;
+		qp_conf.mp_session = session_pool_socket[numa_id].sess_mp;
 
 		retval = rte_cryptodev_queue_pair_setup(cdev_id, 0, &qp_conf,
-				socket_id);
+				numa_id);
 		if (retval < 0) {
 			printf("Failed to setup queue pair %u on cryptodev %u",
 					0, cdev_id);
@@ -2619,7 +2619,7 @@ initialize_ports(struct l2fwd_crypto_options *options)
 		rxq_conf = dev_info.default_rxconf;
 		rxq_conf.offloads = local_port_conf.rxmode.offloads;
 		retval = rte_eth_rx_queue_setup(portid, 0, nb_rxd,
-					     rte_eth_dev_socket_id(portid),
+					     rte_eth_dev_numa_id(portid),
 					     &rxq_conf, l2fwd_pktmbuf_pool);
 		if (retval < 0) {
 			printf("rte_eth_rx_queue_setup:err=%d, port=%u\n",
@@ -2632,7 +2632,7 @@ initialize_ports(struct l2fwd_crypto_options *options)
 		txq_conf = dev_info.default_txconf;
 		txq_conf.offloads = local_port_conf.txmode.offloads;
 		retval = rte_eth_tx_queue_setup(portid, 0, nb_txd,
-				rte_eth_dev_socket_id(portid),
+				rte_eth_dev_numa_id(portid),
 				&txq_conf);
 		if (retval < 0) {
 			printf("rte_eth_tx_queue_setup:err=%d, port=%u\n",
@@ -2766,14 +2766,14 @@ main(int argc, char **argv)
 	l2fwd_pktmbuf_pool = rte_pktmbuf_pool_create("mbuf_pool", NB_MBUF, 512,
 			RTE_ALIGN(sizeof(struct rte_crypto_op),
 				RTE_CACHE_LINE_SIZE),
-			RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+			RTE_MBUF_DEFAULT_BUF_SIZE, rte_numa_id());
 	if (l2fwd_pktmbuf_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");
 
 	/* create crypto op pool */
 	l2fwd_crypto_op_pool = rte_crypto_op_pool_create("crypto_op_pool",
 			RTE_CRYPTO_OP_TYPE_SYMMETRIC, NB_MBUF, 128, MAXIMUM_IV_LENGTH,
-			rte_socket_id());
+			rte_numa_id());
 	if (l2fwd_crypto_op_pool == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot create crypto op pool\n");
 
-- 
2.55.0

