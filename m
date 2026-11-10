Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B805606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NMHpDOSp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABFA740283;
	Tue, 10 Nov 2026 10:40:51 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by mails.dpdk.org (Postfix) with ESMTPS id 1E87E4027C;
 Tue, 10 Nov 2026 10:40:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErZVbfLWIgduy2bs83C/3u+ZdAAmmir70vf0WC0lMH4IiHthjWUhHr92jfcKroPj5T116ESc8DOcnc+yqwElK3MdHPCcC+MppVb7YRG8gg6qZ1xzuKhk2KAncyiyOnejSy8NhXYVNkGpF/Q1ZgFdcr+uKAMmB0u43+afdq8iejSRx7gMgVnRc7wWIZziE7POnOKan9GizaQbgKUMnVg2Jz2u1GEC5wrQiuLqyV3Nr1lmhTByRRbS6iQ7RlXpkjQOEYGB5HGdFVFgg72a3k9NRI2uVYtMGE55d1l0tJvWPwCZmm4yU+ATViiXuZ0O9eQmhRxWb8nAU2pRRBM+Mz3YUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jWUpyv88GVoOLIaT2czcMEZaOEjnVHsaiFiqayfM9U=;
 b=iT0h4PIdEgcKZ+VK6kZF5iGSCv9Kc164FnTah8XgJIXF5SrnfJ5IMy2qtNbLeTjgw0By7pAVoxRJDzdhMmD1WYs9FQwpFHUKIm8tPL6ghrToCUp8uHKx+Zvckd1qebXeW2LYuz+4P+mx0An14R8xtYo1Sm2tn9tqX4bqYhN1CGQaS5xprTCf6m/P13KDFegitH5Mo83ntiCX6XizjjKswbwCpcBbFLwG0o3moP87VQb91QhweayjNS1MPW20A9/gZeIorgARNcrl2y75HsUmiLfeaCm7M5R4sAzGaRbTJV/UHA2Ko1hIPBw+aUxPd1tbJsiCefZIIrUasfmPXwOBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jWUpyv88GVoOLIaT2czcMEZaOEjnVHsaiFiqayfM9U=;
 b=NMHpDOSpuCaBxXfmlbK70cuf1dIx4Y+MqR8/+RWZZL68MtRp263a7Qpiuu8kqOkYrH2q92hlsXfHweIl+7Vvsd44tQc9XROwopMf02yZm29iaNpfn71Qpy1n5oLyYdxJV7EeJYLXbkJvgx6drYczIMZNOje/lUsa/gFUAsVFPvEI5uW1JFYALfQ6JQILuMh5PpU2Rv3z74q23FqihHBBScGzgtC8SLPncaxYmVFbTc7l1ZsD6px8lScGcxE7AG+qRibPOLk31GYx1VuvmYBeugVlW0/C5PIwbC3yOdK5etgzSnFoz72GUvAnPA05ityg879ZGzPd9HpRQzGwf9etMQ==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:40:43 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 09:40:43 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Shuaisong Yang <yangshuaisong@h-partners.com>, "NBU-Contact-Thomas
 Monjalon (EXTERNAL)" <thomas@monjalon.net>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "yangxingui@huawei.com"
 <yangxingui@huawei.com>, "liuyonglong@huawei.com" <liuyonglong@huawei.com>
Subject: Re: [PATCH v3] common/mlx5: fix high SMMU TLB miss with mempool
 alignment
Thread-Topic: [PATCH v3] common/mlx5: fix high SMMU TLB miss with mempool
 alignment
