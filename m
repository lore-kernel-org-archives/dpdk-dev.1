Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D2EF3718
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 17:39:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 714A0402BE;
	Mon,  9 Mar 2026 18:39:48 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 7206840261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 18:39:47 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-128d2e3074fso2165499c88.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 10:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773077986; cv=none;
 d=google.com; s=arc-20240605;
 b=h5s1/8twRAmejEUcazed7bQpJrIvWBYY90oPZ43Wm2OWwazufmp1STxuUroRTW2WFc
 F5T38mcsBQx0MxrMChnVLjfUREHUW/uQMFbCqn5V78WmYLcepoFFro2MEBd7EOGvPJsP
 jtg89pZDVLbw7V7sSe5zWjYKkRcaHrbCkqdMVcmZQrMUS2z19BvOJfqQQf0cUSov7z1e
 6ekzXl/mrahEEm8XuCSKNU/O2tmItxn1Szx6Rj36bTT0hHoqnUZBeRTxYPMmdX7ZujDM
 MZJJq0hNZLIjwfXgTKFwLQHkVqtvSeF36/8q+Z/9ipGhWTc1AVh6VWOoTIQ3W/RpK729
 7Zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dnoq3I233MifuR08939N+d3ZWL1LYhSVy3yEgf9zmZg=;
 fh=YekrB8WUZcRza9se9HASwPL3uT+nzfzYV3jCldPSGdc=;
 b=EIsY4/oJOu79sQAC2ttu4Ib7KMR8aRLaiT+2hAnHAUGV0oUbTHaPO1dD3HckW7TNuE
 QE+U2yZrAPAbwHbEyH5gSLg9t1CY0iwLaDfnWaWkLdYrtSsBWlNEH2qwwYs2wli/smc2
 lgXttxkcxzks+OKoBb7vAvHlSBxKDt7UZjvW2Fh+A/R8jPsDralXc9erbzEFRcy3+SAQ
 E1iRFvVsfzAVKS6GtI6XCdsso7XnUs73sw3oR/FrTcE3Mi50wBgPtxTp2ilUb0IGMEL/
 c0+cyRh0GlFndUoa9iQDWJDXeuUr7nCrDG+nwKNkFmy5/KBHTw5pu2UlR0tCe0bRjAfl
 wGOw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773077986; x=1773682786; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dnoq3I233MifuR08939N+d3ZWL1LYhSVy3yEgf9zmZg=;
 b=UQusrC67kNcebKGfi62ykHWQR/lORed7/fOy5e/dRt9JzS8XofyrQprv90V0p9RANe
 VmaDFNqph62fFR2DCEHgSknCukD3WXnJMjA5Tm+wm3d82GIEzrLte7vL/W3oeqlH63PF
 wnilJ9u1mVADpEIgCVcBVtXV9sDZnx+PTGLJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773077986; x=1773682786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dnoq3I233MifuR08939N+d3ZWL1LYhSVy3yEgf9zmZg=;
 b=Le+s6jTkZ9w2XoOTjfmWlg5PdbkOLhbya5RQ7QJLD2YcBzPK44yGYO72QRdfE86GGG
 LiM2iGMK9smJwhBZYAsx3Uo2odYadrR8C08GprIIM44PM4Jx/74GmWTvooYk2QdyuMxi
 cpc/Hbeh4p0BZ6dyQ24UoBgwMXgkrh4nrbMiRxETC5sdRVL8JARcnl6eU6riN3WslgZa
 k/+BkVGz+lpH/TLUoKtuw0gW7SJ6OmGhmvfxvjNGArQJ/0X0tLLHPFoYMtFAibgLb30u
 DAjjHE79EGiYAZwcOR9SuXYwyyk7HNidrZ+r1VgdgL4LmFV5AFl1eeM9JZWXH6kSzBSd
 p54g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOv4I85aKQAcL/FL+cewQctJqq8TDB9rQqmEz65W4eCs2cj22BJemh4k2V4t+SfJv1xqc=@dpdk.org
X-Gm-Message-State: AOJu0YzbboNo2PLRvHz6WnNJ+mK2D/iQZci7y4ZfSQWUY2ah+hOvEflJ
 IXOPvxJPTFiCtz3Li6vbH3Rey6Ur7CY7ir3HmoUUjFIHYoXTvgIY5YI1xFtPQkNwH//ut16u3YN
 kqV5JlfrvxH77Jniv8EO9S9G8EaL3dGoWn3XGM8lZ+Q==
