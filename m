Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2A606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=dgBa2diW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215FB4064E;
	Tue,  3 Nov 2026 21:29:34 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTPS id B55F640272
 for <dev@dpdk.org>; Tue,  3 Nov 2026 21:29:32 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-5366ae57896so54806161cf.3
 for <dev@dpdk.org>; Tue, 03 Nov 2026 12:29:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793737771; cv=none;
 d=google.com; s=arc-20260327;
 b=lQnArizKg9EPhSCLk/+jExk8B6tK8YtkKAdp2yPB3zzwANe870Paj5nZfdQdnav+Nk
 U+IMTwZyWR5VhPgIBqAqZL9sfJNtGdaS32HYAqXLkwtxfSmIg9AEBTSLnlU96GSITvuT
 oZ/TFDGBc4YXd/Fp9bFaYmfwfF0veyF/P3YCzEzRDw2Z2L3nUnjLZwA9H9mWzYrOFcC4
 NHHF3bGDOFEvtvAqsWvFxQUDlM5TK1jPr23R/B57lWc3QdcAEbMnU6NaQTl2xjXQDbP2
 6SoACRFiYN4UuYxICvqGZdEDKzbrl011PY1B9AmnYet6Q0jKQyPihnoxDKwF6oFthP2/
 0QsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ghgRhQLLz1X3/z4w3juoFGftN1TCeJJ7F4raQDvc5Oo=;
 fh=PruOJbWVBoWzxSO5rmj6G7r7UYz1r36QCEms5CeyK+0=;
 b=peIDFzWwXazR94RS+HwgobMX6e3Tt0iqayxZVXPX+mOf3harTv8BPc/w6GQs0oFJCU
 UiGv2QmCqEckFVswxCFljzPSZK3aav9W37sXYie2VNTRbuwMXLbw0AALdWMx1nvgboq9
 BaX65r8qJb/zM9VMdaAeaKxAWzwBARZG2f6U10N8CTS2L9VzE65tTp2dA3xuRvLjUwLj
 mrXOAb57QUX1oUS7QJH1l4qiRja7ncMHOjpJ+DaXQLXyz0YOjhq29z92OoG868zcjwg/
 wQhr7yoBa1o7l3eJEtrS7M+2vjSl4WsxL0rUmnuoSB593c6rPighy6gaopVHLkAP0ODO
 Oizg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793737771; x=1794342571; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ghgRhQLLz1X3/z4w3juoFGftN1TCeJJ7F4raQDvc5Oo=;
 b=dgBa2diWaHE1H1a9/oXxbMJDExdhKvWtTh+XhskKalwyNuT6SfNQv9U1SrC97Ud9y4
 eXVy1yBXZCObJ/CMY4aHZLI8AT3Jtd58hAfOFv8CI108nv5MIivv7qwXcZ1O0loRx8tn
 QQLKVuVs9PpCRJlpVEdowYqkPrqgg8uiZXebY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793737771; x=1794342571;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ghgRhQLLz1X3/z4w3juoFGftN1TCeJJ7F4raQDvc5Oo=;
 b=HaHFxM+VtYTcE/wI6W4GeW2WgXfeXerbzVXh6k6jJMCVRq3q9J4GC/plH2M5TdZlDZ
 0ZDgiOZ8gg+zVNyGyV/Bf4vMf/hVaZCdYyFIsKx/f2L/MhadxhemjgV7WBMBm+5Ehrkb
 N5hUH6LxXrwWAqLOPKAhRo0Pvo3WJgJEnsXfAeBgK3Scm2f5LjsbSP1FttEmiLUWSl7z
 CBGX/0ZfLOnQMu6Y/Qkd1tgWj5jjzofQEf+K1CCv+CMq2SoeCgweFLseNFa1Yo4R005f
 PLXqVJY96oCk+wXPboQpS7SuIHGqXel6sfe4D6Rd6FG9WzlZB8KIGTKfXNd72S1i6Wrp
 DOvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBydC8b+Wp7EIO/UdrmQwj35bqMCRBw4lTTPCF7wHZY8osjA4oeeYRQWwD4nd9qvlAz/A2s=@dpdk.org
