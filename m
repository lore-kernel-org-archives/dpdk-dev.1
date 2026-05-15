Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE08CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 11:17:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C00D840269;
	Fri, 15 May 2026 13:17:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C9580400EF
 for <dev@dpdk.org>; Fri, 15 May 2026 13:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778843842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JWfruNhnOF82Ejqaaqfx7QdTbQPcpy//ESaeNEUD2Bo=;
 b=gOXMfMduvEuC5aRIG+L0+8i9C+ka+3dAxZaJQyilViZhYPTEv4PZkcXV9mMDFP87n8Jxin
 K33Gju6L1DbJRptkI4CNS5p+HPIS+w6DGf9FMAgaQ4knn11W9qujaIsdiVGI+bT+8GCAiD
 o/I7n6TyR4mH+mj/0XpYMoOSgUQWfsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-PpwNTiYXNyCxopc4jJactg-1; Fri, 15 May 2026 07:17:21 -0400
X-MC-Unique: PpwNTiYXNyCxopc4jJactg-1
X-Mimecast-MFC-AGG-ID: PpwNTiYXNyCxopc4jJactg_1778843840
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fdca5c638so11061405e9.1
 for <dev@dpdk.org>; Fri, 15 May 2026 04:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778843840; x=1779448640;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWfruNhnOF82Ejqaaqfx7QdTbQPcpy//ESaeNEUD2Bo=;
 b=R+zS8knKFMbCC9sXYKnDU573goBT7m3Fympo6mQNvgPqdr7DvQdYOXNO1HweCBmGvA
 4+ewY5lBjNpWZ6tN0TEiK0kWI9FTMLsJe53u+2BTU/E2GCJSzkZmcI3aFEAlcLr0f2ca
 HKP+uEw7ine3Ch+tgFj9hdUVF9onVFRc7qMSKor34uj7AvXPbss7s0Cqdjf4Lf1ulGK5
 e9rg6IMRXTSkgdjancIbU0lBZy66iLY2rWcRvTt2CQrIy4lnPg+6alg7b+uumu2BW6QZ
 bwKTX8jeFXklR+9E97uc8/dFgxw8hC7XN5oFIvn7K/u39p7Qf6btjigHmLDYUEJ2Ffhz
 vOow==
X-Gm-Message-State: AOJu0Yzw0CAls2OgxIySQEXRuymV+TbPRdHzYXiMeJA4nqgkvNFRun67
 5wYqXO5UhdWrjUFwn7oc7kYeU0Sp/d+R6hY25gvH18oGk9wKEGsjW9G1D+PnRW+EpcuS4xHV6nK
 L+wXbBUUknWcRv1tvuzVO6MVAagZVnEZrEr6ovKZvIOEDhewq27quzxs=
X-Gm-Gg: Acq92OF9TgYs/BthLjRKRR4Ej2EhVkng48PnJAGegg2GGeeFHEg7NQLchEQxMsLTLHt
 yz2u2zQLTTQzhp8xHopLYsr0B5I2U/VnoAVAPkIpMSoC66y4T66+X1C0hBOjBhzjZ6U/POVc1zv
 8h5LDvTUYpRzpPOJDknPvyzfxvCwwKsLHrCDi4bi63tI7tteh0dtcMey4jGgk2EN/n3tGJwytvI
 kD92K3KVvQmnc+Jd4yOyhmlzMqWG3fo4KbMBNskGVwIOcy3mSbfVm29gIpyTbEg2rxcNaIhP/CB
 j14Ggf2b4G3v/jF1pE+5PyjP9pODIVyeRyo6d6nvIXoYfi1R3+rL7SUiNIg4eajHCvKzAFby0HY
 5kXKpzHq5X/cscyBlb+ZYKVzdFUU=
