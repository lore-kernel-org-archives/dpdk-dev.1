Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D189CCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:06:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91A124026D;
	Sat,  9 May 2026 13:06:53 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id EAFA540269;
 Sat,  9 May 2026 13:06:49 +0200 (CEST)
X-QQ-mid: Yeas9t1778324801t828t18730
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.204.251.157])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 12363965412987554375
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260429102515.58880-1-zaiyuwang@trustnetic.com>	<20260429102515.58880-12-zaiyuwang@trustnetic.com>
 <20260429081136.3defdeba@phoenix.local>
In-Reply-To: <20260429081136.3defdeba@phoenix.local>
Subject: RE: [PATCH v2 11/20] net/txgbe: fix traffic class priority
 configuration
Date: Sat, 9 May 2026 19:06:40 +0800
Message-ID: <000e01dcdfa3$e9b30880$bd191980$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwHnyBxIArpVolwBjXDnqrUnlckg
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N3IC8um5pMyYsQfPMPilZTMH1ARGE7tkjkB+yutZBiuGd6Z7ZtW2TWeH
 kuV9u/3NoKejnmTmDqPiMbrph264SEFMlsHNOssn2gYBPYqJy0PW3YQhayQnQxDelJWHSLY
 TWnKrSUBJifRijwN01gNzXJZVlwhJALzBIDqeJGVBgk0IXR34JTUs1B59OvMbFhaUKWd6yd
 Az4qXyiwBLU++1zsNW8mM80SvgQOBN3KXurIuMtlEKGjUFNd4Xc0T/8T5JQxxQ5vDUZqf42
 lSoKneiMzlW+0NcXNnzrNOOy916XHJ+TJ/TcdJjBfn2zihrIm8gl5+iF5aywuFQLwIavIxZ
 AM15Xv7MtuMeWRXv5j8lIh3XYJCtBw8PFK4ls8lz1TuAP56wIvNQjqkKDrS8eecNnS8z+5w
 5SNyJhQ3ynHkj3GiQbJnhSkNs2f+I7HyR5NOlMsNZk85TlFSj4jd1Ffyyoz9rT3CW8YfX86
 PpqADfeaWtfAepxr34h+V/pdONLic2h68BDURn7D9NH9OcrO5TWDZRNQK+EjfcCUrxWvNbt
 PP1gynyhKbLac0MuADb72+0slT0/RYVJu798w4PeUraC2/TMBmdLAgDyhwn5D0eXS1vnfQ2
 hffcrTfXs7N9d/uhC1glUHAKM5hbRHFXQDCZEVNYl0ddQwM9VVri3onnfCwoNz/iUUcK4WP
 h3ffi1gIdVp63otaK+3L5K+oiPNnzeWOIozyevSTABDy/YmiSoR4hZ+EhqqEE40or6P0CNH
 g45Tp8oZmTFyDp4vUN9E57nQ7GVEx8irnsk9bPy6bPBuFkEV8RpOO85BZlB6fu6a/dBcks7
 03JP93vQwIgVmjKSnhFZo0gT/tc0mEvP7747hH2ejH23DHu7qGRDs/59LHvdEKFCbNgVE3V
 7zV7rIk/MlHFf2eHeTOPjca+SV0UKSRxmRq/CRcD2retVNX4BSE0hl41fIlnTj5M7cL3bRe
 bjje003YnbbQONtt/8IFuwVIFnVzX8YK2ThoD42zPU9BGECHzER//blm/tq7gi3o9z9q1DL
 dfztFWdQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, April 29, 2026 11:12 PM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang
> <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Jiawen Wu =
<jiawenwu@trustnetic.com>;
> Ferruh Yigit <ferruh.yigit@amd.com>; dev@dpdk.org; stable@dpdk.org; =
Jiawen
> Wu <jiawenwu@trustnetic.com>; Ferruh Yigit <ferruh.yigit@amd.com>
> Subject: Re: [PATCH v2 11/20] net/txgbe: fix traffic class priority =
configuration
>=20
> On Wed, 29 Apr 2026 18:25:05 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
>=20
> > After applying the following testpmd command, 802.1Q packets with
> > specific priorities were not properly directed to the corresponding =
traffic classes:
> >     port config 0 dcb vt off 4 pfc off
> >
> > The old driver had two issues:
> > 1. The hardware uses a 4-bit mapping register per traffic class for
> >    priority-to-TC mapping, but the driver incorrectly configured it
> >    as 3 bits.
> > 2. The DCB TX configuration mistakenly wrote to the RX register.
> >
> > Fix both issues, ensuring that tc-prio mapping works as expected.
> >
> > Fixes: 8bdc7882f376 ("net/txgbe: support DCB")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> > ---
>=20
> AI review spotted issues:
>=20
> Error: The fix is incomplete. The same priority-to-TC layout is also =
written in
> drivers/net/txgbe/txgbe_rxtx.c around line 3380 in =
txgbe_vmdq_dcb_configure():
> for (i =3D 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
> 	/*
> 	 * mapping is done with 3 bits per priority,
> 	 * so shift by i*3 each time
> 	 */
> 	queue_mapping |=3D ((cfg->dcb_tc[i] & 0x07) << (i * 3));
>=20
> wr32(hw, TXGBE_RPUP2TC, queue_mapping);
> This writes the same TXGBE_RPUP2TC register (0x019008) the patch is =
fixing,
> using a hardcoded i*3 shift and a comment claiming 3 bits per =
priority. After this
> patch, txgbe_dcb_config_rx_arbiter_raptor() encodes priorities at =
4-bit positions
> (via the updated TXGBE_RPUP2TC_UP_SHIFT=3D4), but =
txgbe_vmdq_dcb_configure()
> still uses 3-bit positions. The VMDQ+DCB path will produce a wrong =
tc-prio
> mapping. txgbe_vmdq_dcb_configure() needs the same fix (use
> TXGBE_RPUP2TC_UP_SHIFT and update the comment).
> Warning: TXGBE_DCBUP2TC_DEC and TXGBE_DCBUP2TC_MAP are now
> inconsistent. After this patch:
> #define TXGBE_DCBUP2TC_MAP(tc, v)     LS(v, 4 * (tc), 0x7)
> #define TXGBE_DCBUP2TC_DEC(tc, r)     RS(r, 3 * (tc), 0x7)
> DEC will not decode what MAP encoded for any tc > 0. =
TXGBE_DCBUP2TC_DEC
> isn't currently used in tree, so this is not a runtime bug, but it's a =
latent trap. Either
> update DEC to also use 4*(tc), or remove DEC since it has no callers.
>=20
Hi Stephen,
Thank you for the thorough AI=E2=80=91assisted review. I really =
appreciate it.
I have addressed all the issues you raised, and an updated patch set =
will be sent shortly.

