Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2A0CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 09:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 509A0402EB;
	Wed, 20 May 2026 11:56:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A01284029D
 for <dev@dpdk.org>; Wed, 20 May 2026 11:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779270991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cb2cGjCFY6hx6PueCmI4kulwHUsqM4us2Fhl/U9YGOM=;
 b=WLMX9coiNCDMC+MhcFK2uZGbOeWva1+grN9A6ljoBcmYm0eFoosHZzDlAuCH84TO40XjTh
 c5vYJI6pgwoti3QTBL/6udCH4O/awBBUzc3fEFEwOEqW+LaGtG+z5bqvB+ATY7jtWlsv7Q
 BdK7n9tUIIUagDTlqo8j4WIVgMUl7/I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-GmhprAhDN_CDolfw_U3NeA-1; Wed, 20 May 2026 05:56:28 -0400
X-MC-Unique: GmhprAhDN_CDolfw_U3NeA-1
X-Mimecast-MFC-AGG-ID: GmhprAhDN_CDolfw_U3NeA_1779270986
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-393a63d9681so20233321fa.2
 for <dev@dpdk.org>; Wed, 20 May 2026 02:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779270986; x=1779875786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cb2cGjCFY6hx6PueCmI4kulwHUsqM4us2Fhl/U9YGOM=;
 b=JRP+Tna//V4QUAZNYrz/oDerwsQshRIgcjxend2td40UK5n8NX0Sj6In8Kg+EBbnIu
 Sskhh4xSSMIjUfSxobYCO6dH1vPGXTNdRgidD22LOs9ItCLlCpBUHywON2ZsWH2usB2k
 P8LSgKetbWDGYUYDl/Y9GQFVMOgZovmFNFJkvzbyewhhwPGBOjgXXtx5K1n0xhQ+0u/L
 uMTcqYi1769c7LC9g5kh3Kl7335/CCwqfFjJIMosnz/L+Q0ZDZ2y4+L53Bo9PQzj9Aur
 BCcpm2LiSfjNY51fLY00a9lc0ORP3Ll9GqZhCgGFqaBbcDXP9qu6ajiNlM6rbnMStGu9
 N2tA==
X-Gm-Message-State: AOJu0YzZqsEw6MXJfre8aiZ844nEPlhSYMHpqImAmgKa2rja24tZDjs8
 T5HEbvwS/JAlTPbEkYoYs4HCj3oPWNKwZMcyj8/PEwL9N3p4WMLYVhQ7dFlhZidKFnX+7AmPjHR
 YkE2ve7uTv0rdQX8PjK8w6szzMoJYF8zYTOznxfeYqvnevR/2ygdF5ssqXmblgK3lkzTG9dT6yN
 mhrIJUTmdUb8/RYRCK9bU=
X-Gm-Gg: Acq92OEB2biGn0WsLETBRurWYzIp4K41hXj4+kxeCu6qmgPvNx1u7FUVJHARLVT7A2n
 gwcakMEomfinOdjHtnTmSj7bznwusjakimwdXP5PMKQ9qkan9nUFW8cWeWQphTESffeLLuVoexB
 xpOEDv/OZ7w16HwPGMoPRInnd0fWwCL8NbT3Iw51oRoAiZSs4ypOQuA/dvhgsYUNFJMyRl+tu0P
 dEw+w1JiLkDHyQuS6Sma7LGb8VaCoKDEn+vTr82C5pQESKyEWeJGMLyw6EfL9FVeHZhAwUPq3ll
 qjGG
X-Received: by 2002:a05:651c:b2b:b0:393:a31a:ab3c with SMTP id
 38308e7fff4ca-39561ed7299mr65759721fa.25.1779270986367; 
 Wed, 20 May 2026 02:56:26 -0700 (PDT)
X-Received: by 2002:a05:651c:b2b:b0:393:a31a:ab3c with SMTP id
 38308e7fff4ca-39561ed7299mr65759641fa.25.1779270985826; Wed, 20 May 2026
 02:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-10-rjarry@redhat.com>
In-Reply-To: <20260518132712.70913-10-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 20 May 2026 11:56:14 +0200
X-Gm-Features: AVHnY4JQN-U5gfN04s-uspCDb5eR-uGZHF92bav58EObKCQs3LKd-rADejITAlw
Message-ID: <CAJFAV8xdkhcmY53VRJf3qbsVsYB-hM3DaxMxr=GS5MNvb1MPGA@mail.gmail.com>
Subject: Re: [PATCH dpdk v5 2/5] net: support multiple stacked VLAN tags
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hOvRHffocJJp303ZFA8qNKPDjywdZqbJoKrQVYClP0Q_1779270986
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

On Mon, 18 May 2026 at 15:27, Robin Jarry <rjarry@redhat.com> wrote:
>
> The VLAN and QinQ code paths in rte_net_get_ptype handle at most two
> tags with duplicated logic. Replace them with a single loop that
> consumes all consecutive VLAN/QinQ headers regardless of depth.
>
> Bugzilla ID: 1941
> Suggested-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

For the record, I am still skeptical about the usecase behind this change.


> ---
>  lib/net/rte_net.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index c70b57fdc0f8..d3cded961fb5 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -349,29 +349,26 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>         if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
>                 goto l3; /* fast path if packet is IPv4 */
>
> -       if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
> +       if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) ||
> +               (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ))) {
>                 const struct rte_vlan_hdr *vh;
>                 struct rte_vlan_hdr vh_copy;
>
> -               pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
> -               vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> -               if (unlikely(vh == NULL))
> -                       return pkt_type;
> -               off += sizeof(*vh);
> -               hdr_lens->l2_len += sizeof(*vh);
> -               proto = vh->eth_proto;
> -       } else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
> -               const struct rte_vlan_hdr *vh;
> -               struct rte_vlan_hdr vh_copy;
> +               if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
> +                       pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
> +               else
> +                       pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
> +
> +               do {
> +                       vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> +                       if (unlikely(vh == NULL))
> +                               return pkt_type;

Kevin noted that it is weird to report back some packet type when the
packet is malformed.
Maybe return RTE_PTYPE_UNKNOWN here so that the application is forced
to validate the packet? (it should already be doing it, in any
case..).


> +                       off += sizeof(*vh);
> +                       hdr_lens->l2_len += sizeof(*vh);
> +                       proto = vh->eth_proto;
> +               } while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
> +                       proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ));
>
> -               pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
> -               vh = rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh),
> -                       &vh_copy);
> -               if (unlikely(vh == NULL))
> -                       return pkt_type;
> -               off += 2 * sizeof(*vh);
> -               hdr_lens->l2_len += 2 * sizeof(*vh);
> -               proto = vh->eth_proto;
>         } else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
>                 (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
>                 unsigned int i;


-- 
David Marchand

