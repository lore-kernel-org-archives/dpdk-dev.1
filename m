Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B32C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B62C42EB7;
	Tue, 22 Sep 2026 21:41:48 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 90F2F42E65
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:45 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so195642a91.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790106105;
 x=1790710905; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hq9eGEEmuFnC47Xe281zdWnDpntNouhofpGi9wxPBTg=;
 b=m893LNyP8Lnu4OAT4JnllUrEbIa5IgpAnWQByx7Ww8k1QEec6nyS66ybs4Ih+NGY2v
 rOKEe5KBUbubIn6E+HsLmegnBs2vkDrM5dEal/e1VGXc/Z1TC+rvhc9V6Q1PVU6FdSWl
 J8S1S1f4ZpkQyLCjsLnWlVpEI8d70AvY4mzDBD1Z3k4RG7trQasGmEQHI4oGKcQCgee3
 /UqjaLn+azXb5C/Aq+rtFY55bBncLZJQPfmA1obkpk6TOJCqdybEAfmb+6QAGyrA1iO1
 au6IyQM0WOzShHtCoud/vP+Wvxtg6J9hzwmIbehJsVBzf/bC4UqjY4SmsbjmJoUYVvad
 raYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790106105; x=1790710905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hq9eGEEmuFnC47Xe281zdWnDpntNouhofpGi9wxPBTg=;
 b=K7vMa2L4nPQeh0+Ni08C5Cx/gB53HQdVG6sHJkrD6U4kNuysmAy9TSzcMM+e++r5en
 Y8W2C+NtSuTwUX3xf3RMveqFyEh8NzaXEWK9KqvZkP4+UE8A6PQ9p8oVaLN0mXPp86f+
 odwh2eVwx+l/rpMtdAdPh5NtsdUW0RND1Oaw3lC5nwM+phQ6Zu3jPJrxlQhafng7Awdz
 iAtjzuPM+qUsr18G0z9F0EVY21qR5SbHSoN4lr0PwqTT9UnybfDvxEjFuSQ99pQiouMW
 0FgyyWY6SbWD9efsLxHa7W++spXJB+GIIZ2k7ixVEvuVNjIZ4v3RzptDwCmB3LH0f/pr
 WdKg==
X-Gm-Message-State: AFuF++n3n8ElxNkeso5IV6DK8FNaWsiDu7CAFG10xAdfMx6HFpaYLSSp
 u2cFymXYxEvX0j9vRRaUQnPzqXa1XuOhIFzPwItiTUqft2Gp5L7q/DPhwzxiQRB8yt0qb15s3FX
 zboK6HAU=
X-Gm-Gg: AYBFou2uqg8bLLfdOIAAoi7P4K2RDssqXmhv8g8x1MVXLcr6gLaAaxQO2c49s4B+rRQ
 5nHO7mvnup9Kx3KPl7J5RLL9e9yDICI7X0+dk1SrJkwofyEtEBX8mis30hgwD4AWVm32klW7HU6
 xfTMXkxWZ+K+WREwh+JKrXUdkSdy+N5sFTS7624jOAQS+FVq7JrcWzW42JQEkniWrAY+Io2GqHl
 YLEscCKDoKaa8LW3SVqYK6Bv69lAxymPiKe4AeDvh3vNODaQfSvcHO0jkKI6uA9OmqcpNuARgJ4
 3EttMsDob/22prCMPUDbwnOGfQPIw5nfU3nsnxk9UaKrdHxMqAeCKYkwjJ2KXh9yf9MojNABxC9
 XHBnkL7xKg53U7WQB3v8ipxkFwH3f1vDw8LSkGXDi5ZBSyRe4NUANL023yVDmud0lzdBxX2uz3k
 mvuDEWfuhNjJIYO4mZLww5vTHPi1DCSGOt10Gd90yuH09F7jSSGHPMKfV5PzCTcqyuooCqP5JS+
 Qi5+39WKYjLmNxOLYPBTNys7SS6SAJ2rPBQbQ==
