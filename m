Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD1C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 09:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AA6A4014F;
	Fri, 18 Jul 2025 11:10:51 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013059.outbound.protection.outlook.com
 [40.107.162.59])
 by mails.dpdk.org (Postfix) with ESMTP id 8C30340144;
 Fri, 18 Jul 2025 07:10:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzCu1+NNzzZamDM9SYZEPDJwl8dPHdsUPI/UULNX2dO+gN3ql2vFTDGk6xXTu072WAwWoMzSyAUHg9mwuUlqT2vkv8sDsVpILoZobb1wtr6i1Nfyx5AIe50EUIjm/B0u+CNdGjR1C5QDVb2HiIenqvMCeZbpclFdBdcmsWMYCh6xgGOy/9/stYqvDrIcDAMW8OPKclatUYep7bh3lLPttLQ2HRE1jGLl3eUw/UB6DI0knxeapN8N815TuNRswOOyaHCkGJO1uEviL5v6MHwf2p0LLCJKYW2Lkgtde/GuAC51B7f7pPQ8gZXiIf2iwkLOqDSqtMVk9dgu240Y+SXn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuKsJ8kVu0s6PKVhNJMX0O+5V5q3qo/VI/Ab9LB2i4I=;
 b=ZeBAGBK1GqNq6CGz6SlVtqf2DA99SLm7j1B5h6DTVAWe+mlccymm+l0HDR4xsM0Eyhi+G88VSicz83oDI5jW610IZHy22dOlo1Z8WhiGFxgJwr35tcHvxF7unDxxpdfT5m6KKSvfoH4NWECX04/u2pbVzyfvm1zTNaflkAfRdW/voq+Lnysd6lTaUJxd0gJbMF/VkGjQA3LfxdDK1lLMZwHK1hsTfPbkddNNujDsKx+0UvQOWXfwDuFtfhNv0A5j+b5/FCARTjyaao+WDON74jr4zMqqgbr2Gc19m7besb9PyhzU/9JkZXIY7zdsBBQzFS+bcrkmHlVbfIcaCr4dcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in.bosch.com; dmarc=pass action=none header.from=in.bosch.com;
 dkim=pass header.d=in.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuKsJ8kVu0s6PKVhNJMX0O+5V5q3qo/VI/Ab9LB2i4I=;
 b=Spq1pewklmEMAd3HcJXaDFisKFB3p4Z0/Pi9UwFX26YT2YNhKIw4Ed94l1xds+VH2taWoI4OsAg2sp5Rd6CBjPDbWiE+rsi1sOg/kbTc/XiFFrG7QIGfa6mR8wqk6TnkRetVUuaZRXJdevp40nsZ2vVSWR5G8e/0Bx5SHC2CefWeLnANpfySVf0mXU+ecbeT5chbejPEjrmeYewBnXNj79j0xI4+qG9wAfFBcdxKUDEp9SOrnCODLBUapWkehF1rTwT1/xnanhOln9Y0nMwCVHuPxZgMtvgByJY4QPsHr2Blxd0Js5xjbKM4zvYXx6y1a/NrnLxK5kqXoXCn79U4LQ==
Received: from PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::12)
 by DB8PR10MB3846.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 05:10:38 +0000
Received: from PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3ff1:7b6d:5fb7:13da]) by PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3ff1:7b6d:5fb7:13da%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 05:10:38 +0000
From: "Gokul K R (MS/ETA7-ETAS)" <KR.Gokul@in.bosch.com>
To: "users@dpdk.org" <users@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: =?Windows-1252?Q?Issue_with_DPDK-Burst_Replay_=96_No_Frame_Transmission_O?=
 =?Windows-1252?Q?bserved_Despite_Successful_Replay?=
Thread-Topic: =?Windows-1252?Q?Issue_with_DPDK-Burst_Replay_=96_No_Frame_Transmission_O?=
 =?Windows-1252?Q?bserved_Despite_Successful_Replay?=
