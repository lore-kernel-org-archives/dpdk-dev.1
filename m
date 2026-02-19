Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E4E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:22:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25CC4402E3;
	Thu, 19 Feb 2026 10:22:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 53B82402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:22:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771492960; x=1803028960;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xoTzr84pVr7HM0cqsKikd6XGQGXdG5lrsSkWrhiyK1U=;
 b=GzXeKNrWSHfZx8v51kBNdms13UaMUr5x23l3mecsVNoUR3aY4uPGwySI
 vQfrwMMp67+2fgC/cwPqXzN9Mcsue2/IXp9wk78XFFEhyKNAAUhdL2AJA
 KPZN7KWK457hFitdnFOb3Lvv5/hQttWuFa3rE17f3GRGlEzYj3dCR/5oO
 A6gYkKxXxKfWys/qZdOWo4j3sfND1CZLQ753alB/wA7JaCeyRUEC+5pSi
 4G9gOCe4676nUUDU0LYRNHRMD3zDUAwQ9BGUPN54bc9IA2uiq/BS7YmlE
 hhO2kHIs3dI/wKaLZRV6YZKgNlcyFf53Y87pvyikbjmjzjrXvWlOm+uMc w==;
X-CSE-ConnectionGUID: 2Fd9MHpXTs6HdeXUUpFdLw==
X-CSE-MsgGUID: XuuSTs+KRb6zktIy1aL/tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="89983517"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="89983517"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 01:22:39 -0800
X-CSE-ConnectionGUID: dZLBKiCgTyWLzwcTWuAqTQ==
X-CSE-MsgGUID: iEweswxTSoOp3MX3rz4+GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="212722648"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 01:22:38 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 01:22:37 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 01:22:37 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 01:22:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4mKP0oi7PLujGTUDPF036CPQrR70gUrdVxXLE9BM+lB3EU/QCP8jqn3HpIUJzTBAsOFBk0EPRaFCa2HzwAQsmxz1RbhHqQ1DUd5oIO3S/azPNVpjU0ZgAv4VIZp5JHaJOjbXrjy0Q+c6KqzZ3J3kt/esB9rVucKVQhylYqaXCnBniBJEfGMQPdKAMvCJI+Thhz38qX0FXS2Ii/KMJmUTM1kcnuUw9rrhzvAVO2nWlcV0hZoXPuoQwIzZck+xAUosikKigjfoyANbqhZsi4Eu+oXA84BFA+Bi47iKlUy5RtBe+2UGO9WilL0NsptiYm2DhjNI86uQqtBrkQmsRAFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkbuYwXQtjIfadoWUYIPF/jQQ0B7kR3nd4EDpgWgOjk=;
 b=FcpwsJD30jAANsaUKbOPDCYq4JMJx+nVL9Dz8JeXtgjE+bKRupYp6oJUb1lYmH1WTOSB+luXAGwcBHCki2uSOCVM+dUTPk+KxD/oj8R97YkqKN7u7joX1sutmGrsjM48gDHrhCheAU0P0sRz9C0TWdVFQuO5LuOa5+pWSTU2meW4bgGs5EBceIkmy/0YmbsALY0AcXxIaq72A/z/j3id/nm50jvSVJ/zLd3ym898bYn9PTiUxOrklZAGqP6ILxBJlnIgiv6ynltYzrTlOS6b+Mrdr9EMo9LuoeuyEJIP98zWuJE9kXc12HXHovxKQVExu2yChCqL3Py0wC/Ss0ADhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS4PPFE99BD3AEE.namprd11.prod.outlook.com (2603:10b6:f:fc02::5d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 19 Feb
 2026 09:22:30 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 09:22:30 +0000
Message-ID: <88f7b829-83aa-48b0-9de4-fbdcf5633603@intel.com>
Date: Thu, 19 Feb 2026 10:22:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/27] net/iavf: avoid rte malloc in MAC address
 operations
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <ad3c77be6c74565b7a9e4544b6565ea91f94fc70.1770978324.git.anatoly.burakov@intel.com>
 <aZNTkvpt8ahCdoSS@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZNTkvpt8ahCdoSS@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0323.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::28) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS4PPFE99BD3AEE:EE_
