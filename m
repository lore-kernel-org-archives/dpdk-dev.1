Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65518C44501
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 00:48:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E9C5402A7;
	Sun, 12 Jul 2026 02:48:02 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 3FDD54026F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 02:48:00 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id AE5AFEC00C3;
 Sat, 11 Jul 2026 20:47:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Sat, 11 Jul 2026 20:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783817279;
 x=1783903679; bh=o5wcEei6RIR4s3R3EnrEFIpRLrw35jq3gZv7ytCyT0c=; b=
 Pk1gLvwOIhIeP226EBSPjnztUYtWOSdVHcLMyvJ7fxkZUB8fSlkPLSHj/WJ48H4b
 CXlqr72IoQo1RRnjheYZBINvrOS34HkAnTeGeEna/5kgna/me8q85iXw7oZ+RM3N
 4AQu5ql6NA88LKrKDvCvvLPlGfFzDCQNHZvIEgYGl3qmIcECIUoGjb4Hmcwe0JK/
 +TnlTvLcLXonic9KMqYq9upG8oWkM6VWBmRqGogFD4TRb+Ps1OHxYwQ8Cc+wAELO
 tUG4Aoou4A+dMab8oyACAKZ+Q61n+2zY3Ovs4deCBahg7MPprP3obwlisBOGubjs
 CkaaU1cE8QcNrhx5wdmr3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783817279; x=
 1783903679; bh=o5wcEei6RIR4s3R3EnrEFIpRLrw35jq3gZv7ytCyT0c=; b=H
 JNVJmqOE4ylbAl2a3k+2cc5NhH1TgstPYRxv7c2/5hQkJEKf/KI3RgNR4s79mVPQ
 M7/F/gAZd8n822qEUuS49ZeQnLnYqbnCLNXdMDkPIKihBQyjFcs/KFLTgujazw/j
 dZOAPAn4tl97vGxazSlWlpVrvIXobVL1g/OrN3Jt7kPBBlo7HyuLY55rv3bRJTB3
 US73KdEIEmNHQHZtQ5zxpG2wb2+OrGKf3JhN/BV4hagG7t2QGToA+KE3rW2r9tto
 SVkfx8PJeosacJ+VMV5hwfGnmwaJZ0T2e1J3nETkBDfyULfuCx2j+cGJtvqhNCjp
 XWyp9TUYKA374wkssE/XA==
X-ME-Sender: <xms:P-RSahmcz1N_gSmyuyVJTL6YyPHWv4zC8Cq-R95hrT4mDEoFOrtchg>
 <xme:P-RSahLYR2ggLczqY5ZxRDGIrqa7_at5CD_oSIFJrSjC2FB0eHjPcKsf4iiFD4Cig
 XSCd54ilEnR9_lGawzJFZRilwJttuC-Jd63WhptlH6cQg2eKMt1yA>
X-ME-Received: <xmr:P-RSamze45oPkt_7hLmjOeYSrx-s6uVCHHGnFbQxP-eS0ysEkDHmxn89EN-w0VDKlb_qt2hQ3cUZd1YI1oHO>
X-ME-Proxy-Cause: dmFkZTGLP9hdAAzNFxZqzxAYdIs1ZLmkd1cEyxeh+93j/MVCtK3cuhbgCeJosO0n2X++QA
 ATxWN5hEWqVkUHTs8lMFuQ8lD02HqqpNVDKeGH1HX/BCA6x1aVTJTOJ2liL0KI314e9V8j
 uIQAbiaSwXWQWHoppbKHJJQK9ye+5DauigbB6FWjIVfghR/mtaJYAfqqnzCQ9mWkOvm6q8
 JGzZI2FX6bJP+BvxHYl3FSol9GsPUof4fpSXLEuQX8uZbgsdFOJaJ3VxDC/zokxJiEQJ03
 bdgqkRSt1p1DIJIizd2kLRA8TCuSZWVRmsDvsGj9GrBkVp5+MY/+aFceRGMmvUe0DwceZZ
 mfqK6sHsOEHSy/58mvFqrllVC4sxyrsIHY1kDz/LuqKgwSx+C7Wi9Yg3H6cGy08XSPzFIZ
 lmmOx5usodPXDICMWWd2/0RXXkKHU7ca8lbYzTGu+4cNqaMbu3gwsB+6EcCivBRrJU8ZQJ
 PBNkd2PtLBPXWzkqM9zVAD5ouhXjwCSB+UvRMdfL1OdNEqNyiGCqfHM1hdfs8Rhu7g+S9M
 GQdQLLzvwIkVFhZrBj528C9ACFxfv3+epKDPr3ICeACeA3SOpuNThsiRb+DdBA8nFv2W1Y
 D3CiIWo6hmfd8qFwRAjpEEvfkCARPRBx5q0u+zN57NsNrqC77eQvEHJlum9w
X-ME-Proxy: <xmx:P-RSapuzPBKa4i3kKCqkANJ8wPqObFnmy1yOMnae2I36EvEKGRgzVQ>
 <xmx:P-RSalvDl37VaFTJxduqPYfoQjX64-t2pGi9wKp2nGaVJV7UOuhcCA>
 <xmx:P-RSamNz0Cr3nS1A7HAl6TyUfs757XpMTKj7tKMlu3yJnsA8MSKP8A>
 <xmx:P-RSar2OESYbzfXKixopy1w-aXDa_9HctFnmCmDqFUFv3ckBOFc0iA>
 <xmx:P-RSarUrLu2FwkCOF11K-vkC3Ejk-2mfh3EsZci0KkRQsa1BSzyge5pE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 20:47:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Loftus, Ciara" <ciara.loftus@intel.com>
Subject: Re: [PATCH] config/x86: enable compatibility with muon-build
Date: Sun, 12 Jul 2026 02:47:55 +0200
Message-ID: <eE7oVtFKTtG1l0W6X1-50A@monjalon.net>
In-Reply-To: <DM3PPF7D18F34A1A9A7381CA38881194F948E2D2@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260204103015.1895506-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1A9A7381CA38881194F948E2D2@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

22/04/2026 13:02, Loftus, Ciara:
> > Subject: [PATCH] config/x86: enable compatibility with muon-build
> > 
> > Muon[1] is a reimplementation of meson in C, and in some ways is rather
> > stricter than meson in processing the build files. Make a few small
> > changes to the meson.build files to improve muon compatibility without
> > affecting meson:
> > * when checking a list of compiler args always use has_multi_arguments
> >   rather than has_argument, even if list only contains one item.
> > * when putting lists of compiler args in message output, explicitly
> >   convert to a string for output using ','.join().
> > 
> > [1] https://github.com/muon-build/muon
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I tested this out with both muon built from source and muon downloaded
> as a package ("muon-meson"). Only the version from source worked, as the
> package version was missing some features required for building DPDK. I
> encountered the same issue with the cnxk driver you flagged. Build was
> successful after disabling. I think it makes sense to make these
> changes.
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>

Applied, thanks.



