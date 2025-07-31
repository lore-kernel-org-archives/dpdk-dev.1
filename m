Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EA4C87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 09:24:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08A3E4026A;
	Thu, 31 Jul 2025 11:24:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A36F44025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 11:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753953865; x=1785489865;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/ByyxxfTiYo0kKMkuwCqY7oVwej5eTUd8OgiJEJlbzQ=;
 b=G/ysHQw1pYE5MDhPehqCLG4UICkSXNZ0XKhia0Mpg8i1bBCRxIgOrVnr
 BIpgn9msvZb1Zgf2D5rHDcAal2VwUbiLSGucIzkfc8W6W4ubZKVoL1j1s
 OON9wLTvw5dHnEZcx+nJtT5qjmg4fYxOKjkUZvyqpM8SY74WscouAEeNV
 /oEkaPbzUTx/xxraWKOenVg8EJYAgPT7su5FjtGexpJzeRDcpR2Ms5JGr
 mDB2bgi3STn6AdNSJGI4qh6sae2Xm6QngTtPWk5VNye9YrIlNyyNYLVsv
 OVA51syYsYb/PfCKGu0tG4+IYQNWCnnGYOiQdk3yjDrmo/YiEk4Ih0lUr A==;
X-CSE-ConnectionGUID: CYLqO5HIQOW3of+mWxGdBA==
X-CSE-MsgGUID: ux5PGpCbSOK8at5D6UIJDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55339368"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="55339368"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 02:24:22 -0700
X-CSE-ConnectionGUID: rBb0JHQrRDGjBnIZoW0Pzg==
X-CSE-MsgGUID: BIqRy+SpQzO/AYV+KJYrNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="200384577"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 02:24:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 02:24:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 02:24:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 02:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d34yQYjpJcLtEwa+AQyKJw5eOxxJrgxohIGkHDFFGNG+5UDaIBcgPaaRkjzqAr1pg1le1FVFH+dTiKFbTNRuBlbqJOq4uaaqJmYiBKK1unFUHHtO9RsfS8I3eMBGkDwq6y/S2LIX0MsWk8jxdCpF9KSYbcvrN944invESHow8X/NtrOuZcWKjpDygRK3/w2ovFnrrjT2tqVEWGJxQZAMSPjVdEoNFTcvom5NF0IvdVPHkayBu1/cbhDJ7AQDlHNkRrG3lYPO4VT6brAoCRgAbzli/MhQvXjesywgNyc07LCUboPVCRYADd4MXHMeX9c7dnxh7JSDe07QRqnlfqtJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27ncQJAsXO/flrUwbkfZLgvMFgjfrRcl+2fUfuq4gWk=;
 b=a71x9MODKN7BE8MJsNr0GY1Dis3rdoyNTuL/5Cs3+IVconAes2jh4nieFWFMW40xOK734GhgrF+PHoQcOs1Ri8wqh23clr7m9/4RyKWyBRUbqzd+NwjYQQCyZzTcRI2UUWSd3RJNW8m53PIJ+o5FwgkOlipZaARtjxANljhdzfTlQooqEMZqwWkflm1pt3nfhKbEldu+VfOcLEeGZy5egVkknBVulE6Y/w5XGFffFEyNvCwJLQfcWNOxFR6uyZFtMD9858rXdfNfj3bEp77qVeQW//r4z05TZy7EDI7smAUAbmGAhRrhpM1/q46ey+dFIPj9+EvffabqlUqoaSUkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 09:24:17 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 09:24:16 +0000
