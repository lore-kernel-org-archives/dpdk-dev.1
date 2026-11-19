Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF36606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=VZvGGJ0p;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GzHPE2K2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE4F402D6;
	Thu, 19 Nov 2026 15:47:08 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTPS id A71F0400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 15:47:06 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id C35FC1D00228
 for <dev@dpdk.org>; Thu, 19 Nov 2026 09:47:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 09:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795099625;
 x=1795186025; bh=PnWLf78KjAfdDK5mfS+WoALjkdTxHMDqEH3XLus9JNg=; b=
 VZvGGJ0przR+kHTy8Af/yW+AsjfPMtMd9NHrEgSInrb6lcddNsVE3tmA+Ej81shV
 R9DjdpDdK6mO+p1D3Awjb3tQJejW3HI4s7Aa/2pOtgRxQUnQMgobPxC6fB+JfbLa
 TT2r+rPmIcftF3y5zcgxp5CjVhaqnoRR1rs41RNO1crdBTFwQT/nnbq7z3xHD+YD
 PIKulUjon2nBWQtPmcN4eKnBcv70XI//bQailjVJSPDcsq8uOtq9SIKBYAkfE5Tw
 /uE7jhyDwOzjzQYRm+mHP20dM4K0Bi2sZoX7MKlF63q+l8ThHXgcECmPjMHvOqa3
 M36eK2TE93LbZAZzEqR06g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795099625; x=
 1795186025; bh=PnWLf78KjAfdDK5mfS+WoALjkdTxHMDqEH3XLus9JNg=; b=G
 zHPE2K23iuZtqUoAVznbiNgNYFw/PWeEnQ3CsZLGfQoIQefPWEhcR/VwTgTm0FAB
 w36S0/LGqiv/jZ/h/MxvE8vh875j8R0Xc/XKTpV9nke32BGT0lOcPLiPg/BHWpoQ
 BHewGtDJCCcm/omW096sPVs3aJqGMAGhy0clgzQPW1J8qM7gnYna2eO9dQNgtOTw
 47Y6x9HrBVFPSDhem445Cvi1cXRCGWzY8YZOfSg8W//pRgckElQHExoT2r6Vbwnq
 JN935IaXpEvY1SLmJOkrfa3c97OGhiSbIEAjH7fcIWLMjc2C8GirGCzud9N7vyCT
 Az08W3qbncv/wXpqQ/1Yw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795099625; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:0wfFrhE1OkvFB3MushyUQYVvQ8km5Gx5W6f+B8cw83Om38z
 cnszXCAuBBGt7FRI6yRHATUO7Xx3cbHsKbll6POT6+xPL2Htw1KtXINbzG6iYB69
 x2fy2TBNgv0ihty+2r5LCWyMWuanY8nNUKKbLiANELeYKxV4J/pbrlRx5LvwET3U
 2fMbmWs9ntMXhFHObZTdJgCATBHt4xjiCW24pMXH6QuE7AGe2YbLha3J2VLI4SB0
 Gn5XNHjiyA5wTkmdUkY15o5lw9W4F/KHMQ1Vlvmic0Y/1xmtOrXeiDguQjfSZ/jv
 nRp/8sM+wI9idJe/ddsDQ4ownVjTYmz9bUZS3VA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:YXGTrul3xklZNOH0WnJsSAmt4xHvIPskn0gC/NHKFEk=:jegZU5u769sEkVfUTW+H6oGAH0lYzENRTF0VIqSSMoM=;
X-ME-Sender: <xms:6Av_an6apMBVyLpU0keXvghfBjemg3uw_-H8uFOo0S58vfSXXyzWCQ>
 <xme:6Av_am9bWOvcNLYyA92FFUT2Fqjl34pZ5cj_J_QFpzlUTD0nlsMQTykZUfbJLqMwg
 YgnGF7nylXFnpEwe-YGZ5fRIoZbEVS67cya6XVydZREUnvC6I2pMxA>
