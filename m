Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45239CA5FA3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 19:15:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8935402F0;
	Mon, 28 Sep 2026 21:15:15 +0200 (CEST)
Received: from mail-qk2-f32.google.com (mail-qk2-f32.google.com
 [74.125.230.224])
 by mails.dpdk.org (Postfix) with ESMTP id 81FE140275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 21:15:14 +0200 (CEST)
Received: by mail-qk2-f32.google.com with SMTP id
 d75a77b69052e-533342a38ebso23654871cf.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790622914; cv=none;
 d=google.com; s=arc-20260327;
 b=jq7mk2RysRUyw8S7oiN9XRWyZ1x2V/XtXj2joEMdqC4K7jZ2LD0SmHSCzJRFRNB7HT
 GL2jgqbdSo2hcH0YEF8774jzJKqS1My5JUb7SDaoYnjznVuey746axSUUNFP8Z2py6zV
 v9Lh4h3SP2SGch9tokxuOloM9HRYGEtBpHtkr0RywHK3gC2bYQHPimlPCsplTp50KTiT
 fIL6mimSXPB3HrHjbKcQ+7p4kJE/vUscTqD+wCRjDF+Ka8b4sdz/lor5tLtv80hiKiW1
 PscaUz8mSSS1NjxoXVk4SDgbBxYokuc3GMjKOzq2h/fC1cvRtC8EONdos6+hCqZh8jMv
 j6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U9K7+FCJ2i8OGsA5q6XcYrv55OlxLGaLhYRvsCRMHg0=;
 fh=sagiv8UuYNg0qHRSkdxniOuKu2ydRxcsBLpQxNb1vYM=;
 b=UgdCveDWBus6ENCfF8pSKCi7R3/5R+g4SjjhDsH54htN1w2FfVC4xoSDPlt+kAPlzO
 f6ozTNYs+XifJRlkhVx2uyHMmXS5mDFdHzx3YSnrHFJJwg56/HiWjnqExsDVDi7awh5D
 zvka0eSu8NPLaLD/DO3zPD9K8/IghJqaLo8hYYeQ8gGduf0MAizw+jpZgHWbqaOdRzi7
 v3vcwQg8U0WKR1ikcND/uBLeCfGcxDAo0CnkFYr1MjE0wiJeqn5ejmlg/hIRGrE0/VBa
 rc3c3P/g9uU/olEQLLW3VE9wzDXuBLSt+G2GUzdksgfrLxfRvmtvyGEK917QET7k21Bp
 qtMA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790622914; x=1791227714; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U9K7+FCJ2i8OGsA5q6XcYrv55OlxLGaLhYRvsCRMHg0=;
 b=Ebg8Yb0Bad2ozWHkKLfirrdObudhdGKacu7Y1LuPKouhcIO/CR2RsZdVAQ8fwlmvyF
 0uCLl0bOkHy5LocS6HtZBNkPEKmH7huC08XGWCrfEshpfpu7rZNPAqPsqLc/xwVDgJ+R
 1P22CBBjyUukwADlSkzVzoMmaQp9yjBK3YVQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622914; x=1791227714;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U9K7+FCJ2i8OGsA5q6XcYrv55OlxLGaLhYRvsCRMHg0=;
 b=0fzBAzqPrSoLt/JbqC5+HnInebC6INlRv0IA/bgK+hjLQ8pk01+RcSBSX4m6jL1tnF
 VuWFWNetQ1/7hExPdLrm95wzI++WgoOYK7Q2cqhvwkoCd35TZwWMeftoUjz5ZhKtKDhu
 XtnSy+b1PlLc65VSje2FwJ2fPkk1vhyvMnhjZ5TQnYaLkCggiGaXk7dffmiBRspi2IHX
 XaKHqJHRvJQudc+KOGz8IlgZ/plgeS4Wy5Dh4wpCaHcC41ufVR/lI1ZSPUHjUpgfQ/R7
 KWcfctfsobVbMVj5+kp9iJ4r6JAs4rRBv0Ghj4FOD3nCZjX+5z1L+D14z5K5SCdMbIvZ
 WdgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhZ51Cpta8CrXNpBfo4YDQtkNG0NQehKMgHoQtIViWQFms+1UeMySJCHfkM+MMdpFZMYc=@dpdk.org
X-Gm-Message-State: AFuF++mKoIE217/NBiTjBBOsrbLAWFD4kBF2+5MgJljG5lFfofpPbbU1
 rA0zwiwQ5/Fh79FuQbZY/JFgDyQyJpVCGSae/Xl0lAMfHT1kJDWMyg7HC92vpKZCH1uMzppPhsc
 BdiNRkCFgT+RY9DbXJCIwJADnCTR3+dOHffz2MZbeWw==