X-Received: by 2002:a17:90b:2ecb:b0:3a0:41ad:6b9b with SMTP id
 98e67ed59e1d1-3a07e74f3d6mr356580a91.34.1790106104608; 
 Tue, 22 Sep 2026 12:41:44 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf1cf3sm814881a91.9.2026.09.22.12.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:41:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 jgrajcia@cisco.com, Arthur Chan <arthur.chan@adalogics.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 3/7] net/memif: validate peer descriptors
Date: Tue, 22 Sep 2026 12:40:54 -0700
Message-ID: <20260922194138.508919-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194138.508919-1-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
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

The buffer descriptors in the shared memory ring are writable
by the peer at any time, and a server can not trust its client.

Validation classifies a bad descriptor into the same categories
used by the VPP memif plugin. The descriptor length is 32 bits on
the wire, so it is validated at full width before being narrowed
for use; otherwise a length such as 0x10040 would be truncated to
0x40 and accepted.

A zero length buffer on a server to client ring is also rejected.
It makes no forward progress, so the transmit path would consume
ring slots without copying anything.

If server gets a bad request it is logged and reported as error.
Since buggy or hostile client is not useful, the connection
is aborted to avoid later problems.

Only the primary process owns the control channel, so a secondary
that sees a bad descriptor counts the error but can not tear the
connection down; that waits until the primary sees one itself.
Propagating it needs an mp message and is left for later.

Bugzilla ID: 2010
Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org
Cc: jgrajcia@cisco.com

Reported-by: Arthur Chan <arthur.chan@adalogics.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Tested-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 .mailmap                          |   1 +
 drivers/net/memif/rte_eth_memif.c | 304 +++++++++++++++++++++++++++---
 drivers/net/memif/rte_eth_memif.h |   1 +
 3 files changed, 279 insertions(+), 27 deletions(-)

diff --git a/.mailmap b/.mailmap
index bbe3d013d2..a64a9d0549 100644
--- a/.mailmap
+++ b/.mailmap
@@ -159,6 +159,7 @@ Arshdeep Kaur <arshdeep.kaur@intel.com>
 Artem V. Andreev <artem.andreev@oktetlabs.ru>
 Artemii Morozov <artemii.morozov@arknetworks.am>
 Artemy Kovalyov <artemyko@nvidia.com>
+Arthur Chan <arthur.chan@adalogics.com>
 Artin Davari <artin.davari@broadcom.com>
 Artur Rojek <ar@semihalf.com>
 Artur Trybula <arturx.trybula@intel.com>
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 89796d3ed5..f7be4e4f4b 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -27,6 +27,8 @@
 #include <rte_memory.h>
 #include <rte_memzone.h>
 #include <rte_eal_memconfig.h>
+#include <rte_stdatomic.h>
+#include <rte_alarm.h>
 
 #include "rte_eth_memif.h"
 #include "memif_socket.h"
@@ -245,10 +247,147 @@ memif_get_ring_from_queue(struct pmd_process_private *proc_private,
 	return (memif_ring_t *)((uint8_t *)r->addr + mq->ring_offset);
 }
 
