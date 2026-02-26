Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73634FD8FF5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:22:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62E1C4027F;
	Thu, 26 Feb 2026 20:22:00 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 76214400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:21:59 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-506c00df428so12422321cf.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772133718;
 x=1772738518; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhhtEIAQESau0E84rQYUdDCkd79dAuvTu8Niz7obhGA=;
 b=hqbU21f+CKVwishJTwnOHPDH2pwhI8e7ElGAIKWKj9hESgqvLypgDKEikNQNb3MwjQ
 9CGU8+DGYmIduKIvQ6EnCWmpKRP7vGNhh3c/LhFTilZX9bIxcBZ3LoT0BOwQkPlN9pLj
 2GQFJL5RYOSdo/d3pW5/EMHcf+UGyyVJcS2g6nLX/ghq6HwqLqTNtZzhrrft76r3/mE+
 HZl9aoVNk0KA4n+2U6fh0LKFZMnaaZlSJw4yJO+OjYJwXHMMAaHMlL8H9nb1s8al3Zj4
 ErT0kbfmePIcXrtjPzrhM7ZgFm878p0hnUTVR4vY1QolqjIyETiVWluaZLP+KPxq698x
 Zg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772133718; x=1772738518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AhhtEIAQESau0E84rQYUdDCkd79dAuvTu8Niz7obhGA=;
 b=VnFWmjYBzcffueJE2okU0O/uCtARSS37CsplQ8A935nrZ9LcPqoovtyeCNgDC7y7rg
 YQ8/t0QMNLyRbPvRt+X39V8Sf50fM8smoxc5GOmP1yUFq234SixaeIQ9J035U6YrLAJP
 YpLK1W0iDG8ocx4cb9PejoVPMhUWMwmojE+mCu6OwyXhMRlyzA37fiSA1SBtg6l82b56
 H806RKevdDDNIRhe/g/x94opVNsHU1/5IsvGvLB+sJNIkUJcC7n8qpEfDciWn/R07vsV
 GsSzetG91fC5Atke6y/vRkEYqcKTF4ffAhTw2SmaNAylXYesmZkeY+Ew5v5943PPE1wK
 LJLg==
X-Gm-Message-State: AOJu0YwRBP7/jwEkioRGJQ97z7YFX2FdCEWQbM40H89TazePFo1g4xhR
 lvv/tmkoohZGTg3YbJhKT7Ovfr6m5m+/2yPeQHc9zMIfvhQLCcLo3npi1WI88Qt1GE0=
X-Gm-Gg: ATEYQzzwRjMH8/wAVPb3CvCvPt6HgCjMnu5hvSebQw8fHgS0lXps4vdAiIL4DNLrg3e
 F+kCUbrLVw6CfxlOYDFx2F0kfYTFgFHfmanvzrC7CND0bJhNLicMrwjEsMFt8zhlLreJH5YM535
 1c/ijeeOBGDUyIXR88xrOgz9rE7jBGRzxCBxrDxknyi3FrXZ8ZZ8LVgAU3/xZmxceBt65mlfMGT
 07OcZ0c+dq/w8QUMaoBQZM2nEdotLgeQxK9lAUHhmmJVWrPWpErWzOjAQ0TUkZusuFI22H9dfhQ
 kEoBHL3AgydUkQ/Iakdz7O6LaOWAyTAYD6hEeTq6vuzW4IUyO5Jz3fw33I4tBDUs3LNdjHjh5Yj
 Piy+ZGVjTTLKLPrRcHh0r5kgoaEpM7Cu4zDuZPDcVxo745j/hr9OBJ1+MuaoPV5e4GkVjZ4WMJE
 4tpVhSyZHf28vJ8ggFxPKYPhHEa7TMeptYWFSGa0m+w9i/3slIKjSaqcruIix7gSjk
X-Received: by 2002:a05:622a:198f:b0:4ee:155d:b560 with SMTP id
 d75a77b69052e-507527caa3dmr1305881cf.8.1772133718514; 
 Thu, 26 Feb 2026 11:21:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c73a3392sm23876156d6.53.2026.02.26.11.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 11:21:58 -0800 (PST)
Date: Thu, 26 Feb 2026 11:21:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, david.marchand@redhat.com,
 stable@dpdk.org
Subject: Re: [PATCH v2 11/17] net/dpaa2: fix software taildrop buffer access
Message-ID: <20260226112154.7b2c51d0@phoenix.local>
In-Reply-To: <20260226143341.282188-12-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-12-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 26 Feb 2026 15:33:35 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> The sw_td path in dpaa2_dev_tx() reads from the wrong position in the
> bufs array. When the goto fires, bufs has already been advanced past
> the num_tx successfully sent packets. The first loop then reads num_tx
> more entries starting from bufs, going past the end of the input array.
> Additionally, the buf_to_free segments for already-enqueued packets
> are never freed, leaking memory.
> 
> Replace the buggy sw_td code with the same pattern used in
> dpaa2_dev_tx_ordered(): free buf_to_free segments first, then use
> rte_pktmbuf_free_bulk() to drop remaining unsent packets.
> 
> Not tested, found by code review.
> 
> Cc: stable@dpdk.org
> Fixes: c3ffe74d85be ("net/dpaa2: support software taildrop")
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  drivers/net/dpaa2/dpaa2_rxtx.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
> index 689e5e7ee7..8275ba9780 100644
> --- a/drivers/net/dpaa2/dpaa2_rxtx.c
> +++ b/drivers/net/dpaa2/dpaa2_rxtx.c
> @@ -1517,21 +1517,15 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  
>  	return num_tx;
>  sw_td:
> -	loop = 0;
> -	while (loop < num_tx) {
> -		if (unlikely(RTE_MBUF_HAS_EXTBUF(*bufs)))
> -			rte_pktmbuf_free(*bufs);
> -		bufs++;
> -		loop++;
> +	for (loop = 0; loop < free_count; loop++) {
> +		if (buf_to_free[loop].pkt_id < num_tx)
> +			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
>  	}
>  
>  	/* free the pending buffers */
> -	while (nb_pkts) {
> -		rte_pktmbuf_free(*bufs);
> -		bufs++;
> -		nb_pkts--;
> -		num_tx++;
> -	}
> +	rte_pktmbuf_free_bulk(bufs, nb_pkts);

It is unsafe to use free_bulk on transmit path because packets in
burst might come from different pools. An example would be a router
forwarding from two incoming NIC's to one outgoing NIC. 

Unlikely, but using bulk here is incorrect.

You are right though old code had other bugs.
