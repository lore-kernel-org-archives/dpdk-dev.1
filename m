Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2361C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 12:53:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E09E40150;
	Thu, 20 Aug 2026 14:53:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D526B400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 14:53:15 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50939153B;
 Thu, 20 Aug 2026 05:53:11 -0700 (PDT)
Received: from [10.1.36.55] (unknown [10.1.36.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5FA3F85F;
 Thu, 20 Aug 2026 05:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787230395; bh=pH82mKmTq9N5lFzKce+akbIaAcDMYt+H7Q9mUt1H16w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aTsS5m60UyZ6kmP6n/qU8NijOjndOBTQaevSHmoKtVLSTc1eu2aY23Gm2f1YMDqRc
 ABnX9HfzpfvlYps+X4aLfxURDlnhdCchqBVrI9Y5lgQ7RWMxItbxJiD4nROgLeaBkk
 p1BxonTiHvSlsnbl0HvIbGGArvYt9gwilOjnTfv0=
Message-ID: <167961b3-08af-4d32-aa72-a9cf2438ab2a@arm.com>
Date: Thu, 20 Aug 2026 13:53:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dts: fix TRex packet stream handling for line rate
 testing
To: Dillon Ladd <dladd@iol.unh.edu>, patrick.robb1997@gmail.com, dev@dpdk.org
Cc: knimoji@iol.unh.edu, llavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
References: <20260805192732.464422-1-dladd@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260805192732.464422-1-dladd@iol.unh.edu>
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

Hi Dillon and Andrew,

Thank you for your patch and so sorry for the wait! This looks good to 
me, I have no objections against it.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>

Luca