X-MS-Office365-Filtering-Correlation-Id: 881b11ef-9895-4856-dcb3-08de6f986794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2VqNEYwSmszRFp6c3MxbEhHcXFLa1ZJSGhJVVZuVmlHS2FVSlhTMFlHdTNr?=
 =?utf-8?B?MEtzb3lqVXV0bGFQaWY2REpCV0Rld2ZpdVV0ZEFIT1FyR21Ob2J3eENrcGgz?=
 =?utf-8?B?TVRZc2ZnSTVVdzU5VjV6ZXJYcG55T2M5Q0Vlc2sxMHEzQk1qVE5HNll0dmcy?=
 =?utf-8?B?MXRNWFI3Nnl3a29ocVZQaXU5VC9keHhwZ3NlQVYyQ3dOYmhJM1J1dnZUb0x0?=
 =?utf-8?B?ZGNyYnY2cjVFK2pvam1qZUVWUnBLY2FmQlZMRUZ6T3d2UjZNbXFncmZlVXBF?=
 =?utf-8?B?YldFL1hrK2UvOWdHOTh0S0F3NEY5bE42dGZSRytQazRwZlZsaHVZRFlkQitG?=
 =?utf-8?B?Z3ZLUEpiOGJRV1JWWFZ3T0diTlcrTzZPL2tQSTR4TzZoQ3J4RjRoQW0wQjdl?=
 =?utf-8?B?b0RDRzlIMEp3ekpXK01XVGkyUWZLbHBuYUR5ejdVWEJhYW1NaytZRHB5QmpH?=
 =?utf-8?B?T2JWT1VGb3k0eE5iNnFPSUNJQlFpeTJYM203UUVDZlFqV3MyT2dZQy93dDhQ?=
 =?utf-8?B?QzcwRHVhUEQvV2syblRWWWVScm1TT1hGNnlKdTQyNFFJZGJnanVaV2hKU3o5?=
 =?utf-8?B?bUhtTEhGRVhuemxTSTBjb2krWGoxUUphRk1SbXR2cHV5UFk5QWM2UXp4ZDB6?=
 =?utf-8?B?SEI3dDBhUGdpN1lMeDZBa3dNckhrUktVWnlsd1JpWHB5eE40NjI5cG9wQ2FH?=
 =?utf-8?B?bkE1SFRXM0FpSmJBTUUwUFhoMlgyVkRFR2FBcWNVWDhwS3lhVFF1b2ZlcTB2?=
 =?utf-8?B?NGFCRmxRa1p1ckVBL25mSE5uemZvWlpVdmhoWS9hT0lkMkZPb0JjRG0ybnhF?=
 =?utf-8?B?SUgwL2E4aGZVeEFpcmhRdGN6TmxlbGo2ZEhGekVscHZhVVNMbldNVmxaS0V0?=
 =?utf-8?B?bXdjYzdFUFhCeG9hcHMyTHVNK3QwOFRoRGl2WmVJZlNzK1FKdjl5S1dVK0lY?=
 =?utf-8?B?emZNTnBERDhESEcvdGNqK0pYUmJCTzJPTzVHUTc2d040elJ5cWF1QThIM2oy?=
 =?utf-8?B?QXlZcWpyNnN6RmR4eHZQK1hGcFlxT3pyTG9CeE55K3hYK0lSK2Q5MDdHSDNv?=
 =?utf-8?B?UXh3Y0Y5NzFzTitxS0k5am5uVHErY24zT05FMWNQVG42eWJpem1pakdzSWRl?=
 =?utf-8?B?OWdYL3BMeXN1N0ZLR0FFN1NubHNQVU1WWmlGVEJlQ1piam1yb05ycjFKbmQ0?=
 =?utf-8?B?U1dYVU1zSFo3RWdMSHJ0RlZVdkxQYUVrUWp6dTByeUN6OGtnOGpaNFBPeFV0?=
 =?utf-8?B?ZzJkM2hpSnhUeXVNaGFrVmxQODlWZnI0bE5KL0VJcHUxNkN3Y2NkNHZhVFRq?=
 =?utf-8?B?ZVBZYUt2YVNZME1hTzg5RDlhcllkYlRPZHJLSVljMFpDaWZ6QnF6dnNYenFQ?=
 =?utf-8?B?eGN5QjRyTG8rRkVvWmxWZ2VVRmJ6K2Q1Qmw0VWtCaG4xajBwaXk4TFNMTXJt?=
 =?utf-8?B?NzJ0Y3ZBamVaRGtxYS9ESVoyeVRDdnJhRkpLMW1UMHJFUXk3WVk0bVlHQzg3?=
 =?utf-8?B?ZXFWSnRvZDhEVUc3U3hwQ1QyVG9odlNKQUNscmFtMWtvLzZIYWRFUWMzekQx?=
 =?utf-8?B?U0ZQS0lnZXJRckpwVkZuaXZWR0sxYlNGVWxMOGVYbGgydFZoTFVXUFhzMGxx?=
 =?utf-8?B?Y0tWK2RtSzByQWw4eGhlZHRVb3dWdFMvWitDSEtLYnM1aEJnYWJTMCtYbmtR?=
 =?utf-8?B?Q1p2a2dTVHZVemdSRTQ4R0w4WHFIVEk4OHVrZW5IN0RHTy9YKzZzaGRPLy9M?=
 =?utf-8?B?U0FjcDBnUEQvS3J6a0RZM3ZSSTFjdDhxdGlUVTRDR0IwcmliSHdpdnJBRzZZ?=
 =?utf-8?B?NWJGN1FiajMzTDI3OVlPdDR0UW01QVF6TTJqM1JsVzhZQUhzMDJCWk1xTUtL?=
 =?utf-8?B?M3lTR2ovcmNVVW5yamJtcjBETzFOSUpiRWo1WmRoaFBlUXY3M296RnFlU0lQ?=
 =?utf-8?B?VGdoRzllVHhwZWE2ZElneUs3YU1vSld6V0c2STdQRU0wajN6ZXVaZjQ5RVhC?=
 =?utf-8?B?bzhMRzlEZW5aT2pQWGZ5aHpOanpxOWVIVHpWYU15ZGw2UWpYenY2Y2VHTTdR?=
 =?utf-8?B?R2QweXBlV2lBM3c3RjB3bHJHRHRZSUVGZFRzUHBDdEVjanpTSUNwNGFldkhr?=
 =?utf-8?Q?2J90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUF3bjIxMFd3RzM5dlJaODdUN2hhbldUMEhRVWJ3YWdRazFEdCtqWmdOdVhh?=
 =?utf-8?B?NGsvR3V0dm93bThPeHlrUXJka05GdTRaQ0xjREtpRFlla3FDaFhHd0ZiV01i?=
 =?utf-8?B?SUlCOVNZTTZrOWRhd1grdTUxenRvNVRrNjM1dkYyQUhUN2tsTEJZNUdFbDlm?=
 =?utf-8?B?azNvbDgrdHFId2tVNW14QmNCZnJDSmVXcFc0ZzhNb3Q0Si8yYzM2bVJDd0VF?=
 =?utf-8?B?NURGY1c2bWNQdXc5b0FMQkRFOFh5UWhKUFVhdlRvSjdHQno4SnZFM1hXeWNz?=
 =?utf-8?B?TXJOcHliUXFkYWFFL3VjRVFnUWhRL29neUJPVTN6S3FqVk1RYzJHcC9hb0ZK?=
 =?utf-8?B?MVZpY3p0S1FwV0NtZVA5V2JOcWZLNkRDeG5Rc2JCMW92VkJUTmhkakxuUzFh?=
 =?utf-8?B?Zi9nRWNyNUFNSyszZVZkS2Q0d0pUNUhBU0xkb0VlWnZBTmpPRkdDL281Y09L?=
 =?utf-8?B?SktYSnA1V0laVTdwMHNuSW1mS0FTM2dLSkNmK0djQmZuU3pORlJLWGZCVkNY?=
 =?utf-8?B?aU11NEpSUE9tSndoK015UnR0aVd4c0tjei9FRlowdnhpK3Y1Rk84ckR3SVlG?=
 =?utf-8?B?TFRDcURmR091VVJDa211YlhXZHlpR3Zjem1pd3ZWd3hKQ29aRUFQQ2ZDSXh1?=
 =?utf-8?B?bTJCMytLSk0vTlhqSDBxRHQ5UFRXVFR5aDdHVTVxK0RlaFdaeDg4QVg4d1BH?=
 =?utf-8?B?SGV4SGRoZXprYWQ5S1VwT0xxZy9zeUJJR0t2THR4TjlkTFBkemJydGl3K2dS?=
 =?utf-8?B?ZVMxMzBiemRJQzFOMUJBMytXcWNyRG9Gbk9FNW8xQlJxbTMvVUR2YWFaVXVh?=
 =?utf-8?B?Wml4dHYvdE5Md2xweWRDbWVtcUYrb0g2ZU9xd1o1Ym42VzJTSjNIcW82WWU4?=
 =?utf-8?B?SDJwWjNxVUlOZ2QwUlN5cmtldmthaENreHQwd3pLYXZhTEx3VDZodEd5ZnRL?=
 =?utf-8?B?WEZTK1JGbjZvTTcxYTIrSTA0Y3E1MG1zeGNNTDd2b1RwbnAwVHVXQkl0bXMx?=
 =?utf-8?B?MWl0SlY0ZnlGblpWc0FZRTAzd2MxOEdBY1EvTHFVL09lQlpGRDVZUWROaHNG?=
 =?utf-8?B?ekZuRFYyRFBDWDhSRkU1Um1ZWkZ3dTlyNVY2Z2w3QkpCaFpKVGpZUGRTdnQ3?=
 =?utf-8?B?M05UTTlaVHNwTExpcnR6MjY1cy9sWkhvQUNjc2dwbkJleEY5VE5yeXBaTHNx?=
 =?utf-8?B?NVhudm44TWc3ZzFYN3RDSHpZOU40UVJpbzJsai95UGxhRjZTTm5BYWcvdlkv?=
 =?utf-8?B?V2E0anVIS21ib29LU1U2eFNZeE8zYWZXYW9FQ2VURlVWcGlEWHZuVWxoa2R4?=
 =?utf-8?B?Q0dxdDdVSExhSmVNZmx6K1gxYktyU2JiNTlsNWE3NWJuaWZacGh2QWE3MHJC?=
 =?utf-8?B?U0tmMEZmMkhVSkI3TzRIMzJnb1JnMXhER1AvRmsvUi90Wm1ZVjhJM3kzdlNy?=
 =?utf-8?B?WU9ZVWNXdC9xbmhMMFFscDBjODRMNWJBTCtmRnlkNXh6WGJXNWtzcldnSi9z?=
 =?utf-8?B?YURuaUdzZmZuYVI2WlduT2JLeHNQUzNMS1pmazVGMk0yMzViWGRuMi9teUNw?=
 =?utf-8?B?cm9JcWRuVWc1VUxScHRGempmR3Y1OCt3eWRXUU42cUFqWDdOWGNlN0VhaW1m?=
 =?utf-8?B?Y1hRbUkyUnUrZ1B2SmR6YmxSaEM2MXcxVWNMNnRQc3BIN2phcEU3enMrODQv?=
 =?utf-8?B?emRGTThYVS8zOFdQeVZpQXNrS0l6OGtheFd3TXkvQ0t4dXUrOTRLWFdYbUNx?=
 =?utf-8?B?clgzWVVVaVRKSjZHNlE4VytzL0JBbU1SR1pjNGxKNEFmRlNqZlYzSTNFSHE5?=
 =?utf-8?B?N3FGbU1sWVFMN1d1RS9TbHJsN2lMSENPdjhYZU5QMzRJTXJZTDIxd0lNaExi?=
 =?utf-8?B?cS9FUXUrUlVNYldRODJrV0xRenlkRVNSZ1VYVms5SVBuVmVrdFJjdWVsSTkz?=
 =?utf-8?B?R2pIdHl2TUxJMVl2VGp3WUdxbWVUSEJETHJzeHVSOSs5aVBzazYrMStEQVlq?=
 =?utf-8?B?RE1YZjFWelVOWjFkcjVTQ1hRMnl3RWJoeDVyemFXeFhSWGxScHBDNEhPQXRJ?=
 =?utf-8?B?ZE41RElvMHVLeUhja21manVwUGJQOGtOeWJQeGhZZDZQRzFEUGYzYmZVN1VV?=
 =?utf-8?B?WDVXV2k3OW11QTVEL1Mxdkc1YXZzcTV5REZvUmNjQms0WmMxL3RiVFFIZER3?=
 =?utf-8?B?eDI1ODhQNnhiNmpoNzNGMEs5MEo0SWJzSjhwZmJ2alk3U1dPRkhvdnA4cEVU?=
 =?utf-8?B?UW9pbFl1QlVDazVJaWZRY0ROaUNMa0FUa1B0a2w1U24rcFJDZWNRaWVRbHFT?=
 =?utf-8?B?Smk3azlQZ1MwbHNxYnZhYzVYQW1ZRWdCZDBhUzVzTEhkc0h2SlB0MFRuVXdk?=
 =?utf-8?Q?LcwAuQ4+atn5CLVw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 881b11ef-9895-4856-dcb3-08de6f986794
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:22:30.6226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b5iOWcEVne9Bk+9oWrp73rbqB9oj5Q7B9PW48pgrtqPJEYcW+xzcbtz0RJvU5nxzTKn+uejvjTDphmD2bCwxp1vVnLagp2bUIsXD+pqYKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE99BD3AEE
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

