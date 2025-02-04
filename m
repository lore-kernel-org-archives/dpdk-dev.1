Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D54C02197
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 13:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F56640E0C;
	Tue,  4 Feb 2025 14:42:38 +0100 (CET)
Received: from PNYPR01CU001.outbound.protection.outlook.com
 (mail-centralindiaazon11020139.outbound.protection.outlook.com
 [52.101.225.139])
 by mails.dpdk.org (Postfix) with ESMTP id DEE044025D
 for <dev@dpdk.org>; Tue,  4 Feb 2025 14:42:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlAh+0nkfJJW0/kcRRVwxfB8fGMVUIhAMwVPt/PlQEgeXZMDQvH5j+GHp++t/HpOcWSX2EmwGWntpFdpsvRSXu1Y1FxvTHgx+l/dSFuEgn55aiO/doE6rMogb6y9qMWvv9yplNuqSBcwdZOpyq82GJkmpzLkP83Mt/snSKNaKGAgKmXoAzdLut6U/9oI2W7EMApZnblGam+IW2bO1VKLxurEZ8yzTXSwI+PLnYNJ+/kI7u9KvkFTS1EW8CrgF2D9UqwUvmLpAUpi1LLFumAgWq1SaXIBpphzK/eVdqNAn4pb7q21Suox/Kz0ch8jwtN7ZuAtMeGv3zRhnwdKE4M5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF86wvWYiBMpvCO3ZPuuSR6kzDw5BHf2/5FmUWlI5JM=;
 b=qDTNb9dMJNJScxOINPzduGS+raHOY+vVovb3UGBAg92uwgEyqZnNkJMM3WdONVzbA5CBWOsMMQ+UvNTzlglNsYIGuydCwdJ/f2VusZDgrCm7eLLzNmz3No3tlp9mLf8pOXg/C276hXT/7/MozmW65zuTTxInAcIvUIeJomiYsRL2wztG2wkaaRlFGt6nXWxNAaX4IS2QYCv+f4DWj2R+1TVRyr0xd/teSOAKS2Y2UzknJFvHv4w9ivK3fKtt4CADfREcnc3M19ZkpOoO7gy3GDSkqew4C3CMpLnBRSjnSYPJC5OOovwuN8y5MKnZHDWp0CJgs1t1M0qeFz7mkYOUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF86wvWYiBMpvCO3ZPuuSR6kzDw5BHf2/5FmUWlI5JM=;
 b=FPQUVrMRjbg2SV4ZuXcGQluRi2sCc0Mya7U+q+dhvgVU3lD2NsVH8MQ8+0/7sqphjzb7/oWxHondu9j0zy8MPAkxwrGxEpUOdp+hxv8vvTc9QWMQOcUIvj6JD5LsuYGpf+M5KE1aFYac4hKJZ2yfBEedwQeK0SrLCeqHhwGtYiepYWS44Oh8txSEb2D5Amrr4ekUMiFxCFTCqU7H4UMa4bzFHQa2Osku0n+DbEs/0Fuczc21kM1QVpDMOoL4XwM2BMn5jv/lhI8CzRRKPEfoyhsPTRjtECye2HSL28JdkGU/K+i1s4WCsPoeO4g1Di1So2dGycYgAngGQMMEfD3fZA==
Received: from PN2P287MB2223.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c5::6)
 by PN3P287MB0718.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 13:42:34 +0000
