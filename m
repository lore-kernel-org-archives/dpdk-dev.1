Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F3CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 06:25:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0C9B4013F;
	Mon, 22 Sep 2025 08:25:36 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0961C400D6
 for <dev@dpdk.org>; Mon, 22 Sep 2025 08:25:35 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4b7a8ceace8so42741871cf.3
 for <dev@dpdk.org>; Sun, 21 Sep 2025 23:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758522334; x=1759127134; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cs2Tv0PmVLday1oP6JSV6kE3CIsx+OOHJGe4nMFnteo=;
 b=Vtmti28YFhbS28H0qWwFdbtfo94ZDUS1GsUwZSz0RbDtPoJZoG7YWhw/NtLkxpCBri
 Q7ZIDakqYaSlThTjN992y/PVdhS2qGhZgBK3JSqmjikeZIK7+ZjPOpKV3S9hd2aF2Zo1
 RaDkIzNVRiUBLak3GoozSSWe4xRpzNw/U9XBjxRSIqobj6a94TbZBFIt7/IZ2G/6RJ8g
 EH7RCZenGKMeo5JcFDWIjjhKP0a9+BULuo4oVhhaCEo69L9Kzd57mg3lwwHuKHDpzuw0
 1SwoX8PWpFWyZrvW1HfTIuK1IWIewRZcu9QiOCczFLJSnoZANXPD283Y6LIcEbI3s/BA
 aE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758522334; x=1759127134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cs2Tv0PmVLday1oP6JSV6kE3CIsx+OOHJGe4nMFnteo=;
 b=SnRsKDSHdv9Z2OOeM16AXwKQNFi8Mn3MFmMXmhAphR1vcd1BbMys5hIc1P+3RIPPJp
 XO128h4e+GDHq+r0uukurzxWB6bobdSgN+NFlQtqqPk0TwoEMICQ8cMrsQqJI0sB2XiB
 gIJKQxcKJa4RmsDsiSDjxXf0k1S/naedK/u10Qtvh0IdUwqSvtnOq4AVccUNgrxIn9Or
 je+I+PJMBqlz9ZUwhG5pLUfbDEKGD2/O3u5W8pZB1mLEfd3U5znbMcqrTkxmFRJ6g5Qf
 8Fne2oghem5zOl5WDx5McPh9sTWqxYj4TU1VyuXudCpnzGwVPWCi6HQbZK6mxDiFicDI
 UR2Q==
X-Gm-Message-State: AOJu0YzSjQgqbmITDuMkgPCXAX79z4QsvRl/IUpVDN6oTFR70bSDcyVE
 oVjK6SQPThQh0E95vxm/UXbvqpJWNfXT1yWbM1d5vrnWY5aGQV4cxqIlqpxrgLRcYRmEZqfVgVW
 SXaiz2SggcOLiZ7yjXLFcvz9L7hc3yJI=
X-Gm-Gg: ASbGncs9+dDu6Myx4QaA6/nVdryEX7LtaCzIWtRmAx3OiCss6SyrM9shXNCvvPT93DF
 xiKiRn1NEE6xyWdC0OUXRX7UcQfFf6m/t8afxq6+qB8rzrJCUV91KwXrTf1l74x+7tsPJPZ0s1+
 /xk5pthGOBWHEieo6EimaUtZmH/GnpvQs7bkYycbkl8hRu5LCZgQpiwcAZan02ZyuL6PpAbJUtW
 mVu3f5I+tK6sCXavYog/cDpew6zCr9yZ/GGjZtsaD+c9hTy0gevkdnc+IbksVM=
X-Google-Smtp-Source: AGHT+IFJeMNB+Cfz8T+F9tmPy1jzzUGVkDM8Qm7cdnycAt/iTIM0AJK/ll5mynGWGtHe/MPE7fVkYIKwsZoivdhMYKc=
X-Received: by 2002:a05:622a:5e19:b0:4c3:ca4b:a1f0 with SMTP id
 d75a77b69052e-4c3ca4ba3d2mr47291341cf.68.1758522334286; Sun, 21 Sep 2025
 23:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250730025109.1245119-1-tduszynski@marvell.com>
In-Reply-To: <20250730025109.1245119-1-tduszynski@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Sep 2025 11:55:07 +0530
X-Gm-Features: AS18NWCWk9hMyfn_mQs58Xt5kMFHIXvN8XAAjr-BdL4GhfGyOarZxAnBNDNZkZk
Message-ID: <CALBAE1PFos4rysaxSxLJQCf1LhUjjuowg7-t-1pAQZ=HhkFNQw@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: fix async event handling
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Jakub Palider <jpalider@marvell.com>
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

On Wed, Jul 30, 2025 at 8:21=E2=80=AFAM Tomasz Duszynski <tduszynski@marvel=
l.com> wrote:
>
> If async event shows up unexpectedly ack it and continue
> until expected event is received.
>
> Fixes: 857721d62d42 ("common/cnxk: add BPHY communication with atf")
>
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
