Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4789CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:03:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17E9A402E4;
	Tue, 26 Aug 2025 16:03:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C91BE402D4
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:03:48 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1A341A25;
 Tue, 26 Aug 2025 07:03:39 -0700 (PDT)
Received: from [10.1.194.29] (unknown [10.1.194.29])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CDEA3F694;
 Tue, 26 Aug 2025 07:03:47 -0700 (PDT)
Message-ID: <23c65370-c5d1-4ee7-b4d1-ff85ecf0a4f8@arm.com>
Date: Tue, 26 Aug 2025 15:03:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dts: rewrite two link topology requirements
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250807140730.292639-1-dmarx@iol.unh.edu>
 <20250820140651.39604-1-dmarx@iol.unh.edu>
 <20250820140651.39604-3-dmarx@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250820140651.39604-3-dmarx@iol.unh.edu>
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

Thank you! Looks good to me.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
