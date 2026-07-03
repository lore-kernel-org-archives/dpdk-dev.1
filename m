Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E9AC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 07:47:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 693EC402D4;
	Fri,  3 Jul 2026 09:47:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5F970402D4
 for <dev@dpdk.org>; Fri,  3 Jul 2026 09:47:01 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FC031EDB;
 Fri,  3 Jul 2026 00:46:56 -0700 (PDT)
Received: from [192.168.100.239] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A98693F673;
 Fri,  3 Jul 2026 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783064820; bh=DSNk7jJ9tr8OtAIEnByL5mXsPHcoGFUqyXlxDAKaJ4Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iGy6CkHK50gWkl3qcKtHu1r6VLxIs9kJm4KDfJP9S5Yi5Z7hwFbqXW2yYmcVWAI88
 SJjc4KO2PHZtY5uuHV7HOZsqDI6jEsHEHrX5E4nLAkqIop9EDHRiVk4kcKHTO0u7fF
 1hiXPmgYHuVTub3Gu5TvwjusYJDrcBDmTqAWMsJI=
Message-ID: <32d66b6e-cd4c-4e34-92c7-49cb59efe3ee@arm.com>
Date: Fri, 3 Jul 2026 08:46:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dts: add support for no link topology
To: Andrew Bailey <abailey@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 ahassick@iol.unh.edu
References: <20260220192510.37163-1-abailey@iol.unh.edu>
 <20260617193240.149708-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260617193240.149708-1-abailey@iol.unh.edu>
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

Hi Andrew,

looks good to me! Thanks,

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
