Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD272C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:55:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 313CC40279;
	Thu, 20 Aug 2026 15:55:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 028F440150
 for <dev@dpdk.org>; Thu, 20 Aug 2026 15:55:09 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83D9A153B;
 Thu, 20 Aug 2026 06:55:04 -0700 (PDT)
Received: from [10.1.36.55] (JR4XG4HTQC.cambridge.arm.com [10.1.36.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A333F763;
 Thu, 20 Aug 2026 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787234108; bh=BYlkbfyfk7eh7MTzm9ReMOnB5YJOjTu+8+63Da9X0t0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J+8DJ0ozJP5/CqVGT4nWR6M50yQDtgrtaioPJPuWkLlmqGmzI2lUzCZ6CzEvQ9tlJ
 ohoNy+26diZg8raL+7kdLi5eZyqUorUwvzuHSba+WKYR54nFFsW5upa5oaa2Slz7IR
 tkOneunQR7RzM2KckQEsPdHIqLUKl5fnBkEf81/E=
Message-ID: <8eedd46e-8130-4212-ba6a-3a3519dbb12c@arm.com>
Date: Thu, 20 Aug 2026 14:55:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] dts: move test suite module from framework to API
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260807161642.122310-1-abailey@iol.unh.edu>
 <20260807161642.122310-6-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260807161642.122310-6-abailey@iol.unh.edu>
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

I think this is ok as it's mostly defining what a test suite is.