X-Gm-Message-State: APuU4Z9q2qvHQlkifBPVp/Ph7A4y2hh5BhXVf+doivEA8wSoTn2n/u7e
 9aSiVg71nuVlHV7cELhD/ktwV4YYRvD2KAND3sJNpsS5d5J8SSkx1GX8ngxkyJaVjqURsU+xHPb
 dejVojSuu1ai4rFGRi93tL2ZQRjElJezqhq/NM9jQvA==
X-Gm-Gg: AYBFou3FqUaRz9pHDb5thOg9jCaEupXWelOIZRUjcPhyVYrvNZgyESH+7NH5NpE4UG4
 dtLqxWB+cHlyByjvOhpNa12rFRhPPBefU63Hnk+GaSOwnsk/OKNONbeUHx6hHJBkAQ+7sibQbWY
 S3H7xRHjj3+6FHjQtPTa5/OYu0CYv1KhvoRQAKwOrVVGPSg5B7xo3F/8i2tBv0FLYLSo362GLmf
 NqAlXMe9f5+hc1ZPlQtrUcqrrrIgA/vWYqu8MsGUAM5TRxEuPfbedWjKSvJKk8JEAie4sPRWEjl
 BF7a7DUt/FkK/UrUosIJDwSPuxM8r9IY6bSDKQvyM6LPhgAgaCH1skjHBGVKzlszq2Mzsy44v4U
 61UhGefT6xaGwXwyPlf2GNAbAu82FMTqYM2O2d1Ej8K9wW/bUZdx9K5ozuUf17dNiYqCmSoWc4u
 Ak4tQRl7+EHVPpZHUfwBFzKxFQPfydaB+4RC2dRMnrVD4DRqhrKW1G9lseGLgidEzl2oV04Pqze
 /y0by2/94syAj1oV89F4cGeFQNt2qjga+aqf3oYINy3jVh1+A==
X-Received: by 2002:a05:622a:5c08:b0:536:566e:6b52 with SMTP id
 d75a77b69052e-542b6a73182mr228527641cf.27.1793737771523; Tue, 03 Nov 2026
 12:29:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261020173029.162255-1-knimoji@iol.unh.edu>
 <bf59fc3e-f831-4a92-8007-8a8badb454b6@arm.com>
In-Reply-To: <bf59fc3e-f831-4a92-8007-8a8badb454b6@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 3 Nov 2026 15:28:54 -0500
X-Gm-Features: AclHuK_tpGA8kYydhWUp3ezwA07-asDtENk7Uck3gy6-7ZUXc7YmLiVmUDo1Zk8
Message-ID: <CAKYPG+wUb40=AKXrDV0bnyHKGg6eQf9cYEQf_9oXrrZqMryYkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: add pvp multi paths vhost performance
 testsuite
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu, 
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000b131ea065f651e5f"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b131ea065f651e5f
Content-Type: text/plain; charset="UTF-8"

>
> > diff --git a/dts/framework/testbed_model/linux_session.py
> b/dts/framework/testbed_model/linux_session.py
> > index 8cc0d09d01..b5cc0a78a9 100644
> > --- a/dts/framework/testbed_model/linux_session.py
> > +++ b/dts/framework/testbed_model/linux_session.py
> > @@ -460,3 +460,7 @@ def configure_ipv4_forwarding(self, enable: bool) ->
> None:
> >           """Overrides
> :meth:`~.os_session.OSSession.configure_ipv4_forwarding`."""
> >           state = 1 if enable else 0
> >           self.send_command(f"sysctl -w net.ipv4.ip_forward={state}",
> privileged=True)
> > +
> > +    def clean_up_vhost(self) -> None:
> > +        """Overrides :meth:`~.os_session.OSSession.clean_up_vhost`."""
> > +        self.send_command("rm -rf /tmp/vhost-net*", privileged=True)
>
> I am not particularly pleased with the idea of deleting every
> vhost-net*, just thinking in case this would disrupt any other
> application. Would there be any better way of doing this?
>
>
The command should not interfere with other vhost-net files, as I point
specifically at the /tmp/vhost-net directory when creating the socket files
for the virtual devices in this specific testsuite. This was also the
command specified in the pvp_multi_paths_vhost_single_core_perf test plan,
so I believe it wouldn't affect other virtual devices.


