Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF39CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A538E4026A;
	Tue, 11 Nov 2025 12:31:31 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4EA1340144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:31:30 +0100 (CET)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB73fAh024105;
 Tue, 11 Nov 2025 06:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 xwINRhOiKSFtFEXUH6WYR5VE7r37E7s3200nzwGVM4=; b=i3OfyNXH8/8gLrQEg
 88yCW5iJX+7vJ4lF2Z0t2d7tbWtmRI91vqKCpY7Jawzr+TE0G/ficICvamgwEUvk
 9kjvJ9owVDbn4UUXODjW7aLjstr5jpMCaTGBG1XtMJXvy/RMwya+BvgH01gIaWWE
 xdaSAmGUl5m2v3SA//MDU2cj4UsJLTOm9JkrfU2ui9ks+WYb+zmC7AljmP35wAEN
 fm7JbZsHMh2yKpcnlfhp16ojPsQILX5se4JeXjEzjUk8GM8dtqK1ya23C/b3eUIE
 Rptze2IkBg86FNJvU0FTu6jsn1+WR3xy3YHXr7XLLIwmoFJJSuZhstPqhjhKp61v
 ehVdw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa22qc2mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 06:31:29 -0500 (EST)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABBK0tL001918;
 Tue, 11 Nov 2025 06:31:28 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4ac46583ws-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 06:31:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRAl+90AuJKabLIBiRbMuOF74ISMovjVvcMQeq/FsS7Oqkjr2HtabqqkBgEO/fZyN6k3dDEGCVYBogTOCw25960plfVRpYE1YTG64Rb48ZANGPCbVE+BjMxVowTGWR1RnOCqKZeFPUtKwD5cPFRaKu885sVNxKVHSHiP7e/6eWG+wJLSnNv4/16rYeJk4ejLmyAEW3EZOP8FE9n+r+RyCNfrFd6nzE0TCIYSOmmE6h+zMAqCHQKe4YVzwqSOfemcqKPO/pi8PO7iW5PWsDO2Rs67tkeEqNmWXOBITrm5w2T1rZGvm0YPWFJhixl69aXyyLhSu1902hIFihvtPkmuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxwINRhOiKSFtFEXUH6WYR5VE7r37E7s3200nzwGVM4=;
 b=WbcNsnWL5X57lvpkwlzuK0FVfSKkhh2xtUAUg1/sCF+zc9fAWNLhx3C6ULWMq3qA08sghFeCU1KcRkRyQaBhka4QtUv6cP4q/CEfeAeDqe9hK5TlqMQvpft1aAxLaPYnuJYtUP7nyrN1TCSNtEuDo+30hybrOpI3rAYxJ39ng+8CZ4hQXzC4TQU6DqbgsRUKb0Vbd4ZHquP8oEGqeHy/z6WaLgyhfET1jYiCpOITyls1j2gWgTvaG6x7M/qgTMb7TGRYfN1unMRUNPc650uISuJs0I7LF1Dx0PU0djZnkXUfIGhdLZ5d7lUYjLyNRJH1dQZ7cb3Cv72b0/Ub85zgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by BLAPR19MB4308.namprd19.prod.outlook.com (2603:10b6:208:27f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:31:24 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 11:31:23 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v3 4/5] vhost_user: support function defines for back-end
Thread-Topic: [PATCH v3 4/5] vhost_user: support function defines for back-end
Thread-Index: AQHcTUK1uWn6VStxUE2UwNqpzuYUW7TiKRWAgAs49gA=
Date: Tue, 11 Nov 2025 11:31:23 +0000
Message-ID: <SJ0PR19MB4606743990AD1AFE8EC06217F5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-5-pravin.bathija@dell.com>
 <051163f2-7b6e-49db-83cf-7f6f366c448a@huawei.com>
