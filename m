Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C6FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9248640679;
	Wed, 29 Apr 2026 11:58:26 +0200 (CEST)
Received: from mx1.wirefilter.com (mx1.wirefilter.com [82.147.223.86])
 by mails.dpdk.org (Postfix) with ESMTP id F4135402EA;
 Mon, 27 Apr 2026 18:42:53 +0200 (CEST)
Received: from egw.wirefilter.com (localhost.localdomain [127.0.0.1])
 by mx1.wirefilter.com (Proxmox) with ESMTP id 3EF98C179E;
 Mon, 27 Apr 2026 19:42:53 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wirefilter.com;
 h=cc:cc:content-type:content-type:date:from:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to; s=default; bh=AZfGARdEQ0adlWEMwvtXXtJTTcohCtMebRwGV8SMnXQ=; b=
 aBKLHCa0YiPkrI/DL7UZZnSH+tPVZimYYJJApiZO0BVOPtnh6be5q8ej5n72Irbn
 ypKElo8jqzoGmINSIP4Vm7hYBX4p1htMntbRncDg3YfXHYPiJBzGT+qkNRBjn4Yu
 IO5yCYEV3q+hvmC7Y/ic+qq/F37BxFnPbEc7kTITKwXLarHH00EptWOdQ/kMGu6a
 6cVMBNjfoqAqqG7Gb30IPF0Q4P6SeJ2HYx7Ze9vl7DxcnJSCmOsD5jsC4l+fkMIe
 /cI5E7aSKC9eUBGxCSV5bt+xExXDl7ze9/CZd2o7N+FKWUnSA9H0e3Ln4gSQN+aZ
 4AbtPmStGnLkkXIeROoPpA==
Date: Mon, 27 Apr 2026 19:42:52 +0300 (AST)
From: Abdulrahman Alshawi <ashawi@wirefilter.com>
To: dev <dev@dpdk.org>
Cc: bharat <bharat@chelsio.com>, stable <stable@dpdk.org>
Message-ID: <48263833.15868423.1777308172969.JavaMail.zimbra@wirefilter.com>
In-Reply-To: <2136264989.15868282.1777307418083.JavaMail.zimbra@wirefilter.com>
References: <2136264989.15868282.1777307418083.JavaMail.zimbra@wirefilter.com>
Subject: [PATCH 2/2] net/cxgbe: restrict rte flow rules to ingress port
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_a413c8da-d1af-44ec-b80c-b5f3e5ca96d9"
X-Originating-IP: [10.1.1.3]
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraModernWebClient - GC147
 (Mac)/10.1.16_GA_4850)
Thread-Topic: net/cxgbe: restrict rte flow rules to ingress port
Thread-Index: vibgbhNHf0ETdtVkwLuwbZrWfuFjrSUCB5/6
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

--=_a413c8da-d1af-44ec-b80c-b5f3e5ca96d9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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

-----Original Message-----

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

--=_a413c8da-d1af-44ec-b80c-b5f3e5ca96d9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-size: 11pt; font-family: arial, helvetica, s=
ans-serif; direction: null; color: #000000;" data-attr=3D"forced_root_block=
_attrs">
<div>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">Chelsio filters are programmed in adapter-wide LE/TCAM tables shared by<=
/span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">all ports. rte_flow rules, however, are created on a specific ethdev and=
</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">are expected to apply to traffic arriving on that port.</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">The PMD already supports ingress-port matching in the hardware filter</s=
pan></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">spec. The iport field is validated, used for hash-region selection when<=
/span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">tp.port_shift is available, and emitted in the firmware filter work</spa=
n></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">request. But the rte_flow parser never sets fs.val.iport/fs.mask.iport</=
span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">for normal per-port rules.</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">As a result, a rule created on one port is installed as an adapter-wide<=
/span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">match and can steer traffic received on sibling ports of the same</span>=
</p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">adapter.</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">In practice this causes cross-port steering. For example, a rule like</s=
pan></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp; vlan 100 -&gt; queue 3</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">created on port 0 can also match VLAN 100 traffic arriving on port 1 and=
</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">redirect it into port 0's queue 3.</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">Fix this by stamping the creating ethdev's physical ingress port into</s=
pan></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">the filter spec before filter placement is decided.</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">Only do this when the active filter mode includes the port field</span><=
/p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">(tp.port_shift &gt;=3D 0). If port matching is not available in the curr=
ent</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">filter mode, keep the existing adapter-wide behavior.</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">Reproduce (two ports of the same adapter bound to DPDK):</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp; dpdk-testpmd -l 1-9 -a 0000:18:00.4 -a 0000:18:00.5 \</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -- --rxq=3D4 --txq=3D4 --forward-mode=
=3Drxonly -i</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp; testpmd&gt; flow create 0 ingress pattern eth \</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; / vlan tci is 100 / end actions=
 queue index 3 / end</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp; testpmd&gt; start</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">Without this patch, VLAN 100 traffic received on port 1 can be steered</=
