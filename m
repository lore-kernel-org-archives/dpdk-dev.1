Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D864CC36002
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 18:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 065BC40659;
	Thu, 20 Mar 2025 19:54:28 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 6250F400D6
 for <dev@dpdk.org>; Thu, 20 Mar 2025 19:54:26 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2240b4de12bso32180545ad.2
 for <dev@dpdk.org>; Thu, 20 Mar 2025 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742496865;
 x=1743101665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiLVQ0GJ+H+Z5cjjcB/lqMxJgtSrxoZsx799QpwHN1U=;
 b=Nh+OxCv1pKKrMlU6QcgMJ/JOrBxrxbVPNW8TKQShFQ+0s/RoGzCATkQdalAOfn/cIp
 HerDcjwHhCGhju2rYFXgbsHZc+kyXTWFc+fphHxZmUAD7tDXgUIQ/CnGod9az3GiGYm+
 xax9m+PApJmf38bX1twJGfFrFSRoSf4CZkDKLViN/GQFxnwtCGehFJGxSHtVVCf93md6
 2d1DvPr41LfFR9OIrEH81V5NByfPzWKPLV2TiZSHx6sbpwBf8cqA2EutDrHTVIfSB89h
 io3AvC9gJVhMAId1JpmLlVRJCuO+qBeakrs4yJ3oRWHZt6nEvYFuqOm43QqsnOHy1vvY
 Vc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742496865; x=1743101665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiLVQ0GJ+H+Z5cjjcB/lqMxJgtSrxoZsx799QpwHN1U=;
 b=SSi5ZWRMHUBd/pYAkLxhfVJH2+QravxZB5NhXm0vedZep+4o2M2Iu/TPLQ0epC/Pfs
 E7nF5MKZ2L5nF2zLEtwOiD5ylMoL5VVQqIovav45h8Epk1yQs+yRMbLuPRMKeVBYPjTN
 uCxqQWXtRNUg/ai2nA8LoOi9EMLuy9sFADoiFRljXzsS0FymnQ6yLfJEMMLhk0FXWsxi
 cWLQniIPCgBI/DCnJc3w1GC+VTUIu6+HrPttyQ5Z5mbpUw/M24SBPNnQOcuB0t/pEmLT
 1R2lf3+MkdHwGL8bOWcoS+hy6jmeiLdIWG6t7ueY4FBosIhwSS2qXkhoHdwSuv2d03tO
 9WDA==
X-Gm-Message-State: AOJu0YxKcYaFzzoxCvj5Lh79+nqjAfNbBigTDj7giHTnB0ZRDRY1oL2g
 nSuLXskibL3EuQgBgxTuaJb+nD4xbvewhQ7V88S1LzsXn5GjFEgxTIS3pWzJsOs=
X-Gm-Gg: ASbGncvLFRGkkgoWmC8t68fAK2MdOn2//wZ3IlsqJPoiYHmvbqKD4VvGeOfl5zTAn46
 O0TaelMzQXDYQ6myopsgX6nO5N9Dh8T1vEI/DBbtGlb4kyxggdV6Wnd+gIRsMVPT/XKomF0POzp
 Q2Aif1HtzuoMWHy0g8rd4aNQWtBpi7tfUJKEnmYMVWpu2vYL1Ds7gKN7UnG45eNHbI4u4s3PUfN
 o3Ug45SOjPPyPMfc3NX40bEnEuB4+FFtkavTmw2RovntnzE7vRhJM5gNcwAOhTey3R0yEQvRr9m
 04GRrA3jg9OjVkkf9d2KPm0FgdwlhbJnYO5MNWQFQtm/TKzGAGCQPh1gVehwSjofk+1OLkjaE26
 mOAhPUZkvM29toHYw4dh7JXfniOzQ+6IW
X-Google-Smtp-Source: AGHT+IFKbZLhqYTJ+eQd7eFWgSEVObMGzhiWdavlBmHl/1eemSSEjh/B2RlvEo01Xby57rQIC49sYQ==
X-Received: by 2002:a17:903:2350:b0:21f:74ec:1ff0 with SMTP id
 d9443c01a7336-22780e14e77mr6095965ad.32.1742496865535; 
 Thu, 20 Mar 2025 11:54:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f65casm1266985ad.230.2025.03.20.11.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 11:54:25 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:53:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 5/6] net/macb: fix tab errors in meson.build file
Message-ID: <20250320115314.42698abd@hermes.local>
In-Reply-To: <1733814515-412204-1-git-send-email-liwencheng@phytium.com.cn>
References: <1731310932-1743343-1-git-send-email-liwencheng@phytium.com.cn>
 <1733814515-412204-1-git-send-email-liwencheng@phytium.com.cn>
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

On Tue, 10 Dec 2024 07:08:35 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> Replace tabs with spaces to resolve indentation
> issues in meson.build file.
> 
> Fixes: 97fd6a929cf8 ("net/macb: add new driver")
> Cc: liwencheng@phytium.com.cn
> 
> Signed-off-by: Wencheng Li <liwencheng@phytium.com.cn>
> ---

Fix the formatting in the original patch since it is not
merged upstream yet.
