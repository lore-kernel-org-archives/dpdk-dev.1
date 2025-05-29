Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F13C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 05:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAD884021F;
	Thu, 29 May 2025 07:54:19 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 66E224003C
 for <dev@dpdk.org>; Thu, 29 May 2025 07:54:18 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4769bbc21b0so5768691cf.2
 for <dev@dpdk.org>; Wed, 28 May 2025 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748498057; x=1749102857; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKWF22yDf/efVxzzkWSDpmrGfKo4hB4mkb2owg5meGc=;
 b=IjVK2dZcm880a4GNfAaEMfwWZA+UqrUG7vjOY5+2dC932GRIF172CK7fRd8IiApCxL
 VxeOAdCtGzCNpLvT3SiUVs0nd31DjLItMZ1ekr9zaeO/QE1FZ4haNXltKGt69oinsnDV
 CVIhJkCoBg/HaARJ1alhV+teTDfAEX8M3wq0X6klAfpA0a9zXVKoRrV0DIVNqlUvjJKA
 1sFQtLDBq9En59SdF9RWXKvKcN+b/QsFgBZ0JXN8H0V8JdKNAQ2yEYx8ZH9cKNP2KynX
 wEswbVv6Gm+HOVItFA1clglw/EiE8bh4dAhZ4gGUzQunYkWOqM587ho/3j5iu7pV9AXB
 s4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748498057; x=1749102857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKWF22yDf/efVxzzkWSDpmrGfKo4hB4mkb2owg5meGc=;
 b=o9TlRMGUO8jGqQbSBoXf9lqQxBzYGYbnPI4yf47ZEXVqY6rRYQew+lZa4UhQW/zoXi
 3T6ZuipB9heAT7WIREXUpC3PkXqDEytIaPtZ0b5vsczsTSclKD2/R0lPq8fG+BH5+puf
 rl85mi9OqKYw4klsl3LNKaWCuVm9kr188h1kvdZpt9wRmpNKG4ESIr0qR8ZfDhVL+RjX
 XexvKtOxdOezNE9daGp7fw4T/MIqaHAp3qeNhQib1mDOQu/A1rwedk8YamAuYJbZ0VWZ
 ov4FmxY7fBKce1pLpB1zJOLDK7dugJ3INDlMEUMSHvoUKR2v4rP5BinWeo1AW7jdmgnk
 oyYA==
X-Gm-Message-State: AOJu0YzAoU0rBwRd+ArS207JiyElNUKrZ+mjD850cSzehxW8lcWtoF2d
 c1YtmpgDmZFHXz0WvuYh6Jxq5NFuBghTxfiehCGpMboMlec1jkA3w0e6vy5iwnGq5itcLp6V8AS
 MKo/zcPjVOfrY2FLSbb81LB0w/D2An7I=
X-Gm-Gg: ASbGncvqYf4p1IymqQztHv+f9b/XVqUiPmpGDyfRYv8OGL9eHXxq2H+94tCxiEYyefF
 rd+Y/HAJ8kHRrenu9iVuUrmn8rVqE8mYrmCGtlzBmfBoCuDQbk4zaCVYLGMZeHC0GvdaBFDGD8g
 QoiNAife2iy1u2qx0RSYXtwK3KqK/OYtSJENDccUYgHg==
X-Google-Smtp-Source: AGHT+IHGrIo6CsiO5sizbNk+bZUfc9DxFDZD6x1TC+SaPbZTsbwoECBP6PqaY8M1pjKCxZNtXnZLtmSlbkTWzYoyIHA=
X-Received: by 2002:a05:622a:1f16:b0:4a4:30b1:366a with SMTP id
 d75a77b69052e-4a4372957d5mr14585571cf.38.1748498057488; Wed, 28 May 2025
 22:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <1743731269-5936-1-git-send-email-andremue@linux.microsoft.com>
 <1748438571-20477-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1748438571-20477-1-git-send-email-andremue@linux.microsoft.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 29 May 2025 11:23:51 +0530
X-Gm-Features: AX0GCFvMxrtpcADa1BpfRAfCBLICQQhpWgtN-mu_Fvd3HqO_6EIvrdNsFJVITOs
Message-ID: <CALBAE1N2ViBw0-3qc2Cga2owLFCZbYssT0khuVfKxfRCnwVRxw@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: remove __rte_used from functions for
 compatibility with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, hkalra@marvell.com, kirankumark@marvell.com, 
 ndabilpuram@marvell.com, skori@marvell.com, skoteshwar@marvell.com
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

On Thu, May 29, 2025 at 5:42=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> With gcc, the macro __rte_used translates to __attribute__((used)).
> MSVC has something to the same effect, but harder to use and with some
> limitations (one being that it cannot be used with "static"). Therefore,
> it makes sense to avoid __rte_used in some cases.
>
> The functions modified in this patch don't really need to use __rte_used.
> Instead, these functions can be involved in same ifdefs used in the
> callers. That way, they are only defined when needed (when
> someone is actually calling the function). Doing so makes the code
> compatible with MSVC and avoids compiler warnings about functions being
> defined but not used.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Updated the git commit as follows and applied to
dpdk-next-net-mrvl/for-main. Thanks


    net/cnxk: improve MSVC compatibility

    With gcc, the macro __rte_used translates to __attribute__((used)).
    MSVC has something to the same effect, but harder to use and with some
    limitations (one being that it cannot be used with "static"). Therefore=
,
    it makes sense to avoid __rte_used in some cases.

    The functions modified in this patch don't really need to use __rte_use=
d.
    Instead, these functions can be involved in same ifdefs used in the
    callers. That way, they are only defined when needed (when
    someone is actually calling the function). Doing so makes the code
    compatible with MSVC and avoids compiler warnings about functions being
    defined but not used.

    Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
    Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
