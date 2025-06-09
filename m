Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C631C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 17:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6CAD40E34;
	Mon,  9 Jun 2025 19:12:40 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 18AF74064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 19:12:38 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7d094d1fd7cso601365485a.3
 for <dev@dpdk.org>; Mon, 09 Jun 2025 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749489158;
 x=1750093958; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/pWDK+gcjVjOWNtXuumvQ/p9SBeNpJEX3MDASxFzQ8=;
 b=wwHvYbSfwY2hMBJudCJCRhad+e43Sh7UOIIwRuEqsPsiWtp6jyJft9r0m5UxNjfqtm
 /AEgEXBhAhQlRCMaAp1jUvd9xsBHd6D384DjKPxB8QzCf/3d8B6TsN239TSj5bNk/qGC
 axXD9qN+BpGoUWJnmHtIy0iohpko3EhqUrFtHnSm/GRD/985BYdiq3kJ3RnOdkNSQhlu
 dGvBpy6MXwlYCXmILHqFykxzt45MduQiIu27+TLsVBLLtzDiiV3UzSI7gk63pSJKyEZN
 2jBcNpPGEz2VplXAsGiFKD0u4cnC5x+zjQlhoRQOq2FTNrTqqJhGN+3C7QP/CU/sfUY4
 80xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749489158; x=1750093958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/pWDK+gcjVjOWNtXuumvQ/p9SBeNpJEX3MDASxFzQ8=;
 b=EO0CxnrzhV6v1z6Ira1/ZxN4yTJLRIFy/OCIwHMp1L5VdN6AVgJ82QtbsttJvK9auo
 eroYMfTmGKUsArvdEd0MYUK6cW50jhjny1lHDUAT12Q+e8RBBzn5jePzIB4s21n6jYOi
 yvEB5Zdk5ui4gkv6irqvoCpIG2U7h0MAFsMIThO/9W3rCw9kiC+RNU1gxiYGfy3bCmfy
 rR2972/vYprLlpX3LSXWpDNViPX5rCc5Tsafb81HdcroqM55+Q7twTmhq5MCxZhi6gO+
 UHB4IaBYiM9Ge40mqoCn/kQv9TpLeacjLdUwujXGEPma7pUOK5yWiHIMvAvCQR1ppDXk
 MuxA==
X-Gm-Message-State: AOJu0YwrjaaBJkzNrY55FzC3KDwFFPttMgXax3+liFvMf5q89IGRXT4f
 qCzOBiqoDyWf2FHgMUWMgDrn+pZ87ZvnVWdgVPUgL7fgouSI0LXlnWrpNmQw9JNjXnhlpThiCCA
 ttfAa
X-Gm-Gg: ASbGnctgfKFe2/wKcJYM920r5w5c2dv5dvqMPcO3Ktv13CZFBTT93jk8QmxLO+EUjEY
 VPE2W7l5CD0LLlg6d0WOUzmJv4N+LuaEP7HhW4zFuzKr4nR98n1joric7XkbwSKpd1iaTSn1mi3
 JZqjKZiuhibec1/5BjaJeDpsVpGcecpmHZzRkSIyKTVGZS7M3m4POuNqmlyj24Ey6VFhqPsTXqz
 2gNKU0uJ2iciOYd8clgvdKgZWvq2Fa01JrKoen9luTzUThWG930kOLLiOv7Ik4Z8hpAkAMbEY19
 9/lUbMzhNfNE4qA8EXGpshO3321gww77/vxCOl84trHGvK61Jp7BYIX0LuvLzvQzTTIqp9CX5oF
 4Hcb5xWNK27Kc0z+hMunnYUn1VAXayriOn7obvio=
X-Google-Smtp-Source: AGHT+IHMC1FOW+KCMnl07qJsbeaed5kRQFYP1mfGjWnOoIbpVxuE5zDg8C5lnWPRcRbOClZ8Y15mjw==
X-Received: by 2002:a05:620a:2b96:b0:7d3:91e1:4f8 with SMTP id
 af79cd13be357-7d391e109bcmr721622685a.24.1749489158348; 
 Mon, 09 Jun 2025 10:12:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d250d7c399sm568150785a.24.2025.06.09.10.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 10:12:38 -0700 (PDT)
Date: Mon, 9 Jun 2025 10:12:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
Subject: Re: [PATCH 3/3] net/hns3: fix can't use vector for Rx when set VLAN
 filter
Message-ID: <20250609101233.73a05aef@hermes.local>
In-Reply-To: <20250609130651.2752977-4-huangdengdui@huawei.com>
References: <20250609130651.2752977-1-huangdengdui@huawei.com>
 <20250609130651.2752977-4-huangdengdui@huawei.com>
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

On Mon, 9 Jun 2025 21:06:51 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> Currently, When RTE_ETH_RX_OFFLOAD_VLAN_FILTER offload is set,
> driver wouldn't select Rx vector algorithm. Actually, this
> algorithm support it, so open it.
> 
> Fixes: a3d4f4d291d7 ("net/hns3: support NEON Rx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

Mind if I reword commit message slightly.
Use past tense for case before the patch was applied (old)
and present for case when patch is applied.

When the RTE_ETH_RX_OFFLOAD_VLAN_FILTER offload flag was set,
the driver would not select the Rx vector algorithm.
But this flag is OK when using vector algorithm so remove
it from the mask.


