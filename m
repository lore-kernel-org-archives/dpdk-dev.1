Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F21CA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 15:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5E0C40274;
	Fri,  9 Oct 2026 17:40:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7D9BA4026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 17:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791560403; x=1823096403;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=ANSnCwDx1tw7xds9/0hdmJBsyeNUv1Bcvf8Kjm3IVDM=;
 b=UdVBiUGizRiHgqY6QyTI2H9PgjsMeCSg8/w/pQCGb8Uy25Dx43VYLWqE
 dY+zgp3+cwF65F7wY9guy0u8v4P91bopSyS5xShn5vAjqdb/dfJnOO9IW
 srzNcueT72RlroFNjkjpORTVcKV5jvhM3X50+fck9/0oslL64Zx4uAibv
 G7mkYb0TrxHCFMDqEdr901zTjMPP3v3QvkkLP6C+/4nrsz1HR557KYDGs
 oV31Y2dg3WfJA6ZeyslAFtJjF1taKUaKHqEX3oFUSun983gzMvP0y50hM
 uz+Goj/tobjcs1SmofbOV1DIQMLpzhZMERVdY202R4EC+I14twZEizIt1 Q==;
X-CSE-ConnectionGUID: Ul+rdhRGSsG2TwI6HoTzRQ==
X-CSE-MsgGUID: J/WKK1hlRpCqM1HLOPr3iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="247786"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; d="scan'208,217";a="247786"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 08:40:02 -0700
X-CSE-ConnectionGUID: EsvR5voMSCKBe7TF6Y9pnQ==
X-CSE-MsgGUID: QyonZwMZTVGTWtSmGxSUrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; d="scan'208,217";a="522688"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 08:40:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 08:40:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 08:40:02 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 08:40:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hM5TPc7Vo8TtfyW80gmptYQIJWWNYkSOcxufRwJtadFQCITiYZgVV4Ilqi6Mx1q4uP5AyfkOc5O8OHwBEthEVAC/xadURETJgV1+xyZElCFiZGm5ZKY5lXrtjaLcFp3gFd/+q6CZ7XGJCDcaegVuwO9t1eCSm+SO06WrnLI7XJvvMpRqBWgyNV/Fej+BRpNGNcuAK1lVtvG45wdLOLxupdnTIFRSTiAu3TRsteL66mjn8y9rrSzbRSOVaT8BUsgYe6jR1vDInKmwv8twfIFHHmC7NA3U4VfRRwgMbzDjNQ5vEzsdAE/czkkSNRlACXz3B6SPwbV94z1e6W85UKL3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd5SDrY16rU3wA96JtqGk0WPhAzYn+J3gQbHu/vyezE=;
 b=ke7VzwOeeYFhMEUwe/9KF3vAGo8G5TtWzQ50fIAC4sRT6ga9IK5B7knFW+IW1fiewXeJgCqn05wLBx6IK3XJGKgqVlzDc7UBfVAKMSVTVgIHpZfN1lExR52bVvynommPVnBwNeWqaMzc6Fi7BQDcC4NgqTzJ1ghDYEhXuu9ZONByq4omCgpM2KjU+GStSi4KkZ0A2nt55TY2eNUddiKcKBuKxEbd2rFLqn9iG4EBJY+n+miW0BQA95xoLidVe5Z2SavcZfDTjKPQxYMQN7D+zmL3rV2BqLYd7KSzu0sLxHykQz2oX0A433jykaqsyL3eqNM+tsv6GwkyEdTw6zANTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by LVUPR11MB9810.namprd11.prod.outlook.com (2603:10b6:408:39d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:40:00 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:40:00 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Pratik Senapati <psenapati@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from
 capability list
Thread-Topic: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from
 capability list
Thread-Index: AQHdV+D33rDuqD9F1kOHV+JXOBdZjLb1WK8L
Date: Fri, 9 Oct 2026 15:39:59 +0000
Message-ID: <LV2PR11MB604545E17B9928A3A4758C2A81922@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261009112543.1766727-1-psenapati@marvell.com>
 <20261009112543.1766727-2-psenapati@marvell.com>
In-Reply-To: <20261009112543.1766727-2-psenapati@marvell.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|LVUPR11MB9810:EE_
x-ms-office365-filtering-correlation-id: 3a9ad688-b71b-4924-538a-08df261b940c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|42112799006|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003|8096899003;
x-microsoft-antispam-message-info: AdZqKgbg7d/eM1vYs6WKSHzVpBd9tEVSeEAe4FMr2S7e7DuZQ0K8mykte3oloMC/faiUfh2JZJcjq/KAQmAHrr1bmkBQyqqItpfb6Bgm7EHWzQkmz4crcR74BbHQoWkuI4eYcv9/SmWbpNvCjbMDJGXcMPPS7WsDERQdj1rjPiwMBxXvqoj3IEZoTMp7wmViGpC4WCkWLbzR7nd3hDjUr8JImHH8qtrKF5/hXclKF78uRAIbN4AUJ/J4Ld2KfHsn6XTYRd5c0K7reOxLFhJNN258hQV1C0qEfD8XhDYdX3EfM80DR/182oeUJob29NvgdYpGKcAboyEBkcQK3HJD2BM9kQsgq34nFUh/XDZWw9v9Fl52MUmHTP2ym4yI3dddzvoFYglut2/OwBfzFF7w0dN5ZYMyQ6PNmmu9IVkMdI1M0eay9P7h4tl0L2Ix4EDul+mG3S7zxiqmtp6eLdf3nlM+rebDoV4C72zqHPXXDABRRTDpxpUdYhq0rkNX1a1jHf5ItJJPV+fpcMzf7oJbrfafqsFmhnMTTibzGkstpsCYI8rK7CEN6jmn64LwLXXwBWak5MNygazddPGTYT/hcb5bJLkjXYUTdlp0fUjTWeN+oFPvhM+A8bs2cqVFcGEqhfYrlVvtM+XxntuECkJayme+dykHsKQPuLA5/ILZaCXCTS+3HwKcaOLjgYIANL5ThKafx9BoVI4VtWoyDCL80sa7cXd59BK3V7RjPO+DxAA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(42112799006)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xk54w87wgjpzTU/h7nKvq35pFOfKl6oog545VIvAMQxZ/Yu9XC7yMs/2MO?=
 =?iso-8859-1?Q?Zs2QMQxmE06srqt21BmnM0H2pauNJeyosGt9ll9VnOLgP36ESM57U0zi6J?=
 =?iso-8859-1?Q?ZyWukcwj3nNo2jCT4VyfzryKCk/iKO18UCKuY4QBrOtMgLl3FgHkbpRgp5?=
 =?iso-8859-1?Q?zYFrOGVQ2v2/yi6ZgyTsMRuoJGhbxkN65iKgdCXX59gEHVqy8q4amFfode?=
 =?iso-8859-1?Q?ewuswKFvKb3JfgtYfKRfHvsx4CajxSyAvnCNOsOpanztMY1OBleabQ35nH?=
 =?iso-8859-1?Q?3lfTGGdCZlSQ1XrCC/8riiVWXAW1Mr1/M7xvXaYO3MLAWIlNHf9LYMM/D4?=
 =?iso-8859-1?Q?CCso7aYGEiILpUA28QBzG/hYVkv3IMyjM0/T+2EUK47LeGDzmD5JZqaHqg?=
 =?iso-8859-1?Q?qbg5j+sf+wFrgeBpCM+hC2EaIK3W6p5DJbR6vMSfqz/7u9ycd95vWUPu/a?=
 =?iso-8859-1?Q?F3l5ktPWASNk9T2Dm+54DbOEloTOdcYu4kvfAmaW2IVw+3TJ7XTKFbSlMk?=
 =?iso-8859-1?Q?AWSvGx1vE1kn/+EKzHIhwzNgNFZqTNiYlEMjIzQd6yLU0pDBSAvx7kp4Of?=
 =?iso-8859-1?Q?gQokNJwHYxVWCGZHmk8UG14EGhFftSObkoiYaO2x78C+qPwtGpKMhRwElv?=
 =?iso-8859-1?Q?1bf5zN/J713dlOj+JVhuc0qaLNDnRqIweFOCroaubzuYgfwmeb5AZmbeVz?=
 =?iso-8859-1?Q?47LdKfSxBIQdET3bk6ePUOOjhMQVbKZDhR5bkJgCAGtgusQbrZzf56nouC?=
 =?iso-8859-1?Q?BprcmqKfn5ihYXjtOCm5u5MjyDmxxupYSiDhgfFSo8BkjR34x0oxcVmW59?=
 =?iso-8859-1?Q?B3DAa6UOxc3I0mMmpyZq0ofKizTqO6pWI8SwG9cAfwuAeKL9TvXUkp6ipm?=
 =?iso-8859-1?Q?MoIYxL9awVDmwCAgGtPDTbs9KDIqFcAy58E2TipLGaR7yhNtcRAW3seZVq?=
 =?iso-8859-1?Q?NWldFjz0M/exHOckzcTmRtgdYvdcXQBcsTs65fLBoP6ZGVPUNyycADdLfO?=
 =?iso-8859-1?Q?QkS4oyVoBYbboETNG3KQzJwMaeeofBVKBwhxKw6F29bzearsSNoDPnpz3d?=
 =?iso-8859-1?Q?aFxfwnnIjWVU5xYFPu0h6dIonMQ1qtlcyeBUGP0zwwQKmiL1ZNhWgjfVIq?=
 =?iso-8859-1?Q?NVKdHMvP5iMLdj9UFaGqrNgGIlQlLUYN//T/gTutYVSMX/lytLrLK8pMmS?=
 =?iso-8859-1?Q?/2AoZ60f8RGtcmt8yQupE2y5M7tyYvzLDa09eshmIgOKVJiGhsOPNK5RpL?=
 =?iso-8859-1?Q?ATDkM4X/2MyMmiklcN086Sjk3iUDPKVMaDmRa10TrC65FTij+ltbTaWf8s?=
 =?iso-8859-1?Q?T7UJL/x5L0zW/fR4qQTky5thSHBzllFgdNFSSd/TugEerNL3/4f2V0tboj?=
 =?iso-8859-1?Q?5VQIKCWc6L6chEzzsVaO/VTUko7rPjRbJXhkcYnSrftj7gh8jzkYjIsRET?=
 =?iso-8859-1?Q?4rEv/H12dQbepuMs1xR5Oqch3ztQqR++MDlpjbufY+386rR6rKMO+P7hwv?=
 =?iso-8859-1?Q?frtDnaXcJP8na3oc7InEjDuE559VsfVnaWAII9UStvctN+OHwDeGAoRQaA?=
 =?iso-8859-1?Q?m/yhVv4MU9i0jaUuqP8bUj8sEpnAhaIRa3g9L2udXizqXcNWX0Xj0QZ8Y/?=
 =?iso-8859-1?Q?SGdrT1RYei4KMt5Icaxci6LjvEqyLdMKOZxxGRlC0WHeS/UQFNsw7hB9zX?=
 =?iso-8859-1?Q?nCGvG0pzryMR8h5nqc16p9jorgQwyK5G/151rYtXZTqBnZR8Ou+Ecm+ntx?=
 =?iso-8859-1?Q?u0UReqf36J+QNad/xi37zBDfcvPAU7ACoO12hKKELavJ0L?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB604545E17B9928A3A4758C2A81922LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KeJfsTGyPq9zx6g+WJ9Xa04OiaBkvc9SFy1luhZ3k5ZUWDe3VOOeu8vbJKH+LAEYSLsDmDphpTm9N/rZHkSpgitI4488dYJS1fUROO8xS2m82+FbEK80UqgGs2i1w0GUhpipaoFUm15yhfhG1Oop44oejcuMHWTTBdxh1/teo2zC/g84200jaRukSjDlJ1+AzXYPeOt0p0zGP/oStd5C29qBm9x+yGSnp86tJ24aGxSHtC7r81qH4Kbj0wtA8e7moygv9MlAXlMD0kEuEwtoQG1EwgnyEkBC4syTVlVE9Qz5prKiICOCj7AFMM2aLceILU2dmYVOXoKRCDkGPZTUeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9ad688-b71b-4924-538a-08df261b940c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 15:39:59.9660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwm7HUnQc0VagE11PhavwWJdem0EeltUVjGZzrtUMDlSxpq67zKJm3Q0WEGPXPxTjZLGnq4ryIkw/qVdN38qEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9810
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

--_000_LV2PR11MB604545E17B9928A3A4758C2A81922LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Pratik Senapati <psenapati@marvell.com>
Sent: Friday, October 09, 2026 12:25
To: dev@dpdk.org <dev@dpdk.org>
Cc: Ji, Kai <kai.ji@intel.com>
Subject: [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from capabili=
ty list

When the legacy provider is unavailable, DES ciphers were still
reported as supported, causing runtime failures when applications
attempted to use them.

Add openssl_pmd_caps_init() to build a filtered capability list at
device init, excluding DES-CBC and DES-DOCSISBPI based on legacy
provider availability. Add a warning when DES algorithms are
unavailable.

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
 drivers/crypto/openssl/openssl_pmd_private.h |  2 ++
 drivers/crypto/openssl/rte_openssl_pmd.c     |  3 +-
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 29 +++++++++++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/=
openssl/openssl_pmd_private.h
index ab40012d61..71d78459ee 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -21,6 +21,8 @@

 /** OPENSSL PMD LOGTYPE DRIVER */
 extern int openssl_logtype_driver;
+/** Initialize filtered capability list based on legacy provider availabil=
ity */
+extern void openssl_pmd_caps_init(void);
 #define RTE_LOGTYPE_OPENSSL_DRIVER openssl_logtype_driver
 #define OPENSSL_LOG(level, ...)  \
         RTE_LOG_LINE_PREFIX(level, OPENSSL_DRIVER, "%s() line %u: ", \
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c
index 2319c7cfa9..275078050a 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -37,7 +37,7 @@ static void ossl_legacy_provider_load(void)
         /* Load Multiple providers into the default (NULL) library context=
 */
         legacy =3D OSSL_PROVIDER_load(NULL, "legacy");
         if (legacy =3D=3D NULL) {
-               OPENSSL_LOG(ERR, "Failed to load Legacy provider");
+               OPENSSL_LOG(WARNING, "Failed to load Legacy provider");
                 return;
         }

@@ -3941,6 +3941,7 @@ cryptodev_openssl_create(const char *name,
          * unless the legacy provider explicitly loaded. e.g. DES
          */
         ossl_legacy_provider_load();
+       openssl_pmd_caps_init();

         return 0;

diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/=
openssl/rte_openssl_pmd_ops.c
index d927cc5228..3dc1ee11a2 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -929,6 +929,7 @@ static const struct rte_cryptodev_capabilities openssl_=
pmd_capabilities[] =3D {
         RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };

+static struct rte_cryptodev_capabilities openssl_pmd_caps_active[RTE_DIM(o=
penssl_pmd_capabilities)];
 const char *ml_kem_type_names[] =3D {
         NULL,
         "ML-KEM-512",
@@ -943,6 +944,29 @@ const char *ml_dsa_type_names[] =3D {
         "ML-DSA-87",
 };

+/** Initialize active capability list, filtering unsupported entries. */
+void
+openssl_pmd_caps_init(void)
+{
+       uint32_t i, j =3D 0;
+
+       for (i =3D 0; openssl_pmd_capabilities[i].op !=3D RTE_CRYPTO_OP_TYP=
E_UNDEFINED; i++) {
+               const struct rte_cryptodev_capabilities *cap =3D &openssl_p=
md_capabilities[i];
+
+               if (cap->op =3D=3D RTE_CRYPTO_OP_TYPE_SYMMETRIC &&
+                               cap->sym.xform_type =3D=3D RTE_CRYPTO_SYM_X=
FORM_CIPHER &&
+                               (cap->sym.cipher.algo =3D=3D RTE_CRYPTO_CIP=
HER_DES_CBC ||
+                                cap->sym.cipher.algo =3D=3D RTE_CRYPTO_CIP=
HER_DES_DOCSISBPI)) {
+                       EVP_CIPHER *des_cbc =3D EVP_CIPHER_fetch(NULL, "DES=
-CBC", "provider=3Dlegacy");
+                       if (des_cbc =3D=3D NULL)
+                               continue;
+                       EVP_CIPHER_free(des_cbc);
+               }
+               openssl_pmd_caps_active[j++] =3D *cap;
+       }
+       openssl_pmd_caps_active[j] =3D openssl_pmd_capabilities[i];
+}
+
 /** Configure device */
 static int
 openssl_pmd_config(__rte_unused struct rte_cryptodev *dev,
@@ -1014,7 +1038,10 @@ openssl_pmd_info_get(struct rte_cryptodev *dev,
         if (dev_info !=3D NULL) {
                 dev_info->driver_id =3D dev->driver_id;
                 dev_info->feature_flags =3D dev->feature_flags;
-               dev_info->capabilities =3D openssl_pmd_capabilities;
+               if (openssl_pmd_caps_active[0].op =3D=3D RTE_CRYPTO_OP_TYPE=
_UNDEFINED)
+                       dev_info->capabilities =3D openssl_pmd_capabilities=
;

It seems  fallback also advertises DES even when DES is unavailable, which =
defeats the filtering during that window. Would it be better fix to initial=
ize the filtered list before the device can be queried; then this fallback =
should not be needed.

+               else
+                       dev_info->capabilities =3D openssl_pmd_caps_active;
                 dev_info->max_nb_queue_pairs =3D internals->max_nb_qpairs;
                 /* No limit of number of sessions */
                 dev_info->sym.max_nb_sessions =3D 0;
--
2.43.0


--_000_LV2PR11MB604545E17B9928A3A4758C2A81922LV2PR11MB6045namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Pratik Senapati &lt;psenapati@marvell.com&gt;<br>
<b>Sent:</b> Friday, October 09, 2026 12:25<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Subject:</b> [PATCH v1 1/1] crypto/openssl: filter legacy ciphers from c=
apability list
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">When the legacy provider is unavailable, DE=
S ciphers were still<br>
reported as supported, causing runtime failures when applications<br>
attempted to use them.<br>
<br>
Add openssl_pmd_caps_init() to build a filtered capability list at<br>
device init, excluding DES-CBC and DES-DOCSISBPI based on legacy<br>
provider availability. Add a warning when DES algorithms are<br>
unavailable.<br>
<br>
Signed-off-by: Pratik Senapati &lt;psenapati@marvell.com&gt;<br>
---<br>
&nbsp;drivers/crypto/openssl/openssl_pmd_private.h |&nbsp; 2 ++<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd.c&nbsp;&nbsp;&nbsp;&nbsp; |&nb=
sp; 3 +-<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd_ops.c | 29 +++++++++++++++++++=
-<br>
&nbsp;3 files changed, 32 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/=
openssl/openssl_pmd_private.h<br>
index ab40012d61..71d78459ee 100644<br>
--- a/drivers/crypto/openssl/openssl_pmd_private.h<br>
+++ b/drivers/crypto/openssl/openssl_pmd_private.h<br>
@@ -21,6 +21,8 @@<br>
&nbsp;<br>
&nbsp;/** OPENSSL PMD LOGTYPE DRIVER */<br>
&nbsp;extern int openssl_logtype_driver;<br>
+/** Initialize filtered capability list based on legacy provider availabil=
ity */<br>
+extern void openssl_pmd_caps_init(void);<br>
&nbsp;#define RTE_LOGTYPE_OPENSSL_DRIVER openssl_logtype_driver<br>
&nbsp;#define OPENSSL_LOG(level, ...)&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_LOG_LINE_PREFIX(level,=
 OPENSSL_DRIVER, &quot;%s() line %u: &quot;, \<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c<br>
index 2319c7cfa9..275078050a 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c<br>
@@ -37,7 +37,7 @@ static void ossl_legacy_provider_load(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Load Multiple providers=
 into the default (NULL) library context */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; legacy =3D OSSL_PROVIDER_l=
oad(NULL, &quot;legacy&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (legacy =3D=3D NULL) {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; OPENSSL_LOG(ERR, &quot;Failed to load Legacy provider&quot;);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; OPENSSL_LOG(WARNING, &quot;Failed to load Legacy provider&quot;)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -3941,6 +3941,7 @@ cryptodev_openssl_create(const char *name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * unless the legacy =
provider explicitly loaded. e.g. DES<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ossl_legacy_provider_load(=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openssl_pmd_caps_init();<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/=
openssl/rte_openssl_pmd_ops.c<br>
index d927cc5228..3dc1ee11a2 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c<br>
@@ -929,6 +929,7 @@ static const struct rte_cryptodev_capabilities openssl_=
pmd_capabilities[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_END_OF_CAPAB=
ILITIES_LIST()<br>
&nbsp;};<br>
&nbsp;<br>
+static struct rte_cryptodev_capabilities openssl_pmd_caps_active[RTE_DIM(o=
penssl_pmd_capabilities)];<br>
&nbsp;const char *ml_kem_type_names[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ML-KEM-512&quot;,<br=
>
@@ -943,6 +944,29 @@ const char *ml_dsa_type_names[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ML-DSA-87&quot;,<br>
&nbsp;};<br>
&nbsp;<br>
+/** Initialize active capability list, filtering unsupported entries. */<b=
r>
+void<br>
+openssl_pmd_caps_init(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, j =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; openssl_pmd_capabilitie=
s[i].op !=3D RTE_CRYPTO_OP_TYPE_UNDEFINED; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct rte_cryptodev_capabilities *cap =3D &amp;openssl_pm=
d_capabilities[i];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cap-&gt;op =3D=3D RTE_CRYPTO_OP_TYPE_SYMMETRIC &amp;&amp;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.xform_type =3D=3D RTE_CRYPTO_SY=
M_XFORM_CIPHER &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cap-&gt;sym.cipher.algo =3D=3D RTE_CRYPTO_=
CIPHER_DES_CBC ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.cipher.algo =3D=3D RTE_CR=
YPTO_CIPHER_DES_DOCSISBPI)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EVP_CIPHER *des_=
cbc =3D EVP_CIPHER_fetch(NULL, &quot;DES-CBC&quot;, &quot;provider=3Dlegacy=
&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (des_cbc =3D=
=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EVP_CIPHER_free(=
des_cbc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; openssl_pmd_caps_active[j++] =3D *cap;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openssl_pmd_caps_active[j] =3D openss=
l_pmd_capabilities[i];<br>
+}<br>
+<br>
&nbsp;/** Configure device */<br>
&nbsp;static int<br>
&nbsp;openssl_pmd_config(__rte_unused struct rte_cryptodev *dev,<br>
@@ -1014,7 +1038,10 @@ openssl_pmd_info_get(struct rte_cryptodev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev_info !=3D NULL) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info-&gt;driver_id =3D dev-&gt;driver_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info-&gt;feature_flags =3D dev-&gt;feature_flags;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info-&gt;capabilities =3D openssl_pmd_capabilities;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (openssl_pmd_caps_active[0].op =3D=3D RTE_CRYPTO_OP_TYPE_UNDE=
FINED)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info-&gt;cap=
abilities =3D openssl_pmd_capabilities;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 11pt; colo=
r: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 11pt; color: rgb(0, 0, 0);">
It seems&nbsp; fallback also advertises DES even when DES is unavailable, w=
hich defeats the filtering during that window. Would it be better fix to in=
itialize the filtered list before the device can be queried; then this fall=
back should not be needed.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info-&gt;cap=
abilities =3D openssl_pmd_caps_active;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info-&gt;max_nb_queue_pairs =3D internals-&gt;max=
_nb_qpairs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* No limit of number of sessions */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info-&gt;sym.max_nb_sessions =3D 0;<br>
--<br>
2.43.0<br>
<br>
</div>
</body>
</html>

--_000_LV2PR11MB604545E17B9928A3A4758C2A81922LV2PR11MB6045namp_--
