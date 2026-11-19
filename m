Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39944606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=tAAKKXM4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l7fQGO5h
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE37C402D6;
	Thu, 19 Nov 2026 16:01:47 +0100 (CET)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTPS id A91B3402D6
 for <dev@dpdk.org>; Thu, 19 Nov 2026 16:01:46 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7DB077A016A
 for <dev@dpdk.org>; Thu, 19 Nov 2026 10:01:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 19 Nov 2026 10:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795100505;
 x=1795186905; bh=QJQDC9V/XOTaOUbZW/I11UTx4erjIwV1VuOpzdPjlEA=; b=
 tAAKKXM4lqQdg9TfsQlqE66L0X2mITbYkaGeWm2tK9nwG6JgO6KMN8elwq+TLvqQ
 2VeYXipMSY21CTD7/qoOSrHSCDxEnL70iysL8B6zrKKdclm0Yhn7KAUZhJbo42zc
 YFUtt25DrOa5TqKhsO/N69tXaj23v3MjOQPhcMtNwKJkXchK94sEXze88dlYKk+F
 Ov2yw2Ac1N3CzJFJxTYWs2/cN2XqhN4FbjvbVxoMF+DxLaZbVJdtfeU34ri36aDp
 IuBOA4Qw7PRmM7Va1jBrZpG5Db3dcYU2ICGNepC47UCga6kvA116Vl4nvIruH4nd
 pr1/HH0jffVNKNSwPvUenQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795100505; x=
 1795186905; bh=QJQDC9V/XOTaOUbZW/I11UTx4erjIwV1VuOpzdPjlEA=; b=l
 7fQGO5hTn73GdBv71JPFD2l14Qe0r7Z11jRaXB3Jcg9o+Z27pEew+fC3OMGMsrmW
 K2wxk94bbxazZ3IVo6kYuzjghDCacCvv0PN0C/YORuVvZmqbCmHoasXdtDc/CbzJ
 Il/NtFOE2q82rKzMmuUaA4rCv3dQ54GfZ0bSjNx45KeIGyE/xBUZNyoGwBIkGQO9
 x0438muW8kpdWd3YOW2hUfiDtbFDUoMcu5W4Ino0iZRhlwv882E7GD7ZSHuaDbaW
 RojF03WSEYAl2jdoe39x0ubW1aaJk+mqytkZ5cVRTF/UWgXeOBD1iwGkY+IFOW07
 UrgJC+wZlFhL4vpzSGZ2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795100505; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:fz1BRMhfAjJxPlZNefx7SWE0Coz060gkDHCPW+NYRuLZ6CI
 p4uapYM0N1jm2VyKvdhVbe8Lg+uWbWB6Cx1RzOkNoxh5RsHXsYQ0RRHkjSZjLk7B
 TkTNuUs9k2Fok/dkPS4iER1C7Ed6RMImmbLiGePNX+vyTAu+GjmSkEVFNPSePXLw
 X5d/BXvGS81KgINB7xo37I5G0DgGB3HSscUaRxFbGViH4bFHBDRKKCXCtKmZo7IL
 x4P/GOlRgtp1I3CGclea4jVxJ18H4TtGrfVre1/eebQCDbwBwf46jUZ2npFE7/Oq
 VPVpd4jGorvO/LGyveDFm4Xp18nasiTas1EWVZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:yJ07601RtrbIGv23ecOJs8r1RZqwqdmalmAdt5uzDYI=:QJQDC9V/XOTaOUbZW/I11UTx4erjIwV1VuOpzdPjlEA=;
X-ME-Sender: <xms:WA__ao2BEOui5lN2mDmOX1lOpw3YxmRtDD6co8eWPLBMBcP7zjJeeg>
 <xme:WA__asAwZKIA8xbLKUUaw62DPwWX27lhO8ZiwMu_7J6evhIFQKOhpSwYYqFkdBRs5
 9NcV8YIcmrnQKF2dOCvtDPOgSzHXo9dHcf7bELjLyjF7grriUIfyGU>