X-Gm-Gg: AYBFou3oV/A58Gz3YjeRUmuAuRi5K6H36Zg/pkhWKD8pp1Xyy5xO4j38QEaf4Y+lvaM
 SvozHaFk6gv8vN1G8hAAW37UoxiDJGvZH+h90z0HS5V611JycuoNN0WJC89jzr8UoeL6Qyfee6H
 iDsbUTyhNntfNOOid+U7Yitl/L+Itawc8Glk48YuzXTajoeRGR5l5ITgzZ118W83wrnEwZLqaHY
 ECXJJE5zy+dsqqo2yX3gT8U5+f5aSYFra49FSnGgKsIJOf4x69wmotZlWYEvWYJ3QscPEi24zDo
 bawt8pryYVYXdCmXnoCOjWl4EdxeT23pG1xU6UBkuU6KR+QS65bF0a/xjXQK/WouPYzKZQ==
X-Received: by 2002:a05:622a:1653:b0:532:c459:7b8f with SMTP id
 d75a77b69052e-5330b67bf9cmr223672891cf.30.1790622913479; Mon, 28 Sep 2026
 12:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260901185957.453730-1-knimoji@iol.unh.edu>
 <20260908144707.862960-1-knimoji@iol.unh.edu>
In-Reply-To: <20260908144707.862960-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 28 Sep 2026 15:15:02 -0400
X-Gm-Features: AclHuK9JDU5Wj34cj_xwxCVuRq5pquJV8gnJiS68NIAkEsOSxYbZAS-ipekwGAw
Message-ID: <CABJ3N2W3cmY28N3UW7c8uNpKJcAKPtTwifWhGy8PnX8dSHnRdQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add pvp multi paths vhost performance testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000af59f3065c8fe25a"
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

--000000000000af59f3065c8fe25a
Content-Type: text/plain; charset="UTF-8"

>
>
> +
> +class Config(BaseConfig):
> +    """Performance test metrics."""
> +
> +    test_parameters: list[dict[str, int | float]] = [
> +        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 128, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 256, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 512, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 1024, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +        {"frame_size": 1518, "num_descriptors": 1024, "expected_mpps":
> 1.00},
> +    ]
> +    delta_tolerance: float = 0.05
> +


This test suite needs an example in tests_config.example.yaml for
configuration.
Also, Test suites that are new to next-dts need an accompanying doc file in
doc/api/dts.


>

+
> +@requires_link_topology(LinkTopology.TWO_LINKS)
> +class TestPvpMultiPathsVhostSingleCorePerformance(TestSuite):
> +    """pvp multi paths vhost single core performance test suite."""
> +
> +    config: Config
> +
> +    def set_up_suite(self):
> +        """Assign test parameters."""
> +        self.test_parameters = self.config.test_parameters
> +        self.delta_tolerance = self.config.delta_tolerance
>

nit: Missing (-> None) in method signature


