Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7486EC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 09:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4E6F4060C;
	Thu,  3 Apr 2025 11:44:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 280E54060B
 for <dev@dpdk.org>; Thu,  3 Apr 2025 11:44:11 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35747106F;
 Thu,  3 Apr 2025 02:44:13 -0700 (PDT)
Received: from [10.1.35.62] (JR4XG4HTQC.cambridge.arm.com [10.1.35.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB7B83F63F;
 Thu,  3 Apr 2025 02:44:09 -0700 (PDT)
Message-ID: <9087e420-32c0-48e7-90dd-cf748e8b1f0f@arm.com>
Date: Thu, 3 Apr 2025 10:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/10] dts: replace use of sanity check in comment
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
 <20250402232441.440346-8-stephen@networkplumber.org>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250402232441.440346-8-stephen@networkplumber.org>
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

I'm happy with the change. The original intention of the comment was to 
make sure that non-involved ports were still being allowed, and that 
there were no side effects. The comment change somewhat becomes 
redundant as it's repeating the subsequent message. So if it were to 
stay as proposed, I guess it'd drop it altogether.
