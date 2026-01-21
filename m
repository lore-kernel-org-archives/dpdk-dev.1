Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A4C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 09:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9766C4026C;
	Wed, 21 Jan 2026 10:14:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5260E400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 10:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768986868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OcdcvGx1w6EjmNlgBa89FH0CGjQz1ey86STiJ0a9m4=;
 b=i2B/QuIY755EVw8zaGVWGluRQB/xYxQFX7L6a1BHgH8NJ3CjO64zSwwEY9d1iZ0LDVHVON
 35OTTcLExrn/x1tpkDx+oT1bvx848iQ7YTailIqZQWTYnQ6iw0W01yzY42MlRDeaSbWXkr
 6GU7L6Xi/PTp2LLQDLqS7QU+Iz3z0O0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-gzaspe9HOVi_s9j5ho8Yjg-1; Wed, 21 Jan 2026 04:14:27 -0500
X-MC-Unique: gzaspe9HOVi_s9j5ho8Yjg-1
X-Mimecast-MFC-AGG-ID: gzaspe9HOVi_s9j5ho8Yjg_1768986866
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-385b736d4f7so1623501fa.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 01:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768986866; x=1769591666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OcdcvGx1w6EjmNlgBa89FH0CGjQz1ey86STiJ0a9m4=;
 b=gnDR/UXc/suat/LgYj64Cd31AXf3RD3+qSgLunOaVZyK59wPwOCLmXi0GTtr0Rb/1r
 8vFY+ZrrfAehRTQyWM9hkQfc2tKumuH0VVzmYuQbXCb7XJmAmc/J9P/d6FPqB61w8rj1
 v1Oosr7NPAj8f/RMgfWF+G9duU5+nSOowBdRYWgpPEnjgkq4xfi7hKPW7UYJ9J6IGjgI
 W3F0YqIui/5GE4J68WHQdHEeCbMpXnjazGBauES4ACaG1119AflkvFE26g9vKdGufT9t
 5IFqFI5pBoJyqCDXk78QuWgH0SKrb9QtrkN5FYqZo7j6XapcWbLULZkf8pIvFWl2Qufp
 MasA==
X-Gm-Message-State: AOJu0Yy0YZ2uuwyCAmwcpWfWme6FWQQpNB7vu1qvAH7OJ38Eaetkz4hY
 lTlU0AQWoX8ZNwcHsSOnMihvs4ognySp4ov5nydskru7ci0Q8+4cayF0NlyIfr+FyQAOAgAaGTq
 t5Oatnzy+pi5aIshcAzNihlgDCwid0W8YGr0Yd57872w/1uwv+ZwlFLnSSrbm8yGOqzCxfUsoq0
 PWsrvi13aqlbRFKMOMfzw=
X-Gm-Gg: AZuq6aK23xr/5cIzQpm2CCJvYsFHctheePQJDZdbTPnIryjnzX4Dl67oVmOkaO0BFPY
 iratHpJn/nG34AHYiOzP7cwB9UbAPgnyflhAjXryay9qu6hpXymsF/MF3Rh1q0oG+npqRqLH5T+
 KPG1PkvvGtZVo44lPz2MDXwh5j1qKVr2aFZV/6drbJ4QTOjkCz7mKErjCHfPUmLNLuIa4g
X-Received: by 2002:a05:651c:220c:b0:383:24fe:4ea0 with SMTP id
 38308e7fff4ca-385a5402275mr18311111fa.2.1768986865788; 
 Wed, 21 Jan 2026 01:14:25 -0800 (PST)
X-Received: by 2002:a05:651c:220c:b0:383:24fe:4ea0 with SMTP id
 38308e7fff4ca-385a5402275mr18311011fa.2.1768986865359; Wed, 21 Jan 2026
 01:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20260119104147.219027-1-bruce.richardson@intel.com>
 <20260119115607.225929-1-bruce.richardson@intel.com>
In-Reply-To: <20260119115607.225929-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 10:14:11 +0100
X-Gm-Features: AZwV_QglDxB2BNXps5E4lPSiQml8LKzqrovb8N1lqu4BwPGAf570ugBfK6E3nzU
Message-ID: <CAJFAV8z06POx--jY3AvxGYPmfZZaDFJgFcNuvJ4=s_tbDBKEhg@mail.gmail.com>
Subject: Re: [PATCH v2] ci: improve logging of unit tests runs
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z2vGq8nf9hDBuVl2k6nefAnissM7vq2dRKy3pvHJERA_1768986866
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

On Mon, 19 Jan 2026 at 12:56, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> To help track down issues reported by CI test runs, add some additional
> meson flags to the run of the fast-tests:
>
> --no-stdsplit:
>   keep the stdout and stderr output interleaved, rather
>   than separated in the logs, to make following what is happening during
>   a test run easier.
> --print-errorlogs:
>   when an error with a unit test does occur, output to the terminal the
>   last N lines of output. This allows us to see inline what may have
>   failed without always needing to check log files.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Thanks, logs are easier to read like this.

Applied.


-- 
David Marchand

