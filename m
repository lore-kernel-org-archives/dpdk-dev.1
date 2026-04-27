Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9130AFF885E
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 10:47:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC2CA40651;
	Mon, 27 Apr 2026 12:47:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3FB3F40651
 for <dev@dpdk.org>; Mon, 27 Apr 2026 12:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777286869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3AqZ8aZzxlXL7UZQqtAHBlRwJTnLGfv8ZglcyZRAjE=;
 b=Tluf+/WWlJs6yjSYNOdoWNyNP8AsPXCf1qTCwAkclm9uTfzjMtjyAGuB9dmESwJSoMsMdJ
 BCweRhv7Euo7n+vq7E3gmewPxuK3HZm6WJu2emeYWkMwqYylQ2HRX7f812Z5i2ol1LJpud
 NjKAZUcRzHRUaca4LGBPUnnV/vkPU1c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-qUX4g8hrPkaIcGHeAwu4XQ-1; Mon, 27 Apr 2026 06:47:47 -0400
X-MC-Unique: qUX4g8hrPkaIcGHeAwu4XQ-1
X-Mimecast-MFC-AGG-ID: qUX4g8hrPkaIcGHeAwu4XQ_1777286865
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488c0120047so59491345e9.0
 for <dev@dpdk.org>; Mon, 27 Apr 2026 03:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777286865; x=1777891665;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T3AqZ8aZzxlXL7UZQqtAHBlRwJTnLGfv8ZglcyZRAjE=;
 b=e453OtQ4y6u//I5px95lpdGQWzn1H0toAv7rR0viANEj5e9wHCp1vbKzRIhBflnKzJ
 j9I8Thxqh4nNsBHbpt96ZBtURDnkM0ix5ULsW7wNE6X8lv6yUnY5P7MIBECqqQVjtSup
 2UJHgkDuZA7pDRMYyJrpMxobJY7JIus7ygiU8xyzJ1AN6ZEoVQp2va2EEDFsg8hGllB1
 MLuT3hjUknVJkdmdVr+8wCM2FYCR1uXKhofbjKzU2b5ubImVdy5o3MK+JiHgtOjywpMN
 dvbLPnES2le2RyqWeqo+DBSYU1P7LkpDJfbpzvRpELIEhKLBG9/56cr6lzfRvDxjjnie
 hDXw==
X-Gm-Message-State: AOJu0Yyi6DocucWerCN6OYsA3yDDFn+NoHqoHEqgYE4JQuaMJIe12YJu
 S6yzZLZ6N9XzQ0sEHcP0jbZTaCC16ovXRXC/hRSdyr7dj32zBVXqu4esINwRxTAcEY8XGm8WhKV
 1AsoRFeQHdn2AeUp3RAoq7hQ8vpNTfsEE7KX7TeS+JuGN
X-Gm-Gg: AeBDietBqKrwq4RNJFXxvLLscg556KxTVczRO4N0Alizd1C9c2invlGCUTxIH43ypPb
 YntS3cIWeyswFUkeH/XqcpyKXT8dg8zk5OvHAJV3bzdR5lyw4o1UQxxnin3p7MamaaPAlc0aIUv
 TQJSAUX26t9KjEL2wpCgAimr8am3AumlIGjslTHmNnDDS0PX5kTr3UKrtg572mMYDVnTc3Udt9C
 FUQg0ZH9yHpPpBl4vapo4hjWDWJcv2z8RPugNm4oHId1i6sMz42vlVHFRJkoUJb3QtjFPRRZgQW
 EXvpqvIDAnpn0i+ozng5Pu4eASchqJBmM81pWKMp8o8DEcxLUExZxzq131BjgANOYnx0+3/mAi1
 wvqWQ1rOS61b+lDw314cqDkD3tW0jWxNXuV4ftRZRiYmhKLX1ihN6IBV/IrE8zn8EFh5YeC44BE
 93gzKfR7tNhdhzixA=
X-Received: by 2002:a05:600c:4fc6:b0:48a:53ea:1408 with SMTP id
 5b1f17b1804b1-48a53ea15a4mr390997755e9.8.1777286865374; 
 Mon, 27 Apr 2026 03:47:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:48a:53ea:1408 with SMTP id
 5b1f17b1804b1-48a53ea15a4mr390997305e9.8.1777286864907; 
 Mon, 27 Apr 2026 03:47:44 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a66533ff4sm107883345e9.6.2026.04.27.03.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 03:47:44 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 27 Apr 2026 12:47:42 +0200
