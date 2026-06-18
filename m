Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711CCCD98F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:43:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA8984027F;
	Thu, 18 Jun 2026 16:43:21 +0200 (CEST)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by mails.dpdk.org (Postfix) with ESMTP id 34E3F40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:43:20 +0200 (CEST)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-69efcc71a1fso1219552eaf.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 07:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781793799; cv=none;
 d=google.com; s=arc-20240605;
 b=jmk5kc/9sWMjM0Ntt4++oSwk+LI05zxZ/tVjjMa8w5rttpyFAV/X1CLkfUwZnAFhsa
 7mv65UmwqYSWFxHmkoyhD83c5nf4EIn75zjw1QMRC9PyPxN5wT41Xc4Tq8kTg80my7U9
 kIeYKQlthpAwPfWmfe9kWaPckLdD840l18tS5J3hkHiCSHZ49I5yVR731O+DkqN8QGMj
 y28e9nx1SzrFIqiAGE149L8GvaxFYDbwM6JJhjH+zYBsSVOL5rF5wraVKZKQnrWHphsO
 hulFRaA/2qUlVnYGON/+BkxdhCw6xijsM+xX6hzgbvPnMH5+YjJNbPlBXh/PzISNob7g
 /5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=AQUgzGLOszsFBruWmPzXJQ4EtAoEc1GdiIYFIbtXwYo=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=Z+kosYlclXuiBk31nJlQ27Ndo8hisKnn3W/brU18aReR8dwoKRaAeHJ3VcrQzC7Tf7
 wLJ7X89/0rQSgIjR9YhsopQgGdFBrFZJq/W6/jjr1Bv5RnqQl4tMNoGEpTMr1pBSCVs7
 gJ969ehbxBUW6ya3EdkbL4HvVDX8427DGKgSImSWEWKauBnk02GPDscOIVMwKZpZq9t0
 QWrk0tGHZ9FXeVCXDGSnCncKBwkiWfsuenR1CROuodGu5kHTpCYDZ+hOpwtkfh22L2Vx
 LVTme8TT8kawy4nDMnsN5ej2Mkj772sKiKNzrNazwQvhDeO0FADNWjqLpVFPeID2gkAc
 ivGA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=interfacemasters.com; s=google; t=1781793799; x=1782398599; darn=dpdk.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AQUgzGLOszsFBruWmPzXJQ4EtAoEc1GdiIYFIbtXwYo=;
 b=hu7r2es7DXh7hnouOGsmu9EzvCCJh0rfilDMTNrQ/p0JSnzOxL6HSR0iNlbFTVyGKs
 zfYkA3wXv7hs22Z2r892DLdoo9Iz2itshC8fuKumKmovD8qFiAWqAgLTkDAYW5EoCzXD
 pv5mzArnruYxs9SJ8vsA6ZMs1enDlZHfzjX4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781793799; x=1782398599;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQUgzGLOszsFBruWmPzXJQ4EtAoEc1GdiIYFIbtXwYo=;
 b=JVIVF/zUjvZYcMrAm1e3J4tFMnxVzac4MINi5IdvO/1Ywq5X/xSaHP6NUjsOakzxzr
 x5jfbyb32n7Kc/mzqfaAd2I5B+pu8dW+Nd3knDrlx9YoY/xwqDhkymGicCR9nop5Akqe
 jS4ZMlgVdYJzb37BK/ESiIgdSFH2HpKzNZUtdAIiQ+/kk0G3zc50mxryB1qAqryVHHkR
 I+4X1TP/4vpx6LjBxVQas7KMYZ4rQFPZzuPS4CQ14n3bzF9YrCavcpT6U3et02HM86Ns
 b7Z0NfQ8HGWCbevhnjd6VSpZXqfMWfUg7hVR/knzezWIjSkCWYoxEj2MdjyRHpqgrGeM
 Ln9Q==
X-Gm-Message-State: AOJu0YxwMjLjCO54ccadHJGsJprHZF7w+IWRK9uVem6lrJOkoKgSlXX9
 9p7sGfPiBUOvrqIZIMYFSxjWR8pPpVkmbFmdP0sbuO0K4Y2Dun7chFElZXdbTTCDP6jkUdINQ3e
 vsqSutw8KOPgMAw9mZMIE/3j+dRQdiyL2KcVxbLN+yu0sSSiPGh18/TY=
