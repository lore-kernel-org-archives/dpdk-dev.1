Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84105CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 10:58:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 543F24021F;
	Thu, 28 May 2026 12:58:16 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 62EBA4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 12:58:15 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id A2FC3EC01CC;
 Thu, 28 May 2026 06:58:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Thu, 28 May 2026 06:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779965894;
 x=1780052294; bh=zvk+3/yRCQ6E54DknTSiKtR0qlLbCcZ5S/G1S9iJjP8=; b=
 EGAduBl1Lg3VP8Af2Kj6DdCiDtNO+BTuUu/S1ITj7ezoFH1Bx3meWjizl1B7frA/
 lb859ucP76zOlnVahPaeuoybNYOSWubKx3IV/mfHguCrzoVNSu0jaKqgR700xSOu
 ejKj+W+k3x46MrfCc06HU+aVgtSUr8ildAKiXjMBEKF8zuUJEqOuFVrrRWfE6Pb1
 8YNG74wRMxqItDMjtq/HlwLe4YRNCnpbKEBWi+JUSV0PgDcn/ndQNzRQolInyNGI
 A00kutxA5H4B230FM+d5dG2DPLEr9CRDfAxrjUT5hpc2Xr9qIZeV71sE1yDnCHBI
 6vQmuI8iQvfnXOwrSDFsSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779965894; x=
 1780052294; bh=zvk+3/yRCQ6E54DknTSiKtR0qlLbCcZ5S/G1S9iJjP8=; b=F
 zWzV2CEkicit7zUUuumQ/1OgEnSdLht0kUMSdMiKmd/KuDRA3BEOyrer+6n+f8De
 n5v0p9QotMsnSMJnV08BID5U7Rs1flqFOtln+d9xfHrXT1PsPsRP2nTJgogc55Ps
 X+zzKVlGewSnaWOLWIHdTCgPdJKF9V5eVXj+hHbZxLgELzyEbjwz+Snm89tFMrpE
 2nBNPJLmx3Dhw/Z7bUuDpOudAOfL6phULNCPyarklciyI5KhBCTnjpZaDtEZVE7D
 pg9GUc+ORhtoeueY5H6rDpC5++hRy4CH1Rhx2IETSPs8jZzmlm9AkWLopEOV9uTs
 L2PGMz4Z+TrxvASEErV+A==
X-ME-Sender: <xms:xh8YapHDL5IjHPzx_-JCCkVKbGeFIKw--Uv32zNQhBdIX_oF35pscg>
 <xme:xh8Yaip2Ts2AIlLvHufkxDhKhkEKeMQpJJJBaaIkOJljzrGpo1MSP54AQfrwDNAa2
 87suxC00i57ENOGLq3b48KfEz41dmKBJmKi6hz37Tqgo0u-5erJvA>
X-ME-Received: <xmr:xh8YaqS-3h4Yg--Qc7F8VKeVRiyBh4uN3pPsGNeu7oJb1Sh12LXso-14PwLJIphqaNa_n_To6EYj8y_qmo9wZeVgPA>
X-ME-Proxy-Cause: dmFkZTFkiOMDZEFnJVP9A9L0qwETt6Qa6dLUbFsjdibgKa/+Ujwwoo6KbmlT9nxKk8CZo2
 vWfGKV+xNrBPT/rXjJQrEWP3wMSK4J4lLbX5eVmyzJvX/dIvf94IvuAYk7vuLLPdGp7205
 9bz8QdMSlcu1nzmqxnswba9WrIRcr7jAY1G5QDqUXmL4BFLF/sz/VaqKBvwFM8iimRGkC2
 7WrDer/8mVtbyNFT2PNKH5ZT9wp4gOwzb+CO5pdh0TBr0w7PJMFfZfsb1+BZiQjylO0P3X
 th+Ir7KxJSRBt/bdiPXPUXE5N5reeSHR47QjCiXo21KpcMMXdyfadf/Nfm1X0nQ3U80pmh
 rhLy0vv4yVigG4kPvI6xb25c3/c05yxfABfe8qUgOBr2jvebRaWf4ogMYyoVtupDM+bbbQ
 t4G/e04Mmv72GvRZQm5/fLcuLeiHcv02mLJow6EztKG7iZoGD9TciZc3VcirMQl6eZ+L9o
 0wCtVY35pI03WZlg5TVyrox4x9S+qtCqwDdiZCtNKSveB6FDGBFI//Hkzwnfay6MU9mEzW
 YdUnj59WeeQB/YRyHcDxAcpuUegw3e4YrSrDnwCCIiq1LOCZ0cM6tZvMDdiK8BZUW1WLeO
 9uRLA11FBmTAAZ/a//UuKIsE8Hyc8peH8xDDdfLr94yMzwFOw4i5sChB66Nw
