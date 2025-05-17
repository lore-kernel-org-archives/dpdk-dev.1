Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2970CC3ABDA
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 May 2025 10:07:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1CEE402E5;
	Sat, 17 May 2025 12:07:48 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4E112402E0
 for <dev@dpdk.org>; Sat, 17 May 2025 12:07:47 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2FFFC2064C;
 Sat, 17 May 2025 12:07:46 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 1/2] lib/fib: remove warning about implicit 64-bit
 conversion
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 17 May 2025 12:07:42 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC5D@smartserver.smartshare.dk>
In-Reply-To: <1747428335-3736-2-git-send-email-andremue@linux.microsoft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 1/2] lib/fib: remove warning about implicit 64-bit
 conversion
Thread-Index: AdvGo4RhCXazQX4XTQa2xIJ7dYffywAb/LZw
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-2-git-send-email-andremue@linux.microsoft.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>
Cc: <dev@dpdk.org>,
	<vladimir.medvedkin@intel.com>
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

> From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> Sent: Friday, 16 May 2025 22.46
>=20
> MSVC issues the warning below:
>=20
> ../lib/fib/trie.c(341): warning C4334: '<<':
> result of 32-bit shift implicitly converted to 64 bits
> (was 64-bit shift intended?)
>=20
> The fix is to cast (1) explicitly to uintptr_t since it is used
> in pointer arithmetic.
>=20
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/fib/trie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/fib/trie.c b/lib/fib/trie.c
> index 6c20057ac5..24a08b827d 100644
> --- a/lib/fib/trie.c
> +++ b/lib/fib/trie.c
> @@ -338,7 +338,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t
> *ip_part, uint64_t next_hop,
>  		if (ret < 0)
>  			return ret;
>  		if (edge =3D=3D LEDGE) {
> -			write_to_dp((uint8_t *)p + (1 << dp->nh_sz),
> +			write_to_dp(RTE_PTR_ADD(p, (uintptr_t)(1) << dp-
> >nh_sz),
>  				next_hop << 1, dp->nh_sz, UINT8_MAX -
> *ip_part);
>  		} else {
>  			write_to_dp(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
> --
> 2.49.0.vfs.0.3

Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>