X-Gm-Gg: Acq92OHkLQfBS4Z6BDv5QzH8IROBTx0tNlmg9DpXWyuUARHL/VRCeeiKppvFlfv0aWy
 4kHWeUBP+MSs03KLuGosWdV+qe+Vjq75vpNS/Ur05tMNB69FiTUs8HSuFsG9y6AM32NhNxSElzs
 TWo+CNudLTFYBvdyzK8gqz3oPXpiFUj73lMHdhWQYNi2adg2T5GsKVQRdl1hx+He8k8PrtGg7En
 dxQxm74yx+iPc8VdIdltHexaOWYcsnpjaqMbZEOy1kftX5xDWrCOnHTS9CI5HgFKJMJWtpd
X-Received: by 2002:a05:6820:1885:b0:696:6440:9e2a with SMTP id
 006d021491bc7-6a0c7705d4amr3705042eaf.29.1781793799299; Thu, 18 Jun 2026
 07:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAL5H3VnP8CJbEaid9H5R+vKYd+-gooRDcixYy9xUR7myzsCa8w@mail.gmail.com>
In-Reply-To: <CAL5H3VnP8CJbEaid9H5R+vKYd+-gooRDcixYy9xUR7myzsCa8w@mail.gmail.com>
From: Taras Bilous <tarasb@interfacemasters.com>
Date: Thu, 18 Jun 2026 17:43:08 +0300
X-Gm-Features: AVVi8CeyfzgGQssXLipp65Ru2VMlz4s3sfLF7ZtsdPhRKNtE4x5ToxAvpr9GVR0
Message-ID: <CAL5H3VkwEUuB+Vn_uVqK2mjy9BCMvzpANFURkn=DvfT5bnSAcQ@mail.gmail.com>
Subject: Re: net/ice: VLAN mode changes after port reset or SIGKILL, VLAN RX
 offload broken
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000078732c06548832e7"
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

--00000000000078732c06548832e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

A quick update on this issue.

I can no longer reproduce the problem with DPDK 25.11.2 on the following
NIC:

   - Intel(R) Ethernet Network Adapter E810-CQDA2
   - Ethernet Controller E810-C for QSFP (rev 02)
   - Subsystem: Intel Ethernet Network Adapter E810-C-Q2

However, the issue is still reproducible with DPDK 25.11.2 on:

   - E810-C 100GbE Controller
   - Ethernet Controller E810-C for QSFP (rev 02)
   - Subsystem: Intel Ethernet 100G 2P E810-C Adapter

The same test scenario was used in both cases.

Thanks,
Taras

On Tue, Feb 10, 2026 at 11:05=E2=80=AFAM Taras Bilous <tarasb@interfacemast=
ers.com>
wrote:

