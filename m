Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D1C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:15:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31C87427BA;
	Wed, 16 Sep 2026 13:15:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id E373D4067D
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789557309; x=1821093309;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EFLBb/nFM6j3x75zIAP3rdO82yYWhdRaXbD/zFoIHbE=;
 b=ldgPEJhcODgQ2HjKbvl5LTGD1IXeOPJpVhWm5aVxNRiZhFf9VM/Lzsyn
 0ePshqLXi+Clxbm9EcgtjrGo+am4Fj0pMRXbKvszg00Zyq6vFrzFokt7r
 5vhHb33TiMaBePjmwsR4pFr7ICZ0PtrOjhp3MK4TttdQ2IQNzRCyWSrYx
 GJD2pAcX2raharnjiDaE4eZjHRNeZNzBsDVct0a0l/wfiDaSmpNK4ki6r
 276u9uIiwi4i0w5I8LQ0e/YwLPc8CRDLSywncRVQJ1tq6EEZaVlqTqfpr
 oKgYauPamTJd5U8Xy/aPLudhnERvlx5NFz4iSx90Wdji88LRoElilJjUY w==;
X-CSE-ConnectionGUID: 0CTLn6VCTaSjE0qUhbFHFA==
X-CSE-MsgGUID: +PzI76xNScet1nMY4Wcejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89949689"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89949689"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:15:08 -0700
X-CSE-ConnectionGUID: cvnuOMwtTz+BlkEYJsXNrw==
X-CSE-MsgGUID: mSDnSYKET+yaWG+Fdz9jLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="303193404"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:15:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:15:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 04:15:07 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1QacIXQshoXtjFfe5UjDGQ1CWePOFdeuDAr/FeTQQ1y1q28rdVSblWPI20SHlIoNyCqbHPAHjuBlLO07pVDWq+SC7c/IGREGQ7VHoidRpMdvWXE2qWDvMx2tAYlEiQO+MP4ycCGj2qZjdBaPSMA/BeACuv9JkAA5fahg/M/tG1QdA5QOK2YoWiE8htygupFhNWAGXipPf2Uck80wy+WnplzcSEoMWhvRo9w3fXqv0swqbz4bhzMFakzLB27Sch6ku477Ado9bBrAD77iefCkkVEiezac8ZHS4fNzNEpG0yelGgBoaTzU73VFXQ538w00TshbcQzi4k8d6u4sj4Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApsgcS19ES2YjwRC54NDTLVQoVTZFenUZJamiBmv7S4=;
 b=ff5DFMHOwKwMGAyVNJFhfMvLRhXihx/lbATp7/cTnqDG5VXcuWuYgSR25Uk3wPPOV2duw0izpxVhuN5SiJg/NFVF/Zv/J3NF4GhdEXGQD9o+ilX1qnTOFIFb+/XPOJ8Hvj5LJOBiWH4Amtu0/hJ298W4L0JOTD5rzt3ljksPwascoCONpha8Sg5tQ+jmA8WayNUECprdpkbZ0HdLaKsdrX9mO0HANllO6iF+0aG/f475EQVI+R3q3t3pvqz9pH3Hwb3jEvNZZSK4dvPiiSOGkR37TCvsC00Ac4MAVl9fv5YEMYDD2GpwGDMHh2ke3bVQQ3x+KhSnOVsW3Rwo3X4/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB6465.namprd11.prod.outlook.com (2603:10b6:208:3a7::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 11:15:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 11:15:03 +0000
Message-ID: <44344be3-9274-456e-8e94-423cb4e217bb@intel.com>
Date: Wed, 16 Sep 2026 13:14:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/26] vfio: split get device info from setup
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski
 <tduszynski@marvell.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, "Vikas
 Gupta" <vikas.gupta@broadcom.com>, Bruce Richardson
 <bruce.richardson@intel.com>
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <b4a07e530751c91f6c3d8a7619c4f926de6d1583.1789044747.git.anatoly.burakov@intel.com>
 <CAJFAV8znFXjkAzntYP9WMfDzh_NkuxuTTPpoZyenL7qAr4uNOA@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8znFXjkAzntYP9WMfDzh_NkuxuTTPpoZyenL7qAr4uNOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 887c7d15-f434-4765-0d15-08df13e3c19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: iQL63qr5HYdlBfTVEkQT97wlgSGhLm6Gir4f0H0nFZAmVKs+udHqPhX48S68U030FK8jjRGNsx4KhbCk+NdSY7OvSi7onvdpMku18WPZ7StKR2ZQiIVXLsjMuM8CfQ1KBiUshwTW6zLpTR2QkMxgqjJqwVxECiHDynGKdWvqw5Bta5FCRgu9larbeXLMnMYPpMYJo6fSVTRxKIFsYzIZ9Ssmo7HhW70vNgYm4nylfE8rCr8b+hRMjsquy7Pi5iQ+0iGbO5FlCQDBUmKR9gBpDOs+cRm90M12/TAD6NlKmuI4utpg+3oj2OUWc1yqa13ux3TY3ACdDRB8+nJEK4ZOqK2bMGLVDyK5rwU1NWKrQaaGAO4rGSfjxmUr+8B6lp1/KuPymfQNG8yN94HS4FAi0HMOVNIY65Ha+hvBdSFJfhetJX6qoHEwsYn6xxMXJv19Q6jArhlOfOp1wgLihUCngmmyZwXL6GtErODMnleZUQuU26qa7AjlY3uGL0bdDdCSZcrKpHsjK3CMQ2q1h4ADJotG9uSnknsbSGiHw6iKfcUrPbJvNj8obZGzyhGJjQLzy+hmRm77nYd/rWwMvMsVyFyjzC0QlQ27t6xHJUiV2pAv8rb/aQgU8Y9E1gaTQn2G9/j8nywxgJRpUGax+XMy44dt95V7RaYxfGXyyL9U1EM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXVKVzNRcDNsOGNVcXhDSUEzSDEyUGcxcktSNnV5T2RyUWE1dVkxbWpISDJz?=
 =?utf-8?B?QzBoMGh5OHJYU2puZjFaOStGZFR5L3Bod25MbEtPblRWTDNRdWkxeHRyYVFZ?=
 =?utf-8?B?UGJsWHdxZ0FxWXJidVppSktaRU5UeHNUOUZ2NkZneHhPQ01BdkI3UGtCUERE?=
 =?utf-8?B?RkUzSjNwUC9XYWxpZGFOOFgzemhhaHY1WlFTbzIxbFJwUFRQa2J3Y2NFdFFY?=
 =?utf-8?B?ZE93Um5wazVuR0tIWndjTWMwNldTRzQ0cUx5bUE1RlczN0RNS25vaEhDUEgz?=
 =?utf-8?B?SWFxRjVqODhPMXcxb1Q3ZkdTd0J2OVRSZFJldUhYZkdrcUt3SE5DdEpJSm1G?=
 =?utf-8?B?bzA5N3VrNDNaVHpyVWxHTHdWMFlCNmkwNjVqQmFGdStGeUVRakdGZEpnZnpz?=
 =?utf-8?B?WEJqMHZGSzJCanlJeWN6UDBFazdjZUoyb2FKM1Uya3ZiQkxiazNhNXBreHRl?=
 =?utf-8?B?T2g1VW4rdHQ3SXZPQzZ3MXJENEtuTnd6UEZQeHZXUC9xNldFc04xVzZRd0o2?=
 =?utf-8?B?c0crU3dXNGovYXludG52cjNtcVRGN0tPVGxTbkx0Z0F1cThNYVA5Mm5OVWx2?=
 =?utf-8?B?MWRHZFBJS1l6NHpLbVJqNnpVd29sQjdlV3dXYUxmTzZqQnV4RGV0cWtSVUgy?=
 =?utf-8?B?N1d5Z3RBRTMxV2dJSjIwV29xVkJIN1ZvQ2g5dzhMM0VNK3FhalM4ZGs3Q3h2?=
 =?utf-8?B?Zk1oQUF2cmt6Z2p5ajJVcWpyNWEyMWsxRW5FUjIxdnZCMm5NZWcyMTc4N29X?=
 =?utf-8?B?NEJ4bmpaK2VzS3RSdWpHNTFneSs2TnBGTGlnUnNPTTVIVUZ5UEpScW1IZ0JJ?=
 =?utf-8?B?QXVTS0NtY29LeCtMUW1HSlhuZ3ZoVTU4M1dNQUV6WGp4RnpWOEl0OW0xSzN4?=
 =?utf-8?B?d1NWSCsray9YRkorL0R1TUY5RWdtNytjNzlWdWZnNmtINkQ3Nks5b1c1S2VB?=
 =?utf-8?B?eVhQb2ZYeGpSTTFHaVdjODUxdVMwcytaMk9aTFRncm9kbEFqaUFNSjNNQWVY?=
 =?utf-8?B?OUVDR1ltRFBtcDlyaU5lNDBlR1RtVU5vdVpsN25lME1JdnhxdjNKRUJmSzl4?=
 =?utf-8?B?M1JtZC9ZVTVtbmVKS0c4OGRqY3FXRzU4cUFMMlk3czhnOE1HVkhEQm16Mjha?=
 =?utf-8?B?YVpqTWNUbzN3aTFOOXZHL00xaDU4T2I0OTA3V1dzeFF6eTlzdCtmQ1JnanpQ?=
 =?utf-8?B?dWc4TGtTd1hBdGdvaUd6Nmk5SGN1NkJjSWdMTjRIU2xjd3duQjhiWkF2UUdL?=
 =?utf-8?B?N1VQRlVMR1ZmMzVsSjlXajdlZ1lMSzJSUVM0YUtPbVdMc1EzZ253SnZPWklt?=
 =?utf-8?B?bzhZdEFGYi9PVHZKZmtOditYNis5eUJsWEk1Z0JGei9MTVZBeVR3NFVPUHcw?=
 =?utf-8?B?ajU4SVFHaFEvVEw0VXc3MmdvU21mQWlCZ3BLbzM1alFJbW5XcnEvSTA4S2F6?=
 =?utf-8?B?Z2l5MkM1eXNlemNEajBta1FFQ0ZSL0dIS21RbWxEL0owaG9sTTFrV0ZQc2hl?=
 =?utf-8?B?UUxIdE1YbVd4UEkyOE1iUWNtMkhVN0pqVWtGbXFUa1FSTVhmTmFoaGFSbkly?=
 =?utf-8?B?RXVQMlBONWN2Rmx3RDlGSjhrK2tia3ZSdVB2UGI5Tnh5aXQrMmNrdGVmK3BQ?=
 =?utf-8?B?Tk1pVS9mT2pxMHZXaGNlc0ZjazBiSmdoeC9VTmJ2N2J5VWhrRm5RRElKWFR6?=
 =?utf-8?B?dlNrOUJzenZHL3d4TzVJM2d3UkdsS21VWDVMTWtpU1ZkaCtaNkxCalNKMVRG?=
 =?utf-8?B?RVVCcHZMTEppRTB2ZjQrRlBzV2lmbDEwYmZVWnFIWC95YkhVV1dCamFVcGhW?=
 =?utf-8?B?dkJnTFQ4UlQ1emdyMFRBMzd0NVNJZktPQk5HdVc2bDQwNlR4VzZKQnU0cCtJ?=
 =?utf-8?B?R2VrK05zeUNZNE9hcmR1QXZEZmYzTlNyQTY3Y0xzdUxZYXVxZzFnNk5oRitH?=
 =?utf-8?B?b1NhendzWTJjWEpId1dUWGtpWVludStUd0ZGUzBqMWlIbXVOWmNRYTdaZmxL?=
 =?utf-8?B?QTR3M1ZHeU55bVJ0eUFkOVI1Wk5lNWNBMDdsN0dEUUlMZm9BSUR2UTNmWW9B?=
 =?utf-8?B?QUoxM2NNMWlybjlmbUZwS1VKU1VrRkJHcmlJbUZZeWdXTjZFSEh2b24rdk14?=
 =?utf-8?B?UXZiTm9HS05zK3hPbmcxb3IySzd4aEZEczB0YzFyZE5Vb1BzcmFORklzS0w1?=
 =?utf-8?B?bU85eWsyZXVGNndiSTNZMVFvc1JFYzFMK3ZiZnV2Q212TWxXSlRXa3N6Z0Jq?=
 =?utf-8?B?dnJmaVZOemppSW9tdmM3a0NFSFg0VXJsamRPQUpvbkFrOVk2b1VvODR3dVAw?=
 =?utf-8?B?Z3lxQU9KbG9qR1ZXOTlhZWYvNnBvNmRnbGNLTW84OXBhWklWTkxINzRWdVBp?=
 =?utf-8?Q?e0Cz18wr6T4l+fXc=3D?=
