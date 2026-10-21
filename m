Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B71606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZr9ZHsA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D0FB400D5;
	Wed, 21 Oct 2026 15:39:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 32DC340041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 15:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792589997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pauTAF2yhUz5eIG+ZMEuX+rw+28839QM6rQyyaWE22g=;
 b=CZr9ZHsAF+kYMekVEj8wV6PekkhGwfDW7P35aBVj2SBo11mbbli4qAZA6zpuo3aV7YZO8t
 Hzz+A5CtpQAdQOI7MrtCzm+0IsfqvAUVZC4Ib5KRwXywX2KqesJyHl3Duk2h8f8v9Rr3g0
 CFq6FkBkBh5W5gwA/hTCE7mMC3JJdaw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-N5DmZdYoOJaCGeZIixshGA-1; Wed, 21 Oct 2026 09:39:56 -0400
X-MC-Unique: N5DmZdYoOJaCGeZIixshGA-1
X-Mimecast-MFC-AGG-ID: N5DmZdYoOJaCGeZIixshGA_1792589995
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3ab136ebf59so4411951fa.2
 for <dev@dpdk.org>; Wed, 21 Oct 2026 06:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792589994; x=1793194794;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pauTAF2yhUz5eIG+ZMEuX+rw+28839QM6rQyyaWE22g=;
 b=cTnCC2J4bvQXJ4loy+Zfg9BS/VMHuWfv8MZnhCAdY+37ZK8L+qUt+SPtfxJxnabFtB
 ZcYPMFFx4ctq9kjzJhJOUmY1V2a1c/pUk1WpUFdquK7dVaZaXbQPUQl1udDHP2P55HfB
 0rbM976rpWIuda3iy5JjqZyKlj9RUq4mKSGD8h9gzsCkt/prkPp3j9MFtHd6QZt+SeCf
 C6Gw7Pa4cmtFZIsB8WmjlvU+OrNiWH0vyrvPHQ63Y7Xs5CogolKpPSVqXpgZE9ttSff0
 zpW1dyVKrXQLfylLhiDVbj2ECBg9rAlDcngvNs1uipO2l7IEFfXiOyqu8BzZEbJViVJt
 LPaQ==
X-Gm-Message-State: AFq9FYL4na5xpWmiCo1UNS+Il++kcViEXnDsHq0wv60+be9uP5wDJUn8
 IddHGnj/pIHpMlYkq7BAYlXay6H8qJEmYTcfuesUsA3VY2LvKdixWTr3djsB5CfgRgkmosNo0xv
 i+r3f8sM8ztKjN84M+lv1/ksYeS4nHx/ur+otvoi7mZ0O1jagbMFL2QN9jyQTmy/IcuZTKCI3ST
 21Cc9CXgOf1xjPwDZmoGQ=
X-Gm-Gg: AYBFou0KxRRMgC9AvB0P6La7GQAtBxH9u9j6TU2RT9lwqvbhbIyhBv/1KlqRYYTQpJ7
 5UqpUSx9m5/2reXyi9z4zUQOkcf1egOod5BcmbCZ56UF/6wNitmsVauJDnZbuv3w87SUO88agI5
 i96Ym5MsRQ9OJkXQ2SOlgBDPiMa4NONuHVJu1b4Kgi5Kqd+68FHe6XWE8bc0/FrqtjbsxkFBiUo
 q9JyzipNPPxfnr0OHXXvYlDuliZL81v6Nmt8W7LwhpRkrOK
X-Received: by 2002:a05:651c:54a:b0:3a9:9a60:2c46 with SMTP id
 38308e7fff4ca-3ac44179fa7mr5993331fa.11.1792589994430; 
 Wed, 21 Oct 2026 06:39:54 -0700 (PDT)
X-Received: by 2002:a05:651c:54a:b0:3a9:9a60:2c46 with SMTP id
 38308e7fff4ca-3ac44179fa7mr5993191fa.11.1792589993904; Wed, 21 Oct 2026
 06:39:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019063823.2831572-1-raghavendra.ningoji@amd.com>
