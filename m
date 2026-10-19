Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE2CCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 06:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D974F4028E;
	Mon, 19 Oct 2026 08:42:44 +0200 (CEST)
Received: from lf-1-33.ptr.blmpb.com (lf-1-33.ptr.blmpb.com [103.149.242.33])
 by mails.dpdk.org (Postfix) with ESMTP id 3453240269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 08:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1792392150; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=I58oJsjzrdmecEK3QYyh3XEClBrZLFCsz90W3MhZyzg=;
 b=fdES1NVWkN3izS7nvBnWIPNdBGgqW4cVIedd/JpbG6xfdWxtlthQ7l6cQjhXmdo+pwHIKx
 crIkUghyMFDK2RdUZW4ItKcqEMphA01bo1snNNodJKll076qofBhZHMOc3w1VFSCFp/Wqu
 08gEQxpYBttXSjf5f9/jXs6aLlXkR9ilzWDr5BPq3vy563GAiIv8oZJZpdHoE1jbOKxCX8
 niwicrFpUatirz2SqRImtgvR5pP3N9RLyrjCjW4XgzKmsO0P8Lu5g1abBOMWIML65g9sdk
 /+MfJMx22Z79i7ftfCDcgz41nXakUP7kvVLY8JWcrgwqUoMZdaAoUzyVlFRlSg==
Received: from [127.0.0.1] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS;
 Mon, 19 Oct 2026 14:42:27 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26ad5bbd4+3b7a41+dpdk.org+wanry@yunsilicon.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, 
 "David Marchand" <david.marchand@redhat.com>
Date: Mon, 19 Oct 2026 14:41:05 +0800
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Validate multiqueue configuration in ethdev
In-Reply-To: <20261016094449.3fad2388@phoenix.local>
From: "Renyong Wan" <wanry@yunsilicon.com>
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261016094449.3fad2388@phoenix.local>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>
Message-Id: <c1fbad13-0888-4a02-892f-e0fb3f3b6e04@yunsilicon.com>
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

