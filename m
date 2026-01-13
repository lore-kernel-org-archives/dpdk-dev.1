Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1FD2F326
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:38:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215164064C;
	Tue, 13 Jan 2026 16:38:49 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 368FF402D8
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:38:48 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6505d141d02so12284146a12.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768318727;
 x=1768923527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ze6PektBc353aGB7/mOcBgV3WNBR7ZghyQiqLU8A8mE=;
 b=YdGUTcxo+iWR54trnawEAzFWrqC2GqBijRenQ/hP2Oxal3fp1/JbanIsrz/6PK5hpw
 t3JMwmcHPqtbBsxf3DqsweCdX/vcOO1JjfJREcBWARm0Za7o1o76V9fgGjKs2qKIoz2C
 zsYP5MvEZgDoo/EoIDRgy0zP0wv4uiAmefhUWgZxI5IID0ARZwAm3pZAmSHDW34sEDSW
 qtx4dSkKcie5hwCAmQ7KSzMNsp66insw+jwmzG1cfifUE2s1DRI5jRQVnXzBYTLEp2vp
 O0YTf6PTI7Nx4169jGPZPtfmK4ZJszKzQ/zM9Y9OPDk2Kc7vgWd9d5/onhHLzgUmu9tK
 lcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768318727; x=1768923527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ze6PektBc353aGB7/mOcBgV3WNBR7ZghyQiqLU8A8mE=;
 b=lS1Pjt7JioVicje6dX7J+V5cCC2WzKHIQNB+z4AQxiUhMZHRlxZbqp43P8Zp8hNeBp
 8HEuqCNLI9VyISz5IbrEXIbe5+gz2LC6gS7/g6vjoOZzL+oZSIwHe+EPc0ToDb7zFDEa
 i5ET/wxm9wpknlegBaDHqcsSDbUx/ynm1WgJvlt6wg1M9yfSrIvsUyScO/xfIa2/PL23
 6GkE28DcD1oX63kDk1pK69LUJiohDebZuaBf+3dcFEkpUbqJ4LvHkI4Po8gufTmwsD8n
 v+Lewk4ecMUTgsEtOAI7A+/kJu+sFsxuLMjVL1O6H6SYIvrcWIPK6YI4KOf9XWP5IPde
 5H+w==
X-Gm-Message-State: AOJu0YwSnZKcSWIok76bf2KUZlIOOa7fcqkS3Ub9oQ/6RgKWJf57MEHG
 BOQ5aU8vEU7K8+V10ypm+AYeiaLc/c5AiLf8LSgbotTpwNDWeKm/11pW5VyKXOWyAzw=
X-Gm-Gg: AY/fxX6BcRG2brRODd47l6jUJw9/cPo3LGn11n4FvxMIJbRnGRs0hbxFFLLuj4bnPwb
 uKC0lKL3/JShn+84TjTkznHJTK4w+XRs5ZTFtqqbWQot1dXy1cABXhl6DtJz2DKgqB67jUzUmgX
 5YkwHlai82AA65eSQGWAg09qkXZ5kGThcvPxutcQVMqLry6TdpINZvqQEDUnDGgzWrE+zmECiuU
 b9pcKETno+iwuXuFWbBqm6oU4xQIlq8BIMriUnsobrnvMOU/MBEv3p9t/iTkO2Sp1V2REYwuWFp
 5o0EFjaSVjK4qimGaR2eFqmIcbu/gl4Dvi0oIs5LvZ2peCg0plkuT5sp5xcn8ILZJ3ogDYC4FJc
 4lbwLhdC5rGogWZJolbzqR0R8Ncbl4Dmh7prk+TRSbF8CuXUb3fDQ+mhV/KtNp+giE4YZY/8tDK
 kPFcS6LMkQF/7MQQTA/COU8XiypBpjRIsHpR3Tunx1w/0XxB8/Ve4bzakXmK6NxMk=
X-Google-Smtp-Source: AGHT+IGWJKi4CFgRrdMYaFJ1IB8eQCGosLHALCjuuGByibdOCQeWfb+wWlZRRfnXEnrv1HVWhLKkVg==
X-Received: by 2002:a05:6402:2794:b0:63c:3c63:75ed with SMTP id
 4fb4d7f45d1cf-65097e59be0mr18220265a12.22.1768318727544; 
 Tue, 13 Jan 2026 07:38:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507be65197sm20352700a12.19.2026.01.13.07.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 07:38:47 -0800 (PST)
Date: Tue, 13 Jan 2026 07:38:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH] net/gve: add reset path
Message-ID: <20260113073842.7069f6c6@phoenix.local>
In-Reply-To: <20251230022958.3842695-1-jtranoleary@google.com>
References: <20251230022958.3842695-1-jtranoleary@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 30 Dec 2025 02:29:58 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> Currently, the driver does not include any reset functionality and hence
> cannot be reset by the application. This patch introduces a driver
> callback for the `rte_eth_dev_reset` function which will reset the
> device.
>=20
> Also, as a precaution, null out device pointers to rx and tx queue
> arrays when we release the queues during a reset.
>=20
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> ---

AI code review spotted some minor things, please provide an updated version.

Patch 2: net/gve: add reset path
Verdict: =E2=9A=A0=EF=B8=8F Needs minor fixes
Commit Message:

=E2=9C=85 Subject line: 23 characters (within 60 limit)
=E2=9C=85 Correct prefix net/gve:
=E2=9C=85 Imperative mood, lowercase, no trailing period
=E2=9C=85 Signed-off-by and Reviewed-by present

Warnings:

Unnecessary initialization (line 45): int err =3D 0; =E2=80=94 err is alway=
s assigned before use in gve_init_priv(). Should be just int err;
Missing release notes: Adding dev_reset callback is a new feature. Per guid=
elines, new features/API additions should update doc/guides/rel_notes/ for =
the current release.
Missing documentation: The PMD documentation in doc/guides/nics/gve.rst sho=
uld be updated to reflect that reset is now supported, and doc/guides/nics/=
features/gve.ini should list the feature if applicable.

Code:

=E2=9C=85 Good defensive check for secondary process
=E2=9C=85 Good check that device is stopped before reset
=E2=9C=85 Error handling is appropriate
=E2=9C=85 NULL-ing queue pointers after release is good practice
