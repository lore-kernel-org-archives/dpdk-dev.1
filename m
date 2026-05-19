Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76560CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 15:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7440A4065F;
	Tue, 19 May 2026 17:44:10 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 1EC1640664
 for <dev@dpdk.org>; Tue, 19 May 2026 17:44:08 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-303f2fb7225so1839923eec.1
 for <dev@dpdk.org>; Tue, 19 May 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779205447;
 x=1779810247; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Nr8AawJhPOIxnQ3r4XmWapDhgZLtX/NlKPL76uHA3s=;
 b=dscWHgN9EHBlDZ/kw4RBbAvazDR68MGihp2J9abABEAL6lCucfHdBZE2Y6iYypSzqE
 jzj0g3PVPbo9oSTUsXGX3sJg70m9Q/E6pui2RtXHwoGaArguJY2qN/YGZGkO1FwXBh5j
 jv6x/nUu4F29XByUK+vXcJJxMX+5jsUmKKnB4xuma7adOG1MV7s28KA+cDJQoGbVYdXT
 sSqzjuWhHLzklEJfFuOn0S0g1hr0q4V6epkTTCrvujz49zZEufrY5IcJMvv51FpuXXsm
 fniUQmGssodwhGPMQuWVXKW726IBoR1mO1lsxSilTyYEt141TmhbK5EqA5YimlltTso3
 dz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779205447; x=1779810247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Nr8AawJhPOIxnQ3r4XmWapDhgZLtX/NlKPL76uHA3s=;
 b=RdfjQ2Q8k7bDR5APEcgrB4GL9ColOvhTrVXoWbTb+tKJWWSNb6SeTqO/4+s61p3RgP
 e7OhozTwJBHX2N8e498jg6EAWPs4qEBxA0gwCP0eIIpNugnjpsz9DHx2jpsev3+I/tT4
 B+h+5tJdnBbUF4xI9Ozk8lP3wHIObEf18J0zIeqMqkkOpbQE0PIN1SeV4QpO3yc3lqxI
 j83cu386gvn2+vdCX0I4/AzK2ULGEeFkgudE8pzVWGAUKiWWHDjsIHOiAfUQJ+koz9f8
 dxDTVlZcF1mYayunUwX1zl2jVkvVsSehZgmRwmrgRbbW3wq3B3zh8f6aW/mxdqntJpeh
 Kn3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3qeidDpIUL/6F+uecvHyXwsHkxtnQaiix+abS+t628IpuZtT4nbOVpbSLtNj8mvhrKL8=@dpdk.org
X-Gm-Message-State: AOJu0Yxx8dBcuk3ZLjR+E6Ru1S2rNxKQoq2ABs1uvGNIoF1oyijj45Zb
 FF2/MZwoFwXR5022VazR4t3uli7atCDJswVMdYSnwajwV6p8tUCDwiw16X6AbM8UY+s=
X-Gm-Gg: Acq92OFmqyTDp9+JJ8tBLhJmEu/wMTglBeiwGL2CC4ld5e6O3HGOnCwCwfSFfshTSgf
 BVJmmOoITvsRHb0IPC6IYTfkJY9BQHJnR12gPve1eruljmdb19T8ZfqSqhXu9bErHxUr0oCIHaQ
 Q87HR0RKyIzm+Qpd5qsa4avwzjniai6O2OpolaFZIxzdo1/a2vMtDMk91wiPvoug3/AMtKq+eOE
 sRfRGI5g0wdtBtgKL+5G/jRVbA6M5Ijjcjy7n0nw15oYhYQKRWCKfeFy9cnWEl/QcCIjwdg9cub
 SjSAOvtoZHlMDkV+K5S4B+Z9Gb9SEQSVPuOdC+gFLHiY/PRpgOc06GyRKrZj7ZPHNprKjaZDkYp
 833+eGoujV83TWCoaRYW7rEQOQ33MxSxoPaosNlTQPAHgY12L/MPMDOH8LBZyOELSUBJ7P9lz0D
 lIFGMFgczzkkzrDpAyuWGJOC9fT6su76jLcso=
X-Received: by 2002:a05:7301:6884:b0:2ea:5057:a2f9 with SMTP id
 5a478bee46e88-3039867f58bmr8227850eec.16.1779205447231; 
 Tue, 19 May 2026 08:44:07 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm19536595eec.5.2026.05.19.08.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:44:06 -0700 (PDT)
Date: Tue, 19 May 2026 07:40:16 -0700
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
Message-ID: <20260519144016.iIxNz_Ggj9mBzmHX7PSokxQJy8NSGiGLscWBaqfF0Go@z>

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
