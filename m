Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B68BC5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 18:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3BDA4013F;
	Fri, 14 Aug 2026 20:44:44 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 811A1400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 20:44:43 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so2200251a91.0
 for <dev@dpdk.org>; Fri, 14 Aug 2026 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786733082;
 x=1787337882; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qSSC5pwtz8Zor2fIJiu6fRT6RQzAVUlJM717ICpW8TI=;
 b=MKWrUHWzVnMdV73ougRj90GoZ3NvnMtbSHZvT6Y6dWmUPxFduVrriIhD17ir43MEVV
 SYklYWzN+07oL1URclVF03uFZrzLHxFwPKxc146PzHRXqjAMSpMKNlcb/k6FDA74rWWj
 SCWZbhrWXmMxxGUIaL1SU3pBDFMzODNRR6cjpcwta+7Hd1SCf8NUByYXwGXxg6HlJGTi
 FgFapjsiR9l+hmGKuz3vCWdgrpa44M8MCDolJ7dGk8We3jGatZjYeAGG3XmUSIAjEgir
 HWMLUGTnBIgYB/n3CNI4W3BFFAGUw89lOHcTlvPeEp6QXYnSfZC3PAvp5AkQF+5c/1wr
 Wfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786733082; x=1787337882;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qSSC5pwtz8Zor2fIJiu6fRT6RQzAVUlJM717ICpW8TI=;
 b=E9JmHSfZXCfGvKBhlzLWJwYi6w+5UGswz4jMhnfXxrjsNi3OqUaNFrbes4Ax3pNWdO
 Yf93Ztsyks4gNilVadpFDYwaaat3R2moQ63o/rczT3UXLMb2wYUmGEve1oka6SA0b5t9
 tqh9gmcLmFeBN3nfWEbk4qrKhQSsDUPgJ79kS3wTCZNdkLZI9rUe5S3f7Jsd4ofm32n4
 EtRGD3nJG4B6EstEYNBDSI6mLKLVQiXEMsH0MdcG5QeTrv0tcShOZcFYOpAGBAfyBz4h
 Ejke0yXoizv6Lm94ApawSE/o2e417SFi9kf7Tla6dKSxiCZ+zIn/TUtHyKbUFNUkj46y
 OKoQ==
X-Gm-Message-State: AOJu0YyPenfd0jTeykz8xougE1EczJCY0duxCAmtNr+cYkUzB0UVOd7L
 GDg18qd6XRp4Y6A6y1Mjliod7k7hOi+qBOzz9pbsqofO0l1sdm3qQpQJSExIFueogdTffA+dNJr
 arP37
X-Gm-Gg: AR+sD12KwSs85zvUnz3rAbIKZo6TtjY4yQOHhYtvGKd9ObFB9DU71in0SARvCab1Mjv
 ypafRckXbTlZgBgID0tB32L+wgab3NjqYDiFYLFGdC18NvZAFYOeaDP4kjAr9U0k9mNz0jpmP7L
 WpvvAE2+ZnAan2IHnFaSv9+LSpcZRz9ADKtj7WdkxVK7SBQ04bZiZ/PnJv2/fAMQWmPn+NcTWKb
 +p9Mek0zU/TpGPpm/ZAOntxhoTuLNd6NJAtj7bD4+yEeJgp+NcVycOcqqLMIm0zIHEXME/0t3fw
 pnoZfXsRMsfEnR+019+gqaCCmCyX7+vRDV9eNyDuT9A9GBGMVOdLP3QyssNbLJx0545UO0G3OLJ
 0z0R5TnCaE24vaW1/niCHNyTqbCn9HHSDxYTkae72ZwFih6JyHFrK986PFyirlgk9t7Shku659b
 p/GUPz70DIKZjSDFVyNJROlQgGHmZ4mwO2MzkphG0HSsRnxYg4HFWR8Zc2/mjbEMaimumAwJbzx
 3OLWDc0MrMYV+MqR/fR2WR2prgcrA==
X-Received: by 2002:a17:90b:4b10:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-3931f4a6536mr11409913a91.8.1786733082039; 
 Fri, 14 Aug 2026 11:44:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d5bd9679sm7259602eec.3.2026.08.14.11.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:44:41 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:44:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/13] net/sxe2: fix bugs
Message-ID: <20260814114426.4939a39d@phoenix.local>
In-Reply-To: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
References: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
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

