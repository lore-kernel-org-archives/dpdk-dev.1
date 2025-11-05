Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E5CCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 061D940615;
	Wed,  5 Nov 2025 08:17:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C2CB340612
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762327021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8UAO1iy6j1aAma7/AQQh4tPqz/bzwn9HBJCbW6bInY=;
 b=Elej+724+DJx+B2fV9qRcBChtgqqUkcVt74tPWpy3VyALtiMFcMn2QC/iT+z0S9TD1a6fY
 /NxsEGjg5TQYu67Dbkn1unJ0acH6GmLi5ZY8pHNGYyi4Xub0YCzckaud83egWQ5wUHRCnN
 szMpFv+u6JueuMhh1k2qq2Yqko0Wn3g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-wghhAg3-OUySf6EN6ILALg-1; Wed, 05 Nov 2025 02:17:00 -0500
X-MC-Unique: wghhAg3-OUySf6EN6ILALg-1
X-Mimecast-MFC-AGG-ID: wghhAg3-OUySf6EN6ILALg_1762327019
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-378dced2d53so40781331fa.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 23:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762327018; x=1762931818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8UAO1iy6j1aAma7/AQQh4tPqz/bzwn9HBJCbW6bInY=;
 b=roO4UCUx/qq0qHWIEx8RAziNDZrZksQmCnQQK4A1czx50hRCIOPrV990RSn6+4r/Tx
 nFeF5/dCLFykkLzxsH97WJVlJvD7Tm54QCQets37QlQjLdSg4wfj4wb+tB4X8sYR7FMQ
 ZVdsg72Zjk4+z9RwedR4qa5eZss6WgatmY8SCuppW4Jl97ROxlrxSSBjuKj3rWL1OqPr
 ViucM0W84Shx9RPvwLJBv9j4gD7i5TO5wFLNS4yYGjMUkj+NPhExVGB1IB7xx53QhPYc
 5KCVohJxeDR9Y8pAIubNQhWMTsewk6D2O98XsdMExTekJ0s4oUENYxPmJ0Cm9DD2K1BU
 sJ0g==
X-Gm-Message-State: AOJu0Yx5elUrKuKfBCFRkhMslfZQG1AOvrhvmZS3CjbFP6ci0LjZICvu
 yS6fRXrreoF8uW0Zhhi6aws/KVmOFLRiIMvY8wJMaz0cUYS2MLN6cH4tJzyFMPAvNcssUTslMIl
 WRWL95J/P96spUoBix41zUuapZV5impFqtRtXeVKDuIUq9QpS29Nkwa99HwXwzun7A0Pz1IOpw1
 K1+RNHtnqOeab8b7dVnm4=
X-Gm-Gg: ASbGncs8HKmYNXfKhURtUTgTXlaIzH3XQmA1DBqfAcKY/GABEo9NCcfJrujNs87TCE5
 4/2TQSgBTdR/nQpI1QWI0NSkdZ+WrESB8jPP+0rE9rJRK5pn68NrB9OARZHBQvpdpiARkTgZsnD
 GG/+41iP9KbsbaMD/ewOHj9ZpPlgg8UeIhNl2n7fiBq6+kWeneyuGstAarog==
X-Received: by 2002:a2e:7d15:0:b0:372:8cc8:fc3d with SMTP id
 38308e7fff4ca-37a513e6d9amr5198071fa.1.1762327018557; 
 Tue, 04 Nov 2025 23:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHJf5u5ydiEoXzqVwMjtEU6ueadkNy6zhcMzzDCE1uE20J9c7QRh+6fXtOIQdhMZjiFr5GJN9ogket5tul2bI=
X-Received: by 2002:a2e:7d15:0:b0:372:8cc8:fc3d with SMTP id
 38308e7fff4ca-37a513e6d9amr5197941fa.1.1762327018086; Tue, 04 Nov 2025
 23:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20251104130808.2692053-1-david.marchand@redhat.com>
In-Reply-To: <20251104130808.2692053-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Nov 2025 08:16:46 +0100
X-Gm-Features: AWmQ_bl48Q3JwMoq7b2TE3xdJ6JuomUQlyrgZ0W1vH2ZyRwPxeuFZ0HVm3YM3jk
Message-ID: <CAJFAV8x7_9AVY6--gdUauNJ=swQZ6AWdd9eWqCq12UF3MybhLA@mail.gmail.com>
Subject: Re: [PATCH] rawdev: fix build with clang 21
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Sachin Saxena <sachin.saxena@nxp.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eeHYqREFk-951Il1naQQFrtYwckabkF6AK9G8T36z3c_1762327019
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

On Tue, 4 Nov 2025 at 14:08, David Marchand <david.marchand@redhat.com> wrote:
>
> Fix 16-bits formatting issues reported by clang 21 on Fedora 43:
>
> ../lib/rawdev/rte_rawdev.c:429:41: error: format specifies type
>         'unsigned char' but the argument has type 'uint16_t'
>         (aka 'unsigned short') [-Werror,-Wformat]
>   429 |         RTE_RDEV_DEBUG("Start dev_id=%" PRIu8, dev_id);
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>
> ../lib/rawdev/rte_rawdev.c:435:9: error: format specifies type
>         'unsigned char' but the argument has type 'uint16_t'
>         (aka 'unsigned short') [-Werror,-Wformat]
>   434 |         RTE_RDEV_ERR("Device with dev_id=%" PRIu8 "already started",
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   435 |                      dev_id);
>       |                      ^~~~~~~
>
> ../lib/rawdev/rte_rawdev.c:457:40: error: format specifies type
>         'unsigned char' but the argument has type 'uint16_t'
>         (aka 'unsigned short') [-Werror,-Wformat]
>   457 |         RTE_RDEV_DEBUG("Stop dev_id=%" PRIu8, dev_id);
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>
> ../lib/rawdev/rte_rawdev.c:464:4: error: format specifies type
>         'unsigned char' but the argument has type 'uint16_t'
>         (aka 'unsigned short') [-Werror,-Wformat]
>   463 |         RTE_RDEV_ERR("Device with dev_id=%" PRIu8 "already stopped",
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   464 |                 dev_id);
>       |                 ^~~~~~~
>
> Fixes: c88b3f2558ed ("rawdev: introduce raw device library")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

