Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F7C103A9BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A71C402CE;
	Wed, 25 Mar 2026 15:17:41 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 9A9F24028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 15:17:39 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 0A1491D001A4;
 Wed, 25 Mar 2026 10:17:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 25 Mar 2026 10:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774448258;
 x=1774534658; bh=klTBYkn9YAZUAd4lxKxz/i1BcR7PGSzjo+8uCU5qNHw=; b=
 c10iR9zB0lzKvcaLbJcFD5FYav0SmRvhs5HcKnx1e2n7uOK4xWgxzFeVnz3NktVq
 s2UUeZtutPK0jFLB7Val/6+vJXsXWhjKAvjOqvZTVV/hIn29a9LV+/EiU1g7oSeY
 Y4aMYJZ7rk+9aEoBX7CBwIEpo87LL8JEMyxJugHxwkGHDYYx7CDZTObO+Lf4JXri
 LxPu0q2r5AKbwDib9mIR1rBaGYtkXYi1T6ZnH29udBAcS0LB1h8Y9xRJ/ckM2Ic+
 J5qJn7nev7KJ5Xjw1C83NPt19estf+zO56TolN93+xwoJHRt82kzou2uXNyKiRgO
 cgrLTO0Equqhhzv9JqrmCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774448258; x=
 1774534658; bh=klTBYkn9YAZUAd4lxKxz/i1BcR7PGSzjo+8uCU5qNHw=; b=A
 8txUF/HdKMTMxaWhyfkuOn5QQdarMOvwMHp6CAow6+eBvy5lT0nkAZElVoea4zuT
 OdJhl/VYaho0xipHXHjcaDzPdDq7BO9Kr4r+2RNVEwULQhsp3dWJ6elAWS6gfGCg
 cG2p3yRiMbncWFTCQLxEcBUS3YKUJU0E72u9uf0l40dfyAfR52XmfrAqSV38drYW
 Z8WH2UADr4zWLXVRO1wtyh13oAomwHNKOFfhVxm1YPz4OgcdNp9bFVxXC6bxC34z
 ed0Lbws7HWilRRJERJTtlbisadczZLmbNrlCzIZyrGPvGwLX7cBoc76IUNWM61+N
 ktoyk3LtqVuZgVIHkQ6pQ==
X-ME-Sender: <xms:gu7DaUv1DMT_H3vXDaH2WQ4pjwH9Tpeyha0U-sCq7Q2KnlUy7xxINQ>
 <xme:gu7DaVy-oeaSgboPeHLDV8OVvaEtmYDQh0fOS30E1m1tzoLsIKHqXQ9cP5gSCAnVQ
 6oxbSeE5k15DJvk_cI-R2To4nSeWKfyKUh6l_y9_R_mrq5zDDc7fg>
X-ME-Received: <xmr:gu7Dae5nSaQBRTzv5CCCWTnWYAthiX65jhi0fIS54c81WltYvEbMCDkTOKkorCsfX-EV03CCtnb50krpUtro6Kr6ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmohhhrghmmhgrugdqshhhuhgrsgdrsh
 hiugguihhquhgvsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehkihhshhhorhgv
 rdhprggumhgrnhgrsghhrgessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepuggvvh
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:gu7DafUL28uEkXHbhC8FW_L6e6lJtPGvBYf3N5GVH8Y1fW8wRKFs7Q>
 <xmx:gu7Daa09XElFYRqdiEWBkiz_TPoFRTZQRo4vLlSgDZNdUsQdmXCYVA>
 <xmx:gu7DaU009uX0mpsFZmYCyNecOf59fegJ1Pm4iwv456JthOapjKwA5Q>
 <xmx:gu7DaV_uLoQE9Wrnh6ZlA2QDbc5zQ-RbbB_RqJY8wAFsWQxTnnZtCA>
 <xmx:gu7DaYzb31ZqpMQLY1ML0HxEYo2qzNxqmT2BqZ1we6vONBFRFAAMMV8t>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 10:17:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/bnxt: fix l2_db_multi_page_size_kb position in
 func_qcfg output
Date: Wed, 25 Mar 2026 15:17:36 +0100
Message-ID: <4156142.taCxCBeP46@thomas>
In-Reply-To: <CA+BST0kjGN1rez_OWsrYdRHs0q=QiTv=s4iT7Xfq8Ag46PMDjw@mail.gmail.com>
References: <20260324204815.54465-1-Mohammad-Shuab.Siddique@broadcom.com>
 <CA+BST0kjGN1rez_OWsrYdRHs0q=QiTv=s4iT7Xfq8Ag46PMDjw@mail.gmail.com>
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

24/03/2026 22:02, Kishore Padmanabha:
> On Tue, Mar 24, 2026 at 4:46=E2=80=AFPM Mohammad Shuab Siddique <
> mohammad-shuab.siddique@broadcom.com> wrote:
>=20
> > From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> >
> > The field was placed at incorrect offset in hwrm_func_qcfg_output causi=
ng
> > legacy_l2_db_size_kb to read svif_info instead, producing a doorbell of=
fset
> > exceeding BAR2 and resulting in SIGSEGV on BCM57608.
> >
> > Move l2_db_multi_page_size_kb after mirror_vnic_id to match firmware
> > response layout.
> >
> > Fixes: 04102f2ffc8c ("net/bnxt: update HWRM API to version 1.10.1.6")

looks not related

> > Fixes: 7a1f9c782b50 ("net/bnxt: add multi-doorbell support")
> >
> > Cc: stable@dpdk.org

not needed as it is only fixing a recent commit

> >
> > Signed-off-by: Mohammad Shuab Siddique <
> > mohammad-shuab.siddique@broadcom.com>
> >
> Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Bugzilla ID: 1909
Reported-by: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>

Applied, thanks.


