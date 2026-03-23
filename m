Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F211BF46113
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 14:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ED8840268;
	Mon, 23 Mar 2026 15:01:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id EBAAC4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 15:01:06 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 151DB14BF;
 Mon, 23 Mar 2026 07:01:00 -0700 (PDT)
Received: from [10.57.17.76] (unknown [10.57.17.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E98903F694;
 Mon, 23 Mar 2026 07:01:04 -0700 (PDT)
Message-ID: <c4a37163-8e4f-4646-bbd0-d2d0c61a121a@arm.com>
Date: Mon, 23 Mar 2026 14:01:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dts: update overall result pass/skip logic
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org, Andrew Bailey <abailey@iol.unh.edu>
References: <20260320154641.21334-1-dmarx@iol.unh.edu>
 <20260320182126.35724-1-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260320182126.35724-1-dmarx@iol.unh.edu>
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

This is ok by me, but let's make sure the new behaviour is documented 
(in the commit description)

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
