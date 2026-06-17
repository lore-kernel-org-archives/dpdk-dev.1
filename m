Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8ACCD98F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 15:36:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02E2F40276;
	Wed, 17 Jun 2026 17:36:21 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id 8C9F540268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 17:36:18 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7ff0584c6b5so9209917b3.2
 for <dev@dpdk.org>; Wed, 17 Jun 2026 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781710578;
 x=1782315378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gF/4RZ/tUKLvaBVfq4U2QKrM6ngK2To+VdmCbrQYEnk=;
 b=A33V4UnL9DvPLzfNgBrpfSZWz/bkEq2qckL7Oli+6n/Cr5gJlXN9ndKiOo9ZmY9yhS
 A42F1MbYNoIT+FxctcXm++beckkNFUF+aqGuV2WE+tWXB/HTypX8y0SpT17vWSBEZH8O
 bxzmvW13AQ3Owcs+LsXmBlTcz6mgjNGlRNkDe8sWOgQ4At523U42Lgz5BsYEzYrqZxRQ
 h64UMOcyqZVEO8gJVdN7vIPsgsKe7ziE91whwZpw3OzjxmIVbMuCvUfu/3jgGxKDW2A2
 o9XpHW6hAjenCcrBvNHQjzzY2msxanlrLSFZTnZ3X2HVjIbwhJvgsWF3hXuwRecxfxpw
 9QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781710578; x=1782315378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gF/4RZ/tUKLvaBVfq4U2QKrM6ngK2To+VdmCbrQYEnk=;
 b=YJzIbgU1lgJaVVyBzbH8oibxWyl8jJpHJaHla1VI2gHc6dl7V409UZclrCsnQ72sBS
 SDbQ40hcjlsedm+8woM+kvGC2XZoD1mmNycc05LhDii+uj+fGnCGtkNA3LBvLW18QUc3
 iBxKjVYjlqRXNGDBasugFYLD6RklD8BEV9BSUjUuD8PwDj1OVkiASSyFK/QWWUJvsq4n
 dofDaE9LCZxy7uCroe2z63Ymz/i9g8zdXZP89vSaw50jS+8KYrBtiKl8ghpZMohf1evd
 uFGNILE+V2P7WmueWw6TxtDiC5r4jSgUlkbUFnwGzRzm8zFk4Z90ABx3DA6Zqc2NSfmr
 aqdQ==
X-Gm-Message-State: AOJu0Yz1Oqx/BY7a5MBFXLKveWtKakRlvdH+Cyo4wEZRTi2udOiD/LC/
 PmVa1BY+uhg6ov21lQz+YLmb38ImAM7zaozLnMNjfJLQpUXIZYr3veQ0hiZJ5mAJm/HpR9i6LPq
 Ns1g0
X-Gm-Gg: AfdE7cmyesIfQed0hoDQDYJDekmEkq67OYgMOSo5NmPicW0+R5SmHpkzndgJZpFP2Uv
 Q5zoyvBF6BQuYCnVu5qWxEurxGZ09gDih8WOjC3yFKfCcREGwKTmUqt7rnGZYkELfmPlT0Giny2
 CAtq9JGmG2K7shL1oVaFEoPaqxlPmevje9RrYzF28VjBNIx65sNFYoPZBxocMeCGpzwBdqBhI6F
 nCrXeNPGaG6KkHrNUuTJK0Tj4Ex+mob9mCLPm6bDQfG+cTKIisoHG3nHXlkplRKzPIZ5Ol9SDsd
 VbRSbVXaEefwkePYICysBaS8Hl1kMPq4OV5RuHFIOn08Gshq/6CeJlTStQl/pI/OMHK4LIyoBPS
 TPJ1HazX20UoesDsaFzoTpuggZ4/ioH/M4/SiH9vkQoNDKU2DnS3a0PGKGsHZj06gKK0yd77RzL
 cIdqGHpi8F+AhL8IerXpNUcBs28JOW6s3wqQAXhA7zuNlC9rPPwwyG0OkmV/TJk8/S
X-Received: by 2002:a05:690c:6506:b0:7dc:7764:3e7d with SMTP id
 00721157ae682-7fe5b8d9bb5mr42481207b3.9.1781710577634; 
 Wed, 17 Jun 2026 08:36:17 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7fcd2d7d1dfsm48158617b3.30.2026.06.17.08.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:36:17 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:36:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] Wangxun new feature
Message-ID: <20260617083614.5c897d9e@phoenix.local>
In-Reply-To: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.com>
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

