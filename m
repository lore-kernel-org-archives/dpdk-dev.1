Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920C5CD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 20:24:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E4C340144;
	Sat, 20 Jun 2026 22:24:12 +0200 (CEST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 2601C400D6
 for <dev@dpdk.org>; Sat, 20 Jun 2026 22:24:11 +0200 (CEST)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c07c67ad9f2so414325266b.0
 for <dev@dpdk.org>; Sat, 20 Jun 2026 13:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781987051; cv=none;
 d=google.com; s=arc-20240605;
 b=gF4+Jxa7JWKYoCTAuWAOfmNr4FtbF4x86fLucH0+VyUIQnsFlBf9kwYd1epOEtCLmL
 e3EVI0U/0DsAZ4igVZcW3INdq6ThVNEe4jf2l9UqwYaUl1nmQsqvgdXfE52spwMFFqe1
 vbwVwvNJjYelGWtjLiLelok004Tx3kPNXK9g560ylgMmPo+emvMqshfCnXKWdT7+a8lK
 /CH5zvZO8f16ldaBHwXV4KkZsBkIrQ2IbpxGtmAHYoDyOwAdO43pCju0vKdwG4OmvvLk
 aZuUdwW+l6NWD/mHQAM8cXFuoMKZGXgg4vqxjHnMWzb3pVmzRgI+7FCH3jYKjzYEq6zu
 V77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1KXJmVC8D10K93qx5m6Hs/h3kUGemj3uDkZW3DRzZ/0=;
 fh=6zkRVN8oQbVHdw70hwTQAhNg1B+n3pw5z6lIYHE8oC8=;
 b=cePdPAtYl35MVCSAU1/CvOeO69aUAXLhAih8jVzmb22fL/BL1reFR0dPS2wYdnq+rg
 zK2armUtSYLmuPfsVdjLJPIzp6cjSmeUy6V+lamtHUEr7+SAc49nUuPCC19Vb+w0tMNC
 xK19WQDY6XGg5w3Oia8hXQ3KdXM2PH6GGhrGrldIM6GiAGD9tZqH6f67v9jLfI5hZxmu
 9KzB5ECLEOTIcNMleir7aNk9OoMaQnU6Bd5ScN4eV+ZSs8mQUY7C4trGzpKSj7cfHGe3
 huJqOtqPQt2Rpt6r4WdxFBPB14l22x6m3Z8gxBXnpNNbO/5jBpi74OMZ1mjSMOv5m82n
 zX2Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781987051; x=1782591851; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KXJmVC8D10K93qx5m6Hs/h3kUGemj3uDkZW3DRzZ/0=;
 b=r4dTYQCTs75Sif4avBFVmYbzG1HU9hdWdpzGkvwlf1T/Ok1B4pG+Dceb6mujaq9rMP
 QA9ne1akfWB1i3ybWN3CEKiQLJ5WQdWP9jYdZndWcO1Aa99657eM5/T2FIMeV6fwa+yg
 U504hqbpT6kZ1ObWxZA6zXF7QllmUzcgIBUawUy2uRd82AKnSIWomEAm7ci4aksxVHwT
 J7X3d93ZKNq2XZl71etwirtWSB8W4eXAXDhvA7MhXur+CPuqtlHeP1MF+VJzh7HNrDnh
 gHnIQtEYmjU0SWulprfztNSVnMhQRNIMYcYFXpKhEpdMSnoz6ttNMq+wlPSlWhPLEeQ9
 RSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781987051; x=1782591851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1KXJmVC8D10K93qx5m6Hs/h3kUGemj3uDkZW3DRzZ/0=;
 b=suOEfjm/nM8bFYMl/Ren54QENlJ+rrEJ3Fc57/KbUd/xnJ6XopDCcEy7oKDQCBCATI
 SssY9FKvsmvEis7GluzmxxPUXuBlTd1d0a+yGCIQSLUWSOtiiUUHRDJPX+GjWIpSOpRi
 KFoNWm6xL0HgjhcmE002Ltp3KxJobddA/qxCZCCH8sAtZIAL6CfcewR35nemszzSdjl/
 XUiSHRtiZ3WqsNR9Efe3JgCubB+LxiQenBRz8VM2rhR9kpq+80rrZw6q4dxLRaJg+gb+
 3Nzmsp8PupKE3P69fiuM+mAcVd1OGpzbYZq7DRnNUjXqojcIu/tPHa/6EZScoWrr43mt
 1DUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ssd8NzRejKffFiQWfbfe1P/gGIpxc/EbJXBnhst4DB/7+sT7+d6z6rY+69iuaCWZcGoQ=@dpdk.org
X-Gm-Message-State: AOJu0YyOXPFRWdBDs9Cb/zZt7gcBEh947owO57kOTTMREJ3IB8fxtdz3
 lPgaswaZQDC1+kE+/WKHYmj5jq9lkNWAho4aWkMQRpSoN55M8LzFuQ/ndpi4WAZ2WQVAFUKyMMg
 km+Og3WEEonlffxjTQzV+9VnOvuMjcws=
X-Gm-Gg: AfdE7ckzEAeh6PANKsk07VQtQMa3bgTXPMbZPrLIE5o1vP+RQt3UbYkLKug4VwJmT/i
 6lAvjlh33pFq1HvSBPsv7LRIY+Gi2+uLY230n8JcttdRw6zidGxkQCt0Ul+00XQSuiuBqveBKlL
 omErQ/qmf2XVVSx/7x6KtBsv/g5EDCPFpNFNzrCP4+iF6IuBsgL6u1j4UAdRA0i7gtZSYBdIKbj
 w+gf+W9ut2EJRKq7f9HZl68yIEm3ONTSljDZUzW8Ix5aAVPbqx5d4rgKE0GlWOt+0ylw47HPgj4
 QXefPb5Z0ykS08kkFRMyAAmw2ZHvEwU=
X-Received: by 2002:a17:906:8e14:b0:c08:7c60:9069 with SMTP id
 a640c23a62f3a-c09ba166c64mr363717766b.32.1781987050363; Sat, 20 Jun 2026
 13:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <98CBD80474FA8B44BF855DF32C47DC35F658E5@smartserver.smartshare.dk>
 <GV1PR04MB10750E293DBDCCDF9FEEFE00289182@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <09dbd9b1-f4a6-48e2-9424-546eafdfa01b@arm.com>
 <GV1PR04MB10750F8AC96BEFB29C1DD13BD89E32@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <1eb241f5-3cef-4814-ab3c-13246a452513@arm.com>
In-Reply-To: <1eb241f5-3cef-4814-ab3c-13246a452513@arm.com>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Sat, 20 Jun 2026 23:23:59 +0300
X-Gm-Features: AVVi8CclsN73r8C6HYmMUabHrr5KCuCK2D9NTkpGqZnn8V8325NuUy1kDQTvIqs
Message-ID: <CAHfVqdXE53E2ykJFHM+HM8xd_zuz4Wt3XvoLMNzhw8Wdnn0pWg@mail.gmail.com>
Subject: Re: ARM v8 rte_power_pause
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, Maxime Leroy <maxime@leroys.fr>,
 Gagandeep Singh <G.Singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

note that Event Stream periodically generates wakeup event for WFE,
linux kernel enables it and configures it to 100Hz (10us).
https://developer.arm.com/documentation/102379/0104/The-processor-timers/Ev=
ent-stream

saeed

On Sat, Jun 20, 2026 at 8:46=E2=80=AFPM Wathsala Vithanage
<wathsala.vithanage@arm.com> wrote:
>
>
> On 6/18/26 01:17, Hemant Agrawal wrote:
> > Hi Watshala,
> >       I think WFET is not available on A72 core.
> > Can you update your answer w.r.t Cortex-A72/Arm v8.0 architecture?
>
> WFET is not available on A72. We enabled it in DPDK selectively for this
> reason.
>
> >
> > Regards
> > Hemant
> >
> >
> >> -----Original Message-----
> >> From: Wathsala Vithanage <wathsala.vithanage@arm.com>
> >> Sent: 17 June 2026 17:27
> >> To: Hemant Agrawal <hemant.agrawal@nxp.com>; Morten Br=C3=B8rup
> >> <mb@smartsharesystems.com>
> >> Cc: dev@dpdk.org; Maxime Leroy <maxime@leroys.fr>; Gagandeep Singh
> >> <G.Singh@nxp.com>
> >> Subject: Re: ARM v8 rte_power_pause
> >> Importance: High
> >>
> >> Hi Morten and Hemant,
> >>
> >> YIELD is a NOP on non-SMT CPUs, such as Neoverse.
> >>
> >> WFE is universally available on AArch64, but it comes with a caveat: t=
he CPU
> >> can remain in a low-power state indefinitely unless an event is trigge=
red. That
> >> event can be generated explicitly via SEV/SEVL by a different CPU, or =
implicitly
> >> through address monitoring (LDAXR).
> >>
> >> WFET is the safer variant because it includes a timeout, so explicit o=
r implicit
> >> event-register manipulation is not required.
> >>
> >> --wathsala
> >>
> >> On 6/12/26 01:11, Hemant Agrawal wrote:
> >>> Hi Morten,
> >>> On Cortex=E2=80=91A72 (ARMv8), the only architectural primitives avai=
lable are
> >> YIELD, WFE, and WFI:
> >>>     YIELD is the only deterministic, low-overhead option (pure CPU re=
lax,
> >> no entry into low-power state)
> >>>     WFE can be used as a low-power idle hint, but it is event-driven =
and
> >> not time-based (it may return immediately)
> >>>     WFI depends on interrupt wakeup and is therefore not suitable for
> >>> tight latency loops
> >>>
> >>> For ~1 =C2=B5s latency targets, the practical approach is a hybrid st=
rategy:
> >>>
> >>> Short waits =E2=86=92 spin using YIELD
> >>> Slightly longer waits =E2=86=92 opportunistically use WFE for power r=
eduction
> >>>
> >>> A simple implementation could look like (not tested):
> >>>
> >>> static inline void rte_armv8_pause(unsigned int iters) {
> >>>     if (iters < 64) {
> >>>             for (unsigned int i =3D 0; i < iters; i++)
> >>>                     asm volatile("yield");
> >>>     } else {
> >>>             asm volatile("sevl");
> >>>             asm volatile("wfe");
> >>>     }
> >>> }
> >>>
> >>> @Wathsala Vithanage =E2=80=94 would appreciate your thoughts, especia=
lly if there
> >> are any micro-architectural nuances we should consider.
> >>> Regards,
> >>> Hemant
> >>>
> >>>> -----Original Message-----
> >>>> From: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> >>>> Sent: 03 June 2026 17:26
> >>>> To: Wathsala Vithanage <wathsala.vithanage@arm.com>; Hemant Agrawal
> >>>> <hemant.agrawal@nxp.com>; Sachin Saxena (OSS)
> >>>> <sachin.saxena@oss.nxp.com>
> >>>> Cc: dev@dpdk.org; Maxime Leroy <maxime@leroys.fr>
> >>>> Subject: ARM v8 rte_power_pause
> >>>> Importance: High
> >>>>
> >>>> Hi Wathsala, Hemant and Sachin,
> >>>>
> >>>> Over at the Grout project, we are discussing power management in the
> >>>> context of 100 Gbit/s latency deadlines [1].
> >>>>
> >>>> rte_power_pause() is not implemented for ARM v8 / Cortex-A72.
> >>>> Syscalls such as nanosleep() have too much overhead, and cannot be u=
sed.
> >>>>
> >>>> Any suggestions for a power-reducing method to make a CPU core "slee=
p"
> >> (i.e.
> >>>> do nothing) for durations in the order of 1 microsecond?
> >>>>
> >>>> [1]:
> >>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
git
> >>>>
> >> hu%2F&data=3D05%7C02%7Chemant.agrawal%40nxp.com%7C06a651571db
> >> 545d47d7a0
> >> 8decc67908e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639
> >> 172942353
> >> 967617%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
> >> OiIwLjAuMD
> >> AwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
> >> C%7C&s
> >> data=3D7NCh3%2BS3TAu1sRLYgqGNAaTwqdgwjqhAs2awPixIeEM%3D&reserve
> >> d=3D0
> >>>> b.com%2FDPDK%2Fgrout%2Fpull%2F624%23issuecomment-
> >>>>
> >> 4602036364&data=3D05%7C02%7Chemant.agrawal%40nxp.com%7Cdbff5f2e
> >> 8db1406f0c4008dec1671791%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> >> C0%7C0%7C639160845728472826%7CUnknown%7CTWFpbGZsb3d8eyJFb
> >> XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTW
> >> FpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DDRpJWjm2yaF3Cnhk0b
> >>>> bFFhmGbKRweOOiWdsWco2NbX0%3D&reserved=3D0
> >>>>
> >>>> -Morten
