Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5076FCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 02:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2156740648;
	Thu,  9 Oct 2025 04:32:22 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by mails.dpdk.org (Postfix) with ESMTP id C24A240277;
 Thu,  9 Oct 2025 04:32:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppwyPPukBSTnhRDT1iJd6JTGLjt9ozfTVnILUQLLyzNU/yqK8MLcAtHo5LLFobbAOPQ56FmKCazmtwOswtAKjoIAO4uSfiYr13qtNjlPEMZIDviXrVJvMB7CkBc8RQ6HLodzyeuSeB7rb2QbO731lLEfe6Uj2XYkqy4gyieovrnEI6YcTP0m3PVW1jvTXwBMqy/ZeCIrp9/wYO8vm3iD4gopuEmhfOQ5CSWwGcEd/mBI09ceS2yZMfOdD6O+CopNfIjS4OlDCY/dviRvbScVjEFyI95FynTD+IANeiRJd4DeVCe+EBFEF/7Hqfc/zHkE4sbN7vOogt91G1N8QoNSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMYblN3UifzrnpdnfMXSIlfzKryp4RJ4wny/g3C6AD4=;
 b=FnpMeSk2x9+DZ56hb5Tawz54mJ89zRlcVIyPJgLSgUq6wEYrFGCfkmaD+TGq64gn6bs5BdpBdP7Lnoag6RqADhYT3ldmiyOOqil26ZoG8tiZ8HU7xoMd/xNgzyZO91FBwL3NBCXHdS+dJ+gPSNZjuxL//foaVj0B7rU5l+lnSyyst08LlZPGdbjDdMpZI6170kmhS1DrXuKQze+vKWvs9CpcaeFWNyr8pcRCjvw6JP3msr2cbvJn/J4aZAZhMr0CffIi0celF3cRp/eQ/j7l+PuwDPZFHGL8bb+DToBQje5WdFvi7zMcsU3RUeNZrMfvzrX5mFFDi4n5Mp01s/MY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMYblN3UifzrnpdnfMXSIlfzKryp4RJ4wny/g3C6AD4=;
 b=Oj1FYMNU+C+3ugDCZhLVPifVTd5IrdZQ/V62cOTRHcL0rFEUd2FGcRqipyvvv9ja6MPxAXMF48BhE93ZoCqW/J2Zi1C7I4Zcxn1sMjfASjJf+AzmqWJQsAj/6sfzFSeb5x5R+VyrMw2qonOMfvgAtiupZ0vBDp/APanQBg4eIC4=
Received: from CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 02:32:12 +0000
Received: from CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::9a84:a7c:143:6f7c]) by CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::9a84:a7c:143:6f7c%4]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 02:32:12 +0000
From: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>,
 "david.hunt@intel.com" <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, "Ande, Venkat Kumar"
 <VenkatKumar.Ande@amd.com>, Dengdui Huang <huangdengdui@huawei.com>
Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size based
 on Rx burst
Thread-Topic: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size based
 on Rx burst
Thread-Index: AQHb2SU+tA7kPVaC/EGjX4/NwXYycbP8deoAgL1hK5k=
Date: Thu, 9 Oct 2025 02:32:12 +0000
Message-ID: <CH3PR12MB8233DABD201A97C7A71D8D2C86EEA@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
 <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
 <PH0PR18MB40861D909AD3BC9A0695309ADE6AA@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB40861D909AD3BC9A0695309ADE6AA@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-09T02:32:11.636Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8233:EE_|PH7PR12MB6693:EE_
