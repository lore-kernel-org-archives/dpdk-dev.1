Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C01FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A916840672;
	Wed, 29 Apr 2026 11:58:28 +0200 (CEST)
Received: from mx1.wirefilter.com (mx1.wirefilter.com [82.147.223.86])
 by mails.dpdk.org (Postfix) with ESMTP id 334D1402A3;
 Tue, 28 Apr 2026 09:03:43 +0200 (CEST)
Received: from egw.wirefilter.com (localhost.localdomain [127.0.0.1])
 by mx1.wirefilter.com (Proxmox) with ESMTP id 31F6EC1758;
 Tue, 28 Apr 2026 10:03:42 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wirefilter.com;
 h=cc:cc:content-type:content-type:date:from:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to; s=default; bh=3q/BzzUMUsLwmERpdg5TdCXTmz6x+3LQMxW1XDkf+II=; b=
 ugCww0CKUMAuliiinBoZ9y+m5p4G/kag2l8HG6YbKRVNfb6Z0KH9DgJymZ3PV7cH
 Wrlw+mdf2CdwpiqUUpVaPBhzkUVwCrnw4xAxerCUHBXrsD4saEzlQsd7LI0a8en3
 bJtMKEYj5zCpelmKX4kJvLtIeSabTEjfgqmanx4yyA9rDERPWsEOoPjGIOdl6I3s
 3g2PfvXzrPzgaR92J7LcfO0tL12wYQjDuH40d1IQD2ZNX6l//4MAlSqWPi3Io+sI
 b372U3eAaqjg39X/hzeNyV8q7xqqmBs2qycZpMnMCVc1eqQhcFW6DrBUYYdLpfZy
 q8rUnTLPY0yR8ZdJSasN5A==
Date: Tue, 28 Apr 2026 10:03:41 +0300 (AST)
From: Abdulrahman Alshawi <ashawi@wirefilter.com>
To: dev <dev@dpdk.org>
Cc: bharat <bharat@chelsio.com>, stable <stable@dpdk.org>, 
 vipinpv85 <vipinpv85@gmail.com>
Message-ID: <1076242828.15909769.1777359821929.JavaMail.zimbra@wirefilter.com>
In-Reply-To: <48263833.15868423.1777308172969.JavaMail.zimbra@wirefilter.com>
References: <2136264989.15868282.1777307418083.JavaMail.zimbra@wirefilter.com>
 <48263833.15868423.1777308172969.JavaMail.zimbra@wirefilter.com>
Subject: Re: [PATCH 2/2] net/cxgbe: restrict rte flow rules to ingress port
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_d7ff3640-e10f-41c0-9c44-83110c995ce1"
X-Originating-IP: [10.1.1.3]
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraModernWebClient - GC147
 (Mac)/10.1.16_GA_4850)
Thread-Topic: net/cxgbe: restrict rte flow rules to ingress port
Thread-Index: vibgbhNHf0ETdtVkwLuwbZrWfuFjrSUCB5/6H58k6yc=
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:58:18 +0200
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

--=_d7ff3640-e10f-41c0-9c44-83110c995ce1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=20
=C2=A0=20
=20
Adding Vipin Varghese


=20
=20
=20

-----Original Message-----

From: Abdulrahman <ashawi@wirefilter.com>
To: dev <dev@dpdk.org>
Cc: bharat <bharat@chelsio.com>; stable <stable@dpdk.org>
Date: Monday, 27 April 2026 7:42 PM +03
Subject: [PATCH 2/2] net/cxgbe: restrict rte flow rules to ingress port

=20
=20
 Chelsio filters are programmed in adapter-wide LE/TCAM tables shared by al=
l ports. rte_flow rules, however, are created on a specific ethdev and are =
expected to apply to traffic arriving on that port. =C2=A0 The PMD already =
supports ingress-port matching in the hardware filter spec. The iport field=
 is validated, used for hash-region selection when tp.port_shift is availab=
