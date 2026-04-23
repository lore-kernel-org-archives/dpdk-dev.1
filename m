Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6DDFC0343
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 15:06:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E67E40272;
	Thu, 23 Apr 2026 17:06:00 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 2EB2E4026E
 for <dev@dpdk.org>; Thu, 23 Apr 2026 17:05:59 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c7212836bso570307c88.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776956758;
 x=1777561558; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=p6DXohtPAUi4wOJm/8Q09Q5skQbfVmpApiK6RI5QZgo=;
 b=Z0JQ4wpDUWh+5H5CS75rRMN04WemMoBHJCd0eJOahez0mkany9ArMvFfyQohP4w9/X
 3iqf3lmf3HnW99FfvZGInzj1U0k39LEKeajnsvZ3mQ2zhWSyaNhdYuotSiwx7b2xdznA
 mktUiAospTpBif78auYe5SUltUdgUjcsPO3d3pS8a7P9mOeBsu0gdQMX3QIkv1bfYrFa
 4sFRW9Fu4SdX2o2EHTyXb4zRmbntjztzHLqdX3Qa+NGW0tcqKCqEit9QH9XI3Ln+Lt8m
 ahaMzK0vZjmLn7FWYa/pOni1xijgCeOGhDdi9WWVTtrMMXfi9njsnOeYi6h8NVKqs0Uf
 opmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776956758; x=1777561558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p6DXohtPAUi4wOJm/8Q09Q5skQbfVmpApiK6RI5QZgo=;
 b=l0En4sPwF1ba7aKAVx3AaR1INlzngTV1MsY1QkaPOefIylQTAINNZsfIfwp2AjttQU
 yf9foeaIeQHoqZU2Hfgqi0MWB0KVYxdrRwfF2mciLZiTcjERsJqIw2x8LSFe0vOJWDLb
 ZxyFVyNzxlNSIBRKQSmHjtnOv9LHt6mSaXi7ITwM/wc2Af7DXxEA3KIf6ehyvGfapXHd
 vVqvjguQ/ZYjHs0U/DvuS3wGskzgYIzZTGurshY3r8NkIqiy1xWSffEdwFGA7o0U/Lqg
 vY04XhhLaMHsTCtt85d9QAmVWlOV4xqqrq3F9CxbLyu7R72hspM2zXisULgiTC5Oz+K5
 cqdw==
X-Gm-Message-State: AOJu0Yw4bkm0dP0hrjOIYZniLs5CtNWtJnUBInBqwjTy5JCHFsFcVDfJ
 4RQqixpCjdo+YAwcITn7hr21AoHulSADwIfZ/hrBGNQZFIiOAPxmfZd1PGGwPe3+VCWs5brnJfJ
 o/hzC
X-Gm-Gg: AeBDieviuLVAmpBSofYWYRzpsnor+VslJsIMJMDQ40BxhOJUzejUDp+wII7PRs0Mqww
 eUDEyfGs0NkLiPr36c0NvG2QeW26gOvF5uMPEUw7gWpqegDqfu61y6YJGPfpZigoE9NIPfigdat
 om35FvhUr8Y5p2qqGVMTPgJ3iP1kmCfJ3cb8fuX2DMemXoMe1WXJ/hhnsP5QPE+Jjs4amrYfBgr
 ouPnruiBBgMP6v20hhCOrWwoEtxwVP5s+Ct6dkuZQdHOrMjqshf+Klh1c1o9tVTkEX1yov/RNGQ
 0/ymbjVzF4gFYAaJ90NWnitWVmCSMWXp7HfdCNzKviAWxPlG+8zVBM32FCqDLjj3lMtpJxnr6Up
 eFOX8J7NEoQ5LDL5SRcAohswb+49CkwkPr5MXeyyFEubub50azi1pO32aW/PHsrPHJrCIfWRShy
 VoLYoxvw6ZENvRsE+DJ3t+Ubt9e4jxIprFI6a2QDU70PVphw==
X-Received: by 2002:a05:7300:bc97:b0:2de:6fac:f666 with SMTP id
 5a478bee46e88-2e4792151e8mr16597353eec.27.1776956757546; 
 Thu, 23 Apr 2026 08:05:57 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ccce0f5sm27653711eec.17.2026.04.23.08.05.57
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:05:57 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:05:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v2 0/6] fix process shared pthread mutexes
Message-ID: <20260423080554.055d6069@phoenix.local>
In-Reply-To: <20260414144246.110681-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260414144246.110681-1-stephen@networkplumber.org>
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

On Tue, 14 Apr 2026 07:39:52 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Several drivers and the ethdev layer initialize pthread mutexes
> in shared memory with default (process-private) attributes.
> This is undefined behavior when secondary processes use them.
> 
> This series adds PTHREAD_PROCESS_SHARED to all affected mutexes.
> All are on control paths (firmware mailbox, hotplug, flow ops,
> PHY negotiation) where sleeping is acceptable.
> 
> See POSIX spec:
> https://pubs.opengroup.org/onlinepubs/009696899/functions/pthread_mutexattr_getpshared.html
> 
> Bugzilla ID: 662

I would like someone to review and ack some or all of these patches.
