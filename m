Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE8CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 08:15:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B361340431;
	Thu,  6 Nov 2025 09:15:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B07D84013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 09:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762416953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvFM7blE1N5EfPgNyAVT4dj+nGBvP9Lpx0NkXDwAeX8=;
 b=XaTrhycCMGNy920XImNFiFhV89nHuKaqIExKjKYlxjMaZ0LOZ27LekfkNhJJlxJ4uSJk2c
 IDE59WTb3Y0A/Z0R8VQL3du7mmnCoCdN2OIWHDFCoIJnijHCpfOOw14uNj+WWr4jwGgxyG
 qE31VouMPKDcHql/02XUPmgW+P7aXMk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-5iTfnIwoMBetTQTnm1VQdQ-1; Thu, 06 Nov 2025 03:15:51 -0500
X-MC-Unique: 5iTfnIwoMBetTQTnm1VQdQ-1
X-Mimecast-MFC-AGG-ID: 5iTfnIwoMBetTQTnm1VQdQ_1762416950
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-37773b477c6so5220901fa.2
 for <dev@dpdk.org>; Thu, 06 Nov 2025 00:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762416950; x=1763021750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TvFM7blE1N5EfPgNyAVT4dj+nGBvP9Lpx0NkXDwAeX8=;
 b=HyV1ZHnbVL1BWhYmQ23JHyRR0RxtdmNsHQawOMy1TOxdq6rQBM4Bes1K2skZaVL20h
 LKyjrDamqSI22RtKIUmiVDCkCMYQ6d63cBGZtwzDACbycNReDN2VvzGRrigqhOoBUjID
 Y/w5g8FMq4V3nF/Ja8KlBscYOPsMtwknJKooG7Pu+BtMtb/2dQWd3W3910oxcceqlRZZ
 O3i2uZ61d9/AWa0OrSC7lNiDRhavdh+MV1bNVDK+qB3Z0WAI2SkP1sFu5VKwgNGA+caX
 ib+ghbrFheWz/58L14QcEQNdY6f3Tw2981Moy9Whuvx8Q5G3bduIs2xzdm2DeQwu/kDX
 mcng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiT/h4WC1VkWEtUfCS3eyNHUlJx7zfiPnCslTADlEGwGIsnhqqhOFzElyLWiSPbGsB73o=@dpdk.org
X-Gm-Message-State: AOJu0Yw2JJSGjGtHWVadA6Q0jDsBzSGVIKqKVtCpKJ0rqM6UJyFQzfjc
 R8TLXYmPG1mIw0DgPzaXxwWBlp32urGOHm/sW1xX/qbPWuGYq/PI/G05AIF577ipaMPfNSmyPKV
 br0y57MyLBkDTKJX5oFI5OSFbxWHQgdMyII9q3hY9njvCrSMSqIalRMbMAptUEsNRgQAL+OIAWV
 6T4T0pbiqbrA2yHQSxoxg=
X-Gm-Gg: ASbGncsuwXh5f1vjePQtLupBrxikuW4eFrXixj70fYlGHHkU6FCm7WXwIvl9+v/SVRu
 TiIV2p43twgmUtTsVVZS+ofkrFXUhdFdnt47frMZFpHI01+QRHpjTyAawJbWScuiY4+RM+EJdDV
 SZP0Ql7vRaslhW3IGJxx2TUNsvT92/aolQ1DecM54MIt4Ymr+uQyqX1DGNFg==
X-Received: by 2002:a05:6512:340a:b0:594:49fa:793 with SMTP id
 2adb3069b0e04-59449fa0a9dmr689874e87.30.1762416950083; 
 Thu, 06 Nov 2025 00:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4I9ibJlcKkYECN3k+jF6lVd4oRgzF+FndQ5hHnPwW/BtSTMiB7mydjLt8J6evSNJk6nWNYVObrE2l+DU7nB4=
X-Received: by 2002:a05:6512:340a:b0:594:49fa:793 with SMTP id
 2adb3069b0e04-59449fa0a9dmr689864e87.30.1762416949660; Thu, 06 Nov 2025
 00:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20251002174137.3612042-1-wathsala.vithanage@arm.com>
 <20251002174137.3612042-2-wathsala.vithanage@arm.com>
 <cfc073b8137541f1be3e01650d6bcf14@huawei.com>
 <566b4c6c-f081-4db8-bc8b-2a576a82e1c3@arm.com>
In-Reply-To: <566b4c6c-f081-4db8-bc8b-2a576a82e1c3@arm.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Nov 2025 09:15:37 +0100
X-Gm-Features: AWmQ_blXcZ87VJW30gw4a8-yPQOkrgBbzYjh4_XSTZFkbCavVuh3CkY1yfRHqYk
Message-ID: <CAJFAV8yumnbPjakBAtkoqrZvWCo90F51Ri9Eje44sAmm_S43gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ring: safe partial ordering for head/tail update
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 Ola Liljedahl <ola.liljedahl@arm.com>, Dhruv Tripathi <dhruv.tripathi@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O1b27zsDIak2WErgNLcLc8HuMF4LQDavdZvS6h2pS-w_1762416950
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

Hello Wathsala,

On Mon, 13 Oct 2025 at 20:10, Wathsala Vithanage
<wathsala.vithanage@arm.com> wrote:
> > LGTM, though. I think that we also need to make similar changes in
> > rte_ring_hts_elem_pvt.h and rte_ring_rts_elem_pvt.h:
> > for CAS use 'acq_rel' order instead of simple 'acquire'.
> > Let me know would you have a bandwidth to do that.
>
> My bad, I forgot those two cases. I will send a v3.

Should we wait for this v3?
We want to close rc2 this week.


-- 
David Marchand

