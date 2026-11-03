Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5790606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=AnqtyPUp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8298F4064E;
	Tue,  3 Nov 2026 17:22:40 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11020093.outbound.protection.outlook.com
 [40.93.198.93]) by mails.dpdk.org (Postfix) with ESMTPS id 7E7E340265
 for <dev@dpdk.org>; Tue,  3 Nov 2026 17:22:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5hUnbKB9y0h0sBTMVICso1U8vAMBDxbuwjror/t1OkVKETHm3O6BRKwJ3tQC+K1NVMjY8i8/wtUoyok0IBpuzx1k/zzQLVf3F2fS2Bu67Cj3c/nmClTHtLKF0og382GZ0KAqDmBQ7QJ3vMu5BR2aSEEMekTLvLVjhoEP7hRpSR3vrV6KMbcbaKFs+U6+Im84K81kqZrZF/YJO9SblYoEQXUPqrSCMJyIaWFt3cuc7x38cbkStJ1c7IFzgBTuqrVw7NjBXwpUXANQzOAvxgtnZ4Um+USCc02W09OkSMh7KlPwZ4V3S03bHUxVsH9Yrb7Td1KYiE43UedJqQ6Yi7I5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws/+Fh5sCgbDttyMF7Fjoc+29j87In42xloGneM6tWA=;
 b=JmMvNNW5KYlAFQ8u4OdLnKpZnvubSJ2er4LAkAXckj9L26nsScjNeeUxcjT83+DdElgQTxhSF4i+TCGSQlM+6Sr1msipLT++RdNpOV5d5YwP3GI1xLHdx23XzmbhMmlhVFpsauVB4oP4UhGp/TEAX6XbhwnqwWKcEnixM4s9+fVGEo7VsYc6COc438usX72pEUTYVikYei4hWBY8R+ThFIbBmrAhaLivvPZXN/gbgug+AKHPNnHFEQ28PSZaMS8BHoRlNSpbFO6xDL5jK6LB7TASxtuaHc6b/jRhtPJka0pXplSj0M1bghjb3Yo7MuHCJj1UT3Ehz5r8IDAVg9C69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws/+Fh5sCgbDttyMF7Fjoc+29j87In42xloGneM6tWA=;
 b=AnqtyPUpy0hpwJvV8l5wjJXiStKf2HlWfc0rxgVC/Pv3pKjgPHX5eycPj5p7f4jAD/ZGkdiQEKL7wIKfeq93UUsDpH3mDfow0TlPTkWWq5DlaYCa6azLdHHMfcBi0RNWgjTImFcweym9V9hpNuDa8L0orF2iqtbRMbS7X/ArE1c=
Received: from LV2PR21MB6136.namprd21.prod.outlook.com (2603:10b6:408:34c::14)
 by LV0PR21MB6212.namprd21.prod.outlook.com with HTTP via P2P;
 Tue, 3 Nov 2026 16:22:35 +0000
Received: from LV2PR21MB6136.namprd21.prod.outlook.com
 ([fe80::1e8:9368:f13b:2833]) by LV2PR21MB6136.namprd21.prod.outlook.com
 ([fe80::1e8:9368:f13b:2833%4]) with mapi id 15.21.0615.002; Tue, 3 Nov 2026
 16:22:35 +0000
From: "Matthew McGovern (LINUX)" <Matthew.Mcgovern@microsoft.com>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>, Aditya Garg <gargaditya@microsoft.com>, "Khrum
 Kashan (Kashan)" <khrum.kashanjat@microsoft.com>
