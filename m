Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744CFCA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 08:17:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B5D04026D;
	Sat, 10 Oct 2026 10:17:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C70F2400EF
 for <dev@dpdk.org>; Sat, 10 Oct 2026 10:17:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791620244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9VcEHrOh06M0ZLyxyMc72T2o3XVUUsYoHcf46RUQx60=;
 b=FVXwqZGrhid4AzC8elKc/MoUvstvYHTfUuQD35wkCwNO6TcrJCJAlFYvcNM13qtROOAZoT
 z69vxayvhcrnirDA6jMz4u/bEGboBUYKsu2WNFVocRfZiFAxlEq2u5tWNTr9TGTQ18nSOB
 C6oBfhg5AA01dLtBUR0Cv0VR0pyQLm8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-uqcf4i5QMFmEg75-OVIqdw-1; Sat, 10 Oct 2026 08:17:22 +0000
X-MC-Unique: uqcf4i5QMFmEg75-OVIqdw-1
X-Mimecast-MFC-AGG-ID: uqcf4i5QMFmEg75-OVIqdw_1791620241
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a87d45b84dso2847441fa.2
 for <dev@dpdk.org>; Sat, 10 Oct 2026 01:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791620241; x=1792225041;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9VcEHrOh06M0ZLyxyMc72T2o3XVUUsYoHcf46RUQx60=;
 b=BLYAS13NwwvEarKIbRoRJ8GP/WZcpygrQ3WZT7Zbfxk0uS9HRi/kIkAkJxAD46rsXs
 ZQauKr1RKdy001edoiiuYLmRujbWvGLebPouB0wfTd19HWBd/j/PfxasoiufM8Hogm0F
 VrxyL203whss4ZjLWmu2Ymdinxt/Q0b9a/ABSQHxStOsYCbfwMWkx/KApJofrPVEEmwi
 vUggeqz4BqHl8FcktzwQunG5qErPmxUud/hkyGEEgCJUw/bcQ/tigSl7uB56bKf6K5+a
 c1teBfFPAFhn9kN76mu7pcpjAdHgoq5wSks6NRV6tHsuxK942esx531eYbCAiPN3V6PO
 Hz8w==
X-Gm-Message-State: AFq9FYLH/l7Hy7Q4HNr40YfXHGpC5pKo7PU9ylIX3cj8AYAzy/w2nXGz
 ru9Fs6Rn02va66+C4zD6yLByQKZrEoepLYIhuZPQafqBJSDdDIEBBUyNToU3LbsePoa8fOHBXDe
 pVqedrT2Qtaw9EE4mq8gGRGxQc7KX2UJ7vtWIqm3SVoKDUlo1VBZa3NpbRSRUkhVB3eyqM1h76a
 ZA5C0VCsSPX1bgx1b1STU=
X-Gm-Gg: AYBFou1FqGAQ1sRYIDbC0XDqIJiqjGN+hNvdKLagrkn7p2I8QpkBqNFw4JBK3d31bBo
 FmUCMYQFK2byoQF3zj22XrNiJHDJ9348HBAlLi9+oP1Q/l7xxIvJGFhpqlXOl/ifImaehE6tiFd
 G1Hi85ORQ4u1sHoeU0sETEc7DSpa/RT4lzsK6eB1dLz6q3UvC4RbuAwVH3MVD9scwSmAdN8YhLz
 xXAVk1u8b6DlBLKoAr9zNwJhOq93U7BgcWw0LETON+aNsld
X-Received: by 2002:a2e:be25:0:b0:3a9:7d11:a790 with SMTP id
 38308e7fff4ca-3a9c56f09aamr10816821fa.21.1791620241165; 
 Sat, 10 Oct 2026 01:17:21 -0700 (PDT)
X-Received: by 2002:a2e:be25:0:b0:3a9:7d11:a790 with SMTP id
 38308e7fff4ca-3a9c56f09aamr10816701fa.21.1791620240694; Sat, 10 Oct 2026
 01:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260928104929.2373409-1-raghavendra.ningoji@amd.com>
