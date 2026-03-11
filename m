Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9259F1125863
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 18:41:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB8B240A76;
	Wed, 11 Mar 2026 19:41:53 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id DCCC74060A;
 Wed, 11 Mar 2026 19:41:51 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 27CE17A00B6;
 Wed, 11 Mar 2026 14:41:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 11 Mar 2026 14:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773254510;
 x=1773340910; bh=xHma0u+akC/tvs61BhwM8QcnLqGH+z26qW5ch4SqxNU=; b=
 f9uc1Qzt+8v81+jdmKQH1LJ8pOAse7kJ/S93nhj5lYI3+Dopu2RkIOl+J5du7aC3
 sAZdGeXefvkORcWoj+A8lXD4R02F3g6B77v81+d9Dt1qQKDWbQ1WD227IIjY9mjX
 Oun9ZCHORvoWncemB6B1UiVlN3ncuUQ/91cVfF6srx1IZWt3Vz1yJJHL3mKkPwps
 BRp+OIMOVysQwJfmnkPnle4KRRdoflhWlUX9f+p19hRQOc2t1Oqo9cj8SgtFj+Wn
 bEwOeC2VJgYiasVoFYP92zaGUOaVLcq+MCwyqHlTGqDn9Hp8kvQNu8GHW8xAtA4y
 IoHH6kdrVMTLj7mxmiUDvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773254510; x=
 1773340910; bh=xHma0u+akC/tvs61BhwM8QcnLqGH+z26qW5ch4SqxNU=; b=i
 BKXdyBltArYB8n01ydwwhtbmQjZ5SOjj/zTxpMAdoxFaSX3QcgpY1CTjaGGVaVAR
 fc0Njc1BrjRWXBsP+zipfHBDjyj2JZUsfrAwejfOSgzcldKl/nEt50vnGj0JkgqJ
 QA9gaXFch4dTRzqy7VXH6e/Si+Ic1w7btrhNLUg0RlgzI32c+AlfziD+nRE5DbOx
 xvsw40/PAGYzd3RTBZy1DN3XdC1ILnlY90EhL4w0mSJeUw1b1jSKnogltwO+hdaY
 BoRtsE1v97W+blro5yYyiK1ZYsVLuf3yb/jGcaoUnmSCBiJZccYnTg3V6CYUpLZ0
 ibvm7lwx5Kofl5P28VEFw==
X-ME-Sender: <xms:brexaat0XiYeHY-dOP0VuGJhktKFrfg1d5SdnQc3iMQFV_GLpJw2ig>
 <xme:brexafnPPhXBlpzu-C8QrMswNDGRzkPbSTQ2G0DmeW90Wu0WR9pF5ovDLT5be0490
 RkpTUE0EngqOFHx-IIysNNqPl3u93T2I6I5acrRcrt5NorKqt4zBw>
X-ME-Received: <xmr:brexadtM94-BDMflLP__K2y261tDdZWJZ1-NToFJ6jeiRNreMzuRICcpLyxcVBZConzKf15WboILEEQ0nW2iiQE-TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegieehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmohhhrghmmhgrugdqshhhuhgrsgdrsh
 hiugguihhquhgvsegsrhhorggutghomhdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoh
 epkhhishhhohhrvgdrphgrughmrghnrggshhgrsegsrhhorggutghomhdrtghomh
X-ME-Proxy: <xmx:brexadc7a6LAxdgLW-FUG-Sp6wM3VBtCCXsGGvfUEocmYH9N52BnTg>
 <xmx:brexaVyyiYlqzp77oM4v_RSzTLulkfGMjThPbI0zi5adrP0GvbpcxA>
 <xmx:brexaTGnz1Pine8GVdjw9xtUV0i6BPY70bjIzMxKoTFOhQD7gU_t0g>
 <xmx:brexaZxrDYxM0NRx0mEYQvxs6FVroa-xui1wECFIYU5WRCak40BxWQ>
 <xmx:brexaZFyCLX8vNt9ZSuyYpDlKYquuYTBwWqixupzSJEjxWcIfNnEDick>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 14:41:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: Re: [PATCH v2] net/bnxt: add multi-doorbell support
Date: Wed, 11 Mar 2026 19:41:48 +0100
Message-ID: <3032945.e9J7NaK4W3@thomas>
In-Reply-To: <CA+BST0nENuxNg5R3cgec8b6T8++bA_puqsPNoqL_G2bQ3xZNcQ@mail.gmail.com>
References: <20260303173156.204872-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260303174219.204977-1-Mohammad-Shuab.Siddique@broadcom.com>
 <CA+BST0nENuxNg5R3cgec8b6T8++bA_puqsPNoqL_G2bQ3xZNcQ@mail.gmail.com>
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

03/03/2026 19:14, Kishore Padmanabha:
> On Tue, Mar 3, 2026 at 12:41=E2=80=AFPM Mohammad Shuab Siddique
> <mohammad-shuab.siddique@broadcom.com> wrote:
> >
> > From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> >
> > Add multi-doorbell support to spread doorbell accesses across
> > multiple doorbell pages for improved performance on P5/P7 chips.
> >
> > Detect capability via HWRM_FUNC_QCAPS
> > Round-robin DPI assignment for NQ rings per device
> > TX rings inherit DPI from parent NQ
> > RX/CQ rings use privileged DPI 0
> > P7: DPI 0=3Dlegacy, DPI 1=3Dpush, DPI 2+ for multi-DB
> > P5: DPI 0=3Dlegacy, DPI 1+ for multi-DB
> >
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadco=
m.com>
> Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Applied, thanks.