X-Gm-Gg: ATEYQzzk5h00MovSwC4/jdOITdxbnasnNfwep+i6w30D+3T3WUGA0rC1yUVh+KWbtpn
 hZ4d1NZyoE+XYccpPy5XoGDmOQvtUo3apI3nuhwt6csKoe21Af1AdHDff0xY3hfyP2SgcBjgR65
 kEZgCeVP6JvEp5UGP4lBgu8fEU01FgNQA4xPCq/nbJ9iqqoi/Pqo1mpE4MWXS2EldPL4zdFM11H
 7EusKbF81l1XUMPMCGctu3pdkKdpXcdwqoQF7cCqm3gGrmXX0ER/SL03kshGyedgHuMriRyGJlR
 HjNjs36XrRFREaaQfnO0j+IY4q+gXbv2dBcN9gXA
X-Received: by 2002:a05:7022:e19:b0:128:d3de:c9e4 with SMTP id
 a92af1059eb24-128d3deccebmr2114977c88.30.1773077986339; Mon, 09 Mar 2026
 10:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260225182616.71972-1-abailey@iol.unh.edu>
 <20260225183328.73357-1-abailey@iol.unh.edu>
In-Reply-To: <20260225183328.73357-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 9 Mar 2026 13:36:45 -0400
X-Gm-Features: AaiRm50RYsJeyAiOfiH2Nf22XdzcbWDYQnpGTzDcFbGDlQGxG7HpRby5VhhTVxM
Message-ID: <CAJvnSUBMtMgU4+8EdxCv2H0h7zUSsZ80hp-qLu982TNObsc-xQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: port speed capabilities test suite to next DTS
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
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

On Wed, Feb 25, 2026 at 1:33=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> This commit ports the speed capabilities test suite from old DTS to next
> DTS.
>
> Bugzilla ID: 1494
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  .../tests.TestSuite_speed_capabilities.rst    |  8 +++
>  dts/configurations/tests_config.example.yaml  |  4 ++
>  dts/tests/TestSuite_speed_capabilities.py     | 54 +++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_speed_capabilities.rst
>  create mode 100644 dts/tests/TestSuite_speed_capabilities.py
>
> diff --git a/doc/api/dts/tests.TestSuite_speed_capabilities.rst b/doc/api=
/dts/tests.TestSuite_speed_capabilities.rst
> new file mode 100644
> index 0000000000..de6dc42757
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_speed_capabilities.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +speed_capabilities Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_speed_capabilities
> +   :members:
> +   :show-inheritance:
> diff --git a/dts/configurations/tests_config.example.yaml b/dts/configura=
tions/tests_config.example.yaml
> index 64fa630aa0..bdc4c49a1c 100644
> --- a/dts/configurations/tests_config.example.yaml
> +++ b/dts/configurations/tests_config.example.yaml
> @@ -15,3 +15,7 @@ hello_world:
>  #       num_descriptors: 1024
>  #       expected_mpps: 1.0
>  #   delta_tolerance: 0.05
> +# port_speed_capabilities:
> +#   test_parameters:
> +#     0 : 100 Gbps # set link speed according to your expected speed in =
Gbps
> +#     1 : 100 Gbps

Can you add a comment indicating that the keys are in reference to the
port number?

> \ No newline at end of file
> diff --git a/dts/tests/TestSuite_speed_capabilities.py b/dts/tests/TestSu=
ite_speed_capabilities.py
> new file mode 100644
> index 0000000000..9ab488ab1b
> --- /dev/null
> +++ b/dts/tests/TestSuite_speed_capabilities.py
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2026 University of New Hampshire
> +
> +"""Speed capability test suite.
> +
> +This test suite ensures that testpmd recognizes the expected speed from =
a link in Gbps.
> +"""
> +
> +from typing import Literal
> +
> +from api.capabilities import (
> +    LinkTopology,
> +    requires_link_topology,
> +)
> +from api.test import verify
> +from api.testpmd import TestPmd
> +from framework.test_suite import BaseConfig, TestSuite, func_test
> +
> +
> +class Config(BaseConfig):
> +    """Performance test metrics."""
> +
> +    test_parameters: dict[int, Literal["1 Gbps", "10 Gbps", "25 Gbps", "=
40 Gbps", "100 Gbps"]] =3D {

Add 200 Gbps, 400, 800, 1600

> +        0: "100 Gbps",
> +    }
> +
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
> +            for i, param in enumerate(self.test_parameters.items()):
> +                link_speed =3D testpmd.show_port_info(i).link_speed
> +                verify(
> +                    link_speed =3D=3D param[1],
> +                    f"port {i} speed {link_speed} does not match configu=
red '{param[1]}'",
> +                )
> --
> 2.50.1
>

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
