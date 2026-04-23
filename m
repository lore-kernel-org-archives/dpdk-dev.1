Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E787FFDEE45
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:00:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB5A740272;
	Thu, 23 Apr 2026 21:00:28 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 693A840270
 for <dev@dpdk.org>; Thu, 23 Apr 2026 21:00:27 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so6864222eec.1
 for <dev@dpdk.org>; Thu, 23 Apr 2026 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776970826;
 x=1777575626; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGg8zwWBir02IgDS0nrVrmi64rvb+lRwKHWTk8UzSdg=;
 b=EZt52moLs0ow4Kk0x/wZ2GFv6ssZ7ebI5yWu+CB0eTq8IaoCVohgb9GtfhAvy/umFI
 00b0Ro5NmEluiu3LbOImc+cRbBybW7rXcc/QpINaW5Zrm2hBfn57TAPBl/eX/6+ALpC9
 EylKPQQg00UsUy53gORrmnryFajs/o+xQQtkCFmoaBRO4q7GhGjglXLfF2qXb20DmwDt
 own58rnfikLRLmpxJQJF1LoO8VYM3sCRet338q1WQ+tKc6ilfR4xLu1cwF8HHqLViByU
 4yMWF6UfihzcSmLe45J83Dsjd73B1a/8N8uvDn8i9BAAQzZH+2nkVgQxCU85nhTM8NNu
 078g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776970826; x=1777575626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGg8zwWBir02IgDS0nrVrmi64rvb+lRwKHWTk8UzSdg=;
 b=rePQ5Ka4AlMyqTSrPNY96hFjPcwXS712FjZWYjdcvjzrtpdJiVInZC7jkuHzQ0xEyw
 j8DBF/X2GRHQ8S6/+rL2jf8Xep7+KHRtq5+bZuq+T97mdiN7a06QEXGMDlDx05I//bwb
 TVaqr6XHVCvy2Nd1gQIfJ93OtYt1M4ax8FLdigd3rTDNLqyRBTCWsy0g/xWjNbVWYF50
 OEmGbovN2617FSRTS0wc+bY9D2D04vkbkVmhANVOMkGHaH9GQUika+CsFwRq6c+AxjDY
 2k9kWMvXD4ZsH16f8azO+I/d7nNfXGfXP8OKCGMr3cnVqw31wtt33706BZjMOtCZwpGA
 fe6Q==
X-Gm-Message-State: AOJu0Yw2ZKYpNsIZ4BsAxc2l2M9NxbWhxi2wyTfyMiNtl/F50gGW96YX
 UaSc9SnUpG+iQfDSdi58I2/oxoN+bUVgQKLMQ5GaxJF6hW7qLO/r7MUgkPCPPcBREIvczoEn2jG
 pRzML
X-Gm-Gg: AeBDieuYwnZ3bBf49Wk0wDuWVG88fiHo62fM/yDffbIQRDOCRHxxAQkad6pXsBkMK7t
 +rUXAUWgGqr71f4VjBCRO8iWfPFcWLTnCfIhL8xLrSPCXEP4t9frPmthK2uYKnwXsNdWbgKECeu
 iCvxFjtOf2jkXyzPeHrvjBci7e3kOLdyK3IafJurXzlFH7/Zuw/bCadD/wu6TI6MiKomw+RIYTp
 iw+tJ9HjHg8fkSJoRTPRXGpJn27xuPh4Ykf+gFoQwHGOGpB06UPq7BXn4WzasSbDZPx0sOy8aTo
 nyHj1F1aYhvdNRtCdeoDqG50ceYzIFsKmXp3KaZkWueILbwcwgZJReK50LmmIgBB8Jz7pmtCeB+
 sUpov0UbZxsXN/x7cMDEOBI1hhoT74wt/eNG+uDgga31eq4l9R2pnCoj+Sw7Z+8xuD/Z4Us4gtT
 DH4apxpVBr9oDFtlMxJMMBLPlqx7UEopqxkf48UxT0lZNoUA==
X-Received: by 2002:a05:693c:2c86:b0:2da:1874:f3bb with SMTP id
 5a478bee46e88-2e47a103c2fmr15018549eec.23.1776970825895; 
 Thu, 23 Apr 2026 12:00:25 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d9b056fsm37717604eec.29.2026.04.23.12.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:00:25 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:54:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 2/3] net/zxdh: optimize Rx recv pkts performance
Message-ID: <20260423115443.6d05ac0f@phoenix.local>
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




