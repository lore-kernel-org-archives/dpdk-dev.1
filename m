Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB810C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 08:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 814A9402D2;
	Mon, 24 Mar 2025 09:32:13 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by mails.dpdk.org (Postfix) with ESMTP id 58EBB40151
 for <dev@dpdk.org>; Mon, 24 Mar 2025 09:32:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3ibC0APb7hkWg1u6UQRHsDOnMoNCgFNfxGpHjd9tXNxqj+Y98J1XQd/eD4GmPnY16AiLWS7lnsHfpWSekt8egOvgsQRa+W1hkfIQXOz0iZcaiHEnpRhNE7lzxf2XviwFIAPepZ0I/hyFHY+laeIbe8u1X3WA9IVanBrRNlcCWmjoyLcSEud5gHoMojb4hzuQG6QkzBR0U3DoO2oVq/XCn8P6oVP2Rx7tg2x0kDB+X0Qs7HZi5AKcqI21Q2e3zNUPnmQLrbB/0v3sQ6QQtL94RbpsTrMQdX+35c9UenGweF90MpqnejzAPUo24MDKPmU6hOx+NyVxKv44KlE3hdlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TEIO6T8x0mqMZVXk2tvzI+KuDZNAahQdBx7T+LqKWw=;
 b=kV5WcGOR0bpBS2AXDrxlDJrGzn19H8NcC+HIVDHEEx/bjIKJ/7/awrXqpFwgcgv6uTCPAUr/PYaxsjzDB9pT89N5w+J8ybmQkfk9x1jeStKUxa5/MT7WSX2VsTr7Jw92tyQBhLoRb6lGxH4b2ClbR6/wLTm6YDvSN2XuP+fna7FHb1Cz9RNdesdhLtZGW1XOCost6ihWihTFlXtIhrnP+y5iwZPmCR+E+E27BQl2Vej+qlgJ53fDDMGR7wVlinaTIRj27B/0qqe9e916a/MMs4ZHGLTKxq05UgDLLOh1aR9zJFyW775JL/Zjefi22Cel58JvdFBIcTraVVMJ2RoKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TEIO6T8x0mqMZVXk2tvzI+KuDZNAahQdBx7T+LqKWw=;
 b=ujqNNxt6/B5noDJv/W4MKm99TorN5hQ7ATbRYSKSJVKP88abj1FB9AUj8Kdrk861VYBJoHohFpPnlup1xl9kFVAENR+P8LfjQCJfhoWWgBL3S3CMi+3U84rTGyD6uuJldtVBGL8gnOtPYP8GpdzteLNZD9FihXE+8pKCY+fwNLfAQ3xfWcvukyX/0Vbm0kSjzGMHQGL1Wyc3uNTzgYJvJ1XLi4N+FWpKMF0j/2KTrd2gL2vPusc+TiCe8ZLE2cA2LPSeQkY5zrd/w8RFLVvdiLeiqGg8Day/zquvn91WZQz4jR6F7U9PHwV5N9RRB7faRAzJyyeyatRBk9TC4Orv/g==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:32:08 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:32:08 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: =?Windows-1252?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Stephen
 Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Topic: [PATCH] app/testpmd: fix VLAN header parsing
Thread-Index: AQHbm+8qBy++gaakq0m8DcV6iO248LOAszuAgAEyu+qAAAERkIAADmsU
Date: Mon, 24 Mar 2025 08:32:08 +0000
Message-ID: <CH3PR12MB84608270E82932227FEF61E5CFA42@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB3D@smartserver.smartshare.dk>
 <CH3PR12MB8460B2A2A61615F589182A32CFA42@CH3PR12MB8460.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB42@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB42@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SN7PR12MB8004:EE_
