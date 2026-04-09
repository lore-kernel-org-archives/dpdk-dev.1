Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57418EA3C5D
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 13:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8760C4028F;
	Thu,  9 Apr 2026 15:16:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 51F3840276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 15:16:56 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED682F9D;
 Thu,  9 Apr 2026 06:16:49 -0700 (PDT)
Received: from [192.168.100.251] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 846DF3F641;
 Thu,  9 Apr 2026 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775740615; bh=c7/qF5I4EFlEfxxaXJLiucPK74S1z/i27iwxdZ2KQ08=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RYnTM6xxvLW4lhz6pCc6P7QMHtU/uVNDUQlREURfA6QDf8ctJ+LE53wdfanTN0fHt
 wZ1oiMQQwgXSyNf7B756E19McfGrFhcWhvNiAMm8W7puYg41JytZYeK68bEvug5syf
 rNRO7io2y1Hymmbb1t5Vsv/4wbyeoGvaUEQa0Ato=
Message-ID: <d0e14173-58e2-4260-9a9e-e33fcff73c3f@arm.com>
Date: Thu, 9 Apr 2026 14:16:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dts: update modprobe command to be privileged
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org
Cc: probb@iol.unh.edu, lylavoie@iol.unh.edu, dmarx@iol.unh.edu,
 knimoji@iol.unh.edu, ahassick@iol.unh.edu
References: <20260403183519.496825-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260403183519.496825-1-abailey@iol.unh.edu>
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

Hey Andrew,

thank you for this fix.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