X-Received: by 2002:a05:600c:1f8f:b0:48f:d612:3c74 with SMTP id
 5b1f17b1804b1-48fe651b2b4mr43022275e9.27.1778843838186; 
 Fri, 15 May 2026 04:17:18 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8f:b0:48f:d612:3c74 with SMTP id
 5b1f17b1804b1-48fe651b2b4mr43020655e9.27.1778843836064; 
 Fri, 15 May 2026 04:17:16 -0700 (PDT)
Received: from [172.29.182.199] ([212.129.81.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694fcasm48888175e9.5.2026.05.15.04.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 04:17:14 -0700 (PDT)
Message-ID: <7a225069-5c51-4f0d-9abd-a887de124417@redhat.com>
Date: Fri, 15 May 2026 12:17:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v4] net: fix VLAN packet type
To: David Marchand <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>, Luca Boccassi <bluca@debian.org>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260423112458.865674-1-rjarry@redhat.com>
 <CAJFAV8yAhr-iXkn6JvderT_Yy4rB91LVWqYvwRqJH0DdmNkJ1g@mail.gmail.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <CAJFAV8yAhr-iXkn6JvderT_Yy4rB91LVWqYvwRqJH0DdmNkJ1g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -u68Jg8qL29z9aURUs7ASvgTO9DQW-QW_Pc_BND0Ozk_1778843840
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 4/25/26 10:40 AM, David Marchand wrote:
> On Thu, 23 Apr 2026 at 13:25, Robin Jarry <rjarry@redhat.com> wrote:
>> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
>> index 458b4814a9c9..a871318b21c2 100644
>> --- a/lib/net/rte_net.c
>> +++ b/lib/net/rte_net.c
>> @@ -357,12 +357,14 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>>                 const struct rte_vlan_hdr *vh;
>>                 struct rte_vlan_hdr vh_copy;
>>
>> +               if (vlan_depth == 0) {
>> +                       pkt_type =
>> +                               proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
>> +                                        RTE_PTYPE_L2_ETHER_VLAN :
>> +                                        RTE_PTYPE_L2_ETHER_QINQ;
>> +               }
> 
> This code is becoming too complex.
> The original usecase with more than 2 stacked vlan is a bit strange,
> but the max depth limit seems just arbitrary (why 8?).
> We have clear boundaries, with the size of the packet (see below,
> check on vh == NULL).
> 
> The offending commit also allows stacking mpls on top of vlan, without
> mentioning it.
> I think we want this behavior, but still was it intended?
> 
> In the end, reverting the previous fix then just advancing off and
> breaking once proto is not a vlan/qinq type gives a much simpler fix
> when compared to v25.11.
> 
> (ignoring indent changes with -w)
> 
> $ git diff -w v25.11 lib/net/rte_net.c
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index c70b57fdc0..f58d699c83 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -349,30 +349,28 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>         if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
>                 goto l3; /* fast path if packet is IPv4 */
> 
> -       if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
> +       if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
> +                       proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
>                 const struct rte_vlan_hdr *vh;
>                 struct rte_vlan_hdr vh_copy;
> 
> +               if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
>                         pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
> +               else
> +                       pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
> +
> +               do {
>                         vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
>                         if (unlikely(vh == NULL))
>                                 return pkt_type;
>                         off += sizeof(*vh);
>                         hdr_lens->l2_len += sizeof(*vh);
>                         proto = vh->eth_proto;
> -       } else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
> -               const struct rte_vlan_hdr *vh;
> -               struct rte_vlan_hdr vh_copy;
> +               } while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
> +                               proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ));
> +       }
> 
> -               pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
> -               vh = rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh),
> -                       &vh_copy);
> -               if (unlikely(vh == NULL))
> -                       return pkt_type;
> -               off += 2 * sizeof(*vh);
> -               hdr_lens->l2_len += 2 * sizeof(*vh);
> -               proto = vh->eth_proto;
> -       } else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
> +       if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
>                 (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
>                 unsigned int i;
>                 const struct rte_mpls_hdr *mh;
> 
> 
> This is untested, but what do you think?
> 
> 

This version LGTM. Maybe we should consider returning NULL on invalid
packets