Received: from PN2P287MB2223.INDP287.PROD.OUTLOOK.COM
 ([fe80::9cdf:cdbc:610c:f86c]) by PN2P287MB2223.INDP287.PROD.OUTLOOK.COM
 ([fe80::9cdf:cdbc:610c:f86c%5]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 13:42:34 +0000
From: Nafiah Siddiqha <nafiah.siddiqha@iwave-global.com>
To: "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "Luca.Vizzarro@arm.com" <Luca.Vizzarro@arm.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "andremue@linux.microsoft.com"
 <andremue@linux.microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>
CC: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Subject: Testing dpdk application using openNIC driver
Thread-Topic: Testing dpdk application using openNIC driver
Thread-Index: AQHbdwieBzBv9VzRV0qcI7ssGAO7mQ==
Date: Tue, 4 Feb 2025 13:42:34 +0000
Message-ID: <PN2P287MB22230CF53B6310DB7F70FF39D3F42@PN2P287MB2223.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB2223:EE_|PN3P287MB0718:EE_
x-ms-office365-filtering-correlation-id: 58dc46fe-c623-48f3-c930-08dd4521c79a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7h3NbNXTlTKlEbvSZVzQ23IThhKJGQaG8Ho5QzjgXzWkYS9Dmv5V11TSqu?=
 =?iso-8859-1?Q?cgI1h3GEPTXqylguoFZHem0IYwkxuYZHgckcP+C7g4oIGX49llO3vpKBm8?=
 =?iso-8859-1?Q?hI+jNzOKXicloMw66mupRkFNHDmwnuCDiP8y47V//ATEYRr5AkMBl3doxf?=
 =?iso-8859-1?Q?XTYOr/Pa5uAEqb/7hS7WudRcMfqDZS7jGv0JVfv+jTnxgOL+QZ10xmj2j2?=
 =?iso-8859-1?Q?sFoDl/1gf3FPyLweMrN4QlE+M+tYzqIp0o8SfArnsYneFN3ynR+lg1i3NO?=
 =?iso-8859-1?Q?lTlV0p/IP6siWbJ28hK1nKJ0J8e8JENcHdkSOdL+uQTl82RKn/fNb+dW/N?=
 =?iso-8859-1?Q?C0FW6Qck4vXyLGJFrG1gUT2jTehI7DSLqxW+ER4Q307HZnwAxElkoN0oiw?=
 =?iso-8859-1?Q?xU8FMaYDmi2p58nEjwGZPLA/PzKOC3P4Y2xz1jLMvJIF5TuqWQD63vtzC8?=
 =?iso-8859-1?Q?jp6uQcrGL7Ua+RPBR9prcioT42r91ZK35qp183uwGKd+hFyYrJrPfUu72F?=
 =?iso-8859-1?Q?t2ofIA8yel7HqbpzDMvEUi5nDXE4k8WeRhp9YfqNzwym472ArIdPn9g1P5?=
 =?iso-8859-1?Q?kNWbbw9dMUhNx+r0iO2/dsyUb6REjjd9mlj8iL1NQe6/bjHUjgRRR8BloS?=
 =?iso-8859-1?Q?pEGDg6A+c/Uq2bplT555KdiagYFqDIf5huRATxSsTKzEKhgg4Zj4qY1mpR?=
 =?iso-8859-1?Q?4dyU+U6+SDGmqdHZ6giIbF//wdrYDk6sf5La7W5MjLCqKljyjzVd5wN7Hv?=
 =?iso-8859-1?Q?Ic8MJGghc7hirWZaaHJuYGl+PoovBHMhvpl9vd59g7nC8XD5zaaF9aIxxJ?=
 =?iso-8859-1?Q?7BwMldfW7Qt/9fSW8RP4niTjFz36v6hnBTEC8ij0RDG9iel94tYlzToi0w?=
 =?iso-8859-1?Q?DIms/SvdUUaqBH506p5Qyw8e5dMUaK81JEyLKTJBR4omtgdS71etIkQVzI?=
 =?iso-8859-1?Q?q4Xmo/6IfPagIB0A2/smPtHMcKHOmcu3b9Awu7Ld67ZmAijIZ+oQcsXsiS?=
 =?iso-8859-1?Q?ruh58ED5EkO1bRhAuBnbSglnH85mVdim8qoCztNffozuLxreZnEoWER5vE?=
 =?iso-8859-1?Q?/NOF9qTKUaiuDl9HUCDlsazvuAPtXtV3/hGI/WG87hBrI/80A0HK13/S8j?=
 =?iso-8859-1?Q?nVVZPYkchNzy7HddplYup+0LElNQK5kut5yxjZd1z85TBrUe+owmkm6KRj?=
 =?iso-8859-1?Q?rjffayv7wSpnPzP+oxfpGyP1FzdFqTpgPUTh7si8qOtAfpSkEOeJyN/VCr?=
 =?iso-8859-1?Q?cWGcwVjzHDOd4h3r7VkCvr2vAW3S1Q79eU6DikKQlWPA5uUInfwq5j4zCk?=
 =?iso-8859-1?Q?RUqtEIrYiParL0I2FTU51nRN9O7Roz5WWRnPMtw7kA1dcoQn74hlohgNu2?=
 =?iso-8859-1?Q?Ia4W21aglzCWDlRv0J1l86GGXxuywIUV2Csn3Dg8VJDPgrgyOI+agwKXZB?=
 =?iso-8859-1?Q?FTWcRhJGBUAk18nDY/Ryiah6j68Jo5syMccKoeByqW76ZHRLJOhEYSp+rH?=
 =?iso-8859-1?Q?ezo93kB6tuMFwpAn553Wi9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN2P287MB2223.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BBSUBBflY6Jnz15ThffchfN5UG1H72kSjw4NpKH7S0ZWWkq/1gdoVuvR0p?=
 =?iso-8859-1?Q?cYT0Ty4XXNuPiI3eYXH7qHZAboySSmbRI549/HHhVEil7In3ML0i/GY1qi?=
 =?iso-8859-1?Q?NEaknttfcRq1xIxF8Uj4if31NsUfzYqGvpSa2vsXNMPSvw1e/2Iu4v1K/p?=
 =?iso-8859-1?Q?sDCdaYrPOHg2vLp2wpI2vjCDQodPjS0AL1ZLORY7bE2bzMsRvF6RmY2NQ0?=
 =?iso-8859-1?Q?o65jvKHwMIILRtkNW3HycO0FIUWN1koYOaem1FzXhIBrIBuAsfeSyZDv5f?=
 =?iso-8859-1?Q?4m9BhYnlzSDiCpx1CyOxOY9YXmXCYwN1H9arayjiSz9kPaVBoepKlbxtm1?=
 =?iso-8859-1?Q?r73wi+cIV5Mw6nwpgvR4A4vNM0+nu5rfmjf887Ef0mlIY1tT9mjXYLUM20?=
 =?iso-8859-1?Q?1aO8/O26Z92iaiYjYk3NsTwrHv8tDPmg1TD9GZ2qrSa09wVhzWsFCb5HTh?=
 =?iso-8859-1?Q?j6BXrX1VF8cx3yC2SAqYiiCTulXZ3r8H68ERcAFSgOIVjGYSDDyqddXnca?=
 =?iso-8859-1?Q?iw/obh7LSiQK6zwwMeCIbX/dC0IoIP3Zg5HLV+0mdHG28xjP1XaLZCyUxL?=
 =?iso-8859-1?Q?VAMS+jqdaLzYuoyUWmihG3NtuRcFAyHP21ufTDtPGexf3Jk5YCaY92oqyp?=
 =?iso-8859-1?Q?D2gfSd6P3p+jOY3hPBlerI/z4YjKWN6Jto7a3KCwSbFZmbasOGNeqVdjEa?=
 =?iso-8859-1?Q?kqbNVJAhzJ9bjxXofWOvFU8nWeeYt0sA5iJifkzYU2FWTZC8YqJoEv13ja?=
 =?iso-8859-1?Q?hJIaEES3It/Ah0smjUT0SGSfez/VBlpC3OWZlFPDr4Uvyj0K78Z26FV2Ky?=
 =?iso-8859-1?Q?e2O4h6cO6cg981NzcFqrRpDONk4l+BOdBUfXTYple3tcUirNVmlCSt203q?=
 =?iso-8859-1?Q?VkEEL2GTi/mZQi1YVVU2k57ldFNb4AV9wTUSIcdOYNQ8HqZSZvOkwEBUhQ?=
 =?iso-8859-1?Q?aDqOhJD4cD+aeZicl2ODo7JnG32F7JqgV5OmWtEitYaFjCP99XkUUwt4Lz?=
 =?iso-8859-1?Q?RbqkOExCLtjpT51xwFFa7Cl9b5JWZtFgtZBArHea8TK8jlRUzyd7Ar64GY?=
 =?iso-8859-1?Q?bVOHgfGzQ38f/Ms0BYljUWR0TPkQps0/BrhQIsoFWQolKAqLU8nYWqx1oY?=
 =?iso-8859-1?Q?Y4Pdo+Qt1lyf55LHj+D1c0A5w3GgU+umMBSaRXNtxtQr9K+9K+xnTnixs2?=
 =?iso-8859-1?Q?ldwntHjZ8HED9XPG+hBpA8ZPWGQGw7ovOTfoaEWkOK6Jy8pGijj0qhCIF1?=
 =?iso-8859-1?Q?X26TFSioTnVzm1hy5yT8pQrm5PVWfWDVUq68i0jXLXryu3BeMLsHUa7c2v?=
 =?iso-8859-1?Q?QcejwSDHPxLXRhDHNdBWG0o6cBcnT03DnxxrYxTliohVVJ8g3XgTSORcZh?=
 =?iso-8859-1?Q?I9II06ESV+E75Cvj1aaUddFdfN57Ricdkc1AnJj1jeTlY8O8KtNqVKPKlU?=
 =?iso-8859-1?Q?3MCctwcZTex08+uz30XkkaLX3Hx2i+lufAFjhVILYUWc25oS/DUf7BMT5C?=
 =?iso-8859-1?Q?qRju2XLii6xdvSoO/RvVJiJdqN8kCE0RmFCCxrAaW2SjNL+tKaSA9AKMY6?=
 =?iso-8859-1?Q?laY4zBjugO4kit7Ag377iNaKiPe+/WGBevohn/bQNaasMAvwdXa1O/JuzJ?=
 =?iso-8859-1?Q?vAxPxgbAffG5wbftKSysuGb20lVhMj/dGCTc3yG+mJD70jK23Zx54WKg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN2P287MB22230CF53B6310DB7F70FF39D3F42PN2P287MB2223INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB2223.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dc46fe-c623-48f3-c930-08dd4521c79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 13:42:34.1129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3lRB9hQtwwdaMhETYodcax5FyYP8JYx4tnTDKb1Y84jTXgZwjeyV/nFpMgIw5vVTaIlLQtzvfbv0/TIJB/g6bZFI0X9XKI/FaN06mm/8ckMuxssWskE9635xllOjURF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0718
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

--_000_PN2P287MB22230CF53B6310DB7F70FF39D3F42PN2P287MB2223INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I'm testing pktgen application using OpenNIC driver, but I face device cann=
ot parse issue ,
What do I need to pass in my vdev parameter for it to run

Below are the logs of the error I'm facing
$sudo ./usr/local/bin/pktgen --vdev 'eth_af_packet0,iface=3Denp1s0f0' --vde=
v 'eth_af_packet1,iface=3Denp1s0f1'   -l 2-10 -n 4  -- -m [3:4].0 -m [6:7].=
1
Copyright(c) <2010-2021>, Intel Corporation. All rights reserved. Powered b=
y DPDK
EAL: Detected 12 lcore(s)
EAL: Detected 1 NUMA nodes
EAL: failed to parse device "eth_af_packet0"
EAL: Unable to parse device 'eth_af_packet0,iface=3Denp1s0f0'


I have tried passing eth_pcap, net_pcap and net_af_packet as well but there=
's no progress in the output.

Thanks in advance
Best Regards
Nafiah Siddiqha


--_000_PN2P287MB22230CF53B6310DB7F70FF39D3F42PN2P287MB2223INDP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi,<br>
I'm testing pktgen application using OpenNIC driver, but I face device cann=
ot parse issue ,<br>
What do I need to pass in my vdev parameter for it to run<br>
<br>
Below are the logs of the error I'm facing<br>
$sudo ./usr/local/bin/pktgen --vdev 'eth_af_packet0,iface=3Denp1s0f0' --vde=
v 'eth_af_packet1,iface=3Denp1s0f1' &nbsp; -l 2-10 -n 4 &nbsp;-- -m [3:4].0=
 -m [6:7].1<br>
Copyright(c) &lt;2010-2021&gt;, Intel Corporation. All rights reserved. Pow=
ered by DPDK</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
EAL: Detected 12 lcore(s)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
EAL: Detected 1 NUMA nodes</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
EAL: failed to parse device &quot;eth_af_packet0&quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
EAL: Unable to parse device 'eth_af_packet0,iface=3Denp1s0f0'<br>
<br>
<br>
I have tried passing eth_pcap, net_pcap and net_af_packet as well but there=
's no progress in the output.<br>
<br>
Thanks in advance&nbsp;<br>
Best Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Nafiah Siddiqha<br>
<br>
</div>
</body>
</html>

--_000_PN2P287MB22230CF53B6310DB7F70FF39D3F42PN2P287MB2223INDP_--
