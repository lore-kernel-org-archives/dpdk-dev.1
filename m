Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CEFD6409D
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 09:22:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD40840275;
	Wed, 17 Dec 2025 10:22:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 98E0A4026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 10:22:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765963336; x=1797499336;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=dKBLwJc0xuusNcfHtyRNyScMkFsGxQIddFxUCytimVo=;
 b=T7es7vuZafgN2ZWNAdCcAQdEOihErOI8B0GLCIQtUuz6sLQoMY0OHTtf
 AkDqNg68JHnC+42WcG1tpppJeq5nw3jn2WcMNdOBfNFug6GB6mJoy8miD
 lZn78QHFSGsxMDsgNNSGVvhXyKl4gtf1MQKwntBJ7qOpazTRQ9GYS4vES
 enYgXdJAKIbeBk5rLUVbWAqvUgd6yCRQXwqFBz7Vvur9H3QZr0aY6yCgG
 bR1xAcKlChBtoxOza4e0QHjR2Vr42pwFSAqJQbeWSHuMH/IrLk3dwWv8g
 shREvZlzSgDMSnHO1Bb4mol23CmQ24d/fXjKs3eQY/9evJ8PwfBSjKmLx Q==;
X-CSE-ConnectionGUID: 3qd6MLeuQCuQMEC6meXL3A==
X-CSE-MsgGUID: twH5tm3sT5G89r1Nrog5pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="78608582"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208,217";a="78608582"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 01:22:14 -0800
X-CSE-ConnectionGUID: fpm7vDZ+T/OntuxXaYqc9g==
X-CSE-MsgGUID: jgWuYXEeTNqqZPXalR5muQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
 d="scan'208,217";a="198314076"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 01:22:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 01:22:14 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 01:22:14 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 01:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rA+uQdpuUWaFsTq1LxkmKLcMmmqLZxlO6QfCxbFSXUIiKNcuiiMCGwj9xt/NxcrDlIlw8FlCGUV58cBmjjO5exnibGYi+i+F+5mPzdd04Ryn2x4lY70oaUJf/lCnH40hmVwlBytxGAOoJVUN7JdsIUrjLg11IQhsYtXgWY1OXljn+NUs69N1GzYWU3BI4EDaqpTwHq2slg2JTkhfwzg1AfIuewDrZj4s4JcIyEoNU1GlVk+WvdHe5JTzxAGUOZtBJmbJ8Qcq/JE7gCgF8vB608deMRa6YZdA3OEaide1dnf7tqu8sMk9zgglL2X420WpBPkraD9nmpDfU1PMpk76gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFBvIy2M13p9pg455FwjVY0dYTcHeAPKAW20yYEzU9Y=;
 b=V1z04l7CS/nyxblFPUsdoNlbg2G1RQINxv3NQx8nC6Z+6c74e5vgowxNUyGKDjsOMTpP8fBd9+YX1WydvQb2l8qPBRhyozu+lSzjQBoU+vM+401qMc2FN3xBBzBypnhJKjZ/21R0YpHEuiUVacCHHe0PCBwgD1CO2JrXSaOkqQ5LKWyx2Dgoifmae5NqiHOUDBeHfrRPwh9nKNCaUg/lCeALgDyXMs2rD98SDfYt42cHhDodWWKr55xMlRAnGl1HM74+Dpf4fVCsPAjL2m6nKYn8ouK8Uj9EwSUhMFVaQSVc0uIeYqPFDdqmL8Hf2eTXKQDwN+Sq5KZ8f6aDqik4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17)
 by SN7PR11MB7666.namprd11.prod.outlook.com (2603:10b6:806:34b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:22:12 +0000
Received: from SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::d99f:fb93:4a9e:9785]) by SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::d99f:fb93:4a9e:9785%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:22:11 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [v2] doc: update device configuration in qat guide
Thread-Topic: [v2] doc: update device configuration in qat guide
Thread-Index: AQHcba9faSZ5mGxCEUGTmxF4zXGZDLUlkb6r
Date: Wed, 17 Dec 2025 09:22:11 +0000
Message-ID: <SA3PR11MB74617FD778283A8863CDFB3181ABA@SA3PR11MB7461.namprd11.prod.outlook.com>
References: <20251201134711.797983-1-emma.finn@intel.com>
 <20251215104109.1476713-1-emma.finn@intel.com>
