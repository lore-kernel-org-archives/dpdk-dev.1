Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF099CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE4714028B;
	Tue, 13 Oct 2026 14:54:37 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id A84B14027B
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:54:36 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0E583140014B
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:54:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 08:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791896076;
 x=1791982476; bh=HqzE9Qo1bIvpdP05iI8PabD6zNUUnVNLEAOjYyozj6M=; b=
 QEXP0yboaZ8mQnYzuPtnCfwLg2bVfe/9jxg8yVwQYSyNbH+02uou2Q4EwLgWlBL2
 MWbwTw3Ts09On9vlfl+GjLDD/3H1hcnYxCdrJCZFjkeEADZ0SPKybqaLPLKKQr4p
 W4ZMZZSRvORLB4frubf7/++NFtlYoADwiB7a2U23P4LhofLg4nbXBUW0+EH/vlVT
 815uh9dn55X1sNU8e82We/nQTdka/8NSBB/6ElXpOGez+eHfzlzECFolUR5VPMYr
 u8BVkqr7J7cx5Akr0GHptck73WpgGaAIS8CMANdqo6UPE2J5l9RV4M6qE6wwLf/C
 Xdi40CWojaliLG6fvqzmXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791896076; x=
 1791982476; bh=HqzE9Qo1bIvpdP05iI8PabD6zNUUnVNLEAOjYyozj6M=; b=H
 gmWgQT0nF92IJnFYgMOtTmR9gHnupjrJ5vQsxVvVzCk/96geDiVQ0oNHm4K9wg5K
 aggEyVtUpaFmz31klbD/k+SGrM3i11gtp9nvJKTVGVAhuiKtH4obO2UmDFOKrqLh
 ocGy+954bugErxaipUFyVRXYY73KhQ8Ff9VO7IsC54HmrJ054g3I/MSzO36KFYBv
 7QnZ/9jsfaPwXXrijHcbc5ELI1cwCdlG6jn4hCbTlIYYmkf/owmm5w3L9nN7l14u
 RUXhCG6J2NaDyEJe/ry5YEi0MB/OnUoWxOrcN73hvRc1ehPOmYNG6jlKkUXVWeqs
 DjfRAZ/dpkAHYHHw3kD5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791896076; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:AhTOzuLSpToHbvTbl6k/Q8dP8DDaYb47lHXVmpbY9xs959D
 Wmo2MgKR61KJybgOkQbnbNFrwanfzwT3hBBBpY7fiR0w39WDRuQRmylNJ/B0eaPO
 BMxpPvaI2tenyBL2MpxqNNj9vNAeNgrmjzKbNHXJh3CDXWU3EyEWrvqREVY1Xuxt
 VsjPvzugsPGophQ/tz9re+y/oIh+KceW3JINuNFUUWqsCXzoJvS+1+rVvioN7Nlm
 pK064rXV+vtp8fbQaKEMk9v36fCrtNaEB+oRTfHw/maJZaUWJZv6ituJbzpNMpaF
 zek1lgk/4srJilSIqHShAcMIOt6WccR7/Z7N6sw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:vsQEI1N+Mq37KfxEZl3L8YolHxsdZevGG56j3PbCAQw=:ail5r/ViqG8I8Heu+rBZ4gFja1o84VRfappG9DK/Nds=;
X-ME-Sender: <xms:CyrOamSMMmQFDan2rdIExd_5DHtqqt3knYjsPHor-hyA1qAanT7uPQ>
 <xme:CyrOal3-JIo0ejbNay86cc6q7jjc-aLjHWU9YENitSSpEKLqH43gmJhYnOPwcqqhB
 j7Lgn6XZph8UVIv14ZPwzkcgSz5cqtQ1Hagb0w0sHy_jSOLfMKUjLk>