> > +    def _create_and_transmit(
> > +        self,
> > +        ring_format: int,
> > +        in_order: int,
> > +        buffers: int,
> > +        vectorized: int,
> > +        extra_args: TestPmdParamsDict,
> > +    ) -> None:
> > +        """Create testpmd instances with specified params and send
> traffic.
> > +
> > +        Args:
> > +            ring_format: selects the virtio queue descriptor layout.
> > +            in_order: toggles in-order packet processing.
> > +            buffers: enables mergeable rx buffers.
> > +            vectorized: enables SIMD vectorized rx/tx data paths.
> > +            extra_args: extra/generic TestPmd arguments.
> > +        """
> > +        sut_dpdk_driver =
> self._ctx.sut_node.config.ports[0].os_driver_for_dpdk
> > +        vhost_user_vdev =
> VirtualDevice("net_vhost0,iface=/tmp/vhost-net,queues=1")
> > +        virtio_user_vdev = VirtualDevice(
> > +            "net_virtio_user0,"
> > +            "mac=00:11:22:33:44:10,"
> > +            "path=/tmp/vhost-net,"
> > +            "queues=1,"
> > +            f"packed_vq={ring_format},"
> > +            f"mrg_rxbuf={buffers},"
> > +            f"in_order={in_order},"
> > +            f"vectorized={vectorized}"
> > +        )
> > +
> > +        for params in self.test_parameters:
> > +            frame_size = params["frame_size"]
> > +            num_descriptors = params["num_descriptors"]
> > +
> > +            default_args: TestPmdParamsDict = {
> > +                "tx_ring":
> TXRingParams(descriptors=int(num_descriptors)),
> > +                "rx_ring":
> RXRingParams(descriptors=int(num_descriptors)),
> > +            }
> > +
> > +            if sut_dpdk_driver == "mlx5_core":
> > +                default_args["burst"] = 64
> > +                default_args["mbcache"] = 512
> > +            elif sut_dpdk_driver == "i40e":
> > +                default_args["rx_queues"] = 1
> > +                default_args["tx_queues"] = 1
>
> This could be a problematic bit as we tried our best in the past to make
> test suites as driver-agnostic as possible. Would these undermine that
> ability? Perhaps a comment is needed here.
>

I copied this over from the single_core_forward_perf testsuite, as it was
necessary to meet the performance baseline across different drivers. The
default burst size for testpmd is 32, but Mellanox NICs typically require
burst sizes of 64 and an optimized mbuf cache of 512 as the Mellanox
NIC capabilities are higher than the other NICs. Additionally, Intel NICs
require rx_queues and tx_queues to be manually set to 1 to ensure hardware
does not distribute traffic over multiple queues, which would cause
degraded performance.

As for the other changes mentioned, I will have those in my next version as
well. Thanks!

