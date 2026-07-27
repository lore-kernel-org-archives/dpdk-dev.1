Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF56EC53219
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 08:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF9B6402E4;
	Mon, 27 Jul 2026 10:04:35 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 95A23402E4
 for <dev@dpdk.org>; Mon, 27 Jul 2026 10:04:34 +0200 (CEST)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-81e9f7491ffso29168007b3.0
 for <dev@dpdk.org>; Mon, 27 Jul 2026 01:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785139474; cv=none;
 d=google.com; s=arc-20260327;
 b=TNjWa9+vp3oo6xYb8WhliF4t/we1ZnNOXUG/3Oo+J9ERA3Biw4BciQBXEW88/T+RL8
 bcXlWQ6qhUgyHOteQD8FP9KApEp5fXnmDgFuKMKV8lKzU7UTzNB1EQlzXdZ35tOlzIXy
 zhW1P5ksDE3HnHQhj+vs78RdNeWfcoZHCGG+Mg94/Q4z+DSGq/h0DVTZ+g8hUqIv0/rm
 84JnyFzE6HDQ7RP1veB4TE6nQneGOxL+AkXe10yAx3SUMS8jJHfGjIF0SzdB1Af+xjnq
 Ci5vLFxZsAkN4KDkG2kfeff/BYAF/mS4S22yTwj1VU5qlsxNOGA2OGpmmEC6KDoP5MNt
 gKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=AFyW+4Hssdnfx2ZU6PRxvnDl6piGiH8RHb0DCR/TuD8=;
 fh=Eu2Lpgy2L18dTAZD7cWRW/ZEK2yU8zRT3rkC873nSXQ=;
 b=szfyKtdEK7lOa1Ok85KzlgtVmeXrABtxAGVStyfTNBvEbzJuSthfx3OKFFjRqzE0if
 phukv17PzoRnadFYwI3G+Exr5Qya6dx/KHXMFn8vtLzbUA7DZutGVcxUB8lR9OphR8Ub
 hiD7k3+uYVMIaHfxBq7HwZpL8v59bqMHlScXxvI9sr80QHx02cn032avxD6u8xZzp5Da
 T4EKIezcnRg5W/vBWhF8AgUp823yP1WanuqpsVKYRmBVhfaGXmZX3ImXAm2C9TrQ5nYn
 j2NaDNdTtEwbHMuhDN3aJdj7TaNtTVh3MRwuwBNlMqyrDC5N9ZKKWudHCm86GL497wZ8
 kMOA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785139474; x=1785744274;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AFyW+4Hssdnfx2ZU6PRxvnDl6piGiH8RHb0DCR/TuD8=;
 b=eJEbREFXXRFPcBpozSxSketNtRe4YGXJpnQUPv9umHAZCgr8rpO45IsX4hIlgC8ziG
 7YChX3jIYmIMwoBOMNCmDhf3ddxV3V//7dl2RGiZkvlynQ6ABEGi+ZxZX/dehTTg+fBq
 md1mO/xQzP5LVf5GCB9l7fomnIpAvd7C+MwWKQYsqMZy1fQjxAi/tJmR9ltVGaJ5cjc0
 D0RGQch4xebzw1u02LsKmu+Vbrh72gGTNzJ14x9n96CKCf37k4WxTWEkZ2iMKvOKUVee
 hMdftdrU6oRH81m439ABFsR9GtSjulUEBWUSt4IFwlKFYx/tvDDhZxm4TNPKXrBCWObE
 haNw==
X-Gm-Message-State: AOJu0YwTq2rbXxi4H+szXZlMQeEM8XVnHAIW/lXmN74CBkfr513lkcNu
 9u65oWfCf4aNZ+4+CaxJfKaxJu+O/sAMKCzuT/tscowZ7x+YopDrGROyHRyxkm54ibOTKWm1nea
 Euekn36fzVxQC2evHCyAz0Oxj5DrDoZ4=
X-Gm-Gg: AR+sD10P8m9wOEIyjnXzogi8LdN04BAurL7V6QrPgjeirqLg4Az7myoAVift/+hMy1b
 WU/nPISwhfv2ymYhgS1JAppuJjXtZqXQNB1HMXWymudGyURNG96GgIrJq5Shaq5qGZ25NLHNNZ7
 LK2kl0G51vXsztgAG2FkkgNOAi7bZuGKj+W0dYmIDZR6ZProvIiFmjGngcKA66/x3zvf91C+8JJ
 WFbnklbtuVzfRFAvSLAYWDsMVO7VSL6BH0GkbzX9pI59etg8SiRPDfy+mFtM6OMvSJmlA==
