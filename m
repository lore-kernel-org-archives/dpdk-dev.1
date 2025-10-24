Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4346DCCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 10:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F46D40267;
	Fri, 24 Oct 2025 12:15:00 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 5A7964025E
 for <dev@dpdk.org>; Fri, 24 Oct 2025 12:14:59 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8F7987A0173;
 Fri, 24 Oct 2025 06:14:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 24 Oct 2025 06:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761300898;
 x=1761387298; bh=0v7BQLntkqK7hH1owy+a6cNYKhUBtpAk+cHKXsYVWuE=; b=
 ZH7I49YAZCnS9ek2ccJC5YIEx7Jkgx0OUSUhSPjsLT8mwv2/NUaxXMFIo0MmEYUY
 rFaHgDGXkTXbzLLLBPRzy0EJFfGj0gfo9/l0Ck2ZOj/4QxbgMMkEm3h/enNKOXmN
 nOH7fx7GVYV0KEKpcJTBc52aIZqJPJ1qeETctYnSSyWBaWwwQRwO3/isCFnVNiQW
 itJZm3/xBENqReZ6TbYDFKF7wqA8Zm/0l0/hrj88mBViJXyq63ZM3lAXlg+quRVK
 J+WVnBzhzf8Xsj1rVlDf9j7cpIGDX7ifoXg7NNG7qbIMtB3MGbsRS7ICP1Vlpcua
 T1s8Zk8BSp1ieezIUg28kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761300898; x=
 1761387298; bh=0v7BQLntkqK7hH1owy+a6cNYKhUBtpAk+cHKXsYVWuE=; b=W
 9XPXUvr777gcyw50n5VI1f9Wzvb3T0xj2h0vQ2fmcLZD/7Y4ax+km4PDTgj/pNp6
 WKkxZV4zErBc4yJWzGW3Z5Baz6vbULVcIFPH6PXvla+XPqkQnBw9DX8yFHBgQV3v
 FBfSsnMARb9cD6U6rX095kl3EXesQQtCDPlcEo39LdEY4zXRE52IF0vzWdvYNF2t
 QoC4fgl2b+wdr/06oDWbC7f64cH723gB8b14MRM9xoOg2iYTTBWyS3o0pftpwCdE
 wmM7me+tDrvHERaZhFyiidGTjvYjNWxJcdJCvXM22RyndHwQmaIyEt44/rsNdUZb
 ll8kG73iou9MkJlwjTvxw==
X-ME-Sender: <xms:oVH7aPmB3oXC0TMknIis4xYr6wBqjLzhPEa1kr4g-HkX2z4XRSedng>
 <xme:oVH7aNwrPzeNCpitquRDWJ6Fa8lcCdFlVdOlqVYf1Rvt_AJ7qjWNm_2kxJSGAMZeK
 rZ7T44T7qJpt11Gbe-zO7oLp5Lc2x9N5nIOz9-PXeVtP0S5gFZdgA>
X-ME-Received: <xmr:oVH7aErLJYxQZhMtDznIjBI2LyRIj23hsfbbEJ8NR8ptOvYsS6zQ379p_AJIr2020Dm_jZ7l2LMKITbuF8OIPcJFww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhi
 gvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghs
 hihsthgvmhhsrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtoh
 epfigrthhhshgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohep
 fhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:oVH7aM4OwjMEM2StZCanZLeJvK21SIsF4IpK8P9ToneHV1Iw-smPWQ>
 <xmx:oVH7aLc9GZiJ22l1D8ctbmypYmhqQzf6IUtCNJECvp-4e4bae0aNTg>
 <xmx:oVH7aB4flZUOzSLa_NGzxdXMsLoi9lmPm2LYJsX2jMG5gm3KnZEggw>
 <xmx:oVH7aCsI0KVyFTLcvyWyX8Ti6aSuGePLNloh67aa1aS2wU_CSQ2wAw>
 <xmx:olH7aLa7bu_2pXvKCo-sPEQw2mRx0xb3IK2ptnynAbx9FbEvk5b5T22Z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 06:14:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v7] mbuf: optimize segment prefree
Date: Fri, 24 Oct 2025 12:14:54 +0200
Message-ID: <9617057.OUTRe80PYV@thomas>
In-Reply-To: <1d47dfea2fcc4dfc8507dd0ba3cbe6ec@huawei.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65503@smartserver.smartshare.dk>
 <1d47dfea2fcc4dfc8507dd0ba3cbe6ec@huawei.com>
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

