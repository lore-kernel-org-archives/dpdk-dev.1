Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF6EFDEE28
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 23:39:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62A51402A2;
	Fri, 24 Apr 2026 01:39:42 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id D0FF640279
 for <dev@dpdk.org>; Fri, 24 Apr 2026 01:39:40 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2dec803f9f0so4255033eec.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776987580;
 x=1777592380; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGg8zwWBir02IgDS0nrVrmi64rvb+lRwKHWTk8UzSdg=;
 b=D086v/QxteauAuLfWhg7LArBDOZqho8jJpQbaU08oUkPdqXwafKmXoJKa4W4b+bIz4
 T9cNJeYGrj/dlph6m5IsJdQJYj3IT7JR3m1GZsYnn0ddRTJwizktTXysR4d7vEuZU1IS
 ggDBaJB/v8LiDB38HBpGaIGZKXZiffnuTLOUEHBiNFxJbF+u25e7gHfH0Hy8ifu1Qbym
 kWY9iqo7LpUoeY1X3gcpNvRd4CiIiP8bumfPzdK22qmuAijd6bGvq84s5qPu9qul1hkU
 Pu+ssQSVN2DbA3QOPD0qU1dYfTuhuVo6stERWzN91O0tZzqP1GAYOBQO+6POJO+Rkl5w
 zN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776987580; x=1777592380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGg8zwWBir02IgDS0nrVrmi64rvb+lRwKHWTk8UzSdg=;
 b=NEVELhLjTUh6jf8clkw7EUyZkPENWbtdV8fx4YPtaxtpx1draP4QYt6Sz94+qw4rzK
 buFbGNmbxxGGO5LjV3xUSI38WonXCxk6LxkXwli9SjOz4ldan/8sg/pkF87Ha+GHzmU/
 GfdFjfmTzze7KzcqqcMSehv5fvA4HTavaB5Wr8Ow8q8k6OUuxR+IdZRz7JCsanZSkIjw
 c/ryIfZvcF3/cefwy+AH1Zxy1+wnWt5JqdL4WR0I+q2yd/E/soxfvVQtOOiQ8oFpPPBC
 MlhgsnLtZCWMSHggXKBkFC3YT+/c5w+2yPBOiZGciVyzkFi2xLFaIWmKiMuBSvJoOaCT
 BlDA==
X-Gm-Message-State: AOJu0YzMzrktHyLFymKO4cKFqLpEK1k1Euj61lPSjW4yf7IM8/mixHxw
 3Igh8boL5/GOH7QPf/ntgInuQLULMNDCpI9G2hPIySRe6MRnW9JY/X/o1IhRhZtFJjk=
X-Gm-Gg: AeBDieu61AxP53ecwEtr+BO/NF2R/iUtG50H8aG6yhUAlE2OJ1sO4NtYVV0IWxEolND
 tUZoo0K8lc5J3FTQP2PlN4u7ZhdYvlet57MXUK9M7zNu/pajxJC65oDJqkKX6mJRduktbA9UFdY
 69jNqWAUO84vrW5/eHZBZ59gzCpf/I4Fm/vwXN01KgiKXdTghqvV5/XYhTvzAOPv2dVg0vyC+Yp
 mSPkq79GlVZFXRSzLnPMTe79jiUIsrYeSuiC1GjjvD7zTGJXnGMAbA/3QAhl82gjDup5DY3aSJl
 vrTMnhcTi6/j3GyM8Ir7rD3vmAw0r7QOEDXOknEYZZlcaKMOoWEu4THAanxhCnyNr2P9bpmWPUR
 rX7mIuf//yJFLoM3w5204qiyyQbOdjaGFVhYNm4uOrfO05TLvnX9XAFc8Mgc0RmfetBzjlJV5v4
 8Hj56WgJoy9HdrERRD6EML4prOHBv/Kb0GInWzC6pedtLZ8A==
X-Received: by 2002:a05:7300:8622:b0:2c1:7480:ff9b with SMTP id
 5a478bee46e88-2e42e6e99b7mr12561879eec.18.1776987579339; 
 Thu, 23 Apr 2026 16:39:39 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa5c86sm35879637eec.1.2026.04.23.16.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 16:39:38 -0700 (PDT)
Date: Thu, 23 Apr 2026 16:39:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 2/3] net/zxdh: optimize Rx recv pkts performance
Message-ID: <20260423163936.30b243a9@phoenix.local>
In-Reply-To: <20260423011820.2426203-3-wang.junlong1@zte.com.cn>
References: <20260326022828.998541-1-wang.junlong1@zte.com.cn>
 <20260423011820.2426203-1-wang.junlong1@zte.com.cn>
 <20260423011820.2426203-3-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 23 Apr 2026 09:18:17 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> +
