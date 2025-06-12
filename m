Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA81FC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 13:39:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1ECF41104;
	Thu, 12 Jun 2025 15:39:30 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id F1A7440ED4
 for <dev@dpdk.org>; Thu, 12 Jun 2025 15:39:28 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-48d71b77cc0so11858321cf.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749735568; x=1750340368; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxMCwrs3GMPGxW8f5uW94+kQNcqZ5tyXLkwFnH5gN6M=;
 b=IO1vmolp0ldK/eE1uGSXqoMi+sHNTAhizGo7XQwY3ecVfoI9CxPLjtu46iZolTSDQE
 C0vqaspUX+opxAtdeJgAnRRZcuQ8olXnnTZNj5UeL7pLtcJGQrYMuNSDqNLDYF1xpjTi
 GNPEkoRWZuRyd+AXitCFfEQW2aIsN736ZBFNkWz/eyKy2HKoiJHew4SirZyiWswF/Bl/
 HsiEQX2/H+zp3wR8PBMwLU1MpsEj809mxOzyVnLiCSTX/bVcgQsAh3kSLRWr9cXYNFBd
 Y20naGLEE7VFJADor/jOL2JQaAYHejvsTkK/Mfe+bAAdgUeC7MXireAG50MwJkanhYdI
 dUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749735568; x=1750340368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxMCwrs3GMPGxW8f5uW94+kQNcqZ5tyXLkwFnH5gN6M=;
 b=D/rI0M9S8kzmfxVJwL3izpA65VjeQJ6CsadMWQciq4IXHfJCQDiiqsLs12qIR/BsvZ
 aQ5wcmN+vmvP7alM2esvlDJhby1wpLjQSk/OKfalcVH6+RIFWmw/0mJuhfCFtg0t7qDp
 rf8mTeKm6rTY1vjrZkfHwZ7QJFhUkbWS+v/qrKC+P5wpRa7GDWG4WvN1YTesigRPBbTk
 ey/d2CSw3Mtd3oVpbwpx9tqDF0Sf0cPg90wp134CktSIgrTEB/X+vntJiTEWwULY2efk
 gK4ayZlR0QZSHeGlDwhi52oIhSRUohNaGu7q6HbUvEUmbsmvYJfHqyOBn3O5uVFSl2Ts
 2I7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt2HaSE5LTbNeAXdIdiMjVea+MyI6mF/02iAxYbnGh7tFFazPNc4+HGPlQWL0bWVHa2QE=@dpdk.org
X-Gm-Message-State: AOJu0YzsxxRH7WISClOW1h0wLH692G/hZ2IUZYrrlU9WIgxQmatUyybr
 SI6RQIVwWn+UHo1qrmCHHCar8DQhZDFr5mwntpdLIJSseWjJNYgy9IW/Q++lkPmHuQIwMzBjpPA
 noXrveSNjv6NKVjyBC7nQ9DKqWLwLtm8=
X-Gm-Gg: ASbGnctzHA+zJCKIhZxkgvakclIJ2oI3Vg0iNZHZwMSmrjsMK3uvdsYfKT/ZSOunWaf
 vJq1oGklW3N+V7fifwL/d8WBxvNg9eUOhCXI3yBZHTGtx5wyJtpDBZA1uk3J/AHDOpPAMItD9gF
 9TxVpWdu3hwqeZOllPC02YTAAmX18TicN0NC5fxlOuMA==
X-Google-Smtp-Source: AGHT+IEm3H04esMrN+H8PTzY4qqjiMXfteBLpoRiZNEqm9fFxFHG06jkD2FrhnzmAZOMTbyEgYkCYOI2WOY1qw4r0e8=
X-Received: by 2002:a05:622a:5c8e:b0:490:8ffd:9a90 with SMTP id
 d75a77b69052e-4a724386d2dmr44622741cf.45.1749735568166; Thu, 12 Jun 2025
 06:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250327111344.2205-1-pbhagavatula@marvell.com>
In-Reply-To: <20250327111344.2205-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 12 Jun 2025 19:09:02 +0530
X-Gm-Features: AX0GCFtUR5XkZJNqHUxYbrOgHvFqXl_bdqC_N2Hvi2yCOwCDADqLstlKMaRvsrE
Message-ID: <CALBAE1PSsm4o-a8_7tJfT=Shiq7xMLvakLgGH0kBRuhiH9e=gg@mail.gmail.com>
Subject: Re: [PATCH] devtools: exclude atomic checks for common cnxk
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
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

On Thu, Mar 27, 2025 at 4:50=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Since driver/common/cnxk has common code that is
> used across multiple platforms, allow use of
> GCC builtin atomic functions.
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>

> ---
>  Rest of drivers i.e., drivers/*/cnxk have been migrated to use stdatomic=
s in:
>  https://patchwork.dpdk.org/project/dpdk/patch/20250327111120.1641-1-pbha=
gavatula@marvell.com/
>
>  devtools/checkpatches.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index c9088bb403..2470d4fa83 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -139,6 +139,7 @@ check_forbidden_additions() { # <patch>
>
>         # refrain from using compiler __atomic_xxx builtins
>         awk -v FOLDERS=3D"lib drivers app examples" \
> +               -v SKIP_FILES=3D'drivers/common/cnxk/' \
>                 -v EXPRESSIONS=3D"__atomic_.*\\\( __ATOMIC_(RELAXED|CONSU=
ME|ACQUIRE|RELEASE|ACQ_REL|SEQ_CST)" \
>                 -v RET_ON_FAIL=3D1 \
>                 -v MESSAGE=3D'Using __atomic_xxx/__ATOMIC_XXX built-ins, =
prefer rte_atomic_xxx/rte_memory_order_xxx' \
> --
> 2.43.0
>
