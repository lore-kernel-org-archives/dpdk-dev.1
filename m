Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BCCCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E2E740E22;
	Tue, 29 Sep 2026 16:36:06 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id AA23240E0A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:36:03 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a49b6bb21eso721267a91.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790692563;
 x=1791297363; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HxNion8QGx4/gSRAxd1MYeFuYHTug7N9xMKsgGpkJl4=;
 b=r7lRFcASWnMzokV0piGmfVpQa9DaGhrdPgtPe98ytY8vbP0hhlnSt8SVEn2Hx3wI4U
 Cv1WLlkiGEQiV5PoW+yijP9mamd63jh4wW40BAydTy98l0gP/ClcOnrPK0aTkZRgKDPA
 rgoYd3ic775VeKFYKMag3I6j382iV2NprnAGgxUxp9vLR6YhaEIocQKetVltJc6SZoeJ
 M/AQGTAbHOGmYJD/Bnd/omW+M4u8Ev/p3HyJrrU42ByEoNZ+KCc7E6wBqZ6C1X3zrvgG
 MTU2zkwOCRD6q2PHKtsHEt68sfzuQeqWyt21kPXv2SAN9enWx/NcnDvJcBwoIEIZ3skD
 nW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790692563; x=1791297363;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HxNion8QGx4/gSRAxd1MYeFuYHTug7N9xMKsgGpkJl4=;
 b=ySIpWsc3uL/3IeZnKybHGa28+hy4y2DxTtmJDMZ2OVSvULBBBFSvGHSp7ix2ON0+nv
 RNZHcFsqiG5urg+OAOVsyyoQVDVWC0aPXOoMmcs9WbRIfrrrRUFsVg32dXM/g6kkY3ht
 8v+JUsJDXOBCQ7NWjHFJT0EYlU//DsNXPCG+V5hDOdSiMmslmYJi3EUGa+vUKo/d/PwQ
 vB2yGT9A8ut7ES+IgoYOatscp8FLslC2ax9ocpizdoVAlLyllsxBUiS64WtEMKvilbNi
 sa3Kg4b0fHC8YNfTBLdWTYmO+pV/vWrSIbfxMqe86vxY82iJRULcdIByRBDMV0BOcKAf
 DC7g==
X-Gm-Message-State: AFq9FYIZXOTV1gpsosbfT2CRp3lanVyO/Q/pZBMrNyNuUYEXjsj3TSui
 X96pTXjGW4ue463R4cxX/Y3DNvRB9KqRyL3rNvAPCFTh50/oauf2kBfiibqe5mCWEGA=
X-Gm-Gg: AYBFou2BuRId7eWc4tUcIlQmcf27UvYm1WZlKk58sQ7dsOGavhnVkS+73nTPuSwNmwW
 i23eKIVbLA8aK/YtEzB35XRywFOwis2Sw/wiLOqRfrjoNr0H6YoxrAijmlY35dmzcU+lOvjVpoM
 pWAj+B4r+JUFaBs4DGfJccWqL0rZ5Mkj1NkxuJIqSKxqTsXrNyhYnbPo6FNRUc0ehoSEgbp31SX
 Xj2Xuxt21ns1eVU6yb3Gmg2BkCaTjVl6M+hn/EXqj+E54BCd8PmHXvzNReUQj45UoJesgBvMWsA
 yGjiPqmbDzJu4jMZ6M+O32hPkRsvSjWX1nVG2FFRrc/MxDz7OQ0Owa5YRFZeu/cqmwdvrTA9V6X
 3bnPIAtN0Inbg6sDYTVEDgblvH5Nr9L2Fop29pM/Y2mxfPpE/wfRsyaluQO/gXYx8ItdsmGa+UN
 ebHdAPsnelxUfzyHfij6GevKRhLRG0VLfdQNCrGwQmatsH16YT++2f/2szCpV9SK+NzpSHZj/7w
 Opch1yGVLhuyvUjlBdSXzioPYr5WqKxBDsNtRaPDuVhV3euwbYLCKaR7xs7JA==
X-Received: by 2002:a17:90b:3908:b0:3a0:c20b:2fdf with SMTP id
 98e67ed59e1d1-3a0c20b3132mr8126753a91.17.1790692561565; 
 Tue, 29 Sep 2026 07:36:01 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4b86052ecsm307407a91.4.2026.09.29.07.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:36:00 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:35:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/3] improve NIC features matrix
Message-ID: <20260929073557.1a12df02@phoenix.local>
In-Reply-To: <20260923032502.770744-1-thomas@monjalon.net>
References: <20260923032502.770744-1-thomas@monjalon.net>
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

On Wed, 23 Sep 2026 05:20:48 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> The style of the features matrices is a bit improved.
> The table header cannot be sticky
> without losing header highlight on hover.
> So instead of adding header stickiness,
> the table size of networking drivers matrix
> is reduced by removing some rows.
> 
> Thomas Monjalon (3):
>   doc: move CSS of overview matrices
>   doc: improve style of overview matrices
>   doc: simplify NIC feature matrices


Applied to next-net.
Hopefully, the whole ini file to matrix process can be automated but
that is bigger effort.
