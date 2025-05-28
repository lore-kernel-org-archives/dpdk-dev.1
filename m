Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA5C5AE59
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 06:27:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F4AF402A8;
	Wed, 28 May 2025 08:27:45 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5BA8140279
 for <dev@dpdk.org>; Wed, 28 May 2025 08:27:44 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4769f3e19a9so23489601cf.0
 for <dev@dpdk.org>; Tue, 27 May 2025 23:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748413664; x=1749018464; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLyFVJz6XcYE5LZdLFMebdzBUn+50GYJUIzWmklolNE=;
 b=maRNZG4mN38Pic+1M+745lFmxnWk7Kb7ZzsZEmbiZhPK7RiwTwtO8rnlvb3JcIXKbV
 yohvIvarejye6meo6W9S8AXhegC7zRqSqaaC3i/R8fvgP7Ul8Z1CWoDBIDUyh7Xzy6X+
 z7jJAlhH3emdIYyckPa2nnIqbbulZndiPYYs9Pwm7vWbRxEy/W9dq9wBEuOcbVIb0O6s
 aRLy2vDhq0y+Sjc98vheGkhvN542S+Gi8sudN5aT70jpH/o9qHFRhHZzoKilu5ILY/Dp
 3fnPLYT2rTB8TRBLs/+3Dp9f0jfZun4+pEh7jNCZRYtM5kieSTjDDIoScaCL4s0FmS4m
 BFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748413664; x=1749018464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLyFVJz6XcYE5LZdLFMebdzBUn+50GYJUIzWmklolNE=;
 b=R8nO+psN1/77DoBrz6V2RepYTxZuOjkvw/Cnw5awT6kbDiLBUzMtUHAjRmZqt1de76
 K6OQZYuNXoOs1T9fYevwZ84iNPvG9nGuWjxt9DCNBvAZjfxGx1TcJ6oytGskhciJJj9w
 GyxMoVnprcLBkj9/aTASnLaq+54ZSzCCYWGUVxgaHqPkNljN05+mfVx3F3JsfFSsTv8l
 GsDNd/eCuTIOQs7tt96qP4BGv78YNfBYLLrrTQtFGksfWlyFVw2EL3zdp12gJ+hQmIho
 xfmV4ehmOlKtQXbovRxJZTohvRAjBeIiAzJtusPlALm1oOnB0owXdc52yhASjYVcurzU
 DJ+g==
X-Gm-Message-State: AOJu0YwsbJCpByO/w4nA3jD/HtksFUihfOMCCT/UzC7RRIkJ5FyQnAn/
 L8JTk50TbZTBTMBWmPd0H/C/QR7is4TE+h53dFQJc94ErcR41w//2uVFI9QGoyUnZY0ApAUpuyX
 gXNUYUSj6TbpbpmM+MWwegrvM6rivCow=
X-Gm-Gg: ASbGncuBUnZ9kqxaV9JcGStOENHXPJUBx3cY1dLdU3QsXAKnB0d6nu48aG2ezDb8FRD
 /BIBUvBILOxVYvLoa9cadkTUtNz1DuG9FMKpefqGG6BIz4NX+ae61TxcX0h4HteyWwoaDYC/RKu
 c0Mq/jIQGsGfIxaiU/cVDswzPUSvmdkRc=
X-Google-Smtp-Source: AGHT+IGb7ADiKswFdiVXn9Be4KY5YMAdBR/7sfeFGodnHVw3HLzPZ0Mfu4Px1STwzH/3EFiqZHVTr5FUreVaqa72wYk=
X-Received: by 2002:a05:622a:6992:b0:494:b3eb:a4cc with SMTP id
 d75a77b69052e-49f480c8fb9mr202399991cf.47.1748413663717; Tue, 27 May 2025
 23:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <1743731269-5936-1-git-send-email-andremue@linux.microsoft.com>
 <1748375344-10254-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1748375344-10254-1-git-send-email-andremue@linux.microsoft.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 28 May 2025 11:57:17 +0530
X-Gm-Features: AX0GCFtTRmCizSA_eZywuXp10D7IAjcyy5sAX-LotpJphpbwh6Ry1rGy_OCvaiM
Message-ID: <CALBAE1NG1tN6vE4TaOEOknZA=Q5Lb3p0GaOOK4LjeXpCVw+RdQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: remove __rte_used from functions for
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

On Wed, May 28, 2025 at 1:27=E2=80=AFAM Andre Muezerie
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
> ---

>
> -static __rte_used inline void
> +#if defined(RTE_ARCH_ARM64)
> +#if !defined(CNXK_DIS_TMPLT_FUNC)

Please change to #if defined(RTE_ARCH_ARM64) &&
!defined(CNXK_DIS_TMPLT_FUNC) in all instances.
