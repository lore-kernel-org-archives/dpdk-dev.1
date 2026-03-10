Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C10FD4F23
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 19:08:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6B0F4067E;
	Tue, 10 Mar 2026 20:08:09 +0100 (CET)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id B201F40672
 for <dev@dpdk.org>; Tue, 10 Mar 2026 20:08:08 +0100 (CET)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-127380532eeso922421c88.1
 for <dev@dpdk.org>; Tue, 10 Mar 2026 12:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773169688; cv=none;
 d=google.com; s=arc-20240605;
 b=VnRXd8rWm4RiKFDaEfQWllqu0PVlfuh5DeyPC7i5I7BMYKkiNz+RaEjEQr86we/UG6
 /IUmD+kSIE9uaKNJO5epHF8wmCDtpTI3cfRd+BmZsywn3vSmlyh+rphQ0VR2lGyEopji
 4mx9K0KJixES3ZuEilKDkdxWTURCk0kg5ESmfZG6hTHyJ5IMwi5E1jUwBPHSUVb01Lmr
 1cMZQFJkhQ++uuQS9TptrgHAOiKGf+jpIzfIIpB8gpwACqGkDY9ivqWbyQr5A2lvNudY
 EnjGb8Mw85EOgVtZ7bU+L7r5qdoC4sQ+wfdkt6pi8e/I9YZq5cEDclhI5yIvNIje8TfT
 UO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rd+GTpHzn0RDeq0il+AZX8kViysEZqlWOAWZcbVjT3c=;
 fh=E0kIeMKsE7pDAfp0OfD0pCB8hlnJNVan3MhEntQzdB8=;
 b=ljAW9PlZ9QltqcxJlMaD6kDFTgtGaXXgWHeLr5ls0GYHT8ff7zgOnRolxwykul50Ev
 kRPnq8mbIIT4KrTLNCtH2DirYn7DM2KWqnzxde5LgXbSoKmMLwyuFM5LhT8/XXncntsK
 t7j7Zpwac92elf4GY9mituuCXUpu7DiBWzkjY8SbycrR4xiQz5B0PcY3RRQMtIQD2kTh
 tOz8GH4rHgPVFaen8cxPwBL944of2hbhut00b9fD2OQ/muzjlQH1Mm3pkHDnikguuOQC
 Yqk/JS1/5TmLExaUqowidghk1eDKwXqXz8J0tbcfpMkXKzOIQVhCb5vrvNsbngN/SWFO
 rRhA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773169688; x=1773774488; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd+GTpHzn0RDeq0il+AZX8kViysEZqlWOAWZcbVjT3c=;
 b=Aft/Ra88iDZO6a7vh2Rc1x+QCdOr0Mr6yhPWUK5Idz/pQvJYut4k5FYkHIDJnNL941
 jEtc8k3tlkA0RyWQvdNxmh/Qff3C8tyEZAscQAAwwiSBSHonMSgUhhaJPjPTx3LBhXGP
 6nVkJpbG0p0OHntrepC5iYIDURbP6cnSPsors=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773169688; x=1773774488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rd+GTpHzn0RDeq0il+AZX8kViysEZqlWOAWZcbVjT3c=;
 b=DXL4lMjS4hTNXpYb7UoEObtNRs0KrfFgeB7bNlH8CumQLjwrsreHAsZSU1l6jDvcwA
 Q32BNDmrGbkteji3y1wfw4I2SjlWwLHF/f08zF1q7+RTMU2HHrBMdfs44NHrpwwK7dMh
 NAQfHGDAWvLOleaH68LJry57dv1hcdry0XFu3dci/l8UjIeXBIlSmN/+Z46wyQPPE22q
 elQUvb41nqk8WElM6U3n/GxkVzETdTGsy5bB8Zpz2Igi8Ni7DRRvLRhKvFFlwJ7qO7Co
 0M3B7xxyxJMEC8+zwCW2lMnJRY1h9lmde13kxa6KoJOvIHxtjNyG/qqpv1NqNa6woJQ7
 ifYg==
X-Gm-Message-State: AOJu0YzfiE9bs1d4ty/o/0886AhlGvvNJYoHDtajOLeOzs8jv2pi20tK
 TwmwfB+SIW5vgP67tQD+ODw9UpmNX/xcKGqvTuTkBsdSDKVvHG6xp8sLNaLFXcBLKUJHR5d2vAs
 LfoqjlaHlfnx7xFqt443SqZpf7FfLqQViHLg8lbczow==
X-Gm-Gg: ATEYQzxgAhqqDhdrVxlzLbFi4WLLA9fovEqSSBIpN+QgKgENzCVaY/CjNwOfTWlfOLE
 i2iuH2mvx1oOzhKT7rnIEp/gNNL/HMTyagilfcOem6nEhmxtj1D7vn/JYerZKG/agK9mVzIZsyj
 BHuEApQRJN22SlnSFO06voD31qfSeJzabwUnAMLO4f9K2dzDvuXU3xk3p3SCtUfA54Q12W5qNBZ
 Ocd/KkWdfjlkyWbcGMLM4WqZEU5lWraqoVzfr2sz32BXU/iJb1mey3VMZ8xMzAHwp4C7Lq167c3
 QqRsoGom4Whzs76hv4umBgEKrY30XPUhqHPlOWL1Fe25Sp6KLbC6CJGHJgHzHTjj4UJvIWQR
X-Received: by 2002:a05:701b:2914:b0:128:ce44:be8f with SMTP id
 a92af1059eb24-128ce44c005mr2829751c88.2.1773169687627; Tue, 10 Mar 2026
 12:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260225182616.71972-1-abailey@iol.unh.edu>
 <20260309202928.200755-1-abailey@iol.unh.edu>
In-Reply-To: <20260309202928.200755-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 10 Mar 2026 15:05:06 -0400
X-Gm-Features: AaiRm53h-gPOic8onLQA0bEwMDpwhombdL7sTWrbm0Gtx4pOHLbnjX7DAMvoMoc
Message-ID: <CAJvnSUDHk88avG5-0ExPb6k9hLuQujxE=nQ=SHFkD6bd0QbKiw@mail.gmail.com>
Subject: Re: [PATCH v6] dts: port speed capabilities test suite to next DTS
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu
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

On Mon, Mar 9, 2026 at 4:29=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu> =
wrote:
>
> +
> +@requires_link_topology(LinkTopology.ONE_LINK)
> +class TestSpeedCapabilities(TestSuite):
> +    """Speed capabilities test suite."""
> +
> +    config: Config
> +
> +    def set_up_suite(self):
> +        """Set up the test suite."""
> +        self.test_parameters =3D self.config.test_parameters
> +
> +    @func_test
> +    def validate_port_speed(self) -> None:
> +        """Validate expected port speed is also the observed port speed.
> +
> +        Steps:
> +            * Show port info for each available port
> +
> +        Verify:
> +            * The resulting link speeds are equal to the configured link=
 speeds
> +        """
> +        with TestPmd() as testpmd:
> +            for k, v in self.test_parameters:

Looks good except you do actually need self.test_parameters.items()
(contrary to what I said yesterday)...

> +                link_speed =3D testpmd.show_port_info(k).link_speed
> +                verify(
> +                    link_speed =3D=3D v,
> +                    f"port {k} speed {link_speed} does not match configu=
red '{v}'",
> +                )
> --
> 2.50.1
>
