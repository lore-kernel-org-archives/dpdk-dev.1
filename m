Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743C6CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 876784029E;
	Wed, 27 Aug 2025 17:11:40 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 02F3340292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 17:11:39 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 73E151400157;
 Wed, 27 Aug 2025 11:11:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 27 Aug 2025 11:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1756307498;
 x=1756393898; bh=rNzajDAdY2aXGposkMwGvQsvhOAaAtNhSkacSd/th5w=; b=
 kwTzXj18YSGvAczuKk4Eirfau5ZhxHSelopNveeIaiqe6eufJGTkv69hePqdT1wx
 lXM1ayz+4R8TjZ4t2Obc2TFGmr9U8jBepqohEe/8EIVQJ/0eln5OUCKAfWUmvlrR
 0LRoeFd14kEw4pWTYQVnQeX5Zowfo49qVOO0Rtjj341A0j4AopVIT4wyQc+/OeT3
 P7C/bf7fmhGB/c3TF2TF5+96bQ4KWcN0AsX2sbZs4cENa/3dMUHkb1gZZ/mryzG6
 4qmu8pDEqNxJDu9FA43swUS4lpDGE6jXFiaj/sL6JE5nmavVI7wg8Zaod5/J2Sv2
 ADohGhX0HoN5lszVDRpELA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756307498; x=
 1756393898; bh=rNzajDAdY2aXGposkMwGvQsvhOAaAtNhSkacSd/th5w=; b=J
 ybwlhxfWQ4lcqDMXt3V64tEQGTfz+89F5mZR30o9TjpgHnZSgHLRgqW+O0hgrQIw
 zws4W3LfsCah7hTqYa2PN0dodsyjXJ110MwMdwa6Mu8j66Ouah/Aknxs1sDVs19X
 7OPJfUfKF4fYYaYhb7cgjUZjgs6oY3TJai/LZpPw+snT1K/BCVMgpRGF+ILTR5fv
 R5Fk2MF8PZgbyQp4eTEskBf3vi/o2JToqA7dl7VPtzU7vjasB7tFeQmbcb+bPRgS
 5vU5FdQT5U9XL6+sjUBwAib5lzZlydpusaKdzAbxGEe1EJh95qfN3Qs1I26Hcq4y
 VPpCxAS/w2r6hSCm1an2g==
X-ME-Sender: <xms:KSCvaFRU17MzkuB-4yD3IxvmRN5NW9eV9fHnH4aL5HX8on4liRiJVQ>
 <xme:KSCvaMunG_TeoTwMypLABt6spBANaV6V66qziEkPChrKL2IZU-N1xPT9QWxtQQwYa
 6ali85QpM-i4VTtQw>
X-ME-Received: <xmr:KSCvaNIUHHnXnpVukf9SOoiKpeXu-tDs7VbWZxfnX5rkTuLZ5RWKGAAIYSh5QDmeS6iJtSY2-O3bRO3lG80KA7nQ4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekgeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhu
 mhgsvghrrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhs
 rdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheprhhorh
 gvthiilhgrsehmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:KSCvaBnkBGIAVmy69YlhS5LV2fQcSWDzc47vZ_zIlBnRMwTN7SBxlA>
 <xmx:KSCvaGIE_flqJ8Vb2Z1uaFnEyY75psX7BB35vyI80TZzs3Glok3OuA>
 <xmx:KSCvaO64eC8M22kxWJ76E6xDRJs97ts9PDcknuzDVwFx2NugcHAKRQ>
 <xmx:KSCvaC2wJBvvVten3hs6s9J4M2iUNY0XS-T--87LPiMS3A4j_TKT7g>
 <xmx:KiCvaJu-AYE34LxMHW5oDbwzzIHnKSbVf7OD7Hsi7GT7ueSikiJThSXa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 11:11:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@microsoft.com>
Subject: Re: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
Date: Wed, 27 Aug 2025 17:11:34 +0200
Message-ID: <2404222.ECZNHGQPT7@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE79@smartserver.smartshare.dk>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <e9017361-f29b-45da-a1b0-cc745b8c906f@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE79@smartserver.smartshare.dk>
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

27/08/2025 17:08, Morten Br=C3=B8rup:
> > From: Burakov, Anatoly [mailto:anatoly.burakov@intel.com]
> > Sent: Wednesday, 27 August 2025 16.14
> >=20
> > On 8/20/2025 8:42 AM, Morten Br=C3=B8rup wrote:
> > >> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > >> Sent: Monday, 18 August 2025 18.34
> > >>
> > >> On Wed, 12 Mar 2025 16:15:29 -0700
> > >> Stephen Hemminger <stephen@networkplumber.org> wrote:
> > >>
> > >>> This series adds common macros for safe iteration over lists.
> > >>> It is a subset copy of the macros from FreeBSD that are
> > >>> missing from the Linux header sys/queue.h
> > >>>
> > >>> Chose this over several other options:
> > >>>    - let each driver define their own as needed.
> > >>>      One Intel driver got it wrong, others will as well.
> > >>>    - rename all the queue macros to RTE_XXX variants.
> > >>>      Seems like useless renaming and confusion.
> > >>>    - Several distros have libbsd package with the correct macros.
> > >>>      But adding yet another dependency to DPDK would be annoying
> > >>>      for something this basic.
> > >>>
> > >>> There are more macros in FreeBSD header that could be useful,
> > >>> but we can add those later as needed here.
> > >>>
> > >>>   lib/eal/include/rte_queue.h              | 174 ++++++++++++++++++=
+++++
> > >>
> > >> Revisiting this and wondering about naming...
> > >> The file rte_queue.h is not really DPDK (ie not related to runtime
> > >> environment).
> > >> Thinking of calling it bsd_queue.h as a compromise
> > >
> > > Since it replaces sys/queue.h, then maybe sys_queue.h (or rte_sys_que=
ue.h).
> > >
> > > But more importantly:
> > > It is not really DPDK, and thus shouldn't really be part of the EAL.
> > > So here's an idea:
> > > As part of de-bloating the EAL, can we somehow add a new directory st=
ructure
> > for independent "libraries" like this?
> > > And treat this rte_queue.h file as a "header file only" library, and =
put it
> > there.
> > > Then, build wise, the EAL could depend on this "library".
> > >
> >=20
> > IMO it depends on what you mean by "EAL". EAL is environment abstraction
> > layer, and this header abstracts OS, thereby meeting description of an
> > "environment abstraction layer"?
>=20
> This library (header file) is generic, and has zero interaction with the =
hardware and OS, so it's not an environment abstraction.

I disagree here, it is something due by the OS libc,
but not reliably available everywhere.

> The EAL has become a dump for "everything else" that isn't an individual =
library with its own subdirectory of the /lib directory.
> IMO, it would be nice if we could separate generic utility libraries from=
 the EAL.

I agree with the goal of having a thinner EAL.

I'm not sure about this one.


