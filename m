Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA82CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 09:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FFE64021E;
	Mon, 27 Oct 2025 10:00:51 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 9A3EC4003C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 10:00:49 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 119F8EC030C;
 Mon, 27 Oct 2025 05:00:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 27 Oct 2025 05:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1761555649;
 x=1761642049; bh=HXL/yngrEF4aTAkNl6OrYLVPNeUP9ZMZtde89q66fLY=; b=
 b3NM3cNMXKqFacPCMR3zF5cVXgP8SV8Ypoci+SNQn5mZfYdyFzIQk2uPCBGy+4OR
 HMMmMVmN0QBVNnX740QRHCbbDPYUZ6WVSNGYjM50qSG/mr5+kDxMLEhYsKFKi/AY
 pTzlTWnVFl0GgoCWvVOjLaLviPH53g496aq9AW/k6vm/8CCChd1+k5774F6gbzVs
 jZaJnZ9tDtyhs+kS/ENIVvv+vFEqoU5WZMra09d6L7iawvgrrBRYkJdK/822x6XE
 Lwa1+sCkCa5pRA4faRqERXRqWgCWbaUsHTZ9+kEs+UoNY5m6oAb2eEbxGsiOGORy
 OeigigK8I8HQNmEoS8dk1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761555649; x=
 1761642049; bh=HXL/yngrEF4aTAkNl6OrYLVPNeUP9ZMZtde89q66fLY=; b=b
 axI4Rb9OFJpeITRwP4zeIUOI7i+aIXu+nDVVCsmoVg1AKbKUS8oemU8jj3sYh0xB
 YopwpLFH3XlH13v7TrxYdFzuxwW7HymPnoe+AoCMynxTewNRQ2SReDDW3r04y84Q
 pVck7UnHd3/+rbwaMJKRrwxg24/0mK3YeAEwxVY1j99buYs0PNyYU4liSdKUBy9g
 O+1P+5rah7s+krWKWBDvZzPIifeW759iUuBjkm/MqozOVIsRCIQ08WD56jV/NT4I
 Xl9GLXd+D6D8Ab/eZBeGCohynWYT3/c5XDxLcBvYqr7c/YCvLrKyy+eNItbqEzvi
 pLDEs2OYYumtWCf9e/ijQ==
X-ME-Sender: <xms:wDT_aBAV_cGo_KO77uY5zCFrPTKuq5zzyIRwKi0HW2YX4VnSEaS3ZQ>
 <xme:wDT_aKd2ntOdt4fFJdAxYdj-a1TfPBqgMJfC7WeSFpxmQNZl6l8wLOXjr3xos2Uuh
 pGOI3YE4Pg8gYQzXfuYk2zeVHjAy--Bd901Pk9iszZXiPQk3qlbQcg>
X-ME-Received: <xmr:wDT_aLkFD7uwnL8uPwD1KuBesFSc3NtSBxJb1zdAakKYF_rsRxeQALoB3qMmt_Ba416TY5MoPAT3oDgBqv5lK3xWyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpefgfeeftdevffffueeiueelhedutefgfefgfeelteehkefgiedvieeu
 geevfeffueenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghl
 ohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhr
 tghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpth
 htohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgr
 nhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghnsehhuh
 grfigvihdrtghomh
X-ME-Proxy: <xmx:wDT_aBGq49dkLgP82ELuHg6T37LAqOLispAZWVAaVUtg4Ps6n_7r8Q>
 <xmx:wDT_aD6LqueZ5iGFZVrP1uWPTpihNJetVhcCBuslmZ9QH-gPYzplZw>
 <xmx:wDT_aJlrjoy0paJpuF4-VYKqdHKW2wMjNiwcX5wM3814BQGQlBbhww>
 <xmx:wDT_aIoaEPQqgvmFZfxL-9Pl-DvNqGcFTf6jtyCwr4gcnfMuputpNw>
 <xmx:wTT_aDmmqIGWOZAmGPB-xRVvICZK4EVKbMH7wG_5clCDrKFS2pna07F->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 05:00:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v7] mbuf: optimize segment prefree
Date: Mon, 27 Oct 2025 10:00:45 +0100
Message-ID: <8731469.qOBuL9xsDt@thomas>
In-Reply-To: <74c5f0883b1943068e7348ca8e8a78da@huawei.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65508@smartserver.smartshare.dk>
 <74c5f0883b1943068e7348ca8e8a78da@huawei.com>
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

