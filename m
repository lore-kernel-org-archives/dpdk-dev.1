Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D81CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3000402F1;
	Wed, 24 Sep 2025 17:24:14 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id B1EBF4025A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:24:13 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-80b7a6b2b47so1006885a.0
 for <dev@dpdk.org>; Wed, 24 Sep 2025 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758727453;
 x=1759332253; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Njm55yCQD8QM5Zd5WruRw7E/N6z4O87rw4Tx9lpRxPY=;
 b=ZBFwIDOl9GiIyqAJP0v0R0LYtjxxM6xzCAek6La5G0LcXmilRDnAgxsr3qccK2Njc3
 tZzMHgeHxHEaWHStoaq5GMjIvCT2jZ0B5rND38327FFvXltSaW2UzkqA3fZuUAQ//L1j
 rDIaEQzCMTU+RalCS2d3azjmsCWLEvc5hvEdpzsp6fb/QCuBp+STZAffBi1pSzHNqAeL
 j2mgz58WV8AdXbgRwsWt61LOvLoafacisU5jlJQH7luoRkcHidcUVfhmJzutGd5fGjM3
 6axp5tfrMetIAR0wLp+uWkeUKS7HBFjfglq2G63npaEjyiLquE4tTnEmVzDfDswHnxWL
 maZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758727453; x=1759332253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Njm55yCQD8QM5Zd5WruRw7E/N6z4O87rw4Tx9lpRxPY=;
 b=cerNc89Q4W/6d9+D3kbBrcpfmuLZNt7RZF0rWDaCZFtt6Yg5Giconrsp7aR4V/1NFe
 +ejdU2kpBfPwV7Es+lUvgqR8HVAuFlunrmz6M7lYmBzPApw8bVgcvncJg3YO3reGLgBz
 ZuCb3mS8Dsd1ndwIKo7QNYoWTjXnV/QYz7HTXG7JPGNtHKmB69nJ/q4pRQBsq6zO7J6o
 6yFAWIL6Q6/lAIJfkVZ+tnlk0LV6rMzikuIYyEwou2n4pVOxetY5RqVf8RzhNjOOTV/j
 /+OBd4Msvfo2lQ2BzsW4GD70nYVvjhTylZydx7Kin5Md6Mjr9Dle5RwRuGuJYxKgfR44
 TbIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9DYlw3GNbEzeKhg3xksvzmr7U0jBf5uIiOrM7J99Tg5njC5GbBlvtt4hMtuu6E6r3tLQ=@dpdk.org
X-Gm-Message-State: AOJu0YyeGoSB1S9psJgxv/MjSV2zid6uTKOWd4dajfG3//09QMIZ3ej1
 V+oWMiMHG6hEfWDfON413FF9GgCGsGoHGY+8oukSoWVP8dz2BPWv1DR7ESSpguYdozA=
X-Gm-Gg: ASbGncv94UuH1FPmVstjlr8dtxJqAKVsIOmAeRIXyz2XDz3rzjLzilExL0nBsAoyfTg
 Vht4wlm+m8A+YfoC4nc303LukWkAxYcSN0x3r7rQnBC58rZy/lCRbmuXVd6SfHNhFSyUGkz1NDc
 pPncYkT0Qu2di68K10H+jL1AUh7Psmoo3QG2v+Pg2ZBr5U3inmcexBfJLI2YydxvCj8aUG1g9sy
 WJiZUcRznvo0XixrLeMrLpVYeVh6Eo6PKA0kYP8NqDFuzrf0scqxHSJaWzH2LZIjnuLVoRDwgdI
 saFzT4L49kMCl9AlMcz7+dFzhU2eZfcCfg0Qd1SOr9TUUsnvbVIKu2eAHyDua7hXYVapzJ1KojB
 VaueRSe7E32jcCA0mmYxxm78KpZ8uFfnvlhH5TQLN3mmXbjbiX5DJt1Zm3W1EcWZmrKfq4Ld3ss
 c=
X-Google-Smtp-Source: AGHT+IGUnxLASaSk74dFSydFNKVsP5fz92ZrKvLFrjlQIAdf6LM9Gkrzy6lzRW/cn/Z0E+obvGQsug==
X-Received: by 2002:a05:620a:40cb:b0:856:b388:7e84 with SMTP id
 af79cd13be357-85adeb4de14mr7142385a.12.1758727452952; 
 Wed, 24 Sep 2025 08:24:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83630481f2csm1154160085a.35.2025.09.24.08.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 08:24:12 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:24:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ola Liljedahl <Ola.Liljedahl@arm.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, "dev@dpdk.org" <dev@dpdk.org>, Dhruv
 Tripathi <Dhruv.Tripathi@arm.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Message-ID: <20250924082408.3a7ebdee@hermes.local>
In-Reply-To: <EF1C5BFC-B9C7-4D38-8FDC-FF412DD45C21@arm.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <a5fae8a9edc947fdbaf4e2519c39f93e@huawei.com>
 <2a611c3cf926d752a54b7655c27d6df874a2d0de.camel@arm.com>
 <61a9d5b157be4816aa296194f9c0eabe@huawei.com>
 <4173E44D-BB31-45B9-AF6A-553B1E755604@arm.com>
 <64a7def62ee642139c3af31ce4fd94e9@huawei.com>
 <EF1C5BFC-B9C7-4D38-8FDC-FF412DD45C21@arm.com>
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

On Tue, 23 Sep 2025 21:57:32 +0000
Ola Liljedahl <Ola.Liljedahl@arm.com> wrote:

> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.


Please fix your mail system (or switch to another email provider).
Because this kind of boilerplate interferes with sharing in free software.
