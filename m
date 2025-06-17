Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B906C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 11:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBE9640E48;
	Tue, 17 Jun 2025 13:56:56 +0200 (CEST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by mails.dpdk.org (Postfix) with ESMTP id 7906340A73;
 Tue, 17 Jun 2025 12:03:54 +0200 (CEST)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-adb5cb6d8f1so1017792166b.3; 
 Tue, 17 Jun 2025 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750154634; x=1750759434; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XEgLGcRTnYcpcerULRO8vnl3vOqtNGrISLiJX3BhWdE=;
 b=RVlNjWMbTcShVl3vZwGDZL1MERI+BWyPJez28DBQiNjNBaKnEhz1VdhJy19ubN5HVg
 It0uLwU/upn7wlvYzD0yWGyAF/KD1J2GwlIIvjkhoBaR9+7WmkMj9/Oe1mm+ancz9ROl
 hHVpkUMQIMgWQaf7c2NYcKJ1vz/46WsO84pAo6X/Lmy3FQ0Kam6vk+pWfM7oNa62ZYxc
 chBVLPLj+NReQ148xG+zzrHftvJJGro5tDBFHg7Smy72JV4jBodUoheSLA7lOnxyjQYp
 HH1GXd6CzNLp/iT5gjeGdFBxSmlZHsRFU9/ir1C+9N0VhIM+8kYVnh22KbrZ6EA/HbAe
 BzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154634; x=1750759434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XEgLGcRTnYcpcerULRO8vnl3vOqtNGrISLiJX3BhWdE=;
 b=PKGVE4W7aO+1yG93tmqhJWQgBHytxEitHOspNqhIQsRMt96Vfe7YxZiEF0pwRhL3TM
 ZyOJCS6/nDD82rvzeUEJvsSRPifvIb6MTZWzsSuHKzPN56ObVf0AjWtc3oUXHk5gMjma
 cIxb5Bs1bG5/1kEX1n1RMlrmOxOybLl8QyVaFmFeVSyJkdz5bk1PCizfjSf9uQmacAgS
 c7EKiIJ8sSisXnl6ormADI6xZjTyeuaKBleuMIFhlwQeBKFuoyQG4F/ThAmkNfZsZ7tp
 QxrCsI9BqPbCvzs6XvT6LhbFlbl5o125OmBLgaSyLxb/0qmlRFSIOMCH4caiMlONnNal
 DD2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt2pDi27gMD9YBD445NU8i0snVkAl7Pkh59GFK5XU2ROPTiwinIeVcb6Wp2S08DWrEvJ/8xg==@dpdk.org
X-Gm-Message-State: AOJu0Yw/JFRW4PLbOm2K1xm+nShKOUwH0p9zRpx34SlW5OD5ZsWnwjZb
 EOjLZIBnv/VwlFc/rclHdb2DFoKCDbAg0O5zdRVDLiOQtk1SSg496oQOO5x/rwoEssyqURr7sdj
 Ji8hPeIH7rkfbfo2b7oW5bymp1KMEJ0A=
X-Gm-Gg: ASbGncvWzgIjIpEMzma+A9AvkEagKFQ+Ga9MJRw9+NIAk4af12Qu1DbxLcnXLKlL9UX
 izjPiFRH9IYemrBuhBJ/kFZ5tgJ+EGt0t0ZHnA1HrMdqu/Kahha4aXnCyjYdmJ8w7F1Rm+kh39d
 9dBnmUQF9XSk8xjS/8Vg7hvL3YgdB0po1Z5VWYAjw9KG9dtm+fEvwJqrMiN1WSCxeahAeokNHsG
 DjvXVeMo4REuQ==
X-Google-Smtp-Source: AGHT+IH7NLNaKP0TEZeLw3e7ci4YhtuJmBB+5QPHQ/PfGri8S/6sePf4ghlx0PieBjAovO4zLSnBl7oR7G0bdyK6hkg=
X-Received: by 2002:a17:907:3da0:b0:ad8:9257:571c with SMTP id
 a640c23a62f3a-adfad326f1bmr1293466466b.20.1750154633368; Tue, 17 Jun 2025
 03:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgakAcq1jA93xuOHfYhGuT9=Hj5p7DaUKq88mbL9t4bqf6qUw@mail.gmail.com>
In-Reply-To: <CAJgakAcq1jA93xuOHfYhGuT9=Hj5p7DaUKq88mbL9t4bqf6qUw@mail.gmail.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Tue, 17 Jun 2025 15:33:42 +0530
X-Gm-Features: AX0GCFtzxNXI4r7EJRWBFLv_OQV1BEC_GNc2DaomoHQZl6SWz-BMJFkzmwWSuMQ
Message-ID: <CAL+mCpPGcyfdYbnkSVaFWx8e1G5pthKvKLmpPQm9R+-bYFYSGg@mail.gmail.com>
Subject: Re: iavf pmd vlan Issue: dpdk-22.11.0
To: Amiya Ranjan Mohakud <amiya-ranjan.mohakud@broadcom.com>
Cc: dev@dpdk.org, users@dpdk.org, wenjing.qiao@intel.com
Content-Type: multipart/alternative; boundary="0000000000003959b90637c1a182"
X-Mailman-Approved-At: Tue, 17 Jun 2025 13:56:54 +0200
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

--0000000000003959b90637c1a182
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Created a ticket: https://bugs.dpdk.org/show_bug.cgi?id=3D1725
Sharing the patch for the same for quick look.( I know it can be better
modularised.)

diff --git a/drivers/net/iavf/iavf_ethdev.c b/drivers/net/iavf/iavf_ethdev.=
c
index 656a4c6176..25d7924c31 100644
--- a/drivers/net/iavf/iavf_ethdev.c
+++ b/drivers/net/iavf/iavf_ethdev.c
@@ -1360,6 +1360,18 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev
*dev, uint16_t vlan_id, int on)
                err =3D iavf_add_del_vlan_v2(adapter, vlan_id, on);
                if (err)
                        return -EIO;
