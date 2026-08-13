Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4080FC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 01:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1478040298;
	Thu, 13 Aug 2026 03:30:06 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 2078F4026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 03:30:04 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d049069377so16523345ad.0
 for <dev@dpdk.org>; Wed, 12 Aug 2026 18:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786584603;
 x=1787189403; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TIP0xKgmHnoTp3Z6cjT+SwFa/Xv7YVs7B2jTQM3QqGI=;
 b=ZukE/DKMu9jXSpK8La4TA9FbMxgKpx1hhaCIN0g+NtS1bjuADGqBztsAM5wlNL0BMe
 SxQT80xNDZgIh1T0M87sbrRKMTtx3z9B6uWACFxLfdIGPSsDoOK/WkX9TvFv+R/dXjTK
 /kNWpu7Gqs5hlSCBvC/DX9eqhVgOF3lm6gmSSJNFlxc7ZWiM5xo3XZKAwQXXbIkSkDQY
 Cmn5sg80fQSiil115AURmzSPb92xnSD+KC3yCwDpWjqWDKHtqHi/lvSh1HN7xAlSMe9t
 D9Kbz1don4H7mCaMex+YjRyOp/zY/9LIdL3pXb+/ixP+iZlTqwlVVSuioNLXQoMLzsKR
 pGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786584603; x=1787189403;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TIP0xKgmHnoTp3Z6cjT+SwFa/Xv7YVs7B2jTQM3QqGI=;
 b=UZc+jDUeLMKpch3s+CXW6ps3Zr9Iv9oNb50QxUU6UiPDikGYNAkNKMS8hTF8nLuiMQ
 cNaHTBfhQqOWWxDU/1dmetgppUL1J0kpq+cHtv5B6+cSGdrddsjrUgPF0FUTsN28BCkk
 Swu2uZcVk9Kw+Gkh/2lBXZgxrQV/PEHTPgfYF/bohZhROR+3H2i2DDszpG9SzZ+gVVP0
 82xAvS0bwZAja9p+5fSv42iiHzU6+Td64bA/2OTuLwVYASffKa21z8PlCBUhwmvnML+K
 G9iWXLZcfeMuZMr5klV6PV1XdW22eI9yxKlOjVl1jwih8Y93w9Cg/mEH3quXXV5Z37eX
 Yypw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpO+6b+nETVcV9AeahXw0WgoL1urcpu5CT+y+icsqQOngGYv+LH0ipvTI3WMBgj3tRY64U=@dpdk.org
X-Gm-Message-State: AOJu0YwdeiJCe7zaAYLnUn7FSOYI8XtsaLFD69mQKnj+uI92ZhB4WagF
 tg+z9Uv18JspH0sGd2oL3kSWEyPZJnKVCVrUdSXry7Ty9Ny54KfP4FXb/qTjEXkOGkk=
X-Gm-Gg: AR+sD11YLJLArubRgXUH67Q1IGlfVqOy+dAyHBCnEPfylBMrf4S7TbyV0kTLavIfj4g
 lBD31px4yRbkG3RgZYaN/YzmPd5V2101QTlyY9Kq/H+XXD7C/yHF566xisUmVwzUzepyk65AO9e
 /U+NixrvfZULcD/xHRoNvBuk40qH0QLWgIwP2TZ7D0WDwBBG1Bhp0YWCx4S1HTTE4INUxJmQYvO
 inWxa4gPXqDhwoweLNnMDdtxLNhtwcIcWE2n7nxdtT4mZ/835p2SjRAeo0zbmHo9+pyWLtsfLry
 jNLY58lEVlgSeXW7vPWkOxoNsJusSfKPegh8uqCyA+uo8N3qp/b6F83BGDjORAUUZkkMN1X+vtv
 MiYJLIsJ39dacvx97eIWME1eW70ukYTVTliL+V+qC62xwMs3Nf8b3JhDE/TVdTNbbTexeyW5uN5
 jg73kr0mGr1G6ErsQ9klz7iMJ57bmaqAkjTrLOJWFQ/8VnGueh+kFsOnIy9ONrbUM/Q9WjEXvPM
 2oN0l1flP8tkM40guSBBbgQSSiY4vIRClHxVM00
X-Received: by 2002:a17:902:f64a:b0:2d2:da8e:9017 with SMTP id
 d9443c01a7336-2d37d54ff55mr27096205ad.8.1786584602814; 
 Wed, 12 Aug 2026 18:30:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf732166sm2212259eec.18.2026.08.12.18.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 18:30:02 -0700 (PDT)
Date: Wed, 12 Aug 2026 18:29:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: Reshma Pattan <reshma.pattan@intel.com>, Chaoyong He
 <chaoyong.he@corigine.com>, Julien Aube <julien_dpdk@jaube.fr>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>, Xiaoyun Wang
 <cloud.wangxiaoyun@huawei.com>, Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Wenbo Cao <caowenbo@mucse.com>, Rosen Xu
 <rosen.xu@altera.com>, dev@dpdk.org
Subject: Re: [PATCH] eal: introduce division round up macro
Message-ID: <20260812182946.16d1e889@phoenix.local>
In-Reply-To: <20260812223017.2980190-1-joshwash@google.com>
References: <20260812223017.2980190-1-joshwash@google.com>
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

On Wed, 12 Aug 2026 15:30:17 -0700
Joshua Washington <joshwash@google.com> wrote:

> A number of drivers define the DIV_ROUND_UP macro -- add it to
> RTE_COMMON so that other code looking to use that functionality doesn't
> have to re-define it.
> 
> Replace usage of DIV_ROUND_UP in existing places with RTE_DIV_ROUND_UP.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---

Makes sense, but this is the kind of change that is best done as a patch series
so that each driver vendor looks at their code; and if something is broken
only one change needs to be reverted. Make blast radius smaller
