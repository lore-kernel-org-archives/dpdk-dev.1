Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0BBC282C6
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 19:25:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61B8E40156;
	Mon,  3 Mar 2025 20:25:09 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id D4FC440041
 for <dev@dpdk.org>; Mon,  3 Mar 2025 20:25:07 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4B51011401D9;
 Mon,  3 Mar 2025 14:25:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 03 Mar 2025 14:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741029907;
 x=1741116307; bh=uTOuP8o2tjO8JgVpTxcnx+zqejueL4UT2ZfRCxE9wsA=; b=
 VTXExr1Mr8FuQXxGiOdGUzjX49b1XaGQpIrrFBnlq1S+L63owixBKlLpl+eU+EI7
 Rb7ZQZWinf89BewAG/ObdzDP9ChxEDyXniocElit2t89dr3fl8d6No3isvPWEMI6
 2luXzBFsMLPPALT7MfSuMDS4ONRcsT1ZjGt/1ArMmLHsES2hW0quAiRTmxf7Ppey
 KZejwzCl81Mnf32MQzgO+BPyKhfaR8ihy4xz228VC3F4aU/2idjRCGqLcT1vgl5R
 ECBkj0HAOwfVPvqy5FMPJb2X1Wilp24eixzEFZMWhJ3HfkeHjWhdCgT5xVt/heSb
 Fo9ikark0zaUvtOJvi8dhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741029907; x=
 1741116307; bh=uTOuP8o2tjO8JgVpTxcnx+zqejueL4UT2ZfRCxE9wsA=; b=m
 XLwSLqGXPSpq8EsglxXH3QHp7IuKKh6Ft1H+i0V5Vrf3AMrOYRaYghNeTuIDFTpj
 XLFkj9OTrwdTjkfZFSR5Iilnwr8Gh3hPWCInpZpQbwBjzVHDTLR2xBxLbQ2ej4BL
 h8MuIWxkpxxdIXrESlOMktu7NAFxOCNVG+qDiX/3aX4qaRrYuTdfece7mEGvc/tg
 gH4zNUFYduTFuew5fZ3SFSRZ9GURSSN3ivPubwxqcLQ5wzbJmlyqibYNG6NeOYu3
 GkAtOh0VYBMasoYrMgV5QXtfZhqUvZAvHPiAPZbjTwk1dgedhpYytXbeGGmJwa7o
 JqGPR2Obc+OlzRstLXdvQ==
X-ME-Sender: <xms:EgLGZ6A7duDx_fOW012uGOzgX51QiW3kjdnjuU3ltQTDsPpQD4Il8w>
 <xme:EgLGZ0g_X8tk2RZxA4EBsS2v9LO1koZMAJG7iTS19wEdBMu1xMvq1DYMry7eOf-mE
 Ce6tUyEcdCH1SmRzQ>
X-ME-Received: <xmr:EgLGZ9n5KOjmp2v6PNQzi_tJPJSmplYMI8_sMt31NxviebYVnWKcgADXpEBK1WAOT3j2xc7LtZcvK05dwIe7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleelhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepgedttdeljeejgeffkeekkedtjeev
 tdehvedtkeeivdeuuedvieduvdelveejueejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhish
 hhohhrvgdrphgrughmrghnrggshhgrsegsrhhorggutghomhdrtghomhdprhgtphhtthho
 pegrjhhithdrkhhhrghprghruggvsegsrhhorggutghomhdrtghomhdprhgtphhtthhope
 hfvghrrhhuhhdrhihighhithesgihilhhinhigrdgtohhmpdhrtghpthhtohepqhhirdii
 rdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorh
 hgpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:EgLGZ4zD2nDHjDb5k3574ScilVGjdxhSiX0msb_sV8oyF_ewhat7Iw>
 <xmx:EgLGZ_TOKIJKHNQQ-ROJbsjYV0dFsiY384BzHCxrxg9mRhKHqy8H-g>
 <xmx:EgLGZzbyJfcrZXWKt5IbJLzpKPwgbRPiNge8Fd6U2qfZPp5FflS3vQ>
 <xmx:EgLGZ4Q2KuOJclFHWk5zu37RRp_euKRMvl-y6PZYW5Eg2ML7r84GbQ>
 <xmx:EwLGZ-HIaZo9E5VAhfb0Ocr_2LKUthMWtR9-WJRefTl0IV8t5NG8p1Re>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 14:25:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Ferruh.yigit@xilinx.com,
 qi.z.zhang@intel.com, dev@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: MPLS Push action
Date: Mon, 03 Mar 2025 20:25:03 +0100
Message-ID: <15378777.dW097sEU6C@thomas>
In-Reply-To: <CACZ4nhuSCiD6gNzF2GFXVoAD__f0oOgu8fXCwRYy6UGMDy3atQ@mail.gmail.com>
References: <b62e330e086126415f7b4987a9747ce2@mail.gmail.com>
 <CACZ4nhuSCiD6gNzF2GFXVoAD__f0oOgu8fXCwRYy6UGMDy3atQ@mail.gmail.com>
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

Hi,

This is the related code:

/**
 * RTE_FLOW_ACTION_TYPE_OF_PUSH_MPLS
 *
 * Implements OFPAT_PUSH_MPLS ("push a new MPLS tag") as defined by the
 * OpenFlow Switch Specification.
 */
struct rte_flow_action_of_push_mpls {
    rte_be16_t ethertype; /**< EtherType. */
};


> On Mon, Mar 3, 2025 at 8:02=E2=80=AFAM Kishore Padmanabha
> <kishore.padmanabha@broadcom.com> wrote:
> >
> > Hi,
> >
> > Anyone has any inputs on this. Or should I add new CLI commands in test=
pmd to support action for push MPLS tag.

This action was designed as an OpenFlow implementation.
Is what you require an OpenFlow spec?
If yes, we may consider an update,
if no, we should create a new action.

> >
> > Thanks,
> >
> > Kishore
> >
> > From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> > Sent: Thursday, February 27, 2025 6:35 PM
> > To: 'dev@dpdk.org' <dev@dpdk.org>
> > Subject: MPLS Push action
> >
> > Hi,
> >
> > When MPLS push action is used, using testpmd action  of_push_mpls, it a=
ccepts the ethertype only. How do I specify the MPLS label and other fields=
 for the MPLS header to be added ? In the doc, in section 7.2.3.7 there is =
mention of OFXPMT_OFB_MPLS_LABEL and other MPLS fields, but I could not fin=
d that in dpdk implementation.

What is this documentation?
Please provide a link.






