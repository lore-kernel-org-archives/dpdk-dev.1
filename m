Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45144C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:14:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98454406B4;
	Mon, 11 Aug 2025 12:14:01 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id D68E7406B4
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:13:59 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7e835e02d96so229045385a.2
 for <dev@dpdk.org>; Mon, 11 Aug 2025 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754907239;
 x=1755512039; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E8C731yE5Idp1uGCTxqOE+VTxeraK7L+RTrAnv1j3bk=;
 b=NLbwTiEhQZwkXlohjy9zQBtpiW9hB7SSiuU7yiHxNfzLlD89K3bjytzVrg4eMxCe3v
 dVd4SYW4FKI8op5Ws0WDRABvbLgmILSeVshVgCJyWCDC5QtQ+Mnd8646bGTOFaKv4A7y
 QZLPNwonKgF7bIkPucYrtClTZCZf7NbpRJlGI8tFYNwxv2XHm4UuGLZrBdP37OPjfhTc
 jimYi/4ovVNG3SwxwYo3MAYV1/hqfmx2EAtmP9rnnNXhoYZoXDaWMcdBo/JppkBOzR/z
 l2gcgPZGk8ciUlyHvUrBx/EF3io+K/gGhwVmrBt1ILJQwHrwdhi1X0lvxgguQrytcI4L
 UtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754907239; x=1755512039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E8C731yE5Idp1uGCTxqOE+VTxeraK7L+RTrAnv1j3bk=;
 b=SaUu+Rqt+X2CbW74DodBKCzASGWeK/avI+FlCxPj+4UJYSZH8nXXjS/EofCho7/XrK
 cjr34oUvTv/oBa53jkMlpu5+HyYHoBfTBsiep02wbbBOrmo0NtP39+OUND5lgp9ec/5E
 mKgodOl9NoLglBP4wZ9ryi/tLyTyTCpxWrcGwfpKcLA21McxiHPE0bN0DtXUybD27Rik
 hQr4RHshFYBLfWrG4JQ4aBsBfq9Tst/L+AYUGddYfh1CvIvaX3Lupx7eGaALui7Ccy0Z
 wtHH/il/vRTlLPzwjJbZq32ZR4TD1Rz6hM7L+bPQBArqYVHcMC36hWAIjhwIUZl/SEVk
 XhDQ==
X-Gm-Message-State: AOJu0Yx+Q8Q4l9S5tlNWJg8vn2mArlLab+SbiT7HgtV1qwHyFl7veWbX
 wrHskX6vkTPjRlnULhJGuDPLrVy00wjQCK+RsGb1cqspaSowiZ9RrZhyR/AI4qM8C7/3lVG/GS3
 JKPYjDliVrcuNBHdiVGIUGMMf1B8YtVqsqC/SeMl3tA==
X-Gm-Gg: ASbGncunEpTpIHXDMOz/+G7c6/Uvv49ClWrZvYLVXbe+wyg50K0cAt2m9vQhUN9neUv
 qqXSz4k17WYF/FWq5Joj8UDSzc7KBy/dP2rg+MfJWW2yJX5NINMhNMivxBTKqkha2kR2TnA6qBK
 UK+dLelp4kDdNUm9k5DJ+DJ8+VXH3Sz/McQTt3VL6eX2PZO59f+KHR4/TOs/h9B2mPZjBORO5S5
 Cka
X-Google-Smtp-Source: AGHT+IH/o5Gi4NXtVfWSPe/Vni+EvKLOT0ONMX6ugS0iFb4SaVK6wmC6fu+P+16/RnmKRaQqRAgdHtI2gjkhegzR67k=
X-Received: by 2002:a05:620a:3709:b0:7e8:211b:f538 with SMTP id
 af79cd13be357-7e82c5fe42cmr1756388285a.13.1754907238636; Mon, 11 Aug 2025
 03:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
 <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
 <7416c5c9-7485-4de1-8006-78a6df128080@oktetlabs.ru>
In-Reply-To: <7416c5c9-7485-4de1-8006-78a6df128080@oktetlabs.ru>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 15:13:46 +0500
X-Gm-Features: Ac12FXxAPt5UJjwUfKi9nv37_sY3np2SxuXIWRZ4aMbg6iFu3dHfHOtt9O_9BSM
Message-ID: <CA++2-x71R+MGC0_ZmC3p8jJ4=q3ZaW3zQeNwrGMp2UuXTkQm0Q@mail.gmail.com>
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, jasvinder.singh@intel.com, bruce.richardson@intel.com, 
 thomas@monjalon.net, ivan.malov@arknetworks.am, stable@dpdk.org
Content-Type: multipart/related; boundary="000000000000937111063c142efb"
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

--000000000000937111063c142efb
Content-Type: multipart/alternative; boundary="000000000000937110063c142efa"

--000000000000937110063c142efa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
You are right, but I haven't found any other reference to the specific
usage of the definition i.e. in correspondence with vxlan_decap,
tunneled offload API and in mbuf packet type .
According to tunnel offload API, vxlan encap/decap action, the inner header
represents the original header
while the outer represents the encapsulated ones.
if performed vxlan_decap, it will decapped the outermost and the inner
header will remain the original header.

Please also check tunnel offload api in
https://doc.dpdk.org/guides-20.11/prog_guide/rte_flow.html

Tunnel Offload API provides hardware independent, unified model to offload
tunneled traffic. Key model elements are:

   -

   apply matches to both outer and inner packet headers during entire
   offload procedure;
   -

   restore outer header of partially offloaded packet;
   -

   model is implemented as a set of helper functions.


E.g., the following two rules (tunnel offload) with  tunnel match and give
the innermost packet.
flow create 0 ingress group 0 tunnel_set 1 pattern eth / ipv4 / udp dst is
4789 / vxlan / end actions jump group 1 / end flow create 0 ingress group 1
tunnel_match 1 pattern eth / ipv4 / udp dst is 4789 / vxlan / eth / ipv4 /
end actions queue index 3 / end


pkt =3D
Ether(dst=3D'24:aa:aa:aa:aa:11',src=3D'50:bb:bb:bb:bb:22')/IP()/UDP(dport=
=3D4789,sport=3D4789)/VXLAN(vni=3D10)/
Ether(dst=3D'24:cc:cc:cc:cc:33',src=3D'50:dd:dd:dd:dd:44')/IP()/ UDP()

[image: image.png]
The outer headers were decapsulated and the inner header was redirected to
queue 3.

Incase of two tunneled packets, the outermost tunnel is stripped and the
packet from the inner tunnel onward is forwarded to queue 3.

You can also check  (Action: VXLAN_DECAP) that performs a decapsulation
action by stripping

all headers of the VXLAN tunnel network overlay from the matched flow.

So, according to vxlan_decap and tunnel offload api, the inner header
information must be the information of the innermost not the outmost.

and then the following would be correct in testpmd:
 92-bytes VXLAN packet size=3D (14-byte outer Ethernet header + 20-byte out=
er
IP header + 8-byte outer UDP header + 8-byte VXLAN header )+

 (14-byte inner Ethernet header + 20-byte inner IP header  + 8-byte inner
UDP)





On Mon, Aug 11, 2025 at 2:39=E2=80=AFPM Andrew Rybchenko <
andrew.rybchenko@oktetlabs.ru> wrote:

> On 8/1/25 14:28, Khadem Ullah wrote:
> > Hi Andrew,
> >
> > Thanks for your feedback.
> >
> > Please check mbuf packet types and the following test case:
> >
> https://doc.dpdk.org/dts-20.02/test_plans/uni_pkt_test_plan.html#test-cas=
e-vxlan-tunnel-packet-type-detect
> > sendp([Ether()/IP()/UDP()/Vxlan()/Ether()/IP(frag=3D5)/Raw('\0'*40)],
> > iface=3DtxItf)
> >
> > (outer) L2 type: ETHER
> > (outer) L3 type: IPV4_EXT_UNKNOWN
> > (outer) L4 type: Unknown
> > Tunnel type: GRENAT
> > Inner L2 type: ETHER
> > Inner L3 type: IPV4_EXT_UNKNOWN
> > Inner L4 type: L4_FRAG
> >
> >
> > union {
> >          uint32_t packet_type; /**< L2/L3/L4 and tunnel information. */
> >          __extension__
> >          struct {
> >            uint8_t l2_type:4;   /**< (Outer) L2 type. */
> >            uint8_t l3_type:4;   /**< (Outer) L3 type. */
> >            uint8_t l4_type:4;   /**< (Outer) L4 type. */
> >            uint8_t tun_type:4;  /**< Tunnel type. */
> >            union {
> >              uint8_t inner_esp_next_proto;
> >              /**< ESP next protocol type, valid if
> >               * RTE_PTYPE_TUNNEL_ESP tunnel type is set
> >               * on both Tx and Rx.
> >               */
> >              __extension__
> >              struct {
> >                uint8_t inner_l2_type:4;
> >                /**< Inner L2 type. */
> >                uint8_t inner_l3_type:4;
> >                /**< Inner L3 type. */
> >              };
> >            };
> >            uint8_t inner_l4_type:4; /**< Inner L4 type. */
> >          };
> >        };
> >
> >
> > Based on the above, it seems that inner_l2_len have to the length of
> Ether.
>
>
> Why?
>
> > Ther might need to be some correspondent between both fields to potray
> the same information.
> > Or, the inner_l2_type and inner_l2_len are completly different ?
>
> Definition says that it is different.
>
> >
> > Best Regards,
> > Khadem
>
>

--=20
Engr. Khadem Ullah,
Software Engineer,
Dreambig Semiconductor Inc
https://dreambigsemi.com/

--000000000000937110063c142efa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Andrew,=C2=A0</div><div>You are right, but I haven=
&#39;t=C2=A0found any other reference to the specific usage of the definiti=
on i.e. in correspondence=C2=A0with vxlan_decap,=C2=A0</div><div>tunneled o=
ffload API and in mbuf packet type .=C2=A0</div><div>According to tunnel of=
fload API, vxlan encap/decap action, the inner header represents the origin=
al header=C2=A0</div><div>while the outer represents the encapsulated ones.=
=C2=A0</div><div>if performed=C2=A0vxlan_decap, it will decapped the outerm=
ost and the inner header will remain the original header.=C2=A0</div><div><=
br></div><div>Please also check tunnel offload api in=C2=A0<a href=3D"https=
://doc.dpdk.org/guides-20.11/prog_guide/rte_flow.html">https://doc.dpdk.org=
/guides-20.11/prog_guide/rte_flow.html</a><br><p>Tunnel Offload API provide=
s hardware independent, unified model to offload tunneled traffic. Key mode=
l elements are:</p><ul class=3D"gmail-ak-ul"><li><p>apply matches to both o=
uter and inner packet headers during entire offload procedure;</p></li><li>=
<p>restore outer header of partially offloaded packet;</p></li><li><p>model=
 is implemented as a set of helper functions.</p></li></ul><br></div><div>E=
.g., the following two rules (tunnel offload) with=C2=A0 tunnel match and g=
ive the innermost packet.=C2=A0<br><span class=3D"gmail-prismjs gmail-_2rko=
glpi gmail-_1dqoglyw gmail-_1wyb1crf gmail-_k48pi7a9 gmail-_1e0c1txw gmail-=
_vwz4gktf gmail-_1reo1wug gmail-_o572qvpr gmail-_1eimjvyg gmail-_bfhktkvp g=
mail-_syaz1fxt gmail-_ect41odn gmail-_1ozdn7od gmail-_7xinn7od gmail-_t7aun=
7od gmail-_1v15u2gc gmail-_ilvcu2gc gmail-_m29uu2gc gmail-_17wyu2gc gmail-_=
pn28u2gc gmail-_gz9fu2gc gmail-_1hmyegat gmail-_vblregat gmail-_vbulegat gm=
ail-_wozj1yev gmail-_1agb1yev gmail-_lkm81yev gmail-_tv41hkgb gmail-_1hmimy=
b0 gmail-_1ra01n1a gmail-_1d4j1y44 gmail-_1f8gstnw gmail-_1pzyb3bt gmail-_j=
1w0ww7y gmail-_13cdh2mm gmail-_15ba126e gmail-_zvy9f705 gmail-_qcxof705 gma=
il-_14y71a66 gmail-_j0l11wug gmail-_1weckb7n gmail-_1na21hna gmail-_1xx2grf=
3 gmail-_x7c815vq gmail-_lh0y15vq gmail-_1m3815vq gmail-_qk1e15vq gmail-_12=
l6ysn8 gmail-_uga3ysn8 gmail-_mx8b7mnp gmail-_1kr87mnp gmail-_xo19t94y gmai=
l-_1bemt94y gmail-_nalpstnw gmail-_151dstnw gmail-_1exb1q9c gmail-_1hgu1q9c=
 gmail-_1mgnt94y gmail-_nhket94y gmail-_h909m7j4 gmail-_scgayz1z gmail-_ipl=
81e17 gmail-_jeky1l04 gmail-_1gec1a66 gmail-_1gx21e5h gmail-_1ls01ule gmail=
-_vm2c1rh5 gmail-_12ok1rh5 gmail-_rude1ule gmail-_1q16glyw gmail-_1io6glyw =
gmail-_juomusic gmail-_lcwuusic gmail-_1552u2gc gmail-_12afu2gc gmail-_28dd=
u2gc gmail-_1i8zu2gc gmail-_12tu1a66 gmail-_zu0j1a66 gmail-_euyxusvi gmail-=
_cahfusvi gmail-_zhnuidpf gmail-_1amdidpf gmail-_mbgcpf9b gmail-_bu7zpf9b g=
mail-_131n1giz gmail-_gy101giz gmail-_1wfuwrk5 gmail-_16kzwrk5 gmail-_9kk3m=
oej gmail-_cjus1w1g gmail-_9k2r1m30 gmail-_nhmw1m30 gmail-_yl021m30 gmail-_=
eiht5x2v gmail-_t9zb5x2v gmail-_mqok1w1g gmail-_3hsg1w1g gmail-_i7ngn7od gm=
ail-_9wu1fb2s gmail-_1xcoh55r gmail-_1t361fxt gmail-_137bh55r gmail-_1k7d1f=
xt gmail-_97lipnps gmail-_12nh9lu1 gmail-_1g0517qg gmail-_i2ig10m5 gmail-_3=
26z1fxt gmail-_113p131l gmail-_1n6tpnps gmail-_tgu817qg gmail-_1k47pnps gma=
il-_g0lx1fxt gmail-_ys4e131l gmail-_7gp8h55r gmail-_1yvq10m5 gmail-_1vww10m=
5 gmail-_1rju10m5 gmail-_1v0lh55r gmail-_wmyy17qg gmail-_748n17qg gmail-_1m=
fn17qg gmail-_1d7e17qg gmail-_p2vr17qg gmail-_19o610m5 gmail-_kxov17qg gmai=
l-_1np517qg gmail-_m2f517qg gmail-_1b9tpnps gmail-_1tq6pnps gmail-_1rd2pnps=
 gmail-_1pbkpnps gmail-_k3lipnps gmail-_13zt131l gmail-_2g12fb2s gmail-_k86=
b10m5 gmail-_b5iy131l gmail-_gti3131l gmail-_1f0gpnps gmail-_9d3e17qg gmail=
-_qdiapnps gmail-_72uvpnps gmail-_13dgkb7n gmail-_170714ej gmail-_1i3h1txw =
gmail-_1huoidpf gmail-_1a9lidpf gmail-_20bqidpf gmail-_1oggidpf gmail-_bymp=
idpf gmail-_9nnjidpf"><code class=3D"gmail-language-" style=3D"white-space:=
pre"><span class=3D"gmail-">
</span><span class=3D"gmail-"></span></code></span><span class=3D"gmail-pri=
smjs gmail-_2rkoglpi gmail-_1dqoglyw gmail-_1wyb1crf gmail-_k48pi7a9 gmail-=
_1e0c1txw gmail-_vwz4gktf gmail-_1reo1wug gmail-_o572qvpr gmail-_1eimjvyg g=
mail-_bfhktkvp gmail-_syaz1fxt gmail-_ect41odn gmail-_1ozdn7od gmail-_7xinn=
7od gmail-_t7aun7od gmail-_1v15u2gc gmail-_ilvcu2gc gmail-_m29uu2gc gmail-_=
17wyu2gc gmail-_pn28u2gc gmail-_gz9fu2gc gmail-_1hmyegat gmail-_vblregat gm=
ail-_vbulegat gmail-_wozj1yev gmail-_1agb1yev gmail-_lkm81yev gmail-_tv41hk=
gb gmail-_1hmimyb0 gmail-_1ra01n1a gmail-_1d4j1y44 gmail-_1f8gstnw gmail-_1=
pzyb3bt gmail-_j1w0ww7y gmail-_13cdh2mm gmail-_15ba126e gmail-_zvy9f705 gma=
il-_qcxof705 gmail-_14y71a66 gmail-_j0l11wug gmail-_1weckb7n gmail-_1na21hn=
a gmail-_1xx2grf3 gmail-_x7c815vq gmail-_lh0y15vq gmail-_1m3815vq gmail-_qk=
1e15vq gmail-_12l6ysn8 gmail-_uga3ysn8 gmail-_mx8b7mnp gmail-_1kr87mnp gmai=
l-_xo19t94y gmail-_1bemt94y gmail-_nalpstnw gmail-_151dstnw gmail-_1exb1q9c=
 gmail-_1hgu1q9c gmail-_1mgnt94y gmail-_nhket94y gmail-_h909m7j4 gmail-_scg=
ayz1z gmail-_ipl81e17 gmail-_jeky1l04 gmail-_1gec1a66 gmail-_1gx21e5h gmail=
-_1ls01ule gmail-_vm2c1rh5 gmail-_12ok1rh5 gmail-_rude1ule gmail-_1q16glyw =
gmail-_1io6glyw gmail-_juomusic gmail-_lcwuusic gmail-_1552u2gc gmail-_12af=
u2gc gmail-_28ddu2gc gmail-_1i8zu2gc gmail-_12tu1a66 gmail-_zu0j1a66 gmail-=
_euyxusvi gmail-_cahfusvi gmail-_zhnuidpf gmail-_1amdidpf gmail-_mbgcpf9b g=
mail-_bu7zpf9b gmail-_131n1giz gmail-_gy101giz gmail-_1wfuwrk5 gmail-_16kzw=
rk5 gmail-_9kk3moej gmail-_cjus1w1g gmail-_9k2r1m30 gmail-_nhmw1m30 gmail-_=
yl021m30 gmail-_eiht5x2v gmail-_t9zb5x2v gmail-_mqok1w1g gmail-_3hsg1w1g gm=
ail-_i7ngn7od gmail-_9wu1fb2s gmail-_1xcoh55r gmail-_1t361fxt gmail-_137bh5=
5r gmail-_1k7d1fxt gmail-_97lipnps gmail-_12nh9lu1 gmail-_1g0517qg gmail-_i=
2ig10m5 gmail-_326z1fxt gmail-_113p131l gmail-_1n6tpnps gmail-_tgu817qg gma=
il-_1k47pnps gmail-_g0lx1fxt gmail-_ys4e131l gmail-_7gp8h55r gmail-_1yvq10m=
5 gmail-_1vww10m5 gmail-_1rju10m5 gmail-_1v0lh55r gmail-_wmyy17qg gmail-_74=
8n17qg gmail-_1mfn17qg gmail-_1d7e17qg gmail-_p2vr17qg gmail-_19o610m5 gmai=
l-_kxov17qg gmail-_1np517qg gmail-_m2f517qg gmail-_1b9tpnps gmail-_1tq6pnps=
 gmail-_1rd2pnps gmail-_1pbkpnps gmail-_k3lipnps gmail-_13zt131l gmail-_2g1=
2fb2s gmail-_k86b10m5 gmail-_b5iy131l gmail-_gti3131l gmail-_1f0gpnps gmail=
-_9d3e17qg gmail-_qdiapnps gmail-_72uvpnps gmail-_13dgkb7n gmail-_170714ej =
gmail-_1i3h1txw gmail-_1huoidpf gmail-_1a9lidpf gmail-_20bqidpf gmail-_1ogg=
idpf gmail-_bympidpf gmail-_9nnjidpf"><code class=3D"gmail-language-" style=
=3D"white-space:pre"><span class=3D"gmail-">flow create 0 ingress group 0 t=
unnel_set 1 pattern eth / ipv4 / udp dst is 4789 / vxlan / end actions jump=
 group 1 / end
</span><span class=3D"gmail-"></span></code></span><span class=3D"gmail-pri=
smjs gmail-_2rkoglpi gmail-_1dqoglyw gmail-_1wyb1crf gmail-_k48pi7a9 gmail-=
_1e0c1txw gmail-_vwz4gktf gmail-_1reo1wug gmail-_o572qvpr gmail-_1eimjvyg g=
mail-_bfhktkvp gmail-_syaz1fxt gmail-_ect41odn gmail-_1ozdn7od gmail-_7xinn=
7od gmail-_t7aun7od gmail-_1v15u2gc gmail-_ilvcu2gc gmail-_m29uu2gc gmail-_=
17wyu2gc gmail-_pn28u2gc gmail-_gz9fu2gc gmail-_1hmyegat gmail-_vblregat gm=
ail-_vbulegat gmail-_wozj1yev gmail-_1agb1yev gmail-_lkm81yev gmail-_tv41hk=
gb gmail-_1hmimyb0 gmail-_1ra01n1a gmail-_1d4j1y44 gmail-_1f8gstnw gmail-_1=
pzyb3bt gmail-_j1w0ww7y gmail-_13cdh2mm gmail-_15ba126e gmail-_zvy9f705 gma=
il-_qcxof705 gmail-_14y71a66 gmail-_j0l11wug gmail-_1weckb7n gmail-_1na21hn=
a gmail-_1xx2grf3 gmail-_x7c815vq gmail-_lh0y15vq gmail-_1m3815vq gmail-_qk=
1e15vq gmail-_12l6ysn8 gmail-_uga3ysn8 gmail-_mx8b7mnp gmail-_1kr87mnp gmai=
l-_xo19t94y gmail-_1bemt94y gmail-_nalpstnw gmail-_151dstnw gmail-_1exb1q9c=
 gmail-_1hgu1q9c gmail-_1mgnt94y gmail-_nhket94y gmail-_h909m7j4 gmail-_scg=
ayz1z gmail-_ipl81e17 gmail-_jeky1l04 gmail-_1gec1a66 gmail-_1gx21e5h gmail=
-_1ls01ule gmail-_vm2c1rh5 gmail-_12ok1rh5 gmail-_rude1ule gmail-_1q16glyw =
gmail-_1io6glyw gmail-_juomusic gmail-_lcwuusic gmail-_1552u2gc gmail-_12af=
u2gc gmail-_28ddu2gc gmail-_1i8zu2gc gmail-_12tu1a66 gmail-_zu0j1a66 gmail-=
_euyxusvi gmail-_cahfusvi gmail-_zhnuidpf gmail-_1amdidpf gmail-_mbgcpf9b g=
mail-_bu7zpf9b gmail-_131n1giz gmail-_gy101giz gmail-_1wfuwrk5 gmail-_16kzw=
rk5 gmail-_9kk3moej gmail-_cjus1w1g gmail-_9k2r1m30 gmail-_nhmw1m30 gmail-_=
yl021m30 gmail-_eiht5x2v gmail-_t9zb5x2v gmail-_mqok1w1g gmail-_3hsg1w1g gm=
ail-_i7ngn7od gmail-_9wu1fb2s gmail-_1xcoh55r gmail-_1t361fxt gmail-_137bh5=
5r gmail-_1k7d1fxt gmail-_97lipnps gmail-_12nh9lu1 gmail-_1g0517qg gmail-_i=
2ig10m5 gmail-_326z1fxt gmail-_113p131l gmail-_1n6tpnps gmail-_tgu817qg gma=
il-_1k47pnps gmail-_g0lx1fxt gmail-_ys4e131l gmail-_7gp8h55r gmail-_1yvq10m=
5 gmail-_1vww10m5 gmail-_1rju10m5 gmail-_1v0lh55r gmail-_wmyy17qg gmail-_74=
8n17qg gmail-_1mfn17qg gmail-_1d7e17qg gmail-_p2vr17qg gmail-_19o610m5 gmai=
l-_kxov17qg gmail-_1np517qg gmail-_m2f517qg gmail-_1b9tpnps gmail-_1tq6pnps=
 gmail-_1rd2pnps gmail-_1pbkpnps gmail-_k3lipnps gmail-_13zt131l gmail-_2g1=
2fb2s gmail-_k86b10m5 gmail-_b5iy131l gmail-_gti3131l gmail-_1f0gpnps gmail=
-_9d3e17qg gmail-_qdiapnps gmail-_72uvpnps gmail-_13dgkb7n gmail-_170714ej =
gmail-_1i3h1txw gmail-_1huoidpf gmail-_1a9lidpf gmail-_20bqidpf gmail-_1ogg=
idpf gmail-_bympidpf gmail-_9nnjidpf"><code class=3D"gmail-language-" style=
=3D"white-space:pre"><span class=3D"gmail-">flow create 0 ingress group 1 t=
unnel_match 1 pattern eth / ipv4 / udp dst is 4789 / vxlan / eth / ipv4 / e=
nd actions queue index 3 / end</span></code></span></div><div><br></div><di=
v>=C2=A0</div><div><span class=3D"gmail-prismjs gmail-_2rkoglpi gmail-_1dqo=
glyw gmail-_1wyb1crf gmail-_k48pi7a9 gmail-_1e0c1txw gmail-_vwz4gktf gmail-=
_1reo1wug gmail-_o572qvpr gmail-_1eimjvyg gmail-_bfhktkvp gmail-_syaz1fxt g=
mail-_ect41odn gmail-_1ozdn7od gmail-_7xinn7od gmail-_t7aun7od gmail-_1v15u=
2gc gmail-_ilvcu2gc gmail-_m29uu2gc gmail-_17wyu2gc gmail-_pn28u2gc gmail-_=
gz9fu2gc gmail-_1hmyegat gmail-_vblregat gmail-_vbulegat gmail-_wozj1yev gm=
ail-_1agb1yev gmail-_lkm81yev gmail-_tv41hkgb gmail-_1hmimyb0 gmail-_1ra01n=
1a gmail-_1d4j1y44 gmail-_1f8gstnw gmail-_1pzyb3bt gmail-_j1w0ww7y gmail-_1=
3cdh2mm gmail-_15ba126e gmail-_zvy9f705 gmail-_qcxof705 gmail-_14y71a66 gma=
il-_j0l11wug gmail-_1weckb7n gmail-_1na21hna gmail-_1xx2grf3 gmail-_x7c815v=
q gmail-_lh0y15vq gmail-_1m3815vq gmail-_qk1e15vq gmail-_12l6ysn8 gmail-_ug=
a3ysn8 gmail-_mx8b7mnp gmail-_1kr87mnp gmail-_xo19t94y gmail-_1bemt94y gmai=
l-_nalpstnw gmail-_151dstnw gmail-_1exb1q9c gmail-_1hgu1q9c gmail-_1mgnt94y=
 gmail-_nhket94y gmail-_h909m7j4 gmail-_scgayz1z gmail-_ipl81e17 gmail-_jek=
y1l04 gmail-_1gec1a66 gmail-_1gx21e5h gmail-_1ls01ule gmail-_vm2c1rh5 gmail=
-_12ok1rh5 gmail-_rude1ule gmail-_1q16glyw gmail-_1io6glyw gmail-_juomusic =
gmail-_lcwuusic gmail-_1552u2gc gmail-_12afu2gc gmail-_28ddu2gc gmail-_1i8z=
u2gc gmail-_12tu1a66 gmail-_zu0j1a66 gmail-_euyxusvi gmail-_cahfusvi gmail-=
_zhnuidpf gmail-_1amdidpf gmail-_mbgcpf9b gmail-_bu7zpf9b gmail-_131n1giz g=
mail-_gy101giz gmail-_1wfuwrk5 gmail-_16kzwrk5 gmail-_9kk3moej gmail-_cjus1=
w1g gmail-_9k2r1m30 gmail-_nhmw1m30 gmail-_yl021m30 gmail-_eiht5x2v gmail-_=
t9zb5x2v gmail-_mqok1w1g gmail-_3hsg1w1g gmail-_i7ngn7od gmail-_9wu1fb2s gm=
ail-_1xcoh55r gmail-_1t361fxt gmail-_137bh55r gmail-_1k7d1fxt gmail-_97lipn=
ps gmail-_12nh9lu1 gmail-_1g0517qg gmail-_i2ig10m5 gmail-_326z1fxt gmail-_1=
13p131l gmail-_1n6tpnps gmail-_tgu817qg gmail-_1k47pnps gmail-_g0lx1fxt gma=
il-_ys4e131l gmail-_7gp8h55r gmail-_1yvq10m5 gmail-_1vww10m5 gmail-_1rju10m=
5 gmail-_1v0lh55r gmail-_wmyy17qg gmail-_748n17qg gmail-_1mfn17qg gmail-_1d=
7e17qg gmail-_p2vr17qg gmail-_19o610m5 gmail-_kxov17qg gmail-_1np517qg gmai=
l-_m2f517qg gmail-_1b9tpnps gmail-_1tq6pnps gmail-_1rd2pnps gmail-_1pbkpnps=
 gmail-_k3lipnps gmail-_13zt131l gmail-_2g12fb2s gmail-_k86b10m5 gmail-_b5i=
y131l gmail-_gti3131l gmail-_1f0gpnps gmail-_9d3e17qg gmail-_qdiapnps gmail=
-_72uvpnps gmail-_13dgkb7n gmail-_170714ej gmail-_1i3h1txw gmail-_1huoidpf =
gmail-_1a9lidpf gmail-_20bqidpf gmail-_1oggidpf gmail-_bympidpf gmail-_9nnj=
idpf"><code class=3D"gmail-language-" style=3D"white-space:pre"><span class=
=3D"gmail-"><span class=3D"gmail-">pkt =3D Ether(dst=3D&#39;24:aa:aa:aa:aa:=
11&#39;,src=3D&#39;50:bb:bb:bb:bb:22&#39;)/IP()/UDP(dport=3D4789,sport=3D47=
89)/VXLAN(vni=3D10)/</span></span></code></span></div><div><span class=3D"g=
mail-prismjs gmail-_2rkoglpi gmail-_1dqoglyw gmail-_1wyb1crf gmail-_k48pi7a=
9 gmail-_1e0c1txw gmail-_vwz4gktf gmail-_1reo1wug gmail-_o572qvpr gmail-_1e=
imjvyg gmail-_bfhktkvp gmail-_syaz1fxt gmail-_ect41odn gmail-_1ozdn7od gmai=
l-_7xinn7od gmail-_t7aun7od gmail-_1v15u2gc gmail-_ilvcu2gc gmail-_m29uu2gc=
 gmail-_17wyu2gc gmail-_pn28u2gc gmail-_gz9fu2gc gmail-_1hmyegat gmail-_vbl=
regat gmail-_vbulegat gmail-_wozj1yev gmail-_1agb1yev gmail-_lkm81yev gmail=
-_tv41hkgb gmail-_1hmimyb0 gmail-_1ra01n1a gmail-_1d4j1y44 gmail-_1f8gstnw =
gmail-_1pzyb3bt gmail-_j1w0ww7y gmail-_13cdh2mm gmail-_15ba126e gmail-_zvy9=
f705 gmail-_qcxof705 gmail-_14y71a66 gmail-_j0l11wug gmail-_1weckb7n gmail-=
_1na21hna gmail-_1xx2grf3 gmail-_x7c815vq gmail-_lh0y15vq gmail-_1m3815vq g=
mail-_qk1e15vq gmail-_12l6ysn8 gmail-_uga3ysn8 gmail-_mx8b7mnp gmail-_1kr87=
mnp gmail-_xo19t94y gmail-_1bemt94y gmail-_nalpstnw gmail-_151dstnw gmail-_=
1exb1q9c gmail-_1hgu1q9c gmail-_1mgnt94y gmail-_nhket94y gmail-_h909m7j4 gm=
ail-_scgayz1z gmail-_ipl81e17 gmail-_jeky1l04 gmail-_1gec1a66 gmail-_1gx21e=
5h gmail-_1ls01ule gmail-_vm2c1rh5 gmail-_12ok1rh5 gmail-_rude1ule gmail-_1=
q16glyw gmail-_1io6glyw gmail-_juomusic gmail-_lcwuusic gmail-_1552u2gc gma=
il-_12afu2gc gmail-_28ddu2gc gmail-_1i8zu2gc gmail-_12tu1a66 gmail-_zu0j1a6=
6 gmail-_euyxusvi gmail-_cahfusvi gmail-_zhnuidpf gmail-_1amdidpf gmail-_mb=
gcpf9b gmail-_bu7zpf9b gmail-_131n1giz gmail-_gy101giz gmail-_1wfuwrk5 gmai=
l-_16kzwrk5 gmail-_9kk3moej gmail-_cjus1w1g gmail-_9k2r1m30 gmail-_nhmw1m30=
 gmail-_yl021m30 gmail-_eiht5x2v gmail-_t9zb5x2v gmail-_mqok1w1g gmail-_3hs=
