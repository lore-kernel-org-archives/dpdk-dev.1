Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB5DC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 16:04:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1887402A3;
	Tue, 29 Apr 2025 18:04:18 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 79EEB40277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 18:04:17 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-309fac646adso3857537a91.1
 for <dev@dpdk.org>; Tue, 29 Apr 2025 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745942656; x=1746547456; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HkGhcxO1r1YMM97rwmRTM/haKUrqVJKWceniFL6pL9E=;
 b=SSDA/O27d0m7MWUMLpZtJiDxHwFMSzebPEpjAGtbMhAF+01c70T6jh8hihgd1cHs4E
 26jKda4qCqflFAoSLyohJCmVh+j2Mdq+dUDvd/kh/5Vjrhk2vAU+BqdE7AA2a+7EkXay
 gbF1XI4hlq8YCydCywzeBVu/+tFQ3O2PEw5Jc6SSlOe9eCcamYikBQBuzlsScm1izY6/
 GMcJbKT85jF033qgoHHLlPY7tbt3wAGHwM733CqNXvZPyYTEhh0w9MKaviNlAZGLGet6
 FYr2N3x5JELd6EPr/OX+6h0YU5PRkrvrrKc1t/z2iu/CCe4uJQrr48T2fFADJYdrg81R
 Tisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745942656; x=1746547456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HkGhcxO1r1YMM97rwmRTM/haKUrqVJKWceniFL6pL9E=;
 b=Wiz7vPvTYOqUeTj+RaSpcdHYWH6EgbnGdYosK+6xr42rx3XvhHHTu59jn3uq7SApgl
 sFJycjC7ASD1FMA9bUuHh/ZGJ3nlB9eJ3PJ34TRGfzQ9sWBsyI1grX+usnRZF1NwvW3F
 WuTHKsMCInXV9bO15JR2bLZW4eVxUBdEKDH9THK4qyWeCXeaCy8Q/+eTA9aqLzxrDS+G
 SFR7QZ1C2k47hdQK9cfrYHBPNjfyBq+RRj0M1ALP5flAKsoqmoLFdpI5k912VXJMQsDN
 wGrOwj0aIxM92VyUV1IPngyjsWZQ+gTlFvEq4lqp2jFVohKcOXz968ZE70qLZHAcxU7I
 ULbQ==
X-Gm-Message-State: AOJu0Yyc86DIEkQzDufmQJ4d0/RdjfgHAbpOGGUkwinUPXXXSnKh1sba
 eYsIdNbW0BRw8C6cdpS1hs9oGwth2VNuEscvbS/WZC8I63IYarET8K9w7SaWSWvLLvqP2gyfeJz
 N+WaKdW9TLqr3JbHnCy0Spy9xvnN3Xwb7YqyD2g==
X-Gm-Gg: ASbGncuv05+L9GtyiVDYq2ZRFo1K2Il8CWf6alkP/r6FZx04zzJVMqJcllZ+gmcJhid
 PNWrHulEuScvSf14kT/D7joioYouq+TCT3KHTEWJWB8149TpZgKEuKBXvGexS+knCd6/72XA0RD
 hmD963gkWGqomkISvPfXVhq+Q=
X-Google-Smtp-Source: AGHT+IFCZW8c8lVHduJ1oyZy+yp7Ap1UlZdZUbR8dXWFhO1rbgf+siGmtNXlT60Kaxh0Gj32IzQBbrpR48EHnubMxVI=
X-Received: by 2002:a17:90b:3504:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-30a22444ab0mr4922058a91.3.1745942655925; Tue, 29 Apr 2025
 09:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABsV3rARRuh8Qhm4q+QCDAEmA8WP+6QK241ik4qoLyGJBPFdHg@mail.gmail.com>
 <aBDSliZlrdd1hOst@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aBDSliZlrdd1hOst@bricha3-mobl1.ger.corp.intel.com>
From: spyroot <spyroot@gmail.com>
Date: Tue, 29 Apr 2025 20:04:04 +0400
X-Gm-Features: ATxdqUG3Ohpzad75zHpWE6CYcK1DANI7v_WOKHq-08MoxjKfhNN0LCPMQBfhIPU
Message-ID: <CABsV3rCS61VvS08yh_g5wXDErV=utD=tYut8P=C1=-BCm0KTLQ@mail.gmail.com>
Subject: Re: 810 VFIO , SRIOV, multi-process stats read DPDK testpmd.
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000ce00f50633ecf3e7"
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

--000000000000ce00f50633ecf3e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much, Bruce, for taking the time.

I'm observing odd behavior when PF either does not show stats for some VF
or leaks VF stats from one to another.

i.e., generator A sent 100 packets to VF A and generator B 100 to VF B;
VF A and PF ICEN stats show 200 packets per VF stats.