Subject: Re: DPDK release candidate 26.11-rc2
Thread-Topic: Re: DPDK release candidate 26.11-rc2
Thread-Index: Ad1rrzWAfc0wTp4GQriTtuamka4uRg==
Date: Tue, 3 Nov 2026 16:22:35 +0000
Message-ID: <LV2PR21MB6136B049268880F8BD299BC490692@LV2PR21MB6136.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b587deb6-c514-46c3-a954-3fcd9af14d2f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-11-03T16:18:59Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: LV2PR21MB6136:EE_|LV0PR21MB6212:EE_
x-ms-publictraffictype: Email
client-request-id: 8e33e07f-ae1b-4fbb-8bec-175c220d614b
request-id: 93bf32d2-135e-496a-398d-08df39c6aba3
x-ms-office365-filtering-correlation-id: 93bf32d2-135e-496a-398d-08df39c6aba3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|38070700021|56012099006|11063799006|261026121527099003|261009223027099003|261021135927099003|261021123027099003|10067099003|7146999003;
x-microsoft-antispam-message-info: u7itjAkXwvw+J6SCljrXIB9jpbY/XqksywukBiwY4JnbbfrP7vjvnEg0i29na4NqbXl7WuJILaine1ID0hF+uxidXcGg0keIXUBD1Ve5ItG7GNZkLySi2HxjYiSiOwAOlV5syo4KGZc1MJQbiZpf/1CuKwW2OBuX6QJmQoIxM1ibTuaS+iWUGVPJoAFEWzdAxYWmgGvQr/cN8shSV0+WWFRBVLuD5GPY1H0WfL+zroeY6RVp99An03zRPCMfsAzqJ9l4CRp19riPJtWv9jbtzMeNCAnomgEk9PNf2AhkUnYjxY+JLVwQtbk2Kdkz4101mnVHQte7ruECNySo0T+gPgHUxDQiChqDc4s8mmSQuq9XPPfSXNyob/d5y5e3j1/6LSoFwqklOQH0CifVheM9ievUzC8b7IGmN3ICB3peW/1plYvGwPkv0qXayk3WEqLF8yy0q8iauZeCrUmcr6b+op64S9eaJ9rcunM0rkriLQg1RsabH7zF9TEeWDhcjmq9QXKfFhrFZNd/6zgpKWLKjB4HIHkwGDS4Qvx6JVRpnQN1ithsR0WastEhbU8LTFBuFfTcvQrTIdFgNiByqVBrqGK6vWmzmXPpI+2bNTtgDkMBbDeQFH4bJe3r6cf4bmF9QZXE8O+THaQJId9ljNTj1VK5YTSdA7yXrhbVFBrw+VVazekx+Wp3NXNyac/KqPDH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(38070700021)(56012099006)(11063799006)(261026121527099003)(261009223027099003)(261021135927099003)(261021123027099003)(10067099003)(7146999003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nwjvm1kBRHHisjYbsVfuJCcmzAA+sxw97itRQpdJPoPktyuIpmKD+Q00+zrC?=
 =?us-ascii?Q?Y7i15ZgVWOAEgbJWTGXL6r0PnUqxSy6ZiVAmZBT6Q2ySebzTZEE1LyKFwLYM?=
 =?us-ascii?Q?1nyfgSHRmpKithsebpfQ4mnjKdWu72Prr8H3sOD9ethhB58mrTqnibdUXtGc?=
 =?us-ascii?Q?FGFTAFXyTCjxZ011JkBQm1kbOtm9PpeVUeOuFi97P6dFnx7RkN8nhhwR0sbF?=
 =?us-ascii?Q?2TFi8dbIu36ntybH4wbt8vWLYHLAGNboHC/NQv1uPmAy8PcFFFhj+YCIYbpi?=
 =?us-ascii?Q?Xy+rhuXEvsVfqryQhtFDrNG6Gy1wbV4CAIviqE4ewUz9qzxbT1NrGATHPMAu?=
 =?us-ascii?Q?tlcggmF6wrY3y+Hz+mSpAGyOEhcYbIIjjEo62dwSSTHxk8+Yh+qAwhc/gb+i?=
 =?us-ascii?Q?B7gkzuopGIqhpt4aJrUGZYSAaWhiYdM+Fvgv4AIHHXmngTsJ2M9zcasG4Dw0?=
 =?us-ascii?Q?FkkucWgX7SgIAVOTsJcqnHsVhTO9rh7YhHOwHlCTzTLFIolnyrDYbEDYIeLF?=
 =?us-ascii?Q?xcLUUNqG+JR6M98qsJebNVcMdXqxRqz5I1o/xvo6lB/PajVqv62yIb1UQmIf?=
 =?us-ascii?Q?4Jnq97RZNfb0LgICzEvGYgm04W2SsvHXnww5Z4sXWeI0eqRuThv3hn4vC8j6?=
 =?us-ascii?Q?e7KkBKeEEMcWGWJE3RyTc+Hc/Y6eAqDnLT9UOso5GZFbcp2eDbPJc70XJPnD?=
 =?us-ascii?Q?VbR3DSPktiAB+0BtkfoeBwPN2rQJKEaUNZ4WoJMU4XEEpBVozLFlqxM7Nevi?=
 =?us-ascii?Q?V16ILrean6/NAQw6vsSS3eAaDZZUUf4osi11MZwjsQGZK+141PNbNLW8W+Nn?=
 =?us-ascii?Q?JzRFzKo+VJkKpWH833DVRNNlRVtJs91g/+Tf8q9XftczdkeFDY7DY4wwPc56?=
 =?us-ascii?Q?Lj7bXqCNO+BralTS2liKsB4c2ht64Y6f8ccUUcfXC8iaFnDC5ZX8yD7AVaX4?=
 =?us-ascii?Q?0iR33h6k+AzNyXC2lBi7hhZEzf8AQfgbqYH2Ebq6hYv3A6kkKz/mRb92nRM/?=
 =?us-ascii?Q?g9p8JTCK2OdlZFW883y/lfRQGyaYamkT3sBhxPC8BtSiCQy88l4eyzX+0qNZ?=
 =?us-ascii?Q?j0EDzOFVPtOXb+kbHOTVmEpCUlp5WDBaSEJW6tWG5jKIhHyzQ3VKf63xKpt7?=
 =?us-ascii?Q?OSFiamrgRT3JhNZ+De5Ggt2BxPoLTHKkYokpR/XwjUoMZxVQ3j9tYTmYUOj3?=
 =?us-ascii?Q?6oGHrFXPseZBbiUN4mGNahWBHCsei5Cq6Xhhr9x/Vj9BMHfyhdk1OrB5NIq2?=
 =?us-ascii?Q?4M1EFwrR5ijfgMX4s9OHKjS7oVaBFWteA9QdlDqnect6v14rdGLCzzwQQZoo?=
 =?us-ascii?Q?QB4fIhD4wGgDoaIK7nQqUSRwiwwrac2OKWZEZuNX3BHb5ecp6WlKRxVkKbif?=
 =?us-ascii?Q?7bOC6Hfe55Ch0Y7Bhntn2JeZZWzT5MhmMhfSO7FPf+Oy8Pv5eSW/BgAE+hZA?=
 =?us-ascii?Q?v5CerdTQUWKefp+5lqkU28Yfcxht97KWysYywAfq5UyDTnz6494bGlYJJWgu?=
 =?us-ascii?Q?YtKq9gguqgVR28m9evgSm3symDk0RyLxW5JTSPYnHt2A39hoVbVukDdEVYdo?=
 =?us-ascii?Q?4S8fmHn6pIQG/WNPo4oOHDCyyHst4sFCn0IHgtPBU9husUeiUKCqRDzBGTf2?=
 =?us-ascii?Q?F4zhcfr5ZuKqv1fBN+FAgcKxuWFDs9E23WZ5Vtvvr9Qtao+C1rNOt9zyLq+t?=
 =?us-ascii?Q?rQYfkn+xjhOnG5hScJSI1XEaIXhVzg+1YxnLJKPnslSh45Qm5f8BoMCAcL5J?=
 =?us-ascii?Q?M5AZZoT+lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB6136.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bf32d2-135e-496a-398d-08df39c6aba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 16:22:35.5380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NaDhcn8qEHMoo2PnvUS0IKpYOKMDAJsri9DZKsyFWkJWf0igWLtFk5upi4BuCBCcvdEzrU7SCNuWEgXG0hkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB6212
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested DPDK 26.11-rc2 on Azure/MANA and found no regressions.

SKU 'Standard_E192ids_v6' with MANA NIC
canonical ubuntu-24_04-lts server 24.04.202610210
kernel: 7.0.0-1017-azure
rdma-core: https://github.com/linux-rdma/rdma-core/releases/download/v59.0/=
rdma-core-59.0.tar.gz=20

Architecture:                x86_64
  CPU op-mode(s):            32-bit, 64-bit
  Address sizes:             48 bits physical, 57 bits virtual
  Byte Order:                Little Endian
CPU(s):                      192
  On-line CPU(s) list:       0-191
Vendor ID:                   GenuineIntel
  Model name:                INTEL(R) XEON(R) PLATINUM 8573C

Results:
---
Dpdk.verify_dpdk_build_gb_hugepages_netvsc: PASSED
Dpdk.verify_dpdk_build_mana: PASSED
Dpdk.verify_dpdk_build_netvsc: PASSED
Dpdk.verify_dpdk_l3fwd_ntttcp_tcp_gb_hugepages: PASSED
Dpdk.verify_dpdk_l3fwd_ntttcp_tcp_hotplug: PASSED
Dpdk.verify_dpdk_l3fwd_ntttcp_tcp: PASSED
Dpdk.verify_dpdk_send_receive_1_queue_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_16_queue_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_2_queue_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_4_queue_1500_mtu_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_4_queue_4k_mtu_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_4_queue_8k_mtu_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_4_queue_max_mtu_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_4_queue_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_8_queue_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_gb_hugepages_netvsc: PASSED
Dpdk.verify_dpdk_send_receive_netvsc: PASSED
Dpdk.verify_dpdk_symmetric_mp: PASSED
Dpdk.verify_dpdk_testpmd_hotplug_sender_netvsc_pmd: PASSED
Dpdk.verify_uio_binding: PASSED
DpdkPerformance.perf_dpdk_l3fwd_ntttcp_tcp: PASSED
DpdkPerformance.perf_dpdk_minimal_netvsc_pmd: PASSED
DpdkPerformance.perf_dpdk_multi_queue_netvsc_pmd: PASSED
DpdkPerformance.perf_dpdk_send_only_netvsc_pmd: PASSED


-------------------------------------------
Matthew G. McGovern | Software Engineer II
Microsoft::Linux Systems Group::Kernel Team
One Microsoft Way | Redmond, WA 98052