X-Received: by 2002:a05:690c:305:b0:81e:b825:24e5 with SMTP id
 00721157ae682-81f69e2ecb8mr26996267b3.47.1785139473850; Mon, 27 Jul 2026
 01:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260720133436.869334-1-maxime@leroys.fr>
 <20260723093540.1839619-1-maxime@leroys.fr>
 <20260726093700.39e9b9ab@phoenix.local>
In-Reply-To: <20260726093700.39e9b9ab@phoenix.local>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 27 Jul 2026 10:04:22 +0200
X-Gm-Features: AUfX_mzAkQjGPikq4PiScyfYPv7jmRiHBfYMNmpeYcnPXSIICX4AqIW2TE0K0Qw
Message-ID: <CAHHRULXPPNUngvOoU396C0Z0-vch5LLv+M9yDux-JZDLQvirJQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/dpaa2: hash inner IP for tunnelled traffic
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jul 26, 2026 at 6:37=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 23 Jul 2026 11:35:40 +0200
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > The RSS key only extracted the outer IP header. Tunnelled traffic whose
> > outer headers are fixed then carries no entropy for the hash, so every
> > flow lands on a single Rx queue.
> >
> > Extract both the outer IP (header index 0) and the innermost IP
> > instance (HDR_INDEX_LAST). Plain frames keep being hashed on their only
> > IP header; the inner extract resolves to nothing and adds no entropy.
> > Tunnelled frames are also hashed on their inner IP and spread across th=
e
> > Rx queues.
> >
> > This is the PMD default hash: dpaa2 does not expose the ethdev RSS leve=
l
> > selector, so it applies to every RSS request. The hardware cannot hash
> > the inner IP alone, as HDR_INDEX_LAST only resolves when several IP
> > headers are stacked and a plain frame would hash to a constant. Folding
> > the outer IP into the key is therefore unavoidable, and two tunnelled
> > flows that share an inner IP but differ in their outer IP may hash to
> > different queues. This is documented in the dpaa2 guide.
> >
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > ---
>
> More detailed AI review
>
> Warning: RSS key size likely exceeds the DPNI key limit
>
> drivers/net/dpaa2/base/dpaa2_hw_dpni.c
>
> Doubling the IP extracts doubles the generated key, not just the
> extract count.  The driver's own accounting treats a NET_PROT_IP
> full-field address extract as 16 bytes (NH_FLD_IPV6_ADDR_SIZE, see
> dpaa2_flow_add_ipaddr_extract_rule() in dpaa2_flow.c), so:
>
>     before:  16 + 16 + 1                =3D 33 bytes  (+4 with L4 =3D 37)
>     after:   2 * (16 + 16 + 1)          =3D 66 bytes  (+4 with L4 =3D 70)
>
> DPNI_MAX_KEY_SIZE is 56, and dpni_attr.fs_key_size is documented as
> "Size, in bytes, of the flow steering look-up key.  Defining a key
> larger than this when composing the hash + FS key will result in an
> error."  The PMD never reads fs_key_size and there is no size check
> anywhere on this path, so the first sign of trouble would be
> dpni_set_rx_hash_dist() failing and rte_eth_dev_configure() returning
> an error for a plain RTE_ETH_RSS_IP request that works today.
>
> Has this been tested on hardware with RTE_ETH_RSS_IP (and IP|TCP|UDP)?

It has, on LX2160A, and with exactly those two requests. testpmd --rss-ip
sets rss_hf to RTE_ETH_RSS_IP and testpmd --rss-udp sets it to
RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP, which compose six and eight extracts,
that is your 66 bytes and 70 bytes.

Our forwarding application goes further, requesting

 rss_hf =3D RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP |
          RTE_ETH_RSS_TCP

which composes nine extracts: one VLAN TCI, six IP (source, destination
and protocol, at index 0 and at HDR_INDEX_LAST) and two L4 ports, so 72
bytes with the 16 bytes per address you count, against 39 bytes before the
patch.

In all three cases dpni_set_rx_hash_dist() accepts the key and
rte_eth_dev_configure() succeeds.

Distribution was then checked per traffic type: plain IPv4, plain IPv6,
VLAN tagged frames and IPv6 tunnelled traffic all spread across the Rx
queues, the last one on its inner IP, which is the point of the patch.

