Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A0CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 08:19:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C65D402EE;
	Wed,  5 Nov 2025 09:19:19 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id E248A400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 09:19:17 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4eceef055fbso106746091cf.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 00:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762330757; x=1762935557; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ev4ERvvVAgI5Qatn7QC3AQ1Jeg+6gOi88FkfwIkAuE=;
 b=J7rJrAbvk6Jo3ohzcfyhEqJuzM99PW5/dqt1hCl0nQmbL8lz+H0q5lxj2SYUO7S7Fe
 UWJqn1KPRlqPsu5JquY2T7X66HKZtq1WmMdnDZLoseMPBFe1AmuJMo/OpJn2Riki/jYj
 rOmqh+JXLb13UztULfz6FDRdJhIw0jfhk6N8ZUVK9uilYMl4AWF25WwX/X1RpcNWHuc5
 eG0KQpCRMF3TzJWyiHvFVUfEgaNInREExa/zf3AWWsReAplFYYBWZmr6dgSldezL/5FD
 X7BvGQgMdORuPc5Lh8BZP1TuxSBp06bD0q0R3FUcq1mv3ljXUrdZUWjF9haRIWAaFgbW
 tUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762330757; x=1762935557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ev4ERvvVAgI5Qatn7QC3AQ1Jeg+6gOi88FkfwIkAuE=;
 b=L2Ge4FyfQ8mP1UIa5g/hJYpRyfYxnFKPVUDMQbEzjp0QbdmaCRAC6y3s13NEyY8tYo
 W+vFOkU9ePtW/BRj1ji3imwCKVKTTVc9/MfcP7hLGWhKuIJAqxJ/9XPS9oE8yvNihu09
 UkAbidQ5fyggd0tfCRIcddCp9rA52pdNnBxbhPM215scivUlfJQkruPnVoOvQNkzbANJ
 FTxsDAmxM4oAhVEWIcCfiZ5qfWlo/CImSy1mYn5Df+7La3SClMT37dq31khgra3MH2mN
 +m/52NeXAONNzWQm7LniTKBzZdolaI8/NLB7O38lu56ofD0iGW03o5Lv0fApsD62Nwc4
 eQmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUERp76FyyftEYb9UoNk5ksZMfYw5KP29q8xTUn497IVrATGnQn3WD8Su6WYZ0JbZxu6hA=@dpdk.org
X-Gm-Message-State: AOJu0YytcRJvA4VUJJMEqp+UpKNAeBPBKwfxf+dBpZQfnRN2azT4Xryc
 148FOCIws5+pNmK/L//PWM7HhVuOaUrY/BzHGXwsEFLtHHxaNhHAyqR9oLbgRj48qNI5uc8VCMN
 qtoWk60hIOR70TStnxR8InaM1okxyp2U=
X-Gm-Gg: ASbGncutXwXwY8F6EImXPg7FfzmIp6DqooLWqxa8WnpHKZydwJBT8kCHZjXdeNaD5sP
 YhTHc5kkzPQgS4ODDLAQkEhu79Qi0weznuoaLqh0hXMrGr+R/qZ1p6gSU/304GUzPmivLnilzpj
 EOkDLYVBJbWtWATwuwldLAvsZOhoY0SaAIe53Ne1aS5OTvLUOn6mhmiLfvFQkeKdqp2uMbXwWUo
 1Lw9bzQtIRU05LS5khFR2W9+9u0EWEW4+aJQhfBQ0jZoYMWniOzQPqaCF8=
X-Google-Smtp-Source: AGHT+IF7gr4iDg8b2JCleS2FhYw7dfPBA2GjGfA9rrzLqr9iygONsSFbNvoIFXmpWde996ruwxI1Ke3DR68elEaHMGs=
X-Received: by 2002:a05:622a:98c:b0:4ed:542:bb38 with SMTP id
 d75a77b69052e-4ed7267bb53mr31304971cf.74.1762330757279; Wed, 05 Nov 2025
 00:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20251030034404.4187369-1-psatheesh@marvell.com>
In-Reply-To: <20251030034404.4187369-1-psatheesh@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 5 Nov 2025 13:48:51 +0530
X-Gm-Features: AWmQ_bkF_FSi_v8h-sDU4hZdGX1MIAMz-PKgB-LJG4BUcsAzXzV-kPq0h4IrOx0
Message-ID: <CALBAE1Piqiq9GDTVwnQ4K3wsc7R-fhn31ikuc-Yt9NZ1U-D1SA@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH] net/cnxk: fix port ID default action
To: psatheesh@marvell.com
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 dev@dpdk.org, stable@dpdk.org
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

On Thu, Oct 30, 2025 at 9:31=E2=80=AFAM <psatheesh@marvell.com> wrote:
>
> From: Satheesh Paul <psatheesh@marvell.com>
>
> The default action for port_id is set incorrectly.
> Fixing this by introducing a new kernel mbox to read
> the action set for the port's default rule and using
> the same action for the rule being created.
>
> Fixes: 15f0b8a5b9e1 ("common/cnxk: support port ID action")
> Cc: stable@dpdk.org
>
> Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
> Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks
