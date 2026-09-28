Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E24BCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 14:15:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4234E402F0;
	Mon, 28 Sep 2026 16:15:51 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id C8DBF402A4;
 Mon, 28 Sep 2026 16:15:50 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 1F528EC00CC;
 Mon, 28 Sep 2026 10:15:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 10:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790604950;
 x=1790691350; bh=Pv6X7L2VrsVeRviTqpBw+8yl3UuPWanAimgc2SBLLqg=; b=
 HbP97g5POByAH3659QOgALVi84Hrqrj+HMUipiturJu995AJzAB858dgTFgDWaXL
 5GQ9yloXe6VzvVU11cOfhWQ6Hqux4zBnAjcUxb79S4ATVI71zgqBfX1nhZUUni5g
 PSNJn1ctAv2Mw8UML2LOSSf2rKubV91S7OPvS8BuqfbskbYBwZPd3j+/0jUAirYu
 3ae8V8eAuOQMb+3e7mEUbAEKjaPRbB5EzNjMpyP27Hn1liK2HztjEOQ3447pPlel
 xRSVuzUX8erEnI2A36TI/3sV+DBdLdM0oLI/JUsRH5pkIMayeTpWTHIjIFEf1XOL
 IXnu5yKGZmYC91GUEpDAGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790604950; x=
 1790691350; bh=Pv6X7L2VrsVeRviTqpBw+8yl3UuPWanAimgc2SBLLqg=; b=M
 IrTpdwcuO31/D7LomCxRBEyAKHyjlJ6nbCd1JmjCzkeBfByS6oHflqx1IviiXOM9
 LgPpWYlMSyF/41mSNN2qzeToD2VU8tF1MeURGlO1Q0QKXtZAMPC5pubUdTSke6/3
 fR4DQqRwzhWyCKp78csYY61YuBdAZex0MIPfF1LWBLMK9SKkandlXQuQXZV2s3gv
 EWBfDgDo73kWfIUAOkDsSrdZTjFcYKKdYLK8eBEPqCO5aXxE/f0zGrXAZ6XS2w4C
 DYEGwnR438TBsBBQnTsE2AYeqiVcPNSGxKY5978nJ8DFqjh66G6UhxnB0E/FWPtw
 CyVwlh2OXlenvMX3fxa1g==
X-ME-Sender: <xms:lXa6ahxnzdHQl_d4C2p8RD-AF9xau5JhiMUspTmzVcis3BcpW7P1ww>
 <xme:lXa6astcfoNDAElR9W1O3hKwAj4UYJnBgVUm3V1XaQYujDvRr6y-f_CK-NhCc_acn
 rs32h57h2cwphNDPPyFeHV0sDcvp5EIishrNp2Nid8saXRcut6nvvQ>
X-ME-Received: <xmr:lXa6au33OqGfBQnUeQWQvd2kbuPH1-eQ94y0ySYjxcHJM0bpdTP98Rqpzvy1UIc8_7ls1harQvHwGMcUotH1Lcpk7g>
X-ME-Proxy-Cause: dmFkZTEuGzXx93ymjHbMpHqbWajw4/LBZR9LlfO4U2IRP57bohYbRNkCbcZp59sZsenONs
 dHn4ZWCEt3Oi3oC0XNfi8Gf3+qxH6lfVdKPM600hEqW4LzZ5kDTqsf2pla8W8tvtUDwglt
 MXh4ivepbNToM1iNPD7axA25dChQobdDBKVL1PyU0Fg++Mt1EuavzLn4wa0GhUNPKfjI5O
 5EPpuCcyFZt9XZg2/TZP5cOkooKNvvI/5SoDnTHQRkE8AB3j5XQIQzLvh7ws3BHm47aCzm
 x3jEyoRRRjnfNj7t6o+yJq+1wUVKyAZh/DFc6bQzTY03tyTZ7ld91TRyngr7dwy8rnivKu
 H1rGFvQ2RJavTfxu6V71FbZcqpzPTzQ/JgIeyWU219t+/J8ITvmtym95U0r2x6K7qnf5YW
 VkPqIPAsG1gblfAsnxWiHmKJW0j975XvRR3tvkJaop2SFFzO4QCK4dwCKJ46WuaJXK05Y2
 ETChLsCYt+rJkZTFaXfmrLh6OgdSJrvYOYld2KG3IbhFAXzmnPurTwqhS/JbC1gOWhFTIO
 f4edHmHzRAN6YpYXMQDCQSg1l55O6vx0RivKlqBfPBnmKAMej6SyKDkJFWU3YdixrCSGJ5
 Yw/fP9XXiq+Vk4nD3SmPT5iiEpStxVy36P8DHr3JGepB2+ulb2Yxv7TPBGew
X-ME-Proxy: <xmx:lXa6an9kg9CvcFpCkIJKfaskJrQRrPsbedMrNF402tnHQOfGmALvyQ>
 <xmx:lXa6avN2Yj6R9UMO-Ywu_NU6xUukKTQnf3jQXkPBgt4EeePfH9D2Vw>
 <xmx:lXa6archcO5g5TlWT0T0viHlusxAdU40CYzuRT-D-fD0WZqkCCNOSA>
 <xmx:lXa6auWB0j-Kz8TW0a_L6XMqJGQAQ5Dn1isvB7QFrrbe6aw_GweTLg>
 <xmx:lna6an26kpZPBkCtHvN61miGb8emV1utLAAggW6CFVtWltxGdjYiaBD_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 10:15:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stable@dpdk.org, Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] net: revert add IPv6 traffic class and flow label fields
