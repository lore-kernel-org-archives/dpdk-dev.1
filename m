Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB91C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 16:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C33F4025D;
	Fri,  9 May 2025 18:24:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 506864025A
 for <dev@dpdk.org>; Fri,  9 May 2025 18:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746807886; x=1778343886;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HdxgrLYaDFTiZbz00ryJ30ivar3VYZzbh1qgH0r3LII=;
 b=GtgqB+bD4RvEt6fqIxUY/q3ugJ+zNiPV1MI4u5ATrqO50xZ0tK/COsWN
 oC2/2pHs6SiHwzVxePHAnJj3R0MmUrpRMfvpHV/UULCmHZ4SGjD+wmcJ6
 YASgweZnwyEVjRsJ3TXrSe/+L5FQhRGxPQU+WLICGkqhQAyctCfkT2nib
 2XIVpvc+KKai/FhmI9epeyMt800CYowSA5cxPl0x73rZDXsnXcinkHy3+
 cpOht0Q5z6+22esiTi4iqyOCQ/UHLP6uArIzyO24JqosuWhGgDh8jkqqz
 rNtg9O1f94OhCk2kuvYtIiKjXNe1cOdA5Ces1Z7+MeaPzUr4Sgnz1BYMC A==;
X-CSE-ConnectionGUID: AoDPfuQYQqGeSSImj4UXzA==
X-CSE-MsgGUID: jw6bMjGnRdaXKUmYdnOjfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52296198"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="52296198"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 09:24:45 -0700
X-CSE-ConnectionGUID: hRpij74OQtKcsCJe2wjPjw==
X-CSE-MsgGUID: FfKYeSorRECVmD/uxInrhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="136611321"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 09:24:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 09:24:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 09:24:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 09:24:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhS16U1OeBRbIKZ0b6TLOvLcvMjApokmvpnCjq+TyaAg6VG51GiFynxRQYPO9WrVHiZjjuHbl6NQ/IXLq8ES7fD+vhdoB9KZbS2jycBZO7afCX7JVX0PwJqvcVNn22hISD6IdobuwGSzcWMzvEQiX9gzQR8dOFVQUd6FY69Fj5musqatUaR3VZprphJjzCH8ZtoLIU8RDZk6FcBLck1D/xHxD2OWd7BZp2KXTOAE78y2ktU0Qr4Ci5bxNy10WKRqbkml2SkznIeqZbMObh30MbSg7YXzIkjTcZi9vdeXRRAFgBrvjYDhQzKUshacpAWtRVOlBlZWkiQih/4GcuCb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLdUq0ffLknkSlsR42yl+pO0VepiOpspXAsxBjWvy1w=;
 b=UKyb7oAKrIEqAfaMfNgWj6EPIB4xHYuU4PKveR44N1e+LEV9ANXff6xxYlnb9g0SDIMBa18/4blgUUbSHEp+My1qK9HlWabgxcvgqgVB2uVHZV4AqqZaCpd8hhc8HTLGfIj/sd2LO2vGZZ5qf40rrT+/iNJOtqCRMmkcjAuw+G/euXeiKGQ38QNiHSuVAVUxw9m2QQgnunblhdpkadFesMV0d34+mnrLpnL5jrp9NM2eS2wjPGQnAfsohrlJ1D25yDhHM7I6sIyCXfF2JGFVdYWdM79o+Br74jz9puM42FTjI3RqasjhLvHGBlC16gyya9lk213/er8mKa7vmZWSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 16:24:39 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%7]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 16:24:39 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: Owen Hilyard <Owen.Hilyard@unh.edu>, "Etelson, Gregory"
 <getelson@nvidia.com>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r3ow4K3xJ6vUu8VgAr7QGxzrOoNgYAgAEJ8vWAAwUpAIAGmn3LgAULbgCABLEMgIAA3kCAgAHmrICAAAsp6YAB0fOAgASR+2OAA7lKAIAA71QJ
Date: Fri, 9 May 2025 16:24:38 +0000
Message-ID: <PH8PR11MB6803FD2723BE0ECE7DBB44C8D78AA@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
 <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
 <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
 <a1161f7d-1a55-6200-7440-d615d5a41a6c@nvidia.com>
 <PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <DM8P223MB038323681A4BEA771CF92A6D8D8D2@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
 <PH8PR11MB6803AD18258A79734D9ABD79D789A@PH8PR11MB6803.namprd11.prod.outlook.com>
 <DM8P223MB038399660EAB15CCEC365A868D8BA@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
