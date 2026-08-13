Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B2C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 04:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F46D40281;
	Thu, 13 Aug 2026 06:10:39 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4D38F4026E;
 Thu, 13 Aug 2026 06:10:37 +0200 (CEST)
Received: from debian (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 68ECFE0BE5;
 Thu, 13 Aug 2026 08:10:36 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 68ECFE0BE5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786594237;
 bh=wzLkKW6yzO+qTMk9g0OW/5oAytoO2T48oR1rvk6h7+4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=u1Co7Y9L0mHzsUycRlObQYRgETEOcd1xVtX70lu+ygGSUwBz/8JH22O2Tq6MghKOq
 50802KK32a28IO72q+73qceHWYsJxbO+g0RUx0ZlZeAVKVs8aCSfftR+ln68wcF/SD
 BZ6BUc0oEL3wb9/rcdd/btbKQxI+x9z9k1Ga+5C1CjI3GkbPjwohRReD/AOPRHvvPl
 cThcRiQDsSAZFOZayEZBrsiM3ts46sh5yW6V/cKj50JS90yBDY8obIjAqBr78Yr8Y9
 DEVoq0v4waTo18FpHFnEDmO1R7cSZNEaU09jTbbVMJKZkLzzzzFp0yismSA6AzNLb4
 VCKfYxWK5RItg==
Date: Thu, 13 Aug 2026 08:10:34 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, 
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>, 
 Roman Zhukov <Roman.Zhukov@arknetworks.am>, 
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: Re: [PATCH v2 3/3] common/sfc_efx/base: fix reading advertised
 autoneg ability
In-Reply-To: <20260812194414.55bf706e@phoenix.local>
Message-ID: <fdfecacc-d2cc-8f91-59db-d18ba9af548d@arknetworks.am>
References: <20260811174913.8961-1-ivan.malov@arknetworks.am>
 <20260812171017.8521-1-ivan.malov@arknetworks.am>
 <20260812171017.8521-4-ivan.malov@arknetworks.am>
 <20260812194414.55bf706e@phoenix.local>
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

Dear Stephen,

If I may, I should like to address the following:

- Backport conflict and 'Depends-on:':
   The stable team operates independently of the upstream review process; should the patch not apply cleanly, the stable maintainers will contact me directly (a well-established practice) and I am entirely willing to provide all the assistance at the appropriate juncture. In other words, the 'Cc: stable@dpdk.org' signals that a backport is desirable, not that it must apply without manual resolution. Upstream acceptance is not contingent on the mechanics of a stable backport, which falls outside the scope of this review.

   As to 'Depends-on:': the dependency here is purely contextual. It is one of hunk context, not of function; the fix is semantically correct regardless of whether the block precedes or follows the conversion call.

- Local variable ('port'): I am entirely mindful of the desire to keep code laconic, yet, high-quality future-proof code benefits from such local declarations as they make the actual usage sites easier on the eyes and can be re-used by later additions to the logic.

On these premises, I respectfully suggest that the series be put forward for reconsideration and integration.

Thank you.

On Wed, 12 Aug 2026, Stephen Hemminger wrote:

> On Wed, 12 Aug 2026 21:10:17 +0400
> Ivan Malov <ivan.malov@arknetworks.am> wrote:
>
>> The issue is that when the user disables auto-negotiation by removing
>> the capability bit from the 'advertised mask' (set method) and then
>> reads the resulting capabilities, which involves querying MCDI, the
>> bit reappears in the mask irrespective of the user's intent.
>>
>> Fix this by remembering the user's intent before any link-state queries.
>>
>> Fixes: 2a5cf77e6de8 ("common/sfc_efx/base: provide PHY link get method on Medford4")
>> Fixes: 06f569de6c06 ("common/sfc_efx/base: decode netport link state on probe path")
>> Cc: stable@dpdk.org
>>
>> Suggested-by: Andy Moreton <andy.moreton@amd.com>
>> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
>> Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
>> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
>
> This patch depends on the previous common series and therefore can
> not be easily backported to stable.
>
> There is a way to mark patch dependencies using Depends-on:
> please use that instead of instructions to AI.
>
> AI says that in its usual over the top wordy way...
>
> Patch 3/3 - common/sfc_efx/base: fix reading advertised autoneg ability
>
>  Warning: this patch depends on the pending common/sfc series for its
>  diff context only, and that dependency creates a backport conflict.
>
>  The efx_np.c hunk removes
>
>      if (lsp->enls_an_supported != B_FALSE)
>              lsp->enls_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;
>
>  from a position after the LINK_STATE_OUT_ADVERTISED_ABILITIES
>  conversion.  On main and on every stable branch the block is still
>  before that conversion, where 06f569de6c06 originally put it.  Since
>  efx_np_cap_mask_hw_to_sw() ORs into *sw_cap_maskp (efx_np.c:197)
>  rather than assigning, the block's position has no effect on the
>  resulting mask - the pending series is only moving text.
>
>  Both Fixes: commits first appear in v25.07, so this needs to reach
>  25.11 LTS and 25.07, neither of which has the move.  Stable will hit
>  a conflict on a hunk whose resolution is not obvious from the diff.
>
>  Suggest sending this fix ahead of the series that moves the block,
>  or as a standalone patch against main.  It then applies unchanged
>  everywhere, and the other series absorbs a zero-cost rebase.  If the
>  current ordering has to stand, please post an explicit backport to
>  stable@dpdk.org rather than leaving the resolution to the stable
>  maintainer.
>
>  Info: the added local
>
>      const efx_port_t *port = &enp->en_port;
>
>  is used once, and the file otherwise reaches through enp->en_port
>  directly (line 33) or names the local "epp" (medford4_phy_reconfigure,
>  medford4_mac_poll).  Suggest:
>
>      preserve_an = enp->en_port.ep_adv_cap_mask &
>                    (1U << EFX_PHY_CAP_AN);
>
