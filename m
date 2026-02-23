Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B1EA4FAE
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 11:35:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDF6B4025E;
	Mon, 23 Feb 2026 12:35:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CF6CD400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 12:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771846503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PzBkZjMaqxIHvP2OeyEbNkhchAoTWitjVla5TA6mWKQ=;
 b=PkXBCzynhX+mEp7hmT9ZK+uqge93yJAFvTsRXhVWm0QyrSUVQJwiSQOuRXVewEB3h0QlIz
 OaCONwNqXwNHKYi3ulZlr3sEOL+xUFULmR5q4hSCV+k02s5t7jyV7qXeF5w8tqmz/Xq1Lg
 MGDB8HXXZTfBBZZ6jdGlfighUpS6TZU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Y4PwzaBEN_-A2RN7Ki2yXg-1; Mon, 23 Feb 2026 06:35:02 -0500
X-MC-Unique: Y4PwzaBEN_-A2RN7Ki2yXg-1
X-Mimecast-MFC-AGG-ID: Y4PwzaBEN_-A2RN7Ki2yXg_1771846501
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38710504f15so25351501fa.0
 for <dev@dpdk.org>; Mon, 23 Feb 2026 03:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771846500; x=1772451300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzBkZjMaqxIHvP2OeyEbNkhchAoTWitjVla5TA6mWKQ=;
 b=d3cHG/bW751AQkW4DP9uSM0jr/eKpNcFrFhvz1ji/tjGiuqGvX9A8TfdZmveMIjKcC
 WknDIOBw8vBQ9+VjEjwauX9XbD449h6NmoMTM8msFImw2ixNCH0ACx0ukhgFRccOcwS0
 AKJHEfGF0BNsL82tfICKKq0zXAOAcn70b2A7gf6Y2UA7rHOTnc2w8VQpMxhwWi8lHSfE
 5jI8l2+5L5vUJwtekkUIzFav5opgLAaleefFLnJGWBnC0CuRj++1rFo/I+nq4wfpwRb7
 JjcQnKHdSuh8IRZD7W9oaEIpaKvUdkXFq7z2BjJuNhCZyHfDKq4LhCeLq93YLkhRO3cr
 g4Mg==
X-Gm-Message-State: AOJu0YwBvFzuyqpNMwz8xWSX6HQxCc94flaz1AiA5qjiInsbLyvdsVU6
 NLFGijD7XVVvWWu7V57DyxAGjhxQkbvxTel9pcfGKFbcszvyM18c7+D4IxLb+eseozYV7YP+HEh
 g48dt1yypHG70skH5lMOx4UXGoMH44SW2sEJ1yqlbXdHCqEa6CvTEPtgfiG/A3mUNls6ZyoWFcq
 vuOW9+s5tOHoxr6UX4rHQ=
X-Gm-Gg: AZuq6aLvLRfI8lfqtjkV6dyKFMQAqpGf4gWOra45nBznb1GQP/OaTMrEt5QFbrd1nq9
 WcJ/3JHw48mo+uHNEEPsaj0S/bMDh18Jgv82dsEv6Bp8Jiq1sSjXT5fxYYirhzbAUUeFMmeeSre
 ziokNh8Nu7FYjMj862q9Bq1DYKT20IMkd8RT4HlKKoSxtfev26JwsJcR0Y4F3sX8hDC5jKqYZop
 kUh3yslL3+gIm2MpSjY0S/fMXHWIF/3JJ0CCgwOpOhibah3Pmt4ykwezYX/xD2PZmhCNg==
X-Received: by 2002:a05:651c:21b:b0:386:8faf:eedc with SMTP id
 38308e7fff4ca-388537d7157mr32726801fa.15.1771846500529; 
 Mon, 23 Feb 2026 03:35:00 -0800 (PST)
X-Received: by 2002:a05:651c:21b:b0:386:8faf:eedc with SMTP id
 38308e7fff4ca-388537d7157mr32726751fa.15.1771846500052; Mon, 23 Feb 2026
 03:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
 <20260210000201.295839-9-stephen@networkplumber.org>
In-Reply-To: <20260210000201.295839-9-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Feb 2026 12:34:47 +0100
X-Gm-Features: AaiRm527dH4g2I7nQL4EBiRK324rTEmvZkksj4r9wQw_ZbvBTV8M3k-9giODglI
Message-ID: <CAJFAV8zyKYCsfhKEi2sPo=aMvLAH7_pWuSAm_163wxxef18hGA@mail.gmail.com>
Subject: Re: [PATCH v13 08/16] net/pcap: support VLAN insert and strip
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 99dkmxOmS5IdsJyXN-neZ5EJtAZZNYWIoDKwYOYmDWo_1771846501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 10 Feb 2026 at 01:03, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Driver can easily insert VLAN tag strip and insertion similar
> to how it is handled in virtio and af_packet.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

[snip]

> @@ -383,6 +393,56 @@ calculate_timestamp(struct timeval *ts) {
>         }
>  }
>
> +

Unneeded empty line.

> +/*
> + * If Vlan offload flag is present, insert the vlan.
> + * Returns the mbuf to send, or NULL on error.
> + */
> +static inline int
> +eth_pcap_tx_vlan(struct pcap_tx_queue *tx_queue, struct rte_mbuf **mbuf)
> +{
> +       struct rte_mbuf *mb = *mbuf;
> +
> +       if ((mb->ol_flags & RTE_MBUF_F_TX_VLAN) == 0)
> +               return 0;
> +
> +       if (unlikely(mb->data_len < RTE_ETHER_HDR_LEN)) {
> +               PMD_TX_LOG(ERR, "mbuf missing ether header");
> +               goto error;
> +       }
> +
> +       /* Need at another buffer to hold VLAN header? */
> +       if (!RTE_MBUF_DIRECT(mb) || rte_mbuf_refcnt_read(mb) > 1) {
> +               struct rte_mbuf *mh = rte_pktmbuf_alloc(mb->pool);
> +               if (unlikely(mh == NULL)) {
> +                       PMD_TX_LOG(ERR, "mbuf pool exhausted on transmit vlan");
> +                       goto error;
> +               }
> +
> +               /* Extract original ethernet header into new mbuf */
> +               memcpy(rte_pktmbuf_mtod(mh, void *), rte_pktmbuf_mtod(mb, void *), RTE_ETHER_HDR_LEN);
> +               mh->nb_segs = mb->nb_segs + 1;
> +               mh->data_len = RTE_ETHER_HDR_LEN;
> +               mh->pkt_len = mb->pkt_len;
> +               mh->ol_flags = mb->ol_flags;
> +
> +               mb->data_len -= RTE_ETHER_HDR_LEN;
> +               mh->next = mb;
> +
> +               *mbuf = mh;
> +       }

Could this segment allocation+chaining be moved in rte_vlan_insert?

This would help solve this issue in other sw drivers that currently
just drop (indirect) mbufs.
We might need an additional input param for driver that don't want
multiseg / existing users... ?


-- 
David Marchand

