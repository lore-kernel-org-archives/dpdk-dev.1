Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114F6CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51B05402E7;
	Tue,  4 Nov 2025 05:28:05 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0A698402B1
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:28:02 +0100 (CET)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A40etmE007190;
 Mon, 3 Nov 2025 23:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=R
 cAu2VFR4H19Hi+l0cW9qMBVnSdR094qJEagV3qczNs=; b=BUq+DdQbMHIKKNP4o
 3BFofL+H7tvMedqAJQYnAeKa4kSJtqUM29/do/U3VbT4uUbsv2kr8jRXMC0J+X7a
 6MjaVhh7a7meRQD1/QF/zBoAGfhk0BGo7U/ZvH3UjJXIRQgxshji5roPnkdcNILB
 mzeT71DKOq490artr8YTbbhPUEfIaLxIo4zWNzGvmTU0mLTRG0Nr4HFHqaa4HBSk
 BX61mBSJz37sKfhxVo08HdqsXv1YjPaG08DrsERfGKUi3QVHuGHm2fuc1vCBK7XF
 0RBdHIAVggYneR03Yh5h3Hu+nmu83bgKZFuP7LKll86znfebmL3QUlZzPRgujfiN
 mj3Kw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4a5evn2s71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 23:28:01 -0500 (EST)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42pRmq034187;
 Mon, 3 Nov 2025 23:27:55 -0500
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4a78bks7nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 23:27:55 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhXXLlP52Wq0XY+awIqWTG13pWr01d8OQ0+e4ZpOM8X8UDZGuzSLHYtRlzPLA7x5kkPbD4nwjsjFgBurBMMdkxuCRgzh9GRa+5TqcWEbX+dL7h9E8T+JjLQRUnmek3Cd/0kIcy7AzbO1BZYLOBlt2mDdVif9C9NtnEH8F6NG23OqpZU5wq9YdbWATfLJ2MbdsiApaAa8o7LX/Lbl/52eV9dUbhO8A6eIZb/xufEa1PAxk4mbEtHU0iacfCFw8YFrYKjlJoG1+GtT1u7FIvFs7eca8nua89JsetGKCBfM1NN9QR9u6VTe4/UehbKRHY81eKvRArnA9ZDOCQ+NhHX1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcAu2VFR4H19Hi+l0cW9qMBVnSdR094qJEagV3qczNs=;
 b=cwgHC8V+Q3mxJoZz+x59OepHP7pH+cSd4ARXwY2G93nApXCqHZHpsYOyrNuQnAqmcekBZFLgZHSOYTeLW1nhWTn26r5jtPJlGc9hmq9QLuDpMxrd7KVeUupjrvrwtZpxeLdZhqzr63o2f6gvw1SvBEBTIOjrBS4fiS4Iz+EcDZbO6H6Z/mSY98eXuEQeDxQ0l9HpWZ+sm9FneWQgSc0WLCLjqb/1IevM4LbwrnKwFZGyhdky+hHqKMzJvADAWnxr/8otqN8dotZITo+g+F53aDFNHEsOMYdRCU2qclYM5odp6stiwfuB6WP9uSDS01JoaMfydOY1kQgbvhxWh8pPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by PH7PR19MB7607.namprd19.prod.outlook.com (2603:10b6:510:26b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:27:53 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:27:53 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v2 1/6] vhost: add define for configure mem slot
Thread-Topic: [PATCH v2 1/6] vhost: add define for configure mem slot
Thread-Index: AQHcODKsU0KRE+HiBk2AaX5s0arbJbTcZBsAgAWxxOA=
Date: Tue, 4 Nov 2025 04:27:53 +0000
Message-ID: <SJ0PR19MB4606EF6E2759DAD22DA0377AF5C4A@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251008090444.2689652-1-pravin.bathija@dell.com>
 <20251008090444.2689652-2-pravin.bathija@dell.com>
 <4112055.uBEoKPz9u1@thomas>
