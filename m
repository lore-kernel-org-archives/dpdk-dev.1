Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49AC87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 07:08:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01F8240A4B;
	Tue,  5 Aug 2025 09:08:47 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 94961402E3
 for <dev@dpdk.org>; Tue,  5 Aug 2025 09:08:45 +0200 (CEST)
Received: from debian (unknown [78.109.79.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id C210BE048E;
 Tue,  5 Aug 2025 11:08:43 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am C210BE048E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754377724;
 bh=XaAiI0Fy+l5ZmZnCykwoYIs1WzRhnuFb9sApwvV00Jo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=4XFG+bYdYC0F/7sdtSaqbrzHWDGiRGJpGeWspKeMUjvXnzfP/7AywCAwj6Oal5PE4
 PaAR/4Ww9ePAysqvO9XbCDrYmV9j2ToVZsH8bv0Nv4hNkIduheVutEyDXPZB+wgWK0
 ISPcr7yzL6P/l/vrtiUtScko7T2YEcjZL2HSqw5L3IYZ+/2rchfUKidjat/naUa1ot
 VLtnfXq1zqvclb3m64AjcsPl1XQ9CixbgpeGBPVdy6/koisHJ5ZXP+JhzlmHNfklSH
 wS/HkalX5QOimlKawv2zhsV/1QfG06O5r1tb0y2pULlqCO5u9BIq0Uh7bzn1plSRVz
 Tr0TVWTuepuNQ==
Date: Tue, 5 Aug 2025 11:08:36 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
cc: fengchengwen <fengchengwen@huawei.com>, dev@dpdk.org, 
 Aman Singh <aman.deep.singh@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDFF@smartserver.smartshare.dk>
Message-ID: <9da405ec-8a1c-4cb3-f44e-1293c85bb49f@arknetworks.am>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
 <4102ec21-46b6-4512-bc2f-3cd61f63f8c2@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDFF@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1331010236-1754377724=:10250"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1331010236-1754377724=:10250
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 5 Aug 2025, Morten Brørup wrote:

>> From: fengchengwen [mailto:fengchengwen@huawei.com]
>> Sent: Tuesday, 5 August 2025 02.59
>>
>> On 8/4/2025 3:42 AM, Morten Brørup wrote:
>>> Enabling some offload by default may conflict with a manually
>> configured
>>> offload.
>>> Specifically, the mbuf fast release TX offload, which conflicts with
>> multi
>>> segment packet TX offload, was enabled by default.
>>> Therefore, mbuf fast release TX offload (the only TX offload which was
>>> enabled by default) is not enabled by default anymore.
>>
>> This may impact default performance, many vendor performance report has
>> testpmd iofwd or macfwd case.
>
> Yes.
>
> IMO, any optimizations, mbuf-fast-free or mbuf-recycle, must be explicitly enabled, and documented in the performance reports when used.

Good point.

Thank you.

> Otherwise the performance reports give a false impression of higher performance, which is only available under certain circumstances.
> I have complained about this before.
> Which is also why mbuf-recycle must be explicitly enabled.
> With this patch, the same finally applies to mbuf-fast-free too.
> I could add a Fixes tag, but I think it is better to categorize this patch as an improvement rather than a bug fix.
>
>
--8323328-1331010236-1754377724=:10250--
