Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A641C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 06:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1244F4028E;
	Tue,  3 Jun 2025 08:06:14 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by mails.dpdk.org (Postfix) with ESMTP id 210A14025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 08:06:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nwa7HHiNJBYo+q5nFONDPAqE+hu6KXqRAV+yv/8ogrgJm2RPcl+ZslqeBHEuS2BCC1lY4ynNoE6yDbs2icXd7AUfW7uB3UozN98EuByy5t9xdBv93NY1QhPQTOWtRW5JOKrE/mJP7i9jNYkC9KHa8XtxrE+B6EdXF+qvw6hI1lh2e19WxzjgVUPWvgnQBIkxF4DPodxqNLQxkT2BWWxCJLIhStA5f2651GNxv0NA9AQnZEG/P6A9fE3NVU8hFhPglLEO5HC+IoaejF9vfMMVEx/dpNaT/uWSfLBFfwzNOaF23syEyEs1UWAcAcfkkXHRKFYk8OZGGQjNMlDJJJk9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4uYLzhDYEcoOHq5DQNax4ZK6NOg6NRP6P7UMOABEYM=;
 b=UqShPj/1BHJb0ttVsfffrVLc7TZ5iUw7fGEc/O3/91Ejn2D5gZ+Dc1WgkOPJCZ57O3J1WoQwZjC56J66aSHPbdU4v5/zOAq/BYBlmyifUoyX8vHog3jxG/sNmYxeJ4kKNBhm3fmGHfdt7ElBjw6v0O/+QvW8htxPL/Bp9njrH8DBBiXiwIHuiY19h5gULzx7F1viVdwEv6P1eStRpz8pp0F6WYlv9MxtQ5AqOMlv5xxG0ntOL2nasORnrAQ7Kj+Nzku6m9femq7Ki5m69cNsACllGYRXA+lwtSba7Gatr0QO3NP1Vf/Mg1Hj1X3my5GoZ6G7VQhYxUctut4FAb8Ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4uYLzhDYEcoOHq5DQNax4ZK6NOg6NRP6P7UMOABEYM=;
 b=oZN4e8RV3NQFaS++WJgODu2gnXiOZ4mZa8NGiq8Tp4dwistnGzUtgaStjojVmi9/6whw8i9vGZ8z+4lHac1uyN/9eQb6gS/thtHtH9WhXNsrs2w8w++Td4xCJ6w2BG4XX9uur3WWCSx+4JR0nwMvKDT2Y4Y2r8z+tvVl6anFEDU=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 06:06:09 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8769.022; Tue, 3 Jun 2025
 06:06:09 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "vanshika.shukla@nxp.com" <vanshika.shukla@nxp.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>
CC: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
Subject: RE: [v1 07/10] net/dpaa: add Tx rate limiting DPAA PMD API
Thread-Topic: [v1 07/10] net/dpaa: add Tx rate limiting DPAA PMD API
Thread-Index: AQHbz7ztVub+vYqNzUORGyDAfpwOcbPw+0bQ
Date: Tue, 3 Jun 2025 06:06:09 +0000
Message-ID: <PH7PR12MB8596481604613E0A63DBAF4E826DA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
 <20250528103934.1001747-8-vanshika.shukla@nxp.com>
