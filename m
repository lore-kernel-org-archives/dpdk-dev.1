Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3BDC43602
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 12:53:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7358D40268;
	Wed,  8 Jul 2026 14:53:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EC22040265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 14:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783515180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9PQiBR5bvkLSWS81UFcIRvn8lwwtiRkBDNYMaw0dT8=;
 b=gpCyadZU25JDZ+S1GAb9ii7xWi1eFCG5/Y/RK9rglRZIO315Jl2Ewv0jZ47EyH+GLxu8j5
 CM+vgebRN1LYF73ZTJEWATBXvLnbJgjuLLyvPo2akcc1wXD8thcYv7/2NDezplyu5us5VA
 RDIgZ0kZOAwHSNcOYakPWQrnMLTaw1A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-rULWZ068M2GNkjA7YW-7rQ-1; Wed, 08 Jul 2026 08:52:59 -0400
X-MC-Unique: rULWZ068M2GNkjA7YW-7rQ-1
X-Mimecast-MFC-AGG-ID: rULWZ068M2GNkjA7YW-7rQ_1783515178
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb423df3bso479015e87.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 05:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783515178; x=1784119978;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b9PQiBR5bvkLSWS81UFcIRvn8lwwtiRkBDNYMaw0dT8=;
 b=kRd+JcT74rsnX5C2fQ3iyhC/iyx+sbV29nV4BHTn+OzArTq9r8VrQxpKOFqJ1His3w
 iDvnQrYoXXAa3tUJVzPhcdeFsKxzmN3y8JO6s3QNPyl0BcXvmS6PrSVxRZq/inJDE0AD
 8thOD9MWCXwOt/aXbybHlax/flSG6fzChFvZ9BqKlsVDZ2uijzqyBWp7KbrWp61zKxhT
 qbL/MTSyeW46VuQj9k9RjWvY2hXk4IVgC66Y0m4EZv3wn7xh4/g7E6+1Ua/9X7m5YHLB
 rehRVwj9gpfxvwnCO+b/FWTkGY0kafQaoFp3F1QuE3IaDMlNEJ/b58rRiq1+H5nnk8IZ
 DJgw==
X-Gm-Message-State: AOJu0YxeUFtu9hP56M/1RzUslEUkZ1jQTZfRA/4+EMKuc4M+N3JCTbLs
 8wwCftInVNFJ4X/3SoJG5dCxLgvzKL4MJVwpPufXx9R0LcrFqZFpVN23PBTiSVglVMRueI2JCEq
 DKJlCm8qT4SKFf38Grm/FeNqhGDUR0aNDkb3uMIZww0x4BVcKvOn2OVcn89fUGo9CGQsYGo9sRN
 W4QpzYeBLhxvZmXAul/Hc=
X-Gm-Gg: AfdE7cknJOMY+f9ev3UZmvCyBgc2GuNtaMHv7+7XwI3CfcWlL65yW+vYojFW5aDUa95
 MLKrBkLE6TPh/IxGA2puuTCI5gJTpk8jPFjFCdMJrE5znZy1CuPwxbYd5sTsBpO+L4PPcQnQtL6
 pPABpC9tGyCO0LL2ZcKNq2wS5aEq+xsrb2bmo1emIy8jocY0ADSx7xBqUAFSC4DTf5Pqb6LoE4g
 Z3sqkXAgh+w9TqjKp9uGWVvPVQFRP5rp60wm2VkTSJ1B7IoSIQWyE7h+QA=
X-Received: by 2002:a05:6512:838b:b0:5b0:d0d:1f41 with SMTP id
 2adb3069b0e04-5b01145dc07mr543280e87.32.1783515177785; 
 Wed, 08 Jul 2026 05:52:57 -0700 (PDT)
X-Received: by 2002:a05:6512:838b:b0:5b0:d0d:1f41 with SMTP id
 2adb3069b0e04-5b01145dc07mr543261e87.32.1783515177297; Wed, 08 Jul 2026
 05:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260706150611.839502-1-david.marchand@redhat.com>
 <akzcxJwc0X_9UXFV@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <akzcxJwc0X_9UXFV@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 8 Jul 2026 14:52:44 +0200
X-Gm-Features: AVVi8CdqAkQe5jHPlfnuIo5Z8AllAN8Q-nJ9ATnjslRY2cPhaDWW6tf2ogRyXpM
Message-ID: <CAJFAV8xfWWEWM5sm=nQwW5pi-vYj+C+gudgbZKs+wK3rvTKy8Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus: remove blocklist evaluation when probing a
 device
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YLaXr_4XwdhTOE0LfMhYm09YlkwO7m023TUCDQUZGcQ_1783515178
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

On Tue, 7 Jul 2026 at 13:02, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Jul 06, 2026 at 05:06:11PM +0200, David Marchand wrote:
> > .probe_device is called from EAL, that already evaluated if the device
> > is blocklisted.
> >
> > Fixes: be29c42523d8 ("bus: implement probe in EAL")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

