Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840FEC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC3F0427B2;
	Thu, 17 Sep 2026 18:19:20 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 74E6E42ED5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:19:19 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39e03468a5fso928561a91.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661958;
 x=1790266758; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ONODqr9IYJ2jSEcVcTe9tglpIdNoHl0veS7q+CyCfSU=;
 b=tL85DgDMrKEVtGsu8ZquV4Wd/8n+10r4qrQCvev8kWNtnC824XoRBlq4Sb/HeggOAm
 o8uiUgB8XA8fM3ZGc6rLdbetUtuwyeiY/802lDw4pJcaaUFsIjvusrVlge1Yt91xftMY
 X7J16SQrjBnHbdOcfVsxoijWTuCf3zaSViugwPJj58HHLbP/e4tSaoxuHSA+y2upqd/u
 PBawFxc1MprvbSiopg+bgKihxZjWnXVrqeaeV5IpGt+kpTENbiVdlA8ZM3wPA5INE3jf
 2EUoDBK1LpPB6AUzTTn/RELL56xrdVdi1zChgUVT9j5QmN74/NhKl/4dCTeFoGvZuzlv
 bRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661958; x=1790266758;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ONODqr9IYJ2jSEcVcTe9tglpIdNoHl0veS7q+CyCfSU=;
 b=2QpTYjhvuQd8ycJ8sV6nk19j+XGAxpUpZfIeR8wxUFeDfTmQjRWjKPOhEaFywQGyOf
 NUVDb4g5VT5388KEqTZ0I02seXQnQqrK+Q0nXGkXbYAxAm7y4CMyL8OkiH/AT7GcjfHI
 +HwOFUfTDc6cA5SWT4tLIiJgPRy5Hi6LiAq5ZrtJa0hr4wd8dMc1QudQR1rlk6Ojj5n8
 nT9Fckm7Pt8/nn1zhaNzFuvHdHcpFMEaAGsU+6OoC5pKdtkQ0S7rO2rkVwQCyoDvOijU
 Y0162U1N7cnZPyn2f8p1JHkBd2ox2O3a8TBqAXf2skytq82nJji3+mYVlOgl879hz+7u
 XwZQ==
X-Gm-Message-State: AFuF++k5fAfrpDLppPCLNBOY3vnY+TxS4EdrN4lN4FdWxtZ3TsGcIkor
 iQqqk9NQ76rEFEaZfGJtJYJCglLuFQ7XxvTY4eVRgTAEQtMh69tIMXmXFTNq00JedjQ=
X-Gm-Gg: AYBFou2aVB+3SRXt/x78td5BQaVL+pFoHgvnR/PKVYWkkyDy5s1ifm3UORKCtbAxqYI
 mvYZ2pemMNhJNaSEJZLnC343xZ0n7TGrk1P54HrVRnhxIoq3GjXOF62gdTkLkz4/7mErCk8X1nW
 l0K/7gJWmjOsziYgeDszWIDoXpPJnEaISkSP7vcWL8VdlKKKnxHth3BrcrT6l3E4nsGp5pFf8uL
 p7lJcF19QA5sgPyXgDvSFtjiH7PFqyNMSZUUBkdWwVzek58h+uhHFDlFAIN97wWEGog2x5ofiOz
 /MLZ5p/ofOV2oNK1rNWj3OgWn2XWRzscAMAE/EaLfbz4flrFaCtSxtxKX4cHLMwr3riU6G6xvKl
 k2zN9NObrqP4uzctu+nNhIrQ7/KK8CJW3EoiRbxoYEJ4pfKSLi5HoGvg0/Mfp/zLb8VY+A/qSIC
 erufLbyMBQh+xRhw5pup7Kdnw03aVbwik7GW6OGkbYhoUclGGUEU9QEVuvDc1fuxLMmv8izX5Ik
 S5w2zkXvmmY2azHKND5mz57nUAkpDyfTzqOaO4uVgkCFqAt18M=
X-Received: by 2002:a17:90a:ec83:b0:39d:eda6:8a0b with SMTP id
 98e67ed59e1d1-39e1e50af4bmr16872864a91.21.1789661958563; 
 Thu, 17 Sep 2026 09:19:18 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:19:18 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:14:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, <stable@dpdk.org>
Subject: Re: [PATCH 03/14] common/cnxk: fix NIX QINT count reset
Message-ID: <20260917091443.0649942e@phoenix.local>
In-Reply-To: <20260917071016.2366467-3-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-3-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:05 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> Fix QINT count reset on NIX queue IRQs register and
> unregister.
> Queue interrupt will be cleared by individual queue
> interrupt operation register update.
> 
> Fixes: f6d567b03d28 ("common/cnxk: support NIX IRQ")
> Fixes: 3c100e0e6b9c ("common/cnxk: support per-port RQ in inline device")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---

More detailed AI review:

Patch 3/14 common/cnxk: fix NIX QINT count reset
------------------------------------------------
Warning: the inline dev path now clears QINTX_INT with ~0ull (W1C),
but roc_nix_register_queue_irqs() still does
  plt_write64(0, nix->base + NIX_LF_QINTX_INT(q));
before ENA_W1S, and roc_nix_unregister_queue_irqs() does the same.
Writing 0 to a W1C register clears nothing, so a stale QINT is still
pending when the interrupt is enabled. Use ~0ull in both places.

Info: the roc_nix path uses "int64_t val; plt_write64(-val, ...)"
while the inl path casts explicitly. Pick one form.
