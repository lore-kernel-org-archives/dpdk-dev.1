Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410F0CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 409864027C;
	Thu, 15 Oct 2026 16:11:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id DA84F400EF;
 Thu, 15 Oct 2026 16:11:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792073504; x=1823609504;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=0qJo7AORIqscAv9W1FJGjCAYuH3uNOrVSKv9Z08XB/0=;
 b=kvJVtzbx4WMVgtjR49XIcu54r/vM9NviZ8vxVc7h1pq4gFVssN4kcFKh
 XBs1pgfeEchpLcFCkgAoQekKrO47eoqMst89zDYUZIxE9F7+aqwE63PWm
 NRY558Pwcb/WdJ+vVix0Go8i4hUyhlcmIUwhS4XeOjJ+YClRHHknFK4Fu
 VlczLFp0/ZHd4SWZ7p1A/Sf48iVThy3J4y4SPafppFnHYcuG2HR0XQi1a
 TPz3+RUJ/A6KnuM4JgRvc5uivtBuRrU4sDbollem+g5VjaJm1EtVcNhz6
 x24JIKiJlR+ZQYV2XEyuZe3a20DZypcTSLPok/SA++jkAF5Yk9MsMbrTn w==;
X-CSE-ConnectionGUID: MozDWA3eS6yNMWCboq7qMg==
X-CSE-MsgGUID: Xcb/H8KaRDaz9HoVBpHzaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="748669"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="748669"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:11:41 -0700
X-CSE-ConnectionGUID: fdXTxAAQRe6NWiniEfwuVA==
X-CSE-MsgGUID: hiB9iagwTsaBsk9s6fAMeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1678004"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:11:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:11:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:11:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:11:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTczpw9hGxC1xYjnjx8ii9xuPNZwXjGNRrAh0lYh64sY140JWYc9LuDr61Fz3uNCLSBdj5AlwADV1ZrPJF5trmy4lDSb09f6EFE0NBZJl+fVNBb4Tr6vRz3SYYTSrF2NKP2eOhNeY1Xq69k/8CnN3h5S/nvPdg7NdV95dXyTICrKRdkrvTZGgBSYcqehDHIr/c3eEVxGDxpXwSQD04yi+2x02tV08AJf+OSNfq0yJuyhbImT2cE8NZ9023TTdWfzVlQHHpWM24QP+RioUdKojO2/cxf6oU6DgXb6rE27rWfHaOKOPGor/Pamw4YpTjG6/kflMtF8PnAlm/uEIetMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HlZv0aSP/d1ym4jMHueGvjLqDg8UwR8papF6LWnWf0=;
 b=CrKU67vIkSivEBCtzjd3m55eG8xSRRLIXgUIss5Z1W96O+SynN3NmHCdF3vvs7OmThkvjK73Cadv8KRZZxmbDbVDWGdaCU+o2bP0b6m3KVzOjRueuZTMtGHa4WTDyUJGV5yJUfw9AJtRwM1/XOcXMTwex6uwkDFuTrNaeZlV1axnUzblAa6tOVAExTgUad6hb14gAPrdQLI5peENVvweZppx447/zkKk/Ci03R4BQ0lXpM0ADsaDIwU1ueGVBzBzaClmQ1nvzvCjB/RJxJHD/FHI9jYTS8TAE5Q28xPUfLmB6xFhZX8mwyGk6K+LadCI1hHJm1rzxtWBryMlCxmwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:11:38 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:11:38 +0000