x-ms-office365-filtering-correlation-id: 1700df15-f33f-497d-2c78-08dd6aae5da5
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?x8cbZv22ciFcV5S1SEeMfFL8OJu7JyYsH1tzfTYuLy8KZhlhR/H9hc1A?=
 =?Windows-1252?Q?eVVdisN52P3NUApHHYGmIr2oEcqS9P6Yiajp2gxs6PSCOZT0U8NmgZov?=
 =?Windows-1252?Q?0ioBhymdwT3FFziL6kXU07I1h3p3ply7lakeMVl9dSLlkgUHhJVeXzP2?=
 =?Windows-1252?Q?At2pfy++Oi1CytqLrdK9IXJM5bG9a33K8i4gOYLmHR00mcKlkbymUmRS?=
 =?Windows-1252?Q?7oHh3GggWBsFkgoDYPexFzAVQeq8B52BTT227z9J63EBq613LFNEPfSi?=
 =?Windows-1252?Q?rkXdqoAX9HAW2pmxBjMbINeXW/VVvqcWEWEL6GEYM8ybrrscidf9Oujn?=
 =?Windows-1252?Q?5y35/Oi6E/ucZJJ6oP1D9A8NMiKAeLqCXoLGwbVfQdmlRT1yR8QESE5O?=
 =?Windows-1252?Q?4ml9Nd4xWfrrZop/x1nVI3ZF6jtuA7rp1uYpEAofHDSrh6vXWIHEFLMJ?=
 =?Windows-1252?Q?B5rlhB5ezct5nTpvcGyt/vkRo9GpAxa6DFM5cT1hdnIvPPmJVsdB34rD?=
 =?Windows-1252?Q?Vyq7fDNNObkHbnEZpdYO6W9L3Bufqlxl2uOlGv/o9DfT3bE4hwVVUabj?=
 =?Windows-1252?Q?1tavfdpFmZlfZee9voHUV95Sz7q7QyVvqxE5C8JjHCw/KXwF3qXs900c?=
 =?Windows-1252?Q?+XSnfA20BkIpd4RpjnZDjL50xFkb7o4Ws3qzTHiJnIfOd44Cm7DcKXEx?=
 =?Windows-1252?Q?NPJg7my5/9XMVRG369PqKnQ+yFfJf92ir6BUDCHQMKpPFrH8QLNGcilp?=
 =?Windows-1252?Q?3iYGGLJSvEl3GfP9AhknGyQ7R2ke3lap9fwnW9PzLpTmDGfaXxzds8JU?=
 =?Windows-1252?Q?uEQywJQpz+GDW+yqrNKKEjQZ0qW+fMjFQ4obUtWAVmA+XZy/u09JtCfw?=
 =?Windows-1252?Q?LaZ7KpusYr06FGe8aRRnJ5da6Hvz7qH9RKRkp9yUDlghGyO/JHcwo2b7?=
 =?Windows-1252?Q?noQ0FOITjGSC0VmlBFMVLEwTCEwbg4XEFLid0iiQOiBZszd8kDuE0cim?=
 =?Windows-1252?Q?nDF4j7t363SsikW0yWJTpjXKGlg/g8N3v+zaq0Jxe15SZbA0D8QfFUS7?=
 =?Windows-1252?Q?GlHbldBahUnhqz4uAhF6ieA+5ZjwGuO8BDe+dXiyIEbqAhwoKPmi00so?=
 =?Windows-1252?Q?7PFg04sfpTpuQsQ3Er44p3d4n6CQJFw4U6bgfzpf6BgBZmBiFTsp08UI?=
 =?Windows-1252?Q?Z6kkEA7eqVrqJhT77iflplRON2p1b0yrUyMzCT0KjflmITs2ilyXAL31?=
 =?Windows-1252?Q?qy3BASZo4ICwzrcDNYpw3/CoFiI1kgpCEYtXX8CUJN9wB1hBjW2xLYV4?=
 =?Windows-1252?Q?75ZvsqPYqx4PnrhsbY3g97KYKfDIKqqIr3ddQpwgoQg9Ie1j4UclTyqX?=
 =?Windows-1252?Q?cAd570QcXA3OcssQY42/HWHK1zTO3/13nFj2SihXzqSX/kwC4o8e68/L?=
 =?Windows-1252?Q?M4tW+gdUaQ8UVk482OUgmYyM+LauI1tItiAImL9lvZ+g5QYMexknNf+l?=
 =?Windows-1252?Q?kZ2iE3Ukg+tpFD1DRrOkR+RMNYNNJ+jVfoPRZ0j4IF3bQgMyurQdLMd8?=
 =?Windows-1252?Q?XV1TQhV6hYBiaiWtsGN9KEGA4LaoSmmk/X/M6Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?14OXLCbNaJb65PXEMKsMligqeAjBUlu+XNin1I1uBhw6P9xKw1apZ0Gl?=
 =?Windows-1252?Q?1XPNhm96BVxLJe/MRDmglnyyXgQqbTDRUMbvS2PUqpO575BFhgYhex+K?=
 =?Windows-1252?Q?uf/I+Vpjmv3jbEZEBetxSngv10XnxfS07eKMyYZmgdHouXGre0VDuSYj?=
 =?Windows-1252?Q?btFbl69HgGiI2oPyYFpI5vJGKKdJvyq0+cJJ3Wjfyxm8l7MkHrzEK/bW?=
 =?Windows-1252?Q?Jt7SgT+g592uTIeLOQGJIxmchrVvXAcgVeF+P+3v9DkL1GmFs2+bVTk2?=
 =?Windows-1252?Q?uhGbzEA6FB84guZHKq+IoANAy1OIw9NSr7IVCdx6Q5OrW5ViEC7XOYS9?=
 =?Windows-1252?Q?lSWTzeqgREIyaQ8pvv/qkl0X8bk+aOQ7Kks0XVhrW9mlV3MDeyR6vuW4?=
 =?Windows-1252?Q?idfBo8N9eI3oPgWsXItJ8qyzNuARg8L3gc1mrAHYrbfCT2rxU83ndHBG?=
 =?Windows-1252?Q?NFtnLVInpZm1STpcP38juF1C+FHY14e+/+RsCXPEjQlzaYJRQQnnMN3I?=
 =?Windows-1252?Q?0HnOjnsJ7Fd1rckirz3z6pArPm7euqon+34Mhf1rfDcpxL6odhAwB19z?=
 =?Windows-1252?Q?a+dTfSSQzS0/qCDXHyjKvRcGXnDtrYXHRE5df/bD8o/A+9BsyC8dgs0Q?=
 =?Windows-1252?Q?HNFmEOOUj5A0ZO014HXY0DmgeI0Ao86D+GrQrI60aSiGiZ9Gt3kNAu8S?=
 =?Windows-1252?Q?3Ra4rZHsq9Xs2kFQxg2VthVbkaw6Cd8SbO/kPye6EeCoRfGS4w3XS4qn?=
 =?Windows-1252?Q?+nS9tAtpGR8QEVlCOxz+dcXcspxFgNIOQnEavNGQ5TTsUp14TuME+gda?=
 =?Windows-1252?Q?/0GTn4YBzNs1YfAiVzuDHzSFbTPuXlE9rbInfySMigWMlmtmjUF/xdVG?=
 =?Windows-1252?Q?kG8r2iz43P3N7EH50QgZ3a9+fnM7GEHEeKTOGFd8r4rLuM9mNFYGqR9k?=
 =?Windows-1252?Q?97NAzHo5s3gMwRYaV+VqocVPul/wX6Nh8NvQV//jGNgE32MARqsDB6Sg?=
 =?Windows-1252?Q?MfwmGAI6ijeA8euIy7H8I30jnyXvlPMRR8Ud5aYim7+Kz0MIi8NzmXDz?=
 =?Windows-1252?Q?1OtYUP0xtbMRot0MTAokx/GEH/X1mA/8j2GfzOwPXhMDx3TJPEMD2Bes?=
 =?Windows-1252?Q?PnMQa+NsY6fw8cNKuXh+JFF8OsVpyTLQKcNVFDZLCjPSbFvG9TbH//UM?=
 =?Windows-1252?Q?Z0hB8AQDHwaID5SHpwdKxvcv5n7JnnkHjpm42558Y6vnR1cNU6r6QCve?=
 =?Windows-1252?Q?L6F9rlck68xlDkpLg2da0+jAYZeqH/M5/7J3ZX08PWk4F6H5THVSgXWx?=
 =?Windows-1252?Q?BbhhW52eZABBWknkXxr7mg1Okj6Lvk9292u8MZ1uwy7DfGkbu4v6Qd9P?=
 =?Windows-1252?Q?t0vT7DWw7iol+2zFeG0GZ05wMsBS0OnUx09XEncu4qt6fabg8bfplxUz?=
 =?Windows-1252?Q?zwj0NI8K7UC7II+pIPNFyZWjQqPkPMggbldmLgcSSKtEK4lh79f/svKM?=
 =?Windows-1252?Q?IWFdAM5+H6xWp9JD2VQPVrLhc4Eh2wANVzF7esQ64zd3Gzi0CFUqfrMY?=
 =?Windows-1252?Q?cPKGOr2vjWpx3mjMSIab12oK/qzGgExiT1V7AlfKbpaZVXX4o8kDdZ6g?=
 =?Windows-1252?Q?nVGo8W10LC6uGP+b5JEG2tj4cX9ylaCc85FTjkyibT43zeoJ2HpDKxIT?=
 =?Windows-1252?Q?OvR1SwgbFM5I67sbsT9YxZ7g4xk2SU0Xvd+D6wBMn7AEb+obyDTzrw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB84608270E82932227FEF61E5CFA42CH3PR12MB8460namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1700df15-f33f-497d-2c78-08dd6aae5da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 08:32:08.4041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4rslcdzCCYoQ/dhSBHqhkDFNd0K24CwUvwqYcV6nT2jUQuzuzJCQ79YKpf94It9+2Q3jW7paW7iEEb3/8BraQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

