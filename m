Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882ADC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 07:53:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A9634026D;
	Fri, 27 Jun 2025 09:53:54 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 00DCD4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 09:53:53 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4a43972dcd7so24767161cf.3
 for <dev@dpdk.org>; Fri, 27 Jun 2025 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751010832; x=1751615632; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uiYKVyzp/mqPyUB57qYAQPJXxPsAhJ2nslzrUBHRCNE=;
 b=fXf4JnUyv3uw7NkmtmSR2k2t2mTtNBfRPUFXNTwPSqUwrGY17KGnmkhOQg0eDlk1RL
 6+3rIMp6cczVXQi5PWXuqACXEiGk2Asd12rGhOacOPwCR2wPgPSPLrvagm0C94QxMbBr
 pFONz2fpuKJb8nuiKDineGB5vHFf941SaUPGr8SkJY0CwAKm5g+Muwe0AEOjYzJKJoDg
 UZk8M7SYi7WrG64rznasN8n0IAS9Q9dnTU5ZEJ12ffj0TuHqgZ9WQY+tyOdfNyQCYdey
 fVT3h3cgF53K/W+Ako8/+L4x4Qja1cbUJLfJ5BA38AOxhp6vT6KN3Uoje4SagXC6zqz4
 gq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751010832; x=1751615632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uiYKVyzp/mqPyUB57qYAQPJXxPsAhJ2nslzrUBHRCNE=;
 b=coNNzRtuWHhB6ihS3B2JyYP8ZDcq8fEZ4i75utZ+97mc5cI/VrT2tmHJdnuIi5zViB
 vTAhEdx3SZDb9/HTGiy2ODG1JSehwKpH3cofxQPjdq0uIiKuyLJfxInOBIa2KmC+RMho
 /9QtWtH9W61FarWN8DvexCGNV0k1FbtIRelm7Ialnw2LtGtZTR5iHt/MUcDmXOhP7tw7
 01Rb+0du9Gvz4b6VcixIB6Peo3nVhpYcuv5f/HewiUrKczUvNFX0E8q65dc/kG//NMB6
 trbSstSgQ9HxwzQZGlYnPguuEtJv84Ildup+i74qMqIyO5grwUkGVS4VHGDnmc3T/BdG
 xjXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvS7LPbM6Vu2CKIX0CTKPB7+64jIztLZvDq7ZShrJZDOAtECrYF4TK9L27GOK3a2FIL14=@dpdk.org
X-Gm-Message-State: AOJu0YxRekCXH1Fhc3IbMnpJcAKFXXBVpuaWTcGKrO7vv3vhPnPukvZU
 QzxbyYgPuo9taOKrv8U6dP+WEGz07R/oZEYWEzJ920JowybsGoPt6AWz+IaBenYfcxd5hOuuKZf
 69gzxieKDOUbNCq+kLfO4Vepefqnva7Q=
X-Gm-Gg: ASbGncvxoSrJlvJ51CyUwzTKsrU9aqZNWmgorP/rTVn1sFyO8mW2dyWORDngv0HbJSG
 Mx7zaegEW/MSgNGNeAqZf8IsERrycbEGYTQZCHd0+k0eWQ2lmFmb6ZbvoWn/BoVoxuhpb63Kol3
 J58dpFe6j5EYlig8UR0XqN/1YrHyLzWPb0+WHkrblFIQ==
X-Google-Smtp-Source: AGHT+IFXON2aaemlzz9i7nkAOaqcgmG8WPGf4d0WDQX4km/DG+mgeFHqpkoIlEI+0U2FZ1xpuCWjMQye9IpiPQb1eKs=
X-Received: by 2002:a05:622a:11d3:b0:4a3:6cbf:1fb4 with SMTP id
 d75a77b69052e-4a7fcbab30emr37400811cf.29.1751010832284; Fri, 27 Jun 2025
 00:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250612001338.71098-1-pbhagavatula@marvell.com>
 <PH0PR18MB40860834C1DE674B225A0AB7DE7DA@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB40860834C1DE674B225A0AB7DE7DA@PH0PR18MB4086.namprd18.prod.outlook.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 27 Jun 2025 13:23:26 +0530
X-Gm-Features: Ac12FXz13nvnTZ7ay2l5wXhKYG95qC_p-nT_0KNJbNzqxjB8YNtaZcCJesEOcSI
Message-ID: <CALBAE1NOg-1QSdSJ+s2SBHYBn06QAqUe4CrugnzLeHmDdvr1oA@mail.gmail.com>
Subject: Re: [PATCH] test/event: fix event vector adapter timeouts
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 19, 2025 at 6:52=E2=80=AFPM Pavan Nikhilesh Bhagavatula
<pbhagavatula@marvell.com> wrote:
>
> >Sent: Thursday, June 12, 2025 05:43
> >To: Jerin Jacob; thomas@monjalon.net; david.marchand@redhat.com; Pavan N=
ikhilesh Bhagavatula
> >Cc: dev@dpdk.org
> >Subject: [PATCH] test/event: fix event vector adapter timeouts
> >
> >From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >
> >Update event vector adapter test to depend on service
> >core cycles instead of system cycles when waiting for
> >events.
> >Reorder event_type check to make sure event received
> >is a vector before dereferencing vector structure.
> >
> >Bugzilla ID: 1720
> >Fixes: de09387f1313 ("eventdev/vector: add default software vector adapt=
er")

Acked-by: Jerin Jacob <jerinj@marvell.com>


>
> Recheck-request: rebase=3Dmain, iol-unit-amd64-testing