X-ME-Received: <xmr:WA__aseJru8UyYcgI0zfwjAuxszrMmEmqlI3EtoMA71Yquq40hSe3FLEImYCjicgCcJeH1BtzDj5yIpEzsMEAB0>
X-ME-Proxy-Cause: dmFkZTGK+IUm5DrxDZlv3wf5CMEB7Uq7Z22OaY2licePxU0B8O0UPjaEG/jQ9IW9sdx084
 PMxBD9icWxpXTvXIwSHQwWVQLnAbHGyAHPT98EXC/diQhggzAi2+8lzSiKJkKJiSsjImae
 f7HfoEYeLcYzF/Ic/4qulXMf/jn64D1o7ojC8x5y7/xLPE48xSsOUm+uuhAx1DmS3m5LkJ
 BGF7KQSmYAJ3xrvH4I1Wn2JQFWi7b7vjkYVaQD8SECLk333wEiA9isNZSiU18Ibps0sfJ8
 V5vez/N/WxqtR0WxPxlEOVEMxDXkiLRSAa5P5E2ElqO5zNCV+8QC/zNctkEwM5L8UgD7PD
 YuLAhlpnm/aneWJMfB6NGZh4MXwvFjD/b6TGu96jqzo4owOn9i98Kbd2vTOWF3SuW4yajw
 KNLXwsbNQcUTLRyTOtKNPNlhoeFmg3fpDZi2DKHaDfRntYkTSBXTWfmJMbaUR1FRD86lHu
 stviPuQY4NvdcSFuXOP0Amtro7TeTEgEnTDYRQ415GZSgwmFQr6dBqGSt2x1IfbqOJ3vEW
 9jPFPEdbyq9+QEouFM0KLsTPI6AzenWz2BMwkAWzVihWGQ8CJHkNdA8AKzz6E6YR6PjXBd
 MYT/Beq5wZ+GFFwCY3QxylIBBJzYRJjEdZ0bonL7yAXlS62vc5LSYIF9u2gw
X-ME-Proxy: <xmx:WA__ah61_mkJaO1-TbSfx0CGWoLUDyOX01onP1gMg5XDSN1kKMYzDw>
 <xmx:WA__anVslzyRn2j2dRzcHeQ8e9Klct3os_6dBacjKD9Z3kgpihkXCw>
 <xmx:WA__ao67sy3KNYs2ZbLl9E6yJInDTu66Vzupiz6ZZNUmgJDl3Wfpqg>
 <xmx:WA__aqo-ZmF00edZWN_XHZZoV2bQplKw4Kd-uIIB6UMh3XGmwXhAdQ>
 <xmx:WQ__aiExSmxOS5tDocdx7ySIKgUBQa7WBpFebXHdFp9lv-1nj7XBQb0W>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 10:01:43 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, iboukris@gmail.com, Harman Kalra <hkalra@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] eal/linux: revert eventfd leak fix for MSI-X
Date: Thu, 19 Nov 2026 16:01:42 +0100
Message-ID: <BHX7Cm4TSSWlZ6C8vcQ_DQ@monjalon.net>
In-Reply-To: <CAO55csyAJqhU2SRsfXqo==TjVUX-nHR4Z5bKgu8RXf93ErJ=3Q@mail.gmail.com>
References: <20261118152945.1404317-1-david.marchand@redhat.com>
 <CAO55csyAJqhU2SRsfXqo==TjVUX-nHR4Z5bKgu8RXf93ErJ=3Q@mail.gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

19/11/2026 14:11, Maxime Coquelin:
> On Wed, Nov 18, 2026 at 4:30=E2=80=AFPM David Marchand
> <david.marchand@redhat.com> wrote:
> >
> > The event FDs leak fix looks correct on the principle but it seems it
> > was too soon to take it, as it broke net/virtio and may have broken
> > other drivers.
> >
> > Revert this fix until we get a proper fix and acknowledgement that
> > other drivers are fine with the change.
> >
> > Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interr=
upts")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
>=20
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Applied, thanks.



