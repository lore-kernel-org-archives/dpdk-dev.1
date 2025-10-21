Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE57CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 15:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00183402E7;
	Tue, 21 Oct 2025 17:27:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A1171402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 17:27:30 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2381063;
 Tue, 21 Oct 2025 08:27:22 -0700 (PDT)
Received: from arm.com (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B11CA3F63F;
 Tue, 21 Oct 2025 08:27:28 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:27:24 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: Re: [PATCH v8 1/3] dts: allow mbuf_fast_free to be set with testpmd
 shell
Message-ID: <176106041831.92381.11029655898747356341.luca.vizzarro@arm.com>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251021144528.39748-1-abailey@iol.unh.edu>
 <20251021144528.39748-2-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021144528.39748-2-abailey@iol.unh.edu>
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

Looks like this fails check-git-log. There shouldn't be any _ in the
commit subject.
