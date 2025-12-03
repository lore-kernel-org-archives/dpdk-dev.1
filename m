Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8A2D12D72
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Dec 2025 14:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6447F402B7;
	Wed,  3 Dec 2025 15:38:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A91724029D
 for <dev@dpdk.org>; Wed,  3 Dec 2025 15:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764772686; x=1796308686;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sFANbgSQA1PvSTcMdb9SO+ckAFQT26l3toqVu+y9StA=;
 b=n2m/k7/hNCrs3yXJgGvuQ79P0nCDAOw+7+sULYAks/eCbyX6AWSTgxq1
 ydgF3AhCwXgRBpnNVnJm+lISXbxCDWHgyxGQZREYZakxZ/taZLBiI009j
 tkSYKwuoKVavF/nvpiGGjTJF4YXlsKV57Os6c45n3bwycLeUCb3zUoVxl
 BTkWVpnAwb4C7QeGnSyqqg07rMYgaFsVXNCprAhvnWX+8j2t6qc9BVH9x
 GMFhUnlWqeY85TvWNU+/EHTezZMQ1O81FinBIGheLODo8K2Oyi1yeHkAb
 54j3RtzF+R9+gu4XugTVW/18KujVXQM/sqK2QbY3VFRT75YzfxE7Vw5uB w==;
