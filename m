Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC54CFEEF48
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 13:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C102F40265;
	Tue,  7 Apr 2026 15:42:34 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3DFD34025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 15:42:33 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VU40y44Y545fLNDKfQStrQVq8HEjDvnVWpPg1yvt4hcE/bRGnPwk8N8WgolOvIFsryZVHvCBgPD3BJPlA2Sg8z0Sm3XFXnOSixIhJLtn9S+l31oTr0K9Gr3fDByq11cZqz8hMkX0J94f4KYm4/bf2gNd5LkVrfE0dWHi/75qykueCFR4YZ7a6mMXz/DOLXJI4qa6VAVCGkFhunsOwZI+UVGf1wkt8npdAP45FFbMB1JTF+rs/sw2/3HDjXtnzs715puiA8ucKSwm5W65jhs65I6bsb7yvTehUWA6DYpgm1MANPgPF1yypvQxegsLd5qitAOptOvjLCnCBN0I1PmlUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpeW7EhoBAm9YeE8CWvf4sU36Wcx0DYYPGQIk6v4hjg=;
 b=I5EkfgZ+DaklI5cp9tuor3dZWuVFGh+xJs+UUBCfzXT46okZPCwJfZG2cHXpl35EO2cIjHhEY2W3k65QtbFIYk/6npm4XyvKQGugHTqaYoiDBKY2h5ZDH2tRw7KJ9E7PUq1yGbsZNtMovN3NoMw0aR5XOXXKAufEm7Kw9UmVIhHAB89SI02bnrLOgnW+JlEDjY0d237aoa8FM1LFzxtXE31O6PDce13/T970hfxP5aWIZtQxsindFLT3AMBn7EGz2Wmqg04ozeMs3+5sU9QLVTLfVgdZVt/X/azK7k2hZ3w4J71jnoUpkMuAwxJLoFQgUJItVes/iYbgz16xJdZC9Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpeW7EhoBAm9YeE8CWvf4sU36Wcx0DYYPGQIk6v4hjg=;
 b=D8kbrf4rd9e5E6IU3Vkin/2+TPn9EhI/7kxL2FGpXnG/313r/s7BtkLI56lt3a9gLUUWoov8VUmjUNEwettwG0CzDiND4QCl2gxv0Mkq2PnUpINCzhdgzBJMZYQVDaMb2b5UCL8DhDpy1w5vkyPCz/Z+GN60Q0yB5w7KK2aHg4g=
