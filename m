Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F56CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 15:44:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 914BC40659;
	Tue, 19 May 2026 17:44:06 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 1BC47402C8
 for <dev@dpdk.org>; Tue, 19 May 2026 17:44:04 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1357c851a48so3580579c88.1
 for <dev@dpdk.org>; Tue, 19 May 2026 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779205444;
 x=1779810244; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Nr8AawJhPOIxnQ3r4XmWapDhgZLtX/NlKPL76uHA3s=;
 b=aHUPsRJ1ZPLN7NTo48RpnkXtPlYwAD4c6ye04hSY4c2sQ1wjpOmcp9JBqNvcs221Oq
 EgXS+7i9+JHdm0DrcL3PKYRItEn7SkYgAtitFodtyAbWqN7GK2AAMuRTbz8dHIsofhwg
 lWQV9DFH2mXptSsBJw2zWseY8jfuxfrvNlRyHmarDjgoHCXIdKmROSbk+rk6SzFSMD2n
 Cfn5Bj9q7X1tAqx+wxEaVIDuXUVXLWW+t33PhiGDqG0Rfj3sV+11taMo3wD0I7f0awX9
 /r9KRqwRacczlqYZj6FFL8AqxuFRmkvJtHb7vDnk1hIoOQc86RK9A5U2uhcihCV6P/WV
 j2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779205444; x=1779810244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Nr8AawJhPOIxnQ3r4XmWapDhgZLtX/NlKPL76uHA3s=;
 b=PVcKpn/WlijVQ9ai1iotusNipeo42cGYXV9HwAVhjXW2POnpVgU5fAu71BfXGpAPkf
 XcqLlVhu8GJBL1cJOWSihJlyVaqns0eC1IsOr+qTLAA4j12ZKqyYgOfnaR3fItYJea5r
 R06h3uFqB3BmWnNV5G6sA+uyNiOaE9loFCkqvO1YTcpskHrhc87vi6sYdVQirKqF3SGk
 GOdPKIvmI8gFBdqwo76FucLMYKS6n6jpvSEPd2a71cvvWDoATZIyVeeeABSut8Xgen1+
 hf02XREQm3M1Zx0Y80bTB/gsHLz1PrhtkfyEGG1hRapbSUV9ckRLOQENcqkoZ80jfnOl
 j1+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iyY4FGmzo0EMHDBZD1ZyMuuMeGiTeQaMgsaqYPv2V06x1yg9BAj1N52pLL3FKaxnP3P0=@dpdk.org
X-Gm-Message-State: AOJu0YxxAHcOGiBBxIq0Q/OIkLZXICNeMit7axMalSRr4NwlM12exRQ5
 qZY//S9YVfR4kxUmgjjFk2sBhFP8OxHeaWhWKHFB8IOew5fdPuLltQvf0ueexJIrB3U=
X-Gm-Gg: Acq92OGhw/g8JK2zTG95DnLQJZ9dU8PR7DzLFQBV7chUgTDJq4WWdND2uh/JIzPHgLe
 YQJg2wXTFRv21X0Rutt0S7UnU5pGUsmTwVNlMt06zqI6EJMNgPSHubtreuuZ8sVnNtGrcORUly0
 RMRsXNxmrVj4MMoJbZhfwamF/M9tUal/jvkQ2mdcSCI0SlW6MJNhQov7NTykUWf7o/JCdlU2Uou
 qB3tWTt6S+ZSS6i+3W2rm33jgoqvd/h8j4uJUUnsfSCt4zbxbomJ9CCO5Pg6rNYVCHzayfBA6SV
 kQQS8bcBYKY13HX8Hb3qdJcXv0nxTjY2zCVLvMF2lNjrhFJVqtXtMzdG8KMAne0n5SwtBKh6LAv
 4IeX8EUjRIx7QCN+6bm+FPhj79rnH8uv68q2rFYEFyH6RmLif5mDehPzEzKxrfg3gl4n8msV461
 NWIrF42ATTtAGBlhsWzYySAevjDe2TckPGeGCBgDxFFETjww==
X-Received: by 2002:a05:7300:3b20:b0:2ed:e14:42ea with SMTP id
 5a478bee46e88-303986bbeddmr11200467eec.35.1779205443725; 
 Tue, 19 May 2026 08:44:03 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm19536595eec.5.2026.05.19.08.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:44:03 -0700 (PDT)
Date: Tue, 19 May 2026 07:40:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Lyulin <lyulin.2003@mail.ru>
Cc: Ori Kam <orika@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Michael Baum
 <michaelba@nvidia.com>, Ferruh Yigit <ferruh.yigit@amd.com>, dev@dpdk.org,
 stable@dpdk.org, adrien.mazarguil@6wind.com
Subject: Re: [PATCH v2] ethdev: fix pointer check in GENEVE and RAW flow copy
Message-ID: <20260519074002.37890cf0@phoenix.local>
In-Reply-To: <20260519072335.16601-1-lyulin.2003@mail.ru>
References: <20260519072335.16601-1-lyulin.2003@mail.ru>
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

On Tue, 19 May 2026 10:23:35 +0300
Denis Lyulin <lyulin.2003@mail.ru> wrote:

> When rte_flow_conv_item_spec() is called from rte_flow_conv_pattern(),
> the spec, last and mask pointers are checked separately. If the API
> is used incorrectly, the spec pointer may be NULL while last and mask
> may be valid pointers. Also call of rte_flow_conv() with
> RTE_FLOW_CONV_OP_ITEM_MASK and item->spec == NULL may lead to the
> same problem.
> 
> In rte_flow_conv_item_spec() for GENVE_OPT and RAW item types the spec
> pointer is used even if the function is called to copy last or mask.
> It may cause a NULL pointer (spec) dereference.
> 
> This commit adds extra check of item->spec and if it is NULL, does not
> copy further data relying on it
> 
> Fixes: 841a0445442d ("ethdev: fix GENEVE option item conversion")
> Cc: michaelba@nvidia.com
> Cc: adrien.mazarguil@6wind.com
> Cc: stephen@networkplumber.org
> Cc: stable@dpdk.org
> 
> Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
> ---

Applied to next-net