On 10/17/2026 12:44 AM, Stephen Hemminger wrote:
> On Fri, 16 Oct 2026 15:05:46 +0200
> David Marchand <david.marchand@redhat.com> wrote:
> 
>> We have various checks in drivers about Rx and Tx multiqueue
>> configuration.
>> This series is a followup of the VMDq cleanup, finishing the job with
>> DCB and RSS, and then rejecting invalid multiqueue configuration (useful
>> from an ABI point of view).
>>
>> Some drivers misreported their capabilities.
>> It is important drivers maintainers review carefully those changes.
> 
> 
> Thanks, eventually the whole features matrix needs to be auto generated
> but that requires lots more work.
> 
> First pass of semi-manual AI review found issues
> 
> Review: [PATCH 0/8] ethdev multi-queue mode validation (David Marchand)
> 
> Applied cleanly on main (v26.11-rc1). Every commit builds with
> -Dwerror=true for all touched drivers except mvneta/mvpp2 (no musdk).
> All Fixes: hashes resolve.
> 
> Main problems: 7/8 rejects RSS mode on ports without RSS, which breaks
> in-tree examples and drivers that deliberately tolerated it; and the
> devtools trigger added in 4/8 never fires on code changes.
> 
> 
> Patch 4/8 devtools: check VMDq capability
> 
> Error: has_code_change patterns use '\|' for alternation. git -G
> compiles the pattern as ERE, where '\|' is a literal pipe, so it never
> matches. On this series:
> 
>    git log -G'max_vmdq_pools\|RTE_ETH_MQ_.*VMDQ' HEAD~8..  -> 0 commits
>    git log -G'max_vmdq_pools|RTE_ETH_MQ_.*VMDQ'  HEAD~8..  -> 7 commits
> 
> So incremental mode only runs check_mq_caps when a features .ini
> changes. Use ERE alternation here and in the patterns extended by 5/8
> and 7/8:
> 
>    if has_code_change 'max_vmdq_pools|RTE_ETH_MQ_.*VMDQ' ||
> 
> Warning: drivers under drivers/net/intel/ are never checked.
> all_net_drivers and changed_net_drivers only yield "intel", there is no
> intel.ini, so check_mq_caps returns early for ixgbe, i40e, igb, ice,
> fm10k, ipn3ke, idpf and cpfl, i.e. most VMDq/DCB users. Running the
> check over the intel subdirectories reports:
> 
>    DCB documented but no get_dcb_info callback for ipn3ke
>    RSS documented but flow_type_rss_offloads not set for ipn3ke
>    VMDq documented but max_vmdq_pools not set for ipn3ke
> 
> e1000 also needs a dir to doc mapping (em/igb/igc share a directory).
> igb.ini claims DCB = Y, but igb has no get_dcb_info and 5/8 removes
> its "DCB mode is not supported" check. Fix igb.ini and ipn3ke.ini in
> this series, and walk drivers/net/intel/*/ in the script.
> 
> Info: -S to -G also changes the existing rte_flow trigger.
> -S'RTE_FLOW_.*_TYPE_' was a literal match and never fired before.
> Mention it in the commit message.
> 
> 
> Patch 7/8 ethdev: check RSS availability
> 
> Error: rejecting RTE_ETH_MQ_RX_RSS_FLAG when flow_type_rss_offloads is
> 0 breaks configurations that work today. Applications set RSS mode
> statically and only mask rss_hf with flow_type_rss_offloads. In tree:
> l3fwd, l3fwd-power, l3fwd-graph, ip_reassembly, distributor, ntb, dma,
> eventdev_pipeline, multi_process mp_server, app/graph, test-eventdev.
> 
> l3fwd only clears mq_mode for disable_rss or max_rx_queues == 1, so it
> now fails rte_eth_dev_configure() on virtio without VIRTIO_NET_F_RSS,
> vhost, memif, af_xdp, af_packet, ring and pcap. mp_server uses one Rx
> queue with RSS and fails on any port without RSS.
> 
> Drivers deliberately accepted this: mvneta (failed only with more than
> one Rx queue), octeontx, sfc_repr and cnxk_rep (RSS with one queue and
> no hash config). After this patch the RSS branches left in
> sfc_repr_check_conf() and rep_eth_conf_chk() are unreachable.
> 
> Only reject what cannot work:
> 
> 	if (dev_info.flow_type_rss_offloads == 0 &&
> 	    (dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) != 0 &&
> 	    nb_rx_q > 1) {
> 
> and fix the examples to drop RSS when the port has none, e.g. l3fwd:
> 
> 	if (disable_rss == 1 || dev_info.max_rx_queues == 1 ||
> 	    dev_info.flow_type_rss_offloads == 0)
> 		local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
> 
> Update the release note wording to match.
> 
> 
> Patch 2/8 drivers/net: fix reported VMDq capability
> 
> Warning: Fixes: targets are in released versions but there is no
> Cc: stable@dpdk.org. If it goes to stable, the fm10k hunk cannot be
> taken as is: it drops the VF configure check and relies on the ethdev
> VMDq validation, which stable does not have.
> 
> Info: failsafe.ini VMDq = P is not mentioned in the commit message.
> 
> 
> Patch 6/8 drivers/net: fix reported RSS capability
> 
> Warning: Fixes: targets are in released versions but there is no
> Cc: stable@dpdk.org.
> 
> Warning: xsc_np.c handles L3/L4 SRC_ONLY/DST_ONLY and LEVEL_INNERMOST,
> but only IP|UDP|TCP are advertised, so ethdev rejects those bits in
> configure and rss_hash_update. Advertise what the driver implements:
> 
> 	info->flow_type_rss_offloads = RTE_ETH_RSS_IP |
> 		RTE_ETH_RSS_UDP | RTE_ETH_RSS_TCP |
> 		RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY |
> 		RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY |
> 		RTE_ETH_RSS_LEVEL_INNERMOST;
> 

Agreed, the advertised mask is incomplete. xsc_np.c does handle these
RSS bits, but they are not reported in flow_type_rss_offloads.
David, please fold this into the patch.

Thanks,
Wan Renyong
