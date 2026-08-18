Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C0C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 14:33:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AF424027C;
	Tue, 18 Aug 2026 16:33:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id CE1A140269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 16:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787063579; x=1818599579;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=urKsv18kaissNAmpCDcvKMMhoISrR8uq0zQSbQP5eBE=;
 b=habIuZaf7sn+jAIYbo9Sq4Aamgbe0xEOeqBs0gYjREqu25kWH1D7anhF
 z7w4o+KJHZy3Bi7AvG9k0Dao02wG2W0M7uNN0jAndeTnXWCWW3u6qnYg1
 I7sjylx2jHZBCUk6LgJg7xQjiRWtvr7lMcf/aFIuTTU2+M4do5l7Gip/d
 0LcRAXNBevoZfpONppWNT4zCFG3KtPrj8+WbCsG+IjkgdBJTY61HsGLcm
 ViTyBY+eaNG8+9/eAW5wwcHvE9vWhd8n1rA5/1uN9uiF4q5tiulhI5uNO
 +L8o3jVOe6MA8vEnsPd4vsObGs+0bZNYzi7YaSzmiJHmH1lRfQ6iy9p58 A==;
X-CSE-ConnectionGUID: HCKkF09ITzOkmyh4SyVpiQ==
X-CSE-MsgGUID: GS7g/wssQMO1tkxD2MuLlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="75086787"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="75086787"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 07:32:58 -0700
X-CSE-ConnectionGUID: RkvTfqlGQjeP3Lz1ST0cEA==
X-CSE-MsgGUID: dhq6iUNbR6GabsDfoi6/TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="263511658"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 07:32:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 07:32:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 07:32:57 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 07:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSUKZJATgr+LM+NoT9Hbj0iO+r949NL2QAKr9iqrI1glNsz6qv3mM+gjCZH9Wqga9EoR94IqI5NGXOTe1+A7TRQf1xJV+1cZb+43RipsZ9RFGT4tu3lEO123KQWDB7QGptTpjLULcEVVaTclFZNaV9Qtf3BEDd8/2jhXC3IwDbx6VlDWVlP3pDkwPqJbkJxZzxNbgLpuh+P5S4ckrTV1juCU3df0L85A/5Uo95rGXOCgswXKwfyRjMniwjMzifXuIEoPGa+hoUmz2w9xi+f3sYYLeXBh4l+Fl/HGx/x1bifzCRJr8YbrFQUmzsuu4KHFqmBC/riFbVFwH+MdyLJsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eT+xpCg2G8EQZj4ngf2gTWwj7B0F3JMYcUnRj4l4bY=;
 b=mKepCmVzHQZWO4/eTbSs6Ib8qhMD6VRA2JkifuxkoahKWz6y24mnIi7j9cCI52tZAVyMBfgDAlsP/lk9NddPtUxxJykQ/uQrJeDodqLgAThYOHznSvb5B7MdykVZmuY5UVwYp0oSkuR/OS/iAw+T3sj06uy2TVdcNDP2ywOdj/O0VU8g5zFHiD5e7Kz1ypsTmGi95UCOx6wnWS4zgC32w88bUQdnpck6gIB0CG69Gwjac7XYVO67kD6+klDGpFOvvI5Qioha6Qq4cuMvXYhN9RIWYmy3yX0M3oSmIJ4CCN5akqh9irNRTW7xFbicUDYuId1r7DdO7rAbHl5sm8558g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 14:32:54 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 14:32:54 +0000
Date: Tue, 18 Aug 2026 15:32:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>, <ciara.loftus@intel.com>
Subject: Re: [PATCH v4 0/7] net/iavf: harden reset recovery and data path on
 link flap
