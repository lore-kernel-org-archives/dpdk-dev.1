Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97103C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 07:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7305A4026C;
	Fri,  9 May 2025 09:17:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE6E4026B
 for <dev@dpdk.org>; Fri,  9 May 2025 09:17:05 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5496XpYo031222;
 Fri, 9 May 2025 00:17:04 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46hcg082jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 00:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlXo9eAMFtqraeLt6j6lTmTm1RqWrztlAXKKuNlGwZvu6zRuVS2AMM/WLHTGhHPHO0sqWOacb0mEDPoupDTvJZ8Jx5msbao04MoqnnkY+2uuzZ/DjPIQ3CSL1ezVnKsOjSDZ/IDCIHsI5Jj2LPHQH+9zyrPCvvqihob4kcx3KFPyzv7u/5UXjscW2+9QIEv9jKo7mUQDwzIZcHuvSXVfI+VZTd0C7TIlFNjwsAdPr8gUeF06iFAoNeGCym5IIriL+EZNqLnrplWBxTf1fnNgvqOfLPugV0XGC4p+3uVSx7xPKkDj5ugjVVS2CJ+EY44pAP8SLgbhFWKcZHq/ycI/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW53xJRrLbOzWkHCY98dUnZiqTLUKgdXGxKLqzfMFX0=;
 b=xs8aWqKm2aomUDUGhXYAfC0B9vJCK6RrGAaqu65HqkpxnZl/5s4itC4LS0vbUrHWPuWONogmvsQVbsxCUrTGDAdULbktjXTmVR3DsAEzEfPBCYTd6Jo+QaGruJIdkPM6kbbj729AMPtxDtBqpi542hLgIKyCVFUWrue6uMaWN80QcaNcbeYGCum8yG/IauV/kmE/jO34JJegEqIhV4+Z4SYeE5YonWaZFLnUwQditzi/SMhGdlVOvWGObZeCl3lo+Iy234rN8xVnbVuhDv0q/9iXzGcDyCTFXx1rgXXaX3YxEHTYTe7QP30LbIVyEOXtGTWd7UOAp2mwhMZvaYcMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW53xJRrLbOzWkHCY98dUnZiqTLUKgdXGxKLqzfMFX0=;
 b=FC7xZ1QjqCgmWOjfgi/8uJ0Kt+tyGZTpLJcArFC3ha86Tw8Pv/pqeu1EY9o5TfkluhobS/Tf4Tzm5A4iaX1eBKdxMhlvTDu94d13QOOQyELXjqQoWanq0S0YXOs2FvuFpmQDZG+/dY0bUL9wijJxVSc0Ty1YCDB/Fyw+AFDdbsQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 DM4PR18MB4365.namprd18.prod.outlook.com (2603:10b6:5:39a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Fri, 9 May 2025 07:17:01 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 07:17:00 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Robin Jarry <rjarry@redhat.com>, Christophe
 Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin
 Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v6 1/2] node: add global node mbuf dynfield
Thread-Topic: [PATCH v6 1/2] node: add global node mbuf dynfield
Thread-Index: AQHbuCmH4uj6c4GiMEWJuRL/WWdkhLPJ9DwA
Date: Fri, 9 May 2025 07:16:59 +0000
Message-ID: <PH0PR18MB40864E708C8B39916AC30E65DE8AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250428103711.3317231-1-nsaxena@marvell.com>
 <20250428103711.3317231-2-nsaxena@marvell.com>
