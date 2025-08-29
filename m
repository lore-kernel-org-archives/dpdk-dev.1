Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A0CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 15:19:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD4114025A;
	Fri, 29 Aug 2025 17:19:55 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 953AE40150
 for <dev@dpdk.org>; Fri, 29 Aug 2025 17:19:53 +0200 (CEST)
Received: from debian (unknown [78.109.65.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 40E33E0499;
 Fri, 29 Aug 2025 19:19:52 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 40E33E0499
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756480792;
 bh=zFM21+mje797OOqt9dgv29arwSXFnjTdHTV1g1h9AnI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=3k94aO5mUdB7+IaEbvmmGcDm3vLyoXtDCv97vqJkPSgCIyfC/OH4TNs/3vjFcPT/u
 FuRu/l2cu6VuWkJxGx8HgbsrT4W/Sj+QvuQY1bPN6doWw2JoWDu55fuMkHporrVHSo
 Cp2BptlMfVKlLILl6BuKlnkJwTwH/VXP7kNnlQThnuZXqYlgCcmnBIcpzk4idMPRp6
 THRtt72r0MpD+WZHAZ8REDQGPoPD5immpxnT2wmR9qyvCSkBsVW1ZUIvWWWnsKPZRf
 TXmlRSVBGcJWEqT8/RPmLT2uRK5lAY+Gf/3Uaq9tLWU1IlEv/asLRKV68Qp9NdStnJ
 tuNpWaLESfg3g==
Date: Fri, 29 Aug 2025 19:19:44 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Ciara Loftus <ciara.loftus@intel.com>
cc: dev@dpdk.org
Subject: Re: [RFC PATCH 1/3] ethdev: add set link state on close API
In-Reply-To: <20250829140224.1748255-2-ciara.loftus@intel.com>
Message-ID: <3f8ed682-28d4-c90a-8547-8d1e98595f79@arknetworks.am>
References: <20250829140224.1748255-1-ciara.loftus@intel.com>
 <20250829140224.1748255-2-ciara.loftus@intel.com>
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

Hi Ciara,

On Fri, 29 Aug 2025, Ciara Loftus wrote:

> Allow the user to configure the state a link should be in after
> the device has been stopped/closed. Make this configurable
> through the new experimental rte_eth_dev_set_link_state_on_close
> API. Three states are allowed:
> 1. down: bring (or keep) the link down
> 2. up: bring (or keep) the link up
> 3. initial: restore the link to the state it was in when the device was
> started.
>

Perhaps it pays to name it 'status' instead of 'state', as the latter is not
confined to just 'up/down' but also includes the speed, technology, FEC, etc.

As for the three cases:

(3)
When the driver gets probed, it may discover the link being in some state that
the previous driver left us, (A). Then if the user does not invoke any APIs to
tweak the link settings and proceeds straight to 'rte_eth_dev_start', the link
will be in some best-effort state (B). Otherwise it will be in other state, (C).

Which one is implied by 'when the device was started'?

(2)
Does 'keep' describe the link being up prior to 'close'? If so, then if the
link is not 'up' prior to 'close', this commands to bring it up, which may
not be possible if the link partner is gone or the cable is unplugged.

(1)
This is OK. If the driver is capable to force link down, in electrical idle,
it will do that. If it can't do this, the whole API won't be supported.

Thank you.
