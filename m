Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCAFCD6E64
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 16:26:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A07A402AB;
	Tue,  2 Jun 2026 18:26:17 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EE9DC402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 18:26:15 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E8A49208EE;
 Tue,  2 Jun 2026 18:26:14 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 0/2] net/intel: optimize for fast-free hint
Date: Tue, 2 Jun 2026 18:26:13 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658DD@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260602154513.1079865-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 0/2] net/intel: optimize for fast-free hint
Thread-Index: AdzyptI5HHCdpGRiT/migeGbQZST6AABZOmw
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
 <20260602154513.1079865-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <ciara.loftus@intel.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Tuesday, 2 June 2026 17.45
>=20
> When the fast-free hint is provided to the driver we know that the
> mbufs
> have refcnt of 1 and are from the same mempool. Therefore, we can
> optimize a bit for this case even in the scalar path of our drivers.
>=20
> ---
> v4:
> * add precursor patch to adjust mbuf pointers so that the DD bit
>   is written to a descriptor with a valid mbuf pointer associated
>   with it.
>=20
> v3:
> * used mbuf_raw_free_bulk rather than mempool function directly
> * check for fast_free via mp pointer rather than flags
> * remove unnecessary prefetches
>=20
> V2: Fix issues with original submission:
> * missed check for NULL mbufs
> * fixed issue with freeing directly from sw_ring in scalar path which
>   doesn't work as thats not a flag array of pointers
> * fixed missing null assignment in case of large segments for TSO
>=20
>=20
> Bruce Richardson (2):
>   net/intel: write mbuf for last Tx desc of segment
>   net/intel: optimize for fast-free hint
>=20
>  drivers/net/intel/common/tx.h        | 21 ++++--
>  drivers/net/intel/common/tx_scalar.h | 98 =
+++++++++++++++++++++-------
>  2 files changed, 90 insertions(+), 29 deletions(-)
>=20
> --
> 2.53.0

Good catch by Ciara, and good solution to it.
Series-Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

