Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ACFCA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A731840698;
	Thu,  1 Oct 2026 00:43:46 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 465EB40262
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:44 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso2715194a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808223;
 x=1791413023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SA50A96/p4OO7aHTJSbvsWJn/oyAEuKyCXtBJOtvf3c=;
 b=M6Cc4voHWzqtA/KTbClXbeTCHmXANA71OFElmEVjcdaHM2X3TDXxeeuza+a0lD9FVO
 3wZoOXbiwWB+8BB6M/4Fg+2l8bw0HEUAl6gik5VWIzjO+dQYN4qp6w/XAsVbB4Plp9Wl
 NjC5c0YhqwR29d5YFqY+krZhBXNGp73IPataZs27Mm8WBhNGrhesOyxOMqA5BY1nIR16
 oMp+L+W9+Nwb6XyA6OSVMOR3X1UJYulZ135GmblzCEt2qWO46r/6I/MNu79uupt3KKlN
 QD/y0F3b6Sw4nQec30fbWQpeOOyltN91lesZoKxbs/lO/74WfxBcM8pEASOfOFG+LUV7
 ODEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808223; x=1791413023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SA50A96/p4OO7aHTJSbvsWJn/oyAEuKyCXtBJOtvf3c=;
 b=B0DGDsF8XQfVJVCp9uPGjVxhoa/1Ou0LLY0T0OOUVgf9f8EKQFKVX8pYPUXU0jzwzI
 R7VM2zAkKPDURj5FWbOOQhnA2nrk6zJhArZPPXL2YZNkI2SGYavEEEu9E+Xwa6aFK3MD
 dKQGfjAbHegmmZby5HKeiPtKpKWl9xS+t9EUfvcd1TZHhHSa4iQMglE5wmCMXBHQlo0s
 9nQFki1Nz0+DJYsTw4UMHrPCCztJnM8SBg8NBdLm7JSUFy9xIQcjE8AiDirfPKLc9BCZ
 oDY2bTsIk7dlcmhhHLDcOdjkRMJ83XuzzuOJ5pYqTKOtcSsmpfssrNKTvIXhRdJ1Rili
 cE2w==
X-Gm-Message-State: AFq9FYJv54hQm5DtOhjRb6hQE0mMLdjhW3eUABKf2OZUBcp1tmScOWwr
 34SAKbqoTtUuqiQFVnLOE1v5/5Y8Gm9kZ1Zku8ykuDfciNjEyQDv13lFLNr/ovkbpK2efJwaGkV
 iTaxO7ls=
X-Gm-Gg: AYBFou3HAwkp+88FnCwlNPJCZnTSy1x286Q9qYKoZlEYXAdUrMJnvoCNuKS0mQgzXSW
 9sYFfXxP1fBDPAK9BkQ5UuMSNbMkDEkZozrtyiUGtuDAEwAPwA7dRZjGWkb4Cu9djfyNUi7Riub
 GoLu1kfV4V2zuvRU7UTlP9knm26KUWwTRzppG075G709DYXyLY4gIvIKY4SCLA7Kdh3AEntTfJu
 SOQI3O0wlB2ZJ1pHJdTV2Uxyn+AlH3SiuHys2u+zNjvLta4BS213p6Bo/O46CVgAXdQH4n2QawP
 KWItaTM2UpuEqsE9TdHxO7LpHGUZRPqRUJQ0KuQHecTbSAmS2a0RVxvLFhUbXHGAZV5UbrHtJK0
 7L5w+ziMZVy+hfr1kqonmTlOAg1MXiuAPpadtUP1cT01Jc71uDVsGxScDAXQmAMLrRS12hTWQNT
 wgbSy1YaV/rAVTMuPinGBPbFWKZl6+ADI8C7ht3IrOyJCImdRXCxf190BiWmf+gb8enk+NFe3EV
 pJ7lnnnhptyOVy/vcxdngfDr8qe9HhCts2Acw==
X-Received: by 2002:a17:90b:2787:b0:3a2:b4bb:91ca with SMTP id
 98e67ed59e1d1-3a4d11df88fmr2395076a91.1.1790808223393; 
 Wed, 30 Sep 2026 15:43:43 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 01/65] net/ring: make numa node signed
Date: Wed, 30 Sep 2026 15:40:19 -0700
Message-ID: <20260930224340.58580-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