In-Reply-To: <20261019063823.2831572-1-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Oct 2026 15:39:39 +0200
X-Gm-Features: AclHuK9fvq0fPrfGxaZMXYCYBte1dt-IB1BsITDWhtQONAUAU_1it0e1ok6gmlc
Message-ID: <CAJFAV8xLAv6qUT9Wvt2WkucoU53=GqWK_YnrLPmFPAOSkRFa_g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] raw/ntb: add AMD NTB support
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, jingjing.wu@intel.com, thomas@monjalon.net, 
 selwin.sebastian@amd.com, bhagyada.modali@amd.com, bruce.richardson@intel.com, 
 sachin.saxena@oss.nxp.com, hemant.agrawal@nxp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 59EMBRMnZJs2DFS94Lo8q_uNNEkcUJZP3jC8QQvi5-A_1792589995
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Mon, 19 Oct 2026 at 08:39, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> This series adds support for the Non-Transparent Bridge (NTB) endpoints
> integrated in AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors
> to the raw/ntb driver.
>
> Following David Marchand's review of v2, the common NTB code has been
> reworked so that it no longer relies on runtime checks of the vendor ops
> presence, and the vendor abstraction has been redesigned around a small
> set of mandatory ops instead of optional hooks with built-in fallbacks:
>
> - Patch 1 is a preparation commit that enforces the vendor ops once, at
>   probe time, and removes the per-call NULL checks that are scattered
>   throughout the common code.
>
> - Patch 2 generalizes the framework for multiple vendors. The link
>   bring-up/tear-down is now expressed through mandatory ops
>   (dev_handshake, peer_mw_validate, read_peer_config, link_cleanup); the
>   former built-in scratchpad logic moved into the Intel driver. The
>   mw_set_trans op is gone (it is now a vendor-internal concern of the
>   handshake), and there is a single common interrupt handler with just
>   one optional op (handle_hw_event) for vendor-specific hardware events.
>
> - Patch 3 adds the AMD hardware driver, its documentation, release note
>   and MAINTAINERS entry.
>
> A few AMD-specific hardware details worth noting for reviewers:
>
> - Primary/secondary topology. One endpoint enumerates as the primary
>   (device ID 0x14c0) and the other as the secondary (0x14c3), rather
>   than the Intel back-to-back model.
>
> - Packed scratchpad handshake. The hardware exposes a single shared
>   16-register scratchpad bank split into two disjoint 8-register sets
>   (one per side), so the driver uses a packed handshake layout that
>   fits in 8 registers, plugged in through the dev_handshake,
>   peer_mw_validate and read_peer_config ops.
>
> - Outbound translation window. AMD NTB uses an outbound translation
>   window: a write to a BARxx memory-window offset is forwarded to
>   (xlat_base | offset) in the peer's memory rather than
>   (xlat_base + offset). The translation base must therefore be aligned
>   to a power of two >=3D the window length so that no offset bit collides
>   with a set bit in the base. This is reported to applications through
>   the rte_pmd_ntb_get_mem_align() API and honoured by the ntb example
>   when reserving the memory window memzone.
>
> - Secondary-side link status. On the secondary side the device's own
>   PCIe link status does not reflect the true inter-host link, so the
>   speed and width are read from the upstream switch port via sysfs.
>
> Tested on a two-node setup (primary + secondary EPYC Embedded hosts)
> with the dpdk-ntb example: the link comes up at the expected speed and
> width on both sides, and file transfers are byte-correct end to end for
> both small and large files.
>
> Changes since v2:
>
> - The series is freshly rebased on main (26.11-rc0); the release note
>   and dpdk-devbind.py now apply cleanly and CI should pass.
>
> - New preparation patch (patch 1): the vendor ops are validated once at
>   probe time and all the runtime ntb_ops NULL checks in the common code
>   are removed.
>
> - Reworked the vendor abstraction (patch 2): dev_handshake,
>   peer_mw_validate, read_peer_config and link_cleanup are now mandatory
>   ops provided by both the Intel and AMD drivers. The built-in
>   scratchpad handshake/validate/cleanup/peer-config logic that used to
>   live in the common code moved into the Intel driver.
>
> - Dropped the mw_set_trans op: it is now a vendor-internal detail of the
>   handshake.
>
> - Dropped the vendor interrupt_handler op: there is now a single common
>   interrupt handler, with handle_hw_event as the only optional op, used
>   by AMD for its SMU/power-management events.

Thank you, that's better.

Still a few things to improve.

- On patch 1, prefer a simple check like:
  #define NTB_OPS_REQ(member) \
  if (hw->ntb_ops->member =3D=3D NULL) { \
    NTB_LOG(ERR, "Vendor ops lacks mandatory ." # member); \
    return -EINVAL; \
  }


- The change on alignment is not listed in the API changes section of
the release notes.
  An update in the RN should highlight that an application must now
rely on rte_pmd_ntb_get_mem_align() and not the mw_size_align field.
  Btw, why keep this field? It would be easier for a developer to
notice a broken compilation. No strong opinion on this point.


- Even though the AMD implementation is added now, I see no reason to
always list it after the Intel code.
  By this, I mean that you must alphabetically sort:
  - the files in meson.build,
  - when including the ntb_hw_amd.h header,
  - when adding the AMD PCI id in the driver mapping table,
  - when adding the PCI id in usertools/dpdk-devbind.py (I just
cleaned this up, I don't want to see the convention broken at the next
commit),
  - etc...


- The AMD topology definitions do not belong to patch 2, but patch 3.


- The pmd_private field is unneeded, please remove:
  - amd_hw->self_mmio is just a copy of ntb->hw_addr,
  - all uses of amd_hw->peer_mmio involve an addition with an offset.
    AMD implementation can simply rely on ntb->hw_addr +
AMD_PEER_OFFSET, or introduce a macro like:
    #define AMD_PEER_MMIO(ntb) RTE_PTR_ADD((ntb)->hw_addr, AMD_PEER_OFFSET)
  - all uses of self_spad / peer_spad involve a check on the peer, and
can be replaced with something like:
    #define AMD_SPAD_BASE(ntb, peer) (((ntb)->topo =3D=3D NTB_TOPO_PRI) =3D=
=3D
(peer) ? AMD_SPAD_SET_OFFSET : 0)
  - int_mask is an *unused* constant, making it a double reason to remove,
  - peer_status is unused,
  - ctl_status is unused,


- As I was reading the documentation, I noticed that you missed to
update doc/guides/rawdevs/ntb.rst with something like:

@@ -151,8 +177,9 @@ like the following:
 Limitation
 ----------

-This PMD is only supported on Intel Xeon Platforms:
+This PMD is supported on:

+- AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors.
 - 4th Generation Intel=C2=AE Xeon=C2=AE Scalable Processors.
 - 3rd Generation Intel=C2=AE Xeon=C2=AE Scalable Processors.
 - 2nd Generation Intel=C2=AE Xeon=C2=AE Scalable Processors.


- I also noticed strange indentation, so please double check the
coding style guidelines.
  And, DPDK allows lines up to 100 characters.


--=20
David Marchand