Received: from DU2PR04CA0357.eurprd04.prod.outlook.com (2603:10a6:10:2b4::32)
 by DB4PR08MB9264.eurprd08.prod.outlook.com (2603:10a6:10:3f7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 13:42:28 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::2d) by DU2PR04CA0357.outlook.office365.com
 (2603:10a6:10:2b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 13:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 7 Apr 2026 13:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRpL8BejZhnivaplZyq1haJaJEPdfYcsWMVi8vlBkmC2zEP4vBBSapNnnVCXF+Q3wUX7JuNW+LKDMJRnqKzQFuAGg/TJOby4Cv44yP6pBbLPOkMxexL6r9G7RqSBTT15KoWwsaY3VvplkygpwRsXweWg1OKepAXUF9RKzKPVvUSWqUVfXXpnoeg1bQ7fJnhoaEHzSsCTeoCUzQW+RvFFLs89ysArj5GqEV5Ls/Pl7rPclgk58u4993b3xMfEKwysUwGyxTiEv0NJpa1IDZADLfpC3vBkEQ+MhMPnkw8BkWz9Rr9dXVTbyY68ALFqT+jKZxs5sk9l+YCpzF2l1Djdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpeW7EhoBAm9YeE8CWvf4sU36Wcx0DYYPGQIk6v4hjg=;
 b=JCh+Qsh758xqFUg+eYlenVkM7FR0ExJkKcZlvX7r4PTWNfEwMMwHVtlWd04v850BZq73BYUunPMxe1nVJ+mYzXZGKJCA/tTOTCW3P3qx3nCDxYZ0+6N8zMFoyEuzAIhfp7os8/wEtMhnfchuemIt4kDGp2MJOVP3tajQoDpSiarTLJk8tM2P1Y1+r1nlYwHGYyQCYJjQWXvWcl1PqeztpL2GhuBtOcuVAaJzUvUj0JeTLkooHO8VMckSMbk54CcjyiWyw40meV8ZNNFDL88ulJBrr7llVSNWKoR1yb1TBelBq3etip6loTuCbqHhRaATZauwHFzt6ENlcNoLc5hlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpeW7EhoBAm9YeE8CWvf4sU36Wcx0DYYPGQIk6v4hjg=;
 b=D8kbrf4rd9e5E6IU3Vkin/2+TPn9EhI/7kxL2FGpXnG/313r/s7BtkLI56lt3a9gLUUWoov8VUmjUNEwettwG0CzDiND4QCl2gxv0Mkq2PnUpINCzhdgzBJMZYQVDaMb2b5UCL8DhDpy1w5vkyPCz/Z+GN60Q0yB5w7KK2aHg4g=
Received: from PAWPR08MB9446.eurprd08.prod.outlook.com (2603:10a6:102:2f3::7)
 by GV1PR08MB7380.eurprd08.prod.outlook.com (2603:10a6:150:24::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 13:41:17 +0000
Received: from PAWPR08MB9446.eurprd08.prod.outlook.com
 ([fe80::c095:9483:83f:66e6]) by PAWPR08MB9446.eurprd08.prod.outlook.com
 ([fe80::c095:9483:83f:66e6%5]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 13:41:17 +0000
From: Jay Wang <Jay.Wang2@arm.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>
Subject: RE: [PATCH v2] net/ice: add NEON-optimised Rx/Tx vector paths
Thread-Topic: [PATCH v2] net/ice: add NEON-optimised Rx/Tx vector paths
Thread-Index: AQHcu6rkNpBSHhrkHkGGTuH4P++y2LXNdl6AgAYKDYCAACzfEA==
Date: Tue, 7 Apr 2026 13:41:17 +0000
Message-ID: <PAWPR08MB94463E85B6B52AED2679761FBA5AA@PAWPR08MB9446.eurprd08.prod.outlook.com>
References: <20260323183231.3988257-2-jay.wang2@arm.com>
 <20260324162525.4083381-1-jay.wang2@arm.com>
 <20260324162525.4083381-3-jay.wang2@arm.com>
 <ac_Pv0hhrBFlY5oy@bricha3-mobl1.ger.corp.intel.com>
 <adTgq107Xrq4yLD0@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <adTgq107Xrq4yLD0@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB9446:EE_|GV1PR08MB7380:EE_|DB1PEPF000509E5:EE_|DB4PR08MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: d0deca77-db43-49dc-e453-08de94ab8275
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|38070700021|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: EKSEfg9ZuFlHtsQUnrpb5JXQKvuTPk+bQAwF8K8YsOt9FGI6/Xr2PllioCIrjRuy/Fzymz7ho9XfNGE4uUVTeLTKZdJIiv2QN0sd3OVTHS3clpOtEHdvsN5tFl2qZ2wX17E2dcJcPq5z6gwQyM+gkzwfZGLMXMFabUjVjDzKWRu0wxkZ72v/H1OG6YRS1M2YPt7tNfovufUF4nt5J2PGmngjKCu9kaRs4In4FwgwHaLot4FeSwcPw9pZVqAEQPJOMpBzhoIHW30llaMMdSUuawHTeywAAVR8FniOyW/VDG+qYmRP+8+3bO6QmGrk53bXoDywAUdDe0l1kc7YeRTM3wyIW9ADN+c5g6Rli1WGicr8eISy7avguNvRaJ8qM2zj2QhgtT7JFiJNcq7TR/KboNeyH5cLZ8HzhqyqtHS0ycrVf5uLKkqlju5rmUjR13ktpbQryFfBQPEY+xrtQp2/lnQOosza43QTfdSt9zkkjW5Rv8NkpRxQ10Y9ob3jW79CVa+TVetRCmxbDa4joUAsuIYF5tKfdvR5F5XBaYhDzRs8KTqFs/85SAL9mm0TvX13pqneW5tpuA5s/Et8Rh5DVwrTZjTR48Kq0mrhkWv97nQ78rXoY8wngt9v1T0hcN+SqkTzkk0I4n9eJ1VRLxNJipUnTAhe9BnithZsDBWcv3jVFsOUlys3khPPzOM8iQaTgdo2CY7kqR3CwBgjmqPPYFUgucQz093UEkiDG+Gbf+c9w8a4kfPbCDcDbLrDSw4X4HctD0dIdbvKZEnub2secLHa8Kef8IouEr4OEzbKv6A=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9446.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q3j5V8I+9jQ+V8OohQWTj/hNdGc0s6gMOrbU/dR9nHlol2Q4M5DxioMmxcRIf4k3lCruOXy5OfQtOsYaehYGeKX7biNb8AZiR15TksA3VbNR7ebq4g5iHnw55rr587V2VjfByCBcEeIZYg3QQA5cuLWtAuOm8g/zbB0Frd1OaLfX4RvbkCJ1n5BN5O8MCEoL+myDgoBwuIXDPfukuNw1df5Te8wFRooCO+7msfD7ojfwWIsWy40ZeeiSlxtP3KEpXRgl9cNSegwoHFhpQY1y72ksgnOuoXXLOwDnOhEfDABBatYpdZ3Plij6sr1AI62H2wk6I8zyvtcBEXUPdnLTYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7380
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a388f024-4784-443f-36c4-08de94ab5842
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|14060799003|376014|35042699022|36860700016|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5FOvIv8rNwfKN2OuQHg6R9SJHhsz5/RmyTtAd0gYRQKmV7VIzF8sWCYgtcfMV+nqotESGWSc8dcDoSVWgLUHhGMIftKPSd9fnKZF240A1lPjhbIkSGNTbKefaDxY+ms44Iy5sKweMx4q3AOYRndYumjRomOhgfbLPU3tBv4ePmfRcW+efBUysvBhBW4w3YNGGHvIRZ2cvEPNAJHnvt7uWahS47KrGgLQKPX2A1zMA40xhQR3qXy8XEs3VDAdVqThSS4l85frMAj0sBupBvowZq4utVK1zMfygY2x6ZR33mUlK8A8qbhW5vSnMVmim04PfAIU3+69/IUzrq85BRiN0Uj+zAjBwg21v6ai95rf9aQatFzv4uoX0cgLdAJ5S9Qi2w/lqY33abDE/ib6+Qz4Z2zskxHqHeOM8Gene4LWuGbbNtFsNagzTG7qOVAtJHZ98uBaDs+gCfPlik4uedkBG9cLYwbgdkJMP7+ODgU3ROe1qmjxLhetYMb1vZD6KmvHnv9spQorJcZJKb4Cu6LXEoNOk8vP2OhDXE7Gy1biIDelPXSAts3JuqYIqDiJecHRHhB+YshsmI0D4ONIH3gOh1ih9zu0xg7xRBY9DK76Mzl78Ewj7TbLH2YX1D6rnWV+/ynutCCHtNNrglVSOi/vUnLASED7cL6S7Tt2A+W3nXR9TrKcX0/OLE0DvxRIceDMQT3N9Hk5OlA+J3BOGgB3VzgQtYeAxA31fMvKTypEhwCKzmdUYhkj0C8UN+8od35dY6/0bjJojg1LcjON8Y/sjA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(14060799003)(376014)(35042699022)(36860700016)(13003099007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ihMKKvJn0JErfzBcVjc5QsdP40CLgGLx/Vn3QZ16ehjxat+IJeG7KQCKh+wel4sfz/R0JD1E6DeqaUoAg5aB/jDGPiZxUsCRwab4QAIFf3fGQNu6oJcp6XfaCKfC04wdWq21DkF4x9oem77gpbXZS7rvinrdRKKXnCxRobUL0vCv0//rBNOZtIHLPxurxxZVlHvi42OcxMNsYaExJ683ejaYgMXZ3bJobc8dp5lzYcZtUcaKPJj2yw9hSf+7B7UMUIR9OHouP2wYKaWqR57562T5T9BdOrg1Ozz0gka6EdjRygrC7smImB9u8/hh4Pi2/qvdJ1KZEW38qz+vOPyW3K5W7874Je/WcpssefxyKHhF44gp/xkpA6juN0ISOd/xmUNAPTqqtUgPDkAvn1gnYANFTAsMI4EOIGUgZU17/UhvF9njQUJn4cTWwAqtOihy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:42:28.1296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0deca77-db43-49dc-e453-08de94ab8275
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9264
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

Hi Bruce,

> Unfortunately, I've had to back this patch out again as it has caused err=
ors in the CI over the weekend e.g. [1]. No errors were reported with the p=
atch before I merged it, but I see now that not all tests were successfully=
 run on it. Can you please take a look at the CI errors reported and submit=
 a new version of this patch.

Thanks for reporting the issue!
I didn't realise that some of the intrinsics, such as vzip1q/vzip2q, are on=
ly supported on AArch64. This explains the compilation errors we're seeing =
on AArch32 when cross-building DPDK for the AArch32 unit tests.
I'll address this in the next revision by using vzip intrinsics to ensure c=
ompatibility across both AArch64 and AArch32.

Best Regards,
Jay Wang

-----Original Message-----
From: Bruce Richardson <bruce.richardson@intel.com>=20
Sent: Tuesday, April 7, 2026 11:47 AM
To: Jay Wang <Jay.Wang2@arm.com>
Cc: thomas@monjalon.net; Anatoly Burakov <anatoly.burakov@intel.com>; dev@d=
pdk.org; nd <nd@arm.com>
Subject: Re: [PATCH v2] net/ice: add NEON-optimised Rx/Tx vector paths

On Fri, Apr 03, 2026 at 03:33:35PM +0100, Bruce Richardson wrote:
> On Tue, Mar 24, 2026 at 04:25:24PM +0000, Jay Wang wrote:
> > This patch adds the NEON-optimised Rx and Tx paths to the ice driver.
> >=20
> > Tested on Ampere One platform with Intel E810-C NIC and 100G connection=
.
> > Tested with a single core and testpmd io forwarding mode. Observed=20
> > ~30% performance boost in the above test compared to the default=20
> > scalar path.
> >=20
> > Signed-off-by: Jay Wang <jay.wang2@arm.com>
> > ---
> >  .mailmap                                  |   1 +
> >  drivers/net/intel/ice/ice_ethdev.h        |   3 +
> >  drivers/net/intel/ice/ice_rxtx.c          |  53 +-
> >  drivers/net/intel/ice/ice_rxtx.h          |   6 +
> >  drivers/net/intel/ice/ice_rxtx_vec_neon.c | 761 ++++++++++++++++++++++
> >  drivers/net/intel/ice/meson.build         |   2 +
> >  6 files changed, 824 insertions(+), 2 deletions(-)  create mode=20
> > 100644 drivers/net/intel/ice/ice_rxtx_vec_neon.c
> >=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> Applied to dpdk-next-net-intel
>=20
Unfortunately, I've had to back this patch out again as it has caused error=
s in the CI over the weekend e.g. [1]. No errors were reported with the pat=
ch before I merged it, but I see now that not all tests were successfully r=
un on it. Can you please take a look at the CI errors reported and submit a=
 new version of this patch.

Thanks,
/Bruce


[1] https://lab.dpdk.org/results/dashboard/testruns/logs/1985291/
