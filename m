Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD67C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 09:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BFDF400EF;
	Fri, 16 May 2025 11:34:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 75C0840041
 for <dev@dpdk.org>; Fri, 16 May 2025 11:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747388069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugEAJlX3ic8xhBhjXmDt7V6L1OBdKF5cdcjWyWMAyQ8=;
 b=KTqXJzxt7ON0UPl9+ZPRcU3mTGugKiN7CGZY4d+5AXhFQku1Nuz8M+3WpX7ET/jJpUnLtH
 BpgBmILu6yvXJ0hZa+HuijyHV48Jd6St9cjxTqjix9nw+Xbq8Swcs0ftf/IKvoT7QNcD/4
 p3UJNBxgsDHzHN4T+CMhXBQWGcxILCI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-RR59LfX8PliFX7cib_LUkA-1; Fri, 16 May 2025 05:34:26 -0400
X-MC-Unique: RR59LfX8PliFX7cib_LUkA-1
X-Mimecast-MFC-AGG-ID: RR59LfX8PliFX7cib_LUkA_1747388065
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-328054cfbc1so6015391fa.3
 for <dev@dpdk.org>; Fri, 16 May 2025 02:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747388065; x=1747992865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugEAJlX3ic8xhBhjXmDt7V6L1OBdKF5cdcjWyWMAyQ8=;
 b=d7z2Q9LNqqh+yabFMVbFxJlaujTlFuxca00T48u97gLVSnQGsQqP02hPyj7DGLcHOk
 fdcCYt174rMbFBArhc0HkEnVl3wP3yKz6MJY9rkP9c+vVlIPVdQDe3ODlqGKdh7vrpIz
 ak+k7lPWfn6hkZvjhBZtuc4I0riRJJ1dFwbxVwjbAD59td3CXsjV9Kl97EZHHe+F1hGg
 7+HhVmlxTjjjR/1qLISz1MzYSFZp3irC9O2WfEvDxAz/63wmdRVKUf0R8aQwCR7yufEa
 E/CuvUO2EVr5qmCJfvHIU+3JzQkuK9eJy6bKgZwCEmn0ZPrmV1VEZ09EsaCEo3G19VKP
 ztIQ==
X-Gm-Message-State: AOJu0YyP5D7ooph5T/opMRfJP9XqAr53M57rnvROrdcXXdlBmAEheKRj
 b4FxwDG6k8gDqq1RkUKAS+knmuuKSQntHC9q8Ny5zQ3HvbsGP8nyhV+5ZGeE+TbT8kwF9xJhd7v
 Zs4j3vZE/CgKDDNOj7E/VlbCghSEfHMXp5u7/DrFvNd1AD04VJBUobu6KRDF9M/0rNxMS9W24th
 cNaE9MIwLI+9uPCoWqVvw=
X-Gm-Gg: ASbGncufL2wHl8hIglNPXUr2K9d7gFpfCRXJGfitEkGhcEq08quAMSaEG7cp7yZb0U0
 9SrXNF+II2ExAYLX5cGB/ICBurpl/6iaj0HCF/kt8ZUZiS3Nbbklsu6o8uFRAHG1iUaXCY5U=
X-Received: by 2002:a05:651c:1501:b0:30b:a4f6:bb35 with SMTP id
 38308e7fff4ca-3280971693fmr7107421fa.22.1747388065111; 
 Fri, 16 May 2025 02:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESS1ONj7T68aE0btDbcwmZaLCPEfvvwSHFJtWNCnX+Cb8wDICXAzJvlkGClsJAZd3Y5x/WCIfC/iz1VpLhymg=
X-Received: by 2002:a05:651c:1501:b0:30b:a4f6:bb35 with SMTP id
 38308e7fff4ca-3280971693fmr7107341fa.22.1747388064707; Fri, 16 May 2025
 02:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-2-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1746627671-28659-2-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 11:34:10 +0200
X-Gm-Features: AX0GCFuLaSEOBqaQMvlAhu3WJb3lHFx5DoG1cke6pSgwvDpg5cO6QXEWSQpT2C4
Message-ID: <CAJFAV8zvB0Bn+r4JiNq5RzgDXZgQr_XRaT66TqR4rWoAwoGvZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 58woilvQrFBRu6RRXbXHedwPasj6K-LPt6hVsN8Mzqw_1747388065
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

On Wed, May 7, 2025 at 4:21=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> When compiling drivers on Windows, instances have been seen where a
> temporary directory fails to get cleaned up due to
> ERROR_SHARING_VIOLATION (32).
>
> This issue was not seen on operating systems other than Windows.
>
> This patch eliminates the use of tempfile.TemporaryDirectory, which
> was triggering the issue.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

How does this change interact (except a merge conflict) with the other
series that adds pmdinfo for MSVC?
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35065&state=3D%2A&ar=
chive=3Dboth


--=20
David Marchand

