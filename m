Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E167D2ECEF
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 00:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2ECB40274;
	Tue, 20 Jan 2026 01:14:00 +0100 (CET)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id DF0854026D
 for <dev@dpdk.org>; Tue, 20 Jan 2026 01:13:58 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so8707486a12.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768868038;
 x=1769472838; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bg/lMc6Vp7+TB9sVRPL1ChCR/1jocrcyFsgca5wyIKU=;
 b=Zng10L+ekK1ZluDzNR9Eqq8obTILnEpZBT03OmolqsVN2YI1VxC9gIx6ljlwHLAwcn
 TMvKrSKhQWpKCWRMM5CCC/skISq2T5wQxY/nKotlYmwxHgR6lIQY/1Lt2AfbHmBQaS6N
 2QJxdlQXOgediNovXa2+wElzCMjYgtZ9K84zrRkdIpF4fyMM6mMF7xfePO6oBSzYXZjJ
 Yshr0NrExD4m20BYWhCm1mDGpwXKWJ9pBIPTLcukCjHyU4YspTAquaGImmVWZRACXZEh
 ctzjT8ZbtCJRejSbMlV7EX8dooyfrXp1LtkR00vy6TYAVfwulTfMhyTGEiWZxRYC6I9Y
 pkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768868038; x=1769472838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bg/lMc6Vp7+TB9sVRPL1ChCR/1jocrcyFsgca5wyIKU=;
 b=NboRyFQ4ds0JDwUJSsaL7MV6QsR7I63/2ChDjE0jbMXKeyhd05P3ZIE/7iGpSXlPXZ
 ZIHPfspXVYJHLkgv2D6yOJnIG+GNR25qrQQofYYqMywRbMnHkocZf70Y8wRxFzxnzzEt
 4IW1Swi4Yn3zbCKZhd8VomJx+iBteKmaXz4vPuGGUdtpx0RtuasUqG2cWZL1dycoxcqm
 FlXutNDko1YNx9OoIsRHxS0cvPan2vL83SzdQph61g5BfTKwJtGzO3ArP+PpXQHw5wrL
 41ldsaAaWGmODFWtHcGqSahn4h+dl8tnN5/3ROTFaf53mYges1lmvE5DvWATJIvWimFG
 aU9w==
X-Gm-Message-State: AOJu0Yw5Sdx9quBh6fL3c7UhF+vAhFiVdLqlDjPO497EnOCIivLAe2E8
 zxJBh5JYjJvtq1dtReqc6Q6CJhlR5U2h2gxOeWWJR32QaFepUDmoF6Re9XbkA0qGA50=
X-Gm-Gg: AY/fxX6pHFd3EKExuVzjFSfN+cyjJgwaV479Lp1KGpn0d+qxBnseNOQZ236Q3rEv2Xz
 nMpn8YsB8+IVqLcEx7odiwSqdyUQjmOrL1Ziwg6Tg+xLMWXQKsQNSDwM2xLL7aN+6DJ1YkMR15A
 hZ/qSTpsxWh6gI3OKRWqfoqpmVSG6X3zwADWLxIlDsaA4EthX9vzVL3FAeDAlMTkrfzsX7F+59f
 zk8br7fG6+Kp7HLn6hZh35E66GuzS/mSIeHTf70fJpvfjI2VuySliujddUMKXWaiBWtGUy2HPLY
 3vnMp3ucw+kST9gyjdrmRTBqGo21K2W26UQfAakO3F8CFeGMH+uzJG5/mTE+JEdov5tZXa/tqhe
 rgApcefv1F7hetf+SuHMoz0lb7w2lSlBsi1RZDIXHDq/MxjvNJYfDTlu4w3+NW5wdllbvONxNGR
 hd9VLCW4dsc+gX7XVaSVE92XijefDwhxFhyJSUK1CRSBqu3G+Y0AXj
X-Received: by 2002:a17:907:7288:b0:b87:794f:254f with SMTP id
 a640c23a62f3a-b8796aee903mr1179515966b.33.1768868038247; 
 Mon, 19 Jan 2026 16:13:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc70fsm11923183a12.17.2026.01.19.16.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 16:13:58 -0800 (PST)
Date: Mon, 19 Jan 2026 16:13:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 4/6] net/nfb: use process private variable for
 internal data
Message-ID: <20260119161351.20d06a34@phoenix.local>
In-Reply-To: <20260116152057.1456380-5-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-5-spinler@cesnet.cz>
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

On Fri, 16 Jan 2026 16:20:55 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> Internal structures of libnfb can't be shared between processes.
> Move these structures from dev_private to process_private, which allows
> secondary process to correctly initialize and uninitialize the eth_dev.
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---
>  drivers/net/nfb/nfb.h        |  2 +
>  drivers/net/nfb/nfb_ethdev.c | 99 +++++++++++++++++++++---------------
>  drivers/net/nfb/nfb_rx.c     |  2 +-
>  drivers/net/nfb/nfb_rxmode.c | 12 ++---
>  drivers/net/nfb/nfb_tx.c     |  2 +-
>  5 files changed, 67 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
> index 917b830283..09d4b7da5f 100644
> --- a/drivers/net/nfb/nfb.h
> +++ b/drivers/net/nfb/nfb.h
> @@ -48,7 +48,9 @@ struct pmd_internals {
>  	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
>  	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
>  	struct nfb_device *nfb;
> +};
>  
> +struct pmd_priv {
>  	uint16_t max_rx_queues;
>  	uint16_t max_tx_queues;
>  };

Where does max_rx_queues get populated in the secondary process?
What if either process calls configure to change number of queues?

Don't see other drivers splitting structure here.
