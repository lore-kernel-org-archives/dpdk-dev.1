Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47813C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 09:12:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDCC340650;
	Wed, 14 May 2025 11:12:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2B59D4064F
 for <dev@dpdk.org>; Wed, 14 May 2025 11:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747213962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNQNdN3roHRKQ0KFPoGLUb1GETxwDyhG0BsOhunR1pQ=;
 b=GlBntQNS8p3JmPBHT/jVzau6eVevi89lg315dL2Hj+x3E9Kj17F+J1YRplr8tHIClMwTRV
 nY2sQ09mDHXJqLJFFSN5YCET2UiW3Qjyif4nSJXxsMdBCZodhhVNDsKltj/EecAjrl2WzB
 MmVSWHABx3g7X4Xa8hqM665oJTr2rEI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-VM274wIWN-CKe4-YpJCHaA-1; Wed, 14 May 2025 05:12:41 -0400
X-MC-Unique: VM274wIWN-CKe4-YpJCHaA-1
X-Mimecast-MFC-AGG-ID: VM274wIWN-CKe4-YpJCHaA_1747213960
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-326d14865beso23213971fa.1
 for <dev@dpdk.org>; Wed, 14 May 2025 02:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747213959; x=1747818759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNQNdN3roHRKQ0KFPoGLUb1GETxwDyhG0BsOhunR1pQ=;
 b=FlkIecUBAPg2ldrlE5YTqVVGAfVUxh5aXjY2VlySbadNEwDzvQ7rvRDHbEyeCXxkXg
 5VIscEkydXIoNWmr1y6qI68UlHNwNcbkzF3tnTuPuBkMFYQ56vsI1YJglvVun9teIAyz
 jm8aKWrfscFwftYElUEIfwcOKzfY+HYCqoVhhEg23zsGOTIyx9Ochwp8hCTBzDnLtCvk
 JHM1Y2fcfRQVkwq1VQdgL9rgS+FAvyTzTM9PeoaQqi/iW4skZ/M2AbB7vLORvKqI+bxh
 3oZWGP4ms8bpfJPNCt9pr3sPEf8Rhv+DmJ4KjOonuKtO2syeee3dMS4T5Sb7dbHrhwcS
 5ikg==
X-Gm-Message-State: AOJu0Yyh/+Au6mw2RCicUqQ62TOKkEFu6h4jWn986+ehnzDbc7Nikcxe
 d38R1rz1xOfGvwBlL09MQaQBsFLOwzMhWSp30WDf/G/x8nEIzTHuqhoecUqIIrzanafA84B4Xzd
 3ZqOmyNe7v/olwFh/oq+OhLuRSsF+S5nUi8jV8U0cO6Dpn4lxBdL87rKxM9PJgTiKNWS2BwU6KO
 rrtu60h1nOj5GUkNw=
X-Gm-Gg: ASbGncv5HIVr+9pWYP0f32v6W1At5mqqygGenubFj6To3o/gq01/gPKjZSJlwkfpppI
 jchtCJc9stTaMj0VrP1BnLomseLN45/E64oKVK76iPrUoZGs1stu4k7kIEih/DrPa/kbAw3M=
X-Received: by 2002:a2e:a9a6:0:b0:30c:50fd:925e with SMTP id
 38308e7fff4ca-327ed09182amr9345571fa.3.1747213959581; 
 Wed, 14 May 2025 02:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2kFikjlAZwK/REWb8qLpIZKMJBZEcZPB3xNVNqNaoSWc+cB+cWqx47r0ZKwJCEpUDyAxk0j6lHWikEN6FvFY=
X-Received: by 2002:a2e:a9a6:0:b0:30c:50fd:925e with SMTP id
 38308e7fff4ca-327ed09182amr9345491fa.3.1747213959180; Wed, 14 May 2025
 02:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250408171902.2833850-1-bruce.richardson@intel.com>
In-Reply-To: <20250408171902.2833850-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 14 May 2025 11:12:27 +0200
X-Gm-Features: AX0GCFuAOjtDIWCMcT-JjmatuMjSf3bi3djYl6jAuTu3TMcxu11UDIQL4FvJy_E
Message-ID: <CAJFAV8w2g9=-=Y5soQD14+-=xZ-eE-2pG-RekE8a+r5p=17cjQ@mail.gmail.com>
Subject: Re: [PATCH] doc/linux_gsg: remove note referring to old pkg-config
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1qcx43Nt09qwi7aQvf7jHFQUiz_7nX2plS2oRpTTcFE_1747213960
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

On Tue, Apr 8, 2025 at 7:19=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Latest DPDK releases no longer officially support RHEL 7 as a target
> platform, so remove the note about pkg-config not working on those
> systems.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Reviewed-by: David Marchand <david.marchand@redhat.com>

I see examples still refer to this issue, could you send a patch
cleaning this too?
$ git grep -l check.for.broken.pkg | wc -l
52


--=20
David Marchand

