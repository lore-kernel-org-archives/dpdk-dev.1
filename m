Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94701C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 04:51:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C79740653;
	Thu, 20 Aug 2026 06:51:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id E91124026A
 for <dev@dpdk.org>; Thu, 20 Aug 2026 06:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787201477; x=1818737477;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=wyQy142u7zoIPBshmyGfEC6EPzALKnOqISJllZmpDNc=;
 b=TKDgSrl16Iw2QeqgT0BbuOGcOZG3vyPt1GSo83386MGXGWBlb/BPZ7E5
 aLAYyap2OTsIlnwCuWZgaw+B6ALv9TQrY3q5iXcnnhmf8ZBq06/+AN8OQ
 UUhdbiQfrCllFw+eOTIpPZmEoLrehzYN6glHXK7ZIRYE9d37y7foXZZCZ
 vQAMfi0xVVAmrQZ8r+DMEYeqm6hbMFTUQJh47Wxq5Tnf0LbLiLGLcKa5c
 2gWaB5YMKP/R7AAy6vee8AqWYxdRWaUSWUrsuZ0UZiP6APFfPRDtTVwnv
 DRoSQmeAfjQ2yWT/pM8eky17fD7Ms4b4RonpxHF7zpJiQz3hAEucyXYh+ A==;
X-CSE-ConnectionGUID: XQ8JL2rNS3GTPsjRZGtO1A==
X-CSE-MsgGUID: aWxOeQQ5Sd+6PUTVnAfVKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87584418"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208,217";a="87584418"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 21:51:15 -0700
X-CSE-ConnectionGUID: zHtRYsNBQHaykkIE9qXjuw==
X-CSE-MsgGUID: KlTGkeDhRsKz2Ox6rndG2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
 d="scan'208,217";a="265837958"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 21:51:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 21:51:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 21:51:13 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 21:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMdU9lrq7w/EnhBNMn33lGBgzIdOwoP5jPkKBttaPzKArW2W2+0QtrzpV1e78ACnf3yh+HJjfNPZL952M1Npm2kiEKj1Iw3klnsr9+MNnb6oUtgeeKsOH8TCbM8+4qGz1c43U915G3yx9ZhhAryf00RPYqiG/LRIx9lbhkOlVQ+5GHOPN1ftNkA+aWYE1xW7XjW3TXFxf6I6lQj6NHfQDK+UjhPAeppjyxIFb+MGSnYI2eFLeVtCf0FeCHGn5eM/Vg/HGbEKUzvF4pWdunFOvpFea5n80jYwyMiN0HvCYmQVNydMdE46IH/78ubhq+YXtcZ8rt4ob8YOE/Fq5iYPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYbTUgyj/4jRov+s9qRDlnRB0VJ4hRBnSPI17jxlSPE=;
 b=A/Hkxvh8UYJb6MYGVUXpnhMSkCvRSKkHwg3r3CxAX5t+tMcW1ran845Kr/cNb8r+J/D5H5FcJWoeVlUhLxFpzaQj7ZYA3OxJ6wOicu4o/n6fyga5iDe7KIHfi03uNMJtkg3vPm1mCRUTPrVezNIj7f3Wy2PXGPx3hxoAvyGAEL2EZh6CKmI6+no4gXmMR2Ad/0TKSaxSdaV7O5nIiZCxvo0OUHhER7auUo5lXXV5PNuKztIsh/H31wmKi6vtS9iRrXs1zhIftiI+K0NTulDVsBKlb6+tFC5LVQm/O+d5LhSUOHJPt4q/J+NZ/cOEDw73uvirsvMyp4XN9fZPSZl2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB013943.namprd11.prod.outlook.com
 (2603:10b6:208:548::8) by CY8PR11MB7082.namprd11.prod.outlook.com
 (2603:10b6:930:52::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 04:51:00 +0000
Received: from IA3PR11MB013943.namprd11.prod.outlook.com
 ([fe80::1766:4eec:eeb0:13c2]) by IA3PR11MB013943.namprd11.prod.outlook.com
 ([fe80::1766:4eec:eeb0:13c2%6]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 04:51:00 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC 1/1] ethdev: add per-packet Tx timestamp slot APIs
Thread-Topic: [RFC 1/1] ethdev: add per-packet Tx timestamp slot APIs
Thread-Index: AQHdLn4XRP+qsskhHESqmvB6BYSyMLamYIpy
Date: Thu, 20 Aug 2026 04:51:00 +0000
Message-ID: <IA3PR11MB013943F03F187EFFF422F08B94A1A42@IA3PR11MB013943.namprd11.prod.outlook.com>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
 <20260817192417.3009990-2-rajesh3.kumar@intel.com>
In-Reply-To: <20260817192417.3009990-2-rajesh3.kumar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB013943:EE_|CY8PR11MB7082:EE_
x-ms-office365-filtering-correlation-id: 7d3a79fa-a951-4dcb-6f97-08defe76a1ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|6133799003|3023799007|18002099003|8096899003|4143699003|11063799006|22082099003|38070700021;
x-microsoft-antispam-message-info: SWoDx2KbbqUzZUnNkO4lKcTytLBJXn8w3MU9s5zFMJDthzXdeK29SpmW3iypjz6caf01+DNzBepC19qER6GCopzonCJBDjxg9uqGutgGa+mueX7b7laRG5tlx8/yN7nGVHiV12diSOZe8VpQ/TqQS2ucYE+P7WaevqsMfWzAe389TYhVWcjcKNQfyur1aEA+yUVjPtcqZ0RV+7DOKrHip0OJqWaWXnSKzwke76kOOkC2jBFJ/ckiod3iWbVqdL5JZnxC8cB+t7fm+EjEROXA6e1wPzRMZQiCtYnyqT4d8RccTVCpX0aGFVmlPXKEoFAIQ0uq1aQvl0xPxcdvBPXFhCJUKnm4fOLovmSdp0vWx91PvAlSetnG4NCSowajcJVPhP7A8AvfB4QGfNeuH9ZMjLNHGIXyk133lGSwX7uzN4AXY/M1TMMVzacMAJa95bK9O+Ip1FHtie30aioPLF+IHlCL0qkDBy77n9cXOzIgQQkTD6kIhO2scficBDWWwksbxf+ujFGXcaHs1bcNN5qeaPG9vqBiJUcrqkM6cO+Uf7Pv+knvgjUzD4DqNK6i6ecmRfuAgXu3Ecs1anHu7EGeckdOvXF4yOpf2KXLrR0x340cUrcEpehkg0XAC5Hmnev85f+kpbKhHWRd6We7OjMdVQ6or1SjHYQp+RRrkZpCak2Q85ToeHNTioAXIPj9TocMsq7PUnafX+usYEUPxlSvKJCs0Ot4wzgpK2Zjt4ZS+OM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB013943.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(8096899003)(4143699003)(11063799006)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?PnihDPmsshxAyxPMqzeowlht8bVw/xLXDTnlAUes49Mi+rAshlyKaBDX?=
 =?Windows-1252?Q?I/ECC3hov+upS+6VQ44qvIemMpdpWZoWkYIEOB3YYhtDNm6T2cUeKSAS?=
 =?Windows-1252?Q?4ZSQsIO+xUE+80DYIX27oOSG1Er3ueE7ogW6KhWUGXkRxroSZdR+ZEEG?=
 =?Windows-1252?Q?miWrD76tRD7a1cveKxKyoj7l8/I4wVlzrO4AWPy90H1EQvXulfR0UNiW?=
 =?Windows-1252?Q?XkTqoOWuerEAEFZwad31IyBVC1L/EODxQlRI4s6LL0kPuFgQRt/nZm9+?=
 =?Windows-1252?Q?Zm+Jdlg+ZZj424Kr9MaPc1EEkL1AiCUNVAbJVJYX6KB09AMrWnQunjfH?=
 =?Windows-1252?Q?UqHjcftDRD/4gJVesSU4AHw/Rr0jXvDbLbjxvMHvbUm1MJzHIVi8spAL?=
 =?Windows-1252?Q?w5mF2Yo/V1c7BMgSv30uT8W+lTBPD1bvrxUXVbLhK3cb8CfkNz9e6ZS2?=
 =?Windows-1252?Q?6d2hiZa02oJiHL0sCTjEWo2lNAHnvevk0U2HuNAJTFcDiFysvVABAYj6?=
 =?Windows-1252?Q?dwTIhEoTraOzWKbTclxsAyMBIID1fNoP95a6ukZooEWy6Ut6T2IRaE13?=
 =?Windows-1252?Q?gAV/GadwdZ5ORSOwmjDarCR9iYebBeHwvBXqdzi/dvNqUqcc4DAU37dB?=
 =?Windows-1252?Q?ey5dvGX0VMdTcaDzEbmHpHZJie63MYA4NMMPerUwvypGIB4blQ0KDdtH?=
 =?Windows-1252?Q?KI7aKyb7Xkoy9cYIiG2Yv8XDKLlGv8/pU3FtqBfTSTkf59BNVuDKY6HY?=
 =?Windows-1252?Q?gMybEaJd+ZNgM6vKiTkTM9G4rPllPGeOrMQI3EnB/X7carqzXleHQKYK?=
 =?Windows-1252?Q?ORVpc4PhuKzHaYATXVjAK/jpZlKZPTcW02QybdBHvk+G/HYMUTZQ468A?=
 =?Windows-1252?Q?WQtxxXfKKlccoED+cGBY4LYuQadyp1zm9DFwlp0PxFTi+aH55Gs7N7ku?=
 =?Windows-1252?Q?Z7Wwg2iV6L72JUPy1V2Rl1C1iSZPhVBLFfCuS0PeQQrH8icDEftEE5Sy?=
 =?Windows-1252?Q?pPXd5OGJGa2w/pkX3OZGwYncPLXg936PFleaxbmO2smdCS9FzGWBqin/?=
 =?Windows-1252?Q?6NUsvsyV1C8/awbDL43Y8ABpjMDW1QxtPedvjhhVHOLw9qVJR03gd2nv?=
 =?Windows-1252?Q?+sVRJCT8J5Um0SUF2Q0MWms1Q/qmsHcV1gWNViMh+AaxtiPowaAcmiHU?=
 =?Windows-1252?Q?Dcdm4i693Dr9qC2L8aaNodThaS4WpbfI8VCY8JJh95culLxBKrbf2+Q0?=
 =?Windows-1252?Q?1fyXIpXTnXB5lxlXn6S7uuxSuopUFO3hFWkW3oEGVFvOXNE9QI0SHOnV?=
 =?Windows-1252?Q?jXG67Eg/oVZqPkTemde2bgO92oun1+bwehIG8pc5oo0UJ70CqOdInMc9?=
 =?Windows-1252?Q?srPeBRfQ3kGMIRRsIb9FHbUGLQs562RbNStUBmh93TB0jFcjeeFQ/p4c?=
 =?Windows-1252?Q?/BFGPV9UrGg/NHgSe9uhK2AR64Ms7J5MXbVJZMmcNBV+mPGvka8nhR0b?=
 =?Windows-1252?Q?m4EPXXqTn9OjEKsYoGimQhLYLLlcj48Ds25zZmXK6R7HGCLr51/PsXaw?=
 =?Windows-1252?Q?reRWCSnxJ7C6kRK9cYwzhidkL8Q+aRq2mmKiNLKxwnr6vpu6/xsCm7nj?=
 =?Windows-1252?Q?fjOzom6+zDCSynsH3tix5vhfjQhidZxFWLqz3eQuZFq0MiwaZ04txFlc?=
 =?Windows-1252?Q?1eJk+U3EOfZY7gqH7wA2sGxFfgs3w7xSmayr22T4Xz92wR8RWWvWt2Lj?=
 =?Windows-1252?Q?0u9hExky0z80SCMBfovozGNfCJFuS95A1Y7JIrzN2382tzdsMcdszjgj?=
 =?Windows-1252?Q?T3hpJGNLN6vTvGfVGuMMSe1JFszeCiD0AAccFQRepfHUH+JBL9dcoCWy?=
 =?Windows-1252?Q?Mlnib5+7rQCsGA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR11MB013943F03F187EFFF422F08B94A1A42IA3PR11MB013943_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A8/YEDvocjHvDBCBA8e9Gjfn+80/cn/wcgO/9jhe4/uMEHmPf0Dy5gV0b5Ezur9T5EZn2P7G4u9FT6Mm1MS8DpXja9g6mB5kKmOUeZc3FnNirl9WODBNfel1EaZxSk3jyu2KeqyJGLwwGSESCK2BrMB7Wje6X+IlCQ1aNLwPxY73KgbPFnkxyUAlbBAArXlRWJcjM2NW9ykE9bGMCzs6qe34t4K18qvIuCGSMxBAd3yzvc/4LWEIeTgPQJn+uim4iT9a3tfl3zJO3i/+d12wFxiDzOSC3wgU4R5egflw38ii2lYe7i5uTpeClBZ6kp9ZClaJDFUf/Q1cDX/ZaF3AJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB013943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3a79fa-a951-4dcb-6f97-08defe76a1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 04:51:00.4939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwctxagQda8W1pHMuuUY18/hW4ERJq6iiHOqdeOpCs3WQKBeZ4+SCfzSAgOpnhDqgYGHZCVajoqsde2pw+ybw/9njCqN5O1vzKYhBAoDXcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
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

--_000_IA3PR11MB013943F03F187EFFF422F08B94A1A42IA3PR11MB013943_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Rajesh Kumar <rajesh3.kumar@intel.com>
Sent: Tuesday, August 18, 2026 12:54 AM
To: dev@dpdk.org <dev@dpdk.org>
Cc: thomas@monjalon.net <thomas@monjalon.net>; Richardson, Bruce <bruce.ric=
hardson@intel.com>; andrew.rybchenko@oktetlabs.ru <andrew.rybchenko@oktetla=
bs.ru>; Kumar, Rajesh3 <rajesh3.kumar@intel.com>
Subject: [RFC 1/1] ethdev: add per-packet Tx timestamp slot APIs

Add ethdev public and driver-facing APIs for per-packet Tx
hardware timestamp slot management.

The existing `rte_eth_timesync_read_tx_timestamp()` exposes a
single shared latch, making it unreliable when multiple Tx
timestamps are outstanding concurrently. PMDs with per-packet
slot hardware cannot be exploited through this interface.

Introduce a slot lifecycle API:
- `rte_eth_timesync_tx_timestamp_slot_alloc()`: reserve a
  hardware slot before transmit
- `rte_eth_timesync_tx_timestamp_stamp_mbuf()`: embed slot
  handle into mbuf dynfield for per-packet NIC steering
- `rte_eth_timesync_read_tx_timestamp_slot()`: poll slot for
  a captured timestamp; returns -EAGAIN if not ready
- `rte_eth_timesync_tx_timestamp_slot_release()`: return slot
  to PMD after readback or timeout

Introduce `rte_eth_timesync_dual_domain_timestamp` to carry
both the adjusted PHC time (`adjusted_ns`) and free-running
cycles-domain time (`cycles_ns`), each with an individual
validity bit in `valid_mask`.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 lib/ethdev/ethdev_driver.h |  19 ++++++
 lib/ethdev/rte_ethdev.c    | 121 +++++++++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h    | 108 +++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)

diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..61dadcea49 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -795,6 +795,19 @@ typedef int (*eth_timesync_read_rx_timestamp_t)(struct=
 rte_eth_dev *dev,
 typedef int (*eth_timesync_read_tx_timestamp_t)(struct rte_eth_dev *dev,
                                                 struct timespec *timestamp=
);

+/** @internal Allocate a per-packet TX timestamp slot handle. */
+typedef int (*eth_timesync_tx_timestamp_slot_alloc_t)(struct rte_eth_dev *=
dev,
+               uint16_t tx_queue_id, uint32_t *slot_id);
+
+/** @internal Read TX timestamp by slot handle. */
+typedef int (*eth_timesync_read_tx_timestamp_slot_t)(struct rte_eth_dev *d=
ev,
+               uint32_t slot_id,
+               struct rte_eth_timesync_dual_domain_timestamp *timestamp);
+
+/** @internal Release a previously allocated TX timestamp slot handle. */
+typedef int (*eth_timesync_tx_timestamp_slot_release_t)(struct rte_eth_dev=
 *dev,
+               uint32_t slot_id);
+
 /** @internal Function used to adjust the device clock. */
 typedef int (*eth_timesync_adjust_time)(struct rte_eth_dev *dev, int64_t);

@@ -1561,6 +1574,12 @@ struct eth_dev_ops {
         eth_timesync_read_rx_timestamp_t timesync_read_rx_timestamp;
         /** Read the IEEE1588/802.1AS Tx timestamp */
         eth_timesync_read_tx_timestamp_t timesync_read_tx_timestamp;
+       /** Allocate a TX timestamp slot handle */
+       eth_timesync_tx_timestamp_slot_alloc_t timesync_tx_timestamp_slot_a=
lloc;
+       /** Read a TX timestamp using a slot handle */
+       eth_timesync_read_tx_timestamp_slot_t timesync_read_tx_timestamp_sl=
ot;
+       /** Release a TX timestamp slot handle */
+       eth_timesync_tx_timestamp_slot_release_t timesync_tx_timestamp_slot=
_release;
         /** Adjust the device clock */
         eth_timesync_adjust_time   timesync_adjust_time;
         /** Adjust the clock frequency */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..b955784594 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6699,6 +6699,127 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id=
,

 }

+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_alloc, 2=
6.11)
+int
+rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,
+                                        uint16_t tx_queue_id,
+                                        uint32_t *slot_id)
+{
+       struct rte_eth_dev *dev;
+
+       RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+       dev =3D &rte_eth_devices[port_id];
+
+       if (slot_id =3D=3D NULL) {
+               RTE_ETHDEV_LOG_LINE(ERR,
+                       "Cannot allocate ethdev port %u Tx timestamp slot t=
o NULL",
+                       port_id);
+               return -EINVAL;
+       }
+
+       if (dev->dev_ops->timesync_tx_timestamp_slot_alloc =3D=3D NULL)
+               return -ENOTSUP;
+
+       return eth_err(port_id,
+                       dev->dev_ops->timesync_tx_timestamp_slot_alloc(dev,
+                               tx_queue_id, slot_id));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_read_tx_timestamp_slot, 26=
.11)
+int
+rte_eth_timesync_read_tx_timestamp_slot(uint16_t port_id,
+                                       uint32_t slot_id,
+                                       struct rte_eth_timesync_dual_domain=
_timestamp *timestamp)
+{
+       struct rte_eth_dev *dev;
+
+       RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+       dev =3D &rte_eth_devices[port_id];
+
+       if (timestamp =3D=3D NULL) {
+               RTE_ETHDEV_LOG_LINE(ERR,
+                       "Cannot read ethdev port %u Tx timestamp slot to NU=
LL",
+                       port_id);
+               return -EINVAL;
+       }
+
+       if (dev->dev_ops->timesync_read_tx_timestamp_slot =3D=3D NULL)
+               return -ENOTSUP;
+
+       return eth_err(port_id,
+                       dev->dev_ops->timesync_read_tx_timestamp_slot(dev,
+                               slot_id, timestamp));
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_release,=
 26.11)
