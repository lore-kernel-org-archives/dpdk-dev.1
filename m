Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0230ACAC5BD
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Sep 2025 01:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D921B402EA;
	Sun, 28 Sep 2025 03:52:57 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23]) by mails.dpdk.org (Postfix) with ESMTP id 09325402DD
 for <dev@dpdk.org>; Sun, 28 Sep 2025 03:52:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQAceoNHE03KBoJoVcKvgsEQJoUf8ANxuB/HRvrwzWbbv9nVkL1jB4UAv3x4ZTIhqjLB44qi6fIos/SXNau81fDI5KzS9lLlv7AHW3j4466uBkfQQTLUe0dCcr7+tGMLa5YwxvCrsPMD0SeShVq0oS3y+QQTFNUpzo/pwr15ZSOyus8rDrhKt79q6b6WQ6ZHNTRh+BT30G1gr6NU9AxZycvd+1zZPYiND4wUDG1PRq+haIhEKmJUBAUIzH2BNzRqWhSKfF7CS5tea5e3ZG/lx9etKh45BssfCq8sCRrGFIzhAmUP9nNl5xkvIWPNXPz+qliTzEP+ESVG2TIzfqpZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgQ9Q//LTcpHWjbdxwDA2tOweFlXu3gPRbd1f7J0OiI=;
 b=KKH9Qoh2GEOot8GM15DBs/oAHnMimzqG5O9FiROXZLK41RtJlK9r001HY/CIcgvfHPch50R5zsUjJcv+XAoktDas7FngkyMlS/45BoskLpl1c0kH7Y1XY37Vb8AQbQ1FSez/ECp5iE+z/nizUb6NIp5vftCnR0sKMoCs3nKjKifyVrgMDIjqpYpj+PjazET0QWCzJFOP1gt9uPFVJzod0FNDv4hF3tPyJq5khFRB8AOtpCgDom9uk5mePZZvE+NOGSkLOyjbkn58+8iXJ/n7h1v8SZ2YIfZUuvigSxTwOawriYMROVRhwGPWg/9xrPe7kU0VINICY1j0Wvv8pKgP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgQ9Q//LTcpHWjbdxwDA2tOweFlXu3gPRbd1f7J0OiI=;
 b=HlNd3oQwWMW+L0GJr13yneEWjAI14CUUuVDwdheueG7Et6s1boWO+ufkieyASENDM25QNsBrlklFnANyC3el/2/Cijh8UtzdyPXhhbK0J4jal3AwA/HAGOGOuN9fAcvBIP7TidHgipwYg7Xcw57amBslTW+/7BsXAwFj8fwMyIwyMCEXyBylYBu2JDoWQhT26+mhkKHIDRzSOqupEsuxUm3EourMMWNNxJZesCKAQ38dZcmTK+F+2kCe7jukn+Hbr+YLrjiJlso9OA//IeOMaQSPmWOGeW4uXm1rPH0lLYfRNZp/vi9QaIsYlQ56Uo1GNhV5kp0dKy+DaDF7Z4YWLA==
