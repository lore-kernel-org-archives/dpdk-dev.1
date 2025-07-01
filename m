Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445C6C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 15:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB97740276;
	Tue,  1 Jul 2025 17:16:43 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 635AC40264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 17:16:42 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-236470b2dceso28199865ad.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751383001;
 x=1751987801; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzgLMFY9q6eCOMOQSRFzyPVqoPwfVRrLyBMXkw9wjso=;
 b=XnMYKu7xYSAKGjTW+KvwKy993HaeqOWMCZlVK5lc5cBB9apAfgqPGEumtl2bdM9PeY
 f1FZiak+MVt/0Q+xygvUb68kIWRe7ZBeI3kHIXn9ODTNBT+3jFInlA9qrFRxg3plFPub
 7SKj1WlNdDfzkH+b8Uz57yTOq9xh3muJIp32K4Sp1LDSXJgY7fGZ7JlSXrd5Iy94a0s4
 qKpOFVJIrnkWPM5XE68WAvE+loeBRGE36I8MfhUxfilOcIy60DO7Cwrfw/idc2GuGkR/
 R7o9443ukAlEpth/XWIBIU70Wqw9qKOFg78qdVJBf9TteQ9VqTAaCQIJfsWVVejPqKT1
 di3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751383001; x=1751987801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzgLMFY9q6eCOMOQSRFzyPVqoPwfVRrLyBMXkw9wjso=;
 b=oU9NWKy37bh3UHPCVWgBP12883XwJP7wOH9ns2DFtH42jg46B/z9B3M+GpFYGOsOJ+
 I6jLrfeREQ65ODyG1iXCd2s9b1qxIFkqmcm3TF71Tl6uKCsb35j5DrXe2gcKl3FVDbE7
 prDo66ZXfpXG86qrdGVrv+u5mONNvxxgTmMeEbDG8Vf+P0k/eNVT58miXLmEVf2Q3hru
 SRUiHkSi+A5hH7FuiluEN/z/2qjW5yEIhUrs6RuDGCTNr43zXhKPE2UTfR+V/RlUvRfz
 qAfAooCmGgrIrAIztWVfyKfzP1bzkjg7vPOR1jEilvKBfybtTdWX5gOs0UeTz4aMfVFH
 ScaA==
X-Gm-Message-State: AOJu0YwFE/mpqqfyW/r9aF2pnxQiMPoFv2XFWGjAEbkuDDf51Szdcjra
 f2zmHWCh0+ImDRNWkxmsF27CKZSykJxo1DvMKUL/Wz3DGBtr6ToFI6vSlVkXwhAeGP4=
X-Gm-Gg: ASbGncvHs6xDoijwyB46JCv0kpL8ZmVoLyM6HeBPKqq8CBod/qk8g2SYTcrlpD3YjWK
 05bTiAIKqDT4COsqbSMY8TZ0q7PBIPre/t8J+/oc8dTR98/cIk1WhQpxvmN1KykN0Nw9S0hkJ1k
 iP9dlNqLVc77X7zBSREExqImFUC07rk2HkNK4DvCtTc4wxAffbQB1NF1eecE4DMVlimIk6MTFaS
 PxlgPrNDmNAHs/7F7fdSqH+eNfOfH6eECxqs8YeEqZDMwD80XuGrv6punJsyKShgylklUp9cp2P
 9rUSrrR1PpSBcXJmvTUAFZ2ktAr348QUHgnlLrUkUVeSY0rtcW2keR4r2B2Mn68djpTYYFudarV
 ia6qj638ywpLMQn72ZgppgMzP8jhiDHBC/S8hcrE=
X-Google-Smtp-Source: AGHT+IHBggs5yUZCfkyT5OO25msh5djsJdkDY1CAAwVKp6U9v61HpmElHXw6aYkoH2vylNkcBAHKIA==
X-Received: by 2002:a17:902:f789:b0:235:f3df:bc1f with SMTP id
 d9443c01a7336-23ac4605670mr303568715ad.36.1751383001420; 
 Tue, 01 Jul 2025 08:16:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2f0b4dsm107941415ad.60.2025.07.01.08.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 08:16:41 -0700 (PDT)
Date: Tue, 1 Jul 2025 08:16:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
Subject: Re: [PATCH 0/6] net/hns3: VF support multi-TCs
Message-ID: <20250701081638.5344a91b@hermes.local>
In-Reply-To: <20250611081900.3658421-1-huangdengdui@huawei.com>
References: <20250611081900.3658421-1-huangdengdui@huawei.com>
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

On Wed, 11 Jun 2025 16:18:54 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> This patchset adds the VF multi-TCs feature.
> 
> Chengwen Feng (6):
>   net/hns3: fix VF fail to config queue TC
>   net/hns3: remove duplicate struct field
>   net/hns3: refactor DCB module code
>   net/hns3: VF support parse max TC number
>   net/hns3: VF support discover multi-TCs capability
>   net/hns3: VF support multi-TCs configure
> 
>  drivers/net/hns3/hns3_cmd.c       |   5 +-
>  drivers/net/hns3/hns3_cmd.h       |  10 +
>  drivers/net/hns3/hns3_dcb.c       | 161 ++++++++++++----
>  drivers/net/hns3/hns3_dcb.h       |   4 +
>  drivers/net/hns3/hns3_dump.c      |  11 +-
>  drivers/net/hns3/hns3_ethdev.c    | 132 ++-----------
>  drivers/net/hns3/hns3_ethdev.h    |  12 +-
>  drivers/net/hns3/hns3_ethdev_vf.c | 297 ++++++++++++++++++++++++++++--
>  drivers/net/hns3/hns3_mbx.h       |  50 ++++-
>  drivers/net/hns3/hns3_rss.c       |   8 +-
>  drivers/net/hns3/hns3_rxtx.c      |  26 ++-
>  drivers/net/hns3/hns3_tm.c        |   6 +-
>  12 files changed, 539 insertions(+), 183 deletions(-)
> 

Applied v3 to next-net