+int
+rte_eth_timesync_tx_timestamp_slot_release(uint16_t port_id, uint32_t slot=
_id)
+{
+       struct rte_eth_dev *dev;
+
+       RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+       dev =3D &rte_eth_devices[port_id];
+
+       if (dev->dev_ops->timesync_tx_timestamp_slot_release =3D=3D NULL)
+               return -ENOTSUP;
+
+       return eth_err(port_id,
+                       dev->dev_ops->timesync_tx_timestamp_slot_release(de=
v,
+                               slot_id));
+}
+
+static int rte_eth_timesync_tx_slot_dynfield_offset =3D -1;
+static uint64_t rte_eth_timesync_tx_slot_dynflag;
+
+static int
+rte_eth_timesync_tx_slot_dynfield_register(void)
+{
+       const struct rte_mbuf_dynfield slot_dynfield =3D {
+               .name  =3D RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME,
+               .size  =3D sizeof(uint32_t),
+               .align =3D alignof(uint32_t),
+       };
+
+       if (rte_eth_timesync_tx_slot_dynfield_offset >=3D 0)
+               return 0;
+
+       rte_eth_timesync_tx_slot_dynfield_offset =3D
+                       rte_mbuf_dynfield_register(&slot_dynfield);
+       if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
+               rte_eth_timesync_tx_slot_dynfield_offset =3D
+                               rte_mbuf_dynfield_lookup(
+                                       RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_N=
AME, NULL);
+       if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
+               return -ENOTSUP;
+
+       {
+               int flag_bit =3D rte_mbuf_dynflag_register(
+                       &(const struct rte_mbuf_dynflag){
+                               .name =3D RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD=
_NAME "_flag"});
+               if (flag_bit < 0)
+                       flag_bit =3D rte_mbuf_dynflag_lookup(
+                               RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME "_fl=
ag", NULL);
+               if (flag_bit >=3D 0)
+                       rte_eth_timesync_tx_slot_dynflag =3D RTE_BIT64(flag=
_bit);
+       }
+       return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_stamp_mbuf, 2=
6.11)
+int
+rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id __rte_unused,
+                                        uint32_t slot_id, struct rte_mbuf =
*m)
+{
+       if (m =3D=3D NULL)
+               return -EINVAL;
+       if (rte_eth_timesync_tx_slot_dynfield_register() !=3D 0)
+               return -ENOTSUP;
+       *RTE_MBUF_DYNFIELD(m, rte_eth_timesync_tx_slot_dynfield_offset,
+                          uint32_t *) =3D slot_id;
+       m->ol_flags |=3D rte_eth_timesync_tx_slot_dynflag;
+       return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_timesync_adjust_time)
 int
 rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..339c39fcdd 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5528,6 +5528,114 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t por=
