Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15209EA3F28
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 09:05:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 312A9400D7;
	Tue, 10 Feb 2026 10:05:19 +0100 (CET)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mails.dpdk.org (Postfix) with ESMTP id A81EA400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:05:17 +0100 (CET)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79636a659f9so9324427b3.2
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770714317; cv=none;
 d=google.com; s=arc-20240605;
 b=LA68PpVHxy4drNGSu9gI09OuRoGbJ4Z6jmFWA8tsOz8bHmaroYjN++fDDfL/ZQC1bJ
 JJF+cEQu0AOh823VtGO6KYjIVsPCefpQELZw8VpqlG0ZGwugVnpI5pNV51BZYzR5rIzZ
 7Qc8u56afGcxqyoix6KmPMjmwngG8bJWOBowHMlGw1NzDdDoN/c/dJVaFcvgJCG6rAOD
 LE2NGC9XC00bnl2e6cWaTwhXsHQ5pToo5dXWSmkXqvshBrniRywxCVGqqni1x2LAJFeF
 PWT9Ct3RefCKB+9SLA35Ni4vf+WXDqHvWnIjzuyD1e2r64WVBWmEwmq/EsyYoMnrUIWM
 0mKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=pyqo5CSSu2uUFj4Gghl7TWD9+Z4uHVmCQ7afObVpzZo=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=UTIS7BN6rgyOTC+Gsr7ReMCXVL71sXT2fwhBLRQdPryXm6W05O/DfREnyi6043q4qw
 LbXieEogrfaJFsZRoIdQd79n8CF93HhQxkQ2Omz0AqtI/WIme9iEIbQpfumWEvbBwjf7
 27APsN1HFBCeUp9IwsjWIzGkXKihGd/q+9zWZiNHQLRf0YPnWdJOl2TU0vmFjU2cTz9d
 pxAbSoEgWMOt4uZMnBPGbMrqyF00J9VMj/P+vAwatAf8W78ymlt7IKU9k1SPTolOPsnj
 tl1IAJUo4FX5k4Jlkhvi456BkpCyzeedKL1kd3ci2BXEgk9yJrrQBJmvCeXaVl/X0c+p
 RlyA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=interfacemasters.com; s=google; t=1770714317; x=1771319117; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pyqo5CSSu2uUFj4Gghl7TWD9+Z4uHVmCQ7afObVpzZo=;
 b=XB6X+GGc5zgQ+Mpv0AJp1MGJku1QiD6lzG/mSgr/Em7Yl98yZE7ILjoXPkR8oIWrJq
 LFmHNx6TdUcJea2B45JdoCJRP2oYEQskjAcOe2TVW9RaoLs6hAHmcfW+LK7OqFNqDjUI
 OT9jwF+ejoasjFCI14LDsZzf/8H876bVHZyNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770714317; x=1771319117;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pyqo5CSSu2uUFj4Gghl7TWD9+Z4uHVmCQ7afObVpzZo=;
 b=BfxH14d9AKeiP1RfXBqUsK8dvTJVSCcaekyQPVHKxIkn/sVzvIzCTxn9zNOK+dkSs8
 dbFF8c1sI6XVpMOOYgejIBYyyhFmZbMzcEYRibn90xfzFEXtm37mm+2m3jnLzoB+eaUU
 JCnPDFPCQRI7H5TzeiXMVsGiAQ4iX91gzRtBGXumpzidyNFYlQZVZweMgJwXwPRRl+Pz
 LqBoEZS4Aalg+lUgGE+Qaf0AQZg2u3rzltEgPTJPsZfeH9CuC62iEYRwyzaVJMhZ7bQQ
 leZ4LMm1PgeT4xMCP4/gLztSqsGTLi2H6x90JUg7NhHAKNrUzje+KiDlR2B3mq9wf8x+
 gv7w==
X-Gm-Message-State: AOJu0YxPwaqzvFBgf4YCyiPsHxEG/Bg/Q+yDvxFQPJINBvNowrNhwz77
 auRgw7sGOV/bjkce5KprolNje/9IxCdCN0KmuxFac8F906ko8tePdLpw2lTHX+wFruz+n57VGTH
 WdZJ0XE0/H5fJVx7B+ZyABPFDES+KnIdmYd0uAtn6vnWfgFuvnLtrLJk=
