Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C36DD73093
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 04:09:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C73040DF6;
	Fri,  3 Apr 2026 06:09:26 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4E8C84028B;
 Fri,  3 Apr 2026 06:09:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf6mBMzoyaVSbxbJoK5ddWyf1Qc6Msxs/NAGsKnoUu+U8BqlivBMOK6nDNcwjSPLEWVAnX6X/8sdC3T2//VNCfAoyWXr0Fc8nGuNKexFsR3bhI8wm2OcUCIuAHsl5D3mNnD+zBuJbjO8yLlyk7wix5lzfn6Tr9NPMfNumQRF+SR/acfex4Gbq7VMJnSYNv6sdYbV9GByr85zlBJ5l7ef7X2QpE3VYCb6dFWKOrkarIufjK/crb9RCw7/adWpU2nxaK3OkAvE+s3iQtEy8ay03zAg6Nl/5NczM2a71BTNp8rN3LFf8ZAuJbyFGqO8wzfwV518CEwAVpsQOpyNXkMQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n5nW2ZqSKzoh7Dz3Y6tZDtnPU6BJcXnzQzV9XLCfNg=;
 b=n/7QmNG0sTH5gHqFEenL8Wxw4nCAQhD1qboxSQ4eBF/aWQcrXAFGyQ/+O8vcd6Kj9bnpy4/t/Hq65bq05/LcTC76lG2aexsENiKi10f8baA2Oo44bF4kzNBnfPiELm9nnRaf1z5CG3vgMvi1B8wDKlc4oOHM/Gqpnn96Oj7qDURFGCodLKlovwKbaeWXHS11KTej9NxO+p5PQ8/SDkM/Ipl8vCqshLjhWMLQlDFI3V1o0zenHTg27CxD1k7+x+uMJe3r3tKLmRa7boujO4xi59omgtRiTcfEPdBZ6xddpR2u1Hjoh8mGoFvILUU8gEKigofzBFqVoli2PyMIpy3xKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n5nW2ZqSKzoh7Dz3Y6tZDtnPU6BJcXnzQzV9XLCfNg=;
 b=X7Gcc0CaZgvUAglZg8+iZfeZLC10zqidhNTIS+aWRkvgeGNFhntY3abRzUlLsz8XwAtajukUHTSB4nmxAszomR5eL1c4noK7m56QmyuO0iPHwJTLEXAiXRyiPbcB6F9YUUtZ+g461Itq4rHEYvVhpzjQU0T7PyY4bpFOPh07mTo=
Received: from CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 3 Apr
 2026 04:09:20 +0000
Received: from CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::9a84:a7c:143:6f7c]) by CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::9a84:a7c:143:6f7c%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 04:09:19 +0000
From: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH] power/amd_pstate: fix frequency matching for continuous
 scaling
Thread-Topic: [PATCH] power/amd_pstate: fix frequency matching for continuous
 scaling
