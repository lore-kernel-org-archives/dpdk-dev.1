Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E3606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Qak7zNwy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DAD8402DF;
	Fri, 27 Nov 2026 18:35:10 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 4D54C402C1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 18:35:09 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3b54096b2d0so357729a91.1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795800908;
 x=1796405708; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lRnX/H2AfMGeRdpczdv7/CzQh0kgy7p6f4izjhNz2XA=;
 b=Qak7zNwy8NtvLsa8AVVeAuwBQzLcZyBI1t/tBUwsTvdZpNfiDvUF0mya7n4UiQ3LrL
 kVsg1oHe7eTO9OvQNmEQfmW6hZ3XsrTwN4wv66YbQqUmgbfGVXeiS6w5cBhDM8nBLLCk
 HsFtuPtKQ3ImU8lDi9beYls2mCWrjVW1e5B3lwHKgFAwwWMCqeuL7+TLU6mkrmFqkGxj
 4Q8NAKAc1MBbGsbDvD7KJ6Zh6buN6D+06n0m/F7DFIhggq5WECvHxUtSoopPe0jNC3jf
 pwh8ze2suu5lhHh1FGXXZJYx5C5FL9wzST12+cWgE7L9Lw5LWAn7NtIu6m6cqx5fGWmV
 yjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800908; x=1796405708;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lRnX/H2AfMGeRdpczdv7/CzQh0kgy7p6f4izjhNz2XA=;
 b=FwbMnQJpgv0cTCQDsR5/QClQTxKgzyIxElYffUDt8CgYK0GP6vajF7Qqswc0phryOG
 fuuat4K0dd+VCT2huVWH/Oo8KijT419zFEu6O9/RtJXvKoml3LqtjHKOHpURWRSqMJK5
 Fic+cjVzC4BBm10H0SBHyef3s4vkTGHcNpYUzka5R85+q+skuJGm0T4Qu2s5trCyfprx
 fN18n+/W49cSX1sHHIfH7Tioi308zWAJqIcEOBeihSka/vtRnvNaVe68c4aAKSssj+5q
 KOhGxR+7TJEWNgsBwBMmwU82oRiBqgOUrsKbQfckgJbOtICCdrUgQ+Ut3n+A7k3gvESo
 G7hg==
X-Gm-Message-State: APuU4Z9HKdpfsktbvsO7x1EpV1hz1q+9YIFiNueL3M5DjkVNHTsXEsgx
 DS40N7x6OiESJDp+AMH4US8Qj1OCxxRWxql0pJ59H8LxV3aAeU2OHm1siQ5nfNlDLfiONNquVzP
 owDkcTQc=
X-Gm-Gg: AZFdTZelBPnhorh2k5MqHYjkv1QZJ2ONrr4Th/XIGVP7oo2AOahmfq7EWdxp2pJHb7w
 XyNUjKnHwDOGuWpmviBvLRmusja1wfpyPczwWQHrHJmr3ckDVJAHHggXLI5fLuy9EbEcGiR0nnr
 KMRaFSLXoqxd8I2MlQGBjRWU82uEWwJLVrhHLDRi4+bXaK7nwUtWAUxUWVaR2qG6B3JEdvvmbXF
 MAGGC3Yb2wD16BoUtrOYnleisgQ6Tf05G14V2SOkPnwSMjbjCnH742cwN4rtid0CEP6Q89dp+tr
 x1aOWJcPlVWyaosgOXWAkvM+g9t+PBwgtC2Q29UskWMGuBVOA5g/EvVXiRUOQMohmvSYen/ODzk
 eMv5WpQExSdJUXfAXJehSmDLDKeLPLTabQOHIaLQCyzpwV55YhX9MfQyADVLlQH/2sLtv6hxO62
 E21Mte8N8L+TXaJI6Y/lCUlfX/07DvhMOskuoZplpwqsUtmXhfEKa1KKbd3kWa8rQLmA3Edp2c1
 gc9g9bB9MR5S+K5YsrIpyVpo0Nv17g+8Lmex7/3IrD9TSwy48sDhvfrWdu6/g5qRRPOuF6UdZnH
 zfiVvWng+65cMjlFLxXMuNG92eAy7MJ/ZjL0dbf+/OMcyViLJZoD7a7ugLX1vv3hHLsRZmQ=
