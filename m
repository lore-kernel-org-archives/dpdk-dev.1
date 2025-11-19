Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C0CF3182
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 09:45:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9991140265;
	Wed, 19 Nov 2025 10:45:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id D3F3540262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 10:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763545538; x=1795081538;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Cf8PL88ycinqo2USLTn7kpZs/HdibVC7DXH9LLYSJTk=;
 b=eoPz5EqsH4xAWD7ENmrjye2Fzh1fHjs/9iscIUhizF+SwVuZvUHPQt3M
 kmLACR54eqqEqnvcoB366EFyVBwoAl2jUHJHzB4LCV0viurGQxUqOx5Wj
 amHlkQq2Z/b4vVX1HGORI083Ik/V/f5LmGb6ErZzugAN/bdhqG/QMtVC5
 NxrnftnOaQkCqsbKVWsS/FF83A/TYO2mButctpzcJLW4aanyY3X70kJcb
 b6UeDwznA1rmYmyIwFXztOXhLXDCVlMxDnnTCbAyhO2AYHB4An3r9sK6C
 R7lQOy7X5fNl/JmKk+j2U/LMVcL2KRxPAoLFsb0UMh+ZjadZIve8GFC2K w==;
X-CSE-ConnectionGUID: HT9n4MOqRlmBhAg+bSVtoA==
X-CSE-MsgGUID: RUh3HRx6ToKW8SUXoRbasg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="64587622"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="64587622"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 01:45:37 -0800
X-CSE-ConnectionGUID: blIciMVYTCGiVZsKyE/E+Q==
X-CSE-MsgGUID: d0DCT28RQ368WjjGD0TQsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191264075"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 01:45:36 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 01:45:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 01:45:36 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 01:45:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNXjxqO2bHdM5iDo/GCkdraszA/MSQ/LJqcDGHlhlL2nmwf55j0EzUMHcfFX3/YNO2Y0EDevam/upiS+49pMPMIChEWgivuTa5GbG0NLvNOIU/3Ua5atXY7hk8a7nQMsKgTcfiKwJgPmowatSyW4Ui2v1/+gLdoLvH+HHxaeMWKJb9g/tum6WFH3zwKnrJX5OLwlwS6Z9BtsAdHOWX4UqOMLxDn85ukxN+Qo0HipdfoCig9XygYbnYm82o9CLRernmN5h2RSenaTaWI3emJ1yYKJ2CqPqvTTJ+zx6PhLj1hQd5vH09lqGVCqZGlbBQHdBCOvbAvTUQs1Qd7P0q1bqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf8PL88ycinqo2USLTn7kpZs/HdibVC7DXH9LLYSJTk=;
 b=U1e06gz/483yvKzdynz0hehrMIjDZyaiSXgpi/8WtAKG98lm3hOUtBVg9U7GKesw3Q+ufqa/J/sDsWOzAvAY+USGrmAyCdqDOs+VhVw+s10FwxcxSpX2MH/IVXyFwGKyzlo7O2/00UeKJPRnum3rN1VXNTgEdqpaKC/L/eaBtFhVDOJx3tKEben+vkg+zpyMz+60Mw+7l/MsycNYbIb2X+pYsbpegt1FqARJXajv5qJTh++ZYnKkvj5ozFt9k/GE+DvMpZaYBIZppQ2mrgXulT7+ZHkFWpOUCm9inCAtEw3ofdNp8a931MB4fEvYDBpcW41HHlxvKKfTHdTFtOCcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9040.namprd11.prod.outlook.com (2603:10b6:208:576::9)
 by CY8PR11MB7133.namprd11.prod.outlook.com (2603:10b6:930:63::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 09:45:24 +0000
Received: from IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f]) by IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:45:23 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>
Subject: RE: DPDK release candidate 25.11-rc2
Thread-Topic: DPDK release candidate 25.11-rc2
Thread-Index: AQHcU1XFtBXhw+b55Um1alW5IgF6XrT5yn/A
Date: Wed, 19 Nov 2025 09:45:23 +0000
Message-ID: <IA3PR11MB9040FAB24756DCE111D4C7129FD7A@IA3PR11MB9040.namprd11.prod.outlook.com>
References: <12952961.2vOk3Fo9v1@thomas>
In-Reply-To: <12952961.2vOk3Fo9v1@thomas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9040:EE_|CY8PR11MB7133:EE_
x-ms-office365-filtering-correlation-id: 85389c79-9b5d-44f0-df2a-08de27505caa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bGJTQ1N4V2RieWpJaXVUL2Ira1FFeTBFQVRQNXJaOHFlWnQxckttRHBGYm4x?=
 =?utf-8?B?NkFkcmZ1dmVDYTAyenlhdkNBek5yb20yNFNYV2JiNUk5c1pDMlF6WjllQlJN?=
 =?utf-8?B?akVJWjBBUWlzdi9iRDRwUkFHZ0NxekpkRmRGcjFrTElPL0lOYmp6RS9hMlBL?=
 =?utf-8?B?d1Iva0pWcFovejVjUnhldDhMaGNGUGltYzFFZTd1WkYxUjZpcFR0YVZsT28v?=
 =?utf-8?B?N1prQzBwNnJIV3ZsOTJaYzQrc2pJeXROL2RLa2ZiemlDUE1GTVpTZThCWmdJ?=
 =?utf-8?B?cUpQZ3pQU1Y3djVOekNsYVJjTWxxQ0FUVnlwajlnT2srUjdTdUw4emt5dGFr?=
 =?utf-8?B?RDZXU1IxUjJ0ZnN1MkhQS2pQUXBJQUZncVdGQjVoSGtuM2FxbGtKZmVsU3ho?=
 =?utf-8?B?bW9pMEZXWGt2K2d6bml1NlI3V2tjd3F5THVPUSt0NC9rOGxGS1RJT0FXeVl5?=
 =?utf-8?B?TThiOGVuQUhRYS9VWGU1cUlaNUxCSzFOcmFzV3dyZWxoSEtOckc4MHdsMlg4?=
 =?utf-8?B?TXQvY1JxVk9TV0RFdHRuVGQza1I4S2V4eE10OWtVQnR0WlRNb0YvZy8zNHRk?=
 =?utf-8?B?N3pkZFFIdmlhem9kRU80SjRBbnlyYjNtL3FjdGVtNlNyNGs3em00Vlh3ajhU?=
 =?utf-8?B?dEhpWFo1amNkd29oRGlXMW5FKytKSjdMdUEwd1BCekdGMTRQSENQcVBRSmo1?=
 =?utf-8?B?QmNjTzBiVDNOVytyMG9RV0pJcE40dE1BU2Y4NHIxak9WODF2cUVCbEc0SU1Q?=
 =?utf-8?B?R0U3SDhFTzIvSGJadmMwbm4vbSt3SVlncHppRWFFbmRJcm9Qck1ldjV4K1cv?=
 =?utf-8?B?QlNzcm51dHJhYnVxLzhtbmtiVFhIcXZaTnNOZjRPanc5K0dzU1BQNVdnbVRu?=
 =?utf-8?B?TVRqSE93RE5TbGhQUmR3eUZtUWYzd1NMWWtqL29TQXp4RDdjQUJUbEs4TXdj?=
 =?utf-8?B?Q3Q0NXZzSzVoYmFzV0t6VEkwVHA4bFVGU215VExIMWg5dEw0Rkl4Ynk1d1o4?=
 =?utf-8?B?WUl3alVhcW9vRUUwQnlIWXBzR3JyTFZQWWZjd3dVU1l1aVZrUXk2STJxSjN1?=
 =?utf-8?B?dGhVMkRDN09qdnFPWUpUbWVLOXYrUmFoV1RJeWFRUDFQbU1OaTBWZzJ1WDBa?=
 =?utf-8?B?UkZuZDdxZWxRbDl6Y2dFQnlPTHlZZGQ3YjJnYjJJVXZWem10NEo3WjNRaDBH?=
 =?utf-8?B?djZGc3l5VFpXYlJmL1lyQURMenFablozYVNaamN5RUtYOFlvVzB0Sk5tT0NS?=
 =?utf-8?B?OVZzNDBRVGEvYm1KL2RBSkZxQU8xTFdob3ZlTDBIMWtLN0NjUjlLZzd6d05a?=
 =?utf-8?B?YUpGd3pRNGhwYVBGblhaWEVaMG81TnhsQmVybjVLNFFyU3ZnWGVpbTdOOHAw?=
 =?utf-8?B?ODdqbjF1WC9ja1NBU25CVzRMZVo2U3ZuYWZsS1NJSVptak9PbVExSGxjM1Jv?=
 =?utf-8?B?TGRNeVQ5Q3p6OW9CUndJMUtzWVZVRk81S3JQSlNnUjRXSXM5RzdBaFZRTWI3?=
 =?utf-8?B?VVJ5UWdKMDdud3hIYkNGWVI2R1NSSHBrQzk1dWpEamRyK0dLVzk0QStwWlVG?=
 =?utf-8?B?REhWSllIcnh5cTd4VDZ5ekxJbjhCOUtSVmlQdFV5elZyYUVXcHZXenlNeGxM?=
 =?utf-8?B?K29qZGxLdVc3Zk5iaGl2REFxQ29MT3lVcFRLVVNQeE9WdnhGTTFNTFJoTXBp?=
 =?utf-8?B?aWZpZmtIVnVUNVhIZEkxRXR2T3d2TDBhb3RJN2R1VnloM0ZXb0VaTWpZSHdO?=
 =?utf-8?B?WCthSENZOG9rRnRQM1pNR1U1OXYwamwybWJUdWFIc3ovUnhJTHQrazBINWs2?=
 =?utf-8?B?OTduRUJIWnFuUXc4aUwzUjdweEtoUk5PYmppSnppejdLYXVzUXpuRVl1T21p?=
 =?utf-8?B?d3ZVdFVDTlEwQko4UkJpeGgxNXdJaHhya0x0Y0o5Y1o2RXFEN3JHcXRpZU93?=
 =?utf-8?B?MU9RczVhajJDbS9TVWE2cW5uc3pCWjhZeW1COXk2T2lvdmNReTJXbzM3Z3JE?=
 =?utf-8?B?L0hDZDRVS1RnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MCtzZFRQeTFRV3dwTUd4UE1yVlVpSGdzclZpSlZ2Wlh5WjJwa0xqSGlOMmV2?=
 =?utf-8?B?dnlyWVNaNzQ4VDdXSmdTZHl2NVdPbnBVbUFhdkVNUDRjcG40SGs1REw1cGp1?=
 =?utf-8?B?TU0xWkx1WGpNeXVaWXVNVk41eFNzYWhlNnV0U0ZGdXVZT2hWdTMybFM1N0Uy?=
 =?utf-8?B?ZTNhNHZTMHYwVTgrMXNGMDRvYlEwK0VUWHFYeHoyQXZ2OUd5TTVNMk5NTnk5?=
 =?utf-8?B?dk1oaVJjL3A3cER1eFRac0hUbENuUlFsTTZ5K1FaZWdRZXVzYWRjcFdwYzEr?=
 =?utf-8?B?UkVlSnZZbzFWZmxwWHg0d25jc1Frd215VXB4L2VaeHpRdVlhbmROb25SeXRJ?=
 =?utf-8?B?WjdrL1kyYzBzVGNsbmZVWGtIWVRrK1B3ZUdyVlh3OHVadUZNVnFYNExlV0hY?=
 =?utf-8?B?NmM2aHBUZFVpTWE3bi9USG5ZTEd1V054eXRYMlNLZlhNRWNoWkdJa1ltS2FH?=
 =?utf-8?B?TG43QklZdnI5WW1RY1RTTFp0VGE4WkhLby8wQmxRazJIcjNTbmdpWjcvUHhD?=
 =?utf-8?B?RFRQS0YwTHRkb1pIMUtmcGQ4OFByNFJaTEdKbDcvYVBvelNoemgxYmxqeHdI?=
 =?utf-8?B?UTQ1ME1jUTBRR25QYzNtTUY2YzhSYnJvanpHcy9zWUlNZ1VhTlRZY0RDQ3Rx?=
 =?utf-8?B?NjJyOStsYUp5TmNkeEw5RmJLd0lCS0Rab1VEZy80cGRnMWxJU1VMZVgrd3N1?=
 =?utf-8?B?Q2V6NzBxSEsvcTNvbW42RGwrekNGNmdGZWs0Q2ZReEpzZ3B5N2hlMUt6UlB4?=
 =?utf-8?B?dThnRnpQT2xocXc0K3ZZeU5vdG12aU5QKzlpZ05SRExNa2V5b04xNEMvVGd6?=
 =?utf-8?B?TEUzTlJ6UWZqZGZ1K1hiNzE2QzlXRWs0UEVJNFBZYUlkUkxJZzZ0TldhOVVF?=
 =?utf-8?B?Yk41SktWcVZ1VWg0eFZrTU42TDRWTDVVdFhHZzJKN3NIRVVkdkRoMjl3Nkhw?=
 =?utf-8?B?SmdwbFM4b0JyZVQ5enJTNDRUNDJiZ0Y1d0x6NFRFQUN5V3E0bzhzYXB2WWRO?=
 =?utf-8?B?NnFCTTh2SVFvSkV3aDNjQzBQWEk1bEJxSmg5ZmF1QzI5U2MxR25lVHEwTjhv?=
 =?utf-8?B?aVliY0drSEpWWldXbG05VHRCcVFKUEdrNXNQSTV5VC8rQ1ZRazFWbStLTDc0?=
 =?utf-8?B?N1VWZ2JDaUpZUjJkeU1QWElSbGdOdGI5V1A4OGhwODMxMUtHa29rWThUV1gz?=
 =?utf-8?B?dHY4b1VnenlFcmVZKzBsSkRjRzdQOEk3TXlzejdsbDVKbC82S0dJNk54OTdU?=
 =?utf-8?B?QWJyL0dZS2ZGTk9pL1pmV3BtVVhDc01vV1ZMdFFKcnJ5eE01R3hhczJNZ0Rm?=
 =?utf-8?B?ejdHYkFHd3czU3diL0o1MFZYdk1oRzZFaTVRbDNtck1pQ3RPL3ZUZDljYzRI?=
 =?utf-8?B?dFU1Q0FiZ2Z2WGlLeExlSmQ2TmJXRXowc2JubDJwY1AwZExpRWxkSEN3QnlQ?=
 =?utf-8?B?Nm5QZEtSa1NpWFRHajY0MWVTY0dFdDd4cE1OWUowdjN1U3BqekUvUU5mVnVu?=
 =?utf-8?B?M1FuMlpzTWE5aFB0M1hlR1FEeitVRktNaDNmWDlDY1lDQXhSa1JGOHY5OWlC?=
 =?utf-8?B?dnlQbDR6TmMydzZPRXkrem5XbTlGTlpSQmdHVVB2Si8xN0RVUGdrTmNMekxm?=
 =?utf-8?B?UURXbEVlVWoyZ3NpZVVjdFBJZ3duZHFLL1hnOVpQbWhxVlRYd2Uvc1JjbEYy?=
 =?utf-8?B?RnFJaHFsS1UwV0VBSExZVXJJQyt5RUJ3bHQ5M2JvMFZ3MDM1eHp1bWVkdDVt?=
 =?utf-8?B?UTVySXU1anZKaktRMjhWeFp4bWNUMmlBRk84ZGlrUGRDUFFNOC8ybWx0ak1m?=
 =?utf-8?B?SlFxL2U1ZjhydDM3bWtuNTQ1ejdZSHpzYnNmeG9PeEVGTnlSbFJhR3BwRXlh?=
 =?utf-8?B?UmdyNC8wbzBRcTUrSkp6T1RZK1JycnlGMUhqN3ArMWdvMGpETmpZNnRJRTFI?=
 =?utf-8?B?cU5GMklXaHNHVW1OdXVOU0lTZXZZTXgvRWZzYzNoRzc5U0daV1ZlOWZ0RVpZ?=
 =?utf-8?B?WlJuMEhCUitkcGNTRDdnSjFlRWJnZllzNEg4YmpqN3RJMHhrQVVlZE1jUWxL?=
 =?utf-8?B?YlpqVXRiaHVXSVQvaXB2Wm9CZ09McjdHZ0pHRnhFRFJidjY2Vm8xQ1IwYndW?=
 =?utf-8?Q?gWTVvLJmheWYqKpPiCYxahIZJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85389c79-9b5d-44f0-df2a-08de27505caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 09:45:23.8148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEb47pfOhWT8etQaWXbiMftIdlXStyKZDiutI8SYGnBoc9wu3CnZpE2RCRj1OKuzppqCrFFZuuj5DWjJ3GvgkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7133
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTIsIDIwMjUg
NTo1NCBBTQ0KPiBUbzogYW5ub3VuY2VAZHBkay5vcmcNCj4gU3ViamVjdDogRFBESyByZWxlYXNl
IGNhbmRpZGF0ZSAyNS4xMS1yYzINCj4gDQo+IEEgbmV3IERQREsgcmVsZWFzZSBjYW5kaWRhdGUg
aXMgcmVhZHkgZm9yIHRlc3Rpbmc6DQo+IAlodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL3RhZy8/
aWQ9djI1LjExLXJjMg0KPiANCj4gVGhlcmUgYXJlIDI1NCBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNu
YXBzaG90Lg0KPiANCj4gUmVsZWFzZSBub3RlczoNCj4gCWh0dHBzOi8vZG9jLmRwZGsub3JnL2d1
aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNV8xMS5odG1sDQo+IA0KPiBUaGVyZSBhcmUgbWFueSBm
aXhlcyBhbmQgbmV3IGRyaXZlcnMgZmVhdHVyZXMuDQo+IA0KPiBQbGVhc2UgdGVzdCBhbmQgcmVw
b3J0IGlzc3VlcyBvbiBidWdzLmRwZGsub3JnLg0KPiANCj4gVGhlIG5leHQgcmVsZWFzZSBjYW5k
aWRhdGUgKC1yYzMpIGlzIHBsYW5uZWQgZm9yIHRoZSBuZXh0IE1vbmRheSAoU2VwdGVtYmVyDQo+
IDE3KSBhbmQgc2hvdWxkIGJlIGRlZGljYXRlZCBtYWlubHkgdG8gZml4ZXMuDQo+IFBhdGNoZXMg
dG8gaW1wcm92ZSB0b29saW5nLCBleGFtcGxlcyBhbmQgZG9jdW1lbnRhdGlvbiBhcmUgd2VsY29t
ZS4NCj4gDQo+IFRoYW5rIHlvdSBldmVyeW9uZQ0KPiANClVwZGF0ZSB0aGUgdGVzdCBzdGF0dXMg
Zm9yIEludGVsIHBhcnQuIGRwZGsyNS4xMS1yYzIgYWxsIHZhbGlkYXRpb24gdGVzdCBkb25lLiBm
b3VuZCBvbmUgbmV3IGlzc3VlLg0KDQpOZXcgaXNzdWU6DQogIDEuIHBtZHJzc3JldGEvcG1kcnNz
X3JldGE6IHJ4IHF1ZXVlIGRvZXMgbm90IG1hdGNoIHRoZSBSU1MgcmV0YSBsaXN0ICAgICAgICAg
IC0+IEludGVsIGRldiBpcyB1bmRlciBpbnZlc3RpZ2F0aW5nDQoNCiogQnVpbGQgJiBDRkxBRyBj
b21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVzdCB3aXRoIGxhdGVzdCBHQ0MvQ2xhbmcgdmVyc2lv
biBvbiB0aGUgZm9sbG93aW5nIE9TKGFsbCBwYXNzZWQpDQogIC0gVWJ1bnR1MjUuMDQvVWJ1bnR1
MjQuMDQuMw0KICAtIFJIRUw5LjYvUkhFTDEwDQogIC0gRmVkb3JhNDINCiAgLSBGcmVlQlNEMTQu
Mw0KICAtIFNVU0UxNS42DQogIC0gT3BlbkFub2xpczguMTANCiAgLSBPcGVuRXVsZXIyNC4wNC1T
UDINCiAgLSBBenVyZUxpbnV4My4wDQoNCiogRnVuY3Rpb24gdGVzdHM6IEFsbCB0ZXN0IGRvbmUg
YW5kIGZvdW5kIG9uZSBpc3N1ZS4NCiAgLSBJQ0UtKEU4MTAsIEU4MjUsIEU4MzAsIEUyMTAwKSBQ
Ri9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2Zy
YW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUy9Td2l0Y2gvUGFj
a2FnZSBNYW5hZ2VtZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FD
TC9EQ0YvRmxleGlibGUgRGVzY3JpcHRvciwgZXRjLg0KICAtIGk0MEUtKFhYVjcxMCwgWDcyMikg
UEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9m
cmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQog
IC0gSVhHQkUtKEU2MTApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvVFNP
L0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBl
dGMuIA0KICAtIElHQy0oaTIyNikgUEY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9S
VEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9W
WExBTi9SU1MsIGV0Yy4NCiAgLSBJR0ItKGkzNTApIFBGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRp
bmcgYmFzaWMvUlRFX0ZMT1cvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmls
dGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMuDQogIC0gSVBzZWM6IHRlc3Qgc2NlbmFyaW9zIGluY2x1
ZGluZyBpcHNlYy9pcHNlYy1ndy9pcHNlYyBsaWJyYXJ5IGJhc2ljIHRlc3QgLSBRQVQmU1cvRklC
IGxpYnJhcnksIGV0Yy4NCiAgLSBWaXJ0aW86IGJvdGggZnVuY3Rpb24gYW5kIHBlcmZvcm1hbmNl
IHRlc3QgYXJlIGNvdmVyZWQuIFN1Y2ggYXMgUFZQL1ZpcnRpb19sb29wYmFjay92aXJ0aW8tdXNl
ciBsb29wYmFjay92aXJ0aW8tbmV0IFZNMlZNIHBlcmYgdGVzdGluZy9WTUFXQVJFIEVTWEkgOS4w
LCBldGMuDQogIC0gQ3J5cHRvZGV2OiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQ3J5cHRvZGV2
IEFQSSB0ZXN0aW5nL0NvbXByZXNzRGV2IElTQS1ML1FBVC9aTElCIFBNRCBUZXN0aW5nL0ZJUFMs
IGV0Yy4NCiAgLSBETEI6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBETEIyLjAgYW5kIERMQjIu
NQ0KICAtIE90aGVyOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwgQ0JE
TUEsIERTQQ0KDQoqIFBlcmZvcm1hbmNlIHRlc3Q6IEFsbCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0K
ICAtIFRob3VnaHB1dCBQZXJmb3JtYW5jZQ0KICAtIENyeXB0b2RldiBMYXRlbmN5DQogIC0gUEYv
VkYgTklDIHNpbmdsZSBjb3JlDQogIC0gWFhWNzEwL0U4MTAvRTIxMDAgTklDIFBlcmZvcm1hbmNl
DQoNCg0KUmVnYXJkcywNClh1LCBIYWlsaW4NCg==
