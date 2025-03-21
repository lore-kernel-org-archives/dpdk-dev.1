Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A86C36018
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 09:20:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 637A04066F;
	Fri, 21 Mar 2025 10:20:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0D86740276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 10:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742548832; x=1774084832;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sXVpp1AWIaAfYf3I43w2mxltRtMzOgCTr3jb6yGSq3g=;
 b=gZpvC4Vnf/OzU8ODwvmajOWRxzRBfWLJD1xblhm5VIoqZC4Qbd8anjN2
 5TlCP1zuhLGkwz23EDFHkmCqS0/a0CZt/S2pK0hoHGSNI0qsD+rmbaik+
 T91UlySoZ90onjKV9mYlKd8V15EnFpVDR9fKCtRccMpOm51tS1rLrKNkp
 NaYPapiwzCXwM9bft3qAv7HtNvxw5dVWayyEvkhF3ElRAaD+PpFO3V4Pi
 H19UjfYSMcjWEysBl2uTwZQJgRQHlFP+0sFc2ft9tnSsZonhpqOXRTkSf
 PxjMFsUvk6ni8wgkewPdGtgHwC6xlv+RXLb3hA5SjwzgY85+Y+NAuClLx Q==;
X-CSE-ConnectionGUID: ToVFF8NdQa+QaENNHfKIPw==
X-CSE-MsgGUID: xjrNNCsTSeqDPRqRIKPzOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54476848"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="54476848"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 02:20:31 -0700
X-CSE-ConnectionGUID: FeBzQzFuQFyQPGWlb/1cfg==
X-CSE-MsgGUID: vaDiYOJPQOaSxqvpTFSPDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="123154872"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 02:20:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 02:20:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 02:20:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 02:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8pqlXXe2AL/z5jF9RhoB56AfjT3DbAzaG+xMYTuqf5GTecclmje8VrhNZuAfk2zZ0kDWVJLIqeQDJrft/Tt4LIpMt2/1NyWKYfQOkQrFh+hvK6CiwHAmoP30JX3DiLNnSeIH5JXyPzBgF+Ea+Hhxq0ITLJwempz/FM0EiR7brli9/+9Ni2uFLt6Z8nWEjBco4GrE29wjThXZcpTcJCLWCN/ItauYN2SdaT+DzAsMpyhQu6LZQa9oF5pZxOfobiOeXMDyUiVDPhTxUPR4BP6v+3K1KNfAywny28FvMcdjBEpBJhS4oabd/CHnN0+qA53YeDOWDf27wj6lbxZWGTp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXVpp1AWIaAfYf3I43w2mxltRtMzOgCTr3jb6yGSq3g=;
 b=blyufSVLFDfv2Lkkz1NEQBXW7MIR2XBI4KwAGm5CsAO7Hu2M00TJW/tCG/BMHyQCxzHiv9DdAP4Hk8hahxnqPkEXRmg6yi4IXrkyScxICm5kzU2+7IwYHusZEMfmh7PZjzfYkaa7g0x0IdKoe6IJsrZ5qWS2e7h4KnHL1xxUhmFp37DvNkjVRNXO9BNmHOQ3LzyE4AvRq3h3gYz2oECHpsZ1PpF1kYm4djTzErXklGffrVUbtaJXAH1XHHlU6Bryf5NxiyCqXtNfHAT0/ez1MTzHgbllYXdvhf5j4A+QvPr5jbs+LexQaIqeISHNTQc/+MvcSoSOStBPkGJORNEdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH7PR11MB6330.namprd11.prod.outlook.com (2603:10b6:510:1fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 09:20:28 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%4]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 09:20:28 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "Jiang, YuX" <yux.jiang@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Puttaswamy, Rajesh T"
 <rajesh.t.puttaswamy@intel.com>
