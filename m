Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26A606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OPijEAEM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4897C427B3;
	Thu,  5 Nov 2026 17:55:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 80CC640E01
 for <dev@dpdk.org>; Thu,  5 Nov 2026 17:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793897753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gPMqMrJj9NXHZjYrUAu/iCtMO+Q5B0+K68t5EhjTBI=;
 b=OPijEAEMomg63GRLbs5Dwh/Iv9uaFMlvNxhm2ldk5wJK5M1ghAC7jPq7YV735PRWFQEycf
 xCkGktrHtqZCXoNvVkenU6sMxboT1i1oKGgsYf8DGh31NjExJIWaEj7v6tXVVPMQ5fcJm3
 1JCl1P4yi0zjtRoQeHUCbO9VEyPf4Ns=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-D_QXxKspPuagMzOkc8BJ8A-1; Thu, 05 Nov 2026 11:55:51 -0500
X-MC-Unique: D_QXxKspPuagMzOkc8BJ8A-1
X-Mimecast-MFC-AGG-ID: D_QXxKspPuagMzOkc8BJ8A_1793897750
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso23457205e9.3
 for <dev@dpdk.org>; Thu, 05 Nov 2026 08:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793897750; x=1794502550;
 h=in-reply-to:references:user-agent:subject:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+gPMqMrJj9NXHZjYrUAu/iCtMO+Q5B0+K68t5EhjTBI=;
 b=gAS9IbMT4g2B6ws5Eiq0djMzUyMFOudn2475izhkySHz8HV54+rL7XK0ZyvLcDTuLO
 i1Z2yoF6SghsFezwV6BRzpOG/NalRsw+e3WTQLHs69BexgcHbWh5uiVfk7xRozTiVjJW
 E1q40/JVscNNftdQlnWOmq2XJP6fJ3JnB4QBkLgjOOHfcPsv5r0WKLatDoIFFs8wHyej
 VQ2fmMwUtKhzjZVYxRfrefk3Ml9lMZOOmSUXNfjMlnF2GmN+n4bb/Q9TBJK/k0/3wpEr
 rN22rZ/2pDiDCcrafHnLSK9FyyxeP7fGO4bqTa6dCe0tNQJp2khXKhllFmoJH+jG9AB2
 9+aA==
X-Forwarded-Encrypted: i=1;
 AKwUvByJK3vV4mlLMywviet52pwfRf30HMkjtXX/lQq+Oh9WdS8B8ywpqA4qgZ+OAz+r0AmYBUU=@dpdk.org
X-Gm-Message-State: APuU4Z+FVvV0k9D30DSH4fHmhHH30uUpUh9hM+J+xHF6x8ipXO587iWk
 NYb3qeKkyuXOK1T374n/sjl809EY7/muVsaVI0TnZgHfe5M3xKGQLcguJanLA7rCCCzqSnEy2YP
 4EtiGQQcLPKY6jyfAoBFeQzrs9/7QrV3V41Axn4XVt4pz
X-Gm-Gg: AYBFou1OJfQF+2WjOtF6Nn/k7DFKGb7TfjgO/FC3WCAfEn6hCkks2pgXr7JmVxkxoL1
 0HoAFCC5YKFXFZOgcgDZESRqWoLgbR6HYfl7Ba2hYKEvWMTeXyyyz9QY2qOGJ/3nfFpNs6nvvru
 Puo53Z0b2FGSWyuI4lDQvvRPnEAo+J2HSw8qMzyKk5EEq+V5jrIAv/0Di/bUl1nFLr8m6gfgRq3
 aacuMQqjHGUYzTk4xbITR1kBq6IuEiC2BHoXUY/1+iS8eod6u+0GFluR0Vpj+gg5LksNuajPFcJ
 2zjOYAD4pvhb7vEXRBIhFccInrvTyBba8sgaqNHAn93UtUxQ+8jkOhffS33fNT2IX9MoC/qSc1l
 /wD9uCPUdtyuuIrDxShRpa4lVjDJkeQNuuqNRnPnetznqjo3o+hzSCpRht+28xMJK/qtlaedsQ8
 FLEkVYZV4/xh577tOniP8fnhHyLm2Eqw==
