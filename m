Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F9ECCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC86E4028C;
	Tue,  4 Nov 2025 14:14:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0620640269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 14:14:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IanWiU8KGBtuuLlws5wsnoyMseuWw9QbgbTRxHzin5U=;
 b=HDLKT7MhPQiNULUM+AXL2d1/KxBovs30HF0xMjqt87l/9+/k28IyIIxyYhyv4cKxgBo/PA
 H7aFePHIHrrtZQpP9g4bHQ2FYegoUHe3PxAsj0zmYI4aHbP4LRvZ3UiEBmGff9zStSC6iv
 TE7LGRdOGsuvDw/zVGQDJRsi8PEjfoM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-liH3mKyINv--qamZzkSlng-1; Tue, 04 Nov 2025 08:14:31 -0500
X-MC-Unique: liH3mKyINv--qamZzkSlng-1
X-Mimecast-MFC-AGG-ID: liH3mKyINv--qamZzkSlng_1762262070
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-378d24de0b4so29475371fa.1
 for <dev@dpdk.org>; Tue, 04 Nov 2025 05:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762262070; x=1762866870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IanWiU8KGBtuuLlws5wsnoyMseuWw9QbgbTRxHzin5U=;
 b=cxDpSr5dPaPhfxB1y76syyWniPsyR3UrXrHLmrF4AAMZjk+/Jl6YQ1imW5my6/6Goi
 wZl+vHZcH2yTtNSQQdAavnVzx1UX7iQosA5etF4oOXDx/WKWM0UmF8Ck2/RxMceiq8i4
 dZl2jw6qPzjzw68g8InECLxe2+OLWYVgxRRCOrDKl1eqD6Grtny001OBjhrRM9esSKXK
 al06x5nH0pZviuD+2oDSkyy2UGKWhhxZ3sHz8+z9WbElaqPenlsbUt09CYgi1VHbM5tI
 wm3BncQkIOXlJAZMU0jv6ps4VpJskGqpX4nzH7r6JnMtEDI7bpba6cybVnezj8hFrSRu
 T79g==
X-Gm-Message-State: AOJu0YwbBNyyWcxQIog3LFnapJa5U0nXiWtpoZxZgiXBytzWbLDQ5qLl
 bwMXv9n5tDNLi7hzjoX3w93cDuwhEKfl2aE3SlXVKxzqnHz8Bm97N98veF98+jXbZi2cK/HSd8U
 0252ExJv0lcqf4evllMS7KWz4qqqEyqi6vmmhsJKJu0QZxMjtBrivrPIO3CgjajvAJVjNTfA1Ug
 2ktKCdp7GDwPgvx0FZZ/8=
X-Gm-Gg: ASbGnctxmh3TcLONnEXeTy33x79Ju1W1oYiJdXp+SxrYwFv9XTHexcsr00mBfeLdtEj
 ERWHiilzs99dYqfux9Evg5EWxkRXpHObhRaKGwcavmVvgNw9Dt/NN5Am/LzrRNb4uF5XHDeNRsd
 ANXqTzXioiIkeaAGs209E4yVvMsZPEozWFIBcbeLADvRISkMbD2kxC63CvEA==
X-Received: by 2002:a05:6512:3d08:b0:594:2bc4:8284 with SMTP id
 2adb3069b0e04-5942bc484edmr2690762e87.49.1762262069703; 
 Tue, 04 Nov 2025 05:14:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHISjuP107lAW6wLHv1Zmpk8aPbhfAkdMualVMzzPOicFvYhreE09OwcW5a98IF61NxxjVq7f8gCWBFaxqQX5I=
X-Received: by 2002:a05:6512:3d08:b0:594:2bc4:8284 with SMTP id
 2adb3069b0e04-5942bc484edmr2690755e87.49.1762262069293; Tue, 04 Nov 2025
 05:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20251029164616.76233-2-rjarry@redhat.com>
In-Reply-To: <20251029164616.76233-2-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 14:14:17 +0100
X-Gm-Features: AWmQ_bk9w--neg6yq_4xd7DT7XX-160xvwnTewTKl_C2bMZncorDtq4aj58ra6g
Message-ID: <CAJFAV8zQDhtFM+kQjQxkOw1T+iXfBK=jQQAP279AUbt-EyHFpw@mail.gmail.com>
Subject: Re: [PATCH dpdk] pmdinfogen: fix warning with python 3.14
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fGCknv9nZWzwhYy-dhVifSSci7x675whjX6YvxKOTvs_1762262070
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

On Wed, 29 Oct 2025 at 17:46, Robin Jarry <rjarry@redhat.com> wrote:
>
> Fix the following warning seen on Fedora 43 with Python 3.14:
>
>  buildtools/pmdinfogen.py:118: DeprecationWarning: Due to '_pack_', the
>  'rte_pci_id' Structure will use memory layout compatible with MSVC
>  (Windows). If this is intended, set _layout_ to 'ms'. The implicit
>  default is dep recated and slated to become an error in Python 3.19.
>
> Use the struct module which is simpler and assumes everything is packed
> by default.
>
> There is no change in the output of dpdk-pmdinfo.py before and after
> this patch.

Bugzilla ID: 1818
Cc: stable@dpdk.org

>
> Link: https://docs.python.org/3/library/struct.html
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Applied, thanks.


-- 
David Marchand

