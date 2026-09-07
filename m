Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85571C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF32B402E8;
	Mon,  7 Sep 2026 20:25:33 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 75BF140262
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:25:32 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d8f265cbe6so28403515ad.0
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788805531;
 x=1789410331; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zMaJfav8mljMl/39sE0rVSHz7u6HVjugpS5mKAcVni8=;
 b=xjZrHoTMaw90FDoswE59xMYtFdADwhwDgDRmRd/Dd9HwZNFTtt37EevAKB/jmXsNr5
 ZHSwUIcg52Rsw+juEGsk0b709T6wJTc9MGlfA9h8YjfzdPzbv7EMblgV+PrAJKDyD7NV
 vp6zgxd1M0XffX9mo2bjfYXleJpbl7BfJUq2LcQj2O6XY8Xj7Q6A0/eXY4VxtpWCrn5s
 Y+HKH7u4Vlz3ajUH5oLUPcsCWtS3m3TAqaez6CppjkEuuTUUpBolhkWcyXKEeII4Qy5s
 9MEerRGsuCPFatKv1S52ErtTTAxFHyZ3aPQCDWQB42uqnw2hPWjh0XEh9UpelziimVp1
 r6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805531; x=1789410331;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zMaJfav8mljMl/39sE0rVSHz7u6HVjugpS5mKAcVni8=;
 b=Vu9f/F+eJ38ztQIDVRyFfxgDjQOzBwOS1jIO81xhMumqq7TWM1bEhAH08ZeivgvOm1
 euo/XTiUBUUzj54zsb9g7lkN8Lm4SiOGPo238uefv0MguPWoMqlYYQgVECM5MIFcUeuU
 dorXVFLk4tUC6mWwdGBEoDEbo6ffXwIhTcrWHL43v8maYq7BhobserFTAGP7pJwfVTS3
 m31YSNHB7AuMo7oGIIpmZ+7+0SNGmGQ81O1S8aAo3BbOH36udnywoQyUDOGTxFU9q+vw
 I2HPhqThWNfIGZtEmwmZqUEQw3Vla8UOwH/5Vp0wHzHfR2LmdexnGtrsia+FUsvmFqPK
 GAUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtbAM9QAm8uaB2zmSCtHcuUmxM1XZtxq/RP0Z5XOouKC4sJc6tbPX7sudPJlwEAAHnZWo=@dpdk.org
X-Gm-Message-State: AFuF++kYMrPfvKefQexmuhwedJ480mYpGR8WnhvgYN5JPz03Zz30Nrcz
 H/qAmlU3qvfYUPM3GHBBLgZIJHWea7orUcdx96ww0WigCA4vsTXRvkStGNAgWTvXY16DWGmVvWB
 86L5q
X-Gm-Gg: AYBFou3vXj4n5OrBxPlKIYDvKu6hbgsQyjrRrh8Wc/7kEZZAqjjb+23mLvWB7VOZuLw
 64ufcSBCBDfZks9sWl+ll9EGG9jY/B4GmPsN47I7WH0NqPviQA0vaf47gCx2ov6xuTJBx6mnJL/
 AGVUUphQuTjBpdu8wentqSjMw7R45Arz1qriD9YiD+2g3Y1ju+B7fqgKYNZP9pBbMJwqZ4vPr0w
 fZchOeG3SrOEGp7z+qtUFSpHtgkMtHcqaLvxmjg1Iyv0LzmzsuKAvouqNMhrnXGogLrpiC6TycO
 ffglUP7qBwbdPsCukxmo7h4v3sKFRz3TU6i9J/zUZTy/94E9LzQ2RJsTNIzsEcdQLhMAx+VZdd0
 S5UPNGV+dlOXttstWGFDCzGLgC+rIytkhb/nVY8hDlxBRtYxhfYtbMhTxTA8EXMWgFZfF18m8qy
 D0zePJtzWZky9NEU7zd8UhkOYXbQkvnym0aDIcl2jefWml0cdZ0IsRvEXwy+xWjs267k6MmmtDc
 /A9ukAtnnPVXDsC4BHttxKxDTpC5g==
X-Received: by 2002:a17:902:d4c8:b0:2d9:69c9:2815 with SMTP id
 d9443c01a7336-2db12588b02mr321708185ad.7.1788805531427; 
 Mon, 07 Sep 2026 11:25:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db149595dasm48205515ad.29.2026.09.07.11.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:25:31 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:24:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] app/testpmd: add size check for flex item
Message-ID: <20260907112430.08b7113f@phoenix.local>
In-Reply-To: <20260907035033.800034-1-kirankumark@marvell.com>
References: <20260907035033.800034-1-kirankumark@marvell.com>
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

On Mon, 7 Sep 2026 09:20:33 +0530
<kirankumark@marvell.com> wrote:

> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> Adding changes for size check for flex item in testpmd.
> 
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
> ---

Applied to next-net.
Ended up rewriting commit message because this is fixing an observable bug.
