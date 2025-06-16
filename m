Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2286C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 15:06:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB000402BC;
	Mon, 16 Jun 2025 17:06:10 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 79CD74021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:06:09 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4a5840ec53dso50182871cf.0
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750086369; x=1750691169; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glOpouWkQ+aenEH4GDP2v6T69z0sf7c3C6jcTGpkCYI=;
 b=OhycOfic2jRgqtZ0YfuhZRLL4im6CpRJGA2QByRYb8g73HnokKKsyLl6MviQajpzrc
 PdHOm2/UtvaM5/cjvwlK0wb8nJ3C04KPtzu/PCg42Lidv+aMhefD15HdenYerdRXhytJ
 9zGSC3/64O0bgYN9YTmJ7jniYwTrPjOckHgdkhaLil3kqx50f6FmMwk/yQIQsvapiUVp
 qQXVn5ZuNJTavPKUSsMrZpkc3QAxNS2HAYAWA8MnexKCg15LZuWi/bxibNUBy/8FYDrS
 acdJb8NyTYJYE8zaI+XO6KL+DJhd/+5kDo4fGh/B6SQR0DD98DOPOg2G7nzhzf1M92Xb
 U62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750086369; x=1750691169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glOpouWkQ+aenEH4GDP2v6T69z0sf7c3C6jcTGpkCYI=;
 b=M6KuaIWGsVYVSXF6eK8DZWVsn4d9lAmw7xra+JsB5lps3M6exIhj1xEG+jMg/aSkyD
 jeQTZhv/t2u+BHCwQUZ0LSKMAcDN0QzB6Ct8NoXC3b2S4ZuDbwUNw0kZWrHAyGHSvfVx
 qIb0H0dj0G8hbdRIpe4cIN7QKHh5Djk1bVdOHBCk5+47ZK7ZgXa4h4ZW2nAJ3N5Ks2iA
 6Cgz3HPfLh/mf0+KROAzRZRXNQ8nHgD5CDQBbnxZ/20ERgxUNq63t+JyTKeCXSsQTfrP
 YYagu9nn4TSAKtSDru801COPGrfBNLbt8Sfs+1tpj7tQJ3Ml+Vhw6GoIfnq6lOPi/Wsy
 cPhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbbtip2f56PmxwfgbG4qAr3VYBYdJui+f8TJ+z+33+SXDMnkF2TuqCH075QTbt2YEVrYw=@dpdk.org
X-Gm-Message-State: AOJu0YwJtXM1ICpcgL7Dfx90AD23GwjqevySp1TZe/F/TGbjrZq8gtag
 Ibq6z9k5t/1ZfV56L+MW/wcD2ePRAm1CJknRk41Ptj8tPL6mZbGJFQA0vHr4hfn5plVGAYfLGDJ
 FNQ8OxZm8MXgPjxuMAtstBSKQQggKF5s4oSLv
X-Gm-Gg: ASbGnctcOv3wGxn9bvS+hpAKJE3NTPPu24hCz+Xf0kgW1kG5vVPY7+xEupvGkb0TRub
 UNXS3/CJ+ocDuRL8hP2LKSuWNynTafipg/CVaMKRj9qbSSls3/XD+/GeLX3luJlE/X8NBVLYGOZ
 n1UcGPj/yME5HAgo8IDxl/f7IZNGPb65m0Zmor6FiL3Q==
X-Google-Smtp-Source: AGHT+IHqAphdxmCOKKkDN/EXIXhjhsbSFOK4IR9XDtSGll0uEmalp+YxyhDt/B9MRfdpanXhFC4GLd9Qq+IV1+AFUog=
X-Received: by 2002:a05:622a:1890:b0:4a6:fa8e:50a8 with SMTP id
 d75a77b69052e-4a73c4fcea9mr164214571cf.2.1750086368614; Mon, 16 Jun 2025
 08:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250613231519.32933-1-pbhagavatula@marvell.com>
In-Reply-To: <20250613231519.32933-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 16 Jun 2025 20:35:42 +0530
X-Gm-Features: AX0GCFuW09B0uTM2qf-8QMTCQ1hMePvUfPDSOq1SQCGqM1pnWqh5RgjjcS6ytiU
Message-ID: <CALBAE1O3gUvoxBcQRjYWqc-d28h_QpGNr8UVsnRhV-pzakr0XQ@mail.gmail.com>
Subject: Re: [PATCH] doc: fix missing feature matrix for event device
To: pbhagavatula@marvell.com, Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>
Cc: jerinj@marvell.com, Amit Prakash Shukla <amitprakashs@marvell.com>,
 dev@dpdk.org
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

On Mon, Jun 16, 2025 at 2:02=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Fix missing feature matrix addition for event device DMA and
> vector adapters.
>
> Fixes: 66a30a29387a ("eventdev/dma: introduce DMA adapter")
> Fixes: e12c3754da7a ("eventdev/vector: introduce event vector adapter")
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>
Tested-by: Jerin Jacob <jerinj@marvell.com>