t_id,
 int rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
                 struct timespec *timestamp);

+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.adjusted_ns. */
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID  RTE_BIT32(0=
)
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.cycles_ns. */
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_CYCLES_VALID    RTE_BIT32(1=
)
+
+/**
+ * Dual-domain TX timestamp payload.
+ */
+struct rte_eth_timesync_dual_domain_timestamp {
+       int64_t adjusted_ns;
+       int64_t cycles_ns;
+       uint32_t valid_mask;
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Allocate a TX timestamp slot handle for per-packet correlation.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param tx_queue_id
+ *   TX queue used by the packet to be transmitted.
+ * @param slot_id
+ *   Output handle identifying the allocated slot.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,
+               uint16_t tx_queue_id, uint32_t *slot_id);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Read a per-packet TX timestamp using a previously allocated slot handle=
.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param slot_id
+ *   Slot handle returned by rte_eth_timesync_tx_timestamp_slot_alloc().
+ * @param timestamp
+ *   Output dual-domain timestamp payload.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -EAGAIN: Timestamp is not ready yet.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_read_tx_timestamp_slot(uint16_t port_id,
+               uint32_t slot_id,
+               struct rte_eth_timesync_dual_domain_timestamp *timestamp);

How is the egress port information conveyed?
The timestamp slot is a resource of the physical egress port.