(Note each flow is destined to the corresponding MAC of VF,
and prior to a generation, MAC entry is confirmed on the L2 switch, TX VF.
So the packets aren't flooded, nor is it an unknown unicast frame).

The second condition, PF, shows zero stats for one VFs, but two RX
instances of testpmd
show correct statistics. (i.e A should see 100, B should see 100, A and B
each report 100, but PF reports 0 for either A VF or B VF).

The results are the same whether tested on the same node (k8s)
i.e lo-locate with TX PODs or on two different k8s nodes.

Condition two is observed if you do a single flow (i.e., hash on RX ide
land packets to the same RX queue). PF doesn't account for or report
correct values if you have two readers (i.e., two DPDK instances).

(Note: TX reports correct stats for A and B)

i.e. A sent 100, B sent 100
switch shows 200.

TX - A - VF A -- (L2 switch) -- (RX side) VF A -- testpmd
TX - B - VF B - - (L2 switch) -- (RX side) VF B -- testpmd.

On the TX side, 3 points of measurement.
VF TX stats, PF TX stats, L2 switch (total pkt,ppks etc) TX and outgoing
port RX.

Kind Regards,
Mus

On Tue, Apr 29, 2025 at 5:22=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> On Mon, Apr 14, 2025 at 07:21:57PM +0400, spyroot wrote:
> >    Hi Folks,
> >
> >    I'm observing some unexpected behavior related to how statistics are
> >    retrieved from a Physical Function (PF) on an Intel 810 NIC.
> >
> >    Scenario: I have two dpdk-testpmd instances running in separate
> >    Kubernetes pods (same worker node). Each instance uses the -a flag t=
o
> >    bind to a different VF. (i.e to have consistent port id 0)
> >
> >    Questions:
> >     1. PF Statistics and 64B Line Rate:
> >        I'm noticing that the RX packet-per-second value reported on the
> PF
> >        side for a given VF is higher than the theoretical maximum for
> >        64-byte packets.
> >           + Does the Intel 810 PMD apply any kind of optimization,
> >             offloading, or fast path processing when two VFs (e.g., A a=
nd
> >             B) are on the same PF?
>
> This wouldn't be something that the PMD does. The forwarding from VF to V=
F,
> or PF to VF would happen internally in the hardware.
>
> >     2. Concurrent Stats Polling:
> >           + When two separate dpdk-testpmd processes are running (in po=
d
> A
> >             and pod B), does the PMD or driver layer support concurrent
> >             reading of PF statistics?
>
> Looking at the iavf PMD, the reading of stats is done by sending an admin=
q
> message to the PF and reading the response. Any serialization of stats
> reading would then be done at the PF or adminq management level. The VF
> should not need to worry about whether another VF is reading the stats at
> the same time. [In fact it would be a serious bug if one VF needed to be
> aware of what other VFs were doing, since different VFs could be attached
> to different virtual machines which should be isolated from each other]
>
> >           + Is there any locking or synchronization mechanism involved
> >             when multiple testpmd instances attempt to pull stats from
> the
> >             same PF simultaneously? ( in essence, does a firmware/OF
> >             support concurrent read).
> >
>
> See above.
>
> /Bruce
>
> >    Thank you,
> > cd /usr/local/bin && dpdk-testpmd \
> >   --main-lcore \$main -l \$cores -n 4 \
> >   --socket-mem 2048 \
> >   --proc-type auto --file-prefix testpmd_rx0 \
> >   -a \$PCIDEVICE_INTEL_COM_DPDK \
> >   -- --forward-mode=3Drxonly --auto-start --stats-period 1'"
> >
> > cd /usr/local/bin && dpdk-testpmd \
> >   --main-lcore \$main -l \$cores -n 4 \
> >   --socket-mem 2048 \
> >   --proc-type auto --file-prefix testpmd_rx1 \
> >   -a \$PCIDEVICE_INTEL_COM_DPDK \
> >   -- --forward-mode=3Drxonly --auto-start --stats-period 1'"
>

--000000000000ce00f50633ecf3e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thank you very much, Bruce, for taking th=
e time. <br><br>I&#39;m observing odd behavior when PF either does not show=
 stats for some VF <br>or leaks VF stats from one to another.<br><br>i.e., =
generator A sent 100 packets to VF A and generator B 100 to VF B; <br>VF A =
and PF ICEN stats show 200 packets per VF stats. <br><br>(Note each flow is=
 destined to the corresponding MAC of VF, <br>and prior to a generation, MA=
C entry is confirmed on the L2 switch, TX VF.=C2=A0 <br>So the packets aren=
&#39;t flooded, nor is it an unknown unicast frame). <br><br>The second con=
dition, PF, shows zero stats for one VFs, but two RX instances of testpmd <=
br>show correct statistics. (i.e A should see 100, B should see 100, A and =
B <br>each report 100, but PF reports 0 for either=C2=A0A VF or B VF).</div=
><div dir=3D"ltr">=C2=A0=C2=A0<br>The results are the same whether tested o=
n the same node (k8s) <br>i.e lo-locate with TX PODs or on two different k8=
s nodes.<br><br>Condition two is observed if you do a single flow (i.e., ha=
sh on RX ide land packets to the same RX queue). PF doesn&#39;t account for=
 or report correct values if you have two readers (i.e., two DPDK instances=
). <br><br>(Note: TX reports correct stats for A and B) <br><br>i.e. A sent=
 100, B sent 100<br>switch shows 200.<br><br>TX - A - VF A -- (L2 switch) -=
- (RX side) VF A -- testpmd<br>TX - B - VF B - - (L2 switch) -- (RX side) V=
F B -- testpmd.<br><br>On the TX side, 3 points of measurement. <br>VF TX s=
tats, PF TX stats, L2 switch (total pkt,ppks etc) TX and outgoing port RX.<=
br><br>Kind Regards,<br>Mus<br><br></div><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 29, 2025 a=
t 5:22=E2=80=AFPM Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@i=
ntel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Mon, Apr 14, 2025 at 07:21:57PM +040=
0, spyroot wrote:<br>
&gt;=C2=A0 =C2=A0 Hi Folks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 I&#39;m observing some unexpected behavior related to how=
 statistics are<br>
&gt;=C2=A0 =C2=A0 retrieved from a Physical Function (PF) on an Intel 810 N=
IC.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Scenario: I have two dpdk-testpmd instances running in se=
parate<br>
&gt;=C2=A0 =C2=A0 Kubernetes pods (same worker node). Each instance uses th=
e -a flag to<br>
&gt;=C2=A0 =C2=A0 bind to a different VF. (i.e to have consistent port id 0=
)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Questions:<br>
&gt;=C2=A0 =C2=A0 =C2=A01. PF Statistics and 64B Line Rate:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 I&#39;m noticing that the RX packet-per-sec=
ond value reported on the PF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 side for a given VF is higher than the theo=
retical maximum for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 64-byte packets.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ Does the Intel 810 PMD apply=
 any kind of optimization,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offloading, or fast pat=
h processing when two VFs (e.g., A and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0B) are on the same PF?<=
br>
<br>
This wouldn&#39;t be something that the PMD does. The forwarding from VF to=
 VF,<br>
or PF to VF would happen internally in the hardware.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A02. Concurrent Stats Polling:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ When two separate dpdk-testp=
md processes are running (in pod A<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and pod B), does the PM=
D or driver layer support concurrent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reading of PF statistic=
s?<br>
<br>
Looking at the iavf PMD, the reading of stats is done by sending an adminq<=
br>
message to the PF and reading the response. Any serialization of stats<br>
reading would then be done at the PF or adminq management level. The VF<br>
should not need to worry about whether another VF is reading the stats at<b=
r>
the same time. [In fact it would be a serious bug if one VF needed to be<br=
>
aware of what other VFs were doing, since different VFs could be attached<b=
r>
to different virtual machines which should be isolated from each other]<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ Is there any locking or sync=
hronization mechanism involved<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0when multiple testpmd i=
nstances attempt to pull stats from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0same PF simultaneously?=
 ( in essence, does a firmware/OF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0support concurrent read=
).<br>
&gt; <br>
<br>
See above.<br>
<br>
/Bruce<br>
<br>
&gt;=C2=A0 =C2=A0 Thank you,<br>
&gt; cd /usr/local/bin &amp;&amp; dpdk-testpmd \<br>
&gt;=C2=A0 =C2=A0--main-lcore \$main -l \$cores -n 4 \<br>
&gt;=C2=A0 =C2=A0--socket-mem 2048 \<br>
&gt;=C2=A0 =C2=A0--proc-type auto --file-prefix testpmd_rx0 \<br>
&gt;=C2=A0 =C2=A0-a \$PCIDEVICE_INTEL_COM_DPDK \<br>
&gt;=C2=A0 =C2=A0-- --forward-mode=3Drxonly --auto-start --stats-period 1&#=
39;&quot;<br>
&gt; <br>
&gt; cd /usr/local/bin &amp;&amp; dpdk-testpmd \<br>
&gt;=C2=A0 =C2=A0--main-lcore \$main -l \$cores -n 4 \<br>
&gt;=C2=A0 =C2=A0--socket-mem 2048 \<br>
&gt;=C2=A0 =C2=A0--proc-type auto --file-prefix testpmd_rx1 \<br>
&gt;=C2=A0 =C2=A0-a \$PCIDEVICE_INTEL_COM_DPDK \<br>
&gt;=C2=A0 =C2=A0-- --forward-mode=3Drxonly --auto-start --stats-period 1&#=
39;&quot;<br>
</blockquote></div></div>

--000000000000ce00f50633ecf3e7--
