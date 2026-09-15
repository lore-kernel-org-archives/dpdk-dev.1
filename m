Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF350C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:41:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F17F040A89;
	Tue, 15 Sep 2026 12:41:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C3F9A40A7A;
 Tue, 15 Sep 2026 12:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789468899; x=1821004899;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gcz94GCBp0ObA9i8AWVAMZLEZ9oUgMJvbdt0ctAOpmI=;
 b=Mpu3E1fFmicbTNianBvdaOts4pYf8AQ55/dyvWk//66D14Q/U/dcwZD/
 MEgN3oe2vembzDI9b+1M8r1vdiWd1bSPRUQ9rqPvZLtgkQDVyeXe2EPZH
 i5cMoovta8SPlwYKXWgrHkQEnyvEtf6hxVHRr9W9UawveNO7uCi80lORa
 /5bnrBMuKkHPE43x169Glzjw1n5i5M91wJ1uZKtL8amjD8Ab9AOjX203m
 31BttTek0y2uosl1tWrLHA6joOCD+Wj8O53TIHcsOKNYG/DidoTrqbtlt
 jJ6//NiLw7kDbGUePZmTPL9dDv0KKfcIu5XE6KbsW/SZzxtY8veuBk8FP Q==;
X-CSE-ConnectionGUID: 2G1ZBweHTeum6A0ewruqtw==
X-CSE-MsgGUID: DpOmkq8lSgS37Bx+cxS8tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89843361"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89843361"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 03:41:38 -0700
X-CSE-ConnectionGUID: aSbOghgoSj+kIT6fqa8ujg==
X-CSE-MsgGUID: SWBassb6RZWyKkqYlVSJKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273502847"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 03:41:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 03:41:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 03:41:37 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 03:41:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K18Et651y7z2kRPo9tdQffW5HudYyBsNnsycgXc8TOSYw8SHcUwdgw1eGMQbS1mvAyrHg4OiYW0CbIxp+2Faei6GWGOlFaReqbbRPxuAZlXzDv2CKXtKIzAjm4ystS7SV3E83O+yC+eMaPlLSRaxOVssUihS1xZboeWSvgd3swFFKeBQLkY/bj4utb/l599JJj5qcKdZeiKJhbrhhY/CkZAKqd9ttNAqvQglFsIV0m7l5WDFmnOrfDy0fbIAKV+dtGTzjO02ipqC1imoqMmX8Cw8918zDXOxXikl1/xk0Kt+/InBFrfv9OqGx3BhqglJKQPVgH8jzcHn8RrZTrv3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgVrtUG4ROJqEHTHmqZgbwv9O2wDxYEECfjdeU6pmL8=;
 b=H9oq6ES57cGgdtjeKEwemr98xRfzm3tI4ezBEfAg6SX4Bxvukd+Y8f+xFeq52nmh7aiCo0agcKT4lfGXJhjRTVaZ1SrnzzKK7LYsCEngwASjJkWbgM5s2s11LheqKXkcQU0z6mH/tfQ3Q6jU9H9fecTxRnWCrIRBkvILmPnnzT9rC5WyjNMZx4LbgNWq/DBBgFV6JAHuFcmLXDSQkwPoiRIiNOxcgizBJccr9DWaITCZu7a9gH11VBU7TKQCupyFCXBwUFSdJfuI2RqSxD/NAdAOZaNpJnVdUUcdcfmTiSrZrQKhGGUx1bf/9xSmdVonQajxRMoy5ww8xD5aoMTFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by SN7PR11MB6897.namprd11.prod.outlook.com
 (2603:10b6:806:2a5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 10:41:32 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::c5c2:2f7b:a506:2cd1]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::c5c2:2f7b:a506:2cd1%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 10:41:32 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/2] net/idpf: fix overflow on store of single-queue
 settings
Thread-Topic: [PATCH 1/2] net/idpf: fix overflow on store of single-queue
 settings
Thread-Index: AQHdRGVUxtRNEQQXmUKZPpIlisfbpLbPdHAA
Date: Tue, 15 Sep 2026 10:41:32 +0000
Message-ID: <DM3PPF291EF9BF15763AC84A0C243D922229DBA2@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <bug-2042-3@https.bugs.dpdk.org/>
 <20260914162234.4058977-1-bruce.richardson@intel.com>
