Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965FEC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:04:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DF2A427E4;
	Wed,  4 Jun 2025 13:04:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9E014427E4
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749035084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4+3J5z7Zou3JLO0YtAK4nKlbhdYP3LlEYxUrSTFtZI=;
 b=fMEouIfQqCPhNRkAmoeT9ajKeqJZU/FKyFXU6QDSHaZHo2zdwtOKSiLzsENqJ4eiMHJTtb
 ArAmPw7CTWEyj/5QQe4jRsPKRPBfW6RsVn/nPfj4WwiSr68L+34OYuuV+8xMiskLdoFFFg
 oQbbSlJn+KyPdNR+eySJvSWsCfXx+Sk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-pMKdvRMTODSzDZraoAmYmA-1; Wed, 04 Jun 2025 07:04:42 -0400
X-MC-Unique: pMKdvRMTODSzDZraoAmYmA-1
X-Mimecast-MFC-AGG-ID: pMKdvRMTODSzDZraoAmYmA_1749035081
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55334debc43so3139581e87.2
 for <dev@dpdk.org>; Wed, 04 Jun 2025 04:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749035081; x=1749639881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4+3J5z7Zou3JLO0YtAK4nKlbhdYP3LlEYxUrSTFtZI=;
 b=KkRPYR2bTGJWnFjBu/yXTIL0blfxx+HQvN5nSnvBmCxp+WwUlbyzR84ZMrU8GOVVut
 fyG5qnQOV0ynALqPgBKRXS1enJtEjJOuN5wmpAFlBQDuOKmZh8Y88dCljlf19IOe0W/X
 l7ic8sDJP7WsNRHK+n5s80MrkhQ6X5g1iekB6FzBWy91/Dg7HHGYxlzfjdR84X9ao0cN
 3AUSFnrOSLUraYA5QFJ29ILwDSJOom/xfuT4AySC57O5md8C/7VZYK5Z0aHN/e5mEtN3
 gx7ryJf5k1srDo2Ujre9ROVHWCQJ7BB0rJNbOaMi8xNhBWq5W4vMdAFknbL3rqkKMata
 gWWg==
X-Gm-Message-State: AOJu0YxWWTHaJh4WtQ7hHDm65njY07cX834pzgcGWw52GN160jC8yCwL
 8x7OQri3+5nBZJZbMHNyD3hInUye+m11sUJobEJo2IoHmwkuYQNxcIbxBTj7y8Oxzu1KEWkdgiV
 UylPgp8u9dI5HMP+7vIjjnGuI81q9bLA1aMkXNHSZr6yc9suglkOM320//GtZgDpKtblJJaZMlW
 F9H0NHlyRlBEHTfRQpQwE=
X-Gm-Gg: ASbGncuvRCb8i/qUgXVAXBL4u72Jzbzvq/gDl3ns9IZgGHWfE+ny2YsQLgi8uNb3lRD
 u7utyyM7blynjTzz8ou0uLjDUrhiSy4H6uNRR++TLb3A51qQ9RKEfchA8Yl1Iwkay1ZO7/SA=
X-Received: by 2002:a05:6512:4025:b0:553:515a:5ef8 with SMTP id
 2adb3069b0e04-55356aeab20mr715417e87.15.1749035081202; 
 Wed, 04 Jun 2025 04:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWJHNaRnddAMA/2aXH7cXK6GMBH6zjBG6OgIKrHoGtH9xO4yLqDSBxZtdbLQQHSQGZlvE0OUWqZjugmd7Q/cY=
X-Received: by 2002:a05:6512:4025:b0:553:515a:5ef8 with SMTP id
 2adb3069b0e04-55356aeab20mr715407e87.15.1749035080776; Wed, 04 Jun 2025
 04:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-3-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1744839898-15745-3-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 13:04:29 +0200
X-Gm-Features: AX0GCFv8tB_tkTx1dZj2UYuPkXF1NxoreG7gimc7rqTchDjaS7KxY6-uCwRdWXE
Message-ID: <CAJFAV8zTWGCt41_oqpHktfNJ1s6n9iFbJjwCJPPoKuWJamg0QQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] buildtools: use macro to embed information in
 binaries
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q-cRbZQLPjrmBpFdP4Eq9LEIaWtF-Dxb_5xLN4aO0pc_1749035081
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

Hello Andre,

On Wed, Apr 16, 2025 at 11:45=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> The archiver tool from the MSVC toolset is lib.exe. It has different
> parameters then it's GNU counterpart "ar".
>
> buildtools\meson.build was updated to use lib.exe when MSVC compiler is
> used. This is to allow the code to be built without requiring GNU "ar"
> to be installed in that scenario.
>
> Script gen-pmdinfo-cfile.py was updated to use the correct parameters
> when using lib.exe.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  buildtools/gen-pmdinfo-cfile.py | 24 +++++++++++++++++++-----
>  buildtools/meson.build          |  4 +++-
>  buildtools/pmdinfogen.py        | 11 ++++++-----
>  3 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfi=
le.py
> index 5fbd51658a..3a078ab6d1 100644
> --- a/buildtools/gen-pmdinfo-cfile.py
> +++ b/buildtools/gen-pmdinfo-cfile.py
> @@ -7,15 +7,29 @@
>  import sys
>  import tempfile
>
> -_, tmp_root, ar, archive, output, *pmdinfogen =3D sys.argv
> +_, tmp_root, archiver, archive, output, *pmdinfogen =3D sys.argv
>  with tempfile.TemporaryDirectory(dir=3Dtmp_root) as temp:
>      paths =3D []
> -    for name in subprocess.run([ar, "t", archive], stdout=3Dsubprocess.P=
IPE,
> -                               check=3DTrue).stdout.decode().splitlines(=
):
> +    if archiver =3D=3D "lib":
> +        archiver_options =3D ["/LIST", "/NOLOGO"]
> +    else:
> +        archiver_options =3D ["t"]
> +    for name in (
> +        subprocess.run(
> +            [archiver] + archiver_options + [archive],
> +            stdout=3Dsubprocess.PIPE,
> +            check=3DTrue,
> +        )
> +        .stdout.decode()
> +        .splitlines()
> +    ):
>          if os.path.exists(name):
>              paths.append(name)

Indent after the change seems strange.

And we need a rebase of this series in any case.
Please send a new revision.



--=20
David Marchand

