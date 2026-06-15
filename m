Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0BCD98DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 21:32:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEC6240DF6;
	Mon, 15 Jun 2026 23:32:33 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 9329140DF5
 for <dev@dpdk.org>; Mon, 15 Jun 2026 23:32:32 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-13817614cd3so8182126c88.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781559151;
 x=1782163951; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5p8fZnbwFtKU4UYZ9ca3G4AjoUhEU9DgFE2fx1snAU=;
 b=FfZ3yjsfNa1vgavG71SDU/sAhU2O9qJzaA0//UMccnVd9voFJvoZWnQGoLAQrPh41A
 FPwmIf3bTaL830LFbfS/MWU3aeBwEZg0b8UMMhMinKT00tJNi5S4b+dmNlLfGh3ra24f
 nHIXdWJg3jJiJHTidkTlhHKoH+nyCuVK9T3OkDAUKl4Q7qKavWwgAk5HNiCWc9Z0fL6j
 2N1pO4eKvqlaDSLxsoBCeFhp+YtBOjjLcdxxpfd4mlI9LOu6F/Q0IaLHoDWKm7cVLrpr
 jBKLzzZUmK5ViiNM7eP1l+Fb4qNmkngoHPwrxpcSLYBYWcXjO/IBrq5LvajZZ33ag4pr
 oGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781559151; x=1782163951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k5p8fZnbwFtKU4UYZ9ca3G4AjoUhEU9DgFE2fx1snAU=;
 b=XqLiq/1ZfftkFywiyZodkXjmtPfc5SXYG458JmoULWcTT34sn90e+0maHSc34Gk+Sx
 kEjZUq4jpyA5y9m0IyLGcF3ZpXR5A8C5kZraYvSMh4iB5e1wgisGzWTLkePEmnRakT02
 xg3FabGeBFTmsd+zrr+RJ2ESiZ6gvYC8xjAPxPdYRNe070Gtd1mNiTBJVo5GdWphcPoo
 3jeNseMdXKxp+4+CRngLLIhMT7oumgkL6apLI13yFvQoRpB7yRDKMCBJmrC3HaV7ofRi
 91y4SMbYOGw2OrOqddJv+EmZt9Xczf8cYNONnYphFh/knIZYfsLCOs29BixC6jLsGMN+
 fa/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JtfyZOLPsODiRw2MTOmcQgELTziUsx3M57uenh9jKyBc4fSgxgpIGaN9SDNCktg9tLaU=@dpdk.org
X-Gm-Message-State: AOJu0Yxq5tu8rz/kQXc1iQaPfJHhTvkq40Qgw2E1C4EmrerlTpM1Gwa+
 eCmkmpWRPQCZhieBSyoMKOJy1UcmTtNadRBlH0YMZWzsqCsncRLWZ+dD9Smu02+KoHk=
X-Gm-Gg: Acq92OGCzxMJDUeN/BeIccO4qMs5y1s6vZPyC7ZZamtVxpV6NDDdxAVHJIFhc/2/RHz
 RR/i7/ECAm3TDGFct0vG6szMd2YBSuRSp0DHOp1FvYCw+1CgLB1BUxtctpGenSlr92Cf/s6uqCV
 GA4mcp6Xa7AqQzY9ME52FO4/UbOK6cKqDH2hELmKhXQr0tnrGw1MmHz5WXcpS7biBfd925/A213
 Jx0RYIo/CRLP/Rb/2njs9hpW/ftN8jda6V6z59f60u88Tai5J51A8VUAOWawfRWAifKvInuRZYT
 wuFKE4Z3Es746yQYSxfUZlwaIvYeqtFIEjVmdQSgu3urgxQgyhRnK/FpD6JsX6YPGtz664PPHE3
 WDlOSgbP9mvwzfE1IYIayXc/BxZ1008suFKga6ckCYK2dAJokxHlTgUg/wROOGSlx+0coACKG5S
 Nm25zCnXJMV0sWVqyoEXNbvR+xX97htusUgXWxGXMVZOTUtSWYKU3I/Ih3MNGhs+ImNrQ9wd7l1
 cY=
X-Received: by 2002:a05:7301:4593:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-3093eb4982cmr7432888eec.22.1781559151491; 
 Mon, 15 Jun 2026 14:32:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e4898c0sm16766981eec.3.2026.06.15.14.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 14:32:31 -0700 (PDT)
Date: Mon, 15 Jun 2026 14:31:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] test: add larger input len test for CRC16-CCITT
Message-ID: <20260615143109.1a931176@phoenix.local>
In-Reply-To: <20260612023745.275608-1-16567adigashreesh@gmail.com>
References: <20260612023745.275608-1-16567adigashreesh@gmail.com>
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

On Fri, 12 Jun 2026 08:07:45 +0530
Shreesh Adiga <16567adigashreesh@gmail.com> wrote:

> CRC16-CCITT test only covered len 32, 12, and 2 which meant that
> code paths like 4x SSE4.2 loop and AVX512 code paths which operated
> on larger lens like >255 never got covered.
> 
> This patch adds a 348 len input test for CRC16-CCITT similar to
> CRC32 test which covers the additional paths in SSE4.2 and AVX512
> implementations, therefore improving the test coverage.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---

Looks good applied to net-next
