Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925A5C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 12:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D2A4410DD;
	Thu, 12 Jun 2025 14:17:28 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4AE8C40FB5
 for <dev@dpdk.org>; Thu, 12 Jun 2025 14:17:27 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4772f48f516so20543041cf.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749730646; x=1750335446; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0XckUL/JYaOiIXGzK1qZQlsYacwliRYflODoxiit0I=;
 b=m1+ZAvYZlGczVKrAvJvwkpItxl0GnQ7Fi92EEqwqfTMeICl1UTfNLiEmEMxjxgH7ph
 pQ+CmfsFg/sElnbKiwTGQyTWwQKWZTnaRWOMvhrhOt1/dms4W16W6U7UKQAIlp9ZIjD/
 LlEWsDGJilMYE44OhcwkFMw5mS0tSD+8fSV19o7x820yabJR3ZeHbASMgV/llmL42GEl
 Vzj5dgbPrOACInCkxOB0vQXPw674P1UVWLw59yeVy4jH6UoR5XmuJu1SHCNGve1u87UK
 1VseYokp0vIzYjHZFZrrJVeyJk6X+O3xeJjvUZpKcK857VpULtaBwBuvQBl2aSR+T0y5
 NXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749730646; x=1750335446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0XckUL/JYaOiIXGzK1qZQlsYacwliRYflODoxiit0I=;
 b=oP9ZKobDCbkjUNGAFmGDF4wb1sfxOy0ATHSLjQmYWDA4Dz17ai98rlnCs+2AGnKkQT
 gNNDysV34irEDxZkF/vSco/K2FbhxJtY7IOjXLsR5GeqxfaVlqFI/n653brL6k7Sc4h/
 IDn52ZegYTN1Fv+c+uoPZ6LxS6sjnsPz/xN0QTX/doeD4wUsfpJVgS5ithL9nCCm/Qf+
 EyOwBiJboBkUzL+24rA2xULdt42oF9UVJ9RpUSDg7JWTNOKWS4RZBUXPbRYg6Lm3uVLN
 a2p4aFLdfDreaFpllXOn0eZZ0AsRERWvupteleveWW282+Pygd0aefpykLB1TDL230YM
 Q64g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr8VG/syKibFJy3hWygabqWMPuPVv77C7GJALvGxlHJP4pC71vuoM10OiKgYp7Y+xuFjs=@dpdk.org
X-Gm-Message-State: AOJu0YyvKm9Z2H5rxe3moUblM00kd9fatxL4wdGWPrIANPFna4wcxwho
 9B6c9AtaUfacn+Yi1UTtYaDTFqMqUCLLbfGtiPWLKWKfGCsqklt/qwtZsTIelC7p+tWmWP19N/b
 4/VNeQeGHId0YpNKYSZwrGjXaA6jB9zE=
X-Gm-Gg: ASbGncvI7fhzVvIuwq0WbL5noLEBdomXpmOjlF5vF/jFYYCmdaQgsEGJWkRg3w3rEhq
 KAc5ZwYEOuyBdp7BCV4wA0A7oC2KkJqqMAXfUoV4WHfRholIDFcWBTA428Gq9tD4ajMAT++uhs0
 O8V563NgPXvtZOsQu5PXX6NALO9/Tyhp7UVT+s4X3F9g==
X-Google-Smtp-Source: AGHT+IEni0dbWRGfg1G3qQAj+oq8CKJ4nEhRLRxgkisrAa/cXAJ9h9YR7a2KsYn30oDn00JmZmtyL6Z/fe30AOWGgeo=
X-Received: by 2002:a05:622a:1f06:b0:4a6:f59c:e83d with SMTP id
 d75a77b69052e-4a7234c004fmr53265641cf.18.1749730646507; Thu, 12 Jun 2025
 05:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250601204626.98998-1-pbhagavatula@marvell.com>
 <20250604124305.80579-1-pbhagavatula@marvell.com>
In-Reply-To: <20250604124305.80579-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 12 Jun 2025 17:47:00 +0530
X-Gm-Features: AX0GCFufuBmqYOJQQ-MvxlxlpVP-fhFyc9ur3PCCh7U4cjQ9DgEaIKArZQxOZB4
Message-ID: <CALBAE1NWJ-5eaMJksoPR8SXgAv=QKDr8oWifcnio5enozXxU-A@mail.gmail.com>
Subject: Re: [PATCH v3] event/cnxk: add event vector adapter support
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>, dev@dpdk.org
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

On Wed, Jun 4, 2025 at 6:13=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
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

CI failures. Please resend
 https://patches.dpdk.org/project/dpdk/patch/20250604124305.80579-1-pbhagav=
atula@marvell.com/
