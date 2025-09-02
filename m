Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD33CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 19:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92F1D40655;
	Tue,  2 Sep 2025 21:48:16 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 689D84042C
 for <dev@dpdk.org>; Tue,  2 Sep 2025 21:48:15 +0200 (CEST)
Received: from debian (unknown [78.109.66.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 7E051E0709;
 Tue,  2 Sep 2025 23:48:14 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 7E051E0709
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756842494;
 bh=vjKnIWfgHQSHHmt5rVhyFZiF2POSomhBlLfrxxhb3rY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=nHx9bXGFr3ijKWcXZtLtbnZK7jg9qsm7gT/rkwCAJLoP7JnkgrkacJ/uVNypcNXb0
 rwd02D/x+mgYA7JzgMVvYMOEvIpxPrK4b8HMZrq/sWfDdW8FLYZYH18RX5Oo8pumrj
 kI+27DitlGhdpv2ypQxUhfHgLgJZhCAKANi3nvVM5I1VlavBSPelu0PEyG9RaxTFxa
 ub6J4Izopah15QeU8fhReXraV8/EVims/ThfZCT0Fjt+/Sq5w1qlUWoR8YfaJVwkPd
 qPWimq9qckFlNqA/K5uiJLYRVhwv7iYb/H7LIf/McbTh1XqqlWCon8SxNbaIsqab6Z
 GDr+q2FTVv6hw==
Date: Tue, 2 Sep 2025 23:48:13 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Andrew Bailey <abailey@iol.unh.edu>
cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: Re: [PATCH v1 1/3] dts: allow mbuf_fast_free to be set with testpmd
 shell
In-Reply-To: <3505d755-ddbc-d6f5-ff47-0ea2216c8993@arknetworks.am>
Message-ID: <a666c751-3890-07b8-b2a1-96001f7ace08@arknetworks.am>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250902142725.56736-2-abailey@iol.unh.edu>
 <3505d755-ddbc-d6f5-ff47-0ea2216c8993@arknetworks.am>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Tue, 2 Sep 2025, Ivan Malov wrote:

<snip>

>> +            port_id: The ID of the port containing the queues.
>> +            num_queues: The queue to disable mbuf_fast_free on.
>
> While I'm not well-versed in DTS style in general and cannot push to choose
> some specific naming, I'd say, to me, 'queue_ids' would read less ambiguous.
>

Sorry, I now see this is not a queue ID array but the total number of queues. If
so, the description should be corrected to say so. Right now it reads like this
is a specific queue index.

Thank you.