X-Exchange-RoutingPolicyChecked: h9xF3QXrWk/vQfiL+4XIoPAvzmR0WvLeX4ZOhydRmYBDbyfmXisSFbMDQri2DSlb7sL6bxnfRlRYWJ/KyctYkHDNbl/hcCSVlATuigJPrHCZEMlb53hvuWm5zC/FWexsQ0T4m5UNWA/cENsD6+wB2/RWi4qLuzRms4sZtbxsWxM+8VZoqCN7HaWXXyCNfcJj30A9dany6fri52geTbsH4ZZe9xx4ZiGunov2GuNv7vYI7HYevkCyiMXNOynFcxVsVN1devr+kI8dLuAKZR1SgOZODpNqgjrRxuJuOMjw731lbHObDrxxzfcZ1BZ+4sWALha7jIJW/MyOmScr9185bQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 887c7d15-f434-4765-0d15-08df13e3c19a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:15:03.7649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtPwfCPUVyT6iRLQMct/dT8ICfSFZhBDO9UatDFI3z4YqF8ZQNkyqbqwwN5Rm84JvfqLt6aNgH4JcB6UNJNtr7Vb8Be+oOG/8FVMW9PK5U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6465
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

On 9/15/2026 5:24 PM, David Marchand wrote:
> On Thu, 10 Sept 2026 at 14:54, Anatoly Burakov
> <anatoly.burakov@intel.com> wrote:
>>
>> Currently, setup gets device info as part of setup, while the separate get
>> device info API also calls setup if the fd is zero. Untangle these two APIs
>> and make each do one thing, and adjust all existing callers.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---


> 
> Not the fault of this patch, but comparing a FD against 0 is a bad sign...
> 
> 
>> -                       if (dev_vfio_get_device_info(rte_pci_get_sysfs_path(), pci_addr,
>> -                               &vfio_dev_fd, &device_info) != 0)
>> +                       if (dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
>> +                               &vfio_dev_fd) != 0)
>>                                  return -1;
>>                          /* save vfio_dev_fd so it can be used during release */
>>                          if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd) != 0)
>>                                  return -1;
>> +                       if (dev_vfio_get_device_info(vfio_dev_fd, &device_info) != 0)
>> +                               return -1;
>>
>>                          if (pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info) != 0)
>>                                  return -1;
> 
> And we have various leaks in case VFIO fails...
> 
> I'll make a note to fix this later as this is already present, unless
> you can have a look.
> 

Yeah, this whole "save fd in interrupt handle" is a bit suspect, I 
didn't want to touch that :D I can have a look later, but not as part of 
this patchset obviously.

-- 
Thanks,
Anatoly