24/10/2025 11:21, Konstantin Ananyev:
>=20
> > > > Refactored rte_pktmbuf_prefree_seg() for both performance and
> > > readability.
> > > >
> > > > With the optimized RTE_MBUF_DIRECT() macro, the common likely code
> > > path
> > > > now fits within one instruction cache line on x86-64 when built with
> > > GCC.
> > > >
> > > > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > > > Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > > > Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> > > > Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > > > v7:
> > > > * Go back to long names instead of numerical value in
> > > RTE_MBUF_DIRECT()
> > > >   macro.
> > > >   (Konstantin Ananyev)
> > > > * Updated static_assert() accordingly.
> >=20
> > [...]
> >=20
> > > >   *
> > > >   * If a mbuf embeds its own data after the rte_mbuf structure, this
> > > mbuf
> > > >   * can be defined as a direct mbuf.
> > > > - */
> > > > + *
> > > > + * Note: Macro optimized for code size.
> > > > + *
> > > > + * The plain macro would be:
> > > > + * \code{.c}
> > > > + *      #define RTE_MBUF_DIRECT(mb) \
> > > > + *          (!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT |
> > > > RTE_MBUF_F_EXTERNAL)))
> > > > + * \endcode
> > > > + *
> > > > + * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are both =
in
> > > > the MSB (most significant
> > > > + * byte) of the 64-bit ol_flags field, so we only compare this one
> > > byte instead of
> > > > all 64 bits.
> > > > + *
> > > > + * E.g., GCC version 16.0.0 20251019 (experimental) generates the
> > > following
> > > > code for x86-64.
> > > > + *
> > > > + * With the plain macro, 17 bytes of instructions:
> > > > + * \code
> > > > + *      movabs rax,0x6000000000000000       // 10 bytes
> > > > + *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
> > > > + *      sete   al                           // 3 bytes
> > > > + * \endcode
> > > > + * With this optimized macro, only 7 bytes of instructions:
> > > > + * \code
> > > > + *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
> > > > + *      sete   al                           // 3 bytes
> > > > + * \endcode
> > > > + */
> > > > +#ifdef __DOXYGEN__
> > > > +#define RTE_MBUF_DIRECT(mb) \
> > > > +	!(((const char *)(&(mb)->ol_flags))[MSB_OFFSET /* 7 or 0,
> > > depending on
> > > > endianness */] & \
> > > > +	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > > > CHAR_BIT)))
> > > > +#else /* !__DOXYGEN__ */
> > > > +#if RTE_BYTE_ORDER =3D=3D RTE_LITTLE_ENDIAN
> > > > +/* On little endian architecture, the MSB of a 64-bit integer is at
> > > byte offset 7. */
> > > > +#define RTE_MBUF_DIRECT(mb) \
> > > > +	!(((const char *)(&(mb)->ol_flags))[7] & \
> > > > +	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > > > CHAR_BIT)))
> > > > +#elif RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN
> > > > +/* On big endian architecture, the MSB of a 64-bit integer is at
> > > byte offset 0. */
> > > >  #define RTE_MBUF_DIRECT(mb) \
> > > > -	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT |
> > > > RTE_MBUF_F_EXTERNAL)))
> > > > +	!(((const char *)(&(mb)->ol_flags))[0] & \
> > > > +	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > > > CHAR_BIT)))
> > > > +#endif /* RTE_BYTE_ORDER */
> > > > +#endif /* !__DOXYGEN__ */
> > > > +/* Verify the optimization above. */
> > > > +static_assert(((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) &
> > > > (UINT64_C(0xFF) << (7 * CHAR_BIT))) =3D=3D
> > > > +	(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL),
> > > > +	"(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) is not at MSB");
> > > >
> > > >  /** Uninitialized or unspecified port. */
> > > >  #define RTE_MBUF_PORT_INVALID UINT16_MAX
> > > > --
> > >
> > > LGTM, thanks for refactoring.
> >=20
> > Thank you for reviewing, Konstantin.
> >=20
> > I had no preference for v7 or v6, but Bruce and Thomas preferred v6, so=
 v6 was
> > applied.
>=20
> Yes, I saw Thomas email, after I sent my reply already.
> Looks like I was late with my vote.
> My preference still would be to avoid hard-coded constants in the code,
> but seems that it is just me.

Me too I want to avoid hardcoded constants.
But in this case, it is very well documented,
and there is a trade-off with length and reading.

The comment starts with
* The plain macro would be:
* \code{.c}
*      #define RTE_MBUF_DIRECT(mb) \
*          (!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
* \endcode

so I believe it is very clear already.


