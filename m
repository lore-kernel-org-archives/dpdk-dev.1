Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984AC7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 18:07:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6043540276;
	Thu, 26 Jun 2025 20:07:24 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 74DF54026F
 for <dev@dpdk.org>; Thu, 26 Jun 2025 20:07:23 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4a752944794so15845301cf.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750961243; x=1751566043; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlsXVayA2cIObo7TZgnPtEBtoEHs+gVmiVDc3tIc80k=;
 b=ITl8bHD7ZXubuEglj11rbLiw6FYbA+cQDKH8oGuLMssP/mTACS8q/zUExpRdi98ksJ
 yj0PvGUmcFlAJsJUAcUWN5VP0UHmxPMDoMsO5BTo79aNNPIuFJPrbr4P83V9uNO1nCb+
 N7tgMrd6neSDAWdU0bVjrZ54HQPSKPZu+TzpDS4U7qgfGduXRDX9zVtGcZt0vCh+xRF4
 pvvLRbjVIUJud5LNwe0UlhTD8SzWjHGe/WVCBuxDv9n5aGNektPIHq/+YkU/cAecx8HK
 bD8YpIJsrufyF4VmY2Vi+hgvTTpukVcLH7iyO1hMATUPkkXYufyYGUNsMItry1SBkZR+
 ZbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750961243; x=1751566043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlsXVayA2cIObo7TZgnPtEBtoEHs+gVmiVDc3tIc80k=;
 b=s9GBexbPWi4hiOGV/8xUz0MsocNJ+SCOtwWJyZSWhxQS85ExaPRZS4vXCvpi9Nq/su
 RDDH47eKBlxtBTZW8vT30YDymIhNi/X3x0UQJ9wd1BlFYYF/vS9Yychntt4LzYtIk+qh
 dcO+9Z1wVaHJhuT1WQgOi9tegSTlkg3qLLtOleaGM8GZTiS7Lw4D0eVPWvbprKcfgFfm
 PsAcEH/NzGyYHMVBl5/onKv2a5I+KI8KgljSN9s8xrCMzPQ2CpJFI+S4G9cPOEzdZ5Qd
 aYzEKIa4dz1FYQQ5GpnoODhSRpX3HBuBkHNg01Kc6W1WZccydTU5Xitj+Nsv0Xi3sSPB
 HMjg==
X-Gm-Message-State: AOJu0YxQLCprSVi70epPbKVNoCSz6Bu4vwpzZP9WDjGoxFUjdJ4lBgJ1
 1weS+JqpwgFOY5JEwS5QxdKtZfwEcF/HjN87Z+PLgzBTStiOHggnOwOxjFOmAt+vM6fcLltHPTq
 WSZk9SrnXFlE+Pl22MR8owCHbV5uGv5M=
X-Gm-Gg: ASbGncv4dsIXVA/0+Df/6G9+u247Cjp2wi3M6lT70Q7N/Y6zLQ/dGHlkqcNzLG8acii
 9LGqRY06Oxe8i9BtuYnXlvMh42uvz6ebj2qr5xTnfMJCQ3Q32ECTcLDkIk20GRvX5d2byv/SKXF
 Zf2B3+deKPV7tBwPDKIkC4TpCdq2XOnPzQG4olwO4KNw==
X-Google-Smtp-Source: AGHT+IGgL5BmpmO8MNGQaICYzpRp5/mgd4nTGYstWzofRoP1IxyZztgmENmZhatBH/k5AaAX3PZIvfkNlH5JQ5yjGdI=
X-Received: by 2002:ac8:7c4c:0:b0:4a4:31c5:fc8a with SMTP id
 d75a77b69052e-4a7fcb0588fmr8859571cf.47.1750961242624; Thu, 26 Jun 2025
 11:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250625112209.2469589-1-tduszynski@marvell.com>
In-Reply-To: <20250625112209.2469589-1-tduszynski@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 26 Jun 2025 23:36:56 +0530
X-Gm-Features: Ac12FXxkcYiyBnPHK2tg9XLIXvl1aJLd5FOl_tyyny9eN7FISOmvGnqwATi2Z-4
Message-ID: <CALBAE1OgF8cqSsp=gz=oYtMggUsCgG6xAGW0T=m7=-cienrdLw@mail.gmail.com>
Subject: Re: [PATCH] raw/cnxk_gpio: fix out of bound access
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: dev@dpdk.org, Jakub Palider <jpalider@marvell.com>
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

On Wed, Jun 25, 2025 at 4:52=E2=80=AFPM Tomasz Duszynski <tduszynski@marvel=
l.com> wrote:
>
> In rare circumstances such as when underlying gpio device is being
> removed while userspace access is still ongoing flags returned from
> ioctl() may be invalid.
>
> Coverity issue: 469060
> Coverity issue: 469061
> Coverity issue: 469067
> Coverity issue: 469068
> Fixes: 9a5ce79325da ("raw/cnxk_gpio: switch to character-based GPIO inter=
face")
>
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks
