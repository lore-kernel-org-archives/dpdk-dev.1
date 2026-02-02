Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F55EE7DF0F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:53:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6D0D4027D;
	Mon,  2 Feb 2026 19:53:18 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 4E2A14026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 19:53:17 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-481188b7760so31943235e9.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770058397;
 x=1770663197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQsjQA19QUFuM5fqdO5iLs29hg8owZE2hkUxMvdwfRE=;
 b=ABKOlDhwVeK9uSFShMrslxG5Cy0xFjYHTwMnay+8tigFkSR/3sUFeHbsjUu14SAR9R
 oXUrwLGD+F/VJdstfPI7Os4FEpWvYEjfjjDRuLwV7lMp/lVt9J86Ex375ou+ey4GUlSk
 3MlHwXAitotlGtT1z+V9mZSssjK90IUy9GuWPDKrwqiRMFtFR1nEClKksuaTRmPL65g2
 04wPG8RnnqDQwB4ywnAYTQI0s5Es1eI/Q/KBndC7mui8EfdCRDlITb6qC153oo4e8557
 xZek8caIMqNRjTQrQeSea14iNUf/4E2c40Sh4knkLyzB/Za8smtCcolwzqpQypVn9R8O
 DhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770058397; x=1770663197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQsjQA19QUFuM5fqdO5iLs29hg8owZE2hkUxMvdwfRE=;
 b=jrKuTGojcxtggw8Elb8FfLfBatg8hdbP22dcqO79lCJhc2UOdgf5fPDWRhYJ0PkVH+
 NtsaPYi08BykkdZtgWZLhPncrMybaBppND9NNedmmoC7pJgAjENsaEETfibUETxSC/B8
 R8topeWFF/8zJejTiws9kpNL+bn2xjV9YB7jvHqfv+gHsPH+N0PbWqya93EbpxGlUHcu
 bO/2HcNtJ9brH0m+V0rUh6P7DHK8cej34TWg1NfETgJG25D/36cbk3EFKVkA2mU6z8MM
 giFILg5nWx/wLVtAHTp81vZ6pQrGTt6N3dQAmkRy0EunwH+OsNrjkTCTnuhzq/y4NvnZ
 HOzw==
X-Gm-Message-State: AOJu0YzhrcCwllH1BLKFpqtSCMDOg3OZqH2fzUG/TaGbv+u0w9Ta9sTT
 2lPxVOB+S2QWkHinaR8VzAkekvMzLqI6slBpbBMKlS+SlG0khUs/DE5pcYDuqqs6iUk=
X-Gm-Gg: AZuq6aIplPnzWCfWZ0xiOgZsswVmSkwjOe8IYbCoWsEA5uaK17XhDRPnBuxbXQO/VC+
 HbvL6x4yYAVe5S/kd0lQg5yRDsfSrkoVaWvdZMhWPtcY6bhQ7gr7Jf9A/0erTxgLNSNVpOB4aFG
 MHhB/39FN8t9iSFshOnKcsRJRI7Eq48rozzdZPKcOzlIAU40Z0WttfpSYtgWLnDH5Ud9uvdypXC
 DnMWliyqkp/fOD2oJQtTQV8qOQJiRksm0t4x6L7WlakbF65oGr274PpxH14PKZkwWDqpA74/5F5
 GwaNo0ctKuyThyOpSBsjYQyJoGXoFJf48Ay+HU4uK18n+kaVvYYCTSOqj6QGXdfb6mO+5pSXLxF
 N1TInr4CFFN0UZBxqlQ4l77xo6MEN1TbCtGXRFs6hG3fWM9yFYx+DALZ7KFmlLMRJKMy23ztOQO
 IFSkEEg2AutPlwug4gYzEDxofTbW/FdmgZadz7nCO4YacDTH1fBTo2
X-Received: by 2002:a05:600c:3b23:b0:480:52fe:58f5 with SMTP id
 5b1f17b1804b1-482db4a01d8mr191486065e9.31.1770058396680; 
 Mon, 02 Feb 2026 10:53:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305161a78sm7610235e9.14.2026.02.02.10.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 10:53:16 -0800 (PST)
Date: Mon, 2 Feb 2026 10:53:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/4] af_packet correctness, performance, cksum
Message-ID: <20260202105311.55e86cc8@phoenix.local>
In-Reply-To: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
References: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-1-scott.k.mitch1@gmail.com>
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

On Mon,  2 Feb 2026 00:14:52 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott <scott.k.mitch1@gmail.com>
> 
> This series fixes critical thread safety bugs in the af_packet PMD
> and adds performance optimizations.
> 
> Patch 1 fixes two major correctness issues:
> - Thread safety: tp_status was accessed without memory barriers,
>   violating the kernel's PACKET_MMAP protocol. On aarch64 and other
>   weakly-ordered architectures, this causes packet corruption due to
>   missing memory ordering. The fix matches the kernel's memory model:
>   volatile unaligned reads/writes with explicit rte_smp_rmb/wmb
>   barriers and __may_alias__ protection.
> 
> - Frame calculations: Fixed incorrect frame overhead and address
>   calculations that caused memory corruption when frames don't evenly
>   divide blocks.

Fix patch 4 and resubmit.
