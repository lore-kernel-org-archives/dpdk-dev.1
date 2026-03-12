Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF4A106ACC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 688CB402C9;
	Thu, 12 Mar 2026 17:35:01 +0100 (CET)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45]) by mails.dpdk.org (Postfix) with ESMTP id 19239402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:35:00 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso852297a34.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773333299;
 x=1773938099; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iP3wgpl0BsdWEPdvcrGD5f89pVQxSNl2qkl46NShn5I=;
 b=gNCJ/6+lK9Hb8wqR5SS6ERSn1RTPAa+ag89xBuJjZo5GYDDjgXwbrMse9PALW+mzSK
 ZaQdsjUhdtCP5PA8NTzudnfWmYAtLFH/nUaTKIC1GQeKoJlEJtqVHPR8xsCGpjUgNGIq
 o71s6JDMxkx1FbkZ8adEKhRdnWFgYAYo/dqht8QTJYjKXCHKH6yB17HNs5zCoieGOQfG
 L+GmngJHcDj9CHjcBoWE3PP36VhwS7dRgrvr6eiRYvPcTmeACqIY1WtGMs8CWBJCjOmp
 64yeYXEi+KnTQ8h9l3HyfgCe3mJOSMhJwUcXs5rJay39dTfNlUYTNsxY/IYQpVChuNHR
 7fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773333299; x=1773938099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iP3wgpl0BsdWEPdvcrGD5f89pVQxSNl2qkl46NShn5I=;
 b=Hp2MSj59tsdbMBeRKbIg8rhbaA9WnIlQT5zErUNjAO2SM+xYt8OX073rvKUQ4qgdNx
 RbUkIbKsNUe1/oMKtlkUzWIy6cevSa+aJd3mwGySnLQeHASteVuT6s1cxSFmVmah/rpL
 wStAW7VUFtOssAKgZVCFd46SYrETZlwloaTiay9eQfwqpSaOlLumr9g+kRc7AncQV+GT
 TlUQ60jBp8Jz+zeknte2K/alAV0c3+7Iah/5L2/GML/uXJIPSwUSp7l0AuLHBW7/pSiE
 irBqEeih6kSz4ZsOkHLx/RRzd/g4zupJo1uxfNzRbC2MuFz6QkijfJA4lsYjVXYeeFU5
 5eOQ==
X-Gm-Message-State: AOJu0YyNovlx0NHw2NYqbhVbY+vF9m3NH7b/E9OYW0UbJagmm6yEwXW6
 /OmALQgCqJsWno3o6g7LtvYCvRWCeKNKeHQDTRqJehPeI68JYV6evnIFh6NnHV6WKWk=
X-Gm-Gg: ATEYQzyOvelTSX/qKNEQBnv/17sjgeUwZw2adR8mUpGtK8nqcbxcB0/IRWQcoSfV+6u
 +c5bbj35qVq3lsf7wzT3AK1R6f4p85x1GjvKBQsfeW45Qnm0IyHPr87/Rb+DVB9v+B/wdWNQgcb
 FMn3X5sPFuEOcKUrJ0wlYhkRyILn+6vHC0jpxP7o+OUrJTqjtVsZFcLcu+BppPwlhke+hlTQASD
 Lg43pPghjuI2eQ38vTpXNsR1pZrM0OyvqWDAnsfw5/QZ76KhudOdIMYGsyg2oMz+lWB9DMRXFdJ
 0Qz9mChxuhl169P352Fhn5LXaFNBuE4UjjuXoaEj1nXl9UVmvK6dO0EfAd2SqI98/rtShvAEdMx
 7NS49JOATKsQXy/rtV4dJcU12ADqaUFBNFSaNu4MFHfzeWiCRbwHQERAANj/CrenlRyh3YdIqwb
 gF4Fp1dR+Q4+jCSAuICj5cWdhfSUs9duozgFw=
X-Received: by 2002:a05:6820:3085:b0:67b:c5ef:abc4 with SMTP id
 006d021491bc7-67bda9da8cdmr22088eaf.31.1773333299143; 
 Thu, 12 Mar 2026 09:34:59 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9354e59sm3385518eaf.16.2026.03.12.09.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:34:59 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:34:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, <xavier.guillaume@ovhcloud.com>, <robin.l.lin@ericsson.com>
Subject: Re: [PATCH v3] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Message-ID: <20260312093456.5d4d2f48@phoenix.local>
In-Reply-To: <20260312073403.4018157-1-sriram.yagnaraman@ericsson.com>
References: <20260312073403.4018157-1-sriram.yagnaraman@ericsson.com>
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

On Thu, 12 Mar 2026 08:34:03 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> Enable jumbo frame reception with default mbuf data room size by
> chaining multiple mbufs when packet exceeds single mbuf tailroom.
> 
> Scatter Rx is only enabled when RTE_ETH_RX_OFFLOAD_SCATTER is
> requested. Packets are dropped if they exceed single mbuf size
> and scatter is not enabled, or if mbuf allocation fails during
> chaining. Error counter rx_dropped_pkts tracks all drops.
> 
> This allows receiving 9KB jumbo frames using standard 2KB mbufs,
> chaining ~5 segments per jumbo packet.
> ---

Project does not accept patches without DCO (ie. Signed-off-by)
