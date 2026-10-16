Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D83CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 16:18:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3422D402E7;
	Fri, 16 Oct 2026 18:18:25 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 539A14026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 18:18:22 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cd62c570b5dso101807a12.2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792167502;
 x=1792772302; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g5PiDosJYwN7AO2CJ76dxQdMPj/l/itDzCghghio4KA=;
 b=jw345yXng5fcu/rpHV6fM4ODP9BBHVUp+4/rEQBee5peaRm5Ym0OaqZ0JXdyUVPn5h
 1oZS6uKHDX9odu/ctt5G8BMySgtL86/N3hYTC7fzd9t5cF1mIge9MPbZf6ID/J53UD4G
 CiqnSfe0sLfPhJlPjYXucUjQ5SK0G1+9eNkgyB1CNGCXdkTPCyurs3Qdynvg3dw2NSkZ
 mhW4/M7cyAUTkjFkoeGs4dHFXYzALoM+PJBmd5rpSqXpIGRS2gXfKaQQOBpAgB1Ni3q6
 fuJBkHSZAncBobT0JHDp0UGxbyEwPQadDvuhkuPysIPNBVuovG7qnXIhKlY8Orr9Zsdj
 UP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167502; x=1792772302;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g5PiDosJYwN7AO2CJ76dxQdMPj/l/itDzCghghio4KA=;
 b=SV1OVtpUFhnDQi0L3pwQ6VQkGklHgz1mM72cDMiPf9LQKDnhmKhrApKtuWfPAz/lrX
 A4fQBL3Hw8PhNaQUSddwoNLj02alylGXhqaAPf7beKNn2/wTNAXmox0tQpkXH7q4K5qS
 1+Z/pxNtMSWW/zgjLfvCfctZmb/Kc/xn1L+9EyIlcfzFmDmapDW7HsxnWVsXXo4FEs6v
 4dPkw6agyR6eWmihdobRyuFf5M90ROPDHeL8TmIzPA0XbzqmFrtV7ZpWvrFJupY3h7ca
 mUXP5FfN3bfucnf5nRvkaQt9EuL0vVQ9l4WwMzO56YSPKmphf24w9k+/MaGnh4OoJ2Dy
 3CAg==
X-Gm-Message-State: AFq9FYIXElp36V7FYSgn9hkXvZDUhOPgxe/di/lXG1Sqid9YfBIIXy/O
 fBLPlFLw6TK75OkBDA/IaMxdAiEF7Ms/ocn7rVp2Yc7/JPy1203lyBiH7ejHdTa1TseRTn7HDsN
 cfbNB1tM=
X-Gm-Gg: AYBFou0AxvAfad5y4RUpJq5TdqWT1JFe42CCZ9tFDZzEBDF76daLHJ0QwQRSmPDu9sQ
 yf+P4gwd1t2UjNHYDGerfphEiE2rN+34W7Tqcm96o9sc+2ZpTk4ETsOp67CXcfm4mM0PmTYOE29
 hLIfBN/umLabI0yys48CiYXMls/Ze4UaiOG9m/lH5DvE6IvopuhXZNOuF4GbptMgCQa78Ua9N2O
 OBOCX5s23AlFgaJFg9RE1CzkB01+aXH5870J6nAniBNInDQJXcoKhmcOCDrzokkWOhl7dLgFWwU
 zVt1UWTfQ7U3XxIL/B6x1zPEmUMqQZvNohF2Z+J1mVmcFyIF8//jAtzQPWbz5dtUlU2FXIRpler
 LKNoAAuYH9fE/rkMZQqOoxEQmcNlUZTFfldsvmV04q0CWkiIPFXATWG3gvzu/wjcvTWZGibTOLW
 lgqydkUcEjLp2cJMtt/pID35gODnq0lcYdy4Jq3wa3EzckBSRl71jvLcgF62LqNLJDQNKNb0wP+
 W+gp76ckl8Fcxfk9F6GcTBKuOUaggPxVd9hmAvI
X-Received: by 2002:a17:90a:e7d0:b0:3ac:9176:e83c with SMTP id
 98e67ed59e1d1-3aceeb9606dmr318650a91.12.1792167501118; 
 Fri, 16 Oct 2026 09:18:21 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc487cccdsm4717121a91.8.2026.10.16.09.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:18:20 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:18:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v12-S2 00/11] net/dpaa2 updates
Message-ID: <20261016091818.7e30a075@phoenix.local>
In-Reply-To: <20261016070339.3011744-1-prashant.gupta_3@nxp.com>
References: <20261015092513.2427856-1-prashant.gupta_3@nxp.com>
 <20261016070339.3011744-1-prashant.gupta_3@nxp.com>
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

On Fri, 16 Oct 2026 12:33:28 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> Changes in v12:
> - Restore VXLAN rte_flow item documentation in dpaa2.ini to
>   keep documentation aligned with PMD capabilities.
> - Fix documentation check failure reported after application
>   to next-net.

This is worse not better.

Subject: Re: [PATCH v12-S2 00/11] net/dpaa2: ...

Series applies cleanly to 26.11-rc1 and every commit builds with
-Dwerror=true.

The doc-vs-code problem is not fixed, it is now hidden. Patch 10
removes VXLAN support but leaves "vxlan = Y" in the feature matrix.
check-doc-vs-code.sh passes only because a stray
RTE_FLOW_ITEM_TYPE_VXLAN reference survives in
dpaa2_flow_item_convert().

