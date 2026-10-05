Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA5CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 00:27:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6489B402B5;
	Mon,  5 Oct 2026 02:27:02 +0200 (CEST)
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
 by mails.dpdk.org (Postfix) with ESMTP id 6289C40290
 for <dev@dpdk.org>; Mon,  5 Oct 2026 02:27:01 +0200 (CEST)
Received: from [192.168.0.40] (unknown [37.228.233.98])
 by smtp05-ext.udag.de (Postfix) with ESMTPA id 28094E0273;
 Mon,  5 Oct 2026 02:26:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1791160020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gNdasJxSEUmgFXTvHhnYD3/f/8tpCVB/LdRlnh2teA=;
 b=Zab/Z95h6jVDvIT0VMZLKArlM/AKB1HwfFlnia0/iRwW0jcEwz9Mriipsvi+hrXitHosB9
 G1la4EbUiSWDG+v+nDXh8L32/mGGDYBCGCD5ZATW/Lqz82p5PDH2mtdi3KdCv4Ste1Llio
 8ayGhCQzuge6Zw0g254OpAN8aRqAkGVpw8hpUi7k3NZ1K2JeWPsNGRAHJ7m+nYNhGBww/f
 vbjsdHp9HABwlXIgWyJgzqlkC9jSZyaAuRrLGhHNQkbY+aQkStDGcGbFTRd/owFiZoUOrP
 hZDwnVDRuLL71EEe4MGa5kk9zYzDrjeCc/VgmIm50TD4k8ZiQ+96pkyj7l1wsA==
Authentication-Results: smtp05-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
Message-ID: <44bdff98-9429-48f1-b284-063cbcf2e42b@dressler.pro>
Date: Mon, 5 Oct 2026 01:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/af_packet: add capture direction option
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
References: <20261004042255.1517316-1-frank@dressler.pro>
 <20261004091057.2c0fb83a@phoenix.local>
Content-Language: en-US
From: Frank Dressler <frank@dressler.pro>
In-Reply-To: <20261004091057.2c0fb83a@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/4/26 17:10, Stephen Hemminger wrote:

 > The AF_PACKET PMD is special case really intended for monitoring
 > applications, not for general use. You are probably better off using 
AF_XDP
 > for general use.

I agree there are cases in which AF_XDP is better, but it redirects 
packets from the host stack and needs bpf()/XDP. The AF_PACKET approach 
allows for passive monitoring without taking the traffic and works even 
when there is already an XDP program attached or bpf() not allowed.

 > The kernel does have flags to filter by direction, so you could
 > avoid having it be done in the PMD.

Thanks for the hint. It made me find the PACKET_IGNORE_OUTGOING sockopt 
(Linux 4.20+, fa788d986a3a). v2 drops the capture_dir=<in|out|inout> in 
favor of ignore_outgoing=<0|1>.