-static void *
-memif_get_buffer(struct pmd_process_private *proc_private, memif_desc_t *d)
+/*
+ * Result of validating a peer supplied descriptor.
+ * The names match the descriptor status codes used by the VPP memif plugin.
+ */
+enum memif_desc_status {
+	MEMIF_DESC_STATUS_OK = 0,
+	MEMIF_DESC_STATUS_ERR_BAD_REGION,
+	MEMIF_DESC_STATUS_ERR_REGION_OVERRUN,
+	MEMIF_DESC_STATUS_ERR_DATA_TOO_BIG,
+	MEMIF_DESC_STATUS_ERR_ZERO_LENGTH,
+};
+
+static const char * const memif_desc_status_str[] = {
+	[MEMIF_DESC_STATUS_OK]			= "ok",
+	[MEMIF_DESC_STATUS_ERR_BAD_REGION]	= "bad region",
+	[MEMIF_DESC_STATUS_ERR_REGION_OVERRUN]	= "region overrun",
+	[MEMIF_DESC_STATUS_ERR_DATA_TOO_BIG]	= "data too big",
+	[MEMIF_DESC_STATUS_ERR_ZERO_LENGTH]	= "zero length",
+};
+
+/* Take a private copy of descriptor for validation. */
+static inline memif_desc_t
+memif_desc_read(const memif_desc_t *dp)
+{
+	memif_desc_t desc = *(const volatile memif_desc_t *)dp;
+
+	rte_compiler_barrier();	/* avoid TOCTOU issues */
+	return desc;
+}
+
+/*
+ * Validate a peer supplied descriptor.
+ * The region index and offset are controlled by the peer, so check that the
+ * [offset, offset + len) window the caller intends to access lies inside a
+ * valid shared region.
+ */
+static enum memif_desc_status
+memif_desc_is_valid(const struct pmd_process_private *proc_private,
+		    const memif_desc_t *d, uint32_t len, uint32_t max_len,
+		    uint8_t **data)
+{
+	const struct memif_region *region;
+	uint64_t start = d->offset;
+
+	if (unlikely(d->region >= proc_private->regions_num))
+		return MEMIF_DESC_STATUS_ERR_BAD_REGION;
+
+	region = proc_private->regions[d->region];
+	if (unlikely(region == NULL || region->addr == NULL))
+		return MEMIF_DESC_STATUS_ERR_BAD_REGION;
+
+	if (unlikely(start + len > region->region_size))
+		return MEMIF_DESC_STATUS_ERR_REGION_OVERRUN;
+
+	if (unlikely(len > max_len || len > UINT16_MAX))
+		return MEMIF_DESC_STATUS_ERR_DATA_TOO_BIG;
+
+	*data = (uint8_t *)region->addr + start;
+	return MEMIF_DESC_STATUS_OK;
+}
+
+/*
+ * Tear down a connection whose peer supplied an invalid descriptor.
+ * Runs on the control thread from an alarm when started in data path.
+ */
+static void
+memif_bad_desc_disconnect(void *arg)
 {
-	return ((uint8_t *)proc_private->regions[d->region]->addr + d->offset);
+	struct rte_eth_dev *dev = arg;
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	if (!rte_atomic_exchange_explicit(&pmd->bad_desc, false, rte_memory_order_relaxed))
+		return;
+
+	strlcpy(pmd->local_disc_string, "bad descriptor",
+		sizeof(pmd->local_disc_string));
+
+	rte_spinlock_lock(&pmd->cc_lock);
+	if (pmd->cc != NULL)
+		memif_msg_enq_disconnect(pmd->cc, pmd->local_disc_string, 0);
+	rte_spinlock_unlock(&pmd->cc_lock);
+
+	memif_disconnect(dev);
+}
+
+/*
+ * Report a peer supplied descriptor that failed validation.
+ *
+ * A bad descriptor means the peer is buggy or malicious, so the rings can no longer be trusted.
+ * The data path only latches the error and defers the teardown to the control thread.
+ */
+static void __rte_cold
+memif_desc_error(struct memif_queue *mq, const memif_desc_t *d, enum memif_desc_status status)
+{
+	struct rte_eth_dev *dev = &rte_eth_devices[mq->in_port];
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	++mq->n_err;
+
+	/*
+	 * Only the primary owns the control channel, so only it can tear the
+	 * connection down. A secondary can just count the error here; the
+	 * disconnect then waits until the primary sees a bad descriptor of
+	 * its own. Telling the primary directly needs an mp message.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return;
+
+	/* Report only the descriptor that broke the connection. */
+	if (rte_atomic_exchange_explicit(&pmd->bad_desc, true, rte_memory_order_relaxed))
+		return;
+
+	MIF_LOG(ERR, "Port %u disconnecting, bad descriptor from peer "
+		"(region %u offset %u length %u): %s",
+		mq->in_port, d->region, d->offset, d->length,
+		memif_desc_status_str[status]);
+
+	if (rte_eal_alarm_set(1, memif_bad_desc_disconnect, dev) < 0) {
+		MIF_LOG(ERR, "Port %u failed to schedule disconnect", mq->in_port);
+		rte_atomic_store_explicit(&pmd->bad_desc, false, rte_memory_order_relaxed);
+	}
+}
+
+/*
+ * Resolve a peer supplied descriptor to a buffer address,
+ * or NULL if the descriptor is invalid.
+ */
+static uint8_t *
+memif_get_buffer(const struct pmd_process_private *proc_private, struct memif_queue *mq,
+		 const memif_desc_t *d, uint32_t len, uint32_t max_len)
+{
+	enum memif_desc_status status;
+	uint8_t *data = NULL;
+
+	status = memif_desc_is_valid(proc_private, d, len, max_len, &data);
+	if (unlikely(status != MEMIF_DESC_STATUS_OK)) {
+		memif_desc_error(mq, d, status);
+		return NULL;
+	}
+
+	return data;
 }
 
 /* Free mbufs received by server */