X-ME-Received: <xmr:CyrOajs33qWNBNJqTzALgicL-yKwnW52ftZwkdBWVO-R4LGaE_zLJ0GplxyUvPuo_UsVT0oAxdCWcTbHkPRts5g>
X-ME-Proxy-Cause: dmFkZTEv4THbZ8c0rLTXZQ8dBdhWhIFxDb00Gr+l4/45St6l/bt8NNbaA3GkPFnt9ql8c4
 TXT0YpYv8czGP9USAFWS/IOHEkFyAy394hXJXZHDXalBQEsUnFnkMy+C7QFhR5ykSHLa/d
 Hfg0UE+BEpOIQRvZCALjufmVxFhk/7zlsN9haP2IWwGHFRAx/5oyJN6YuPNqW8Jgro/J6j
 U6BSvQGEUHDuthhAbYWE1m2oTljSi/Pk8VbRGlMEuJvqtnrNmKoteY3p9jxCb31WSvzllF
 oLxib1CVZq0pOTBnCBG5pa2DFnQuGe7bREQQej7kYpkBqrJEZXVvGHQ796oKtkearWIQAL
 NDHmUAfJFfCyQ7OIfe7scjsZIdg3Nc+XHrOYQbrvD/jnoZsRPghJDpLZ/Oie9Z8vTGmqsa
 s70HB5rgchKfXCoWWSAgns5HqJIxG5aimSeH/9Nr/Ki4iKbBbGzutTZo9AG19e6Lai88ez
 vZyM0ONMERJDCt2UoJcyd69W+CZrmOt13x1kcMvzxdPn9BVaLewzf1ZvH4pOEsIJDwNVr7
 bHZacZDAHPljjKCi/7n7h5bHkwQGsUsqfMxduwJwUI5pePFNeD7/SqkCkmo/s12UASwARg
 84kVgklLHp0aNbDO6XpAMIsrQLuFqUzN8CHe1eoYOksNdCLnxghCavofuGnA
X-ME-Proxy: <xmx:CyrOajiBCehkbr0DxU_hyDb5rCk2KZ7qb6fH6PP44jOROGAoj2lT4A>
 <xmx:CyrOas8SUZmqHp12_UDnCa0IbUXBrHj8FhptfIbDiG_tIihi82ubUA>
 <xmx:CyrOausZKGxN_d8-9_sIaEQeZl3kL5LlRb2i4fJkoPWl6SIkuRfpaQ>
 <xmx:CyrOaoq5PutPmYVKYn6AiPZMNE9nhBinSQ43uUVkQknAiTRChHWzMw>
 <xmx:DCrOanCgpxM_uu1ffynu_IOO8NLEtcqXZy_8b9bPqZKgFD9BBXMUehIL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 08:54:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: dev@dpdk.org, Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Lee Daly <lee.daly@intel.com>,
 Marcin Hajkowski <marcinx.hajkowski@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH RESEND] examples/vm_power_manager: add missing <stdlib.h>
 header include for strtol
Date: Tue, 13 Oct 2026 14:54:32 +0200
Message-ID: <4jUps5nwQy6FzQ_KSzLtXQ@monjalon.net>
In-Reply-To: <20260828151833.1d4e92d0@phoenix.local>
References: <20260828215350.2861715-1-thomas.petazzoni@bootlin.com>
 <20260828151833.1d4e92d0@phoenix.local>
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

29/08/2026 00:18, Stephen Hemminger:
> On Fri, 28 Aug 2026 23:53:50 +0200
> Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:
>=20
> > From: Guillaume Gardet <Guillaume.Gardet@arm.com>
> >=20
> > strtol is defined in stdlib.h
> >=20
> > Fixes the following build failure:
> >=20
> > ../examples/vm_power_manager/guest_cli/vm_power_cli_guest.c: In functio=
n =E2=80=98cmd_query_freq_list_parsed=E2=80=99:
> > ../examples/vm_power_manager/guest_cli/vm_power_cli_guest.c:208:42: err=
or: implicit declaration of function =E2=80=98strtol=E2=80=99; did you mean=
 =E2=80=98strtok=E2=80=99? [-Wimplicit-function-declaration]
> >   208 |                 lcore_id =3D (unsigned int)strtol(res->cpu_num,=
 &ep, 10);
> >       |                                          ^~~~~~
> >       |                                          strtok
> >=20
> > Fixes: 0e8f47491f090f44a4956429cb27f6942b6618b0 ("examples/vm_power: ad=
d command to query CPU frequency")
> > Signed-off-by: Guillaume Gardet <guillaume.gardet@arm.com>
> > [Thomas:
> > - retrieve patch from
> > https://build.opensuse.org/projects/openSUSE:42:Factory-Candidates-Chec=
k/packages/dpdk/files/0001-examples-vm_power_manager-add-missing-header.pat=
ch?expand=3D1
> > - improve commit message]
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > ---
> >  examples/vm_power_manager/guest_cli/vm_power_cli_guest.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c b=
/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
> > index 4114593cee..63a59c8b10 100644
> > --- a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
> > +++ b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
> > @@ -6,6 +6,7 @@
> >  #include <stdint.h>
> >  #include <string.h>
> >  #include <stdio.h>
> > +#include <stdlib.h>
> >  #include <termios.h>
> > =20
> >  #include <cmdline_rdline.h>
>=20
> There is a pre-existing bug here. strtol() can returned signed value.
> Probably should be using strtoul

I assume this patch is superseded by the 2 patches Stephen sent.


