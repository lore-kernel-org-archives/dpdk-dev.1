Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B5DC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7821F4065B;
	Mon, 21 Jul 2025 17:35:01 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 29E9540297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:35:00 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7e29d5f7672so409095285a.3
 for <dev@dpdk.org>; Mon, 21 Jul 2025 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753112099;
 x=1753716899; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JS6BSGr4U2KCKy47vrdN+mI7chF6CxTYcdpeEw9RtoA=;
 b=qO+5KR0bxPEpvIzolLpEn58VlAQLcx1q31OYKdRZa3pwNpU+b+xkNjqi919TOkjd9H
 3mhGuS5hAJeV5+T11fMSHG5OgZYTVqHg+sraDcA3rrA1+KEnK7s3yXkLynOMId6UuMjL
 A9h0WkfoAErdOsznJ+zjrlZBHIKU4Ic0RDFcBi/26Slohl5BR+PtHFcCsSrwPyzzj4a1
 mg8NphCKXdmcZYoVd/SYAS9/nAVmDVClIB4WPO6tpNsp3rBVw65etHpqvXTzuDdKtK/O
 xucJpswvxCoel929qUU4EFAqu37MvW1d5Zx3Pg0G4NoRPV7LzDPfLxOdLr5DUb5Ra8Lg
 AbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112099; x=1753716899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JS6BSGr4U2KCKy47vrdN+mI7chF6CxTYcdpeEw9RtoA=;
 b=r59P9noR8B8tQolCA8OIHRGbM94KTwCkfDoMkrVRRET1VR2xDk/kjUgkFWQpLkARu+
 3FxDJnTtohRn3JWKX16ECyyQwbgXFHB+vHSjjL4LzNp0fcP4PtMNq/KOqPOBbcrBqf8M
 6wCg3sIfbh6MNaXlgFtSSxEAr6CJnnAAQrL39JNY5j9zmx/3KM+Pj9h054YYWuK7GRf0
 I/VI/ssifyhHpULPBdjLXhD2jXLlgfG0yhLvCgU8LQfM3Mn7Dq7e5UUWDIr30d9L58IJ
 Vbauze9kNH5KRHKTNNrmk59p+l3PFpfhRaM1MWfGN6jPePq9EYwa8piJz8Hoz/HT0Tw2
 KDiA==
X-Gm-Message-State: AOJu0YwWOLsjP7PstRa89z2+BXKxWYzFv24sxzKIPOkbkMkRsOZtOpYO
 CcgjnGX7b5lIc0vKdDtrDJ13H9f7wCLbRVssT8L/644DDM+bOsWtk0FtwcdS2PEoXIo=
X-Gm-Gg: ASbGncv3Rx+/THV8C1xbH1MruHbzJ9PVvIKaWAdJCBysFEfPOMBZwRgEyvG5fsXuGRH
 LvNN/lu9z89cKqNc7fSsbUA3CBMAk6Ln4ZkQeSq+bSpyT9LZoKGPjYB6cUJdPIznxf5mt4PK7QB
 64jjlOttqV583U30SZp1w04nXi3AscG12vn7UCJMOQOSRaSXCaepMMUIBGkEYQVM3qxTntbeyxy
 GXNa3i7KFTYlaW2cHgP38qb01LIPjgXaAAXc2C1AM+4FSwmWNhVD8bxk8HeZJQVottH7LEdx/6W
 Rz8hMNM/VHWJYiR2ByqzAtsmJhSVNQrwsKvnxwP6KRC0hI+F/aj7WaJUWGoC3so3UbhJatagp4Q
 6c8STvFP12vruYmdNnBnpuL0HXkxH/TPqo1b1iXnGUbQ+rEQlrg+TFoTFV33c11p3sAq8LEaSzG
 E=
X-Google-Smtp-Source: AGHT+IGR4/EQGEYi9Yy6O2ik77EXVFj1XcE2SqSjV6wqDZrU6hxX+UCEEDyHblWSbmSf6PVMnF2+Gg==
X-Received: by 2002:a05:620a:4113:b0:7e3:3276:99f with SMTP id
 af79cd13be357-7e342b869bbmr3193246585a.53.1753112099467; 
 Mon, 21 Jul 2025 08:34:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b2854asm425216885a.18.2025.07.21.08.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:34:59 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:28:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250721082846.7a31ddad@hermes.local>
In-Reply-To: <20250719090537.699357-3-liujie5@linkdatatechnology.com>
References: <20250716082930.83026-14-liujie5@linkdatatechnology.com>
 <20250719090537.699357-1-liujie5@linkdatatechnology.com>
 <20250719090537.699357-3-liujie5@linkdatatechnology.com>
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

On Sat, 19 Jul 2025 17:05:26 +0800
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +s32 __rte_cold __sxe_rx_queue_setup(struct rx_setup *rx_setup, bool is_vf)
> +{
> +	

Repeat of earlier feedback.
Do not use __rte_cold except in rare cases.
Best not to litter code with it.