Subject: RE: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Thread-Topic: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Thread-Index: AQHbmkFXwQZx6K/Ya0er6PvgtGrQ57N9UGKg
Date: Fri, 21 Mar 2025 09:20:28 +0000
Message-ID: <PH8PR11MB68040B66701697332F62778BFCDB2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20250321090340.35913-1-yux.jiang@intel.com>
In-Reply-To: <20250321090340.35913-1-yux.jiang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH7PR11MB6330:EE_
x-ms-office365-filtering-correlation-id: 0b3f54fc-64ce-4922-5382-08dd68599ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CKi1MTxSKR38LJBSSAZNH4T5krvoLj8R0I8xuRNymSWQMQyadbLeBdrz//bj?=
 =?us-ascii?Q?9UrsFRrvKmtAt6fERZ8bjBAqX/Pom69LhexZG+QUjDq6xDQ1jF5Q9ll7KCeD?=
 =?us-ascii?Q?IWUy6vsyTZEds0BYsdOClOLMo3B1DVSkMrfFPsvBAGZ0ZMn6c+i+GNrd9EMN?=
 =?us-ascii?Q?xKcaqZPU7dFNUgL+4A+eNjECxMFvVccbcxpA8mBj0GCM92BFlkvYJcob4hfJ?=
 =?us-ascii?Q?oipIPlgOMI2i6Ok3DGGW8UUyXR8jv89bD6Kl5KC5kNOTBuOE3SkgMi3BfulR?=
 =?us-ascii?Q?yThqkN/hGClbUnfH9472Egeii91nHxji0BtlySb5zmyypEOm7zhBZ8w16zdP?=
 =?us-ascii?Q?rUqGdRXzeboiroF/WFyBfSllfS74kNUzNjGecCg+OH1rDUZs/B5jehbg6R0A?=
 =?us-ascii?Q?SoJ5jR3XWw/CWtk4buD9vKwOXN6f+1crhLd0X5z9Vzn8zIwMFI3VT9x68gqz?=
 =?us-ascii?Q?5ouVdUONTxDbtbOHdUhz8YzwcL6Z/lw1xkSOpHBeNEhsOgu5aRuw7E1jPNL1?=
 =?us-ascii?Q?x4atMQ+UrGQE2lR6QhsmAP/ASINFRn4Xf3J4G51xUNSz0/2GKbsKM1MPZ/TC?=
 =?us-ascii?Q?kF4+/wAxNQv7oyja/if+tddO4TBNhtJryf9/qCaoUriZPutyjg41EQdFEqpO?=
 =?us-ascii?Q?VexPL1SjwyC/aHgXpRUPA55iALickFpYCrBaqhp/CcRdJMxTdX9fnMbqT3gT?=
 =?us-ascii?Q?pKAfqCJrQSgkTF0sWXMsnRAmBLr/KkRmyI1YYpoHI6E8kExAud6wviLBcTzb?=
 =?us-ascii?Q?+w/nQNFIAFgH3ORc0Dpaa6LgNmT8VB8+N8GWZhkjNaByftl9BC3kl6OWBrkY?=
 =?us-ascii?Q?QN7YHjRXAsetGmkgI1oAjwZV35iTz9JTehQmtkfoCpCBa1jSlokCWcufcsgI?=
 =?us-ascii?Q?SJi5EtPf5jNv8BM0gGHmz3nmV05TLU0mgaIcMgzrQY5jc7rZMedD6cTSfx9X?=
 =?us-ascii?Q?xgfn4OROiWYzngGT/WnddUaHimfOWKhT7KyT8N01/7RM2ODIOKec+li6NXEm?=
 =?us-ascii?Q?JFUzOw38z8reI7D66CAN9GfZ/MD1QLgR6TraOlb15a63h5oYmqSDfLxL5rpx?=
 =?us-ascii?Q?5bILekFgcE1LklLquCk6l09KcwN0Nx/YnCeBpvr5X8wJdlNrk+l8jAsESpV1?=
 =?us-ascii?Q?SAuHkMjmfQegUi1NFpH66AX+9NGo654JGvR+xH37/1Bfr6uhZMNM7ZFa4vPk?=
 =?us-ascii?Q?ZxwA4JB5hIqK++iGDBtLe/DgaezJKsjXbH58GvdCap3f+L5VoycRcZ43783A?=
 =?us-ascii?Q?sNgKJwcZT50gWLpDSw1HsTcr/AoQLRt2ci7CvKqvMXifxWYhMeWH+DBdR/iF?=
 =?us-ascii?Q?tV/h1TyVcCHVkuFdv/5Q0OF0s8Sx8VTy5BmP7iGZsLc4ehGJjP9ylyWiQaDP?=
 =?us-ascii?Q?UTfEv2blGGTeszCUwJRxVBKCNaVQ86UQV6ihLhCrX824EI+aAnRr+LrGiV7l?=
 =?us-ascii?Q?E7+tY+gPOi90z0sYjbKfE+qb/6drjvbv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eYsVesvht+UXsUy2ZPf0UW7Rwl+lb2KNUBdjK9wJqRMu6ByUQjuubFb7yWQQ?=
 =?us-ascii?Q?4XSS80L+JdjFHKvTnXdKKWl9BV5I/bdBGhYxHeI8CuwY6TfUf4qQ04FwiJxv?=
 =?us-ascii?Q?0iDbw4c4/cd9vUrbkuDyZ606sO0Q2dDKKtY9q1dctahSXdqDrnmpb+eImGhM?=
 =?us-ascii?Q?tmukreg9x4pHMJBGSlFHUVv9eod3cVisAlzXhkQQhZJ4jS3BZ3ehAaduTfoI?=
 =?us-ascii?Q?zE8H6ieBu4mZ96xc6T/MZe/TpMZQQ0ic//6fsTabXI1wYTR+U/VMbUHP/PEl?=
 =?us-ascii?Q?RjAtujcgAeI7vWn6JYx4ut6JP8D+gpr2QiDuWBcyPsgsxA3erb0dNmvpKLjg?=
 =?us-ascii?Q?p+4hEiEtfkjxGR81gOkIkH5liLhKWnG2joF9gFzNDGrW74bapDA1wZ30dWq9?=
 =?us-ascii?Q?8WE4vb1wESnNE+UD6ESgWRKXBpYhcxlqoQmHiQ2RKtksLX4TZWNArJePH0Uw?=
 =?us-ascii?Q?2qdgth96bk0hLR4wKU8GcnpYWwAIggRXaV+Wfnbv9PRT5sgbqgUl11RTGhIF?=
 =?us-ascii?Q?kSB7+ySgF5LP3YNF7RBOmGVJcPUIdIbPCq4+1ZcA6hzZdoSZSShzWw9fbgdY?=
 =?us-ascii?Q?U+/sb0xeV1530qFkKWQLeLblRq76JmuH0GZhj/9My4+V7plw7ZKrVGCYa20H?=
 =?us-ascii?Q?cVVX41BwIikJiGwobRENHgwXOvEIBvai0NAdhmuBhkA/5M8ofS7m00cCZYMH?=
 =?us-ascii?Q?Vn+N2LPbJZMyl/Y+vI82IiFkWrgBgxIFY9vmJCvAXMIEo6xodb5oFqrIxlxX?=
 =?us-ascii?Q?z+e5OnLe+ynTxh8nRHNmv+JO7yX23QQAf/3+0evY/1qzY1zNRSY7paiY8F2O?=
 =?us-ascii?Q?saJ0oJZFmlVcAwOLjD6nklCvf4lee+ypnWNGTwKPM1uavgMEII4WD+1IBGUd?=
 =?us-ascii?Q?NyLjrKsh5EoOIb0+dCVrKFZEBtKLT21LbR77QIuO71uh+3TN31mPVN8hLnNB?=
 =?us-ascii?Q?TFoq2XTO4kygVG9tpH4L1EGBGwGZu7EAhs6fii7/bpqdbNCs7MrjtRHEuY/T?=
 =?us-ascii?Q?sbZj90MoV+qJVBD5GH5tpsNOStVQ6FOcrGi0BPRdnKd+UpuPGYxLB7Z2FSmR?=
 =?us-ascii?Q?GhgH5Q9K6jZsOrJRlp8suN7hIxYAYnI2XAibsILjqs1r/mstGpaKWJLtsioU?=
 =?us-ascii?Q?nvdjtJCWXQXUJYacbQjXXHCjw9V1virgFhY+l6zOI5ku/p9pqM0G669Cj+8e?=
 =?us-ascii?Q?l19MJka0hW0jALcs9he0tHnwxmiu0MUCENojt1A/gqhZzfxq+PMhYK1lYWJt?=
 =?us-ascii?Q?UMqly57H/Q5JGQSI+9bwlILOgQQhBb/PUd0oQAXPh6ZRRm7uJucHYPIcET0E?=
 =?us-ascii?Q?VniUiAGF/HJuDUiVa2mz3Sx1J5lkvYCph/pl+paO6V8ipoqmH4ocvqcYhtHM?=
 =?us-ascii?Q?Hi9VYHifH5kHTTNN8Nrow8ePW4TVIYZ3tq+TQb6o5F8DsputI1UAs1y1G8G+?=
 =?us-ascii?Q?TUtfSejwuRjT12ummUg7lZkrxlZaxF2HGowWXzo6VSAdyWBR3opQUt5dt4uJ?=
 =?us-ascii?Q?ls19rfkSKRsmTkE7S9D2wZ68+9kn2adR59Eg7qBvJD6//g4fIUtt2LiP3zBO?=
 =?us-ascii?Q?+v85MZe3QTXNG3QCQEq7FMqTL2MkEJWzhxflHAH0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3f54fc-64ce-4922-5382-08dd68599ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 09:20:28.3304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ek/A3FVfmYIH2kz+AhFXHcdei19yL1HwpFLzsbLIMwd6IWrKURTMJKgBiSX3C88HJwluzvL+ryX12+QOFQfWfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6330
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

> Subject: [PATCH V1] doc: add tested Intel platforms with Intel NICs
>=20
> Add tested Intel platforms with Intel NICs to v25.03 release note.

Acked-by: John McNamara <john.mcnamara@intel.com>


