Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3417DC88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:39:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 361654067D;
	Wed, 16 Sep 2026 13:39:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2A669402B0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789558740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=stj69fB9KoUZ32nklyynNFZeZmurmCDmpnOy8Yi5dbo=;
 b=akZ6ZNmuMhGtwOWEQjHpGEJ4ZtfZxEVhTcUg2xQygWqQj63N/fUotJ1sUxOD7dvdWKK8ge
 tHns0139Y2qt94KH5rgy8+1w3PnJH4DR8ST3iduUv3hp39Ha2eIPe9E9g55ubF+dOKKezK
 Cx5iQ7BxBID/1No5MKFwUXDqsLSVjHs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9hzdQQBeN1mXMAvPsk0IpA-1; Wed, 16 Sep 2026 07:38:58 -0400
X-MC-Unique: 9hzdQQBeN1mXMAvPsk0IpA-1
X-Mimecast-MFC-AGG-ID: 9hzdQQBeN1mXMAvPsk0IpA_1789558737
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a49cdd876dso23934701fa.2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 04:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789558737; x=1790163537;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=stj69fB9KoUZ32nklyynNFZeZmurmCDmpnOy8Yi5dbo=;
 b=dYN1PIgPU/ZgZ8j9wKzvnZDQBjRomsqsOWrQNxlcfQt5gNjM4om2wVD90JQGjk4x6Y
 g2UKZrlspWcDXXOu6dfTMwS8fmNRZWoOkPQ7ijje9fIwmvzafiRilsvrMaYZT/nSBhUR
 PW25PHMxc8uWJr6sCDwQJ8gGKWni+n73Y/KPrIQh7dBp2exqggMdVuUYtq7QdjnFMaQW
 F4UjiHqjq0kEFIf7hbgj6diwIFdN3V8TRyPRCHStWX0nC3Qz7PGrMGN/LYIIBIGFsP5B
 SI4EWA0exVbgBcZJ7BpnM4ltQryj8iHEip7redhRtfnM8jB2cX4UEDFxfTEc4erIOOyL
 rZ4w==
X-Gm-Message-State: AFuF++klPwlCfGAQl7/kF/7lhnRdj/YfgUXOjhI1yILw4+E0BpLeo5p2
 ooxNbBU8hp38w0wkCCa42TvMV/rDOsAmW6RdST6XqDvXthzaOUax83bW9Ej1fXw4L7rsFWuW7zy
 RepIIcrmzdqP2BgAoz5RnCiNJV5EkSLtNxNKANwsU1l7HO1KhfYTfGqTtvdkPc6tFDIaJdf7k5/
 SQhpEZZxCsGR5YuhLtXKh9s86476I=
X-Gm-Gg: AYBFou1iIQjMCyrMEoIcksz+t9Cch1nA8lu7xGX+WopqQ5cCrO3dOzjyb7V4D5cBKUb
 JyjUXDqhmlINMlJwAlcubBj7rK2AxW3Xs/3Q/DOouAbYiF63W1h2qRyUo2zupCWalUPIsBU9iCB
 Paw50Kje2RN7Fk3u52GLb1Dj2WRAEKt5tihcFlT74wChxKLYYmshV4z+21eenSZwooyZelWbqfa
 oD7Eip5zMx/k15nvggsilHNKRk0ZZnN17EbeSBoMlOsbJAO
X-Received: by 2002:a2e:a98e:0:b0:3a3:7681:6d5f with SMTP id
 38308e7fff4ca-3a5dca16b57mr3907951fa.23.1789558736801; 
 Wed, 16 Sep 2026 04:38:56 -0700 (PDT)
X-Received: by 2002:a2e:a98e:0:b0:3a3:7681:6d5f with SMTP id
 38308e7fff4ca-3a5dca16b57mr3907761fa.23.1789558734860; Wed, 16 Sep 2026
 04:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260624113550.821516-1-bruce.richardson@intel.com>
 <20260629142931.2666673-1-bruce.richardson@intel.com>
In-Reply-To: <20260629142931.2666673-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 13:38:42 +0200
X-Gm-Features: AcwNN1WmnMg-i2nFv1SiD0WPNAMD6yoP1qWt3Cf2ODKbaRa2kA2mD2QCpsd9AOY
Message-ID: <CAJFAV8xMLE7JsXc7dVmT0st=rZZEifZFVPVuyHSwdjHRv5B_TA@mail.gmail.com>
Subject: Re: [PATCH v3] build: drop dependency on libbsd
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9rWFkxk3Zrm4YB4UeHY8IlCsgP3aJ7KKTuOgu5Zz0NA_1789558737
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

On Mon, 29 Jun 2026 at 16:30, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Glibc added the strlcpy and strlcat functions to version 2.38, released
> in 2023, meaning they are natively available in modern linux distros. At
> this point, the value of having the libbsd provided versions of these
> functions is reduced, so let's simplify the code options here by
> providing just two options for strlcpy rather than three:
>
> 1. native implementation for BSD and recent Linux
> 2. DPDK-specific fallbacks using snprintf
>
> Since the strlcpy and strlcat functions are the only two items used from
> libbsd, we can then drop completely any DPDK dependency on libbsd.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

I removed one last reference in doc.
Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks Bruce.

-- 
David Marchand