> Hi All,
>
> I am seeing multiple issues with net_ice where VLAN mode changes after a
> device reset or an ungraceful application exit, which then breaks RX VLAN
> offloading.
>
> The same NIC and the same DDP package behave correctly after a cold start=
,
> but switch to a different VLAN mode after either port reset (or
> rte_eth_dev_reset()) in testpmd or after killing the application with
> SIGKILL. After that, VLAN tags appear to be stripped in hardware, but VLA=
N
> metadata is no longer delivered to vlan_tci in mbuf structure.
>
> *My setup is the following:*
> Debian Bookworm
> Ethernet controller: Intel(R) Ethernet Controller E810-C for QSFP
> Firmware (NVM): 4.91 and 4.51 were tested
> DDP: ICE COMMS Package 1.3.55.0 and 1.3.50.0 were tested
> DPDK: 25.11
>
> *First scenario: port reset in testpmd*
>
>> :~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -=
a
>> 0000:04:00.0 -a 0000:04:00.1 --  -i
>> EAL: Detected CPU lcores: 90
>> EAL: Detected NUMA nodes: 1
>> EAL: Detected static linkage of DPDK
>> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
>> EAL: Selected IOVA mode 'PA'
>> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
>> Package (double VLAN mode)
>> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
>> Package (double VLAN mode)
>> Interactive-mode selected
>> Warning: NUMA should be configured manually by using --port-numa-config
>> and --ring-numa-config parameters along with --numa.
>> testpmd: create a new mbuf pool <mb_pool_0>: n=3D267456, size=3D2176, so=
cket=3D0
>> testpmd: preferred mempool ops selected: ring_mp_mc
>> Configuring Port 0 (socket 0)
>> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 0).
>> Configuring Port 1 (socket 0)
>> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 1).
>> Port 0: link state change event
>> Port 0: link state change event
>> Checking link statuses...
>> Done
>> testpmd> port stop all
>> Stopping ports...
>> Checking link statuses...
>> Done
>> testpmd> port reset all
>> Resetting ports...
>> ETHDEV: Device with port_id=3D0 already stopped
>> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
>> Package (single VLAN mode)
>> ETHDEV: Device with port_id=3D1 already stopped
>> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
>> Package (single VLAN mode)
>
>
> After this reset, RX VLAN offload no longer behaves correctly. VLAN tags
> are stripped from packets, but VLAN TCI information is missing in the
> received mbufs vlan_tci fields.
>
> *Second scenario: killing the application with SIGKILL*
>
>> :~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -=
a
>> 0000:04:00.0 -a 0000:04:00.1 --  -i
>> EAL: Detected CPU lcores: 90
>> EAL: Detected NUMA nodes: 1
>> EAL: Detected static linkage of DPDK
>> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
>> EAL: Selected IOVA mode 'PA'
>> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
>> Package (double VLAN mode)
>> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
>> Package (double VLAN mode)
>> Interactive-mode selected
>> Warning: NUMA should be configured manually by using --port-numa-config
>> and --ring-numa-config parameters along with --numa.
>> testpmd: create a new mbuf pool <mb_pool_0>: n=3D267456, size=3D2176, so=
cket=3D0
>> testpmd: preferred mempool ops selected: ring_mp_mc
>> Configuring Port 0 (socket 0)
>> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 0).
>> Configuring Port 1 (socket 0)
>> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 1).
>> Port 0: link state change event
>> Port 0: link state change event
>> Checking link statuses...
>> Done
>> testpmd> Killed
>>
>
>
>> :~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -=
a
>> 0000:04:00.0 -a 0000:04:00.1 --  -i
>> EAL: Detected CPU lcores: 90
>> EAL: Detected NUMA nodes: 1
>> EAL: Detected static linkage of DPDK
>> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
>> EAL: Selected IOVA mode 'PA'
>> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
>> Package (single VLAN mode)
>> ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS
>> Package (single VLAN mode)
>> Interactive-mode selected
>> Warning: NUMA should be configured manually by using --port-numa-config
>> and --ring-numa-config parameters along with --numa.
>> testpmd: create a new mbuf pool <mb_pool_0>: n=3D267456, size=3D2176, so=
cket=3D0
>> testpmd: preferred mempool ops selected: ring_mp_mc
>> Configuring Port 0 (socket 0)
>> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 0).
>> Configuring Port 1 (socket 0)
>> ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 1).
>> Port 0: link state change event
>> Port 0: link state change event
>> Checking link statuses...
>> Done
>> testpmd>
>
>
> At this point the behavior is the same as after port reset: RX VLAN
> offloading is broken.
>
> The observed RX VLAN offloading behavior then is very similar to the issu=
e
> described in the following bug report, where VLAN stripping works but
> metadata is missing:
> https://bugs.dpdk.org/show_bug.cgi?id=3D1677
> The trigger is different, but the resulting VLAN RX offload behavior
> appears to be the same.
> I can reproduce this reliably and can provide more logs or information if
> needed.
>
> Best regards,
> Taras
>

