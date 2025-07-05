Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF1C8303D
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Jul 2025 07:44:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C9944028C;
	Sat,  5 Jul 2025 09:44:37 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 3C24440287
 for <dev@dpdk.org>; Sat,  5 Jul 2025 09:44:35 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bZ2Z75wyPz6L578;
 Sat,  5 Jul 2025 15:43:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 951D21402F5;
 Sat,  5 Jul 2025 15:44:34 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 5 Jul 2025 09:44:34 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Sat, 5 Jul 2025 09:44:34 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC] ethdev: TX mbuf fast release optimization
Thread-Topic: [RFC] ethdev: TX mbuf fast release optimization
Thread-Index: AdvsIqk6dXfxyQ/IQSK9FKicZXvNKwA28pmQACBkzjA=
Date: Sat, 5 Jul 2025 07:44:34 +0000
Message-ID: <cefc9412679c4257bed9e604b86f5a9c@huawei.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD87@smartserver.smartshare.dk>
 <395df6c41a554ee29b122d7f85950690@huawei.com>
In-Reply-To: <395df6c41a554ee29b122d7f85950690@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.243]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> -----Original Message-----
> From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Sent: Friday, July 4, 2025 5:20 PM
> To: Morten Br=F8rup <mb@smartsharesystems.com>; thomas@monjalon.net; Bruc=
e Richardson <bruce.richardson@intel.com>
> Cc: dev@dpdk.org
> Subject: RE: [RFC] ethdev: TX mbuf fast release optimization
>=20
>=20
> > For TX mbuf fast release offload, I propose to add the mbuf mempool
> > pointer to the ethdev tx queue configuration structure,
> > so the ethdev TX burst operation doesn't need to fetch it from the
> > first mbuf of each burst being fast free'd to the mempool.
> >
> > This modification of the struct rte_eth_txconf, and the requirement
> > to set the mempool pointer if the RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
> > flag is set, will be an API+ABI change in 25.11.
> > Should it be announced in the 25.07 release notes?
> >
> > Note: We could phase it in softly by letting the ethdev drivers
> > check if the pointer has been set, and fall back to fetching it
> > from mbuf[0] if not.
> >
> > /**
> >  * A structure used to configure a Tx ring of an Ethernet port.
> >  */
> > struct rte_eth_txconf {
> > 	struct rte_eth_thresh tx_thresh; /**< Tx ring threshold registers. */
> > 	uint16_t tx_rs_thresh; /**< Drives the setting of RS bit on TXDs. */
> > 	uint16_t tx_free_thresh; /**< Start freeing Tx buffers if there are
> > 				      less free descriptors than this value. */
> >
> > 	uint8_t tx_deferred_start; /**< Do not start queue with rte_eth_dev_st=
art(). */
> > 	/**
> > 	 * Per-queue Tx offloads to be set  using RTE_ETH_TX_OFFLOAD_* flags.
> > 	 * Only offloads set on tx_queue_offload_capa or tx_offload_capa
> > 	 * fields on rte_eth_dev_info structure are allowed to be set.
> > 	 */
> > 	uint64_t offloads;
> >
> > +	/**
> > +	 * Per-queue mempool to release the mbufs to; required for
> > +	 * RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > +	 */
> > +	struct rte_mempool *mp;
> > +
>=20
> Even though I usually recommend to use MBUF_FAST_FREE -

Correction, meant to say: I usually recommend not to use MBUF_FAST_FREE.
The rest remains the same :)

> that's probably a good change.
> At least people will realize that they have to provide a single mempool
> per TX queue when they enable FAST_FREE flag.
> One naming suggestion I have - can we name it somehow more informative:
> 'fast_free_mp' or so?
> Also, we can update tx_queue_setup() to catch the situation when FAST_FRE=
E
> is set but mp is NULL, or visa-versa.
> Again drivers can probably add extra check when debug is enabled, that
> all mbufs are exactly from that mempool.
>=20
>=20
> > 	uint64_t reserved_64s[2]; /**< Reserved for future fields */
> > 	void *reserved_ptrs[2];   /**< Reserved for future fields */
> > };
> >