In-Reply-To: <20260914162234.4058977-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|SN7PR11MB6897:EE_
x-ms-office365-filtering-correlation-id: 28d81320-f36d-400d-7e72-08df1315e86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|56012099006|11063799006|10067099003|4143699003|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: sAwYMb5aREVh6mJxHbdg3aImBH69w1u4vmlgH9pWaSZ27OVsoGs5+hvTkUYUKrelMtdrTYtIHS6YAUkx8X2LNd1PxI65rVm5VpWXYueEt4iBudAZlcZliriFOQCZEBoGeGQb7m7GeiPAejeBLWqT/q0cjAlVxVhpkim49xNnfZnLzdCWaMD6PBom4oZBDSBdLnSCassA4wSqz8f08+BiuO5YZ72ZsnbvWcmbS6232xZtONNzf85wxVtKoHhvcd/XvU5XN8a7h7PV6sCCZ+HWdNqmMPApcOCPCxOiT0B7bSeR6hclRhygHD1aeLIRA5lq8meVMVlsiY+JoYRfEpNHuXQkRg8Sdl/lZGcI5qIR9ZdaHTQQOCAoRz/F+qgoUURc67YmdqX+V9qKEAlmM0nTBfrnzFYhiqOOU8kw797dLS920v4fA4woo50HySsJb5T8FeLeuap31I3w+H1skUz93tV94vtlmzMHkYWbTHFTfJ9BTfWZOp9CsV+ae6ZxpaA9XRRqrNPB8GHna27GlOSh9LgSibZs+FgkmNYJlMQUdpiSCujB9ussbwP15oj+YWlYv7AHHPAFd+Jw6TlpZmVsRS2/y4DGKIIEjk3KqG2NbxtwIZYfCwYk4+BNf1Ce7eCijzpJbEvcd+M0GxZ8rLr/8v8l6VQnqdy4GDYcS3E6q9YwYSQhNJmbCnGT6ySBr/rNcD8liMqx+t8vFms6XdePRMHQEkOp9lVZ5vdbdk8Jr/Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?McgyPNhxb3GZlGMvkzDIBo9SZYOWXTp18OdofWAbZTpDwZO/NronNTOdR+I+?=
 =?us-ascii?Q?fuoXhDxBicliICv0ni4yI+jre+2tBBmYGt2WeCpdLiH+2TTzeQBbo73ZTOF/?=
 =?us-ascii?Q?k1oCKfu6KuiG0Gq3owAwcFYIQLYbzxvY7FT8gkWJCl8S19mKj3mfPVvdk6zu?=
 =?us-ascii?Q?LlpyXi7Og/oANXLgtblwbhenQd4WzMIcaqYi/Rkc+Gp3k/mSu0DlCKC8GBSr?=
 =?us-ascii?Q?Wbd0MhdIT+kARFrPmbhraATeKL8LWxnp6wGvzPBmXIFNGWJVc15qBxPLlAAq?=
 =?us-ascii?Q?4xIxOtkn3YV1VOg+lDl1SaFOoMNVrK/3QwK6d7LD+PMgCPxoSiqKVSzvpLdX?=
 =?us-ascii?Q?Jd9fB+NijfqTu8kF7nYgThq/V+SCEgXCW9RfI5JZQ/0v19KgeBKHo8l5fXf3?=
 =?us-ascii?Q?HwpROlIjckiZEs2KGZlirWlMO7npu+6yPDjOSlq/DwOE9+gajHcUSRn6gEam?=
 =?us-ascii?Q?bZkef0GN23R4a4QLFCHW1TMyU0H0sL+sc4c9VmhXgn7WugiJZq1caxMPcR0Y?=
 =?us-ascii?Q?wgtMcqq50V07xIj5Xct6PYW5RbCJyI1wzWUrJDV9H6qHuZZEa+kC7/jSsnB7?=
 =?us-ascii?Q?FIACCCfhFYmdr/P44paFdzEg0wTHCwsAwN1HBunpEjKxJSVcQ2mGWfS/fsoc?=
 =?us-ascii?Q?AuSYoLscoxkZ946aEx7Wkn6Mchqw5yZperfWiTYT/g8hAhafj6FdIT6MrQb+?=
 =?us-ascii?Q?SEiLg6IglDDJh83jrem5I1SvyPvcNiC9H+0BjzzVi2sLPWyM5NJmE7UpDbSj?=
 =?us-ascii?Q?gFTl2hLld8d1pYbnReae6rb5SNdndKdPntFoAPx714DSL0ATTgeztpovyRVZ?=
 =?us-ascii?Q?jZdeI8bBOaT3xx7ys94rvn3VX9vkZnShMYnRVm4dQTSZVmVYBfCYIbQ9FeCP?=
 =?us-ascii?Q?6WWerwxhyTM0UWDhAXpDj0ULr1Rja/BH1bkPDYgn7ubl41N0UmNW67Phyp94?=
 =?us-ascii?Q?uSSVVh6UYzyzYxPrmq2zRO+asIPgTxN+mVYALBDmQmq5llW7ZF2qjsjHrFGh?=
 =?us-ascii?Q?FuFPAo02jrEVJnO2LW8ErNv84qL8UbrhYJ7mIWZAGINvyp1TeosYNBSp8IMZ?=
 =?us-ascii?Q?kAtC9UnR8qzX4QT8Fa7ppKZXn3weuDLBr0TLjw6COm5ha2mhocerxlxN4SNg?=
 =?us-ascii?Q?sVddPdMBW6585wAlbXBurRCXI+UYfvzWT8WAyV8IjupeFXad88VgpbkoAxnM?=
 =?us-ascii?Q?YfKL1q7Yv9XKYRZ3XrMKvyyOVBxoh40WaLVKWdqjPF7HpZfWCeu2IR0uy5d7?=
 =?us-ascii?Q?RzlT2Y0ocfrn8FTGlFvguuiy6Nn33/bq7TVpqOgG9dPHJ9QY0zyMTr4HpJS8?=
 =?us-ascii?Q?WvY7T4gaHbXud1KZUALd5HSIfe+eHYEc/daGdd+j20GBzsRr5MxGR5ucNeHf?=
 =?us-ascii?Q?mDs2BarZNdY6qmw+XxOPUzWdfd6utvMMKz8XqWMAmNIMf65A2HNDqYbA9DWU?=
 =?us-ascii?Q?ePUAwljQBC2afEDaxVH6gbc++jEzKeSYUHfers7cdjONp2Colfb/QhSrN9I0?=
 =?us-ascii?Q?cEzyT0N/v7pwu5lFxxfVw8s/nrN3HyGXYHy4rkcTYWQMazFpA7lpDNLNTIIv?=
 =?us-ascii?Q?Plz0Q/DBATEklLsrdINVqHIXKMfgdWQgB2myxxONjhJikbluZcrE/TplTAxa?=
 =?us-ascii?Q?H4ztqwOAMJa5wgWQN3yN838a4Oeng5UuDLzK5eXY1b+k5vx7QAHTstSwUTpm?=
 =?us-ascii?Q?OCwdNfRNJebRTBT8AX/rI446EpYZYITJC5vDWw7lDcIXjeVqfUss4H2vo9KW?=
 =?us-ascii?Q?/heuvR4+dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CIpAitsFUc8nrxhhGr2yHHa1sApk9XiFo/uuTGsE+NqpDsfMkPGHduifQ6kmkC1N/R2uhow54foDFaCeeTro+gi/gn2Xb0bsns8Zug3AH+CDeQcxTefz69c6CZkuy7g4xIPx2ULWoGBseMC+tnn+lEGgQKkXYWF4LV/wW+AsZbaWu2uI56CDjgNkNAk6d2wUHWvXf7jalB7j28I7nUL/HBypq0aLyUNVzwi2cxfi4tdwNnUHSSOAuSFo+jiw9qnvlFR0GOuhHNRRzaKko5OjnbAlAi9oFw+9JG3eECpfV44Dk6O8KqgE8BDfXUrGEUEgFujpFebmKVEfFmbMzvcP7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d81320-f36d-400d-7e72-08df1315e86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 10:41:32.4500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /i5HlVLFgIJIKSEvKn0Tpp97fX9GSxMmXt7MNFOxQoJjRNuPrwKL8aSvvqLv28ddXlF+oHvjBYu59y7EEFqaOyDHvdWnZWYd62erfm3huJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6897
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

