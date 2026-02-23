Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0CDEEC2AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 23:29:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2376402C1;
	Tue, 24 Feb 2026 00:29:18 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id BEE0C400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 00:29:17 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso4692319a34.2
 for <dev@dpdk.org>; Mon, 23 Feb 2026 15:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771889357;
 x=1772494157; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N95dKycmpjNscQPtA/cGqlSea7A9+nMbRUsGZy1zUkI=;
 b=AaLnVKnOsNkrsygxwnxmIamIgtrmBx/p5Ur8ir0BCKXlAGOQ/QTBz2ovPLzs46h6pe
 8VXVUNqOw7qoo9+aAGaz1GuVFEJUIaY+rIRSqelg3SeLzDKm34rhlMQf1p7ndOhq7ruD
 5VzmPZwNBAWpiVnIzQshAhgJ9A0ouSJh9hElwWQ6OnqRcESuZBttdFf/IVlVSz9e04NN
 b6Iucfya7Imi4ArRD9X0wTz+dELTaR1MG7t10AD42fsEX3lYAPYfDUUpHWVY4t1NiQPe
 q2zUNdAQPpFTaWHPrIamdwHzxM4UmdAwZNC8WQ/5+KLHQkp6q0cvDqI7P6oocEhOnPC/
 luCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771889357; x=1772494157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N95dKycmpjNscQPtA/cGqlSea7A9+nMbRUsGZy1zUkI=;
 b=c3qWYN+Flso/zcN0wWOzN6tTR6yG7ldloWyg2Xzbjq8uVHqDuTCNLAoNB+7NcJyQnC
 tI0gqp8n4231RaUSSZvasFM+KjEwoxdwCGVnUKtg+ZMXZCNco7uhh0eZHbLV0mfijPxB
 GEXj71F2yGkR0Aj9/U1SAaOQXSUdgf6vfBHdFzloiM1eWlZHOUMm1S+UgmBTSB2oGE4Y
 e2cIZI0PjQv23ULU+8BOMHZIryUCAXGE9BUzbcnb1hwLVVB4CBlCz4hapfCEBUcwqmOO
 CeYhXKL+NcsjyIaS4l/cpikvoXpz+QhqewnMU/DGU4XRkFREEFR/5BW2ObFJ2TDSmWdl
 Medg==
X-Gm-Message-State: AOJu0Yx51b0uzgdIwjNzGiGb0qp/FtR0TiuSRCoAs2lVS0ix8g4RmrRP
 Y/pDnVw76IwujS+8HvDHxrQvoASLykNHGTGRR62HKo7yCCzOMDz2D3F0qpwc+FIDZbQuYsG5r2P
 EugOe
X-Gm-Gg: ATEYQzzCMpjmIvGIjXaGo2KYmTYEaEDR7SdGZx1devWDTm619rTU81ccRwlkt7nQf3K
 9hfESgevjYU1fiIOKmhnxGv6gs1ma1nOjDSvJE4DKAClipBVHvhLhWfDJ41fXuRrLBMCg17OAU5
 Schbj3JzralG9flBWuTYTiw9n3PwWQ510sfcjqYN2e8+u5bicel9n8B28w8qFrxsBTc1LofNlcx
 6mn69Ho4WXkYigDkDp/3xBDVShoFdJZsgcjPn3sNa8oavjvBc3JwFAuQI+0XvITjVKIVCj4eb/7
 0nmQ1MXdSm2qJLnpuzh0IvA/F2Xfit7tQfOwA1M+YSEwYYS0sLAjW4Z83Hxtb74RCB78TT3csGP
 k3TF/XugMl6LHMgPQP1Sf5xD8EDfZOArPJ4C/g9tw4MLjBIdCT9j7I+TY9VFTxdVIyxwcO0b9uE
 fuIU9oevtT+i+fbkTFqBvasvWG3BielBDdWjK/zvxIWH4YDGTtCmdpf0EEKJhYwSNA
X-Received: by 2002:a05:6871:68f:b0:414:93cb:b992 with SMTP id
 586e51a60fabf-4157af9dae6mr4737571fac.33.1771889356875; 
 Mon, 23 Feb 2026 15:29:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfa6624sm9927765fac.8.2026.02.23.15.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:29:16 -0800 (PST)
Date: Mon, 23 Feb 2026 15:29:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/vdev_netvsc: block driver in github action
Message-ID: <20260223152913.6d15baa2@phoenix.local>
In-Reply-To: <20260223172137.93558-1-stephen@networkplumber.org>
References: <20260223172137.93558-1-stephen@networkplumber.org>
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

On Mon, 23 Feb 2026 09:21:37 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> On Hyper-V systems (including Azure-hosted CI), the vdev_netvsc
> driver auto-injects itself during vdev bus scan. This interferes
> with other tests.
> 
> Suppress this by detecting via environment variable.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Sigh, this won't work either.
The problem is that the CI runs tests with sudo and that strips the environment away.