Thread-Index: AQHdbS8wkitL2nDEAUmNTb+lLfdtS7cnEeRp
Date: Tue, 10 Nov 2026 09:40:43 +0000
Message-ID: <DM4PR12MB6087DD6882E87E7EBD2ECF30DF722@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20261105140824.2094914-1-yangshuaisong@h-partners.com>
In-Reply-To: <20261105140824.2094914-1-yangshuaisong@h-partners.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|SJ0PR12MB5664:EE_
x-ms-office365-filtering-correlation-id: bf75ccdf-6079-4f25-7cfb-08df3f0eb078
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|10067099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003|261009220027099003|20046099003|18002099003|22082099003|16056099006|8096899003;
x-microsoft-antispam-message-info: lbkD4lCgxbLLsIrN16vPAp+9SvpJL7aDiOqXgAKNBzQ7+QEnytE6EdprQYAir4Hs0M5dTtD9c0fRe5MTQcKGePhE82i4a7VuvcN27W5hEWnVth3/k/youh8gj5GwE6m/nC/+BYjdZErw6wsOSREiTtE80xNfD9+uAONRWrq0Ing495z6/NXwxua5vbkenZEzTA5jRWGY1R513FJV5GxYkDN6zYXQ5swtnHQg5Y+aqFeJAKJrFiLfCP1PM20EWn66IsYX+A+Aux7wLyctXT0z1vYy8ggwZCSVNS+Sma/oJMnNHmey3wpEIGWAzpjsDfwG+R0A17kutmKepkub6N5WT1EEJjwpOe1NLBrxzzMv17JWT2VjcgDhlsVBVg+D5qZ9l0AvS2WhDeugKzB91cpGd2/N0kTVihl8wA4nddc1Tncs5cOavYXFVU51AUEh9FV+mD+Q39uQmHK+IfdiV5s6KhnNeUjUV/sFLc6gxz66MSTlL2u4IEbf4+vBPTn21gWWJd6Gf9J+JEhzKQRIacrGdWpabxf4Z83JH1L54CfDr3YHXad0q/S2xJ4jTLgoCXRdzJJ0p+qGhO4lqm27y9Sl0Fz7+MJFCNN8KUEhHXh1pO2AqUYINf6c9SHyIzfHnMvTy0YW5Z/AdedAeE/JCsUcGrnIoWiaYYC51RPXb20i9scdmVIbzMpGqj12Jf19t+C/MSwAi6osl0xN1DuiRAnS0PdWV+LRlSvq/MMyzJu5GmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(20046099003)(18002099003)(22082099003)(16056099006)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ViWORn7BZpsgYKXX+1jakV9fdcIUDrglVNeZY6G7H17G1F53Umf3IvjO6z?=
 =?iso-8859-1?Q?MqdKveDQrSU5CjgIuIagVuE9zb2cptd69C5W+sBCm51PZydQaMk90t2c1x?=
 =?iso-8859-1?Q?yuRjnNmx+ye/0BMp89mVbNbOUe+b2ggzbI533TRSNfI976aSRK8pvUPywQ?=
 =?iso-8859-1?Q?S+mrANv6UqqDyw124iw4Lrz7aCWh4lt1cW8YzAeUqu0Sy22eeNIZbkYbAb?=
 =?iso-8859-1?Q?v11xpLkf8RhfVvbznzxmM35n43RspCoJXRn1rJc2+bxFtFQCAiWUIiZAyO?=
 =?iso-8859-1?Q?foXnllNmI0rEOV6bM0f60AWqgNlXo0bh0l/MsYHb8bXdiXxdsI5yv3NjYh?=
 =?iso-8859-1?Q?kInmvZbdOJiTcSwH6PhFrs3y8kO0oxujamZVsp79BfVOvIkFg/is3YhHc2?=
 =?iso-8859-1?Q?a6veL/LmsCzprEF7YoFCDuxRaHZhHkNYwd+Ej8mEm3Oto/0r74zAMxoUGn?=
 =?iso-8859-1?Q?VAGjcfYH18/Rox/qazXPEvHyhKs7FdaP9j+qajW3v5UNp6qRsMK+0J6xVF?=
 =?iso-8859-1?Q?Goz39uFmOEaI+eN5Eh0OSO97EmtdkgS7NLmNQDBlq8gkgLcT2FDsFZ6BNj?=
 =?iso-8859-1?Q?GQgaJZiHEWk2fFXYtTSMXvjJUcBZM2YAVIzQ28gkioXeITjqk27lJy+BK5?=
 =?iso-8859-1?Q?6vuieuMweFwm/Z6VuvrgyTzQfc7NII652rQPXF9w+attUzAFHTbIcVmA2K?=
 =?iso-8859-1?Q?izFxUiBmf+9r+/H7E6Rq5t+29PPM+HYu1MeYEKwvhLSd6u5PCmLTEmbKJb?=
 =?iso-8859-1?Q?BwMA53b/vjJzZCc2de8G2zjxUxrvSOdSEASYDbb2RolwVv0pvrKUxS0lui?=
 =?iso-8859-1?Q?9A/ExFtFi57ldFZlSFbivLZSCTQyreka9+N8ZPA0vTCIKHAZuogwRtZmaR?=
 =?iso-8859-1?Q?cu86as/BHwzTVqsfVLWtsAA73gWHtWPZN2fKZ/xbCO4SNpMBPaNR9grlI6?=
 =?iso-8859-1?Q?p0DNFzyMnzyvEALHZxgP9fQv7prkLL63AuA8LpuBdeou4ZZ3PPUsG/DQmo?=
 =?iso-8859-1?Q?dHe+JJ+d5Dqaai/PVwTUwrNznh8A2H8iU1LFrUlooC4cOO4dwRQA2VWQzp?=
 =?iso-8859-1?Q?2Dip3r+v6vh/cDlfbZnSv4ET6aZA9Ng3znrWdlx4aPnYEKNcFDdX00INuD?=
 =?iso-8859-1?Q?z9kzyEp4GPls6SsxWYlK294yVU6VRJMocBwKDeFhnVpmvjT0msOlXZSay0?=
 =?iso-8859-1?Q?jerebBniYeKH2RfbrphfrbwNCpUiHGCHN0nOgd25ySAQRhR+2PyP5ScuNJ?=
 =?iso-8859-1?Q?DCLwLOcMuzjPW96YmjsazxxPOohkB2uFJHTcY0uNHco3aC4rqVt+xhOjxL?=
 =?iso-8859-1?Q?FCziNv0+uYT+kK/ZjnzEuqpo2DEt7WGI93pb/wdeiPs+jamh8pyHX5rAF2?=
 =?iso-8859-1?Q?jguqtPJ5WzbptAEi2NPr4xyeDlX7CTg2hgWumQlkFnObj1NBJXBbPlIz+P?=
 =?iso-8859-1?Q?Qa71Ux3XsbmTHfZZnZf+MQCZVY/6gFOxg6leYtoW5aT2kldeL/W7dZvG6g?=
 =?iso-8859-1?Q?ujbkIe/6HD12RDLnxQx41n390dOlF4zxpD44YdSAmYOLSu7EvkispdpGvV?=
 =?iso-8859-1?Q?+eSwxiaUkKv0p4XXBLvopouenIUZDC31NOXX1A0AjoDSsIrYd4H51h9LpA?=
 =?iso-8859-1?Q?1XHzlqnww6TbsbQsUWc0/3D+ahtObY6errX9Uu2977wCWsNhgwkB1WmsZZ?=
 =?iso-8859-1?Q?uIpK29mq1QUZasXZT1f4bDlrHRi6W+Tv9cIb/sPcBMeI5PaWSQ7yumDzwO?=
 =?iso-8859-1?Q?YVooOgT+MLTFXSLybCu/7qjiumXzkgd9mVAsGOqYKlRVmv?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB6087DD6882E87E7EBD2ECF30DF722DM4PR12MB6087namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf75ccdf-6079-4f25-7cfb-08df3f0eb078
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 09:40:43.2418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gJS3JWDcLw6kopwWmlOXIEuURcCkX+FsmXh77Jdj7WJuBdQ44eLArBPswvX+S8rPK/V3QPYXj+imJCZube0Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DM4PR12MB6087DD6882E87E7EBD2ECF30DF722DM4PR12MB6087namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
________________________________
From: Shuaisong Yang <yangshuaisong@h-partners.com>
Sent: Thursday, November 5, 2026 4:08 PM
To: NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Dariusz S=
osnowski <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>;=
 Bing Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou <su=
anmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; Dmitry Kozlyuk <dmitry=
.kozliuk@gmail.com>
Cc: dev@dpdk.org <dev@dpdk.org>; stable@dpdk.org <stable@dpdk.org>; stephen=
@networkplumber.org <stephen@networkplumber.org>; fengchengwen@huawei.com <=
fengchengwen@huawei.com>; yangshuaisong@h-partners.com <yangshuaisong@h-par=
tners.com>; yangxingui@huawei.com <yangxingui@huawei.com>; liuyonglong@huaw=
ei.com <liuyonglong@huawei.com>
Subject: [PATCH v3] common/mlx5: fix high SMMU TLB miss with mempool alignm=
ent

On Kunpeng SoC with mlx CX7, dpdk-l3fwd with intra-NUMA core pinning
under SMMU nonstrict/strict mode shows about 30% performance degradation
compared to cross-NUMA pinning. With SMMU disabled or passthrough mode,
intra-NUMA performs as expected (slightly better than cross-NUMA).

CX7 in NUMA1
NUMA node0 CPU(s):    0-39
NUMA node1 CPU(s):    40-79

intra-NUMA:
dpdk-l3fwd -l 40-55 -n 4 -a 0000:17:00.1,mprq_en=3D1 -- -p 0x1 -P \
   --config=3D'(0,0,40),(0,1,41),(0,2,42),(0,3,43),(0,4,44),\
             (0,5,45),(0,6,46),(0,7,47),(0,8,48),(0,9,49),\
             (0,10,50),(0,11,51),(0,12,52),(0,13,53),\
             (0,14,54),(0,15,55)' \
   --rx-queue-size=3D4096 --tx-queue-size=3D4096 --rx-burst=3D64

