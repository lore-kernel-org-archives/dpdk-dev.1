Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CDC5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 14:51:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 220E04067B;
	Mon, 24 Aug 2026 16:51:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3474640270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 16:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787583086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9q/+HwwYk2cwOgN9WZh6iUhYTC6C8Ib0cKk3079Wb14=;
 b=dZkTz3J8HN5on8Y55MQ54JT+ugiJ6xG/RGMfaGnfz1h23KQtuI5xfAqBnIN7+ynzqvK9vW
 oBflYki0guYBsPr44OFYK5g3PPfOTFepHayhIgDqZcewEzFwglivIEsOFKhkFKYX1NV37k
 z0g7EXgCHkx0uA+iIWc2gVXq/hwNX5I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-uNRJI5LNNtCzaIxRzUh-lA-1; Mon, 24 Aug 2026 10:51:25 -0400
X-MC-Unique: uNRJI5LNNtCzaIxRzUh-lA-1
X-Mimecast-MFC-AGG-ID: uNRJI5LNNtCzaIxRzUh-lA_1787583084
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39c79b2836dso15370621fa.3
 for <dev@dpdk.org>; Mon, 24 Aug 2026 07:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787583084; x=1788187884;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9q/+HwwYk2cwOgN9WZh6iUhYTC6C8Ib0cKk3079Wb14=;
 b=TZA0XSxAASwZK6IUyqsH9BasYNb1pC/HathNMSAbZXp92mpnymgQnEFbKxjRv6vccj
 Ili7Jp8ofzJgIThAZ+WSJe6rXnQa9PA7Ten7fIfsTSUHPEKUIbJ7hv4f2OyMjl90DHMA
 tGAlQCBR7CZjmrtelY3S9564Wpyw4nh+f/2KOQgSNJKAFnuCb5jTkoooinwnh58TGoYG
 nCABlFVgbOBYPo6nYZndRhJup++urboylxb2+1BdYaJxZ0VKXawA/yaUboUunP2lNCEG
 SG+f7hwgJBHGB/0uUvbXjzUvSgEgDAXgGAHxiW+BU/jKsJGMglQV8QRXy41mP1UOUxgz
 Rmuw==
X-Gm-Message-State: AFuF++muC70aOkEjH6TD9TZdicR4gXDaTiUsmuR7EI0lskOGkjAj/4KC
 wCafnm5Tw4qQ1aCe5fMvTOgOjTbNP/ulk0VMZFXfsQM4rXYKo8+7sSiUyGz3XHVw7AP0ok3A3R1
 XLdodhh42ZrRhX3fZWkXALnZrDbrb7Fcjkj0xzTnSiuy5PX7jndKrs9/UNBt455Dw68pvZB8DPG
 24gHac5Ps9M5B9Z2jTcjc=
X-Gm-Gg: AR+sD10G9vlHCgA52qC6p1IYarxSoyegp613zfIXhMCr95B9i+HJJDY02fwxPNZjRp3
 7Ux1uwNlYY1SMOJzP+1K09HQqrulv8OpLee7QWTAMIjCM67XttMZZhsO1TjzntN1oavKc1SAKb2
 3JVxBScSWE4u/tTFAg84KQQiW8CTAThnVfegVdrYE/BZx8BtF12pakX4mEwyEI+Na136Omjz21L
 5JpwM11Tvv4nnCL3cN0hTg8pPlBoMrwLaaWRY5xFp/18umB
X-Received: by 2002:a05:651c:550:b0:39f:27a4:8036 with SMTP id
 38308e7fff4ca-3a1c1e8e79bmr40474641fa.9.1787583083708; 
 Mon, 24 Aug 2026 07:51:23 -0700 (PDT)
X-Received: by 2002:a05:651c:550:b0:39f:27a4:8036 with SMTP id
 38308e7fff4ca-3a1c1e8e79bmr40474491fa.9.1787583083178; Mon, 24 Aug 2026
 07:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787566677.git.anurag.mandal@intel.com>
 <1544dfcdca6e4accac523326948cbe2b4571e76b.1787566677.git.anurag.mandal@intel.com>
