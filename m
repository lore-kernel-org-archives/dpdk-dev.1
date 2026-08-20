Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1EFC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B498740698;
	Thu, 20 Aug 2026 16:03:32 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 65B12406A2
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:03:31 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBC53153B;
 Thu, 20 Aug 2026 07:03:26 -0700 (PDT)
Received: from [10.1.36.55] (JR4XG4HTQC.cambridge.arm.com [10.1.36.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C70413F85F;
 Thu, 20 Aug 2026 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787234610; bh=AakTxpV667+lPk/GINE8R97jtoXO8z2aJMgY9cp7fLk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sKaVA5ZxB1kDfC2+py6/eiHeA6ASHHAgo0INjwZwSriiJ7bNglNc+2kTyAghDbxCT
 vNNwttDMKjhhLYNYlSbSTq0bSYw8HBDCozfZ1pPcZNtloMZaU4WPKgcNxZjqefKQJN
 OEV+fqQqE2Rq+YjVhgmo+mdcSoUqHIGpqIBuI1JI=
Message-ID: <6d5be581-8479-4433-a391-2bf141e63a55@arm.com>
Date: Thu, 20 Aug 2026 15:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] dts: separate Linux session into interface and
 logic
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260807161642.122310-1-abailey@iol.unh.edu>
 <20260807161642.122310-8-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260807161642.122310-8-abailey@iol.unh.edu>
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

This looks like it should've been done with the testbed model refactor? 
It's a bit confusing to read the changes separately here. It may be best 
to move linux session to API first and then the rest of the testbed 
model separately to avoid it being confusing.
