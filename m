Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5C0C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 07:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1BDC40677;
	Mon, 24 Mar 2025 08:44:45 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3B2A040674
 for <dev@dpdk.org>; Mon, 24 Mar 2025 08:44:44 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1C380204FE;
 Mon, 24 Mar 2025 08:44:44 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----_=_NextPart_001_01DB9C90.9BBB4E36"
Subject: RE: [PATCH] app/testpmd: fix VLAN header parsing
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 24 Mar 2025 08:44:42 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB42@smartserver.smartshare.dk>
In-Reply-To: <CH3PR12MB8460B2A2A61615F589182A32CFA42@CH3PR12MB8460.namprd12.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Index: AQHbm+8qBy++gaakq0m8DcV6iO248LOAszuAgAEyu+qAAAERkA==
References: <20250323122822.90407-1-rasland@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB3D@smartserver.smartshare.dk>
 <CH3PR12MB8460B2A2A61615F589182A32CFA42@CH3PR12MB8460.namprd12.prod.outlook.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Raslan Darawsheh" <rasland@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<haijie1@huawei.com>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01DB9C90.9BBB4E36
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Comment inline below.

=20

From: Raslan Darawsheh [mailto:rasland@nvidia.com]=20
Sent: Monday, 24 March 2025 08.35

=20