In-Reply-To: <20250428103711.3317231-2-nsaxena@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|DM4PR18MB4365:EE_
x-ms-office365-filtering-correlation-id: 0bd49631-1361-4a2c-879b-08dd8ec97d73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xA4T0Nnp4nPfbBas+ahFF77a4J+CTD6rXS+mjRGYt0gCNSmhyCEn8elCc5SD?=
 =?us-ascii?Q?NqS3wy2txKTPRSZtYyJWi9GgjYTwy2psOOYcgQm7CPI5w1uenMYjqY5oZ8+H?=
 =?us-ascii?Q?GLZ311zv8SrbxONP/msQtirb9cVI0BgwpBSs1ZPdN9LgNFk9iUuY21OkGyfs?=
 =?us-ascii?Q?RQ4Yx1bBM8YpoFZDqfAI/YCnuMIzQ7NOYiOFYtq8fKXgza+FJexMBV86ltBg?=
 =?us-ascii?Q?NmIGkKl4wS2/NJDXA6j+fBAqI1dxlnCL8GQ6E2ZmOpPV+uuhrXkLR6LJd2hh?=
 =?us-ascii?Q?b9V5knL+90g6AY4+l98U8JznN+36SNUTlMo53usLc2VOg89UUnp3/oJvEq6D?=
 =?us-ascii?Q?/Ow32msAri3318dRo3e3Oe0yPeSQ4fbbfNoYsT8GVaACLDb5Qhw3eZMSsFbA?=
 =?us-ascii?Q?wkKCK+yAyFDqaSsTkvFxyQRB1OUWUQLoh/umq/Hj8R/oDWGq74MoNdFQL7pU?=
 =?us-ascii?Q?xe9FFzqN/M2XdHDacOG0o0Z42R/ZDtcxXO3IT/QNy2s4/M/ymnM4pJRRko4a?=
 =?us-ascii?Q?8O7ZqDQ5bPz5EW1MyzEl+E9C92pqphRsjC/L5qRfyoRmMbVmtwvML/DCmXzc?=
 =?us-ascii?Q?MwMT0T1Jgsmheaz19MWXWmbPOMiQwq8a20C/v9dnRpCxqDaTSmZxHMLKel8C?=
 =?us-ascii?Q?fcSOpKkk0stf672xIifaaI00hAzFar2Cpr38NovEEi901GvR79+uEPdHTjm1?=
 =?us-ascii?Q?IAQSMZtIRFyAOmXGCWAmv9xHNEd0N+HMIOBS0kiDLVH37qcdRyogzkVGd9r2?=
 =?us-ascii?Q?7f6KDAHBck0mnUMXSZbznjtTKWwHJQ5hssAkqofzi1BbL3xvR27JTavQDefw?=
 =?us-ascii?Q?hrMB6hg+iW3gUfqPKevEAc4BatWy07FRO9T+A0fMZDegAUsL9x5/fx9vF09r?=
 =?us-ascii?Q?okCHNO+7FK8G5rcY1vle5lgCCCwuIFfdJkLtVFxx8tdF581bykohbYjprJfG?=
 =?us-ascii?Q?4aga+Rhyny0qLbLjmC22hAPrLb32jemLoJWWjPLx8kBcPgi8iSVTfxOG9wC4?=
 =?us-ascii?Q?RgZrgNcRpdjCEry/WsZYNZurxsMkxS69P36MlIkxa36qcJuq6jtJL8PNgINK?=
 =?us-ascii?Q?OTlD73WAyE43QqCRkMuEvpDxxcgJ/+EoJ9Vu9IdOz8TcM/zKPAUiZ22LFo28?=
 =?us-ascii?Q?Yxjq1QbvL4AJ1WPlkR3YQJazfly/s0QjoYMEKBztkY76aD74Fb5zs8uPpq+7?=
 =?us-ascii?Q?Cmc3e3eQpzs+dar7nur+eSQe4AT93vSjB7YuLPk5M5HV0d/K8oau/g3ehBaH?=
 =?us-ascii?Q?QZheNbj4n71jLiC4kvft4UT17xcgt++55X3Whs1o2nro1Fg1Jz9JHs9V2POc?=
 =?us-ascii?Q?auXsSUfPqauEYX6fs0K0v1MyLVt0ZGxbF0ZPV+vNGobhB1hUxvwI4D0AiaHw?=
 =?us-ascii?Q?3nr7WeCq1ZlvqKK62+HabON1DcTAYO4abdGMvqTfHRAEomTHKNs5NSESxRaf?=
 =?us-ascii?Q?bNp4rhODDs5W2eBkvGldWQSeiZCNjjSHteo7wovOOEsk8C1kvDT6awGGGfNZ?=
 =?us-ascii?Q?k1e4likCI9wsc6M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wx3PcAR8ItsQQ5dYvQrO0IWTC5NL4c0jz0Bg8CfesZY08hrxFgSHVREzcdTt?=
 =?us-ascii?Q?2UHR/rpfrpXHO2Nfe9wvMuUDNcdiodpyKZ0lawGiJqwIdjRPX2fCiwfdsJYS?=
 =?us-ascii?Q?+TBvyhP4Lqe7+FTlhA3urcOaTgSl4QxR4W2y9wf0egx9mXVI5RoKSy3TM2OD?=
 =?us-ascii?Q?NpEre6y7CfuLZwmAUNE7Zu0rh2QaHSZLcq2yn97fNDEubKCxZlJUSDPl6Pwc?=
 =?us-ascii?Q?9r7JQVPJn5+JPbn3x1xUdp5iW5LSs1HzuP+Kx9Eo/hf4lhFLy8f+yy20ZCcd?=
 =?us-ascii?Q?6Dt46/RjUfm8zuT2br7Ezpv6lqLz2ayXWKG0rvp50kTZyzZodSbGNldbuju1?=
 =?us-ascii?Q?11L3jv3vFC3jP2hnTW8TcBmCKMfachrc1p9LElKaatXkbU1ugfCKhUD1ecl4?=
 =?us-ascii?Q?y1oelWKXQKSKN+3c5f4q+lNmAeJUwGhdydrE17usMofs+m4XppCQ26He1Dj0?=
 =?us-ascii?Q?SvauEqPYWkYvua+g9o1k7p8I0XNcI5si/wWcQehc5Dwk3FsinSAJfgaLAlov?=
 =?us-ascii?Q?hC6UdlFjbA4DPio0p4WOu/q9TZiqiPDQEjXuZAy9dBYaj+30lsISu6lCMwrs?=
 =?us-ascii?Q?8vp4JGNcnitBx+ka/eqS1Nhoru6/NwIsnBpZDIonFiZ9TJJlV5WRg7RvBYBC?=
 =?us-ascii?Q?Mz2pEpqTScTttAxZQZ78C9a+sFYcHIuiktR0sjjjuVJg/3XCeBULSWG/NMSG?=
 =?us-ascii?Q?u9j1fcBSrVa3AyYjRQS57hI4eixV8kQkWgPW+ovCBXycbs6AG23yz6Sa74uA?=
 =?us-ascii?Q?8Ncl1M7ImlT+R6fw1TE0SRNq12pHkuGiGlWDRjLPhQGcPBq1nlyrsw5bKUtF?=
 =?us-ascii?Q?VzJX6OWbk14HUR4l7HPUQxB3zkdHXK2s8YNYMChDHqSp1aGJ4axpFtlWa5vO?=
 =?us-ascii?Q?LPTFHbjyfTjKhYd7KWUNp4s9Hdy+f1gL1rHie3j+LN4JpHWAeLmRE2YcFgFG?=
 =?us-ascii?Q?flD6LPBQuqk+/8qk1azV1Vva9ZMCsPwsE5N+RcXc8LhiX/hLJh3oKCOAw+O1?=
 =?us-ascii?Q?5nowo+1MUh8rrk/bREQwDRFBgeIMxAyOfgRBzJPCele0L+CFQ2lzDPx94+VQ?=
 =?us-ascii?Q?dyrj9u4m4/26mOwlaGgzCUsIDvQJKEAncBKtYlK9fjT/mIo4JE0Ct+4riYBd?=
 =?us-ascii?Q?L1xDRITHFTCY6RVXEW/BLIuzTFuO++5uySyrlJ+dQwEQaFo859ULq34sPr1f?=
 =?us-ascii?Q?zYCzopkYF3VYPH/FCGur5tV5n9GkGQfAluFtz3ExXKGkmRNeTcQhUgyHA7wq?=
 =?us-ascii?Q?O7da27bQaJCRKtWAQBNtt005k65XtqDoh8m9tle0kc2g9wwryPEKU2/T5tK5?=
 =?us-ascii?Q?UhrPMSALemseDl/GEjFqQSq2REkeSkLzrUVDsq8itZz+TNDT5EuAt3+vlK6J?=
 =?us-ascii?Q?kJ9PuoDMSgacbjyKVSUCaTVadjX7pK7XG08ruKacm8aKbDYPy0YtwWyS81U2?=
 =?us-ascii?Q?RkP16d/xp1GuIkhapjrjCVu2KnZJHWuLkGjtysZYni4/XPRHvGjhqwScQ0SC?=
 =?us-ascii?Q?WHb69BCt93xiXVTLPZJnswCDRAadfhF2mw6SuN3k/MKH8p+Zf5xoYaacBmxk?=
 =?us-ascii?Q?VhwAIR+uc/69wcWRYf/HMGYn5mTMNFy0v89jXw9k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd49631-1361-4a2c-879b-08dd8ec97d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 07:17:00.0269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gy81XWC/Sx/T8zcK7IaZeW/OHfjUomcNrGiDPNnvP53gi0qizFMcEak8kQSkPEi1CrerAeBPlWa6TYtaokC1OYp4hsR91Bl4NjLFC3V1lVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4365
