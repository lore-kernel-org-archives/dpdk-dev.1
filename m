Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286DCCA476
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 07:47:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EB66402A3;
	Tue,  7 Oct 2025 09:47:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 900ED4027F;
 Tue,  7 Oct 2025 09:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759823252; x=1791359252;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TdoT06mbDmu5s0NrfkEYzE/Bc8W30ujYgqzZ37MLtEs=;
 b=D/OuwhzoOpt2H0FYtKT8SPCbcAC1Pl++thFFEIOqfu4JZrTOo7+Fjjh+
 HWD8M1YB9xERXE4OIiQGNDmT/jNcc5LrWkCchwInhy3MFSRtE1PtR/PgW
 cBGsdUuOMRgD4SvMvrZVgfABQk/41o5wBGlElbXGomcUBjv8HcZw4L+Nk
 dJ2cTsmsgryljXfR2KwIAf9CeqrrQE8/3kVFAm0UG3vg0+d1hoetus7HK
 qyjnkaVMR/81dTz+6d8I9T7mOkHHUojLSqnrlomvfQ9aO1CHI7vrNJx77
 TlAAumM3eyziqRF9Q/KnSHt+bU7DM2lDCRrOrcAxZrlWucaLm+TuAG4/Y g==;
X-CSE-ConnectionGUID: /RtFSBKuQ4+1g5FG70I/1A==
X-CSE-MsgGUID: foYK2gUhSFWLxYancQXRpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61709988"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="61709988"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 00:47:30 -0700
X-CSE-ConnectionGUID: uNk850oPRrSav0COkOxlHQ==
X-CSE-MsgGUID: xim49SFQQtCq4gO3UdZWYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="180884957"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 00:47:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 00:47:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 00:47:29 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 00:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXN/P/4xzOFugjKyIfolblDp5QTpoX6+oi4TAmnV7Nh5q57TJjiTl+OQCdk0a2Y2wTwSPvBslRPjCk/mhLS0ku6Y64gsLKT1OeeBOKo06DE4aRto4DNtJR4uyIHYiN2GJL8/QhUpLBZOAY4axPPXt6DAk1v/kEcTVAe8clsVGhSCX5poiseep9MKsWmNJuAvJrlVIdsXm1SsCiofGwB9DJ8wJYWDQrkcAb5AKOfMbKr9XYvEoJ7R1FAMuvLzUImLRJzN+va7wKeO6nQ+RSGUaoUsYZdii159kHbaZdPSK7C4iscxXaCn0CbMqhZgzn+4b58++ZQFK7rNATVh6a+/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVMmgyaCLgpRe/xw177qO4QHE9yQUE29wHAts1lc6TE=;
 b=OcAejNQx7nqy3FSxp77njFgGUP7SpZMco8yFgqvpmwRcgC0dYaF5nSxj9ieKh64CbCbHq2RPqkapKdq5o9Fp8IqccWQ8bsO0C8K4hfIv4ykx9H4mOgQAwLx4gA4p4MAz8AMdn3WihotFklz8dYdpW2epHjt/+J8U15V+FnNudSsVabJ3E79lJIT1evDGiFKBRAfxM1ZF4zJKIis00q0KLljmMKSuOt6OE10U2qXjnI2qvx+7yFOUrH4yMfFUTbq3CgJ7ceYvtufGDgqxVl+HYKXe6G0qNDQAULP/XUCKh7erCgXSNFLgurzC1x27I08hXBR39SuSDZUCDqMe0lw8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by PH0PR11MB5904.namprd11.prod.outlook.com
 (2603:10b6:510:14e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 07:47:23 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d%4]) with mapi id 15.20.9137.017; Tue, 7 Oct 2025
 07:47:23 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Zhang, Qi Z" <qi.z.zhang@intel.com>, 
 Yuying Zhang <yuying.zhang@intel.com>