Thread-Index: Adv2L7p3bdoMR1ufSN+JWPZiXr2rmw==
Date: Fri, 18 Jul 2025 05:10:38 +0000
Message-ID: <PAVPR10MB73554B90C65B0D9A83AD8582A450A@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR10MB7355:EE_|DB8PR10MB3846:EE_
x-ms-office365-filtering-correlation-id: 85e9b706-b529-45e7-c790-08ddc5b96f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?fw0mR47ZROew6BCyN/8hMkSuIC4jNDredfDdEjA8Kya+d2lP4zSNCaL/?=
 =?Windows-1252?Q?yfdKBA+jl+gTYNKphKdzFMBq3OyN4KpQVP9nq8yXg6lZpjV3s0KBuqNM?=
 =?Windows-1252?Q?t6a4N1RNWs8DRhTi3WOBOIlmmJ/eC30X0/qW5p4VYy2G3TZOJQaitMFW?=
 =?Windows-1252?Q?9osZzY5+VyjbNzZkSpTK43tdGHmlHCCfRmJsWzYTvySTsubISV1VNBNI?=
 =?Windows-1252?Q?T3vHK9aRHNgLTO23UzXvs2UPRC8UlSjNSCRnerFuIfD4h5qj1cpriqfF?=
 =?Windows-1252?Q?MHgxop9BpVRzGQupvihUHXYVKGkhT9NoHktcrnGRVeSk1XIAI4dPbDeX?=
 =?Windows-1252?Q?K+2G9OH8UJR8yEzDlcsCJYCcGqL73S2IaM5coKkyCYb3uZVf499sGtpE?=
 =?Windows-1252?Q?bWuVfCzCgjGwUmHnDaBYuLchaDr90tNo//Xe45mJAAeSh+ylfcPOMGFT?=
 =?Windows-1252?Q?7dwK8KVmv6qWrH3XDFMT2REyJf+U4V3AXerUwixwVUjdtLhjWT0Fsgdo?=
 =?Windows-1252?Q?Ik4g0DPfAhXHbLlQ1CL/XF5fZ+FnYyOzAYgwNI5KmqA+cRZEuYz+95AD?=
 =?Windows-1252?Q?+JOA8wVdpyqAA2rEsYTcgWELg9k1bugQnyc7y4+pv/iR4DeSIzloHbDl?=
 =?Windows-1252?Q?S930gwPELs6UBhOeacr1v2t7cVEX+2T3FBXS8VTiQlj1ZYBM6iuXk4HH?=
 =?Windows-1252?Q?my26IvRkFZ77QhWXzOD/fRfrE8Z97JhqeAd3KioymVzhiueSZfs9AkOY?=
 =?Windows-1252?Q?ZUH+RFBHP1Yr1mrFIz1SUav7J9P80Wb48g6cRAC2TVzYbidorgA7TMzu?=
 =?Windows-1252?Q?pOnikNcFKwFpLk71Iryaw+Mf7MZ8kqKuDQJbknveMIzFjSrnNuaG35lw?=
 =?Windows-1252?Q?e9gEB4Tn7oZ9Nm7JtzLMwHJXn5rVeeJ4oh0wJwpI1u8XqbKU0g/L+hqe?=
 =?Windows-1252?Q?fn043QSLjMcRSmEKpiONbq4TPIerXvCS6Pdqkia2E4eS5Xht8Ii79upJ?=
 =?Windows-1252?Q?AQXKCJoOPgdkWCmsB2gKsfkJZsXDfP9zK5F/CrxsXUaPN77PU3X6DlX8?=
 =?Windows-1252?Q?4hFDDf2ei29SMuV3Px+Rm9AuSZdLF91x9gT6UxBWJnEGgF4WYQffDopl?=
 =?Windows-1252?Q?KEutVcgyINFBs5IamCnoegWUt/11qrKOX8CmTZfXMisgNlNjZJkthe37?=
 =?Windows-1252?Q?wCMiMGTWcbFUnLjuAyRUhD3Gr17M17oY0ovD9rjkvdNx+3LZZOZPV8NK?=
 =?Windows-1252?Q?fFmJbbSR9BTf7K7HRFCuN1G7lrEnTH+lzxQQVf/k9ye3jOyhMd/VmrPb?=
 =?Windows-1252?Q?sA/8S7Gre/jLsjeHtlNbXGnTnxJ6LMftMM9KnVrslJyt4WbzXwN3s6lH?=
 =?Windows-1252?Q?QQ7TUg3DKTsW/ixunTJMPbGS88YZx/GYc8ioxpCCiPJcjKePMSdDOYP3?=
 =?Windows-1252?Q?9YlS5veSH1QIeIcoQIeLRwI88QU0J8u7EsfipWemS3qye3Da3f/+u6GX?=
 =?Windows-1252?Q?jIHTWz98lf2zElxeMUxMFg2j3C12O6J41562QUGHUgUBrg6aTUCjjW9c?=
 =?Windows-1252?Q?JfPs2hDWkC29CAcW+9dDh9+e8s5tmQQS9iUaVA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?76Bc+RxaimejZkm3sLBE6roI99rJfONcvqoBt96ORQgXB0INL/Ese8ov?=
 =?Windows-1252?Q?Iw6UGDKoF2C0M++IgBwdxVRjlehPRpLTMDe4WED9HxqWmVhNvN/Ugtx/?=
 =?Windows-1252?Q?e/9icwdnR4Xifc812MN9+QPoEtpm2b5nOvoRnXXfFeqnsykpb/38hRNR?=
 =?Windows-1252?Q?ZGPaXB/kzemdR19cQlOD7jZjN480uOT7VB6oBOkiTa45MXP0mLmg7fQ9?=
 =?Windows-1252?Q?Z6LnjYYEcaokYdd+LnvtiGnRUfBp+PNlHfbwt7ZwwnK2iMETdePZnpWv?=
 =?Windows-1252?Q?w7LeM6VHLAujtev7KQEJ17HfNDr/s5zuFp2Rgpid67JdCQRZBZ3KPoDK?=
 =?Windows-1252?Q?v6urQw7HzE8R8+Ez3JlWcP6nhrXtJj0RNU8u1CilpPjTlnEzh5fdnas0?=
 =?Windows-1252?Q?gLjandbLTEUcY3ZF9woLGxfTpet//fMd35EcNJAzt3QhG5NQ5DPqG8Pv?=
 =?Windows-1252?Q?jHE7kBcvu7XEbY402MsQGtluZaAnuy6tNuVOnSGkUfS97O2MXzPnr4na?=
 =?Windows-1252?Q?g2i+pwdTfWF8cx+j81gm0v7UduPEVhYM9gxFOnMb4sggV5K7inuM7aF8?=
 =?Windows-1252?Q?PA3abwe8No2OmIyboq19D/VPxZBSUldZDvcOBnO2rRsmGQQcqc2QB/4t?=
 =?Windows-1252?Q?y2uxq2xE6wk6AhzdFRCjpoqo/xNLlatAGFZdvosGD0bskpmzUKI5PcaK?=
 =?Windows-1252?Q?exDn5TcxcwXZvRftOSGCllVzxK8sbRzefQ8CyIeVDafH33c4UjU+7r9s?=
 =?Windows-1252?Q?S+lhK0lBVvBY0rAAfMRa9Skfmzb4VFtsNqZgsAY1ywfrsu5589Im6Jun?=
 =?Windows-1252?Q?zY5k1SGgQVEZO6n+SV74db9/dFePleixS/pSC/XRhdDpEoZRZfMUldX0?=
 =?Windows-1252?Q?HjxbKksxaRLyR26NGMMQJAEs8UQbmvmQ7EnqeIKk8qEdqh6E/jT+zYCu?=
 =?Windows-1252?Q?O/BAPuRTL8OwHT/p4YmB5KQX6WpBE2YQ5PnZtsJO3B9ioOAa7+aVScP4?=
 =?Windows-1252?Q?fJwgKQxXF/g4SI0zBTRDpXpBuob75fBXlL243l/8gGgcVf37RJpGWSES?=
 =?Windows-1252?Q?GGDGzhye9u4X4DwEvugCUlkhS0WOM8kpYFlSRKDjCEzEQ0XwCEJUawj4?=
 =?Windows-1252?Q?qiZDKeVnMSmi24k5jWHhveoyEyEPB+xuqoLTmH2yPIQw6FUAeSsvYGJ3?=
 =?Windows-1252?Q?ue4RIjG2+jzol8N7Tc+qVWOQzYTZALcoLZub8TMCrf1xa3/mHUBfrg/b?=
 =?Windows-1252?Q?ZD9AkI4GmnPca5jQKxpbfiSVgoN6MPCrExsCsIIx37Nq5zAsSDzCFTNU?=
 =?Windows-1252?Q?+IiWSImhQbsCvJjEabkC/FUVF+kCog5mnr1WdO9aunkTnBLFIQy3D0ZU?=
 =?Windows-1252?Q?T91+oryrx6viT4eUjKKuCK2GuM9SE99AZ6BGWvEWQjDLluVml5BZmzzX?=
 =?Windows-1252?Q?zryC5U/tjzA7mSGIGgKLuEIIxrWWZaTpxik4iEeIkqs9HwCNyjPY6muY?=
 =?Windows-1252?Q?V33MqDXlU6zU0GXoZZhV01DntLbtuAnu0tamAXK9VQ1QvTo8J+kBWKjT?=
 =?Windows-1252?Q?srAFFuEpiEpiknCSOEQOygk39UTPNlHvIH7PJGHyccY6t/LkOJRURz5X?=
 =?Windows-1252?Q?3s/pnLLKq9fhB+By34i+pECxofE+UAwhVRRTbUbr4HbRBbpHVSuOqfD1?=
 =?Windows-1252?Q?C/kKYtaV40Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PAVPR10MB73554B90C65B0D9A83AD8582A450APAVPR10MB7355EURP_"