Pre-existing, separate fix needed: dpaa2_flow_item_convert() allocates
one item too few. For "eth / end" num ends at 1, rte_malloc() gets
1 * sizeof(item), then new_pattern[1] is written for the END marker.
An empty pattern also reads pattern[1] past the end.

	for (num = 0; pattern[num].type != RTE_FLOW_ITEM_TYPE_END; num++)
		;
	new_pattern = rte_malloc(NULL, sizeof(*new_pattern) * (num + 1),
				 RTE_CACHE_LINE_SIZE);


Patch 06/11 net/dpaa2: set default flow miss action per device

Error:
  default_flow = min(fs_entries, dist_queues) - 1 is computed at probe
  from hardware attributes, but fs_miss_flow_id is a queue index inside
  the TC distribution, and dist_size is nb_rx_queues / num_rx_tc set at
  configure time. A DPNI with 16 queues where the app configures 4 Rx
  queues gets fs_miss_flow_id 15 with dist_size 4: either MC rejects
  dpni_set_rx_fs_dist() and every rte_flow create fails, or unmatched
  frames go to an unconfigured queue. The old default (0) was always
  valid. fs_entries is the FS table size, not a flow id, and should not
  be in this expression at all.

  Compute it where dist_size is known and drop the priv field:

	tc_cfg.enable = true;
	tc_cfg.fs_miss_flow_id = dist_size - 1;

  Or keep 0. Either way the release note must say which queue gets
  unmatched frames.

Patch 07/11 net/dpaa2: identify Rx mbuf hash information by FLC

Warning:
  Commit message says TC and flow id are stored via
  rte_mbuf_sched_set(); the code writes m->hash.fdir.hi. Fix the
  message.

  RTE_MBUF_F_RX_FDIR_ID means hash.fdir.hi holds the id from a MARK
  action. This driver has no MARK action, so applications see a
  synthetic (tc << 16) | flow value as if it were a mark. Set only
  RTE_MBUF_F_RX_FDIR, or implement RTE_FLOW_ACTION_TYPE_MARK.

Patch 09/11 net/dpaa2: parse tunnel and fragmented packet types

Warning:
  Parse summary 0x0001 was mapped to RTE_PTYPE_L3_IPV4_EXT (options
  present). Now it is L3_IPV4_EXT | L4_FRAG. The slow path treats
  options (L3_IP_1_OPT_PRESENT) and fragments (L3_IP_1_*_FRAGMENT) as
  independent bits, so one summary code cannot mean both. If 0x0001 is
  the fragment code, the mapping should be:

	case DPAA2_PKT_TYPE_IPV4_EXT:
		m->packet_type = RTE_PTYPE_L2_ETHER |
			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_FRAG;

  and the IPV4_EXT/IPV6_EXT names should be changed to match. If it
  is the options code, drop L4_FRAG.

Patch 10/11 net/dpaa2: remove unused soft parser driver

Error:
  doc/guides/nics/features/dpaa2.ini still has "vxlan = Y". Commit
  message and release note both say the item is no longer advertised.

	-vxlan                = Y

  The leftover VXLAN check in dpaa2_flow_item_convert() is what keeps
  the doc-vs-code script quiet. Remove it:

	-		if (pattern[num].type == RTE_FLOW_ITEM_TYPE_VXLAN)
	-			tunnel_start = 1;
	-		else if (tunnel_start)
	-			new_pattern[num].in_tunnel = 1;

Error:
  dpaa2_flow_create() does not call dpaa2_flow_validate(), and the
  default case in dpaa2_generic_flow_set() sets ret = -ENOTSUP and
  breaks out of the switch without leaving the loop; the action loop
  then overwrites ret. With the VXLAN/ECPRI cases removed,
  "eth / ipv4 / udp / vxlan / end actions queue index 1" now creates a
  rule matching all UDP. Fix before (or in) this patch:

		default:
			DPAA2_PMD_ERR("Invalid flow item[%d] type(%d)",
				i, pattern[i].type);
			ret = -ENOTSUP;
	-		break;
	+		goto end_flow_set;

Warning:
  Removing the VXLAN/ECPRI cases in dpaa2_flow_extract_support() left
  two dead "break;" lines after the GRE case.

  Leftovers from the removal:
    dpaa2_ethdev.h: dpaa2_soft_parser_loaded() prototype
    dpaa2_ethdev.h: ss_offset, ss_iova, ss_param_iova in dpaa2_dev_priv
    dpaa2_ethdev.h: DPAA2_ECPRI_MAX_EXTRACT_NB
    dpaa2_flow.c:   #include <sys/mman.h>

Info:
  With VXLAN gone nothing sets in_tunnel, so tunnel_start and every
  "if (dpaa2_pattern->in_tunnel)" branch in the configure handlers is
  dead. Fine as a follow-up.

Patch 11/11 net/dpaa2: rename Rx queue flags

Warning:
  Commit message says mechanical rename, but it adds
  DPAA2_RX_PRINT_PSR_RESULT_FLAG, which nothing uses. Drop it.

Patch 01/11 net/dpaa2: fix integer overflow in CCSR region mapping

Warning:
  Second paragraph of the commit message is wrong. For len 4096 on a
  64K-page kernel the old code masked len to 0 and then bumped it to
  PAGE_SIZE, so the mapping did not fail. The real defect is that the
  old length ignored offset, so a region crossing a page boundary was
  not fully mapped. Since this goes to stable, the message should say
  that.

Info:
  PAGE_SIZE and PAGE_MASK in dpaa2_recycle.c are now unused; remove.

Patch 03/11 net/dpaa2: support larger burst size

Info:
  Limit for non-LX2160A (and LX2160A with dpni < 8.7) drops from 65536
  to 0xF7FF. Mention that in the commit message. Write 0x37FFF instead
  of 229375 so it matches the fsl_dpni.h comment.