X-Gm-Gg: AZuq6aLAU6/kRpdV1vmjY+ZgweVJ9zHpeNnU2BdgdVjsWPJ7cVtBaMCtxf84hBAoznU
 GW+elUNIe7c/w2+cs4GdMFA58/0qV/aZlrdomSnLeGrkJ05FhALYjhhpHo4lNixQ4UHD1OTrvny
 hGsrG/4XHT8+5CDLch2sZKY8SN7kCWvFxfpQVrbmIUT4c8V6hXu+vq1i1ihINFRLxMUSQ6pbWdY
 0aDT4dwZz/yP1u90sR4vHB3C+J5H2mjHmjAKlJmXDwTe6U8henj45hR5KAxjH+oS4rDQgK0mEZM
 085MjQE=
X-Received: by 2002:a05:690c:498f:b0:796:3124:6565 with SMTP id
 00721157ae682-796312469e8mr186259367b3.1.1770714316671; Tue, 10 Feb 2026
 01:05:16 -0800 (PST)
MIME-Version: 1.0
From: Taras Bilous <tarasb@interfacemasters.com>
Date: Tue, 10 Feb 2026 11:05:06 +0200
X-Gm-Features: AZwV_QjezEoHMlF2_ND8WM-QgiMsg2MLHkJIoPbbZwZt1wEDFPp-VKSCftH1Edo
Message-ID: <CAL5H3VnP8CJbEaid9H5R+vKYd+-gooRDcixYy9xUR7myzsCa8w@mail.gmail.com>
Subject: net/ice: VLAN mode changes after port reset or SIGKILL, VLAN RX
 offload broken
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000d82075064a748d70"
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

--000000000000d82075064a748d70
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am seeing multiple issues with net_ice where VLAN mode changes after a
device reset or an ungraceful application exit, which then breaks RX VLAN
offloading.

The same NIC and the same DDP package behave correctly after a cold start,
but switch to a different VLAN mode after either port reset (or
rte_eth_dev_reset()) in testpmd or after killing the application with
SIGKILL. After that, VLAN tags appear to be stripped in hardware, but VLAN
metadata is no longer delivered to vlan_tci in mbuf structure.

*My setup is the following:*
Debian Bookworm
Ethernet controller: Intel(R) Ethernet Controller E810-C for QSFP
Firmware (NVM): 4.91 and 4.51 were tested
DDP: ICE COMMS Package 1.3.55.0 and 1.3.50.0 were tested
DPDK: 25.11

*First scenario: port reset in testpmd*

> :~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -a
> 0000:04:00.0 -a 0000:04:00.1 --  -i
> EAL: Detected CPU lcores: 90
> EAL: Detected NUMA nodes: 1
> EAL: Detected static linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'PA'
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
> Package (double VLAN mode)
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
> Package (double VLAN mode)
> Interactive-mode selected
> Warning: NUMA should be configured manually by using --port-numa-config
> and --ring-numa-config parameters along with --numa.
> testpmd: create a new mbuf pool <mb_pool_0>: n=267456, size=2176, socket=0
> testpmd: preferred mempool ops selected: ring_mp_mc
> Configuring Port 0 (socket 0)
> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 0).
> Configuring Port 1 (socket 0)
> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 1).
> Port 0: link state change event
> Port 0: link state change event
> Checking link statuses...
> Done
> testpmd> port stop all
> Stopping ports...
> Checking link statuses...
> Done
> testpmd> port reset all
> Resetting ports...
> ETHDEV: Device with port_id=0 already stopped
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
> Package (single VLAN mode)
> ETHDEV: Device with port_id=1 already stopped
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
> Package (single VLAN mode)


After this reset, RX VLAN offload no longer behaves correctly. VLAN tags
are stripped from packets, but VLAN TCI information is missing in the
received mbufs vlan_tci fields.

*Second scenario: killing the application with SIGKILL*

> :~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -a
> 0000:04:00.0 -a 0000:04:00.1 --  -i
> EAL: Detected CPU lcores: 90
> EAL: Detected NUMA nodes: 1
> EAL: Detected static linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'PA'
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
> Package (double VLAN mode)
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
> Package (double VLAN mode)
> Interactive-mode selected
> Warning: NUMA should be configured manually by using --port-numa-config
> and --ring-numa-config parameters along with --numa.
> testpmd: create a new mbuf pool <mb_pool_0>: n=267456, size=2176, socket=0
> testpmd: preferred mempool ops selected: ring_mp_mc
> Configuring Port 0 (socket 0)
> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 0).
> Configuring Port 1 (socket 0)
> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 1).
> Port 0: link state change event
> Port 0: link state change event
> Checking link statuses...
> Done
> testpmd> Killed
>