On Wed, 17 Jun 2026 18:59:55 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This patchset introduces three new features and critical fixes for our
> recent release cycle.
> 
> Patch 1/2 adds support for UDP Segmentation Offload (USO) to improve
> large-packet transmission performance for UDP workloads.
> 
> Patch 3 enables VFs to sense PF ifconfig down/up events, allowing
> better fault tolerance and fast recovery in virtualized environments.
> 
> Patch 4 adds the missing VF support for the Amber-Lite 40G NICs, which
> was previously omitted in the initial integration.
> 
> Zaiyu Wang (4):
>   net/ngbe: add USO support
>   net/txgbe: add USO support
>   net/txgbe: add support for VF sensing PF down
>   net/txgbe: add VF support for Amber-Lite 40G NIC
> 
>  drivers/net/ngbe/ngbe_rxtx.c          | 13 +++---
>  drivers/net/txgbe/base/txgbe_devids.h |  2 +
>  drivers/net/txgbe/base/txgbe_hw.c     |  7 ++++
>  drivers/net/txgbe/base/txgbe_regs.h   |  7 +++-
>  drivers/net/txgbe/base/txgbe_type.h   |  2 +
>  drivers/net/txgbe/base/txgbe_vf.c     |  7 ++--
>  drivers/net/txgbe/txgbe_ethdev.c      |  4 +-
>  drivers/net/txgbe/txgbe_ethdev_vf.c   | 60 +++++++++++++++++++++++----
>  drivers/net/txgbe/txgbe_rxtx.c        | 13 +++---
>  9 files changed, 92 insertions(+), 23 deletions(-)
> 

Preliminary AI review found some bugs.

Review of [PATCH v2 0/4] net/{txgbe,ngbe}: USO, VF PF-down sensing,
                                              AML 40G VF support

Patch 3/4 (net/txgbe: add support for VF sensing PF down)

Error: dead store in txgbevf_get_pf_link_status() leaves the link
struct status field unmodified when the PF is down.

  +	if (!hw->pf_running) {
  +		link_up = false;
  +		link_speed = TXGBE_LINK_SPEED_UNKNOWN;
  +		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
  +		return rte_eth_linkstatus_set(dev, &link);
  +	}

The local variables link_up and link_speed are written here and never
read before the function returns, so they have no effect.  The actual
fields that need to change are link.link_status and link.link_speed,
neither of which is touched -- the function then publishes a link
struct that still has the previous link.link_status (whatever
rte_eth_linkstatus_get returned a few lines earlier) and only the
duplex updated.

Compare with the parallel code added in the same patch in
txgbevf_check_link_for_intr(), which gets it right:

  +		new_link.link_status = RTE_ETH_LINK_DOWN;
  +		new_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
  +		new_link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;

In txgbevf_get_pf_link_status, assign directly to the link fields:

	if (!hw->pf_running) {
		link.link_status = RTE_ETH_LINK_DOWN;
		link.link_speed = RTE_ETH_SPEED_NUM_NONE;
		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
		return rte_eth_linkstatus_set(dev, &link);
	}

Warning: the commit message describes a flag that is not what the code
checks.  The message says "Detect PF ifconfig down when
TXGBE_VT_MSGTYPE_SPEC is present in mailbox commands", but the
implementation in txgbevf_mbx_process does:

  +		if (!(in_msg & TXGBE_VT_MSGTYPE_CTS)) {

TXGBE_VT_MSGTYPE_SPEC is defined in base/txgbe_mbx.h with a different
bit (0x10000000) and is only used in the 5-tuple-filter request path.
The detection here is "CTS is absent", not "SPEC is present".
Please rewrite the commit message to match the code.

Warning: no release notes entry.  This is new VF behavior visible to
applications (a new INTR_RESET callback is dispatched when the PF
comes back up); doc/guides/rel_notes/release_26_07.rst should
mention it.

Info: msgbuf is declared as
u32 msgbuf[TXGBE_VF_PERMADDR_MSG_LEN] = {0}; but only msgbuf[0] is
ever used.  Either size it to one element or drop the zero-init since
only the first element is touched before write_posted.

Patch 4/4 (net/txgbe: add VF support for Amber-Lite 40G NIC)

Warning: stray blank line between the if() and its body in
txgbe_reset_hw_vf:

  +	if (hw->mac.type == txgbe_mac_aml_vf ||
  +	    hw->mac.type == txgbe_mac_aml40_vf)
  +
   		wr32(hw, TXGBE_BME_AML, 0x1);

The blank line is a no-op for C but reads as a typo and checkpatch will
flag it.  Remove the blank '+' line.

Warning: no release notes entry.  New device IDs are user-visible (the
VF binds devices that previously did not work); please add a brief
note to release_26_07.rst.

Info: in txgbe_check_mac_link_vf the patch drops the explicit
sp_vf/aml_vf check before the wait loop:

  -	if ((mac->type == txgbe_mac_sp_vf ||
  -	     mac->type == txgbe_mac_aml_vf) && wait_to_complete) {
  +	if (wait_to_complete) {

The simplification is fine since txgbe_check_mac_link_vf is only ever
called with a VF mac type, but it is an unrelated cleanup that could be
mentioned in the commit message (or split into its own patch).

Patches 1/4 and 2/4 (net/{ngbe,txgbe}: add USO support)

Info: it would help readers if the commit message noted that
RTE_ETH_TX_OFFLOAD_UDP_TSO was already advertised in tx_offload_capa
(see ngbe_get_tx_port_offloads / txgbe_get_tx_port_offloads), so this
patch fills in the data path for a capability that was previously
claimed but unimplemented.  Without that context the change looks like
a new feature addition; with it, it is clearly a fix and could carry a
Fixes: tag plus Cc: stable.

Info: a brief features-list or feature-matrix note in release_26_07.rst
would still be welcome since UDP_SEG offload now actually works.

Stephen Hemminger <stephen@networkplumber.org>
