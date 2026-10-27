Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAA606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TXxTQC8u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CFEE400D7;
	Tue, 27 Oct 2026 15:00:03 +0100 (CET)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTPS id 5908E400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 15:00:02 +0100 (CET)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so2794163a12.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793109601;
 x=1793714401; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pTBxXIDGNShH2WpJ+KqQC4G/+RSpc/kZeSV4TQ9eKuE=;
 b=TXxTQC8u3eWmRlxdmD74VK1DYCOdwKR9Aaq1Lkaxlclk36H5JQr4RlYaCuefTEjQ7J
 yT5mDdKC0yDsMqDUgnMb13c/Ne4w/mPshMQpPtf0Vl6vM5D6HtZZuCAP99BFebQmaSCs
 SSxmb2Xxen4xDnTJ9lEWawbDhourrrAPuT5JfYwQpKjPkMp8az7fTRzRp/dz8lhYxazz
 j1Sd/ZLR7ES/WW06X7YNyKgkRCUus5W33Wb32B5XeykY0r0HlvggQacK5zxj9m6wVXgP
 v26W0Wed0kDsBeYJaqsrkO8ePch8zBiQMc/qC+/+LO4TEiLRawMb0reJvLofP+Ccfa1d
 KWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109601; x=1793714401;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pTBxXIDGNShH2WpJ+KqQC4G/+RSpc/kZeSV4TQ9eKuE=;
 b=migt8ijYk7uhKJXpqS98q23XUumDomUF7j6zgZBlk+oan+RS7D0KCDS/5RPI7yxPAs
 N+NXPqUTZcC4t3ur4/MKZvI279xo5eiqIhaJbI9qtVdBsubPUQWf1AnCZOxZN1xEk3Mq
 YN7MPJymQgADexUy0vKjJ/A/6eDVePONu9Pf7GchicEQOK4H7xYI34PXhYaq61T/OC3u
 h3nZKxYtVeK7J6xbOS4rvuc9BIqHHU+GHLUcTYTrHVcLurS6gQnJveI6N7wfmnyStUSb
 fspw/PGSMmihgck/of3piohmT9C0Hr3afLg9hhGIYCN3X8cSUmfsahsoIbOMvAKdlgOj
 F6Kw==
X-Gm-Message-State: AFq9FYJJIScienofwLhWgDHXqnzc9otqGQxqaPvOlCIrCxz+NolXqfBA
 hBtiuCb5Q5I24NmhkEywRKZnaQplbwvclotsy7MkicypM39z+m5ZuHxU+9/HgLMwycc=
X-Gm-Gg: AYBFou0yxGQDzlvXsqOdCoo4lT1+XyEyhxAmabyTZZnMsbXxGsd1zsfwAqhljXBNTiq
 0EOZnTmHxp+ZcDdRqjfsmzSQj2XZ5d8ZswceoOMypiNFE8WE3ZIL9f06Gg+XzzkcNQ8AHA4cY+7
 z32JI+rVrP1roHDFpRj78jU5PZe5rZUS9xAxzvUE7nSc6W9i7M6wpXG+Zu39knF1pHJBl+/O5nc
 e6B+ZgPHX572ici+p8kDNTt4i6u2tb9gi9U/nI6PpQWne6M4vjxWi4WWJVSB2ze/VHH7yuy7Sit
 uukE1zcE7hKgzQWYWtjzG09VpZobdAJCOeTuLgnTJerPpvi2hoR/atEzuE7OvCX0LY0lU4qnxA2
 DpwNUJGtPIsIPiHhlh+fqlzpDY16a47B8UioGRSmYbSIn5LckhP7dxeP2+tTWJA7Tosp0id4xt8
 rnp3UUNfVfMUcQHtx0Pj+hVJ8uzXzKdLee1QDsTGSbt2j1Ij1YzYZNUnFAkChiGWrqtli5+yI55
 /69l2thUUdr7H6sN3lGSBMz6Y9UgkxusCJB3XVGhlhUOr4351g8oQrXFn67fxUdFkHObtelmgdJ
 c9xLOMye8FC4GqPGfmiwmrg=
X-Received: by 2002:a17:90b:5805:b0:3a0:b312:1fbe with SMTP id
 98e67ed59e1d1-3adea899396mr7895732a91.23.1793109600641; 
 Tue, 27 Oct 2026 07:00:00 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm4150813a91.0.2026.10.27.06.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:00:00 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:59:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Andrey Vesnovaty
 <andreyv@nvidia.com>, Ray Kinsella <mdr@ashroe.eu>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Jiawei Wang <jiaweiw@nvidia.com>, Haifei
 Luo <haifeil@nvidia.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [PATCH v4 3/6] ethdev: fix missing flow action descriptors
Message-ID: <20261027065953.7505de59@phoenix.local>
In-Reply-To: <0830b411294b86d984626eb4b974a2fcb5a1d4be.1793094529.git.anatoly.burakov@intel.com>
References: <5698ccb3daeebd1d50346d5a3bd8471468056463.1793094528.git.anatoly.burakov@intel.com>
 <0830b411294b86d984626eb4b974a2fcb5a1d4be.1793094529.git.anatoly.burakov@intel.com>
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

On Tue, 27 Oct 2026 09:50:10 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> RTE_FLOW_ACTION_TYPE_SHARED, RTE_FLOW_ACTION_TYPE_METER_COLOR and
> RTE_FLOW_ACTION_TYPE_SKIP_CMAN were never added to
> rte_flow_desc_action[]. The table uses designated initializers, so
> these slots are zero filled: their name is NULL and their size is
> zero.
> 
> As a result, RTE_FLOW_CONV_OP_ACTION_NAME on any of them passes a
> NULL source to strlcpy(), and rte_flow_copy() as well as the action
> conversion operations reject any action list containing one of them
> as an unknown action type.
> 
> Add the missing descriptor entries. Preserve the deprecated SHARED
> action handle directly, as for INDIRECT, instead of treating it as
> configuration data to copy into the destination buffer.
> 
> Fixes: 4d9fd85fb545 ("ethdev: add shared actions to flow API")
> Fixes: 5f0d54f372f0 ("ethdev: add pre-defined meter policy API")
> Fixes: 6807e8b52a18 ("ethdev: skip congestion management configuration")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Applied to next-net.

AI saw some sequencing issue here which might make backport harder.

Subject: Re: [PATCH v4 0/6] ethdev: flow conversion fixes

v4 addresses the v3 feedback. SHARED handles are now preserved
alongside INDIRECT (3/6), the INDIRECT/SHARED conf write is bounded
by the destination entry (4/6), and the new truncated-buffer test
walks every size from 0 to the needed length, checking for writes
past the end. Series applies cleanly to main and each commit
builds with -Dwerror=true. Fixes: tags resolve correctly.


[PATCH v4 3/6] ethdev: fix missing flow action descriptors
[PATCH v4 4/6] ethdev: fix indirect action conversion with short buffer

Info: consider swapping these two.

3/6 sends SHARED through the INDIRECT branch while that write is
still unbounded, and 4/6 then fixes it. Both are marked for stable,
so a backport of 3/6 without 4/6 opens the overflow for SHARED as
well. If 4/6 goes first it applies on its own, and 3/6 then simply
extends an already-correct branch. The SHARED sentence in the 4/6
commit message would then move to 3/6.

Not a blocker.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
