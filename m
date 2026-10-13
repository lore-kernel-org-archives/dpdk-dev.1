Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D105CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 08:36:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89D0740272;
	Tue, 13 Oct 2026 10:36:54 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id A2ECD400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:36:53 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 1FC301D000AE
 for <dev@dpdk.org>; Tue, 13 Oct 2026 04:36:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 04:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791880612;
 x=1791967012; bh=Nf5v/v7gG1mJEQV39pVAr0ZxfWmy0QNeqRk7mAfjkSE=; b=
 DWGcNl819jsMI2oiFdHoJwgavI3Ws8bYA8BJznTq5/1TXL140YBcpQTMErFhxgGp
 vd3Uun/kFyycGoYa8b45qrGNee1CAEo8KRNu23iZoelWrlAOgplye42qbvPKuJKy
 lROhoT6M6yHAf2gvKDo+iOScBCgNYSiMmjb1gc8224YWLTgIaxx+4kRi5NjZl9No
 PI7dHvHjWdRmPgG3OA6jsq47a8urdONxSApQfmC09GdT7p7dfnll2mc8Jrj+5ODC
 qNwKDqYGr9eZAfsnnjiTxxF10cssakB+aVtqYa+1DTtKJdPb/udNlzbANGSWO8zm
 q1SCFddir2cUpnkU7RFE0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791880612; x=
 1791967012; bh=Nf5v/v7gG1mJEQV39pVAr0ZxfWmy0QNeqRk7mAfjkSE=; b=m
 GpQbC2Nr03IJYdLYZlT3FOOvqaxuvp6VEkWjogBC7uRHou+F7sRlsEJt6E/oXKdw
 eM++EukLgQB/KkEQkPuusOJ83qyWUsi04TOko0L9S+DX0u77u2rx/YWlvpnCJYI/
 K3P/kG30hbsySnKjrHVV4remwqZyUCxhdvBM7yBAn7Oe7Nw6MQPM406ly2j6GJC7
 944RAWacuPiSEZA9L+oup0b04V/X6PP9g9jGLNaWyb3kb8PcDjbQej3cjhcwIt+x
 LKj1N2zRDEkFbaf2/GRA+xZweOtaKoz2OHU4cAewV9RlUiLaSWS+F0BZ6F4UPeeM
 AnYxinsM5eMFYWmgDJFvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791880612; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:M/V/vJeEGGYRvSa/qBuvtDaiHQa7Oza8vGYPdSeKl7FdIfA
 Ny90Q26QuC44VfgTMuW55MyZSHPOBT8wPcmGR+/UemVWtQ+KlRgeaF//8k2Squ7F
 z72kzhEXlQKosKgt7MyzuoDfaRBJBVbe6Cl0Fkxbk/NG5cef4p6M6bGj3KJ2juxU
 +Wz4NwAlwACwzu6GeHur/shZPLMSonO/IS7aU1JcGwGCBG76ICMeGN0q43DDXOie
 ENMLkmZb9DuX9DunUqQvhBjXgslo3P0uc23OHaehFyQx9ttjjtpbLQ6IZWn7gqNM
 TQ7d3LqzlW08kKZnWp4NNeP132qKowR+br5Yt1g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:EYphNGYhIdZSgpMJz/VAzv5wFDqUgSsjipY7NKCVHU8=:nJ64+gMY9SI8FV/XSBlALCtHDR/7/Ki9Osk95WkXuK8=;
X-ME-Sender: <xms:o-3NajJfcRY5tFq6oksZ6lU4nm0v2I3j4Yx2na8I8PQH1WAvpkAgzg>
 <xme:o-3Naotw61DKVvfKVPuQTwwnZ-UI-ofF3H1L60Q05a6rV3jUgd3_Qzx0qG-9vtH_k
 tI33qL2FEBaYcNLsiuU4Wo6ysyojYycA4rglzB-ARy2-tW3csPW5mM>
