Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD279C87FD2
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 18:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35511402E1;
	Thu,  7 Aug 2025 20:06:49 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 6874F40270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 20:06:47 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso8487895e9.1
 for <dev@dpdk.org>; Thu, 07 Aug 2025 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754590007;
 x=1755194807; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OauuU6a3IZ6aRujGup5qH/nMcuk5aRxXETyjaTCQMbQ=;
 b=Oh9t07gJM5ANVqytTlkszUsL/rOLkvMUMMzggFF1y6Zxy1FncU1cuvPLoXWMdLYlFm
 NIZ78qZXVdI9dpEg4Gy8aVrMUFABps45jFCzhRpNttcKWKgCgnPBhlO43573s59juLNF
 VO2PS7WU6rD8k25lSlnlF+BinbaEAh+VyvimKoIjGZ9K82dNaJS/CS4jT1CKtf1Ewxhy
 162p+MhpZrsqA5Ewv81u3w5HRW3eytAiVIAx+TKHlQaOYhXbjAy2kfo0t8Bq7OJp+dJN
 FZINWE+MkwcfmvhkeOQApeeIvz3ToUT0wbwT99WBW7FSiuIRTW1mhKGwvs9A3q0JfaRt
 TmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754590007; x=1755194807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OauuU6a3IZ6aRujGup5qH/nMcuk5aRxXETyjaTCQMbQ=;
 b=Gs6wikJB1UEYnLBzTWL99sHThVxvozjbXz2n6zJbJtI9lPHco1Fqb1ki75DwYDevvO
 ogeiFtCCHOSMV1WoATuVJ9pfPK5kA3/ePqf9KdRzqBJBmvM2fpqswog9nInXATVkgFQc
 RhBEnyKIwhZmyCIsHP3rGou9wE+59XL/rxkTlGzxMJTQDPDkhVfXibBuzncsnh5YIzNw
 qD+OFMO/ahm8dyFuAO9tv+DSs7hbMiXCHuTvRL5HwHGYIvbZK1VX+d/ikYpty7BzZV6o
 cp3Mhtd/iKOD5TU4fihKg4zAiumkN3TsNTB+sgK5FltA4k54TfuaRekjgWOpXNo3Xh6/
 yYTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhA5iU///U8sSN1GJoBj2WeylKb67SB9Q1Dm5S3dWrM+bLJ5SFg/Gx85hBXzPjFkXtt34=@dpdk.org
X-Gm-Message-State: AOJu0YwBffBR2NztnVaR7JLiwFf+58wEvgUT6wK3bnogIbg/1mvIqffO
 ssoeGAHBT9K0DK25PcG0+u40eIRrPj8AmCKPHWUt+172wc0Go0hfra5Y/9eS39lHks0=
X-Gm-Gg: ASbGnct+vtB8xvknguw2a+p3rGllN4ege7eiuoULHLdc0RI8rJJArjH/xuGGNbrk+OR
 ylSX7EnjeufYJK12EVfgCqJpcADARUGsNNpEw2//OBFZgKhmbhg1VeorX8DLjI13+SDwDMgrgWg
 QIsJerOonSKdKTrj//rTSuoN2CIlUOtlrmS2lSDBRMHquEgSUtkQ3fLOv0ozKIkzmuAxe8SV+lC
 eAT8uUTIM162v0e76ZzIR7m+kiCaiYUCRIz13RBUWQyo0h24k64Fw18aDfovQ4cOqySfKM1z1pI
 NZsL8o9KaKzK+AyIZchUKxV6Sg/sIFu3CyuFBTQc8dM5qeqDcUwgNR28Drk34m9+Z62rYRcoBoS
 /NamezPyC7Q16/y5JX8uFkxsX+IHTApB5orDtlWtDEzdayajzAUNsuxN//pORXzoYnNcIClmHUZ
 k=
X-Google-Smtp-Source: AGHT+IEI6qa0SigVj7Svrbqh6FCsSTufnWszGwkoH+KJlB6iqjpbfuTvEbqnd5EqEJBRoVZ9HMORPQ==
X-Received: by 2002:a05:600c:4e91:b0:456:2212:46b8 with SMTP id
 5b1f17b1804b1-459e74a6907mr65710915e9.28.1754590006752; 
 Thu, 07 Aug 2025 11:06:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586eef8sm100854565e9.21.2025.08.07.11.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 11:06:46 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:06:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: Jeroen de Borst <jeroendb@google.com>, Junfeng Guo
 <junfengg@nvidia.com>, dev@dpdk.org, stable@dpdk.org, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [PATCH] net/gve: properly disable interrupts on DQ
Message-ID: <20250807110642.3138f7eb@hermes.local>
In-Reply-To: <20250804205024.873414-1-joshwash@google.com>
References: <20250804205024.873414-1-joshwash@google.com>
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

On Mon,  4 Aug 2025 13:50:24 -0700
Joshua Washington <joshwash@google.com> wrote:

> When starting RX and TX queues in the DQ queue format, the driver was
> erroneously writing GVE_IRQ_MASK to the IRQ doorbell. GQ and DQ have
> different interrupt register layouts, so writing this bit is incorrect.
> Update the register write to properly enable NO_INT_MODE for DQO.
> 
> Fixes: b044845bb015 ("net/gve: support queue start/stop")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> ---

Queued to next-net for 25.11