Subject: RE: [PATCH] net/cpfl: fix display of commands in the docs
Thread-Topic: [PATCH] net/cpfl: fix display of commands in the docs
Thread-Index: AQHcNHZF0dDm95Xfd0+2C77smUoutrS2U7MQ
Date: Tue, 7 Oct 2025 07:47:23 +0000
Message-ID: <DM3PPF291EF9BF1FE2D5C76005FEDDCDA199DE0A@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <20251003145848.1675691-1-bruce.richardson@intel.com>
In-Reply-To: <20251003145848.1675691-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|PH0PR11MB5904:EE_
x-ms-office365-filtering-correlation-id: 295d0ace-1b21-4f68-b0a3-08de0575c0c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?57x0fQb+yoHTUgERdDUT5tZSawVCNTEDfcP+Bm2KD6djo/fDtEBbbmzJ2NH/?=
 =?us-ascii?Q?cBxGkLPj2NyL3NJA6gZFj/wzieGffkqAoFwbqVkkKXNLsFaJuY0M2x8y9lqE?=
 =?us-ascii?Q?PGodcbZFag40T0k4wFU4yOfOORU2OZTgUkJmd9dgET1ozJ3ueDip5ZvkWj8+?=
 =?us-ascii?Q?97+FDa9H+eBAz+LuJd1q7x9qjlL63q/xDSE2C1+D7Xj2tBc7m7qq1sigdSsA?=
 =?us-ascii?Q?88HltHNmNESwAHqvhUSjPuhKbixOkWwYvwt/RtDV2qLdWr0oOm5CZyZC5JYq?=
 =?us-ascii?Q?zyAUczTLhozEQpVj7Jg7nRiiwn+2iEzDMxnhUJ+UelA1CYL76NTP7/MiQKCD?=
 =?us-ascii?Q?m56BZnZeoZD0lYH2yB5Mxa6hVBNbl2U1szw+vdJ9nz4dJ5gCF0lrgAoXCjjY?=
 =?us-ascii?Q?bVWqoSs0rAqSq1gFy6ngb+8wA3C5YfqEpbcZZsZ7DUxElG49tRmrjBVryNtE?=
 =?us-ascii?Q?DKTa5mUswUDucw6fzp6fn2iBSkf2H+QEXoSM74wq+sGObVJa3Q6LcGujNqmJ?=
 =?us-ascii?Q?9oiPgMonKQSmg3NUX/gfJDjBOhzbyIfgP8yqGDUTfYXnSTND810WYI3pKnz1?=
 =?us-ascii?Q?V87qr9xJTKmv6TRISfxXRvyXULh6I58zjxx0lP11XDqD1TMzfbfN3YAJLM69?=
 =?us-ascii?Q?iddOdR1GWekiN6gSFflLSGjFzJGhS2ekrgdloN9o3yAG+2ErbOhvGc/kEsih?=
 =?us-ascii?Q?ectzrcO9E9YcmSCKX1YDLk0iDu8SA+j+yhEM8Fb4O/NuS8KANwS26X/+07v7?=
 =?us-ascii?Q?NhRhC+eTcsxUV2IBJ7sNCOmrWBqQEsXKj72mO3DfBQ0MoIRL2ZPZM9ILEDoT?=
 =?us-ascii?Q?lJM45IKfPUjhAaRhiL9Z7th3q5ftqVuv+B872l8KHrgK+LRiKBvE+khwfQdz?=
 =?us-ascii?Q?64MNpXBnefhYKbCtCEsfBKUpV3Nq7wTNvwwBg0xS8R/H/MYNpVhg80c59SOl?=
 =?us-ascii?Q?/JizQXkdmz1mswEKG5/Wq1406enNWXtx/0genXZ3PPM73rBmNVZY9plu5a+K?=
 =?us-ascii?Q?f827e6/iV8wEAIh9GBeDu/efx0CudZsimuohdvNX891FF+EeVn8iFLx1JQSD?=
 =?us-ascii?Q?e6+UNwruSSR3DR8cLbU4yAsami1qbHFT/blSaoJZ0cN4y4O18/GMGKc5Bdm5?=
 =?us-ascii?Q?mHRrVSDAgSIiKwFNHLo4iWj/a/0+VnUPlsHv5h9V8TXi8f0kMwxiBYp/iaAI?=
 =?us-ascii?Q?M7scPtCqox4RoTObzGICiEpr1TgXKp4YbX4VmeBkuxc2bkAyHCX7nVMuAvkT?=
 =?us-ascii?Q?OwTqTTnksFp1NId9OXdwvM3WEdmZmWuuNj30uzkv9X+a86xM75k2d3TcgDuV?=
 =?us-ascii?Q?lIUvjDBRdvxYVVY1sY52BONOOJHIA8vFjUbl83kxUayw/wfMn9bSAtDttvTu?=
 =?us-ascii?Q?B327N1Mp0T7TDu49Y9BgqnsqlyJMtlMNC/fqdhc/EN3sKrZfOXij2tj6FKuT?=
 =?us-ascii?Q?nWVEkiNm3o0FChrHAGTRZ0JlZ7OAku4+kKeWVUa+qQcEO4g0iTfEVF1/IuKv?=
 =?us-ascii?Q?3TZ9w8HK77WjoTOZlb/96N8s9lrrhXCbHQNr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o8CjgVGr1pNBIRTcqjiV9VNCk34KTGlY7aXhs2tmhszGIzaS2jE0qknDAW8g?=
 =?us-ascii?Q?qrs5a4FDPqVhB/7vH2vN7k9z6fghgJcBugiKqqPYaoESl0UE/kqsAWn5KxqU?=
 =?us-ascii?Q?rnaVHBGGvCohnvOhuw+N4KFgHfTQEt6u5HkzckG7pYLF2LUaBLiep8ijbHrE?=
 =?us-ascii?Q?NINJ56IZJ2+qnGOuVA3Yxa/MLrhFgoJnYn+bfjMLMJl61WMi1vQV9yu4VAR5?=
 =?us-ascii?Q?eyIxpqra1eLxzXGBmATcX3TfJvUEUzPKhb4PR5t6758ZIZubKnmav3DGIF7U?=
 =?us-ascii?Q?QEis/jg2jP1GFfVoK2z4QiCvdwJAo0M8+Cnu4TmdKFu8M6D0e3R2zPUW0iCO?=
 =?us-ascii?Q?BkJbqy/o9qs/j64/Jd4+S6I2R9OGBUb+c/Sc0C6m9LxuQwRQkVxzgv1ZDYi+?=
 =?us-ascii?Q?N9iAA30H3+CQxlRUL6qrmcmXpEpaoO9gvk1Dmq1CwBaob4ZPkNgnwNpkB406?=
 =?us-ascii?Q?PitVNCTkyJ25ayXxlCtcJ0VN3c+L2uFThO5MLcJcEyaurDE/F0AFkjXHi8NZ?=
 =?us-ascii?Q?G4jfhwm5qSHskzTvQXmCA8Pgtu0tNCBmCs9uuU1V1q7JCJm+GZ1zKkgz4Qr3?=
 =?us-ascii?Q?HVgWTSv+9rXBkyWGI/qviLtsDQC1kHnnvYA+U2Lz7DVqKdNsyR25AGNavFUA?=
 =?us-ascii?Q?TD+MOpZ3KQFJIaB5j/ivjjKCVgiqTuFV8Dg8HE/2RDmC6eWqQx/jF4igsTFq?=
 =?us-ascii?Q?bQyRC32ymDdkuAHN2o5ojJrE4Qe3YwVpWtA/ywyO9I9FspjlCG3k+fgu48YA?=
 =?us-ascii?Q?Dq+jockGA7gzuyqicubwkpsWMnIfFjZJBLkOaAHR+UtHuXCJ9y8efOeDcEdJ?=
 =?us-ascii?Q?vgfMet65y73xgjejb2Ib0eB9xrjfbtY+Pas4Ilf+buKs1WV98/p9SjqFyNC0?=
 =?us-ascii?Q?kuo2+dAweZS5ML064wFqPFhJHh5r61S80UdGGy/oTUePRE2X+9iEira2UN+8?=
 =?us-ascii?Q?UHpcmyxiobyvNPDf9Y2fBQV4uY51jJ/PHbMzkKUz++vimZG1i04r3KFH2MEX?=
 =?us-ascii?Q?XzZlOcItLUvvSwrVjeOTCmtt+9txGQQAxbtWosP7Pj43NnPxc2czJ8ILpnc1?=
 =?us-ascii?Q?rFQ12bMh0nf2RB+pB7lmrgsNAsmmeHFgEC63T8VCDWVXKqRdP7EpnuklWOUj?=
 =?us-ascii?Q?qCqWZazWg9rl38VF1Wlrfykh5RlxjejSf5TKF5CItBjGhXchBWFFxwM1MqDk?=
 =?us-ascii?Q?VwboVsbGk2EKf336SXrENXPFBIUXHy5KQ9uqPscPp4Ea7caVCAIWqyeyzdBa?=
 =?us-ascii?Q?BO3W7SVMRV2m8vW2XJPQhFO+qlFF2kI7eozu8kALpL3EGb8fhCLsoKM5H9Am?=
 =?us-ascii?Q?Uii5GGb5NNUcMBvmg60G8KYDTiBuYHLCWMrBpF5hJgjq0dVcZnNwLYmPrU8f?=
 =?us-ascii?Q?61ld1T5k3eLnEU3h8I3mO/2zyZvKc6pyoeLnivwrflRQ1oIXq+j2HYUygqXZ?=
 =?us-ascii?Q?tSj+Q/Pf8Bk+5+Fn62SlQ7x5p0dGhLCGAfvVN3lh56j5Lcu9ZmeoHM1aTPCn?=
 =?us-ascii?Q?OhfYKrOtOMQxFsKQq96AeYADTQaeKvLeTnY58JePVsTYHQFJKeAKU1iri1d6?=
 =?us-ascii?Q?X9FeyUcM6imUm5jApwhoG/KAHOuaE0EOuk9rk5fN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295d0ace-1b21-4f68-b0a3-08de0575c0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 07:47:23.6462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+vodAFCWqfxYzb75GY7isMAs5FexOzBLBvT7MwnsUFk/MqmKeyM7oBY4psCM0FGxv5jihhvna2FfGlOa7HYm2HS7UFP+cGNH2lk/9vXf40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
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