x-ms-office365-filtering-correlation-id: 871cef9e-a55c-44eb-c02b-08de06dc0daa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|8096899003|921020|38070700021|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7dQW6ahENGRfwHUZfqdT3DC7iA0ByIgXxoqkPfzQG7vfYU9DnIJxiX8NmS?=
 =?iso-8859-1?Q?tU7WwFfTuPJK6SsQzk6pZELpBPb0Ieim9rnfNT77Dt904sLybPC/OYWwEn?=
 =?iso-8859-1?Q?cLSr+ETEmxJHgx+2wYOdMU0IqS+nAWHRP/zkFZXj9sErqLwjjNvuEOycE+?=
 =?iso-8859-1?Q?cf27cNfnFUGn32vC85nweKGvo03w2tvboljPyldhWgIpDiCVD+5JCV71Vk?=
 =?iso-8859-1?Q?CmlQf5ZatIiQoy04nf1C+ocnoMqkTV986ieJevV9CXrjjl+Upwe0zyy+B/?=
 =?iso-8859-1?Q?aaFolSR+jsAxJ+O/fGg5/+JUC/T6T0cFR5amCEeZETgpdOXDfGMyXiZGEM?=
 =?iso-8859-1?Q?wunVsKubGpthKIP2NYAAGZLTT0MxYfHolbcffA6wx86Zkmpi6INe1c5BnC?=
 =?iso-8859-1?Q?Vx2hMYg/jJp0uX2BfvtRCAFsZsOqvNtPeaPVS9N+EdVqm798Crv6SLsHYS?=
 =?iso-8859-1?Q?bSYNG5O4VVrYTtA8gFrYGUFc2IJ4EGrfBu8bPJXWbRIZP/b9LuQZTTX7mQ?=
 =?iso-8859-1?Q?ZIuK7jyhEHLkAvRcEB7sBWel0H5lS2LZKleTosu/HSBmC03Ce/7kwlco62?=
 =?iso-8859-1?Q?ejzQ+KlbGFdZ6LkW86i+qUxs1Fx8v6XPi74Dckuq/iVs07oHGA6VNqmi1d?=
 =?iso-8859-1?Q?aU3j8BadC2w09ES6Y1AvZHfJUanAejnY6iR9fFlfRKB4rIvvfTt2uQPbht?=
 =?iso-8859-1?Q?/X12Ec97KkD7e+kt1VXoH8lo9MN0rSvWiB4J1nDFIPj5u22Oe0dG/S/GjA?=
 =?iso-8859-1?Q?6sRMAqOA2BGf5qqBrGBa7S5athHeGheKWRzIjDmIH+W2uV7EHOoZbyN+a+?=
 =?iso-8859-1?Q?w2uGDOUgEoObubhA7rsTRIOBRNdE3Gd6MzBTwHQDI+IEU6oLO/awC59WW9?=
 =?iso-8859-1?Q?0mYzVjLjOOWaCncurbtrB0TjlCZRd6MEHAXrXtmXEB9xxfSKfkKvijEU7l?=
 =?iso-8859-1?Q?ffkM+hThfv5j+2DbKm9y8CrQphxjjiI3ykbcWvK9k2dQ+njWbyezIkPp8l?=
 =?iso-8859-1?Q?vjT9Wqp/sWdyi69dMzzXHx9F2g4mCSkrXEGuCedvA5g2vP/Hn+HRGQ4i1Y?=
 =?iso-8859-1?Q?USNsyWAd775q6cnRSeaYhib4eLFQUm3sMUVCI4D6QlIo/aZRZODS17kbRp?=
 =?iso-8859-1?Q?h74i09wKp7JLej83N2Vk1kXLrO1LpbRjnx2fnQgHsxwTuchsYsIMIvHtLq?=
 =?iso-8859-1?Q?+EPSKPuKVJh2Jcgf0ZKJ2g1D7nT4ppAIqIJzaN4TYIQtv0AoW/0fWf0zJR?=
 =?iso-8859-1?Q?/CT+SE5T+Q69UbyPBL1ry2T104f16bA4MPPq7hnfT8gSFqylaQJYsYPBAY?=
 =?iso-8859-1?Q?wKeGoB1kY2fTNW+0FT3ZC3E+EzrcrQ9rFdUefVAkhkGBiZgZC3QfgWH/iK?=
 =?iso-8859-1?Q?e99IEhXBWuZ60CkgLFA3zjeNso+rd6JJKKLgi4rfQ6akZWPsHzq1hDvi/W?=
 =?iso-8859-1?Q?WmysWEeN6xtf9BD/wQQLeWBYtqzSvR+90U29d4qLyYqvBhA5Y7VQiZ0k2S?=
 =?iso-8859-1?Q?EPC4018+m8MVqEMobN2O63QlFFKxfrDAGFw3RZkdW9DDy4PaHbK52BYhlJ?=
 =?iso-8859-1?Q?jTxKPRGfQiI4AnH7hQ5xVjE0UtyAIhq83uAmiBbHtWDZVXhfUA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8233.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(8096899003)(921020)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IceED6vukakGjz/AEcs8Hv92WE6fH94ibGnZrBp7s98NNVw1wUjonOf4L8?=
 =?iso-8859-1?Q?0UOiZmJVXRnXiMtvDH+6O1CMbMbZUbBqgQrcWAUc7RKYLq7/PoHkS+eoq/?=
 =?iso-8859-1?Q?9ir8j1NijrqeTxIMUhHof1DyS/loTxJNPDNl0gDnCyi+jG+7du52+mROR0?=
 =?iso-8859-1?Q?pLEFDFPAtRvCzKaJ9FRdwAv6PrTu+b0NSdEmyCa/l3nU2V44eQxtfh0gda?=
 =?iso-8859-1?Q?vOa5bWe+waZ+xfYN9Tmr87/ReePWxewGk5IqL9DpOtXdWOiSTXB/1+fJSM?=
 =?iso-8859-1?Q?2eC66WWgOVUuyqKSTyJFhvq2+KnwKZDrdnXGHOP+0TXvOG6+g2VQkSbj6O?=
 =?iso-8859-1?Q?c3i+VmEairLtY+VkJmqjkimajKg7y9iav66kJiOBE4hJvMJtvusogOSh5A?=
 =?iso-8859-1?Q?eVLEj2mKRRupb9s7tzvfGtPO6pLpAEhCj9lekOsCTBj/VHNDbiJbK1qxpZ?=
 =?iso-8859-1?Q?dMfCMa8eGXfnEzmE/lxdJp5IMPxXQo0L3hFVo/hgykwWE2VgMejYLi9yIU?=
 =?iso-8859-1?Q?/+w0eU74nAA/rnTz1BM6HEfc5JlaZyPP0QX8024lZsKdPHH9ovHLPYYSNl?=
 =?iso-8859-1?Q?YiH2GXkqXmtdbpxy5ibYuoPJzkQ1kd/6+zLjywPzqgC5CxzxqlRjZPz5wE?=
 =?iso-8859-1?Q?JzRed+jkCG7yaCCvSIJMKSoC/PwpP/hsokHZIQeZwBKaoHgPrwB+cHPzR/?=
 =?iso-8859-1?Q?tBAQfhJZEU0apzNaRApZcDGZCueSd2OGN298aR3v+b9VhB7/9huooEouxt?=
 =?iso-8859-1?Q?h118e44WbzH6Ypze0cBXxE+zr0ExC0LEcbetAbdlI/RyVd+/kpnlT2wqlY?=
 =?iso-8859-1?Q?NDdGYcV52q12f5Ku/3HBF4BOzKXhX1TdtOu4LMQ21SYH9Grn3ps2y+8ja1?=
 =?iso-8859-1?Q?YO7cmk4r89CLMFBGLibZfYHXNl080d7bE9mi2604zaH4uCSOjixXQHo0Tm?=
 =?iso-8859-1?Q?2rG13fV13PnJ1a+eZnFulHjCC0h5zbjLiEZRcmp2FEKNp5ZWYAD3BaQeai?=
 =?iso-8859-1?Q?CYodKTC7ETOuTioMHJcq4sVU+HZzpTSc3G0w0hnj9eXHWtNLmXAkfDTzj7?=
 =?iso-8859-1?Q?Z+FW0JFvHdfl5uBGaomyzUb3cFD8N63vKYER+5HS1X9cAaiZ0jojUlTTyC?=
 =?iso-8859-1?Q?kApMJZMt9Li9hm8oFBsZs6mBMRbMV7AW5lEj7jWwWGmQO6KdlPt5LfYkC3?=
 =?iso-8859-1?Q?EbWFi5f+w8kbg72Yi/DBEKZh6zx8C2C1KayBykYmWobeAuaFYB7M/Ourwm?=
 =?iso-8859-1?Q?qAtIfhs46VMb3mnNBAKnniYeWMwb0T9Oqa6atNdl8FQ5ZR2kdpcmMRR3sc?=
 =?iso-8859-1?Q?egG6qQn+ipiTL4kPw7oQb+PbtSwZJNUvYKA2Stbn9HCrCVSJp4xo1g9NE0?=
 =?iso-8859-1?Q?nAhAFq0Wo4V3XX5gsikYcopDOGyL4YYdTpGgATU21bTGTwtk5O11/T/sHL?=
 =?iso-8859-1?Q?cSu/dqDI1VCxGdJYFKwGDDdzykWRpNlAV99cALptJF8miQeyNs+XZjEIlx?=
 =?iso-8859-1?Q?QA5wYfNZX1qDNxctoDrkuh5pAAL2DNv8OwDUkb/w+wXyoCDroTADtT6IQc?=
 =?iso-8859-1?Q?1SO+GDpiesaIf3iavQlittaUMur832mdpHFW3JQ07ARTzDBaK9k41cbcf/?=
 =?iso-8859-1?Q?02g69l82W94sY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8233DABD201A97C7A71D8D2C86EEACH3PR12MB8233namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8233.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871cef9e-a55c-44eb-c02b-08de06dc0daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 02:32:12.4525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkNbIaSnWerREpnQJRdl4AWKsUyL1mBdhmOZpYtFybODjFj+k8O8Ul+mH3rI94u+tbhc5frNoURM83LA8K1D2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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

