Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923A606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=QbjqB2ke;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RbTMFprF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E39D840285;
	Tue, 10 Nov 2026 14:56:27 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTPS id 57F6A40281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 14:56:26 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3C6A17A024E
 for <dev@dpdk.org>; Tue, 10 Nov 2026 08:56:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 10 Nov 2026 08:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794318984;
 x=1794405384; bh=gY6L1sZ71i/JB5w1AP8ihonuZ/ZtNYSeHUGx9Caqd/o=; b=
 QbjqB2kegfkZoMFwoK2JolCFlAPDdFo8LKhzsUICQe8+zppvwlr5/iCOgNE3Mlja
 EJynGasep/K7H3k/OkFICp5lScQBasiaMpNL406XM7VsvZQBCKX84NEt0Vohqha1
 e4Axfh51kU+m86cWKf/DopSHtA9ekxWyAyu0lzCg6AiOO/C5VZbGY0T8V1MgIObi
 Obj2fzb9Yy5kZnWV7mS0ml1DogwfRoi7HjBOeRgfV49/9l3gbXJ9LB/tMJzBAgdH
 GZdsBWktgkRpr/N6/7XzrDCkmi96fjvYFi0yu+oPzRDHbiBL24IZWnxFqUv6YkXv
 kENSpbftPz/bbU0Xs3z8Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794318984; x=
 1794405384; bh=gY6L1sZ71i/JB5w1AP8ihonuZ/ZtNYSeHUGx9Caqd/o=; b=R
 bTMFprF+57O0Q9+LamppOYjYlfWP4QHCFflgUqpAosCA+jBN0SRFoTTg5YJWha6s
 IL5gYZfmE44SildZj1veAI2A7VcK84LPok8GqY7sYVpo4qyca4PFYx0HgtwmKXem
 IWo5S/+iw16WqtZwXOwIKhCEuM+bMxPTpnKHhEV4MSsWX6i0i25FUe6JoxqshayK
 ysVubbhuEMLa4hzS7Z4yl/+rFHrbzBfH078d/ssXOi9BPbVvTggMQxy4cEndsI3q
 HygPFrvAL5U62xUEV7Cb3FpcdEYJskg7Owe4TfETd07K+77mrZ43Al/PGOx9yj/R
 yQ4BZ754EkYQscHdzW28g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794318984; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:Ce61qWmiW04Csltku/wcaRvWvi/kAn+mRICofQ3Fk4HYC7q
 OEQdO8hoIPzmVzgSN5LtJhTglmXAHd66puwzAUCbD5iOGqdJ3MVQqJxwf9YyhENX
 Vd06qb57AMtl/i2jCfCkMRBPP61vuwhN8ytqYdlVwEl/Jw4TFCNjt2amzhFdvnpn
 3wY4aD4dYpGBlMMOmUSMCs2efDdc8+TXK9qgsvHDYh1aQrEfEXbsMUShrQ3REoCp
 OEpFRyCrYuQS0PWIeG05IfLdNsPrYQ5zCWtGYI28WDC+qM/RjMNdGQeO8hC/SYLf
 QkUdNV988DE5NT+VQPm6KZiFmWgYxfk/qi1ff7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:azyaG5OajNoh29F0137xiIx9E5kkIutDNQzbHzZ0Pqs=:VR16RhNQw5yNRgjG1+ONJ/L4wrgPjbkdbKbAVYUQpjY=;
X-ME-Sender: <xms:iCLzakbieFiz1l1Ht4pCc6wXVY3tQGONwQmlN32kuhBsNiFt-goy1g>
 <xme:iCLzaqVaeyIDH22zSIc1s_p6Ox-H4H_SeP8UgZmU12ZYNtxjLFuGgOGhNb0is98F5
 r-_JVR5jfNAC1G82PxANQzjq1KxMk8ziknyVU4OEV9Mowno0pNaeyTZ>
X-ME-Received: <xmr:iCLzat9MGjavsMz249OrC_0hqHSuXgb7UqVn793WV09CHRqC_FpR9XlZo_6PzzrKbsc4oxOgWoQXVRF1unAA18s>
X-ME-Proxy-Cause: dmFkZTFF88O+5Fv/9Iynqgn173ZtA+N2KGlE301EciKbJLp9MIwjDAGmKXoN+qv4I9lFYC
 U90TTrgewHhyGhe/by2dp6XsSEJfV96Zk7+KWvTwdP70jA+2muEvqwtntmMEc39siRsV7B
 NUR1HVqvHPw/wOYOMPNvZJRE6NCG4FfL0bBG9GUh0NzQikCaqN884tjYr1fAVrYGRhJCE9
 7ehn7IrMH3kRBwIWlieBvBahi4PXTlT3CooUyA6tA6RjGi1WqQEBQsyekhrppPbKp1IiEm
 SF41M4wGs59GVhFqktiYEYJvIy0YA9hJYvYcnRJiBcuQL5hHA/C3slptykwfy0TYLNkUTS
 lmg3V4Qiw53rSJKyx6YFblmZhsg081PFDyG71Zy8E3JMBzjRrFkAqVh6DzDyhXy2mZw14t
 wcwNwwLDe2eqi6IpOGAnD8M5Der8JRfUTDppzp4C4Vb65ZroWH8zR5jIBmFN+Jn5iWVXvF
 4brZu+VFn6R7vpPab+ToM3gHl9ew/PtMZSUgLHF4BdTXOz1WXNWxHyOGcdq5YbU1JGB4LX
 E9+60BTAWd7/Mn8A0CglhL2mplkpeitvoZ1OaHzBO5iQ9IgbBUpjnTMHmgo5rTFamimaee
 WNN9gl0fS3SxNZB5NWgtlYHSTk7vG4hMMtsA4szUg35gESTeGIZZGkng7N9A
