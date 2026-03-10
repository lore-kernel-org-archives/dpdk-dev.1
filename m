Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF64EB1052
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8055402DC;
	Tue, 10 Mar 2026 15:10:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EAA08402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 15:10:37 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BFBA4209B9;
 Tue, 10 Mar 2026 15:10:37 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: mempool name size incorrect?
Date: Tue, 10 Mar 2026 15:10:35 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65773@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: mempool name size incorrect?
Thread-Index: Adywl6pOeioOieCEStaA8yIKq8lxpw==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
	<dev@dpdk.org>
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

Isn't the RTE_MEMPOOL_NAMESIZE too short?

Looking at the names sizes:

RTE_MEMZONE_NAMESIZE =3D 32,
RTE_RING_NAMESIZE =3D RTE_MEMZONE_NAMESIZE - (sizeof("RG_")=3D4) + 1 =3D =
29,
RTE_MEMPOOL_NAMESIZE =3D RTE_RING_NAMESIZE - (sizeof("MP_")=3D4) + 1 =3D =
26

Referring to [1], I think it should be fixed as:
- #define RTE_MEMPOOL_NAMESIZE (RTE_RING_NAMESIZE - \
			      sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)
+ #define RTE_MEMPOOL_NAMESIZE (RTE_MEMZONE_NAMESIZE - \
			      sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)

There is no ring involved, so I guess it is some kind of =
copy-paste-search-replace error.


Looking at the rte_mempool structure [2]:
struct __rte_cache_aligned rte_mempool {
	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
	union {
		void *pool_data;         /**< Ring or pool to store objects. */
		uint64_t pool_id;        /**< External mempool identifier. */
	};


Due to the 8-byte alignment of the pool_id field following the name =
field, fixing the length as suggested doesn't change the memory layout =
for 64 bit CPU architectures.
But it does for 32 bit CPU architectures, which will only 4-byte align =
the pool_id field.

[1]: =
https://elixir.bootlin.com/dpdk/v26.03-rc1/source/lib/mempool/rte_mempool=
.h#L128
[2]: =
https://elixir.bootlin.com/dpdk/v26.03-rc1/source/lib/mempool/rte_mempool=
.h#L230


Another thing:
On 32 bit CPU architectures, the cache_size and local_cache fields in =
the rte_mempool structure are not in the same cache line.
But I guess we don't really care about 32 bit CPU architectures.


Venlig hilsen / Kind regards,
-Morten Br=F8rup

