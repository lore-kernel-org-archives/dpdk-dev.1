Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03B60A2603
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=h6niW7Gg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77CFD40430;
	Mon, 19 Oct 2026 18:34:11 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id DE04240298
 for <dev@dpdk.org>; Mon, 19 Oct 2026 18:34:09 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8a06c60065fso774148b3a.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792427649;
 x=1793032449; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M62KZqEiIebaQ1RJ463mE92MXCcjjqq1aJwiWpwq94s=;
 b=h6niW7Gg/QwKuy6GkiUx1H7l7Ay+s2S4SRdr2Q5MOebaxYb2HMwbL3Ztt/vTFtAzVq
 +kanGFNQUG3P+45rN6dkFlHpEgNqvr4vNDfoUiB10kDnHngsx12BD6O2338/665GqIcB
 X+V669IpmRnUvFJKNKp+p9F1RR6vBES2kcubYA5dqsd9CTCRdjP3xt/4alR7Cfkb+Zd0
 eNy+9JxxwNS6yJcCPJVjU6/PRmu0QtclcEK97HWXft8VFH2U4Dj9cyOpIQiZY/wg5V17
 Aim2bWW4SuvGbbPc2r86G+LVPOW9WYnhdJa9WN9HJpSk1uNaETi7O2s2ISedAmpiTLHf
 unEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792427649; x=1793032449;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M62KZqEiIebaQ1RJ463mE92MXCcjjqq1aJwiWpwq94s=;
 b=niVkqomloxGVUcU7KpisVLOknAJkyZLDRBIc+fF6cWZxhvZcxD3qkbLeOVjxFQXjlp
 PeUZC7pSYTePdJ6DqZC+inu+/FBDPaHxR5IEyqd27loo21xiRvkpnVBmxZWt5y/qHBR6
 4/EbK7ZFKrZbY/JjKBXoBE4chrlG+8egDfBTt6U5QQ3QOInIjW/qyqz4Y74M1KPxVL/X
 2y953ksZlOSXAAh1WZJTG4cfD3Q3+HlovhMi15XaWPjsmhwhUek7rlQmlczy6Wk5pkqO
 7rJA28Z6KLktOhhrCBNqW47hHrIayrOBh6G0WkVgdKiiNGrmDrLu1uc0AABpafOfxNfw
 N3+w==
X-Gm-Message-State: AFq9FYLXaiGS5lx4Olx1p9ffwcs8x3s/AzFKWMctAKyn977erzDyFODY
 SDh3C++FRvUQ2o2xAF3PLygaGKsEUlfIhS2yvb+CAO4BlbaDU39elQOu9ltlu1JVhaBtN3v3nEi
 jd+6Flm8=
X-Gm-Gg: AYBFou36W4eLE4FiYMoe1SKGQl1NmdKcJADj9idkQzV7tSxasMfSG3R2Jh020Qgfrsh
 yBjZ8yUDb8TqMJmad/nkhfyLGVRdd3DopXAEOJ/6Uo/rvHElgFLyDaatR2H3MQ3GB0CS6E4CVoC
 9E9aHmB6wxB80FMG+pC+7cKTBBU0rreUAL+ftlWKXZD01FfobMzqx8pcQ4DVtfS12IgJdQD/a9c
 6MDuk+hHwykxshYCuzRumNBbwzCwkLz9qjCmEvFJjdIVecqI679aBfUFdj4n9oza9hMoJkc76GV
 vlB9j9EkpX+RUYa3CoVp1IrKOYR3E2gi7kJx7uyrz2klGzDd2lhjlvafSjpcMfgqVmdVuz1MEuY
 MRIHsbFoR4m+sZ7S/GrrPEmB+C5mGYq4w8NPhbIYuChj7U/A917FnocNofTvTgdWhnJCU7y7STm
 jeD9AvBT/e3I528CqgvibFkF1epG4WR55TzaphbBmTPWajA4weE1DYpEZWOIAK8fxMaIyEqa0OA
 FTpFV/SyLPd3AF1ndJEk7c6/eYPu9Y7SQGE15tU
X-Received: by 2002:a05:6a00:2386:b0:886:ead5:6d36 with SMTP id
 d2e1a72fcca58-8a04be664bemr5957865b3a.45.1792427648811; 
 Mon, 19 Oct 2026 09:34:08 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f56c89e19sm3872424b3a.15.2026.10.19.09.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:34:08 -0700 (PDT)
Date: Mon, 19 Oct 2026 09:34:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shai Brandes <shaibran@amazon.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v3 00/13] ENA release 2.15.0
Message-ID: <20261019093405.2935bec4@phoenix.local>
In-Reply-To: <cover.1792312029.git.shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 12:45:41 +0300
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


I am disappointed that you did not address the AI identified problems
in last version.

Review of [PATCH v3 00/13] net/ena: 2.15.0 (bundle 2204)

Applied to main at 9a45341f18 (26.11-rc1); every commit built with
-Dwerror=true (gcc, x86-64).

Series level
------------

There is no changelog. Against the previous posting, v3 only
rebases, keeps ena_com_execute_admin_command() exported in 01, and
fixes a typo in 11. None of the earlier review comments are
addressed; they are repeated below.

Error: patch 04 still breaks the build.

Info: the stable fixes (02, 03, 06, 10) sit behind refactors, and
06 and 10 depend on context from 01, 05 and 09. Put the fixes first
so they backport without rework.


[PATCH v3 01/13] net/ena: avoid using un-needed admin response buffers
----------------------------------------------------------------------

Warning: undocumented behaviour change. Besides the move, the
missing-interrupt fallback in
ena_com_wait_and_process_admin_cq_interrupts() changes from

	admin_queue->polling = true;

to

	ena_com_set_admin_polling_mode(admin_queue->ena_dev, true);

which also writes ENA_REGS_ADMIN_INTR_MASK to the device. Say so in
the commit message, or split the wait path rework into its own
patch.


[PATCH v3 03/13] net/ena/base: fix missing barriers in PHC timestamp read
------------------------------------------------------------------------

Warning: wrong Fixes tag. The req_id poll loop without a barrier
comes from f73f53f7dc7a (v23.11); a14be4dd8693 (v25.11) only added
the statistics block. As tagged, 23.11 and 24.11 will not pick this
up. Use:

  Fixes: f73f53f7dc7a ("net/ena: upgrade HAL")


[PATCH v3 04/13] net/ena/base: rename bounce buffer references
-------------------------------------------------------------

Error: build break. The member is renamed in ena_com.h but
ena_eth_com.c still uses the old name until patch 05:

  ena_eth_com.c:160: error: 'struct ena_com_llq_pkt_ctrl' has no
  member named 'curr_bounce_buf'

Move the ena_eth_com.c renames (curr_bounce_buf, plus
write_header_to_bounce and close_bounce_buffer, which 05 also
renames without mentioning it) into this patch. 05 is then only
the ena_com_sq_is_llq() helper, matching its subject.


[PATCH v3 08/13] net/ena/base: deduplicate meta caching config flag
------------------------------------------------------------------

Info: removing the field leaves two consecutive blank lines in
struct ena_com_io_sq after mem_queue_type. Drop one.


[PATCH v3 09/13] net/ena/base: split LLQ info into datapath and config
---------------------------------------------------------------------

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


[PATCH v3 11/13] net/ena: support flow API for n-tuple Rx steering
-----------------------------------------------------------------

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


[PATCH v3 12/13] net/ena/base: remove x86 Tx LLQ write barrier
-------------------------------------------------------------

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