>> From: Raslan Darawsheh [mailto:rasland@nvidia.com]
>> Sent: Sunday, 23 March 2025 13.28
>>=20
>> Updated the `get_ethertype_by_ptype` function to correctly parse VLAN
>> headers.
>>=20
>> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
>> Cc: haijie1@huawei.com
>>=20
>>> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
>> ---
>>  app/test-pmd/csumonly.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
>> index 5b906eaa53..302cc4cc66 100644
>> --- a/app/test-pmd/csumonly.c
>> +++ b/app/test-pmd/csumonly.c
>> @@ -468,6 +468,7 @@ get_ethertype_by_ptype(struct rte_ether_hdr
>> *eth_hdr, uint32_t ptype)
>>  {
>>        struct rte_vlan_hdr *vlan_hdr;
>>        uint16_t ethertype;
>> +     uint32_t i =3D 0;
>>=20
>>        switch (ptype) {
>>        case RTE_PTYPE_L3_IPV4:
>> @@ -486,10 +487,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr
>> *eth_hdr, uint32_t ptype)
>>                return _htons(RTE_ETHER_TYPE_IPV6);
>>        default:
>>                ethertype =3D eth_hdr->ether_type;
>> -             while (eth_hdr->ether_type =3D=3D =
_htons(RTE_ETHER_TYPE_VLAN)
>> ||
>> -                     eth_hdr->ether_type =3D=3D =
_htons(RTE_ETHER_TYPE_QINQ)) {
>> +             while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||
>> +                     ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {
>>                        vlan_hdr =3D (struct rte_vlan_hdr *)
>> -                             ((char *)eth_hdr + sizeof(*eth_hdr));
>> +                             ((char *)eth_hdr + sizeof(*eth_hdr) +
>> +                             (i * sizeof(struct rte_vlan_hdr)));

>Doesn't work; "i" is not incremented, and remains 0.
>Instead do this: Initialize (struct rte_vlan_hdr =
*)vlan_hdr=3DRTE_PTR_ADD(eth_hdr, offsetof(rte_ether_hdr, ether_type)) =
before the loop, and move vlan_hdr+=3DRTE_VLAN_HLEN inside the loop.
Yes you are correct I had a (i++ *) but must have slipped while rebasing =
will handle your way in v2=20

MB: Noticed a bug in my suggestion: Due to the type of vlan_hdr, moving =
it should be vlan_hdr++, not vlan_hdr+=3DRTE_VLAN_HLEN.

MB: And you might want to impose a maximum boundary to the loop, as =
suggested by Stephen. E.g. break out of the loop if =
vlan_hdr>RTE_PTR_ADD(eth_hdr, offsetof(rte_ether_hdr, =
ether_type)+4*sizeof(struct rte_vlan_hdr)). Supporting up to 4 stacked =
VLAN tags should suffice.


>>                        ethertype =3D vlan_hdr->eth_proto;
>>                }
>>                return ethertype;
>> --
>> 2.39.5 (Apple Git-154)

=20

Kindest regards

Raslan Darawsheh


------_=_NextPart_001_01DB9C90.9BBB4E36
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Microsoft Word =
12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:Aptos;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Aptos;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple style=3D'word-wrap:break-word'><div =
class=3DWordSection1><div><p class=3DMsoNormal><a =
name=3D"_MailEndCompose"><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Comment inline below.</span></a><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p></o:p></span></p></div><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><div =
style=3D'border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt'><div><div style=3D'border:none;border-top:solid #B5C4DF =
1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt'><b><span =
style=3D'font-family:"Tahoma","sans-serif"'>From:</span></b><span =
style=3D'font-family:"Tahoma","sans-serif"'> Raslan Darawsheh =
[mailto:rasland@nvidia.com] <br><b>Sent:</b> Monday, 24 March 2025 =
08.35<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div =
id=3Dmail-editor-reference-message-container><div><div><div><p =
class=3DMsoNormal =
style=3D'mso-margin-top-alt:0cm;margin-right:0cm;margin-bottom:12.0pt;mar=
gin-left:36.0pt'><span style=3D'font-size:11.0pt'>&gt;&gt; From: Raslan =
Darawsheh [<a =
href=3D"mailto:rasland@nvidia.com">mailto:rasland@nvidia.com</a>]<br>&gt;=
&gt; Sent: Sunday, 23 March 2025 13.28<br>&gt;&gt; <br>&gt;&gt; Updated =
the `get_ethertype_by_ptype` function to correctly parse =
VLAN<br>&gt;&gt; headers.<br>&gt;&gt; <br>&gt;&gt; Fixes: 76730c7b9b5a =
(&quot;app/testpmd: use packet type parsing API&quot;)<br>&gt;&gt; Cc: =
haijie1@huawei.com<br>&gt;&gt; <br>&gt;&gt;&gt; Signed-off-by: Raslan =
Darawsheh &lt;rasland@nvidia.com&gt;<br>&gt;&gt; ---<br>&gt;&gt;&nbsp; =
app/test-pmd/csumonly.c | 8 +++++---<br>&gt;&gt;&nbsp; 1 file changed, 5 =
insertions(+), 3 deletions(-)<br>&gt;&gt; <br>&gt;&gt; diff --git =
a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c<br>&gt;&gt; index =
5b906eaa53..302cc4cc66 100644<br>&gt;&gt; --- =
a/app/test-pmd/csumonly.c<br>&gt;&gt; +++ =
b/app/test-pmd/csumonly.c<br>&gt;&gt; @@ -468,6 +468,7 @@ =
get_ethertype_by_ptype(struct rte_ether_hdr<br>&gt;&gt; *eth_hdr, =
uint32_t ptype)<br>&gt;&gt;&nbsp; =
{<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
rte_vlan_hdr =
*vlan_hdr;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint16_t ethertype;<br>&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D =
0;<br>&gt;&gt; <br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch (ptype) {<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case RTE_PTYPE_L3_IPV4:<br>&gt;&gt; @@ -486,10 +487,11 @@ =
get_ethertype_by_ptype(struct rte_ether_hdr<br>&gt;&gt; *eth_hdr, =
uint32_t =
ptype)<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
_htons(RTE_ETHER_TYPE_IPV6);<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =
default:<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethertype =3D =
eth_hdr-&gt;ether_type;<br>&gt;&gt; =
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 while (eth_hdr-&gt;ether_type =3D=3D =
_htons(RTE_ETHER_TYPE_VLAN)<br>&gt;&gt; ||<br>&gt;&gt; =
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_hdr-&gt;ether_type =
=3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {<br>&gt;&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||<br>&gt;&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethertype =3D=3D =
_htons(RTE_ETHER_TYPE_QINQ)) =
{<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; vlan_hdr =3D (struct rte_vlan_hdr *)<br>&gt;&gt; =
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + =
sizeof(*eth_hdr));<br>&gt;&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + sizeof(*eth_hdr) =
+<br>&gt;&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; (i * sizeof(struct =
rte_vlan_hdr)));<br><br>&gt;Doesn't work; &quot;i&quot; is not =
incremented, and remains 0.<br>&gt;Instead do this: Initialize (struct =
rte_vlan_hdr *)vlan_hdr=3DRTE_PTR_ADD(eth_hdr, offsetof(rte_ether_hdr, =
ether_type)) before the loop, and move vlan_hdr+=3DRTE_VLAN_HLEN inside =
the loop.<br>Yes you are correct I had a (i++ *) but must have slipped =
while rebasing will handle your way in v2 <span =
style=3D'color:#1F497D'><o:p></o:p></span></span></p><p =
class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>MB: Noticed a bug in my suggestion: Due to the type of vlan_hdr, =
moving it should be vlan_hdr++, not =
vlan_hdr+=3DRTE_VLAN_HLEN.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt'><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>MB: And you might want to impose a maximum boundary to the loop, as =
suggested by Stephen. E.g. break out of the loop if =
vlan_hdr&gt;RTE_PTR_ADD(eth_hdr, offsetof(rte_ether_hdr, =
ether_type)+4*sizeof(struct rte_vlan_hdr)). Supporting up to 4 stacked =
VLAN tags should suffice.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'mso-margin-top-alt:0cm;margin-right:0cm;margin-bottom:12.0pt;mar=
gin-left:36.0pt'><span =
style=3D'font-size:11.0pt'><br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethertype =3D =
vlan_hdr-&gt;eth_proto;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ethertype;<br>&gt;&gt; =
--<br>&gt;&gt; 2.39.5 (Apple Git-154)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span =
style=3D'font-size:11.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span =
style=3D'font-size:11.0pt'>Kindest regards<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'margin-bottom:12.0pt'><span =
style=3D'font-size:11.0pt'>Raslan =
Darawsheh<o:p></o:p></span></p></div></div></div></div></div></div></body=
></html>
------_=_NextPart_001_01DB9C90.9BBB4E36--