So 56 does not bound this path. DPNI_MAX_KEY_SIZE and fs_key_size bound
the flow steering look-up key, that is the key which is stored in, and
compared against, the FS and QoS table entries. Its size is explicit in
the API (dpni_rule_cfg carries key_iova, mask_iova and key_size), and it
is the size dpaa2_flow.c accounts and checks: that is the path your 16
bytes figure comes from.

The hash distribution path installs no table entry and stores no key.
dpni_rx_dist_cfg has no key_size field at all, only dist_size and
key_cfg_iova, i.e. the key composition; the composed bytes are only fed
to the hash function which yields the queue index. The two budgets are
not the same.

For the extract count, the flib bound is DPKG_MAX_NUM_OF_EXTRACTS =3D 20,
and it is the only limit the driver checks, in dpkg_prepare_key_cfg().
The worst case, requesting every type the PMD advertises (ETH, PPPOE,
ESP, AH, VLAN, MPLS, IP and L4), is 16 extracts with this patch. It is 13
without it, and it was 15 in the code that shipped until the June cleanup
folded the SCTP ports into the L4 case (4b200f10de27).

> If MC accepts it, please say so in the commit message, because the
> arithmetic says it should not.  If the limit is real, the extract set
> needs to shrink -- dropping NH_FLD_IP_PROTO, or extracting only the
> inner address pair, would be candidates.
>
> Warning: the "inner extract resolves to nothing" claim needs backing
>
> Both the commit message and the new comment assert that on a plain
> frame the HDR_INDEX_LAST extract resolves to nothing and contributes no
> entropy.  The MC header documents hdr_index as "used for protocols that
> may have more than a single header, 0 indicates an outer header" with
> NET_PROT_IP taking (0, HDR_INDEX_LAST).  The natural reading is that
> for a single-IP frame the last header *is* the outer one, so index 0
> and HDR_INDEX_LAST select the same header and the fields are extracted
> twice.

That reading is excluded by measurement on LX2160A, with testpmd.

It is in fact the regression patch 1 of this series reverts. The reverted
commit programmed the IP extracts *only* at HDR_INDEX_LAST. Had
HDR_INDEX_LAST selected the outer header of a frame carrying a single IP
header, plain traffic would have kept hashing on that header and there
would have been nothing to fix. What we measured instead was every plain
frame getting the same hash and landing on one Rx queue, while tunnelled
traffic spread correctly on its inner IP. Patch 1 states this and carries
Hemant's ack.

Reading the driver leads to the same conclusion, though I can only offer
it as a reading. fsl_dpkg.h defines hdr_index for VLAN, MPLS and IP only,
and for those three the Rx annotation exposes one flag set per header
instance: L3_IPV4_1_PRESENT against L3_IPV4_N_PRESENT and so on in
base/dpaa2_hw_dpni_annot.h, the matching offset accessor being named
IP_N_OR_MIN_ENCAP_OFFSET(). Index 0 would then select the "1" instance
and HDR_INDEX_LAST the "N" one, and a frame with a single IP header has no
"N" instance for the extract to resolve to. Whatever the key generator
places in the key for such an extract, it is the same for every plain
frame, which is what the measurement shows: no entropy, and no second
extraction of the outer header.

> That is harmless for distribution but it is not what the patch
> says, and it changes the key size and hash values for every existing
> non-tunnelled user.
>
> Please confirm the actual behaviour with NXP and describe it
> accurately, one way or the other.  This also feeds directly into the
> key-size question above.
>
> Info: duplicate constant
>
> +#define DPAA2_DIST_HDR_INDEX_LAST 0xff
>
> mc/fsl_net.h already carries LAST_HDR_INDEX (0xFFFFFFFF), truncated to
> 0xff by the uint8_t hdr_index field.  Two differently-named constants
> for the same hardware encoding in one driver is confusing.  Either
> reuse the existing one with an explicit cast, or add a comment saying
> this is LAST_HDR_INDEX narrowed to the 8-bit command field.
>
> Info: placement
>
> The #define sits between two function definitions.  Move it up with the
> other file-scope definitions, or into dpaa2_ethdev.h next to the
> related driver constants.

Agreed on both. v3 derives the constant from LAST_HDR_INDEX, cast to the
8-bit field it feeds, and moves it up with the other file scope
definitions:

 /* LAST_HDR_INDEX narrowed to the 8-bit dpkg hdr_index field */
 #define DPAA2_DIST_HDR_INDEX_LAST ((uint8_t)LAST_HDR_INDEX)

-------------------------------
Maxime Leroy
maxime@leroys.fr