cross-NUMA:
dpdk-l3fwd -l 11-26 -n 4 -a 0000:17:00.1,mprq_en=3D1 -- -p 0x1 -P \
   --config=3D'(0,0,11),(0,1,12),(0,2,13),(0,3,14),(0,4,15),\
             (0,5,16),(0,6,17),(0,7,18),(0,8,19),(0,9,20),\
             (0,10,21),(0,11,22),(0,12,23),(0,13,24),\
             (0,14,25),(0,15,26)' \
   --rx-queue-size=3D4096 --tx-queue-size=3D4096 --rx-burst=3D64

The root cause is that under SMMU enabled mode, the mempool allocated
for intra-NUMA pinning is aligned to system page size instead of
hugepage size, while cross-NUMA pinning correctly uses hugepage size
alignment. This causes high TLB miss rates under SMMU.

For non-external memory, align all memory ranges to hugepage boundaries
during mempool registration to ensure hugepage_sz alignment, thereby
reducing TLB misses and fixing the intra-NUMA performance degradation.
External memory keeps the original behavior.

Fixes: 690b2a88c2f7 ("common/mlx5: add mempool registration facilities")
Cc: stable@dpdk.org

Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>

---

v2:
- Address review comments from Slava:
  - Call rte_mem_virt2memseg_list() in a single point inside the loop.
  - Skip the alignment block when hugepage_sz equals rte_mem_page_size(),
    since mlx5_mempool_get_chunks() has already done the alignment.
  - Skip the alignment for external memory with early goto, since ranges
    are already aligned to the correct page size.
- Update function documentation and comments.

v3:
- Drop the "if (is_extmem) goto out;" early exit: external memory now
  follows the original behavior again (if the entire pool resides within
  a single hugepage, all ranges are combined into one of the hugepage
  size and share_hugepage is set), while non-external memory keeps the
  new hugepage alignment and adjacent ranges merging.
- Move the .mailmap entry to its alphabetical position.
---
 .mailmap                             |  1 +
 drivers/common/mlx5/mlx5_common_mr.c | 85 +++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/.mailmap b/.mailmap
index 754dd9e760..b4a4646568 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1584,6 +1584,7 @@ Shreyansh Jain <shreyansh.jain@nxp.com>
 Shrikrishna Khare <skhare@vmware.com>
 Shu Shen <shu.shen@radisys.com>
 Shuai Zhu <shuaix.zhu@intel.com>
