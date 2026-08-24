Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89211C5DF9D
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C51D140270;
	Mon, 24 Aug 2026 18:44:22 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 3B815400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:44:21 +0200 (CEST)
Received: from debian (unknown [78.109.64.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 77E63E0753;
 Mon, 24 Aug 2026 20:44:20 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 77E63E0753
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787589861;
 bh=ZjfXPAiIeqK9IATTzGvNZEK9bTSn5gE3LBeA9K7//Bo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=NDpxzeXgnMMgMOzVL9v/ZiZjx6AI0eiyDKGCa7ylQkFCyR85oyG4j5bXT/5ftmq8J
 yMXbgVonmTinaBf5ePTNEnKZsiF9mPuo4QznI87H+FKZMpHVUQl1wl79iLrpn2+9dY
 ao6COT8hD+g7In21azwY55cvUKrBF8IxZw2Dl+BFgtsK6yi8VVntbqXhWXKVLFRxpT
 VY73Fd+rNe/hK0Xaa4NcJ0VLDS/cc5oqPBjuztXjSzxfHtf5fP319qtVFrm757CTNX
 VxWL2Ofmb3fxZ+LqQzJgYn5NqcE8x+YaJ73kKnmr+MnoOoRSHKP1jaHGbnA/3rV3pz
 QnQKw2XSk5Row==
Date: Mon, 24 Aug 2026 20:44:18 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: dev@dpdk.org, 
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>, 
 Andy Moreton <andy.moreton@amd.com>, 
 Roman Zhukov <Roman.Zhukov@arknetworks.am>, 
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 1/1] common/sfc_efx/base: clear VADAPTER stats upon
 allocation
In-Reply-To: <20260824090632.687d7e6e@phoenix.local>
Message-ID: <4b595977-e358-4170-174d-ff83a368f554@arknetworks.am>
References: <20260824112647.27146-1-ivan.malov@arknetworks.am>
 <20260824090632.687d7e6e@phoenix.local>
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

If I may, the premise that the netport branch never reads 'en_vport_id' does not hold water, as 'efx_np_mac_stats' clearly accepts the vPort ID as its third argument and correctly places it into 'GET_NETPORT_STATISTICS_V2_IN_PORT_ID' unless the action is 'EFX_STATS_DISABLE'. The comment is therefore accurate and will stay. As for the "affects only Medford4" claim, that refers to observable counter behaviour for the specific NIC family in question.

Concerns expressed by the AI do not meet the threshold of an actual defect, and thus no change to the patch is warranted.

Thank you.

On Mon, 24 Aug 2026, Stephen Hemminger wrote:

> On Mon, 24 Aug 2026 15:26:47 +0400
> Ivan Malov <ivan.malov@arknetworks.am> wrote:
>
>> The probe-time clear in 'ef10_nic_probe' runs before the VADAPTER is
>> allocated and so cannot zero its counters. Add a complementary clear
>> to the point at which the VADAPTER is already in place, so that
>> VADAPTER statistics begin at zero for both PFs and VFs.
>>
>> This change affects only Medford4 NICs within the 26.11 release, where
>> Medford4 VADAPTER statistics have been added in the first place.
>>
>> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
>> Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
>> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
>
> Looks correct but Opus AI review spotted something.
>
> Review of [PATCH 1/1] common/sfc_efx/base: clear VADAPTER stats upon
> allocation
>
> The new failure path is correct: fail6 frees the vAdaptor only when
> alloc_vadaptor is set (so the EVB case, where the vPort belongs to the
> vSwitch, is left alone), resets en_vport_id, and falls through to the
> existing fail5 unwinding.  efx_np_attach() runs in ef10_nic_probe()
> before ef10_nic_init(), so ep_np_handle is valid at the new call site.
>
> Warning: the code comment and the commit message do not match what the
> code does on the family they name.  efx_mcdi_mac_stats_clear() splits
> on efx_np_supported(), which is true for EFX_FAMILY_MEDFORD4 and
> later.  On Medford4 it therefore takes the netport branch,
>
> 	efx_np_mac_stats(enp, epp->ep_np_handle, EFX_STATS_CLEAR, NULL, 0)
>
> which never reads en_vport_id, so the comment's "do it here while
> 'en_vport_id' holds a valid value" does not describe the Medford4
> behaviour.  Conversely, it is the pre-Medford4 families that use the
> vPort-scoped branch, efx_mcdi_mac_stats(enp, enp->en_vport_id, ...);
> the probe-time clear there runs with en_vport_id still EVB_PORT_ID_NULL
> (0) and the new one runs with EVB_PORT_ID_ASSIGNED or the vSwitch
> vPort, so Huntington/Medford/Medford2 do see a behaviour change as
> well, contrary to "This change affects only Medford4 NICs".
>
> Suggested fix: reword both to state the actual reason -- the vAdaptor
> counters do not exist until the vAdaptor has been allocated, so a
> clear issued at probe time cannot zero them -- and either drop the
> Medford4-only claim or explain why the extra vPort-scoped clear is a
> no-op on the older families.
>
