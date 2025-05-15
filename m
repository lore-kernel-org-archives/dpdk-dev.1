Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AF1C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 19:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 207CA410DD;
	Thu, 15 May 2025 21:30:00 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 73A6641060
 for <dev@dpdk.org>; Thu, 15 May 2025 21:29:59 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-22e5df32197so13420245ad.0
 for <dev@dpdk.org>; Thu, 15 May 2025 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747337398; x=1747942198; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cy+2GgWFFxOmwk44oHgP3jBE1AZQnAh1OFcizZFVzQM=;
 b=fDGOkSLJkgliVqGpm15GMZxZMs6RGWOZeYHBy4vyDizO/Cda7/90ybhuhBYz2OJ1P1
 hOH1ofB97FFxMZLkOTwR8ttjlbE2yCcrG0PX0IA0LuOJ87hzRSzYu5HnuHzeNWd1T8DF
 bXZshx3u9Z2PBnpLKX/sRZ/bM+kqN462kcUh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337398; x=1747942198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cy+2GgWFFxOmwk44oHgP3jBE1AZQnAh1OFcizZFVzQM=;
 b=pRcYTjDZ/YvIjD0o/NqqpaCKGPzB2mUofZQNXkQ7HS70BRQBAjHVdKOcA0mES/B4db
 0a+5K9OBBcy8jGGkFQvfvQmcIE1kMCagpMVzNJXQIBabTrjlj31pSwvRUFellpz//iKb
 /u+w6IWR5SSwZUWjjFNOlPlfo509QbfmP7H3LTPrxGdcvpnoG8gL6PrYVAjYi/N3J112
 qDeo5PoI/Wjp0gDU8lj5GSRY/PxV6ULNxNG7SYuGNx6Ew9KSTbu0cUGe3Y52Bg2hU70Y
 e8yHep/WtIPMCPJvwSMzApR8E3AgdDziyYfq4n8qoBcNFF8cTyWhCdf/y02yAcr9e011
 kcJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrsKcz18Yx8HcPIPEqfvGfIVDcpZ2/sEee7xt1N0v0MsAStPiV8QI3wLGj3qcfNSwTNE8=@dpdk.org
X-Gm-Message-State: AOJu0YwBeiLvz+Dax8i+kGcUyNatPWAn1i1rxvcZtlqIq8dvBDFL4Xxv
 vm8UOHZiKv/CDaWNtz0d+WJNtdNs5zdrKC7j3L9n0y3xISTNNr/ZpxSUe2SfnH0xc54vyNyVwQO
 UDXfTW59FMmuoF7gNtAwLuAOQTtTY+KNVAKVRmDic8il8nCtj0/u5DEprCw==
X-Gm-Gg: ASbGncsRFsHxvkeiGwneTet1OMTBfwzWWUqclVDJeH+nqMENpJEIYeNW1JeT3lfSnQE
 iAJi3g9RfC3OHdKODReFMcm4UZG1P6FuNl+tKRlDbxPxApZAG4BLXJmxSEey/sCehdDzrowP5vu
 lNJsNsacKit3x/dK6k3AUvSs3c4scLwjoJn3gBu0eHQDkq1Z/iWe51cGDVIUt2POFx1A==
X-Google-Smtp-Source: AGHT+IF/SAiUZB5uOqqDI7wAbqAZ4gP0GMUgOns+A4MlZVGuMrs/8zdKrUxUkXPFJFF6Av4iVcGYJ4JBbFw6sxreZF0=
X-Received: by 2002:a17:903:289:b0:225:adf8:8634 with SMTP id
 d9443c01a7336-231d4561aebmr6700145ad.51.1747337398571; Thu, 15 May 2025
 12:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250423194011.1447679-5-npratte@iol.unh.edu>
In-Reply-To: <20250423194011.1447679-5-npratte@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 15 May 2025 15:25:15 -0400
X-Gm-Features: AX0GCFtV-dmmOhkbwYmOVKG5NpuoCZpc9rmaT5_eECZ9ybjKV2287AdMuYnSfi8
Message-ID: <CAJvnSUBt4D=jvYcbZacN1kDXL6pmukVeVq=g5XbkvwPG2b4tZw@mail.gmail.com>
Subject: Re: [RFC Patch v1 4/5] dts: add trex traffic generator to dts
 framework
To: Nicholas Pratte <npratte@iol.unh.edu>
Cc: ian.stokes@intel.com, yoan.picchi@foss.arm.com, paul.szczepanek@arm.com, 
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, luca.vizzarro@arm.com, 
 thomas.wilks@arm.com, dmarx@iol.unh.edu, stephen@networkplumber.org, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f1f076063531b018"
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

--000000000000f1f076063531b018
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 3:40=E2=80=AFPM Nicholas Pratte <npratte@iol.unh.ed=
u> wrote:

> Implement the TREX traffic generator for use in the DTS framework. The
> provided implementation leverages TREX's stateless API automation
> library, via use of a Python shell. As such, version control of TREX may
> be needed. The DTS context has been modified to include a performance
> traffic generator in addition to a functional traffic generator.
>

