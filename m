Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F5CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 13:40:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2138402B0;
	Thu, 21 May 2026 15:40:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 92EEE4025E
 for <dev@dpdk.org>; Thu, 21 May 2026 15:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779370831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJ19kRFtWjG1z25IF+mzGpxa2y4LfIiLPqp9NwyBhc0=;
 b=Q6Qv6twrL2lNoNzpViB3c28tJV7wv/O9KBs4GtHtJFhHyupO2JmSqaBh/ITu4rr6JwYqR5
 vKpWCNMiRQZJcqugDsYC2HnPOPab2/kyGQry5E0xLBvWIDHwrSXuG6jeHPKGPFytNqA8WU
 zYrv421JTSPHii9EtVAvgb0gwA4+D04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-vnEI9VSOPjWj3ahgXghoXQ-1; Thu, 21 May 2026 09:40:28 -0400
X-MC-Unique: vnEI9VSOPjWj3ahgXghoXQ-1
X-Mimecast-MFC-AGG-ID: vnEI9VSOPjWj3ahgXghoXQ_1779370827
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4518f777225so4690350f8f.1
 for <dev@dpdk.org>; Thu, 21 May 2026 06:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370827; x=1779975627;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFf0AltgiOzDfmnSSeZtkagWDdEmsFHtcSFuNdlAtUw=;
 b=P/iPF8R6+vbMGQrcBxnxayCAv1MJD9lEs1K2AQaSnqNNMHBA2maWdr6DQ9jinIg2oP
 UQOlEnZ3Ldanov7x2nFrSxwdAHJIMiPztX8bIKWG3hugRpu6JfO/TIX+6XYVDoUlLMLg
 ++AS+fnEi1EiM8aBWHkouhxmr9hw0XxBg7uAgrTaCjs+7MwhWUKl26EDAGck6HEUanFo
 oBXHX5OUYACaaKWhAE/s2gvaRFKBGLF78YWkJU6csvu8TK00Awqgt9cS14QNy0BD0zX4
 +ZZl6uXg8NDHAfeOFgE4mSI34WcZwK09OMoETG9D/BMDX6TrBhMrLHsTbLopP8KpHHM8
 dZfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hUqEg+kVjqIX/pxRo1ZFaWXxMXqEcs1uOvu//cG4YYNHmIEQj9GoSKToeFCSLn7AbKeA=@dpdk.org
X-Gm-Message-State: AOJu0Yw6hewAvqNRwSS73f4b2x8z1a5O6RPP8LinLiQ01O4ANaAW5oFF
 fl4LswhPsPKmvK/w8zRF/opZrj92L6rYEKeCNOWl/upHka56OxcoKFf97AyS5RkKBjhLmAnkLkS
 VLKJ8Vz+Zr2VuF3/lq8lo3w65e/6rparbUKUBzoQC/Klb
X-Gm-Gg: Acq92OGxogfdcmszm43ZU6gngqFIkwLQtGPbUwbxteNsIxdyju44xU+BhysQlwU9yk3
 grosC5YMbnQNaepVC0aHADopYNQa+ZbAk64JOQqZAxBn+sg+fovRqiJPMQ8+86/thherHzxh675
 4ZRcaldSb55gmV6ognj8Hn1q1LtvuWXUq1/dQpxJiLjSKCX3KdYvyX8TUJWXW9J/Hc6PqiEtGJu
 V1dztrnj/5iNsvFG2ZSD5nRxiy9V+aXFhTKd7Dq1T9zz1GYbImYbqcy5nEj1OQ9axzgv2LkJT7O
 TTM8ehkQHhgxzyn2i8ED61aF3gspfODEanm/EP1qeOlWpcd7fT59wXaxMrVmEA+bNO3oVbs7xN1
 09EGDVwAxAXIFsgofIJg8pDzodykLK2O0WYV/10v0kPcdY40eGBi7jAKj3xO8wAxVGSau/9T+UB
 5cFek=
X-Received: by 2002:a05:600c:c8d:b0:48f:fe2a:107c with SMTP id
 5b1f17b1804b1-4903603350fmr41878245e9.6.1779370827358; 
 Thu, 21 May 2026 06:40:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c8d:b0:48f:fe2a:107c with SMTP id
 5b1f17b1804b1-4903603350fmr41877735e9.6.1779370826766; 
 Thu, 21 May 2026 06:40:26 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c21587sm16240145e9.6.2026.05.21.06.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:40:26 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 21 May 2026 15:40:25 +0200
Message-Id: <DIOEBCK3G0K7.16VTGFEM1I4MC@redhat.com>
Subject: Re: [PATCH dpdk v5 2/5] net: support multiple stacked VLAN tags
Cc: "David Marchand" <david.marchand@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Kevin Traynor" <ktraynor@redhat.com>, <dev@dpdk.org>
User-Agent: aerc/0.21.0-151-g204ee0bf378b
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-10-rjarry@redhat.com>
 <0fc8a941-58ed-4901-8310-44c3a8d4b049@redhat.com>
In-Reply-To: <0fc8a941-58ed-4901-8310-44c3a8d4b049@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TTBO6VHamUpDyMDQHPPu6zPCVoba2jjBICd3ncGXw7w_1779370827
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

Kevin Traynor, May 21, 2026 at 15:38:
>>  =09} else if ((proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
>>  =09=09(proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
>
> David's code snipped earlier in the thread suggested that this should be
> change from an 'else if' to an 'if'. It seems to make sense to have it
> as an 'if', not sure if it was deliberate to remove. Though it might not
> be really part of this patch.
>
> -       } else if ((proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) |=
|
> +       if ((proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
>                 (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
>                 unsigned int i;

Yes, I deliberately kept this as it was. I can add another patch to
change to a simple if. It makes sense to support MPLS in VLAN.


--=20
Robin

> Place stamp here.