+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Release a previously allocated TX timestamp slot handle.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param slot_id
+ *   Slot handle to release.
+ *
+ * @return
+ *   - 0: Success.
+ *   - -ENODEV: The port ID is invalid.
+ *   - -EIO: if device is removed.
+ *   - -ENOTSUP: The function is not supported by the Ethernet driver.
+ *   - -EINVAL: Invalid parameters.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_timestamp_slot_release(uint16_t port_id,
+               uint32_t slot_id);
+
+/** Mbuf dynfield name for the TX timestamp slot handle. */
+#define RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME "rte_eth_timesync_tx_slot"
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Stamp an mbuf with a TX timestamp slot handle so the TX path steers the
+ * NIC to capture the timestamp in the correct per-packet slot.
+ *
+ * Must be called after rte_eth_timesync_tx_timestamp_slot_alloc() and bef=
ore
+ * rte_eth_tx_burst(). Safe for concurrent callers =97 slot is stored per-=
mbuf.
+ *
+ * @param port_id  The port identifier (unused; reserved for future PMD us=
e).
+ * @param slot_id  Slot handle from rte_eth_timesync_tx_timestamp_slot_all=
oc().
+ * @param m        Mbuf to stamp.
+ * @return 0 on success, -ENOTSUP if dynfield registration failed.
+ */
+__rte_experimental
+int rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,
+               uint32_t slot_id, struct rte_mbuf *m);
+
 /**
  * Adjust the timesync clock on an Ethernet device.
  *
--
2.54.0


--_000_IA3PR11MB013943F03F187EFFF422F08B94A1A42IA3PR11MB013943_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
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
<b>From:</b> Rajesh Kumar &lt;rajesh3.kumar@intel.com&gt;<br>
<b>Sent:</b> Tuesday, August 18, 2026 12:54 AM<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> thomas@monjalon.net &lt;thomas@monjalon.net&gt;; Richardson, Bru=
ce &lt;bruce.richardson@intel.com&gt;; andrew.rybchenko@oktetlabs.ru &lt;an=
drew.rybchenko@oktetlabs.ru&gt;; Kumar, Rajesh3 &lt;rajesh3.kumar@intel.com=
&gt;<br>
<b>Subject:</b> [RFC 1/1] ethdev: add per-packet Tx timestamp slot APIs </d=
iv>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Add ethdev public and driver-facing APIs fo=
r per-packet Tx<br>
hardware timestamp slot management.<br>
<br>
The existing `rte_eth_timesync_read_tx_timestamp()` exposes a<br>
single shared latch, making it unreliable when multiple Tx<br>
timestamps are outstanding concurrently. PMDs with per-packet<br>
slot hardware cannot be exploited through this interface.<br>
<br>
Introduce a slot lifecycle API:<br>
- `rte_eth_timesync_tx_timestamp_slot_alloc()`: reserve a<br>
&nbsp; hardware slot before transmit<br>
- `rte_eth_timesync_tx_timestamp_stamp_mbuf()`: embed slot<br>
&nbsp; handle into mbuf dynfield for per-packet NIC steering<br>
- `rte_eth_timesync_read_tx_timestamp_slot()`: poll slot for<br>
&nbsp; a captured timestamp; returns -EAGAIN if not ready<br>
- `rte_eth_timesync_tx_timestamp_slot_release()`: return slot<br>
&nbsp; to PMD after readback or timeout<br>
<br>
Introduce `rte_eth_timesync_dual_domain_timestamp` to carry<br>
both the adjusted PHC time (`adjusted_ns`) and free-running<br>
cycles-domain time (`cycles_ns`), each with an individual<br>
validity bit in `valid_mask`.<br>
<br>
Signed-off-by: Rajesh Kumar &lt;rajesh3.kumar@intel.com&gt;<br>
---<br>
&nbsp;lib/ethdev/ethdev_driver.h |&nbsp; 19 ++++++<br>
&nbsp;lib/ethdev/rte_ethdev.c&nbsp;&nbsp;&nbsp; | 121 +++++++++++++++++++++=
++++++++++++++++<br>
&nbsp;lib/ethdev/rte_ethdev.h&nbsp;&nbsp;&nbsp; | 108 +++++++++++++++++++++=
++++++++++++<br>
&nbsp;3 files changed, 248 insertions(+)<br>
<br>
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h<br>
index 0f336f9567..61dadcea49 100644<br>
--- a/lib/ethdev/ethdev_driver.h<br>
+++ b/lib/ethdev/ethdev_driver.h<br>
@@ -795,6 +795,19 @@ typedef int (*eth_timesync_read_rx_timestamp_t)(struct=
 rte_eth_dev *dev,<br>
&nbsp;typedef int (*eth_timesync_read_tx_timestamp_t)(struct rte_eth_dev *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct time=
spec *timestamp);<br>
&nbsp;<br>
+/** @internal Allocate a per-packet TX timestamp slot handle. */<br>
+typedef int (*eth_timesync_tx_timestamp_slot_alloc_t)(struct rte_eth_dev *=
dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t tx_queue_id, uint32_t *slot_id);<br>
+<br>
+/** @internal Read TX timestamp by slot handle. */<br>
+typedef int (*eth_timesync_read_tx_timestamp_slot_t)(struct rte_eth_dev *d=
ev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t slot_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_timesync_dual_domain_timestamp *timestamp);<br>
+<br>
+/** @internal Release a previously allocated TX timestamp slot handle. */<=
br>
+typedef int (*eth_timesync_tx_timestamp_slot_release_t)(struct rte_eth_dev=
 *dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t slot_id);<br>
