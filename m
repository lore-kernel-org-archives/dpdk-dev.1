Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5671C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 22:48:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBCBE4027C;
	Fri, 11 Jul 2025 00:48:14 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 167D44026A
 for <dev@dpdk.org>; Fri, 11 Jul 2025 00:48:13 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7de159778d4so21015885a.1
 for <dev@dpdk.org>; Thu, 10 Jul 2025 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752187693;
 x=1752792493; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vpi8qtxqbi8Rze08uNY4BAUb2c5XRcukuliKMmFtASI=;
 b=U8xmEwSzbhSXlC/NMc3eyMmh4s74pp6Hc+PK1rbcL16Vd8KeLMkJvV0UL6/0LX1tqh
 qLaXloIzpBiDiJEb2I7ERlCVu5jsSCGvspcsD2pITLD5uHPIM0u2srUQodebwp6v9scC
 vm5aTvVBkaaBDTrmXBl0JoeJBF9qwcrngilFtpnF/qIrHZ/55ar/0c0gv9YPd64s3pW/
 DeRIKdTV8h3B4Mk6XS1GLpDUtF/wiaJlavOAS5c4t0DRNmBJUQi7rQS3wZ9OQIrSyDUt
 0TduAD3hseSD4H/aMMlI0T5hICuKCx7SHQvN70Hww0TPaN4k5kWLajcj8fLrPCh1owvh
 HTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187693; x=1752792493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vpi8qtxqbi8Rze08uNY4BAUb2c5XRcukuliKMmFtASI=;
 b=YtYadiqSv/Hb3x2yb16WhQdEQeEXUElq5oPeXmsoQlKzeTFeKUpFpQWyX/VfyKfWh+
 xhwILckb5/ENm5ja7+2FUykzvCssRF8aU8WHIQ2sTtjr/jbJ5t2R5pirtxaMRR1WP9ZF
 fRvriIDRpRCKlIrURtTT0etxsdFpX/y+j14wZiV4MNKZwWk5sP1mTG8D1eV2tSnYDFEA
 HbrM8pQjRMBRGSvhkqYagxu3VxOzto3UXBXgf4taifj3dY9R7hfdP92smFEpH9dmlvxu
 FYLAHlpZz9kPKxUw01ftmVJ3XYT65yu6L3h8AAHHjeZZ4kEONKjU2jc91A6OcBEGC4o8
 n4Eg==
X-Gm-Message-State: AOJu0YzLey9ZZPrrhWRzMbTccZ5d/6D6ZV36tv2XgRo3dvfaUxZePROf
 AGTajaYR19TJ4TI5UhthXKdPKeatuwzanH43yUI+DVLSTutv2NKxiduGnkEsdtukauA=
X-Gm-Gg: ASbGncsra4jgLUPnUQ0X0CxaJh4irp81FBCVR/kttIAUYgvnmXuXQQibvGk7MofLAtC
 P/sIhedQ4weWs81ZN38JipA/Bc6jCI5KVzLRd61ZDXZ0QzuC866YT8TETrzbbHzIOz8l5X77rWP
 lKNbIo64SXvvZ0XsVDZ+tVMyWAVpoMzVyl23TyJXmRGS0LY6EndUeoSoUmDP+WwiBsaMJ53Orli
 HxhNt4Oog7LlxqaNKMklFretq+d/veAi1Jigi1KsVog2vMZJEkpTh262UAvcnfw344iIyGl78Qh
 +0EhSj1m3w+UW8Hg+DurVLsNiAaOadLoDHoK7WhTVe3VmExv/2vOAf40nWQBpDF4DWvbTrajzcy
 ox3lwGp2D95P/kYG3X1biX0x+aUtV6ID18Fh+Nbw=
X-Google-Smtp-Source: AGHT+IFjP6a1yHH/EV8j3dHT3sgj7YvOr0RA4WFnVX6oHi/4+N6PWf3DtOnFNosHxYv2jiSZ+kEr3w==
X-Received: by 2002:a05:620a:370b:b0:7db:3ce5:d599 with SMTP id
 af79cd13be357-7de049db23bmr143015385a.11.1752187693233; 
 Thu, 10 Jul 2025 15:48:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7de54718fb9sm15957685a.21.2025.07.10.15.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:48:13 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:48:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: Re: [v8 7/8] bus/dpaa: improve DPAA cleanup
Message-ID: <20250710154809.1bb1a5db@hermes.local>
In-Reply-To: <20250703053743.3710482-8-vanshika.shukla@nxp.com>
References: <20250703052558.3700573-1-vanshika.shukla@nxp.com>
 <20250703053743.3710482-1-vanshika.shukla@nxp.com>
 <20250703053743.3710482-8-vanshika.shukla@nxp.com>
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

On Thu,  3 Jul 2025 11:07:42 +0530
vanshika.shukla@nxp.com wrote:

> From: Gagandeep Singh <g.singh@nxp.com>
> 
> This patch addresses DPAA driver issues with the introduction of
> rte_eal_cleanup, which caused driver-specific destructors to fail
> due to memory cleanup.
> To resolve this, we remove the driver destructor and relocate the
> code to the bus cleanup function.
> 
> So, this patch also implements DPAA bus cleanup.
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>

This looks like a bug fix (not a simple improvement).
Could you provide a Fixes: tag so that it can goto related stable trees.
