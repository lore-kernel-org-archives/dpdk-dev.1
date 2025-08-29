Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E4CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 13:08:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C805240263;
	Fri, 29 Aug 2025 15:08:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D805B4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 15:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+DU3ssJQ4SVnPrLawkYJ2X2zcAXU+0Y1pcBUgz1afQ=;
 b=CVm2R+v5mKmBGD5BL3PF09ns+6kOXchcNUhDIXGSkIgnFccj3AQHYhiCfr3dcf8MkaWZ73
 v1Ajhe2ItjXEiHO4W1XI4zr/K+YpSYCW1JoIPQvaOOwzxyVElpRr/DAT2fdeEielu4eoou
 BInxNoLjuR1y4n5oT5xr/0J5vcqDMOo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-wWbnm5AwM_qn79A-kj2_gQ-1; Fri, 29 Aug 2025 09:08:26 -0400
X-MC-Unique: wWbnm5AwM_qn79A-kj2_gQ-1
X-Mimecast-MFC-AGG-ID: wWbnm5AwM_qn79A-kj2_gQ_1756472905
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55f6bdc1773so244425e87.3
 for <dev@dpdk.org>; Fri, 29 Aug 2025 06:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472905; x=1757077705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z+DU3ssJQ4SVnPrLawkYJ2X2zcAXU+0Y1pcBUgz1afQ=;
 b=fbA7izIvF1bf1gaC++lZOa42RdbkteoLEymhydJak6ufAYznE/2h/JzKKNjFtcZarF
 Rw9poCyYdjnfpri91Pi5F8dccUKzm2OZ8Kxm+KZ0eZ3MrYYJsnupO0U6v6N3lYNZaB5m
 4pIjvd50u0B3JEQ1D79T4x09DKqn3Nmm/CdsDI11JTGnJle/n5lVh+Q2LzN//e5+QZoP
 700KcrekErwfyk1Wk2yHHv4/97dooeH9qMWCtDRcGifm1vnX6qdaKsMdElGZ86+3nY+E
 WEcce7HICnqh/sGeOm0jLcaOKX1B+wLIRU1nxDumsmmqXukOq+gXaBZyLC1GWAj8kqv8
 POjA==
X-Gm-Message-State: AOJu0YxYWX4OAKwTnmj8sDi2rHrP0x6QrQ14rmv58hMvKIILzwZKauXI
 DxeLzmyJIq68gFIcQnKb60Kq/tPtd8hbLNiUuhXfDl2TdsjOhxqNgU6uexdkquC6YUTneYjSSfV
 nx9rQJhI78pElIc1hLTCRc2GoVY6PWYU9ljGi/vi9Iq31kuhXd4N+J8f1DRpns7EwzUWEGpYYEO
 T6r7+/Ro1SaAXJwPQSJURrEnZuqhaztw==
X-Gm-Gg: ASbGnctdJavMzue6QCm8iC6wTKKECPt+YvNDItezS4IuWU+uXZoAzxJv9PVONZs/Yel
 NCFNFWTbYXRLjgZ7F8+EJzLeXW6CZdLCWjaDK7kZUAa4QROhp74TEQQOfhvwtQbQi7z2ktyS8H5
 DbgpNBAsVf1JRkbfbleavzAzk=
X-Received: by 2002:ac2:4bd6:0:b0:55f:6da4:6d2d with SMTP id
 2adb3069b0e04-55f6da46eb6mr30127e87.33.1756472904991; 
 Fri, 29 Aug 2025 06:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXjW8ww/NlrIpRIl90maRuRRkbq3akpzS2xiiRLo64P2cbQWe9AIphBlegtjl/bNd03qQnYnbj4VN/OLwUTkQ=
X-Received: by 2002:ac2:4bd6:0:b0:55f:6da4:6d2d with SMTP id
 2adb3069b0e04-55f6da46eb6mr30117e87.33.1756472904594; Fri, 29 Aug 2025
 06:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <1734982541-8248-1-git-send-email-andremue@linux.microsoft.com>
 <1753121912-31321-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1753121912-31321-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 29 Aug 2025 15:08:13 +0200
X-Gm-Features: Ac12FXys_3k2hlG36msT1gauQeX1NGMIuj0amshYKITo6YJ-94u-_a1DOIBazyo
Message-ID: <CAJFAV8y4TCOcZ5JZSE-MDfkBCe=DuMStFpmETJ9wM6JQZJt6ew@mail.gmail.com>
Subject: Re: [PATCH v2] app/test-cmdline: add test to Windows build
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jhIwEqPWIwpZypob34RTk8ZMMX43ZIfO49DxAvt9odQ_1756472905
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

On Mon, 21 Jul 2025 at 20:18, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Header termios.h was not found on Windows, which was probably the
> reason this test was originally excluded from the Windows build.
> However, ir turns out this header is not needed for this test, so it
> can be removed and then test can be added to the Windows build
> without negative consequences.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


-- 
David Marchand