+<br>
&nbsp;/** @internal Function used to adjust the device clock. */<br>
&nbsp;typedef int (*eth_timesync_adjust_time)(struct rte_eth_dev *dev, int6=
4_t);<br>
&nbsp;<br>
@@ -1561,6 +1574,12 @@ struct eth_dev_ops {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_timesync_read_rx_times=
tamp_t timesync_read_rx_timestamp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Read the IEEE1588/802.=
1AS Tx timestamp */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_timesync_read_tx_times=
tamp_t timesync_read_tx_timestamp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Allocate a TX timestamp slot hand=
le */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_timesync_tx_timestamp_slot_alloc_=
t timesync_tx_timestamp_slot_alloc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Read a TX timestamp using a slot =
handle */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_timesync_read_tx_timestamp_slot_t=
 timesync_read_tx_timestamp_slot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Release a TX timestamp slot handl=
e */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_timesync_tx_timestamp_slot_releas=
e_t timesync_tx_timestamp_slot_release;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Adjust the device cloc=
k */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_timesync_adjust_time&n=
bsp;&nbsp; timesync_adjust_time;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Adjust the clock frequ=
ency */<br>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c<br>
index 9efeaf77cb..b955784594 100644<br>
--- a/lib/ethdev/rte_ethdev.c<br>
+++ b/lib/ethdev/rte_ethdev.c<br>
@@ -6699,6 +6699,127 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id=
,<br>
&nbsp;<br>
&nbsp;}<br>
&nbsp;<br>
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_alloc, 2=
6.11)<br>
+int<br>
+rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t tx_queue_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t *slot_id)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev *dev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETH_VALID_PORTID_OR_ERR_RET(port_=
id, -ENODEV);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D &amp;rte_eth_devices[port_id]=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (slot_id =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_ETHDEV_LOG_LINE(ERR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Cannot all=
ocate ethdev port %u Tx timestamp slot to NULL&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;dev_ops-&gt;timesync_tx_t=
imestamp_slot_alloc =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOTSUP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return eth_err(port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;dev_ops-=
&gt;timesync_tx_timestamp_slot_alloc(dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx_queue_id, slot_id));<br>
+}<br>
+<br>
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_read_tx_timestamp_slot, 26=
.11)<br>
+int<br>
+rte_eth_timesync_read_tx_timestamp_slot(uint16_t port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t slot_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct rte_eth_timesync_dual_domain_timestamp *timestamp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev *dev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETH_VALID_PORTID_OR_ERR_RET(port_=
id, -ENODEV);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D &amp;rte_eth_devices[port_id]=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timestamp =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_ETHDEV_LOG_LINE(ERR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Cannot rea=
d ethdev port %u Tx timestamp slot to NULL&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; port_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;dev_ops-&gt;timesync_read=
_tx_timestamp_slot =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOTSUP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return eth_err(port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;dev_ops-=
&gt;timesync_read_tx_timestamp_slot(dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; slot_id, timestamp));<br>
+}<br>
+<br>
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_release,=
 26.11)<br>