--_000_CH3PR12MB8233DABD201A97C7A71D8D2C86EEACH3PR12MB8233namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Pavan,

Please find my response inline.

________________________________
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Sent: Tuesday, June 10, 2025 7:59 PM
To: Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>; david.hunt@intel.com =
<david.hunt@intel.com>; anatoly.burakov@intel.com <anatoly.burakov@intel.co=
m>; Jerin Jacob <jerinj@marvell.com>; radu.nicolau@intel.com <radu.nicolau@=
intel.com>; Akhil Goyal <gakhil@marvell.com>; cristian.dumitrescu@intel.com=
 <cristian.dumitrescu@intel.com>; Yigit, Ferruh <Ferruh.Yigit@amd.com>; kon=
stantin.ananyev@huawei.com <konstantin.ananyev@huawei.com>; mb@smartsharesy=
stems.com <mb@smartsharesystems.com>
Cc: dev@dpdk.org <dev@dpdk.org>; haijie1@huawei.com <haijie1@huawei.com>; s=
table@dpdk.org <stable@dpdk.org>; Ande, Venkat Kumar <VenkatKumar.Ande@amd.=
com>; Dengdui Huang <huangdengdui@huawei.com>
Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size bas=
ed on Rx burst

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


>>Previously, the TX burst size was fixed at 256, leading to performance
>>degradation in certain scenarios.
>>
>>This patch introduces logic to set the TX burst size to match the
>>configured RX burst size (--burst option, default 32, max 512)
>>for better efficiency.
>>
>>Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
>>Cc: haijie1@huawei.com
>>Cc: stable@dpdk.org
>>
>>Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
>>Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
>>Tested-by: Dengdui Huang <huangdengdui@huawei.com>

