Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34101C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 13:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0D8F4066F;
	Wed, 11 Jun 2025 15:01:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5A1A0402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 15:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mb7P6qjVvvr7hCze6s0MIH3mIAt21NOF6sDAMHdVVPM=;
 b=PHCI7s636XWdDLa5aBdl8SmkWbYeJG47ZG9WO3o0q0asH2BGGpMpMnT9nD/9N/IlJhO1rk
 tyvF+f04pe/KF9eTDHNkJOJNz0J8MnmDtWB3cptDxmUjK8RCoOvFWv2dV+3K38kTY9Rfd3
 q1XQfqXkPjI0LsK441XUarLKSrnI6tE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-oCv6sZ62PqCeXlL7Kc6u4w-1; Wed, 11 Jun 2025 09:01:53 -0400
X-MC-Unique: oCv6sZ62PqCeXlL7Kc6u4w-1
X-Mimecast-MFC-AGG-ID: oCv6sZ62PqCeXlL7Kc6u4w_1749646912
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5535e35bb83so3117730e87.1
 for <dev@dpdk.org>; Wed, 11 Jun 2025 06:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749646912; x=1750251712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mb7P6qjVvvr7hCze6s0MIH3mIAt21NOF6sDAMHdVVPM=;
 b=G+cS4ydqz74Tgc1h//1CFvMmk05wWK3x4sE3fuDevj0IeTNU6kldiEx6atWL9YxsxG
 /0rzaatE2tXC7mn2L6qVky1S2KvAeq//obEVz8FQMSyds1+KS0kiTu4iNLwc5qD70tht
 hQu2T1nMVFYzQN7x0fZEJCYglSkuN1nnBEIpk0HCbMcqMHPaXSpclPjk25rJQg50gohE
 83T7/zJg505uiUUnBerdKFkXHmaIWYGCKzfx2+vmjsad4Xw4LH6mXDnnE8OlFR1DPlFI
 4Q6cRy+oZ50zVVHtWFkfRdeDi61ITd1lvdgZDA4fdzTwVuDxgDouxwXX3ctEuoyNB5qb
 EUMg==
X-Gm-Message-State: AOJu0Yz9hier4yZoBnovFtxbx1rtwQB+zfS8YU3RCCqJtE5+NNSDaJYZ
 bDFvVf6Xw9S1+xT6Ub1ndRIBymp84doNfp8rsipuwmCu6/TshFv31XUTv4YycbCHMVZZeY2udUV
 kGyTxBkqss6Bbl9gXIAh5XbbLXff26F+qWINxyYBDbnwwKLo4/YKxhtJgVfzsELjlrydMg+FQ+H
 8neA/kawheIdfIW4yDem8=
X-Gm-Gg: ASbGncubtqha3z2wtTkJTZEcoHmHpxUZr64rgCog/x4wmfSYLfPT3l0OGtgrEbQbE1t
 xO4wFx66OUTjhmCaI/L9YLcjmBU9cdvhB7Y9EiCK+X0+xpZfi0APgg9qlzH9lDVmdWhPlUtdIpS
 ovKhTOGg==
X-Received: by 2002:a05:6512:1152:b0:553:510d:f470 with SMTP id
 2adb3069b0e04-5539c0a030emr1222871e87.4.1749646911605; 
 Wed, 11 Jun 2025 06:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmkcFhZQ38yrpLhMTmm3SbsabBBi/rRcl9NeiTX7BPvdoF/F3NJisG/Gyg8sa0RaQ+xFMIL3mF/DQdQ4gPRKU=
X-Received: by 2002:a05:6512:1152:b0:553:510d:f470 with SMTP id
 2adb3069b0e04-5539c0a030emr1222698e87.4.1749646909376; Wed, 11 Jun 2025
 06:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250402084744.334095-1-haijie1@huawei.com>
In-Reply-To: <20250402084744.334095-1-haijie1@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 11 Jun 2025 15:01:37 +0200
X-Gm-Features: AX0GCFtLdRgYdhovZqUmclw8Ye4cF2xlZK0g0nZTifna8zz9CmzmJkBvTiuQmGE
Message-ID: <CAJFAV8xXmz-KGUZE8XtjmV0N0Nzkz_UYGA7MD31imPV=DuQbuA@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update for hns3
To: Jie Hai <haijie1@huawei.com>
Cc: dev@dpdk.org, thomas@monjalon.net, ferruh.yigit@amd.com, 
 lihuisong@huawei.com, fengcengwen@huawei.com, huangdengdui@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JO4jhZp1vkjbe447sjkmGHiwRTaFrrKvkxOCOYILzOs_1749646912
X-Mimecast-Originator: redhat.com
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

On Wed, Apr 2, 2025 at 10:54=E2=80=AFAM Jie Hai <haijie1@huawei.com> wrote:
>
> I am moving on to other things and dengdui is going to
> take over the role of hns3 maintainer. Update the
> MAINTAINERS accordingly.
>
> Signed-off-by: Jie Hai <haijie1@huawei.com>

Thanks for all your contributions.
Applied.


--=20
David Marchand