le, and emitted in the firmware filter work request. But the rte_flow parse=
r never sets fs.val.iport/fs.mask.iport for normal per-port rules. =C2=A0 A=
s a result, a rule created on one port is installed as an adapter-wide matc=
h and can steer traffic received on sibling ports of the same adapter. =C2=
=A0 In practice this causes cross-port steering. For example, a rule like =
=C2=A0 =C2=A0 vlan 100 -> queue 3 =C2=A0 created on port 0 can also match V=
LAN 100 traffic arriving on port 1 and redirect it into port 0's queue 3. =
=C2=A0 Fix this by stamping the creating ethdev's physical ingress port int=
o the filter spec before filter placement is decided. =C2=A0 Only do this w=
hen the active filter mode includes the port field (tp.port_shift >=3D 0). =
If port matching is not available in the current filter mode, keep the exis=
ting adapter-wide behavior. =C2=A0 Reproduce (two ports of the same adapter=
 bound to DPDK): =C2=A0 =C2=A0 dpdk-testpmd -l 1-9 -a 0000:18:00.4 -a 0000:=
18:00.5 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -- --rxq=3D4 --txq=3D4 --forwa=
rd-mode=3Drxonly -i =C2=A0 testpmd> flow create 0 ingress pattern eth \ =C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / vlan tci is 100 / end actions queue=
 index 3 / end =C2=A0 testpmd> start =C2=A0 Without this patch, VLAN 100 tr=
affic received on port 1 can be steered by the rule created on port 0. With=
 the patch, the rule only matches traffic arriving on port 0. =C2=A0 Signed=
