Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EBECC6B19
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:33:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 703C140274;
	Tue, 13 Oct 2026 17:33:49 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 1A40E40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:33:48 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3a0aaa0fd13so2198471a91.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791905627;
 x=1792510427; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aSLn4RvyNW2Dg6k4ExZ3EVQ40Qlf/TvP9NFp2cfSL4M=;
 b=qFRZKjzaS59SadYlsmnChCSuK9M2VC9/T9F/yezF/t4SY3fEJbmTkhT5PVlG20Cz6U
 GCmYUppqJkcsMizMF7ohXDf+xD24ZcZj6+GkQL0L49WtLFJcAWKzBo+gDIMWj0eTui4n
 0eCzBbA5rDg7c48EeH8odCN1tAgeA7cnxTKhbjd7+zeT0EVBC/qNNVxo9nPMlDvw1gwn
 G0mnrG9uYatCj4Xp21Kd32ZkFgXkP8svkHQjoTZZUMOBBvCp7ZSn7VKrLkglP60QuxYY
 hbD21SeG6gC/r8orBaVtKTVGPfMFdsXiMst01VzZv+M7+LY7XrU/OMfxWD74ICKmyUnx
 Enxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905627; x=1792510427;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aSLn4RvyNW2Dg6k4ExZ3EVQ40Qlf/TvP9NFp2cfSL4M=;
 b=sDe+hKVq354qxj96ghbX69fFuKGKKmo4NVP6TYZkWhH4dqKTbZh2XYh4JPrJQgClWY
 mx+nunP7pvzJ950WpF8rwnfft4iGMuaaIicdUYgCvN8xF1gWzmDi1ELO7pGs7tt6YumM
 84XDQhlBXNg1aoifmNEGK18AKN9Ys3YYCAsxDrnk2YgITtp+G6j0MJuvToasORQFETMf
 YNDP+LoeNj6xUkwceZdMknVtI+7vf5GZpMiFFaR0gmU2wMfO2MVVn/W2B3j+rzPMDheZ
 V9J7Oy/3baGw9aY5XjCaUzRAHhSWa8K8uBm0Sw2a891bNwlDYpobIaWxTY2cobe9vTB8
 SYBg==
X-Gm-Message-State: AFq9FYLlwCTicbJvJuEeJBGTjmHx/SqC95FxQrh3PxqK5U04/m4agCFI
 FIpNzHsugqkPLr8vZAGMxcPo7GxNy54RA+MFZPgj9wT7PEyWgv27wfM32YMGNVbwIFg=
X-Gm-Gg: AYBFou2ZbKmizwktbfe1CsIGils1NioCx5A17XKhG6gKqkhYWK3kLY6Twn14kPw3xU9
 9zkC5KDZ/3x85QY8FB8XhVnShNwvIgCGTRUEqx9YXQjgvxcv/yq6doKZKSAJfItz9OU3iEvpEQ1
 1b6xzXuFvQzTrPSDY0+O0G2dgRK+qpS725XkLwaIqRiMxgKmnDvxDINc2YfogmsLbDDd4wlx2E/
 TxiCWLG0dnrRgrSELS7iMrZvrXikA2G9HnJO027F6sc4R4nqrEUFM1gLRqfX2DS35RbADbMs1s4
 CN2Fn04JITtIW16+BK2Ksc9NrUza4E+XjqyeBtRA1S5mPNcpmt03pglg1BpHIwvYVyCYkmfvOtH
 qDnTGgquABaJJNMo2jJwUM5Oceu4NH9Jp5Giiz4D7JcauCmOM3D6mAP+oBFsFKQaEsHhgSo9c8Q
 Q1R4G/qgNi64NdyLzlSayIOlDvW8oPJsV8LJnQmniv7YC7RSdHfSt+s2ZgOYRXpz3xWGNlBdJFF
 uMFLHCkovtZKSMlJfju1p+/i3DKJzB82LFImIfw