In-Reply-To: <051163f2-7b6e-49db-83cf-7f6f366c448a@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-11T11:28:20.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|BLAPR19MB4308:EE_
x-ms-office365-filtering-correlation-id: 9865266a-fd1f-40e4-122d-08de2115d802
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-7?B?TEE0aHQ4MFFvcENSeDZxRDBvcGV2d0YySTYxWUIycUNoSzNjelc5L2VEcWtn?=
 =?utf-7?B?MWxCaTRleGIxT1IybVBWV2pSak5jSU5VcFhjVzhFbGUrLWFOdTF5TzZ1VklG?=
 =?utf-7?B?OFZVTzhFYnVTdm0vajlGdER4Ky15WkFPNjF6TGJVTDBvUndOcFdsVU5uWVc5?=
 =?utf-7?B?d05qL3ZRQXJ1MmFFWWxWWXpmeWg3M0k0bWZEUWJFc1ZHbFVvdjNVdTUwckFR?=
 =?utf-7?B?d21La2JOaVBDTUhFN2p5UkwrLVJ2SzB6V045bWsrLUxUcXNaMDRTZnFiMnY=?=
 =?utf-7?B?Ky1iR01xLzhpcUE0V3VXOGRQTGFQeFlqajhkZGYycWx6TDFmenRlRjNMa29E?=
 =?utf-7?B?N0EzRE96RXNqMGdoQnNGckRYREVlNjRrVnZwTURhQW93SUVVakhKZGNuSnBX?=
 =?utf-7?B?MXFSRXNiQmVxbystKy04QWJFcHJRYVNmYUl5Vkd6bHlxSDBORmtiKy0yWDhz?=
 =?utf-7?B?UGxtUlVvcWVmN0MvUkptV2tEaENnVGZEeGQwUGRaazZGV1dRRVUwNkg1dTNR?=
 =?utf-7?B?NXBkY1V0aGliKy1hUFd0OEQvYmVCYjRhdDlWNCstaTFxMmtCdGdxSVBlaDN6?=
 =?utf-7?B?amFkOGxDTDV4SVNPVmlhS2RKaXdSTWh6VVlRQlZtdnhLbGRQOGFBQzdjKy1P?=
 =?utf-7?B?UnVTUWJtT2NQNGt0cVpZa042MjA2VmJvUEdyMSsteHMvTzlMUE5sMXVQcGc1?=
 =?utf-7?B?U0J1UkN5eUxnYmZGc2VqWTI0NXFZUTdsdEZBRzE0eGI3ZXcyUndzRnZwL2J0?=
 =?utf-7?B?YUZiMGtuVlhhbGJRN2p1SlNsYjNjRGN1YzhaTFRnSndKanFBeXMyZjQyZ0ZN?=
 =?utf-7?B?Z3FIRGF4amp0OFVhbUQ3L0luYk12OTRjU0FJOXk1MFdYT1VUT3NEWmdJQ3ht?=
 =?utf-7?B?ZTNya3IwVEg5WE83ZnlFMVJqdzA3cCstVkp6VTdseW53bEJqOG5yYUY3NXBS?=
 =?utf-7?B?dXNOdnV6aHcvNzZwU3h5dVFaWFJSblVKSFM1ZTFiS2E2TE1zRmswd2kzS2V2?=
 =?utf-7?B?cFBWY3NDdVlBWkRzMEN3SG9jMEVaRmNZTE5PS1dQUndaMy83THVaSkd2WlRr?=
 =?utf-7?B?czJWMTlGZzJwRkxPcVl5ZW1MVFBDY2tvRDM1UDlzWnNXL20rLTM1Ky1rckh0?=
 =?utf-7?B?YzV4aTEvN0lDeGFOeGdBMlc0OFpqUGV5NzhaN1VmS01mS1lSZXB4OUhBSFA2?=
 =?utf-7?B?SDdVOXZkN2l6aTYzRWZ1dXgvN1UrLUtJTEc1SHNoVFQ2dWtBcURyYXBodmdY?=
 =?utf-7?B?aDNsMksvM1FRMlZpNDNMVzNkTDZhbjEvcU5vcS95V084NC9aQm4yVXBDMmF5?=
 =?utf-7?B?SXpiOEdQbEJCWEdqN2VxYm5UaWZqR0tnOUx4ckZrTFBJaElZb09hMlkyS1ZQ?=
 =?utf-7?B?ZXBMYldQVTdmM1NoSngxZm90VC95N3oxUE9hWTdPRm5wbkQrLW4zMkp3ajFk?=
 =?utf-7?B?QmFyU2x4MmorLUU3c2FaYUJnNDJwak5pYTF3cmVTeUgvUFRBaWFaczRrS0Rj?=
 =?utf-7?B?YWdqM2VFSG1nQml4bEVqRkYwMGJtSm9hQTRMVjNEODZ0akZ3d0p0UGhleVBj?=
 =?utf-7?B?SEx3WGxHZlV6anQ2WlUxclo0ajMzV1d4RFB3TFFyQVJGMWp3RXE0aWJ6MEM4?=
 =?utf-7?B?N0RyTDJMem1qYnFQUEs4RDdDVzVPaDhwa0h3TFdHNVN4ZkQvdHJ3YzdHV21I?=
 =?utf-7?B?NzNWRFM4YlMybTZwTWtOQ01ud2I2bURkNXhKbXdHQWhhSEZybkpHVVl5eFhC?=
 =?utf-7?B?L0FRcGJxWGw0VmNYREt2T0FydEttQkRrbDlNaHVOKy1oRy91Ky1oQzFaYVZw?=
 =?utf-7?B?TXljWmFaU1M5b1NVL3FIQW8vT0Z6UkhCdGtRTzFybGdlcHZkUjdlY2IvbkhO?=
 =?utf-7?B?VEtESmc3TTgyZFVuc0hiT05xQ2xhU2c1eDlNcEZwczAzbjJCc0p5SHl4RzFq?=
 =?utf-7?B?cFdycGF4bWV0bjlSYU9kV2M1clRER2c5c2JnN0hMaHgrLWpwV3JRNVJ4ZmpD?=
 =?utf-7?B?NCstU3c4OHNVY1VSSjR5WmNGbjh6ek5DOW9TamZmTEdLM3Zodjk1VTRQd3JL?=
 =?utf-7?B?cEwrLXh6Ky0wVzdYcHJEWXdsSy84M0lPSnEwOWZvcQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?cldRYnhIcjhDMzQ2RFlXR3ZYWDNtVystME5VYjhMUnNVYzBvaG9KYUJqSFpH?=
 =?utf-7?B?N21uZjRPdmtVcXBTaFVPanRwZFJ5UkpjTmNXRDg5YXlUSmFaUmJxaGI3eXhF?=
 =?utf-7?B?eVJiRXdyWmNPWTFNMUFNRDVSbkVBKy05emgrLUdOdXFIWkZKS3FmaUY5WVB4?=
 =?utf-7?B?STloSjExUFVoSmI3Ky16eVdvVExKdE9PcmlJZXRUbjhmbUhHMXdKV3BrQVFt?=
 =?utf-7?B?UVZpSFFVUXhjVUZqRHhHSUtaKy1laVVjWUpKQ3h3TDN0d0lOUUw2SlRBZlVN?=
 =?utf-7?B?NHpuL2kwVlpGL0k1UnhYKy1Na3NJTlZ2bldkN2NGV0h5MjJqdVdCUEY0d3JD?=
 =?utf-7?B?WDBadTlWdklLSkZ1TzdTeTg1aUZtc2FkYWFDdXpadFZjZFNsRU4zeTByTGhX?=
 =?utf-7?B?WTFEVmdTVGs4QlJtclp2N0owdkF1T0dtNjdlNFFsUElTR0c3NkduZ0RBR2oz?=
 =?utf-7?B?TFNZUmcwTUFJclp6YUI4Z3BRcmdqSTN2ODZWQXlRYWdTN1h2a0VLb0VWVXFh?=
 =?utf-7?B?T1JXRkNoaHE5NFJRTVhpSGNMbENqby9JMVZBN01mQk05QkpidjAycjBva0Jw?=
 =?utf-7?B?TklybFhPeHB2N0d5WkhZUWRraUdzbWxBU2hWck4wcEN6OEJoWGkvUW5lUUZU?=
 =?utf-7?B?MystZEZXWmxXd0xiZ0w4Um9NSE1LSU83TUhZMzJHb05HT0htZkU4VFdMWSst?=
 =?utf-7?B?aFZwd3lxQ251eGNPdE5aNHZ6S1cwakRUQm0xRWhNREtzZVdoRzJmSE1UUHRB?=
 =?utf-7?B?NjllOWNpbGR2MjdXR1IyQnZFSVJWMkFsWXUvQlYzdi9ZaUhsV0UwYTRyZTE4?=
 =?utf-7?B?SWNBOHpHc0RWWEQ0aDZ2N1ZpbC9sS1ZZb3o0YlVzd3UzNzhNVTBXSmpPd2Fw?=
 =?utf-7?B?RWpZN3hlSDBPOXVrQm0xVDVUdzAvU01xakV3NFJGTEp0NHg4SUlmUXZVM2FO?=
 =?utf-7?B?dWtuaTVRR3J6OHcrLXB3N0FKdlJwaVJhNnk5L0ErLUdQQXc0OXJOM0F6dFRq?=
 =?utf-7?B?OE5rYmRMRjhSdlhSMk1sSFZpQ2NuQWhJam4yVWprT0tRL0NrYnMwdG51YUh5?=
 =?utf-7?B?YWVYaXl3RGthSEY4MGx1WTdKY2NpMWZhdVNFb0NKOHF6cVJlS21TUUJReDVn?=
 =?utf-7?B?ZXhlcjdzL245VGJVOVFCbkc2VistVEUxKy1rSUUzKy1pWUphKy1LUUlMa1I=?=
 =?utf-7?B?Ky0yQkNJSjJVOEZKOWFhSWF3WW5uemo0SENNOXJJdk9nYU9zekgxdkdaSXpz?=
 =?utf-7?B?YWFMR0x3MW4xdXFiV0Y1dmxHZ3dxN2h5VnZjTWdJdkovVVFYUDk0QVVnZGVN?=
 =?utf-7?B?eWdWWlk1SjNQRHZSYkd1akljQWRNRGYrLUtoNHZmNnZYUXlNcG0wVzBnbThi?=
 =?utf-7?B?UFEzSUhqbnJoRDNJVFRJZUFRSlU4bm82Q3FOL3BadDgwVUFJeC9BeWtNNlRV?=
 =?utf-7?B?L2x5UTQ0NUR0T0JJdlB2L3FjVnVLc2RFOHpESG8vWWJ5eGdoanRCa1d4alhv?=
 =?utf-7?B?M2FFL2F1SDEvV3VjcmRyVkxMbmpESDlmb1RNU1NqSGxOR090NDFYckM1YzFp?=
 =?utf-7?B?c0duS25hQnNFdU00NndhSlB3NWdndi9mUGprZXozMTdYdSstaVp4R3BiaXB6?=
 =?utf-7?B?ck9TNHZCY1dJZkhCVVFVd0NHcThqNDVIWWw4d0NyV0FFaWtxOC9Fb0s4T0w5?=
 =?utf-7?B?eFRCbi81aFdaSExMcUZhMWFFOHN0MFRKUzBrOXRZLzBVUS9UdEViVjFHU0tH?=
 =?utf-7?B?UW5YaTRyUW5nSTRYbUZrbDZqNmxiZ1NVWnkxSHptVGE3TWkxTk84TDVqcmU=?=
 =?utf-7?B?Ky1EbGQ4T1dTQnR6Wk9UbUtUQTlxakVGVTgzL09QcHY5RXdQUnVSSGlxWUc=?=
 =?utf-7?B?Ky1uMmZFU1ZvM0tUeDFIUTM0TWVmTHM2b0JjSVRJYXZ5czNabWFlY3dYY0Iy?=
 =?utf-7?B?Skp4VEQ1THVQQmZQeUtYSG9BemdxNkEzcm5SNksvQjQvQnlNSlpqTXh3NFpB?=
 =?utf-7?B?enNHWVN0ekZURTFCaVF3VEJON3U3YzF4OXV6RDJ2bTVwbjc1QzJoRistSWs3?=
 =?utf-7?B?ekhlUHhYZnhMNG5BaVJlcistOXBoWi9RTXFjQUxWQ1dKQWZZUG55NHh1Tmt3?=
 =?utf-7?B?MnRoeE5MTEV5RG1RSGpZYlpmY3ZEN3dtYnhTSjMwZ3BwT0VMUVh6VEdzNWZ4?=
 =?utf-7?B?dHk4dw==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9865266a-fd1f-40e4-122d-08de2115d802
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 11:31:23.5188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +IXq+8LMHra2ywsWvUc+AvUxFuFIpAb+HBqpeLrGaLbF2yr0LlyAy9N2npg70pP9NUQkKw2XCZ3mAgCNxqcM3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2NSBTYWx0ZWRfX3smWL8skX64t
 PXLGbyBvEnwtnaLkpEXQGpxvysDggz766JOEG2nGd4J24YR+WqsGpiBdbP/7Yfz5fXAIKZ6H/Ff
 CYcuILeWvcztmJyGIItoBFHwDLKWPkcACSYCfAdg1e0SMiaCzFYmpXePx/QgcPg1idTLyYMsCEk
 p/MkLouURAhdhVsGbVo5MVUEdFj2ppgfArAy31OP1M4pAFqU7A+LuzmiOWuom7zLdyafk5G3hsR
 sLjjSmTlt7SLXwGJ4k7OiFenXvKY8wO6s33En4r8E8Fxf6A2eA7Ip6Oj+26qf4uLztGyzbGtP2+
 5XoMlgzduZO4Won5c2DmwibyaasDfDk2A9m0lFGs1O7D27FOk2lUv/UIVR7jpN7mqMQdo0qZewl
 pEHS4IAGl73HQrAv6Bg/Y8nHs2aGdA==
