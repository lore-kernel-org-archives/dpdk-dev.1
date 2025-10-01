Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69204CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:25:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8777C40B8D;
	Wed,  1 Oct 2025 17:25:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0F7D940A80
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwotjoKgD8Vt6rgeM1n/UcTs8oBxP3cBE1axRkCViQM=;
 b=h6l2x4zpklKNqNRH7yz5bkwTFB2CtFTVBeU/u9PiwIFiMEvRydlsjUzN4IHPk2zz4n9CFK
 aKk3Hk3cgHUqEVeqcenCoTewPUcXW3C20ecdwCW+6jMw+fKd5vrGDjVm5G8m0w7FxNgEee
 Tf9txiWLlqYK3BnMtvhEoeA5k2qFPA4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-jrHPnvVtOeqTfxmajzOvig-1; Wed, 01 Oct 2025 11:25:00 -0400
X-MC-Unique: jrHPnvVtOeqTfxmajzOvig-1
X-Mimecast-MFC-AGG-ID: jrHPnvVtOeqTfxmajzOvig_1759332299
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3654fd1a668so36244081fa.2
 for <dev@dpdk.org>; Wed, 01 Oct 2025 08:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759332299; x=1759937099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwotjoKgD8Vt6rgeM1n/UcTs8oBxP3cBE1axRkCViQM=;
 b=r7unk0T7YShPQbzg81jWcTzk3YlLnBQP76dzsfhRrNCjTFWJEGY14eSxOWK39gmVsr
 2h7xMNtwGdDTyNcGLCh4oEsmsf1wtSnkop1oURLMLBVDXwaKMP0cF2GLMUMu5eTiwpWh
 gg39nx9J0LDFQx9CcOYdH8kxCGjIJYL8MvRFoNreSyqdLpIsStmJzb4sGyF2GxIXXlMo
 vxEsv+53BJ9S3KA0zvpgTePRx2kaxXwAfSb9ZrGd6fuGRv0BDA2WpjjS+ewWUUDta3AF
 a8LepSIWcjTO1mJWRYZNQe6rhwZrmkc7r/eXRgmdwLnCvT7LKni2XQ2MTe7HYFXCi82W
 O/rw==
X-Gm-Message-State: AOJu0Yz1OhQFQqHpBhVtmPG+1y3ehRG53U31d01UMYyaioNjV+RMllxN
 vLzceSK+aSP+1CBDb+/qtva0IHoUPc8sZfC/+UQHexEE4JfWjX9oB4k7DRx0Gnb4Ca/QxbtUSVG
 6fsXWS7bW6vdy4JhEK0E2eV31yboc/jHxW/MK7zyvAM6ZvzRqUVcAO/eeMJ5bnfhuBg2CMfAqlG
 KtgXzGzZTssDxll0XQC7M=
X-Gm-Gg: ASbGncubHBhBnQfKTf/5F6xk7w+dK6YgessKyLxda8V9kRmKBSBe3X/MUc8PoR8Ok2Y
 miYL8TpP4/gvdy3DlnvfPjJqPZU8iOwLr3/tmwou/X8BF/wItZBNBOzWIWKSys4YE3Wn48QURpV
 N8hA23EMJEfWo6X6yL1E13h0y6MCic
X-Received: by 2002:a2e:bd0e:0:b0:368:2cf8:5111 with SMTP id
 38308e7fff4ca-373a7452334mr9750981fa.36.1759332298707; 
 Wed, 01 Oct 2025 08:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjxNTmS+dZQjKSCQXvRUoSTtXpw2ijWw2osHnIQe8QEekoiXHaS5xRwDUlQeIEMvTwe4BVHpSoIGNtE+NGZiM=
X-Received: by 2002:a2e:bd0e:0:b0:368:2cf8:5111 with SMTP id
 38308e7fff4ca-373a7452334mr9750851fa.36.1759332298250; Wed, 01 Oct 2025
 08:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250919083808.1667491-1-david.marchand@redhat.com>
In-Reply-To: <20250919083808.1667491-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Oct 2025 17:24:46 +0200
X-Gm-Features: AS18NWD7qgg5JJ3wvaQ5-xntM7UuiGQ-1RFaExRHA1BFXyPWg_z61oooMqaMUHU
Message-ID: <CAJFAV8y7btqbr3MzGWFn7tVJvR+GVUXdVrcUC0_KdjS5D7HFiA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Cleanup VFIO API and import Linux uAPI header
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, maxime.coquelin@redhat.com, 
 anatoly.burakov@intel.com, stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vrJI-FDcAGWN1-wpeLqW5bv7-DpCqfGWX_ULt6wZN9I_1759332299
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

On Fri, 19 Sept 2025 at 10:38, David Marchand <david.marchand@redhat.com> wrote:
>
> The VFIO headers have a number of issues:
> - showing to the world a lot of internal considerations,
> - defining macros with the VFIO_ namespace (confusing, and a source of
>   conflicts with the VFIO official uAPI),
> - wrapping around VFIO uAPI in case the kernel headers do not contain the
>   expected API (putting the burden on DPDK developers to find the right
>   way to detect the presence of a VFIO feature),
> - (somehow related to the previous point) supporting old version of the
>   Linux kernel while DPDK now requires a v5.4 Linux kernel at least,
>
> This series proposes to cleanup those headers by hiding as much as
> possible internal macros and structures, then removing the explicit
> inclusion of linux/vfio.h from rte_vfio.h (pushing this inclusion to the
> application which may want to do some funny stuff with VFIO and should
> already include this header on its own) and finally importing the VFIO
> uAPI header from Linux v6.15 for internal consumption by DPDK
> components.

Series applied, thanks for the reviews.


-- 
David Marchand

