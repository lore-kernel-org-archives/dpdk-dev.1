Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E44C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 08:38:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 414D240ED2;
	Thu, 19 Jun 2025 10:38:12 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 54C0D4025E;
 Thu, 19 Jun 2025 10:38:10 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4a58c2430edso5537391cf.1; 
 Thu, 19 Jun 2025 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750322289; x=1750927089; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dv7rABnsJPihHyAWw6pUvmu+UBNDbeFGaFnPaRCUwjA=;
 b=itdXyagE3s1ctkOlb9ezIXW7fsFCRabXLSOD8nHX5tIFNQIW5EYejJ7ErRzw0jjdPr
 35eKgEnyCedXaDyK9KEqcg4z7FcScvRlVtYqyuzlW/pwDyuSJBLX6mXOH4FWquZJoDuq
 H5c43yNB+Yz1uYNuzbCH1A1wTgnhPaeYgoTWxzvX0NrrwdPHhNszayVbKxJsIwOnaqYp
 rXl57fMMrNhHWGpGKbg/AdG4Et3eSh6g1NAldxVLoQmSzQGzW3rR0gWuGroTP7DhAasd
 KdPY/qN2cv4i9nqUGgf6t4FjSJAHbkL3dttDoAvE3OaQg46A1+JYZDc7ESv0/IImBtX2
 HEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750322289; x=1750927089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dv7rABnsJPihHyAWw6pUvmu+UBNDbeFGaFnPaRCUwjA=;
 b=HBGQIMIWK3JvHb6KFxRrVKaFvo5jyE+Y7G4iXiQ8AG6EqEJLfHmFF1xY/fuqNfvzP5
 Efp9ldOYp7vWsxer2SBpxzlgVZi3ixoJdumGM5LGsVzfhEcK1Zj2KVzxOeEeh+hp3N4Y
 4S90XEgXUmB5edJAo0pPb8ZPgj9N8zEg6roWpvK9iNHfcljZ8zCFpFuLDidZX2yAnxNi
 jUsTIChQNH0CF0gX5cSyOs4mQemltFEaz6YGn8yvcPtxPVx/30GE0PkmmBOHI6dKurS6
 H+xjqlWVk28gU4W29k34OwT4X3aaFcRZXx5wpeC+IIw9olUIszu6WFD8knUtsqeSENAO
 BgoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcRbrQpiws1DM8VOjlZIiBmPXOYdIXRIZlFOvIYhhQKnF2GEYHN9eTy7ldfvs5ZvCEcYLkREQ=@dpdk.org
X-Gm-Message-State: AOJu0YyIsfyPbXprbgwacjkkjCR97RiPfN7+S85OBb6EanQytAZa1cRQ
 KJLOSWA/v1seoIOsK/az0wGtz7II3PQDjzICQuTGPVeliKpYSYyhzibHA5XDO27pHlB+T/T1iJp
 c9chINqKaeR4QWf8MHtemCs0SH2gVbow=
X-Gm-Gg: ASbGncsDhFmIj2PYXV1mi/gtVNSGIqPLOBgvAHv9jet+i7P+fC0gk7zgFhUL6B5dNrD
 5SnjTFRUTACvXxLM9khd1czusGwsiAHHFbw1gTrAWStL22dfXdWttDLgNiPetah9WfmZdYAfn+j
 QQjIpHU8ral6FXSNrUI6wO9UeLcZTVhFmEjpHOYWl/dQ==
X-Google-Smtp-Source: AGHT+IGPuSIRrARmN/d8flUVftgvyxjYbSvHtmGXsoJDvtanQPSiPnEwqzlpdKcnHDDPqOX5gL8Ejg0n/pjDKWac3oo=
X-Received: by 2002:a05:622a:1245:b0:4a6:f6e6:7696 with SMTP id
 d75a77b69052e-4a76e2666f5mr39981691cf.26.1750322289530; Thu, 19 Jun 2025
 01:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250619040316.317733-1-pravin.pathak@intel.com>
 <20250619040316.317733-8-pravin.pathak@intel.com>
In-Reply-To: <20250619040316.317733-8-pravin.pathak@intel.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 19 Jun 2025 14:07:42 +0530
X-Gm-Features: AX0GCFvdqifPfQUgQGToNYjDBWk0BJwhqon85MvF4GyJAYuf9Z7QrluKAQF8G00
Message-ID: <CALBAE1OprL7gh9AWbHHjUBmKb4xMkX=NPphvPs_WKNQTs1AZyg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] event/dlb2: fix default credits based on HW version
To: Pravin Pathak <pravin.pathak@intel.com>
Cc: dev@dpdk.org, jerinj@marvell.com, mike.ximing.chen@intel.com, 
 bruce.richardson@intel.com, thomas@monjalon.net, david.marchand@redhat.com, 
 nipun.gupta@amd.com, chenbox@nvidia.com, tirthendu.sarkar@intel.com, 
 stable@dpdk.org
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

On Thu, Jun 19, 2025 at 9:34=E2=80=AFAM Pravin Pathak <pravin.pathak@intel.=
com> wrote:
>
> From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>
> dlb2_eventdev_info_get() that implements rte_event_dev_info_get() should
> return the maximum available credits as supported by HW.
>
> Set maximum credits before device probing by checking HW version.
>
> Fixes: b66a418d2ad3 ("event/dlb2: add v2.5 probe")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Series applied to dpdk-next-net-eventdev/for-main. Thanks
