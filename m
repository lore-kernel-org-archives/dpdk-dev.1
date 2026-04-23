Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CECBF589D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 13:15:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 221AD402B6;
	Thu, 23 Apr 2026 15:15:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E59644026E
 for <dev@dpdk.org>; Thu, 23 Apr 2026 15:15:34 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D53F1C25;
 Thu, 23 Apr 2026 06:15:28 -0700 (PDT)
Received: from [192.168.100.217] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA1B73F641;
 Thu, 23 Apr 2026 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776950134; bh=Qkah2RacDnBFWEvYCEnmVfkeCA5oMl3Fm23U4Pj6cGc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X6tgoWsfSzpp/fMfXR/lUbeVKslxTGd8/7Y7g2icOFx+moVT6bQfiO/CxuNq4OcfO
 m2zk7YGc2SzZOZ2HaWWO8xDvxAEIa47Wwgr4cBnrmMDyNU58VJSFa5hJcs59chdnx3
 Vz5d0hwkTLah7LjNGRReTRKIqusbLbq/BzYs/IJI=
Message-ID: <48c25ced-0c92-46b1-bf6e-f9ef8d1859f8@arm.com>
Date: Thu, 23 Apr 2026 14:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: update dts maintainer email
Content-Language: en-GB
To: Patrick Robb <patrickrobb1997@gmail.com>, thomas@monjalon.net
Cc: dev@dpdk.org, aconole@redhat.com, lylavoie@iol.unh.edu,
 abailey@iol.unh.edu, dmarx@iol.unh.edu, knimoji@iol.unh.edu
References: <20260419194836.27602-1-patrickrobb1997@gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260419194836.27602-1-patrickrobb1997@gmail.com>
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

Acked-by: Luca Vizzarro <luca.vizzarro@arm.com>
