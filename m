Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FCBCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 21:14:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7D3B402A2;
	Sat, 30 Aug 2025 23:14:02 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id AE23740276
 for <dev@dpdk.org>; Sat, 30 Aug 2025 23:14:00 +0200 (CEST)
Received: from debian (unknown [78.109.76.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A7A2AE080B;
 Sun, 31 Aug 2025 01:13:59 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A7A2AE080B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756588440;
 bh=b29nzxB6pLcHFcId33qlYW9VEgV8v6gOToTANeo6mfY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=soTnjaxqsBj5LEDOZOIb/CCyCqE6g2noqLOFO1ckVIhFZCo1qEjgY0r1oAPDOS+8J
 35V2xVz/2u2onHCOSDJZfMtQiDYZhELkszFAYYtqBqWNHkT/GezqE647jo8R3AIeYW
 SBdcCFpQRj+GpUOmYUFRQtgn49gv0ilUcmGSwGfoe0BJWY2i3ZoN5M4FF/0Z9fIlld
 3N6Ey36aSFX3HLBvMbCLS9mI++hJ5UkUEtmStWaWbgipF/cIoeMxCBHNHbbi7HILns
 mQwjPVPlIWU2NilyhTkom2tSDH40qv0ALR+pa6+GyIcLJY0UtXB3l7p71NbphAxrvY
 dMvU3nvSz4jsg==
Date: Sun, 31 Aug 2025 01:13:58 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Subject: Re: [RFC PATCH 0/6] ethdev: refactor and extend DCB configuration API
In-Reply-To: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
Message-ID: <609e89f7-4bbc-3535-b924-832afed6d006@arknetworks.am>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
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

Hi Vladimir,

On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:

> Hi all,
>
> This series reworks the ethdev API related to advanced queueing configuration,
> specifically Data Center Bridging (DCB) and Virtual Machine Device Queues
> (VMDq). The existing API was designed years ago around ixgbe hardware
> assumptions, which makes it difficult to properly support modern NICs and their
> more flexible capabilities.
>

I like this overall.

The series seems to be a good rework, but the PMD changes are going to be vast.
Also, given the fact it targets the same release cycle as some new drivers do,
it can be problematic to apply 'rx_adv_conf.mq_mode' to, say, [1] on the go.

[1] https://mails.dpdk.org/archives/dev/2025-August/323562.html


Also, now we've touched on the topic of traffic classes and priorities, if I may
be so bold as to ask an unrelated question about [2]. Does the priority value
have to come specifically from VLAN header? Or can it come, say, from ToS of
IPv4, or Traffic Class of IPv6, or from some vendor-specific header?

[2] https://doc.dpdk.org/api-25.07/structrte__eth__pfc__conf.html#a0ad043071ccc7a261d79a759dc9c6f0c

Thank you.
