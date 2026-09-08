Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DBC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:55:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97534402C3;
	Tue,  8 Sep 2026 05:55:25 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11022092.outbound.protection.outlook.com [52.101.53.92])
 by mails.dpdk.org (Postfix) with ESMTP id 5BB394026E
 for <dev@dpdk.org>; Tue,  8 Sep 2026 05:55:24 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GuXbNwZ4HQGT5X9O8IYtJf0anSqQ6wMy9K2/dHgCxVi9/+hWz/8Y0PPuMNZdzGZiNDFifybNZgkXxSsYCIQgT5tDQJhIwtX4yaoJZAXiImvGkk0oea5gTIhEwZ3nQrXMg2AJkPYS6ASBwkBdHWaPwVWK69VnAhLjFovVeZ5vzsMYPThA9aOpw09x9d0JslOCqeGC/qeeB5horuI1dJ1BxuvlZqrLYPIfkOkvZzprUiPpg56NRleaemTH9IdQ3OvfIYd0xj6cGUugnxnlKu0GmRT1P53+PgwSpTCzYY7HQRj2GksM4Os8ojTxZRaIRpux7soh2+CxYUxPDVIKp6ElLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpQNfOHGUw4tPCJcDjsN4WOZY6AjXMnvTqrr7rFs4+k=;
 b=cpo3loUZptdSrL/drAg7IgavaJRjNdy80Ldcy3PfZB8nLgXi/3gTmAfAd6hJayhXgtdUPf3WSv3lzgOMHrUG1mSK3CpSElJ30YCg5HWDvF+n12dRBoDH17ea6DR42PayqjhstakjAyou9r2QRA8ik4rlQQ56lfVXcRI/619UZ9EskPoYexEF05Y7Jcmr6754HvnUVfFohszIpVzrXLbNJiGRIfJ2rOcGTdGonXSqyTyasEOYBeX6pRRz3a82p1iiQJ7U4BMXiN87akVSTg5PhFPRP/EKAYzLKssMZTc0JOc/RG4V+fsrFU3Mnwv9f+a8JLnoNFzIlqaJvKSbmr7cFA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 64.65.23.201) smtp.rcpttodomain=dpdk.org smtp.mailfrom=versa-networks.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=versa-networks.com; dkim=pass (signature was verified)
 header.d=versa-networks.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=versa-networks.com]
 dkim=[1,1,header.d=versa-networks.com]
 dmarc=[1,1,header.from=versa-networks.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=versa-networks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpQNfOHGUw4tPCJcDjsN4WOZY6AjXMnvTqrr7rFs4+k=;
 b=ZIrRmdbnXwg3QFsJ5o9JmedSHrAdHOPG5gn3OQAricAu1J6AeimBOsaD9mVYelMR6aYakjrTy05FEw64YnYFOtf7ROOfJhYDug09NVYwBOLfv/1AnXMHhmnhKAw39VhiGRfXmR4ZJb7XtbIbR4S+8EHzM++O0uut1Yd5nvTcxFSap3chUZpTtYcUP940gFgMu6HPQRpQJoe/LGsgSEWX443BlbXgLYJPPwKkWPsfEXBkkqxTMEEgzOdN+5mr1Z4mYeOCVcCSpodfBUd0XC7mbXh18+vdMYO/U0xsOsT5K6zfLOva2ntXI9SwMQsQ7wuxhatOYaWUXQYhXFryevs/tA==
Received: from SA0PR12CA0013.namprd12.prod.outlook.com (2603:10b6:806:6f::18)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 03:55:21 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::2b) by SA0PR12CA0013.outlook.office365.com
 (2603:10b6:806:6f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 03:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.65.23.201)
 smtp.mailfrom=versa-networks.com; dkim=pass (signature was verified)
 header.d=versa-networks.com;dmarc=pass action=none
 header.from=versa-networks.com;