X-ME-Proxy: <xmx:iCLzaj8Zpeg9YqM309Zz7ewI2RtnRrmJ2KS9tUInqx77_N1c5br8nA>
 <xmx:iCLzatQ1Ujb73Beis5jy8Ru2SzHaPzhsj1ljxHI6GMXptCWI7QnmRg>
 <xmx:iCLzanfRfAMD7oacuLInoaKBre03beFS6gcg5ziYRs3GkglRkxRKfg>
 <xmx:iCLzahDuvjNVaoQdDaVY75eoB_akxwUw7BhbcMtpDafXWaPvXJwyIw>
 <xmx:iCLzatICUpifHUj4hxDzvKrjMpI8buWC2dDLvUcgq2WjNs7YKHpU45WR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 08:56:23 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Kevin Traynor <ktraynor@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v2] net/af_packet: fix build with old kernel headers
Date: Tue, 10 Nov 2026 14:56:21 +0100
Message-ID: <zmh4QzPKQvWlZHerQoYLhg@monjalon.net>
In-Reply-To: <be84046c-8071-4fee-aea0-234b772cc91a@dressler.pro>
References: <20261106142756.241131-1-bingz@nvidia.com>
 <O1P4UruZSlqFOdl0F9QGXA@monjalon.net>
 <be84046c-8071-4fee-aea0-234b772cc91a@dressler.pro>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

10/11/2026 13:52, Frank Dressler:
> On 11/10/26 10:39, Thomas Monjalon wrote:
> > 09/11/2026 18:47, Stephen Hemminger:
> >> On Mon, 9 Nov 2026 17:47:30 +0200
> >> Bing Zhao <bingz@nvidia.com> wrote:
> >>
> >>> The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
> >>> but it was only added to the uapi headers in Linux 4.20. The build
> >>> fails on distributions shipping older kernel headers, like RHEL 8
> >>> (kernel-headers 4.18.0):
> >>>
> >>>    rte_eth_af_packet.c:1057:41: error: 'PACKET_IGNORE_OUTGOING'
> >>>      undeclared (first use in this function)
> >>>
> >>> DPDK requires Linux 5.4, so the driver does not need to support older
> >>> kernels. Check for the symbol at configure time and skip the driver
> >>> when the headers lack it, instead of failing the whole build.
> >>>
> >>> Fixes: 3db7aa7868b2 ("net/af_packet: use kernel to filter single-queue Rx")
> >>>
> >>> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> >>> ---
> >>
> >> No. DPDK should just fail build on older kernels.
> >> Since current DPDK is not tested with those releases, anyone doing that is
> >> working outside the tested environment and has to fix it themselves.
> > 
> > We used to support some old RHEL versions.
> > Remind that the RHEL kernel is full of backports,
> > it is not exactly the same as an really old kernel.
> > I think this solution disabling a driver is acceptable.
> 
> But does RHEL itself actually have a problem? I could not find an 
> incompatible DPDK being shipped by them. DOCA ships unsupported DPDK.
> 
> If it is RHEL, Redhat could add `-Ddisable_drivers=net/af_packet`. If it 
> is DOCA, NVIDIA could just add `-Ddisable_drivers=net/af_packet`. DOCA 
> already only ships a limited set of PMDs in their bundled DPDK.

I don't know why you insist on DOCA, it is not an upstream concern,
and was not mentioned in this thread except by you.

> Or is this change more intended for third-parties cloning and building 
> DPDK 26.11 on RHEL 8?

Yes my concern is to allow building a new DPDK easily.
But I am still waiting for a confirmation from our Red Hat friend
that RHEL 8 is still a target.

> If RHEL 8 must be supported, the documented requirements would need to 
> change then to say that features of Kernel 5.4 may be used but the code 
> must still build without error on RHEL 8, or something like that.

Yes that's something we had in the past.
This has been removed last year:

"Compatibility for recent distribution kernels will be kept, notably RHEL/CentOS 7."

Does it mean we don't care about RHEL 8 users?

If that's what we decide, I'm fine with it.