X-ME-Received: <xmr:o-3NaiC0S72H8dyTNKXJyJbtRauV2IFVVgr3ppMaaIzBup9eMMTc-LqXeV6HqMk>
X-ME-Proxy-Cause: dmFkZTGdF4Vp2yOJyYo8fjQaAZUoQWuXmEzGygJKhwdxDh4wOS2xkUycQeAEUXcZqlAvu6
 wwPlcFAnBS1XD6u7zoLQ01y81G0rk0UmXNlKVRr4WDli5Oa9SbZLWkg5RSSwnNj9M/QYm7
 vPpbAQE0+IxhH1TSxUr2JLAbiAyyPK5en0vFZWas59NkZMe3VkXAJ9FagFd10em9rIJRGK
 i+tqX7jdMj2NrF4EuJFkkjizUrvY+Fn8gO8xtqKsD2DeWwItsVlSoNZ1ito5j8EluTJ55g
 X1xtRmi7Pl/3mgGJPxJwUtZSLGur2q9kdAHXLq/wOIqBZa3p1YyxRBGMUbOC6cQj/oLPc1
 2EohLuwz7v9mU6KUT15AleGZ7u2T5z+B40yYrLqueiH3m7mEjKhplQMxEF0sBT+yV8pnQb
 Y3dFaq4ItCQNz/EXaPSwuuSSwG/owaO58MVQzXzbH7ABfVmAdKuT3+joZZh8HkTX8cakPh
 5nROkD5wIkcIcJTDl3E+WwmaQVe16VVyNt5I84n+0LjmTvGs/lBz4fVSH2tZvAdLVFvBLu
 vwh7QP7snvP3xcilp2yXKvmmstxFkMbfKGHFl/68EiMWdmyHRGocV9oW/0GYlqNfumj6hE
 XRpbBTxwUmOPYDWb61d3UkzkBzH+gBc9PSVmDEKZamSwuVfcVZKso8VnoQRQ
X-ME-Proxy: <xmx:o-3NaoOqNt7KbDtl7NRolpzvb0vYIXXPIWZXFrhrIf2n6UOzwjTYaw>
 <xmx:o-3NaiBNsbWmZQhhPmqouF0MQvvR36SXPOKmfpci0HaCnw8BqZEIvg>
 <xmx:o-3Nap5uZt1jUk7Wo0CgLxkpANyWXFz8NiPxaQuWJIMtBdBFzN2evw>
 <xmx:o-3Nas6EqSKEgrVtCEV7yaVfBQbLrCLUDeU-mj5A7NitJ51IbZ0gPQ>
 <xmx:pO3NahF1VkGRFqCNDZZZK9VDWB2gfgUaKzxRhRRJmGNm47CU1t0spIsP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 04:36:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] eal: prefix lcore role values
Date: Tue, 13 Oct 2026 10:36:46 +0200
Message-ID: <4cWA2sW3QHGCB0s6AL8HJg@monjalon.net>
In-Reply-To: <CAJFAV8yrTbrEyHh7i-h-1BPdhR5rawFUW0t_6Uw8KNA1uuewtw@mail.gmail.com>
References: <20261012141037.1451851-1-thomas@monjalon.net>
 <CAJFAV8yrTbrEyHh7i-h-1BPdhR5rawFUW0t_6Uw8KNA1uuewtw@mail.gmail.com>
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

12/10/2026 16:30, David Marchand:
> On Mon, 12 Oct 2026 at 16:11, Thomas Monjalon <thomas@monjalon.net> wrote:
> >
> > From: Huisong Li <lihuisong@huawei.com>
> >
> > Add the RTE_LCORE_ prefix to the lcore role enum values in
> > rte_lcore_role_t to follow DPDK naming conventions.
> >
> > - ROLE_RTE      -> RTE_LCORE_ROLE_RTE
> > - ROLE_OFF      -> RTE_LCORE_ROLE_OFF
> > - ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
> > - ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL
> >
> > Old names are kept as macros aliasing to the new names to preserve
> > backward compatibility.
> >
> > Suggested-by: Thomas Monjalon <thomas@monjalon.net>
> > Signed-off-by: Huisong Li <lihuisong@huawei.com>
> > Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > ---
> > This patch has been reverted in June because our CI was not ready.
> > Applying it in 26.11 will be easier because there is no ABI check.
>=20
> Yes, lgtm for this release.

Applied, it was waiting for long.



