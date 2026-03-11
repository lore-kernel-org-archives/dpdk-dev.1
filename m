Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA881125851
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6429440EF0;
	Wed, 11 Mar 2026 17:32:15 +0100 (CET)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43]) by mails.dpdk.org (Postfix) with ESMTP id 49DB2402E7
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:32:14 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7d744540081so755993a34.0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773246733;
 x=1773851533; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDXRoUFk3JsDHxwTatAvUZLEvRaVmkKcvdT6/+L5hD8=;
 b=pnPvUzdfGOBPL+omjHkY+mpbzcOBcpiEsm8qaf5nPfY10QrnmwEkfnAKidm9ifrr/8
 y9o/xwTjT3ap71Zn7l+3okt34Y55ICUHqtD54nehKdtW5KFtW8C0O1eSfVB0y24LgMaj
 tPV7tSC+xGB4rgbgWyhD0frEo6/fdH2ztEpl+/z/emKB1ivjq5g4KxGiQIa6UAEQ1Gnn
 S1D25iP2ahkp8p5/UmyN7+mbfFBoscewd8myf5BT4j/adwwzysG0d116OaD0jWNoCCjm
 t+eAOjiielkL7wEhlJB2jmCOHKsvftXLRhfvTkh1l2/zgLWFurFo9foWDg89PyAG5mhn
 1k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246733; x=1773851533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDXRoUFk3JsDHxwTatAvUZLEvRaVmkKcvdT6/+L5hD8=;
 b=HDfK1dEnPTwoaMaYU6RLrRzIKRvMqivmCQevi/uvUp9LE7mYTyTUcGZNUBJDQVPEnI
 kSN3tFCKp939RuAFLk9eJKSBjVk67ZRvGtLId5qLxYsVIhtUSnQAN39r6OQcDUVO07xj
 s2kVZyf3fZKzdzDmE2nt0X3tiAQYmCWszC/dqLRjohhg4yau08G/s72edTh1G85OvUvF
 q4M0ZXwe6D60JiNM2mWrclXRnmBM8xWKt3aKPDq3DXCcSsCSvi5vaGClbYYvs4epRHNZ
 eJ8rUv9GIXnlGOyAG1McM5qgEopw+MvWf9cTODm/qfZiiANOiUNZu3eEXGf9o48cZXjr
 qu5g==
X-Gm-Message-State: AOJu0YyaYzwYjMG/aa+6jZzaK5gW36O1IHPqAnESyjy1bnuofm94TJ+C
 kWZpl74hN4EKQf+rm/kElFJXwIYhCh0KzrdRfxt6wL0MO7JBGFhlnbFW2mZXaepZj8Y=
X-Gm-Gg: ATEYQzwCLaynUWiBqz+4QxOvdmGxryi2iYDnBGZZhCLpvAL1xDIlVEGxSeH2uFMyxB1
 YYN387IFCOYtxV5wluVf6Rz32klP/wJ90G52IIas0Yb49eNhbXVvVvOD5BdXLcvFywVUSavjJWX
 x7HhktvQOAVz90plAsQJh1I0VfsuVZI+vYFOf3oRzUCDNoQQUppYspcqO1DKny0tN/vlRpDs0Dh
 HgTZ9tQKw5s4pXesJWNAbQvWzfowfKCXWutLXr4SCZAKcmJjxvdGffquRxXNjNMRCnSCo+TRwPm
 FD+RvAM+ZebTqMCUjU7MwL6rjS2IpK1ttdcJ2aZwfnHHC9h6Nlc68UFr6nHd0YWnTB0/CiDwaJ2
 os7VHr+C715AtzdDC94OiKpaolo3QmPRc8XlnmexqWjPwwmRIEecNTNQsTgR2gbFmMGTMGVlz+s
 lxXMZOgOKykLeF8zEeij3fv1oIzEl3o2J2SdY=
X-Received: by 2002:a05:6820:4888:b0:67b:ab52:2799 with SMTP id
 006d021491bc7-67bd06dcf33mr93333eaf.7.1773246733482; 
 Wed, 11 Mar 2026 09:32:13 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc93061f2sm1686372eaf.10.2026.03.11.09.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:32:13 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:31:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 10/10] net/mlx5: add rate table capacity query API
Message-ID: <20260311093153.4802bcef@phoenix.local>
In-Reply-To: <20260310232653.2935764-11-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-11-vjardin@free.fr>
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

On Wed, 11 Mar 2026 00:26:53 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> Add rte_pmd_mlx5_pp_rate_table_query() to report the HW packet
> pacing rate table size and how many entries are currently in use.
> 
> The total comes from the HCA QoS capability
> packet_pacing_rate_table_size. The used count is derived by
> collecting unique non-zero PP indices across all TX queues.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

This will be considered for 26.07 so need to hold off until those
release notes are setup
