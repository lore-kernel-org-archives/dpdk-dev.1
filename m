Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5403CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:39:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDF7D40272;
	Wed, 14 Oct 2026 19:39:03 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id CD5B140144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:39:01 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3a80d1c98f5so498030a91.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791999541;
 x=1792604341; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zsda9hFrIcWzpGWxo9RecR3Sh3VlGPKVnh2AcyKjZx4=;
 b=k3N5E2aWaaqI6wzFSu7ii4iPk73v8vgFcMW4k7yrLDvpNeKM1UwrpP1/3fHnh6/dMy
 MU7a3TeBlz7gc6/iuH32jt//eJnuvBwhrfHSL0IKeCdI+w1RQRyUG/H6xtum1T9DiIiD
 cDOFmWnb7IhnZfLfXBQpg04vXzEFg23RqeBdpn/VPQKpD/QccD9rvDW1VUfu1WaQWPio
 6Hxi9PeTr+nK5QBYwtjP+RojD2hY2KhpKTFtKklJ9ycsXusrg6UZ37/eOvWTJMTCjA8g
 yX9V7ZSZbbQ5IY5sxO98qfQ8zPAH1zaZD+5mLNx6M1IjVoJTTikx4SY8ZA0lHM/dzNw/
 NlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791999541; x=1792604341;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zsda9hFrIcWzpGWxo9RecR3Sh3VlGPKVnh2AcyKjZx4=;
 b=wl90yZkju1MU6UOLSDoYjaG2ajzxZIy9Fg/YidfC6CS5LnJN8oBfioKZD0OR2JDPjs
 3PPUG3Gq3bwvcaOu8TTt+rfhoobkOzYdgEXBGhHqYZuXqRipKvIWpPYmw4OhLD98gBIE
 Y2Dge9rv/s4YeNVK/v0s1Z8wMhIRkZkcyDDHuyIQV7gkGXFlWHIh+ENmkbU1AnySLnGT
 ot3lqMHxAU/iL/8TI22UvzS//U7L3pOpSapGAJz9h67564Ns+6zeefikDC4IK2UDeyOB
 mLCbyjSjhI/J0Req9RLrk805naWLoKzzB0PRwGpP0dcGgFl1YwTKqb0e28wBl50aeWrn
 Ci9g==
X-Gm-Message-State: AFq9FYLhOgt7mMNiXl4gcvYHnyxoBclDEEaMmkFoRrl8JTcGHweQMxYu
 Ebypmz9ZhwLaBrYBKuXyA+4m5NLDVCLOX666lAQLNzbsbSoOMU9XONrV3kC6Yw4K2pg=
X-Gm-Gg: AYBFou0IKgx3XiPk1MoO6juk73vAR58tJMvceNPB45pguRTEVwiDKAjfU+44oUPI/PG
 kvM7jt59UZwtzy+7RTxEkNbJ+YV/+LF0Y9Jwwp74N8bVGRo/KtdNpOy4kCwGC5niuM5frcNr16X
 7ZdasmyTNmjxsXnDlDXan+th5WLNG8GoR4cP+eTldOeChm7kCLkvaA31rTM1lli1fSF3aqAuRcd
 Vu0VlpmyubpG+6yYfkhrNyggGZYANCtVVZ/ICbf51n8AnxkV+9ssTEFG/vYlnxafIA95IkubQIm
 AoUj20Dq3iQ3xaC6P4pCZSXHNE2P6tYMvZZ+DGfBR4e7yS2aRuYaIYqsFXpNQUEzxqZfpNLakfq
 VaSQtkoWwZlNwmOSlTCG12FM+Qhhy+5WnMdkPtg2fvAPEcnJKeomviMXH/PayOfPTUaPoC2xxHy
 AUbDhFsf67q36qUkELxYWf2zE+oQSRvkVDhSZnejGEM4rx4fVhi/Zj4maQKdlymJHBdi9OPYWHa
 MM7Q1R+E4W3Zrcl3iseOxmtCSNny7Talo/Bxw88
X-Received: by 2002:a17:90b:1dce:b0:3ac:7556:8ee4 with SMTP id
 98e67ed59e1d1-3ac7556a3e9mr2293620a91.67.1791999540785; 
 Wed, 14 Oct 2026 10:39:00 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635c58d91sm134649a12.14.2026.10.14.10.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 10:39:00 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:38:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, reshma.pattan@intel.com, thomas@monjalon.net,
 mb@smartsharesystems.com, marek.kasiewicz@intel.com, Jerin Jacob
 <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v7] pcapng: add user-supplied timestamp support
Message-ID: <20261014103858.5a454dac@phoenix.local>
In-Reply-To: <20261014172102.1090177-1-dawid.wesierski@intel.com>
References: <20260629093942.983145-1-dawid.wesierski@intel.com>
 <20261014172102.1090177-1-dawid.wesierski@intel.com>
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

On Wed, 14 Oct 2026 17:21:01 +0000
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

>  
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pcapng_tsc_to_ns, 26.11)
> +uint64_t
> +rte_pcapng_tsc_to_ns(const rte_pcapng_t *self, uint64_t tsc)
> +{
> +	return pcapng_timestamp(self, tsc);
> +}
> +

Since the tsc_to_ns is independent of the pcapng handle, I had some
patches in other work which made it not require pcapng_open and/or move
it to EAL. What do you think?