+               /* Disable strip for i40e kernel driver which supports vlan=
 v2
+                * VIRTCHNL OP
+                */
+               if (adapter->hw.mac.type =3D=3D IAVF_MAC_XL710 ||
+                   adapter->hw.mac.type =3D=3D IAVF_MAC_VF ||
+                   adapter->hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
+                       if (on && !(dev_conf->rxmode.offloads &
RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
+                               err =3D iavf_disable_vlan_strip(adapter);
+                               if (err)
+                                       return -EIO;
+                       }
+               }
                return 0;
        }

@@ -1375,10 +1387,9 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev
*dev, uint16_t vlan_id, int on)
         * change strip flag. To be consistent with dpdk side, disable stri=
p
         * again.
         *
-        * For i40e kernel driver which supports vlan v2, dpdk will
invoke vlan v2
-        * related function, so it won't go through here.
         */
        if (adapter->hw.mac.type =3D=3D IAVF_MAC_XL710 ||
+           adapter->hw.mac.type =3D=3D IAVF_MAC_VF ||
            adapter->hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
                if (on && !(dev_conf->rxmode.offloads &
RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
                        err =3D iavf_disable_vlan_strip(adapter);





Thanks
Amiya


On Mon, 16 Jun 2025 at 22:05, Amiya Ranjan Mohakud <
amiya-ranjan.mohakud@broadcom.com> wrote:

> Hi All,
>
> I'm encountering an issue with XL710 SR-IOV on KVM for VLAN packets with =
DPDK-22.11.0 version.
>
> *Issue Description:* I have disabled RTE_ETH_RX_OFFLOAD_VLAN_STRIP in rte=
_eth_conf and calling rte_eth_dev_configure and expecting my dpdk applicati=
on to receive the packets with vlan tags. Later I added some vlans using rt=
e_eth_dev_vlan_filter() and I see that the vlan is getting stripped off  fo=
r the incoming packets.
>
> *Setup Details:(KVM SR-IOV)*
>
> KVM Host: Ubuntu 20.04.6 LTS: kernel version: 5.4.0-216-generic #236-Ubun=
tu
> NIC: XL710
> 3b:00.0 Ethernet controller: Intel Corporation Ethernet Controller XL710 =
for 40GbE QSFP+ (rev 02)
> 3b:00.1 Ethernet controller: Intel Corporation Ethernet Controller XL710 =
for 40GbE QSFP+ (rev 02)
> i40e PF Driver: Out of tree 2.20.12
> Firmware: 9.00/9.40
> DPDK Version: 22.11.0
>
>
> *Observation/Analysis:*
>
> I could see that even after disabling RTE_ETH_RX_OFFLOAD_VLAN_STRIP offlo=
ad flag, when I receive the packets, the mbuf offload flags (RTE_MBUF_F_RX_=
VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED) are set inside the mbuf. This confirms =
that the driver is stripping off the vlans.
>
>
> I tried with recommended PF driver version for DPDK-22.11.0 as per https:=
//mails.dpdk.org/archives/dev/2023-November/281700.html and DPDK-22.11 rele=
ase note https://doc.dpdk.org/guides/rel_notes/release_22_11.html. Still it=
 did not help.
>
>
>        Intel=C2=AE Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
>     Firmware version(PF): 9.00 0x8000ce86 1.3179.0
>     Device id (pf/vf): 8086:1583 / 8086:154c
>     Driver version(out-tree): 2.20.12 (i40e)
>     Driver version(in-tree): 5.15.0-46-generic (i40e)
>
>
> Upon debugging further, I came across a DPDK commit: https://github.com/D=
PDK/dpdk/commit/e25c7ed114b296ddaa583427824acc30bcf9c85d which says it sets=
 the vlan_strip on in PF when we set vlan filter on VF.
>
> I picked the fix, but still it did not help.
>
> Later when I debugged further, I found that the vf_cap_flags is set to VI=
RTCHNL_VF_OFFLOAD_VLAN_V2 for the above PF driver and still it sets the vla=
n_strip on. I extended the dpdk commit for the VIRTCHNL_VF_OFFLOAD_VLAN_V2 =
case which fixed the issue.
>
>
> I just want to know if it's a known issue for the VIRTCHNL_VF_OFFLOAD_VLA=
N_V2 case. I understand it's a known issue for VIRTCHNL_VF_OFFLOAD_VLAN_V1 =
and dpdk has a fix for it.
> Do we need to add the fix for VIRTCHNL_VF_OFFLOAD_VLAN_V2 as well. Can we=
 mainstream it? If yes, please let me know so that I can raise a pull reque=
st for it, if required.
>
> Regards
> *Amiya*
>
>
> This electronic communication and the information and any files
> transmitted with it, or attached to it, are confidential and are intended
> solely for the use of the individual or entity to whom it is addressed an=
d
> may contain information that is confidential, legally privileged, protect=
ed
> by privacy laws, or otherwise restricted from disclosure to anyone else. =
If
> you are not the intended recipient or the person responsible for deliveri=
ng
> the e-mail to the intended recipient, you are hereby notified that any us=
e,
> copying, distributing, dissemination, forwarding, printing, or copying of
> this e-mail is strictly prohibited. If you received this e-mail in error,
> please return the e-mail to the sender, delete it from your computer, and
> destroy any printed copy of it.

--0000000000003959b90637c1a182
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:verdana,sans-serif;color:rg=
b(103,78,167)" class=3D"gmail_default">Created a ticket:=C2=A0<a href=3D"ht=
tps://bugs.dpdk.org/show_bug.cgi?id=3D1725" target=3D"_blank">https://bugs.=
dpdk.org/show_bug.cgi?id=3D1725</a></div><div style=3D"font-family:verdana,=
sans-serif;color:rgb(103,78,167)" class=3D"gmail_default">Sharing the patch=
 for the same for quick look.( I know it can be better modularised.)</div><=
div style=3D"font-family:verdana,sans-serif;color:rgb(103,78,167)" class=3D=
"gmail_default"><br></div><div style=3D"font-family:verdana,sans-serif;colo=
r:rgb(103,78,167)" class=3D"gmail_default"><pre class=3D"gmail-bz_comment_t=
ext">diff --git a/drivers/net/iavf/iavf_ethdev.c b/drivers/net/iavf/iavf_et=
hdev.c
index 656a4c6176..25d7924c31 100644
--- a/drivers/net/iavf/iavf_ethdev.c
+++ b/drivers/net/iavf/iavf_ethdev.c
@@ -1360,6 +1360,18 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, ui=
nt16_t vlan_id, int on)
                err =3D iavf_add_del_vlan_v2(adapter, vlan_id, on);
                if (err)
                        return -EIO;
+               /* Disable strip for i40e kernel driver which supports vlan=
 v2
+                * VIRTCHNL OP
+                */
+               if (adapter-&gt;hw.mac.type =3D=3D IAVF_MAC_XL710 ||
+                   adapter-&gt;hw.mac.type =3D=3D IAVF_MAC_VF ||
+                   adapter-&gt;hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
+                       if (on &amp;&amp; !(dev_conf-&gt;rxmode.offloads &a=
mp; RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
+                               err =3D iavf_disable_vlan_strip(adapter);
+                               if (err)
+                                       return -EIO;
+                       }
+               }
                return 0;
        }
=20
@@ -1375,10 +1387,9 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, ui=
nt16_t vlan_id, int on)
         * change strip flag. To be consistent with dpdk side, disable stri=
p
         * again.
         *
-        * For i40e kernel driver which supports vlan v2, dpdk will invoke =
vlan v2
-        * related function, so it won&#39;t go through here.
         */
        if (adapter-&gt;hw.mac.type =3D=3D IAVF_MAC_XL710 ||
+           adapter-&gt;hw.mac.type =3D=3D IAVF_MAC_VF ||
            adapter-&gt;hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
                if (on &amp;&amp; !(dev_conf-&gt;rxmode.offloads &amp; RTE_=
ETH_RX_OFFLOAD_VLAN_STRIP)) {
                        err =3D iavf_disable_vlan_strip(adapter);
  </pre></div><div style=3D"font-family:verdana,sans-serif;color:rgb(103,78=
,167)" class=3D"gmail_default"><br></div><br></div><div><br clear=3D"all"><=
/div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmai=
l_signature"><div dir=3D"ltr"><div><span style=3D"font-family:verdana,sans-=
serif">Thanks</span></div><div><span style=3D"font-family:verdana,sans-seri=
f">Amiya</span><br></div></div></div></div><br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 16 Jun 2025 at 22:05=
, Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiya-ranjan.mohakud@broadcom.=
com" target=3D"_blank">amiya-ranjan.mohakud@broadcom.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv><pre style=3D"font-size:13px;color:rgb(0,0,0)">Hi All,<br><br>I&#39;m en=
countering an issue with XL710 SR<span class=3D"gmail_default" style=3D"fon=
t-family:verdana,sans-serif">-</span>IOV on KVM for VLAN packets with DPDK-=
22.11.0 version. <br><br><b><u>Issue Description:</u></b> I have disabled R=
TE_ETH_RX_OFFLOAD_VLAN_STRIP in rte_eth_conf and calling rte_eth_dev_config=
ure and expecting my dpdk application to receive the packets with vlan tags=
. Later I added some vlans using rte_eth_dev_vlan_filter() and I see that t=
he vlan is getting stripped off =C2=A0for the incoming packets. <br><br><b>=
<u>Setup Details:(KVM SR<span class=3D"gmail_default" style=3D"font-family:=
verdana,sans-serif">-</span>IOV)</u></b><br><br>KVM Host: Ubuntu 20.04.6 LT=
S: kernel version: 5.4.0-216-generic #236-Ubuntu<br>NIC: XL710<br>3b:00.0 E=
thernet controller: Intel Corporation Ethernet Controller XL710 for 40GbE Q=
SFP+ (rev 02)<br>3b:00.1 Ethernet controller: Intel Corporation Ethernet Co=
ntroller XL710 for 40GbE QSFP+ (rev 02)<br>i40e PF Driver: Out of tree 2.20=
.12<br>Firmware: 9.00/9.40 <br>DPDK Version: 22.11.0<br><br><br><b><u>Obser=
vation/Analysis:</u></b><br><br>I could see that even after disabling RTE_E=
TH_RX_OFFLOAD_VLAN_STRIP offload flag, when I receive the packets, the mbuf=
 offload flags (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED) are set i=
nside the mbuf. This confirms that the driver is stripping off the vlans.</=
pre><pre style=3D"font-size:13px;color:rgb(0,0,0)"><br>I tried with recomme=
nded PF driver version for DPDK-22.11.0 as per <a href=3D"https://mails.dpd=
k.org/archives/dev/2023-November/281700.html" target=3D"_blank">https://mai=
ls.dpdk.org/archives/dev/2023-November/281700.html</a> and DPDK-22.11 relea=
se note <a href=3D"https://doc.dpdk.org/guides/rel_notes/release_22_11.html=
" target=3D"_blank">https://doc.dpdk.org/guides/rel_notes/release_22_11.htm=
l</a>. Still it did not help.<br><br><br><span class=3D"gmail_default" styl=
e=3D"font-family:verdana,sans-serif">       </span>Intel=C2=AE Ethernet Con=
verged Network Adapter XL710-QDA2 (2X40G)<br>=C2=A0 =C2=A0 Firmware version=
(PF): 9.00 0x8000ce86 1.3179.0<br>=C2=A0 =C2=A0 Device id (pf/vf): 8086:158=
3 / 8086:154c<br>=C2=A0 =C2=A0 Driver version(out-tree): 2.20.12 (i40e)<br>=
=C2=A0 =C2=A0 Driver version(in-tree): 5.15.0-46-generic (i40e)<br><br><br>=
Upon debugging further, I came across a DPDK commit: <a href=3D"https://git=
hub.com/DPDK/dpdk/commit/e25c7ed114b296ddaa583427824acc30bcf9c85d" target=
=3D"_blank">https://github.com/DPDK/dpdk/commit/e25c7ed114b296ddaa583427824=
acc30bcf9c85d</a><span class=3D"gmail_default" style=3D"font-family:verdana=
,sans-serif"> </span>which says it sets the vlan_strip on in PF when we set=
 vlan filter on VF. <br><br></pre><pre style=3D"font-size:13px;color:rgb(0,=
0,0)">I picked the fix, but still it did not help.<br><br>Later when I debu=
gged further, I found that the vf_cap_flags is set to VIRTCHNL_VF_OFFLOAD_V=
LAN_V2 for the above PF driver and still it sets the vlan_strip on. I exten=
ded the dpdk commit for the VIRTCHNL_VF_OFFLOAD_VLAN_V2 case which fixed th=
e issue.<br><br><br>I just want to know if it&#39;s a known issue for the V=
IRTCHNL_VF_OFFLOAD_VLAN_V2 case. I understand it&#39;s a known issue for VI=
RTCHNL_VF_OFFLOAD_VLAN_V1 and dpdk has a fix for it. <br>Do we need to add =
the fix for VIRTCHNL_VF_OFFLOAD_VLAN_V2 as well. Can we mainstream it? If y=
es, please let me know so that I can raise a pull request for it, if requir=
ed.</pre></div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"=
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
 copy of it.</font></span></blockquote></div>

--0000000000003959b90637c1a182--