Received-SPF: Pass (protection.outlook.com: domain of versa-networks.com
 designates 64.65.23.201 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.65.23.201; helo=versa-networks.com; pr=C
Received: from versa-networks.com (64.65.23.201) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Tue, 8 Sep 2026 03:55:20 +0000
X-nn-versa-inspected: true
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (10-0-98-203.ingress-data-ingress-nginx-controller-admission.ingress-data.svc.cluster.local.
 [10.0.98.203]) by smtp-proxy-787ddd9967-7q4sn () with SMTP
 for <dev@dpdk.org>; Tue, 08 Sep 2026 03:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxE0u8iLa25v02lm1pJvM31rVr+Ls7jykf7RhLzA8UCCrKom1neEof3v9VngDCDFvmTeHN4Q6bGxYZFIF7LQrQRPE12DhdEjggcEe+rgQUyJUgHkwBno4dVvlY1Lv9yfEkPp7i4UsJ8E4vHOd4j/jfX3bxmZeNvk2PzL6qijBQipqODTW29b2c5/35hPLBo+GuAiOX9mN77UX3kQ6lBxdn9L/Qaznzh5Wg9zJMn/IHLEugFzc81nBU6tDSWtkDBIlDNRAZci2jiv9spVa9c/uAsqtUznRP/NbKNKs1XD4tm2w7wAApwAdxosQlV6v7ASNasbefVoyILxfsFavGcgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpQNfOHGUw4tPCJcDjsN4WOZY6AjXMnvTqrr7rFs4+k=;
 b=Lyxu9O7C9aKgZ0wuJrf5Y3ByBDCJ128G/QXxqM2w10JimYLNTKErNwaaFd6TImsw0UCw12EWu6c6qyAofp7KJmEArowWsYlzB3UgBhCDbVfnsaJ9njfnYxu1FjNAF6uu5AD8cksMdZz78hxOhYfT9XodcROD79DQN3XRuKfnbQGRZH7u/U42e033x9pliHOWpsDJAht/sXQNDTyNLxja59txqY3e4IgCmuCeKezJfhaYEYG0hNYafOZuu2V4ABQcwZhvAbPsKy+yZO6EAQR3FKUIOH8zql73J7AktiV46htkmGfwaUWMcXrdlJabroxhJ+G/NVD6a6/8JC11xR5Lrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=versa-networks.com; dmarc=pass action=none
 header.from=versa-networks.com; dkim=pass header.d=versa-networks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=versa-networks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpQNfOHGUw4tPCJcDjsN4WOZY6AjXMnvTqrr7rFs4+k=;
 b=ZIrRmdbnXwg3QFsJ5o9JmedSHrAdHOPG5gn3OQAricAu1J6AeimBOsaD9mVYelMR6aYakjrTy05FEw64YnYFOtf7ROOfJhYDug09NVYwBOLfv/1AnXMHhmnhKAw39VhiGRfXmR4ZJb7XtbIbR4S+8EHzM++O0uut1Yd5nvTcxFSap3chUZpTtYcUP940gFgMu6HPQRpQJoe/LGsgSEWX443BlbXgLYJPPwKkWPsfEXBkkqxTMEEgzOdN+5mr1Z4mYeOCVcCSpodfBUd0XC7mbXh18+vdMYO/U0xsOsT5K6zfLOva2ntXI9SwMQsQ7wuxhatOYaWUXQYhXFryevs/tA==
Received: from DS7PR11MB8855.namprd11.prod.outlook.com (2603:10b6:8:257::21)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 03:55:12 +0000
Received: from DS7PR11MB8855.namprd11.prod.outlook.com
 ([fe80::5a7b:4b18:336a:f6b8]) by DS7PR11MB8855.namprd11.prod.outlook.com
 ([fe80::5a7b:4b18:336a:f6b8%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:55:12 +0000
From: Mukul Katiyar <mukul@versa-networks.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: [RFC] Highly efficient reader-writer lock (EPRW) for mostly-read
 applications 
Thread-Topic: [RFC] Highly efficient reader-writer lock (EPRW) for mostly-read
 applications 
Thread-Index: AQHdPxNCkfkFOcf4dk+KXkrBYu7Fpg==
Date: Tue, 8 Sep 2026 03:55:12 +0000
Message-ID: <DS7PR11MB885556AF77C5110C85609B7B8CB22@DS7PR11MB8855.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=versa-networks.com;
x-ms-traffictypediagnostic: DS7PR11MB8855:EE_|MN0PR11MB5961:EE_|SN1PEPF0002BA4B:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 0452134d-a341-4f23-65d9-08df0d5d00d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|376014|10067099003|18002099003|55112099003|11063799006|56012099006|8096899003|13003099007|38070700021;
X-Microsoft-Antispam-Message-Info-Original: vVJllgzBfq0tYuk1S10HisqvSZ1wSxZghUN3jVSMNoqvSue/KmLTMhxNXHuyG8WlSXYmvon90G8ouaNs11eMWbkJzYNFjpQ7+10Ni/+XvEjVn179LftOjbRPmmRsWEz0JeZVONgRTzbwyPpdTzJxAFSAdyqVAN2gE4SDJZDJeW2/ExoRMxwDm0Ap46JSjM7S/ZT5U4d4eY8L37I9PkBFIGuURljba2EaRqolxdvWc7T5GF6s7tj3D2fcSslSTWym1Gn5DbKdoiEwYzUr/eLacEdzdJ+xfBi/sLMWUqdt/h4NOTTWETsrUdHHvyabjWoDZYo+WgVDvym7KbwFsknMi1u+7GFEE7ZjR/XpwsJkfPkHAbzEiPGJyNgnzmFKs20vo0n9uLYLkKN7Rc81X5vT0ILMrbbvGpnmXpiSio8p9iRZNCn4hqfCDnXDlzpeslj9t4/eIXwdf/Xfvl8nDsJIFRK3J+hdhYFRbhXATDIoOov5HMOpyZ4CbG7WdnlDOiNbJ4CvOdwNMPuEojWGZS+OSCgKPCoyiz/P18ZJPceRPDjbaAGyJyQnbOpNz6Yu2wSmvYSVcK1My6vod1ACHmqHXIwp0TVjQKFY8dh5MJMthliuSfAZ490kO/YtweI63OBnAnjzijWcgWEjMw6Gi42Xt5ZhWGC8J4o8veokPm1AJrw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DS7PR11MB8855.namprd11.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(55112099003)(11063799006)(56012099006)(8096899003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: multipart/alternative;
 boundary="_000_DS7PR11MB885556AF77C5110C85609B7B8CB22DS7PR11MB8855namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vpXGUVdXPboCtuXpRlIAC0olLO2lYvA2GoOk1+/WninmW1eekoK/l363Jfm3GyghYtrSeLWJ516HMH64+NBr8QhwqGbup6/RbniX2CcZtjz0kqZRWIW7U/6Hoi8TYQCsR0uLXm0LB10SY1JiY4URiHFZqbFdL/+Vo2edhsKm9lyeIltTC93Tg+f6G4KUfmdC1p5Jyge1d6Hj1CWd7HM6a4ps741zGMjR73l18tFGIFu4XsFPjz53ov8Ww9uCS5+DtA+FCz8OeMEFS6e6t6/hBdbRRSQTmn+eyuNcvY9YSweT+LLb/TQ5JT1DxToQ76rm37IJ35ash/hwQ1KYXtPqWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: beb0ce00-03fc-4afc-b06f-08df0d5cfbaf
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700016|23010399003|1800799024|82310400026|14060799003|10067099003|55112099003|8096899003|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: ghlrAUU3Xhr9DsA2r7xisGaIiNN1NzkctifJ9Ejhk+DVmqp4YkudoylxgYtvphcTjl7uUxMeq0cBjPqbw5ytoQRlypM1/SmeT3unvplDIzf359InmyPtK79ZcIBOHB1SiSYdMS11IDk6Z/mSRU5G6OYh0GLPxJpsVkvXbISr86I4tM+C/clB3CpCobBgDMXqK3qT8C58TuOiMaOIHRGU1pLEH0+6CYjS0xG4Z511W97AK9q3Fv4GHUNsioGQfIQZhZ6mo4EO1zOQr5XJkp/HtmjDEdg1JG9Dc24QMR1ATFmasVBqWaPJxUPdRqjOXQqj1HVYL6DJEPaoy6R+SyKU4csJM+ztfpZ+t+P5N+pNhFKDtreoxW2thHQyJd242maeRFfx5wE6fqLFt+MHKvmJS9MbjbH8VEPZnM56YpYRtGVykNZpFkRqtqSv131eKpBCZm+q8HZbHAkeY3Z9Ax0dx1+jN5qgpSpxwhsPe/W81A+Rg7avfRLjl6PRXpnUSx5CkuoZ5qRbbamYm7JAu6cPPNOKGTi+nEsGdM5Z49OqtmRm+O7FFjs5GiPs/5wi82Gu+zqLNDQ9dd1uFSAn/DjEaX3WoZwAgjn1/ItGpI/LnYMJYmeZzUZBT6oZqSYZlrl/GDBpyGoZ5bM0SRYll/+jhQ==
X-Forefront-Antispam-Report: CIP:64.65.23.201; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:versa-networks.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(14060799003)(10067099003)(55112099003)(8096899003)(56012099006)(11063799006)(18002099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ChhLxUjELAXX2UUDvJKlPr/pdPiA+rlzUDKtYdYs3tQ2R/IKjEZHjHaaU1jApC52HCSmSRYgsQ1fnlWdASKP9j0zZJfCydz99MhQcYku49dToYLS/bP8UInyHk1DseCpZH3AFhFgJxw1259CHa7rjJ91+B0Pm7PB1qpfIW9scdUZsVXwqyyg+b9Cp3+wRyKmcZDuIzEVPGdl9YQ5vrKyiOC/hxz84i4HyG1TAxrs8idHelf+yTIMu7wybSs+6KVvWPDODzVS+dYekiksvG9NEPEYUNO+hdz2OlLN6NNKolRGReeuhwc854ZCixwB3eob2UGx9ULasjNUItcgJ5+7lI38ZerDg7/gPp/eCEsONVMeLswfP8vhZJTvfyjoV4thQHH2ogBsX0mBi7IKlVJAo1NXcsbcy4xQ7GclDgBUbfxUOnHKR89wO5aAYDnLClsg
X-OriginatorOrg: versa-networks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 03:55:20.5937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0452134d-a341-4f23-65d9-08df0d5d00d9
X-MS-Exchange-CrossTenant-Id: d39a23bd-897c-45f1-a3f5-c5213b673627
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d39a23bd-897c-45f1-a3f5-c5213b673627; Ip=[64.65.23.201];
 Helo=[versa-networks.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
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

--_000_DS7PR11MB885556AF77C5110C85609B7B8CB22DS7PR11MB8855namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi all,

Sharing a userspace reader-writer lock that has been running in production =
in a DPDK-based network function for several years and wanted to check if t=
here would be interest in contributing it to DPDK as rte_eprwlock.

The Enhanced Passive Reader-Writer (EPRW) lock eliminates atomic operations=
 on the reader fast path, giving near-flat per-reader performance as core c=
ount grows. It is compatible with poll-mode lcore discipline =97 no heartbe=
at or periodic refresh required from registered threads.

Details, correctness proof, memory ordering analysis (x86-TSO and ARM), and=
 performance evaluation against rte_rwlock and pthread_rwlock_t are in a pr=
eprint at:
https://zenodo.org/records/22636501

Would this be a useful addition to DPDK?

Regards,
Mukul Katiyar
Versa Networks


--_000_DS7PR11MB885556AF77C5110C85609B7B8CB22DS7PR11MB8855namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Hi all,</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Sharing a userspace reader-writer lock that has been running in production =
in a DPDK-based network function for several years and wanted to check if t=
here would be interest in contributing it to DPDK as rte_eprwlock.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
The Enhanced Passive Reader-Writer (EPRW) lock eliminates atomic operations=
 on the reader fast path, giving near-flat per-reader performance as core c=
ount grows. It is compatible with poll-mode lcore discipline =97 no heartbe=
at or periodic refresh required from
 registered threads.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Details, correctness proof, memory ordering analysis (x86-TSO and ARM), and=
 performance evaluation against rte_rwlock and pthread_rwlock_t are in a pr=
eprint at:</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://zenodo.org/records/22636501" data-outlook-id=3D"443fd9b2=
-04c6-49d0-9eb7-7e8eb0354251">https://zenodo.org/records/22636501</a></div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Would this be a useful addition to DPDK?</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Mukul Katiyar</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Versa Networks</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS7PR11MB885556AF77C5110C85609B7B8CB22DS7PR11MB8855namp_--