X-Received: by 2002:a17:90b:384c:b0:3a4:b061:2765 with SMTP id
 98e67ed59e1d1-3ab3a735fd2mr12894207a91.15.1791905626972; 
 Tue, 13 Oct 2026 08:33:46 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f3db2f5sm42397a91.1.2026.10.13.08.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:33:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 08:33:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shai Brandes <shaibran@amazon.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH 00/13] ENA release 2.15.0
Message-ID: <20261013083341.45cb17fa@phoenix.local>
In-Reply-To: <20261013150611.9237-1-shaibran@amazon.com>
References: <20261013150611.9237-1-shaibran@amazon.com>
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

On Tue, 13 Oct 2026 18:06:11 +0300
Shai Brandes <shaibran@amazon.com> wrote:

> Hello all,
> This series upgrades HAL and fixes two PHC correctness issues,
> an LLQ feature version not communicated to the device, and
> a failed LLQ configuration zeroing the negotiated tx_max_header_size.
> Additionally it adds n-tuple Rx flow steering support through the rte_flow API.
> Review and comments are welcome
> 
> Best regards,
> Shai Brandes

Running AI review spots several issues:

Review of [PATCH 00/13] net/ena: 2.15.0 (bundle 2177)

Applied to main at 7f615af; every commit built with -Dwerror=true
(gcc, x86-64).

Series level
------------

Error: patch 04 breaks the build (see below).

Warning: patch 11 does not apply to main. doc/guides/nics/features/
ena.ini now ends with "Usage doc" and "Design doc"; rebase.

Info: the stable fixes (02, 03, 06, 10) sit behind refactors, and
06 and 10 depend on context from 01, 05 and 09. Put the fixes first
so they backport without rework.


[PATCH 01/13] net/ena: avoid using un-needed admin response buffers
-------------------------------------------------------------------

Warning: undocumented behaviour change. Besides the move, the
missing-interrupt fallback in
ena_com_wait_and_process_admin_cq_interrupts() changes from

	admin_queue->polling = true;

to

	ena_com_set_admin_polling_mode(admin_queue->ena_dev, true);

which also writes ENA_REGS_ADMIN_INTR_MASK to the device. Probably
the right thing, but the commit message only talks about response
buffers. Say so in the commit message, or split the wait path
rework into its own patch.


[PATCH 03/13] net/ena/base: fix missing barriers in PHC timestamp read
---------------------------------------------------------------------

Warning: wrong Fixes tag. The req_id poll loop without a barrier
comes from f73f53f7dc7a (v23.11); a14be4dd8693 (v25.11) only added
the statistics block. As tagged, 23.11 and 24.11 will not pick this
up. Use:

  Fixes: f73f53f7dc7a ("net/ena: upgrade HAL")


[PATCH 04/13] net/ena/base: rename bounce buffer references
----------------------------------------------------------

Error: build break. The member is renamed in ena_com.h but
ena_eth_com.c still uses the old name until patch 05:

  ena_eth_com.c:160: error: 'struct ena_com_llq_pkt_ctrl' has no
  member named 'curr_bounce_buf'

Move the ena_eth_com.c renames (curr_bounce_buf, plus
write_header_to_bounce and close_bounce_buffer, which 05 also
renames without mentioning it) into this patch. 05 is then only
the ena_com_sq_is_llq() helper, matching its subject.


[PATCH 08/13] net/ena/base: deduplicate meta caching config flag
---------------------------------------------------------------

Info: removing the field leaves two consecutive blank lines in
struct ena_com_io_sq after mem_queue_type. Drop one.


[PATCH 09/13] net/ena/base: split LLQ info into datapath and config
------------------------------------------------------------------

Warning: this is not "No functional change". The burst limit
divisor changes:

-	llq_default_cfg->llq_ring_entry_size_value;
+	llq_info->common.desc_list_entry_size;

