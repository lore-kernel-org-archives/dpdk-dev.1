Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C1CD277C1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 15:29:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D713F4028E;
	Sat, 10 Jan 2026 16:29:18 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 52DFA40144
 for <dev@dpdk.org>; Sat, 10 Jan 2026 16:29:17 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 771E120679;
 Sat, 10 Jan 2026 16:29:16 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v12 3/3] eal/net: add workaround for GCC optimization bug
Date: Sat, 10 Jan 2026 16:29:14 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65648@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260110015651.26201-4-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v12 3/3] eal/net: add workaround for GCC optimization bug
Thread-Index: AdyB1HLgl4G3XQXGR16Zz+0J/2oxxAAbqGTA
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
 <20260110015651.26201-4-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>,
	"Scott" <scott_mitchell@apple.com>
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

> From: Scott <scott_mitchell@apple.com>
>=20
> GCC has a bug where it incorrectly elides struct initialization in
> inline functions when strict aliasing is enabled (-O2/-O3/-Os), =
causing
> reads from uninitialized memory. This affects both designated
> initializers and manual field assignment.

Does this still happen after you replaced the RTE_PTR_ADD() with native =
pointer arithmetic in the checksum function?
In other words: Is this workaround still necessary?

This is a showstopper:
If the workaround is necessary, applications with similar use cases also =
need to apply the workaround.
If we cannot somehow enforce that, the series is likely to break some =
applications, which is unacceptable.

>=20
> Add RTE_FORCE_INIT_BARRIER macro that uses an asm volatile memory
> barrier
> to prevent the compiler from incorrectly optimizing away struct
> initialization. Apply the workaround to pseudo-header checksum
> functions
> in rte_ip4.h, rte_ip6.h, hinic driver, and mlx5 driver.
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---
>  drivers/net/hinic/hinic_pmd_tx.c |  2 ++
>  drivers/net/mlx5/mlx5_flow_dv.c  |  2 ++
>  lib/eal/include/rte_common.h     | 14 ++++++++++++++
>  lib/net/rte_ip4.h                |  1 +
>  lib/net/rte_ip6.h                |  1 +
>  5 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/net/hinic/hinic_pmd_tx.c
> b/drivers/net/hinic/hinic_pmd_tx.c
> index 22fb0bffaf..570715531d 100644
> --- a/drivers/net/hinic/hinic_pmd_tx.c
> +++ b/drivers/net/hinic/hinic_pmd_tx.c
> @@ -725,6 +725,7 @@ hinic_ipv4_phdr_cksum(const struct rte_ipv4_hdr
> *ipv4_hdr, uint64_t ol_flags)
>  		rte_cpu_to_be_16(rte_be_to_cpu_16(ipv4_hdr->total_length) -
>  				 rte_ipv4_hdr_len(ipv4_hdr));
>  	}
> +	RTE_FORCE_INIT_BARRIER(psd_hdr);
>  	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
>  }
>=20
> @@ -743,6 +744,7 @@ hinic_ipv6_phdr_cksum(const struct rte_ipv6_hdr
> *ipv6_hdr, uint64_t ol_flags)
>  	else
>  		psd_hdr.len =3D ipv6_hdr->payload_len;
>=20
> +	RTE_FORCE_INIT_BARRIER(psd_hdr);
>  	sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
>  		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
> 0);
>  	sum =3D __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c
> b/drivers/net/mlx5/mlx5_flow_dv.c
> index 47f6d28410..1eeeb6747f 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -4445,6 +4445,8 @@ __flow_encap_decap_resource_register(struct
> rte_eth_dev *dev,
>  			.reserve =3D 0,
>  		}
>  	};
> +	RTE_FORCE_INIT_BARRIER(encap_decap_key);
> +
>  	struct mlx5_flow_cb_ctx ctx =3D {
>  		.error =3D error,
>  		.data =3D resource,
> diff --git a/lib/eal/include/rte_common.h
> b/lib/eal/include/rte_common.h
> index 00d428e295..d58e856d96 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -555,6 +555,20 @@ static void
> __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
>  #define __rte_no_ubsan_alignment
>  #endif
>=20
> +/**
> + * Force struct initialization to prevent GCC optimization bug.
> + * GCC has a bug where it incorrectly elides struct initialization in
> + * inline functions when strict aliasing is enabled, causing reads
> from
> + * uninitialized memory. This memory barrier prevents the
> misoptimization.
> + */
> +#ifdef RTE_CC_GCC
> +#define RTE_FORCE_INIT_BARRIER(var) do {	\
> +	asm volatile("" : "+m" (var));		\
> +} while (0)
> +#else
> +#define RTE_FORCE_INIT_BARRIER(var)
> +#endif
> +
>  /*********** Macros for pointer arithmetic ********/
>=20
>  /**
> diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
> index 822a660cfb..a0839c584e 100644
> --- a/lib/net/rte_ip4.h
> +++ b/lib/net/rte_ip4.h
> @@ -238,6 +238,7 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr
> *ipv4_hdr, uint64_t ol_flags)
>  		psd_hdr.len =3D rte_cpu_to_be_16((uint16_t)(l3_len -
>  			rte_ipv4_hdr_len(ipv4_hdr)));
>  	}
> +	RTE_FORCE_INIT_BARRIER(psd_hdr);
>  	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
>  }
>=20
> diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
> index d1abf1f5d5..902f100a44 100644
> --- a/lib/net/rte_ip6.h
> +++ b/lib/net/rte_ip6.h
> @@ -572,6 +572,7 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr
> *ipv6_hdr, uint64_t ol_flags)
>  	else
>  		psd_hdr.len =3D ipv6_hdr->payload_len;
>=20
> +	RTE_FORCE_INIT_BARRIER(psd_hdr);
>  	sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
>  		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
>  		0);
> --
> 2.39.5 (Apple Git-154)