MIME-Version: 1.0
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e9b706-b529-45e7-c790-08ddc5b96f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 05:10:38.3388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CJS3woGgRN4EiF+johhJH7o8rX2iAT2W1D16kZWuQWjxE8lwiJSuWWOKWrpaUjKG06syWq4oOftMDjXHdFnjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3846
X-Mailman-Approved-At: Fri, 18 Jul 2025 11:10:49 +0200
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

--_000_PAVPR10MB73554B90C65B0D9A83AD8582A450APAVPR10MB7355EURP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Team,
I=92m currently working with the dpdk-burst-replay tool and encountered an =
issue during execution. Below are the details:
________________________________
Observation:
During replay, we received the following informational message:
port 0 is not on the good numa id (-1)
As per the DPDK mailing list discussions, this warning is typically benign=
=97often seen on NICs like Intel I225/I210, which do not report NUMA affini=
ty. Hence, we proceeded with execution.
________________________________
Command Used:
sudo numactl --cpunodebind=3D0 --membind=3D0 ./src/dpdk-replay Original_MAC=
.pcap 0000:01:00.1
Execution Output:
preloading Original_MAC.pcap file (of size: 143959 bytes)
file read at 100.00%
read 675 pkts (for a total of 143959 bytes). max packet length =3D 1518 byt=
es.
-> Needed MBUF size: 1648
-> Needed number of MBUFs: 675
-> Needed Memory =3D 1.061 MB
-> Needed Hugepages of 1 GB =3D 1
-> Needed CPUs: 1
-> Create mempool of 675 mbufs of 1648 octets.
-> Will cache 675 pkts on 1 caches.
________________________________
Issue:
Despite successful parsing of the pcap file and proper initialization, no f=
rames were transmitted or received on either the sender or receiver sides.
________________________________
Environment Details:

  *   NIC used: Intel I225/I210
  *   Hugepages configured: 1 GB
  *   NUMA binding: --cpunodebind=3D0 --membind=3D0
  *   OS: [Your Linux distribution, e.g., Ubuntu 20.04]
  *   DPDK version: [Mention if known]