Date: Thu, 31 Jul 2025 10:24:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] ethdev: Reject conflicting TX offloads configuration
Message-ID: <aIs2O169emw39bQZ@bricha3-mobl1.ger.corp.intel.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731090731.671589-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0211.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::24) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH0PR11MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d4773f-a9b9-40e4-eb3f-08ddd014058e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4rEkmOGslE3owfyhlBdVB5Nl13RY4SttxevB6CfK21yNu9mGIjFmknVJFT?=
 =?iso-8859-1?Q?RPeePVzxOG7T88m+G2kam320Nm/rc7jVHVdnS+v992fY+eYj3Xka38GoIO?=
 =?iso-8859-1?Q?yGIRMWoHoYKu3jGVt0TAgm+MZDHKiavA3vvCHu+FLowy+qseW/FU0J/W52?=
 =?iso-8859-1?Q?233GzUUrwQvhTEb8ZQOa1Cw0HyholKtYhHBql33p/zinvH6Fya+bPr3G9P?=
 =?iso-8859-1?Q?+6wZfJq5+sFLnXfkv/U93MbW9vaoJfLQLUmL0DyLqhG5dAmDSlJdVQaywQ?=
 =?iso-8859-1?Q?Yi9/9LY/5krSk8HamLwGt5dOQ/t73rBMzMPOORRMqvNXMYxbO86XHTcRUQ?=
 =?iso-8859-1?Q?HCVIGXUP/tzUEwLsB4hcgWE8tt1KZJoeJWoOPQaCXdNgLsLolbq4FE0BVz?=
 =?iso-8859-1?Q?ytIjRcO6fQabWekLYX6wOitb+O7d3vLVXlC2moLCAW7u3xQiuMsc88HVTV?=
 =?iso-8859-1?Q?XseaWBX5r+IdsE51wOxmpQDsy4VxsAO2NG8OS/OKpZoKSloWVQe2tWT9NA?=
 =?iso-8859-1?Q?ChSIKhcXradcRUWXkGIo+Y4kxutbuVfoOUpXT7QjvXwqPonFIuyQN+Tbt8?=
 =?iso-8859-1?Q?6N0r34KqJD5j8awlTnOc2l3H19j4Rybnw6ECBqBe7drztK5b8BEo9JaN0Q?=
 =?iso-8859-1?Q?6qDmruDdz90Bq/WdMadzr6NalCpq8aNLaHDU8jL+VNvJ71kdoBBLmMzG7k?=
 =?iso-8859-1?Q?wx9jWIzsqJpZNFO7CCEPPRyZhLTxyW4xIdNigtuFA4BkAcNffYVzThCNzt?=
 =?iso-8859-1?Q?OnSWq9ypzoDv4/gTz0ZpkH+FjfXBVMmv14IwIqFPUA81dVm6hFbezWJz0K?=
 =?iso-8859-1?Q?Cd2RxjI87d0VHN0erExU/nueH0K5Rhq5qJUm0/1+dqLP+gx5BC8qDDYhD6?=
 =?iso-8859-1?Q?mhr4d4z0gbmmI9vMTanYriR5MvUR2MSL+GU/gOJ1u3wBIoDwo6F/HxRqAP?=
 =?iso-8859-1?Q?x/1kB6cG4tI2obYvNCtOt712e8YItGH57B2dd6eXE+zpWvkJ+EynR3W1HC?=
 =?iso-8859-1?Q?p8sBwTfWSr5GtLoNw3+AF5U7IJkAoenobF6/BxZvMVpthOgDIYxOMI0dOH?=
 =?iso-8859-1?Q?kPlK9ADldZ1B1MZlGN3v2cEIRH+T/1oGV+uKZNZpOljz6U7rkLIWpm4nXm?=
 =?iso-8859-1?Q?4udXW8flcDHvqClTM4pH1xeRhGQzPF+5vNjVtvNysXh8VrMvYGm8NDttzI?=
 =?iso-8859-1?Q?Pn8jSUbOX8O7kKK38crXB30gDwbujnkQ0k3sodq7e5iQI4TS0jpN9xmqvl?=
 =?iso-8859-1?Q?sliYNwCfUsL9bhYUFUeBc8HwVcvlIYIrkNt7J3ATAQxUyKI6ZXP8VchrPh?=
 =?iso-8859-1?Q?cturir0wRMqqhTKuhbVVtkabpr57dUx/NTOeIpAxmhceMKBch/UIeqkBru?=
 =?iso-8859-1?Q?L/cgpPeKhLDGF6uoCKoIJcZwOVJcGYrQ32VeVwr9PPvrfF0RA5CzBhU5e7?=
 =?iso-8859-1?Q?SbjOz6RjGrUjQJ/hWxCDD+SZ1iNhzDw39hFq+y7dCortEa/YzrqDDT3sIU?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XjLQ9wooAIH4mcsoaYKFVarjbU0j7Suds6WG1rfClOOU0n8Stc98B5aoPF?=
 =?iso-8859-1?Q?bH9QCyO58sPrgltnp9tQBfxudxRV172c+qO3rOlF/sNF2annaZA4O9HW3P?=
 =?iso-8859-1?Q?NsWI406EKciuM5kI+NF3zuV3pB6E85vG5F6xZvRMdfMI3y53kHDvarBkg/?=
 =?iso-8859-1?Q?rFdZ4uRHJuN+apoTuomb7aPpQrO8MHslxbsGnaHMcGENNtp9TN0nIXYRMJ?=
 =?iso-8859-1?Q?k2Lo9F0UWrgAZxL8pENjyAhvo1CoQHYru/k1uRG21wz5NGAjHKC487CgzE?=
 =?iso-8859-1?Q?qHJkI3kYkW6saELH67gzg7E0bpgT0hxJjWBjIuQcTFQhZSyk8/OEJQy5aw?=
 =?iso-8859-1?Q?XkQv2cpG2uI7CL7JBIMNYLiphv5oree/SbdkRtfYs9TsyFeaYOqLlrduVy?=
 =?iso-8859-1?Q?454u2BlgVBGdsGkx3U9g4kB7dOEv4H1iO+8MiO+jtjHCx7+DT3TX2zmiAv?=
 =?iso-8859-1?Q?G7arKkudadYOGmZchJAPghrnTACe0PrjBktodXibKuc9RajoO4a5XsDjM+?=
 =?iso-8859-1?Q?AW8wcDFOXotCDfGoCAjDl7fL5lJSyvaZJmxj0DfF6WVw1qGT22ZcZGGQBf?=
 =?iso-8859-1?Q?69+vjbRO6gP3O1Cf4SBYrn0xr2nThbK/Rf8QbQOjnK73mPvjNZFGl3xFbf?=
 =?iso-8859-1?Q?boa7LniKlDwdjyfJbPL6QSLgPGFVuqZ/aBPOAtSQEyFWx2ebYQUcyl4hev?=
 =?iso-8859-1?Q?3zMY7f6/DaKQXVvpo86ZtGjAbBMaU7R+dG2vbYZteSdVTy+JI5VpnVh1/t?=
 =?iso-8859-1?Q?A22N+8svBENy9HYPMSSlnyZRRlP259WbEj8oWRZnXmAcIPoBUqUgi6S89s?=
 =?iso-8859-1?Q?OHv2XD244SySnLYnfvliQOqAbLst9VtOHPnYWn1uxeJXlrl3p/OLgiSpZJ?=
 =?iso-8859-1?Q?BB4KKNelj8yM3O15qJih3J1R5CDJruMMBh7EkyLG6dbVeBP4Kh+VOoQWBv?=
 =?iso-8859-1?Q?GZZglVi9bgXitoP+NUMD96cFEE7mhRXwbh8MhXm8DE9ngXR5BFucyYTjat?=
 =?iso-8859-1?Q?rGUG5f+ToFFraU2FEGljq+dkC//2uZX+Gh6NmIkQyWP56yFu42TCGvJ0Uk?=
 =?iso-8859-1?Q?5IbECsWJdjq0mVFWe2oXJ/dQUTWwGDlbmPIkELYmzR0wLfTTRebM6my7Nq?=
 =?iso-8859-1?Q?iJ8+lKcUc48ydVbyj6/ld0LFOxXMspWcOM8Qg+1fozRlcDZbiNSDlWQh7J?=
 =?iso-8859-1?Q?Oxm2XX7AKlqCr3COlGCDMTXv9g4GcWh7be/ZfARAHOxqzR2J90Ri9FEdWU?=
 =?iso-8859-1?Q?2NrK/WPelr5jqjTqLVvOLmO9e9d+YQImJQ5auvEf4vnYD2u+DCM5Otphg+?=
 =?iso-8859-1?Q?ZUQraEZucoDuaPKBzGu8/v534gw1B/JTkXllWtVF4H/11zqz63RJTqbtCe?=
 =?iso-8859-1?Q?jJYVU68aLwfL+Fr3slPDvlExk8plB1GZBohOXnO+u+pjTY52PS9nBjoOjP?=
 =?iso-8859-1?Q?TLlks88Hc9r6Nfyo4IfXRIP8cisW1Mt6shpj8Qx9ferTC08pgrgx+cqpCO?=
 =?iso-8859-1?Q?Me7alqocK7UH/eouRZM2naG8xOeOkdVhGzJE044SXrznLcNA7ch4zZfAEA?=
 =?iso-8859-1?Q?mEh21kxv2uYvZ2naloYaO9PG+kTvpevbv8JG3sCjcQoRevvZSMVIK3G3lS?=
 =?iso-8859-1?Q?ljf2b3H5ZCrns/iBZbe5QIyVhk7QQQ7kuot1gntFKkgZW2Z7FYVaYkvQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d4773f-a9b9-40e4-eb3f-08ddd014058e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 09:24:16.8635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5imt0qqbl8BzXOHRW2UF8UKrwUqmVbnzRBDBHVhoFy4D8kJvr5vuthZx1SHnIMEY88bF+apVIWHn0IPKTmKwB1M3D0IIZY3UqEoX2ZVMzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
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

On Thu, Jul 31, 2025 at 09:07:31AM +0000, Morten Brørup wrote:
> When an ethdev port is configured for fast mbuf release, the driver can
> use a TX burst function relying on the fast mbuf release preconditions.
> Thus, also configuring this port or a queue on the port for transmitting
> segmented packets is prohibited.
> Checks for these conflicting configurations have been added to the ethdev
> library, so the drivers don't have to implement them.
> 
> Also, the descriptions of the RX and TX offloads have been improved, to
> reflect that they are not only for device capability reporting, but also
> for device and queue configuration purposes.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---

Maybe split into two patches, so the offload descriptions are separate from
the conflict checks.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

