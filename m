Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60440CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 19:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F80E40E32;
	Thu, 16 Oct 2025 21:29:54 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id E08474026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 21:29:52 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 75A17EC0053;
 Thu, 16 Oct 2025 15:29:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 16 Oct 2025 15:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760642992;
 x=1760729392; bh=spW04s30xQtbAUBRi7EJVNLdLsfq5zhYjCljDwOl57Q=; b=
 b/WO2lwsdHxBcrSxJXqKNBuOG8A1Rr0YspYQQW0Gm41KSVw0QnSYTR7rsBcy+qC1
 tDGtmQ7If5iJty1Oqr1LzxcPFDhC0p14VURBERHZjOmkk3fJdgxP/rKKaV9Co2Cz
 G9vYPjsEmK+7xbEj0PLQAIZKWsJjHvnqhDgQMrOl9KrYLbcetnLea2h9eFwrjR+G
 aqEyW0itMdGYVtnCzgAls7LZoqbuclZLR8E2FwY4NqSVKNIC0uxtI2Z6k3Kogc/C
 Wv7FVWKQeLNtqKl/p5cVkaryNkPOPbmR24dC/1xNTQsGdjIo6lhwl9k5qJxgf5l5
 +RME7khAN+Erd5vC4vd00w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760642992; x=
 1760729392; bh=spW04s30xQtbAUBRi7EJVNLdLsfq5zhYjCljDwOl57Q=; b=M
 6ba4iuJ8vTC+ft4BP/YlmtePDO79PpYwMbUAgE4Cpa3KY605S+kjoCCmS8kSiYwP
 naI0b0voBPy7zvSKOhgP+knyvo7QYrvPduoXglfyftqvrbAJ8ffz/7msBJU0m3u1
 wV+mY2s9L5l9qxVxO4AQ2ivWaJpVh838MKs48kv8WyPoLhgVFGInHZMJZurz0Acw
 VJfbzsv9q2RhS0LZOLJ7hlk/VNaZbe0buKAfo34O0HcBIVRhgn3SHCfF124w8zmd
 dnlj3S29oJeSVtPk9WX0KE1+rn22Xzs45CjiSSepQWdRhIr1idgn8L1ZBGrBgHz7
 2Td/eyTqC8oGQymzLFx8Q==
X-ME-Sender: <xms:r0fxaJ6K3ZXZzfBo_Hf6yR-Hu02k_fqtQ2FqxtD21gchpDWeolobdQ>
 <xme:r0fxaHB6F7KRVYHuEVOqoCUot1HkcZ3k9aRI6oW-wL3JhrJ2Bb-SCAYsfzlnpQAW5
 xfzRBLza70QweHE71fcJNlgp9eNMeEB1M-wINXgYDF1j9S0ulP1TA>
X-ME-Received: <xmr:r0fxaIbLElmX4fOIk-B3ov6LnZ5JutIJXC0ZbJtR7FvKueKbzIehaJdejSGNygOTDKZrORZt3BKoBzpO2mfSZAPZpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejudefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpefftdeuhfehvdekleelveffvdelhfelhedvgedtvddvudeuieevtdfg
 jedvudegfeenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epmhgrnhhishhhrdhkuhhruhhpsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegr
 jhhithdrkhhhrghprghruggvsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehsth
 gvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghv
 seguphgukhdrohhrgh
X-ME-Proxy: <xmx:r0fxaKbMkQaNQ0Qf3VQq2nolc-LC2swLdJB1LdSW5zfK95Xc9zmZhA>
 <xmx:r0fxaH9U49T30QCrB4kgfmvB8krHVB2QwLR-fBAPwWOhY_RcsDztsQ>
 <xmx:r0fxaBgi6cJ1tMr2DevLSxy6hTMU38-j4CXxFQUjOkdT0I1RDcSXDg>
 <xmx:r0fxaPdJRl2GAddpGlS1VpavwmY24r0CWU65DdodoFeG4aj2vTCDTw>
 <xmx:sEfxaHdvbiuj6cwPUE8XnOay-QoUSoR74Usvhob4BtXJ5ZpgeklQ638_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 15:29:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Manish Kurup <manish.kurup@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH v3 00/54] bnxt patchset
Date: Thu, 16 Oct 2025 21:29:49 +0200
Message-ID: <10599004.ag9G3TJQzC@thomas>
In-Reply-To: <CACZ4nhvcn-z_9W=cuV5nKEcFsP87cBQ+hx6_WsNcqZGpw3gm-w@mail.gmail.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <CAEKskBV=t-3tR+qBGBDPNiEj1=6UKSPGP=-LA5Ztmxr5viwizw@mail.gmail.com>
 <CACZ4nhvcn-z_9W=cuV5nKEcFsP87cBQ+hx6_WsNcqZGpw3gm-w@mail.gmail.com>
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

16/10/2025 17:39, Ajit Khaparde:
> On Wed, Oct 15, 2025 at 12:46=E2=80=AFPM Manish Kurup <manish.kurup@broad=
com.com> wrote:
> > Ok I=E2=80=99ll do that the next time Stephen. Could you please allow t=
his one through?
> Thomas,
> Patch 01/54 is stuck probably because of its size.
> Can you help and open the gate for the patch.
> https://patchwork.dpdk.org/project/dpdk/list/?series=3D36360

Indeed, it's a big one and was blocked (currently it's limited at 700 kB).
I've unblocked it.
I can raise it but processing big emails may be a problem for many tools.


> > Also, how would you recommend I split it? Can I do it by file?
> >
> > What=E2=80=99s the patch limit?
> >
> > Thanks,
> >
> > ;) Manish (x1380)
> >
> >
> > On Wed, Oct 15, 2025 at 15:09 Stephen Hemminger <stephen@networkplumber=
=2Eorg> wrote:
> >>
> >> On Wed, 15 Oct 2025 14:20:00 -0400
> >> Manish Kurup <manish.kurup@broadcom.com> wrote:
> >>
> >> > Hi Stephen,
> >> >
> >> > To reiterate, this happened for V2 as well. I remember seeing a warn=
ing
> >> > about the size of the patch, and that being the reason it was droppe=
d.
> >> >
> >> > Could you please explain why this happens? How can I ensure that this
> >> > doesnt happen again?
> >> >
> >> > Thanks a lot!
[...]
> >> > > Stephen,
> >> > > I don't see patch [01/54] on patchwork yet.
> >> > > From what I am told, that patch adds the ulp_template_db_defs.h
[...]
> >>
> >> I think mailing list and patchwork have size limits.
> >> You might need to split big ones.



