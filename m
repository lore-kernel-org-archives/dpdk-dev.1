Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1122C83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 13:59:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B8240267;
	Thu,  3 Jul 2025 15:59:18 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0285640264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 15:59:16 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BEDE020636;
 Thu,  3 Jul 2025 15:59:16 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [RFC] ethdev: TX mbuf fast release optimization
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 3 Jul 2025 15:59:14 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD87@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] ethdev: TX mbuf fast release optimization
Thread-Index: AdvsIqk6dXfxyQ/IQSK9FKicZXvNKw==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <thomas@monjalon.net>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
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

For TX mbuf fast release offload, I propose to add the mbuf mempool
pointer to the ethdev tx queue configuration structure,
so the ethdev TX burst operation doesn't need to fetch it from the
first mbuf of each burst being fast free'd to the mempool.

This modification of the struct rte_eth_txconf, and the requirement
to set the mempool pointer if the RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
flag is set, will be an API+ABI change in 25.11.
Should it be announced in the 25.07 release notes?

Note: We could phase it in softly by letting the ethdev drivers
check if the pointer has been set, and fall back to fetching it
from mbuf[0] if not.

/**
 * A structure used to configure a Tx ring of an Ethernet port.
 */
struct rte_eth_txconf {
	struct rte_eth_thresh tx_thresh; /**< Tx ring threshold registers. */
	uint16_t tx_rs_thresh; /**< Drives the setting of RS bit on TXDs. */
	uint16_t tx_free_thresh; /**< Start freeing Tx buffers if there are
				      less free descriptors than this value. */

	uint8_t tx_deferred_start; /**< Do not start queue with =
rte_eth_dev_start(). */
	/**
	 * Per-queue Tx offloads to be set  using RTE_ETH_TX_OFFLOAD_* flags.
	 * Only offloads set on tx_queue_offload_capa or tx_offload_capa
	 * fields on rte_eth_dev_info structure are allowed to be set.
	 */
	uint64_t offloads;

+	/**
+	 * Per-queue mempool to release the mbufs to; required for
+	 * RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
+	 */
+	struct rte_mempool *mp;
+
	uint64_t reserved_64s[2]; /**< Reserved for future fields */
	void *reserved_ptrs[2];   /**< Reserved for future fields */
};

