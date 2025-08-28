Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884F3C8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 12:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B362D4025A;
	Thu, 28 Aug 2025 14:50:56 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BB046400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 14:50:54 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9803E1688;
 Thu, 28 Aug 2025 05:50:45 -0700 (PDT)
Received: from arm.com (unknown [10.57.58.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB1613F694;
 Thu, 28 Aug 2025 05:50:52 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:50:47 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: Re: [PATCH v3] dts: enable port binding on the TG
Message-ID: <175638514815.25987.9964104140534837687.luca.vizzarro@arm.com>
References: <20250808182152.356879-2-abailey@iol.unh.edu>
 <20250828123758.20451-1-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250828123758.20451-1-abailey@iol.unh.edu>
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

I see you've made a bit of a mess with the versioning. v2 was detached
from the thread, so this is confusing me. Can you make sure that (as per
contributing guidelines):
- you always reply with new patches to the very beginning of the thread
  (usually the cover letter of v1 – if it was a single patch, then a
  reply to that patch)
- you add a cover letter to your patch series explaining your changes
  across versions. You can check other emails in the mailing list to
  gather an understanding of this. Of course, if you are sending a
  single patch, a cover letter is not necessary, but you'll need to
  annotate your patch (the contributing guidelines who how this is done)

Finally, I cannot tell easily tell what changed from v2. Can you please
give a summary of the changes?

Best,
Luca
