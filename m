Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F227CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 15:54:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AF864060A;
	Thu, 18 Sep 2025 17:54:39 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9CF8240288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 17:54:37 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8250869d5d8so149763785a.2
 for <dev@dpdk.org>; Thu, 18 Sep 2025 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758210877;
 x=1758815677; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4Q+EkWHhUULALn2+RVbf+ofP8rDGim9UiOS7VCdR2c=;
 b=tq7fPAWYfQkVEJWYaQCge3nG+34q4amZkCmF9wpuu0PA6POnBUeSQnnuJqAuFIZDe7
 k/9J95uZD+w35PSIrG0FJq3hIh9kFqJfja8PeTuUqbf78oBiLYj8jHSgtZ9PYsLbtzJn
 yRWE7XRlxYagMnsqLoXiG8wG31ifz0jVX5xYV++vXiv/jxi4L22O2M4GHqiOG7p9VKck
 VMSjms1RWizqCTubcY3mwKiIRgyMGYRyn7Y1BpvZAUpLXyKOJ1B3JB2WM6xWrZNpwy+H
 eGkBomWIf8B3J9KaDuODMYrzqrr9CdxZudEln5og8RH77LOJREadMh8argEtk7ivmj5+
 oIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758210877; x=1758815677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4Q+EkWHhUULALn2+RVbf+ofP8rDGim9UiOS7VCdR2c=;
 b=kU90zCMuSfnXXPXA98ubmdc+Yxa92Q1sQWKTZJQfX8nfnIwz8kyIdAUnNrPrL7UliY
 XGa3FF7EaqHSKyg7oWJXYpnwqMc7fLRojOBxnRwjdiFS5JFjR+PhCAS20hh6VUoXQDmW
 fHNcQorVP7rMZ3y8joSmJ6+xRGm6UteokcrcmLHWcvb1/hvXXRHLNWpnZdRi5Skug/MS
 69qdQuwsO6jT8IHNvZRVn+q7ZUNxte8YaxTyBrSkKd6cLBPd6CyzSRMP4seO0jcP2d6I
 TTL/WwTEctcEbLaKTtvVl2n88NJy0Z4nXCM7m4bTjOs9RxlXzMALq4QOre7hYQ8ezToD
 IDsQ==
X-Gm-Message-State: AOJu0Yxaa7YoHIeF0TbxoJwHFUfdaqoddiVDh7WELuLq4ehDuMVeoOCJ
 Gv4jiDtT1r1lqlq8UsA5uDmEVHVKS3vQLpvZLVkfa4vpuE2e+T0FbFUWDxQQEgbgHTI=
X-Gm-Gg: ASbGnctj7NP/aGJAJd2s7qGAXKxiZ7GLb+qbXYcews0IpKVx/hQQhZNA8izx0W87pz/
 gORYGOZi0+41V4qiUxwMyutyW9CVylcMeg9dXyVr6+zGvAEJcfL4xd+y6j+Rtf9UJPsjhlNfjd9
 v2Oo+FoROtFVQDs+BHRQe+qOMNy4iqm/LrYOT19zxoCMW2QWHQisltcR3Mgnkva4Wn6rkNhwoqg
 F5JMi2SlBFzezt48LwJDsXZjWm2EtKgcde+WU1N/m91UfYqHC1Ev7bHbiE+KNBteDprLwPHc5Wu
 1sUKSyYaw9InqWuB9fMaStHczIkURAFKtgnqlctRma7ddyUeA/ejUH8lITeAmhtj8Rw5EdwFkNw
 6MvHBsA8MpTRy8T+yEwsJAYf2hYhorwKdp2uzoLK+MHieoLQKRbj67U92i3qsxmR5/VwIj1g6TY
 gNNXfqXubaoDBDr47vmQ==
X-Google-Smtp-Source: AGHT+IFIrkVaQoiygYKS+z69uRQknrT84MQsMEs0Eh+QpxBsy9cFVC7upGGSMWZtSEdygPJPTyq4zQ==
X-Received: by 2002:a05:622a:114e:b0:4b6:38f8:4edf with SMTP id
 d75a77b69052e-4ba69c3b98bmr84181011cf.29.1758210876645; 
 Thu, 18 Sep 2025 08:54:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-793543fdd29sm14419946d6.55.2025.09.18.08.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:54:36 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:54:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <qianr@yunsilicon.com>,
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>,
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: Re: [PATCH 2/2] net/xsc: support compressed PCI BAR
Message-ID: <20250918085433.0f3017ae@hermes.local>
In-Reply-To: <20250916100852.226649-3-wanry@yunsilicon.com>
References: <20250916100850.226649-1-wanry@yunsilicon.com>
 <20250916100852.226649-3-wanry@yunsilicon.com>
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

On Tue, 16 Sep 2025 18:08:54 +0800
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> This commit allows the driver to correctly handle device
> with compressed PCI BAR.
> 
> Signed-off-by: Rong Qian <qianr@yunsilicon.com>
> Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
> ---


Queued to next-net.
Should there be a Fixes tag on this?