g1w1g gmail-_i7ngn7od gmail-_9wu1fb2s gmail-_1xcoh55r gmail-_1t361fxt gmail=
-_137bh55r gmail-_1k7d1fxt gmail-_97lipnps gmail-_12nh9lu1 gmail-_1g0517qg =
gmail-_i2ig10m5 gmail-_326z1fxt gmail-_113p131l gmail-_1n6tpnps gmail-_tgu8=
17qg gmail-_1k47pnps gmail-_g0lx1fxt gmail-_ys4e131l gmail-_7gp8h55r gmail-=
_1yvq10m5 gmail-_1vww10m5 gmail-_1rju10m5 gmail-_1v0lh55r gmail-_wmyy17qg g=
mail-_748n17qg gmail-_1mfn17qg gmail-_1d7e17qg gmail-_p2vr17qg gmail-_19o61=
0m5 gmail-_kxov17qg gmail-_1np517qg gmail-_m2f517qg gmail-_1b9tpnps gmail-_=
1tq6pnps gmail-_1rd2pnps gmail-_1pbkpnps gmail-_k3lipnps gmail-_13zt131l gm=
ail-_2g12fb2s gmail-_k86b10m5 gmail-_b5iy131l gmail-_gti3131l gmail-_1f0gpn=
ps gmail-_9d3e17qg gmail-_qdiapnps gmail-_72uvpnps gmail-_13dgkb7n gmail-_1=
70714ej gmail-_1i3h1txw gmail-_1huoidpf gmail-_1a9lidpf gmail-_20bqidpf gma=
il-_1oggidpf gmail-_bympidpf gmail-_9nnjidpf"><code class=3D"gmail-language=
-" style=3D"white-space:pre"><span class=3D"gmail-"><span class=3D"gmail-">=
Ether(dst=3D&#39;24:cc:cc:cc:cc:33&#39;,src=3D&#39;50:dd:dd:dd:dd:44&#39;)/=
IP()/ UDP()<br><br></span></span></code></span></div><div><img src=3D"cid:i=
i_me6xwrqy0" alt=3D"image.png" width=3D"578" height=3D"73"><br>The outer he=
aders were decapsulated and the inner header was redirected to queue 3.=C2=
=A0<br><p>Incase of two tunneled packets, the outermost tunnel is stripped =
and the packet from the inner tunnel onward is forwarded to queue 3.<br></p=
><p>You can also check=C2=A0 (Action: VXLAN_DECAP) that performs a decapsul=
ation action by stripping=C2=A0=C2=A0</p><p>all headers of the VXLAN tunnel=
 network overlay from the matched flow.<br><br></p><p>So, according to vxla=
n_decap and tunnel offload api, the inner header information must be the in=
formation of the innermost not the outmost.=C2=A0<br></p><p>and then the fo=
llowing would be correct in testpmd:=C2=A0<br>=C2=A092-bytes VXLAN packet s=
ize=3D (14-byte outer Ethernet header + 20-byte=20
outer IP header + 8-byte outer UDP header + 8-byte VXLAN header )+</p><p>=
=C2=A0(14-byte inner Ethernet header + 20-byte inner IP header=C2=A0 + 8-by=
te inner
 UDP) <br></p><p><br></p><p><br></p><br></div></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon,=
 Aug 11, 2025 at 2:39=E2=80=AFPM Andrew Rybchenko &lt;<a href=3D"mailto:and=
rew.rybchenko@oktetlabs.ru">andrew.rybchenko@oktetlabs.ru</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 8/1/25 14:28, K=
hadem Ullah wrote:<br>
&gt; Hi Andrew,<br>
&gt; <br>
&gt; Thanks for your feedback.<br>
&gt; <br>
&gt; Please check mbuf packet types and the following test case:<br>
&gt; <a href=3D"https://doc.dpdk.org/dts-20.02/test_plans/uni_pkt_test_plan=
.html#test-case-vxlan-tunnel-packet-type-detect" rel=3D"noreferrer" target=
=3D"_blank">https://doc.dpdk.org/dts-20.02/test_plans/uni_pkt_test_plan.htm=
l#test-case-vxlan-tunnel-packet-type-detect</a><br>
&gt; sendp([Ether()/IP()/UDP()/Vxlan()/Ether()/IP(frag=3D5)/Raw(&#39;\0&#39=
;*40)],<br>
&gt; iface=3DtxItf)<br>
&gt; <br>
&gt; (outer) L2 type: ETHER<br>
&gt; (outer) L3 type: IPV4_EXT_UNKNOWN<br>
&gt; (outer) L4 type: Unknown<br>
&gt; Tunnel type: GRENAT<br>
&gt; Inner L2 type: ETHER<br>
&gt; Inner L3 type: IPV4_EXT_UNKNOWN<br>
&gt; Inner L4 type: L4_FRAG<br>
&gt; <br>
&gt; <br>
&gt; union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t packet_type; /**&lt; L2/L3/=
L4 and tunnel information. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __extension__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t l2_type:4;=C2=A0 =C2=
=A0/**&lt; (Outer) L2 type. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t l3_type:4;=C2=A0 =C2=
=A0/**&lt; (Outer) L3 type. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t l4_type:4;=C2=A0 =C2=
=A0/**&lt; (Outer) L4 type. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t tun_type:4;=C2=A0 /**=
&lt; Tunnel type. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t inner_esp_next=
_proto;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt; ESP next proto=
col type, valid if<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* RTE_PTYPE_TUNN=
EL_ESP tunnel type is set<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* on both Tx and=
 Rx.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __extension__<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t inner_l=
2_type:4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt; Inner L=
2 type. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t inner_l=
3_type:4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt; Inner L=
3 type. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t inner_l4_type:4; /**&=
lt; Inner L4 type. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; <br>
&gt; <br>
&gt; Based on the above, it seems that inner_l2_len have to the length of E=
ther.<br>
<br>
<br>
Why?<br>
<br>
&gt; Ther might need to be some correspondent between both fields to potray=
 the same information.<br>
&gt; Or, the inner_l2_type and inner_l2_len are completly different ?<br>
<br>
Definition says that it is different.<br>
<br>
&gt; <br>
&gt; Best Regards,<br>
&gt; Khadem<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div style=3D"font-family:Calibri,Aria=
l,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><span style=3D"colo=
r:rgb(12,100,192)">Engr. Khadem Ullah, </span><br></div><div style=3D"font-=
family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">=
<span style=3D"color:rgb(12,100,192)">Software Engineer, </span><br></div><=
span style=3D"color:rgb(12,100,192)">Dreambig Semiconductor Inc <br></span>=
</div><div dir=3D"ltr"><span style=3D"color:rgb(12,100,192)"><a href=3D"htt=
ps://dreambigsemi.com/" target=3D"_blank">https://dreambigsemi.com/</a><br>=
</span></div></div></div></div>

--000000000000937110063c142efa--

--000000000000937111063c142efb
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_me6xwrqy0>
X-Attachment-Id: ii_me6xwrqy0

iVBORw0KGgoAAAANSUhEUgAAA8MAAAB5CAYAAAAdzPO4AAAABHNCSVQICAgIfAhkiAAAABl0RVh0
U29mdHdhcmUAZ25vbWUtc2NyZWVuc2hvdO8Dvz4AAAAxaVRYdENyZWF0aW9uIFRpbWUAAAAAANmI
IDE0OjU4OjE4INiqIDExINin2q/Ys9iqIDIwMjXtTqKUAAAgAElEQVR4nOydd0AU19bAf7MF2F16
702QIiAIioqiomJBULCmWFNMfXklz5SXvPTEdJOXbmxRo8ZujCX2XkEREFCQ3ntnWXbn+wM0xpKQ
fKnvze8vZc+cc+bOnZl7zrn3jiCKokg3/fv3R0JCQkJCQkJCQkJCQkLiv5UzZ84AIPud/fgdkaEw
6cWI2fOZ3M8c4fd2R0JC4mYEFTaeAxgzZRLRvur/4vtUiV3vKO6Y/zCzYrxR/N7uSEhISEhISEj8
D3D7YFjlSJ/Bg/Cz/LWHnwKCxok+gyLpbfFbDnVlKFS+xEyPJ9LN5M89yBbkKC1c6dO/H97mv+GZ
KM1xGvAgH331KQ/0U/12diV+c+TmboRPf44lS97kLzEuyH8rw4IaO/cwRoyLIsDe+Ley+tsjyFFb
O+Ht54uL5S9wnnIVVq6+BAT2wlH9p366SUhISEhISEj8atw2GFZ4JfKvFx8hxulXLh4LMox7JfHU
cw8x7Ne29d+KQoVVnyk8/sRcoux/bhvKMDJ1YdCcF1mycQd7dm1m2esPM85Hc9tEgVKlwSOiL7a1
yZy62PZzvf8TIKA0dSA4/jEWLv6Kb77dy+6v1/DRv+9ltK/pnzuR0kNkRirMbJ1wtrLC3t7yT1O5
lKnsCRr7MK+//zaPj/f47YL43xnBzJN+Y+7mvjtG4v+bJhklJCQkJCQkJP48/FnGtBK/MnK1Nb0T
/s6CJFtS17/L8lJzwhOmc9/Talr/+TaHagw3HKFEpfEioq81NWdOcbH9d3H7N0JEFEDX0ciVPUvY
XtCEsWtfYuJimfOggap/LeX8f3MuANBV53JixdPM+9qEtvJStL+3Qz+CoDTF3jeSuCmTGT8kELOq
VPb83k5JSEhISEhISEj8obg5GFaE8tja95ji0FVhvPOzg9wJIOqp+/oJJr95Ch0gyC0JSryfeXED
8HOzQKzO5uiGT/hoYzoNIoCAzNSXCfMfZlq0P84WSnQt9VTlfct7T3zCmRYBuSqCx1a9RWJ3NXPW
4oPMAkS9lqptTzHjnbPoldYMuvdp5g3rjYudKUb6JkovHmXLssVsSq3DIFOgCpzGCwumEeJkTFtJ
BqfSdfgN7YtNcwZfv/cqS07XYUCGwtyHMfc+xF0xfbBXtlF5pQqFHPIBkKEwdmLAmD60nD7ChfI2
xJsapycIKNWORM1bwOyhPjjbmqLQ1VOUdpgtK5axLb0eQ7c9pakbUXfcz8yx/XA31VKecYStXyxn
8/ka9ACCEpV9X+LvSmBIiB/udlaYqeV01BRwbNmzvPpNJRqHKB755AXG23a1oc+yg9wPGNpqyN30
PPd/cp7OH/VZidrch5iRntTue5O3Vp2kWVBxsRDsX57K+BFuHN1Q0OXTtUNUmHpHEGJVzenTmdcF
R3JMLDwZNHUOd4wJx8vGCENzDQWZZ9m96mM2pXVg7jKAWc8+jN/Jl/nr8gw6BTX2PnE89lo8rYv/
zmu7qzEgx8TSnf6TZjJjVBhedka0Fpxj74YVrNpzmWbRCCv3Qcx86n56nXiFf3xxkU7BFEe/OB59
YSzNnz/O63tquvRYexI5aSbTR/bF08aI5oKz7N2wki/35tDcw4vc2VRB1u5lZF29yhn5VChceDLW
BRdrGedLriYL5Jg5BzFu/t9IdC7k6w/eZE1q00/rS3I1tl79GT9lHAMDe+FqZ4HGWKCp4Dx7VrzF
xwcrMKBAY+/DoEl3MWV4MO5WMhpyT7N7w5esP3SFlu57UGnmRMDQiUyLjybEyw6NrJ2a3LPsWbuY
JYdKMAgKTB16M3jinUweHoSbpYz6yyfZtWENG4/k0aKwwy9qBo8/Nw1/BRhqczi9aRFPr0hFd9Vd
ax8GJT3Aff1q2fjG62zL1wMCapcQRs+8n/Fmx/ngpdWkaRWYOQUwZNIMEqODcDWH2kvH2blhLZuP
FdAqAjI1dr6RxN99J+PDPdB0NNLQ2EGnvoS8HjeggMbZj4Fj4gjpuMDXK9Px7u/7U65AN0psekUQ
e8cc4sPdsTVXom8oJuPoDjZt2sGJ/Oau62pkT+DQScy7P54QGzWyjlryUg6wbcNGdqdW0CECyDCx
9iR0RAJJYwcT6G6NidhKxcXDbFu7kvVnGm6yrrDyZcjEmcwYAGfWfsqqIyVoMcLKM5ThE6cwYbA/
ThodFemH+HrDJnaeLaZNsKHPyKnc+9c7ieheMtF/+ExApKPwFFu/+IgPd+ehV5jj0XcEk2YkMizI
BXOlntbaHE5+s4E1aw+S90fPdkhISEhISEhI/ALcHAx3ZvLFYzPZ3nsGC5+N4MxLT7Luih4Q0TdV
dQVWgpo+c9/mzYkd7Fz8Nksut2LTbyoPzF/Ik2338K9vKhBlRgTPfYHHoopZvegpTpS2IDezw8VB
S0kbgIihPY3lj81he8B0XvpnX06/+i825OkBA52N1XQCMrkG9z4huFRv5OU3T9Fm4ky/+Jnc9+pC
rJ78G4svdqK088bfNp91Ty2jaNjfWBDTyNpXn6Ny+F948IEpHEn5nByFPSP++gp/7VfFziUvcrxK
jVfEBKb06j5vQUBu5kHo+AeZ9JeHKT6xi21ff8Oes4W03FgU/UEEZEpT3P39sSndxEtvJKM1dSdi
wnTue8kLy2eeYHlGO0q1A4MfeJkFUU3sW/kaiytNCRgznVnPvYDFswtYkt4KMiUqp36MHhVMy44l
vHu2jPo2AwoTNbriSgx00lJ9ms/+Op/dYVP4x2wPTrzzGl8X6sHQSUdTzfcD2NshN8LY2g8vSy05
l8rxuet1/jGilS3vf0V6oZK43j6YCgXdSY4ulGpTevUPwbLqOCczO7r/KsPY0p2h85/jrwO1nNjw
DkuzW1C7DWHK3X0JdDZhc1rHLV24sQ2NrTyImvM0D/arZteqhXxWYYTX4Ikk3fNP1O1PsehwU4/0
mNh4M3TOE9wfUsmulQv5tNKEXlEJTJz3D1Ttz/CfIzX8pMsLyJSmOPqEMWKAC60FW8isvE6DYIzG
3J2AYC/sZdCntz2y1KaeXYerKEyx9gpnaIQTlbuWsOZCJU06AbkMmotrMSBD7RhAzOzHuNOnhF3L
XuWTOjP8ouMZN+cRjLUv8dmJehRWngyY9CiPTXKi4sROPluXQ1WbgLGRnJbCWkRkaJyCGDX7EaZ5
FrFryaukNVgQMGwCo+c+hLH2VT4/XUveqVU8O3sHzr0iGJ84Cosb3NU31lGVfZmaIcH4BTghyy/G
IJhgZeOOn6uS6lPp5GhlmLqGMmbWA0x0yWf34lfIaLaiz/A4Rs6ej5H2DZafacGqVwST7rufUaZZ
7PhwFbl6F0KjRzHQ+ac0oEhzQTJbF6WwDVM8B8Th/nM2yhfkqK0c8HQyofr4Mv5zsBAT91CGx07k
/oft0XywmD0FWtA1U37xIF8uSmZFYwfGTiEMGz+aSXfKaav+iL3FBowdgomZfh9zojXkH9vMhyvz
qdUpMZFpqSlpuCFZImBs48fAxJlM7mfg1JrFrDlaglaUY9l7MBPvvouhptns/mg9uTpnwkeNZfzM
mSg6PmR9aj05x9byekkWw8fGEe1Syf41GzhTZUDUtdHU0JUYtPKLZOyUBPp0nGLp88e40iJgZqVB
bCyjrie3qISEhISEhITEfwG3mCatpa6kkCaLJnQGHU3lBRQUXD+UF5Bbj2DmFAfOvHU37++tRwSE
7HwUfl/yxKjB2O7cTBVyrKzNERsLSD13nsx6A5BN+nWaRLGd2pJCWq2b0Bk6aLyFrS5BA/rKi5xJ
PoeWVFJT8+G9d5gwfSjrnz+AARGDvpa8zExSTC/RMlxJXmoqyfJ05kS64qpSUGg7ggmDTDj/6Yss
2lKOAQXnMwQCYx/BGEDUo60+zscPzWBd7yjGxscx9bkl3Ft7jr3btrHt25NcafjxGut3J9eJrvwi
p5NT6CCV9PRCeP0FxiVFsTnrCKLzMBKGmpLxxdMs2lSEHjmpF0tRvvYSsUlRbMrYQ12XIjo7mrh8
bBeHzt1s36Bvpaa0GLlLMx36dhrKbmzDHiCTobAwx1Rs5XKTAVN/Z6ws6rExaae4UYfcwhJLGTRc
VSsYoTb1ISLIjIqjp8i+ViJUY+E6lHEDlKStfpaFGwroFNTY1joyfEbfnvsj12DlFsXoCD2HP3iF
JSeaEJGRU1qDsfO/GDs4DMujh3+82io3w8Z9MCNDOzj04WssPdml50pZLcaOCxg5KBTLY/uo7Wk0
LLfALSSJBW/Moa+ilYqLe/n8/d1c0V0nI7ZSXXicVW8vIsu+lpS9eT8tEP5OEe2NFVw8vpcjF2+4
7gprHL0HEuXbwP5P3uSLs82IyMmvbkZlO5/wiGAsTqdg6t6P2BF2FO38gFc+PUbtjQ2msMHZJ5KB
XrXs/fRtViZ36SmobcHEeh7BEX2wOH2U+rY6youaMWg8aergpmCYzgaqKzLJro4kqE8fHHcXU2Zi
ja1nIO7Kco6lZNOmsCXAdwARrhXs+exdVp9rQURBYX076jl3EtgvEIu0PFx8+hNsVcyBpf9h2bFa
RJkNFa1mOM32+RlN2DW9/f+LqG2iuiCDs2cy0CWnk1/WwOyZQxkcFcjxwnO0iK3Ull2itqz7gKxy
tDJLbBOccHc1RygFr4BwosPkpG36gPfXJH8vsQSAYNL9DzmmruGMnx3GKPcK9i5extZzlXQAGDnh
2yccP00OO5Z8xKaMVkSUlLYZUE8bhV+QL6YXkmlqraeitIKqhlbarRqoLimgoOz6Ti7H2NgYtZGe
2suXSUtLo6D1582DkZCQkJCQkJD4M/PT1wwLoPDpg7/KDIunN7L3qet+UigQixywEaDS0MbJLz7i
8Et/4e21UaQe2c++PbvYd7boJ1Zab8SAQZtPcmo1kwf74aU4QO73fhYRERBkV/8tQ5DJUbp74i5W
8k1W1Q9WAkWDlpqs/azOPsi6T1wJHz+Lh+Y+R2z8Zp665yNSdT9w8G3Ro2sr4HxGHeP6+uBpfIJS
j164U86O9LLuYEmPTltCelYdcSG9cJfvoe43H5+K6BrLOfHBg8z+Atr1VgyLvVlKUKow9e1PsFkl
h05dujZdVlAaofLwxElXzvbzxT2Ynn1rBCMTNB6+BLn4EfnKFiZebQdBQDC0UJZig6VAd7LgB/QY
d+txCyTy1S0kfk9PEyVnrLEEanvqmL6Z8qytLHwkBU+fUIaOjWXOk4/Cq4vYXfRdx+hsrSH32Obv
98tfEEGlwcytF8E+4US+sZUZ152XrLOWy0essDRSY2Lnga2hhgvnz9+yLwlqU8xdvQnuPYDIN7dy
1/f0VJPVbIWFAPU/2g87qa8qJeNiJQPCQghx2ku9zA7vQFdkxQc4e6kdQeOMuasXwQH9iXx7G7Ov
t6WrJL3OEguNGlMHazQtlRQW1v/MZQq/MoYWaquKuFItEurijL3sHPlyS9z7DmfS5DgG9nZAIzOg
FwX0NRnkKRUIJhos7Z3RtJaRejGTxh84MZm1PwODfOiVd4Ltny9m47naa88rmbklVk4ehIYHMzAs
loeu6pHJkLUXcDLfHDMBmn604fRUXkrl6PFA5t3xGIsGxXHq4B72HjpJWl4t2j9kw0tISEhISEhI
/PL8QDAs3n4wKgigL2H7i/9ifd73Q0uxo5EKfdfx7Xnf8NLcE6wdFMOoESOZ/fJ05mSs5IXnviD1
eyPCH7B1O98MIoIg3GI7bAMGvYh4o0KRrgp2D/b+FWRGWPYayJj4CYwbEYZdQzr7vj5O8c8r8XXb
FxFFsSsQ+3Hhn2Pg5wcPBgOdDY00CxqsLJUYdM3U1MhQ2zpjaW6Evq6B+muXWcBIbY5f/2A0Ffs5
dfmG7IAg/ogvImBAFAVk8h/Y21fQ01yRyrb3FrG75Lo+JhrQtTVQrQdNT/TQSWNZClv/8x++/Z4e
Pbq2Rqp/UmJGj66tlpLsWkouXSb3Sj33LUhi5NBe7Psy62cH/z8HQeigNv8E6z/5jAPXV/3ETrQt
jdQaVHhjwACIhh/qGR3U5B5l3Wefc6j8OjmxE21LA9f2TfuRzqVvqKIkI42SgYMICw/gcpk/QR6Q
t+10d+VcQKCDqksH2fP5co5WXKfQ0El7SwN1Bgecu+9ThD/uDsii2OWkgIBMUOESPJwZ907Dt/ow
KxceJadRjc+gWMYMUF89AFEUMYggij/c4cSWcgovlVOlCWDEpCSKKldzuOC7/QsE2ig+t4Pdq9Zz
pvr6NtTR2lRP3TX14g/ehYbmIs5sXkT2ie2EDRnJqOF386/xkzi3bQXL1h+nqF2KiCUkJCQkJCT+
+7l9MKzT0iGo0ZjK4PqJniJ05mZyWTeaAB8jyg9m/+DOsqKulkuHN3DpyCaWe03n1Q/mct/Yvfzl
q5LvKrQ6LTqZGo3mBlu3REAmdyKojy26/Ct8b0awoYPGw68z5TAgN8L82t/1dORdJk8cQmi4O8qs
K9xc4BWQm9gTFJPAxAljiPIzoeLst2x77WO+PZ1H4/8r0pGjMHIkoLc1HYX5FHV0oivIpZAIAoOc
kGd3TZNWGrsQ5G9Fe94VCvX80Fegv48oInbq6JSpUGl+RhCh70Bbe4m8ugRCQoNQHzlFi2CMiWUQ
fdw6KD51+buNpgQjVGZ+RASpKNtzkpzr2kXUdaAtKqbSyA8/PztkOeW3qMIb0Hc20dyqwNTREXPZ
hZum74odWloLCyiT+eLhLFJ2vICblzHKMelsorlNgamDI+aytFvoaae1qIhKeTRujrfT8/+hK+ki
k33/QinUNniEDSXCvo6UvUe43PT/mgpxs9X2VpqKy6hVhuJs20npyaKb+7Mg0lxVTK2sH359Q7A8
c/Km6rDY1kJTSTl1Rn1wstFTeuoWer6TxmDQ0SHKkavUqATQXa/P0EhFSTopeYOIGzWRkdkaXFoy
WXWqpOuObm2msbSCRmMfHKx0lJ4uudmWkYbG0kpahnvi62uPvLDsZ04x/xURVFhaOeJmI6Mpt4Iq
0RQ3K2esxALO7N7IztNViDJr5E4h1Id5ASBqG2moLqdNHY5vgD/mF87fPE26G1Fbw6UTa1mV40zS
7CnMfECB4rMv2J/XiqGpgbryOtpDLbEybackufz2CRiDAYMeUBpjbHybZ4Khg8bSixz66iJHdnzD
kEmzmDoghmFZF1l9pu6PWZmXkJCQkJCQkPgFkT///PPPX/3P4sWLr/1g0JrTd1Icg13lVNeBtWcw
g7zhUkEthrYSKjRRTJ0xgX5WBnQyNVZO3gRFhmNXd4mSZhFBpiJs+mPE+xghU5hgau1K735DGNrf
nvIDX7E/9+q3eATQWdB34lgineXUNMiw8exDpBdcLqgHhQV9xiYywNsSY30nxlZeDJrxCHf203Hw
kw/YV6zH2COKxEEyTq4/RP7V0aFMjrHbQCZGGZO8cT85jeXU2w5jStIIfBRtdCgscOoVxuDBvdCe
3creS1qMLPpx19/GYZKyno/feIOPNx0lo6ge7U/cQEthYk3Q6AQivCww0RtQ2fkSNf1+kvq0cmjx
ZxwsasPQXk2rw3CSJkTi0NkCdoGMuPs+Erwq2fHRUo5X6ro20HIIYeRwDyoPbeVM+W0cEWUo5baE
jo8hzEFOfbMSBy9/QpwNXCm+cXOeW2FAb2in2TiY8QlD8ZE1o7cNYsys6QyQJbNq8S7yutcUCsZm
2IcnMGOAyOGV60it/X41Ud/ZgqzXaOJjQrHVt6N08mdg7BgGeRpTeXYXR3Jb0MvkYN+PMSNCcaEZ
rdIWD/8w+gXb0Ziym6OXG9F1NNHhGM3E+OEEWIBBaYa9R2/8g3wwq8+notWAXiZH7hBO7IgQnGlG
a2SHh38o/frY0JDyLcdyGunQtdDpFM3EuGj8zUE0ssDB0xe/AG9M6wuobOvJkF+BxsaTyHGxBNua
Ym7rTK+woYyfPolwVSF7v9pKWnV3xxPU2PUaxrxn/0FSmCc2bRc4dPEnBhYKDTYeIUQGm1F8fB9p
VTdcd4OWDl0HMvdhTBg7GF8zwMQSB6/e+PV2R1VfSFWbjnZdB51mYYyNH0GEuwa5XIWFgxs+3l64
W3RQXFZDe6cOpcdwJsQOpJeZACaWOHn74evjgqq+iOprn8wSEVSW2AdGERVoj7FOj7mTO24WHRRX
du2q3NkOMqUTAxPGEenQzuVDG/jqTEVXwKZvp73TgIn3cOJGDcDbTIagssSplz++3k4YNxRT09KG
1iBi2juGsdHBOMk7ETRO9OrTl0A3BeXnjpBc1MNveMmUqMxtcXZ2wb1XAH0CXZBX55Nf24lc7KCt
owdhtqDAwtmH0CFD8LNXYSQzxt5/MLEJ4wjkEvs3b+dCtQ4TGyf8Igbib61A26xDaeGEd5++BLoZ
UZ1+kpSCWlo6RIwdBjBmXBRBzmrkSlOsnDzo7e2Kraqd8poOLFx7E9LHHbHgJLsPJnOlpBXb/rEM
9zelJusixQ1NtBoUWPnHMDY6FHdTGTK1Da6+AfRytULeUE7d1cykXomVsy8RQ0JwUcvokFvh7eWC
rUpLeY0W615hDB0VS19HY5QqC+zd/QntH4KbcTVZp0+QVfmz1oNISEhISEhISPwpuP/++4EfCIbR
FZNdpCZg2HiSEuOJHeiDpjqVQykldIgdVJ47REqjLSHRcUxMnEjcyEj87QQKTx0ks05EkJnh2m8E
ExKTmDJ1Colxwwl30ZK+6T98uC3nunXDIqKulJxSU/oMH09i4gRGDfBGVZXKkfNldCos6DNmEuGa
dhSBsUyJH4afUS67PlrIp4cr6ZTJexAMHyCnrY2y8ye5LHoxaPxkJifFMXKAC52F6Zw8eIDzpe10
thVyfNs2DpzNprRR97M/raQwsSZo1ATCzDoxCYolafxgvMVsdnz8NkuOd+3IbdC1UnohhSJNEKOT
pjFpVBj2TclseO9dvrzQHcD2NBhGT2d7BUW11gSPiGPSxLEM6+uCvCKNk+kVP1Dt+w5R1059Xjp5
gi8jEqeRMLwPpiUH+eL9xewrvlpPFTA2s6f/xBlE6A/xxVcXbqg2inS2N1J8MZsmp3DGTEpiXFQQ
TrJORI2cqrO7OJLbir6jjfrCXKrMg4hJSCIpYTQDg6xpu3KBM8eOk16hpbOtgZKMFPL0rvQbMYGJ
E+MYHdUXN1Ur+edPc6VBxNDRRn1BLjWWwYxMSCIpYRQDA61ozb3A6eMnuFihRddaT3HGefJxJzxm
AhMTxjNqcAguJi0UpJ7hyg8t4LyGApWFO2Gj40lKSiJx4liGBjlhyD/MhqVL2J7RdF0F3IDMyARL
twDc5YUc27mHtIqfWI/+sWAYEV1zDUWZ6ZQovBgwcgIJCeMYGdkHB3kD+WnnKGgS0bfVU3Y5lcxa
U3wiRxGXEE/c6CGEeZrRXn6JC5craWmqojArgzIjbyJHxpMQP5aYyEAcZA3kpZ2n8LoFqLrWVprq
tdiFxjAubjQDe1ugLcnk/OXqawFvhwgq1xBctRfYtmo72deOF+lorKAwK4tKEx8iR00gIX4sI/r7
YyvWkpd+gaJmA9qGSoou59FkFczw+CQmTRhGmJeK2sxkTp9OIbemZ0GaoPEgLO5BXnr5YRKignC3
s8crfCRxg3pj2ZjJiUs9SFB0B8MhEeH0srPGfcAoxgz0QlF4mA0r17DrYgN6dDTVVlNeI+I2YAyT
pkwmccII+nmZ0Zp3geSz57hcpUXXVEnh5UzyWm0IjIplQnwc42IG0sfZiMbiy2TmN2F6NRguTOZ4
ZjlN1WVUNirwio4hzK6N3NTLlFaWkJeTT6OFP4NGTyBhQizR/Xww11ZwJTOL0pbuszK00NDYRLux
D4Ni44gfE01fFwW1+dlkFjZjbOtJSPQ4Jk2ezOSkeGIH9cai4QJ7Nm/m25RKad2whISEhISExH81
V4NhQRS/W13bv//P+f7Ir4mA3MSNaW8u5u7KV0h66fAPTsn+YyDD2KIX019+h4nFC7nj9WO/8NTc
3xHBBCv3GB5+dRaWXz/FE2t7sFOyoMbWezx/e2MS7Z/9lVd2V//kTxlJSPwuCCa4hY/lrjtHYXTy
Y177KqNHiSUJCQkJCQkJCYk/NmfOnAF6vipVQgLBWIVFUDgB8mJOnyr8463nlJCQkJCQkJCQkJCQ
6CFSMCzRQwSMVZYERwQiLzjFqUIpFJaQkJCQkJCQkJCQ+PPyB58mLSEhISEhISEhISEhISHxyyFN
k5aQkJCQkJCQkJCQkJD4n0UKhiUkJCQkJCQkJCQkJCT+55CCYQmJ/wqMsXTuR+z0qYz01yD83u5I
SEj8sRCU2PlFMSE+lgG9baSXv4SExI8jqPCKns49iZE4WphIY4sbEVR4j7iL+yeFYqlS/t7eSPxM
pPehhMR/A4IKS+dgRkwYRpCD8U87VmaExt6LwL6BuJpKrzoJid8Mk97Ezl/ImoNHOHLkCAdXvsDc
EZ7IfxVjxjj6RzA8egC9Hf4cCTNBHUTi4++x4Wr7LH2SKZEuv1L7/A4YWeDiH4y/hz3mRr+3MxK/
NoJZFA9/sIYdh7v68/73Z9PPw+L3H4gb2+Ad2g9/R1NMbry5BDU+g8cQ298LK7Xid3HvD42gISBm
InH9PTA1kv0pnqsSN/M/1LNlGGkCmP3hB8zq9d1pd7bXsf+V6bx0sA0QkBvb0nfygzyYNBAvcz0V
Fw/w1cefsS27GfH2yr9DUKJ2HM5Dr9xDlJMN5ooO6oqzST64lbXrD5PXKoJghMZpOA+9Mo8oRxvM
FB3UFmV1yWw4Qn5rjyyBYIyZ6wgefHEOgx1tMJVrqS3K4uyBrXy16WiXHpkxFm4xPPD8HAY5WnfJ
FGZy5sBWvtp8jIKe2pKZYOkxkgeem8VAB2tMZe3UFF7k9P5tbNhynII2EWQqrL1GMv/ZmURelSnI
4NSBbWzYcoLCtp7aUmPrM4r7n76bSAdLNLJ2qvMzOLV/Gxu3nezSI9Ng5zuK+56+i0h7S9RCO9UF
6Zza9zUbvz5JUU9t3dSklngOnMHfHxmNJhqUdHUAACAASURBVHUJ/3p1B2WGG2Ws8Bo0g78/PBLV
+SU889rOm2T+TAgqe3oNnsEDowV2vp5FcfNPbzuFxh6fgROYnjSKMG9bTDqquHz6Wzav28SBnKab
7h2Z2pE+MXfy8Mww2o4t5bX/HKDyJ5iVGVvhETqSpKlxDA5wRN1ZR0HaUXZu2cru5BLaRZCZWOMZ
OpKkKeMZ1C2Tf+EIO7ds5duUUtp73PVt8O43isTJ4xjo74BaV0te6mF2bN3G3nNl3ba6ZJKmjCPS
r0vmSuohdmz5mn3ny3puS2WLT/hoEiePJbK3PSYdNVw5f5Bvtm5nf2o5WhFkKjt8I0aTmDSGAddk
DrB9yzccuNAl0yNbant6948lMTGWAb52GHdUk5NygG+2fsPBtIouW2p7/AbEkpg4hv4+thh3VJGT
fICvt+7gcHpFD2zJUDsFMGhMEomjwullr0JfX0jqgW1s3LaXcyVtiMhQOwUyeGwSk0b265Yp4Pz+
Lpnzpe09e/b+GdHmc/yrd8n89gt6D51IQuhPTGT9lyO2XWbfsoUkb7IhcPQMJvr+/x+0CqsAxtw9
jziHy2xdu5E96TX8Xo9vmW04E2cnYJe1mTVbqmjs+IP3dEGF28AEZkybwBB/W6i5yIF1X7DhYAbF
TZ0/Tc/gSdw5LY4oPxsMVRkcWLuC9YcyKW3u1qOwJWjMZKZPHEk/T0toyCdl11pWfX2SnMrWrk87
Circo5K4a/p4Bvtao69MZ9+a5aw/kk35VT2CCo8hk7lr2ngG+Vqhr0xj75fL2XDkEuUtP8HnXwCx
5RxrXlnANypr+t/1GJM1v6n52yJzHsG9f42l7svXWX64hXb9r98PjVxH8si/HmaUyUFefmYFZ0oa
0CGg8Ypm8vRERkb64awRaShKZe+Xn7P2WD717dJXTP6oGLvE8OhL/yAi7Xnu+SCZFt3v8FTVRPGP
T55gtIsFarkBbXM1hWlH2LJ8Gduzbh6HXs//UDAsgFyFSt7K+aXPsuhQPSIgip00V2oBkCnVeMQt
4LnZbmSseZdlV4wJTZzD/BdMaXnkZfZW9+TiypAbW+PkoObyqgWsSDfBpU8U8YkLeDPUneeeWUVG
m4Dc2BpHOxMurVrAigwVrn2imDBxAW+GevDcs6u42NKDh5EgQ2FsjYONksyVC1h9UY1rcBQTEhaw
sK87Lzz/JZltXf7YW8vJ/GIBq7PUuAUPIW7iAhb2XcuLz68hs0cBsRyliTV2lgIZKxawJluDR8hQ
xif+k1dD1vLSS+vI0spRmFhjawHpKxaw9pIpniFDGJ+4gFeC1/Dyy1+R3RNbghylyhobs05Slz/J
+hxTPPsOZVzSP3kpeA2vvrqBbG23jEbHuWVPsjHXFK/QaMZNfpwXg9bw2sKNXOppoH/VrJEFbuGJ
PPrYBNw6m6i5pYwl7hGJPPKXOFw7G6n+SRb+SxFMsPXoy4ix4RhlbOSDNVUoXMOImTCeu+YJ1L+6
gpTrAmzBxIGAoUncOy8GJ10luT/ZnAOBMXfw4NwojLL2sertNCpEa9wczVCqFOhFEFSO9ImZwYOz
o1Bk72Pl22lUida4OZqiVCnp6bteUDkRMvpO5t89ACFzPyvfTqcKG9wd1Nf0CCpn+sbeyf139Ue4
uI8v3s6gGhvcHVQoVUo6e2pL7UrY2Du5b0Y/DBn7WP7WRWpktnjYG6M06baldiV83F3cOz2UzvR9
LH8rk1qZHe72ymvn3iNbGnf6x93NPZOD6Ejbx9KtWdTJ7fGwk6Mw6W5DjTsD4mcyLzGQ9gv7WLol
mzq5PZ7Xyfw4IqJMhrbmCifWHeXLGnAIGsqo6ESmyTpo+Hw3uVoRUS7QXp3L8XVHumSCoxk9NJFp
QgcNS7/lirZn5/WnQ+ygua6C5vomNP71tOrsf2+P/liIWhprymisbcSqppF2r5+vSqayx2/gmK7k
mJ8TYtqVX87P/wkELMOmcN/cWBxKj7Li3SvI+4wl/s77MOg+Yd2BDCp6lIkTsOw3jQfmjsKm6BDL
3s5HGTKehJnz0Xd8xFeHM6nUKvEefy8PTPKg8uhyXni/GGXAWGYk3sNsXRuLt54mr8GAZcQdPDgv
Bsu8/Xy+tRCT0AkkzHkAvfYDvjp6ieoOsOp/Jw/NG4F57l4Wby1CFRbPxLkPotf+h/XHLlP9WyYg
DK3UlrVSK2vEvbGdTtUfPPnxKyF3GMZDT80iwkGDsuG6NpDZEzVjKuHGmez4eCOFbVaETbqD+Mce
pqF8IduyKmmR4uE/FHLzXgxNvJtZU4biZaakJv3380WQmWHnqCH/y8d553ATKpteRE2/n7+/44Jh
3tN8U377zvMrBsMCMlNfJsx/mGnR/jhbKNG11FOV9y3vPfEJZ1q6ZOSWwSTMSmRYaAAe9laYmyrR
N1eRvPRx/rWpCAMgyExw7J/I7OljGODvhpWxnpaaAlLWvMYLm6/Q03tDEDSoVToqci+Se6X9hl9l
KE16MSY+kLYDr/HaiqM0oSQ1R8T5wweYOMaDA6vzum0JKNXODH/0FR7p38ruN5/m41P138s6GAyd
1BdnkZHaRkZ6CqfPV/D8K0ncE3eExzeUASIGfSd1RVlknG8jIy2F06kVPPfiJO4Zf5h/ri/ozlbL
MDJzI+aRF5gf2siut57lszMN37el11FXlEX6+TbS085x9kIlzz47kbljj/Lk5sprMrVFWaSfayM9
7TxnL1TyzDMTmT32KE9vKrxmy8TSm1EPP8PcwFp2vPsCS8/eYKtT+z09yemVPPVEArPGHOeZbbXf
yRRmkp7STvqF8ySnV/HkPxOYGXucf28p6rYlR23ry+gHn+Ru30q+WfQyK1Iav29L11V9TktuJ/1C
KucypvPPv8Vz56iTvPBNw+1l/jKBO0ee5MWvi6/Z0jgEMPaBx5nmUcr29xey6vz3bSFTYddrMFOn
R9C87T1WO89gzI1zl+Rq7H0HM2VaP5q2vc8a52mM+r3mxMhMsPIIJ27WLBIGeGGub6auphWDrJ7y
a/6qsPWOJGHmXYwN98DGBNobisk4tpVlH24lU2uGW+h4HnjhYaKtuk4kePU4FiDSWXWJo2vf4oWv
svjR3LnYTnnmXj59cj/o9V33rHkhNYI190e74+EoJyXnarbfHI/QaOJGeVCxfSmpriMJukmhEute
kSTcex8x6gw2ffIRWzOvzsxQYusdTPToMMTkL3nzvS1cumkWgBJ772CiR4WiP7uKd/+zjcu3nSmg
xNYviknz5hKlOM+mxZ+xPavlmi17n75ExwShPbWKDz7aTk63nmPXjjfC0bcv0SMCaT+5kg8/+oac
9htlvpO1C4xm8tyZDBDPsuHzpey8dNWWEY5+YUQP86Pl2Bd89OlOcm/SY4SzfzjR0b1pPPoFH3+2
iyu3LTkb4RAcw5Q5dxCmPclXy1aw53LrNVvOAeFED/Gi7vAKPlnyLXndeo5ed7xrn/5ED/ak9tAK
Plm6h/ybZK5ijFPoaKbOmkpQy1HWLV/N/tyrtkTaStI4WpJ27Th5XjOC+TSGWdlhYyaQqxVpK07j
aHHaNY3y/BZk5lMZamWLrZnAlZ6Wu38RjHEOG0n8lCnEBLlgbSqgrb5C8t4tbPrmEBdK27rOTVDj
HBzNhKmTGR3miqqtmNR9W9jw9UFSS1q6nj2CGpeQ4UyYksioMFdUbUWc37uFDdsPceGqzC+AzDaI
2KQZ3DEuFFtquXKplHaVA56uSooPrWf1hm9JLu2SFexCiHtoIXGPW2Ep1pB5eAvrNu8hOa/hx+91
AMEE98g4JiUlMDTACSuVSGvlZU7t3MjG3SfIruyu5MtMcQ8fzaQpCQwPckDZVMDZXRtYv/M4mRVt
12Q8ImKZNDmeYUEOKJvyu2VOfCfzy7QQNqGjiRsWgHhmK1tLIghW/46BiNyd2If/wqz4AXiYCDAk
nFH3Aoi0nlvDm5+uZ3+uI1P+MZ+RqjOsXLGFY5cbEVHiO/FvPByr5uyXq9h6ogSH4dOZmjCa/r72
WBjraSy9yNGta9m4/zwFdR3X+qrbgLFMShjDkGB3zPTVZB/eyKoNB7hQ1ICuJz7LHAgfEopjw3HW
fbWJQxer0B8tR2HxEEMjAnDLzKOqzpvpf32QkZoUVi3ZxLFLtXSaBjLlsYeJMTrOyhXbOZ2vpn90
KA51R1m1djNHs6vRH6vAyPJhBg/wxyWrgKoSK/z8nJFdOciO/UdIzm9CzGzA2seNUU4OWJgZIzRZ
EjksFPvqQyxfu5kTl2vRH6/E+NlHGRTpz9HsImrKLIkcHoZd1QGWrN3CqZxa9MerMPn3owyM9Odo
djE1pa1/vJknMlO8hyUxLT6G/n6OqNpLubDnS5ZtOE5OdSt6QUOf+HnMGBNJoLsdFmqB1opMjny1
jJV7M6ho1nXfX5YEjp3BHZNi6Odlg7G+herSK5zc8DGrD+VQ1d6LOxb+mzvCPbBSAs8uJwEAA02H
3+Ov7+/mclWXSwr/abz06SzMVHK0lZkcXLuYlfuzqW7p/EntJ6j9mPrYXbhdWM6qrGnM9L9uBG+o
YM8bj7HPYEDf/dXXM1UW+D0/Fm93Nca5Ai2/QdX6O2dNCZ3+KHePDMHH2RZzEwNNpWnsW/UpKw5e
oUH7ne/yXgk8/eEcPB1MMVRncXjdZyzZlUlte8/bR1B5Mmr2/Uwb2RdPWxViexN1xQf55NlPOVrR
ik4EZOb4j5/FrAlRBHvbIm+4wumtS/hkQwoVV23JrQlLupc5E4cQ4GSKrKORiqLLHF75FitOVNLe
KSKovImdN59pMcF4WJtgaG+itmg/Hz39CcdqtD1MdsvxiH+UeyOq2P3WQlLmPM6Q3/1mEmmuyCX3
ci36S1mk5Rrjt+YhYvpbsPPr2tu+c3+1YFiQGRE89wUeiypm9aKnOFHagtzMDhcHLSVt14RQ2IYx
PmEgnds/5r1TJdS16FFoLBCLK7oG1XJjnEY+yXtPDKTj9BZWv/M5hfVajCwcMS6p6PlgQhAQjM2x
UGmpl9tgpamkvkX3XScV5MitA+lt30nWuhycprzO50kG1r/4MedyZMwM8MNcyKOu6wmD3NiNkHAv
LC2b6RfshPxU/e0HEvoOWgv3se9iEvMG9sdl4zYabpLR0lqwn/2Zk5gzsD8uGwsoMkBXRdaNkH5e
WFnUExbkhPzMDwxa9G00FxzgQPYE7oqMwHnrDlpvlOlspangAAez45gxIALnLYUUGwBBgbHalaAw
L2w0ZoQGOiI723D7ZENnC435hziSM4bJ/fvh9PXem1+qnS005B/iaO5oJkX0w2lbESXdtkw0rvTp
64WtSkVIgAOylMbb2hJ1TdTlH+Z43gjiwkNx3HnoNjJHOV4wnLHhoTh+U0ypga6p66ZuBIZ4YadU
EOxvj+z89bYUmDn5M3xqPE7pS3lnVyPhc2/UrsDcKYDhk8fjkLaMRbtb6D8Hfp8FIgos3EKY8MCj
TLLLZffHq8nUOhAcFUt076syAhpHX6LvmMto6wy+evUDLtbpUVlaoBJrqdICYgvlF3fw3j+ucGjo
RKYPlnH488UcLDMgdmppa6zrcaIJUcSgv+7FoDRGbWaM2FpIVW333wUjbLz7MTx2AMYpK1l+2oTo
O2+hSzDBwsYNvwBPnLRN+HnbIMts7vJFYYW9sz8+5tVkbTl66yBXYY29sz+9zKrJ3Hz8WgB7SwQ1
ljZu+Pp74tpSi6+nDbKsli5bShscXfzxVFeSeeoEubfSo7TB0dUfD1UFmadPXgtgb2fL2s4dHz9P
XBsr8fGwRnbpqi1bnFx7425URvqZU7cOcpV2OLv54qosIe3M6WsB7C2RabBxcKdXb0/cakvp5WbF
3qvBsJE9Lu6+OMuLOX/27LUg93sYOXTJyIpITj5LwY/YsnVyx9vXE4/qQrxcLRFybzXAFFCo7fDv
249QdwVVZ65QWHej1Hcyfd0UVJ66lcyvjKDA3N4VT6t2snZ+xI7kaqz8BzN65N3cb2vFF8s2cKoc
HMPHc+eseALazrHpvVVU24QSM2o691qZs3L5Rk6WiThGxHHXzAn0bk1h43urqLUNI2bUjC6ZFZs4
Vdbxy7istsHJSUnlsXVsylXTL7Y/5nmHWHfCjNCBAxkyoJj8bdldsrJOqjMPsu9YNq12ocSMTmS2
sQLZys2cKO5JCV6JpbMHnqZ1nN20jgMZTdgFD2PcmHuYb2XK8jU7Sa2S4TJ4MnPvisGp8iSr37lI
i3MkY0bN5j5zNSvW7OJ8lYDrkKnMvXM4DuUnWP1OJi0uAxkzcg73malZvnY3qVU9CtN6gIGqk1/y
9gkRUeZA9NwA+nj+Qqp/DvpSjq18g4vHhjNzZgyWeXvZsfcs+c2GrkFpfSOGjjYuX6liWJQHLjbW
qHIaaRXs8XCzxaj+EiU1tbSIRth49MLTuJC9K5ZxJl+HS/8xxE97FFvTxSzZeoycehmuw+fw8PRQ
hOwDfPZSNs22EUxImsrcqZ0sXrOXC2U/vhRBMPXAw8mMhsIrdHpP4Jn5QTTs30BORT1yH1dsLcxR
FKSzefUOXB5LJCmujJrmM8iHT2W4cwn7lx/hQn4DetMAPJzMqM3PodN3Es89EkjN7nXkVjSg9HLD
1twURXEjNbVtGA0IwNv+JNlFTbTZeOJuI6c+rZKmFi2YeuLpZEpNTg56vym8+Fd/yrevIa+sASMP
d2zMTFE2e+HlpKE6OwfRfyov/d2P0m2ryS9txNjDHRszDQpae5YM+M0wwjPuMZ6Y6k750c28s7IA
g9twpt0xnwf1rSzacIb8BmMcegfhq7jMls8+J7tahtewqUyd/SBtNQv58lQetR0m+Cb9nQXTvKg+
sp5Fy/JoUAYzaX48vl42aE5coaoln2/e/CfHe8Xxt0eGUL99CVuSi6jTGjC01lFR24aICQCGugx2
bjvAxQoRjxHTmXbPQzRVvMZXKcU09HS2ucyS/rMfYnj7Lj7ckow4ZtJNY3hRr79u3CFgYmWNRqim
olKLrqfTrH4pBBOcA0PpbTjHsncPU9yipnfsTO549O80lz/D2vQark5AFBTt5H2zmLU5TVgPmMrd
D/wbTcfjvL2viEZtTyIVBX4znuSRke3sWfEq/7lSg97EGmcnPVcadN3BqTG9Z7zIK5NNOLX+M577
Ty3qwHjmzXmGx7V/54WtV2jqMKbPnJd5IcmMC+s/4oX0SnSmkcxcMJFgDzMUp6oAOf53/4u/jGhk
++cvsii/HoPKBhenTvKbOhF73Mx6rnz5N2auFhHlvsy7W+SPllkS21ppFQU0RsofHK7/ipVhOVbW
5oiNBaSeO09mvQHI5lYVdNHQTu6xnRw8c+MjSYbcJJjp84agOLWIR57ZTsWNfUqmRBPyAJ8vmobr
jQv/RR2teev42z2fctEgIDMzQWiQM2jBCsapROpzT7J9+cd8caSUDkGG3NISC7GFgvpOTHs5YWnR
iZ1KS1adFrmTNZYyqNMD6NE2nWfV64uoDujg7PbsH8moi+j1bZSW1iIf6ICdnJuD4W6ZsrI65P0d
sJXRHQzraKtPYdUbiyjzbSP5m0s/aquzs43yinoUofbYyqDwVrauyoTYYSujKxgWO2iqTmbVG4so
9m4heeflHwmGRHSdrZRXNqAIsMNWDmU3yRi6/KlsQOFnh42MrmBY1NJQcYZVby0i372J5F25P2qr
U9dGRVUTSu8uPTdPYxbRdbRSWd2E0qNLptQAiO3Ulp5k1VuLyHFuIHnP92cTKMwd6R2dyAj1ST5c
nUK9mc9NmhXmTvhFT2SY6hQffnmOevPeN8n0GJkMhZEJJoqu0rNo6KSjvZ0eL7EwssTeK5L+zjUc
WfIuiw9WIwqWFNWpcXusf7eQgEKpxEwtp7kil7TUC2TftBbYgE7bRFVpGeW1LWi1ArWlBRQUfueI
oHEjdMx9/PuxEdjdUCkXteVkHFjJ6wu3kX9dgwomdvQOH0l8uJpL23ZyplYEBIxsvAkZMpw+upN8
viWdRseIW5+f2Exx1iFWvtvOWU05yYcLr10vwUSFysoKo/YGyspqb/ncFUxUqK0sMWpvoLz81jLf
2Wqk8OIBVr7bzCnjEpKPFl1nS43aygJlWz3lFXU/YKtbpvzWMt/ZaiDvwl5WLqrDS15EyvHi72yp
1GiszJG31lNRUX9rWyo1Gstumcpby1zDUE9uyh5WLqrCnQJSTpZeG3QIKg0aSzNkzdVUVt3OlgZT
S1OE5gqqKht+xFYdl87sZuX7ZTh35pFypuzmJKWRO4MnzeT++bF4i9Wk7VnH0t1n+d6sJSMPopJm
ct99o/E2VHFhzzqW7knhB2Y23RJBrsTIyAilXABEDLoOOjp0PZ6ufhWxtYbS3DSSz1yhM/kipQ13
MzM2hLDQFC4cNhAU2hcPXSrbv1zO1tR6DMJ5ylsMzBwTQmjfFC40iASH9sWt4xzb16xgW2o9BiG1
SyY2hNCQc1woy6btR/yQ2fVnytx5zJ4QhPkNb3OxKZ2vly5l1VlAbKOuqoj0VBHrYCecKvI5d8qA
qY81zuZmmHe/7Q0VFzl1YBdfHylEL5ynXCtndkwfAv1TSC25RI9Xl7RUUngpjeTTReiTM6lsvY+Z
g8MIDkgnu01NeEQwdrXH2LR2LXsyGxFlaVTr5jMzKoyggAyy21RERARhW3OUjWvXsS+rW6bzAWYN
7Ecfvwyyq/K4cQ7Xz0YUf7FxmqAwwthIiULW1cf0HVo6dJ09XqYAnbTUVdJWVk1DWztG9VWUFRdQ
cP2UUVrJycqhYshAvF0dsE0toEjljoejhsbSQqprGzHQvei0sYScrDSSL1RwJjmLesPfuatff/xS
cyjMcWDYMD8M6ZtYu34fFyp0wEWazRx5IDIAd6fzXJIHMv/vsxkX4Y76xj5Wd5zFCz9je74ppkYi
7c3tCGpLzK2dMTaTk9nWRodSjZmREUpBpCV3F6s3uvG3mROZ+Ugsdi4CF7cs5/jFYpoNIDM1w0xp
oL1Ji0xjibm1E3IzOZkt7eiMNJgZGWFEBSnb1rHP6X4mP/4Cg7MLMTh7YHRpG8v3pVFQp0dwNsNM
qae9qR25xgpzKycMZjKymtvpNNZgbqTEyKxLpq2xHZlpl0ynmYzslrZrMkqBropbT6670hgTIwVy
oeu6d7a30dFp+EXXnAtm4YyP7UXNvk9YujWFgvpOOJdNx/+xd9bxUR3bA//elbgrSSCCQ5Dg7lLc
rUApVkq9fdXX9tfXvrq7IAWKFIfiAUJwSwgQAhGIe7KbTXY3Wd97f38kQPDQ0tcn+X4+/EH23Dkz
c+eOnDlzJjCCZ1u1J8QrlYKaCaSoySDx3Fku5us4kyISErGAxi39cE/Ko9ypE8MGNsVyahk/rT1K
htqMpJToOH0QLa+V14KutIhK1woMVgtVZYUU5Oagqm38rBn3xZJLnIyLI7WokrjLMiKaP06L1n64
phZR6TuRD957hC6NvFDe1H5E1V7ef/FHjmSX49xtFrPaFrHj6yOkq6oIv0e9Kxr0Zv4jPZDil3Ig
Q8P9HvGWOTjjrJQjCAAiNqMRs/3++wFRncaZM2fJrzCRkCan2Y9PENnGB8fL5Rhq7Ie2tH2s3X6A
Aq0Z6XQ69sBvmP9QX4JObaLSbKxDG5Hh6e2OrCqTSxcSScmrxCrBpVoSgmdvpo5vROrKF/hhTx6V
FgkupUPjZbzauxsB0bkYXHszaXgYpdvf4NO1SdW71w7ODDSPIuRaSnK8vN0RqlK4mJhIcpER+026
5C3mseirGTRzU94S4E0s3sJLc74nodKC+AD7VZmjCy7Kq9pErAYDdbIj3BYBB88Ies2ZQkdLEovj
1HddY/xpi2FJMnJq5Q8cefdZPl/Xi8SjsRzYH82BM3lU1bVwgoAioCXNfSwkrzhC6e2eE20Y0tby
2vw93BrUXEKyVFBgp3phnLGR16ZvRBAUuAW3ZcCMp3nstfdQ6p/ixwvXE7ebtZz76UlmrIfKKgd6
DLtN+WwmShK28ktCHctSXaDfJSNaDRTGb2VV/IPWdSuiRU9+3FZWx92Pnt9XLrtJS+6prfx66j4y
WOc83aTLWE7Wya1k3fyD3A3/8O4M7+vO2aVbuWSQcHa/WcadgIjuPNTblbNLfyPZIOHs8fvz5hrY
koee/Ijn+nsjw4I6/RRr3n+LTel1m/ULTs64NvDH01hKdvadFnsi+uJsjkcfof0Tc/li2RASDscQ
E3uEuNTSOgd0kozFpMb+wN8urLy1s5CsmCrLb/gu5S6BtB4wjXkTW6KJWcSy6CzMAApvwlp1pVck
nF0RzWWjxJ2rUMKqKyT58FaSb/2pelJ7VwOkhHRPmeuylop8Lh7Kv9VQJ11P564pSBJinUypEpby
XBJjc0m89adqXdwlz9JVXXVQhYRZk8W5A1mcu006SBIidx/EJElCvFt+autSZ5CwP4M7dofWIs7t
W8o7yftpHtWXwf1H8uhcAX7eRIKqpt1bCzkXvZR3Lu6neYe+DOk/kkdnA8u3cFZV1xWxDP+oUcyc
t4Bxbd0QpCrSYtayYukqjhX+gSmrqKWwoIAiUwR+Af74+drx83PFrkqmsEhXPdGR9BQXFlJiisDX
3w9fXwk/PxdspUW1ZHQUFRVRYg7H188XbxkY75EtsfwS+1a8z5ktTrdGnRVN6DQatJ5drv/tasMX
QJAkJEkAQYZwu35a0lNcVEyZPQgfby88Beq+GK6NXUNebgGq7m3w9/XB28+DQB8lhqJCSkprjjiI
FeTnF1Emtsbfxxtvf89qmcJCSlXXZQpyiyjr3gp/Hy88ZGD6twtOKKPRgAU8NWsMPcKdESQtZ9Z8
xZKNsSRrHmRmJSrTLpJW1IMezUJp4J+ExjeChh46Co+XoCq/w8rAriY9oxBt+wAaeHngGdSQht4B
dOn3Ct3Hv3ztexbkcoSKU5x2dERZepI1n6ey3dnh1jZmr0JTWkalR/jVP1AQs4i39y3FarQSOmLA
TQ/YKDqyni1NQnl8XBccT3/PgfhUYtwpLAAAIABJREFUCm+Z+Nkp2PcDb+2VYzFaCBs9tNZvAkoP
P/w8LGQnJJKmUhLm15y27boTdfoCWapKymulk7/3W97YK8disBA+btTtKoX86G94fa8cS5WF8PHj
7lztd0RO07Fv8Or0XjT3d0CQNBz6+v/4aW8SBb8j6OQdtTSMINzDh06zP6L7LKnW+1IgKyvDy9EB
Bbd6lIiVKtRVVhq7uCGXy5EHRxDuZiI7NRddleWBbtiJOhUqg41QNzcUcjn2wn189Xo8Lkr5rb2M
XU9pQQUW1w7MergtJQe+Ij6//J79nlPoYJ58bT5Rmi18vuokeVrzfRod5LSc/hnvTo0kwE0Oooo9
/3yG748Wov0D58RFXQklBpEGrh7IZXeIAy6WkppagjiyIY0cFGQJcG+VFs6u/5nYZk/z+qLOpJ85
ysH90ew/nUmF2Y4EKCJa0MzFnUbPLWfbs9efFBRKZMUB+MplFIS3oJlTBQnnczDb7jRumkn4dTGx
bz3LP5Z15fLpw8Tui2Z/XBY6q4gE2HO28s5Th3CU3WbcsGkpNFofcOBBBW0fW8YXk4NxkAkglrD5
b4/w7VnjfRgZAZR0/ttG9r0gR6GQYS+NY+X/fcDWvLvPIf68nWFJwpS1i3fnnGRdj4EMHjCIR9+b
yuxLq3jnHytJ1NV1Ni4iSiCKd6p2CcmoIS+zvMb6c3M2bp08SpINfcEF9v60iMbt36ZP75YsTbyI
vaICreCKj48j2CtRqwWUrp74eDti15ZT8QcsFHK5M8HB3oiqUtS3fSfVMkFBXojqUsr+gC6FwpkG
gZ7Y75iOgFzhTINAL+xq1R/SpVQ40yDAA3uZmrLblktWnZ8amd8/VxBQKJ0J9PfAdsd0BJQOLgT6
uWHT1E2XzNWTgKi+DGjdDtknvzENQBCQyRXIxKf4IqQZiz7YQkVUHwZEtkP26W88fIPM03we3Iwf
Xv+WY9q6LYhMZTkcWfY6mVuUCEhYjVpKCu6jYq6Njtx+gluDaCoj/fAy3riwn7a9BjF4wGieHzqR
3IMr+XZxNBk3zHolpNulJdowa0vJ1alu+32JonhtsSh3C6Hd4JnMHxdG3vbv+PG3S2hriqXw8iek
bQ8GdG7FwKg+zIeaOpQjE0P4ICiCxR8sJ05/9zqULCaMWh1Wp0YEBnghXC67ZZCXzCZMWh1Wp4YE
+N9epi5IZhNGrR6bcwD+/p4IV241PEgmI0atHruzb7VM+j12ou+oy4hRW4no4om/nydCxm10mQ0Y
dZVILp74+XkgZNxjJ/pOukwGDLoqcPXEz9cDIfPWdCSjAYPOcF0m6/fpup6gFWNFCVkVJWSlZFGi
ncb0oW3o2OYE5w/W7MZLVgwVxWRVFJOVkkmpdjrTB7ehY+RJEg/l19FlX6T88lE2fJVBrKscATuG
8lKKy/7oVFC6ZoSpq/nvnunVFZsRraoI/W0i+kk1BhvZDZYlCUkUkcS6aREQrhuZ6p6r2+YFQBDu
1itdz+Mf+/2vRKLkzFYW5R9lnZMMJBv60nyK9L93cLuLWc94mcRL+XTv35yIkCSkhuF4VpaQUKRC
Y+UODbG6rXLtZwGkCs5tWsf2g4nk1QrOKdmNaMsqqLRY0Rca0Nxmbn+1jSGvpNIi0MjNGUelBV2J
DQQX3DyccbCq0Vss13ZYBc8wmoV54yST8GndjmYhZ7lSlIPeDlKlHr1VRpB7dTra0uvpKC0V6C0W
LIrGjJw2hvDivaxcH8OFAiOs3cHoZ19i/EO9Sc5TE6fSo7fKCXB3xkFhQauuScfTGYVZhc5ixaKv
lvHzuFHG3dMZhbkYncVa511hEMk/vIxPUzdX715JNioKMlH/zpsr7oggIEhlnFj2FVtPZ1FW6+SC
ZKtCo6rAfFtTck3/JFT/Q5AjQ0QU62IVvt9vX8Rur1EGYNZRkqe/8xxcFHHp1JvuIQ0Jf+pb+j9Z
0z7lCuRCe95fHskvL73L5kvF6O0Czo1H8eIbj9A4ay0f/7SXVLWh7ke2auUxO/or3jrrioNcAMmK
JkdN1R92tZaQRO5xMa1wrV+9q4H7JqwFsXz5zBl+69SXAQMGM/7VH5iZu5VP3l3BqSJDddsQS9n/
+cdsStFR68gyklWPSmfGLpMjw4b9HlZzS34Mnz0Zz5bO/RgwcBCT3xzPrMxNfPDOcuJVZuymCgqy
tXd5pw+6j7aTsfWf/O2YI9UONxbUGeY6Gv9rY+Piiuf5/LCRRmPe5M1+FWRmVdxz4f6nR5OWrBou
H9nE5aNbWBExlQ++m8Njw2J4dkPBva0KkoRNdYV0rZK+vXvjHxN96+5wXd2kb2dElQnXX7Rkx65J
4XKpgr6d2uMae5xKFCg92hPVRCRvcyq11++CwomA9sMY1srKmZ17uHS3lbLMAaeQ/gxsDdnr4imQ
4JaI+nJHnBv2Y0ArqVqmVnIypQsNooYyqJmJhF37SNbeRZfcCdeGfenXQiR7XQKFInjeIuOMW8O+
9G1hJ3tttcz1rLoTHDWI/o0NJOyJIeVuuhSuuDfqTe+mNrLXnaVIAt9bZFzwCO1NryY1MrV3EZ08
CYkaQO/QShKiY0nT3U2XG56hvegRYSF77XmKRQi8WUbpjldoT7qFW8hZe/5GXc7ehEb1o3uwjoT9
h7hco0usLCF12/vMPnx110XAyTeMHhPnM1CI5ovvdnO5VI/42/vMPnRdxtkvnB4T59JfiuaL7/dw
+R6LuNrYLVWosy7+7kjUksmAPr+Icuf2tGjVAEV2wZ1d5yUbRk0WcTuWcmb/dlr2m8HCh0cyptsZ
vjqoqu6kJRHRLiIqXHBylkGtL1NwbUj7OrhJ58h8adJpGA+PDqVgx7f8sDXlhu/FXp5F3Np3mLPL
8doEza1hG/qPHk+kbjff/xxDxjXruoDSI4hmHbrSyrWEhCOnyL76m60CTckVCsydad2jBxFndt16
vtZWQVlJOoWWTrTu3p2IhN13CTQl4OAVQvOozjR3LCThWDw5VyeLNg3qknSK7e2J7NqN8LPRt57T
tZWjLs6gRGxL665dCTu39/ZncK/q8m5Eqw4diZDnc/ZEArlXdVnLKC3KpFQaSWSXzoQm7r/1nK61
jJKiLFSy4UR27kzo+Rhy7hhYSsDRJ4zWHaIIJZezJ8+Rd9X4YVVTUphFmXwIkZ060uhCLLk3p2NV
UVyYhUYxiMhOHWiYdJC8u+nya0ybDm0JtmVz9nQiBXfdXry6qBQQbjfSXpWSpBqZ+7uF06pXk69X
k39fT90DwY2AwAYEOtvI12go01hRq6uQtwoiOMgDWWkFouBOg+BgAp3MZKrUlJVJqNUGFC1qy3gQ
FBREoKOZdHUZ5Vc/NUlEtNsR5UqUSgeUcG3yJ/PvXDc36RrseUdZ8f5RAOQN+9D7buWSeRHSKAh/
hYHEMs3vN/gK7gQFN8BHZiS3vIIKtZESjZX2QcEEBrghlOmQZF40bBiEr6ySTE0F5SozJRorbYOD
CfC/LhMSGoQvVVzRVHB9SBCx20VEhRNKpRJFrfr51yNhLi8gs7zgjydlt2ITFSidlCgU1a63N6oy
kX7mHJk9RtKqTR/CInypKkokv0R9m73BGgQvQsMa4GGpoFRfib64gEKtQONAVyRTGXk5+lvmXrKQ
oTz34t3dpLefziWnSE+3Rk0I8DmHokSN3akxzcK9sJefQ63VVZ+9VQbRd/o0enmk8uunOwgeMoYh
YwdQoP6NUxkV2Cpr0gltir93IorSMuxOTWgR7oW17DRqXSV258YEeCkwFGkwGM3VtWIsIDO/ArO/
By5ODsiqsskuqqRLeDP8vZLIUGuwOzWjZYQnFnUOZfpKrPpssoqq6BzeDD/Pi2Sqy2tkPDCrcijT
V9UtaFx1TWBUZZOmqvMDd0nKjs0mIjk44SiXU3vUtRdkk1vpSLsQZ4zaUvJKbuNiW4cuUSwtpMTi
RsPG/riczgbTXU5G26xYJQccXeTcabPzbsgjJt3TTfpo4kpef24LjvKrCmQ0HvsaT7TNYs3iTRxL
U1NlB5lXF+a9OJ2IrNV89tN+0tTG3/mtSxiKr3Cp+N6SDxxFEO3aNkAoOEqOyXp/O5s2HVmnd5J1
eierVo3hH189zoyHDpO0NhVd9hUyzMNpEuGIJjafMqP9loW2rDCXAvtQmrXwR5mow2S/S6du05J5
ajuZp7azquF43vl2AY8OiyVpbTqmxnPq5iZ9H0W7OxKVBckk/uFuVcKkKSA3R0PWoo9YH/UNTy84
yPmPj3O3Pdg/MYCWM1FTnqSz6Qzn0ovR2Zxp0L4Ffkoz2dq6Ru8TsZsusHlVAv3+9gJffhDBln2J
5GitKFy88LensftEXp3cpGVKNyKHTaGVJY0slRHBoxEdhk9hiFcxO46lYkVEZkpn785khj32FH8v
dmJXlhPtxs+mkyWeL/fl1Pog5Ti6RzHj1RcY61NJb6dMnliackOnKpMp8GrYklaRcgJbdGfUpOGE
5m7krZ3Z2HEAqncWvRpVyzRo2YOREx+iUe5G/rGrti4lzl4dmfHKC4z0rKCnYzbPLL8xwq9MrsS7
YUtatVEQ1KoHI8cPJjhnI+/sycFeE/xAJlfi3aglrdooCW7dg5HjBhKUvZF/7rl+HhPBAXe/Tsx4
5QWGuarp6pDDCyvTbuiIZApHvBu1pHVbB0IiezJiTD8CsjbwbnQu9polfrVMq2qZNr0YMboPflkb
eW9vXi1djngGdmHGSy8w1LmYTsocXllz4xllmdIJn0ataF3lSKM2vRg+qhc+GRv4cX8edtyvyfiG
tqK1wYlGbXsxfGQPvNLX82NM/vWPVHDCO7g7M156gYHKPKKUuby+Lr1al2jDrC0h79ohbgEXkwPN
Ky1Y5OWUFJdjEIGbZcxOtNBbsMjKKS2+t8vPA8VaTknWSY6m9+KRWa/wgsd2jmXa8WsZjhfURJOW
4RYQQcf+gwnRJpGSX47VKZg2rRriKpmorLp+Ek8yG6gqLcXs3ZH+4yehOpSNXaFE0KVz7GJd3KQF
3BqGE9WvO76q0+xKMuMX0Rg/QLJbMOjKKC03YigvJveab5uApyyAiioTpkoNqlLtdddtwY2GLfsx
84WFdDEnsV8o5POr34RkpiTzIodjL9N25qP83bMR0YcvUmh0wM/fA1lZEnuPplOckcThgx15asZs
XvMOZe/hixQaHfH3dwd1EvuOpVfrEzwIbT2AmS/Mp2PVWaKFYr6Ozr2mq+jKBY4c7sATU2fzqk8o
+44kU2RyJMDfDbsqiZjjGRReTuTI0Q4snDyH13zDqmXMTgT4uWArTeLAicwaXZ6EtxvMzOcfpb0u
jh2U8MP+q7uiJgrTznP0eHsWTJzDq37h7D+WQonZmQB/Z8xFF4g9lUVByjmOnmjHY+Pn8opfOPuP
pVJqcSbA3wlTURIHT2VV3/0r86JJx6HMfG4GbTQn+E0qYVFsjQFSMpKXfJZjp9sxb/Q8XgmIIOZ4
KqVWVwL9HDAUJHEoLpu8iwkci2vL3FE1MifSUFldaeDngD7/Akfic2p0edO8y0M88uRUWqqPsFEs
ZfnhmjPKghOBzSKJbNEQWVkh5VYHfJt1ZcDALngWxpJ2pRi74ESDZpG0riXj16wrAwZ1wT0/plrm
AX9CdUHm34wO/YYzTriEzjOSPoN74lMcQ3RSBoYqkYvnE4lqN4ZR0+fg3OAcZT5R9B/cEdf0PZxP
zMJgkEg6n0iHtqMZ/bCAS4NzlPl2YOCgDjhf2c35C1m1zgtbqKioQOfYiw49B6G2BaOz6inIySC1
8D7dpO+FWwChzdvRxRKGX5u+DO3fCuncZi5cyr2v87myBpH0GDgMo/MVTAEdGTSkAw6pW0m9nIuh
EhLOJNFhxkAmPKzA82gKlcFdGTqwNWLCBi6m5GGsFDhz5iJR0/sz6WElXkdTMIR0Y+igVtjj13Mp
Lf96fiQzZWXlVLn3oXvvgVQ5ZGGylpOZnkFG0d3vj7yGwgVvH2883YMJ8HLDydUL/+BQQjVQptGi
N/1r75wFEMtLKdWK9Ow6iEEVMrzyzHgotKSmZZBTUl0uW/4Z4lN6M3PQKBp7ZLPraD5F6huXwrJG
nRk0RIvSNxfC+jBiUARVR5aRkVuCSa/i8NGLtHtkHAueDKHpoTguqyw4+Phgz7tASno+ZXVxk7Zb
STh+nn6PD2HKFDtexzORtRnO8JYiZ1emkFdsQMKR8MHTGN9OImH9Hk6cuIxZ406Dp4Ywsn8mJeUn
uKIpIv7oefovHMy0KXa8T2ajaDeSYc0txC1LpaDUgGjNJrPQRM8+Exihk3PwQhGE9GJC/yYoM+Mo
rdBjtRs5feQ8/RcOYMZUO76ncnGIGs2wJiaOL06lSGVEEo2cPnSOAU8MZOY0Eb+TeTh1HMOwxgaO
/ZRKkfpBRiy/DyQjxcUaLL27M6x/Ka6hehzthcQlZqLWJrA7Jo12M+bxkmsEe49eIEcr4hLgiyX1
JInZairr0CGKZfHEJozihUELmGcL4FBKOY5hfegQ6HWLR4GoyqNA78jghyYwyHScDJ2SQGUxxxMy
0NwSgfVW6uImbbbYKTaU1/pBjku5CatFh6pQhc5sQ0RBs+FT6OWZye51eYieQYTVbIKLpjKKSvWY
bf925yYAEHybERVVTAOrJ60HT2VSGwNHPjpKcVVd3bsdiBw7j67ydFIz8tGYFPi0akmgs0iFvqr6
bG75UdZvH8UHD7/Bu25b2XkyjRKjAq8Qf6rO7CW+wIit5DC74ibz6pTXeNq2liO5NnxaDaWtqxLt
tZfjSNsJC+giJXMpo5AKsxLf1i0JdLKj1lUhItXdTdrBi5BgbxwVIXg5yVB4BBEWEUFleRH5asPv
2Nl9gJhTWffDHoZ+tJCZOxP44eKdR7g/b2dYcELh6EXncS8xOdADR8mItiiDhFXv8eOBurvcSXYz
ebve4WnNJGZNHcojr0zC2wkMZTlc3P0DB0/mUmlUk5N+t302AbnMBY8GLRg8cDxhgW7IzRUUppxm
9Tsr2HS+ekoiWg3k7PyEdxyf4ImJL/NPdxulyQdZ9PYiYlS1m7OI3ZxHUkI2/bpUcS6pqNZkTUQ0
ayguMdJr5qd8P9tCeX4aCXs/4/tNh8iqkkCQsJs1lKjM12Q0+amcif6M7zYfJvuGO4btWE15JJ3N
pmeUlvMXa+mSROxmDaVlNnrO+pTv5ObqdHZ/zrdbj1SnI6uWUWlEelyVyUshftfnfL31KDm1d3Ak
G2ZDPpfOZdO1dRmJycW1PmI7NpMGdQV0f/RTvpVXX2kUt+Nzvtp2rDodWbVMmVag2+xP6Smrljm9
43O+3Hac3Jt0marySU7MpmOzEpJSakUGl+xYjRo0eiXd5nxCb5kJdc4lTm37nC92nKhOR1YjU+VQ
S+Yip3/7nM93nry+CwbVLpqVeaRcyKZtWAEXU0sf8FmHfzUilYWX2PfTJ5gmz2TSlJcZ5u2AvaqM
7AtHyVSZABmC3BnPkJYMmzqOeT5OCBYtJennOLRhI5sSak0g7VoK0g6yaWsYcyc+yptD5Bjyz3Fg
wzLik4owVhSTXXGX7AiO+Lj7EdqkKc0bt+S9Xo9ez2lFBnG/fc/by+Kpy9XZAEgmtGV5XE7JpqFL
Lpczy254X2JlHueil/BxxQimTBjCoy9NwpVKSq6cZu/WSzgAphqZTypGMrmWTPHlU9dlACQDFWV5
pKdmE6jI5Ur2Tbr0OZzZtZhPy0cxadwgZr88BVf0FKWdJPpqOvps4ncuQl82ksnjBzP7lSm4SHqK
U0+yZ+sllLV0latyyUjLxlfKJSPnxjD/dl0mp7YvQlc2iknjBjL3lak4izoKU0+wZ8tFHACzLoOT
2xahU49i0tjBzHt1WrVMynF2b6nOjxlArKKsJI/My9l4mnPJyLuxz7Vr0zm25Se0qlFMHDOEea8+
jLOopSD5GLs2X0QJmLVXOHpN5iEee3U6TnYtBclH2XlVpkaXuiiPzCvZuFTlkp1fOyiXAgeXQJr3
HEn/yDB8XcCoziHp+CaW7YwhPs8CghtK1wa06DmK/pGh+FyVObaRZTtjOJP/YCIu3zeiA37N+jCp
3Wi8BQ2Xj+9k9eY9nMip3qkqTtjNr7YqxkyZxIRnh+FiKuBC7CaWbTvAuZoo0cVndrHGZmDM5AlM
fHYYzqZ8Eg9sYNn2g5y/IZK0iCrpBLGxwUyfPIKFPUZSnhzD2jXFZORWUFFqoKL0zlmV1ymGgZWK
4lxyKzvRb8JzDJoOhtIrxO1dwZbo4ySX3mdMXdGBgDZDmNFtEu72UpIPbeKXLQc4W1BdroITm1lh
1TNu8limvzAGh6pcEqJXsmHXcS7VRInOP7aR5RYd4yeNYcaLY1Dqc0iI/oUNu4+TfEMkaZHihAPs
a+jPw2Mn8vQAEfX5naxYVUROkb5O0YBlvp0Y/9RsJvVvjnvN/C6yywhmnt/A10vWs/eC6l8/Lliu
cHDbTnynTWLYoy8zVm6gKH4Li4vzyS/RVxu9pXLOHz9Dn6hmhJSlkJZTgPrmAtudCOkylvmDPXAy
5nN+73JWbztBak0d5h5Yxte6fMaOGcGIx4cwy1miSp3BwTX5ZGfng0mPqkDPvTY9K85uYslyC9Om
jubRlyaCOplDvy5l8/FUSswSykb9GTekGVXxGzicmEmZVYKLu9lxPJKF/QbT5VIeJXFZVCRs4Kfl
FqZPHcXcl3yRVJeIXbWEzScvU2qWgCIO/bIExaQpjJv8CqOfdMauL+byqa0sWXuEtJrrkCri1/Kj
g5kZU0cx/2VvxNKLxKxYypbTGahqDmmWx//KD45mZkwdyWOveCOWJrF/+Qq2xGf+a+8YvgE72THr
2R46l0njnqCng4H8oyvJSc9Ho9OTsf1LPigfx+QxQ5j6/AS8HWzoStLYsziJ1LyyOi2GESuIX/EF
i0yzmDrsMV6dLKDNVYGznDLppogRpkS2LP8Nn9ljmPa3IbiKFWTFLic1OZvyOiyGMVdQlHO3SUId
kXnRuEkgLoFhLPigLwtq/WRNXMLT724htaTy32v+JpkoTL1ETnhvnvq/UThhQJUex9YPl7PxVBGV
dY7O5oTcwYN2I59gSiMfnGUWKktzuLDjS5ZEF1BlFgEjKavf5DX1DB4ZM4qFA+fgJjOhyU9iS0Ys
ZwuN2OwaDn/1Fi7zH2faw68w2NWKKr0EhUJAkmpqTnBE7uBO+xHPMCXEC2eZBX1JNolbPmXRvhJM
VgmsGvIyNffMtjxsPG9/N4vmLopqQ1r4yywaIqLZ8XdmfHmKyjpHhv1zqDq7lrUXHuKJ+SP47cUt
FN7h2xEk6Xrkly5d7sO6XE899dRTTz3/bQiutBw6g1lDGpGzdzk/78+8D1fK/wEEd9qNf4zZPZyI
/20VG47n/YUuy/8bCL49mPvcaHxTd7F55wkyrvr7CZ50m/0Sc1uWsHnNRmIu3Md1k/X8zyHzHcRL
H83F6+DHfLfjIoW/+5x7Pf9JyALG8uGSeVgWzeeD/SqMdT8o/19PfHx1ZOI//cxwPfXUU0899dRT
Tz11R3D0pkGgFx4+jegwbAKdFSlsTbxMbl2Dj9bzP46SsK4DaOZsRKvVYnMKpM3QyXTzzGNTshq9
oX4h/N+JA037j6SpVEyJphLcG9Jp7MNE2c/z5fnKf/1dzf8h1C+G66mnnnrqqed/HZk/3abOZ86M
4UR63i6wmUjF2U0sWr79wQYn+yPIAuk96wnmTBlIc/fb51kTt4bvft5ATPI97ub+N0PWoDMTnpjB
8PbelF/ax7pVOziRqqqTS3g99SBzw79FN8aN6ErzQDfkFh3FV+LY8tUa9qQWo6935/jXIG/CzC8/
55F2vrjcHOQXADsFm1/lqcUJlBkegA+SzIOgNn15eFBLGno7g1FDfvJxfnxrBbElRurXwren3k26
nnrqqaeeev7nUeDi7YuPtztOd4goazdWUKYpR2f8d5lJK3D18cPHyw3HO+XZUI5aU4He9O+S53rq
qed/Bwe8G4bg7SjndrGoAKzaQvLLjPe8DqmeB0+9m3Q99dRTTz311FODDUN5CYbykr86I/eBjSpN
MVX3jvNSTz311PMXYKE8P4vyewvW8xfyO24Uq6eeeuqpp5566qmnnnrqqaee/2z+0sWwIPcgcvTj
PDu29Z+8RS0gU3rTdvRjPDW6Zf12eD31PFDkuAU2p++YqUzoFcZtj8XUU0899dRTTz311FPPvxl/
4WJYQKbwoO3QiQyP8v/TJ9ByBy/aDZ3AQ+3+fF311PM/hSDHzT+CLgMG0a2J57+Pu4ncCY+gJrRu
04Jg1zsc1qmnnnrqqaee/0QcfWncviMtg9xxqp/Y1lPP7+b2m6QOwfR59GkefSiKCF9HbPpSspIO
s+abxRwtqQ7HLjiGVMsMbU+4ryNWXQnZSYdZ/e0SjpX8N4dsF5A7+hM16QkWju9GhIeN4ksH2fDT
EnakVd5HtEoBhXMgHSYu5PHxXQlzs1J0MZYNi35m1+X7SecBIDjhGTqYZz9+gj4BbjgKVgwVRVw5
E8vWtes5lFl9wT2CAmff5gycMY8p/VsT4iHHpMknJT6G9cvWcUYtXpeZOY8p/a7K5JESF8O6ZetJ
KPtvbht1QY6LXxN6TJrLrIfa0UCpJzM+mg2/rOdQtqGO713AwSOYyIFTeHh0TyIbeSE3lnIlbj9b
1m3kUEbVf1TU1D8LwSWY1v2nM71zJbu+vEJh1X96rQg4hXVj9MyJ9LCfYPFnW0m9TfBJpWcobfuO
ZuLovrQN9UJRVcSlYzvZvGUPp3Pq2jYEnCN6Mf7RJ1gwKLSWAVHClHWcLb/8yNKUBoya8TjPjm6O
4mZbgy2Pk1tWsWR9Ac0mTWWQfzpbF/3CsWIREPBuM4yp0wYTmLmNxSuOUtG4H5MffZy5/RveqCvj
MBtWLGbZcTtRI6Yye84wWns6IrMbKC+4TPz+7Wzbe5wUlbnO5XJpPojps4YSlh/D8iX7yLwlrpIM
15C29Bk+gTEDomjs74RVk8V/typDAAAgAElEQVTZmN/YvOsQSUWmOutyjxzBrLlzmdw14Hq5RBXx
m1ewbMUOLuqUhPWawMMzpzGguSdOMjvG8kLSzuxn27a9nEguJ7DfTOZMbIf+0BpWbjmD6uoVs17t
GTdnJn3ckvht5VqO5FyPM6zwac1D0+cyvYfAyV+Xs2r3RbR1yrSAa5sxPDbvEcZ3Dqxl2JIwXNrO
4p9X89vlAMbMe5TBPmlsX72Ofak6JMGT9uPm8chAT1K2rWFLdmOmz5/F5F6NbjE+S5bL7PpxCau3
nqLgHjGtZP49mPH4FFrpYtmwdhfnVSIgJ3TgYywYGUT2nrVsPCZj4NOPMaGVih1LV7P9VC4mSU7Y
4Md5rI8LF/Zu5LfTNnrNX8jokFz2rNtITHIFOIUy4JHHmdrRzNE1q9l21oWhzzzGuGZF/LZ4Nbvi
8zFJcsKHPsnjvZWc2bWRHafzsCi8adZ7JBPHD6NHcz9kuhzO7t3I+l0nSC0x4tZ5Bs/PbI56z0Y2
7k9CVTPkKZqO4oWFvRFObmX9ARM9nl7A6NAsNvz0K9HnCjFLciKGP8eTPUSObtvInoSCOkSOFvDo
MouX57WkZMuvbIhJovQeQ6wysCvTnniMcY3zWffdCnbH51CXrlHWYBBPvzwJ3wurWb3tJFcqqt9F
07Gv8uxAiSOr1hCd7MqAx2Yyul97wtyVWLVFXDkby/bN0cSll1JlBwRnIsc/w/wJ/Wgb4ooSC/rS
bC4c2cq6rcdIKdJTfw1q3ZAF9WPOsw+h3/Q5vxyqxGT8T684GT5DXuPrx13Y9urX7M5UYbilSAKu
Ef2YOG08g7s2J8hVQpuXyP41S1h3IgdtnQPlyfB56E1+eKYvwZ6OXB/CRMr3vc/Crw+hbvU0y98Y
TiNvJ24e4iTjMT6d8xGx7uP45P3+XPn8FZbGq6i0AshpOvMrPnkomy9fXMSpUgMew99m0bO9CXBT
3qgr+h3mf3WUUqkDT3z2AiOaB+GhlLBWachPPsmO1b+w66IaU53DQMvwHfUey56w89OjHxKjNtym
H1EQ0HUKs6cOpXvrhngqTKiuxLFz+U9sOKvCYq+7ruBJX7D0yQ64K2ttg9hSWDz/WdZmmrDhRu/n
v+GFwaH4ujsgWKsoz0/hxO6VLNtygTKrE71eX8vbbfbz4twfuWCyXxtfZWEP88OSmZR+/DDvxOqo
nS3HiLH847Pn6V6+gvkLV5L5B8Nk32YxLKfFIx/w9iSJ2KUf8t0lNZJnGJHtXdFdvaBbUNLikfd5
a4JI7NIP+TZZDV5htGpXS+a/FJmDK+GjXuatRxpycd2XrMhyJmrcLB5/242qZ97ngLpu5Zc5etB4
1Eu8MT2Ii+u/ZHmuKx3GzuDxt1wxPP8RsXVM54EgyFAo3fF0NnL25zdZlmDDu1Eb+o2fyHNv+SO9
9BmH1CJKd386zXiFhb21HFjxLl9mVKL0a0hYiEhlVXV+HTwC6TzzFRb2rCBm+bt8mVmJg19DGgXb
r8n8L6P0bkSH8U+xcKADCRu+ZIWuAd1GDGfuc04Y/7mIU+V1qSMJSQYWUzmXo5ewLa8Kl9AODBw+
jFmP2Sl7ZxUXjH96Uer5d0RwJaR1F/r2boIp7le+WqnDrXl3Bg8exzSFiO77rSTfOru4M/ZSLh6I
YfPqw+TUNE3RUoWuQoPNrOLA8rc4v8kRZXB7Bo0cSFtrIlvXxpJhtlKlK6eCxjSrs65iEqP3sHX9
MXKv6apEW16OKITg4uaGveAk637cwrEiFyI6DeChobOY4+vCsmW7SNE/qImghCiXYVKlceTXg6wu
lxMc1Z8hAyYySTKjW3WQbEvd0qlKP8zaTy+wv0UfxozpQXDJKbZvO0qqupzyKgmQ4eTmiYcpg5hl
O9h5Ro1LwygGjhjErDleuP6yhgOFhRTp2hEe4I+/q4CqUgIEHAOCCPSDyqxCikqvT3dkni0YPGUq
Ywe2xsuY9PsMY/Zcjq9fy87ocxSLNXVi0qMpr8BuVHHsWAItpnWhU8e2pGSfQB3ak95dwjFf2sOp
MxlUGApZ++Uldi9W4hjRjynjOuFy+RA7952lwGJGr9FQ8UCDOws4Ne5N/+6XSM8q4mzxPfpRmTdt
RkxlTHcPLu9YQeyZLCqJBARcmvRhYI+LZGSXcP7mlaXgROPBM3lsYnuElF1882sG9rA+jBnxKPNd
lCzfcIB0iwW7KCGXyW6cQMvkyAQbVqsVm736HTo378/gHklk5Km4qPrzx0e5T0cmL5jOwHYNca3M
efAKZG74NQjAeG49Xx9MRuPSkr4jhvPUG01p8MMydp3JRmeX4+rli7v6OD//sp+zuWZ8mvdl3MQ5
POfhyLcr95FYUFfDcD3/c8gC6f3wZDo7JLPrx43kGn3oOH46Y59/Cm3RR2xPU3FfVyhbE1n16iqO
legwSwAS9koVqkortqRfePXpLTgoZDh3nsc7Mz2J/XwpB/N1mOxVqEv1WNzuR9c5Vry4guPqqpoF
qoRNX4rGaENwccMvwI38rW+z6FAJolsYXSfM5rF3g5D/7R22ZegwP7AuQsTuoKTq/Ba+2ViEwbER
PSfNYvYbT1Gy4EMOqkx1vIJJpHTvRzyZ4IJrj6f57FEHNr7xLUc1ekrzzdWLV0GBZ2AD3DPW8OIP
x9EJboR0HMf8eR/ygdMLPLv6MpfOXsLSvyWt/BUk5dupvuNIwKNVW8KkFKKTDEi18qMIGcmbn8yh
mWCFB9RT3LoYlvkQ2S4UMe49vth4lOo5dQqJJ6+LCHIfIts2Qox7jy83XZc5f+J35EAmx7nLU/yy
/XX8XUTKs+LZ9fO3rDylwg4gyHAIGMiLHz9JnxBvXORmynOTiF37Iz/vy6yxGslQerZg5IInmNSn
BcHuCqxV5RSn7+Xb15dwxlCjS+6Ae49n+WXHm/g52dFknmbnzz+wJq5G1z2R4+DclKEjW2E4+BEf
/XIMPUoSM0SCvnmMsUPDOLSuAJewobz60QICj73HS9/FoRWUuDUaxN8+eJzAg//HKz+nILo2Ycjw
5lTGfszHK4+jx5GkTImgLx5l9OBQDq/LrmOeHhQSot2CtiiDK6k6pCuZZBU7EfLOYHq0c+dwbCWO
Tn40C3ej/MRP/LTtFCYALhB/Q/340SzMFc2Jn1i0/bpM3H3nR46zd2N6Tn6UaUM6Eu7rgFipJvtS
PNFrfuK3i1a8QnvwyN8X0OTk+7y4Mhmb4EaDFiN55p1hVC59iY/3lyEix8knnG7jHmHqoPaE+zpQ
mXOGmE2r+DUmnUrJEd+IXjzy8hxCT3zIK6uTsQnuBLcezdNvDqRi6at8dqA6HWffxnQfN5PJA9sR
7qtEnxXP/k2rWRebQWVdvkfBCe+AFvTs4k3e3q/4dt1ZqmSeZJbIePLZXgzsGUz8Pj2NOo/jyYX9
sO7/ko/WJKGXexLacTQLFvTFEv0pn26+grGigEvRK7h0NemUfMocgni2VzDB3gIX/gILseARSofJ
b7NuqitukpbsszFsXbuBfSlaPJp0Y+yMWbQpWME7y+Ku15fcj5a9xjFtUjBJ373P5sv3avUKvCM6
MPTheYzpHIq/pwN2XSEpJ/awddMOjmVVIgmeNO0xlgV/n08Pr+rpaIe1E3gTCWvRBWLWfM0nu3S0
GjiVeVPDyFz7Od/FFCIiw7dVPyY9Oo1mBRv4/PsjWCI6M/Th2YzuFIqfhxK7Np9Lx3azZctuTmbX
eHAISjwbtaPfuMmM6dWaYDc7quQj7Ny0iV1xebUs2w74t+7LxDmP0FU6w6aly9hz+QHv4ktVZJ/e
yjent4IoIgKy5FJMSg/GRgQT4i8jOed+ehYbRr2aguxMMm/ZhbaiUxegU4NSDESjN2C0lFGQnUWm
qbpUMt/7ybwVg05Fflbmrbu1DgASVkMFJXlXSE02kppehplZjG7dlGaNnEhNNj6gupQw5p7jUO65
a3+R55pw8JpAJx9ffNwEsjV10ySaK9EUV1LpVkJFlQHPChUF2XkUm298XrJUoinOJT0tE2vaZTSS
A65jW9GkcSOOx+aRX2iiWYMGNAh0ILnSDCgIDAkhUGGmsKCAouqOFsGhAV2Hj6S7Xwnxe/dSEOH3
O+vASqWmhLysTPJu01xU545wonVTxrbtTIcME1Vtu9NUlsHBU2dIq7AjUYmmpBINAo6OrdEaqxA1
JeRnZdbRkHC/GCnI0xLUsh0d2l4hszTtLrIuRAwcw8PDmqE/tpbthxIpNEkIToBkIC9XS3DrKKLa
pJN16MoNTwqebejZtRmKjGjWb9pJXK4JKS4VrewZ5vbsRGTTVHLKrdhEEGSyG4+MyOXIELFaRex2
gCpys3WEtOtEVFImuWWZD7xWbsi7UxiDZkygjeEU+2K0dG/6AO40vS0SxrICstLOk6JKIC4hk7kv
zaP/wI6kFqg4f/WSalM5RXnZpKepsKddpsqjAU/3ak1EwBkuFxpusyP41yI4htB9/HQmDe9J6xAP
FHYj2sJTrP1yOfsvldBw6vv8rW0Gy5du5nRGGddq17Ej8z96DP8TP7IqOon8exntBFcix8xn+vCe
tA33w1VhoTznPLEbVrLx2BVUVTaQN2Pqe28yvVtjfJTA6z8z+nUAEf3Rb3np22hSta1Z+OlzdMr9
hQ+XHSFDZULCgXZzPuGVngX88tEKjmYaaDp+ITOHdaN1mC9ucjOa7HPsX/cLm05kXr/3VuZG04FT
mDa6Px2bB+JkyOf8nlX8vOkU2RWm63NVwZ2oR/7O86MakrX2I37Yl4aq6gHPZMVi9n38LDGiiL1m
hRSv8qLFPx+icZgzDpkCBvP9NB4j6vwcsvLKMd38mKGM/NwyQMA1VI/NrqQsL5fsbA3Gqx4f95V5
I6q8HLKKdVhu0lU9U5GoUmeTmZ6DzpzCxQw5EUsW0q2jD9G5lZgf2GpYpOzYL3x/7Or/4zlvakyv
t1sRHqhApqbOa0ybvphsvYBbs0pEyQl1TjaZajM3by5LlSVkZmRQbrVzJSUNqfGvvNmvF+HrrnDl
bBwp4gLat3Njc4GZ6humnInsFIn88q8klIvXsiO4tWP+O3Px2v4WX/v9H/9o/SDq43bvUdSRm12G
os9ghoSfYHu26dan7DpyczQoeg1mcNhJduTcRqauSBLW4tOs+uUopXYf2o6bx/Q3XqFs/qtsLxFB
krCVp7FvxSfsUVVglvvSatgc5r3wJqbcx1mSYkWmdKHd7Ld4smsOv375GqeLjCjc/AjyN1FYO2uS
HXPBCVauPoFa8qX92NlM//vf0Dz+Bjvv5VsEIMhR+LSieYCVtA3pBE/+mHfG2tn0/iLOZciZ0bI5
7lIW2rxYvv+hJR+99BzPXXmFz447MvCx2bQr3cjfV12kSnDCw6cVTf0spF3KptHUj3lzhIUtnywn
MVPBlJbNcReyqfgrBwNJwm4yYUJAqVQgIGK1aClUWXBv1ZteIec4UGC+6SERm/mqTC96hpwj9haZ
uiDDySeCvo+/xTNdDJzY/AU/pxlwC+vNhGntaBXszLaL93YgAwEn38b0mf0qC9qVEr3qIxaVOtGk
1xjGzn0RZ9ObfHu0sk75cfZrSr/ZLzM3spjolR+xWOVM095jGD33BZzNb/H9MQ33bEEKF1x9GxPk
VElOoZlO8z9hZmQJ0etPkF46mKjG4bjajpGXFMOvO8J4ZuxcHsn5lPX54QycOADfjC18tP0KN69z
ZQ7uhDTrQN+OgVTlnCC19K9pOJJFS/75fayNTsHq25JewwYydY6A7sMlJFrM6AxG5G5uuMiUWJ1d
cXe0oatU4uDqiMKqo0JXt2/QxTOAsBA3tHEr+e5AFo4N29N36CgWPNsA169/IDpbT8653/jspXS6
DxrNqEgTh35ZyfESEclmokpbjt0G6pIr5OrbEtKkMd4HCinDDS/vEILdjZRmZaGS5AR5BxIe5IT6
xHK+PZSLU2gU/YeOZcFTAbh+t4T9OTY8I7ox+pFHGeSdzt6f3uWyKZAOg4czbNZslJZvWHtOW7No
dsHHP5SmLcJpqCulaZgPsstVD97oVbMIvorcyRkXVznWSg0a7X+Pd4Zkq9llk8mRK/6sA3MCStdA
WnfoSJsgieKjOeTXzd/4DyBit9kR7QIIMqjKJzevEFtYMA1DAlFm5GKVB9KoURDO1iLy8wqr3VwF
FyJ6j6B/c4ErB/dwSurF1PDfuxi+B9YC4o+donWThxg89yncRDWXDpwkPlnFn7XEujsi6vNHyHUJ
Iqx9eyLT88i/nZjgTMM+U+kTFYkycQtrdx3nSoXthnRUZw+T69mIJh3a0Tozn6LrD+MYEkpDbytl
JwsoKa1xzZf0pF/JprRXBxr6++JVZsZsF5EEAZmzNw28nLHryzHIZGA1Y7ZasSEHJFRnYsn1b0rL
jm1Jyyqi7M+qHsGd1qOm0d87m0NbDpET1pAuTf41oUTFsrOcThpO514tCPOLJy3/dpfM2LHZRERJ
hiAIt7ik/vXICR8+jzkPBZB9YDHvnM9BJ3MnMECgoEiP2S6i1VZgdXTCValAoXTD01uJWavH6OqB
u9KAXmfGWhf/b8GRwKatiJAusu6bQ1wuU9K47zgmPvF3fBw/ZmlMCsWGbHZ/8Ronm47g+Sf7oN+7
nG1xOZSZRURDOaXlBkR7ChfSdPRu2ZJgtwRyVSYsshCaN/XGnnuQvMoqzIITDZq1JsKeyJovDpNe
4Uiz/hOY+Myb+Dq+z+LYK6iNChqPeYnXJweRfWA9ny4rQIgYxPQZz/C0vZLPNp+nQHd10RxIq7bh
+PqF4BHZCLcjmair7A98l1+y22uNmwJO3j64oqak1FLjdfHfgWQyYhTBzUH5J34TMpwDIhkxohNO
RUc5l2fB/qdPE2xYrRKSIEcQQFTHceryQmZ1bodL9GG0iOAQSbcoJ7K2x1Nil6rbkMyXfs+/Tv/c
73lubQrBTz64d32b3tBMwuI3+db9dRYuWcfoE3vYtm0bMWeLubqulCQjCYv/j+/d/84TS9Yy+sQe
tm/bTsy56zJ1RhKx5Z0h5mgcZkHOhVxPopbNpnsHd3ZEa5GQEC15JBzKq3lATnqOE217v0hka39k
KYUIghxvb1dEbQ6JZxNJqZnwJd2sS7RjyT3DgaOnMQtKLuV70fbHaXSNcmfXARPuUQtZ/PkkQm6e
V4kW9BnreGnhSgq8vPCUDGRr7bg1DcbL04y/s5m0cjPyBj54y6DCZqT09DK+2vY+7zz5Ni+01dG+
eTa/vrKRK2ZALqDw9MRDqiJTa8etWTDengb8nM1kVFiQ+XnjJaPubmSCgNzRGWeFrOb92LEajVh+
Z4MWZA64B7ei35TBNNEnsySxHBEJs66IEyu/JeipJ3nup2WMOrKbnbv3cuySmuolr4RJW8jxVd8T
9OQTPP/jMkYf3c2OXXs5nnxVpg7IXfEO7c1DHQUSV7/PJ1tysQmuBGiD6Tcpsu4FkbvjG9qTQVEW
Dn//IctO6ZGQkVmkwbHBKwzqEYXX8WP3Tkfhjl94D/q3NXLw+49ZHqdHQk5mqRanwBfo0609XmeT
8e+/gPdfHUrgzRGkLGWkn1zNex8eQeHhhrPdQKVRwM0/GB8PC55KE7pKEaW7Bx4C6CoLSTuygQ2h
zzHnybcISTPQwOUSa7/ZR87/s3feUVYV9wP/3Ne2994bC0vvvfdepEtvBo3G2E1MjEYTY4kaSxQR
UIrSi/S6FOm7sMAWtvfeX93X7++PBVxgkV1YjMnvfc7hHPade2fmzsydO986Da0qUg8ie0znxb/N
o6NUQ9G1Q6z67ii5zdyNChIpMoU9djIBEBEtZox6Q/PjtvRKKjLiOHHmGmZFNpUGd5bNbEXbVo7E
5eqpVetQ+Lrj6RtF+8eWMCcyi7WfHMbgYo9CX0F1M7Q/olFNdX4y8XGJmC4lkVNYw4KlI+k/qAOn
8y6hqVNRUVxKeY0OvV5DVXEeeYUNXwiB6ooS0vI1tA6PobX7Gc7r3fHwD8bNWkliVhHmm7pag5rK
vGTi45IxXUoit0TJwvkD6de/HWdLy4ho24MOHnkcXP0ZWxJ1iMgo0lpwnDOOmE6tcbkSh0oERCU5
146y/l81REgLuHy28JF7f0icQujWfyiDww0k7ThFYnM1bNJAek55hT5TXqn/21pC3O4NfPXpbtKa
oo8CEJxpPXwJ/xix5LafRW0Gxxsaw6Qh9J35GgNmvlb/t6WIczvW8fWX+7ndPgcSO3dCe/Slb49A
yDtIVpNjoZuBIpIhsxeyZOEQwq1lXN73PZtjr1D+CAdNkNrjGdaTwQN6Ei7JZX9hIUqrGktuPiW9
+xAQFISPNJ9S72BCAhwxll0lv1CFiIBj1ACG9wrCkHaU4xfyoWf/B2+INIrRT/2DsU/d+NuSzeGv
V7Fu84/kmQFE6rIucP5KJ9rN64wi6SSXEhIpfSRW3yZiKOBiQjm9h7WlU/toDHetgwLO7ccwu7eF
ghPrWbXnOEnljTTYkM/50zUMGB5Np7atMAk/3e/o4oK93ES1to66W6YdkTqVCp1BhpOzPXaiAYPJ
ilQiJ3jgHKbN7ov1+NdszJIhGPXojSZM4o1NhiGXMyd1jBjZlk5tMrj6SORTAZeO45ncTUr6kdPE
p1bgFvoo6rkXJqoqqtErvHF3sMPujl29IHPCP2YE4wdEYV+xm4Kq2rsUvg+LILfDXiFDKtR/48wG
PUaz5YYFqilIcHZ1QmaqIut6MskpBajNIik/1UBtZQ1Gew/c7BS4dZvEH59qR+Y3X7C1xBM3qYqs
agPGpq6ZgFibS0rSNa7lK4m/lI7W7k3mDOlH6LViKnNrUFeUoHWqQWs0oK0qoaggj7LbOk5LUkIq
qj7RdAh0IamwilqPaFr7Syg4ko1Kp0fEvr6umhySEq+SUqzm0qV0dA5vM2d4P0KulFCr7sTEsRGU
7v+IVbuTKFZb4Go6psBonu/UlcAjGZSplPVKMEs2+1atxpTgSuGZC5TUNjW/woMj8x/IEwv6Yr2w
kmPZNWibq42T9+H573bzws2/TRf515K/sS+vEUvxvZAGMuW9HUy742drecHtP8j78fKWfbxyq67z
fDj/bQ4Uq7h9JRJQuIbSc85jdJdls/1SOXpzy0uogvMw/rzuVYZ6OSBVX+WbP2/imsr0SPclEoUb
oT1nM6e/E+WHLpJvsiJaSzl3JpOlM3rSzv4U57Ugbd2Tbq4FHD1fiFmsDynyHvZ7nml7iQ+fPkm5
WSCgBdvV6NIratPY8dZiDgV3Y9i4SUx9ax2L0zbw1pvruXrDxcOqSWX7X5dwKOSnaxalbeCtv67n
2oPGbokilpoSSvUCIR5uCCgRBQly765MWzqfMd0j8XUU0Kn02NlJKLCrb77FpOH8d6s598ZTfLRx
IFd/PMbRI4eIvVx479gBUcRSW0KZXoKfuyuCVYXm+ne8umwf8rsvxmqspcR6w1sPEYteScKKp5i3
CTQ6O/qNvv16i76WlC2fsLnTv1g6Qs/lr3/HD7l3r4QWXTXxXzzFvO9Bp3diwKjmd5vC2Y8Bv1vB
G2O9kGBBV3mdTa/9jm+uN2dVELBzC2L06zsZ+boUKSZqM0+w9v3POXIz/spqQl14jnWvX2FfVC9G
jB/P/LenMvvSBj781y5StWK94qDgLGtfv8LeVr0YOW48C/42ldnx6/nwkx9Ia0KmDkFhh2NoGP6m
UvZcK3pgS4NgZ49TWDQdQtrR+51dPHbLz0JAsKopivPEXQDlfctxwDk0mg5hHen97i6mNyzHoiT/
giduxipyT6/kpfSNd79UohmjroZyqx1h9T9QV5bBkQ+f5JyjiOgYyehht91AXXk28T9sIjrmNSa0
zeHY6u+JLbpj/lhUFCTu4B+/iyOidXcGjRrKopck8MHnHCtsaq8JOAd3YtyTb/H0QHcE0UhZ6kk2
vPt3dt2dWajJiCY9dcoq1NZQnJ0dsRr0aFQaTJFehPv7EdauI94OVtp19CbN0QGZsoqqZmwUbsOq
o6aqgKwyC32CgvCTXEJz36aLGCpKyU/JRTM5ivYxHlzO88A31ANp5RXSc42AXSN1aamuKCC7UqRL
UCD+bno8gsLo1KUrvT8Zym9uzQ0JEmMh8UVuuAjUC8OIGGvyuRqbz9UHfNTmIHMNp9f4OTw+1IOs
vWvYeqqQZssqlgqSY2PZ8f1J6r2rTehUNVQ156UUdeRd2MW67XtIqKxPoOUa3Z/RI7vcWE9v1lXG
1UOH2LX19A3XXBNaZTXVZqhflCX4dZ/C8z0m8bwgRdCXkXhsK+u2HiLxUVhrTYVc3LOC/IQDtOk+
hFGDprBgPqxbt4erVS27XZCGDmLBX4aw4C+ApY7y1FPs/H4nRxPqQ3hUeTnklvegZ3Aowd5xmEJD
CXYxUXE9j3yliGAXRq+B3fA353DifALFRpHAh2mQpYCzWzaz79DNmOH6ON/qBo8tcQsjMswfL4UV
9+BIwkKDcMrObFrIyCNBRH39HBcj2jK8TTvaqBzvsqYYy3PJqXHGvdNwhvTJo7g6jnzNnZsEEXXy
GS5ExTA0pi3RWkeE21LQ3MtGU//gorEOg8mCgzyIDpGOaNVWAr0DCDa4IzXqqTMZMd0QQkBEnXSK
c21iGNw+Bo3eAdA+dE80RHBow8ixXZDmxBKXnEW1GdxatIYmteKuX6TtZvHXr2YjCAKiSUVe3G7W
bowlqUB9fy+rZiElasIfeGXuIGL8FAhiNac+f5OvDlwhv8l7VRPXD27nRNRyZv/lY8akxXHq2CGO
nE2hRGnAgoi+qhKVLAgXJzc6dmiDu3tbOrTzJVbhh5teRa3O8OAxn+YSUq6XYJgUSLCTA8lCTRNi
Oq0or1wksaYXMZ2Ccb1ejLl1DKHyAs6k1qC51+bYXExySgnGicGEONmT5RFFhIsHHZd9TJ8l4k/u
qlIZksp8POQyZAI32mNFlXaMbT8XpdCC2IeN5Ok/PkHnyq38c/05CpVNTaTYANM1Nry2gTOlN2OG
dVQU3/x/E7FUcPyTT0gwt18AACAASURBVNmZVE29Z7mUkAmv8FzPO/rYdIW1r6zlbKX2hrFBS3m5
poHLtIwuT65m53IpMpkES2UCW/75ATvS1RgegYQq6i6w4oVn2OXfil4T5jLr7bfhT6/xfZLygY1p
90LW71V2HX21/n03VJFy+F+8+c01dBYRECk+8yOZix+jd1t7Ll7S06pvb3wKT3I2z4woguDajyd+
055rK37DRaUFsYUPyf2Z0qxoC+PZszKeg3vG8saXL/PqvEss+DK5gXBiQVMQx+6vblzzxYu8Mjee
RStSHsJVyoLFAoJEoD5zcwhT/vw2S7zjWfvv14krrEPu3YtFr83F6eYtogVNxm7eXnqaTX2GMWLY
cBb/fRYLE9fz1l83kKhurB4REQsW6426RBGrrpqC7BqERr51oihiFWVIa2tRCk54eCgQzRoqKwUU
zu54eNhhqa3hVv4jiQw7/3Z0DpOhN0mIHDCYVns3kKan3vVbqUTVoJyqSgF7N2883BVYlbXUNmMi
mnTVXN7wZ35/QI6AiMWkoyK/+W+OUV3G6e/e5NtkJ9pPXM7ciFryC1V3fZis5joq0k6yKSue2GOT
eeHV2SyfnMRL32fc0ihZzToqUk+wMTOO2NgpPP/KbH4zKYlXNmY2UetU/4L8/HpkRRQFJNKfc5E0
oyq5zA+ffcbhogZPIlow1amotIALVkQRJNKfOxTIhLIwnp3//jdHi28vx6hTUmk2Y1JVkK+pvPf8
kUoxqjTUScNxc5ViNmioMUjxcHfA1VmCKU91Q2gCFE64BkQT7SdFFF2I6t6TsJN7yLnNvG7BpKui
MLWKwrRMcvKULH12NEP7RnJya3oT30ERXVkGx1e9RtrWend4o1ZJWcnDr4SiaMUq1r9fol6HrlKJ
xjGC1m10OMmvE39NQ0yPLmhr7NFXlPEwOeNEUUQUxTtc7ER+NvDFVElpQRKZyjZEd+lMlFZGmLc9
1devk/UzKmFRFEEEgZt16Sm5dojD6zZyvqLBfVYTdRol1f8Bz2SZeyv6T57H7P4OJG5fyfojGTxY
bkMTOlU5BVmZZD7wom7FoKmmJDeTzJvZpO1bUaOz4HfbdUZ0yjIKMjPJbHSREKlMPkbszq1cEnow
dkwPnFW1VFU9IuuDaERXU0J2TQnZKTlUauczu38HOsVcJOlMcYtqzy0l8ezevZsfzmShVNWiVOlu
24yIqjxy8yrp3i2Y0LBoCA3BxVRBam4eShHkIa1pE92RoX1HM3TsYkTqPT4kEgF6ReLnu4Z1m46R
2eTEekbUVSXkZWU2GjOM4ETr/oPoGaLj5NpvsIR3o1Pf3mTlFHE6t6Vit+vXEBHq3+sG66pEKkGC
gFW84xthKSPhQjK9pscQ4x+MhyGnYWkYyxPY/cMFjJ2mMW/yEuYisGHfRQruTO5oKeXS+WR6TYsm
JiAUd2MmIKLTaNCbZLg4OeCgEKg3HQk4uLrgaGdGp9GjrzGjNVqwD2lHG6cy4k+dRB3hSVBwIG6G
bHQG4+3xguYS4s4m03d6JDGKENzNqS3Ue/XYtepCp4hoBo3pxdDZr9b3p1SKVBDo2jma0I8+ZePR
qxTfR1Mm3vhOChLhNtlWIpEgUG9lbXzc5Xj5eOBg1KGsM9wSMixZB/n33kPEp5dQW1ONSmtsYtKe
5mKl6Me1/DN9F04KCYhmlMU5lDczKNlcfpF1b6VwrH1PBgwewYilf2PK9NN88+m3HE0qQVtRSrm+
L66BXejTrpa4s9fp6R9JjBCBozKJ8gbP3nxEbmYQksBt37ifK1LUXOFsQgV9unYj/FAegR2icSiK
J6VSXZ/Zu9Etj4horZ/XAvWVCWIlP371LjsvFVHbYJ6IZi1V5bUP8VwPioBD1ERe+tN8IrI38O6X
h0mrqnvANVlHRV4OWY3FDDcZE8riHLKzfsomTaUOy12uBzrKc3PIumfMsIXrm/7MithK3Ic9x0tD
qsnNr8VkfUSbCKuWitwMKnIzSLxciPzr9xg/piO70s5hbGHp23xlNS98cZparYrqiirUd3SAtfgs
p7MWM6lvNPJrOvr19Sf/1ClyzfVz3LnnaIb4eqH40xYG/6n+HkEmR8YSVu3rzCfzX2F3+YO75DdJ
tDaXxXM510qf4AAUJDeyyRYxlV3icq6VHkGBKHgYYbghAhJ5JG2jpGRuXMPGE7lYkSAv9aLMIBJ5
RxushirSTm4l7cedrG81m7c+epylo47xwvaSe5TfAKkdrvdzk/7NGrKrU0kvlzOwe2ecjp9Bgwy5
W2e6RFoo3J6Guv5Lg71HB2Y+N4/gq5/z4kYpi95ewPMLk3lpZQIaqwlTdSqZlQr6dOuE04mzaFCg
cOtEpwgzBdtulNNERIuR2vwkruQ3/Z5GSkG0mtFWFZJ1vY5y1beE/eV3LJ59jusrLzd69IJo1qMt
SSS17DGG+vsiJ+OuxejmNWmlkxnk74uc+wvDoslIXVExFYqBtG7tjSSzrBFNsQWLWY2mToaznz+u
kkTuzGkjGvXoCgoolw4ixF+k5GxeI5YxKWazGq1ejoufH66SpLvLMejRFhZSIetHsJ+VknN3lyM4
+NFm6H3cpN/ci7oqh5K6PrRq3waHiwnoJM64eMYQ5VNH0fHcequKxAHfqN5Mmd0f8cRnvJXgy4wl
k1k0JZP3tly/Z2IRERFEAUHSvJN+LQYN5dmJlDfrruYhmurQ1tagdR1Bh84aiuMOsy8ngJm/GUjf
rGpyfyx78A+RYI+buz9hPnI0l0t/OlpEtGK1iIhye+zsG7PmmKkqzCMxuZz23YczSleEu1M1qUkZ
9X3c2C2CA+4e/oR4SVBnlVGuUuFSUoWulw9eLgaK40t+5jgUAYVHCG27diNCWsjls5fIfwTHPQl2
AXQePIHJfexJ2r6SdYebmODtV4+IRa+hujSPpLRysHdl1rABDOuXQVFs7iPekIn1ggDNf7+ahElH
bXkRefnFjc8fUUVOVi6VXboR3nUQPi7OGCtSyclVIQKm/LNs/jiZA1/djC2T4NNtAlMHh6O6tJvN
e+IoeojUHrcjYBfai/69WiHkHudi7CHK29oRNL07fXpmkFV88b6CVZPRadHqRRw9PXBztUco1yEK
znh6ueEsNaDT6zH8pBYHRDRpcVwq7sT00VFEVBdw4o4ixbp8Tm1cjUS2nLkTZjBRrWHL0aQ74nVF
NNcvcKmkE9NGRhJelQuIGArzKKwZTPfIQPx87Mgr0CMKLrSKjsAXFWcqqqjWyqkzQkDbtjglp1Fy
JYFyt+n0bx+MV+V19AbjHd8zEXXyOS4O7MTUIeGEVN4ZFPBwGNL38/mbp1ljJ701N4IGL2JebylX
9u9k36lUypvilaNWozJKaeXjgbOjAqFGjyi44ePrioOlCK3R2OjcFTy60LNDAELxQfIrq6m7ubAa
lJQXFZJX0NQEpg+KSF1lLumVLVCURUPRteNsvnac7ZuH8NSflzFqaHuul1STVlVCca0DPQcOIlx7
nI8PJyCZ14d+XVuhuH4SdZ3+wS3eEm+iWvlhr7xCcZ3+p7XObMKEAjsHGY0uS2IdSSfOUtB/OL07
lyLp6kzB6UTKVJp797nEh+jW/iiqz1NcZ6SuPIdc7VjahTigOVJKftXPWV8luLYZwqjubhSeOc6V
wlqafNJRM5C492LZi3OIyF7H+18eJeOBBeFfGyKG2hIK8vNI/uZjwtu9x/x5/Uj85DjFGtMjdjkX
Ea31yq1Hgq6S/Jw8akz3GClrET+eyGDRlAG0P1HHgIAcYk/m33CRBt35T1m6cFWDo/qkxCz4kJej
jvPGW5u5VvlwsemNZJP2YvCyRUSUXCQxuxy11ZngHo8xo4OFtJXp6AFB6s2gpQsIL4kjKbsctehC
SI/HmN7eQvrKtObHDd8TEaspj8x86D9iDo/l7CWp0oDcIwofxU87VYnMma7Tn6BL3WWuZJWisTgR
2DUaL5mRbFUTU/Rbjfd1ky62WDDWZXB4/3XGLHuaP5TZsz/Xgc5TFtLNGM/HR/KwICCz96bb/KeZ
6HCaf3z4A2l1Tnz5bRfeX/40Cy8/zxdxagzaTI4cTGfkot/yarkDBwuc6DJ5Hp318Xx8LP8/+2KL
JjQVSezZfoXui+cyJTaJ7zIsOLiH0H/qeHyKE0gtqMGg8KV134kMD9OTeSQHI1IcPcLo99jYBtf4
0abfBIaF6Uk/ktM0N02zhtqCM5xMHcWS+X/gGcUPJKjdiO49nNZ23HAxtaDTVpCUWsHkcTN5aqaZ
I+lG3KMi8RRAc6OcqrzTHLw8mGcWvMEb3rs4mliCTuqIk5OEivgTJFZZ0KkrSEqvYsKomSyfYeVY
pgnPVhF4CFALYFZRkXOGI9cG8+TCv/C6z26OJZVQJ3XCyRHKL50kqeb+btJlFj3W8lTOxtfy3Ohl
PKvdwQV1AL3GjSa4+jT/Plef0djJL5p+j02ho+YEn6zaTbI0DDE2mqfGzGNK8jtsTDLg4hdB535d
canMo0wn4hTYjr4jR9JWTGdrQs5/KInNzyDq0GrK0ehd8Pay4/iGM+RYupNdNZNRPiWcK6xo1kZB
4hJAZJ/xzKz1pkQIouuwUXQQ0th5NvGWIkms06KuqMLq25+hk6eiPFOIKJdgqs7iQnIpVsCqKiI/
5SqFQ55g1JRA0i4fIjH99jVD4hZIdN9xzFD7UiYLpfuw4bSxJLHjfBJqvZGc6xeJ77ucSUtfxTXk
MGczqjDZuWBnVVF4NY7Mmy68ghvhnUYw77mFdFZdZA9lfHGk4AHedRkOzl4EhUf+ZD0UTejUNVRX
6XCKbE/XXm2QFvxIQraIb0QkvoBorkOtrKaqWa5kMhxcvAkKj+RWyJJoRKuqpaZac5d2++GQ4+jq
Q3BEJNaGdSlrqLkzz52lmtT4C1xuM4P+fQbSPbmQs6XNmfVynNzq67o18UQDmtpaamot+LTtRNtI
P6gqpdZsh09MX4YP64pD1n4ys8qaPGYSO2fcPTzwDvLD3ckRJ3cfgsJDUFfWUFPbHNc3EXVOJjkV
3Rk9ZDheFdc4vj+LXPVN11wttRXa+vWqvmZMwTVo6nxRV1dRrdQ1c6zkOHv6ERIRifxG/4iiHk11
DbVqRzr06UV792oSYhNJq9KjT7hIQtd2jOnWjc4p6ZQm17aIq6tYl0taRgEDHxvKuAkGhB/TqPPv
zfhhHbHP201+YRnGO9TimItIuJRG3y5diXFpXN8v6vM5uWM7Pt5LGT9+FMVlVRxI4a5yLsen0a9L
F9o41JcjKpM5H5dJ52njmD5dgfOZTExhA5k8pi2Wy9+TklmIzuqDWutKYKCMolMllJbmoEqvYnhv
DxzUIgZ9I54M5gLiL6YzoFNHou0exP3PDjfvQEIjtDjfXP/EOpQV1Sg1KipLVQ2ulSKpVKPXy6ip
qKRWa2iSRVbUpZN4vZT+oycxpUbAMa4AMXIo0weEY4g/RlF5NSZCAAEHryDCW3XEsX0rBoybSH+/
fHatuExmiRaR5pxF82tBTquh0+jhqaUsP5cytYhzRDtCPOQYdHWYzRawllJYZOKxrmGUbMmkNDeN
c6nD6DXZkeoz5Wh1zXPhlUUOZNK4OnySK3BoP5Zp/dzJ33ye/ArlLaWDtbKQYpWCkaOmMELvTUat
DB95KecuZ1Glrq/PlH2C46kjmD/zcbydM9lwrQzlHRmepa0G89h4PQHXq3DqNJ4ZfZzJ3nCOgmo1
Ju1F9hwaQee5v+UPTq04eDqRAjU4+3mjT/6RK3k13Ew6jTSSccuWMbd7EKZIHS9+eZLcB/LcccAr
KJRwXG4pyUWrhqriKjRGgajxs+jvlsne7wvAPYCwG37/1roqisvVGJuVAcoB7+AwIuQet5QMolVD
ZVElGpO1hQVQB3xCwohw0N4aQ9GqpqKwCt2dlxoz2bnmMEPfepwZHRJYGV+JrlmuEw74hoQT4aq/
tR8UrWoqCirRiu50mzSWYFU+xTVarA6+tBsxm0lBSo6vTqGuGfHJMhd/gr0dcfJ2RiIo8A4LJ9JF
TXlhCSrj/bw7G2Kl5NRxUpc8zuLlZgIzdnCiyHzrSCWrtoLC2yJIZHgoTYimWkryyx/Q861haXeh
wGJxosu055gZ5Imj1IiqKI1zq1/j62351Du5KbBaXeg67TlmBXniKDWgLErj3JrXWLW9oAXjPUQs
hlx2vvMOzk/NY9YfP+C3zjLMOg21ZemcK66j3ofDHrmjF72nvMwsPxcUoo7aokziN/yDlcdrEZuS
h00Useoqycu8j/rQqCV3zwe8ZfcUT059mbdcTJQlH+erN1dyrMKKIHPAvdNMlg6VcOzvq7igFBHR
UXzqGzYP/CfzF8/g+LU1pBhUZO/5J3+3e5Llj73Mm05GSpNi+ertVRz/Bc4bvB9Wg5ryy/s4PuZ1
Rs8awuF3YlFjh8wxkAHzRrLAzxU7UUtlzjVOfvMu3x8sxooMEQVyx0AGzhvJQj9XFKKWiuyrnPzm
PTYeKmni3LCiq8jk8BfvIV20mOlP/IkJaKgsqr0tXbtZVUbyzs9Z6fwb5s75IyNcZZg01RSmxpFZ
ZkDESl1lJie+ehNd6TxmjlzKH2Y5IzXUkH3lOFtSTpBYBSZlMYk7v2SV0zIen/cao5ylGLXVFKac
J6v8RjkV6cR+9Vc0JXOZOWIZf5zthMRQTdblWLaknIQqMwZVGbmqsp9/tJoCEnb+mxXSJSx4/GWG
ylTkxB1k9bpNnK+2InH0J7zHWEZH1RD7r21cU4uIFJF26gdOd3qSodNGcyFjH1UKT4LbD2Rct0X4
uykwqUrIvHycb3fs4Gj6g2TwftRY0KprKMxMpUgWz/k0NTXOBVy9cIH2nSooKGlem0VRiot/B0Y/
MRh/ex2FV46zZf1WDlxvIMhaqshJPMbOA0EsnLSE18cKaHLjOLBlLQkpNzwcxTpK8lKJu5hBn6ES
Sq9eJv2O7C2iKMM1qAtjfzMMPzst+ZePsXnLdg6n1buD1madY9cKDdWTZjBpwtMM87JD1JSReGo3
W9Li4aYwLOqoqcgnKy0XLzGfrLwmZCBvDIkPbQcv5M3BC3/6zVRE3L7v+OKTo1g8vAmOaEu3kA50
u5UBCazlVzmw6Ss+2ZbY9AQ1Ul86DF9C5+ENkl+ZCji3az1ffXGArJbUukj96Tz8CbqNeaJBXXn8
uHUtX397t7XMVJ7KtYRUOk3qRO8+V0j6IfGnMIP71hVAtwlP0nPCkz/9ZszhxMZvWfVtHIJTAO0G
TmRguxA8HER05blc/XEjm/edIKG4yZnDcGo1mMeXLGFGL98bGu0u9Bw/jbjt37Lm2z0kqe5TRANE
bS6ZOaUMHNQHT00p2Vl5j87iLw2l/6yeDJzVoH5DGge+Xs3my8706BSCJfswicl59XNJk86lhBS6
te5Glw7tSMw4S2FLWIdFDdcPb2aDVc+0ydN4aZw7sroy0s7tYd32I1zK1zcS2i+iSonnalp32nW8
dwdZqhI4dOAkEcvGMrBvKtnlxXeVo0yO42pGd2JibmnYyDyynlWGWqZNncjvR3shVedx+dBaNu89
S0q5CQQVSpUBfXE6GXmllGksaFNTyS/vhZtag07fmLlApPbaeRIyuxEd9QCDKmvFqKd6Muan1x1R
f5WN737J1uPJDxWC8lOBKhJ2rGataTpTxy7mzzOdQVNE8skNrN5xnrRyI9hrqCytwHHwbJ4fNB+T
soTMy7F8ueYgFzPL6pMb/fpSRd8fQYFE7kzroZN5PNoXV4UVfXUR189sYv2+RApqzCBaKcgrQV1Y
xo9Xi6lUqig9G09BXyklBUp0zTSRihZHIobMpddUJyTKbM5v/RdrD6TUJ7C6if4au9buwnPhZKb/
fjjOYi25J9aSmZpHjdpQr7SzVnDm4FnGdJqKS+IFrpbVctdpR2ZHIocvoO8MJ4TaTM5u/CffHkyj
XGsBLGTufJ+3a6Yxa9JI5r04Eze5CWXpdfZ9cYnkwlpuaVOsZaQm5lEVZiYnuQCN/gGtmfJOzP17
L+Y17A/daT566p8cyhOIivLD0S+E5f8YzPIG15iurOS3b+0gvULb9G+rvDPz3+vFgtvqOsX7S9/n
SJGyZT2O5F1Z9GEvFjesS3uCdxa+x/FGUgXoEney4+oIfjN7FAeubyNDaWjGc3Vn2ae9WXZbXbG8
NeddTtQ64OzXhlHTZxIV4IbcpKI0K4Ht76xh8/kqDE3OyC3Bd/Qf+OK3XXGR11uUF3+8isXm66xc
9iwbs/XNMsxYK04Rm7SM53tJufzRj5SZmyNMPxyCKP50lHHPnj1/oWpt2GgmghN+0eN59u/j0X79
Iu8ermzhJBs2/isQ7AjqPII5CyfgFvcFf/0+8WfckptYpGMo3UdPZWpvE0c/WUFsyY2dgmBPSPcx
zJ0zAsX5L/nHluSHrsuGDRs2bNi4JxJPhj3/Dku9z/DBl7u5lq986L2OxG80r741Du3Wz/j+dBaV
N82tEk9GvPwBy9yO8fbne0gpVv9iwocNG78G4uLigOaeF23Dhg0b/wvIHHD18CHAz5vA9oMY2S8E
5fGVnC/934g8smHDhg0b/38RHHwIDXDB3j2KgTMfp03JXj5OKaXmwbNE2bDxP4tNGLZhw8b/OyTO
gXQYs4wX5nZBWnqN4z9sYPO+tHsmJ/ufQXCj7dDpLHl2AX28Gs24gibjJNu++Tff/Fhq875oDMGL
rpMXsGTJFLp4NN6HysS9rPtmDdvifiUeLBIfes1YypL542jv1pifqpXahB18vWYDe65UPXrrkMSX
fnOXs3j2SGJcG29PTdwmvliziUNJNTZr1aNEEsjIZ15k4biehDk1PhaVp1bw3qq9XMixWQ7/W5CG
DGbpK7PpFSRQGLeLld8cIbX0ZxJn/a8gjWD2e++xoFsALncnAAIsFP/wOs+tPE+Jyubr1SjSaBZ/
+Snz2zgjbzSfloXCzc+x7KtraE2/ii/cQ2Nzk7Zhw4aN/zdIsXN2w8vHE8d7nEhmNWiora6kWvur
S8P2K0GKg5snnp5uONyrD/UqqqurqdX9WvpQhqO7J56ertjfI1mopa6WquoaVHW/xHZZhpOHF54e
Ltjdqz26Giqra1E/inS0Nhogx8XHBw8XRxT3GgttJWVVKnQtffioDRstjgL3oEA87WVI7hGfblaW
UFitw9zk2Nj/b9jhGRKEh53kniH+ptpCCqr03HV61H8ZN92kbcKwDRs2bNiwYcOGDRs2bNj4f8NN
YfgRHShlw4YNGzZs2LBhw4YNGzZs/HqxCcM2bNiwYcOGDRs2bNiwYeP/HbYEWv8JJHa4hj3G26uf
ppscRKOaskN/Y+77Z2mJoxlvr8sBz1bT+OuK5XSRg6ivpfDAOyz66FzL1/W/isyd0K4zeO29BbSX
g6gqInn3Bzz71aWWP2pH5klkr1m8+rc5tJODqMwjYeeHvLQ6wXasT1ORB9Bp+Byee3UK0TKwVqRw
cutnvL0xqeX7UBFE19FzefaFibSSgbXsGkc3/5t3t6bYxutXjNyvG+Nmz2FCSBEHvlvProRfSaIr
GzZs2LBhw8YvSiPCsATfqR+z6be1vDXuDU7cT2ISBByipvLmB8/Qo2I1S57cQF5TdhWCFPuYJXz5
yUgSXpnLp1fqt44SmRO9n1/Hm6128dRT31HgMYhn3l/OoABvXBUmlEWZJJzaxXcbj5OtEwEBqcKL
oS9+wu+H+OPqIEM0aqjMTeTHvetZuzuZ2l/bLsdqRFN4gHeXxOPmFsLIJ19gUCOXCTIHfDuOZ/68
CfRtF4QbGopSTvPDt6vZlVjbtM2b1YAydy/vLDmPh2c4I5c9Te8WfpwHRZA7EdBxIsufGo/Lybd5
eUN6o5kOBYUrIT1n8dLz4/BIXsOrf91D8S85pmY1JYnbeGvpSXyD2jN69jTC724lchc/2g6ZxdzJ
/ekQ6olMX0Fm/FF2btzMsQxN07JwmpUUJmzmr0uP4R/aidEzJuLf0s/TTGROPkT1nsCsaSPpFumN
vbGSzLgj7Ny8jdiMm9lFZTgHxDBw+kLmDG+Pj6SG9LP72Pr9Tk7n1/2yGUjNFaSfXsvraXsJjunL
uLG97pkE4iYSpyC6jJrHk7NjqD3+DR98dYqKpjTaVM7142t4PWk3Ie0HMG5k55Z4godD4oR/u35M
mDWD0d3CcLXWkHPpKLu27yY2qRzjLzkY8gC6jpnJoqXj6OBmh8Sio6Y4g/ije9h98EeSyw3/key0
UidXPDx9CfKpw9PdGSk2YbjFEezw6zScKTOnMqpLEAp1Nud3b2LrwQukVzdVFSvBNaI3IyZMZtzA
9oR4yNGXZXB+/xa2Hb5ARqVNpWvDhg0bNh6Oh7QMCyhCJvKX9xcSJRpbflMjCAhyD4KCPcj97hW+
viLHP6Yfk2e8yifdw3nt5W9I1IIgkePu7YUscTXPrIjDYO9JRK/HWPTkO0TaPccLm3N+ZenkRawm
JSW5amrchXuc+ybF3iWSkfMnE156kK93ZqN1asXg2TNY8qqMyqff55SyKT1uxWKspSRXhVIj/3Wc
MSdR4BLUiVHTH2f66G74msq5do9LBbkLAZ2n8PsXJxFiqUP9izb0JhZM+hqKc9TUiZ4oDY1dIyIK
YDQqyTq8mt15ahxCujB0/CgWPWml4s/fcLWuaXUZ66opzlFjkPqhMoj/WWFYsMcrtBNDx/bEPmUH
n28sRxrUhWETxjB3KdT87Vsua8DOpxV9pi5nUR8rcRs/5oohjH5jxrHoSTvq3v+W+NpfcN6JZvSa
Soq0KkS3VqiNIq4/c7ngEEDHodNYPH8Q/sZiappVlwm9ppJCrRq8YtAYRRQP2fyHQ4pX235Mnvc4
PaxxfPvXzylyiGHwhNFMnWePdcVKDuf8kgKEAkcnZ8SSi2z5aiunihwI6zqE0cPnscTbiVVf7yZF
/cuvSfrsM2z79DoHFWY0FVU2K36LI+ASM5LZ86bSWUhh1xebUQf3Z/SYecwSYP3O0+Q26RwzEYtM
Ql1RAgdW76dYvCiumQAAIABJREFUY09En9GMnjibyXV1fLc3nhLb4NmwYcOGjYfgIYRhAYlrF554
cxHOO/7EJ75v8JeYlmvYbYhWlIVppFzTkZJ4mXOXSvnHvxbw1JTjPPNd7s2LsKhLyMzMoA6B7Iws
hMg1PDu4H6Fbc8j5r1P7W6irSea7Vxaz0WzGAgjyRNL1/rR9vg1tQqWcSmzJYzskKFyC6D5lEXNG
dSXK1wF90VVit37D2oNpqEUJ9m4hDFzwLLP6RhDg5Yo9Wkqun2HPujVsu1zZZIWDwsWHjhMWMs43
m32fXyBo8pTGBT6JPZ7hfZi1oD91uz9mfcB8Jtu34CO3MGZVKamHviX1xt9CSj5lskBeGRFEkKeE
q0UtOQllOPm2ou+UuUwf0pFQDwnKrIsc2vY9W09moxVluAa2ZdicZUzuEYafpzNycy15CcfYtXEz
B5KqmzZeop6y1FhW/uEEWCxYAcElj0o8eXJoKOEBUi5nKvAJiqFXRzsyD3zOF1uuoZN6kV8tYdnC
LgzqFcDlw8W/TsubzJ2oHkMZO9CXgn3rSAruT8SjqEeQ4x7amcGTZzBpQFsCnMxUJJ9iz7bt7Isr
oE6U4x3di9Ez5zC6Swg+bo5I9OWknzvAjm27OZmhbFr/Cc74+IYQqCjl8t7dHLhYhFVSgFHuhufY
YIKD3JHklP/CYyFi0tVSXpBBalIdqRlV6MX5TOncitZhDlxP0iEKdni16sGIyVMZ06c1fvZ6iq8c
Y+e2Hzh2tYR6HZ4EB7829B4xiUkjetImyB2FRU1xwmG2bt7K/quVWAU7vFv3YsSkxxjTOxpfOz1F
V46wc9tuYq+VoreLYujsRTyxaAghUrDkn2bT2lWsOpzFzdVUETqAmQtm01s8x/erN3Ku1AoIuHcc
z7y5I/DJ3M2362LJMdnhE9OXUZOnMKpnK3wUOgouHWL7tr2cSi6jyXpHwYGADgMZN/UxRvaIwtve
gqaykMQTu9ix9ygJxU50fWwRs3vJSdi1ji3nS7BKIxi+eBFjokqIXbeBg9c1iII9fu0HMGbSJEb0
iMRLpiEv7gBbt+3nzPUKDIIn3acvZVZ3iNuxnu0XS7FKIxm5bDGjQ/M5vP57jqRqEQV7/DsOYuyk
iQzvHomnVEXuhf1s2XaQc2kVNKoLvBOJF+26dSRCls6hLZvZea4Ak30uRvlSxrRvR5srieTn+jB6
0RImtark6Pcb2RtXjNExipELlzA+rJQjGzdx6GoF2owzHMj4qeiLJRI8vcfg7+WOm6NASZOUwjZs
2LBhw0bjPLAwLEi9GfLcHxmY/QnPbEon7Hct2ayfQTRjLDjEgStzea5/X4I35lJ890WIWDAZRQRB
inA/H8lfMeINQRhAkEhx8HBHYSyluLwlt7MCCpdAei9+gxf61HBww3t8XSQlpM8UZi/7I076l/jg
eA0yezfCYqLxKN7DB59exegSRs/x03n8eXuUL/+Ng6VNa5NRWcTZFc9yTpTjHtKPxZMau0qKk080
Qx6fTljKat7bV0nXpS34yI8YidyZgFZdGNozCF3eLq636HhJcPRvy7CFv2dOqyIOfvMOK2pcaDNo
ImMXPYOd4W1Wntdi7+JNeKQ/pO3k3QNpCL5t6T9mJLOfkKP+22ecbJIfMCCKWC0/ic5ShQJHV3vQ
FVBRbQG5C67e4XjLlGRUyxjw1PtMDsnj2KFU8mp6ExEWgpNQzH/AAPjzCAp82/RkyNCOEP8dm655
MGz2o6hIiltUXybOm88w9wwOfvk2GQZ/ug0fy5gFC5EZP2PzVQNOXgFEBDlTE/c9K0/lYx/WjaEj
RjNrDmg+3UBcTRM6UDSg1aqok3sTFBVNwJliSuQeePn5YG+soqSkiUL1I0S0mDCZjJglUmRSCSDF
s90wZsydSldJIns+3UieGEafMaOYPNceqXE1e1I02If0ZtK8xUzrZCHt9BY+WZOPyuqAnaWWklI1
IjK8Ooxk1tzJdLRe44dPvqdAiKDv2JFMmWOHYPyG/akFXNjxKWmx64nuN55Jvbzuap+xtJCCvHJ6
9wgmNNSLC6UVWAVXgkPDCLJTk52bS7FJhnfnscyZM542hgR2fLyBIlkUA8aOZNocOZK1GziU1pTQ
CDl+PSYwf+EUOpiTOPjld6RUu9N55Gi6RIYR4Cbnyt0fuEaQ4dttIvPnjCRMfYktH66l1K4Ng8eP
YObjMli3ieNZTSynxxQWzhlGUE0cGz/4lnKHtgybMJxZj0th/VZOZmnv+1yCQwABft6YqxLQevbi
yb//HrfMY1xTlmOI8MfX2xNFciaxuw8SsGwmw8YNp6L6MOUxYxkaI5JyIJYzSRV3WOwFFK7BdO3d
lVauGlLyiynX/NoWFRs2bNiw8d/GgwnDggyf4c/xTJuLvPvkKaqsCsJauGE/h2g1UFRUiSTGD18p
twnDAgIyB29a9Z/DzJ5yCnfFUdjSPtKCgFThgIP8RjJu0YKxro5HeR69ILXHI3oUy2e2pnDvX4gt
a8HKJA64BA5g/AAZpz99m5WnVYhIyCgowy7kHaYP7I7HyaP1FgGLEV1hImfPX8QoTSGrzJmIN4bR
pZ0zh6olBPVbzkdvTiBAekcdZjXFV77n9Zc2kG4BRPFnN1RSZ19aDZ7BaLfzfP5hPLUO4Q/+fIIE
mZ099rL68RKtZkx6/aMZL6k7oV2m8vK7C+ks01GafIRVaw+R05KufDJ3/CP70D9aSeyKD1gXr0FE
Sm6lBgfv5XTv0RG3C+frrzVqqcm9yrnzVzDLsyhVO+O7MIq20c78qHOlw6jf8OZzw/C5I6+8aCjj
+sn1vPvOD+Q0eH8Ee29adR3OpJ5OpP+wn4tVIoKjHIWLIwpTHTqDFGefQDzdlDhJ9KjrROQurjgL
NFkYFiRSZHb22EkFQMRqMWPSGzC16L5XwM63DV379ydKd441e1NQhfRvyQp+QuFPVNvutHfL4cCq
z9mapENERrHWguPjY4np2BqXa4kAiPoaSjOvcv78dSxXCtFYXJg1OIyocEcuWYMZPG0Zzy3sg+ed
46XL4ewPa/l8xTGKks9xJDaMJTOf4d0u4yjUynFRVBO3dTvHs5tk17uFIJUhV9ihuDkWZhNGgxHz
A42FgEThRnD3vvTrFYqk6DAZeVpEuzDade5CmJDI7m++Zn9aHSJXKTPLcJnSg+iYCJzSionu0pPe
URrOblrD6t1Jd88n+0g6dOlMsPkKP6xbw8H0+nLKLXJcJnUmuk0ETqmJaFQV6NQanCtV6Mx3C8MY
S8jLz6GiZzfCwsPwjK+gyjWU8Ihg7FSZZGYWYrALp3+3TvjXxbFz/TqOZuoRuUaFaI/r+DZERYfi
mJ6C9n795BBB565dCDPGs2v9WnYlVGOVhuEY043oNs3oWodIuvXsiFftWbZv2MSJHD2QSJXEmUWj
womKDOZ8dkUTymlFj14dcK/4kW3fb+FUrgFIolrmwuIREURGBBGv8WLKE4uZM6otLncomkXVVbZ/
tZqN5xU42Uswa/VY5E64egXiXWYHZXr0eOFob4+9IFJbcJrdewLwnT+U6c/0QuFgpTRuNyfOpVLT
cN2xa8vEp55g7qQe+JsKOL15DScuplP964p/smHDhg0b/4U8gDAsIHHrxxO/iSHhs6XEqcX/0AFN
d3yFpQpch7/JgWEgCGDRlnBl34d8vOF6i2dNltm70+d3a/j7RG8kWDGoMtn8ynK+Tm5Jt+WfEGQO
+HaexosvTcHlwie88f11mhR+2tTy5QocItrQ3i8cl7d2Mu7mBk4QEEQ9VYneeAhQeueNVjMmZTlV
Rhkuzi4IplLK4r/hlWXb755YogWzvpYmGY8ljniF9GHiCE8Svv6ARK2IvcMDPx0O3pGMePpDXhru
iQQTNXnxbHzrj2xMfwQ7KYuakpRdvPfMJcKiuzJo9EgW/eEZ+McnHC5oGYlYcHDCJSSKjq260/v9
H5jdYLwk5moyfvTATeCuOSKaDehVVSgtMTg7OiHWlZMe+yUvJK5vZLzMGLQ1NDRoSxx9aTdkNktn
tEd5dAWrD+ZgoOGbKKItuMbe954k1l5E6tmR8c1/OlzDezBp+es80c8NQTRQfO0I6//5T/bmtuB4
yb2I6tCLnlFGLq07RmadiFvLlX4bEhc3PALD6NS1C70/Hc7yW+MlQWIs4GKB611CBYBo1KFVK9ER
gKO9A6Iml7gfPuK5U07cqWvCakSnqqZSBKm9M24ejhjKUrl8NRNzWHd6hkbRvmsnwpJKSFM2VQsk
wavdSGY98TtmdXVBEHVk/biDtV9+zfHC5miSpPh2nciz3cbzrCBFMJSTfHwb6zYf4FqtiMTPC2//
ELr0bUuf3pN54Wb/SCRI6jI5nuKCs5MXXr5+yGryyc7IpDGDoMTdC2+/YLoOGEGfflN5qWE5ugyO
XnPGSaDRe2/HQHF2Dlml3egeEUWEZwKWoAgiAmVUp6aRXmhE4uONr28wXQcPpc/AWfyhYV3aVA5e
csZR4L7CsMTTBx9vRwwlRRQUNjEpYiNIPX3x9Q2k29CB9B4yn9dv/C5IpAiaJHafc8KR+wvDUi8/
/HwC6Ta4P72HL+KnqSpF0Fyj4kdH7Gqusu/rtzi7yf7uT7+1DmVVNUpFpxs/WKi4sJV/HdsJFjM+
fRfQ47YbLFReOsD+kCCWzhmDV9Zmtp2JI115+7suGrM5vuEjUk6E077PKMYOncN8rKzffuqua23Y
sGHDho3m0HxhWBBw7jWWob7eSP+ynSE3f5bJkbGU1Xs78vH8P7Cv6v6mA1G0IiJBesfOTiqVIorW
e8Y0ChI7goK8ECvKqbAAUsBiQn1+JS+uOI9Or6GqogrtI0qsYTGoSdz0Z35/RIEAWM11VLTkRr0B
gswJ/x5zee2lkVgPv8+fV1+k6pFUZaWuKoX9H37A/oYbXdGKWa+iwsI9EgOJiCIIEkC0YNJUkp9d
1ahruiiKWJtgUZI4uuDddTBD23RA8u4upkO9oCeVIRF/y7++as2/X/6Ik01KyiRiqC3i7Ld/4vc/
yBEQMevVlDdrM98cLJjqqilMq6YwPZPsnFqWvTiFYf0jid2URkupSwTBSHXuObauWMnxkobjZcag
VVFlBY/GbhRBrE/CDlYzBlU5+eqKRsfLarXWXwtInQLpOGIeT0yNoHD3Z3yxM4mbMpVoNmFU6zDK
PXBxkWDSa6jVy/AJcMDFQcCUr26CAPJTA7Ul1zn81R9J3CRDwIpRU0NpE13wm4rM05/gDr0Z2rs1
w3oM5ymoF06lEiSWEN4OCOPrf27gUov5duspvnqAw+s3c6Ghe7rVRJ1aSbUVghq5SxRFuPl+WYxo
q8vQ1Qj3Hi/Biw7dhzConYQrGz9mw4UqrPLddBg2g/kThjG2fwY5+zObqCC0osy+wK7PCjnjXD8W
dbUVlDXVvb5BOVXXj3Nqx2YuWrsyemwfPFS1VFbVZxkXAEQdeed3cGDLHq40/HZYjWhVtSgtIYii
FasoYv3ZRURH9pltHNy2j6vVt5ejUdbemrOIN/7dA2NJFhmZxXTtE0l0m3ZIAqIJlFVyJTWNEjP1
Glc0ZJ3axP4dh0hq6MJuNaCpVdJknYNwn8Yg1s8DiQSJ5B6aZ0FAEDWkxa5n/+5YrjdYG0WLAU1t
LUrRgVCxPnTo3uWAIKpJPfot+/ecJFXZsBx9/XMZDVjLS1BVNtJS8UZbHXVo9VZkTo442FnQlNSB
YE+oswP2GNHpDbdiqgWXQMJC/HC3B9fw1kRHhHA5M5nqhoulaEBdWYi6spDMxFyUluVMj+lI64gk
Mq9U/Mdd/23YsGHDxn8vzReGRSuaMx+xeP6KW1phQZDTbuE/eSH8KH9+c8vtG4N7liNira6mGhdC
wzyRXCrDioAg9SE01BGxuopGZR1BijxwBKO7SMnddI5C603LlIioLScvO69FraaNNt1qRpmfzJX8
FihLNGOyAPaO2AvcfuyJxA7XsOE8/dwoOPIub66Kp+Yhvvqi1YLZKiDYO9xWl2g2UpeXQ5HQkYhg
gZIzeY1slqX3z5KrcCe4qW7SP4NVV0XW3n+w6MxNy4OAnUcQvaf/lnGKQ7z/yV7SVE3fkFtNdVTl
JlGV2+Rb7oGIaDVjFgUkN/rw5113xVvCzD03n/etS4LEzgG7BnWJeh3qwhKq5V0I9DZTfL7g7my4
wv1zGgtOgU1yk86VeBLRbQxzJodTvOcz/r3j/9g76/iojvVxP2d9N24kQYK7u5RSaHEo7kVaoC60
vXW57a17b12hWFvc3d0hCcRdNrZJdpN1P78/EiBtoWxoe3vv77sPH/5YmDPznpkz8r7zvjMp/KL6
XSaMFflUuDrQsl1rVBcuYpOGEBbZiqahZorzC27sLloHt81IWc4lynx/5NqIIqLXgwcpUoUSRZ06
9FRmcnzFP7lnk7J2/BAIbtaDO8aMpHnFDr5ZepCc+sQjXi5LqClLXqcsr9lIVakeW69wwoMcFJ0r
+a1RRLjxyXBCSJsbu0kvzSIoJAy1aMagN9YoCa5qKsqLKTG3QxMShOLX48zv4LLoKcrUU+Rb8usg
4rGb0Zflk5RahlcZzIzhtzL0lgy0+3JxVOup1BlxtwolSGmlKF/32/qRGNBXVOANa0LLVi0JTE/5
jZu0t1pPZbkJsWkIgQoLRfnlv2N88uD2uHFLFCiUNd/GL1y/3aVkpqeR130wHYeOp5kQjKg9RnJa
7RVMhgoqyi3QJRiNzExRfsVNGbrEqkr0egeKFtHERAcilBuvoRbbsdlseBUNCA4JRi0UYfn12+jL
0VXakbUKRiUxoc2v/K0xWRCwWe14lQ0JDg5CJYD11/lU6iirtCNvFoxCMKLN/+1Be5IG/bnrvt93
k/5xu5aSskpkPZsQG9sARZ4Wl6IxTRtHo3TkoauorAm7kUXRc8x4Brc0ceCbT3C1uY1BQ4dRXFbB
zgtl1zHa1Fj0BEFA+F8+EMSPHz9+/PxX8DvKcADRzVrQos4ML3qNlOVXYLWUU1hnNhYkSiKMbkRX
FSWFOsw+KWwinqrTHIlfyKK7nmaefiWndDLiBs1hehsr5947i0msFVCQENK4Le3aQ2Trvtw5cwJt
itbzwqaaK5P+4P1QfyNePG4ThaVWggaMZdZwKxetKkKcmew5rUWiDqHT+Kl0cZzi84N6wpq1qNnt
E724zOUUlVvqYRH34naZ0OrsBPcaw8zhDi5ZFQTZM9l3tghT0RE2HxvGM3Ne4/Xw9exO0GISNASH
qag8s5cEH8LNcJl8c5MWpMjVYcRERxARG02QSo46rBHNmtmwVusoNThwGMsoNF5+WEBtkdDK7MSp
NlBWosf6t2wFeHE4TJRUCTToMZqpwyDTJkFqyuRIQjmayKZ0v7UXQRV5lFlENLFt6TtsJJ0luaw7
n1vPxbIHu91IqVHKsF6jmDpUQpZdQKjO5NhFHaXZJziYNoB77n6ZF6O3ciilDJssgAClh9ILR0nx
4X4g39ykBQIaNqXbkAFElp9i+0U7kc1bEAmIHic2YyVlBhvlRamcSb6dhaPu4SHnNhKcTek/chAR
5QdYe6bkb9q5cWOxVFPuCKRX75FMLNKgdXiwVWRyNrUci74Ui/5yWoFQZROqLHZsRj3l5dW+nwYM
gAuzuZoKVwhd+4xgQlkQxQ4nFl0259NLyU45w/l+93Ln/GcJabyHk1mVuFVBKDzVFCaeI9t44xJ8
cpO2S1DrSnBGDmXoxMlU7TxPubwZfUYMp0tIJYfztPUyTPzpeAxkXDjDubbNuK3/bfS+VMix0kJS
L54ntcddjFv4D6KaHeBcbhXegBBk1jLyki6Sb6og4+J5LnTrysQ5jxHZdD9HEwswuBQEK+yUF2WT
lFNAUsIFOnebyfh7nySq+UHO5xkRA4KRWUrITU6i4IoG7aLKoEcvNKDrLcMZZ4+mwm6hTJtFcq4e
LyJVmWmkZfWhz7QhRBYdY/3RS2Reft6Wx8UL8XTuMpXJ94YQ0+II8QVGCAxBatSSk5JCoQ/GFNGS
S1JSCr26jmT8LCkBhy9SGdiWW/q0J9pytDaRnaL8Agqdfek/fDx2MYxkQyStG0cSIJTUpLFmc+Fc
PF06TmT6vWE0PHCURK0ZISgUiSGPrNR0ii12tPl5aN09uWXkeBzCMVKromjVKBKNUGvZtWZx/mwi
XTuMY+Z94TQ+cJyLRWYkwaEIlblkpWVQrL+xm3SVx05K/EVyu09kxMRpKMISMTYeyMi+4ZTs2UF6
bjUiChr2G83ovpGUHlvLvr1nMKR7CF84ntuGDEBbsp3zpTKade9Fm5gAnJXlmEQNDbsOZuTgVjhP
nSFfq/fvCvvx48ePnz/E9fVIZV8eWdy3zj+IeE27eX7Cm5z4U4JwRbzOEna+9xIBDy5k/FMfMFfj
xVScwrGvXuKbfZV4kSC6DBRrqxg0432+nOuiujiL+H0f8Niq/eRYrjjZ/c/itlVzce137Gx6H+Of
fp2JxnziN33GkTPFeBWRtGnbmLAWzXh58fgrz4hOEyUHPmThW/vrdUKvy6Incd0P7ItbyISn/8XE
qlzObfyCo+e0WI1aTnzzIq+VzWXWiLt5ZkowclcVBcnHWZ20z7cCRA8us468LN3vp1MEEdPnHt5/
dRyNLq/qm7/G4lHFXFrzGk8sTf7T3In/XERslUWc27yazg/PYerTvfDqUjm64VtOJ1YiVYQR22EA
Y3vMIzZUgdtURnb8EZYuXsfedHu9y7KWF3B2y3o6PngX05/pi7s0icPrv+fspVIsJcns/foNTONn
MeWO+3h+lgaJrZKMs3tZk3oMny7L9bqwV5eSV/07aQQloUGRNG3ZktYt2vLGgHlXH6/K4ezmL3hl
8Rks5VmcWv8NcuFuZs1+mmGCnswT21n684b/7B3Dv0DEVJjOyR27aD1/MrOfvRV7wTl2r1lGYlp5
PZXdG5dlzE/hxM69tLxnAnOfHYwt7zQ7Vi/nUkY5VVnH2fiVCf34qYy782HuiFDiNZdx6fBm1qSf
90kZxuPAXFmCufL3k2Wf3c3PcinTp03iuY/vQ+U2Upx6gp2rNrD9dPmffx98PXGVp5OUkELXCd3o
N6ADFzdepCJpH6u+MqAbP5nRkxcxOkyB21jEhd1rWZN5iXyTF0veSTZ+a6BkxHjuvGMmT0wMQeGx
oEs9xMY1ZaTn6qm4uJufvtKjGzeJUVOfYGyoDFd1Eed3rWFNZjJX3ZFF9GmnObQnhoYzx3D3U8Mw
pR9k7c8lpOfpcYogWvNIvnSJ5F4taJKbRGJCPo4rledCl7CdlV9VUjZ+IiNmPMG4EBmuKi1nt/9M
RVZqnbJ+DweFJ7fyo9fBpKnjmPXEKDDosUrk2MyX04iY0w+zZY0cybSJjH98GHPlHiyGYpIPFKEz
uRBxUXZ2Mz9YyhkxfgLD7nqKSUFSHFUFnNqyEl12OsUWEVPqQTatkSNMncCkJ0cQLPNg0ReTtL+I
cqMbERelZzaw2Kpj5LjxDJ39FJODpDiq8jm5aQWl2RlgsWIos2K4geuGKXUvq1Z4sU+bzMSHh6Mw
5XBq60rW7jpNnlVEFtOLoUO6Elh4nJ3HEyhyiJB1hP3H2tJ0zAD69cgmf08BiuDGdBs2gr5tGhKi
cGMszeL83sVs2nWStPL/zpnCjx8/fvz87yCIonhlxu7du/ffKYsfP378+PHzfxtpM26fN49Rbcs5
uGw5O1N8uaLJjx8/fvz48VMfzp49C/xN50D78ePHjx8/fvz48ePHjx8/fyd/QbitgETRnvuXfMms
pr+JbANqTrfMXfkw879Pv+6J0X5uhIzAqF7c++k7TGp87Xp2W8q5uOJpnvwx21/PfzeCmug2Q7j3
9WcZEXstG5SIQ5fB0eWv8/rmfH8c3N+NEETLfuNY8PR93Prr08UAELHmnWbb0o/5Yn+xv738+PHj
x48fP37+B/lr3KQFFRFxjQmTXy+BiFOvpUDv+HPK+z+JgESmJqJxQ0KuY9IQvW7shmKKDH/2Tct+
6o8EmTKQiNgGBF2vvdwOLIZSSqv/ojvB/NQDCYqAECIaRBBwbVsTXqcVo76cCrO/vfz48ePHjx8/
fv6XuOwm7Y8Z9uPHjx8/fvz48ePHjx8//2fwxwz78ePHjx8/fvz48ePHj5//s/iVYT9+/Pjx48eP
Hz9+/Pjx83+Ov+AALV+RIG8wnnd/fpLeCsDrxrz/VSa8dpibjSQWpEpi+szm4QUj6NokHKXLgDbz
HOs++zcHHXfy1vJF9FIAbjuGfa8x9c2jN12WHz9+/Pjx48ePHz9+/Pj53+VvVIa9uCv3896CiwQq
I7njiTeY8EeyE6QoI2/nkRdn0CpxOR99lUCFV0NIhJKKShd2yx7eWxBPkCaGoY+9xMg/6zX+TgQl
QY1uZ9EHjzCoQSBKiRtrVQlZ5w6w6afVHMixgCqUxiNeYOk/+qMQfvW8aKMydxtvLvyUC4oo2k17
nc/nd/zFR+Gx6Ehb+yqPLL6E+4YCSQiIas24Z95hnHsFz764gQJpCA17zeHVp/qQ/cWjvHfIRUSr
ETz2xkL6RQaiFNzYqkvJTjjG9jWr2JViQFSE0aTfPF54oAUnXn+S5aluQEAd2YI77n+Faar1vPjK
ZkqCGtN1+j/5YE77X8jsNRWTuuVdHv36Ar4cbSQLjaPnzJd5Z1a7X+Zj1JK06T0e/y7+xvlIgojt
OIqHXr6bflEByEUn5soCUk/uZdO6zZwosCEqImg5YCaPL+hE4bJ/8cG+ErwoiGw5gBmL7qF93lJe
+/dBym50NLE0hCZdRvPAC3PoExmAXHRgqigg5cRuNq3fxqlCW829pBIloY27MmzmbCYMaEN0gIhF
l0fC0Z2sW7WVSwaxJk2TbgyfOZvx/VsTrRExl+eScGQn61ZvI8lw4xtOhcA4eoyex4JBLra/+x7b
C72AQGBcd0bMXsAQdvHBu1vJ8wDIadB+EFMXPcUwxSV2L3mHr4/pr96jKlER0bwnI2bMYmzfljRQ
ezGV5XBu1Za5AAAgAElEQVTh0HbWr9tFqrc5fcbOZk5vC9s+/Jhd2pqygpr3ZvRdc+jv2MnHH+0g
/0bHp8siaTtgAgsXTaF7uAqZ1051WS6Jh3eweeteLhTbEaI6cfv0R3hhWkfkv+47nlIS967i83c3
kBvbk1FzFvH4qGZcPWtLxKE9z84Vn/HvHTk+nOYuo2GPUcycO47w5OV8+v1RdAEtuWXCXO7q7+bI
9x+xKimQzrdPZv4D4+gUqkbmtWPU5XPp+G62bt3N6XwzBLfhtkmzGNeukp1ffsneAg8gIbLzcKZN
H0l09ho+X3oSU9P+TJj3MA8MjaPu+WDuojNsXfk1n27L9KG/C6hbDGTSvAe59/Ymv8xHe5KNK77l
ix1ZN353eUN6jJrG3fNH0TFEicRjxVCUwbn9W9m86xgpOgcEtmHI1NlM7mzm8IrvWRevxysE0WbI
VGZP6ED14RUs3phI1Q2P9RbQtLmDWXOH01S7jx++20PODQSUhrZhyNS7mTskgMT1S1myIR4fusXV
5wMb0XngKCaMu53uzcKQWktJP72bTVv2cTpTQrep85jc3cvZtctYf74ClA3pO3EuswaHkrZ5OT/t
TqFKCKJpr6GMnzSO2zo3Ilhip7IwmSNb1rPtwHm0qh5Mvmc6PYXzbFyxltOlXkBKo4GzuWdcW6qO
/MyP29OJHLGAe8a2pGTXMlZuv0RVaHcmL5jHkJBENiz7mf1Zdt/fK7gZve4Yy4Qxt9E5LgSptYzM
E9tYvXEvpzP1uKUhtOg3gomTxjCwfTRyi5aEfetZt+0ol4rMNd+FNISW/UcyYdIYBrZrgNxSSMLe
DazddpSkYjNeZQtumzGdyWP70ypEiWgpJ/fiUXZs3smxSwX4fNagshXD5s1jxrh+NA+Ug9NEeV4S
x7atY8uRi+RXuZC1GceiB+7izt4N+fWZeaIzlY0ff83PO+KxdJvJ4/dOY2iniDqudSLm+FV8/O0a
9iVV+HC6vIrO057iviFKzvy4jE3HszBH3MKCJ+bR1biDZT/u5HxFc8befw9ThvckLkCG6DRTqU3j
1I51bDgQT57egRA9mPufmEJs5jp+2nCENENNu7cY8ySPDlNwetVPbDudh6T3PJ69fxID24T9QmZn
0ire/Gwth1LKfZBZILjffF64fwL9W4X+Mp+LP/HaZ+s4mubDu6s6MPGxe5k8uAuNNFK8jmrKsuM5
sGE1W09lUmZ2I0QO5P5n76GLbhPf/LiPi8U2RCGSgfc/y90dS9jwzU8cTC7FdsN+KBA5+DFevm8k
3ZsEcmUY9+Sz5Z23WHEolVKHmi7TnuTe8QPoEBuATHRg0uUQf2gDqzaeIF1nxl2P/i4Pb8/tEyYz
9vZetIqUY6/M4cLedfy09Qx5VbFMeOV5hlk288my/aSV2kDTlilPP82EqESWfPIzx7IqcMgi6Tp6
FtPvvJVuTUOROaspzjzL5qXL2Z9cgjn6Tl56dSLe7R/w/Z5USi0iIKP9rLd5bmAxKz5cwdFsC90f
/pjHumax5N2lHM2uwBU7mhffmkfkiQ/4cG08BVU3HuWvvFdUV0ZNm8aY27rRPEKOszyH+F0r+G7T
ObRVDrzyBvQYP5tZY2+lY0M1jrIUjqxdyo/7U9FZXDVzvLwBPSfMYdbYgXSMVWMvTeHw2h/4cX8q
5VY3BPRg9gsLGNG5JdEasFUUknJ6B2tX7eVSmRmnr9c2qHuy4K1FjO3YhHAluKwGilJPs+On5WxL
LMPi8iLv8zg/vDiauHA1v10aH+eD+e+wp8iIZsTLfPXoIGKDFXXSeTHsfoP7PzlMqcnpwz3wAQx+
4QeebHmY1575gYRKK94mU3jv03lI1zzOqxtzMcr68ND7jzOydQzBcnBbqyjJjmfvz0tYe6YIq8uL
tPks/v3vcRR++Aifn6jA6gaQ0+2hxbze/Tgv/WMpSUYXoWPfYMlj/QlX113RitiPvMmMN/ZTafOl
3SVE3vk2Sxf1JURZd0QUsR16namvH6Da6cM9NQH9WfT504yICydQJuIwV1KYfIzNS39ge2o1bhEk
jSbx/jf3EbDqURb9lIXDK4KkEZPf/4aFyhU8/ORacp1eH+oZUDRi4NwHuXtkT5qHCVTlnWf3sq9Y
ekTL7x0l/DcqwyB6jJTmmZAqrFTa6zHaXAtBgjSmOY0kxRz48WcOpvy6sY2U5Jmo0LjQ33gE/R9B
QCYPIlTjIHHJy3x31klo444MmjSNRf+KRnziXQ5Umig9+CELLgYgVQXTaPACnrrdyMp/Leac1Yvb
aaTcDSgA0U510V6WvrySi7XfuOh146jW+Xg1kxSZPJyoaCUqSU96NNxEiTGAxt170lgqxRAVjkQo
R6oMJkBazfEvnmblJQnhTTszZOJEFjwVguPZ9zhQXY8qEK1U5Oxg+RurSb4spNeFvbrCh8V8HbwW
dFnbWPHWWlIu5+NxYjdW+paPIEWhCEIj6jj25SesShKJatWDIWMn8vDTEYivfMUJvZ7ilP1sv9iJ
GaPG0OP0YhKksbS6dTQ9FemsXXPsxoowAFIUyiBU7mIOf/E5a1MEolv3YsiYyTwYF474+recMoAm
uhW33vUQ09sUs++bVzmldaCJaUiUxoTVKgICmpg2DLrrQaa2KmLf169yushBQExDItTG2jR/LoIy
kugmzYkmkeOJNpr37E6D4/spEwEEAhp3YMisexkfl8/eL5dzrsRFYGxDwmTVWG0iKP8sSWQo1YHI
jGnsWPYDO3LkNOo4gKHDp3NfwxC++ehHLhgyOfXTayzYrkIW1Zb+I0dzW3AG6xZvJ93uwmauRn/l
m6sg4/gx1izee0W5El1WTFV6365dElSo1UGExEYRZWxD68jjmIOiadyqDQ1V2QSHBCEIclQBwXjL
LrD2qxUc0Gpo0mUgI0ZMYG6oEudnPxNfnybz6kg+sJ/1Kw6R560rs6F+V7F5yri0dw8bfjpCfp18
jAZf312BJiAQb/FpVn+9jqPFapp1H8KIO+ZwT7iGJYu3kWLKJv7sKdq2Hkm3/n2JT9uFtkFXevXr
TGDxGbYeTvJBEa4/kqBWDJo4jSmjuhFhS6v380JQawZPv5u7hjai8txOvl6dg0XVkBbhDqQKKZ5f
T++SYFrfdid3DmlK5YnV7DicSpVXQkSP4UyZMZZ2tgusevdzMkwKGjSLQiy34HCKoPJFmECCAzUE
xDYlrkkcjYOTEZu2oEmjxsSShSZQg4DdpwWHJKQDo+bOZ+qAYPKP/cz73xZgC2hCi+BqbB4vHkFJ
00FTuWd6f4Ly9vP1ujRssX0ZPXom8wPVLP9pG+dKBZoNnsY9U/sRkLuPr9akYW/UjzGjZjI/UMny
n3ZwwaghLCoKb/Zefthzgjxa0HfocGY/0Yq4n5axdl8SFT4oxIKgJCgkAEvSJr7ccZhUUxhtbx3L
mJn3EaT6gZVbT1OYf5Bl78WzQSNH2Woosyd1gQt72X7oEqUuO8YKPdVeUAN4cjiw+Dt2Hkulwgsg
4rVVU2Go9vGbDyI0RIkqtjWt46JpkJCDok07mkQ2IEYIQq1WIkjVBIUGoj+zktW7TpFjj6TD4HGM
m7YAuecbVu46T7EvZV3GncXuL3ex50wWerFGZtFWjU5vrN/VcO5Mdn62g73nc2qNQpfz8e3dBUFN
SFgAVaeWsnLPBbSuKDoNncy4+x9BI/mCVYdT0VWcYuvePrSbeit922SgLc/A1Wk0I7sHkLXzEBdz
dT4owjWyGc6s4J3szYR2m8Kj05pRsHk9exIyyS8rp9ohAhICwiIIKj/El9/tJ6nETUTbIUyeei9P
Bsn4cMVBUkttvvWLyP7c8+xDDIsp5/Tub1mbbUTeoA3tNV5EieS3eUij6D/3fsa30rP78y2cy6vA
IUpoMvIBHpneEsOJVbz/dSZ6SQTN24VSZnDi9nVwloQTGS5F1qgrXeKCSdDqkXXtThNNIMERocjl
MgTcvr1X9CAe+ucjDArKZv/q9/g2x4IqtgPtZWbsXhFRCKDLXc/y1MgAkrZ9ySvJ1YT1nMic+c8T
InmNz/ekU25T02X2czw1QsPFrV/wzxQjYb0mMWfhC4RIXuXzPZlUSoOJadwAw/5/8+XxCoSYboyY
NI9XurTkszcWcyTXgMOHj0yQBBARFUDJjnd460AhDlVjeo2fy5yXn0H20ptsTKnAdmkFzz26CYVM
grrnfF6dHcrBjxdzqLAam8dCRZkJhwgaAFcCy55eznGdqVahEnGbyym/rOTfsAIjaBApIDTqTe+4
n0mpshPWuy9xMgWu6AhkknyQBhERFUDO6uf57mgl3sCm9J18NzNfeAb3ky+xLrO6fmta13m+f3YJ
J6vttc+JeM0VVNnredGq6xzf/uN7TpmctesCEa+5HLPLt1FDEIJoEB1A/prn+PRQFYqwFvSftpDH
3m8ID7zMVq0Db9E2vl43kk+nzOW23a+xr9xN6JB7uatjKeue2Eqey0dFWAii72Mf8OqgSjZ9/U8+
LpDQ4o67eeCVjwh9eSHvnzBeN5+/VBkW5NH0nfUQC8b2oUWYl4r0E2z54RtWnav4E++9lSAP7M1j
y95jQoMaW2XLbw4yG/A6jcR/eS9PrvfxHlBBhrrhUJ546z5ubRiGWmKnMi+R/au+4Yd9ubWDrwSZ
piH9Z9zH3NG9aRGuxGPVo826yP5lH/NTvAlRkKIM78Cd997PxAGtiQ2S4TRXok3byZev/MAF61XZ
FYGNGfLoazzQ3cSuD17i2zPVvjV6HbxeF8aSLDLTjYhZOWSXqGny1kgGdAvi4L5qXMYy8owgUYeD
3oLbZUKXm0uO5WpJNXYfEY/bSEleDjk3c1uMIEUqD0SjLCYjLZQePZpw8GwE7dsrSU8uJjQiHAnl
NTK7nVSX5JCdYSc7V0uJNZIWj3SgeawE6qMM48XtrL55mf/UfEQ8LhuG4kwyUs2kZxVQrFez6KFO
9OwQwMljJmwVhVzcvYfej4zmzlHn0Ge2YeTAcPJ3fst+bf0K9jit6IuyyEgxk56ppbRaxcP3dKB7
u0BOn7ITEBRFsygvBUfX8sOO+JqQgIvxVzMQZAQGR9Es0kP+0bUs3Znw2zR/KgLqqAY0axWHcGYf
+/OaMmZ0N7o3OlizwyvICQ5pQFyonazD61m+62LNxJN44WoOf5oyXIPbbqaiKIv0JAvpmaUYbGrm
jm5Lp1Ya4s9bMOuLMetBZg+ilcmKXaKnJC+XnCsrMaFWP/dgt1RSlJtDTr1mrMvZqFCpBJz2KkzW
SNq0aUKxtwHhoW5Ki80EhgQjwQaIuO0mKoqyyUxxklVYjVsexsTO0cRESKCiXm+PzVSBNu8mZa6T
j9VUgTY354a7rNdHxGWtoqwwk7RkG2lZldiZw/jOrWgdpyI12YYh7Tynz7Sh6a29uKVfGRnhfekW
pSdh3WESKv6Cm9QVDeg+dCS3xlm4uGsr+U3j6jk2q2jWcyCDeoSSs+17lq49jtZRk8ORy0kkDa4m
F1Q07jucKeN6oUzeyprtx8iziiBoiI6NIcqVx/E9W9l4OK9mcXO1W/h2+IdEQ0CAncpKGxGqBjRu
0hhp8wjwWjBaPGgCNEjQ33huFtS0HDCYgZ2UJK//nhVbzlDiBDjHmctJgrvSq2c7AosPsWHNOo7m
2BCFFPSinHuGdKVz+yTSrBp692xPQPFBNqxZz7FcG6KQikGUc8/g7nRqn0z6GQARe1UZhZmJnCk8
z7kLmZTcdzd33NKXjNxCDqT5Pmc6jOUU5WeQnO8kJcuCIvBu+raKo1GDeAryTVSUmqhAQKWpxGyz
IFaUos3NofDK0Hx5b8iJsbKEgpwcSm/GCCMJIjjQSFGxm4jwGKKjG9GgTThWUxVOlwS1WnWlJEe1
juKCLNJK0kgvFoiKnklcVAjBGqF+yjAOqsuLyc/NofwPGY4cVNXmU/EH8rFVlVCYm0FyWTLJWU5C
Xl5I2/YNiUrMRFfmoujwFg71eoLhg7qTUBpEs7H9CC86wpb4LEosvhfsseopsRqoijFgc0ZRVVpE
QZ6Wystj3uWKthkoLsglK1tPelo61rCGLOrXiebh8eSW2W6sfAuBdB8/mVuiClj/72/YnlCAyQNw
jP2X09TdYBOC6DDlIeYP0hC/4hN2XSys8XSQBNOiVWPU+Qf5ass+EgpqjAyJZ64+6lt/DyUsWEd6
ZgtatWpEUJKL1l1D0eaV0UUVgFLu4/JfCKL3lOkMCE5j5dtfsDutDKsXiD/H8ctFRd7G2MENKdn9
Psu2XKTI6IbELJxh7/Hg0EE0P1tMdUBf7hzckOJd77B0yyVKTB5IzMIV9gEPDruN5mdLqLbU5Gcu
yyUzNZPyc+c4da6AZ96+j2mjT5K8/AzFPruDiFgr8snLzqDckkJStkDjzx+gZ9codufosVoq0RZU
AgIBTYy4PAr02gJycyuxXfm8Lte0jQptPnlFVdzUvp0knMgQLYlJsXTt1gRlhoZevUNITy6kc0gY
MsnlckSs5QXk5xRjcmaQpguj66fTaNZYgSyH+inD2NAV5pFbYfXJQ/J38ynII8dg/wN6m4ilLJfs
LB1OTxqXshW0XvEgg3qFsqNIh1d0krnmK3bc8Q5zZ3bm5DI5dy/sj2XHC6zJsOH1sc4lMSO4a0QY
8Z8t4uudOtwiJKfkIsQtZ9FdI/nx9BqKrvMSf9kBWoIkmJ4PfsDrMxqTvfptnn/xQzbr2jDnzfd5
oFvAn1iSF7clkR8ev4f73thBkSWfjS/NY/bs2cy95wHe2q3z3eopenFVprB7yXs89/iDPPSPt1mV
FcWoRc8zs60cEJCpIulz/1u8ODGWnDXv8vxTz/HGV6dwt+lBpyY17hYyVQg95j3Pgq7V7P7oOR5+
8BGeee1TVu1NpPgXXmgS5KomdO7RnLDQpvToFPsb96x6I4p47TbsSGotf/9BBClSZRAqTxXpF1II
7juAljHtaCc/z4l0J/LAYNS/EEhAkKoIj2vPgMEd0ZSe5Wz2X7Co/bvwevE47DiQIJPVtoXXjC7/
HLuP6mg57SEemHE7TcsPsW5n9h+LX/d68DgcOAUJMrkURA92WzU6k5TIdr3pGaP47TOiB7u1Gp1J
RlS73vSIvkaaPxNBQ0RUM5o2lJBx4QxFJXmUmhrRqXOjmu9edGO1VFFhUxHTtgfdGvzF8vwK0ePB
7XTgEqTIZP9hpxmJAqVKiaNCS7GuivCuA2gfFUKANY2UEhGlWvOrMAcBqTKEuA7d6N4hBHthGunF
f8HW6N+E6HbjcrlwS6RIpbWjoruMlPNnSCgLpt/ch5g3uDH25OMcPlfyByf7ayCoadp3GIM7B1J0
bCu7EirqX4ayEc1bNCfUmknSpSSKHL8zowtKYnqOYea024kp3Mfa9XtIrKhd+ogOqvQGTMpYWrdp
Q4vQm/w2pWrUKimGvGwMooSoDgPoEuHBVplLQZUUlVLlk3VcUMbRumVTNPpkLqakUfob3zMBRWxj
GkVCdb6W4pLa3WbRQl52PsXuABrGRNMorjGNIrxU52kpKb2cxkxudj4l7gAaRUcRIfvtDOatSuFi
cg6m4GY0bRRD4M1Oci4nTrcHUSpFIpH8Z+dKeQAalUBpaiqWwGCi2w6ge0QVZcVaymwKlHLFr9YC
AvLAWDrf0pe2IQbyckrQGf//6e84HTg8HgSp7GpbOLLZt+0E5TH9mfLAw0xpXsnp/WfJKDL+iZsp
18OD2+3FK0oQBN++DEHTgZ6do7BeOkyCVlerCF8vcQCt73yYR8c1oXDjt/x8NBPdZQ3Ma6G0WI+r
YTf6tGhAqPIml+mKIILVbrLPXEBs3pxGzQfQJyyH5KxyLEIAKqnMJwVA0HSiT5cIDGf3caHEUKMI
/zIF6tbtaaEqJe2iDrO1dtzyVpEQn40lqiVtQjWEtW1PC1UJqRfLsdg8V9LEX8jCGt2KNqFqVNeo
a0/pEQ7EVxHSqTtNAzTIb642EO127F4RqVzGf7i3gzKUELWT1CNnkHfpTJO4AfQPucjJ5Go8yiA0
0l9LJEEZ1oJbxgyiifkCp9NsOP+Qwfq/C9FuxSoKyBVyrjS5NYEV3x9FNfJeFj35MKOkB/l2RSJm
j6/WB4GATt1oK6Rz6rSeK495Kzh5LB2xbQ86B1z/i/+LVnwSpFFDmDE6hszlC3l/XT4eBM4nFCD/
/CumzRjMz4nba111/jiiaEdfVIgj0oTL48RYmk/+DYMGr4UXt72A84cLan4KWeQWqenY52E6tI9E
kl6JKnoQk4aEkvHjIt5fk4sbOQFRkQx7cGBtZQoIEhkhIRrchjwS4xNJrb7epOXGVh3Pj+/+G11b
O+e2ZdTT8vNLBImcwJh23DZ9OK3NyXyXYKif+5OgJrzpZD44MLnmt2hHX7CTdxd+xAlfQskkEmRB
wQQ5jVRlJZI55i5GDKpEcWEX6c6RjAkMJBDwIKCJasGkt3cxEQFBcGEqPMeaDzZyySLWuGz7LHMg
MW1n8OG+6Vdkrsg+yNfPvMfeynq8vRBEw/az+GjfzNp8bOgy9vP18x+yvz751GRWo+S36MKtd/Yn
1pDEjpSrLmTu6lJyTu7l3NCXGB6Xxq4vt5LyB1ySBZmayJZdGTiqN1H6RLamViMiYipO5+CqH4m6
dx5Pf96XtMM72LbrIGcz9bWuPl6MRakcXP0TUQvn8sznfUk9vINtuw9x7koaX1HRsMtwnvtpDM/V
+VfRUULSgVo5NeFExjWjEVmczDRhCCojv9zGyI4did1TiNbjpTo/iX1r1hG+YBbPfTaA5EPb2b7n
CBeyDVflEdQ07jmMF3+ewIt1y7IXkbDn5upQIg8kumNPBg7pQKDuBMlZ13enuXYG0XQZvohvhy+q
+e3VcXHfar58dw3JPlSkoFCg1KhRVRWRWVpB1LCh9JelUpaeQlFAezpr1GgEAAkNuo5i0ZcjeUwQ
ELxm8k9vZ+XOo+TY69l3JA3pOe4pvrvzH7UyV5K8dy2LP1/FeWM93l7SkD4Tn6HfhKev5HNx1yqW
fLWW+Prkczk7ZQhNevZnQJ/GCIW7ySqwXGkLu/Yi8Rc60LXXDFoZtrHj1GkKfk/JvCkE1M36MqhP
C6R5h9lzLAdnl+71zyUgiOBgNe5qPZWVpt/5ngTUrQYxtquT0vNbWblhG2eK6g64bkrO72FjUAB3
TV/Aa32HcXbfNnYcPE9mqdnnOUNQqdEoFcjKMsj2BBLWfRBxxSc5m5+LrFEEKqUSpQA3qk4hMISQ
ICUOfSUGg/ma76UJCECt9GKxWrE6L6cQsZlN2GwSwgLUhEcGolZ6MVt+lcZkwmqXEBOgQa0yXSN3
NwZDFRYaERwQgEYAU70+AQGZOorWQ4bQt7US/cECinW+uYdfQdqOCc98wqRnLouUweaPv+TH7ecp
8WHpIag1BCpkCEVJpDVpTpN+vWhZvp+dOhlN2qrQKOW1xi8pbSc8yycTn6tRylw6zq39hmOJ2VS6
qN+SXtqBqS9/wbSXa3978tn1ySes2H0BbX22u6QdmfHqV8y8/NuTz46PPmLlvkSK6r1tJiDTxNBx
9HD6xDrIOqylwnA5BlPEfGk3+5N7cu+YJpj2/MjZrEKq/2KlQJAFEttxOHfe0gxZ8WoKq6pv2CcA
hLAoItVQUazDavs907aE4L5zeDgYMla/zfJ9lyg2130pFxlbvmZZ0P3Me/Qd+o87y/4dW9h9MpNy
i8vnNZ0kMIggmYAx5wzxHW+n19BImmjXs70yFGubAAJlUqRwQ8OCEB5NA5WH0sJS7I5rmQQFgsJC
kYsm9Ka6btxezJWVOLxNCA2REx4Vdu00+stpZEjLriWBi9LiCjz9w4lQyJAK4Kpnf5cHNaHXtHH0
VGnZlVCKxVFP/UDen3/8vJWnroh0ho/vfp0dhb7tFEuCQgiReHGlH+XMsBncPlZJg5QVpBsb4AoK
IkgiIKkJqqbPEz+x7QkBQSKAPZ+d73/IKZ0Vl0j9Nstkt/Dc+p1X12OuZL5/4BlW59Qj9hpANpAX
Nu3mhTr5fLPwH6zJt9Urlr4GAUVwM/rfPZWe3lSWnSnH47069lcd/YE1U5bw4GAJCZ88y+nq3wQS
/W7eYVGRSF1FlFfXbV8v1eU6nEJzIsMFMF7nNev7Kj7KhKxFO1rLytiZUHTVz9ytJSGxnNm3taG5
bDv6P92c/wcRpKiiezJp/l2M6N6cSA3YTU7kKoFchRykUhTNW9NMomNXYuF1FiEibnsVp1atYMBL
9/LRj4NIOLqf/Xv3ciih6DdWNa/LSsm5jSw/d9NCowiKYdhLGxnyohSZ4KY65zDL3/mU3SX1VOJE
B9XF+1n2ykouuQG8eFwmynzViiRSpAGBqLFjrMqnMjOQJ/tZWPNONo62IlK1BrUAZkTshkL2/fgG
P14UCYhqTtdBYxj19KuoPn6V7xLrI7OVityddWKGvbidZirrG0AoWtBlb68TM+zF7ahvPgKBsR2Y
9MZmJiBB4rVSlrSXZZ8t5ojuaj6CMojQJh3pGOXGawmmVfeuhB8/Uk+XM4Hgxl2Z9tYWpiBB4jFT
nLibZV8s42h57fDhsaJL3ctXz59mU7v+DB8zivvfnMCkIyv4cslesq0ieKyUpezhy+dPsan9AIaP
GckDb05Ad3glXy7ZW8cd+EY4KM84wualyzhaWnOolSa2HQNGj6VTrbya8EjimsVC7kkyrCIuj56y
gjJcd3SkY8wetEVe8Jgpvridz547zsYOtzBizAgefnMC2gMr+GbFQfIBRAe6lINsXLGS42W1ZTXq
xK2jh9O6PlWIQFjbgcz/YCt3I0XiNpBzaivLl6zlTGU9R3lvJRknTrBuyeWYYTc2s4FKX8c4uQK5
Wo3CU4RWW4nSHkSPWDdHTxah6N0RuUJVq+d60acf5cT6FRwokBMe15WBdwxiygP3ovjuO7aX1Edm
HSkH68YMu7GbqtGb6/vuOpL27a0TM+zGbqqqZz4SonuM4/GeY3lckCLYy0g6uI7lq3dxqepqPkJg
Q2hh2X0AACAASURBVBrHxdEo0IsmqhHNW7YgKPkSN6FzXx9lY3r060lTRQknj51B64AGN37qmoii
iOiDbG69lsJKEVXLAdw2KId83SEy60zoorOClD3f869TO2nbazCjxt7NyyPu5OTaFazZm1gbfHKj
91KhVMqRVpeTkQODewcjLzORn+siPC4GuVzu866LKIrU/LmMhKjeU5k3ri2mE5vZV/F7atrVEIMb
lPI7/3czOztSmg19kLeGPggSCVjyObFhKWv3nCPPUs8PyJPLgR8Ws/tKzLCD6vIKn+PWBZUGlVyK
4CrhUmpDpswIwZ5TSXGxAm+nxihl8tqFr4e8A0v4btdJssxBxHa4jTtH38VCqZSlaw+QUi+Zs9nz
dZ2YYdGJqbKCqvoakzxZ7PqiTsyw6MRYUd98pLSe8CKfTXgRiVSCaMxk34pvWXc8ndI62oUksh0d
mwajFL2Et+9Ek4hL5OjKbs5V9UYSdbqLd5bMRhAERFc1eac2svinw6SXWHxTQEWxtl/cMCEObQpp
IS1pdvsUhqaXsu5UDoY69SfaCjj0/cuc3tKW3reNYNy8Nxg76TjLPl/BwXQdvuxNCJpANFIB0VHA
mXiBJ2aEkrVYi97eEZQqVFIJEoHf72a18npr+3rd/t50/D95YVgVaz5YSbbEh/74uzvsN/RBv3H+
v0FO5wVfsnq+BIlUgld/kQ2ff8SGlEos9TWouBJZ/twKTuhM1NjtLJSXmnwykgAIgUEESEU89hyO
nZXzxvQwjr2Zg0njAJUGtURA8AC4uLTiWb4/WolLGUmLPuOZ89jbPCV/ng/35mO9UUF1cV9gyeN1
YoZFO5VFVnwM9a2Tz3m+f6pOzLBoo7LIjs8btgDI6bnoJ3Y+JkUmk+ApP8fKf73NhnznL/KRNupL
/2YezCYJbW+9hZhtGyh0+tKnavkD39jfdIDWf+MBVhLkmuZMfOGfzAk7x/LPl3C+yIEqph9z/jHp
yoaLIJEiEd24f+dLED1OqlI38K+FR2nb/3aGDrmdBW9OZ3bCct58axXJ9TNj3wARl6WC4z++zJJE
Ne3HPcS8VlUUFNbzUAygRvmtojg7i6ybMFQIEglSjQYNbmyGEs599wyPh3gorxCJaeVFolajkoAZ
8LpdGEtzyc6yQ1YGObkFiE/+k2HDerHu0llEapQcaR1TmCAISKWSGvfjOjL/98QMg7U8m72r3mdd
fjQ9x85kWFAVRcXmOm0hJzS2DYNH98R17AfeOxfNtJkTmNwrke/O+Hj4CgAi5rJ0dq76mE1FDekz
ZiqDVFWUlP56p0bE46hGm7iLH1LPcnTAFB6YO4mZBRm8vSXviqHK46imMGEnS1LOcPSWqdw/ZyIz
CtJ5d2u+jy5pIi67CV1+FlmXT5N2BtHadHnWUREWHken/n0ZENOHTbNqDvASBAF7cQJFbaPYU1R2
ZUfAYzOQf34b3yWd4fjg6SycMp6phVl8fBzAi9Nmoiw/i6zLp0l7wmhvctdTGRapzj3P+nXfs7+6
FYNGj6S9tYoynfUmRig3dnM5hdlZZN3EzoUgk6FQKlDgpir7NBs/Sme/1IZBaM7gPgIypeKKm7Tb
bqayOIesdCekp1FcZWbm9Dvo1qsth7cZEUURQRCQ1PEIqvktIIpinW/svytmuCLlAAc3rOEcPRk5
sg8hxioqKuvs2AlqmnXvQ7+OapLW/UCBvD39+g7i1rQcdqRb/rRZRRHbglZtuzJkcBNuHzqzxiIu
kSCVSKBfMxo0WM7SZbtIu4E3h2gxYzbbkTUKJSwsAEF7PW8DEVdlKnu27iG/4UjmjJvFPEFg2ZoD
ZP7CFVbEadRy6cBKks+cZuhddzNhyFAGlhazKbfmgBFBIvxiPSCRCEiEmnZHoUSpkCETXegubGNx
1mFkDiPG8AF0k0pRKOQ1p6bfoCJFczUmixNlbDihoQEIJTW73oJMjlKtwimXYDebsTmkhGs0aBQC
NQGXAurAQNRqEZvFhr7SjM0pJTTgV2mCgtCovNgsNmzXXPXLCAsLIQAXWovVx4OUADwUnVzFym2H
KGwwkunDGlNeWUW1yXET344DY3kReVlZNxUzLCiVqOQSXF4XJcd/5pOUzXiNBsyNxyDK5CjkUi57
iDuM5RQX5pBR4iYjNQWD7Cnu69OFVk2TyCrwIlLTt3/R7rVul95fKGf/TTHDHvL3f82WnfEYW0/l
7jsCKSmrwmytcyCREEKPsaPpqkhl5ccHaDf6NoYO6kh+uYH0cl9O8K2nRJnb+HjTXi7mlGLQ6zFa
XfVa8ItVlRgcAo2iI1GrFGC83u6wiEN7hG8++Yk2Ux9g1oOPgvdT1p3OxeCsW6AXmy6VI2tTOX7g
FAtfepQpE9LJXnKADLFOu9d5QiKVIogiHmq8DzRSEdHrIn/Xp7xyToG5tBxbZzcog1DLJD65SYv6
ciodUto1ikKlzAVrzQJJIlei1iiRSwRMBgMuoTnhQQpkUmqDWyUERoSjlJipqnahlxpwCU1/myY8
HKXERFW1G8815w85MQ0jkBm16J3uerSJm4x1r7F4fxGagQ+xaLCRgsIqHPXWBgGslOfnknOTMcOC
JoAAiReP10X2hjd48pgMfaEeZx83glqNWnpZGa45QTs/txiTM5P0S0k4Ypbw+PBbiDlWTK7oQURS
sy7+RX+XglizLr4q3n9TzLCb5BXP8clBEzFjnueF2wzk5lXhqWsplkQy7P65tM1fyROfCTz20Wwe
GHqMV3aV+qjAixjKK/DII4kKkYL98qJGQkhUFAqxkorfcUf+a2KGRXDnpJHpjqZLt9p4QAQkssZ0
6xqFMzuTXPfVxKLoxu0WQa1B9Re78ouiG5cHUP26LAlSZXPaNIXM7T+w+nAiGVlZZKRko7s8QHm9
uIq1lEljaNc24gaVJ+Kx6Ug5sIrPXn2Me59eRXn7acy7I+YXz0nkGmJ7TWDuXaPoEHJzzSF63Vgr
tGSnX+Tgiu85zCDm39WDgP9wWASCgEStQYkbl8uNo6qE3HwdFlHE6wVBeb32FQBJzWTu9eJ1e3BX
G7HIg2nY8PIVDjLkyghiGyhwV1fX0y3uP4WI1+3AVF5IRuJp9q3bRHLgrcyc0KnWxRWkQdE07TOS
/uEF7Fu9kfOXDrAvJ5h+k8bRUVO/BvO67DVlxZ9k38btZIYMYuqdHbheNqLTSFVxOnkGBeFREde0
hIlOI1UlGeQbFIRHXjvNTaEKI7xxHKH6vXz+xHzmz6/5+/CLH7A5W0pcu7aEX0Nu0VGFvjiTQqOS
sMjwP91653XaqNYVkHrqEHt2HKM89lbuHNbmV7Ht/wFkcmRKJTLRg9thw1hegra0CptXxCtIkSpU
v70aDajpOwICIqJXRLQ7sFucEBhKZGTtVSKCiqDgMCICwWExY/uPvpiviHjsZvRl+SQd3sHOg6mI
rW/ljgFNUda+tzymEz36dCWyKonjOzew/8x5cuVt6XdbP5oq/7wGcxWdZdPnz3HPvLu5Z/585s9f
wDMf/syhCwkc/Hkx360+4pvHhLMEbaEWW0gbOnXuQMy1G/AKor2Ec1t+5MdtmYQPmsikUb2JvY7b
u9dShFZbjEkMJDg4EInNhsXqRRkaSmioprbdAwgNCyVY7sJms+GQK1DIZUi8Xjx2ExUlxZTqzTg8
Il6pHLlcwTVCdH8rp0NLbl4RzsgOdGzXmqhrbCc7S4oorhAJadqIhrGqK/I0a9mMhjIrJWVlFOcX
UlQhENK0EbExl9ME0rxlU2LlForLyqm8hh+eENyOTu2bE2TMI7+opF5zgctiQFecy4Xtq9l6wUJc
v4H0ah9903GIN4ugVKGUSxC8Ih5bFaXaYnRGG06PF1GuQCGTX2esqzFuCIh4vSKi2YzJIRAUGUZg
YO3VL0IwkVEhaEQ7FocT53/lXAlOUyWlRbmc3bCMzakqeg0bQIemYVfCzVRthzGqTxjFJ4+QeHoD
aw/loek5lP5t47jZsPnfxVFNmbaQ/MIyDJb6KcIAoi2DpMwqQrsOpEvjKAJv4NMqmtPZ/MnHrEkJ
ZPi9c7m9Q+x1n/Ho00jLN6IIjkSjkCMYq6l2KYiMDUOlrK0MSSixsUHI7SZMLjcelQaVFLweEa+l
goK8YvR2V00stEKNUiL1TRm2pZCQZiSy9xC6RIei/s1DIrbMNHLt0bTrHEWg5qo83bq3IqAih8wq
K4b0VHLtMbTvHEWAWnolTfcerdHocsissmG/hhuNJOoWBncLpTo5nnyLrR6KnYijupSiwmxOLP+M
9cWtmTx9AI1CVH/dYUnXQVAHoJZ48bhBtOjIzSmm2uXB7fEgqjSoBeE6e9817tKCV8QrglhlQO/R
0LBJOPLL1m5JBE2aBCIxGjB667GL+h9FxK4vJr8gm6PfvcdqQ38eWDCAMNnllhAI7DWXeX3M7Fy8
mayM9Xyzw0Sv+fPpH+Lr2UcilqQEMsQ29OsTjvTyQ5JI+g9sh5ART9LvHLz3F+0Me/GUH2DVjim8
PecVnnEt56BWSssR85gZp2XrF4d+ES8ses3/r737Do+qSh84/r1TMjPpFQKEFoqi0okIRHoVEQQs
CEgRsCtWLKuui7ruT3F1VezUxQbSFASEAKGXAKGFFpKQhPQ+M5nJzNz7+yNISwIJRsXl/TzPPITJ
nXPOvXcyc997znkPKacK8RpwB2MHFLLb5ksd9RgrtlS3V6q6NDSPlVPpxVh6DWFM/xL22L0JcR/j
521pqGWnOJmup3PfexmWspJDeW7MYc0I+/UiRi2jNG0Dqw4M47EJr/KY7jt25llo3L4/1xkgEShP
shVA+6HjaV26h/iT2dg0Pxp2aE6Q3snR4vN7nQyYA9ozetpT3B5QRFdTEo/NOnLl84Y1F7a8gyxb
GEfUlLEMX3uA+cdqMvNTQW/wp16TSCLPm9PhLisiJ73gsnfgFZ0ek8WEzuO+8LxpgOYBownzr5+T
BgP+dRrRsJEH/7rN6NB3BEMji9mxMp4idynu7Hji04Yy/N5Huad0GQftwdzQ+y761C1ky7f7sWm/
Y/a32qCWkpu6jzXrOvHEoBEM3HyExcl6guu1onevSKy7Z7IuyYlNn078up30eDiaIT3Xc3hlWs3f
86qd7OS9rNvYngd7D6Pf1mMsS4HA+i25pV9XfNP2c+J0CR7fRrTtcRs3h5WwOzGVMsVIUMR1dO7d
Bd/0/Rw/XYLq15i2PW6jU1gJu09eel226lPwCgymbmQDvLN2EX8gmZQzb3K91USd1t3o0Ow6Wvrv
4FhQK27u3hFL+gESM2xoAU3p0GsQ7YKK2ZqUjgvfWmlRBWoJpxLi2LyvFSOjB3Jr3EnWpNbkfqoe
s08IDZpGcnY6kuai1FpIXm7JZS9I9QYDXl4GFNVz4eiAMxcHOqMRrzPXDwaTD8HhjWhsNxAa2YGe
g/rT2nyMnxISsZY5OX3qGFn6kfS6czRF+q1kWFrSbVA/IrUElieUZ8Wv5aTctctTwNE9O9lz3V3c
2rU7nQ6lsSXLh+Zt2tOhsUbS6p3sy3RiLzzAvgPtGNkhii5t4jm1qzrru/7KiE9AGBFNIzn7Is2J
tbCQgkIbRbl2is5m5tbhqFOA1W5HLcgjv8BWvQBDs3Eibhtbr7ueUXc+yDMRLdmw6yT5mj8RIZBx
PJ4dBy98j2nO0+xavZyQ0PGM7D2QfhmZfL85h/COXWnXPARn6nFS812Y67Wld58owsp2sjErH7fD
TeLJFEo7dmXgHXbcPgcoDu3AgP6dCMxbR1JKBh5jS4wGHZqqXvQe86Dp9BiMeow6Lj+JULNxdNtm
dl7fguF3TyYgfA0b9qShb9GQUH8jJYBWfITde47S7p7eDL9Lh2VDArb6tzB4cHu8ji7lQEIyJcW6
8m3u6lO+zcYjlDbowuDB7TAmLObgkRRsWktAwRxYl4hmN9G+cSOi+g6ie6Sdrd/sYF9izVdfAMCd
ya51m2nTfDCdo9pwMiWGwwU1+eT1wj+kHo0iI/H+dTkxrZTi3AKKShyX+Q5Xym98KaCqFy0Zoqmo
OgNGox79mS84k38Ideo1oqmvLw3b9mXYoJswHPyatMxcnPZiDh3JIPq2wdxxm4Z5RzKext0Z3r0Z
7vitpGdVc2nAP5MrjdgfNxI1tS+9OhwiNSuOFFsdug6IpnHpIb7Zn0KG1YFr4zr2dJ1C5+43sTf5
NIVp1RvBo/cOpk6IP4HhQVi8fAgMb0CjJna0rByKrM7aOz5qATuW/UTn6x5g1NNP0WRdLLuPZuPy
jaBlUDYb1+8hOe+i19iPsvTz/9Lg5QcZeV8fTn20nL1p0HrIHVxvyCUtOZVcu4Hg63tzZ+e62Lal
UGRz4LEdZPfBfG65dQx355mJOZiH+cbB3H1zCNkrD5BdZEMfYcKAetHoAMr/3g1GTEalesOk1UK2
LVpG9xsm8cC0J2iwfB17UuzUiwzB21g+AVPN3cKK2EE8P/BBxpUtYu3hIgI6Duf+aF+Ozo3lZEEJ
ZaVb+Cl2ENNue4jxZQtZm1BMYKcRjIv2JmH2RpIKrbjPXB/61m1Ks5Zmmoa2pt+I4XTW7eCjFYfI
LbnCK5Kyk/w4fy3dXxnGsDb7+GJbOsU1uktkITSiMU28gs9eE2mqldz0XKyXXfZHweRtQe9x4+Gi
c6G6UQ0mzEYF5cxAAu+Q+tSPMOI2hdEi+i4mdDVxYs4ucpwuPK44Nu+x8vTQxxiT9zWxSU5Cb76H
+9rqOPx5HPll1Vsq60/lPMrCT1fR962JjPo5jk/irXh0TRg6oT++e2ey8FApqqZy8Ltv2D1wKuOH
L2bn7KM4qpFSWs1Yzde/jGT65Fd5yDWH9ak6mvSZwIPtS/jl1VVVZpKG33GYtKaWEPfJs7xqfYxJ
o16kn79KXuJ2FvxtJl/vs120rZOD3/2HHyIf5/bn3mSYPZNDy/9NzNYUajp97XI8LhsHvv+EZU0e
ZvDzbzDMms7+Ze+zfvspbPZElvzfO/hMuY97X3qXEB8D7tISCjKOsznDTvmQ5FRWvfN3zA89yMgH
X2Oo3k7Wr59w2plvRcWCya8OXYY/z6g6vhhVOwVpR9mx4F2+ij3/y1vF7UjlwJ5kurUvZu/BjN8c
/GtldnL3/MjatH8waFRvVk9fRXZ1rxAVMwEN+vHMrH7nnlPt5CYu540HPybuMrGBotNhMpvA7b5o
Yn15rxU6MxaThsdZjJ1Qej71JX3w4CjJJS1hF0s/+J4lm8ovaEuyE1j+4Qd4TRzN8BffZZLRQd7J
Paz98r98vbUQlas8GAZUay5pe9azO3oKfYZ2Y/OcRCKietPOlMTS1bspUgG1kOykrWw63oWhvfvT
ZuNs9tZ0/hrgKckmZW8s8V3G0ev2W9g8cwduzHiHtKD/gCFMDvNB7yom49gu1s5dxNKN2WiY0DQz
3qEt6D/wvG2O7mTtnEUsjc2upQ9WAwGBoTRvEITt+KkLPpBUWwmF6fk4o5rSsrkPx3JN+IW3ov9t
Q2kY6oO+rJD0hO2snruYH7fkoPr9TsEw4C48xfG9u0luPZBb+7Rn19ydZ9bRrAZdKC27jeG1bmPO
KzCDvau/5qN3l3LskldcCnp9+QWw6vFc2COhaaiqDr3BC5PBhcNuxdCgL/e92p3RqhNb3mmO79nA
gp9WsuFAEZoGafvW8/1cHSPvHcqk14fjoxZyKn4DS/67lDWHrGh/dCbNK+DKPsL+fQm0GdqGzl32
cXSXN63b3YBfzl5W7j6GTQNKU0g4EE9i2wG07tiRnQfWkFjdMWz6enS4/SGibn/o3HNlSWz4Zg5f
zo7hivIvVsKTd4BVCz4mL2MIw267g4f7BeHlyiclPoalSfsr7Yn1FCYQG7OeRo1GcnPXrhw7sZrT
qpm6rXoQfdc4wgO8UK3ZnIj7hW+WrGJLQvl5P75hCd9oZQy/czBPvjUWL0cuibtW8c0PP7PtZCmG
G40YdAqqql64VIWqoWmG8jnDBqhO14sndy/LZ9vJPT2MYQPG8cIIX3SOQjISNrA+PQ+H5iB340Lm
uEq4c8RgHv77aLzsacSv+5ZZyzey/3T5JWXS+u+YXVbM8OG38ejrYzBYU9m/7hu+Wh7LgYwyMNkp
zMlB37k/D7w0BM2WQ9L+TXz7/s9sOpBCtVdZqYTz1E627uvE+K430/bwCZK3JlHtPIb6SHo/EEXf
B849pTkPsmjGp3y7Ov6y37leXl4YFKVCMKypKppmxGQ0YFBKKCm2EzZgAi/1nYRWZqcwM4n9sbOY
s2ILCekONBzEL5vLPPcIhg8ey0sj/FCsGRze9C2zftjMoUznX+Lv3ZG4kZj4LkzoGk2rw2kU05Oe
N3iTFrODE2m55TefivayfutJOg6LplPTQ5zKPE7+ZSNZhaCbx/LClIG0b1g+Uqb1k20Z7Elh+dtv
MX9DApm/aRmHC7lS1/Lx24UkjxjOwEFT6D/WhKc4nYTNi4nTQ2VTa92ZsSxY2JbmDw1gSNR+0gsy
8KjeNO8xipET6xFk1ijNSyF+w+d8sWgnKXlOwMn2uR/g7biP4UOf5M1JZtwFKez7ZSZzlh8kvciD
v8mMTvOcl6ConObxoGpmLCZ9+VSaalwfuk79zHv/KOLOe0YyYOw07g404irK5GTccTKsDjyqjX3z
3+Y961juu/0x/jHBQllWArFz/sn8NcfJtauAlX3z/sl71vu57/YneGOiGWfWYWJnvcW8NYnl2/gU
k5WWTbs+T/HGECjNS+Xw9gW8/t1qDmTWMPHTRUoP/cjy/b2YfGdf1h5eyMEcW/Wvt43tGPfOzYw/
7ynNtpF/PfAOa09fLsGagtliRlEduC9qv+ZRUbHgbdGhFJeQn++gy5h3+WIcuBzF5KYksP2zv7Hg
50RKnCqQR8yH/8Bn4gTunPQ6wwN0OHJOsPO/0/l8ZSq2sr/ClTHY9n3H9/v78eD421j+/GIKbh7F
8OZ5rHl+HTlnbi5ouev4btVoZgwZRbcl04nJr0agrxWz7f1nmF70COOmvMHwQIWilD38NP0tvtp8
6RuniqadG5cQFRVVG/t5bdGZ8G9+N2/OuIO0t+/nX1uuzkGIQgghhBBCCCFg165dwJ+WQOuvS2/0
5boeA2nsTOF0oRNTWAu6DLuDpkU7+OZAdXL8CSGEEEIIIYT4s13FwbCCwXITD37xIfc2rjyrgOa2
c3z+40yZdewPWIQdQIfOK5QmNw9kQrdGhPoYcRdnkbjvF95/fwHbanV9j6uJEf96tzDlvekMjaj8
XLiLTxM370WmfXfyDzoXl6GYCGlyK1PefoXb6lc2bESjLD+Z7XNf5ZXFyVWPFFLMhDXrweS3XmJQ
vSrKyU1ky7y/8/clKVeQwfv8uiyEX9ebydOfp3945XU5s4+yce503lx+6rfVVa32+BDRpj+TXplK
n7qVt8dx+gBr577NOytTf//2/BUp/rToNowHnn6AbmGVH0Pbya0sn/MBn67PuDqOoRLIDX3uYuJj
Y+gcUnmbrcfWs3D2TOZszrrE304gN/a7lwceHUVUcOXllBxZx3ezP2X+1kuUU602B9N28H1MnHwX
Haqoq/jwKhbM/pJvt2f/xrpCaD/0fiZOHEa7oMrrKjrwE/Nmz2JRjeYx/8l0YXS+ZxITRg/ixoDK
htaqFO5ZxGezFrAiPv/qn5v2Z9CF03PSE4y/M5pmvpUfw7yts/n3V0uIPXaF851rm64+/R57hnG3
RdG40qybKrmxn/KvL39iR9Il1svWNWDAk88xbmAHGlaaxVElZ8PHvPXlSuJSKl+fuvptjuC2Z15g
XL821K8026FKdswHTP9yNfGpvzHTvK4ht7/wN8b1akV4pRlAVbJ+mcFrX6zlcMaVrETwJ9E1Zvjr
0xnXtQnBlSb3U8lc+QbTvthEUm4N1+G+VugjGT3jXca2DcOn0mjKQ/riF3ns813k1ng9p9+Jvjnj
P/6Asa388ap0RLWHtO+fYvJn8VgvNS5d34KJn37ImJY+5bkmKikn9dsnmfTZAewXjw+vcZtbMvnL
mYxpZqp0qgF4OLXgEcZ/driGa1Cfc1UPk1YUMyGNIgisKtWjplFWkMap/Fqc9CEqoaA3eBMcUY+A
Km6faB43pQWnOV1YOymXfjsFg5cPwfXD8a+yzWXY8zPJKLpUmxUMXr6E1K+LX1XluMuwFWSQ+Vsm
sAGgw2DyJaRenUvU5cSan0lW8R+xSLcOo9mPkPAwfKtqj8tBSUEW2X9Ie/6KdJh8AgiuE4JPFZlC
1TIbxfk55Fqvki9L9Jj9AgkODcK7qjY7rRTm55J/yS/42iqnem22+AcRHBKIpaq6HCUU5OdRYK+F
ugKCCQ4OuERdxeTn51P4m+v6IxnwDgohOMgPcxXTzjylheTlF1BcelXc8rwKGfANCSM4wKeKC03w
2PLJyS/C6rxajqERv7Awgvy8L9HmXLLyirFfctKmEb+wOgT7Waq4OAaPNZfM/GJKf8vkzzN1+dep
S5CfuXw5sEq4rTlk5ZVQekVL6VxUV91wgn1NVWZbd5dkk5lvxfGb6/ojeRFQL5xgb69zmXcv4i7O
4nS+lbJKsroLAC+CGjQgyKyvIkgDd9FpUvNKK8zd/vOYCG7YgCCTrspsAq7CdFLzSrl0k00EN4wg
yFRVJmxwFaZxKs9BJUnCa8hESKMIgi6xIoOrIPXMfPqa+XWY9FUdDAshhBBCCCGEELXp12D46k87
JoQQQgghhBBC1DIJhoUQQgghhBBCXHMkGBZCCCGEEEIIcc2pEAzrmz/AnHWLebrDeVmrFC+inlnC
ulnjaKbXYe41nbWxm9i06eJHLOtXvEK0F6AzEj7yP8RctE3sxnUsnNoRIzoMgT15/usfWR2zkdiN
Maz58Ts+f/NRBrX0rdEy8YrBQqN73mfVTy9zq1d19tpIwI338s7iX1jxn3toVNNbAjoDfk26M/HV
mXzz42rWrlrK15+8zpT+zfFRDFiCu/D0f5cx8/7m6AEUIz71e/Dc7OV8O30IDY2AosMroAX9wSWA
2QAADuBJREFUH3uH2Yt/Zl3ML6xcPJf3Xx5H5zAdGLwJ7fQoXyz5iimtf81epODlF06fF75h0Yy7
aKxTMAc04a53lvPDjLtpogMMPoR1fJjPl33LK/0Cq3ccjX6E3/I4ny/8lIk3nqvLFBjBgBcX8O2/
htPI4E1oy/t4f8VSvnqmO+VJVBXMQY0YOG0u86b1xE8xEdSwD8/P+YZ374ks33edmeDmA3lx1iJm
vTSABl6+1G01hg9++oHPp0afLccSEsngabOZ/Wx3fJXyY+ZdpzVDnnqPeUtXsebnJcx592lGdqiD
ETAERBA1+T0WfDyR1ucld1J86nDdiFeZ/9Vz9A4JoEHb8fxn+fd8/HhXAs/U5V2nJUNf+JLPp0ZT
acJPIYQQQgghxP+8mi+tpKk4d37IpHGz0ekUfKOn8t5YjblPvc8WG2ieErJcUB6Faaj2bXz4+Kfs
PptUU8VVlIUbMOj8CA01cXz+03ywxY5vnZZE3z2RZ/6vHtqUV1mV/Ttk5tMZ8G02hBen30ek5qx5
unidF34t7uCVtx+kZVYMCz/6L8eLTdRpfD2Rvl64NLgwwageU0BzBk99nFvVDfzr3ytIdYHBEkjb
MS/zVB8b6+a9wQfHi9AHN6RZUx0l1urutx69MYQ6dYwYzVF0arCItHwLEZ2iaKjTYa8TjI7CWl3q
SGcJpEHXe7grJo4v9tovvbFiwLfOjdz+8ATa29Yz45NfSHd7UxcFnXcwDbvdzYgNe/lq38Xl6PAO
bUa/R15gQtOTLP3oFeKtIbTpP4J7nnsBv7dfYd5JFYfTiaIzXJThUUHR6VA0J05n+dnV+4bRuOtI
hm2MZ+7+y7RZCCGEEEIIcU24onWGNVs2yUnZoOgJvN6GpkJOchInS84LLc8EKBo2MpNPcrLC6jVn
umM1FWvWCU4cK0I7fozDyWZazBpPz07+rF5ZWLtrmyl6TCEdmfD83XgteZ2ZdZ9jaqMaFYDRUpde
48ZwQ/4yXnv2Y+KsZ1q4bf2ZbQxYzm6vw+jTgG4PvsDYxieY9/JMtuSrgA6DVwjXtQjGuv1LPlqy
BQcAB4mLPVtMNejQGfzxs6Rz+GgAnTo1YlWsL61bmzm8/zQhoaHoqM11f1WcjgJS0nXceu9gfjm4
kIxLtM0c1Jyekx7njpDDzP/HV+woUM+cdg/O0kJSM/RE3z2IdYd+IPO8VyoGX4KadKfPDQ42zXyP
eRsKUDGQmJqD/tnn6HF7NCv/s48yhwtNb7hweIOioOj1KG4XDhegeSi1F5CR60X0yAGsT1hCTq0d
DyGEEEIIIcRf1dU1Z1gDrdSOXVMwehlrNFT68hQM5nr0fPgJOh3/iLcXnaC0ppG2YsArsCPdWus4
sWoZe62XKkDB6FOfzhNf5vGbi1j29j9ZdMJx5ncaHncR6Rk2LDd0p3tD0xXukg6dyR8LRSTs2I/f
LV2JrNeam7x2synBgdHXn0rXo79iGm5rAUfX/MiB4EHc2yO0inOkwxwUya3jn2J8qyyWvfcey086
LiinrDiXI+tWkRA6kLu7n1+Ogs5sIbBFJHXtx4mPL6K8n9yNvSST+MOZmCNb0cKs4XGW4lT0GIxG
zEENaNIoFB9FQaeAx2E7e36dhdkkxKzleFh/RnYLucre9EIIIYQQQog/w+8cFyjovfvy5rpf5wxv
ZP2q1+llqbgd6DAHN6PH+Dtp4zzApl151OYgacVgoV7vh5jQZAcfztxC3pUUrtNhqFOPMMVGclLm
JdqnoJj8aDhoKs8P8mf3zH8wa2/Reb3cGi57Pttnv8u3qdfz+Kfz+PDFcfRvXYcahcU6HQb/APzd
NoqP7eZwSHcG9WmLOW4bR8pUFD8//Gp7TqzqpCR7LyvXZ3LDHUO4ocK5BJ1PGM0HP8rD0Xq2ffZ/
LNhfUrGHX3VQlLGXVRuzuWHIYFqdV45eb8Q/yA/NWUj+eUPGPR4XxfnFaIZAAn01PPZSHIoe39BG
9HjkXd5/6ykGNjag14HbZsOuAWiglpJ/ei/rtuXRavAgrqukzUIIIYQQQoj/TZqmUVZWhsPhoKzs
3JDl3zkY1lBLd/DRlAlMmDCBCRMeYNKjM9nlPLeFzuBNl+d+YG1MDKuXfM7zUdl8/eqbLE+vxVBY
MWAK6cr9YyLZO2vuuaHNV0LTUNEuP3zbXUZJ4j6OlATRedREekUYL/y95qY0O44Fr03m/ic+JNbW
ivumf8nnr9/FDdXN6qTo0Pn64Y0Da3Eyew75cGt3b+K2ncDpVtFZvGu5ZxhAw2MvInXTSnYZb2VY
dFiFN5FWZqco8QBJrnBuuWs00fWNlZbkthVwassa9njdyh3dQisMd66qfgBUDx67DQc+BAY35aYW
ThJPWujUuTEmRcFjs2LTzr3GXZJH8tb1HDR3Y3CXqnq0hRBCCCGEEP9rXC4X3t7eREZG4u3tffb5
CsGwpnnQ0KG/MAsUeoMeVLXG8081rYSMxBOcOFH+SEzM4vz8UKqnlL1fPcGkBx7i9aXJuCkkKbmo
dnuF9Qb8o/rRq0EDBr6+mLXr1rFm5WLeuKM+AW2m8Omi6QwMrkZ4pKp4crPJ13xo2LBiEHiOhuZx
kLvvO15/+i3WatE89caz9KlXMSjUPE4KEjez8KPXeOqFeWS0Gs1jI1piADRNBUWH/qKK9Pryc6Hq
FPQWb7xx4yjOYfes53ni2Tf54bgLj0dFb7FUOxjWUNGUC8+7goJerwNVu/B8aC6s+UeI2ZBOi4H9
aH5RBm/NVULazq95428fstPSiyf/9ijdwyuZBK2VUZx7hPWbMmjZvw+RZ8rxeNwUF5SgmAIJ9j23
83q9Ef9gfxR3IQUFHtxWK1ZzAMHNWxGRsYHFMUcxdexMMwO4S4ooOb/RqoPC7CNs2pFDy769iKw8
PhdCCCGEEEL8j1FVlfDwcAwGA+Hh4WefrxgM5+eRhx+NmpybW6nowmjc2ActP4/CWs1oBWgajvw0
kpOOEvvFDJbYu/PIpM61OrxX8zjJ3zCDCWPvZ/zEiUycOJHJDz3BB+tzsB5dyN+n/odN1dkxzUNZ
UTx7E3VcP3AwN/lcupGa5sJ2ehtfvjaDjUTz+N/G0aaqXl/VRWlmPAfTFcLq1cWoqngKCynW+RHR
MOjMudChN4bSoL6p/Hco6Lx9sCgeXC4PrqIMTiZlYdNAVTUw+1QvGPZ4cBcWYdX706DBr3XpMXiF
UD/chKeogOILDo+Gx15M2vb17LV0p08bc4WeVs3joCBxI1+9/Rlx3j15+NlR3FjheGl4bIWkbd9I
vE93erc2o6ChOuwUHj9Jtndz2rYJONMeA95+4bS9oR6Okwkct7nx2G14LCG0uKkFRds2cTQ5gROG
jnRuZsBeVIL7otrcJXmc2rmVw77R9LypYpuFEEIIIYQQ/5t0Ot0F/0JlwXDRdmJ2OWk9ZhoTerXj
+uvb0+eB5xjdysGumJ0XBUWXp+BDeJNIIiPPPZo0DsG7QiSi4bYnsPCLGPR9pzDq+pomlVJQFF/q
XlBXU5o0CsGChtuaTWpKCim/Pk6lkVPiwuMsIDMtB1u1uqJVXPY0Vs9dRlrEPbw+43nGDu7BLTd3
pfeQ0UwZ0Y6K8Z4LW9YOvpzxHacihvHU5FsIUHR4+UTQe9ITjLmtGx1uvJ5WbbrQ5+5JDGru5MTh
RJxqGY68OHYc86L9qKmM7t6OG9veQv+xD3F7oxL2bd2LFR0mbzM6t+vCHntNA82DZjRhrk4PqOqk
NHcPcSctdBz1OKO6t+Omdl3pP3oyAxsUsW9bPBVGlmtOrPmH+CUmHe8AcxXlOihI2cLcT1aQ13Qo
j9zfCf8Kx8dBcd4h1q0/V47mtlKQFEtMgg+3Tnia+3t3ol3nPgyb+BCD6mWwacVmclQPbpcdp7se
kY0L2LMniZLiUxw6ptHy+jqUFBRWHF2glVKYc5j1saex+FfRZiGEEEIIIcQ1oeLYVTWHVW+/gO8j
U7jzmXcZ46NhyzjClpkv8sma3BoOX1bQeXfh8a+6nF8BroJVvDzyX+yuULeH4j3f80PCJ9w/cSDL
py0js7oVKnqM/tE8+VX0uec0N46clbwy6h22V1ja6cpoHicF++fx0rQsxt4/nGGP9SfY5KYk4wjb
VhzBrECFlWw9DoqOLeOT7zvx9r0TuXfdfmYneqEzhnHLqGcZHR6AmVLyUg6yedYbzPspHRVwFCex
4t//xDJ5HEOmvcsEk4vCU/vZ8PnHzNmYj2YKxmw2obnduC8KVlWPBjoLFrPCmUxSl+DBnn+CHz94
B9OksQyd9i4TTWUUJO9j/RcfMn9TASreFV7lthWRsmEluwbcT8OqjperhKzDPzJ7RRteHDCa4Zvf
4OeLumzd1kJSYn8mru99lA9aULHnnmDNzH+ijZ3IyKlvMtpUSuahzSyaMZ/F+2xoGHC7CsjLLsWe
H8ee0yplxmKS4/ZwOqoV+XnlyzFdzFWcR/KmNezpOYLgyxwVIYQQQgghxP8uRdO0s5FSVFTUn9kW
IYQQQgghhBCiVjkcDlq2bHn2/z/88ANwta0zLIQQQgghhBBC/AEqSfF7tVAwWG7iwS8+5N7G+kq3
0Nx2js9/nCmzjtU4y/WF9Jj82zDlk39zd6PK61KdxRyZP5VH5h7/jXX9kYz41oliygdvcWdE5fvl
tmaxb940nv0m8S+0X0IIIYQQQgjx21QYJr1p06ZLvkBVVXr06PG7NwxAUcyENIogsKokUJpGWUEa
p/KdVWxQg7p0FkIaNrhEXSrOgjRS82tp8vEfQkFn8CYkoh4BVdz20FQ3jvzTpBf+lfZLCCGEEEII
IaqnqmHSV3HPMGiag9yUE+T+EXWppX9YXX8cDdVtIyf5BDl/dlOEEEIIIYQQ4ioic4aFEEIIIYQQ
QlxzJBgWQgghhBBCCHHNkWBYCCGEEEIIIcQ1R4JhIYQQQgghhBDXHAmGhRBCCCGEEEJccyQYFkII
IYQQQghxzZFgWAghhBBCCCHENUeCYSGEEEIIIYQQ1xwJhoUQQgghhBBCXHMkGBZCCCGEEEIIcc2R
YFgIIYQQQgghxDVHgmEhhBBCCCGEENecC4Jhb2/vP6sdQgghhBBCCCHE78pisZz9+f8BdhN1TeuU
RYwAAAAASUVORK5CYII=
--000000000000937111063c142efb--
