Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E03CC3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 17:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29F3940DCE;
	Tue, 20 May 2025 19:14:44 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 017BE4029C
 for <dev@dpdk.org>; Tue, 20 May 2025 19:14:42 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-601f1914993so3688183a12.0
 for <dev@dpdk.org>; Tue, 20 May 2025 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747761282;
 x=1748366082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKx6N1EIWsv/aQOJH+Z4ga9sl80evqXo6lmnIvouiE8=;
 b=UOdXSZUF/dHDH5D1rKXXWWLqmKTZdpVIRwCLyxn3uVgG1M5LGNwXVzPpTxkzXHgCz/
 RFQHwEq6nuu0V+VKoVWvuOvG3pXFhfIwdrb0DuDg1lpTJkQ+6KMu0FFPFoD8cazxUXfr
 didybHrsEYtRTFZY0SQYccEd7kOfthIewGCWJlig/jx112hswGFUROmYfMQqWIn+cBvr
 uzTyBkYVS8bt1DpSV4nLHtgnushvss+5ePVxU6AdHPD7Qa/pAY5+aCLQ6UH1yXB3ExPl
 IysOKJ7dDXW3Nnl9dWEXo/W2DHODLac5MMsSnt62B2T+5iDficw8RQATIBz6LM4a3Cg+
 WrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747761282; x=1748366082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKx6N1EIWsv/aQOJH+Z4ga9sl80evqXo6lmnIvouiE8=;
 b=Ym4dXpz03q0NERUts4uVHOP2EKYhz0h8Tp2Ip5eFXSY7+2iX/mx5XZVloL5vRkxXG+
 OpoWVMpNNKUTmpTq15iij203ylofSgZWSkeluWJ2tKeC7FAIcv9eBXJzFxoTohgvwMPw
 SMdiq8sqUQ2tsk5LO3KDelDLeWrN4z4AbA48vOBSGAfoLwXuvpqs3Z5HzxuQ2O1zpvsO
 OONN55jUEGFopiYRBBJHfq1pGWmGuTHVGo4NjqVOdu36QvHTXl2niRacfybETnB46vK/
 48RpZSEnrdcq5IgmRRTeOWh2qoGdMrsg1CfE+kG+45HcEwksrFW1RvUNYLQ5SBQoaJ3M
 m0Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPHsuDsnlzOZYPRL6sfeX98njdc1fYTrBaf2yW4lR6xQ5tcXHtqE9j1yTqn+NiAM1Luz0=@dpdk.org
X-Gm-Message-State: AOJu0YywIzbGeVfWjYf5UVOlfiY1LbIYK+Dy0X3x1n60NOF2cZePAnwL
 LDFc/1tFqdRFNpxjkSvWKo2lctbBzPTGJwmxcLKkUp9ajd1BMUGZv3WULdkz0ajcvtg=
X-Gm-Gg: ASbGnctavz3Gy5K160sCsWSPRXxV8BYNYDcA/TMoPaTS95KMO4swQ9TOvdWugGrL8KV
 tgvuXXzoMMRAFWuPwimvGdI7xdby55qUuTA/E3KHSbf9TMmHTdntLL5jq92CRmyiFWHCytkelXo
 dq1kH5wl/0wfpfHwkVBzJAsqJHm3R2LuVS0Eh/A02og0pcIAn24HbJC+i5IppxwGAJ3C0er5rt8
 lPYBdfIxTxkcpZ5PmJABI/aeFFDyThw7+1yOIBUyn/QNCkZOqwUmcJdX1FUW5NU//H1j9IRooLv
 LqBX71lFn/ReOFQXF8jUSPDhPvbe7sbbrpHnRI602Iz7metKYdTtzEEFOsojCpKSMUhA9FGX83q
 duHPOzjwDOMjk+6Zixn4wr/LDT3zF
X-Google-Smtp-Source: AGHT+IF+J1tGSYsCtVFUJ6AmnBSQNSfrQKjaSIJQHUMM3uBvjwNKPflkRmxOwAeFc24Kfka+mA3Psg==
X-Received: by 2002:a05:6402:3550:b0:600:77e:49b with SMTP id
 4fb4d7f45d1cf-6011408851bmr15519829a12.8.1747761282357; 
 Tue, 20 May 2025 10:14:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ac33a88sm7458095a12.51.2025.05.20.10.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:14:41 -0700 (PDT)
Date: Tue, 20 May 2025 10:14:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Thomas Monjalon <thomas@monjalon.net>,
 dev@dpdk.org
Subject: Re: [PATCH] eal: add getline() function for Windows
Message-ID: <20250520101433.3a264cb1@hermes.local>
In-Reply-To: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
References: <1746477607-14961-1-git-send-email-andremue@linux.microsoft.com>
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

On Mon,  5 May 2025 13:40:07 -0700
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> Existing DPDK code uses getline(), which is a POSIX function and is
> not available in the Windows APIs.
> 
> Instead of rewriting it or coming up with some other replacement, this
> patch makes use of the implementation provided by NetBSD to make it
> possible to compile code dependent on getline on Windows.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Not sure, are BSD-2 and BSD-3 compatible?
Getting license exception approved requires going through the governing board
which can take up to 6 months.