X-CSE-ConnectionGUID: qc6rGh6XS+GGDi7YJxBPCw==
X-CSE-MsgGUID: sx8ko73FS9mvq0mrItD91w==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66657695"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="66657695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 06:38:03 -0800
X-CSE-ConnectionGUID: y6KxQVwJT3qeOao1FVNqFQ==
X-CSE-MsgGUID: VbbuIxT8TB+z71zSCLalUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="199109095"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 06:36:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 06:36:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 06:36:30 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 06:36:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhTx5o9GD4hU9kM733Q/BRok3VC4HOhUrvFl+3z6Xz18zgFAWice90tf9yShecAwgVZfPmSnUhxlGwoSgU5Q4+zpVIz+fujQyJVB0jvRyEvkI3tK1ldbhrmgDqQ5aYFB688lq9MsqdDKb8QKwwI6/u91lcYNF2NgjgcuSpE9lvbDtW5jFD992kwYR/v2b5GADa8ZOrSRkYHYujA/UWrfA+x62YNbnPNtg+mOjDqUO2c/s2TVyrRJp9DQ+7gNaZqRJuBgOrDGg3Q3Dw9NgsQV1U2pzmQATTWVpbbWnG+g9xldHnpsYPdigFvTI1TdtJjIFtnDHsI/kPdyXT9xkDLeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFANbgSQA1PvSTcMdb9SO+ckAFQT26l3toqVu+y9StA=;
 b=UB1Uh16TQt6rRod+gHaxWf7cpevoTCRm1T+4AuaeFWC6yoVOlqrcnfuaGQHsIpxz3Sf+lAVBfKOjgGWzW6ru+Q6xDsArO70wDyGFAbXhkLBqFz0f+v5h+v6onKASO51JTyIbtLldvdT20lNCZWiUfwadjMGTM/al1ZUf3ezP0XHFb6th9AKXWDj0lUfE0uHMhmXDHFXySvRWZc8HQxk2OGLbA1JNhWxuGaZnynSCwWfgZ+XQDsXURjm4x/zLFJHhnNI4EpGXZvKV3TFNvXHKETrZFZVuS/7y+3yJAd5upd3h7CKDrxpasq/aIwBg17vLa25bUiXD+7aIvY4zxJKGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by IA4PR11MB9108.namprd11.prod.outlook.com (2603:10b6:208:567::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:36:27 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:36:27 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Index: AQHcZEGAPn5qQK3460OIGurf0zTObLUPyuyAgAAkB/A=
Date: Wed, 3 Dec 2025 14:36:26 +0000
Message-ID: <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|IA4PR11MB9108:EE_
x-ms-office365-filtering-correlation-id: e3df1ec6-49ae-431e-e22a-08de3279573e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bXZjd2ZKRUVhREhoTWtOcFJYZDNyQnk5MWhnYlJ0ZUdGRW9ZWU5MUTNTV3Vu?=
 =?utf-8?B?QUxlcnBldERUYTMwWFY4U2dCcnlVd1IvM1JFTjQyVm00NDNja3FaNlYxSFNo?=
 =?utf-8?B?Wis3YnBvaFEra2RwOXBaRVo5aXRmcXliL2JVVkxmS3JqblJ0eE1KczhpWnVZ?=
 =?utf-8?B?d2dZeHI2Z3pSTElRdGtjV0diQTJHaHQ1OFRQeHdhdUdvZEREbVBiU0d2TFpV?=
 =?utf-8?B?TGZzRks5aVpORWRXWE01Z0E5UUo4QlBxMkdRSUdwOGNENmQySlh2N3hOTlZX?=
 =?utf-8?B?dnlsMzVqaVRBZXoxVkhVczg1RVVJWS9ja0RjdjYzR3RLckZLcjdpOU5RU2J6?=
 =?utf-8?B?dU1CcC9zZnhXMld5dHhlUGxEVnlSL2F4eHVLUUJrV001Q09vZmhjQjNZa1VI?=
 =?utf-8?B?VnBDM3NTbGVNK3VmdTZCdmVNK0lMRzBRaU5HUFFSSVNoUkhIaFJ4MUcyTlc5?=
 =?utf-8?B?Q2swZ1hqSG5XZkpTZ0Vma2RTanJDNFBKMEdqblVmamxSMmFHZnRaakVYRlhV?=
 =?utf-8?B?c0Ywb3UxT1pwTGlOeUVYK3pvVS80U0FWUXhyQXZFb2JBUkduVUhyZDliMXhR?=
 =?utf-8?B?aXVDcVo4NDk5aG4yVmsrSVY5dzV4RHlBSkJFdmFvV1N1VXgwZitweXh5K3VT?=
 =?utf-8?B?RDh0WEtuY1hlL0RsWVBpcGRZVVpjN0x5QW9VV2RnSitKY2IzMW5pOGNvK3FK?=
 =?utf-8?B?YkNIY0F4QzFmd0liNi9xSDdKN0FsSVpSVE9GVlBMcmVTMXpHZmpWU0R4aTg4?=
 =?utf-8?B?NU8wR2tGUVhyS3NsWVF0djd2MWYxVU9DUUFLdlMwSU1QOHV4SXVxVFVQYzhz?=
 =?utf-8?B?L3JiUmZxd3ovMGRXUkxMNTNjMHFKbStqaUJHZnhBb2xKRldHQzdDZ1UxZ2J3?=
 =?utf-8?B?VFA2bFlwVTY0NktSV1J2bTBNNWU5RWQ2OFVKVm5YNkwxc3g0Z3c0YktDMDBs?=
 =?utf-8?B?VHVoT01tcFhianBSbVdSV0xIdlZFKzBQOHE2NE1DMzhyK0c1ODFzaExlQnVY?=
 =?utf-8?B?ZDBGeXNBMWM1ZUN3dlJvZkRobkVtMWZXazhPck9xRVQxQkx1Wkg1TlNDaXhu?=
 =?utf-8?B?QVNKYUVqVnc1YXVPQ0IzUDF0MGlrN1BaTXhMS2MzMVNhN0VNeGdlVkRpSjN6?=
 =?utf-8?B?TlJ5VFc1SWhxalVuK01taG9ETVJFdFNnMUZnYkVZS1FORUtuQWdUZy9la25N?=
 =?utf-8?B?bGxKbVNoR2xXek91Y29mMEp6bnFDbHJMdmxUWGxPeFgvajEybXZtMmFLYm1s?=
 =?utf-8?B?OXFUZFlsdEZUYkFkc0lqKzdYam5yMys3cHdwdWdZbk5UdElhSDdqMmRabmI5?=
 =?utf-8?B?ajlheURDUk5RTlVMeklsKysvQmQ0YnFXMzFCVFdvYjBTZ2xpQ1pVdWxZVUVj?=
 =?utf-8?B?Z2lldmpvTkhhN3NLMUlhcFdQelh4c0ZvdFB5V0w5OHNUZS9HVUx1WnRYNE0w?=
 =?utf-8?B?SlFmNkwwQ3orOFVPbmZ3blRMNnpaTkF1VGtKYUZWT3IrVWhJNTFSYU00dW5X?=
 =?utf-8?B?b1k1L3MzNnlHUVpST280cjFyeGt3MVlpOEtXU21hNVF5MTBFOUhLMzFCRXlj?=
 =?utf-8?B?S0RyaEpHKzVPOFppNjdGS3FrSHdOU2hoN0ZUenFtUFM3RlZrdUFvUnJCNGpa?=
 =?utf-8?B?MHBIM2U4VDZwYWx0VzBhOTZ0bXQ3Qk5XUWFFQ0orcDB1bVI1YnJvVjRmdDlo?=
 =?utf-8?B?VDVZU3ZGNTNKcGNVeUgzUGZFQjQwN1NVQ3pISjBjSUJxT3hvTGQ2R0ZWSlF2?=
 =?utf-8?B?MGluajBSeFpBdExFT2ZyeEo0NnMrRnh1bkUxb1lhRWQzam5mV3JHcjdyUnZo?=
 =?utf-8?B?YWhzenhRSlVjY2g3allzN1F3Q2VzZCsvWlpTTENxdlVXUFMvNzNrM0lyc2to?=
 =?utf-8?B?Z1phOGxWRnVBd1pXaTFmRS8wdlFUaWRGaTBpYTluUXEyNncwZXZVTlBCQmRI?=
 =?utf-8?B?dTBpNDBVRnBURlBRMUhvNENwSEZuTDNJRUYvZjRGblgyQ2ZwbnUzUENRZktJ?=
 =?utf-8?B?WmI0L1RKNEZSaWFESmtWMWpWKytLRDFGdlV5dE5KVnl5cFhMenovMmtzaUYz?=
 =?utf-8?Q?LpDNY8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjRYRzZPd0t3N3JBTWVXbkxnU0pkY25BWjF5S1pWK3ZmOGllU2thM0srYjda?=
 =?utf-8?B?aGRZVUxTYlV4TVNpYkNNQytYS0JxeFFZS3AzRlFYUHNXUmdhOE5jTnkySm9y?=
 =?utf-8?B?dTJnSW9mclVHYjVVU0ZqUWZ3RllzdzhPSWlPMUptNWlVZWJteUxGeCtaN3Fm?=
 =?utf-8?B?bzVaNHlQNjlWMUJEYk9LOWlPcVE0R1VKWkM0Rm1SelkzZVhFcE5FY09EeFds?=
 =?utf-8?B?dW1SK1g0UUVuREhSTWtVQzk1MDdCOGZCMjlKVHFZaDIvcHkrM3MrWTlhOHFr?=
 =?utf-8?B?SDlLM1hHUVJocDBLcC92c0JTS04zRm1SM293VXhSUlRDM2ptQzJaQlJQeHRP?=
 =?utf-8?B?bnNVZUs0dHh6R3c3ajZIL1kzV0J3K2hoVStmckd1c05Mam1XeitvaTl1bndR?=
 =?utf-8?B?S29kLy8zWjBFQk56NWszWUEvU3dpa1NLRFJicEVkMXVsMFE5aDYyRXkyUWxt?=
 =?utf-8?B?UFROcndHM0Y1VnM5cTFlbzhJYzdyWUprUFl2Wk1OMHJ1MHdDbnkzbHBJSjBM?=
 =?utf-8?B?NEl1WVhQdHdyZ1Zod3paMFpzNGJPL0xKVEM4bXdLVUMvN3RjT2FKRUtqZDVS?=
 =?utf-8?B?WlJqUWo3eGkvUXllYVhsWXR5N3RGdVFRSHBhdlU5MWVqR0pzL0FtQ0d5TFpB?=
 =?utf-8?B?R3hlNmZ4VWk1RTFqellodnBwVzN4UkNFWUFxei9nZWR5QlZucXFzUzI0UWI3?=
 =?utf-8?B?SUJXYVVKQ0ppZlNNL3k4N1BMWkYvcHFYTDNWdVFEVU1JZEJPZVBJNWtPaEJP?=
 =?utf-8?B?SEZPTGYxUFpmWlZ1dldSMXROekxDREcrU1RhZlU2VWcxMEw3eFN2cEtaR25R?=
 =?utf-8?B?Z3NDeE93Q2dST3dxQkFIWGpQUyszMXpKcDBOa3NvbngweGp2ZmpUOWd5eERV?=
 =?utf-8?B?dmROc1pLVXlLVmRsem42ajlqczlTbG5DN29haW5OaTNIRVFHL3kyZGFEOUdN?=
 =?utf-8?B?N1BYMVZWek9udzR5SDN1MTE3ekUrd2VFT1Y2K2wzY0RMRjRnODVDRE15cWNy?=
 =?utf-8?B?ekNRdGxxa2pCek1LVGQvT05Sd1U4aGVNbU56UzIvQjBUTHdrU3A2R3k5Q3V3?=
 =?utf-8?B?SVErRU91SVB0QVJxRVNZQ0djZWRyTlYvQndrNTVNK08vOUZTbGc1bEY2TGF3?=
 =?utf-8?B?VEJTNng1aTZTMWRuZDg2L0N3dVlJb3hEcXY4NzJrMHhwbDVGaG90WG9uRG5y?=
 =?utf-8?B?Nk5hSmxudlhrS3pWVU9hWnZGMHZkMlV2WXZyYnRTZi9XVUVZRUNqMERhWjk3?=
 =?utf-8?B?NUdmcmkycEJLSlRSRkJRWXM4TTJUZWJrdVoxWWtSQnk0SGR0U1VXMDNsTDBr?=
 =?utf-8?B?MkdtSjR6Q3hWZ2hxR2ovdWYwY2FSQ1J0NktlRDVIZ2xFeXdHYlZCNHZFd0Nk?=
 =?utf-8?B?ZTlvakZEVmUyd0ZOQksrRjY2RWcvRmR0TUlVZkpUZ0pzQ0ZNNGxGeldMNFBB?=
 =?utf-8?B?Qml0S1JTZWErZ25JSVVuVVJRNkVQdzhwMkp1NHljYWVkMXpCQTc4aW0zQVY4?=
 =?utf-8?B?ak5vUjdCV1RGcnFVZUxqQ3JaNmZNdWtCT1YrNXQvQytKYkMzeG43c2VKc2FB?=
 =?utf-8?B?aVpjNDIrQWlwK0dPNlYxVSs4TGhIYjV1OVlaSFBCZVFJSE51WFRQQ3NEZUdv?=
 =?utf-8?B?c3YyNDBjZnl3WWZsbENEc3Z3Lzg2RitZL3VVWEY3VWlMTXk0TnF3RlkzZHJm?=
 =?utf-8?B?cXRFcU9sSSt2SGo1NUk2Zm85UmlURVZwQUhJbFl5cXpXTldYTlFqNzlDQ3l3?=
 =?utf-8?B?T2FWd29DYUR4Qml3ZUZIZzlMd0Y1S2toMkcrcnhGbzR4NU5yNDh4MFF6WWZr?=
 =?utf-8?B?Ym90QmJ0djVqZVdxZzNFeHp1Qm5RT29vZ3dvb1ZQUE96dEhiZmhjMGhSMStF?=
 =?utf-8?B?VXNUWEtXMXNDVFJKTk9WaktPei9WU0lrZHpQOE5zWmhZTjJTTmY3TC9MTG1E?=
 =?utf-8?B?RlZ6U3o5Tm9RQjBCTmJWcFhReHJPaWRaaTJ1SWllQWladWFLaWhxM0Y2bGZG?=
 =?utf-8?B?YXp3VHlhYyt5S1V2ZDY3ZG5La3hiZHhzR1BzWWRqLzUyZ005UGRPWkdMRS80?=
 =?utf-8?B?Vjlmd0VGNFczMjdMUXQ5aklmMGw0Wk5NbmQ3Q3R1c0duWXVPZ1JUTHBpeEdk?=
 =?utf-8?Q?+spd4PvCuSAvQ+XDsmau8+Nd7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3df1ec6-49ae-431e-e22a-08de3279573e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 14:36:26.6474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVj7i1T2e2Y9QUsX3KBz1yU6sIJCE07bOB9tJxbsD4OSTjeO07no8RO8ul+ZWXEIPVjUU7Syu9ERJqRV/KdIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9108
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

SGkgTW9ydGVuIEJyw7hydXAsDQoNCkZyb206IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJl
c3lzdGVtcy5jb20+IA0KU2VudDogMDMgRGVjZW1iZXIgMjAyNSAxNzoxMQ0KPiBAQCAtMTc2MSwx
MyArMTc2MywzOSBAQCBpY2Vfc2V0dXBfdnNpKHN0cnVjdCBpY2VfcGYgKnBmLCBlbnVtIA0KPiBp
Y2VfdnNpX3R5cGUgdHlwZSkNCj4gIAkJLyogU291cmNlIFBydW5lICovDQo+ICAJCWlmIChhZC0+
ZGV2YXJncy5zb3VyY2VfcHJ1bmUgIT0gMSkgew0KPiAgCQkJLyogRGlzYWJsZSBzb3VyY2UgcHJ1
bmUgdG8gc3VwcG9ydCBWUlJQDQo+IC0JCQkgKiB3aGVuIHNvdXJjZS1wcnVuZSBkZXZhcmcgaXMg
bm90IHNldA0KPiArCQkJICogd2hlbiBzb3VyY2UtcHJ1bmUgZGV2YXJncyBpcyBub3Qgc2V0DQo+
ICAJCQkgKi8NCj4gIAkJCXZzaV9jdHguaW5mby5zd19mbGFncyA9DQo+ICAJCQkJSUNFX0FRX1ZT
SV9TV19GTEFHX0xPQ0FMX0xCOw0KPiAtCQkJdnNpX2N0eC5pbmZvLnN3X2ZsYWdzIHw9DQo+ICsJ
CX0gZWxzZSB7IC8qIEVuYWJsZSBTb3VyY2UgUHJ1bmUgaW4gUnggKi8NCj4gKwkJCXZzaV9jdHgu
aW5mby5zd19mbGFncyA9DQo+ICAJCQkJSUNFX0FRX1ZTSV9TV19GTEFHX1NSQ19QUlVORTsNCj4g
IAkJfQ0KDQpUaGlzIGxvb2tzIGxpa2UgYSBidWcgZml4IHJlbGF0ZWQgdG8gU291cmNlIFBydW5l
Pw0KDQpBbnM6IE5vdCBleGFjdGx5LiANCkluaXRpYWxseSwgU291cmNlIFBydW5lIHdhcyBkaXNh
YmxlZCwgYW5kIE1BQyBBbnRpLXNwb29mIGNoZWNrIHdhcyBlbmFibGVkIGJ5IGRlZmF1bHQuIFRo
aXMgd2FzIGRvbmUgYnkgZm9sbG93aW5nOi0NClNvdXJjZSBQcnVuZSBpcyBkaXNhYmxlZCBieSBz
ZXR0aW5nIGxvY2FsIGxvb3BiYWNrIHdpdGggSUNFX0FRX1ZTSV9TV19GTEFHX0xPQ0FMX0xCIGZs
YWcgaW4gdGhlIFJ4IGRpcmVjdGlvbi4NCklDRV9BUV9WU0lfU1dfRkxBR19TUkNfUFJVTkUgaXMg
YWRkZWQgdG8gcHJldmVudCB0cmFuc21pdHRlZCBwYWNrZXRzIGZyb20gYmVpbmcgbG9vcGVkIGJh
Y2sgaW4gc29tZSBjaXJjdW1zdGFuY2VzLg0KTm93LCBNQUMgQW50aS1zcG9vZiBjaGVjayBjYW4g
YmUgZGlzYWJsZWQgYnkgY2xlYXJpbmcgYm90aCBJQ0VfQVFfVlNJX1NXX0ZMQUdfU1JDX1BSVU5F
IGFuZA0KSUNFX0FRX1ZTSV9TRUNfRkxBR19FTkFfTUFDX0FOVElfU1BPT0YgZmxhZ3MgYW5kIHNl
dHRpbmcgVHggbG9vcGJhY2sgd2l0aA0KSUNFX0FRX1ZTSV9TV19GTEFHX0FMTE9XX0xCIGZsYWcg
aW4gdGhlIFR4IGRpcmVjdGlvbi4NCg0KQXMgd2UgbW92ZWQgdG8gbWFraW5nIGJvdGggc291cmNl
IHBydW5lIGFuZCBtYWMgYW50aS1zcG9vZiBjaGVjayBkaXNhYmxlZCBieSBkZWZhdWx0LCBJIHRo
b3VnaHQgbm8gcG9pbnQgdG8gc2V0IElDRV9BUV9WU0lfU1dfRkxBR19TUkNfUFJVTkUgZHVyaW5n
IHNvdXJjZSBwcnVuZSBkaXNhYmxlIGFuZCB0aGVuIGNsZWFyaW5nIGl0IHRvIGRpc2FibGUgbWFj
IGFudGktc3Bvb2YuIA0KDQpUaGFuayB5b3UuDQoNClJlZ2FyZHMsDQpBbnVyYWcgTQ0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hh
cmVzeXN0ZW1zLmNvbT4gDQpTZW50OiAwMyBEZWNlbWJlciAyMDI1IDE3OjExDQpUbzogTWFuZGFs
LCBBbnVyYWcgPGFudXJhZy5tYW5kYWxAaW50ZWwuY29tPjsgZGV2QGRwZGsub3JnDQpDYzogUmlj
aGFyZHNvbiwgQnJ1Y2UgPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPjsgQnVyYWtvdiwgQW5h
dG9seSA8YW5hdG9seS5idXJha292QGludGVsLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0ggdjNd
IG5ldC9pY2U6IGFkZCBNQUMgYW50aS1zcG9vZiBvcHRpb24NCg0KPiBAQCAtMTc2MSwxMyArMTc2
MywzOSBAQCBpY2Vfc2V0dXBfdnNpKHN0cnVjdCBpY2VfcGYgKnBmLCBlbnVtIA0KPiBpY2VfdnNp
X3R5cGUgdHlwZSkNCj4gIAkJLyogU291cmNlIFBydW5lICovDQo+ICAJCWlmIChhZC0+ZGV2YXJn
cy5zb3VyY2VfcHJ1bmUgIT0gMSkgew0KPiAgCQkJLyogRGlzYWJsZSBzb3VyY2UgcHJ1bmUgdG8g
c3VwcG9ydCBWUlJQDQo+IC0JCQkgKiB3aGVuIHNvdXJjZS1wcnVuZSBkZXZhcmcgaXMgbm90IHNl
dA0KPiArCQkJICogd2hlbiBzb3VyY2UtcHJ1bmUgZGV2YXJncyBpcyBub3Qgc2V0DQo+ICAJCQkg
Ki8NCj4gIAkJCXZzaV9jdHguaW5mby5zd19mbGFncyA9DQo+ICAJCQkJSUNFX0FRX1ZTSV9TV19G
TEFHX0xPQ0FMX0xCOw0KPiAtCQkJdnNpX2N0eC5pbmZvLnN3X2ZsYWdzIHw9DQo+ICsJCX0gZWxz
ZSB7IC8qIEVuYWJsZSBTb3VyY2UgUHJ1bmUgaW4gUnggKi8NCj4gKwkJCXZzaV9jdHguaW5mby5z
d19mbGFncyA9DQo+ICAJCQkJSUNFX0FRX1ZTSV9TV19GTEFHX1NSQ19QUlVORTsNCj4gIAkJfQ0K
DQpUaGlzIGxvb2tzIGxpa2UgYSBidWcgZml4IHJlbGF0ZWQgdG8gU291cmNlIFBydW5lPw0KDQo=
