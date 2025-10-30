Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A61CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 18:13:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F176140609;
	Thu, 30 Oct 2025 19:13:27 +0100 (CET)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2441E4026F
 for <dev@dpdk.org>; Thu, 30 Oct 2025 19:13:27 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-44588e94decso754018b6e.0
 for <dev@dpdk.org>; Thu, 30 Oct 2025 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761848006;
 x=1762452806; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc/FmoWnKs11Rgp6msbHwfoQKHRiehnElMuII99D16Q=;
 b=z9cs9CVOOalTw7heJtYgcIwm/e3IrX0k1N52YNRldoGPtGkw8ca430LD0wiv0nNdTb
 h8jU1vS8xllDTyogWjo476mhjCb2pxFTGrN8XJxXehh0C6NfLHWh0qGvQbOW98hbAB4I
 4OfYLLKm2cWY3kHkpW2xRoBzbf0vCWuAi+uQ2G/wzEhpxYC99gpUJbLfAaF6PluHrrN6
 dE67O2AH6LCSJtoXDDN0//bDnKPP6SWg22uK+9LnuLC01iq7RIgjCmpbnCnER3X5pXMw
 pCLoJFk5VXJvYUqhXcOm5wdJYDlkurn6md/q5KKfRmpI4FgKBFVgleFVApQzTOQSKrb8
 we1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761848006; x=1762452806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hc/FmoWnKs11Rgp6msbHwfoQKHRiehnElMuII99D16Q=;
 b=xPPJg7CDQ1Sg/FasijHU7KOwqFb9V3ZwpVChGf9H3hynhyc9/702AmXGcy6sKkr7QM
 xAms5eRltsFBp2Ck1vN4BON8lDA4Smac8piM/hxLwJEMgaR9eu4G5wX1qMvpDrD45r02
 Ch8EeQuk0Qq132M66W+Cj+wL23yyWsJ2j17HpEhXo0/kPu2EByszNG6NlpfYr+CZvZ1A
 MA9sLOWfq817VQ9Z5huaZ1LWu6l6QoECov+Mr624xxAImyZr4trsSvYYDiyUkg0QMDxQ
 Jt1QZsqWqzQKqD3XWPjSyb6zZIXoLaNTgsaqieb9dShPONvjO2Y4c84aP3ILI+Gvxfdr
 t5UA==
X-Gm-Message-State: AOJu0Yx64/LChP54C4ophoX3mcEvAZv0z4Q4JzmvQp0uRiACmVFc5PPr
 RsuXrlg3WLELCWiLOObI6pudMabq+F4Bs/33wH8B50VzsbLl57xOdIm38e40aH1aS2Y=
X-Gm-Gg: ASbGncvpllprG8RFBdzo2bKQ/2KPIjBb09iomZ01XPA7kZtES33ugHz8sg31292bhBC
 MdmRB/axPMBugqPKo+EJAFYADM6aNh3J1+7ib9DMx2kCsbclwq+HqjPIRfCPYKPHUdD2GsFeMrW
 MXI59krGXBzNgZz3Jsm3TLVpzPNfJG5T8JO2jzsHQQnG8NowQK2gRR0C7Xoroqz6ljkrxzAzDrF
 QMO1qYfID1SqcZUkADQeTXYxc6YAw7ZouTzfgJSpkTTU9iaW1JBuEA9rvEjGJQdr13cVen+NWx5
 +Jj6ZH/Wf8SDBFEYQG1Z0HM4cSbHF8OwqYTOKS3VxuBdwC+Kg74DHiVDSUQveRVFgOj4TiqdqIJ
 MCu7IS/MLD/jv2rCDRQpIBbGpZoIdoWTEmAbway7EG6xkxvsLgdc1XurQEuhakymN02Q1XVXCef
 Bs03wb+ncyEEvQYNzMgRbPNC8SuuilULXtzA==
X-Google-Smtp-Source: AGHT+IEc+m1JINg7+uAPBmOfmvxZzGIfLLhsVhujl+dSfvQ3MnIcDI+VUY5aUoovm4dNiqvh8JATcA==
X-Received: by 2002:a05:6808:c175:b0:43f:ee6f:3c06 with SMTP id
 5614622812f47-44f889b9146mr1897419b6e.2.1761848006108; 
 Thu, 30 Oct 2025 11:13:26 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef272edasm4482714eaf.1.2025.10.30.11.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 11:13:25 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:13:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v4 0/4] net/tap: add network namespace support
Message-ID: <20251030111322.024d4332@phoenix>
In-Reply-To: <20251030175537.219641-7-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251030175537.219641-7-rjarry@redhat.com>
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

On Thu, 30 Oct 2025 18:55:39 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> The TAP driver currently uses ioctl operations which are name-based and
> namespace-unaware. When an interface is moved to another namespace, the
> driver loses control and cannot track the device.
> 
> This series migrates to netlink-based interface control using ifindex
> instead of names, making operations namespace-safe. When an interface
> moves to another namespace, the driver detects RTM_DELLINK, queries the
> new namespace using TUNGETDEVNETNS, and recreates netlink sockets in
> that namespace to maintain control.
> 
> Tested by moving TAP interfaces between namespaces while running
> testpmd. All link operations continue to work transparently after
> namespace changes.
> 
> v4: added TUNSETCARRIER support after moving to another netns
> 
> v3: added release notes
> 
> v2: completely removed ioctl-based implementation
> 
> Robin Jarry (4):
>   net/tap: add netlink helpers
>   net/tap: replace ioctl with netlink
>   net/tap: detect namespace change
>   net/tap: configure link carrier
> 
>  doc/guides/rel_notes/release_25_11.rst |   7 +
>  drivers/net/tap/rte_eth_tap.c          | 437 +++++++++++++++----------
>  drivers/net/tap/rte_eth_tap.h          |   5 +-
>  drivers/net/tap/tap_netlink.c          | 291 ++++++++++++++++
>  drivers/net/tap/tap_netlink.h          |  10 +-
>  5 files changed, 566 insertions(+), 184 deletions(-)
> 

Queued to next-net