rte_eth_from_rings() takes a numa node (socket) but used unsigned
where int should have been used to allow for SOCKET_ID_ANY.
The only usage is in call rte_malloc routines with socket
and those functions expect int.

Change the parameter to int socket_id and carry that through the two
internal create functions. The devargs path keeps working as before:
"nodeaction=name:-1:CREATE" was already accepted, since strtol()
returned -1 into an unsigned int which became SOCKET_ID_ANY again at
the allocation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  6 ++++
 drivers/net/ring/rte_eth_ring.c        | 38 +++++++++++++-------------
 drivers/net/ring/rte_eth_ring.h        | 11 ++++----
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e027c7a27f..58b0e588ce 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -206,6 +206,12 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* net/ring: The last parameter of ``rte_eth_from_rings`` changed from
+  ``const unsigned numa_node`` to ``int socket_id``, so that
+  ``SOCKET_ID_ANY`` can be passed as it can everywhere else a socket is
+  given. The value was already used as a signed socket id by the memory
+  and ring allocations underneath.
+
 * ethdev: Updated VMDq related API.
 
   * At port configuration time, the number of VMDq pools advertised by a driver
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 4cbdbe3085..533a4c1b6b 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -32,7 +32,7 @@ struct ring_internal_args {
 	const unsigned int nb_rx_queues;
 	struct rte_ring * const *tx_queues;
 	const unsigned int nb_tx_queues;
-	const unsigned int numa_node;
+	int socket_id;
 };
 
 /* rte_eth_from_rings() stashes a pointer to its on-stack args here */
@@ -361,7 +361,7 @@ do_eth_dev_ring_create(const char *name,
 		const unsigned int nb_rx_queues,
 		struct rte_ring *const tx_queues[],
 		const unsigned int nb_tx_queues,
-		const unsigned int numa_node, enum dev_action action,
+		int socket_id, enum dev_action action,
 		struct rte_eth_dev **eth_dev_p)
 {
 	struct rte_eth_dev_data *data = NULL;
@@ -371,24 +371,24 @@ do_eth_dev_ring_create(const char *name,
 	void **tx_queues_local = NULL;
 	unsigned int i;
 
-	PMD_LOG(INFO, "Creating rings-backed ethdev on numa socket %u",
-			numa_node);
+	PMD_LOG(INFO, "Creating rings-backed ethdev on numa socket %d",
+			socket_id);
 
 	rx_queues_local = rte_calloc_socket(name, nb_rx_queues,
-					    sizeof(void *), 0, numa_node);
+					    sizeof(void *), 0, socket_id);
 	if (rx_queues_local == NULL) {
 		rte_errno = ENOMEM;
 		goto error;
 	}
 
 	tx_queues_local = rte_calloc_socket(name, nb_tx_queues,
-					    sizeof(void *), 0, numa_node);
+					    sizeof(void *), 0, socket_id);
 	if (tx_queues_local == NULL) {
 		rte_errno = ENOMEM;
 		goto error;
 	}
 
