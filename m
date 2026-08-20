Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4BC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:50:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B1AA40150;
	Thu, 20 Aug 2026 15:50:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 402AD400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 15:50:38 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F1A7153B;
 Thu, 20 Aug 2026 06:50:33 -0700 (PDT)
Received: from [10.1.36.55] (JR4XG4HTQC.cambridge.arm.com [10.1.36.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131343F763;
 Thu, 20 Aug 2026 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787233837; bh=t0wxkk9s93D5OY+lRMewhaPyfeiZWKzsjZkKPSWNd3w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BBS65N9KG1h13yxmnDZ/xG4uvsX9DpOR2j1sGQbLV21vl53G/3q0VyydPUupWwxrO
 0G/kucd90gMEepHpUPGm/mPBk90Z0PY7n36PG+D9Mk+0Tu4ELitEpxC4rXdmGyt+/6
 boZUatfaDyxJhFXmpra/4g4m7xZta/t+0URfhb2s=
Message-ID: <afbaf065-9927-4273-bc81-02f3d2fd865c@arm.com>
Date: Thu, 20 Aug 2026 14:50:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] dts: move utils from framework to API
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260807161642.122310-1-abailey@iol.unh.edu>
 <20260807161642.122310-3-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260807161642.122310-3-abailey@iol.unh.edu>
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

This is a bit trickier as the utils do contain a lot of implementations. 
The idea behind the API package is to just provide interfaces and not 
actual implementations. I am not too fussed with just porting all of 
this over just because it's misc utils really... but it's not my 
favourite solution either. Can't really think of one either unfortunately
