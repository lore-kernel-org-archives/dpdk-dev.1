Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA18F9936C
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 11:11:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F22964028F;
	Thu, 23 Apr 2026 13:11:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 294374026E
 for <dev@dpdk.org>; Thu, 23 Apr 2026 13:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776942675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pT5IOMFr0F4WQWXoIylqB7/5ZoAV9hv4gV9bavQXdys=;
 b=b/YLg6sm8SNRnyD+FVPdRa93ZLpAhkevo34sjHTRDS3WkLekKI1oRlAirAevSlQn/mSKFl
 J2HinhluXZhqSsNsj69qkdI+cErjOO0ImlNFkM41luXkkeHCX1jcfqCmM5WthkX863wEyD
 MT2r33RccddlLV1xx3d7djfLJT7tKsc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-VXWyY5UqOOSBt56UPJX0nQ-1; Thu, 23 Apr 2026 07:11:14 -0400
X-MC-Unique: VXWyY5UqOOSBt56UPJX0nQ-1
X-Mimecast-MFC-AGG-ID: VXWyY5UqOOSBt56UPJX0nQ_1776942673
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48a5775d647so25998165e9.2
 for <dev@dpdk.org>; Thu, 23 Apr 2026 04:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776942673; x=1777547473;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pT5IOMFr0F4WQWXoIylqB7/5ZoAV9hv4gV9bavQXdys=;
 b=ohVzQvD5zaN5Y41WHSFiBw9mCGvhJQYvE7HMf6NizMimbB+vlMwU59EUae/Un0dlJW
 fS7X6Kev7iwUUMbGpRy2FhlqADEGy4/lqTq0UFIFzp1sT0GOQkOxIBbISAylLDFel5wy
 FCDc1s7AfUxbC6XwuyL9y+MluBOZdknw3TJWIA1vHq274JTJsqU3nH9wnJeOZOf47Ox4
 zWokXoBe04huVRFqwTqj0pi7oc9LsC01EcELoOjsIFVZ6G5o05FyvnUT1UJFHbXwbzM8
 aE4CZF6S03EVGx0OugxEIXNm3OA7DiGmBxCXr/vfLNvUpxZB8ptC7jznwDa4wKKOPqK4
 HWxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9efvWCFZdnp63PmR/dUe4JADiLX1Ir/GPubKTXV4/O1zDhNRbBSW/Xilh0RqyU+367n44=@dpdk.org
X-Gm-Message-State: AOJu0Yyi5yl2/gosJ+hYEFbFRPQImfREaLZ9f85wq/8nZG86MFPyFh2v
 ImBJjYohePZ7bmJNJUMiIF4mWl3QG3bqptpRGsdS0joiesfsp9l8QkncXbmOoGKVgGUVACY2AaN
 QCx66MLPk+69ed6i4rmlYOasuRnuTgwH0C/Yx/L7sulcn
X-Gm-Gg: AeBDiesX+Cuh9kOt87SoecjJV2Dr6jFYHdb1Iwcn7BIpy6WsqvRghfaaG08XTcTFOpQ
 qO4UEZesmGcR8tXNqozUfELCisWwrvBbzPqpkJu/KVs5CRk1sWZDb2Z4J7qAD1Egz8A3UxrWsqw
 wafrpTv70jrQ1T4rOlGutucaDlbolCRPIjxIy69EriSc/arR7O6aS/V9cDyXA6rxbl7BWN0PSaf
 5glJiUOKdnHgRZD+9BpLf+AiVAznm/DtTzhVvqzpRH2Ev/GDLmThDwADnf2owtGo0j71mhymCoP
 LtqfbQGbLT53KYW4zMAkF3kedcZZtAUup5IgjuqD15ViWs2VEtjZ5EhXIRkhqK9moxZ5kJceuWe
 cjIaAj8rMP6IRteCyvE9BtbAuFPzFfVpZE/7zcqZqHha8StbCYLndSid3nb5j+/Ng9I+uiUoVHa
 p4T5ewGytpFkEpLJw=
X-Received: by 2002:a05:600c:c0c8:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-488fb73d9ffmr290782945e9.5.1776942672947; 
 Thu, 23 Apr 2026 04:11:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c8:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-488fb73d9ffmr290780905e9.5.1776942672208; 
 Thu, 23 Apr 2026 04:11:12 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cca5743sm303701115e9.9.2026.04.23.04.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:11:11 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 23 Apr 2026 13:11:11 +0200
Message-Id: <DI0HLTSLSW44.38PADIXZYUN7B@redhat.com>
Subject: Re: [PATCH dpdk v3] net: fix VLAN packet type
Cc: <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Kevin Traynor" <ktraynor@redhat.com>, <dev@dpdk.org>, "Gregory Etelson"
 <getelson@nvidia.com>
User-Agent: aerc/0.21.0-142-gcff39137b013-dirty
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260422133217.675900-3-rjarry@redhat.com>
 <66613eae-13f6-42f9-bada-d1f3b5d9cee0@redhat.com>
 <DI0FVI2TG9UU.JRHQ224VBSMW@redhat.com>
 <8561da5f-4ca7-4404-91d4-0c5ea296bb6e@redhat.com>
In-Reply-To: <8561da5f-4ca7-4404-91d4-0c5ea296bb6e@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ud0TIf8AswWDaY9YkGgegGPMottjoJUTiKwRoXxxVqY_1776942673
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

Kevin Traynor, Apr 23, 2026 at 12:59:
> Setting pkt_type later has some implications for early returns (now i
> notice that's present in v3 too)
>
> Would this work ?
>
> @@ -358,10 +358,12 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m=
,
>                 struct rte_vlan_hdr vh_copy;
>
> +               if (vlan_depth =3D=3D 0) {
> +                       pkt_type =3D
> +                               proto =3D=3D
> rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
> +                                        RTE_PTYPE_L2_ETHER_VLAN :
> +                                        RTE_PTYPE_L2_ETHER_QINQ;
> +               }
>                 if (++vlan_depth > RTE_NET_VLAN_MAX_DEPTH)
>                         return 0;
> -               pkt_type |=3D
> -                       proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN=
) ?
> -                                RTE_PTYPE_L2_ETHER_VLAN :
> -                                RTE_PTYPE_L2_ETHER_QINQ;
>                 vh =3D rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
>                 if (unlikely(vh =3D=3D NULL))

Yes, that works. I'll send a v4.

