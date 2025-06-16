Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA9C71159
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 16:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE39F402BC;
	Mon, 16 Jun 2025 18:35:35 +0200 (CEST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 by mails.dpdk.org (Postfix) with ESMTP id C32CF4021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:35:34 +0200 (CEST)
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-e824793a1cfso1298036276.3
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1750091734; x=1750696534; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l6tMcQy9GBa6Rrrl4egmcTwKpJMddBq0ojsFm6FlDvI=;
 b=AFHBV75PqXqx+A6zxmTjF8KBBw5yAh2F0otWN55nZuP3UhkUw3v7pDMm16/3pDGm2N
 4vHNEMOuMPaEnmY8CKfHnJLZUICgUASISj+yh63CUTerVMcc7iNQxxk7VadXpR3yk/AK
 NtAxyHrB9J7e2oshSJBCCAf5lo2QEPkiyIOgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750091734; x=1750696534;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l6tMcQy9GBa6Rrrl4egmcTwKpJMddBq0ojsFm6FlDvI=;
 b=afh04i0k9Twd7OGeLtDrBvmVPK/vAnmI89TWgZS728OH4im2QZ3CCzuI9imXMHlBVT
 1VX3I85oCyn5//sd75g4B+p3lKyxjn0Qqn5nVT5V5rmJT4VaZaCnrBSIJNR5jRpJkbpL
 hl0Uv20Jlu35BB2Wn6ZF1DA1rP9soYER1Enlh/LzTCRZaxHcY/kqT8NxW2CL8cY1WPLG
 OSBvk+6HX9RrDH98PbYJl01yQbYb2IGZQ6svzGD4BmFYDyLfNd7IZaP7HDGbb+871e7F
 ISql72YnuGFBH4jbWdWMcMUMJRAKdm5dTXKTdcfDFttTealX5m4AvHzzaokmWrfTvimq
 WXSA==
X-Gm-Message-State: AOJu0YzefHYi1qnYGnYWGdxKF74fsx81CtT7umvC6ATBNiHW4j9/8Juh
 kI5opzxnUJN3cu+LETzFpAs6TMeM4DugHDdN8YARuZyPzFcmJXVgJ312+bNLxzebnGEhlQmeL+K
 6f++wLvW4VTOfTee6yyIhM5dkTLgUoO/3My5G40grJz3CG0WhjG8DONC696qArJn/ihS8UOb7mr
 z7Xo4OpbK2bgtKIZ9pU8MkoQ==
X-Gm-Gg: ASbGncvv/FELOcrgE87Wwbwzfe8XQA/8HQolhqzRQvkP37TVcnjeVAKoYoMqZ6vKQ8c
 rQWksASjUgl05reXQW18zg0k4BI4pHae6a6T0IkjW8a0GLCwApxeLaoQChhy18T/Mk7DD6M34YS
 50Pb5ASoRq7tRt9kfUCnsi/u/VLNpN/lchjjP3tD+2GQ5F
X-Google-Smtp-Source: AGHT+IELNgLnpuu4ELGl5GO6TrX+h6f42IHMFOwwHrANLX5YR7KvH8PZ3g2WX5x0cf0dW36shtAlR1CNk70XWvoMg3A=
X-Received: by 2002:a05:6902:e0b:b0:e82:403f:dd1b with SMTP id
 3f1490d57ef6-e82403fdd8fmr9868135276.42.1750091733852; Mon, 16 Jun 2025
 09:35:33 -0700 (PDT)
MIME-Version: 1.0
From: Amiya Ranjan Mohakud <amiya-ranjan.mohakud@broadcom.com>
Date: Mon, 16 Jun 2025 22:04:57 +0530
X-Gm-Features: AX0GCFsflkQopMhgy6Pkg-QeNl6xYQnVs57gmz8NDPBPwUhwxut_cgeKbblrkrs
Message-ID: <CAJgakAcq1jA93xuOHfYhGuT9=Hj5p7DaUKq88mbL9t4bqf6qUw@mail.gmail.com>
Subject: iavf pmd vlan Issue: dpdk-22.11.0
To: dev@dpdk.org, users@dpdk.org
Cc: wenjing.qiao@intel.com, 
 Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001f234d0637b2fc73"
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

--0000000000001f234d0637b2fc73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

I'm encountering an issue with XL710 SR-IOV on KVM for VLAN packets
with DPDK-22.11.0 version.

*Issue Description:* I have disabled RTE_ETH_RX_OFFLOAD_VLAN_STRIP in
rte_eth_conf and calling rte_eth_dev_configure and expecting my dpdk
application to receive the packets with vlan tags. Later I added some
vlans using rte_eth_dev_vlan_filter() and I see that the vlan is
getting stripped off  for the incoming packets.

*Setup Details:(KVM SR-IOV)*

KVM Host: Ubuntu 20.04.6 LTS: kernel version: 5.4.0-216-generic #236-Ubuntu
NIC: XL710
3b:00.0 Ethernet controller: Intel Corporation Ethernet Controller
XL710 for 40GbE QSFP+ (rev 02)
3b:00.1 Ethernet controller: Intel Corporation Ethernet Controller
XL710 for 40GbE QSFP+ (rev 02)
i40e PF Driver: Out of tree 2.20.12
Firmware: 9.00/9.40
DPDK Version: 22.11.0


*Observation/Analysis:*

I could see that even after disabling RTE_ETH_RX_OFFLOAD_VLAN_STRIP
offload flag, when I receive the packets, the mbuf offload flags
(RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED) are set inside the
mbuf. This confirms that the driver is stripping off the vlans.


I tried with recommended PF driver version for DPDK-22.11.0 as per
https://mails.dpdk.org/archives/dev/2023-November/281700.html and
DPDK-22.11 release note
https://doc.dpdk.org/guides/rel_notes/release_22_11.html. Still it did
not help.


       Intel=C2=AE Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
    Firmware version(PF): 9.00 0x8000ce86 1.3179.0
    Device id (pf/vf): 8086:1583 / 8086:154c
    Driver version(out-tree): 2.20.12 (i40e)
    Driver version(in-tree): 5.15.0-46-generic (i40e)


Upon debugging further, I came across a DPDK commit:
https://github.com/DPDK/dpdk/commit/e25c7ed114b296ddaa583427824acc30bcf9c85=
d
which says it sets the vlan_strip on in PF when we set vlan filter on
VF.

I picked the fix, but still it did not help.

Later when I debugged further, I found that the vf_cap_flags is set to
VIRTCHNL_VF_OFFLOAD_VLAN_V2 for the above PF driver and still it sets
the vlan_strip on. I extended the dpdk commit for the
VIRTCHNL_VF_OFFLOAD_VLAN_V2 case which fixed the issue.


I just want to know if it's a known issue for the
VIRTCHNL_VF_OFFLOAD_VLAN_V2 case. I understand it's a known issue for
VIRTCHNL_VF_OFFLOAD_VLAN_V1 and dpdk has a fix for it.
Do we need to add the fix for VIRTCHNL_VF_OFFLOAD_VLAN_V2 as well. Can
we mainstream it? If yes, please let me know so that I can raise a
pull request for it, if required.

Regards
*Amiya*

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000001f234d0637b2fc73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><pre style=3D"font-size:13px;color:rgb(0,0,0)">Hi All=
,<br><br>I&#39;m encountering an issue with XL710 SR<span class=3D"gmail_de=
fault" style=3D"font-family:verdana,sans-serif">-</span>IOV on KVM for VLAN=
 packets with DPDK-22.11.0 version. <br><br><b><u>Issue Description:</u></b=
> I have disabled RTE_ETH_RX_OFFLOAD_VLAN_STRIP in rte_eth_conf and calling=
 rte_eth_dev_configure and expecting my dpdk application to receive the pac=
kets with vlan tags. Later I added some vlans using rte_eth_dev_vlan_filter=
() and I see that the vlan is getting stripped off =C2=A0for the incoming p=
ackets. <br><br><b><u>Setup Details:(KVM SR<span class=3D"gmail_default" st=
yle=3D"font-family:verdana,sans-serif">-</span>IOV)</u></b><br><br>KVM Host=
: Ubuntu 20.04.6 LTS: kernel version: 5.4.0-216-generic #236-Ubuntu<br>NIC:=
 XL710<br>3b:00.0 Ethernet controller: Intel Corporation Ethernet Controlle=
r XL710 for 40GbE QSFP+ (rev 02)<br>3b:00.1 Ethernet controller: Intel Corp=
oration Ethernet Controller XL710 for 40GbE QSFP+ (rev 02)<br>i40e PF Drive=
r: Out of tree 2.20.12<br>Firmware: 9.00/9.40 <br>DPDK Version: 22.11.0<br>=
<br><br><b><u>Observation/Analysis:</u></b><br><br>I could see that even af=
ter disabling RTE_ETH_RX_OFFLOAD_VLAN_STRIP offload flag, when I receive th=
e packets, the mbuf offload flags (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_=
STRIPPED) are set inside the mbuf. This confirms that the driver is strippi=
ng off the vlans.</pre><pre style=3D"font-size:13px;color:rgb(0,0,0)"><br>I=
 tried with recommended PF driver version for DPDK-22.11.0 as per <a href=
=3D"https://mails.dpdk.org/archives/dev/2023-November/281700.html">https://=
mails.dpdk.org/archives/dev/2023-November/281700.html</a> and DPDK-22.11 re=
lease note <a href=3D"https://doc.dpdk.org/guides/rel_notes/release_22_11.h=
tml">https://doc.dpdk.org/guides/rel_notes/release_22_11.html</a>. Still it=
 did not help.<br><br><br><span class=3D"gmail_default" style=3D"font-famil=
y:verdana,sans-serif">       </span>Intel=C2=AE Ethernet Converged Network =
Adapter XL710-QDA2 (2X40G)<br>=C2=A0 =C2=A0 Firmware version(PF): 9.00 0x80=
00ce86 1.3179.0<br>=C2=A0 =C2=A0 Device id (pf/vf): 8086:1583 / 8086:154c<b=
r>=C2=A0 =C2=A0 Driver version(out-tree): 2.20.12 (i40e)<br>=C2=A0 =C2=A0 D=
river version(in-tree): 5.15.0-46-generic (i40e)<br><br><br>Upon debugging =
further, I came across a DPDK commit: <a href=3D"https://github.com/DPDK/dp=
dk/commit/e25c7ed114b296ddaa583427824acc30bcf9c85d">https://github.com/DPDK=
/dpdk/commit/e25c7ed114b296ddaa583427824acc30bcf9c85d</a><span class=3D"gma=
il_default" style=3D"font-family:verdana,sans-serif"> </span>which says it =
sets the vlan_strip on in PF when we set vlan filter on VF. <br><br></pre><=
pre style=3D"font-size:13px;color:rgb(0,0,0)">I picked the fix, but still i=
t did not help.<br><br>Later when I debugged further, I found that the vf_c=
ap_flags is set to VIRTCHNL_VF_OFFLOAD_VLAN_V2 for the above PF driver and =
still it sets the vlan_strip on. I extended the dpdk commit for the VIRTCHN=
L_VF_OFFLOAD_VLAN_V2 case which fixed the issue.<br><br><br>I just want to =
know if it&#39;s a known issue for the VIRTCHNL_VF_OFFLOAD_VLAN_V2 case. I =
understand it&#39;s a known issue for VIRTCHNL_VF_OFFLOAD_VLAN_V1 and dpdk =
has a fix for it. <br>Do we need to add the fix for VIRTCHNL_VF_OFFLOAD_VLA=
N_V2 as well. Can we mainstream it? If yes, please let me know so that I ca=
n raise a pull request for it, if required.</pre></div><div><div dir=3D"ltr=
" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"=
ltr"><div><span style=3D"font-size:10pt;font-family:Arial,sans-serif;font-w=
eight:700;vertical-align:baseline"><font color=3D"#666666"><span style=3D"f=
ont-size:13.3333px">Regards</span><br></font></span></div><span style=3D"fo=
nt-size:10pt;font-family:Arial,sans-serif;vertical-align:baseline"><b><font=
 color=3D"#666666">Amiya</font></b></span><div><div><div><span style=3D"fon=
t-size:10pt;font-family:Arial,sans-serif;color:rgb(102,102,102);vertical-al=
ign:baseline"><br></span></div></div></div></div></div></div></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--0000000000001f234d0637b2fc73--
