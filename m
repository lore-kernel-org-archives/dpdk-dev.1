Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A1C28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 17:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01E5740656;
	Thu, 20 Mar 2025 18:46:02 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4C84E40151
 for <dev@dpdk.org>; Thu, 20 Mar 2025 18:46:00 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-224171d6826so30979115ad.3
 for <dev@dpdk.org>; Thu, 20 Mar 2025 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742492759;
 x=1743097559; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXrZ10bTXpeGbFbJA3N0wDVDgdMrITiwlSs/wx36Bu0=;
 b=sJQ+ZbhZ2w0yBJhT0uWu7KPAAkkZ6PmTWjICpqlhy0a233BOFxjPpLxSAPGwaV4Zar
 epIZyVTLAO5nYb8gsS5PcRtc66EPKi99KwQkpmH1/NzbKPnqfWxGKSLvDtIoPkxC5d3r
 5zfZSA7Wsk2764jg5ou+vCle8T1DtZ+gJZF7fxg1/wGsobuYeGyKcInuJa9FgtjmYE+F
 XuNmHg8Ipe+WsVi5VK6RfjgOPIZLghMJzu5a9nie2NC81xeXn1dmVCVjYQHCcXOhdd15
 6ZQ3narwuCTEMsknLbicOSEYwqyoIYd+f2/ZIHPNZirZ1IEKw8Vx/wyQ9I6yFvFbTaj0
 OClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742492759; x=1743097559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXrZ10bTXpeGbFbJA3N0wDVDgdMrITiwlSs/wx36Bu0=;
 b=WsyMvVAk592JVMA9ox90dDJTp1n7mP0046RSLQCgwWhUvgVd9Oruh6h79dFaKP3H9W
 8ghrcpIcjbO8kXaefmD0VQ00WY5EGg6umhgBXchxfGs7UStR10tSDm82vSnIulwfnhI8
 CvRCiMEUmiynMCuNCOaPcHn1/tCiZrnJvHhVxPMhYvnRp67g9hXz8Dyy1uhgtzvoB2uh
 B1wK7P5RIx5sWObPuQHgMezCZPAZcedjLPHj7W0e/eGuT34JH0Ou4CvZwfRxMBOlWwx+
 21/czCVe4xXzIcL9Q+JdFp074zKUY0ul3xbZRvjpdtacudaeBcBbIU4h5EtefmiPS7pE
 0RAw==
X-Gm-Message-State: AOJu0YwuCzYvpLxhD63c0QAxD/6m71gdkaJyBbK++wbL6kIEkSAIA1d6
 pIvR9P6U8dheHMGrbeKFtY1X7Kn/IYW/1H+QtekRZrTXOPEx1ejwYaxr1pA+76c=
X-Gm-Gg: ASbGnct7mZD5dDYZzbZoK5lHqlY+L88cGT/wknr3w0Txlkc8urW+CJVAPpu85fzMo5o
 9ibPdecF1tO9UTQ3aGnYR2yynTikqnlM5kldfPc9zxfK/t+Gf7WDcWm26RVftJ8DGFbJpyrw1y6
 DP+zLA6nmylv5+Y+mHFGhJLzrh0IN+D/cSXGSj6OjDrV1HEW2rLPppwqMdyXVAbkfK/PGJERUaJ
 qhnNHjbpLdRhV3TSWcJuw3m1xArp5qOu8f2s1C4MkjGdv/ri5c10n6E3xXWmK6vRB0XODnhYklU
 QGCgDzZk0ZXvdbTGl96Tx5JMGMgZlSehQJvIb8qskmtlJ+0vneLBB/Zz6FU6VNdK4O29eCOCVlC
 wf8smAV4YOa2n2a0DI3RxMg==
X-Google-Smtp-Source: AGHT+IFJuKS5J0ZAg487sASPECWb1z8z4CsL4koP9iGMXpPYNSx3BKnnnggaakrsqv8KPNRGLjmG6w==
X-Received: by 2002:a05:6a20:258a:b0:1f5:7280:1cdb with SMTP id
 adf61e73a8af0-1fe42f2c9d0mr519555637.16.1742492759267; 
 Thu, 20 Mar 2025 10:45:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739061562e4sm65636b3a.139.2025.03.20.10.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 10:45:58 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:45:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shaokai Zhang <felix.zhang@jaguarmicro.com>
Cc: dev@dpdk.org, linville@tuxdriver.com, stable@dpdk.org, Joey Xing
 <joey.xing@jaguarmicro.com>
Subject: Re: [PATCH v2 1/1] net/af_packet: register supported param fanout mode
Message-ID: <20250320104555.476b834e@hermes.local>
In-Reply-To: <20250320083707.5594-2-felix.zhang@jaguarmicro.com>
References: <20250320081503.5505-1-felix.zhang@jaguarmicro.com>
 <20250320083707.5594-1-felix.zhang@jaguarmicro.com>
 <20250320083707.5594-2-felix.zhang@jaguarmicro.com>
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

On Thu, 20 Mar 2025 16:37:07 +0800
Shaokai Zhang <felix.zhang@jaguarmicro.com> wrote:

> diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
> index ab34285ed9..55171944cc 100644
> --- a/drivers/net/af_packet/rte_eth_af_packet.c
> +++ b/drivers/net/af_packet/rte_eth_af_packet.c
> @@ -1172,6 +1172,11 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
>  	PMD_LOG(INFO, "%s:\tblock count %d", name, blockcount);
>  	PMD_LOG(INFO, "%s:\tframe size %d", name, framesize);
>  	PMD_LOG(INFO, "%s:\tframe count %d", name, framecount);
> +	PMD_LOG(INFO, "%s:\tqdisc bypass %d", name, qdisc_bypass);
> +	if (fanout_mode)
> +		PMD_LOG(INFO, "%s:\tfanout mode %s", name, fanout_mode);
> +	else
> +		PMD_LOG(INFO, "%s:\tfanout mode %s", name, "default PACKET_FANOUT_HASH")

All these debug messages are too noisy for my taste.
Should all be removed or made DEBUG level.
There is no point in echoing the arguments in a working driver.