--00000000000078732c06548832e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-isSelectedEnd">Hi,</p><p class=3D"gmail-=
isSelectedEnd">A quick update on this issue.</p><p class=3D"gmail-isSelecte=
dEnd">I can no longer reproduce the problem with DPDK 25.11.2 on the follow=
ing NIC:</p><ul><li>Intel(R) Ethernet Network Adapter E810-CQDA2</li><li>Et=
hernet Controller E810-C for QSFP (rev 02)</li><li>Subsystem: Intel Etherne=
t Network Adapter E810-C-Q2</li></ul><p class=3D"gmail-isSelectedEnd">Howev=
er, the issue is still reproducible with DPDK 25.11.2 on:</p><ul><li>E810-C=
 100GbE Controller</li><li>Ethernet Controller E810-C for QSFP (rev 02)</li=
><li>Subsystem: Intel Ethernet 100G 2P E810-C Adapter</li></ul><p class=3D"=
gmail-isSelectedEnd">The same test scenario was used in both cases.</p><p>T=
hanks,<br>Taras</p></div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 10, 2026 at 11:05=E2=
=80=AFAM Taras Bilous &lt;<a href=3D"mailto:tarasb@interfacemasters.com">ta=
rasb@interfacemasters.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><p>Hi All,<br><br>I am seeing mul=
tiple issues with net_ice where VLAN mode changes after a device reset or a=
n ungraceful application exit, which then breaks RX VLAN offloading.</p><p>=
The same NIC and the same DDP package behave correctly after a cold start, =
but switch to a different VLAN mode after either <code>port reset (or rte_e=
th_dev_reset())</code> in testpmd or after killing the application with SIG=
KILL. After that, VLAN tags appear to be stripped in hardware, but VLAN met=
adata is no longer delivered to vlan_tci in mbuf structure.</p><div><p><b><=
font size=3D"4">My setup is the following:</font></b></p><div>Debian Bookwo=
rm</div><div>Ethernet controller: Intel(R) Ethernet Controller E810-C for Q=
SFP<br>Firmware (NVM): 4.91 and 4.51 were tested<br>DDP: ICE COMMS Package =
1.3.55.0 and 1.3.50.0 were tested<br>DPDK: 25.11<p><b><font size=3D"4">Firs=
t scenario: port reset in testpmd</font></b><br></p><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">:~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/ap=
p/dpdk-testpmd -l 0-15 -a 0000:04:00.0 -a 0000:04:00.1 -- =C2=A0-i<br>EAL: =
Detected CPU lcores: 90<br>EAL: Detected NUMA nodes: 1<br>EAL: Detected sta=
tic linkage of DPDK<br>EAL: Multi-process socket /var/run/dpdk/rte/mp_socke=
t<br>EAL: Selected IOVA mode &#39;PA&#39;<br>ICE_INIT: ice_load_pkg_type():=
 Active package is: 1.3.55.0, ICE COMMS Package (double VLAN mode)<br>ICE_I=
NIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS Package (d=
ouble VLAN mode)<br>Interactive-mode selected<br>Warning: NUMA should be co=
nfigured manually by using --port-numa-config and --ring-numa-config parame=
ters along with --numa.<br>testpmd: create a new mbuf pool &lt;mb_pool_0&gt=
;: n=3D267456, size=3D2176, socket=3D0<br>testpmd: preferred mempool ops se=
lected: ring_mp_mc<br>Configuring Port 0 (socket 0)<br>ICE_DRIVER: ice_set_=
rx_function(): Using Vector AVX2 (port 0).<br>Configuring Port 1 (socket 0)=
<br>ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (port 1).<br>Port =
0: link state change event<br>Port 0: link state change event<br>Checking l=
ink statuses...<br>Done<br>testpmd&gt; port stop all<br>Stopping ports...<b=
r>Checking link statuses...<br>Done<br>testpmd&gt; port reset all<br>Resett=
ing ports...<br>ETHDEV: Device with port_id=3D0 already stopped<br>ICE_INIT=
: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS Package (sing=
le VLAN mode)<br>ETHDEV: Device with port_id=3D1 already stopped<br>ICE_INI=
T: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COMMS Package (sin=
gle VLAN mode)</blockquote><p><br></p><p>After this reset, RX VLAN offload =
no longer behaves correctly. VLAN tags are stripped from packets, but VLAN =
TCI information is missing in the received mbufs vlan_tci fields.</p><p><b>=
<font size=3D"4">Second scenario:=C2=A0killing the application with SIGKILL=
</font></b></p><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">:~$ sudo .=
/DPDK/dpdk-25.11.0/dpdk-25.11/build/app/dpdk-testpmd -l 0-15 -a 0000:04:00.=
0 -a 0000:04:00.1 -- =C2=A0-i<br>EAL: Detected CPU lcores: 90<br>EAL: Detec=
ted NUMA nodes: 1<br>EAL: Detected static linkage of DPDK<br>EAL: Multi-pro=
cess socket /var/run/dpdk/rte/mp_socket<br>EAL: Selected IOVA mode &#39;PA&=
#39;<br>ICE_INIT: ice_load_pkg_type(): Active package is: 1.3.55.0, ICE COM=
MS Package (double VLAN mode)<br>ICE_INIT: ice_load_pkg_type(): Active pack=
age is: 1.3.55.0, ICE COMMS Package (double VLAN mode)<br>Interactive-mode =
selected<br>Warning: NUMA should be configured manually by using --port-num=
a-config and --ring-numa-config parameters along with --numa.<br>testpmd: c=
reate a new mbuf pool &lt;mb_pool_0&gt;: n=3D267456, size=3D2176, socket=3D=
0<br>testpmd: preferred mempool ops selected: ring_mp_mc<br>Configuring Por=
t 0 (socket 0)<br>ICE_DRIVER: ice_set_rx_function(): Using Vector AVX2 (por=
t 0).<br>Configuring Port 1 (socket 0)<br>ICE_DRIVER: ice_set_rx_function()=
: Using Vector AVX2 (port 1).<br>Port 0: link state change event<br>Port 0:=
 link state change event<br>Checking link statuses...<br>Done<br>testpmd&gt=
; Killed<br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">:~$ sudo ./DPDK/dpdk-25.11.0/dpdk-25.11/build/app/dpdk-tes=
tpmd -l 0-15 -a 0000:04:00.0 -a 0000:04:00.1 -- =C2=A0-i<br>EAL: Detected C=
PU lcores: 90<br>EAL: Detected NUMA nodes: 1<br>EAL: Detected static linkag=
e of DPDK<br>EAL: Multi-process socket /var/run/dpdk/rte/mp_socket<br>EAL: =
Selected IOVA mode &#39;PA&#39;<br>ICE_INIT: ice_load_pkg_type(): Active pa=
ckage is: 1.3.55.0, ICE COMMS Package (single VLAN mode)<br>ICE_INIT: ice_l=
oad_pkg_type(): Active package is: 1.3.55.0, ICE COMMS Package (single VLAN=
 mode)<br>Interactive-mode selected<br>Warning: NUMA should be configured m=
anually by using --port-numa-config and --ring-numa-config parameters along=
 with --numa.<br>testpmd: create a new mbuf pool &lt;mb_pool_0&gt;: n=3D267=
456, size=3D2176, socket=3D0<br>testpmd: preferred mempool ops selected: ri=
ng_mp_mc<br>Configuring Port 0 (socket 0)<br>ICE_DRIVER: ice_set_rx_functio=
n(): Using Vector AVX2 (port 0).<br>Configuring Port 1 (socket 0)<br>ICE_DR=
IVER: ice_set_rx_function(): Using Vector AVX2 (port 1).<br>Port 0: link st=
ate change event<br>Port 0: link state change event<br>Checking link status=
es...<br>Done<br>testpmd&gt;=C2=A0</blockquote><div>=C2=A0</div>At this poi=
nt the behavior is the same as after port reset: RX VLAN offloading=C2=A0is=
 broken.<br></div><div><br>The observed RX VLAN offloading behavior then is=
 very similar to the issue described in the following bug report, where VLA=
N stripping works but metadata is missing:</div><div><a href=3D"https://bug=
s.dpdk.org/show_bug.cgi?id=3D1677" target=3D"_blank">https://bugs.dpdk.org/=
show_bug.cgi?id=3D1677</a><br>The trigger is different, but the resulting V=
LAN RX offload behavior appears to be the same.<br>I can reproduce this rel=
iably and can provide more logs or information if needed.</div><div><br>Bes=
t regards,<br>Taras</div></div></div>
</blockquote></div>

--00000000000078732c06548832e7--