________________________________
Could you please advise if any additional setup, configuration, or known li=
mitations may be impacting the packet transmission?
Thank you in advance for your support!


Best regards,
Gokul K R


--_000_PAVPR10MB73554B90C65B0D9A83AD8582A450APAVPR10MB7355EURP_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1099910202;
	mso-list-template-ids:687255042;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1660303150;
	mso-list-template-ids:785561934;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-ligatures:none">Hi Team,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
I=92m currently working with the dpdk-burst-replay tool and encountered an =
issue during execution. Below are the details:<o:p></o:p></span></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;mso-ligatures:none">
<hr size=3D"2" width=3D"100%" align=3D"center">
</span></div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;mso-ligatures:non=
e">Observation:</span></b><span style=3D"font-size:12.0pt;mso-ligatures:non=
e"><br>
During replay, we received the following informational message:<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;mso-ligatures:non=
e">port 0 is not on the good numa id (-1)</span></b><span style=3D"font-siz=
e:12.0pt;mso-ligatures:none"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
As per the DPDK mailing list discussions, this warning is typically benign=
=97often seen on NICs like Intel I225/I210, which do not report NUMA affini=
ty. Hence, we proceeded with execution.<o:p></o:p></span></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;mso-ligatures:none">
<hr size=3D"2" width=3D"100%" align=3D"center">
</span></div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;mso-ligatures:non=
e">Command Used:</span></b><span style=3D"font-size:12.0pt;mso-ligatures:no=
ne"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
sudo numactl --cpunodebind=3D0 --membind=3D0 ./src/dpdk-replay Original_MAC=
.pcap 0000:01:00.1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;mso-ligatures:non=
e">Execution Output:</span></b><span style=3D"font-size:12.0pt;mso-ligature=
s:none"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
preloading Original_MAC.pcap file (of size: 143959 bytes)<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
file read at 100.00%<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
read 675 pkts (for a total of 143959 bytes). max packet length =3D 1518 byt=
es.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
-&gt; Needed MBUF size: 1648<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
-&gt; Needed number of MBUFs: 675<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
-&gt; Needed Memory =3D 1.061 MB<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
-&gt; Needed Hugepages of 1 GB =3D 1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
-&gt; Needed CPUs: 1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
-&gt; Create mempool of 675 mbufs of 1648 octets.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
-&gt; Will cache 675 pkts on 1 caches.<o:p></o:p></span></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;mso-ligatures:none">
<hr size=3D"2" width=3D"100%" align=3D"center">
</span></div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;mso-ligatures:non=
e">Issue:</span></b><span style=3D"font-size:12.0pt;mso-ligatures:none"><br=
>
Despite successful parsing of the pcap file and proper initialization, <b>n=
o frames were transmitted or received</b> on either the sender or receiver =
sides.<o:p></o:p></span></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;mso-ligatures:none">
<hr size=3D"2" width=3D"100%" align=3D"center">
</span></div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;mso-ligatures:non=
e">Environment Details:</span></b><span style=3D"font-size:12.0pt;mso-ligat=
ures:none"><o:p></o:p></span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3"><span style=3D"fo=
nt-size:12.0pt;mso-ligatures:none">NIC used: Intel I225/I210<o:p></o:p></sp=
an></li><li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3"><span sty=
le=3D"font-size:12.0pt;mso-ligatures:none">Hugepages configured: 1 GB<o:p><=
/o:p></span></li><li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3">=
<span style=3D"font-size:12.0pt;mso-ligatures:none">NUMA binding: --cpunode=
bind=3D0 --membind=3D0<o:p></o:p></span></li><li class=3D"MsoNormal" style=
=3D"mso-list:l0 level1 lfo3"><span style=3D"font-size:12.0pt;mso-ligatures:=
none">OS: [Your Linux distribution, e.g., Ubuntu 20.04]<o:p></o:p></span></=
li><li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3"><span style=3D=
"font-size:12.0pt;mso-ligatures:none">DPDK version: [Mention if known]<o:p>=
</o:p></span></li></ul>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;mso-ligatures:none">
<hr size=3D"2" width=3D"100%" align=3D"center">
</span></div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
Could you please advise if any additional setup, configuration, or known li=
mitations may be impacting the packet transmission?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
Thank you in advance for your support!<br>
<br>
<br>
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;mso-ligatures:none">=
Best regards,<br>
<b>Gokul K R</b><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_PAVPR10MB73554B90C65B0D9A83AD8582A450APAVPR10MB7355EURP_--
