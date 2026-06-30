Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D54C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 09:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71ED84025E;
	Tue, 30 Jun 2026 11:32:57 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 57D284021E;
 Tue, 30 Jun 2026 11:32:55 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gqHwk5FXxzJ46ds;
 Tue, 30 Jun 2026 17:32:06 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 0FD0F4057A;
 Tue, 30 Jun 2026 17:32:53 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Jun 2026 10:32:52 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 30 Jun 2026 10:32:52 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 5/6] ip_frag: reject oversized reassembled datagrams
Thread-Topic: [PATCH 5/6] ip_frag: reject oversized reassembled datagrams
Thread-Index: AQHc/dQbZ/OUdWXWdkKeOmP6fbD2WLZW6wJQ
Date: Tue, 30 Jun 2026 09:32:52 +0000
Message-ID: <217a7790c9e74d9b89150f08fe68dbfd@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260616210656.464062-6-stephen@networkplumber.org>
In-Reply-To: <20260616210656.464062-6-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.205.173]
Content-Type: text/plain; charset="us-ascii"
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


> The reassembled total length of a packet must not exceed 65535.
> A fragment with a high offset could drive the sum past that,
> causing silent truncation since IP payload_len/total_length is 16 bits.
>=20
> When reassembling a packet the total length should not be allowed
> to exceed 65535. A fragment with high offset could drive the sum
> past that, causing silent truncation.
>=20
> A valid datagram never exceeds 65535 bytes, so reject any fragment
> whose resulting length would exceed that.
> Fold the test into the existing zero-length check.
>=20
> Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ip_frag/rte_ipv4_reassembly.c | 9 +++++++--
>  lib/ip_frag/rte_ipv6_reassembly.c | 9 +++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/ip_frag/rte_ipv4_reassembly.c b/lib/ip_frag/rte_ipv4_rea=
ssembly.c
> index 980f7a3b77..727fc58243 100644
> --- a/lib/ip_frag/rte_ipv4_reassembly.c
> +++ b/lib/ip_frag/rte_ipv4_reassembly.c
> @@ -136,8 +136,13 @@ rte_ipv4_frag_reassemble_packet(struct rte_ip_frag_t=
bl
> *tbl,
>  		tbl, tbl->max_cycles, tbl->entry_mask, tbl->max_entries,
>  		tbl->use_entries);
>=20
> -	/* check that fragment length is greater then zero. */
> -	if (ip_len <=3D 0) {
> +	/*
> +	 * Drop fragments with no payload, and any fragment whose end would
> +	 * make the reassembled datagram exceed the maximum IPv4 size. The
> +	 * total_length field is 16 bits, so otherwise it is silently
> +	 * truncated while the mbuf still holds the full length.
> +	 */
> +	if (ip_len <=3D 0 || ip_ofs + ip_len + mb->l3_len > UINT16_MAX) {
>  		IP_FRAG_MBUF2DR(dr, mb);
>  		return NULL;
>  	}
> diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_rea=
ssembly.c
> index 7c1659002b..0b44275b37 100644
> --- a/lib/ip_frag/rte_ipv6_reassembly.c
> +++ b/lib/ip_frag/rte_ipv6_reassembly.c
> @@ -174,8 +174,13 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_t=
bl
> *tbl,
>  		tbl, tbl->max_cycles, tbl->entry_mask, tbl->max_entries,
>  		tbl->use_entries);
>=20
> -	/* check that fragment length is greater then zero. */
> -	if (ip_len <=3D 0) {
> +	/*
> +	 * Drop fragments with no payload, and any fragment whose end would
> +	 * make the reassembled payload exceed 65535 bytes. The payload_len
> +	 * field is 16 bits, so otherwise it is silently truncated while the
> +	 * mbuf still holds the full length.
> +	 */
> +	if (ip_len <=3D 0 || ip_ofs + ip_len > UINT16_MAX) {
>  		IP_FRAG_MBUF2DR(dr, mb);
>  		return NULL;
>  	}
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