Received: from CH2PR03MB5239.namprd03.prod.outlook.com (2603:10b6:610:a2::21)
 by CH0PR03MB5954.namprd03.prod.outlook.com (2603:10b6:610:e1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 01:52:52 +0000
Received: from CH2PR03MB5239.namprd03.prod.outlook.com
 ([fe80::7fea:1069:aa12:4792]) by CH2PR03MB5239.namprd03.prod.outlook.com
 ([fe80::7fea:1069:aa12:4792%6]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 01:52:52 +0000
From: "Xu, Rosen" <rosen.xu@altera.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [RFC 3/6] raw/ifpga: avoid use of pthread_cancel
Thread-Topic: [RFC 3/6] raw/ifpga: avoid use of pthread_cancel
Thread-Index: AQHcLXQSWMr0MdNoQEyuTyusY7Km77Sn2jaC
Date: Sun, 28 Sep 2025 01:52:52 +0000
Message-ID: <CH2PR03MB52394B11C758A4F637484146FC18A@CH2PR03MB5239.namprd03.prod.outlook.com>
References: <20250924165527.268645-1-stephen@networkplumber.org>
 <20250924165527.268645-4-stephen@networkplumber.org>
In-Reply-To: <20250924165527.268645-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR03MB5239:EE_|CH0PR03MB5954:EE_
x-ms-office365-filtering-correlation-id: 52ab57cf-5509-4e30-ef23-08ddfe31bcaf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|39142699007|376014|31052699007|1800799024|38070700021|7053199007|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BhbS1oyWQqlyNabG3BsYikumo56NUVKS2PVEaGvpJayjY7yvznkkdhYwmi?=
 =?iso-8859-1?Q?xAjrnchi15aXEBNHyw9evRoZKG8je+Qlp58+OhNJrk0BvOALkqPcXJFati?=
 =?iso-8859-1?Q?YswBTRV+Cqx171P1r2n8HJWVNu/i34KbBAhzzaM98vp2uwuQWGxkjyhL9W?=
 =?iso-8859-1?Q?Fb6x/asBDPPrlzCr1gpyDqXyFZ7x5aLkZVTMvGUlELLBIvWb1jSGh0bJTg?=
 =?iso-8859-1?Q?syTgmjJWfV28cEYsEq6fQr+t3W9uizQWSd5kcXznlrmz4Xrhhj8QeeRZ/H?=
 =?iso-8859-1?Q?mskYt42rFwUggR/k8XJYUKyT4L2fwU/GDdztEA98ZKRSWq1FnoXG7BFVgH?=
 =?iso-8859-1?Q?OcMXx8AVR/4FYnhzZTs0j1Un+sOhbEXsNWdFId6HgDalGtqgohbJDtFoVZ?=
 =?iso-8859-1?Q?KGYfG18mb9MFbcc7qFClxDJXlbhwevnCXYfGXM2i0wChxRLgshw+YWYZIB?=
 =?iso-8859-1?Q?f/PbWO/P0Ix1JHFDCGpNU36jUayYN1TR0sSZ2GfofZH29nmfaSTRybW0Ow?=
 =?iso-8859-1?Q?3x2PHijNqBbm5F61kD1wQ2IPOuHdPkLUldzHNiVPtNFD9aKPIse7Xby+XV?=
 =?iso-8859-1?Q?beaA35aF0DYvms4hHddbmT+aQq5SJrrEugaPE3gY8cuvwwLSNMhfafL1F+?=
 =?iso-8859-1?Q?kNXmXuraIVqMIYNvu4nPxi720gwqF4UwLZYDpwzq1Tu2XsGEz+dEOKCAyX?=
 =?iso-8859-1?Q?Z7A8Nx5FdUl5Ujkbj9u/2i3iQXHGRn5U00Ne1GrLl/utGNtuf5jDTe6Hlo?=
 =?iso-8859-1?Q?zYV3IVd7815PfMPSVNloVpj7N7sfTWfHd3E2W/EpcxExzYzF95mYSa8Fmg?=
 =?iso-8859-1?Q?PShGgEghAp6Gfxc5/Hm51BBB5EjHsmaQ5NmF0QROayXJQsIm6aPlwVsuyi?=
 =?iso-8859-1?Q?L2gDkKQfQR+AaeTa4FnDsqJ0rrtFRMFMMpTIkTI6VZJiGWPjTgl+B8wVbb?=
 =?iso-8859-1?Q?Da4+aYkNVdPsCcLS0zMuRG0qztTMX4tp+eqQsugJ2eAtFkM9j/1Dp8xNuG?=
 =?iso-8859-1?Q?te7WZRVnQojYefLmX5vX2d8ySVRR1HUM+00PHG97BGHmbH6zwxWIaIyC/y?=
 =?iso-8859-1?Q?stuQ/Qf/tGTFvpf8UkWLDzqw/EkyB+WlutiUh4idwiTlcHe/2W366mE+JP?=
 =?iso-8859-1?Q?5DNMYzrb2NDwQfKEmCH3Y7nag0OQ6qhyAbgQeXWBPMwONw5R2ul8W47jY5?=
 =?iso-8859-1?Q?WUp0tc5wehmAu7MgQc1FRJdQ4vZkUDEDei00s8yN4G1V/Z6Qv9DKfKYTwR?=
 =?iso-8859-1?Q?Zdi+Cqi5TwYioWkf4iwABkNxz8QzKRW+5ZeAG0tXacPbydFRDzVIygTXAx?=
 =?iso-8859-1?Q?xzL2sKt1wAMxO1kUSXZ2++ayStKwTo4YEf/OPVsDbZBR9xBV7ziEejUh5j?=
 =?iso-8859-1?Q?s9frcysBt7Wu5Mo/U4rl6gsQ2dINJAEVVA8N7hDnTMO/Eh5RMofFb2DwVJ?=
 =?iso-8859-1?Q?sDiFh66Wc9he5dDSgleCu192yUTkB46Bx8rrQ0J6ybvgpxU0sxf9N5+xju?=
 =?iso-8859-1?Q?I3CML5BntdavBiL6MFYgYydh+SrY9IeybR21Tn04yCaVI77m6wJ3C75ODO?=
 =?iso-8859-1?Q?q1N/akTM6XIRPt7nBKD4hBdqXDGZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR03MB5239.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(39142699007)(376014)(31052699007)(1800799024)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Oe9bL8ZuC0ydVSazb/FMY3nWGg7qeGK93KnAY/kI76P0nyQywucX2UD4U6?=
 =?iso-8859-1?Q?XCgBzPeQ4FsBWyT1z2R2vyQ/aBYyuBoK6BGj3SYSY5sTzlILJqRAXgVFfy?=
 =?iso-8859-1?Q?eobskxP6ekgPNcYgVQP7p2SRdiHJpXaad8uirn2Yckb2NL/ITbYphWGPqS?=
 =?iso-8859-1?Q?42KZ+oLoKu5s9sCvGmaS/dBvYzRny/1IJ0FgM/dq66iP+0plzDrqz+UWo/?=
 =?iso-8859-1?Q?72NBu2vhmb2qQHP6WQIoRhmdYsVcAJWGlb9IkKeaDE2FEXrwIIQI+l1nXL?=
 =?iso-8859-1?Q?SQnd7z1+hWxNcnMf9eufnd4dAVDOzgi5+5rXE3Glt9drrqPhXMwJ1+i4PL?=
 =?iso-8859-1?Q?VoLQJxp5rn5WrsWeQFaGeGz/hcgnPI3PCxAM8JAH8W9zgrWZOBfLF/+QQK?=
 =?iso-8859-1?Q?kWFSqPYqO3z3pexi+CKS5s+pv0euUViUSwlwDf2MAgVQFj2BZCT5yTGO/x?=
 =?iso-8859-1?Q?RiEnOvbkdju0wcZDKU0lkB4/Y2u7V+YU4uCdboQ3A7/8t1x/SaHE7TfBQ2?=
 =?iso-8859-1?Q?AM2TQ5zvsm87Ms6kK+qvuz5I0HoPYgCVcFDj5ZfraxQHoFuw6svXfRfShT?=
 =?iso-8859-1?Q?2cGoeoo+k0GI3a54cNocIt+0MfVg4PHYBiaCzJIEf2KYQwad/a708L0Zo4?=
 =?iso-8859-1?Q?N0NnJT1AMBhIVNFCU808go5fWh47mptriuulES/LxzFudPrtH2sOjIYo2X?=
 =?iso-8859-1?Q?RyYVYua3eRMfjSYMYHfmcha3z2UvNETm1GMq0ulpZIl+uREefU2K1/4+PQ?=
 =?iso-8859-1?Q?UEHjlt7rtGUldwaQxBIQTKvV6dcBkREbAXLXfBn6GRIBSP9q5RPgdYUwFm?=
 =?iso-8859-1?Q?xgxVenwcnUhaQCdd2qpDoUYeBzmMLjnu3UcsYAqGdTvnZoXNXkwCeZlccJ?=
 =?iso-8859-1?Q?KVelVz+5UtT2RQp3cIjQfVj1Ks9ZffPrCZ3bcPYz4z7n3enBesuFhiEzLA?=
 =?iso-8859-1?Q?CQoTscZdFR7PgtnyzPi2ysz8oV1Nh/KUrgg2o1Vt8c1ovdABOLtJhBfHzD?=
 =?iso-8859-1?Q?38dLgCYjABPlzfrM3ib9PQiOhYMFo4YywFWaJlUxarBolIyt6abO4E+0Ez?=
 =?iso-8859-1?Q?tP1fAvPPWlKumwzjJgntioiTnZTW9LQnYTfKGl++I29cmV2EUdiZhRTL8R?=
 =?iso-8859-1?Q?qpXd0IfKCG51xQIucwGkjFjDTDUBif1/lMkMUKSZwaks01TtPboC2Q62JB?=
 =?iso-8859-1?Q?+h2NTmnHJW43NlKm5wyPGLjFv4QmGtPNFc9wAeWupxyTPWCMa2u/DZCpNb?=
 =?iso-8859-1?Q?t4ZzwHdi2Fn9um6G9kHiiky2Kt7yj/3Lue94W/0lKjlUhfltkwwlWfxUQJ?=
 =?iso-8859-1?Q?5YNOZShmtu9xogfSwHBfljjJoTiBBfQrKqtEbu77aXUqsdIwt2OepwReK6?=
 =?iso-8859-1?Q?16W6WJ5zcz6E45WczrgCQ1oST0mfXcmERIojCLUULSvu4MPWWPFFuW2gJt?=
 =?iso-8859-1?Q?017xJ3/rdBpwDv3mTDByLcu4YYasYsFXp6J45KvlIEt+wdEdA5vvpKf1GC?=
 =?iso-8859-1?Q?SWKBNCVBHKvoY2VtHCWgGOqTorD6t0+mDpnRgTf6OG47zvd9tKFTRd6vZU?=
 =?iso-8859-1?Q?Zgzj0cSXr8UeiAOM7wr8cYpP+keSjI+0qQsTOUmfqIKRLAUkQJEs84TbRt?=
 =?iso-8859-1?Q?Z3xatE1dd11PU+Qrdo9Rllvjknire70sDa?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR03MB52394B11C758A4F637484146FC18ACH2PR03MB5239namp_"
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR03MB5239.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ab57cf-5509-4e30-ef23-08ddfe31bcaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 01:52:52.8909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFs2K3fsU3wyI6bGfLzazPU23MM3UkvpGeOG0xCmJHlTVzWvimTLDziT5qf0IlmnOOpLrtnWmfyL7e4fJ5Z1dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5954
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

--_000_CH2PR03MB52394B11C758A4F637484146FC18ACH2PR03MB5239namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Thursday, September 25, 2025 12:51 AM
To: dev@dpdk.org <dev@dpdk.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>; Xu, Rosen <rosen.xu@alt=
era.com>
Subject: [RFC 3/6] raw/ifpga: avoid use of pthread_cancel

[CAUTION: This email is from outside your organization. Unless you trust th=
e sender, do not click on links or open attachments as it may be a fraudule=
nt email attempting to steal your information and/or compromise your comput=
er.]

Use refcnt to do controlled shutdown of control thread
rather than using pthread_cancel().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/ifpga/ifpga_rawdev.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_raw=
dev.c
index 5b9b596435..d61927f193 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -573,13 +573,7 @@ ifpga_monitor_stop_func(struct ifpga_rawdev *dev)

        dev->poll_enabled =3D 0;

-       if (!(rte_atomic_fetch_sub_explicit(&ifpga_monitor_refcnt, 1,
-                       rte_memory_order_relaxed) - 1) &&
-               ifpga_monitor_start_thread.opaque_id !=3D 0) {
-               ret =3D pthread_cancel((pthread_t)ifpga_monitor_start_threa=
d.opaque_id);
-               if (ret)
-                       IFPGA_RAWDEV_PMD_ERR("Can't cancel the thread");
-
+       if (rte_atomic_fetch_sub_explicit(&ifpga_monitor_refcnt, 1, rte_mem=
ory_order_relaxed) =3D=3D 1) {
                ret =3D rte_thread_join(ifpga_monitor_start_thread, NULL);
                if (ret)
                        IFPGA_RAWDEV_PMD_ERR("Can't join the thread");
--
2.47.3

Reviewed-by: Rosen Xu <rosen.xu@altera.com>

--_000_CH2PR03MB52394B11C758A4F637484146FC18ACH2PR03MB5239namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi,</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
<b>Sent:</b>&nbsp;Thursday, September 25, 2025 12:51 AM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Xu, R=
osen &lt;rosen.xu@altera.com&gt;<br>
<b>Subject:</b>&nbsp;[RFC 3/6] raw/ifpga: avoid use of pthread_cancel</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">[CAUTION: This ema=
il is from outside your organization. Unless you trust the sender, do not c=
lick on links or open attachments as it may be a fraudulent email attemptin=
g to steal your information and/or compromise
 your computer.]<br>
<br>
Use refcnt to do controlled shutdown of control thread<br>
rather than using pthread_cancel().<br>
<br>
Signed-off-by: Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
---<br>
&nbsp;drivers/raw/ifpga/ifpga_rawdev.c | 8 +-------<br>
&nbsp;1 file changed, 1 insertion(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_raw=
dev.c<br>
index 5b9b596435..d61927f193 100644<br>
--- a/drivers/raw/ifpga/ifpga_rawdev.c<br>
+++ b/drivers/raw/ifpga/ifpga_rawdev.c<br>
@@ -573,13 +573,7 @@ ifpga_monitor_stop_func(struct ifpga_rawdev *dev)<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;poll_enabled =3D 0;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(rte_atomic_fetch_sub_explicit(&=
amp;ifpga_monitor_refcnt, 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_memory_order=
_relaxed) - 1) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ifpga_monitor_start_thread.opaque_id !=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D pthread_cancel((pthread_t)ifpga_monitor_start_thread.opa=
que_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IFPGA_RAWDEV_PMD=
_ERR(&quot;Can't cancel the thread&quot;);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_atomic_fetch_sub_explicit(&am=
p;ifpga_monitor_refcnt, 1, rte_memory_order_relaxed) =3D=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D rte_thread_join(ifpga_monitor_start_thread, NULL);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IFPGA_RAWDE=
V_PMD_ERR(&quot;Can't join the thread&quot;);<br>
--<br>
2.47.3<br>
<br>
</div>
<div style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica =
Neue&quot;, sans-serif; font-size: 14.67px; color: rgb(0, 0, 0);" class=3D"=
elementToProof">
Reviewed-by<span style=3D"background-color: rgb(255, 255, 255);">: Rosen Xu=
 &lt;rosen.xu@altera.com&gt;</span></div>
</body>
</html>

--_000_CH2PR03MB52394B11C758A4F637484146FC18ACH2PR03MB5239namp_--