In-Reply-To: <DM8P223MB038399660EAB15CCEC365A868D8BA@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|SJ0PR11MB4815:EE_
x-ms-office365-filtering-correlation-id: 10945039-6359-4182-b17e-08dd8f15feed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LsmAzFs2RWdf70ebsyFwWNfAu/8KpR7t8ADROlK/2fAcRjfzLSV5ZF0kdN?=
 =?iso-8859-1?Q?1u/Zm6VHdZUeDwBmxUDeG+Micb5oczaZq4dSYVWtB6oBWirBAAhfmeG5Nn?=
 =?iso-8859-1?Q?ppyWGLl1o8H9YoVjs2FzjdpnujxXCgIeHnkC6kj4VwDGMk18VUSOIjthxi?=
 =?iso-8859-1?Q?3yOnp/t+a1RNn12J1Sk1pmNySFjxAb9/87rh6lu6xTZFRo5MlBRKJN3DPg?=
 =?iso-8859-1?Q?OIcfsJav/EwGmSHNwG3G3Ue88ptzYSkM+fTGj/ORbObnG5CTdxdl0N4mnx?=
 =?iso-8859-1?Q?OYtxKNLuNm1I9592FykjeDU/ceZFUA4W4MGleCm1J8eATg7DjD7o2Cs4Te?=
 =?iso-8859-1?Q?K2cDGVmi7A2pzOEsgnLwTS4AbjgpwpDjyO56bI+xCSO+4/ujOOjZrb5ken?=
 =?iso-8859-1?Q?oKQ1lUz+yOeIc/abFocSA3+R0EyS9rqTxU6SiTbHuSkJuo6QAbputgfb8r?=
 =?iso-8859-1?Q?IZR8IfTAH3Hhs4xOz6jkp/cPmyqd4h6owTytDjCv+7Zw57UirgqXERM0LQ?=
 =?iso-8859-1?Q?50cxOAeJJD4rrfIcL3ZilX7h9JhXseLePfm8T2DTtteeaosilT7qRCrJKz?=
 =?iso-8859-1?Q?UPVH4bSdsKbkzx+V/W3FSOe2j/QXs3oQqrcJQXwKkLno7b/D2aIFa+tJfR?=
 =?iso-8859-1?Q?teIFdhIj2lpn2uT+eXlKvejVL7ZvRz2uP8ZywoM8NVwkJvbuKvEDLBVVZU?=
 =?iso-8859-1?Q?jLNXLst0xWTrvKmpbD2IKWMCnblfunLh1/pOEgV/o+QVaYGqAFH34ZVy1U?=
 =?iso-8859-1?Q?kZ6rDxhs7R0fqopM/gNAqqaHe6N4YE9r2YUpc/Fuua/QXLvCLmKWRLy6sr?=
 =?iso-8859-1?Q?D4wp3MZ5idiTa6/Bmqds7KvSicIGaDE3nLi0koNq+D4mXYKPPK+OX2TqMe?=
 =?iso-8859-1?Q?fmfKWnsxL4gMVnNbLGKh9LkE/0YuC/FbE5gS1G+X7QlKdBP3c89u3JBOcO?=
 =?iso-8859-1?Q?DL9jwZjnWsL2GJ142NcBzdSsh9K0WwewNb07yvbU9KId5arawGqPsiEXI8?=
 =?iso-8859-1?Q?tQtzQaSDmaJn9waoo5DSZhC3oQtQDJQE/D6mWlb3WNhELTA8d8DEp49bcX?=
 =?iso-8859-1?Q?yRRhPTHgcG7E/oooHt7MCi7uIdpvHti/hrams0HzzJTgX+IH1sKrs3LUJW?=
 =?iso-8859-1?Q?P0Id2SxlM9TXLKya3OR1CUN4Pm1Xfhw+jz31fkMdleyjmCP4HgOTEYHtfG?=
 =?iso-8859-1?Q?wwl2Buxvwik51nQtm1+e/X6BtGxShROXRnOsWU7a8kTXxGr7D2cVZdHnO7?=
 =?iso-8859-1?Q?OeFngVSmJEweygHB6q9BZ1rlJkBAm2TVVSxklsq+DIt5eCiQAdZ0EaYFUM?=
 =?iso-8859-1?Q?jIWbRW/lDzB+daEk6pmucMUsY7HAjA7P3D98BGknCjIT2milFm/HaAWxaH?=
 =?iso-8859-1?Q?mDNBbUb0HlwsIZ0YDKdHm5Hj/kFYHgACOfxtrxMgekX5mlvx9BvalOHNrj?=
 =?iso-8859-1?Q?LZhgkgC6uUfWGPt81Z4oBeZpZ1H4yr2/dQdQuu0C7jMTTrwPAT/aav7kp7?=
 =?iso-8859-1?Q?k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZujAgdMXE4Eytj5i4Xo7X61caDQcywdZCpqloWItgCK99UpJnpKlDg2GCN?=
 =?iso-8859-1?Q?FWphZmqcuPgkFQewG6gjcrMS/iB+Z0VJ8wsk0b1dMLXd7cA522oBsL5jIa?=
 =?iso-8859-1?Q?/PcdLxxlOPQmpT6y+BN+d9doDKP7cBkAKoZfoAPCXyHz5rNuNhNHWF9h8G?=
 =?iso-8859-1?Q?I3OHJUMziJrxWwJdb0TpsZpayDsTykx02M6MZ1ga+wMZfH9aZJQm6UrZ9D?=
 =?iso-8859-1?Q?RSB6xHTF5KVg9ne/cHsYo2u6XBixboioonSCB5MD6cTP7FH/A1mHbk+9GX?=
 =?iso-8859-1?Q?3tDHnO+F+rs0Z+mgxBe75n2uNEoY17NZhBNsU4Hp3Bk0/H8oyWpRWXOdXE?=
 =?iso-8859-1?Q?4E/5X2wax4JztfFKzUGlOHB+gr6FRUix3AqQL0rxPKwAhR7ZpEP2vckZ77?=
 =?iso-8859-1?Q?cdwHsw9hq80/iYISiFU2dqKgzWJc7TWD6uWd+mdDSUVsLYuwfzc/HoFNS7?=
 =?iso-8859-1?Q?LKbptWiEYOUF1rHLd9atrN8i/S7Vdix0rTynkW0Yl1sNnjCQsAaS7a7U6X?=
 =?iso-8859-1?Q?FZ/r6NU8Gvtx8ukNqiLk/YqjmlvOs59Qy+lJfAEvxY8GFLHiLR64rFMZ3b?=
 =?iso-8859-1?Q?8uh3rIerynCBoQIw8O7lTnSvC7cYz8946Zkgbn8Tj2gyIDo+qgqB9wxnkN?=
 =?iso-8859-1?Q?RFfhYGi+xERWWkGNFu1MxOB+2jk8sjBSzopkc7hc+paZZDfP1gS1JckXVU?=
 =?iso-8859-1?Q?P27lpdDgYFyI5TxRWdPk5to7f/BQinMO/eZLkl06nCqbEAwKAsk2t3fbO0?=
 =?iso-8859-1?Q?oTcND8Vqc1HZUsGsppMVTzUBuXBoDD7QH07PVmNcnETIOgiFSmZBf9B2Fa?=
 =?iso-8859-1?Q?vsnThJcNV3OeLa51QEn751eadX/UrO0/va7CymMo6cJ2hH6lSwTefWVFQL?=
 =?iso-8859-1?Q?XSYUjxGkg0U2JsXKqumSdvRG8NWlk3nrG0XkF0/yC3ymRjyLtTf1QxXOxR?=
 =?iso-8859-1?Q?8H84dSpcTM7mtL3yj7RQUeKlPky1G5uzmlQajq1nrDhCjyS1FE9xAnnNIb?=
 =?iso-8859-1?Q?GY/VoPZ/Rw935d2lkS7AL6Mvg0G8YK2E9XDGwpso6Z/L7S/tIdFFj2hg6H?=
 =?iso-8859-1?Q?MZOhJXsNJ5ZPoGZ/Ab2rziA1gsNBse9jwrXiJs0ASLZeZfzrDW1QOxk+So?=
 =?iso-8859-1?Q?2oVfP5VOWTBlEvZLF7ub0opOVgTO9Pw8572SI3+CyFLRJ+H1TQyqLWR+Mu?=
 =?iso-8859-1?Q?y0J4uOzAGkkETNMv8w2cfGFCcUj2MP4BYpbCMBoKmd5G2OmV9Eqg6MhUcD?=
 =?iso-8859-1?Q?PxpTkxaHDvRpc8Xyry0Xe/CVBTb6x5E6UB0zpqRU6vDb8TWS6cHwK9BQGG?=
 =?iso-8859-1?Q?I+mbHQxddOXjORVYl0ENlU3h6QaMgUVW6lYVbjcQJ1gZnB2fjY+NjoUqNr?=
 =?iso-8859-1?Q?BnuoZ8bs2FTOOynLLZdFb778peX0usuht2F59g6//8czRugRKq7jpnS1HA?=
 =?iso-8859-1?Q?D8SfzsRfch3eAaDwIpiIVli2q2ATSya8I8pKecp/iOfGejwzmiLG1860kc?=
 =?iso-8859-1?Q?ndNIJqn7tnbXKZL7SSMBFlNq8sURKVA/voptkRwMvQh+XFeuuFH2SEualM?=
 =?iso-8859-1?Q?mNQNKvQTB8M3OTGHP1t5Ilb7iIoTBi9bj7k9Qt1MoQkosxiqg9L6aRaJ/W?=
 =?iso-8859-1?Q?FA9BObVVu4kp1ZKXys/hW22I0yHBJX/cNV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10945039-6359-4182-b17e-08dd8f15feed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 16:24:39.0107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsJ4rmrHvzAZ+fwJRrip3ykQtkQxyw51MJL1mjUPylJMu1wbQYws8WXIHl1xUSNZztObYcw/d3uP1Y2yh6yHIXuJ/S4IhWVpa7zlRDosFIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
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