In-Reply-To: <20250528103934.1001747-8-vanshika.shukla@nxp.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=87da2eab-0034-4851-bcb3-4ef608918bf3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-03T06:05:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DM4PR12MB6278:EE_
x-ms-office365-filtering-correlation-id: 4531b780-034c-4a78-c98c-08dda264bc20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2kwDFg95TB0vVgBfkwvSGO4NUUlhp9YQEJ1Bh1TfqGHnEEQRY+CmSyzg6csB?=
 =?us-ascii?Q?elNPpa/mnf/wq4M5LolxR3uuqenomJTNOzMDJVJeQZtlw2EhT0F0qCDI+CTz?=
 =?us-ascii?Q?/V8lw1eehN9cIec+GtWbOBvfxMCTTkvbn0S6nKCtOncdKPPyFyd/h15btjjU?=
 =?us-ascii?Q?kOmZzubQ8QninYNfVefiVSD7+GvdVHmvgU9OZTMH7FhLZfxYH+mhH9RM68jK?=
 =?us-ascii?Q?mnKsSTM/ke1nPmlIosEDB8uTzJzZIl5YR+mZfzMxLWlRgiehhcgDjjO/A960?=
 =?us-ascii?Q?xN9MofvC3SsoEvPOrKvfH0MN93D0PYTlPO/Y+ULMUkf9KM8GLL9Keq46COlb?=
 =?us-ascii?Q?5D+kvMz6Wxqi4PM38IlEO41Q9ne5ygGVQM9NioG80Clhf3l6wuR2yTpDoR/+?=
 =?us-ascii?Q?XEBRvmGbvtzVU1NEjqQScVM9WWAv0NtqazogDO7M3WVuk8gJCNdTZgDdJq71?=
 =?us-ascii?Q?NnbIVykI5rr0tzYnCNKy8TIU4mMZNIQa0vlUlWbtfHLkcZ+JxO5NyhJY9LfT?=
 =?us-ascii?Q?vMCEM/epexrGpelcfI1lGlXEY39lM4fBb0RcGiPstJBZ1FLJX0S9Ovzf7Bxa?=
 =?us-ascii?Q?n90zdfOlrUWDi49lrJ+Dx9hpYuj6lweFbDzdYuUvPZOFIRD7xMXJqIP5Ii1h?=
 =?us-ascii?Q?LLL54yVAGsLirxBRUSZIZflXzjb+4S8bHCLHLqCoz9MRglw5QelrTc45fuBI?=
 =?us-ascii?Q?yQOIjuXeQneT9zbWwJrQ+L6qpgW+0lwQX9iNiKJKSwAy8SLJs7K4W1q9i6YS?=
 =?us-ascii?Q?9y/Tu45qCJVnzfx9apXByDp9lB2Proe4PVqxsQX4CCYBJB5/Df0cLyZSzfOk?=
 =?us-ascii?Q?OTd4DMb3QPtBFvh3ZHsmtUnVOmoVBEWfoS0Ni1785hPHh4w9LOGkqulS65cd?=
 =?us-ascii?Q?fOkjTNwvWDdm0BWiJtwFWvUKoFWmfGt0Ydb3EXP4rhe6lChuELztueXpQiqp?=
 =?us-ascii?Q?DJfm5kEBATYJeNlj0ms9pqcbaAgl1KvHga1TX4/Y58cqUm/XAq0eanj4Ue9u?=
 =?us-ascii?Q?IE7Wr8SxX/QT/NXDv3ewMO92hz2hy5xVI9NF2SckWA3jhA+abEvISlcUYS+z?=
 =?us-ascii?Q?IzrrbynnNKln4dvGGUCSWBDFc4xbtyvHRrSPRhReLEwxLjc5+Aq4uWGfRyaQ?=
 =?us-ascii?Q?wbnVj4PfetGyejdeEPojtgrA2VPjeEzxtvLoB5EjKBfb9XuhUKfR7AhupSks?=
 =?us-ascii?Q?KxFzPCGViEqfDQ33U4uD5BkPIrPYSFKcV3jl+FTBxm3nXev7edpYKRAIfj/s?=
 =?us-ascii?Q?y2XKtIXYbJgMLBF3R62wlGEnlHV43VibG6/8/N0qGdJziSbW17+a5ilPAsiu?=
 =?us-ascii?Q?uw6VjPxs+VxcjxB5XN/SLuFnB4ZZ3hXvea54bXPdgKRzeXMfsatbXiBQDzzl?=
 =?us-ascii?Q?sqOCE36qcfHmrEtpUWSkUBWRE+m2R+b11Z01UA2CXCRWbWf8xKQgmMHnZr1c?=
 =?us-ascii?Q?QddgJtAvX4my7DySGby0Fxd/87Z5p2p2/oyZixRacMIsMUXdc4baPIkqnT6R?=
 =?us-ascii?Q?WOU2BWCmpqoVr00=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bCxeLr+zapjCBBGHB3hP8FdndjdwTdQjm4RjwDZ+Hp8oEatlEZp4ebdJ38Na?=
 =?us-ascii?Q?Xm8dBFB1A19ZOatqXj+zN0vYrGayX8muzftjTg/CuYs9+2FmWwJQU9ffRNI6?=
 =?us-ascii?Q?U8jBc+pj8KXQVlHMgMw5TMMu/FEdI5adsMtxcUco5HLWZLwySRnSxFcazpLf?=
 =?us-ascii?Q?+u7F6RHeFLoFb6WjNK9hx6owPxiK8AAY3+gOrrGvc6ejENMVbVvP15T7+WAB?=
 =?us-ascii?Q?pR0vFrpDv+ytBUMn5LmGlT7U2mSGhjjkbjeQBzMW0CXnhBUkEIU1yjSUrJmJ?=
 =?us-ascii?Q?yI7S+HoE+lGko3UpxR7a6DvY/iyrx2l60FEU4PV4YkXtjVk2tVcoaNRA7bNQ?=
 =?us-ascii?Q?Bur91sOf498pWPax8dDKEMksic6Cb3wumsrD2gIsfoC8l4zIkkw5pUza4vkE?=
 =?us-ascii?Q?BKVZM5CTnpdI2nm5EdX4o+uwxwOsHZtO80BcRyvKYiVanHDfW7nMfvFcmmz2?=
 =?us-ascii?Q?g9sM1POneUSzV+ujJAw8KGVr2Ha307poFZEPUWaRZwQxNUn0Tee7+GbsyeL+?=
 =?us-ascii?Q?G6liRhJS0/GLfywPXCVlUY6XF3ltVA8SyzCxq31WFebBTV+6bv1ZjODKy1N6?=
 =?us-ascii?Q?vwE7eXe8ZrN2fo4E566e50We7JXTZHx6bUcZsP3IlHOse3FnLoLmdAasY9Cq?=
 =?us-ascii?Q?FEgkT5zecmwKmBZJPZ62f9+6eYKIkDErjgBxkjHdN/Z9p3B+NeJna8uuByC0?=
 =?us-ascii?Q?UJJg2GzknG3HhHH8tIv059Frrvs06s6GylutDTA5E3R3OnEBC3Z+g0wIrRV0?=
 =?us-ascii?Q?zTXAtbkqRlLLkQhuZi8Rkwz3fLG1hy/T7H0anAPj2c/OBfOpv6ETB1QDibBw?=
 =?us-ascii?Q?c9fxN+0QYMuPADfH3fZm00EbI1mNHFG6x363F5+muYlEUT5TI18kLLOTIyDb?=
 =?us-ascii?Q?Hi4b8+2j70pu0P5hl49A2pNdl17FoGb4gzH2VkR2fNejBel0X/ikAQUkG359?=
 =?us-ascii?Q?+Vu0m/Jv3cWt3Kcr/EtK5pRj+GiRjoaikiE/pbXCUf51BASWSS7btA0UYqCK?=
 =?us-ascii?Q?It5MduEd1favZO0s3kYq6Y5dItNFHIAlAt5FaPX8VlIgvQwGSuGWeWKtyw34?=
 =?us-ascii?Q?A2JBP7JI+n+A01T4bNJbz4bdGChoYlCPyKYkGxLZEcKT0qMDUq3Gc06wYM4x?=
 =?us-ascii?Q?Sw8zSfzU6xpDanUvrlEWBnFhjIE8ZVg7ufeSs+WdxbB+RDKfc3vDKjfq9mly?=
 =?us-ascii?Q?3+fedrObOC4SiF9P8hGIZu+YayPYSMP2gghiw7zT3XsVjbC6VK4TwQ2paYvo?=
 =?us-ascii?Q?7Yq45cMavINGeljG/EhSqMJRONB9PDRcrAEAPPmNOPqAmXS5aFhy6DVCLZId?=
 =?us-ascii?Q?Lvx8b/PTeEtWx6N0JONKgN99LDrP9TQOUdESDd5i4vj/zVCoDeuqpuYZe7yv?=
 =?us-ascii?Q?BLI22qk/G21NyiNaCjSJmUy3fRl2WUS5mHO3oe6KWFtSEKVseyn/J2WwwvCf?=
 =?us-ascii?Q?v1j8/L1l9EAtkTWfamME1YBFm3AGuPmlqrMc4aYynqd7PRa8gv5eFc3fDK1r?=
 =?us-ascii?Q?SHJ3JhbB2CKPMcin2JTKa9+ZPx1jDOo2KVaPT4pJDL43aDaVWmI/F7SZrFZ+?=
 =?us-ascii?Q?Zhg4TCHGz7obfrcRGFs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4531b780-034c-4a78-c98c-08dda264bc20
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 06:06:09.2598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkpMi+TtGEu78ZbrrThI5C5nxDYW7oEZpJLFtYqBLWfFYJvOOBJOdIkF/kXQ09NmcsO05Na+wnsB6DyXX3ZVjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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