--000000000000b131ea065f651e5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">&gt; diff --git a/dts/framework/te=
stbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py=
<br>
&gt; index 8cc0d09d01..b5cc0a78a9 100644<br>
&gt; --- a/dts/framework/testbed_model/linux_session.py<br>
&gt; +++ b/dts/framework/testbed_model/linux_session.py<br>
&gt; @@ -460,3 +460,7 @@ def configure_ipv4_forwarding(self, enable: bool) =
-&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :m=
eth:`~.os_session.OSSession.configure_ipv4_forwarding`.&quot;&quot;&quot;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0state =3D 1 if enable else 0<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.send_command(f&quot;sysct=
l -w net.ipv4.ip_forward=3D{state}&quot;, privileged=3DTrue)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def clean_up_vhost(self) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.os_s=
ession.OSSession.clean_up_vhost`.&quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(&quot;rm -rf /tmp/vhost=
-net*&quot;, privileged=3DTrue)<br>
<br>
I am not particularly pleased with the idea of deleting every <br>
vhost-net*, just thinking in case this would disrupt any other <br>
application. Would there be any better way of doing this?<br>
<br></blockquote><div><br></div><div>The command should not interfere with =
other=C2=A0vhost-net files, as I point specifically at the /tmp/vhost-net d=
irectory when creating the socket files for the virtual devices in this spe=
cific testsuite. This was also the command specified in the=C2=A0<span styl=
e=3D"background-color:transparent">pvp_multi_paths_vhost_single_core_perf t=
est plan, so I believe it wouldn&#39;t affect other=C2=A0virtual devices.</=
span></div><div><span style=3D"background-color:transparent"><br></span></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 def _create_and_transmit(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format: int,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 in_order: int,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buffers: int,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vectorized: int,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: TestPmdParamsDict,<br>
&gt; +=C2=A0 =C2=A0 ) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create testpmd instance=
s with specified params and send traffic.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_format: selects the vi=
rtio queue descriptor layout.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in_order: toggles in-order =
packet processing.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffers: enables mergeable =
rx buffers.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vectorized: enables SIMD ve=
ctorized rx/tx data paths.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extra_args: extra/generic T=
estPmd arguments.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sut_dpdk_driver =3D self._ctx.sut_node.co=
nfig.ports[0].os_driver_for_dpdk<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user_vdev =3D VirtualDevice(&quot;n=
et_vhost0,iface=3D/tmp/vhost-net,queues=3D1&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_user_vdev =3D VirtualDevice(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;net_virtio_user0,&quo=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mac=3D00:11:22:33:44:=
10,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path=3D/tmp/vhost-net=
,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;queues=3D1,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;packed_vq=3D{ring_fo=
rmat},&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;mrg_rxbuf=3D{buffers=
},&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;in_order=3D{in_order=
},&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;vectorized=3D{vector=
ized}&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for params in self.test_parameters:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size =3D params[&quot=
;frame_size&quot;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_descriptors =3D params[=
&quot;num_descriptors&quot;]<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args: TestPmdParams=
Dict =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tx_ring=
&quot;: TXRingParams(descriptors=3Dint(num_descriptors)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rx_ring=
&quot;: RXRingParams(descriptors=3Dint(num_descriptors)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if sut_dpdk_driver =3D=3D &=
quot;mlx5_core&quot;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args[=
&quot;burst&quot;] =3D 64<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args[=
&quot;mbcache&quot;] =3D 512<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif sut_dpdk_driver =3D=3D=
 &quot;i40e&quot;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args[=
&quot;rx_queues&quot;] =3D 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_args[=
&quot;tx_queues&quot;] =3D 1<br>
<br>
This could be a problematic bit as we tried our best in the past to make <b=
r>
test suites as driver-agnostic as possible. Would these undermine that <br>
ability? Perhaps a comment is needed here.<br></blockquote><div><br></div><=
div>I copied this over from the single_core_forward_perf testsuite, as it w=
as necessary to meet the performance=C2=A0baseline across different drivers=
. The default burst size for testpmd is 32, but Mellanox NICs typically req=
uire burst sizes of 64 and an optimized mbuf cache of 512 as the Mellanox N=
IC=C2=A0capabilities are higher than the other=C2=A0NICs. Additionally, Int=
el NICs require rx_queues and tx_queues to be manually set to 1 to ensure h=
ardware does not distribute traffic over multiple queues, which would cause=
 degraded performance.</div><div><br></div><div>As for the other changes me=
ntioned, I will have those in my next version as well. Thanks!</div><div><b=
r></div><div>=C2=A0</div></div></div>

--000000000000b131ea065f651e5f--