> From: Owen Hilyard=0A=
> Sent: Friday, May 09, 2025 12:53 AM=0A=
> To: Van Haaren, Harry; Etelson, Gregory; Richardson, Bruce=0A=
> Cc: dev@dpdk.org=0A=
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq=
=0A=
> =0A=
> > From: Van Haaren, Harry <harry.van.haaren@intel.com>=0A=
> > Sent: Tuesday, May 6, 2025 12:39 PM=0A=
> > To: Owen Hilyard <Owen.Hilyard@unh.edu>; Etelson, Gregory <getelson@nvi=
dia.com>; Richardson, Bruce <bruce.richardson@intel.com>=0A=
> > Cc: dev@dpdk.org <dev@dpdk.org>=0A=
> > Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and R=
xq=0A=
<snip>=0A=
> > Hi All!=0A=
> >=0A=
> > Great to see passionate & detailed replies & input!=0A=
> >=0A=
> > Please folks - lets try remember to send plain-text emails, and use  > =
 to indent each reply.=0A=
> >Its hard to identify what I wrote (1) compared to Owen's replies (2) in =
the archives otherwise.=0A=
> > (Adding some "Harry wrote" and "Owen wrote" annotations to try help fut=
ure readability.)=0A=
> =0A=
> My apologies, I'll be more careful with that.=0A=
=0A=
Thanks! The reply here is perfect.=0A=
=0A=
=0A=
> > Maybe it will help to split the conversation into two threads, with one=
 focussing on=0A=
> "DPDK used through Safe Rust abstractions", and the other on "future cool=
 use-cases".=0A=
> =0A=
> Agree.=0A=
> =0A=
> > Perhaps I jumped a bit too far ahead mentioning async runtimes, and whi=
le I like the enthusiasm for designing "cool new stuff", it is probably bet=
ter to be realistic around what will get "done": my bad.=0A=
> >=0A=
> > I'll reply to the "DPDK via Safe Rust" topics below, and start a new th=
read (with same folks on CC) for "future cool use-cases" when I've had a ch=
ance to clean up a little demo to showcase them.=0A=
> >=0A=
> >=0A=
> > > > > Thanks for sharing. However, IMHO using EAL for thread management=
 in rust=0A=
> > > > > is the wrong interface to expose.=0A=
> > > >=0A=
> > > > EAL is a singleton object in DPDK architecture.=0A=
> > > > I see it as a hub for other resources.=0A=
> >=0A=
> > Harry Wrote:=0A=
> > > Yep, i tend to agree here; EAL is central to the rest of DPDK working=
 correctly.=0A=
> > > And given EALs implementation is heavily relying on global static var=
iables, it is=0A=
> > > certainly a "singleton" instance, yes.=0A=
> >=0A=
> > Owen wrote:=0A=
> > > I think a singleton one way to implement this, but then you lose some=
 of the RAII/automatic resource management behavior. It would, however, mak=