> +
> +    def set_up_test_case(self):
> +        """Delete stale vhost-user Unix domain socket files."""
> +        self._ctx.sut_node.main_session.send_command("rm -rf
> /tmp/vhost-net*", privileged=True)
> +
>

nit: Missing (-> None) in signature


> +    def _transmit(
> +        self, vhost: TestPmd, virtio: TestPmd, frame_size: int,
> repetitions: int = 1
> +    ) -> float:
> +        """Transmit packets using testpmd instances and compute average
> MPPS.
> +
> +        Args:
> +            vhost: the running vhost testpmd shell.
> +            virtio: the running virtio testpmd shell.
> +            frame_size: The size of the frame to transmit.
> +            repetitions: The number of times to rerun the transmission.
> +
> +        Returns:
> +            The MPPS (millions of packets per second) forwarded by the
> SUT.
> +        """
> +        assert repetitions > 0, "Invalid number of repetitions given."
>

nit: Error message should include why this number of repetitions are invalid


> +    def _create_and_transmit(
> +        self,
> +        ring_format: int,
> +        in_order: int,
> +        buffers: int,
> +        vectorized: int,
> +        extra_args: TestPmdParamsDict,
> +    ) -> None:
> +        """Create testpmd instances with specified params and send
> traffic."""
>

Missing "Args:" tag


> +            with (
> +                TestPmd(**vhost_params) as vhost,
> +                TestPmd(**virtio_params) as virtio,
> +            ):
> +                vhost.set_forward_mode(SimpleForwardingModes.mac)
> +                virtio.set_forward_mode(SimpleForwardingModes.io)
> +                vhost.set_portlist([0, 2, 1])
> +
> +                params["measured_mpps"] = round(
> +                    self._transmit(vhost, virtio, frame_size,
> repetitions=5), 3
> +                )
> +                params["performance_delta"] = round(
> +                    (float(params["measured_mpps"]) -
> float(params["expected_mpps"]))
> +                    / float(params["expected_mpps"]),
> +                    3,
> +                )

+                params["pass"] = float(params["performance_delta"]) >=
> -self.delta_tolerance


This allows for a division by zero exception if the user supplies an
expected mpps of zero.

Other than these small things, the patch looks good.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000af59f3065c8fe25a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
+<br>
+class Config(BaseConfig):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Performance test metrics.&quot;&quot;&quot=
;<br>
+<br>
+=C2=A0 =C2=A0 test_parameters: list[dict[str, int | float]] =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 64, &quot;num_descrip=
tors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 128, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 256, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 512, &quot;num_descri=
ptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 1024, &quot;num_descr=
iptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;frame_size&quot;: 1518, &quot;num_descr=
iptors&quot;: 1024, &quot;expected_mpps&quot;: 1.00},<br>
+=C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 delta_tolerance: float =3D 0.05<br>
+</blockquote><div><br>This test suite needs an example in tests_config.exa=
mple.yaml for configuration.<br>Also, Test suites that are new to next-dts =
need an accompanying doc file in doc/api/dts.<br>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><span style=3D"background-color:transpa=
rent">=C2=A0</span></blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+<br>
+@requires_link_topology(LinkTopology.TWO_LINKS)<br>
+class TestPvpMultiPathsVhostSingleCorePerformance(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;pvp multi paths vhost single core performa=
nce test suite.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 config: Config<br>
+<br>
+=C2=A0 =C2=A0 def set_up_suite(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Assign test parameters.&quot=
;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_parameters =3D self.config.test_para=
meters<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.delta_tolerance =3D self.config.delta_tol=
erance<br></blockquote><div><br>nit: Missing (-&gt; None) in method signatu=
re<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 def set_up_test_case(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Delete stale vhost-user Unix=
 domain socket files.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ctx.sut_node.main_session.send_command(&=
quot;rm -rf /tmp/vhost-net*&quot;, privileged=3DTrue)<br>
+<br></blockquote><div><br>nit: Missing (-&gt; None) in signature<br>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 def _transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, vhost: TestPmd, virtio: TestPmd, frame_s=
ize: int, repetitions: int =3D 1<br>
+=C2=A0 =C2=A0 ) -&gt; float:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Transmit packets using testp=
md instances and compute average MPPS.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost: the running vhost testpmd=
 shell.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio: the running virtio testp=
md shell.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size: The size of the fram=
e to transmit.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repetitions: The number of times=
 to rerun the transmission.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The MPPS (millions of packets pe=
r second) forwarded by the SUT.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert repetitions &gt; 0, &quot;Invalid numbe=
r of repetitions given.&quot;<br></blockquote><div>=C2=A0</div><div>nit: Er=
ror message should include why this number of repetitions=C2=A0are invalid<=
br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 def _create_and_transmit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 in_order: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buffers: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vectorized: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create testpmd instances wit=
h specified params and send traffic.&quot;&quot;&quot;<br></blockquote><div=
><br>Missing &quot;Args:&quot; tag<br>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(**vhost_pa=
rams) as vhost,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmd(**virtio_p=
arams) as virtio,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.set_forward_=
mode(SimpleForwardingModes.mac)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio.set_forward=
_mode(SimpleForwardingModes.io)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost.set_portlist=
([0, 2, 1])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;measu=
red_mpps&quot;] =3D round(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._transmit(vhost, virtio, frame_size, repetitions=3D5), 3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;perfo=
rmance_delta&quot;] =3D round(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (flo=
at(params[&quot;measured_mpps&quot;]) - float(params[&quot;expected_mpps&qu=
ot;]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / fl=
oat(params[&quot;expected_mpps&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )</blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params[&quot;pass&=
quot;] =3D float(params[&quot;performance_delta&quot;]) &gt;=3D -self.delta=
_tolerance</blockquote><div><br>This allows for a division by zero exceptio=
n if the user supplies an expected mpps of zero.=C2=A0<br><br>Other than th=
ese small things, the patch looks good.<br><br>Reviewed-by: Andrew Bailey &=
lt;<a href=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;<br><b=
r></div></div></div>

--000000000000af59f3065c8fe25a--