On Fri, 14 Aug 2026 20:21:51 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Jie Liu (13):
>   net/sxe2: add Rx queue buffer split fill support
>   net/sxe2: update switchdev repr VSI ID display format
>   net/sxe2: add ACL engine event statistics support
>   net/sxe2: enhance device cap and res management
>   net/sxe2: improve representor device initialization
>   net/sxe2: refactor flow tunnel port handling
>   net/sxe2: validate IPsec key length against maximum limit
>   net/sxe2: enhance repre event handling and  MP code
>   net/sxe2: optimize vectorized Tx/Rx path
>   common/sxe2: allow munmap during kernel reset
>   net/sxe2: clean up duplicate function declarations
>   net/sxe2: clean up structure definitions
>   doc/sxe2: add acl-stat-type parameter documentation
> 
>  doc/guides/nics/sxe2.rst                   |  33 +--
>  drivers/common/sxe2/sxe2_common.c          |   5 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |   8 +-
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 215 +++++++++++++++--
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  15 +-
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  47 ++--
>  drivers/net/sxe2/sxe2_dump.c               |  10 +-
>  drivers/net/sxe2/sxe2_ethdev.c             | 203 +++++++++-------
>  drivers/net/sxe2/sxe2_ethdev.h             |  38 +--
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  13 +-
>  drivers/net/sxe2/sxe2_flow.c               | 259 +++++++++++++++++----
>  drivers/net/sxe2/sxe2_flow.h               |   6 +-
>  drivers/net/sxe2/sxe2_flow_define.h        |  13 +-
>  drivers/net/sxe2/sxe2_flow_parse_action.c  |  37 ++-
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ---------
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   7 -
>  drivers/net/sxe2/sxe2_ipsec.c              |   5 +
>  drivers/net/sxe2/sxe2_irq.c                |  27 ++-
>  drivers/net/sxe2/sxe2_mac.c                |  10 +-
>  drivers/net/sxe2/sxe2_mp.c                 |  65 +++---
>  drivers/net/sxe2/sxe2_mp.h                 |   3 +-
>  drivers/net/sxe2/sxe2_queue.c              |   2 +
>  drivers/net/sxe2/sxe2_queue.h              |   7 +-
>  drivers/net/sxe2/sxe2_rx.c                 |   5 +-
>  drivers/net/sxe2/sxe2_security.c           |   1 +
>  drivers/net/sxe2/sxe2_stats.c              |  10 +-
>  drivers/net/sxe2/sxe2_switchdev.c          |  12 +-
>  drivers/net/sxe2/sxe2_tx.c                 |  42 +++-
>  drivers/net/sxe2/sxe2_tx.h                 |   4 +
>  drivers/net/sxe2/sxe2_txrx.c               |  19 +-
>  drivers/net/sxe2/sxe2_txrx_poll.h          |   2 -
>  drivers/net/sxe2/sxe2_txrx_vec.c           |  77 +++---
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   1 +
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  10 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    | 123 +---------
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |   5 +-
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 215 +++++++++++------
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
>  drivers/net/sxe2/sxe2_vsi.c                |   8 +-
>  39 files changed, 993 insertions(+), 692 deletions(-)
> 

Claude Opus 5 AI review found lots of things to address.
It stopped after the first 5.

Overall: the series is titled as bug fixes but most patches mix feature
work, renames, log-message rewording, and unrelated fixes into single
commits. Several of the real bug fixes are buried in patches whose
subject describes something else, and none carry Fixes:/Cc: stable.
Please split these out.

Patch 3/13 (net/sxe2: add ACL engine event statistics support)

Error: stale count-manager pointer causes double free.

  In sxe2_flow_rte_list_free(), mgr is declared once outside the
  TAILQ_FOREACH_SAFE loop and never reset per iteration.
  sxe2_flow_query_mgr() writes *mgr_ptr only on the full success
  path; every error path leaves the caller's mgr untouched.
  sxe2_flow_free_mgr() is then still called (it is gated on the COUNT
  bit, not on ret), so on iteration N it operates on the mgr freed in
  iteration N-1: TAILQ_REMOVE() on an already-removed node plus a
  second rte_free().

  This is reachable whenever an expanded flow has more than one
  sxe2_flow entry with a COUNT action and the FW query command fails
  on a later entry.

  The new "user_id == 0 && mgr" guard fixes the first-iteration NULL
  case but not this one. Reset the pointer per iteration:

	TAILQ_FOREACH_SAFE(hw_flow, &flow->sxe2_flow_list, next, hw_flow_temp) {
		mgr = NULL;

  or declare mgr inside the loop body.

Error: sxe2_flow_free_mgr() frees without unlinking on unknown engine.

  If flow->engine_type is neither ACL nor FNAV, neither branch runs,
  cid_mgr_list stays NULL, no TAILQ_REMOVE happens -- and the function
  still falls through to rte_free(mgr). That leaves a freed node on
  whichever list it came from. Add an else branch that logs and skips
  the free, or return early.

Warning: sxe2_flow_query_mgr() returns 0 for an unrecognized engine
  type without setting *mgr_ptr. Callers treat 0 as "mgr is valid":
  sxe2_flow_query_count() does count->hits = mgr->hits with mgr still
  NULL. The COUNT action is currently rejected for non-FNAV/ACL
  engines in sxe2_flow_parse_action(), so this is not reachable today,
  but the contract is wrong. Return -ENOTSUP on that path.

Info: the trailing else in sxe2_flow_query_mgr()

	} else {
		PMD_LOG_ERR(DRV, "query flow engine neither FNAV nor ACL");
		ret = -ENOTSUP;
	}

  is dead -- the if/else-if/else at the top of the function already
  goto l_end for anything that is not ACL or FNAV.

