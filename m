Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F172DCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 09:06:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE97040695;
	Fri, 22 Aug 2025 11:05:08 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A48FA40695
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:05:07 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 85930209AA;
 Fri, 22 Aug 2025 11:05:07 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [RFC 1/3] hash: move table of hash compare functions out of header
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Aug 2025 11:05:06 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE5F@smartserver.smartshare.dk>
In-Reply-To: <20250821203646.133506-2-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 1/3] hash: move table of hash compare functions out of
 header
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdwS21jiOe3yS9WiQrOQTe4L8AZvOQAZNFUQ
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250821203646.133506-2-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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
> Sent: Thursday, 21 August 2025 22.35
>=20
> Remove the definition of the compare jump table from the
> header file so the internal details are not exposed.
> Prevents future ABI breakage if new sizes are added.
>=20
> Make other macros local if possible, header should
> only contain exposed API.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

[...]

> +/*
> + * All different options to select a key compare function,
> + * based on the key size and custom function.
> + * Not in rte_cuckoo_hash.h to avoid ABI issues.
> + */
> +enum cmp_jump_table_case {
> +	KEY_CUSTOM =3D 0,
> +#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
> +	KEY_16_BYTES,
> +	KEY_32_BYTES,
> +	KEY_48_BYTES,
> +	KEY_64_BYTES,
> +	KEY_80_BYTES,
> +	KEY_96_BYTES,
> +	KEY_112_BYTES,
> +	KEY_128_BYTES,
> +#endif
> +	KEY_OTHER_BYTES,
> +	NUM_KEY_CMP_CASES,
> +};
>=20
>  /* Enum used to select the implementation of the signature comparison
> function to use
>   * eg: a system supporting SVE might want to use a NEON or scalar
> implementation.
> @@ -117,6 +154,25 @@ void rte_hash_set_cmp_func(struct rte_hash *h,
> rte_hash_cmp_eq_t func)
>  	h->rte_hash_custom_cmp_eq =3D func;
>  }
>=20
> +/*
> + * Table storing all different key compare functions
> + * (multi-process supported)
> + */
> +static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] =3D =
{
> +	[KEY_CUSTOM] =3D NULL,
> +#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
> +	[KEY_16_BYTES] =3D rte_hash_k16_cmp_eq,
> +	[KEY_32_BYTES] =3D rte_hash_k32_cmp_eq,
> +	[KEY_48_BYTES] =3D rte_hash_k48_cmp_eq,
> +	[KEY_64_BYTES] =3D rte_hash_k64_cmp_eq,
> +	[KEY_80_BYTES] =3D rte_hash_k80_cmp_eq,
> +	[KEY_96_BYTES] =3D rte_hash_k96_cmp_eq,
> +	[KEY_112_BYTES] =3D rte_hash_k112_cmp_eq,
> +	[KEY_128_BYTES] =3D rte_hash_k128_cmp_eq,
> +#endif
> +	[KEY_OTHER_BYTES] =3D memcmp,
> +};

Nice trick explicitly indexing these here; it reduces the risk of not =
matching the cmp_jump_table_case.

Consider adding static_assert() that RTE_DIM(cmp_jump_table) =3D=3D =
NUM_KEY_CMP_CASES.

With or without suggested static_assert()...
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

Good cleanup!

