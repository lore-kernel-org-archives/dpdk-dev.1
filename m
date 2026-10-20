Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE127606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=eK79qMlm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bZh20JNK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4545340283;
	Tue, 20 Oct 2026 17:25:17 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 835A74025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:25:15 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id CC48CEC013B
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:25:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 20 Oct 2026 11:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792509914;
 x=1792596314; bh=5H1KbbHcdcpDjmXKztl0np85lD+ORcxyloDZoTZP220=; b=
 eK79qMlm/0cOx0JT7hgMzwN3XMYu17mJmXwJsuW0nUEqacksCLzb8azP2S4QFb9L
 K4Ee38BBLXrFLXP9t8goN+u6+3CENokuqeKUcDFAS/9HMf5kaKRRwe+zGzBlh0MQ
 xP8ZlghT6QTY2bwhDFvCOGCOUE7Rlco9No+Gei7gWd7Kc+ZgUYcpJHp395mDTddh
 iyfrXyb3uaQc3KwQULWpyd68Q6obH/tG7UqufbSy890ixjZxjY8Exsp3P0AHpS1p
 t52wF8fS371jAgQ2/XNnsgvO+FgpIAfrJ5uJXDzBA5aRhV4lFOIii3Bz5DV63QIH
 hXxe28rmmWAB/pE6vcs+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792509914; x=
 1792596314; bh=5H1KbbHcdcpDjmXKztl0np85lD+ORcxyloDZoTZP220=; b=b
 Zh20JNKPUcB+jiPPNySXorGOrco5P1EQbyfV570HgcQnsVB2cAtM42C5u1lEdRGz
 XsxDU1aPel4j3JbUEMS97PKdNNGy5no67ywMUugalM5Bhia+UT+z85oQrW6hJr0g
 MyZie8FIMKpbEAyoMUc/q+Vxswfv3r+ZGN61Ot+d1RnvtUYLdUpHVjCYQYrY6eDK
 MN9NQ/vzlUQA/mb0bFSGDR7w/q7cSOiPZvb746UZoGvPGWZVDJ5SMdp2Bscu31HC
 NGfZ4tagxGPv0Vz3c3gcty03lqE2YMzclHSpAKN3pZ2ziaWgcfQShUUL39edFzyc
 L9W/0k8d4eHA7Mwu0g3VA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792509914; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:kMQvOppPuopuDkw/VZYQKfO9cz6DdaXi1NPwBNQcajSkmcQ
 1Bbf9rzsvbjhFr2L1xmCT8U4kNOoNOuXcQOqDT3sNDJalGGAEKSHckhRpyZeGUG5
 DJ+catQXMYd4Eg6W9TSCrdei+binmTvV89CMOXqiqvLc9ntgRNDma44WmX6yO+XK
 4YoKg17JJOiBP+hXnZ79IttCmoMi70mWsn7nIPXY/Rms6Gj122EBmTaF2UWN2Ho6
 tL7U2pqv04AuTTyC8qmTPBUWSHZ0JMLbrG253P+5okZby5LgXFXbSomIIsk88iuS
 gt3MI7c24HKcI3JrH4fNl3g26oZvi+2OiKEKvBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:JSYwdOz4jL0hJzHY/DKK6xXxQGkVrrQ+G7o0oUREdwg=:gcF41c4ODw4tEgMCPpJwnBQIvQM5Z1WLahbVQqHUuWI=;
X-ME-Sender: <xms:2ofXah-gNXh3sFtZ57yQ1IIaw0idz-LYeRq5sXfxworWcGY5Xcdk7g>
 <xme:2ofXaiD075xlTIDEQPfh0hy0CRX9OuZydg9kKcF3tAvhVsk8IVOiRWi_-8qJKHDqK
 UDfVN1nSSVZsF1GkXsi1qRv_jU2K1BljuMfWJYX6aghZTk_LoKncXA>
