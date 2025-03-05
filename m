Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3DC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 21:33:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15077402DD;
	Wed,  5 Mar 2025 22:33:18 +0100 (CET)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id 462FC40279
 for <dev@dpdk.org>; Wed,  5 Mar 2025 22:33:17 +0100 (CET)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-6feab7c5f96so6634047b3.3
 for <dev@dpdk.org>; Wed, 05 Mar 2025 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741210396; x=1741815196; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5SvP5Wn3IfP8ZzvQSFsLB5uQvRPIw3Cbya69d6kD3aE=;
 b=AdXaKXi7netTJTAzqD82K3X8AZd2OVKH7O5ZbastatEY3Q9rfnkkJN6M9OBEGu3hYP
 Z3+heiAUCyG46iFi4a+Px2A7otKFquFOylJqA5wjjZIB8yBCp23nXmZsC5N8Sqt8GMmm
 KWTY2sW10ZTUiX7V9SOXc2IQY/Q38VRNvwG5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741210396; x=1741815196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5SvP5Wn3IfP8ZzvQSFsLB5uQvRPIw3Cbya69d6kD3aE=;
 b=YM+Ykgw1RAIQjnYpk123o497QN/k4S0L+KKvW3RXPjidccTS1xMG0UBTndrTv5sUVH
 WSXdv7XFgmtYosySuTraoIH95HRAvbH1jnCvcWz+y33CH4JtcXfpdrVsj61eKzHD3TVe
 /ur8HtcTiJLdDeWR6tb1RvjKPMpWIXX+s+0xngS602uovNqa035jUIYzTVsyu24PtSAM
 N3GsFKnzFUydzXIq1AIXoCxdYW/2wWtovr9gptf2yvF+UeonmvV/oVharo4PnGvW6Eng
 fTpkgsmNDvQot0z8BX+G60B5Lo381wauo94Ilt/MYjcLXg2sjZ2GlbO72OOLT442dYH1
 XDAg==
X-Gm-Message-State: AOJu0YyodmVmKS1lhLFucH1dE9wXzjwh+ZCWp6VStdMHJ7kAJtl5jjfu
 7nPO+s22ywP0WcBoyq2xzRcM0Gb8QyOaoIWVVdwDd4qNOZCJiqSKIhCBSeJe4MlJAhT5gu+ClJk
 A97Bit1DaXex/Hdd27RT1StvjUG/f5ejhDnoXSw==
X-Gm-Gg: ASbGnctsYDuyyA6oL5jZTaBWn8W3boU9vCIwiEFL5DfkvIWn1zIoT6aZnMbex4iEfsB
 wt8Wfw9+EsYjk+VMuua9HOrJmE7gc8bMmMc5uI4Oez/uQqQPwDZ34dsTw7NXXGyCEpBtP3NYSp6
 rEW6iaMysN67xl/M0BPJEr9U3410F3nfvlX0EeI36xFiSXGuxFGMRArgaZaJj5
X-Google-Smtp-Source: AGHT+IECCBazLaMLN3dAnfp08aeF8qcynTW4F4p1Go/bcj/w04JpTCMabp+jlMs9AxjSPdMDbJFa2bXH+lim20udomg=
X-Received: by 2002:a05:690c:d87:b0:6fe:ad42:19be with SMTP id
 00721157ae682-6fead421b2amr24588377b3.12.1741210396428; Wed, 05 Mar 2025
 13:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-6-luca.vizzarro@arm.com>
In-Reply-To: <20250224132823.196509-6-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 5 Mar 2025 16:33:05 -0500
X-Gm-Features: AQ5f1JpBJqiu5qT5a34Vi2h5eUSVHLWU17cCUsx6uySJe-M2Z7FvU7a8_65n5ck
Message-ID: <CABD7UXOK9ZH17zMw_7HQ=4JD4a0gxj11TMRJQRRnxg0tuF5QrQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] dts: enable build-less DPDK driver binding
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
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

This looks great, one small thing I noticed though is that you don't
necessarily need to build dpdk to use devbind, since it's already in
the usertools directory, so this commit/series title could be
misleading.

Otherwise:
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
