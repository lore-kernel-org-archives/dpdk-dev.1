Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62236CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 07:06:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C03940296;
	Tue, 19 May 2026 09:06:39 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id C8D604021E;
 Tue, 19 May 2026 09:06:38 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKQgr2VYLzHnGjc;
 Tue, 19 May 2026 15:06:16 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 99FDD40570;
 Tue, 19 May 2026 15:06:37 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 08:06:36 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 19 May 2026 08:06:36 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "techboard@dpdk.org" <techboard@dpdk.org>, "mattias.ronnblom@ericsson.com"
 <mattias.ronnblom@ericsson.com>
Subject: RE: Memory management BoF summary (DPDK Summit 2026)
Thread-Topic: Memory management BoF summary (DPDK Summit 2026)
Thread-Index: AdzmoVFwN4xj0n6ARyCQahjMRW9t3wAbJqnA
Date: Tue, 19 May 2026 07:06:36 +0000
Message-ID: <f6a160e5cdf8477ea32c649a4dd7547c@huawei.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F6587B@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6587B@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.15]
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



> There are two ways of allocating/freeing memory objects in DPDK:
> 1.	From the memory heap, i.e. rte_malloc() etc.
> 2.	From a memory pool, i.e. rte_mempool_get() etc.
>=20
> The current memory heap in DPDK has two issues:
> -	It is too slow to be used in the fast path.
> -	There may be contention between control threads and
> 	EAL threads for the same spinlocks in the heap.
>=20
> The memory pools in the DPDK has multiple issues:
> -	It is designed for fixed size objects,
> 	so individual mempools must be allocated for each type of object.
> 	(In theory, mempools could be allocated per object size,
> 	and shared across modules.
> 	But that would require coordination across modules, including
> 	the total number of objects required by these modules,
> 	the choice of underlying mempool driver,
> 	and the optimal mempool cache size.)
> -	The number of objects in each mempool is fixed,
> 	so applications have to size their mempools to worst case usage.
> -	The memory for the objects in a mempool is pre-allocated.
> In summary, mempools consume significantly more memory than effectively
> being used.
>=20
> We discussed the need for a new memory heap system,
> and converged on the following features:
> -	Providing functions to allocate and free memory objects of varying
> 	size, like the rte_malloc library, but usable in the fast path.
> -	Perhaps also a need for bulk alloc/free functions,
> 	like the rte_mempool library.
> -	Building on top of memzones.
> -	No dependency on the current DPDK heap, so it can cleanly replace it.
> 	This is a stretch requirement.
> -	NUMA aware.
> -	Using slabs for various block sizes like in the Linux Kernel,
> 	possibly with object size 2^N.
> -	Using per-lcore caches to reduce contention,
> 	resembling the mempool per-lcore caches.
>=20
> Mattias R=F6nnblom has implemented a prototype with the above properties,
> and this was a good starting point for the discussion.
>=20
> Discussion:
> -	It does not seem to be a requirement to be able to free the memory
> 	used by the heap back to the memzones.
> -	It is possible having header-less objects.
> 	However, if the headers are relatively small compared to the size of
> 	the objects themselves, having a header may offer some benefits.
> -	The mempool library has implementation details optimizing for
> 	spreading usage across memory channels, cache alignment, etc..
> 	Such performance optimization details might need consideration.
> -	There is a lower limit to how small objects will be allocated.
> 	E.g. objects smaller than the size of a pointer is unlikely.
> -	It is acceptable to return an object larger than the size requested,
> 	e.g. returning an object of 16 bytes when 12 bytes were requested.
> -	Preventing false sharing of allocated objects between CPU caches
> 	may not be necessary, but must be considered.
> -	Optimally, the new heap should replace the existing heap.
> 	As seen with the timer wheel library previously proposed, replacing
> 	core libraries in DPDK is difficult, so adding the new heap library
> 	in parallel with the existing heap, i.e. with separate APIs, might be
> 	a path of less resistance.
> 	It will then be an application choice to use this new memory heap.
> 	And long term, it can replace the existing heap, if appropriate.
>=20
> Mbuf discussion:
> -	As a stretch goal, mbufs should be dynamically allocated from
> 	the new heap, instead of being pre-allocated in mempools.
> -	This might be achievable either
> 	-	by replacing the mempool library with a wrapper to the heap, or
> 	-	by providing a new mempool driver using the heap, as an
> 		alternative to the existing ring and stack mempool drivers.
> -	In this context, it is important to note that mbuf objects have some
> 	pre-initialized fields when held in their respective mempools.
> 	If allocating an mbuf directly from the heap, these fields must
> 	somehow be initialized.
> 	We did not discuss solutions for this, but noted that using the new
> 	heap for mbufs should be considered in the design choices.
>=20

Thanks Morten and Mattias, good summary and interesting discussion.
I also agree that DPDK will benefit from mem-allocator, that=20
probably will be not as fast as mempool, but will provide more flexibility
and will not require up-front memory pre-allocation:
still fixed size objects in the pool, slab-like mechanics underneath, abili=
ty to grow/shrink on demand.
Internally we have the lib that satisfies some of the functional requiremen=
ts above.
If time permits, ant there is an interest from the community, will also try=
 to send an RFC for it,
might be it will help to blend few things together.
Konstantin  =20


