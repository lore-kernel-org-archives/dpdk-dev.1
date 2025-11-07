Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F42CCFA19
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 19:24:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61E22402CB;
	Fri,  7 Nov 2025 20:24:28 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id CD4D04026D
 for <dev@dpdk.org>; Fri,  7 Nov 2025 20:24:26 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2958db8ae4fso9481445ad.2
 for <dev@dpdk.org>; Fri, 07 Nov 2025 11:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762543466; x=1763148266; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dQs8qM7qNO96BDwCALBBjMvodB2lByp+MWJwsJtrvqo=;
 b=CgyMZcr41s9bk+hQYReWm9ZUbX+GiAda4YALBS4bZnrIezBmv/ezAiuKErrAf80zg4
 OW6CrwYsJyde4rENldeP/hPWna0z2iOIqJMN2DQDG174Gj5U+tSJO+9JJNjk0XvO4xQ4
 MGxXJpmdibEZcMPZVbaWJLozv3GjCxSpXOC6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762543466; x=1763148266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQs8qM7qNO96BDwCALBBjMvodB2lByp+MWJwsJtrvqo=;
 b=ucQAxA4IwC6G0IggwbWTrYEOZecv4Hs+UNzAUSeF4O01msGsJW1caq3lQw/7rAOF+r
 ORO3ejCzaN6wQv7gDtjUouWT6TWpmMW51aTILWeoofgS15fBlm2sC2dU9Woj09JOa9pb
 nlTK9wUiG2WxLsELDTPhDLy4HCEcMYsQHSGrZ/6KMbhaqQEVonkoVY6uecHtnNa26CSA
 zKMFCnj/W0jw08SHB9mIOPov1s0KCNnaky9ZzNVn2l111xolne2Ka4wKxBcwiT4Nd1AI
 K2obU44ne6e+n3ccnW7PuDTTSl5jWSApH34jxpyakDKM3GOBoS059w4PSB/rNKpMU/wl
 kezQ==
X-Gm-Message-State: AOJu0Yx8dsOdI+VSYyae3kWk0Vpsxppwh808+xrXzkQwcCBCyqx/o/Yq
 +bvUHimtKyVRojiDE8zPyBfNnPlU646uw7ogNpHw9wSg/Lm0xH15dZbBlmfTSgncbPgXqG1Cxck
 cpzgwXiGrcc05hT/QFv1syteCcogtA24FUpyieH8qdBdU0qA/1ISbiXmJow==
X-Gm-Gg: ASbGnctGW2A/U1Q2zc/jbCA5K2C/VhYQsAdHCjYIokxNCohA+BZoXVxcaJUlnzg6rwg
 yib8BBFVlafDwc+F+ANL9kpFEU0qKrObMFA/Cs7tSnySkhj1WrsSvThXB8EKm6mSdMmv/SlVKnz
 6y7GI4rGodw5tH3K47WOaUvPHY7gHqOAI8UIBfx2d2qxWE5ajnek/TPQZ7MeewZe246ot2fqy5S
 9SqRgu87jXe2ZBF98p/YXxHRICaiJMvEDYFkwY69XZWsOUNHZqyjXoAtkbYTTMu86rvTLAWsYmH
 cCHCVr1zJkG5btcU3l0FzngTYfou
X-Google-Smtp-Source: AGHT+IF+OFJNhFf8wZRPe+DWnYK2YbkxsvZ2uW8ZiXoALlwkrF2c0+5xBG3ZUjF7rXsO4p8MX7Gd/pBfg8NbHqV8mOM=
X-Received: by 2002:a17:902:e74c:b0:295:5805:b380 with SMTP id
 d9443c01a7336-297e56f6e1bmr2339945ad.49.1762543465545; Fri, 07 Nov 2025
 11:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <20250808161539.485512-1-bruce.richardson@intel.com>
In-Reply-To: <20250808161539.485512-1-bruce.richardson@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 7 Nov 2025 14:23:15 -0500
X-Gm-Features: AWmQ_bkPFcIguYJHHRwXVjhIxAZwizEAL2h1ct9jEqg7mSPB8cYLMJ-dZ1QxRzU
Message-ID: <CAJvnSUC=Qg53EdE5XDQ+GU_KC-3XJB4nc9cKXk3ZfxueXTMMKQ@mail.gmail.com>
Subject: Re: [PATCH v2] doc: clarify VLAN and QinQ stripping behaviour
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000002a4f42064306213c"
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

--0000000000002a4f42064306213c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bruce, Morten,

