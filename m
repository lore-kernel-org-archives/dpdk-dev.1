Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B59C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CE6A410E4;
	Thu,  6 Feb 2025 21:44:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 771E440EE2
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:44:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738874661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a48TGOlhSfOF39qbJXHUsyW4RAHk8/YHXS47cLsC998=;
 b=NOu+G3eZh/rY+bZKurUZ0oo8ycJaeJcKDATe+dQCa3n1XUMm6qhbaS3grkg3zOtIMjM7IJ
 UWziDXRvoaJOclxz4P/ZrRKgtFOZLxPLyAwqVQw7ytlPpyRQWnB56qbzszKBQoNHL4NjmE
 ZD0VhN2/FCeF2vgWSo113Kb8o61M4lg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-zKdMUj_UP0efsYW33gJMCA-1; Thu, 06 Feb 2025 15:44:18 -0500
X-MC-Unique: zKdMUj_UP0efsYW33gJMCA-1
X-Mimecast-MFC-AGG-ID: zKdMUj_UP0efsYW33gJMCA
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-53e3c516973so755214e87.0
 for <dev@dpdk.org>; Thu, 06 Feb 2025 12:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738874657; x=1739479457;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a48TGOlhSfOF39qbJXHUsyW4RAHk8/YHXS47cLsC998=;
 b=OElVn5v/tR09vQzsiSGilKVaeLtpg5DwlFJsZHuGib9s647cnRGHLEMvlOdLlrvp23
 izEFYoojDOPzSlgRO2A3RmDZIzU29elRNbeGxyp8ywa6wii8V3Ws4A99+5xxl8QIZ1ni
 QpmYRRgllq2vf+TKxnS6eaA52j8RrGXDdofK4Xhv6+qZHQzy63NeGGNzgcmAf6fMUvgj
 eb49FCfO5Mi5WFfGl55Xw2ll0/oQAdZmXtE+APsFnKEwGst20twhJVylmpcRo9bf8w5P
 p1FXaQzNLXnzoiG4mzZcOBD6oCKUYKyM/PrqLyvvpUSdDEqH0TcjRg/407iymxLwz+VA
 8vzA==
X-Gm-Message-State: AOJu0YzcCHG6nrLcYlxv0vZ5T3jBwZsEiXIFTVQ0Q4FeGuJv0pliCWrV
 OOHwMmaTpo9v0vigRqSE/lna94n2r9j0pgfSuj3toC8wL0jOAdbMy1uth2vogkfw/jFH0OWw6Y3
 Mk5oKqHTiEOgGv6vPlgMutCBrL3Vu/BtvqKyDcdqOdUKu0BXnkdfNz7XeASMDPvh207oTNV43vk
 XQPyfn6Nkcx4tmVws=
X-Gm-Gg: ASbGnct4sNRiY86ChD7NFD+1whCNCpiarI1e6Wqlg8WtIPzfJ2DKGTZVnFqTMGHziig
 RFNMkiHqGUPROFs8VnpqTrBKC15Epkgz2K1WU1THhpk4qvxOc/3yjGb+Tr+gBTRuR
X-Received: by 2002:a05:6512:108c:b0:542:238d:d714 with SMTP id
 2adb3069b0e04-54414ae0abbmr135856e87.32.1738874656797; 
 Thu, 06 Feb 2025 12:44:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5T1CoMVlZUJ/FTopfpLszoCriF2vM0DwDRRadjg2TWvfQoelz2IINsycQPWTrqXs1/SYwj3ztOhPV26fO3BQ=
X-Received: by 2002:a05:6512:108c:b0:542:238d:d714 with SMTP id
 2adb3069b0e04-54414ae0abbmr135840e87.32.1738874656429; Thu, 06 Feb 2025
 12:44:16 -0800 (PST)
MIME-Version: 1.0
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Feb 2025 21:44:05 +0100
X-Gm-Features: AWEUYZnIIAnTZUIguzGTccVEVLGx3Is0tHnOl-tbz0moKOwsfYUxyKyijDuUNCs
Message-ID: <CAJFAV8zzqa50xJLTk2gb2eZR2fSXNaLX7rHkEx_jdJkERk7Asw@mail.gmail.com>
Subject: Re: [PATCH v22 00/27] remove use of VLAs for Windows
To: Andre Muezerie <andremue@linux.microsoft.com>,
 konstantin.ananyev@huawei.com
Cc: dev@dpdk.org, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NxjBHnNsvoFB9LM5mlnwhUuOuJytu6QQo6Jxt3jTJ_Y_1738874657
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

On Thu, Feb 6, 2025 at 2:33=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> As per guidance technical board meeting 2024/04/17. This series
> removes the use of VLAs from code built for Windows for all 3
> toolchains. If there are additional opportunities to convert VLAs
> to regular C arrays please provide the details for incorporation
> into the series.
>
> MSVC does not support VLAs, replace VLAs with standard C arrays
> or alloca(). alloca() is available for all toolchain/platform
> combinations officially supported by DPDK.

- I have one concern wrt patch 7.
This changes the API/ABI of the RCU library.
ABI can't be broken in the 25.03 release.

Since MSVC builds do not include RCU yet, I skipped this change and
adjusted this libray meson.build.

Konstantin, do you think patch 7 could be rewritten to make use of
alloca() and avoid an API change?
https://patchwork.dpdk.org/project/dpdk/patch/1738805610-17507-8-git-send-e=
mail-andremue@linux.microsoft.com/


- There is also some VLA in examples/l2fwd-cat, so I had to adjust
this example meson.build accordingly.

Series applied, thanks Andr=C3=A9.


--=20
David Marchand

