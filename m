Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BCF10F92E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 16:38:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1A88406FF;
	Tue, 31 Mar 2026 18:38:26 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 31ED640615
 for <dev@dpdk.org>; Tue, 31 Mar 2026 18:38:25 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0D5057A0178;
 Tue, 31 Mar 2026 12:38:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 12:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774975103;
 x=1775061503; bh=ps7Aq5MrY5dkZIMgpcBm7yAuvo4KgLHqBq+A5pNXwiE=; b=
 PLCMA0te/dRjPrFI5q5qhHOLuLEPIerS1iMbHBDJ2npgDv9aApNyaNuheGutnLsX
 4svdMf0RpBT2e/M00p2I589AYG1u+ZbMJ2BxV/4rGKCgSQZ7GsFnGPMltoIVX9rj
 swNLP/F+BBAppYocoRqkHnAi9rrYMjn2iYomR6XVBawkDYn7E3ouqbi4CLC+At8U
 QyLX79hCx5RYRIJQkhKPUhBQc/imJEVPyRi99dMVkxyLbAQFJvpExOjmKQNvC5K7
 51Dz3HeylhKo70jwK787xbghFUxcJ8h5kp/pPuXTWqktJot+eNKovwvwqZ6jVowZ
 o3hk+QN4S8PcmDscpbf1Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774975103; x=
 1775061503; bh=ps7Aq5MrY5dkZIMgpcBm7yAuvo4KgLHqBq+A5pNXwiE=; b=b
 znyKQVoE/XJqTFjGwdFB1SH4reKp5qpT08G9cqpzJa2kxSD9HxsmgahJr5ga4AUf
 qRgw+KzxdijGrjmy8PkZeHu4ouaV6K/yaQuLIF7QG3ZpAKlh1ibYzRcXesmbhMKs
 bgf6ZA2QUR6ep4LHF3ArODOw/++NGGMYNNy+w4xFPmuiqJQEuZBgiKPhQfZwhM8a
 V5C1VO1sKfWZy04jFLWQulqf5enAWz9a0BgajBwKzleO2yETWKpf9udxtRMMA031
 nXrlld09ZlU/DCDyHF/crQiSjjpPndZf0WLuiuhd64tGO55+ZTnuzFeGhOWsDrfJ
 cnkmoADp6LFQhE+oLmbmQ==
X-ME-Sender: <xms:f_jLabBdvDfRPMEpQjsbdBO0xuIq9W045sZ0vXvHC858Mpi8LkaXyw>
 <xme:f_jLaY_7cafQrf36D9LoDCLNbwvdX8xrasxJTu-98SSxgRX_CKeKjWq8A61ODTO-U
 ZlcekUPj-LEMv0Hy0tMJ8dSVhBjcPU-2tf8OwlKVqmeN8DVUM-N>
X-ME-Received: <xmr:f_jLaT-e3NH0H2cN774AzsiXcbxLlHm6A3nmpZ7d6vbzwzKUVstjPg6Wsjh5IgyLZlw0vc7WL0u-DFwIJQ90YFsXsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdelveej
 ueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepphhrohgssgesihholhdruhhnhhdrvgguuhdprh
 gtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehluhgtrgdrvhhiiiii
 rghrrhhosegrrhhmrdgtohhm
X-ME-Proxy: <xmx:f_jLaXd--v0pXZ2hMc0RgdHJp-B1MnGP2ubIxOa6wpXGWWj1j_YdGA>
 <xmx:f_jLaUE-XGOpOyP4IjvhqwHyRr4_mpUB5ZVSP7dT6ZJFL7UquPvnfA>
 <xmx:f_jLaddosvosMt5rU2JHvkXZn9hKVBzttQiJuluOVTc7q4iCtFhm0w>
 <xmx:f_jLaWHXLo7ItpzduVyZ1ejhrtrXIHRrFqOsufNcm4q-KmNVjBxDUA>
 <xmx:f_jLaXqWE-ICsQfHHPvgO9mw3N-Om0QHQNUYIDsVJ1w-OzUrgpMwU3fD>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:38:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>
Subject: Re: [PATCH] dts: fix Sphinx parsing of a docstring
Date: Tue, 31 Mar 2026 18:38:21 +0200
Message-ID: <3433059.aeNJFYEL58@thomas>
In-Reply-To: <CAJvnSUACPMwpZr+QEYp=rj3gvQwg4=6Y=1AHmsjVDgiLLJ1_uQ@mail.gmail.com>
References: <20260331161253.462180-1-thomas@monjalon.net>
 <CAJvnSUACPMwpZr+QEYp=rj3gvQwg4=6Y=1AHmsjVDgiLLJ1_uQ@mail.gmail.com>
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

It was working for me as well until I update my distro...


31/03/2026 18:13, Patrick Robb:
> Thanks Thomas for fixing this.
>=20
> I had done a manual doc build (and checked the doc builds from CI) before
> merging patches to next-dts, so I suppose my Sphinx version must be less
> than 9.1.0. I can check this when I do my next doc build.
>=20
> On Tue, Mar 31, 2026 at 12:13=E2=80=AFPM Thomas Monjalon <thomas@monjalon=
=2Enet>
> wrote:
>=20
> > With Sphinx 9.1.0, the word "ports" is wrongly parsed as a reference,
> > and the doc fails to generate.
> > Splitting the docstring (as the next one) seems to be a workaround.
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> >  dts/api/testpmd/config.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
> > index e71a3e1ef0..1e59bccd08 100644
> > --- a/dts/api/testpmd/config.py
> > +++ b/dts/api/testpmd/config.py
> > @@ -30,7 +30,8 @@
> >  class PortTopology(StrEnum):
> >      """Enum representing the port topology."""
> >
> > -    #: In paired mode, the forwarding is between pairs of ports, e.g.:
> > (0,1), (2,3), (4,5).
> > +    #: In paired mode, the forwarding is between pairs of ports, e.g.:
> > +    #: (0,1), (2,3), (4,5).
> >      paired =3D auto()
> >
> >      #: In chained mode, the forwarding is to the next available port in
> > the port mask, e.g.:
> > --
> > 2.53.0
> >
> >
>=20





