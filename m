Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673FEC982D7
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:18:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7298F42F09;
	Thu, 17 Sep 2026 18:18:49 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 9102942F09
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:18:48 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so1008076a91.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661928;
 x=1790266728; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A3/sdoYkV4m4vV25tFzQZ1pTMlg3Uz5xMnP7LWBKE9s=;
 b=U8vNO7upeP9o2S48RY/blyEHyrN/s2G6kbPXGCyJi+QZhfAmJeM5/8ajKXjeJIOBkQ
 4BGRsqbhVWPkLdEux269hWHxt1xoP32BOIgjA180o+N/H1fmEUdyu+L0z+Mr58Wizt0J
 /6wxA1NnaAMhZjDEDdAaPE7Xvjcc2jU2FyzGXJTj6t+zVOW+w/RaRIlMW3oVplQNfqLM
 8OqwIRDqD40slTr3Q2XYaPZ2RlsH5vW4gi9GJGI4cXm3DD98afMgkDyKhQkN4F2n8J9c
 MjEhjKQMCO8LqQvRPqmbzTKwEdNCyBa8Y/IQwftO+XPqQB09tCyOWRuMl6fSyed7IhVx
 XXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661928; x=1790266728;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A3/sdoYkV4m4vV25tFzQZ1pTMlg3Uz5xMnP7LWBKE9s=;
 b=j641bha3mgsrl+JDYQr0OI0aZkTY7kXXrNulrRQaG7e15xXSvXlW/D3QnFkh055Rte
 TpYvltd5DJdDvIQhNVhw0CMV4d5m8rpRuulcnxqa0U27e3INO7m+zNaq+LWcM0416fRt
 q0xHmv25uAiUT7g+I2cv0pPdv+jfkNaAWp0i0HHW8S8hK5FWz4E6maESp5AZp8X3qwZ9
 2nKnkE+LyHRYEm88hj23fvOwsNBGIKHjtyqchEiJEfbsweC/y6NRZS43wzPueo9j7JOd
 A1j/uLcoL3rDF7pAW5lnOJ+7drAk8gzyBRkq1owRL9hAkIbK2HRgIwv+qN9x4xw1rm7M
 if5Q==
X-Gm-Message-State: AFuF++mrnMxkmKrsQZt2eAob6WvQn76jEuiy7PVeXAZBaEzHXmzb1CJk
 GT6yLCjUZGLNHGJeXf1zXf1iNRww+WYdSbw0/2RMcBPfZxbaBZvzfKYN5pYeZB530LqAeutKTGq
 Q75vA
X-Gm-Gg: AYBFou0U41HT3jgQY9ypRhywWUTc2r21mmQca6AV3Dky6QnIXjlPkkvEtznqubAkHAH
 4yXp8E4uE99NwIL+3GrU1Pe/ndK+TPQO1e8a0/+nuzrhuLc7w/KZY43V5++KXh7NKnE9FIFVmk0
 78xNWuu4AWiAKY3e9YE/tdyQBzumUaPuf08UCYH/5xKV4pruOAZWZAMydHu7EvP24q8Ap4dN77N
 9MwN0ER/yL+sq0fOWRDffm+uG2GOkf+bH8kgn3Pe2DQuinX7l9nt+cbm+mpQoyQ7D+CLIy/J4H2
 51gnhROmBnAe9IbVx5w/6T7GSP3185cYR9gvbKXelZn7TSP+NrHzkKul3Dr3gORyjouu7KI4S4a
 RQ8mWlby1Cc4UK9T25wG0yYW49/UCgPvMDFZtVKXWUnsHOyAG8EVtuoVOMvDUWlfOByz00i3GKY
 Dfbd5lm90kry+idbTyJxUttqDCuZEIFoq2WHkyJpIJF0OtiW/8V5TXjgZvRUmja40GVUwtjUe12
 w/gNKsJu+6TeN1WpHF73yQn4S/cZ6CeIaG+3D5H
X-Received: by 2002:a17:90b:4d0e:b0:39e:4c7f:7307 with SMTP id
 98e67ed59e1d1-39e4c7f9159mr1446575a91.30.1789661927504; 
 Thu, 17 Sep 2026 09:18:47 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:18:46 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:15:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: Re: [PATCH 07/14] common/cnxk: derive mbuf from CPT CQ in inline
 IRQ path
Message-ID: <20260917091538.4f82a48d@phoenix.local>
In-Reply-To: <20260917071016.2366467-7-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-7-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:09 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> 
> Populate mbuf from WQE_PTR_CPTR and CPTR_WQE_PTR completions, handle
> WQE_PTR_ANTI_REPLAY and CPTR_ANTI_REPLAY, and pass the mbuf pointer
> into the inline device work callback instead of a fixed non-NULL
> sentinel.
> 
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---

Patch 7/14 common/cnxk: derive mbuf from CPT CQ in inline IRQ path
------------------------------------------------------------------
Error: NULL dereference at this commit.
- WQE_PTR_ANTI_REPLAY now calls work_cb() with sa = NULL and
  cq_type NIX_INL_INB_CPT_CQ.
- At this commit, cn20k_eth_sec_sso_work_cb() still does
    inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(args);
    if (inb_priv->eth_sec && ...
  which is PLT_PTR_ADD(NULL, HW_SZ) followed by a dereference.
- The guard only arrives in patch 8.
Squash 7 and 8, or move the guard first.