span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">by the rule created on port 0. With the patch, the rule only matches</sp=
an></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">traffic arriving on port 0.</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">Signed-off-by: Abdulrahman Alshawi &lt;ashawi@wirefilter.com&gt;</span><=
/p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">---</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;.mailmap &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; |&nbsp; 1 +</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;drivers/net/cxgbe/cxgbe_flow.c | 19 +++++++++++++++++++</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;2 files changed, 20 insertions(+)</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">diff --git a/.mailmap b/.mailmap</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">index 0e0d83e1c6..a6bcbd5756 100644</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">--- a/.mailmap</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+++ b/.mailmap</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">@@ -4,6 +4,7 @@ Aaro Koskinen &lt;aaro.koskinen@nsn.com&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;Aaron Campbell &lt;aaron@arbor.net&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;Aaron Conole &lt;aconole@redhat.com&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;Abdullah =C3=96mer Yama=C3=A7 &lt;omer.yamac@ceng.metu.edu.tr&gt; =
&lt;aomeryamac@gmail.com&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+Abdulrahman Alshawi &lt;ashawi@wirefilter.com&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;Abdullah Sevincer &lt;abdullah.sevincer@intel.com&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;Abed Kamaluddin &lt;akamaluddin@marvell.com&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;Abhijit Gangurde &lt;abhijit.gangurde@amd.com&gt;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">diff --git a/drivers/net/cxgbe/cxgbe_flow.c b/drivers/net/cxgbe/cxgbe_fl=
ow.c</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">index 14b9b49792..dd0634131e 100644</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">--- a/drivers/net/cxgbe/cxgbe_flow.c</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+++ b/drivers/net/cxgbe/cxgbe_flow.c</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">@@ -172,6 +172,24 @@ cxgbe_fill_filter_region(struct adapter *adap,</spa=
n></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;<span style=3D"white-space: pre;"> </span>fs-&gt;cap =3D 1;<span s=
tyle=3D"white-space: pre;"> </span>/* use hash region */</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;}</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+static void</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+cxgbe_scope_flow_to_port(struct rte_flow *flow)</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+{</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>struct adapter *adap =3D ethd=
ev2adap(flow-&gt;dev);</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>struct port_info *pi =3D ethd=
ev2pinfo(flow-&gt;dev);</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>/*</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>* Chelsio filters are program=
med in adapter-global tables. DPDK</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>* ingress rte_flow rules are =
created on a specific ethdev, so include</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>* the physical ingress port w=
hen the active filter mode supports it.</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>*/</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>if (adap-&gt;params.tp.port_s=
hift &lt; 0)</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span><span style=3D"white-space: p=
re;"> </span>return;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>flow-&gt;fs.val.iport =3D pi-=
&gt;port_id;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>flow-&gt;fs.mask.iport =3D (1=
U &lt;&lt; IPORT_BITWIDTH) - 1;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+}</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;static int</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;ch_rte_parsetype_eth(const void *dmask, const struct rte_flow_item=
 *item,</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;<span style=3D"white-space: pre;"> </span><span style=3D"white-spa=
ce: pre;"> </span>&nbsp; &nbsp; struct ch_filter_specification *fs,</span><=
/p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">@@ -986,6 +1004,7 @@ cxgbe_rtef_parse_items(struct rte_flow *flow,</span=
></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;<span style=3D"white-space: pre;"> </span>}</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;<span style=3D"white-space: pre;"> </span>cxgbe_tweak_filter_spec(=
adap, &amp;flow-&gt;fs);</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">+<span style=3D"white-space: pre;"> </span>cxgbe_scope_flow_to_port(flow=
);</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;<span style=3D"white-space: pre;"> </span>cxgbe_fill_filter_region=
(adap, &amp;flow-&gt;fs);</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
 min-height: 15.0px;"><span style=3D"font-size: 11pt; font-family: arial, h=
elvetica, sans-serif;">&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">&nbsp;<span style=3D"white-space: pre;"> </span>return 0;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">--&nbsp;</span></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 13.0px 'Helvetica Neue';=
"><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-serif=
;">2.39.5</span></p>
</div>
<div id=3D"signature-content-no-signature" data-marker=3D"__SIG_PRE__"></di=
v>
<div><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-se=
rif;">&nbsp;</span></div>
<div>