On 2/16/2026 6:27 PM, Bruce Richardson wrote:
> On Fri, Feb 13, 2026 at 10:26:31AM +0000, Anatoly Burakov wrote:
>> Currently, when adding or deleting MAC addresses, we are using
>> rte_zmalloc followed by an immediate rte_free. This is not needed as this
>> memory is not being stored anywhere, so replace it with regular
>> malloc/free.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/iavf/iavf_vchnl.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
>> index 55986ef909..19dce17612 100644
>> --- a/drivers/net/intel/iavf/iavf_vchnl.c
>> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
>> @@ -1402,7 +1402,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>>   			}
>>   		}
>>   
>> -		list = rte_zmalloc("iavf_del_mac_buffer", len, 0);
>> +		list = calloc(1, len);
> 
> Given the loop above has a threshold set for IAVF_AQ_BUF_SZ, maybe a static
> buffer of that fixed size might be better?

That size is 4 kilobytes, so I agree that we can use one buffer rather 
than constantly allocating/deallocating things, it'll still have to be 
dynamically allocated.

> 
> Also, that check itself seems a little off, since it allows buffers greater
> than the size, rather than ignoring the length of the address that pushes
> it over the limit.

Yes, this seems like an opportunity for a bugfix. I'll submit it separately.

> 
>>   		if (!list) {
>>   			PMD_DRV_LOG(ERR, "fail to allocate memory");
>>   			return;
>> @@ -1434,7 +1434,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>>   			PMD_DRV_LOG(ERR, "fail to execute command %s",
>>   				    add ? "OP_ADD_ETHER_ADDRESS" :
>>   				    "OP_DEL_ETHER_ADDRESS");
>> -		rte_free(list);
>> +		free(list);
>>   		begin = next_begin;
>>   	} while (begin < IAVF_NUM_MACADDR_MAX);
>>   }
>> -- 
>> 2.47.3
>>


-- 
Thanks,
Anatoly