X-Proofpoint-GUID: 1ZYztSRLFEK4nJkusZyufjN1qJOAUOQu
X-Proofpoint-ORIG-GUID: 1ZYztSRLFEK4nJkusZyufjN1qJOAUOQu
X-Authority-Analysis: v=2.4 cv=BaPY0qt2 c=1 sm=1 tr=0 ts=681dabf0 cx=c_pps
 a=tyvwN2z/Y66O58r8mq/nTQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=UxMM5sU4P2_Nscn_De8A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2OSBTYWx0ZWRfX74hRHuHTIgNn
 v5fzEVQkFNzsOhKOid0PZHTd1UdBZSuDjZlLBW5LiRUBBtp29q2uhQ8iwcqpkrVYw35N1edVunv
 V577qL+XcT0YtNA+FdiZlu8CcFfd5HIV2Haif93lSgDmaKWAokBXf2HPCH6CvxyQ/ZWo3kdo1iK
 PMM5s5YghdqOiQPFOwV0HcLRFmmBG7ldP0+mFSXY68x6cR0eQM+8zEfz7lh8ax9yA4lbV1xcgWr
 hSxvPJKLOAhyUtzhNvIuctWZscF4OgUKM78UB+k/alcp9n520raHEpla+OYc6MR3/Wx6K51cw27
 JOzfvoZqT6F2HCydYByrtnuoWiHcvRwor5WDU1Ajv1/8ncpSsFqfpolrZUrmePcfhEQYlvcOCr/
 JyOw2NncXhLxeeZZX5kEyny4StLlgaIRoDxAG/BdSF0QW7Z7TzZJcfpTsBQcfl1qERx+Mgf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
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