In-Reply-To: <20251215104109.1476713-1-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7461:EE_|SN7PR11MB7666:EE_
x-ms-office365-filtering-correlation-id: 7d50fcb9-427d-4677-bb1e-08de3d4dc292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|42112799006|366016|1800799024|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?2lJOcY0sed7VNNYqP/C7yQBIeyc5G4Txz3WoWiolN2XTvFJx5XgLLpHaSre5?=
 =?us-ascii?Q?BKqnVDTIaomPwdiWqC5XEquADftP1J1qBovwcx6/pa4txICszL+XEVTXtLw8?=
 =?us-ascii?Q?po1LjVOOFmE7w2U+jWGgCPlfKwXJG0l3u3zU5/wG4yHqqcI92hHeCJtoChq1?=
 =?us-ascii?Q?ho/Zh8gp66Jjjwve+lmspZeFf7nea4e+tR3UGxhYP7nVwYNUxKf8JsEekzVU?=
 =?us-ascii?Q?IFiJbGW6r/VFJTdBN2+4JkgKNzRiikJDZxEyKejwf8keLFy+PM79un6Qe5FL?=
 =?us-ascii?Q?4kv1UY35jjBpmh+pALebyChztP3cGZ90TS36wKY/Aj3WirIk14E6hSN5TjvB?=
 =?us-ascii?Q?fO4q8yDshdjnXrTvQgkpBfjstvsAL16hqebx+ncs/8DlHAy0eCVS4wHVtRiK?=
 =?us-ascii?Q?M88py1n46xTrdpoIoUgMRcCLeQTeZHby4Et0h7t9vobbPbwfHMRO/Ie4pzt2?=
 =?us-ascii?Q?7Y/BEVWXK2WpzNDpySsc/QixsI9A2wYfAD5k3ATSl2Idd8AxzWjjgQyNup6Q?=
 =?us-ascii?Q?KX7J+aZX8FuSGrkkKWFrbDwjTCITZtltoEbPn+uhrN+MiGp/ZD/XfQrK67Ib?=
 =?us-ascii?Q?VmGCn8oDhUhQbaiufk1Xqm3RbJ4haUXc0j3+cDwMolWOIx24Gc7+y5wMF/43?=
 =?us-ascii?Q?XnFYnyJKC8jIRdaGUqAdgHaAaG3vXLIXLyEzOYhoqOljSoU5M4aOk12P/8gq?=
 =?us-ascii?Q?SD3Hl5AwpN/kMcvjQDhML1fO0DVceDmdejtC3EgurdNzaigng0oTXzP/dJ9c?=
 =?us-ascii?Q?WrX6s4TA16yCJP5H2g6zJUDmfKhBylcYFv/P5M3hQHvYDlxstnXtVEknVzhw?=
 =?us-ascii?Q?uu3ElLyPU1vg8uW3Tmm8YTLcHbDpRvucRkUWfIMGuAOfcRuL7UrVulYmtClt?=
 =?us-ascii?Q?bwJeRuOPOm1W0iKxw8K04oMJ5LoRG1q+ObZEIJvBPS9UTaWcbKwFWwvZtz0C?=
 =?us-ascii?Q?WrptJvIHgE7tgjTR/l0O6R0cx9hLt+Avdkp/cw2UfkIWc4X/1yuKg6QmpMHd?=
 =?us-ascii?Q?dfy/gJ6slV6/g79Lo8wjndJ9OHJZh19H00OBmvuxOH9ZeMU2LqaIFl58YC5P?=
 =?us-ascii?Q?3nFbEGklkg3jef+yMu4C7bRFREEgncE48Pzg4gyb+OaPneZG8bMzgFqryNpB?=
 =?us-ascii?Q?17ie3UWd8ez5osCF9n3gWwFFOIUcMBbHkyQY64e7aGI3FULaUPtIAv/8pGiY?=
 =?us-ascii?Q?SSae4RCRHfxIqumB4ajgH5rebpank2CX5Qs2xDwEMUayKdQzCJVztfLMQpTF?=
 =?us-ascii?Q?mi3+nxelt5E9+qj4PMRs/eWq2Kx1ByiNjs2J1th2/gG5nvKBMcPlJGWO+CXK?=
 =?us-ascii?Q?9s9nRp54IajGO+Bo8ODOaYdJwHtVWAFqpvfZxwF25+7DEOGaYWbwDMoHfFQb?=
 =?us-ascii?Q?GslRqMf4zEEtnvwTfDqVFO0ZDFalM0dxbU13ep2iMJAKGcJmlpv326xvZO7D?=
 =?us-ascii?Q?iXrpRf+/phLDC34Xj5i6KP3p9BzWvRqBibMx8d93efLw+PO8fAgDoGTwr7G8?=
 =?us-ascii?Q?Gt879MvA03GGxbTskbF0Iynh3gqZKSfPvv67?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB7461.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(366016)(1800799024)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EdWF+C4CoFBW68MdY7f9FDpcaSy1YnNfRvRZcw5zQS3bU8retsySs0gkbtuZ?=
 =?us-ascii?Q?3CjGgpaTk+n4gM6zdkB+PQpeO66/m3wvBzG7bRu9sXuts3dH2Wjrzv+QzMSv?=
 =?us-ascii?Q?w6ZkOT5fk52X7zFtBNOsvRSWRNxmD+Y+fV61h6mUJGdIB+XvUtR8oUR0Yv8K?=
 =?us-ascii?Q?FbNMZlln6DVvc2dQbIRfR6hokAP/CdCTPpmE5HBI7jD8vdLLBy+gJ41jwkuc?=
 =?us-ascii?Q?ZRWCIZ0JKI4vAZNsbfzx6fIQvRAnaIqOkUYoUVKABDILrlUGKfbBBrRmZ0rW?=
 =?us-ascii?Q?tK4Z1hilaRQOmbfgKVAzM4gJtqP5wjX/qUXZCyofEtdvwQsB5zs+txjltnzn?=
 =?us-ascii?Q?xakKgyZx94uhjUw9j7WfcyBW3VcMQA0/BhPoq8pLsOHUtYDX15KosEHQI8xY?=
 =?us-ascii?Q?AIZaMTLYgBLVMoqfm1GzAFimQbKVg35213hDSZpTMfxFDxEq1hmOf3hQ6QYc?=
 =?us-ascii?Q?7wObuhTBcZRPvIl9RqG8TmXCIY3C5mLKTjPpE+gC1m4S0AztV3eYAmnkD795?=
 =?us-ascii?Q?p7R8huxGEq3EjvbB9JxAVImUrXtMo66rkP9dSxBKaZz4OAYHEO6N149ExwC0?=
 =?us-ascii?Q?xbpkusl6OxE7nmEu3YcWN2bxL7sVQD5WdDH6bDoCabsSz0Wh3eRlOy5o2J9N?=
 =?us-ascii?Q?35A3KHQAhaGdKAaHTGA5a4RI8l3MD9EPfCvApCWfmcOEUyJfgxsItBIK1JDs?=
 =?us-ascii?Q?oPAqOTYocCiHFWYCSpCHg7JdBSFJmOG401i1+WvB/6Wz3JgqM0Mgy+zzLMvj?=
 =?us-ascii?Q?4VHr5rcTALxDnSXmIk+vAa4ia3bydRlXublewiNfxmzHdzXkT8B+aNIhDAsH?=
 =?us-ascii?Q?XgRy2CwdhLK14TYt0cN6SHMCTLxQBW1sOZfqYf85Khfc8W0MzBsxcLNA03UD?=
 =?us-ascii?Q?2TQ0xVTZhnWRMUsejnPnNcSFH5LgFatKaIiirUwnkm5TGhi9h8OA+VUoB/py?=
 =?us-ascii?Q?OyA7vZ3yDVpvAS2w5qSdcZt6TGWPMjr9dQdq1YdPooc7l3B1zkG4s3tMaJtZ?=
 =?us-ascii?Q?lEaUbpFnZkCXisUuShuwM3nSoKpVdEbxSjccRbNPrRxGuX/BBrsjRQb2fFev?=
 =?us-ascii?Q?XkEx+nb3FaCGGhd4NlTpQcCzhxBhfmuSCE6apDPEEJ7QXi6sOwgAuLPMYDv8?=
 =?us-ascii?Q?Rk2qJx3x84hPDd93g8UvuMCCsnMvnVKHxvyTcZgecTII977y6IlSGzgCvSFF?=
 =?us-ascii?Q?APHw2xf1Wbb6y1Y9GYxFvdH7wWjESO8CPddmgdwEG2dzXuhSTcuHUUic8v5n?=
 =?us-ascii?Q?66HBKAeP1DIjNrUDDxVKjw6e4Kb3RXzM7B4CQJn7b3dlZz83vbFYNsWiBtQv?=
 =?us-ascii?Q?nrwPkx9Rg46nvGoN8fLAYQ+vQBl3312wS20kAzvrWXqc6IsIsfkS3FtvjjpF?=
 =?us-ascii?Q?QtgBWjjG3eOQtSNa4kAhkjgnSlUhEv7W7Yp3O9WP3XKwwoRK+rbp6enaHy2V?=
 =?us-ascii?Q?I4C6STFHsrw3O2qVn1u0rqZq+UGCWy32T2qJ0OmK8kuqVOBlEr5B+gQbvjSw?=
 =?us-ascii?Q?8vJtOGj3xN84jQT4T5wUAahJjs7joiIFk/YQglH3FFnu7vpf+YR5uEtK7Kdv?=
 =?us-ascii?Q?zj6BDFtr1qv/y4gHccA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA3PR11MB74617FD778283A8863CDFB3181ABASA3PR11MB7461namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d50fcb9-427d-4677-bb1e-08de3d4dc292
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 09:22:11.8787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVfx5Sv+djnpQ7Fv0JKEJDiOS4NZsRgV8/2CNKmAbI5JnV8PdnKvLlILoOwsalql2VEckDXnR7CLNub1sXmB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7666
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

