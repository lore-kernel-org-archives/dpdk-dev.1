Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839FD6409D
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 09:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 603EE40275;
	Wed, 17 Dec 2025 10:25:30 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 988594026C;
 Wed, 17 Dec 2025 10:25:28 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 640E4202CC;
 Wed, 17 Dec 2025 10:25:27 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 1/5] eal: variable first arguments of RTE_SHIFT_VALxx
Date: Wed, 17 Dec 2025 10:25:26 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655F0@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251216182036.77869-2-marat.khalili@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/5] eal: variable first arguments of RTE_SHIFT_VALxx
Thread-Index: AdxuuMHbKUs3FF6ZTvyl3TAwuslQvwAffkSQ
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251216182036.77869-2-marat.khalili@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Marat Khalili" <marat.khalili@huawei.com>, <stephen@networkplumber.org>,
 <jerinjacobk@gmail.com>,
 "Jack Bond-Preston" <jack.bond-preston@foss.arm.com>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>,
	<konstantin.ananyev@huawei.com>
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

> From: Marat Khalili [mailto:marat.khalili@huawei.com]
> Sent: Tuesday, 16 December 2025 19.21
>=20
> Macros RTE_SHIFT_VAL32 and RTE_SHIFT_VAL64 were implemented by =
applying
> UINT32_C or UINT64_C correspondingly to its first argument. As a
> consequence first argument had to be a constant. Replace UINT32_C and
> UINT64_C with casts to uint32_t and uint64_t to allow these arguments
> be
> variable. For constants the result should be the same.
>=20
> (Yes, technically UINT64_C promotes to uint_least64_t, not uint64_t,
> but
> I think most users of RTE_SHIFT_VAL64 expect the result to be
> uint64_t.)

Interesting detail.
And yes, I agree about expectations.

>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  lib/eal/include/rte_bitops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/eal/include/rte_bitops.h
> b/lib/eal/include/rte_bitops.h
> index 2d1b9d281c..aa6ac73abb 100644
> --- a/lib/eal/include/rte_bitops.h
> +++ b/lib/eal/include/rte_bitops.h
> @@ -51,7 +51,7 @@ extern "C" {
>   * @param nr
>   *   The shift number in range of 0 to (32 - width of val).
>   */
> -#define RTE_SHIFT_VAL32(val, nr) (UINT32_C(val) << (nr))
> +#define RTE_SHIFT_VAL32(val, nr) ((uint32_t)(val) << (nr))
>=20
>  /**
>   * Get the uint64_t shifted value.
> @@ -61,7 +61,7 @@ extern "C" {
>   * @param nr
>   *   The shift number in range of 0 to (64 - width of val).
>   */
> -#define RTE_SHIFT_VAL64(val, nr) (UINT64_C(val) << (nr))
> +#define RTE_SHIFT_VAL64(val, nr) ((uint64_t)(val) << (nr))
>=20
>  /**
>   * Generate a contiguous 32-bit mask
> --
> 2.43.0

Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>

