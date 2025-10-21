Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DB5CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 15:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61F7640691;
	Tue, 21 Oct 2025 17:32:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B2B77402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 17:31:59 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD611063;
 Tue, 21 Oct 2025 08:31:51 -0700 (PDT)
Received: from arm.com (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 335EE3F63F;
 Tue, 21 Oct 2025 08:31:58 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:31:53 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: Re: [PATCH v8 3/3] dts: update tx_offload test from legacy dts to
 next dts
Message-ID: <176106055133.92518.192726916092523898.luca.vizzarro@arm.com>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251021144528.39748-1-abailey@iol.unh.edu>
 <20251021144528.39748-4-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021144528.39748-4-abailey@iol.unh.edu>
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

I've merged the API changes earlier in the day which means that this now
fails because `verify` is a function of `api.test` now.

This also causes a conflict with the variable verify you've been using
across this whole test suite. Looking at it, it seems that this variable
is not actually used at all in a significant way. It's always True,
therefore I'd just remove all the instances of verify, argument of
_check_config as well, and use the verify=True default as-is.

Finally, I've realised that the commit subject is incompatible. This
should just be something along the lines of:

  dts: add rx tx offload test suite