--_000_SA3PR11MB74617FD778283A8863CDFB3181ABASA3PR11MB7461namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Finn, Emma <emma.finn@intel.com>
Sent: 15 December 2025 10:41
To: Ji, Kai <kai.ji@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Finn, Emma <emma.finn@intel.com>
Subject: [v2] doc: update device configuration in qat guide

Added note for QAT driver information and device
configuration for services.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 doc/guides/cryptodevs/qat.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 68d792e4cc..bae7724a76 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -501,6 +501,27 @@ If you are running on a kernel which includes a driver=
 for your device, see
    The actual crypto services enabled on the system depend
    on QAT driver capabilities and hardware slice configuration.

+..note::
+
+   With the introduction of QAT Generation 4, the in-tree drivers are avai=
lable within the
+   mainline Linux kernel. Out-of-tree (OOT) drivers for QAT Gen 4 are curr=
ently in sustaining
+   mode, meaning they will only receive maintenance updates without new fe=
ature development.
+   Future generations of QAT will be supported with in-tree drivers exclus=
ively.
+
+.. note::
+
+   For **in-tree drivers**, when multiple QAT instances are available, eac=
h instance is assigned a
+   different crypto service by default (asym;sym or dc). The available cry=
pto queue pair request
+   will return zero if the corresponding service is not enabled.
+
+   To verify the device configuration, run:
+    cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
+
+   For symmetric and asymmetric crypto services, ensure that `"asym;sym"` =
are enabled.
+   For **out-of-tree drivers**, the configuration file for each instance c=
an be found at:
+    /etc/<GEN>_dev<ID>.conf
+
+
 Installation using kernel.org driver
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--
2.43.0