In-Reply-To: <1544dfcdca6e4accac523326948cbe2b4571e76b.1787566677.git.anurag.mandal@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Aug 2026 16:51:11 +0200
X-Gm-Features: AcwNN1WDnT8qo_Qk9y0X_7g-R2QZS-7DcHewqMgSnNsiYYyMgQ5E1aYXxFE_6Yo
Message-ID: <CAJFAV8z+ce0FBGQ5LvecKY__W_B8PWBoh2MJWcYZHVtcyDRSmQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/ice: add vector tunnel context encoding
To: Anurag Mandal <anurag.mandal@intel.com>, bruce.richardson@intel.com
Cc: dev@dpdk.org, anatoly.burakov@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jxMtgWYLza_dp3asvsv97bqQR2sU5tQlRbBYHfbAebE_1787583084
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

On Mon, 24 Aug 2026 at 12:23, Anurag Mandal <anurag.mandal@intel.com> wrote:
>
> Added helpers to encode tunnel context descriptors,
> and checksum offsets.
>
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx_vec_common.h | 53 ++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> index 1d83a087cc..b84456357f 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> @@ -123,8 +123,12 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
>
>         /* Tx Checksum Offload */
>         /* SET MACLEN */
> -       td_offset |= (tx_pkt->l2_len >> 1) <<
> -               CI_TX_DESC_LEN_MACLEN_S;
> +       if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> +               td_offset |= (tx_pkt->outer_l2_len >> 1) <<
> +                       CI_TX_DESC_LEN_MACLEN_S;
> +       else
> +               td_offset |= (tx_pkt->l2_len >> 1) <<
> +                       CI_TX_DESC_LEN_MACLEN_S;
>
>         /* Enable L3 checksum offload */
>         if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
> @@ -172,4 +176,49 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
>
>         *txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
>  }
> +
> +static inline uint64_t
> +ice_txd_tunneling_ctx(const struct rte_mbuf *tx_pkt)
> +{
> +       const uint64_t ol_flags = tx_pkt->ol_flags;
> +       uint64_t ctx = 0;
> +
> +       if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
> +               return 0;
> +
> +       if (ol_flags & RTE_MBUF_F_TX_OUTER_IP_CKSUM)
> +               ctx |= ICE_TX_CTX_EIPT_IPV4;
> +       else if (ol_flags & RTE_MBUF_F_TX_OUTER_IPV4)
> +               ctx |= ICE_TX_CTX_EIPT_IPV4_NO_CSUM;
> +       else if (ol_flags & RTE_MBUF_F_TX_OUTER_IPV6)
> +               ctx |= ICE_TX_CTX_EIPT_IPV6;
> +
> +       ctx |= (uint64_t)(tx_pkt->outer_l3_len >> 2) << ICE_TXD_CTX_QW0_EIPLEN_S;
> +
> +       switch (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
> +       case RTE_MBUF_F_TX_TUNNEL_IPIP:
> +               break;
> +       case RTE_MBUF_F_TX_TUNNEL_VXLAN:
> +       case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
> +       case RTE_MBUF_F_TX_TUNNEL_GTP:
> +       case RTE_MBUF_F_TX_TUNNEL_GENEVE:
> +               ctx |= ICE_TXD_CTX_UDP_TUNNELING;
> +               break;
> +       case RTE_MBUF_F_TX_TUNNEL_GRE:
> +               ctx |= ICE_TXD_CTX_GRE_TUNNELING;
> +               break;
> +       default:
> +               PMD_TX_LOG(ERR, "Tunnel type not supported");
> +               return ctx;
> +       }
> +
> +       ctx |= (uint64_t)(tx_pkt->l2_len >> 1) << ICE_TXD_CTX_QW0_NATLEN_S;
> +
> +       if ((ctx & ICE_TXD_CTX_QW0_EIPT_M) &&
> +                       (ctx & ICE_TXD_CTX_UDP_TUNNELING) &&
> +                       (ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
> +               ctx |= ICE_TXD_CTX_QW0_L4T_CS_M;
> +
> +       return ctx;
> +}
>  #endif

Why copy/paste this code in a new helper?
The scalar path seems to have the same code, simply moving existing
code should be enough, or do I miss something?


Besides, all of this looks really close to the iavf code.
Can this be factorised in drivers/net/intel/common in some way?


-- 
David Marchand

