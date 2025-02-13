Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489EBC0219D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 12:22:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1747A42EA9;
	Thu, 13 Feb 2025 13:22:33 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 8068040287;
 Thu, 13 Feb 2025 13:22:29 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YtvP23gZYz16KFY;
 Thu, 13 Feb 2025 20:19:02 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 809CC14037E;
 Thu, 13 Feb 2025 20:22:23 +0800 (CST)
Received: from kwepemn100010.china.huawei.com (7.202.194.113) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 20:22:23 +0800
Received: from kwepemd500024.china.huawei.com (7.221.188.194) by
 kwepemn100010.china.huawei.com (7.202.194.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 20:22:22 +0800
Received: from kwepemd500024.china.huawei.com ([7.221.188.194]) by
 kwepemd500024.china.huawei.com ([7.221.188.194]) with mapi id 15.02.1544.011; 
 Thu, 13 Feb 2025 20:22:12 +0800
From: "Wangyunjian(wangyunjian,TongTu)" <wangyunjian@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, "chenbox@nvidia.com" <chenbox@nvidia.com>,
 "Lilijun (Jerry)" <jerry.lilijun@huawei.com>, "xiawei (H)"
 <xiawei40@huawei.com>, wangzengyuan <wangzengyuan@huawei.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 1/1] vhost: fix a double fetch when dequeue offloading
Thread-Topic: [PATCH v2 1/1] vhost: fix a double fetch when dequeue offloading
Thread-Index: AQHbUpI+FCGDiyHbb0Sqz6JfQyy2bLLu2P4AgFalaDA=
Date: Thu, 13 Feb 2025 12:22:12 +0000
Message-ID: <dd21d206b0384a2db02d33d1cee860f1@huawei.com>
References: <91dc12662805a3867413940f856ba9454b91c579.1734588243.git.wangyunjian@huawei.com>
 <09058cfb25d7583f67d74f09cd36673f1b10f5ec.1734661755.git.wangyunjian@huawei.com>
 <20241220091052.68bb13ee@hermes.local>
In-Reply-To: <20241220091052.68bb13ee@hermes.local>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.242.157]
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


> -----Original Message-----
> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Saturday, December 21, 2024 1:11 AM
> To: Wangyunjian(wangyunjian,TongTu) <wangyunjian@huawei.com>
> Cc: dev@dpdk.org; maxime.coquelin@redhat.com; chenbox@nvidia.com;
> Lilijun (Jerry) <jerry.lilijun@huawei.com>; xiawei (H) <xiawei40@huawei.c=
om>;
> wangzengyuan <wangzengyuan@huawei.com>; stable@dpdk.org
> Subject: Re: [PATCH v2 1/1] vhost: fix a double fetch when dequeue offloa=
ding
>=20
> On Fri, 20 Dec 2024 11:49:55 +0800
> Yunjian Wang <wangyunjian@huawei.com> wrote:
>=20
> > The hdr->csum_start does two successive reads from user space to read a
> > variable length data structure. The result overflow if the data structu=
re
> > changes between the two reads.
> >
> > To fix this, we can prevent double fetch issue by copying virtio_hdr to
> > the temporary variable.
> >
> > Fixes: 4dc4e33ffa10 ("net/virtio: fix Rx checksum calculation")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
>=20
>=20
> How about something like the following *untested*

I agree. Can you fix it?

Thanks,
Yunjian

>=20
> diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
> index 69901ab3b5..c65cb639b2 100644
> --- a/lib/vhost/virtio_net.c
> +++ b/lib/vhost/virtio_net.c
> @@ -2861,25 +2861,28 @@ vhost_dequeue_offload(struct virtio_net *dev,
> struct virtio_net_hdr *hdr,
>  	}
>  }
>=20
> -static __rte_noinline void
> +static inline int
>  copy_vnet_hdr_from_desc(struct virtio_net_hdr *hdr,
> -		struct buf_vector *buf_vec)
> +			const struct buf_vector *buf_vec,
> +			uint16_t nr_vec)
>  {
> -	uint64_t len;
> -	uint64_t remain =3D sizeof(struct virtio_net_hdr);
> -	uint64_t src;
> -	uint64_t dst =3D (uint64_t)(uintptr_t)hdr;
> +	size_t remain =3D sizeof(struct virtio_net_hdr);
> +	uint8_t *dst =3D (uint8_t *)hdr;
>=20
> -	while (remain) {
> -		len =3D RTE_MIN(remain, buf_vec->buf_len);
> -		src =3D buf_vec->buf_addr;
> -		rte_memcpy((void *)(uintptr_t)dst,
> -				(void *)(uintptr_t)src, len);
> +	while (remain > 0) {
> +		size_t len =3D RTE_MIN(remain, buf_vec->buf_len);
> +		const void *src =3D (const void *)(uintptr_t)buf_vec->buf_addr;
>=20
> +		if (unlikely(nr_vec =3D=3D 0))
> +			return -1;
> +
> +		memcpy(dst, src, len);
>  		remain -=3D len;
>  		dst +=3D len;
>  		buf_vec++;
> +		--nr_vec;
>  	}
> +	return 0;
>  }
>=20
>  static __rte_always_inline int
> @@ -2908,16 +2911,12 @@ desc_to_mbuf(struct virtio_net *dev, struct
> vhost_virtqueue *vq,
>  	 */
>=20
>  	if (virtio_net_with_host_offload(dev)) {
> -		if (unlikely(buf_vec[0].buf_len < sizeof(struct virtio_net_hdr))) {
> -			/*
> -			 * No luck, the virtio-net header doesn't fit
> -			 * in a contiguous virtual area.
> -			 */
> -			copy_vnet_hdr_from_desc(&tmp_hdr, buf_vec);
> -			hdr =3D &tmp_hdr;
> -		} else {
> -			hdr =3D (struct virtio_net_hdr *)((uintptr_t)buf_vec[0].buf_addr);
> -		}
> +		if (unlikely(copy_vnet_hdr_from_desc(&tmp_hdr, buf_vec, nr_vec) !=3D
> 0))
> +		    return -1;
> +
> +		/* ensure that compiler does not delay copy */
> +		rte_compiler_barrier();
> +		hdr =3D &tmp_hdr;
>  	}
>=20
>  	for (vec_idx =3D 0; vec_idx < nr_vec; vec_idx++) {
> @@ -3363,7 +3362,6 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
>  {
>  	uint16_t avail_idx =3D vq->last_avail_idx;
>  	uint32_t buf_offset =3D sizeof(struct virtio_net_hdr_mrg_rxbuf);
> -	struct virtio_net_hdr *hdr;
>  	uintptr_t desc_addrs[PACKED_BATCH_SIZE];
>  	uint16_t ids[PACKED_BATCH_SIZE];
>  	uint16_t i;
> @@ -3382,8 +3380,12 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
>=20
>  	if (virtio_net_with_host_offload(dev)) {
>  		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
> -			hdr =3D (struct virtio_net_hdr *)(desc_addrs[i]);
> -			vhost_dequeue_offload(dev, hdr, pkts[i], legacy_ol_flags);
> +			struct virtio_net_hdr hdr;
> +
> +			memcpy(&hdr, (void *)desc_addrs[i], sizeof(struct
> virtio_net_hdr));
> +			rte_compiler_barrier();
> +
> +			vhost_dequeue_offload(dev, &hdr, pkts[i], legacy_ol_flags);
>  		}
>  	}
>=20