Warning: unrelated fix in this patch.

	-#define SXE2_PCI_DEVICE_ID_VF_1 0x10b
	+#define SXE2_PCI_DEVICE_ID_VF_1 0x10b2

  A VF PCI device ID correction has nothing to do with ACL statistics.
  Separate patch, with Fixes: and Cc: stable@dpdk.org.

Warning: the rxq->fnav_enable assignment added to sxe2_queues_init()
  is also unrelated to this patch's subject.

Warning: the acl-stat-type devarg is added here but documented in
  patch 13/13. Code and documentation must land in the same commit.

Info: struct sxe2_flow_cid_mgr.stat_index is uint16_t, but
  sxe2_drv_flow_acl_get_stat_id() returns uint32_t and
  sxe2_drv_acl_query_stat_req.stat_id is __le32. The assignment
  mgr->stat_index = stat_index truncates. Pre-existing on the fnav
  side, but the new ACL path inherits it.

Patch 4/13 (net/sxe2: enhance device cap and res management)

Error: error-unwind regression in sxe2_dev_init().

  Before this patch:

	init_flow_err:
	init_rss_err:
		sxe2_security_uinit(dev);
	init_security_err:

  After:

	init_flow_err:
		sxe2_security_uinit(dev);
	init_rss_err:
	init_security_err:
		sxe2_intr_uninit(dev);

  sxe2_rss_disable() runs after sxe2_security_init() succeeded, so a
  failure there now jumps past sxe2_security_uinit() and leaks the
  security context. Move init_rss_err back above the security_uinit
  call.

Error: buffer-split ptype count includes the sentinel.

  sxe2_buffer_split_supported_hdr_ptypes_get() now sets
  *no_of_elements = RTE_DIM(ptypes), but the array still ends with a
  RTE_PTYPE_UNKNOWN terminator left over from the sentinel-based
  convention. rte_eth_buffer_split_get_supported_hdr_ptypes() copies
  all no_of_elements entries verbatim, so callers get a bogus
  RTE_PTYPE_UNKNOWN entry and an inflated count. Compare ice, whose
  array has no terminator. Drop the RTE_PTYPE_UNKNOWN element.

Warning: sxe2_dev_close() cleanup fixes are unlabelled.

  This patch removes a duplicate sxe2_switchdev_uninit() and a
  duplicate sxe2_dev_pci_map_uinit() from sxe2_dev_close(). Those are
  double-free fixes and belong in their own patch with Fixes: and
  Cc: stable@dpdk.org, not inside a "cap and res management" commit.

Info: dev_info->nb_rx_queues / nb_tx_queues are dead stores.
  rte_eth_dev_info_get() overwrites both from dev->data after the PMD
  op returns (lib/ethdev/rte_ethdev.c). Drop them.

Info: sxe2_dev_infos_get() returns -EINVAL directly on the new NULL
  vsi check while the rest of the file uses goto l_end. Minor
  inconsistency.

Info: after the new res_type bounds check in sxe2_dev_pci_res_seg_map(),
  the following "if (!addr_info || ...)" test is redundant --
  addr_info is &array[res_type] and can never be NULL.

Info: in sxe2_switchdev_repr_match(), port_idx is initialized to
  UINT16_MAX and then unconditionally overwritten by the for loop.

Patch 1/13 (net/sxe2: add Rx queue buffer split fill support)

Warning: the subject describes buffer split, but the patch also drops
  a debug log from __sxe2_drv_cmd_params_fill(), adds a
  sxe2_link_update() call to sxe2_drv_mac_link_status_get(), fixes an
  error path in sxe2_drv_udp_tunnel_get(), and rewords a dozen log
  messages. The udp_tunnel_get change is a real fix (the function
  previously copied response fields after a failed command); it wants
  its own patch with a Fixes: tag.

Info: sxe2_rxq_buf_split_fill() re-tests
  rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT, which the caller
  has already tested, so the else branch clearing hdr_len /
  split_type_mask is unreachable. Either drop the check in the helper
  or drop it in the caller.

Patch 5/13 (net/sxe2: improve representor device initialization)

  The added sxe2_stats_init() call and its l_init_irq_ctxt_err label
  unwind correctly. No findings.