X-Received: by 2002:a17:90b:258e:b0:3b4:fd89:5f99 with SMTP id
 98e67ed59e1d1-3b4fd896a22mr9401294a91.17.1795800904885; 
 Fri, 27 Nov 2026 09:35:04 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d96bd3sm42109052a91.12.2026.11.27.09.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:35:04 -0800 (PST)
Date: Fri, 27 Nov 2026 09:35:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/11] net/nbl: add Draco support
Message-ID: <20261127093502.6e554696@phoenix.local>
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 15:34:17 +0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> This series adds support for Nebulamatrix Draco adapters to the NBL PMD.
> 
> Dimon Zhao (11):
>   net/nbl: prepare common interfaces for draco
>   net/nbl: add draco HW layer
>   net/nbl: add draco channel layer
>   net/nbl: add draco resource layer
>   net/nbl: add draco dispatch layer
>   net/nbl: add draco device layer
>   net/nbl: support draco queue setup and release
>   net/nbl: support draco Tx and Rx burst
>   net/nbl: support draco stats and xstats
>   net/nbl: support draco hardware VLAN offload
>   doc: update nbl driver guide for draco
> 
>  doc/guides/nics/nbl.rst                       |   8 +
>  drivers/net/nbl/meson.build                   |   2 +
>  drivers/net/nbl/nbl_core.c                    |  19 +-
>  drivers/net/nbl/nbl_core.h                    |  10 +
>  drivers/net/nbl/nbl_dev/nbl_dev.c             |  85 +++++-
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |   5 +-
>  drivers/net/nbl/nbl_dispatch.c                | 170 ++++++++---
>  drivers/net/nbl/nbl_dispatch.h                |   1 +
>  drivers/net/nbl/nbl_ethdev.c                  |   9 +
>  drivers/net/nbl/nbl_hw/nbl_channel.c          | 135 ++++-----
>  drivers/net/nbl/nbl_hw/nbl_channel.h          |  91 ++++--
>  drivers/net/nbl/nbl_hw/nbl_hw.h               |   4 +
>  .../nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c   | 244 ++++++++++++++++
>  .../nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h   |  62 ++++
>  .../nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c   | 274 ++++++++++++++++++
>  .../nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h   |  10 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c | 181 ++++++------
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |  80 +++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             |  74 ++++-
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  10 +-
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |   2 +
>  drivers/net/nbl/nbl_include/nbl_def_hw.h      |   5 +
>  .../net/nbl/nbl_include/nbl_def_resource.h    |   5 +
>  drivers/net/nbl/nbl_include/nbl_include.h     |  10 +
>  24 files changed, 1247 insertions(+), 249 deletions(-)
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h
> 

I did first pass AI review and it saw this:
Review of [PATCH v1 00/11] net/nbl: draco support

Applied to main (ddb3b0c, 27.03-rc0) with git am, no conflicts.
Every commit builds with -Dwerror=true -Denable_drivers=net/nbl (gcc).
Review is from post-apply source. No hardware, nothing was run.

Series
------

Warning: draco PF is coexistence only, but the series tests that with
a different predicate than the rest of the driver. Patches 05/06 use

	if (!NBL_IS_COEXISTENCE(common) && !common->is_vf)

