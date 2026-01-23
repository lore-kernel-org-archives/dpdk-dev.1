Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBA9D74EF8
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:11:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D57AA402D5;
	Fri, 23 Jan 2026 17:11:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE9F4021F;
 Fri, 23 Jan 2026 17:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769184705; x=1800720705;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=gRNctEyDmP017B2MS8xOjgAAM+Io2qrcS6JiqSUOzuQ=;
 b=VKF83Pps3U9Ccqxa6SRAIP3SjT+uHvL3TkPq0t8yZd5rdZIJe5M0MW6e
 6hTB4/NtNBVcrpIb3DttXIL2eTk9dDfXQbR6JT3oQ6TeZFbxOgbXgN0Qm
 JsnX9YzMwGtqtdbmhkM0nkHDjAB0m1aD/yQl0wYz78ZOINJKuBcnfERAv
 BuZVXlX52JMOEHUN4HW8FpHdMDN+zmV4GPwxIHTRDLoGvvBNQA5PIGMml
 g5vs0TJIFDj6p7VDRNtJ76eXim30nyRI0bqu2uYyIoy7F5lePWm/+bh68
 /Ry/s36haZOxy2QqjueBJDH+gXNJZDmWShR4lon/k4XSPe7JQ6UMvKoAR w==;
X-CSE-ConnectionGUID: YMGxlgq5Qn2HsqX/D3k+AQ==
X-CSE-MsgGUID: eaR6F5X8TWWKtal2KdBR7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81550706"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="81550706"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 08:11:43 -0800
X-CSE-ConnectionGUID: m+3Q73XCS9m6w59ri6ivFw==
X-CSE-MsgGUID: JTWaJbczRoiivUa3JIrzUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="207086136"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 08:11:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:11:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 08:11:42 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:11:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/Epi5EfohuUAwIgrrxabiOxUjLcxQI+rFXSqHENci/880b/GLBkqUEF5JpcKYMWrUaHM9Ys+OEXtC5m/oa30rQZnYSoeznLPQR+CRD9eKQCxER62NZ/Fb6K7o4yFeR4X3C8WO6uHgvtJ5RzcYKViTJy9NTJQZFPaY+BovjLH7UPzuOosGLtaIgqbH29v5Aot5rxmQbWSWoodfv/lYSE7voEsSzSN+5cl+4WcbRcDtfBVXPK3DLKzeNvQojP1oNqRN9KbsevW9Fbc0Swp0N+mqWho2yMWm9/xIC2ifEPoZ1Zz/38EjP7PwltVRLxnwnJ4QfNMP+qzcE/WXiEzQl9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMMl4YqLvuYbyGrjH7i8o7jA54g9N37BbCZtl/g+NCk=;
 b=fLl4SvIOTdAZ+l/5ONiPoclx1JELBhVkQFHn4DWo4dbN45+/+6D5C748vKiT+i8Bxysd1lGWUseiPG7wk33+7D+svHSPgzzhsgqx3JFh6BQVGieIuR3rzpYE4YZPNVi0D/nL9oddcyQeqNMuD8oUjajzDYw2I2CWSRn2z5R9rmAj7WPNeS5ReCSs17PhbRlxKrLTbJEQ8/ZuG9fWKUaoml8WeuxtWWf8t6pWmScCpiT+0Gleh0IECbe0EZjfvW8E2ip1LEzlsMCtaOvxdXQJ0V346o8h+9e/8jWriUXw+cxFm8tGIvKcyhv50NreXNajN4lvKnPdHYIjltiz4HLEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6649.namprd11.prod.outlook.com (2603:10b6:510:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 16:11:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 16:11:39 +0000
Date: Fri, 23 Jan 2026 16:11:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Patrick Robb <probb@iol.unh.edu>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>, <ci@dpdk.org>, 
 Thomas Monjalon <thomas@monjalon.net>, Aaron Conole <aconole@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Timothy Redaelli
 <tredaelli@redhat.com>, Matthew Labrecque <mlabrecque@iol.unh.edu>
Subject: Re: [PATCH] build: bump meson version to remove warnings
Message-ID: <aXOdtd5SjD08kkBv@bricha3-mobl1.ger.corp.intel.com>
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
 <CAJvnSUC3ze51WFHx=cRMGKezrwXvo7fCXH8o64qJsbWf9SXsZg@mail.gmail.com>
 <aXM5LAcV6EC6L9VS@bricha3-mobl1.ger.corp.intel.com>
 <CAJvnSUCd3MpiHbTuv17bXdQK+rfeXwiacW3=sJqpJgMxO3YkFQ@mail.gmail.com>
 <aXOXIJerY0lZz9VA@bricha3-mobl1.ger.corp.intel.com>
 <CAJvnSUBOU7QTb6kp2RypHnk7rF5QjSjk5G8WtsEEgT23VmW-vw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJvnSUBOU7QTb6kp2RypHnk7rF5QjSjk5G8WtsEEgT23VmW-vw@mail.gmail.com>
X-ClientProxiedBy: DB9PR06CA0002.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: f457f203-9e69-41ff-7f64-08de5a9a1758
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjAyUnFoMVE4bUV4RTNSSnhSOUs3N2xqMHRPdmgrK01VMnNiMWNiYXhyNlEv?=
 =?utf-8?B?RkNuc0lnbU1DaC9qK20vN1ZhQ1F0Vmo2TitHNU5xOE5odkZSV1RVbXdFZ1U3?=
 =?utf-8?B?UzVDZmVkcGtMR3NKdU11SHcwUlFkQjVsTURpeHc1TnA0cTJpSzNUcGl6bjhN?=
 =?utf-8?B?KzFyQkdRNWh6cVFaa1pMWmdYeHJFcUhLZms1VUlJYnQwQ0VXNGNmdHV2N25w?=
 =?utf-8?B?aVJQQU1LVk5iZDZhOFJ5V0xpQTBQOHY2cFFwWC8rTDFsK21WdjV5bGdydzRU?=
 =?utf-8?B?SzR6L2dnK1BmWjJSU0MxQjd4ODFBZmdpekZBczYyMU5kWUw4aGQzWUIwTXNz?=
 =?utf-8?B?TFhhcGtwdjNTYnR0SzV5RXpTaDBpekZIVDh4V2RxalhlQ1NvVHRxaExnTHJR?=
 =?utf-8?B?NXhTN2lyU3lQeTlzRmplM0dEM0hiZmNMT2NnbTluSks3bFMrWmpObnk5YWw1?=
 =?utf-8?B?RHg0Ry9ZdWxKMnBjWkpPMlhkNHF2OHRvc2tYWW1wQTJqenM1Zi81eEV0R0xZ?=
 =?utf-8?B?ZmV2cFh5QkE1NTZjUktuT3NMcGVHNEZIZE04blg1U3VCTE1EWWl6VWM0R2Y5?=
 =?utf-8?B?UkNybW1IM0hxdWd2c2NPNWczbDVtWEV5RTk0VXozV0xBSFRKV3pJbStmcXoz?=
 =?utf-8?B?bW82TXc3U3hJNzU0VFFpcmR5ZWFYUSs3TVl1WndPLzZwSEhhRzB0MmNqa0hU?=
 =?utf-8?B?N2taVjRya3N4cCtQQmY1YnRvdkpieGZ2ZkVLT3VrLzZLWlhBNVN2cHY0V3lr?=
 =?utf-8?B?ZWFWdXJGMDNYdXk2Vk9oMmRFekMvYnUrNGU4ZjYrb2VPdElqWTdGa3BzeEpi?=
 =?utf-8?B?MFVyc0t3V3NBNVBiUDdkY2FTN1JockZsMStJNFV2SFIyMlozM2hmRUZwRFVw?=
 =?utf-8?B?UmtWN3A3Yi9PN0NCNTd0YTI0dGRrN24rOGVlNStYNjA4aGJuYU4yMkl2WTFK?=
 =?utf-8?B?WWpLSkRwUUtaU1dPamRvUjlaZFpKanRLZThPR1ZrNDB0Uzl3S09helBDdXRh?=
 =?utf-8?B?WjhNbms5MTNVbndEZWlrKzJzUmVyd1NmSldkc3I4eFp5ckQ3T0RmelIwdHY5?=
 =?utf-8?B?bW9tU1VMcXpOalplVTF3dkxlSG1QUkkvaW4xNDhQTGVPOU1PM3F0RFd4L2V5?=
 =?utf-8?B?bkpZK21jVUdVK3VwZmVhbHhOMnFJTHN3cldrZktFeGJCZHdlOTRJdndpNml3?=
 =?utf-8?B?N3hRanZFSGl2ai81c2k2MkdKQVNadzdBRi9YdTIzeFJmaVl1QXArQ1Y4YWxk?=
 =?utf-8?B?dDdXdy9yT1l1dEJLMmRScEJzelc1NDBlZWdjTU0vNmt6NFVLYnBZRmw4WENy?=
 =?utf-8?B?QjV2amFIOXNaZ2hTRjB1Q0NqZThoc3J2Mllkc0JQWlRyM1NJemhDV0VCRFNU?=
 =?utf-8?B?eGk5VXlBSGxmWnA1dTQ5TTlHOWdLWVIwNU90S08rY3dqM2ZUaHdMRGhGaEh4?=
 =?utf-8?B?VE1HTGdCRGxqWXNlZXVxV2NUSGt3RGxQRyt0TEU4WmRBUXc5ZTZzb3Rud09n?=
 =?utf-8?B?ZzlIZnZuWGlPWHpSZHFVOE9YZStwYndKSTdEemJ2NUpsSDZBZGttME1DcTZx?=
 =?utf-8?B?My9pUVRZSXY4Q3owaitpdEFvcmJFYWduMW1GYnNEaGE1UE9wdGtpV3gxZnpU?=
 =?utf-8?B?TDNta0g2QmRaMzdYelcrdjRmbzNrTkNVR0VaTFpsNWg2L3pGbjNNVzdVWkJP?=
 =?utf-8?B?NlpmV1Voa1dOREVWVFE3U3c1ZWxONDQrbFo1UmxRV3ZCdm9yWXkvVVdnY3Zi?=
 =?utf-8?B?N3h5VlVyS2dsVzRXY1E1WW9RKzFaRGYrVEd6bHlnUW00S3pJQnJWSzVHRXRC?=
 =?utf-8?B?aG1VRlpOeXpzT3ZxOHNZeW0wUCtqaW9xbmdmTldIY0pLNXBrQUdUN3dTYWFQ?=
 =?utf-8?B?WWM0SzFDSE5WcG4vTGZtRHNpOE5zbWE4QmNSbUVJQXg5MUVRSWwrUDNzcEZq?=
 =?utf-8?B?VlBXZDdxZnRLMU5pQWxBdXlrN1FQYXA0UldOZ1c5V0hSNmhkNkN0OVlKNVd1?=
 =?utf-8?B?anUvaklSaVQyOStnUFN1U0NjZXNPSVkrNHZnZVYxaUxKQnhwcE5EQ3BlYTdC?=
 =?utf-8?B?TVJSTWRJcno4U1lnZ0szcWRLZGUvTEdueWFQcE1UeXg3K21lbWZjSlR0SWVq?=
 =?utf-8?Q?+uwA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZUQ09KUjN1YW0wQ2hoTE96aVJzQm55WEpGK2llL3RWR3JLYy81WnRRdjlR?=
 =?utf-8?B?d1lqSk5hY0xnaTFGdzE1WUlyL1pvUDhONHlJblI4emkzam51T0dxaVY5TTAz?=
 =?utf-8?B?YklSWWJkV0o2S0F5Z1NYMExnTzBOUXE1SmVVK1FwL3pkTVZTN1RlUHJMa2lM?=
 =?utf-8?B?RWZnSUl1ekUxa2E2UmpoSHd3TVRwbU5DUjN1Y2Vpak5ZTVJvczlsY2k1aUtt?=
 =?utf-8?B?QmtWWDFKcjV3eGZzczJhb00vYzIrdzEyeUl3cUMvUTB3WGlUQVhkSlVPRDE3?=
 =?utf-8?B?QTdUazFpQnFaeXBpSThKdUd2bktwbjU2d3VnVjB1eTkzL1YxYWpXTVN2VWFT?=
 =?utf-8?B?VllnK3dHbFNyYlhNbmdaMTdoWFBHWjlCMSs1d1N0RHBiOVpjdGh6WkRYdXNG?=
 =?utf-8?B?VjJkYTRxV2JQdXBlZFROZFk1QmtCSHdaeDRZVDFqNlRaekExcGJCMnYyV1A2?=
 =?utf-8?B?MmtOdWJRNm4vb2NLemhhT1hWaVpDK0VtQlkzblQ3MEtIakRYV0EwWmRQSExY?=
 =?utf-8?B?S0RmOFMzalR3YllyWGFab2pMZ2ZFZUFoYkVNMmJQM1U4QWd0Tk9EVkJTTkEz?=
 =?utf-8?B?b0JjQTJIMjBYd1kwTWU1Wk5sWU1KNlFKeE85YVdBYlNUY2JPMER1VWtxMElM?=
 =?utf-8?B?bGI1WnY0dm16ays5V004aUdBMzhhT0RmZlVBcUs1RWVDUFdWc01KcE5TZ000?=
 =?utf-8?B?bFRjOHZhMml5Tzlac3d3N2N4RUhOYk8xUlFVN1R4am1oNDVndUlQWDJOWCtI?=
 =?utf-8?B?aDBKUkZYQzZicm1sVHpnZFpQRXk5dXBxeHZzUS8zWXVQanBaaGx4L2FDUGJx?=
 =?utf-8?B?T0FpK1FYU0lwNVdFemp6YWZDMy95bjlnb0lacFBOVXkvZjFTLzdIa3lYaVVU?=
 =?utf-8?B?RmNrWmZnYmVPQThjWWhKNmt6Y3hKZjk0SzRZMktWdE9aL2NXZ1doOGkvaVRF?=
 =?utf-8?B?MDZMclB6Q3htS21vWng5bCtIZVJiUUNmUzBNWTFQdU9tRHYvOC8wOTBQWHky?=
 =?utf-8?B?NHU5aW1lTW9hUThVNElkMWZ3aW5OU2Y1ejVjUDhmUkk5b0FFNmxzMlZZRVc2?=
 =?utf-8?B?ZUFFSFVMaDJkN2JoZkM0cGxVaisxNXVsWFhhZmRUYmVtMzFvd1NCZWdTdXFl?=
 =?utf-8?B?Q0VDdTVzOXpqU1U4YnIxOGcvd1diSEs3SVdJMHpia2trbHFIMUxLL0VoZ0ts?=
 =?utf-8?B?b0hqZ3UycHJhSXVwbjJqVGVwQ29rcnUrQjM5aG9iSHBxTFVpanNJb1QxVUhx?=
 =?utf-8?B?amhOV05yTElJOUU0eUxIZ0lkK1ZHemNXam9Vc2Exei83d3JQdFh2VjlDRyta?=
 =?utf-8?B?UWFpYjJIend6QU03RTBFNjRrWW9rYWU1Q3JhMFRsazZseVRiM3VGcEZNL3V6?=
 =?utf-8?B?OWNWd2ZRb214YTZBTEp3OXkyN3B4bGt0WmZtQWoycG1OTlpLUHN5V1ZLem8y?=
 =?utf-8?B?c0Y0RTViMHpmdEF3Sm1Wdi9vOXRJSTFOejM5VnRqT1pJZ3hWblZhQTRPTjFS?=
 =?utf-8?B?ZVhoUTZQSC84ZjVmYWdidkN5WXJxekNJbTBjQXBZQWtRZUZ2Z0lpb3RTYXB1?=
 =?utf-8?B?N05WcFVCTUxzZVBCMEdnNDArY2JzempRZTVtL3phZDZNSmppWHFtOEppakFU?=
 =?utf-8?B?Z1o4Qm1OLzJDdHQ2NU9hNEtBNGJCQldjSFZHaHoyV3BrK2xCcERHUWpqVTkv?=
 =?utf-8?B?YTFxelloR24wK2Z4MzI3aDNFcytRY0hFVk9PTmNxSWx1MHc2SEZ1RE1XVTlj?=
 =?utf-8?B?S0dnUERwVzVBUm5sK3lZNjB6b3FOcEo5eWJhV1R4RzJYbGZkUGpQRlh1aTFV?=
 =?utf-8?B?bWRWU3J6MUlLNmFhT3B2aTlEOU56TUc2dW1WUHFaMEtPWUlraWpRSGVSL1RG?=
 =?utf-8?B?NkRUdktKV0JibTNNTWw0Wk9aSzhXdkh1YmRtQWhiQzBNZWVaSDY0cWc1QTlJ?=
 =?utf-8?B?MEx1VjNRSGxMVTg4MEhwUjF1TS9acWgvMlRxd1d3TDdBV1c5eEJkNWcwdnRR?=
 =?utf-8?B?ZFNZM1RjVEoveWg0cjAzNVFTOEJXY2piWGZLdDVVTHNlK1Ayb1ZoamJSR3Fj?=
 =?utf-8?B?ZnlXRDNrQTBrTHJOajFwTkFvUlJpeVI2eTQzeXVtK25aK21VbUEwT2N1Q2th?=
 =?utf-8?B?dDVYcElqUyt5c1Fka1VUVWR5Zm9BK2x0UjRFWjAyUnlpYkNialNFczFhMU5p?=
 =?utf-8?B?ekdKS0t0VGxoUlNVUE5ISkVvazE5aGJzL2VwVjRTREVxeVFNSUFlOHJtOVND?=
 =?utf-8?B?NTlrU2tRam1hOG01UVFUakVIYmk5OGd5UUJ2UEIrUk5Wa2FWZDE5ZzFISE54?=
 =?utf-8?B?dktGQ1VTUEgrN3FmbFpYVUtoRjJTQXdIRHEyV255VGpER2JrOVUrLy8xbGY3?=
 =?utf-8?Q?6WgN9IEWJvRnVvlg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f457f203-9e69-41ff-7f64-08de5a9a1758
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:11:39.8620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yi4+QRfRfpm+e14RhXWuR8LHCvC0U8OPvUTplvrhjnUrn8h1Il4BRPcPBzNItG5haNak9lZ/Og4yPPVue7BO3JfxUIPE4KZSjGs1SeYa8c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6649
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

On Fri, Jan 23, 2026 at 10:59:23AM -0500, Patrick Robb wrote:
>    On Fri, Jan 23, 2026 at 10:43 AM Bruce Richardson
>    <[1]bruce.richardson@intel.com> wrote:
> 
>      On Fri, Jan 23, 2026 at 10:35:53AM -0500, Patrick Robb wrote:
>      >    On Fri, Jan 23, 2026 at 4:02 AM Bruce Richardson
>      >    <[1][2]bruce.richardson@intel.com> wrote:
>      >
>      >      On Thu, Jan 22, 2026 at 01:59:19PM -0500, Patrick Robb wrote:
>      >      >    Thanks David for the CC. We need to rebuild all of our
>      DPDK
>      >      >    container images for the distro build testing etc. which
>      takes
>      >      some
>      >      >    time. We should be ready early next week.
>      >      >
>      >      Is rebuilding all container images something that needs to be
>      done
>      >      every
>      >      time we do a minimum meson version bump? If so, we probably
>      need to
>      >      look to
>      >      take steps to make things easier to do.
>      >
>      >    Right now we do build new images any time any DPDK dependencies
>      are
>      >    updated, including meson. That's done with the dpdk-ci template
>      engine
>      >    (an application that templates out Dockerfiles for DPDK CI
>      >    testing):
>      [2][3]https://git.dpdk.org/tools/dpdk-ci/tree/containers
>      >    However, to simplify we can just move to installing meson at
>      runtime in
>      >    all cases. We already have to do this sometimes (like when
>      testing with
>      >    an LTS that requires a different meson) so doing it in all
>      cases
>      >    wouldn't be too disruptive. And, of course the main point is
>      that that
>      >    would allow us to accomodate a version bump like this  without
>      >    rebuilding the CI images. Let me know if you have an opinion.
>      In any
>      >    case I will chat with the CI Lab students about it.
>      >
>      Having it installed at runtime would be definitely good.
>      The other thing I was considering is whether we actually need to use
>      the
>      minimum meson version for all build testing. If one or two
>      containers have
>      the minimum version that should be fine, and others can use the
>      distro
>      supplied version so long as its >= minimum.
> 
>    Okay, both of the options above sound good. From my end if I had to
>    choose I would just do the first solution (install meson at runtime in
>    all cases) because it keeps our process uniform across distro testing
>    and there is no "special" container. But, the second option sounds good
>    too so please let me know what you think is best.
> 

Go with your runtime solution, it's fine - and possibly better.