--_000_SA3PR11MB74617FD778283A8863CDFB3181ABASA3PR11MB7461namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Finn, Emma &lt;emma.f=
inn@intel.com&gt;<br>
<b>Sent:</b> 15 December 2025 10:41<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Finn, Emma &lt;emma.finn@inte=
l.com&gt;<br>
<b>Subject:</b> [v2] doc: update device configuration in qat guide</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Added note for QAT driver information and device<b=
r>
configuration for services.<br>
<br>
Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;<br>
---<br>
&nbsp;doc/guides/cryptodevs/qat.rst | 21 +++++++++++++++++++++<br>
&nbsp;1 file changed, 21 insertions(+)<br>
<br>
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst<=
br>
index 68d792e4cc..bae7724a76 100644<br>
--- a/doc/guides/cryptodevs/qat.rst<br>
+++ b/doc/guides/cryptodevs/qat.rst<br>
@@ -501,6 +501,27 @@ If you are running on a kernel which includes a driver=
 for your device, see<br>
&nbsp;&nbsp;&nbsp; The actual crypto services enabled on the system depend<=
br>
&nbsp;&nbsp;&nbsp; on QAT driver capabilities and hardware slice configurat=
ion.<br>
&nbsp;<br>
+..note::<br>
+<br>
+&nbsp;&nbsp; With the introduction of QAT Generation 4, the in-tree driver=
s are available within the<br>
+&nbsp;&nbsp; mainline Linux kernel. Out-of-tree (OOT) drivers for QAT Gen =
4 are currently in sustaining<br>
+&nbsp;&nbsp; mode, meaning they will only receive maintenance updates with=
out new feature development.<br>
+&nbsp;&nbsp; Future generations of QAT will be supported with in-tree driv=
ers exclusively.<br>
+<br>
+.. note::<br>
+<br>
+&nbsp;&nbsp; For **in-tree drivers**, when multiple QAT instances are avai=
lable, each instance is assigned a<br>
+&nbsp;&nbsp; different crypto service by default (asym;sym or dc). The ava=
ilable crypto queue pair request<br>
+&nbsp;&nbsp; will return zero if the corresponding service is not enabled.=
<br>
+<br>
+&nbsp;&nbsp; To verify the device configuration, run:<br>
+&nbsp;&nbsp;&nbsp; cat /sys/bus/pci/devices/&lt;BDF&gt;/qat/cfg_services<b=
r>
+<br>
+&nbsp;&nbsp; For symmetric and asymmetric crypto services, ensure that `&q=
uot;asym;sym&quot;` are enabled.<br>
+&nbsp;&nbsp; For **out-of-tree drivers**, the configuration file for each =
instance can be found at:<br>
+&nbsp;&nbsp;&nbsp; /etc/&lt;GEN&gt;_dev&lt;ID&gt;.conf<br>
+<br>
+<br>
&nbsp;Installation using kernel.org driver<br>
&nbsp;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
&nbsp;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SA3PR11MB74617FD778283A8863CDFB3181ABASA3PR11MB7461namp_--