They differ when the device does not support the default entry
size and the fallback above picks another one. With a 128 byte
default and a 256 byte fallback, the old code allows twice as many
entries per burst as the device accepts. That is a real bug, present
since the LIMIT_TX_BURST support went in. Split it out:

  net/ena/base: fix Tx burst limit with fallback entry size

  Fixes: b68309be44c0 ("net/ena/base: update communication layer
  for the ENAv2")
  Cc: stable@dpdk.org

and keep 09 a pure refactor.

Info: continuation lines of the descs_num_before_header assignments
are not indented:

		llq_info->common.descs_num_before_header =
		llq_default_cfg->llq_num_decs_before_header;

Indent the second line one more tab, or keep it on one line.


[PATCH 11/13] net/ena: support flow API for n-tuple Rx steering
--------------------------------------------------------------

Warning: an item without spec is rejected for IPV4, IPV6, TCP and
UDP ("IPv4 item requires spec"). In rte_flow a NULL spec means
"match any packet of this protocol". testpmd passes spec == NULL
for items given without fields, so the obvious rule

  flow create 0 ingress pattern eth / ipv4 / tcp dst is 80 / end
       actions queue index 1 / end

fails. Treat NULL spec as protocol presence with zero masks, e.g.:

	case RTE_FLOW_ITEM_TYPE_IPV4:
		...
		has_ipv4 = true;
		if (spec == NULL)
			break;
		if (mask == NULL)
			mask = &rte_flow_item_ipv4_mask;

Same for IPV6, TCP and UDP.

Warning: secondary process. All other admin commands (MTU, RSS,
stats) go through ENA_PROXY because only the primary owns the admin
queue. The flow ops call ena_com_flow_steering_*() directly, so
rte_flow from a secondary submits admin commands from the wrong
process. Proxy them, or simply refuse in ena_flow_ops_get():

	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
		return -E_RTE_SECONDARY;

Warning: features/ena.ini adds the [rte_flow items] and
[rte_flow actions] tables but not "Flow API = Y" under [Features].

Info:
- ena_infos_get(): the two "&= ~" lines are no-ops (ENA never sets
  RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP or RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE)
  and dev_infos_get should not write dev->data. Drop them and the
  comments.
- ena_flow_create() parses the pattern twice, once inside
  ena_flow_validate(). Split the attr/started checks into a helper
  and call ena_flow_parse() once.
- adapter->flow_rule_count duplicates
  ena_dev->flow_steering.active_rules_cnt. Use the base counter.
- ena_flow_ops_get() logs WARNING when steering is unsupported.
  testpmd calls rte_flow_flush() on port close, so this fires on
  every close. Use DEBUG or no log.
- ena_flow_query() only returns ENOTSUP; leave .query NULL and
  ethdev returns ENOSYS.
- ena_com_flow_steering_remove_rule() and _remove_all_rules() pass
  a response buffer they never read. Use
  ena_com_execute_admin_command_no_resp() from patch 01.
- ena_com_flow_steering_destroy() leaves dangling pointers. End it
  with memset(flow_steering, 0, sizeof(*flow_steering)) like
  ena_com_rss_destroy().


[PATCH 12/13] net/ena/base: remove x86 Tx LLQ write barrier
----------------------------------------------------------

Warning: arm_wmb() is a no-op on every non-ARM architecture, not
just x86. ppc64le, riscv and loongarch are weakly ordered and the
driver still builds there. The argument for dropping the barrier
(UC doorbell store flushes WC buffers) is x86 specific, so make the
test x86 specific:

  #if defined(RTE_ARCH_X86)
  #define ena_llq_wmb() do { } while (0)
  #else
  #define ena_llq_wmb() rte_wmb()
  #endif

(rte_io_wmb() everywhere is the other option, if Graviton testing
shows dmb oshst is enough; on x86 it is a compiler barrier.)

Info: the new comment in ena_com_write_bounce_buffer_to_dev() is
20 lines, half of it history of the old wmb(). History belongs in
the commit message; keep the comment to what the barrier orders and
why x86 does not need it.
