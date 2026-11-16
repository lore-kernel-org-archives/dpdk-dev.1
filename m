Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D3606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=nu5bow2E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZdDd53Pc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03D624026F;
	Mon, 16 Nov 2026 17:00:27 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTPS id 663AA40150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 17:00:25 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 667A5140006B
 for <dev@dpdk.org>; Mon, 16 Nov 2026 11:00:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 11:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794844824;
 x=1794931224; bh=BBSJVEPyRUw0sJ0cmNVrHrtpDkfoSlIX5RKPpGNzRTk=; b=
 nu5bow2EgSQJQDPVODTaFsL3pzg4SRGVm5FauHH96CEQS0Ku4Ax1BciSzYDPr+AS
 Hj79glag1PYXvMuruEL7m5i6vpZFWsr0xpgKAwUeFzWLL+PjdghveqFeg6z3XYfu
 G4XEHQSZ0sQMyg6Z5rt7iL0U7jIWUBSPij1Br3PXs6cD94hQ3DtarbzXIYPLGqcJ
 TbbNhwK/3uK4BL0jUg8aTgANQ9iQpkCsA1uE/B3IWSzCu21JbdENQF03eq3sysZ8
 1EUaoY+F+DCJV8CR8vn85KhDgF1up3o71wJTcv6dpYSxlvoPlZkJhAYBE6aiJnH+
 aqkU9iBtCcTI8VjxCXxW9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794844824; x=
 1794931224; bh=BBSJVEPyRUw0sJ0cmNVrHrtpDkfoSlIX5RKPpGNzRTk=; b=Z
 dDd53PckPuLSMVWuJ3sZakZ5ctKlLR638funFe3lWLZYHfIKlQ7IbKoNdSF8MEHT
 mgC2/Tz8SUJSqsgfmCqZvKMDmzvPrx9GMLI3bPyFdm9rwbiGnr1ZIf0W5VtzjIZY
 aVD9+CVYI6wRJrcbxMYUGoIw5izAW8Lwmf8teVGFz3r05KuVvtC7aHSmx5Qxm+7Z
 h3p84ZSLAdh1SF2ZKwK4/c1RpOT6z2kfrNU6tE/DDsdhUDn+ckbnUk07gVeV2Asm
 NmI51nlebVxqTOcT7L2Ni9/oZoVUyEbWLP0Khwjf5wAereE8WiYwLSX1zzbbp58T
 Rl0spTlnvN8DZGebBK+Yg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794844824; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:ai79l2GUUw3eQkqbhyNxnNzWWGaA6VbasQSIe+ZH/V6b4CW
 7Mh40nFR4jB7bjh+GKpwB2k5BMLreY1On0/rRNtChNErn2Zf5RZlKcTRQUumrUav
 fWnctpaz8k4077QPIDU0n2ZvxfnCBmT3nbE/sh5bSW059UQ/iQRZffYzmxzm/f7Z
 m4+RVggd6u0p7X0o6Rd3XUOG55jKzYpmdnSIvSAMRi+8n/6j/DKw6mmm3tJAEpBp
 yrt2Yc+xtDsn87Fdg1FWCa/5IiuHQyUQfgXPmyie+MNFsZT6pXSnipNkUNVmw0e6
 R/30LGZThmonXC/FYjezy1MPr1Py4EC7m5+NeKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:xopCNNweBgMONUONApLtsRRvw7+RfHGbjbsRVerdFKE=:wa/6Sv1x1m932bkTtPYqSkntytn268dAgfohhV38PVM=;
X-ME-Sender: <xms:lyj7aiDs-ag4ir8cwlCyAPal7tYGTZiCPP5hMEKjOeHUfz-WJNmNaA>
 <xme:lyj7asrKn_TtKaiBCXjfLvdYy6fbrDq8xvmoVqfwrR6z7xgIoekX8UGLZ_F5qXwTh
 NzX_SoJFOk8SXBQfLkdOP1J8Vw8h9Rur9dInWvtXtesaEMLVrpZtxWl>
