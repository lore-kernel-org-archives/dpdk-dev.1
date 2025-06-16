Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC76C71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 15:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31E08402DB;
	Mon, 16 Jun 2025 17:25:40 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id C4F2C402BC
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:25:38 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4a6f6d52af7so51271821cf.1
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750087538; x=1750692338; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzeHqFnxARM4IdAQU4pTPXHRzk5S3THNOwH5YHBjQAc=;
 b=J+7N1FItpu12bDbIl3ykNKjAiP3hoaazblqTZg1BWomwHFHG9gcZqY3o2FoY+cv+8S
 oTrUjsC+NAkR1XtUETkjNd7CnH4m0hgAj3yVlCii/53A1Ze+9o0zvZ+tio8E9sT9PqYR
 IWCAS7+LUl+iZIKoPqeu2aN/NMw9FvWY2lifsIq+/n/8h4FuiPbJdJOOkFECTCTpjbY5
 aLvuquWd5ksOTzBDf6Gafoq9pcsRQytwgt4VIlIyTmYk8Cok4QMm+pJ6L0xPu0t/t6aS
 SsfTUAonUghpbbyhb0DtAJ/hGEtiVo1b86dgZvT+BgugAUZWEQwrTbmKa8so0VRsrcbk
 rEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750087538; x=1750692338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzeHqFnxARM4IdAQU4pTPXHRzk5S3THNOwH5YHBjQAc=;
 b=szn49zHGSTYn010/E/UVpNJKplIZqOjtK0rXcb86EhWZTZOn86jYFVof5BBw8ZwzLX
 d+WeGSK8ZmSRkR2kxaDxkNyXH+rA6OoTuj9Ltrn97pHshDD0T2nT9KsJfc9Iwc0NlVB9
 IiRSJWF4zZsUZZgdGpdcRyDRzCe5aOGNy8NVQ7qZBkJ5RrPxhnWNEAoay4ocsKy6LTfS
 MkDI2q66KtVsLztENgwHW06fiZuOSQ37R+Iaj2RTRWVLx+BLzQmMVnVLcgI6jtBva7Kk
 cEDY0DX8QajNQzPUCgabsI2V/CtC3dnWLUcU71b+gR03dVgYeS1I+bC9WTQerTLW0Z6S
 YldA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc8eyAKI5eVKUi2s4zteKlhuae1hMPMXInCjklC+KjCyjogWDG+ylXv9V9yPLqhHJc4YQ=@dpdk.org
X-Gm-Message-State: AOJu0Yw8ZPafG6m/hm/dDXDAqdWv07JqEET9PFlZR0I6+PSdnBeNWE1L
 Cz6vVx8wX1llNrz4F+WRKKLrdMG+3EPggq9jADoEMOBKMbEBVUD2eTqSahohq1reXle0yrjbwBh
 qKp2T8Yp2vmcLcB0B1mof7aivqLKHBYE=
X-Gm-Gg: ASbGncsDfEMvPZbbvx4cPjJpDDBC5cJXHbKh0Rpjr6xsJvsY3a77wxN/1/rV0GoApjo
 WktVQ17wia+qlv2Ya0C0jl9PvXR5u6gP8yLFzuUmwTBGSinsyCbi6dGJx2IeWYnXxB/PvWLOBPQ
 H3MeSsdI5tJyxjGvfk/2G6KoTwdri+coiduDnMuhXKlQ==
X-Google-Smtp-Source: AGHT+IH9bXaMcd4jTOz7E1JAV00xD83bhQMXR1eR9UsJNs6Zd9ArBMXXR50ABns5UQSqE1UjEMLijqc0QxQmr7W1ayI=
X-Received: by 2002:a05:622a:253:b0:4a6:f6e7:7218 with SMTP id
 d75a77b69052e-4a73c61708emr135444471cf.45.1750087538008; Mon, 16 Jun 2025
 08:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250612170923.36114-1-pbhagavatula@marvell.com>
 <20250613231942.35167-1-pbhagavatula@marvell.com>
In-Reply-To: <20250613231942.35167-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 16 Jun 2025 20:55:11 +0530
X-Gm-Features: AX0GCFsXnR1pbmM9LfJyCv_C9LrmfxRtRA8Fwl6fALZ9kI9-J_JVh05GzWbnOrU
Message-ID: <CALBAE1OH=K_6KAmRwfnNLsHg7Dqe=XPPZYY3QEKYToeLGzeVJQ@mail.gmail.com>
Subject: Re: [PATCH v5] event/cnxk: add event vector adapter support
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Shijith Thotton <sthotton@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org
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

On Sat, Jun 14, 2025 at 4:49=E2=80=AFAM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Add event vector adapter support to CN20K event device.
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> ---
> v2 Changes:
>  - Add depends on series tag.
>  - Fix compilation.
> v3 Changes:
>  - Rebase.
>  - Fix errors from check-meson.py
> v4 Changes:
>  - Rebase.
> v5 Changes:
>  - Update documentation and release notes.


Applied to dpdk-next-eventdev/for-main. Thanks