I think the statement is that only certain versions are confirmed to work
off of your implementation? I think usage of the term version control is
confusing since we are just talking about using particular versions of
TREX, and not using a "version control" tool like git. This is more about
listing approved versions of the dependency for the TG.

>
>
>          dpdk_build_env =3D DPDKBuildEnvironment(config.dpdk.build, sut_n=
ode)
>          dpdk_runtime_env =3D DPDKRuntimeEnvironment(config.dpdk, sut_nod=
e,
> dpdk_build_env)
> -        traffic_generator =3D
> create_traffic_generator(config.traffic_generator, tg_node)
> +        # There is definitely a better way to do this.
> +        tg_dpdk_runtime_env =3D None
> +        if (
> +            config.perf_traffic_generator.type =3D=3D
> TrafficGeneratorType.TREX
> +            or config.func_traffic_generator.type =3D=3D
> TrafficGeneratorType.TREX
> +        ):
>

We have this from the testrun config

perf: false # disable performance testing
func: true # enable functional testing

So, use if testrunconfig.perf =3D=3D true?

>
> +
> +@dataclass
> +class TrexPerformanceStats(PerformanceTrafficStats):
> +    """Data structure to store performance statistics for a given test
> run.
> +
> +    Attributes:
> +        packet: The packet that was sent in the test run.
> +        frame_size: The total length of the frame. (L2 downward)
> +        tx_expected_bps: The expected bits per second on a given NIC.
> +        tx_expected_cps: ...
>

"The expected connections per second" ? I think you just missed this one.


> +
> +        Attributes:
> +            ports: Related ports utilized in TG instance.
> +        """
> +        super().setup(ports)
> +        # Start TREX server process.
> +        try:
> +            self._logger.info("Starting TREX server process: sending 45
> second sleep.")
> +            privileged_command =3D self._os_session._get_privileged_comm=
and(
> +                f"""
> +                    cd /opt/v3.03/; {self._tg_config.remote_path}/t-rex-=
64
> +                     --cfg {self._tg_config.config} -i
> +                """
>

I know this was just a work in progress for RFC with some hardcoding, but
you already have tg_config.remote_path, right? So, the leading hardcoded cd
does not do anything, and even if you had to cd there you could use the
tg_config.remote_path?

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000f1f076063531b018
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 23,=
 2025 at 3:40=E2=80=AFPM Nicholas Pratte &lt;<a href=3D"mailto:npratte@iol.=
unh.edu">npratte@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Implement the TREX traffic generator for use in=
 the DTS framework. The<br>
provided implementation leverages TREX&#39;s stateless API automation<br>
library, via use of a Python shell. As such, version control of TREX may<br=
>
be needed. The DTS context has been modified to include a performance<br>
traffic generator in addition to a functional traffic generator.<br></block=
quote><div><br></div><div>I think the statement is that only certain versio=
ns are confirmed to work off of your implementation? I think usage of the t=
erm version control is confusing since we are just talking about using part=
icular versions of TREX, and not using a &quot;version control&quot; tool l=
ike git. This is more about listing approved versions of the dependency for=
 the TG.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpdk_build_env =3D DPDKBuildEnvironment(c=
onfig.dpdk.build, sut_node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpdk_runtime_env =3D DPDKRuntimeEnvironme=
nt(config.dpdk, sut_node, dpdk_build_env)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 traffic_generator =3D create_traffic_generator=
(config.traffic_generator, tg_node)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # There is definitely a better way to do this.=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tg_dpdk_runtime_env =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config.perf_traffic_generator.ty=
pe =3D=3D TrafficGeneratorType.TREX<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or config.func_traffic_generator=
.type =3D=3D TrafficGeneratorType.TREX<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br></blockquote><div><br></div><div>We have=
 this from the testrun config</div><div><br></div><div>perf: false # disabl=
e performance testing<br>func: true # enable functional testing</div><div><=
br></div><div>So, use if testrunconfig.perf =3D=3D true?</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><br>
+<br>
+@dataclass<br>
+class TrexPerformanceStats(PerformanceTrafficStats):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Data structure to store performance statis=
tics for a given test run.<br>
+<br>
+=C2=A0 =C2=A0 Attributes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: The packet that was sent in the test r=
un.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size: The total length of the frame. (L2=
 downward)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_expected_bps: The expected bits per second =
on a given NIC.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_expected_cps: ...<br></blockquote><div><br>=
</div><div>&quot;The expected connections per second&quot; ? I think you ju=
st missed this one.</div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Attributes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ports: Related ports utilized in=
 TG instance.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().setup(ports)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Start TREX server process.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.i=
nfo" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&quot;Starting TR=
EX server process: sending 45 second sleep.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged_command =3D self._os_=
session._get_privileged_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;&quot;&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd /=
opt/v3.03/; {self._tg_config.remote_path}/t-rex-64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0--cfg {self._tg_config.config} -i<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;=
<br></blockquote><div><br></div><div>I know this was just a work in progres=
s for RFC with some hardcoding, but you already have tg_config.remote_path,=
 right? So, the leading hardcoded cd does not do anything, and even if you =
had to cd there you could use the tg_config.remote_path?</div><div><br></di=
v><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">p=
robb@iol.unh.edu</a>&gt;=C2=A0</div></div></div>

--000000000000f1f076063531b018--