+Shuaisong Yang <yangshuaisong@h-partners.com>
 Shuanglin Wang <shuanglin.wang@broadcom.com>
 Shujing Dong <shujing.dong@corigine.com>
 Shuki Katzenelson <shuki@lightbitslabs.com>
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx=
5_common_mr.c
index cf39aa93e7..c215ef2bb6 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -1524,7 +1524,11 @@ mlx5_get_mempool_ranges(struct rte_mempool *mp, bool=
 is_extmem,
  * @param[in] is_extmem
  *   Whether the pool is contains only external pinned buffers.
  * @param[out] out
- *   Receives memory ranges to register, aligned to the system page size.
+ *   Receives memory ranges to register. For non-external memory, ranges
+ *   are aligned to the hugepage size if all ranges are on hugepages
+ *   of the same size, otherwise aligned to the system page size.
+ *   For external memory, if the entire pool resides within a single
+ *   hugepage, all ranges are combined into one of the hugepage size.
  *   The caller must release them with free().
  * @param[out] out_n
  *   Receives the number of @p out items.
@@ -1541,7 +1545,8 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, bool=
 is_extmem,
 {
         struct mlx5_range *ranges =3D NULL;
         unsigned int i, ranges_n =3D 0;
-       struct rte_memseg_list *msl;
+       uint64_t hugepage_sz =3D 0;
+       bool same_hugepage_sz =3D true;

         if (mlx5_get_mempool_ranges(mp, is_extmem, &ranges, &ranges_n) < 0=
) {
                 DRV_LOG(ERR, "Cannot get address ranges for mempool %s",
@@ -1550,33 +1555,69 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, bo=
ol is_extmem,
         }
         /* Check if the hugepage of the pool can be shared. */
         *share_hugepage =3D false;
-       msl =3D rte_mem_virt2memseg_list((void *)ranges[0].start);
-       if (msl !=3D NULL) {
-               uint64_t hugepage_sz =3D 0;
+       /* Check that all ranges are on pages of the same size. */
+       for (i =3D 0; i < ranges_n; i++) {
+               struct rte_memseg_list *range_msl;
+               range_msl =3D rte_mem_virt2memseg_list((void *)ranges[i].st=
art);
+               if (range_msl =3D=3D NULL) {
+                       same_hugepage_sz =3D false;
+                       break;
+               }
+               if (hugepage_sz =3D=3D 0)
+                       hugepage_sz =3D range_msl->page_sz;
+               else if (range_msl->page_sz !=3D hugepage_sz) {
+                       same_hugepage_sz =3D false;
+                       break;
+               }
+       }
+       /*
+        * For non-external memory, align ranges to the hugepage boundaries
+        * and merge adjacent ones. If the entire pool fits in a single
+        * hugepage, the MR for this hugepage can be shared across mempools=
.
+        */
+       if (!is_extmem && same_hugepage_sz &&
+           hugepage_sz > rte_mem_page_size()) {
+               unsigned int orig_ranges_n =3D ranges_n;

-               /* Check that all ranges are on pages of the same size. */
                 for (i =3D 0; i < ranges_n; i++) {
-                       if (hugepage_sz !=3D 0 && hugepage_sz !=3D msl->pag=
e_sz)
-                               break;
-                       hugepage_sz =3D msl->page_sz;
+                       ranges[i].start =3D RTE_ALIGN_FLOOR(ranges[i].start=
,
+                                                         hugepage_sz);
+                       ranges[i].end =3D RTE_ALIGN_CEIL(ranges[i].end,
+                                                       hugepage_sz);
                 }
-               if (i =3D=3D ranges_n) {
-                       /*
-                        * If the entire pool is within one hugepage,
-                        * combine all ranges into one of the hugepage size=
.
-                        */
-                       uintptr_t reg_start =3D ranges[0].start;
-                       uintptr_t reg_end =3D ranges[ranges_n - 1].end;
-                       uintptr_t hugepage_start =3D
-                               RTE_ALIGN_FLOOR(reg_start, hugepage_sz);
-                       uintptr_t hugepage_end =3D hugepage_start + hugepag=
e_sz;
-                       if (reg_end < hugepage_end) {
-                               ranges[0].start =3D hugepage_start;
+               ranges_n =3D 1;
+               for (i =3D 1; i < orig_ranges_n; i++) {
+                       if (ranges[ranges_n - 1].end >=3D ranges[i].start)
+                               ranges[ranges_n - 1].end =3D
+                                       RTE_MAX(ranges[ranges_n - 1].end,
+                                               ranges[i].end);
+                       else
+                               ranges[ranges_n++] =3D ranges[i];
+               }
+               if (ranges_n =3D=3D 1) {
+                       uintptr_t hugepage_end =3D ranges[0].start + hugepa=
ge_sz;
+
+                       if (ranges[0].end <=3D hugepage_end) {
                                 ranges[0].end =3D hugepage_end;
-                               ranges_n =3D 1;
                                 *share_hugepage =3D true;
                         }
                 }
+       } else if (is_extmem && same_hugepage_sz && hugepage_sz > 0) {
+               /*
+                * If the entire pool is within one hugepage,
+                * combine all ranges into one of the hugepage size.
+                */
+               uintptr_t reg_start =3D ranges[0].start;
+               uintptr_t reg_end =3D ranges[ranges_n - 1].end;
+               uintptr_t hugepage_start =3D
+                       RTE_ALIGN_FLOOR(reg_start, hugepage_sz);
+               uintptr_t hugepage_end =3D hugepage_start + hugepage_sz;
+               if (reg_end < hugepage_end) {
+                       ranges[0].start =3D hugepage_start;
+                       ranges[0].end =3D hugepage_end;
+                       ranges_n =3D 1;
+                       *share_hugepage =3D true;
+               }
         }
         *out =3D ranges;
         *out_n =3D ranges_n;
--
2.33.0


--_000_DM4PR12MB6087DD6882E87E7EBD2ECF30DF722DM4PR12MB6087namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Viacheslav Ovsiienko &lt;viacheslavo@nvidia.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> Shuaisong Yang &lt;yangshuaisong@h-partners.com&gt;<br>
<b>Sent:</b> Thursday, November 5, 2026 4:08 PM<br>
<b>To:</b> NBU-Contact-Thomas Monjalon (EXTERNAL) &lt;thomas@monjalon.net&g=
t;; Dariusz Sosnowski &lt;dsosnowski@nvidia.com&gt;; Slava Ovsiienko &lt;vi=
acheslavo@nvidia.com&gt;; Bing Zhao &lt;bingz@nvidia.com&gt;; Ori Kam &lt;o=
rika@nvidia.com&gt;; Suanming Mou &lt;suanmingm@nvidia.com&gt;; Matan
 Azrad &lt;matan@nvidia.com&gt;; Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.co=
m&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; stable@dpdk.org &lt;stable@dp=
dk.org&gt;; stephen@networkplumber.org &lt;stephen@networkplumber.org&gt;; =
fengchengwen@huawei.com &lt;fengchengwen@huawei.com&gt;; yangshuaisong@h-pa=
rtners.com &lt;yangshuaisong@h-partners.com&gt;; yangxingui@huawei.com
 &lt;yangxingui@huawei.com&gt;; liuyonglong@huawei.com &lt;liuyonglong@huaw=
ei.com&gt;<br>
<b>Subject:</b> [PATCH v3] common/mlx5: fix high SMMU TLB miss with mempool=
 alignment</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">On Kunpeng SoC with mlx CX7, dpdk-l3fwd wit=
h intra-NUMA core pinning<br>
under SMMU nonstrict/strict mode shows about 30% performance degradation<br=
>
compared to cross-NUMA pinning. With SMMU disabled or passthrough mode,<br>
intra-NUMA performs as expected (slightly better than cross-NUMA).<br>
<br>
CX7 in NUMA1<br>
NUMA node0 CPU(s):&nbsp;&nbsp;&nbsp; 0-39<br>
NUMA node1 CPU(s):&nbsp;&nbsp;&nbsp; 40-79<br>
<br>
intra-NUMA:<br>
dpdk-l3fwd -l 40-55 -n 4 -a 0000:17:00.1,mprq_en=3D1 -- -p 0x1 -P \<br>
&nbsp;&nbsp; --config=3D'(0,0,40),(0,1,41),(0,2,42),(0,3,43),(0,4,44),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
,5,45),(0,6,46),(0,7,47),(0,8,48),(0,9,49),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
,10,50),(0,11,51),(0,12,52),(0,13,53),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
,14,54),(0,15,55)' \<br>
&nbsp;&nbsp; --rx-queue-size=3D4096 --tx-queue-size=3D4096 --rx-burst=3D64<=
br>
<br>
cross-NUMA:<br>
dpdk-l3fwd -l 11-26 -n 4 -a 0000:17:00.1,mprq_en=3D1 -- -p 0x1 -P \<br>
&nbsp;&nbsp; --config=3D'(0,0,11),(0,1,12),(0,2,13),(0,3,14),(0,4,15),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
,5,16),(0,6,17),(0,7,18),(0,8,19),(0,9,20),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
,10,21),(0,11,22),(0,12,23),(0,13,24),\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
,14,25),(0,15,26)' \<br>
&nbsp;&nbsp; --rx-queue-size=3D4096 --tx-queue-size=3D4096 --rx-burst=3D64<=
br>
<br>
The root cause is that under SMMU enabled mode, the mempool allocated<br>
for intra-NUMA pinning is aligned to system page size instead of<br>
hugepage size, while cross-NUMA pinning correctly uses hugepage size<br>
alignment. This causes high TLB miss rates under SMMU.<br>
<br>
For non-external memory, align all memory ranges to hugepage boundaries<br>
during mempool registration to ensure hugepage_sz alignment, thereby<br>
reducing TLB misses and fixing the intra-NUMA performance degradation.<br>
External memory keeps the original behavior.<br>
<br>
Fixes: 690b2a88c2f7 (&quot;common/mlx5: add mempool registration facilities=
&quot;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Shuaisong Yang &lt;yangshuaisong@h-partners.com&gt;<br>
Signed-off-by: Xingui Yang &lt;yangxingui@huawei.com&gt;<br>
<br>
---<br>
<br>
v2:<br>
- Address review comments from Slava:<br>
&nbsp; - Call rte_mem_virt2memseg_list() in a single point inside the loop.=
<br>
&nbsp; - Skip the alignment block when hugepage_sz equals rte_mem_page_size=
(),<br>
&nbsp;&nbsp;&nbsp; since mlx5_mempool_get_chunks() has already done the ali=
gnment.<br>
&nbsp; - Skip the alignment for external memory with early goto, since rang=
es<br>
&nbsp;&nbsp;&nbsp; are already aligned to the correct page size.<br>
- Update function documentation and comments.<br>
<br>
v3:<br>
- Drop the &quot;if (is_extmem) goto out;&quot; early exit: external memory=
 now<br>
&nbsp; follows the original behavior again (if the entire pool resides with=
in<br>
&nbsp; a single hugepage, all ranges are combined into one of the hugepage<=
br>
&nbsp; size and share_hugepage is set), while non-external memory keeps the=
<br>
&nbsp; new hugepage alignment and adjacent ranges merging.<br>
- Move the .mailmap entry to its alphabetical position.<br>
---<br>
&nbsp;.mailmap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;drivers/common/mlx5/mlx5_common_mr.c | 85 +++++++++++++++++++++------=
-<br>
&nbsp;2 files changed, 64 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 754dd9e760..b4a4646568 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -1584,6 +1584,7 @@ Shreyansh Jain &lt;shreyansh.jain@nxp.com&gt;<br>
&nbsp;Shrikrishna Khare &lt;skhare@vmware.com&gt;<br>
&nbsp;Shu Shen &lt;shu.shen@radisys.com&gt;<br>
&nbsp;Shuai Zhu &lt;shuaix.zhu@intel.com&gt;<br>
+Shuaisong Yang &lt;yangshuaisong@h-partners.com&gt;<br>
&nbsp;Shuanglin Wang &lt;shuanglin.wang@broadcom.com&gt;<br>
&nbsp;Shujing Dong &lt;shujing.dong@corigine.com&gt;<br>
&nbsp;Shuki Katzenelson &lt;shuki@lightbitslabs.com&gt;<br>
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx=
5_common_mr.c<br>
index cf39aa93e7..c215ef2bb6 100644<br>
--- a/drivers/common/mlx5/mlx5_common_mr.c<br>
+++ b/drivers/common/mlx5/mlx5_common_mr.c<br>
@@ -1524,7 +1524,11 @@ mlx5_get_mempool_ranges(struct rte_mempool *mp, bool=
 is_extmem,<br>
&nbsp; * @param[in] is_extmem<br>
&nbsp; *&nbsp;&nbsp; Whether the pool is contains only external pinned buff=
ers.<br>
&nbsp; * @param[out] out<br>
- *&nbsp;&nbsp; Receives memory ranges to register, aligned to the system p=
age size.<br>
+ *&nbsp;&nbsp; Receives memory ranges to register. For non-external memory=
, ranges<br>
+ *&nbsp;&nbsp; are aligned to the hugepage size if all ranges are on hugep=
ages<br>
+ *&nbsp;&nbsp; of the same size, otherwise aligned to the system page size=
.<br>
+ *&nbsp;&nbsp; For external memory, if the entire pool resides within a si=
ngle<br>
+ *&nbsp;&nbsp; hugepage, all ranges are combined into one of the hugepage =
size.<br>
&nbsp; *&nbsp;&nbsp; The caller must release them with free().<br>
&nbsp; * @param[out] out_n<br>
&nbsp; *&nbsp;&nbsp; Receives the number of @p out items.<br>
@@ -1541,7 +1545,8 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, bool=
 is_extmem,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mlx5_range *ranges =
=3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i, ranges_n =
=3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_memseg_list *msl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t hugepage_sz =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool same_hugepage_sz =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mlx5_get_mempool_range=
s(mp, is_extmem, &amp;ranges, &amp;ranges_n) &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRV_LOG(ERR, &quot;Cannot get address ranges for memp=
ool %s&quot;,<br>
@@ -1550,33 +1555,69 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, bo=
ol is_extmem,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if the hugepage o=
f the pool can be shared. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *share_hugepage =3D false;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msl =3D rte_mem_virt2memseg_list((voi=
d *)ranges[0].start);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msl !=3D NULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t hugepage_sz =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check that all ranges are on pages=
 of the same size. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ranges_n; i++) {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_memseg_list *range_msl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range_msl =3D rte_mem_virt2memseg_list((void *)ranges[i].start);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (range_msl =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; same_hugepage_sz=
 =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hugepage_sz =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hugepage_sz =3D =
range_msl-&gt;page_sz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (range_msl-&gt;page_sz !=3D hugepage_sz) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; same_hugepage_sz=
 =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For non-external memory, alig=
n ranges to the hugepage boundaries<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and merge adjacent ones. If t=
he entire pool fits in a single<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * hugepage, the MR for this hug=
epage can be shared across mempools.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_extmem &amp;&amp; same_hugepa=
ge_sz &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hugepage_sz &=
gt; rte_mem_page_size()) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int orig_ranges_n =3D ranges_n;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Check that all ranges are on pages of the same size. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ranges_n; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hugepage_sz =
!=3D 0 &amp;&amp; hugepage_sz !=3D msl-&gt;page_sz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hugepage_sz =3D =
msl-&gt;page_sz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[i].start =
=3D RTE_ALIGN_FLOOR(ranges[i].start,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hugepage_sz);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[i].end =
=3D RTE_ALIGN_CEIL(ranges[i].end,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hugepage_sz);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i =3D=3D ranges_n) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If the e=
ntire pool is within one hugepage,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * combine =
all ranges into one of the hugepage size.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t reg_st=
art =3D ranges[0].start;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t reg_en=
d =3D ranges[ranges_n - 1].end;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t hugepa=
ge_start =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ALIGN_FLOOR(reg_start, hugepage_sz);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t hugepa=
ge_end =3D hugepage_start + hugepage_sz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reg_end &lt;=
 hugepage_end) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[0].start =3D hugepage_start;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ranges_n =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 1; i &lt; orig_ranges_n; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ranges[range=
s_n - 1].end &gt;=3D ranges[i].start)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[ranges_n - 1].end =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RTE_MAX(ranges[ranges_n - 1].end,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[i].end);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[ranges_n++] =3D ranges[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ranges_n =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t hugepa=
ge_end =3D ranges[0].start + hugepage_sz;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ranges[0].en=
d &lt;=3D hugepage_end) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[0].end =3D hugepage_end;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges_n =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *share_hugepage =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (is_extmem &amp;&amp; same_=
hugepage_sz &amp;&amp; hugepage_sz &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * If the entire pool is within one hugepage,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * combine all ranges into one of the hugepage size.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uintptr_t reg_start =3D ranges[0].start;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uintptr_t reg_end =3D ranges[ranges_n - 1].end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uintptr_t hugepage_start =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ALIGN_FLOOR(=
reg_start, hugepage_sz);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uintptr_t hugepage_end =3D hugepage_start + hugepage_sz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (reg_end &lt; hugepage_end) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[0].start =
=3D hugepage_start;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges[0].end =
=3D hugepage_end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges_n =3D 1;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *share_hugepage =
=3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *out =3D ranges;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *out_n =3D ranges_n;<br>
--<br>
2.33.0<br>
<br>
</div>
</body>
</html>

--_000_DM4PR12MB6087DD6882E87E7EBD2ECF30DF722DM4PR12MB6087namp_--