Message-ID: <aoRtEjd2hNx6c7Tl@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
 <cover.1787028683.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1787028683.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DB9PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::27) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: d84629cf-e58a-411b-1a11-08defd35972c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: aRvpkRmYrypMxVC9i7NAOlMtZ6NgATT+QvPv8kuHsprP3uIwEoKfPydC5xnMf55HK2yJS5IsfG+GelGVk2y9ewF1a5S3Ydn1Rd5PC7KQ3Xr43EK+zkR3VjAe5aL0GucF7HEjkKoUwGRU4dsCgDqTV3VDBNaIS77KXxyv1PskVKlDmEV3leMiq4LHiIp3Ws9L1xLr1gfEJuVMxbCGkhUPR1OkOynufCZIvaXWxCDPzzq1Akbr2LhPBgE+9ogVZ/uo6DDYJemJAqW6AzJoqAIptdXn95JnuVLRqblqDG8h3JJuYPWB94g6cYBvUEwiO20jjsV1kNjYyURycZ/fteyuvdtf8mHMlzHL6qdXcbZ7lBMC2dD8lH6QsYeP3N4kO9n3lzAnC9miKkns+9l0KtRYOrU6zCKKt9KEKKY8YqbrTqnuGCqOGzocvEKEMWvYYXkggtIf/Umvk4qQUex2HShNinPvyBfguEryTXp5ugOw1sIpYaclzajCwXWPArtCM0yfzzW8UHxnxcbzeQc0oDyNGbkFTggFMd4ft/i6F610g8HFkg+Ew6H7O04hVs6GJ95MyLWlR5bRj5T0WthwdFfE83E4KAE6CZ4Ojs8AJwWwfL1/LWbmvIsIeW/A8SrYO2bh6NOXD3UDZ0I6bXrZTyq9Qfj5j4bd8o+8KQI+Y5UvAKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLrD6gJe+ds9ch169Zj8s+AIp7qYhYIQNVL/K1216VVYxNdXh47WPAfjTZsh?=
 =?us-ascii?Q?TiClFUKVLV4Gf/tYpeuD2jmDK3C2ryMSFJc5j+ooXknxKfl8HpTGFlFHXfXi?=
 =?us-ascii?Q?l68rKLMoQ9a+Y1HBh0ApNNWJl2vuWIWvfYJeoZ3FEZVx9gdqaQSvqlvElg47?=
 =?us-ascii?Q?QAW/+VkOC6wbANFVSoB/KXzJxYm6pvaJnOalrE87a5dFX9I6mQarVYUJmYbH?=
 =?us-ascii?Q?ZZVw+V8zI7xx/+ajrNGQXMoDhIIk2xs9gUI9FO9MJOBH/7GvbesS/d1MfKBB?=
 =?us-ascii?Q?F+5HAkPeIZ14to7XHA4VvR0aQ6xg0g6qB9KLXhDRfyFuKcT6rwm9HJbUVNV2?=
 =?us-ascii?Q?+H4MWdEmJNf6jt2y/gAhCUkZ7RUOcTYONDJGZWKChkrwpqO/t1VIdNQY3Ib2?=
 =?us-ascii?Q?VNZxhy4qetx65PF100HwlN/wVbvY2KgoA/MvyMRGkgedbb2ToFyDQimX7MXK?=
 =?us-ascii?Q?kSVOKhCvcc1N7QZDkO0Gst3VuTPdfCe37u30A3nSdq+0/3jmfQYuHCOppj2I?=
 =?us-ascii?Q?irIH7BEOqaMRwnzgDTcWHkRyi07687emwoF2dOsnTV9zNPAwee5OgGo0ifFK?=
 =?us-ascii?Q?iG8oI2krlhzj0yOcZEkELLVxqDB1Gi5KARdjvyV1lLfkdGy6uj32nMsJSswZ?=
 =?us-ascii?Q?3YDKfv2gjjiMMQ8FPnVNacYJXYzFT+IYMlkRiJqApBscGoJ9l80sNhvWXW4w?=
 =?us-ascii?Q?oUpeb0cJAFx5tTaYMGpxy2UdQHJ7X4beikpqmAVqs85uT4QnXXZaKDBRjyk9?=
 =?us-ascii?Q?GYkc8UGvdDxeChBqs5bVgFRPK7RXmQ057r7BDcCLozYrCXkzgS84eiULKB+4?=
 =?us-ascii?Q?KDndbnYYYido6h07a/DNcEYr+t+iiXQrz9qFv2snywMou0cNhleX9Z0QluwC?=
 =?us-ascii?Q?hsHjjIGM/CuYPaLoRWh6/BNhXGg0VciocfM2kI5WFj0/Scd9HRQGVjEyK7Ao?=
 =?us-ascii?Q?PLBbblL5K3QjnfnTS0VipV2OjPDR2+xf3HW56cMBWfx6v5CX/kv+19cEjcwT?=
 =?us-ascii?Q?FPFJsjdo2G1XgzIWA7NUnWfVzrQIKJaQqznlHkc0t52ds76i101eevg4sOQk?=
 =?us-ascii?Q?QkoQHPE4g+WUxb72MxkxbFc5pXIkdvyCs1fKDFL6jUEZItP8TtXS8g6+Me1Y?=
 =?us-ascii?Q?cwzyw+AKNQN8BcApVaIfKpA4L/aYjfVa204kCeGpMd6Utock6GOD5e/iO+ux?=
 =?us-ascii?Q?PTY+yJizinhclcQvWFsP20ao6GpWYTKnKOTLb+y792dYjWEcUuP6Wmz+xE1p?=
 =?us-ascii?Q?+u9BsLZeapdl8dN9lLLZ4Lqlio6WBLXjoGNyOiLuGwRthH06Xsr+Jjck5XGZ?=
 =?us-ascii?Q?YBj2sbU9QkQWN6yBTlq9jo992zK8Zaf5fDrqP6E0DxDFNg4M5yhkyorEFUcN?=
 =?us-ascii?Q?AkBi5xnVgAt0bBFE4bJfjLJwKUEhgQ4TERrdd0YAFiJjYFU7S2jZQKnf5Efo?=
 =?us-ascii?Q?e7D3BU2/eLz3qXCelcy3qzaZJ41fZF5ktmngaw/DBD1Lo9b2EVp30FGj2zy4?=
 =?us-ascii?Q?bwpvCs1vstD+S1KiIl7QTFoEUd1eiKccyXOfiglO0CO/6hhz5VTnIaOxgbkg?=
 =?us-ascii?Q?ZJTkLRRUXb4+FtCWK5K+NmupXy7UZP+pFW0VuGAFeGyXMK9MCR+b+nk26TOl?=
 =?us-ascii?Q?/0/BQ/hNrgYJ2t3fGAZ4AwzkXomHgRBw3XdxPQ+FNGH7CyZXv7xGJev243tc?=
 =?us-ascii?Q?QJ9qMuYInmNHZiCqBZh7HWY8alEP/nUeHDHyE+GHsQpNylFkctuzOZAv8oUD?=
 =?us-ascii?Q?LyjzEspFXE5kvmDQ/qOU2XFBAmIr5tk=3D?=