1 follow up question about vlan_filter which is tangentially related to the
QinQ/VLAN stripping conversation.

Dean has a testcase in the QinQ testsuite which is supposed to check the
vlan_filter capability correctness when processing a packet with Tag 88a8 +
Tag 8100. So, the test steps are like:

1. Create 2 packets (for context, the Dot1AD just means 88a8)
        packets =3D [
            Ether(dst=3D"00:11:22:33:44:55", src=3D"66:77:88:99:aa:bb")
            / Dot1AD(vlan=3D100)
            / Dot1Q(vlan=3D200)
            / IP(dst=3D"192.0.2.1", src=3D"198.51.100.1")
            / UDP(dport=3D1234, sport=3D5678)
            / Raw(b"xxxxx"),
            Ether(dst=3D"00:11:22:33:44:55", src=3D"66:77:88:99:aa:bb")
            / Dot1AD(vlan=3D101)
            / Dot1Q(vlan=3D200)
            / IP(dst=3D"192.0.2.1", src=3D"198.51.100.1")
            / UDP(dport=3D1234, sport=3D5678)
            / Raw(b"xxxxx"),
        ]

2. enable vlan filter on testpmd port 0, set port 0 rx_vlan to 100
3. Transmit the 2 packets above from TG to testpmd on the SUT. The first
packet should be accepted, the second should be dropped.

What he is seeing is that (at least with an ice e810 card) both packets are
dropped. So, clearly the vlan_filter capability does not apply to 88a8 +
Tag 8100 packets in DPDK (at least right now). We were curious if DPDK was
skipping past the Dot1AD and reading the Dot1Q for the vlan_filter
operation, but it is not, as even when rx_vlan on testpmd is set to 200,
both packets are dropped.

The vlan_filter capability description from the docs (pasted below) is not
very verbose, so we can't tell whether it (should) apply to 88a8 packets or
not. In any case, I think we will remove this testcase from the testsuite
at least for this DPDK release (that will mean the testsuite just covers
QinQ_strip, vlan_strip, and how DPDK reads the tags) which are the parts we
are confident we are validating "correctly." But, I wanted to mention this
so the question of what is the correct vlan_filter action for these packets
is not lost. cheers.

---------

2.27. VLAN filter
Supports filtering of a VLAN Tag identifier.

[uses] rte_eth_rxconf,rte_eth_rxmode: offloads:DEV_RX_OFFLOAD_VLAN_FILTER.
[implements] eth_dev_ops: vlan_filter_set.
[related] API: rte_eth_dev_vlan_filter().