-off-by: Abdulrahman Alshawi <ashawi@wirefilter.com> --- =C2=A0.mailmap =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 + =C2=A0drivers/net/cxgbe/cxgbe_flow.c | 19 +++++++++++++++++++ =
=C2=A02 files changed, 20 insertions(+) =C2=A0 diff --git a/.mailmap b/.mai=
lmap index 0e0d83e1c6..a6bcbd5756 100644 --- a/.mailmap +++ b/.mailmap @@ -=
4,6 +4,7 @@ Aaro Koskinen <aaro.koskinen@nsn.com> =C2=A0Aaron Campbell <aar=
on@arbor.net> =C2=A0Aaron Conole <aconole@redhat.com> =C2=A0Abdullah =C3=96=
mer Yama=C3=A7 <omer.yamac@ceng.metu.edu.tr> <aomeryamac@gmail.com> +Abdulr=
ahman Alshawi <ashawi@wirefilter.com> =C2=A0Abdullah Sevincer <abdullah.sev=
incer@intel.com> =C2=A0Abed Kamaluddin <akamaluddin@marvell.com> =C2=A0Abhi=
jit Gangurde <abhijit.gangurde@amd.com> diff --git a/drivers/net/cxgbe/cxgb=
e_flow.c b/drivers/net/cxgbe/cxgbe_flow.c index 14b9b49792..dd0634131e 1006=
44 --- a/drivers/net/cxgbe/cxgbe_flow.c +++ b/drivers/net/cxgbe/cxgbe_flow.=
c @@ -172,6 +172,24 @@ cxgbe_fill_filter_region(struct adapter *adap, =C2=
=A0 fs->cap =3D 1; /* use hash region */ =C2=A0} =C2=A0 +static void +cxgbe=
_scope_flow_to_port(struct rte_flow *flow) +{ + struct adapter *adap =3D et=
hdev2adap(flow->dev); + struct port_info *pi =3D ethdev2pinfo(flow->dev); +=
 + /* + * Chelsio filters are programmed in adapter-global tables. DPDK + *=
 ingress rte_flow rules are created on a specific ethdev, so include + * th=
e physical ingress port when the active filter mode supports it. + */ + if =
(adap->params.tp.port_shift < 0) +  return; + + flow->fs.val.iport =3D pi->=
port_id; + flow->fs.mask.iport =3D (1U << IPORT_BITWIDTH) - 1; +} + =C2=A0s=
tatic int =C2=A0ch_rte_parsetype_eth(const void *dmask, const struct rte_fl=
ow_item *item, =C2=A0  =C2=A0 =C2=A0 struct ch_filter_specification *fs, @@=
 -986,6 +1004,7 @@ cxgbe_rtef_parse_items(struct rte_flow *flow, =C2=A0 } =
=C2=A0 =C2=A0 cxgbe_tweak_filter_spec(adap, &flow->fs); + cxgbe_scope_flow_=
to_port(flow); =C2=A0 cxgbe_fill_filter_region(adap, &flow->fs); =C2=A0 =C2=
=A0 return 0; --=C2=A0 2.39.5 =20
=20
=C2=A0=20
=20
=20
=20
From: Abdulrahman <ashawi@wirefilter.com>
To: dev <dev@dpdk.org>
Cc: bharat <bharat@chelsio.com>; stable <stable@dpdk.org>
Date: Monday, 27 April 2026 7:30 PM +03
Subject: [PATCH 0/2] net/cxgbe: fix packed Rx handling and flow port scopin=
g

=20
=20
=20
=20

This series fixes two correctness issues in the cxgbe PMD that can cause
traffic loss on Chelsio T6 adapters, especially when rte_flow QUEUE
rules concentrate ingress on a small set of RX queues.=20

Patch 1 fixes packed Rx response handling. The current PMD assumes every
response descriptor starts a new Free List buffer by requiring
F_RSPD_NEWBUF on each response. That assumption does not always hold for
packed ingress responses. Under sustained small-packet traffic to a
single ingress queue, the FL/IQ state goes out of sync and the affected
Rx path stops making forward progress.=20

Patch 2 scopes rte_flow rules to the ingress port they were created on.
Chelsio filters are programmed in adapter-wide tables, and the PMD
already supports the iport field in the hardware filter spec. However,
the flow parser never fills it for normal per-port rules, so a rule
created on one port can also match traffic arriving on sibling ports of
the same adapter.=20

Both issues reproduce with stock testpmd on T62100-LP-CR. The per-patch
commit messages include the details and reproducers.=20

Abdulrahman Alshawi (2):
net/cxgbe: fix Rx handling for packed responses
net/cxgbe: restrict rte_flow rules to ingress port=20

.mailmap | 1 +
drivers/net/cxgbe/base/adapter.h | 1 +
drivers/net/cxgbe/cxgbe_flow.c | 19 +++++
drivers/net/cxgbe/sge.c | 122 ++++++++++++++++++++++++-------
4 files changed, 118 insertions(+), 25 deletions(-)=20

--
2.39.5  =20
        =20

--=_d7ff3640-e10f-41c0-9c44-83110c995ce1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-size: 11pt; font-family: arial, helvetica, s=
ans-serif; direction: null; color: #000000;" data-attr=3D"forced_root_block=
_attrs">
<div>&nbsp;</div>
<div id=3D"signature-content-no-signature" data-marker=3D"__SIG_PRE__"></di=
v>
<div>Adding Vipin Varghese<br><br><br></div>
<div>

<div id=3D"OLK_SRC_BODY_SECTION">
<blockquote style=3D"margin: 0 0 0 .8em; border-left: 1px #ccc solid; paddi=
ng-left: 1em;"><hr id=3D"MESSAGE_DATA_MARKER"><strong>From: </strong>Abdulr=
ahman &lt;ashawi@wirefilter.com&gt;<br><strong>To: </strong>dev &lt;dev@dpd=
k.org&gt;<br><strong>Cc: </strong>bharat &lt;bharat@chelsio.com&gt;; stable=
 &lt;stable@dpdk.org&gt;<br><strong>Date: </strong>Monday, 27 April 2026 7:=
42 PM +03<br><strong>Subject: </strong>[PATCH 2/2] net/cxgbe: restrict rte =
flow rules to ingress port<br><br>
<div style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-se=
rif; color: #000000;">
<div>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">C=
helsio filters are programmed in adapter-wide LE/TCAM tables shared by</spa=
n></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">a=
ll ports. rte_flow rules, however, are created on a specific ethdev and</sp=
an></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">a=
re expected to apply to traffic arriving on that port.</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">T=
he PMD already supports ingress-port matching in the hardware filter</span>=
</p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">s=
pec. The iport field is validated, used for hash-region selection when</spa=
n></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">t=
p.port_shift is available, and emitted in the firmware filter work</span></=
p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">r=
equest. But the rte_flow parser never sets fs.val.iport/fs.mask.iport</span=
></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">f=
or normal per-port rules.</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">A=
s a result, a rule created on one port is installed as an adapter-wide</spa=
n></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">m=
atch and can steer traffic received on sibling ports of the same</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">a=
dapter.</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">I=
n practice this causes cross-port steering. For example, a rule like</span>=
</p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp; vlan 100 -&gt; queue 3</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">c=
reated on port 0 can also match VLAN 100 traffic arriving on port 1 and</sp=
an></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">r=
edirect it into port 0's queue 3.</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">F=
ix this by stamping the creating ethdev's physical ingress port into</span>=
</p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">t=
he filter spec before filter placement is decided.</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">O=
nly do this when the active filter mode includes the port field</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">(=
tp.port_shift &gt;=3D 0). If port matching is not available in the current<=
/span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">f=
ilter mode, keep the existing adapter-wide behavior.</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">R=
eproduce (two ports of the same adapter bound to DPDK):</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp; dpdk-testpmd -l 1-9 -a 0000:18:00.4 -a 0000:18:00.5 \</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -- --rxq=3D4 --txq=3D4 --forward-mode=3Dr=
xonly -i</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp; testpmd&gt; flow create 0 ingress pattern eth \</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; / vlan tci is 100 / end actions que=
ue index 3 / end</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp; testpmd&gt; start</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">W=
ithout this patch, VLAN 100 traffic received on port 1 can be steered</span=
></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">b=
y the rule created on port 0. With the patch, the rule only matches</span><=
/p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">t=
raffic arriving on port 0.</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">S=
igned-off-by: Abdulrahman Alshawi &lt;ashawi@wirefilter.com&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">-=
--</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;.mailmap &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; |&nbsp; 1 +</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;drivers/net/cxgbe/cxgbe_flow.c | 19 +++++++++++++++++++</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;2 files changed, 20 insertions(+)</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">d=
iff --git a/.mailmap b/.mailmap</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">i=
ndex 0e0d83e1c6..a6bcbd5756 100644</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">-=
-- a/.mailmap</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
++ b/.mailmap</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@=
@ -4,6 +4,7 @@ Aaro Koskinen &lt;aaro.koskinen@nsn.com&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;Aaron Campbell &lt;aaron@arbor.net&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;Aaron Conole &lt;aconole@redhat.com&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;Abdullah =C3=96mer Yama=C3=A7 &lt;omer.yamac@ceng.metu.edu.tr&gt; &lt;=
aomeryamac@gmail.com&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
Abdulrahman Alshawi &lt;ashawi@wirefilter.com&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;Abdullah Sevincer &lt;abdullah.sevincer@intel.com&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;Abed Kamaluddin &lt;akamaluddin@marvell.com&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;Abhijit Gangurde &lt;abhijit.gangurde@amd.com&gt;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">d=
iff --git a/drivers/net/cxgbe/cxgbe_flow.c b/drivers/net/cxgbe/cxgbe_flow.c=
</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">i=
ndex 14b9b49792..dd0634131e 100644</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">-=
-- a/drivers/net/cxgbe/cxgbe_flow.c</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
++ b/drivers/net/cxgbe/cxgbe_flow.c</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@=
@ -172,6 +172,24 @@ cxgbe_fill_filter_region(struct adapter *adap,</span></=
p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;<span style=3D"white-space: pre;"> </span>fs-&gt;cap =3D 1;<span style=
=3D"white-space: pre;"> </span>/* use hash region */</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;}</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
static void</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
cxgbe_scope_flow_to_port(struct rte_flow *flow)</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
{</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>struct adapter *adap =3D ethdev2a=
dap(flow-&gt;dev);</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>struct port_info *pi =3D ethdev2p=
info(flow-&gt;dev);</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>/*</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>* Chelsio filters are programmed =
in adapter-global tables. DPDK</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>* ingress rte_flow rules are crea=
ted on a specific ethdev, so include</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>* the physical ingress port when =
the active filter mode supports it.</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>*/</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>if (adap-&gt;params.tp.port_shift=
 &lt; 0)</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span><span style=3D"white-space: pre;"=
> </span>return;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>flow-&gt;fs.val.iport =3D pi-&gt;=
port_id;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>flow-&gt;fs.mask.iport =3D (1U &l=
t;&lt; IPORT_BITWIDTH) - 1;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
}</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;static int</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;ch_rte_parsetype_eth(const void *dmask, const struct rte_flow_item *it=
em,</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;<span style=3D"white-space: pre;"> </span><span style=3D"white-space: =
pre;"> </span>&nbsp; &nbsp; struct ch_filter_specification *fs,</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">@=
@ -986,6 +1004,7 @@ cxgbe_rtef_parse_items(struct rte_flow *flow,</span></p=
>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;<span style=3D"white-space: pre;"> </span>}</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;<span style=3D"white-space: pre;"> </span>cxgbe_tweak_filter_spec(adap=
, &amp;flow-&gt;fs);</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">+=
<span style=3D"white-space: pre;"> </span>cxgbe_scope_flow_to_port(flow);</=
span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;<span style=3D"white-space: pre;"> </span>cxgbe_fill_filter_region(ada=
p, &amp;flow-&gt;fs);</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue'; min-heigh=
t: 15px;"><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica=
' , sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">&=
nbsp;<span style=3D"white-space: pre;"> </span>return 0;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">-=
-&nbsp;</span></p>
<p style=3D"margin: 0px 0px 0px 0px; font: 13px 'helvetica neue';"><span st=
yle=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">2=
.39.5</span></p>
</div>
<div id=3D"signature-content-no-signature"></div>
<div><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , s=
ans-serif;">&nbsp;</span></div>
<div>
<div id=3D"OLK_SRC_BODY_SECTION">
<div id=3D"OLK_SRC_BODY_SECTION">
<blockquote style=3D"margin: 0 0 0 0.8em; border-left: 1px #ccc solid; padd=
ing-left: 1em;"><hr id=3D"MESSAGE_DATA_MARKER"><span style=3D"font-size: 11=
pt; font-family: 'arial' , 'helvetica' , sans-serif;"><strong>From: </stron=
g>Abdulrahman &lt;ashawi@wirefilter.com&gt;</span><br><span style=3D"font-s=
ize: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;"><strong>To: </=
strong>dev &lt;dev@dpdk.org&gt;</span><br><span style=3D"font-size: 11pt; f=
ont-family: 'arial' , 'helvetica' , sans-serif;"><strong>Cc: </strong>bhara=
t &lt;bharat@chelsio.com&gt;; stable &lt;stable@dpdk.org&gt;</span><br><spa=
n style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif=
;"><strong>Date: </strong>Monday, 27 April 2026 7:30 PM +03</span><br><span=
 style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;=
"><strong>Subject: </strong>[PATCH 0/2] net/cxgbe: fix packed Rx handling a=
nd flow port scoping</span><br><br>
<div style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-se=
rif; color: #000000;">
<div>
<div>
<p><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , san=
s-serif;">This series fixes two correctness issues in the cxgbe PMD that ca=
n cause</span><br><span style=3D"font-size: 11pt; font-family: 'arial' , 'h=
elvetica' , sans-serif;">traffic loss on Chelsio T6 adapters, especially wh=
en rte_flow QUEUE</span><br><span style=3D"font-size: 11pt; font-family: 'a=
rial' , 'helvetica' , sans-serif;">rules concentrate ingress on a small set=
 of RX queues.</span></p>
<p><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , san=
s-serif;">Patch 1 fixes packed Rx response handling. The current PMD assume=
s every</span><br><span style=3D"font-size: 11pt; font-family: 'arial' , 'h=
elvetica' , sans-serif;">response descriptor starts a new Free List buffer =
by requiring</span><br><span style=3D"font-size: 11pt; font-family: 'arial'=
 , 'helvetica' , sans-serif;">F_RSPD_NEWBUF on each response. That assumpti=
on does not always hold for</span><br><span style=3D"font-size: 11pt; font-=
family: 'arial' , 'helvetica' , sans-serif;">packed ingress responses. Unde=
r sustained small-packet traffic to a</span><br><span style=3D"font-size: 1=
1pt; font-family: 'arial' , 'helvetica' , sans-serif;">single ingress queue=
, the FL/IQ state goes out of sync and the affected</span><br><span style=
=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">Rx p=
ath stops making forward progress.</span></p>
<p><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , san=
s-serif;">Patch 2 scopes rte_flow rules to the ingress port they were creat=
ed on.</span><br><span style=3D"font-size: 11pt; font-family: 'arial' , 'he=
lvetica' , sans-serif;">Chelsio filters are programmed in adapter-wide tabl=
es, and the PMD</span><br><span style=3D"font-size: 11pt; font-family: 'ari=
al' , 'helvetica' , sans-serif;">already supports the iport field in the ha=
rdware filter spec. However,</span><br><span style=3D"font-size: 11pt; font=
-family: 'arial' , 'helvetica' , sans-serif;">the flow parser never fills i=
t for normal per-port rules, so a rule</span><br><span style=3D"font-size: =
11pt; font-family: 'arial' , 'helvetica' , sans-serif;">created on one port=
 can also match traffic arriving on sibling ports of</span><br><span style=
=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-serif;">the =
same adapter.</span></p>
<p><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , san=
s-serif;">Both issues reproduce with stock testpmd on T62100-LP-CR. The per=
-patch</span><br><span style=3D"font-size: 11pt; font-family: 'arial' , 'he=
lvetica' , sans-serif;">commit messages include the details and reproducers=
.</span></p>
<p><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , san=
s-serif;">Abdulrahman Alshawi (2):</span><br><span style=3D"font-size: 11pt=
; font-family: 'arial' , 'helvetica' , sans-serif;">net/cxgbe: fix Rx handl=
ing for packed responses</span><br><span style=3D"font-size: 11pt; font-fam=
ily: 'arial' , 'helvetica' , sans-serif;">net/cxgbe: restrict rte_flow rule=
s to ingress port</span></p>
<p><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , san=
s-serif;">.mailmap | 1 +</span><br><span style=3D"font-size: 11pt; font-fam=
ily: 'arial' , 'helvetica' , sans-serif;">drivers/net/cxgbe/base/adapter.h =
| 1 +</span><br><span style=3D"font-size: 11pt; font-family: 'arial' , 'hel=
vetica' , sans-serif;">drivers/net/cxgbe/cxgbe_flow.c | 19 +++++</span><br>=
<span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-s=
erif;">drivers/net/cxgbe/sge.c | 122 ++++++++++++++++++++++++-------</span>=
<br><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sa=
ns-serif;">4 files changed, 118 insertions(+), 25 deletions(-)</span></p>
<p><span style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , san=
s-serif;">--</span><br><span style=3D"font-size: 11pt; font-family: 'arial'=
 , 'helvetica' , sans-serif;">2.39.5</span></p>
</div>
</div>
<div id=3D"signature-content-no-signature"></div>
</div>
</blockquote>
</div>
</div>
</div>
</div>
</blockquote>
</div></div>
</div></body></html>
--=_d7ff3640-e10f-41c0-9c44-83110c995ce1--

