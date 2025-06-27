Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D38C7EE30
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 02:31:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D90F40283;
	Fri, 27 Jun 2025 04:31:30 +0200 (CEST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mails.dpdk.org (Postfix) with ESMTP id A368140277
 for <dev@dpdk.org>; Fri, 27 Jun 2025 04:31:28 +0200 (CEST)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-32b595891d2so15405861fa.2
 for <dev@dpdk.org>; Thu, 26 Jun 2025 19:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750991488; x=1751596288; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LiWalnIgbaetauzijeyGEdcVbUB4qKJhmOQiIeVZIo=;
 b=VQF48hN8ITYLOHq94bwsrl0MGPSaX0ji34uXPhKtaVn22kOCyCoyEg7/hj9T6jHthZ
 xBF+n8cW6tN9uRdsay4O2VhcNWLjLWNISU6QY16vGBnPSGyqkd+lSQIZFkY7O9NAb41Q
 lVMIWESiOLf3m645afPaelQbT/ZoyVsyAUdmn+dozG0L6TZrwfh3QjMSC42TEgVo76sy
 MVW+Zdo2MJ72ziSfrw78O0vu2z41zTnAQa7+6nk3IBZY2+gA0QS3vZ7jKKeya0Ewf3Dd
 zJi1esGIDQly6e2WZ5DiuW6gt7zkfRTdhtCQ5M0MVCahpeJps+YW2o4uEk9Sb5t5JiC8
 Aw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750991488; x=1751596288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LiWalnIgbaetauzijeyGEdcVbUB4qKJhmOQiIeVZIo=;
 b=SiQWiMliwNctnFmYw2n623Y+qjfSkxNqZ+feTiuukT3lXrW+1BetIHJf2NyeQPQ8Xn
 pnRa/TcJl5GLgl6x2EDm3Nd6Hrlhk6Tz9XJJg7bKFQRy2eOPtFfUT6bUxMBa9zrn68zg
 fyNn01JGAM0PilP8vnTE5bgp0W45RDDZuqfF71eUKuSA7V3K7XKtme/+WhlqtaJ3Uu3r
 9A5PGBKkFQy0B+t6FD7nqoW8+Nruaebg9CeCqpPMMs+W8VPMicFgFrTQlX5YFF6mJknK
 OZZhTHgEXv2ytn0ninVJSWEZZJzzjWCO1NqLuDYfZXhDz4VXMrUS0+puW6XuoW892wsD
 QLgw==
X-Gm-Message-State: AOJu0YwUNjPRkq+KVfA4d2WsyKmzSrvBoldExIT4JtI1GV5kg9kRrOOw
 5Z9oMBytMGOgZ0Jsj1GfjVrTQxbDZr1rJjNr592TIC12HWdCMTTrA79BCFOejSI8iD+MpkA/0kd
 mpKY6zsFzdKNh28KXMlCwC4UqCqWdrP4=
X-Gm-Gg: ASbGnctvw/g7NnvqZmPHrwQyfJuZdW+5UPeltPNSj6zZy1GplATQ+pGutvOxKrW5am0
 +T8nCrujECX1KixI8lbd4MYqToY9OhXKXPyZIhqtDqCY/Kfq5/CeBWExmTH7a/hfbG+Yj4WFftf
 Pu7vMieMBSR9XLd+N8RSb+h2rJupqZefNvkrcDVDzUjFFT3U18gKyQ
X-Google-Smtp-Source: AGHT+IFPUFz5ExPhnJfwTbcpSoH6V6VR2CWCNzLI+TtMp4ZJ9KnWGf7WTmL8NvCraiKxSETMqVUr0+8E61EROP4eLVk=
X-Received: by 2002:a05:651c:2117:b0:32a:888e:b30f with SMTP id
 38308e7fff4ca-32cdc480a68mr3401821fa.6.1750991487662; Thu, 26 Jun 2025
 19:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_C18B280C87275E35D0427508AF98674E1005@qq.com>
 <20250611145915.854026-1-uk7b@foxmail.com>
 <tencent_A06B260C88274A75C9E26748A3F8612E1005@qq.com>
In-Reply-To: <tencent_A06B260C88274A75C9E26748A3F8612E1005@qq.com>
From: =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Date: Fri, 27 Jun 2025 04:31:15 +0200
X-Gm-Features: Ac12FXzukrNg559lHqiUS5wAm5K6wmyZcTRftQF3jEJTEotZGQjvUNFP4S09M0o
Message-ID: <CAJcPQBra-tp_66-R8L7Yd0MFOZ5rG4tPv4kMVv3RhbNpLiiqCw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] riscv: override machine_args only when default
To: uk7b@foxmail.com
Cc: dev@dpdk.org, Sun Yuechi <sunyuechi@iscas.ac.cn>, 
 Bruce Richardson <bruce.richardson@intel.com>
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

On Wed, Jun 11, 2025 at 5:23=E2=80=AFPM <uk7b@foxmail.com> wrote:
>
> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
> Support using -Dcpu_instruction_set=3Drv64gcv to enable V extension.
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> ---
>  config/riscv/meson.build | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/config/riscv/meson.build b/config/riscv/meson.build
> index e3694cf2e6..1036a86d05 100644
> --- a/config/riscv/meson.build
> +++ b/config/riscv/meson.build
> @@ -111,6 +111,7 @@ arch_config =3D arch_config[arch_id]
>  # Concatenate flags respecting priorities.
>  dpdk_flags =3D flags_common + vendor_config['flags'] + arch_config.get('=
flags', [])
>
> +if (cpu_instruction_set =3D=3D 'rv64gc')
Perhaps instead of removing full flag customization, we should skip
the -march flag within foreach if cpu_instruction_set!=3D'rv64gc'.
Reason being that just 'rv64gc' doesn't mean the default. Look at
SiFive configs - they have -march=3Drv64gc but -mtune specific to those
boards.
>  # apply supported machine args
>  machine_args =3D [] # Clear previous machine args
>  foreach flag: arch_config['machine_args']
> @@ -118,6 +119,7 @@ foreach flag: arch_config['machine_args']
>          machine_args +=3D flag
>      endif
>  endforeach
> +endif
Small nit - there's an indentation level missing around #if-#endif

>
>  # check if we can do buildtime detection of extensions supported by the =
target
>  riscv_extension_macros =3D false
> --
> 2.49.0
>