From: "Richardson, Bruce" <bruce.richardson@intel.com>
To: dev <dev@dpdk.org>
CC: DPDK Techboard <techboard@dpdk.org>
Subject: Minutes of Technical Board Meeting, 2026-10-14
Thread-Topic: Minutes of Technical Board Meeting, 2026-10-14
Thread-Index: Ad1crxdE3FCPX/vIQlOpj0VIgIO1Rg==
Date: Thu, 15 Oct 2026 14:11:38 +0000
Message-ID: <SN7PR11MB8066BB403CE3C86A95E80682979C2@SN7PR11MB8066.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8066:EE_|CH0PR11MB5283:EE_
x-ms-office365-filtering-correlation-id: 8eae913b-10f4-4f6a-e364-08df2ac63a78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|10067099003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: 8oup7IKOhVwOcyGuFW/Ax+S9gTT1JyjYL6ApDXd1fID8SyGrB9KQP52fsSeWhMH9LtujVOs3gEyfFBKnmoh+P+5pBqrNguzvDg/DfiJW36HLjU/WN/aDBfrgwTr293jl2UN8pp3lS53pxWfu7dON67DLrJ9KkPIvXDxQMydUBCxXpUIFSUCVDadXhx5sa2D1RU6maw5/RFNlsBFrUW2+J3XlxqXQWjKFL+085w2jJZ73XBaxvXE9nvEyJsKDIV1pjzMG//SF6E0EqtM1VnemqYyaxKWM/hnYZoKv54n8uKaDe6YDd1gycahTkPXrTAXYu/1hKZKUP04gx33J965132mMjDSXYz0PbXqyeBvMaDwyTNu2w8891YT4v+41WPkyoV6oH6xeG1wAI2qTtlaDihLFMbg+JHtVuOtEN8EP81tPoBaaFvIgbH2YlHHh2iZH1Lv5T5jX5mpp7qIDM+yzEyIMzCDy3UcGk8Z0vqrvelp7yl8dhHjtDqmN/9NYDEyYlpDHZNbrhXwOKYNJCHBwc7GzOtQwOISUNnhXQnYrkVQb+RhpBPaUO7QwBCtp3IjrMoAbaETP7FLpICqcxqUGW/CYZPVOEBPcPRyC/Md/WUzjsITmaZNCeQC9qwaKiQ8ytieNrSsX98N766wZfKT5C7Hcqo430pQT2CB5Jn2n4vI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iALj1OPhtPjBlIU36I27rVd/La3e+tJGdrZZ9zbzeSbVsAqnA9S6A3VgTO?=
 =?iso-8859-1?Q?Z8vN++dZgFmpFUeV4lNlrhNGex//hJxRXe/vdZROPZtAsuH+9PSMBKpvXO?=
 =?iso-8859-1?Q?YcMi9hDlM4NLlk+4q2iwAZAqu3pDZ03kvT6Itemm6mx3veLQHoDXUq6mVF?=
 =?iso-8859-1?Q?pMobbJjKMxS6eHgW/ZpAJ9UMnH49em8Ck2kZyPcxXjqZ0SKqY8IWgxAN3j?=
 =?iso-8859-1?Q?hnM78CLnO+OQI2pi/n2nChqQJIY/UsbALxXvdTWQ8MdvM64QmogFtiE5Or?=
 =?iso-8859-1?Q?nBTym5vxYt6lRROwcxlHHYOBJdc6EEOooqW+4ZbAMRK6JkFb2efDMtr4dx?=
 =?iso-8859-1?Q?xH6AwCSzqI/cKmTDw+SeMsPl/OxV//sqloTsJhOONvPQXbugL03M1ZNr+N?=
 =?iso-8859-1?Q?vRc1aabZt2WR+SYnb4xTP58IHLEXfisSUHnRqFOomDgowxYSw1l67DDthn?=
 =?iso-8859-1?Q?+zfANzup3Do9PBcfEnmPibNjKW0whxubaj2skWFg0afP0rUudl7zkPB2TG?=
 =?iso-8859-1?Q?X5mZAd6fj/pMc0tgIZr8ZGmenT8vacwtI9m3KgX6/+IK0pdqay+AMqP5mG?=
 =?iso-8859-1?Q?EuJUrg/ecyYj0hxUtZ6B7+d8rTj40FrWaAZ0CPLSW8P/waJhF+v/dG062s?=
 =?iso-8859-1?Q?TrPyhXFHTz2Aeks9kSZLjCCcROFw+Ep4hA8aKbgpV7Zl3131My9yYgbqdx?=
 =?iso-8859-1?Q?mtUhgn5CA8Q+eE42pZYpcgwGk38WO1tVQTjlGfTldewtblmzQOlQmIa2MI?=
 =?iso-8859-1?Q?CTnsEA97EOFHowZ6sxr8OGd0HjdL5876FQhF1cbwrf18CRiU8RtIf0lYld?=
 =?iso-8859-1?Q?nbAvqPoryZsy3tq4f9MANbaV3MaKg12GwFY21PzyZ9BOtQll3eML78dwdY?=
 =?iso-8859-1?Q?VtlHI2QaxyqDPj1c8aPWEFnIlaYAvClmWfbovzyR7+S1D+URfCi1GQmCJf?=
 =?iso-8859-1?Q?OXH023sD7tNMD9ECZ5U23B7Nld1e4l/lvYVwZ6U5VdZERhY+Wow7FJmcX/?=
 =?iso-8859-1?Q?8ua//ng7IqTg+S//v0Vn57ivpqUQoEGZ9d+C29oQ/QhIpefA3ixIQrE2jR?=
 =?iso-8859-1?Q?hqIlyX/9HainuknRYd6/96UavtsElZlrs8SVE7OilWZiIqlqChBLac+Fij?=
 =?iso-8859-1?Q?B7zLQ2R585/i+TLv2QWyFP6lC2vCbYnNokYgMNteD8tGPgYkLGqk4qzmd0?=
 =?iso-8859-1?Q?0J5Jr6rMsBcH1e3mpCQ42taYN4xGOGJ7/tISKJDW7Hb+kNV74jA6Jq13Wz?=
 =?iso-8859-1?Q?PxADC4/9GS80pwrDTAEbjfpjUon3+OuYlquBrY0LcPPDXrGD2TVQlGeqJs?=
 =?iso-8859-1?Q?7L2tHwm6BB58c7zYvJlBL53V8tiQHxYOQJ2ejVL7VUi8PhyZd+l8v4IUAM?=
 =?iso-8859-1?Q?lRl6RZT3WJn0KnVHqT3dc7nhUxLngzS19Ba1Dz/ueI+YKWOtlk87PDPp+d?=
 =?iso-8859-1?Q?II5Iwm60i5XsZYGhTQH47NmpKO37i7UPrbFv0xqTNZFulaD3F+zl/T7EJG?=
 =?iso-8859-1?Q?ec77j7iXRZQyNwQI06MEbafectctFssjkp+8jF6orOycjHa4eFfiAnIYCO?=
 =?iso-8859-1?Q?B/Qv4rKT7MObfPd8eTO3fp5hOgzjjAYFt/wjRCbXn0YqR0WJ2Fi+Y+/MDz?=
 =?iso-8859-1?Q?Aeek+8caXun+6l6IySNMjJhvx8m/yWbQfEfyl3/tKYWdv8ypD8EflgXl/Z?=
 =?iso-8859-1?Q?QslqWJOpAeLEHRTyS+Ld12+KjVupyfv6i6Io/n85SAhctUq08HMtQJEznq?=
 =?iso-8859-1?Q?CVU/pgorCrdi5UiaviC+S16xktsyyXGUo6auFvdRB+XDXM7bte6LCBmE5J?=
 =?iso-8859-1?Q?DRuuRtaDjQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X3LC75r4ZymVo5jAU7R79KEYHscH84ZjY7nLwOUQf5NyU0PP2NbBw1Rq23MNy5+suxnBO+Hj7n/ag1qacbBziYCdGDq9XacpKYlDFu/dHHwrFHG6/QC6Tw0Z4XViR94V3RrCLhCBLeZoCS9gBe9rXiA+Oja8GzpHpBIbFZHGmUpseNf7e3l+UIvdXC04TSQusCHDKG/9MloxqFlA+2F2wzZ7UwH6poY2yuqFfsHVYju/3Zer0y7uqepXeyDUbOLc3j0cfGMh88PyrIWrZrAwKEQsS8238wndM2lE9WX72+oC5VQi/HB9HrwQGLC0TsIyDDNnD1oNY4Ibw3pYfs2Hog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eae913b-10f4-4f6a-e364-08df2ac63a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 14:11:38.2636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0Y5YyijK/7UVhGmcNCzIAwPAxEkuP8VYXhCIPDqKUiIFkaz+IRYSBPOl+kLVjsvTTHCr20jsXREX6I4KtjgBGCmgzpckAXgoJTe2xO8pwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