@@ -307,6 +446,8 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint16_t src_len, src_off, dst_len, dst_off, cp_len;
 	memif_ring_type_t type = mq->type;
 	memif_desc_t *d0;
+	memif_desc_t desc;
+	const uint8_t *src_data;
 	struct rte_mbuf *mbuf, *mbuf_head, *mbuf_tail;
 	uint64_t b;
 	ssize_t size __rte_unused;
@@ -362,22 +503,29 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 next_slot1:
 			mbuf->port = mq->in_port;
 			s0 = cur_slot & mask;
-			d0 = &ring->desc[s0];
+			desc = memif_desc_read(&ring->desc[s0]);
 
-			cp_len = d0->length;
+			/*
+			 * One descriptor per mbuf, so length must fit the mbuf.
+			 * Validate the full 32-bit peer length before narrowing it.
+			 */
+			src_data = memif_get_buffer(proc_private, mq, &desc, desc.length,
+						    mbuf_size);
+			if (unlikely(src_data == NULL))
+				goto discard1;
+			cp_len = desc.length;
 
 			rte_pktmbuf_data_len(mbuf) = cp_len;
 			rte_pktmbuf_pkt_len(mbuf) = cp_len;
 			if (mbuf != mbuf_head)
 				rte_pktmbuf_pkt_len(mbuf_head) += cp_len;
 
-			rte_memcpy(rte_pktmbuf_mtod(mbuf, void *),
-				(uint8_t *)memif_get_buffer(proc_private, d0), cp_len);
+			rte_memcpy(rte_pktmbuf_mtod(mbuf, void *), src_data, cp_len);
 
 			cur_slot++;
 			n_slots--;
 