The Rx and Tx single queue settings in idpf driver are both boolean values,=
 but the parse_bool function writes to them as int. This causes an extra 3 =
bytes to be written beyond the variable itself.
Fix by changing store type to bool.

Bugzilla ID: 2042
Fixes: 549343c25db8 ("net/idpf: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> =3D=3D=3D
Note: this fix is superceded by the kvargs numeric args patchset [1].
However, that patchset relies on new kvargs features unlikely to be backpor=
ted, so this standalone fix is useful for backporting or if the whole other=
 set doesn't make the 26.11 release.

[1] https://patches.dpdk.org/project/dpdk/list/?series=3D39247
---
 drivers/net/intel/idpf/idpf_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/=
idpf_ethdev.c
index c13505416a..9fd5b28adb 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1247,7 +1247,7 @@ parse_vport(const char *key, const char *value, void =
*args)  static int  parse_bool(const char *key, const char *value, void *ar=
gs)  {
-	int *i =3D args;
+	bool *i =3D args;
 	char *end;
 	int num;
=20
@@ -1261,7 +1261,7 @@ parse_bool(const char *key, const char *value, void *=
args)
 		return -EINVAL;
 	}
=20
-	*i =3D num;
+	*i =3D (num =3D=3D 1);
 	return 0;
 }
=20
--

Looks good to me,
Acked-by: Praveen Shetty <praveen.shetty@intel.com>

2.53.0