+int<br>
+rte_eth_timesync_tx_timestamp_slot_release(uint16_t port_id, uint32_t slot=
_id)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev *dev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETH_VALID_PORTID_OR_ERR_RET(port_=
id, -ENODEV);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D &amp;rte_eth_devices[port_id]=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;dev_ops-&gt;timesync_tx_t=
imestamp_slot_release =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOTSUP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return eth_err(port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;dev_ops-=
&gt;timesync_tx_timestamp_slot_release(dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; slot_id));<br>
+}<br>
+<br>
+static int rte_eth_timesync_tx_slot_dynfield_offset =3D -1;<br>
+static uint64_t rte_eth_timesync_tx_slot_dynflag;<br>
+<br>
+static int<br>
+rte_eth_timesync_tx_slot_dynfield_register(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rte_mbuf_dynfield slot_d=
ynfield =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .name&nbsp; =3D RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .size&nbsp; =3D sizeof(uint32_t),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .align =3D alignof(uint32_t),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_eth_timesync_tx_slot_dynfield=
_offset &gt;=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_eth_timesync_tx_slot_dynfield_off=
set =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mbuf_dynfiel=
d_register(&amp;slot_dynfield);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_eth_timesync_tx_slot_dynfield=
_offset &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rte_eth_timesync_tx_slot_dynfield_offset =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_mbuf_dynfield_lookup(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_eth_timesync_tx_slot_dynfield=
_offset &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOTSUP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int flag_bit =3D rte_mbuf_dynflag_register(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(const stru=
ct rte_mbuf_dynflag){<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD=
_NAME &quot;_flag&quot;});<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (flag_bit &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flag_bit =3D rte=
_mbuf_dynflag_lookup(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME &quo=
t;_flag&quot;, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (flag_bit &gt;=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_eth_timesync=
_tx_slot_dynflag =3D RTE_BIT64(flag_bit);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_stamp_mbuf, 2=
6.11)<br>
+int<br>
+rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id __rte_unused,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t slot_id, struct rte_mbuf *m)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (m =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_eth_timesync_tx_slot_dynfield=
_register() !=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOTSUP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *RTE_MBUF_DYNFIELD(m, rte_eth_timesyn=
c_tx_slot_dynfield_offset,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; uint32_t *) =3D slot_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;ol_flags |=3D rte_eth_timesync_=
tx_slot_dynflag;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;RTE_EXPORT_SYMBOL(rte_eth_timesync_adjust_time)<br>
&nbsp;int<br>
&nbsp;rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)<br>
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h<br>
index ee400b386f..339c39fcdd 100644<br>
--- a/lib/ethdev/rte_ethdev.h<br>
+++ b/lib/ethdev/rte_ethdev.h<br>
@@ -5528,6 +5528,114 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t por=
t_id,<br>
&nbsp;int rte_eth_timesync_read_tx_timestamp(uint16_t port_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct timespec *timestamp);<br>
&nbsp;<br>
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.adjusted_ns. */<b=
r>
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID&nbsp; RTE_BI=
T32(0)<br>
+/** Valid bit for rte_eth_timesync_dual_domain_timestamp.cycles_ns. */<br>
+#define RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_CYCLES_VALID&nbsp;&nbsp;&nb=
sp; RTE_BIT32(1)<br>
+<br>
+/**<br>
+ * Dual-domain TX timestamp payload.<br>
+ */<br>
+struct rte_eth_timesync_dual_domain_timestamp {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t adjusted_ns;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t cycles_ns;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t valid_mask;<br>
+};<br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this API may change without prior notice.<br>
+ *<br>
+ * Allocate a TX timestamp slot handle for per-packet correlation.<br>
+ *<br>
+ * @param port_id<br>
+ *&nbsp;&nbsp; The port identifier of the Ethernet device.<br>
+ * @param tx_queue_id<br>
+ *&nbsp;&nbsp; TX queue used by the packet to be transmitted.<br>
+ * @param slot_id<br>
+ *&nbsp;&nbsp; Output handle identifying the allocated slot.<br>
+ *<br>
+ * @return<br>
+ *&nbsp;&nbsp; - 0: Success.<br>
+ *&nbsp;&nbsp; - -ENODEV: The port ID is invalid.<br>
+ *&nbsp;&nbsp; - -EIO: if device is removed.<br>
+ *&nbsp;&nbsp; - -ENOTSUP: The function is not supported by the Ethernet d=
river.<br>
+ *&nbsp;&nbsp; - -EINVAL: Invalid parameters.<br>
+ */<br>
+__rte_experimental<br>
+int rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t tx_queue_id, uint32_t *slot_id);<br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this API may change without prior notice.<br>
+ *<br>
+ * Read a per-packet TX timestamp using a previously allocated slot handle=
.<br>
+ *<br>
+ * @param port_id<br>
+ *&nbsp;&nbsp; The port identifier of the Ethernet device.<br>
+ * @param slot_id<br>
+ *&nbsp;&nbsp; Slot handle returned by rte_eth_timesync_tx_timestamp_slot_=
alloc().<br>
+ * @param timestamp<br>
+ *&nbsp;&nbsp; Output dual-domain timestamp payload.<br>
+ *<br>
+ * @return<br>
+ *&nbsp;&nbsp; - 0: Success.<br>
+ *&nbsp;&nbsp; - -EAGAIN: Timestamp is not ready yet.<br>
+ *&nbsp;&nbsp; - -ENODEV: The port ID is invalid.<br>
+ *&nbsp;&nbsp; - -EIO: if device is removed.<br>
+ *&nbsp;&nbsp; - -ENOTSUP: The function is not supported by the Ethernet d=
river.<br>
+ *&nbsp;&nbsp; - -EINVAL: Invalid parameters.<br>
+ */<br>
+__rte_experimental<br>
+int rte_eth_timesync_read_tx_timestamp_slot(uint16_t port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t slot_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_timesync_dual_domain_timestamp *timestamp);</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">How is the egress =
port information conveyed?</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 11pt; color: rgb(0, 0, 0);">
The timestamp slot is a resource of the physical egress port.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this API may change without prior notice.<br>
+ *<br>
+ * Release a previously allocated TX timestamp slot handle.<br>
+ *<br>
+ * @param port_id<br>
+ *&nbsp;&nbsp; The port identifier of the Ethernet device.<br>
+ * @param slot_id<br>
+ *&nbsp;&nbsp; Slot handle to release.<br>
+ *<br>
+ * @return<br>
+ *&nbsp;&nbsp; - 0: Success.<br>
+ *&nbsp;&nbsp; - -ENODEV: The port ID is invalid.<br>
+ *&nbsp;&nbsp; - -EIO: if device is removed.<br>
+ *&nbsp;&nbsp; - -ENOTSUP: The function is not supported by the Ethernet d=
river.<br>
+ *&nbsp;&nbsp; - -EINVAL: Invalid parameters.<br>
+ */<br>
+__rte_experimental<br>
+int rte_eth_timesync_tx_timestamp_slot_release(uint16_t port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t slot_id);<br>
+<br>
+/** Mbuf dynfield name for the TX timestamp slot handle. */<br>
+#define RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME &quot;rte_eth_timesync_tx_s=
lot&quot;<br>
+<br>
+/**<br>
+ * @warning<br>
+ * @b EXPERIMENTAL: this API may change without prior notice.<br>
+ *<br>
+ * Stamp an mbuf with a TX timestamp slot handle so the TX path steers the=
<br>
+ * NIC to capture the timestamp in the correct per-packet slot.<br>
+ *<br>
+ * Must be called after rte_eth_timesync_tx_timestamp_slot_alloc() and bef=
ore<br>
+ * rte_eth_tx_burst(). Safe for concurrent callers =97 slot is stored per-=
mbuf.<br>
+ *<br>
+ * @param port_id&nbsp; The port identifier (unused; reserved for future P=
MD use).<br>
+ * @param slot_id&nbsp; Slot handle from rte_eth_timesync_tx_timestamp_slo=
t_alloc().<br>
+ * @param m&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mbuf to stamp.<br>
+ * @return 0 on success, -ENOTSUP if dynfield registration failed.<br>
+ */<br>
+__rte_experimental<br>
+int rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t slot_id, struct rte_mbuf *m);<br>
+<br>
&nbsp;/**<br>
&nbsp; * Adjust the timesync clock on an Ethernet device.<br>
&nbsp; *<br>
--<br>
2.54.0<br>
<br>
</div>
</body>
</html>

--_000_IA3PR11MB013943F03F187EFFF422F08B94A1A42IA3PR11MB013943_--