X-Proofpoint-ORIG-GUID: hQyFGS5SInRghryScNGm8IdrWkH__AqN
X-Proofpoint-GUID: hQyFGS5SInRghryScNGm8IdrWkH__AqN
X-Authority-Analysis: v=2.4 cv=BMO+bVQG c=1 sm=1 tr=0 ts=69131e91 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=TWYSljadmAguvVshPxsA:9 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080065
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

Responses inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4- Sent: Tuesday, November 4, 2025 12:06 AM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v3 4/5+AF0- vhost+AF8-user: support function =
defines for back-end
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
+AD4- +AD4- Here we define support functions which are called from the vari=
ous
+AD4- +AD4- vhost-user back-end message functions like set memory table, ge=
t
+AD4- +AD4- memory slots, add memory region, remove memory region.  These a=
re
+AD4- +AD4- essetially common functions to initialize memory, unmap a set o=
f
+AD4- +AD4- memory regions, perform register copy and align memory addresse=
s.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-  lib/vhost/vhost+AF8-user.c +AHw- 80
+AD4- +AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+--------
+AD4- +AD4-  1 file changed, 68 insertions(+-), 12 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost/vhost+AF8-u=
ser.c index
+AD4- +AD4- 168432e7d1..9a85f2fc92 100644
+AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AEAAQA- -228,7 +-228,17 +AEAAQA- async+AF8-dma+AF8-map(struct =
virtio+AF8-net +ACo-dev, bool
+AD4- +AD4- do+AF8-map)  +AH0-
+AD4- +AD4-
+AD4- +AD4-  static void
+AD4- +AD4- -free+AF8-mem+AF8-region(struct virtio+AF8-net +ACo-dev)
+AD4- +AD4- +-free+AF8-mem+AF8-region(struct rte+AF8-vhost+AF8-mem+AF8-regi=
on +ACo-reg) +AHs-
+AD4- +AD4- +-   if (reg +ACEAPQ- NULL +ACYAJg- reg-+AD4-host+AF8-user+AF8-=
addr) +AHs-
+AD4- +AD4- +-           munmap(reg-+AD4-mmap+AF8-addr, reg-+AD4-mmap+AF8-s=
ize)+ADs-
+AD4- +AD4- +-           close(reg-+AD4-fd)+ADs-
+AD4- +AD4- +-           memset(reg, 0, sizeof(struct rte+AF8-vhost+AF8-mem=
+AF8-region))+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-static void
+AD4- +AD4- +-free+AF8-all+AF8-mem+AF8-regions(struct virtio+AF8-net +ACo-d=
ev)
+AD4- +AD4-  +AHs-
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+ADs-
+AD4- +AD4- +AEAAQA- -239,12 +-249,10 +AEAAQA- free+AF8-mem+AF8-region(stru=
ct virtio+AF8-net +ACo-dev)
+AD4- +AD4-     if (dev-+AD4-async+AF8-copy +ACYAJg- rte+AF8-vfio+AF8-is+AF=
8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4-             async+AF8-dma+AF8-map(dev, false)+ADs-
+AD4- +AD4-
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- dev-+AD4-mem-+AD4-nregions+ADs-=
 i+-+-) +AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- -           if (reg-+AD4-host+AF8-user+AF8-addr) +AHs-