X-Exchange-RoutingPolicyChecked: itAXwjoyXqCfOhT6rZ+o8sGpsCFGfsrF5GullTU6iUroo8Mjod+0crs5JZQb0vEHPmQN537z5DVdsD3kfSL23aOTUlz52x6P3yup5baF7tLD6woo13iy6NTpTQhsv0vzNMazqw2HWRfV04D1lDLevv5DYvu9YKZhZwPmsgCDSa160LBHLB1QbrByyMPkNpLOlvZe50kwT4QrRPLyGru105ILICaoD1bEoeHuVSwVU4DceoyRMCUfxfzW2ufLVACHpKLSiEmkWE/Ft1JxVpCIUGSpd4MvjUYrdHBN92Mwej05bazIdxSUF6hkX4c1JM6m6XM/TCXpzvp4cQYqz9nb4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d84629cf-e58a-411b-1a11-08defd35972c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 14:32:54.7049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AS0uyuZdMSui/fBx6ptxs6INFXhdKt3DADyuXaKELiQZP3KzcSkYMcHHDuzqnXAOaWI2YT78lBH3AAjY/mA71kiRrZi50HuGUG7b7xC7M8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
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

On Tue, Aug 18, 2026 at 04:57:25AM +0000, Anurag Mandal wrote:
> V4-changes:
>  - Addressed Bruce Richardson's review comment on Patch-3
>  - Removed Tx drain on link down
> 
> V3-changes:
>  - Addressed Ciara Loftus's review comments on Fixes tag
>  - Added missing watchdog enable in Patch-6
>  - Removed extra space in commit msg of Patch-5
> 
> V2-changes:
>  - Addressed Ciara Loftus's review comments.
>  - Split Watchdog and flow flush from other patches.
>  - Shortened multiple comments and commit msg
>  - Prevented iavf_resume_pending_start() looping
> 
> During PF-initiated reset or a remote/ToR switch link-flap, the VF
> might miss the reset event, race on the no_poll gate, leak in-flight
> Tx descriptors, and stay down if dev_start ran before the PF VSI was
> ready.
> 
> This patch series build on the earlier reset-recovery fixes with the
> following:
> 
> - Reset detection: complement the ARQLEN1 check with VFGEN_RSTAT
>   (VIRTCHNL_VFR_INPROGRESS) and poll at a 5 ms interval, matching the
>   kernel iavf driver, so fast ARQ flips are not missed. When the VFR
>   is still not observed, recover anyway instead of bailing out,
>   keeping PF and VF state in sync.
> 
> - no_poll: make the flag atomic (RTE_ATOMIC) with release/acquire
>   ordering so the data-plane lcores observe gate changes reliably.
> 
> - Tx drain: add iavf_dev_tx_drain() to flush in-flight Tx descriptors
>   on impending-reset events before teardown, preventing
>   MDD events and descriptor leaks.
> 
> - Deferred start: when dev_start fails during recovery (PF VSI inactive),
>   defer it via start_pending and resume on the next link-up event so the
>   VF comes back without manual intervention.
> 
> - AdminQ: discard zeroed (opcode 0) descriptors seen during PF-initiated
>   resets to avoid the "Request 0 is not supported" log flood.
> 
> - Watchdog: keep watchdog armed for the whole reset window
> 
> - Flow flush: skip flow flush during PF-initiated reset
> 
> Anurag Mandal (7):
>   net/iavf: discard empty AdminQ descriptors on reset
>   net/iavf: defer device start when PF VSI not ready
>   net/iavf: drain in-flight Tx before reset
>   net/iavf: change no_poll flag to atomic
>   net/iavf: improve VF reset detection on fast ARQ flip
>   net/iavf: keep watchdog armed for the whole reset window
>   net/iavf: skip flow flush during PF-initiated reset
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