X-ME-Proxy: <xmx:xh8YanN7IO0PLyG8MI77OqDJ0bmxEccRxGHMBnd_rzKVbZinZHbIdQ>
 <xmx:xh8YalPqP-KA5ofqCFGyo0bhtWaUPKWvfZ83D9l8B68dNDhYVgsuTg>
 <xmx:xh8YavvaC6mbQYwhZsEfHVyet2qEPNU-K_wZ_7R5G6pKAjJlpNG50w>
 <xmx:xh8YanU6j5QBDX2RgX9ogMNOgsUSV2PNJC54oIfaxZeBltwrLZIM4g>
 <xmx:xh8YasTuVH93luVST9IzWTZlrPMJrXjEiaVdLvNMwCx7VEgOWI-pz9yj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 06:58:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Jie Liu <liujie5@linkdatatechnology.com>
Subject: Re: [PATCH] net/sxe2: fix 32-bit SSE build
Date: Thu, 28 May 2026 12:58:11 +0200
Message-ID: <-b1vJiPdTrqtGy9X39oH8Q@monjalon.net>
In-Reply-To: <CAJFAV8xY0uM=RbcR64ZMc-eOTVkzZc0PFTCBCaQkNNE7uuvZeg@mail.gmail.com>
References: <20260528084717.1754057-1-thomas@monjalon.net>
 <CAJFAV8xY0uM=RbcR64ZMc-eOTVkzZc0PFTCBCaQkNNE7uuvZeg@mail.gmail.com>
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

28/05/2026 11:47, David Marchand:
> On Thu, 28 May 2026 at 10:47, Thomas Monjalon <thomas@monjalon.net> wrote:
> >
> > Seen in OBS on i586 Debian:
> >
> > from ../drivers/net/sxe2/sxe2_txrx_vec_sse.c:5:
> >         In function =E2=80=98_mm_loadu_si128=E2=80=99,
> >                 inlined from =E2=80=98rte_memcpy=E2=80=99
> >                 inlined from =E2=80=98sxe2_rx_pkts_refactor=E2=80=99
> >                         at ../drivers/net/sxe2/sxe2_txrx_vec_common.h:2=
33:2:
> >         /usr/lib/gcc/i686-linux-gnu/12/include/emmintrin.h:703:10: erro=
r:
> >         array subscript 8 is outside array bounds of =E2=80=98struct rt=
e_mbuf *[32]=E2=80=99
> >
> > The important options to reproduce are "-m32 -O2 -march=3Dcorei7".
> >
> > In 32-bit build the pointer array done_pkts[32] is smaller:
> >         32 * 4 =3D 128 bytes
> > so an SSE access  would be outside the bound.
> >
> > The libc memcpy does not trigger such warning
> > and is a good choice to copy an array of pointers.
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
>=20
> I reproduced and checked Debian 13 32 bits build with OBS.
> Tested-by: David Marchand <david.marchand@redhat.com>

Thanks for testing.

I forgot this:

=46ixes: 885647d31504 ("net/sxe2: fix 32-bit SSE build")