In-Reply-To: <4112055.uBEoKPz9u1@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-04T04:26:05.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|PH7PR19MB7607:EE_
x-ms-office365-filtering-correlation-id: 253b4240-b8cd-495a-bb4b-08de1b5a854f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-7?B?bURpTnA1Ky1mZ2xraE1uR0MrLVBhbFNNN1JvU1d6UC94RFRKdG1FSFJVLzZG?=
 =?utf-7?B?TnBCWG41YystRTFXVTRKcC9XZnNZckZxOW9KTWFjM3liZ3BNMHhQSlQvamxk?=
 =?utf-7?B?V1FIVFRTZnNhSUN0QVNzN3ZqUXFXaWFOR1ZnVXJBOUFHbDhqWGpLVWdiMmVM?=
 =?utf-7?B?aUloN2lYeExYZUc1SC9FVzArLWgyKy1SWGNKL0swYjlyV3ZLck83cHY2dXpS?=
 =?utf-7?B?V0hPS2JHMG1CV21rdVE3ZTUwaVdyWVkvYXM4VzdmSmNIQmhZRmtkdDVoYURD?=
 =?utf-7?B?dHdBTXZVVy8rLVdvQ3ZRd0Jvd2VTaDZtTHR6cFlYM2dJNmJtd0NzUk0zMist?=
 =?utf-7?B?dkYvTistSDEvMjZnWUpJZmVYTzFoZkQ0RVNCcnpvYnI3WVZZaXFqZFBrNFZ3?=
 =?utf-7?B?NWNid05RRlhOcmRJb1c5RlgvaWE0aGJzclFGdmJ0RC82SDZCcVJkKy1EcHNV?=
 =?utf-7?B?NG9TVGxESistbWh2RVV3Nmd6Mm54clRwZHByYXdSZVhoWE1kZmYyWVBYNnV1?=
 =?utf-7?B?bzdHb0FSWGk2eHFWVXFKQ0pjU0N6MWUrLSstYystTmdEaERJYVZMTHRGaG5h?=
 =?utf-7?B?eEllVWU1NzcwNWVkUVo0M1JzclhjaTc3YVFzNi83bystMEtCSHlHejczeURj?=
 =?utf-7?B?R1dmM1p6RjJGRzJNdXZuM2p2ZTVjUkpOR1JxOENUcHFDT0pDL1FwbDB4cmJQ?=
 =?utf-7?B?c0dEZDFyZkZ5NSstdHlpWTlWTlVxKy1PR1JMSWtTclpFdXhaVm5VTWsrLTcz?=
 =?utf-7?B?SXAxWUlPUXBzVmQzMHFNV2VkcElCb211RHQwT2hRVWRQbkFGVG90Q2NjVDNa?=
 =?utf-7?B?OSstaEs3V25hTFRKYkpDMjR5UUZ0UUFzeldldWlzd0FtVUthYUltcnZQckpL?=
 =?utf-7?B?YzJrKy10dWxnKy02dnV5anhXYi8rLVZtYloyZkJEZ0Z5L2ZyWHJZendwTWxh?=
 =?utf-7?B?QXZXODlJemFLaG94cVNuKy1QRjhFZEs4NHlQRkcwek1HWFFIN21GL3JnWVp0?=
 =?utf-7?B?TGdCTlBVb1RWRmQ0N0lFbnZacGpxS0dSZzY2S1NoTW02cWtqR3pPR3RGMzVa?=
 =?utf-7?B?STB6ZTF0WlVrVFhuQXVoL0xpa0VaY3RHNFVtWlNWMk0wVFhCRWRlMVQ3Q2ox?=
 =?utf-7?B?Ky1GREV5NGszWnZmNmd2L2VnLzlrN3Z0MHh0RTVjNWVkMUFZbUlCVistbjZs?=
 =?utf-7?B?UmJCdEw4VFBMQy9QKy0xRm85aTMvVXNkdnJpa3A3ZDF2Zm9idm05YXRocGgx?=
 =?utf-7?B?Rk44a3B2N1d2ZVVPNXdtWVY3SkNtcW45Z2Y3eGFOVjNrVWQwVUZnQXhEbWhx?=
 =?utf-7?B?WHN0T3J2ZTFwMUVHNmk5MTR6Y1NrR2Q2dG9ZUjZjUmZGYy9QemN0TnpzU3VC?=
 =?utf-7?B?MWtaeVdEZFUxRkxyWnVnNFcwYS9YYnZRZVM3cmxyRDFKeGsydExWYWRpbCst?=
 =?utf-7?B?d0FPZCstZExwMEFVZDc1Qm0yWWE0VGVRcGxNWjJHSUQ2encyOGZiQk5VNWdr?=
 =?utf-7?B?VUJ5emhsQ0pCQXB0N3FNVUlnTjNqYnlmUjhhNWpPNVUzT2ptT0svWkZiS2lT?=
 =?utf-7?B?NXk0bFkzbHowVElNTk5PMDdQaExIWHd3UUtpemc2a0xlMENJREhMUG16dWxo?=
 =?utf-7?B?em9jbFladnFhNmMwWlJBc0FIUWhpOFNkZGpoUHNPTG1pM01EcG0wZFRNVUFn?=
 =?utf-7?B?VWlBREpGMUhPcCstczlZb2xrMVRnL1A5NG92c0tkVTRSZ0RYR01VTmNQNEtM?=
 =?utf-7?B?aHlMTTVhZ3B5QnBaRUxxTzAxandCeWpoZzQ1QkVVKy1JaE5TVVNFOG03SXpX?=
 =?utf-7?B?V1R5SGdEU20xZ2FheExmOG1WWXNhMC9QRG9sVFNNeWorLUR2UVRPSC9ZUHFn?=
 =?utf-7?B?MDBlV0ZNREdkM0lFZXRTaDVjQUdVZER6MGcxb2xMWHoxMGRONHNsOXFUb1dn?=
 =?utf-7?B?OUUxRnRhMHE3VTJuNkZYcUdicWdvMW1KNUQyd1lvSGJIV2ZtWHJoVTViZ1pu?=
 =?utf-7?B?UWVyOVpHM1F3TER0d2FCOUFRYkhQN2ZLZXNxZXRzcmMyKy1FdGZrdFh4SUNT?=
 =?utf-7?B?SDNVc3dDckJWKy1aVGZvV25DcXl0Z3JuQnQyaEF5Y1FwdHBvU0M=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?aUlqSm9DL2tKdXBXZm5rcml6WnhMR25CdSstMDBDQlRyNTRNaUkxbTJNMXc0?=
 =?utf-7?B?R2g2WHZ1S25hL0JROGNJcjM3OTJLMFc2WlBOSHZRQ011Wkc0MTRwMTZNL3Jn?=
 =?utf-7?B?OW1aMlllbVpCN2hNam00NmRValRZNjZNZXVrZUcvQVFOTWJoMUZ5SVZhMEdE?=
 =?utf-7?B?cTZ6b2g4dlFHak8wcVN6S2I5dE8rLTNnVFlaczVGeUgxWW5jTjFQQUxRL2hV?=
 =?utf-7?B?UTlPKy0zSkkwbVhwQWVlYmh3ekhMSHRha3JDeXg4anhyYVVxYmJWclZjRzVW?=
 =?utf-7?B?b1k3em8rLVdOdkwwN1FzVXJZaWkwTVNJdzR2clZnZmQ1clM3L1VHU1VVa2cw?=
 =?utf-7?B?aUJYZ2FkR3NhM3VkdVFZRTdJOFBDQ3FTQUZMbXNTZmFHVEtqYVBvcVF0ZjNi?=
 =?utf-7?B?Nm91QlFkUlh4anJ1dlAxRWNJOTlabjhMY3l0V3FEeHJJR09YMno0SjRKTzRk?=
 =?utf-7?B?N1NHN0k0MnBZVUsrLUZBYzFIUHA0VXovaGZpNC9ob3BLUlVpN1FMTWxKODRP?=
 =?utf-7?B?cUNwZlovZEFKUjFybDM4eFZMNk1GdUlKOGJ4eXRCRTErLWZhZistenBkSlZW?=
 =?utf-7?B?UmpJa1NTQmpFL3QwUUZZcEF5bWE4cEM2cEtnS0wyOTR1OHpwTFl3c0lEVEtU?=
 =?utf-7?B?Vk9DT3RzNE5nc2R2d2NrOE8xVlZnSEVUalBaa1AxWU1wRUZYRlNYVEhHbVFP?=
 =?utf-7?B?MGVtOFlBSG82aFl2b1lnaEVQT3U2RlVGeWQrLU1zUmxka0xNZDE4REN4Tyst?=
 =?utf-7?B?dk51MDFIZXdoRXZzWENkRzRNUGNvS3NmTUxaU2xtYjllZGdZeXZPTEFBcXJQ?=
 =?utf-7?B?VGNPRHEwVDhmUXEyd1VCM1BVUVlNVHNXa2lBTGIxRGlROTNzam1lcGN0b3M=?=
 =?utf-7?B?Ky1vYXBla0NCKy1wL0txVHNiUS9WTGwrLXV2NmpaM1dPSzg1Tk1STnpRNDc4?=
 =?utf-7?B?QTBpSlhaS05EaDRZVDNLcno4S1RRWWxwMEFnc0p6R255akdkMmNvdWJZMU1U?=
 =?utf-7?B?WU84T1NmOWluVTIydURCZlNQQUlsbE81Nk02RFcvWnJrZ0tyRldzS0dXT1Fz?=
 =?utf-7?B?S0kvQndwVmhPM0hMV1hPTWMyRU8wS1k2SDBRWmNqb1FMbG1sY2M5RmJkSnYy?=
 =?utf-7?B?R3NWajhHL0tXdVRoL0hpRFBmNXlWT2FzWVF2Z2J3b1AzMUplRzFRU05aUUZ6?=
 =?utf-7?B?a01NQ21BWDJRREt2OW1iUENSNVJWMlo3eTQ4V0liQnZlWTMwSmZTck9vanhy?=
 =?utf-7?B?Q0VrTDRhTnBUa2pkY3hLQWl4bTVjNista1h5cWdabHhtbUJYYVdCS0E1Syst?=
 =?utf-7?B?MTk0ckFkWDF0bWlnU1JtV3k4MzFVN05Gbmx3T1FGcm9XNmw4eDhwTkNCKy1m?=
 =?utf-7?B?eXZQcllsdGs0dUtKblh3VFUyQ2FyaEdGWktNNHVWTmZrandWR1BtcHJBeUpK?=
 =?utf-7?B?OGlJUnFnOUR4VTdqaGtaL1Y5Z2VLcTJRdWE3ZXJ6R3hrKy1RNE1yYjJ1MzRU?=
 =?utf-7?B?NFpJbEJSdmhmeklBa0w1emZBTistU3E1VWQ5dWswVmRqS1dxbmg5d3hwNFpp?=
 =?utf-7?B?ajRZV1pNVTNhUDBmcW5rSlF3c1ZEUUtZZGRLNistVSstUzZ3eWFVOE5hREF5?=
 =?utf-7?B?QzRDYklxRnhIUmZPL3VjcnpTRnVVY3pFeHVtWGVGU1dHWkZmRUFlWEFLQUNU?=
 =?utf-7?B?T0M3cVZXQ1R3VzZCaW1XWEpycWZFN09tc041alVQeXRVUXFoekpUR1lrVkpr?=
 =?utf-7?B?R3BvNjJKMXZXbUtQOWM2SHRINzNYaVZ1SHVjWWxRWjN6MVBTa0xBZUNLcVE5?=
 =?utf-7?B?ZFJqbVNZTHRWRGlVczhJcFFpNlVSSkJzaEpkQzJ1bVQ1M3lEUG55eGpWR3dT?=
 =?utf-7?B?SUNXVmlFMndaRjZDKy1ueGx3OEhZdistVmNMQ0s0cDYxdjZlT1FJdU43UmJh?=
 =?utf-7?B?c0Zob1lXSlFlbUN2VWpGTm4yU0tDM1lsVkk4ekpGNmk5SUxkb3BSRG0zclVx?=
 =?utf-7?B?YzdqRXhuVkxMb1FaNUlxVUd2dEVDSnFEYUtSWHB6NWZaSSstb2I4ZzF2VER5?=
 =?utf-7?B?SC9YV3F4MW5LZm9raHVRYXZtZ2IzKy1KZjJIa0tzMGlGdk40cXJ0VTNZcDg=?=
 =?utf-7?B?Ky04akd3Q0FCSmZiQXg0SU1ESGpSM3lHbHRiL1M4VlluRzZtc296cCstekha?=
 =?utf-7?B?NEMrLTJPOUk=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253b4240-b8cd-495a-bb4b-08de1b5a854f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:27:53.0329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQ+SJa1SRI8Eq+bQIMszlJ20H1eGR+8YnPmlqpr+Y/fobhr26MTqmBPzZUFP+ZQ8KMRD3SD2XazpIvM2VX0Zxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511040015
