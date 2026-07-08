Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB22C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2636540268;
	Wed,  8 Jul 2026 16:49:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B4A4440265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 16:49:41 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AA321CDD;
 Wed,  8 Jul 2026 07:49:36 -0700 (PDT)
Received: from [10.57.81.169] (unknown [10.57.81.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEEDF3F7B4;
 Wed,  8 Jul 2026 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783522180; bh=6k+WYD5sV9HkRaJVNTa9aD00ECCYFCxdZHA4bZ4rmpU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lcnxrLEjiTrqISxa4w6cC5jdlkoeXMOtGaLKeeUHwxnkuXmKWOJ0Yyy152JofqVSF
 NQcBy4w76v3emoREpTUP4UI834Umr1wTAvO0mt9LKXgrU4kRr8BZxl7zKmtyh/jXl5
 zkIT/vztNDzzKrRQEwi63lbVeEq3PVC7r/K3FBI4=
Message-ID: <c64ad156-9ccb-495c-8642-e203a6a2be7b@arm.com>
Date: Wed, 8 Jul 2026 15:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dts: resolve new formatting error
Content-Language: en-GB
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com,
 dev@dpdk.org
Cc: abailey@iol.unh.edu, ahassick@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260708141309.566874-1-knimoji@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260708141309.566874-1-knimoji@iol.unh.edu>
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

Hi Koushik,

I'll fix your patch retrospectively since it's just been merged on 
next-dts but not yet on main. No need for a new patch.

Luca
