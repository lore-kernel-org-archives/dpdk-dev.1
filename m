Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00733CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 11:09:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6BDF40609;
	Wed, 20 May 2026 13:09:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB0CA402DA
 for <dev@dpdk.org>; Wed, 20 May 2026 13:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779275391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xwrcd0wNkBZeIzL5NJ9EGu+3Fv7k4gYtoajg+4CFN9k=;
 b=QRfR4hkHBGvjNUKoIXcrx2ERcNCaL8DqIv2TfqqrnCQkuoAYhrYx/1QjkQRsF0yogApJpI
 SqmDEoXNAt0vFzsUe6a0aNpkwoWauJ4frc38baQZdZK3/vgDKsu/OxEJMCfzAzWVtG77eN
 ClBzZbRic1BMP2TjUNApp55whih5ZyI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-iyIMyEiIOmC5U5gYU5v9jQ-1; Wed, 20 May 2026 07:09:46 -0400
X-MC-Unique: iyIMyEiIOmC5U5gYU5v9jQ-1
X-Mimecast-MFC-AGG-ID: iyIMyEiIOmC5U5gYU5v9jQ_1779275385
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-449dcfe8005so3724872f8f.3
 for <dev@dpdk.org>; Wed, 20 May 2026 04:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779275385; x=1779880185;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xwrcd0wNkBZeIzL5NJ9EGu+3Fv7k4gYtoajg+4CFN9k=;
 b=qG5K36ZwcPN/oAVY6kvr186PnSbx4Rwao2uKqwjFG8XeHZ1k+sB9aSTyMY1KBhysEt
 vqRzqarF4T01LnLnp14QVZk+WXbp1ZAazK6koNiKb55y+kCJthES+ZbY+9QZgYwAjRKa
 06XSfv3B7XVr5urPT1YQWg92MoTyoEFigysRiT8NRDmbNK6i9ZvEIQikOmQMrx6OSgWY
 We/q2KuTO8KLp4QaU1zZZDVC5cANuhLeMf9D0Wpw+dNb+Gaj309gCBguha8e8RxjWRiM
 TW0SIcHmcN5vbbsr9YHzfbnUmSpE8G+4lIrpNrHmdBD9IHnJ0fExXQftBQTihrkJ660f
 HaIQ==
X-Gm-Message-State: AOJu0YxDnLzqceuKyZa43LDKKgIglpCb4kpnj1G7H1YVHOSmKsHGoAUo
 y6mVpyFlPRk963yNsD+9/s/QnGpqKdwIwPCLm6wOhEdDzOB/pOsqRo7yCXssLeFt5nVSAUtXH61
 TvANB5p8G7ShQ/vc1deJf2IALpt7WtM7d8qQa0Wx1F5GyDpl97FHA
X-Gm-Gg: Acq92OG1orkYnSLUpo7k+73Je/t+4ZEiX/2VkcC4/PeCEB2JgDnfjvduAJe59FsSG8U
 TKiNlGKYms2Awu518k11tVAQwAKqK8ielb7AW5rtn7AhQN6KbmVXGwhM0LaqjfrSjd6mNJFgeVA
 LsCKAmk2AFJN1VcXz3mqt/iWSP+1en2/wmBrBzejMkSNezGT4vupKt+j/mr0YoPgvb5lNsFb7Wm
 oxr0aHeesbKwDScEA3/WK2z/qZDR5klH8cEG98zelEqEDMyhnQjhPexqGwCXFtvmtG9EJS5Mf+y
 pz1MvCSw/Zv4K2YiOjybHl6rzKz4RFEb7v3Q5n4M3QWUcwiIoCxIxHRxUYRqDWXZ9dM5UAISZ8Q
 taDGPt4IL/5QefDoR4VV83slDRdyc8gn4zCWlXgpbHfw50wExfZDki13FmRxVc7Z3mFUR/zDIj5
 t5gQ==
X-Received: by 2002:a05:600c:181c:b0:48f:d5b2:7c1a with SMTP id
 5b1f17b1804b1-48fe60eca66mr234457895e9.13.1779275385267; 
 Wed, 20 May 2026 04:09:45 -0700 (PDT)
X-Received: by 2002:a05:600c:181c:b0:48f:d5b2:7c1a with SMTP id
 5b1f17b1804b1-48fe60eca66mr234457765e9.13.1779275384768; 
 Wed, 20 May 2026 04:09:44 -0700 (PDT)