Thread-Index: AQHcvunoZUH5GOhJTkyJYMyqEgeB9bXMwNnQ
Date: Fri, 3 Apr 2026 04:09:18 +0000
Message-ID: <CH3PR12MB82334A10F7761285F7AF2403865EA@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20260328193419.106100-1-stephen@networkplumber.org>
In-Reply-To: <20260328193419.106100-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-03T04:07:08.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8233:EE_|SA1PR12MB7341:EE_
x-ms-office365-filtering-correlation-id: d59e7b8a-e464-4994-943b-08de9136c741
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: TliVp13/2IO/mHJmMKcpl2rKjWbcpulLf8+6/9TK9MxTQgS7hGtoFBzfapOlzkujaROM+0tYTXYntNZ7drs13j48PD1FVbpqrkVAPHCLIOOGsnpc+FgQeQAcTDoWn/K7O7PKEFR2nPxKd7H/aHfY/kJK5URl2hdUkNkqfSJDqgqSYKfr4HDoC9tqHAYcXx70qQCUQx4BoSWGShZm0okHml6ojE3RQ+QvaVETRUVPE+k+qOVQ+e+LeQI/5v9Iy6ezazQ94MS1zGmTYEwH/A1w3xGGmggjX9qBntyjKI6j3uz1+7ApWYyF54hYarJtbG34cCmEvMis+luBvcOq+y9xRY+D4kiOCB4eHgxmXX4CR3+zY5DeSHu65QGbbQTBuRNJdXrVLV+Q3q0R44i4j+PIfp1MlGqFOotDQA1u1VyMbOD4tDqE8Gri/rEy+Y31Gu2BrayIaEg+aCIJY7G/bPU7JxDDLYxC9TiZGGJfCh1BDRNtrImQzP4UUOUK5jLwcfYDgn4+pC/8ptCDL8K5GvKF7tvEUYjlY746XzWN7P8Cujh5pEiSYKh8ddV7Okpdc3htc3ZO/5QmgdUatzucR2xFtCxILBrZSO0KoLH2oIHYhTO2wyctR3IerNLpS+HyAUd+zrU8B7QxHr0/4PDKKBHD6uWxhoS0aCiFd55fosR/6i3/eWCq8Kt7B82acXhGHnpmwYJkK6DaStBIfqL5rTuxAdLCbi+6unzh/+IN2SCbWnhYqA68O2vM7zkVqkSb7S8QEIzC6FI88QRNHPFCr919VO7RRvqUzf6R7mV9++5q9EM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8233.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HNd+267UOwldY5ItkFTWnUd5UfvO1YhX1iAJyrL/rP/6vPxat5z5hdyNNQ+X?=
 =?us-ascii?Q?2D0GScJTh20MKj+ToiSuBkvvYZF5pMd4OUjW9/NVz6nVVF9NFTHpDLA1vGmj?=
 =?us-ascii?Q?HMw0YbLo+ErFj/irZiPIKR/p439Tj9Gsq2gxV2u/Cr1+jc5r7CSNClLrNH3v?=
 =?us-ascii?Q?cVpx8lSxldYGQHHrjV4cSGZBnk/1q1Tpb/CsrO5u9E/ub9GaidGkg/EFED5B?=
 =?us-ascii?Q?+S5YGl10NHLq6eKLe6DAQVCN2iKm6uuNcnbS01k1DzAGYPRne0T2kGsC2Cwr?=
 =?us-ascii?Q?kNGr9qhAzTy5r6OvO5Zsks0XJBpy+anGiGQ/GSRgcTy+5dFNIw97MpIn541b?=
 =?us-ascii?Q?XAMJEmATLOUUBi3uFAAzo/7XhpJCy9IgwgBLoI1e6BdIn0nceeYu8lkejNU9?=
 =?us-ascii?Q?3KhemaoV1fgCIpv2BYS8yD72nURWCz/ZadLLvZf3OqdWZLMU10WJNCrLnIhE?=
 =?us-ascii?Q?nnJU1aKP0KOcg+rj3z85V0aaII/hJzS9YTlw7k97YPDjzF5Tlovs29HdAGIv?=
 =?us-ascii?Q?iX2dDctrosbSUsoHroEibF4YUP1LFEm1s7e/dqzKE0SHn3+DcTViOu6F32ip?=
 =?us-ascii?Q?xH5H0/MNUSP2B+IgBI8y2J8qu10hAxMyJaGysScbG5yF09Owek1bZb21pdbR?=
 =?us-ascii?Q?6P9FAZPIKFyvR32arnPDINJ9Q95zjPg+BbxeL+Entb1Gc9GWB14NO0vk2JNz?=
 =?us-ascii?Q?mGZHvqJkoOV83k91JrxL2By5XtHmL6zV6GvrFhNHFH9Xiea3i+N3JuaeFEBN?=
 =?us-ascii?Q?jDBykmJMl/0F4KRUBhTBmks0sc/mRHAzkChzngSSfuRe4qjsAklh0P1B5VRr?=
 =?us-ascii?Q?h7mt0/PbDXXdVOjlYP7r61ZCN7edIuryAQ5Bol0rnqp7FMfIT8khn8ssiidK?=
 =?us-ascii?Q?6n1bN9QAPW8YadbdSV1un9EZkeqAM1aFnNEBMIz3M3glKg7UaqcBpPr6Nn8U?=
 =?us-ascii?Q?bdN5Yv+EH3FZSqVmQRByF3s5h1iSJ65b2Jy3CluHM8fYCQA0Oa4lmT1Ykgsp?=
 =?us-ascii?Q?2+L7ACzigFOtSgIJANnOQow+UZJvARFwx5+ttPmf+1KiJEw3XwMEkPoey8N5?=
 =?us-ascii?Q?mHBeRO6Sx66I9iCpNk5Vt39sUxJVI9GsRY3R19eQYPnzXSS4vcTKeqrQnwWJ?=
 =?us-ascii?Q?ObRQfXKmLCBObwhbqZ2DRSgMCqb85IP62E9NjT33MJTDsH2C9kv6orTKSMRU?=
 =?us-ascii?Q?6U2CK48/Vy1Q2BldwkYeTFMqJaWsuDqevz9nqppt8sAnAd7uRmz3KiznWT11?=
 =?us-ascii?Q?q8j0ijQe+6p8vOg+9PliIvBsGXRpt8SIYZjToNBzFudP//aTSDPt/OUYeEmT?=
 =?us-ascii?Q?FWZ6nrM6yjU+Ygq7YMmectQS3mYzL5H1pugHh1Fgb2z3nGPakjeWb797uIDg?=
 =?us-ascii?Q?SuhHpa0sz9beKVlubzBb9lvdzE2s/tDAbFR28XSASaKDH2Llh7JuiOS1FWt6?=
 =?us-ascii?Q?7w1yFH4R2nQX7sSqatM4j0CsQ/c1xc3le3Sq0zkLFT0n+zplo2AuhuDf2Qnq?=
 =?us-ascii?Q?S89I0F0c9ZLyITlXTyWbPYk3Q+6fuVOjvsLagW131QowKJQItwygj+EkQyO0?=
 =?us-ascii?Q?+tjqGKwGlXQ8Xz5+B/SKUM/AXZrMaW7PtToTvzrbgfPdMH5RwbMrbOD2W/Sn?=
 =?us-ascii?Q?PzbIQuvzpP/WR+rzJpKD6aluWgShtzCRrDlHRGflANBThlWT+pkFA9q6CpHL?=
 =?us-ascii?Q?unAgNOPft5p/umjeeXXA7QW9gOBh29V7aDk2lWfH1dotbAAx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8233.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59e7b8a-e464-4994-943b-08de9136c741
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 04:09:19.0287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vK7ltiGuBwoLRywPwah5mlv5427zDzAcvioHVFMP4Jp2Ry17Vvwzl315YdhY44qPcDxKPa/Hqxos8jpzbNJ2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday, March 29, 2026 1:04 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org;
> Anatoly Burakov <anatoly.burakov@intel.com>; Tummala, Sivaprasad
> <Sivaprasad.Tummala@amd.com>
> Subject: [PATCH] power/amd_pstate: fix frequency matching for continuous =
scaling
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> The power_init_for_setting_freq() function fails on systems using the amd=
-pstate-
> epp driver because the current CPU frequency read from scaling_setspeed d=
oes
> not exactly match any of the synthesized frequency buckets. Unlike acpi_c=
pufreq
> which provides a discrete list of frequencies, amd-pstate operates with c=
ontinuously
> variable frequencies, so an exact match will rarely succeed.
>
> For example, on a Ryzen 9 7945HX the sysfs file reports 2797172 which rou=
nds to
> 2797000, but this value does not appear in the generated frequency table.
>
> Replace the exact match lookup with a nearest-frequency search.
>
> Also fix several issues in the same function:
>  - strtoul() was called with NULL endptr, making parse failures
>    undetectable
>  - errno was not checked, so stale errors could cause false positives
>  - freq was declared as uint32_t, truncating the unsigned long
>    return value of strtoul() on LP64 platforms
>  - no error was logged when frequency matching failed
>
> Bugzilla ID: 1915
> Fixes: 1ed04d33cf19 ("power: support amd-pstate cpufreq driver")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/power/amd_pstate/amd_pstate_cpufreq.c | 56 ++++++++++++++-----
>  1 file changed, 41 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
> b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
> index 95495bff7d..14625ffd73 100644
> --- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
> +++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <stdlib.h>
> +#include <errno.h>
>
>  #include <rte_memcpy.h>
>  #include <rte_stdatomic.h>
> @@ -291,15 +292,21 @@ power_get_available_freqs(struct
> amd_pstate_power_info *pi)
>         return ret;
>  }
>
> -/**
> - * It is to fopen the sys file for the future setting the lcore frequenc=
y.
> - */
> +static inline unsigned long
> +abs_diff(unsigned long a, unsigned long b) {
> +       return (a > b) ? a - b : b - a;
> +}
> +
>  static int
>  power_init_for_setting_freq(struct amd_pstate_power_info *pi)  {
> -       FILE *f =3D NULL;
> +       FILE *f;
>         char buf[BUFSIZ];
> -       uint32_t i, freq;
> +       char *endptr;
> +       unsigned long freq, freq_conv;
> +       unsigned long best_diff, diff;
> +       uint32_t i, best_idx;
>         int ret;
>
>         open_core_sysfs_file(&f, "rw+", POWER_SYSFILE_SETSPEED, pi-
> >lcore_id); @@ -308,7 +315,6 @@ power_init_for_setting_freq(struct
> amd_pstate_power_info *pi)
>                                 POWER_SYSFILE_SETSPEED);
>                 goto err;
>         }
> -
>         ret =3D read_core_sysfs_s(f, buf, sizeof(buf));
>         if (ret < 0) {
>                 POWER_LOG(ERR, "Failed to read %s", @@ -316,25 +322,45 @@
> power_init_for_setting_freq(struct amd_pstate_power_info *pi)
>                 goto err;
>         }
>
> -       freq =3D strtoul(buf, NULL, POWER_CONVERT_TO_DECIMAL);
> +       errno =3D 0;
> +       freq =3D strtoul(buf, &endptr, POWER_CONVERT_TO_DECIMAL);
> +       if (errno !=3D 0 || endptr =3D=3D buf || freq =3D=3D 0) {
> +               POWER_LOG(ERR, "Failed to parse frequency '%s' for lcore =
%u",
> +                               buf, pi->lcore_id);
> +               goto err;
> +       }
>
>         /* convert the frequency to nearest 1000 value
>          * Ex: if freq=3D1396789 then freq_conv=3D1397000
>          * Ex: if freq=3D800030 then freq_conv=3D800000
>          */
> -       unsigned int freq_conv =3D 0;
> -       freq_conv =3D (freq + FREQ_ROUNDING_DELTA)
> -                               / ROUND_FREQ_TO_N_1000;
> +       freq_conv =3D (freq + FREQ_ROUNDING_DELTA) /
> ROUND_FREQ_TO_N_1000;
>         freq_conv =3D freq_conv * ROUND_FREQ_TO_N_1000;
>
> -       for (i =3D 0; i < pi->nb_freqs; i++) {
> -               if (freq_conv =3D=3D pi->freqs[i]) {
> -                       pi->curr_idx =3D i;
> -                       pi->f =3D f;
> -                       return 0;
> +       /* Find the nearest frequency in the table.
> +        * With amd-pstate the CPU runs at continuously variable
> +        * frequencies so the current frequency will not exactly
> +        * match one of the synthesized frequency buckets.
> +        */
> +       best_idx =3D 0;
> +       best_diff =3D abs_diff(freq_conv, pi->freqs[0]);
> +
> +       for (i =3D 1; i < pi->nb_freqs; i++) {
> +               diff =3D abs_diff(freq_conv, pi->freqs[i]);
> +               if (diff < best_diff) {
> +                       best_diff =3D diff;
> +                       best_idx =3D i;
>                 }
>         }
>
> +       POWER_DEBUG_LOG("Freq %lu rounded to %lu matched bucket [%u] =3D
> %u "
> +                       "for lcore %u", freq, freq_conv, best_idx,
> +                       pi->freqs[best_idx], pi->lcore_id);
> +
> +       pi->curr_idx =3D best_idx;
> +       pi->f =3D f;
> +       return 0;
> +
>  err:
>         if (f !=3D NULL)
>                 fclose(f);
> --
> 2.53.0
LGTM
Acked-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