On Fri, Aug 8, 2025 at 12:15=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
> not very well documented. Even the documentation that does exist appears
> contradictory.
>
> For example, the doxygen docs for the mbuf flag
> RTE_MBUF_F_RX_QINQ_STRIPPED says:
>
>   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
>   is unset, only the outer VLAN is removed from packet data,..."
>
> but the docs for RTE_MBUF_F_RX_QINQ says:
>
>   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
>   headers have been stripped from mbuf data, ..."
>
> Without a good definition of what the correct behaviour is, it's not
> possible to assess and ensure conformance across drivers. Update the
> documentation for NIC features, ethdev and mbuf library to all report
> the same information.
>
> - VLAN strip implies stripping a single/outer tag of type 0x8100
> - QinQ strip implies stripping a single/outer tag of type 0x88a8, which
>   may be followed by a tag of 0x8100. That inner tag is stripped
>   if-and-only-if VLAN stripping is enabled too.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> V2: updated and reworded following discussion on RFC patch
> ---
>  doc/guides/nics/features.rst | 31 +++++++++++++++++++++++++++++++
>  lib/ethdev/rte_ethdev.h      | 28 ++++++++++++++++++++++++++++
>  lib/mbuf/rte_mbuf_core.h     | 32 ++++++++++++++++++--------------
>  3 files changed, 77 insertions(+), 14 deletions(-)
>
> diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
> index a075c057ec..df0b7edee7 100644
> --- a/doc/guides/nics/features.rst
> +++ b/doc/guides/nics/features.rst
> @@ -483,6 +483,11 @@ VLAN offload
>  ------------
>
>  Supports VLAN offload to hardware.
> +This includes both VLAN stripping on Rx and VLAN insertion on Tx.
> +
> +On Rx, VLAN strip removes one VLAN tag (default ethertype=3D0x8100) if
> present.
> +If multiple VLAN tags are present, it strips the outer tag only.
> +The stripped VLAN TCI is saved in mbuf->vlan_tci.
>
>  * **[uses]       rte_eth_rxconf,rte_eth_rxmode**:
> ``offloads:RTE_ETH_RX_OFFLOAD_VLAN_STRIP,RTE_ETH_RX_OFFLOAD_VLAN_FILTER,R=
TE_ETH_RX_OFFLOAD_VLAN_EXTEND``.
>  * **[uses]       rte_eth_txconf,rte_eth_txmode**:
> ``offloads:RTE_ETH_TX_OFFLOAD_VLAN_INSERT``.
> @@ -501,6 +506,32 @@ QinQ offload
>  ------------
>
>  Supports QinQ (queue in queue) offload.
> +This includes both QinQ stripping on Rx and QinQ insertion on Tx.
> +
> +On Rx, QinQ strip removes the outer QinQ tag (default ethertype=3D0x88a8=
)
> if present.
> +If multiple QinQ tags are present it only strips the outer tag.
> +The tag stripped is saved in mbuf->vlan_tci_outer.
> +
> +If an outer QinQ tag is stripped and if VLAN stripping is also enabled,
> +any inner VLAN tag (default ethertype=3D0x8100) is also stripped.
> +That tag is stored in mbuf->vlan_tci.
> +
> +Summary of VLAN and QinQ stripping behavior for some possible input
> traffic options:
> +
>
> ++----------------------+-----------------------+------------------------=
------+------------------------------+
> +| Input Traffic        | VLAN-strip on         | QinQ strip on
>     | Both on                      |
>
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Single Tag 0x8100    | Tag in vlan_tci       |
>     | Tag in vlan_tci              |
>
> ++----------------------+-----------------------+------------------------=
------+------------------------------+
> +| Single Tag 0x88a8    |                       | Tag in vlan_tci_outer
>     | Tag in vlan_tci_outer        |
>
> ++----------------------+-----------------------+------------------------=
------+------------------------------+
> +| Tag 88a8 + Tag 8100  |                       | Outer tag in
> vlan_tci_outer  | Outer tag in vlan_tci_outer  |
> +|                      |                       |
>     |                              |
> +|                      |                       |
>     | Inner tag in vlan_tci        |
>
> ++----------------------+-----------------------+------------------------=
------+------------------------------+
> +| Double Tag 0x8100    | Outer tag in vlan_tci |
>     | Outer tag in vlan_tci        |
>
> ++----------------------+-----------------------+------------------------=
------+------------------------------+
> +
>
>  * **[uses]     rte_eth_rxconf,rte_eth_rxmode**:
> ``offloads:RTE_ETH_RX_OFFLOAD_QINQ_STRIP``.
>  * **[uses]     rte_eth_txconf,rte_eth_txmode**:
> ``offloads:RTE_ETH_TX_OFFLOAD_QINQ_INSERT``.
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index f9fb6ae549..5e226ff1c9 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -1552,11 +1552,39 @@ struct rte_eth_conf {
>  /**
>   * Rx offload capabilities of a device.
>   */
> +/**
> + * VLAN strip offload.
> + *
> + * When enabled, strips one VLAN tag (ethtype=3D0x8100) if available.
> + * If multiple VLAN tags are present, it strips the outer tag.
> + * The stripped VLAN TCI is saved in mbuf->vlan_tci
> + * and @ref RTE_MBUF_F_RX_VLAN_STRIPPED flag is set.
> + *
> + * Note: if @ref RTE_ETH_RX_OFFLOAD_QINQ_STRIP is also enabled,
> + * the stripped tag may be an inner tag present after a QinQ tag
> (ethtype=3D0x88a8).
> + * In this case, both @ref RTE_MBUF_F_RX_QINQ_STRIPPED and
> + * @ref RTE_MBUF_F_RX_VLAN_STRIPPED flags will be set in the received
> mbuf.
> + */
>  #define RTE_ETH_RX_OFFLOAD_VLAN_STRIP       RTE_BIT64(0)
>  #define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
>  #define RTE_ETH_RX_OFFLOAD_UDP_CKSUM        RTE_BIT64(2)
>  #define RTE_ETH_RX_OFFLOAD_TCP_CKSUM        RTE_BIT64(3)
>  #define RTE_ETH_RX_OFFLOAD_TCP_LRO          RTE_BIT64(4)
> +/**
> + * QinQ strip offload.
> + *
> + * When enabled, strips outer QinQ tag (ethtype=3D0x88a8) if present.
> + * The stripped QinQ tag is saved in mbuf field vlan_tci_outer
> + * and @ref RTE_MBUF_F_RX_QINQ_STRIPPED flag is set.
> + *
> + * If a QinQ tag is stripped and VLAN stripping is also enabled,
> + * any inner VLAN tag (ethtype=3D0x8100) is also stripped and
> + * stored in mbuf field vlan_tci, with the flag @ref
> RTE_MBUF_F_RX_VLAN_STRIPPED
> + * being set.
> + *
> + * @see RTE_ETH_RX_OFFLOAD_VLAN_STRIP, @see RTE_MBUF_F_RX_QINQ_STRIPPED,
> + * @see RTE_MBUF_F_RX_VLAN_STRIPPED
> + */
>  #define RTE_ETH_RX_OFFLOAD_QINQ_STRIP       RTE_BIT64(5)
>  #define RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM RTE_BIT64(6)
>  #define RTE_ETH_RX_OFFLOAD_MACSEC_STRIP     RTE_BIT64(7)
> diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
> index a0df265b5d..824f11d438 100644
> --- a/lib/mbuf/rte_mbuf_core.h
> +++ b/lib/mbuf/rte_mbuf_core.h
> @@ -44,7 +44,7 @@ extern "C" {
>  /**
>   * The RX packet is a 802.1q VLAN packet, and the tci has been
>   * saved in mbuf->vlan_tci.
> - * If the flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN
> + * If the flag @ref RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLA=
N
>   * header has been stripped from mbuf data, else it is still
>   * present.
>   */
> @@ -66,7 +66,11 @@ extern "C" {
>   * A vlan has been stripped by the hardware and its tci is saved in
>   * mbuf->vlan_tci. This can only happen if vlan stripping is enabled
>   * in the RX configuration of the PMD.
> - * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also
> be set.
> + * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, @ref RTE_MBUF_F_RX_VLAN must
> also be set.
> + *
> + * Note: When @ref RTE_MBUF_F_RX_QINQ_STRIPPED is also set,
> + * the stripped tag is an inner tag, rather than a single or outer tag.
> + * @see RTE_MBUF_F_RX_QINQ_STRIPPED for more information.
>   */
>  #define RTE_MBUF_F_RX_VLAN_STRIPPED (1ULL << 6)
>
> @@ -113,19 +117,19 @@ extern "C" {
>  #define RTE_MBUF_F_RX_FDIR_FLX      (1ULL << 14)
>
>  /**
> - * The outer VLAN has been stripped by the hardware and its TCI is
> + * The outer QinQ Tag (ethtype=3D0x88a8) has been stripped by the hardwa=
re
> and its TCI is
>   * saved in mbuf->vlan_tci_outer.
> - * This can only happen if VLAN stripping is enabled in the Rx
> + * This can only happen if QinQ stripping is enabled in the Rx
>   * configuration of the PMD.
> - * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags RTE_MBUF_F_RX_VLAN
> - * and RTE_MBUF_F_RX_QINQ must also be set.
> + * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flag RTE_MBUF_F_RX_QINQ
> must also be set.
>   *
>   * - If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIPPED
> are
>   *   set, the 2 VLANs have been stripped by the hardware and their TCIs
> are
>   *   saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
>   * - If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPP=
ED
> - *   is unset, only the outer VLAN is removed from packet data, but both
> tci
> - *   are saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer=
).
> + *   is unset, only the outer VLAN is removed from packet data and
> + *   stored in mbuf->vlan_tci_outer.
> + *   The contents of mbuf->vlan_tci are undefined in this case.
>   */
>  #define RTE_MBUF_F_RX_QINQ_STRIPPED (1ULL << 15)
>
> @@ -149,12 +153,12 @@ extern "C" {
>  #define RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED       (1ULL << 19)
>
>  /**
> - * The RX packet is a double VLAN, and the outer tci has been
> - * saved in mbuf->vlan_tci_outer. If this flag is set, RTE_MBUF_F_RX_VLA=
N
> - * must also be set and the inner tci is saved in mbuf->vlan_tci.
> - * If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
> - * headers have been stripped from mbuf data, else they are still
> - * present.
> + * The RX packet is a QinQ packet, and the outer tci has been
> + * saved in mbuf->vlan_tci_outer.
> + * If the flag @ref RTE_MBUF_F_RX_QINQ_STRIPPED is also present,
> + * the QinQ tag has been stripped from mbuf data.
> + *
> + * @see RTE_MBUF_F_RX_QINQ_STRIPPED, @see RTE_MBUF_F_RX_VLAN, @see
> RTE_MBUF_F_RX_VLAN_STRIPPED
>   */
>  #define RTE_MBUF_F_RX_QINQ          (1ULL << 20)
>
> --
> 2.48.1
>
>

--0000000000002a4f42064306213c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Bruce, Morten,<div><br></div><div>1 follow up question =
about vlan_filter which is tangentially related to the QinQ/VLAN stripping =
conversation.</div><div><br></div><div>Dean has a testcase in the QinQ test=
suite which is supposed to check the vlan_filter capability=C2=A0correctnes=
s when processing a packet with=C2=A0Tag 88a8 + Tag 8100. So, the test step=
s are like:</div><div><br></div><div>1. Create 2 packets (for context, the =
Dot1AD just means 88a8)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets =3D [=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(dst=3D&quot;00:11:22:33=
:44:55&quot;, src=3D&quot;66:77:88:99:aa:bb&quot;)<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 / Dot1AD(vlan=3D100)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 / Dot1Q(vlan=3D200)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 / IP(dst=3D&quot;192.0.2.1&quot;, src=3D&quot;198.51.100.1&quot;)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(dport=3D1234, sport=3D5678)=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Raw(b&quot;xxxxx&quot;),<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(dst=3D&quot;00:11:22:33:44=
:55&quot;, src=3D&quot;66:77:88:99:aa:bb&quot;)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 / Dot1AD(vlan=3D101)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 / Dot1Q(vlan=3D200)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 / IP(dst=3D&quot;192.0.2.1&quot;, src=3D&quot;198.51.100.1&quot;)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(dport=3D1234, sport=3D5678)<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / Raw(b&quot;xxxxx&quot;),<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br><br>2. enable vlan filter on testpmd port =
0, set port 0 rx_vlan to 100</div><div>3. Transmit the 2 packets above from=
 TG to testpmd on the SUT. The first packet should be accepted, the=C2=A0se=
cond should be dropped.=C2=A0</div><div><br></div><div>What he is seeing is=
 that (at least with an ice e810 card) both packets are dropped. So, clearl=
y the vlan_filter capability does not apply to=C2=A088a8 + Tag 8100 packets=
 in DPDK (at least right now). We were curious if DPDK was skipping past th=
e Dot1AD and reading the Dot1Q for the vlan_filter operation, but it is not=
, as even when rx_vlan on testpmd is set to 200, both packets are dropped.<=
/div><div><br></div><div>The vlan_filter capability description from the do=
cs (pasted below) is not very verbose, so we can&#39;t tell whether it (sho=
uld) apply to 88a8 packets or not. In any case, I think we will remove this=
 testcase from the testsuite at least for this DPDK release (that will mean=
 the testsuite just covers QinQ_strip, vlan_strip, and how DPDK reads the t=
ags) which are the parts we are confident we are validating &quot;correctly=
.&quot; But, I wanted to mention this so the question of what is the correc=
t vlan_filter action for these packets is not lost. cheers.</div><div><br>-=
--------<br><br></div><div>2.27. VLAN filter<br>Supports filtering of a VLA=
N Tag identifier.<br><br>[uses] rte_eth_rxconf,rte_eth_rxmode: offloads:DEV=
_RX_OFFLOAD_VLAN_FILTER.<br>[implements] eth_dev_ops: vlan_filter_set.<br>[=
related] API: rte_eth_dev_vlan_filter().</div><div><br></div><div><br></div=
><div><br></div><div><br></div></div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 8, 2025 at=
 12:15=E2=80=AFPM Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@i=
ntel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">The behaviour of VLAN tag stripping Rx =
offloads is unclear in DPDK, and<br>
not very well documented. Even the documentation that does exist appears<br=
>
contradictory.<br>
<br>
For example, the doxygen docs for the mbuf flag<br>
RTE_MBUF_F_RX_QINQ_STRIPPED says:<br>
<br>
=C2=A0 &quot;If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_S=
TRIPPED<br>
=C2=A0 is unset, only the outer VLAN is removed from packet data,...&quot;<=
br>
<br>
but the docs for RTE_MBUF_F_RX_QINQ says:<br>
<br>
=C2=A0 &quot;If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both =
VLANs<br>
=C2=A0 headers have been stripped from mbuf data, ...&quot;<br>
<br>
Without a good definition of what the correct behaviour is, it&#39;s not<br=
>
possible to assess and ensure conformance across drivers. Update the<br>
documentation for NIC features, ethdev and mbuf library to all report<br>
the same information.<br>
<br>
- VLAN strip implies stripping a single/outer tag of type 0x8100<br>
- QinQ strip implies stripping a single/outer tag of type 0x88a8, which<br>
=C2=A0 may be followed by a tag of 0x8100. That inner tag is stripped<br>
=C2=A0 if-and-only-if VLAN stripping is enabled too.<br>
<br>
Signed-off-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@inte=
l.com" target=3D"_blank">bruce.richardson@intel.com</a>&gt;<br>
---<br>
V2: updated and reworded following discussion on RFC patch<br>
---<br>
=C2=A0doc/guides/nics/features.rst | 31 +++++++++++++++++++++++++++++++<br>
=C2=A0lib/ethdev/rte_ethdev.h=C2=A0 =C2=A0 =C2=A0 | 28 ++++++++++++++++++++=
++++++++<br>
=C2=A0lib/mbuf/rte_mbuf_core.h=C2=A0 =C2=A0 =C2=A0| 32 ++++++++++++++++++--=
------------<br>
=C2=A03 files changed, 77 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst<br=
>
index a075c057ec..df0b7edee7 100644<br>
--- a/doc/guides/nics/features.rst<br>
+++ b/doc/guides/nics/features.rst<br>
@@ -483,6 +483,11 @@ VLAN offload<br>
=C2=A0------------<br>
<br>
=C2=A0Supports VLAN offload to hardware.<br>
+This includes both VLAN stripping on Rx and VLAN insertion on Tx.<br>
+<br>
+On Rx, VLAN strip removes one VLAN tag (default ethertype=3D0x8100) if pre=
sent.<br>
+If multiple VLAN tags are present, it strips the outer tag only.<br>
+The stripped VLAN TCI is saved in mbuf-&gt;vlan_tci.<br>
<br>
=C2=A0* **[uses]=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eth_rxconf,rte_eth_rxmode**:=
 ``offloads:RTE_ETH_RX_OFFLOAD_VLAN_STRIP,RTE_ETH_RX_OFFLOAD_VLAN_FILTER,RT=
E_ETH_RX_OFFLOAD_VLAN_EXTEND``.<br>
=C2=A0* **[uses]=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eth_txconf,rte_eth_txmode**:=
 ``offloads:RTE_ETH_TX_OFFLOAD_VLAN_INSERT``.<br>
@@ -501,6 +506,32 @@ QinQ offload<br>
=C2=A0------------<br>
<br>
=C2=A0Supports QinQ (queue in queue) offload.<br>
+This includes both QinQ stripping on Rx and QinQ insertion on Tx.<br>
+<br>
+On Rx, QinQ strip removes the outer QinQ tag (default ethertype=3D0x88a8) =
if present.<br>
+If multiple QinQ tags are present it only strips the outer tag.<br>
+The tag stripped is saved in mbuf-&gt;vlan_tci_outer.<br>
+<br>
+If an outer QinQ tag is stripped and if VLAN stripping is also enabled,<br=
>
+any inner VLAN tag (default ethertype=3D0x8100) is also stripped.<br>
+That tag is stored in mbuf-&gt;vlan_tci.<br>
+<br>
+Summary of VLAN and QinQ stripping behavior for some possible input traffi=
c options:<br>
+<br>
++----------------------+-----------------------+--------------------------=
----+------------------------------+<br>
+| Input Traffic=C2=A0 =C2=A0 =C2=A0 =C2=A0 | VLAN-strip on=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| QinQ strip on=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | Both on=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+<br>
+| Single Tag 0x8100=C2=A0 =C2=A0 | Tag in vlan_tci=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Tag in vlan_tci=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
++----------------------+-----------------------+--------------------------=
----+------------------------------+<br>
+| Single Tag 0x88a8=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Tag in vlan_tci_outer=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | Tag in vlan_tci_outer=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<b=
r>
++----------------------+-----------------------+--------------------------=
----+------------------------------+<br>
+| Tag 88a8 + Tag 8100=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Outer tag in vlan_tci_outer=C2=A0 |=
 Outer tag in vlan_tci_outer=C2=A0 |<br>
+|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |<br>
+|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Inner tag in vlan_tci=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |<br>
++----------------------+-----------------------+--------------------------=
----+------------------------------+<br>
+| Double Tag 0x8100=C2=A0 =C2=A0 | Outer tag in vlan_tci |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | Outer tag in vlan_tci=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
++----------------------+-----------------------+--------------------------=
----+------------------------------+<br>
+<br>
<br>
=C2=A0* **[uses]=C2=A0 =C2=A0 =C2=A0rte_eth_rxconf,rte_eth_rxmode**: ``offl=
oads:RTE_ETH_RX_OFFLOAD_QINQ_STRIP``.<br>
=C2=A0* **[uses]=C2=A0 =C2=A0 =C2=A0rte_eth_txconf,rte_eth_txmode**: ``offl=
oads:RTE_ETH_TX_OFFLOAD_QINQ_INSERT``.<br>
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h<br>
index f9fb6ae549..5e226ff1c9 100644<br>
--- a/lib/ethdev/rte_ethdev.h<br>
+++ b/lib/ethdev/rte_ethdev.h<br>
@@ -1552,11 +1552,39 @@ struct rte_eth_conf {<br>
=C2=A0/**<br>
=C2=A0 * Rx offload capabilities of a device.<br>
=C2=A0 */<br>
+/**<br>
+ * VLAN strip offload.<br>
+ *<br>
+ * When enabled, strips one VLAN tag (ethtype=3D0x8100) if available.<br>
+ * If multiple VLAN tags are present, it strips the outer tag.<br>
+ * The stripped VLAN TCI is saved in mbuf-&gt;vlan_tci<br>
+ * and @ref RTE_MBUF_F_RX_VLAN_STRIPPED flag is set.<br>
+ *<br>
+ * Note: if @ref RTE_ETH_RX_OFFLOAD_QINQ_STRIP is also enabled,<br>
+ * the stripped tag may be an inner tag present after a QinQ tag (ethtype=
=3D0x88a8).<br>
+ * In this case, both @ref RTE_MBUF_F_RX_QINQ_STRIPPED and<br>
+ * @ref RTE_MBUF_F_RX_VLAN_STRIPPED flags will be set in the received mbuf=
.<br>
+ */<br>
=C2=A0#define RTE_ETH_RX_OFFLOAD_VLAN_STRIP=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_B=
IT64(0)<br>
=C2=A0#define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_B=
IT64(1)<br>
=C2=A0#define RTE_ETH_RX_OFFLOAD_UDP_CKSUM=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_B=
IT64(2)<br>
=C2=A0#define RTE_ETH_RX_OFFLOAD_TCP_CKSUM=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_B=
IT64(3)<br>
=C2=A0#define RTE_ETH_RX_OFFLOAD_TCP_LRO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
RTE_BIT64(4)<br>
+/**<br>
+ * QinQ strip offload.<br>
+ *<br>
+ * When enabled, strips outer QinQ tag (ethtype=3D0x88a8) if present.<br>
+ * The stripped QinQ tag is saved in mbuf field vlan_tci_outer<br>
+ * and @ref RTE_MBUF_F_RX_QINQ_STRIPPED flag is set.<br>
+ *<br>
+ * If a QinQ tag is stripped and VLAN stripping is also enabled,<br>
+ * any inner VLAN tag (ethtype=3D0x8100) is also stripped and<br>
+ * stored in mbuf field vlan_tci, with the flag @ref RTE_MBUF_F_RX_VLAN_ST=
RIPPED<br>
+ * being set.<br>
+ *<br>
+ * @see RTE_ETH_RX_OFFLOAD_VLAN_STRIP, @see RTE_MBUF_F_RX_QINQ_STRIPPED,<b=
r>
+ * @see RTE_MBUF_F_RX_VLAN_STRIPPED<br>
+ */<br>
=C2=A0#define RTE_ETH_RX_OFFLOAD_QINQ_STRIP=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_B=
IT64(5)<br>
=C2=A0#define RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM RTE_BIT64(6)<br>
=C2=A0#define RTE_ETH_RX_OFFLOAD_MACSEC_STRIP=C2=A0 =C2=A0 =C2=A0RTE_BIT64(=
7)<br>
diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h<br>
index a0df265b5d..824f11d438 100644<br>
--- a/lib/mbuf/rte_mbuf_core.h<br>
+++ b/lib/mbuf/rte_mbuf_core.h<br>
@@ -44,7 +44,7 @@ extern &quot;C&quot; {<br>
=C2=A0/**<br>
=C2=A0 * The RX packet is a 802.1q VLAN packet, and the tci has been<br>
=C2=A0 * saved in mbuf-&gt;vlan_tci.<br>
- * If the flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN<br>
+ * If the flag @ref RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN<=
br>
=C2=A0 * header has been stripped from mbuf data, else it is still<br>
=C2=A0 * present.<br>
=C2=A0 */<br>
@@ -66,7 +66,11 @@ extern &quot;C&quot; {<br>
=C2=A0 * A vlan has been stripped by the hardware and its tci is saved in<b=
r>
=C2=A0 * mbuf-&gt;vlan_tci. This can only happen if vlan stripping is enabl=
ed<br>
=C2=A0 * in the RX configuration of the PMD.<br>
- * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also b=
e set.<br>
+ * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, @ref RTE_MBUF_F_RX_VLAN must a=
lso be set.<br>
+ *<br>
+ * Note: When @ref RTE_MBUF_F_RX_QINQ_STRIPPED is also set,<br>
+ * the stripped tag is an inner tag, rather than a single or outer tag.<br=
>
+ * @see RTE_MBUF_F_RX_QINQ_STRIPPED for more information.<br>
=C2=A0 */<br>
=C2=A0#define RTE_MBUF_F_RX_VLAN_STRIPPED (1ULL &lt;&lt; 6)<br>
<br>
@@ -113,19 +117,19 @@ extern &quot;C&quot; {<br>
=C2=A0#define RTE_MBUF_F_RX_FDIR_FLX=C2=A0 =C2=A0 =C2=A0 (1ULL &lt;&lt; 14)=
<br>
<br>
=C2=A0/**<br>
- * The outer VLAN has been stripped by the hardware and its TCI is<br>
+ * The outer QinQ Tag (ethtype=3D0x88a8) has been stripped by the hardware=
 and its TCI is<br>
=C2=A0 * saved in mbuf-&gt;vlan_tci_outer.<br>
- * This can only happen if VLAN stripping is enabled in the Rx<br>
+ * This can only happen if QinQ stripping is enabled in the Rx<br>
=C2=A0 * configuration of the PMD.<br>
- * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags RTE_MBUF_F_RX_VLAN<b=
r>
- * and RTE_MBUF_F_RX_QINQ must also be set.<br>
+ * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flag RTE_MBUF_F_RX_QINQ mu=
st also be set.<br>
=C2=A0 *<br>
=C2=A0 * - If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIP=
PED are<br>
=C2=A0 *=C2=A0 =C2=A0set, the 2 VLANs have been stripped by the hardware an=
d their TCIs are<br>
=C2=A0 *=C2=A0 =C2=A0saved in mbuf-&gt;vlan_tci (inner) and mbuf-&gt;vlan_t=
ci_outer (outer).<br>
=C2=A0 * - If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STR=
IPPED<br>
- *=C2=A0 =C2=A0is unset, only the outer VLAN is removed from packet data, =
but both tci<br>
- *=C2=A0 =C2=A0are saved in mbuf-&gt;vlan_tci (inner) and mbuf-&gt;vlan_tc=
i_outer (outer).<br>
+ *=C2=A0 =C2=A0is unset, only the outer VLAN is removed from packet data a=
nd<br>
+ *=C2=A0 =C2=A0stored in mbuf-&gt;vlan_tci_outer.<br>
+ *=C2=A0 =C2=A0The contents of mbuf-&gt;vlan_tci are undefined in this cas=
e.<br>
=C2=A0 */<br>
=C2=A0#define RTE_MBUF_F_RX_QINQ_STRIPPED (1ULL &lt;&lt; 15)<br>
<br>
@@ -149,12 +153,12 @@ extern &quot;C&quot; {<br>
=C2=A0#define RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED=C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
ULL &lt;&lt; 19)<br>
<br>
=C2=A0/**<br>
- * The RX packet is a double VLAN, and the outer tci has been<br>
- * saved in mbuf-&gt;vlan_tci_outer. If this flag is set, RTE_MBUF_F_RX_VL=
AN<br>
- * must also be set and the inner tci is saved in mbuf-&gt;vlan_tci.<br>
- * If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs<br>
- * headers have been stripped from mbuf data, else they are still<br>
- * present.<br>
+ * The RX packet is a QinQ packet, and the outer tci has been<br>
+ * saved in mbuf-&gt;vlan_tci_outer.<br>
+ * If the flag @ref RTE_MBUF_F_RX_QINQ_STRIPPED is also present,<br>
+ * the QinQ tag has been stripped from mbuf data.<br>
+ *<br>
+ * @see RTE_MBUF_F_RX_QINQ_STRIPPED, @see RTE_MBUF_F_RX_VLAN, @see RTE_MBU=
F_F_RX_VLAN_STRIPPED<br>
=C2=A0 */<br>
=C2=A0#define RTE_MBUF_F_RX_QINQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1ULL &l=
t;&lt; 20)<br>
<br>
--<br>
2.48.1<br>
<br>
</blockquote></div>

--0000000000002a4f42064306213c--