Received: from localhost (92-184-116-170.mobile.fr.orangecustomers.net.
 [92.184.116.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8344asm660197315e9.1.2026.05.20.04.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 04:09:44 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 20 May 2026 13:09:43 +0200
Message-Id: <DINGHEW3M9WT.3F4XUUTLNKEL3@redhat.com>
Cc: <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>
Subject: Re: [PATCH dpdk v5 2/5] net: support multiple stacked VLAN tags
User-Agent: aerc/0.21.0-151-g204ee0bf378b
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-10-rjarry@redhat.com>
 <CAJFAV8xdkhcmY53VRJf3qbsVsYB-hM3DaxMxr=GS5MNvb1MPGA@mail.gmail.com>
In-Reply-To: <CAJFAV8xdkhcmY53VRJf3qbsVsYB-hM3DaxMxr=GS5MNvb1MPGA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aIhDVNbxwITWLeYprAUmAZuT3gvziq5hmFG-rt_QaTI_1779275385
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

David Marchand, May 20, 2026 at 11:56:
> On Mon, 18 May 2026 at 15:27, Robin Jarry <rjarry@redhat.com> wrote:
>>
>> The VLAN and QinQ code paths in rte_net_get_ptype handle at most two
>> tags with duplicated logic. Replace them with a single loop that
>> consumes all consecutive VLAN/QinQ headers regardless of depth.
>>
>> Bugzilla ID: 1941
>> Suggested-by: David Marchand <david.marchand@redhat.com>
>> Signed-off-by: Robin Jarry <rjarry@redhat.com>
>
> For the record, I am still skeptical about the usecase behind this change=
.
>
>
>> ---
>>  lib/net/rte_net.c | 35 ++++++++++++++++-------------------
>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
>> index c70b57fdc0f8..d3cded961fb5 100644
>> --- a/lib/net/rte_net.c
>> +++ b/lib/net/rte_net.c
>> @@ -349,29 +349,26 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *=
m,
>>         if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
>>                 goto l3; /* fast path if packet is IPv4 */
>>
>> -       if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
>> +       if ((proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) ||
>> +               (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ))) {
>>                 const struct rte_vlan_hdr *vh;
>>                 struct rte_vlan_hdr vh_copy;
>>
>> -               pkt_type =3D RTE_PTYPE_L2_ETHER_VLAN;
>> -               vh =3D rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
>> -               if (unlikely(vh =3D=3D NULL))
>> -                       return pkt_type;
>> -               off +=3D sizeof(*vh);
>> -               hdr_lens->l2_len +=3D sizeof(*vh);
>> -               proto =3D vh->eth_proto;
>> -       } else if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
>> -               const struct rte_vlan_hdr *vh;
>> -               struct rte_vlan_hdr vh_copy;
>> +               if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
>> +                       pkt_type =3D RTE_PTYPE_L2_ETHER_VLAN;
>> +               else
>> +                       pkt_type =3D RTE_PTYPE_L2_ETHER_QINQ;
>> +
>> +               do {
>> +                       vh =3D rte_pktmbuf_read(m, off, sizeof(*vh), &vh=
_copy);
>> +                       if (unlikely(vh =3D=3D NULL))
>> +                               return pkt_type;
>
> Kevin noted that it is weird to report back some packet type when the
> packet is malformed.
> Maybe return RTE_PTYPE_UNKNOWN here so that the application is forced
> to validate the packet? (it should already be doing it, in any
> case..).

If we do this, we need to fix it in the entire function. There are
several other places where the "current" value of pkt_type is returned
on error.

>
>
>> +                       off +=3D sizeof(*vh);
>> +                       hdr_lens->l2_len +=3D sizeof(*vh);
>> +                       proto =3D vh->eth_proto;
>> +               } while (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VL=
AN) ||
>> +                       proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_QIN=
Q));
>>
>> -               pkt_type =3D RTE_PTYPE_L2_ETHER_QINQ;
>> -               vh =3D rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh=
),
>> -                       &vh_copy);
>> -               if (unlikely(vh =3D=3D NULL))
>> -                       return pkt_type;
>> -               off +=3D 2 * sizeof(*vh);
>> -               hdr_lens->l2_len +=3D 2 * sizeof(*vh);
>> -               proto =3D vh->eth_proto;
>>         } else if ((proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) =
||
>>                 (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
>>                 unsigned int i;


--=20
Robin

> Avoid contact with skin.