Date: Mon, 28 Sep 2026 16:15:26 +0200
Message-ID: <endP4k7ET0iyFdUNMs3orQ@monjalon.net>
In-Reply-To: <20260922111408.3b2c7bcf@phoenix.local>
References: <20260922163640.1144749-1-mb@smartsharesystems.com>
 <20260922111408.3b2c7bcf@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hello, are we waiting for a v2?


22/09/2026 20:14, Stephen Hemminger:
> On Tue, 22 Sep 2026 16:36:40 +0000
> Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
>=20
> > IPv6 header when the field crosses a byte border.
> >=20
> > Let's consider a simplified struct for illustration:
> >=20
> > struct example {
> > 	union {
> > 		rte_be32_t vtc_flow;
> > 		struct {
> > 			uint32_t version:4;
> > 			uint32_t ds:6;
> > 			uint32_t after:22;
> > 			uint32_t after:22;
> > 			uint32_t ds:6;
> > 			uint32_t version:4;
> > 		};
> > 	};
> > };
> >=20
> > struct example e;
> > e.vtc_flow =3D 0x00000000;
> > e.ds =3D 0x3F; // binary: 111111
> >=20
> > With big endian:
> > Value of e: 0000 111111 0000000000000000000000 =3D 0F C0 00 00
> > Memory at e's location: 0F C0 00 00
> > As expected!
> >=20
> > With little endian:
> > Memory at e's location: 00 00 C0 0F
> > The reason being that the bytes are filled with bits starting with the
> > LSB, so when crossing a byte border, the "ds" field doesn't continue at
> > the following bits, i.e. the MSB of the next byte, but at the four LSB
> > of the next byte.
> >=20
> > This wrapping cannot even be fixed by having separate, dedicated structs
> > for each field (with each their own "before" and "after" filler fields)
> > in the vtc_flow union.
> >=20
> > There is a GCC attribute to fix this, but nothing similar is offered by
> > Clang or MSVC:
> > __attribute__((scalar_storage_order("big-endian")))
> >=20
> > Bugzilla ID: 1679
> > Fixes: cba27998dc81 ("net: add IPv6 traffic class and flow label fields=
")
> > Cc: stable@dpdk.org
> >=20
> > Reported-by: Maxime Leroy <maxime@leroys.fr>
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > ---
>=20
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
>=20
> Long form AI review. This may need addressing before merge.
>=20
> The revert is correct and complete. cba27998dc81 only touched
> rte_ip6.h, there are no in-tree users of the removed fields, and the
> struct layout is unchanged so there is no ABI impact.
>=20
> Keeping Cc: stable is right. The fields shipped in 24.11 and 25.11
> but access the wrong bits on every little endian target, so any
> direct user is already broken and a build failure is the better
> outcome. Please add a note for the stable release notes pointing to
> vtc_flow and the RTE_IPV6_HDR_*_MASK macros. Code that byte swaps
> vtc_flow in place before using the fields does work on little endian
> today and will stop compiling.
>=20
> The commit message needs rework before this goes in.
>=20
> The example struct does not compile: after, ds and version are each
> declared twice with no #if between the two orderings. Since it is
> the justification for the revert, either fix it or drop it and show
> the actual result.
>=20
> The root cause is understated. It is not only ds crossing a byte
> boundary; every field is wrong on little endian, including version.
> A uint32_t bitfield is allocated against the host order value of
> the word, while vtc_flow holds network order. The little endian
> layout is only correct after byte swapping vtc_flow.
>=20
> On x86_64 with the removed layout:
>=20
>   header bytes 6b 91 23 45 (ver 6, DSCP EF, ECT(1), fl 0x12345)
>     -> version=3D4 ds=3D0x14 ecn=3D2 flow_label=3D0x3916b
>   version =3D 6  -> bytes 00 00 00 60
>   ds =3D 0x3f    -> bytes 00 00 c0 0f
>=20
> Suggested wording:
>=20
>   On little endian, a 32-bit bitfield is allocated from the least
>   significant bit of the host order word, but vtc_flow is stored in
>   network order. All four fields therefore read and write the wrong
>   bits. For example, setting version to 6 writes 0x60 into the last
>   byte of the word.
>=20
>   ds and flow_label are not contiguous in memory on little endian,
>   so no reordering of bitfields can express them.
>=20
> For reference, neither Linux nor FreeBSD tries this. Linux uses a u8
> bitfield only for version and the upper nibble of traffic class,
> then flow_lbl[3], with big endian masks (IPV6_FLOWINFO_MASK,
> IPV6_FLOWLABEL_MASK) for the rest. FreeBSD has no bitfields: a raw
> ip6_flow word, the ip6_vfc byte for version, and per byte order
> masks. DPDK already has the equivalent in rte_ipv6_check_version()
> and RTE_IPV6_HDR_*_MASK, so nothing is lost.
>=20
> Release note: "defect bitfields" reads oddly and gives no migration
> path. Suggest:
>=20
>   * net: Removed ``version``, ``ds``, ``ecn`` and ``flow_label``
>     bitfields from ``struct rte_ipv6_hdr``. They accessed the wrong
>     bits on little endian. Use ``vtc_flow`` with the
>     ``RTE_IPV6_HDR_*_MASK`` and ``RTE_IPV6_HDR_*_SHIFT`` macros.
>=20
> Minor: "Reverted the patch introducing them." should be imperative,
> "Revert the patch that introduced them."




