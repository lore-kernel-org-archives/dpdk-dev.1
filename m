Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD8EE83061
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 08:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1BE440611;
	Tue,  3 Feb 2026 09:24:30 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5D2F3402A2;
 Tue,  3 Feb 2026 09:24:29 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 367DB206EC;
 Tue,  3 Feb 2026 09:24:29 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v17 1/2] eal: remove alloc_size from rte_lcore_var_alloc
Date: Tue, 3 Feb 2026 09:24:26 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656E5@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260202052442.92192-2-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v17 1/2] eal: remove alloc_size from rte_lcore_var_alloc
Thread-Index: AdyUBED8gncKqVNYT2630YyYxKp1HgA4cKoA
References: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-2-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <bruce.richardson@intel.com>,
 <mattias.ronnblom@ericsson.com>, <stable@dpdk.org>
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

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> The __rte_alloc_size(1) attribute on rte_lcore_var_alloc() is
> semantically incorrect and causes false positives with FORTIFY_SOURCE
> runtime checks.
>=20
> The attribute tells the compiler that the function returns a pointer
> to 'size' bytes of usable memory. However, rte_lcore_var_alloc()
> actually returns a handle to a per-lcore variable scheme. The
> allocator internally allocates 'size' bytes per lcore
> (size * RTE_MAX_LCORE total), partitioned into per-lcore sections.
> The handle points to lcore 0's copy, and accessed via
> RTE_LCORE_VAR_LCORE(lcore_id, handle) which computes:
> handle + (lcore_id * RTE_MAX_LCORE_VAR). Access is expected
> beyond 'size' bytes beyond the returned pointer when 'lcore_id !=3D 0'
> but FORTIFY_SOURCE may terminate the program due to out of bounds
> access.
>=20
> This can be observed on CI with gcc 13.3.0 in lcore_var_autotest with
> '*** buffer overflow detected ***: terminated' if pointer provenance
> is preserved (e.g. if offsets avoid casting to uintptr_t).
>=20
> Fixes: 5bce9bed67ad ("eal: add static per-lcore memory allocation
> facility")
> Cc: mattias.ronnblom@ericsson.com
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---
>  lib/eal/include/rte_lcore_var.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/eal/include/rte_lcore_var.h
> b/lib/eal/include/rte_lcore_var.h
> index ca31dff6fd..48b022e84e 100644
> --- a/lib/eal/include/rte_lcore_var.h
> +++ b/lib/eal/include/rte_lcore_var.h
> @@ -202,7 +202,7 @@ rte_lcore_var_lcore(unsigned int lcore_id, void
> *handle)
>  __rte_experimental
>  void *
>  rte_lcore_var_alloc(size_t size, size_t align)
> -	__rte_alloc_size(1) __rte_alloc_align(2);
> +	__rte_alloc_align(2);
>=20
>  #ifdef __cplusplus
>  }
> --
> 2.39.5 (Apple Git-154)

This patch could be separated from the RTE_PTR_ADD/SUB series.

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

NB: Please keep this ACK for any new versions of this patch if the =
essence of the patch doesn't change.