[Public]

Hi Vanishka,

I believe you were trying to reach out using  email id `vipin.varghese@inte=
l.com`. Please use `vipin.varghese@amd.com` as I no longer have access to i=
ntel.com

Snipped

>
>
> From: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
>
> Add support to set Tx rate on DPAA platform through PMD APIs
>
> Signed-off-by: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
> Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
> ---
>  .mailmap                             |  1 +
>  drivers/net/dpaa/dpaa_flow.c         | 87 +++++++++++++++++++++++++++-
>  drivers/net/dpaa/fmlib/fm_lib.c      | 30 ++++++++++
>  drivers/net/dpaa/fmlib/fm_port_ext.h |  2 +-
>  drivers/net/dpaa/rte_pmd_dpaa.h      | 21 ++++++-
>  5 files changed, 137 insertions(+), 4 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 563f602bcc..d2d9ad2758 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1635,6 +1635,7 @@ Vincent S. Cojot <vcojot@redhat.com>  Vinh Tran
> <vinh.t.tran10@gmail.com>  Vipin Padmam Ramesh <vipinp@vmware.com>
> Vinod Krishna <vinod.krishna@arm.com>
> +Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
>  Vipin Varghese <vipin.varghese@amd.com> <vipin.varghese@intel.com>  Vipu=
l
> Ashri <vipul.ashri@oracle.com>  Visa Hankala <visa@hankala.org> diff --gi=
t
> a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c index
> 2a22b23c8f..eb4bbb097c 100644
> --- a/drivers/net/dpaa/dpaa_flow.c
> +++ b/drivers/net/dpaa/dpaa_flow.c
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright 2017-2019,2021-2024 NXP
> + * Copyright 2017-2019,2021-2025 NXP
>   */
>
>  /* System headers */
> @@ -669,6 +669,22 @@ static inline int get_rx_port_type(struct fman_if *f=
if)
>         return e_FM_PORT_TYPE_DUMMY;
>  }
>
> +static inline int get_tx_port_type(struct fman_if *fif) {
> +       if (fif->mac_type =3D=3D fman_offline_internal ||
> +           fif->mac_type =3D=3D fman_onic)
> +               return e_FM_PORT_TYPE_OH_OFFLINE_PARSING;
> +       else if (fif->mac_type =3D=3D fman_mac_1g)
> +               return e_FM_PORT_TYPE_TX;
> +       else if (fif->mac_type =3D=3D fman_mac_2_5g)
> +               return e_FM_PORT_TYPE_TX_2_5G;
> +       else if (fif->mac_type =3D=3D fman_mac_10g)
> +               return e_FM_PORT_TYPE_TX_10G;
> +
> +       DPAA_PMD_ERR("MAC type unsupported");
> +       return e_FM_PORT_TYPE_DUMMY;
> +}
> +
>  static inline int set_fm_port_handle(struct dpaa_if *dpaa_intf,
>                                      uint64_t req_dist_set,
>                                      struct fman_if *fif) @@ -889,9 +905,=
9 @@ int
> dpaa_fm_init(void)
>         /* FM PCD Enable */
>         ret =3D fm_pcd_enable(pcd_handle);
>         if (ret) {
> -               fm_close(fman_handle);
>                 fm_pcd_close(pcd_handle);
>                 DPAA_PMD_ERR("fm_pcd_enable: Failed");
> +               fm_close(fman_handle);
>                 return -1;
>         }
>
> @@ -1073,3 +1089,70 @@ int dpaa_port_vsp_cleanup(struct dpaa_if *dpaa_int=
f,
> struct fman_if *fif)
>
>         return E_OK;
>  }
> +
> +int rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
> +                                    uint32_t rate) {
> +       t_fm_port_rate_limit port_rate_limit;
> +       bool port_handle_exists =3D true;
> +       void *handle;
> +       uint32_t ret;
> +       struct rte_eth_dev *dev;
> +       struct dpaa_if *dpaa_intf;
> +       struct fman_if *fif;
> +
> +       RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +       dev =3D &rte_eth_devices[port_id];
> +       dpaa_intf =3D dev->data->dev_private;
> +       fif =3D dev->process_private;
> +
> +       memset(&port_rate_limit, 0, sizeof(port_rate_limit));
> +       port_rate_limit.max_burst_size =3D burst;
> +       port_rate_limit.rate_limit =3D rate;
> +
> +       DPAA_PMD_DEBUG("Port:%s: set max Burst =3D%u max Rate =3D%u",
> +               dpaa_intf->name, burst, rate);
> +
> +       if (!dpaa_intf->port_handle) {
> +               t_fm_port_params fm_port_params;
> +
> +               /* Memset FM port params */
> +               memset(&fm_port_params, 0, sizeof(fm_port_params));
> +
> +               /* Set FM port params */
> +               fm_port_params.h_fm =3D fm_open(0);
> +               fm_port_params.port_type =3D get_tx_port_type(fif);
> +               fm_port_params.port_id =3D mac_idx[fif->mac_idx];
> +
> +               /* FM PORT Open */
> +               handle =3D fm_port_open(&fm_port_params);
> +               fm_close(fm_port_params.h_fm);
> +               if (!handle) {
> +                       DPAA_PMD_ERR("Can't open handle %p",
> +                                    fm_info.fman_handle);
> +                       return -ENODEV;
> +               }
> +
> +               port_handle_exists =3D false;
> +       } else {
> +               handle =3D dpaa_intf->port_handle;
> +       }
> +
> +       if (burst =3D=3D 0 || rate =3D=3D 0)
> +               ret =3D fm_port_delete_rate_limit(handle);
> +       else
> +               ret =3D fm_port_set_rate_limit(handle, &port_rate_limit);
> +
> +       if (ret) {
> +               DPAA_PMD_ERR("Failed to %s rate limit ret =3D %#x.",
> +                       (!burst || !rate) ? "del" : "set", ret);
> +       } else {
> +               DPAA_PMD_DEBUG("Success to %s rate limit,",
> +                       (!burst || !rate) ? "del" : "set");
> +       }
> +
> +       if (!port_handle_exists)
> +               fm_port_close(handle);
> +
> +       return -ret;
> +}
> diff --git a/drivers/net/dpaa/fmlib/fm_lib.c b/drivers/net/dpaa/fmlib/fm_=
lib.c index
> b35feba004..d34993de38 100644
> --- a/drivers/net/dpaa/fmlib/fm_lib.c
> +++ b/drivers/net/dpaa/fmlib/fm_lib.c
> @@ -558,3 +558,33 @@ get_device_id(t_handle h_dev)
>
>         return (t_handle)p_dev->id;
>  }
> +
> +uint32_t
> +fm_port_delete_rate_limit(t_handle h_fm_port) {
> +       t_device        *p_dev =3D (t_device *)h_fm_port;
> +
> +       _fml_dbg("Calling...");
> +
> +       if (ioctl(p_dev->fd, FM_PORT_IOC_REMOVE_RATE_LIMIT))
> +               RETURN_ERROR(MINOR, E_INVALID_OPERATION, NO_MSG);
> +
> +       _fml_dbg("Finishing.");
> +
> +       return E_OK;
> +}
> +
> +uint32_t
> +fm_port_set_rate_limit(t_handle h_fm_port, t_fm_port_rate_limit
> +*p_rate_limit) {
> +       t_device        *p_dev =3D (t_device *)h_fm_port;
> +
> +       _fml_dbg("Calling...");
> +
> +       if (ioctl(p_dev->fd, FM_PORT_IOC_SET_RATE_LIMIT, p_rate_limit))
> +               RETURN_ERROR(MINOR, E_INVALID_OPERATION, NO_MSG);
> +
> +       _fml_dbg("Finishing.");
> +
> +       return E_OK;
> +}
> diff --git a/drivers/net/dpaa/fmlib/fm_port_ext.h
> b/drivers/net/dpaa/fmlib/fm_port_ext.h
> index bb2e00222e..f1cbf37de3 100644
> --- a/drivers/net/dpaa/fmlib/fm_port_ext.h
> +++ b/drivers/net/dpaa/fmlib/fm_port_ext.h
> @@ -274,7 +274,7 @@ typedef struct ioc_fm_port_congestion_groups_t {
>   * @Return     0 on success; error code otherwise.
>   */
>  #define FM_PORT_IOC_SET_RATE_LIMIT \
> -       IOW(FM_IOC_TYPE_BASE, FM_PORT_IOC_NUM(3),
> ioc_fm_port_rate_limit_t)
> +       _IOW(FM_IOC_TYPE_BASE, FM_PORT_IOC_NUM(3),
> + ioc_fm_port_rate_limit_t)
>
>  /*
>   * @Function     fm_port_delete_rate_limit
> diff --git a/drivers/net/dpaa/rte_pmd_dpaa.h b/drivers/net/dpaa/rte_pmd_d=
paa.h
> index ec45633ba2..1a847c4d43 100644
> --- a/drivers/net/dpaa/rte_pmd_dpaa.h
> +++ b/drivers/net/dpaa/rte_pmd_dpaa.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright 2018 NXP
> + * Copyright 2018, 2022, 2024 NXP
>   */
>
>  #ifndef _PMD_DPAA_H_
> @@ -31,4 +31,23 @@
>  int
>  rte_pmd_dpaa_set_tx_loopback(uint16_t port, uint8_t on);
>
> +/**
> + * Set TX rate limit
> + *
> + * @param port_id
> + *    The port identifier of the Ethernet device.
> + * @param burst
> + *    Max burst size(KBytes) of the Ethernet device.
> + *    0 - Disable TX rate limit.
> + * @param rate
> + *    Max rate(Kb/sec) of the Ethernet device.
> + *    0 - Disable TX rate limit.
> + * @return
> + *    0 - if successful.
> + *    <0 - if failed, with proper error code.
> + */
> +int
> +rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
> +                                uint32_t rate);
> +
>  #endif /* _PMD_DPAA_H_ */
> --
> 2.25.1

