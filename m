Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B31C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 14:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B267A40287;
	Mon,  7 Jul 2025 16:58:44 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id D36334025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 16:58:42 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4a752944794so36086481cf.3
 for <dev@dpdk.org>; Mon, 07 Jul 2025 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751900322;
 x=1752505122; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHh+m+GLUE4NEFT/89Z3Ixm6MlfihoiOZrnp0K7WgKE=;
 b=JMv8JM9sqGBez4X45ASppvcDqx60A0bG0sdmookgZcXi18k7Hg9D6tGB3AFioAHKxB
 YTN8AVWe8Ky5se5GNvvdVIXyBr2JUQaLN+CH4NsFazYizlw+ktvMQtAPV2BL7lqk1JGF
 oZB8moAy3eQw3YkoCO32TIXRntWLLJgEHpheaCwZAvkQ0NPT/Q7Iyf41QssSUwsIdaWb
 +FJhQNYYS81LInnb9Qp9rpBEdnxfAaaofSgZ/YEFcnj+QtMIFncvOMmqoZsRkbhr6gbK
 HsqxjGy+0JLGmh6q1IT/5Y7edie0KZ7sEgb+OXAv/1mmQxzfRHAb9Z155Z1cdPR9jdos
 g/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751900322; x=1752505122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HHh+m+GLUE4NEFT/89Z3Ixm6MlfihoiOZrnp0K7WgKE=;
 b=dq7u4ROE1E5IwjRR61FNpFdmDzzfzvEVTDs/V8AHEGUfwx9grzpgZbVc3JvhFQoOhV
 mxl67dmqDlT0MNDCQUqu2Sv32iUxANOd9S0++Y+nW+XNXG+TycNcMmWEnIw601gyVjTu
 AiEJ4jE98bZwrqk60U3yjR48hNRXgQQZnot8BkzQYCTvleXIuxnArqfm6irk1+qQaitv
 iNozum7ukHihT/NCFaz8mhXy7JcSha8nzscXj2xnpUsD5d29tcCvnViXuPMYtIB3o/2V
 4oQs5paFkKUtRLinczyVYcztbJJz5Lt1nTmqus5Q36Xtbtx/ewiznic81Abn/E0MrzWK
 Z4sA==
X-Gm-Message-State: AOJu0YyR/JxIfs43ObKiCvgWpNbJRgceHjIAGETPW/EuqYgWouFzuRrH
 BrkJKW9K2WXiLHGuh3wHoqAUgDdzJUZ7FIOlO7YAotVF4iTQIKew4wx7mQK7eIeDTVlAjCndMrC
 YXhuu
X-Gm-Gg: ASbGnct5y1IX5eG5jbvbaFM+ZUwEV/MwWCbdDUydHF2rMeKSybE8rQ52ae75LPm83M7
 i0MuD4UV4ckSy+2ux6Cm7Aq2vyMl8BTvOnbULcMdBXNjF2H+4LvQg2PpH7ZJhGjURr2NGipe315
 K9hWB8mhKhOUawAOiyp+Awm8G6GsjWJoEK93sYZejiLJUlKsCpfv55vUWJHrEKa0n89xfSfYkoy
 M1xX2OZIOhVnBqyHvOjYmc4U1v1T2NaZYdylCsX7RX0a+UB3ksWb50glk+PHlhNaHAkgMj0y2mH
 TL0J4SS+lZ5s6WsGrwYRfcMZYT48OY1ByHY05pKJJtWsB+2P7atISeco7Cr4kS3AQ8Xa5pcl5he
 zpL2KUuNyOPgp3XJpFqONXrHhRcFg+xwiZjcbkxU=
X-Google-Smtp-Source: AGHT+IGR16nUp+xMlmgchDxE9Tjv/cV2RP5JbSJq90EChIvrfC9DQXk69flw1e3wKMvUg0iX8jt5cw==
X-Received: by 2002:a05:6214:21eb:b0:6fd:75ef:3dc3 with SMTP id
 6a1803df08f44-702d171dc97mr151045426d6.28.1751900321958; 
 Mon, 07 Jul 2025 07:58:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d50e50sm59697276d6.56.2025.07.07.07.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 07:58:41 -0700 (PDT)
Date: Mon, 7 Jul 2025 07:58:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 01/14] net/sxe: add base driver directory and doc
Message-ID: <20250707075839.5b1736db@hermes.local>
In-Reply-To: <20250707115819.12826-1-liujie5@linkdatatechnology.com>
References: <20250704025401.301617-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon,  7 Jul 2025 07:58:06 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
> index 10a2eca3b0..67e6374c69 100644
> --- a/doc/guides/nics/index.rst
> +++ b/doc/guides/nics/index.rst
> @@ -72,3 +72,4 @@ Network Interface Controller Drivers
>      vmxnet3
>      xsc
>      zxdh
> +    sxe

Please insert driver in alphabetical order position, not at end.