-	internals = rte_zmalloc_socket(name, sizeof(*internals), 0, numa_node);
+	internals = rte_zmalloc_socket(name, sizeof(*internals), 0, socket_id);
 	if (internals == NULL) {
 		rte_errno = ENOMEM;
 		goto error;
@@ -404,7 +404,7 @@ do_eth_dev_ring_create(const char *name,
 	/* now put it all together
 	 * - store EAL device in eth_dev,
 	 * - store queue data in internals,
-	 * - store numa_node info in eth_dev_data
+	 * - store socket id info in eth_dev_data
 	 * - point eth_dev_data to internals
 	 * - and point eth_dev structure to new eth_dev_data structure
 	 */
@@ -439,7 +439,7 @@ do_eth_dev_ring_create(const char *name,
 	data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 
 	eth_dev->dev_ops = &ops;
-	data->numa_node = numa_node;
+	data->numa_node = socket_id;
 
 	/* finally assign rx and tx ops */
 	eth_dev->rx_pkt_burst = eth_ring_rx;
@@ -464,14 +464,14 @@ rte_eth_from_rings(const char *name, struct rte_ring *const rx_queues[],
 		const unsigned int nb_rx_queues,
 		struct rte_ring *const tx_queues[],
 		const unsigned int nb_tx_queues,
-		const unsigned int numa_node)
+		int socket_id)
 {
 	struct ring_internal_args args = {
 		.rx_queues = rx_queues,
 		.nb_rx_queues = nb_rx_queues,
 		.tx_queues = tx_queues,
 		.nb_tx_queues = nb_tx_queues,
-		.numa_node = numa_node,
+		.socket_id = socket_id,
 	};
 	char ring_name[RTE_RING_NAMESIZE];
 	uint16_t port_id = RTE_MAX_ETHPORTS;
@@ -526,7 +526,7 @@ rte_eth_from_ring(struct rte_ring *r)
 static int
 eth_dev_ring_create(const char *name,
 		struct rte_vdev_device *vdev,
-		const unsigned int numa_node,
+		int socket_id,
 		enum dev_action action, struct rte_eth_dev **eth_dev)
 {
 	/* rx and tx are so-called from point of view of first port.
@@ -549,7 +549,7 @@ eth_dev_ring_create(const char *name,
 		}
 
 		rxtx[i] = (action == DEV_CREATE) ?
-				rte_ring_create(rng_name, 1024, numa_node,
+				rte_ring_create(rng_name, 1024, socket_id,
 						RING_F_SP_ENQ|RING_F_SC_DEQ) :
 				rte_ring_lookup(rng_name);
 		if (rxtx[i] == NULL)
@@ -557,7 +557,7 @@ eth_dev_ring_create(const char *name,
 	}
 
 	if (do_eth_dev_ring_create(name, vdev, rxtx, num_rings, rxtx, num_rings,
-		numa_node, action, eth_dev) < 0)
+		socket_id, action, eth_dev) < 0)
 		return -1;
 
 	return 0;
@@ -565,7 +565,7 @@ eth_dev_ring_create(const char *name,
 
 struct node_action_pair {
 	char name[ETH_RING_ACTION_MAX_LEN];
-	unsigned int node;
+	int socket_id;
 	enum dev_action action;
 };
 
@@ -626,7 +626,7 @@ static int parse_kvlist(const char *key __rte_unused,
 		goto out;
 
 	errno = 0;
-	info->list[info->count].node = strtol(node, &end, 10);
+	info->list[info->count].socket_id = strtol(node, &end, 10);
 
 	if ((errno != 0) || (*end != '\0')) {
 		PMD_LOG(WARNING,
@@ -686,7 +686,7 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 			internal_args->nb_rx_queues,
 			internal_args->tx_queues,
 			internal_args->nb_tx_queues,
-			internal_args->numa_node,
+			internal_args->socket_id,
 			DEV_ATTACH,
 			&eth_dev);
 		return ret >= 0 ? 0 : ret;
@@ -740,7 +740,7 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 		for (info->count = 0; info->count < info->total; info->count++) {
 			ret = eth_dev_ring_create(info->list[info->count].name,
 						  dev,
-						  info->list[info->count].node,
+						  info->list[info->count].socket_id,
 						  info->list[info->count].action,
 						  &eth_dev);
 			if (ret == -1 && info->list[info->count].action == DEV_CREATE) {
@@ -748,7 +748,7 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 					"Attach to pmd_ring for %s",
 					name);
 				ret = eth_dev_ring_create(name, dev,
-						info->list[info->count].node,
+						info->list[info->count].socket_id,
 						DEV_ATTACH,
 						&eth_dev);
 			}
diff --git a/drivers/net/ring/rte_eth_ring.h b/drivers/net/ring/rte_eth_ring.h
index 98292c7b33..dfbfce9f2f 100644
--- a/drivers/net/ring/rte_eth_ring.h
+++ b/drivers/net/ring/rte_eth_ring.h
@@ -24,17 +24,18 @@ extern "C" {
  *    pointer to array of rte_rings to be used as TX queues
  * @param nb_tx_queues
  *    number of elements in the tx_queues array
- * @param numa_node
- *    the numa node on which the memory for this port is to be allocated
+ * @param socket_id
+ *    the NUMA socket on which the memory for this port is to be allocated,
+ *    or SOCKET_ID_ANY
  * @return
  *    the port number of the newly created the ethdev or -1 on error.
  */
 int rte_eth_from_rings(const char *name,
 		struct rte_ring * const rx_queues[],
-		const unsigned nb_rx_queues,
+		const unsigned int nb_rx_queues,
 		struct rte_ring *const tx_queues[],
-		const unsigned nb_tx_queues,
-		const unsigned numa_node);
+		const unsigned int nb_tx_queues,
+		int socket_id);
 
 /**
  * Create a new ethdev port from a ring
-- 
2.53.0