X-OriginatorOrg: intel.com
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

Members Attending: 9/10
        - Aaron Conole
        - Bruce Richardson
        - Hemant Agrawal
        - Jerin Jacob
        - Kevin Traynor
        - Maxime Coquelin
        - Morten Br=F8rup
        - Stephen Hemminger
        - Thomas Monjalon

NOTE: The Technical Board meetings take place every second Wednesday at 3 p=
m UTC
on https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?passwo=
rd=3Dd808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes
The next meeting will happen on October 28 and will be chaired by Morten Br=
=F8rup.

1. Additions to Security Team
   - Kevin and Maxime volunteered to be part of the DPDK security team
   - Both were accepted onto the team after a quick vote

2. Release Update for 26.11
   - Progress ongoing for RC1 due this week.
   - Some trees still to be pulled and more patches under review
   - As flagged on the mailing list, concern was expressed about issues wit=
h
     IPSec multibuffer compatibility between platforms in crypto drivers
     - One commit had to be dropped when crypto tree was pulled because of
       build breaks
     - Thomas asks for the maintainers of the relevant packages from Intel/=
Arm
       to work to try and improve this
=20
3. Having a single Public Key for Security Disclosures
   - For reporting security vulnerabilities, best practice is to use encryp=
ted
     emails.
   - This is impractical for reporters where each member of security team h=
as
     a different key
   - Suggestion to have a single GPG/PGP key for the whole team, who each h=
ave
     a private key to read the messages
   - Can also be used to secure messages received from automatic security
     scanning (see below)
   - Stephen to follow up on creating that common key and ensuring secure
     distribution of private keys

4. New Security Scanner available for Open-Source Software (OSS)
   - Provided by Anthropic, projects can opt in to have their code scanned
   - Stephen is looking to register DPDK project, and board generally felt =
this
     was worth doing
   - As part of the registration, a threat model can be provided to help gu=
ide
     the analysis
   - Stephen to generate a short model draft and circulate it to the board =
for
     comments, before uploading to guide the security scan

5. UNH Lab Retrospective and Future Work Plans for 2027
   - The work is already underway to plan out the statement of work for the
     UNH Lab for DPDK in 2027
   - Tasks are being identified for this, for presentation to and budget
     approval by Governing Board in next few weeks.
   - Dillon Ladd from the lab presented to the techboard:
     - Draft presentation on the lab work done in 2026 including:
       - New testing and test cases added to the CI system
       - An overview of the ongoing CI lab maintenance undertaken by the la=
b
         staff
       - A proposed list of tasks under consideration for 2027 for Techboar=
d
         prioritization
       - Tooling enhancements to allow easier use of AI for DTS and test
         development
       - Proposals for new areas of focus for testing
       - Techboard members to review and grade on the spreadsheet over the =
next
         week.