+AD4- +AD4- -                   munmap(reg-+AD4-mmap+AF8-addr, reg-+AD4-mma=
p+AF8-size)+ADs-
+AD4- +AD4- -                   close(reg-+AD4-fd)+ADs-
+AD4- +AD4- -           +AH0-
+AD4- +AD4- +-           if (reg-+AD4-mmap+AF8-addr)
+AD4- +AD4- +-                   free+AF8-mem+AF8-region(reg)+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4-  +AH0-
+AD4- +AD4-
+AD4- +AD4- +AEAAQA- -258,7 +-266,7 +AEAAQA- vhost+AF8-backend+AF8-cleanup(=
struct virtio+AF8-net +ACo-dev)
+AD4- +AD4-             vdpa+AF8-dev-+AD4-ops-+AD4-dev+AF8-cleanup(dev-+AD4=
-vid)+ADs-
+AD4- +AD4-
+AD4- +AD4-     if (dev-+AD4-mem) +AHs-
+AD4- +AD4- -           free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +-           free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4-             rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4-             dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4- +AEAAQA- -707,7 +-715,7 +AEAAQA- numa+AF8-realloc(struct virtio=
+AF8-net +ACoAKg-pdev, struct
+AD4- vhost+AF8-virtqueue +ACoAKg-pvq)
+AD4- +AD4-     vhost+AF8-devices+AFs-dev-+AD4-vid+AF0- +AD0- dev+ADs-
+AD4- +AD4-
+AD4- +AD4-     mem+AF8-size +AD0- sizeof(struct rte+AF8-vhost+AF8-memory) =
+-
+AD4- +AD4- -           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +AC=
o- dev-+AD4-mem-+AD4-nregions+ADs-
+AD4- +AD4- +-           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +A=
Co-
+AD4- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4-     mem +AD0- rte+AF8-realloc+AF8-socket(dev-+AD4-mem, mem+AF8-=
size, 0, node)+ADs-
+AD4- +AD4-     if (+ACE-mem) +AHs-
+AD4- +AD4-             VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AEAAQA- -811,8 +-819,10 +AEAAQA- hua+AF8-to+AF8-alignment(stru=
ct rte+AF8-vhost+AF8-memory
+AD4- +ACo-mem, void +ACo-ptr)
+AD4- +AD4-     uint32+AF8-t i+ADs-
+AD4- +AD4-     uintptr+AF8-t hua +AD0- (uintptr+AF8-t)ptr+ADs-
+AD4- +AD4-
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- mem-+AD4-nregions+ADs- i+-+-) +=
AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4-             r +AD0- +ACY-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +-           if (r-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4-             if (hua +AD4APQ- r-+AD4-host+AF8-user+AF8-addr +ACY=
AJg-
+AD4- +AD4-                     hua +ADw- r-+AD4-host+AF8-user+AF8-addr +- =
r-+AD4-size) +AHs-
+AD4- +AD4-                     return get+AF8-blk+AF8-size(r-+AD4-fd)+ADs-
+AD4- +AD4- +AEAAQA- -1250,9 +-1260,13 +AEAAQA- vhost+AF8-user+AF8-postcopy=
+AF8-register(struct virtio+AF8-net
+AD4- +ACo-dev, int main+AF8-fd,
+AD4- +AD4-      +ACo- retrieve the region offset when handling userfaults.
+AD4- +AD4-      +ACo-/
+AD4- +AD4-     memory +AD0- +ACY-ctx-+AD4-msg.payload.memory+ADs-
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4-
+AD4- I think the using MAX+AF8-NREGIONS are most for convienent, but it wi=
ll impact
+AD4- the performance, because the rte+AF8-vhost+AF8-va+AF8-from+AF8-guest+=
AF8-pa() should iter the
+AD4- entire array.
+AD4-

Replaced VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS with memory-+AD4-nregions. P=
lease review v4.

+AD4- I think we should keep the original impl: make sure the nregions entr=
y of
+AD4- memory-region is always valid.
+AD4-
+AD4- Beside, where is the modification for rte+AF8-vhost+AF8-va+AF8-from+A=
F8-guest+AF8-pa()???

Could you please provide more detail ? rte+AF8-vhost+AF8-va+AF8-from+AF8-gu=
est+AF8-pa() was never called from here before.

+AD4-
+AD4- +AD4- +-           int reg+AF8-msg+AF8-index +AD0- 0+ADs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- -           memory-+AD4-regions+AFs-i+AF0-.userspace+AF8-addr +=
AD0- reg-+AD4-host+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-           if (reg-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4- +-           memory-+AD4-regions+AFs-reg+AF8-msg+AF8-index+AF0-=
.userspace+AF8-addr +AD0- reg-
+AD4- +AD4-host+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +-           reg+AF8-msg+AF8-index+-+-+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-     /+ACo- Send the addresses back to qemu +ACo-/ +AEAAQA- -127=
9,8 +-1293,10 +AEAAQA-
+AD4- +AD4- vhost+AF8-user+AF8-postcopy+AF8-register(struct virtio+AF8-net =
+ACo-dev, int main+AF8-fd,
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-     /+ACo- Now userfault register and we can use the memory +AC=
o-/
+AD4- +AD4- -   for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- i+-+-=
) +AHs-
+AD4- +AD4- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+AF8-N=
REGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i+AF0A=
Ow-
+AD4- +AD4- +-           if (reg-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +-                   continue+ADs-
+AD4- +AD4-             if (vhost+AF8-user+AF8-postcopy+AF8-region+AF8-regi=
ster(dev, reg) +ADw- 0)
+AD4- +AD4-                     return -1+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4- +AEAAQA- -1385,6 +-1401,46 +AEAAQA- vhost+AF8-user+AF8-mmap+AF8=
-region(struct virtio+AF8-net +ACo-dev,
+AD4- +AD4-     return 0+ADs-
+AD4- +AD4-  +AH0-
+AD4- +AD4-
+AD4- +AD4- +-static int
+AD4- +AD4- +-vhost+AF8-user+AF8-initialize+AF8-memory(struct virtio+AF8-ne=
t +ACoAKg-pdev)
+AD4-
+AD4- This function should be part of 3/5, else the 3/5 will compile fail

I have moved support functions to patch-3. Please review v4.

+AD4-
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4- +-   int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   /+ACo-
+AD4- +AD4- +-    +ACo- If VQ 0 has already been allocated, try to allocate=
 on the same
+AD4- +AD4- +-    +ACo- NUMA node. It can be reallocated later in numa+AF8-=
realloc().
+AD4- +AD4- +-    +ACo-/
+AD4- +AD4- +-   if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4- +-           numa+AF8-node +AD0- dev-+AD4-virtqueue+AFs-0+AF0--=
+AD4-numa+AF8-node+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs-
+AD4- +AD4- +-   if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           dev-+AD4-max+AF8-guest+AF8-pages +AD0- 8+ADs-
+AD4-
+AD4- It should be VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS

Done. Please review v4.

+AD4-
+AD4- +AD4- +-           dev-+AD4-guest+AF8-pages +AD0- rte+AF8-zmalloc+AF8=
-socket(NULL,
+AD4- +AD4- +-                                   dev-+AD4-max+AF8-guest+AF8=
-pages +ACo-
+AD4- +AD4- +-                                   sizeof(struct guest+AF8-pa=
ge),
+AD4- +AD4- +-                                   RTE+AF8-CACHE+AF8-LINE+AF8=
-SIZE,
+AD4- +AD4- +-                                   numa+AF8-node)+ADs-
+AD4- +AD4- +-           if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-                   VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, =
ERR,
+AD4- +AD4- +-                           +ACI-failed to allocate memory for=
 dev-
+AD4- +AD4-guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4- +-                   return -1+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-socket(+ACI-vhost-m=
em-table+ACI-, sizeof(struct
+AD4- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4- +-           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region) +A=
Co-
+AD4- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS, 0, numa+AF8-node)+ADs-
+AD4- +AD4- +-   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR, +AC=
I-failed to allocate
+AD4- memory for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4- +-           rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +-           dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +-           return -1+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-
+AD4- +AD4- +-   return 0+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-
+AD4- +AD4-  static int
+AD4- +AD4-  vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF8-net=
 +ACoAKg-pdev,
+AD4- +AD4-                     struct vhu+AF8-msg+AF8-context +ACo-ctx,