X-ME-Received: <xmr:lyj7atjdRUSN7kUXgoZm3LjksLz5Wbt7ekKi2yiQ4TcKCnoLZxBjwUiEoW04FWvxXw72OFgFP7bxasSEb57OJiE>
X-ME-Proxy-Cause: dmFkZTGJgyue1OG1+2YyTDl3z21N5KSwnAI3mzowDSDWGAXBpK9XJ+m6cCVijEVdaslnmA
 ZV1sDqn9qQPQjMuApT9BSCXZ6J5zGCQvh0mUZ9uh7IlGqtJolLnL/MDEqC1UQVAnTrGTVb
 u4eJQLpTCIxgu7bpPVVwg7JZ0+Af+Sv0VfJo2hEK9enJATH98vJskG+Wv+5om5tJN1Rwwy
 NrRj95VeVxz572McjRGYx2dqBCB4HsxySRNDi0oRL6YR6gBIcIMpoCeIsaoXQWkNY8QZY+
 SL5/hdcu0v1yty8kXYFclFmMH91X+YgTxVCFz/iI90nh2FUF82GCqGD53xWxdviDCeCNE3
 Doo86ZNm9oZJeQIVFuXyBiJZNAkV+gHz8wJBdRxJwYrYEkrWTVPnsJGz4hfxy86zrcOjGa
 5ScCBtws8SzSilKB2V8WDcsAef5teWQOD3FTqzccaqtpScwiBQlh/fG6cSVc0Oig41jELl
 vGytgun5gi9nKLuwo71lUYTRlvQMSN6ziKg4QyEnLdFDCF6+Z+HQw8KFrEhksb+laRr2wl
 5nDidik+YJZE/YHDfwK6aSfcyoN4OZlTxtbNF+mk/+7PwOzpBiP4cbJzq4jcbjyBXZmaB/
 aoKYyBN3onuNrsDcVvsR+jr/ywkbSQCjduarNy/pT5uVwpkgEzgJBmiJYnLQ
X-ME-Proxy: <xmx:lyj7apBFXg1EkI9cOxStwhnbgP28Ar32NuDntS1d-cXa-ftEDYg9lA>
 <xmx:lyj7aiEMTdJsyXHD5f2ARw_vQ_l73r_srXvI-lLfWdPCS_N8vB7G3g>
 <xmx:lyj7ahLeP2m1sVW7WlwvUk97_rbhAzHaSILfm5bDEmnOQRNXad8s_Q>
 <xmx:lyj7amnvjjMh_UZSNiVpCvBQigRlCDh5pKYLm07SoTBCHDZSyOV_JQ>
 <xmx:mCj7apodXwWFzgSUiGjmKcvC0qpTElNP5rFcwsTQ8ryMUNPvZlJ2POZn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 11:00:22 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Cc: david.marchand@redhat.com, hemant.agrawal@nxp.com
Subject: Re: [PATCH v4 1/1] bus/dpaa: fix unneeded conditional in bman_release
Date: Mon, 16 Nov 2026 17:00:19 +0100
Message-ID: <q-i_SV0SRL2NN8wm9QvxNw@monjalon.net>
In-Reply-To: <20261116040635.639732-2-g.singh@nxp.com>
References: <20261027093335.4109017-1-g.singh@nxp.com>
 <20261116040635.639732-1-g.singh@nxp.com>
 <20261116040635.639732-2-g.singh@nxp.com>
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

16/11/2026 05:06, Gagandeep Singh:
> bman_release() computed i = num - 1 before the num == 0 bounds check,
> which only exists under RTE_LIBRTE_DPAA_HWDEBUG. With that debug flag
> disabled and num == 0, i wraps to UINT32_MAX, and the subsequent
> 'if (i)' guard is then always taken regardless of num, relying on the
> for loop's own bound to do nothing. The indirection added no value and
> obscured the num == 0 handling.
> 
> Drop the i = num - 1 initializer and the if (i) wrapper, relying
> solely on the for (i = 1; i < num; i++) loop condition, matching the
> simpler pattern already used in bman_release_fast().
> 
> Fixes: f38f61e982f8 ("bus/dpaa: add BMAN hardware interfaces")
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>

Applied, thanks.