> -----Original Message-----
> From: Nitin Saxena <nsaxena@marvell.com>
> Sent: Monday, April 28, 2025 4:07 PM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Pavan Nikhilesh
> Bhagavatula <pbhagavatula@marvell.com>; Robin Jarry
> <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>; Nitin Saxena
> <nsaxena16@gmail.com>
> Subject: [PATCH v6 1/2] node: add global node mbuf dynfield
>=20
> This patch defines rte_node specific dynamic field structure
> (rte_node_mbuf_dynfield_t)
>=20
> rte_node_mbuf_dynfield_t structure holds two types of fields
> - Persistent data fields which are preserved across graph walk.
>   Currently size of persistent data fields is zero.
> - Overloadable data fields which are used by any two adjacent nodes.
>   Same fields can be repurposed by any other adjacent nodes
>=20
> This dynfield can be also be used by out-of-tree nodes.
>=20
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>

Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

> ---
>  doc/api/doxy-api-index.md              |   2 +
>  doc/guides/rel_notes/release_25_07.rst |   6 ++
>  lib/node/meson.build                   |   2 +
>  lib/node/node_mbuf_dynfield.c          |  59 +++++++++++
>  lib/node/rte_node_mbuf_dynfield.h      | 140
> +++++++++++++++++++++++++
>  5 files changed, 209 insertions(+)
>  create mode 100644 lib/node/node_mbuf_dynfield.c
>  create mode 100644 lib/node/rte_node_mbuf_dynfield.h
>=20
> diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
> index 5c425a2cb9..e1c85bcfbd 100644
> --- a/doc/api/doxy-api-index.md
> +++ b/doc/api/doxy-api-index.md
> @@ -219,6 +219,8 @@ The public API headers are grouped by topics:
>      [ip4_node](@ref rte_node_ip4_api.h),
>      [ip6_node](@ref rte_node_ip6_api.h),
>      [udp4_input_node](@ref rte_node_udp4_input_api.h)
> +  * graph_nodes_mbuf:
> +    [node_mbuf_dynfield](@ref rte_node_mbuf_dynfield.h)
>=20
>  - **basic**:
>    [bitops](@ref rte_bitops.h),
> diff --git a/doc/guides/rel_notes/release_25_07.rst
> b/doc/guides/rel_notes/release_25_07.rst
> index 093b85d206..2dc888e65d 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -55,6 +55,12 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> +* **Added rte_node specific global mbuf dynamic field.**
> +
> +  Instead each node registering mbuf dynamic field for its own purpose, =
a
> +  global structure is added which can be used/overloaded by all nodes
> +  (including out-of-tree nodes). This minimizes footprint of node specif=
ic
> mbuf
> +  dynamic field.
>=20
>  Removed Items
>  -------------
> diff --git a/lib/node/meson.build b/lib/node/meson.build
> index 0bed97a96c..152fe41129 100644
> --- a/lib/node/meson.build
> +++ b/lib/node/meson.build
> @@ -8,6 +8,7 @@ if is_windows
>  endif
>=20
>  sources =3D files(
> +        'node_mbuf_dynfield.c',
>          'ethdev_ctrl.c',
>          'ethdev_rx.c',
>          'ethdev_tx.c',
> @@ -30,6 +31,7 @@ headers =3D files(
>          'rte_node_ip4_api.h',
>          'rte_node_ip6_api.h',
>          'rte_node_udp4_input_api.h',
> +        'rte_node_mbuf_dynfield.h',
>  )
>=20
>  # Strict-aliasing rules are violated by uint8_t[] to context size casts.
> diff --git a/lib/node/node_mbuf_dynfield.c b/lib/node/node_mbuf_dynfield.=
c
> new file mode 100644
> index 0000000000..6fbbf9604c
> --- /dev/null
> +++ b/lib/node/node_mbuf_dynfield.c
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +#include <rte_memzone.h>
> +#include <rte_node_mbuf_dynfield.h>
> +#include <node_private.h>
> +#include <eal_export.h>
> +#include <rte_errno.h>
> +
> +#define NODE_MBUF_DYNFIELD_MEMZONE_NAME
> "__rte_node_mbuf_dynfield"
> +
> +struct node_mbuf_dynfield_mz {
> +	int dynfield_offset;
> +};
> +
> +static const struct rte_mbuf_dynfield node_mbuf_dynfield_desc =3D {
> +	.name =3D "rte_node_mbuf_dynfield",
> +	.size =3D sizeof(rte_node_mbuf_dynfield_t),
> +	.align =3D alignof(rte_node_mbuf_dynfield_t),
> +};
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_mbuf_dynfield_register,
> 25.07);
> +int rte_node_mbuf_dynfield_register(void)
> +{
> +	struct node_mbuf_dynfield_mz *f =3D NULL;
> +	const struct rte_memzone *mz =3D NULL;
> +	int dyn_offset;
> +
> +	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) <
> RTE_NODE_MBUF_DYNFIELD_SIZE);
> +	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
> +			 RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
> +
> +	mz =3D
> rte_memzone_lookup(NODE_MBUF_DYNFIELD_MEMZONE_NAME);
> +
> +	if (!mz) {
> +		mz =3D
> rte_memzone_reserve_aligned(NODE_MBUF_DYNFIELD_MEMZONE_NAME,
> +						 sizeof(struct
> node_mbuf_dynfield_mz),
> +						 SOCKET_ID_ANY, 0,
> +						 RTE_CACHE_LINE_SIZE);
> +		if (!mz) {
> +			node_err("node_mbuf_dyn",
> "rte_memzone_reserve_aligned failed");
> +			rte_errno =3D ENOMEM;
> +			return -1;
> +		}
> +		dyn_offset =3D
> rte_mbuf_dynfield_register(&node_mbuf_dynfield_desc);
> +		if (dyn_offset < 0) {
> +			node_err("node_mbuf_dyn",
> "rte_mbuf_dynfield_register failed");
> +			return dyn_offset;
> +		}
> +		f =3D (struct node_mbuf_dynfield_mz *)mz->addr;
> +		f->dynfield_offset =3D dyn_offset;
> +
> +		node_dbg("node_mbuf_dyn", "memzone: %s of size: %zu at
> offset : %d",
> +			 mz->name, mz->len, f->dynfield_offset);
> +	} else {
> +		f =3D (struct node_mbuf_dynfield_mz *)mz->addr;
> +	}
> +	return f->dynfield_offset;
> +}
> diff --git a/lib/node/rte_node_mbuf_dynfield.h
> b/lib/node/rte_node_mbuf_dynfield.h
> new file mode 100644
> index 0000000000..4db5382f91
> --- /dev/null
> +++ b/lib/node/rte_node_mbuf_dynfield.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#ifndef _RTE_GRAPH_MBUF_DYNFIELD_H_
> +#define _RTE_GRAPH_MBUF_DYNFIELD_H_
> +
> +#include <rte_common.h>
> +#include <rte_mbuf.h>
> +#include <rte_mbuf_dyn.h>
> +
> +/**
> + * @file: rte_node_mbuf_dynfield.h
> + *
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Defines rte_node specific mbuf dynamic field region
> [rte_node_mbuf_dynfield_t] which
> + * can used by both DPDK in-built and out-of-tree nodes for storing per-=
mbuf
> + * fields for graph walk
> + */
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/** Size of persistent mbuf fields */
> +#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE          (0)
> +/** Size of overloadable mbuf fields */
> +#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE        (8)
> +/** Size of node mbuf dynamic field */
> +#define RTE_NODE_MBUF_DYNFIELD_SIZE     \
> +	(RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE +
> RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE)
> +
> +/**
> + * Node mbuf overloadable data.
> + *
> + * Out-of-tree nodes can repurpose overloadable fields via
> + * rte_node_mbuf_overload_fields_get(mbuf). Overloadable fields are not
> + * preserved and typically can be used with-in two adjacent nodes in the
> graph.
> + */
> +typedef struct rte_node_mbuf_overload_fields {
> +	union {
> +		uint8_t
> data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
> +	};
> +} rte_node_mbuf_overload_fields_t;
> +
> +/**
> + * rte_node specific mbuf dynamic field structure
> [rte_node_mbuf_dynfield_t]
> + *
> + * It holds two types of fields:
> + * 1. Persistent fields: Fields which are preserved across nodes during =
graph
> walk.
> + *    - Eg: rx/tx interface etc
> + * 2. Overloadable fields: Fields which can be repurposed by two adjacen=
t
> nodes.
> + */
> +typedef struct rte_node_mbuf_dynfield {
> +	/**
> +	 * Persistent mbuf region across nodes in graph walk
> +	 *
> +	 * These fields are preserved across graph walk and can be accessed by
> +	 * rte_node_mbuf_dynfield_get() in fast path.
> +	 */
> +	union {
> +		uint8_t
> persistent_data[RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE];
> +	};
> +	/**
> +	 * Overloadable mbuf fields across graph walk. Fields which can
> change
> +	 *
> +	 * Two adjacent nodes (producer, consumer) can use this memory
> region for
> +	 * sharing per-mbuf specific information. Once mbuf leaves a
> consumer node,
> +	 * this region can be repurposed by another sets of [producer,
> consumer] node.
> +	 *
> +	 * In fast path, this region can be accessed by
> rte_node_mbuf_overload_fields_get()
> +	 */
> +	rte_node_mbuf_overload_fields_t overloadable_data;
> +} rte_node_mbuf_dynfield_t;
> +
> +/**
> + * For a given mbuf and dynamic offset, return pointer to
> rte_node_mbuf_dynfield_t *
> + *
> + * @param m
> + *   Mbuf
> + * @param offset
> + *   Dynamic offset returned by @ref rte_node_mbuf_dynfield_register()
> + * @return
> + *  Pointer to node specific mbuf dynamic field structure
> + */
> +__rte_experimental
> +static __rte_always_inline rte_node_mbuf_dynfield_t *
> +rte_node_mbuf_dynfield_get(struct rte_mbuf *m, const int offset)
> +{
> +	return RTE_MBUF_DYNFIELD(m, offset, struct
> rte_node_mbuf_dynfield *);
> +}
> +
> +/**
> + * For a given mbuf and dynamic offset, return pointer to overloadable f=
ields
> + * Nodes can typecast returned pointer to reuse for their own purpose
> + *
> + * @param m
> + *   Mbuf
> + * @param offset
> + *   Dynamic offset returned by @ref rte_node_mbuf_dynfield_register()
> + * @return
> + * Pointer to node mbuf overloadable fields
> + */
> +__rte_experimental
> +static __rte_always_inline rte_node_mbuf_overload_fields_t *
> +rte_node_mbuf_overload_fields_get(struct rte_mbuf *m, const int offset)
> +{
> +	rte_node_mbuf_dynfield_t *f =3D NULL;
> +
> +	f =3D RTE_MBUF_DYNFIELD(m, offset, rte_node_mbuf_dynfield_t *);
> +
> +	return &(f->overloadable_data);
> +}
> +
> +/**
> + *  Register rte_node specific common mbuf dynamic field region. Can be
> called
> + *  in rte_node_register()->init() function to save offset in node->ctx
> + *
> + *  In process() function, node->ctx can be passed to
> + *  - rte_node_mbuf_dynfield_get(mbuf, offset)
> + *  - rte_node_mbuf_overload_fields_get(mbuf, offset)
> + *
> + *  Can be called multiple times by any number of nodes in init() functi=
on.
> + *  - Very first call registers dynamic field and returns offset
> + *  - Subsequent calls return same offset
> + *
> + *  @return
> + *   <0 on error: rte_errno set to one of:
> + *    - ENOMEM - no memory
> + *   >=3D0 on success: dynamic field offset
> + */
> +__rte_experimental
> +int rte_node_mbuf_dynfield_register(void);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> --
> 2.43.0

