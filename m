Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFE7CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 15:29:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A464067E;
	Tue, 21 Oct 2025 17:29:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1E9BF402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 17:29:06 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABC271063;
 Tue, 21 Oct 2025 08:28:57 -0700 (PDT)
Received: from arm.com (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 697033F63F;
 Tue, 21 Oct 2025 08:29:04 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:29:00 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu, 
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: Re: [PATCH v8 2/3] dts: add TX offload capabilities to NIC
 capabilities
Message-ID: <176106045859.92415.12049315788071239194.luca.vizzarro@arm.com>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251021144528.39748-1-abailey@iol.unh.edu>
 <20251021144528.39748-3-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021144528.39748-3-abailey@iol.unh.edu>
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

Unfortunately this also fails check-git-log due to "TX" not being "Tx".

Please make sure to run:
- devtools/dts-check-format.sh
- devtools/check-git-log.sh
- devtools/checkpatches.sh

before you submit again.