> +	PMD_DRV_LOG(DEBUG, "port %d min_rx_buf_size %d",
> +		eth_dev->data->port_id, eth_dev->data->min_rx_buf_size);

Don't use %d when printing unsigned values.

+	/* If device is started, refuse mtu that requires the support of
+	 * scattered packets when this feature has not been enabled before.
+	 */
+	if (dev->data->dev_started &&
+		((!dev->data->scattered_rx &&
+		 ((uint32_t)ZXDH_MTU_TO_PKTLEN(new_mtu) >
+		 (dev->data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM))) ||
+		 (dev->data->scattered_rx &&
+		 ((uint32_t)ZXDH_MTU_TO_PKTLEN(new_mtu) <=3D
+		 (dev->data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM))))) {
+		PMD_DRV_LOG(ERR, "Stop port first.");
+		return -EINVAL;
+	}

You can use lines up to 100 characters, and break up this into multiple
if statements to avoid such a complex expression. Looks like multiple
parts are the same?

> =20
> +#define ZXDH_VLAN_TAG_LEN   4
Why not use RTE_VLAN_HLEN?

> +#define ZXDH_ETH_OVERHEAD  (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + ZXDH=
_VLAN_TAG_LEN * 2)
> +#define ZXDH_MTU_TO_PKTLEN(mtu) ((mtu) + ZXDH_ETH_OVERHEAD)

> +static inline int zxdh_init_mbuf(struct rte_mbuf *rxm, uint16_t len,
> +		struct zxdh_hw *hw, struct zxdh_virtnet_rx *rxvq)
> +{
> +	uint16_t hdr_size =3D 0;
> +	struct zxdh_net_hdr_ul *header;
> +
> +	header =3D (struct zxdh_net_hdr_ul *)((char *)
> +					rxm->buf_addr + RTE_PKTMBUF_HEADROOM);

Please use rte_pktmbuf_mtod instead for this.

> +uint16_t zxdh_recv_single_pkts(void *rx_queue, struct rte_mbuf **rcv_pkt=
s, uint16_t nb_pkts)
> +{
> +	struct zxdh_virtnet_rx *rxvq =3D rx_queue;
> +	struct zxdh_virtqueue *vq =3D rxq_get_vq(rxvq);
> +	struct zxdh_hw *hw =3D vq->hw;
> +	struct rte_mbuf *rxm;
> +	uint32_t lens[ZXDH_MBUF_BURST_SZ];
> +	uint16_t len =3D 0;
> +	uint16_t nb_rx =3D 0;
> +	uint16_t num;
> +	uint16_t i =3D 0;

Useless initialization of i.

> =20
> -			dev->data->rx_mbuf_alloc_failed +=3D free_cnt;
> +	num =3D nb_pkts;
> +	if (unlikely(num > ZXDH_MBUF_BURST_SZ))
> +		num =3D ZXDH_MBUF_BURST_SZ;



> +	num =3D zxdh_dequeue_burst_rx_packed(vq, rcv_pkts, lens, num);
> +	if (num =3D=3D 0) {
> +		rxvq->stats.idle++;
> +		goto refill;

Since this is normal path on idle network, the counter will grow
rapidly. Do you need it?

> +	}
> +
> +	for (i =3D 0; i < num; i++) {
> +		rxm =3D rcv_pkts[i];
> +		len =3D lens[i];
> +		if (unlikely(zxdh_init_mbuf(rxm, len, hw, &vq->rxq) < 0)) {
> +			rte_pktmbuf_free(rxm);
> +			continue;
>  		}

Better practice to make rxm and len variables scoped to the loop.

AI review noticed that there is now a double free in the error path.
Both error paths inside zxdh_init_mbuf() already call rte_pktmbuf_free(rxm)=
 before returning -1. The caller's rte_pktmbuf_free(rxm) then frees it a se=
cond time. Remove the caller's free, or stop freeing inside zxdh_init_mbuf(=
).

(zxdh_set_rxtx_funcs) =E2=80=94 dropped mergeable-rxbuf feature check: The =
old code returned -1 with an error log when the peer did not negotiate ZXDH=
_NET_F_MRG_RXBUF. The new code silently drops that check. If the negotiated=
 feature set doesn't include MRG_RXBUF, the multi-segment rx path may now b=
e selected against a peer that doesn't support it.




