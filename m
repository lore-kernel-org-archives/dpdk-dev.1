Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FFAF589CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 13:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A32724026E;
	Thu, 23 Apr 2026 15:10:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 714574003C;
 Thu, 23 Apr 2026 15:10:36 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D185A1C25;
 Thu, 23 Apr 2026 06:10:29 -0700 (PDT)
Received: from [192.168.100.217] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79DAF3F641;
 Thu, 23 Apr 2026 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776949835; bh=GV08LP66CzT195R9BXeUCeUPAmYUZSxHmZGUF2ZvUuY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RYBxgy3XTG/laWce8y2xW3NIea4IzDzBWi4PPBGDMFA25LuYKhfcrc1gD5Wd/lHge
 HwECdygILzHMWgQ0NuElYvxSL124gsVRVAKh604TBTmDmcnlXn07oFMoxMTlQ9mzaP
 LkkAJYl+bkgHApG4VjcTVDQdvwUnTYqDQEl8CKRE=
Message-ID: <fb8f96a0-f497-4ac6-907f-1cd770770dee@arm.com>
Date: Thu, 23 Apr 2026 14:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: fix port info getter when port is not found
Content-Language: en-GB
To: Riley Fletcher <rileyf@linux.ibm.com>, dev@dpdk.org
Cc: stable@dpdk.org, patrickrobb1997@gmail.com
References: <20260422183524.2012369-1-rileyf@linux.ibm.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260422183524.2012369-1-rileyf@linux.ibm.com>
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

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