In-Reply-To: <20260928104929.2373409-1-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 10 Oct 2026 10:17:08 +0200
X-Gm-Features: AclHuK9G8yntkxtjnzub7s9Q63fa-JnvZ1vg2FTz_cphKflEJnOgdnNJhmn8smQ
Message-ID: <CAJFAV8xvyNqfqfJk=SjKpJ-JsgRDybpzM5rtZVDORQMUcxhgtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] raw/ntb: add AMD NTB support
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, jingjing.wu@intel.com, thomas@monjalon.net, 
 selwin.sebastian@amd.com, bhagyada.modali@amd.com, bruce.richardson@intel.com, 
 sachin.saxena@oss.nxp.com, hemant.agrawal@nxp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T_8EQQXf2wJXjE_D5D4VM0Z5NehkG66VNabU1fo-McA_1791620241
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 28 Sept 2026 at 12:50, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> This series adds support for the Non-Transparent Bridge (NTB) endpoints
> integrated in AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors
> to the raw/ntb driver.
>
> The NTB rawdev framework was originally written around the Intel
> back-to-back topology and the built-in scratchpad handshake protocol.
> Patch 1 generalizes it so other vendors can reuse the common code, and
> patch 2 adds the AMD hardware driver together with its documentation.
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
>   fits in 8 registers, plugged in through the dev_handshake and
>   read_peer_config hooks.
>
> - Outbound translation window. AMD NTB uses an outbound translation
>   window: a write to a BARxx memory-window offset is forwarded to
>   (xlat_base | offset) in the peer's memory rather than
>   (xlat_base + offset). The translation base must therefore be aligned
>   to a power of two >= the window length so that no offset bit collides
>   with a set bit in the base. This is reported to applications through
>   the new rte_pmd_ntb_get_mem_align() API and honoured by the ntb
>   example when reserving the memory window memzone.
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
> Changes since v1:
>
> - Replaced the mw_addr_align field in struct ntb_dev_info with a
>   mem_align op and the rte_pmd_ntb_get_mem_align() API, so the
>   base-address alignment computation lives in the driver and the
>   application just queries it. The ntb example no longer open-codes the
>   power-of-two/alignment logic (Bruce Richardson's review of patch 2).
>
> - Squashed the documentation, release note and MAINTAINERS update into
>   the AMD driver patch, and documented the alignment API in the guide
>   (2 patches instead of 3).
>
> - Minor meson.build formatting cleanup (trailing comma).
>
> - Patch 1 keeps the ntb_dev_ops hooks (interrupt_handler, dev_handshake,
>   read_peer_config) as optional, with the built-in scratchpad path used
>   when a hook is NULL, as discussed on the v1 thread.

I took some time to look at this driver.

- (even before this series) the driver is riddled with runtime checks
on the ntb_ops presence.
  As far as I can see, none of those checks are required and those
really make the code confusing.
  Instead, all ops should be enforced at probing time when selecting
the vendor ops.
  This could be a first preparation commit.

- The handshake op should be mandatory and provided by both Intel and
AMD implementations.
  This probably makes the mw_set_trans op a vendor specific concern
which does not have to be exposed as a op.
- I see no reason to have a separate interrupt handler. This should
stay in common code. It just needs some abstractions of some
operations:
  - read_peer_config (which is present in this series),
  - peer_mw_validate (which can be easily abstracted from the current
handshake handler),
  - link_cleanup (idem, can be abstracted from existing code),
- Only handle_hw_event seems optional, and it is better to keep
optional ops to a minimum, this reduces the runtime checks.


There is some rebase needed on the RN, and the dpdk-devbind.py (trivial).
Please make sure to send a series freshly rebased so that CI can pass
on next revision (did not happen on v2).


-- 
David Marchand