e some APIs inherently unsafe or very unergonomic unless we were to force r=
te_eal_cleanup to be run via atexit(3) or the platform equivalent and forbi=
d the user from running it themselves. For a lot of Rust runtimes similar t=
o the EAL (tokio, glommio, etc), once you spawn a runtime it's around until=
 process exit. The other option is to have a handle which represents the st=
ate of the EAL on the Rust side and runs rte_eal_init on creation and rte_e=
al_cleanup on destruction. There are two ways we can make that safe. First,=
 reference counting, once the handles are created, they can be passed aroun=
d easily, and the last one runs rte_eal_cleanup when it gets dropped.  This=
 avoids having tons of complicated lifetimes and I think that, everywhere t=
hat it shouldn't affect fast path performance, we should use refcounting.=
=0A=
> >=0A=
> > Agreed, refcounts for EAL "singleton" concept yes. For the record, the =
initial patch actually returns a=0A=
> "dpdk" object from dpdk::Eal::init(), and Drop impl has a // TODO rte_eal=
_cleanup(), so well aligned on approach here.=0A=
> > https://patches.dpdk.org/project/dpdk/patch/20250418132324.4085336-1-ha=
rry.van.haaren@intel.com/=0A=
> =0A=
> One thing I think I'd like to see is using a "newtype" for important numb=
ers (ex: "struct EthDevQueueId(pub u16)"). This prevents some classes of er=
ror but if we make the constructor public it's at most a minor inconvenienc=
e to anyone who has to do something a bit odd.=0A=
> =0A=
> > > Owen wrote:=0A=
> > > The other option is to use lifetimes. This is doable, but is going to=
 force people who are more likely to primarily be C or C++ developers to di=
ve deep into Rust's type system if they want to build abstractions over it.=
 If we add async into the mix, as many people are going to want to do, it's=
 going to become much, much harder. As a result, I'd advocate for only usin=
g it for data path components where refcounting isn't an option.=0A=
> >=0A=
> > +1 to not using lifetimes here, it is not the right solution for this E=
AL / singleton type problem.=0A=
> =0A=
> Having now looked over the initial patchset in more detail, I think we do=
 have a question of how far down "it compiles it works" we want to go. For =
example, using typestates to make Eal::take_eth_ports impossible to call mo=
re than once using something like this:=0A=
> =0A=
> #[derive(Debug, Default)]=0A=
> pub struct Eal<const HAS_ETHDEV_PORTS: bool> {=0A=
>     eth_ports: Vec<eth::Port>,=0A=
> }=0A=
> =0A=
> impl<const HAS_ETHDEV_PORTS: bool> Eal<HAS_ETHDEV_PORTS> {=0A=
>     pub fn init() -> Result<Self, String> {=0A=
>         // EAL init() will do PCI probe and VDev enumeration will find/cr=
eate eth ports.=0A=
>         // This code should loop over the ports, and build up Rust struct=
s representing them=0A=
>         let eth_port =3D vec![eth::Port::from_u16(0)];=0A=
>         Ok(Eal {=0A=
>             eth_ports: Some(eth_port),=0A=
>         })=0A=
>     }=0A=
> }=0A=
> =0A=
> impl Eal<true> {=0A=
>     pub fn take_eth_ports(self) -> (Eal<false>, Vec<eth::Port>) {=0A=
>         (Eal::<false>::default(), self.eth_ports.take())=0A=
>     }=0A=
> }=0A=
> =0A=
> impl<const HAS_ETHDEV_PORTS: bool> Drop for Eal<HAS_ETHDEV_PORTS> {=0A=
>     fn drop(&mut self) {=0A=
>         if HAS_ETHDEV_PORTS {=0A=
>             // extra desired port cleanup=0A=
>         }=0A=
>         // todo: rte_eal_cleanup()=0A=
>     }=0A=
> }=0A=
> =0A=
> This does add some noise to looking at the struct, but also lets the comp=
iler enforce what state a struct should be in to call a given function. Tak=
en to its logical extreme, we could create an API where many of the "resour=
ce in wrong state" errors should be impossible. However, it also requires m=
ore knowledge of Rust's type system on the part of the people making the AP=
I and can be a bit harder to understand without an LSP helping you along.=
=0A=
=0A=
This is too much in my opinion. I know there's value, but the ergonomics su=
ffers significantly if we have generics over Eal.=0A=
I'd like to not treat Ethdev "differently" to other Devs. And if we give Et=
hdev a generic for EAL, then the others would too; exploding the generic co=
unts & complixity.=0A=
=0A=
Techie notes for eager readers; one can use this technique for compile-time=
 enforing lock-ordering (avoiding ABA deadlock)!=0A=
Thanks to Fuchsia OS, and Joshua Liebow-Feeser https://lwn.net/Articles/995=
814/,=0A=
and Angus Morrison for the simpler demo at https://docs.rs/lock_tree/latest=
/lock_tree/=0A=
=0A=
So this technique is really cool, but not the right tradeoff in this case.=
=0A=
=0A=
<snip>=0A=
=0A=
> > The key point above is "except where runtimes force them to mix". The D=
PDK rxq concept (struct Rxq in the code linked above) is !Send.=0A=
> > As a result, it cannot be moved between threads. That allows per-lcore =
concepts to be used for performance.=0A=
> =0A=
> The problem is that, with Tokio, it also can't be held across an await po=
int. I agree that !Send is correct, but the existence of !Send resources me=
ans that integration with Tokio is much, much harder. For PMDs with RTE_ETH=
_TX_OFFLOAD_MT_LOCKFREE, TX is fine, but as far as I am aware there is no e=
quivalent for RX. And, to safely take advantage of the TX version, we'd nee=
d to know the capabilities of the target PMD at compile time, which is part=
 of why my own bindings "devirtualize" the EAL and require a top-level func=