-			if (d0->flags & MEMIF_DESC_FLAG_NEXT) {
+			if (desc.flags & MEMIF_DESC_FLAG_NEXT) {
 				if (unlikely(n_slots == 0)) {
 					mq->n_err++;
 					rte_pktmbuf_free_bulk(mbufs + rx_pkts,
@@ -406,6 +554,25 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			*bufs++ = mbuf_head;
 			rx_pkts++;
 			n_rx_pkts++;
+			continue;
+
+discard1:
+			/* Skip the remainder of this descriptor chain and
+			 * reuse mbuf_head for the next packet.
+			 */
+			while (1) {
+				cur_slot++;
+				n_slots--;
+				if (n_slots == 0 || (desc.flags & MEMIF_DESC_FLAG_NEXT) == 0)
+					break;
+				desc = memif_desc_read(&ring->desc[cur_slot & mask]);
+			}
+
+			/* Free any segments already chained, then reset the
+			 * head so it can be reused for the next packet.
+			 */
+			rte_pktmbuf_free(mbuf_head->next);
+			rte_pktmbuf_reset(mbuf_head);
 		}
 
 		if (rx_pkts < MAX_PKT_BURST) {
@@ -426,11 +593,22 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 next_slot2:
 			s0 = cur_slot & mask;
-			d0 = &ring->desc[s0];
+			desc = memif_desc_read(&ring->desc[s0]);
 
-			src_len = d0->length;
 			src_off = 0;
 
+			/*
+			 * Descriptor may span several mbufs, only bound by the region.
+			 * Validate the full 32-bit peer length before narrowing it.
+			 */
+			src_data = memif_get_buffer(proc_private, mq, &desc, desc.length,
+						    UINT32_MAX);
+			if (unlikely(src_data == NULL)) {
+				rte_pktmbuf_free(mbuf_head);
+				goto discard2;
+			}
+			src_len = desc.length;
+
 			do {
 				dst_len = mbuf_size - dst_off;
 				if (dst_len == 0) {
@@ -457,10 +635,8 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				if (mbuf != mbuf_head)
 					rte_pktmbuf_pkt_len(mbuf_head) += cp_len;
 
-				rte_memcpy(rte_pktmbuf_mtod_offset(mbuf, void *,
-								   dst_off),
-					(uint8_t *)memif_get_buffer(proc_private, d0) +
-					src_off, cp_len);
+				rte_memcpy(rte_pktmbuf_mtod_offset(mbuf, void *, dst_off),
+					   src_data + src_off, cp_len);
 
 				src_off += cp_len;
 				dst_off += cp_len;
@@ -470,7 +646,7 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			cur_slot++;
 			n_slots--;
 
-			if (d0->flags & MEMIF_DESC_FLAG_NEXT) {
+			if (desc.flags & MEMIF_DESC_FLAG_NEXT) {
 				if (unlikely(n_slots == 0)) {
 					mq->n_err++;
 					rte_pktmbuf_free(mbuf_head);
@@ -482,6 +658,17 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			mq->n_bytes += rte_pktmbuf_pkt_len(mbuf_head);
 			*bufs++ = mbuf_head;
 			n_rx_pkts++;
+			continue;
+
+discard2:
+			/* Skip the remainder of this descriptor chain. */
+			while (1) {
+				cur_slot++;
+				n_slots--;
+				if (n_slots == 0 || (desc.flags & MEMIF_DESC_FLAG_NEXT) == 0)
+					break;
+				desc = memif_desc_read(&ring->desc[cur_slot & mask]);
+			}
 		}
 	}
 
@@ -657,9 +844,14 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		rte_eth_devices[mq->in_port].process_private;
 	memif_ring_t *ring = memif_get_ring_from_queue(proc_private, mq);
 	uint16_t slot, saved_slot, n_free, ring_size, mask, n_tx_pkts = 0;
+	/* Counted in n_tx_pkts to pass ownership, but never transmitted. */
+	uint16_t n_drop_pkts = 0;
 	uint16_t src_len, src_off, dst_len, dst_off, cp_len, nb_segs;
+	uint32_t len;
+	uint8_t *dst_data;
 	memif_ring_type_t type = mq->type;
 	memif_desc_t *d0;
+	memif_desc_t desc;
 	struct rte_mbuf *mbuf;
 	struct rte_mbuf *mbuf_head;
 	uint64_t a;
@@ -726,12 +918,24 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 next_in_chain1:
 			d0 = &ring->desc[slot & mask];
-			d0->flags = 0;
+			desc = memif_desc_read(d0);
 			cp_len = rte_pktmbuf_data_len(mbuf);
 
-			rte_memcpy((uint8_t *)memif_get_buffer(proc_private, d0),
-				rte_pktmbuf_mtod(mbuf, void *), cp_len);
+			dst_data = memif_get_buffer(proc_private, mq, &desc, cp_len, cp_len);
+			if (unlikely(dst_data == NULL)) {
+				/*
+				 * The descriptor is bad, so this packet can never be sent.
+				 * Rewind the slots it used and count it as transmitted.
+				 */
+				slot = saved_slot;
+				n_tx_pkts++;
+				n_drop_pkts++;
+				goto free_mbufs;
+			}
+
+			rte_memcpy(dst_data, rte_pktmbuf_mtod(mbuf, void *), cp_len);
 
+			d0->flags = 0;
 			d0->length = cp_len;
 			mq->n_bytes += cp_len;
 			slot++;
@@ -760,10 +964,25 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 			saved_slot = slot;
 			d0 = &ring->desc[slot & mask];
+			desc = memif_desc_read(d0);
 			d0->flags = 0;
 			dst_off = 0;
-			dst_len = (type == MEMIF_RING_C2S) ?
-				pmd->run.pkt_buffer_size : d0->length;
+			/*
+			 * On a S2C ring the buffer length is supplied by the peer,
+			 * so validate it at full width before narrowing. A zero
+			 * length buffer makes no progress, so reject it here.
+			 */
+			len = (type == MEMIF_RING_C2S) ?
+				pmd->run.pkt_buffer_size : desc.length;
+			if (unlikely(len == 0)) {
+				memif_desc_error(mq, &desc, MEMIF_DESC_STATUS_ERR_ZERO_LENGTH);
+				goto drop_mbuf;
+			}
+
+			dst_data = memif_get_buffer(proc_private, mq, &desc, len, len);
+			if (unlikely(dst_data == NULL))
+				goto drop_mbuf;
+			dst_len = len;
 
 next_in_chain2:
 			src_off = 0;
@@ -776,10 +995,25 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 						n_free--;
 						d0->flags = MEMIF_DESC_FLAG_NEXT;
 						d0 = &ring->desc[slot & mask];
+						desc = memif_desc_read(d0);
 						d0->flags = 0;
 						dst_off = 0;
-						dst_len = (type == MEMIF_RING_C2S) ?
-						    pmd->run.pkt_buffer_size : d0->length;
+						len = (type == MEMIF_RING_C2S) ?
+						    pmd->run.pkt_buffer_size : desc.length;
+						if (unlikely(len == 0)) {
+							memif_desc_error(mq, &desc,
+								MEMIF_DESC_STATUS_ERR_ZERO_LENGTH);
+							slot = saved_slot;
+							goto drop_mbuf;
+						}
+
+						dst_data = memif_get_buffer(proc_private, mq,
+									    &desc, len, len);
+						if (unlikely(dst_data == NULL)) {
+							slot = saved_slot;
+							goto drop_mbuf;
+						}
+						dst_len = len;
 					} else {
 						slot = saved_slot;
 						goto no_free_slots;
@@ -787,10 +1021,9 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				}
 				cp_len = RTE_MIN(dst_len, src_len);
 
-				rte_memcpy((uint8_t *)memif_get_buffer(proc_private,
-								       d0) + dst_off,
-					rte_pktmbuf_mtod_offset(mbuf, void *, src_off),
-					cp_len);
+				rte_memcpy(dst_data + dst_off,
+					   rte_pktmbuf_mtod_offset(mbuf, void *, src_off),
+					   cp_len);
 
 				mq->n_bytes += cp_len;
 				src_off += cp_len;
@@ -811,6 +1044,13 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			n_free--;
 			rte_pktmbuf_free(mbuf_head);
 		}
+		goto no_free_slots;
+
+drop_mbuf:
+		/* The descriptor is bad, this packet can not be sent. */
+		n_tx_pkts++;
+		n_drop_pkts++;
+		rte_pktmbuf_free(mbuf_head);
 	}
 
 no_free_slots:
@@ -830,7 +1070,11 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 	}
 
-	mq->n_pkts += n_tx_pkts;
+	/*
+	 * Dropped packets are counted in n_tx_pkts so the caller does not
+	 * free them again, but they were never put on the wire.
+	 */
+	mq->n_pkts += n_tx_pkts - n_drop_pkts;
 	return n_tx_pkts;
 }
 
@@ -1412,8 +1656,13 @@ memif_dev_start(struct rte_eth_dev *dev)
 static int
 memif_dev_stop(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *pmd = dev->data->dev_private;
 	uint16_t i;
 
+	/* Drop any deferred bad descriptor disconnect, this supersedes it. */
+	rte_eal_alarm_cancel(memif_bad_desc_disconnect, dev);
+	rte_atomic_store_explicit(&pmd->bad_desc, false, rte_memory_order_relaxed);
+
 	memif_disconnect(dev);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
@@ -1624,6 +1873,7 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		}
 		stats->opackets += mq->n_pkts;
 		stats->obytes += mq->n_bytes;
+		stats->oerrors += mq->n_err;
 	}
 	return 0;
 }
diff --git a/drivers/net/memif/rte_eth_memif.h b/drivers/net/memif/rte_eth_memif.h
index 9c7a3a93f0..398a1f7baf 100644
--- a/drivers/net/memif/rte_eth_memif.h
+++ b/drivers/net/memif/rte_eth_memif.h
@@ -98,6 +98,7 @@ struct pmd_internals {
 
 	struct memif_control_channel *cc;	/**< control channel */
 	rte_spinlock_t cc_lock;			/**< control channel lock */
+	RTE_ATOMIC(bool) bad_desc;		/**< peer supplied bad descriptor */
 
 	/* remote info */
 	char remote_name[RTE_DEV_NAME_MAX_LEN];		/**< remote app name */
-- 
2.53.0