27/10/2025 09:54, Konstantin Ananyev:
> > > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > > Sent: Saturday, 25 October 2025 12.25
> > >
> > > > >
> > > > > > > > Refactored rte_pktmbuf_prefree_seg() for both performance a=
nd
> > > > > > > readability.
> > > > > > > >
> > > > > > > > With the optimized RTE_MBUF_DIRECT() macro, the common like=
ly
> > > code
> > > > > > > path
> > > > > > > > now fits within one instruction cache line on x86-64 when
> > > built with
> > > > > > > GCC.
> > > > > > > >
> > > > > > > > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > > > > > > > Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > > > > > > > Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> > > > > > > > Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > > > > > ---
> > > > > > > > v7:
> > > > > > > > * Go back to long names instead of numerical value in
> > > > > > > RTE_MBUF_DIRECT()
> > > > > > > >   macro.
> > > > > > > >   (Konstantin Ananyev)
> > > > > > > > * Updated static_assert() accordingly.
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > >   *
> > > > > > > >   * If a mbuf embeds its own data after the rte_mbuf
> > > structure, this
> > > > > > > mbuf
> > > > > > > >   * can be defined as a direct mbuf.
> > > > > > > > - */
> > > > > > > > + *
> > > > > > > > + * Note: Macro optimized for code size.
> > > > > > > > + *
> > > > > > > > + * The plain macro would be:
> > > > > > > > + * \code{.c}
> > > > > > > > + *      #define RTE_MBUF_DIRECT(mb) \
> > > > > > > > + *          (!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT |
> > > > > > > > RTE_MBUF_F_EXTERNAL)))
> > > > > > > > + * \endcode
> > > > > > > > + *
> > > > > > > > + * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL a=
re
> > > both
> > > > in
> > > > > > > > the MSB (most significant
> > > > > > > > + * byte) of the 64-bit ol_flags field, so we only compare
> > > this one
> > > > > > > byte instead of
> > > > > > > > all 64 bits.
> > > > > > > > + *
> > > > > > > > + * E.g., GCC version 16.0.0 20251019 (experimental)
> > > generates the
> > > > > > > following
> > > > > > > > code for x86-64.
> > > > > > > > + *
> > > > > > > > + * With the plain macro, 17 bytes of instructions:
> > > > > > > > + * \code
> > > > > > > > + *      movabs rax,0x6000000000000000       // 10 bytes
> > > > > > > > + *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
> > > > > > > > + *      sete   al                           // 3 bytes
> > > > > > > > + * \endcode
> > > > > > > > + * With this optimized macro, only 7 bytes of instructions:
> > > > > > > > + * \code
> > > > > > > > + *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
> > > > > > > > + *      sete   al                           // 3 bytes
> > > > > > > > + * \endcode
> > > > > > > > + */
> > > > > > > > +#ifdef __DOXYGEN__
> > > > > > > > +#define RTE_MBUF_DIRECT(mb) \
> > > > > > > > +	!(((const char *)(&(mb)->ol_flags))[MSB_OFFSET /* 7 or 0,
> > > > > > > depending on
> > > > > > > > endianness */] & \
> > > > > > > > +	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > > > > > > > CHAR_BIT)))
> > > > > > > > +#else /* !__DOXYGEN__ */
> > > > > > > > +#if RTE_BYTE_ORDER =3D=3D RTE_LITTLE_ENDIAN
> > > > > > > > +/* On little endian architecture, the MSB of a 64-bit
> > > integer is at
> > > > > > > byte offset 7. */
> > > > > > > > +#define RTE_MBUF_DIRECT(mb) \
> > > > > > > > +	!(((const char *)(&(mb)->ol_flags))[7] & \
> > > > > > > > +	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > > > > > > > CHAR_BIT)))
> > > > > > > > +#elif RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN
> > > > > > > > +/* On big endian architecture, the MSB of a 64-bit integer
> > > is at
> > > > > > > byte offset 0. */
> > > > > > > >  #define RTE_MBUF_DIRECT(mb) \
> > > > > > > > -	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT |
> > > > > > > > RTE_MBUF_F_EXTERNAL)))
> > > > > > > > +	!(((const char *)(&(mb)->ol_flags))[0] & \
> > > > > > > > +	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > > > > > > > CHAR_BIT)))
> > > > > > > > +#endif /* RTE_BYTE_ORDER */
> > > > > > > > +#endif /* !__DOXYGEN__ */
> > > > > > > > +/* Verify the optimization above. */
> > > > > > > > +static_assert(((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)=
 &
> > > > > > > > (UINT64_C(0xFF) << (7 * CHAR_BIT))) =3D=3D
> > > > > > > > +	(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL),
> > > > > > > > +	"(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) is not at
> > > > MSB");
> > > > > > > >
> > > > > > > >  /** Uninitialized or unspecified port. */
> > > > > > > >  #define RTE_MBUF_PORT_INVALID UINT16_MAX
> > > > > > > > --
> > > > > > >
> > > > > > > LGTM, thanks for refactoring.
> > > > > >
> > > > > > Thank you for reviewing, Konstantin.
> > > > > >
> > > > > > I had no preference for v7 or v6, but Bruce and Thomas preferred
> > > v6, so v6 was
> > > > > > applied.
> > > > >
> > > > > Yes, I saw Thomas email, after I sent my reply already.
> > > > > Looks like I was late with my vote.
> > > > > My preference still would be to avoid hard-coded constants in the
> > > code,
> > > > > but seems that it is just me.
> > > >
> > > > Me too I want to avoid hardcoded constants.
> > > > But in this case, it is very well documented,
> > > > and there is a trade-off with length and reading.
> > >
> > > If we allow hard-coded constants in one place,
> > > then it would be harder for us to disallow them in other places.
> > > If we allow them everywhere - code will become a mess pretty soon.
> >=20
> > Vector code has plenty of hardcoded constants. E.g.:
> > https://elixir.bootlin.com/dpdk/v25.07/source/drivers/net/intel/i40e/i4=
0e_rxtx_vec
> > _avx512.c#L154
> > So we already do allow it.
>=20
> It is a SIMD code for specific architecture (avx512) and specific driver.
> mbuf.h is a core header in our core library - I expect the code cleanness=
 requirements
> to be higher for it.

=46eel free to propose a patch, and I'll apply it if several reviewers like=
 it.