which is devfd != -1. nbl_chan_setup_ops(), nbl_dev_common_start() and
nbl_pci_unmap_device() use NBL_IS_NOT_COEXISTENCE(), which is
nl_socket_route < 0 || ifindex < 0. nbl_pci_map_device() does not fail
when NBL_DEV_USER_GET_IFINDEX or the netlink socket fails, so devfd can
be valid while NBL_IS_NOT_COEXISTENCE() is true. In that state a draco
PF passes the check in nbl_dev_snic_init(), gets nbl_chan_ops (native
mailbox), and nbl_userdev.c has set mem_resource[2].addr = 0, so
nbl_hw_config_mailbox_txq() writes through a NULL mailbox_bar_hw_addr.
Use the same macro as the channel layer:

	if (adapter->caps.product_type == NBL_DRACO_TYPE &&
	    NBL_IS_NOT_COEXISTENCE(common) && !common->is_vf) {

Warning: nbl_hw_draco_snic.c is nbl_hw_leonis_snic.c with capture_bdf
added and one delay replaced by a readback; nbl_res_draco.c differs from
nbl_res_leonis.c only in the stats table and nbl_res_start(). That is
about 400 lines of copy. Share the code and keep only the differences
per product (ops table, stats table, mbx write, bdf capture).

Warning: no release note. New device family in an existing driver
belongs in release_27_03.rst.

Info: 01/11 adds the draco IDs to pci_id_nbl_map, but the port is not
usable until 08/11. Move the ID table entries to 08/11 and most of the
"return -ENOTSUP until the next layer exists" churn in 01-07 goes away.

Patch 03/11: add draco channel layer
------------------------------------

Warning: product_type is stored inside one arm of the union it is
supposed to describe:

	union nbl_chan_info {
		struct { ... enum nbl_product_type product_type; } mailbox;
		struct { ... } userdev;
	};

and nbl_chan_recv_msg() reads chan_info->mailbox.product_type on the
userdev path too (nbl_chan_userdev_eventfd_handler). It only works
because the field lands at offset 280 and the userdev arm is 80 bytes.
Draco PF always runs the userdev arm. Put it in struct nbl_channel_mgt.

Warning: DESC_R()/DESC_W() silently use a local named chan_info, and
nbl_chan_recv_msg() grows a variable only to feed the macro. Pass the
type explicitly, for example

	static inline bool nbl_chan_is_draco(const struct nbl_channel_mgt *m)
	#define DESC_R(mgt, desc, field) ...

or, since only buf_len/buf_addr (Tx) and buf_len/buf_id (Rx) move
between the two layouts (checked with offsetof, the rest is at the same
offset), keep one struct and add small accessors for those fields.

Patch 05/11: add draco dispatch layer
Patch 06/11: add draco device layer
-----------------------------------

Warning: 06/11 rewrites a line 05/11 just added (devfd == -1 becomes
!NBL_IS_COEXISTENCE). Fold that into 05/11.

Info: the NBL_DISP_CTRL_LVL_MGT branch in nbl_disp_draco_init() cannot
be used. nbl_dev_snic_init() rejects the only case that selects it, and
draco has no resource ops behind the MGT level calls. Set NET
unconditionally and drop the branch.

Patch 07/11: support draco queue setup and release
--------------------------------------------------

Info (pre-existing, not introduced here, but the patch rewrites the
lines): the fallback Tx header slots overlap for leonis.

	u = RTE_PTR_ADD(tx_region, (size_t)desc_index * txq->exthdr_len);

Leonis stride is 12 bytes, but the VLAN fallback writes
12 + 14 + 4 = 30 bytes at u. A single segment packet that cannot be
pushed uses two descriptors, so the next such packet starts 24 bytes
later and overwrites the ether_type and VLAN header of the previous one
before the kick. The memzone is already nb_desc * NBL_TX_HEADER_LEN, so

	u = RTE_PTR_ADD(tx_region, (size_t)desc_index * NBL_TX_HEADER_LEN);
	...
	head_desc->addr = net_hdr_mem +
			  (size_t)desc_index * NBL_TX_HEADER_LEN;

fixes it for both products. Separate patch with Fixes: and Cc: stable.

Patch 08/11: support draco Tx and Rx burst
------------------------------------------

Info: this changes leonis as well. nbl_res_txrx_update_rx_ring() used
to OR the wrap flag into bit 0 of next_to_use and now puts it in bit 15,
and nbl_fill_rx_ring() adds an MMIO write per refill on leonis. The
first looks like a bug fix; say so in the commit message and state that
leonis was retested.

Patch 09/11: support draco stats and xstats
-------------------------------------------

Warning: masking the delta fixes the bogus huge value after a wrap, but
the reported xstat is still only 32 (or 48) bits wide:

	return (current - baseline) & ((UINT64_C(1) << bits) - 1);

eth_rx_prioN_packets goes back to 0 after 2^32 packets since the last
reset, which is a couple of minutes at 25G. xstats are 64 bit and
monotonic. Accumulate instead:

	delta = (cur - net_dev->hw_xstats_prev[i]) & mask;
	net_dev->hw_xstats_total[i] += delta;
	net_dev->hw_xstats_prev[i] = cur;
	xstats[count].value = net_dev->hw_xstats_total[i];

with xstats_reset clearing total[]. That still needs a read at least
once per wrap period; if the kernel PF can return widened counters that
is the better fix.

Warning: hw_xstats_bits is control path only bookkeeping, no need for
hugepage memory. Use calloc()/free() as hw_xstats already does:

	net_dev->hw_xstats_bits = rte_zmalloc("nbl_xstats_bits", priv_cnt, 0);

Patch 10/11: support draco hardware VLAN offload
------------------------------------------------

Error: the strip setting from dev_configure is never sent to hardware.
nbl_vlan_offload_set() is only reachable as the ethdev callback
(nbl_ethdev.c .vlan_offload_set); nothing in nbl_dev_configure() or
nbl_dev_port_start() calls it, and ethdev does not call it on
configure/start. An application that sets RTE_ETH_RX_OFFLOAD_VLAN_STRIP
in rxmode.offloads gets whatever parse mode the kernel PF left behind,
and one that leaves it off may still get tags stripped. Apply the
configured state at start:

	/* nbl_dev_port_start() */
	ret = nbl_vlan_offload_set(eth_dev, RTE_ETH_VLAN_STRIP_MASK);
	if (ret) {
		NBL_LOG(ERR, "vlan strip config failed %d", ret);
		goto ...;
	}

Warning: stripped priority-tagged frames lose the tag.

	if (rx_ext_hdr->draco.vlan & 0xFFF) {

VID 0 with a non-zero PCP is a valid 802.1Q tag. Hardware strips it,
the test fails, and the mbuf is delivered untagged with no
RTE_MBUF_F_RX_VLAN. If the Rx header has a "tag stripped" bit use it;
otherwise test the full 16 bits.

Warning: rx_hash_en no longer means what its name says. 07/11 adds it
as "selects the Rx header length ... RSS hash reporting is not enabled",
and this patch turns it on for every draco queue in a VLAN patch:

	param.rx_hash_en = adapter->caps.product_type == NBL_DRACO_TYPE;

without a word in the commit message. After this patch the
"if (!param->rx_hash_en) exthdr_len -= sizeof(u32)" branch is dead. If
the 16 byte header follows from half_offload_en, drop rx_hash_en and
the 12 byte case from the series and set half_offload_en where the
datapath is enabled (08/11), so the Rx header length does not change
between bisect points.

Info: nbl_disp_cfg_rx_vlan_parse() and the cfg_rx_vlan_parse resource
op have no implementation and no caller that can reach them (see the
MGT level note under 05/11). Drop them until something implements it.

Info (pre-existing, nbl_res_leonis.c, not touched by this series):
nbl_res_setup_ops() does rte_free(*res_ops_tbl) on memory that came from
calloc(). The draco copy has this fixed; leonis still needs it.
