Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71769CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 16:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DCA0402E7;
	Fri, 16 Oct 2026 18:44:56 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2A63D4026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 18:44:55 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2e96502e447so143775ad.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792169094;
 x=1792773894; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nzd1GIaAZIytK4BKgH7AS4NVYxDG3n1JVThpmTirbkI=;
 b=SEpWoH2wcFXbH2LCJCNSWAvFQjAYOJl4oxvk0gcjeFpoT6tYGFvimQEh2/+oSHwIJf
 HNgfEo9sxxZPQfQx1erfUhcr2gMewO1CaBi1Ml83bHM9FtsjfE3oq2YEk7KbdVZc0jrF
 aj3IXXZ9Oj8gDe2gT8DivI0Ki7t9LMmTOvzB8j8pLX5vq9RbZvV1XbWJnbRp3bAEZN7m
 DQDvOyPtzX1kYmpCtvMyco/Cn5ZUo3ljMvawrPwIFdT25ja/qyiK/VrZEDaPMHmHaskn
 HAfZi52Q8sg/V7dJivI16XzjhUHpVVowJJEAVHwIeiuQ1lpVOTlzJr0fhGNLLhk1YdLi
 OZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792169094; x=1792773894;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nzd1GIaAZIytK4BKgH7AS4NVYxDG3n1JVThpmTirbkI=;
 b=B6pZgqCjDeHjxtxM/u2v6gZ5BIltpMatdi5JaJKm5vLL5sfU637TNcrR/7uBhI9Jwp
 W5pTsgjKmie2bwsMElw0NzgY3MVSPKZ89BpiXOe3jHCk93v/rL9xPELbPkLSvJPbyujr
 ZqCpGCz5AwYVlfdtSDvbfnBogtIDPxTi2W2xnde7ZYNgl9j8/XSQqNT0np7w6mBE1q8M
 y/WZ+NxhHieAfFkMtS4frECGY4buQKRT7MngET88w37Ck1llxQyueI7SUtXyizh9+ntu
 Wxp7evvdl0cJ69R2Ak8U72RUtyT7XxtGl7/6PmLfragSOEqn+aMQy5l7/RFKZMfji6wi
 055g==
X-Gm-Message-State: AFq9FYKQkB6+TIRcoY9VP59vs47tAbEgsYf3hfd3EUEK4SVjMM0AfDys
 7LYaj72zNleA4AlpXuU5ltKED/2xMVFuk7EXuTbJboFfhDeweO1VWJCvrXMh4pHaIB4=
X-Gm-Gg: AYBFou0a3U+Qwej9pgEZ2POtU2NwGpHdDNDLeT2kuOVcFKL58dGIgZX0PsBA3w21pZF
 N0/xXP2IYLkI7/O5608CJ5iN4lQXxAWp6NbtJXI9Kalu+Nmaci8rLJTBhMCI+8sP1rQKsLKHATX
 YEUUtPg+BaYbBAkglWleESnIQcq6iqkeV1drxpi2bZ42jXFq+q1Lg7+m1vNPQMJSSTXrcXCjNjt
 D06JyvtIRuzieZ8LUKWDdFF3r4lWTIGtHeIlLWXOxlmmMhHLu+U22CbHKjTNlIVQNqoaq7IABmv
 phKVdsDQTQXq2UU82AklYaD6bry/UD8q8jl0vJsgkMBNFkl4phBV21eTuEIJQkXmYl6dJWdjLr+
 zhvD6PXaEigNOTpa/Kpr0xt4fkoRsidij2v8e80L1tV7vOiVJATAT7sM3QQRurgGagiad342qkW
 +9oKqEQuClDPT8nHM+VYnz721OA45U09lCdLQRJ6HBgsYHD6IOPZzdT03ldYVmFTjtTez4PovyU
 AZgq5yPrAXtboCBfPw8FqjQO1OboKaORFkv1xR6
X-Received: by 2002:a17:902:f607:b0:2e9:69b1:1b9b with SMTP id
 d9443c01a7336-2e9a6846dd7mr5335405ad.8.1792169093599; 
 Fri, 16 Oct 2026 09:44:53 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e8b205fsm13347225ad.72.2026.10.16.09.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:44:53 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:44:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH 0/8] Validate multiqueue configuration in ethdev
Message-ID: <20261016094449.3fad2388@phoenix.local>
In-Reply-To: <20261016130555.1685102-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 16 Oct 2026 15:05:46 +0200
David Marchand <david.marchand@redhat.com> wrote:

> We have various checks in drivers about Rx and Tx multiqueue
> configuration.
> This series is a followup of the VMDq cleanup, finishing the job with
> DCB and RSS, and then rejecting invalid multiqueue configuration (useful
> from an ABI point of view).
> 
> Some drivers misreported their capabilities.
> It is important drivers maintainers review carefully those changes.


Thanks, eventually the whole features matrix needs to be auto generated
but that requires lots more work.

First pass of semi-manual AI review found issues

Review: [PATCH 0/8] ethdev multi-queue mode validation (David Marchand)