> :~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -a
> 0000:04:00.0 -a 0000:04:00.1 --  -i
> EAL: Detected CPU lcores: 90
> EAL: Detected NUMA nodes: 1
> EAL: Detected static linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'PA'
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
> Package (single VLAN mode)
> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
> Package (single VLAN mode)
> Interactive-mode selected
> Warning: NUMA should be configured manually by using --port-numa-config
> and --ring-numa-config parameters along with --numa.
> testpmd: create a new mbuf pool <mb_pool_0>: n=267456, size=2176, socket=0
> testpmd: preferred mempool ops selected: ring_mp_mc
> Configuring Port 0 (socket 0)
> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 0).
> Configuring Port 1 (socket 0)
> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 1).
> Port 0: link state change event
> Port 0: link state change event
> Checking link statuses...
> Done
> testpmd>


At this point the behavior is the same as after port reset: RX VLAN
offloading is broken.

The observed RX VLAN offloading behavior then is very similar to the issue
described in the following bug report, where VLAN stripping works but
metadata is missing:
https://bugs.dpdk.org/show_bug.cgi?id=1677
The trigger is different, but the resulting VLAN RX offload behavior
appears to be the same.
I can reproduce this reliably and can provide more logs or information if
needed.

Best regards,
Taras

--000000000000d82075064a748d70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-isSelectedEnd">Hi All,<br><br>I am seein=
g multiple issues with net_ice where VLAN mode changes after a device reset=
 or an ungraceful application exit, which then breaks RX VLAN offloading.</=
p><p class=3D"gmail-isSelectedEnd">The same NIC and the same DDP package be=
have correctly after a cold start, but switch to a different VLAN mode afte=
r either <code>port reset (or rte_eth_dev_reset())</code> in testpmd or aft=
er killing the application with SIGKILL. After that, VLAN tags appear to be=
 stripped in hardware, but VLAN metadata is no longer delivered to vlan_tci=
 in mbuf structure.</p><div><p class=3D"gmail-isSelectedEnd"><b><font size=
=3D"4">My setup is the following:</font></b></p><div>Debian Bookworm</div><=
div>Ethernet controller: Intel(R) Ethernet Controller E810-C for QSFP<br>Fi=
rmware (NVM): 4.91 and 4.51 were tested<br>DDP: ICE COMMS Package 1.3.55.0 =
and 1.3.50.0 were tested<br>DPDK: 25.11<p class=3D"gmail-isSelectedEnd"><b>=
<font size=3D"4">First scenario: port reset in testpmd</font></b><br></p><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">:~$ sudo ./DPDK/dpdk-25.11.=
0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -a 0000:04:00.0 -a 0000:04:00.1=
 -- =C2=A0-i<br>EAL: Detected CPU lcores: 90<br>EAL: Detected NUMA nodes: 1=
<br>EAL: Detected static linkage of DPDK<br>EAL: Multi-process socket /var/=
run/dpdk/rte/mp_socket<br>EAL: Selected IOVA mode &#39;PA&#39;<br>ICE_INIT:=
 ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS Package (doubl=
e VLAN mode)<br>ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0,=
 ICE COMMS Package (double VLAN mode)<br>Interactive-mode selected<br>Warni=
ng: NUMA should be configured manually by using --port-numa-config and --ri=
ng-numa-config parameters along with --numa.<br>testpmd: create a new mbuf =
pool &lt;mb_pool_0&gt;: n=3D267456, size=3D2176, socket=3D0<br>testpmd: pre=
ferred mempool ops selected: ring_mp_mc<br>Configuring Port 0 (socket 0)<br=
>ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 0).<br>Configur=
ing Port 1 (socket 0)<br>ICE_DRIVER: ice_set_rx_function(): Using Vector AV=
X2 (port 1).<br>Port 0: link state change event<br>Port 0: link state chang=
e event<br>Checking link statuses...<br>Done<br>testpmd&gt; port stop all<b=
r>Stopping ports...<br>Checking link statuses...<br>Done<br>testpmd&gt; por=
t reset all<br>Resetting ports...<br>ETHDEV: Device with port_id=3D0 alread=
y stopped<br>ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, IC=
E COMMS Package (single VLAN mode)<br>ETHDEV: Device with port_id=3D1 alrea=
dy stopped<br>ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, I=
CE COMMS Package (single VLAN mode)</blockquote><p class=3D"gmail-isSelecte=
dEnd"><br></p><p class=3D"gmail-isSelectedEnd">After this reset, RX VLAN of=
fload no longer behaves correctly. VLAN tags are stripped from packets, but=
 VLAN TCI information is missing in the received mbufs vlan_tci fields.</p>=