X-Proofpoint-GUID: s_VUc94gwfrHERDscxL6aljhYyV-20il
X-Proofpoint-ORIG-GUID: s_VUc94gwfrHERDscxL6aljhYyV-20il
X-Authority-Analysis: v=2.4 cv=Z5zh3XRA c=1 sm=1 tr=0 ts=690980d2 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bt5KbKNvAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=6-dRa9qSAAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=yK0Rz-qNUZeL3ic-FDUA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22 a=NZk92sZ4hQKp_Sw8PGvT:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA3MiBTYWx0ZWRfXxjWHvKwzyUa1
 n4QqQwK+xP7j9kHLYyBWT1n9xmbxJJN9bDjpCA661BxJhH/o6Q7Ev/qhlfTgFee42kayLUscBj5
 +jzo/odVKlkzfU8RjePaXWpJ3rQPo123jvXJDCaSku9Bffr3MVRiD7UpTZ2Ed8bO617LycibZaq
 F5eaECWGhJLU/M5YJyiayMKxjdpW3ljA6Qz71FWSsZQpXYpL6pKQ0OzwR8mb6mjzM2oSV1TwPss
 SW66nVbOYpuQY04v0CPhg7lSccHqS1rAQv91iX5inIMtnF9asIAMlKWdMlUTaJeGXaKxP3i23om
 zneXHMWPd6C3hXH2IZNSv7tm0ykoPqVjKP0U4CzdPvN8l8vyrlnyBanoXtHrZJnEXnDnwvYDmxN
 yyeT11HQ3AxIBfQ9hHalZasR3DZ8aw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010072
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

Dear Thomas, Answers inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
+AD4- Sent: Friday, October 31, 2025 6:29 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v2 1/6+AF0- vhost: add define for configure m=
em slot
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- 08/10/2025 11:04, Pravin M Bathija:
+AD4- +AD4- +ACo- add user to mailmap file
+AD4- +AD4- +ACo- add define for configure memory slots
+AD4- +AD4-
+AD4- +AD4- Signed-off-By: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4- +-Pravin M Bathija +ADw-pravin.bathija+AEA-dell.com+AD4- +ADw-p=
ravin.m.bathija+AEA-gmail.com+AD4-
+AD4-
+AD4- The mailmap file is for tracking adresses of the patch authors.
+AD4- Why adding your gmail address here if you don't use it for DPDK dev?
+AD4-
Suggestion taken. I submitted an updated patch-set v3 where I'm only includ=
ing my dell corporate e-mail address and not the gmail address.

