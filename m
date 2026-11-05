Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5352606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=r9K8zJNF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2979D40296;
	Thu,  5 Nov 2026 09:37:12 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 8840A40281
 for <dev@dpdk.org>; Thu,  5 Nov 2026 09:37:10 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c40e02b2ebaso274517266b.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 00:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793867830;
 x=1794472630; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=io8bY9wN4XUXOCxP18u/PKizh5BC/MUmd4Uqd1J3kII=;
 b=r9K8zJNFjSZ4pd6/NfMFRe56IMFFwiZKNVjjUClyz/6OCpyQBGsBMOvp3IlcyM5vn9
 /BcgIUHBCPPYoet5WeM5e167uOUxNzi7mPEeUQArWibMTv6OvKRYefV/J4X9reODaM7O
 q4ne2R55EvyRs7K8Sbgeqp9FGQthDy5wOr1pvqeC5JRAQC0c7RE6cGJhHQROl8PVzefg
 VG6f99jzdQ4uJWwMiaZuYWbleqqKYu2q6Bzx8Zw93A522Y7LC6RXEdS66vnpPzZz9IoY
 ey/FsbIxfVszKyFta+IP4JqyOnbwpAgxGpYNmu3vCni8IFzQzFCd99UxjsSH47p/SLUL
 ecvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793867830; x=1794472630;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=io8bY9wN4XUXOCxP18u/PKizh5BC/MUmd4Uqd1J3kII=;
 b=I3SWRvRe0S2Wgt6ek3h3zWDV7e/Sb9L9892p6MTbz+LX2XVBOxVikWNKQGClLgmeA4
 DkwRqrxpvucsILb6PWpHi6FiDKrEpoy5WVbIKsU8IioalSwXSt9gvAri0GIUY+jCKesI
 NjooXPvFBY/gr3IziIF2v8BVZua7j73NSVzwVdNmXp/U88vzP5Gl1R4wZ5dcyiagdsOX
 7D9silP2EaTTEb7PevXoKVu4uBVgd7CpbLs4fZ05H1rZ4RXU5vXA4/cTpkCgt01weQQ8
 R0PsvVDzQkvo/6dNxifk/mmLz+j1HtEXlRyu11wjfjeF4+583o514SQzA+7OgNiPtBxL
 kcCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVGj9YDw2+aINQiEhoiKOlVmNtwOkZNF+gNGDPUosT5P7CWWp8cNhgpxDqdTUHn/tEySM=@dpdk.org
X-Gm-Message-State: APuU4Z9XD0UMdjB3/J4gKIVMAtAhqBf5fUzaufmDXxLAvN3CxxuHeiyF
 fkHgAeyC+ssMeLDRd2TfRV3taJNH88jHifZn+Z601y5RV6h5qagckklVsNtRdEXEy9c=
X-Gm-Gg: AYBFou1yilj7ZeIKkV5WuodVER344NET/723LqXvSuOsdv9TCqlWlHn7RulvLdInNJZ
 qe/UH3Uf9w75sM62SkgluuCuFTvvFPNgnYg12wY3/K/MYqE3jTT099ADgwsw5Dk6vSQ1ERO6S8r
 /iCiWKQVapauiflV+iBindQPtrfMhGPWe07de16tYUkVNP52K0sV52jYe+rY9TjM5X0p8aERGwb
 BXZcnKtD8bThj7KdnIVESfzeLXbJs/0bcueFB3PevLHPTX2A2C+enlgwS5tE9xlFeMJmN6n4BVi
 jJSx5iBOhOvowMElzyenvVCt7bBRHwmx9cLm0jq7TKTMBe1Blppai+gAvCDQQAZeOf4ZfT6IESh
 VAuSGIieOjDt8ZCajA6cBnWgevLFtJRQmE4cl/SlTYy9TrJGzLIROvYNXIypyZV1i18+bKyEWI+
 ekT+wgz7CqHxaDp7PV3PW5EALHJRuKWDRx/kAeBRUFFh9TKKTXpkLLbcq7jU1hjfFIrDTaczLsd
 Q2aLb8x1r3HLOHvuk2SmRQ8BbbeQDPSrukD/dKo58Sm5411Wgf4dQcwHauiLtqV56+Op/GamTR7
 5VxAmjtjSRDml1nV2v9Q91oQY1JzpIe1KsZFWyR4KrF8wvOmWEChfI1YSGGdXFmgRiNjY0hE6QX
 waf/qN+Au3yJhrWClDjxKN6cDz6y0xDO4GtFY
X-Received: by 2002:a17:906:e20b:b0:c4c:e344:ecec with SMTP id
 a640c23a62f3a-c4ce344f762mr657016766b.6.1793867829972; 
 Thu, 05 Nov 2026 00:37:09 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e42318fsm146564966b.18.2026.11.05.00.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:37:09 -0800 (PST)
Date: Thu, 5 Nov 2026 09:37:07 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shuaisong Yang <yangshuaisong@h-partners.com>
Cc: Xingui Yang <yangxingui@huawei.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Hao Chen <chenh@yusur.tech>, "Min Hu (Connor)"
 <humin29@huawei.com>, "Wei Hu (Xavier)" <xavier.huwei@huawei.com>, Chunsong
 Feng <fengchunsong@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 <dev@dpdk.org>, <stable@dpdk.org>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] net/hns3: fix hard-coded default value of UMV space
Message-ID: <20261105093707.17ab008d@stephen-xps.local>
In-Reply-To: <20261104124033.3373452-1-yangshuaisong@h-partners.com>
References: <20261104124033.3373452-1-yangshuaisong@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 20:40:33 +0800
Shuaisong Yang <yangshuaisong@h-partners.com> wrote:

> Currently, the driver obtains the PF's UMV (unicast MAC VLAN) table
> space from the board configuration, and falls back to the hard-coded
> default value HNS3_DEFAULT_UMV_SPACE_PER_PF (384 = 3072 / 8) when
> the firmware reports an empty umv_space field.
> 
> The hard-coded value is only accurate for chips with a 3072-entry UMV
> table. On chips whose total UMV table size is smaller than 3072, every
> PF still requests 384 entries: the first initialized PF occupies the
> whole table while the others get nothing, which makes adding unicast
> MAC or VLAN entries fail on those ports.
> 
> Fix this by obtaining the UMV size from the device specifications
> command, whose umv_size field is the default value allocated by the
> firmware policy. The requested size is determined at allocation time
> in hns3_init_umv_space(), in the following priority:
>   1. pf->cfg_umv_size, the user specified value from the board
>      configuration
>   2. pf->def_umv_size, the default value reported by the firmware
>   3. the hard-coded default, as the last fallback for old firmware
> 
> Fixes: d51867db65 ("net/hns3: add initialization")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
> ---

Looks ok, I will correct the Fixes line during merge to next-net.
Current process needs longer hash value