<p class=3D"gmail-isSelectedEnd"><b><font size=3D"4">Second scenario:=C2=A0=
killing the application with SIGKILL</font></b></p><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">:~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/app=
/dpdk-testpmd -l 0-15 -a 0000:04:00.0 -a 0000:04:00.1 -- =C2=A0-i<br>EAL: D=
etected CPU lcores: 90<br>EAL: Detected NUMA nodes: 1<br>EAL: Detected stat=
ic linkage of DPDK<br>EAL: Multi-process socket /var/run/dpdk/rte/mp_socket=
<br>EAL: Selected IOVA mode &#39;PA&#39;<br>ICE_INIT: ice_load_pkg_type(): =
Active package is: 1.3.55.0, ICE COMMS Package (double VLAN mode)<br>ICE_IN=
IT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS Package (do=
uble VLAN mode)<br>Interactive-mode selected<br>Warning: NUMA should be con=
figured manually by using --port-numa-config and --ring-numa-config paramet=
ers along with --numa.<br>testpmd: create a new mbuf pool &lt;mb_pool_0&gt;=
: n=3D267456, size=3D2176, socket=3D0<br>testpmd: preferred mempool ops sel=
ected: ring_mp_mc<br>Configuring Port 0 (socket 0)<br>ICE_DRIVER: ice_set_r=
x_function(): Using Vector AVX2 (port 0).<br>Configuring Port 1 (socket 0)<=
br>ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 1).<br>Port 0=
: link state change event<br>Port 0: link state change event<br>Checking li=
nk statuses...<br>Done<br>testpmd&gt; Killed<br></blockquote><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">:~$ sudo ./DPDK/dpdk-2=
5.11.0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -a 0000:04:00.0 -a 0000:04=
:00.1 -- =C2=A0-i<br>EAL: Detected CPU lcores: 90<br>EAL: Detected NUMA nod=
es: 1<br>EAL: Detected static linkage of DPDK<br>EAL: Multi-process socket =
/var/run/dpdk/rte/mp_socket<br>EAL: Selected IOVA mode &#39;PA&#39;<br>ICE_=
INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS Package (=
single VLAN mode)<br>ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.=
55.0, ICE COMMS Package (single VLAN mode)<br>Interactive-mode selected<br>=
Warning: NUMA should be configured manually by using --port-numa-config and=
 --ring-numa-config parameters along with --numa.<br>testpmd: create a new =
mbuf pool &lt;mb_pool_0&gt;: n=3D267456, size=3D2176, socket=3D0<br>testpmd=
: preferred mempool ops selected: ring_mp_mc<br>Configuring Port 0 (socket =
0)<br>ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 0).<br>Con=
figuring Port 1 (socket 0)<br>ICE_DRIVER: ice_set_rx_function(): Using Vect=
or AVX2 (port 1).<br>Port 0: link state change event<br>Port 0: link state =
change event<br>Checking link statuses...<br>Done<br>testpmd&gt;=C2=A0</blo=
ckquote><div>=C2=A0</div>At this point the behavior is the same as after po=
rt reset: RX VLAN offloading=C2=A0is broken.<br></div><div><br>The observed=
 RX VLAN offloading behavior then is very similar to the issue described in=
 the following bug report, where VLAN stripping works but metadata is missi=
ng:</div><div><a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1677">http=
s://bugs.dpdk.org/show_bug.cgi?id=3D1677</a><br>The trigger is different, b=
ut the resulting VLAN RX offload behavior appears to be the same.<br>I can =
reproduce this reliably and can provide more logs or information if needed.=
</div><div><br>Best regards,<br>Taras</div></div></div>

--000000000000d82075064a748d70--
