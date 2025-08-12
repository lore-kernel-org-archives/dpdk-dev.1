Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D59AC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 15:34:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CD1440270;
	Tue, 12 Aug 2025 17:34:40 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id B399D400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 17:34:38 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so51166835e9.1
 for <dev@dpdk.org>; Tue, 12 Aug 2025 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755012878;
 x=1755617678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSXvfa4k1gwJK+a3IlQYP84DHK5k/9V6op3rEUd2xA4=;
 b=jAcJjoeBAoPrUHHOb21gO7IQvXojKMy2l+hNVYt44f2+3MVBANKGPTew/Av+pXBXbR
 HYiSQGbCFDKMQp4R8Cu0Hq02YGdXHGVKDAIHKexaWbbTfiVSRfBOHfpvVca1wQxHvKu8
 5U8jYnciAuM+0zsHo+rET8iSpbiFC2QVuGjA/wJpRNY6sI3tnD+Tfd5iRUQQ1MHIrtWb
 K+bho89t7Nv3pq/R20ahb5ybUc2vtEBsoTMzgWl66LgFDv3TopfCGggpHS4oinipqofK
 VvYVrZlpDQzuGyQT+4gplMGMphjL7NTN8znm5TPeIofMoBPUgjlo2F74aYfOrbTd8Aic
 jNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755012878; x=1755617678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSXvfa4k1gwJK+a3IlQYP84DHK5k/9V6op3rEUd2xA4=;
 b=xDMnD/ey8TYpt5b+3kHXdCUfyDndPqFIs+7asnET8V9nznVRlJRF++cuFXYWruoQOl
 dVn+ii5iyBHVnmRBFdsUN4yjpWeTm8rWKAz/YAfGkQGSVi3WZAVlSi+2s7XwqY7H9/u8
 1Lo0dH3ZuVm7/KPCVk4ds0TskpcWKME/2ULEepP+RFk6DVzcBldJD9a/zrwC/gcZauzj
 QKdCZ6ZkvJRYzfLPHJc/Ks/ZO/k6cee9ubCuaEn73HmzZW9mPk89glXiqBSKjeXt9TgW
 MMBtgEzFf/vTs0AomeaupDBKVvvVPLFflD1XKM+20gyt3JyvajBkeJr96vrRKUMfT2U3
 UaCQ==
X-Gm-Message-State: AOJu0Yx6Ridcoq5TIK/MuldG72nDEfmgXtG7SwH9HPgdqW4OEExNWpma
 oO5ZtDSM4z9d6drLJTK6i5+FKhszU8gVAtMKW2sAATqotY6svToaIBcST/Gn50dp4/Y=
X-Gm-Gg: ASbGnct9bwYChuCR9wJm3cOgWo4HZDAgAQD3q2CJbQieZSEmi9IAC7Uxg2LOeCDYTEN
 W+PIlT08uqMCWOuMB5wpDDfOIv7I38+5zb0fdUOUbSkHs29foo03Sj/O4l4ziF5DPRAT77lnIJK
 dbmLbtfwzrgyEoJ6nYYy6SjUIEPZfCN7nsDgN05Un8IIK4kPQrjJU/OVT7yBEj3WrrEwvVJIUPN
 FCEUOv8eekOgwGm9NNtsvNGMdpOY0Pb/wG6NFkin8JVTknZxYGagoosHCbHOggaPTC7cbrzRavO
 kMFY2Ip+a67pd36pcKayHXtqjO2pGXfvVYCm7/TxOodzSWJHXgGqm/qCJG178nvHq04Y5Rnmto9
 T1jaYdHHoAYJwhrIAzgc8GHvQYZFTnpZnn8mDWuvE24ifxQ/n9OG5dwjzsb6RRInhF92zF5sJiC
 8=
X-Google-Smtp-Source: AGHT+IEhW4E7H1YYubjfy5+axMI/yGR0ANe2pIw3qCfDbD+DzoSgD4VGuJZsPfrZfRKp8h+EbQGIew==
X-Received: by 2002:a05:600c:c176:b0:453:6ca:16b1 with SMTP id
 5b1f17b1804b1-45a15b4fa4fmr2144255e9.26.1755012877969; 
 Tue, 12 Aug 2025 08:34:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b9132f00ecsm2368401f8f.24.2025.08.12.08.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 08:34:37 -0700 (PDT)
Date: Tue, 12 Aug 2025 08:34:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: Re: [PATCH 1/1] ethdev: add link speed 800G
Message-ID: <20250812083431.6502e587@hermes.local>
In-Reply-To: <20250812144249.316120-1-thomas@monjalon.net>
References: <20250812144249.316120-1-thomas@monjalon.net>
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

On Tue, 12 Aug 2025 16:42:48 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index 5d7fc5ee9d..d23c143eed 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -306,6 +306,7 @@ struct rte_eth_stats {
>  #define RTE_ETH_LINK_SPEED_100G    RTE_BIT32(14) /**< 100 Gbps */
>  #define RTE_ETH_LINK_SPEED_200G    RTE_BIT32(15) /**< 200 Gbps */
>  #define RTE_ETH_LINK_SPEED_400G    RTE_BIT32(16) /**< 400 Gbps */
> +#define RTE_ETH_LINK_SPEED_800G    RTE_BIT32(17) /**< 800 Gbps */

Do you want to go further, looking around I see roadmaps for.
1.6Tbs, 3.2 Tbs, 6.4 Tbs (2028) and beyond.

Looks like will run out of bits in 2040...