X-ME-Received: <xmr:6Av_auUD85aa7cclVINX2V8F5srA7rVLWaGa2c7_mHKr1f4kfpfPNfK97uvhftVX6_yg_0lULe7OKLt-d_VudJE>
X-ME-Proxy-Cause: dmFkZTExggthEgaR4WZjl2xfdVQ5CU6+VbtyhI7zr2R7c0vey2wJHde5jrOkuuX7zg+Jat
 8KSrJH3monuUH/YW3IIs5CO7AVXVvS6DpkhLWj/6QxkYiiZSF6jzTpvfVTBtg6qptt1INB
 VGS7Eox49NffySuo9gIm+XpgA+TOyY8QnzCnVBzCP9MfMTUwJPujhUmXoL1215Q6+Un5SO
 dp2i5kFQR8VJbU6/LwHHOGg/c34ZtoFJbVUPV2mm7wFQei6VM3RTGGkO0JsNfR9QwyInmU
 JqBFf1p4UFYZLR10Mx/mniiI2dF2xZWyC1oM423AgfIjde6VjlW1myL1S3ORiIFVWxsTU/
 YvAA6y9904L2+27OqIuTC7dxv6f1Khu1qLzODZPBLeAoOk+uQvm2SCGxfyBX57MF1ZULq8
 RthHRqS3U6uCqxH6SlxQ22FNgIy/jfonrFQHXv2s4GB4QMaWLdx0+vPRqao/AEda4k/hYi
 1pZuMp5VBXCgKUrb3dCEVem3D2j7acG0Bm/P5NZkJieXA3lmFHjWf2cQ3AJhjSiCABhtUO
 IzuD4K90PZqSa4dzLTOSosNhoVI/FwxsyKpOtRvPDQCyFbHFH+0IVnc+hUQ8/5sd8qR8Rx
 tAgeCUR1/cx+9fhSiy73dHh8DuK9FQuDt+OswQG/YASR3u3vzTnJILxLljxA
X-ME-Proxy: <xmx:6Av_apphfVYe-1DzkZ9hvpRbq_8Teh06yCssKNl99_p8t7c4zRnedQ>
 <xmx:6Av_aomol5IPLCL0vvzUt1f9p9j7g43H3zWJrZOmMTgUjPMKNAMxxg>
 <xmx:6Av_ah32Mk2m48bNpVhJjnzTotL8IE1b04-XyFTqKcIzbDjXBQyyCQ>
 <xmx:6Av_atRmy9i7IHmJf2vlE0lT7A_0_QG0m3AJsxHMScCXSVOoAWju4Q>
 <xmx:6Qv_apAA5PvIvPD547XmJlA4NfObPknTZDR9QlEZoAXstmw9Dc_u5KIb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 09:47:03 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robert Sanford <rsanford@akamai.com>, Robert Sanford <rsanford2@gmail.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, andrew.rybchenko@oktetlabs.ru, olivier.matz@6wind.com,
 stable@dpdk.org, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v4 2/3] mempool: fix dump of unpopulated pool
Date: Thu, 19 Nov 2026 15:47:00 +0100
Message-ID: <hJsCtzRYR1eG3PZiPV7p7Q@monjalon.net>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65B15@smartserver.smartshare.dk>
References: <20261109144054.3784583-1-rsanford2@gmail.com>
 <eexnNMGcSbWMwzjgikVLXw@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F65B15@smartserver.smartshare.dk>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

19/11/2026 15:18, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Thursday, 19 November 2026 06.08
> >=20
> > 12/11/2026 16:43, Robert Sanford:
> > > +* **Added function to check if a mempool is created.**
> > > +
> > > +  Added the ``rte_mempool_is_created()`` function
> > > +  to check whether the store of a mempool has been created.
> > > +  ``rte_mempool_walk()`` callbacks can use it to skip mempools
> > > +  that are not populated yet before querying the mempool driver.
> >=20
> > If usage is internal, why exposing this function publicly?
>=20
> It is also for public use:
> If an application walks the list of mempools using the public function rt=
e_mempool_walk(), we need a public function for the application's callback =
to determine if the mempool is created (i.e. driver callbacks are initializ=
ed). If the mempool is not created, accessing the mempool driver is now all=
owed.
>=20
> >=20
> > [...]
> > > +bool rte_mempool_is_created(const struct rte_mempool *mp);
> >=20
> > Any new API must enter in an experimental first.
> > But here we may not need to expose it as an API?
>=20
> If it is marked as experimental, it cannot be used internally, and its in=
ternal user would need to implement similar functionality.
> And since it is a simple function, we decided to skip the experimental st=
age.
> The alternative was making it inline; but it is not a fast path function,=
 I preferred not to.

Oh I forgot this constraint.

Please add this explanation in the commit log.

By the way I assume it is too late to add such a function in 26.11,
and it is not a recent regression, so it can wait a little, right?