>It would be good if the selected burst sizes of Rx and Tx are logged.
ACK

>On CN10K platform we see upto 5% improvement, and upto 30% improvement on =
CN9K.

>Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

>---
> examples/l3fwd/l3fwd.h        |  8 ++------
> examples/l3fwd/l3fwd_common.h | 11 +++++++----
> examples/l3fwd/main.c         |  2 ++
> 3 files changed, 11 insertions(+), 10 deletions(-)


--_000_CH3PR12MB8233DABD201A97C7A71D8D2C86EEACH3PR12MB8233namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Pavan, </div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
Please find my response inline.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Pavan Nikhilesh Bhagavatula &lt;pbhagavatula@marvell.com&=
gt;<br>
<b>Sent:</b>&nbsp;Tuesday, June 10, 2025 7:59 PM<br>
<b>To:</b>&nbsp;Tummala, Sivaprasad &lt;Sivaprasad.Tummala@amd.com&gt;; dav=
id.hunt@intel.com &lt;david.hunt@intel.com&gt;; anatoly.burakov@intel.com &=
lt;anatoly.burakov@intel.com&gt;; Jerin Jacob &lt;jerinj@marvell.com&gt;; r=
adu.nicolau@intel.com &lt;radu.nicolau@intel.com&gt;; Akhil Goyal &lt;gakhi=
l@marvell.com&gt;;
 cristian.dumitrescu@intel.com &lt;cristian.dumitrescu@intel.com&gt;; Yigit=
