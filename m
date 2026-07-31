Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81014C5516F
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 08:23:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D7FE402BB;
	Sat,  1 Aug 2026 10:23:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4409540299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 10:23:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com (unknown [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 248A7226C5;
 Fri, 31 Jul 2026 16:47:41 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC 13/32] ring: replace SMP read barrier with C11 acquire fence
Date: Fri, 31 Jul 2026 16:47:39 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659A9@smartserver.smartshare.dk>
In-Reply-To: <20260729175715.165120-14-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [RFC 13/32] ring: replace SMP read barrier with C11 acquire fence
Thread-Index: Ad0fg+S9v1s/gsMRRaeIj5+Rn2jSqQBd5hTA
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-14-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Wednesday, 29 July 2026 19.54
>=20
> rte_smp_rmb() is deprecated. The acquire fence generates the same
> code everywhere the gcc implementation is used: a compiler barrier
> on x86 and dmb ishld on ThunderX.
>=20
> The gcc implementation itself is kept: unlike the lock-free stack,
> the in-tree comment records a 10% x86 performance drop with the
> C11 version, which needs re-measuring with current compilers
> before RTE_USE_C11_MEM_MODEL can be removed.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ring/rte_ring_gcc_pvt.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
> index 340ece28c7..9c2c58824d 100644
> --- a/lib/ring/rte_ring_gcc_pvt.h
> +++ b/lib/ring/rte_ring_gcc_pvt.h
> @@ -55,10 +55,10 @@ __rte_ring_headtail_move_head_st(struct
> rte_ring_headtail *d,
>=20
>  	*old_head =3D d->head;
>=20
> -	/* add rmb barrier to avoid load/load reorder in weak
> -	 * memory model. It is noop on x86
> +	/* Acquire fence to avoid load/load reorder in weak
> +	 * memory model. It is noop on x86.
>  	 */
> -	rte_smp_rmb();
> +	rte_atomic_thread_fence(rte_memory_order_acquire);
>=20
>  	/*
>  	 *  The subtraction is done between two unsigned 32bits value
> --
> 2.53.0

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