--_000_CH3PR12MB84608270E82932227FEF61E5CFA42CH3PR12MB8460namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Comment inline below.

From: Raslan Darawsheh [mailto:rasland@nvidia.com]
Sent: Monday, 24 March 2025 08.35

>> From: Raslan Darawsheh [mailto:rasland@nvidia.com]
>> Sent: Sunday, 23 March 2025 13.28
>>
>> Updated the `get_ethertype_by_ptype` function to correctly parse VLAN
>> headers.
>>
>> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
>> Cc: haijie1@huawei.com
>>
>>> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
>> ---
>>  app/test-pmd/csumonly.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
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
>>
>>        switch (ptype) {
>>        case RTE_PTYPE_L3_IPV4:
>> @@ -486,10 +487,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr
>> *eth_hdr, uint32_t ptype)
>>                return _htons(RTE_ETHER_TYPE_IPV6);
>>        default:
>>                ethertype =3D eth_hdr->ether_type;
>> -             while (eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_VL=
AN)
>> ||
>> -                     eth_hdr->ether_type =3D=3D _htons(RTE_ETHER_TYPE_Q=
INQ)) {
>> +             while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||
>> +                     ethertype =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {
>>                        vlan_hdr =3D (struct rte_vlan_hdr *)
>> -                             ((char *)eth_hdr + sizeof(*eth_hdr));
>> +                             ((char *)eth_hdr + sizeof(*eth_hdr) +
>> +                             (i * sizeof(struct rte_vlan_hdr)));

>Doesn't work; "i" is not incremented, and remains 0.
>Instead do this: Initialize (struct rte_vlan_hdr *)vlan_hdr=3DRTE_PTR_ADD(=
eth_hdr, offsetof(rte_ether_hdr, ether_type)) before the loop, and move vla=
n_hdr+=3DRTE_VLAN_HLEN inside the loop.
Yes you are correct I had a (i++ *) but must have slipped while rebasing wi=
ll handle your way in v2
MB: Noticed a bug in my suggestion: Due to the type of vlan_hdr, moving it =
should be vlan_hdr++, not vlan_hdr+=3DRTE_VLAN_HLEN.
                 Yes sure will handle,
MB: And you might want to impose a maximum boundary to the loop, as suggest=
ed by Stephen. E.g. break out of the loop if vlan_hdr>RTE_PTR_ADD(eth_hdr, =
offsetof(rte_ether_hdr, ether_type)+4*sizeof(struct rte_vlan_hdr)). Support=
ing up to 4 stacked VLAN tags should suffice.
              I=92m not sure this should be added to this patch, as I tend =
to believe it=92s less critical to handle for this release, and also, this =
might cause inconsistent results, think of the case if we send five stacked=
 vlan tags, then we=92ll return ethertype as VLAN as we skipped the last on=
e.

>>                        ethertype =3D vlan_hdr->eth_proto;
>>                }
>>                return ethertype;
>> --
>> 2.39.5 (Apple Git-154)

Kindest regards
Raslan Darawsheh

--_000_CH3PR12MB84608270E82932227FEF61E5CFA42CH3PR12MB8460namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-PS" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Comment inline below.<=
/span><span lang=3D"EN-US"><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span lang=3D"EN-US" st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1=
F497D">&nbsp;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<b><span lang=3D"EN-US" style=3D"font-family:&quot;Tahoma&quot;,sans-serif"=
>From:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Tahoma&quo=
t;,sans-serif"> Raslan Darawsheh [mailto:rasland@nvidia.com]
<br>
<b>Sent:</b> Monday, 24 March 2025 08.35</span><span lang=3D"EN-US"><o:p></=
o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span lang=3D"EN-US">&n=
bsp;<o:p></o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:72.0pt">
<span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;&gt; From: Raslan Daraw=
sheh [<a href=3D"mailto:rasland@nvidia.com">mailto:rasland@nvidia.com</a>]<=
br>
&gt;&gt; Sent: Sunday, 23 March 2025 13.28<br>
&gt;&gt; <br>
&gt;&gt; Updated the `get_ethertype_by_ptype` function to correctly parse V=
LAN<br>
&gt;&gt; headers.<br>
&gt;&gt; <br>
&gt;&gt; Fixes: 76730c7b9b5a (&quot;app/testpmd: use packet type parsing AP=
I&quot;)<br>
&gt;&gt; Cc: haijie1@huawei.com<br>
&gt;&gt; <br>
&gt;&gt;&gt; Signed-off-by: Raslan Darawsheh &lt;rasland@nvidia.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; app/test-pmd/csumonly.c | 8 +++++---<br>
&gt;&gt;&nbsp; 1 file changed, 5 insertions(+), 3 deletions(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c<br>
&gt;&gt; index 5b906eaa53..302cc4cc66 100644<br>
&gt;&gt; --- a/app/test-pmd/csumonly.c<br>
&gt;&gt; +++ b/app/test-pmd/csumonly.c<br>
&gt;&gt; @@ -468,6 +468,7 @@ get_ethertype_by_ptype(struct rte_ether_hdr<br=
>
&gt;&gt; *eth_hdr, uint32_t ptype)<br>
&gt;&gt;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_vlan_hdr *vla=
n_hdr;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t ethertype;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt;&gt; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ptype) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_PTYPE_L3_IPV4:<=
br>
&gt;&gt; @@ -486,10 +487,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr<=
br>
&gt;&gt; *eth_hdr, uint32_t ptype)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return _htons(RTE_ETHER_TYPE_IPV6);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ethertype =3D eth_hdr-&gt;ether_type;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; while (eth_hdr-&gt;ether_type =3D=3D _htons(RTE_ETHER_TYPE_VLAN)<br=
>
&gt;&gt; ||<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_hdr-&gt;ether_t=
ype =3D=3D _htons(RTE_ETHER_TYPE_QINQ)) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; while (ethertype =3D=3D _htons(RTE_ETHER_TYPE_VLAN) ||<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethertype =3D=3D _h=
tons(RTE_ETHER_TYPE_QINQ)) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vla=
n_hdr =3D (struct rte_vlan_hdr *)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + sizeof(*eth_hdr));<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ((char *)eth_hdr + sizeof(*eth_hdr) +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (i * sizeof(struct rte_vlan_hdr)));<br>
<br>
&gt;Doesn't work; &quot;i&quot; is not incremented, and remains 0.<br>
&gt;Instead do this: Initialize (struct rte_vlan_hdr *)vlan_hdr=3DRTE_PTR_A=
DD(eth_hdr, offsetof(rte_ether_hdr, ether_type)) before the loop, and move =
vlan_hdr+=3DRTE_VLAN_HLEN inside the loop.<br>
Yes you are correct I had a (i++ *) but must have slipped while rebasing wi=
ll handle your way in v2
</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif;color:#1F497D">MB: Noticed a bug in my suggestion: Due to th=
e type of vlan_hdr, moving it should be vlan_hdr++, not vlan_hdr+=3DRTE_VLA=
N_HLEN.</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; Yes sure will handle,
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif;color:#1F497D">MB: And you might want to impose a maximum bo=
undary to the loop, as suggested by Stephen. E.g. break out of the loop if =
vlan_hdr&gt;RTE_PTR_ADD(eth_hdr, offsetof(rte_ether_hdr,
 ether_type)+4*sizeof(struct rte_vlan_hdr)). Supporting up to 4 stacked VLA=
N tags should suffice.</span><span lang=3D"EN-US" style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I=92m not sure this should be added to this =
patch, as I tend to believe it=92s less critical to handle for this release=
, and also, this might cause inconsistent
 results, think of the case if we send five stacked vlan tags, then we=92ll=
 return ethertype as VLAN as we skipped the last one.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:72.0pt">
<span lang=3D"EN-US" style=3D"font-size:11.0pt"><br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth=
ertype =3D vlan_hdr-&gt;eth_proto;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ethertype;<br>
&gt;&gt; --<br>
&gt;&gt; 2.39.5 (Apple Git-154)</span><span lang=3D"EN-US"><o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<span lang=3D"EN-US" style=3D"font-size:11.0pt">&nbsp;</span><span lang=3D"=
EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<span lang=3D"EN-US" style=3D"font-size:11.0pt">Kindest regards</span><span=
 lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<span lang=3D"EN-US" style=3D"font-size:11.0pt">Raslan Darawsheh</span><spa=
n lang=3D"EN-US"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH3PR12MB84608270E82932227FEF61E5CFA42CH3PR12MB8460namp_--