X-Received: by 2002:a05:600c:1d29:b0:4a5:5fb9:5d35 with SMTP id
 5b1f17b1804b1-4ac187a7678mr461670155e9.21.1793897750422; 
 Thu, 05 Nov 2026 08:55:50 -0800 (PST)
X-Received: by 2002:a05:600c:1d29:b0:4a5:5fb9:5d35 with SMTP id
 5b1f17b1804b1-4ac187a7678mr461669765e9.21.1793897749968; 
 Thu, 05 Nov 2026 08:55:49 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46538sm72808485e9.5.2026.11.05.08.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 08:55:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Thu, 05 Nov 2026 17:55:48 +0100
Message-Id: <DMNFOGW1LT7T.3MNPAEW881VDD@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH dpdk] fib,rib: implement full network order support for
 IPv4
User-Agent: aerc/0.22.0-38-gda2e3af216c4
References: <20260518083935.15173-3-rjarry@redhat.com>
 <1263b2cc-6fc6-4b85-b542-6764c2a66825@intel.com>
 <DM6DVTPQVKBJ.16GPH4JSTG0K2@redhat.com>
 <374fbd82-3167-4e77-8571-3b4b8679b210@intel.com>
In-Reply-To: <374fbd82-3167-4e77-8571-3b4b8679b210@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4EpW0-BOWYxS2hAjG4v_jVmYzWSeU2Dm2O6f3tshDKU_1793897750
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey Vladimir,

Medvedkin, Vladimir, Nov 03, 2026 at 18:24:
>> Yes, because the control plane will iterate over the RIB and will=20
>> expect addresses to be in a consistent endianness.
>>
>> Honestly, I would really prefer if that host-order thing was only an=20
>> internal implementation detail of the FIB algorithm and that *all*=20
>> user facing APIs only dealt with *network order* addresses.
>>
>> But that would be a hard-break of the ABI. Would that be so terrible?=20
>> Who reasonably needs IPv4 host-order addresses for real world=20
>> applications?
>>
> I think we can't just give up host order, we need to maintain some=20
> level of backward compatibility with the good old LPM library. People=20
> have been using it for a long time and have built their code around=20
> its API, which uses host order in both the=C2=A0control and data planes.

Too bad, it was worth a try ;)

I would be interested to know which real applications use the LPM/FIB=20
libraries. It would give us some confidence if we ever need to break the=20
APIs.

> FIB keeps the same semantics, which makes migrating from LPM=20
> straightforward. The problem with a hard break is not only the ABI,=20
> function prototypes remains the same (use uint32_t), so existing apps=20
> would still compile and links without warnings, they just will install=20
> byte-swapped routes.

Yeah, we had talked about this last year [1]. The solutions wouldn't be=20
pretty. We would need to change the APIs to use a struct instead of=20
integers. That wouldn't be that bad honestly.

[1] https://inbox.dpdk.org/dev/D5SUAHQG4BFP.IRLD8VYLD2U7@redhat.com/

Let's table this discussion for next time.

> The existing RTE_FIB_F_LOOKUP_NETWORK_ORDER flag has been there since=20
> 24.11 and is part of two LTS releases, so I would keep it as is, at=20
> least for a while.
>
> However you have a fair point about the RIB, it is exposed through=20
> rte_fib_get_rib(), it is not 100% internal, and user may expect to=20
> have the same byte order as was used for FIB add/del. I'm fine with=20
> propagating the flag to the internal RIB, although we can just mark=20
> host order in documentation.

> So I'd suggest:
> - keep host order (for both CP and DP ops) as default (to maintain=20
>   alignment with legacy LPM)
> - keep RTE_FIB_F_LOOKUP_NETWORK_ORDER unchanged (lookup only)
> - add a new flag that makes all IPv4 operations (CP and DP) use=20
>   network order (with this flag order propagated to the RIB if you=20
>   think it would be better)

OK.

--=20
Robin

# Portions not affecting outcome have been edited for broadcast.

