Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9488CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 08:01:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE08D402BC;
	Wed,  3 Sep 2025 10:01:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D3E3440261
 for <dev@dpdk.org>; Wed,  3 Sep 2025 10:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756886482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KjDkwOTBtWYWR0MasUXosI9B+yykhbNVME66dfL8e80=;
 b=hDD7IzhRBUhWxU8diMcpwpLXTzXaEtFqY7h7PUA5f9jr7FB6yAbtADBh3ikGD/J/3kBYRT
 m61qUbBqsJwzldMKagVnRE4Euk6qngsoCY4wzR8Ho1ncF7fbal/2UK+FldpiOQsTodYQBJ
 0v+csAUP0pHCYjjEn87GTqdtogQIceQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-6ho-L435P6O8ec11QMMkNg-1; Wed, 03 Sep 2025 04:01:21 -0400
X-MC-Unique: 6ho-L435P6O8ec11QMMkNg-1
X-Mimecast-MFC-AGG-ID: 6ho-L435P6O8ec11QMMkNg_1756886480
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55f75b4b1d4so409321e87.0
 for <dev@dpdk.org>; Wed, 03 Sep 2025 01:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886480; x=1757491280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KjDkwOTBtWYWR0MasUXosI9B+yykhbNVME66dfL8e80=;
 b=P3qAzGqRUFgjTE1RnWxB8C7028yR7jkVhj4h8Y9xpfHux4sFcyEwU4YbNhkHX9eVhs
 cq+0XoNg+33uQmMk0FeVP/h1vbctVP8pWuqiy3BVFiLpp0vI7dAWH1n5RD0y8ZhAzhGR
 fQ69HBsX0Jj9l3Qo2Ou15QDCtkCEjm10HISVqe2wNrUKNWxQQgiuHNbHYWb1Pi2NKvei
 WsfEnJ8R3krqpDz8yNyp+JAffFj/zQ3BaU8O8Uur5J8loAXETD+kQBEp538eZgU/u2VX
 s/rvzOB0doYsf+RYE/rw53Xw9ZwNDsqaeNk8mcUVAAhZsEOiIsRovtwRe3jV5I9IwC4X
 5kLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPxVQYyPmaLzpFntjuUdF8EjMf2oswduA2tpyLRH9DUB3A9EXENM+dg8jQS5yWGqNiy7c=@dpdk.org
X-Gm-Message-State: AOJu0YxZEurmCLtSY2lc39zZ7LWqgEQA1M8SNNIHMvzcYukIRGUIR6lk
 v6CV1oXJRenGs5FypnLpmAXxqz2r0S9+89+srXF8KKlcsTj+6GRbdnlwHrNTAEwpQXYuiotwkZp
 G8pkOPFwL0hFAZnLYLZhb5kLEzeyADwOLVguEbvjwFtS2gt/NtDFH3w7M3FaGtq5O91pf8uCdj4
 Duny3Fb9d63D/DOZ+8X3Q=
X-Gm-Gg: ASbGncufMhX7Wp2IMperh9dxsWafmZFy15M6VWGJwwm7y2MCZE4Tv6xzrpw34ik9IC4
 eO5uuWLH7/zP7VnV6rW5dFfiLwXtYzPxpq0VZpB2ON3bjO2jymzoszOa9k85KD8Wm7rxkijy5D6
 cSm3Dulx2uhgkStylOkqe1Q74=
X-Received: by 2002:a05:6512:1514:20b0:560:88b3:b63 with SMTP id
 2adb3069b0e04-56088b30cb1mr726242e87.2.1756886478312; 
 Wed, 03 Sep 2025 01:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Mmg/tk/53JchvllA3MrIXeBiNty9+6qvbLIOLKhj0aUXP9Powtuh5yof2Xlb2QJgZsP+mcn4d6AyuFb2bT8=
X-Received: by 2002:a05:6512:1514:20b0:560:88b3:b63 with SMTP id
 2adb3069b0e04-56088b30cb1mr726227e87.2.1756886477732; Wed, 03 Sep 2025
 01:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <1754423992-24652-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1754423992-24652-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Sep 2025 10:01:06 +0200
X-Gm-Features: Ac12FXzSn5q1bhc7TsiFsJqnO6nDUlh6KuneOdFr6SdVCR330QIUhAHOeL_hNjM
Message-ID: <CAJFAV8zwgC=KbS5BaAiFcckzuuCNGQDMQK3Bz+V849rkMuPEOQ@mail.gmail.com>
Subject: Re: [PATCH] test-flow-perf: Enable to build on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Wisam Jaddo <wisamm@nvidia.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IRnjA8vbfcuzVXIo2ntlYtIpc_tppsQVZRtP_tWNKp4_1756886480
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 5 Aug 2025 at 22:00, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This patch fixes some issues which were preventing this test to be
> built on Windows:
>
> - Remove VLAs (not supported by msvc).
> - Replace strsep() (which is not natively available on Windows)
>   with strtok_r().
> - Remove the "thousands" separator from printf() calls as it is
>   not available on Windows.
> - Include the test in the Windows build.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied, thanks.


-- 
David Marchand