X-ME-Received: <xmr:2ofXahy7_kMyhVchvTaDHpc7iGJmbsjGg2Dzm2scDV4Z8w5qDojK96lWbw8I_tOQDQBRLcW5YKSnPCJzbzW7uUs>
X-ME-Proxy-Cause: dmFkZTGUlhvhQLDTyhzUVPtIzrm4w8Hefhs4cNq/tQbjdei+4PIzAeQ9RbFUKmlagO+Fcl
 ILj8RP0xypPsUsV+wZp/yekmymzcz92MJkkeqGQZtnNGjrB3KgNQNACC30QSn+uImeateD
 P9aLJL1q3YkJl0hCnjJPJZgirpbiLVp7ktSjhSiqEk4wfMO3nCJJlTi9fyo7b5WW5ph10t
 3ZTcFGlu5AEmnEdXaeZGzTzSZ31pp/RWNWYG8+a5h4L69qtXia/dAU5S8gwp428Al7IRcb
 NF4tHeTgmxCXUcBzy82bq3WPSvYoa65U3OMuPqV8ctD+WPfpbPXc08jqNTBUIB/ArzFYsl
 1n6qo8g6XFOtHxwjLqj46a5lJDMZozE4Y/ajfc9nv/CRxK/yRG3OjbcrY/VHz4l2QQfDSc
 3srSkLwPiTd5TZVLkRiUbkDJcNDTcaTw4G+nsiTJ4ZlXTlMxRwTDinGXYWef0QuYmPazu5
 bgaZvk9wH4oAnQoy+JYnShCtEpSjWysgcAtOcwwSE79h5fitqQk9nzAgUHaDZOiaFqqTkp
 2VT6TaSeXeP5Ci+TyBv0xDxVgfwtVzPLpLVE3tpAk1U4v/stypUkR6wNb6/l6xsve9cskF
 UlJzo2dEu5WD4r0cE2jDWRYwPzuAKVm4UY7/bj5PtZOCMErNfsqN3kiz9umw
X-ME-Proxy: <xmx:2ofXanRy9G1A-9wmfLat_JFAn2sUpVOvRzAI3TM-u36TH940JtbhQQ>
 <xmx:2ofXao_pIb97ocasMDN9GiqIKvRNksEnLxrFrBqSNwWqmK3-Y8x2vw>
 <xmx:2ofXauo09VJ38wNF6fBVQGdPtrj4FhK71ozzRNQ4eFUOyYWrLvLDNw>
 <xmx:2ofXallBcD2L9fN5KGlXPz2dhXX1fjrS5vPHNHhb_B04oOKA-rSJJw>
 <xmx:2ofXatgHM4bQCb8ZHiJ4EZyTaZ5Y5OQzroQPzF_03ebELXcxJDffePJi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 11:25:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] maintainers: update for next-net-brcm tree
Date: Tue, 20 Oct 2026 17:25:11 +0200
Message-ID: <lRZjk3DyTXKk4mD6lIGtug@monjalon.net>
In-Reply-To: <CA+BST0mwb_r5JnNJBHzoYaOtYWYxoP1QveQjVzXCXwmCDiefwA@mail.gmail.com>
References: <20261020095133.2811576-1-thomas@monjalon.net>
 <CA+BST0mwb_r5JnNJBHzoYaOtYWYxoP1QveQjVzXCXwmCDiefwA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

20/10/2026 15:41, Kishore Padmanabha:
> On Tue, Oct 20, 2026 at 5:51=E2=80=AFAM Thomas Monjalon <thomas@monjalon.=
net> wrote:
>=20
> > Kishore is the maintainer of the Broadcom tree
> > since DPDK 26.07 cycle.
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> >  Next-net-brcm Tree
> > -M: Ajit Khaparde <ajit.khaparde@broadcom.com>
> > +M: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> >  T: git://dpdk.org/next/dpdk-next-net-brcm
>=20
> Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Applied