<div id=3D"OLK_SRC_BODY_SECTION">
<div id=3D"OLK_SRC_BODY_SECTION">
<blockquote style=3D"margin: 0 0 0 .8em; border-left: 1px #ccc solid; paddi=
ng-left: 1em;"><hr id=3D"MESSAGE_DATA_MARKER"><span style=3D"font-size: 11p=
t; font-family: arial, helvetica, sans-serif;"><strong>From: </strong>Abdul=
rahman &lt;ashawi@wirefilter.com&gt;</span><br><span style=3D"font-size: 11=
pt; font-family: arial, helvetica, sans-serif;"><strong>To: </strong>dev &l=
t;dev@dpdk.org&gt;</span><br><span style=3D"font-size: 11pt; font-family: a=
rial, helvetica, sans-serif;"><strong>Cc: </strong>bharat &lt;bharat@chelsi=
o.com&gt;; stable &lt;stable@dpdk.org&gt;</span><br><span style=3D"font-siz=
e: 11pt; font-family: arial, helvetica, sans-serif;"><strong>Date: </strong=
>Monday, 27 April 2026 7:30 PM +03</span><br><span style=3D"font-size: 11pt=
; font-family: arial, helvetica, sans-serif;"><strong>Subject: </strong>[PA=
TCH 0/2] net/cxgbe: fix packed Rx handling and flow port scoping</span><br>=
<br>
<div style=3D"font-size: 11pt; font-family: 'arial' , 'helvetica' , sans-se=
rif; color: #000000;">
<div>
<div>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-seri=
f;">This series fixes two correctness issues in the cxgbe PMD that can caus=
e</span><br><span style=3D"font-size: 11pt; font-family: arial, helvetica, =
sans-serif;">traffic loss on Chelsio T6 adapters, especially when rte_flow =
QUEUE</span><br><span style=3D"font-size: 11pt; font-family: arial, helveti=
ca, sans-serif;">rules concentrate ingress on a small set of RX queues.</sp=
an></p>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-seri=
f;">Patch 1 fixes packed Rx response handling. The current PMD assumes ever=
y</span><br><span style=3D"font-size: 11pt; font-family: arial, helvetica, =
sans-serif;">response descriptor starts a new Free List buffer by requiring=
</span><br><span style=3D"font-size: 11pt; font-family: arial, helvetica, s=
ans-serif;">F_RSPD_NEWBUF on each response. That assumption does not always=
 hold for</span><br><span style=3D"font-size: 11pt; font-family: arial, hel=
vetica, sans-serif;">packed ingress responses. Under sustained small-packet=
 traffic to a</span><br><span style=3D"font-size: 11pt; font-family: arial,=
 helvetica, sans-serif;">single ingress queue, the FL/IQ state goes out of =
sync and the affected</span><br><span style=3D"font-size: 11pt; font-family=
: arial, helvetica, sans-serif;">Rx path stops making forward progress.</sp=
an></p>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-seri=
f;">Patch 2 scopes rte_flow rules to the ingress port they were created on.=
</span><br><span style=3D"font-size: 11pt; font-family: arial, helvetica, s=
ans-serif;">Chelsio filters are programmed in adapter-wide tables, and the =
PMD</span><br><span style=3D"font-size: 11pt; font-family: arial, helvetica=
, sans-serif;">already supports the iport field in the hardware filter spec=
. However,</span><br><span style=3D"font-size: 11pt; font-family: arial, he=
lvetica, sans-serif;">the flow parser never fills it for normal per-port ru=
les, so a rule</span><br><span style=3D"font-size: 11pt; font-family: arial=
, helvetica, sans-serif;">created on one port can also match traffic arrivi=
ng on sibling ports of</span><br><span style=3D"font-size: 11pt; font-famil=
y: arial, helvetica, sans-serif;">the same adapter.</span></p>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-seri=
f;">Both issues reproduce with stock testpmd on T62100-LP-CR. The per-patch=
</span><br><span style=3D"font-size: 11pt; font-family: arial, helvetica, s=
ans-serif;">commit messages include the details and reproducers.</span></p>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-seri=
f;">Abdulrahman Alshawi (2):</span><br><span style=3D"font-size: 11pt; font=
-family: arial, helvetica, sans-serif;">net/cxgbe: fix Rx handling for pack=
ed responses</span><br><span style=3D"font-size: 11pt; font-family: arial, =
helvetica, sans-serif;">net/cxgbe: restrict rte_flow rules to ingress port<=
/span></p>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-seri=
f;">.mailmap | 1 +</span><br><span style=3D"font-size: 11pt; font-family: a=
rial, helvetica, sans-serif;">drivers/net/cxgbe/base/adapter.h | 1 +</span>=
<br><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-ser=
if;">drivers/net/cxgbe/cxgbe_flow.c | 19 +++++</span><br><span style=3D"fon=
t-size: 11pt; font-family: arial, helvetica, sans-serif;">drivers/net/cxgbe=
/sge.c | 122 ++++++++++++++++++++++++-------</span><br><span style=3D"font-=
size: 11pt; font-family: arial, helvetica, sans-serif;">4 files changed, 11=
8 insertions(+), 25 deletions(-)</span></p>
<p><span style=3D"font-size: 11pt; font-family: arial, helvetica, sans-seri=
f;">--</span><br><span style=3D"font-size: 11pt; font-family: arial, helvet=
ica, sans-serif;">2.39.5</span></p>
</div>
</div>
<div id=3D"signature-content-no-signature"></div>
</div>
</blockquote>
</div>
</div></div>
</div></body></html>
--=_a413c8da-d1af-44ec-b80c-b5f3e5ca96d9--

