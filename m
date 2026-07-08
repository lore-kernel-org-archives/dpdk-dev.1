Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A6CC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACF6E40268;
	Wed,  8 Jul 2026 16:54:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D3AB040265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 16:54:24 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB3BC1CDD;
 Wed,  8 Jul 2026 07:54:19 -0700 (PDT)
Received: from [10.57.81.169] (unknown [10.57.81.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1065E3F7B4;
 Wed,  8 Jul 2026 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783522464; bh=yJxQgcZdU4LQiLyu5eCUaAt7TKAZZqVVvwBShmJBAm8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pI6+JYtqqScAJGEVChEuol4wb3w3WdtRlB6VO5O2DWlrx76HDuuXwcFxfy+wzXFnF
 EuZetM8OJvywkDDx+MTN4PK1Ufaemmb7kM4KURyVRX0oFsCJsuZx42vekyXs4e0TfI
 8M7Z0HEzXUq/DauVcouphKBQJjAGR95HfdKMtHH4=
Message-ID: <c88474df-8cf0-422b-8b22-1ce65a0084d6@arm.com>
Date: Wed, 8 Jul 2026 15:54:21 +0100
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

Now applied to next-dts to the original patch