Message-Id: <DI3VM171VBSL.3E3J3C1HJ1GZG@redhat.com>
Subject: Re: [PATCH dpdk v4] net: fix VLAN packet type
Cc: <dev@dpdk.org>, "Gregory Etelson" <getelson@nvidia.com>,
 <stable@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>, "Kevin Traynor"
 <ktraynor@redhat.com>, "Luca Boccassi" <bluca@debian.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>
User-Agent: aerc/0.21.0-142-gcff39137b013-dirty
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260423112458.865674-1-rjarry@redhat.com>
 <CAJFAV8yAhr-iXkn6JvderT_Yy4rB91LVWqYvwRqJH0DdmNkJ1g@mail.gmail.com>
In-Reply-To: <CAJFAV8yAhr-iXkn6JvderT_Yy4rB91LVWqYvwRqJH0DdmNkJ1g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uChTT8NzGpCQUCFH9ggevHPeuBxiY--bLRs1wA7hNPM_1777286865
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

David Marchand, Apr 25, 2026 at 10:40:
> On Thu, 23 Apr 2026 at 13:25, Robin Jarry <rjarry@redhat.com> wrote:
>> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
>> index 458b4814a9c9..a871318b21c2 100644
>> --- a/lib/net/rte_net.c
>> +++ b/lib/net/rte_net.c
>> @@ -357,12 +357,14 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *=
m,
>>                 const struct rte_vlan_hdr *vh;
>>                 struct rte_vlan_hdr vh_copy;
>>
>> +               if (vlan_depth =3D=3D 0) {
>> +                       pkt_type =3D
>> +                               proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_=
TYPE_VLAN) ?
>> +                                        RTE_PTYPE_L2_ETHER_VLAN :
>> +                                        RTE_PTYPE_L2_ETHER_QINQ;
>> +               }
>
> This code is becoming too complex.
> The original usecase with more than 2 stacked vlan is a bit strange,
> but the max depth limit seems just arbitrary (why 8?).
> We have clear boundaries, with the size of the packet (see below,
> check on vh =3D=3D NULL).
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
> @@ -349,30 +349,28 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m=
,
>         if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
>                 goto l3; /* fast path if packet is IPv4 */
>
> -       if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
> +       if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
> +                       proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ=
)) {
>                 const struct rte_vlan_hdr *vh;
>                 struct rte_vlan_hdr vh_copy;
>
> +               if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
>                         pkt_type =3D RTE_PTYPE_L2_ETHER_VLAN;
> +               else
> +                       pkt_type =3D RTE_PTYPE_L2_ETHER_QINQ;
> +
> +               do {
>                         vh =3D rte_pktmbuf_read(m, off, sizeof(*vh), &vh_=
copy);
>                         if (unlikely(vh =3D=3D NULL))
>                                 return pkt_type;
>                         off +=3D sizeof(*vh);
>                         hdr_lens->l2_len +=3D sizeof(*vh);
>                         proto =3D vh->eth_proto;
> -       } else if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
> -               const struct rte_vlan_hdr *vh;
> -               struct rte_vlan_hdr vh_copy;
> +               } while (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLA=
N) ||
> +                               proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_T=
YPE_QINQ));
> +       }
>
> -               pkt_type =3D RTE_PTYPE_L2_ETHER_QINQ;
> -               vh =3D rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh)=
,
> -                       &vh_copy);
> -               if (unlikely(vh =3D=3D NULL))
> -                       return pkt_type;
> -               off +=3D 2 * sizeof(*vh);
> -               hdr_lens->l2_len +=3D 2 * sizeof(*vh);
> -               proto =3D vh->eth_proto;
> -       } else if ((proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) |=
|
> +       if ((proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
>                 (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
>                 unsigned int i;
>                 const struct rte_mpls_hdr *mh;
>
>
> This is untested, but what do you think?

That looks correct. But you don't impose a limit in the number of VLANs?

I don't see any good reason to support more than 2 stacked tags.