, Ferruh &lt;Ferruh.Yigit@amd.com&gt;; konstantin.ananyev@huawei.com &lt;ko=
nstantin.ananyev@huawei.com&gt;; mb@smartsharesystems.com &lt;mb@smartshare=
systems.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; haijie1@huawei.com &lt;h=
aijie1@huawei.com&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;; Ande, Venka=
t Kumar &lt;VenkatKumar.Ande@amd.com&gt;; Dengdui Huang &lt;huangdengdui@hu=
awei.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx bu=
rst size based on Rx burst
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">Caution: This mess=
age originated from an External Source. Use proper caution when opening att=
achments, clicking links, or responding.<br>
<br>
<br>
&gt;&gt;Previously, the TX burst size was fixed at 256, leading to performa=
nce<br>
&gt;&gt;degradation in certain scenarios.<br>
&gt;&gt;<br>
&gt;&gt;This patch introduces logic to set the TX burst size to match the<b=
r>
&gt;&gt;configured RX burst size (--burst option, default 32, max 512)<br>
&gt;&gt;for better efficiency.<br>
&gt;&gt;<br>
&gt;&gt;Fixes: d5c4897ecfb2 (&quot;examples/l3fwd: add option to set Rx bur=
st size&quot;)<br>
&gt;&gt;Cc: haijie1@huawei.com<br>
&gt;&gt;Cc: stable@dpdk.org<br>
&gt;&gt;<br>
&gt;&gt;Signed-off-by: Sivaprasad Tummala &lt;sivaprasad.tummala@amd.com&gt=
;<br>
&gt;&gt;Tested-by: Venkat Kumar Ande &lt;VenkatKumar.Ande@amd.com&gt;<br>
&gt;&gt;Tested-by: Dengdui Huang &lt;huangdengdui@huawei.com&gt;<br>
<br>
&gt;It would be good if the selected burst sizes of Rx and Tx are logged.<b=
r>
<span style=3D"color: rgb(0, 0, 0);">ACK</span></div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><span style=3D"col=
or: rgb(0, 0, 0);"></span><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">&gt;On CN10K platf=
orm we see upto 5% improvement, and upto 30% improvement on CN9K.<br>
<br>
&gt;Tested-by: Pavan Nikhilesh &lt;pbhagavatula@marvell.com&gt;<br>
<br>
&gt;---<br>
&gt; examples/l3fwd/l3fwd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 8 ++------<br>
&gt; examples/l3fwd/l3fwd_common.h | 11 +++++++----<br>
&gt; examples/l3fwd/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 ++<br>
&gt; 3 files changed, 11 insertions(+), 10 deletions(-)<br>
<br>
</div>
</body>
</html>

--_000_CH3PR12MB8233DABD201A97C7A71D8D2C86EEACH3PR12MB8233namp_--
