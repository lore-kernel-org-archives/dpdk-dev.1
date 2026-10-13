Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADBECC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B381C40274;
	Tue, 13 Oct 2026 16:46:01 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 0227740272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 16:45:59 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1783684a91.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791902759;
 x=1792507559; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qZmk3oWDtq9n6Dv6GPKw4bpNQ/sAJ8NvSPVhjSKO4t0=;
 b=XQBu7ioV/9mtoRNGNSc0jrKOV18iUxbPMOybxRioIV9Aa5HB2wQd82H7Ibbz0FkKmb
 1dNbVwVU7JQjfbzgeX84nm8lN43lCFyQuRMFQspKzRHiXNChVBLhbOuiHh29/oFgaQfk
 70TqI9xsWFVB1k1IO+DzOtBBNtfmCNlhZrl97mE+rJ674zixk77kFlo5gnpFjN92uKWO
 98vvRpcW+sR3wfUc97qgQODD2B8e2o3vvZq/4pGY9ButJfqPzNXLwPLw8hA0+uwGmZim
 Z6nMgjcDILC3zHzyzejh9GO8Gy4dypdR8/zqoliLO4c28tqgfU8Wjv/t4ok+PCrJV97R
 1vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791902759; x=1792507559;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qZmk3oWDtq9n6Dv6GPKw4bpNQ/sAJ8NvSPVhjSKO4t0=;
 b=CvBZjo+dMEoT8lBKJACY07omCrtjU8uxcg+M3qhxp83hR4fHW7AzlVk2BnuS+2+vNl
 yc5gbAqjRKXJGJskqewjdm3/5iPBeERSW3/PfRb7PE+6QKNcSTY0J5O9OV1aLAITL93h
 HtrHFhizempCyu226ELwWe3ZaxqhUJUCrHqptzC86xhfPAoM9THrwfybPjhjZtl5b+Jh
 ukJJscLZtfzry96jg52+Kqi/wWZ3iT1gg2wi5e+4kW0I0BWdco29gquU3qYRWjzq+nXk
 +CdLmZhHVe37m9sx8odTgnWIuUkMhKWltvdbQzWkH5MTNcP0KWqNGOa2gZ4MwP6+w6zD
 ORzg==
X-Gm-Message-State: AFq9FYKGBZXsu4mEch2JYhOi/NzBhHk9X+dYnZXfU6juBjCnHsSpm4mS
 XVszV1/WbF7Rk3faODLYJxFqUljg7MoIArKvzaWlGFy+E+7kvR62tzxcnwnBb77XSoL3fF2dAvP
 DNeqN
X-Gm-Gg: AYBFou230xAeknUBcl2iT+f2wlZ7rGBJPegZJ5PEYIjUdWc/VzEjE+yBbnSGR6zSVar
 UPhG/ZiWqeEja6GgPU6nY0QPjmtFmuMR31PxMr/Sic//qPRfHeQVG6TP+OucABRN6k4PyI2brRs
 DVM8CGVQLdykwHvsAQK/Y+4lPmw2WVgSQRdUagXMgeZEw5PXBwSu7dkcteMClOFs76V4x81RhMa
 rI3PgtoZ7E3kQZhxMw6aK6csKTSq3QlSf+2g+IIFit3iIoRUzt0XMD/1TYQNN1XrMxjLXs5EWt2
 6qxfIrnrTNeWKCg9WHclvcqeii5vL9K+bbJMvkzMlK64Z+JAxOrpaQijHGPNIfZTk/bjIzVDbjH
 GFFipTA/b2S30J1jlEZh04TtsWqgIWTB4G92ttAZvFzkIA5uMEjNH0Jow+xi8Gk3qN4NLBhE8As
 Fdm0RTdHqUbTpdVG2SBqmaCh8vagVQG0o1bpxtJuy1PCK0FVF2rRMRwg1Il1wvdees5ZWPWHmY7
 CAok3IV7qhLnARh242MNGkkxwQxdU3FkFUrwtHs
X-Received: by 2002:a17:90b:2b50:b0:3a8:609c:7a6 with SMTP id
 98e67ed59e1d1-3ab3a8e9100mr10098258a91.44.1791902758793; 
 Tue, 13 Oct 2026 07:45:58 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371e2833sm22517295a91.17.2026.10.13.07.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:45:58 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:45:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org, jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com
Subject: Re: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
Message-ID: <20261013074555.1ab5dc7c@phoenix.local>
In-Reply-To: <cover.1791898970.git.zhtfdev@gmail.com>
References: <cover.1791898970.git.zhtfdev@gmail.com>
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

On Tue, 13 Oct 2026 22:00:16 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> Enabling Flow Director reduces the Rx packet buffer 0 to reserve memory
> for the filter table, but the size was computed from the current
> register value and never restored when FDIR was no longer used. Since
> the FDIR mode is reset when the last rule is removed, on flush, or when
> enabling FDIR fails, the next rule enabled FDIR again and shrank the
> buffer once more, until it underflowed. Validating a rule also enabled
> FDIR.
> 
> Patch 1 computes the buffer size from the default packet buffer size,
> which alone stops the repeated reduction.
> Patch 2 stops enabling FDIR from flow validate and rolls back the mode
> when the first rule fails.
> Patch 3 disables FDIR and restores the buffer when no rule is left.
> 
> The same issue was fixed in ixgbe:
> <https://patches.dpdk.org/project/dpdk/patch/20260927042545.45152-1-zhtfdev@gmail.com>
> 
> Compile tested only.
> 
> Zhang Tengfei (3):
>   net/txgbe: fix Rx packet buffer size with flow director
>   net/txgbe: do not enable flow director on flow validate
>   net/txgbe: disable flow director when no rule is left
> 
>  drivers/net/txgbe/txgbe_ethdev.h |  1 +
>  drivers/net/txgbe/txgbe_fdir.c   | 36 +++++++++++++++----
>  drivers/net/txgbe/txgbe_flow.c   | 60 +++++++++++++++++---------------
>  3 files changed, 62 insertions(+), 35 deletions(-)
> 

AI review saw a warning that would be easy to fix.

Subject: Re: [PATCH 0/3] net/txgbe: flow director state fixes

Applied to main, each commit builds with -Dwerror=true. Fixes: tags
check out.

Series looks right overall; one validate regression in 2/3.

[PATCH 2/3] net/txgbe: do not enable flow director on flow validate

Warning: validate now accepts rules that create will always reject.

txgbe_parse_fdir_filter_normal() can set
rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN. Before this patch, with
mode NONE, parse called txgbe_fdir_configure() which returns -ENOSYS
for anything other than SIGNATURE or PERFECT, so validate failed.
Now parse only checks for a mode mismatch, validate succeeds, and
create fails later in txgbe_fdir_configure().

Keep the cheap mode check in parse so validate and create agree:

	if (rule->mode != RTE_FDIR_MODE_SIGNATURE &&
	    rule->mode != RTE_FDIR_MODE_PERFECT)
		return -ENOTSUP;

	if (fdir_conf->mode != RTE_FDIR_MODE_NONE &&
	    fdir_conf->mode != rule->mode)
		return -ENOTSUP;

[PATCH 3/3] net/txgbe: disable flow director when no rule is left

Info: txgbe_fdir_disable() restores a single packet buffer layout
(PB0 = rx_pb_size, PB1-7 = 0), not what txgbe_configure_dcb() set at
dev_start. That matches what txgbe_fdir_configure() already does, so
FDIR with DCB is already broken and this is not a new problem. If
you respin, consider saving the PBRXSIZE values before enabling FDIR
and restoring them on disable, or reject FDIR when DCB Rx is
configured.
