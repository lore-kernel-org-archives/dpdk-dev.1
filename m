Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F144ECA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 10:00:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EE4840281;
	Fri,  2 Oct 2026 12:00:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E79A44003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 12:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790935212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dP/jGeXMN8a3Wu3iw+iOQKnjhzsfPHZVSQyTgDpVFIw=;
 b=ZxQ3+N/yOVzwwcT2oLITpedb+X18ZDrZo4/36lySJ2QheRd1Yjkn+WPm/iRd5NIQeH4+JV
 Nrk1GG7hF5AzXEM2k81LpNe6YdzEE+hLVRBb7aXGzAIiIRW6DQMbrsj79+ZiS+m7jow6Px
 zCoxsMZKHFc8YDZpEhRV242gJqKP/jg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-S9qfo51GNRmjCMiD-Qzotw-1; Fri, 02 Oct 2026 06:00:11 -0400
X-MC-Unique: S9qfo51GNRmjCMiD-Qzotw-1
X-Mimecast-MFC-AGG-ID: S9qfo51GNRmjCMiD-Qzotw_1790935210
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a782da8ce7so11405461fa.2
 for <dev@dpdk.org>; Fri, 02 Oct 2026 03:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790935209; x=1791540009;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dP/jGeXMN8a3Wu3iw+iOQKnjhzsfPHZVSQyTgDpVFIw=;
 b=xzz1KQ8Mg8J4A0c/JC8dv+gnIPjF94b/4KpHOVqoYjuqz0cgdegtjslKqBI5PXHIUo
 hqqyGgKp6wWbl/yNgM1eonMeTUoRngx8rSJ5Te3M0vleRISD+IKvfrljqpDrT61mE+sj
 tdMe1Y2bskbzLG9OTtt6A8C481lzQ9vy/TFCYkDsgNFj4ZiGx3z2j6rokCm5ab1aKECY
 HChCMU5r/halFeA48+z8QCHgFcgr7rfDtBPWuzdWqdNXeA+y6Y86KQy6XddPAORNB/gh
 pe+Dps5MK1lKFVI+zatyhY9mBSDL/emylCYA5nVXt16XMVPtogrv1Azn96oUju5Q7R8Z
 HQzQ==
X-Gm-Message-State: AFq9FYL6CWfSEqHadwV7HDfLykit0fwUC1855tw0SFrlDwQVAfS0xC30
 TkVNQ3P5A1xihnYpC+j0zq5HqgCnlyo/pAkB1ytQkwCTNqtTos5qYkfM35a0ba9fJ8PR+0Rbcrj
 kAJIxjmPCeRpiVqrHFn9/3HmfnIJ49OJpG7sLAqECwJCuGz67jfA5miGDqvaFF9/FisdJ5XOGwT
 9bQ0FVjnJaJGh5j6TTE4w=
X-Gm-Gg: AYBFou22nbh9c7GLgeX9aLT+f2fG72ugqN4Qw/KcySpXMEwqzUQEzFs0q/gWL2Zd5VU
 h4vs/FU/jEcR5A44x3zMhw8d4XmS9YT54FImC/a6UCLZQIFEt405tTR2RlgKThxWbYbJgqWSfNt
 1mVdCacpwsUNf9BdT9evbODcKExScCKu476VGgV+VYYEyJeUCzzmPgC0w2MrUzy16TmHKK8hzyL
 EyEF87rKGZ/Y/Lbr4cuVLso17FNHo4YiUJXHFJ1eR5etbf6
X-Received: by 2002:a05:651c:b0e:b0:3a9:6f1c:928b with SMTP id
 38308e7fff4ca-3a96f1c94admr2135381fa.25.1790935208178; 
 Fri, 02 Oct 2026 03:00:08 -0700 (PDT)
X-Received: by 2002:a05:651c:b0e:b0:3a9:6f1c:928b with SMTP id
 38308e7fff4ca-3a96f1c94admr2134851fa.25.1790935206306; Fri, 02 Oct 2026
 03:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20261001090558.1131763-1-david.marchand@redhat.com>
 <42IOfTxsQM-Md_-aO3EZGA@monjalon.net>
In-Reply-To: <42IOfTxsQM-Md_-aO3EZGA@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 2 Oct 2026 11:59:54 +0200
X-Gm-Features: AclHuK_n3IqpiVYn_Mb0B3-0BLsIWK4MUZCMm8h0XdpVKDPMRvbIGm9HI1mwfEo
Message-ID: <CAJFAV8w6ueUz1gRJdTbXabnvEPE0tEse8ykKZS5a_agegN-yow@mail.gmail.com>
Subject: Re: [PATCH v2] uapi: update headers to v6.19
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, eperezma@redhat.com, maxime.coquelin@redhat.com, 
 stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: amMoygARPsq_F_CBciXvmFpNDYWMcif8gPv48eS154s_1790935210
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

On Fri, 2 Oct 2026 at 11:46, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 01/10/2026 11:05, David Marchand:
> > --- a/devtools/linux-uapi.sh
> > +++ b/devtools/linux-uapi.sh
> > @@ -13,6 +13,9 @@ file=""
> >  check_headers=false
> >  quiet=false
> >
> > +# Require unifdef
> > +unifdef -h >/dev/null 2>&1 || { echo "This script requires unifdef."; exit 1; }
>
> Do you need to send the message to stderr?

Yes.


> > --- a/drivers/net/nbl/nbl_common/nbl_userdev.c
> > +++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
> > @@ -2,8 +2,9 @@
> >   * Copyright 2025 Nebulamatrix Technology Co., Ltd.
> >   */
> >
> > -#include "nbl_userdev.h"
> >  #include <uapi/linux/vfio.h>
> > +
> > +#include "nbl_userdev.h"
> >  #include <rte_vfio.h>
>
> This is tricky.
> Is it documented that uAPI headers should be included first?

https://doc.dpdk.org/guides/contributing/linux_uapi.html#header-inclusion-into-library-or-driver

"""
This inclusion must be done before any header external to DPDK is
included, to prevent inclusion of the system uAPI header in any of
those external headers.
"""


-- 
David Marchand