Applied cleanly on main (v26.11-rc1). Every commit builds with
-Dwerror=true for all touched drivers except mvneta/mvpp2 (no musdk).
All Fixes: hashes resolve.

Main problems: 7/8 rejects RSS mode on ports without RSS, which breaks
in-tree examples and drivers that deliberately tolerated it; and the
devtools trigger added in 4/8 never fires on code changes.


Patch 4/8 devtools: check VMDq capability

Error: has_code_change patterns use '\|' for alternation. git -G
compiles the pattern as ERE, where '\|' is a literal pipe, so it never
matches. On this series:

  git log -G'max_vmdq_pools\|RTE_ETH_MQ_.*VMDQ' HEAD~8..  -> 0 commits
  git log -G'max_vmdq_pools|RTE_ETH_MQ_.*VMDQ'  HEAD~8..  -> 7 commits

So incremental mode only runs check_mq_caps when a features .ini
changes. Use ERE alternation here and in the patterns extended by 5/8
and 7/8:

  if has_code_change 'max_vmdq_pools|RTE_ETH_MQ_.*VMDQ' ||

Warning: drivers under drivers/net/intel/ are never checked.
all_net_drivers and changed_net_drivers only yield "intel", there is no
intel.ini, so check_mq_caps returns early for ixgbe, i40e, igb, ice,
fm10k, ipn3ke, idpf and cpfl, i.e. most VMDq/DCB users. Running the
check over the intel subdirectories reports:

  DCB documented but no get_dcb_info callback for ipn3ke
  RSS documented but flow_type_rss_offloads not set for ipn3ke
  VMDq documented but max_vmdq_pools not set for ipn3ke

e1000 also needs a dir to doc mapping (em/igb/igc share a directory).
igb.ini claims DCB = Y, but igb has no get_dcb_info and 5/8 removes
its "DCB mode is not supported" check. Fix igb.ini and ipn3ke.ini in
this series, and walk drivers/net/intel/*/ in the script.

Info: -S to -G also changes the existing rte_flow trigger.
-S'RTE_FLOW_.*_TYPE_' was a literal match and never fired before.
Mention it in the commit message.


Patch 7/8 ethdev: check RSS availability

Error: rejecting RTE_ETH_MQ_RX_RSS_FLAG when flow_type_rss_offloads is
0 breaks configurations that work today. Applications set RSS mode
statically and only mask rss_hf with flow_type_rss_offloads. In tree:
l3fwd, l3fwd-power, l3fwd-graph, ip_reassembly, distributor, ntb, dma,
eventdev_pipeline, multi_process mp_server, app/graph, test-eventdev.

l3fwd only clears mq_mode for disable_rss or max_rx_queues == 1, so it
now fails rte_eth_dev_configure() on virtio without VIRTIO_NET_F_RSS,
vhost, memif, af_xdp, af_packet, ring and pcap. mp_server uses one Rx
queue with RSS and fails on any port without RSS.

Drivers deliberately accepted this: mvneta (failed only with more than
one Rx queue), octeontx, sfc_repr and cnxk_rep (RSS with one queue and
no hash config). After this patch the RSS branches left in
sfc_repr_check_conf() and rep_eth_conf_chk() are unreachable.

Only reject what cannot work:

	if (dev_info.flow_type_rss_offloads == 0 &&
	    (dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) != 0 &&
	    nb_rx_q > 1) {

and fix the examples to drop RSS when the port has none, e.g. l3fwd:

	if (disable_rss == 1 || dev_info.max_rx_queues == 1 ||
	    dev_info.flow_type_rss_offloads == 0)
		local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;

Update the release note wording to match.


Patch 2/8 drivers/net: fix reported VMDq capability

Warning: Fixes: targets are in released versions but there is no
Cc: stable@dpdk.org. If it goes to stable, the fm10k hunk cannot be
taken as is: it drops the VF configure check and relies on the ethdev
VMDq validation, which stable does not have.

Info: failsafe.ini VMDq = P is not mentioned in the commit message.


Patch 6/8 drivers/net: fix reported RSS capability

Warning: Fixes: targets are in released versions but there is no
Cc: stable@dpdk.org.

Warning: xsc_np.c handles L3/L4 SRC_ONLY/DST_ONLY and LEVEL_INNERMOST,
but only IP|UDP|TCP are advertised, so ethdev rejects those bits in
configure and rss_hash_update. Advertise what the driver implements:

	info->flow_type_rss_offloads = RTE_ETH_RSS_IP |
		RTE_ETH_RSS_UDP | RTE_ETH_RSS_TCP |
		RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY |
		RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY |
		RTE_ETH_RSS_LEVEL_INNERMOST;

Info: idpf, cpfl and cpfl representor still report hash_key_size and
reta_size when rss_caps == 0. Move them under the same condition.


Patch 1/8 net/bnxt: remove leftover VMDq code in MAC helpers

Info: bnxt_mac_addr_add_op() still range-checks pool and indexes
bp->vnic_info[pool]. With ethdev forcing pool 0 when VMDq is not
configured, it can use vnic_info[0] like the remove path.