tion which dispatches based on the capabilities provided by the PMDs I make=
 use of. Glommio was easily able to integrate safely (theoretically Monoio =
would be too, although I haven't used it), but I haven't found a safe way t=
o mix Tokio and queue handles which doesn't make it nearly impossible to us=
e async, even when taking that fairly extreme measure.=0A=
> =0A=
> > The point I was trying to make is that we (the DPDK safe rust wrapper A=
PI) should not be prescriptive in how it is used.=0A=
> > In other words: we should allow the user to decide how to spawn/manage/=
run threads.=0A=
> >=0A=
> > We must encode the DPDK requirements of e.g. "Rxq concept" with !Send, =
!Sync marker traits.=0A=
> > Then the Rust compiler will at compile-time ensure the users code is co=
rrect.=0A=
> =0A=
> I agree that !Send and !Sync are likely correct for Rxqs, however, we als=
o need to be very careful in documenting the WHY of !Send and !Sync in each=
 context. For instance, how are we going to get the queue handles to the th=
reads which run the data path if we get all of them from an Eal struct in a=
 Vec on the main thread? We may need to have a way to "deactivate" them so =
the user can't use them for queue operations but they are Send, !Sync, emit=
 a fence, and then when the user "activates" them it performs another fence=
 to force anything the last thread did with the queue to be visible on the =
new core. I suspect we'll need to apply a similar pattern for other thread =
unsafe parts of DPDK in order to get them to where they need to be during e=
xecution.=0A=
=0A=
=0A=
Look at the patch, the difference between a RxqHandle and Rxq encodes exact=
ly what you're asking.=0A=
Gregory renamed the "change" function to .activate(), but the fundamental "=
consume struct and give back !Send pollable Rxq" is the same.=0A=
Agree we need things documented, but the C API docs should have that alread=
y, see the Rxq example as explained at Userspace: https://youtu.be/lb6xn2xQ=
-NQ?t=3D890.=0A=
=0A=
=0A=
> > I don't believe that I can identify all use-cases, so we cannot design =
requirements around statements like "I think X is more likely than Y".=0A=
> =0A=
> I agree, this is why unsafe escape hatches will be necessary. Someone wil=
l have some weird edge-case like a CPU with no cache that makes it fine to =
move Rxqs around with abandon.=0A=
=0A=
No need for unsafe, just not be prescriptive in how threading "should work"=
, just be flexible and allow the user to decide.=0A=
All the proposed DPDK-rs does is provides safe Rust structs that encode the=
 correct Send/Sync requirements, nothing more.=0A=
After that, any user can correctly use our APIs, and if it compiles, then i=
ts correct (from a threading POV).=0A=
Even users with "weird edge-cases like a CPU with no cache" will still work=
 correctly.=0A=
=0A=
=0A=
> > Harry wrote:=0A=
> > > Lets focus on Tokio first: it is an "async runtime" (two links for fu=
ture readers)=0A=
> > >     <snip>=0A=
> > > So an async runtime can run "async" Rust functions (called Futures, o=
r Tasks when run independently..)=0A=
> > > There are lots of words/concepts, but I'll focus only on the thread c=
reation/control aspect, given the DPDK EAL lcore context.=0A=
> > >=0A=
> > > Tokio is a work-stealing scheduler. It spawns "worker" threads, and t=
hen gives these "tasks"=0A=
> > > to various worker cores (similar to how Golang does its work-stealing=
 scheduling). Some=0A=
> > > DPDK crate users might like this type of workflow, where e.g. RXQ pol=
ling is a task, and the=0A=
> > > "tokio runtime" figures out which worker to run it on. "Spawning" a t=
ask causes the "Future"=0A=
> > > to start executing. (technical Rust note: notice the "Send" bound on =
Future: https://docs.rs/tokio/latest/tokio/task/fn.spawn.html )=0A=
> > > The work stealing aspect of Tokio has also led to some issues in the =
Rust ecosystem. What it effectively means is that every "await" is a place =
where you might get moved to another thread. This means that it would be un=
sound to, for example, have a queue handle on devices without MT-safe queue=
s unless we want to put a mutex on top of all of the device queues. I perso=
nally think this is a lot of the source of people thinking that Rust async =
is hard, because Tokio forces you to be thread safe at really weird places =
in your code and has issues like not being able to hold a mutex over an awa=
it point.=0A=
> > >=0A=
> > > Other users might prefer the "thread-per-core" and CPU pinning approa=
ch (like DPDK itself would do).=0A=
> > > nit: Tokio also spawns a thread per core, it just freely moves tasks =
between cores. It doesn't pin because it's designed to interoperate with th=
e normal kernel scheduler more nicely. I think that not needing pinned core=
s is nice, but we want the ability to pin for performance reasons, especial=
ly on NUMA/NUCA systems (NUCA =3D Non-Uniform Cache Architecture, almost ev=
ery AMD EPYC above 8 cores, higher core count Intel Xeons for 3 generations=
, etc).=0A=
> > > Monoio and Glommio both serve these use cases (but in slightly differ=
ent ways!). They both spawn threads and do CPU pinning.=0A=
> > > Monoio and Glommio say "tasks will always remain on the local thread"=
. In Rust techie terms: "Futures are !Send and !Sync"=0A=
> > > https://docs.rs/monoio/latest/monoio/fn.spawn.html    =0A=
> > > https://docs.rs/glommio/latest/glommio/fn.spawn_local.html=0A=
> >=0A=
> > Owen wrote:=0A=
> > > There is also another option, one which would eliminate "service core=
s". We provide both a work stealing pool of tasks that have to deal with be=
ing yanked between cores/EAL threads at any time, but aren't data plane tas=
ks, and then a different API for spawning tasks onto the local thread/core =
for data plane tasks (ex: something to manage a particular HTTP connection)=
. This might make writing the runtime harder, but it should provide the bes=
t of both worlds provided we can build in a feature (Rust provides a way to=
 "ifdef out" code via features) to disable one or the other if someone does=
n't want the overhead.=0A=
> >=0A=
> > Hah, yeah.. (as maintainer of service cores!) I'm aware that the "async=
 Rust" cooperative scheduling is very similar.=0A=
> > That said, the problem service-cores set out to solve is a very differe=
nt one to how "async Rust" came about.=0A=
> > The implementations, ergonomics, and the language its written in are di=
fferent too... so they're different beasts!=0A=
> =0A=
> I think we could still make use of the idea of separate pools of thread l=
ocal and global tasks.=0A=
> =0A=
> > We don't want to start writing "dpdk-async-runtime". The goal is not to=
 duplicate everything, we must integrate with existing.=0A=
> =0A=
> What do you picture someone who picks up "dpdk-rs" seeing as the interfac=
e to DPDK when it's fully integrated? Do they enable a feature flag in thei=
r async runtime and the runtime handles it for them, do they set up DPDK an=
d start the runtime? Most of the libraries I'm aware of assume the presence=
 of an OS network stack. Yes, there are some like smoltcp which are capable=
 of operating on top of the l2 interface provided by DPDK, but most are goi=
ng to want a network stack to exist on top of.=0A=
=0A=
DPDK-rs remains DPDK, and the Rust APIs remain at the same level of C APIs.=
=0A=
When I say "integrate with" I mean that DPDK-rs APIs should enable others t=
o build on top of it.=0A=
I reference some examples (eg SmolTCP, Tokio etc) because knowledge of how =
they could consume DPDK gives good context.=0A=
=0A=
I am NOT proposing that DPDK-rs includes more features than DPDK-via-C-API.=
=0A=
DPDK-rs is "just" a safe Rust interface to DPDK functionality.=0A=
=0A=
I am advocating that we understand how things integrate and try support/be-=
aware of those usages,=0A=
primarily to ensure that topics like threading can be resolved well. Yes ot=
her libraries expect a TcpListener,=0A=
and libraries like SmolTCP (or the DemiKernel Netstack, or FuchsiaOS's nets=
tack3, etc) may provide that bridge.=0A=
=0A=
But DPDK-rs is just DPDK: as first priority, a high-performance L2 ethernet=
 packet I/O library.=0A=
Due to Rust language features, we can build in safety via Send/Sync of stru=
cts, and nice API design.=0A=
To me, that's the goal for a minimal DPDK-rs release.=0A=
=0A=
=0A=
> > I will try provide some examples of integrating DPDK with other Rust ne=
tworking projects, to prove that it can be done, and is useful.=0A=
> >=0A=
> > Harry wrote:=0A=
> > > So there are at least 3 different async runtimes (and I haven't even =
talked about async-std, smol, embassy, ...) which=0A=
> > > all have different use-cases, and methods of running "tasks" on threa=
ds. These runtimes exist, and are widely used,=0A=
> > > and applications make use of their thread-scheduling capabilities.=0A=
> > >=0A=
> > > So "async runtimes" do thread creation (and optionally CPU pinning) f=
or the user.=0A=
> > > Other libraries like "Rayon" are thread-pool managers, those also hav=
e various CPU thread-create/pinning capabilities.=0A=
> > > If DPDK *also* wants to do thread creation/management and CPU-thread-=
to-core pinning for the user, that creates tension.=0A=
> > > The other problem is that most of these async runtimes have IO very t=
ightly integrated into them. A large portion of Tokio had to be forked and =
rewritten for io_uring support, and DPDK is a rather stark departure from w=
hat they were all designed for. I know that both Tokio and Glommio have "st=
art a new async runtime on this thread" functions, and I think that Tokio h=
as an "add this thread to a multithreaded runtime" somewhere.=0A=
> > >=0A=
> > > I think the main thing that DPDK would need to be concerned about is =
that many of these runtimes use thread locals, and I'm not sure if that wou=
ld be transparently handled by the EAL thread runtime since I've always use=
d thread per core and then used the Rust runtime to multiplex between tasks=
 instead of spawning more EAL threads.=0A=
> > >=0A=
> > > Rayon should probably be thought of in a similar vein to OpenMP, sinc=
e it's mainly designed for batch processing. Unless someone is doing some f=
airly heavy computation (the kind where "do we want a GPU to accelerate thi=
s?" becomes a question) inside of their DPDK application, I'm having troubl=
e thinking of a use case that would want both DPDK and Rayon.=0A=
> >>=0A=
> > > > Bruce wrote: "so having Rust (not DPDK) do all thread management is=
 the way to go (again IMHO)."=0A=
> > >=0A=
> > > I think I agree here, in order to make the Rust DPDK crate usable fro=
m the Rust ecosystem,=0A=
> > > it must align itself with the existing Rust networking ecosystem.=0A=
> > >=0A=
> > > That means, the DPDK Rust crate should not FORCE the usage of lcore p=
innings and mappings.=0A=
> > > Allowing a Rust application to decide how to best handle threading (v=
ia Rayon, Tokio, Monoio, etc)=0A=
> > > will allow much more "native" or "ergonomic" integration of DPDK into=
 Rust applications.=0A=
> >=0A=
> > Owen wrote:=0A=
> > > I'm not sure that using DPDK from Rust will be possible without eithe=
r serious performance sacrifices or rewrites of a lot of the networking lib=
raries. Tokio continues to mimic the BSD sockets API for IO, even with the =
io_uring version, as does glommio. The idea of the "recv" giving you a buff=
er without you passing one in isn't really used outside of some lower-level=
 io_uring crates. At a bare minimum, even if DPDK managed to offer an API t=
hat works exactly the same ways as io_uring or epoll, we would still need t=
o go to all of the async runtimes and get them to plumb DPDK support in or =
approve someone from the DPDK community maintaining support. If we don't of=
fer that API, then we either need rewrites inside of the async runtimes or =
for individual libraries to provide DPDK support, which is going to be even=
 more difficult.=0A=
> >=0A=
> > Regarding traits used for IO, correct many are focussed on "recv" givin=
g you a buffer, but not all. Look at Monoio, specifically the *Rent APIs:=
=0A=
> > https://docs.rs/monoio/latest/monoio/io/index.html#traits=0A=
> =0A=
> As far as I can tell, the *Rent APIs for Monoio have the same problem, th=
ey require you to pass in a buffer, and to satisfy that API we'd need to th=
row out zero copy, pass that buffer directly to the PMD, or do some weird t=
hing were we use that API to recycle buffers back into the mempool. I see, =
in Monoio terms, a DPDK API looking more like TcpStream::read(&mut self) ->=
 impl Future<Output =3D BufResult<usize, dpdk::PktMbuf>> or some equivalent=
 abstraction on top.=0A=
> =0A=
> > Owen wrote:=0A=
> > > I agree that forcing lcore pinnings and mappings isn't good, but I th=
ink that DPDK is well within its rights to build its own async runtime whic=
h exposes a standard API. For one thing, the first thing Rust users will as=
k for is a TCP stack, which the community has been discussing and debating =
for a long time. I think we should figure out whether the goal is to allow =
DPDK applications to be written in Rust, or to allow generic Rust applicati=
ons to use DPDK. The former means that the audience would likely be Rust-fl=
uent people who would have used DPDK regardless, and are fine dealing with =
mempools, mbufs, the eal, and ethdev configuration. The latter is a much la=
rger audience who is likely going to be less tolerant of dpdk-rs exposing t=
he true complexity of using DPDK. Yes, Rust can help make the abstractions =
better, but there's an amount of inherent complexity in "Your NIC can handl=
e IPSec for you and can also direct all IPv6 traffic to one core" that I do=
n't think we can remove.=0A=
> >=0A=
> > Ok, we're getting very far into future/conceptual design here.=0A=
> > For me, DPDK having its own async runtime and its own DPDK TCP stack is=
 NOT the goal.=0A=
> > We should try to integrate DPDK with existing software environments - n=
ot rewrite the world.=0A=
> =0A=
> Which existing software environments are you thinking of exactly? Most Ru=
st applications that use networking are going to be using Axum, Tower, and =
the other crates that you've mentioned, and all of those rely on having a T=
CP stack to be useful. I have found vanishingly few Rust crates which handl=
e integration with DPDK without me editing them to some degree. I'd like to=
 know where you're finding existing Rust software environments which don't =
care about the presence of a network stack but are still networking oriente=
d. If the goal is to take a DPDK application that would have been written i=
n C/C++ and write it in Rust instead, that is very different than taking an=
 application which would have happily used the OS network stack, such as an=
 HTTP server which deals with normal (<1k RPS) amounts of traffic, and movi=
ng it onto DPDK, and it seems to me like you are suggesting that we should =
focus on the latter.=0A=
=0A=
As above, DPDK-rs is for accelerated packet I/O. Perhaps with some offload =
features etc in future,=0A=
but fundamentally its a high-speed packet I/O library.=0A=
=0A=
Other libraries can build on top, I've done a small (sorry for the pun!) ex=
ample with SmolTCP,=0A=
and integrating DPDK into the "phy" device abstraction: it is not difficult=
. This provides a route=0A=
to TCP with high performance I/O under the hood...=0A=
=0A=
So you mention "HTTP is <1k RPS", that assumption is not correct in all cas=
es.=0A=
Use-cases like Next-Gen-FireWall (NGFW) and Reverse-proxy require L7 HTTP p=
rocessing.=0A=
Some even go as far as doing "TLS bumping" (aka MITM inspection; eg interna=
lly in a company network).=0A=
=0A=
In these cases, the requirement for L7 HTTP(s) parsing, TLS decrypt/DPI/cry=
pt is huge, with=0A=
DPDK levels of performance absolutely being required (or scaling to 100s of=
 boxes doing <1k RPS each!)=0A=
=0A=
I believe the above cases are not easily catered for, because the projects =
(e.g, Snort, Envoy)=0A=
were mostly designed in a pre-DPDK era, and hence expect kernel/FD based I/=
O. I believe that the lack=0A=
of clear C-API abstraction into L7/HTTP layers has stifled some of those pr=
ojects from consuming DPDK.=0A=
=0A=
So yes, DPDK-rs initially should focus on core priorities: L2 ethernet I/O.=
=0A=
But because the abstractions are more easily ported in Rust, ensuring we do=
n't "design out" these=0A=
other use-cases is very important to me - I believe it can expand the poten=
tial use-cases for the=0A=
core DPDK functionality (Ethdev and the PMDs) a lot.=0A=
=0A=
=0A=
> > Owen wrote:=0A=
> > > I personally think that making an API for DPDK applications to be wri=
tten in Rust, and then steadily adding abstractions on top of that until we=
 arrive at something that someone who has never looked at a TCP header can =
use without too much confusion. That was part of the goal of the Iris proje=
ct I pitched (and then had to go finish another project so the design is st=
ill WIP). I think that a move to DPDK is going to be as radical of a change=
 as a move to io_uring, however, DPDK is fast enough that I think it may be=
 possible to convince people to do a rewrite once we arrive at that high le=
vel API.=0A=
> >=0A=
> > I haven't heard of the Iris project you mentioned, is there something c=
oncrete to learn from, or is it too WIP to apply?=0A=
> =0A=
> I have some design docs, but nothing concrete. I got pulled back to anoth=
er project which is still ongoing shortly after I gave the talk at the last=
 DPDK summit. The main goal of Iris is to provide a DPDK-based alternative =
to something like a gRPC with a message-based API instead of a byte-based o=
ne, and to take advantage of the massive amount of extra breathing room und=
er that new API (as compared to TCP) to plumb in the various accelerators i=
ntegrated into DPDK alongside a network stack. It's based on observations t=
hat many developers aren't even working at a TCP or HTTP level any more, bu=
t are instead using "JSON RPC over HTTPS which is automatically converted i=
nto objects by their HTTP server framework" or something like gRPC to have =
a "send message to server" and "get message to server" API. Most of what I =
have for that is a lot of time spent thinking about a Rust-based API on top=
 of DPDK as a foundation for building the rest of the network stack on top.=
=0A=
=0A=
Wauw, big project goals; interesting. (Techie note, checkout Zenoh, and che=
ck how SmolTCP allocates its rx/tx buffers allocated in hugepages, lots of =
cool potential here!)=0A=
=0A=
As above, I think DPDK-rs should focus on "Safe L2 packet I/O" for Rust. So=
 while "cool stuff" above, my focus is on a good/safe L2 API first and fore=
most.=0A=
=0A=
=0A=
> > Owen wrote:=0A=
> > > "Swap out your sockets and rework the functions that do network IO fo=
r a 5x performance increase" is a very, very attractive offer, but for us t=
o get there I think we need to have DPDK's full potential available in Rust=
, and then build as many zero-overhead (zero cost or you couldn't write it =
better yourself) abstractions as we can on top. I want to avoid a situation=
 where we build up to the high-level APIs as fast as we can and then end up=
 in a situation where you have "Easy Mode" and then "C DPDK written in Rust=
" as your two options.=0A=
> >=0A=
> > My perspective is that we're carefully designing "Safe Rust" APIs, and =
will have "DPDKs full potential" as a result.=0A=
> > I'm not sure where the "easy mode" comment applies. But lets focus on c=
ode - and making concrete progress - over theoretical discussions.=0A=
> >=0A=
> > I'll keep my input more consise in future, and try get more patches on =
list for review.=0A=
> > > > Regards,=0A=
> > > > Gregory=0A=
> > >=0A=
> > > Apologies for the long-form, "wall of text" email, but I hope it capt=
ures the nuance of threading and=0A=
> > > async runtimes, which I believe in the long term will be very nice to=
 capture "async offload" use-cases=0A=
> > > for DPDK. To put it another way, lookaside processing can be hidden b=
ehind async functions & runtimes,=0A=
> > > if we design the APIs right: and that would be really cool for making=
 async-offload code easy to write correctly!=0A=
> > >=0A=
> > > Regards, -Harry=0A=
> > >=0A=
> > > Sorry for my own walls of text. As a consequence of working on Iris I=
've spent a lot of time thinking about how to make DPDK easier to use while=
 keeping the performance intact, and I was already thinking in Rust since i=
t provides one of the better options for these kinds of abstractions (the o=
ther option I see is Mojo, which isn't ready yet). I want to see DPDK becom=
e more accessible, but the performance and access to hardware is one of the=
 main things that make DPDK special, so I don't want to compromise that. I =
definitely agree that we need to force DPDK's existing APIs to justify them=
selves in the face of the new capabilities of Rust, but I think that starti=
ng from "How are Rust applications written today?" is a mistake.=0A=
> > >=0A=
> > > Regards,=0A=
> > > Owen=0A=
> >=0A=
> > Generally agree, but just this line stood out to me:=0A=
> > > Owen wrote:   I think that starting from "How are Rust applications w=
ritten today?" is a mistake.=0A=
> >=0A=
> > We have to understand how applications are written today, in order to u=
nderstand what it would take to move them to a DPDK backend.=0A=
> > In C, consuming DPDK is hard, as applications expect TCP via sockets, a=
nd DPDK provides mbuf*s: that's a large mismatch. (Yes I'm aware of various=
 DPDK-aware TCP stacks etc.)=0A=
> >=0A=
> > In Rust, applications expect a "let tcp_port =3D TcpListener::bind()", =
and then to "tcp_port.accept()" incoming requests.=0A=
> > Those requirements can be met by: std::net::TcpListener, tokio::net::Tc=
pListener, and in future, some DPDK (SmolTCP?) based TcpListener.=0A=
> > - https://doc.rust-lang.org/std/net/struct.TcpListener.html=0A=
> > - https://docs.rs/tokio/latest/tokio/net/struct.TcpListener.html=0A=
> >=0A=
> > The ability to move between abstractions is much easier in Rust. As a r=
esult, providing "normal looking APIs" is IMO the best way forward.=0A=
> =0A=
> Yes, moving between abstractions is easier in Rust, but I think that the =
abstraction provided by std::net::TcpListener and tokio::net::TcpListener i=
s flawed. I'm not sure there is a good way to provide a "normal" API withou=
t fairly serious performance compromises. For example, as I'm sure everyone=
 here is aware, the traditional BSD sockets API requires double the memory =
bandwidth that a zero-copy one does on the rx path. Those APIs also ignore =
TLS, meaning that we would actually need to go look at a wrapper over rustl=
s or some other TLS implementation as what users interact with. I can keep =
going up levels, but this is why I decided to put the highest level of abst=
raction in Iris, the one I intend most people to interact with at "get this=
 blob of bytes over to that other server as a message, possibly encrypting =
it, compressing it, doing zero trust checks, etc". I'm not sure if applicat=
ions expect a TcpListener, so much as an HttpListener, or a JsonRPCListener=
. I think it would be wise to determine what type of API people would want =
for a dpdk-rs, rather than making an assumption that they want something li=
ke BSD sockets. Even inside of the kernel io_uring has been breaking away f=
rom that API with an API that looks a lot more like what I would expect fro=
m DPDK, and providing ergonomics benefits to users while doing it.=0A=
> =0A=
> > Regards, and thanks for the input & discussion. -Harry=0A=
> =0A=
> Thanks for the discussion, and I hope to continue to work with all of you=
 on this,=0A=
> Owen=0A=
=0A=
Thanks, good input! Regards, -Harry=
