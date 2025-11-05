Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F318CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 06:52:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ECF7402B6;
	Wed,  5 Nov 2025 07:52:42 +0100 (CET)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8678F40269
 for <dev@dpdk.org>; Wed,  5 Nov 2025 07:52:40 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4e88cacc5d9so60351151cf.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 22:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762325560; x=1762930360; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUh+Lcs44Vw+2a/UUN3IPvRqiTP/TbQp3Bkf/yQJb9E=;
 b=lTHRWBS02jNAXWzrEosO/4x9x2ZdcKkN+9OOK7kJFjrDxR6dcFC/bkYgNXLskp/g55
 9mR79ODpg0lVQpfnXCh8Z3WK+bpqQT4IX2AESi3FFo8usKcLx+X7HwsKb6aWjDtJKu9L
 QWn6kx/DDxOcssIo6nPwKogsNGPz/drlX8Enpcl43sDXBMEyVKrASPmgVrKtCYc9CY7B
 AyXgv5VYhC1qkQlvLQRSz7ZREDTtu28suDYF1xLO95QOwA4MNXGBZ6O+StaBYkwl1i3Q
 3wvLPZOy8CUVj2t0IucSOlFOECvHxHcjjJJqVjqhgcyqLx8lSN741sCHji4wFIWxKTAp
 NanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762325560; x=1762930360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUh+Lcs44Vw+2a/UUN3IPvRqiTP/TbQp3Bkf/yQJb9E=;
 b=H5HwAHSidKnwTTzb79/0OeTFhxlRzIkbSqLwZsTJAbW5ITJd4YEI6NYg5lR3popOrV
 pfnI8jjbr6Ya/mETMkqDo9dQHgUBasKSUHpcQ1Z3RPZP9jHYWcoE1lrhaKr20+NCpM9Q
 wvdYS11uJG7NyNLYNLmpVU18zJ5GDfSXHwo8uhPXNFdvbDnvYsw+/TMeBuxEVPpV5uFq
 WagmOS2BqaJlQvkn6zX24ANVOf2TYQ4HW6m2rN9PCn3YvRAWglLEYh00P+fe8+73EI5x
 /ZQJxwjT6SNXgGzFTxE4dxEnA5/DGuKVYJwzcb0Ho8zQ1mFoRxE9bjptVqnuoai90lD5
 zp2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/5UE8T7QXMNVS6Rji/0j10bpPBa+TsqKcpZK/2usTta/Y76C2cx3dUY9sMjhq0J3q8tY=@dpdk.org
X-Gm-Message-State: AOJu0YxFCLXYPtZJ4NChZBFbpGQ8dC35FFoPH6SpbpBZDKiu3wJiRTGV
 wGbbGgJw2oZ96ycJEo7QM0tYr5qYhj8OySpd1YqCp3Hd2d0FPIiq21dpQeqh0QpzyPYyjKRblpB
 7i3SNfb6KT2halVN8hbd1BzlbTpTYAqc=
X-Gm-Gg: ASbGncs/jfPBFf+SuXOJgiHwzyHf3hVGvkmLM8E/QkcKhS51xBisif9YeRU5l5UkFTA
 +5K5uwVIh9XLrsCYqCr0CoCn22fN4V1ZHlkaQdiOkBVp2oxpOVbYS+LKv0emp1kk55vkaXqFYuR
 KIDVHlWSiYPODyVH6NfjJR9neF8uNFLhe6FMIiJ46peQZvmoKcGkjpHJDEzklm9THioZMKCvTLd
 xmD6hkwv3GLDC6MdZQLMSe/9Mhit3RWsO1BRUgSXrrPiHk2YaADW7LPk8E=
X-Google-Smtp-Source: AGHT+IFD0uzks4umerPQK98CFVPN4r4DtKhqy1Kvt2dPUQQj5dT3zLj2L9eDxw/XwhNSkzbEK10qBQXEvVMF1GCB+k0=
X-Received: by 2002:a05:622a:1f0f:b0:4df:504:ef88 with SMTP id
 d75a77b69052e-4ed7236b1famr33120261cf.23.1762325559693; Tue, 04 Nov 2025
 22:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20251023110332.6231-6-skori@marvell.com>
 <20251104080901.1610706-1-skori@marvell.com>
 <20251104080901.1610706-6-skori@marvell.com>
In-Reply-To: <20251104080901.1610706-6-skori@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 5 Nov 2025 12:22:25 +0530
X-Gm-Features: AWmQ_blG3oE_If_Wd40t4Dpj_qtrERqXBQgvHjanobQ-ZojxWuAQNBf5fa7fcko
Message-ID: <CALBAE1PvLXi4AHQZE93hApC5mdOSXT7_F3HSPEsLtABF1+cSuQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] net/cnxk: report link mode
To: skori@marvell.com
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 dev@dpdk.org
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

On Tue, Nov 4, 2025 at 10:36=E2=80=AFPM <skori@marvell.com> wrote:
>
> From: Sunil Kumar Kori <skori@marvell.com>
>
> Reports link mode whether fixed or autonegotiation
>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>


Update release note for cnxk PMD for this feature and fix the issue
below. Good to merge the next version.


### [PATCH] net/cnxk: support link mode configuration

Warning in drivers/net/cnxk/cnxk_link.c:
Using %l format, prefer %PRI*64 if type is [u]int64_t