The literal text of the commands to use were not displayed properly because=
 of a double ":" at the end of the preceding text, meaning that the ".. cod=
e-block" marker got recognised as the literal text to include. Change the d=
ouble colon to single, and also indent the line continuation in the multi-l=
ine flow-create command.

Fixes: 03f976012304 ("net/cpfl: adapt FXP to flow engine")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/cpfl.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst index 54a3=
015aa0..bc42c524ea 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -218,14 +218,14 @@ low level hardware resources.
       dpdk-testpmd -l 0,1 -a 0000:af:00.6,vport=3D[0-1],flow_parser=3D"ref=
pkg.json" -- -i
=20
 #. Create one flow to forward ETH-IPV4-TCP from I/O port to a local(CPF's)=
 vport. Flow should be created on
-   vport X. Group M should match fxp module. Action port_representor Y mea=
ns forward packet to local vport Y::
+   vport X. Group M should match fxp module. Action port_representor Y mea=
ns forward packet to local vport Y:
=20
    .. code-block:: console
=20
       flow create X ingress group M pattern eth dst is 00:01:00:00:03:14 /=
 ipv4 src is 192.168.0.1 \
-      dst is 192.168.0.2 / tcp / end actions port_representor port_id Y / =
end
+         dst is 192.168.0.2 / tcp / end actions port_representor=20
+ port_id Y / end
=20
-#. Send a matched packet, and it should be displayed on PMD::
+#. Send a matched packet, and it should be displayed on PMD:
=20
    .. code-block:: console

Looks good to me - thanks Bruce!=20
Acked-by: Praveen Shetty <praveen.shetty@intel.com>=20

--
2.48.1

